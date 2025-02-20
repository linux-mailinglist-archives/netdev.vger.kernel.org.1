Return-Path: <netdev+bounces-168004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217DBA3D1E4
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80471620A7
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AC1E9B07;
	Thu, 20 Feb 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmN+9b6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD61EDA09;
	Thu, 20 Feb 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035479; cv=none; b=AdgM9K4244b2UXP7vArEH9YsuloKONHT5b067/PrX+6NgQBjcrLNR7F245pAA04s6dMoREeA8GoTRSe95TCPrC8A2tmUbZ8oXDbWpilquGcW03Nf0vSO1qlUVPx1rTF2oJaPJEPwLHjAc3AnM6I74YMXeRp08gj+pZoX1McZMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035479; c=relaxed/simple;
	bh=p/LLNspP63XeDluK8n1bB3ApPN0HiknOfwCoEOeBPsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCskgST5Df3vaThuzD/gfImI7kq6BrdI/Od9QSpMvdTI7Os7Vwwa5GT0rH4O2X7rViTlmqyBo+CtAiGimkCKIgVDoHfecwFe7Vtf6UKLCZIY+8c+D0VK+fMHyD3sFosioQBfDKPpgXrNvakHeYRLNQGtjNRwDDk4bmTqmWRThmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmN+9b6E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c8eb195aso11255395ad.0;
        Wed, 19 Feb 2025 23:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740035476; x=1740640276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R57PZ40vsMBhmQU5DVB3HkIVq/yRk+LSm6ONd5T9PSk=;
        b=EmN+9b6EhknPszgZ8D9UrMz4TVHxSBZCQSawDPdWCJPlBsw5ARhQ+Wt1Iy/FXA51HU
         IcFY/W1dPfPjytHxqJs2gZKiFPo+s179YzEZGjAnE5JhyRhVy9HVNYaGgsf1wUTqZ2ZR
         X6dznxFA9FalQkMN52C+9cE4WbEkF2tRHxbXTUcWJ7JlfXlHDZvfSipW4z+qt0ZTmEdU
         v8lDUjVx3bQ4SL909VoF3A3VbOh/2hKoplABHuaQNBM01P4IVG/5NCuJQxD9sS2Wccle
         2vVkPsAwZkC14JLc9CDphMwWUJSnXgBxsgjImNC7ZVfquToCComzpTZrOAPZG71AvBPK
         1lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740035476; x=1740640276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R57PZ40vsMBhmQU5DVB3HkIVq/yRk+LSm6ONd5T9PSk=;
        b=ZlmEcL+vXdAKphXkGEjsGptJx5PpqQLYE4qU40e26BN2s8wW/QPgSqz5X73+W13VmE
         jUSN0QHu7Le/FtoJJcFz1w9QjsIuvNFic+XTTgz2Jgyn9vHsAWq1t2UA4sry7ozih9p0
         avGWE5F0UzjR7Wy7FOPsE8HIE0E+kZ3DnYLFrER9qTgiaWlWHQA6dvHdX71gH2Ncn5vF
         w/arcquT96fHEqfvb9dnYm6Rj+Dw8teVXK4GLDqXtbKITSQsHC9gN7zH6ujklHqy6sEd
         L6KFHNsXvioMHJbNso+mYhSjuyObETRR2oYqaBYdv34jP03pXtFKbQY1YtbCFZp7DRuF
         hOow==
X-Forwarded-Encrypted: i=1; AJvYcCUmG4zlOUDSxUkq097GrTDi0T58W7e4jN8s3z8bOUNAyMhh7eupUeHWPLognZ0XHg7ROre468DEKB0glrH93yg=@vger.kernel.org, AJvYcCXqBRH/miP7POEEp9vq7VvL8+iVdTn/KubKIwvVyeoGMcDpyqOd+x0pnCR4V58ZOFE5sIxhsGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySw0DucvtsEJe6yYinxXqt/9o602cXOf0oPh/88JL3UKcgxOrb
	CQ3W8eb0feq2ktJibEglA0vrI3KTBtUN+hc6ilQimWXMw8+QOOcktzZab4YP
X-Gm-Gg: ASbGncvK7/cR5zMbVFKbav+4I0y3XLcpAPIiOVBMQDxy77HwnwCoI9QCN40a9KX33IR
	k6gvnPADMk1sDSds7uXH1khaZzpptNVZkBvGj1G/tinew05TGco+Rv4ur8Nc9E5BYEX9q3KHvFR
	m1VOxS0IFJ41bQRMDVJffesBvFPhgZH9YPzX549jDbOXsFt6iLYaiS/krgi5Mpj6bgUF5bqysW1
	SgEj2vm2PxEoC9ZhuhMr4NLO2glwawgR43ViKspji9AGjt3oICQpSvUMR+JX6cugyGo7jVadOHi
	Fv52KvVuYHwtkg98hYG7MAzMmHiiXaZJYAL7KLeueRto1278aMm5Xr/FKP8W+1XEj/A=
X-Google-Smtp-Source: AGHT+IGgvvsOvoTjyFLbSMVPkqFMMTB4aJyC8QIwojlxrUp5IaE62lLYCwUR5sCAQaovzeTxC/kKkg==
X-Received: by 2002:a05:6a00:2443:b0:732:5651:e897 with SMTP id d2e1a72fcca58-7329de80994mr8185974b3a.11.1740035476247;
        Wed, 19 Feb 2025 23:11:16 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568af8sm13059672b3a.48.2025.02.19.23.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 23:11:15 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alice Ryhl <aliceryhl@google.com>,
	Gary Guo <gary@garyguo.net>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	jstultz@google.com,
	sboyd@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tgunders@redhat.com,
	me@kloenk.dev,
	david.laight.linux@gmail.com
Subject: [PATCH v11 8/8] net: phy: qt2025: Wait until PHY becomes ready
Date: Thu, 20 Feb 2025 16:06:10 +0900
Message-ID: <20250220070611.214262-9-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220070611.214262-1-fujita.tomonori@gmail.com>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until a PHY becomes ready in the probe callback by
using read_poll_timeout function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/qt2025.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175..cdf0540f0a98 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -12,6 +12,7 @@
 use kernel::c_str;
 use kernel::error::code;
 use kernel::firmware::Firmware;
+use kernel::io::poll::read_poll_timeout;
 use kernel::net::phy::{
     self,
     reg::{Mmd, C45},
@@ -19,6 +20,7 @@
 };
 use kernel::prelude::*;
 use kernel::sizes::{SZ_16K, SZ_8K};
+use kernel::time::Delta;
 
 kernel::module_phy_driver! {
     drivers: [PhyQT2025],
@@ -93,7 +95,13 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        // TODO: sleep here until the hw becomes ready.
+        read_poll_timeout(
+            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
+            |val| *val != 0x00 && *val != 0x10,
+            Delta::from_millis(50),
+            Some(Delta::from_secs(3)),
+        )?;
+
         Ok(())
     }
 
-- 
2.43.0


