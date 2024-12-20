Return-Path: <netdev+bounces-153595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5D9F8C98
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4441896D57
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6812B1AC88A;
	Fri, 20 Dec 2024 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8xTPzjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A4E19D88B;
	Fri, 20 Dec 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675666; cv=none; b=A0i8QcIokDCvhwsSyk3EHQaqgHiypY35HaDoJZyvbG+19muImxSL6/xlLjsSv9TsdC7UOSlKhQ76NiNL+qVdPLbkFbdeddayiYkfz6NjGMNRCQpN8NC+c8MRUDO8/7jBMAt+qrFlK6fvoXPxtqOWPxc1ogK7qlE8EqKbrRiMv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675666; c=relaxed/simple;
	bh=Vc+8HUJI9ajHvEkwsTV8Xxd958VCwxmLyh0VR+NP/iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgbyUcxfKEcn0uGdoGjTM71wNhZ3V8/IBbAInYfGrdwKVEpWpUWOqy7oE3B1WgU+ZwKeqLF3Cr4Ta8wmfiz+NUEs9nc4xaNQvCqnME0hae0vhS3vSQ1ZIk6cMH4DYLKVhLaC8ywxp4iXDfnPtvnuKJrV6hyg9M8IDt8UtwocEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8xTPzjr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-728f1e66418so1378831b3a.2;
        Thu, 19 Dec 2024 22:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675664; x=1735280464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHj7ri5OVtg4QKKoVCyZMM8tEP6V7lzENuUM05/wz2w=;
        b=Q8xTPzjriJhneQTG6iWzE6XXo7e5NvtDahjGU7xjpqKmB1idMgrjlZJwKEltcUGD9O
         AyTSo7a/9wROTqbIJuYVBQgUwW8cK70mu42ke2dVy7oq1aasEb9Iw5hZYE0CWi5JCpA1
         nbFDlCE3bwThBKxVKnhYDESaZA87PRVAwNrLFY4Ha46ryzGD8iWCQQ3222beup9yUftP
         ep0XwPrIJ0n0+haQJ4FhsPnBF4AfLiAvCZNvDvk8Gpqhng4+0EVdlQLdGlmwkJKTX0EK
         v2en/79NM9Pd+8rvDac/9ui/hJY+NbG2OUev9C034CORJKuT8GoaqhvbC+MZtQurv80Z
         iv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675664; x=1735280464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHj7ri5OVtg4QKKoVCyZMM8tEP6V7lzENuUM05/wz2w=;
        b=Fw8vuzDMAPsixxxxUERnYDi5j8bvfs73U6yLboo6AfpGfS96BynR17gVZdbDbdc2Nx
         rDGv8t8//t4PsTaCpWyL53cpGhekybJe6+AppqSMG2uvPdr+emhKJdoqWQTR72hrzLxS
         u9VMUIW+lOQWZIevTRstCtY+iDkvX0eurJart8xkN9571TVeTRMCb1zf/tHJVe4Y/wLF
         LjOF7MZS2z3RiZPOM7pDxgZ5NbsnbOcC1wYNeTVyHoIbgAac6vR1aVuH5Bl90Fm5Wk/y
         DILC2m2L/7wr7LDuL5Ru/Jg20sNIChxlZ66RtaTHc3uXuBlvaooqdO62tODR2rUdBAMU
         f8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nomfnAIC7gHvmNn0OeeXFIjJJAals3a0j3zLgYLfh7O8R8s4CEfr6nOe7LyKdwSJvzPgDlM=@vger.kernel.org, AJvYcCUz+U4lhX8u9O81M05ZpWlfO5BhyalnvmC07ulw7q6ZbcqAHF45cPTMLddWR3vJhA0ihlR5Q1HGmnGGJ26MkXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQdL4IuxA/v+56E5Iho5Z8xH/fhv4M5bSV8XedFpjRLvVtQNMC
	0OOCyx3jtQxW4GZRjeV11nbOrSDCLUj7oBR+i7eN4ezY3e9fS3B4eKiSVuC0
X-Gm-Gg: ASbGncutou32eFPTsvxRCxxOjLe/5rNP3om+n0aSy5qCbB8y9L0Whicr9/agCs5hkFi
	OTuVF0pVQKwWqlxEFXzWSSgvyFXgowaNDghAKZ1G4rNOc1BKRrRJuarXXEu7JEwEEmO+EZgutcD
	8KIennHN2C31DwGtlJ/yJ7Qny6Tn7FPd+gkhYXh/6dnkEsZdg9p2MuhwQCuVMzPlWG7tZ5L27Ai
	zAjDe9XA9UyVgufxr9N0hyMBq6UjWrSPqZ0Z1Ur59Hwfno/wSJ1VMSWvDP4YUGEEYw7F2aiNW5d
	3w0ddO9mSoZPOtmaGw==
X-Google-Smtp-Source: AGHT+IG7D6MbXLp2ExvCaSV05bTT8A1MXC2sr0IaBVywXBIdDRJbaDSpvvsL7c3fPIz6BgPPRX3acA==
X-Received: by 2002:a05:6a00:2181:b0:729:49a:2db0 with SMTP id d2e1a72fcca58-72abdebf27cmr2065656b3a.25.1734675663978;
        Thu, 19 Dec 2024 22:21:03 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:03 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
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
	vschneid@redhat.com
Subject: [PATCH v7 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Fri, 20 Dec 2024 15:18:47 +0900
Message-ID: <20241220061853.2782878-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
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
index 379c0f5772e5..48b71e6641ce 100644
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


