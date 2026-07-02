Return-Path: <netdev+bounces-304095-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WJjUC4pDRmqKNAsAu9opvQ
	(envelope-from <netdev+bounces-304095-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:55:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7726F6425
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:55:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sartura.hr header.s=sartura header.b=mVYzt7dm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304095-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304095-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=sartura.hr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E35483467205
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B1A47D924;
	Thu,  2 Jul 2026 10:16:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4243DF001
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:15:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987362; cv=none; b=s82QgyRx8RYoob6OAFqvcEkflnsI+68NxY9P6/gxkAWt6yzIkkPyTgQ4DNGqcreITM4yi3ZyjHVXaFAGzqFH7wQQthTMhbESEeDCDDw4uFrbv0WUD6AQb25WEQKQ6NoC6i2gflhsPUbb4JiuBZ5ndqn6MZINF6ROuqlcBS7MaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987362; c=relaxed/simple;
	bh=oI9mo+kK/dY8LnNtPsTVPnaa5YkRrzSB+3UnGPD2bE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRDY7xm2NaWRT+/Uzmzl6UjhUQGxOytzzQU8DnZ+NmBSr8lWLppwG5+DYZC4q5kG869wMQtvH99iYR+wF56DhjXTQmXuucOrb3vKZRM1hK024TDY1yj3UiGcU0BFIykbBya+T+JuVyGEM3bJ6DFkCOH1mFWUOlj+DhWHCII+Yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mVYzt7dm; arc=none smtp.client-ip=209.85.128.42
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso7193065e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1782987358; x=1783592158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L2AXykctnuSwIgdCxYi80gooQQMlU2MT4Krd1IoiYwg=;
        b=mVYzt7dmHdFLxNGD+5rA9nEHFIeHTHfwogqNmMIObzrEYYlIf2on4Rhk2bnlQOKhMA
         BGlG1pu/ohDu2eA1e5BQSpMKxwZyzS1HDRczV4qyNefwrKkPomjEMh8OOvsiLHXBo9OH
         m3KaDkELgUJeJa32vXYh+32wxg5NthDo8M/T+P022O6GSx1IwHiPjfSQA2cnVzzOhjy2
         cxl19l/xob7U3DotkqI/zWaOd/qQvbwdbzlmzI0N4yH7CzHkbsIe2AEOz/wtea7VwTV6
         kRIB29EKriBqsm7fPheSUIbdZA2NJ23h1sGLAVQahzZcgulEPuOhigjS2WRuJcWeeXy6
         ILyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782987358; x=1783592158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2AXykctnuSwIgdCxYi80gooQQMlU2MT4Krd1IoiYwg=;
        b=EMqp8//c5fV90qcTy08OONOCg8vEDz1kmVb+lQdG7sEiy7AGqMAyZblZnTRwaZmaJf
         rwM1xM5uDCoxzNTA8zlfPANN8/PVEHfhfNjslaLimym01N5ooaavgQyluzkGcO2E76Db
         eG/Q+rbiShP3WhW6Jyg6HATExwkDR0RBH+5T2e5fNz3gGtGrlRgQ7iN3dWy/t8oK+fFp
         B2SImgNmudoAszkGgHVH6wY5E3ADlCP14OALsXdO3xqTbbqZduZkNrPeVo3uRMcU0RIW
         ZRI40KQA9DEnXL5PfbUQEjesAJmbNaL2smdvijkQ3zVpvos/hnqh1wYb9c6DijHEVfQQ
         5AEA==
X-Forwarded-Encrypted: i=1; AFNElJ9syGvW6KRYrrF5S9uAzV1Qye0MjvKnHXi5DhU3R20QfERgNVXzlNIQK8pM/JrV/gWVvnwv+1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDarypKq77anDtDp1zS2GL5QDrplpn+xrMHcQPRJERDnd+zpw8
	wJW4ucCzqXPvY1ADZfQaKARszVa3jiBBH5scEHtojm1Q4fFVBFkVuTT7KrthhPJ8lIU=
X-Gm-Gg: AfdE7cnhs2jwnd8lkGs4fvl1plUdANLJQ9+ExgiNLachQAyL+iznH+OF8dJQNherg/C
	64LKxyozLeRukX5cd0N5syjWO6gz4xOP04umjAFrWwZYQVOx2qDwm4RRLEjMiJIRxRlx+staKeX
	9BAQSJr0ERBMn/ziPycnj4wPS+/uL7mXhKDiQ5ZSfxG0F7TMH54+9j/1aKm25myPnmHRhHfxGoh
	X2557UMfFRu1EPDwai1MvkW8fE/3vPW5MmDGYp5r5trN0SWvDYQ2KCfQd4nHmqFPtx50Q2Oi8tQ
	6dY/QxlNq0kCryieJtMJulnk9Hm+CLejeAwSABRInGIPNtZFR4941+aixp35hSM9XQptN9U1XRG
	7RYNvCuWFzhLkauJzk7v5sn/diaqyhht8KUT91yeiXQ/WEjSUm7tbZOVoaL6xOAUxC0tKVSsz7j
	V26FyhCNf88SfWcncaGltm7SqDTeunrK1GMja2szChb9SiJ9THZhvJSe9+FYtBBSjN36Drn4JVs
	lG2vLFjYUfUdmfIFyBPPcRluB5qbqYhVP1w1T3MuuPm89hX
X-Received: by 2002:a05:600c:6296:b0:493:bd2f:c5dd with SMTP id 5b1f17b1804b1-493c2b90534mr74549765e9.21.1782987357840;
        Thu, 02 Jul 2026 03:15:57 -0700 (PDT)
Received: from threadripper-fedora-workstation (d-zg1-018.globalnet.hr. [213.149.36.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c6372c52sm38791925e9.14.2026.07.02.03.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:15:57 -0700 (PDT)
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
Subject: [RFC net-next] net: sparx5: configure TAS port link speed
Date: Thu,  2 Jul 2026 12:15:44 +0200
Message-ID: <20260702101550.189699-1-robert.marko@sartura.hr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[robert.marko@sartura.hr,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-304095-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel.machon@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:Steen.Hegelund@microchip.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:robert.marko@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,microchip-ung.github.io:url,sartura.hr:dkim,sartura.hr:email,sartura.hr:mid,sartura.hr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E7726F6425

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


