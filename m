Return-Path: <netdev+bounces-104617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD41990D967
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D99C2853B6
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9E3E49D;
	Tue, 18 Jun 2024 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="BEiB/iT/"
X-Original-To: netdev@vger.kernel.org
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F102139DD;
	Tue, 18 Jun 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718728636; cv=none; b=Pd0M6HwD4Ip+WH/1vY0FXIqmDXBBNp6b39rrNOiOnzsQGkj5A7CqzP1RtsUkL7dGAN5j8bpbKxCus6xkhZtoAWgIqG8Niy9E7s7bkG9sZCPRLmjFQxtVAVmuO92Q/Yv+Pw6jUnvzmmLusAhpE7/AicOX14XANRJ8mdT+ikeOxMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718728636; c=relaxed/simple;
	bh=+zr+cYq8LEpuJSRUOZhobDOGEptwOrvW51PfDDnNXZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a/qYaT2NPdoxpmZf/ShFQ8EH/2JWtzFhgKqfpkN4KRC8JOSLnUW1t5hIJV+2tmo+BPY4u2a9xdUCEEfgnNy+D2OZiGGVMKS79kKIY2LCpx8ZjZhBPhY5DHgZ6BzVN06KrmX2M71XQokBLep+xI5l4nqnXl0HVKHIo7E23PTC02A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=BEiB/iT/; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 0642B61214;
	Tue, 18 Jun 2024 19:37:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6bLJYoJvL4Y0-sUUzT6n3;
	Tue, 18 Jun 2024 19:37:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1718728628; bh=+zr+cYq8LEpuJSRUOZhobDOGEptwOrvW51PfDDnNXZ8=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=BEiB/iT/VawyOXlhMh13SBTf0/ajegrj+8iup7MWIKIPlOS0CpqvgMNvzVaFQh78+
	 WdpYN1NbrueRB6Kc8fVWKz8OLtbCBktVlhPN7eIFcydJ9LIw0QrSUSkPXDDHy5OTc7
	 AVTnBwcKrgiXq8pr3JMG973plZQHsP5uFftCLTxY=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <e84daaf35b825d6f36795533e0ecec8245786ea7.camel@maquefel.me>
Subject: Re: [PATCH v10 17/38] net: cirrus: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Simon Horman <horms@kernel.org>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn
 <andrew@lunn.ch>
Date: Tue, 18 Jun 2024 19:37:06 +0300
In-Reply-To: <20240618124610.GN8447@kernel.org>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
	 <20240617-ep93xx-v10-17-662e640ed811@maquefel.me>
	 <20240618124610.GN8447@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgU2ltb24hCgpPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTM6NDYgKzAxMDAsIFNpbW9uIEhvcm1h
