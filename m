Return-Path: <netdev+bounces-40264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DFB7C6749
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C885A2825BC
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F56C12E5C;
	Thu, 12 Oct 2023 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKbT3Wi+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662DFFC16;
	Thu, 12 Oct 2023 07:58:16 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468FCA9;
	Thu, 12 Oct 2023 00:58:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-69361132a60so142755b3a.1;
        Thu, 12 Oct 2023 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697097492; x=1697702292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75m1NY8R56xspS8q5Li9JybfkjSR/ekIxTCcniMnDmc=;
        b=NKbT3Wi+mIEfVTb3JbMKUYf2Uh80ImFLbWZFOSsT5y2MJ+ZHhOrGNTXsJWtRi2ArcE
         3nphHTDHgZJP20R122cMFxHjsNsVDvxyF5cMQu5xbaf0P1Q3ck/df16rdfAZX5oUVwyN
         TZ9LwQ+qDDaiXmW8WdX9ErTWRCY07ySYRfvrB1sxiXyc+EnLoArIq08v0JzIN3A88KPI
         GMZJ7StfnXEFlWao/Dmnj7AqZt9PG/Ts1J3HcOXbHXTykD/LBIZ4orYLy93DQCof0k26
         0RdwCXvtnb952rkbfrKM52W8rEnZwAjIhGaxe+WmItLW8HdsvKF9A5Y2MLNT9hM+VOvM
         L72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097492; x=1697702292;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=75m1NY8R56xspS8q5Li9JybfkjSR/ekIxTCcniMnDmc=;
        b=WM04lmPZiVtXk01DlwW5qEVhOQEmRmJU/Pqy1VYvdHKYQtjt6pQjJbuXebYeRp/GAN
         NYFhUL78sifyiefdxdGWDuIMjfTaDc2IYrEPwc4QOqmcNkTLoVqqI29Hg3tUFx5bibsP
         2bu/uh/V3t8Ktvr9R1PzYZ06VAjifdtnhxR6zDreYdGmrUI+gIQrU9qVNQnBAsWJ7288
         rz4hIjjctmZfcC8EG0yP/s43WVU6RYQ05G2lKlNrDrXLexW9c/x0vBcPkJqv1ItNJyzL
         BurPhmGIR9IlJP0LbGpAZKqS/fW+cbkoC7t5YieINr1OOJ2iY/AnYIX+Di74YXVxD5XX
         TFDA==
X-Gm-Message-State: AOJu0YwcrmoAY9C2m5gn/gIO/lfb/7qAH4DFMrFtODqTmJOQxmIbb6AN
	7iq+SSVraPy2ZonPuWrIVPU=
X-Google-Smtp-Source: AGHT+IF2HCL1d45kVUP7IMWJmhprElPobYIpWXUgYrnoNDvY5+GXUf41LuPNLx+XJoTQz5AVbfVl4g==
X-Received: by 2002:a05:6a20:1595:b0:163:ab09:195d with SMTP id h21-20020a056a20159500b00163ab09195dmr27010506pzj.0.1697097491499;
        Thu, 12 Oct 2023 00:58:11 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id g23-20020a1709029f9700b001c74876f018sm1264349plq.18.2023.10.12.00.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:58:11 -0700 (PDT)
Date: Thu, 12 Oct 2023 16:58:10 +0900 (JST)
Message-Id: <20231012.165810.303016284319181876.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: boqun.feng@gmail.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47tKwVE_GF-kec_mAi2NZLe53t2Jcsec=vsoJXT01AYLQQ@mail.gmail.com>
References: <20231012.160246.2019423056896039320.fujita.tomonori@gmail.com>
	<ZSeckzvOTyre3SVM@boqun-archlinux>
	<CALNs47tKwVE_GF-kec_mAi2NZLe53t2Jcsec=vsoJXT01AYLQQ@mail.gmail.com>
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

