Return-Path: <netdev+bounces-245848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AD1CD93B1
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95F2C301B829
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA80233D4EC;
	Tue, 23 Dec 2025 12:21:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9642C235B
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.204.27.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766492473; cv=none; b=jycpZLJtFmYaQQPSsSkOtfP3gv6HsT/84cjxiM69Y3ocquTqX7B8EcHNUTKCcKBOlwPbj5jle6zAIb7xOSj2Z5+3v7HGNlMJOekHv1zyxmYvKmZR6wDbhKo+oYA5QJf/RIzm/YYqrRUr3fBhSTloZzSnkSr4dIIiPfPfxRrZGwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766492473; c=relaxed/simple;
	bh=+ecacnhXoEhIYOhGyErXJQ08fyfhGIKE0jeTT9YEC8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ay4pAvmeRQbVVaIY9WCfEsvVKDcFNPNY44r5fuEh5Mi2IHHyU3N5k85FlDzs/r2A2kjNX3EV/SXblOl7CpZGI/3m4LRG66q4zGXeTri4fNR5qp9X4kJO7b4jw1UZSLDa3ly9CJ9VwzP0oCqncV2fSEzzcR+NkFYNbzZJ1t3YDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn; spf=pass smtp.mailfrom=hygon.cn; arc=none smtp.client-ip=101.204.27.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hygon.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hygon.cn
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4dbDcW6MrDzVcB5;
	Tue, 23 Dec 2025 20:20:43 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
	by mailgw1.hygon.cn (Postfix) with ESMTP id 4dbDcV3Bj8zVcB5;
	Tue, 23 Dec 2025 20:20:42 +0800 (CST)
Received: from cncheex03.Hygon.cn (unknown [172.23.18.113])
	by maildlp2.hygon.cn (Postfix) with ESMTPS id 9B22431AC4EA;
	Tue, 23 Dec 2025 20:16:13 +0800 (CST)
Received: from cncheex04.Hygon.cn (172.23.18.114) by cncheex03.Hygon.cn
 (172.23.18.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 20:20:43 +0800
Received: from cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d]) by
 cncheex04.Hygon.cn ([fe80::1b6f:6c58:58a4:430d%10]) with mapi id
 15.02.1544.036; Tue, 23 Dec 2025 20:20:43 +0800
From: Zhud <zhud@hygon.cn>
To: Paolo Abeni <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Jing Li <lijing@hygon.cn>, Zhiwei Ying <yingzhiwei@hygon.cn>
Subject: RE: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
Thread-Topic: [PATCH net] netdev: increment TSO only if TSO is not enabled on
 any slave device
Thread-Index: AQHcbmlNWOTIX90gx02lh/ymGCh5arUukjiAgACaXqA=
Date: Tue, 23 Dec 2025 12:20:43 +0000
Message-ID: <fe236a552f594780a4b2ead63b4bc329@hygon.cn>
References: <20251216085210.132387-1-zhud@hygon.cn>
 <eae60389-27a5-4e8f-af49-7f75d4c116d8@redhat.com>
