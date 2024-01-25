Return-Path: <netdev+bounces-65710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541183B6D2
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3D91C220EC
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FDD67C5A;
	Thu, 25 Jan 2024 01:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxVj/MRT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB60417EF;
	Thu, 25 Jan 2024 01:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147216; cv=none; b=bSOn27WeM5M3zWYczoR1U3i66HyhMFceKlMy3pOVJCwrTdIdpAqZahmz+m2a975IMZsEvlQjrYRro2xM/G94BsrEoOMUmCkpdnb3NaGcYVjSvpSeqd+Ghp6gP7JbF9ySiGxHlzp3+NX0ZucSGJRL1MbXaXqwK7JMkeSZPenunVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147216; c=relaxed/simple;
	bh=wJ/B5H7BPRzVSP4LOP5qt75n/II3509WKyIdg5RFo4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WI8TOXItUGEqMHD/S2MT8k0rSZTwqXwHthn4cy2ksAcYBA9FmzuyVu4ZLt1SecV101fDugPgKKx1cmeHrLTZwLZr7Q1G0JAl/uU4606Ccawveqj2heZSLnyPPKCvxS1LYzu43K2K3Lo+RQV/ksZ9nzzymqRb2Kaxca9JRbZEVWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxVj/MRT; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5a0dc313058so674023a12.0;
        Wed, 24 Jan 2024 17:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706147214; x=1706752014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LXSs0IrdDsAsnyvMWhMZAeAfP0ktcJ5dH3Gdj/YyyMU=;
        b=KxVj/MRT/TlGip38z0ix+eW7OS9wL7ojMeD0LEoJM18TN6Rd3WG0T7NXwKLKMbxLZy
         dLiLy3aSIUGkSGOYCQGj+vLxNl50L4XZ8C6kcclVK/H0VETUTdP2u3ByFFfpwnCD5Ff9
         ZYY/kjUTo8ZWIS4n7rmpqloRErVii0OU1W4TL2FJpxWXSDcFbWPSgLJd9w2fApYDRDpx
         jkYgm+8GkmvBPB9ARonhGL9Xxa1s76ag3SqvmHFwKgfcJxIi1y0KCJQIZ+oaxA06eBy/
         f816xvIqOSMejkgxsCUXinIL0alzf7/YsMW1t9teJJjdPlvTTObXzwDDmGxYEHe9sp0a
         0vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706147214; x=1706752014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LXSs0IrdDsAsnyvMWhMZAeAfP0ktcJ5dH3Gdj/YyyMU=;
        b=fdQw3qkFjQrr/D8IhySw80hcMymtDabOyMtbkRWfSldtUFeELocoFY9ZNvn+kdVz0F
         Ldk33E6ru6y4DUGnSSEzNrZL6gvLWKSPfwER6G5/2qK0hyTrD8hpENUhpmiNKRus49xN
         rLjSTlgHwMe+Ae86OQzuLSovZS1UoYxfFCOvfukGN2/EYzE6BnnBh8hESjdxqh4GAvR7
         Y6ro0wg3ZeFoISs5t3k3+5qKglNWPV1u6tEETAHJLCR3MGBE5/bxz6vHintQIF6TgQ8N
         A9/QNOtCmfrFW+/pNTp7vyea9Ru1SmiSnrNleiWT7C6iC9+7SzJjsQjygQ3gDh77l+5F
         6cYA==
X-Gm-Message-State: AOJu0Yy0cMTpegjEh+URmA/lt9NgVz3URryCL+m2jeil+T1AavXV7Apo
	hEqpbjTr5xB4CkhzmnMTFtsZzNq/T647PKa4YABUTmpLzqak+CUzsOcXFwqV8YwjcA==
X-Google-Smtp-Source: AGHT+IGU96BKcCD9LDL1fcKk2XbCQy2GwTvDDjn2RuptVuoYAfb4MEawPNH1jSITG6E2lUpUDABbdw==
X-Received: by 2002:a17:903:32d0:b0:1d7:3ea0:e6e5 with SMTP id i16-20020a17090332d000b001d73ea0e6e5mr531608plr.6.1706147213663;
        Wed, 24 Jan 2024 17:46:53 -0800 (PST)
Received: from ip-172-30-47-114.us-west-2.compute.internal (ec2-54-68-170-188.us-west-2.compute.amazonaws.com. [54.68.170.188])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm11107980plb.148.2024.01.24.17.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 17:46:53 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu
Subject: [PATCH net-next] rust: phy: use `srctree`-relative links
Date: Thu, 25 Jan 2024 10:45:01 +0900
Message-Id: <20240125014502.3527275-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relative paths like the following are bothersome and don't work
with `O=` builds:

//! C headers: [`include/linux/phy.h`](../../../../../../../include/linux/phy.h).

This updates such links by using the `srctree`-relative link feature
introduced in 6.8-rc1 like:

//! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index e457b3c7cb2f..203918192a1f 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -4,7 +4,7 @@
 
 //! Network PHY device.
 //!
-//! C headers: [`include/linux/phy.h`](../../../../../../../include/linux/phy.h).
+//! C headers: [`include/linux/phy.h`](srctree/include/linux/phy.h).
 
 use crate::{bindings, error::*, prelude::*, str::CStr, types::Opaque};
 
@@ -16,7 +16,7 @@
 ///
 /// Some of PHY drivers access to the state of PHY's software state machine.
 ///
-/// [`enum phy_state`]: ../../../../../../../include/linux/phy.h
+/// [`enum phy_state`]: srctree/include/linux/phy.h
 #[derive(PartialEq, Eq)]
 pub enum DeviceState {
     /// PHY device and driver are not ready for anything.
@@ -61,7 +61,7 @@ pub enum DuplexMode {
 /// Referencing a `phy_device` using this struct asserts that you are in
 /// a context where all methods defined on this struct are safe to call.
 ///
-/// [`struct phy_device`]: ../../../../../../../include/linux/phy.h
+/// [`struct phy_device`]: srctree/include/linux/phy.h
 // During the calls to most functions in [`Driver`], the C side (`PHYLIB`) holds a lock that is
 // unique for every instance of [`Device`]. `PHYLIB` uses a different serialization technique for
 // [`Driver::resume`] and [`Driver::suspend`]: `PHYLIB` updates `phy_device`'s state with
@@ -486,7 +486,7 @@ impl<T: Driver> Adapter<T> {
 ///
 /// `self.0` is always in a valid state.
 ///
-/// [`struct phy_driver`]: ../../../../../../../include/linux/phy.h
+/// [`struct phy_driver`]: srctree/include/linux/phy.h
 #[repr(transparent)]
 pub struct DriverVTable(Opaque<bindings::phy_driver>);
 

base-commit: fa47527c71dceb2fd4fb3b17104df53f7aed8d49
-- 
2.34.1


