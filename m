Return-Path: <netdev+bounces-259826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEeCIWXAmWlDWgMAu9opvQ
	(envelope-from <netdev+bounces-259826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 15:25:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B503516D052
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 15:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F7743002D0C
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C21E5724;
	Sat, 21 Feb 2026 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cc7wubvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXwF0A3f"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C51156F20;
	Sat, 21 Feb 2026 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683935; cv=none; b=dVWawapUHDWFb0vV+S6gdePCjo2nykBh5ez8KbRWVKqectEcMkgL4Ig/nOhq8YOQWxAhrDddvoHSKasHhwfWz10HJ5DE5OCft/mtRtQ52jK8W+4BphyWyBEOzvoSp9Ljxm3YJ8aB9Wcvbhtke9P9xLq+GsdDMVdzwzDKqOrlZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683935; c=relaxed/simple;
	bh=otMyq/aQ3qug49eFV1PgpQjmdBBXQNS8WTZj5UYz3/8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gxw7wZCVPrccLD9S5fR1BPnMmXq18YEaq99IpAK8oZmss0l25wfUMiL/Kt3fK5PsdyzWA5uOH3cPVc5ojT5XiItQqPeMjEzhgBcdCLO1xrOK8gXEAjpvIKyP4loNHEWGOhH/gDpWnjfFmlxCCVjSDOTbosbmqJCjyuxMJDr6hBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Cc7wubvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXwF0A3f; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8D9B114000AF;
	Sat, 21 Feb 2026 09:25:32 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 21 Feb 2026 09:25:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771683932;
	 x=1771770332; bh=GFuuMBED/UJaIkcfl/purSOfaX3aDg7So0nftdQcupg=; b=
	Cc7wubvGSlVCzIGR4PFcGRLjg2jbz0QNqUNGQCkKC8WxAK3FH0mRmvgWizTkEAdz
	Zp6wvxCnfFVGHnTpEpm1YwNt3polZYWMky4g8jMaCmXTkOPslCwxY33A17nCzrb2
	16zyofTpKb2jbJx2Bi5Ir65B9LDPzHM7+uX8xDvBoUWayfZDrJIpd6eFsiuDDxua
	zHosKu9mHbtuxGBmdZPXhIX+PsbnZGZjMyx1rNgfrRykNBz4nLAw+kjmQa326Sar
	5rE9HzpwU2G28EADonHnlqQl38wYau3P4atRGoddTTiH3HavaHmwOHy7I7A3Wf+f
	+JYCmCzl4pJSvOBYmpojsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771683932; x=
	1771770332; bh=GFuuMBED/UJaIkcfl/purSOfaX3aDg7So0nftdQcupg=; b=T
	XwF0A3fSWkILfVh8WoG70+zGpGTm0kSKrMh2KOla/rb07ZRFLoK335pvqL9d/IPY
	9YHh8visIVsQHr6y4IXVgduOyyMONeYNKQ+sZrcyscNGN9McMmUIEXZQO//uFMGw
	DoZRvfO+kLkNpbig+KElLU6+ZtvmUsfvOeCxbeY+HbPq5vO9MNUcIWv07NPuXoEH
	yP/HRJyKeHcaU4fKvWDjAsiszodjbfZEF7SBCGQuZgXKZ9uL89Z/JjzDyz8Bcdy7
	v3hdabEqMTXPCIY1yfWQhcTDfquZtotTKpb52FLnnx1/932brIzdrUx6dlyqJRy4
	9edPA1/uUxFf77ZzB8yow==
X-ME-Sender: <xms:W8CZadez4PC9mSPnfZ98qm2--th0e6uljFFDjREMi_IddhZFrvgVfg>
    <xme:W8CZaWCQAol7kIkiPydT4f5zeW5UNZ6uMSyAfXF8fPoJlbAyqanYBPDkJYGMZJiBC
    aFhxU9FDSJ-wFJDZN8l4KwRhheLqwM5YbDfPaVrGSkQLpCPilWlqfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeduiedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:W8CZadY3GJ5GAkuESU9NxIfDG1aHqfh_p8GICEugtLki4_ZA_sBN8w>
    <xmx:W8CZaayILHKj1rV30vE-eddt6J3Zda1tJh1-I6n--JO-UAf969JIpQ>
    <xmx:W8CZacPaQEM5dmvyfubcJR9p7LITw2oNxou2nbHBjnsMF2ltfKYNPQ>
    <xmx:W8CZaZf2WRLHfOamQj3U73JbfhpYx5XCo0lpmMC4A20b1OTs_WhBIw>
    <xmx:XMCZaQ38u20kVn5RQMlbt38Cmi5PDgI-fmGfNd5oTIXo90RYtTydTrx3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DA248700065; Sat, 21 Feb 2026 09:25:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABuPgj6G8jlB
Date: Sat, 21 Feb 2026 15:24:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Daniel Golle" <daniel@makrotopia.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Message-Id: <3deb6138-e331-4e35-bc56-653a0a741a46@app.fastmail.com>
In-Reply-To: <9d7aee5a-ac46-47d9-ac26-0f3a63b6a8ab@roeck-us.net>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
 <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
 <70a195ab-3b61-47fb-a361-17b53cf7bdda@roeck-us.net>
 <aZNEKS-fefEgqhTs@makrotopia.org>
 <316a6ee6-9e5e-4518-8dc4-2f39805934a9@app.fastmail.com>
 <9d7aee5a-ac46-47d9-ac26-0f3a63b6a8ab@roeck-us.net>
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-259826-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B503516D052
X-Rspamd-Action: no action

On Sat, Feb 21, 2026, at 02:25, Guenter Roeck wrote:
> On 2/16/26 08:27, Arnd Bergmann wrote:
>> On Mon, Feb 16, 2026, at 17:22, Daniel Golle wrote:
>>> On Mon, Feb 16, 2026 at 08:20:41AM -0800, Guenter Roeck wrote:
>> 
>> What I meant above is that I had considered and rejected the extra
>> dependencies in the ethernet driver. I don't think there is a good
>> way to add inline helpers. Technically, one could use IS_REACHABLE()
>> here, to stub out the functions when the caller is built-in, but
>> I find that even worse because it replaces a trivial build-time
>> failure with very subtle runtime bug.
>> 
>
> Lots of kernel APIs have dummy implementations. hwmon isn't really that
> different to those. Also, arguably, that would not be a subtle runtime
> bug but a feature.

I would argue that all of them are wrong. I currently count 33 uses
of IS_REACHABLE() in header files, which is not a lot, but I would
prefer replacing these with proper Kconfig dependencies than to
add more for cases we already handle correctly.

     Arnd

