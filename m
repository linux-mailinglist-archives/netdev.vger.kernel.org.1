Return-Path: <netdev+bounces-136028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5A499FFCD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 05:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B4FB26206
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 03:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19218E044;
	Wed, 16 Oct 2024 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChOkcjtv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE21E18D62D;
	Wed, 16 Oct 2024 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729050852; cv=none; b=IonzpMEK6HRF0sPOokFoZqeXZfq/Ynzz7haQv0c7madz2o7rDTNufqVvg8Pi8279vBciLvqx6BixHV6tNwzy7uV7U2bVqtRhydY2/6SdnLoWvYo0SYb+g+xPrhzxNyNw0z/4JRsGimxFr69qyL4ZfHI1y3JOSLpfii9Wp6DdAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729050852; c=relaxed/simple;
	bh=jzFKSh9o+bumGj3TnLtbfXkFEwNCdfMJAShnlXD3DRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkgmePk8Aj+XpsAk25TxeV10lydIYAO3+VqVqPpxdwCdlwWBqd1Rb00b7rUM2ZbixyD7cx5ivyGIV+Fpidi2MMzNTtnz6EZJIAcFi4at4KQOtC+wbVTBsgOjT+0f4sJL0H+sG5JJlzD0XXL6g3fiXvWiLsOeRnhq2kmF9XrIgEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChOkcjtv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4043998a91.2;
        Tue, 15 Oct 2024 20:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729050850; x=1729655650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wo+ebOBA6uOgnJrPTZr9hFWwcZfDvc+UeNZE4w2Oi2o=;
        b=ChOkcjtvbKEJIuuNmjTbYv4lesPODnibuLey+sRCcE62wMf0scg4gWGnhy1Pe36fEr
         vJyoAUzzHr8NfWMVHzA3y2Bd+Rc/8BNVwS68XdiwUpGu7tD/be5FesqF7BZXv4DDMi5L
         lhD11e8y8kXlrM9najhOdE0VDDwioZAJB5rOde8uV+KJhn8eOQmYdluR960yCK7zIUVk
         XR0HOIMNw3kQuy3fh6VR+NoF64FqauNLtqGEymCy3qbAmDz3DCaEGuflRnUIY66i4aaT
         Ri78itSchzZeiZvqO8yiuF5Phzepo7BHzSsZj9HG2VFeewAr/inVfMfw0DGQ/bbQNUcE
         EuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729050850; x=1729655650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wo+ebOBA6uOgnJrPTZr9hFWwcZfDvc+UeNZE4w2Oi2o=;
        b=JEdPmFx1uHTOai7sLoXpEtB70bRDlTp54lI4N29YrC38HnL56uxfEMu6a9tJb/QKs4
         OhaMGePlxvOjCKW6BPcFCr9+9NDz5YEoHqIYFxsRaDLGpj4KnwYJIlzjfKqfjNLz1gq8
         qVBGEG4r+nL4D9hIXiwcDUQnafS1kK9Phndt2HLClL3BQaH28/N+rD5Ryo9dqW9tnYNs
         bXEBDF06UzpqMT23EKs03Ac7i/aVs0BCZ08msPApLPz42rOVGJ1p4hr5RufeX1LO7/wv
         A910wpAM1ynSuST5KrZ6Ww5ozQ9OXcmgdSIDZuTtv7Kb3iJBPuSWol9goaIDQkPvO8uQ
         9T/A==
X-Forwarded-Encrypted: i=1; AJvYcCW6cBKOiIWHVM2ZWqR0EdtnTWOMlOIvGf7iBnJNDzTBAjSBU0V3jzyIw4znTHvt8RjVZEC8z0xMmfojbok=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8SOv/OjBb5Xm4VoZ54vxB+uOWPt5kM5CpGmuaeRzfG8P4e9N
	68lySxLh9jvPx9AY3jWWAU2tKtmsIhy6OLHSkqnG3G8exQfPD3tVTKqNZhY7
X-Google-Smtp-Source: AGHT+IEA2CCbHvwGf03FPLUkUraMS05ikMuK9tpmIBZQSsxZM5NDDWHrubA89P/w0fE4ZMPfSNlTcg==
X-Received: by 2002:a17:90b:224d:b0:2e2:bb02:466d with SMTP id 98e67ed59e1d1-2e3ab8dfb4fmr3212058a91.33.1729050849805;
        Tue, 15 Oct 2024 20:54:09 -0700 (PDT)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392ed1a4fsm2885691a91.17.2024.10.15.20.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 20:54:09 -0700 (PDT)
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
	jstultz@google.com,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 8/8] net: phy: qt2025: Wait until PHY becomes ready
Date: Wed, 16 Oct 2024 12:52:13 +0900
Message-ID: <20241016035214.2229-9-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016035214.2229-1-fujita.tomonori@gmail.com>
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
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
index 1ab065798175..dabb772c468f 100644
--- a/drivers/net/phy/qt2025.rs
+++ b/drivers/net/phy/qt2025.rs
@@ -18,7 +18,9 @@
     Driver,
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


