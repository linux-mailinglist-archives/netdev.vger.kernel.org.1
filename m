Return-Path: <netdev+bounces-52790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A571D800379
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98DE1C20A5C
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B5BE5C;
	Fri,  1 Dec 2023 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L20XJVL6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559A1720
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 22:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701410412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c5UCSvcRKtd6d2j+BMVs/9VlfhZGRPUwVUQBSZyn2JA=;
	b=L20XJVL6UNkRsVyDRTnclrL2yL3url6qNgKOiaJEAaa9Nw4hwMeZEqoUGZNzItgedagA2m
	CMHUQH5rC0Dl4Bs7TqSK5OJVWNj67T+YLqdml1fW4XA8XPlNZG18pyf+fFT7lluu8I2iDh
	RWyjXTfDYWuLf96RCB24/NMd3GEsq0M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-2c3leWtAMAqgqhgMfqWv9w-1; Fri, 01 Dec 2023 01:00:08 -0500
X-MC-Unique: 2c3leWtAMAqgqhgMfqWv9w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-285b77f7e1fso1663159a91.0
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 22:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701410407; x=1702015207;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c5UCSvcRKtd6d2j+BMVs/9VlfhZGRPUwVUQBSZyn2JA=;
        b=kVXsH4WGa6loBjYYZxdm0qh8IwpxC/3tBjzgMBItVE8t04hxx5HykmsWmAb8hALTTu
         0gNXnqOXnSUTXLwkVuPWndOYGYNvg1+NPcoVtfbEb3PDanbv4htG1tXdGgNiCwinYQ6J
         HrQV9mj5uNq+abTKRlRLhcSxe+sU07LiSYc3t27OuRAaBCdc5SzwoPZHAv3FAVi/YYcc
         AZPKhsJdbYMZ3GkkZsJvoPVZ8QysI1F19EleyuO+WHLJCPMYxjKb1BQkHlVPXUVx9DyL
         BwI2wPNpnOXg+R+0xgZi5Ga5Du0520mHzOjCWOB36Nbd0wVWD/AQgTLAuFB7TUA8MDxd
         zfMQ==
X-Gm-Message-State: AOJu0YyqAhKuVFQ3H/YPzQvbiFIYT6LExMjrwebQynIYoMG6qlanrgPG
	rLxoRsDAF+m6tDbW/2h/pUYCg9uzr87Lr+4UZEmAM7sTehswxDLGBhVXFXxP8V3nddSu9pkVfCA
	zUgkrfOIB096wgEq0
X-Received: by 2002:a17:90a:1656:b0:286:49cb:ef22 with SMTP id x22-20020a17090a165600b0028649cbef22mr3583848pje.24.1701410407252;
        Thu, 30 Nov 2023 22:00:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFL0i6C+nvuHJfXZFwprm/4fHEbJS8k0eoF9pHdZq0wQukG9xOm1Bqg4VmjooU3zZwm9Y4lw==
X-Received: by 2002:a17:90a:1656:b0:286:49cb:ef22 with SMTP id x22-20020a17090a165600b0028649cbef22mr3583751pje.24.1701410405567;
        Thu, 30 Nov 2023 22:00:05 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090ab10800b002865028e17csm1039533pjq.9.2023.11.30.22.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 22:00:05 -0800 (PST)
Date: Fri, 01 Dec 2023 15:00:01 +0900 (JST)
Message-Id: <20231201.150001.994919262711540315.syoshida@redhat.com>
To: edumazet@google.com
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89i+u6tFJQKESV9DH-HypezVV7Ux+XhnyFGLd833PR9Qpyw@mail.gmail.com>
References: <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
	<20231130.230329.2023533070545022513.syoshida@redhat.com>
	<CANn89i+u6tFJQKESV9DH-HypezVV7Ux+XhnyFGLd833PR9Qpyw@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

