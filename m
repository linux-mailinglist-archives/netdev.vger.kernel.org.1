Return-Path: <netdev+bounces-306989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ndnfBEAWVGqwhwMAu9opvQ
	(envelope-from <netdev+bounces-306989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:33:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966F746303
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 00:33:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ssZS7k1m;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306989-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306989-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23AD9302B74D
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60B38398F;
	Sun, 12 Jul 2026 22:32:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C391381EBC
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 22:32:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895569; cv=none; b=uLDk/U7ZY5wDBZX9bbkAnMMSCQ1aUMSUDCuPMB0tztbhfDvCKsaE54e6NuedhxSdXTR5DO5JvIvn8S/qFo9LfCvuDC0jLFNRZhXQH7cKzTtAeQaUkC9Ks4xJYDAQDOosivQFcgeov35EOHOQR6/LwVoSf9HppBw5X98N7YK/1DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895569; c=relaxed/simple;
	bh=rMJRUga+qfOnoGx07qr045Ebx7qHtK4d/BCQpBlQpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPU/2kq3nzmvvmUKQ/V5sDJ7BQ9jRvccvwgD7zOBEhWq2Ufg5vgEiUuQDWaO+BQ59hvP8TiRw3xqkzk4v0pLo8LvH9cITTKR8YAejwIQRaIomDGw+ea0C4+tUUHN+qWCCGKbVNNu8EBkkLP/3IYThKetbREMgTYgwbDgxlIdiAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssZS7k1m; arc=none smtp.client-ip=209.85.216.42
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1599151a91.1
        for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895567; x=1784500367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2kQZPoHSijeo1tUSaMcbyM3cWe1NTKRtsDQpKGYRUEs=;
        b=ssZS7k1m1KmncA0QBAFIZtsk+gK4L2p/S0/NWYbwJUVdjSiyX03otEG7XnXNTwm8KA
         MgZDpmLheAtXwygPSC2TDdAy7zVMVQJu/Iy5Kyx0hgAugogG7l7/zzbxYt3OyBczNHT9
         O745m0hpaqfQwBAwwBVTlmN17aoFPq41j2p4YO6NAxZIyEG0s1YXe7vPT0VQMQgc5WeI
         K+h8Ya6chDazUHhGPPga4gugnxiELe+iXbNRwt0kwKZqXFK1gavNqY28EMDXvOpCT1B1
         0kUe+UYlcNyf9ZjYw+IIsVbGoCWxnT50EJ9APsQhUYV2X0VFnBihmT26Uo4gMr0eh1n8
         OAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895567; x=1784500367;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2kQZPoHSijeo1tUSaMcbyM3cWe1NTKRtsDQpKGYRUEs=;
        b=MVu1JvAMKBvbSTJIqS2IP8jIU2XtWRRBhJsMFHL45gHr14bK/EprxiSVboCFNcljFI
         CEdEtV7UMiCRMANqkPj/1b1e0VeFFv0G0vjBepmWySNX8nL5w5JlkAnllkhFp8SORSM4
         NWXRMMR519IXXtBeYC+QOpQVYNQzQODHKghu9Vm9pNVn2a52KYM6Exw05LEH45mAWQes
         Y/CoDjuL1uvKOR9BT+TYXo7EihTPbvJbzD3bmgNDm9xjwdKDuS0vBlwaEvAA870cW/oT
         tIN6NW/9mf3EcPr2/8lt9UQ9WcWaA8G6kvWrGiXeFzmgCsUyPH+uUDbXl6FE489IRUKm
         h9bw==
X-Gm-Message-State: AOJu0Ywg1Jrxs8gCm2MZvANConWLGlkDW9mGNlnX1NqmvZI794P1psMn
	KrFhaV8o6xSoIPgsUNrHcnLBr9vQLuuIjUTdVGF4Hp7g1pKm/97YAPqD
X-Gm-Gg: AfdE7ckB+2Ct/k4gHoZmviZeF8iY/4737uIsuDjeza6fvOUV1tH3aHPz5uawieItDoF
	8+ZDfA0zlN4oubmea3y5j/zCGTo52E7G0y74eIc4yWc1aIh7SD66UgJkM4XM2p+caS6rWlL47jH
	swXKQaHkX/ljWNeITnlpxIUMKHhlMk5B0dz2KrbwRs/NgCXDW79zODIYP0TWcl5sy9pHprPa5ep
	kFL+Mn0E6xFcsyU9Jv1rdxpIYIJecTIiE0KIrNJW4qGH8IiHgCA8jcME7vYCt313vlnoxgGnaVn
	eDvXQx8YpkQhrLcQqqv06ebanBzDptWo8CS8zFmSB27iGsNBVbwcgYmDWq75LMx9RfGfT/I8fzu
	2OtyYe17mxW8VYQDPKwr0Pw+jUj2gHIRWRSr/RjmiQJyso65xmkkigqiVuVHdMW9S
X-Received: by 2002:a17:90a:da86:b0:387:e0bb:5800 with SMTP id 98e67ed59e1d1-38dc7ba7310mr5970904a91.39.1783895566751;
        Sun, 12 Jul 2026 15:32:46 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f7293sm61166210eec.3.2026.07.12.15.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:32:46 -0700 (PDT)
Date: Mon, 13 Jul 2026 06:32:02 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, E Shattow <e@freeshell.de>, 
	Han Gao <gaohan@iscas.ac.cn>
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
Message-ID: <alQVg3QqoIdwGEmR@inochi.infowork>
References: <20260712045233.800748-1-inochiama@gmail.com>
 <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306989-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dlan@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:e@freeshell.de,m:gaohan@iscas.ac.cn,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com,lunn.ch,google.com,davemloft.net,kernel.org,redhat.com,foss.st.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inochiama@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inochi.infowork:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9966F746303

On Sun, Jul 12, 2026 at 10:55:51AM +0200, Maxime Chevallier wrote:
> Hi Inochi,
> 
> On 7/12/26 06:52, Inochi Amaoto wrote:
> > TL;DR:
> > 
> > The DWMAC on Spacemit K3 is failled to register phy after the reload
> > the driver module (rmmod then insmod). Because the reset-gpio is
> > asserted while unloading the driver and is not desserted before reading
> > the c22 id, which leads to a fault.
> 
> You're not the first one facing this type of issues, this is a long standing
> source of issues. The problem is partially hidden by the fact that often times
> the bootloader deals with the PHY reset (like the case you're facing)
> 
> Take a look at these discussions :
> 
> https://lore.kernel.org/netdev/cover.1761732347.git.buday.csaba@prolan.hu/
> 
> and maybe more intersting, Russell suggested an approach on how we could potentially
> address this here :
> 
> https://lore.kernel.org/all/aTBeVTlsElGXUCSN@shell.armlinux.org.uk/
> 
> 

Yeah, I have found these links, but it is something more than I want,
so I think I should deal with this carefully. I will have a try if I
have enough time, but currently I will send this workaround to dlan
to solve the problem....

Regards,
Inochi


> > ---
> > --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > @@ -196,7 +196,8 @@ &eth0 {
> > 
> >  	mdio {
> >  		phy0: phy@1 {
> > -			compatible = "ethernet-phy-ieee802.3-c22";
> > +			compatible = "ethernet-phy-id001c.c916",
> > +				     "ethernet-phy-ieee802.3-c22";
> 
> Indeed that's merely a workaround :(
> 
> Maxime

