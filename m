Return-Path: <netdev+bounces-259762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNn8HTi/mGnuLgMAu9opvQ
	(envelope-from <netdev+bounces-259762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:08:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA82316A8E5
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 751E2302EEB4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 20:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D710342535;
	Fri, 20 Feb 2026 20:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtipkWCu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A97331A7A
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 20:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771618101; cv=none; b=j8UV4glq0Xc+e8/3vEXRuJIIxdVWiRJ87QRY4FNUfD03I0e32kmRnZCN/NyIRebbP3FvXask33juqKtfwe/ZUZx6+xMnIKTHjaisBjI7j41ExuUG/WeRnOL+CG29Cmu+Bi2smn/YO3bfLWXjahVCYRipjhblV8Kn0RjiV5J93Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771618101; c=relaxed/simple;
	bh=wNp992WHvEsa/JEWVwfBeRNuvRIR3zhNSlmJNfhdORM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qu2YCDBzvqQXocXxNOMv5phZ5eQq6QGeQYmS1fPL2AKhtvoVhPpW2TpeET19mxoIW9h5UmTYC6TcUGbQmKN7h2uumUXxo+tVB3NmJOfQ2XTJHddjV/dDLdkFSpY9YWK5LDtg8lSKG4qAmjzXw90xvMzrRp7SWvWKrV596V8XXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtipkWCu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794f701a3e6so24261847b3.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 12:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771618099; x=1772222899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XdCfU3TY/z4MLJZHuc2137C+5K1SA/ke9KnoDI2wD0=;
        b=ZtipkWCuTOcikOHBU409TZDIH9oKx2mbmAQ+mkia2Zt8fCTbrHy7IzqCmpSVrU5ZuJ
         Q3DrpOYf3vg0hUg4R+SZmU2Alu00MnOiCzXJ0vWtqnIDwaeO/5qBTjqRAa1u1uhrBqYL
         z9D+RSn0Iwxm4hvbNLTq/Gs5UiQSGWKmdWs50mrsUZCwkwB5/vnqHWxSxcUT7s5jie/4
         S5rDeFZY3vvYYkWZbGfY8ARZFW34ktdO9ImhGErSTRCHeCrtRV8R2enwCIupbJnGx81o
         PEEUt3p671iFoRkRA7LoespefMXRceLahrRMi99nLVTwRkSNbGqMLEJEIRTdL5Ricbe4
         RO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771618099; x=1772222899;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6XdCfU3TY/z4MLJZHuc2137C+5K1SA/ke9KnoDI2wD0=;
        b=oMJ18kLs3l/MulbVkGmY26lKGkKzOs+TCvAHQUdeXzIy9EhSYTQzMH1FVMFJ5VKx3R
         XhsPm7viFv03Fenwf0+brgQbDghyG6S4WChohUc+Nokc1FfV8ZZGIdvY3GiEdFoP5y4F
         /MaTN4p8wkAlsUAbzSpGyqo1M8Mj/Ib6VMr3Xic94PmIF4IuPiB8vSpCRTfHlUrytWDD
         w+6Do7B396/OX+T9pcxzJlL7qXqRWfCBHB5Dr29TxudXBvuyi+Ssmc9pJUmSU1VXAEuJ
         etmEONCKzLaFngTTEKvssQeJt2ii7ipV7aeZNh3rewJ98fyuvJtqtAKmkUyUg0CZYRDv
         ufFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPHg6HPkWoTVdLBE8bIsRaHrxZWvEIkWMSBscOd3J3FBs987HLoBnKvojK5ZgEklXuGfDYEkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJWWcHjfz8MNqEa0wRWcf+C5tsk2yvY/QeKY4FPX/iRcZENAQT
	Tw7htbXZgeO0EdfXlLhmBkD4dRbfcytV5SzQcIqnLx8MejB+9tBXOcNz8n7ErA==
X-Gm-Gg: AZuq6aKeQ0kKmnMZfIo56rCaUhptOHO7ItMjYd1hq0CeOD30K2fOpE1P09sD4JR9crf
	nMQp/jEc4WJtfoQ2YowWNKJa2JTWPQPmFtqxcBRu8h8DUX6PjW9JgUoKSRrQTKMow/UYmvphYJz
	pAtM4wiT+GpMaP0bAYEnXmu43D/5CjhG96RbcW0yFaNCJh0pUkr8dcD8X2MWV+UwQkX1LOBHlBA
	LIvQ5hPlenI3wQwbRz7JV8hJ98hVc90OE8l7lAt2lCPoFrVQ1c2egCpq4HBiGcd6i7yxcETBVdw
	OFHexUVTB7Idll5PhWaaKlz6squ0JG5P6m/ZAoiAW2FdS+4X59xJtMIejgYZjSI07SaNjeFjt8s
	5Mtq5GzRBYl6kCcgrIPKYD9Sfzb1uqarsx+UDN13HjpVlO51bK/lWbCBNiIOn7HLRekU73lvHQp
	NneP8UWv/HEBq8Y9aracO7EWOifAg7ylVb1xb8C0/pYSRQ5vpDIhIYu3Z6qjMyoFwzyaKUT9M=
X-Received: by 2002:a05:690c:9a87:b0:794:d7ed:53a0 with SMTP id 00721157ae682-79829021c39mr11433837b3.53.1771618098630;
        Fri, 20 Feb 2026 12:08:18 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7982de1381esm858647b3.53.2026.02.20.12.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 12:08:17 -0800 (PST)
Date: Fri, 20 Feb 2026 15:08:17 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>, 
 kuba@kernel.org
Cc: maciek@machnikowski.net, 
 richardcochran@gmail.com, 
 netdev@vger.kernel.org, 
 milena.olech@intel.com
Message-ID: <willemdebruijn.kernel.1957319fee759@gmail.com>
In-Reply-To: <20260219140530.2148-3-maciek@machnikowski.net>
References: <20260219140530.2148-1-maciek@machnikowski.net>
 <20260219140530.2148-3-maciek@machnikowski.net>
Subject: Re: [PATCH net-next 2/2] netdevsim: Implement basic ptp support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259762-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[machnikowski.net,gmail.com,vger.kernel.org,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA82316A8E5
X-Rspamd-Action: no action

Maciek Machnikowski wrote:
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
> 
> This implementation enables running ptp4l on netdevsim adapters.
> 
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  drivers/net/netdevsim/ethtool.c   | 12 +++++
>  drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  3 files changed, 103 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 36a201533..367c7ca8b 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -201,6 +201,18 @@ static int nsim_get_ts_info(struct net_device *dev,
>  	struct netdevsim *ns = netdev_priv(dev);
>  
>  	info->phc_index = mock_phc_index(ns->phc);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
> +				SOF_TIMESTAMPING_RX_SOFTWARE |
> +				SOF_TIMESTAMPING_SOFTWARE |
> +				SOF_TIMESTAMPING_TX_HARDWARE |
> +				SOF_TIMESTAMPING_RX_HARDWARE |
> +				SOF_TIMESTAMPING_RAW_HARDWARE;

preferred model is to populate the device independent defaults with
ethtool_op_get_ts_info, then extend where relevant. See for instance
gve_get_ts_info.
> +
> +	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
> +	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
>  
>  	return 0;
>  }
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 6285fbefe..b1161c1ca 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -30,6 +30,8 @@
>  #include <net/rtnetlink.h>
>  #include <net/udp_tunnel.h>
>  #include <net/busy_poll.h>
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/timecounter.h>
>  
>  #include "netdevsim.h"
>  
> @@ -119,12 +121,17 @@ static int nsim_forward_skb(struct net_device *tx_dev,
>  
>  static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	struct skb_shared_hwtstamps shhwtstamps = {};
>  	struct netdevsim *ns = netdev_priv(dev);
> +	struct ptp_clock_info *ptp_info;
> +	struct timespec64 tx_ts, rx_ts;
> +	struct sk_buff *skb_orig = skb;
>  	struct skb_ext *psp_ext = NULL;
>  	struct net_device *peer_dev;
>  	unsigned int len = skb->len;
>  	struct netdevsim *peer_ns;
>  	struct netdev_config *cfg;
> +	bool gen_tx_tstamp = false;
>  	struct nsim_rq *rq;
>  	int rxq;
>  	int dr;
> @@ -161,6 +168,27 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		skb_linearize(skb);
>  
>  	skb_tx_timestamp(skb);
> +	gen_tx_tstamp = skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP;
> +	if (gen_tx_tstamp) {
> +		ptp_info = mock_phc_get_ptp_info(ns->phc);
> +
> +		/* Create a copy of tx skb to keep the tx reference */
> +		skb_orig = skb;
> +		skb = skb_copy(skb_orig, GFP_ATOMIC);

This should not be needed

skb_tstamp_tx itself will cal skg_clone or alloc_skb for the
notification skb.

Just queue the tx timestamp before nsim_forward_skb?

> +		skb_shinfo(skb_orig)->tx_flags |= SKBTX_IN_PROGRESS;
> +
> +		/* Timestamp as late as possible */
> +		if (ptp_info)
> +			ptp_info->gettime64(ptp_info, &tx_ts);
> +	}
> +
> +	/* Generate Rx tstamp based on the peer clock */
> +	ptp_info = mock_phc_get_ptp_info(peer_ns->phc);
> +	if (ptp_info) {
> +		ptp_info->gettime64(ptp_info, &rx_ts);
> +		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(rx_ts);
> +	}
> +
>  	if (unlikely(nsim_forward_skb(dev, peer_dev,
>  				      skb, rq, psp_ext) == NET_RX_DROP))
>  		goto out_drop_cnt;
> @@ -168,6 +196,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	if (!hrtimer_active(&rq->napi_timer))
>  		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
>  
> +	/* only timestamp the outbound packet if user requested it */
> +	if (gen_tx_tstamp) {
> +		shhwtstamps.hwtstamp = timespec64_to_ktime(tx_ts);
> +		skb_tstamp_tx(skb_orig, &shhwtstamps);
> +		dev_kfree_skb_any(skb_orig);
> +	}
> +
>  	rcu_read_unlock();
>  	dev_dstats_tx_add(dev, len);
>  	return NETDEV_TX_OK;
> @@ -182,6 +217,59 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int nsim_set_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +
> +	if (!ns->phc)
> +		return -EOPNOTSUPP;
> +
> +	switch (config->tx_type) {
> +	case HWTSTAMP_TX_OFF:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_OFF;
> +		break;
> +	case HWTSTAMP_TX_ON:
> +		ns->tstamp_config.tx_type = HWTSTAMP_TX_ON;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	switch (config->rx_filter) {
> +	case HWTSTAMP_FILTER_NONE:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +		break;
> +	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
> +	case HWTSTAMP_FILTER_PTP_V2_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
> +	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
> +	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
> +	case HWTSTAMP_FILTER_NTP_ALL:
> +	case HWTSTAMP_FILTER_ALL:
> +		ns->tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
> +		break;
> +	default:
> +		return -ERANGE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int nsim_get_ts_config(struct net_device *netdev,
> +			      struct kernel_hwtstamp_config *config)
> +{
> +	struct netdevsim *ns = netdev_priv(netdev);
> +
> +	*config = ns->tstamp_config;
> +	return 0;
> +}
> +
>  static void nsim_set_rx_mode(struct net_device *dev)
>  {
>  }
> @@ -660,6 +748,8 @@ static const struct net_device_ops nsim_netdev_ops = {
>  	.ndo_open		= nsim_open,
>  	.ndo_stop		= nsim_stop,
>  	.net_shaper_ops		= &nsim_shaper_ops,
> +	.ndo_hwtstamp_get	= nsim_get_ts_config,
> +	.ndo_hwtstamp_set	= nsim_set_ts_config,
>  };
>  
>  static const struct net_device_ops nsim_vf_netdev_ops = {
> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
> index f767fc8a7..6d3e8700c 100644
> --- a/drivers/net/netdevsim/netdevsim.h
> +++ b/drivers/net/netdevsim/netdevsim.h
> @@ -103,6 +103,7 @@ struct netdevsim {
>  	struct net_device *netdev;
>  	struct nsim_dev *nsim_dev;
>  	struct nsim_dev_port *nsim_dev_port;
> +	struct kernel_hwtstamp_config tstamp_config;
>  	struct mock_phc *phc;
>  	struct nsim_rq **rq;
>  
> -- 
> 2.53.0
> 



