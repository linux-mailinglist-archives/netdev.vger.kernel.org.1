Return-Path: <netdev+bounces-64602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3C835DAE
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C3A1F25BAA
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDD338FAD;
	Mon, 22 Jan 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="Pe5TSqY0"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2166.outbound.protection.outlook.com [40.92.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D05697
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914625; cv=fail; b=ca9WsSovBjQDmSasmc9BteMNLeGSsWT12TSCh4WB9N/v4cSXF30/cqLHmiTQEwsOv9SBoFy645tLRcugjFGUtLhSIgXxiitkgoUEAKH/h7WefXb1dlKmruC5ilPc+4MIdo+HaY0ZGYpwoB5RHzRtMIsVivcNqxxYRLiISwij+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914625; c=relaxed/simple;
	bh=mDL0/OEu95MCOb52OJh/YzjG7B4OPIRzqAzd02nXVIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgZB7H1vY6Uc3CoeKb3JqZTxmnYSnBhvYOsXCkMVJu2C7xRGbkYkRW2iXmr+G0t3x17Frq+4HKQfu1HmU/36AfVm5zdWvyScQgwwcJp9VMo6aUGxbyyueAvBXOsob45BKwNwt7cEsR9mreY/ZgaAcm59IwZkDluMdMT6j/3tYVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=Pe5TSqY0; arc=fail smtp.client-ip=40.92.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQKXPMM8c8THmKYCbadL58g0m2oPKOV+XQvhUDnVJvIpSYXO70PEVdMecXjU36spJunqJxaDqCtBrvYuAzYg4aEUxGRj7BZmbpn7xNaTijLphcHl7cfXrVEKDsTfHpN/7Jo5f1QBcvbN9jD9SlnOqb5DT8n/wzKu/zFkTVGATh1Wb0EJqFt/pqvWNYL3LtglecebmjKvbOwUw/ejW/gubGCW2YKLKacAgiIatE3Uew4AZ6xTHzkrhZooyb8h8XmjrVLRAOJr4/bOnRVDNpz9fLDmVaZX++xoUC5/CQkkjWazRoTYjxgycQv/d/2v2KB9RnF6c2Pthnq9vdlncxGGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9s7QEHa9n2gu4UFKFF1iRn5LzoR5hrMJc/w6aMY+x4=;
 b=OysBmC7haCPsx/1UUEcL7Ljo529e31XLTq5WgfxD2+MZFysI6PhNQ6MAdx2mRZuhF+wuir0oINoDwlTPgd3AieY/IleS7fr2usRp8QAE/ZtKqRFdnlM9rkmB7KnD2Az7VeuBgujRj3RU8QX0P8GQOhpGiZZ4HhoR6knhqPhOf4nuGySl6tpdDFAwGfscWWc99+lt731eOsDZLd5kS70wZeF5eT0T0RAGAJoQMS0Pz94UX3AuOQbIAYD9AGhtrGz2Nzma7SsOGGL9MzLA0bEp5VLr0c7jpmaHPwkqiLFIUov1Rci4l56Frqo8vqAR2vMZZ9oerbQis8eHvjhFcjAwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9s7QEHa9n2gu4UFKFF1iRn5LzoR5hrMJc/w6aMY+x4=;
 b=Pe5TSqY0F3Uxa+vgqPIaPUq1MqgePxghd0Vz3HOyCAzwoYe+d1Hqxr1d1m+ljUjyuZwm8qEWUUV5Zy2XJ4Xir+9BLQrVSptt72FjnaaRcvjeB0FhZ+Mh0Oc+B4Xr6OB7A3hUm/qnufT9NjkhyCrjvV2CqiShpU4rSB4ndWIFa1B+xXmAZ0eNfvDlJZp1IbqOMl7J7Bslyv86zKSicMX0V1gzwXZ9LP+lBENhYlalUdTRhFpE9xPNeIaT05Pc1RkkEKYBPJAn+ZKCiPgOU8cvM26k0ndRO9jxdVPBgzQrfHnLz1pNVztl/CMqjzesxwchtej1YZAcXKigMd67pIehTw==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY5P282MB4893.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:26e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:10:16 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:16 +0000
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
Subject: [net-next v5 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Mon, 22 Jan 2024 17:09:38 +0800
Message-ID:
 <MEYP282MB2697D7CFB233DDAE83F74988BB752@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122090940.10108-1-songjinjian@hotmail.com>
References: <20240122090940.10108-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [M1Hdfatq5cpHCrBAUaz9vobZCr4XfPIz]
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240122090940.10108-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY5P282MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 50ce43c6-b7b6-4750-f597-08dc1b29f305
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+Q2HEwoVzMN5GXiu1uBXKs3S45nxTwZfwejg3zu8NaHMwoqNaJRyQ1lbh5Qe2jxkbGfc3SK45nC9mpEwbm1YmeZLhIGC/0hGduzNZa9/PZ6iw0AeWWNp5aWGme5BwpEJnzlQQLoxXYaRvnKJ+nLYsYK11EFiOV9Hfe8Hhzj4+8vV/vHJaa6jNIYRKmynm+H8SWYnvcrxZVPlmIcpKBSUN90Oy8ZRApz68Bs5aaQGic7FJI0VFfncVQJuPwdckNoSdewfu9gX7WStiFipdhP6yH0x+XH1sxQohQUEfOMyU8FTJA+yHjRGtSs9X0SSoorFxLDWIhcbsdatUW6fT+CzVenGFF/1x4zig7vfiBjJ8jD6VRLLRj3YJzaGnSJ/UBqkZ63817wtpKn5ycO84iIa9j4EKH4kBhYfPestFVZwktjQAOWdndqkcOuz1cFLnLmFPSzo3J1w3zjV+w7lhXoqjI81Evlp7OemGkdaSjfmC8hn7xdA/6N1YdxroU2aBy7w4Mf3dniSlssgePhYWDEN6LV6xm0RyP2+UyfdfmRi1CVZVhf//cFVUv1ElnpQ26g6
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OURFvmfzUZ7Y/uhNH4V+0+nSE8b53hfn3Dn8Oe5kt/O4odr5sVk7eOdfcDGn?=
 =?us-ascii?Q?SbVRAnnJBj9Y/V81ptCJKym2vD3dCgoEJ2mh8wXd9/vPJD48SPC5tAKcWz+F?=
 =?us-ascii?Q?XwKA/vOdRGXfuzKamN+nlZPDK2Gy25c9z1JHyiwpI1yA4lEASZJXD5yWHLpT?=
 =?us-ascii?Q?uvsVEBP4YNmit8MPzY8saD4UQyK/tYknrj4ZcdPgNCgtYIM9Cd8WvP9/Z1tt?=
 =?us-ascii?Q?OHgE90doV7/tbPJXzZrFjhCYeSrG3oZj6ma2nq2PFegdyUCtUEHBPCG0Oiuh?=
 =?us-ascii?Q?9McsTfbAHr3wH0Mq86FxBQRTSQu9bPwDOSY1Uu4n71PuLdrkL1ErQkagnz6N?=
 =?us-ascii?Q?aNIa0kTWvZkhrTy2Cf12QqxB8uBbanPIJ4xHPEv3Y8+VZUpXT5irYnXcJcxn?=
 =?us-ascii?Q?qX4zqCB/QQpy97YMR07ITLSqfBklnQ0388tV4hJ7UUdzY9wdmse3VVvuVjRv?=
 =?us-ascii?Q?voQA5/3osp5WczB/hsGbelagSEH9QV+KFdVqvqEBgbO8S5fJmKYvl0iDxkog?=
 =?us-ascii?Q?HaXbDw7Mu3oSQnn1qrr4EKK3F9DUy8F/NGuIeOwPo+8jF+DGDJqawuj3MnXL?=
 =?us-ascii?Q?B7dctcL/k9xxakxzLhQ48tbB8njkglAKMZMi3C7WvfCC++P0+Idt6pcscpKE?=
 =?us-ascii?Q?pUs11pKIYslPNJN+yefGJaB5Sy0GB/LBUpPaaD01+5zCcDnwR83fIZ+GOvdi?=
 =?us-ascii?Q?/hdDVAZ5nuT4FzEessN6iXH7Q+3W5regxhJsLg5fjcb6qJEdEaEOltBW6cq+?=
 =?us-ascii?Q?6L4MF1IbVfgrekmYNRIN7Mkog9hsLlGI55BAJIJsN6IXbi8VhA1OmyETuqAP?=
 =?us-ascii?Q?gjqJFqs8m0V4w2mdUrw78nYWvOaSUCs5sCScSeGivFJ/dmqQbcaN41o6tjrD?=
 =?us-ascii?Q?3U2zNMScEddelxaAQFtn0zw5pdKNBQxhgAXeF8QFoolhGhTAXKckl1/4be08?=
 =?us-ascii?Q?8UVf2iYkx1ml6K18bj6mcDtM/GNwKQliXAohsly79ha93fOHlbuQ49ltSGET?=
 =?us-ascii?Q?CIh/cvkBcQ/vIXRVtIHRua1MBhD3cB+U9PVWGwgHqgpvvqm7TcXDKGD494vd?=
 =?us-ascii?Q?jN4n6Joj3bT+GYasyK+3xL7dGnewztaCWXvb0YI+1We7v8MbjxdVCLhdHUGn?=
 =?us-ascii?Q?bjnlikqPoa+/kp2PuGBBhuCLUg70pdgm3yGHpC3OX/pMZ1FE4twDZAQZXicB?=
 =?us-ascii?Q?52cFjwR1xvHg9/9p0ddcC9W9+Foi1br0pW4fYd8G7c0VlWkgZ8Q0UQk2sGY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ce43c6-b7b6-4750-f597-08dc1b29f305
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:16.7257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY5P282MB4893

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode,
e.g., reset/ready/fastboot mode.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v5:
 * add cold reset support via sysfs t7xx_mode 
v4:
 * narrow down the set of accepted values in t7xx_mode_store()
 * change mode type atomic to u32 with READ_ONCE()/WRITE_ONCE()
 * delete 'T7XX_MODEM' prefix and using sysfs_emit in t7xx_mode_show()
 * add description of sysfs t7xx_mode in document t7xx.rst
v3:
 * no change
v2:
 * optimizing using goto label in t7xx_pci_probe
---
 .../networking/device_drivers/wwan/t7xx.rst   | 28 ++++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  6 ++
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 96 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              | 14 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |  1 +
 6 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index dd5b731957ca..d13624a52d8b 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -39,6 +39,34 @@ command and receive response:
 
 - open the AT control channel using a UART tool or a special user tool
 
+Sysfs
+=====
+The driver provides sysfs interfaces to userspace.
+
+t7xx_mode
+---------
+The sysfs interface provides userspace with access to the device mode, this interface
+supports read and write operations.
+
+Device mode:
+
+- ``UNKNOW`` represents that device in unknown status
+- ``READY`` represents that device in ready status
+- ``RESET`` represents that device in reset status
+- ``FASTBOOT_DL_SWITCHING`` represents that device in fastboot switching status
+- ``FASTBOOT_DL_MODE`` represents that device in fastboot download status
+- ``FASTBOOT_DL_DUMP_MODE`` represents that device in fastboot dump status
+
+Read from userspace to get the current device mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
+
+Write from userspace to set the device mode.
+
+::
+  $ echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.c b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
index 24e7d491468e..ca262d2961ed 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.c
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.c
@@ -177,6 +177,11 @@ int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev)
 	return t7xx_acpi_reset(t7xx_dev, "_RST");
 }
 
