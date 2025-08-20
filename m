Return-Path: <netdev+bounces-215382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C8EB2E4D5
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 20:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08611CC0A45
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2CC271A7C;
	Wed, 20 Aug 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HA/ybv69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE124C07A
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755714113; cv=none; b=TnKMS7HXNKTmJlleheKla4/tzt+xlZJeFpvGe66e1I7j0H9Fvjtp0xCQ2EJd7vi6O0J1wcgIeORHn+P6beWeWZ4Pu7W5zWdagGTsDJc4SxU9YvEcoaCUrPbLsU9trIdrZNZiwQ+gQTY6SembLDLa3DM9B/iITKiqxgddjnvHPc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755714113; c=relaxed/simple;
	bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naTNiXMYAg4I0T/22Pb2hZgV1N6u5+5x7sC2QzlchVYozljrOmAhvSlCH0G+3cvTEH53iEZLhLfb2gR7RKneLvxnQnCXZXqMHr60a8y17gNCD7CfOkNcLd+4pMDQapgcYDQo+ORjvvi1B3/awiTHRLoUIVv9fRMxICl44NzuVtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HA/ybv69; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b1098f9e9eso3173331cf.0
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755714111; x=1756318911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
        b=HA/ybv69C2EJIgkjvUOPaQ4k5vqTGMzxIB3+668Yu0PmHIL5KF+F2X/lpW8TfzbejS
         74kwjRDHYnCErSbTFq3eGvj/j1AA6hHLJPkIhvjrTbtu6Jh08U2OVAApqrZ1YSvVhYSl
         xE2MUYUWYNzUnJEvhBmODfR1QNsE6N/oY+r6dhq2Bkh37SLPkh2O3/ZUJlldJSSfTO6p
         UKtc9+fDAGwEDkGn6RT9alr75JfnTjHR6vmoB/DoxlH/Hx1DNXvHZ8URob2IrFZ03iix
         UOOGtg/FSzkS0U/ANC/HcOt2OA0+Rq8fE8UTvvkqHBdYf2U4xAVYYQPoZsZj6c2uF+Bp
         LLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755714111; x=1756318911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u3eJc+Cr/HD2IRm8IYQ1qswckEy9jtZ6vbP4NpLR30=;
        b=lGf7krfWNuAnrUX3/Bj6IHz12xHCiVPsSi/XN/W1ONKSxOMYtxUcUQP9XgOcJbxa5j
         Da9Lyb/2+ueXgJmADFxgO4eznjagNCU7BdS0p5K2mBlbnTzy6uXUooSAmImxj15iE+iJ
         /q32NtnJi196yN5FweAeQw0Ka8cHfCxaFhMtVnTkyBy9FTkTSPFXZulpwdiOnQBkU1PL
         tgS5r+Ttmo69zfr5lJVaO7UZyqm++jpQ5sxq/DVYOxV/hLGdwLI6OikQpNFMtlB00+wd
         TK8XI87qOf3xw3HmQcAVK4p36vf3THiojxSZYyerO2B8QoSYA++z/j6ONvRWMKfqetnM
         4n9g==
X-Gm-Message-State: AOJu0Ywcfsc4afXtEGOy2F8GBHi+4jXmNGDY71Fkl0m+JSxAb1Y6fCk8
	UgmChS9HPEqZt4Fyf52OgH0lkiM3Ifrxp6p1jUJ6Zb1nv0NS+b1tB9KmmvOWwgNPXXaDcuBrsvo
	/hVcNTI98bA8KM4SJkx197DufCDN7m/ocGwUJJ1q1PSvTi+ij4rBAW3nw
X-Gm-Gg: ASbGnctpGWKkzebn127b/FhsUNABEHRa5j9w6LM1fmEumAU3QdMCNmg4DymYgoy4Gef
	TLjYrPlgWMfrQzkU0nZSbnJr6Na16HxP0EVgMKZY9VIYuDEg6yo9K32TJgvj7qPWvQsLD+CAHw6
	8x4sCYE5fsTq062f2W0B1LWe1ZrxoQBV+pDAhw0VLMSfM+LfkbkUHjZrtWsGggfQvArzFMCupa+
	qej3kPkanxSCFpWTGcagzuIFg==
X-Google-Smtp-Source: AGHT+IFtN+kEQBkHVHFlDdHu9xL7iEVvs85IioqCBHEdG4+4w39Pga2xsI9hPIBI84cgx4pD5AL0C4f9XVOfwzVus+0=
X-Received: by 2002:a05:622a:1cc9:b0:4b2:8ac5:27c3 with SMTP id
 d75a77b69052e-4b291c40309mr49861031cf.78.1755714110904; Wed, 20 Aug 2025
 11:21:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819082842.94378-1-acsjakub@amazon.de>
