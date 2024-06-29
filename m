Return-Path: <netdev+bounces-107876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8619191CB63
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 08:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A940C1C21E2E
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597F7364AE;
	Sat, 29 Jun 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="d6Ij+3jf"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2187.outbound.protection.outlook.com [40.92.62.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE782D05D;
	Sat, 29 Jun 2024 06:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.187
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719642220; cv=fail; b=sG2w1IBjidwJNZcqfFedzQY4DwKGMkhSMCU1rITA5U7q/MvpJfJ0to/467hVsfVTqFhDdhvdAG31Re7GHh0T/9QQo3SrB5UsnUk+CJFq+AVc7JpK2KssRpoteoa5BK3Il0hMDkH1R088UbWabImSVq1dmLSyCIzgczstGHRL4ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719642220; c=relaxed/simple;
	bh=Qah8FHvSq0LnTKCgpkFPjQVpM4D/ftm1mv9WnUc0D8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKQYsooOei0wzTzxV22Osjn0uQpeLk8axLYA61FSDa9QQ51vrc74mmQ2Z7woIvfFX3aklPMsiDe6T5mZxI7UD40rPRryyfyG0kKobmUSxQ9diYAUZ1UGC1lt7dX+q6oEBlzXux8FgeA10W/Qi8IfurWOxMQRr62friquJo69Bi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=d6Ij+3jf; arc=fail smtp.client-ip=40.92.62.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZZQMN0OjOXjXseNJqdyRxb9rwq/AkBQV0z5vYsbPs1Yf66bhI5R1C8f4gjizb2qED/ENlbgSkrquTcmg965mTee1Cfzzn+N1wjJDYAEjafhHaCfrH0PRnFvJRFrArK1/My8ZB2MOrK+E86wa003KDev2yUPhzmcwdIMnFLN10xY7Gk9WU0J90pNwQv88GuB5tyJYsCCIL+xSxV06ufmzzT6VzSN57eBxOD8F7WQbIvPWEiCG0RgtdNJzN59guTLWC78MDZmtXnA2w6rZicgl3h2eV9aXimyNVkp59uM5hPmu6JdwIR1Nzmhwy4RQPQ+TLwTuJaJgD/fuELf67Uy0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM4ghNnLfT2Pu1S8Hc1PEiCzZ3UXxq4X+bpBVjXUqYM=;
 b=grcegz4PhpAGec/lYUnZKE9ZGjUZYKZJEVHby63Q+go/N5ppvIZiUlfZKklOYTUKLE5ZaZNmKxmo8S9gf8FvLG9gfqoVceXwA38OVETQuN7gjrP1WMCGSNUvkpiVh4QuQibcqyMGyNS1tlxHbjYqFt62d4EAz77qJ/VZs5mUpe3sAIXat469DQmtAdYLc8Sc8bkPj4F6dh2xjzPiPwbZcQ1c3NeZbUd0pZfdZUCFPER8f6J8hw0J1IGxhe7/9PV9+kZzTNNZ+xlgV7s1bDjvc8NaDeuzCkHiTumxVHAlke6DBTS5uJAzIbiHgNJSb/Mlj5MAdd/Aroa5rq4I/MZGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM4ghNnLfT2Pu1S8Hc1PEiCzZ3UXxq4X+bpBVjXUqYM=;
 b=d6Ij+3jfNAHE6WSz7UTzlSSDQwCuSPO3wLinKBKvKgXLBM/gb9lS4Y3zTDUoXFtRJEl5DpkIg6Lbyjx4AxHKJFiiljKXB2phm4HF07dz+uDHR2QWULOKGr3znUeRXrCOh74LeiwM4mOyCviyCR2PesygRMhhwFf4xW/znJO/D7i3XZu/aO/mQFddwUdaT4CS0Ygvt4eJhZEzptSWHy2Dz1hk5mNt1SEDZHjjdp8LWDbnmnvRWcOibs+QgBXrN38O6MnW9wbPz9BPm83eichNGsu1e7Bml/OVeuYP1DfI1zvD/QjDNZmbW9V5iJ/gkHwy5ZCtU7UaK4TyAnE0KQAjDg==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB1915.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:d1::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 06:23:32 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 06:23:32 +0000
From: Jinjian Song <songjinjian@hotmail.com>
To: chandrashekar.devegowda@intel.com,
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
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Jinjian Song <songjinjian@hotmail.com>,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v4 2/2] net: wwan: t7xx: Add debug port
Date: Sat, 29 Jun 2024 14:22:49 +0800
Message-ID:
 <SYBP282MB3528536850DD67947F4DABC6BBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629062249.8299-1-songjinjian@hotmail.com>
