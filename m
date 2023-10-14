Return-Path: <netdev+bounces-40951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2D17C92D3
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25BF0B20AF4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 05:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B239415C9;
	Sat, 14 Oct 2023 05:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abyd2+Mi"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B77E;
	Sat, 14 Oct 2023 05:15:11 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AE8BF;
	Fri, 13 Oct 2023 22:15:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-69361132a60so547249b3a.1;
        Fri, 13 Oct 2023 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697260509; x=1697865309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ytPEO/GRfLMESHiZP0+jQ4is/7AAUxZMkGlziKXda8s=;
        b=abyd2+MiQQY/+rKCOU0ZvsnM6gDHaUip5lsdEq/EenkfFD5aZ4xtKkMqv+vU0v9DWL
         oqGtyrtinwN8XSymATYdpm2KmHo9N3HipN6zHnurvM6HZfj3tz5Hj4y5irUocrCPWYGh
         T95+qzksPPQtVGTrA8wbXpaDvXpNIwQkEpMs9khx7JY0la9Zw3DheCyP2LTrCLJjtqo8
         OhjAYuL6EyMoqa3K0c7r1YOlxRfN/x0YKieRJjgvxNVyw3FcJrDEjUEbFi4Q1I7ORFcd
         VflLvpv1GeEVtvhQx+FCMqYlMkRkJJSTNKkTFs2sy553ZTnhsi+IYONdENonzaecNJSF
         d57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697260509; x=1697865309;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ytPEO/GRfLMESHiZP0+jQ4is/7AAUxZMkGlziKXda8s=;
        b=GVKLpvZh+or/26OyI9T4iY0zqAC0gnQzj8KBdRHWo6gi1w51GffIxQUfd6p4Ls8xGQ
         fvDb6AX/XNG1aT1Y7eVymFHcqlWamwYzix9nBy2LIyShlXVqXUw6QDDMh1P5SmLv1B1G
         Kswc0tRgbMM9Ca9JM6LhY70O2df9fvxUqOroFem3s8YlyP2w1XOSgvxFTxTPBYOrvuUZ
         /D8Kt4nzHo4/aPmBsIXeeCeGuO9NfUR5Pbc0KmqRlnQSWUn77e0KL/LRESp8z12IRkia
         GTmsXbdtdbsoURmOcnOLCf0H1X1ZJxaqJPO4N09E9ZspOA3o96HL2v7Tu3NPmxpMsQU4
         ATBg==
X-Gm-Message-State: AOJu0Yy9ZLQhHMYfbvaTU2Hi0vnFpEszkUKMGmUZZNtH5IaqwZ4m2QBZ
	LW/uNb3q6gTTLzKXKo5M1H2XejayyIFv7Fng
X-Google-Smtp-Source: AGHT+IELGgunqWnk7XjsNajTK28OVIadvT1g3nsqlEKhLD90zAtPKRp1Qm68ymK722mxpn2XMS5QxA==
X-Received: by 2002:a05:6a20:4407:b0:133:6e3d:68cd with SMTP id ce7-20020a056a20440700b001336e3d68cdmr39059121pzb.3.1697260509591;
        Fri, 13 Oct 2023 22:15:09 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id v15-20020a63b64f000000b00528db73ed70sm3602804pgt.3.2023.10.13.22.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 22:15:09 -0700 (PDT)
Date: Sat, 14 Oct 2023 14:15:08 +0900 (JST)
Message-Id: <20231014.141508.709941476709455265.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: miguel.ojeda.sandonis@gmail.com, tmgross@umich.edu,
 boqun.feng@gmail.com, fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
 benno.lossin@proton.me, greg@kroah.com
Subject: Re: [PATCH net-next v4 3/4] MAINTAINERS: add Rust PHY abstractions
 to the ETHERNET PHY LIBRARY
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <0948fa3f-2421-47ad-89fc-8b0992d9f021@lunn.ch>
References: <CALNs47u9ACA3MO2soPueeGZe=yZkieKb6rDr-G1fGQePjJ5npg@mail.gmail.com>
	<CANiq72kS=--E_v9no=pFtxArxtxWNrAbgcAa4LUz28CYozbVWg@mail.gmail.com>
	<0948fa3f-2421-47ad-89fc-8b0992d9f021@lunn.ch>
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