biB3cm90ZToKPiBPbiBNb24sIEp1biAxNywgMjAyNCBhdCAxMjozNjo1MVBNICswMzAwLCBOaWtp
dGEgU2h1YmluIHZpYSBCNCBSZWxheQo+IHdyb3RlOgo+ID4gRnJvbTogTmlraXRhIFNodWJpbiA8
bmlraXRhLnNodWJpbkBtYXF1ZWZlbC5tZT4KPiA+IAo+ID4gLSBhZGQgT0YgSUQgbWF0Y2ggdGFi
bGUKPiA+IC0gZ2V0IHBoeV9pZCBmcm9tIHRoZSBkZXZpY2UgdHJlZSwgYXMgcGFydCBvZiBtZGlv
Cj4gPiAtIGNvcHlfYWRkciBpcyBub3cgYWx3YXlzIHVzZWQsIGFzIHRoZXJlIGlzIG5vIFNvQy9i
b2FyZCB0aGF0Cj4gPiBhcmVuJ3QKPiA+IC0gZHJvcHBlZCBwbGF0Zm9ybSBoZWFkZXIKPiA+IAo+
ID4gU2lnbmVkLW9mZi1ieTogTmlraXRhIFNodWJpbiA8bmlraXRhLnNodWJpbkBtYXF1ZWZlbC5t
ZT4KPiA+IFRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5A
Z21haWwuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IEFuZHJldyBMdW5uIDxhbmRyZXdAbHVubi5jaD4K
PiA+IFJldmlld2VkLWJ5OiBMaW51cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+
Cj4gCj4gSGkgTmlraXRhLAo+IAo+IFNvbWUgbWlub3IgZmVlZGJhY2sgZnJvbSBteSBzaWRlLgoK
VGhhbmtzIGZvciBjYXRjaGVzIQoKSSBob3BlIGNhbiBhZGRyZXNzIHRoZW0gbmV4dCBzcGluIG9y
IGFmdGVyIHNlcmllcyB3aWxsIGFwcGx5IChkZXNpcmFibHkKdGhlIGxhc3Qgb25lKS4KCj4gCj4g
Li4uCj4gCj4gPiBAQCAtNzg2LDI3ICs3NjYsNDcgQEAgc3RhdGljIHZvaWQgZXA5M3h4X2V0aF9y
ZW1vdmUoc3RydWN0Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gPiDCoAo+ID4gwqBzdGF0
aWMgaW50IGVwOTN4eF9ldGhfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiA+
IMKgewo+ID4gLcKgwqDCoMKgwqDCoMKgc3RydWN0IGVwOTN4eF9ldGhfZGF0YSAqZGF0YTsKPiA+
IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2Owo+ID4gwqDCoMKgwqDCoMKg
wqDCoHN0cnVjdCBlcDkzeHhfcHJpdiAqZXA7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJl
c291cmNlICptZW07Cj4gPiArwqDCoMKgwqDCoMKgwqB2b2lkIF9faW9tZW0gKmJhc2VfYWRkcjsK
PiA+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7Cj4gPiArwqDCoMKgwqDC
oMKgwqB1MzIgcGh5X2lkOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGludCBpcnE7Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgaW50IGVycjsKPiAKPiBuaXQ6IFBsZWFzZSBjb25zaWRlciBtYWludGFpbmluZyBy
ZXZlcnNlIHhtYXMgdHJlZSBvcmRlciAtIGxvbmdlc3QKPiBsaW5lCj4gwqDCoMKgwqAgdG8gc2hv
cnRlc3QgLSBmb3IgbG9jYWwgdmFyaWFibGUgZGVjbGFyYXRpb25zLiBBcyBwcmVmZXJyZWQgaW4K
PiDCoMKgwqDCoCBOZXR3b3JraW5nIGNvZGUuCj4gCj4gwqDCoMKgwqAgRWR3YXJkIENyZWUncyB0
b29sIGNhbiBiZSBvZiBhc3Npc3RhbmNlIGhlcmUuCj4gwqDCoMKgwqAgaHR0cHM6Ly9naXRodWIu
Y29tL2VjcmVlLXNvbGFyZmxhcmUveG1hc3RyZWUKPiAKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDC
oMKgaWYgKHBkZXYgPT0gTlVMTCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmV0dXJuIC1FTk9ERVY7Cj4gPiAtwqDCoMKgwqDCoMKgwqBkYXRhID0gZGV2X2dldF9wbGF0ZGF0
YSgmcGRldi0+ZGV2KTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgbWVtID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqBpcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGlm
ICghbWVtIHx8IGlycSA8IDApCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAtRU5YSU87Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgZGV2ID0gZXA5M3h4X2Rldl9h
bGxvYyhkYXRhKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGJhc2VfYWRkciA9IGlvcmVtYXAobWVtLT5z
dGFydCwgcmVzb3VyY2Vfc2l6ZShtZW0pKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmICghYmFzZV9h
ZGRyKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkZXZfZXJyX3By
b2JlKCZwZGV2LT5kZXYsIC1FSU8sICJGYWlsZWQgdG8KPiA+IGlvcmVtYXAgZXRoZXJuZXQgcmVn
aXN0ZXJzXG4iKTsKPiAKPiBuaXQ6IFBsZWFzZSBjb25zaWRlciBsaW5lLXdyYXBwaW5nIHRvIGxp
bWl0aW5nIGxpbmVzIHRvIDgwIGNvbHVtbnMKPiB3aWRlCj4gwqDCoMKgwqAgd2hlcmUgaXQgY2Fu
IGJlIHRyaXZpYWxseSBhY2hpZXZlZCwgd2hpY2ggc2VlbXMgdG8gYmUgdGhlIGNhc2UKPiBoZXJl
Lgo+IMKgwqDCoMKgIDgwIGNvbHVtbnMgaXMgc3RpbGwgcHJlZmVycmVkIGZvciBOZXR3b3JraW5n
IGNvZGUuCj4gCj4gwqDCoMKgwqAgRmxhZ2dlZCBieSBjaGVja3BhdGNoLnBsIC0tbWF4LWxpbmUt
bGVuZ3RoPTgwCj4gCj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqBucCA9IG9mX3BhcnNlX3BoYW5k
bGUocGRldi0+ZGV2Lm9mX25vZGUsICJwaHktaGFuZGxlIiwgMCk7Cj4gPiArwqDCoMKgwqDCoMKg
wqBpZiAoIW5wKQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBkZXZf
ZXJyX3Byb2JlKCZwZGV2LT5kZXYsIC1FTk9ERVYsICJQbGVhc2UKPiA+IHByb3ZpZGUgXCJwaHkt
aGFuZGxlXCJcbiIpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgZXJyID0gb2ZfcHJvcGVydHlf
cmVhZF91MzIobnAsICJyZWciLCAmcGh5X2lkKTsKPiA+ICvCoMKgwqDCoMKgwqDCoG9mX25vZGVf
cHV0KG5wKTsKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChlcnIpCj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIGRldl9lcnJfcHJvYmUoJnBkZXYtPmRldiwgLUVOT0VOVCwg
IkZhaWxlZAo+ID4gdG8gbG9jYXRlIFwicGh5X2lkXCJcbiIpOwo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgZGV2ID0gYWxsb2NfZXRoZXJkZXYoc2l6ZW9mKHN0cnVjdCBlcDkzeHhfcHJpdikpOwo+
ID4gwqDCoMKgwqDCoMKgwqDCoGlmIChkZXYgPT0gTlVMTCkgewo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlcnIgPSAtRU5PTUVNOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBnb3RvIGVycl9vdXQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgfQo+ID4gKwo+ID4g
K8KgwqDCoMKgwqDCoMKgZXRoX2h3X2FkZHJfc2V0KGRldiwgYmFzZV9hZGRyICsgMHg1MCk7Cj4g
Cj4gYmFzZV9hZGRyIGlzIGFuIF9faW9tZW0gYWRkcmVzcy4gQXMgc3VjaCBJIGRvbid0IHRoaW5r
IGl0IGlzIGNvcnJlY3QKPiB0byBwYXNzIGl0ICgrIG9mZnNldCkgdG8gZXRoX2h3X2FkZHJfc2V0
LiBSYXRoZXIsIEkgd291bGQgZXhwZWN0Cj4gYmFzZV9hZGRyCj4gdG8gYmUgcmVhZCB1c2luZyBh
IHN1aXRhYmxlIGlvbWVtIGFjY2Vzc29yLCBmLmUuIHJlYWRsLiBBbmQgb25lCj4gcG9zc2libGUK
PiBzb2x1dGlvbiB3b3VsZCBiZSB0byB1c2UgcmVhZGwgdG8gcmVhZCB0aGUgbWFjIGFkZHJlc3Mg
aW50byBhIGJ1ZmZlcgo+IHdoaWNoIGlzIHBhc3NlZCB0byBldGhfaHdfYWRkcl9zZXQuCj4gCj4g
RmxhZ2dlZCBieSBTcGFyc2UuCj4gCj4gPiArwqDCoMKgwqDCoMKgwqBkZXYtPmV0aHRvb2xfb3Bz
ID0gJmVwOTN4eF9ldGh0b29sX29wczsKPiA+ICvCoMKgwqDCoMKgwqDCoGRldi0+bmV0ZGV2X29w
cyA9ICZlcDkzeHhfbmV0ZGV2X29wczsKPiA+ICvCoMKgwqDCoMKgwqDCoGRldi0+ZmVhdHVyZXMg
fD0gTkVUSUZfRl9TRyB8IE5FVElGX0ZfSFdfQ1NVTTsKPiA+ICsKPiA+IMKgwqDCoMKgwqDCoMKg
wqBlcCA9IG5ldGRldl9wcml2KGRldik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZXAtPmRldiA9IGRl
djsKPiA+IMKgwqDCoMKgwqDCoMKgwqBTRVRfTkVUREVWX0RFVihkZXYsICZwZGV2LT5kZXYpOwo+
IAo+IC4uLgoK


