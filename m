Return-Path: <netdev+bounces-138957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C289AF844
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 05:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66885B21FBF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49991B0F31;
	Fri, 25 Oct 2024 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbgCZRqK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339D1B0F1C;
	Fri, 25 Oct 2024 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827279; cv=none; b=gortbliKT+8oii0tTPaIbs39tdBiIiBJ/VjTXJTZcddFAKprLQdRjlXKlddyxIHXVNUGSraitcl8F8pHugGqC0FtH4Go9gjvt1yQsXO3KnJa4J2qMfqWIZivRUl2Xfvvd7r3hVUgtgm74uXKDPY22AJdVCM++SQP1niMnio+BkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827279; c=relaxed/simple;
	bh=jB92JpeDW2yhP2VRKGudKbbfDREsNE6Gpy5FBMVK5aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tckyOhPpPKUS6sI3a5I23tv2nzvWtHdH53BW13lNmVqc0vdOYExH9l3a6uF+0tH6APXKUg02GPe+Ez3/IfNVPmlt+qicFHE9cf6inmAGVIGqPTFpgRBRvJfW4QgF2dyVvNm9RA48m1vwsRI056fkn6jP2/727sF2xjmOk8WsnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbgCZRqK; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8de14848so877201a12.2;
        Thu, 24 Oct 2024 20:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729827277; x=1730432077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mK2RJ1Xug5oMAzwhSCqVHPpqDu7p/3YqJqaxy25r6IM=;
        b=QbgCZRqKte0cIj2PmXXi1/D/AM/ld59kHK+Rz4IHb6EA8ztM1vEPQUVtD7yK7KuZA+
         F7DG9W5aWUimm0B8GAstODa5WstGSp7FZe5NKffesTEeSqE9dVK+jQ6vLs+K6GHnrHQg
         sbRSzh2r8zqrZe9eP6vGmj7AtQMnIE4HY7Adtz3lgvZkNfe3lok0WxH8VWjCTy4rZnN7
         uG9M9yv1rNzbPiMqv6m1h3f8Lo960m2oJsPBvcoivqEs6RuCxzruDgNPydY7MiJ1t8LZ
         0xOh6pZgPzMbvy3iut2zeheiUcwaf3LegSaNxMchAhaK2t773jSy1/E2ooyl2oeZ7RKf
         WkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729827277; x=1730432077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mK2RJ1Xug5oMAzwhSCqVHPpqDu7p/3YqJqaxy25r6IM=;
        b=U/Y357W9qT5FkuuQDeg0fhuTt/KbOeGd97/FsppLnIsYOaejuq/Gv41hGpwFNSxkNt
         XvGscEj4FnIDqnVSjnYh5Z7dfg6yNwp8lZjnUnFgxB4WN87PKJZs+aXVTE8w6YceAxHi
         GaQQZvvfnU9FdwdIXo9uuM3YIR4IfAG0BQhkLg4VV23oCVkhzGdz7SyoMAE5UWSd/J2g
         HP2Q1YnCNRc5iBiVx+IWoVB8Qy5v2OMndhwZKKw7O2oFObPjScIaYxx3g7jsCLIOHZ1F
         wzwQ+MCFkLDiLAu7xhU/txQc/iEtZomQ+3eaKESt0vq5AWcCPdtP4S3UMq2UHu67Kitc
         rF+w==
X-Forwarded-Encrypted: i=1; AJvYcCUi7L3vrYX9zAdCZnAzS8T6ItuWrAETnSY4496dDfr/BUK43+ebj5XIWCoDocioksmmfTS42CIbh5PyVTRthN8=@vger.kernel.org, AJvYcCWwYw1SPPqMgEZVSfVIkvWUPBvp5b0LtcqksQjbFqKSBQdgQVuBN2i1j0z9DtPCs7ocNhlcwOsRjf1ZyUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv85pUFpkYjQMA8eBSHoT1yjRdeMiiYJyL1CfGZTrzvpL8hb7Z
	c0hgmBw2qFKkc9/k82kxg4/VlqUXYB+WFiEHFxTy3FTb6xsy6l2KeC83iCVj
X-Google-Smtp-Source: AGHT+IEH7dK1McuvR7hzSWJAMJ7WGlTHb2AlplhCtkFMzCX87+IiwGmqetTU9HQS3ZVTMuAz2d+mnw==
X-Received: by 2002:a05:6a20:1d98:b0:1d9:4837:ada2 with SMTP id adf61e73a8af0-1d978bad18emr10579527637.35.1729827276975;
        Thu, 24 Oct 2024 20:34:36 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791db5fsm180188b3a.11.2024.10.24.20.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:34:36 -0700 (PDT)
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
Subject: [PATCH v4 7/7] net: phy: qt2025: Wait until PHY becomes ready
Date: Fri, 25 Oct 2024 12:31:18 +0900
Message-ID: <20241025033118.44452-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025033118.44452-1-fujita.tomonori@gmail.com>
References: <20241025033118.44452-1-fujita.tomonori@gmail.com>
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


