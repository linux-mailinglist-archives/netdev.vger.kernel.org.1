Return-Path: <netdev+bounces-64604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AEF835DB0
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E21691F25CAD
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C456E38FBC;
	Mon, 22 Jan 2024 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="c0FJbr3Z"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2186.outbound.protection.outlook.com [40.92.63.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B624638FB2
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.186
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914638; cv=fail; b=MAt46DAX/FmLP1sla4CE3AO7XxTmxGCqkybhScUak6QXMyO1XTMCd9ZI/SO4XZRrz61xmeZXL0Tkvju/tZIy0/MbvcWgoDPUS9xR5xB00O/S9bJoK+qQnfIy9ZqhbxlQ8HC48PFhLLx9Y3VBWutf10lLvgTckurdJj8yBvn2ZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914638; c=relaxed/simple;
	bh=/TwPvR6wYUCEDHNIIavCi023LHep7cjKtNilJ+t+F+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4njjQoaPUp2Glj61gbI5NdqQz6TmuGNt+Rz4Rd4pyZqKrDyfSbu6zMBbv9sOXvaO9ILrJ1DBUMQZrdWxzHZsjbo3hP1IB+vUzBWIrVSMjhN8lMDDr6gy9Fx3njIJ2tLW3zWvGthO0t3/jajBQVYmnf0rlfEYtiMMUCJzLTZhTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=c0FJbr3Z; arc=fail smtp.client-ip=40.92.63.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaYXdAcheXmwrQ7T7dhFG7cRFL4GSDvSLj2Qh2egUGgrb6Y8O7Y/HquIvTjYu3FtvrXZP8bpJ0kihja5vsp+nT91kVYduw6XEI+2WUs4NSaluyaooyo4K/yBRWsePJODKKrn97oNS+o5+V5awp6xcpVCMuzz2izWK5X8y7bPmU0LNux5DMnSTF+YjBJF/lBqE/wwazzQcqEqJoDnakGXgSwqFnXGHTk3GyKN4EProvSy/Vi/BJBLHAFztORVw80gBKzQIl2Y0bWrYeDQ7VuGoAUikK7lRsMLOt5SKSIP5wF34Wuiih3DLZtX3ZziDL7c6LbHdylv5Efab3CYe+QUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gV99M/yDC/MRR+3bDBKEWiryR1G5szEsSo+NfjISS4=;
 b=ogV4FhBKtc9w0ZxrdmNzyqjhGl3lXc4Kiiuq8/VCRhi8WteydpIRvo78dBDfqyCRdBOkv+2XmNIFA7El9R16sA5Ztcqmf1zpYxBkuIIB53/acjixwfVng+vBNBEhDbGSdPcGv/SBlvxeamKj24Sw00tGxDDL3bcmjuJk1YyBjUIYpWNHzZGv/Vv7hsvU9xxxU8m7/NOJaJ3jLj+FjR0lPKa0yGUc1Ok5lhi1wVKjLdRkHcuNHJT6qiRAHCEZid21dXAXYLGNN0bhYwfwZ+BquqU7+Q7KwAV/Moo5yUd+M6cLuBC4mIiXrtM/gpdCReJJ/k/OnpohYWBDnVPVWC44PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gV99M/yDC/MRR+3bDBKEWiryR1G5szEsSo+NfjISS4=;
 b=c0FJbr3ZffJVw6DqpNTbsol/MimO5FGiJ3qHnUmz7iV973Hc0Tsgo2GD7r4XfCWTUNvVEs9eSBHAQsLwSf39rINk4gRI5Xz39Fd2CQdRPojxNopr8kvGDSgEPMNQI5C6xSjlUc824fea6m4+qWGd7ZyfVFmnnItfzBg/7JNm1inrzNujUURzL7ZCePH352ur9ghPOgDN/vlItdnLMAyjmk2/mt8ovBCTuGWZbbIS3lK60Q3KFnSJTnrBNB9uR7/P+TLCUP8ZYT0G+2XZVvvIY/SO5A+sqixIYaV63lBX+Rytg1Fy8RzTP06xDVaeXOx1GVEkW9RUGO81jSfBywA2+Q==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4893.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:10:29 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:29 +0000
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
Subject: [net-next v5 4/4] net: wwan: t7xx: Add fastboot WWAN port
Date: Mon, 22 Jan 2024 17:09:40 +0800
Message-ID:
 <MEYP282MB26978032980360EBBB1DAFF9BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122090940.10108-1-songjinjian@hotmail.com>
References: <20240122090940.10108-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9cL8Aqv8wePe238BiSEPonibIkp4YNe+]
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240122090940.10108-5-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ef8a436-286a-448a-3ec0-08dc1b29fa59
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZomRtvtK9pxI1sA919XQrKdbuT+IpCdM9ntok8LMxvF07mA97vfCBmAxhsT7kve4c2Iy3/fP0neTTkT1T6XGKbsUZEETjr13VUvn6fwcol7HjXizMEC3e4dbDJhgdxF22N73Hw6SwYNXtcB8ipN/pOS4lhHYL1I+2el6eMD3qBk4iX9bugLTCNtPmCLG03uHxF+wWefbPOgwpazK1U4hgvsVn2IhPmCKr0b4ysGdMfznuUnVmpu+yHdGoo9NeuzZj4JVMg9wWbQtqH7Bclb3ABhL3oy/zfWh3BL/KU5HFxEenbJvrQ0KfQMMg1g8ul7Lx/IOwZdINwVqx7QFNVGU+DptMXSkOEOlYZonK6Gxdau/qmmgzUxW5VDhKxLCH3bOMLh8OT1HskYDi5wX5vBBpRspTt4stm9+nCnF/+1ScwomcEqXtY3LtblOhiuY1hPTbVlkkOIQv3Uo1zPMTthnEutJA+nSgOtV7KZpWqtDsaXv4cFerDGpo6AD7j3WghicHohctaokj4+hVJIh07QvxDxDfcmF21XFIz2bt34DqA8qoKSvjMA0DmNPt/JGjJBz
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbObdz9w1qhyM6/7mLXlkOOCrHd8DSSMpZZ1A/t69orJM0H6FAZuR4WZF+4J?=
 =?us-ascii?Q?LYOTd7+ML0epsidQKR1anaIEIpEm8RdceGrn/hlxcm3bFaLWgHQzWzA206Wu?=
 =?us-ascii?Q?UlUXPXFlmUwSSi63Y/Z2Yo4YbLiunOA26OOebeQzT/A+gMvAucTUJN8pvCrd?=
 =?us-ascii?Q?Z9On6m3nCN1m8m0OWhO6Wzi7zGERSEg3/t2gz11XgXorXp+xjanQgAdXQyF3?=
 =?us-ascii?Q?h70DEFnT703L6keXfLcEj8C/Te8ab9kHNh+mwkLMzCavyO947nN8JdcmpheW?=
 =?us-ascii?Q?aJ3qDkFWZc9i/EYlZi8MRIVDsz0V9Jix8v/TVLfsKNNltbiNXxaKF+Yi4EAl?=
 =?us-ascii?Q?hXg9ky3bjOin7qbv0apnjBt+9bbrgt1exIqUty13HZQjmOhabjSSytBxo060?=
 =?us-ascii?Q?08k83vFqNoSqyb5oZ+h5SlKJVNkq1cv0CzhPfxtWjj/JxFZfPdSxha2YXW8V?=
 =?us-ascii?Q?BaakXVnKyZQFIvSZC9kLl7ndmB47JTOF8wS3utr55gOUNHU8Z/J6B8dxT1gN?=
 =?us-ascii?Q?pMb8RzkQZPsHB62kDa9Yad83Dw/M2vxJrSeNWi55+4W8gBJZAi0do7/+KAhS?=
 =?us-ascii?Q?Lk8dPR8+wZRV30KDMFiDQ12EAiIil2age3bbn58AjD8tHuJZpi60hcRUb+b3?=
 =?us-ascii?Q?ujPYFNUSBRG+Mi0fZorfE5c35K2JozuKmnKCMhvqigbIQGVvbwulWKbA6TjY?=
 =?us-ascii?Q?ae8CjLevdGOaZSVwKFFKORZ5GGcMLMURdfswzdk3seMkQRtCTB+lK4DzPdgd?=
 =?us-ascii?Q?LqrjyPjeLVI9EVlKq1WyoFzXouqqf+tVWyBjf9C5xXOHtoANNG0PQ3y+q6UO?=
 =?us-ascii?Q?MbIS7T0vc26eq4bD4h3bB5z58BIb6tqHPj1xD/4TgB+JKeTLfEAl7++goNdu?=
 =?us-ascii?Q?EUnXw81W12NaXH6IQoAGAeuNXYaVolNkI4kGjMVrvbzREFGfOlr2akDu0lzd?=
 =?us-ascii?Q?OEvK1DDOwoXCSJkla1VAgct3M/PT9gtao735Te6cSxwa6ajlZaUJIYnXLd2J?=
 =?us-ascii?Q?dFz9ocp/q/8d9BX8qXsjA6wa/UPFjEoZyU5k935Zx4MbkF35XeI3nHs0A9rn?=
 =?us-ascii?Q?43wu4xJq+YNwqdCWkGOr4fRcFx5v96/IZpN9MRB2Eesjx6mq22kp44InjAho?=
 =?us-ascii?Q?cJDXh5yOYJSDT8bNkm/+2UbGzrhVDRoUARYY5P8Ef5Ej/FYSYpYGurUQx42m?=
 =?us-ascii?Q?+oI3o1J1VWSZ5CC+PBXcl4j5KMKByKZsjyhh0qO2jYeTXmwIE26LQVxx1oY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef8a436-286a-448a-3ec0-08dc1b29fa59
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:29.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4893

