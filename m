Return-Path: <netdev+bounces-119377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C37B95558A
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 07:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0951C208ED
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 05:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091D912C475;
	Sat, 17 Aug 2024 05:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6tkPEkh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6364313BC12;
	Sat, 17 Aug 2024 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872348; cv=none; b=IJmXs5Paf7V6/sL6pccxISiJ3ZS1FLj8GprsjoPd0uPcjgxgzjvtsRg91swQu5eRlhKCXsDEoJos839RZB/Lw/MaIi1qGikcwhbtvyL0bC8m9nHEF5wjxCzCdKU0oKRWod79Kh8pRaFEQQuB58Rg+Xr1f4Sd3hF3uHkMJtw7ivc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872348; c=relaxed/simple;
	bh=sRKNxzsj/K5Wi+RNvb01kvC0we2rZdphYRRwZyIOSGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M6NzL0AAevQ8/CBj/pIZ/x/QvTfWCzxSy99Fo++kLHGSZC0ZwV2w5QKMrR+JI3djuVUAlfq7oIEhDHEnXwPqmqj8Z3A7Buc/ui10KLTtlJonYUHj8cLbtv7hgxwffpz7gm+l6UVOg3I5Rk2mYKkOGWzP4AkRLBypV/hGDEbtQPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6tkPEkh; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d22b6dab0so248040b3a.1;
        Fri, 16 Aug 2024 22:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723872346; x=1724477146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow+R+9e+Ob/UXg8D0PjkU4R3Df3JLCTiMkZW0sbnCxQ=;
        b=G6tkPEkhYeM3/2yW+AsSEKu/sjzNiV1ET8WjkJukGCXsFDt1IpML+iUCHqal+P96RU
         2jD157Xf917NziNGBCook85g5OW/4fWhI6bAkYD6jDqkbuoPgf5KMr5Tl8Tj42KgAYze
         YKNM7NPVOfLZaWFaqsY0vkwmc71dNz+6buW554Y9/HpGA4rNTeE4lOpkNAMIdwefspRW
         t9xImqETcDlB4pDLIgwOlUc1ALDsNRiaOOGUaijdi9ZkzJl+txApgrP7N1BEkKJE4cIE
         PlmYX8UeMVMBHti8X57cejuH6W1eYTrKLLeZfDflX0tuRivhxYtw8wWX725gulm1C2NP
         p5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872346; x=1724477146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow+R+9e+Ob/UXg8D0PjkU4R3Df3JLCTiMkZW0sbnCxQ=;
        b=bkY67W4hZ1/bPfiqyVkalRH1uPujtVV+kW+6U5dtulED9CFKCEkknvDq1VUKJWpuHC
         nmgZeaWnM6gPyztWN1gkN7ODocvIF3BAq/w93kOGebM2ujMuHiqxHiBBNsLFKKPbHg2C
         VE462FtS2YoP8AnvyFWkj5CBqsrSfYZwwKa4rNjnZhtHn200g0vRFDzkaHSHdED6NaLF
         08jf02hwqddJtrPoRftp6CW2BD0KmYfX2WPYBV6SU9fbWh0iqk306zr3ud2omyNut58F
         isPTQ0lUyNlyegsHk/3PN5g4QDovktdl//ezPPRR73DJsTl1GkURlassf4t91J42hISv
         0ZfQ==
X-Gm-Message-State: AOJu0YwDNPEttCaV6pZuRsfKKbZMkadBrJZ+7P3O2iA/k7+z3JZWITyg
	W+HbNV2vbaiezMYkPpDOLjyxbnrb+0cVFQ6faPjhZ2JLvqh7UsyXQAMj8a9p
X-Google-Smtp-Source: AGHT+IEKKvMOoeUgafnzytE2imiCDmelH4v6Q9dKv0NuEWgBrf57/UGEZQ+PcZsEoi/4lBVn8HonTA==
X-Received: by 2002:a05:6a21:7890:b0:1c4:a20e:7a8c with SMTP id adf61e73a8af0-1c905025e78mr3795576637.4.1723872346157;
        Fri, 16 Aug 2024 22:25:46 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c74e33sm2881655a91.39.2024.08.16.22.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 22:25:45 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v4 5/6] rust: net::phy unified genphy_read_status function for C22 and C45 registers
Date: Sat, 17 Aug 2024 05:19:38 +0000
Message-ID: <20240817051939.77735-6-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817051939.77735-1-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
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
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs     | 12 ++----------
 rust/kernel/net/phy/reg.rs | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index f2cdb617d44b..deccffde31f8 100644
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


