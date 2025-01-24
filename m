Return-Path: <netdev+bounces-160697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A801BA1AE4D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 02:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA05B1667B1
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576E1D514A;
	Fri, 24 Jan 2025 01:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laoTN4BK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991B60890;
	Fri, 24 Jan 2025 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737683470; cv=none; b=uiBKopJmsza0eleJoNr4Lmatw9IbQw0QXy4HZV+nTqWR+s629PT7hXtqftvu77UoeHvZRzwsh37IKSE8SWd5DFiHtWzqP8/MPlegYFy+bFU4SjPLWDKLe+yl2LG3yjYyAIxglWk8ems3YqZZsC2xWCh3O8hybytY4sP1yjA5QOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737683470; c=relaxed/simple;
	bh=i+amdNE0u8D8ChGqZ3qs6cRFJs6BsiNJwg022n6KT98=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=V24H4/t7kwPjb9rgCXJ4IewDQJpJZSMbPzbyVr5CI3b+As904EoRX5gfR6ht425kx/eAFMPFwfyQfDrr6SkPWI1Az8q5WmH5qGaZ+x7T+x+cbrLy7I1usxycDRmTd/9DlUUe443vFScaHRMOPkSFAvE9gs45xkq5PVU2LSfuslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laoTN4BK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163b0c09afso30295605ad.0;
        Thu, 23 Jan 2025 17:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737683468; x=1738288268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+amdNE0u8D8ChGqZ3qs6cRFJs6BsiNJwg022n6KT98=;
        b=laoTN4BKJCU+IGRict2UB0Dpzg8cEOzf3tcTnUpS4IKBoAYNk+1yc7+cMziTGvyTbN
         h9Krizq0v5941yHmtD6CNw8Flhk5JWdGpRsQZ/YE9Ovsi2RJm7rYiSMH8TWzsvW7boqu
         M51JEF7cTfoH9dJRalgdE1Wsnm1HR0SGSvP3KdBRcO9Jbq0u7lgQ77vGhQW/AY8n/cb+
         W9xms6ila7qgNXdVimlw6JSTQNJD6A2NxwntkB7QvtE/DrHtKAWcoKBAdT0iORnIgZhJ
         L6744JXWVdyN9NvbUJjOv6064g1YML8XFqObVHSHl6X1r9OKdkGc1/vLvdPDCm9xEh8c
         6OWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737683468; x=1738288268;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i+amdNE0u8D8ChGqZ3qs6cRFJs6BsiNJwg022n6KT98=;
        b=Vgaib5gZgQbXAuEhZy7ESM7sTed0bGfJP1JmDDTNTU58QWMq4jkSVPTsHLjEJ8Vw2B
         mgwKxdBIhrUaR5I+a5fvMWdN4gCDIgmiTk9nFiysjCGwBaxzc5hrCfWkwRAY2cSqijVw
         29UmkDTOcmIUpqnD6SNqEn2oUiF/wrJvL/7GJ2YjoPCxdNKTC9X4H3GZGJqYRyJ5BHMU
         1+VMA8m7iKhoxqxdsE6jbV8KKYbtA5T8Te4utylIfELJwC6XXzwW2PoTAdQ0YaCUEz2p
         OMj21OtZhxPPJNhmCLEXKcKn4fmS4BnFaQ+53ql+bwi0oSLaTcV++Pcqx9Oc5+NYN32Y
         Fp7g==
X-Forwarded-Encrypted: i=1; AJvYcCUV4rQnpwOiWhQ8DF20uXMiBAp1uivoEegr5N4brWOqi6Kk8ceVdF615comSVy8di3rT6b8+ws7e9CMHQO9yCY=@vger.kernel.org, AJvYcCUv6EEnV2ybO+zogeGx0rhyBXSt5KHK3ajhuwWsed4t49Fn9EJCnmiJ7dGQCaEplcfTcRHnrU6p@vger.kernel.org, AJvYcCXhLLIlzXeJ2+GjD8pgBxo/iK3ZFocBxE1YFrjSqXMINQ8NmD+0XZsn47+/2qiP0HebXhlvxiS+rfGIomU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/dH6zDSHDJoPCyHPLusKFhuhRaSu2EZuOaB0fLYcCo0cZBnN
	xYNAOjLI1g+TzeJO9tOwOwqz5B7rEOfQsrJpogVfwCT4ednKsF+E
X-Gm-Gg: ASbGncufL5UDhwawkyhgASVP1H7ZHLRRSPC/QyFET7BCYqPIB9UXOZEGKsOD/CVtTSG
	Mc2fbj8YjLpcTTKE8fVJ1tts+YYTXuXfrInhQ1tJbE7loimufxfp8KuiiYxDxu66xSwlMGzYszy
	+DfDQFtJRRarJZdqTbcv56pjePgo5CLO6QdqEmFpZI8aG2Yj8bo9C6JtcqmUROPG8fGLdvFm+4Y
	wCJvwtpCpDVzaDX9Qh++bNrvnzPyO8SVD8paVJwjLx9dBQQ3hQB7LR11Pf05qWr4VHB4Sb0X9Q2
	wYILUi0N75aXn6TN0LemfDdgplB0IWb6Ta/3rCqnH9bDNerGICok5SyORkljOlBM4uN13ajZ
