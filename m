Return-Path: <netdev+bounces-249774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB24D1DBDC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF7FA301E9AD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFCC37F734;
	Wed, 14 Jan 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YlEQUMZc"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CF381703;
	Wed, 14 Jan 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384551; cv=none; b=Zs2pTA7MbCSeW06WEiAFbaBoew4l/Ln8DnIR3bkL4Czz6gpTbCLyhIzk9C/wBvB0DtJ43D5piQ+jozPwbIQj1k+TtXvA8DL28z0rbVqdZEe2VWWjD7Pm6a3dJZI/cjJRxOlbuhKfsvleiPo6npAlwvEsRu37JBxFMAicJuikEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384551; c=relaxed/simple;
	bh=qL2qbGb6r3753bd2rOjt8l7/sBAj0eVAiydCbqTkA/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmaXUeLCjV1dojYcQUZoj0B8NDwmhgCts9tTmme/r1EtR3k2VIFeZFphkFmk4L+/fILP+KgAGVwSebF/qf1/o6wxx3ZcVHMLm/54FYYpJo+a+wSnl7nuiwHAnQkePcS+h6r1cT0Vm3rzsc1WItmNl6Q0P9QKaEXj51N6RUsyay4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YlEQUMZc; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=z1
	6dwRbADXgtI/mf09Lm83CXWp7hCTPbP6RmhMcW3ZE=; b=YlEQUMZcz/+NNwdD4Z
	YYFVGJLT/oEspTPWDBf0g3KGSG+/yQtYmVEz9jFUGFvk0zd146fMu2fgkXxxGotA
	Zxjy+2JRaxEMJWwBRjA0XX1o23FGqizVbnQGhxq9/ZzPJ0sLBNM/VUF0k9ZaY+wq
	f6sYM0iiuE5NPZTtf2J1KKVog=
Received: from GHT-5854251031.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAH54jfZ2dpprqHFw--.18602S2;
	Wed, 14 Jan 2026 17:54:49 +0800 (CST)
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
Subject: [PATCH] [PATCH v2] wwan: t7xx: Add CONFIG_WWAN_ADB_PORT to control ADB debug port
Date: Wed, 14 Jan 2026 17:54:34 +0800
Message-ID: <20260114095434.148984-1-zwq2226404116@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH54jfZ2dpprqHFw--.18602S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArWxZF17Xw1xAr4rXw18Xwb_yoW5AF18pa
	n8Ja4YkFyDA3ZxJw4UZFWIgFy5A3ZruFW3Kr12y34Y934YyFy5Crs2va4ayF15JFnxXFWI
	yrW2qFyUW3Wq9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UvZXwUUUUU=
X-CM-SenderInfo: h2ztjjaswuikqrrwqiywtou0bp/xtbC9AlIn2lnZ+mD3AAA31

From: "wanquan.zhong" <wanquan.zhong@fibocom.com>

Add a new Kconfig option for MediaTek T7xx WWAN devices, to
conditionally enable the ADB debug port functionality. This option:
- Depends on MTK_T7XX (specific to MediaTek T7xx devices)
- Defaults to 'y', as disabling it may cause difficulties for T7xx
debugging
- Requires EXPERT to be visible (to avoid accidental enablement)

In t7xx_port_proxy.c, wrap the ADB port configuration struct with
CONFIG_WWAN_ADB_PORT, so the port is only exposed when
the config is explicitly enabled.

This addresses security concerns in certain systems (e.g., Google
Chrome OS)where root privileges could potentially trigger ADB
configuration of WWAN devices.Note that only ADB port is restricted
while MIPC port remains unrestricted,as MIPC is MTK's internal
protocol port with no security risks.

While using a kernel config option for a single array element in t7xx may
seem like resource overhead, this is the most straightforward
implementation approach. Alternative implementation suggestions are
welcome.

Signed-off-by: wanquan.zhong <wanquan.zhong@fibocom.com>
---
 drivers/net/wwan/Kconfig                | 12 ++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 410b0245114e..ef36a49cc85c 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -26,6 +26,18 @@ config WWAN_DEBUGFS
 	  If this option is selected, then you can find the debug interface
 	  elements for each WWAN device in a directory that is corresponding to
 	  the device name: debugfs/wwan/wwanX.
+config WWAN_ADB_PORT
+	bool "MediaTek T7xx ADB port support" if EXPERT
+	depends on MTK_T7XX
+	default y
+	help
+	  Enables ADB (Android Debug Bridge) debug port support for MediaTek T7xx WWAN devices.
+
+	  This option enables the ADB debug port functionality in the MediaTek T7xx driver,
+	  allowing Android Debug Bridge connections through T7xx modems that support
+	  this feature. It is primarily used for debugging and development purposes.
+
+	  If unsure, say Y.
 
 config WWAN_HWSIM
 	tristate "Simulated WWAN device"
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 4fc131f9632f..9f3b7b1dd4e2 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -102,6 +102,7 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
 	}, {
+#ifdef CONFIG_WWAN_ADB_PORT
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