In-Reply-To: <eae60389-27a5-4e8f-af49-7f75d4c116d8@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQo+IE9uIDEyLzE2LzI1IDk6NTIgQU0sIERpIFpodSB3cm90ZToNCj4gPiBVbmNvbmRpdGlvbmFs
bHkgaW5jcmVtZW50IHRoZSBUU08gZmxhZyBoYXMgYSBzaWRlIGVmZmVjdDogaXQgd2lsbCBhbHNv
DQo+IA0KPiBUaGlzIGNoYW5nZWxvZyBpcyBJTUhPIHF1aXRlIGNvbmZ1c2luZy4gVGhlIGNvZGUg
ZG9lcyBub3QgJ2luY3JlbWVudCBUU08nLiBJbnN0ZWFkDQo+IGl0IGluY3JlbWVudHMgdGhlIGZl
YXR1cmVzIHNldCB0byBpbmNsdWRlIEFMTF9UU08uDQo+IA0KPiBQbGVhc2UgcmV3b3JkIHRoZSBj
aGFuZ2Vsb2cgYWNjb3JkaW5nbHkuDQo+IA0KPiA+IGRpcmVjdGx5IGNsZWFyIHRoZSBmbGFncyBp
biBORVRJRl9GX0FMTF9GT1JfQUxMIG9uIHRoZSBtYXN0ZXIgZGV2aWNlLA0KPiA+IHdoaWNoIGNh
biBjYXVzZSBpc3N1ZXMgc3VjaCBhcyB0aGUgaW5hYmlsaXR5IHRvIGVuYWJsZSB0aGUgbm9jYWNo
ZQ0KPiA+IGNvcHkgZmVhdHVyZSBvbiB0aGUgYm9uZGluZyBuZXR3b3JrIGNhcmQuDQo+IA0KPiBi
b25kaW5nIG5ldHdvcmsgY2FyZCAtPiBib25kaW5nIGRyaXZlci4NCj4gDQo+ID4gU28sIHdoZW4g
YXQgbGVhc3Qgb25lIHNsYXZlIGRldmljZSdzIFRTTyBpcyBlbmFibGVkLCB0aGVyZSBpcyBubyBu
ZWVkDQo+ID4gdG8gZXhwbGljaXRseSBpbmNyZW1lbnQgdGhlIFRTTyBmbGFnIHRvIHRoZSBtYXN0
ZXIgZGV2aWNlLg0KPiA+DQo+ID4gRml4ZXM6IGIwY2UzNTA4YjI1ZSAoImJvbmRpbmc6IGFsbG93
IFRTTyBiZWluZyBzZXQgb24gYm9uZGluZyBtYXN0ZXIiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IERp
IFpodSA8emh1ZEBoeWdvbi5jbj4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9saW51eC9uZXRkZXZp
Y2UuaCB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5o
IGIvaW5jbHVkZS9saW51eC9uZXRkZXZpY2UuaA0KPiA+IGluZGV4IGJmOTlmZTg2MjJkYS4uMmFj
YTM5ZjdmOWUxIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbmV0ZGV2aWNlLmgNCj4g
PiArKysgYi9pbmNsdWRlL2xpbnV4L25ldGRldmljZS5oDQo+ID4gQEAgLTUzMjIsNyArNTMyMiw4
IEBAIG5ldGRldl9mZWF0dXJlc190DQo+ID4gbmV0ZGV2X2luY3JlbWVudF9mZWF0dXJlcyhuZXRk
ZXZfZmVhdHVyZXNfdCBhbGwsICBzdGF0aWMgaW5saW5lDQo+IG5ldGRldl9mZWF0dXJlc190IG5l
dGRldl9hZGRfdHNvX2ZlYXR1cmVzKG5ldGRldl9mZWF0dXJlc190IGZlYXR1cmVzLA0KPiA+ICAJ
CQkJCQkJbmV0ZGV2X2ZlYXR1cmVzX3QgbWFzaykNCj4gPiAgew0KPiA+IC0JcmV0dXJuIG5ldGRl
dl9pbmNyZW1lbnRfZmVhdHVyZXMoZmVhdHVyZXMsIE5FVElGX0ZfQUxMX1RTTywgbWFzayk7DQo+
ID4gKwlyZXR1cm4gKGZlYXR1cmVzICYgTkVUSUZfRl9BTExfVFNPKSA/IGZlYXR1cmVzIDoNCj4g
PiArCQluZXRkZXZfaW5jcmVtZW50X2ZlYXR1cmVzKGZlYXR1cmVzLCBORVRJRl9GX0FMTF9UU08s
IG1hc2spOw0KPiANCj4gTkVUSUZfRl9BTExfVFNPIGlzIG5vdCBhIHNpbmdsZSBiaXQsIGJ1dCBh
IChsYXRlciBsYXJnZSkgYml0IG1hc2s7IHRoZSBhYm92ZSB3aWxsIHlpZWxkDQo+IGluY29ycmVj
dCByZXN1bHQgd2hlbjoNCj4gDQo+IAlmZWF0dXJlcyAmIE5FVElGX0ZfQUxMX1RTTyAhPSBORVRJ
Rl9GX0FMTF9UU08NCg0KWWVzLCBpdCBpcyBpbmRlZWQgbmVjZXNzYXJ5IHRvIHNldCBhbGwgdHNv
IGZsYWdzIHRvIGF2b2lkIEdTTyBhdCB0aGUgYm9uZGluZyBsYXllci4NCkkgd2lsbCByZXZpc2Ug
dGhlIGNvZGUgYW5kIGl0cyByZWxhdGVkIGNoYW5nbG9uZywgdGhhbmtzLg0KDQo+IA0KPiAvUA0K
PiANCg0K


