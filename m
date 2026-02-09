Return-Path: <netdev+bounces-257913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP7jNG2biWm1/gQAu9opvQ
	(envelope-from <netdev+bounces-257913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:31:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D9210D014
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6239F3009F10
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 08:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6B2E92A6;
	Mon,  9 Feb 2026 08:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15675258EE1;
	Mon,  9 Feb 2026 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625857; cv=none; b=P5caC46nEhAzpCRbxQ60aMDs+G9neJWCh0KUSdi2/qBvVBqyNqDkMV6rpgLJIWUByM8FWwTb8P0lz5p4/gq7RqNpU6bD9xbwjptcKO/dl7s0Kb1OyG0b5ic+B/i97Uol0UISmTPc1r9q79casIS2Q1VWHO5stFjnpZidsX9mmpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625857; c=relaxed/simple;
	bh=5RToMGj6L0UU9/thfMGbTXpASthD8mgxpSeCnR0NvCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=cSAJZ1yZNoKExUpW+NPS8XVmPAYndL9sr5A06EfJCO7G1j42iXIGwJ32kEE4yBtLUwh3OFNv2MBchVS9rR0tuHi0Y+DPXocYsRe9dg0IuYNYwVDTLdaWVprPPzQleEv4EhYQeMkblcdOHWTTyDg5Owo/0yAZDBFakJEk7ghMjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.16.96])
	by mtasvr (Coremail) with SMTP id _____wCXJ+gzm4lp_pyXAA--.23042S3;
	Mon, 09 Feb 2026 16:30:44 +0800 (CST)
Received: from duoming$zju.edu.cn ( [218.12.16.96] ) by
 ajax-webmail-mail-app2 (Coremail) ; Mon, 9 Feb 2026 16:30:42 +0800
 (GMT+08:00)
Date: Mon, 9 Feb 2026 16:30:42 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Jijie Shao" <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, 3chas3@gmail.com
Subject: Re: [PATCH net v2] atm: fore200e: fix use-after-free in tasklets
 during device removal
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <39abbfbb-777e-4fe9-a8cf-38ab40863667@huawei.com>
References: <20260206094811.23431-1-duoming@zju.edu.cn>
 <41559748-63f2-49ea-9d94-433eeb0edb8b@huawei.com>
 <1ec5e02d.6d52a.19c337418d3.Coremail.duoming@zju.edu.cn>
 <39abbfbb-777e-4fe9-a8cf-38ab40863667@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6a1f4a65.6fced.19c41863ba9.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgBXJDYzm4lpb0m+BQ--.44570W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwYRAWmI5wcH0wAAsA
