Return-Path: <netdev+bounces-65536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3754B83AF03
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D5BF1F2212A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543517E782;
	Wed, 24 Jan 2024 17:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Pb75dZBo"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2172.outbound.protection.outlook.com [40.92.62.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402557E772
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115664; cv=fail; b=dvS0/p79zufa3NjLMuAFmAIzIh5LE4/8/RqNnstRksgIJ49DqtQH9pzoBjTNDf4C4GPY2xv8iSlRLIQbAcqqAGysq7YbPHwq0/M66xzS7GwGa651r8Nns0a3ZmMgDcG2ohL/NrqNg4xiOzcg/oOwN1JEzgh+fBzQQpcu9oatGSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115664; c=relaxed/simple;
	bh=i00nK1Vkn0NJgdHwFHUfKzRSdtkDdicc9Ra4tOhUccE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fKZZMVxaaJe0kG/eBJDIEbVcqILP/Jy9pekZPBzyiAjcE29ZNfMoHSPXQJBNxOa0JrYB1/9L33FlHXPcWVccdl7nHisnTBvyU8O43gOSI3QDhWUSm986s6VKYYDBcHhQebAS2HIBq0+uUPMcKBTc1fiolxOKjvtg94+dEIg8bhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Pb75dZBo; arc=fail smtp.client-ip=40.92.62.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guYrNVmh95kp8/ytj+gbN9NAGAXcHFu7SudOQO6GRtD26iPCb/2i7BHNk7dcauFxqMcvM0GfiHJIaTXsYydNBqhuWOwvtNCklkTl05w6zlKuOS4uO8tN99LFvebcC6L/qnrSnAkfvwqe6DgqnOWD1aWLZ9YX4AP6jkojiqbhvFqubczsPs/1PZ2N6Y/S7xHtKMuhihBBjP/uRHPoHGRBzhhUc2qd4hHYWIraG9PgIUKHyacEznN7509nmAlROl9J3Qh4gHcTiqW3jwcWaAmPIXSfF1vdaUWJUFqe1zU98AA7tKAK7ZD2mViWLm9/DaXkDMk9jC0Ga33k07JkT0OD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cjtH5EutjCZHV0kXQcwBKraNTJZYbnQDZs0djWzck4=;
 b=cL5F6jZmf9DAmym49M4wOMegYyp1pns8Gfeem90ihxZ2HC5jh7k36xtZWIAV7W5RItM72VGtrInLHC21kXeYP2JId6nCYDrvPjGInn3s8zMlTdULhtWNfZUDhaWR2uhBy0A9s+oC826+eTsM5bvSA6b31wJEYgY1WZGaaUv5PxWgVWiB7/lXnVpRjOyGLxcjo+Dut6kvCCpS4PV/+dhGakWXYKKm+zwROLOt3TFzHyj4Xa+ja0gcC/KQx30JFmkEM4Ijz0/IcyqMqoMcjlSYDJAzzrGVCGn1hZs0jQKRcA/jcAVvmSycfZjpBkXskqYiFTdPijN9aUD8H5jE1QzjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cjtH5EutjCZHV0kXQcwBKraNTJZYbnQDZs0djWzck4=;
 b=Pb75dZBoalfv5Wd97pujcaI7YXQDht/RYhDmXmSEdsmoWY6bUP+nuiwtuCMOhZGrW7v8A7NmEMQBIVzpggJ2c3mVwFDRBAm62XImvQd8RkNBLGPsOmrfvle3jJqkSpSz3NAVBv3r+YYkyfDWUtiiDl4/4gcaEO/85aDwPaeu1VvbNLQNK8uERe4tDaISF3z0tDpqQ2XfVb/xDsw8q4ssj/TX92Hj537E4ubNLgL+hNTYgEapLJgrj0CIs2jbY4pMPZEnMfrg4LN0n5bYRli67MI0iEXz3g8QWbZeNKf8iOUpzC7+O+UNEEGqUR7Lze5VELCORC0xxIvJHGLdV7D2VQ==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY8P282MB4480.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:00:56 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 17:00:56 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.com,
	vsankar@lenovo.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v6 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Thu, 25 Jan 2024 01:00:10 +0800
Message-ID:
 <MEYP282MB2697BA48FD21EF9AF36D8CC4BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124170010.19445-1-songjinjian@hotmail.com>
