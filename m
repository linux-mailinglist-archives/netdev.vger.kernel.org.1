Return-Path: <netdev+bounces-273207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIb1D8+Eymmu9gUAu9opvQ
	(envelope-from <netdev+bounces-273207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:12:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420635C9DD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCE2A30576B7
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DA03D75D5;
	Mon, 30 Mar 2026 14:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ujeq4gq/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OiJnLNge"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550893A6B74;
	Mon, 30 Mar 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879713; cv=none; b=XeN4n7Gu92lZxktheH3FVVx4QZumU6eIqBftRy4LL+s8a0p1597DW1ZDcx+wpUulqrOmej7LAPpXcpdt3sEk/b4eu2H4kW+V+8aCv1/CEHdUAy46ir0EhUKVTWVGDDGt98be6fjqcdA7/3zyvacce4acNlyAqQPAxyf/sODoPZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879713; c=relaxed/simple;
	bh=hFayC9XGARLt59gT4kaWnR1VbNh1fXsz2EkVwo5VaTs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IwNiR34bp3gYmbmNiFNHPPgykFPiBJaAiTWf87OG4QJLH00+2VT0b+F3H7wyrLt+u2+5uKL3lmiQolPOYvnFdakIJLKkbgN3vbeAs6dMHG+C+/+T2VNCPgpt3orl7CoJZRLnWLPMZKGfjMRLmJBZ9jP38bD8hm1LcKAmXmhHrQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ujeq4gq/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OiJnLNge; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8BE6514001F0;
	Mon, 30 Mar 2026 10:08:31 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 10:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774879711;
	 x=1774966111; bh=YA2cMrzAK0doTuah/ZCPF1VdfdHNuVkolPMJyy3xMrQ=; b=
	Ujeq4gq/WEs1p9vSUxQnl4+BgdpSA/BJwX+UH36sE3cUoUl9NbUK5T0px/WkCtxb
	AwPrvEM08tMl+HQtlW0+xJx9OvoTyVDQHdmWP0fH8zCmHP93Ap7+9E/ZlIJv2WOq
	hXY2kCz9eOMBNjxbAZeTXb74tp10sTkzbchdrZQp5RBjKaKQ7RkNjyDmGNYVqnKY
	oyK2MOPMa7k4FVcOg12UdYjm3boVAnFHavWlADt+b0vi423d9VekEQ6T+6D8y5hp
	/L4jqAJrjINdAEIiKYH3+ridXSRE+g8i2LyhgSvnAKBfuiY47ckWBIXLHmE7W6r3
	FgYpZVCLDZnvutw1A1AcIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774879711; x=
	1774966111; bh=YA2cMrzAK0doTuah/ZCPF1VdfdHNuVkolPMJyy3xMrQ=; b=O
	iJnLNgetz8UVAbcu0pFZAzaN+3Gvgj1w1+eHn5O7QkgSkE87J0zC7ufehTfbtTaP
	kFnlO567bSql9dIy/f3pQTS8pRYtMjBXQ0NVO+LnOwdiDb7PdceMOwBEv8nya4f1
	8dBwovee+IXOVRnI2p0iHx+MwivIp/49fbYwDruHvncvKc8T60MrO9ReBgjvUbFh
	5FT+f7gwwkwjoRUpb5QPFZAucPMP4if/gZy+HBQ5nKAtlb8W9cna1YA0MV5LYpxn
	b0vxswo0d1PA9lFEGbjajCKzv44cTeUz4lXTBWMRAYregAK+K5bZsqUv1X8T5jan
	q3wJ7z5ShFtCm4MzJ9m5w==
X-ME-Sender: <xms:3oPKaTq1omGJRkJyWauN5SI_d1_T9Aa7x3eBUtdVCtrBlt5o9pZKEg>
    <xme:3oPKaYcZIPrw16hOKq3TPxMCxlcAfzLJer2x8jZKHNbB5OuDen7Pbg0BQOjXhX7Zs
    HOXNBPhAxqVGdZlZSBdJPHFWTmwdmatRoIBaW7_OH6lOuZ90XnLx2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrg
    hrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghr
    mhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehsihhmohhnrdhhohhrmhgrnhestg
    horhhighhinhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdr
    nhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpth
    htoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepihhorghnrgdrtghiohhrnhgvihesnhigphdrtghomh
    dprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtohhm
X-ME-Proxy: <xmx:3oPKaRiNJOojTShCtuheMAtB8IruWvXHg14u1etlAMMfXyZOMDgHkw>
    <xmx:3oPKadlyBcGNLeUN2y2bMID-ML4_QQBEbybAZ8EASUJGTA5IDripwg>
    <xmx:3oPKaQvnNz0RlTq-RJ1yhA8Pa7tzAQHgonuE1xLI43b2ebddUFxe8w>
    <xmx:3oPKaTChOIZ1-laPcx70XQvCNYVo-rZol1ga_fnmGM8QMoMDloN2MQ>
    <xmx:34PKaVqjRYr71F2QCTQc-e6kWnpYnYG_ln7e9MhlOsmoqYv4jFiiKugt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 84D97700069; Mon, 30 Mar 2026 10:08:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsXllcCpWoG-
Date: Mon, 30 Mar 2026 16:08:10 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Ioana Ciornei" <ioana.ciornei@nxp.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <simon.horman@corigine.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Josua Mayer" <josua@solid-run.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Sean Anderson" <sean.anderson@seco.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <d0cf4b6b-39e6-44da-916c-07f935b7ee4b@app.fastmail.com>
In-Reply-To: <20230725205933.yqvdy3h7hewbjosy@skbuf>
References: <20230725204004.3366679-1-arnd@kernel.org>
 <20230725204004.3366679-1-arnd@kernel.org>
 <20230725205933.yqvdy3h7hewbjosy@skbuf>
Subject: Re: [PATCH] [v2] dpaa: avoid linking objects into multiple modules
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-273207-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,kernel,renesas];
	NEURAL_HAM(-0.00)[-0.705];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,arndb.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 8420635C9DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jul 25, 2023, at 22:59, Vladimir Oltean wrote:
