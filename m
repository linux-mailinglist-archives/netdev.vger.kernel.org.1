Return-Path: <netdev+bounces-282453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IyfLRBE8mk+pQEAu9opvQ
	(envelope-from <netdev+bounces-282453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:46:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFFC49844D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8173011107
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D190B33D515;
	Wed, 29 Apr 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtqxcFQN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D23890F7
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484779; cv=none; b=EIhXaC5tUsti4CWEsQoM2xeH6621sJ0putm+GAZ86eASuvEOQhmhkjl3Z9eA8oq+uTFAeyP4KTYDGx5l0w6vbkpai8FFZqmvSnYMxTkBiI941QkJOg9Y1YkUl/X6AY7uZ49SruytPON0cJvTafRCMMiSZ01LRxlb3CcJREA03Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484779; c=relaxed/simple;
	bh=zvCOH3lB1Am44afwYKt0JmP9EQ2aBgzCmUp7gvB5hmg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Vk3Aza7QlMjlqpOptkJG72XYdg8FIROI3+7/WScbF+tVJqo79UvR9vhOUqNH6RPY4PfWW0J6GsXKTJU3yT27B2383jnwAxz5DY7Lx0J8WEWw68+IVMTJ1eEzzc0Qej1DHZ17ei2CrX2vttJebzqWCFlQ8Eo25Te4X585LK1u6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtqxcFQN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a7109f568so377017b3.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777484775; x=1778089575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKIco3GQAiw+z7+bsPEUCzAZ4BpHjbtXVNubj2uFdQ0=;
        b=OtqxcFQNVGlNEwPeSI+oKO3H5GTsKLTsFHBhir/CPMqAnZNHaG7ZHawpPqRdC85EXF
         w+oQfzwsH06IseSIHEBhetF2sdBxMuhBuIlGB96GNqr8sYiEhqFo0dHBKaa3TRu5/kEH
         yM7wbFdTRyTiN/stBtNStNOOCXwpbZxzlMWgSN2bxHCcO2FwrxtCNnbHksODMX8G8qXf
         dDxkFkGy0q+lVfEGiHl9quof5+75WcpqGSbtbievW6S1xDyWOo6L96x88gbHe6oWY7WN
         JpAIVPbQC3Kz/C0HwEJ7OQe0AB/XjvhRJFbkA2t28UlvCI18KjuSPRhyicxogTrfKjZH
         7jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484775; x=1778089575;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKIco3GQAiw+z7+bsPEUCzAZ4BpHjbtXVNubj2uFdQ0=;
        b=a+ZPb6+spDEiE/trnEoJZhdfwUPzkWPRE3wvlTRWzcgVxd+rvPG0W1CwwUbrtRFmiO
         tQcuUHlymGVe7kSnx5GAoi75XYfQiMnGpZZVxAbByDz2KUGmVSQciX1s6spMx2U3ytaG
         VseI/sv7atLjzKkSB8xEmOJCZnMgbzwuWArOgeTf/d/3qxn76S1Zb9qahf8w0HJlyjuQ
         txvobPXjt/Ci0IgiYE4RaTe99Jw2+pmLsNbZYr9eJ8TRNEfvsFBAhy8HEY36LN14iWk5
         V3q3xlg+a0zSbwA6XvJ5w6NRnFUnvw38WM/UE3QII75xbrTuJrcpL8zNZ2SeLF7DWah4
         8hVA==
X-Forwarded-Encrypted: i=1; AFNElJ+VvrkQjo+G402XVC7Tem8HJ1V2gAVr+aUxad9UnLoJJCgfZ3RurFdbc8qLJvuaFyJ53tIwx7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvYRoK83kwk83VVDPAsJ7VJjCBh1uZk1+cudQuX9Siijf68KNB
	3yN1lRvlDAX5mDm6JQxyuuoJiUSaxA5g1cOvL/K5OM4Wm/XWRG2Tl93i
X-Gm-Gg: AeBDietqd/05Kc6ZR9BFB7VhivfEsUn1GYawq03D+hVuJKHF7+63kyKTZofWZ7EKdp3
	0HT+fTsfmalA6kACCYa7+9tzbe4iM9+eepiR04wB4JtvvLTye7JN68r4exWZFtajYsnw7uIdi7O
	iGCAaoknOgP+YarvLsLDcPjUIUDmlPTKaBElhSSSZpX7nTeivOPPlh6mXFJ0jgdnW4aT9d3PxXn
	KeLqrh8yobA9Vs+CSNPNZ9i8f9hkukQauLb+z+J0rwrPiJ/JVbse5YpJvqWS1BebP4pt9GZTqkj
	mN0/h0OoPFC3a/1/5R/fseqpDQokTUbLcd7N8+dYAWDEj2LPraO1SEO+YmoWbycf5oxQbvGJ0NF
	v3YGKiNZ/hYmvlK86hEru5kB2fg3jmPgfcdM1gjZUF9gpXfbha9WAV0APqMQ1y4RDnyrw7M2Na8
	zwtfix2RKyv3e6+OPZnd1eKZf9uriwfK5sfSEeV5Z4NP4VpKMMRNZxAqYHAqaiwqACvNv+oB7XE
	fjsdNZS7XrqsAA=
X-Received: by 2002:a05:690c:385:b0:79a:6ea2:f439 with SMTP id 00721157ae682-7bcf57957e9mr83186257b3.38.1777484775035;
        Wed, 29 Apr 2026 10:46:15 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd252d3051sm19175237b3.22.2026.04.29.10.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 10:46:14 -0700 (PDT)
Date: Wed, 29 Apr 2026 13:46:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Neelima Muralidharan <neelima@ti.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praneeth Bajjuri <praneeth@ti.com>, 
 Pratheesh Gangadhar TK <pratheesh@ti.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <willemdebruijn.kernel.31592d82701e5@gmail.com>
In-Reply-To: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
Subject: Re: [PATCH RFC net-next v3] hsr: Allow to send a specific port and
 with HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1FFFC49844D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282453-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Sebastian Andrzej Siewior wrote:
> HSR forwards all packets it received on slave port 1 to slave port 2 and
> one of the two copies to the user (master) interface.
> In terms of PTP this is not good because the latency introduced by
> forwarding makes the timestamp in the PTP packet inaccurate.
> The PTP packets should not forwarded like regular packets.
> 
> In order to work with PTP over HSR the following has been done:
> - PTP packets which are received are dropped within the HSR stack. That
>   means they are not forwarded or injected into the master port. If the
>   user requires them, then they need to be obtained directly from the
>   SLAVE interface.
> 
> - Sending packets. If the ethernet type of the packet is ETH_P_1588 then
>   the stack assumes a header of type struct hsr_inline_header. The size
>   of this header is as ethhdr. As a safeguard, the header contains a
>   magic field which matches the position of h_source and it needs to
>   match HSR_INLINE_HDR.
>   Once this is verified, the header contains the port on which this
>   packet needs to be sent and if system's HSR header should be added.
>   This information is used with the HSR stack and also attached to skb
>   as a skb-extension. The packet is then pulled passed the custom header
>   so the remaining stack will see the actual data.
>   The skb-extension is needed so that an ethernet driver, with
>   HSR-offload capabilities, knows that it must not add HSR-header (unless
>   requested) and send the packet on both ports.
> 
> The originally submitted skb is freed and only the (altered) clone is
> submitted to the slave interface for sending. Therefore on cloning, the
> socket and tx_flags/ tskey are copied so that the PTP timestamp is
> forwarded to the submitting socket.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Great to see a solution that keeps the added logic mostly within HSR
itself, and works for the userspace component too.


> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..220f6e5d7b24c 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IF_HSR_H_
>  
>  #include <linux/types.h>
> +#include <linux/skbuff.h>
>  
>  struct net_device;
>  
> @@ -22,6 +23,21 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  
> +struct hsr_ptp_ext {
> +	u8	port;
> +	u8	header;
> +};
> +
> +#define HSR_INLINE_HDR	0xaf485352
> +struct hsr_inline_header {
> +	uint8_t tx_port;
> +	uint8_t hsr_hdr;
> +	uint8_t __pad0[4];
> +	uint32_t magic;
> +	uint8_t __pad1[2];
> +	uint16_t eth_type;
> +} __packed;
> +

No specific need to make this header ethhdr like?

>  /* HSR Tag.
>   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
>   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
> @@ -45,6 +61,60 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  				     enum hsr_port_type pt);
>  int hsr_get_port_type(struct net_device *hsr_dev, struct net_device *dev,
>  		      enum hsr_port_type *type);
> +
> +static inline bool hsr_skb_has_header(struct sk_buff *skb)
> +{
> +	struct hsr_ptp_ext *ptp_ext;
> +
> +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> +	if (!ptp_ext)
> +		return false;
> +	return ptp_ext->header;
> +}
> +
> +static inline unsigned int hsr_skb_has_port(struct sk_buff *skb)
> +{
> +	struct hsr_ptp_ext *ptp_ext;
> +
> +	if (!skb)
> +		return 0;
> +
> +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> +	if (!ptp_ext)
> +		return 0;
> +	return ptp_ext->port;
> +}
> +
> +static inline bool hsr_skb_get_header_port(struct sk_buff *skb, bool *header,
> +					   enum hsr_port_type *port_type)
> +{
> +	struct hsr_ptp_ext *ptp_ext;
> +
> +	*port_type = HSR_PT_NONE;
> +	*header = false;
> +
> +	ptp_ext = skb_ext_find(skb, SKB_EXT_HSR);
> +	if (!ptp_ext)
> +		return false;
> +
> +	*port_type = ptp_ext->port;
> +	*header = ptp_ext->header;
> +	return true;
> +}
> +
> +static inline bool hsr_skb_add_header_port(struct sk_buff *skb, bool header,
> +					   enum hsr_port_type port)
> +{
> +	struct hsr_ptp_ext *ptp_ext;
> +
> +	ptp_ext = skb_ext_add(skb, SKB_EXT_HSR);
> +	if (!ptp_ext)
> +		return false;
> +	ptp_ext->port = port;
> +	ptp_ext->header = header;
> +	return true;
> +}
> +
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5555b71ab19b5..ac39b2347aa0f 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -228,20 +228,51 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	rcu_read_lock();
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	if (master) {
> -		skb->dev = master->dev;
> -		skb_reset_mac_header(skb);
> -		skb_reset_mac_len(skb);
> -		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, master);
> -		spin_unlock_bh(&hsr->seqnr_lock);
> -	} else {
> -		dev_core_stats_tx_dropped_inc(dev);
> -		dev_kfree_skb_any(skb);
> +	if (!master)
> +		goto drop;
> +
> +	skb->dev = master->dev;
> +	if (skb->len > ETH_HLEN * 2) {
> +		struct hsr_inline_header *hsr_opt;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->eth_type == htons(ETH_P_1588) &&
> +		    hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> +			enum hsr_port_type tx_port;
> +			bool has_header;
> +
> +			has_header = hsr_opt->hsr_hdr;
> +			tx_port = hsr_opt->tx_port;
> +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +				goto drop;
> +
> +			if (!hsr_skb_add_header_port(skb, has_header, tx_port))
> +				goto drop;

All use of this information happens in the context of this ndo_start_xmit?

If so, no skb_ext needed. Can store the data in skb->cb[], which in
that case is assured to not be overwritten by another layer.

Among various options. skb_ext works, but is a bit heavyhanded for
passing around state within the same layer and call stack.

> +
> +			skb_pull(skb, ETH_HLEN);

Prefer sizeof(struct hsr_inline_header)

> +			if (has_header)
> +				skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
> +			else
> +				skb_set_network_header(skb, ETH_HLEN);
> +		}
>  	}
> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);
> +	spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, master);
> +	spin_unlock_bh(&hsr->seqnr_lock);
> +
>  	rcu_read_unlock();
>  
>  	return NETDEV_TX_OK;
> +
> +drop:
> +	dev_core_stats_tx_dropped_inc(dev);
> +	dev_kfree_skb_any(skb);
> +	rcu_read_unlock();
> +	return NETDEV_TX_OK;
>  }
>  

