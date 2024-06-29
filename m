Return-Path: <netdev+bounces-107873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D307E91CAFA
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 06:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E2A284A42
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 04:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E40C1EEE9;
	Sat, 29 Jun 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="io4wg9TB"
X-Original-To: netdev@vger.kernel.org
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2171.outbound.protection.outlook.com [40.92.63.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1692E3EE;
	Sat, 29 Jun 2024 04:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.63.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719635393; cv=fail; b=f6HQ6wA3O2qJwFpXuQr0IYdhZjEoVgcQaXxRfyOGzETGsk+lboEdfNYBcv2ZktwwsIErHrXgDb3rsP9N6AwPeYZ5f0EKS3HJWHqdJo72O7VLjbOveNxgpI7zim+lEnGUULe8OBSV7OOOMsB9PeIgIVvFiGQ1HriehvQp2zh2bBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719635393; c=relaxed/simple;
	bh=pTOTquazEhq4BcBV35H6UH7c1iTqXusBxZATaMNTKlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nSeZFw4tXDGpv15HXm8xPJnMAzmnxpRq9/6U17O/phPWfjbHJYFth5cdGQU0bYCaJsUmPDO9UBGWOve97wKGPzEGnl358LAFr6Mggs+hpwBsbDqf5M73LJ/VTBV/2P3yiuxz3btMZcszW/PDhA4q/YcsMfn1rFJo1W/8NYvFFMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=io4wg9TB; arc=fail smtp.client-ip=40.92.63.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk5wXs5FXgheBr23IdfGd3CgbIZ8UtNnIOuw3HAdJJgEiVNnpvoHwsUbE8odjrJxZ2E+UUEv7BVi6WMGUGELPitnDprdHC4lxqkXAQm6gRX3rkF8TV9UBj0Ko4m1uwKOXZzmnMSwIWr0YpuyKwHZ9Zpv7r2vya/2KS8UfQW10ESIsSI6CFve7d2ZFKb20Z2v/UMxhe9VUEsEHUpIsTgFzrlHJ9D1e+I1IES7nsQpr5zDwKv2AHvP8M6XnAWFBfQDNxk62gUBwrtb8uV63UrTRoUGnH1+kw38R/if934pR/6tTFd8XYtpRVgNQb62Tr0c+GEInKThG9cTSCfRaFCNfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDjdvMRNlcHapbYBZl7KsiIYrB3/nXtvvEfNhUDmovk=;
 b=H0GvAteFDw0vpDP4qWAB6CnZPvBhrYUq9/joW9iszjfcTSGS7TKv6RW8SpjN+KYocMt6vq3i/4F3OUus+pv25QJUVPPHpV//AfOo4AqCyP70IHRnIFTlwNBbVvz/8Aokt+VolDHRaiSwA9YyUkNWo6ysQdw+Db8e5DCwTAOp95/rnKJzMEeqOYJZC7TZlq0m0PADNaq4ModjEs5oFjCAteSbOjc+8eCB8cndjPmpY/sZI92ypUKUJBlIlv8VmxJfv7DYGVQePiiNLYOuH1w3fPiWJFzskTASkLhRUuGNIZgKdUkMPADGYsr61sMPDfhcgWD1PcTn8QbM1uEHhKsjLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDjdvMRNlcHapbYBZl7KsiIYrB3/nXtvvEfNhUDmovk=;
 b=io4wg9TBXH/11tBY6/K6sdzHvYW+Q4eJDXFKtexi1SyES6o4YIuNzJIc1SRWQY4cfIWQdrqFejBtic3WaeamnSO4yxnQjYbcMhSbgslfPUek4LKJt5hqwi+oc3JQAASGHbX+YIpdWfUD0WPh305zIVfPZgJSM4Wj/qSmqQPpvhT8kMKFPhGkm3oRuUZbc+WMeHZ34rcN5n0DE2WeM6JhRzkGdU/OHTbv46SyCNmG5YxpUVPaIOXKai5TFB8dQzhofwKfnRvE4qHlaiFnNFL5Sd93OpvN017kIdLFGwTGPHf1dD6EqbW1p/oUpzvamxMorhVlyZvIGCogpTfEMSNraw==
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6) by
 SY4P282MB4160.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.28; Sat, 29 Jun 2024 04:29:45 +0000
Received: from SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289]) by SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
 ([fe80::a8e8:3859:c279:c289%5]) with mapi id 15.20.7719.028; Sat, 29 Jun 2024
 04:29:45 +0000
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
Subject: [net-next v3 2/2] net: wwan: t7xx: Add debug port
Date: Sat, 29 Jun 2024 12:28:18 +0800
Message-ID:
 <SYBP282MB3528164C1735BEEB3336877FBBD12@SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240629042818.5397-1-songjinjian@hotmail.com>
