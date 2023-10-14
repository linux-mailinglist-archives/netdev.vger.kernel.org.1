Return-Path: <netdev+bounces-41052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439157C973D
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 01:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD41C209B1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 23:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2726E0F;
	Sat, 14 Oct 2023 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT4GiDb4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383B185A;
	Sat, 14 Oct 2023 23:18:52 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BBEA9;
	Sat, 14 Oct 2023 16:18:51 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27d5fd02e3dso170378a91.1;
        Sat, 14 Oct 2023 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697325531; x=1697930331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xyeTySPk0pqZaSpZ4hZukn7toOVHaM03Ut/LEiAi7Sc=;
        b=ZT4GiDb4WwOJC8CMT5BGipxOLVQUg71TX1g8qIdFJfRMj0shEjFenH9kND6dYOJtWS
         WKwLvvKn7l4GYpXw9QAUiBt6LFSl7fbvQBA7GUtYVrfvluZUM7QQmRa2NJScsOafHDRd
         fBfrtgV2unh9zCJy/O49/p1IkniSO+Zeck/C1exb7c+SKDRbL6Ot5p6IzQBhl2ihTyVa
         JqM0Dyao+3A0/tYfMkySYjozuLZb9TT7wx17Cq26aPHdWwxE03dZ9d8dy3TT5eDWb9UH
         D0s5SI5eo78qB/gehiUUbqesuNoHanFf29+TR4jrFga1D0bt/nL1oAcpYERivCh3TXC0
         naZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697325531; x=1697930331;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xyeTySPk0pqZaSpZ4hZukn7toOVHaM03Ut/LEiAi7Sc=;
        b=eGPzxIooU5ZdE1K+Z+XRY1fFvz+5gnmJtf25J1H4SJPYqlt0L5xhULYjSHleMfVmE+
         xCGGBe69+RTtI5EonV8lYB4A1dNeUQlPFh4mGih1AEPGzHyI4N5lvBcPkivUU277G1qY
         3FbGagui1OjpsZGFyQKKydEzG6/BbeSWDH8O12zXkLD3AxMH72OBx/5w1VtoijpbsmbG
         sFuAtMAjmMzPv3lM5H3AthGGz1EYZOzymCP/quALig/qlUFOJnR19A2tcwhZEvzN49ok
         oHtSqz7tJWYPGmaepZOncsRoTNGWBZPDswytyJwQoZ0dVyFqjL1Yf2ibR6uUf362A2cU
         GuXg==
X-Gm-Message-State: AOJu0YxjL3ANa8Ars1PjqLbjOhFKHwL1XPJQxT03CptL0HMS8GYgDx+R
	PR7RCMSa5H3dqFtDS3X7rqQ=
X-Google-Smtp-Source: AGHT+IFVKXx89vfE2eloqHxfmpRMaUSpBe/2YRAZzIT4cAAi0nQAaFsVV7Y5iJKRRjRuBphf8cXj1g==
X-Received: by 2002:a17:902:d352:b0:1c9:e121:ccc1 with SMTP id l18-20020a170902d35200b001c9e121ccc1mr8973820plk.5.1697325530969;
        Sat, 14 Oct 2023 16:18:50 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id ju10-20020a170903428a00b001bdb0483e65sm6001153plb.265.2023.10.14.16.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 16:18:50 -0700 (PDT)
Date: Sun, 15 Oct 2023 08:18:49 +0900 (JST)
Message-Id: <20231015.081849.2094682155986954086.fujita.tomonori@gmail.com>
To: andrew@lunn.ch, miguel.ojeda.sandonis@gmail.com
Cc: benno.lossin@proton.me, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72m3xp6ErPwCOj6DrHpG_7OE9WUqVpsZcUDk4OSuH62mKg@mail.gmail.com>
References: <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
	<4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
	<CANiq72m3xp6ErPwCOj6DrHpG_7OE9WUqVpsZcUDk4OSuH62mKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gU2F0LCAxNCBPY3QgMjAyMyAxOTowMDo0NiArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBTYXQsIE9jdCAxNCwgMjAy
MyBhdCA0OjEz4oCvQU0gQW5kcmV3IEx1bm4gPGFuZHJld0BsdW5uLmNoPiB3cm90ZToNCj4+DQo+
PiBUbyBzb21lIGV4dGVudCwgdGhpcyBpcyBqdXN0IGEgdGVtcG9yYXJ5IGxvY2F0aW9uLiBPbmNl
IHRoZQ0KPj4gcmVzdHJpY3Rpb25zIG9mIHRoZSBidWlsZCBzeXN0ZW1zIGFyZSBzb2x2ZWQsIGkg
ZXhwZWN0IHRoaXMgd2lsbCBtb3ZlDQo+PiBpbnRvIGRyaXZlcnMvbmV0L3BoeS9LY29uZmlnLCBp
bnNpZGUgdGhlICdpZiBQSFlMSUInLiBIb3dldmVyLCBpDQo+PiBhZ3JlZSwgdGhpcyBzaG91bGQg
YmUgdW5kZXIgdGhlIFJ1c3QgbWVudS4NCj4gDQo+IE5vLCBpdCBpcyBvcnRob2dvbmFsIHRvIHRo
ZSBidWlsZCBzeXN0ZW0gcmVzdHJpY3Rpb25zLg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIHRoZSBL
Y29uZmlnIGVudHJ5IGNvdWxkIGJlIG1vdmVkIHRoZXJlIGFscmVhZHkuIEluDQo+IGZhY3QsIEkg
d291bGQgc3VnZ2VzdCBzby4NCg0KQW5kcmV3LCBpZiB5b3UgcHJlZmVyLCBJJ2xsIG1vdmUgUlVT
VF9QSFlMSUJfQUJTVFJBQ1RJT05TIHRvDQpkcml2ZXJzL25ldC9waHkvS2NvbmZpZy4NCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3BoeS9LY29uZmlnIGIvZHJpdmVycy9uZXQvcGh5L0tjb25m
aWcNCmluZGV4IGU1NWI3MTkzN2YwMS4uMGQzOWI5N2E1NDZjIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQvcGh5L0tjb25maWcNCisrKyBiL2RyaXZlcnMvbmV0L3BoeS9LY29uZmlnDQpAQCAtNjYs
NiArNjYsMTQgQEAgY29uZmlnIFNGUA0KIAlkZXBlbmRzIG9uIEhXTU9OIHx8IEhXTU9OPW4NCiAJ
c2VsZWN0IE1ESU9fSTJDDQogDQorY29uZmlnIFJVU1RfUEhZTElCX0FCU1RSQUNUSU9OUw0KKyAg
ICAgICAgYm9vbCAiUEhZTElCIGFic3RyYWN0aW9ucyBzdXBwb3J0Ig0KKyAgICAgICAgZGVwZW5k
cyBvbiBSVVNUDQorICAgICAgICBkZXBlbmRzIG9uIFBIWUxJQj15DQorICAgICAgICBoZWxwDQor
ICAgICAgICAgIEFkZHMgc3VwcG9ydCBuZWVkZWQgZm9yIFBIWSBkcml2ZXJzIHdyaXR0ZW4gaW4g
UnVzdC4gSXQgcHJvdmlkZXMNCisgICAgICAgICAgYSB3cmFwcGVyIGFyb3VuZCB0aGUgQyBwaHls
aWIgY29yZS4NCisNCiBjb21tZW50ICJNSUkgUEhZIGRldmljZSBkcml2ZXJzIg0KIA0KIGNvbmZp
ZyBBTURfUEhZDQo=

