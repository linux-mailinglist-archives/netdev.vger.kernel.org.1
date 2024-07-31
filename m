Return-Path: <netdev+bounces-114389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E645942558
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD571F245B2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48832233B;
	Wed, 31 Jul 2024 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmocLhk9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE6210EE;
	Wed, 31 Jul 2024 04:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399739; cv=none; b=B/+biST6Eqkoh8/WSINsvZSGohgi2ZHj51/h92bD3xbMTNqx0L+qMzcqi/MLgOEEZnISFWob8TY9kuelrEJsP6nfAdOkaCo206M9QG+0LV45GowRFLR4g2OWFjiG5QqexHIt5gGg0X3axrSxJyXTRc67rnBRKAfHuWx89LNo8lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399739; c=relaxed/simple;
	bh=VlMnWbOHgbB7/irsZJPQNTVbW+F3ocIi5Pat2kw6khw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AOpzx5HTlebXk+VCN/AHt3xn5dN9d5FPUi1/q5moLf+kfCgB8vitfJwvAebKE1QxyxfF5BxAQPq8yEVwVIooHLkpJMt0UWiz+2q0IOiLvTKojYinfFze4QwsXsXK/9AKcq/AiT4yr8b41wl2pqH8c5KPv5Vx8nISZRwhUkEk/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmocLhk9; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cdba658093so958536a91.1;
        Tue, 30 Jul 2024 21:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399737; x=1723004537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ME4S6g3J7hg1K2EVmi4NiVpdfefWhzcKB/jHmW+Ol90=;
        b=PmocLhk90s5ebQGG3zJPgMNDBLE3NpQyc7uo9XQeNMuJIXLfWtTviad5tbM2wSFICp
         Bw1toCrvs/+uxj9f+qL32RcDQJ8jgLE82FgE5b+9Ut8wzibYTMQ2NhQt6JbQPtq6GMmZ
         mWSkPkd56UOw8ps+thCO3B3SNV2GUiFruXDmNH7Ojl2FejXEMu0qSsLlQ9n2firbGFRR
         VXhUsy3YeBYl2mIbPOLuz7nCikHV/8jZ892fXy2oSq+mcrTnHkGfcSV5Z1MxGnLSL67p
         Gpjch1ZPXkdF5RSfSeyFKX+KV9Cgcc3hXZ9QF1G8PJu0VhFg5w+WWEVgtzIv6gRaWrMY
         rapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399737; x=1723004537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ME4S6g3J7hg1K2EVmi4NiVpdfefWhzcKB/jHmW+Ol90=;
        b=ouJ6HCBcVwbRHfO+mRyBGTcDNkuHi7Gp0mQsvxInVkTDZwEAldOi3jP63kwgBEunCT
         bZ9Lt+c230ZbAatPNcLVGfTF8c6zTns6Rf9ltRibSyfEcvvW/b2PTyL97Wz2171V6UN8
         PtjAd+SeugGcDcOnjuiiS7YT/1tmmM65f92sDK1GeT3kq75oLsNxZLqi0QVWSYJf+pjA
         AodfQV8/rnRAP24Pg+ULWg6WTEMGmzOxZw1XV2eZJSyVXH3ZZCDJ+jJzvNU5g2WRIdce
         wv3yVhWtSI5C2748Itt5gL1+N2lVTf3GWVxLYODChKUBteQX0CcuFxzkQ2GNON4lAAcG
         gubQ==
X-Gm-Message-State: AOJu0YyEjGQ9HcztwZ6JFs8K6h5Iw/Iwy2YAeDlfZWJq8Yu77v1tAGt8
	25hcml0f7QFMXjq0BhG63spQ0lJ6ND5z7gurkyLsxmB31grHZ/dGkJR64g/4
X-Google-Smtp-Source: AGHT+IHewVmxmUwKVd6Dx7Xk5ho3fPN8cpGBHyRpLjZ+OG8FN/fBvcAOBRdBEP1Lk1ZIcAweSNKoew==
X-Received: by 2002:a17:902:c402:b0:1fc:7180:f4af with SMTP id d9443c01a7336-1fed6bdd52amr128713805ad.1.1722399737313;
        Tue, 30 Jul 2024 21:22:17 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:17 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 2/6] rust: net::phy support probe callback
Date: Wed, 31 Jul 2024 13:21:32 +0900
Message-Id: <20240731042136.201327-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731042136.201327-1-fujita.tomonori@gmail.com>
References: <20240731042136.201327-1-fujita.tomonori@gmail.com>
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
---
 rust/kernel/net/phy.rs | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index fd40b703d224..99a142348a34 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -338,6 +338,20 @@ impl<T: Driver> Adapter<T> {
         })
     }
 
+    /// # Safety
+    ///
+    /// `phydev` must be passed by the corresponding callback in `phy_driver`.
+    unsafe extern "C" fn probe_callback(phydev: *mut bindings::phy_device) -> core::ffi::c_int {
+        from_result(|| {
+            // SAFETY: This callback is called only in contexts
+            // where we can exclusively access to `phy_device`, so the accessors on
+            // `Device` are okay to call.
+            let dev = unsafe { Device::from_raw(phydev) };
+            T::probe(dev)?;
+            Ok(0)
+        })
+    }
+
     /// # Safety
     ///
     /// `phydev` must be passed by the corresponding callback in `phy_driver`.
@@ -511,6 +525,11 @@ pub const fn create_phy_driver<T: Driver>() -> DriverVTable {
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
@@ -583,6 +602,11 @@ fn soft_reset(_dev: &mut Device) -> Result {
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


