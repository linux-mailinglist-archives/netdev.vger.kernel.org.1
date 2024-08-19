Return-Path: <netdev+bounces-119517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84B9560AB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8561C203F6
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EC6208A4;
	Mon, 19 Aug 2024 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDkRtaEs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCED208A0;
	Mon, 19 Aug 2024 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029237; cv=none; b=ar2S/FGund1aqCUrUaMB7FNqOjwONZAovfQC9blEbTxF77BH6hOEcdB5IE83s+bGJvWnSlYfc3Tsz8+eVPyNnY4OMydgl89XQeXUFlKABHvy8CY3zQ1pBmwGlUe/dg/aNpPMhcAJMFOWUdnEQ0oe/GpOyzpef5Rldx/EMVus9ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029237; c=relaxed/simple;
	bh=vUIxXGv09GRc5aBu/neSNb1GummZ9qZKEeeQN0wo22A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwcCSIqSzh8OsSKTLuPqnHuMsfF7jvJ2usRE7FQQXtQYeee1lHlefuGEmkqn4d/aKbc2RwLhIjBH9tyRqpIJ6CWlOpwsps8duc2iTAqC1qkeJ02KzZe5GXULULoZnli+eTRYQlz9t/FNXG9EUiOaLLufkgrM98qWSYfaYovVTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDkRtaEs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d3f39e7155so466154a91.0;
        Sun, 18 Aug 2024 18:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029235; x=1724634035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XazJ8mTlycGs5dNR+W4h8gQItndR+sDYEfDvhQ5CokM=;
        b=jDkRtaEsUfnM2aj6CZd0hTO0EbrB1AEQXtKYEqqCNIbFvkKPoOTbfPBKLll+5WDnwa
         ClB/mxlTU3UVUqC7MIn3YErCBuv3K2CNpRTMjmpgxG2C52f4tkUdYMSmWByV4HdWFY96
         izURF2NVXFBkwQ/fwHJ6r97Wh4hr2lrj9rtEq9OAUCKsNvGwYmWCbpqCda3Z7RFjrgtB
         T66ZQGoFpuS1a0PSdk2q6trIMLGq7FhQnrh0ggjgxlhKi35Yskzm3sLoJC4qrD2aBncs
         4rxKsC75Rzjm4Z8JILji4XAAYPiTxFHoWKGCMBPC0yg9Qr/cPsmV2u9W0W2iSULHtt5l
         OO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029235; x=1724634035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XazJ8mTlycGs5dNR+W4h8gQItndR+sDYEfDvhQ5CokM=;
        b=TFyWKw486WnGbAvGEic09a6wK/bfHBmW2Ydohbe1w9KzM+vNAk9mTX3cxWdQxYzZVo
         khaLUPThhdVpssPWJqkECCN8PpF6R0dwCq1F7MQkhRiV0j9NzLLw4TiyXDNGQKRsXfqh
         Skkem+JHDgwkFPImCazmj0iTr1sYejJJx1vGZka9LhnMBESBLVomrdFoYPEOMuVyGprl
         WSI/y+DzrkbNSWQX0f6ddxC6FQcS49wcex7ALby7hb/dxuz6/YN01ZYZOV9q8Zd+lXeG
         q5w8p49xu5/APvG7UDQuf5GLJ56DfnR6AvyBVl60x2H2LS5Bls3r5FVv06Zsjnhmu0b9
         /Y1g==
X-Gm-Message-State: AOJu0Ywzg49wr7zkJi2OIUCv/YSnK2VtRQY5/kk80oyq7thwFrmASCeK
	0Y726PLA71PcvUdahk2Wz7y/0gTvTIN28FOh/zmNM8YMI1BL+GTl/U/Fx99m
X-Google-Smtp-Source: AGHT+IHJEFDYL6xCYegZiVOw7O5OID8ZCfuLy8lrRNDqIrjpd8qx34ThaBBtGZP4h7U+Fdbr7XEO8w==
X-Received: by 2002:a05:6a20:12cb:b0:1c6:bed1:bbd0 with SMTP id adf61e73a8af0-1c97beeffc0mr8608877637.0.1724029235068;
        Sun, 18 Aug 2024 18:00:35 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:34 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 2/6] rust: net::phy support probe callback
Date: Mon, 19 Aug 2024 00:53:41 +0000
Message-ID: <20240819005345.84255-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819005345.84255-1-fujita.tomonori@gmail.com>
References: <20240819005345.84255-1-fujita.tomonori@gmail.com>
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


