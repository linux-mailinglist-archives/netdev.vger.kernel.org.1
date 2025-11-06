Return-Path: <netdev+bounces-236118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF4C38A76
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 02:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506303B3956
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 01:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5220C202979;
	Thu,  6 Nov 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L64zd5kh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DE1DDC1D;
	Thu,  6 Nov 2025 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390907; cv=none; b=EKA+tgfwkoyOeODBSJ6JCW3u82RDsObZelCs5nIvf6oPfPNv3tvj4yh1O1qovi8EARn0oLokYktnFhZNbPqV+4NjZ46a5AMujFVSSpq4U90H4Kiz7+engMCdDA+VIS8eqxlz4Mi0ySf4XQq39oeLw9n8tSd+VCpb/z61moHrgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390907; c=relaxed/simple;
	bh=BzaUGNd0RbQfRICzb5BLazyLO6lbo5kIyph1QuSsSKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p3IG58JgfkIJ6HqP1Yweg39oEtzaLuhpcFUidVE98H+3fE15Mgx6ENf+SwGOsyi4DlKmeH7430e5thRBGuxv6qr81NJcF2TLRbaiKpjuuaghTdUdWU2DCojf4ITAzxvCeg1dBincRGG/xiWJ717cAQnWfpXjX0b1lzA19h9y8yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L64zd5kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDAEC116D0;
	Thu,  6 Nov 2025 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762390906;
	bh=BzaUGNd0RbQfRICzb5BLazyLO6lbo5kIyph1QuSsSKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L64zd5khlFi++wULtreDv4LgQWkCVSKNN9LYdRTnNd2bGDaw+vQkzgdM7k4dFg5Qz
	 BgHRaSkFOw4IAL1n8SdLYtROGsNngIPPxFd0rURTupinYfZDNk7enQw5b80030bme+
	 8i0GfEypzZsphe1bmdQVEiCAY4/cE3cvSNCcHcFzyWs0DG/UheKkk+fsCMHGOcr3Rm
	 UG5bB7Br0+zmsK307tIc2FPTFJ56G0j0EbJ8hYiU9ZQ7JdAbgGQ7oP9tlLJjtS12v+
	 l/ztkcACBlkRy6eVNjB+K0BNQgb4VXRH57XhWP/oQT4ATErNowWO2LDrbt4O6GAXNl
	 TGkgoiwtkR7Rw==
Date: Wed, 5 Nov 2025 17:01:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: Breno Leitao <leitao@debian.org>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next] tg3: extract GRXRINGS from .get_rxnfc
Message-ID: <20251105170145.461c8f11@kernel.org>
In-Reply-To: <CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
References: <20251105-grxrings_v1-v1-1-54c2caafa1fd@debian.org>
	<CACKFLim7ruspmqvjr6bNRq5Z_XXVk3vVaLZOons7kMCzsEG23A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Nov 2025 11:05:34 -0800 Michael Chan wrote:
> The existing code to use num_online_cpus() is actually not correct.
> This is more correct:
> 
> return min(netif_get_num_default_rss_queues(), tp->rxq_max);
> 
> I think when netif_get_num_default_rss_queues() was used to replace
> num_online_cpus(), tg3_get_rxnfc() was not properly converted.

All true, but perhaps we want to do that change as a follow up?
Someone may show up later insisting that fewer queues cases 
a regression for their workload..

The sensitivity to default queue count was why we didn't change most
of the drivers when netif_get_num_default_rss_queues() got reworked
to a more sane default than 8.

