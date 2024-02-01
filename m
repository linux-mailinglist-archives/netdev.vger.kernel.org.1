Return-Path: <netdev+bounces-68042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70609845B0B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC075B20FD1
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E686214C;
	Thu,  1 Feb 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="aTi+GdlZ"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2144.outbound.protection.outlook.com [40.92.63.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466C24500F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800481; cv=fail; b=otIe3orNewXyIcAeX5p7U1m38gbfoTllxHDOppcbW9Z8LueqXs2OPUNRQSSE97xel1lxkD03wdqYdXXHx4Sdcvna+ja9GPcRKsT3JI6KbWcEca5qdGJTw+mtVeHqiN6Lj5fva/R3ZERJ/yoAR5IfAK+qQk+5XvgDq6/Wh8AqGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800481; c=relaxed/simple;
	bh=mVsNdlABjyQvB6grxQ7pWryCQ8gEtKU/7G22oNoRMQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhqRpAYQVMaT4D7NAHqp+rOLR4D/2a0jcU6VMnRR2kKfj7hqGF/6BWKLZK3rBMpyzd9rdGBn4592Znmj2jMpEx47i5UIQXIexiFLxWj68S19Yz25tiegZymGPFIYYhPYVix6jhTA8b/9F49PJjmC7Vae8PbNXyXkJOPPV+HhCi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=aTi+GdlZ; arc=fail smtp.client-ip=40.92.63.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmA5YIo5+8W0WFFZH2DcZQHiWxES4xuniQDhRhdpJMltQIKTDE93W9OuNX2IwR7IyY0O2hDlh4nlvc5Tos6ErD08y6HRwjvtt5H7WZ1+fogegbq83KnwfZiIscwwWiK7i6lc6dwP4uc7h2WeOJOcLNV1AnyXCjxHD9F6Dam4D4yIyF2aShjBBMZj8Bcsfsdxu9z030QAEC6VEBNsvUOlPSWlrMhMhdcRvYpquSTQYSMmBy28/OCRpiliVBOPIkOemAZWJy0snTTDvDzYI7NLdon1J1WmlHVKfNvkhJwTsbBRdE97BRZRHLsa/B8UFmKvcpBztRNqsKpDZKlZQPkMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn0lU6B9OopGvLMxAoCB3hpfiC/suxxjDxovM4lj5X0=;
 b=NjiL3ERpXsLxIXMcD9Nu9gvccWiAW/z2HJUVxCYxAyYEJc9KRtfzA7sMINbSCGhbIoclmIRwFJWv9VapLXyP+vvXRYVGNyuSCep9xIXtGQfTrk62rKApvUBnn0pw9tQ+daeCybwz1jqZa5sPoDZyKD1KZXCB6Me97q7pgi1AnSvMu7brdNJk9yiK+QhcHLLMY/7pquKiZHVKq2GSgtxYwxpdBSnQUzt637gVrS93Aw1UL1QAge07JDdw+55yOxLRAFR4WAFTXkvd8GvYQsnQsKv1YDyKMVtJ4oWxt74/E1C/NuHjwq87CewszeJHBrbS8GtPzbaRXJLW1u/1hN15lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn0lU6B9OopGvLMxAoCB3hpfiC/suxxjDxovM4lj5X0=;
 b=aTi+GdlZk08APfXclEzB68yO/pibHplNeb5LB9MmR3igUcXDgptjiPvdPhcAUvIXK39TxHVxobqAx0IN8+Ek5n65xHAtFIzcswem6TOaEiUfYBKfNaVtU8NIT9tvDC9Xkpu/8sqHPE7SLjfER/tEbO744FzezJ+3vYL77NnGDr53WIZK4tBFHByTUqHqn7dn2+ioFIaX7BNqxuF3DcgQYGogymPp/Qe5GGWICuKXHHuS19YutkbhEjTZove4RqRiv+cBiXoaZZp36KYbtxS28RwlV3WYMSuU8uFjX8zavuQysrpPRgzagcNLz+yZGyfZ1y2VEvX9CJbq4pwY0NIscA==
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:14c::12)
 by ME4P282MB1224.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 15:14:31 +0000
Received: from MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f]) by MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 ([fe80::4b5:c5db:e39a:e48f%4]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 15:14:31 +0000
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
	letitia.tsai@hp.com,
	pin-hao.huang@hp.com,
	danielwinkler@google.com,
	nmarupaka@google.com,
	joey.zhao@fibocom.com,
	liuqf@fibocom.com,
	felix.yan@fibocom.com,
	angel.huang@fibocom.com,
	freddy.lin@fibocom.com,
	alan.zhang1@fibocom.com,
	zhangrc@fibocom.com,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v7 2/4] net: wwan: t7xx: Add sysfs attribute for device state machine
