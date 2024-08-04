Return-Path: <netdev+bounces-115599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F347B9471CE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DBD2B20AB4
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE08213C9D3;
	Sun,  4 Aug 2024 23:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8nxt6Iw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537FC13C9B3;
	Sun,  4 Aug 2024 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814908; cv=none; b=cUaor72dz85CgXVHMrUEXWcKPftP4FcF4VThhQROtBTI2g8fPA89FAW6OmHuNw1DjpR3chX4aQuUMbpKLWpqh8KDQki5DigSgXSpq368Q5cPkBmWWP7kSXY4g5oMo6KyDBzRhxLc3v4ojTYhGyjdrcv8cdZKQzaok5wDCxFnWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814908; c=relaxed/simple;
	bh=wW29bSCtFMJibi2MzDpnRkX2jajAXNFRbqt4OAIvvbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xvw7GWPuCknzDri8oEn1MgkIvb3Lu3l/lE0fTVZWKeaKVv8DYZhg9M54ATurJx35Y9iyBTMX9jA1qdNXvGtHRl/cGjd/xPlN3tR86At7IctBowi5m2Bkwc8xTD6Tm5KG2zC81MQu2cwwHIRKIwYP7TfJtbLzm2Gq4ZPehKWHwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8nxt6Iw; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-788485dd42cso98681a12.1;
        Sun, 04 Aug 2024 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814906; x=1723419706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//pn9qMo06/6J2HC4egkDbIKedBmsIQb6XaD6L19e3c=;
        b=W8nxt6IwWHwaB8dD6ssC/xwW6LoOU+Jboj3g9/+4gHrercaSzGddkniNN1bWduVTWs
         Bit1nP+BXEFhlGB0b6ZEgujQnNkf20SkdUClnDqsBqp43fhAXTRnXMDyoxK+faAD76jh
         duTJewqqCQffnOb6frVKGzANGFxgjk8Uokx7KrWiS9pL3w7D0l66hc8gv9p/Wbm5IWW8
         dfTaawCfwLvXQ6Q3rckUJf0OicGG1VcHSLBsEFkLWHc6D5x8S7ZUjPW+GE9AVf93f8Rx
         hEm9ZYY06UaBHcWQujzk+HEyfJrHNCeg/VBrdW+Sh4I3YzGA4Btr/by3jUSYzlGJASvQ
         FqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814906; x=1723419706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//pn9qMo06/6J2HC4egkDbIKedBmsIQb6XaD6L19e3c=;
        b=XgoIjUsdkx1yxiVHjcEcI7BgCBPFm1DBpz1nCCmCqqc/cHkGdL2ujvHj4rN6MEDo6w
         pNg+8FtafLTkHiz2+ZEoVh1TgA1BbyWZO2yfXWnn+BaF8w5nCsxEt0d6FG0Me838Trb4
         cPWEmob82GcmFyYcmK/skpAmzwA1UnXrgAzN2p8YV9SolFM8XCS//8Z6LNjQd3UDW4Ot
         B+dSvWPi+UYtdaCK2HctKWqs9YOtv5EE2iM93vJawULHO8t+pXBDh+kliVoIlyKVda0o
         1b9kxIEO5uCz6X4YRQv5/kR8fBV4STYBvpF7RGqVaBxCH9Cj8BRjt1zP9wQCiEuxYUwX
         08ug==
X-Gm-Message-State: AOJu0YzCriLj/i/8LyvofJB1tMeEJC2CPfYcUQKY9OKUVtMdu0CsSJCP
	NwXyrLWDd+TTVjaw/Ayo2jhRQLjS4HZUYPDVhaiqin8aeP6FqVRVLU5BUM6p
X-Google-Smtp-Source: AGHT+IHSlUgTCQXmmaheRUnYI/iE9sfvICI0gd/wF5fEa9UegOyJudnj5j24nDRiGS74FPGCa7K4eQ==
X-Received: by 2002:a05:6a00:22d6:b0:70d:148e:4bad with SMTP id d2e1a72fcca58-7106cfa0c59mr8094678b3a.2.1722814906159;
        Sun, 04 Aug 2024 16:41:46 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 2/6] rust: net::phy support probe callback
Date: Mon,  5 Aug 2024 08:38:31 +0900
Message-Id: <20240804233835.223460-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240804233835.223460-1-fujita.tomonori@gmail.com>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support phy_driver probe callback, used to set up device-specific
structures.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/net/phy.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d224..60d3d8f8b44f 100644
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
+            // where we can exclusively access to `phy_device` because
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