+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev)
+{
+	return t7xx_acpi_reset(t7xx_dev, "MRST._RST");
+}
+
 static void t7xx_reset_device_via_pmic(struct t7xx_pci_dev *t7xx_dev)
 {
 	u32 val;
@@ -192,6 +197,7 @@ static irqreturn_t t7xx_rgu_isr_thread(int irq, void *data)
 {
 	struct t7xx_pci_dev *t7xx_dev = data;
 
+	t7xx_mode_update(t7xx_dev, T7XX_RESET);
 	msleep(RGU_RESET_DELAY_MS);
 	t7xx_reset_device_via_pmic(t7xx_dev);
 	return IRQ_HANDLED;
diff --git a/drivers/net/wwan/t7xx/t7xx_modem_ops.h b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
index abe633cf7adc..b39e945a92e0 100644
--- a/drivers/net/wwan/t7xx/t7xx_modem_ops.h
+++ b/drivers/net/wwan/t7xx/t7xx_modem_ops.h
@@ -85,6 +85,7 @@ int t7xx_md_init(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_md_exit(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_clear_rgu_irq(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_acpi_fldr_func(struct t7xx_pci_dev *t7xx_dev);
+int t7xx_acpi_pldr_func(struct t7xx_pci_dev *t7xx_dev);
 int t7xx_pci_mhccif_isr(struct t7xx_pci_dev *t7xx_dev);
 
 #endif	/* __T7XX_MODEM_OPS_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 91256e005b84..4c3f70f92470 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,79 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+static const char * const mode_names[] = {
+	[T7XX_UNKNOWN] = "UNKNOWN",
+	[T7XX_READY] = "READY",
+	[T7XX_RESET] = "RESET",
+	[T7XX_FASTBOOT_DL_SWITCHING] = "FASTBOOT_DL_SWITCHING",
+	[T7XX_FASTBOOT_DL_MODE] = "FASTBOOT_DL_MODE",
+	[T7XX_FASTBOOT_DUMP_MODE] = "FASTBOOT_DUMP_MODE",
+};
+
+static_assert(ARRAY_SIZE(mode_names) == T7XX_MODE_LAST);
+
+static ssize_t t7xx_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int index = 0;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	index = sysfs_match_string(mode_names, buf);
+	if (index == T7XX_FASTBOOT_DL_SWITCHING)
+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);
+	else if (index == T7XX_RESET)
+		t7xx_acpi_pldr_func(t7xx_dev);
+
+	return count;
+};
+
+static ssize_t t7xx_mode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	enum t7xx_mode mode = T7XX_UNKNOWN;
+	struct pci_dev *pdev;
+	struct t7xx_pci_dev *t7xx_dev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	mode = READ_ONCE(t7xx_dev->mode);
+	if (mode < T7XX_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", mode_names[mode]);
+
+	return sysfs_emit(buf, "%s\n", mode_names[T7XX_UNKNOWN]);
+}
+
+static DEVICE_ATTR_RW(t7xx_mode);
+
+static struct attribute *t7xx_mode_attr[] = {
+	&dev_attr_t7xx_mode.attr,
+	NULL
+};
+
+static const struct attribute_group t7xx_mode_attribute_group = {
+	.attrs = t7xx_mode_attr,
+};
+
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
+{
+	if (!t7xx_dev)
+		return;
+
+	WRITE_ONCE(t7xx_dev->mode, mode);
+	sysfs_notify(&t7xx_dev->pdev->dev.kobj, NULL, "t7xx_mode");
+}
+
 enum t7xx_pm_state {
 	MTK_PM_EXCEPTION,
 	MTK_PM_INIT,		/* Device initialized, but handshake not completed */
@@ -729,16 +802,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
+	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
+				 &t7xx_mode_attribute_group);
+	if (ret)
+		goto err_md_exit;
+
 	ret = t7xx_interrupt_init(t7xx_dev);
-	if (ret) {
-		t7xx_md_exit(t7xx_dev);
-		return ret;
-	}
+	if (ret)
+		goto err_remove_group;
+
 
 	t7xx_pcie_mac_set_int(t7xx_dev, MHCCIF_INT);
 	t7xx_pcie_mac_interrupts_en(t7xx_dev);
 
 	return 0;
+
+err_remove_group:
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
+
+err_md_exit:
+	t7xx_md_exit(t7xx_dev);
+	return ret;
 }
 
 static void t7xx_pci_remove(struct pci_dev *pdev)
@@ -747,6 +832,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	int i;
 
 	t7xx_dev = pci_get_drvdata(pdev);
+
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..0abba7e6f8aa 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -43,6 +43,16 @@ struct t7xx_addr_base {
 
 typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
 
+enum t7xx_mode {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_DL_SWITCHING,
+	T7XX_FASTBOOT_DL_MODE,
+	T7XX_FASTBOOT_DUMP_MODE,
+	T7XX_MODE_LAST, /* must always be last */
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -59,6 +69,7 @@ typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
  * @md_pm_lock: protects PCIe sleep lock
  * @sleep_disable_count: PCIe L1.2 lock counter
  * @sleep_lock_acquire: indicates that sleep has been disabled
+ * @mode: indicates the device mode
  */
 struct t7xx_pci_dev {
 	t7xx_intr_callback	intr_handler[EXT_INT_NUM];
@@ -82,6 +93,7 @@ struct t7xx_pci_dev {
 #ifdef CONFIG_WWAN_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
+	u32			mode;
 };
 
 enum t7xx_pm_id {
@@ -120,5 +132,5 @@ int t7xx_pci_pm_entity_register(struct t7xx_pci_dev *t7xx_dev, struct md_pm_enti
 int t7xx_pci_pm_entity_unregister(struct t7xx_pci_dev *t7xx_dev, struct md_pm_entity *pm_entity);
 void t7xx_pci_pm_init_late(struct t7xx_pci_dev *t7xx_dev);
 void t7xx_pci_pm_exp_detected(struct t7xx_pci_dev *t7xx_dev);
-
+void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode);
 #endif /* __T7XX_PCI_H__ */
diff --git a/drivers/net/wwan/t7xx/t7xx_state_monitor.c b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
index 0bc97430211b..c5d46f45fa62 100644
--- a/drivers/net/wwan/t7xx/t7xx_state_monitor.c
+++ b/drivers/net/wwan/t7xx/t7xx_state_monitor.c
@@ -272,6 +272,7 @@ static void fsm_routine_ready(struct t7xx_fsm_ctl *ctl)
 
 	ctl->curr_state = FSM_STATE_READY;
 	t7xx_fsm_broadcast_ready_state(ctl);
+	t7xx_mode_update(md->t7xx_dev, T7XX_READY);
 	t7xx_md_event_notify(md, FSM_READY);
 }
 
-- 
2.34.1