References: <20240629062249.8299-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [l/uw4pOdeiSjDAK831op4hXl/S5A2kuH]
X-ClientProxiedBy: SG3P274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::26)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629062249.8299-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB1915:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f132e0f-a5a4-4dc8-076e-08dc9803ff51
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|440099028|3412199025|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	A1nVVr6/H/Ju5+utNj8vFAGco9CPilKqoz2LExdTt8Bxx8CK+R1qK4TsegNBDZJ4cB6buOewTOC4UKh3PBgAsnDyCkP3SEwDkG4rgQHEV6KHazOErFB9NwB3o8j5STY7qaSEG+KAHawE4s5GVFJBuB1nii5PCZfnSwf/EuiA8jJ5pN22jGrFv0I/yg+VIxAl+vsxzZoLCKuxo1aQFB3ITLuOUL+KJPhAvImy0rseHK9PVhwtOXy+pjHsAeXWINNcXSvrbkpmI9FAlKpXRrK392797yEkUwzqXTWuFZiim350aRjuEkNySjvTq4UG6xny1iFDqD/Y+WYA+VDJMFwoTSCjEih3Lu7ADoxBB4NlTbfAt0+L5fGFGYk3Tga5IRY2uzfZGg3RH6HFP3BHpmSWaeTIRSvPkNZFioTfF/LtQi4UI4/r2WnCMKtVb2IxAhutDMPKRwxc9HHQrImoke4CllPvk8FZjZQFlhTb60eLcNOVpRtoh0yCXE6gJ4HmYDd5qJU6MBkDsIbUqRnnnJ5krzmidMiv33RHEtUZI2PkBkF5Bq9Gkzhh5gX1pqjpCDRPBb0kUgaHnQ4TipJ/u9cidT27c7ac27vi91NGS0heyZnt+d8DlpwDytULjvQRbxYSeqZYKLrMNyrNIO1hX7THi21M7xZPRYmzmVbE6KcDKAR4OXuWo44s5lf6VNiNgQ0HAz+JGIZwcqQMge/fwd9Ch0h1xmeJH8ugD2xzWcnrbQaAw2UrDu/Rcm2wO0IdviDq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?88mlZbXJRZWupxGyQA6Y3VhpyRC30cpscmP1jSazclL2mtU9bL68CDLKz+Ep?=
 =?us-ascii?Q?J9oXs5ZLvRASShnEEyx+U+5Zqm4vt836Cr7KEqHcI4d0gXEccne5NQqc7c30?=
 =?us-ascii?Q?cxO3S27mbI3vtELalNLwaFrhBxJOIvAhhPnGUr9IawPPbAShNA2OwO/GUtp+?=
 =?us-ascii?Q?YfjDGE/vL4wYKTEMVN08/Ef3RzABr4u+SESe6EggrMQd3b7WopTKE12p63TB?=
 =?us-ascii?Q?IJgjMTzHbWmqpdO5C6usszpvPH9Hb74mLUxUT9n3rqzd4H1HevunnvyDMH6V?=
 =?us-ascii?Q?JXwRAmGr8U75IhmryZEHoUw07cwBRGyNXDWsGzHSqUHYwA0u4faq5G8UapgH?=
 =?us-ascii?Q?NlhSZww4xJ99p4HrO85lVcNWgjbCHzO8jv5FgaoYCox12YWUfL6Nlf1sz2sn?=
 =?us-ascii?Q?fEN7cZvwO8GPwfuz6XhNHZhZeTQd9Yjea2npSFg35b3gubKS+StX3aB+Gag0?=
 =?us-ascii?Q?AVH7sxarmiLa7KvWRSwn+GLdZ5fTGUUadDWr0z6h85Xm1gSlbmmHN/57IAwx?=
 =?us-ascii?Q?ltXW7QNd74gTFB0RLA7FoItdHXlk2yBMMKgHB7npIfCQVXgwuNbKyU8jVE2H?=
 =?us-ascii?Q?eRFzSKMhbZYBqZaQ2kXonACdmUEgaG8VRXGYvpdieUX4UDAIimmYihXEhKRx?=
 =?us-ascii?Q?PhLXq3cpCmXXkQZcFL9E6loCsKi/pvoUcoTRryZXf8Zddh/zHnFdz+xZRXow?=
 =?us-ascii?Q?l9KQxcqF+wJuWp8mjaPQ6PaDpgVh9cBUKd2bAZWzF9Ha2jnu6Iue+0oJBD1i?=
 =?us-ascii?Q?1nQ6zSTwv/+FO8AkzcTj9gD3bvZPgW3FXnzNy7jkPZTEnaVw02rmMIWNzAbv?=
 =?us-ascii?Q?dg1MAYbjv/ZB76OemIsHriDTewDV0KjShJESxvz8qoBNJLWNpTURrkgoABmP?=
 =?us-ascii?Q?2ATDG9OV1/KpkDvh164Ss+CL3EoAmWLmANTSVF36ZxfrA/EaXZjwr/ZDdS2k?=
 =?us-ascii?Q?7E/zgsD77jtQegzqaq/zBxFaSEUPw771v7ZtwcsZFxqPHKgDpC+RBU9BoQiJ?=
 =?us-ascii?Q?Pojop+1oHbo5iU4K7nMslzJd+r8NjiiCaKAEwmlGsGUZncV3MumjeKKMQUOm?=
 =?us-ascii?Q?qJ7sVPWT0cybCM2RnI0cbIBdZpTcw76ugcr4RWP4j+/S9uz/AdO8lVqLWawt?=
 =?us-ascii?Q?QFQjhuNvHKkuqMQCZH4pgmwgbI65sh3cD+32FqCLogNaKpuBnGxEbbRqkXwl?=
 =?us-ascii?Q?MTjNzstWBf7EZ29dOSFyYIsDodqpcSNFS2dRMcqY+a8QJHU7XOkaYvEcbCxX?=
 =?us-ascii?Q?Pxnyyft6rHJPZzemD/O8?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f132e0f-a5a4-4dc8-076e-08dc9803ff51
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 06:23:32.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB1915

