Return-Path: <netdev+bounces-106405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34D1916192
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D72873A6
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB01494D6;
	Tue, 25 Jun 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ngF0B1hj"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2160.outbound.protection.outlook.com [40.92.62.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42C148848;
	Tue, 25 Jun 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305173; cv=fail; b=BbuB2y3WD27d3+M0VMCHRbpLU28DqyjI6+2FJkxu1kAj73Zh30GCEtBIQRXZ/X84uGrnuUae89D0kyBnVMesoUK+aC5k2q1Xr5Lj0JPVy/NBgta3VAABh6xRCEOO273D5iY3j1rlp2oDAWEfnl4p4j72tpFKPsoP1zMx6NWiAO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305173; c=relaxed/simple;
	bh=X0lGcRTgGhfIhmSoiMimPXG34HFUE0UIznAZUeL5Ey0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SflFZx0PSvtcPjI7P/n2dxqudcdHIZQ9uEhSMW5xVuFikSVDzX6TKdguIvxeWsyJ2aJM/DM/7fcOPc51Pj3iQfn4olVwWTlpszRRcQNqP+Jltr8h9/OdSXhBYskgPZjwS9J5ciiPVTaWkKQO67vnVewt8wONTO/NzwSBx2TQtWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ngF0B1hj; arc=fail smtp.client-ip=40.92.62.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUJ2/UaFj5HXescTSJhdL/CxjSADuA2Mmm7+0GCaFZ8OemINMWwUD+Q6VACKB7gu9iDXIqyrpOrTZWTYnZkteyS/RJaxvF7V/08TuJ/j5kLWohei9FSWQxcTyvZBnJ/LGAP0sUM5U51RfIu5uNtyLtaEkjWQTQGaPRTTpEs17bC6MYbRZxNhNp9OVXhciWC1YJ548X9sVHFDDJDdzXdE653nZo8OjftB4cIh62Gr/e9Ic926tidkoHwaJhVZv4nMUhQLiAN8DjqiIXvD7WR9Lrac4duK7s/Jz2bNfbTEvvo+i/H4mxvgNR9iAvlkHI5NRJcqJ50FJyXLDLzo/xnijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wp3xO5ElR6gIXJh2MJqZzRhmNSnJUkl9o4EOaUfxO0=;
 b=DeKz6lulyzfVpL7XTcbVtTP7kqzFnodsK+2fu2TPGaQdfoG1/L/FcDGW7fGpbqmvIn8o2fVbp1D33sCi/NifHqrWDgbycACUi0Zj6rVmt5NWrzKT9fgMHiXP+sA8BEw9GNvAKAKfvTlPU3A8gQGVgSlp5zA0snBMlCME33GfTwiTDG0dfUSt/Ab2AEiR8vQDFrE14u2s/4P0ZftzPJCBDxnYMuL+4dbJ0ozFISs17vxOof+qxwVFGufiFcU3CLeY9NKOA2gNeZzXRt0/ZowxyQCrc2URtL6veENz7xlm4laXr78KXzyBfecS/fwb/LL5MMzPtIvNT8DBFfAQuiTfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wp3xO5ElR6gIXJh2MJqZzRhmNSnJUkl9o4EOaUfxO0=;
 b=ngF0B1hjItP32ZsP7utZr3Be8PE+6N//KTpy/Bg5DHUhD1dsD8ZB/SLwrSEdm8mLBo0w4EDGKdfQdw6mIP6AAt4FJyEqdZV8/yuZ3zXmszMgDZo5giC0oYs0C+WycSOb3L4V8UR2hPFSUD4M4pekfquY0gp1lO72nkeIqdB7x2waCLqgX6c5nrYEQOEh0D9kBCEQyRtl95liGM++HHcXiedHtq4mHGkuDVKULiRkUGyKJzNQVgPf8MjkHJXiBIDHh9dEdnMw607HT9Q4TAnQuXR5VwpWF267Jq4zG3MOix7n+Na4LNR9D822/TuG5aA6DOLTAmKPg02k5nTdpVTX1Q==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY7P282MB4874.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:27c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.28; Tue, 25 Jun 2024 08:46:04 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 08:46:03 +0000
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
Subject: [net-next v2 2/2] net: wwan: t7xx: Add debug port
Date: Tue, 25 Jun 2024 16:45:18 +0800
Message-ID:
 <SYBP282MB3528BE02090B58B84CD714DFBBD52@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625084518.10041-1-songjinjian@hotmail.com>
