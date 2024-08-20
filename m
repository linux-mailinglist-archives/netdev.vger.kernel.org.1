Return-Path: <netdev+bounces-120366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C73F49590C8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CE11C21338
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7AF1C8FB2;
	Tue, 20 Aug 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdWDdPB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F821C8FC6;
	Tue, 20 Aug 2024 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724194755; cv=none; b=W/PHzRJ8bmRFHJnGvIOvRudqOHgH4K9WQ+5vNDg3RUMa6HD1kNw1EV1nWL+Lhjg0X1ek4hPgDo0nLE0Y9HGSU39BWZRcXo65EQLu20KwoG0zT3aHWoMcmBbwlH5h79hKj6gp5z5559fi3toa3yJI/AXoJL/z3p5PoIcnC9EKnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724194755; c=relaxed/simple;
	bh=aHiVGhRwYAsQczP9WqvPUI9lvDsw7q7yZyu98J4LwcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtcWyHvt3WUoeBz65mgKsWl73bUEfBaCPz0UuDqSF9fDIGmiUhCeML6UTTbo95qMz+5xLpvRkJ4KOrbxHxBUGEf0NOITGGQ4y9luFv9FX+v/IdANr1X8EdZtcf4s9vcEsgtLUuQ41YTJjkSmNdpd4Ntz9MM/AAC9NDsBYmBUgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdWDdPB3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d1d6369acso160525b3a.0;
        Tue, 20 Aug 2024 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724194753; x=1724799553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=QdWDdPB3rgz5oaQOuh6pCLadecbo8O8nFuGc3Kte9CwMTYMmnGRqqw3rW5WaQ8zp1m
         tgsvH/I4K8+QACUiwnu06eh5B0NoSvMoKcoKvBJxNV70nSMdpoYoAMlhJeOMkPiyLFIx
         svm068i1kUv+KaUD+yX7MY3SOh7O+qiR1WB4v19g3XUAr/N+NiLAkjx6wFQO4lmUC2m7
         F4AbIyy40eByi/jCb+jwgyLsPzToKMNqmijdfHfO70OSln8o+pI3WAWpOTdo2uQSEGlv
         0Kmav00vDplQIYYrDrUFAGMrkSgJi5uSRIbDIB34vM/+f1vMlXDycfm5Fyu4i5C5tifF
         J1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724194753; x=1724799553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mrcl7Z+31Fhv7Hq2xBCP13+zdTE4Tg47VezA00ALMk=;
        b=VPxtRub539triWrb57YEUs6O3y1LMA+0bD5eb2IhdHAxLHTRKviYK5LY7iKPWIwRii
         wg9NDoIKU7j2Wpwk9DkRk7VH8SbxWB9JY94bRDBGnsX+ieSCWBFmVaha24GrI/nil4nB
         whcwWrBsFMPRMwLjgtti0efokBtzjBI/ENDHVSVDLYPJXvWjot/m6v7TmF5ZtbjvAvux
         SUmxSDWRWCLuRS+pzp9Hl7XR+YGeCLSj9mo36itDtNGiip8beEFJRVlCJhy5TzDpAIHm
         oq5CeeRQxGTMiyP/ODW1yhkcqL0AvbeYNzGFUvM/WmKy3g8mAEseixbPZYJoayijFXxN
         gMmg==
X-Gm-Message-State: AOJu0YwnmupXQWcQVURVxgrcTfkhBTz8ZSNuzrO8sfYRnzScIzoGsJK6
	euZDDaqf7a0a707cw0K2jFwIwXCR/7kkfXDg0zUP9XS2hVrsC+N8pk00UvgC
X-Google-Smtp-Source: AGHT+IFg8WIKWd2W59nve96c3TvLZk2eWL2mQdTlkW1xQH37KgGlWKc8MdsyigLup+q16lAb82zY0w==
X-Received: by 2002:a05:6a21:4581:b0:1c4:85a2:9958 with SMTP id adf61e73a8af0-1cada298244mr640875637.25.1724194752387;
        Tue, 20 Aug 2024 15:59:12 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b61d5045sm9922076a12.38.2024.08.20.15.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 15:59:12 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com
Subject: [PATCH net-next v6 3/6] rust: net::phy implement AsRef<kernel::device::Device> trait
Date: Tue, 20 Aug 2024 22:57:16 +0000
Message-ID: <20240820225719.91410-4-fujita.tomonori@gmail.com>
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


