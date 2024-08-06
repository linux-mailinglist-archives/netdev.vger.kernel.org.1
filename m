Return-Path: <netdev+bounces-116100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E311949177
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAB1C23ADE
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C41D61B3;
	Tue,  6 Aug 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIdxqp1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F31D2F4E;
	Tue,  6 Aug 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950936; cv=none; b=ivKW+jfFJz586pUDthyeIZlrRtC/y0LnUyN6lrXp23VyCMZjsH9OabVXmIHR27oqWdE2UujJoE78ZMYWskAhfxmBOJE9WKgAQumUWfgoyyukzI3V+RsYIVGoPbXkLLcwk3ocndVjdFPFzyXoFSwKvPE+CY9kUrpiTOBFFBnP/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950936; c=relaxed/simple;
	bh=Oy5VK+J9SJzFKJSgznA+kp9C9cF+F9I7pfuj42UXu6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liFrpEkBB8QskIifBHCKIAkJHE0MlGDzpmahCQ84Lr8kQskKTQNOpNwzLmPSPNyWBZw9S1TI25blHBrEggGUMbiojsKSbsrfiBr1RSoGW3RpQOBmx8J7sgYQFjiAq9VY0zIP6KyeZQNA1a2Tb7hG1GBvdBLhgCKZq8+SGSvjaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIdxqp1N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b7b6a30454so1008481a12.2;
        Tue, 06 Aug 2024 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722950933; x=1723555733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w49WuvPRHENEHIOBXjssOrgW46Ua4jNhfekHObaq3gM=;
        b=eIdxqp1Nno7bRCkExM1tPO9zw7R5TrjXDK/scjolfVyVquWLkTtBGGDziKkq/MMeDd
         MH46IPg2hVD2D1n9MJQSjUX95Rfr61Mns6q8mq20JFrXznucPa8G8k3xUgI1RfYAoM5H
         VgxT1Av8CxK9Br4UFLPGni6JojEOrsJQltVDD9zC9Q8B61xMncDnWISoL1TTczvS1bs2
         QcmZIRorHoK645Ks0LiSk4des+W6C49ENFDjrLYlFaMLErq1PofMcYqL0LBsEZMxH5LD
         lIe4z45jpebnvL61gpmb+dT9m8lLS3ULBhVTzCwkfoHr2eVaOpjWcrRgwZ2wuvLB7W0O
         KhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950933; x=1723555733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w49WuvPRHENEHIOBXjssOrgW46Ua4jNhfekHObaq3gM=;
        b=IZ2S7s4S229sXVXC6lcCmAqCdtz0ZmoghlJ2wp4SSuvCVSoQhQkWItcCyydZA5VfxY
         xBL7xUqTCfy2xGYDZVxN0Bj0VEz0NqIMQFVzzjOaxjhEnqA0UsCbVkbOg11SBOPyUFHQ
         ibKIj0V0OCZjNCz/hY/gHn55BmKMgtUVD/n+Fh5tqD0nU/affqC3hQgpkbtGUQF3wbPw
         qxRwqQ0wIthg08ktRZ0YknjSDlCCSkU/slsq2AA1spdaKsoQzJeVWPbyHk4AR7tmnkc9
         auXnMzKekIcOLQVdBv5WlEIH5dZ7J8Q8isLGt0Mpsj91rMJMIr1JIX2f1pZdtfRTgP6q
         vV7w==
X-Forwarded-Encrypted: i=1; AJvYcCWn2qQ5loNHlqp+t8R175kdtFQZR7KovBrxD7jGGmsxa4wGguDYNYmwEk4VPYKH6b9MMWTx3AicN7eIfTzlI6QcQH9yGo1BjfuCWr3d4BM2zbM4enP8JAEqGvak0eUZx/ullTyV6yXd2LThFGO2tpKM6f+h3mtKb+m7tr24K/JqBg==
X-Gm-Message-State: AOJu0YwCJiqM5+vrXb6mYaYA1C8hSFyh0bJRrse9o3Rny9EqpbT9Ez31
	2uVc8fZL/x+nlXLGDzkgWXFcwzXUSo9NadrOddHsRhJZOCFWE9Qj
