Return-Path: <netdev+bounces-75384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60272869ABE
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9FB28822A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED71468F1;
	Tue, 27 Feb 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnEMS6Dv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B53D14601E;
	Tue, 27 Feb 2024 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048586; cv=none; b=cUSfodLWPLhQZJEHTLDuDa4bKyZVnKw3dY3ysBEvJimlLV0rtlXe9ChbyXIU/blse+SbYVsXoc9TKJ8ermRPexTY5//waD4RXrIU7lSrm3cKcBnf8MrWDVt8IEj4zzv1gGk6woqNI6Bg4vVy0ItLI74YY9DOee0ywVuwUKd4C5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048586; c=relaxed/simple;
	bh=K6qxV/PqF4vaZH3ha+bkO8pZVnHtRWeU645o2MFq188=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDxVOiGE4PzBRLunaBSWBjhUhy4PRX7JkyS5BtSzBN3Hwk3YCkDIatbB9O5dXnxhH8GL63Jrl1eeR9eZ5VMAtV3is0c545QxPQi03KlIlYE3MjyBQOkhTOYylx3UvbnRs/9PsNtNdvVEPr2AYJHefmUiDK/MBVFfz6qMUiR+wS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnEMS6Dv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3D7C433F1;
	Tue, 27 Feb 2024 15:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709048586;
	bh=K6qxV/PqF4vaZH3ha+bkO8pZVnHtRWeU645o2MFq188=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YnEMS6DvNt85awweZGtd5cTs/S8vxk+cQKuo7Ylsm5NM3rkjynht1MeIW6Bx3d7er
	 quNVjr4ulzBpp6NmBsQOqZSoVv9oWN+Tqj4tVVuFqhZggJZqzPefwToeJ6b446oW5g
	 MtKa8NfDQ6Sq9agdbiVYg8p2gHnosC/odMPKFYW1EeBQiPWcxBjsh4CY3a1Ap2G6jH
	 oEohpIsQq4BRdn3kbnwxIW8quzAmJOyH4UvbtDB0n/sSBgYYJ3PwOh96hbReLSuYMn
	 GqSrGYiFjbM1jvd5/SkRLuVS/m+rSdmesSgoVdwmsfFeh7++l02PmqL52jJSGu2/ZO
	 DfMtGrB1ZUY4g==
Date: Tue, 27 Feb 2024 15:43:00 +0000
From: Simon Horman <horms@kernel.org>
To: Karthik Sundaravel <ksundara@redhat.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de, jiri@resnulli.us,
	michal.swiatkowski@linux.intel.com, rjarry@redhat.com,
	aharivel@redhat.com, vchundur@redhat.com, cfontain@redhat.com
Subject: Re: [PATCH v4] ice: Add get/set hw address for VFs using devlink
 commands
Message-ID: <20240227154300.GA277116@kernel.org>
References: <20240224124406.11369-1-ksundara@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224124406.11369-1-ksundara@redhat.com>

On Sat, Feb 24, 2024 at 06:14:06PM +0530, Karthik Sundaravel wrote:
> Changing the MAC address of the VFs are not available
> via devlink. Add the function handlers to set and get
> the HW address for the VFs.
> 
> Signed-off-by: Karthik Sundaravel <ksundara@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


