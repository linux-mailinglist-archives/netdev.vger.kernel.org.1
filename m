Return-Path: <netdev+bounces-39180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3477BE45E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BB1C209F3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C236AEA;
	Mon,  9 Oct 2023 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfx6QiL4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC94358AA;
	Mon,  9 Oct 2023 15:15:55 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EA5D5D;
	Mon,  9 Oct 2023 08:15:38 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c76ef40e84so8397555ad.0;
        Mon, 09 Oct 2023 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864538; x=1697469338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aRK3ZlGgDbvMOUdTshYX2ukuvGIWQ+VDogksvQqekMA=;
        b=Mfx6QiL40jQtclTnF0RgTrF8b91/pmrohaINLaihNF1NLL+YFxFk0jFWWfPZBh+ZeG
         0wyLbRZS4g5qyK0mqj0E/f7uG2j+SwOgGRfMVEjTVzTyYwxYnuZsoePEOgGQLS8bmEUC
         8sGnrmPJVuCZD4c6vYNqbRsB9R/Ph329yFiSiNWAGRLv1gqFFT6jEoKg0O9IAlA/vOfv
         LfRX/ffD6ZpaoPA5sb8892iCqS0jyg8vvNo/yJ7M+x3Dh/tlA/YYvFGJ9S3s2keqm6g5
         /vMBV+ujnZnMPWGRRHedLFiPdu1sRHySSdTjROAQaC6KupgLM1FT5eP6WlEnGfwJhTfi
         QAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864538; x=1697469338;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aRK3ZlGgDbvMOUdTshYX2ukuvGIWQ+VDogksvQqekMA=;
        b=CWhtgT01SZM4V/IhMoZ586n1b4WkhSiPGMd7GYNBTzxkk6FP4NW1SEz/FU9zN2s9Se
         5ruGVwKHJEOBqaqfkRTsbOHqozSAJJu/beXEOomlI1bbU36hc6NiXBZRH24dKXImgf69
         NP7CNbs8J2yEIM8jAP+NIIGQWDot9t8uRNjAJQj4/qJxg5r0MDPiHyqVuUwvje/kVqQO
         pDdfF063cxDjW+s0nFblPqsLNo3luBf7Kj7YbWbuRcQ1q5ZCVbmOEc3FcJfBOtcQ9+jC
         eyXhtAcRp15MJTtenmYoOqNJ4dnCunqZPTLKsiqvUWVQBiv+BT4X9ZifSUBKataI+EuH
         jO3Q==
X-Gm-Message-State: AOJu0YyvVmBoryg1S4f0FqXmFTpbZ+PYc92eWRz6MVgetmz5tpdtCbn8
	2T4w7Wu9hRbdxIQylYeWh/g=
X-Google-Smtp-Source: AGHT+IEcpIIZ0l9Bo3FZOsBEcDlIvvySS15WxpMSmiM4ejSaHySLEmYClmfmZr/rxl6wTQBvfFFWyg==
X-Received: by 2002:a17:902:f54e:b0:1c2:c60:8387 with SMTP id h14-20020a170902f54e00b001c20c608387mr17800520plf.0.1696864537634;
        Mon, 09 Oct 2023 08:15:37 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001bd28b9c3ddsm9693781plr.299.2023.10.09.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:15:37 -0700 (PDT)
Date: Tue, 10 Oct 2023 00:15:36 +0900 (JST)
Message-Id: <20231010.001536.1522827516505306330.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, greg@kroah.com,
 tmgross@umich.edu, wedsonaf@gmail.com
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72nf1ystSiV_BavRvMHA79bO7XapA3TURag1Kw_wzUr2Og@mail.gmail.com>
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
	<20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
	<CANiq72nf1ystSiV_BavRvMHA79bO7XapA3TURag1Kw_wzUr2Og@mail.gmail.com>
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

