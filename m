Return-Path: <netdev+bounces-257498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SICUG3e0hWmbFQQAu9opvQ
	(envelope-from <netdev+bounces-257498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:29:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9570CFC090
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7A23004637
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB4535B64E;
	Fri,  6 Feb 2026 09:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F229345740;
	Fri,  6 Feb 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369887; cv=none; b=YKTHsEU8mkNwLdydgJtNkB4lv9RiJC6vhBDpiNpvHM1rcZCdQm+P4AM9qdJz+Z9cBzXDS1rRMFALBQD/ZW0ZNVde62k6peJaOHEeOw9g07qP+AQsSfSstaKTAgMPEIyUU7Sski4FCwCMUXYmF0W3exuAR0qfeT5Jufja+RfuIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369887; c=relaxed/simple;
	bh=DzivIq0z2g+HN2WYqwO0Ny3JkGOtpkdz0RLth/DavD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=O4OEpdFw2a3fn4aGfv5qRiAb/8mH+C8amznMh5cHlltuYqVdwcVlfcnjZoeccgeK9VtUcaBeOrUu8fvgN07rvUsh8rtY9lHxbRGOWq0W5b/KmvKBuaLm2mYO/03zYP+q8vL0U65HUkIn4BoZoNcGsM26DUknMzo4jTmXoeBdtIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.18.78])
	by mtasvr (Coremail) with SMTP id _____wDn73NKs4VpnHqKAA--.32588S3;
	Fri, 06 Feb 2026 17:24:27 +0800 (CST)
Received: from duoming$zju.edu.cn ( [218.12.18.78] ) by
 ajax-webmail-mail-app2 (Coremail) ; Fri, 6 Feb 2026 17:24:23 +0800
 (GMT+08:00)
Date: Fri, 6 Feb 2026 17:24:23 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Jijie Shao" <shaojijie@huawei.com>
Cc: netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, 3chas3@gmail.com
Subject: Re: [PATCH net] atm: fore200e: fix use-after-free in tasklets
 during device removal
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2024.3-cmXT6 build
 20250620(94335109) Copyright (c) 2002-2026 www.mailtech.cn zju.edu.cn
In-Reply-To: <b68a6d51-a416-4252-848e-0f3a8a3216bd@huawei.com>
References: <20260205030317.39190-1-duoming@zju.edu.cn>
 <b68a6d51-a416-4252-848e-0f3a8a3216bd@huawei.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ea159e7.6ea9a.19c3244507b.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:zC_KCgD3xDZIs4Vp_wuyBQ--.44231W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMOAWmE8ocaTAAAsB
X-CM-DELIVERINFO: =?B?Hb+iwwXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1zXbE/KbOKpOcnYVZjSMniAvL7tC09SAnHIJSSYTvEvDjd63BaiSRTGl8s0LazOk63Br
	THAvnGnKZaAdGGxRTO3CsdWy6DgEGqUElsGlCUUkGRdDfyo5jrcTWZYr9xXDmQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxJrW3GF4rAF45tr4rXw1fAFc_yoW8trW8p3
	yUCa17CFW8Jryj9w17Jw18uF18Zrn3ZFWYkws7K34j9F1Yvr109r1xKFs8WFWjk34UAr1v
	yr1ktF13W34kJFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUmvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	C2KfnxnUUI43ZEXa7IU8v_MDUUUUU==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257498-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[duoming@zju.edu.cn,netdev@vger.kernel.org];
	DMARC_NA(0.00)[zju.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_X_PRIO_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,gmail.com];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zju.edu.cn:mid,zju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9570CFC090
X-Rspamd-Action: no action

