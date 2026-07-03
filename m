Return-Path: <netdev+bounces-304529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VhtbEBO1R2pNdwAAu9opvQ
	(envelope-from <netdev+bounces-304529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4E7702B49
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 15:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=VmakpVOo;
	dmarc=pass (policy=none) header.from=lunn.ch;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304529-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304529-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A200D304568A
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 12:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB7B3D0910;
	Fri,  3 Jul 2026 12:53:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5208F3C7E18;
	Fri,  3 Jul 2026 12:53:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083209; cv=none; b=p2LZpZ7TRzyWj17iHy5VZqbEAxjsaotleUYQT9aJ5a4Jl9ecRcj093CJX0K0tatuFN5SstVxTC86RUjw45lbUBMFeabUsU/DzXTruetsfpLaCzcZUmG6YL4Kyfdn6o27izmZyAW8TSSqyf4Q1beNMe5RVGRtB/0zreJ5nvPeCL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083209; c=relaxed/simple;
	bh=sYgk24Hi7gndmbMPVzrP/qiqaAfFKPbRFaAahnzmxv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtBXrfE61V1fjrveyI4J9uy8Z+thbKP6/pcXIiyrsU51OcyfmErsaeDldga9k5UT79PnUYNGXmyNyrpFt4n94LTxylz7+97PsIxifpRZ3UMDKBWbyz43UI/4Kh3v2T7H4/za9y31G0aU/uDA/XrGD2roiT4LJT2WxPNmQ1QBd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VmakpVOo; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=o+3NvdYBEUqk2CKnHX9pZjbpAvzlQaG9N1ZG1jFcieA=; b=VmakpVOoSJEMcr89h0S6RXio5t
	jbDIo9DxAQpleQp+uoslQ3xtwuCs1OM+LwGIcZ+Z0Tu/yNLr9Htmcd3crKtDpS6FvBaxdFnlbx0FF
	Ll57CJlQ05oeviq73rOkpRnKFPUDGq0famwzq1Czou5phPg7b9pYUGMHFvKsTSxTMAQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfdON-00AY2J-2R; Fri, 03 Jul 2026 14:53:15 +0200
Date: Fri, 3 Jul 2026 14:53:15 +0200
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
Message-ID: <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
 <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304529-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Ben.Brown@alliedtelesis.co.nz,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:Chris.Packham@alliedtelesis.co.nz,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C4E7702B49

On Fri, Jul 03, 2026 at 12:14:26AM +0000, Ben Brown wrote:
> 
> 
> On 7/3/26 11:04, Andrew Lunn wrote:
> > On Fri, Jul 03, 2026 at 10:50:34AM +1200, Ben Brown wrote:
> >> When bringing down then up the link on a 88e1512 phy a link is not
> >> getting established. This is because the phy is coming out of reset then
> >> immediately getting configured. During configuration the page is
> >> unsuccessfully updated causing writes to the wrong registers.
> >>
> >> Add the soft reset function that does a reset then polling read waiting
> >> for the phy to come back online, at which stage the page register can be
> >> updated successfully.
> >>
> >> This was tested on a 88E1512 phy, using ip link to bring up/down the
> >> link.
> > 
> > What makes the 88E1512 special that it needs this, but no other
> > Marvell PHY does?
> > 
> > 	Andrew
> 
> This may be needed on the other marvell phys, but I only have access to 
> a 88E1512 phy so I am only updating what I have seen this on.

The Marvell driver is used a lot, so i would of expected somebody else
to of noticed.

Lets take a step back.

What sort of reset are we talking about? Software or hardware?

	Andrew

