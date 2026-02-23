Return-Path: <netdev+bounces-260230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJcfKFjSnGkJLAQAu9opvQ
	(envelope-from <netdev+bounces-260230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038D17E2B4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFAE53236CE1
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3E37D111;
	Mon, 23 Feb 2026 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo4edKX+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3461E37A4AF
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884309; cv=none; b=RO8QbEpLcxe6Wbc0qaH/nklKi/p+kZRnJ/jVTzTb3EKbX9zI1T6TzdQph5To55JWVhr+Gvhp3z1bXygeXs/dIDypJVSgOUIgxLqNaQyHZYYr/3IgQwKlb6BUAIaEOjtpMYbeVrvDh6+74n0Kx82veunqYcipAMTUQfpBjcxtDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884309; c=relaxed/simple;
	bh=DLo8ybjKAeliYnp5FSPsB19NqPjD3Xu29SYo+c/oWr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNPxCU14qeY7ywVcYlEDwiNps41jbkps2mUTH6QvPMBMajNVCZCtjpwf56GCJnSpNO+sku/AtL7rfMtMUe3wChE3DYa42KiwnIdSEFzuu+zs9VBihfecv45GIjrjnJCR71VX8H3kaq+JhRIF6Z7KMzn8us0gOyd1lFkmv6jZWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo4edKX+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so6511715a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771884307; x=1772489107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqhn3ZOG/BZpB/hKPwpYI1TGTRMCqv7M1e3G0fpG16Q=;
        b=mo4edKX+xhX4FCeFSP+BjzVlzepc3vkeBnX3N3XPn65rdfIR0GXu04JMDkiUNe2bp8
         H0usNhBDT3fEWTcFz52eWPEOVfbVLGFawiYjPP2spIYvsjXVKdW+HZkkaN46SwC9Xn6x
         WAYf4QKpHkdaTxGM7eZPmVsrV0N+n6PfhdhDdZgaQH8IOdLso6JPKrfD3Cvy846CEMCg
         Kknmvlmj6T0GA6a3sr6zu+26lRjKAJ6xRqV2B0swzWq/W8zJPAbiNFdsvW8+fbTL6Vyv
         ez6LABtN0E7jkBerSaOSPPoNEDD0EFzXMjzpgUyTAd2dbiVYct0AVZM82TT+BAPbdoKH
         9Owg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771884307; x=1772489107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yqhn3ZOG/BZpB/hKPwpYI1TGTRMCqv7M1e3G0fpG16Q=;
        b=Fo5HW7E6HVYAV0acl1vuj3GkhN+4GnXqTI+YSkXWZUi4J2EK3hi5j06kS1GzGUWXVr
         ghTrsJNgbfx5MXkdGT2lPMoEt0E/y26KE9l3+gYQ+aEzw21aIeLriut+fI+KlUelcKfF
         bTAeBK5H9kTFJaxCBIMhV4knSYxDVZV5juSAbx0z6p9SsoP2Oh5xoa/UvGj8XDRJ2LKB
         k8NfOY7fLUtNRcDdnId+74E5uCCGeEQaybLbusAYZS6JK7Ib47BiAhJAriH8XMTefB1h
         I5P19Dh4soZw8RfwCxvQ9/DYAWK1n98/3UUmg6DLtojNGWFNv4UD4oHuU97rxAVu1ZUd
         nsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOTuD7y3vLLfMPgiooB8wl6c5QmuqGRO7vMOkS5cd64Lw+s6Bg7NQPiGTAurz7YV9/PlXUdS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXGVgvEYoQ/ztSX2n003fplIhzVUVnF/1BIZsWZejrUxHbbwj
	4+LKBSwkgAEmeRr+SFWO/HPLB1CknM5XxzmuZccDccx4tN/X6bb2mBLo
X-Gm-Gg: AZuq6aJoMmx7ZZHdeGjt/nL0Y8SBg+VlT/niOnRVHelccuw8JxdxucInii1w7wqvnHI
	PuArTVasVl+X68FuTZ/4IXvtd4aaiLsEq8NbQy2+M81+nm3HPD6+fgNe9y8y9pLX3TOjYUKH5q1
	aNDE3UvHags7hReu0qA0k8xsnH0Vblg5CibfHL/RINARhLwF287+gclC0AdFM7Fr2cZ6m4zHb/h
	3KI96GIc9vnbj9iYYcktIX+OYuTRhogxg48/vA+nyiDziz8pCoZeqoXSd84qa+meQmQKF8yKUWL
	gJqyTJ8WxcGArdFNQrLb+KWmc3fzz5UhB1eOguI6YCQkRmWTlkyxWEUACk+iVGqN2K2xce454ZT
	VmMTg4niUf0a3+KzXk1Fpy1WXGAIk1qnxaakkWJygOsBbmGIgSqR3hQ8KyoiDXIKq8hDWzkOuhm
	kFcF5FEeuBuNP8BG78M5tzRkK0O1IISFxigochImmMXhed24GhE4pNyn8H6vbVivquayUzA3mZy
	rZ56SaVw8wjLp6KKl2iZv5SsbzRkF9CfisOt+cQj86BvxAwYt2wtSIKQHEy2RceKvUMFJo=
X-Received: by 2002:a17:906:c153:b0:b90:bc06:2abf with SMTP id a640c23a62f3a-b90bc063f00mr168485366b.4.1771884306385;
        Mon, 23 Feb 2026 14:05:06 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (230.86.12.34.bc.googleusercontent.com. [34.12.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084f191b9sm359394666b.67.2026.02.23.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 14:05:06 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Trevor Gross <tmgross@umich.edu>,
	Russell King <linux@armlinux.org.uk>,
	Miguel Ojeda <ojeda@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next 2/2] net: phy: add Rust reference driver for ET1011C
Date: Mon, 23 Feb 2026 22:05:02 +0000
Message-ID: <20260223220504.2102-4-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223220504.2102-1-iprintercanon@gmail.com>
References: <20260223220504.2102-1-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[umich.edu,armlinux.org.uk,kernel.org,davemloft.net,redhat.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4038D17E2B4
X-Rspamd-Action: no action

Add a Rust implementation of the LSI ET1011C PHY driver, equivalent
to the existing C driver in drivers/net/phy/et1011c.c. The driver
implements config_aneg and read_status callbacks using the Rust PHY
abstraction.

The Rust driver can be selected via the ET1011C_RUST_PHY Kconfig
option, following the same pattern as AX88796B_RUST_PHY.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/phy/Kconfig         |  9 +++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 70 +++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7b73332a13d9..5271898a38f7 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -254,6 +254,15 @@ config LSI_ET1011C_PHY
 	help
 	  Supports the LSI ET1011C PHY.
 
+config ET1011C_RUST_PHY
+	bool "Rust reference driver for LSI ET1011C PHY"
+	depends on RUST_PHYLIB_ABSTRACTIONS && LSI_ET1011C_PHY
+	help
+	  Uses the Rust reference driver for LSI ET1011C PHY
+	  (et1011c_rust.ko). The features and behavior are
+	  equivalent to the C driver. Selecting this option builds
+	  the Rust version instead of the C version.
+
 config MARVELL_PHY
 	tristate "Marvell Alaska PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 3a34917adea7..491469457a67 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -62,7 +62,11 @@ obj-$(CONFIG_DP83TG720_PHY)	+= dp83tg720.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed_phy.o
 obj-$(CONFIG_ICPLUS_PHY)	+= icplus.o
 obj-$(CONFIG_INTEL_XWAY_PHY)	+= intel-xway.o
-obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
+ifdef CONFIG_ET1011C_RUST_PHY
+  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c_rust.o
+else
+  obj-$(CONFIG_LSI_ET1011C_PHY)	+= et1011c.o
+endif
 obj-$(CONFIG_LXT_PHY)		+= lxt.o
 obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
diff --git a/drivers/net/phy/et1011c_rust.rs b/drivers/net/phy/et1011c_rust.rs
new file mode 100644
index 000000000000..57aa50caca47
--- /dev/null
+++ b/drivers/net/phy/et1011c_rust.rs
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (C) 2026 Artem Lytkin <iprintercanon@gmail.com>
+
+//! Rust LSI ET1011C PHY driver
+//!
+//! C version of this driver: [`drivers/net/phy/et1011c.c`](./et1011c.c)
+
+use kernel::{
+    net::phy::{self, reg::C22, DeviceId, Driver},
+    prelude::*,
+    uapi,
+};
+
+kernel::module_phy_driver! {
+    drivers: [PhyET1011C],
+    device_table: [
+        DeviceId::new_with_driver::<PhyET1011C>()
+    ],
+    name: "rust_et1011c_phy",
+    authors: ["Artem Lytkin <iprintercanon@gmail.com>"],
+    description: "Rust LSI ET1011C PHY driver",
+    license: "GPL",
+}
+
+const ET1011C_STATUS_REG: C22 = C22::vendor_specific::<0x1A>();
+const ET1011C_CONFIG_REG: C22 = C22::vendor_specific::<0x16>();
+
+const ET1011C_SPEED_MASK: u16 = 0x0300;
+const ET1011C_GIGABIT_SPEED: u16 = 0x0200;
+const ET1011C_TX_FIFO_MASK: u16 = 0x3000;
+const ET1011C_TX_FIFO_DEPTH_16: u16 = 0x1000;
+const ET1011C_GMII_INTERFACE: u16 = 0x0002;
+const ET1011C_SYS_CLK_EN: u16 = 0x0010;
+
+const BMCR_FULLDPLX: u16 = uapi::BMCR_FULLDPLX as u16;
+const BMCR_SPEED100: u16 = uapi::BMCR_SPEED100 as u16;
+const BMCR_SPEED1000: u16 = uapi::BMCR_SPEED1000 as u16;
+const BMCR_ANENABLE: u16 = uapi::BMCR_ANENABLE as u16;
+const BMCR_RESET: u16 = uapi::BMCR_RESET as u16;
+
+struct PhyET1011C;
+
+#[vtable]
+impl Driver for PhyET1011C {
+    const NAME: &'static CStr = c"ET1011C";
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x0282f014);
+
+    fn config_aneg(dev: &mut phy::Device) -> Result {
+        let ctl = dev.read(C22::BMCR)?;
+        let ctl = ctl & !(BMCR_FULLDPLX | BMCR_SPEED100 | BMCR_SPEED1000 | BMCR_ANENABLE);
+        dev.write(C22::BMCR, ctl | BMCR_RESET)?;
+        dev.genphy_config_aneg()
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        dev.genphy_read_status::<C22>()?;
+
+        let val = dev.read(ET1011C_STATUS_REG)?;
+        if (val & ET1011C_SPEED_MASK) == ET1011C_GIGABIT_SPEED {
+            let cfg = dev.read(ET1011C_CONFIG_REG)?;
+            let cfg = cfg & !ET1011C_TX_FIFO_MASK;
+            dev.write(
+                ET1011C_CONFIG_REG,
+                cfg | ET1011C_GMII_INTERFACE | ET1011C_SYS_CLK_EN | ET1011C_TX_FIFO_DEPTH_16,
+            )?;
+        }
+
+        Ok(0)
+    }
+}
-- 
2.43.0


