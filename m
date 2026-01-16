Return-Path: <netdev+bounces-250417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E80D2AB58
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07F4F30204BA
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675CE335084;
	Fri, 16 Jan 2026 03:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qqr0mqLP"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ACB308F30;
	Fri, 16 Jan 2026 03:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768533966; cv=none; b=Os4o1W4zosfkrrc6JWqjZD1bXw4/ajOLdY+U9gMxSMWON3HoFxVOuJMeMUGQEoVIzUs5GGjj8vpAorI+7l7F+rLDMvGotWzqbZ2Y0sj0pNBBa57SjMu6pkDDal9RF39fgUGTAhXz82Y3cPeLHU2q8urLANUSieBE8eSZeC63Im4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768533966; c=relaxed/simple;
	bh=St5RjKQwSLS8NqjqfEczXrKcZ9I82X4Ra/QUmAjcs20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=bUkoxr0oJe10aSZjui68SoF0xnorgvFw6ns+h/f5ZgXSsWv3iK/q8k0yopfk6O8Koe8KGgOo9s4J/x2ANKomA5WwWfcMUCSQU2QG5uShvt3P7BK6MgRArcRZQGkTTTLuojChID6PXRfIhw4KQAulrJwXD8gKb+h72riS4fk66Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qqr0mqLP; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=St5RjKQwSLS8NqjqfEczXrKcZ9I82X4Ra/QUmAjcs20=; b=Q
	qr0mqLPtsZRIIR1VarekyoWuI39xqCP+W9Ol5+P6oHGpTJ/pSsu2HkFhW3HjH0Dn
	cKEuqQHQKUv7ohHN65RIzzv/yZQy1UP0bd3sBgfxintJpROWOMoeoo9t5a1TXYRb
	uvMZOq4gOtgtVh8G9BVVE7A0SwjSJnoUFtIhIr69o4=
Received: from slark_xiao$163.com ( [112.97.202.229] ) by
 ajax-webmail-wmsvr-40-133 (Coremail) ; Fri, 16 Jan 2026 11:24:54 +0800
 (CST)
Date: Fri, 16 Jan 2026 11:24:54 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: quic_qianyu@quicinc.com, davem@davemloft.net,
	loic.poulain@oss.qualcomm.com, johannes@sipsolutions.net,
	netdev@vger.kernel.org, zaihan@unrealasia.net, johan@kernel.org,
	andrew+netdev@lunn.ch, edumazet@google.com,
	linux-kernel@vger.kernel.org, dnlplm@gmail.com,
	manivannan.sadhasivam@linaro.org, pabeni@redhat.com, mani@kernel.org,
	ryazanov.s.a@gmail.com
Subject: Re:Re: [net-next,v7,3/8] net: wwan: core: split port creation and
 registration
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <20260116024435.347774-1-kuba@kernel.org>
References: <20260115114625.46991-4-slark_xiao@163.com>
 <20260116024435.347774-1-kuba@kernel.org>
