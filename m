Return-Path: <netdev+bounces-120368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0464F9590CA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CB131C20F9D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A151C8FDE;
	Tue, 20 Aug 2024 22:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfTJGIxJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93E1C9DC4;
	Tue, 20 Aug 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194759; cv=none; b=KeSfGP637aqZhDdKyUyKK8bxpbJsga2MjyNhctv9H6raGj3Bq9vt7EybePDB8ltLnV4JrOrbsK0Egpuxuarg3o8hCzo5CLWCnz6WIgLpwaX64rNaapESvjYTndBvPuqNfkps7FVXd+4uixTOG8qT0UCjVVazhaZ6bkEe+vZfmuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194759; c=relaxed/simple;
	bh=yW56BZHZUfncLkfqi94dO6YFbJLn0EcSIdANOSc40eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDaxfCv5OStpgdtJ/bSxpmqTU3M/OQiPZ6l/xImSDnuTE2XEtpVc2XZCFLdhlXTiLK8upnI/L742LxrcTugVvoafdlNJdWGvxYHWi1tD3ge/z96tEqQ3HUHWt32coojm+cXIcQksmb+VJ+SoWhPsXtkM0uzvhGOQCn9q/Im7rbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfTJGIxJ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1d0fca58so3649398b6e.3;
        Tue, 20 Aug 2024 15:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194757; x=1724799557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2CZcdR/DCR2N+rA9DR4gVTG5pOnDP4T1vaCkucmKOE=;
        b=YfTJGIxJ+L8xig1NFnZrO16c5D9kG79qJikCgnoDBS1/G6rPyL1I7V0vNcsrIw64nb
         BXORhIwiYnHpeJZzcoGDQz4INrAuMw7fAflKbk6uiu9HC54VtDB7y6ttOi2funKgteRn
         INnvugcsk37mRghs8lhrwjB210pA5zfoh/LoZcRQDCiA1+2ihrrsLs8iGPq5O80gKNMH
         9n+HDpSng8K+eRTyNdHWbwtRVFaGYGwS/JzqtrpE4awTyclvu53vY1iir9a1K9mkeW8s
         kktvP1FaY+Z2uafbgDnS9tEc7xM2/0xSragfzKMfDXQNjKNzChgMVkIU8SuN8Av81JKM
         P7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194757; x=1724799557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2CZcdR/DCR2N+rA9DR4gVTG5pOnDP4T1vaCkucmKOE=;
        b=pQGty6crj0+TpsF0luGV2YBXyodsHtbMujaTgCja4CRiY3yXeaXlIwdc+ulhSnZF/k
         SGinlCuGtijwIM63UhIPiLdq01CKF8VHgheNhBHK5bihrOXSOX97g15EWvrKZtxS1YuM
         wcMNEeEfVannE/pbsEf3imdknz9qRNx/LZVbV0X+oGi/0jVnDyf7lwMIpVOl91A9N68b
         wDTnxH57EQK0K1zvnzaJGlwZOLlz0/QRFgW0hjIXFtHozj/TfxGO1uJev5FBnZ8eBpvr
         qmeRzBLj6NusYRp6WQVvcn5RTZ5e9OJAIGUvxpivFFNp/UPEju7oAtPHm3Or4fbF7IKj
         Yj2Q==
X-Gm-Message-State: AOJu0YxdK2cSyZLkJmZQI+30NtvvSPbdc8V8Nay0L0Y1CvYtF2WfxZTA
	6AfLoK1YOWTgpjj8y+v8oVbzxTPuFpTjM8eK0EBZPsaWzeZOjRJBMqPPJIc4
X-Google-Smtp-Source: AGHT+IHIkbG5wC/Qgkp+TnPpi4ceyUYf4D6xLq1hFyrYW3qqL0nUfdP7L3iaVgNcXuax8kTM47LRTg==
X-Received: by 2002:a05:6808:14ce:b0:3d9:2b45:1585 with SMTP id 5614622812f47-3de195591a1mr1018151b6e.22.1724194756845;
        Tue, 20 Aug 2024 15:59:16 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:16 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Tue, 20 Aug 2024 22:57:18 +0000
Message-ID: <20240820225719.91410-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820225719.91410-1-fujita.tomonori@gmail.com>
References: <20240820225719.91410-1-fujita.tomonori@gmail.com>
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


