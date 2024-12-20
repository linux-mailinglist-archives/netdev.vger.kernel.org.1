Return-Path: <netdev+bounces-153611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49069F8D62
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 08:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0642188B1ED
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2B17B401;
	Fri, 20 Dec 2024 07:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bInsg9mS"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439F786337;
	Fri, 20 Dec 2024 07:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734680445; cv=none; b=fLHM3+6o6Zv78WaLt5vqLU+Yz3WRUd7Qt77HkM26I3p8wxQtWWOnvhbjJVDtUIGJ25ancX+94AYaLciJ01oNrYXX+0q6PToOUKFtlpRpWBN6xz1Z74jMygUyfWuSIEuksglYNYNlEjABWkA8x1RrbbYs5U0aIv2INoOSuOHf5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734680445; c=relaxed/simple;
	bh=oZwO3EKeLGNnLdka2GhCy5e37M34CKThU9bQvjA99Ic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVis+riCK6Fuo8wJx9jYc+ogGDLkPJ5Z1/G9UyEDTzB1h2hCovOf5lL+79ckRVhRKpwsCN49zUrChfRb8K3NhHRwVafD4uOYYMaXuN1D938s34s3ZWSF/O2erl8Sw+MS5tChWLxNZq2gTyFsjp+WcLtplkt1nkTklSCcNrl/Dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bInsg9mS; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1734680433;
	bh=oZwO3EKeLGNnLdka2GhCy5e37M34CKThU9bQvjA99Ic=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bInsg9mS1OF70/p1jhuuPwkSshLAe4jUKfgvYAdIexBVj6WVjAAXmKinJ04S0mU0Q
	 Wgwh//ZlU5bp4AMCzO3f9trNVuD5IlH2GawRj9NAgSzGTd5yLE/60RtE7errqFKfj0
	 M71QJXJFOb4hV213pQvwLKSwCQCUYltqLbsN/JLpVNmvvQGxlemgh4Yaks4D9PgzZU
	 /HLH6u/iBuYyn2lBEHdbC43bpWvMT0XZeKY95g55/YXHqs6flA9E9ajuzATzTNKA+7
	 2XNkhqEjOFvuXCsdQGkC1uLmjy/mm7+kKRDtISDicO9Omctfq34eniPEbMjzWj7cUF
	 76Ba3q2V5t7sA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CE2826F8DC;
	Fri, 20 Dec 2024 15:40:31 +0800 (AWST)
Message-ID: <b5be0f5cef13cec69fbea5f10539481dbafd9ba3.camel@codeconstruct.com.au>
Subject: Re: [PATCH v10 1/1] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: admiyo@os.amperecomputing.com, Matt Johnston
 <matt@codeconstruct.com.au>,  Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Fri, 20 Dec 2024 15:40:31 +0800
In-Reply-To: <20241219191610.257649-2-admiyo@os.amperecomputing.com>
References: <20241219191610.257649-1-admiyo@os.amperecomputing.com>
	 <20241219191610.257649-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgQWRhbSwKCkxvb2tpbmcgZ29vZC4gSSBzZWUgdGhhdCB0aGVyZSBhcmUgc29tZSB3YXJuaW5n
