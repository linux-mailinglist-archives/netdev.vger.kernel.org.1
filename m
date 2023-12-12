Return-Path: <netdev+bounces-56350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B91280E936
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC025281578
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CFE51C37;
	Tue, 12 Dec 2023 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqMv8FKw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A79F;
	Tue, 12 Dec 2023 02:36:34 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-286f3e0d010so1610978a91.0;
        Tue, 12 Dec 2023 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702377393; x=1702982193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvcdwgxZ2kCJNVDoUSBD6tBiTD2/scMMhEPOsBUMcZw=;
        b=JqMv8FKwbT+Pli1AXgTQlJTednpOjdIHPKKJJFaZJeF9ESRMAVSyGCX4SQUn7kF4nG
         hJI9ZkiZkoDMf2PFzhTS2fEHAwgkOeMnallVDVTGk/E4meC7Niv2hHWaDxSFFCdzccuW
         rWvWgGaNvKExJOKQc//ztKW04KscPowv8aBg88PaUSENVZN0SrfwyOIUGwB/EO3zf7PQ
         jJrK4JbFVwMB8DLkHt5oBzSuY4UCXLZX7d9gmv4nMH0jg92wNNvwY3nzxp6r6GiOCkwr
         7tQrL6OBbq5FNbL3tOz+uVcR9GFGXI6t+irRmM59juxgy0kBE1FFoOMoKlAWGXXNPxB2
         QbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702377393; x=1702982193;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RvcdwgxZ2kCJNVDoUSBD6tBiTD2/scMMhEPOsBUMcZw=;
        b=fftsLGFcP+7tQD5FoZFXuVSYsbij9nQROl8er4ZGvdQdNOKR06vT0DD6vPMvKrJZZJ
         DX9SMBVTAh2/+Jq0lqLCX42CLaL0OLr/d6qC0CY93qqhWfDX0yllpWhX0/wlJVdXh3vc
         CeX6Sm2z+NX/ohFCkvkbFzOkJDfESD6wrhZHCwVny4gF2/gdu9cxGmKe3jpZoI9m1QuH
         7RdmemMaWPazzPX2T7Q34A+cdW8jGQrPV6rJ0QdxAnLezWxZ7WlZ5sKWIpiAcS50mAKP
         vF7n4beOYocH/m6/tFZJY8UpggVzRfh61PdYbWQbkwuupBE0xVC40ifZuHtmUgf7xkZG
         ldmQ==
X-Gm-Message-State: AOJu0Ywqn3K8iEkbbsCMnwFv8NJe4DddT0sN/flE2gQxzPZsrGtNY6rj
	YTs8dRTGtGj0jfUlbOaczQcLWqass/rpp5d0
X-Google-Smtp-Source: AGHT+IGjPCuulZv/1RfF+goXdNPkIsIeQA8U/8N7Ia18iChIodw1XB9Of/mf/Ks7XADORYjp+WznpQ==
X-Received: by 2002:a17:90a:c285:b0:286:bf9e:a6 with SMTP id f5-20020a17090ac28500b00286bf9e00a6mr10323037pjt.4.1702377393539;
        Tue, 12 Dec 2023 02:36:33 -0800 (PST)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id nu4-20020a17090b1b0400b0028865708d09sm10033439pjb.29.2023.12.12.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:36:33 -0800 (PST)
Date: Tue, 12 Dec 2023 19:36:32 +0900 (JST)
Message-Id: <20231212.193632.117477874141101308.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, alice@ryhl.io,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
 benno.lossin@proton.me, wedsonaf@gmail.com
Subject: Re: [net-next PATCH] rust: net: phy: Correct the safety comment
 for impl Sync
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiQd=9k5OaEKUjLw9WFSXW-kujNveN3cXdvqW-xNp5PSg@mail.gmail.com>
References: <ZXeZzvMszYo6ow-q@boqun-archlinux>
	<20231212.085505.1804120029445582408.fujita.tomonori@gmail.com>
	<CAH5fLgiQd=9k5OaEKUjLw9WFSXW-kujNveN3cXdvqW-xNp5PSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVHVlLCAxMiBEZWMgMjAyMyAxMDoxNzo0MCArMDEwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFR1ZSwgRGVjIDEyLCAyMDIzIGF0IDEyOjU14oCv
