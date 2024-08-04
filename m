Return-Path: <netdev+bounces-115602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDA99471D1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D31B1C209AF
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 23:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E71813D520;
	Sun,  4 Aug 2024 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhFbjPtP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AC13D504;
	Sun,  4 Aug 2024 23:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722814915; cv=none; b=CX8Qd1WSkXl5MYxUXGfBscg5URHQWIZf9oOMIQMfYxbiE03lIGVz6C5GRZKVsX1rzLxJGTF3/YEpvu8GSoz7Hv75d0d8uz6Ay51wqrAtVQhmhxUe+7jZ3O024kCoTkNR9Tpr4wJEXKrVWL8Ung67Wbw+6/FyghHbe/yRXRD3sGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722814915; c=relaxed/simple;
	bh=kKUvKq8V5yBzqCS+HfwPhHfPlHvHGM3jIIabc1FPaLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E3311LREgdo7rK7ysrCgzImgAD4FhzdTGQh4CVxZ2P/POftae9cw5/DpzkInj0tZebI6R0fL5N8KgLpmegiOYzuQ8pDtg3xas/RuU5hHaC5Yy/Ub+blse3m9AejFlEyZJZ/DPS/mjE9+YAtlsJlUyHYwBcOKSokLXlMLr/1/s2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhFbjPtP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70d26cb8f71so582842b3a.2;
        Sun, 04 Aug 2024 16:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722814913; x=1723419713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pytqjKlSRbcr90FHfsODZ5jUOTVS+nbBYnrBhQ6kFt4=;
        b=BhFbjPtP3oXcvE/AuNSvfWp9tn18aWN45m5sAObg3T8T9F9ewDBm46DClRyoc/f0Ic
         G1B33NE3wsaUxPZwFh/MaC56BEuCqo6nStBlLSE0/ErrTgfXFuN4CLBitEuXCEixdQwP
         D7zZhPhzNOavK3FNm26LbHMYBuQZ81LFsoCxEQq42H+zZAjXppXLijOmNzHYJ1Lx9I+p
         12EzEIWu1r/MTS+fumIaj9gnTQ61HkRTmpFWnMd/QERy0QDydANObLHlnYp/KuBc7A++
         KHkPdYNHsENvpXx5GyTH6K6dxxsh68YokcERw6n2MLNoWhFNcPM7q64VWZ9bbYfL6LkO
         +e5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722814913; x=1723419713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pytqjKlSRbcr90FHfsODZ5jUOTVS+nbBYnrBhQ6kFt4=;
        b=HzMNM67Ld9wmiTcCjyiRvCwc3jVALYL53foEEGqtyb0JNeSJZ1HsJ/unBzJ9iOVTS6
         Pi7imSBnJV29Sh0S9sx4vVe6oxYifEw+6cnHrz/viZo6SeGalitDf/M+VcxaZ8RYh9bo
         J1SSntUSxsqst8Ypv95OrCU7MKTw/fqdlewcFZXFSBDcj2G2tzA1RJLhybmwiRdx2Vxu
         cD5PS1EhK7ZSVxtOvk3drX3xsVlgFC9fFNjBCT8zhkjVFdyjU7JsrNPcrpWg7KfjFqY2
         Fu78P3kSyCMYtZHXsYyi9uXNXqMLy/o4hP16PSBuECgFtk0CpwrIIM4eYlOUfjNplcFQ
         MCow==
X-Gm-Message-State: AOJu0Yx3SIuF9sDwjA+q/48EA18+Mse0gx+My0iJBrBXRVP1hXCXraCF
	9Y/zOCb4PHOTd41s5LCGV8oZa7mufoh1u0C/qaWUGOafvOP/r/Z1wPTdDBvV
X-Google-Smtp-Source: AGHT+IE1NuLpqZ8ejF6eICa9w8kkYP3YmIg8T17Ix1V7MuFc0XgZZHbZidKBfOBEve+IMulH3vnDTQ==
X-Received: by 2002:a05:6a00:3a20:b0:706:aadc:b0a7 with SMTP id d2e1a72fcca58-7106cf94aa4mr7106698b3a.1.1722814912674;
        Sun, 04 Aug 2024 16:41:52 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece3b99sm4535258b3a.98.2024.08.04.16.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 16:41:52 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v3 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Mon,  5 Aug 2024 08:38:34 +0900
Message-Id: <20240804233835.223460-6-fujita.tomonori@gmail.com>
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

Add unified genphy_read_status function for C22 and C45
registers. Instead of having genphy_c22 and genphy_c45 methods, this
unifies genphy_read_status functions for C22 and C45.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
---
 rust/kernel/net/phy.rs     | 12 ++----------
 rust/kernel/net/phy/reg.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 60e30e7b3f41..6703bf288d76 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -249,16 +249,8 @@ pub fn genphy_suspend(&mut self) -> Result {
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
index 91f73179315e..4cf47335539b 100644
--- a/rust/kernel/net/phy/reg.rs
+++ b/rust/kernel/net/phy/reg.rs
@@ -30,6 +30,11 @@ pub trait Sealed {}
 ///     dev.read(C22::BMCR);
 ///     // read C45 PMA/PMD control 1 register
 ///     dev.read(C45::new(Mmd::PMAPMD, 0));
+///
+///     // Checks the link status and updates current link state via C22.
+///     dev.genphy_read_status::<phy::C22>();
+///     // Checks the link status and updates current link state via C45.
+///     dev.genphy_read_status::<phy::C45>();
 /// }
 /// ```
 pub trait Register: private::Sealed {
@@ -38,6 +43,9 @@ pub trait Register: private::Sealed {
 
     /// Writes a PHY register.
     fn write(&self, dev: &mut Device, val: u16) -> Result;
+
+    /// Checks the link status and updates current link state.
+    fn read_status(dev: &mut Device) -> Result<u16>;
 }
 
 /// A single MDIO clause 22 register address (5 bits).
@@ -111,6 +119,15 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
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
@@ -190,4 +207,13 @@ fn write(&self, dev: &mut Device, val: u16) -> Result {
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


