Return-Path: <netdev+bounces-38879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8157BCD0D
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E41C208B8
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1D882E;
	Sun,  8 Oct 2023 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV/jHUju"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7177A8820;
	Sun,  8 Oct 2023 07:49:10 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897DB9;
	Sun,  8 Oct 2023 00:49:08 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c72e235debso7559105ad.0;
        Sun, 08 Oct 2023 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696751348; x=1697356148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1RbYTqgrJd0w4RigU6u5ebUwwEHQIkJiZthLnH27yo=;
        b=JV/jHUjuLU7mY3PBYKECoa15Ozqo/9HPZXOuYp7tvF0xFszwjRmx71GOpHJnP4Nr/r
         r4JCsNPzAGDZuE/+D2QQ6uiNF43Zk3BinHy1eOXafJ2A1od/v/u3zeMBWxFrePR3Hlbm
         FVVaYBI8RvZCiUtQBkbxpi/hm9HKM9P3IvFjbJXM8HO/ENRzCIX/GExizw9xpd20LPIo
         7e/BNYd02D8+vkJEN/aRpxyj4G69H+6XWS9ko4ZX5cdv1NUZwycpCXIp3IvqZrp8N+Lf
         B7PY4XZoUHrPx8UC4MXEjOD9vpQu8u6bs6GzOtI3mirEDYdRTMhaBOkbdG3k9SYVy0ku
         dpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696751348; x=1697356148;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U1RbYTqgrJd0w4RigU6u5ebUwwEHQIkJiZthLnH27yo=;
        b=sTuj47RMj0HK5Dcl4AzWYsXo0aFunFTsYb3SvH5ez6NJTNWCy/bc1lS2BnZQZElSv/
         7pZ508J8sSqGObva/y2P3JiYEYwRi4vj2jZUTnolxloN9MML6i5ayQGahJYIIMW96/vR
         r5sn9WRww9E+xdBCog0fTacRnIGbXjRJJ+TSzQQDixHLzqCWRs0WO1+RPGG8mUYva+lp
         jdgi6TBA4TcG/6vHuYsHw3/3sWCslP1XxCKFUfoxcp5Jyh1+wyIh7lUdjksfcmueSo+2
         KddBcagS/5pDx2ObyofnkaihJAupN7zQwxaJ+NQAQYzt6LTjz5eiWOl9TJMZVecqOs17
         3DDA==
X-Gm-Message-State: AOJu0Yzu/Lp+/Jnn1UBQolcaxmGodHCgpVb4br2txdpLJMetLhnC/+Uf
	m63t624T4eNWIaoJ+gb08g0=
X-Google-Smtp-Source: AGHT+IGtw2YGKY9lEiBHxgPLUNg2ZOTzca9tURPT8qXpUKgwEGYHvPmymtXpH27Wu7ggyDwUhh0T2g==
X-Received: by 2002:a17:902:ec88:b0:1c0:bf60:ba4f with SMTP id x8-20020a170902ec8800b001c0bf60ba4fmr13919413plg.4.1696751348132;
        Sun, 08 Oct 2023 00:49:08 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001c60ba709b7sm6965739plk.125.2023.10.08.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 00:49:07 -0700 (PDT)
Date: Sun, 08 Oct 2023 16:49:06 +0900 (JST)
Message-Id: <20231008.164906.1151622782836568538.fujita.tomonori@gmail.com>
To: tmgross@umich.edu
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CALNs47v3cE-_LiJBTg0_Zkh_cinktHHP3xJ3tL3PAHn5+NBNCA@mail.gmail.com>
References: <20231007.195857.292080693191739384.fujita.tomonori@gmail.com>
	<20231008.073343.1435734022238977973.fujita.tomonori@gmail.com>
	<CALNs47v3cE-_LiJBTg0_Zkh_cinktHHP3xJ3tL3PAHn5+NBNCA@mail.gmail.com>
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

