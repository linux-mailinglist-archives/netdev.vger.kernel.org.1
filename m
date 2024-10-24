Return-Path: <netdev+bounces-138433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FF69AD8E9
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F45E1F23384
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 00:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB4749A;
	Thu, 24 Oct 2024 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpvfHnRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C0B848C;
	Thu, 24 Oct 2024 00:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729377; cv=none; b=T7Gcc1oaU2WX3p8/o7KMtcYtm4+XmCaaVVs6X6G2NAWQT2O/UuUlzbpWdSM3btL+CnNE7ymFYRzd5HXIfq1Pdl5HKkt4gIgdjEdbvhNCTqWCDVqcAQktUI+ZtXO4kF+X7feOqmnHg2F7CpU0hK/ufFodZ/Jt1VEcWTBfNa7kFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729377; c=relaxed/simple;
	bh=o/i0czh18H01Bh++/viBvqJsWZfb8X++LjTv5T5KwxA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tcUB9kZ/sLgCp05nKwriO/AzEFG0Lagf3/mAvp9maBmXf0VsTMiGstjDOiu4IYVQTq2alIrzdzkOIbH4jIO/reXKdkpxDrE8u0KjGqDj8MJIzfs3ncHFPJHtz65ZPcoOsNl8eyx1mK5iLEYkjhV8O0qWFZUxwy036uP0ySw5WoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpvfHnRl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e681bc315so274598b3a.0;
        Wed, 23 Oct 2024 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729375; x=1730334175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/i0czh18H01Bh++/viBvqJsWZfb8X++LjTv5T5KwxA=;
        b=GpvfHnRlhc1pM6pbQuRmmu7p09OKJEO2QkTym+S48Nr9jUNL99bN7/neCIPhbdyXDI
         fBuhJzvpX9RoVZ9G1CiXFz03D4psfEWb0MgNQmdA7akZ3lAqa7S++VOhhYnWS+bJtN2o
         7Yy3Vk7bvRtlqwBXmdNfCjDh/tZm0dgtFRBgABwzR/7/je+mVW0aWN9DQYz2IkHPE5kM
         HdtAc5D6jbJsPkuUQUX5PP0MvbVB09ovo8plKrRy8zyJ2lQ9985roHBlyzV7Wm4Y6A5Q
         wIAhOnC0wvJDExKjzXe53mql/t9e4qRS7tqv1lwc/x6byQuKejPvIPx6XqI8v5fqEtDb
         E37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729375; x=1730334175;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o/i0czh18H01Bh++/viBvqJsWZfb8X++LjTv5T5KwxA=;
        b=KEjvwUuyX7fIb6E2gMfFn3rO3xFXavVlX6nl3BRFxcMCsY+wCO58VoZOivt1zIpIl8
         0BQSMlkfX3+7aIg6szG0rtJFc0dS1c8JxV2KbLVvWlHcGRfGeNeY6TFDKdNaoEi9hJpy
         KLerByIXR9ZRYnieHWGGMMwXhFIsVnS/S1NC7dPsQVV6Yr9JrzNDFRx0IxoNGtw49lnB
         PBa74hALyvefnT1zeAHn9Ypwh2fR6Lo4lo3FmxHFnTvF/xf4WfsVHP5FZdkYOfeT+FmI
         MygRNHCcak97RXdMcNTX3IAPsEfXwVBfrq95ht1ZtmVHuJAAV11lRNCAwDMhg3H9dp+B
         rveA==
X-Forwarded-Encrypted: i=1; AJvYcCUDqCvX4VwL7suxb4fgQXXpKuqNfs/4qTN2s9v7ookBMzCGkjdv/CZti7lnEksVNSHCsDUGp0O6PswwdEo=@vger.kernel.org, AJvYcCVLEWRIxE+aaAk3CaEt9uxYEYIhNr5ua+ex0UOhvZE+0uvJgow/BuIaGIIXg9wRYM5CIRjGyrqWs4FpTrsa+nY=@vger.kernel.org, AJvYcCWRX98HMTgjz/ICcpC8RNqQ2/pg464jfUtrur6NOHorEVVS/divntD7MaaaZ1/jAVFL/11lg9ye@vger.kernel.org
X-Gm-Message-State: AOJu0YxBgVvSZaF4+sJdF/hIY/ipaugr4LK/HIWFW9s4fRKo0f6WXj2I
	iYx9EP+Txu5huvwMabqQMA10mk1za/T0kH1E8svj2cox96T08EyK
