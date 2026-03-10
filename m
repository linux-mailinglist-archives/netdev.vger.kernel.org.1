Return-Path: <netdev+bounces-265843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIeAER92r2msZgIAu9opvQ
	(envelope-from <netdev+bounces-265843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:38:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B1243B1F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 02:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 204473088633
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91065283C93;
	Tue, 10 Mar 2026 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4fbgMCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE96825C802
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773106716; cv=none; b=tAJSnfDP7oAY+9VA3ip0A6Mj8Ya3dueNf9CKSGb2DRvMdEL5kYMj8ykJwrSSNs7JhiLrCjLYylke89eOPkLr0qnjNFTtqp+GCpWC4gpWScyZaaUkebxQ3iMeHdXWayDyCVOL4nf2szISQelTRxTwLqhqHycwn/WFtDx5R5sQwXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773106716; c=relaxed/simple;
	bh=NMKVgPEqPC3Ke8et+2T6/hZtMl1Lch5KsaW/V5zHyVA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iPVgSuOzyguPBwiuzPkrdoi2QMNXxwSdJLOvXCJ+HOx+jMQdU01NZEaf7Pu89FAScn/KH8ApOpp18jkYIbnOGzpVZ2hZmMw5VfgYaiTsrtwRyHC7PsJkCBd+xFNG7i2GQJI7yWlkzl6qc3Tr1KfZo9yNuyVKP8icB4vdndZfrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4fbgMCb; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64aedd812baso11043136d50.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 18:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773106714; x=1773711514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWfGkgWHIHm1kmaE6k3RnPsDX8IM4IAZCfxijJzQ89M=;
        b=T4fbgMCbog+WDrAxxPssSHlPD3rlS7zy0Q6x0LaZORcyJV7WR4i3qw36gI1XkL3zMD
         gUEhKrZTIf/6j6iKKl5fKi8vkGahAYCc5drjrryUl02jLtox+hZo1Wtq+IkGaCvcRwrq
         DbnS/LGrCMDdoQJisqa8lfZ5rX057G7Yk5mSE+cH6zqweTAr882G2S2kJhZ7qogD8S7o
         JbqSS6UA/MTyEExUc2hGLSrBNYq8cQCdw9eB+I1XgieGrvwnTFqzFJ1L6BhC3gXpUpmK
         3m/gTe6HOglT66TgHh4myMf4IB7jhsGrYcWMJJ/fDq3XiDX0uBPB5h5q22B9nZsqTXqL
         P2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773106714; x=1773711514;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NWfGkgWHIHm1kmaE6k3RnPsDX8IM4IAZCfxijJzQ89M=;
        b=dTlPQNI6e9k150frSjWlFQ4WrG4qHrwfcls/IxHHzuhsH94kgJfPSOPfFBjyPI2INb
         i9nccKITGQixqrkXWT2OJldiwQ1RPCkpsgxR736iku5HVuaFxoK7KRPz+/XrPYwVdvEx
         K8d35GGjNeu+h4wC8+4Ddxf3molF+dkeLUO5DtbbewbQuKQ+0xv7+OMe7hlsbfhX987Y
         D5kMHynkWt6sG3sLqGMHhpPxzH4PB6VCNvRfAC/zcWdJxgkUbDwS3hsGgFYFLDEazljg
         fMfyA1hYBieInxclD613DZx9s06kcyxiDj97tbjEUxl3sioN2hZvvEDBjDWruGGyR6Uz
         PqGw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAoJLmvKgWZGrj9/fqCVfbz9nxVeJKBqgevnor7CuLdFNdPRxDGP8wKTGaLV0GGrS4b+ZSoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEcJ5LXP3RqEFWa+9eMe4E5HCoMOtEeYEGMUxxlex+tUumu99s
	haBCUYWf3smX+/fYTmSimCDxAmzfNAVX/litTLA/LQ9+9zlEEbLpvrVeWFckOA==
X-Gm-Gg: ATEYQzyfv/cRBPGRYoZd8hfbIxD1a4YkA6TFlpf55/irxNHeZBvx50aAd/rvAW1Iv72
	Promz16Py04tt82UCtnbwGp1exbLEgYpuIIR7/67Yj7w23wV/2Kkr1JeWEIwbbnsshXHDxRuqC+
	3itpXjsRJI+PNXUPjJ7x0u6F3iLFUH3r+Cw23UhJpRuReyb7etAOtc4bbucqZK4jho9u/A3lMgk
	KceXI2HFlKa/z/gmWviPkngQJGoCi+XelOX1mwhChVbjHxFMNfL8uv9+NQ2PIA0qMHCjr6XRRW7
	GZOa2c3ZN6IGc8D/osH76fQAs08JX79KZauzAbty3WNpz+yzqP7ZnvnQI8hQ1Y7yM7EARbGmjnI
	Hh2DhKD9/5bQxk/T6+Y15a0h/5R4AhCn/JaM8qmbS9nsyvqr8YpbCxseRM+19n64NYZbgb8zHuu
	URMMGTNWdWKmnwXhLpk8+tNduOCEYUS1oeIISj88x81cVy0d2JXpxsHaM3j1ecwLVfJBtobwM/M
	KBN
X-Received: by 2002:a53:ecda:0:b0:64a:d4ca:4ed9 with SMTP id 956f58d0204a3-64d1439f4afmr10392346d50.83.1773106713903;
        Mon, 09 Mar 2026 18:38:33 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64d175d32cdsm5686121d50.2.2026.03.09.18.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 18:38:33 -0700 (PDT)
Date: Mon, 09 Mar 2026 21:38:33 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
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
 Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
In-Reply-To: <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
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
X-Rspamd-Queue-Id: 9F2B1243B1F
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
	TAGGED_FROM(0.00)[bounces-265843-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> linuxptp/ ptp4l uses a AF_PACKET with a RAW socket to send and receive
> PTP packets. Extend the interface with the ability to bind the socket to
> one of the two HSR ports and a flag for sendmsg() to indicate that the
> packet already contains a HSR header.

The same point about adding per protocol state to sk_buff applies
to a slightly lesser extent to PF_PACKET.

Adding this much HSR + PTP specific code there is a non-starter.

I should have said this in v1. This likely makes my skb_extensions
suggestion a non-starter sorry.

We need to find a different way to

Rx: get the port info from the slave device to userspace.
Tx: send out the intended slave device.

Let's separate the two challenges (and patches).

On Rx, could your process just attach the PF_PACKET socket to the
slave devices and filter on HSR PTP packets? Then separately drop
these packets in hsr_handle_frame (as already done?) or TC ingress, so
that they only arrive in userspace?

On Tx, can you share a bit more why there are two cases, one where the
master has to add the header, but also one where it does not (so
userspace has presumably inserted it).

The second case is simpler: can just write directly the whole packet
to the intended slave device.

For the first case, could skb->mark be used as port selector when
writing from a packet socket to the master device? That already works
with sock_cmsg_send.

> Once PACKET_HSR_BIND_PORT is set, the socket will be bound to requested
> slave port. All incoming packets without a set port will be discarded.
> This limits receiving packet to PTP only packets since only those get
> the tagging by the HSR stack.
> 
> For the control message used by sendmsg(), type PACKET_HSR_INFO is added
> with PACKET_HSR_INFO_HAS_HDR as the only option. If this is used, the
> skb will be known as containing the HSR header. This option can only be
> used if the socket is bound to a specific HSR port.
> 
> To lower the impact for non-PTP-HSR/PRP user, a static branch is used to
> to avoid a compare & branch if the socket was not bound to a hsr-slave
> device. If CONFIG_HSR is not set, the compiler will be smart enough to
> remove the code entirely (keeping only PACKET_HSR_BIND_PORT for
> getsockopt()).
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/uapi/linux/if_packet.h |   9 +++
>  net/packet/af_packet.c         | 167 +++++++++++++++++++++++++++++++++++++++++
>  net/packet/internal.h          |   1 +
>  3 files changed, 177 insertions(+)
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
> index 72d0935139f0f..98322ad57a234 100644
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
> @@ -284,6 +285,94 @@ static int packet_xmit(const struct packet_sock *po, struct sk_buff *skb)
>  	return dev_direct_xmit(skb, packet_pick_tx_queue(skb));
>  }
>  
> +#if IS_ENABLED(CONFIG_HSR)
> +
> +static DEFINE_STATIC_KEY_FALSE(hsr_ptp_support_enabled);
> +
> +static inline bool packet_add_ptp_settings(struct sk_buff *skb,
> +					   bool header, unsigned int port)
> +{
> +	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
> +		return true;
> +
> +	if (!port)
> +		return true;
> +
> +	return hsr_skb_add_header_port(skb, header, port);
> +}
> +
> +static inline bool packet_filter_hsr_port(struct packet_sock *po, struct sk_buff *skb)
> +{
> +	unsigned int req_port;
> +	bool req_hdr;
> +
> +	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
> +		return false;
> +
> +	if (!po->hsr_bound_port)
> +		return false;
> +
> +	if (!hsr_skb_get_header_port(skb, &req_hdr, &req_port))
> +		return true;
> +
> +	if (req_port == po->hsr_bound_port)
> +		return false;
> +	return true;
> +}
> +
> +static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
> +			    bool *hsr_has_hdr)
> +{
> +	struct cmsghdr *cmsg;
> +	int ret = -EINVAL;
> +	u32 val;
> +
> +	if (!static_branch_unlikely(&hsr_ptp_support_enabled))
> +		return 0;
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
> +		*hsr_has_hdr = true;
> +	}
> +	ret = 0;
> +out:
> +	return ret;
> +}
> +
> +#else
> +
> +static bool packet_add_ptp_settings(struct sk_buff *skb,
> +				    bool header, unsigned int port)
> +{
> +	return true;
> +}
> +
> +static bool packet_filter_hsr_port(struct packet_sock *po, struct sk_buff *skb)
> +{
> +	return false;
> +}
> +
> +static int packet_cmsg_send(struct msghdr *msg, struct packet_sock *po,
> +			    bool *hsr_has_hdr)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static struct net_device *packet_cached_dev_get(struct packet_sock *po)
>  {
>  	struct net_device *dev;
> @@ -2131,6 +2220,9 @@ static int packet_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		goto drop;
>  
> +	if (packet_filter_hsr_port(po, skb))
> +		goto drop;
> +
>  	skb->dev = dev;
>  
>  	if (dev_has_header(dev)) {
> @@ -2260,6 +2352,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (!net_eq(dev_net(dev), sock_net(sk)))
>  		goto drop;
>  
> +	if (packet_filter_hsr_port(po, skb))
> +		goto drop;
> +
>  	if (dev_has_header(dev)) {
>  		if (sk->sk_type != SOCK_DGRAM)
>  			skb_push(skb, skb->data - skb_mac_header(skb));
> @@ -2731,6 +2826,7 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  	int len_sum = 0;
>  	int status = TP_STATUS_AVAILABLE;
>  	int hlen, tlen, copylen = 0;
> +	bool hsr_has_hdr = false;
>  	long timeo;
>  
>  	mutex_lock(&po->pg_vec_lock);
> @@ -2775,6 +2871,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  		err = sock_cmsg_send(&po->sk, msg, &sockc);
>  		if (unlikely(err))
>  			goto out_put;
> +
> +		err = packet_cmsg_send(msg, po, &hsr_has_hdr);
> +		if (unlikely(err))
> +			goto out_put;
>  	}
>  
>  	if (po->sk.sk_socket->type == SOCK_RAW)
> @@ -2863,6 +2963,10 @@ static int tpacket_snd(struct packet_sock *po, struct msghdr *msg)
>  				goto out_status;
>  			}
>  		}
> +		if (!packet_add_ptp_settings(skb, hsr_has_hdr, po->hsr_bound_port)) {
> +			err = -ENOMEM;
> +			goto out_status;
> +		}
>  
>  		if (vnet_hdr_sz) {
>  			if (virtio_net_hdr_to_skb(skb, vnet_hdr, vio_le())) {
> @@ -2950,6 +3054,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	int offset = 0;
>  	struct packet_sock *po = pkt_sk(sk);
>  	int vnet_hdr_sz = READ_ONCE(po->vnet_hdr_sz);
> +	bool hsr_has_hdr = false;
>  	int hlen, tlen, linear;
>  	int extra_len = 0;
>  
> @@ -2988,6 +3093,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  		err = sock_cmsg_send(sk, msg, &sockc);
>  		if (unlikely(err))
>  			goto out_unlock;
> +
> +		err = packet_cmsg_send(msg, po, &hsr_has_hdr);
> +		if (unlikely(err))
> +			goto out_unlock;
>  	}
>  
>  	if (sock->type == SOCK_RAW)
> @@ -3047,6 +3156,10 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>  	}
>  
>  	skb_setup_tx_timestamp(skb, &sockc);
> +	if (!packet_add_ptp_settings(skb, hsr_has_hdr, po->hsr_bound_port)) {
> +		err = -ENOMEM;
> +		goto out_free;
> +	}
>  
>  	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
>  	    !packet_extra_vlan_len_allowed(dev, skb)) {
> @@ -3166,6 +3279,11 @@ static int packet_release(struct socket *sock)
>  		fanout_release_data(f);
>  		kvfree(f);
>  	}
> +
> +#if IS_ENABLED(CONFIG_HSR)
> +	if (po->hsr_bound_port)
> +		static_branch_dec(&hsr_ptp_support_enabled);
> +#endif
>  	/*
>  	 *	Now the socket is dead. No more input will appear.
>  	 */
> @@ -4044,6 +4162,40 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
>  		packet_sock_flag_set(po, PACKET_SOCK_QDISC_BYPASS, val);
>  		return 0;
>  	}
> +	case PACKET_HSR_BIND_PORT:
> +	{
> +#if IS_ENABLED(CONFIG_HSR)
> +		int old_val;
> +		int val;
> +
> +		if (optlen != sizeof(val))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&val, optval, sizeof(val)))
> +			return -EFAULT;
> +
> +		old_val = !!po->hsr_bound_port;
> +		switch (val) {
> +		case PACKET_HSR_BIND_PORT_AB:
> +			po->hsr_bound_port = 0;
> +			break;
> +		case PACKET_HSR_BIND_PORT_A:
> +			po->hsr_bound_port = HSR_PT_SLAVE_A;
> +			break;
> +		case PACKET_HSR_BIND_PORT_B:
> +			po->hsr_bound_port = HSR_PT_SLAVE_B;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (old_val != !!po->hsr_bound_port) {
> +			if (po->hsr_bound_port)
> +				static_branch_inc(&hsr_ptp_support_enabled);
> +			else
> +				static_branch_dec(&hsr_ptp_support_enabled);
> +		}
> +		return 0;
> +#endif
> +	}
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> @@ -4164,6 +4316,21 @@ static int packet_getsockopt(struct socket *sock, int level, int optname,
>  	case PACKET_QDISC_BYPASS:
>  		val = packet_sock_flag(po, PACKET_SOCK_QDISC_BYPASS);
>  		break;
> +	case PACKET_HSR_BIND_PORT:
> +		switch (po->hsr_bound_port) {
> +		case 0:
> +			val = PACKET_HSR_BIND_PORT_AB;
> +			break;
> +		case HSR_PT_SLAVE_A:
> +			val = PACKET_HSR_BIND_PORT_A;
> +			break;
> +		case HSR_PT_SLAVE_B:
> +			val = PACKET_HSR_BIND_PORT_B;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
>  	default:
>  		return -ENOPROTOOPT;
>  	}
> diff --git a/net/packet/internal.h b/net/packet/internal.h
> index b76e645cd78d1..24d63275d432f 100644
> --- a/net/packet/internal.h
> +++ b/net/packet/internal.h
> @@ -114,6 +114,7 @@ struct packet_sock {
>  	unsigned long		flags;
>  	int			ifindex;	/* bound device		*/
>  	u8			vnet_hdr_sz;
> +	u8			hsr_bound_port;
>  	__be16			num;
>  	struct packet_rollover	*rollover;
>  	struct packet_mclist	*mclist;
> 
> -- 
> 2.53.0
> 



