Return-Path: <netdev+bounces-128874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC2797C35B
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 06:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476911F212CD
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCB1803E;
	Thu, 19 Sep 2024 04:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEc6gkag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D4C1B947;
	Thu, 19 Sep 2024 04:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726720773; cv=none; b=HhtuP4xUoiKFuG1+pAxOYTnPWByKUF0xjI/KMfoWnPBm/JZK92y2hgzfwGMYw/fLA0YVixeIY6Z8nX7VcbRnzzNyZFZnHc5pQiLA3y1p/0KCRRHN3XBz3xD+ud+lT4W2uLNV8axOivCCZiTPqpJoRx3flTJfO3lo32XpLFtWZck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726720773; c=relaxed/simple;
	bh=By1pXO8MlcrIKJjeuVH+H79pclvUsAQeO4FFePYYMAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daNjxAsVoVkQ14PeYkOcSGcSmOMNsDlQj9PJ8YevysU8PhjmaWl6DTaOiYEuG3s0fiAJbV+RSQV7GYhIBe3UBhkKAIQDc0qfzbuJC+aDEeU58wTa1SQqpWoOHTF0P01lAN4IuL138GLCQcdjNsmt96xZh9vgGqIwCc1LBW3ceXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEc6gkag; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20573eb852aso10432475ad.1;
        Wed, 18 Sep 2024 21:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726720770; x=1727325570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd04kpnXehwfq41UE2xkxy2jFr1cKphCNGa8mLUJ7so=;
        b=eEc6gkaguonYw2Z47r/25rxI5mHJ3NYwHuu+TidP6CnPOYNm01UmotM135b8wCTVdO
         DS0mN1UOgo2rur+b8mAESkY9XMCJbDQuzp1DRvsStDvJ69JjumzvN1dKsTpjp2gPdrSm
         7c6mFAEPJIpiQ8XKEeWSRbrZTFBGgLfduqKyho5dcQbIVDZFn1ws+4vRBbEwgBDl/Tqy
         L/TRks3Us1lyqdckSLPBh4i7ziJJ701CirUvyVdZDoOFvnPho5cYwbAUOI46Li9dBB5O
         7SBz9YQeWc6ulk+g+6w+IsFxCm56gv+0XWeYIJr28suLqBQFiWXM2s5/Or9rqP+dD01Y
         FdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726720770; x=1727325570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd04kpnXehwfq41UE2xkxy2jFr1cKphCNGa8mLUJ7so=;
        b=gRtxQKpixiUltSdOBcLCiIV8MJumwRz2qBh0fNMuIE2+lJM3uIJzY/CPDylqV5HGZk
         nVOKLrwoYyhcCs6m+93rkvplu0OxXdhtOZvVn0aVwur94HZGaTunURqVoVdGK+LrqYTV
         vlRYE1GdDQreNy4ZCq1pfYQImoPjvvtXY+HYokr1FcwZWJZ0dm8ZIXDedDsvDt++WAGy
         V2BqgKArxlRfXTCQOC2u6g42mJoYl31Uj92uiGrmQLGj24thjxmi+GsAm+UU/P9QHIoa
         Xpw+1LN4PH997iZN/3USMtXabMXfbjGRNqD6bIpnLCH61Yra6tgozUQQlmtLowgUqkSe
         yLrA==
X-Gm-Message-State: AOJu0YykR4JImoz6QewHSTVoDQAn7/wnIrntdZvbFnT7vnFu3nxFq9vT
	OTckreNKEhby/ZI/UWtLLx++i81el0IsL+8w/VDjRPEb7u6g+DWWkgK3uUka
X-Google-Smtp-Source: AGHT+IFAWXdRUGbRwBJjhv7vrZTalz8F78Ixoww3X2ySCURu9CiWvepAWmLv83U+nMXjNNZ0uzB33g==
X-Received: by 2002:a17:902:ec8e:b0:205:5a3f:76b2 with SMTP id d9443c01a7336-208cb912168mr29945805ad.29.1726720770109;
        Wed, 18 Sep 2024 21:39:30 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4991f7e2sm8436491a12.50.2024.09.18.21.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 21:39:29 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	tmgross@umich.edu,
	kernel test robot <lkp@intel.com>
Subject: [PATCH net] net: phy: qt2025: Fix warning: unused import DeviceId
Date: Thu, 19 Sep 2024 04:37:07 +0000
Message-ID: <20240919043707.206400-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warning when the driver is compiled as built-in:

>> warning: unused import: `DeviceId`
   --> drivers/net/phy/qt2025.rs:18:5
   |
   18 |     DeviceId, Driver,
   |     ^^^^^^^^
   |
   = note: `#[warn(unused_imports)]` on by default

device_table in module_phy_driver macro is defined only when the
driver is built as module. Use an absolute module path in the macro
instead of importing `DeviceId`.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp@intel.com/
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
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

base-commit: 9410645520e9b820069761f3450ef6661418e279
-- 
2.34.1


