Return-Path: <netdev+bounces-187126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E5DAA51DA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98ADE9E2A38
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2790262FDB;
	Wed, 30 Apr 2025 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi7hiEzM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3334288DA;
	Wed, 30 Apr 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746031389; cv=none; b=ImTFgfNKw3kXdZw1YkZ9kh8Z4HGOC+Ccizu+SP2HpQlulaoiPpKg5nXd1X2AM7aegZ53z44FKBuT8j+rvVxEHHsQao56F4X6wf21Qkt5bsH78rWaus3SMo15QYO6FTYRCB95FEraSkd3c1o54GluZ1rUsn7rd2zHXbFOFPYvuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746031389; c=relaxed/simple;
	bh=G4oiFZbFiXvHgWV+JSaBFAW886RfJtGLNAynJQXdcWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G5aFCidkW9SlARkWavlsSKXrspchjGTlaub76O+WKEbA6pdZEenhIV3bCKh5sb5q54bZ+ylDt2rYqbO32X2+fUvSkFTZ83mFRKaRvsHMMKbqq9kZIMh5vn+a4QjmztyctofSAi1p3ZZm3K4YSRs0QLeApbHnct5ZSHUrCxQ3FW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi7hiEzM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso37630755e9.3;
        Wed, 30 Apr 2025 09:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746031386; x=1746636186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nJiAf5o1o3t4Zc12gEdYScmBrcEv2gqtb9G2WE6q1qg=;
        b=Hi7hiEzMy+I0aE/qidXzukY61vnvw6miovB7z51QWDxP5VmsLGUfIW86mFVvkLHtlJ
         F1ZzXo9dEMZZ3IJlZXKuGBvJqR9WkD1kXwC98FXmIIEDCwDeRSudKLgzQhvvo+0RCBAE
         mswH6YQcCCOYU96B8Cb3ZCQvuBgb7A+ytGANE2pUYV8rvrnuJQJoNMUy/R1yzC8qiTY7
         BhH7BWhG8Tv43gvShPoubZkpxZDLJ3UozbJbmPyLA90AjCb8MFuLXN5uT2kB5Y8YaOSE
         iecHYqGJn4KjQVCU2gl7M07dJANsdi2vgP5cqcM2ITjtT6SPXXByJFc947+21mTnc6Th
         m4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746031386; x=1746636186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nJiAf5o1o3t4Zc12gEdYScmBrcEv2gqtb9G2WE6q1qg=;
        b=i7soSquAtgAP2yRh9IY2HNJB6XvR4h6BnS9H0bJmVcZjFGIfY0iJ0pKUxtcPbmR32B
         PRIQ8o2P8Anc8R92bT+/1n2Jk674MCeP+TwsCHHNTQaCdnfBTfDvQf5++UvR8O9Xle5Y
         7odreSNQB4751XyvwlyYttwSzSJykT/F29R8T9xlYplyAaVTPpAsGkVIiI5ESstukgvx
         Su3xqz+GU48QAGjLCOOa3tgPmTici84gZ5c6BMREGlTdyEV+CMUd8dHp8YpKHimxdOWc
         xE4OUMZwkBFtuNOwFQ+yqoQhsSgmtMty3Q5BXIErBC8XkK6KeDI6U0t9A5QcWi4ZTiRg
         8yYw==
X-Forwarded-Encrypted: i=1; AJvYcCUOZvn0kXy9Brc2YmPeVlAmOVwod+hlaOfJXYtvL3DidsmEAABJouk5bRyrhws2D6UIEbnN9wmhmWlmN3U=@vger.kernel.org, AJvYcCV1U51Sif1AQeJjX0uMbEjZ6QszPeOoyV5QO0Cn7AgW86SBoCcVwfv316GxhKZ2q6fqgtVZ0b9XBc5s5ug9nWw=@vger.kernel.org, AJvYcCWsoE4f0+7boxXstg3tWanvqLe33knCXT/D3rzye/uCnJb+QrkQyzQr4o7rocjeyQRw/KZUY5AG@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDNHprytbaAh9cigmwgRyCiLZgK8VBvd7y0Ajn3OB5ItZOXtA
	9hcoLBixTnFXEG/F6WkdYFUPARt67mTGJExbyVeTNWujTr/dU609
