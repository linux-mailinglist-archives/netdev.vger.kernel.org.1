Return-Path: <netdev+bounces-132586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E6F992458
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 08:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A06B21134
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 06:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FDC14B06C;
	Mon,  7 Oct 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKKYH/U9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6460148828;
	Mon,  7 Oct 2024 06:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281846; cv=none; b=U2/wEByUAubEUDUXS/fjOynOU9W0HJfMzkgy+VTvpM1vQqVb6q/aK4CWlFp0v7udq1G5VwIl2aiYfHSvP1a0ppcQG31o2gAvFY+Mtd6s8K0wqnZeRaKg5LyTGgYZoS7OhoYC6pGTXc8xQYFn2UCCth9ZqvOt8+T4UM/jV+GRgAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281846; c=relaxed/simple;
	bh=gjxH3KMp6SBAKNKlE+PNtyiP5iNEs7Prz6/7y5O0qg8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=L4Z2lC/U8JzoU76Rgz2KzVSrd07/cgr+FKV1ZIqCePrHE2gtKhuEqbOByszrzhJMLc59us1JA5NDKRdQPcW+ms8kHytNQCyvITa/OSg183WjvV6InYzmMLQcWK9HeXDw0bp6ulpWdGD6uLIvP87m+ln0PvcajX7ESsSMkDToXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKKYH/U9; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-710e489860bso2071749a34.1;
        Sun, 06 Oct 2024 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728281844; x=1728886644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjxH3KMp6SBAKNKlE+PNtyiP5iNEs7Prz6/7y5O0qg8=;
        b=WKKYH/U9Lz84YzdY+S3LnD1yfVyZXDFxazRt1woeujIWt0V98q5yORe+sFtcTZqvc7
         Gvtb5IjkjYw1kvRYFh/7Bh1Dd5hW6Q5V8dUo1qP8gBpau1sxlkgZPlaBE7Ab6sxQea1A
         LPl83ciDFa+bkhRHEUs+UoSOzcHhdtTyHjnglKlU4siZ9VRQJh89vNbgKfZE9cXjHM7L
         5I3ecDDEUDULWk6m91kN1EHXS1COLP3OJY6GOotyLrYCnPqV2ZahoiWaW5YBKarleg94
         AXDxyO9JSfnQLAbDZAhaNrY2vzsOg1W/YAkpb+h1eojWmvEmGbZVxSq/DR4A0gnsSoby
         CrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728281844; x=1728886644;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gjxH3KMp6SBAKNKlE+PNtyiP5iNEs7Prz6/7y5O0qg8=;
        b=vlX8zc+QtSTcy2VPJksK4oNqNPefaLVc+8f41m1VetnVHWXP7cYxMAvXgT9xao6Epl
         IenbjJAFziIfpLvzAJy4XLzHULGP11qiQlEJCUQV1s/l33Csjhji3VNL95j6FL2r244R
         CVyQyYymcXe7QCM3dVtGQkF/GtRKIYmWECNVVyr0pPMKHMwRNtvADJidmc/GveN2wuJZ
         XGSkhCf5RoO6g9fdi2JEsdMFy6L8N3e8kfXrJF38Cp5UHlhwW+m5KGY3FhFMKeQa+8OC
         DJnEatjxj/FSWuzj3h+jrz61N9cQ829/J2wD+7qtSRaL9Sc8Xz7vr4438QRqznqa4z6/
         OAaw==
X-Forwarded-Encrypted: i=1; AJvYcCVlB5L1ZGLFvpA6zynKuTkjmI5x5Pbz2vzdfw+DI0uaBFoc1m9lqrwYbqYwmUoMimqoncRT31Mq1IkpINaSLIA=@vger.kernel.org, AJvYcCWzGtK65HUh7A3rAOOSfjHNNj/bDfT7Cme9pswD0el0t2TUC5EYMNmv3ZvVYHDf3oW0uBVO90AblxheB14=@vger.kernel.org, AJvYcCXiVHtEjTGx0104qhsp9rEsk8O6HP28quxsf58twxHCrEoDbwzei0obzsLThGXfIUkr4YKSWtyn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj2xcGcsPkmH/sP321TW5OA82erfk20VX07cxlaT4BAJuuXDG
	KQd0xo9GeLg+589hr6B5MJLeq0B7f1X8vzEvwBwdKNYjY0ZjKXWw
