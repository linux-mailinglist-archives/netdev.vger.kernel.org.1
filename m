Return-Path: <netdev+bounces-258032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFMWG5nEimm9NgAAu9opvQ
	(envelope-from <netdev+bounces-258032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:39:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6033111724A
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 06:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFAEF301324E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 05:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983ED32B9AD;
	Tue, 10 Feb 2026 05:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0732DC334;
	Tue, 10 Feb 2026 05:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701907; cv=none; b=t2mnMNiqEaQX75+CaKjYMeGeDGieXGb2LeKpvrxYGFYXknS+WN441sYFrBjqAfjBmb0grGZxRv0YfTwTT0d79UtD1jNcX8MBMKPtvJJK1YNPE/yPK8dtY81A/9wanQ2Dd2CNhqh3DsMDXfQHsTjNxwvB9OZaqtmlg61x/cEZhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701907; c=relaxed/simple;
	bh=t9R0Mk/yXEzHc+Q7LIjB8fcK44EbgHnJucyiiqIgQqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=k3Fwpg87BYAqy4PP8R8QcjvQCGmvTn0loppIVYX9dVrSChpXlCLO/aTKuyhZj0ri6n+fYd19WFXRgLP3/1/IyHjzZzJWSkxsoMBHRMpwKc1eDkQ26mousbRI+JJrbjNKwAP5aum/+j+idSo9IFuYmUn5vnuOl8c9h1slmMAF+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.133])
	by mtasvr (Coremail) with SMTP id _____wD33+lIxIppYB+cAA--.33113S3;
	Tue, 10 Feb 2026 13:38:17 +0800 (CST)
Received: from duoming$zju.edu.cn ( [218.12.18.133] ) by
 ajax-webmail-mail-app2 (Coremail) ; Tue, 10 Feb 2026 13:38:13 +0800
 (GMT+08:00)
Date: Tue, 10 Feb 2026 13:38:13 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Jijie Shao" <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, 3chas3@gmail.com,
	linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v3] atm: fore200e: fix use-after-free in tasklets
 during device removal
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <cfa65635-8a78-4929-8490-f66b7a38d02e@huawei.com>
References: <20260209094512.33847-1-duoming@zju.edu.cn>
 <cfa65635-8a78-4929-8490-f66b7a38d02e@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <60202c25.703d4.19c460eafca.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgDHkzVGxIppNTfCBQ--.44549W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwESAWmKOIcFcAAAs4
X-CM-DELIVERINFO: =?B?vUoDHQXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR18B2QU8C4caAVCxk1uY0CQM8Tpn3ioqs2/vFmiqPhwqh9yPMg5hrglTP0U2lkQXXDIqM
	hxB7JQ9/xFama3KKFHOPabtyPYocyPRRCLHrgs8nzWjt7ZxaxMmFNMD/EcsBPg==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF18ZFWDtFW5Gr15GFWxuFX_yoW5Kr1xp3
	97Ga13CFW8GrWj9w17Jw15uF18uwn2qFWYkw4DK34jgF10vry0vr1rKF4DWFWDZw1xZFyv
	qr1kXFy3W34DGFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4xvF2IEb7IF0Fy264kE64k0F24lFcxC0VAYjxAxZF0Ex2IqxwAK
	zVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UMVCEFcxC0VAYjxAxZFUvcSsGvf
	C2KfnxnUUI43ZEXa7IU848BUUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,netdev@vger.kernel.org];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258032-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lists.sourceforge.net,kernel.org];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,zju.edu.cn:mid,zju.edu.cn:email]
X-Rspamd-Queue-Id: 6033111724A
X-Rspamd-Action: no action

