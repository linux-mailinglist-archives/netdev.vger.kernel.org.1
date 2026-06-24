Return-Path: <netdev+bounces-301535-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qS8dGFhBO2rsUggAu9opvQ
	(envelope-from <netdev+bounces-301535-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:30:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8826BAEF9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 04:30:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b="J/XH9OST";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301535-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301535-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C16F230252AB
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 02:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F722367D9;
	Wed, 24 Jun 2026 02:30:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4B72857CC
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:30:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782268235; cv=none; b=VyOfbpG5JB7rbeK+h7WNPwUMk4Omrn6DH3Lp51nm3CnsSsjJ8yRIk1B1BiMPfSb5CVZqvdqUjIioPRXNJSAtbx4q92tBInKzUOlqvT6zDatxVp+QN7SFMSNBZUT/XEXH7zWqFkygkWCjacEGLX22XTYwnIXC9z4kQ060AS3PmXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782268235; c=relaxed/simple;
	bh=nksDu5yyFmXaqsW8EE2cTW17CPVO6hsTaFF/gmdHOWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfucA5xVPYrOLRsRfbwmUHcYvNphkPUa1eoAp8OlDJfLcYFmMZG7xTqY7a/nOqUP6w20aZDF0JvD/kS2RqMtAOxybZmoGGSKNF9ENn71NeFnEP1uCCDJhlR9g3MzS2ZN5nMLxKjK3mEn/Yqmc84uY7GETt+tJC7Dr+kQMeNjZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=J/XH9OST; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cwkN8WKDn4xDdeIp1Dq+VVasAbicD8jCRQpIpf6d36M=; b=J/XH9OSTujJgPkikT4O1a6FtTq
	znJn9yun7/v/KopP1o+ti+izygrcHQWVW4/41Xr50hsJzWSYqcJdHZYZNufop51tvHkVxdElMHFza
	X+1sz3qDxKhnb+Qp23g6sgUB+N5wQFo7HXlqwHdCDDwgogS1KUQK+XwpF7+I1E3psifQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wcDNk-0092Cw-JL; Wed, 24 Jun 2026 04:30:28 +0200
Date: Wed, 24 Jun 2026 04:30:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: "Das, Shubham" <shubham.das@intel.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Alexander H Duyck <alexander.duyck@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"mkubecek@suse.cz" <mkubecek@suse.cz>,
	"D H, Siddaraju" <siddaraju.dh@intel.com>,
	"Chintalapalle, Balaji" <balaji.chintalapalle@intel.com>,
	"Lindberg, Magnus" <magnus.k.lindberg@ericsson.com>,
	"niklas.damberg@ericsson.com" <niklas.damberg@ericsson.com>
Subject: Re: Ethtool : PRBS feature
Message-ID: <38359a70-ebc7-49c5-bae5-0d3d7bf82fac@lunn.ch>
References: <f4a3e4ad-91e2-4844-a29b-81f70151228e@lunn.ch>
 <SN7PR11MB81099B4885C10E16D52A2EB9FFE52@SN7PR11MB8109.namprd11.prod.outlook.com>
 <06d8c98da24e80d148ede4e933bb621c5515a7a2.camel@gmail.com>
 <SN7PR11MB8109C173933D08F994FBB084FFE22@SN7PR11MB8109.namprd11.prod.outlook.com>
 <26971635-b13a-4ed3-b2cb-ce35da9b63d3@lunn.ch>
 <SN7PR11MB81096CF160930DB8FA278B3CFFE12@SN7PR11MB8109.namprd11.prod.outlook.com>
 <be5c474b-c969-49af-8235-825580ee945c@bootlin.com>
 <SN7PR11MB8109149608172808784CDCBEFFEF2@SN7PR11MB8109.namprd11.prod.outlook.com>
 <5f22c491-b816-421e-a531-bf87a07fea70@lunn.ch>
 <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08f1b0c2-2b09-4c30-b95a-02959d409a03@trager.us>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301535-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lee@trager.us,m:shubham.das@intel.com,m:maxime.chevallier@bootlin.com,m:alexander.duyck@gmail.com,m:netdev@vger.kernel.org,m:mkubecek@suse.cz,m:siddaraju.dh@intel.com,m:balaji.chintalapalle@intel.com,m:magnus.k.lindberg@ericsson.com,m:niklas.damberg@ericsson.com,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,bootlin.com,gmail.com,vger.kernel.org,suse.cz,ericsson.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lunn.ch:dkim,lunn.ch:mid,lunn.ch:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA8826BAEF9

>     To avoid race conditions, maybe some of these commands need combining.
>     ethtool --phy-test eth1 tx-prbs prbs7 rx-prbs prbs7 bert start
> 
>     The configuration is then atomic, with respect to the uAPI, so we
>     don't get two users configuring it at the same time, ending up with a
>     messed up configuration.
> 
> Testing consumes the link so you really don't want anything done to the netdev
> while testing is running. fbnic does the following.
> 
> 1. Testing cannot start when the link is up

That is not going to work in the generic case. Many MAC drivers don't
bind to there PCS or PHY until open() is called. So there is no way to
pass the uAPI calls onto the PCS or PHY if the interface is
down. There are also some MACs which connect to multiple PCSs, and
there can be multiple PHYs. So you need to somehow indicate which
PCS/PHY should perform the PRBS. There was a discussion about loopback
recently, which has the same issue, you can perform loopback testing
in multiple places. So i expect the same concept will be used for
this.

> 2. Once testing starts the driver removes the netdev to prevent use. The netdev
> is only added back when testing stops. The upstream solution will need
> something that can keep the netdev but lock everything down while testing is
> running.

Probably IF_OPER_TESTING would be part of this. If the interface is in
this state, you want many other things blocked. However, probably
ksettings get/set need to work, so you can force the link into a
specific mode.

> 3. Once testing starts you cannot change the test, even on an individual lane
> basis. You must stop testing first.
> 
> 
>     Traditionally, Unix does not offer a way to clear statistic counters
>     back to zero. So i'm not sure about clear-stats. We also need to think
>     about hardware which does not support that. And there is locking
>     issues, can the stats be cleared while a test is active?
> 
> fbnic actually has separate registers for PRBS test results. Results do need to
> be clean between runs but I never created an explicit clear interface. Firmware
> automatically reset the registers when a new test was started. This also allows
> results to be viewed after testing has stopped.

We should really take 802.3 as the model, but i've not had time yet to
read what it says about the statistics.

> Reading results was a little tricky due to roll over between two 32bit
> registers.

802.3 is make this even more interesting, since those registers are 16
bits.

> When I spoke to hardware engineers at Meta they did not want a timeout. Testing
> often occurred over days, so they wanted to be able to start it and explicitly
> stop it. I'm not against a time out but I do think it should be optional.
> 
> Since PRBS testing is handled by firmware one safety measure I added is if
> firmware lost contact with the host testing was automatically stopped and TX
> FIR values were reset to factory. This ensured that the NIC won't get stuck in
> testing and on initialization the driver doesn't have to worry about testing
> state.

That will work for firmware, but not when Linux is driving the
hardware. I don't know if netlink will allow it, or if RTNL will get
in the way etc, but it could be we actually don't want a start and
stop commands at all, it is a blocking netlink call, and the test runs
until the user space process closes the socket?

      Andrew