References: <20240124170010.19445-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Xe/0KlBXxvMaNmtXbLbVv5kwI4hL/JcV]
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124170010.19445-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY8P282MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f9e32e4-6787-42b9-413d-08dc1cfe082b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yo69p0OPLCNRF/uqp4aOIdE+vo7qhlvHPtrMQP6BcArjgr0bYtwvSF3L7cmGc8ii8F8LYwsDOTcSsLPxshqE4I6w9RgMhpl1LZzrVTGi1z4Jxpjlqm9+Aqtyhx/ZhY/HT44lPbPVyuKthaGSVlUZZjgj5tO0c8M2jvgPbroT9jx+UQ4//po3gUzbvKNAxsNTS23c3x1R8iGGwikbxP9lES6Wc5ahRg5SSeataYTyH/dXgVgNbRpq+ytluaKBdQNReBRINbufIwTg6d3bjJv07hU2iRUN6F4UCi+LJ+C4dkikHC3/c+Z2P9TLkuAg55iCT4KnBCCD7dl1m1VWHdMWYpvrq9ZeRU/Xe7m6RKbqLZPvyG31x+FVS3db+931s62k0AhhSQ7e8sSLA+zI4IRlKcv/OPoY42GOa+z+0len0sHODtbhSLfnO2bWg4YEXOsyNiuut8FJhHJEoCYdIZJN57lMLD10ySbgT+capg9uPim6p+xvJWRHzPcLdWjgEkhQ99FAF+rgQOjGj67E2lsXOcl2jOICCYwRDReQiBN6I34989GxVgArjr87x3wPu0/O
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jrf4ieWTf8n1+Xbc4gV8SWkPEsCNrvnlteft56gXhOm/CUqdLh+zpQmlii2c?=
 =?us-ascii?Q?ZNd1QkXS6gUbmEpSqIVShwyIyeV/XwLiLY/lqh4J7LtzPOyJKpTeVTlSxLlT?=
 =?us-ascii?Q?WiWMB7wZayBN6uP2/fo2uyjl9YdVBNVBVoYAfcgHE0VRAU9pM8zJncBxgjTg?=
 =?us-ascii?Q?V9p5rU9PzWNZnYP9e497tiGrLOCQQ8GdIdYQfL95iIi8yOLwpW4tSYqPuty6?=
 =?us-ascii?Q?sqk+8UR6id5boIGbAKk23MAKKPDIgMaTeHHPuUf7D567gdYKrpce2tgppuNU?=
 =?us-ascii?Q?r/3D7bOwb6acxWAQ/udADoVSvS59W/OK8f+8Tk7fa1UAf3dDVuJbM3ubwmsQ?=
 =?us-ascii?Q?cACYMMGVf1NdlrwxjSyhveeUAw86G8zv4ZbdA7MBEFmpkdJfaBMzAWqba1+o?=
 =?us-ascii?Q?am4FrTNxYqlFyDSko2EutysEOZJZm19Lvcg2EJXTaOVGVoTOAkniSN6C+po0?=
 =?us-ascii?Q?o28Q077sGNl3K14Yj3oTDKG6LcKnU+X6zJgOEUWJmlV2AWUg3gbe9F9cKeNz?=
 =?us-ascii?Q?klmO/suyU+JqrVI5x3+nPagLsnTaAxhJgPT8iWY7cH2ojDsfY4AxC/p7je8H?=
 =?us-ascii?Q?Smx2ZXHdoSdNp0XzruYrS4FzfA+Bj3gVk4krLMEDjf2sHEQEtPNZOr7eHBTr?=
 =?us-ascii?Q?C6HFsp7uY+Mzj/8MFp4a4QF37eVshHIJfxYasVGt6+upgo6JkFYU687AbdeU?=
 =?us-ascii?Q?9W+R+DDmPB/neCZW+mV+0dA1wtJM4wSqGu5AmiF/nALudzeh/+deGg7HckGv?=
 =?us-ascii?Q?qGQ7Jltkov5cQ65uBxhvLOZn6MEEB0lcm/D5Mq2pStbB1c8I4BQcRr1yrLgX?=
 =?us-ascii?Q?ExfonU0oD6ZwNBRh3c94hz6SEs2PvfuDT2zopfHqwfRQVc4pqCNyolrAxQG4?=
 =?us-ascii?Q?vmNm3CPZ0lbEysvjKSujvTYh1p7+7yk8QJ/ks+/yOawVuUggkgVRZfMFNcR6?=
 =?us-ascii?Q?o8ZMcLLm2z8mODOdkzY968qLSfWextixtUCDwCsmipPoxehurQBgjcstwlXa?=
 =?us-ascii?Q?RSAdRlOhmUbljNdPXeobTG0l0876bzjLj9tbCFXgumVw5ykToY9SsoYCn5pe?=
 =?us-ascii?Q?HsmWGmRjhcqiqy7L4qguB4RCW37zRTMVwORhmpOlTFqhsGk81wwjElB1WBsn?=
 =?us-ascii?Q?QYixWWOBIGXubdM/k7NVb4C48kuHGZnwezPaDmFMOwl0PhyPg7XXiPHd525g?=
 =?us-ascii?Q?6gssQ0nXOp+8gvZftRHL8mU/+EJ3IrOKn7PLwRUWi8ZFh+XXyVR3yTknuGU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9e32e4-6787-42b9-413d-08dc1cfe082b
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:00:56.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4480

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v6:
 * reorganize code to avoid dumplication
v4:
 * change function prefix to t7xx_port_fastboot
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
---
 .../networking/device_drivers/wwan/t7xx.rst   |  14 +++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        | 116 ++++++++++++++----
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 4 files changed, 111 insertions(+), 26 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index d13624a52d8b..7257ede90152 100644
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
+port, because device needs a cold reset after enter ``FASTBOOT_DL_SWITCHING``
+mode.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
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
index ddc20ddfa734..1d3372848cb6 100644
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
+			dev_err(port->dev, "Unable to create WWWAN port %s", port_conf->name);
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
index 2bcd061617e2..60bc8d635ade 100644
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