cyByZXBvcnRlZCBmcm9tIHRoZQphY2Nlc3NlcyB0byB0aGUgX19iZTMyIGZpZWxkcyBpbiB0aGUg
aGVhZGVyIHN0cnVjdDoKCiAgaHR0cHM6Ly9uZXRkZXYuYm90cy5saW51eC5kZXYvc3RhdGljL25p
cGEvOTE5NjEyLzEzOTE1NTM4L2J1aWxkX2FsbG1vZGNvbmZpZ193YXJuL3N0ZGVycgoKW3RoZXJl
IGFyZSBzb21lIHByZS1leGlzdGluZyB3YXJuaW5ncyB0aGVyZTsgYnV0IHRoZXkncmUgZmluZSB0
byBpZ25vcmUKZm9yIHlvdXIgcHVycG9zZXNdCgpZb3UnbGwgbGlrZWx5IG5lZWQgc29tZSBlbmRp
YW4gY29udmVyc2lvbiB0aGVyZTsgYXJlIHRob3NlIGRlZmluZWQgYXMKYmlnIGVuZGlhbiB0aG91
Z2g/CgpBbmQgaWYgeW91J3JlIHJlLXJvbGxpbmcsIEkgd291bGQgc3VnZ2VzdDoKCj4gK3N0YXRp
YyB2b2lkIG1jdHBfY2xlYW51cF9uZXRkZXYodm9pZCAqZGF0YSkKPiArewo+ICvCoMKgwqDCoMKg
wqDCoHN0cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gZGF0YTsKPiArCj4gK8KgwqDCoMKgwqDCoMKg
bWN0cF91bnJlZ2lzdGVyX25ldGRldihuZGV2KTsKPiArfQo+Cj4gK3N0YXRpYyBpbnQgbWN0cF9w
Y2NfZHJpdmVyX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmFjcGlfZGV2KQo+ICt7Cj4gK8KgwqDC
oMKgwqDCoMKgc3RydWN0IG1jdHBfcGNjX2xvb2t1cF9jb250ZXh0IGNvbnRleHQgPSB7MCwgMCwg
MH07Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IG1jdHBfcGNjX25kZXYgKm1jdHBfcGNjX25kZXY7
Cj4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IGRldmljZSAqZGV2ID0gJmFjcGlfZGV2LT5kZXY7Cj4g
K8KgwqDCoMKgwqDCoMKgc3RydWN0IG5ldF9kZXZpY2UgKm5kZXY7Cj4gK8KgwqDCoMKgwqDCoMKg
YWNwaV9oYW5kbGUgZGV2X2hhbmRsZTsKPiArwqDCoMKgwqDCoMKgwqBhY3BpX3N0YXR1cyBzdGF0
dXM7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IG1jdHBfcGNjX210dTsKPiArwqDCoMKgwqDCoMKgwqBj
aGFyIG5hbWVbMzJdOwo+ICvCoMKgwqDCoMKgwqDCoGludCByYzsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgZGV2X2RiZyhkZXYsICJBZGRpbmcgbWN0cF9wY2MgZGV2aWNlIGZvciBISUQgJXNcbiIsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfZGV2aWNlX2hpZChhY3BpX2Rldikp
Owo+ICvCoMKgwqDCoMKgwqDCoGRldl9oYW5kbGUgPSBhY3BpX2RldmljZV9oYW5kbGUoYWNwaV9k
ZXYpOwo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9IGFjcGlfd2Fsa19yZXNvdXJjZXMoZGV2X2hh
bmRsZSwgIl9DUlMiLCBsb29rdXBfcGNjdF9pbmRpY2VzLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICZjb250
ZXh0KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAoIUFDUElfU1VDQ0VTUyhzdGF0dXMpKSB7Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAiRkFJTFVSRSB0byBsb29r
dXAgUENDIGluZGV4ZXMgZnJvbSBDUlNcbiIpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVJTlZBTDsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKgwqDCoMKg
wqDCoC8vaW5ib3ggaW5pdGlhbGl6YXRpb24KPiArwqDCoMKgwqDCoMKgwqBzbnByaW50ZihuYW1l
LCBzaXplb2YobmFtZSksICJtY3RwaXBjYyVkIiwgY29udGV4dC5pbmJveF9pbmRleCk7Cj4gK8Kg
wqDCoMKgwqDCoMKgbmRldiA9IGFsbG9jX25ldGRldihzaXplb2Yoc3RydWN0IG1jdHBfcGNjX25k
ZXYpLCBuYW1lLCBORVRfTkFNRV9FTlVNLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1jdHBfcGNjX3NldHVwKTsKPiArwqDCoMKgwqDCoMKg
wqBpZiAoIW5kZXYpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRU5P
TUVNOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBtY3RwX3BjY19uZGV2ID0gbmV0ZGV2X3ByaXYobmRl
dik7Cj4gK8KgwqDCoMKgwqDCoMKgcmMgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBt
Y3RwX2NsZWFudXBfbmV0ZGV2LCBuZGV2KTsKPiArwqDCoMKgwqDCoMKgwqBpZiAocmMpCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gY2xlYW51cF9uZXRkZXY7Cj4gK8KgwqDC
oMKgwqDCoMKgc3Bpbl9sb2NrX2luaXQoJm1jdHBfcGNjX25kZXYtPmxvY2spOwo+ICsKPiArwqDC
oMKgwqDCoMKgwqByYyA9IG1jdHBfcGNjX2luaXRpYWxpemVfbWFpbGJveChkZXYsICZtY3RwX3Bj
Y19uZGV2LT5pbmJveCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRleHQuaW5ib3hfaW5k
ZXgpOwo+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byBjbGVhbnVwX25ldGRldjsKPiArwqDCoMKgwqDCoMKgwqBtY3RwX3BjY19uZGV2
LT5pbmJveC5jbGllbnQucnhfY2FsbGJhY2sgPSBtY3RwX3BjY19jbGllbnRfcnhfY2FsbGJhY2s7
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoC8vb3V0Ym94IGluaXRpYWxpemF0aW9uCj4gK8KgwqDCoMKg
wqDCoMKgcmMgPSBtY3RwX3BjY19pbml0aWFsaXplX21haWxib3goZGV2LCAmbWN0cF9wY2NfbmRl
di0+b3V0Ym94LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGV4dC5vdXRib3hfaW5kZXgp
Owo+ICvCoMKgwqDCoMKgwqDCoGlmIChyYykKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ290byBjbGVhbnVwX25ldGRldjsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbWN0cF9wY2NfbmRl
di0+YWNwaV9kZXZpY2UgPSBhY3BpX2RldjsKPiArwqDCoMKgwqDCoMKgwqBtY3RwX3BjY19uZGV2
LT5pbmJveC5jbGllbnQuZGV2ID0gZGV2Owo+ICvCoMKgwqDCoMKgwqDCoG1jdHBfcGNjX25kZXYt
Pm91dGJveC5jbGllbnQuZGV2ID0gZGV2Owo+ICvCoMKgwqDCoMKgwqDCoG1jdHBfcGNjX25kZXYt
Pm1kZXYuZGV2ID0gbmRldjsKPiArwqDCoMKgwqDCoMKgwqBhY3BpX2Rldi0+ZHJpdmVyX2RhdGEg
PSBtY3RwX3BjY19uZGV2Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBUaGVyZSBpcyBubyBjbGVh
biB3YXkgdG8gcGFzcyB0aGUgTVRVIHRvIHRoZSBjYWxsYmFjayBmdW5jdGlvbgo+ICvCoMKgwqDC
oMKgwqDCoCAqIHVzZWQgZm9yIHJlZ2lzdHJhdGlvbiwgc28gc2V0IHRoZSB2YWx1ZXMgYWhlYWQg
b2YgdGltZS4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBtY3RwX3BjY19t
dHUgPSBtY3RwX3BjY19uZGV2LT5vdXRib3guY2hhbi0+c2htZW1fc2l6ZSAtCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemVvZihzdHJ1Y3QgbWN0cF9wY2NfaGRyKTsKPiArwqDC
oMKgwqDCoMKgwqBuZGV2LT5tdHUgPSBNQ1RQX01JTl9NVFU7Cj4gK8KgwqDCoMKgwqDCoMKgbmRl
di0+bWF4X210dSA9IG1jdHBfcGNjX210dTsKPiArwqDCoMKgwqDCoMKgwqBuZGV2LT5taW5fbXR1
ID0gTUNUUF9NSU5fTVRVOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBuZGV2IG5lZWRzIHRvIGJl
IGZyZWVkIGJlZm9yZSB0aGUgaW9tZW1vcnkgKG1hcHBlZCBhYm92ZSkgZ2V0cwo+ICvCoMKgwqDC
oMKgwqDCoCAqIHVubWFwcGVkLMKgIGRldm0gcmVzb3VyY2VzIGdldCBmcmVlZCBpbiByZXZlcnNl
IHRvIHRoZSBvcmRlciB0aGV5Cj4gK8KgwqDCoMKgwqDCoMKgICogYXJlIGFkZGVkLgo+ICvCoMKg
wqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoHJjID0gcmVnaXN0ZXJfbmV0ZGV2KG5kZXYp
OwoKbWN0cF9yZWdpc3Rlcl9uZXRkZXYoKSwgc28gdGhhdCB5b3UncmUgc3ltbWV0cmljYWwgd2l0
aCB0aGUKbWN0cF91bnJlZ2lzdGVyX25ldGRldigpIGluIHRoZSBjbGVhbnVwIHBhdGguCgpDaGVl
cnMsCgoKSmVyZW15Cg==