T24gRnJpLCAxMyBPY3QgMjAyMyAyMDo0OToyOSArMDIwMA0KQW5kcmV3IEx1bm4gPGFuZHJld0Bs
dW5uLmNoPiB3cm90ZToNCg0KPiBPbiBGcmksIE9jdCAxMywgMjAyMyBhdCAwODo0MzoyMVBNICsw
MjAwLCBNaWd1ZWwgT2plZGEgd3JvdGU6DQo+PiBPbiBGcmksIE9jdCAxMywgMjAyMyBhdCA2OjE3
4oCvUE0gVHJldm9yIEdyb3NzIDx0bWdyb3NzQHVtaWNoLmVkdT4gd3JvdGU6DQo+PiA+DQo+PiA+
IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24gQm9xdW4gOikgSSB3b3VsZCBiZSBoYXBweSB0byBi
ZSBhIHJldmlld2VyDQo+PiA+IGZvciB0aGUgcnVzdCBjb21wb25lbnRzIG9mIG5ldHdvcmtpbmcu
DQo+PiANCj4+IFRoYW5rcyBhIGxvdCBUcmV2b3IhDQo+PiANCj4+ID4gQXMgVG9tbyBtZW50aW9u
ZWQgSSBhbSBub3Qgc3VyZSB0aGVyZSBpcyBhIGdvb2Qgd2F5IHRvIGluZGljYXRlIHRoaXMNCj4+
ID4gbmljaGUsIG1heWJlIGEgbmV3IHNlY3Rpb24gd2l0aCB0d28gbGlzdHM/IEFuZHJldydzIGNh
bGwgZm9yIHdoYXQNCj4+ID4gd291bGQgYmUgYmVzdCBoZXJlIEkgc3VwcG9zZS4NCj4+IA0KPj4g
WWVzLCBtYWludGFpbmVycyBtYXkgcHJlZmVyIHRvIHNwbGl0IGl0IG9yIG5vdCAoZS5nLiAiRVRI
RVJORVQgUEhZDQo+PiBMSUJSQVJZIFtSVVNUXSIpLiBUaGVuIFRvbW8gYW5kIHlvdSBjYW4gYmUg
dGhlcmUuDQo+PiANCj4+IFRoYXQgYWxzbyBhbGxvd3MgdG8gbGlzdCBvbmx5IHRoZSByZWxldmFu
dCBmaWxlcyBpbiBgRjpgLCB0byBoYXZlIGFuDQo+PiBleHRyYSBgTDpgIGZvciBydXN0LWZvci1s
aW51eCAoaW4gdGhlIGJlZ2lubmluZyksIGEgZGlmZmVyZW50IGBTOmANCj4+IGxldmVsIGlmIG5l
ZWRlZCwgZXRjLg0KPiANCj4gWWVzLCB0aGlzIHNlZW1zIHNlbnNpYmxlLg0KPg0KPiBJIHdvdWxk
IGFsc28gc3VnZ2VzdCBhIG5ldyBlbnRyeSBmb3IgdGhlIGRyaXZlci4NCj4gDQo+IFBsYXkgd2l0
aCAuL3NjcmlwdC9nZXRfbWFpbnRhaW5lci5wbCAtLWZpbGUgYW5kIG1ha2Ugc3VyZSBpdCBwaWNr
cyB0aGUNCj4gcmlnaHQgcGVvcGxlIGZvciBhIHBhcnRpY3VsYXIgZmlsZS4NCg0KTG9va3MgZ29v
ZD8NCg0KRVRIRVJORVQgUEhZIExJQlJBUlkgW1JVU1RdDQpNOiAgRlVKSVRBIFRvbW9ub3JpIDxm
dWppdGEudG9tb25vcmlAZ21haWwuY29tPg0KUjogIFRyZXZvciBHcm9zcyA8dG1ncm9zc0B1bWlj
aC5lZHU+DQpMOiAgbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KTDogIHJ1c3QtZm9yLWxpbnV4QHZn
ZXIua2VybmVsLm9yZw0KUzogIE1haW50YWluZWQNCkY6ICBydXN0L2tlcm5lbC9uZXQvcGh5LnJz
DQoNCmdldF9tYWludGFpbmVyLnBsIGdpdmVzIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uIGhvcGVm
dWxseSwgd2UgY2FuIG1vdmUNCnBoeS5ycyB0byBkcml2ZXJzL25ldC9waHkgc29vbi4NCg0KdWJ1
bnR1QGlwLTE3Mi0zMC00Ny0xMTQ6fi9naXQvbGludXgkIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5l
ci5wbCAtLWZpbGUgcnVzdC9rZXJuZWwvbmV0L3BoeS5ycw0KRlVKSVRBIFRvbW9ub3JpIDxmdWpp
dGEudG9tb25vcmlAZ21haWwuY29tPiAobWFpbnRhaW5lcjpFVEhFUk5FVCBQSFkgTElCUkFSWSBb
UlVTVF0pDQpUcmV2b3IgR3Jvc3MgPHRtZ3Jvc3NAdW1pY2guZWR1PiAocmV2aWV3ZXI6RVRIRVJO
RVQgUEhZIExJQlJBUlkgW1JVU1RdKQ0KTWlndWVsIE9qZWRhIDxvamVkYUBrZXJuZWwub3JnPiAo
c3VwcG9ydGVyOlJVU1QpDQpBbGV4IEdheW5vciA8YWxleC5nYXlub3JAZ21haWwuY29tPiAoc3Vw
cG9ydGVyOlJVU1QpDQpXZWRzb24gQWxtZWlkYSBGaWxobyA8d2Vkc29uYWZAZ21haWwuY29tPiAo
c3VwcG9ydGVyOlJVU1QpDQpCb3F1biBGZW5nIDxib3F1bi5mZW5nQGdtYWlsLmNvbT4gKHJldmll
d2VyOlJVU1QpDQpHYXJ5IEd1byA8Z2FyeUBnYXJ5Z3VvLm5ldD4gKHJldmlld2VyOlJVU1QpDQoi
QmrDtnJuIFJveSBCYXJvbiIgPGJqb3JuM19naEBwcm90b25tYWlsLmNvbT4gKHJldmlld2VyOlJV
U1QpDQpCZW5ubyBMb3NzaW4gPGJlbm5vLmxvc3NpbkBwcm90b24ubWU+IChyZXZpZXdlcjpSVVNU
KQ0KQW5kcmVhcyBIaW5kYm9yZyA8YS5oaW5kYm9yZ0BzYW1zdW5nLmNvbT4gKHJldmlld2VyOlJV
U1QpDQpBbGljZSBSeWhsIDxhbGljZXJ5aGxAZ29vZ2xlLmNvbT4gKHJldmlld2VyOlJVU1QpDQpu
ZXRkZXZAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6RVRIRVJORVQgUEhZIExJQlJBUlkgW1JV
U1RdKQ0KcnVzdC1mb3ItbGludXhAdmdlci5rZXJuZWwub3JnIChvcGVuIGxpc3Q6RVRIRVJORVQg
UEhZIExJQlJBUlkgW1JVU1RdKQ0KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyAob3BlbiBs
aXN0KQ0K