References: <20240625084518.10041-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [p9yts9UxfE6NUESxD+yNlXzaanvZgFsF]
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240625084518.10041-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY7P282MB4874:EE_
X-MS-Office365-Filtering-Correlation-Id: 09299a05-ae28-4341-d4b9-08dc94f33f22
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|1602099009|3412199022|440099025|4302099010|1710799023;
X-Microsoft-Antispam-Message-Info:
	aLhg2yDtN8x69vYrEX4Lc8R/9UEGjQzI83qYblEdN0PJvsFH5PZuBG0TzQ/EBsvz/rNHJfuTT6Ug6tX8ogP9zdYJoH0gvBBbNrAj1pszbk81gEnWo7JXX0weq41teXNo3zpXgBOzNBvKbQpu2cZcA2YYSxZYscxrbRy6eAcjWjDMZCp/B/o+sa3z1/46s5UJwjC7HhO9amcDia2CQWyjwpd5hUEdGsVSHfPmdj/IHwJ8DKO+ONgxmWuBEu04NDHz6tvgucV5+BzvpHvg2OzZIcTKgMuugMXirQmpECjev/AqWOQavS7qD+guKdNEq2Ao8rsldnTVcpC+VQzGGydktcbo1OqtIv9DSh+dbwj8s3e87F3hit4yloDodKRgz0fKnnvYg/1/tl/ZvVdsZI4Hj8Lx9VnRjHgEEtKwlzoUcMOSvo6o5Yhjj30i3eJ9c2iJ9vcPAiBw7E86nAHterSnoNagbjdrBv7nU8xui7DTW08BwO9V1cBAMAh6VGcWTEvX2fTaJFxNK611HOUKoc7WbEJNpVnGK4J2MAO+aZa60FSGoYgdaO+sqjW2pIKplMpVxuSGSSRCxEWkS03uDR25oYVPadhvVNc5kVNkN7G1VzypAcYqJ3HsJjPogcqAgN7gGMue4aHoCUI0QU7r+LNtp4/sVtY7RfpTKOkNCzJKQ4Khr3tRV8e+IVmNEZpbs5Gr7XcoAk69X6KUpPFRFcq4GQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w6TOpNgU8+5oU21awctCh0obukxlkbfPNrELKT2wP8hs2ORb9L3Dz60kI42u?=
 =?us-ascii?Q?UUDLOQIsWwzFbTc67dD0Ml+FkfHu2OyvgnD73mYQUQc2YCsWeMSR58fU8WPT?=
 =?us-ascii?Q?rDVbNu4IDqvcBVRMob0gDR89YL3xHItyRvFXkIUA3KVwmpSJy9KJVyeYVt9l?=
 =?us-ascii?Q?3s4/vRJs9pZQqpqJrYrDiX9xlSIjOk8lkufWrOw6PecA9Tw3MG7I/CztVkhb?=
 =?us-ascii?Q?eb+XFe530tZKKQ+woXAEEvypWxFD5qEQqL5Kc3cVNlZbOiOW2N9XxrGemiEz?=
 =?us-ascii?Q?CvkFDvleBuAq8XWn++SSzeUO9EEUhjdw6q80//C8WTOMcxPTV7Dhx2eFk7JN?=
 =?us-ascii?Q?9Kb5Dj4pxAmY2Wgjwwywz+fvJzkX7cxRmOhRHZ0NFkBamNSJeJi+qvHTX00L?=
 =?us-ascii?Q?m3oZolK5+NDL0oXcxlue+awyXPKYp60I5F/0UAE+pPC5cIHInLQhJX6rOWtU?=
 =?us-ascii?Q?Rdlc6lvreMvxG0ags3OJmngZ4hYGwf35oJHwgyBA3J3YxOj0GOB9ldQk0x20?=
 =?us-ascii?Q?ThbI5Lu4pXoCOzS2hRqBleH3AvmaePIU/sxR4jguH8d22EeU4RkOxl9NRsN1?=
 =?us-ascii?Q?fiM5WLBhpROfAqzS0XqMRrT3l0MTHjG5A2fCk5ayaXgCcBTLJEGu7oGap/F9?=
 =?us-ascii?Q?k9eBw9DrR14VVhTsTFWQN85nXfKJLXg/zhLjtNuensQ7vhLcLqoQIrxxm4NF?=
 =?us-ascii?Q?R/JdX2uyRzO95RC61SwS4KSDoASROCR8U3T4STbf1i0lA0S9fHMn4n0z3a3/?=
 =?us-ascii?Q?OhMAAKDSNzciecEB7fPZ514FTjrvQUHZJvm8i/0oeDiBb/H+/oZuNmvbiVJ/?=
 =?us-ascii?Q?52tZz9qkWWlFtGnK1eU9jVaQkGyXJhHvewtlukG86YqTgNQKy14JJFlFd5Ly?=
 =?us-ascii?Q?58lcJYcxVfFciZC4iAnIXTkv07YvJLoM0YDy4Pdu8VqM/PgvfL2/x9nowFrI?=
 =?us-ascii?Q?Op9Y2gcJSsgpOHePocZB/79ow3105xVHUXSl0NtxTG4wRZdRyryLFiXB6SDQ?=
 =?us-ascii?Q?8C2pebPN6zvAxQrmbTFuxDHkGg2IlEyuBK6OYPjgmYaU6f8mD9whPVneU/bC?=
 =?us-ascii?Q?J3cvnnhOanE0pX8uJ05XvzVtrArIiGFsthyt+f89TF+8YgaeJUomr1WNeKeh?=
 =?us-ascii?Q?+gWhVzNdQQkdHHj1RkO123sx8dPKVgS8g2fIiqTKEtwfzEob5gSEGcY/98bs?=
 =?us-ascii?Q?VJuFNQKY3QaKgGbOZ6mYs5IdP3KEqlZ+lsv1Wq1rB4R/5jxMy/RAAmSp2Wcr?=
 =?us-ascii?Q?px+s52B1qX9/o3pmB8DW?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 09299a05-ae28-4341-d4b9-08dc94f33f22
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 08:46:03.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4874

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
 - debug: 'echo debug > /sys/bus/pci/devices/${bdf}/t7xx_mode

