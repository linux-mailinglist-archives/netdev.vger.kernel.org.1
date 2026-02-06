Return-Path: <netdev+bounces-257551-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNa9FkLuhWnSIQQAu9opvQ
	(envelope-from <netdev+bounces-257551-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:36:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4D1FE368
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ACAC302495B
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 13:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822A539E6F6;
	Fri,  6 Feb 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kj1RJvvg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41D14A8B
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384864; cv=none; b=MmKEsPmSLtspRsyT5eahY0cS0aB3tGnCKIRgqZPFT+/TlncpWmg53HkiTdzz0YBIKQn+Vs5dYzSiUQb9OAQYmRHRcRzctbr4HiYzGw/39e+IfP+XmrO5kb4a+nCMukaAx+p7m2J7T820l7ASCXz5YZAvPsJ8QLoLspOgz2cFqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384864; c=relaxed/simple;
	bh=IuMyMRvNZUCfTkMLA4Wc42ZkPQ9Vq8ETpzgm2iGt9Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=as4+x4C2U9f4Jw9eAbYR2VAvrgpMD4BAAw9oTkrxFDXuMePDg0FTaKjMOKKGZXZBrJYzrYA3gKS2WVWi0kMhpLRsavfU9UEY/fv+rNdngeNnTGwIJ60N3l3rNbKV1wMXTGc1mPtbTtcJi6MIRhiBmRIkPb92+lHL8BTFsrBwDZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kj1RJvvg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43614c6afacso298482f8f.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 05:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770384862; x=1770989662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXkwLOFRlIih17A8fA8wgWqc3R7cmaWgMUZ9oqwSoYc=;
        b=Kj1RJvvg2hZMTalbRjhB809HVri53KgZrLtKVI6IS0v+R8NGrax4oP8K1zp34MXsHE
         kO69FyJFSBleSRI+1snYIFzYRLMimpwP8glRdTnuy2mqJL9xbVe7aRmHo4ESDOAuGbIm
         8EP9EVz7fz7kv77IcLFg0eeea66eIDIoyscSGoDKIl29Tkr4uwA9fqx5XYwmt226/oiM
         elS29fJ3KQ28IIqXRWwvFuTo9KA/y2Y4w44rdGlFEB0dV4rDOgpCRdaGcRuwFNrRiQd9
         41yd+fuOutPDcXMoE9mwipcbmzL7FGbXXmnbdcUHi6jY0WYJcA8tFvwi9+7ClIDKswXC
         EZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770384862; x=1770989662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXkwLOFRlIih17A8fA8wgWqc3R7cmaWgMUZ9oqwSoYc=;
        b=QBQDogvS+1uEUG5Zz9ax8/L3L8WikD+AaPWpTXTx7uu6ars6fcXnNK/QjXxdbo6ht2
         96lWDAHxpW3A6M3Tgg5kbP06/SRi4UuU/TfhC5dF8PVM9Wwod6dBAxIlMaP9wisqjGHJ
         oIl/suJxCrcuUvFvef8dsyUAjpM8xvm1SwMtTwVu3Mq6oJktwEGY2DqMfhqGZfL35pus
         3MsFDixXZXfbRXGd2gmPPZvib1w+YIDQZHNt3E6RamrW6u8YvTv0VM5JhMorJ0xSyjic
         wHeFBTxNRV7v0557BhKGNp4CqyB5LqU5dkqDV9hqGnGPPBiwuvGaAEeKD8SdqEIlBuPd
         vP6w==
X-Forwarded-Encrypted: i=1; AJvYcCXYDon9VxW10C3/KXmFcxVorYAdhebWSAOt1lMXz/GCH6VfH8pm5xhbJTeKw66NZys1TKstMQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRWHeSF9CHWgVgbPjMbpy7Fl8kzb6vRCa3gl4U8uG6xGN1m1e
	lKVAk/eIgaFSt6GZ351YV1Tb/MEaMG6DXrJvMaGgvj68gCCN8E88Ne9h
X-Gm-Gg: AZuq6aJcGDBOYDAzsq1XFRcnC+7qftkCpIOZKb9moMRoSZT3XAmfaEGerbMan+73I3M
	xO3BMrx9r3RycCvOxWecrgpdzGC8+HXlB/pJ76qIUDaxO8DBiSmtSruOUBEY2CeEv8VllXb3hG5
	YpOZbg+XRBJu45hhhK/Paj+ddBchLsXJu8w0/G3DyPJNjGYdg0xnSZReHfh0JKTqgYVt0MFXPTu
	etFMiKdsp6YIk0Jv5oCN8YE9xkksQ35vDPFWVawnR+cV909nGjfpNZiXZ3OoTl+J/WOsyItWPs/
	JDK6hGBaTzpHCdCYqvW0ES1kKCc3QfYJ2oqWzSqFUdsAAasSdp/ljWXOdsBrmzBiJ5+7zAz5Jx6
	gaD3DokJSh4yjycO5eBfTisDsugwREgzsNjfVgwBRkRcnsmjQULzd/Dk8/bhRzmc9lnctmZtXSG
	uBVeU=
X-Received: by 2002:a05:600c:4f49:b0:477:9a4d:b92d with SMTP id 5b1f17b1804b1-4832033a019mr26258435e9.5.1770384862226;
        Fri, 06 Feb 2026 05:34:22 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:6d6c:e4d6:4ec4:ebd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362974527fsm6382837f8f.31.2026.02.06.05.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:34:21 -0800 (PST)
Date: Fri, 6 Feb 2026 15:34:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v13 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <20260206133418.vxui223u4d6jdpql@skbuf>
References: <cover.1770211259.git.daniel@makrotopia.org>
 <2da8267175bfe7b8ff92d67ba5aa88755fab1710.1770211259.git.daniel@makrotopia.org>
 <20260205182117.41618f8d@kernel.org>
 <aYVckqToPwzR75EO@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYVckqToPwzR75EO@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257551-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olteanv@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE4D1FE368
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 03:14:26AM +0000, Daniel Golle wrote:
> Hi Jakub,
> 
> thank you for looking into this driver another time.
> 
> On Thu, Feb 05, 2026 at 06:21:17PM -0800, Jakub Kicinski wrote:
> > On Wed, 4 Feb 2026 13:33:19 +0000 Daniel Golle wrote:
> > > +/* The switch firmware expects all structs to be byte-aligned */
> > > +#pragma pack(push, 1)
> > 
> > "Byte-aligned" means..? Generally aligned means that it starts
> > at an address which is multiple of X. All addresses are multiple of 1
> 
> In case fo the firmware running on this switch it means that data types
> used in structures used as input and output parameters for firmware
> functions should be aligned to 8 bits, without any additional padding in
> between.
> 
> struct foo {
> 	u8	var1;
> 	__le16	var2;
> 	__le32	var3;
> } __packed;
> 
> It's size is 7 bytes and it looks like this:
> 
> .||||||||.||||||||.||||||||.||||||||.||||||||.||||||||.||||||||.
> |  var1  |       var2      |                var3               |
> .        .   LSB  .   MSB  .  LSB                         MSB  .
> 
> 
> This is what the firmware on the other end expects, from all data sent
> to it and what the Linux host has to expect from all data received from
> it.
> 
> > We used you push back against blanket __packed because it's forcing
> > all *host* accesses to also assume that the structures are unaligned.
> 
> Understand that in general, and of course know that using packed structs
> without a hardware requirement of doing so needlessly wastes CPU cycles
> on each access to struct members.
> 
> However, in this case this is a header file which exclusively defines
> structs which are only used to communicate with the firmware running on
> the switch. Using them for anything else, such as storing or processing
> data the driver deals with internally is, very inconvenient because all
> types are also defined as little-endian, so not only unaligned access,
> but also endian conversion burdens every access (in the sense that it
> burdens the programmer on little-endian machines, but the CPU as well on
> big-endian machines).
> 
> tl;dr: This whole file is only API definition. And this is how the
> firmware API is defined, and that's the only way to deal with that
> switch.
> 
> (I would have preferred if they just exposed the internal 16-bit
> registers of the switch via MDIO, and have asked MxL for that several
> times, without success)
> 
> > The best practice is to pack only specific structs which need it
> > and add compile_assert()s to make sure that the compiler doesn't add
> > any padding.
> 
> Imho checking whether each of these structs is naturally packed (ie.
> 8-bit aligned without padding between 8-bit aligned members) is prone to
> human errors which only become visible when testing on the real
> hardware, and hence complicates maintainance.
> 
> Other drivers which operate on similar APIs (many GPU drivers, for
> example) also use #pragma pack(push, 1) in header files defining
> external API. Also there all external API definitions are kept in a
> separate file, away from any of the datastructures used by the driver
> internally at runtime.
> 
> Anyway, if you really really want me to set individual __packed for each
> struct which isn't naturally packed in this whole file, please tell me
> clearly that this is what you would like, and I will of course do it
> despite disagreeing with the reasoning.

When I created the pack_fields() API it was exactly for situations like
this. It helps you keep naturally aligned structures in native CPU
endianness while adapting to whatever quirks the peripheral you're
talking to has.

