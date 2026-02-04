Return-Path: <netdev+bounces-256786-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yE2XLx2Eg2llowMAu9opvQ
	(envelope-from <netdev+bounces-256786-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:38:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22535EB0A1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040DA30075F3
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CD631B107;
	Wed,  4 Feb 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHnoabir"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB6258CD0
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226599; cv=none; b=nB1n9CkMHj8TL0GVBu8z4+4PvXcP2Q7XKwa2SJ6Fhwp5krrxtSd6T3dCvgUqpa2gEIlIcszfdoHpBNeacmugTqy03CSQeHRHK5VXFyGQ63mKYlXRJ12qmm5I3pGUgSqOhpxg3fUK+6e8eL1GB89tkvYN87i04NkrsPJ3K5Gy6Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226599; c=relaxed/simple;
	bh=BOALPNWP3nm/4vIE4J1UGb6Zj/KBLz6fjJlAVGH5Rm0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=n9opC6EHr9QjeVM7Qz1kEK9qL4TKYLKiYM9Sf64FIqQPLfaDBhT95r47jrqKKy/2jfnkyCKcrnc8rCqZ6zAA4OLQBg0YrBC/CDTAgdo/ckA30C3iKJJTXqQdpbTFtGL/Vh7zczwleVIoZzvcO/pGnU4lULkpo/A7Vx4WV7zd2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHnoabir; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-795055a17a3so146857b3.0
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 09:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770226598; x=1770831398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhVN7wQ08Kv6eyYz6NmjxKDvl1VfG4pfNI4T9ZdOIeQ=;
        b=kHnoabirFlRIasuaPhX4PQU2DmT4A+51Tp9tslcz8RhhKo1Wdyu2hGJiuh75sfpNHG
         fbki3xvFcMfV8ISh9xNsH3W7BaSwOmCL0IIXbNz1iO5Qmic8vhhzByhx7E3igSqk3fH+
         vdsCj+jK549bmXaEZ8DmyxL3nYLSKva86kGA9xmmTUFT3dmRrw3JsM1etftk78BuDneo
         VP70syhu13MXAMG7Y4wFhhWn6cn2crq5wRDzRynqMZGF0dtO5EDrTyF+X1GeaKhUkmEx
         Jp4ffWkSfmX60E4K4DnWzJ+9uDmQsjqk/mvrTxt9Q4Tu4bouHLvY1pT2NosdB8Nr5cEY
         Uc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770226598; x=1770831398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GhVN7wQ08Kv6eyYz6NmjxKDvl1VfG4pfNI4T9ZdOIeQ=;
        b=QCqnJVWPuB5XGNlpqwFJWF4H817t/bR1Le2kaBnI0lKIzc8ypL3oZ3RYyZjfxHwRbt
         /8/BN17q/PiihJDe+Ll5RWjuPtPouFF/nQ6dmnmb982t7gm+JOT0A2kgSNLSC62/ZJBQ
         anq900/RzESQKx08g0w1jllCaId5Te7DU6q9F5Jnr4zhCf7fj6lkpIue+7FwZNtbtp/V
         E5qVxUOFzw7DZ49VYRkwgAPgMNY8jCiEH1XiU9454RKCblTLfYyNRhSM49VYQogH0oV2
         FRmVtGwGTo2LH7LOogTW0JocBEq7fL2MulntW6/7RunwmZEGdandlXRFa3VeYA5QpBIG
         h/gg==
X-Forwarded-Encrypted: i=1; AJvYcCWBT132UILbZqrcTlnp/+50t+iGO/ogaVEdTOOdOfWHRS33UrTGpPb5Br8EDoxmbaLiJDaZ31I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxywxW72BhcK0FFkI8eyMDhZ9a5qVqihquJZo5fqdPNimzL2gc6
	Mrq7poCIT1aXgKg1RSC0kyp6U8/WjYZOy8/xqDIohKjXGnXPkHlbshq0
X-Gm-Gg: AZuq6aI2zvZSWlHiHKtwFWx5qxvZdIrPP6Fi1gGU1q6tR5Hdn4wlZboMkFHi1YCnMOv
	U7PW8xPYEmxi85eMRJv9eHNBPFM282f71eJJElcgTwYBCGbCTvgfIfqEMDC/eMU3+YE67w+FMbB
	J3jw9oYLlkpcPjz0q+v4OzyoXFAfV9tMRuonphPYxT/bvqiReRcl8Ww4pFH0jH/o92LkyBF2obo
	bcXYLn9mEaO0QBVPARNplnjlAngQnN8yNsqpUUPlUsi2Bzzap2zpI6KZrBIvazzf/sdbVH+6aAV
	1t9o4JN6g0hT5q6Sy8uK89JsgbcwWEiE8O4jH1SB0RLwh1BGxmvZlI5IBlma7qBdy3Txuokvh9a
	lXUOaKnj3YHS1Ef59t4hhbg3iHLezSRrIJ1nidPegS1MGGizL2u0J9ifqiWqNBDBMkbF6PmvmHX
	Bv87KP4Qi7mzxmyqYi0HX/Jfe7xsdru8mrQz1oGn0fDBEZvKw3CUppMytDgVQ=
X-Received: by 2002:a05:690c:ec9:b0:794:26a9:f9c3 with SMTP id 00721157ae682-794fe83c7e0mr36696117b3.63.1770226597688;
        Wed, 04 Feb 2026 09:36:37 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794feff5cc7sm26353707b3.52.2026.02.04.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 09:36:37 -0800 (PST)
Date: Wed, 04 Feb 2026 12:36:36 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <willemdebruijn.kernel.2a1e4d7240fd4@gmail.com>
In-Reply-To: <20260204-hsr_ptp-v1-2-b421c69a77da@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-2-b421c69a77da@linutronix.de>
Subject: Re: [PATCH RFC net-next 2/2] af_packet: Add port specific handling
 for HSR
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256786-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,linutronix.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email]
X-Rspamd-Queue-Id: 22535EB0A1
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> linuxptp/ ptp4l uses a AF_PACKET with a RAW socket to send and receive
> PTP packets. Extend the interface with the ability to bind the socket to
> one of the two HSR ports and add a flag for sendmsg() to indicate that
> the packet already contains a HSR header.
> 
> Once PACKET_HSR_BIND_PORT is set, the socket will be bound to requested
> slave port. All incoming packets without a set port will be discarded.
> This limits receiving packet to PTP only packets. The packet will be
> forwarded to userland with the HSR header.
> 
> For control messages used by sendmsg(), PACKET_HSR_INFO is added with
> PACKET_HSR_INFO_HAS_HDR as the only option. This option sets
> HSR_SKB_INCLUDES_HEADER on the outgoing skb to indicate that the packet
> already contains a HSR header. This requires that the socket is bound to
> a specific HSR port so that the packet is sent only on one of the two
> ports.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/uapi/linux/if_packet.h |   9 ++++
>  net/packet/af_packet.c         | 103 +++++++++++++++++++++++++++++++++++++++++
>  net/packet/internal.h          |   1 +
>  3 files changed, 113 insertions(+)
> 
> diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> index 6cd1d7a41dfb7..3443eeac8470e 100644
> --- a/include/uapi/linux/if_packet.h
> +++ b/include/uapi/linux/if_packet.h
> @@ -60,6 +60,7 @@ struct sockaddr_ll {
>  #define PACKET_FANOUT_DATA		22
>  #define PACKET_IGNORE_OUTGOING		23
>  #define PACKET_VNET_HDR_SZ		24
> +#define PACKET_HSR_BIND_PORT		25
>  
>  #define PACKET_FANOUT_HASH		0
>  #define PACKET_FANOUT_LB		1
> @@ -74,6 +75,14 @@ struct sockaddr_ll {
>  #define PACKET_FANOUT_FLAG_IGNORE_OUTGOING     0x4000
>  #define PACKET_FANOUT_FLAG_DEFRAG	0x8000
>  
> +/* For HSR, bind port */
> +#define PACKET_HSR_BIND_PORT_AB		0
> +#define PACKET_HSR_BIND_PORT_A		1
> +#define PACKET_HSR_BIND_PORT_B		2
> +/* HSR, CMSG */
> +#define PACKET_HSR_INFO			1
> +#define PACKET_HSR_INFO_HAS_HDR		1
> +
>  struct tpacket_stats {
>  	unsigned int	tp_packets;
>  	unsigned int	tp_drops;
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 494d628d10a51..cd7c4ad034bc5 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -82,6 +82,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/mutex.h>
> +#include <linux/if_hsr.h>
>  #include <linux/if_vlan.h>
>  #include <linux/virtio_net.h>
>  #include <linux/errqueue.h>
> @@ -1938,6 +1939,36 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	skb_probe_transport_header(skb);
>  }
>  
> +static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
> +			    unsigned int *hsr_setting)
> +{
> +	struct cmsghdr *cmsg;
> +	int ret = -EINVAL;
> +	u32 val;
> +
> +	for_each_cmsghdr(cmsg, msg) {
> +		if (!CMSG_OK(msg, cmsg))
> +			goto out;
> +		if (cmsg->cmsg_level != SOL_PACKET)
> +			continue;
> +		if (cmsg->cmsg_type != PACKET_HSR_INFO)
> +			continue;
> +		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
> +			goto out;
> +
> +		val = *(u32 *)CMSG_DATA(cmsg);
> +		if (val != PACKET_HSR_INFO_HAS_HDR)
> +			goto out;
> +		if (!po->hsr_bound_port)
> +			goto out;
> +
> +		*hsr_setting = HSR_SKB_INCLUDES_HEADER;
> +	}
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
>  /*
>   *	Output a raw packet to a device layer. This bypasses all the other
>   *	protocol layers and you must therefore supply it with a complete frame
> @@ -1947,6 +1978,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  			       size_t len)
>  {
>  	struct sock *sk = sock->sk;
> +	struct packet_sock *po = pkt_sk(sk);
>  	DECLARE_SOCKADDR(struct sockaddr_pkt *, saddr, msg->msg_name);
>  	struct sk_buff *skb = NULL;
>  	struct net_device *dev;
> @@ -1954,6 +1986,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  	__be16 proto = 0;
>  	int err;
>  	int extra_len = 0;
> +	u32 hsr_setting = 0;
>  
>  	/*
>  	 *	Get and verify the address.
> @@ -2044,6 +2077,9 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  		err = sock_cmsg_send(sk, msg, &sockc);
>  		if (unlikely(err))
>  			goto out_unlock;
> +		err = packet_cmsg_send(msg, po, &hsr_setting);
> +		if (unlikely(err))
> +			goto out_unlock;

packet_sendmsg_spkt is legacy. No need to extend that.

>  	}
>  
>  	skb->protocol = proto;
> @@ -2052,6 +2088,7 @@ static int packet_sendmsg_spkt(struct socket *sock, struct msghdr *msg,
>  	skb->mark = sockc.mark;
>  	skb_set_delivery_type_by_clockid(skb, sockc.transmit_time, sk->sk_clockid);
>  	skb_setup_tx_timestamp(skb, &sockc);
> +	skb_shinfo(skb)->hsr_ptp = hsr_setting | po->hsr_bound_port;
>  
>  	if (unlikely(extra_len == 4))
>  		skb->no_fcs = 1;
> @@ -2131,6 +2168,13 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		goto drop;
>  
> +	if (po->hsr_bound_port) {
> +		struct skb_shared_info *si = skb_shinfo(skb);
> +
> +		if (po->hsr_bound_port != si->hsr_ptp)
> +			goto drop;
> +	}
> +

Similar to the high level comment to patch 1/2: this is quite a rare
use case, but this implementation imposes cost on every user. By
adding branches in the hot path, among others.

It is simply not scalable to extend core infra in this way for every
use case. The cross product of features is too great. We'll have to
find a way that is less HSR specific.

There are existing mechanisms for binding to a specific interface or
port, such as SO_BINDTOIFINDEX and packet bind().

>  	skb->dev = dev;
>  
>  	if (dev_has_header(dev)) {
> @@ -2260,6 +2304,13 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		goto drop;
>  
> +	if (po->hsr_bound_port) {
> +		struct skb_shared_info *si = skb_shinfo(skb);
> +
> +		if (po->hsr_bound_port != si->hsr_ptp)
> +			goto drop;
> +	}
> +
>  	if (dev_has_header(dev)) {
>  		if (sk->sk_type != SOCK_DGRAM)
>  			skb_push(skb, skb->data - skb_mac_header(skb));
> @@ -2731,6 +2782,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  	int len_sum = 0;
>  	int status = TP_STATUS_AVAILABLE;
>  	int hlen, tlen, copylen = 0;
> +	u32 hsr_setting = 0;
>  	long timeo;
>  
>  	mutex_lock(&po->pg_vec_lock);
> @@ -2775,6 +2827,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		err = sock_cmsg_send(&po->sk, msg, &sockc);
>  		if (unlikely(err))
>  			goto out_put;
> +
> +		err = packet_cmsg_send(msg, po, &hsr_setting);
> +		if (unlikely(err))
> +			goto out_put;
>  	}
>  
>  	if (po->sk.sk_socket->type == SOCK_RAW)



