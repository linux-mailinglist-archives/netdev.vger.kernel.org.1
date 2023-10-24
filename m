Return-Path: <netdev+bounces-43726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DC7D450E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321A91F224B5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2BE63DA;
	Tue, 24 Oct 2023 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miA6KBkz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C931863;
	Tue, 24 Oct 2023 01:37:35 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A1E10A;
	Mon, 23 Oct 2023 18:37:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6bbfb8f7ac4so816039b3a.0;
        Mon, 23 Oct 2023 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698111453; x=1698716253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNxhERLWPzLgUytWqGsvsFoYjKoK6dpsWIDCl7T8+G4=;
        b=miA6KBkzWOfDfLuS7MChiK6RUxXtB+zfd/POPKhcngvN/gh0BoKbQ4EiLF9CjeqhL9
         nw3cIOLp2DLOgRohrJtVG2ZzgRxS48FkWAlbQx3kmXRjLmfEYIZYZvwVYTi5n4yQxUpm
         9HfbAbrnw4yk19bXEzfdOdPlVEISHcq4ZTjfT9od0JKUnrcZw8OUogH+wgx0KgYW48I8
         VyrLyAZxu3oj4BF5KUrkuIZpSnDti5J1gOiBo3Mu3VzAgtI2WQlLIxI/BLQZ6sI6zwr1
         nhdwypTDNmp/mVOCliMoE2YitL5zO3ZL57BIGMpEFrRHrcyLx+SJhWEc7w2Ymc3Rc4ev
         ECNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698111453; x=1698716253;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qNxhERLWPzLgUytWqGsvsFoYjKoK6dpsWIDCl7T8+G4=;
        b=q670z2TpvlTIHufWO+UjywOYAK2TVPkHBwuVvZrepAgeb1fNY2eIaSoeef3W1P1bOL
         hPtiol3kRMU3ey5Q0ce337ag0Bd1VXCdkKRDruJtsS7UZGOF1ddp4EBRmz+gY6vr0sys
         RLpOQe4WRfC6s0BTt2O0U3wyVjqlZcmXY9JPUThasJc9PuGwRJG2SMm6VIx9JRiX4Wlo
         k/0cpLB+NJlrufGmXwYxcCcmbsRUSLAKGKDfS5QaP2w83pGrXl4XOQ0Xm6FevLi4exJR
         3l0ROctYdxwwXA9V8mm41LtpVUlMmisvl1PVrigjRuhEj96WCawEcPUDAkeDPvXJjhCX
         fHTw==
X-Gm-Message-State: AOJu0YyzyOcKVKSSgfx075eWhuuckwZ52L9VRTgGABzsmA0nIha0w5vy
	FvV2v/Mjv6/J1NSDLBKQoB4=
X-Google-Smtp-Source: AGHT+IE+ukPeijiSUxOOtocpWFCuPnHcJDV4cI1f2sPxoZ/VXnZ9u0BJ5XwqMJu/nO711JNwsRQXHQ==
X-Received: by 2002:a05:6a00:4598:b0:6be:4b10:b27d with SMTP id it24-20020a056a00459800b006be4b10b27dmr10474821pfb.0.1698111453309;
        Mon, 23 Oct 2023 18:37:33 -0700 (PDT)
