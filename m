Return-Path: <netdev+bounces-69071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6AA8497B0
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C08284C6D
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E40168DA;
	Mon,  5 Feb 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="m2a/spPV"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2153.outbound.protection.outlook.com [40.92.62.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CD171BC
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.153
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128620; cv=fail; b=s8xEy6rCKoYYKzcc15X1JQo36uSgmaPQYxxrlLs6kGs1qU3ogGdd93cnOpQDST5G07De5j5r+hguT8WrgKaETBrzHK0XwHzhq1p6pXl6Psn00SIWA6qzFmynsMnd/FktJCGIkyOAXswbLxUybWrjCnbZv1pg+zLYo+1kde2FBFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128620; c=relaxed/simple;
	bh=QhGbgy9+rl+ghWeCSxy7ADup7xXRPhV5njC2cvDo5bE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZEWYxJ7SjoWWwauuY+izFcU4qc18vB27TTWZlMmfONZu81ds6tDssijXmsy6ja4wHi/2AKo3xyb+9dDBNO7B/2ubQoajSoZpTbGv5lO8R5RhGIkmxDro3A7kr0ERZwTv9h3rgi3E4UjMx58H7V9YSHfJ/A87mAwtAd/rkHH8n0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=m2a/spPV; arc=fail smtp.client-ip=40.92.62.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIv9vvYejScROwlOEjWjbIJQuOHUwiX8DJMlMjXeU3I5yLuH6OjICD42OW+Zes0g4lZJMFYJMAdhAhuIQKlVhze8PKs+omyNXPCeCUmIYwxaGptZPjwYKrSVb45Iw8ljSyGQc2dwejwUrn8CErYuuBdtdLiWzmKC4JGkG+QHGB5hLe6dY4Wl9vT/De7DOiF9iguQJzx7OkXyClNiSS6FY/WtAoI4GCt5kx06OCBaNRTsGlwsYM3Oe77k7v9Wh59XfUeBkjB5scrG4+2WAX0K93LMznRtaWtIcRY/cGrwBq/g+GatRdTd6t1v7M63BRxc8QEmu8x/y1a5fS7YznLHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQFMu+d8fEhUzsGqXOEZeVcjvPj7yJ8NyEd/JqbpeSE=;
 b=SErvF1JIHCoQVENr8bhX87mvp7au/wmw3xXx9Zo2pVoARKiM0p6KXb3yH1sYAh/83SeVvt3zfa4jU0oElGYgoqlrNDPK0iBNW1kSV25UCZGhm/0NOGYzbBGixZ8R+aivNNUCaXjx39Ci6zE4tPm+ol7tqGzIrQtAILTpoc9rjkRgyYeHfDNssMiAIfe6YlvGqK7hQnl9zMGXGCcUf5KlR28iqCi6UUqARg+59Z6efORMpGo/Tnbg9cQDKVJwsvAwgCLynJyOglqPDrW01rJR2nXKTpe7HiKYrcxQiTNQgEKUc+Y2aHIKTpmIaw5iaabR6Zs/sA3X4XHdzUWdyiL29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQFMu+d8fEhUzsGqXOEZeVcjvPj7yJ8NyEd/JqbpeSE=;
 b=m2a/spPVN2dKdzD161b+uSlP5i3bRDO3dD75EIwfvJYpDVE8KmLErHWAsxIprgT3m3krsWG81fm+yYBLVaglA036XnCHb1SazVuL2cbBWcJ7SEILuLnFo95M6LTFyQeG+UEDDUBb5ig8fU2PfKUmiuKAJEDuPMMzqZK5wYWmyNYCWRLbqzmZHfSaueVsAiwe6n3cHHlR88vw9z4frPCR8Kc6uUg3Sd+qU0f98V/0Ixazx2EkDxicgtmtN4Vpzfxhb++YtfR5nm7P5KRpcRPOyS5Af4BFupI4lvlUpo2gEqj1Jo7k+h5CJ8O0Y0/W0bSkKaa8n+9ku5MMmWP0U0da5Q==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB0886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:23:30 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:23:30 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: alan.zhang1@fibocom.com,
	angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	danielwinkler@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	felix.yan@fibocom.com,
	freddy.lin@fibocom.com,
	haijun.liu@mediatek.com,
	jinjian.song@fibocom.com,
	joey.zhao@fibocom.com,
	johannes@sipsolutions.net,
	kuba@kernel.org,
	letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com,
	liuqf@fibocom.com,
	loic.poulain@linaro.org,
	m.chetan.kumar@linux.intel.com,
	nmarupaka@google.com,
	pabeni@redhat.com,
	pin-hao.huang@hp.com,
	ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com,
	vsankar@lenovo.com,
	zhangrc@fibocom.com
Subject: [net-next v9 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Mon,  5 Feb 2024 18:22:30 +0800
Message-ID:
 <MEYP282MB269716FCE0A2DD81815622F9BB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205102230.89081-1-songjinjian@hotmail.com>
References: <20240205102230.89081-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Lnne84yinz95x/++tgas9yZ0V3D8wIje]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240205102230.89081-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea92c3b-48bd-45cb-da74-08dc26347f4a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UlNRWtjeignWUIsuc+9iSn6w/ZHSZUwxoaJqH1MU15+ls/VAtvdl5w5yzsfvjL+ztsW6qBa6QNi4g6QLQaxyyX5kQEdv4XVupVuYecIJ1F9AKFIF7jdkDfR817AJ7780mTabhNEr4BSg8yh5Dmf982d9i9GjtCwGc1WjcayJr8+ZiA/lk8Lawief8nqSe0hqlQwRzH7fh2Busy76lD1P6VE7u7g4IysLWOjP5u4GEw7106xPtkKpACz/BYkkYDu8+CjNdSPUiWS76cnC/LBabv0vMpYZdP45nQfJwR/VxjUQzIQadQmeoBGPTI7lbhrH0Ak7gdLASsx82rUP9CyG8a9tftf7o5oOwToQdSIUmvI90sF6dRb4eQU9i2HGwE9+8f332/MNldgupjDuSmYnAcVmLc1hgbSUrPDLzdnzZwqR2+3Gf+G0ZjmlbAZHOsu24ynGjV5Shfz36f6jHhcyhLMUjyCsNs2UkkRoMy2IeW9fZ9hRE9isYcjQ72S+9dnyEP8ZyNVZRCh0Q0Dco0cddTLg4dfkph2RoquWExh+XF3AZueYjt83hg5muRDxYMe1fITO32qKTT3R+3kmXhFLWiQkPVKvS6l9XFAxMtUwlRo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/cUsCuWhPog9Lq5n4zZCqjwJlampSrCDjJwnJN5bGR44FcUwomA5AlmjFc28?=
 =?us-ascii?Q?Wn73mkRgZjiMSAUpsf43wsbpjrQiK9krtcMeENzqXp3a0MIlrXE+WAqhrzVu?=
 =?us-ascii?Q?YdxYkuS2jD3ctyqDiIREhBtvlodAmDHw6mWuuZri1pbQcMYAFvzGPPebycgi?=
 =?us-ascii?Q?7nuwKCTJGrvS02OX8VkcrdtAiKccNPRC1LeN15c55UQihupEIHokymzm2ONp?=
 =?us-ascii?Q?BaCluTohg60OqCc+vVeRF2RoOKyLdH2Bx3bhVJQ476F1rq7LKDcPfx8S+z2H?=
 =?us-ascii?Q?Sa0XupYQN41zsYJDOyAju9hb5acS+M74A2xOYZkxJ83Sp9Tc0TaVYCkcYJUp?=
 =?us-ascii?Q?pl+ltJuZ7NamlSghOKUQFo3T0s4ktqmHrux64W4AopfMQ1VJmRbxtI73nBPe?=
 =?us-ascii?Q?VY2FM+hpgU+kjW1Bus8CvxDOnrBR+1iI0Ry9HUbxJnuuWOULgCLUXPRFChVS?=
 =?us-ascii?Q?JbayFomatdJcFfJL2rNzutqQL2rruvyf7aR1IWx3ofepJ1jKrbQylMEBg/g5?=
 =?us-ascii?Q?/QNv4lyVbzEVmwMt/EFAkiwlL4DelOYN+7Im2bxRadM3X8VWAlo8U6DMcLEt?=
 =?us-ascii?Q?6d6dTjnyAbuOiniLX9CEq7oZVqow8GMaI7nGoedvLZYfxLXOwlMaVJvQhV+X?=
 =?us-ascii?Q?TgrudR6O6cyT4dXO0YsxwIKx55n+fH+2MZey4M7+OOOroZulO9zIDUqaqU9A?=
 =?us-ascii?Q?nxzDYwZtmY5m6LZQMeN2EW3vvXuTCmkmAmfPQCIqo5+noJVfjuTW1zFJJFzF?=
 =?us-ascii?Q?oIbzzVgYIXegNmzmGZj/SAmQNGrebpJMKGCv0Qf12uKQABdTonx9nNqDJBgg?=
 =?us-ascii?Q?StN37C5VVOIFd9oqRTx853hxPKgGplIlFgelXh1LRqKOimiVQxnKHokV9yML?=
 =?us-ascii?Q?RRVM37iAlIImQE7MR+vgfsDelXrBO6cW6UivxtZ16k3jERgZxR00WYCASEiT?=
 =?us-ascii?Q?4xaQRCev/Z5tAdTy/0u0j5ONoi1bg6RDoVE3y/5J8zTXFmySe7qMxt33aJXI?=
 =?us-ascii?Q?8SDChN3/0SNI6h6vf/yEiptaWAOA8Ym23ZXgREbMO0T/3C+AUf+9vHfwWSl8?=
 =?us-ascii?Q?21uhg/scfy0IyeGxotZP4BS4roGfrciHnEs3DbburUAtR05yVeBr2b9kJYlx?=
 =?us-ascii?Q?Zjy4ZKevlHsUPrgBOfoFcqQ1xqwFRmktci6X5aLjzD3qqj4Yii4CcynGrwhg?=
 =?us-ascii?Q?sAOzsmvx0aWA/A2NOmkksbscPKc2F64/+qOxQKZmlm/M+jvxCOBmipiQeSE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea92c3b-48bd-45cb-da74-08dc26347f4a
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:23:30.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0886

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.
E.g., flash firmware through fastboot port:
 - "download:%08x": write data to memory with the download size.
 - "flash:%s": write the previously downloaded image to the named partition.
 - "reboot": reboot the device.

Link: https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v8:
 * modify spelling error in WWAN 
v7:
 * add fastboot protocol link and command description to commit info
v6:
 * reorganize code to avoid dumplication
v4:
 * change function prefix to t7xx_port_fastboot
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
---
 .../networking/device_drivers/wwan/t7xx.rst   |  18 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 116 ++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 4 files changed, 115 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index 8429b9927341..f346f5f85f15 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -125,6 +125,20 @@ The driver exposes an AT port by implementing AT WWAN Port.
 The userspace end of the control port is a /dev/wwan0at0 character
 device. Application shall use this interface to issue AT commands.
 
+fastboot port userspace ABI
+---------------------------
+
+/dev/wwan0fastboot0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a fastboot protocol interface by implementing
+fastboot WWAN Port. The userspace end of the fastboot channel pipe is a
+/dev/wwan0fastboot0 character device. Application shall use this interface for
+fastboot protocol communication.
+
+Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
+port, because device needs a cold reset after enter ``fastboot_switching``
+mode.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
@@ -146,3 +160,7 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [4] *Specification # 27.007 - 3GPP*
 
 - https://www.3gpp.org/DynaReport/27007.htm
+
+[5] *fastboot "a mechanism for communicating with bootloaders"*
+
+- https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index e53a152faee4..8f5e01705af2 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -112,6 +112,9 @@ static const struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "fastboot",
+		.port_type = WWAN_PORT_FASTBOOT,
 	},
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index ddc20ddfa734..4b23ba693f3f 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021, MediaTek Inc.
  * Copyright (c) 2021-2022, Intel Corporation.
