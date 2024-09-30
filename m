Return-Path: <netdev+bounces-130394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4398A594
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C955281AD1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A51C18FDBC;
	Mon, 30 Sep 2024 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx2yNAQh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05218E779;
	Mon, 30 Sep 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703691; cv=none; b=VAU6+WzA8aEj4wZpjJ7Y3Si0Y3xIKotj+/PvA6/QP73OEoMXmiArYRQzvpJmTPOid/yOL8iUdZi8iNuNY7XD/6CznEn87kevnnxXFLsyqUOXjLXig8GG1fQ+lmoQKy6SH1bf15n5i9b1pMijOOEGsLn8GkMUZSrYPCN0Grf3rhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703691; c=relaxed/simple;
	bh=M2qViDpasppWgOmVAPajz8rAxi9prqGpUdCk9L5cHMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiL11ZxYHt9iZHRXumtitc5AbP2urYxJaLLYZQDfMRhn1fAB8vUPUhU1SIzuovEal/V40F2H/vFP9Ath3noQJJkPxiXY5+NgaPpao5VHgpsQlx/hQnIf4tHBwnIb5tmgVv7FE4DHjQPWyVt6jIiPvhwanvbE28kG9AA1v+aogaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gx2yNAQh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cdc21b5d8so242162939f.3;
        Mon, 30 Sep 2024 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727703689; x=1728308489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVt6XafWgMWCoTa19tQEGdIpDNZtiBMIFTEzYFLIRmY=;
        b=gx2yNAQhF2VmLP1DKFFAaS5Wn+B48xGz2FOg7cIy0ocNWn7Ch6Yt3QdBm/U8UHy4c5
         mPY4i3NjwgFgdx/SLhakWDJbhyo9O+A+Mp4HbC7aSCifDiVyysGQ1XhryLN6tuemHsK3
         1YkWSzNCEflCxAOgX7mK+4hcmH81ueh68IC8hUrOt0A74ib7pgN13lUB9Kr9OzCStyz9
         ntgSSPeupsnkktbNqCi/qYgOtuemmwo95lPfLsYqpo/H+G6yPlx66X15XomTA6vopgEm
         wpD0brOA+sIf1InzzBz7YaJZtO4MCsvQxzqUR7qQoUj6NxXhIr98uWn3OimCVzOHzlNQ
         LlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703689; x=1728308489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVt6XafWgMWCoTa19tQEGdIpDNZtiBMIFTEzYFLIRmY=;
        b=sib7vEAWia9BBHGBvOr0me1zdB2m9kVK43oP0js9Jxh2/KJGkHuVrlNwxiMwhRtUXF
         HL6XRz2evu6toDDGKyCpokgjYtH8imggy8iINbcSythr8Jtp6udaiDhfnLSAhBi2faYK
         h0Y/s4rR5+V2stkKaqN/JKGlFfuzF9YoRu3Q10DC9QxpXrxNN05djKrrxIcpbNYSKt+5
         Y0bbbiP41eacvRDumBFgm6Gi3RijQv/dYeuziccdjeAaDh6q6xsA8H5NnuWSwXMY0m4j
         6yNGQQ5H/n7J/iNPTtV/lBsuogPwzIZC5ShIj22lt9zBndE0eOjrWEkR2L9To+P4lFkO
         4uCQ==
X-Gm-Message-State: AOJu0YyPCCSzLTaqxR8ZFf5SQ7Vn09dPZvtBoY2cMkuwwV9X44B3vEcY
	nz544LMnLG2Z8Q1MEEx0wkiOwfyS0SmDJtDYOqtSn/oCOtEkQTBFQmkcbw==
X-Google-Smtp-Source: AGHT+IHIMVIwbvg3zEa5ZaBNu4XUVEyL/ww7nafE1KzVNbaB1mLETOdqKEBkrga6QzcW7vmR7nQEDg==
X-Received: by 2002:a05:6e02:1d84:b0:3a3:4164:eecd with SMTP id e9e14a558f8ab-3a34517abd7mr107364275ab.15.1727703689318;
        Mon, 30 Sep 2024 06:41:29 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6db2927c7sm6582308a12.1.2024.09.30.06.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:41:28 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	aliceryhl@google.com
Subject: [PATCH net-next v1] rust: net::phy always define device_table in module_phy_driver macro
Date: Mon, 30 Sep 2024 13:40:37 +0000
Message-ID: <20240930134038.1309-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

device_table in module_phy_driver macro is defined only when the
driver is built as a module. So a PHY driver imports phy::DeviceId
module in the following way then hits `unused import` warning when
it's compiled as built-in:

 use kernel::net::phy::DeviceId;

 kernel::module_phy_driver! {
     drivers: [PhyQT2025],
     device_table: [
        DeviceId::new_with_driver::<PhyQT2025>(),
     ],

Put device_table in a const. It's not included in the kernel image if
unused (when the driver is compiled as built-in), and the compiler
doesn't complain.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index 910ce867480a..801907fba199 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -848,9 +848,7 @@ const fn as_int(&self) -> u32 {
 ///     }
 /// };
 ///
-/// #[cfg(MODULE)]
-/// #[no_mangle]
-/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = [
+/// const _DEVICE_TABLE: [::kernel::bindings::mdio_device_id; 2] = [
 ///     ::kernel::bindings::mdio_device_id {
 ///         phy_id: 0x00000001,
 ///         phy_id_mask: 0xffffffff,
@@ -860,6 +858,9 @@ const fn as_int(&self) -> u32 {
 ///         phy_id_mask: 0,
 ///     },
 /// ];
+/// #[cfg(MODULE)]
+/// #[no_mangle]
+/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
 /// ```
 #[macro_export]
 macro_rules! module_phy_driver {
@@ -871,9 +872,7 @@ macro_rules! module_phy_driver {
 
     (@device_table [$($dev:expr),+]) => {
         // SAFETY: C will not read off the end of this constant since the last element is zero.
-        #[cfg(MODULE)]
-        #[no_mangle]
-        static __mod_mdio__phydev_device_table: [$crate::bindings::mdio_device_id;
+        const _DEVICE_TABLE: [$crate::bindings::mdio_device_id;
             $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = [
             $($dev.mdio_device_id()),+,
             $crate::bindings::mdio_device_id {
@@ -881,6 +880,11 @@ macro_rules! module_phy_driver {
                 phy_id_mask: 0
             }
         ];
+
+        #[cfg(MODULE)]
+        #[no_mangle]
+        static __mod_mdio__phydev_device_table: [$crate::bindings::mdio_device_id;
+            $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = _DEVICE_TABLE;
     };
 
     (drivers: [$($driver:ident),+ $(,)?], device_table: [$($dev:expr),+ $(,)?], $($f:tt)*) => {

base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.34.1


