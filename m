Return-Path: <netdev+bounces-260592-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB8uK1rYnWk0SQQAu9opvQ
	(envelope-from <netdev+bounces-260592-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335A18A298
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7C12326462B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544793AA19D;
	Tue, 24 Feb 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8NW2Co9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6863A9629
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771951772; cv=none; b=b5Q/WKra7FlKgnrx0JlgrEGjyRLgw33Vqjp7gE27YZuynyLg0+S6etU9xjqU7BAz1yp8s7ZGfWn3P9T2ycjmr/RHI0yX/gtkejDsjTsB3rJ93S36RPIYNOFqV6m/0iKClWydgTd2j5VzqHZ51s4xLQLNaA6PW9UOZ68pfIbvJgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771951772; c=relaxed/simple;
	bh=T0WkFt8h0ycy6bABF+LGvuxazF7V3cZ+XMp6YYvk+GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nyylv+z9kx8Itc+fLX2No6b89xFAP2jcUEbJqhWBYnYCNUOQjheZ0pVCrLE7v30mP0eQ26MtiNcB2BsC222x8IhzsK6UV7sCS4605knT0ft6vRmAzXRg/jUOYFEDEtdSyROFqExBWFyENHLbWSZJ+i4CRAkpcBJTpvSGMe+wkyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8NW2Co9; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f8d80faebso964273366b.1
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771951769; x=1772556569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abZkGQJq5HsIhHOb3bxYhOqt23SPwyqxtVKq5uoT1Xk=;
        b=G8NW2Co9ljrKUFzNc+xdLXgxwBIXEHgH7InbVctufxo5XCbYre0s+5sgIM25YUNgjg
         RowE11Awaiwzx4XZMZiFQ7CnTXPzN8M/Me+dyuvLXZGkZ5ouIBEeH93ZVU9bBqN0wf6m
         z9Sg9ff+jkDo4NOwqzosqYzsDmLfPCBh4nMYUHsNrZbBcjepAG7UhTWrN21tTKqWJSzw
         rtMFzQStdXIYON0Im3HqQPLzcn2dsupRrDElFJras4as3dK9MMD9EvKG+Q0J7uKxv4v7
         R8KhXTRiucxJm5OOAsemcVg/1OugGaciaMZ4n/2loFBZ8c6CJyxtYSt+vBLVuqDGev6J
         xfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771951769; x=1772556569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=abZkGQJq5HsIhHOb3bxYhOqt23SPwyqxtVKq5uoT1Xk=;
        b=qFMDkPpvgTX3ey540Jce2s/7wkE2Kp/+qoj8XACunZfnS2Gtqx32ExOU00Kh090TDN
         /v4XI7Lzg6BHeZtGb67YOrb8oKmEFp0ndMAi6E339wPjl4zp3+xnd0I7e1JZ8nBlsNv3
         5qBOpvYsGgQ4dxfbb+g8Y93/4vvj2RpI7uXGQMXFylBtHBu3RmM4A86vCGGhlbgxZFRB
         W+JyDqx94hI/VFwSc9c6AJaOp+Z4EpK2RUXMERtGqNYQTvjfY1hjC8dIHRqqwtyCvXJ/
         D12PN/HNhjrc8Reb4xuu2oJ3UDFtEDyIZcvyyc8qTLPwZiAieE0xXGj//oYLEwO8wXhy
         aX/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVDY/sg4WFioVuDuVaopQ5RwXjUMCiXABoU4uLT/Fc7rVfq9Egb+K90F73PLWYSpeioqhEYmlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Ry/Zs930XpFrmcor2plgtteVzhxsylplatecjjt/uZtNg6WX
	Y3aT314U/afEoLUuC09xa02vdS0/yUbaqb7MZKIwkT0NTg/uXURhtkeO
X-Gm-Gg: ATEYQzza+hHEuKnpAsYhskGhcwzJcWE0nzrmHTUV/8va5SDP2k2Pyp5glSu+CsUExFe
	5SELzdH42OnWexCHHwMZUJCEC0wYLbFfTKvEqiXyYYISPQ0FI6TaqVP0Cc2IP98hhPo9tYU9BCN
	WSPYdOXZsg5Wxs3VOMzN+r64O2gCxKMnb2N52HVwnOD89rpIQUkm6/ijKWeuZcdetg1oXlrg1n6
	7zKaNmC2I2E4WmM0vzl6QOx2gzBzDxwn0kTnoB+mViwrvJdaqYpzmiyG4Q35mxfIIIH7+f2tBHZ
	qF7eYZNJ7Qxw3hELv7FTxfgTR4NFAGB9z8X6P3B/Wltk1ya6+nrk82+v5STrlaZ1rzj2asYrfdp
	ddvYiRtqJXsqhn+q00kdMp4jPHlKdMFjTTKlMg9WPvrEMv7Y0HZZJjwr+YxXP6TmNxewduyDoPU
	YE2a7Sfrki0V9BZqfv2RMZq2QfN/88qi+CihH16wDbnVv3NsV0HMVt1W/Y+Zp0HScK+abiPX7QH
	8GAPCLXx3QiI+kzE7+sWtC7jQnBnLefFeNNR21CJMiXF/xdjv1hbKwM1Z07AfRTjXtt
X-Received: by 2002:a17:907:94d1:b0:b87:75c:3660 with SMTP id a640c23a62f3a-b933ce0e135mr37900166b.28.1771951768862;
        Tue, 24 Feb 2026 08:49:28 -0800 (PST)
Received: from cs-874966990260-default.europe-west4-a.c.i2f7e30109524dc12-tp.internal (30.49.91.34.bc.googleusercontent.com. [34.91.49.30])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9a077asm3771023a12.4.2026.02.24.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:49:28 -0800 (PST)
From: Artem Lytkin <iprintercanon@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Lytkin <iprintercanon@gmail.com>
Subject: [PATCH net-next v3 2/2] net: phy: add Rust reference driver for ET1011C
Date: Tue, 24 Feb 2026 16:49:26 +0000
Message-ID: <20260224164926.1760-3-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260224164926.1760-1-iprintercanon@gmail.com>
References: <20260224043211.1747-1-iprintercanon@gmail.com>
 <20260224164926.1760-1-iprintercanon@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-260592-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,umich.edu];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iprintercanon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1335A18A298