> On Tue, Jul 25, 2023 at 10:39:40PM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Each object file contains information about which module it gets linked
>> into, so linking the same file into multiple modules now causes a warning:

A recent change broke my earlier patch, and I noticed I had this
version sitting in my randconfig tree for multiple years now, so
I refreshed it now, sorry for dropping the ball earlier.
 
>> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
>> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
>> 
>> Chang the way that dpaa2 is built by moving the two common files into a
>> separate module with exported symbols instead.
>> 
>> To avoid a link failure when the switch driver is built-in, but the dpio driver
>> is a loadable module, add the same dependency in there that exists for
>> the ethernet driver.
>
> Unrelated change should be separate.

This was fixed independently and is gone from v3

> There was a previous attempt at this before, by Alexander Lobakin:
> https://patchwork.kernel.org/project/netdevbpf/patch/20221119225650.1044591-16-alobakin@pm.me/
>
> but it seems he wasn't persistent enough with it.
>
> Something which I liked better in his proposal was the naming of the
> config option (FSL_DPAA2_MAC) and of the new module (fsl-dpaa2-mac).

I renamed the module, but did not introduce a Kconfig symbol.
The same thing can be done either using Kconfig or Makefile
logic, and I just kept my previous approach here.

>> -obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
>> +obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o fsl-dpaa2-common.o
>>  obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
>> -obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o
>> +obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o fsl-dpaa2-common.o
>
> I am not completely sure how this works. Can fsl-dpaa2-common appear
> both in obj-y (added by $(CONFIG_FSL_DPAA2_ETH)) and in obj-m (added by
> $(CONFIG_FSL_DPAA2_SWITCH))? Olek proposed the introduction of a new,
> hidden and selectable tristate FSL_DPAA2_MAC. At least I understand how
> that works.

Yes, this is a Kbuild feature: if a module is both obj-y and obj-m, it
is built into the kernel and the second one is dropped. The effect is
exactly equivalent to having a silent Kconfig symbol FSL_DPAA2_MAC
that is selected by both others.
  
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("DPAA2 Ethernet core library");
>
> s/core/MAC/ everywhere

Done.

       Arnd

