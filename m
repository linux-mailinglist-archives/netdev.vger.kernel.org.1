Return-Path: <netdev+bounces-40731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C5F7C8864
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F5DF2812FE
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08A719BDC;
	Fri, 13 Oct 2023 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvYttgJ0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299A17740;
	Fri, 13 Oct 2023 15:15:18 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616FBE6;
	Fri, 13 Oct 2023 08:15:16 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57c0775d4fcso331780eaf.0;
        Fri, 13 Oct 2023 08:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697210115; x=1697814915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGA66Kd3z5BNtZqpc0uixzcNt7bSPROD/81oqwbxDCI=;
        b=LvYttgJ0W1tf5StW/U65IHNWNSLP89yz0CtgfwFoy5gpGTtw+bypxXNY0LoxWCXO+z
         GYGYgnbgCwKcthdCgvX+q+pbMDkGPVS1uNtMZ6xVoFz5jA1uHEaIXI6aUQ5zpnXCjZi/
         exT2dnRm6RBafCtBJqek7wOowRM0nT9sYXIwYPvloe3W20hRyK8q3rH6wcgnoXP9faXb
         clUFSotL+neFaaF0icsbZ+ZkA53MRp0nJQJUxFxPlNYwtfpbrvEueHui4fcWyJqdffDX
         t/CQOZPoyUhyhc0MyeUyB2M2EsdSKG6BE5g21delM/bueJe5kyb3EBRAXSd+KBJBDi1U
         JTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697210115; x=1697814915;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YGA66Kd3z5BNtZqpc0uixzcNt7bSPROD/81oqwbxDCI=;
        b=A8DF0Jo525ufrpimhGThvl86jlWppcgJ9KMKasFEArQV2IKWN58Pd275nqggLNHUfM
         ywvddhpZhhEQgCIhhhYN5gt2OpFjhZaDqaRLL/rT/NA4/IzYQJLQxjNpLRSy1W4CAxs+
         bsCitOdiPosowr99eyrka+lxusgo368J1OlVzCEG+UteADsVta3kvOdkhUAmaXwshoHN
         kWPhdXQTiO9PmIJeteyeaRZ0yjntVAYEM7hITIyTywaUi7I9ivpKYYtO85rX2W8Awer3
         cqeZvEnr15X8TyzuqqzJvzXDkL5IXiWz7QbnEqjKCc5DqqplkBeLgC3D8FCPfxhqaepK
         qC0Q==
X-Gm-Message-State: AOJu0YwHvbIvR/xMcNn3jgZgy3X4irppYIngJyJPTBreA/xar7Hgr8/1
	C7vVwbg4Ybxq+74KaUyobds=
X-Google-Smtp-Source: AGHT+IETzObRaTI1o4WmubSs9gdjYHinFlnPi8BVZGBLPRGzcOstmgCvsl1lBGNS2p2KVv5Xv0UVwA==
X-Received: by 2002:a05:6359:219:b0:14a:cca4:5601 with SMTP id ej25-20020a056359021900b0014acca45601mr21930790rwb.3.1697210115333;
        Fri, 13 Oct 2023 08:15:15 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id y16-20020aa793d0000000b0068fdb59e9d6sm290816pff.78.2023.10.13.08.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 08:15:15 -0700 (PDT)
Date: Sat, 14 Oct 2023 00:15:14 +0900 (JST)
Message-Id: <20231014.001514.876461873397203589.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com, andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu,
 wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com>
References: <CANiq72=GAiR-Mps_ZuLtxmma28dJd2xKdXWh6fu1icLBmmaYAw@mail.gmail.com>
	<20231012.081826.1846197263913130802.fujita.tomonori@gmail.com>
	<CANiq72mgeVrcGcHXo1xjaRL1ix3vUsGbtk179kpyJ6GAe9MMVg@mail.gmail.com>
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

