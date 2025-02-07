Return-Path: <netdev+bounces-163989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAF7A2C3B5
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE793AB960
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 13:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAE21F560D;
	Fri,  7 Feb 2025 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+5LtLQz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2011F4E56;
	Fri,  7 Feb 2025 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935149; cv=none; b=sTwfZfeW9VoZ6s0Wz6GBWlAg1cfkEz59OHWOGD6Zcws1YXQsR7t3Em3VOXULCdkc0+8faF/acmILhi/F7/vK2sBqjUTeg2Z7y2CcSnTmbRk8943TjOOc9nBSjFpSBf437I9YNteuP+34vFGujMZq3gzCrdU/yYlQ7MvTE8fLcZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935149; c=relaxed/simple;
	bh=p/LLNspP63XeDluK8n1bB3ApPN0HiknOfwCoEOeBPsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZp7v2G/8UGCb1rJQMI4LE5po7VvqCdDPwnYgGoHK/Q1ZeQiPoelaRD0Fh5KXAN6VswEGQqMinUbK/MlhPiVrkC0RraXPIpkrJtsaVWKcS6GVPqYuoC8UqKKMbIPlBNLJNYgMcSzLKWD3n2tOm+ZNgUISc6ibDMiNcsgvPkms48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+5LtLQz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f5660c2fdso9590525ad.2;
        Fri, 07 Feb 2025 05:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738935147; x=1739539947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R57PZ40vsMBhmQU5DVB3HkIVq/yRk+LSm6ONd5T9PSk=;
        b=j+5LtLQz4hKl9OtugRZi89BG3nF+IzTUkizVR2EhR3vMCOMOTUu9sovFpSgTCZEKBu
         OMqY74VB9t13J3ad349EmLTqTkQbPmve3TL1OUuit1j/nJuuEurkIEy5y1QRoLIBy065
         PS819Ny5ET663NbQbcxzbq3WIVUXyeOJDnKI2DZUOAxFJr0SjXxunY9gX2pFRrPwxKD3
         xXYt2f9jdJMnbdZIqr8WHoJ1GpULB56GOG3YG8nsa8v+yu/Q0qhpLReiYCZdmUHZTqoC
         0lG9bS4QfIorrgWs07KxwTL+yiSWDw4o4w//82VcyN/EOWswXUr2kVxMgtemESPQKCfE
         84MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738935147; x=1739539947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R57PZ40vsMBhmQU5DVB3HkIVq/yRk+LSm6ONd5T9PSk=;
        b=hWiSmHI3r/IMbx3ML3DzwkgCO9Bv9V6vo6SR50vYv8hTzyELDDE+99j66+dx955n3d
         qubvMEAL55pcBGA2PdLO/KbJcPdjOf7TpFMMkXVUs1YJC+1BnWJ1SEbIuBAEHJ3L5vnK
         C6VcKh99ipFTpqpbD7r4RanmCFDBSJK25fVIXMZh6p5GiN7l/GdjhfVNOJklBosA/hJN
         T5UOVo5vL7SYYZAagYUlhswzy5VbWn+Oq9XcXz/FVoi7/y149xB06lcPojUb/sWFK3u1
         1tOBmL98PpCzLIvOKKS/9hAySG68/ezbM08X3rXi9krC6xKARIqEqtwitKGhlkn+Ulny
         RpeA==
X-Forwarded-Encrypted: i=1; AJvYcCVbisuUmNKbqOrXXepEnpOdTa4rUdIRkchMEjgGKwEMJhvEECZ6Y0VBADMyUMPMKh0WRx+NxWWnQpXGpgCc8Ao=@vger.kernel.org, AJvYcCWNZEVKb25KXh4Edt/tthZlTl4oTK/gD0eJbFQgbvHm94vno0w5G4ddgqixoikJz6TAai8U+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNejoInx3c1o2mRWt9tlXzF99TONmywtwsBXQ0iiyHaxFQVO3l
	QWDkUYlNgnXCZto1ab1l+QKhtE9694x8Vtc+tmPgmDzfxHIbYKCdN+l/L66V
X-Gm-Gg: ASbGncvm/tQQhDBmzHMtUsK9qEWMCEk6BVddoOPvVVizNDXxLojhlh8ToTT3pVm61Ir
	HnaVhXk5bEBHBjsYUP7PbGNHTifgCV6Q4zK5ee7k/e/jUS2Fk+8bA0nQc1d3nwMLS4G0F2qflkD
	xvWDddc9+j+UMFHkXrlPlwW34DNn6CTptr+jsRMMfwTbU7hGni7e4l19TMVrExSYOKK8GFKeGwX
	9YUVoRt3tKBp+XJfEWphYHX1td+wEBeXdBqRB+9RvBdx02pTiKjaPL4WREkvk9uH5hGSb7F0Zfb
	yFmGVl1/CcmfVR/IiNr936+Jk8L2Mgfq1EENOBEvz/aXbbvonlRAQ03Bm6qsDlAE7+w=
X-Google-Smtp-Source: AGHT+IHhtSG2duMocArmnuRm1/YUB2+aUWDxsujnMBlnADYjatNoIUDc8APNR9zWnp5zI5ykScedxA==
X-Received: by 2002:a05:6a20:438c:b0:1ed:a72f:bed1 with SMTP id adf61e73a8af0-1ee03b5a90emr7910761637.32.1738935146765;
        Fri, 07 Feb 2025 05:32:26 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51ea79a47sm2877843a12.76.2025.02.07.05.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 05:32:26 -0800 (PST)
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
	me@kloenk.dev
Subject: [PATCH v10 8/8] net: phy: qt2025: Wait until PHY becomes ready
Date: Fri,  7 Feb 2025 22:26:23 +0900
Message-ID: <20250207132623.168854-9-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207132623.168854-1-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
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


