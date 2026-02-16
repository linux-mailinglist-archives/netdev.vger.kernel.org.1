Return-Path: <netdev+bounces-258915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNZnCUg5k2mV2gEAu9opvQ
	(envelope-from <netdev+bounces-258915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41398145A99
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 357C930048FD
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF9F331230;
	Mon, 16 Feb 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="I4oafzKe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AobOE8cI"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC831195B;
	Mon, 16 Feb 2026 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256133; cv=none; b=K+dSQjjKmyoh6sq6j8grFetQmtG7bpG711CSJHw0vDX/Kw4DifF4xoVxbvTdgLczqc1wnVhs+Z1Jflm84WXEbzYGRG0TQNUcWIJEPotznKkjCYdzvIlhuhy7CmK+YeBSHS5jrVlgZ/p90X5tjhzFIxToiYgaY/YyNoMPX73YYUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256133; c=relaxed/simple;
	bh=GgFZFCwhs+oum4SRPd+XLcStRrtBcbmcx8TYR+yQa2g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=G9ONw9mMENVf6N1p0b8GkH36BacK72GWZu4cqi9RJhtifG/BgPDCv7n9Ta5FhIdys5j4hGmcV02FYepCfTTZ22jINVqDnyOf9tPIEZK1FTYKgheWUVbc58BieOh8CqiBHgwwMe7BQWrre/PVn2pv9HT/6SQESJ7Rg4X1OPDE2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=I4oafzKe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AobOE8cI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66E7214000FC;
	Mon, 16 Feb 2026 10:35:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 10:35:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771256130;
	 x=1771342530; bh=1M9OD1k2FGWLXvm754NldKFt/bnZKjCF3z66kq/k3Ns=; b=
	I4oafzKehXyd8h4iXuRs5H8xYHQUoDxi+/aofsswfWMjCWEBlgrz/r2obTCQi3hF
	jbaMfor+qDeLFm44puXJMxv1eN2LR1s//gAiZD54WhWJA3up73h4swk2wW/ffBf1
	hYnuW819hsFdMQzEbegc5IKawSBN/TvB4CZzJjPE5ovDl/HHG1tix+So/wvIdz5y
	uSvc1LzslQ3dSBjuVHZa8fjqbk/ft6YFv5GlV4cfRCz7HriblpaFK/Xv4qz4J+DR
	uBu2/FhDckVygSaS/GtK/k9F99HVNmd5AzRUTanDUBqHn6L3GJlHZ8RgBi4ygRRv
	8CrLn6WsuVNqATLg5rvv/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771256130; x=
	1771342530; bh=1M9OD1k2FGWLXvm754NldKFt/bnZKjCF3z66kq/k3Ns=; b=A
	obOE8cIlSpad9pyQCXCYS2Hkcz186isPO0ECFmaj1Ck7xTYE1CiJ+1XOw/L49Uom
	UzMfoEI/l0l9ePQn9qm3eWi0WFteNc/p4OkjqWbpmNRbWmWivdl9ZencaXo6/XEB
	cqtp8bpj0H+FvWMY+XoIm0Gto6DJ0FCFk49vgfDAks/06o91x6jHgaJ/CZRbmATP
	3iwIPMWDa9M+SmSV7E8VG7WBcsY+DWky71BkyVm9jSj0X/bZ5L0Iy7+0zfq3YDjl
	WIjK7qPcP88qRiBmzoarpnXCtptsnmWuFxNN8SXRAH8g7VvN7twdr/amb5JJm+xv
	H8M5gTKbirKhZSyzhtAVw==
X-ME-Sender: <xms:QTmTadMkJb6rgsIXCy_GQgVU1_XsNO7G09HljvR28jcxACuMSsJjMA>
    <xme:QTmTaawT-RyI2eUxh8ADQ_znoR6PjFihi3pzMhsL1IcC76xTMS1ybagONq2IdAQl1
    bee1C42ULCXwWpLnHB2bRFTLOExI1anvf8hTrIMgJTfHatZcRPMbRk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudejvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:QTmTadI7eXwDIGtW4uo7qm8YHRUeJnyvMSllNPsPKEjef3ZeukhBrQ>
    <xmx:QTmTafiiX39jwv5OqSl6LY0vJzPIoSt37vjgtHLiR8UKN3bqb0XNUA>
    <xmx:QTmTaR9Vs_EwYkv1GQNBrjCkN_QaeLf64q_ARZwQ6H15p-G9PaPASQ>
    <xmx:QTmTacO31sfPTvA4N3oRypmc7E8LJrOJhenFgiBWcW-XfWdOzHEerA>
    <xmx:QjmTablOBP8Ru11gZLGnP-yEiicyqo9OB9cRFrbtgaTRw7Z-E85tUOUK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B47F470006A; Mon, 16 Feb 2026 10:35:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABuPgj6G8jlB
Date: Mon, 16 Feb 2026 16:34:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Guenter Roeck" <linux@roeck-us.net>,
 "Daniel Golle" <daniel@makrotopia.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, Netdev <netdev@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Message-Id: <c881a13a-0687-4e4d-b70b-900f91acd212@app.fastmail.com>
In-Reply-To: <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
 <306e79fb-f3ee-434e-a90e-547e97d2a5aa@roeck-us.net>
Subject: Re: [PATCH] net: dsa: MxL862xx: don't force-enable MAXLINEAR_GPHY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,arndb.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 41398145A99
X-Rspamd-Action: no action

On Mon, Feb 16, 2026, at 16:17, Guenter Roeck wrote:
> On 2/16/26 04:15, Daniel Golle wrote:
>
> Technically, with "select MAXLINEAR_GPHY", NET_DSA_MXL862 should depend
> on "depends on HWMON || HWMON=n". That would prevent NET_DSA_MXL862=y
> and with it MAXLINEAR_GPHY=y.
>
> Maybe it is time to implement dummy functions for hwmon API calls
> to avoid all this.

I had considered this when I found the build failure, but
I think removing the 'select' here is much better: this
simplifies the dependencies, and allows a valid configuration
with hwmon and gphy support in a loadable module that would
otherwise be impossible.

     Arnd

