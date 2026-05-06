Return-Path: <netdev+bounces-284668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB+RJh+l+mm7QwMAu9opvQ
	(envelope-from <netdev+bounces-284668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:19:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114474D59C7
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 04:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6732E3021AD2
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEB9283C93;
	Wed,  6 May 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmg53ooT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC272820A9
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778033947; cv=none; b=gNx2dDewHHcDuMH/Dxc+jMDO/AaXaDVbRkZuSKdBlDedcLFxmCv+tCOiXIHRI3uT3lYZaSDTT6P7kAtDSrvg0zvQ6eGW5IXOlm2/zA43sMn2sCkZ4ZeC/7sukvnYpMglzTORgaXPEfnOX82kQ1ZJjMKeItu0z6H0XNeFUi4OVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778033947; c=relaxed/simple;
	bh=86Ei1WG1fz4kMaacEOmlqzqDxWn+mO7BN44/481AeEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y3lJxOxDfi9eTnt8rYcSb3leAnDmDhHIazGM4zcCHQIvBQ84djeO4DC8SlDdFYM4hBDxTS36whwh0UJ9dqrtHUcyBJaSuVEgqVviMhDSEdKsehOsnglJ9QwayAu5irG1YWlZtqKiOT4030VxodavYH15vp8FnM6DfH68INJsOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmg53ooT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba4efedbeaso11505345ad.1
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778033944; x=1778638744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpUMCxZV9PP5HhSYLbx/P1k1sQWc+4gDEtSSVnk03wQ=;
        b=pmg53ooTLNemlhOLUkNHIIYA1sI9zOQwiDK7wRMqqjsktLi2zwtgvVmuKX02hHB6mU
         NpxBq5ZivPcSSRLga2AtkJpEOlHhoeCaEHeuuwod99w3u1EP3DODdWX8gFds0923p+lj
         uVvrVEjEiF2aSuXmD8f4N7wyPOHgQWL8k4tM6gs8dfBwveAnQBwVqEheAKt9jJy9oEz6
         YAZ7PlM0mRBYtKJMD9t0laNbK/vke2Jl72duYIfDu9SGkyRc34fTyqHqHN0PiAnsZUxs
         B9/TzTiavdbipbE8JXN3VBz3/JxBjd4DVITpi/PMQqwbXQgqfKl4KT6c7OuKjrduIWWF
         lUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778033944; x=1778638744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GpUMCxZV9PP5HhSYLbx/P1k1sQWc+4gDEtSSVnk03wQ=;
        b=NalKw6FVUXIUVMbqpWR9kQc+cnPIIA2wI2LCjB+PQQyLIU01hMC53z9fi7gRs3g3SD
         TWFNkxHQ4lC0Wo0/O96l20r/1VOTCuMQZBfj5hOZZOl0uTt5s8mpNY2UHNHuBc5sbyIa
         LjldfHi1TtVWPaMbo1o665zHhE/l+qJn9KK+OT/+ZY7ws4FvLBy00oAl9B1jhiZM88j4
         +nQLtJpHmsNROFd+ce+EPOAE43PwCNMc5jPLQAdzF5uadjxvimULZbVHimPBdGqOQgjh
         /2iEhIt+V0YK7hJloNS9lw6FWwZGh4MNUy1XFY3sSebYXjdYlnmXZUrKabiRBdQ54vTh
         R87w==
X-Gm-Message-State: AOJu0Yw46UkJAGk2R/tlzVXKipeiTpIAZJBGpqgVIGIWPttMyc6DynHq
	rPDn60r9BUi7gsG1MOngyWa720moXviq9EiGF7JrHYDBzHpBXBc5zbwI3Ua5GGID
X-Gm-Gg: AeBDiev9LeFCYNUr/WsDN2E0jgitZoWYLvkLJO+IQnoIl1NDn77k6UnGBHqu97C2nDH
	sL0b//8UXc/2BltombFL9dfg8fjrH3hNOmYeQcu81Nz9tqYPahezSDMmg1KL1svMTvkRlolrymq
	xrLxa/pW4VO7eBoqtoTZ2fMyK8W4cHJi5elKgas/roGDwtDLxWxTWURPOnXUE24OeIY1en4jZih
	gm1SQ6g7k4trDNvDYI+youhALa0pap7RTKVGb7QrYYBILZAasi1H8XblUr8iwqczqE724xU3Dds
	0tDlk8U2+Kt1mk+KMydzISvcUFfQ8gN+5DB9HQzfGbl+dYs6YMWp4FHhTMsr5zTIfQorGiXFD7I
	6Dc1VLZLVNUhOzn5Xffb2Sofsgb2ciGxksStdmbB4h6jtLVbATjoOxellWgNtqkvuraqA7VgTVI
	1P5PlmITgbAaY3U4bIyzzwdiGOShdL/rNtH0FqeCRXr5EBpCg4jYgshQ==
X-Received: by 2002:a17:902:d2d1:b0:2b2:42f8:1a45 with SMTP id d9443c01a7336-2ba7a377058mr14501615ad.39.1778033943967;
        Tue, 05 May 2026 19:19:03 -0700 (PDT)
Received: from ampere-server.example.org ([103.68.183.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1ac6sm6319525ad.42.2026.05.05.19.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 19:19:03 -0700 (PDT)
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
Subject: [PATCH 2/2] docs: acpi: dsd: add Motorcomm yt8xxx PHY properties
Date: Wed,  6 May 2026 10:18:13 +0800
Message-Id: <20260506021813.3658669-3-linchunzhi0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506021813.3658669-1-linchunzhi0@gmail.com>
References: <20260506021813.3658669-1-linchunzhi0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 114474D59C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,redhat.com,google.com,davemloft.net,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-284668-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linchunzhi0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]

Document Motorcomm yt8xxx PHY ACPI _DSD properties consumed by
the motorcomm PHY driver.

Describe property placement, UUID usage, and reference the DT binding
for value constraints and defaults.

Signed-off-by: chunzhi.lin <linchunzhi0@gmail.com>
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
index b246902f523f..3cd38bb4de15 100644
--- a/Documentation/firmware-guide/acpi/index.rst
+++ b/Documentation/firmware-guide/acpi/index.rst
@@ -12,6 +12,7 @@ ACPI Support
    dsd/data-node-references
    dsd/leds
    dsd/phy
+   dsd/motorcomm-yt8xxx-phy
    enumeration
    osi
    method-tracing
-- 
2.34.1