From: Jinjian Song <jinjian.song@fibocom.com>

On early detection of wwan device in fastboot mode, driver sets
up CLDMA0 HW tx/rx queues for raw data transfer and then create
fastboot port to userspace.

Application can use this port to flash firmware and collect
core dump by fastboot protocol commands.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v5:
 * no change 
v4:
 * change function prefix to t7xx_port_fastboot
 * change the name 'FASTBOOT' to fastboot in struct t7xx_early_port_conf
v3:
 * no change
v2:
 * no change
---
 .../networking/device_drivers/wwan/t7xx.rst   |  14 ++
 drivers/net/wwan/t7xx/Makefile                |   1 +
 drivers/net/wwan/t7xx/t7xx_port_fastboot.c    | 155 ++++++++++++++++++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       |   3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |   2 +
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   4 +
 6 files changed, 179 insertions(+)
 create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

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
diff --git a/drivers/net/wwan/t7xx/Makefile b/drivers/net/wwan/t7xx/Makefile
index 2652cd00504e..ddf03efe388a 100644
--- a/drivers/net/wwan/t7xx/Makefile
+++ b/drivers/net/wwan/t7xx/Makefile
@@ -11,6 +11,7 @@ mtk_t7xx-y:=	t7xx_pci.o \
 		t7xx_port_proxy.o  \
 		t7xx_port_ctrl_msg.o \
 		t7xx_port_wwan.o \