X-Google-Smtp-Source: AGHT+IHsiev09pNB8pqeGsewSHkIKAVMQz7zVum35IyU1VaOqBZ4LK4Z85lBsnr7xV6CC5bpnegQpg==
X-Received: by 2002:a05:6a00:22d4:b0:71e:5709:2330 with SMTP id d2e1a72fcca58-720452cf756mr560400b3a.7.1729729375113;
        Wed, 23 Oct 2024 17:22:55 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312e7dsm7156595b3a.11.2024.10.23.17.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:22:54 -0700 (PDT)
Date: Thu, 24 Oct 2024 09:22:48 +0900 (JST)
Message-Id: <20241024.092248.1743299714523375638.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 5/8] rust: time: Add wrapper for fsleep
 function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72mKJuCdB2kCwBj5M04bw2O+7L9=yPiGJQeyMjWEsCxAMA@mail.gmail.com>
References: <20241016035214.2229-6-fujita.tomonori@gmail.com>
	<CAH5fLgjTGmD0=9wJRP+aNtHC2ab7e9tuRwnPZZt8RN3wpmZHBg@mail.gmail.com>
	<CANiq72mKJuCdB2kCwBj5M04bw2O+7L9=yPiGJQeyMjWEsCxAMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxNiBPY3QgMjAyNCAxMTo0MjowNyArMDIwMA0KTWlndWVsIE9qZWRhIDxtaWd1ZWwu
b2plZGEuc2FuZG9uaXNAZ21haWwuY29tPiB3cm90ZToNCg0KPiBPbiBXZWQsIE9jdCAxNiwgMjAy
NCBhdCAxMDoyOeKAr0FNIEFsaWNlIFJ5aGwgPGFsaWNlcnlobEBnb29nbGUuY29tPiB3cm90ZToN
Cj4+DQo+PiBZb3UgcHJvYmFibHkgd2FudCB0aGlzOg0KPj4NCj4+IGRlbHRhLmFzX25hbm9zKCku
c2F0dXJhdGluZ19hZGQodGltZTo6TlNFQ19QRVJfVVNFQyAtIDEpIC8gdGltZTo6TlNFQ19QRVJf
VVNFQw0KPj4NCj4+IFRoaXMgd291bGQgYXZvaWQgYSBjcmFzaCBpZiBzb21lb25lIHBhc3NlcyBp
NjQ6Ok1BWCBuYW5vc2Vjb25kcyBhbmQNCj4+IENPTkZJR19SVVNUX09WRVJGTE9XX0NIRUNLUyBp
cyBlbmFibGVkLg0KPiANCj4gSSB0aGluayB3ZSBzaG91bGQgZG9jdW1lbnQgd2hldGhlciBgZnNs
ZWVwYCBpcyBleHBlY3RlZCB0byBiZSB1c2FibGUNCj4gZm9yICJmb3JldmVyIiB2YWx1ZXMuDQo+
IA0KPiBJdCBzb3VuZHMgbGlrZSB0aGF0LCBnaXZlbiAidG9vIGxhcmdlIiB2YWx1ZXMgaW4gYG1z
ZWNzX3RvX2ppZmZpZXNgDQo+IG1lYW4gImluZmluaXRlIHRpbWVvdXQiLg0KDQpEbyB5b3UgbWVh
biBtc2Vjc190b19qaWZmaWVzKCkgcmV0dXJucyBNQVhfSklGRllfT0ZGU0VUICgoTE9OR19NQVgg
Pj4NCjEpLTEpIHdpdGggYSB2YWx1ZSBleGNlZWRpbmcgaTMyOjpNQVggbWlsbGlzZWNvbmRzPw0K

