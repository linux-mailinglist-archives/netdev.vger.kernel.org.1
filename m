Return-Path: <netdev+bounces-140858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2B9B8817
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD14281D5A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA37353363;
	Fri,  1 Nov 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHI8nVAb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2967F38FA6;
	Fri,  1 Nov 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422943; cv=none; b=X7eggeSyrpcfEXcHnGAV7sN3YTJSIMVwq3dgYnYJDcxXUUkh4f6oAikxVlb5xjjgfUmf2QDKdrcMM3SYjFydyW0ilBeY+r3X4hDTFfDgf2uakVXBTxAMbPIGAjxob8zifB143cPXjdwRxhs4ELqhW4ReLHxHB90CbApkUIbAP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422943; c=relaxed/simple;
	bh=ty5/y7Xtb2hwXPXaqKl+csNiJiUlRX6POVGSNuNzKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/062jMpiu/NG2StGWvNXW9YKi2eLewygOmhtXJbU7jOx0e4ZDZFditn5p6qwnvWv29QDMzuSWg0DEZDGf6FODFzhMRhWr8x8VQiB90H21bHeE45VLV+2J8Xajtzix/6exRvQEn8rb+7JgC3oFCXcooExrNI07jZFRItu0S2XhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHI8nVAb; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720c2db824eso954217b3a.0;
        Thu, 31 Oct 2024 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422937; x=1731027737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UR/Ms0FQM0UCt080++CvJa6JNyMuRguxnIevuegujk=;
        b=EHI8nVAbzMetpB8XqFtwYRvkn+u+OSC1V+vMUSeUgAhqcSCV+ILXK2Q624fD/hig3H
         BUtL68VE5BtYIPexDd0249iSaW87ykWYB0Ud9rjhA4gCNMGVc6a/6G+xi250jEa8PBrG
         pz2ATQdylFQPTDkfS0Y74KlMs3A2UbFnRoR/SYyA8kKuDaSFQEyViW/GReeiWWJYI+9p
         kWhtK2jm6HUpGBx8ADfOAxi9Aj66ZNjytM/5w8+zLvoWQ+FuzJT7wQGyvRCxQ4+MlL79
         ER/Vq9zN3SMlPMurk3tkvjlUE26mtd8RX9Tjs75wchfXjthx5UX7vv+9TemxDq+5CL5J
         Tn1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422937; x=1731027737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UR/Ms0FQM0UCt080++CvJa6JNyMuRguxnIevuegujk=;
        b=KYLlJJQZhO+TJTxmGc+NxaQtpEcjrPbTaZtL0hMRBN1AlmvEztM5D85atLEFoRQVef
         l3vt4tHG+uVTwBibRJWQD4dGFjehkyuGInn9iB+CW/HqGTZnSO5x1zSdG9C0tA8LM4PU
         phPQSN6Oe3Z7gQiLom4LmgHmyMAiHxvrMlJ1iZwndVZ9Fpk2Y4/gJSIWowISLG+a5rGs
         yb3ShdrewQhocVFZ0nTfR2+5iRuvPXD1GnXCefZ19xIgE0CcJQPdxuJTKO4UpxlTkxRC
         sPT46jTod15mZCXfQ+biwQDPj9VBTp50E8Sreusn/NDs/8VvwTHqdzgbd21b8EmAc01D
         KU9A==
X-Forwarded-Encrypted: i=1; AJvYcCVRo41FwBvGjtLfGRjwoEhtpwrtx1TOXnVb1wMJahHvFojhRu2+D/DaYa4c61H86vsVi1HrroBatmEGfMMwc5k=@vger.kernel.org, AJvYcCXhCxvF54+Tpd3y+MD3G30ShFxDrYwqgluKKZegx1fNlQGvpl49CaVo7LPOD73n3efsfEicUVvFXnuJnQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt5QToX1YIbekr2lpP64o+M5of2BW0UD9wS9kcyTB9A9s1Tycg
	uWl81t0qQGBwgtcaT2f2mUh9QzK51cGTHUHVHacKR/V2bdyiDgiZ
X-Google-Smtp-Source: AGHT+IHq9PCnfOGKPlXnGN+8ljS5aTE7+Ms55aNXzF9qxiuWry8bC8I/0a9Qg7t83bcX8lUCnIA0xA==
X-Received: by 2002:a05:6a21:1349:b0:1d8:a96c:e9bf with SMTP id adf61e73a8af0-1d9a850a5a7mr28826274637.44.1730422937462;
        Thu, 31 Oct 2024 18:02:17 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:17 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
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
	arnd@arndb.de
Subject: [PATCH v5 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Fri,  1 Nov 2024 10:01:15 +0900
Message-ID: <20241101010121.69221-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
can be compared to determine whether a timeout is met or not.

Use the derive implements; we directly touch C's ktime_t rather than
using the C's accessors because it is more efficient and we already do
in the existing code (Ktime::sub).

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index e3bb5e89f88d..4a7c6037c256 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -27,7 +27,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


