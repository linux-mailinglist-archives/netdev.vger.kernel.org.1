Return-Path: <netdev+bounces-266217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDwhEvU2sGkKhQIAu9opvQ
	(envelope-from <netdev+bounces-266217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:21:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06525253386
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DEFF303A3F5
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1E6313277;
	Tue, 10 Mar 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWh0omad"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841FC30FC06
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155988; cv=none; b=QHRCf1Bupf5BxQGSL/KZbRaxATtIEcoQnVnKiehbbica+kpGz/dPJFh7aWU8/YlfkKwBdTGJtsbB1O87TTxrCtsS5XXpEX0P3JLxYWd7Vqm6x0pKY+mmg1Vkgo7rLKh3gXPCFPDjm8uaCLQPOjIrwEXRXRJhy8e5HKzYkIxiBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155988; c=relaxed/simple;
	bh=Yn4rjllrYHk/ctlmLPVwWjts5+Uwqds4FvaaiUMOC/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xpe65p20Jnmkm4jz5de7XmOzAUSVjBwPN0rbfya0SglRUaUPQ70aLA6p7y9aa6yD8zFfdljYKGmKJHHIWkgp4FEP2E4A5JJ2jJj/gnqIAE/wjVFQR3cmq7FtNjxdOn9aawYAWTTzh5Hxk4QcdFpTYBJvFWA0lGtJMxcLWWLxQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWh0omad; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3598cab697eso6076570a91.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 08:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773155986; x=1773760786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tbEPBXLOW6W4Gfj+URzMtQVIzs7pEYzk3RvSx2kF+M=;
        b=MWh0omadQaDkZEzZkUwMCqVo98TdS/1ONqS5uQa0Xo6j2NaD82SiY5MW61vCZJJPXx
         NikzYetZomo5HetmP5/qiPFKhSzzAku/yCqzLzkQyNKHMbk6l8h53mpkoa5J/OAESrmq
         oASvKkdf78Xc/7vGTBJrDQissoqtgkddvIbb5tCCh6HbR7v48lkhhIKeu52m+nDQSs5v
         ZJYM9PjVq4gOShgtJcbGkRNDeg/8pSEI6RNjoq7Cmbve8HzhiiRvg5mbL4vRfNr8M4rl
         hx3GyNujBrHftHc7muHV0IqY54afmxZ73nEZQO/hdzpRhpQyY6EfPZAXWkU1ksTPwzHB
         b0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773155986; x=1773760786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tbEPBXLOW6W4Gfj+URzMtQVIzs7pEYzk3RvSx2kF+M=;
        b=PYj3/NN0LBfUedYB3/VSf643COoyNthiH0imqh3tSCu8TWA/5NdwmVEh2e8CvsZ4Yz
         J6h3mSuUIe/5ZMaoJhI5NHrOycdPK9rAdlS3Wbkn8HF6tYWintVbDgW979xJMJ+q1Uxt
         cRwIjrD/kgprmyTl0efR2gr6SJLtGKnlRd6SqQOppKCzs+KVWCRZl4BYiuFo53iIiKTs
         2Z2oekjmNzDQxnbvZiBZ5t1abXGDUanXgOZAdQdBTFPupJfUgIqvqjzrhRN+kOX+gpgN
         rjL12n4NwS5yHBZA05pElvL6t5EYU6FqFfFUOdO379Ha/yeOtRK1MN9MfIOULh4JA3uU
         dipw==
X-Forwarded-Encrypted: i=1; AJvYcCUMg+fzuRzmFGgbjSR3XXdMV4AWxo/MmkVL1lPAh7HSsUdCM4OIrv9PL/DUsUWck5gBwQJnAdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8FQlLnt3Ai+ocO3uiTHqfHdm3wqM6TvK0iomTqUKDwPoPZzCE
	7jFgHCLirfetpmkRf7FvgwplkCbm5d+wThFMWJf5e3F/MzcoEdQ8F/IY
X-Gm-Gg: ATEYQzzfEoRWsVHKnUVyl7yvQlWEaB0LzqOTUf7uK9pxOKLzrsKgs6zBWwA+u8jb9zZ
	EU8XhW+dcS+hEn4QGcI9RXmnhfQsUIaOLjNBMuC/oXofgUB4GCQXiWgvwa6hCYrlyP/O/2pkEfV
	E5aaNWeuf+iX5uLBMIx8ASWpwDzRu3FZMHt6h+QEa1/IkgOsbbzUC3BGv0m+2PNhyAioHZyOf4f
	4DxHuVJT7UNYmCvWBLMCl7uMHuKlGAff6FMdZzTg2+Crv33Bb7COuJUnJqxxEv5WaONqntrmzIe
	o3PYyz5qR+p2aN7szNx3AzBFm3KE9mRJn1MsMAngQ9jZfgV0LMTlpY9TmEc320N8D6FlrNpTc+r
	Iuvw+XRcYorCRPYTe/69FIL6J3PktkTMZB44UvoycHJCLFm0nk5rCtj8/yw/DAdXNwSFt3e5Q68
	iQsOudDy4iKUhvvSIZbk5P3j3CXKlaQEKxr+C52xSUVRZxORqX/UDNsZ1mU+FR7qaF8AQh9fnud
	vEo
X-Received: by 2002:a17:90b:2c86:b0:359:8ca0:308d with SMTP id 98e67ed59e1d1-359f05cddb0mr3295256a91.14.1773155985702;
        Tue, 10 Mar 2026 08:19:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2003:2adb:898c:8fe1:aebd:4139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f080db95sm5051182a91.9.2026.03.10.08.19.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 08:19:45 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	ojeda@kernel.org
Cc: linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH net-next] net: phy: rust: add experimental Davicom PHY driver
Date: Tue, 10 Mar 2026 22:19:35 +0700
Message-ID: <20260310151935.33197-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 06525253386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266217-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchamadcoirulanwar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

