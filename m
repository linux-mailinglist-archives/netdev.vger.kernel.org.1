Return-Path: <netdev+bounces-121557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1EA95DA7F
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FE41C2195D
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5A18EB0;
	Sat, 24 Aug 2024 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUxvlTv8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618725762;
	Sat, 24 Aug 2024 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465318; cv=none; b=rvLQ9cMMQjILB5kdIBkrew5vNGbLRHV1Jj0TXc8pk57dNgaimUp44z0X4ouHt6R0ZleZR8M8pGcGoNVNhaH1J3HH5cB08QoGMywR+CXh/YuXaV9/v8Etqj5SPiuJJdAnEHyQzxat73LyUeryxHfUeFV9cc9EpZ6lY+wsjN9XnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465318; c=relaxed/simple;
	bh=Z+3W+TjB/+akxnGD/81jh9rFeSs5dXy3N237wOpbV+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+nk7KYYXYJ6gCdGQndZeP2KsH5VrKjbia5nzpDTzYZhhOD5FHIBe7n3fu49uTWRa6RCrGFx9qNppnhXpF6m0fEYe4MXQ6JC76odeb+GwjEjP7Ss8w2JgmfZ6/HLHNjlg4HfSp8yhsEc2YNFP46RbvWPy9ZmeILQZXtDYxcVmJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUxvlTv8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201f7fb09f6so23193125ad.2;
        Fri, 23 Aug 2024 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465316; x=1725070116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=lUxvlTv8o7MCMcCE/9NMmGHCFxiBupBuzmL2tsrl1BJMLY1IpUzmJpfJkeBnIilFAi
         nUo+0DQBKVvz06p1EAbv6Jpg4T8ASMI3J9ohc7jnxmDFEN4YKigEfcp5d0tKsaSu68m0
         RKUB1LqBiQG/HRWokpjEWvTEKzCfKgrUtBFE3WFxa+5SCO6mRc88XFnyXImQvbqsLtjZ
         ZSe9tWVTgeKQeGQYSEiYrraknzBmuUAOQEK1d/fyQ7mWZQ0IZSdVF4go2KL3rXhYdhd5
         4WQFbiyaWsbAJ9xyPj6zunZF3bbtACYxAjC+uPTdxxvM2wRtujZoZzCkqtnkyuVh469x
         k7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465316; x=1725070116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=XtdUSeAoTO6ERuMTTQS68uG+8Rk3k3JhzaPa2eIML1YzZtXWr8msxj8sV5zJPUQJAj
         ENJ9Kin1et7G0hlgliNVi0pI7u9jYrqOzCiKq+XO6V0rynyC3//U04VXHOh6AyXTsUfh
         2Wisr8dFV9wIziA3aRCWO32ClI7mbW2Q5P4GlnIRj2Ebu7vXExYYmemplpdxYX1UaZV0
         8v6jdnNH0b2KyVFiLzWiYnCHl4em42eq5iCIEiX81XIunw/BTnsBDjfo/sqdH+d7W7hI
         43+JRFafWxPWFTPhA9yompN7H6YtisVgHhIFX14rWB/5POZ2ewsE6U+hmVlQ1p5kAbwg
         mM5g==
X-Gm-Message-State: AOJu0Yyou1mrj6L81QzNSnQuFGainNhJLWfHI3V7PBwIow390VktiUL4
	miv/bdCT2LdwLspsMhCkklufvMjJFKYvg5R2ptW5D1bPdFykJPAzVomDBQ8P
X-Google-Smtp-Source: AGHT+IG+YAqUd2Odi/UjufBqpYpla47k2W4b1Ke/siKgWeRIIrMp+v7tBwHViOnYAjUFmHzqTKOSUQ==
X-Received: by 2002:a17:903:40c6:b0:202:32cf:5db1 with SMTP id d9443c01a7336-2039e50e6f3mr42502735ad.44.1724465316238;
        Fri, 23 Aug 2024 19:08:36 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:36 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 2/6] rust: net::phy support probe callback
Date: Sat, 24 Aug 2024 02:06:12 +0000
Message-ID: <20240824020617.113828-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240824020617.113828-1-fujita.tomonori@gmail.com>
References: <20240824020617.113828-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support phy_driver probe callback, used to set up device-specific
structures.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d224..5e8137a1972f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -338,6 +338,21 @@ impl<T: Driver> Adapter<T> {
         })
     }
 
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we can exclusively access `phy_device` because
+            // it's not published yet, so the accessors on `Device` are okay
+            // to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::probe(dev)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -511,6 +526,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        probe: if T::HAS_PROBE {
+            Some(Adapter::<T>::probe_callback)
+        } else {
+            None
+        },
         get_features: if T::HAS_GET_FEATURES {
             Some(Adapter::<T>::get_features_callback)
         } else {
@@ -583,6 +603,11 @@ fn soft_reset(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Sets up device-specific structures during discovery.
+    fn probe(_dev: &mut Device) -> Result {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Probes the hardware to determine what abilities it has.
     fn get_features(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
-- 
2.34.1


