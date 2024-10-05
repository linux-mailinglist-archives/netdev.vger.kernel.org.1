Return-Path: <netdev+bounces-132366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0AE9916C0
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C3C2842E7
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865C156676;
	Sat,  5 Oct 2024 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyDXU+L/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC8E14F9D5;
	Sat,  5 Oct 2024 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131189; cv=none; b=rI3uTEfKlgymzsJAlZWRrCDr7QxQSupRZE0vIPIakEQL0yBG9EoTCKNm4zXeKRsjr/AGfwOJMEF9S2Z1emdUcDWcLec2/fKwoyZ+h4kJapvEbC17ep8kiprT5xOog/gpS+j6oxGmZiStlcPEyxPVGxkQU8uX9KaRhZ4wBBAFynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131189; c=relaxed/simple;
	bh=KcAeSONx/DiMxyfcnJRledcFg4LXf3lzROgvJ3YPsZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEzgnwt9lys8lqVhWufsPprqj0gy5ODUcQZ7RK8oevJoXk9I0hadO9vyhCRGWra1jgji3yUWd4kCQN6ctt3kXb0LYEBA1SzX25yu20adp/Oav2/HmvRhfgkBW7pr0yyhihx16FAGZXy6t5TqnN2UdGY4FjgseSHOy6GJLCjSBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyDXU+L/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71dea49e808so1254928b3a.1;
        Sat, 05 Oct 2024 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131187; x=1728735987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR/9kqLqTs0B22yZKmgz+3pmNIwgLpkKQm87ew+rvAs=;
        b=IyDXU+L/7wrr3/mCEFiK1ikS/aR8PSoF0Zp6iNS6Zvqnw3uvxysvGDSeUG9QAfjZdY
         bPHddtvmwd7cyl4OGWlJeuk5a/Qk51BVCwgHG+GTkngUSq4/53Eq2dH2ZxIIHFZc8T81
         KBmMqkS51gvMlgkLHyUqNgIW+iqKskGZRVt60sSBO4+xmHbfei8tYCiixgo26s8ZlBiP
         XUyhhfJYh1o+ITY9w6y/UkN4Q9/tsGAiPWpVBoiRqP63cf1bMRgg7MDaZaSMAsDxy1xY
         lj+2TUEXk5wDnq0nw5nfRSeDeaKWT1ndeAJd+2b3MDgYuWwPuNX7vDzVY9mDu5/oKjCT
         63yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131187; x=1728735987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR/9kqLqTs0B22yZKmgz+3pmNIwgLpkKQm87ew+rvAs=;
        b=jwOdKu3BKCghxFBAqKvm9U29N+pk5rjKuWgJKB1G6JLP1+BLHpAwK1pS9j2KieHoQx
         aCA5oJnX9wnL6Zn/GbXQdW2FZrN0Degu/YBEHgTrXbK6K3goNR9DOz6oI6FQfxsWc4Gb
         vdvbleeTplhegIhdWt07bk4WaAtoxLHInVv4mfNxD6bO+hJBEIys+lkCz3Ya3Iu6TVlM
         QJq3pIMqxcgdMATKMTf+m7VzY32L/3o92anx+7GE8hVm+DiEI2jIV4zEJTzCkDn4+gdI
         g56K0ztMNWCjCt57Hamx16lHMlGNkcgji/rlBWF4b+dIZ4A5HLpnZSF9BU8XTX0SRON8
         carQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3bcenvdqfWDBpeB6imI/LYukMsw+26nkRnFmTNsA8lspVnswUAk9asgdyERKANzjkYphoeLJipCWnKTE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt7GepTKoSEzMvfxFJmAWZRTmjyuezmCLdEdoYUnV1Cv3bKteb
	wZRFI0R1r/FGzOo9GXE7MJ3xUbbUmZW9b3xSdMDTPesWiIA/iQwJfZUVpq6f
X-Google-Smtp-Source: AGHT+IGM/R6UCUnLz5gHhmt80Zj8TRtxwkmL0KFhW4UUxT4flbS3jpdytc4Y6DzO6Z9LcUNf2SW8Kg==
X-Received: by 2002:a05:6a00:2e27:b0:717:87d6:fdd2 with SMTP id d2e1a72fcca58-71de23a89damr10684913b3a.4.1728131186738;
        Sat, 05 Oct 2024 05:26:26 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:26 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/6] rust: time: Implement addition of Ktime and Delta
Date: Sat,  5 Oct 2024 21:25:28 +0900
Message-ID: <20241005122531.20298-4-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement Add<Delta> for Ktime to support the operation:

Ktime = Ktime + Delta

This is used to calculate the future time when the timeout will occur.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/helpers/time.c |  5 +++++
 rust/kernel/time.rs | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/rust/helpers/time.c b/rust/helpers/time.c
index d6f61affb2c3..60dee69f4efc 100644
--- a/rust/helpers/time.c
+++ b/rust/helpers/time.c
@@ -2,6 +2,11 @@
 
 #include <linux/ktime.h>
 
+ktime_t rust_helper_ktime_add_ns(const ktime_t kt, const u64 nsec)
+{
+	return ktime_add_ns(kt, nsec);
+}
+
 int rust_helper_ktime_compare(const ktime_t cmp1, const ktime_t cmp2)
 {
 	return ktime_compare(cmp1, cmp2);
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 6c5a1c50c5f1..3e00ad22ed89 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -167,3 +167,14 @@ pub fn as_micros(self) -> i64 {
         self.nanos / NSEC_PER_USEC
     }
 }
+
+impl core::ops::Add<Delta> for Ktime {
+    type Output = Ktime;
+
+    #[inline]
+    fn add(self, delta: Delta) -> Ktime {
+        // SAFETY: FFI call.
+        let t = unsafe { bindings::ktime_add_ns(self.inner, delta.as_nanos() as u64) };
+        Ktime::from_raw(t)
+    }
+}
-- 
2.34.1


