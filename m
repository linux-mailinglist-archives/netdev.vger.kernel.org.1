Return-Path: <netdev+bounces-258926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP2NEPtGk2mi3AEAu9opvQ
	(envelope-from <netdev+bounces-258926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:34:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6781463B3
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 17:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667F9305ACB5
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FC0332EA9;
	Mon, 16 Feb 2026 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="HDf1VCwl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R/b+qeHO"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EE31A051;
	Mon, 16 Feb 2026 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771259286; cv=none; b=R75kkqnRaiWaUJns6Hu8vglFbjxg9ma5k7fucNwz4MRXzZfq/KSOSbRxqUhAVmImMlPrzapuv2OVxCnA6oMMuiRoCE3HVwQpvABZz8ltRqs/S1li+gnEbgUyQ9nal3+j02AzjYNgew+6hcTCMnfLFVdrauQbvNnUby1766mq9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771259286; c=relaxed/simple;
	bh=DxfnFkyKJVMGTyOCW8lUOhCWwAKvXMljswjv2mgUGJY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MCetTqP4i6lJOcDGxKoNKevcrB0i4Kjim658qLWImMs5XLHleWeSrr8dxqfAMicpnl6NBUl2uJq3qVdQl36Ik/YQZNJ+BgJ+V4Q0D7SVpaCD+lvCLpKgE3KAu3DFf0ztDyP7TCvjEVOAYhtDWDGxy4OteklaTBa9/w164eD0iZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=HDf1VCwl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R/b+qeHO; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 639D81400024;
	Mon, 16 Feb 2026 11:28:04 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 11:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771259284;
	 x=1771345684; bh=1Yl0Y9bvubAtUFocle2sVeYCdqu4O5AiOcYxmmV1DTc=; b=
	HDf1VCwl6cbD029CDJD8SKrYlXf8UYtOWonsP8qk9b/YtOVbjQFQUnL4IkgRZwl9
	3r1kOpaODHiXqTBqIUehTikYIXnUUOaXfKnIw+OT4l+DCBugIhi/D1MiX+jL4uIY
	pxHAXTpdgXI3+7QQxWgmJ/Szc9F4a56JGkJgSrtjI0NzwUG50q3kwEsMLs1499Gf
	CDDLcA4QA6tr4Oz+96ultvsIg4JDvs/U9Nt3wd9M/LVVnAhJRhtyqpWRdKRo00Ts
	EsML26msUSPJAlUCB/VeGyUnlVaQSGTqUt9QwxaWfvvP+grDDTxtQFLjmEnmLwjZ
	EeTK7KZLbjmb0heRs6lhPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771259284; x=
	1771345684; bh=1Yl0Y9bvubAtUFocle2sVeYCdqu4O5AiOcYxmmV1DTc=; b=R
	/b+qeHOj8MhcWHddaNIyxoShuO7e/N5vgQplGSEULo8c3Kdna8mQlKoHi5onshMh
	CJdJeUqSLWPXB/vtbrJpvJlwlogXq8p1ManSc9dCopEZWdEIkUkQ7V0l94Y9RnhP
	hlK6sukLkNlcNiofEyF83en4vTbycHHy7mlF7e5l6wLEjVkCXVYNie60NRSwVqz6
	PC+E6IrDQfQb7T1rLmbdxa7vw1icPrGxXDIBYofVmqxopBdnD+aXadSazeQ2lz33
	yzdhyw9yHrIZN+QQi2TyGFK9AepFcbhsK4Z6TLSeup4On1CHh/5QCm9sJIbFN+T3
	y6AuTTju4O6sNnqD/ugcg==
X-ME-Sender: <xms:lEWTaZ3PY3S3Z_ws5zjrWyRQG0EMJA-0OJ0Ny336QC9jPiHJbmZCAg>
    <xme:lEWTaa5HUaHcVuarhaXZeqTqTWhxSyOuC1I0qA7TEoJNd_BwxFmE2ArwSupZ1dUPq
    J04e18q2URScQmcAZJ-vvm4ySwCTIhFHY2O0qHf6ZkGrF2gEruLC1U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopegvughumhgriigvthes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgif
    sehluhhnnhdrtghhpdhrtghpthhtohepuggrnhhivghlsehmrghkrhhothhophhirgdroh
    hrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
    lhhinhhugiesrhhovggtkhdquhhsrdhnvght
X-ME-Proxy: <xmx:lEWTaRyHozYazLRknExXjsLZvAXHoBcF9w0mNo8rsWVg02q1mEdlIg>
    <xmx:lEWTaXotPlcR9kidGmWg2zxff3gBCDykMrAWb1zqrAnxGDruKo6zug>
    <xmx:lEWTaXkavTeauyZhw8V6nmtFrSHaUx_vaDqloeNekt1aT9kruofgsQ>
    <xmx:lEWTaRWbRlyr3u_GArY_g9PGWvhFtUClXpRx168KeJPKN7LHJ47v6Q>
    <xmx:lEWTaUtOwqse-29Swr9CxLmUnqDy6XBaOW0SWwZ2Mmqc2c-BIWqZHN_4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E685B700065; Mon, 16 Feb 2026 11:28:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABuPgj6G8jlB
Date: Mon, 16 Feb 2026 17:27:42 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Golle" <daniel@makrotopia.org>,
 "Guenter Roeck" <linux@roeck-us.net>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Message-Id: <316a6ee6-9e5e-4518-8dc4-2f39805934a9@app.fastmail.com>
In-Reply-To: <aZNEKS-fefEgqhTs@makrotopia.org>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
 <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
 <aZNEKS-fefEgqhTs@makrotopia.org>
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arndb.de:dkim]
X-Rspamd-Queue-Id: 9B6781463B3
X-Rspamd-Action: no action

On Mon, Feb 16, 2026, at 17:22, Daniel Golle wrote:
> On Mon, Feb 16, 2026 at 08:20:41AM -0800, Guenter Roeck wrote:
>> On 2/16/26 07:34, Arnd Bergmann wrote:
>> > On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
>> > > On 2/16/26 04:15, Daniel Golle wrote:
>> > > 
>> > > Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
>> > > on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
>> > > and with it MAXLINEAR_GPHY=y.
>> > > 
>> > > Maybe it is time to implement dummy functions for hwmon API calls
>> > > to avoid all this.

I think I misread this bit earlier, sorry

>> > I had considered this when I found the build failure, but
>> > I think removing the 'select' here is much better: this
>> > simplifies the dependencies, and allows a valid configuration
>> > with hwmon and gphy support in a loadable module that would
>> > otherwise be impossible.
>> > 
>> 
>> Makes sense. I think I'll move forward with the dummy functions anyway
>> because with that the #ifdefs in drivers are no longer necessary
>> and the "depends on HWMON || HWMON=n" becomes optional.
>
> Yes, that would be great and eliminate that whole class of obstacles
> with some inline no-op stubs in the header.

What I meant above is that I had considered and rejected the extra
dependencies in the ethernet driver. I don't think there is a good
way to add inline helpers. Technically, one could use IS_REACHABLE()
here, to stub out the functions when the caller is built-in, but
I find that even worse because it replaces a trivial build-time
failure with very subtle runtime bug.

      Arnd