X-Gm-Gg: ASbGncvH1ViG/QRIT6yEbxR+HNpvZaqE/9ADsgFIqTQmiE8difD68NIcw0XlhkVHP02
	Q49Y76phYsim7/W+feVaJPltzORMfzAQi49VeMnwUMkIeaUuGiR0qK59sBWVq8CE/SVWfF4E/ai
	GCSyG4W530z4O/EODdDPNjkypvp5fTZK/06Jeu9SoVhwL9vP2oIeVCjHiOieMgPeqWpKlQOLzUQ
	tpD5AkQliLrltp+wP1JBJSNVgjunYjz49yvzbtT66WrrNIJjmCXhYoak4YNkfMYj9Z99DqO9s3G
	IwXPn3Sw7/kxtm0rCE75QbkRA/+WxKW7mzcghLrXNkYEc2aWm1ys8Q==
X-Google-Smtp-Source: AGHT+IGh6opw3i1MptMjyNUX216gNu6ecfuXNuFeE+pokOikg5C6G4kO60j+oSOCzszCovW6gDcsNA==
X-Received: by 2002:a05:600d:101:b0:440:67f8:7589 with SMTP id 5b1f17b1804b1-441b1f39599mr34373825e9.16.1746031385778;
        Wed, 30 Apr 2025 09:43:05 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2ad7688sm31261115e9.3.2025.04.30.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 09:43:05 -0700 (PDT)
Message-ID: <66f78ed5-aeff-4b79-8c6c-2b54a5855bde@gmail.com>
Date: Wed, 30 Apr 2025 18:43:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, gary@garyguo.net,
 aliceryhl@google.com, me@kloenk.dev, daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, anna-maria@linutronix.de, frederic@kernel.org,
 tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, david.laight.linux@gmail.com, boqun.feng@gmail.com,
 pbonzini@redhat.com, jfalempe@redhat.com, linux@armlinux.org.uk,
 linus.walleij@linaro.org
References: <871ptc40ds.fsf@kernel.org>
 <20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
 <CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com>
 <20250430.225131.834272625051818223.fujita.tomonori@gmail.com>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <20250430.225131.834272625051818223.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.04.25 3:51 PM, FUJITA Tomonori wrote:
> On Tue, 29 Apr 2025 16:35:09 +0200
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> 
>>> It appears that there is still no consensus on how to resolve it. CC
>>> the participants in the above thread.
>>>
>>> I think that we can drop this patch and better to focus on Instant and
>>> Delta types in this merge window.
>>>
>>> With the patch below, this issue could be resolved like the C side,
>>> but I'm not sure whether we can reach a consensus quickly.
>>
>> I think using the C ones is fine for the moment, but up to what arm
>> and others think.
> 
> I don't think anyone would disagree with the rule Russell mentioned
> that expensive 64-bit by 64-bit division should be avoided unless
> absolutely necessary so we should go with function div_s64() instead
> of function div64_s64().
> 
> The DRM QR driver was already fixed by avoiding 64-bit division, so
> for now, the only place where we still need to solve this issue is the
> time abstraction. So, it seems like Arnd's suggestion to simply call
> ktime_to_ms() or ktime_to_us() is the right way to go.
> 
>> This one is also a constant, so something simpler may be better (and
>> it is also a power of 10 divisor, so the other suggestions on that
>> thread would apply too).
> 
> One downside of calling the C's functions is that the as_micros/millis
> methods can no longer be const fn (or is there a way to make that
> work?).

It would theoretically be possible to use the unstable `const_eval_select`
to use the C implementation at runtume and just divide at compile time.
I don't think that we want to do this (or that it should be done in any
serious project should do this) but it would be technically possible.

I'm also not sure how/if const-eval would handle the 64 by 64 bit division.

> We could implement the method Paolo suggested from Hacker's
> Delight, 2nd edition in Rust and keep using const fn, but I'm not sure
> if it's really worth it.
> 
> Any thoughts?

