Return-Path: <netdev+bounces-121558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB31095DA80
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 04:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80B6B216AE
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2377F25762;
	Sat, 24 Aug 2024 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMfdq8pO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DAD14290;
	Sat, 24 Aug 2024 02:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724465321; cv=none; b=lCF5WMJWhLydJ/w53ZaxtZ3Ic/HHaDVAQR7nfBwWUAhATSfgqL3ByrsbQJlmlqbdbLVPPlXpaZh22t3de//KJHWszTaQns7BSs63CMhzIxm4EsFSFhCZWWjNNJ5upQ76IInX7SstBZEGDFsYa7VTI6G9KUJOum4N5Cxf5ZX1a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724465321; c=relaxed/simple;
	bh=aHiVGhRwYAsQczP9WqvPUI9lvDsw7q7yZyu98J4LwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwy+Zqd7YnYP39Xf0ZOTNzc6XY2SfqATKoTZ+t2/OlgK5VG3XFcxgJEb8IpcVHbNjdi3oYYq5Bh/hhdzrmyR9hFAdJRse0LqGg7uwmnMUGhhhAOmWR6idP4Q9lUYbLJIBkSv942vcGq7MCby8FEEvodDn1b80939ph7apmTR+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMfdq8pO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-714186ce2f2so2201253b3a.0;
        Fri, 23 Aug 2024 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724465319; x=1725070119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=lMfdq8pOtlvRCOU6+3zxeteODLGjF4jU1bc2vEkkfvT7UixaSlrlQfuMiYlimNyIP1
         6V178dIPveukeVEFZSOuizWEXzedFFb2urK5T4te41iO9N8LamglaFivRlZv3wD3ot5k
         QiFYPCoqyFcprdJ8KUPr66HdBXhQl72Wgp+BYIXKQs1qBlBTRwhFAlCdxfKPh4owqcvK
         YckcMg+6JG2R3YP3KgdVGQlYnMEt20goam9V5LgGOUPoDl/IJ9r6Lxnt0daYR/jKbsAM
         wC2CwDNmdIS/4YbF7jMaFvhsa6I8EVe2meAHAOrj490Fshuw+z8wcr64IRCB1ir0oh8U
         LV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724465319; x=1725070119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=EmfJbZ2WOvVQQ9z4oDizr5Al/Ys70XHPB0yspvRABRn4EMfCY8X7irplbxv0GlpRsN
         dknjmoR1owLg3Vp/SP6tdxvCE56K/pxdXguvgOtz1ZV2XGF/yfDRgh4/pp8T2d9WEoQA
         XVd7eVkz+6n/3orkEZuR5Y0GP6057WIJdMOp9ncMj7f9LTKkYCVZiMaeM7u6ilul3Q/z
         zxQciRX3zjSXuBOS/QGb7pMs16eEVUuGqFY0E8PYrzi2LSnOcRoJN2OVCVA4ox3Yea/g
         O6BZm30YP8s5IcmZYZASxXYBGlI6+ZwNqlKuja4MfKIlp7xBBYlotc+VXqKxXaxVv0zN
         ANxA==
X-Gm-Message-State: AOJu0Yz13nE7w18+YbaDH16lREksKso1qkqjLal0MagX2Jr3O17b6Qwh
	fKzLkORi+Zir/CK83de9XcCsoJI86+Jax4EbcPAzVgCJTAchy4eKc0Ko+eMp
X-Google-Smtp-Source: AGHT+IGx+rniv31EohkBavuGQcWNAeM9VZDVZ4o6C4lIkV4jsbkEp5iHESRhvJxMby3tUGwVZxAOyg==
X-Received: by 2002:a05:6a21:3489:b0:1bd:1df4:bd43 with SMTP id adf61e73a8af0-1cc8a37d2d5mr4788826637.54.1724465318366;
        Fri, 23 Aug 2024 19:08:38 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855809d4sm34393875ad.95.2024.08.23.19.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 19:08:38 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v7 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Sat, 24 Aug 2024 02:06:13 +0000
Message-ID: <20240824020617.113828-4-fujita.tomonori@gmail.com>
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

Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
needs a reference to device::Device to call the firmware API.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5e8137a1972f..b16e8c10a0a2 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -7,8 +7,7 @@
 //! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{error::*, prelude::*, types::Opaque};
-
-use core::marker::PhantomData;
+use core::{marker::PhantomData, ptr::addr_of_mut};
 
 /// PHY state machine states.
 ///
@@ -58,8 +57,9 @@ pub enum DuplexMode {
 ///
 /// # Invariants
 ///
-/// Referencing a `phy_device` using this struct asserts that you are in
-/// a context where all methods defined on this struct are safe to call.
+/// - Referencing a `phy_device` using this struct asserts that you are in
+///   a context where all methods defined on this struct are safe to call.
+/// - This struct always has a valid `self.0.mdio.dev`.
 ///
 /// [`struct phy_device`]: srctree/include/linux/phy.h
 // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
@@ -76,9 +76,11 @@ impl Device {
     ///
     /// # Safety
     ///
-    /// For the duration of 'a, the pointer must point at a valid `phy_device`,
-    /// and the caller must be in a context where all methods defined on this struct
-    /// are safe to call.
+    /// For the duration of `'a`,
+    /// - the pointer must point at a valid `phy_device`, and the caller
+    ///   must be in a context where all methods defined on this struct
+    ///   are safe to call.
+    /// - `(*ptr).mdio.dev` must be a valid.
     unsafe fn from_raw<'a>(ptr: *mut bindings::phy_device) -> &'a mut Self {
         // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::phy_device`.
         let ptr = ptr.cast::<Self>();
@@ -302,6 +304,14 @@ pub fn genphy_read_abilities(&mut self) -> Result {
     }
 }
 
+impl AsRef<kernel::device::Device> for Device {
+    fn as_ref(&self) -> &kernel::device::Device {
+        let phydev = self.0.get();
+        // SAFETY: The struct invariant ensures that `mdio.dev` is valid.
+        unsafe { kernel::device::Device::as_ref(addr_of_mut!((*phydev).mdio.dev)) }
+    }
+}
+
 /// Defines certain other features this PHY supports (like interrupts).
 ///
 /// These flag values are used in [`Driver::FLAGS`].
-- 
2.34.1


