Return-Path: <netdev+bounces-248042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7005D026DC
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 12:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F3CB32A0027
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE74A3A50;
	Thu,  8 Jan 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LSNy5RUW"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034C64A340E;
	Thu,  8 Jan 2026 10:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869746; cv=none; b=kAjvzjaHknSqnxHtGzU/m7JHh7MkNl+8+tM6JhKPuiAijzMr/BhiYQcbuMuWKRzlApR/vluR3Xid1C14RDAC+CR0Zm1dQBZih0R9H93T6/NeuzZXf6j0lmvJD18BeBKsP0/wGGe05pmmj9tQuzok4J+uMrhaswvlBuie2Jqiup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869746; c=relaxed/simple;
	bh=CMHw5DVfJXuTHlKA1vYZRXcYoK6WVCIZRW+YpFHJDKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oh0qmdcl+AvjeVQcyGH8ElVZ27RJRcb1lj6G+VuKprzHTABq/yuwCdRfQPD4ZU2kY9gMuZAar1bPRySMNcKiE4pa7thC0SSpqxvKwrEDPg+Z8wfaXqL9xiDrVX3gdilX/Jn+GxFCDp4nusC74oQPcThzH25nWzCmiSpGY2+Lb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LSNy5RUW; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6B
	x/uBoRw2LaNn4oI17UqZrmd/+0o1xj0zRiwIVURNk=; b=LSNy5RUWIF5JMTqzzU
	H7aEcuFI6pUxe17aBdf06ze43FCCxKPOEcfYO+PqRf6qFANEy+Evl/YLP2SQPu4S
	2M1/eCM3EFUqS5siVuyjhtcsTw0yCB/cKpDJxXpW6b82lulMcJR741mhM+yQd+uG
	G06UbvG2RMeFu34oAyd8S1md4=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBnDLTojF9pnbalKQ--.33395S2;
	Thu, 08 Jan 2026 18:54:36 +0800 (CST)
From: "wanquan.zhong" <zwq2226404116@163.com>
To: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com
Cc: netdev@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	"wanquan.zhong" <wanquan.zhong@fibocom.com>
Subject: [PATCH] wwan: t7xx: Add CONFIG_WWAN_DEBUG_PORTS to control ADB debug port
Date: Thu,  8 Jan 2026 18:54:25 +0800
Message-ID: <20260108105425.601842-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBnDLTojF9pnbalKQ--.33395S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3tFWxuF18AF43Cw4kJFb_yoW5Xr1kpa
	1DGa4Ykr1DJ3ZxAa18AayI9ry5AFnruFW2gry2q34Y9ryUAFy5Cr4v9FyayF15J3W7ZFyx
	A3yjgFnFgF1q9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uvg4DUUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0g2Q52lfjO0NlAAA3m

From: "wanquan.zhong" <wanquan.zhong@fibocom.com>

Add a new Kconfig option CONFIG_WWAN_DEBUG_PORTS for WWAN devices,
to conditionally enable the ADB debug port functionality. This option:
- Depends on DEBUG_FS (aligning with existing debug-related WWAN configs)
- Defaults to 'n' (disabled by default for user devices)
- Requires EXPERT to be visible (to avoid accidental enablement)

In t7xx_port_proxy.c, wrap the ADB port configuration struct with
CONFIG_WWAN_DEBUG_PORTS, so the port is only exposed when
the config is explicitly enabled (e.g. for lab debugging scenarios).

This aligns with security best practices of restricting debug interfaces
on production user devices, while retaining access for development.

Signed-off-by: wanquan.zhong <wanquan.zhong@fibocom.com>
---
 drivers/net/wwan/Kconfig                | 11 +++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c |  2 ++
 2 files changed, 13 insertions(+)
 mode change 100644 => 100755 drivers/net/wwan/Kconfig
 mode change 100644 => 100755 drivers/net/wwan/t7xx/t7xx_port_proxy.c

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
old mode 100644
new mode 100755
index 410b0245114e..70edfd0c03bb
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -27,6 +27,17 @@ config WWAN_DEBUGFS
 	  elements for each WWAN device in a directory that is corresponding to
 	  the device name: debugfs/wwan/wwanX.
 
+config WWAN_DEBUG_PORTS
+	bool "WWAN devices ADB debug port" if EXPERT
+	depends on DEBUG_FS
+	default n
+	help
+	  Enables ADB (Android Debug Bridge) debug port support for WWAN devices.
+
+	  If this option is selected, then the ADB debug port functionality in
+	  WWAN device drivers is enabled, allowing for Android Debug Bridge
+	  connections through WWAN modems that support this feature.
+
 config WWAN_HWSIM
 	tristate "Simulated WWAN device"
 	help
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
old mode 100644
new mode 100755
index 4fc131f9632f..23b331780f07
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -102,6 +102,7 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
 	}, {
+#ifdef CONFIG_WWAN_DEBUG_PORTS
 		.tx_ch = PORT_CH_AP_ADB_TX,
 		.rx_ch = PORT_CH_AP_ADB_RX,
 		.txq_index = Q_IDX_ADB,
@@ -112,6 +113,7 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.port_type = WWAN_PORT_ADB,
 		.debug = true,
 	}, {
+#endif
 		.tx_ch = PORT_CH_MIPC_TX,
 		.rx_ch = PORT_CH_MIPC_RX,
 		.txq_index = Q_IDX_MBIM_MIPC,
-- 
2.43.0


