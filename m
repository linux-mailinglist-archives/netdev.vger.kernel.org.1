Return-Path: <netdev+bounces-167999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770A8A3D1CE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441FB7A3DC7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3EE1E493C;
	Thu, 20 Feb 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUkbjpJX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352131E5B87;
	Thu, 20 Feb 2025 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035438; cv=none; b=grhPjThQpdki7Z4K4TmyStANYWGeZ3GDkug3BJg3YkXud1ztrbw2R3yDW4AJTQfldg8XwXUvwXlW7P51pfh2suwiAbBExrh3Gn5FyLW2jBPp8txJxJznerGFVQ+0Na/L2YCGRGuzgWV9nX0PKzsXLf/8RDnkLQ+d+ZSuvNDIGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035438; c=relaxed/simple;
	bh=pkSYO6NlMhW+D/DQ7y5lZOVnQKEZRbtDpqdcNVBlflY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WARA1YpbBbBvRiXAK6flwanHL+FuN77EgYZTXMmnx1/+yl1ZA6GFoFE9jnc5FfA/hFV+6s7CwXENLrMOTdU2velGwu3Rz/yiqrZyI/fqtTC4Xa72cGIk5l2lC/nm/qclIVVSelCEm3IS3d5wVWA21U7NstWo5Wm47w2/zm4nTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUkbjpJX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22113560c57so10608955ad.2;
        Wed, 19 Feb 2025 23:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035436; x=1740640236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4TJ+Zzt6WaZlUf68dO8eijca8HC/3tLlWTzp/tyTWE=;
        b=mUkbjpJX4sPXcW2dA0mIORtcLMQqP6m1EYx+pZyVBzwLxH71VepNO5eU1vV42p9eXd
         /sePPbAyugCUP2DdNqvCIil0IKTd8Q8t2m6qDfVEm5xeu6wuCKSVVYjM5+n0xLQwy7/q
         qcDEeC9UdygfYUk+RstBwBZOYHJLQMQ8+g9ZKmttxQ2W2FHEpG5LfVm1lhZE4UApJU4v
         3chfFY3v7QECTLQXaPFLILbGm9n12kWZHjBiHKMi1qtrXwGaWbyvbGT7FFXgYg4+HESY
         W4SnQfI89wR/jNW7ABvMSEHtuNwS7522ovq7K038UHANaEi2fuGVpiKC0apbIoKw7eUH
         7z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035436; x=1740640236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4TJ+Zzt6WaZlUf68dO8eijca8HC/3tLlWTzp/tyTWE=;
        b=MBW6R9Sx2yduTn0tJUrUH8uKtlDGCVY4+X5lPX+bXnHl9RCIkthrwOIayTBECsXBxE
         wBIPtV2oy7Q1X4vvC0CsnUsNKwj+SODodBl/I6ab3+9ViVgXaTPJib8fC0cAu2PoTWVP
         tldUFBQPhbO93tlIhUogfbOpUsfMwgNYunj0GC5ebkTXTfKbJAAtvmaJnFfsNuFF8OEF
         ScIe+ggiWieollkIvLdfSo3SLS4QPDs6/w2paVlxGaQtASQ8tOdzYBjhkQmOQRckWhc2
         p7CAoyWvyd1AmmRIv9DBA7Gy9ErgEUNVw2ClkhjcYFX5MhoFWArzflf64cv4oMK+WkGA
         Uc8A==
X-Forwarded-Encrypted: i=1; AJvYcCU6fXBgYpsmTuXOJ7TmSH6BJYfC02gPWc+GyfecKEvRKNPONRAOtMTI2lAkmT8Yaj+fzjqEKMg=@vger.kernel.org, AJvYcCXs+8E9oVMJTleOdJOo9jhhQKmtrWuQSxQTZn18OKQvb9lREMWC9Ty0SCulLVwx7MEk/KWudOiI9/GOWcyCk1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDAsgmWiKnSuwjEHkl3/EGTohscYzY1eLYI9/bVBGN6ntXxiAp
	hF7f8pGdo05SfNxlrJIPIgu5tI+5VowF5S8IieVuJUSUDMDU2kZazIN7jHnm
X-Gm-Gg: ASbGncsdlkPofLLwoN+Fr/Dm8nh2BRD0UYayNblfG+eliKsooUT99//kGI6lhwHWapa
	/5VQTNTsqxU2P4svFTZBK3xpbXwFmH7hV4I6/jW9APO4zS5saHdxl+TR4ioJlRANMXHHviBFovu
	Nh9ejXo98VaOsOxJoJ1UQLoXxUZoG8ryZc7UyQgD9ZcVAeN2j/30KVLwK46cHardSP6kK5xkBbE
	Bv/jgRSgNW1ObRIRry/RsL+A6JpLoRZJFMtYyyFualo+VhwklbwjZvLnWWCVNXyvkDyTBm09ffD
	NEZkiIN0uDtZ+VtPlpbFLZKlmXRD4NK8QJwKoaUyclkKmaSwjG66lw5IDTFjb7lZqVo=
X-Google-Smtp-Source: AGHT+IG/d/do3HPgOHdwMufa+1WBx3SE5+2M9ZJFHzfK23ADwWeL8LJCvWvmechh6RZ++eueyjm0+g==
X-Received: by 2002:a05:6a20:160e:b0:1ee:c598:7a93 with SMTP id adf61e73a8af0-1eec5987c6emr17652336637.42.1740035436186;
        Wed, 19 Feb 2025 23:10:36 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:10:35 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	david.laight.linux@gmail.com
Subject: [PATCH v11 3/8] rust: time: Introduce Delta type
Date: Thu, 20 Feb 2025 16:06:05 +0900
Message-ID: <20250220070611.214262-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a type representing a span of time. Define our own type
because `core::time::Duration` is large and could panic during
creation.

time::Ktime could be also used for time duration but timestamp and
timedelta are different so better to use a new type.

i64 is used instead of u64 to represent a span of time; some C drivers
uses negative Deltas and i64 is more compatible with Ktime using i64
too (e.g., ktime_[us|ms]_delta() APIs return i64 so we create Delta
object without type conversion.

i64 is used instead of bindings::ktime_t because when the ktime_t
type is used as timestamp, it represents values from 0 to
KTIME_MAX, which is different from Delta.

as_millis() method isn't used in this patchset. It's planned to be
used in Binder driver.

Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 48b71e6641ce..622cd01e24d7 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -8,9 +8,15 @@
 //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.h).
 //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
 
+/// The number of nanoseconds per microsecond.
+pub const NSEC_PER_USEC: i64 = bindings::NSEC_PER_USEC as i64;
+
 /// The number of nanoseconds per millisecond.
 pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
 
+/// The number of nanoseconds per second.
+pub const NSEC_PER_SEC: i64 = bindings::NSEC_PER_SEC as i64;
+
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = crate::ffi::c_ulong;
 
@@ -81,3 +87,85 @@ fn sub(self, other: Ktime) -> Ktime {
         }
     }
 }
+
+/// A span of time.
+///
+/// This struct represents a span of time, with its value stored as nanoseconds.
+/// The value can represent any valid i64 value, including negative, zero, and
+/// positive numbers.
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord, Debug)]
+pub struct Delta {
+    nanos: i64,
+}
+
+impl Delta {
+    /// A span of time equal to zero.
+    pub const ZERO: Self = Self { nanos: 0 };
+
+    /// Create a new [`Delta`] from a number of microseconds.
+    ///
+    /// The `micros` can range from -9_223_372_036_854_775 to 9_223_372_036_854_775.
+    /// If `micros` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_micros(micros: i64) -> Self {
+        Self {
+            nanos: micros.saturating_mul(NSEC_PER_USEC),
+        }
+    }
+
+    /// Create a new [`Delta`] from a number of milliseconds.
+    ///
+    /// The `millis` can range from -9_223_372_036_854 to 9_223_372_036_854.
+    /// If `millis` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_millis(millis: i64) -> Self {
+        Self {
+            nanos: millis.saturating_mul(NSEC_PER_MSEC),
+        }
+    }
+
+    /// Create a new [`Delta`] from a number of seconds.
+    ///
+    /// The `secs` can range from -9_223_372_036 to 9_223_372_036.
+    /// If `secs` is outside this range, `i64::MIN` is used for negative values,
+    /// and `i64::MAX` is used for positive values due to saturation.
+    #[inline]
+    pub const fn from_secs(secs: i64) -> Self {
+        Self {
+            nanos: secs.saturating_mul(NSEC_PER_SEC),
+        }
+    }
+
+    /// Return `true` if the [`Delta`] spans no time.
+    #[inline]
+    pub fn is_zero(self) -> bool {
+        self.as_nanos() == 0
+    }
+
+    /// Return `true` if the [`Delta`] spans a negative amount of time.
+    #[inline]
+    pub fn is_negative(self) -> bool {
+        self.as_nanos() < 0
+    }
+
+    /// Return the number of nanoseconds in the [`Delta`].
+    #[inline]
+    pub const fn as_nanos(self) -> i64 {
+        self.nanos
+    }
+
+    /// Return the smallest number of microseconds greater than or equal
+    /// to the value in the [`Delta`].
+    #[inline]
+    pub const fn as_micros_ceil(self) -> i64 {
+        self.as_nanos().saturating_add(NSEC_PER_USEC - 1) / NSEC_PER_USEC
+    }
+
+    /// Return the number of milliseconds in the [`Delta`].
+    #[inline]
+    pub const fn as_millis(self) -> i64 {
+        self.as_nanos() / NSEC_PER_MSEC
+    }
+}
-- 
2.43.0


