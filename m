Return-Path: <netdev+bounces-145090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBB89C9574
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01A02834DE
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFBA1B2180;
	Thu, 14 Nov 2024 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ze+96R6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F99E1ADFEA
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624876; cv=none; b=QELIXBdUrtEEuPkzGU+F8W02CLdFt5CXpbM7jjCFOcMojBCI8w/RlVrC7mGUhTz5h876BtfnMp/tv3Ev0BMl1YL/04zM78mxcrjIhlvMrRnS7Qw9ooKOkwqFFrjGKgSZCfMkgQJmbXbWg5imBfTtlSLJqQk2QZjF1e9SW6le5H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624876; c=relaxed/simple;
	bh=xjiVWDWIYCD0KdHaLBnPpoGwUhftZvEE0oMF7YQKNac=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpdoLkiUiSrBrW07xnsZjA3ZI3tLuGRwAAW1JRrSLQPWRy7JvaCAEYaDe73SxPZc56fvZDEk7K7GxNh6wg5div60eHPXcB6tOj16EKiEQUONS7uG6erTOISYdmNFszAf1EZOJ0JbKExqhYMpvy4zLznr+JTsL5FNRBkt5kSp20M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ze+96R6D; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f12ba78072so949981a12.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 14:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731624874; x=1732229674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4uJMk5Wun363unIpf6v1rom+etNspxI2fD/8K0qZ77o=;
        b=Ze+96R6DoQE03hd4Mez9FrGNNWWMev0i3HBibt+ltbbtFwL4zNXqbGTv+oRQWLEc2j
         W7Vnfq777Nc7apgYLelJ1QF3wbvP5Rt0zccs91w7/zUOTa0dC7wsGdFtLv1LCznjzIni
         ysdcb93CtknX8m2qmah/OpGq/rRnGbDunNtLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731624874; x=1732229674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uJMk5Wun363unIpf6v1rom+etNspxI2fD/8K0qZ77o=;
        b=qWlmADKEOgGb/Tm9B3D57JihNoYiDgvGSMNy9SAzYeFS6PKhlwsZHKx/6lo7uQ7mU9
         ZxjkwWtQyBYDtgnDibizZMEoPyoBoHdq3Ysb1dut7aRo4VEYaMb9dONJjRWXK4ZOg078
         9gwh3xMi5Fs8ChUuW1JhaZ0woXx74cv8Ag02R5gMFUNksHk1vixc4E8JDuro3nsL02S8
         hqrTUJEoxHqHEWD4AejKTIWvsC/43/BYQe03FNxVwURDsfgeXpafGvDa09WXhCARFmCK
         r75hWQTUf3drgkCiSJMQRAJaKbGUdTNaIMoi5bv5wonguyPn17K238bc0Dad+Jb273Od
         6jIw==
X-Forwarded-Encrypted: i=1; AJvYcCUaQ0ceLrrP82iB6qYIStvvW3z5uHmvRi70h8Wt4AZPcxCxOPS/LFVnB3b7V8/LmTjvT6sa09k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcIIVja6Rp2Nh1WWVaP5/6O29jZuIau20/TPeOmj8cAv+X8Fh
	DNCjY+N49FuS5XXYKAa1LnucMCyMBJ85I6yrX99t9xA1kbvMywq6AttVqFcbNw==
X-Google-Smtp-Source: AGHT+IHT2LCi/rnRmjRYLUW9JFT3jxyddYtF/5069Xj6y31An++H/S1T/eAP4iK06p2WBQIf31TVFw==
X-Received: by 2002:a05:6a20:2449:b0:1d8:a29b:8f6f with SMTP id adf61e73a8af0-1dc90b1cc5emr536253637.16.1731624873721;
        Thu, 14 Nov 2024 14:54:33 -0800 (PST)