This is an experimental Rust port of the legacy Davicom PHY driver
(davicom.c) to explore the boundaries of the current PHY abstractions.

During the porting process, a few limitations in the current
`net::phy::Driver` trait were observed:
1. Callbacks for `config_init`, `config_intr`, and `handle_interrupt`
   are not yet exposed.
2. `bindings::genphy_config_aneg` is not yet wrapped.

In this RFC, the logic for these missing callbacks is implemented
and marked with `#[allow(dead_code)]` to demonstrate the required
hardware logic. Additionally, `unsafe` blocks are used as a temporary
workaround for `genphy_config_aneg` and interface checking.

Note: I don't have access to the physical Davicom hardware.
This patch is compile-tested and verified via QEMU only. It is
submitted as an RFC to share findings regarding the missing
abstractions and gather feedback on the Rust PHY usage.

Signed-off-by: Muchamad Coirul Anwar  <muchamadcoirulanwar@gmail.com>
---
 drivers/net/phy/davicom_rust.rs | 165 ++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)
 create mode 100644 drivers/net/phy/davicom_rust.rs

diff --git a/drivers/net/phy/davicom_rust.rs b/drivers/net/phy/davicom_rust.rs
new file mode 100644
index 000000000000..173f14ce25cf
--- /dev/null
+++ b/drivers/net/phy/davicom_rust.rs
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Davicom PHY Rust driver.
+//!
+//! C version `drivers/net/phy/davicom.c`
+
+use kernel::net::phy::{self, reg::C22, DeviceId, Driver};
+use kernel::prelude::*;
+
+/// Register 0x10: Scrambler Control Register (SCR)
+const SCR: C22 = C22::vendor_specific::<0x10>();
+const SCR_INIT: u16 = 0x0610;
+const SCR_RMII: u16 = 0x0100;
+
+/* DM9161 Interrupt Register */
+
+/// Register 0x15: Interrupt Register
+const INTR: C22 = C22::vendor_specific::<0x15>();
+const INTR_PEND: u16 = 0x8000;
+const INTR_DPLX_MASK: u16 = 0x0800;
+const INTR_SPD_MASK: u16 = 0x0400;
+const INTR_LINK_MASK: u16 = 0x0200;
+const INTR_MASK: u16 = 0x0100;
+const INTR_DPLX_CHANGE: u16 = 0x0010;
+const INTR_SPD_CHANGE: u16 = 0x0008;
+const INTR_LINK_CHANGE: u16 = 0x0004;
+const INTR_INIT: u16 = 0x0000;
+const INTR_STOP: u16 = INTR_DPLX_MASK | INTR_SPD_MASK | INTR_LINK_MASK | INTR_MASK;
+const INTR_CHANGE: u16 = INTR_DPLX_CHANGE | INTR_SPD_CHANGE | INTR_LINK_CHANGE;
+
+/// Register 0x12: 10Base-T Configuration/Status Register
+const BTCSR: C22 = C22::vendor_specific::<0x12>();
+const BTCSR_INIT: u16 = 0x7800;
+
+/// Handles incoming hardware interrupts from the Davicom PHY.
+///
+/// This checks if the interrupt was caused by a link, speed, or duplex change.
+/// If so, it notifies the kernel to update the link state using `genphy_update_link`.
+///
+/// TODO: This function is currently unused because the Rust PHY abstraction `net::phy::Driver`
+/// does not yet expose a `handle_interrupt` callback. It is included here for the RFC.
+#[allow(dead_code)]
+fn dm9161_handle_interrupt(dev: &mut phy::Device) -> Result {
+    let irq_status = dev.read(INTR)?;
+
+    if (irq_status & INTR_CHANGE) == 0 {
+        return Ok(());
+    }
+
+    dev.genphy_update_link()?;
+
+    Ok(())
+}
+
+#[allow(dead_code)]
+fn dm9161_ack_interrupt(dev: &mut phy::Device) -> Result {
+    let _ = dev.read(INTR)?;
+    Ok(())
+}
+
+/// Configures whether the hardware alarm (interrupts) should be turned on or off.
+///
+/// It reads the current interrupt status requested by the OS by accessing the raw pointer.
+///
+/// TODO: This function is currently unused because the Rust PHY abstraction `net::phy::Driver`
+/// does not yet expose a `config_intr` callback. It is included here for the RFC.
+#[allow(dead_code)]
+fn dm9161_config_intr(dev: &mut phy::Device) -> Result {
+    let mut temp = dev.read(INTR)?;
+
+    let intr_enabled = unsafe {
+        let ptr = (dev as *mut phy::Device).cast::<bindings::phy_device>();
+        (*ptr).interrupts == bindings::PHY_INTERRUPT_ENABLED as u8
+    };
+
+    if intr_enabled {
+        dm9161_ack_interrupt(dev)?;
+        temp &= !INTR_STOP;
+        dev.write(INTR, temp)?;
+    } else {
+        temp |= INTR_STOP;
+        dev.write(INTR, temp)?;
+        dm9161_ack_interrupt(dev)?;
+    }
+    Ok(())
+}
+
+/// Configures PHY Auto-Negotiation.
+///
+/// Isolates the PHY during configuration, then calls the generic `genphy_config_aneg`
+/// via unsafe C bindings because Rust abstractions don't expose it directly yet.
+fn dm9161_config_aneg(dev: &mut phy::Device) -> Result {
+    dev.write(C22::BMCR, bindings::BMCR_ISOLATE as u16)?;
+
+    let err = unsafe {
+        let ptr = (dev as *mut phy::Device).cast::<bindings::phy_device>();
+        bindings::genphy_config_aneg(ptr)
+    };
+    to_result(err)?;
+
+    Ok(())
+}
+
+/// Initializes the Davicom PHY hardware upon detection.
+///
+/// Depending on the `interface` mode (MII vs RMII), the Scrambler Control Register (SCR)
+/// is configured. It relies on `C22::vendor_specific` addresses.
+///
+/// TODO: This function is currently unused because the Rust PHY abstraction `net::phy::Driver`
+/// does not yet expose a `config_init` callback. It is included here for the RFC.
+#[allow(dead_code)]
+fn dm9161_config_init(dev: &mut phy::Device) -> Result {
+    dev.write(C22::BMCR, bindings::BMCR_ISOLATE as u16)?;
+
+    let interface = unsafe {
+        let ptr = (dev as *mut phy::Device).cast::<bindings::phy_device>();
+        (*ptr).interface
+    };
+
+    let temp = match interface as core::ffi::c_uint {
+        bindings::phy_interface_t_PHY_INTERFACE_MODE_MII => SCR_INIT,
+        bindings::phy_interface_t_PHY_INTERFACE_MODE_RMII => SCR_INIT | SCR_RMII,
+        _ => return Err(code::EINVAL),
+    };
+
+    dev.write(SCR, temp)?;
+
+    dev.write(BTCSR, BTCSR_INIT)?;
+
+    dev.write(C22::BMCR, bindings::BMCR_ANENABLE as u16)?;
+
+    Ok(())
+}
+
+/// Representation of the Davicom DM9161E chip.
+struct DavicomDM9161E;
+
+#[vtable]
+impl Driver for DavicomDM9161E {
+    const NAME: &'static CStr = c"Davicom DM9161E";
+    const PHY_DEVICE_ID: phy::DeviceId = DeviceId::new_with_custom_mask(0x0181b880, 0x0ffffff0);
+    fn config_aneg(dev: &mut phy::Device) -> Result {
+        dm9161_config_aneg(dev)
+    }
+}
+
+struct DavicomDM9161A;
+
+#[vtable]
+impl Driver for DavicomDM9161A {
+    const NAME: &'static CStr = c"Davicom DM9161A";
+    const PHY_DEVICE_ID: phy::DeviceId = DeviceId::new_with_custom_mask(0x0181b8a0, 0x0ffffff0);
+    fn config_aneg(dev: &mut phy::Device) -> Result {
+        dm9161_config_aneg(dev)
+    }
+}
+
+kernel::module_phy_driver! {
+    drivers: [DavicomDM9161E, DavicomDM9161A],
+    device_table: [DeviceId::new_with_driver::<DavicomDM9161E>(), DeviceId::new_with_driver::<DavicomDM9161A>()],
+    name: "davicom_rust",
+    authors: ["Andy Fleming"],
+    description: "Davicom PHY Rust Driver",
+    license: "GPL"
+}
-- 
2.50.0


