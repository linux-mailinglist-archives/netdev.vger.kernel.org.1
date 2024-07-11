Return-Path: <netdev+bounces-110720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076DE92DE69
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DA81C212D2
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36556D271;
	Thu, 11 Jul 2024 02:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="p5SAVGSN"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2091.outbound.protection.outlook.com [40.107.255.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6118A225CF;
	Thu, 11 Jul 2024 02:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665333; cv=fail; b=nIMj/JlHDeA1vCdTXexarny2fOgmUL23EBzK6RYEmuZm4cFsaxMvRaup2IzxUtMEBwqC7X5M95M9RKCdas3IAELU/QwpKKUQty65UQ3EMJRl3QDOCAZqarGsIkbqtvU7ntZthlFCOCWod7S5OVFgOYtuSAl4OxYXtRZQy5mAdLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665333; c=relaxed/simple;
	bh=1PNojwSDsHgW7W3uQ9YJkPEVrI8qjBhplnR8GxAp2MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhCkQatJIrHRjsDmBRGRr2k6dPHmDBcC/QcgnDHw2YDTJTrmXz6b4h25PsaJduxD0Rco5i+YPNnfvhIlLXEGHbVX21/ATzaIlFSRdkux1ZHVCeLqYrJa8c26FM0NLI1Ksilm4f28Qolsa8GbxRh0F/FJqCCAliafKFfZ0HE/B9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=p5SAVGSN; arc=fail smtp.client-ip=40.107.255.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUnSj59MwMykP2P9ipleZG3L3ErJIyVGVaeku9/VR0JeCEL9GA4PgM3K1k294YX16WT6tkNXarxzALTxEJPPRfcaou3tHldzFxvNHz2VZ2eeKVvD0cSRNX6wJqERC3/+fHcbgOKAWRY2IV72m1OpkoHT2Qsj7koDwkDJWNkgL7zVfig51dA1iFhdsoEefd38eX7er91BaazKrKkiZljJlunkobSzAtyMfuc1VD8r8Ahzk5V9vuzdbs/holWDCwvuTaq6QBmwrbrQNrkLtziBunMjBTREsAlLxPoM5M5YUWc6TcDeZqTTNojk1IxX43dSCkgc5SowWuE4Yl2bT6C6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZTIlXFBMXbsYpmoUNS0lZqscPH099e7SC//Jpl8ni4=;
 b=GUFegy+fn8nqWbnkus5iHJI7CW701IhsqL/gqoYz/JP6vNksqhevVVyf5xzRv7/Toau02q6EISR044BWuLcgWFjIrrXnryj/2jsWA6Zk8lHDS3+gHsOWuy+7Ok4IFL23ixak5JXMRYtR/4uu9DWetEV8GbCW8UXh+qS6xFpEnprhDoir9tH9edX953H4OVZxHt086n8l6clrMWdpy5IgAbpRhduMSdfr/wZTZ7SSs5ND67nAeIDY8Hx031t9Bv/UiE9vuRek2hLCITuRuwvgGgInkggXHASND7zYwWvKP8fXIppA1dlkSQFxoMSDI4VVje39BvDFQ8lGa79yqJUO9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZTIlXFBMXbsYpmoUNS0lZqscPH099e7SC//Jpl8ni4=;
 b=p5SAVGSNW7f5wTUU2uQ86h3EAzs58Zt1oPe8B3XTkzTkyxLUSOnkE98xQ+YG1WVx0/AeJWVThgqwzz1hhtZ0/p+NRrRoHnhG2uP1SDq+p//N3YpC94Dzu/5rKRpzBgXVogIq16AFGKRVeFRVJhEbd+RyO+x08GCMIKeieb/f6WQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by KL1PR02MB7168.apcprd02.prod.outlook.com (2603:1096:820:116::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 02:35:24 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 02:35:23 +0000
From: Jinjian Song <jinjian.song@fibocom.com>
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
	linux-doc@vger.kernel.org,
	angelogioacchino.delregno@collabora.com,
	linux-arm-kernel@lists.infradead.org,
	matthias.bgg@gmail.com,
	corbet@lwn.net,
	linux-mediatek@lists.infradead.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v5 2/2] net: wwan: t7xx: Add debug port