Received: from JRM7P7Q02P ([136.56.190.61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c62ccfsm127603a12.43.2024.11.14.14.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:54:33 -0800 (PST)
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
X-Google-Original-From: Andy Gospodarek <gospo@broadcom.com>
Date: Thu, 14 Nov 2024 17:54:26 -0500
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, almasrymina@google.com,
	donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
	andrew+netdev@lunn.ch, hawk@kernel.org, ilias.apalodimas@linaro.org,
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	dw@davidwei.uk, sdf@fomichev.me, asml.silence@gmail.com,
	brett.creeley@amd.com, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com, danieller@nvidia.com,
	hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com,
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org,
	jdamato@fastly.com, aleksander.lobakin@intel.com,
	kaiyuanz@google.com, willemb@google.com, daniel.zahka@gmail.com
Subject: Re: [PATCH net-next v5 3/7] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <ZzZ_olqQ_vUE1l_K@JRM7P7Q02P>
References: <20241113173222.372128-1-ap420073@gmail.com>
 <20241113173222.372128-4-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113173222.372128-4-ap420073@gmail.com>

On Wed, Nov 13, 2024 at 05:32:17PM +0000, Taehee Yoo wrote:
> NICs that uses bnxt_en driver supports tcp-data-split feature by the
> name of HDS(header-data-split).
> But there is no implementation for the HDS to enable by ethtool.
> Only getting the current HDS status is implemented and The HDS is just
> automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
> The hds_threshold follows rx-copybreak value. and it was unchangeable.
> 
> This implements `ethtool -G <interface name> tcp-data-split <value>`
> command option.
> The value can be <on> and <auto>.
> The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
> automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
> automatically disabled.
> 
> HDS feature relies on the aggregation ring.
> So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
> This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.
> 
> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Tested-by: Andy Gospodarek <gospo@broadcom.com>

> ---
> 
> v5:
>  - Do not set HDS if XDP is attached.
>  - Enable tcp-data-split only when tcp_data_split_mod is true.
> 
> v4:
>  - Do not support disable tcp-data-split.
>  - Add Test tag from Stanislav.
> 
> v3:
>  - No changes.
> 
> v2:
>  - Do not set hds_threshold to 0.
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +++--
>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 +++++++++++++++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index d521b8918c02..608bcca71676 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -4474,7 +4474,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
>  	bp->rx_agg_ring_size = 0;
>  	bp->rx_agg_nr_pages = 0;
>  
> -	if (bp->flags & BNXT_FLAG_TPA)
> +	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
>  		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
>  
>  	bp->flags &= ~BNXT_FLAG_JUMBO;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index d1eef880eec5..3a7d2f3ebb2a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2202,8 +2202,6 @@ struct bnxt {
>  	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
>  	#define BNXT_FLAG_JUMBO		0x10
>  	#define BNXT_FLAG_STRIP_VLAN	0x20
> -	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
> -					 BNXT_FLAG_LRO)
>  	#define BNXT_FLAG_RFS		0x100
>  	#define BNXT_FLAG_SHARED_RINGS	0x200
>  	#define BNXT_FLAG_PORT_STATS	0x400
> @@ -2224,6 +2222,9 @@ struct bnxt {
>  	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
>  	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
>  	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
> +	#define BNXT_FLAG_HDS		0x20000000
> +	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
> +					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
>  
>  	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
>  					    BNXT_FLAG_RFS |		\
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index adf30d1f738f..b0054eef389b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -840,6 +840,8 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  			      struct kernel_ethtool_ringparam *kernel_ering,
>  			      struct netlink_ext_ack *extack)
>  {
> +	u8 tcp_data_split_mod = kernel_ering->tcp_data_split_mod;
> +	u8 tcp_data_split = kernel_ering->tcp_data_split;
>  	struct bnxt *bp = netdev_priv(dev);
>  
>  	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
> @@ -847,9 +849,25 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
>  		return -EINVAL;
>  
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> +	    tcp_data_split_mod)
> +		return -EOPNOTSUPP;
> +
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    tcp_data_split_mod && BNXT_RX_PAGE_MODE(bp)) {
> +		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (netif_running(dev))
>  		bnxt_close_nic(bp, false, false);
>  
> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> +	    tcp_data_split_mod)
> +		bp->flags |= BNXT_FLAG_HDS;
> +	else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
> +		bp->flags &= ~BNXT_FLAG_HDS;
> +
>  	bp->rx_ring_size = ering->rx_pending;
>  	bp->tx_ring_size = ering->tx_pending;
>  	bnxt_set_ring_params(bp);
> @@ -5345,6 +5363,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
>  				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
>  				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
>  				     ETHTOOL_COALESCE_USE_CQE,
> +	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
>  	.get_link_ksettings	= bnxt_get_link_ksettings,
>  	.set_link_ksettings	= bnxt_set_link_ksettings,
>  	.get_fec_stats		= bnxt_get_fec_stats,
> -- 
> 2.34.1
> 