X-CM-DELIVERINFO: =?B?1AxJWAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR12qq1Zxbg26r1G9JjDbDDsRaiD27yhHLblImfYBVumiHjnXkalqwUIn4TqCMAeHJEnnZ
	HUjvCV1Fsyb0lRFBnWpvjDEIRIohna8t4UJzwDF5uMCr9qHEWbhNmBTN2RtIHw==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF1UZF4xJrWfZrWUAw15KFX_yoW5ur4Dp3
	ykGa17CrW8Gryjgw1aqw15Wr10vrn3XFy5uw4kK34jgFn0vr10vr18KF4UuFWjk34xZF1v
	vrn5Jryfu34kAFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJwCE64xvF2IEb7IF0Fy7YxBIda
	VFxhVjvjDU0xZFpf9x07jY6wtUUUUU=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257913-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[zju.edu.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51D9210D014
X-Rspamd-Action: no action

T24gTW9uLCA5IEZlYiAyMDI2IDE0OjQxOjUyICswODAwIEppamllIFNoYW8gd3JvdGU6Cj4gPj4+
IFdoZW4gdGhlIFBDQS0yMDBFIG9yIFNCQS0yMDBFIGFkYXB0ZXIgaXMgYmVpbmcgZGV0YWNoZWQs
IHRoZSBmb3JlMjAwZQo+ID4+PiBpcyBkZWFsbG9jYXRlZC4gSG93ZXZlciwgdGhlIHR4X3Rhc2ts
ZXQgb3IgcnhfdGFza2xldCBtYXkgc3RpbGwgYmUgcnVubmluZwo+ID4+PiBvciBwZW5kaW5nLCBs
ZWFkaW5nIHRvIHVzZS1hZnRlci1mcmVlIGJ1ZyB3aGVuIHRoZSBhbHJlYWR5IGZyZWVkIGZvcmUy
MDBlCj4gPj4+IGlzIGFjY2Vzc2VkIGFnYWluIGluIGZvcmUyMDBlX3R4X3Rhc2tsZXQoKSBvciBm
b3JlMjAwZV9yeF90YXNrbGV0KCkuCj4gPj4+Cj4gPj4+IE9uZSBvZiB0aGUgcmFjZSBjb25kaXRp
b25zIGNhbiBvY2N1ciBhcyBmb2xsb3dzOgo+ID4+Pgo+ID4+PiBDUFUgMCAoY2xlYW51cCkgICAg
ICAgICAgIHwgQ1BVIDEgKHRhc2tsZXQpCj4gPj4+IGZvcmUyMDBlX3BjYV9yZW1vdmVfb25lKCkg
fCBmb3JlMjAwZV9pbnRlcnJ1cHQoKQo+ID4+PiAgICAgZm9yZTIwMGVfc2h1dGRvd24oKSAgICAg
fCAgIHRhc2tsZXRfc2NoZWR1bGUoKQo+ID4+PiAgICAgICBrZnJlZShmb3JlMjAwZSkgICAgICAg
fCBmb3JlMjAwZV90eF90YXNrbGV0KCkKPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICBmb3JlMjAwZS0+IC8vIFVBRgo+ID4+Pgo+ID4+PiBGaXggdGhpcyBieSBlbnN1cmluZyB0
eF90YXNrbGV0IG9yIHJ4X3Rhc2tsZXQgaXMgcHJvcGVybHkgY2FuY2VsZWQgYmVmb3JlCj4gPj4+
IHRoZSBmb3JlMjAwZSBpcyByZWxlYXNlZC4gQWRkIHRhc2tsZXRfa2lsbCgpIGluIGZvcmUyMDBl
X3NodXRkb3duKCkgdG8KPiA+Pj4gc3luY2hyb25pemUgd2l0aCBhbnkgcGVuZGluZyBvciBydW5u
aW5nIHRhc2tsZXRzLiBNb3Jlb3Zlciwgc2luY2UKPiA+Pj4gZm9yZTIwMGVfcmVzZXQoKSBjb3Vs
ZCBwcmV2ZW50IGZ1cnRoZXIgaW50ZXJydXB0cyBvciBkYXRhIHRyYW5zZmVycywKPiA+Pj4gdGhl
IHRhc2tsZXRfa2lsbCgpIHNob3VsZCBiZSBwbGFjZWQgYWZ0ZXIgZm9yZTIwMGVfcmVzZXQoKSB0
byBwcmV2ZW50Cj4gPj4+IHRoZSB0YXNrbGV0IGZyb20gYmVpbmcgcmVzY2hlZHVsZWQgaW4gZm9y
ZTIwMGVfaW50ZXJydXB0KCkuCj4gPj4+Cj4gPj4+IEZpeGVzOiAxZGExNzdlNGMzZjQgKCJMaW51
eC0yLjYuMTItcmMyIikKPiA+Pj4gU2lnbmVkLW9mZi1ieTogRHVvbWluZyBaaG91IDxkdW9taW5n
QHpqdS5lZHUuY24+Cj4gPj4+IC0tLQo+ID4+PiBDaGFuZ2VzIGluIHYyOgo+ID4+PiAgICAgLSBN
b3ZlIHRhc2tsZXRfa2lsbCgpIGFmdGVyIGZvcmUyMDBlX3Jlc2V0KCkuCj4gPj4+Cj4gPj4+ICAg
IGRyaXZlcnMvYXRtL2ZvcmUyMDBlLmMgfCA0ICsrKysKPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG0vZm9y
ZTIwMGUuYyBiL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKPiA+Pj4gaW5kZXggZjYyZTM4NTcxNDQu
LmRlMDRjNDA3OTIxIDEwMDY0NAo+ID4+PiAtLS0gYS9kcml2ZXJzL2F0bS9mb3JlMjAwZS5jCj4g
Pj4+ICsrKyBiL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKPiA+Pj4gQEAgLTM2Miw2ICszNjIsMTAg
QEAgZm9yZTIwMGVfc2h1dGRvd24oc3RydWN0IGZvcmUyMDBlKiBmb3JlMjAwZSkKPiA+Pj4gICAg
ICAgIGlmIChmb3JlMjAwZS0+c3RhdGUgPiBGT1JFMjAwRV9TVEFURV9SRVNFVCkgewo+ID4+PiAg
ICAJLyogZmlyc3QsIHJlc2V0IHRoZSBib2FyZCB0byBwcmV2ZW50IGZ1cnRoZXIgaW50ZXJydXB0
cyBvciBkYXRhIHRyYW5zZmVycyAqLwo+ID4+PiAgICAJZm9yZTIwMGVfcmVzZXQoZm9yZTIwMGUs
IDApOwo+ID4+PiArI2lmZGVmIEZPUkUyMDBFX1VTRV9UQVNLTEVUCj4gPj4+ICsJdGFza2xldF9r
aWxsKCZmb3JlMjAwZS0+dHhfdGFza2xldCk7Cj4gPj4+ICsJdGFza2xldF9raWxsKCZmb3JlMjAw
ZS0+cnhfdGFza2xldCk7Cj4gPj4+ICsjZW5kaWYKPiA+Pj4gICAgICAgIH0KPiA+PiBJJ20gc29y
cnkgaWYgSSBnYXZlIHlvdSBhIGNvbmZ1c2luZyBjb21tZW50Lgo+ID4+Cj4gPj4gSWYgKGZvcmUy
MDBlLT5zdGF0ZSA8PSBGT1JFMjAwRV9TVEFURV9SRVNFVCksIGlzIHRoZXJlIG5vIG5lZWQgdG8g
ZG8gdGFza2xldF9raWxsKCk/Cj4gPiBUaGUgZm9sbG93aW5nIGZvdXIgc3RhdGVzIHRoYXQgYXJl
IHByZWNlZGluZyBGT1JFMjAwRV9TVEFURV9SRVNFVCBhcmUgb25seSBzZXQKPiA+IGR1cmluZyBk
ZXZpY2UgaW5pdGlhbGl6YXRpb246IEZPUkUyMDBFX1NUQVRFX0JMQU5LLCBGT1JFMjAwRV9TVEFU
RV9SRUdJU1RFUiwKPiA+IEZPUkUyMDBFX1NUQVRFX0NPTkZJR1VSRSwgYW5kIEZPUkUyMDBFX1NU
QVRFX01BUC4KPiA+Cj4gPiBJZiB0aGUgZGV2aWNlIGlzIGluIGFueSBvZiB0aGVzZSBzdGF0ZXMs
IGl0IG1lYW5zIHRoZSBpbml0aWFsaXphdGlvbiBpcwo+ID4gbm90IGNvbXBsZXRlIGFuZCBpbnRl
cnJ1cHRzIGhhdmUgbm90IGJlZW4gcmVnaXN0ZXJlZC4gVGhlcmVmb3JlLCB0YXNrbGV0Cj4gPiBj
b3VsZCBub3QgYmUgc2NoZWR1bGVkIHRocm91Z2ggZm9yZTIwMGVfaW50ZXJydXB0KCkuCj4gPgo+
ID4gSWYgdGhlIGRldmljZSBpcyBpbiBGT1JFMjAwRV9TVEFURV9SRVNFVCBzdGF0ZSwgdGhlIGZv
cmUyMDBlX3Jlc2V0KCkgaGFzCj4gPiBhbHJlYWR5IHJlc2V0IHRoZSBkZXZpY2UsIHdoaWNoIGNv
dWxkIHByZXZlbnQgZnVydGhlciBpbnRlcnJ1cHRzIGFuZAo+ID4gdGFza2xldCBzY2hlZHVsaW5n
Lgo+ID4KPiA+IFNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZG8gdGFza2xldF9raWxsKCkgaWYgdGhl
IHN0YXRlIG9mIGZvcmUyMDBlIGlzCj4gPiBsZXNzIHRoYW4gb3IgZXF1YWwgdG8gRk9SRTIwMEVf
U1RBVEVfUkVTRVQuCj4gCj4gWWVhaCwgSSBhZ3JlZS4KPiBCdXQgSSByZXZpZXdlZCB0aGUgZm9y
ZTIwMGVfaW5pdCgpIGFnYWluLCBhbmQgaXQgb25seSBuZWVkcyB0byBkbyB0YXNrbGV0X2tpbGwo
KQo+IHdoZW4gImZvcmUyMDBlLT5zdGF0ZSA+PSBmRk9SRTIwMEVfU1RBVEVfSVJRIihpbiBmb3Jl
MjAwZV9pcnFfcmVxdWVzdCgpKTsKPiBvdGhlcndpc2UsICJmb3JlMjAwZS0+dHhfdGFza2xldCIg
aGFzIG5vdCBiZWVuIGluaXRpYWxpemVkLgoKVGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYW5kIHN1
Z2dlc3Rpb25zISBZb3UgYXJlIHJpZ2h0LCBJIHdpbGwgYWRvcHQgeW91ciAKc3VnZ2VzdGlvbnMg
aW4gdGhlIHYzIHBhdGNoLgoKQmVzdCByZWdhcmRzLApEdW9taW5nIFpob3UK


