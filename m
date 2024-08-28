Return-Path: <netdev+bounces-122651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D7962167
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEF7281F57
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F1D1684A2;
	Wed, 28 Aug 2024 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wdr6swpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC3160783;
	Wed, 28 Aug 2024 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830620; cv=none; b=NekDtIDYzT9gsIULjucf8/t2fYGud4ZXtg3t0sCSOeKLvR3L+yrC1rdHLqaCbgpoJBHwy69xS31kdQImbZfzPFRqvQx+zbz/Jm0VydwlKLLpO2hlL45M0AnGUz87ThLvC5kRMR/2itpyhjT3ap+oKFwTCUW+JU8rhAhRJFwFQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830620; c=relaxed/simple;
	bh=fmaFkVQcvY6JJhqKe96ZnDZTjLKsGV+aP7hDCXQP1ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA2kg+07HIe90DC047VFuKGwzWEHVziENZZyYflvoJkJfg/wBLB+NDSYVDbKg61EOXIbdDIApJHRDoKkx8jke1nvF5I60r+9nVNy6l48TPjiNJIdd9Tt/tz8CU1WXWlpC5GGWHtKtOO1PG3ZYjbVP/8VaFxeCjDWH2rMpr2giVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wdr6swpZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-715cdc7a153so261177b3a.0;
        Wed, 28 Aug 2024 00:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830618; x=1725435418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qQxWIg1EEWwKzc/SOJAE4/A/RWLbXcic6JIjq2SU5I=;
        b=Wdr6swpZOzUr8RDOz15Z56xFRYkBjwZB7n3qKmWxU46vWZUpEt5mv/M6sFteHHxPQg
         THlMO6HT1nmjlYdJ1A4/nkPAwL98mlSDhaEMSb76EFwiOVOrqOs7zE5InNgeqkF5Bm2U
         RljPgSskqdHRV9mqTrfsAJgyYXmc4Wq1E+LJx0CBPrQmm1cTBmbQTiglfjt877ZlJG2t
         oSZ7nGiuuWnnISMg7WVi21AqBHUEbqxqzYGLlxR1EWMWmdvoF0AbVYcJyuoqyaq4Zvp2
         pnMLouOaiSSMxp5l7KqqW5JENguuF0S0OE3klUKUSFHOTTpHGmBy1EEYKGNfF0VsJTH5
         UF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830618; x=1725435418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qQxWIg1EEWwKzc/SOJAE4/A/RWLbXcic6JIjq2SU5I=;
        b=NCiOD+Pd4zzjIG4Yl9pH/jLl2QFES6ES8bjaAJthvS3ldVPRPTImEa8Ao/K2bN2Ysy
         BWShw6cGowXvYeRn/K667/NrPaISSbZmtii1n5vq1c0OQTYOMrUXFPKnJmFHYUytAgeh
         VzJF0JlubMbbnDamg87TgK9Jfl0po3PlPyGpTyu9l8v2kRuLvmxxcy0r06s0nECQAT7F
         LXzJB3tV2f20zxuwAD1zepTMgyQdQJbTbgaiwSsvSWxwxJJuKA+bYRdggn4BU8rOv09b
         IvqpDw0AGCTYWAqi7ODJKdvp1e2Hanw4COLqWFLb2vuuGZalUkXt8MDaUUiGbeSFQ07j
         ZvLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrw6DtmnNgX9nbz9BdLO0qiwkD4FZ88W3M9F1TaGxf6CLTVfiJxFLdHj96pg4v09QjKGbPRqqpajnzX1zDXw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywGPRUi6qE9Z1BB5I0QhXRmAZvWGvvYimtgGPHJQVuc8xv60wc
	+THfeYOu+Pt2Saaud3DSLBJduIek8mtbaKmIJvRqzN1XoZ10aeb7NY9IichOt6Q=
X-Google-Smtp-Source: AGHT+IGfQNI5QlFiL2lIUSDkNAlt6ZJ4nnRGas1yjQojkeqWpTCIShpTqZDaY6VvUnNMjcksEqsffg==
X-Received: by 2002:a05:6a20:d808:b0:1c0:f09c:1b98 with SMTP id adf61e73a8af0-1ccd1aae729mr1943814637.16.1724830617747;
        Wed, 28 Aug 2024 00:36:57 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:57 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Wed, 28 Aug 2024 07:35:15 +0000
Message-ID: <20240828073516.128290-6-fujita.tomonori@gmail.com>
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

Add unified genphy_read_status function for C22 and C45
registers. Instead of having genphy_c22 and genphy_c45 methods, this
unifies genphy_read_status functions for C22 and C45.

Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs     | 12 ++----------
 rust/kernel/net/phy/reg.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 45866db14c76..1d47884aa3cf 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -252,16 +252,8 @@ pub fn genphy_suspend(&mut self) -> Result {
     }
 
     /// Checks the link status and updates current link state.
-    pub fn genphy_read_status(&mut self) -> Result<u16> {
-        let phydev = self.0.get();
-        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
-        // So it's just an FFI call.
-        let ret = unsafe { bindings::genphy_read_status(phydev) };
-        if ret < 0 {
-            Err(Error::from_errno(ret))
-        } else {
-            Ok(ret as u16)
-        }
+    pub fn genphy_read_status<R: reg::Register>(&mut self) -> Result<u16> {
+        R::read_status(self)
     }
 
     /// Updates the link status.
diff --git a/rust/kernel/net/phy/reg.rs b/rust/kernel/net/phy/reg.rs
index 4563737a9675..a7db0064cb7d 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -31,6 +31,13 @@ pub trait Sealed {}
 ///     dev.read(C22::BMCR);
 ///     // read C45 PMA/PMD control 1 register
 ///     dev.read(C45::new(Mmd::PMAPMD, 0));
+///
+///     // Checks the link status as reported by registers in the C22 namespace
+///     // and updates current link state.
+///     dev.genphy_read_status::<phy::C22>();
+///     // Checks the link status as reported by registers in the C45 namespace
+///     // and updates current link state.
+///     dev.genphy_read_status::<phy::C45>();
 /// }
 /// ```
 pub trait Register: private::Sealed {
@@ -39,6 +46,9 @@ pub trait Register: private::Sealed {
 
     /// Writes a PHY register.
     fn write(&self, dev: &mut Device, val: u16) -> Result;
+
+    /// Checks the link status and updates current link state.
+    fn read_status(dev: &mut Device) -> Result<u16>;
 }
 
 /// A single MDIO clause 22 register address (5 bits).
@@ -113,6 +123,15 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
             bindings::mdiobus_write((*phydev).mdio.bus, (*phydev).mdio.addr, self.0.into(), val)
         })
     }
+
+    fn read_status(dev: &mut Device) -> Result<u16> {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe { bindings::genphy_read_status(phydev) };
+        to_result(ret)?;
+        Ok(ret as u16)
+    }
 }
 
 /// A single MDIO clause 45 register device and address.
@@ -193,4 +212,13 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
             bindings::phy_write_mmd(phydev, self.devad.0.into(), self.regnum.into(), val)
         })
     }
+
+    fn read_status(dev: &mut Device) -> Result<u16> {
+        let phydev = dev.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe { bindings::genphy_c45_read_status(phydev) };
+        to_result(ret)?;
+        Ok(ret as u16)
+    }
 }
-- 
2.34.1