Date: Thu,  1 Feb 2024 23:13:38 +0800
Message-ID:
 <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201151340.4963-1-songjinjian@hotmail.com>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [OAzt537dBn1AlU6NNjhdz7QDs+PeFIbX]
X-ClientProxiedBy: TY2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:404:f6::16) To MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:14c::12)
X-Microsoft-Original-Message-ID:
 <20240201151340.4963-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MEYP282MB2697:EE_|ME4P282MB1224:EE_
X-MS-Office365-Filtering-Correlation-Id: beed07e5-e376-4928-8667-08dc23387d1e
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6freGFPHZ3GjGHLcCLCqTPfz+d9nc/HNS3hqppNUbPO68k1YefrXhwbg9+5u9ZwYrrFf8WcQv6ismjNUz9I3mZXqyt8F/8bjljeYw9BCBc2/O3lqOoBFTi25pVIXg9euNFEV+TC1N9OsQsOSTBjuC0AJhEPuqghMtQ3FZAgCluxiS6HBkc2XR8LOnbC3Dn0S9r+sqPhkEhONZA8S0wb8eR6u7EUGb5A/h0eKkTs1he8t+DUJGvRvy6MoPw08zbXfNtqTweuPIvpEgmI6s97+TMZl5X9U0eVLuix0PL+iEjtu7RDxMQx+PvcH2L0mibYMzlQ4u9zPdX+9azEKOwQo82JGjgh9H5n/TqyTbtj1nPF9UGZgCQC/rKuvoL8NqjSTTDJXRKtLG7k5Lgo+TXuDPV4MpKs3UEWvyiYjKPahqP5V2uLQzuPDIO5iYuUaGJrZlbgACEbVRRczad+XzX4V22qe8gXXsqwdU1NV6MhCNK+ob2YDBPjA/an1KZQmluYnAXokuPPzmCyguiofNf6hK38p3A0J11+h6yLG0cNdNmQdLqLftgSZRRDZTYwM0WEQ4RxjufK4HS1GI9HQ8ZMSqQ4E3/MbKJ4qEVF98tEhmuv9NDB3Xrs29rz7hAXwmVg00I9oGYdGBvOiecXa5IdoOV98Camci7c0mW+4/oKgEHz4dzMbTqwqRhuJ0eWQxNmZQQAtwPfPT2twz0672T363wtgQv0eiTaB164w4ciRZND22z/i2UemdQPK5zQIc9FMM0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4+jR6vFVX4k35uQLlA3+GNQmSSjSiq2JrOu/Y0B4IH6ZwRQ1WmqG11VznBjhT4mQNBaVJmeIAdZtuJ2lae7nulYCAEdUTotngqSDCVSgRUvGqiOWkHRYRvjlsKeO3B2uuoptxMS1ork4XiOCczjJm4buhXfUdhsigQ9F5puzXo5N9Pw2jH3PWT7QUgxnhDk8rbbodhX+W23i86em2I826OQLJlPuV9CQxywMIM3/m8EKlNoY2boBwSjGmDW62E0q+GQ1690qfg1t67ayDm8EcK7XA0m7u7H5CTyz5rL2gEASd/a8dSx6AZ6V1GodqCVTarmhWSESr+ijaHesyVP8IlszdildwU0jWI/0oNWY+dNxiKXDpR4MUJP4bFy1bCLwcj2349C2NXn1vpFbss7eCaptOj+ZHeS/OUepBUu+4UVjbHaNa0v7MmFYWoTPqSALjcgBecPFxDs08SaUn92vyvV+uD8H+lXSxgmbCPLcVdz3P5SrsiDR+GAAWCKB0Gd4154oPJ4BZIUsw2gkLmCa3wuliBEnvtlKY1CRmMevCTYm/Iw1MCkMCyrZvQxGpvvg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qEqXWv/QYXI/PhoC+zxmeGIEWF6gfnt/fyzljBeoGxoeazWq2m90i/BeRkRl?=
 =?us-ascii?Q?TUhcRAt4/JGk+fuU/XBk4mGr7aRXjBHSPlKhVTrMg1WFhlKoe9xg197kUi7R?=
 =?us-ascii?Q?E/mpyctB+zvJ90QomaehwVNzYMLKad1MsTj565D6M856HzG3DgpIodwD1Tq8?=
 =?us-ascii?Q?3mC41Cn8DmSW/9SgGfSA49MgNwOPnJrqXm+iaC5PxYe5EVZrszlYQfO4hMgm?=
 =?us-ascii?Q?iCUaAmF7g5PJM8xWi04gwoNDDyeGZdAmp+LOIdLkvVOx/5QpAhi22p7NHTIi?=
 =?us-ascii?Q?6q4lKHwA2KqhcyN1wQOoheaobV33zx6WHpfCTLmZsBrUk11Fm1HvkYkPA4IZ?=
 =?us-ascii?Q?vFqlIKd2KD6kvYdOI/6mYocONhLGxVqBMjM8lXlWVceg2z7iCv61o5Qnl79B?=
 =?us-ascii?Q?5Kw4ZpuvvLqR/iw2HK9SB6TPtUjwKp1S5GNFjVU8B0D1BKgbF4rPlgaInDUR?=
 =?us-ascii?Q?+sAW63+wsWsWPH+6HLPrWzuoKiYexcu5Ny00SQQUrTARQT1d3eaBe1Owf10E?=
 =?us-ascii?Q?4DconrfBIZUEZPEZHKathIEf2DzvC/rzY20t9YyM6++zIKE3tX2s3jJYpS/1?=
 =?us-ascii?Q?S7cVQ+X2id9trnYAjiPmtX8AJcefcm6s6rXfpP/e1NHGsxGbVrOF9qE8Whgq?=
 =?us-ascii?Q?NuZjOTWJuwc8z6le3fT3zQYy8B03lpBhAcSbd3mZm4eerU3GAMFk67mUN4dz?=
 =?us-ascii?Q?591cp4E4QQBeX1TD6ifUypCBo6r2GVl7AOd/JxlrazWzn3NQwElQGxzMAVAJ?=
 =?us-ascii?Q?cnyZwuSn4D3SfUDlNjgKiIFMoT/n+wnJnoRXxZbeAyHIHOgfpkTv6+fG3G5n?=
 =?us-ascii?Q?4qXucj71kKZuaDug09SP+XSyuKhwmGBRYvUTgqlmM1ZEzWLvt0tcNqssuPLM?=
 =?us-ascii?Q?k3Alk13wgLKXqlpxVLebqQbjYld+CBQJVEBNNopgfSL9nclqUhW1dx3lZjFi?=
 =?us-ascii?Q?acb2hnpQMpCiRgAwR7SmhxMfyYy6QMSflfmONHy3uSSdMxO0PrfrkyvZPdks?=
 =?us-ascii?Q?Q6KVCzZCSrZFtqKMQlQY9ANBCuWU9GvswCulXJGlFJExbaAlzjES7jYOqxJm?=
 =?us-ascii?Q?+jKRStInLZhUQ2Y1cp0KCxoR3bEVoVFKv78n5KVRUvrNMNRv0z+vldNC2NXW?=
 =?us-ascii?Q?EhvT/Hd4EfW+m2A92ujVPJk4uKN+C6LD4YnReIvg+PU0d5XeuIFGLnloc8Kq?=
 =?us-ascii?Q?GzpExRrzgjtQpfesMYVK3SlkZKx8ZKp+y/3kSL6EJsQDoREZ57AX1hY4Q4I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: beed07e5-e376-4928-8667-08dc23387d1e
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:14:30.9238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1224

