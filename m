Return-Path: <netdev+bounces-263856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Cg5JdpOqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:25:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6512029AC
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19346300E72F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2629330B30;
	Wed,  4 Mar 2026 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URHr9y23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B74B3264E2
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637591; cv=none; b=A3PaycK5eZ+I5WOVZh7evbHbnv8EE7gl6/WeKSOmbOjorwYCWveQeqsyZuFcL4aNfTjJuLzKKwGcHEocgNykRVpMqyQ9AGySfjL6EfwMERPjOrClDKOXgtfpmue1IRdbMVD8zwRv64f+vDfNeoEK6eXW6iCj966Pi28JSLLNdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637591; c=relaxed/simple;
	bh=m0UtBTUcV9BHom3Haq4+TtWQ+KPLRqJ0s4yb2b2yhOY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WxGSh8T3UGJ1womCTKRjPhFuNDGWcbvEX1Q0N4PkInBhm5wPL2wiOzXn7xICU3yshLExZGHXyBYT77V4lVle0Qt8CNOVFcSx95QbMZigr7R1sfPzOeQ0cWBeLr9iNTlh2v1x7Fjw0sqtzfQwbXBNoELI6cilOI2SNrbSef4SBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URHr9y23; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64c9cabfe5dso8544732d50.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772637589; x=1773242389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOrFVNzQHWof4jJnFxTDmG3TO3l7ICSL1AouP2+Xjjk=;
        b=URHr9y237xB8bkMpLphSHR3y1cvje/UNEr5AC+l0DkwoiO7GVBW71t3c6MAb9F7W/3
         logoGg5J5p6wafqTl1h9pAUIeoYRosTKCCWxUVtsIH939+rWKE4WXW+jOdp+DFu8mz/t
         6ykwgtTHl3JMIMRTWt387y7RJE87ZF8XEot3IlkB1Vj6nxPfX7ukIu+Nhc0BAhd4PzoJ
         1jDsdHAeQTmecqnWUrD7fVtdoLahtzuicV8D/MbQ3DXiRlWshpLB/EtYelGMQQAOd7l1
         KFdCylSDsRybSO++G2oOF1xBMU1baeZ5zXf6aGyajlX3hdA6YWhhwstBZVp26utaqlan
         UdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772637589; x=1773242389;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOrFVNzQHWof4jJnFxTDmG3TO3l7ICSL1AouP2+Xjjk=;
        b=I/Gn7uWJWYKc1jlc0sbNfKmPWM4T4nvDqy/yPydbE3nwLMV1fz0w/6Ux78V6kc9Wi/
         1aU6g7cz1jS7ZB0/L7YP4e4YqFwmNramXJonGwOTJoeyrgnzslY+b8YMDMCDLfhzCfTu
         5xXm4uHzJQC24P8EUq5Ytik9HjUVkEgqHGX+ZM/GsWg5UsIn7ho/jbEU1/CKpMm+Tq5X
         j2KoOUEhcIPf8guTmMWSSLc5PjcO5rGBA02uRjdep+XvJ89NMFC5x5V4LL4ME5Sk7Z1q
         sO7YXYSp5FYzrtlONBIupXxGtPaNXqfFlTnklp8J9MMWeJ93lkMTSlvH1BVx0V3l+NEx
         ukaw==
X-Forwarded-Encrypted: i=1; AJvYcCUx4Ms7O3sjk3sUSxMAQwwYLEZvk305XmEz2n2J3iZWjVxMPI429LxfjGOJcMTAhL/IzD1yi4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCdFlg4uWtWvgUsZ1/Cfx74P0d42YEvUz/vLKUzT+DCO4t9R/v
	oBhJxClhg1XseIVW+eaLI7ljRbeF4wbKpehld1I/LRbeQVC/6KrHKymK