Add support for userspace to switch on the debug port(ADB,MIPC).
 - ADB port: /dev/wwan0adb0
 - MIPC port: /dev/wwan0mipc0

Application can use ADB (Android Debg Bridge) port to implement
functions (shell, pull, push ...) by ADB protocol commands.
E.g., ADB commands:
 - A_OPEN: OPEN(local-id, 0, "destination")
 - A_WRTE: WRITE(local-id, remote-id, "data")
 - A_OKEY: READY(local-id, remote-id, "")
 - A_CLSE: CLOSE(local-id, remote-id, "")

Link: https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md

Application can use MIPC (Modem Information Process Center) port
to debug antenna tunner or noise profiling through this MTK modem
diagnostic interface.

By default, debug ports are not exposed, so using the command
to enable or disable debug ports.

Switch on debug port:
 - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_port_mode

Switch off debug port:
 - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_port_mode

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
v4:
 * modify commit message t7xx_mode to t7xx_port_mode
v3:
 * add sysfs interface t7xx_port_mode
 * delete spin_lock_init in t7xx_proxy_port_debug()
 * modify document t7xx.rst
v2:
 * add WWAN ADB and MIPC port
---
 .../networking/device_drivers/wwan/t7xx.rst   | 47 +++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              | 67 +++++++++++++++++--
 drivers/net/wwan/t7xx/t7xx_pci.h              |  7 ++
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 +
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 44 +++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 7 files changed, 167 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index f346f5f85f15..02c8a47c2328 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -67,6 +67,28 @@ Write from userspace to set the device mode.
 ::
   $ echo fastboot_switching > /sys/bus/pci/devices/${bdf}/t7xx_mode
 
