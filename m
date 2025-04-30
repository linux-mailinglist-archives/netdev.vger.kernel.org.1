Return-Path: <netdev+bounces-187088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA9AA4DEA
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01E44C824F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9E25E475;
	Wed, 30 Apr 2025 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJatmC8O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F501B5EB5;
	Wed, 30 Apr 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746021112; cv=none; b=A1PY+gO5XP/RyH4d3Mzjo8+YZVBiBnhIV6japfEvyDLVY8g7FztAS7DkbESKt6HZiSo7ULespDS9JhX/ETlecjKhkwlnnYukurzrY4f3aOraBV9w8papxwvI8mUgYolTiHNu0lQZ1xtG+7AC5ObN562eEB/XvP9t0L9krZRD0p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746021112; c=relaxed/simple;
	bh=6lKg1os531NFcBDjwEJw1YQuhF4Fo1Y0v3cg06ARjhU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ulxbtmQFh4N85tOU1t6k1mN0Zmthio8Y4jsTUAJsXwdef5/DaFL6NP9yUxChWy4gdQGJBUzuIjXQSucCKBrYNfBo8WKZrGAPskpQ7WhZeWwEovjcQwT8Btho7r0Z8UjuysaullEtcYgtkgnYEszrXmDYztd+BfIzU0po8sl7JMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJatmC8O; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22928d629faso78446375ad.3;
        Wed, 30 Apr 2025 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746021110; x=1746625910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sSaO5HdN2jYcb7WhxxBoa767nZPX+vlCke2cHAE+mMA=;
        b=EJatmC8OljXNoFBvDehe6ZHlCW0olBFlYEnsaA1kMPATEglZqCCqDjxGOumqN4mir3
         kybbii9iIsCycPCBK/wpNgB8oBHh5vesuuBOr/6obbTitVpABxD+EXN5F/l3Pm2+N3ki
         n5LNSO4sXMubKhpEBikViBif6NurqN/hzl+tLNws5BBHhA3BtJlmAb913RKmSSqqJ69s
         3PE5UiMZ/H5P7y+ROHnbQrj5W3b2pyz+LPoQEJLZs/DFGauPvDjB5bFJrmCI3SybZTzo
         7M98C03+MDANdTvorFDm0MAFheRChJqiIP/PqjDQ6gMGUa8JnmnC9vGHDGMYA8/vJoo3
         J5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746021110; x=1746625910;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sSaO5HdN2jYcb7WhxxBoa767nZPX+vlCke2cHAE+mMA=;
        b=GE9e6njC2xjENkLvHm1hpg4NknYCEIYcxFoJmpmzbJG/4RQTxGDtmRcCeExrKHOaXm
         Mjo/atU9v18GE6Io5aNCQ552StUciGOD7nQWuwr/xxrWKmvanDrx3UiMACcwHsDoV3+w
         XZPZKTswQL/48qMlUS0VVUCw25gkkwJc89JIcElbMC6biyiLKsAr9zclC3dPqE7FBlUN
         SB0Jd3J+GiZmWkZs7EHOSKhiOR8HLaQLtdOul/1Reu24zG2/eVN5faJjZbosBpgUC+4B
         l6OT+xemV9V2zRYvpZQBUAVKFdXKCL+qUVMDwXc8xPRt4K2JHp/tF1UCbjyf44kZiKoN
         tN3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVWMqjTNed5opVRFAbBl2f9Yx3YfyW+55cEawCscSIWxnl7AE4/342YQ52ZyVZdIWoEIpxrvfr4@vger.kernel.org, AJvYcCVpd+tYTNiPJ9vA0u46CxEeudr6U8hKErPdkE4XpGVTe3Mzu9Am8c4997qEl0xqbw1Qvc8llL6C811bfHCkw90=@vger.kernel.org, AJvYcCWRs9+HfWMlviOs6pCEN2nPYL7/gLOsxp0sQpIZ4sgVXznlSDkK8Eq9bqJ3SKWR9MrRnZLFL36xxz7xBew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3DNGMAIXH7D1RZbAVQTb66epde0ICFGXggZDQwxFPMGmeThnf
	r0u0LGcSjPO4CvX77WzQfSR4SztJ4mi3hY1hFfrOT0Mnv99L9n0G
X-Gm-Gg: ASbGncutNGXsFUbUG9ZjL8l//TuBFd7TJBTfz8SaCoi4D1NzFi0zs/zg2QhgxKHaiLn
	Ay9PEgexst4IcxGdqzteDsB8lalSf4HW2caGffnizWdvZpAIfthBHpI707X40Ky2lo48tNJ75Fc
	CUZ8/MW45i+1ELHfeQe4cYEvWLOaKm7c6/fJCHAeI0JP7LcHijjZnGFDnaHjuNEq06imIwIeynj
	PX4pOdYtM0xvuMmZAI3r7pgDZvHPyyjLg1Potp6218fRQIYsXpzP+JxGqe5n3Qlu/unk67iRi2H
	TLAFrGsOPbelKciOqfu8cxJUgQRMmUiZoq6PxT79OqNT2jLK+QiB2WoTX0zjrR770s7zT4/J6yD
	7I6T3hj5aHLpttljCbs4PYYEONE+XwaFHwg==
X-Google-Smtp-Source: AGHT+IFeETFPHvQx7o64lr2bJdz4LNwJ3EyNpxCVa1tty8DWWZScxrT2IA1cHarp5SxWpdIm9bPECw==
X-Received: by 2002:a17:902:e803:b0:220:e63c:5b13 with SMTP id d9443c01a7336-22df3587811mr52653905ad.46.1746021110426;
        Wed, 30 Apr 2025 06:51:50 -0700 (PDT)