QU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwuY29tPiB3cm90ZToN
Cj4+DQo+PiBPbiBNb24sIDExIERlYyAyMDIzIDE1OjIyOjU0IC0wODAwDQo+PiBCb3F1biBGZW5n
IDxib3F1bi5mZW5nQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gPiBPbiBNb24sIERlYyAxMSwg
MjAyMyBhdCAxMDo1MDowMlBNICswMTAwLCBBbGljZSBSeWhsIHdyb3RlOg0KPj4gPj4gT24gMTIv
MTEvMjMgMjA6NDksIEJvcXVuIEZlbmcgd3JvdGU6DQo+PiA+PiA+IFRoZSBjdXJyZW50IHNhZmV0
eSBjb21tZW50IGZvciBpbXBsIFN5bmMgZm9yIERyaXZlclZUYWJsZSBoYXMgdHdvDQo+PiA+PiA+
IHByb2JsZW06DQo+PiA+PiA+DQo+PiA+PiA+ICogdGhlIGNvcnJlY3RuZXNzIGlzIHVuY2xlYXIs
IHNpbmNlIGFsbCB0eXBlcyBpbXBsIEFueVsxXSwgdGhlcmVmb3JlIGFsbA0KPj4gPj4gPiAgICB0
eXBlcyBoYXZlIGEgYCZzZWxmYCBtZXRob2QgKEFueTo6dHlwZV9pZCkuDQo+PiA+PiA+DQo+PiA+
PiA+ICogaXQgZG9lc24ndCBleHBsYWluIHdoeSB1c2VsZXNzIG9mIGltbXV0YWJsZSByZWZlcmVu
Y2VzIGNhbiBlbnN1cmUgdGhlDQo+PiA+PiA+ICAgIHNhZmV0eS4NCj4+ID4+ID4NCj4+ID4+ID4g
Rml4IHRoaXMgYnkgcmV3cml0dGluZyB0aGUgY29tbWVudC4NCj4+ID4+ID4NCj4+ID4+ID4gWzFd
OiBodHRwczovL2RvYy5ydXN0LWxhbmcub3JnL3N0ZC9hbnkvdHJhaXQuQW55Lmh0bWwNCj4+ID4+
ID4NCj4+ID4+ID4gU2lnbmVkLW9mZi1ieTogQm9xdW4gRmVuZyA8Ym9xdW4uZmVuZ0BnbWFpbC5j
b20+DQo+PiA+Pg0KPj4gPj4gSXQncyBmaW5lIGlmIHlvdSB3YW50IHRvIGNoYW5nZSBpdCwNCj4+
ID4NCj4+ID4gRG9lcyBpdCBtZWFuIHlvdSBhcmUgT0sgd2l0aCB0aGUgbmV3IHZlcnNpb24gaW4g
dGhpcyBwYXRjaD8gSWYgc28uLi4NCj4+ID4NCj4+ID4+IGJ1dCBJIHRoaW5rIHRoZSBjdXJyZW50
IHNhZmV0eSBjb21tZW50IGlzIGdvb2QgZW5vdWdoLg0KPj4gPg0KPj4gPiAuLi4gbGV0J3MgY2hh
bmdlIGl0IHNpbmNlIHRoZSBjdXJyZW50IHZlcnNpb24gZG9lc24ndCBsb29rIGdvb2QgZW5vdWdo
DQo+PiA+IHRvIG1lIGFzIEkgZXhwbGFpbmVkIGFib3ZlIChpdCdzIG5vdCB3cm9uZywgYnV0IGxl
c3Mgc3RyYWlnaHQtZm9yd2FyZCB0bw0KPj4gPiBtZSkuDQo+Pg0KPj4gSSdsbCBsZWF2ZSB0aGlz
IGFsb25lIGFuZCB3YWl0IGZvciBvcGluaW9ucyBmcm9tIG90aGVyIHJldmlld2VycyBzaW5jZQ0K
Pj4geW91IGd1eXMgaGF2ZSBkaWZmZXJlbnQgb3B0aW9ucy4gSXQncyBpbXByb3ZlbWVudCBzbyBJ
IGRvbid0IG5lZWQgdG8NCj4+IGh1cnJ5Lg0KPiANCj4gVG8gY2xhcmlmeSwgdGhlIG1vZGlmaWVk
IHNhZmV0eSBjb21tZW50IGlzIGFsc28gb2theSB3aXRoIG1lLg0KDQpUaGFua3MgZm9yIHRoZSBj
bGFyaWZpY2F0aW9uLiBUaGVuIEknbGwgZm9sZCB0aGlzIGluIHRoZSBwYXRjaHNldC4NCg==

