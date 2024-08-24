Return-Path: <netdev+bounces-121560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C195DA82
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C7B1F22A4E
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A5536124;
	Sat, 24 Aug 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX6VDb+r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00814290;
	Sat, 24 Aug 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465325; cv=none; b=JnvmiQgtpLjwA0GsKzzHv6SF6MvFf0G3AKdB+PDusAwkBCIYDge+6A88qxXFYR0ZKt2nYX3QTK8B33pWyfSVzQuljPQ3lIJSvbRt/v75kgJL/jz8jiaKbf8juKKt0zaq5YGo3M1glAJ1RaoT0RQcsO6nCCUXE/L1YOiPJW/LVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465325; c=relaxed/simple;
	bh=yW56BZHZUfncLkfqi94dO6YFbJLn0EcSIdANOSc40eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8rMflTFU/11D9BC6vSD6NS3hweATmMVM5RGbX7UPStq8JuPmzexxyoAv25djskrRp5eQM2n8ZWlji+GQ60gdPry/LheOBF36N6mNnlipV1PASDU6zZpSpT8V47Qo/PIsCkqqD3XVF16LxIXaf9H2MWEKLbnGEaPYpMt2Af73yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kX6VDb+r; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-202318c4f45so26410285ad.0;
        Fri, 23 Aug 2024 19:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465323; x=1725070123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2CZcdR/DCR2N+rA9DR4gVTG5pOnDP4T1vaCkucmKOE=;
        b=kX6VDb+rjot5I1CtHypaxY9xXTF+576ymIJvFVVxUSg6wyXKsGw4pPKs7EgpMuLBbp
         /HCRCaHh6aYRmxfyJY6tny2rdHnC3rXkxiIirnDGd3b2Q+O7mVAn9sAQzgQkRKPlvMIy
         NOPZpwkRLo3cBhfQeeWEHyx2ABAlMTMDGtXiBfwNT1s/a9Eb3YHU5lqtxfNx+Poi6801
         U+vZEsZHh8MkArt4GefA6UDsLo9ajS47/YhBoYNTY201795MJw8HfhtWroShDnK6PrJg
         eF3+d1hhN4CKO22/ldkRndmwnTll0wEiODvpM2OXz7rvCetVJwJQT7T+itQSGrKDyVUx
         9www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465323; x=1725070123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2CZcdR/DCR2N+rA9DR4gVTG5pOnDP4T1vaCkucmKOE=;
        b=S88QqO9/d5SRY7ReLQt+pumF90LAesQHYHibt/5ra2IQl3KI0o338+sR9qttfNCgh6
         NJRs9kMNgBjc6DOuS22k1m26Y5v4XLQHpO7FoGM6miR5JecyaGXmY8Vz06L3PcfWElsE
         7mXD9eDpk63F4tphcIAEHsgoE/W38seOo6VOBbzvE1NSEBeBr4+O5aLYuEDiIHi7UCRz
         zAVWPKTXUaOfBbbegnpqEE6EoJ0/+OGz4vVwsKDX/r2JM9SHr14Bw8WvVQlBSFP0ZMsR
         Lnh51IFRKACFg74Q+UVM1dP2H4XryZopLVbCyhovx/1mElWQOtLvyJrD9lVZQe8smQqA
         Dp5g==
X-Gm-Message-State: AOJu0Yx4GEHfvldS4W/EnXl6RZieJmatj/LiqWB51zaoXzxK0n9FvatJ
	zoW6wcAQG4UF2W5rMHNpC9YxxGA5mPW60sawa1bnSLO1top/zEX9OPfriDF0
X-Google-Smtp-Source: AGHT+IH2cgW/fU/MCb//l/4owSJVtP4Q/AQB2CtLXhZeNG81aOGL0CVwlWMpZsdANoh4v9GpXWpetA==
X-Received: by 2002:a17:903:984:b0:202:44a3:e324 with SMTP id d9443c01a7336-2039e486f88mr50850415ad.21.1724465322633;
        Fri, 23 Aug 2024 19:08:42 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:42 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Sat, 24 Aug 2024 02:06:15 +0000
Message-ID: <20240824020617.113828-6-fujita.tomonori@gmail.com>
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
index 191b96a524f5..c784e6834bfa 100644
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


