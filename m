Return-Path: <netdev+bounces-120235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1808A958A36
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33EB288D52
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF4D192B6D;
	Tue, 20 Aug 2024 14:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3mVYPcn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF61922E9;
	Tue, 20 Aug 2024 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165640; cv=none; b=NMMg/PKG890pcvi9Mqm/zGI28dNSuXPjAGYW/OgVXOb9wO8xu+IKgd114KRi571pxzC8zbUyGhHuEIagvs+gemo+FSk6h/S/bjgJZkK6s5p/d0OqrMmmPIASltCS1K0aINnoG4QVBVxqIcDJC6yjMMizHIsjVlzrNj+ZBvL31mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165640; c=relaxed/simple;
	bh=PDqL5T42bwr0/utcT1Ml7l0u88ldWUK4M8dTnabKW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcLIorNbfWUbuwOFpn9V2jtb0PJ0eeXIep6vxQBTWJURxuTeJtVFlw/sPCXpJzHtO6uHXuQWB2Fs8eaiNS1iGLaQMR6qRrRFPgcF6O0rwhh9Pelizd/9UW5FS5eM9Kr8+fkA0WHszx9BqvFaGZqTfyy60EvfnLc4rbrSNC4/aVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3mVYPcn; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c0f35f2so4919391fa.1;
        Tue, 20 Aug 2024 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724165637; x=1724770437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5lPcHvpv1sRtwbunJR9ClPnsil30TdbQ3ASxEknkIMw=;
        b=A3mVYPcn4IBnh7xXu0vbUitG1qQPlk8KUS2ndLPWwOORxLWU01f/E6zFkff6p+8cuI
         InMa5P+nR2/CI7foAyuqNxsK/GbWM5Bn2W2CkiB4/FLu0VLAesJ9E1oXx9BULItuUB3I
         0fCOu3J0ITpscpGPGnT37R48TP48bW8vMesohFEljSyhioONfMCkTEhpFKPMHPz+NLwB
         lB70scckd8erVTr30oBzjQEvxCxbf/nMlviGOIxDIJ/iQKavX4lqYj1Rz4AkzC/cV/+x
         VW7uyH//crYDdlX3svfFTZLI181od2ZRn5NH47usYyU8CEPuHw6QuX0JXZ/kaoutDvrT
         U2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724165637; x=1724770437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lPcHvpv1sRtwbunJR9ClPnsil30TdbQ3ASxEknkIMw=;
        b=Db62flApackkXNwwV3J4lsADfF0zHxs3lUBgDHjL9xVMpoFqYtDz4kO7rFxWTJ0g8K
         GWGRFO0utdqOSUKkm9lKpPxUoSEJwgAs0xrj2nqjj7Ye43Hzo+TB1AdACUlMXqLYHxGp
         qNzy6RtjYv6OBCj1/K2tAJ/bNbQFlvXimYOSacerG9mZbE3ohNhslfzqyHp4hxvIUZR+
         xWFOIUWSNPJ8ZvGwEqeqdtOTK8qjPyMdRLwnIueiX8bz4lD8gBnl2i2rkqV3vfgUMJoz
         5UvufFM7sQPgWh7z0/w2APHEh+JLQSqslXbLk+eBy0taL0IlpB+QufusSvxTRJnQrXvd
         WTUw==
X-Forwarded-Encrypted: i=1; AJvYcCU645AGujkESdIfTaZXEkQBOpBNN0gT5vr7Kz4zpzQCT8tKnbRbAJnU0GSnJuszWjypyMclGUe0WV2MZHpILzXUWW/0Ft82sLjXnGpp2wSNkuGpDKE+N3jlfQJWrd1yDY9IWepq
X-Gm-Message-State: AOJu0YyHypHik83TIUTF5WSRgt5nX3QNkPa2MTiTQ03a0y0PsiWEvTbC
	OrV3fm5+/mmygNH2ZVHDmwx+U/g77My/zELR005xMytYEiWO+S6U
X-Google-Smtp-Source: AGHT+IFoUVSwvX/j2zn5P5gwCmqWAcX48W3j1vfyGyPqmumyT/lLiUAIbbKhnxvW5iYBBS69JiNtjQ==
X-Received: by 2002:a05:651c:19a9:b0:2ef:23af:f1f2 with SMTP id 38308e7fff4ca-2f3be78709cmr58117921fa.9.1724165636185;
        Tue, 20 Aug 2024 07:53:56 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f3e0sm6853312a12.71.2024.08.20.07.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:53:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 17:53:52 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xfr@outlook.com
Subject: Re: [PATCH net-next v5 5/7] net: stmmac: support fp parameter of
 tc-mqprio
