Return-Path: <netdev+bounces-122649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BEE962164
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF391C20AFC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BE5163AA7;
	Wed, 28 Aug 2024 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKyoiYso"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27704161320;
	Wed, 28 Aug 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724830615; cv=none; b=FCgxaB7HlswZ2FzXwST6O6uuy9YB8gXcn2bG0y/RZXyiGuvVlqH6XoNIJ64sZoe9l3GEPm6xD1VS+SgkQsris40mxeQeF61ZuVi9SOoiNFr3iWvuloy7neWro8S0uzFf6DUEJ0EbhkBkApDB19sgeMX6kdSzVO/l4z7fYaPH9zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724830615; c=relaxed/simple;
	bh=aHiVGhRwYAsQczP9WqvPUI9lvDsw7q7yZyu98J4LwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQzaJpR//ZQe7ty5GC0pKFIbMFwq/aZG7PAnKGudiXbOkeuTgMu+eeBeb7gS04dMMkNMgzRkME5ObuI/BbuOUQ9LPgPI6R0NbNPWofKgEaibrm7FdQ0vfcfupR4m3Zllz+v6la8Hnxy7ckav0xv13j6ikMptDfj6NsW7RSIuBdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKyoiYso; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7143185edf2so5352273b3a.0;
        Wed, 28 Aug 2024 00:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724830613; x=1725435413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=eKyoiYsoxmz70tUin25p6ChVVB/RBuuQ0z+hHOiLA+cSuA+knV1LWi3BXiy8AY9Wbr
         ensrvVF1eU/udfHd+rBZT2daiSFAqmb2ocxC5SuPVwnhukhdphg+GAyxWhmXXBFh8F3m
         RFpM40FIT47bhyb412ia4dFBbonNz/8hejtWFI7u4hcuTXvrRgmWKapCcUyLbAdWdxlp
         nhDYq6PezOb8Op0eEM37XeU5xWfTFcmeN0+nS73taMJvZQA+RhqzhrcE65N22UfIZDiX
         NmbaMlyioZ8/b1dwVaOsumh9eUsl3eNra6I17TI7x5aGY1Tt/+TSLbDf51MD8TBbfMiC
         RJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724830613; x=1725435413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=RtxM5ePN/9rXzl7Y4+vErpCzElyMgfgY+TA2YEWvlaekd1zevpwR9OqKl/yQPR42Yq
         vQ1ga3cO8RgBbeI+kcX+CXnKV52SxXDSzs8PA4B9mRyVs+Lkyq+PwnqhRQ/qYvY9qqwX
         vv0nVH6EVmmlNcAQdgI1Aq8drdWuvmV2I0qRfgoAqBLUpy7fbbzb79mM+U/vXwmk3SOF
         O9NM85/0Q4NVHj1G5HpbgYXeDi/0L1rSufUayAJf8PuH9g9VfBDMSV5ENxNSefZ4NmoF
         2O16MBEK/JdHvPP7wCTqm3NEvUA29HTlILGSU9ZaZ1xCPFLzs6p9JapMjFiZPK0qDwZr
         jJEg==
X-Forwarded-Encrypted: i=1; AJvYcCVMwj4i3FLIKcyjkddzxPUADv/D2t6ylpHCPnPJjqvtOkgFfFAFK1p1Bj0Iss87cSanqnIyoNr8J1Lx0KU8Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7DDr+ffB86SZ7whlfvkc6lPQC6hCWVgon90r38VZhBDv/gdoR
	0j/Z6GtNzX98fh1E67a+UgJvtVo5ku8oZa37uGTJyGO6R52zY3gNZokdGFhVR5U=
X-Google-Smtp-Source: AGHT+IGCL2tYWSdmcyD/eL5x7RVhP7HCwJUlHKNlCfLy0sjNIU7qA/SzemEv2Mv6EYjEGOC1wq/E7Q==
X-Received: by 2002:a05:6a00:847:b0:714:228d:e9f5 with SMTP id d2e1a72fcca58-71445cc26c7mr17790050b3a.2.1724830612978;
        Wed, 28 Aug 2024 00:36:52 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ac98286sm9016225a12.5.2024.08.28.00.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:36:52 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v8 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Wed, 28 Aug 2024 07:35:13 +0000
Message-ID: <20240828073516.128290-4-fujita.tomonori@gmail.com>
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


