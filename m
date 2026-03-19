Return-Path: <netdev+bounces-269446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHB4CVL6u2mzqwIAu9opvQ
	(envelope-from <netdev+bounces-269446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:29:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 165662CBFFB
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 21C353013CA1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1073B3BFE3F;
	Thu, 19 Mar 2026 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIc9frOz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BDB3A5E62
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926989; cv=none; b=VImFyltSNPkZAtmpHOiBq56GmibRn7bmlFgZWPDOkf1BkaabkkoQRFP5834PJMpJVTjyEj4nwg8j9oV85rzc/Ssd4PwRDEo8Zg0SKSYSMbqjuZ9iDapOXKMYzr9Xhao2AiqFBhSjcJYerwMIwGqE57btG9qdSMJ7v4kuJJRpUE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926989; c=relaxed/simple;
	bh=SDyBDi028rHysToBlr/SjBujKjGQVgp5UopkJDtHfAU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dy45GN8T3cbqiGNwfMOO+j/7iaI4vQnwotiZ5fz3BFF4Q/kI+kmHc6ko/LjQuVQxIjax2NhkMPdRUZlgpmaesxKxmpuwG+cfPpl8KRwkdN2KeRK8uF2/dqffj4z0BHvb1piJU1QxPq38yfGOlzcD3xBJURG6qYILAY1vP9hN2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIc9frOz; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a5a37113aso10251557b3.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773926986; x=1774531786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7WOJPGk6EyB/jwKTXJ9mfu0cdVjYd1vlv/ZkNNi0tA=;
        b=QIc9frOzK3q5lNVnCXHNCMk0bH4EEKU71JEbRSkKfJNQ/7XsqK7y6MAr7Pi7UFTLYD
         4z4JojIf3R7c+Vbn6m0kJmofPaPgk9tWlc55xwPBboO8Z3q4tYT5JIFgyNLiJuMDbiAX
         I4e6+m/a4VIXO7XndTrADz5zN+UrdayV5x/+sLO5gGnKK1waEqYJpsHOqY/+Vx9z5xfV
         Y4tKKLZ8AcVadozTXeFwY1m6ZVnJBrwLiYPZd3K+deKUyHn3W978BqJAPXC056CffStG
         EBWRklUwYQvB6uW0f0R9cLX3O4DkkjiQLQAhG3q0vfyCrQwMWbGMUYsUglkbIAsOWai0
         0Lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773926986; x=1774531786;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S7WOJPGk6EyB/jwKTXJ9mfu0cdVjYd1vlv/ZkNNi0tA=;
        b=MlnY/SkOpmYyd3Bf8jWQ08f5SAibdpHSuSUxfOIkDEBDinOdJ2pxwtvJOi9pM0J5xL
         NAsqxlBShlfdYiHpCAc5Uy7wxZRei3sBS06CjhITnHpqjszyBcsnOqtGBWZ/igxdEqQh
         /0QR7ho5ojc8AXKGMU/8olnXqVDScXixupKL3T/yyoNnNSN/hxgwLgiD8o3l9gKcumSu
         yjT/x5oDeoK8nLzoH9PlpTUtfR+05Whe3pSSCzSJQE+veGYpZ4J7JO9hapRye0Z/TVqf
         Bi/e0GGQar3MQP+j04e0JUj0b8MmSxJM5eLW2qEN0vLmPBV+ddrwYuefQIFzmGWHLMep
         riIw==
X-Gm-Message-State: AOJu0YxUgn37Y6FOWvzs719u8cRP/foFWPg6kr/1V71c9m5J7PkDNyNA
	Z0MoqBn6EyMwQL9eA1P6T+yVkyor6rRKcZufKhDrn4c9C3vwETMHACmH
X-Gm-Gg: ATEYQzyWAH1Xr9xvBILnNhhRaLlgQnI5PWIdyWly3Sew6dYHNzK/t0lN83HuPwwZP4i
	0ltEn34MTQ9bLB/0E1t0AzdrndmPkZJ2B3tH/6fjR1ET4krKrF+yALkhf9ExJogkGa/ujm2Rm7B
	jQnXcMBRJagiQQH/10IsUveaKRHiVfTGi001z6bYTOcpqWG5eI3+YynPqnX3CV2B9T8isLNfuTg
	gBXeuKzdfbyVWxfOExSyzENI2paAK1jhLmjrVbyXd+XzHVax5nMMCCeNcC8P21Kwxn82RqhhFSZ
	wabb/fB1yyEH74yPwcCVCLsUNqerseQ9OvUwPFuPhVPPMwncQq1s6q9Fji34lTnRFUuTCtxVD77
	DJYxNzWXNh89CS3PWBRTN7yObLB3hDMf+FO5EQRuefn+FmyCBaTbTEbXBKunv2z9e+dOUi5tzSa
	CCYl8Z8fom2w4uCjbLxSZU92ZR9YaVLUZlmbViu8Vj3HjLbXss9qvrcIi/xU1Uqisww5tfwYDnq
	UJ0PQl/Fp1xdDQ=
X-Received: by 2002:a05:690c:9a0f:b0:79a:3edf:a049 with SMTP id 00721157ae682-79a718c84d0mr64907737b3.24.1773926986274;
        Thu, 19 Mar 2026 06:29:46 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a8d9784e0sm1778177b3.13.2026.03.19.06.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:29:45 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:29:44 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "(JC), Jayachandran" <j-rameshbabu@ti.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Danish Anwar <danishanwar@ti.com>, 
 Daolin Qiu <d-qiu@ti.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Felix Maurer <fmaurer@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Simon Horman <horms@kernel.org>
Message-ID: <willemdebruijn.kernel.17068ce38efa5@gmail.com>
In-Reply-To: <20260317172906.eG2LxlZ7@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
 <20260310105544.EVXIekwG@linutronix.de>
 <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific handling
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269446-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.015];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 165662CBFFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> On 2026-03-16 16:12:41 [-0400], Willem de Bruijn wrote:
> > > The suggested changes to af_packet, that remains a hard no?
> > 
> > Yes. Packet sockets are largely superseded by XDP and AF_XDP when it
> > comes to new functionality. And were never open for such protocol
> > specific logic.
> 
> ptp4l uses AF_PACKET and while I am not against AF_XDP I am not sure if
> it helps. I don't have any protocol stack so extending SOL_PACKET was
> the only option left.
> 
> > Protocol independent extensions, such as reading skb->mark as part of
> > extended auxdata, could be up for debate. But again, we already have
> > XDP and AF_XDP which allow passing arbitrary metadata to/from
> > userspace. That is preferable over adding new structs to the ABI.
> 
> Is this struct xsk_tx_metadata and something similar for RX? If so, I
> would require HSR fields for both.
> My understanding is that you bind XDP to device+queue. I would require
> four sockets (generic+event for both slaves) so this does not work,
> right? Also I would need to extend HSR stack so support XDP in a similar
> fashion as network driver do?
> 
> > If you only want to attach to a single (hsr0) device, I still think
> > passing the data inline might work. Either by overriding existing
> > fields such as a MAC addr (a hack for sure) or something in the HSR
> > header (it as the direction? or by inserting a custom header (or
> > trailer) akin to virtio_net_hdr for tun/tap. But custom to your
> > workload.
> 
> But here you have PACKET_VNET_HDR_SZ to configure virtio_net_hdr. 

I mean an implicit header in the packet. virtio_net_hdr is something
that the packet socket needs to inspect. The metadata between ptp4l
and hsr_dev_xmit is not, so the packet socket can be oblivious to it.

> This
> is kind of what I ask for with PACKET_HSR_INFO + PACKET_HSR_BIND_PORT
> (and I added static branches so nobody has to suffer with CONFIG_HSR
> enabled but no HSR enabled socket)..
> 
> The diff below would be what means to bypass AF_PACKET entirely and use
> eth0/ eth1 to send via SLAVE_A/ B and hsr0 with SO_MARK to send with
> system's HSR header but only on one of the two ports.
> With HSR-offloading enabled we need to attach the SO_MARK hints also on
> eth0/ eth1 devices, too. Otherwise the offloading part will send the
> packet on both ports and attach a header (as designed).

eth0/eth1 are not HSR devices, so how would they interpret skb->mark
and how would they loop packets to the other port?

> 
> Now I have now 8 sockets in userland instead of 4.
> I added icssg to show the offloading case:
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 79df641b4fb97..a2e50cae01686 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -909,13 +909,17 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>  	 */
>  	dst_tag_id = emac->port_id | (q_idx << 8);
>  
> -	if (prueth->is_hsr_offload_mode &&
> -	    (ndev->features & NETIF_F_HW_HSR_DUP))
> -		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
> +	if (prueth->is_hsr_offload_mode) {
> +		bool has_header;
> +		bool has_port;
>  
> -	if (prueth->is_hsr_offload_mode &&
> -	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
> -		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
> +		hsr_skb_get_header_port_mark(skb, &has_header, &has_port);
> +		if (ndev->features & NETIF_F_HW_HSR_DUP && !has_port)
> +			dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
> +
> +		if (ndev->features & NETIF_F_HW_HSR_TAG_INS && !has_header)
> +			epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
> +	}
>  
>  	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index d7941fd880329..814b30f65f102 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -22,6 +22,11 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  
> +struct hsr_ptp_cb {
> +	u8	ptp;
> +	u8	port;
> +};
> +
>  /* HSR Tag.
>   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
>   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
> @@ -43,6 +48,57 @@ extern bool is_hsr_master(struct net_device *dev);
>  extern int hsr_get_version(struct net_device *dev, enum hsr_version *ver);
>  struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  				     enum hsr_port_type pt);
> +
> +static inline unsigned int hsr_skb_get_TX_port(struct sk_buff *skb)
> +{
> +	struct hsr_ptp_cb *cb;
> +
> +	if (!skb)
> +		return 0;
> +
> +	cb = (struct hsr_ptp_cb*)skb->cb;
> +	if (!cb->ptp)
> +		return 0;
> +	return cb->port;
> +}
> +
> +static inline void hsr_skb_set_TX_port(struct sk_buff *skb,
> +				       enum hsr_port_type port)
> +{
> +	struct hsr_ptp_cb *cb;
> +
> +	cb = (struct hsr_ptp_cb*)skb->cb;
> +	cb->ptp = 1;
> +	cb->port = port;
> +}
> +
> +static inline void hsr_skb_non_ptp(struct sk_buff *skb)
> +{
> +	struct hsr_ptp_cb *cb;
> +
> +	cb = (struct hsr_ptp_cb*)skb->cb;
> +	cb->ptp = 0;
> +}
> +
> +static inline void hsr_skb_get_header_port_mark(struct sk_buff *skb, bool *has_header,
> +						bool *has_port)
> +{
> +	u32 mark = skb->mark;
> +	u32 val;
> +
> +	val = mark & 0b11;
> +	if (val == 1 || val == 2)
> +		*has_port = true;
> +	else
> +		*has_port = false;
> +
> +	val = mark & 0b100;
> +	if (val)
> +		*has_header = true;
> +	else
> +		*has_header = false;
> +}
> +
>  #else
>  static inline bool is_hsr_master(struct net_device *dev)
>  {
> @@ -59,6 +115,13 @@ static inline struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  {
>  	return ERR_PTR(-EINVAL);
>  }
> +
> +static inline void hsr_skb_get_header_port_mark(struct sk_buff *skb, bool *has_header,
> +						bool *has_port)
> +{
> +	*has_port = false;
> +	*has_header = false;
> +}
>  #endif /* CONFIG_HSR */
>  
>  #endif /*_LINUX_IF_HSR_H_*/
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 2c43776b7c4fb..e01d3a33ac941 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -229,6 +229,14 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>  	if (master) {
>  		skb->dev = master->dev;
> +
> +		if (skb->mark == 1)
> +			hsr_skb_set_TX_port(skb, HSR_PT_SLAVE_A);
> +		else if (skb->mark == 2)
> +			hsr_skb_set_TX_port(skb, HSR_PT_SLAVE_B);
> +		else
> +			hsr_skb_non_ptp(skb);
> +
>  		skb_reset_mac_header(skb);
>  		skb_reset_mac_len(skb);
>  		spin_lock_bh(&hsr->seqnr_lock);
> @@ -355,6 +363,7 @@ static void send_hsr_supervision_frame(struct hsr_port *port,
>  		return;
>  	}
>  
> +	hsr_skb_non_ptp(skb);
>  	hsr_forward_skb(skb, port);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
> @@ -396,6 +405,7 @@ static void send_prp_supervision_frame(struct hsr_port *master,
>  		return;
>  	}
>  
> +	hsr_skb_non_ptp(skb);
>  	hsr_forward_skb(skb, master);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  }
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index c67c0d35921de..d0d6a8342bb33 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -12,6 +12,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/etherdevice.h>
>  #include <linux/if_vlan.h>
> +#include <net/sock.h>
>  #include "hsr_main.h"
>  #include "hsr_framereg.h"
>  
> @@ -333,7 +334,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  		hsr_set_path_id(hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
>  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
> +		skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +		if (hsr_skb_get_TX_port(skb))
> +			skb_set_owner_w(skb, frame->skb_std->sk);
> +		return skb;
>  	}
>  
>  	/* Create the new skb with enough headroom to fit the HSR tag */
> @@ -355,6 +359,15 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
>  	memmove(dst, src, movelen);
>  	skb_reset_mac_header(skb);
>  
> +	if (hsr_skb_get_TX_port(skb)) {
> +		/* Packets are bound to a port and the sender may expect time
> +		 * information.
> +		 */
> +		skb_shinfo(skb)->tx_flags = skb_shinfo(frame->skb_std)->tx_flags;
> +		skb_shinfo(skb)->tskey = skb_shinfo(frame->skb_std)->tskey;
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +	}
> +
>  	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
>  	 * that case
>  	 */
> @@ -377,12 +390,23 @@ struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
>  		}
>  		return skb_clone(frame->skb_prp, GFP_ATOMIC);
>  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
> +		skb = skb_clone(frame->skb_std, GFP_ATOMIC);
> +		if (hsr_skb_get_TX_port(skb))
> +			skb_set_owner_w(skb, frame->skb_std->sk);
> +		return skb;
>  	}
>  
>  	skb = skb_copy_expand(frame->skb_std, skb_headroom(frame->skb_std),
>  			      skb_tailroom(frame->skb_std) + HSR_HLEN,
>  			      GFP_ATOMIC);
> +	if (hsr_skb_get_TX_port(skb)) {
> +		/* Packets are bound to a port and the sender may expect time
> +		 * information.
> +		 */
> +		skb_shinfo(skb)->tx_flags = skb_shinfo(frame->skb_std)->tx_flags;
> +		skb_shinfo(skb)->tskey = skb_shinfo(frame->skb_std)->tskey;
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +	}
>  	return prp_fill_rct(skb, frame, port);
>  }
>  
> @@ -508,10 +532,13 @@ bool hsr_drop_frame(struct hsr_frame_info *frame, struct hsr_port *port)
>   */
>  static void hsr_forward_do(struct hsr_frame_info *frame)
>  {
> +	unsigned int req_tx_port;
>  	struct hsr_port *port;
>  	struct sk_buff *skb;
>  	bool sent = false;
>  
> +	req_tx_port = hsr_skb_get_TX_port(frame->skb_std);
> +
>  	hsr_for_each_port(frame->port_rcv->hsr, port) {
>  		struct hsr_priv *hsr = port->hsr;
>  		/* Don't send frame back the way it came */
> @@ -532,6 +559,16 @@ static void hsr_forward_do(struct hsr_frame_info *frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  
> +		/* RX PTP packets have the received port recorded */
> +		if (frame->skb_hsr)
> +			skb = frame->skb_hsr;
> +		else if (frame->skb_prp)
> +			skb = frame->skb_prp;
> +
> +		/* PTP TX packets have an outgoing port specified */
> +		if (req_tx_port != HSR_PT_NONE && req_tx_port != port->type)
> +			continue;
> +
>  		/* Don't send frame over port where it has been sent before.
>  		 * Also for SAN, this shouldn't be done.
>  		 */
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index 464f683e016db..f4879d1ee8ab6 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -44,8 +44,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  
>  	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
>  		/* Directly kill frames sent by ourselves */
> -		kfree_skb(skb);
> -		goto finish_consume;
> +		goto finish_free_consume;
>  	}
>  
>  	/* For HSR, only tagged frames are expected (unless the device offloads
> @@ -70,15 +69,36 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
>  	/* Only the frames received over the interlink port will assign a
>  	 * sequence number and require synchronisation vs other sender.
>  	 */
> +	hsr_skb_non_ptp(skb);
>  	if (port->type == HSR_PT_INTERLINK) {
>  		spin_lock_bh(&hsr->seqnr_lock);
>  		hsr_forward_skb(skb, port);
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
> +		struct hsr_ethhdr *hsr_ethhdr;
> +
> +		/* PTP packets are not supposed to be forwarded via HSR/ PRP
> +		 * as-is. The latency introduced by forwarding renders
> +		 * the time information useless.
> +		 */
> +		if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
> +		    protocol == htons(ETH_P_HSR)) {
> +			/* HSR */
> +			hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> +			if (hsr_ethhdr->hsr_tag.encap_proto == htons(ETH_P_1588))
> +				goto finish_free_consume;
> +		} else {
> +			if (protocol == htons(ETH_P_1588))
> +				goto finish_free_consume;
> +		}
> +
>  		hsr_forward_skb(skb, port);
>  	}
>  
> -finish_consume:
> +	return RX_HANDLER_CONSUMED;
> +
> +finish_free_consume:
> +	kfree_skb(skb);
>  	return RX_HANDLER_CONSUMED;
>  
>  finish_pass:
> 
> Sebastian