References: <20240629042818.5397-1-songjinjian@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [N0LZoZrbKrlSP6Y1hkp6RTZ+ntO9+ufd]
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1b3::6)
X-Microsoft-Original-Message-ID:
 <20240629042818.5397-3-songjinjian@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB3528:EE_|SY4P282MB4160:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fdbd8b-aefa-4c31-6ca8-08dc97f41994
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|440099028|3412199025|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	AlHpZyR7Z3f1hcdcJwrGsuuAdYxCK8aPmsaylrH4ohcyFlFBYI8o/mXOFYGBup1s8luwMu8N+Oj6HosIoNRu5jSMLLvYgwjR29FteIaD+fk3Sl32Gr/VSMsvqiawfiuFrgqXwW2n0W/PFRRLd19QJOjHmbu0UheGEh+dVVIRjx/gXH9yvH99Mz5GGKy7QRbiHDEpgIBo16zKCQ7IIMN3tKGUlgk44AsF+1NkNc/WBQzObZ+ZVpZlHJhUI4j4xFretW8I1/Q3B/6kZKL+XYwU3j0tWrEVuOksLUGSzWlIfkA55L8W3LBeie9NeDEXnKjcgDn1JXlEsZF6tp9Thk2Z84cJ8HEZBpOhVfqZB6d0GgS7HVnH806BA9e4+seb6F/QDvrRmTYDeIDMCHbg8aOKE/lxtnpLXmTFRSJm4QkE9rGnL3XNV9kLrazIadYK9wMbR/PW6O41U0pbwYdiNLQtAASD4pugg17AwXKkPjb2NGCh+qNCkZJWf8Uhn4jIhrE1+9nlfbGkCIWVQpcB87uLJWNFQ7D5l8qrkS/hnCy3nXdn444be+oa49ivu2bCO4i+yj6sm+85dg1Z9rdYCg4U5Rt8jaf7Rt5jBP+Mbwptepu5dsLlPRxAphGnUrTaq54GeojOAbYDGqdnP4Z5Xy74lt1z5cCnawwkPi6vBoAWCMuUIF4VzyE+O3yoKwsGjmsoeAVEp1Y7TuPB+CeiNw4xip28nMRGB4C09se3NiePHzVsDdodEku48l5+YZuDBLtG
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpWenO/0VBhN7a7xvz4bl8Z4LqnaA1mEMvgf5flUQTx98Cc5Xa1ct3STu88S?=
 =?us-ascii?Q?VeAYwGmq5Ynlw1GFxMQ/2NlwzhX8uANrAW6wR+gyk97K6cA74z+muFt8IXDR?=
 =?us-ascii?Q?bPuIfLs4J0Q4IsUfW2uSWP2DwtwLKHehfdo1EyR+omAVX+D3mVJRNCVN2JNk?=
 =?us-ascii?Q?WF4jiPurw8F4QQYc2i0hbSB7Dfs99K50tXNA4dpYdWArLY5Tk33MqZR7ujCs?=
 =?us-ascii?Q?UyZkcB8NFjJdvNKQEGPy3IWl7Y+p9tajtxJs3F5U8mP1Ky3XlirOIAxAr3pj?=
 =?us-ascii?Q?/JnSfSBTeUqtO04GMYLE4qcCpb8lJyD39R+kSan6p+WgiaB9w0WXpQnR7Lsd?=
 =?us-ascii?Q?+qe2bSOnoWaBAzssY2v9HlOxdw8Gg6rLTFdotrT0fBSb2QQtu+Ag0ZA7PbEB?=
 =?us-ascii?Q?RDleuSX1tg8wNccG2MjYqF+lCDKfr+0HHK1BF0K3K2xNNnJwtoP188rDCEvE?=
 =?us-ascii?Q?IDcpqfqsnwCZwRu+4yMo5tfyihXFl0oNk3OIttTKFwCGIMD7zGul3LZVQ+il?=
 =?us-ascii?Q?/paGJnMARSZyB+pw7KPSqoOr60gwbLVnz2Wm0YjmZ4nbZluWOdT7+AVBRy0J?=
 =?us-ascii?Q?3WWeyod2zn9Bns8RqY5rhhGpTeUi9wt9vtuONnmyFGLWQX/IZPLmB/3ZpPaX?=
 =?us-ascii?Q?XIxdcdRjL1sbpFvERhUWgT2Zmhycxuz7UnYYBVnkViGb5QL0LMo1eoCuliZ+?=
 =?us-ascii?Q?Tar3UV9AUlyBx+fbLVp5BoedoSGkkqS42fxNs3YnNSDpxntxbFwqwPG0RAWV?=
 =?us-ascii?Q?rWI5WlqYAAgaO373BUKXQqRaRudpKtNrM/+vUQfU3izo16h1CUJjvCv1f8dW?=
 =?us-ascii?Q?kyN5Tqn1Fgazcyo6m9892QRTUSDGd+ArS+5ogBX59zOdlqIE6lO2HtByo+7u?=
 =?us-ascii?Q?xKedupq4ot773p6YVCV+domlSKVo0Q6SGuI47L/5bZP6fkmHLbkhLtSsEer9?=
 =?us-ascii?Q?odAuCmEuSHGw9OTI2taOrJwW7+2Vz75XwZ9kBDQN2j1RRSDhWaH/uy17LSmf?=
 =?us-ascii?Q?uLKRgghtnOqUT61w6y+hwBBxVd7/eo4t0gx2j09fdEOIEPSxenyaGShBwsSK?=
 =?us-ascii?Q?v4BIMIKSDC+0+65McV5YZc84W9luZY3d59cayNAfHoK6VEIzdOE6CGfISg05?=
 =?us-ascii?Q?jv+MvM/xncrl7fDv3i7zG1jJewWVkyphEh1jPcPE2vt3hPDJXK8YOlvGhQPm?=
 =?us-ascii?Q?8794ROZ+7EcqsOu2SHu6+WRtDAryhZywGFJpKSYatSP9Q1zLTFBtfYrLuJ5R?=
 =?us-ascii?Q?I9tFZNzDn6vKwcCTqxGe?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fdbd8b-aefa-4c31-6ca8-08dc97f41994
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB3528.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2024 04:29:45.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4160

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