+t7xx_port_mode
+--------------
+The sysfs interface provides userspace with access to the port mode, this interface
+supports read and write operations.
+
+Port mode:
+
+- ``normal`` represents switching off debug ports
+- ``debug`` represents switching on debug ports
+
+Currently supported debug ports (ADB/MIPC).
+
+Read from userspace to get the current port mode.
+
+::
+  $ cat /sys/bus/pci/devices/${bdf}/t7xx_port_mode
+
+Write from userspace to set the port mode.
+
+::
+  $ echo debug > /sys/bus/pci/devices/${bdf}/t7xx_port_mode
+
 Management application development
 ==================================
 The driver and userspace interfaces are described below. The MBIM protocol is
@@ -139,6 +161,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
 port, because device needs a cold reset after enter ``fastboot_switching``
 mode.
 
+ADB port userspace ABI
+----------------------
+
+/dev/wwan0adb0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a ADB protocol interface by implementing ADB WWAN Port.
+The userspace end of the ADB channel pipe is a /dev/wwan0adb0 character device.
+Application shall use this interface for ADB protocol communication.
+
+MIPC port userspace ABI
+-----------------------
+
+/dev/wwan0mipc0 character device
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The driver exposes a diagnostic interface by implementing MIPC (Modem
+Information Process Center) WWAN Port. The userspace end of the MIPC channel
+pipe is a /dev/wwan0mipc0 character device.
+Application shall use this interface for MTK modem diagnostic communication.
+
 The MediaTek's T700 modem supports the 3GPP TS 27.007 [4] specification.
 
 References
@@ -164,3 +205,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [5] *fastboot "a mechanism for communicating with bootloaders"*
 
 - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