+ * Copyright (c) 2024, Fibocom Wireless Inc.
  *
  * Authors:
  *  Amir Hanania <amir.hanania@intel.com>
@@ -15,6 +16,7 @@
  *  Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>
  *  Eliot Lee <eliot.lee@intel.com>
  *  Sreehari Kancharla <sreehari.kancharla@intel.com>
+ *  Jinjian Song <jinjian.song@fibocom.com>
  */
 
 #include <linux/atomic.h>
@@ -33,7 +35,7 @@
 #include "t7xx_port_proxy.h"
 #include "t7xx_state_monitor.h"
 
-static int t7xx_port_ctrl_start(struct wwan_port *port)
+static int t7xx_port_wwan_start(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
@@ -44,30 +46,60 @@ static int t7xx_port_ctrl_start(struct wwan_port *port)
 	return 0;
 }
 
-static void t7xx_port_ctrl_stop(struct wwan_port *port)
+static void t7xx_port_wwan_stop(struct wwan_port *port)
 {
 	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
 
 	atomic_dec(&port_mtk->usage_cnt);
 }
 
-static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
+static int t7xx_port_fastboot_tx(struct t7xx_port *port, struct sk_buff *skb)
+{
+	struct sk_buff *cur = skb, *tx_skb;
+	size_t actual, len, offset = 0;
+	int txq_mtu;
+	int ret;
+
+	txq_mtu = t7xx_get_port_mtu(port);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		tx_skb = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!tx_skb)
+			return -ENOMEM;
+
+		skb_put_data(tx_skb, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port, tx_skb);
+		if (ret) {
+			dev_kfree_skb(tx_skb);
+			dev_err(port->dev, "Write error on fastboot port, %d\n", ret);
+			break;
+		}
+		offset += len;
+		actual -= len;
+	}
+
+	dev_kfree_skb(skb);
+	return 0;
+}
+
+static int t7xx_port_ctrl_tx(struct t7xx_port *port, struct sk_buff *skb)
 {
-	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
 	const struct t7xx_port_conf *port_conf;
 	struct sk_buff *cur = skb, *cloned;
 	struct t7xx_fsm_ctl *ctl;
 	enum md_state md_state;
 	int cnt = 0, ret;
 
-	if (!port_private->chan_enable)
-		return -EINVAL;
-
-	port_conf = port_private->port_conf;
-	ctl = port_private->t7xx_dev->md->fsm_ctl;
+	port_conf = port->port_conf;
+	ctl = port->t7xx_dev->md->fsm_ctl;
 	md_state = t7xx_fsm_get_md_state(ctl);
 	if (md_state == MD_STATE_WAITING_FOR_HS1 || md_state == MD_STATE_WAITING_FOR_HS2) {
-		dev_warn(port_private->dev, "Cannot write to %s port when md_state=%d\n",
+		dev_warn(port->dev, "Cannot write to %s port when md_state=%d\n",
 			 port_conf->name, md_state);
 		return -ENODEV;
 	}
@@ -75,10 +107,10 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	while (cur) {
 		cloned = skb_clone(cur, GFP_KERNEL);
 		cloned->len = skb_headlen(cur);
-		ret = t7xx_port_send_skb(port_private, cloned, 0, 0);
+		ret = t7xx_port_send_skb(port, cloned, 0, 0);
 		if (ret) {
 			dev_kfree_skb(cloned);
-			dev_err(port_private->dev, "Write error on %s port, %d\n",
+			dev_err(port->dev, "Write error on %s port, %d\n",
 				port_conf->name, ret);
 			return cnt ? cnt + ret : ret;
 		}
@@ -93,14 +125,53 @@ static int t7xx_port_ctrl_tx(struct wwan_port *port, struct sk_buff *skb)
 	return 0;
 }
 
+static int t7xx_port_wwan_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	const struct t7xx_port_conf *port_conf = port_private->port_conf;
+	int ret;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	if (port_conf->port_type != WWAN_PORT_FASTBOOT)
+		ret = t7xx_port_ctrl_tx(port_private, skb);
+	else
+		ret = t7xx_port_fastboot_tx(port_private, skb);
+
+	return ret;
+}
+
 static const struct wwan_port_ops wwan_ops = {
-	.start = t7xx_port_ctrl_start,
-	.stop = t7xx_port_ctrl_stop,
-	.tx = t7xx_port_ctrl_tx,
+	.start = t7xx_port_wwan_start,
+	.stop = t7xx_port_wwan_stop,
+	.tx = t7xx_port_wwan_tx,
 };
 
+static void t7xx_port_wwan_create(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	if (!port->wwan.wwan_port) {
+		mtu = t7xx_get_port_mtu(port);
+		caps.frag_len = mtu - header_len;
+		caps.headroom_len = header_len;
+		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
+							&wwan_ops, &caps, port);
+		if (IS_ERR(port->wwan.wwan_port))
+			dev_err(port->dev, "Unable to create WWAN port %s", port_conf->name);
+	}
+}
+
 static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		t7xx_port_wwan_create(port);
+
 	port->rx_length_th = RX_QUEUE_MAXLEN;
 	return 0;
 }