From: Jinjian Song <jinjian.song@fibocom.com>

Add support for userspace to get/set the device mode, device's state machine
changes between (UNKNOWN/READY/RESET/FASTBOOT_DL_MODE/FASTBOOT_DUMP_MODE).

Get the device state mode:
 - 'cat /sys/bus/pci/devices/${bdf}/t7xx_mode'

Set the device state mode:
 - reset(cold reset): 'echo RESET > /sys/bus/pci/devices/${bdf}/t7xx_mode'
 - fastboot: 'echo FASTBOOT_DL_SWITCHING > /sys/bus/pci/devices/${bdf}/t7xx_mode'
Reload driver to get the new device state after setting operation.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
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
 .../networking/device_drivers/wwan/t7xx.rst   | 28 ++++++
 drivers/net/wwan/t7xx/t7xx_modem_ops.c        |  6 ++
 drivers/net/wwan/t7xx/t7xx_modem_ops.h        |  1 +
 drivers/net/wwan/t7xx/t7xx_pci.c              | 98 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_pci.h              | 14 ++-
 drivers/net/wwan/t7xx/t7xx_state_monitor.c    |  1 +
 6 files changed, 143 insertions(+), 5 deletions(-)

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
index 91256e005b84..1a10afd948c7 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -52,6 +52,81 @@
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
+	if (index == T7XX_FASTBOOT_DL_SWITCHING) {
+		WRITE_ONCE(t7xx_dev->mode, T7XX_FASTBOOT_DL_SWITCHING);
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
@@ -729,16 +804,28 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
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
@@ -747,6 +834,9 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
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


