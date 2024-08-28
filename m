Return-Path: <netdev+bounces-122648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8526A962163
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D6E2823C7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689B215F3E6;
	Wed, 28 Aug 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ghm3MdCN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FD0160783;
	Wed, 28 Aug 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830613; cv=none; b=uVhtBxCoCIbJaeYqcdUKTSlp6o1dY1z1SnIhcah17do124aokQR6FZWgN/W9sWB/c3Q+TW8qpyJApq9RXNrLWhQT9GOUCuomitDbExiywe1WgZd1xjclFvMAo1XdVCWe+pfaIr9vnS2gsvkyYLYaJ2sp/uX+bJjOtMJiMMhiqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830613; c=relaxed/simple;
	bh=Z+3W+TjB/+akxnGD/81jh9rFeSs5dXy3N237wOpbV+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OH5psDcNWEy0EMGXlY75n6TPEowR4dlo51otpGGwTUfS4pWfW+Hob7jPJWqnIU9vB21pv/0srmF9OyZOgrmRqORewqjmwgQJ9B+mtFtJX0qpoEjjgY0D797wZQQu7jcv0x2jDDjJOz8e5gAhqTG4I3feO08ji3DyyZRUG3TkJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghm3MdCN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70e07c1ab31so4902103a34.0;
        Wed, 28 Aug 2024 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830611; x=1725435411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=Ghm3MdCNjHU/7UMUxjcKGAGI/ywXR5JB2Apk00xj7NgUwFZ61Pjqi2/2dR1I7V+gKl
         sJQ0pRDL50BjYdDP55m7a+YP8Rlw7ut161yDzHYkjpEDJ+dHMCxAB2rc4AqgOO8X1UbW
         z++LHbY3SfPm4vJMuXUImak6eGrdpqZjkdudnCbmOfvv2/FvAFYNJtrk4mvB14XdODXB
         3fBIfGY762bKZWIeZLuT8dxV7NlDDJiZekI0Oh6rSyiBfLNP0OSkaoYwFqXKlP73805z
         sHKl9qHFenTKKC0uxLOO1Cu6eDnXkbky6CwVFKpomwGurf7o/lEbV1mNvFOzLdw1OZ/Q
         /AZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830611; x=1725435411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEn+T3edq3AlPKEeI8Gs8XwEjBjg6OpikVH3BRZII5Q=;
        b=e1OgkBi0NrXPIXM8kG3Bf3+IJiMfPPRIPN10XHMs4P8NSd30So0UjplhX5lpXkqfa0
         ll7nC+9zgHlI707mlG6bVTYyr5K7WQ3T2+8hshaj39+UynMavlVgR7pyeHJt7nDiSBKZ
         Ee/3bwYaNZYLJXp+fLgMnYy4GHTNs8nEFnGzyNtopaiM9aTwyiHVSXfObBuLRMh25WOD
         K8EoypTqxfBVm+1216RwHXW9HQVlyf76C3TVPXPy1imFT7p0MZ6/22S+awKtdEgTjGgk
         y4Rg1zoU97pftavWS7PI8AEHbMlw2nObDUJn/ZLHhc9kZSfL9CK4DRQ8diDfry1ce61F
         DPHw==
X-Forwarded-Encrypted: i=1; AJvYcCXNDP3E+Q0Dd/LJsHAedgPJXF3sjEHvnmj3mkpea5lkrib8EzyhYrEk7kA6BFr78hszoxk8oYZWUknMzAHHrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEYJuudzROST0fDSbQcC9cW2n1eFmJjxKM8ff8A528KC9ROOX
	Fc22vtBfiIMH+oBIkFMD6CpIThU4OmtYy2aldGeXT6X8lkCC5mhRqUxmTiU5t+M=
X-Google-Smtp-Source: AGHT+IGAWIB2Rektk4c8hPNmZsYyrri+3l9GgFv6TaNxQR/UnmGve76gj7tjTTdR54s9YkiIgziUTg==
X-Received: by 2002:a05:6830:600c:b0:700:d3b7:4ede with SMTP id 46e09a7af769-70f53ac404cmr1259668a34.27.1724830610631;
        Wed, 28 Aug 2024 00:36:50 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:50 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 2/6] rust: net::phy support probe callback
Date: Wed, 28 Aug 2024 07:35:12 +0000
Message-ID: <20240828073516.128290-3-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828073516.128290-1-fujita.tomonori@gmail.com>
References: <20240828073516.128290-1-fujita.tomonori@gmail.com>
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