X-NTES-SC: AL_Qu2dCvmYvEAi4imbZ+kfn0YTguc2WcG3vf0k2YFRc8AFni3K5Toub1VqG1jT6fqjLSGDnje3QRpg9sRlUJleARviAyHMC/KQRZC/PEiITw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <55195fd2.3367.19bc4d5a71f.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hSgvCgD3l9mGr2lpE+lYAA--.39096W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCvwfBJmlpr4e8GAAA3T
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTAxLTE2IDEwOjQ0OjM1LCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5lbC5v
cmc+IHdyb3RlOgo+VGhpcyBpcyBhbiBBSS1nZW5lcmF0ZWQgcmV2aWV3IG9mIHlvdXIgcGF0Y2gu
IFRoZSBodW1hbiBzZW5kaW5nIHRoaXMKPmVtYWlsIGhhcyBjb25zaWRlcmVkIHRoZSBBSSByZXZp
ZXcgdmFsaWQsIG9yIGF0IGxlYXN0IHBsYXVzaWJsZS4KPgo+Rm9yIGxvY2FsIHJlcHJvZHVjdGlv
biBzdGVwcyBzZWUgaHR0cHM6Ly9uZXRkZXYtYWkuYm90cy5saW51eC5kZXYvYWktbG9jYWwuaHRt
bAo+LS0tCj5uZXQ6IHd3YW46IGNvcmU6IHNwbGl0IHBvcnQgY3JlYXRpb24gYW5kIHJlZ2lzdHJh
dGlvbgo+Cj5UaGlzIHBhdGNoIHNwbGl0cyB0aGUgcG9ydCBjcmVhdGlvbiBmdW5jdGlvbiB0byBw
cmVwYXJlIGZvciB1cGNvbWluZyBHTlNTCj5wb3J0IHR5cGUgc3VwcG9ydC4gSXQgc2VwYXJhdGVz
IGRldmljZV9yZWdpc3RlcigpIGludG8gZGV2aWNlX2luaXRpYWxpemUoKQo+YW5kIGRldmljZV9h
ZGQoKSwgYW5kIG1vdmVzIG1pbm9yIG51bWJlciBhbGxvY2F0aW9uIGludG8gdGhlIG5ldwo+d3dh
bl9wb3J0X3JlZ2lzdGVyX3d3YW4oKSBmdW5jdGlvbi4KPgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvd3dhbi93d2FuX2NvcmUuYyBiL2RyaXZlcnMvbmV0L3d3YW4vd3dhbl9jb3JlLmMKPj4g
aW5kZXggMWRhOTM1ZTg0MDA4Li4xYTlhNzdkNTk3ZTYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMv
bmV0L3d3YW4vd3dhbl9jb3JlLmMKPj4gKysrIGIvZHJpdmVycy9uZXQvd3dhbi93d2FuX2NvcmUu
Ywo+PiBAQCAtMzU3LDcgKzM1Nyw4IEBAIHN0YXRpYyB2b2lkIHd3YW5fcG9ydF9kZXN0cm95KHN0
cnVjdCBkZXZpY2UgKmRldikKPj4gIHsKPj4gIAlzdHJ1Y3Qgd3dhbl9wb3J0ICpwb3J0ID0gdG9f
d3dhbl9wb3J0KGRldik7Cj4+Cj4+IC0JaWRhX2ZyZWUoJm1pbm9ycywgTUlOT1IocG9ydC0+ZGV2
LmRldnQpKTsKPj4gKwlpZiAoZGV2LT5jbGFzcyA9PSAmd3dhbl9jbGFzcykKPj4gKwkJaWRhX2Zy
ZWUoJm1pbm9ycywgTUlOT1IoZGV2LT5kZXZ0KSk7Cj4+ICAJbXV0ZXhfZGVzdHJveSgmcG9ydC0+
ZGF0YV9sb2NrKTsKPj4gIAltdXRleF9kZXN0cm95KCZwb3J0LT5vcHNfbG9jayk7Cj4+ICAJa2Zy
ZWUocG9ydCk7Cj4KPlsgLi4uIF0KPgo+PiArLyogUmVnaXN0ZXIgYSByZWd1bGFyIFdXQU4gcG9y
dCBkZXZpY2UgKGUuZy4gQVQsIE1CSU0sIGV0Yy4pICovCj4+ICtzdGF0aWMgaW50IHd3YW5fcG9y
dF9yZWdpc3Rlcl93d2FuKHN0cnVjdCB3d2FuX3BvcnQgKnBvcnQpCj4+ICt7Cj4+ICsJc3RydWN0
IHd3YW5fZGV2aWNlICp3d2FuZGV2ID0gdG9fd3dhbl9kZXYocG9ydC0+ZGV2LnBhcmVudCk7Cj4+
ICsJY2hhciBuYW1lZm10WzB4MjBdOwo+PiArCWludCBtaW5vciwgZXJyOwo+PiArCj4+ICsJLyog
QSBwb3J0IGlzIGV4cG9zZWQgYXMgY2hhcmFjdGVyIGRldmljZSwgZ2V0IGEgbWlub3IgKi8KPj4g
KwltaW5vciA9IGlkYV9hbGxvY19yYW5nZSgmbWlub3JzLCAwLCBXV0FOX01BWF9NSU5PUlMgLSAx
LCBHRlBfS0VSTkVMKTsKPj4gKwlpZiAobWlub3IgPCAwKQo+PiArCQlyZXR1cm4gbWlub3I7Cj4+
ICsKPj4gKwlwb3J0LT5kZXYuY2xhc3MgPSAmd3dhbl9jbGFzczsKPj4gKwlwb3J0LT5kZXYuZGV2
dCA9IE1LREVWKHd3YW5fbWFqb3IsIG1pbm9yKTsKPgo+WyAuLi4gXQo+Cj4+ICsJZXJyID0gZGV2
aWNlX2FkZCgmcG9ydC0+ZGV2KTsKPj4gKwo+PiArCW11dGV4X3VubG9jaygmd3dhbl9yZWdpc3Rl
cl9sb2NrKTsKPj4gKwo+PiArCWlmIChlcnIpIHsKPj4gKwkJaWRhX2ZyZWUoJm1pbm9ycywgbWlu
b3IpOwo+ICAgICAgICAgICAgICAgIF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgo+Cj5XaGVuIGRl
dmljZV9hZGQoKSBmYWlscywgdGhpcyBmcmVlcyB0aGUgbWlub3IuIEhvd2V2ZXIsIHBvcnQtPmRl
di5jbGFzcwo+d2FzIGFscmVhZHkgc2V0IHRvIHd3YW5fY2xhc3MgYWJvdmUsIGFuZCBwb3J0LT5k
ZXYuZGV2dCBjb250YWlucyB0aGUgbWlub3IKPm51bWJlci4gVGhlIGNhbGxlciAod3dhbl9jcmVh
dGVfcG9ydCkgdGhlbiBjYWxscyBwdXRfZGV2aWNlKCkgd2hpY2gKPnRyaWdnZXJzIHd3YW5fcG9y
dF9kZXN0cm95KCkuIFNpbmNlIGRldi0+Y2xhc3MgPT0gJnd3YW5fY2xhc3MgaXMgdHJ1ZSwKPnd3
YW5fcG9ydF9kZXN0cm95KCkgY2FsbHMgaWRhX2ZyZWUoKSBhZ2FpbiBvbiB0aGUgc2FtZSBtaW5v
ci4KPgo+V291bGRuJ3QgdGhpcyBjYXVzZSBhIGRvdWJsZSBpZGFfZnJlZSB3aGVuIGRldmljZV9h
ZGQoKSBmYWlscz8gVGhlIGNhbGwKPmNoYWluIGlzOiB3d2FuX3BvcnRfcmVnaXN0ZXJfd3dhbigp
IGZhaWxzIC0+IGlkYV9mcmVlKG1pbm9yKSAtPiByZXR1cm4KPmVycm9yIC0+IHd3YW5fY3JlYXRl
X3BvcnQoKSAtPiBwdXRfZGV2aWNlKCkgLT4gd3dhbl9wb3J0X2Rlc3Ryb3koKSAtPgo+aWRhX2Zy
ZWUobWlub3IpIGFnYWluLgo+Cj5NYXliZSB0aGUgY2xhc3Mgc2hvdWxkIGJlIGNsZWFyZWQgb24g
ZXJyb3IgYmVmb3JlIHJldHVybmluZywgb3IgdGhlCj5pZGFfZnJlZSBpbiB0aGUgZXJyb3IgcGF0
aCBzaG91bGQgYmUgcmVtb3ZlZCBzaW5jZSB3d2FuX3BvcnRfZGVzdHJveSgpCj53aWxsIGhhbmRs
ZSBpdD8KPgpIaSBTZXJnZXksCldlIG5lZWQgdG8gcmV2aWV3IHRoaXMgY2hhbmdlcyBhZ2Fpbi4K
Cj4+ICsJCXJldHVybiBlcnI7Cj4+ICsJfQo+PiArCj4+ICsJZGV2X2luZm8oJnd3YW5kZXYtPmRl
diwgInBvcnQgJXMgYXR0YWNoZWRcbiIsIGRldl9uYW1lKCZwb3J0LT5kZXYpKTsKPj4gKwo+PiAr
CXJldHVybiAwOwo+PiArfQo+Cj5bIC4uLiBdCj4KPj4gKwlkZXZpY2VfaW5pdGlhbGl6ZSgmcG9y
dC0+ZGV2KTsKPj4gKwo+PiArCWVyciA9IHd3YW5fcG9ydF9yZWdpc3Rlcl93d2FuKHBvcnQpOwo+
PiAgCWlmIChlcnIpCj4+ICAJCWdvdG8gZXJyb3JfcHV0X2RldmljZTsKPj4gKwo+PiAgCXJldHVy
biBwb3J0Owo+Pgo+PiAgZXJyb3JfcHV0X2RldmljZToKPj4gKwlwdXRfZGV2aWNlKCZwb3J0LT5k
ZXYpOwo+LS0gCj5wdy1ib3Q6IGNyCg==