In-Reply-To: <20250819082842.94378-1-acsjakub@amazon.de>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 11:21:39 -0700
X-Gm-Features: Ac12FXwJD1Q9uldV_MwNTRIlw_umA48L2xrMHQZoMdQq8LUL1LtWz7MkR21uLbw
Message-ID: <CANn89i+pRcoUO5_VeS9evwPJrNaa=8H2=p7=Fo3oJCENV0019g@mail.gmail.com>
Subject: Re: [PATCH] net, hsr: reject HSR frame if skb can't hold tag
To: Jakub Acs <acsjakub@amazon.de>
Cc: netdev@vger.kernel.org, aws-security@amazon.com, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, security@kernel.org, 
	stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

T24gVHVlLCBBdWcgMTksIDIwMjUgYXQgMToyOOKAr0FNIEpha3ViIEFjcyA8YWNzamFrdWJAYW1h
em9uLmRlPiB3cm90ZToNCj4NCj4gUmVjZWl2aW5nIEhTUiBmcmFtZSB3aXRoIGluc3VmZmljaWVu
dCBzcGFjZSB0byBob2xkIEhTUiB0YWcgaW4gdGhlIHNrYg0KPiBjYW4gcmVzdWx0IGluIGEgY3Jh
c2ggKGtlcm5lbCBCVUcpOg0KPg0KPiBbICAgNDUuMzkwOTE1XSBza2J1ZmY6IHNrYl91bmRlcl9w
YW5pYzogdGV4dDpmZmZmZmZmZjg2ZjMyY2FjIGxlbjoyNiBwdXQ6MTQgaGVhZDpmZmZmODg4MDQy
NDE4MDAwIGRhdGE6ZmZmZjg4ODA0MjQxN2ZmNCB0YWlsOjB4ZSBlbmQ6MHgxODAgZGV2OmJyaWRn
ZV9zbGF2ZV8xDQo+IFsgICA0NS4zOTI1NTldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQ0KPiBbICAgNDUuMzkyOTEyXSBrZXJuZWwgQlVHIGF0IG5ldC9jb3JlL3NrYnVmZi5j
OjIxMSENCj4gWyAgIDQ1LjM5MzI3Nl0gT29wczogaW52YWxpZCBvcGNvZGU6IDAwMDAgWyMxXSBT
TVAgREVCVUdfUEFHRUFMTE9DIEtBU0FOIE5PUFRJDQo+IFsgICA0NS4zOTM4MDldIENQVTogMSBV
SUQ6IDAgUElEOiAyNDk2IENvbW06IHJlcHJvZHVjZXIgTm90IHRhaW50ZWQgNi4xNS4wICMxMiBQ
UkVFTVBUKHVuZGVmKQ0KPiBbICAgNDUuMzk0NDMzXSBIYXJkd2FyZSBuYW1lOiBRRU1VIFN0YW5k
YXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2ZWQ2Yjcw
MWYwYS1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+IFsgICA0NS4zOTUyNzNdIFJJUDog
MDAxMDpza2JfcGFuaWMrMHgxNWIvMHgxZDANCj4NCj4gPHNuaXAgcmVnaXN0ZXJzLCByZW1vdmUg
dW5yZWxpYWJsZSB0cmFjZT4NCj4NCj4NCj4gVGhpcyBpc3N1ZSB3YXMgZm91bmQgYnkgc3l6a2Fs
bGVyLg0KPg0KPiBUaGUgcGFuaWMgaGFwcGVucyBpbiBicl9kZXZfcXVldWVfcHVzaF94bWl0KCkg
b25jZSBpdCByZWNlaXZlcyBhDQo+IGNvcnJ1cHRlZCBza2Igd2l0aCBFVEggaGVhZGVyIGFscmVh
ZHkgcHVzaGVkIGluIGxpbmVhciBkYXRhLiBXaGVuIGl0DQo+IGF0dGVtcHRzIHRoZSBza2JfcHVz
aCgpIGNhbGwsIHRoZXJlJ3Mgbm90IGVub3VnaCBoZWFkcm9vbSBhbmQNCj4gc2tiX3B1c2goKSBw
YW5pY3MuDQo+DQo+IFRoZSBjb3JydXB0ZWQgc2tiIGlzIHB1dCBvbiB0aGUgcXVldWUgYnkgSFNS
IGxheWVyLCB3aGljaCBtYWtlcyBhDQo+IHNlcXVlbmNlIG9mIHVuaW50ZW5kZWQgdHJhbnNmb3Jt
YXRpb25zIHdoZW4gaXQgcmVjZWl2ZXMgYSBzcGVjaWZpYw0KPiBjb3JydXB0ZWQgSFNSIGZyYW1l
ICh3aXRoIGluY29tcGxldGUgVEFHKS4NCj4NCj4gRml4IGl0IGJ5IGRyb3BwaW5nIGFuZCBjb25z
dW1pbmcgZnJhbWVzIHRoYXQgYXJlIG5vdCBsb25nIGVub3VnaCB0bw0KPiBjb250YWluIGJvdGgg
ZXRoZXJuZXQgYW5kIGhzciBoZWFkZXJzLg0KPg0KPiBBbHRlcm5hdGl2ZSBmaXggd291bGQgYmUg
dG8gY2hlY2sgZm9yIGVub3VnaCBoZWFkcm9vbSBiZWZvcmUgc2tiX3B1c2goKQ0KPiBpbiBicl9k
ZXZfcXVldWVfcHVzaF94bWl0KCkuDQo+DQo+IEluIHRoZSByZXByb2R1Y2VyLCB0aGlzIGlzIGlu
amVjdGVkIHZpYSBBRl9QQUNLRVQsIGJ1dCBJIGRvbid0IGVhc2lseQ0KPiBzZWUgd2h5IGl0IGNv
dWxkbid0IGJlIHNlbnQgb3ZlciB0aGUgd2lyZSBmcm9tIGFkamFjZW50IG5ldHdvcmsuDQo+DQo+
IEZ1cnRoZXIgRGV0YWlsczoNCj4NCj4gSW4gdGhlIHJlcHJvZHVjZXIsIHRoZSBmb2xsb3dpbmcg
bmV0d29yayBpbnRlcmZhY2UgY2hhaW4gaXMgc2V0IHVwOg0KPg0KPiDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJAgICDilIzilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJANCj4g4pSCIHZldGgwX3RvX2hz
ciAgIOKUnOKUgOKUgOKUgOKUpCAgaHNyX3NsYXZlMCAgICDilLzilIDilIDilIDilJANCj4g4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSC
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiDilIzilIDi
lIDilIDilIDilIDilIDilJANCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAg4pSc4pSA4pSkIGhzcjAg4pSc4pSA4pSA4pSA4pSQDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIOKUgiDilJTilIDilIDilIDilIDilIDilIDilJggICDi
lIINCj4g4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSQICAg4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSQICAg4pSCICAgICAgICAgICAg4pSC4pSM4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSQDQo+
IOKUgiB2ZXRoMV90b19oc3IgICDilLzilIDilIDilIDilKQgIGhzcl9zbGF2ZTEgICAg4pSc4pSA
4pSA4pSA4pSYICAgICAgICAgICAg4pSU4pSkICAgICAgICDilIINCj4g4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAg4pSU4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSYICAgICAgICAgICAgICAgIOKU
jOKUvCBicmlkZ2Ug4pSCDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICDilILilIIgICAgICAgIOKUgg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSC4pSU4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSYDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICDilIINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkCAgICAgIOKUgg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSCICAuLi4gIOKUnOKUgOKUgOKUgOKUgOKUgOKU
gOKUmA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg4pSU4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSYDQo+DQo+IFRvIHRyaWdnZXIgdGhlIGV2ZW50cyBsZWFkaW5nIHVw
IHRvIGNyYXNoLCByZXByb2R1Y2VyIHNlbmRzIGEgY29ycnVwdGVkDQo+IEhTUiBmcmFtZSB3aXRo
IGluY29tcGxldGUgVEFHLCB2aWEgQUZfUEFDS0VUIHNvY2tldCBvbiAndmV0aDBfdG9faHNyJy4N
Cj4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBKYWt1YiBBY3MgPGFjc2pha3ViQGFtYXpvbi5kZT4NCj4g
Q2M6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCj4gQ2M6IEpha3ViIEtpY2lu
c2tpIDxrdWJhQGtlcm5lbC5vcmc+DQo+IENjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5j
b20+DQo+IENjOiBzZWN1cml0eUBrZXJuZWwub3JnDQo+IENjOiBzdGFibGVAa2VybmVsLm9yZw0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZw0KPiAtLS0NCg0KUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29v
Z2xlLmNvbT4NCg==

