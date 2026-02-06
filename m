Return-Path: <netdev+bounces-257567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB4pCioBhml0JAQAu9opvQ
	(envelope-from <netdev+bounces-257567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:56:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AB0FF574
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D3C23017277
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17A84219F1;
	Fri,  6 Feb 2026 14:56:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7F40FDB3;
	Fri,  6 Feb 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770389785; cv=none; b=tqMRlEc51D+SpciSo/3r9RW0dXRY5EOdtCob/FSM8EqRT2eIx6wd0oBAE/z0eh0hBX7W8KpbyJNJgbWuPIb+7udd71+4bugoyHjBW+P9EAHgQL1wl5MkoCB+anukOfqNe55PjWrTpqGP63b4qWA0hVpaeRoUCIAnk+aCXH1vK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770389785; c=relaxed/simple;
	bh=1tPS9voMPZHpllU/8adchw+PoAddqW1N9aylk/lY3cU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=m9y2rmYLnREwaoQcikl4XHK2AJykd0yqpzOSR9EcMxvWWSzPuqwEKjK5+tpAmliCwVdK8827/HH7r9eAlrt/JNkeSQowlI2SwV9UHQ5UoZkKnZvxsr/Q34O3Hhy/qKyN4YvqXwEJX4DmWMqI4B7vQuaZLDTukSQFS4966gqpCJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [106.117.96.98])
	by mtasvr (Coremail) with SMTP id _____wC3VGUNAYZpZxqMAA--.41639S3;
	Fri, 06 Feb 2026 22:56:15 +0800 (CST)
Received: from duoming$zju.edu.cn ( [106.117.96.98] ) by
 ajax-webmail-mail-app4 (Coremail) ; Fri, 6 Feb 2026 22:56:12 +0800
 (GMT+08:00)
Date: Fri, 6 Feb 2026 22:56:12 +0800 (GMT+08:00)
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
In-Reply-To: <41559748-63f2-49ea-9d94-433eeb0edb8b@huawei.com>
References: <20260206094811.23431-1-duoming@zju.edu.cn>
 <41559748-63f2-49ea-9d94-433eeb0edb8b@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1ec5e02d.6d52a.19c337418d3.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zi_KCgCnXoUMAYZpnz87BQ--.44542W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwcOAWmE8ocisQAAsA
X-CM-DELIVERINFO: =?B?ToigWAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR149YnFNguHllVpYezh+wy/NiB5iWO6vGkpaBCm21Qkq7pbArV0tpjgJxS6vL+lg1nGV5
	QjOISfhCFV7p1NBiI0HDA9LRmLkaY8seg7x7S1p9l959arCTKdPJI8D/VDX8bA==
