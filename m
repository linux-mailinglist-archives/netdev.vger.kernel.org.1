Return-Path: <netdev+bounces-295835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMzCA0vbImrqeQEAu9opvQ
	(envelope-from <netdev+bounces-295835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:20:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C20F648CBA
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 16:20:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=Y8xS4wKU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295835-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295835-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45270305BF8F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E338B361668;
	Fri,  5 Jun 2026 14:12:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235E40E8FF;
	Fri,  5 Jun 2026 14:12:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668776; cv=none; b=gWEGedTMOOOfO9FoP7Um9HP43zgNYccaqhbDxF8SWInJHaU6jBbzTWON5pR4A2htElNH3O6RM4L4oq3Aqhl9XQ9q33sjjPK+krxz/hN82z4xE2YAfzraBSISX7t95awI4sDWH5mVjfUvCuzM5xmpIgAPwNdUcl7sCLh9rBrKJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668776; c=relaxed/simple;
	bh=8kte1jYsfpJ+YdWvrUzTLwzEb6GY+7W+zz0SvAjs9RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egr1gDLkoC/1qwmtj33TBxw39oHVHyvV8LeViNklgTFJK0b8yf8jAvq4cA9Vw0CQCLOrcX7k0bsBvJJbD3odYyMQV0KsOuYYso8is5kTFhY/BVn4cUdmZ6/UGLZqo/lW/GHtMklKTDSfb1RYZapVsZsHiiSKk2rhI6j86MCY6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Y8xS4wKU; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gwZpFcQuVSep5h2JfBZIsItjVotlQ0g44gywc7q0L44=; b=Y8xS4wKUwI9UtNLzhFo1rIXGQb
	ID7ZHfXz9oSRBBQFP0TfI1kMEEPON7JahkxHrpMpfJl+yL0XCOr0svzp8Oektt3eyLNKf2k/HCWO7
	YzgPU6Z36X7alXcHCOt2xtvePAxOu22dgr2Tb0XDmMFTaRFVwLQ8FAIXlgXxZLSYKNWY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wVVI3-006F2u-0F; Fri, 05 Jun 2026 16:12:51 +0200
Date: Fri, 5 Jun 2026 16:12:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	nic_swsd <nic_swsd@realtek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net] r8152: handle the return value of usb_reset_device()
Message-ID: <839beccc-165e-4f60-9c23-ccc8e4f205ed@lunn.ch>
References: <20260604092247.27158-450-nic_swsd@realtek.com>
 <c1ddf8f3-71f7-434c-ad10-64096b65fe51@lunn.ch>
 <ce2651bf86fc401b9e1e7cc29b5a6c22@realtek.com>
 <3e108daa-7913-4890-8331-9761a4654b1f@lunn.ch>
 <19bdb89de51c46408b7e7d7cdeba8e4d@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19bdb89de51c46408b7e7d7cdeba8e4d@realtek.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-295835-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:nic_swsd@realtek.com,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:mid,lunn.ch:dkim,lunn.ch:from_mime,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C20F648CBA

On Fri, Jun 05, 2026 at 06:26:46AM +0000, Chih Kai Hsu wrote:
> On 05/06/26 12:04 pm, Andrew Lunn wrote:
> 
> > On Fri, Jun 05, 2026 at 02:42:34AM +0000, Chih Kai Hsu wrote:
> > > On 04/06/26 8:54 pm, Andrew Lunn wrote:
> > >
> > > > On Thu, Jun 04, 2026 at 05:22:47PM +0800, Chih Kai Hsu wrote:
> > > > > If usb_reset_device() returns a negative error code, stop the
> > > > > process of probing.
> > > > >
> > > > > Fixes: 10c3271712f5 ("r8152: disable the ECM mode")
> > > >
> > > > https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.h
> > > > tml
> > > >
> > > > Does this bother people?
> > > Yes, it does.
> > > If the driver does not return early when receiving an error code from
> > > usb_reset_device(), the subsequent execution will trigger a kernel call trace.
> > 
> > Please include a link to such a bug report, kernel call trace etc, to to show it
> > bothers somebody. Do you have the hardware and can trigger this?
> 
> If the driver ignores the error from usb_reset_device(), I get the following call trace.

O.K, great.

We have had a lot of AI driven bug fixes for theoretical issues, which
in practice are unlikely to happen. We want to consider such patches
as just ongoing development work, and merge them via net-next, and not
backport them to stable.

From the commit message it is not always clear if a patch is just
fixing a theoretical problem, or a real problem which bothers
people. So sometimes we need to ask....

Including in the commit message a Reported-by, or a link to issue
report, makes it very clear it is a real issue which bothers somebody,
so we don't need to ask. Please consider this with further
submissions.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew


