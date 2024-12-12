Return-Path: <netdev+bounces-151375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A49EE74B
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36CD1646AA
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DB211A1B;
	Thu, 12 Dec 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGHRQ0Nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747331EEE6;
	Thu, 12 Dec 2024 13:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734008507; cv=none; b=F01DTXIoLA0QBQ5XftU8d/jmV0ghrKubKw+T2n7xH7fZ7RhPNqHbxtplUdlP0dxppPKe9RHX4RiGS6elawXy3LyN2xnuNAU2w0zurmipu0aQyF3XIAJd9+T+Fde60Kifmluqzc98thqdhABcRQ6u2pvd18Dbg/M4BmwybKGYnvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734008507; c=relaxed/simple;
	bh=Pn+HV+sRlLumfNM4ihppFPs/L/KEiADaCK8PIzifXw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpMKiWUc8nMXd5TBIZq0Turc8iBXALDYhgX7qp6mq2PZG+/Y1u8NKp2BxtFFgz+Ws/YhGu+dqfw0WhrkknMB4XgdvF4lwocFYyMV7TgVkpOj8ycM1RBYEPZYYIVGFt4Z2Dedbxg7idTbXTsscws7fkuuIo6AkbM+v0DD11o/Fwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGHRQ0Nn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-728f1525565so665714b3a.1;
        Thu, 12 Dec 2024 05:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734008505; x=1734613305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTZmgfgObbQLBSvoK4M5Ynsni5KYn/weRAsN8CypaP0=;
        b=HGHRQ0Nn/0mJUAVfUPZTMPJd/nnRRP+jh3tXcQ9YjVMLPxutqMp+ph7tCugWzvPDmk
         4Jyc2eDbJp1BXxk06iGdHjNg0YSm6e/irU/BdZsdvPhsDD3IZDwDB1RhlNsEbDT4un7n
         /aUWqpgrh38SdZLClNdmXO3aeVIiytcT/tPrphDAhVu/eSVcshqkst31CMsQqeJtTX7D
         9Mozz6NzIRpJDCcI9/dfN5C98RlHDduJFm8quCu80VmiD42twEt8K1htBKWE2+cPNn6f
         vA5jQkjJadJq7FWSaYshW9LCt5+JdRiqhAjpUVoayPwRV/XICn6Lvt7NZt7nDnfwYD3F
         k0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734008505; x=1734613305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTZmgfgObbQLBSvoK4M5Ynsni5KYn/weRAsN8CypaP0=;
        b=v7wVj0tVfQJu4eSsV3zaCvY/riZrnTvqnpRPYOsOdUjC25YGJdSqcW26HG1mUZDDRy
         xIH6sAMUgQCa739HJNvq3K9E0Qftu+EW2axpH39e4X+8d74lWqK84HtKYGhNnHfGUCxQ
         sevMzC/Y6ZMhlJPppSbzQ+HDS6sZZEKAv3ZIjqUSoe0v/8U5cqsSlI1RlOsce+aWl8DH
         1YTUtr65PGM5RXShHCeDNOxB73C03bA4jCk4HGV4KmATq5rH+wGreKTFML3pKztFqhQh
         YHCQvc10a1QXnEMx9bT0o52/5G0fBTA/rY0VyH33vCY+ACFR8NnqY/xLbwdGzR0GZtWI
         L79A==
X-Forwarded-Encrypted: i=1; AJvYcCUa2bu9TUC3z/R3xpnv/yXU/pRkIiqRKr+7gpNIUN69EMS2Q+eP4h7Uv2IpJKiGfwlUacxIQ4KWBRHiuHsShw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsyYtaQdh0ju3ecj8/3WoIicnEWlWlrpNrRGGPSn7F+Gepxudj
	N/F2cu6G5L0YWwMyb/Uqnbz0nf3/NIX9GI/PlQZttSnjqI7XwgnOFppjPNdx
X-Gm-Gg: ASbGncuIy3dRMKzLxkG8VSWRNaovHPemIP6xWbdUqj3ynOZ7s1SiMSJM2TYxO5KQ5Q3
	D34aD5nXM1B+yG5VglNZkFx868K9GzD9BwrO4EOJtqENpuRdM4wgYRbjP+nQgD/+G6SnJpwgWxi
	hrBAvtScqZr9HkuoOnBUFNLRK2OKHuwSY02pS4WBug+hCaV5pYWLqpFLIMQkPAbI2+UqSZmy1hW
	xfvKRXeFaXUckl3QKOvV9NtBtIuEZeRYoNsCQolbEC9ALFBRuwvYBrw/dUoejSZbQO1QMVny+YA
	GcujqYw/bNrzmithGPnJxZu3fmpK4g0=
X-Google-Smtp-Source: AGHT+IEMCWGjuoxGsheINT+mZjeEt7qQZNNo6pjSk2L/xFc76UOs0z0LX1SSC9EqafV6J0XSNzs4Jg==
X-Received: by 2002:a05:6a20:12c1:b0:1e0:e07f:2f01 with SMTP id adf61e73a8af0-1e1da9e211dmr362937637.0.1734008505404;
        Thu, 12 Dec 2024 05:01:45 -0800 (PST)
Received: from mew.. (p4007189-ipxg22601hodogaya.kanagawa.ocn.ne.jp. [180.53.81.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725d7cdb38fsm9176500b3a.110.2024.12.12.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:01:45 -0800 (PST)
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	rust-for-linux@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	tmgross@umich.edu,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com
Subject: [PATCH net v2] rust: net::phy fix module autoloading
Date: Thu, 12 Dec 2024 22:00:15 +0900
Message-ID: <20241212130015.238863-1-fujita.tomonori@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The alias symbol name was renamed. Adjust module_phy_driver macro to
create the proper symbol name to fix module autoloading.

Fixes: 054a9cd395a7 ("modpost: rename alias symbol for MODULE_DEVICE_TABLE()")
Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 rust/kernel/net/phy.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
index b89c681d97c0..2fbfb6a94c11 100644
--- a/rust/kernel/net/phy.rs
+++ b/rust/kernel/net/phy.rs
@@ -860,7 +860,7 @@ const fn as_int(&self) -> u32 {
 /// ];
 /// #[cfg(MODULE)]
 /// #[no_mangle]
-/// static __mod_mdio__phydev_device_table: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
+/// static __mod_device_table__mdio__phydev: [::kernel::bindings::mdio_device_id; 2] = _DEVICE_TABLE;
 /// ```
 #[macro_export]
 macro_rules! module_phy_driver {
@@ -883,7 +883,7 @@ macro_rules! module_phy_driver {
 
         #[cfg(MODULE)]
         #[no_mangle]
-        static __mod_mdio__phydev_device_table: [$crate::bindings::mdio_device_id;
+        static __mod_device_table__mdio__phydev: [$crate::bindings::mdio_device_id;
             $crate::module_phy_driver!(@count_devices $($dev),+) + 1] = _DEVICE_TABLE;
     };
 

base-commit: 51a00be6a0994da2ba6b4ace3b7a0d9373b4b25e
-- 
2.43.0


