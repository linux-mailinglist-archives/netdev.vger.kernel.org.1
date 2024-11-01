Return-Path: <netdev+bounces-140864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86FE9B8823
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AB281A0A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD9140E30;
	Fri,  1 Nov 2024 01:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6RcZ5PQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D00413CFA1;
	Fri,  1 Nov 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422968; cv=none; b=jQXfFCvoI9Ym4LOtrFe7k9ENzh9a76CCUJV0MCixUy7HgNUn27u87qO2O/5EKQD1swgCLrjzSUL8GQ3cj6t5K2CAB4lDKCrquZkox5Z4Rg/Kf8hToKf+cITMEuDATzEOHsTijaisBIAi+GjU+ovQu0UEHsFYxX9St0MWssK5Qfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422968; c=relaxed/simple;
	bh=jB92JpeDW2yhP2VRKGudKbbfDREsNE6Gpy5FBMVK5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbaSPEK61hHqqRkZIfrvYBpEWbdYbkdZdIOWYXHb58WjLi4O289s/PiTezCltprmEah+ENvCcrZDk6PEEtIZH6a9E67Cs0+OyhFas+c9CeFHVYfaoBP/+lVvzj54BwYW5RuK2nq3zxWvri/Y6X4ZELViAdjlJuGbvIH6TT8H7+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6RcZ5PQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720b2d8bb8dso1167682b3a.1;
        Thu, 31 Oct 2024 18:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730422962; x=1731027762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK2RJ1Xug5oMAzwhSCqVHPpqDu7p/3YqJqaxy25r6IM=;
        b=K6RcZ5PQ/jHuVET2LPDWRT2gGOMPoZJ3qgUoBgvFr5oV7CIMS/r7SDhWAGALecqJXE
         uHIg/rdboZmHcPGHbZdnY+Sv4wFRG90tUv+HHpxJd83gr82jEaHcpkS4RKkFm+tnuNCo
         9NcUL37CXyiAiqF1h7uQunn9XcAiZyVyMFIqQ09Lr+I9DvO7/yQ8fnNoOXxgUqRQDaA/
         u1bw65umUQ0CoPf0csCpvTO2Wxw8u1OyytzRaY4PZTx62GHVBfgiNJmBTRhJl0VzL8wC
         4ggImIqFGbMRwqbeCI62tNhRZ+qeJVED9eEISmprzUrAKwOPJWymAOZLdX/AJ08eeX3n
         5+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422962; x=1731027762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK2RJ1Xug5oMAzwhSCqVHPpqDu7p/3YqJqaxy25r6IM=;
        b=ncht1IYR0gmTY+/Q2S1H48UqXVOTUXlwnHkXp1cZSmrwqaK0RcFJGr/j3UwbgwlYpP
         4uw6UyAjhe9POED8FUB/A5GMZEcDcXxf9znaeYHdt6jILuv9dRSo3u5MuAdBo4nkH2gy
         /0b1g6BonFyLCq5c4ov/jdFno6KiS6GeofuQ18mQjnS6gpGLy3d4RQpHb5WBVwoQR6Zv
         Ol/L7M9pVi6sZMiX7ycwj0l+pBTxSWbRqf5SkGfsiEqXXlhJoaWQU5ebZc615y7hByIc
         0qjpr+bbmQxavUQt4cWk+n+EId2/9cB+DNOvzJyloW29Wuhd3XRe59O6PraD5kIEli1O
         +NXA==
X-Forwarded-Encrypted: i=1; AJvYcCVbYywT/5Drc6KJs4nr+b3TdQrs3bX2tuHhYpFzXHJ//PXIOL/9feYfPDh+kmVv1kY2JhSXs/KvkTf2Lvs=@vger.kernel.org, AJvYcCWwy0HpAgae6Ff52/tBqJbv9o592t8fBR0VN2G3sVfEHXfY+LdjDwcO0kHuHlmdGxkjuCF3lQKXue2wSorxdCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JezzUUcCeRSrU8yDK1PFhuQgN0oe7yjdJv9tUlc05L7unOW3
	24llqtl4BHzUbW8xQtHiwd15b8rPKcq7G1hBdM5Ad5J1dMYf4J9S
X-Google-Smtp-Source: AGHT+IHkyE9UpBFyYv5S5Va5DuUIZq6OF/wcFyP2zyu3sOmg17gD9KqyIrhK+dK32peNyOFGyFxLSQ==
X-Received: by 2002:a05:6a21:58d:b0:1d6:e6b1:120f with SMTP id adf61e73a8af0-1d9a83d0b04mr30096430637.11.1730422962531;
        Thu, 31 Oct 2024 18:02:42 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ea6a1sm1743403b3a.74.2024.10.31.18.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:02:42 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	arnd@arndb.de
Subject: [PATCH v5 7/7] net: phy: qt2025: Wait until PHY becomes ready
Date: Fri,  1 Nov 2024 10:01:21 +0900
Message-ID: <20241101010121.69221-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101010121.69221-1-fujita.tomonori@gmail.com>
References: <20241101010121.69221-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until a PHY becomes ready in the probe callback by
using readx_poll_timeout function.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/qt2025.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 28d8981f410b..f7480c19d4cc 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -18,7 +18,9 @@
     DeviceId, Driver,
 };
 use kernel::prelude::*;
+use kernel::readx_poll_timeout;
 use kernel::sizes::{SZ_16K, SZ_8K};
+use kernel::time::Delta;
 
 kernel::module_phy_driver! {
     drivers: [PhyQT2025],
@@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        // TODO: sleep here until the hw becomes ready.
+        readx_poll_timeout!(
+            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
+            |val| val != 0x00 && val != 0x10,
+            Delta::from_millis(50),
+            Delta::from_secs(3)
+        )?;
+
         Ok(())
     }
 
-- 
2.43.0