+		t7xx_port_fastboot.o \
 		t7xx_hif_dpmaif.o  \
 		t7xx_hif_dpmaif_tx.o \
 		t7xx_hif_dpmaif_rx.o  \
diff --git a/drivers/net/wwan/t7xx/t7xx_port_fastboot.c b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
new file mode 100644
index 000000000000..880931af3433
--- /dev/null
+++ b/drivers/net/wwan/t7xx/t7xx_port_fastboot.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Fibocom Wireless Inc.
+ *
+ * Authors:
+ *  Jinjian Song <jinjian.song@fibocom.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/wwan.h>
+
+#include "t7xx_port.h"
+#include "t7xx_port_proxy.h"
+#include "t7xx_state_monitor.h"
+
+static int t7xx_port_fastboot_start(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	if (atomic_read(&port_mtk->usage_cnt))
+		return -EBUSY;
+
+	atomic_inc(&port_mtk->usage_cnt);
+	return 0;
+}
+
+static void t7xx_port_fastboot_stop(struct wwan_port *port)
+{
+	struct t7xx_port *port_mtk = wwan_port_get_drvdata(port);
+
+	atomic_dec(&port_mtk->usage_cnt);
+}
+
+static int t7xx_port_fastboot_tx(struct wwan_port *port, struct sk_buff *skb)
+{
+	struct t7xx_port *port_private = wwan_port_get_drvdata(port);
+	struct sk_buff *cur = skb, *cloned;
+	size_t actual, len, offset = 0;
+	int ret;
+	int txq_mtu;
+
+	if (!port_private->chan_enable)
+		return -EINVAL;
+
+	txq_mtu = t7xx_get_port_mtu(port_private);
+	if (txq_mtu < 0)
+		return -EINVAL;
+
+	actual = cur->len;
+	while (actual) {
+		len = min_t(size_t, actual, txq_mtu);
+		cloned = __dev_alloc_skb(len, GFP_KERNEL);
+		if (!cloned)
+			return -ENOMEM;
+
+		skb_put_data(cloned, cur->data + offset, len);
+
+		ret = t7xx_port_send_raw_skb(port_private, cloned);
+		if (ret) {
+			dev_kfree_skb(cloned);
+			dev_err(port_private->dev, "Write error on fastboot port, %d\n", ret);
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
+static const struct wwan_port_ops wwan_ops = {
+	.start = t7xx_port_fastboot_start,
+	.stop = t7xx_port_fastboot_stop,
+	.tx = t7xx_port_fastboot_tx,
+};
+
+static int t7xx_port_fastboot_init(struct t7xx_port *port)
+{
+	const struct t7xx_port_conf *port_conf = port->port_conf;
+	unsigned int header_len = sizeof(struct ccci_header), mtu;
+	struct wwan_port_caps caps;
+
+	port->rx_length_th = RX_QUEUE_MAXLEN;
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
+
+	return 0;
+}
+
+static void t7xx_port_fastboot_uninit(struct t7xx_port *port)
+{
+	if (!port->wwan.wwan_port)
+		return;
+
+	port->rx_length_th = 0;
+	wwan_remove_port(port->wwan.wwan_port);
+	port->wwan.wwan_port = NULL;
+}
+
+static int t7xx_port_fastboot_recv_skb(struct t7xx_port *port, struct sk_buff *skb)
+{
+	if (!atomic_read(&port->usage_cnt) || !port->chan_enable) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		dev_kfree_skb_any(skb);
+		dev_err_ratelimited(port->dev, "Port %s is not opened, drop packets\n",
+				    port_conf->name);
+		/* Dropping skb, caller should not access skb.*/
+		return 0;
+	}
+
+	wwan_port_rx(port->wwan.wwan_port, skb);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_enable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = true;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+static int t7xx_port_fastboot_disable_chl(struct t7xx_port *port)
+{
+	spin_lock(&port->port_update_lock);
+	port->chan_enable = false;
+	spin_unlock(&port->port_update_lock);
+
+	return 0;
+}
+
+struct port_ops fastboot_port_ops = {
+	.init = t7xx_port_fastboot_init,
+	.recv_skb = t7xx_port_fastboot_recv_skb,
+	.uninit = t7xx_port_fastboot_uninit,
+	.enable_chl = t7xx_port_fastboot_enable_chl,
+	.disable_chl = t7xx_port_fastboot_disable_chl,
+};
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index e53a152faee4..7200d2d210fc 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -112,6 +112,9 @@ static const struct t7xx_port_conf t7xx_early_port_conf[] = {
 		.txq_exp_index = CLDMA_Q_IDX_DUMP,
 		.rxq_exp_index = CLDMA_Q_IDX_DUMP,
 		.path_id = CLDMA_ID_AP,
+		.ops = &fastboot_port_ops,
+		.name = "fastboot",
+		.port_type = WWAN_PORT_FASTBOOT,
 	},
 };
 
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..0f40b4884dc0 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -98,6 +98,8 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+extern struct port_ops fastboot_port_ops;
+
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
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