T24gTW9uLCA5IE9jdCAyMDIzIDE2OjMyOjQyICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIE1vbiwgT2N0IDksIDIwMjMg
YXQgMzo0OeKAr1BNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gV2UgaGF2ZSBhYm91dCB0d28gd2Vla3MgYmVmb3JlIHRoZSBtZXJn
ZSB3aW5kb3cgb3BlbnM/IEl0IHdvdWxkIGdyZWF0DQo+PiBpZiBvdGhlciBwZW9wbGUgY291bGQg
cmV2aWV3IHJlYWxseSBzb29uLg0KPj4NCj4+IFdlIGNhbiBpbXByb3ZlIHRoZSBhYnN0cmFjdGlv
bnMgYWZ0ZXIgaXQncyBtZXJnZWQuIFRoaXMgcGF0Y2hzZXQNCj4+IGRvZXNuJ3QgYWRkIGFueXRo
aW5nIGV4cG9ydGVkIHRvIHVzZXJzLiBUaGlzIGFkZHMgb25seSBvbmUgZHJpdmVyIHNvDQo+PiB0
aGUgQVBJcyBjYW4gYmUgZml4ZWQgYW55dGltZS4NCj4+DQo+PiBPbmNlIGl0J3MgbWVyZ2VkLCBt
dWx0aXBsZSBwZW9wbGUgY2FuIHNlbmQgcGF0Y2hlcyBlYXNpbHksIHNvIG1vcmUNCj4+IHNjYWxh
YmxlLg0KPiANCj4gSSB0aGluayBpdCBpcyB0b28gc29vbiB0byBtZXJnZSBpdCB1bmxlc3MgeW91
IGdldCBzb21lIG1vcmUgcmV2aWV3cy4NCj4gDQo+IE9uIHRoZSBvdGhlciBoYW5kLCBJIGFncmVl
IGl0ZXJhdGluZyBpbi10cmVlIGlzIGVhc2llci4NCj4gDQo+IElmIHlvdSB3YW50IHRvIG1lcmdl
IGl0IHZlcnkgc29vbiwgSSB3b3VsZCBzdWdnZXN0DQo+IGNvbnNpZGVyaW5nL2V2YWx1YXRpbmcg
dGhlIGZvbGxvd2luZzoNCg0KSXQncyB1cCB0byBQSFkgbWFpbnRhaW5lcnMuIEkgcHJlZmVyIHRo
YXQgdGhlIHBhdGNoc2V0IGFyZSBtZXJnZWQgdmVyeQ0Kc29vbi4gTXVjaCBlYXNpZXIgdG8gaW1w
cm92ZSB0aGUgY29kZSBpbiB0cmVlLg0KDQoNCj4gICAtIFBsZWFzZSBjb25zaWRlciBtYXJraW5n
IHRoZSBkcml2ZXIgYXMgYSAiUnVzdCByZWZlcmVuY2UgZHJpdmVyIg0KPiBbMV0gdGhhdCBpcyBu
b3QgbWVhbnQgdG8gYmUgdXNlZCAoeWV0LCBhdCBsZWFzdCkgaW4gcHJvZHVjdGlvbi4gVGhhdA0K
PiB3b3VsZCBwcm9iYWJseSBiZSB0aGUgYmVzdCBzaWduYWwsIGFuZCBldmVyeWJvZHkgaXMgY2xl
YXIgb24gdGhlDQo+IGV4cGVjdGF0aW9ucy4NCg0KT2YgY291cnNlLiBJIHdvdWxkIGJlIHZlcnkg
c3VycHJpc2VkIGlmIHNvbWVvbmUgdGhpbmsgdGhhdCBhIFJ1c3QNCmRyaXZlciBpcyByZWFkeSBm
b3IgcHJvZHVjdGlvbiBiZWNhdXNlIFJ1c3Qgc3VwcG9ydCBpcyBhbg0KZXhwZXJpbWVudC4NCg0K
SG93IEkgY2FuIG1hcmsgdGhlIGRyaXZlciBhcyBhICJSdXN0IHJlZmVyZW5jZSBkcml2ZXIiPyBL
Y29uZmlnDQpkZXNjcmlwdGlvbj8NCg0KDQo+ICAgLSBPdGhlcndpc2UsIHBsZWFzZSBjb25zaWRl
ciBtYXJraW5nIGl0IGFzIHN0YWdpbmcvZXhwZXJpbWVudGFsIGZvcg0KPiB0aGUgdGltZSBiZWlu
Zy4gVGhhdCBhbGxvd3MgeW91IHRvIGl0ZXJhdGUgdGhlIGFic3RyYWN0aW9ucyBhdCB5b3VyDQo+
IG93biBwYWNlLiBPZiBjb3Vyc2UsIGl0IHN0aWxsIHJpc2tzIHNvbWVib2R5IG91dC1vZi10cmVl
IHVzaW5nIHRoZW0sDQo+IGJ1dCBzZWUgdGhlIG5leHQgcG9pbnRzLg0KPiANCj4gICAtIFNob3Vs
ZCBmaXhlcyB0byB0aGUgY29kZSBiZSBjb25zaWRlcmVkIGFjdHVhbCBmaXhlcyBhbmQgc2VudCB0
bw0KPiBzdGFibGU/IElmIHdlIGRvIG9uZSBvZiB0aGUgYWJvdmUsIEkgZ3Vlc3MgeW91IGNvdWxk
IHNpbXBseSBzYXkgdGhlDQo+IGNvZGUgaXMgaW4gZGV2ZWxvcG1lbnQuDQo+IA0KPiAgIC0gU2lt
aWxhcmx5LCB3aGF0IGFib3V0IFJ1c3QgdW5zb3VuZG5lc3MgaXNzdWVzPyBXZSBkbyB3YW50IHRv
DQo+IGNvbnNpZGVyIHRob3NlIGFzIHN0YWJsZS13b3J0aHkgcGF0Y2hlcyBldmVuIGlmIHRoZXkg
bWF5IG5vdCBiZSAicmVhbCINCj4gc2VjdXJpdHkgaXNzdWVzLCBhbmQganVzdCAicG90ZW50aWFs
IiBvbmVzLiBXZSBkaWQgc3VibWl0IGFuIHN0YWJsZQ0KPiBwYXRjaCBpbiB0aGUgcGFzdCBmb3Ig
b25lIG9mIHRob3NlLg0KPiANCj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2tzdW1taXQv
Q0FOaXE3Mj05OVZGRT1WZTVNTk05WnVTZTlNLUpTSDFldms2cEFCTlNFbk5qSzdhWFlBQG1haWwu
Z21haWwuY29tLw0KDQpJZiBhIGRyaXZlciBpcyBtYXJrZWQgYXMgYSByZWZlcmVuY2UgZHJpdmVy
LCB3ZSBkb24ndCBuZWVkIHRvIHRoaW5rDQphYm91dCAic3RhYmxlIiBzdHVmZiwgcmlnaHQ/DQo=