X-Rspamd-Action: no action

Add a Rust reference driver for the LSI ET1011C PHY, following the
pattern established by the existing Rust Asix PHY driver
(ax88796b_rust.rs).

Unlike the C driver which uses a custom config_aneg that manually
clears BMCR bits and writes BMCR_RESET without polling, this driver
uses the soft_reset callback with genphy_soft_reset(). This properly
polls the self-clearing BMCR_RESET bit and handles both autoneg and
forced mode, following current best practices.

The read_status callback detects speed changes and reconfigures the
GMII interface and TX FIFO when switching to gigabit, matching the C
driver's functionality.

Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>
---
 drivers/net/phy/Kconfig         |  9 +++++
 drivers/net/phy/Makefile        |  6 ++-
 drivers/net/phy/et1011c_rust.rs | 69 +++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/et1011c_rust.rs

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7b73332a13d9..41abf13662e6 100644
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
+	  (et1011c_rust.ko). The features are equivalent.
+	  It supports the LSI ET1011C PHY. If unsure,
+	  say N.
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
index 000000000000..93dbf9586da3
--- /dev/null
+++ b/drivers/net/phy/et1011c_rust.rs
@@ -0,0 +1,69 @@
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
+// Vendor-specific registers
+const ET1011C_STATUS_REG: C22 = C22::vendor_specific::<0x1A>();
+const ET1011C_CONFIG_REG: C22 = C22::vendor_specific::<0x16>();
+
+// ET1011C status register fields
+const ET1011C_SPEED_MASK: u16 = 0x0300;
+const ET1011C_GIGABIT_SPEED: u16 = 0x0200;
+
+// ET1011C config register fields
+const ET1011C_TX_FIFO_MASK: u16 = 0x3000;
+const ET1011C_TX_FIFO_DEPTH_16: u16 = 0x1000;
+const ET1011C_GMII_INTERFACE: u16 = 0x0002;
+const ET1011C_SYS_CLK_EN: u16 = 0x0010;
+
+struct PhyET1011C;
+
+#[vtable]
+impl Driver for PhyET1011C {
+    const NAME: &'static CStr = c"ET1011C";
+    const PHY_DEVICE_ID: DeviceId = DeviceId::new_with_model_mask(0x0282f014);
+
+    fn soft_reset(dev: &mut phy::Device) -> Result {
+        dev.genphy_soft_reset()
+    }
+
+    fn read_status(dev: &mut phy::Device) -> Result<u16> {
+        let old_speed = dev.speed();
+        dev.genphy_read_status::<C22>()?;
+
+        if old_speed != dev.speed() {
+            let val = dev.read(ET1011C_STATUS_REG)?;
+            if (val & ET1011C_SPEED_MASK) == ET1011C_GIGABIT_SPEED {
+                let cfg = dev.read(ET1011C_CONFIG_REG)?;
+                let cfg = cfg & !ET1011C_TX_FIFO_MASK;
+                dev.write(
+                    ET1011C_CONFIG_REG,
+                    cfg | ET1011C_GMII_INTERFACE
+                        | ET1011C_SYS_CLK_EN
+                        | ET1011C_TX_FIFO_DEPTH_16,
+                )?;
+            }
+        }
+
+        Ok(0)
+    }
+}
-- 
2.43.0


