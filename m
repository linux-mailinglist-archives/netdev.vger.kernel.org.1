Return-Path: <netdev+bounces-202377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3FDAEDA5E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3EB4162A2F
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 10:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63923E358;
	Mon, 30 Jun 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSQo28AG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C711FBCAA
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751281112; cv=none; b=qRTfDyD/SD0A77Vm4U31Pc03pZxZOkhGYHbehuiMTyXxxMgi8C0aOCmzc4+FHc2uxRBAF7ulk2SwWJch/1VBMmziExI5wy7nfBqWAZt+4WaWGteymPnSjUvnvDNSetLxbA2z54zt3JPc/rXL30gR2qYpjFLy2AwtdPnYSvdy8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751281112; c=relaxed/simple;
	bh=zgsDUjpr8Kr3qyKRd0Q8bT31LR5pMsMeqLjL7qg91m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvpgoWu1s4T9Ji7VYtIz14w8RSRw8sSwrNlZnCiIU8/mbFkMSFYpQZ8bC5oZG0R+r1FB2HjUJMEG75ryT3gNQdR+CmTHIv9aJxKQMuDRK+CsZNHIsO3yIF9b8ZLk1LHzQLfGBJnpSOS5tbHz6Yi+JZ/wyLRihFb3/OeuraEoKrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSQo28AG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500C7C4CEE3;
	Mon, 30 Jun 2025 10:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751281111;
	bh=zgsDUjpr8Kr3qyKRd0Q8bT31LR5pMsMeqLjL7qg91m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSQo28AGTehDj3ObjKVUbPx6HlTEoAeNxoBLIGbNlqoWbaGiReGSp+XGUexONoZn+
	 /ygp6fIW7jYIPTZvn8da7CM/ah9ReIrJTgRoo2GMV8QyrAnQU3ecF5DUoSK8e21Yyx
	 5FBaJmfJFCclw3aFQeceXByyAQ4Y+I90otarm5w8BPd39AS1yfKtLM3Rw9KwEzPQXN
	 I6qSbXcL0ahBt3mQZNCPIJmd1dF3ucPf6kCcx0S3VMt74he5foaEUtCJ3pf8hcTII2
	 4sPQI+aieVP0KTrYkSYLAc8OPsvyX1txDyCSpUbUUKOYV/HEeVnBEnR6hiPcdOCh0C
	 ftk9iUvi7wRSA==
Date: Mon, 30 Jun 2025 11:58:26 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: johndale@cisco.com, neescoba@cisco.com, benve@cisco.com,
	satishkh@cisco.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] enic: fix incorrect MTU comparison in
 enic_change_mtu()
Message-ID: <20250630105826.GC41770@horms.kernel.org>
References: <20250628145612.476096-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628145612.476096-1-alok.a.tiwari@oracle.com>

On Sat, Jun 28, 2025 at 07:56:05AM -0700, Alok Tiwari wrote:
> The comparison in enic_change_mtu() incorrectly used the current
> netdev->mtu instead of the new new_mtu value when warning about
> an MTU exceeding the port MTU. This could suppress valid warnings
> or issue incorrect ones.
> 
> Fix the condition and log to properly reflect the new_mtu.
> 
> Fixes: ab123fe071c9 ("enic: handle mtu change for vf properly")
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Reviewed-by: Simon Horman <horms@kernel.org>


