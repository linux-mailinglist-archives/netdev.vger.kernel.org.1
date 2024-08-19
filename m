Return-Path: <netdev+bounces-119518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 891439560AC
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2541C2121A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C239241E7;
	Mon, 19 Aug 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Goye6Rjr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE06F225D6;
	Mon, 19 Aug 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724029240; cv=none; b=UpQMLjCS8pQkxGaPnHCdygSkUIx/82SzdCMCkvYiPk9Zl/mmr72ztmbLjPsWVgB1bJDwJSoKWbtwBo2K/vS3LR/ossWCnVlqpuU33vwxJobJLB6/IJZaeoDg8k4DSjYzGsrqGY/bcgI8W2GjCfuJNH1LUYBXmX6i6TGxOQ2o4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724029240; c=relaxed/simple;
	bh=hO8jaPoe8Z8KfyUx9xcnRBOH6nmrdlSVRLp7CB+itpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiQUkQQoNINFNTaHpwfgVULjNwK7DarPHk4QT0XVGu7XFE/zMao0Wl9ccL7JMTDo6EkoWcI3rSGo4f2w4qV9l9QUEJlkfagLrTS4AYq7yXm4KUL7dUwcOpyuJUpvw87MInUt2bmcf919xANCKofEkmqMFDeAGslYz0gzc0IboDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Goye6Rjr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3e6fd744fso516501a91.3;
        Sun, 18 Aug 2024 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724029238; x=1724634038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZYPHOtPx499jxXDsFggcgwM/32QfaN5aB36q4eX0TE=;
        b=Goye6RjrRf0wXZFySvYYGCnCSaWHn338IrOMefvdhLQvt6GLSTj+QZp/mhu6dejn7I
         wCj9thpqbb1HQZJJLAEoEAZ3N6YxdkGiHUinq4byQ+Sj1NWCpQQAXzfyD3ScCymGpqH8
         3kzwFIHFrJdsSorrX2U76xeAgOG4kAFVjyBNCCrPHUoRHJbPu0wb8x8qa3KRoxiegnXd
         PwUbyxkJGHmpKOw9vP/Ri26DIT3z9owkijEMle4r72DBtu7Ye4mobNDW2/31h8X+4/xi
         fnCAfc9KBlBck0AtshzuFrB+uGQlplQ0PJnq7CIFrhCGOI+wr8rWDRhc/OuRGj2Fczhz
         GFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724029238; x=1724634038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZYPHOtPx499jxXDsFggcgwM/32QfaN5aB36q4eX0TE=;
        b=KOObjw5YVL2+m5FyqKSS7r7z6XvjBOFrNouTilIySNkIWlJKj280eSnnD+Qcl2OFSl
         oqLEmuGomXVTQnytc3EiGVRGTRGTWWReWAlmcrgoVKZO4gUUs04GIqGErNtdxKcQzhU6
         Ro5dXS0YypZJWLqlOn2B8wSGEvj9meyIiPwqdVNRNUCEYg8mWW+lp131YcnQa/VEHY+p
         WzYtzrZqhg7Bf+4kjsLQxPHb3UYChJ4l750QOz5oJEMRvjroQAIfAUr/rXdnrt8tjeJO
         2DIbGF4Kn8AemlKqN1Ndt/f2UkakOZgNq4q183bmAhowt1BEtxlaZNEIuooI6Q3VfLqE
         DJ7A==
X-Gm-Message-State: AOJu0YwyFLSSrKsT8BNjJxj4PiXRqtDw1o5FeTwpmBi5q3X4N98Pi0il
	Ng5EnijgvfXU6z+BCMY7+qO0xgfMPtFmteU1JaEIwf/XSu2rrxOYD5r4xlGN
X-Google-Smtp-Source: AGHT+IGAZe+EWkE7wSRPBqFNaDEznu42gvDVmAKTD4JQZEvoQmR66oE7TIrhnTZiMciVhE5YXe4lZg==
X-Received: by 2002:a05:6a00:9446:b0:710:5d44:5fe6 with SMTP id d2e1a72fcca58-713c557a36amr7082330b3a.1.1724029237585;
        Sun, 18 Aug 2024 18:00:37 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c4a7sm5718732b3a.193.2024.08.18.18.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 18:00:37 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v5 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Mon, 19 Aug 2024 00:53:42 +0000
Message-ID: <20240819005345.84255-4-fujita.tomonori@gmail.com>
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

Implement AsRef<kernel::device::Device> trait for Device. A PHY driver
needs a reference to device::Device to call the firmware API.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 5e8137a1972f..ec337cbd391b 100644
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
+    /// For the duration of 'a,
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


