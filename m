Return-Path: <netdev+bounces-135417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B26AF99DCA5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 05:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623E51F230AA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75016087B;
	Tue, 15 Oct 2024 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzxpRdsr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC3D4C8C;
	Tue, 15 Oct 2024 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728962220; cv=none; b=G4Q9Ji52v1x8rXT+hmqhr6OgE0fCp178UH8E5IsaXs1gliclU18AsVqa/1P3QXVwjSdu1HdSueLpSyuDDNdHItC0PQ9nzRhQGYmiMyFhlqokK487WALAkKkqylJMKjE+IWBH6ROKHfje3/Uh4bgyk5CAlX8JjKDZoKXlIWMlZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728962220; c=relaxed/simple;
	bh=Vy5+b03BWuS+g4Wcrm8bS07wpHcNGmDKzU4Frh3eis8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PWg6eiv27uY7LCvTFWUVxA4jwRoRpQXC8p/CnBNUAQEXFlwIGfdfCwQOum8KAy+YbYjGWoTCSKM81Vjsm5pC9UjO1f6qD4FCMesFpK6iS/IwdFJ3wYysX+cS2cUSKHq2BCJuvEqfrNPKl9ZrwYPEuePPXCKqep58r+Y7gRZVAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzxpRdsr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c693b68f5so49347995ad.1;
        Mon, 14 Oct 2024 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728962218; x=1729567018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xkYR7td2l+FeCuSLcJD66wuG7yiW4yRioWP8jk1sCVs=;
        b=EzxpRdsrBQEcWr+WMhj6lqepNjiCvhoOoEnrsWlJmIYVNSjGVlL7r10t8/n/E5z7p/
         n5EeSFrYMemmbxo9ibtIasJ1D5ZqAv8KOSakcrbHTWbqRZgdi75bv6uCSN5VyoqHgSpL
         VNXPgGm8oMSrswqyin+flf28h5IyyiX0rPdGPLHZNtWhBqj+qd/wKhVDuM7VeTizFEcM
         2aQD7yIwfnvfutyNb73pQrqJi029llzlI3hdm/8xBwKWqWe8uV0UXt038/4Aj9Y6q0H8
         NPCtK2BCFbk1hIhE8Gv8ZsXn8XLS+fAHdDM8hmewL35665ryBY3Fpl5BeRz6v1SuHvda
         0K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728962218; x=1729567018;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkYR7td2l+FeCuSLcJD66wuG7yiW4yRioWP8jk1sCVs=;
        b=SlqfIViq9XXhNO2mIV4dZpyc2VAH7XknUz4RlMCZhktz9AIHf6NwuCrnwpDdp8YON/
         pUWaJu0/Fd3Uwf9B8BaZ+mQCNscz2Id6uuIT3ttXwPaGAY98XQfl/VviP+pNKlFpdPfb
         o3JFa2VIYo5bwuAeudrgDP6YUmvTHoPSmTqqdgY3huXN8co4JkLjySqZKSRVXG2Fxf68
         xVboS6At0LfNz4tkhLR+o3fEOXcRL1x35O4M0dvzBeJ5Op/hNHMMzhruUh62TVDMI2I3
         4LM+QNBTuCoSXSJ+wWUXFCojMMkQclSkLs2rHLThbJSrGCeAaerV1ISYAgtExNN/MFIY
         CLaA==
X-Forwarded-Encrypted: i=1; AJvYcCVmTJffxAMmlXv2xMbAsSqUmARpYMHfqvKcTP2/ddNAEvQCMUPKj5oFjPZL5jaFlJJP6OjcIV9W@vger.kernel.org, AJvYcCVz2TbaclSBE/E/q1T/cOMtWwxujTdL7n0s2QoT0s0WmXJcA6tbmEW0uwLtk62tHrZqi3NRnotpSMoXK20=@vger.kernel.org, AJvYcCWBOlCP2QU/mXfpCfXxooaGLT10q2casd0MKDCm/hRKxTby656b5secM8JG8dUkq7drWdG+SkbLK0L/RxuFAFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4mAB3xV4pfGxxNlo8vJROwRQzuIDqvYpoPX+rXKKG2cJOEBt
	vPf+dYz9Mhl+TN1imz9E08hnpnMK6ttI68oA7pocirhiyi3FHC0T
X-Google-Smtp-Source: AGHT+IHfnyTgworhr6LYwqZjKuVR1XpcYvqTA1bM8IJkqIEMPsuzzH5ABHcOoQ0B+2FhYCQE8kAs/w==
X-Received: by 2002:a17:902:e845:b0:20b:b26e:c149 with SMTP id d9443c01a7336-20ca1467cf5mr192200905ad.29.1728962218285;
        Mon, 14 Oct 2024 20:16:58 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d1804b5cfsm2566795ad.205.2024.10.14.20.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:16:57 -0700 (PDT)
Date: Tue, 15 Oct 2024 12:16:42 +0900 (JST)
Message-Id: <20241015.121642.1320408148892534399.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jstultz@google.com, sboyd@kernel.org
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Zw2KwQbAAKZ_5lPL@boqun-archlinux>
References: <Zws7nK549LWOccEj@Boquns-Mac-mini.local>
	<20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>
	<Zw2KwQbAAKZ_5lPL@boqun-archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 14:18:57 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

>> This patchset adds Delta (also belongs to time, I guess) and fsleep to
>> rust/kernel/time.rs. I think that fsleep belongs to timer (because
>> sleep functions in kernel/time/timer.c). It's better to add
>> rust/kerne/time/timer.rs for fsleep() rather than putting both time
>> and timer stuff to rust/kernel/time.rs?
>> 
> 
> Good point. So how about putting fsleep() into rusk/kernel/time/delay.rs
> and add that into the "F:" entry of TIMER subsystem? Since "sleep"s are
> a set of particular usage of timers which don't directly interact with a
> timer or hrtimer struct, so I feel it's better to have their own
> file/mod rather than sharing it with timers. Plus this results in less
> potential conflicts with Andreas' hrtimer series.

Sure. I'll go with rust/kernel/time/delay.rs.

