Return-Path: <netdev+bounces-153601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1B9F8CA9
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F52B16C94A
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5C41C5CAD;
	Fri, 20 Dec 2024 06:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqkGFX5c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2AB1C5CA1;
	Fri, 20 Dec 2024 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675701; cv=none; b=k5RvVE+r1p1XJOUuJyY2Zj2glbMbmupWESrZvfFL/OB6ld3M5D5US+yplcHUeAEaCHLkM3WwWaRogjQ3A5FqezuxQkjXZ9rgD5qiliW2prvDzr5v8JuTlS4o1MCJIbwF6DyXN2A3oyizhM4DTqQ+XnZ6TbnyFEZc+7puFad3/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675701; c=relaxed/simple;
	bh=re0jrUWb22m9wVcyDHNMZvdytL9xnLR8R6MQwhWR7x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3KkrpKXhzaAug9NAj3SN1kN6ra3brPIYG2HRUKwDMUSDQLtCTO3D6VASd36YkOWDsptVedXnCKee1gjn3XK9rHvmwG9qE9VEcnmUR6Rbfda7+tQUOvYSzJ2uaUumWXUrXB82DzgAw8Ko2c7tx1cQYj0O7q6igPHEhnwFmJJYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqkGFX5c; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-725f4025e25so1302670b3a.1;
        Thu, 19 Dec 2024 22:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734675699; x=1735280499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SHfADerOSbD2n5XWOFlbp5M9r6bMFwlpcEuA4NEOP8=;
        b=DqkGFX5ch64oLsxtLl1V6a8dqf8m3pY/+xB8ZzGc8PZkSWxImj1qLnBj7e43m6F5hV
         YyOSdF4TPYn1GXGWfyeYAbqy+QKIb3EfMDICwQRvD2gtvpGtF8T/IImMBbstPxb0VhuT
         mgHWgXwgm/QWgiEjRp/lE/I6ymKgpygInqjC/Fr2Ai5wCkXqS48AE1HoWXzaYcFmD1S7
         3gsFji7syOilKqYR/mo2RVW2ahthN2vDY1MaxluNsQpQzKG076GJDpFEDWBrz6tKvEtC
         08hXPVROMaRUT88+u4Lu8AwdsQcBR0TfNGNuRoQUg068jAJLMwuj4Shk5OVy6RcdUNnL
         eLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734675699; x=1735280499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SHfADerOSbD2n5XWOFlbp5M9r6bMFwlpcEuA4NEOP8=;
        b=j9tYrjH2VFno8b4adCeJo9l0FDZJIHMQPeQyrNxl83Tml/4fz5soY+xO6mechBgF3h
         NUquoTjf5kyy/MTd3sNjzttnA/cKjIYI/uo5K7r8Yd5hxKQbyK7SAcLt0HbyPK9ErTVT
         LQbJ7w32KRgErUK9re7zQgIKmzS9rzfOGeHBLkK6BF7NHuc4jqAKZJv10W2yhFZhv96J
         GwkT3pQ1Kfp6y6stoDxlU5VVdvRAm86XcUDt3zZTkuhxCnrNsOkoLBK5FVWL2DlGs5aZ
         uvvL9owXnf6ZZV96toZ5VfhAHPuvw9hZ75dfjvv7lFTLs7kL/BecZ+peb0d905Wnu49x
         TxBA==
X-Forwarded-Encrypted: i=1; AJvYcCW9EdbDZx6flM2VOg6zKWSZf1U0jAzqrmEqGrvk9Mv2SO77NL3heTabTmUZR/UaIaszUV/S72i5s/mgQMTYrQ4=@vger.kernel.org, AJvYcCXJ5OBgDVIrr+baBscIefhtvgda57adEmoJPi9uruiRpHk8rTtwu818MWXQHVp1kE7OvveJj+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTg9iqgvj3M1V90wf00efIZZkMW5bl9rHTzggw9V013PTsFPg
	OVIispK98C6y/bOPhrwAZZcKhcoa7Dkt3hTXy1SMKzn6nUWuedWzaW8Pg5jn
X-Gm-Gg: ASbGncvSPVqSMxf9GFgNCP5d8KsVGqhtKCUSIUvEthEE4OAst6Jvt4WMWJFRsPwKJdx
	rtg0q4oSCCGmLfVI+mINpIkMa0wSVQJm4OdrtFWKbSCUkyhcfPtChGQlQMQIjSqQK8WxtzHL9jo
	uEKWetWWuAOXSzOVN+2VY3qhcj8kQkU1C6u0+1vqos0X+LvNywz7YHmNuMBMjjBuDOJdrY4QazA
	5WdU5NTT/Pf/0iZ3nPEGnoWEjLK4FQ6bz3LuddWR1vuJ4VkgGuReinNsJdxXyBuFdy7MIJSB2mb
	nbQAgO/UTqN4rjI9Lg==
X-Google-Smtp-Source: AGHT+IHCrBFAgZKCOGPCuaEFQVdtzq3kyFL+Q+NAjhWIFcZD8J2LEWmL+MO1sGwmDwBk+NqwxMNvGw==
X-Received: by 2002:a05:6a00:1947:b0:725:456e:76e with SMTP id d2e1a72fcca58-72abdd8caf2mr2370104b3a.6.1734675698970;
        Thu, 19 Dec 2024 22:21:38 -0800 (PST)
Received: from snail23.. (p7659208-ipoefx.ipoe.ocn.ne.jp. [221.188.16.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b1ce01d3sm2158548a12.23.2024.12.19.22.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 22:21:38 -0800 (PST)
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
Subject: [PATCH v7 7/7] net: phy: qt2025: Wait until PHY becomes ready
Date: Fri, 20 Dec 2024 15:18:53 +0900
Message-ID: <20241220061853.2782878-8-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
References: <20241220061853.2782878-1-fujita.tomonori@gmail.com>
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


