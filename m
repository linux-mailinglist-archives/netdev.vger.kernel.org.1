Return-Path: <netdev+bounces-305811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v3K1MnVMTmqLKQIAu9opvQ
	(envelope-from <netdev+bounces-305811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:11:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2948E726A4D
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 15:11:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=VgX5Gph6;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305811-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305811-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76A38304A8F6
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65D213254;
	Wed,  8 Jul 2026 13:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F152D7BF;
	Wed,  8 Jul 2026 13:04:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515860; cv=none; b=QPhIJl09wEO2U5ziachO6H+oHfR9vXLGx85TGmXXGkcaIFabSvUlY8S6C0d64j4y+RA2572GQfKwJ8dsnP2wrTHc+HaMl4DWSWU2HF7LHO7RgeOSLB8d0v2VJzq5W0Uy7Sb51B7f5SfCpKLE/ZhwGQLsCxXN5nAdZsup56I8TvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515860; c=relaxed/simple;
	bh=JXmP3skyaaMi4BY4n7w3R6Ut2ADHA6ulYgIRlMj/YXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLq9HmRMyVDFQ5+7l1GfIPYrg55o7jf9t46u/EkdD/BEHlHiFhnM69pqaZpkSl4zbgXCrY5bMuKNuIfZUbWQZg25lBPWICz6ZHrjkU05jGiug/2t73WRG+jAIRkr3cpZz4fmQHal/kqd7NH8OfGunBWFLQ8n5KXHYnVc3/QrYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VgX5Gph6; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mD6KjjgfwpBL/g4vGVwQBgC2tYhaN/n2+ryjbjSF3IE=; b=VgX5Gph6KJX3vRkpfoOfuxI5i2
	lQpOQj9FSVs6D/+Q9WgxnbK7Iu3P83HgnMCKKfd5qJuaRoNj4CdDir5oiYWeLwnjwIW6CD+RATm10
	yEIqVJBuJoIjSxiqKXjELd89Dda5CqdnBGpdC8e3KHu2yqmLWbZtXV6ZhML2K5m/Qb/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whRwY-00BJt8-OC; Wed, 08 Jul 2026 15:04:02 +0200
Date: Wed, 8 Jul 2026 15:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ben Brown <Ben.Brown@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Message-ID: <0c9c5fe2-6b91-42d2-8582-80f9a47df827@lunn.ch>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
 <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
 <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
 <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TAGGED_FROM(0.00)[bounces-305811-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Ben.Brown@alliedtelesis.co.nz,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:Chris.Packham@alliedtelesis.co.nz,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2948E726A4D

> > Lets take a step back.
> > 
> > What sort of reset are we talking about? Software or hardware?
> > 
> > 	Andrew
> 
> It is doing a hardware reset using a GPIO line.
> 
> When linked down the phy gets put into reset using a hardware GPIO line,
> during link up the phy initializes the hardware using phy_init_hw(),
> which de-asserts that reset GPIO. Then trivial setup is done before
> the driver specific config_init().
> 
> When we are doing the marvell m88e1510_config_init() the first page
> write is not applying so it ends up writing configuration to the wrong 
> registers. When testing fixes adding a 15us sleep before changing the 
> page also meant the page was updated correctly.

  reset-gpios:
    maxItems: 1
    description:
      The GPIO phandle and specifier for the PHY reset signal.

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

  reset-deassert-us:
    description:
      Delay after the reset was deasserted in microseconds. If
      this property is missing the delay will be skipped.


What delays are you using?

     Andrew