Switch off debug port:
 - normal: 'echo normal > /sys/bus/pci/devices/${bdf}/t7xx_mode

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 .../networking/device_drivers/wwan/t7xx.rst   | 29 ++++++++++++
 drivers/net/wwan/t7xx/t7xx_pci.c              |  7 +++
 drivers/net/wwan/t7xx/t7xx_pci.h              |  2 +
 drivers/net/wwan/t7xx/t7xx_port.h             |  3 ++
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 45 ++++++++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 +++-
 7 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index f346f5f85f15..3d70c5e3f769 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -56,6 +56,10 @@ Device mode:
 - ``fastboot_switching`` represents that device in fastboot switching status
 - ``fastboot_download`` represents that device in fastboot download status
 - ``fastboot_dump`` represents that device in fastboot dump status
+- ``debug`` represents switching on debug ports (write only)
+- ``normal`` represents switching off debug ports (write only)
+
+Currently supported debug ports (ADB/MIPC).
 
 Read from userspace to get the current device mode.
 
@@ -139,6 +143,25 @@ Please note that driver needs to be reloaded to export /dev/wwan0fastboot0
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
@@ -164,3 +187,9 @@ speak the Mobile Interface Broadband Model (MBIM) protocol"*
 [5] *fastboot "a mechanism for communicating with bootloaders"*
 
 - https://android.googlesource.com/platform/system/core/+/refs/heads/main/fastboot/README.md
+
+[6] *ADB (Android Debug Bridge) "a mechanism to keep track of Android devices and
+emulators instances connected to or running on a given host developer machine with
+ADB protocol"*
+
+- https://android.googlesource.com/platform/packages/modules/adb/+/refs/heads/main/README.md
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..6b18460d626c 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -41,6 +41,7 @@
 #include "t7xx_pcie_mac.h"
 #include "t7xx_reg.h"
 #include "t7xx_state_monitor.h"
+#include "t7xx_port_proxy.h"
 
 #define T7XX_PCI_IREG_BASE		0
 #define T7XX_PCI_EREG_BASE		2
@@ -59,6 +60,8 @@ static const char * const t7xx_mode_names[] = {
 	[T7XX_FASTBOOT_SWITCHING] = "fastboot_switching",
 	[T7XX_FASTBOOT_DOWNLOAD] = "fastboot_download",
 	[T7XX_FASTBOOT_DUMP] = "fastboot_dump",
+	[T7XX_DEBUG] = "debug",
+	[T7XX_NORMAL] = "normal",
 };
 
 static_assert(ARRAY_SIZE(t7xx_mode_names) == T7XX_MODE_LAST);
@@ -82,6 +85,10 @@ static ssize_t t7xx_mode_store(struct device *dev,
 	} else if (index == T7XX_RESET) {
 		WRITE_ONCE(t7xx_dev->mode, T7XX_RESET);
 		t7xx_acpi_pldr_func(t7xx_dev);
+	} else if (index == T7XX_DEBUG) {
+		t7xx_proxy_port_debug(t7xx_dev, true);
+	} else if (index == T7XX_NORMAL) {
+		t7xx_proxy_port_debug(t7xx_dev, false);
 	}
 
 	return count;
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index 49a11586d8d8..bdcadeb035e0 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.h
+++ b/drivers/net/wwan/t7xx/t7xx_pci.h
@@ -50,6 +50,8 @@ enum t7xx_mode {
 	T7XX_FASTBOOT_SWITCHING,
 	T7XX_FASTBOOT_DOWNLOAD,
 	T7XX_FASTBOOT_DUMP,
+	T7XX_DEBUG,
+	T7XX_NORMAL,
 	T7XX_MODE_LAST, /* must always be last */
 };
 
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
index 7d6388bf1d7c..3510f9013811 100644
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
@@ -505,13 +527,32 @@ static void t7xx_proxy_init_all_ports(struct t7xx_modem *md)
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
+		spin_lock_init(&port->port_update_lock);
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