T24gRnJpLCAxMyBPY3QgMjAyMyAxMzo1OToxMiArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBUaHUsIE9jdCAxMiwgMjAy
MyBhdCAxOjE44oCvQU0gRlVKSVRBIFRvbW9ub3JpDQo+IDxmdWppdGEudG9tb25vcmlAZ21haWwu
Y29tPiB3cm90ZToNCj4+DQo+PiBJSVJDLCBBbmRyZXcgcHJlZmVycyB0byBhdm9pZCBjcmVhdGlu
ZyBhIHRlbXBvcmFyeSBydXN0IHZhcmlhbnQgKEdyZWcNCj4+IGRvZXMgdG9vLCBJIHVuZGVyc3Rh
bmQpLiBJIGd1ZXNzIHRoYXQgb25seSBzb2x1c2lvbiB0aGF0IGJvdGggUnVzdCBhbmQNCj4+IEMg
ZGV2cyB3b3VsZCBiZSBoYXBweSB3aXRoIGlzIGdlbmVyYXRpbmcgc2FmZSBSdXN0IGNvZGUgZnJv
bSBDLiBUaGUNCj4gDQo+IEFzIGZhciBhcyBJIHVuZGVyc3RhbmQsIHRoZSB3b3JrYXJvdW5kIEkg
anVzdCBzdWdnZXN0ZWQgaW4gdGhlDQo+IHByZXZpb3VzIHJlcGx5IHdhcyBub3QgZGlzY3Vzc2Vk
IHNvIGZhci4gSSBhbSBub3Qgc3VyZSB3aGljaCBvZiB0aGUNCj4gYWx0ZXJuYXRpdmVzIHlvdSBt
ZWFuIGJ5IHRoZSAidGVtcG9yYXJ5IHJ1c3QgdmFyaWFudCIsIHNvIEkgbWF5IGJlDQo+IG1pc3Vu
ZGVyc3RhbmRpbmcgeW91ciBtZXNzYWdlLg0KDQpJIG1lYW50IHRoYXQgZGVmaW5pbmcgUnVzdCdz
IGVudW0gY29ycmVzcG9uZGluZyB0byB0aGUga2VybmVsJ3MgZW51bQ0KcGh5X3N0YXRlIGxpa2Uu
DQoNCitwdWIgZW51bSBEZXZpY2VTdGF0ZSB7DQorICAgIC8vLyBQSFkgZGV2aWNlIGFuZCBkcml2
ZXIgYXJlIG5vdCByZWFkeSBmb3IgYW55dGhpbmcuDQorICAgIERvd24sDQorICAgIC8vLyBQSFkg
aXMgcmVhZHkgdG8gc2VuZCBhbmQgcmVjZWl2ZSBwYWNrZXRzLg0KKyAgICBSZWFkeSwNCisgICAg
Ly8vIFBIWSBpcyB1cCwgYnV0IG5vIHBvbGxpbmcgb3IgaW50ZXJydXB0cyBhcmUgZG9uZS4NCisg
ICAgSGFsdGVkLA0KKyAgICAvLy8gUEhZIGlzIHVwLCBidXQgaXMgaW4gYW4gZXJyb3Igc3RhdGUu
DQorICAgIEVycm9yLA0KKyAgICAvLy8gUEhZIGFuZCBhdHRhY2hlZCBkZXZpY2UgYXJlIHJlYWR5
IHRvIGRvIHdvcmsuDQorICAgIFVwLA0KKyAgICAvLy8gUEhZIGlzIGN1cnJlbnRseSBydW5uaW5n
Lg0KKyAgICBSdW5uaW5nLA0KKyAgICAvLy8gUEhZIGlzIHVwLCBidXQgbm90IGN1cnJlbnRseSBw
bHVnZ2VkIGluLg0KKyAgICBOb0xpbmssDQorICAgIC8vLyBQSFkgaXMgcGVyZm9ybWluZyBhIGNh
YmxlIHRlc3QuDQorICAgIENhYmxlVGVzdCwNCit9DQoNClRoZW4gd3JpdGUgbWF0Y2ggY29kZSBi
eSBoYW5kLg0KDQpJJ2xsIGxlYXZlIGl0IHRvIFBIWUxJQiBtYWludGFpbmVycy4gVGhlIHN1YnN5
c3RlbSBtYWludGFpbmVycyBkZWNpZGUNCndoZXRoZXIgdGhleSBtZXJnZXMgdGhlIGNvZGUuDQoN
CkFuZHJldywgd2hhdCBkbyB5b3UgdGhpbmsgYWJvdXQgdGhlIHN0YXR1cyBvZiB0aGUgYWJzdHJh
Y3Rpb24gcGF0Y2hzZXQ/DQoNCg0KPiBIYXZpbmcgc2FpZCB0aGF0LCB0byB0cnkgdG8gdW5ibG9j
ayB0aGluZ3MsIEkgc3BlbnQgc29tZSB0aW1lDQo+IHByb3RvdHlwaW5nIHRoZSB3b3JrYXJvdW5k
IEkgc3VnZ2VzdGVkLCBzZWUgYmVsb3cgWzFdLiBUaGF0IGNhdGNoZXMNCj4gdGhlICJuZXcgQyB2
YXJpYW50IGFkZGVkIiBkZXN5bmMgYmV0d2VlbiBSdXN0IGFuZCBDLg0KDQpUaGFua3MsIGJ1dCB3
ZSBoYXZlIHRvIG1haW50YWluIHRoZSBmb2xsb3dpbmcgY29kZSBieSBoYW5kPyBpZiBzbywNCnRo
ZSBtYWludGFuYWNlIG5pZ2h0bWFyZSBwcm9ibGVtIGlzbid0IHNvbHZlZD8NCg0KDQpidHcsIEkg
Y2FuJ3QgYXBwbHkgdGhlIHBhdGNoLCBsaW5lIHdyYXBwaW5nPw0KDQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uN2M2MmJhYjEyZWExDQo+IC0tLSAvZGV2L251
bGwNCj4gKysrIGIvcnVzdC9iaW5kaW5ncy9iaW5kaW5nc19lbnVtX2NoZWNrLnJzDQo+IEBAIC0w
LDAgKzEsMzggQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsN
Cj4gKy8vISBCaW5kaW5ncyBleGhhdXN0aXZlbmVzcyBlbnVtIGNoZWNrLg0KPiArLy8hDQo+ICsv
LyEgRXZlbnR1YWxseSwgdGhpcyBzaG91bGQgYmUgcmVwbGFjZWQgYnkgYSBzYWZlIHZlcnNpb24g
b2YNCj4gYC0tcnVzdGlmaWVkLWVudW1gLCBzZWUNCj4gKy8vISBodHRwczovL2dpdGh1Yi5jb20v
cnVzdC1sYW5nL3J1c3QtYmluZGdlbi9pc3N1ZXMvMjY0Ni4NCj4gKw0KPiArIyFbbm9fc3RkXQ0K
PiArIyFbYWxsb3coDQo+ICsgICAgY2xpcHB5OjphbGwsDQo+ICsgICAgZGVhZF9jb2RlLA0KPiAr
ICAgIG1pc3NpbmdfZG9jcywNCj4gKyAgICBub25fY2FtZWxfY2FzZV90eXBlcywNCj4gKyAgICBu
b25fdXBwZXJfY2FzZV9nbG9iYWxzLA0KPiArICAgIG5vbl9zbmFrZV9jYXNlLA0KPiArICAgIGlt
cHJvcGVyX2N0eXBlcywNCj4gKyAgICB1bnJlYWNoYWJsZV9wdWIsDQo+ICsgICAgdW5zYWZlX29w
X2luX3Vuc2FmZV9mbg0KPiArKV0NCj4gKw0KPiAraW5jbHVkZSEoY29uY2F0ISgNCj4gKyAgICBl
bnYhKCJPQkpUUkVFIiksDQo+ICsgICAgIi9ydXN0L2JpbmRpbmdzL2JpbmRpbmdzX2dlbmVyYXRl
ZF9lbnVtX2NoZWNrLnJzIg0KPiArKSk7DQo+ICsNCj4gK2ZuIGNoZWNrX3BoeV9zdGF0ZSgNCj4g
KyAgICAocGh5X3N0YXRlOjpQSFlfRE9XTg0KPiArICAgIHwgcGh5X3N0YXRlOjpQSFlfUkVBRFkN
Cj4gKyAgICB8IHBoeV9zdGF0ZTo6UEhZX0hBTFRFRA0KPiArICAgIHwgcGh5X3N0YXRlOjpQSFlf
RVJST1INCj4gKyAgICB8IHBoeV9zdGF0ZTo6UEhZX1VQDQo+ICsgICAgfCBwaHlfc3RhdGU6OlBI
WV9SVU5OSU5HDQo+ICsgICAgfCBwaHlfc3RhdGU6OlBIWV9OT0xJTksNCj4gKyAgICB8IHBoeV9z
dGF0ZTo6UEhZX0NBQkxFVEVTVCk6IHBoeV9zdGF0ZSwNCj4gKykgew0KPiArfQ0KPiANCg==

