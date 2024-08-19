Return-Path: <netdev+bounces-119520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFE69560AE
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94729B22FF3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B1F288B1;
	Mon, 19 Aug 2024 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NffpODzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E62941B;
	Mon, 19 Aug 2024 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029245; cv=none; b=dWsmXoLQSRRIPe9zVWWhAMyn4rSI9Jo6OwKgwzVG9+LB03gCFgoSGjeRG1xhJlMyTMei9a5L5BWbLgFz7z0VRZ1Q5ZqHqUVg8OJpOKsu8fG4S71dy5F0shEi2W+cf1g0SLWwrZYIqJ6lxZJxDXAE0/ArKoIwf/QN20S+150GBVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029245; c=relaxed/simple;
	bh=RtVxmQiE2amUT37c5dYO/3pNWoIJF7gMSCNvWJHSwjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B18VN55bRP/Ty/cBfYcArBUAdPNB6TQ4ZGj0gVDURrpUginSLmth+cMTWysbAtjDlCEoi2GNazSWiZ4vPrAJUb1ABb/jpFKZG4oFyFpZgp4YvM0M+EOdQ39YZWtVDp4ZSNWz32a208biPHaQoCrWCtM1Ld1mIZdjLh6xHQ72p2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NffpODzL; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5da8c4a88fbso97141eaf.1;
        Sun, 18 Aug 2024 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029243; x=1724634043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccx12vLZCXZwR8/v5RNHblIUI8DVfBbUOP+jn6uBVsw=;
        b=NffpODzL1WTzpTh61/FFGJ75Vskekpn0dn7sDirwEA0pVXoXTFv099rGKGo/GTu4da
         FTFuynDChDVgjX5k7yuFitSjYTGd2/MKPzdRIIt9SyvDbfVjbpZRS68Zuv6tfgoGEShJ
         0tT19FELNNVB2SkSqhtxjWlIVavVrTiycUNJpf7LeavrVTUGv/nVKZMjjkkusEATPQPJ
         r9zL7OZLrNzviE0BCRQzV9ppfhUdqfgiNnPnW7PWvZ6WwvJ+8UywJOmeW6gvdsr4/Mus
         Dkc7BpwU2b2zuKz8yUe4/f5JltGXJnqQ8NtXrEHi247wEWOM+K21uIHK1tiqkWEdF0gl
         F7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029243; x=1724634043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccx12vLZCXZwR8/v5RNHblIUI8DVfBbUOP+jn6uBVsw=;
        b=Ya1OYNtCmAlw9bqqxPSqcz8xCM34Z7qp/nCcRTTDNJqRjCfnaJ7U/hEcG9f0FYtCP2
         6/Z7fHccyYS4qm0qPeDPyFb5EqrVGwgomICoNrFdiRVH6k6TeU1YvDcmAyy5siZspPNp
         cDVexzbsOcXKzP+pu8ViIImqoJxYf3QjiiqNrwuejGTRpes90kWANjsqiFeg6feXxDkr
         Qr6/Egq5fWCcFcr+K9VYe5Nw3n8BYktM84PFvuBgjeeovvYyxODvn60EP7ATM/88HBFr
         YZDwPwLFNHEPK/E3OZu+gt0kfeQdePvF8yMtmDgJ8nDN84DWiCuyKa6mb32tSUcw2Y2k
         OkrQ==
X-Gm-Message-State: AOJu0YyVG5K5BX5I6xjHHIhg2FZKL0B/o1JLdFq1ZaWmY6SG/r8jOiz5
	ULqpPS2jeSx9JDHbKMxsWcupZuYf58t9vC/ajVmQ8eeFaH/bVbJj7PEbYbdP
X-Google-Smtp-Source: AGHT+IFi350co4BEF0R5n8NXnG7JEueqWv5JywdtHPu5mNgc1r/z8bMojI5Jij24tCwtiSNGuLnIlQ==
X-Received: by 2002:a05:6870:d6a5:b0:268:afc3:64cb with SMTP id 586e51a60fabf-2701c575f2emr5190954fac.8.1724029242686;
        Sun, 18 Aug 2024 18:00:42 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:42 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Mon, 19 Aug 2024 00:53:44 +0000
Message-ID: <20240819005345.84255-6-fujita.tomonori@gmail.com>
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
index c07accb08434..a74ce9f30ce7 100644
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
index 5fb05b79a956..7edb5d494e0a 100644
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
@@ -112,6 +122,15 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
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
@@ -191,4 +210,13 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
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


