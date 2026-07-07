Return-Path: <netdev+bounces-305537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UNpOBxYzTWrwwQEAu9opvQ
	(envelope-from <netdev+bounces-305537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:10:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BE271E248
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 19:10:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=Mv31kGbD;
	dmarc=pass (policy=reject) header.from=sartura.hr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305537-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305537-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D52330EBE28
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9973EB81E;
	Tue,  7 Jul 2026 17:05:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1D434E58
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:05:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443947; cv=none; b=oySrq/pKV/w1tzT+gJv6rX5MZ/KV04fnn1c1KzwiFtk19mwBhuWJZFm3ZQYeaznlcofb+bs5SzLEu3qj6i2CM6ZAmWk+qjBRSm076JVx1XL1GG8sHf5mSe/w/Rq38BxPC3gllGH9Dk0Tcd/yRe5wkhAgsYg21iJ39JJIVVCKstw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443947; c=relaxed/simple;
	bh=oI9mo+kK/dY8LnNtPsTVPnaa5YkRrzSB+3UnGPD2bE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tBCR6cj7OE7D6N2LnqS5osWexEJzv/Vscb1xxdHui1l8Q95tNJDS13CeTOxTSpsbtk9lOsCOkatdO4GpyPp9pWRXwpmgOTm4EbSTdBXWXoX+XC66FmOfFNAnBt0t/ErGZVUemZFOQZ2uUjUiRch7+HUvscFeA9E1OjoZrXTgJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Mv31kGbD; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-471eeac43bfso4726899f8f.3
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1783443942; x=1784048742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2AXykctnuSwIgdCxYi80gooQQMlU2MT4Krd1IoiYwg=;
        b=Mv31kGbDyMZyQNfrhxORs9XGKKYmpNp0+Looj+QIXNLFy/jJVyhm+coCYMZ80ZAto6
         tp97/hkRrQmqRlSQPOdCMhV3YmPApxzbUL6bJkTsLfPixxSh2lfj+ITs77yoci+AjqmT
         PCwO00n6WAcoQ11atqv9gneqmQtF3S86m4ByuU1wYHGzp8IujSTBFzoiJeWbs71U49AM
         4mtEBiEj+aC45W6BWvgE9NY7OLsJicLQZusi+dmBDF/4vW/54Qe2+vCqgygyDf6djF3K
         zbZ9Gosc4hKRrIr/BOjnbLemmg599I7wc5mb4FRdkMyZk1VyKBOfsJgO0r9iveGKVvWu
         uc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443942; x=1784048742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2AXykctnuSwIgdCxYi80gooQQMlU2MT4Krd1IoiYwg=;
        b=acSYuWTY5QaKuC+QDO0x1LcrzpMoMQpNcVuLTbobEerORG97DytPCTPM+wEDXr5fKa
         +xmb3WDxjcTc6ce0Er9VSXA3GdB6SAFTlyekffY3V+kqPMHW6Fhn54P97gf3W+S+qX/d
         b7zrzsXR7xuWxz49OnJdgNWqlfY4HpgtFuYFtv1qFOAqa6QYee5pa73YIBSo2B+RFsyT
         E0llcK4ORoogyZ01QFGvCEjb3+kbi6SnJ7ZoQmtUCF61xLW4/Gveo396gj1O/nPhzHgS
         aGjJo7PoYH0I/WXSlgKNtixHwkJiuZwjjPNQsgmLXJzN8WBtSRVmbC/doXaoHXKSYIhC
         PRaw==
X-Forwarded-Encrypted: i=1; AHgh+RqNymQ7r3U8kFoB+S/C4PGMNc9DnQ3R1rYOS5u1JbidmiWCg3IGozC5d2qTCfAFGdIBzW6tzYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaMb7jG1ySmQZGkEMCxIk+CCdzWRAE5L4amT5XRhCJ/j5IME9w
	HggBcj1s21QTJ3F73pOz6O7UbzkhqPZ8qf4JtaxefvT2SNndmchDAQcOb/ca1gj/jEk=
X-Gm-Gg: AfdE7ckRN4zy7+R/yNF6AMQNAsbhWaEf/ByNCbB9XmU/+wWNMnWg15GJR4uBkVq7Vmk
	QBycTSh7MiYsnigZqpTOmxO4pPUtZf0mGscWXK45/P/JAxAg/E4u6yw6lU6xNBLmC3EK8/Dig/r
	6Ug+zR6TODA0tHIIDgR8IZrFB3+mIygxyDQPuONys28lbw9jpaiJHEsFgBhdNqgjWxWp+MZPAwz
	hxO3C7cAW8xgw0vamNkJl5vwG2Gz7mRsWRMMH9cqwiMbKZHXs+RkI2j5lJg4F6jQG9E8gEu9N5/
	3BsOX1E2sztv1E1Hpt0GWwdoLYdBc3VYrGsKNVD6Zv28p4SxVq0/1mt8AydcZWn6cVP87xNqddV
	AoVtEqyBPmH1pMhAiWUuwp5dI6pplCaUaD7Cdd9/0MctdMMjPKQiAxi61tX4BpnTuxjCPCUpjrM
	OAN3q4xVAAFBCysPHt1tyrDQ23McgiCKhKLVRye9wWIWN4BJaoPX1l3bxdgCVKi2tK3pTp/S/Ls
	vs1y342jw1euoH/Det7a3GSY88DmJoKwRFRY0mMYig=
X-Received: by 2002:a05:600c:1d1a:b0:493:d078:796 with SMTP id 5b1f17b1804b1-493df092921mr77545585e9.17.1783443942618;
        Tue, 07 Jul 2026 10:05:42 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-57.xnet.hr. [88.207.15.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e54a27cbsm1811395e9.1.2026.07.07.10.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 10:05:41 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next] net: sparx5: configure TAS port link speed
Date: Tue,  7 Jul 2026 19:04:48 +0200
Message-ID: <20260707170531.1129866-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-305537-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sartura.hr:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,microchip-ung.github.io:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 44BE271E248

On the TSN and RED variants of LAN969x and SparX-5i TAS (Time-Aware Shaper)
is present in the silicon.

Currently, the driver does not use configure it at all, which means that
the TAS_PROFILE_CONFIG.LINK_SPEED[1] value is left at the default of 3
which means that its configured for 1 Gbps.

So, running iperf between two 10G switch ports will result in only 940-ish
Mbps while we should be getting around 9.3 Gbps.

Correctly populating the TAS_PROFILE_CONFIG.LINK_SPEED[1] with the current
port speed fixes this issue and we achieve around 9.4 Gbps between two 10G
switch ports.

So, port the TAS port link speed setting from the vendor BSP 6.18 kernel[2]

[1] https://microchip-ung.github.io/lan969x-industrial_reginfo/reginfo_LAN969x-Industrial.html?select=hsch,tas_profile_cfg,tas_profile_config,link_speed
[2] https://github.com/microchip-ung/linux/tree/bsp-6.18-2026

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../microchip/sparx5/lan969x/lan969x_regs.c   |  3 ++
 .../microchip/sparx5/sparx5_main_regs.h       | 12 +++++
 .../ethernet/microchip/sparx5/sparx5_port.c   |  4 ++
 .../ethernet/microchip/sparx5/sparx5_qos.c    | 49 +++++++++++++++++++
 .../ethernet/microchip/sparx5/sparx5_qos.h    |  1 +
 .../ethernet/microchip/sparx5/sparx5_regs.c   |  3 ++
 .../ethernet/microchip/sparx5/sparx5_regs.h   |  3 ++
 7 files changed, 75 insertions(+)

diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
index ace4ba21eec4..3fc2c006ba12 100644
--- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_regs.c
@@ -95,6 +95,7 @@ const unsigned int lan969x_gaddr[GADDR_LAST] = {
 	[GA_HSCH_SYSTEM] = 37384,
 	[GA_HSCH_MMGT] = 36260,
 	[GA_HSCH_TAS_CONFIG] = 37696,
+	[GA_HSCH_TAS_PROFILE_CFG] = 37712,
 	[GA_PTP_PTP_CFG] = 512,
 	[GA_PTP_PTP_TOD_DOMAINS] = 528,
 	[GA_PTP_PHASE_DETECTOR_CTRL] = 628,
@@ -129,6 +130,7 @@ const unsigned int lan969x_gcnt[GCNT_LAST] = {
 	[GC_GCB_SIO_CTRL] = 1,
 	[GC_HSCH_HSCH_CFG] = 1120,
 	[GC_HSCH_HSCH_DWRR] = 32,
+	[GC_HSCH_TAS_PROFILE_CFG] = 30,
 	[GC_PTP_PTP_PINS] = 8,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 8,
 	[GC_REW_PORT] = 35,
@@ -144,6 +146,7 @@ const unsigned int lan969x_gsize[GSIZE_LAST] = {
 	[GW_FDMA_FDMA] = 448,
 	[GW_GCB_CHIP_REGS] = 180,
 	[GW_HSCH_TAS_CONFIG] = 16,
+	[GW_HSCH_TAS_PROFILE_CFG] = 68,
 	[GW_PTP_PHASE_DETECTOR_CTRL] = 12,
 	[GW_QSYS_PAUSE_CFG] = 988,
 };
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
index 27d02eea7ce1..15fbfa68bc75 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
@@ -5369,6 +5369,18 @@ extern const struct sparx5_regs *regs;
 #define HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY_GET(x)\
 	FIELD_GET(HSCH_TAS_STATEMACHINE_CFG_REVISIT_DLY, x)
 
+/* HSCH:TAS_PROFILE_CFG:TAS_PROFILE_CONFIG */
+#define HSCH_TAS_PROFILE_CONFIG(g)                                             \
+	__REG(TARGET_HSCH, 0, 1, regs->gaddr[GA_HSCH_TAS_PROFILE_CFG], g,       \
+	      regs->gcnt[GC_HSCH_TAS_PROFILE_CFG],                              \
+	      regs->gsize[GW_HSCH_TAS_PROFILE_CFG], 32, 0, 1, 4)
+
+#define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED       GENMASK(10, 8)
+#define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_SET(x)\
+	FIELD_PREP(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED, x)
+#define HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_GET(x)\
+	FIELD_GET(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED, x)
+
 /* LAN969X ONLY */
 /* HSIOWRAP:XMII_CFG:XMII_CFG */
 #define HSIO_WRAP_XMII_CFG(g)                                                  \
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
index 62c49893de3c..ef06bed3a9cc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_port.c
@@ -11,6 +11,7 @@
 #include "sparx5_main_regs.h"
 #include "sparx5_main.h"
 #include "sparx5_port.h"
+#include "sparx5_qos.h"
 
 #define SPX5_ETYPE_TAG_C     0x8100
 #define SPX5_ETYPE_TAG_S     0x88a8
@@ -1050,6 +1051,9 @@ int sparx5_port_config(struct sparx5 *sparx5,
 		 sparx5,
 		 QFWD_SWITCH_PORT_MODE(port->portno));
 
+	/* Notify TAS about the speed. */
+	sparx5_tas_speed(port, conf->speed);
+
 	/* Save the new values */
 	port->conf = *conf;
 
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
index e580670f3992..972da8a71f5a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.c
@@ -9,6 +9,17 @@
 #include "sparx5_main.h"
 #include "sparx5_qos.h"
 
+enum sparx5_tas_link_speed {
+	TAS_SPEED_NO_GB,
+	TAS_SPEED_10,
+	TAS_SPEED_100,
+	TAS_SPEED_1000,
+	TAS_SPEED_2500,
+	TAS_SPEED_5000,
+	TAS_SPEED_10000,
+	TAS_SPEED_25000,
+};
+
 /* Calculate new base_time based on cycle_time.
  *
  * The hardware requires a base_time that is always in the future.
@@ -581,3 +592,41 @@ int sparx5_tc_ets_del(struct sparx5_port *port)
 
 	return sparx5_dwrr_conf_set(port, &dwrr);
 }
+
+void sparx5_tas_speed(struct sparx5_port *port, int speed)
+{
+	struct sparx5 *sparx5 = port->sparx5;
+	u8 spd;
+
+	switch (speed) {
+	case SPEED_10:
+		spd = TAS_SPEED_10;
+		break;
+	case SPEED_100:
+		spd = TAS_SPEED_100;
+		break;
+	case SPEED_1000:
+		spd = TAS_SPEED_1000;
+		break;
+	case SPEED_2500:
+		spd = TAS_SPEED_2500;
+		break;
+	case SPEED_5000:
+		spd = TAS_SPEED_5000;
+		break;
+	case SPEED_10000:
+		spd = TAS_SPEED_10000;
+		break;
+	case SPEED_25000:
+		spd = TAS_SPEED_25000;
+		break;
+	default:
+		netdev_err(port->ndev, "TAS: Unsupported speed: %d\n", speed);
+		return;
+	}
+
+	spx5_rmw(HSCH_TAS_PROFILE_CONFIG_LINK_SPEED_SET(spd),
+		 HSCH_TAS_PROFILE_CONFIG_LINK_SPEED,
+		 sparx5,
+		 HSCH_TAS_PROFILE_CONFIG(port->portno));
+}
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
index 04f76f1e23f6..a92a699c551f 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_qos.h
@@ -60,6 +60,7 @@ struct sparx5_dwrr {
 };
 
 int sparx5_qos_init(struct sparx5 *sparx5);
+void sparx5_tas_speed(struct sparx5_port *port, int speed);
 
 /* Multi-Queue Priority */
 int sparx5_tc_mqprio_add(struct net_device *ndev, u8 num_tc);
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
index 220e81b714d4..3863f954bd83 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.c
@@ -95,6 +95,7 @@ const unsigned int sparx5_gaddr[GADDR_LAST] = {
 	[GA_HSCH_SYSTEM] = 184000,
 	[GA_HSCH_MMGT] = 162368,
 	[GA_HSCH_TAS_CONFIG] = 162384,
+	[GA_HSCH_TAS_PROFILE_CFG] = 188416,
 	[GA_PTP_PTP_CFG] = 320,
 	[GA_PTP_PTP_TOD_DOMAINS] = 336,
 	[GA_PTP_PHASE_DETECTOR_CTRL] = 420,
@@ -129,6 +130,7 @@ const unsigned int sparx5_gcnt[GCNT_LAST] = {
 	[GC_GCB_SIO_CTRL] = 3,
 	[GC_HSCH_HSCH_CFG] = 5040,
 	[GC_HSCH_HSCH_DWRR] = 72,
+	[GC_HSCH_TAS_PROFILE_CFG] = 100,
 	[GC_PTP_PTP_PINS] = 5,
 	[GC_PTP_PHASE_DETECTOR_CTRL] = 5,
 	[GC_REW_PORT] = 70,
@@ -144,6 +146,7 @@ const unsigned int sparx5_gsize[GSIZE_LAST] = {
 	[GW_FDMA_FDMA] = 428,
 	[GW_GCB_CHIP_REGS] = 424,
 	[GW_HSCH_TAS_CONFIG] = 12,
+	[GW_HSCH_TAS_PROFILE_CFG] = 64,
 	[GW_PTP_PHASE_DETECTOR_CTRL] = 8,
 	[GW_QSYS_PAUSE_CFG] = 1128,
 };
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
index ea28130c2341..585589a31e90 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_regs.h
@@ -104,6 +104,7 @@ enum sparx5_gaddr_enum {
 	GA_HSCH_SYSTEM,
 	GA_HSCH_MMGT,
 	GA_HSCH_TAS_CONFIG,
+	GA_HSCH_TAS_PROFILE_CFG,
 	GA_PTP_PTP_CFG,
 	GA_PTP_PTP_TOD_DOMAINS,
 	GA_PTP_PHASE_DETECTOR_CTRL,
@@ -139,6 +140,7 @@ enum sparx5_gcnt_enum {
 	GC_GCB_SIO_CTRL,
 	GC_HSCH_HSCH_CFG,
 	GC_HSCH_HSCH_DWRR,
+	GC_HSCH_TAS_PROFILE_CFG,
 	GC_PTP_PTP_PINS,
 	GC_PTP_PHASE_DETECTOR_CTRL,
 	GC_REW_PORT,
@@ -155,6 +157,7 @@ enum sparx5_gsize_enum {
 	GW_FDMA_FDMA,
 	GW_GCB_CHIP_REGS,
 	GW_HSCH_TAS_CONFIG,
+	GW_HSCH_TAS_PROFILE_CFG,
 	GW_PTP_PHASE_DETECTOR_CTRL,
 	GW_QSYS_PAUSE_CFG,
 	GSIZE_LAST,
-- 
2.55.0


