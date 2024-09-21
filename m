Return-Path: <netdev+bounces-129137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3097DBDB
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 08:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D218AB21C37
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 06:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A76014A627;
	Sat, 21 Sep 2024 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgWeOhNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7D74BF8;
	Sat, 21 Sep 2024 06:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726900163; cv=none; b=r7Z5tul5sD0ykwDWt8YQD9BOII4w/o1dG3gFsXA+QTF0vmqPVwdd3e9cYO6vsTcbe2UeDqqcwRruRlY/Hqj+Kws0PhYn3YFYuwmHyzxmWP8VBBBEK93r41Y0lO0dj7aw5tBV1Dbl9rBuzcT5vJiYuLPVQ/gzQKjHSZCzuuOK/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726900163; c=relaxed/simple;
	bh=EcJPydsHnRGQW6LvPk984ivfdu78cEbJqUHvT9tO4GA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uim1Tu2xwFdW0QJjrpa2Gn3Uk27MJL+TQhTa79AV7+2M9DSN3k2SvRw0BBz4P6CAO1xN3OB7DZVinSpdFl8l5PX+sCzDaHYkg5n3+TmG8IDNQpphqG81pnYmkj99HfCJd2SX7nRO+GZuELi6S/ho+lyxlHe3hcK5lzStoF1st5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgWeOhNH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-206f9b872b2so23574715ad.3;
        Fri, 20 Sep 2024 23:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726900161; x=1727504961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=moyjRHrcUgC2KQDXFHWcgH89RQ02eBzSTJuHo5HVnzI=;
        b=mgWeOhNHO0Um5pqQzxoPewBQbr+A5em2RWjEPoJ4d6Oq/QhqpB/dubFtnEoSU+s+/b
         O1Z2jWu7tR2NQpaeWxIkmcvdC+eY1qa9UKSexWCVays+AtmJVq9mGq9DJM+jz3YbYGtv
         LKD6Vu2Ae9hzW/b+n5aCBQHFPIsoHlAAPj7GrOlKlnrljdjADLLFMQkXCqhfrAxSnvI6
         dNqYDiaz7SVVh3KCIfh8j2jickBQFRRJ8eWjLL6Ju0QmmasNC9tFCaHEqkWeGWDhMyld
         ykwWjZjYGgE5Lb7KaHE7BlcyfIdNqs6ly6ghPIoX3sXok4g4NZ+Ry5E6VEsbPSKYhHrD
         waPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726900161; x=1727504961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moyjRHrcUgC2KQDXFHWcgH89RQ02eBzSTJuHo5HVnzI=;
        b=OvxeuIUZTIqhgw7DmwNysA1lEM8WmTlp4dGNwcjajIbdLgHx+3Jcipz9Q/TJ65f+R4
         taS1HgyAQkdQhztq8UuGWygmTjuCkEsDO0qXgtZWlq1gy+zzcDs8od139Fr85qd/2gn6
         xHs2WLivlJOMTWRs7yuPlKPotzKhf8ac5CK825xe5JD36QdiIeYh/4J8EPb1Ur/juewc
         LjuQpZUXV8a2aavBMDTrLn17ivlDNGzLKKDEaMUD1bXA+Tu6O321gNWfZM/U2ULeIK3n
         2BzpzE3zSxbRvp8jZJ0L2ZD0Jl8w2wxHZlP47rDRU9Osc53d5sVL4R9NQYvY16GFPNRU
         QGqA==
X-Gm-Message-State: AOJu0YzqFsyTKXrBKFx/xkeRyOdwfm8KOkvhdWUpkaBF/kxHeKCOdKFU
	wFcXneQsVdSYWieasbytygSPjooSggWY+eZ7jc/aQ89xKW8Lp7Z+gWSJfddHXPE=
X-Google-Smtp-Source: AGHT+IHCA8z7Ymc9hTuavZkBk+5vZ6yoISxOBLUsW0sjlC+EpWnKZ65NTSy0s9+3jAHYBLIWT5+jUQ==
X-Received: by 2002:a17:903:2ce:b0:205:9112:efee with SMTP id d9443c01a7336-208d9807d25mr63145975ad.21.1726900160916;
        Fri, 20 Sep 2024 23:29:20 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d27dasm103401015ad.172.2024.09.20.23.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 23:29:20 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	aliceryhl@google.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net v2] net: phy: qt2025: Fix warning: unused import DeviceId
Date: Sat, 21 Sep 2024 06:25:49 +0000
Message-ID: <20240921062550.213839-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning when the driver is compiled as built-in:

      warning: unused import: `DeviceId`
      --> drivers/net/phy/qt2025.rs:18:5
      |
   18 |     DeviceId, Driver,
      |     ^^^^^^^^
      |
      = note: `#[warn(unused_imports)]` on by default

device_table in module_phy_driver macro is defined only when the
driver is built as a module. Use phy::DeviceId in the macro instead of
importing `DeviceId` since `phy` is always used.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp@intel.com/
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v2:
 - fix the commit log
 - add Alice and Trevor's Reviewed-by
---
 drivers/net/phy/qt2025.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 28d8981f410b..1ab065798175 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -15,7 +15,7 @@
 use kernel::net::phy::{
     self,
     reg::{Mmd, C45},
-    DeviceId, Driver,
+    Driver,
 };
 use kernel::prelude::*;
 use kernel::sizes::{SZ_16K, SZ_8K};
@@ -23,7 +23,7 @@
 kernel::module_phy_driver! {
     drivers: [PhyQT2025],
     device_table: [
-        DeviceId::new_with_driver::<PhyQT2025>(),
+        phy::DeviceId::new_with_driver::<PhyQT2025>(),
     ],
     name: "qt2025_phy",
     author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",

base-commit: b5109b60ee4fcb2f2bb24f589575e10cc5283ad4
-- 
2.34.1


