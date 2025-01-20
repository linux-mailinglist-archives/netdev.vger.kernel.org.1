Return-Path: <netdev+bounces-159874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0C2A1743B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729C1161E21
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8EE1EF09C;
	Mon, 20 Jan 2025 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="gW+R2H2M"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C0A1EEA5F
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737409022; cv=none; b=t6UQZ4ZCa9/aKISivBYgLvFCx0zuSQUAk9EC+zEtuY5qksl9+ktwKTCpUyBpjzmGmjp2AX7D+obaf1x64zMMeB9Cm3e+ZM8aWvzhUw2V/J3Br6LwwCCoRLOybpZdnAtn9/5qZ17OWKBbVpOPEwkXX2rM2nyTAG/1MUa/bye30M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737409022; c=relaxed/simple;
	bh=K71wbxAUNyo2TiWahbDb5lpk/z3cW0dvfDSTxYtoBcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ljd4VAnFwksyxNCSO3bK7fw+tFsDoq7LGPyfbSZGFyPS/KRKGlIwcMwNcMkRlaHm2gcyOgTD+WAac96Cil5IEM0pbErQju7KNu3r3u4mYzluNEs5b0u/Njzbo0rabWgwRvogxSXtifrpe3GxcTzoStZ+8OAK3qPWlES7Egu8om0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=gW+R2H2M; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C8A442C0C2E;
	Tue, 21 Jan 2025 10:36:57 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1737409017;
	bh=K71wbxAUNyo2TiWahbDb5lpk/z3cW0dvfDSTxYtoBcU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gW+R2H2Mu5P39ftBPw6XlXgMKPjFOkp2cth5o7eX9setONevbnpOnh1gnS1gYVQ2o
	 7eOyTaolnIDZjrnUPNWmZFzhBdQ+qS0BU/ytdT716eOdLJbRvBvAvE906N0H1GQyCq
	 MtayH3v43XWQofnadt0Eajfd9OZv5aKszAkSOGuDnRi7LFXzO37P1XaWm72TMVr1rd
	 nkqSVPTMuE/9HxqdyQSnnTYZxS8WRKVjl/1KyGbdn17dy/cIBZLD2X+gVmyzdq/PEm
	 q22xTUnm+hwKgW6Y79EiiFOMxBFf7nInB1t1098mInGO0RIIH9bo2AUfjTiPWEnfwE
	 RzVAXM+/18ksg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B678ec1f90001>; Tue, 21 Jan 2025 10:36:57 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Jan 2025 10:36:57 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1544.011; Tue, 21 Jan 2025 10:36:57 +1300
From: Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
To: "andrew@lunn.ch" <andrew@lunn.ch>
CC: "olteanv@gmail.com" <olteanv@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Topic: [RFC net-next v1 2/2] net: dsa: add option for bridge port HW
 offload
Thread-Index: AQHbatUxQfjmZDZH702s8g6egGdzMbMeGWgAgAAGS4CAAALyAIABNJ6A
Date: Mon, 20 Jan 2025 21:36:57 +0000
Message-ID: <f8e90a949d08d3aba01a77f761efa41b44924345.camel@alliedtelesis.co.nz>
References: <20250120004913.2154398-1-aryan.srivastava@alliedtelesis.co.nz>
	 <20250120004913.2154398-3-aryan.srivastava@alliedtelesis.co.nz>
	 <bb9cf9af-2f17-4af6-9d1c-3981cc8468c0@lunn.ch>
	 <5d5cc80b20e878d01c3d7d739f0fc7e429a840ed.camel@alliedtelesis.co.nz>
	 <17952bc5-31eb-452c-8fec-957260e9afd1@lunn.ch>
In-Reply-To: <17952bc5-31eb-452c-8fec-957260e9afd1@lunn.ch>
Accept-Language: en-US, en-NZ
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <626D89B27A473A46B16308A37DA30B03@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=678ec1f9 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=w1vUsAckAk8A:10 a=IkcTkHD0fZMA:10 a=VdSt8ZQiCzkA:10 a=ydzi82uJTmq6Tf2ns4gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

