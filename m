Return-Path: <netdev+bounces-304316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ml7gDuz+RmpngQsAu9opvQ
	(envelope-from <netdev+bounces-304316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:14:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 452C06FD92C
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:14:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alliedtelesis.co.nz header.s=mail181024 header.b=obBNV4Lh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304316-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304316-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=alliedtelesis.co.nz;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F49E300B055
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B8F286AC;
	Fri,  3 Jul 2026 00:14:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22E5695
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:14:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783037671; cv=none; b=jOB1Dgne0+afwJFr3CdR6V/3RKeC8iXFge+IOBoplwYB3hy5hbhSPYNo2QdehqQ0De9Eof9J1P1pRizC2i2W3XNNK/GuzFAyb23B3Ya8sVNc4oBc30mL2DTfMUgfJXLQUU2tVIqkuZLvmk4qNkKfua68VsfpozhbRNVwJcy1zQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783037671; c=relaxed/simple;
	bh=KlhtLlgt89+Bs8w521mb12f8K+7RwFZOa+pewcCf6EU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ya+jjtKsRYi5FPEEejl7rdDjcJQciHO4ZLB7N/Ot94XThw2SyWJPBjItpNoygJ3q1wfOly7jQr7wyRHF17KTARDj1+R4Hhh2EiDT4Lb+5OEk6Xsm+EUTV+wIfu4XyPmi+6I49UsS8jNfgkLKyDDaMf/xWM7PAW/0FlBP5LycV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=obBNV4Lh; arc=none smtp.client-ip=202.36.163.20
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0D0FA2C04D3;
	Fri,  3 Jul 2026 12:14:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783037667;
	bh=KlhtLlgt89+Bs8w521mb12f8K+7RwFZOa+pewcCf6EU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=obBNV4Lh8kLGp7FMJNn2DSv2fRnU6q0O7JL13cBDBMS4uqbkcZW6ys9TlhOmrcskk
	 ClybzdJ0VjwBP2r6ggnIrL/TwSOfG1ZNaZKjo/Xrr6q3gkCDuEwAKq/a8vVARBHxG9
	 iXwxzqLvtcQ9wjHzgHHsBnFJp+prcYV3M50nLswN9/2mBZodWmnRjs4Vvz/mPU1CNh
	 QhycbSlh2AR/n6pas0hP4l9hFXD0NfXK/uOlFfULl0V8qE/iZzVyWIQ64qBysWloGk
	 IotdhjkRqPTT5SmTr4uDH/atvmrZLe53tjHfavEie8ovj723kYwzQam1GHEj1QhIgf
	 SC32tNyaKmc8g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a46fee20001>; Fri, 03 Jul 2026 12:14:26 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 3 Jul 2026 12:14:26 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Fri, 3 Jul 2026 12:14:26 +1200
From: Ben Brown <Ben.Brown@alliedtelesis.co.nz>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Chris Packham
	<Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Thread-Topic: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Thread-Index: AQHdCnU25IxsSStIXU2TivaqAyBQrLZaEDQAgAAThwA=
Date: Fri, 3 Jul 2026 00:14:26 +0000
Message-ID: <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
In-Reply-To: <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <267C638AE3A555458BE34035E87E8582@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a46fee2 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=GE29vkJnOosA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=-pb2v2eUWDIIKyzDtCIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alliedtelesis.co.nz,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alliedtelesis.co.nz:s=mail181024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-304316-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:Chris.Packham@alliedtelesis.co.nz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Ben.Brown@alliedtelesis.co.nz,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ben.Brown@alliedtelesis.co.nz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[alliedtelesis.co.nz:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 452C06FD92C

DQoNCk9uIDcvMy8yNiAxMTowNCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDAz
LCAyMDI2IGF0IDEwOjUwOjM0QU0gKzEyMDAsIEJlbiBCcm93biB3cm90ZToNCj4+IFdoZW4gYnJp
bmdpbmcgZG93biB0aGVuIHVwIHRoZSBsaW5rIG9uIGEgODhlMTUxMiBwaHkgYSBsaW5rIGlzIG5v
dA0KPj4gZ2V0dGluZyBlc3RhYmxpc2hlZC4gVGhpcyBpcyBiZWNhdXNlIHRoZSBwaHkgaXMgY29t
aW5nIG91dCBvZiByZXNldCB0aGVuDQo+PiBpbW1lZGlhdGVseSBnZXR0aW5nIGNvbmZpZ3VyZWQu
IER1cmluZyBjb25maWd1cmF0aW9uIHRoZSBwYWdlIGlzDQo+PiB1bnN1Y2Nlc3NmdWxseSB1cGRh
dGVkIGNhdXNpbmcgd3JpdGVzIHRvIHRoZSB3cm9uZyByZWdpc3RlcnMuDQo+Pg0KPj4gQWRkIHRo
ZSBzb2Z0IHJlc2V0IGZ1bmN0aW9uIHRoYXQgZG9lcyBhIHJlc2V0IHRoZW4gcG9sbGluZyByZWFk
IHdhaXRpbmcNCj4+IGZvciB0aGUgcGh5IHRvIGNvbWUgYmFjayBvbmxpbmUsIGF0IHdoaWNoIHN0
YWdlIHRoZSBwYWdlIHJlZ2lzdGVyIGNhbiBiZQ0KPj4gdXBkYXRlZCBzdWNjZXNzZnVsbHkuDQo+
Pg0KPj4gVGhpcyB3YXMgdGVzdGVkIG9uIGEgODhFMTUxMiBwaHksIHVzaW5nIGlwIGxpbmsgdG8g
YnJpbmcgdXAvZG93biB0aGUNCj4+IGxpbmsuDQo+IA0KPiBXaGF0IG1ha2VzIHRoZSA4OEUxNTEy
IHNwZWNpYWwgdGhhdCBpdCBuZWVkcyB0aGlzLCBidXQgbm8gb3RoZXINCj4gTWFydmVsbCBQSFkg
ZG9lcz8NCj4gDQo+IAlBbmRyZXcNCg0KVGhpcyBtYXkgYmUgbmVlZGVkIG9uIHRoZSBvdGhlciBt
YXJ2ZWxsIHBoeXMsIGJ1dCBJIG9ubHkgaGF2ZSBhY2Nlc3MgdG8gDQphIDg4RTE1MTIgcGh5IHNv
IEkgYW0gb25seSB1cGRhdGluZyB3aGF0IEkgaGF2ZSBzZWVuIHRoaXMgb24u

