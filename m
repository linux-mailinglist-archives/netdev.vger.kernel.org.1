Return-Path: <netdev+bounces-294209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UTNMMO3RHmrXVQAAu9opvQ
	(envelope-from <netdev+bounces-294209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:51:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D641B62E2C3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 14:51:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=IyUKeYZF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294209-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294209-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13A083006522
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF93C76A1;
	Tue,  2 Jun 2026 12:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2217638911E
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 12:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780404661; cv=none; b=OZzlwLe7kkjzzBvdjge6g4XjqrJ8PzbztK6o4yc32AhJ0Z6ogATBBEk9PVzaRPicQC0Cs3lawWF39CQJffsF52yCv4lxGyxxV53V0JySgzgwjNESRQLBk6GVEdUFvGD2PVaD/1YqToQukRsW4lQgYUuNMF+SlBMbI5Yr90NI6B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780404661; c=relaxed/simple;
	bh=KdPsukPOjhZ2FXSvDmayJ4LjEz5qmYgAur6pLF6ZhMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWaUicDSeIfLHUsN7bVF3RIu2L2rSd6fPeee3utNyvahw0z7iqUB6jTi/QxTKR0kh0Va+g/uFV3NVqND5OzWWRAroOXHOlHo49iZ4D3TdcrvJm4wbAAR5300V5NwxAOA/4f4pK5MzUz+7JXyPKBsm9XPxge2XhPavCKwdXbyYfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IyUKeYZF; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pG7HUrAUTDx39Xaw4AN8KuESL2B22Hci2e/DT7Kf02U=; b=IyUKeYZFpRMgKJBR8OBFecMrDP
	TnWjpO3kDWdjSB5JCpvCDFtQ6CBJoJnT7mf1kBAZletouW2VxUDGz72nO+5nJVsop2VRodaU9WBDc
	Cc3WsMwJ1cwpFesbEPKu+raV901qNxhL0aJEIAHpBx8EoMqfXWBNYVGSTREFvhsPcVIA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wUOa3-005gmQ-8U; Tue, 02 Jun 2026 14:50:51 +0200
Date: Tue, 2 Jun 2026 14:50:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, mensi@mensi.ch
Subject: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
 fwnode API
Message-ID: <8c2ef5ad-62a9-4cea-8be5-d2ef49389ca7@lunn.ch>
References: <20260602052640.93083-1-markus.stockhausen@gmx.de>
 <20260602052640.93083-2-markus.stockhausen@gmx.de>
 <3b54c1f3-b60c-4e97-8e14-fec10cb1030a@lunn.ch>
 <027401dcf28b$760ad6b0$62208410$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <027401dcf28b$760ad6b0$62208410$@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294209-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:mensi@mensi.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org,mensi.ch];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gmx.de:email,lunn.ch:mid,lunn.ch:dkim,lunn.ch:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D641B62E2C3

On Tue, Jun 02, 2026 at 02:29:23PM +0200, Markus Stockhausen wrote:
> > Von: Andrew Lunn <andrew@lunn.ch> 
> > Gesendet: Dienstag, 2. Juni 2026 14:06
> > An: Markus Stockhausen <markus.stockhausen@gmx.de>
> > Betreff: Re: [PATCH net-next 1/8] net: mdio: realtek-rtl9300: Convert to
> fwnode API
> > 
> > On Tue, Jun 02, 2026 at 07:26:33AM +0200, Markus Stockhausen wrote:
> > > The driver still uses legacy "of_" functions to determine the port
> mapping
> > > during probing. Convert this to the modern fwnode API. With that also
> fix
> > > a subtle lookup bug in the original code.
> >
> > fwnode does not exist because it is modern. It allows you to have
> > other bindings, like ACPI binding, using the same code. Do you need an
> > ACPI binding? Have you documented this new ACPI binding? Has ACPI been
> > tested? Are there any OF properties which as listed as deprecated
> > which have been converted to fwnode? A new binding should not start
> > out with deprecated properties.
> 
> As I'm no firmware expert, thanks for the note. 
> I came across this mix in the old code:
> 
> 	err = fwnode_property_read_u32(port, "reg", &pn);
> 	...
> 	err = of_property_read_u32(mdio_dn, "reg", &bus);
> 
> So I decided to get consistent and opt for the 
> fwnode version. To be precise: We are using 
> device tree only here and we do not need to 
> change any structure or properties. 
> 
> Leave all as is then? If yes, do I use "of_" or "fwnode_" 
> for new functions? E.g. for patch 2/8.

Please use of_

And in this case, i think there is a helper you can use. In general,
take a look around and try to reuse as much existing code as
possible. That might mean changing core code, making a static function
global, etc.

	Andrew

