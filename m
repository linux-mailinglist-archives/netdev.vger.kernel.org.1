Return-Path: <netdev+bounces-258868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNBYGQcNk2nw1AEAu9opvQ
	(envelope-from <netdev+bounces-258868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:26:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99376143540
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 13:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25BF3007CBE
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 12:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1298A30E0E0;
	Mon, 16 Feb 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KW//vJ3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l/Y0IxSa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF182C08AC;
	Mon, 16 Feb 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771244804; cv=none; b=gVaw0+5gUTfmvF7he6x+S4WgPkRgrb0gKGkfBp4d0VQW8iuJkHmfcaulmwEO0D9iPtLHSjiJVqi5rbgv4kxcTGB5vPT8wDCod9T2Eord0c/sdnhCRywmMxqqWSazCvpftz1eFmtJKrT/hjKU1yv/dcp5tZi04mB/k6aCcf9Vovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771244804; c=relaxed/simple;
	bh=fPxjZCK7De6NDjiMjLNyqxBEWy3t8LcYSfNjKuyAUYM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kV9kcfVtGlKH+Vo/zeP3fwzCI8rFhRdZp0ygOPBkGZAXpd7lAGEC0a+GDrp5OukAcU+zwkUNvSVyIkwgALVCpO1xFNNf9IAgapzEFJNtnljyhFkzTLxUuFbf0utrovLLKQyJR+ygve3xnhgyeHdOv0c2xP35KDnlEOWCpIfywAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KW//vJ3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l/Y0IxSa; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3161140002D;
	Mon, 16 Feb 2026 07:26:41 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 16 Feb 2026 07:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771244801;
	 x=1771331201; bh=2++ADpinTnvZesqAdX3b86NNjaDofYy1bfNpxSentKM=; b=
	KW//vJ3kUQwwDhr+ErDoy6/bAq+MJEXlYSQEZS37ILzhWuNDoqUqfMDirQqsUYqZ
	4ffYZzXr5x55NFadMyR7JACg9wWRNA1r3rWdW9VgYeXoNlFu8c1Zqj5uFVDQkYDU
	qPRzBiWh7LrtW0dX6PeoI7xDY0AbX3hplbcZ6b91pWpxSQByzaaPgjsIL4TfogpR
	q/FO2GmChFpVrZx4vkmKJfQ3x0VEhqhntRLAtSLTyE32GWNTF+9XXyjyqO5nCozF
	eUeSdiIWCKJpt9925lMj887MdfoqcdFUCxNi9fMclUi3cRFL8N41UlO1rqXVXaY7
	dPYlS9eNdjALdkncm/2gxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771244801; x=
	1771331201; bh=2++ADpinTnvZesqAdX3b86NNjaDofYy1bfNpxSentKM=; b=l
	/Y0IxSaLG52Qt8z+lG0QuINl34oyfAJ6KF5yf2EMrhe2jKVHlM4KCgnNvVUdJwc1
	65tUMFyflYESDn68ngepIbo62x/n+RgCUGF6s0qpCIxB45D0wl+w5XNdMLdsIvs/
	TlvD1i/z7Hv5jyFTYhnthcugfYSX1cz6v6h4ssR+R+zCCJRUbTFQpp0B8dkBRrrF
	UzQKMSjWpDl+oTTJRSYkPK4vgwSnwhpi0qMWYvRGpWgaCfWTOgdTLvuDAXuI1dmw
	gmutw2xeMY+OO54i43Qu3aW8HdHR/SKR8eHt1HlqIpFJWcKRdtKbMFIGXNkMcU3Q
	r+ahvU8G8VFzI09k8T3ZQ==
X-ME-Sender: <xms:AQ2TaSTV_CeGqXEvjae6yWNeJFAQb001NV-7D2Bid54VGtsZ6eEgBw>
    <xme:AQ2TaSns477OnlLKMdeLN6EfbsUrE5fBqbakztA7QRgQkzXYQVctt5DAQO2SlO3tA
    HLHPIIWnbvwICcxN0qUj2PrNpVeSOuqeUIK3WWGnJKIAYwf-xqppsnj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeikeejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:AQ2TaWMbwdkYKkCsae9zqquckX7f51lrd_z6qM0X9QFFSt7deC6tgQ>
    <xmx:AQ2TabUZgqGqaLHqvqwhT-Swm2zieu5PjjixAUHcpJuxSvBzSjvuoQ>
    <xmx:AQ2TaZixSc3O7Gyq7uG-4n_ATCjpXO2wzhF9vVyzQ289XXuyfiuBtg>
    <xmx:AQ2TaUjNfIur7URufAlnokS-oW9paLbwqbBfb7yu11nbwX63OTKhCA>
    <xmx:AQ2Tad4JlaICVel1jrFrcC2MhUDJvO3-gfrAzs1-FiQLWqTx8ZbZJqwE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3D8CE700065; Mon, 16 Feb 2026 07:26:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABuPgj6G8jlB
Date: Mon, 16 Feb 2026 13:26:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Golle" <daniel@makrotopia.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "Vladimir Oltean" <olteanv@gmail.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Guenter Roeck" <linux@roeck-us.net>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Message-Id: <5a058ebc-fb35-410b-b73f-716681c10a2f@app.fastmail.com>
In-Reply-To: <aZMKXavVQPelSXcG@makrotopia.org>
References: <20260216105522.2382373-1-arnd@kernel.org>
 <aZMKXavVQPelSXcG@makrotopia.org>
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
	TAGGED_FROM(0.00)[bounces-258868-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,roeck-us.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99376143540
X-Rspamd-Action: no action

On Mon, Feb 16, 2026, at 13:15, Daniel Golle wrote:
> On Mon, Feb 16, 2026 at 11:55:17AM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The newly added dsa driver attempts to enable the corresponding PHY driver,
>> but that one has additional dependencies that may not be available:
>> 
>> WARNING: unmet direct dependencies detected for MAXLINEAR_GPHY
>>   Depends on [m]: NETDEVICES [=y] && PHYLIB [=y] && (HWMON [=m] || HWMON [=m]=n [=n])
>>   Selected by [y]:
>>   - NET_DSA_MXL862 [=y] && NETDEVICES [=y] && NET_DSA [=y]
>> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_probe':
>> mxl-gpy.c:(.text.gpy_probe+0x13c): undefined reference to `devm_hwmon_device_register_with_info'
>> aarch64-linux-ld: drivers/net/phy/mxl-gpy.o: in function `gpy_hwmon_read':
>> mxl-gpy.c:(.text.gpy_hwmon_read+0x48): undefined reference to `polynomial_calc'
>
> I assume this happens in case CONFIG_MAXLINEAR_GPHY=y and
> CONFIG_HWMON=m, right?
>
> None of the PHY drivers seem to adequately prevent such situations,
> which in my opinion would be worth correcting, ie. by preventing any
> PHY driver using HWMON from being built-in while CONFIG_HWMON=m.

As far as I can tell, the dependency in MAXLINEAR_GPHY does
address this correctly.  We are however a bit inconsistent in
how we pick the PHY drivers in general. Almost all ethernet
drivers expect the user to enable the correct phy separately,
but there are a couple of exceptions that force a specific one:

drivers/net/dsa/Kconfig:        select BCM7XXX_PHY
drivers/net/dsa/Kconfig:        select MEDIATEK_GE_PHY
drivers/net/dsa/Kconfig:        select VITESSE_PHY
drivers/net/dsa/realtek/Kconfig:        select REALTEK_PHY
drivers/net/ethernet/8390/Kconfig:      select AX88796B_PHY
drivers/net/ethernet/broadcom/Kconfig:  select BCM7XXX_PHY
drivers/net/ethernet/hisilicon/Kconfig: select MARVELL_PHY
drivers/net/ethernet/hisilicon/Kconfig: select MOTORCOMM_PHY
drivers/net/ethernet/hisilicon/Kconfig: select REALTEK_PHY
drivers/net/ethernet/micrel/Kconfig:    select MICREL_PHY
drivers/net/ethernet/micrel/Kconfig:    select MICREL_PHY
drivers/net/ethernet/realtek/Kconfig:   select REALTEK_PHY
drivers/net/ethernet/smsc/Kconfig:      select SMSC_PHY
drivers/net/ethernet/stmicro/stmmac/Kconfig:    select MOTORCOMM_PHY
drivers/net/ethernet/wangxun/Kconfig:   select MARVELL_10G_PHY
drivers/net/usb/Kconfig:        select MICROCHIP_PHY
drivers/net/usb/Kconfig:        select AX88796B_PHY
drivers/net/usb/Kconfig:        select SMSC_PHY

We could probably drop most or all of those as well, but that risks
regressions with existing defconfig files.

      Arnd

