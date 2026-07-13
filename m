Return-Path: <netdev+bounces-307255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ozDBBIIdVWp5kAAAu9opvQ
	(envelope-from <netdev+bounces-307255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:16:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BC74DEE2
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=breiti.cc header.s=google header.b="H4Ub/jeg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307255-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307255-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 697EA301D327
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32168277035;
	Mon, 13 Jul 2026 17:16:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56511274658
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 17:16:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783963008; cv=none; b=oD10vdMQJWb2+xt80dS7+PZb55r35SONYb5M2zwohQHkf8/SeQ4+QYrxa5Z5HZ1WT4ibSXjTKJD4GenVw/HmOcJnuRC+jGkwoDGO/QJgX8KneggW5OJ5yIAcjzXf0tkj8Xy1fK845OB5e7bKilQm5edd32vwBw/6di+z11Pfg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783963008; c=relaxed/simple;
	bh=p1jLAlgaFAZC8YZE8WGwBXhLOIAf22MGlzvlCbicn1g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Esthn82DxSM9+Bb9TSVjM/bgMxlq+dXwn9FJfW0cIihVBvCw3TT/OJTTsUNRGmkJxeIR3DOTetOhaLncVsZuIjIHzHExlBEJRr7tMIt/o2/0sD5Vi7xHprR2YABjCTUMIxrxESdFqpj5CRNj0KlTxCHgjpGrOvPaolEWwSwwKKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=breiti.cc; spf=pass smtp.mailfrom=breiti.cc; dkim=temperror (0-bit key) header.d=breiti.cc header.i=@breiti.cc header.b=H4Ub/jeg; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47defd0c1c5so51895f8f.3
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 10:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=breiti.cc; s=google; t=1783963004; x=1784567804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D6+zJCN4uHBUySGZxMxtpjUmXPdT/OOFNXEwXFVOhXs=;
        b=H4Ub/jegVV6xKMr4b4ZDBmeZ0ff+XupXiS9lQnnIZYqM4pT9VVV3bSGeBrmCRXsc5z
         g1zq7Q/Jp09al8/RSz30PQaRl7O3KE7e18lo7uC+l16JFTDYLn+WEBqCc2h3XxplWNyT
         Eyfd3QPCqAPv0bKUvjN0+/shaMoAQ6AdgF3jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783963004; x=1784567804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D6+zJCN4uHBUySGZxMxtpjUmXPdT/OOFNXEwXFVOhXs=;
        b=IwquwHmTfroxP0qZUv+zNApAZsT12pPGF6x3XLZby9dFClbf6sONbL8mJPo4OPGN1C
         bqfxXO6uX4wFwQONWeDvblHF3Dl6IlETBsM3UKjCLWV3IZur16tKSFyiXx8zsfzsSiur
         oi1xfE8IGkj7X1gN8t+VBxBYzCJyDTzJrmq1IS88sYCuRAb9yIhD7iScu1Z2zOFmrMrH
         sui/dcCxgfchGBsJZWGDysSUZYCC/ljFPdEarcYJbUBPb9ofArjjba/IePH6q/h80Tl7
         zKBPxxbK6ZcXEoXEQe+AApgX499DJwKLI4w3J9Eh65eQmFn1teCEHM83lCliN1Av0i7a
         Jk8g==
X-Gm-Message-State: AOJu0YwEQi7IZmVZmkeCXNAB8NunO5Pch7KeAYAVvmKhgOE7VNfRhvoi
	TkttmSVXr3rK27WH7cqyCu35Jt+5KVHUWHxVuDDFzccScOEHOf2AcYmyTVZcCvu5Thcns0edig0
	GK45A/JUL
X-Gm-Gg: AfdE7cl/HbrEF6HQB4jS/ErN/E0W5G5ucxdImBZD68YMGM/or3k3oGUIPfurA4Rwy2F
	a7cI5DGnBgoNEKgbAVljzuZxVf+qrUlE3mODXqTG/HiYID7M8IQy7fgiBlqoiGYLDX/Q8aDj2/T
	OXnS1CNjaOsvBUEGtrjeif+TzsMjAfhU99wdawIqDCwUDphcwZqaGrLy5ZNhQ7K0vpgpYJult4O
	7gNNdfPWjTGciso5WlITDbQzgXwolJWjDX7QteqttWYhHsSBIRKe6VY9xhIXUmNWTleMi4V4Tlh
	8gM6K9GKEwMXPlyUpfSYpPliC6GHqv5F7oQFm5QT3RnCOIILppFJIlhStmD+eUXrQ5V1sWC9D2W
	+w32vI3nx/aoBIHEF2VoslOHBhfMPw0hYc+Z5WLJ2K3hJIlbPM+akrKa8i0Z02afUeAecvizjrV
	SNsuRGCL+vIQu+5EbDWhUYpR9vAASAkkS4qt90IWsHVg92+VjNhQ==
X-Received: by 2002:a05:6000:1848:b0:476:a715:1a with SMTP id ffacd0b85a97d-47f2dce2b61mr11893647f8f.41.1783963003297;
        Mon, 13 Jul 2026 10:16:43 -0700 (PDT)
Received: from framework.casa.breiti.cc ([2.57.48.190])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9728sm1007047f8f.21.2026.07.13.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:16:42 -0700 (PDT)
From: Markus Breitenberger <bre@breiti.cc>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	yong.liang.choong@linux.intel.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	Markus Breitenberger <bre@keba.com>
Subject: [PATCH net v3] net: stmmac: intel: skip SerDes reconfig when rate is unchanged
Date: Mon, 13 Jul 2026 19:16:19 +0200
Message-ID: <20260713171619.192452-1-bre@breiti.cc>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[breiti.cc:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-307255-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:yong.liang.choong@linux.intel.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:stable@vger.kernel.org,m:bre@keba.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DMARC_NA(0.00)[breiti.cc];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,gmail.com,foss.st.com,armlinux.org.uk,linux.intel.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,keba.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bre@breiti.cc,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[breiti.cc:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,keba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 628BC74DEE2

From: Markus Breitenberger <bre@keba.com>

intel_mac_finish() is registered as the phylink mac_finish()
callback for the Elkhart Lake SGMII ports. phylink calls it at
the end of every major link reconfiguration, including the
initial one during probe.

The callback selects the PMC ModPHY LCPLL programming for the
requested MAC-side interface and then power-cycles the SerDes.
On Elkhart Lake that ModPHY is also used by the on-die AHCI
SATA PHY. Reapplying the programming during the initial
boot-time link-up disturbs the shared analog block while it is
still driving SATA, so the SATA link fails to train:

  ata1: SATA link down (SStatus 1 SControl 300)

The disk carrying the root filesystem is never detected and the
system hangs at rootwait. Ethernet itself comes up normally,
which makes the failure look unrelated to the network driver.

Before mac_finish() runs, the legacy SerDes power-up path has
already programmed SERDES_GCR0 for the current interface. The
1G and 2.5G ModPHY tables selected by mac_finish() correspond
to the SerDes lane rate, so read that rate back from SERDES_GCR0
and skip the PMC reprogramming and SerDes power-cycle when it
already matches the selected interface.

This keeps the disruptive reprogramming out of the boot path
when the SerDes is configured correctly, while preserving the
previous behavior when a real SGMII/1000BASE-X to 2500BASE-X
rate change is needed. If the register read fails, reconfigure
as before.

Fixes: a42f6b3f1cc1 ("net: stmmac: configure SerDes according to the interface mode")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Markus Breitenberger <bre@keba.com>
---
v3:
  - Update priv->plat->phy_interface before skipping SerDes reconfiguration,
    so SGMII <-> 1000BASE-X changes still update the cached interface.
  - Rename subject to "net: stmmac: intel: skip SerDes reconfig when rate is unchanged".

v2: https://lore.kernel.org/netdev/20260709190329.124432-1-bre@breiti.cc/
  - Read current SerDes lane rate from SERDES_GCR0 instead of comparing
    against cached phy_interface state.
  - Rework commit message.
  - Keep previous behavior if SERDES_GCR0 read fails.

v1: https://lore.kernel.org/netdev/20260706061954.94842-1-bre@breiti.cc/

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b8d467ba6d72..4d207f41a43b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -525,6 +525,32 @@ static int intel_set_reg_access(const struct pmc_serdes_regs *regs, int max_regs
 	return ret;
 }
 
+/*
+ * Return true if the SerDes lane rate must change to serve @interface.
+ * If the current rate cannot be determined, reconfigure as before.
+ */
+static bool intel_serdes_needs_reconfig(struct stmmac_priv *priv,
+					struct intel_priv_data *intel_priv,
+					phy_interface_t interface)
+{
+	u32 cur_rate, want_rate;
+	int data;
+
+	if (!intel_priv->mdio_adhoc_addr)
+		return true;
+
+	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr,
+			    SERDES_GCR0);
+	if (data < 0)
+		return true;
+
+	cur_rate = (data & SERDES_RATE_MASK) >> SERDES_RATE_PCIE_SHIFT;
+	want_rate = interface == PHY_INTERFACE_MODE_2500BASEX ?
+			SERDES_RATE_PCIE_GEN2 : SERDES_RATE_PCIE_GEN1;
+
+	return cur_rate != want_rate;
+}
+
 static int intel_mac_finish(struct net_device *ndev,
 			    void *intel_data,
 			    unsigned int mode,
@@ -536,6 +562,11 @@ static int intel_mac_finish(struct net_device *ndev,
 	int max_regs = 0;
 	int ret = 0;
 
+	if (!intel_serdes_needs_reconfig(priv, intel_priv, interface)) {
+		priv->plat->phy_interface = interface;
+		return 0;
+	}
+
 	ret = intel_tsn_lane_is_available(ndev, intel_priv);
 	if (ret < 0) {
 		netdev_info(priv->dev, "No TSN lane available to set the registers.\n");
-- 
2.55.0