T24gVHVlLCAxMCBGZWIgMjAyNiAwOTo0Njo1MyArMDgwMCBKaWppZSBTaGFvIHdyb3RlOgo+ID4g
V2hlbiB0aGUgUENBLTIwMEUgb3IgU0JBLTIwMEUgYWRhcHRlciBpcyBiZWluZyBkZXRhY2hlZCwg
dGhlIGZvcmUyMDBlCj4gPiBpcyBkZWFsbG9jYXRlZC4gSG93ZXZlciwgdGhlIHR4X3Rhc2tsZXQg
b3IgcnhfdGFza2xldCBtYXkgc3RpbGwgYmUgcnVubmluZwo+ID4gb3IgcGVuZGluZywgbGVhZGlu
ZyB0byB1c2UtYWZ0ZXItZnJlZSBidWcgd2hlbiB0aGUgYWxyZWFkeSBmcmVlZCBmb3JlMjAwZQo+
ID4gaXMgYWNjZXNzZWQgYWdhaW4gaW4gZm9yZTIwMGVfdHhfdGFza2xldCgpIG9yIGZvcmUyMDBl
X3J4X3Rhc2tsZXQoKS4KPiA+Cj4gPiBPbmUgb2YgdGhlIHJhY2UgY29uZGl0aW9ucyBjYW4gb2Nj
dXIgYXMgZm9sbG93czoKPiA+Cj4gPiBDUFUgMCAoY2xlYW51cCkgICAgICAgICAgIHwgQ1BVIDEg
KHRhc2tsZXQpCj4gPiBmb3JlMjAwZV9wY2FfcmVtb3ZlX29uZSgpIHwgZm9yZTIwMGVfaW50ZXJy
dXB0KCkKPiA+ICAgIGZvcmUyMDBlX3NodXRkb3duKCkgICAgIHwgICB0YXNrbGV0X3NjaGVkdWxl
KCkKPiA+ICAgICAga2ZyZWUoZm9yZTIwMGUpICAgICAgIHwgZm9yZTIwMGVfdHhfdGFza2xldCgp
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgZm9yZTIwMGUtPiAvLyBVQUYKPiA+
Cj4gPiBGaXggdGhpcyBieSBlbnN1cmluZyB0eF90YXNrbGV0IG9yIHJ4X3Rhc2tsZXQgaXMgcHJv
cGVybHkgY2FuY2VsZWQgYmVmb3JlCj4gPiB0aGUgZm9yZTIwMGUgaXMgcmVsZWFzZWQuIEFkZCB0
YXNrbGV0X2tpbGwoKSBpbiBmb3JlMjAwZV9zaHV0ZG93bigpIHRvCj4gPiBzeW5jaHJvbml6ZSB3
aXRoIGFueSBwZW5kaW5nIG9yIHJ1bm5pbmcgdGFza2xldHMuIE1vcmVvdmVyLCBzaW5jZQo+ID4g
Zm9yZTIwMGVfcmVzZXQoKSBjb3VsZCBwcmV2ZW50IGZ1cnRoZXIgaW50ZXJydXB0cyBvciBkYXRh
IHRyYW5zZmVycywKPiA+IHRoZSB0YXNrbGV0X2tpbGwoKSBzaG91bGQgYmUgcGxhY2VkIGFmdGVy
IGZvcmUyMDBlX3Jlc2V0KCkgdG8gcHJldmVudAo+ID4gdGhlIHRhc2tsZXQgZnJvbSBiZWluZyBy
ZXNjaGVkdWxlZCBpbiBmb3JlMjAwZV9pbnRlcnJ1cHQoKS4gRmluYWxseSwKPiA+IGl0IG9ubHkg
bmVlZHMgdG8gZG8gdGFza2xldF9raWxsKCkgd2hlbiB0aGUgZm9yZTIwMGUgc3RhdGUgaXMgZ3Jl
YXRlcgo+ID4gdGhhbiBvciBlcXVhbCB0byBGT1JFMjAwRV9TVEFURV9JUlEsIHNpbmNlIHRhc2ts
ZXRzIGFyZSB1bmluaXRpYWxpemVkCj4gPiBpbiBlYXJsaWVyIHN0YXRlcy4KPiA+Cj4gPiBUaGlz
IGJ1ZyB3YXMgaWRlbnRpZmllZCB0aHJvdWdoIHN0YXRpYyBhbmFseXNpcy4KPiA+Cj4gPiBGaXhl
czogMWRhMTc3ZTRjM2Y0ICgiTGludXgtMi42LjEyLXJjMiIpCj4gPiBDYzogc3RhYmxlQGtlcm5l
bC5vcmcKPiA+IFN1Z2dlc3RlZC1ieTogSmlqaWUgU2hhbyA8c2hhb2ppamllQGh1YXdlaS5jb20+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEdW9taW5nIFpob3UgPGR1b21pbmdAemp1LmVkdS5jbj4KPiA+
IC0tLQo+ID4gQ2hhbmdlcyBpbiB2MzoKPiA+ICAgIC0gT25seSBkbyB0YXNrbGV0X2tpbGwoKSB3
aGVuIHN0YXRlID49IEZPUkUyMDBFX1NUQVRFX0lSUS4KPiA+ICAgIC0gTWFrZSB0aGUgY29tbWl0
IG1lc3NhZ2VzIGNsZWFyZXIuCj4gPgo+ID4gICBkcml2ZXJzL2F0bS9mb3JlMjAwZS5jIHwgNyAr
KysrKystCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG0vZm9yZTIwMGUuYyBiL2RyaXZlcnMv
YXRtL2ZvcmUyMDBlLmMKPiA+IGluZGV4IGY2MmUzODU3MTQ0Li5lYjM4NmVjNmI1ZSAxMDA2NDQK
PiA+IC0tLSBhL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKPiA+ICsrKyBiL2RyaXZlcnMvYXRtL2Zv
cmUyMDBlLmMKPiA+IEBAIC0zNjMsNyArMzYzLDEyIEBAIGZvcmUyMDBlX3NodXRkb3duKHN0cnVj
dCBmb3JlMjAwZSogZm9yZTIwMGUpCj4gPiAgIAkvKiBmaXJzdCwgcmVzZXQgdGhlIGJvYXJkIHRv
IHByZXZlbnQgZnVydGhlciBpbnRlcnJ1cHRzIG9yIGRhdGEgdHJhbnNmZXJzICovCj4gPiAgIAlm
b3JlMjAwZV9yZXNldChmb3JlMjAwZSwgMCk7Cj4gPiAgICAgICB9Cj4gPiAtCj4gPiArI2lmZGVm
IEZPUkUyMDBFX1VTRV9UQVNLTEVUCj4gPiArCWlmIChmb3JlMjAwZS0+c3RhdGUgPj0gRk9SRTIw
MEVfU1RBVEVfSVJRKSB7Cj4gPiArCQl0YXNrbGV0X2tpbGwoJmZvcmUyMDBlLT50eF90YXNrbGV0
KTsKPiA+ICsJCXRhc2tsZXRfa2lsbCgmZm9yZTIwMGUtPnJ4X3Rhc2tsZXQpOwo+ID4gKwl9Cj4g
PiArI2VuZGlmCj4gCj4gVGhlIGNvZGUgYXBwZWFycyB0byBiZSBtaXNhbGlnbmVkLgo+IEkgc2Vl
IHRoYXQgaW4gdGhlIG9yaWdpbmFsIGRyaXZlciBjb2RlLCB0aGUgZmlyc3QgbGV2ZWwgb2YgaW5k
ZW50YXRpb24gdXNlcyA0IHNwYWNlcywKPiBhbmQgdGhlIHNlY29uZCBsZXZlbCB1c2VzIGEgVEFC
ICg4LWNoYXJhY3RlciB3aWR0aCkuCj4gSW4geW91ciBjb2RlLCB0aGUgZmlyc3QgbGV2ZWwgdXNl
cyBhIFRBQiwgYW5kIHRoZSBzZWNvbmQgbGV2ZWwgdXNlcyB0d28gVEFCcy4KPiBPZiBjb3Vyc2Us
IHlvdXIgY29kZSBjb21wbGllcyB3aXRoIHRoZSBjdXJyZW50IGNvZGluZyBzdGFuZGFyZHMuCj4g
Cj4gQWRkaXRpb25hbGx5LCBJIHRoaW5rIGEgYmV0dGVyIG1vZGlmaWNhdGlvbiB3b3VsZCBiZSB0
byBkbyB0YXNrbGV0X2tpbGwoKQo+IGluIHRoZSAic3dpdGNoKGZvcmUyMDBlLT5zdGF0ZSktY2Fz
ZSBGT1JFMjAwRV9TVEFURV9JUlEiIGJyYW5jaCwKPiBiZWNhdXNlICJmb3JlMjAwZS0+dHhfdGFz
a2xldCIgaXMgaW5pdGlhbGl6ZWQgdG9nZXRoZXIgd2l0aCAiZm9yZTIwMGUtPmlycSIuCgpUaGFu
ayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbnMhIEkgd2lsbCBhZGp1c3QgdGhlIHRhc2tsZXRfa2ls
bCgpIGludG8gdGhlCiJjYXNlIEZPUkUyMDBFX1NUQVRFX0lSUSIgYnJhbmNoLiBUaGUgZGV0YWls
cyBhcmUgYXMgZm9sbG93czoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2F0bS9mb3JlMjAwZS5jIGIv
ZHJpdmVycy9hdG0vZm9yZTIwMGUuYwppbmRleCBmNjJlMzg1NzE0NC4uZmVjMDgxZGIzNmQgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKKysrIGIvZHJpdmVycy9hdG0vZm9yZTIw
MGUuYwpAQCAtMzczLDYgKzM3MywxMCBAQCBmb3JlMjAwZV9zaHV0ZG93bihzdHJ1Y3QgZm9yZTIw
MGUqIGZvcmUyMDBlKQogICAgICAgIGZhbGx0aHJvdWdoOwogICAgIGNhc2UgRk9SRTIwMEVfU1RB
VEVfSVJROgogICAgICAgIGZyZWVfaXJxKGZvcmUyMDBlLT5pcnEsIGZvcmUyMDBlLT5hdG1fZGV2
KTsKKyNpZmRlZiBGT1JFMjAwRV9VU0VfVEFTS0xFVAorICAgICAgIHRhc2tsZXRfa2lsbCgmZm9y
ZTIwMGUtPnR4X3Rhc2tsZXQpOworICAgICAgIHRhc2tsZXRfa2lsbCgmZm9yZTIwMGUtPnJ4X3Rh
c2tsZXQpOworI2VuZGlmCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=


