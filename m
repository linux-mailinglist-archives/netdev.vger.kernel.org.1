Return-Path: <netdev+bounces-157139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1864FA08FDD
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 12:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B46161BBB
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 11:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8420C20B806;
	Fri, 10 Jan 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6gQ2k1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60F20766F
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510370; cv=none; b=sGbhoRAi23b+lO46REFRIQIAL4K8v5EFliD6Gb6yuWJhpXcqfA7uw576Ng2AIi9u+8nQrVBGJiM1bO7SbDZxF6+9X1BZor8+lvZBCuFxe5zKeAi9IR2oe9XoCSypz7J+rd83y9jgx5hvmoB//XXj4UprVyGCDGKDiV6N4Pf+Fcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510370; c=relaxed/simple;
	bh=oIOGs5oxHSUKLXCpkdy+sMTpAoLL5Ee+yOgw2feXKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M25ERYqMOdbxvkXBbBirAGxF5k00t3pxGUmCRxxzj9TK6XVTOMj0KK/7ojkq8BSaEZxHDmU8QsRM3j7dmrSbZQyGr3hh/upd/4nq0Mtc2piJdZxiO/E1QHkKVd2p4tUC1jyJAR+HZdJF7SAcLRB2HbvDAH0Ehv7FiRvVJM1Hk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6gQ2k1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73F9C4CED6;
	Fri, 10 Jan 2025 11:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736510369;
	bh=oIOGs5oxHSUKLXCpkdy+sMTpAoLL5Ee+yOgw2feXKVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6gQ2k1WwhAFLJusZlJ5Oq+2H4i3Tx07kJ2XknzV1uSztFv+1iATkKUXwtZ5GWY4m
	 2EnvWxTh1E4HbxIv63SOnbgCquKcy548r6fTd+Dbc7ykwb4bmz2bb2pD7RmCfgumtQ
	 jOK7FeKrx1E/vDKyoyfuXlOp+cKaYD8EuHWoR8a1xy6zJQgfBALFSKqzREHhOuyZi0
	 Krw6n0soX70J2R8YlithM1QDM+CIPaqL+SQPY9Vgj1ML0PfzN/4rwckVL909z+pcHp
	 aTnVzSl8quG8sJht5R6u5hMvwKtzdxBY7kE0ba/zJVJ9XPU9nKUrVW1QcqmfQJFTUV
	 f3VKjrrZnDEvg==
Date: Fri, 10 Jan 2025 11:59:24 +0000
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net, michael.chan@broadcom.com,
	tariqt@nvidia.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, jdamato@fastly.com, shayd@nvidia.com,
	akpm@linux-foundation.org, shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v4 1/6] net: move ARFS rmap management to core
Message-ID: <20250110115924.GC7706@kernel.org>
References: <20250109233107.17519-1-ahmed.zaki@intel.com>
 <20250109233107.17519-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109233107.17519-2-ahmed.zaki@intel.com>

On Thu, Jan 09, 2025 at 04:31:02PM -0700, Ahmed Zaki wrote:
> Add a new netdev flag "rx_cpu_rmap_auto". Drivers supporting ARFS should
> set the flag via netif_enable_cpu_rmap() and core will allocate and manage
> the ARFS rmap. Freeing the rmap is also done by core when the netdev is
> freed.
> 
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

...

> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1812564b5204..acf20191e114 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -2398,6 +2398,9 @@ struct net_device {
>  	struct lock_class_key	*qdisc_tx_busylock;
>  	bool			proto_down;
>  	bool			threaded;
> +#ifdef CONFIG_RFS_ACCEL
> +	bool			rx_cpu_rmap_auto;
> +#endif

nit: rx_cpu_rmap_auto should also be added to the Kernel doc for
     struct net_device.

>  
>  	/* priv_flags_slow, ungrouped to save space */
>  	unsigned long		see_all_hwtstamp_requests:1;

...