X-Google-Smtp-Source: AGHT+IEnEOpMZd94Nvaj5D1v1KGJ51auz4R9U2AKF2YdxaLOKvxnXL2Sm9J23v0XcOBTj+ZOv/gHjA==
X-Received: by 2002:a17:902:c94d:b0:216:7175:41bd with SMTP id d9443c01a7336-21c355c0257mr396700635ad.39.1737683468300;
        Thu, 23 Jan 2025 17:51:08 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424eca8sm5497755ad.241.2025.01.23.17.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 17:51:07 -0800 (PST)
Date: Fri, 24 Jan 2025 10:50:58 +0900 (JST)
Message-Id: <20250124.105058.869129840829208535.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=vY3eZdsr12KfTCR6wGwrXyGZBk+1J7fsvg0t41ufYeA@mail.gmail.com>
References: <CANiq72m++27i+=H0KUaf=6fn=p29iueEV-+g8toctp0O0zEW+A@mail.gmail.com>
	<20250117.083111.1494434582668066369.fujita.tomonori@gmail.com>
	<CANiq72=vY3eZdsr12KfTCR6wGwrXyGZBk+1J7fsvg0t41ufYeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCAxOCBKYW4gMjAyNSAxMzoxNTo0MiArMDEwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBGcmksIEphbiAxNywgMjAy
NSBhdCAxMjozMeKAr0FNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWls
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gQXMgSSB3cm90ZSB0byBUb20sIHRoYXQncyB0aGUga2VybmVs
J3MgYXNzdW1wdGlvbi4gRG8gd2UgbmVlZCB0byBtYWtlDQo+PiBpdCBhbiBpbnZhcmlhbnQgdG9v
Pw0KPj4NCj4+IE9yIGltcHJvdmluZyB0aGUgYWJvdmUgIlJhbmdlIGZyb20gMCB0byBgS1RJTUVf
TUFYLmAiIGlzIGVub3VnaD8NCj4+DQo+PiBUaGUga2VybmVsIGFzc3VtZXMgdGhhdCB0aGUgcmFu
Z2Ugb2YgdGhlIGt0aW1lX3QgdHlwZSBpcyBmcm9tIDAgdG8NCj4+IEtUSU1FX01BWC4gVGhlIGt0
aW1lIEFQSXMgZ3VhcmFudGVlcyB0byBnaXZlIGEgdmFsaWQga3RpbWVfdC4NCj4gDQo+IEl0IGRl
cGVuZHMgb24gd2hhdCBpcyBiZXN0IGZvciB1c2VycywgaS5lLiBpZiB0aGVyZSBhcmUgbm8gdXNl
IGNhc2VzDQo+IHdoZXJlIHRoaXMgbmVlZHMgdG8gYmUgbmVnYXRpdmUsIHRoZW4gd2h5IHdvdWxk
bid0IHdlIGhhdmUgdGhlDQo+IGludmFyaWFudCBkb2N1bWVudGVkPyBPciBkbyB3ZSB3YW50IHRv
IG1ha2UgaXQgY29tcGxldGVseSBvcGFxdWU/DQoNCkluc3RhbnQgb2JqZWN0IGlzIGFsd2F5cyBj
cmVhdGVkIHZpYSBrdGltZV9nZXQoKSBzbyBpdCBzaG91bGRuJ3QgYmUNCm5lZ2F0aXZlLiBrdGlt
ZV90IGlzIG9wYXF1ZSBmb3IgdXNlcnMuIEhvd2V2ZXIsIHdlIHN1cHBvcnQgY3JlYXRpbmcgYQ0K
RGVsdGEgb2JqZWN0IGZyb20gdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0d28gSW5zdGFuY2Ugb2Jq
ZWN0czoNCg0KRGVsdGEgPSBJbnN0YW50MSAtIEluc3RhbnQyDQoNCkl0J3MgYSBzdWJ0cmFjdGlv
biBvZiB0d28gczY0IHR5cGVzIHNvIHRvIHByZXZlbnQgb3ZlcmZsb3csIHRoZSByYW5nZQ0Kb2Yg
a3RpbWVfdCBuZWVkcyB0byBiZSBsaW1pdGVkLg0KDQpJJ2xsIGFkZCB0aGUgaW52YXJpYW50IGRv
Yy4gSSdtIG5vdCBzdXJlIGlmIGFuIGludmFyaWFudCBkb2N1bWVudA0KaXMgdGhlIGJlc3QgY2hv
aWNlLCBidXQgaW4gYW55IGNhc2UsIHRoZSBhYm92ZSBpbmZvcm1hdGlvbiBzaG91bGQgYmUNCmRv
Y3VtZW50ZWQuDQo=