T24gTW9uLCAyMDI1LTAxLTIwIGF0IDA0OjEyICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiA+IFRoaXMgaXMgbm90IGEgdmVyeSBjb252aW5jaW5nIGRlc2NyaXB0aW9uLiBXaGF0IGlzIHlv
dXIgcmVhbCB1c2UNCj4gPiA+IGNhc2UNCj4gPiA+IGZvciBub3Qgb2ZmbG9hZGluZz8NCj4gPiA+
IA0KPiA+IFRoZSByZWFsIHVzZSBjYXNlIGZvciB1cyBpcyBwYWNrZXQgaW5zcGVjdGlvbi4gRHVl
IHRvIHRoZSBicmlkZ2UNCj4gPiBwb3J0cw0KPiA+IGJlaW5nIG9mZmxvYWRlZCBpbiBoYXJkd2Fy
ZSwgd2UgY2FuIG5vIGxvbmdlciBpbnNwZWN0IHRoZSB0cmFmZmljDQo+ID4gb24NCj4gPiB0aGVt
LCBhcyB0aGUgcGFja2V0cyBuZXZlciBoaXQgdGhlIENQVS4NCj4gDQo+IFNvIGFyZSB5b3UgdXNp
bmcgbGlicGNhcCB0byBicmluZyB0aGVtIGludG8gdXNlciBzcGFjZT8gT3IgYXJlIHlvdQ0KPiB1
c2luZyBlQlBGPw0KPiANCj4gV2hhdCBpJ20gdGhpbmtpbmcgYWJvdXQgaXMsIHNob3VsZCB0aGlz
IGFjdHVhbGx5IGJlIGEgZGV2bGluayBvcHRpb24sDQo+IG9yIHNob3VsZCBpdCBoYXBwZW4gb24g
aXRzIG93biBiZWNhdXNlIHlvdSBoYXZlIGF0dGFjaGVkIHNvbWV0aGluZw0KPiB3aGljaCBjYW5u
b3QgYmUgb2ZmbG9hZGVkIHRvIHRoZSBoYXJkd2FyZSwgc28gaGFyZHdhcmUgb2ZmbG9hZCBzaG91
bGQNCj4gYmUgZGlzYWJsZWQgYnkgdGhlIGtlcm5lbD8NClllcywgc28gd2UgdXNlIHZhcmlvdXMg
aW4ta2VybmVsIChlQlBGKSBhbmQgc29tZSBvdXQgb2YgdHJlZSBtZXRob2RzDQoobmV0bWFwKS4g
VG8gc2VydmljZSBib3RoLCBJIHRob3VnaHQgdGhhdCBhIGRldmxpbmsgY29uZmlnIHdvdWxkIGJl
DQpiZXN0Lg0KDQpBbHNvIGFzaWRlIGZyb20gc3BlY2lmaWMga2VybmVsIGZlYXR1cmUgdXNlLWNh
c2VzIHRoZSBhY3R1YWwgcG9ydCB3ZQ0KYXJlIHRyeWluZyB0byBzZXJ2aWNlIGlzIG1lYW50IHRv
IGJlIGEgZGVkaWNhdGVkIE5JQywgd2hvc2UNCmltcGxlbWVudGF0aW9uIGRldGFpbCBpcyB0aGF0
IGl0IGlzIG9uIGEgc3dpdGNoIGNoaXAuIEJ5IG9mZmxvYWRpbmcNCmFzcGVjdHMgb2YgaXRzIGNv
bmZpZywgd2UgZW5kIHVwIHdpdGggaW5jb25zaXN0ZW50IGJlaGF2aW91ciBhY3Jvc3MgTklDDQpw
b3J0cyBvbiBvdXIgZGV2aWNlcy4gQXMgdGhlIHBvcnQgaXMgbm90IG1lYW50IHRvIGJlaGF2ZSBs
aWtlIGENCnN3aXRjaHBvcnQsIHRoZSBmYWN0IGl0IGhhcHBlbnMgdG8gYmUgb24gdGhlIGVuZCBv
ZiBhIHN3aXRjaCBzaG91bGQgbm90DQpmb3JjZSBpdCB0byBIVyBvZmZsb2FkIGJyaWRnaW5nLiBU
aGUgSFcgYnJpZGdpbmcgcmVzdWx0cyBpbiBDUFUgYnlwYXNzLA0Kd2hlcmUgYXMgU1cgYnJpZGdp
bmcgd2lsbCBiZSBhIG1vcmUgZGVzaXJhYmxlIG1ldGhvZCBvZiBicmlkZ2luZyBmb3INCnRoaXMg
cG9ydC4gVGhlcmVmb3JlIGl0IGlzIGRlc2lyYWJsZSB0byBoYXZlIGEgbWV0aG9kIHRvIGNvbmZp
Z3VyZQ0KY2VydGFpbiBwb3J0cyBmb3IgU1cgYnJpZGdpbmcgb25seSwgcmF0aGVyIHRoYW4gdGhl
IGRyaXZlcg0KYXV0b21hdGljYWxseSBjaG9vc2luZyB0byBkbyBIVyBvZmZsb2FkIGlmIGNhcGFi
bGUuDQo+IA0KPiA+ID4gbmV0LW5leHQgaXMgY2xvc2VkIGZvciB0aGUgbWVyZ2Ugd2luZG93Lg0K
PiANCj4gPiBJIHdhcyB1bnN1cmUgYWJvdXQgdXBsb2FkaW5nIHRoaXMgcmlnaHQgbm93IChhcyB5
b3Ugc2FpZCBuZXQtbmV4dA0KPiA+IGlzDQo+ID4gY2xvc2VkKSwgYnV0IHRoZSBuZXRkZXYgZG9j
cyBwYWdlIHN0YXRlcyB0aGF0IFJGQyBwYXRjaGVzIGFyZQ0KPiA+IHdlbGNvbWUNCj4gPiBhbnl0
aW1lLCBwbGVhc2UgbGV0IG1lIGtub3cgaWYgdGhpcyBpcyBub3QgY2FzZSwgYW5kIGlmIHNvIEkN
Cj4gPiBhcG9sb2dpemUNCj4gPiBmb3IgbXkgZXJyb25lb3VzIHN1Ym1pc3Npb24uDQo+IA0KPiBJ
dCB3b3VsZCBiZSBnb29kIHRvIHNheSB3aGF0IHlvdSBhcmUgcmVxdWVzdGluZyBjb21tZW50cyBh
Ym91dC4NCj4gDQpBaCB5ZXMsIEkgdW5kZXJzdGFuZC4gSSB3aWxsIGFkZCB0aGUgcmVxdWVzdCBp
biB0aGUgY292ZXIgbGV0dGVyIG5leHQNCnRpbWUsIGJ1dCBlc3NlbnRpYWxseSBJIGp1c3Qgd2Fu
dGVkIGNvbW1lbnRzIGFib3V0IHRoZSBiZXN0IHdheSB0byBnbw0KYWJvdXQgdGhpcy4gU3BlY2lm
aWNhbGx5IGlmIHRoZXJlIHdhcyBhbHJlYWR5IGEgbWV0aG9kIGluIGtlcm5lbCB0bw0KcHJldmVu
dCBIVyBvZmZsb2FkIG9mIGNlcnRhaW4gZmVhdHVyZXMgb3IgaWYgdGhlcmUgYXJlIGFsdGVybmF0
aXZlDQptZXRob2RzIHRvIGRldmxpbmsgdG8gYWRkIHNwZWNpZmljIHN3aXRjaCBjb25maWcgb3B0
aW9ucyBvbiBhIHBlciBwb3J0DQpiYXNpcy4NCg0KCUFyeWFuDQoNCg0KDQo=

