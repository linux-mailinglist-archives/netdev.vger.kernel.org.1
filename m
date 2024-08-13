Return-Path: <netdev+bounces-118091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168D950793
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E2C1C21F46
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E7919EEC8;
	Tue, 13 Aug 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0WfIQc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25D19E83D;
	Tue, 13 Aug 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559316; cv=none; b=tnvMzWuCE++x4hEZ8U6o5fM6LOoHetM+wf1AzbZ8buQnOuI8b/9RgGdC0z1/vRfjPVEvwGNnEGFT9zvnukwzwLZGqZ0fBINbgf+YstgsR4Qrxq5apnAoVAsj9gSStZztJoXBNg9p6Fzq+0gQhMfZ83MMhBac8aKL3JXVR11N7Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559316; c=relaxed/simple;
	bh=Dl2XlbH7I+RV5d1Dk9ofxgBFzl7ct+AQ/da3g5ataGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcS2UBVRsx2eiXAWvX4ThJy9wXiqCjGCjAc/qU9KGmyTUofcp8YakHJ61+2rch0o5XNhZwRpT1QRtEL1UEbU9LSnHkpll5ed6snBhvBcfAVnYF/dUBbhT+8BSmjde5bKJ61LrdgvfiGshd2BMrDhWzP0e7wV4l0Z/n+0prwpXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0WfIQc9; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efa16aad9so7267125e87.0;
        Tue, 13 Aug 2024 07:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723559312; x=1724164112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH9A5Szkc/IlyuIN03/o/3XyWT9l7X0+GSlwBPiML/U=;
        b=J0WfIQc9b4jEDgASe2JiOFqve6Yu/tl6qYH/PXLUPovxZZav+Wmr0JsBXPEwHRrKAz
         zbt3mlLUjqUyV+HSo+QkyaFRwQEGcj0W+h77ItEuUDynLbag03Xie9laYVD8iQpHedo/
         rtq/JMP1RyyJAPRfu7nx49dG+ii6NYsxqqKj+Z1iDhrsdwLqgBpMl1RARBLc3rwO8Jm2
         qUfUZQEecs2/oxu6SlEatGpWOBC6ghv/2lm1Gw4Jsd5WwtFsly8NhMQ9uySuSI2n2Bka
         27JNCs/IOtffkUtoOngyBBBB2S1TiF3ngBJSI0DIsDkuKoxPu/f91kYI/u5cX/cv/xhy
         APFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559312; x=1724164112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hH9A5Szkc/IlyuIN03/o/3XyWT9l7X0+GSlwBPiML/U=;
        b=RyGPgOvVWesFBU34lGMEZMPz2BVeGmXTAPG5HveuF5YtDxj8WIZDo4wgDoeIhJRGu5
         sqcl7bGDn4vTqnxXpUHXyE3k6BJ0UFq/iZsL5T3GlbYL85opeB9uUsDTFlBis4xqY7Is
         ixQ9bodbKYuXVamHa+7vgYS48b0/xnVBV8hHKNDjFiaQczf39kP+stHmcF2xGjbklTYu
         kmqRunbBGbF/PXvrT5DAREqt1jgp+760QDhIOuZBLPph6Iay9wzbmQm7lsTMGfYERHui
         qGaxUvZwAsgCpbT6PvJhIXcebFz2ciaIF6l2yP3eXSRbnAPTpVAGl3DvwUDKvGtpsmbt
         fo0w==
X-Forwarded-Encrypted: i=1; AJvYcCXj1ttchYIK3he0RORvqwjxQCRdiQH2axOnLOfzLY1Ez5kfU+H03ZF4J76ezXh+vMxurSU6B1jie1JYK33Q9vSx9pK647BoTrWxG1QOTxITUzvXnreOuCoV0F7grsgxRJLnBc/Es4o2O5zjPVIK64dcfJUwPBlPHgevpEa1ahliQg==
X-Gm-Message-State: AOJu0Yz8N7pQOEjPzyfyRl/y70KWjJfjqzjlqWPF3XdxfS9lBp2zuxMB
	RAmmb0tJpFzDKI451TJKtvCy2Qoslbn2U/9xOXzaRUuxPd81x3i8
X-Google-Smtp-Source: AGHT+IG39YK0aR2tCjBu623dnSdp6lDNkQzwjk6JyWm7+BSt9km+iWXJTeMzJHGFWFDy2QTXo0scuQ==
X-Received: by 2002:a05:6512:12d5:b0:52e:be1f:bf84 with SMTP id 2adb3069b0e04-532136a4a20mr2999994e87.53.1723559311932;
        Tue, 13 Aug 2024 07:28:31 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3fa7c27sm74345166b.66.2024.08.13.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 07:28:31 -0700 (PDT)
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
	Pieter Van Trappen <pieter.van.trappen@cern.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Subject: [PATCH net-next v6 5/6] net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
Date: Tue, 13 Aug 2024 16:27:39 +0200
Message-ID: <20240813142750.772781-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813142750.772781-1-vtpieter@gmail.com>
References: <20240813142750.772781-1-vtpieter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pieter Van Trappen <pieter.van.trappen@cern.ch>

The KSZ87xx switches have 32 static MAC address table entries and not
8. This fixes -ENOSPC non-critical errors from ksz8_add_sta_mac when
configured as a bridge.

Add a new ksz87xx_dev_ops structure to be able to use the
ksz_r_mib_stat64 pointer for this family; this corrects a wrong
mib->counters cast to ksz88xx_stats_raw. This fixes iproute2
statistics. Rename ksz8_dev_ops structure to ksz88x3_dev_ops, in line
with ksz_is_* naming conventions from ksz_common.h.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 51 ++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3f3230d181d8..cd3991792b69 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -277,7 +277,7 @@ static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_link_up	= ksz8_phylink_mac_link_up,
 };
 
-static const struct ksz_dev_ops ksz8_dev_ops = {
+static const struct ksz_dev_ops ksz88x3_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
 	.cfg_port_member = ksz8_cfg_port_member,
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
@@ -1362,7 +1397,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.port_cnt = 3,
 		.num_tx_queues = 4,
 		.num_ipms = 4,
-		.ops = &ksz8_dev_ops,
+		.ops = &ksz88x3_dev_ops,
 		.phylink_mac_ops = &ksz8830_phylink_mac_ops,
 		.mib_names = ksz88xx_mib_names,
 		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
-- 
2.43.0


