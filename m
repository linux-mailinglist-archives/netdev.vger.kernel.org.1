Return-Path: <netdev+bounces-307006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+lTGUBcVGpjlAMAu9opvQ
	(envelope-from <netdev+bounces-307006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:32:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4BB746F06
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:32:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alliedtelesis.co.nz header.s=mail181024 header.b=xbZewW7j;
	dmarc=pass (policy=quarantine) header.from=alliedtelesis.co.nz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307006-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307006-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09A14301FD62
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21643314AC;
	Mon, 13 Jul 2026 03:30:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32232F748
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 03:30:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913440; cv=none; b=sb/3XAOcfe+tO/bzeSt7xI3mYteMkfIU8Bjlw7AXE3Wa8q3HRK6kP7vrOJh5+yS7YSgjO8PnUFX8lnBWQ5sRmpo2BXjJlNYnLv2mA0AxXe4zT8anF066UBhU0GNCJ70OaeJi0RUnMkmxI12ZRBViNweJbdXNXMQHdwxIYNzvsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913440; c=relaxed/simple;
	bh=2clG83VhZGz+0fVJd7IOdQ2BBqXOuZZYZB7zi6SYgoY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWyQLg7TvikZcIugYrHxfSTUAWvtXuizTulzduh9mKMtixP1PbVsYZK65NcTNo/GL8zDt/FkQLwbhlx2Jev5ITlN5W6l79QfmHlMQwQC1H76M1x7CogKTN1q630o61oSnM57k51xJUmXVQP8OZsihGqecLf99SM8jiOnqzKKTqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xbZewW7j; arc=none smtp.client-ip=202.36.163.20
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 3D54B2C03DB;
	Mon, 13 Jul 2026 15:30:35 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1783913435;
	bh=2clG83VhZGz+0fVJd7IOdQ2BBqXOuZZYZB7zi6SYgoY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=xbZewW7jP/Gh5pfqKRafGojp8gO74REJRBLxOnZ/RlyB12Zm8eT+o2AOL4AhWpJxB
	 O6QmBaOUOvHlZhmlT6onxhhgvsZIO0lCkzDjy3deBLpjiQhQNrbAccJl9bBD56gpms
	 HrpzdW02JwUgkE0rBT5LYXlyqSPakS29MgsP+zNg+g7Xce2U3aNHw5+ZVEVLJiL5fm
	 Pxm5ASs4UPZTq76mv1LpeQ0Rm+sWQnaHoEePX+GzP7T9O2DNg+Ay/DJ4SOjGdssoZB
	 4LKV/vgmCpEZZKxQZ+FgQv906JIjSb78/Rja6SRTtqf+VeuD5WvwURz+KmMvS/xp4x
	 9Zcg+IwvDniTg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a545bdb0001>; Mon, 13 Jul 2026 15:30:35 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Mon, 13 Jul 2026 15:30:34 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Mon, 13 Jul 2026 15:30:34 +1200
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
Thread-Index: AQHdCnU25IxsSStIXU2TivaqAyBQrLZaEDQAgAAThwCAANQDgIAG4eYAgAD8xQCABztvAA==
Date: Mon, 13 Jul 2026 03:30:34 +0000
Message-ID: <3c585db4-364e-4b6f-a946-535887209702@alliedtelesis.co.nz>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
 <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
 <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
 <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>
 <0c9c5fe2-6b91-42d2-8582-80f9a47df827@lunn.ch>
In-Reply-To: <0c9c5fe2-6b91-42d2-8582-80f9a47df827@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <C085E2F9F678744EA850E820B52C6FF1@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=TI3mSEla c=1 sm=1 tr=0 ts=6a545bdb a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=GE29vkJnOosA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0zmtXMD5vJBTacGzs_EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zY0JdQc1-4EAyPf5TuXT:22
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
	TAGGED_FROM(0.00)[bounces-307006-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:Chris.Packham@alliedtelesis.co.nz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Ben.Brown@alliedtelesis.co.nz,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alliedtelesis.co.nz:from_mime,alliedtelesis.co.nz:dkim,alliedtelesis.co.nz:mid];
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
X-Rspamd-Queue-Id: 7C4BB746F06

DQoNCk9uIDcvOS8yNiAwMTowNCwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+Pj4gTGV0cyB0YWtlIGEg
c3RlcCBiYWNrLg0KPj4+DQo+Pj4gV2hhdCBzb3J0IG9mIHJlc2V0IGFyZSB3ZSB0YWxraW5nIGFi
b3V0PyBTb2Z0d2FyZSBvciBoYXJkd2FyZT8NCj4+Pg0KPj4+IAlBbmRyZXcNCj4+DQo+PiBJdCBp
cyBkb2luZyBhIGhhcmR3YXJlIHJlc2V0IHVzaW5nIGEgR1BJTyBsaW5lLg0KPj4NCj4+IFdoZW4g
bGlua2VkIGRvd24gdGhlIHBoeSBnZXRzIHB1dCBpbnRvIHJlc2V0IHVzaW5nIGEgaGFyZHdhcmUg
R1BJTyBsaW5lLA0KPj4gZHVyaW5nIGxpbmsgdXAgdGhlIHBoeSBpbml0aWFsaXplcyB0aGUgaGFy
ZHdhcmUgdXNpbmcgcGh5X2luaXRfaHcoKSwNCj4+IHdoaWNoIGRlLWFzc2VydHMgdGhhdCByZXNl
dCBHUElPLiBUaGVuIHRyaXZpYWwgc2V0dXAgaXMgZG9uZSBiZWZvcmUNCj4+IHRoZSBkcml2ZXIg
c3BlY2lmaWMgY29uZmlnX2luaXQoKS4NCj4+DQo+PiBXaGVuIHdlIGFyZSBkb2luZyB0aGUgbWFy
dmVsbCBtODhlMTUxMF9jb25maWdfaW5pdCgpIHRoZSBmaXJzdCBwYWdlDQo+PiB3cml0ZSBpcyBu
b3QgYXBwbHlpbmcgc28gaXQgZW5kcyB1cCB3cml0aW5nIGNvbmZpZ3VyYXRpb24gdG8gdGhlIHdy
b25nDQo+PiByZWdpc3RlcnMuIFdoZW4gdGVzdGluZyBmaXhlcyBhZGRpbmcgYSAxNXVzIHNsZWVw
IGJlZm9yZSBjaGFuZ2luZyB0aGUNCj4+IHBhZ2UgYWxzbyBtZWFudCB0aGUgcGFnZSB3YXMgdXBk
YXRlZCBjb3JyZWN0bHkuDQo+IA0KPiAgICByZXNldC1ncGlvczoNCj4gICAgICBtYXhJdGVtczog
MQ0KPiAgICAgIGRlc2NyaXB0aW9uOg0KPiAgICAgICAgVGhlIEdQSU8gcGhhbmRsZSBhbmQgc3Bl
Y2lmaWVyIGZvciB0aGUgUEhZIHJlc2V0IHNpZ25hbC4NCj4gDQo+ICAgIHJlc2V0LWFzc2VydC11
czoNCj4gICAgICBkZXNjcmlwdGlvbjoNCj4gICAgICAgIERlbGF5IGFmdGVyIHRoZSByZXNldCB3
YXMgYXNzZXJ0ZWQgaW4gbWljcm9zZWNvbmRzLiBJZiB0aGlzDQo+ICAgICAgICBwcm9wZXJ0eSBp
cyBtaXNzaW5nIHRoZSBkZWxheSB3aWxsIGJlIHNraXBwZWQuDQo+IA0KPiAgICByZXNldC1kZWFz
c2VydC11czoNCj4gICAgICBkZXNjcmlwdGlvbjoNCj4gICAgICAgIERlbGF5IGFmdGVyIHRoZSBy
ZXNldCB3YXMgZGVhc3NlcnRlZCBpbiBtaWNyb3NlY29uZHMuIElmDQo+ICAgICAgICB0aGlzIHBy
b3BlcnR5IGlzIG1pc3NpbmcgdGhlIGRlbGF5IHdpbGwgYmUgc2tpcHBlZC4NCj4gDQo+IA0KPiBX
aGF0IGRlbGF5cyBhcmUgeW91IHVzaW5nPw0KPiANCj4gICAgICAgQW5kcmV3DQoNCldlIHdlcmUg
bm90IHVzaW5nIGFueSBvZiB0aG9zZSBkZWxheXMgYXMgSSBkaWRuJ3Qgc2VlIHRob3NlIG9wdGlv
bnMuDQpBZGRpbmcgYSBkZWxheSBmaXhlcyBvdXIgaXNzdWUsIHNvIHRoaXMgcGF0Y2ggaXMgbm90
IG5lZWRlZC4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHRpbWUsDQpCZW4=

