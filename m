Return-Path: <netdev+bounces-163984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B78BA2C3A5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAF83A26BE
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA91F6694;
	Fri,  7 Feb 2025 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgmOgSHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16CF1A5BB1;
	Fri,  7 Feb 2025 13:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935111; cv=none; b=c7yXQOuDMhvFCo8SL/gdYfvZqD+vGYdC34hkFegL4IsIqs18SHSZx66a7ZK6HeipMCjxTanpavGF1zLRrBYURHsjdeyt3cY2+e5F1uCSCSnUeLrlqx4sp37+C05OAvHckAUidmxBoFVb4NN7/jxqDy6U0BJ5Jb3cJ9cwPicMdBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935111; c=relaxed/simple;
	bh=v/wkh9kr1o8bPZhLstlnmZubIhj6xBoQq+qlOb9ycKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIlssRFYs4o9/D2EgIrgXmYkX1M+mDVhZG0QyLxtwzKn12AB+7iWhQ4TQtmfT393SvLzhZuz24sLvX+HnIV5tJcubIMu9+OEghkk6Er63suxYzmHinpMd8pmJwqvgEYivR/ptaG32HNKM61fCCHRmoOVgjSYaGNdENQQ+6pJM8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgmOgSHQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2166f1e589cso52385495ad.3;
        Fri, 07 Feb 2025 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935109; x=1739539909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cj8NIj61MhF1K2//dHDrnbWqun0z8imxzp8+ulm+riQ=;
        b=lgmOgSHQNk58P+50d5OCwC/Nq75tUVORAzx+Q6D5+vcHT3PHBGHWHw8OVlDyaVvmY5
         7zY1j9OzskNb1FZv7O9GGCIf9+MTZbTruzUVfMSW5kxYnp+h5DhZR43BvTncr0T3+t8s
         6jawBCSLtNX20qKTP6sNgHVuCKPm1izPTQLhyIX0wBpUr0POvTDVa5nkkXQub7V6MFjP
         Ck9x0GtW9Ut+LEPRaK6jU++HT7ZT+YUAdxeeH3cxcqL06+w74/6I6Oe19PCNrPC4AfSg
         PaLrHW4Gqtaqvbzt9olBl95pAyG/YgK2l943dhC77GiV3LMlglMrnDPSC+Lhahr+bL7v
         bEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935109; x=1739539909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cj8NIj61MhF1K2//dHDrnbWqun0z8imxzp8+ulm+riQ=;
        b=xT+Cnxw4oRMBCdRXo6xuerQShBwOPm3PE4neXrG7LAQ0xncBZ/hoRYYH8/T1Lr3H1J
         2dLi4DWZJWheixaKRmkY6PYrHRZDiGIbXp3wsTYWeAQ4NVipDQM2jHp9fEEmjo6wAeqq
         RvyrBpmbQiISWLrVpyupCDze5tf7XbSILnrFUcrK1cGZaOV4ZezyjHhTHVJO2a+tE+mO
         OpoO/yyqCkj94hBk3MlytrgjUhyxQJlhmGFNHsvJ/QmJ6OxiGYJUyoXGtadJz5pHtSBT
         Mm4/QTccWSjOq9QG7A/np0nX+ALXknmCYv+ymzaERcc2VFOUjA9vueQR/0hb0AwkZiY3
         HIDA==
X-Forwarded-Encrypted: i=1; AJvYcCUwbrJuotJESXn8qyRgeg5V+zBc3RoskLJxVV3aUc9CjLrJKIyYTW3mhcw+FJI0X64Z3tCx+WfFZgsRHkYABIQ=@vger.kernel.org, AJvYcCUxjmnf7c+nEFcQ0JG9sDbcDxgPOS4PIKoZ7+MWJaSlrlgpis3/hvWBstHTlpA0f/p3qHpmvvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzERplZrrEUXWQXODc74iB4EizO4oPPLTQ05F1aeu4p5QbG5KvX
	y/ObUnvn2g/bp7y67qLS2Z0kOYLNyZ+VnzJd8l7R6/EheNe7x1M6yRDq3d/D
X-Gm-Gg: ASbGncs/xeC/fulO+GAQ2tgumw77OUPgybRklcm3q2lVDnCa5jWi8FcGlO7LTpiiy7G
	CNkByKxwE+So+nxfXneVCMg4iFdHk4HbombFXWn0sxBOX0yWhqU35jstMkHfsv9QyoxJQ07V98Q
	MLTmct3cgbdUDvRepi7pGrXrDZsWJyvW06eeeBJLnnCiZWEWjqIDcXqNgyGWasuAJBLTMrnxhkB
	lDWbgUou03NZEJ5QJ7rFau0HKOQNOi7/gLUiQM4Fn22iZnbNeUqc1GFZX9Pqe3WLWGXjZOZoHVI
	BT85nUWwmPx7/u6RrHzeMoRzkMzjF2hO8ye84BtthhaoXDdQDXgvCQaiFErPzeTwwYI=
X-Google-Smtp-Source: AGHT+IE8T9P7QTcwxMiIQY3V8PR1OxE5QCTkFUNALDy/74PLsQApqSBIkxe5Gmqm/V4cpV9KXJZQLQ==
X-Received: by 2002:a05:6a20:c90a:b0:1ed:aca6:8dd4 with SMTP id adf61e73a8af0-1ee03a9ad11mr5727957637.19.1738935108702;
        Fri, 07 Feb 2025 05:31:48 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:31:48 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
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
	tgunders@redhat.com
Subject: [PATCH v10 3/8] rust: time: Introduce Delta type
Date: Fri,  7 Feb 2025 22:26:18 +0900
Message-ID: <20250207132623.168854-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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


