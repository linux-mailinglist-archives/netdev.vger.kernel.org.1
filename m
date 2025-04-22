Return-Path: <netdev+bounces-184681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1E7A96D83
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 810B2188912A
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20EA283CB0;
	Tue, 22 Apr 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef680URI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044E9146A60;
	Tue, 22 Apr 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330094; cv=none; b=TnvY4IZfFcVTkPdog4HOk+AxRF3MtT/TTuX9tjNBQb5Umsp7f9ZRtGbIr/fxYNUJY4uRplxt6lLt4/FuBH5IeuBbAlgzFyV/itxjxZ8NOqOtePGMQ1+vVFjcJgCB2kBuGAGc/JSQ7IzkIgxHOqlWR3sCF0eY/QjORWRdkGE+vOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330094; c=relaxed/simple;
	bh=kd3vW/wW1gabeQG7Fy0PVk4IKsLzJY/aNs7T6WdurXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIW4ESaQkpX4iwguFzm2BXGVbzF6D7fZBiLpe+hule0UO73B2BcojdsEF/ZNEcuZZzBHmbjKaHDUxTVbvwEyHBIhVKxvi83r4xEMYLjg2AZnDop/kMrvHcxHMRU/kbfZMoyRF+KHTOofvaYxYqN6M4HRHpYM/nivJ37s01t4DpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef680URI; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso181307a12.2;
        Tue, 22 Apr 2025 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745330092; x=1745934892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=ef680URIDlzz9j1nMrL7fVQshjOvnKj7J9a83HI2yeWo3BjzgDyoSU4NaXKGx3QDlU
         OQXBYHNSJPpPg6e5rdoEzomlNoqalIYWFPnTlLqknUKSHTvg20eiTFtvRyaINQ2fkyIl
         2Dy6wkmmFBNuUfCTO1/M6goTLkr/7gZKGSxLN9clEg05xJ5OJIRVYn5VY5dE3nk6d122
         3egJP1e66UC0XuN0lrz5lH4vJbmC6+ak3sFm4puFrS52jj0Vykmci4RVdvgrEfI2ZTt4
         oy+5ZmYN9f+o7ID5VBLFpe/wkKwFWdv+oSrrKsPWDGgUVkk1KLWyvu2nVJ/WCScODhXf
         Sn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330092; x=1745934892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OA/MmqYliLwWhi3o92n3t+JslJEn4NlsVVnjQQ5ihp8=;
        b=byFlJAwC2XlInMO4FbqVIBMItR3OYSgDkcnDhMtptL8M0DmUbv2B+qSHv3xB/v6X+8
         tW+lss173g3QrQNcrKSfyGlahlvbrBqNA3FTr+91QLBQW4yvpDqTVDujS2088tXh3uTj
         372OD5RQ6m9pLN8lEQaKpobAck4pZPSKstA77mpKL0bFxqWbcNctmpGJP4injysun2Ne
         NFqWATYJXjEnDVR49LyU3b3dGlf4rWUhHepAM5ATpTyJY5BDoz+Ul6CRZ6PKfRbMZIcL
         px3vIUQiXYj/naPlSiRsVBhcMdOnLmwduk2dZcd6/4Nm0TR2SPZpETwie1Ts2AXjH2LF
         f92w==
X-Forwarded-Encrypted: i=1; AJvYcCVDBXnUk49nEp5G20Ye/76OVu8YFIdWtICqLhyZBrZY3MQptKvGJcV0Bggwa2OKp5mU9QJ3OSPHOidMTCM=@vger.kernel.org, AJvYcCXEhyXyfqKSLqNYf1qils2yYWw5HEzyo0F8TCJqolmx2qSsbMg9F0Dfj++hvktoTgFrieiN1dpe@vger.kernel.org
X-Gm-Message-State: AOJu0YxiEg5eEIeCQWAdbiZazKe8FsF58cKZTnSmd6srKbaGqTn8sa9k
	C/jv7ty8695/OfWvf8OAII2JAT3bNLxc7YAvUaorLF2YeYw5gw6HqfD0d36G
X-Gm-Gg: ASbGnctxGovZyV/PXtx4YRlGqiTkz31p1Pi3YY+ST/eAXqLqsDwr4ypcUdvnn+FPcBa
	fMqzmQcBDpqWlhVSzRSmV5A4kVLa61cQyJ6B/fNv/81j/06BGIlnJD3EBe83SzZcno/Sewzh3EZ
	SjE/Z4EYPPqdlX8dfHe+324npft0lKnJqPuebEkZflgXb6WdeFioBYRJbPtPxHoZ/ELWmEs91/r
	nMyI1eUp3HkyFs2nzxTYqFtJl/9XX4gZKGU+V6CYfFySgyyMLO25gtc1nBL5MA1LG7YoWMHgaVe
	LIHuFz1dZAc682EfBT5p2HB4b44UTjr7E9H6wndrmBdKa4P5tBS2HxvQEWNI8IRLZweT4EOLO2z
	3iA37J87wDVt2WKrfdw==
X-Google-Smtp-Source: AGHT+IFQSM/A3SMEFEI+Gb0vSvgqV3Z2tMqCRbJiessfnFICSzi69NjpfPD3Qppo4NvySWvzPM3m0w==
X-Received: by 2002:a17:902:e944:b0:220:ca08:8986 with SMTP id d9443c01a7336-22c535a177fmr292454765ad.22.1745330092025;
        Tue, 22 Apr 2025 06:54:52 -0700 (PDT)
Received: from mew.. (p4138183-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.129.206.183])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaaba76sm8869650b3a.143.2025.04.22.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 06:54:51 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Trevor Gross <tmgross@umich.edu>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	Fiona Behrens <me@kloenk.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
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
Subject: [PATCH v14 2/6] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
Date: Tue, 22 Apr 2025 22:53:31 +0900
Message-ID: <20250422135336.194579-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422135336.194579-1-fujita.tomonori@gmail.com>
References: <20250422135336.194579-1-fujita.tomonori@gmail.com>
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
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/time.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index f509cb0eb71e..9d57e8a5552a 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -29,7 +29,7 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
 
 /// A Rust wrapper around a `ktime_t`.
 #[repr(transparent)]
-#[derive(Copy, Clone)]
+#[derive(Copy, Clone, PartialEq, PartialOrd, Eq, Ord)]
 pub struct Ktime {
     inner: bindings::ktime_t,
 }
-- 
2.43.0