Received: from localhost (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id s19-20020a056a00195300b006be0fb89ac2sm6721031pfk.197.2023.10.23.18.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 18:37:33 -0700 (PDT)
Date: Tue, 24 Oct 2023 10:37:32 +0900 (JST)
Message-Id: <20231024.103732.1242900920044504585.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: miguel.ojeda.sandonis@gmail.com, fujita.tomonori@gmail.com,
 benno.lossin@proton.me, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu, boqun.feng@gmail.com,
 wedsonaf@gmail.com, greg@kroah.com
Subject: Re: [PATCH net-next v5 1/5] rust: core abstractions for network
 PHY drivers
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <798666eb-713b-445d-b9f0-72b6bbf957ff@lunn.ch>
References: <20231022.184702.1777825182430453165.fujita.tomonori@gmail.com>
	<CANiq72mDWJDb9Fhd4CHt8YKapdWaOrqhJMOrQZ9CDRtvNdrGqA@mail.gmail.com>
	<798666eb-713b-445d-b9f0-72b6bbf957ff@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU3VuLCAyMiBPY3QgMjAyMyAxNzozNDowNCArMDIwMA0KQW5kcmV3IEx1bm4gPGFuZHJld0Bs
dW5uLmNoPiB3cm90ZToNCg0KPiBPbiBTdW4sIE9jdCAyMiwgMjAyMyBhdCAwMTozNzozM1BNICsw
MjAwLCBNaWd1ZWwgT2plZGEgd3JvdGU6DQo+PiBPbiBTdW4sIE9jdCAyMiwgMjAyMyBhdCAxMTo0
N+KAr0FNIEZVSklUQSBUb21vbm9yaQ0KPj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdy
b3RlOg0KPj4gPg0KPj4gPiBBZ3JlZWQgdGhhdCB0aGUgZmlyc3QgdGhyZWUgcGFyYWdyYXBocyBh
dCB0aGUgdG9wIG9mIHRoZSBmaWxlIGFyZQ0KPj4gPiBpbXBsZW1lbnRhdGlvbiBjb21tZW50cy4g
QXJlIHRoZXJlIGFueSBvdGhlciBjb21tZW50cyBpbiB0aGUgZmlsZSwNCj4+ID4gd2hpY2ggbG9v
ayBpbXBsZW1lbnRhdGlvbiBjb21tZW50cyB0byB5b3U/IFRvIG1lLCB0aGUgcmVzdCBsb29rIHRo
ZQ0KPj4gPiBkb2NzIGZvciBSdXN0IEFQSSB1c2Vycy4NCj4+IA0KPj4gSSB0aGluayBzb21lIHNo
b3VsZCBiZSBpbXByb3ZlZCB3aXRoIHRoYXQgaW4gbWluZCwgeWVhaC4gRm9yIGluc3RhbmNlLA0K
Pj4gdGhpcyBvbmUgc2VlbXMgZ29vZCB0byBtZToNCj4+IA0KPj4gICAgIC8vLyBBbiBpbnN0YW5j
ZSBvZiBhIFBIWSBkcml2ZXIuDQo+PiANCj4+IEJ1dCB0aGlzIG9uZSBpcyBub3Q6DQo+PiANCj4+
ICAgICAvLy8gQ3JlYXRlcyB0aGUga2VybmVsJ3MgYHBoeV9kcml2ZXJgIGluc3RhbmNlLg0KPj4g
DQo+PiBJdCBpcyBlc3BlY2lhbGx5IGJhZCBiZWNhdXNlIHRoZSBmaXJzdCBsaW5lIG9mIHRoZSBk
b2NzIGlzIHRoZSAic2hvcnQNCj4+IGRlc2NyaXB0aW9uIiB1c2VkIGZvciBsaXN0cyBieSBgcnVz
dGRvY2AuDQo+PiANCj4+IEZvciBzaW1pbGFyIHJlYXNvbnMsIHRoaXMgb25lIGlzIGJhZCAoYW5k
IGluIHRoaXMgY2FzZSBpdCBpcyB0aGUgb25seSBsaW5lISk6DQo+PiANCj4+ICAgICAvLy8gQ29y
cmVzcG9uZHMgdG8gdGhlIGtlcm5lbCdzIGBlbnVtIHBoeV9zdGF0ZWAuDQo+PiANCj4+IFRoYXQg
bGluZSBjb3VsZCBiZSBwYXJ0IG9mIHRoZSBkb2N1bWVudGF0aW9uIGlmIHlvdSB0aGluayBpdCBp
cw0KPj4gaGVscGZ1bCBmb3IgYSByZWFkZXIgYXMgYSBwcmFjdGljYWwgbm90ZSBleHBsYWluaW5n
IHdoYXQgaXQgaXMNCj4+IHN1cHBvc2VkIHRvIG1hcCBpbiB0aGUgQyBzaWRlLiBCdXQgaXQgc2hv
dWxkIHJlYWxseSBub3QgYmUgdGhlIHZlcnkNCj4+IGZpcnN0IGxpbmUgLyBzaG9ydCBkZXNjcmlw
dGlvbi4NCj4+IA0KPj4gSW5zdGVhZCwgdGhlIGRvY3VtZW50YXRpb24gc2hvdWxkIGFuc3dlciB0
aGUgcXVlc3Rpb24gIldoYXQgaXMgdGhpcz8iLg0KPj4gQW5kIHRoZSBhbnN3ZXIgc2hvdWxkIGJl
IHNvbWV0aGluZyBsaWtlICJUaGUgc3RhdGUgb2YgdGhlIFBIWSAuLi4uLi4iDQo+IA0KPiBJdHMg
dGhlIHN0YXRlIG9mIHRoZSBzdGF0ZSBtYWNoaW5lLCBub3QgdGhlIHN0YXRlIG9mIHRoZSBQSFku
IEl0IGlzDQo+IGFscmVhZHkgZG9jdW1lbnRlZCBpbiBrZXJuZWwgZG9jLCBzbyB3ZSBkb24ndCBy
ZWFsbHkgd2FudCB0byBkdXBsaWNhdGUNCj4gaXQuIFNvIG1heWJlIGp1c3QgY3Jvc3MgcmVmZXJl
bmNlIHRvIHRoZSBrZG9jOg0KPiANCj4gaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvbmV0d29ya2lu
Zy9rYXBpLmh0bWwjYy5waHlfc3RhdGUNCg0KSSBhZGRlZCBsaW5rcyB0byB0aGUga2RvYyBsaWtl
Og0KDQovLy8gQ29ycmVzcG9uZHMgdG8gdGhlIGtlcm5lbCdzIFtgZW51bSBwaHlfc3RhdGVgXSho
dHRwczovL2RvY3Mua2VybmVsLm9yZy9uZXR3b3JraW5nL2thcGkuaHRtbCNjLnBoeV9zdGF0ZSku
DQoNCkJ1dCB0aGUgZmlyc3QgbGluZSBuZWVkcyB0byBhIHNob3J0IGRlc2NyaXB0aW9uIHNvIEkg
Y29weSB0aGUgQw0KZGVzY3JpcHRpb246DQoNCi8vLyBQSFkgc3RhdGUgbWFjaGluZSBzdGF0ZXMu
DQoNCkkgcmV2aXNlZCBhbGwgdGhlIGNvbW1lbnRzLg0K