T24gVGh1LCAxMiBPY3QgMjAyMyAwMzozMjo0NCAtMDQwMA0KVHJldm9yIEdyb3NzIDx0bWdyb3Nz
QHVtaWNoLmVkdT4gd3JvdGU6DQoNCj4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMzoxM+KAr0FN
IEJvcXVuIEZlbmcgPGJvcXVuLmZlbmdAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+PiBJZiBgRGV2
aWNlOjpmcm9tX3Jhd2AncyBzYWZldHkgcmVxdWlyZW1lbnQgaXMgIm9ubHkgY2FsbGVkIGluIGNh
bGxiYWNrcw0KPj4gd2l0aCBwaHlkZXZpY2UtPmxvY2sgaGVsZCwgZXRjLiIsIHRoZW4gdGhlIGV4
Y2x1c2l2ZSBhY2Nlc3MgaXMNCj4+IGd1YXJhbnRlZWQgYnkgdGhlIHNhZmV0eSByZXF1aXJlbWVu
dCwgdGhlcmVmb3JlIGBtdXRgIGNhbiBiZSBkcm9wLiBJdCdzDQo+PiBhIG1hdHRlciBvZiB0aGUg
ZXhhY3Qgc2VtYW50aWNzIG9mIHRoZSBBUElzLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBCb3F1bg0K
PiANCj4gVGhhdCBpcyBjb3JyZWN0IHRvIG15IHVuZGVyc3RhbmRpbmcsIHRoZSBjb3JlIGhhbmRs
ZXMNCj4gbG9ja2luZy91bmxvY2tpbmcgYW5kIG5vIGRyaXZlciBmdW5jdGlvbnMgYXJlIGNhbGxl
ZCBpZiB0aGUgY29yZQ0KPiBkb2Vzbid0IGhvbGQgYW4gZXhjbHVzaXZlIGxvY2sgZmlyc3QuIFdo
aWNoIGFsc28gbWVhbnMgdGhlIHdyYXBwZXINCj4gdHlwZSBjYW4ndCBiZSBgU3luY2AuDQo+IA0K
PiBBbmRyZXcgc2FpZCBhIGJpdCBhYm91dCBpdCBpbiB0aGUgc2Vjb25kIGNvbW1lbnQgaGVyZToN
Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcnVzdC1mb3ItbGludXgvZWM2ZDg0NzktZjg5My00
YTNmLWJmM2UtYWEwYzgxYzRhZGFkQGx1bm4uY2gvDQoNCnJlc3VtZS9zdXNwZW5kIGFyZSBjYWxs
ZWQgd2l0aG91dCB0aGUgbXV0ZXggaG9sZCBidXQgd2UgZG9uJ3QgbmVlZCB0aGUNCmRldGFpbHMu
IFBIWUxJQiBndWFyYW50ZWVzIHRoZSBleGNsdXNpdmUgYWNjZXNzIGluc2lkZSB0aGUNCmNhbGxi
YWNrcy4gSSB1cGRhdGVkIHRoZSBjb21tZW50IGFuZCBkcm9wIG11dCBpbiBEZXZpY2UncyBtZXRo
b2RzLg0KDQogICAvLy8gQ3JlYXRlcyBhIG5ldyBbYERldmljZWBdIGluc3RhbmNlIGZyb20gYSBy
YXcgcG9pbnRlci4NCiAgIC8vLw0KICAgLy8vICMgU2FmZXR5DQogICAvLy8NCiAgIC8vLyBUaGlz
IGZ1bmN0aW9uIGNhbiBiZSBjYWxsZWQgb25seSBpbiB0aGUgY2FsbGJhY2tzIGluIGBwaHlfZHJp
dmVyYC4gUEhZTElCIGd1YXJhbnRlZXMNCiAgIC8vLyB0aGUgZXhjbHVzaXZlIGFjY2VzcyBmb3Ig
dGhlIGR1cmF0aW9uIG9mIHRoZSBsaWZldGltZSBgJ2FgLg0KICAgdW5zYWZlIGZuIGZyb21fcmF3
PCdhPihwdHI6ICptdXQgYmluZGluZ3M6OnBoeV9kZXZpY2UpIC0+ICYnYSBtdXQgU2VsZiB7DQoN
Cg==

