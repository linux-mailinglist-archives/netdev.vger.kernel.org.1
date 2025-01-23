Return-Path: <netdev+bounces-160498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D642A19EF4
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 08:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ED23ADAB3
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F274E20B7FD;
	Thu, 23 Jan 2025 07:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1TlyuuW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07920B7F9;
	Thu, 23 Jan 2025 07:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737617405; cv=none; b=hszaSc/7RxDRKQkcTkUpkL2p00kNG7iIeC81sxeF8OOKZn7AG2Rq/nrcW+YaPDXc2WUr88l+fH/5P8+ti3aA57ELg9Pca0hhF3U5IoA7r3rQligJBKuxI1n0RzAVZ72OpImundvL26yAh/iT5BrKoEcHo8Mfq3ozP9kW6qG+JcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737617405; c=relaxed/simple;
	bh=8wIUWRleAJl/I3w9xAtnwjP1dwhnjToxJNMmVKMjapI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZPmEMYnNiZyZTphInmKPT2cdqbRRN/880Y6rccjBnIcTqoHwytI4D8pnWjDeeeTs2TFA3KBynZ4WF4MxutT918jFR+waJtllQzTCj28CcYMKT5uyNXqWzxhxnSIo5461lqaZ2uswFabpBpRVfOWmWAO409PI9N6o0ZYQ8qhZBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1TlyuuW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef28f07dbaso915015a91.2;
        Wed, 22 Jan 2025 23:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737617403; x=1738222203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceNonhB99Ue99Hp33lMgol+NGBL9sA13QyEPHHCOh0E=;
        b=I1TlyuuW0+A73FK59s053dilKqLXhM6w9DtTuetnI/nWM0dYgK5zeD0MYfBdgRJsJ6
         Kx3L+97Yt18TNzoMzGteB53EBpcmExtZhS8KSS+iUEc4y8Aa0d/MxlLnQbdiKGFrvdP4
         WvTHIsJufnDOgrAT7PCMePezoEvjqpI+FP7HATmcqzfHB6D6A0C2Sd9aDois1+hEChMk
         lua/9q7papHs0eCniERH3ZP34hhrWj8MzuZ0K1t0D0vpWMxxpobl8DibIg5uoY+mhG9S
         YIDdGmrvx/p21NKDzZq+LccSvK6/CarCL9NGeId8Ii1l1yna1wAQyyMoEHqipGsMfloX
         E6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737617403; x=1738222203;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ceNonhB99Ue99Hp33lMgol+NGBL9sA13QyEPHHCOh0E=;
        b=d9fVzewigW/LcwoJCPcPMH+Ki/s5X2fU6CcSaAaYVv0HLbx9T0xzx8U8HjhyTK5DZd
         rbGJHLO5xa4ztUcFcvaTrGBKz8EmJnhHqZs//oORhU6t4fZbzbjF+20Jp4O39eAAg5XI
         L8lS+I+mtegLePWW6nURm6Ec8VLosvr7sAU7BXtE+36hm6DxGCE8eZ7hS7aZr57EAkxR
         DAui4Tt96H5pxKdVPhmK3MTvzKWNEZGaZ2bjhqwlf/QQ6OvBNSI5BMX5NMicc94oYHlV
         MQ6cgdNFSFxraBAT8AW9zCjJCyDzUKsO+0OqhWyzwk5IA24yBR03FQjdjmMsm7VXS/zb
         xfPg==
X-Forwarded-Encrypted: i=1; AJvYcCVnaCK/3/9E7LKxZVy5l61cOIRcKoqOfLBlew/dBK2tIgBg8r8fH3Sg8qqd3G02M6+6oYcefgzB@vger.kernel.org, AJvYcCW6t04RnpYPMgyrGLhTUO/NxWaB4O3MGEk9ashu6mIz9AvdKSu38ZjV1d2XGK96+eWnRc8J617pYEGkTmE=@vger.kernel.org, AJvYcCWLmwVfTKSybVI9f46+7REbQDyyMJTPwNQ5hoBzLilVZteJYrDXac/50mjyZw5AKhzn07VSjyT9/Quu4mFeFMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI6U2T6fivY9F4EaDLq2059uBf+mLKzfHRsgZKiRnzDvNgoYZv
	mqFCS92rfZ6ZepcI8v0Gor6ad2D7b3uSAw07TKrURnRG56tf6F12
X-Gm-Gg: ASbGncvdh0o6cGbfNkEZ/1U0bB7DSRkvRib0+ZEsRN5QTjXxu71rBrQgwIlGBP98pFX
	xR15sR9IYSw4h0k4TBQJ2MLOQK5/+511pA1UH65DaXGFcI8TENDIQy1IGn2Od91HrMppUfRtLYq
	rX2TCEKfRuWZ24ARuSM04oZaaD87xjYduIHgi052kXoH7hq+jL2hYH6T/2rO4KYhJknpm+cP1Ym
	CIGozD6rDYDoRObV1gKji+NxR6rSepKBThBeSAdhObNsf03SclZIT8EKlz5XzSnwqcbNbJC+80F
	B/ZGmaWLOpbEuFKFR7itOz7HyKMi8BCX64JSoyp+WuJF8Xy8AlqS5YgDBJj0OA==
X-Google-Smtp-Source: AGHT+IGgJEEY2fGYxnhEALflskADXUIN88Cj8MuBBCz6FtXxIsTDrMlOpzda6kUQdSB5RFDIBGpEEQ==
X-Received: by 2002:a05:6a00:190c:b0:729:1b8f:9645 with SMTP id d2e1a72fcca58-72dafbd02ecmr41151029b3a.24.1737617403150;
        Wed, 22 Jan 2025 23:30:03 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f0b0dsm12206881b3a.30.2025.01.22.23.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 23:30:02 -0800 (PST)
Date: Thu, 23 Jan 2025 16:29:53 +0900 (JST)
Message-Id: <20250123.162953.1064418483128096795.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: gary@garyguo.net, fujita.tomonori@gmail.com,
 linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 6/7] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CAH5fLgiMnifHoEkExSQVcv+7amO5aXSqd9kaGfM5af4eapcHzA@mail.gmail.com>
References: <20250116044100.80679-7-fujita.tomonori@gmail.com>
	<20250122183612.60f3c62d.gary@garyguo.net>
	<CAH5fLgiMnifHoEkExSQVcv+7amO5aXSqd9kaGfM5af4eapcHzA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 22 Jan 2025 21:14:00 +0100
Alice Ryhl <aliceryhl@google.com> wrote:

>> > +#[track_caller]
>> > +pub fn read_poll_timeout<Op, Cond, T: Copy>(
>>
>> I wonder if we can lift the `T: Copy` restriction and have `Cond` take
>> `&T` instead. I can see this being useful in many cases.
>>
>> I know that quite often `T` is just an integer so you'd want to pass by
>> value, but I think almost always `Cond` is a very simple closure so
>> inlining would take place and they won't make a performance difference.
> 
> Yeah, I think it should be
> 
> Cond: FnMut(&T) -> bool,
> 
> with FnMut as well.

Yeah, less restriction is better. I changed the code as follows:

#[track_caller]
pub fn read_poll_timeout<Op, Cond, T>(
    mut op: Op,
    mut cond: Cond,
    sleep_delta: Delta,
    timeout_delta: Delta,
) -> Result<T>
where
    Op: FnMut() -> Result<T>,
    Cond: FnMut(&T) -> bool,
{

			  

