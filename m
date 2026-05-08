Return-Path: <netdev+bounces-285939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPgTIeUe/mkRnAAAu9opvQ
	(envelope-from <netdev+bounces-285939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:35:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EDA4FA072
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B98E30209D0
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4F2C15A5;
	Fri,  8 May 2026 17:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgq07YUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34732147E6
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261651; cv=none; b=T+GkaL1dGwEtjV4TrFlasTz3abJRSeFlxS44dsonatEx9Qgpc5CtvlK7b3murNOmKDzZXfyTRJODpPEu8QYTVUWyJWc7EtA+3IzxPX8hjkJIV3oDvZG/RDjzVuTXyhU2soaFNoR/mD/A4k/Aewp5dWLGFxKEEmaXRohHqfkOPEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261651; c=relaxed/simple;
	bh=C/OHu70942WuNySLIP29u0ToF3BvH9c5KBTtNOLlyvA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MBXvAmyiSKiGH2pW/hgspQS8BYGk1+6tV/vCyxxE62fCsx3Ece9TQxc6lax5pgNzTAsNdE4jl64ff7trzPu2dlh892zw6xibKi/qNhpt3OHgKe9uAVHk9dV8vp1iNtOc7RpH0uvS4Uc45+NzcAQ5o/AdHjWb7QX1ZlN1cheqfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgq07YUU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd65714dcaso25044577b3.3
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778261648; x=1778866448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/PEjLRBGpVPbehvjLCWtyPrGthRHjTMSPaUUrv4MHs=;
        b=lgq07YUU6oV7uaMqW04SB3sGVeZ7QV+ztOgzN1ODNTK5bRH5xVJiK55LfsOKil27mF
         IBehmsanHp0KL2uFgBTMa4H2yqspbWDMZQF9aN0SV8ysjwAG+GDFMjrLcKgWRUnDH0x3
         rdQmxOz6FnCpKDo2U54eNZrN4A1Bf+m75zlqGeFCg4tLEkiObpmLSDFs1gNtMWbSx40n
         fobpqjvLRhjVDkE6Sh3LkwUtloIouD+Z0VwK/zYsJvXjkiFawhwduXCWPR7QThEkgZWe
         4ymuCUZK8jPyH4Cw7CqTv4I6Wjmgbmwfb6hCx8aiLwa3S/tou/tseYFIAUrQkgA2t8DO
         TBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778261648; x=1778866448;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4/PEjLRBGpVPbehvjLCWtyPrGthRHjTMSPaUUrv4MHs=;
        b=rpMQcdhIGoD69nTw8pr4XMiU2idnaP0ZLT0iFm1Rj1l0OKcEqXt0EvCCa6zZipRv8O
         TYvos2zljWtiKTmy83Ndzmac62WNNqtLHejbS6X0gLT2/nQxARwPihewvpdPsX9oBSQl
         dNJ6c3Xe0bwDPdAH0Fx6oVkGqeFAGd/btFYg/zJK43GIwNqKZZXtVZZEO4h6X20OdsOL
         tQE352lDdCy7/eAFZ4Bz3qS9rE3EjpSqRfeFWjTKl7sx/6iL6vPlXtxcbTLPc1STWLYt
         /s2OE/sClU62N7vBiZnYSogYPSpmpc6Sd6H6I1CSO/8SE/w8qn9xcL0IoHLowEfZ0/LX
         lCvw==
X-Forwarded-Encrypted: i=1; AFNElJ8xP8HkNhIQncXHUHqDQkSGwG5F7zMiqq7nT2wgmYt5ov11Q0a/ySRnC0BuFvkrQfB67fxMeQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRx8e5OFb/nv5LruT+MNkWjrjHb5SOZ7MP2A0FQADmNiSGL2N
	IklXpjPPv+tWkmGmi+aVxbLFcZPIBz56xSUw06F8mfhcCzNLvIRgfxcQ
X-Gm-Gg: Acq92OHztOzt77PO7QKIECEy/4cPlSnXShy9DyuhjCitmMKMt7/SfXPKXEW77zgXB8g
	1XfZRw0KwOr8Ssben6aRYR4DbKPix5jQj5Lz0umYodVL0YyK3APJKPcrurHR20ANIeOIMS4D1nl
	xjA2C1nGbyTp+IDSW5odWT3sJg1VOfatPGcX+tHcHlGICmiCVdkEw3AAD9t43/WqIrljCDTA/51
	Pz8YSN9z8vpfK6l4oBvdvIbub68wuSZx63l4dZ4uaB5qSLJfog/sTrLFNMUSbR54+SMm7Eb3dPS
	9vs9rhAFNkBvM9nFB/ly2XEVUT5de9i7XSu8zmmNpplY/o/YIy9XjkWPfDErXijhL9zplqsrtXU
	bI0CNFi9P1XP3/Ess6LyOrttN3Ty1qttUp9Iemw9qMV1rjHlaNuRC5rYDENB9GlIlL13Kfdf4SO
	LJoiSUVzRo6oHbRm1gDemTWJBPTJaK6o/LHihrJMBBy+Bi6yNJh4yQumaX1U1YKFhquA8GqCkxl
	9RrhRgCCrfj/Gw=
X-Received: by 2002:a05:690c:f14:b0:7bd:73f3:7a67 with SMTP id 00721157ae682-7bdf5e66460mr146306567b3.28.1778261647672;
        Fri, 08 May 2026 10:34:07 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66019105sm110069437b3.0.2026.05.08.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 10:34:06 -0700 (PDT)
Date: Fri, 08 May 2026 13:34:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 netdev@vger.kernel.org
Cc: Jayachandran <j-rameshbabu@ti.com>, 
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
Message-ID: <willemdebruijn.kernel.38ce4095cf2f5@gmail.com>
In-Reply-To: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
References: <20260508-hsr_ptp-v4-1-aa19aa7c6a71@linutronix.de>
Subject: Re: [PATCH net-next v4] hsr: Allow to send a specific port and with
 HSR header
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C8EDA4FA072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285939-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ti.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sebastian Andrzej Siewior wrote:
> HSR forwards all packets it received on slave port 1 to slave port 2 an=
d
> one of the two copies to the user (master) interface.
> In terms of PTP this is not good because the latency introduced by
> forwarding makes the timestamp in the PTP packet inaccurate.
> The PTP packets should not be forwarded like regular packets.
> =

> In order to work with PTP over HSR the following has been done:
> - PTP packets which are received are dropped within the HSR stack. That=

>   means they are not forwarded or injected into the master port. If the=

>   user requires them, then they need to be obtained directly from the
>   SLAVE interface.
> =

> - Sending packets. If the ethernet type of the packet is ETH_P_1588 the=
n
>   the stack assumes a header of type struct hsr_inline_header. The size=

>   of this header is the same as ethhdr. As a safeguard, the header
>   contains a magic field which matches the position of h_source and it
>   needs to match HSR_INLINE_HDR.
>   Once this is verified, the header contains the port on which this
>   packet needs to be sent and if system's HSR header should be added.
>   This information is used with the HSR stack. The packet is then
>   pulled passed the custom header so the remaining stack will see the
>   actual data.
> =

> - HSR HW offloading. The stack passes the skb to the requested port. Th=
e
>   driver needs to be aware of the mode (HSR/ PRP). In PRP mode, there
>   must be no offloading if the ether type is ETH_P_1588. In HSR mode it=

>   needs to add a HSR header for the ETH_P_1588 ether type but none if i=
t
>   is already ETH_P_HSR.
> =

> The originally submitted skb is freed and only the (altered) clone is
> submitted to the slave interface for sending. Therefore on cloning, the=

> socket and tx_flags/ tskey are copied so that the PTP timestamp is
> forwarded to the socket submitting the skb.
> =

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> I am trying to extend linuxptp to support PTP over a HSR network.
> =

> This is the kernel side of the changes. In short PTP over HSR sends its=

> packets to a multicast address and every node needs to forward the PTP
> packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
> In order to achieve this, the HSR stack must not duplicate and forward
> the PTP packets as it would do with other packets. The delay caused by
> the duplication and forwarding adds overhead which in turn makes the
> timing information within the PTP packet inaccurate.
> =

> My current approach is to open the slave devices (eth0/ eth1) from
> userland in order to receive the PTP packets. Sending happens from the
> hsr0 device. The actual packet can have an optional inline header
> prepended of type struct hsr_inline_header. The size of the header is
> equivalent to ethhdr. The header has a type (h_proto) at the same
> position as ethhdr and expects it to be ETH_P_1588 as this extra meta
> information is only relevant for PTP packets. It makes no sense to send=

> PTP packets via the HSR interface because it gets duplicated and the
> timestamp information is lost so this should not break anything. As an
> additional safe guard there is a magic value at h_source position. The
> value has '0xaf' at the most significant byte which makes the address a=

> locally administered multicast address.
> =

> The header passes two information from userland: On which slave port
> the packet has to be sent and does the HSR stack need to prepend a
> header or not.
> The header is skipped so that the remaining stack sees the actual data
> and can send it as requested.
> =

> The PRP packets are sent directly via the SLAVE interface. The standard=

> mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP=

> packets. There is not really a reason to use hsr interface.
> =

> HSR hardware offloading is optional. The driver needs to know if the
> operating mode is HSR or PRP. In PRP mode it needs to check the ether
> type and for ETH_P_1588 it must not perform any offloading.
> In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
> the ether-type is ETH_P_HSR there must be no offloading if the
> encapsulated protocol is ETH_P_1588.
> =

> This has been tested in a pure software environment and in an HW-assist=
ed
> environment where the HW is able to duplicate and duplicate packets
> but does not do it for PTP packets.
> It has not been tested within an environment where the HW is able to
> forward the PTP packet and correctly update the timing information.

It probably makes sense to integrate this with the main commit message
that is preserved in the log.

Or as a cover letter if this goes to a multi-patch series.

> ---
> v3=E2=80=A6v4: https://lore.kernel.org/r/20260429-hsr_ptp-v3-1-afbf8f20=
0f48@linutronix.de
> - Removed skb extention. The information within HSR is passed via
>   struct hsr_frame_info. Driver with HSR-offloading capabilities need t=
o
>   know the HSR mode (HSR or PRP) and parse the skb to decide what needs=

>   to be done (whether to send on both ports and if adding a header is
>   needed).
> =

> v2=E2=80=A6v3: https://patch.msgid.link/20260309-hsr_ptp-v2-0-798262aad=
3a4@linutronix.de
> - Remove af_packet changes entirely.
> - Add an internal header to pass additional information for HSR-PTP
>   packets.
> - Remove PRP, userland will use slave devices directly.
> - Drop all received PTP packets. Userland needs to use the slave device=

>   for RX.
> =

> v1=E2=80=A6v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a7=
7da@linutronix.de
> - Added PRP support
> - skb extention is used instead of extending struct skb_shared_info
> - in af_packet
>   - packet_sendmsg_spkt() is no longer extended
>   - jump labels are used to avoid the overhead if there no socket that
>     is using this HSR extension.
> ---
>  include/linux/if_hsr.h | 11 +++++++++
>  net/hsr/hsr_device.c   | 49 +++++++++++++++++++++++++++----------
>  net/hsr/hsr_forward.c  | 65 +++++++++++++++++++++++++++++++++++++++++-=
--------
>  net/hsr/hsr_forward.h  |  3 ++-
>  net/hsr/hsr_framereg.h |  2 ++
>  net/hsr/hsr_slave.c    | 37 +++++++++++++++++++++-------
>  6 files changed, 134 insertions(+), 33 deletions(-)
> =

> diff --git a/include/linux/if_hsr.h b/include/linux/if_hsr.h
> index f4cf2dd36d193..0dda83511804e 100644
> --- a/include/linux/if_hsr.h
> +++ b/include/linux/if_hsr.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_IF_HSR_H_
>  =

>  #include <linux/types.h>
> +#include <linux/skbuff.h>
>  =

>  struct net_device;
>  =

> @@ -22,6 +23,16 @@ enum hsr_port_type {
>  	HSR_PT_PORTS,	/* This must be the last item in the enum */
>  };
>  =

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
>  /* HSR Tag.
>   * As defined in IEC-62439-3:2010, the HSR tag is really { ethertype =3D=
 0x88FB,
>   * path, LSDU_size, sequence Nr }. But we let eth_header() create { h_=
dest,
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5555b71ab19b5..cab4f7c601257 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -223,24 +223,49 @@ static netdev_features_t hsr_fix_features(struct =
net_device *dev,
>  =

>  static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device=
 *dev)
>  {
> +	enum hsr_port_type tx_port =3D HSR_PT_NONE;
>  	struct hsr_priv *hsr =3D netdev_priv(dev);
>  	struct hsr_port *master;
> +	bool has_header =3D false;
>  =

>  	rcu_read_lock();
>  	master =3D hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> -	if (master) {
> -		skb->dev =3D master->dev;
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
> +	skb->dev =3D master->dev;
> +	if (skb->len > ETH_HLEN * 2) {

Try to avoid magic constants

sizeof(struct hsr_inline_header + ETH_HLEN is better self-documenting
that these are two consecutive protocol headers.

PF_PACKET sockets also choose an skb->protocol. Even if you don't use
that as the sole signal that such a header is present, you probably
want to check it and ignore (or drop) packets with a different than
the one expected value (ETH_P_1588?).

> +		struct hsr_inline_header *hsr_opt;
> +
> +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) !=3D sizeof(struct eth=
hdr));
> +		hsr_opt =3D (struct hsr_inline_header *)skb_mac_header(skb);

Need a pskb_may_pull before accessing fields?

> +		if (hsr_opt->eth_type =3D=3D htons(ETH_P_1588) &&
> +		    hsr_opt->magic =3D=3D htonl(HSR_INLINE_HDR)) {
> +			has_header =3D hsr_opt->hsr_hdr;
> +			tx_port =3D hsr_opt->tx_port;
> +			if (tx_port !=3D HSR_PT_SLAVE_A && tx_port !=3D HSR_PT_SLAVE_B)
> +				goto drop;
> +
> +			skb_pull(skb, sizeof(struct hsr_inline_header));
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
> +	hsr_forward_skb(skb, master, tx_port, has_header);
> +	spin_unlock_bh(&hsr->seqnr_lock);
>  	rcu_read_unlock();
>  =

> +	return NETDEV_TX_OK;
> +drop:
> +	rcu_read_unlock();
> +	dev_core_stats_tx_dropped_inc(dev);
> +	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }
>  =

> @@ -361,7 +386,7 @@ static void send_hsr_supervision_frame(struct hsr_p=
ort *port,
>  		return;
>  	}
>  =

> -	hsr_forward_skb(skb, port);
> +	hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  	return;
>  }
> @@ -402,7 +427,7 @@ static void send_prp_supervision_frame(struct hsr_p=
ort *master,
>  		return;
>  	}
>  =

> -	hsr_forward_skb(skb, master);
> +	hsr_forward_skb(skb, master, HSR_PT_NONE, false);
>  	spin_unlock_bh(&hsr->seqnr_lock);
>  }
>  =

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 0aca859c88cbb..7f92314934c98 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -12,6 +12,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/etherdevice.h>
>  #include <linux/if_vlan.h>
> +#include <net/sock.h>
>  #include "hsr_main.h"
>  #include "hsr_framereg.h"
>  =

> @@ -343,7 +344,10 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr=
_frame_info *frame,
>  		hsr_set_path_id(frame, hsr_ethhdr, port);
>  		return skb_clone(frame->skb_hsr, GFP_ATOMIC);
>  	} else if (port->dev->features & NETIF_F_HW_HSR_TAG_INS) {
> -		return skb_clone(frame->skb_std, GFP_ATOMIC);
> +		skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
> +		if (frame->req_tx_port !=3D HSR_PT_NONE)
> +			skb_set_owner_w(skb, frame->skb_std->sk);

How is this related to the rest of the patch?
> +		return skb;
>  	}
>  =

>  	/* Create the new skb with enough headroom to fit the HSR tag */
> @@ -365,6 +369,15 @@ struct sk_buff *hsr_create_tagged_frame(struct hsr=
_frame_info *frame,
>  	memmove(dst, src, movelen);
>  	skb_reset_mac_header(skb);
>  =

> +	if (frame->req_tx_port !=3D HSR_PT_NONE) {
> +		/* Packets are bound to a port and the sender may expect time
> +		 * information.
> +		 */
> +		skb_shinfo(skb)->tx_flags =3D skb_shinfo(frame->skb_std)->tx_flags;
> +		skb_shinfo(skb)->tskey =3D skb_shinfo(frame->skb_std)->tskey;
> +		skb_set_owner_w(skb, frame->skb_std->sk);
> +	}
> +
>  	/* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
>  	 * that case
>  	 */
> @@ -420,7 +433,7 @@ static void hsr_deliver_master(struct sk_buff *skb,=
 struct net_device *dev,
>  static int hsr_xmit(struct sk_buff *skb, struct hsr_port *port,
>  		    struct hsr_frame_info *frame)
>  {
> -	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER) {
> +	if (frame->port_rcv->type =3D=3D HSR_PT_MASTER && !frame->has_foreign=
_header) {
>  		hsr_addr_subst_dest(frame->node_src, skb, port);
>  =

>  		/* Address substitution (IEC62439-3 pp 26, 50): replace mac
> @@ -519,11 +532,12 @@ bool hsr_drop_frame(struct hsr_frame_info *frame,=
 struct hsr_port *port)
>  static void hsr_forward_do(struct hsr_frame_info *frame)
>  {
>  	struct hsr_port *port;
> -	struct sk_buff *skb;
>  	bool sent =3D false;
>  =

>  	hsr_for_each_port(frame->port_rcv->hsr, port) {
>  		struct hsr_priv *hsr =3D port->hsr;
> +		struct sk_buff *skb =3D NULL;
> +
>  		/* Don't send frame back the way it came */
>  		if (port =3D=3D frame->port_rcv)
>  			continue;
> @@ -542,6 +556,19 @@ static void hsr_forward_do(struct hsr_frame_info *=
frame)
>  		if ((port->dev->features & NETIF_F_HW_HSR_DUP) && sent)
>  			continue;
>  =

> +		/* PTP TX packets have an outgoing port specified */
> +		if (frame->req_tx_port !=3D HSR_PT_NONE && frame->req_tx_port !=3D p=
ort->type)
> +			continue;
> +		/* PTP TX packets may already have a HSR header which needs to
> +		 * be preserved
> +		 */
> +		if (frame->has_foreign_header && frame->skb_std) {
> +			skb =3D skb_clone(frame->skb_std, GFP_ATOMIC);
> +			if (skb)
> +				skb_set_owner_w(skb, frame->skb_std->sk);
> +			goto inject_into_stack;
> +		}
> +
>  		/* Don't send frame over port where it has been sent before.
>  		 * Also for SAN, this shouldn't be done.
>  		 */
> @@ -569,6 +596,7 @@ static void hsr_forward_do(struct hsr_frame_info *f=
rame)
>  		else
>  			skb =3D hsr->proto_ops->get_untagged_frame(frame, port);
>  =

> +inject_into_stack:
>  		if (!skb) {
>  			frame->port_rcv->dev->stats.rx_dropped++;
>  			continue;
> @@ -633,6 +661,13 @@ int hsr_fill_frame_info(__be16 proto, struct sk_bu=
ff *skb,
>  	struct hsr_port *port =3D frame->port_rcv;
>  	struct hsr_priv *hsr =3D port->hsr;
>  =

> +	if (frame->has_foreign_header) {
> +		frame->skb_std =3D skb;
> +
> +		WARN_ON_ONCE(port->type !=3D HSR_PT_MASTER);
> +		WARN_ON_ONCE(skb->mac_len < sizeof(struct hsr_ethhdr));
> +		return 0;
> +	}
>  	/* HSRv0 supervisory frames double as a tag so treat them as tagged. =
*/
>  	if ((!hsr->prot_version && proto =3D=3D htons(ETH_P_PRP)) ||
>  	    proto =3D=3D htons(ETH_P_HSR)) {
> @@ -674,7 +709,8 @@ int prp_fill_frame_info(__be16 proto, struct sk_buf=
f *skb,
>  }
>  =

>  static int fill_frame_info(struct hsr_frame_info *frame,
> -			   struct sk_buff *skb, struct hsr_port *port)
> +			   struct sk_buff *skb, struct hsr_port *port,
> +			   enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_priv *hsr =3D port->hsr;
>  	struct hsr_vlan_ethhdr *vlan_hdr;
> @@ -697,10 +733,15 @@ static int fill_frame_info(struct hsr_frame_info =
*frame,
>  	if (port->type =3D=3D HSR_PT_INTERLINK)
>  		n_db =3D &hsr->proxy_node_db;
>  =

> -	frame->node_src =3D hsr_get_node(port, n_db, skb,
> -				       frame->is_supervision, port->type);
> -	if (!frame->node_src)
> -		return -1; /* Unknown node and !is_supervision, or no mem */
> +	frame->req_tx_port =3D tx_port;
> +	frame->has_foreign_header =3D has_hsr_header;
> +
> +	if (!frame->has_foreign_header) {
> +		frame->node_src =3D hsr_get_node(port, n_db, skb,
> +					       frame->is_supervision, port->type);
> +		if (!frame->node_src)
> +			return -1; /* Unknown node and !is_supervision, or no mem */
> +	}

This is quite a large patch. Does it make sense to split this
has_foreign_header into a separate first patch, before the second
patch that handles the ETH_P_1588 packets?

>  =

>  	ethhdr =3D (struct ethhdr *)skb_mac_header(skb);
>  	frame->is_vlan =3D false;
> @@ -731,15 +772,17 @@ static int fill_frame_info(struct hsr_frame_info =
*frame,
>  }
>  =

>  /* Must be called holding rcu read lock (because of the port parameter=
) */
> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header)
>  {
>  	struct hsr_frame_info frame;
>  =

>  	rcu_read_lock();
> -	if (fill_frame_info(&frame, skb, port) < 0)
> +	if (fill_frame_info(&frame, skb, port, tx_port, has_hsr_header) < 0)
>  		goto out_drop;
>  =

> -	hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
> +	if (!frame.has_foreign_header)
> +		hsr_register_frame_in(frame.node_src, port, frame.sequence_nr);
>  	hsr_forward_do(&frame);
>  	rcu_read_unlock();
>  	/* Gets called for ingress frames as well as egress from master port.=

> diff --git a/net/hsr/hsr_forward.h b/net/hsr/hsr_forward.h
> index 206636750b300..e64b0358907a9 100644
> --- a/net/hsr/hsr_forward.h
> +++ b/net/hsr/hsr_forward.h
> @@ -13,7 +13,8 @@
>  #include <linux/netdevice.h>
>  #include "hsr_main.h"
>  =

> -void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port);
> +void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port,
> +		     enum hsr_port_type tx_port, bool has_hsr_header);
>  struct sk_buff *prp_create_tagged_frame(struct hsr_frame_info *frame,
>  					struct hsr_port *port);
>  struct sk_buff *hsr_create_tagged_frame(struct hsr_frame_info *frame,
> diff --git a/net/hsr/hsr_framereg.h b/net/hsr/hsr_framereg.h
> index c65ecb9257348..7aeb59beb7fd8 100644
> --- a/net/hsr/hsr_framereg.h
> +++ b/net/hsr/hsr_framereg.h
> @@ -27,6 +27,8 @@ struct hsr_frame_info {
>  	bool is_local_dest;
>  	bool is_local_exclusive;
>  	bool is_from_san;
> +	bool has_foreign_header;
> +	enum hsr_port_type req_tx_port;
>  };
>  =

>  void hsr_del_self_node(struct hsr_priv *hsr);
> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> index d9af9e65f72f0..7cc0641dbd137 100644
> --- a/net/hsr/hsr_slave.c
> +++ b/net/hsr/hsr_slave.c
> @@ -44,8 +44,7 @@ static rx_handler_result_t hsr_handle_frame(struct sk=
_buff **pskb)
>  =

>  	if (hsr_addr_is_self(port->hsr, eth_hdr(skb)->h_source)) {
>  		/* Directly kill frames sent by ourselves */
> -		kfree_skb(skb);
> -		goto finish_consume;
> +		goto finish_free_consume;
>  	}
>  =

>  	/* For HSR, only tagged frames are expected (unless the device offloa=
ds
> @@ -64,10 +63,8 @@ static rx_handler_result_t hsr_handle_frame(struct s=
k_buff **pskb)
>  	skb_reset_mac_header(skb);
>  	if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
>  	    protocol =3D=3D htons(ETH_P_HSR)) {
> -		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
> -			kfree_skb(skb);
> -			goto finish_consume;
> -		}
> +		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN))
> +			goto finish_free_consume;
>  =

>  		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
>  	}
> @@ -78,13 +75,35 @@ static rx_handler_result_t hsr_handle_frame(struct =
sk_buff **pskb)
>  	 */
>  	if (port->type =3D=3D HSR_PT_INTERLINK) {
>  		spin_lock_bh(&hsr->seqnr_lock);
> -		hsr_forward_skb(skb, port);
> +		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  		spin_unlock_bh(&hsr->seqnr_lock);
>  	} else {
> -		hsr_forward_skb(skb, port);
> +		struct hsr_ethhdr *hsr_ethhdr;
> +
> +		/* PTP packets are not supposed to be forwarded via HSR as-is.
> +		 * The latency introduced by forwarding renders the time
> +		 * information useless. Userland needs to capture the packet on
> +		 * the original interface instead of hsr.
> +		 */
> +		if ((!hsr->prot_version && protocol =3D=3D htons(ETH_P_PRP)) ||
> +		    protocol =3D=3D htons(ETH_P_HSR)) {
> +			/* HSR */
> +			hsr_ethhdr =3D (struct hsr_ethhdr *)skb_mac_header(skb);
> +			if (hsr_ethhdr->hsr_tag.encap_proto =3D=3D htons(ETH_P_1588))
> +				goto finish_free_consume;
> +		} else {
> +			/* PRP */
> +			if (protocol =3D=3D htons(ETH_P_1588))
> +				goto finish_free_consume;
> +		}
> +
> +		hsr_forward_skb(skb, port, HSR_PT_NONE, false);
>  	}
>  =

> -finish_consume:
> +	return RX_HANDLER_CONSUMED;
> +
> +finish_free_consume:
> +	kfree_skb(skb);
>  	return RX_HANDLER_CONSUMED;
>  =

>  finish_pass:
> =

> ---
> base-commit: 9e0898f1c0f134c6bad146ca8578f73c3e40ac0a
> change-id: 20260204-hsr_ptp-1f6380f1d35f
> =

> Best regards,
> -- =

> Sebastian Andrzej Siewior <bigeasy@linutronix.de>