DQpPbiBUaHUsIDMwIE5vdiAyMDIzIDE1OjA1OjM4ICswMTAwLCBFcmljIER1bWF6ZXQgd3JvdGU6
DQo+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0IDM6MDPigK9QTSBTaGlnZXJ1IFlvc2hpZGEgPHN5
b3NoaWRhQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIFdlZCwgMjkgTm92IDIwMjMgMTA6
NTY6NDcgKzAxMDAsIEVyaWMgRHVtYXpldCB3cm90ZToNCj4+ID4gT24gV2VkLCBOb3YgMjksIDIw
MjMgYXQgMjo1MeKAr0FNIFNoaWdlcnUgWW9zaGlkYSA8c3lvc2hpZGFAcmVkaGF0LmNvbT4gd3Jv
dGU6DQo+PiA+Pg0KPj4gPj4gT24gTW9uLCAyNyBOb3YgMjAyMyAxMDo1NTowMSAtMDUwMCwgV2ls
bGVtIGRlIEJydWlqbiB3cm90ZToNCj4+ID4+ID4gU2hpZ2VydSBZb3NoaWRhIHdyb3RlOg0KPj4g
Pj4gPj4gSW4gaXBncmVfeG1pdCgpLCBza2JfcHVsbCgpIG1heSBmYWlsIGV2ZW4gaWYgcHNrYl9p
bmV0X21heV9wdWxsKCkgcmV0dXJucw0KPj4gPj4gPj4gdHJ1ZS4gRm9yIGV4YW1wbGUsIGFwcGxp
Y2F0aW9ucyBjYW4gY3JlYXRlIGEgbWFsZm9ybWVkIHBhY2tldCB0aGF0IGNhdXNlcw0KPj4gPj4g
Pj4gdGhpcyBwcm9ibGVtIHdpdGggUEZfUEFDS0VULg0KPj4gPj4gPg0KPj4gPj4gPiBJdCBtYXkg
ZmFpbCBiZWNhdXNlIGJlY2F1c2UgcHNrYl9pbmV0X21heV9wdWxsIGRvZXMgbm90IGFjY291bnQg
Zm9yDQo+PiA+PiA+IHR1bm5lbC0+aGxlbi4NCj4+ID4+ID4NCj4+ID4+ID4gSXMgdGhhdCB3aGF0
IHlvdSBhcmUgcmVmZXJyaW5nIHRvIHdpdGggbWFsZm9ybWVkIHBhY2tldD8gQ2FuIHlvdQ0KPj4g
Pj4gPiBlbG9ib3JhdGUgYSBiaXQgb24gaW4gd2hpY2ggd2F5IHRoZSBwYWNrZXQgaGFzIHRvIGJl
IG1hbGZvcm1lZCB0bw0KPj4gPj4gPiByZWFjaCB0aGlzPw0KPj4gPj4NCj4+ID4+IFRoYW5rIHlv
dSB2ZXJ5IG11Y2ggZm9yIHlvdXIgcHJvbXB0IGZlZWRiYWNrLg0KPj4gPj4NCj4+ID4+IEFjdHVh
bGx5LCBJIGZvdW5kIHRoaXMgcHJvYmxlbSBieSBydW5uaW5nIHN5emthbGxlci4gU3l6a2FsbGVy
DQo+PiA+PiByZXBvcnRlZCB0aGUgZm9sbG93aW5nIHVuaW5pdC12YWx1ZSBpc3N1ZSAoSSB0aGlu
ayB0aGUgcm9vdCBjYXVzZSBvZg0KPj4gPj4gdGhpcyBpc3N1ZSBpcyB0aGUgc2FtZSBhcyB0aGUg
b25lIEVyaWMgbWVudGlvbmVkKToNCj4+ID4NCj4+ID4gWWVzLCBJIGFsc28gaGF2ZSBhIHNpbWls
YXIgc3l6Ym90IHJlcG9ydCAoYnV0IG5vIHJlcHJvIHlldCkgSSBhbQ0KPj4gPiByZWxlYXNpbmcg
aXQgcmlnaHQgbm93Lg0KPj4gPg0KPj4gPj4NCj4+ID4+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+PiA+PiBCVUc6IEtNU0FOOiB1bmluaXQt
dmFsdWUgaW4gX19ncmVfeG1pdCBuZXQvaXB2NC9pcF9ncmUuYzo0NjkgW2lubGluZV0NCj4+ID4+
IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBpcGdyZV94bWl0KzB4ZGY0LzB4ZTcwIG5ldC9p
cHY0L2lwX2dyZS5jOjY2Mg0KPj4gPj4gIF9fZ3JlX3htaXQgbmV0L2lwdjQvaXBfZ3JlLmM6NDY5
IFtpbmxpbmVdDQo+PiA+Pg0KPj4gPg0KPj4gPg0KPj4gPg0KPj4gPj4gVGhlIHNpbXBsaWZpZWQg
dmVyc2lvbiBvZiB0aGUgcmVwcm8gaXMgc2hvd24gYmVsb3c6DQo+PiA+Pg0KPj4gPj4gI2luY2x1
ZGUgPGxpbnV4L2lmX2V0aGVyLmg+DQo+PiA+PiAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+PiA+
PiAjaW5jbHVkZSA8bmV0aW5ldC9ldGhlci5oPg0KPj4gPj4gI2luY2x1ZGUgPG5ldC9pZi5oPg0K
Pj4gPj4gI2luY2x1ZGUgPHN5cy9zb2NrZXQuaD4NCj4+ID4+ICNpbmNsdWRlIDxuZXRpbmV0L2lu
Lmg+DQo+PiA+PiAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+PiA+PiAjaW5jbHVkZSA8dW5pc3RkLmg+
DQo+PiA+PiAjaW5jbHVkZSA8c3RkaW8uaD4NCj4+ID4+ICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4+
ID4+ICNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4NCj4+ID4+DQo+PiA+PiBpbnQgbWFpbih2
b2lkKQ0KPj4gPj4gew0KPj4gPj4gICAgICAgICBpbnQgcywgczEsIHMyLCBkYXRhID0gMDsNCj4+
ID4+ICAgICAgICAgc3RydWN0IGlmcmVxIGlmcjsNCj4+ID4+ICAgICAgICAgc3RydWN0IHNvY2th
ZGRyX2xsIGFkZHIgPSB7IDAgfTsNCj4+ID4+ICAgICAgICAgdW5zaWduZWQgY2hhciBtYWNfYWRk
cltdID0gezB4MSwgMHgyLCAweDMsIDB4NCwgMHg1LCAweDZ9Ow0KPj4gPj4NCj4+ID4+ICAgICAg
ICAgcyA9IHNvY2tldChBRl9QQUNLRVQsIFNPQ0tfREdSQU0sIDB4MzAwKTsNCj4+ID4+ICAgICAg
ICAgczEgPSBzb2NrZXQoQUZfUEFDS0VULCBTT0NLX1JBVywgMHgzMDApOw0KPj4gPj4gICAgICAg
ICBzMiA9IHNvY2tldChBRl9ORVRMSU5LLCBTT0NLX1JBVywgMCk7DQo+PiA+Pg0KPj4gPj4gICAg
ICAgICBzdHJjcHkoaWZyLmlmcl9uYW1lLCAiZ3JlMCIpOw0KPj4gPj4gICAgICAgICBpb2N0bChz
MiwgU0lPQ0dJRklOREVYLCAmaWZyKTsNCj4+ID4+DQo+PiA+PiAgICAgICAgIGFkZHIuc2xsX2Zh
bWlseSA9IEFGX1BBQ0tFVDsNCj4+ID4+ICAgICAgICAgYWRkci5zbGxfaWZpbmRleCA9IGlmci5p
ZnJfaWZpbmRleDsNCj4+ID4+ICAgICAgICAgYWRkci5zbGxfcHJvdG9jb2wgPSBodG9ucygwKTsN
Cj4+ID4+ICAgICAgICAgYWRkci5zbGxfaGF0eXBlID0gQVJQSFJEX0VUSEVSOw0KPj4gPj4gICAg
ICAgICBhZGRyLnNsbF9wa3R0eXBlID0gUEFDS0VUX0hPU1Q7DQo+PiA+PiAgICAgICAgIGFkZHIu
c2xsX2hhbGVuID0gRVRIX0FMRU47DQo+PiA+PiAgICAgICAgIG1lbWNweShhZGRyLnNsbF9hZGRy
LCBtYWNfYWRkciwgRVRIX0FMRU4pOw0KPj4gPj4NCj4+ID4+ICAgICAgICAgc2VuZHRvKHMxLCAm
ZGF0YSwgMSwgMCwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBzaXplb2YoYWRkcikpOw0KPj4g
Pj4NCj4+ID4+ICAgICAgICAgcmV0dXJuIDA7DQo+PiA+PiB9DQo+PiA+Pg0KPj4gPj4gVGhlIHJl
cHJvIHNlbmRzIGEgMS1ieXRlIHBhY2tldCB0aGF0IGRvZXNuJ3QgaGF2ZSB0aGUgY29ycmVjdCBJ
UA0KPj4gPj4gaGVhZGVyLiBJIG1lYW50IHRoaXMgYXMgIm1hbGZvcm1lZCBwYWNoZXQiLCBidXQg
dGhhdCBtaWdodCBiZSBhIGJpdA0KPj4gPj4gY29uZnVzaW5nLCBzb3JyeS4NCj4+ID4+DQo+PiA+
PiBJIHRoaW5rIHRoZSBjYXVzZSBvZiB0aGUgdW5pbml0LXZhbHVlIGFjY2VzcyBpcyB0aGF0IGlw
Z3JlX3htaXQoKQ0KPj4gPj4gcmVhbGxvY2F0ZXMgdGhlIHNrYiB3aXRoIHNrYl9jb3dfaGVhZCgp
IGFuZCBjb3BpZXMgb25seSB0aGUgMS1ieXRlDQo+PiA+PiBkYXRhLCBzbyBhbnkgSVAgaGVhZGVy
IGFjY2VzcyB0aHJvdWdoIGB0bmxfcGFyYW1zYCBjYW4gY2F1c2UgdGhlDQo+PiA+PiBwcm9ibGVt
Lg0KPj4gPj4NCj4+ID4+IEF0IGZpcnN0IEkgdHJpZWQgdG8gbW9kaWZ5IHBza2JfaW5ldF9tYXlf
cHVsbCgpIHRvIGRldGVjdCB0aGlzIHR5cGUgb2YNCj4+ID4+IHBhY2tldCwgYnV0IEkgZW5kZWQg
dXAgZG9pbmcgdGhpcyBwYXRjaC4NCj4+ID4NCj4+ID4gRXZlbiBhZnRlciB5b3VyIHBhdGNoLCBf
X3NrYl9wdWxsKCkgY291bGQgY2FsbCBCVUcoKSBhbmQgY3Jhc2guDQo+PiA+DQo+PiA+IEkgd291
bGQgc3VnZ2VzdCB1c2luZyB0aGlzIGZpeCBpbnN0ZWFkLg0KPj4NCj4+IFRoYW5rIHlvdSBmb3Ig
eW91ciBjb21tZW50Lg0KPj4NCj4+IFlvdXIgcGF0Y2ggZW5zdXJlcyB0aGF0IHNrYl9wdWxsKCkg
Y2FuIHB1bGwgdGhlIHJlcXVpcmVkIHNpemUsIHNvIGl0DQo+PiBsb29rcyBnb29kIHRvIG1lLiBB
bHNvLCBJIGhhdmUgdGVzdGVkIHlvdXIgc3VnZ2VzdGVkIHBhdGNoIHdpdGggdGhlDQo+PiByZXBy
byBhbmQgY29uZmlybWVkIHRoYXQgaXQgZml4ZXMgdGhlIGlzc3VlLg0KPj4NCj4gDQo+IFRoaXMg
aXMgZ3JlYXQsIHBsZWFzZSBjb29rL3NlbmQgYSBWMiB3aXRoIHRoaXMgdXBkYXRlZCBwYXRjaC4N
Cj4gDQo+IEkgd2lsbCBhZGQgYSAnUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRA
Z29vZ2xlLmNvbT4nIHRoZW4uDQoNClRoYW5rcywgRXJpYyEgSSdsbCBzZW5kIGEgdjIgcGF0Y2gg
c29vbi4NCg0KU2hpZ2VydQ0KDQo+IA0KPiBUaGFua3MuDQo+IA0K


