Return-Path: <netdev+bounces-44469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596727D8216
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 13:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9ECDB21361
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 11:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ED32D79B;
	Thu, 26 Oct 2023 11:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg8lM5d+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9992D799;
	Thu, 26 Oct 2023 11:54:37 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50191AE;
	Thu, 26 Oct 2023 04:54:35 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-51f64817809so99636a12.1;
        Thu, 26 Oct 2023 04:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698321275; x=1698926075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Q4sKw20IDYCQXVbEgRDRjEjEctNoIjeFaPqJNC/rc=;
        b=gg8lM5d+v+Xudbnf8Wlj5+yZos22AMGP5ruaxqdfbmji4NiWItW6cvOod0+zXN+0k4
         Wn4Ez3dPv3Y8cxj+DZxG4rFVG6YvwoUND2FSmbNKpPG8KLv4xHJyjOfrECmdMARWPI8+
         hUmJhP+FaBLI/focenNeoTDch5u2cFQfemMQChtmAutFubr4er1pnvy9roLF+/hmPAkG
         Bt8MhpCDxt4c3Lnh/h78EUPseYmjhOC+wN3DFSoxDUBdyKNzbHAitT5bmIRnzrYllxfQ
         lKYi+YUNdzAXDuv0/FBDT7c22d8h0Kyxc6KTZ9RzR9YBrxkhvacRz8gCtxXOpwo68QA/
         CnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698321275; x=1698926075;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5Q4sKw20IDYCQXVbEgRDRjEjEctNoIjeFaPqJNC/rc=;
        b=JyzWRBVI5yVKjerqB6GSAWsP4TgzUyjI9ZSe0uatIQn8gNLt0BY4sc/bNoZFaSijiX
         1Yb6nyJePqMsD0xhWnwU+daERUn7Tocmr/KuTMAzEJ6OTQ5ngCNguPY5B6pSp+mk2Twc
         chZzK2hjHJXKNm9TpeVtGHCEyCLYkVpR7ItqUNRVjk/h4ODdQ1OEqw4H1R9cRdEYNII5
         6EOQme19FZCBtWxAooV5iIBlVZywwkI9Kel212JOB/pHKg3EW8S8Mz7NxT0yOs8xg+BR
         fUR9sAp8/t8WklsAwM1GwOkYTHJ2anUBTTxah4OWW954CYhrL6VIKciSSpFk9PXAtzea
         bQLA==
X-Gm-Message-State: AOJu0YxnjRL/NioY/BSProqT8hzOj3TJXsj7OttaNMfjBXOQM9jh7p2k
	wkCllEvcne1q04tX97EZCko=
X-Google-Smtp-Source: AGHT+IHkE6Z2sn4JakvHISr7KVCogjXHvU+PXjauonII13+9RFcxWzaevHmt2KXLxZnYf1nhP9EqMQ==
X-Received: by 2002:a05:6a20:4420:b0:163:f945:42c4 with SMTP id ce32-20020a056a20442000b00163f94542c4mr24703115pzb.1.1698321275323;
        Thu, 26 Oct 2023 04:54:35 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id h7-20020a655187000000b0056b6d1ac949sm8780610pgq.13.2023.10.26.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 04:54:35 -0700 (PDT)
Date: Thu, 26 Oct 2023 20:54:34 +0900 (JST)
Message-Id: <20231026.205434.963307210202715112.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu,
 benno.lossin@proton.me, wedsonaf@gmail.com, ojeda@kernel.org
Subject: Re: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for
 enum exhaustiveness checking
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
	<20231026001050.1720612-4-fujita.tomonori@gmail.com>
	<CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gVGh1LCAyNiBPY3QgMjAyMyAxMzowMjo1NyArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIE9jdCAyNiwgMjAy
MyBhdCAyOjE24oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBGcm9tOiBNaWd1ZWwgT2plZGEgPG9qZWRhQGtlcm5lbC5vcmc+
DQo+Pg0KPj4gVGhpcyBwYXRjaCBtYWtlcyBzdXJlIHRoYXQgdGhlIEMncyBlbnVtIGlzIHN5bmMg
d2l0aCBSdXN0IHNpZGVzLiBJZg0KPj4gdGhlIGVudW0gaXMgb3V0IG9mIHN5bmMsIGNvbXBpbGlu
ZyBmYWlscyB3aXRoIGFuIGVycm9yIGxpa2UgdGhlDQo+PiBmb2xsb3dpbmcuDQo+Pg0KPj4gTm90
ZSB0aGF0IHRoaXMgaXMgYSB0ZW1wb3Jhcnkgc29sdXRpb24uIEl0IHdpbGwgYmUgcmVwbGFjZWQg
d2l0aA0KPj4gYmluZGdlbiB3aGVuIGl0IHN1cHBvcnRzIGdlbmVyYXRpbmcgdGhlIGVudW0gY29u
dmVyc2lvbiBjb2RlLg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IE1pZ3VlbCBPamVkYSA8b2plZGFA
a2VybmVsLm9yZz4NCj4+IFNpZ25lZC1vZmYtYnk6IEZVSklUQSBUb21vbm9yaSA8ZnVqaXRhLnRv
bW9ub3JpQGdtYWlsLmNvbT4NCj4gDQo+IFBsZWFzZSBkbyBub3QgbW9kaWZ5IHBhdGNoZXMgZnJv
bSBvdGhlcnMgd2l0aG91dCB3YXJuaW5nIHRoYXQgeW91IGRpZA0KPiBzby4gSSBkaWQgbm90IHdy
aXRlIHRoaXMgY29tbWl0IG1lc3NhZ2Ugbm9yIGFncmVlZCB0byB0aGlzLCBidXQgaXQNCj4gbG9v
a3MgYXMgaWYgSSBkaWQuIEkgZXZlbiBleHBsaWNpdGx5IHNhaWQgSSB3b3VsZCBzZW5kIHRoZSBw
YXRjaA0KPiBpbmRlcGVuZGVudGx5Lg0KPg0KPiBBcyBJIHJlY2VudGx5IHRvbGQgeW91LCBpZiB5
b3Ugd2FudCB0byBwaWNrIGl0IHVwIGluIHlvdXIgc2VyaWVzIHRvDQo+IHNob3djYXNlIGhvdyBp
dCB3b3VsZCB3b3JrLCB5b3Ugc2hvdWxkIGhhdmUgYXQgbGVhc3Qga2VwdCB0aGUgV0lQLCBwdXQN
Cj4gaXQgYXQgdGhlIGVuZCBvZiB0aGUgc2VyaWVzIGFuZCBhZGRlZCBSRkMgc2luY2UgaXQgaXMg
bm90IGludGVuZGVkIHRvDQo+IGJlIG1lcmdlZCB3aXRoIHlvdXIgb3RoZXIgcGF0Y2hlcy4NCg0K
U29ycnksIEkgdG90YWxseSBtaXN1bmRlcnN0YW5kIHlvdXIgaW50ZW50aW9uLiBJIHRob3VnaHQg
dGhhdCB0aGUgUEhZDQphYnN0cmFjdGlvbnMgbmVlZHMgdG8gYmUgbWVyZ2VkIHdpdGggeW91ciBw
YXRjaCB0b2dldGhlci4NCg0KSSdsbCBkcm9wIHlvdXIgcGF0Y2ggaW4gdGhlIG5leHQgdmVyc2lv
biBhbmQgZm9jdXMgb24gbXkgcGF0Y2hlcy4NCg==