Message-ID: <20240820145352.kfhvdipr37iivt4l@skbuf>
References: <cover.1724152528.git.0x1207@gmail.com>
 <cover.1724152528.git.0x1207@gmail.com>
 <d816e312349d0ee4740f5c3068cbcbed17e8d6e3.1724152528.git.0x1207@gmail.com>
 <d816e312349d0ee4740f5c3068cbcbed17e8d6e3.1724152528.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d816e312349d0ee4740f5c3068cbcbed17e8d6e3.1724152528.git.0x1207@gmail.com>
 <d816e312349d0ee4740f5c3068cbcbed17e8d6e3.1724152528.git.0x1207@gmail.com>

On Tue, Aug 20, 2024 at 07:20:39PM +0800, Furong Xu wrote:
> tc-mqprio can select whether traffic classes are express or preemptible.
> 
> After some traffic tests, MAC merge layer statistics are all good.
> 
> Local device:
> ethtool --include-statistics --json --show-mm eth1
> [ {
>         "ifname": "eth1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 0,
>             "MACMergeFragCountRx": 0,
>             "MACMergeFragCountTx": 35105,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Remote device:
> ethtool --include-statistics --json --show-mm end1
> [ {
>         "ifname": "end1",
>         "pmac-enabled": true,
>         "tx-enabled": true,
>         "tx-active": true,
>         "tx-min-frag-size": 60,
>         "rx-min-frag-size": 60,
>         "verify-enabled": true,
>         "verify-time": 100,
>         "max-verify-time": 128,
>         "verify-status": "SUCCEEDED",
>         "statistics": {
>             "MACMergeFrameAssErrorCount": 0,
>             "MACMergeFrameSmdErrorCount": 0,
>             "MACMergeFrameAssOkCount": 35105,
>             "MACMergeFragCountRx": 35105,
>             "MACMergeFragCountTx": 0,
>             "MACMergeHoldCount": 0
>         }
>     } ]
> 
> Tested on DWMAC CORE 5.10a
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  2 +
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.c  | 52 +++++++++++++
>  drivers/net/ethernet/stmicro/stmmac/dwmac5.h  |  4 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    | 10 +++
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
>  .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 75 +++++++++++++++++++
>  6 files changed, 145 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> index 679efcc631f1..4722bac7e3d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
> @@ -1266,6 +1266,7 @@ const struct stmmac_ops dwmac410_ops = {
>  	.fpe_irq_status = dwmac5_fpe_irq_status,
>  	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
>  	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
> +	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
>  	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
>  	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
>  	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
> @@ -1320,6 +1321,7 @@ const struct stmmac_ops dwmac510_ops = {
>  	.fpe_irq_status = dwmac5_fpe_irq_status,
>  	.fpe_get_add_frag_size = dwmac5_fpe_get_add_frag_size,
>  	.fpe_set_add_frag_size = dwmac5_fpe_set_add_frag_size,
> +	.fpe_set_preemptible_tcs = dwmac5_fpe_set_preemptible_tcs,
>  	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
>  	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
>  	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> index 4c91fa766b13..1e87dbc9a406 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.c
> @@ -670,3 +670,55 @@ void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size)
>  
>  	writel(value, ioaddr + MTL_FPE_CTRL_STS);
>  }
> +
> +int dwmac5_fpe_set_preemptible_tcs(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack,
> +				   unsigned long tcs)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +	void __iomem *ioaddr = priv->ioaddr;
> +	unsigned long queue_tcs = 0;
> +	int num_tc = ndev->num_tc;
> +	u32 value, queue_weight;
> +	u16 offset, count;
> +	int tc, i;
> +
> +	if (!tcs)
> +		goto __update_queue_tcs;
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		count = ndev->tc_to_txq[tc].count;
> +		offset = ndev->tc_to_txq[tc].offset;
> +
> +		if (tcs & BIT(tc))
> +			queue_tcs |= GENMASK(offset + count - 1, offset);

What does the name "queue_tcs" mean?
Would this be more descriptively named "preemptible_txqs"?

Also, what is the maximum acceptable plat->tx_queues_to_use value for
the driver? I assume that the preemptible_txqs bit mask will always fit
into an unsigned long value (32 or 64 bits)?

> +
> +		/* This is 1:1 mapping, go to next TC */
> +		if (count == 1)
> +			continue;
> +
> +		if (priv->plat->tx_sched_algorithm == MTL_TX_ALGORITHM_SP) {
> +			NL_SET_ERR_MSG_MOD(extack, "TX algorithm SP is not suitable for one TC to multiple TXQs mapping");
> +			return -EINVAL;
> +		}
> +
> +		queue_weight = priv->plat->tx_queues_cfg[offset].weight;
> +		for (i = 1; i < count; i++) {
> +			if (queue_weight != priv->plat->tx_queues_cfg[offset + i].weight) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack, "TXQ weight [%u] differs across other TXQs in TC: [%u]",
> +						       queue_weight, tc);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +__update_queue_tcs:
> +	value = readl(ioaddr + MTL_FPE_CTRL_STS);
> +
> +	value &= ~PEC;
> +	value |= FIELD_PREP(PEC, queue_tcs);
> +
> +	writel(value, ioaddr + MTL_FPE_CTRL_STS);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> index e369e65920fc..d3191c48354d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac5.h
> @@ -40,6 +40,7 @@
>  #define MAC_PPSx_WIDTH(x)		(0x00000b8c + ((x) * 0x10))
>  
>  #define MTL_FPE_CTRL_STS		0x00000c90
> +#define PEC				GENMASK(15, 8)
>  #define AFSZ				GENMASK(1, 0)
>  
>  #define MTL_RXP_CONTROL_STATUS		0x00000ca0
> @@ -114,5 +115,8 @@ void dwmac5_fpe_send_mpacket(void __iomem *ioaddr,
>  int dwmac5_fpe_irq_status(void __iomem *ioaddr, struct net_device *dev);
>  int dwmac5_fpe_get_add_frag_size(void __iomem *ioaddr);
>  void dwmac5_fpe_set_add_frag_size(void __iomem *ioaddr, u32 add_frag_size);
> +int dwmac5_fpe_set_preemptible_tcs(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack,
> +				   unsigned long tcs);
>  
>  #endif /* __DWMAC5_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index ba4418eaa8ba..37e8fecaf042 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/netdevice.h>
>  #include <linux/stmmac.h>
> +#include <net/pkt_cls.h>
>  
>  #define stmmac_do_void_callback(__priv, __module, __cname,  __arg0, __args...) \
>  ({ \
> @@ -428,6 +429,9 @@ struct stmmac_ops {
>  	int (*fpe_irq_status)(void __iomem *ioaddr, struct net_device *dev);
>  	int (*fpe_get_add_frag_size)(void __iomem *ioaddr);
>  	void (*fpe_set_add_frag_size)(void __iomem *ioaddr, u32 add_frag_size);
> +	int (*fpe_set_preemptible_tcs)(struct net_device *ndev,
> +				       struct netlink_ext_ack *extack,
> +				       unsigned long tcs);
>  };
>  
>  #define stmmac_core_init(__priv, __args...) \
> @@ -536,6 +540,8 @@ struct stmmac_ops {
>  	stmmac_do_callback(__priv, mac, fpe_get_add_frag_size, __args)
>  #define stmmac_fpe_set_add_frag_size(__priv, __args...) \
>  	stmmac_do_void_callback(__priv, mac, fpe_set_add_frag_size, __args)
> +#define stmmac_fpe_set_preemptible_tcs(__priv, __args...) \
> +	stmmac_do_callback(__priv, mac, fpe_set_preemptible_tcs, __args)
>  
>  /* PTP and HW Timer helpers */
>  struct stmmac_hwtimestamp {
> @@ -623,6 +629,8 @@ struct stmmac_tc_ops {
>  			 struct tc_etf_qopt_offload *qopt);
>  	int (*query_caps)(struct stmmac_priv *priv,
>  			  struct tc_query_caps_base *base);
> +	int (*setup_mqprio)(struct stmmac_priv *priv,
> +			    struct tc_mqprio_qopt_offload *qopt);

I don't really understand this (the driver authors really love function pointers).

We have stmmac_tc_ops, but all hwifs either set it to dwmac510_tc_ops, or NULL?
And within dwmac510_tc_ops, we have the second round of function pointers,
for fpe_set_preemptible_tcs(), depending on the _actual_ hwif?!

Shouldn't any differentiation among mqprio implementations be done primarily
at this stage here?

>  };
>  
>  #define stmmac_tc_init(__priv, __args...) \
> @@ -639,6 +647,8 @@ struct stmmac_tc_ops {
>  	stmmac_do_callback(__priv, tc, setup_etf, __args)
>  #define stmmac_tc_query_caps(__priv, __args...) \
>  	stmmac_do_callback(__priv, tc, query_caps, __args)
> +#define stmmac_tc_setup_mqprio(__priv, __args...) \
> +	stmmac_do_callback(__priv, tc, setup_mqprio, __args)
>  
>  struct stmmac_counters;
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3df9cad0848b..dcf2b5ea7b4f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -6274,6 +6274,8 @@ static int stmmac_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>  	switch (type) {
>  	case TC_QUERY_CAPS:
>  		return stmmac_tc_query_caps(priv, priv, type_data);
> +	case TC_SETUP_QDISC_MQPRIO:
> +		return stmmac_tc_setup_mqprio(priv, priv, type_data);
>  	case TC_SETUP_BLOCK:
>  		return flow_block_cb_setup_simple(type_data,
>  						  &stmmac_block_cb_list,
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index a58282d6458c..08fda0ed5ff3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -1174,6 +1174,13 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  			 struct tc_query_caps_base *base)
>  {
>  	switch (base->type) {
> +	case TC_SETUP_QDISC_MQPRIO: {
> +		struct tc_mqprio_caps *caps = base->caps;
> +
> +		caps->validate_queue_counts = true;
> +
> +		return 0;
> +	}
>  	case TC_SETUP_QDISC_TAPRIO: {
>  		struct tc_taprio_caps *caps = base->caps;
>  
> @@ -1190,6 +1197,73 @@ static int tc_query_caps(struct stmmac_priv *priv,
>  	}
>  }
>  
> +static void stmmac_reset_tc_mqprio(struct net_device *ndev,
> +				   struct netlink_ext_ack *extack)
> +{
> +	struct stmmac_priv *priv = netdev_priv(ndev);
> +
> +	netdev_reset_tc(ndev);
> +	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
> +
> +	stmmac_fpe_set_preemptible_tcs(priv, ndev, extack, 0);
> +}
> +
> +static int tc_setup_mqprio(struct stmmac_priv *priv,
> +			   struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	struct net_device *ndev = priv->dev;
> +	int num_stack_tx_queues = 0;
> +	int num_tc = qopt->num_tc;
> +	u16 offset, count;
> +	int tc, err;
> +
> +	if (!num_tc) {
> +		stmmac_reset_tc_mqprio(ndev, extack);
> +		return 0;
> +	}
> +
> +	err = netdev_set_num_tc(ndev, num_tc);
> +	if (err)
> +		return err;
> +
> +	/* DWMAC CORE4+ can not programming TC:TXQ mapping to hardware.

s/can not programming TC:TXQ/cannot program the TC:TXQ/

> +	 * Synopsys Databook:
> +	 * "The number of Tx DMA channels is equal to the number of Tx queues,
> +	 * and is direct one-to-one mapping."
> +	 *
> +	 * Luckily, DWXGMAC CORE can.
> +	 *
> +	 * Thus preemptible_tcs should be handled in a per core manner.
> +	 */

What is the justification for programming the TC:TXQ mapping, for the
hwifs where that is configurable, in a method named fpe_set_preemptible_tcs()
though? Your intention is for that method to do so much more than its
name would suggest, at least for DWXGMAC. Either restrict its purpose to
just deal with the preemptible TCs as described, or rename it to make it
clear that it applies an entire mqprio queue configuration.

> +	for (tc = 0; tc < num_tc; tc++) {
> +		offset = qopt->offset[tc];
> +		count = qopt->count[tc];
> +		num_stack_tx_queues += count;
> +
> +		err = netdev_set_tc_queue(ndev, tc, count, offset);
> +		if (err)
> +			goto err_reset_tc;
> +	}
> +
> +	err = netif_set_real_num_tx_queues(ndev, num_stack_tx_queues);
> +	if (err)
> +		goto err_reset_tc;
> +
> +	err = stmmac_fpe_set_preemptible_tcs(priv, ndev, extack,
> +					     mqprio->preemptible_tcs);
> +	if (err)
> +		goto err_reset_tc;

Oh, the pains of stmmac_do_callback().... If the hwif does not
implement stmmac_ops :: fpe_set_preemptible_tcs(), this will
return -EINVAL and not set any extack message, leading the user
to ask himself "which parameter is invalid?!". The tc subsystem is
notorious for being cryptic in its errors, and we should try to not
make that any worse.

Also, since the check for the presence of the function pointer is
bundled up with the call itself, you are forced to do a lot of useless
work when you could have tested at the very beginning for the presence
of the function, and returned -EOPNOTSUPP prior to having changed
anything. It is an antipattern which actively results in worse code by
using it.

Would you be against "open-coding" it, and testing the function pointer
early, to return -EOPNOTSUPP and set the extack message?

> +
> +	return 0;
> +
> +err_reset_tc:
> +	stmmac_reset_tc_mqprio(ndev, extack);
> +
> +	return err;
> +}
> +
>  const struct stmmac_tc_ops dwmac510_tc_ops = {
>  	.init = tc_init,
>  	.setup_cls_u32 = tc_setup_cls_u32,
> @@ -1198,4 +1272,5 @@ const struct stmmac_tc_ops dwmac510_tc_ops = {
>  	.setup_taprio = tc_setup_taprio,
>  	.setup_etf = tc_setup_etf,
>  	.query_caps = tc_query_caps,
> +	.setup_mqprio = tc_setup_mqprio,
>  };
> -- 
> 2.34.1
> 


