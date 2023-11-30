Return-Path: <netdev+bounces-52536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72727FF11C
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78DB1C20BC5
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B047A59;
	Thu, 30 Nov 2023 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEgdgaMn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B84B9
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701353022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gmdPA6Q0p/W1i/RS4gTbBPaBlWq/FezNYBpeVlP4grs=;
	b=UEgdgaMntbwIBcLBDKJFrAAqoNKmbaziAOPN6qXXgVFgn/fW14fcxc9NAxu6HmSMIXiovf
	uUKkv/HA9xiDW2Z/2wErpmzYOTDGAUHq17G9a9v6BcH5GHBaaByxxmHds7z1iDXbMpHFKl
	mvpcN5p8JD3X4hllNyyJz17z5J/IBjU=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-kB2s64BQNP6g0W3YXqbd9g-1; Thu, 30 Nov 2023 09:03:40 -0500
X-MC-Unique: kB2s64BQNP6g0W3YXqbd9g-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-6cdc03f9fe9so1104690b3a.1
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 06:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353015; x=1701957815;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmdPA6Q0p/W1i/RS4gTbBPaBlWq/FezNYBpeVlP4grs=;
        b=MF8KpzqjecCYg9Fc1Fa4zFsYAX7YLtknGD3wPmXot5LyMmNRoy+Sw6XTvS+JFSG1RH
         wZVI8kaLm6ZQsxACwbx6cmkANtxKNQGjhonhnXv2TMZLIP/g5s+yBy57mXpkhhlVkoGA
         lD/d+kW7Rd9yhhugS0watxHPAxK0UyZsLO+Vaj5qtCE/QesyRixJPax2g7ETGzd7avXQ
         pfcQP5Xujp7o1Fko+J1s1AXVh/dIyXOFM9sLcObuXhCafrB0Mi1CtX4CkqODiLZQUsJQ
         lwVp3+mSG78o1gO3dHCTqeUohxsoJhdJ/gVsfi0WjIZ8ZJhBpj7Y/3qr2HC0O/RXb50D
         SBdA==
X-Gm-Message-State: AOJu0Yxui2raaQ5p7DWN6JGNUhcd8kjWt9Ewe4SCjMnSspGc1xgLj1a1
	C5FmelHtTRMkRjmxCzj4HuqrTRXxoUn1UQj+S1/eaBYajDg8GzHYSD0IoboI+YIRw56CU4LWrVP
	FghOcruy0ZojIFb5D
X-Received: by 2002:a05:6a20:7d90:b0:18c:159b:7f9 with SMTP id v16-20020a056a207d9000b0018c159b07f9mr21669077pzj.9.1701353015301;
        Thu, 30 Nov 2023 06:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdSW+2umD53SCs6TiYdklpG0q3siARTKLwhi4Q9J/3czjPhDQqPtFb2ESipFTTfZjLCSxxKg==
X-Received: by 2002:a05:6a20:7d90:b0:18c:159b:7f9 with SMTP id v16-20020a056a207d9000b0018c159b07f9mr21669055pzj.9.1701353014964;
        Thu, 30 Nov 2023 06:03:34 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm1269885pfg.30.2023.11.30.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:03:34 -0800 (PST)
Date: Thu, 30 Nov 2023 23:03:29 +0900 (JST)
Message-Id: <20231130.230329.2023533070545022513.syoshida@redhat.com>
To: edumazet@google.com
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
References: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
	<20231129.105046.2126277148145584341.syoshida@redhat.com>
	<CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAyOSBOb3YgMjAyMyAxMDo1Njo0NyArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBXZWQsIE5vdiAyOSwgMjAyMyBhdCAyOjUx4oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9z
aGlkYUByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBNb24sIDI3IE5vdiAyMDIzIDEwOjU1
OjAxIC0wNTAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPj4gPiBTaGlnZXJ1IFlvc2hpZGEg
d3JvdGU6DQo+PiA+PiBJbiBpcGdyZV94bWl0KCksIHNrYl9wdWxsKCkgbWF5IGZhaWwgZXZlbiBp
ZiBwc2tiX2luZXRfbWF5X3B1bGwoKSByZXR1cm5zDQo+PiA+PiB0cnVlLiBGb3IgZXhhbXBsZSwg
YXBwbGljYXRpb25zIGNhbiBjcmVhdGUgYSBtYWxmb3JtZWQgcGFja2V0IHRoYXQgY2F1c2VzDQo+
PiA+PiB0aGlzIHByb2JsZW0gd2l0aCBQRl9QQUNLRVQuDQo+PiA+DQo+PiA+IEl0IG1heSBmYWls
IGJlY2F1c2UgYmVjYXVzZSBwc2tiX2luZXRfbWF5X3B1bGwgZG9lcyBub3QgYWNjb3VudCBmb3IN
Cj4+ID4gdHVubmVsLT5obGVuLg0KPj4gPg0KPj4gPiBJcyB0aGF0IHdoYXQgeW91IGFyZSByZWZl
cnJpbmcgdG8gd2l0aCBtYWxmb3JtZWQgcGFja2V0PyBDYW4geW91DQo+PiA+IGVsb2JvcmF0ZSBh
IGJpdCBvbiBpbiB3aGljaCB3YXkgdGhlIHBhY2tldCBoYXMgdG8gYmUgbWFsZm9ybWVkIHRvDQo+
PiA+IHJlYWNoIHRoaXM/DQo+Pg0KPj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBwcm9t
cHQgZmVlZGJhY2suDQo+Pg0KPj4gQWN0dWFsbHksIEkgZm91bmQgdGhpcyBwcm9ibGVtIGJ5IHJ1
bm5pbmcgc3l6a2FsbGVyLiBTeXprYWxsZXINCj4+IHJlcG9ydGVkIHRoZSBmb2xsb3dpbmcgdW5p
bml0LXZhbHVlIGlzc3VlIChJIHRoaW5rIHRoZSByb290IGNhdXNlIG9mDQo+PiB0aGlzIGlzc3Vl
IGlzIHRoZSBzYW1lIGFzIHRoZSBvbmUgRXJpYyBtZW50aW9uZWQpOg0KPiANCj4gWWVzLCBJIGFs
c28gaGF2ZSBhIHNpbWlsYXIgc3l6Ym90IHJlcG9ydCAoYnV0IG5vIHJlcHJvIHlldCkgSSBhbQ0K
PiByZWxlYXNpbmcgaXQgcmlnaHQgbm93Lg0KPiANCj4+DQo+PiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4gQlVHOiBLTVNBTjogdW5pbml0
LXZhbHVlIGluIF9fZ3JlX3htaXQgbmV0L2lwdjQvaXBfZ3JlLmM6NDY5IFtpbmxpbmVdDQo+PiBC
VUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gaXBncmVfeG1pdCsweGRmNC8weGU3MCBuZXQvaXB2
NC9pcF9ncmUuYzo2NjINCj4+ICBfX2dyZV94bWl0IG5ldC9pcHY0L2lwX2dyZS5jOjQ2OSBbaW5s
aW5lXQ0KPj4NCj4gDQo+IA0KPiANCj4+IFRoZSBzaW1wbGlmaWVkIHZlcnNpb24gb2YgdGhlIHJl
cHJvIGlzIHNob3duIGJlbG93Og0KPj4NCj4+ICNpbmNsdWRlIDxsaW51eC9pZl9ldGhlci5oPg0K
Pj4gI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPj4gI2luY2x1ZGUgPG5ldGluZXQvZXRoZXIuaD4N
Cj4+ICNpbmNsdWRlIDxuZXQvaWYuaD4NCj4+ICNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQo+PiAj
aW5jbHVkZSA8bmV0aW5ldC9pbi5oPg0KPj4gI2luY2x1ZGUgPHN0cmluZy5oPg0KPj4gI2luY2x1
ZGUgPHVuaXN0ZC5oPg0KPj4gI2luY2x1ZGUgPHN0ZGlvLmg+DQo+PiAjaW5jbHVkZSA8c3RkbGli
Lmg+DQo+PiAjaW5jbHVkZSA8bGludXgvaWZfcGFja2V0Lmg+DQo+Pg0KPj4gaW50IG1haW4odm9p
ZCkNCj4+IHsNCj4+ICAgICAgICAgaW50IHMsIHMxLCBzMiwgZGF0YSA9IDA7DQo+PiAgICAgICAg
IHN0cnVjdCBpZnJlcSBpZnI7DQo+PiAgICAgICAgIHN0cnVjdCBzb2NrYWRkcl9sbCBhZGRyID0g
eyAwIH07DQo+PiAgICAgICAgIHVuc2lnbmVkIGNoYXIgbWFjX2FkZHJbXSA9IHsweDEsIDB4Miwg
MHgzLCAweDQsIDB4NSwgMHg2fTsNCj4+DQo+PiAgICAgICAgIHMgPSBzb2NrZXQoQUZfUEFDS0VU
LCBTT0NLX0RHUkFNLCAweDMwMCk7DQo+PiAgICAgICAgIHMxID0gc29ja2V0KEFGX1BBQ0tFVCwg
U09DS19SQVcsIDB4MzAwKTsNCj4+ICAgICAgICAgczIgPSBzb2NrZXQoQUZfTkVUTElOSywgU09D
S19SQVcsIDApOw0KPj4NCj4+ICAgICAgICAgc3RyY3B5KGlmci5pZnJfbmFtZSwgImdyZTAiKTsN
Cj4+ICAgICAgICAgaW9jdGwoczIsIFNJT0NHSUZJTkRFWCwgJmlmcik7DQo+Pg0KPj4gICAgICAg
ICBhZGRyLnNsbF9mYW1pbHkgPSBBRl9QQUNLRVQ7DQo+PiAgICAgICAgIGFkZHIuc2xsX2lmaW5k
ZXggPSBpZnIuaWZyX2lmaW5kZXg7DQo+PiAgICAgICAgIGFkZHIuc2xsX3Byb3RvY29sID0gaHRv
bnMoMCk7DQo+PiAgICAgICAgIGFkZHIuc2xsX2hhdHlwZSA9IEFSUEhSRF9FVEhFUjsNCj4+ICAg
ICAgICAgYWRkci5zbGxfcGt0dHlwZSA9IFBBQ0tFVF9IT1NUOw0KPj4gICAgICAgICBhZGRyLnNs
bF9oYWxlbiA9IEVUSF9BTEVOOw0KPj4gICAgICAgICBtZW1jcHkoYWRkci5zbGxfYWRkciwgbWFj
X2FkZHIsIEVUSF9BTEVOKTsNCj4+DQo+PiAgICAgICAgIHNlbmR0byhzMSwgJmRhdGEsIDEsIDAs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKTsNCj4+DQo+PiAgICAgICAg
IHJldHVybiAwOw0KPj4gfQ0KPj4NCj4+IFRoZSByZXBybyBzZW5kcyBhIDEtYnl0ZSBwYWNrZXQg
dGhhdCBkb2Vzbid0IGhhdmUgdGhlIGNvcnJlY3QgSVANCj4+IGhlYWRlci4gSSBtZWFudCB0aGlz
IGFzICJtYWxmb3JtZWQgcGFjaGV0IiwgYnV0IHRoYXQgbWlnaHQgYmUgYSBiaXQNCj4+IGNvbmZ1
c2luZywgc29ycnkuDQo+Pg0KPj4gSSB0aGluayB0aGUgY2F1c2Ugb2YgdGhlIHVuaW5pdC12YWx1
ZSBhY2Nlc3MgaXMgdGhhdCBpcGdyZV94bWl0KCkNCj4+IHJlYWxsb2NhdGVzIHRoZSBza2Igd2l0
aCBza2JfY293X2hlYWQoKSBhbmQgY29waWVzIG9ubHkgdGhlIDEtYnl0ZQ0KPj4gZGF0YSwgc28g
YW55IElQIGhlYWRlciBhY2Nlc3MgdGhyb3VnaCBgdG5sX3BhcmFtc2AgY2FuIGNhdXNlIHRoZQ0K
Pj4gcHJvYmxlbS4NCj4+DQo+PiBBdCBmaXJzdCBJIHRyaWVkIHRvIG1vZGlmeSBwc2tiX2luZXRf
bWF5X3B1bGwoKSB0byBkZXRlY3QgdGhpcyB0eXBlIG9mDQo+PiBwYWNrZXQsIGJ1dCBJIGVuZGVk
IHVwIGRvaW5nIHRoaXMgcGF0Y2guDQo+IA0KPiBFdmVuIGFmdGVyIHlvdXIgcGF0Y2gsIF9fc2ti
X3B1bGwoKSBjb3VsZCBjYWxsIEJVRygpIGFuZCBjcmFzaC4NCj4gDQo+IEkgd291bGQgc3VnZ2Vz
dCB1c2luZyB0aGlzIGZpeCBpbnN0ZWFkLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4N
Cg0KWW91ciBwYXRjaCBlbnN1cmVzIHRoYXQgc2tiX3B1bGwoKSBjYW4gcHVsbCB0aGUgcmVxdWly
ZWQgc2l6ZSwgc28gaXQNCmxvb2tzIGdvb2QgdG8gbWUuIEFsc28sIEkgaGF2ZSB0ZXN0ZWQgeW91
ciBzdWdnZXN0ZWQgcGF0Y2ggd2l0aCB0aGUNCnJlcHJvIGFuZCBjb25maXJtZWQgdGhhdCBpdCBm
aXhlcyB0aGUgaXNzdWUuDQoNClRoYW5rcywNClNoaWdlcnUNCg0KPiANCj4gZGlmZiAtLWdpdCBh
L25ldC9pcHY0L2lwX2dyZS5jIGIvbmV0L2lwdjQvaXBfZ3JlLmMNCj4gaW5kZXggMjJhMjZkMWQy
OWEwOWQyMzRmMThjZTNiMGYzMjllNTA0N2MwYzA0Ni4uNTE2OWMzYzcyY2ZmZTQ5Y2VmNjEzZTY5
ODg5ZDEzOWRiODY3ZmY3NA0KPiAxMDA2NDQNCj4gLS0tIGEvbmV0L2lwdjQvaXBfZ3JlLmMNCj4g
KysrIGIvbmV0L2lwdjQvaXBfZ3JlLmMNCj4gQEAgLTYzNSwxNSArNjM1LDE4IEBAIHN0YXRpYyBu
ZXRkZXZfdHhfdCBpcGdyZV94bWl0KHN0cnVjdCBza19idWZmICpza2IsDQo+ICAgICAgICAgfQ0K
PiANCj4gICAgICAgICBpZiAoZGV2LT5oZWFkZXJfb3BzKSB7DQo+ICsgICAgICAgICAgICAgICBp
bnQgcHVsbF9sZW4gPSB0dW5uZWwtPmhsZW4gKyBzaXplb2Yoc3RydWN0IGlwaGRyKTsNCj4gKw0K
PiAgICAgICAgICAgICAgICAgaWYgKHNrYl9jb3dfaGVhZChza2IsIDApKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGZyZWVfc2tiOw0KPiANCj4gICAgICAgICAgICAgICAgIHRubF9w
YXJhbXMgPSAoY29uc3Qgc3RydWN0IGlwaGRyICopc2tiLT5kYXRhOw0KPiANCj4gLSAgICAgICAg
ICAgICAgIC8qIFB1bGwgc2tiIHNpbmNlIGlwX3R1bm5lbF94bWl0KCkgbmVlZHMgc2tiLT5kYXRh
IHBvaW50aW5nDQo+IC0gICAgICAgICAgICAgICAgKiB0byBncmUgaGVhZGVyLg0KPiAtICAgICAg
ICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgICBza2JfcHVsbChza2IsIHR1bm5lbC0+aGxl
biArIHNpemVvZihzdHJ1Y3QgaXBoZHIpKTsNCj4gKyAgICAgICAgICAgICAgIGlmICghcHNrYl9u
ZXR3b3JrX21heV9wdWxsKHNrYiwgcHVsbF9sZW4pKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGZyZWVfc2tiOw0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBpcF90dW5uZWxfeG1p
dCgpIG5lZWRzIHNrYi0+ZGF0YSBwb2ludGluZyB0byBncmUgaGVhZGVyLiAqLw0KPiArICAgICAg
ICAgICAgICAgc2tiX3B1bGwoc2tiLCBwdWxsX2xlbik7DQo+ICAgICAgICAgICAgICAgICBza2Jf
cmVzZXRfbWFjX2hlYWRlcihza2IpOw0KPiANCj4gICAgICAgICAgICAgICAgIGlmIChza2ItPmlw
X3N1bW1lZCA9PSBDSEVDS1NVTV9QQVJUSUFMICYmDQo+IA0K