Date: Thu, 11 Jul 2024 10:35:00 +0800
Message-Id: <20240711023500.6972-3-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711023500.6972-1-jinjian.song@fibocom.com>
References: <20240711023500.6972-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0175.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::19) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|KL1PR02MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7a1673-8408-447c-61f7-08dca1521db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dWGRDgYkhk67Bw3pjQKgMVxy660v/kHzRVWNRlnVExJLlZXYiQcq5APxX2hw?=
 =?us-ascii?Q?p5R38KNEEZlKQDJZ+89xhEzwZFJWwDHgWZOFFuoJ0g4rAgTX6dzwdsUQlU6I?=
 =?us-ascii?Q?aQPxNba1o5kG9C7pKPMyarOtQBw3ulPw5jfmO5+K2pq+92pXmYbM92XoNoMG?=
 =?us-ascii?Q?qbHRcTvWDMPkqdvElGVdaeGoAIvrGHkVGX3WQXOXtTMBEREdtTRg5J0M/EBh?=
 =?us-ascii?Q?8tcBjixLBSX2PGPZ2dLSiylQGAdP/YW7xr4RMf3/TCfkcLRsYjM0A8zvuKgE?=
 =?us-ascii?Q?Yuai4woHN0r+hbSHYv4MSDnqtrYaIYlHz2a16lKPbLEBajg3Nu8ZRp7PULdE?=
 =?us-ascii?Q?uOC8uHdXSfk9AxpPBGAxCPxDVROcVXbU7W3VESLzbN/htgY/9KMoih9gU3lD?=
 =?us-ascii?Q?Hv0NZw8bqktiAnioHGrK95Db2Jt3wIorv4Xpy3HEN8DwJz9iGswa8jyaKhWM?=
 =?us-ascii?Q?Pt4imL71f7y/sQPRFZ1fHe3yxyfte1bnnZh1WbFfShajtqBTZc5Olx/eo8qH?=
 =?us-ascii?Q?2vGxRPOmX5rt9zu15BxPmghuFrLzkDy6bRW5WPv4gciZkBDTqaFuk583pq0a?=
 =?us-ascii?Q?5I6UtWPETiIgJYtSnJ/ghp3yxGZOITy3JKdjtAZ8F6A9F703RAR1hCxdh3LT?=
 =?us-ascii?Q?5saMuxRa9EIfV6xenEvXzTJMGODKdzNjXR8+zQA11NmWEF0rMvAWRs67CF0E?=
 =?us-ascii?Q?WJZvyJ/nQxe8HzUTNotfYai5YTokIpQ11b/KwZYy+JN9TZqO3ajTQckT08rN?=
 =?us-ascii?Q?Cz/pADwpEMZvthsKTswfqNEbBe+CvEflOhcm85R2umWtcWRh7yvz8770ox5o?=
 =?us-ascii?Q?sNlToSe0rafqCfO0I203WqxsaNvxBqYgr01X9+MLra0Jl2vEaR8P/aewf6QQ?=
 =?us-ascii?Q?UMWAfcYBkhFDv2Np3j7tswmSbfyYtyujtSJm49vfTY8cagxw5CtLy7Tsk0ja?=
 =?us-ascii?Q?RhEoa5/UuOSu8hgfVYBT08CachFkEcTyw3S/GC1dlYgQ01ILObXg8y9Ux/4Q?=
 =?us-ascii?Q?w2apSSHBKgabnxDN35XhH5lFOIbPBY9m5sE0rQkbQXSfa1zlRdGIl3i2dFk2?=
 =?us-ascii?Q?YQxavQ1g15s0+6u5q83hElY7bagEqx9qzPDu7maziF2gaWKTCLrvbk5EOc0I?=
 =?us-ascii?Q?k2OkWolPF+gw/STSQT1SzwXemQja3lXzh7UR5z+C2zRaQI/lTDzG+Wd7lnRZ?=
 =?us-ascii?Q?6A27zMuSaXr0o3eWQ8vhho0XMNHd1wLCr2rY1fn8Hsr5VqRQwsOr9jPFXDSe?=
 =?us-ascii?Q?ENc29vUVdsssk5LaQn737RoquYMfVOCRp71YQAsKfDKgCWsb3fxy96WoAmn+?=
 =?us-ascii?Q?pEaT5zjqSB0qZHIQJNCWzco0H1lgkc+LXum3f/Rha0HMmPuQWHCKGvzWgZsL?=
 =?us-ascii?Q?GVc2pJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S12Iky+oOuXtP4mAhyNb+nyx2V+X+FvN8awQYihVG0ne5YoSumTX8Q9JOPne?=
 =?us-ascii?Q?4ed9BQLDWbPX8WaFFRvwGcdIs9rLr4UVguJuGUXgzXD3usf30TwhE/nrBsKv?=
 =?us-ascii?Q?WwMVoC27EDbkM4+94CtwrvdK/5CleTTG+wV22f57OgdE4h/UdGYBp0fqpXAT?=
 =?us-ascii?Q?4O3MjiItTBElXlG0UFWzH14RrpjvoP9WpR/1TjJN6qz0AL63aGx3DV4X2/XH?=
 =?us-ascii?Q?Ee+vBiKxjTJTZiUGEWGInzhGjsogKNWxJNISt0qqY2Q1q+k8lbU5J2P4u4FZ?=
 =?us-ascii?Q?Am7mJDnQn5+DQmMHqsFodCP4kOFey6pOUZGYzJZ5nVCkgwlgKrkPdmYRzT1O?=
 =?us-ascii?Q?V9LjBfBusOlOq1+u5BZ6XTlKS8yh+J6fYpaHhYls/Qhl0pQ/WpA5AZbyrFsT?=
 =?us-ascii?Q?o0qOZw/knl6EyaNx2uX0/oyoILklg5Js/UFcUR2nh+DhMPcrB3VIBCkJifcY?=
 =?us-ascii?Q?EexTVNt/GQTuNkTlYdNIceL7hn5WvXi1U+u0fWbHiZRHYbhp4HG/wiUUFMB6?=
 =?us-ascii?Q?pv04QSiV1a27bO66DEZoA6z/A4Ruh/Y+RCOmWF0i/ioHZTcoE/FxXVONU/Ig?=
 =?us-ascii?Q?IREnJAfPJ9uXGOP0mHH29+pHyoDpmPVZt202gUdmSGq6tk4T8DuvkvIh373I?=
 =?us-ascii?Q?hjSx0HqChWe3PbxwVhX2auerzVhJcrfTgl29n0sFrCZVg0arx+t0RPyjcs/Q?=
 =?us-ascii?Q?WeYNeShcTdUZ/O/Vya5T57/WlDgdIgzgacHBD8G1MsCD6ZiEyk3Ci0aHVYoN?=
 =?us-ascii?Q?VZGpVXotH/Ks/LFNInLUDgzKHOsywN4avun2i1g8crVST+UjE8PkPpCLwesJ?=
 =?us-ascii?Q?u/ZxzgnBbxn32x/EiXByfMizy0ZcCkSRLcMlO/VXujhBiYOo7gXYlfrjK0ek?=
 =?us-ascii?Q?H8pYFxQhvscXY0/devQAzAZp+1dw+/XtDcRp0wbN1XfVUX0ob5HAgUXWB63H?=
 =?us-ascii?Q?/R4ZGkJ4Mto8EaV+Qx+PEpc8ROmgL+lfOZeZrE9nwwrQVBduqxsuOFoNEI3X?=
 =?us-ascii?Q?mkLlXVC9n3lo8GYpiWd8ydl3l89F5B8U6w1Uhvu0gs1TUElaLs2s97zovVB7?=
 =?us-ascii?Q?FRCf3pG8MnHtrkz60TN0KKcdujDh8sjwP/JCsY/Ul9byvbFmW4GJ/lDj0UgK?=
 =?us-ascii?Q?GBmhQmSKOuGhdDUEH2bJU2u8CJXGpL8IF5mCc480lFh8Z1TzQqkdmqPwnZkt?=
 =?us-ascii?Q?r0icLgxXIyR6KshmK2BFSarrI/H7BItgVRVWmsIhq2wjilgGMEpx7IZA5suW?=
 =?us-ascii?Q?ohTAX6CV0IOKON8qfk3VpkHZPvqZrRIiIGULAUUaKZA+f5Np6xSWrLtJp3UA?=
 =?us-ascii?Q?CTBnf/h3CKfmqNvA1pJzsHfyMzEbM2KhSLtrwRuGhQURiXSQ+YTvnEFXGzy3?=
 =?us-ascii?Q?NZh7Lr1dA2qkpdwic4xknwZgYvmwoQtRXWfnu/ndTBml4EVXJBkVZpvResuJ?=
 =?us-ascii?Q?Y69tmbl2Gie91TBuq2+ZI8vYkL+tzfX+SFdkg6DLZZZtLDJIKpXmgdg4iUit?=
 =?us-ascii?Q?6f7OhuLz2QrsfJ+huh9hCj2sQnzMDinPWD3Yojw8yPfVUs+qADIFZf4eFmgW?=
 =?us-ascii?Q?lOTRGL5XYAaOX5Wwj1gRKv3UefIla9V007OV6tTUuDJL8zKXQwqjO93P29SE?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7a1673-8408-447c-61f7-08dca1521db3
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 02:35:23.8306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U0gLyvSAwSSXU7GpAcrh+jh3Y+4hrJVtT9fVTje6DLXPhrnt5EmdejiaA0PFtyCRtqBrCIppAxlFtg6bBzh123Z2Dt1OBhF8bShWPbZhTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7168

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
v5:
 * modify line length warning in t7xx_proxy_port_debug() 
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
 drivers/net/wwan/t7xx/t7xx_port_proxy.c       | 45 ++++++++++++-
 drivers/net/wwan/t7xx/t7xx_port_proxy.h       |  1 +
 drivers/net/wwan/t7xx/t7xx_port_wwan.c        |  8 ++-
 7 files changed, 168 insertions(+), 10 deletions(-)

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
index 7d6388bf1d7c..0b1640ceff71 100644
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
+		if (port_conf->debug &&
+		    port_conf->ops && port_conf->ops->init) {
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


