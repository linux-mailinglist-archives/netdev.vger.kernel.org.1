Return-Path: <netdev+bounces-38885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AF87BCD6A
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 11:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D609F281A4C
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB958BE2;
	Sun,  8 Oct 2023 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWuvsU9R"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1EB20E1;
	Sun,  8 Oct 2023 09:03:00 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA64BA;
	Sun,  8 Oct 2023 02:02:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-693400e09afso970926b3a.1;
        Sun, 08 Oct 2023 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696755779; x=1697360579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sXnj1ztEEdQ/JZ/W7SHO7h+PsjiP4cYEHeArS/Gzz0=;
        b=nWuvsU9RYaTft1+/hjE5UiWl09EQO7HpLpCYXSkwTCQakizLU/Myx1mb5F0vIUWzb+
         mutlmNeRHchRPCPhWuDp0rlyrOIrDqzzeuL8KHUrWxgdr5ihhqwNhYxXeGPC5I8HHuGL
         R5HP3so9ROv0EhExoSQvBOBvEYU6MgmUP/dSzX8M7iAgHch9jOKONAHwGuAwnQqIYwWY
         JlZiq19gLGSBa2vzRzp6gB91m82subnqNFKAmc3UVJ5/Ro+1WlkgKaR1+BiYQIuWWzD/
         0DmHdpJeJmvi6kLJwtBKmWHoyuLBm7ZPZZoHnO7Y5wQTt5jAxlsS7VPz9CLpByeAUdVe
         x6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696755779; x=1697360579;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/sXnj1ztEEdQ/JZ/W7SHO7h+PsjiP4cYEHeArS/Gzz0=;
        b=IEqZAT1cleD6wFBezw6yATGEPe0IWXqZeXwKJTvsFdjkTN3W7zV1G38Y1iDYRouAOU
         5JxC/1LWCcxlJLcQAb+zSMiCDmhbKlSs82l6y9Q2AKijeTeZ4uC4/z7UNc/2hmtc1NpL
         SKouwxtk0yN4RkOzA6ZeLWCKAvkxB20CNnPtClyEEEl4im7h9X1VW/z1ysQQomK+/Tcc
         TCS1TmlcXANNJRd0EZNJdwstv3TlG1H90Qr3jjkGwxAggrhxYD9l+0y3rYK/8fYe/iMb
         57eN7GPCtJfsfQk9FH5MSCGplnTmUqAjgkG7i5dVneG5XzjG8cQlUtzc81QOcGmCdk7P
         3aDw==
X-Gm-Message-State: AOJu0YwXaCViKdY2BsQfqZWiHHUcI2uWbu0Rp7PYUe4o3X0xV3193EME
	YlSiRtxiqgdqzBbgP6zswoQ=
X-Google-Smtp-Source: AGHT+IG0EFQEt43AMzkbooNF05PLsbFwCuce59+GhZYEWNWJQ8sQiiDEwI/VU7UXHXglkDJ+Q1MaKg==
X-Received: by 2002:a17:902:ea07:b0:1c3:a4f2:7cc1 with SMTP id s7-20020a170902ea0700b001c3a4f27cc1mr14544918plg.5.1696755778691;
        Sun, 08 Oct 2023 02:02:58 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s2-20020a170902ea0200b001bbd1562e75sm7124157plg.55.2023.10.08.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 02:02:58 -0700 (PDT)
Date: Sun, 08 Oct 2023 18:02:57 +0900 (JST)
Message-Id: <20231008.180257.1638765262944543712.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47sh+vAXrZRQR8aK2B_mVoUfiHMzFEF=vxbb-+TbgwGpQw@mail.gmail.com>
References: <CALNs47v3cE-_LiJBTg0_Zkh_cinktHHP3xJ3tL3PAHn5+NBNCA@mail.gmail.com>
	<20231008.164906.1151622782836568538.fujita.tomonori@gmail.com>
	<CALNs47sh+vAXrZRQR8aK2B_mVoUfiHMzFEF=vxbb-+TbgwGpQw@mail.gmail.com>
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

T24gU3VuLCA4IE9jdCAyMDIzIDA0OjU0OjUyIC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBTdW4sIE9jdCA4LCAyMDIzIGF0IDM6NDnigK9BTSBG
VUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPj4g
SSByZWFsaXplZCB0aGF0IHdlIGRvbid0IG5lZWQgYG5hbWVgLiBUaGUgbmFtZSBvZiBzdHJ1Y3Qg
ZG9lc24ndA0KPj4gbWF0dGVyIHNvIEkgdXNlIGBNb2R1bGVgLiBJIHRyaWVkIHRvIHVzZSBgbmFt
ZWAgZm9yIHRoZSBuYW1lIG9mDQo+PiBkZXZpY2VfdGFibGUgaG93ZXZlciB0aGUgdmFyaWFibGUg
bmFtZSBvZiB0aGUgdGFibGUgaXNuJ3QgZW1iZWRlZCBpbnRvDQo+PiB0aGUgbW9kdWxlIGJpbmFy
eSBzbyBpdCBkb2Vzbid0IG1hdHRlci4NCj4+DQo+PiBGWUksIEkgdXNlIHBhc3RlISBidXQgZ290
IHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+Pg0KPj4gPSBoZWxwOiBtZXNzYWdlOiBgIl9fbW9kX21k
aW9fX1wicnVzdF9hc2l4X3BoeVwiX2RldmljZV90YWJsZSJgIGlzIG5vdCBhIHZhbGlkIGlkZW50
aWZpZXINCj4+ID0gbm90ZTogdGhpcyBlcnJvciBvcmlnaW5hdGVzIGluIHRoZSBtYWNybyBgJGNy
YXRlOjptb2R1bGVfcGh5X2RyaXZlcmAgd2hpY2ggY29tZXMgZnJvbSB0aGUgZXhwYW5zaW9uIG9m
IHRoZQ0KPj4gICBtYWNybyBga2VybmVsOjptb2R1bGVfcGh5X2RyaXZlcmAgKGluIE5pZ2h0bHkg
YnVpbGRzLCBydW4gd2l0aCAtWiBtYWNyby1iYWNrdHJhY2UgZm9yIG1vcmUgaW5mbykNCj4gDQo+
IFRvbyBiYWQsIHRoaXMgc2VlbXMgdG8gYmUgYSBsaW1pdGF0aW9uIG9mIG91ciBwYXN0ZSBtYWNy
byBjb21wYXJlZCB0bw0KPiB0aGUgcHVibGlzaGVkIG9uZS4gV2hhdCB5b3UgaGF2ZSB3aXRoIGBN
b2R1bGVgIHNlZW1zIGZpbmUgc28gSSB0aGluaw0KPiB5b3UgZG9uJ3QgbmVlZCBpdD8NCg0KWWVh
aCwgbm93IEkgZG9uJ3QgdXNlIHBhc3RlISBpbiBQSFkgYmluZGluZ3MuDQo=