X-Google-Smtp-Source: AGHT+IGxV+ISuGgORGRSPMwY7Nw46x5tF8+NUOXAr5pk0dni48nHLr/FmB62p3Ie8N8c7CQuNmEZTw==
X-Received: by 2002:a05:6402:1244:b0:5a1:225b:4233 with SMTP id 4fb4d7f45d1cf-5b7f531468amr10906863a12.23.1722950932990;
        Tue, 06 Aug 2024 06:28:52 -0700 (PDT)
Received: from lapsy144.cern.ch ([2001:1458:204:1::102:a6a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83a153f77sm5910172a12.53.2024.08.06.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:28:52 -0700 (PDT)
From: vtpieter@gmail.com
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	David S Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marex@denx.de>,
	Russell King <linux@armlinux.org.uk>
Cc: Woojung Huh <Woojung.Huh@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Subject: [PATCH net-next v3 5/5] net: dsa: microchip: apply KSZ87xx family fixes wrt datasheet
Date: Tue,  6 Aug 2024 15:25:57 +0200
Message-ID: <20240806132606.1438953-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806132606.1438953-1-vtpieter@gmail.com>
References: <20240806132606.1438953-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The KSZ87xx switches have 32 entries and not 8. This fixes -ENOSPC
errors from ksz8_add_sta_mac when configured as a bridge.

Add a new ksz87xx_dev_ops structure to be able to use the
ksz_r_mib_stat64 pointer for this family; this corrects a wrong
mib->counters cast to ksz88xx_stats_raw. This fixes iproute2
statistics.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz_common.c | 47 ++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c2079e39fbd5..dd141a31b26d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -312,6 +312,41 @@ static const struct ksz_dev_ops ksz8_dev_ops = {
 	.pme_pwrite8 = ksz8_pme_pwrite8,
 };
 
+static const struct ksz_dev_ops ksz87xx_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8_r_phy,
+	.w_phy = ksz8_w_phy,
+	.r_mib_cnt = ksz8_r_mib_cnt,
+	.r_mib_pkt = ksz8_r_mib_pkt,
+	.r_mib_stat64 = ksz_r_mib_stats64,
+	.freeze_mib = ksz8_freeze_mib,
+	.port_init_cnt = ksz8_port_init_cnt,
+	.fdb_dump = ksz8_fdb_dump,
+	.fdb_add = ksz8_fdb_add,
+	.fdb_del = ksz8_fdb_del,
+	.mdb_add = ksz8_mdb_add,
+	.mdb_del = ksz8_mdb_del,
+	.vlan_filtering = ksz8_port_vlan_filtering,
+	.vlan_add = ksz8_port_vlan_add,
+	.vlan_del = ksz8_port_vlan_del,
+	.mirror_add = ksz8_port_mirror_add,
+	.mirror_del = ksz8_port_mirror_del,
+	.get_caps = ksz8_get_caps,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+	.change_mtu = ksz8_change_mtu,
+	.pme_write8 = ksz8_pme_write8,
+	.pme_pread8 = ksz8_pme_pread8,
+	.pme_pwrite8 = ksz8_pme_pwrite8,
+};
+
 static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 					struct phy_device *phydev,
 					unsigned int mode,
@@ -1262,12 +1297,12 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.dev_name = "KSZ8795",
 		.num_vlans = 4096,
 		.num_alus = 0,
-		.num_statics = 8,
+		.num_statics = 32,
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.num_ipms = 4,
-		.ops = &ksz8_dev_ops,
+		.ops = &ksz87xx_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1303,12 +1338,12 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.dev_name = "KSZ8794",
 		.num_vlans = 4096,
 		.num_alus = 0,
-		.num_statics = 8,
+		.num_statics = 32,
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.num_ipms = 4,
-		.ops = &ksz8_dev_ops,
+		.ops = &ksz87xx_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
@@ -1330,12 +1365,12 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.dev_name = "KSZ8765",
 		.num_vlans = 4096,
 		.num_alus = 0,
-		.num_statics = 8,
+		.num_statics = 32,
 		.cpu_ports = 0x10,	/* can be configured as cpu port */
 		.port_cnt = 5,		/* total cpu and user ports */
 		.num_tx_queues = 4,
 		.num_ipms = 4,
-		.ops = &ksz8_dev_ops,
+		.ops = &ksz87xx_dev_ops,
 		.phylink_mac_ops = &ksz8_phylink_mac_ops,
 		.ksz87xx_eee_link_erratum = true,
 		.mib_names = ksz9477_mib_names,
-- 
2.43.0


