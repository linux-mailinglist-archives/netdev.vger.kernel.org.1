Return-Path: <netdev+bounces-144702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BDB9C83BD
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 08:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A38E2846F4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13D1F81BE;
	Thu, 14 Nov 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8mtXEMl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937551F81B1;
	Thu, 14 Nov 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731568042; cv=none; b=bGNHAqf+k+/LEGQj5NWC/0b3BoIpe/YaGKlaQoXgKH3oRaj2gCrMn8Jd++t9s29NDEXVFuv7W2ixIqR1aT/A/1oql1sQCVZwUrIefoRM1bKUbJ1td85oC6kVEhQ7vRDToUqeb/bWIqHonCFc4ejTKJifX6wZhGRsd+hgvACX6Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731568042; c=relaxed/simple;
	bh=s1fGkXCbAOyGJfqqcT0sczwpfVFOxllsZIzn+hXFv54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=drBW4fWTEIvSc5MqvOMGdVS1cX1eEK9INFgl7/3lKPK/zMJ/QkaVON1yIrsrr81yurTdqufDaFBRkYwficeocLLy+enz4hbD8Rk1uB0PCJQRN6qtMi15Fz5/RCf06+TCo8e1Z3hB+4pAiNWnoaD13M25JVHzxK5h8f1ccWFzfNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8mtXEMl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2118dfe6042so1892925ad.2;
        Wed, 13 Nov 2024 23:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731568040; x=1732172840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0qB0dHVK4fkbUBFWgw/OXByiy+cGpd6DkNTPsTFikE=;
        b=E8mtXEMl+eWsrwWA+yP90+TfCvFPjP+LAsdEMW6I5NZaceny6HoJKjyRZQkx+5E1Do
         c6F2/7HvArwnkc6EM+2HfizOfwshR5ZX22IVuBiQKEFnAuvn5irR30p5tJmYT+aaMP4c
         pXo0IjmxDqTybslQCPvR6R6fi1fvumJNzP9/uOVTVbeOeiNubUHtlRke0JgqCN7Tp+w5
         +g1g9p/7CdNaaz3s/Q/awkJrjhe02vlp3F1SNPatBX/iXtz++a/bOQyG2zNc2E0DQeyE
         toWf4CQhkzAZSusAG50yVzAWUUCh/Ev6TyLkWapHUVvLc+zf1zucsxPHyf830DlRmj+a
         gAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731568040; x=1732172840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I0qB0dHVK4fkbUBFWgw/OXByiy+cGpd6DkNTPsTFikE=;
        b=umBCX68TblXrbTVdGVhNANKfaSe82RrWy8jqT6a3Tr0CH0guPwv+YQnEhwbA+76f9Y
         SIgU25RrZSBuTFTjDY5NsQiV8M0vdp59ElNU/8tw2WWPBXQmEMinvDMHFrRW7AyKyjVx
         WQAfD5edK0OISjMoMyFvjhVdKtR+HCS/GC3Shnw+wYlCvg0Dt6ZRGtIaPhWz7XNByjUa
         MdgoC04RBFf5M4EaFjubabN5qzLeAP6mcFVCRfhBdByHcbQxzWriZNbU9JJB081hJzgK
         lNcql22b4+Lkyrh4/NBHpfuWJrlDNyRoVDceMQVaipP74cLVhjJESYqw+zwmz4FtlXkH
         lVpA==
X-Forwarded-Encrypted: i=1; AJvYcCXAwLQtwiT/XCG996mcgWeGlWMqlIIF9uqk0etMcbqOCvXLdmfoi8m/zQlDA3wSAmlTgt4DbRVzWKq67wfk1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBAck/MaSEQEhal3gst2H6OI+OXJ5JM3WKL+OWbkrYnCvCA0E
	ka54qKBs2lwQGHUsZgxilzQKgRp32rzg5dXT5THIT3MapfteJCmfc25JwSQE
X-Google-Smtp-Source: AGHT+IEJem3Kp38rXmgL6DAz6s4FPxX/o78x5w0/1Bw6VftwfbcnCG7GRH7kBNbdt2lBkrBrIW5i6A==
X-Received: by 2002:a17:902:d488:b0:20b:65d6:d268 with SMTP id d9443c01a7336-211aba446f2mr134652305ad.53.1731568040612;
        Wed, 13 Nov 2024 23:07:20 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm4260315ad.244.2024.11.13.23.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 23:07:20 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
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
	vschneid@redhat.com
Subject: [PATCH v6 7/7] net: phy: qt2025: Wait until PHY becomes ready
Date: Thu, 14 Nov 2024 16:02:34 +0900
Message-ID: <20241114070234.116329-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114070234.116329-1-fujita.tomonori@gmail.com>
References: <20241114070234.116329-1-fujita.tomonori@gmail.com>
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
 drivers/net/phy/qt2025.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 28d8981f410b..c042f2f82bb9 100644
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
+            |val| val != 0x00 && val != 0x10,
+            Delta::from_millis(50),
+            Delta::from_secs(3),
+        )?;
+
         Ok(())
     }
 
-- 
2.43.0


