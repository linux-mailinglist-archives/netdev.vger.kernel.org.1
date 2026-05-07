Return-Path: <netdev+bounces-285143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM5nKeIO/GnsKgAAu9opvQ
	(envelope-from <netdev+bounces-285143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D254E2C16
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 06:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A55B43009CF8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 04:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC731815D;
	Thu,  7 May 2026 04:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL2LuZGw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E8B31A7E4
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 04:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126561; cv=none; b=DrUxGqmomG82R1cEyrEfOP0NbDIcqir4cnoYYBDulH6LHFfYWB6x+s5GkGXJDKGIHMQZxPK+SITULCuUs88x7zHCI+McsLzsmSXA5mIzLtV47l6vhPlM8Mikjq/BSol7QaUBiAgh0Q0rNA5af7Llwwf1H1fGRWGbBrKDd4CcmF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126561; c=relaxed/simple;
	bh=Ll5t8GG+HHemlVZ/dlzGil/rBZk5oSgZbVxAUeRxn+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYlTR1M6WJr6NnTZK3KCPxRW8lp3OFzgKkVk/cCx8BmWHSa4zgXhmH5ZiD74QiapSF0hYFrlF/TCeCIztKFs801o8iJbY+hRC6VIUnlGBHEJov36e31PXM83YTM4ugRNHn9k3yfuoBhraIbigiBpYnFts6BGBW4ZEMAv5FwOpMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL2LuZGw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3660ab73adbso130953a91.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 21:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778126557; x=1778731357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5gyYRLK16pcO2llT+UUfUWubla4yLA0GVq02udlXI=;
        b=RL2LuZGwYfTHFPP9NJzBHUOyErQiI5dLc0Wm4BNfPAOqZBzInj4DvHJK+HAaQkYS85
         cbxCvtE2effJedExPyIcmLObxJPL2fVcK6P/52AZo4fK4H13aGZm/VdUZpW56yYye0jy
         pw62lQI3lr80jDFoKoVnWwFBzoXWb+N26svryuTWAxI4fs+ZMZgbWzd0NxV6pWAAbcVT
         JQgnlByNqmEpWuOfkM7tv93sMhWiHXVOo2wgDNxGivfuAsuNN9yFL5ZLvAWxb72+2tVq
         PDyHCsac6uneXgRpfpLOat89XVTH/nvgvAs262hgHFv9qvkxoDgSsbb/M5cm5san5Eyg
         vx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778126557; x=1778731357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jq5gyYRLK16pcO2llT+UUfUWubla4yLA0GVq02udlXI=;
        b=QoskAyOHstkjSL+9SHmkJF+d1bHBr6/9JK0rRVEPEVVa+haVHFqUaQuLoXxmYwqTY7
         g5Rm2YeAdjc+h6tX7FM8OF95aJ4udIlXu93MWR5yDxp3+rhVXoCaMgs6kVQxHlVWpRs0
         ZnAsRxOf54JFI1du3BmIawWXy10e5V9XsPGKzY4Js4miC+zPi5XVxlh6qv+HM1f1+S3+
         Zp7CVVmLh64AievGYdnD2Cd/eG3PK0e+++GPEOGBdfjPmO6GlfSQmI/JTJyAE0LrlWQU
         jAMgbmQCE8+qhCxchvJJBA6UxxgIVEnxTDDFjLlO1ikcmluENOexa35K1BZOMpiR4ZNS
         +L1w==
X-Gm-Message-State: AOJu0YyOAN4/AxQI1W4xO3q8IaYhgvHGoaKBW9btOveplO/7vZJJ9ENW
	GRAJn79wUArH2dsqI3UKeYNMXJogwEKLG+EgWlnzraRbLj8miE1Wt3k0uJfW/mZe
X-Gm-Gg: AeBDieuPemcQcMtK8r/Yw/507K9xRDWa+T+jPIN6eGYRhjppRozKM4Av+ojoiKh8Hrv
	6gM3NVyTplrupVzwSQ7iLtTL1vtHMF9fm7lLkvvKDsTu/Q6bD+92oCS/y+/BwyO6DeFarCADpOu
	1v1mlCqo694gQVEsyo7nfslBDtWP9M2gaO8+eh0bAosgTToLP/TIO0QuRcBOgvcImZV5YX9uHr0
	cGbLvyk69hw84gLzAWz1Nx62ecNNhY2c2WEvVXwDm0bQ19sKrWh0M0idd0HVeLyOCUJWxYJVvpT
	JkXZqt3uIWDncNRiLvTlWzHMAjP1Bw0tJG+Y9/qRIXtaGnvncoQ/7GoqUlJ8C4Y9flts/JByjZN
	iDhH3VWmHVAiqoBGuzAGplMYlw1xWH6kQ51aZEvW/Dacex9AWwhlg9ioORIkKb2Sox/vnOD/2zf
	mAsk0nVVCIcPay7c6uUZ62w07wqcn4hB31J/+Zi7yDE5Vf6/9ph3m2zQ==
X-Received: by 2002:a17:90b:37ce:b0:35e:579a:7e9a with SMTP id 98e67ed59e1d1-366053f7f37mr1026290a91.7.1778126557333;
        Wed, 06 May 2026 21:02:37 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365d8e3dad8sm2536182a91.1.2026.05.06.21.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 21:02:37 -0700 (PDT)
From: "chunzhi.lin" <linchunzhi0@gmail.com>
To: netdev@vger.kernel.org
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	linux-acpi@vger.kernel.org,
	rafael@kernel.org,
	lenb@kernel.org,
	"chunzhi.lin" <linchunzhi0@gmail.com>
Subject: [PATCH v2 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Date: Thu,  7 May 2026 12:02:21 +0800
Message-Id: <20260507040221.3679454-3-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507040221.3679454-1-linchunzhi0@gmail.com>
References: <20260507040221.3679454-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 50D254E2C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285143-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Document Motorcomm yt8xxx PHY ACPI _DSD properties consumed by
the motorcomm PHY driver.

Describe property placement, UUID usage, and reference the DT binding
for value constraints and defaults.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>

Changes in v2:
- Keep dsd/ entries sorted in Documentation/firmware-guide/acpi/index.rst
---
 .../acpi/dsd/motorcomm-yt8xxx-phy.rst         | 107 ++++++++++++++++++
 Documentation/firmware-guide/acpi/index.rst   |   1 +
 2 files changed, 108 insertions(+)
 create mode 100644 Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst

diff --git a/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst b/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
new file mode 100644
index 000000000000..d64a396fac81
--- /dev/null
+++ b/Documentation/firmware-guide/acpi/dsd/motorcomm-yt8xxx-phy.rst
@@ -0,0 +1,107 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Motorcomm yt8xxx PHY properties (_DSD)
+======================================
+
+This document describes ACPI _DSD device properties for Motorcomm yt8xxx
+Ethernet PHYs supported by the in-kernel driver in
+``drivers/net/phy/motorcomm.c``.
+
+The properties are exposed on the PHY device object under the MDIO bus ACPI
+device (the same objects that are registered via
+``fwnode_mdiobus_register_phy()``). MAC-side connection properties such as
+``phy-handle`` and ``phy-mode`` are documented in [acpi-mdio-phy]_.
+
+Property names and semantics are intentionally aligned with the Devicetree
+binding [motorcomm-yt8xxx]_ so that the same driver code path
+(``device_property_*`` on ``&phydev->mdio.dev``) can consume firmware
+described either as Devicetree or ACPI _DSD.
+
+UUID and placement
+==================
+
+Per [acpi-dsd-properties-rules]_ and [acpi-mdio-phy]_, properties must be
+placed in an _DSD package using the standard Device Properties UUID::
+
+	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301")
+
+Properties
+==========
+
+Unless noted otherwise, integer properties use the same allowed values and
+defaults as [motorcomm-yt8xxx]_.
+
+``rx-internal-delay-ps`` (u32, optional)
+  RGMII RX internal delay in picoseconds. Only meaningful when the link is
+  using RGMII modes with RX internal delay; see [motorcomm-yt8xxx]_.
+
+``tx-internal-delay-ps`` (u32, optional)
+  RGMII TX internal delay in picoseconds. Only meaningful when the link is
+  using RGMII modes with TX internal delay; see [motorcomm-yt8xxx]_.
+
+``motorcomm,clk-out-frequency-hz`` (u32, optional)
+  Clock output frequency on the PHY clock output pin. Allowed values and
+  default are defined in [motorcomm-yt8xxx]_.
+
+``motorcomm,keep-pll-enabled`` (boolean, optional)
+  If true, keep the PLL enabled even when there is no link (useful for using
+  the clock output without an Ethernet link). See [motorcomm-yt8xxx]_.
+
+``motorcomm,auto-sleep-disabled`` (boolean, optional)
+  If true, disable the PHY auto-sleep behavior described in
+  [motorcomm-yt8xxx]_.
+
+``motorcomm,rx-clk-drv-microamp`` (u32, optional)
+  Drive strength for the ``rx_clk`` RGMII pad in microamps. Allowed values
+  depend on the configured RGMII LDO voltage; see [motorcomm-yt8xxx]_.
+
+``motorcomm,rx-data-drv-microamp`` (u32, optional)
+  Drive strength for the ``rx_data`` and ``rx_ctl`` RGMII pads in microamps.
+  See [motorcomm-yt8xxx]_.
+
+``motorcomm,tx-clk-adj-enabled`` (boolean, optional)
+  Enables adjustments related to ``motorcomm,tx-clk-*-inverted`` usage; see
+  [motorcomm-yt8xxx]_.
+
+``motorcomm,tx-clk-10-inverted`` (boolean, optional)
+``motorcomm,tx-clk-100-inverted`` (boolean, optional)
+``motorcomm,tx-clk-1000-inverted`` (boolean, optional)
+  Per-speed TX clock inversion options; see [motorcomm-yt8xxx]_.
+
+ASL example (illustrative)
+==========================
+
+The example below only shows PHY-local _DSD properties. A real platform
+still needs a MAC ``phy-handle`` and ``phy-mode`` package as in
+[acpi-mdio-phy]_.
+
+.. code-block:: none
+
+	Scope (\_SB.MDI0)
+	{
+		Device (PHY4)
+		{
+			Name (_ADR, 0x4)
+
+			Name (_DSD, Package () {
+				ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
+				Package () {
+					Package (2) { "rx-internal-delay-ps", 2100 },
+					Package (2) { "tx-internal-delay-ps", 150 },
+					Package (2) { "motorcomm,clk-out-frequency-hz", 0 },
+					Package (2) { "motorcomm,keep-pll-enabled", 1 },
+					Package (2) { "motorcomm,auto-sleep-disabled", 1 },
+				}
+			})
+		}
+	}
+
+References
+==========
+
+.. [acpi-mdio-phy] Documentation/firmware-guide/acpi/dsd/phy.rst
+.. [acpi-dsd-properties-rules]
+   Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+.. [motorcomm-yt8xxx]
+   Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
diff --git a/Documentation/firmware-guide/acpi/index.rst b/Documentation/firmware-guide/acpi/index.rst
index b246902f523f..db9eb7229948 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -11,6 +11,7 @@ ACPI Support
    dsd/graph
    dsd/data-node-references
    dsd/leds
+   dsd/motorcomm-yt8xxx-phy
    dsd/phy
    enumeration
    osi
-- 
2.34.1


