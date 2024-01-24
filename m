Return-Path: <netdev+bounces-65534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA80E83AF01
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9358F1C254FE
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A30D7E58D;
	Wed, 24 Jan 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="u5sXm4DN"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2175.outbound.protection.outlook.com [40.92.62.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97F7E580
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115656; cv=fail; b=KzoIUBmi6iR02/NqmlY/DTRmoVhs2i3rDGjvRzHkFezd4E8nduY86Ny2XTSZhKNqFnYa/2zWgT2+IPiAJwVqbZwCLBCWCuTPZzdqwfiQacV6NOKAErW0w5/mt35DrmKNMUQYde+5HcGgH68LKXUmgC400sj9OCikbD3y1To0OGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115656; c=relaxed/simple;
	bh=CV4ZmaGba1te4KGpKxDA9t+gCwzaiMIBS99zfhN3iS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OHUB3tR+HB0roevD77NkTeeAulYaLxV/kwaQ/A/VBxZeGM5TISJ8jXCb70zoWVAb7sXp7J/lm0iy0DqPQgtjnldaZSGrZ3eYmaVnYCMcn2PTS4ckSss5w+rlZsFTRYRmyPgCfrskO5VFAGxjZAcsjknI4tyYaaGopizhGqiSIfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=u5sXm4DN; arc=fail smtp.client-ip=40.92.62.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewrEFVDdqqAnxeg7LfmNiAOvvCY2L4u6pbz8TATKQtrzaCyhGXPDC7u7qAKY8oEnwagN2mDHG0EcdRVxqRWGT24wGSp3sZF6sMj6eAsn7euRX7hQlwK43f5VqAjHC850Mn+vocxrVV+J6rqNLmj4l9iYjNUQUTXnpygU+ONYZgKmNv1C0yiPmxvC2FFMwkZBm1q6RmnrBHtjlg9XDFfcdwYXwFISfdvxNC9w869vrcaObIpqjn77MFZzysEjE6LPDLp87zErMctJkfdrXybG9KiozGYt4z5mWb/BxUuy9xXe24upQM9a7EV/9qrzoT9vFtaNGSRky7We6ew06eSq5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iiACtjaGoJg24eJ4T8qz1rVfeodmpekMlTLOZ6RW5uA=;
 b=aYdQbWNsEnATW0l2y1mURcQgZD/UiCLI3WTjLDeDMeCPAvdDo/9YKJeAR3vQnIuc2nL6X4FDpyXvNTwAXE5KpJnm2d5GXUmJQ0C/jVB13fOqruIVgkpY3HrgaVfgV+ND8bneAdvtaiIY8DVrURCdulYfasZlvT3Ia7wPi/Yfs8prUpVs/e14DZjRJ7siyph/LjU5SDXWHD2C+tY0M9Qlx+2gR+0yXl1d7KXicopRdvgCBGcMJDfmTdjfOPH/BuZQLzKUNCwjJ5qwX6FHDKNVSH/tUfdrAWJlTizo4JIw8xmhdT4U57XLmPQzNIuNvwFHhxcgj/RDRJoPpyINnewjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iiACtjaGoJg24eJ4T8qz1rVfeodmpekMlTLOZ6RW5uA=;
 b=u5sXm4DNYYDPRJe+5UXdiryuOy+mEjSyrhlUgXzh97Ivm1pqoVOphcgm6UK9ds4XMs1Dt5IaToN1dzpTjNmUdTEAwPISudeAcGXE+Glg5t8g30okub1UbhEl6M8sLWlMigW25wcXGxJ5BXFrkl3aMY8U7g3GxqhAvvXOQ6g7y2TvsptK798RIXg7jwWWkGTJyT2rzT/aP8caM14EoKfnptLo+je8BaJ9YvezhWTkmDg96qwsEgMNESuNf89XxfJ2kLTqh/H66Gh9h+kIOM4Lqea9FX+V+7gbZ3KN17FIdOulTx8Ml5I42xPub16Lp3OoDw4qmcjheOwOu57FUL/3Dg==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by SY8P282MB4480.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:258::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Wed, 24 Jan
 2024 17:00:46 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%3]) with mapi id 15.20.7202.031; Wed, 24 Jan 2024
 17:00:45 +0000
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
Subject: [net-next v6 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Thu, 25 Jan 2024 01:00:08 +0800
Message-ID:
 <MEYP282MB2697447F0AFBA93A9033DE23BB7B2@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124170010.19445-1-songjinjian@hotmail.com>
References: <20240124170010.19445-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [hqr2Tp0GR9eRSiROSO2lUfEA2ju8quCO]
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240124170010.19445-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|SY8P282MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: c009ea5b-bda8-4eee-8a09-08dc1cfe01a3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JLP7Wd83Pmub2BmHJ3FfvyHp01ddmTQTolQZ/af07BckZ6F7fFJQPxz4vrricH5ojQ2iP3gJ06pz6JwvFz265a59Nvt7uKB7m0rDuaSf50F+Gq0l2eUs/LCDfCsXsyiDVbRCnxAgtg+CUZ7q15AIxb2OfqcKvioB9nDM+4h4o6c4Z1te1Z7wQFOADqbMKEc3WuVwgoSZvvatWIO8PBfVYvjYGyuwsuEIxBbhmtPTKSadted7Oht/vTpOCk2l5pSaVYLOAHNrvS2o6q/nwLrDw8+vSebjZfT9kAsNtaC0jYJpEE37Z6EQ02KzIpbCyU6HTOjLVOERwQzxk2XxrF+CZyB/S4M2GqydSzztg4lp1+ugG5LvsHEedsTDWhYXzmXP16tEHCMcEf2ijYroniwf+0gx4kDbBlrxRotxVWLzywBlpAwY65+QVBgoIWy4minDqw05Bq9p49ioWA6W9SJs6GmhzpOLUmYzgSWsnq5v7f/Emtfpinlxlf1XCdW3TLbs4gnRblMF+m6hmAVK15zvxQK/o8nBQfQkz7mOTklm+NXn5VqNUQKURrAdAVjNZj4g
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bTvNYr7+vBd++AoBqYmbwzHr3QYu37o24sKk764as4a1HkNLjT5j56HO3EHq?=
 =?us-ascii?Q?yUh5zqXeLWaZEJFwITeqJfuY/Dnwo2JjHf3z+/3HIMlmYU9q52fok6ciq1Fo?=
 =?us-ascii?Q?RjQtKhry7rz8tNTom+pRNOLtHfUiNfl5x0TWr8LGKurO+ISmiKz9jJ5ny8Gc?=
 =?us-ascii?Q?x2ajKpK9s2hHmOHAkqu/MPU0nRJ0kwn8t4HJfc9/3/4jv793acjge4u+8XpK?=
 =?us-ascii?Q?9/+jDMEJ9bI8GDYF1deMEdDhZFyUsOg9lbfRxL1uDddebzyCOuMS5Es9W3Lo?=
 =?us-ascii?Q?8uF9Ii5BfaFgQ1UwsNl5rVRCfvNaG6PD9URUZicBRkMBQmX/YtBUSizwZyw3?=
 =?us-ascii?Q?a3tn/ztpHmDuUq1dVlF8bhsDohstZVtQWCEhHM2TLN7vhwN78vr966x2XBfI?=
 =?us-ascii?Q?ZhEZpuF8zrwBi0xFfhs7YJza9xOabXeYH0UihGMQcoG7qOv4ryEGMxWPH2q/?=
 =?us-ascii?Q?tK+kdpsXEBMspyplAP9Oo7wdV5mJb4mV/iS0OJe0bpAypZuWN3NubXwxmS/G?=
 =?us-ascii?Q?rn7RPdEzTAoJzWankGS3PW4g8QsZt0eGYsooaR88AghEOQ4heCmhjbSUDR85?=
 =?us-ascii?Q?jaoi3h0i2iX+1fmpMDn6zweqidLjBnPMFOew+/ULZNc7+Kl2mC7rfn9N2rT1?=
 =?us-ascii?Q?I91Itn1DK0MzI7F6QAddyIGTMt1Cwas3WhLlMB5LQSo+A21fJhpQioX+/U8b?=
 =?us-ascii?Q?KfICQIiBrfJrDTYr4MVHYC1I7oCdKFgCONM7o9LGGjrkN0O91gLClhmAW6Jr?=
 =?us-ascii?Q?rdiFXkvn/YC261zAdmEN2lRhFfkU8AXPvJSaqR6rQ49ShlGJXk8MQ9qkO6J5?=
 =?us-ascii?Q?/Mb+rQEqI+/V3oLtUkoJwOtBM9FSPG+e/HI5U/Hx/AW5WCaFZ2+f10aIAbMh?=
 =?us-ascii?Q?Yf2YtaemVbsaaNIrvjCOSD3rhwdm2ueYIzjw1ZOSwWeyXfbYDQjg9XDYWoX8?=
 =?us-ascii?Q?ehFnr6s3LEsdGwk5JkfHO/SI707SXtJhGOxZ5qW8QbQSnS9PV6jP/ANrjD3T?=
 =?us-ascii?Q?25I3/N8ZtMvQd+9ZY718nOU1L0W5VVgIkPZgECFxuqoy1gm9bqnlveqEzwK8?=
 =?us-ascii?Q?vLoTGwQKER8SDAgaUyBTGc1Kci/I4UJxX87XvtuuqGYDBbkca7IYrZy6vgJn?=
 =?us-ascii?Q?DuQVz9Fwg/ThGuyjkbRijPRLOT9c1VO0xCVACf1hdtCMc0KLDlxGv5cidjwT?=
 =?us-ascii?Q?OCnrHyuGkZKvFWIVznyC6TYqbdVfd+WztDigORIULGCwBBB0WoZGzUpe4Ek?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c009ea5b-bda8-4eee-8a09-08dc1cfe01a3
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:00:45.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB4480

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode,
e.g., reset/ready/fastboot mode.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
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
index 91256e005b84..3776bd8650a6 100644
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
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+	int index = 0;
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


