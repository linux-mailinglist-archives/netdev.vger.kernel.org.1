Return-Path: <netdev+bounces-158754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E8A1321B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A65F7A2E80
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D97156C76;
	Thu, 16 Jan 2025 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QG9qy3G2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B64414;
	Thu, 16 Jan 2025 04:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737002601; cv=none; b=PgkgwZhB43YcRmsYSZTe/r+6ONf1Rwm8dz6murpAUxRodmggd7xmHa4R+sFBQnTINJuYBOZ8K8er7orzece9mxVVjKcgip3DlN6UpHP5R0isOjzCw8Rz8OTZht8Z5HKfoicDdZyM8JNKidNmaCzKUDvEmbEPkIJI7FAQsd4cmAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737002601; c=relaxed/simple;
	bh=re0jrUWb22m9wVcyDHNMZvdytL9xnLR8R6MQwhWR7x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhSu4OCSRuVXLYK3vdY/QWZ+kUuGwLhxNQ1zt9PdbisW7BQKAmoa+9wXyF46HAwptn9ybpK5bbb/crvIhc/F/Cd84LAjVbCwbe6kYqMBTSFQ++0SMAQV+rjQjjyWNfsF8QoVU/1wFngvI1uC5jZT98OeHrSAuZRc71G1/XELYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QG9qy3G2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-216395e151bso7690265ad.0;
        Wed, 15 Jan 2025 20:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737002598; x=1737607398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SHfADerOSbD2n5XWOFlbp5M9r6bMFwlpcEuA4NEOP8=;
        b=QG9qy3G2zVXW3GVCk6gVzwb/UZdB5r1BCXatQ4ggy+A1XY1y2y4K6DF9O35P2KZ2UD
         be8mddwOeiLxr8Y8H6uPuotZeXdl61BisHN88Ub0hXlpJROS/20xA296PrY+kPT3hA3x
         pU00J+SsCLB4SbFJKIg/IOVcrxC5ppQ8nILB231m2yWOXFh6r6tIWUnRnkMWRvFm8QXX
         wBOjNSapWDQNBhnt6FRfNWJwpnQ6+mLDRLUiRZLrw5zhVtyKCn2kfn7LL1Het+Qj9F6T
         lDbvMEBCu/qDR49hHAc4Es4xzGdTI6SgZ3zVszC+TrBgIxPkYbx8onvIlT/VLyVAZLeE
         oRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737002598; x=1737607398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SHfADerOSbD2n5XWOFlbp5M9r6bMFwlpcEuA4NEOP8=;
        b=WlX5AkekJFmfrZ4/OC4xMk9BTs8AAiOYCDO8Qx8yB04Ug6ARFh/4+/bwo1qYN4RBRd
         Yy55lAprULCfVCvbmAze/+DWThFd2wvqS4np+B5C4WSMAnOqrjfDRfwCx2avfoNpMnMa
         jSqbcZlHLB5cNyNYTJFsBpX3zkSdIZePGnZxjaK1k1+ApeAot++a998tCIeN4sBDiGK1
         DeUjUVq7W8Cx4mrnFDEgXexi4bIM7B92jtbwl+tno32xqwxpg/fZVJXhuGoGqpRB/wu7
         E4PoUZ2dgEQA1W3rRSp6rQEFt38Stmv9pUEaBLIB7PysttytQRDEIUvch5qebYC/v8bm
         6Ugw==
X-Forwarded-Encrypted: i=1; AJvYcCUBOfnGxmgMeNj0fyw9etiZIalJye6FR5FJoVZmxcJzc8MCtyClQbU/FDrhW0kdxwQ5oGZfJSnyA5rEq3esZT4=@vger.kernel.org, AJvYcCVDiM18qX6rloX/QvMAhbRHixOAz2HRcmpIQgVtFp4QxkCRxn8vXLzTlq9bBvisv2oMqhfnn/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIW0l+OxTh/0kh9ncItwzU0pWYtcgjKu6I6EtNmlFBaQOG8BD
	ViWlPTTpjS+hX1IAOvuv3O/JXHpQMs1+v6F/vmOZm/lyC8n2HMwPSpl947xM
X-Gm-Gg: ASbGncvSuFVZ9Svrsmd/PpA84F+hzZxeKC3UHQdFKJBQap3wifHdcRfQwsPEgs+UteL
	ciu19wtNXfmBob6F5D++UFExX0T7NT7QPuXA46dDgHM5cXhMd83zc+nlFwaTops0/vl8yEBA7kH
	dyQsF1xndnv89YQ70sHZ/2M6bp28MFkAy1OXMU2MKfh3RTBPZmM5umEDz0x1M//kCEiz2iTo13w
	B1d7sdX602jJ5uoGtNGFJxTE9vSIMLgBT6SUct9edNrRooLqFAZGlz6Lq6YMoJnMHqwND9D+c1V
	V/Bn8Xm+KWJuA++YPFTUuUESfqAvJbbB
X-Google-Smtp-Source: AGHT+IF1zYWuvY6J11Gv/X0oddWEerWFkZm3r8Y53udA9sBWenUxWgEyVzqUXhp519omHjlOYKPMww==
X-Received: by 2002:a17:903:1d2:b0:21a:7e04:7021 with SMTP id d9443c01a7336-21bf0d1c68dmr84654725ad.24.1737002597672;
        Wed, 15 Jan 2025 20:43:17 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f217a60sm89161045ad.158.2025.01.15.20.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 20:43:17 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	rust-for-linux@vger.kernel.org,
	netdev@vger.kernel.org,
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
Subject: [PATCH v8 7/7] net: phy: qt2025: Wait until PHY becomes ready
Date: Thu, 16 Jan 2025 13:40:59 +0900
Message-ID: <20250116044100.80679-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116044100.80679-1-fujita.tomonori@gmail.com>
References: <20250116044100.80679-1-fujita.tomonori@gmail.com>
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
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/phy/qt2025.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/qt2025.rs b/drivers/net/phy/qt2025.rs
index 1ab065798175..f642831519ca 100644
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


