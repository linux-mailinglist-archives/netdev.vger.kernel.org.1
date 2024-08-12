Return-Path: <netdev+bounces-117765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F25AC94F1BC
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73EF61F246C6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DC1184558;
	Mon, 12 Aug 2024 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgMn7bdZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C618756D;
	Mon, 12 Aug 2024 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723476650; cv=none; b=L/uxF7M6oi8M8jiiHfjmQ87mSeckJVSNwcPy9mc/cbMopM4leGVNg0ILoeU7CmvMTzOeo3HMy8A+Wg9zSAotKy7WlzD+sTFhYDduFfkGfFGZeZS6Ep7G3urJ7fy5LVRw/oYC2oW2x8lz4FXqDj5/IUG+/Inu8gITT0PmhxJ73Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723476650; c=relaxed/simple;
	bh=YN4VF9eogqlyEemrlDUeUUfXNQS8CprZhceY24IX5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2Tmc9b4CZAno5/jzN3BCNvZs3Sr1/O1qng31GeOZLP/NVgz++KyGoZE7QHJ6winUr0yoaCdgiEepJnvbDk3bsyfWTDsKbJe/tg8OWJfC9nEIYrC7v0vcjk9UgJrDtC0jm8JbutpCUlvlq9Nv6qEzDNkk90ea2xxTuyigTta+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgMn7bdZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so4681328a12.3;
        Mon, 12 Aug 2024 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723476647; x=1724081447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLmRpZ1aG/lzex3h1BqdyLB+WcZHwCjcjuUeIyDowBA=;
        b=MgMn7bdZpqjEE9Ln3DTgqapiObVfaRhhwF0VGxUXAxgrAi5B/XYzzyGHgihgRkJUMh
         qIxYKsROMhXq7C8rjrYV0GK+R0WY1oUgtEPaR3ddGaB2nYQspC2jMUxM1VwL0cNm5XsZ
         N8HrRPkd+k9oD0guFfNCo3GfTWbb0T/4DNp0C83oWkg8y6sGOt26PSlnPlbXg/o7RRqP
         qNKYJk8z7vkl03+PwKWMkwr7Au+SW2n5q7rmQ2k3jVZ/lqkQde4sWeob6nuXT86Ue/aO
         bCgIPE0DEYwUMY4kmwMve8ayCd/6F5ACw1OjnDsY7KDor/TxlgOEJeAc4jcez5jMWHzr
         MB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723476647; x=1724081447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLmRpZ1aG/lzex3h1BqdyLB+WcZHwCjcjuUeIyDowBA=;
        b=D3AbvfjBQu9foLMZzCU3LW2rYJGtPwLcPScM+UHuAW3zKdj234gk2qMwB27xIlHkYZ
         SoZMK+Pg/sMe9u+29t3IoPbdFT9ysQRZPsno87TYUBGtNO68KwO1LhX+y1Wq5o7UuF3V
         dhvwKmGzYylTBVadX7JAsGo3DaTT3ElgizAsHBmlyJpJzpTwPw7w+0cgUKOu2xFpX2o/
         8jTTwBSQrxxFfyR1IWcoOKN7PTnGwU5UwHJ87vDgwx/QJSY5RtCEnMS7QSTbMCxug68v
         BgK0QQ9/LDb0FYq2M0ZPP9H6HQJl18xbXbTApNOMI+5eaBgDchefLwtWVIfnsI3bh+yd
         /vFg==
X-Forwarded-Encrypted: i=1; AJvYcCUGyhTUwIHc9RvAOqukpQYtqdqcAw804pSN8qWDJZyqDtgALTrfIUHhycg/NpDCFQ4h6lVZd2q2RY1fvWzZRY7vXVZQXgiCDIpbRzDoFPCwOrKQhLNIzWcZHDEUp2MfuWpmuR1rZtTIOcXPsLrYEjP/nlXct+TGSfgpu/541RGgpg==
X-Gm-Message-State: AOJu0YzBwxHAyotQgJA0gTcdxcTZs3+IRcGthGWrmH8qYdddqCNdsOfL
	JUdP78Y9K2Oqo3xCLOXf6SLm+SxQbLkD4Thotx2gGsWpvk+F/fej
X-Google-Smtp-Source: AGHT+IEnTXS7AVSc649zDQ+487fyDcpGFVy2Df4beudLFabvjF2dpgvjXDR8HEvOKyWMW9xzs5UYHg==
X-Received: by 2002:a05:6402:3587:b0:5bb:9ae0:4a46 with SMTP id 4fb4d7f45d1cf-5bd44c0cff8mr579891a12.5.1723476646900;
        Mon, 12 Aug 2024 08:30:46 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a666fsm2192535a12.46.2024.08.12.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:30:46 -0700 (PDT)
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
Subject: [PATCH net-next v5 5/6] net: dsa: microchip: fix KSZ87xx family structure wrt the datasheet
Date: Mon, 12 Aug 2024 17:29:56 +0200
Message-ID: <20240812153015.653044-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812153015.653044-1-vtpieter@gmail.com>
References: <20240812153015.653044-1-vtpieter@gmail.com>
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