`const fn` would be nice, but if it is not currently needed and would
complicate the implementation we should probably keep it non-const
until someone needs it to be const.

> 
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index a8089a98da9e..daf9e5925e47 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -229,12 +229,116 @@ pub const fn as_nanos(self) -> i64 {
>      /// to the value in the [`Delta`].
>      #[inline]
>      pub const fn as_micros_ceil(self) -> i64 {
> -        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
> +        const NSEC_PER_USEC_EXP: u32 = 3;
> +
> +        div10::<NSEC_PER_USEC_EXP>(self.as_nanos().saturating_add(NSEC_PER_USEC - 1))
>      }
>  
>      /// Return the number of milliseconds in the [`Delta`].
>      #[inline]
>      pub const fn as_millis(self) -> i64 {
> -        self.as_nanos() / NSEC_PER_MSEC
> +        const NSEC_PER_MSEC_EXP: u32 = 6;
> +
> +        div10::<NSEC_PER_MSEC_EXP>(self.as_nanos())
> +    }
> +}
> +
> +/// Precomputed magic constants for division by powers of 10.
> +///
> +/// Each entry corresponds to dividing a number by `10^exp`, where `exp` ranges from 0 to 18.
> +/// These constants were computed using the algorithm from Hacker's Delight, 2nd edition.
> +struct MagicMul {
> +    mult: u64,
> +    shift: u32,
> +}
> +
> +const DIV10: [MagicMul; 19] = [
> +    MagicMul {
> +        mult: 0x1,
> +        shift: 0,
> +    },
> +    MagicMul {
> +        mult: 0x6666666666666667,
> +        shift: 66,
> +    },
> +    MagicMul {
> +        mult: 0xA3D70A3D70A3D70B,
> +        shift: 70,
> +    },
> +    MagicMul {
> +        mult: 0x20C49BA5E353F7CF,
> +        shift: 71,
> +    },
> +    MagicMul {
> +        mult: 0x346DC5D63886594B,
> +        shift: 75,
> +    },
> +    MagicMul {
> +        mult: 0x29F16B11C6D1E109,
> +        shift: 78,
> +    },
> +    MagicMul {
> +        mult: 0x431BDE82D7B634DB,
> +        shift: 82,
> +    },
> +    MagicMul {
> +        mult: 0xD6BF94D5E57A42BD,
> +        shift: 87,
> +    },
> +    MagicMul {
> +        mult: 0x55E63B88C230E77F,
> +        shift: 89,
> +    },
> +    MagicMul {
> +        mult: 0x112E0BE826D694B3,
> +        shift: 90,
> +    },
> +    MagicMul {
> +        mult: 0x036F9BFB3AF7B757,
> +        shift: 91,
> +    },
> +    MagicMul {
> +        mult: 0x00AFEBFF0BCB24AB,
> +        shift: 92,
> +    },
> +    MagicMul {
> +        mult: 0x232F33025BD42233,
> +        shift: 101,
> +    },
> +    MagicMul {
> +        mult: 0x384B84D092ED0385,
> +        shift: 105,
> +    },
> +    MagicMul {
> +        mult: 0x0B424DC35095CD81,
> +        shift: 106,
> +    },
> +    MagicMul {
> +        mult: 0x480EBE7B9D58566D,
> +        shift: 112,
> +    },
> +    MagicMul {
> +        mult: 0x39A5652FB1137857,
> +        shift: 115,
> +    },
> +    MagicMul {
> +        mult: 0x5C3BD5191B525A25,
> +        shift: 119,
> +    },
> +    MagicMul {
> +        mult: 0x12725DD1D243ABA1,
> +        shift: 120,
> +    },
> +];
> +
> +const fn div10<const EXP: u32>(val: i64) -> i64 {
> +    crate::build_assert!(EXP <= 18);
> +    let MagicMul { mult, shift } = DIV10[EXP as usize];
> +    let abs_val = val.wrapping_abs() as u64;
> +    let ret = ((abs_val as u128 * mult as u128) >> shift) as u64;
> +    if val < 0 {
> +        -(ret as i64)
> +    } else {
> +        ret as i64
>      }
>  }


