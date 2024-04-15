Return-Path: <netdev+bounces-87862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5AB8A4CD4
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFEDB22B9C
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111625CDEE;
	Mon, 15 Apr 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gejsSo/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22F40875;
	Mon, 15 Apr 2024 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178042; cv=none; b=phH4hTI8N8KVuTvJTdSNZbd0y70mL1spwNP3fKxHoxwa5nyql8YIVLKsG3sTEO6mlczyZE7fyjuwrMTsLT78AONOkQIhCoFJOJ0Xa+WbW4+xKJBP/ybs6luj2iEChqDhnoc7BS83hR68CClV6SGPv2S8iHkHt+686LB24U1GRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178042; c=relaxed/simple;
	bh=nD1tEtqg4j7krrkyj/awg+O23r5SRZZiEXAq11MeqdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlqL+m4f5TijKQXMbabxiGDY3AN5xwzmypt4DjeiAxjgnmTwnh3I4RVHvklSKZNgMFyFzS8U00GVhtcjqZsMJc59WwmOOSpRPo9f7CWkJMgQ/jt7q6cVJxnZ5xHVYSbD+PGb1RyhjgHtusBYueMaFqch3x4jMJos4lC7jVkCC/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gejsSo/v; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2a1654e6cso6694035ad.1;
        Mon, 15 Apr 2024 03:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178039; x=1713782839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o93WmUwILj9Ylyz0cHUrPbesxHIpYDmgZJzB+S+Les=;
        b=gejsSo/vNrSqyBXN49/jBH4yaaZUaiABtxoNtsSirXkfA56XEp/W8T+1DMab5WsDCt
         uP5JLNBasdAtEz1yT68fo+6kyl4uNMcbSq0/QuxNNRrY5k8vw9x2+0hGSQiqsgx5WvVl
         X7uT6kIWwjYfaPU8Hz/8XqMJGlVg2P1RyQQpQFI7koLSpr4vPRbVRynJHNcQ82FrA3Qf
         9oqq0YcK0V/cHEcO/OEpZyAKZ7vXDTf5FbyBJfkdBYYxvazoNXgt/gZlZkrdQA1tJbYN
         l5pgwBQrU+TJ4AjbL0bPDAmyDdFJMHh/U+6v4330Y7JEadEUtJq8DoYF452yX/yvv13y
         54RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178039; x=1713782839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8o93WmUwILj9Ylyz0cHUrPbesxHIpYDmgZJzB+S+Les=;
        b=fuI1MjIbuZ0AREfM6P/SyS5L3TGA6zGTlYp4qZs/Gvx7W7ma6MF2R6eyfYvAZ3gGz3
         7P4jvIcIu0BAT5ec53uEyneHtR+lLrLhXzu5NhCkMy5JRUL8h2VewdiOszXNYHAdMRtk
         IO+IjBEpgdMkN6unJFCqFXhO+zFf9psM/5Haa1rHCv+ZypQ+CWodFf97uAW4bHR8v+iU
         ph4b6bQ9jkZjX9Asxp7ccsId909cX+CI1eTmgwAP3J0/oRFsWH8o98oS74ls540TMBL4
         f8lvZuAY4DP/ZG9Df6spb9SMunl0idPu2lkiF0uW5LpX5C81gBA3rZ1U15Dk29cCs4VB
         t+2A==
X-Forwarded-Encrypted: i=1; AJvYcCWjA1ERXp//5r7dU356aaNmg70MuJVlLCDhzagNlrXKiWx8dXyolZszc6wUEb9I+DDZe+zNqXEMVFSu3bjkKvH9bY5rAdIJTsXJb+tJllo=
X-Gm-Message-State: AOJu0YzUV2onTD7WTMCd7HRWS1kMcjtr/mZjrXajXkMfXhsaVLTBHl4A
	SZh2LNV4iAqwp+A2LxSNxVAYAG98c/5oDKVvLJymE5bGACxh2/sTx9K8JQ==
X-Google-Smtp-Source: AGHT+IF2HHNmxBM0EgCJxntqHrJuV/y+/K00HLr6hdlIoL7wXYBCGXaX2KyRVAboFE6fhOynpp0Dew==
X-Received: by 2002:a17:902:ce86:b0:1e5:1138:e28e with SMTP id f6-20020a170902ce8600b001e51138e28emr12017943plg.3.1713178039055;
        Mon, 15 Apr 2024 03:47:19 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm7807806pln.8.2024.04.15.03.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:47:18 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH net-next v1 1/4] rust: net::phy support config_init driver callback
Date: Mon, 15 Apr 2024 19:46:58 +0900
Message-Id: <20240415104701.4772-2-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415104701.4772-1-fujita.tomonori@gmail.com>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds phy_driver's config_init callback support for
initializing the hardware.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 96e09c6e8530..44b59bbf1a52 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -338,6 +338,22 @@ impl<T: Driver> Adapter<T> {
         })
     }
 
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn config_init_callback(
+        phydev: *mut bindings::phy_device,
+    ) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we hold `phy_device->lock`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::config_init(dev)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -511,6 +527,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
         } else {
             None
         },
+        config_init: if T::HAS_CONFIG_INIT {
+            Some(Adapter::<T>::config_init_callback)
+        } else {
+            None
+        },
         get_features: if T::HAS_GET_FEATURES {
             Some(Adapter::<T>::get_features_callback)
         } else {
@@ -583,6 +604,11 @@ fn soft_reset(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
     }
 
+    /// Initializes the hardware, including after a reset.
+    fn config_init(_dev: &mut Device) -> Result {
+        kernel::build_error(VTABLE_DEFAULT_ERROR)
+    }
+
     /// Probes the hardware to determine what abilities it has.
     fn get_features(_dev: &mut Device) -> Result {
         kernel::build_error(VTABLE_DEFAULT_ERROR)
-- 
2.34.1


