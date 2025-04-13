Return-Path: <netdev+bounces-181960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD3A871A6
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 12:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCBA21899DA2
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 10:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408C1A238F;
	Sun, 13 Apr 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS56iUWf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A283820EB;
	Sun, 13 Apr 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744541036; cv=none; b=lKU5lKJ9t6zqFXpXyzxnfIQRx3h7LdIVYaS0J2ZXXAVY68tr0H3lex86toS4ZzrNe2hS8EZq7xPzynn671O4KzLg2NhamXwThVQ3fWGm/Uwl1ZQZNV5m+h3EbMIPpHonu9ArrjO0ty0hv87pqWxyEAa4AfyatlnRf7rRw4HqUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744541036; c=relaxed/simple;
	bh=12o8EpFplw5vxKVaPZGoT3TplIy82zwNzBv2WcTOE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhJIT9fHqqPttDiawS77IekRvfGuE1uviiPzXUimEnJmtiInS4odvgHXJorKKgdEHzMNNdkK5iXBk5TwmgFFVHL1ldSBHpw/6HymvRKPXqKoQNYvNGPcjshbA0GuGgf32LkdOg2NMUiUK4AwxjWdS34QTPPPqoOXqZAW/YlGSb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS56iUWf; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2295d78b45cso47754485ad.0;
        Sun, 13 Apr 2025 03:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744541034; x=1745145834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=aS56iUWfQ3jEqWJKmlnUNfTmmz+0VaBHfPkqzGrvkBlI/YQZUCW3ijdfgo8q/5qw9z
         zMrMZzu+e7f1WuBUtVQu3sGmhVXFCzbA+IwWxzHCMfLAfbucSSCYNynqgqqEMMZkNu61
         ZDI7rA4Mhqg3ufLJbBLwGhNGDS7pxWsvTIYQWQpRRx2f1ySizLL7Eh3dAq9OWyIOme/6
         R2YyJR/JqeLVsveQZH/J6s7hLTbOw/XCihsuzW8wO3xwxvzmWnZ3iKCnK0vxNjIZI8uo
         rEcZ9fHQY8KslZxSjn4lpIDhS6bQGSX5qkXV2OxOIInPFXsVQ+/opLlPxhbsSHFZ74I1
         M8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744541034; x=1745145834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=cyed78EEG7JwoD97F3dAeELCV84HmkwkFuxXXRhA7J8NhzGao1fHIdnExNODVeMliL
         Xzsn+FiZcp1u/25brrdhFtJVsO2VAIkfgmKDudWqaeNkrJBhMdBcl6HOOUylZ5nvU77J
         0cWrNqLJ/u+7eYhvlRncKRYLfcabYkHiSkoowa1nfffNBPAG2IQyRCnOElcccKgyZNpI
         9Jt7LTnS61ICGuTutmQDx6w++4V+lW8zp13QdQsw7HiXr/il05A0lf7AByUvB+txhcLy
         ZN0BKJwYkg+IbXzgQznN9tQnk+qBVT00nYwJv49JOD/WGwdQuKp333XyspWtmHlkc7Qt
         pflw==
X-Forwarded-Encrypted: i=1; AJvYcCVEQEFR6a8xT/OTE+fxiliVlRdx0vXpwgaRmcmb6j3mhGTCzKsWGZBch0jvTgoHHaDsBh4wGXAt@vger.kernel.org, AJvYcCWBF2C/w+wfw9Ag7D+UGnpYISiktvfDjsNv1PK0DybnAxOZlYTAaCmm5MobIe8yH75sq7gbYAsO4HgKcNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvDcHTk2c8lDDKO4QSbqsi2OUAcYQ0Y3sqDIKgJnNdHXjJxjjZ
	xIOuzFw7NycxYRv+wTH+LCxFC09xlNGqlI3Vt+e6y1IY7vXhTeWD20jkF0lX
X-Gm-Gg: ASbGnctRGFjZbE9ruoKonWrUQt8Kn9xUHlYHUeHnFfmqX/92fgl4yIZk3MPdr3A5UUE
	W09TTMexod24SlZus4r/nzpSMFBQEOtd70R+qbYmEqLcRlzcJ2aPUtPfleug2Sy4gdrmgKGCa43
	i0tyY3qXB8rLgwQRlBQPU2K0J40UCBCM+URtSdZWFlEzyXiIdn2aoa8oxFZwnDy95WVYeOpxZXA
	8KjcdLmDZepOswzvyS6GMQ32kbFcp8BPPb8dXAnn7ef6AK/YEsJl7bIBvdjXMwKKjWxX99a1TsK
	vMHmuSlE7YNlmL27Ze0ZqB38ToHjS1LbQoEMtZ8+eI794E/Zsc9W8iU2odRrnTyGgLNaosxgRWz
	8+6tXv1Y7MSfPkfqsLyt+aACe6B6K
X-Google-Smtp-Source: AGHT+IGyJzXu/QZWZvnsXLrxgv5e1KiAX6WTGdLvQ/PfQMXGA3E+O7CbPNK9xknSW7PUkWb5rUTiLQ==
X-Received: by 2002:a17:902:ce8d:b0:224:1579:5e91 with SMTP id d9443c01a7336-22bea50bcf5mr109395525ad.47.1744541033511;
        Sun, 13 Apr 2025 03:43:53 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8af56sm80160885ad.66.2025.04.13.03.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 03:43:53 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH v13 2/5] rust: time: Introduce Delta type
Date: Sun, 13 Apr 2025 19:43:07 +0900
Message-ID: <20250413104310.162045-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250413104310.162045-1-fujita.tomonori@gmail.com>
References: <20250413104310.162045-1-fujita.tomonori@gmail.com>
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
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 9d57e8a5552a..e00b9a853e6a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -10,9 +10,15 @@
 
 pub mod hrtimer;
 
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
 
@@ -149,3 +155,85 @@ fn into_c(self) -> bindings::clockid_t {
         self as bindings::clockid_t
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