X-Google-Smtp-Source: AGHT+IHKHE9JKs9exCA3eMTf2jx5LCKophpwq+oZk1RZDvfFprLE33eNFEDu2VVEi7gTGrVv4mfzHA==
X-Received: by 2002:a05:6358:52d2:b0:1b8:37c3:9a00 with SMTP id e5c5f4694b2df-1c2b7f042e7mr343423855d.4.1728281843814;
        Sun, 06 Oct 2024 23:17:23 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6821c32sm4200760a12.33.2024.10.06.23.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:17:23 -0700 (PDT)
Date: Mon, 07 Oct 2024 15:17:07 +0900 (JST)
Message-Id: <20241007.151707.748215468112346610.fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/6] rust: time: Implement addition of
 Ktime and Delta
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
	<20241005122531.20298-4-fujita.tomonori@gmail.com>
	<CANiq72=YAumHrwE4fCSy2TqaSYBHgxFTJmvnp336iQBKmGGTMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCA1IE9jdCAyMDI0IDIwOjM2OjQ0ICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFNhdCwgT2N0IDUsIDIwMjQg
YXQgMjoyNuKAr1BNIEZVSklUQSBUb21vbm9yaQ0KPiA8ZnVqaXRhLnRvbW9ub3JpQGdtYWlsLmNv
bT4gd3JvdGU6DQo+Pg0KPj4gKyAgICBmbiBhZGQoc2VsZiwgZGVsdGE6IERlbHRhKSAtPiBLdGlt
ZSB7DQo+PiArICAgICAgICAvLyBTQUZFVFk6IEZGSSBjYWxsLg0KPj4gKyAgICAgICAgbGV0IHQg
PSB1bnNhZmUgeyBiaW5kaW5nczo6a3RpbWVfYWRkX25zKHNlbGYuaW5uZXIsIGRlbHRhLmFzX25h
bm9zKCkgYXMgdTY0KSB9Ow0KPj4gKyAgICAgICAgS3RpbWU6OmZyb21fcmF3KHQpDQo+PiArICAg
IH0NCj4gDQo+IEkgd29uZGVyIGlmIHdlIHdhbnQgdG8gdXNlIHRoZSBga3RpbWVgIG1hY3Jvcy9v
cGVyYXRpb25zIGZvciB0aGlzIHR5cGUNCj4gb3Igbm90IChldmVuIGlmIHdlIHN0aWxsIHByb21p
c2UgaXQgaXMgdGhlIHNhbWUgdHlwZSB1bmRlcm5lYXRoKS4gSXQNCj4gbWVhbnMgaGF2aW5nIHRv
IGRlZmluZSBoZWxwZXJzLCBhZGRpbmcgYHVuc2FmZWAgY29kZSBhbmQgYFNBRkVUWWANCj4gY29t
bWVudHMsIGEgY2FsbCBwZW5hbHR5IGluIG5vbi1MVE8sIGxvc2luZyBvdmVyZmxvdyBjaGVja2lu
ZyAoaWYgd2UNCj4gd2FudCBpdCBmb3IgdGhlc2UgdHlwZXMpLCBhbmQgc28gb24uDQoNClllYWgs
IGlmIHdlIGFyZSBhbGxvd2VkIHRvIHRvdWNoIGt0aW1lX3QgZGlyZWN0bHkgaW5zdGVhZCBvZiB1
c2luZyB0aGUNCmFjY2Vzc29ycywgaXQncyBncmVhdCBmb3IgdGhlIHJ1c3Qgc2lkZS4NCg0KVGhl
IHRpbWVycyBtYWludGFpbmVycywgd2hhdCBkbyB5b3UgdGhpbms/DQo=