T24gU3VuLCA4IE9jdCAyMDIzIDAyOjE5OjQ2IC0wNDAwDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NA
dW1pY2guZWR1PiB3cm90ZToNCg0KPiBPbiBTYXQsIE9jdCA3LCAyMDIzIGF0IDY6MzPigK9QTSBG
VUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0KPj4g
VG8gY3JlYXRlIGFuIGludGVybmFsIHR5cGUgYmFzZWQgb24gYG5hbWVgLCB3ZSBuZWVkIHRvIHVu
c3RyaW5naWZ5DQo+PiBgbmFtZWA/IEkgY2FuJ3QgZmluZCBhIGVhc3kgd2F5IHRvIGRvIGl0Lg0K
PiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIGp1c3QgYmUgYWJsZSB0byBkbyBpdCB3aXRoIGBwYXN0
ZSFgDQo+IA0KPiAgICAgbWFjcm9fcnVsZXMhIG1vZHVsZV9waHlfZHJpdmVyIHsNCj4gICAgICAg
ICAobmFtZTogJG5hbWU6ZXhwcikgPT4gew0KPiAgICAgICAgICAgICBwYXN0ZTo6cGFzdGUhIHsN
Cj4gICAgICAgICAgICAgICAgICNbYWxsb3cobm9uX2NhbWVsX2Nhc2VfdHlwZXMpXQ0KPiAgICAg
ICAgICAgICAgICAgc3RydWN0IFs8JG5hbWUgX3R5Pl07DQo+ICAgICAgICAgICAgIH0NCj4gICAg
ICAgICB9DQo+ICAgICB9DQo+IA0KPiAgICAgLy8gY3JlYXRlcyBzdHJ1Y3QgYGRlbW9fZHJpdmVy
X3R5YA0KPiAgICAgbW9kdWxlX3BoeV9kcml2ZXIhIHsNCj4gICAgICAgICBuYW1lOiAiZGVtb19k
cml2ZXIiDQo+ICAgICB9DQo+IA0KDQpJIHJlYWxpemVkIHRoYXQgd2UgZG9uJ3QgbmVlZCBgbmFt
ZWAuIFRoZSBuYW1lIG9mIHN0cnVjdCBkb2Vzbid0DQptYXR0ZXIgc28gSSB1c2UgYE1vZHVsZWAu
IEkgdHJpZWQgdG8gdXNlIGBuYW1lYCBmb3IgdGhlIG5hbWUgb2YNCmRldmljZV90YWJsZSBob3dl
dmVyIHRoZSB2YXJpYWJsZSBuYW1lIG9mIHRoZSB0YWJsZSBpc24ndCBlbWJlZGVkIGludG8NCnRo
ZSBtb2R1bGUgYmluYXJ5IHNvIGl0IGRvZXNuJ3QgbWF0dGVyLg0KDQpGWUksIEkgdXNlIHBhc3Rl
ISBidXQgZ290IHRoZSBmb2xsb3dpbmcgZXJyb3I6DQoNCj0gaGVscDogbWVzc2FnZTogYCJfX21v
ZF9tZGlvX19cInJ1c3RfYXNpeF9waHlcIl9kZXZpY2VfdGFibGUiYCBpcyBub3QgYSB2YWxpZCBp
ZGVudGlmaWVyDQo9IG5vdGU6IHRoaXMgZXJyb3Igb3JpZ2luYXRlcyBpbiB0aGUgbWFjcm8gYCRj
cmF0ZTo6bW9kdWxlX3BoeV9kcml2ZXJgIHdoaWNoIGNvbWVzIGZyb20gdGhlIGV4cGFuc2lvbiBv
ZiB0aGUNCiAgbWFjcm8gYGtlcm5lbDo6bW9kdWxlX3BoeV9kcml2ZXJgIChpbiBOaWdodGx5IGJ1
aWxkcywgcnVuIHdpdGggLVogbWFjcm8tYmFja3RyYWNlIGZvciBtb3JlIGluZm8pDQoNCg0KI1tt
YWNyb19leHBvcnRdDQptYWNyb19ydWxlcyEgbW9kdWxlX3BoeV9kcml2ZXIgew0KICAgIChAcmVw
bGFjZV9leHByICRfdDp0dCAkc3ViOmV4cHIpID0+IHskc3VifTsNCg0KICAgIChAY291bnRfZGV2
aWNlcyAkKCR4OmV4cHIpLCopID0+IHsNCiAgICAgICAgMHVzaXplICQoKyAkY3JhdGU6Om1vZHVs
ZV9waHlfZHJpdmVyIShAcmVwbGFjZV9leHByICR4IDF1c2l6ZSkpKg0KICAgIH07DQoNCiAgICAo
QGRldmljZV90YWJsZSAkbmFtZTp0dCwgWyQoJGRldjpleHByKSwrXSkgPT4gew0KICAgICAgICA6
Omtlcm5lbDo6bWFjcm9zOjpwYXN0ZSEgew0KICAgICAgICAgICAgI1tub19tYW5nbGVdDQogICAg
ICAgICAgICBzdGF0aWMgWzxfX21vZF9tZGlvX18gJG5hbWUgX2RldmljZV90YWJsZT5dOiBbDQog
ICAgICAgICAgICAgICAga2VybmVsOjpiaW5kaW5nczo6bWRpb19kZXZpY2VfaWQ7DQogICAgICAg
ICAgICAgICAgJGNyYXRlOjptb2R1bGVfcGh5X2RyaXZlciEoQGNvdW50X2RldmljZXMgJCgkZGV2
KSwrKSArIDENCiAgICAgICAgICAgIF0gPSBbDQogICAgICAgICAgICAgICAgJChrZXJuZWw6OmJp
bmRpbmdzOjptZGlvX2RldmljZV9pZCB7DQogICAgICAgICAgICAgICAgICAgIHBoeV9pZDogJGRl
di5pZCwNCiAgICAgICAgICAgICAgICAgICAgcGh5X2lkX21hc2s6ICRkZXYubWFza19hc19pbnQo
KQ0KICAgICAgICAgICAgICAgIH0pLCssDQogICAgICAgICAgICAgICAga2VybmVsOjpiaW5kaW5n
czo6bWRpb19kZXZpY2VfaWQgew0KICAgICAgICAgICAgICAgICAgICBwaHlfaWQ6IDAsDQogICAg
ICAgICAgICAgICAgICAgIHBoeV9pZF9tYXNrOiAwDQogICAgICAgICAgICAgICAgfQ0KICAgICAg
ICAgICAgXTsNCiAgICAgICAgfQ0KICAgIH07DQoNCiAgICAoZHJpdmVyczogWyQoJGRyaXZlcjpp
ZGVudCksK10sIGRldmljZV90YWJsZTogWyQoJGRldjpleHByKSwrXSwgbmFtZTogJG5hbWU6dHQs
ICQoJGY6dHQpKikgPT4gew0KICAgICAgICBzdHJ1Y3QgTW9kdWxlIHsNCiAgICAgICAgICAgIF9y
ZWc6IGtlcm5lbDo6bmV0OjpwaHk6OlJlZ2lzdHJhdGlvbiwNCiAgICAgICAgfQ0KDQogICAgICAg
ICRjcmF0ZTo6cHJlbHVkZTo6bW9kdWxlISB7DQogICAgICAgICAgICAgdHlwZTogTW9kdWxlLA0K
ICAgICAgICAgICAgIG5hbWU6ICRuYW1lLA0KICAgICAgICAgICAgICQoJGYpKg0KICAgICAgICB9
DQoNCiAgICAgICAgc3RhdGljIG11dCBEUklWRVJTOiBbDQogICAgICAgICAgICBrZXJuZWw6OnR5
cGVzOjpPcGFxdWU8a2VybmVsOjpiaW5kaW5nczo6cGh5X2RyaXZlcj47DQogICAgICAgICAgICAk
Y3JhdGU6Om1vZHVsZV9waHlfZHJpdmVyIShAY291bnRfZGV2aWNlcyAkKCRkcml2ZXIpLCspDQog
ICAgICAgIF0gPSBbDQogICAgICAgICAgICAkKGtlcm5lbDo6bmV0OjpwaHk6OmNyZWF0ZV9waHlf
ZHJpdmVyOjo8JGRyaXZlcj4oKSksKw0KICAgICAgICBdOw0KDQogICAgICAgIGltcGwga2VybmVs
OjpNb2R1bGUgZm9yIE1vZHVsZSB7DQogICAgICAgICAgICBmbiBpbml0KG1vZHVsZTogJidzdGF0
aWMgVGhpc01vZHVsZSkgLT4gUmVzdWx0PFNlbGY+IHsNCiAgICAgICAgICAgICAgICAvLyBTQUZF
VFk6IHN0YXRpYyBgRFJJVkVSU2AgYXJyYXkgaXMgdXNlZCBvbmx5IGluIHRoZSBDIHNpZGUuDQog
ICAgICAgICAgICAgICAgbGV0IG11dCByZWcgPSB1bnNhZmUgeyBrZXJuZWw6Om5ldDo6cGh5OjpS
ZWdpc3RyYXRpb246OnJlZ2lzdGVyKG1vZHVsZSwgJkRSSVZFUlMpIH0/Ow0KDQogICAgICAgICAg
ICAgICAgT2soTW9kdWxlIHsNCiAgICAgICAgICAgICAgICAgICAgX3JlZzogcmVnLA0KICAgICAg
ICAgICAgICAgIH0pDQogICAgICAgICAgICB9DQogICAgICAgIH0NCg0KICAgICAgICAkY3JhdGU6
Om1vZHVsZV9waHlfZHJpdmVyIShAZGV2aWNlX3RhYmxlICRuYW1lLCBbJCgkZGV2KSwrXSk7DQog
ICAgfQ0KfQ0KDQo=

