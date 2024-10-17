Return-Path: <netdev+bounces-136432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65749A1B6B
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292C41F212BD
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73191C2339;
	Thu, 17 Oct 2024 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUEAsYYm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2C1779AE;
	Thu, 17 Oct 2024 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729149065; cv=none; b=gh1B/piCsjUFIsEPlSy/BZLXbS3LJKKYbUfHeUgp5jxM13wyhYjpWrksERM2TrTwZiI/908+dXPLkD6EXsXxO4SR31K86eK70tydVxdIjUjJBty0KvySnLsJC4IRMpOx4JBcy+kzjiB3ADNVjcbD5R8dCANGjp2bDV33t3cTAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729149065; c=relaxed/simple;
	bh=XUMkmnzAx5XwvZByS/iUxOhHmg9WghpsMFBk+L2XpTM=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jeb96DVJg0R2UaQCH+FhY+vOuIbU9J64nbnE99PCyiVvnstIykCMfEXxZSvd5h2MPy+k6dih+aV/Kqny0hfkZ3m8V7cA5goD/2XkwTj/m9VXYLKrL1vBmfZaUh3Ampz1mQyW/rtwPg81jXc/WeSaNmruyh6MNTsYBq8gu94K9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUEAsYYm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca7fc4484so4275725ad.3;
        Thu, 17 Oct 2024 00:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729149063; x=1729753863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUMkmnzAx5XwvZByS/iUxOhHmg9WghpsMFBk+L2XpTM=;
        b=CUEAsYYmYNeR5V9B+5cgJA2QeT5PC/GMWRZPIgPl3TkOzUGzcqTth7yJy8EXXvEIbC
         y9sq0n7NBc8EGwMgVsmaIGDCAVGwXturDjZqD9eV/SaVWOWWX8KSQ4NcoXN4hQdvWbQI
         qLJ5UC+7/8uepnW2r+Q07IPdEJHsjH/wVcFhKAVCGYFf+UxgyTfYAkutre9aRc2WO8u+
         LnZGJvJEqTceXqlDUoLvsBHXYTvDfY/UpgdRPdHMvOCD3Xb3G1W+1tHxBMg5w0BUUlXK
         avX0qtm7g3l7yA+AYLfZwODGtN/OT8z9LzRH4JQyTcMV3lNQsKY6kBEZ6tlKMH/kfcAk
         xYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729149063; x=1729753863;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XUMkmnzAx5XwvZByS/iUxOhHmg9WghpsMFBk+L2XpTM=;
        b=Og4trPPY82MDzZuybDcPF8wF5aijf9um8MXgIYe0dRxdgnPRMugpBIzWlZ9l2Fs6ll
         CVMSCaMem7CNmDBBHXnYrJ2GtnfNBIMu74aXi7/yZxYICCeC/R3KYXJYiY7xcXVPkteM
         PbDB0gRlgiGP2XqO2mTiQEymQ3Cttxwce7JwoJQNBwXOOWwCTlOp+cKTn+ymhHD09vUU
         kC9ZeP0nZGBKsSUc7kvM4z4X6JP1ruE/lF5UQ/5AnTxRsxE5K/T5/TqibajOnYzMez14
         kug9pgJWpPR2rD8yAxZ7KjrL0DDsuL3xMiVe7t9Nj4xyRnGQeHHTTaQABpHKqMtbb0f6
         3afA==
X-Forwarded-Encrypted: i=1; AJvYcCU5U4HVrj61IL2oqYprOhi2/cirst5geOUoUaYJcuCivF1BrHFcDT5LCqZ7KsD5B+IoyBCSf0LJ@vger.kernel.org, AJvYcCW92ySTxxLBzEdkAN5YnGuu6MRhCCDXQF5RgkNsTp5D88njnQRQxPLx3wNEYHpKORgoT4rtn46QuExNVnUXVuA=@vger.kernel.org, AJvYcCXk8Qkf6kOSyO19R0CvAHdphvTWf0WeTc5z+jEY2g3dN55wW8z7EZVdJ8unbEPlLn6YPJYgc09x31BqBxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoH7Or/VCFDN0BPYOObkchtvOfQcdic3FoT8GAP0bVn73iayr
	lYQdUxfi7UNHBmiaajYQ9dFRNBsrgit6AT2dj2XkFNEY1MkXxADd
X-Google-Smtp-Source: AGHT+IGYol31U8j2U7l9C1uZFBT+QAB9ZeBINyfi/GdRlGq2ruS1KKjjyBv16QkgsWhc0Qzne6vLcA==
X-Received: by 2002:a17:902:f70f:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-20cbb230588mr253917495ad.41.1729149063417;
        Thu, 17 Oct 2024 00:11:03 -0700 (PDT)
Received: from localhost (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d199d010csm37782495ad.157.2024.10.17.00.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:11:03 -0700 (PDT)
Date: Thu, 17 Oct 2024 16:10:50 +0900 (JST)
Message-Id: <20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's
 sub operation to Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
	<20241016035214.2229-4-fujita.tomonori@gmail.com>
	<CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gV2VkLCAxNiBPY3QgMjAyNCAxMDoyNToxMSArMDIwMA0KQWxpY2UgUnlobCA8YWxpY2VyeWhs
QGdvb2dsZS5jb20+IHdyb3RlOg0KDQo+IE9uIFdlZCwgT2N0IDE2LCAyMDI0IGF0IDU6NTPigK9B
TSBGVUpJVEEgVG9tb25vcmkNCj4gPGZ1aml0YS50b21vbm9yaUBnbWFpbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IENoYW5nZSB0aGUgb3V0cHV0IHR5cGUgb2YgS3RpbWUncyBzdWJ0cmFjdGlvbiBvcGVy
YXRpb24gZnJvbSBLdGltZSB0bw0KPj4gRGVsdGEuIEN1cnJlbnRseSwgdGhlIG91dHB1dCBpcyBL
dGltZToNCj4+DQo+PiBLdGltZSA9IEt0aW1lIC0gS3RpbWUNCj4+DQo+PiBJdCBtZWFucyB0aGF0
IEt0aW1lIGlzIHVzZWQgdG8gcmVwcmVzZW50IHRpbWVkZWx0YS4gRGVsdGEgaXMNCj4+IGludHJv
ZHVjZWQgc28gdXNlIGl0LiBBIHR5cGljYWwgZXhhbXBsZSBpcyBjYWxjdWxhdGluZyB0aGUgZWxh
cHNlZA0KPj4gdGltZToNCj4+DQo+PiBEZWx0YSA9IGN1cnJlbnQgS3RpbWUgLSBwYXN0IEt0aW1l
Ow0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZVSklUQSBUb21vbm9yaSA8ZnVqaXRhLnRvbW9ub3Jp
QGdtYWlsLmNvbT4NCj4gDQo+IFNvIHRoaXMgbWVhbnMgdGhhdCB5b3UgYXJlIHJlcHVycG9zaW5n
IEt0aW1lIGFzIGEgcmVwbGFjZW1lbnQgZm9yDQo+IEluc3RhbnQgcmF0aGVyIHRoYW4gbWFraW5n
IGJvdGggYSBEZWx0YSBhbmQgSW5zdGFudCB0eXBlPyBPa2F5LiBUaGF0DQo+IHNlZW1zIHJlYXNv
bmFibGUgZW5vdWdoLg0KDQpZZXMuDQoNClN1cmVseSwgd2UgY291bGQgY3JlYXRlIGJvdGggRGVs
dGEgYW5kIEluc3RhbnQuIFdoYXQgaXMgS3RpbWUgdXNlZA0KZm9yPyBCb3RoIGNhbiBzaW1wbHkg
dXNlIGJpbmRpbmdzOjprdGltZV90IGxpa2UgdGhlIGZvbGxvd2luZ3M/DQoNCnB1YiBzdHJ1Y3Qg
SW5zdGFudCB7DQogICAgaW5uZXI6IGJpbmRpbmdzOjprdGltZV90LA0KfQ0KDQpwdWIgc3RydWN0
IERlbHRhIHsNCiAgICBpbm5lcjogYmluZGluZ3M6Omt0aW1lX3QsDQp9DQo=

