Return-Path: <netdev+bounces-293223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAmgG+rvGWoX0AgAu9opvQ
	(envelope-from <netdev+bounces-293223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:58:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0122D608236
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051DA30138A1
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714063A9D8B;
	Fri, 29 May 2026 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UycYLKvO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1955C357739
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 19:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084712; cv=none; b=NPL7Fz/vNgvc+tBpeqLUVIlhFdWoxVtzY38Cp7ueyTW0xSUnVaWdGOu271Xnr/POmGpTLsjGJPZ0exwFU++qHyOD+djDYkKdH24vK57p2SBKqdHkNJvBryc3ME9ov7fhaOJh18GENBgsGbL6p8NKYlQ2srzwvR4KzcTBRoeOa34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084712; c=relaxed/simple;
	bh=z9DUmc2ukOgVnwCFOA3uFc2l31BlNVRBsbjOBHDG7iA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TCIeHgtJGkb7qeOSPKJ8xWlHbAiTC+dQxPqbl8h9ZnrixFzrfpDy+d/SR36eQA2949JwDWfrBRqgUDiusQw38nOQs7I3tSJMWLlQ/UmujbnMvGE8opWHQaFunA+1QLe0RIOx9ZmcmtQlcW+FYURpxLXiL/wYKSf2iOD7Q+oFTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UycYLKvO; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so14961673d50.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780084710; x=1780689510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8ATeVuBOVR89vX0+Pwzh1VVYH32NG0Skle7Xdxhuqc=;
        b=UycYLKvOC6o2RaUeWyGN9ivIubfpUT5cdfAAlfSqYQQupHVOF2J3ul8mBA+NQamak+
         hvgnO4UxtXRRAQD86GmgKtx8H+rehMfl2d7A9ZQPcHR4LljqExOd9CYGACSUzLl/6RQy
         dwCoSI0WWtZtR0ZGFxx2AoBW+uLdwHRQQpI/8HSbyhkYeampZ9a2kiwbTjBtisOLD4tt
         ciZbvGo9DlNwFEKfxF3RSNKNVpT4FgxM4Pa/njuce7OKv8p94SXbcvU8qhJ3UQAzz0ZF
         SnC4I8/CJ6NszkH3b7T81AWiqWGfuwoCy6PRk6syPzjdZ0b91BNtIZZod9YHgpacBsGg
         ri6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084710; x=1780689510;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8ATeVuBOVR89vX0+Pwzh1VVYH32NG0Skle7Xdxhuqc=;
        b=Dvd+M7Z4V2MlevToqe89trigTSIE4IoqYu7W63lUmvW8alhxpWuXD+nFTccxyNOxAZ
         5GeNcOn639nCTT6IttSLRf6kTxVrtYq2D6pEzQcFT5Ng70jwssbpOSYydKzzFlvvy5JS
         uOQyVi/ei9RRm02wco0/7JqSiSA1IWo1oEUaURGsrRUCWlADl5JwZ6gx7dCY0rWZWCVt
         CA1IGXoP+Cd4BjZRShhHNUMUbbFTn7j9PT6nhxEb/OoSx+7RDThIqc6u1cAPvqlEhaCB
         V7brhRr2zvTzqKgn6GwGdVPkiVb1inxOE3uf7Ot2aVS7icW3Hxcs1otHHZaRKzJO88l3
         zv7A==
X-Forwarded-Encrypted: i=1; AFNElJ/G1Oy1jiiFocUsDIVwfEaUW6mbOUhpIjCr5QKKYR/k6VNWLa4O9MLnokKJILk5aBcdeI1buLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Z84sg4hGNoeodiFE+0s0WGamsYtJ9am0Q3j5fpOzS4qAShPm
	SX0PQnnv0ISC1Oa+FS98IQffZIlVv7yvBkqGJktKoUvTf3BeCILdv+6U
X-Gm-Gg: Acq92OF8wSHZJ2Va1A9rofOJ6g7alZyyqymmAvdTXPVMIdU2lV5R2fRYkkOt8JGOGoD
	Vmya4PwmB28jDtWX3HPgn5tIncnIJ6X/6SJdt3l61NICAIpZzfGU75RgalfrfBryc4MscCxIJTz
	WzxhTAiIxXYOTggrUfHXE05nQE1weCd84aJrJw8nfFFsFQwZ2tis7AffFt3R+OYgSGydtTYW1hD
	mLmodL3WVL9SVk3YXVf4agjTZKPC0Ci1GS1IG6NCjXLnro9cCnVhnPOpCOsOKd9d6LBrUBtD4Lq
	xwB143eZH3NmfcnAc9Ip8Apbz2VuL5uB5TYGhRCHcJ6ObmNDL42XZs8hsLXhhaQ2fdo/+93Gf1v
	z+RMkEqUo/WIydRCNhzvb3cCSl+VjZYMcxQnXaoBlo2LGFoSM+1kKMymI+E1gaPSgg3sMR4Pbu1
	AbFKekTCgmC0gw9pM5/wPkdNNuirNByzst8ZX/BMaKSAc7b0VqDWHy4CvsoCt/DRZi6lK+6cn9/
	0F9vsSWwMZVDZXVFA==
X-Received: by 2002:a53:de4b:0:b0:64c:f7d0:5c07 with SMTP id 956f58d0204a3-6605ed3bd2amr796621d50.10.1780084709684;
        Fri, 29 May 2026 12:58:29 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66053635987sm1098375d50.2.2026.05.29.12.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 12:58:29 -0700 (PDT)
Date: Fri, 29 May 2026 15:58:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
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
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.28f56d129e0b1@gmail.com>
In-Reply-To: <20260527-hsr_ptp-v5-3-158a7633eac0@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-3-158a7633eac0@linutronix.de>
Subject: Re: [PATCH net-next v5 3/8] hsr: Add a magic header for sending PTP
 packets
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293223-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0122D608236
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sebastian Andrzej Siewior wrote:
> Sending PTP packets (ETH_P_1588) via the HSR stack is pointless in its
> current shape because the requested PTP timestamp is not routed to the
> sender. It also needs to be distinguished on which port the message
> should be sent and whether or not a HSR header should be attached.
> 
> To pass this information, a custom header (struct hsr_inline_header) is
> introduced. This header is expected if the ether type is ETH_P_1588. To
> avoid any wrong usage, there is a magic field to ensure it really is the
> header.
> 
> The inline header is just prepended containing the port and header
> parameter. After the header, a regular packet follows. It is ensured that
> the inline header and the following ethernet or HSR header is linear
> and can be accessed.
> 
> The two retrieved parameters are passed to hsr_forward_skb() and will be
> used later.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/if_hsr.h | 11 +++++++++
>  net/hsr/hsr_device.c   | 61 ++++++++++++++++++++++++++++++++++++++++----------
>  net/hsr/hsr_forward.c  |  3 ++-
>  net/hsr/hsr_forward.h  |  3 ++-
>  net/hsr/hsr_slave.c    |  4 ++--
>  5 files changed, 66 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..1db1bd0fa181d 100644
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
> @@ -22,6 +23,16 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  
> +#define HSR_INLINE_HDR	0xaf485352
> +struct hsr_inline_header {
> +	uint8_t tx_port;
> +	uint8_t hsr_hdr;
> +	uint8_t __pad0[4];
> +	__be32 magic;
> +	uint8_t __pad1[2];
> +	__be16 eth_type;
> +} __packed;
> +
>  /* HSR Tag.
>   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype = 0x88FB,
>   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_dest,
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index a999ddccc46c5..797e2cf391998 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,61 @@ static netdev_features_t hsr_fix_features(struct net_device *dev,
>  
>  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> +	enum hsr_port_type tx_port = HSR_PT_NONE;
>  	struct hsr_priv *hsr = netdev_priv(dev);
>  	struct hsr_port *master;
> +	bool has_header = false;
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
> +	if (skb->protocol == htons(ETH_P_1588)) {
> +		struct hsr_inline_header *hsr_opt;
> +		unsigned int hdr_len;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> +
> +		/* need to access the magic header */
> +		if (!pskb_may_pull(skb, sizeof(struct hsr_inline_header)))
> +			goto drop;
> +
> +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> +		if (hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> +			struct ethhdr *eth_hdr;
> +
> +			has_header = hsr_opt->hsr_hdr;
> +			tx_port = hsr_opt->tx_port;
> +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> +				goto drop;
> +
> +			eth_hdr = skb_pull(skb, sizeof(struct hsr_inline_header));
> +			if (has_header)
> +				hdr_len = ETH_HLEN + HSR_HLEN;
> +			else
> +				hdr_len = ETH_HLEN;
> +			skb_set_network_header(skb, hdr_len);
> +			/* Ensure the header can be accessed */
> +			if (!pskb_may_pull(skb, hdr_len))
> +				goto drop;
> +			skb->protocol = eth_hdr->h_proto;
> +		}

Should the packet be dropped otherwise?

>  	}
> +
> +	skb_reset_mac_header(skb);
> +	skb_reset_mac_len(skb);
> +	spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, master, tx_port, has_header);
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	rcu_read_unlock();
>  
> +	return NETDEV_TX_OK;
> +drop:
> +	rcu_read_unlock();
> +	dev_core_stats_tx_dropped_inc(dev);
> +	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }

