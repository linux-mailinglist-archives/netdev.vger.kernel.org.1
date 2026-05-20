Return-Path: <netdev+bounces-289706-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLbJA9QWDWq5tAUAu9opvQ
	(envelope-from <netdev+bounces-289706-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:05:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E576586B34
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDDC3005D0B
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 02:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DA02DAFCB;
	Wed, 20 May 2026 02:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="X82Qn6g5"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0041CDFCA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242684; cv=none; b=cuy11DBGau4MPBzceDXk3HzEzMJJw4IE9UWQP7VjUtFPfBdGp0qFWi8fdc+e7AiKgQKeRvXC9DT1+dB8W7CNQh5X8JwzWv+DDT27dHLiV1XOr18ZzDdh3jWBmom++DuAjlsJuA9NrEfHKfMaSnR7DiyCFx9sbUjn1R31/811Zqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242684; c=relaxed/simple;
	bh=1mYZLt6JhKjD66nEjp0R8JMd2KC3DFKyLczm5lxC7yg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJZ6DdHF8IPA1ibw+5+HB9/dIBxLvuT0RFL9GVp3XeOiPjHAQntW4Ttlfviqu0rdwEeGvuC1uddiJwxl9LDai2510hcQeYV6+b8I46xicRiqI+eNmFMdgjaFbTk4frkVrdREA7Ijv6fxnsWBd2RRMMCGSi0yGDt8pV/qYBk1m4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=X82Qn6g5; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C0BE62C0658;
	Wed, 20 May 2026 14:04:33 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1779242673;
	bh=1mYZLt6JhKjD66nEjp0R8JMd2KC3DFKyLczm5lxC7yg=;
	h=From:To:Subject:Date:References:In-Reply-To:From;
	b=X82Qn6g5waD7C0qYNNkWu9t163jzc+1jQDaXesi0PrXfEdSWduxa9Xc32NzmAbatV
	 BSLjg3XspmFjovG3ahMp1VAV3XnZybS9DxTDGoxxg8rAyNUnvEOYx3e2YttCSdw0/S
	 3+vhPsPZxohnEkg+Ba2b1QVRHmVP5RS+S64HBIoP9w30C2hNuu6zNJ/s/DyNl+TWxC
	 jo/R7O8/uvonG8eObwru9mHE5LH2CGBjoPuNGzJoZCjSAQk9Mtlg9Qq40KWW7JH/7L
	 WF5vXGd0Xwc5WXV0qlyyGpVuUdme4/91RNvdCrpElVAY6/KhfcfBvVtR5v5UYk2kDg
	 8Xhm6L68Y+szQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a0d16b10002>; Wed, 20 May 2026 14:04:33 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 20 May 2026 14:04:33 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1748.039; Wed, 20 May 2026 14:04:33 +1200
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: Markus Stockhausen <markus.stockhausen@gmx.de>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "daniel@makrotopia.org"
	<daniel@makrotopia.org>
Subject: Re: [PATCH 0/9] mdio: realtek-rtl9300: Groundwork for multi SOC
 support
Thread-Topic: [PATCH 0/9] mdio: realtek-rtl9300: Groundwork for multi SOC
 support
Thread-Index: AQHc57Cy88mPwJb+m061hysJJswj3bYVYXSA
Date: Wed, 20 May 2026 02:04:33 +0000
Message-ID: <31a47180-e0cc-4731-aca4-e5266aecb7a2@alliedtelesis.co.nz>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
In-Reply-To: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <511AD8658A71A2468B1DFCD1421ABC2A@alliedtelesis.co.nz>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Es1xrjcA c=1 sm=1 tr=0 ts=6a0d16b1 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=drD7vYo3kbIA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=q4N3wYjI9pO_S6glQpgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spamd-Result: default: False [-2.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alliedtelesis.co.nz,quarantine];
	R_DKIM_ALLOW(-0.20)[alliedtelesis.co.nz:s=mail181024];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email];
	TAGGED_FROM(0.00)[bounces-289706-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alliedtelesis.co.nz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Chris.Packham@alliedtelesis.co.nz,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2E576586B34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgTWFya3VzLA0KDQpPbiAyMC8wNS8yMDI2IDA0OjU3LCBNYXJrdXMgU3RvY2toYXVzZW4gd3Jv
dGU6DQo+IFRoZSBSZWFsdGVrIE90dG8gc3dpdGNoIHBsYXRmb3JtIGNvbnNpc3Qgb2YgZm91ciBk
aWZmZXJlbnQgc2VyaWVzDQo+DQo+IC0gUlRMODM4eCBha2EgbWFwbGUgICA6IDI4IHBvcnQgMUcg
U3dpdGNoZXMNCj4gLSBSVEw4Mzl4IGFrYSBjeXByZXNzIDogNTIgcG9ydCAxRyBTd2l0Y2hlcw0K
PiAtIFJUTDkzMHggYWthIGxvbmdhbiAgOiAyOCBwb3J0IDFHLzIuNUcvMTBHIFN3aXRjaGVzDQo+
IC0gUlRMOTMxeCBha2EgbWFuZ28gICA6IDU2IHBvcnQgMUcvMi41Ry8xMEcgU3dpdGNoZXMNCj4N
Cj4gVGhlIGV4aXN0aW5nIHJlYWx0ZWstcnRsOTMwMCBNRElPIGRyaXZlciB3YXMgb25seSBkZXNp
Z25lZCBmb3IgUlRMOTMweA0KPiBkZXZpY2VzLiBUaGUgdGhyZWUgb3RoZXIgU09DcyBhcmUgbm90
IHN1cHBvcnRlZCBhbHRob3VnaCB0aGV5IGJhc2ljYWxseQ0KPiBpbmNvcnBvcmF0ZSBhIHZlcnkg
c2ltaWxhciBNRElPIGNvbnRyb2xsZXIuDQo+DQo+IFRoaXMgc2VyaWVzIGlzIHRoZSBmaXJzdCBz
dGVwIGluIGEgbXVsdGkgc3RhZ2UgYXBwcm9hY2ggdG8gYWxzbyBzdXBwb3J0DQo+IHRoZSBtaXNz
aW5nIFNPQ3MuIERldmljZSBzcGVjaWZpYyBwcm9wZXJ0aWVzIGFuZCByZWdpc3RlcnMgYXJlIGNv
bnZlcnRlZA0KPiBpbnRvIGRlc2lnbmF0ZWQgaW5pdGlhbGl6ZXJzLiBCYXNlZCBvbiB0aGlzIG5l
dyBkZXZpY2VzIGNhbiBiZSBhZGRlZA0KPiBtdWNoIGVhc2llciBpbiBmdXR1cmUgY29tbWl0cy4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIFN0b2NraGF1c2VuIDxtYXJrdXMuc3RvY2toYXVz
ZW5AZ214LmRlPg0KDQpGaXJzdCBvZmYgdGhhbmtzIGZvciBwaWNraW5nIHRoaXMgdXAuIFRoZSBp
bml0aWFsIGRyaXZlciB3YXMgYSBiaXQgb2YgYSANCnBhaW4gdG8gZ2V0IG92ZXIgdGhlIGxpbmUu
wqBJIHdhcyBuZXZlciBhYmxlIHRvIHRlc3QgdGhlIGNsYXVzZSAyMiBzdHVmZiANCm9uIGFueSBy
ZWFsIGhhcmR3YXJlIChhbGwgb2YgbXkgc3R1ZmYgd2FzIEM0NSksIGl0IHdhcyBkb25lIGJhc2Vk
IG9uIHRoZSANCmRhdGFzaGVldHMgSSBoYWQgYXQgdGhlIHRpbWUgKHdoaWNoIEkgZG9uJ3QgY3Vy
cmVudGx5IGhhdmUgYWNjZXNzIHRvKS4NCg0KSSBzZWUgdGhlIE1ESU8oQlVTLEFERFIpIC0+IFBP
UlQgaXMgc3RpbGwgY2F1c2luZyBjb25mdXNpb24uIEl0IGlzIG9uZSANCm9mIHRoZSBtb3JlIGFu
bm95aW5nIGFzcGVjdHMgb2YgdGhlIGhhcmR3YXJlLiBUaGUgYmFzaWMgc3VtbWFyeSBpcyB0aGUg
DQpoYXJkd2FyZSB3YW50cyB0byBvd24gdGhlIFBIWXMgYnV0IExpbnV4IHdhbnRzIHRvIGtub3cg
YWJvdXQgdGhlbSB0b28uIA0KVGhlIFJlYWx0ZWsgU0RLIGJ1bmRsZXMgdGhpcyBhbGwgdG9nZXRo
ZXIgd2l0aCBsb3RzIG9mIHRpZ2h0bHkgY291cGxlZCANCmNvZGUgb3JpZW50ZWQgYXJvdW5kIHN3
aXRjaCBwb3J0cy4gTGludXggd2FudHMgUEhZcyBhbmQgTUFDcyB0byBleGlzdCANCnNlcGFyYXRl
bHkgKElNSE8gdGhpcyBpcyB0aGUgY29ycmVjdCB0aGluZyB0byBkbykuwqAgSSBkb24ndCBrbm93
IGhvdyB0aGUgDQpSZWFsdGVrIFNESyB3b3VsZCBkZWFsIHdpdGggZXhvdGljIFBIWXMgd2l0aCBz
cGVjaWZpYyByZXF1aXJlbWVudHMgZm9yIA0KaG9zdC9saW5lIHNpZGUgc2V0dGluZ3Mgb3Igbm9u
LVBIWSBkZXZpY2VzIGxpa2Ugd2UgaGF2ZSB3aXRoIHNvbWUgRFNBIA0Kc3dpdGNoZXMsIEkgc3Vz
cGVjdCBpdCB3b3VsZG4ndA0KDQpUaGUgUmVhbHRlayBpbnRlcm5hbCBQSFkgcG9sbGluZyBzdHVm
ZiBkb2VzIHNlZW0gdG8gYmUgYWJsZSB0byBjYXRlciBmb3IgDQpzb21ld2hhdCBhcmJpdHJhcnkg
RXRoZXJuZXQgUEhZcyBpZiB5b3UgcHJvdmlkZSB0aGUgcmVsZXZhbnQgcmVnaXN0ZXJzLCANCm1h
c2tzIHZhbHVlcyB0byB1c2UgZm9yIHBvbGxpbmcuIFRoZSBkZWZhdWx0cyBhcmUgc2V0dXAgZm9y
IHRoZSBSZWFsdGVrIA0KUEhZcyB0aGV5IHdhbnQgdG8gc2VsbCB5b3UgYnV0IEkgaGF2ZSBzZWVu
IGEgY291cGxlIG9mIFJlYWx0ZWsgYmFzZWQgDQpkZXNpZ25zIHVzaW5nIE1hcnZlbGwgKEFRUikg
UEhZcy4NCg0KPiBNYXJrdXMgU3RvY2toYXVzZW4gKDkpOg0KPiAgICBuZXQ6IG1kaW86IHJlYWx0
ZWstcnRsOTMwMDogQ29udmVydCB0byBnZW5lcmljIHByZWZpeA0KPiAgICBuZXQ6IG1kaW86IHJl
YWx0ZWstcnRsOTMwMDogQWRkIGRldmljZSBzcGVjaWZpYyBpbmZvIHN0cnVjdHVyZQ0KPiAgICBu
ZXQ6IG1kaW86IHJlYWx0ZWstcnRsOTMwMDogQWRkIHBvcnRzIHRvIGluZm8gc3RydWN0dXJlDQo+
ICAgIG5ldDogbWRpbzogcmVhbHRlay1ydGw5MzAwOiBBZGQgcGFnZXMgdG8gaW5mbyBzdHJ1Y3R1
cmUNCj4gICAgbmV0OiBtZGlvOiByZWFsdGVrLXJ0bDkzMDA6IEFkZCByZWdpc3RlciBzdHJ1Y3R1
cmUNCj4gICAgbmV0OiBtZGlvOiByZWFsdGVrLXJ0bDkzMDA6IEFkZCBjb21tYW5kL0MyMiByZWdp
c3Rlcg0KPiAgICBuZXQ6IG1kaW86IHJlYWx0ZWstcnRsOTMwMDogQWRkIEkvTyByZWdpc3Rlcg0K
PiAgICBuZXQ6IG1kaW86IHJlYWx0ZWstcnRsOTMwMDogQWRkIG1hc2sgcmVnaXN0ZXINCj4gICAg
bmV0OiBtZGlvOiByZWFsdGVrLXJ0bDkzMDA6IExpbmsgSS9PIGZ1bmN0aW9ucyBpbiBpbmZvIHN0
cnVjdHVyZQ0KPg0KPiAgIGRyaXZlcnMvbmV0L21kaW8vbWRpby1yZWFsdGVrLXJ0bDkzMDAuYyB8
IDIxMyArKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTI5IGlu
c2VydGlvbnMoKyksIDg0IGRlbGV0aW9ucygtKQ0KPg==