X-Gm-Gg: ATEYQzwOuJ8UqJV3GkkfAqfiHU/67myfxtAlKaJUZO+510CJl61BDi1twOB9BddVOOI
	gM3Yrc+HU9M/vtsYPkUxUecOoDQT9EgHU2EAbcIDGNSvgOsTm3tXMefFBJzoNUTTBSwS9ULQot7
	9AJOgB1lBA2n4XitY0T2u6ty2IDik50ptPpufVONeIdTtoDlysYNBZJXlWSKuhEbBUUP8n4LMbj
	5wZFnBEkZ3hBd61iA2n0Flyc77EBtUZwd+qywL/GJCbGgiRwLjDQWfMHcn80irf9lqo6u0HENYI
	CTU0VggQgxrj59arxfgmng99dcnGWA08qEQZluyYNsBlj1f/1rHDleWlvsjusjpr0p/epM1d+Qu
	HGlC7VBjDwwfzgKTRHA1Hku+iTV1D1MSIhoQiTMwVpAsxjSnEhRSslU8MjbZfV7Yb7kZRJWFpo8
	lGlPwqjfwbbsbzeiVOwVYsG2U88qlLGWe+R8ekcFfofl2LqVZZy/CUzvH+isSGEMvZD2Aguxo=
X-Received: by 2002:a05:690e:140f:b0:649:ba22:58d0 with SMTP id 956f58d0204a3-64cfacf99c9mr1488148d50.29.1772637589137;
        Wed, 04 Mar 2026 07:19:49 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb7626ff1sm7905540d50.13.2026.03.04.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 07:19:48 -0800 (PST)
Date: Wed, 04 Mar 2026 10:19:48 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>, 
 netdev@vger.kernel.org
Cc: kuba@kernel.org, 
 maciek@machnikowski.net, 
 richardcochran@gmail.com, 
 milena.olech@intel.com, 
 willemdebruijn.kernel@gmail.com, 
 andrew@lunn.ch, 
 vadim.fedorenko@linux.dev, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.211108b8ab49@gmail.com>
In-Reply-To: <20260225153858.29486-3-maciek@machnikowski.net>
References: <20260225153858.29486-1-maciek@machnikowski.net>
 <20260225153858.29486-3-maciek@machnikowski.net>
Subject: Re: [PATCH v3 net-next 2/3] netdevsim: Implement basic ptp support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EF6512029AC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-263856-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,machnikowski.net:email]
X-Rspamd-Action: no action

Maciek Machnikowski wrote:
> Add support for virtual timestamping inside the netdevsim driver.
> The implementation uses two attached ptp_mock clocks, reads the timestamps
> of the ones attached either to the netdevsim or its peer and returns
> timestamps using standard timestamps APIs.
> 
> This implementation enables running ptp4l on netdevsim adapters and
> introduces a new ptp selftest.
> 
> Co-developed-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Milena Olech <milena.olech@intel.com>
> Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
> ---
>  drivers/net/netdevsim/ethtool.c   | 11 ++++
>  drivers/net/netdevsim/netdev.c    | 90 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  3 files changed, 102 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
> index 36a201533..5b709033c 100644
> --- a/drivers/net/netdevsim/ethtool.c
> +++ b/drivers/net/netdevsim/ethtool.c
> @@ -200,7 +200,18 @@ static int nsim_get_ts_info(struct net_device *dev,
>  {
>  	struct netdevsim *ns = netdev_priv(dev);
>  
> +	ethtool_op_get_ts_info(dev, info);
> +
>  	info->phc_index = mock_phc_index(ns->phc);
> +	if (info->phc_index < 0)
> +		return 0;
> +
> +	info->so_timestamping |= SOF_TIMESTAMPING_TX_HARDWARE |
> +				 SOF_TIMESTAMPING_RX_HARDWARE |
> +				 SOF_TIMESTAMPING_RAW_HARDWARE;
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

I still don't understand this tx timestamp path, which is
non-standard.

The comment says timestamp as late as possible, which would be calling
gettime64 in the second branch, rather than the first. That would mean
that the tx timestamp is taken after the rx timestamp at the peer.
Confusing, but something that may actually happen on real NICs too in
some cases (e.g., PCI backpressure).

If goal is to maintain ordering between the two, remove the comment
about as late as possible.

More importantly, since skb_tstamp_tx internally will call alloc_skb
or skb_clone, why is this skb_copy here needed?

I probably should have replied to your previous response:

> If I queue the tx timestamp before forwarding - the same skb would
> be freed when the timestamp is delivered.

That is not the case since it is a clone or separate skb that is
queued to the error queue?

