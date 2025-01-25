Return-Path: <netdev+bounces-160922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE28EA1C2C1
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 11:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AC316B279
	for <lists+netdev@lfdr.de>; Sat, 25 Jan 2025 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26D20A5C2;
	Sat, 25 Jan 2025 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyHzqdyx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9217207DFD;
	Sat, 25 Jan 2025 10:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737800460; cv=none; b=SmB5x3VY2tPzmFznOzSlj/FZrPJsyNW4PyVuS9uvpQgyrqECozVqcpJnf1TsOz3t2EMC8YcXKG8t64ejqgK/0AbdI0STGVdPL2OzAF9PdGuTx6DwnjgactOHXNqZ2uxe70Bx3BJRAFU06OOgvjEKfZkx3KNWfyG+2Wil78EMtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737800460; c=relaxed/simple;
	bh=dtsPSe/89K1qHsAPwEqFVf1AQJ3aUTY/1OyPXFve/GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5+UlwrWTlLSl7bgc5Jccxx4YkkjcZX6XFPdDXBCUtgf4HiAlYqBTwWYzw+BlYU7lQ8/p36gikAGkzMr672xegpHk3Sb5ntp4J2biBGww8pteWqoE2xdSLwjn3Tbk008oOYcvEl5tXDsUDgjk6Wm86h6bE0cTpRVjr5DF2G35CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyHzqdyx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21bc1512a63so59034455ad.1;
        Sat, 25 Jan 2025 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737800458; x=1738405258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdEH3sWOd96J7GmaCg3rI9cjGuBtz1cihBXbvMrlTZ8=;
        b=dyHzqdyxX8fzTmOegdLma4+X80IV9IkeObLZL/tfryqzMgXfCfCkqKfnO1TMRLhnjR
         s5uis2T2VZcYGQHjReoVGAIvmbYe3jBFUPCHuJfBUn8ZbzrrXQs2oiYqNtNj8PSsSMfr
         /LB9iILr9K1kG70uM0g0CHShYY2mZ44nXzeLl4kCI2WXrlEiiGS8VDkQccVctj4b6B+7
         4RvSAXW6JgWYoWOSDZiCot4pWcbq5Elj+YnJJSeh2kcHMvU3EWDdmrQF11VcPHTPmJ40
         LFgxTKsWmPBUj49cfsvUa8gYl4kig/cDchOFhkdTzQX6Hy6mBKHi5/Dbat9V39WumpL5
         JDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737800458; x=1738405258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdEH3sWOd96J7GmaCg3rI9cjGuBtz1cihBXbvMrlTZ8=;
        b=je++zdp79gv08k0OeGvtebfq3UrQAuBR3tWzJwPQ5Xru0ZMVJkAFJSkeDsNrtP/h9g
         hdIyEfEFLTd4FhgFkLYX30ph1xGAlcUGCPMf6jaZL/zyPVRuOpZioTwC7NhBl997pRXM
         yruMbvEpl0PU9gy8Ly72sSSrQivpAyt5/SUKmURbGJyTFg8vD83UkqmwEqv+6B8IJb+w
         uWaENqKlVkeK1OrG12KKKSCSAOljOXu70LqIG+iR2n6d3Tl5s5ggH+Iz20iPGVDR1sWh
         GelWKeuu0w0DNTsX8qMW8u4VpQJ/ALnVS8LqwcNP8I0xWIP+nfd7A5QVoaVg5OUfnzD8
         II9g==
X-Forwarded-Encrypted: i=1; AJvYcCWPNdWfW0JoasNGSzH6CYrFpgpF0ExDLcO8d1YxFO39RD+PGmAWBhbqlWMaqY2RzEay8m+rVYg=@vger.kernel.org, AJvYcCXt5P50yIHHj4mwhGDQnd8rPu9xdGtBOEKZ2WSOF9LG6lBE4R6RvfJ3B9SmW/NIIs4h8HwHOq5/8Wtcl9AEmaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxW7h35cHjYNomu0iOFl6R/G4LUBpgQGFS105R0JiK6F0/x2/
	HRX3Ihxs++lf/6E29zjzpYrBlUauSdEmyfD+o2ZELJtJndbDYL6DxINeRluM
X-Gm-Gg: ASbGnculVzXf+oU7wNjJrsVKhfwBifBhNxEOIH24OwjRyFbE9zzOG8oyU1MGIb5tJ69
	CPrtPO6DItfV96mUrpMPij89Carx1V7Yy1gHwFSfNZvjV0hmwff0SCLEal7WhCwtRlFVG9PwwjV
	oWlXi9NA+e2DdUkDRDgZHmgpO3Z4iGnk2SgI+VJLnqOyFDGEHJII7gFDqP7HVUOEYet6xxKnz6b
	ffv9Jb0SsYv59cr0EYJBB3v6NYkzhChjjCem4WrJEcpIypLQzDgcW8zDEhuLE0gAiDSGa9Zcd5i
	iUoFdoOBZUIbN1lJQAmGyWHHgPxwTQQAR/6ICQUgMyh5xlwAeN1OtEut
X-Google-Smtp-Source: AGHT+IG3ByhHT2uvNChQG8MEVjIDl1+asqjbY9Lbh9elMS6FdR1fy14OY5OjIprl1M3G87M1OfTS4g==
X-Received: by 2002:a17:902:ec90:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-21c3553b527mr458147165ad.9.1737800457820;
        Sat, 25 Jan 2025 02:20:57 -0800 (PST)
Received: from mew.. (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424f344sm29461155ad.232.2025.01.25.02.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 02:20:57 -0800 (PST)
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
	tgunders@redhat.com
Subject: [PATCH v9 8/8] net: phy: qt2025: Wait until PHY becomes ready
Date: Sat, 25 Jan 2025 19:18:53 +0900
Message-ID: <20250125101854.112261-9-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250125101854.112261-1-fujita.tomonori@gmail.com>
References: <20250125101854.112261-1-fujita.tomonori@gmail.com>
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
index 1ab065798175..b6a63eaa6ef5 100644
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
+            Delta::from_secs(3),
+        )?;
+
         Ok(())
     }
 
-- 
2.43.0


