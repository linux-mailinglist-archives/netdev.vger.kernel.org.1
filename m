Return-Path: <netdev+bounces-69069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3458497AF
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 11:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24CF281C53
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750A168DA;
	Mon,  5 Feb 2024 10:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="G8imkZ+F"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2157.outbound.protection.outlook.com [40.92.62.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433FC14AA2
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128611; cv=fail; b=RnmXrGqvcfUVoRgHy74gbiGh4Lf1zZQ0V/iGRYmcOEaGD3P+rPyEurQqim0JZo11y3zPlFVqGctjUsXKQOGsoBXvRbFejmFJnn0WaT3hbkWiby206LErpXADh2831R1csHEQz5TWPlIgxoAQ8N4i8/YoG9WhsdaAAlIUXHhYOkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128611; c=relaxed/simple;
	bh=uKjTtuDIfIrMaCH3HeRrnWWuOCmRvK8C+lG5FootX+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PoxHo3jMW9XCjNW2muGxk55acQ1+jUEjGGWXpyLHjVkMR6cd1fZ5donm59QGyZT6GSr8RWY2tWpfMR/MXJzx951y1ny4x6abh4SPpfLFp+POivkMabA0kYlqeKfD5LE0RvuqzORU8FHLR+zKC/+DYoa0xNm/40e+RhwztAm1RGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=G8imkZ+F; arc=fail smtp.client-ip=40.92.62.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6CBTNKAFf35ginvCZDnH6F3AbEitQ6IYYA4ia+J/2S0TS0KvlH2Yv9zXnVLVyywIQzWHjUHRm5jltrnnJ5J3eJvjRWyNp/Zd4Rf7MkvqIW3d7U+0JxXVj4SionzQ01JYscw7y0R7hiao7mrf+Zc3InJroHqG0jWrYoFskyNNup7/o1nS7l2WKib4L4W/iz6C/+AJyoax4ow2HcotU6sM/hbjim0PLDIzF64YELv0Sawoxae2WxrQJQ3EwmjSeLpvm9kdEL4lb0cpFfAWN7HB9zGj8vSUH5qv+fqrlFNc2D0Zq3tU7EcEw4qc6nu0Mqp3yX1tEAdGUW9F3N0FY68Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwDo8w5FRoVvf/S0qQNguBb0hhrKs4wcZvFIF5utdHQ=;
 b=kUbGkWMFjai9KLBvrhciZG5KJjwIFPTWDpOxB+teBB/PRlSFCuntmAq85p4SuUY/2Ps9MIkAp7PbTemjKwUz9cPNxn/8LehImDuPAnYWO/r/8+6FkiC6tdlEuv0MEUk2CQFXbsX4csnq8tuxch9UmBqpzLnaR8x9iZ3gKCinfJ8+z8gXu6eFJgiCvuZUUCGKGHutWnADamNjDmH+F/UfTPz2IZwimVqv3qa1LQtgBRjVOHLA7h/VrgtkbDqpWyQpheNrw5LzFzlD9cQm7Hgi5jxz9Yj3+hNPncvOrWQ+7ZaC83qyUZlmoyVt49pTL1KKZo8pveS+qYvRRzaagJLkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwDo8w5FRoVvf/S0qQNguBb0hhrKs4wcZvFIF5utdHQ=;
 b=G8imkZ+FuBuRTIWtgw89RoBN2C1UwVNi8OC4GrAK7G0N0696ig3wnCWA6AIXefMPOGbQzKUrpw2y0uEjOXnZ97jTT41GhbxS/urrrAEKoNZ/PTzAPa9G5yAuTSXlmAwWLEaMeL8GZViQcsxN/c5tXn2hw8BUFWXTSurLb2BikmAWAyo+51IUybrPrZfm6rLsOgKdNHeeskuTgIe61rVOcGTUBH4h5hqsj9s+R93Ul79nWyS784lfNDzdWMa1pDyE+myxIJvB6LwpFPRUxdVCl8LZIiw6+oztFeS2B4eSIqBmw8DsckKZtc/6n8POuk5qjZV+5MAwqx1x7h3FD2Q88w==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB0886.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 10:23:11 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 10:23:11 +0000
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
Subject: [net-next v9 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Mon,  5 Feb 2024 18:22:28 +0800
Message-ID:
 <MEYP282MB2697248D37143B58DF23688FBB472@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205102230.89081-1-songjinjian@hotmail.com>
References: <20240205102230.89081-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0RbaLkzs21ivcyHjGgMbuH3BPZ+7O08M]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240205102230.89081-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB0886:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f695aa7-2dd7-46a6-ac65-08dc2634744b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Po14ygazhycDsjVBxcwN802xkX7KusNgDmA2hsCQznEdFArk6EL2Dyv8oxtJKoKJpZfwUIEj0LAaW1Wsh4cqOryjlhmzj8bpoeMicqnyTJ8t/pzdmKzY0Yb8JA80sd1TCucuuN5WTukPzCOsJliuynsr+JmQOj3zICFEmFePQ0xnr/UuqUUaZ948SOjXDFdZn8r1KUko+ruoqIBADw+Oyx0UWk27Kq3IlzVeoDlyS/J+r6iQcV50oKFbBNxIDsn8VVTn+MkAy95A3qBuPVzpkU2vOamML3FTuPGtboai1riW3WoQ7l/IOjdm1wLWOiJ8/EFmSXeqiarVrLx8/MlKndkBOfngdUqMOYMqnmqs6+oQCBCATDBVb5ITJAeBaMuEvgkucA7inonhE4TIHCXheV9jW41uFg2iFzrEt4JBETR++aPkDqUT6hxsfPuEGpkBA8tq1qheXZrkwbI7VQxCshF4g42ghwZNy2UlQ9lYZDJE8uKUeNfda/+BZk62vWjYH5pNd/oaQ5/ENQriEe6n5MNyHBjAp00l9XqvMGqCRMLhqeQGjKPOXt0fv6rkWxgX
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzQCVJGrW8auPBlFVo1I9j/kQSJvsHYqjeCVyyTbDOLRInpg6Ckh3hsinREb?=
 =?us-ascii?Q?SYXvPjZ7g0HVsioubVljdj12hDDWZiqHDYfdLfCJre0UbRtioZRt3ZDKBqdi?=
 =?us-ascii?Q?HrIc59KrZe9pT5GJMEfYzy9oFDE9gI2YVcW6kgs0q0VfLW6CsirRi5VUOkin?=
 =?us-ascii?Q?HdGACCPrkn4oKmXZWMGXSZv5xT6bWwu50uu/5u1ENzE2nAAUZ6qhthJJ3IyC?=
 =?us-ascii?Q?ReeBKqX7QOPbOzz0pv5nmyrxNbHwtmK+oSgGsDLxacGsHiOcNSBRmMtyu210?=
 =?us-ascii?Q?6z/Dy5E3QpsGEq7DBfwtyMZgn+FuoeIRFot3WXaIgknbRItPfAaVCKyOdJYt?=
 =?us-ascii?Q?NfFAC2T7gvmU8OcHF5ukrbEbNRuKYj4regnd5AGBL+umdAvRJHyIevOHZ/8S?=
 =?us-ascii?Q?JHBuzSrSgmYFjvYtk6Sr6xMz07+DJ2/r0Uk7tBULMx5zKrfL8+N7gfbKIU6n?=
 =?us-ascii?Q?soM+wvKyjt0Qt3cePlFfoNRt/yDUtUyb9tnyc/JVbmtcvhSqKfIpjS15XWFM?=
 =?us-ascii?Q?c+bOve5sTT2Nn0Tsw9bqlXLBu5JMY5KhNsyn0DSYyOtjjfqC8NeH+DsjmPBC?=
 =?us-ascii?Q?qbvpIeaLd35ZtBzwULsDb4acJay8peVv08oPt7JdVQoZHLxugfpAksXiUBdg?=
 =?us-ascii?Q?S/1WN9YBOPBNi40bGLGsM95Cy9OzooK/ykAoCHbgVOLznclSI3zwDExUbF6w?=
 =?us-ascii?Q?NLlrc805LjOr9ZmwJDYlg0sV2L+Nlkmx/Eb+YaK2Z3Qw17DQVEbuwjrP1HbL?=
 =?us-ascii?Q?J2Eeq4BP4PQYNRyS2vDcRWB0wrtVmtModxrkaGw/ExOu+5CynsTz7W0ux5i7?=
 =?us-ascii?Q?2T1prSBl9ihBMg/1zZQtVwNDR7jvNOSrcRREyBMu3A+OQSVm3ETj/deJcAar?=
 =?us-ascii?Q?t3w93qDFYgXvgzi4VBPSRxKDsJiuYIt+aki54l63DGO/got3GVIjToLzNw4s?=
 =?us-ascii?Q?5cI071n9oXu8feEwfmYtBhNKZcBX1PNp0ZYuQYP2wNl+eZLb8/oUEfZedNr5?=
 =?us-ascii?Q?N3lfExKsi+giOXvnABCSzGSOFNVgvHkCYGpfxSVSAsI+PXC7c51p1MtPxf8F?=
 =?us-ascii?Q?KN/u5myHVQxSI/kQvtcFI5tAZVvAvWUCiUdiXN+A9tJvJOUCOIYYPM243pd/?=
 =?us-ascii?Q?RaIp9UkphUb9iUxIU5a8yCCzmxGNT2R5atmqZz0z4qOxBFPEyegGZp1a3ce0?=
 =?us-ascii?Q?tKsRObTezcanbHFPGj8wfFc/icbRVDaSQBTztRvEeIGzNCmUGeRnk6jkDuM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f695aa7-2dd7-46a6-ac65-08dc2634744b
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 10:23:11.4492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB0886

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode, device's state
machine changes between (unknown/ready/reset/fastboot).

Get the device state mode:
 - 'cat /sys/bus/pci/devices/${bdf}/t7xx_mode'

Set the device state mode:
 - reset(cold reset): 'echo reset > /sys/bus/pci/devices/${bdf}/t7xx_mode'
 - fastboot: 'echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode'
Reload driver to get the new device state after setting operation.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v8:
 * change sysfs t7xx_mode to lowercase, modify spelling in UNKNOWN
 * change sysfs mode_names to t7xx_mode_names 
 * add t7xx_mode check in __t7xx_pci_pm_suspend() 
v7:
 * add sysfs description to commit info
 * update t7xx_dev->mode after reset by sysfs t7xx_mode
v6:
 * change code style in t7xx_mode_store()
v5:
 * add cold reset support via sysfs t7xx_mode
v4:
 * narrow down the set of accepted values in t7xx_mode_store()
 * change mode type atomic to u32 with READ_ONCE()/WRITE_ONCE()
 * delete 'T7XX_MODEM' prefix and using sysfs_emit in t7xx_mode_show()
 * add description of sysfs t7xx_mode in document t7xx.rst
v2:
 * optimizing using goto label in t7xx_pci_probe
---
 .../networking/device_drivers/wwan/t7xx.rst   |  28 +++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |   6 ++
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |   1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 101 +++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              |  14 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |   1 +
 6 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index dd5b731957ca..8429b9927341 100644
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
+- ``unknown`` represents that device in unknown status
+- ``ready`` represents that device in ready status
+- ``reset`` represents that device in reset status
+- ``fastboot_switching`` represents that device in fastboot switching status
+- ``fastboot_download`` represents that device in fastboot download status
+- ``fastboot_dump`` represents that device in fastboot dump status
+
+Read from userspace to get the current device mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_mode
+
+Write from userspace to set the device mode.
+
+::
+  $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
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
index 91256e005b84..f99eb21cb8cc 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,81 @@
 #define PM_RESOURCE_POLL_TIMEOUT_US	10000
 #define PM_RESOURCE_POLL_STEP_US	100
 
+static const char * const t7xx_mode_names[] = {
+	[T7XX_UNKNOWN] = "unknown",
+	[T7XX_READY] = "ready",
+	[T7XX_RESET] = "reset",
+	[T7XX_FASTBOOT_SWITCHING] = "fastboot_switching",
+	[T7XX_FASTBOOT_DOWNLOAD] = "fastboot_download",
+	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
+};
+
+static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
+
+static ssize_t t7xx_mode_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	int index = 0;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	index = sysfs_match_string(t7xx_mode_names, buf);
+	if (index == T7XX_FASTBOOT_SWITCHING) {
+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_SWITCHING);
+	} else if (index == T7XX_RESET) {
+		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
+		t7xx_acpi_pldr_func(t7xx_dev);
+	}
+
+	return count;
+};
+
+static ssize_t t7xx_mode_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	enum t7xx_mode mode = T7XX_UNKNOWN;
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	mode = READ_ONCE(t7xx_dev->mode);
+	if (mode < T7XX_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", t7xx_mode_names[mode]);
+
+	return sysfs_emit(buf, "%s\n", t7xx_mode_names[T7XX_UNKNOWN]);
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
@@ -279,7 +354,8 @@ static int __t7xx_pci_pm_suspend(struct pci_dev *pdev)
 	int ret;
 
 	t7xx_dev = pci_get_drvdata(pdev);
-	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT) {
+	if (atomic_read(&t7xx_dev->md_pm_state) <= MTK_PM_INIT ||
+	    READ_ONCE(t7xx_dev->mode) != T7XX_READY) {
 		dev_err(&pdev->dev, "[PM] Exiting suspend, modem in invalid state\n");
 		return -EFAULT;
 	}
@@ -729,16 +805,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -747,6 +835,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	int i;
 
 	t7xx_dev = pci_get_drvdata(pdev);
+
+	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
+			   &t7xx_mode_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index f08f1ab74469..49a11586d8d8 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -43,6 +43,16 @@ struct t7xx_addr_base {
 
 typedef irqreturn_t (*t7xx_intr_callback)(int irq, void *param);
 
+enum t7xx_mode {
+	T7XX_UNKNOWN,
+	T7XX_READY,
+	T7XX_RESET,
+	T7XX_FASTBOOT_SWITCHING,
+	T7XX_FASTBOOT_DOWNLOAD,
+	T7XX_FASTBOOT_DUMP,
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


