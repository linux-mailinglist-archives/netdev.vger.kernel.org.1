Return-Path: <netdev+bounces-304238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hG+MC7CpRmr+bAsAu9opvQ
	(envelope-from <netdev+bounces-304238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:10:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E11D6FBDEB
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 20:10:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=lIErxrsO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304238-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304238-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F0AE3051BC5
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9A3093C1;
	Thu,  2 Jul 2026 17:12:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EA2E2DD2
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 17:12:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783012329; cv=none; b=u39iFYNH6T9ttrGH4Jn570hVGE7jA5sQNHzRENyyfKBeB/7Ovd123PqPIlFYEoG2daj4cVtl9g4WRuy8Mr7/jrGWjy7ue+bgr9aq3JPB/AVDYDbIuZglJ/20Bto8sxcFWK1ossCKlIGO0aePLWhXryuVwXla4FaJRdkcg8EQ0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783012329; c=relaxed/simple;
	bh=z1cqIfGke7T0b8xMxNl/NhQAv83pNTgQHNtqjcDMa90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJb4lHJ5dyIeEZjDKmDA4oWwMoAn4QfDGm/C5fge+pR+jn8jRI2Vwb72gzWgnTv8o/G1i+SRX+vmYUom7oHj1xt/FuWh26X/i/A7FXg73XTuO1sreIQl6Z0jKD/JrOa6pRxUXa/MN2c+UzpsKGI2OkKXozR+E3MwTfBUvc+aYHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lIErxrsO; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HGS+v1TKz5afliQ+dRAWzgxiAR6QloFBynSXvurA7vc=; b=lIErxrsOcv/ehkA9K6JG1kuNuH
	Q0TXsnYbhoWH/lO1yTSnv06z401jlklLwlAkdhDxg1Oy5Nom4/++ColJSnRb+oiC7aEvupKeuixl4
	76ieqvH/nQMWnMzO63VvJaIqYGlGg7O2JQdLe11XuVLoi9/kBmWc8k+xo7SaLUXpnKO8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfKxJ-00APDF-JI; Thu, 02 Jul 2026 19:12:05 +0200
Date: Thu, 2 Jul 2026 19:12:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "D H, Siddaraju" <siddaraju.dh@intel.com>
Cc: Michal Kubecek <mkubecek@suse.cz>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org, Shubham Das <Shubham.Das@intel.com>,
	Balaji Chintalapalle <balaji.chintalapalle@intel.com>,
	Vijay Srinivasan <vijay.srinivasan@intel.com>,
	Magnus Lindberg <magnus.k.lindberg@ericsson.com>,
	Niklas Damberg <niklas.damberg@ericsson.com>,
	Jonas Wirandi <jonas.wirandi@ericsson.com>,
	Siddaraju DH <siddarajudh@gmail.com>
Subject: Re: [PATCH ethtool] man: ethtool: link 10000baseCR to SFF-8431,
 Appendix-E SFP+ DA
Message-ID: <e603f91b-8f98-4101-a091-0e6007dfdec1@lunn.ch>
References: <20260702145002.1024439-1-siddaraju.dh@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702145002.1024439-1-siddaraju.dh@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,bootlin.com,vger.kernel.org,intel.com,ericsson.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-304238-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:siddaraju.dh@intel.com,m:mkubecek@suse.cz,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:Shubham.Das@intel.com,m:balaji.chintalapalle@intel.com,m:vijay.srinivasan@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:jonas.wirandi@ericsson.com,m:siddarajudh@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E11D6FBDEB

On Thu, Jul 02, 2026 at 08:20:02PM +0530, D H, Siddaraju wrote:
> From: Siddaraju DH <siddaraju.dh@intel.com>
> 
> Annotate the 10000baseCR entry in the advertise mask table so users
> understand what physical media this mode it actually represents.
> 
> 10000baseCR does not correspond to any IEEE 802.3 *base-CR PMD.
> It has no autonegotiation, no link training, and no mandatory FEC.
> The industry standard for this media type is SFF-8431 Appendix-E
> Direct Attach cable, also known as 10G_SFI_DA.
> 
> This change follows the conversation from netdev mail thread with
> subject: "the confusing 10000base_CR. Shouldn't it be 10000_SFI_DA?"
> 
> Signed-off-by: Siddaraju DH <siddaraju.dh@intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