+
+[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices and
+emulators instances connected to or running on a given host developer machine with
+ADB protocol"*
+
+- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..b15c470acd3c 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -41,6 +41,7 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
+#include "t7xx_port_proxy.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
@@ -61,7 +62,13 @@ static const char * const t7xx_mode_names[] = {
 	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
 };
 
+static const char * const t7xx_port_mode_names[] = {
+	[T7XX_DEBUG] = "debug",
+	[T7XX_NORMAL] = "normal",
+};
+
 static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
+static_assert(ARRAY_SIZE(t7xx_port_mode_names) == T7XX_PORT_MODE_LAST);
 
 static ssize_t t7xx_mode_store(struct device *dev,
 			       struct device_attribute *attr,
@@ -109,13 +116,61 @@ static ssize_t t7xx_mode_show(struct device *dev,
 
 static DEVICE_ATTR_RW(t7xx_mode);
 
-static struct attribute *t7xx_mode_attr[] = {
+static ssize_t t7xx_port_mode_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
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
+	index = sysfs_match_string(t7xx_port_mode_names, buf);
+	if (index == T7XX_DEBUG) {
+		t7xx_proxy_port_debug(t7xx_dev, true);
+		WRITE_ONCE(t7xx_dev->port_mode, T7XX_DEBUG);
+	} else if (index == T7XX_NORMAL) {
+		t7xx_proxy_port_debug(t7xx_dev, false);
+		WRITE_ONCE(t7xx_dev->port_mode, T7XX_NORMAL);
+	}
+
+	return count;
+};
+
+static ssize_t t7xx_port_mode_show(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	enum t7xx_port_mode port_mode = T7XX_NORMAL;
+	struct t7xx_pci_dev *t7xx_dev;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+	t7xx_dev = pci_get_drvdata(pdev);
+	if (!t7xx_dev)
+		return -ENODEV;
+
+	port_mode = READ_ONCE(t7xx_dev->port_mode);
+	if (port_mode < T7XX_PORT_MODE_LAST)
+		return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[port_mode]);
+
+	return sysfs_emit(buf, "%s\n", t7xx_port_mode_names[T7XX_NORMAL]);
+}
+
+static DEVICE_ATTR_RW(t7xx_port_mode);
+
+static struct attribute *t7xx_attr[] = {
 	&dev_attr_t7xx_mode.attr,
+	&dev_attr_t7xx_port_mode.attr,
 	NULL
 };
 
-static const struct attribute_group t7xx_mode_attribute_group = {
-	.attrs = t7xx_mode_attr,
+static const struct attribute_group t7xx_attribute_group = {
+	.attrs = t7xx_attr,
 };
 
 void t7xx_mode_update(struct t7xx_pci_dev *t7xx_dev, enum t7xx_mode mode)
@@ -806,7 +861,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
-				 &t7xx_mode_attribute_group);
+				 &t7xx_attribute_group);
 	if (ret)
 		goto err_md_exit;
 
@@ -822,7 +877,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_group:
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 
 err_md_exit:
 	t7xx_md_exit(t7xx_dev);
@@ -837,7 +892,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	t7xx_dev = pci_get_drvdata(pdev);
 
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..973d0f1f8f9a 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -53,6 +53,12 @@ enum t7xx_mode {
 	T7XX_MODE_LAST, /* must always be last */
 };
 
+enum t7xx_port_mode {
+	T7XX_NORMAL,
+	T7XX_DEBUG,
+	T7XX_PORT_MODE_LAST, /* must always be last */
+};
+
 /* struct t7xx_pci_dev - MTK device context structure
  * @intr_handler: array of handler function for request_threaded_irq
  * @intr_thread: array of thread_fn for request_threaded_irq
@@ -94,6 +100,7 @@ struct t7xx_pci_dev {
 	struct dentry		*debugfs_dir;
 #endif
 	u32			mode;
+	u32			port_mode;
 };
 
 enum t7xx_pm_id {
diff --git a/drivers/net/wwan/t7xx/t7xx_port.h b/drivers/net/wwan/t7xx/t7xx_port.h
index f74d3bab810d..9f5d6d288c97 100644
--- a/drivers/net/wwan/t7xx/t7xx_port.h
+++ b/drivers/net/wwan/t7xx/t7xx_port.h
@@ -42,6 +42,8 @@ enum port_ch {
 	/* to AP */
 	PORT_CH_AP_CONTROL_RX = 0x1000,
 	PORT_CH_AP_CONTROL_TX = 0x1001,
+	PORT_CH_AP_ADB_RX = 0x100a,
+	PORT_CH_AP_ADB_TX = 0x100b,
 
 	/* to MD */
 	PORT_CH_CONTROL_RX = 0x2000,
@@ -100,6 +102,7 @@ struct t7xx_port_conf {
 	struct port_ops		*ops;
 	char			*name;
 	enum wwan_port_type	port_type;
+	bool			debug;
 };
 
 struct t7xx_port {
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.c b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
index 7d6388bf1d7c..4891070ad9b1 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.c
@@ -39,6 +39,8 @@
 
 #define Q_IDX_CTRL			0
 #define Q_IDX_MBIM			2
+#define Q_IDX_MIPC			2
+#define Q_IDX_ADB			3
 #define Q_IDX_AT_CMD			5
 
 #define INVALID_SEQ_NUM			GENMASK(15, 0)
@@ -100,7 +102,27 @@ static const struct t7xx_port_conf t7xx_port_conf[] = {
 		.path_id = CLDMA_ID_AP,
 		.ops = &ctl_port_ops,
 		.name = "t7xx_ap_ctrl",
-	},
+	}, {
+		.tx_ch = PORT_CH_AP_ADB_TX,
+		.rx_ch = PORT_CH_AP_ADB_RX,
+		.txq_index = Q_IDX_ADB,
+		.rxq_index = Q_IDX_ADB,
+		.path_id = CLDMA_ID_AP,
+		.ops = &wwan_sub_port_ops,
+		.name = "adb",
+		.port_type = WWAN_PORT_ADB,
+		.debug = true,
+	}, {
+		.tx_ch = PORT_CH_MIPC_TX,
+		.rx_ch = PORT_CH_MIPC_RX,
+		.txq_index = Q_IDX_MIPC,
+		.rxq_index = Q_IDX_MIPC,
+		.path_id = CLDMA_ID_MD,
+		.ops = &wwan_sub_port_ops,
+		.name = "mipc",
+		.port_type = WWAN_PORT_MIPC,
+		.debug = true,
+	}
 };
 
 static const struct t7xx_port_conf t7xx_early_port_conf[] = {
@@ -505,13 +527,31 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
 		spin_lock_init(&port->port_update_lock);
 		port->chan_enable = false;
 
-		if (port_conf->ops && port_conf->ops->init)
+		if (!port_conf->debug && port_conf->ops && port_conf->ops->init)
 			port_conf->ops->init(port);
 	}
 
 	t7xx_proxy_setup_ch_mapping(port_prox);
 }
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show)
+{
+	struct port_proxy *port_prox = t7xx_dev->md->port_prox;
+	struct t7xx_port *port;
+	int i;
+
+	for_each_proxy_port(i, port, port_prox) {
+		const struct t7xx_port_conf *port_conf = port->port_conf;
+
+		if (port_conf->debug && port_conf->ops && port_conf->ops->init) {
+			if (show)
+				port_conf->ops->init(port);
+			else
+				port_conf->ops->uninit(port);
+		}
+	}
+}
+
 void t7xx_port_proxy_set_cfg(struct t7xx_modem *md, enum port_cfg_id cfg_id)
 {
 	struct port_proxy *port_prox = md->port_prox;
diff --git a/drivers/net/wwan/t7xx/t7xx_port_proxy.h b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
index 7f5706811445..a9c19c1253e6 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_proxy.h
+++ b/drivers/net/wwan/t7xx/t7xx_port_proxy.h
@@ -98,6 +98,7 @@ extern struct port_ops ctl_port_ops;
 extern struct port_ops t7xx_trace_port_ops;
 #endif
 
+void t7xx_proxy_port_debug(struct t7xx_pci_dev *t7xx_dev, bool show);
 void t7xx_port_proxy_reset(struct port_proxy *port_prox);
 void t7xx_port_proxy_uninit(struct port_proxy *port_prox);
 int t7xx_port_proxy_init(struct t7xx_modem *md);
diff --git a/drivers/net/wwan/t7xx/t7xx_port_wwan.c b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
index 4b23ba693f3f..7fc569565ff9 100644
--- a/drivers/net/wwan/t7xx/t7xx_port_wwan.c
+++ b/drivers/net/wwan/t7xx/t7xx_port_wwan.c
@@ -169,7 +169,9 @@ static int t7xx_port_wwan_init(struct t7xx_port *port)
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		t7xx_port_wwan_create(port);
 
 	port->rx_length_th = RX_QUEUE_MAXLEN;
@@ -224,7 +226,9 @@ static void t7xx_port_wwan_md_state_notify(struct t7xx_port *port, unsigned int
 {
 	const struct t7xx_port_conf *port_conf = port->port_conf;
 
-	if (port_conf->port_type == WWAN_PORT_FASTBOOT)
+	if (port_conf->port_type == WWAN_PORT_FASTBOOT ||
+	    port_conf->port_type == WWAN_PORT_ADB ||
+	    port_conf->port_type == WWAN_PORT_MIPC)
 		return;
 
 	if (state != MD_STATE_READY)
-- 
2.34.1


