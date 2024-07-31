Return-Path: <netdev+bounces-114393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0DA94255C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136D9282EB3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC938394;
	Wed, 31 Jul 2024 04:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx7bQ1AS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552731A60;
	Wed, 31 Jul 2024 04:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722399749; cv=none; b=p6dYpgO+DJz4QUnK8PeOXDP9SovpltoEsglKN5HglPzTUCFyOv5/13aNXr8Bh+jtghKUHnb6n15TZmzvib8rjWgtHqSGFTmkz8HZTaMuNjhymTV/BsBqdgj97/jWvvM3g9MJF2thW8HIylE+i5HRLW1LizqkDiGPDdc9s2fGVIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722399749; c=relaxed/simple;
	bh=EElCyadeekEfno3mu9oVNwL8HZSElxozh54kmrj1XyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSYXnGpirEXepij51wQCaXfmApkaGZD8QrQBY1gLoxJ8h+sHqCKdP5ddrHhRf0WjgK8VVDsAPOYktmyiCjrUJnDQk7qpA49qQwlUyjUUO0JAAKj4ymQy69qtFdO4fYZs16byx9gk7lPEtydaEjIzdRX+uUBZte6WLnsgZV2rn9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx7bQ1AS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cdba9c71ebso957490a91.2;
        Tue, 30 Jul 2024 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722399744; x=1723004544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkpEiKThjKWf5IvvvkusNDCDk2uO0uXuRG0X4aMvshk=;
        b=Cx7bQ1AS5cPiJ+utKq0jPyHjVztf4PPA2mXT2Gn2FQSbU+U71R+WFbA3r0V/pwkaZH
         XBZfUgqa4B7q6AH/IS2ss9RA9fah0ingQ4wOkt+tlV3vWRE8Yng5fD08A7nf3w11vPxx
         UgK5YOG1QNWwwlTxv6tKB51orLefhFBy+2hG4o0rIX9jCDZQeCZAXbTqPx92Gjs7UoM0
         4kBG7edGEfY0TmZ5D6swaZEOFooKLNltB8a44qTNodz8tNPjEmtRwbU0peQL/eCEWltY
         W7b6X/Zhz+wJqt+v/JEuW8sDbU4fGpE7GhghaSC7eQ6F3Pa4iv217u1MQ5xFyCcmAMvt
         bRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722399744; x=1723004544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NkpEiKThjKWf5IvvvkusNDCDk2uO0uXuRG0X4aMvshk=;
        b=pecuLE03ZRXTkrtWIraJKENI1E4Zp0RfMcolYBPwZ6IAd3x+5Yr8x2g3BSXN4sO8+F
         4WRYGYN8nX9b2QBlBzdsa0VYC7/t+zVfcBPMsn1wd/tWk+qL44HYqIEZPaC0ibg86dOS
         j1qfJZrdfQIlnLfSuzyEFE0vi2bfo0Oa3Kag/u+8dt5EHTVvpZvw/ToJdVKi5jywdBwy
         1bj6nbiKoos760wLGaSsXA6MmeOwEEv0TVWIe9DFH3J+9aRXJFH5pzw4vGrNUwMgpa3f
         HfNJGZ4hjjeVSyYW7mzOaG+JiXSuhBDFGoPSrjrvhisS40yDGyZY+4SGIJRrd/MOZy+N
         fyRQ==
X-Gm-Message-State: AOJu0Yycitq+uni/osCt7BpMSrKJNJCBXhX/MigdJT2IhJ6KP1Ak83SI
	J1r9kxQwshJbkzy2TlWOUzv/pH/V5PCQpMqgAOz42l8Ma/HkRX6tK6YY1VVz
X-Google-Smtp-Source: AGHT+IHudcVQDvhWWHYOtc7xwBlwpUj/gWnbH60BNTegIVXrzUaWi3u2wW3GpmNZ6hdeMUgsr5tf3w==
X-Received: by 2002:a17:902:bc81:b0:1fb:1ff1:89d2 with SMTP id d9443c01a7336-1fed6cca0d9mr130489795ad.6.1722399743807;
        Tue, 30 Jul 2024 21:22:23 -0700 (PDT)
Received: from rpi.. (p4456016-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.172.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d376sm110815145ad.18.2024.07.30.21.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 21:22:23 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me
Subject: [PATCH net-next v2 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Wed, 31 Jul 2024 13:21:35 +0900
Message-Id: <20240731042136.201327-6-fujita.tomonori@gmail.com>
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
index 7ee06dd5a1b1..938820704aca 100644
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