@@ -152,21 +223,14 @@ static int t7xx_port_wwan_disable_chl(struct t7xx_port *port)
 static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int state)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
-	unsigned int header_len = sizeof(struct ccci_header), mtu;
-	struct wwan_port_caps caps;
+
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+		return;
 
 	if (state != MD_STATE_READY)
 		return;
 
-	if (!port->wwan.wwan_port) {
-		mtu = t7xx_get_port_mtu(port);
-		caps.frag_len = mtu - header_len;
-		caps.headroom_len = header_len;
-		port->wwan.wwan_port = wwan_create_port(port->dev, port_conf->port_type,
-							&wwan_ops, &caps, port);
-		if (IS_ERR(port->wwan.wwan_port))
-			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
-	}
+	t7xx_port_wwan_create(port);
 }
 
 struct port_ops wwan_sub_port_ops = {
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 038377fed102..9889ca4621cf 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -229,6 +229,7 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 	struct cldma_ctrl *md_ctrl;
 	enum lk_event_id lk_event;
 	struct device *dev;
+	struct t7xx_port *port;
 
 	dev = &md->t7xx_dev->pdev->dev;
 	lk_event = FIELD_GET(MISC_LK_EVENT_MASK, status);
@@ -244,6 +245,9 @@ static void t7xx_lk_stage_event_handling(struct t7xx_fsm_ctl *ctl, unsigned int
 		t7xx_cldma_stop(md_ctrl);
 		t7xx_cldma_switch_cfg(md_ctrl, CLDMA_DEDICATED_Q_CFG);
 
+		port = &ctl->md->port_prox->ports[0];
+		port->port_conf->ops->enable_chl(port);
+
 		t7xx_cldma_start(md_ctrl);
 
 		if (lk_event == LK_EVENT_CREATE_POST_DL_PORT)
-- 
2.34.1


