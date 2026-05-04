Return-Path: <netdev+bounces-283966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKYpENbS+Gm41AIAu9opvQ
	(envelope-from <netdev+bounces-283966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86664C1C65
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3829030182A2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B28F282F10;
	Mon,  4 May 2026 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPcbphmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010353E3C6F
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914488; cv=none; b=Xtq16lonELexh2iUsuG0oihvxaWiZ4QiRg9g4oaCTp+j2Zf73IC/Nrs8B7jaGtQmPTJtN7ajK639yFDMjfsviuvWs32m+srEVnefGZobr4+XCSubK46PUcfsIrEYtfWlQPk/i+ALYWBjCdp5jMaZEj0zC6n/LD0eVQG4LPWOMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914488; c=relaxed/simple;
	bh=Pps8RK8buB3hso0zneOERYi5j2/ISVJ1p9jHSMvbHrc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AjAG1yDvXpkqpiKToZwIzs7SpX5bnpmJgecBF2TI0vBmGOWnTYfCagMnY9E3Gl1wERvmgDsP6CbolW1PAGifgKPK5B2vyu3kY0R22Aq1Jk/JK+l3Pwd/1bxTva8Ywh2HN9wn5qqEQl1GxApZMMxArX0yHAfdq4jR3T7I6O5g6Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPcbphmb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd65714dcaso32430877b3.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777914486; x=1778519286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1L14G+WrJaZh7HM6Ic9zVnampCDzlveR7wmXLamQVWk=;
        b=KPcbphmbviEsaa8+lBYsVfovgf8hR7giQmD8gLfmFRZivN6haH/SrBbvodQv6YaP8J
         lFk7TuT6BcJH0VePXGgTVFm2caSM6D9PsK9ySgR5O2l/TD/xHxYiUtfeKYAEnVDH9Lbg
         Y6KmCAudX+bZwxxnuDFTp6htTNkPOCkqJH4yx5K1iQLlfFhWiy5Hv9gkp2m1RQVXFvME
         OeBABJR4phGUWzpac8Eijnb+z0M2kwLIOIP7HwWWblBUjNLow5vVM00fOAMmfFCW38gm
         Z52n7xkYAJEcRnFJrcAQ8Xg+hUhw1+jiyi/iD7IDebEoI6HxtQU13d1l0dqsbhj24Q4z
         vyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777914486; x=1778519286;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1L14G+WrJaZh7HM6Ic9zVnampCDzlveR7wmXLamQVWk=;
        b=CGlZkEnwoOUsxR02eoZD53pNhwuwzC7BTks8DrYQqAaiJxA3OkscJczWRfcrYXzWxl
         CoxVZZ0wNYg06hns50YtinGnyBUHJvJRgY8j9IMFLZ8o6pv3HTkexTiOfMH4fM6utrQ8
         UNcB8f0UNRS+0g2bYfSScc/OWB25kvc385txGP7ohrsMYO4pYDrBeq00pRSwHZQ0owcr
         mOJE2P6CuwBlv+lDQOVSwzTgDZDp1qJWxW7BYDdjbFDfhUbdlHdaZ5esfiSUPPJeGXYb
         +IXh6u4v/DbG9ueZRHvrc57CVkKH1dXa3f57F+llP/ZpZdJ5PIPv9mr57R9qgK3/WKEn
         xA/g==
X-Gm-Message-State: AOJu0YwVjgbLzPcb1sKPNy+8KjP+WLHms5ikOisXYSgXCRHY4irUq9J/
	Xi/+56sStI0rTgs0x46hwptN43lFLoH0w/rJDhmJIpzPmuXAU4BKlA0g
X-Gm-Gg: AeBDiesLjM9cB/Pbc9Fq1I8mpaGQvwgOBB4EwV/RewZHclouIcOJePEac19qh7Nfm/3
	X9WH6ZSRasVIaYrZ0OcJXuU1C5ED8QsByGPQO+vybAXwsXiAjI2cF/1assmtnfhJqKu/G/iRuj1
	MHaJO7JTs5vBMTbJzWx+uwn31GDsrSDQ5s7fSqgO/Ayn2pzpdYdytJfs/inKwraXCGIG6RNSyyL
	aogfnuL6N3RiSGUbM6dHM2KWLazp9vS6+oRGWUxsXE4ylY1uFpw18e25DSxe1sPIuqIT5Ve0VJv
	TXqeRewrT6p06ZCoaQe8epdSDQWafkskiwEPHFmFWvYVhmsyis7/yxzMhwzjaMXPCOXZhpeju4v
	rZrVxFLW1ho6mqcBW9rm2xCYj+mI4vIr3G7cK+BIH1gcF4MusUxUoBAPTJ2qY+cKQ8TF1aWsBcC
	9XSJoPvZ8EfsLCser1f8R28W1ijQOw6FfH5eRqFqdWjFiIt1OLiZvUx/XAg9g6mxWosQwK0/Xce
	p8+RmULFgxbL2k=
X-Received: by 2002:a05:690c:660c:b0:7b8:926e:3f0d with SMTP id 00721157ae682-7bd770b3a0cmr100909857b3.26.1777914485731;
        Mon, 04 May 2026 10:08:05 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bda8203a25sm1395727b3.4.2026.05.04.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:08:05 -0700 (PDT)
Date: Mon, 04 May 2026 13:08:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
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
 Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <willemdebruijn.kernel.22897601ad5fe@gmail.com>
In-Reply-To: <20260504085911.nLZLRjPF@linutronix.de>
References: <20260429-hsr_ptp-v3-1-afbf8f200f48@linutronix.de>
 <willemdebruijn.kernel.31592d82701e5@gmail.com>
 <20260504085911.nLZLRjPF@linutronix.de>
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
X-Rspamd-Queue-Id: A86664C1C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283966-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[linutronix.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

> > > +#define HSR_INLINE_HDR	0xaf485352
> > > +struct hsr_inline_header {
> > > +	uint8_t tx_port;
> > > +	uint8_t hsr_hdr;
> > > +	uint8_t __pad0[4];
> > > +	uint32_t magic;
> > > +	uint8_t __pad1[2];
> > > +	uint16_t eth_type;
> > > +} __packed;
> > > +
> > 
> > No specific need to make this header ethhdr like?
> 
> What do you mean? eth_type is at the same spot or do you mean it should
> be named h_proto?

I mean there is no reason your fake header needs to be 14B or
or otherwise resemble an Ethernet header.

That ties into my last comment to use sizeof(struct hsr_inline_header)
where working with that header, rather than ETH_HLEN. It is an
independent header.

This padding and packing is unnecessary.

> > > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > > index 5555b71ab19b5..ac39b2347aa0f 100644
> > > --- a/net/hsr/hsr_device.c
> > > +++ b/net/hsr/hsr_device.c
> > > @@ -228,20 +228,51 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
> > >  
> > >  	rcu_read_lock();
> > >  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
> > > -	if (master) {
> > > -		skb->dev = master->dev;
> > > -		skb_reset_mac_header(skb);
> > > -		skb_reset_mac_len(skb);
> > > -		spin_lock_bh(&hsr->seqnr_lock);
> > > -		hsr_forward_skb(skb, master);
> > > -		spin_unlock_bh(&hsr->seqnr_lock);
> > > -	} else {
> > > -		dev_core_stats_tx_dropped_inc(dev);
> > > -		dev_kfree_skb_any(skb);
> > > +	if (!master)
> > > +		goto drop;
> > > +
> > > +	skb->dev = master->dev;
> > > +	if (skb->len > ETH_HLEN * 2) {
> > > +		struct hsr_inline_header *hsr_opt;
> > > +
> > > +		BUILD_BUG_ON(sizeof(struct hsr_inline_header) != sizeof(struct ethhdr));
> > > +		hsr_opt = (struct hsr_inline_header *)skb_mac_header(skb);
> > > +		if (hsr_opt->eth_type == htons(ETH_P_1588) &&
> > > +		    hsr_opt->magic == htonl(HSR_INLINE_HDR)) {
> > > +			enum hsr_port_type tx_port;
> > > +			bool has_header;
> > > +
> > > +			has_header = hsr_opt->hsr_hdr;
> > > +			tx_port = hsr_opt->tx_port;
> > > +			if (tx_port != HSR_PT_SLAVE_A && tx_port != HSR_PT_SLAVE_B)
> > > +				goto drop;
> > > +
> > > +			if (!hsr_skb_add_header_port(skb, has_header, tx_port))
> > > +				goto drop;
> > 
> > All use of this information happens in the context of this ndo_start_xmit?
> 
> I receive it from af_packet in HSR's ndo_start_xmit, yes. Then
> hsr_xmit() is forwarding it to the slave device via dev_queue_xmit().
> Here the skb->cb information gets overwritten.
> 
> I need this hint in the slave eth driver in case there is hsr-offloading
> available. 

This assumes that the slave device is somehow HSR aware. But standard
net_devices are not?

Isn't it HSR's ndo_start_xmit that selects which slave to forward to,
based on the information in this header?

