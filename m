Return-Path: <netdev+bounces-185264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E71DA998C8
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 21:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1402921028
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201E2949F1;
	Wed, 23 Apr 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpJht6GI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6B1293461;
	Wed, 23 Apr 2025 19:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437313; cv=none; b=aaRzRIDazx0XPAV2MBmep7WGFMFPZ9LFxeruhyS1y8f9iyfmNkv9uh7L0NnRu2YFPNzZoSbbFUTFV/87nQvTzyip0IUZHKT0PJS930CqPfkfZMjdUtuqMK71ObrqQ2rF7yTiJAbX1iMtZSYwcSzksjN8Lj1l7iSva7wFkmlKVTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437313; c=relaxed/simple;
	bh=12o8EpFplw5vxKVaPZGoT3TplIy82zwNzBv2WcTOE8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZ6U7VXz4Jfh6UqtCAQQ2thmKxlZCUuPlxJN+Uk8eJYp9r6nAFSN3R/9Z5XGuE7a7EbNtUG0tWISwwzkmkUtsimPQ26si8Iy/k9TrNQAw37gCZ1+Sw0fPEsfifBew/jnRx7z+D2JiMM2k1Gpomfnv743NhTQdcN1I3P26Z1Kmb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpJht6GI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-308702998fbso261226a91.1;
        Wed, 23 Apr 2025 12:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745437311; x=1746042111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=YpJht6GIttdAu2jMXZXQBSIHCq8CSMXsq+D+lAcjNwQn7Q5A34JpKqHwEGK9Fut79r
         6WAroo0uMeM6V8aWspRLzRpjBngjWLRfEu8PdUnTE7OubChkOlszPkKjmE3s4xwLQ6cs
         A8Mb1Y6c/GgHRJFZfRHUHVU4/IFni14wQrl4pOgjzM2SQ/tqj5n1N3auVmI/9Ot3/BL9
         RdI29SnkCkaGtovzRFIX1iXM635vi4syW5oXgYGQyv3uwMUT692bikg0Hu9xcSnngy/Y
         J/AZtADS3jKFQcuvABIJzc4nLUyPBlY4LVT9fsd0gCiONAcFLijNr4FjEpTP14VV0kiX
         cvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745437311; x=1746042111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB3yUUfhGJKZTpW8owaV/xnUEivaCxVXrQXi/bn6tLQ=;
        b=foSc5LC7AG0IeY6Ycv+eiXc7GJTaxBgRCJGkOO0vFzYw1jswE2lEtDx6J3tmUhJ4KA
         7W7jXZT02fG9WZcMypkuUTh7d/F/LKMr43K6K55KRU4HOVVzHdykdpHomBmIPIS5r242
         pL4A1by1iwrBp5+Or11siilbVX5zvs+9vAG+/pmg4CJxBe8eBlHBsSbnlg2ZWtv96O8x
         fVsi7Gu/aWfsemzgGuhhGbsMEyE08G7U3bG0DzB9u12jKajvwxXZRlFNtzAQB5/eHQr3
         VOTCBiA5cKEXsXGFrgGNyZjdJ7miKnwm8jJKZkjGv5vU92zlUCmSBHVQvCGUquUKiKlo
         oT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUozV9l2LhAb8379P9jVQvpigSk+yxm3zdoggW26U1pdlktZ4/YusXjRvxh7ZGo2iStt2KtAWd9@vger.kernel.org, AJvYcCXaq9YYj6yBzrkPhC+B22yqkdoAxLexEByD6XxYGARJ1k1U9PRGTVLDQ/QM+rfsHLy35/qS7rJL1MD45ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4hzPgb96JXSwjm6frQA5X8/+LRMTCM+5pjTDoXvC7H9c8hzf
	u18DBpH9++M5faDLmfdT46rJ18bSue98TmdJzLsn6mIqokTNJ7sGHR9Wkkog
X-Gm-Gg: ASbGncsv3PpzBi+1kPpcV/qv1+ngJWR7jc+nGyEc5twn0P5KDTaadLicy1ogUOQveIt
	Sl/ODuakt/UtZU0cVTa4AjcibvZitZHw5sGGjfT5lJv0FQV0zgkbl8D0YhyNJri8eHpQJopFtFK
	R+b5MrL9bIyvrSbz6igQx0zwI9sGy8oWHWamAYY+YybS1QGAmaoQXALLGa9RH2hd3hlIWyqUrXY
	faHazN/cvTyB66m32Mon2/5St4OXRTJFcW0pl+HxG498zC5Z/iIr3e5UdB/48XrDx7eQNKn2SK3
	s2TpkytxTEW5cuG09FUhb2l55JC3uP+74HSRjEIGtKSOIpjqDeuamOqYxDkhWZxACpVKYGduDyW
	f6XZOKKg5CZcVjaGI9w==
X-Google-Smtp-Source: AGHT+IGcS3ZtMDXlm0p2dxnRXQ6Gh4zJOqlR2ipqQYAoCngciLC/1Zki0gl5uXqBifGp9if2TnS62A==
X-Received: by 2002:a17:90a:da8f:b0:2ff:6fc3:79c4 with SMTP id 98e67ed59e1d1-309ed33b49bmr58989a91.27.1745437310562;
        Wed, 23 Apr 2025 12:41:50 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9ef918sm2056475a91.7.2025.04.23.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:41:50 -0700 (PDT)
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
	david.laight.linux@gmail.com,
	boqun.feng@gmail.com
Subject: [PATCH v15 3/6] rust: time: Introduce Delta type
Date: Thu, 24 Apr 2025 04:28:53 +0900
Message-ID: <20250423192857.199712-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
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


