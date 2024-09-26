Return-Path: <netdev+bounces-129963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3855D987361
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5771F27730
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AB3158851;
	Thu, 26 Sep 2024 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcm8FqVf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2EF9474;
	Thu, 26 Sep 2024 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352995; cv=none; b=uMiN/me48OYhwMTzTUDPPnekuRYWR5uvGtc3KXFuWzBnfGcjeEAoO+cVlhKvMs2j2kAZRAkCqNuyzHhTM0EzHBHKaw8Nqlu8eHpST0DOpUbntArbykWvWWlq9AvRmsak6yPLSsNR+Ly45aw8Xxk3QKgOfabwfLe7QrFP6Mbfhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352995; c=relaxed/simple;
	bh=6jDdywGd8sGLg0g+8ifYmBt7GKJcmc0mmZs+1uU2AaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kldAGTVzcGT+eTi+2jFV9Yi82gw3jOIvvKBYYQscXtAbo79P48DnyqLnf6U+r1L81irTn33mjBKFab3oyzml/0rJ112aPOE9Kv58BRHHgmFKiMdEmS80h5KE+hmOz6l7Fm8o0GnUC6i7Mgou82VUMO6vWz2dRw+PG+riQDDMvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcm8FqVf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2059112f0a7so7047405ad.3;
        Thu, 26 Sep 2024 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727352993; x=1727957793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RFWRrrc/OB59rTuGIRSZF3RT/9LOUXYC3YSwE4RjXKQ=;
        b=kcm8FqVfU6xhejk0fu7kJcTiRRk0zpPuQ62095E5NfjvfrT9+aC8w65Y/p4BdJkPXp
         kiVT+WE7LXlqEDU20LFd1fNlWArdkzfruAiqwapa4c3Uwrh/5EWYI9y4781U0gwCpa4e
         cEEeF9F/b87pbEwUt8DjdBNAu+tm6xUOQIdFZO1Dug4swYT1uWTnkccysu867Pb1442E
         PBWNCNVh8wgqe9TEoleVbRzM6ydqIFRbc6cH+QpUa77mYWgf33+dI99oRl3Gf69qpXxz
         xuuejHfwdyKjgaFOcYJ5IWNHbcYgPkfclKbxa3/hwEpO2DPJPdrwU5D6D1VquID65UgT
         sknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352993; x=1727957793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RFWRrrc/OB59rTuGIRSZF3RT/9LOUXYC3YSwE4RjXKQ=;
        b=WjhTX1GeEifHyDkRIzYJ0PS6+51RJcIqke20H69QIbrGfCAze4VQPtDwH4OhkfxWRT
         NZjLdRnbVYh4pt+5sQPhCdDZ5MDS0S30Ma1hFqPTWcdn0zkPELVXvPl72/lGrG9OwpLW
         Ornk8keSJJ48Xy/x29vPqgglnn9DiXnA3aSH2/WWzg9XHD+EiUK+i3Rg7j/jeJl8eAdS
         CfFtFILyd2gjKD3z1j/ZgmKTC2S2lTw0iy6fAeJQNRjkAOUfH4WYZ9kDY0Q4ZZDo1FLO
         jqg0XDxSgF4D4DhMISgg5o8JoxwCvCTD5fCeZHg+Q8PwgTPNfCtBuhJYfsNr+ieE25PD
         vLKw==
X-Gm-Message-State: AOJu0YycN36oqqAX7tFMzVUk+Bn2gx6XSeyYgnDb6ZQFEjUap2cCUlYY
	35Rr3dh97ieSI+c7JohDIJSUaQBpTOzawOacSPuMDhMiB1M0gcDGJ5S2LXKU
X-Google-Smtp-Source: AGHT+IHyCVxo4uRC7+KQrVZwA38pdP8q+YT+SnlvhP6nlgn5ij9mjJRzqH+5BytSE/yLkRG3f8576g==
X-Received: by 2002:a17:903:2bce:b0:205:5427:2231 with SMTP id d9443c01a7336-20afc5e1120mr81235105ad.47.1727352992831;
        Thu, 26 Sep 2024 05:16:32 -0700 (PDT)
Received: from localhost.localdomain (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1722177sm37722765ad.94.2024.09.26.05.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:16:32 -0700 (PDT)
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
Subject: [PATCH net v3] net: phy: qt2025: Fix warning: unused import DeviceId
Date: Thu, 26 Sep 2024 12:14:03 +0000
Message-ID: <20240926121404.242092-1-fujita.tomonori@gmail.com>
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

Fixes: fd3eaad826da ("net: phy: add Applied Micro QT2025 PHY driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409190717.i135rfVo-lkp@intel.com/
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
v3:
 - add Fixes tag
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

base-commit: 72ef07554c5dcabb0053a147c4fd221a8e39bcfd
-- 
2.34.1