Received: from localhost (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc7d5fsm121671715ad.103.2025.04.30.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:51:49 -0700 (PDT)
Date: Wed, 30 Apr 2025 22:51:31 +0900 (JST)
Message-Id: <20250430.225131.834272625051818223.fujita.tomonori@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 rust-for-linux@vger.kernel.org, gary@garyguo.net, aliceryhl@google.com,
 me@kloenk.dev, daniel.almeida@collabora.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com,
 david.laight.linux@gmail.com, boqun.feng@gmail.com, pbonzini@redhat.com,
 jfalempe@redhat.com, linux@armlinux.org.uk, chrisi.schrefl@gmail.com,
 linus.walleij@linaro.org
Subject: Re: [PATCH v15 5/6] rust: time: Add wrapper for fsleep() function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com>
References: <871ptc40ds.fsf@kernel.org>
	<20250429.221733.2034231929519765445.fujita.tomonori@gmail.com>
	<CANiq72mMRpY4NC4_8v_wDpq6Z3qs99Y8gXd-7XL_3Bed58gkJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 16:35:09 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

>> It appears that there is still no consensus on how to resolve it. CC
>> the participants in the above thread.
>>
>> I think that we can drop this patch and better to focus on Instant and
>> Delta types in this merge window.
>>
>> With the patch below, this issue could be resolved like the C side,
>> but I'm not sure whether we can reach a consensus quickly.
> 
> I think using the C ones is fine for the moment, but up to what arm
> and others think.

I don't think anyone would disagree with the rule Russell mentioned
that expensive 64-bit by 64-bit division should be avoided unless
absolutely necessary so we should go with function div_s64() instead
of function div64_s64().

The DRM QR driver was already fixed by avoiding 64-bit division, so
for now, the only place where we still need to solve this issue is the
time abstraction. So, it seems like Arnd's suggestion to simply call
ktime_to_ms() or ktime_to_us() is the right way to go.

> This one is also a constant, so something simpler may be better (and
> it is also a power of 10 divisor, so the other suggestions on that
> thread would apply too).

One downside of calling the C's functions is that the as_micros/millis
methods can no longer be const fn (or is there a way to make that
work?). We could implement the method Paolo suggested from Hacker's
Delight, 2nd edition in Rust and keep using const fn, but I'm not sure
if it's really worth it.

Any thoughts?

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index a8089a98da9e..daf9e5925e47 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -229,12 +229,116 @@ pub const fn as_nanos(self) -> i64 {
     /// to the value in the [`Delta`].
     #[inline]
     pub const fn as_micros_ceil(self) -> i64 {
-        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
+        const NSEC_PER_USEC_EXP: u32 = 3;
+
+        div10::<NSEC_PER_USEC_EXP>(self.as_nanos().saturating_add(NSEC_PER_USEC - 1))
     }
 
     /// Return the number of milliseconds in the [`Delta`].
     #[inline]
     pub const fn as_millis(self) -> i64 {
-        self.as_nanos() / NSEC_PER_MSEC
+        const NSEC_PER_MSEC_EXP: u32 = 6;
+
+        div10::<NSEC_PER_MSEC_EXP>(self.as_nanos())
+    }
+}
+
+/// Precomputed magic constants for division by powers of 10.
+///
+/// Each entry corresponds to dividing a number by `10^exp`, where `exp` ranges from 0 to 18.
+/// These constants were computed using the algorithm from Hacker's Delight, 2nd edition.
+struct MagicMul {
+    mult: u64,
+    shift: u32,
+}
+
+const DIV10: [MagicMul; 19] = [
+    MagicMul {
+        mult: 0x1,
+        shift: 0,
+    },
+    MagicMul {
+        mult: 0x6666666666666667,
+        shift: 66,
+    },
+    MagicMul {
+        mult: 0xA3D70A3D70A3D70B,
+        shift: 70,
+    },
+    MagicMul {
+        mult: 0x20C49BA5E353F7CF,
+        shift: 71,
+    },
+    MagicMul {
+        mult: 0x346DC5D63886594B,
+        shift: 75,
+    },
+    MagicMul {
+        mult: 0x29F16B11C6D1E109,
+        shift: 78,
+    },
+    MagicMul {
+        mult: 0x431BDE82D7B634DB,
+        shift: 82,
+    },
+    MagicMul {
+        mult: 0xD6BF94D5E57A42BD,
+        shift: 87,
+    },
+    MagicMul {
+        mult: 0x55E63B88C230E77F,
+        shift: 89,
+    },
+    MagicMul {
+        mult: 0x112E0BE826D694B3,
+        shift: 90,
+    },
+    MagicMul {
+        mult: 0x036F9BFB3AF7B757,
+        shift: 91,
+    },
+    MagicMul {
+        mult: 0x00AFEBFF0BCB24AB,
+        shift: 92,
+    },
+    MagicMul {
+        mult: 0x232F33025BD42233,
+        shift: 101,
+    },
+    MagicMul {
+        mult: 0x384B84D092ED0385,
+        shift: 105,
+    },
+    MagicMul {
+        mult: 0x0B424DC35095CD81,
+        shift: 106,
+    },
+    MagicMul {
+        mult: 0x480EBE7B9D58566D,
+        shift: 112,
+    },
+    MagicMul {
+        mult: 0x39A5652FB1137857,
+        shift: 115,
+    },
+    MagicMul {
+        mult: 0x5C3BD5191B525A25,
+        shift: 119,
+    },
+    MagicMul {
+        mult: 0x12725DD1D243ABA1,
+        shift: 120,
+    },
+];
+
+const fn div10<const EXP: u32>(val: i64) -> i64 {
+    crate::build_assert!(EXP <= 18);
+    let MagicMul { mult, shift } = DIV10[EXP as usize];
+    let abs_val = val.wrapping_abs() as u64;
+    let ret = ((abs_val as u128 * mult as u128) >> shift) as u64;
+    if val < 0 {
+        -(ret as i64)
+    } else {
+        ret as i64
     }
 }

