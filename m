Return-Path: <netdev+bounces-110719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276492DE67
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE9BB214B5
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837915E8C;
	Thu, 11 Jul 2024 02:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="Qt11Nua2"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2138.outbound.protection.outlook.com [40.107.117.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A458C133;
	Thu, 11 Jul 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720665327; cv=fail; b=DUKlEADArpCLikdHZvYhPkG9/8pzaQtmjY+NosWq2HqG8jx4JWcVRZzBpd8lVhbivEwFY0BbNJF06HgTbJ7+nVGbAvCbZFpIFg39yI6p2xcVd/u2SxTAkHitOENLgiN4b3gU5XgFJ7hdUbVBXa46npo0MBSTImAFfucvPsPyIRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720665327; c=relaxed/simple;
	bh=3zfuP1sv4iUvvExyRqIChypttB/Fw5J2yKi9/EXQgTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sed1bl0TDVBXB3gNH3E5wBUa+8UCVJ7ZiH+ztJ3QRS++mhwzCuFw82HczAR6Kv1UH2T4GnyfCBMslfTLulgxAvo8hpCdUj+YCCwBAzCA9gK4xPcryKW/C3AO4q4H7wEzMvfnS0XZNUycCKJKAw3zCc7FZ7KMDli39WiGaPt67FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=Qt11Nua2; arc=fail smtp.client-ip=40.107.117.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JG8NT/m1VwWuRrn51nkNtIyCfpOaD6ApxRxMkYQ5T5KNF4BVP7ethK/+es/avLWyx2CavLlMiQBZ7mHGosqZaTTXqIKQHjgBuqGi+Pyh7SiO0W0DLiTiodxzQ1ziolHh15ezgGKVkvxnNfKkmDXl0Dcu810RBNkaoS+PkM9nrpakm+sc4CTkss1FP/gLr/N+6DkAc9jdHPr88Cf49AC1uUvAjZQxeYoUuQPKiLdrrk8HTyCw7RM/4lt7cZ0LUmUVj4E9IIf4zI1G4CQRfMosBJpRlcPweuZDjt108VPlh3tPFOktljNyqHmTIpaqvZGOod+JACJETewWfc67F60/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duN7N9TURc9wnKlLcQJnw5LloNUvtgiA3EKnROioOoY=;
 b=OCxtlg45k0iPYZ/91Nxor8tKFfVYgJvobxyvPdgZKEQg6IoospXVpY4i46qlIHSerJm/cO2iOlWJdBQSRSLF59IVVijDxgn2UQweO1rt082vjXUYjExj7Bk+sF8Hfg4trT1C6P8zI/KkuyMm+kGellR/MvqJrlIHw+oUJBsxW64UU0+O3M/hio0R0eNj2Px0NO5Q45YAH9Jm0J10viPaHOxjPxPV4ucGVzy0oVSCluuANcJ05ExmLm3EhPzwqIPpS+s+jEtzP+UTdSDdfITDLelU8TfNYKVaiYP6xdniZmPp/0+Wqwst5POwJZV8sJKsrawhjNf7OQ9mCCfwlXBKWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duN7N9TURc9wnKlLcQJnw5LloNUvtgiA3EKnROioOoY=;
 b=Qt11Nua2/f9XTaZROnHG+FKxHukIavYPax8mOTKS6xGE/9uMK7c/UZLewxH6D6Yc0p3JEBy/tP6pIK3qiZ2See1zvVHhQOJtoVRY9PlaO9O+0Zu3/W5eZEEcrwEIcN9HOuYGuCHWAdClFKnkGa0FCrkRxPZZDi8eiYhnZF5fgQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by TYZPR02MB5713.apcprd02.prod.outlook.com (2603:1096:400:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 02:35:20 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 02:35:20 +0000
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
Subject: [net-next v5 1/2] wwan: core: Add WWAN ADB and MIPC port type
Date: Thu, 11 Jul 2024 10:34:59 +0800
Message-Id: <20240711023500.6972-2-jinjian.song@fibocom.com>
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
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|TYZPR02MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: e46f98dd-39b5-4c2c-9cce-08dca1521b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBspYi6uWrFVVWCQ5y/3RG1FqFgO6+OgthiQG2wWbe3tTKeO+nkbXa6gGVBV?=
 =?us-ascii?Q?FogMkJiITucwiacQqGct5ic4mYlUinZJxaODJo9jT/mEY6amBHzkA+fiShIB?=
 =?us-ascii?Q?DTS6ksc8C+7nHeW9W4F1oC7PnuQj8BAA4FjGSWsVLYQ70ZsmrXw0KKbgzfzu?=
 =?us-ascii?Q?mPVjmIslh7GFbChoIHkN6ITF7R1A7dr5FVkKxKiXjMZv7NkCGQ1phqkj3FXL?=
 =?us-ascii?Q?GY58jPQIRASV9VP6mGxz0DfqYXdDHXErfFRQcOlvtLCyVKEE7rmU6UTzOiQf?=
 =?us-ascii?Q?kEIuTXG69ZCTvwnA7C/+c7KhkAdG/5Um5sb1jQj8+nQbuQKPe2FiTjAy4Hsu?=
 =?us-ascii?Q?dkQXfdf/U0Uv5SkjDFo4vwQIPhHMfdzajiNFt3VbW/8G4HzGYy7N/g8L1P3I?=
 =?us-ascii?Q?uOLuVYE0kQRJT9sZy2LVTcqZVb3CBVbKikS9w6tOncokZTqzA0NVRfYHvnTW?=
 =?us-ascii?Q?H2S4kOz3iTitVegzfbq813T6nHTiSk0SZmsnM2fRIamkPD6QT0j5722N72ZU?=
 =?us-ascii?Q?daflvtA6JY9g0zbG2DWBjRpuF8uXX93DyxtRtRVRSpkOsdrUu35uoZwtk5Ja?=
 =?us-ascii?Q?rphqEoInX/7mb/PyeEHIhMNlgh6b1Li9dC8077rjZOZhniLN04OHWviRlTGU?=
 =?us-ascii?Q?n/VBNCX+2qIgv5VlMMu93zAeKh5nRpU2FhC2/3Fs+dHoZxGPQj+T/VdAdJHK?=
 =?us-ascii?Q?A2NNYy2/4uIazQmiNpLyQUC/pYHxQH1acMiMhUypLEQI6Pi5WX3S4AcHYYBZ?=
 =?us-ascii?Q?R+R+pMSXNKKj5WKYG5CMR0MrG+56Xn64kKnK2GMUhmvpc7LAhZsJdeqPWMSm?=
 =?us-ascii?Q?yAzF+oc/zAQXOOT/yfvEOZDh+ZJTDOz2YUvi3Yl4afYBIJxJNEM2Cxytdj6+?=
 =?us-ascii?Q?MR5JyCkA+OJHILxh7lgxFr80KeNk4mQ3BIGIBw2QiTQOSm40Qup8XVkKeEg+?=
 =?us-ascii?Q?micN7TcSSidiUn6t5zcl1sp7/MH2+2el48ttN33QE/eKe87wF9HLqkvWrkH+?=
 =?us-ascii?Q?A4dapIzwJFv+ybXQ5DodLSJlog7a1cjFQpCB5t4bRCLqjSjmPAOXI8KvWpKG?=
 =?us-ascii?Q?H7BTjJQbba77AmThFEBvi5ZHsbm49gsO9Y++u4N2mazdhPqYZZTmitSChAX4?=
 =?us-ascii?Q?XA2/lA3MJByWXE8FXLfD2l0oSvmtm+s4ewN2w9JZvWZPKAHPksJrFteTy2rr?=
 =?us-ascii?Q?WZqYA9u4/pN2VnLi5M7MaY3Kg0W5XRi11U/WmsMnf5R7BAtDm3eUzZi4366B?=
 =?us-ascii?Q?jsZAtxyOVbE5APy89mtEKdVb9aXwOgjPW8DnCswJ3djTHmAVmCqs++yd3kXC?=
 =?us-ascii?Q?tG8oZplsaWTA7UHZJGALyh242oyZ8mlwMr3J7MFy/aBXGi2bBOk0TIPXqnVG?=
 =?us-ascii?Q?JzcWbj6Yq7brvk8FIKH8BEnhXosaYrXeyQpNUaiKNFGh/QVH2ZaUUp6jiH3k?=
 =?us-ascii?Q?u4JN4b4iOq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0S9Y0RiCeFLFbiFZCoIrWpuOVVxGmavmoVsNTnviY20bAVeMVWztDSX4QD1?=
 =?us-ascii?Q?s5nr2ohtXx520GQ2UIEyWi89eqD9jaS35wsu4T1hjTed1WwOrBLejGHgkYhl?=
 =?us-ascii?Q?ewY4kGI+yo21fN97VFhxvLj7kYUkvpzqieDmMJHx7NisWGamrjqb1yDQZsTO?=
 =?us-ascii?Q?QbeJCq3lL+YGjJ4HfEiBzve/ArN6/mnhOBA6jGIdbQrptoedTHO3NaJVldaO?=
 =?us-ascii?Q?ej9U55gj3+wB+C3ugg93IZ2vy/UCycoEnzyP0QTaTgTWDCLAiShIBwGYzOMM?=
 =?us-ascii?Q?0WifyvrnRPRNnAlaHjNliOONeZMAtegxMVhIZAthtap65ejCwiP981AFjDIt?=
 =?us-ascii?Q?OfBJn9hbrjvqozFXwGo7/lzuhZSehhJqT40I7Enovx3VyQCZGBQ1gAlo2B24?=
 =?us-ascii?Q?P/AL9YK7ej7FNgF6j8FZfUjcTdHMg6g9dRskb/sn0pDSgiJGDd4Q4vGynq9Z?=
 =?us-ascii?Q?VuA2ya78/ITVWwlJqEdCQTroFL+ZOrrWI9xy5EhHmAblHO/I7TceIS/n/Mm0?=
 =?us-ascii?Q?Gw01B+n3ajkjCu8E26UFYtDWewJy1CBBM8/Eqm9JL0WNX70GFpJO0yc7RIsS?=
 =?us-ascii?Q?ZUj3gM2DtvOVUD/zt/vDKfNc4pfuZRF2h6IVD0W9hbYxrWBkeNW5RawiPPA2?=
 =?us-ascii?Q?Ke2Qmt8g/CYGNfgT7q9l1OWTwHM0cKrM3IBzdmMPagscLv9FTZ0yHRGpeWSK?=
 =?us-ascii?Q?hVWROYeWOFS9V+rf1BGZYGe1ACZvX/rShe+XHHDyjWvzSiFj0rRr4OO9OL4R?=
 =?us-ascii?Q?jqywBbYK6siv4m9R/gRz1ABRQl47ObVHuaoHRYMbBEiCrUWHXS8NWGKuN2Ta?=
 =?us-ascii?Q?LJSmb0YIsUQQttBCJugoZ/lPeE49ibxr01ixHkXHRnGb8v9RC20TdtFFCVq8?=
 =?us-ascii?Q?VoPTYGJ/dKigNR61V2WvIjzSk2oiKwaG1z5JF/pBEyUAtkjVBMDDQXkxiRMv?=
 =?us-ascii?Q?hWRvMpn3rbs4jzYiSk1Vr8js11fExOnpXgLlv1q/ZjbriPIOGsY2JPqL7Mev?=
 =?us-ascii?Q?cTtH+3WlrPqVE75vG3IJ+9gKHlJJWfvHO+iMkRzlvJ7RaYBDFb7By422pF1C?=
 =?us-ascii?Q?Xct8WnL82GohxGKkBZlO5jMXbS9DkA3LENapWGtIDgqzOQDGW54Be31jp6zT?=
 =?us-ascii?Q?ITTT74Vp1x7w437Fx9Cal+EdeyGPa56MSliYuEhxEZumfqcyCu3MNuFR+T/o?=
 =?us-ascii?Q?pERxwvQasY7naAROYwZzDVQTO8E6PaHT2aHEyGL+HjG3MRQXdXeB5WbkKbRZ?=
 =?us-ascii?Q?0x1Mhw8dyaQ4IFqrGTIQCdsUeOBIc3MW4ih0c5xYJo8p85dqLLWQp2gj9LPs?=
 =?us-ascii?Q?LYVInqNJb9N/DcyComBIY6EIaTRUVXW1gFsZQ5z1aW3eChkI+iRnxMydq01r?=
 =?us-ascii?Q?jhC3Io96my6FAR+B00ebKbG071/UZYw+3sl7Q8qVAlu6rb4BmsXDrX8wDU/r?=
 =?us-ascii?Q?wLv2K8MxjipN9fQJntkCX9Wz4nrRoxiSRDA37qrpkb++qpjI+bPwP+aygr2k?=
 =?us-ascii?Q?o7dn6k7pc3sVDPJYBdS2BMQ/1hI14mG3DdT9XmdfX9QcLHolMgII47nH/nZf?=
 =?us-ascii?Q?JHDJn8uwODRVADpuLIAil/TMz+xuI5aAaFmbLmmuiOjkWr5FtkT3dqEJyTTY?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46f98dd-39b5-4c2c-9cce-08dca1521b48
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 02:35:19.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIwJnHREVZKxdK0co6+z18VJKoNp0wCgrlgW25Y2lNjCtm0qbEn0FnX/MCvP1dVt/dOSVhJJLm9qr4kcTq81tLyR9g5qMG0+5QkwBtw3klE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5713

Add new WWAN ports that connect to the device's ADB protocol interface and
MTK MIPC diagnostic interface.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
Reviewed-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 8 ++++++++
 include/linux/wwan.h         | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..5ffa70d5de85 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -334,6 +334,14 @@ static const struct {
 		.name = "FASTBOOT",
 		.devsuf = "fastboot",
 	},
+	[WWAN_PORT_ADB] = {
+		.name = "ADB",
+		.devsuf = "adb",
+	},
+	[WWAN_PORT_MIPC] = {
+		.name = "MIPC",
+		.devsuf = "mipc",
+	},
 };
 
 static ssize_t type_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/wwan.h b/include/linux/wwan.h
index 170fdee6339c..79c781875c09 100644
--- a/include/linux/wwan.h
+++ b/include/linux/wwan.h
@@ -17,6 +17,8 @@
  * @WWAN_PORT_FIREHOSE: XML based command protocol
  * @WWAN_PORT_XMMRPC: Control protocol for Intel XMM modems
  * @WWAN_PORT_FASTBOOT: Fastboot protocol control
+ * @WWAN_PORT_ADB: ADB protocol control
+ * @WWAN_PORT_MIPC: MTK MIPC diagnostic interface
  *
  * @WWAN_PORT_MAX: Highest supported port types
  * @WWAN_PORT_UNKNOWN: Special value to indicate an unknown port type
@@ -30,6 +32,8 @@ enum wwan_port_type {
 	WWAN_PORT_FIREHOSE,
 	WWAN_PORT_XMMRPC,
 	WWAN_PORT_FASTBOOT,
+	WWAN_PORT_ADB,
+	WWAN_PORT_MIPC,
 
 	/* Add new port types above this line */
 
-- 
2.34.1