X-Coremail-Antispam: 1Uk129KBj93XoWxWF18ZFWDtFW5Gr15GFWxuFX_yoW5Wr1kp3
	ykCa17CFW8Gryjgw13Xw15uF18urn3XFWYkw4kK34UKFyYvry0vr18KFZ8WFWj934xZF92
	yFn5Jr1fu34kZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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
	TAGGED_FROM(0.00)[bounces-257567-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:mid,zju.edu.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97AB0FF574
X-Rspamd-Action: no action

T24gRnJpLCA2IEZlYiAyMDI2IDE4OjQ4OjM4ICswODAwIEppamllIFNoYW8gd3JvdGU6Cj4gPiBX
aGVuIHRoZSBQQ0EtMjAwRSBvciBTQkEtMjAwRSBhZGFwdGVyIGlzIGJlaW5nIGRldGFjaGVkLCB0
aGUgZm9yZTIwMGUKPiA+IGlzIGRlYWxsb2NhdGVkLiBIb3dldmVyLCB0aGUgdHhfdGFza2xldCBv
ciByeF90YXNrbGV0IG1heSBzdGlsbCBiZSBydW5uaW5nCj4gPiBvciBwZW5kaW5nLCBsZWFkaW5n
IHRvIHVzZS1hZnRlci1mcmVlIGJ1ZyB3aGVuIHRoZSBhbHJlYWR5IGZyZWVkIGZvcmUyMDBlCj4g
PiBpcyBhY2Nlc3NlZCBhZ2FpbiBpbiBmb3JlMjAwZV90eF90YXNrbGV0KCkgb3IgZm9yZTIwMGVf
cnhfdGFza2xldCgpLgo+ID4KPiA+IE9uZSBvZiB0aGUgcmFjZSBjb25kaXRpb25zIGNhbiBvY2N1
ciBhcyBmb2xsb3dzOgo+ID4KPiA+IENQVSAwIChjbGVhbnVwKSAgICAgICAgICAgfCBDUFUgMSAo
dGFza2xldCkKPiA+IGZvcmUyMDBlX3BjYV9yZW1vdmVfb25lKCkgfCBmb3JlMjAwZV9pbnRlcnJ1
cHQoKQo+ID4gICAgZm9yZTIwMGVfc2h1dGRvd24oKSAgICAgfCAgIHRhc2tsZXRfc2NoZWR1bGUo
KQo+ID4gICAgICBrZnJlZShmb3JlMjAwZSkgICAgICAgfCBmb3JlMjAwZV90eF90YXNrbGV0KCkK
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICBmb3JlMjAwZS0+IC8vIFVBRgo+ID4K
PiA+IEZpeCB0aGlzIGJ5IGVuc3VyaW5nIHR4X3Rhc2tsZXQgb3IgcnhfdGFza2xldCBpcyBwcm9w
ZXJseSBjYW5jZWxlZCBiZWZvcmUKPiA+IHRoZSBmb3JlMjAwZSBpcyByZWxlYXNlZC4gQWRkIHRh
c2tsZXRfa2lsbCgpIGluIGZvcmUyMDBlX3NodXRkb3duKCkgdG8KPiA+IHN5bmNocm9uaXplIHdp
dGggYW55IHBlbmRpbmcgb3IgcnVubmluZyB0YXNrbGV0cy4gTW9yZW92ZXIsIHNpbmNlCj4gPiBm
b3JlMjAwZV9yZXNldCgpIGNvdWxkIHByZXZlbnQgZnVydGhlciBpbnRlcnJ1cHRzIG9yIGRhdGEg
dHJhbnNmZXJzLAo+ID4gdGhlIHRhc2tsZXRfa2lsbCgpIHNob3VsZCBiZSBwbGFjZWQgYWZ0ZXIg
Zm9yZTIwMGVfcmVzZXQoKSB0byBwcmV2ZW50Cj4gPiB0aGUgdGFza2xldCBmcm9tIGJlaW5nIHJl
c2NoZWR1bGVkIGluIGZvcmUyMDBlX2ludGVycnVwdCgpLgo+ID4KPiA+IEZpeGVzOiAxZGExNzdl
NGMzZjQgKCJMaW51eC0yLjYuMTItcmMyIikKPiA+IFNpZ25lZC1vZmYtYnk6IER1b21pbmcgWmhv
dSA8ZHVvbWluZ0B6anUuZWR1LmNuPgo+ID4gLS0tCj4gPiBDaGFuZ2VzIGluIHYyOgo+ID4gICAg
LSBNb3ZlIHRhc2tsZXRfa2lsbCgpIGFmdGVyIGZvcmUyMDBlX3Jlc2V0KCkuCj4gPgo+ID4gICBk
cml2ZXJzL2F0bS9mb3JlMjAwZS5jIHwgNCArKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdG0vZm9yZTIwMGUuYyBi
L2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKPiA+IGluZGV4IGY2MmUzODU3MTQ0Li5kZTA0YzQwNzky
MSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMKPiA+ICsrKyBiL2RyaXZl
cnMvYXRtL2ZvcmUyMDBlLmMKPiA+IEBAIC0zNjIsNiArMzYyLDEwIEBAIGZvcmUyMDBlX3NodXRk
b3duKHN0cnVjdCBmb3JlMjAwZSogZm9yZTIwMGUpCj4gPiAgICAgICBpZiAoZm9yZTIwMGUtPnN0
YXRlID4gRk9SRTIwMEVfU1RBVEVfUkVTRVQpIHsKPiA+ICAgCS8qIGZpcnN0LCByZXNldCB0aGUg
Ym9hcmQgdG8gcHJldmVudCBmdXJ0aGVyIGludGVycnVwdHMgb3IgZGF0YSB0cmFuc2ZlcnMgKi8K
PiA+ICAgCWZvcmUyMDBlX3Jlc2V0KGZvcmUyMDBlLCAwKTsKPiA+ICsjaWZkZWYgRk9SRTIwMEVf
VVNFX1RBU0tMRVQKPiA+ICsJdGFza2xldF9raWxsKCZmb3JlMjAwZS0+dHhfdGFza2xldCk7Cj4g
PiArCXRhc2tsZXRfa2lsbCgmZm9yZTIwMGUtPnJ4X3Rhc2tsZXQpOwo+ID4gKyNlbmRpZgo+ID4g
ICAgICAgfQo+IAo+IEknbSBzb3JyeSBpZiBJIGdhdmUgeW91IGEgY29uZnVzaW5nIGNvbW1lbnQu
Cj4gCj4gSWYgKGZvcmUyMDBlLT5zdGF0ZSA8PSBGT1JFMjAwRV9TVEFURV9SRVNFVCksIGlzIHRo
ZXJlIG5vIG5lZWQgdG8gZG8gdGFza2xldF9raWxsKCk/CgpUaGUgZm9sbG93aW5nIGZvdXIgc3Rh
dGVzIHRoYXQgYXJlIHByZWNlZGluZyBGT1JFMjAwRV9TVEFURV9SRVNFVCBhcmUgb25seSBzZXQK
ZHVyaW5nIGRldmljZSBpbml0aWFsaXphdGlvbjogRk9SRTIwMEVfU1RBVEVfQkxBTkssIEZPUkUy
MDBFX1NUQVRFX1JFR0lTVEVSLCAKRk9SRTIwMEVfU1RBVEVfQ09ORklHVVJFLCBhbmQgRk9SRTIw
MEVfU1RBVEVfTUFQLgoKSWYgdGhlIGRldmljZSBpcyBpbiBhbnkgb2YgdGhlc2Ugc3RhdGVzLCBp
dCBtZWFucyB0aGUgaW5pdGlhbGl6YXRpb24gaXMKbm90IGNvbXBsZXRlIGFuZCBpbnRlcnJ1cHRz
IGhhdmUgbm90IGJlZW4gcmVnaXN0ZXJlZC4gVGhlcmVmb3JlLCB0YXNrbGV0CmNvdWxkIG5vdCBi
ZSBzY2hlZHVsZWQgdGhyb3VnaCBmb3JlMjAwZV9pbnRlcnJ1cHQoKS4KCklmIHRoZSBkZXZpY2Ug
aXMgaW4gRk9SRTIwMEVfU1RBVEVfUkVTRVQgc3RhdGUsIHRoZSBmb3JlMjAwZV9yZXNldCgpIGhh
cyAKYWxyZWFkeSByZXNldCB0aGUgZGV2aWNlLCB3aGljaCBjb3VsZCBwcmV2ZW50IGZ1cnRoZXIg
aW50ZXJydXB0cyBhbmQgCnRhc2tsZXQgc2NoZWR1bGluZy4KClNvIHRoZXJlIGlzIG5vIG5lZWQg
dG8gZG8gdGFza2xldF9raWxsKCkgaWYgdGhlIHN0YXRlIG9mIGZvcmUyMDBlIGlzCmxlc3MgdGhh
biBvciBlcXVhbCB0byBGT1JFMjAwRV9TVEFURV9SRVNFVC4KCkJlc3QgcmVnYXJkcywKRHVvbWlu
ZyBaaG91Cg==


