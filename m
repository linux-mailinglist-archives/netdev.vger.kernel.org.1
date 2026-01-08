Return-Path: <netdev+bounces-248072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F5FD02D9E
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEA3131066EE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 13:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021D4C5F25;
	Thu,  8 Jan 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IxuwGwLt"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251F4BCACA;
	Thu,  8 Jan 2026 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767876811; cv=none; b=h2KRQv2tE8wGs969DYOLpdQbmUiVge9U05e3YLD2FqCJtYBdwKH7h8VrXXQNVhN7/jo+NAKjVvvuqtA7Xpotu31y4sEW91MuozySoqZYuhK/8JvemtayyXSs7Y87uvFrwveJ8BL+6Ev4pqSZ3vYXyGe13qhnPcsjrR/DX1ZGayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767876811; c=relaxed/simple;
	bh=svnNRaBTJNUFwETiA1MXqP7OMWedQw2Y1M4r27+bDU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MEYmgkm+UGck0vGjBkdrppa2tVBd87kqe3uiyQo9+sv8sW8RtLQh6OXaHcpSH/6yTc1NXoSxpoFMZ09HWH3cWlKE1fDyfBSw570rXztiyKawsH4+O+USN+/W26YcH2wI24E/XmQyqKc/CDfAIwqOkjVDvNeqNBe69fGoSNwA1Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IxuwGwLt; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3k
	jFa0XAwm7NyigmEH3hAIOT6w08yI6fW8tasntTN9E=; b=IxuwGwLt5Q5wZ1C24I
	E1+eW9++wBt1jkmUT0mnx2FoQzS6hKqe+WNz40UFmKX5jZCdGblDMiPnBdg5KjKw
	60cLYFw7DsG30RuZOFybOeQ9QPOO5mz4NZbpyM1mNtPYtx0ZS/dY7gm9J2RzsYt1
	dpoYSHQo41SvwtpPbRk6BgGdI=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDHb417qF9pcLFIFg--.2964S2;
	Thu, 08 Jan 2026 20:52:13 +0800 (CST)
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
Date: Thu,  8 Jan 2026 20:52:07 +0800
Message-ID: <20260108125207.690657-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHb417qF9pcLFIFg--.2964S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww13Kr45Wr45Jrykur4rKrg_yoW5JFWfpa
	n8Ga45tr1DA3ZxAw48ZFWI9ry5CFnruFW2gryav34Y9ryUAFy5Cr4v9FyayF15J3WxXrW7
	A3yFgF1UX3Wq9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBWl9UUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC0h570mlfqH4ESgAA3L

From: "wanquan.zhong" <wanquan.zhong@fibocom.com>

Add a new Kconfig option CONFIG_WWAN_DEBUG_PORTS for WWAN devices,
to conditionally enable the ADB debug port functionality. This option:
- Depends on DEBUG_FS (aligning with existing debug-related WWAN configs)
- Defaults to 'y',If default to n, it may cause difficulties for t7xx
debugging
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

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..0ab8122efd76 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -27,6 +27,17 @@ config WWAN_DEBUGFS
 	  elements for each WWAN device in a directory that is corresponding to
 	  the device name: debugfs/wwan/wwanX.
 
+config WWAN_DEBUG_PORTS
+	bool "WWAN devices ADB debug port" if EXPERT
+	depends on DEBUG_FS
+	default y
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
index 4fc131f9632f..23b331780f07 100644
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


