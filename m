Return-Path: <netdev+bounces-117617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C981194E8F0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEC1D1C21645
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590D16DEA3;
	Mon, 12 Aug 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH4HDJdA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193616DEAA;
	Mon, 12 Aug 2024 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452684; cv=none; b=MEPHthlhc7XH/YK4YpNO7b5wZ5C5wCrIe5MMcHlF+lP+uOs2IYMS+2JWg/x3VNgnOjwJzg8iVf+bRVoYgbzi89qGJEtm0Ol5HkIXuBoC81n0oDOV9Y8lxrTIqbV5GkXJhtG4A3tgcqFRiuO2THhnVKMjVCQx1T3WHy9yQpQDkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452684; c=relaxed/simple;
	bh=nFEnDoSdVTo4lzMLYHEaOnWJFN+6tarTe+JLia11nOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJSVuuAuM/f2MzTGcJ0hzpJnAldE5e50wdMm7FpOnqlteQcqMy8L02y/TZgi1EQttXMKIjZoZS+0JtxmVvKwioX/5KFtNaJ5JiuIIBl57h/hAPB5+rpDmEWrCYn7lPkMDd13yv+1aRcRO15c3mAUG+e6IXo9c1TiGLb65qN8lDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH4HDJdA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so4884888a12.2;
        Mon, 12 Aug 2024 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452681; x=1724057481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCfmZ4fWtBZIWANIT9oaDcYlZvEgthqm6GmK6t7+ids=;
        b=JH4HDJdAN0L4EAhZg0+IwBaPauwRAlhQ67TO0Fe1KL8AJmGc+38e8uTpTGgtbz6nKh
         +GBq9e0xjroW8Du2uBrARb9GGOeaESJZqXUky8OEpSein6iiU/D2EBJCUNVNrus5q5lQ
         QDLhizGfqxVVK2Pjm6VKcRd/pL3wRF5xXxv0tkQOFM2YMXe50z5fHXxQi3xqXovToaGj
         Bd3rdq30y6pJXA8GAqf5v+OHqtPdpalX8nuBa3YnhNdflDibYE8bwQlk88CDaTJfNZPb
         +TfnB66UMVSojIw7gjnH687RIr4ocXrqv5butCs9nddgnnRDlauQdwriNv0Hbi5RNQPo
         K8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452681; x=1724057481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCfmZ4fWtBZIWANIT9oaDcYlZvEgthqm6GmK6t7+ids=;
        b=mqgdBOZXwlSHPFM2erwe0fRBm71StMn5WdTq0b/RgH3ieUOuDVuLCUKRPpXUiRGBh8
         uiMvFkcwCNEtS/cwe6zxtGgPuBrmRDe06rRY+HheI+cy2Bs/LLGiSTzoU7BAXi9Un+D0
         s5OcB7HPLFQthrkH5fQT7zQ4xCFDr4yscITHpsXjyRbnDI9IPZpJZFpzojpt6CiWy4Wo
         TJUlnsRh1nj31wth950yGx2W3GUwcfi/q+TqRW0mLkGRScdb6ywAap4/bpkD0HRmt/2o
         TlhnLpEARrk2abzJ6A4wa72eP+6jPbH/93MXL+I7lTGLa/70txSUEQrC2dTvOoXNPsq7
         5UCA==
X-Forwarded-Encrypted: i=1; AJvYcCXdh8rHs8fSCDcHo1N8gm5vshXkiL6OiGhl1rvNd2hcmGsJHRzmU2CAklb8/nzZCZtNowGRmypI6hDlVotRroL1K3cRUiPpLYDVAZkUvdui9N1LXullbCQ+/7BFuWh1rGGFpnXR5fsi8p6tVz1wMYdfUeLMiAvMMC2HZ+mdMPLbUA==
X-Gm-Message-State: AOJu0YzMbdPLdkxKYL2ODcSStxCu7dAwxzyg1LCH98d8ODApfJemZS+5
	7PMDIuhqQ70nbguUoSTWthgF1Pk89ymOeClnJ6ayrAzwiHL49Ezc
X-Google-Smtp-Source: AGHT+IGp6x2YaGrS4Z1BAvHuDLKBmlWiI5u/tEqLJZOWYC1JTJQJ40uHnZLg9oYh/SIQIIAVUE8EiA==
X-Received: by 2002:a05:6402:90e:b0:59e:65d1:a56b with SMTP id 4fb4d7f45d1cf-5bd0a6668camr7573182a12.34.1723452680593;
        Mon, 12 Aug 2024 01:51:20 -0700 (PDT)
Received: from lapsy144.cern.ch (lapsy144.ipv6.cern.ch. [2001:1458:202:99::100:4b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f517dsm2094761a12.4.2024.08.12.01.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 01:51:20 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/5] net: dsa: microchip: apply KSZ87xx family fixes wrt datasheet
Date: Mon, 12 Aug 2024 10:49:36 +0200
Message-ID: <20240812084945.578993-6-vtpieter@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812084945.578993-1-vtpieter@gmail.com>
References: <20240812084945.578993-1-vtpieter@gmail.com>
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

Fix the tag_ksz egress mask, the port is encoded in the two and not
three LSB. This fix is for completeness, bit 2 must be 0 in most if
not all cases because it works without it for the KSZ8794.

Signed-off-by: Pieter Van Trappen <pieter.van.trappen@cern.ch>
---
 drivers/net/dsa/microchip/ksz_common.c | 51 ++++++++++++++++++++++----
 net/dsa/tag_ksz.c                      |  2 +-
 2 files changed, 44 insertions(+), 9 deletions(-)

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
diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index ee7b272ab715..a0f9965de027 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -141,7 +141,7 @@ static struct sk_buff *ksz8795_rcv(struct sk_buff *skb, struct net_device *dev)
 {
 	u8 *tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
 
-	return ksz_common_rcv(skb, dev, tag[0] & 7, KSZ_EGRESS_TAG_LEN);
+	return ksz_common_rcv(skb, dev, tag[0] & 3, KSZ_EGRESS_TAG_LEN);
 }
 
 static const struct dsa_device_ops ksz8795_netdev_ops = {
-- 
2.43.0


