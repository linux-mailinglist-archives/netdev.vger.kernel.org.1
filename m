Return-Path: <netdev+bounces-160271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61079A191B6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E939C7A4BC0
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131D5212D72;
	Wed, 22 Jan 2025 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOD6JdNO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01F20FA8A;
	Wed, 22 Jan 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737550172; cv=none; b=G4ncpxITEnCd4iPmdYe0pIwFvVRkbpCRzYMA8/d1tlRkyoJW/LOMYM7EN2JLDfck1inAFsrDqKvfiUB3sPWvJCXqQTJeDcMUItEVvxqpU/I3AVl0AuOyCUygQBcjmcwKYu39pYT/Jgh6m7HFCzZX+GJaisd6abm0rlOeTZa8pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737550172; c=relaxed/simple;
	bh=fulkn0CZ8dAX8ZJi6q40SCLWotSdfPTnPt/YSJVSi7M=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J8zBFZ+KLR9VvBO7oF1kYCMYb4XevvmWK5F+nyk8CJZ6JevbKDLF8FQQCnTZmYEoT/9IhoxnvjqC8c/q8q0lw3r37s8ZTiOhp4A8PcirkeVtcwxtGCWAHQcuxtL96aLponlm+BGXmGnmjTFQwjzFwYm7O0iofQt3ol+GvQgEIrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOD6JdNO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21644aca3a0so153860105ad.3;
        Wed, 22 Jan 2025 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737550170; x=1738154970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/tW6RLUcA52NhRJWU9merpmr82Jkd0q1UsX6dibBJQ=;
        b=KOD6JdNOEkcuDP9HSMyZGduOEzaHj1FjyZd781B/zfo1N+Ra91NuznVLKznMypx25w
         gbMfAXQeGvwO+Cz9idm6RC/FAZavjYPwTN9rcTHwmNBgqFbGcyByclpA7QLYbqMaL1QW
         XLTcbF7Nfg/RQrfpVu7hpXFehNDEb+CVO/wX3gNWIcLDscpVEm7CoTfIzNIdw/+EUh0Y
         xxcCqAl1Kf8rB0rfcMzOwUEQN3GcJlVjEK/QCwdbtOHF86ZkXzQNpMgWCWYyhdVfoJ0q
         cmyzFrfh7JTu3nAJzxlQw49NT9dtKQKBdO/aLFYDgFUCSgSwZdnLnXip72IiZIEvqX1S
         NhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737550170; x=1738154970;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C/tW6RLUcA52NhRJWU9merpmr82Jkd0q1UsX6dibBJQ=;
        b=MYt/nTvsSj4KoF9rX1GzQRFhW+Ja5yuuqt1tWmENJ0yaSeyak3InBu9ZIyH3opqtX1
         QUCnrc/N7/ysmRowRuiWuwft4AIPQBL0/Dus2YxuPOd/7SxUm3uVte2IHR6zNwJ8q969
         yVKZmails/CmXepuQZijK6x5uidiHF1vba6fycOQUE2UECXEMd5qpjC5rqzEQ7h0R9LM
         53FFp0GzV4LDvxD5S/llN1ekKZ7sOGtVVR3EPEbNrT4JIeoWNO3PXkC+Vu6OMv9fLeRZ
         fT0gn+kZOgoq0AQlEjjYVXGi6WxgcBkAZYzRaUgt0KcKvX9mLoWSRkfEDkkmobUIXvE4
         0BgA==
X-Forwarded-Encrypted: i=1; AJvYcCUHsE7TvIVp2Qt9omw/CQhcNIfU0uKi7g0z8K0hiNf+lvjEEq4QtME+A9TTrupSRJjr7I2KewwCG6q1c3Q=@vger.kernel.org, AJvYcCUyxDw9QB9VwuzzzrPbzGTyQM8Bn2c7l/xIu6hvkuN1aPzwqjyhT7ueV2x6Wzu5FeV4o5FdToJx@vger.kernel.org, AJvYcCXaUaEoFi/DZDdQ+wGiYy3qXjl+jf+y+jPrnwzHZc8PrZoTrorMSmD1QMt1+5hMn1tOYB7vx8cYXSPfchzwIjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpsAC3DPPbVy17e/N59GKFELjzzcJ6DWZeVSMkvJs/OASU09Rp
	hP5LbM7hHgwBVS9SX8eXRp35JpEyvnZo+ISMSK1b85jNgs86AnYV
X-Gm-Gg: ASbGncuFzLWOJfdzQerJz7WWdQW6ZRDSVJ1NSUhgoWt35CkqKYR1Y5F6mTwo3BG0xnd
	bQ+JmXtB7bqD3YOZ80q8SS5d1XLykT6gv1soABMt3EcqT7EWR1YwkTMpQldgfw6lzqnEoKvxuTv
	R1lcE2Az4fL3kqg9FEEnmVPRWpt3DmSF8slI8EZ2pvnZ/+KSgtjrZK3Rfz1rPYBPR3Z5WuE8DKR
	WgQcvGmo5kOrhCeFigUGRzus52F5FT5VyyxdRMwZ1ypauL0XrIEieRKrkBwi/JbEz2RguqGESmZ
	ToFDcn41CkdA6sEel5JT2MbGI7PmJz0sIgbAx8a3H1dVMuB9Diw=
X-Google-Smtp-Source: AGHT+IGWvRDmGu4hGMbEgJxA/MZfPrakPsojxGXFWOy202xxw7bV+CC54VPXxCUo+XnZx98Fxx+O1g==
X-Received: by 2002:a05:6a20:840b:b0:1e1:c748:13c1 with SMTP id adf61e73a8af0-1eb215ec017mr30298366637.27.1737550169753;
        Wed, 22 Jan 2025 04:49:29 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bdd30d1fdsm10790874a12.60.2025.01.22.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 04:49:29 -0800 (PST)
Date: Wed, 22 Jan 2025 21:49:20 +0900 (JST)
Message-Id: <20250122.214920.2057812400114439393.fujita.tomonori@gmail.com>
To: aliceryhl@google.com
Cc: fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 boqun.feng@gmail.com, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com
Subject: Re: [PATCH v8 3/7] rust: time: Introduce Instant type
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250116.210644.2053799984954195907.fujita.tomonori@gmail.com>
References: <20250116044100.80679-4-fujita.tomonori@gmail.com>
	<CAH5fLggz0t3wTxSNUw9oVBDbR_PSWpQysaSSt6drd7vw8AXQfw@mail.gmail.com>
	<20250116.210644.2053799984954195907.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 21:06:44 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> On Thu, 16 Jan 2025 10:32:45 +0100
> Alice Ryhl <aliceryhl@google.com> wrote:
> 
>>> -impl Ktime {
>>> -    /// Create a `Ktime` from a raw `ktime_t`.
>>> +impl Instant {
>>> +    /// Create a `Instant` from a raw `ktime_t`.
>>>      #[inline]
>>> -    pub fn from_raw(inner: bindings::ktime_t) -> Self {
>>> +    fn from_raw(inner: bindings::ktime_t) -> Self {
>>>          Self { inner }
>>>      }
>> 
>> Please keep this function public.
> 
> Surely, your driver uses from_raw()?

I checked out the C version of Binder driver and it doesn't seem like
the driver needs from_raw function. The Rust version [1] also doesn't
seem to need the function. Do you have a different use case?

https://r.android.com/3004103 [1]

