Return-Path: <netdev+bounces-87863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86198A4CD5
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E61D1F22E5D
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 10:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93C05C8FF;
	Mon, 15 Apr 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdYAs6DU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F257876;
	Mon, 15 Apr 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178042; cv=none; b=HhN55jSZXSFrXBcVHSNxJW99SHSo9TAruDx56Mkv+xMCMFfUh0ucfx4UmXV6sNRX0p7HjuJEGNHf7lermvpQbJJ7M+cwHM6eHJvsuDP237ZG89vHTCmI3XjQTLRFRx3KOmNxvCzSVOKv6/w1tWRZGQD8+vtR+51yYidVWIlycQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178042; c=relaxed/simple;
	bh=mDsXOZiRjBw17WiyCt9RDsjjUz9yPKgL0seYrVNux60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mMvzHEidfJlE8m5B52sBksqYCljA44UVobl7IJ1f7kXQ4tTVnWmUJ4tC6pe8Mq8JmMp+N/G+VDSYzHi48fl+dxrMlsu3CHPzlawbZAel+FeMJGddCKm/iMq4x4RVENn3Gz6rQadHJ38P/Y+mVAKvzzNWohkWzARSYkbQIHYXH9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdYAs6DU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e7af7eb4ccso61435ad.1;
        Mon, 15 Apr 2024 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713178041; x=1713782841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI+7QAyl9KHMPPW/ptNsMI2gC+m8PWYq6f/+7tSOvtw=;
        b=JdYAs6DUCDPD3J7yw+Vl3h++sBxNMluxIs9rbEgEw57GWQ8s1QszAeecy4rVnkcNI3
         hHZ+Bxjo7RnUoy9rbzlloq9UJJKVd/aupZ9ld7kDmXw43bP7qacDeRc2KzWjUBmxBrIs
         L9Pci5vf/CdPze1OJn26odduN4q/rqrcFYpX0TqPDWWXPppA8QQkDzio+RFI7XwVcW3x
         T6wHHA587zFYWtMJjQeohAPa+/RljeeD1VAbWcqS+x2xLvK6zg566w4njwe4fUGx/5jV
         de9Bfr5UY5BQm6abi+o/ScBqmwJQtg35zfruZ4I2Btmv/vVzB/bm6g5gKu/aNYKfOS6r
         ylVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713178041; x=1713782841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BI+7QAyl9KHMPPW/ptNsMI2gC+m8PWYq6f/+7tSOvtw=;
        b=uZtlZ73zvBy7Za+gP/5u1IaCP1n4xxjoB62e8ivlRHozD0cMYJ9apd2dqKOZegRW7D
         uDlEVBmWfPh/yrAXP2R2DjDi8PsYSqdc+6S0on/Lv8Wo6hEYeEd5qBWSTHMVe3hJ+RqN
         ppoKRvjdrVWvFQLf9/Rac7rnAP7N6mxQS3KjSOLBaNi/F/DwBKeTS0mEoHXvO3BG9KhX
         tCQfG7tyMncpPG84lC+Tn4ZgCJHiAb2zLfArkJUFBSOmfvRS5/oNv7rAO106VwOOlTeS
         kW4dt9n44dPFk4q/e8L/IZEpHHrcYVYKou9CODBJi2jmKJoyVi93tuP0XPUUOGhBP0Ua
         G8AA==
X-Forwarded-Encrypted: i=1; AJvYcCW5HpGRLN+eITsJH4I3/v4nS23fhKUBicOJFCcUCsh43pKbja+f3I5SdRmCCDv54WSzQYIfQuvoqfAykBkf/HQs/xj8q/PIGgfdWbWaFB0=
X-Gm-Message-State: AOJu0YxaL2Bhwz+ct1NhMmOrovA66hFP788mLCjlaX9SHQTfTSEsaYg/
	2htoI17IrtI4NatX+2lRps+rhZ9kmXRpTsQz6SSDJYTWKvdFz92hzO5j4w==
X-Google-Smtp-Source: AGHT+IHBb6IFiUs8xU43oTAG+X29+KkljWdZJwP/hKf4iChRy3JNnv34wAQX382qqFSczCl24o2QqQ==
X-Received: by 2002:a17:902:f542:b0:1e2:b3d:8c67 with SMTP id h2-20020a170902f54200b001e20b3d8c67mr11301029plf.6.1713178040744;
        Mon, 15 Apr 2024 03:47:20 -0700 (PDT)
Received: from rpi.. (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902654700b001e20afa1038sm7807806pln.8.2024.04.15.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:47:20 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	rust-for-linux@vger.kernel.org,
	tmgross@umich.edu
Subject: [PATCH net-next v1 2/4] rust: net::phy support C45 helpers
Date: Mon, 15 Apr 2024 19:46:59 +0900
Message-Id: <20240415104701.4772-3-fujita.tomonori@gmail.com>
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

This patch adds the following helper functions for Clause 45:

- mdiobus_c45_read
- mdiobus_c45_write
- genphy_c45_read_status

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 44b59bbf1a52..421a231421f5 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -203,6 +203,43 @@ pub fn write(&mut self, regnum: u16, val: u16) -> Result {
         })
     }
 
+    /// Reads a given C45 PHY register.
+    /// This function reads a hardware register and updates the stats so takes `&mut self`.
+    pub fn c45_read(&mut self, devad: u8, regnum: u16) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe {
+            bindings::mdiobus_c45_read(
+                (*phydev).mdio.bus,
+                (*phydev).mdio.addr,
+                devad as i32,
+                regnum.into(),
+            )
+        };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
+    /// Writes a given C45 PHY register.
+    pub fn c45_write(&mut self, devad: u8, regnum: u16, val: u16) -> Result {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        to_result(unsafe {
+            bindings::mdiobus_c45_write(
+                (*phydev).mdio.bus,
+                (*phydev).mdio.addr,
+                devad as i32,
+                regnum.into(),
+                val,
+            )
+        })
+    }
+
     /// Reads a paged register.
     pub fn read_paged(&mut self, page: u16, regnum: u16) -> Result<u16> {
         let phydev = self.0.get();
@@ -277,6 +314,19 @@ pub fn genphy_read_status(&mut self) -> Result<u16> {
         }
     }
 
+    /// Checks the link status and updates current link state via C45 registers.
+    pub fn genphy_c45_read_status(&mut self) -> Result<u16> {
+        let phydev = self.0.get();
+        // SAFETY: `phydev` is pointing to a valid object by the type invariant of `Self`.
+        // So it's just an FFI call.
+        let ret = unsafe { bindings::genphy_c45_read_status(phydev) };
+        if ret < 0 {
+            Err(Error::from_errno(ret))
+        } else {
+            Ok(ret as u16)
+        }
+    }
+
     /// Updates the link status.
     pub fn genphy_update_link(&mut self) -> Result {
         let phydev = self.0.get();
-- 
2.34.1


