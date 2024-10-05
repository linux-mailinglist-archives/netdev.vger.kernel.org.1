Return-Path: <netdev+bounces-132369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C819916C6
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B141C21A5F
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3D1158D79;
	Sat,  5 Oct 2024 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPCTYc7D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00757158A1F;
	Sat,  5 Oct 2024 12:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728131200; cv=none; b=Id/WQaf81HBUnoZux11zl8WFL2QGS/C+cWao8Ynvf4P5pjHDinRTqhNxrS5h2xb7AGv8qE5y+uKYuvnP3ADcIVkMvVeYv+RM8FvMf56TZy4vOmVajjn1fPmOdTPMKq9AQHdSIf/3mmWjipKVBGFCFXOEBHb+K2vuPxMPRSGAoko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728131200; c=relaxed/simple;
	bh=fqFACiSqMZBgnX0/lu/Hs1iRXNUzcVy+wdWJ8PqhZLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdZcdnjpgyhnrhRYuWsFs6sslrbAMQL0S58bUkApsZ+XgXqeqbMfB11hf10AxlAi2plNEZbRD2dszHZURBh9J6OKGDH+CXzVRSgAIVLzFMv6nnVmlJyQoyNkvP8nDdBxX8+WAejRLLyLjwk8irfjVZFQ1b17FDwrgjB/0p9sIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPCTYc7D; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71de93c918cso1103068b3a.0;
        Sat, 05 Oct 2024 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728131198; x=1728735998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdkX6wuCkXTawGfq5yedKZKwPh+awCwS1ZCSgtCWaZg=;
        b=mPCTYc7DPzBBAFJgGqZmI5y5b4f1Us9EJkNuZPb8hAdK23zBTPfC2/U/QYBAo7LeeI
         hgounnmrLHkZ3WRLySuBFtUasLRAJIR6ZeLQcd6OCJXpJLK0J3fzd1ium+ZMwpeFSROf
         B8GMFTmD2l+Np8MgZeGQFg7DPGowPADcvvWXDdlHgx0GUcxTMWdLfy7az2SIJohal5x6
         UioFC5DBJTDuEf1q2rO0YqiieLOCD0U10nPKTMZktFYu9FALRyQRKmKA5w/qktrHnCq4
         jVOoamKewe9bz0ACllT8BPNrJr6T6a0IURSujlczPqVjFxEG6LAFqduLuwsTgXZzp0KI
         la3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728131198; x=1728735998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdkX6wuCkXTawGfq5yedKZKwPh+awCwS1ZCSgtCWaZg=;
        b=XXY3ENjv1NGlcuLXOYkINO1nl74YwCYcbVUPzJ3ipZtWov7nOBeFSnCMGAr2kl+AfC
         6AyGLDM3RjJxhf2ou7gm9ZH//SYV5aDrzOqfoPykgkM5RBgdKp/taDGbsFlcUCHbjdwt
         Kjc9zkV9T0cwInjS+S7VjuK/XsfTJeMrHZtkia95/pJjKcjgiZTPQ0aefQrikiopavE5
         ZqTDN6CHm7U607l2R25YVTOils1jw+8B0U1XZ1gxUFtmNVYZI15glBDH6qoCEHTynSA7
         8trIlaBdwpuCiXxcwmOkpH4vwtkiwgQ5pVXEzp0pcLpD2otPAeCWWuKirSG0Yv7vfqp1
         +AyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf38y+m/bA2Useul6qCZoD9laeCk72N7uFpqsJvgZED7ueywFGF4/WqF869VU5DR8RT882mjUdw3syiag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrnNXXRmiYIOYGz6y08/EW44tNghOFmlYu0xCh2TcUk7T+oGg
	CEiJefPYhQxKPtVS+xIyev6LESPIiipGKajuByuv7ukoo9Fd+BVF7TUzzgnJ
X-Google-Smtp-Source: AGHT+IFZZxrOV3jNdJQFi3xVOSpRCRDXWy+64wpkzTQY+OA+CMx4Xc/JuC5z4UHhSJ6BHkfOpK/VtA==
X-Received: by 2002:a05:6a20:c70b:b0:1cf:e5e4:a24e with SMTP id adf61e73a8af0-1d6e03732e2mr7755425637.16.1728131198157;
        Sat, 05 Oct 2024 05:26:38 -0700 (PDT)
Received: from mew.. (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cd08besm1397878b3a.79.2024.10.05.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 05:26:37 -0700 (PDT)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
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
	anna-maria@linutronix.de,
	frederic@kernel.org,
	tglx@linutronix.de,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/6] net: phy: qt2025: wait until PHY becomes ready
Date: Sat,  5 Oct 2024 21:25:31 +0900
Message-ID: <20241005122531.20298-7-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241005122531.20298-1-fujita.tomonori@gmail.com>
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wait until a PHY becomes ready in the probe callback by
using read_poll_timeout function.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/qt2025.rs | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175..b5925ff9f637 100644
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
@@ -93,7 +95,14 @@ fn probe(dev: &mut phy::Device) -> Result<()> {
         // The micro-controller will start running from SRAM.
         dev.write(C45::new(Mmd::PCS, 0xe854), 0x0040)?;
 
-        // TODO: sleep here until the hw becomes ready.
+        read_poll_timeout(
+            || dev.read(C45::new(Mmd::PCS, 0xd7fd)),
+            |val| val != 0x00 && val != 0x10,
+            Delta::from_millis(50),
+            Delta::from_secs(3),
+            false,
+        )?;
+
         Ok(())
     }
 
-- 
2.34.1