T24gRnJpLCA2IEZlYiAyMDI2IDExOjQ4OjQ5ICswODAwIEppamllIFNoYW8gd3JvdGU6Cj4gPiBX
aGVuIHRoZSBQQ0EtMjAwRSBvciBTQkEtMjAwRSBhZGFwdGVycyBpcyBiZWluZyBkZXRhY2hlZCwg
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
aXRoIGFueSBwZW5kaW5nIG9yIHJ1bm5pbmcgdGFza2xldHMuCj4gPgo+ID4gRml4ZXM6IDFkYTE3
N2U0YzNmNCAoIkxpbnV4LTIuNi4xMi1yYzIiKQo+ID4gU2lnbmVkLW9mZi1ieTogRHVvbWluZyBa
aG91IDxkdW9taW5nQHpqdS5lZHUuY24+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9hdG0vZm9yZTIw
MGUuYyB8IDcgKysrKysrLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRtL2ZvcmUyMDBlLmMg
Yi9kcml2ZXJzL2F0bS9mb3JlMjAwZS5jCj4gPiBpbmRleCBmNjJlMzg1NzE0NC4uNzQ3MGRhZjk0
NjkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2F0bS9mb3JlMjAwZS5jCj4gPiArKysgYi9kcml2
ZXJzL2F0bS9mb3JlMjAwZS5jCj4gPiBAQCAtMzU4LDcgKzM1OCwxMiBAQCBmb3JlMjAwZV9zaHV0
ZG93bihzdHJ1Y3QgZm9yZTIwMGUqIGZvcmUyMDBlKQo+ID4gICAgICAgcHJpbnRrKEZPUkUyMDBF
ICJyZW1vdmluZyBkZXZpY2UgJXMgYXQgMHglbHgsIElSUSAlc1xuIiwKPiA+ICAgCSAgIGZvcmUy
MDBlLT5uYW1lLCBmb3JlMjAwZS0+cGh5c19iYXNlLAo+ID4gICAJICAgZm9yZTIwMGVfaXJxX2l0
b2EoZm9yZTIwMGUtPmlycSkpOwo+ID4gLQo+ID4gKwo+ID4gKyNpZmRlZiBGT1JFMjAwRV9VU0Vf
VEFTS0xFVAo+ID4gKwl0YXNrbGV0X2tpbGwoJmZvcmUyMDBlLT50eF90YXNrbGV0KTsKPiA+ICsJ
dGFza2xldF9raWxsKCZmb3JlMjAwZS0+cnhfdGFza2xldCk7Cj4gPiArI2VuZGlmCj4gPiArCj4g
PiAgICAgICBpZiAoZm9yZTIwMGUtPnN0YXRlID4gRk9SRTIwMEVfU1RBVEVfUkVTRVQpIHsKPiA+
ICAgCS8qIGZpcnN0LCByZXNldCB0aGUgYm9hcmQgdG8gcHJldmVudCBmdXJ0aGVyIGludGVycnVw
dHMgb3IgZGF0YSB0cmFuc2ZlcnMgKi8KPiA+ICAgCWZvcmUyMDBlX3Jlc2V0KGZvcmUyMDBlLCAw
KTsKPiAKPiBIaSwKPiAKPiBJIHBlcnNvbmFsbHkgdGhpbmsgdGhhdCB0YXNrbGV0X2tpbGwoKSBz
aG91bGQgYmUgbW92ZWQgaGVyZS4KPiBBY2NvcmRpbmcgdG8gdGhlIGNvZGUgY29tbWVudHMsIHRo
ZXJlIHdpbGwgYmUgbm8gZGF0YSB0cmFuc2ZlcnMgb3IgaW50ZXJydXB0cyBhZnRlciBmb3JlMjAw
ZV9yZXNldCgpLAo+IG90aGVyd2lzZSBmb3JlMjAwZS0+dHhfdGFza2xldCBtYXkgYmUgcmVzY2hl
ZHVsZWQgYWdhaW4gaW4gZm9yZTIwMGVfaW50ZXJydXB0KCkuCgpUaGFuayB5b3UgZm9yIHlvdXIg
c3VnZ2VzdGlvbnMhIEkgdGhpbmsgeW91IGFyZSByaWdodC4gSSB3aWxsIHNlbmQgdGhlIHYyIHBh
dGNoCmFuZCBtb3ZlIHRoZSB0YXNrbGV0X2tpbGwoKSBhZnRlciBmb3JlMjAwZV9yZXNldCgpLgoK
QmVzdCByZWdhcmRzLApEdW9taW5nIFpob3UK


