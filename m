Return-Path: <netdev+bounces-179290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B214A7BB48
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF17189DF75
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E5A1C861B;
	Fri,  4 Apr 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ozr5oUbf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B2F1BEF87;
	Fri,  4 Apr 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743764386; cv=none; b=vEHMV9dadXDh5Bbb1H4rGYBa3Fym/44ywQE/nzI6w5j6r0F7PXcVgy4eC8str1AoM7G88sNwZ673aZ4nnqEajLvs0Oa72VpIs+dQhq88UwDGdtkaJC6vqZ7EGAZ4Fxc6mTE4IaF1HTddHc67KGiXXdG46r2YeT5axv4BvogPHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743764386; c=relaxed/simple;
	bh=yhYS4eZ5vDTG+ZOahz1UCsM6rGMobvDFfIV2X9EDPdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSh6g6IxjHAi9cpGCWR5s0FvvbjXnxxm3ohFyDO9zJUDIqCEoKDDEz4vT9GWsoXcYDTIPJU58SDiBVjobOks7EDI+cLawfrXBdlwMi6hRh5msVVfj4n3JIrxkuqBRgAdOQc3sXSoKLFoxekpGK9l+v20elD14us8wcOsjYUMtUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ozr5oUbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB8C4CEE5;
	Fri,  4 Apr 2025 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743764385;
	bh=yhYS4eZ5vDTG+ZOahz1UCsM6rGMobvDFfIV2X9EDPdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ozr5oUbfm2+qbAZ5JOojv/oXOneP7zNUyueLA8jxeDUtM8VEu/1L7eF5m6qCtfTYc
	 SfBuB0H7No+Lmj6bqDfZkI1syWhQAzBrZLBGgXb5C58YUdtb9t/DE6hDSIBssQICzh
	 N6WRX+zPWXjXsPbVQ5SeBc2dZiyaA2kBZ4ofhA9czAODErXFrEQAqztHne+AOF4QFp
	 tgsG/uzvg4FuF564jrSXx1FnL5VSXLDj0KRNGgFl/1q1tkWrtGhN6aKgwWw9eWWjfL
	 dvUE7V1265dhGl8gfTynJUjTrY0LBohNtP2Oolk5MoOWrtcyRUjrbJNOSz7zHI34Cf
	 6+mN/86njiCJw==
Date: Fri, 4 Apr 2025 11:59:40 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/7] net: hibmcge: fix incorrect pause frame
 statistics issue
Message-ID: <20250404105940.GE214849@horms.kernel.org>
References: <20250403135311.545633-1-shaojijie@huawei.com>
 <20250403135311.545633-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403135311.545633-2-shaojijie@huawei.com>

On Thu, Apr 03, 2025 at 09:53:05PM +0800, Jijie Shao wrote:
> The driver supports pause frames,
> but does not pass pause frames based on rx pause enable configuration,
> resulting in incorrect pause frame statistics.
> 
> like this:
> mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
> 	-p 64 -c 100
> 
> ethtool -S enp132s0f2 | grep -v ": 0"
> NIC statistics:
>      rx_octets_total_filt_cnt: 6800
>      rx_filt_pkt_cnt: 100
> 
> The rx pause frames are filtered by the MAC hardware.
> 
> This patch configures pass pause frames based on the
> rx puase enable status to ensure that
> rx pause frames are not filtered.
> 
> mz eno3 '01 80 c2 00 00 01 00 18 2d 04 00 9c 88 08 00 01 ff ff' \
>         -p 64 -c 100
> 
> ethtool --include-statistics -a enp132s0f2
> Pause parameters for enp132s0f2:
> Autonegotiate:	on
> RX:		on
> TX:		on
> RX negotiated: on
> TX negotiated: on
> Statistics:
>   tx_pause_frames: 0
>   rx_pause_frames: 100
> 
> Fixes: 3a03763f3876 ("net: hibmcge: Add pauseparam supported in this module")
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
> ChangeLog:
> v1 -> v2:
>   - Add more details in commit log, suggested by Simon Horman.
>   v1: https://lore.kernel.org/all/20250402133905.895421-1-shaojijie@huawei.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


