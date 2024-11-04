Return-Path: <netdev+bounces-141461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65839BB023
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07CA8B250AE
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C811AC458;
	Mon,  4 Nov 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="leJpFKb+"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2121.outbound.protection.outlook.com [40.107.215.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441E61AF0A0;
	Mon,  4 Nov 2024 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730713561; cv=fail; b=rcoYrcmU+xwpZQ99u6Q+PIb/F5cxiSGCIv9X4BX4NVtQOLegGqxnYme55uwJk9RC7QHqXkE4ofa8L2ZmlVWSydzR+Pr7eIEGfjiQ+vcRh8rNGOFCbAC5An8XcvFOsJnayNVhUTbUzcEwoRlt6xcpe9pKgOQSAserPeGp6jCVc6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730713561; c=relaxed/simple;
	bh=98pWwlrBk7khPcN8tJL75j8XyXJXn1k6CA6hSHzHuqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/rbFJZ5xZucj71Qvqfz5LAv366p4EAZcifQ7K5wmn2v9vs+gdsono/m+Y80bbWHbnIABNZqiPc5YpkMYqvHS+bG/kuObOv1NMK0VODf66hwyry2yNIdWfacUtiYI+K4yuqccAHvnuu3npQj8NL/PBWYnDWUIecU5TBYam7bogc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=leJpFKb+; arc=fail smtp.client-ip=40.107.215.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxQ77KoqmTPn7+yxQkCeAFWSg/l0Nhrn7ykX5JOPCP3CiJGfavQmUl0/Br8oz1k1lKJeZYu1ZpOC8JcpJ7qRgQJGHyPzIy1/xtHbDKOwqAlg+b+UVTHUVTAW7JpS6YWJwYq+zImMs2vLeUDusBULia3oPLdajtP/RGkKengPrL+pYpTzDqaWMmAwbGROqsnhruC4n3/ZI5nDxFY0Y4hIVpFdjVqsSlwshNc0j5eqw4sSKHFDY0fgJcQGmui68pKcCPWea5FfMAejjax5zBPFvbaEzp11pXYhd7zYut8j5ITB5mcW0X2wKMtbI3IaIMipM+iCjAC9vXs4RgVLRI3nbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR/IPmJERzKwq7pyhhzpV+mbaE98mDNPcQJZDDRh8mw=;
 b=aHtdC/qlKt/4wRem/pluPQsk8m4A5dlpEnlUIHtrAi78606RZxpXiuxWi8JQrgJ/6/q7U7MTaV3sN+ltFGzQwcMM01hFLar1FSOMeMYrhBPzz1BWnEG/+GSCHwdBBTtcJUcs+qiFY7GJz444Q2OJcU5Zl1AO2rzTe2OIyW+NEAN3vtGtlnMNRO2I7AEKVBXuMI1sjfMotZtz6bHgks+NHtQD6bEd0ZAN4X4NbYM0v95an5Kdc0HSjEBAeLb5JlEGGw8hzuqIxRArLKHKHOapYB7Ei/1h8Eiu/FLF1O3z7vMn9Gnx5xkDcqbCOz5Y+B0i4H8r4WO5w0eKKu99KiMu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR/IPmJERzKwq7pyhhzpV+mbaE98mDNPcQJZDDRh8mw=;
 b=leJpFKb+dVp0issH3qocnT9aLaxSqR6gcb/qq6tDn+UtcEr4mItIJAoodQu770jVH5H5xU3689k012ajctaP5MQs5tvUq52FKsZEGVHNG3bMdVkjs49/z0Rb6AZleNZ/G/D0A2nmuK2VJmJpQdHDJq05/AMA1XnGQsIagUdSnK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com (2603:1096:101:4f::8)
 by TYZPR02MB5764.apcprd02.prod.outlook.com (2603:1096:400:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 09:45:56 +0000
Received: from SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e]) by SEZPR02MB5782.apcprd02.prod.outlook.com
 ([fe80::4843:bf84:bd17:827e%5]) with mapi id 15.20.8114.020; Mon, 4 Nov 2024
 09:45:56 +0000
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
	helgaas@kernel.org,
	danielwinkler@google.com,
	korneld@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next v8 3/3] net: wwan: t7xx: Unify documentation column width
Date: Mon,  4 Nov 2024 17:44:36 +0800
Message-Id: <20241104094436.466861-4-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104094436.466861-1-jinjian.song@fibocom.com>
References: <20241104094436.466861-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To SEZPR02MB5782.apcprd02.prod.outlook.com
 (2603:1096:101:4f::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR02MB5782:EE_|TYZPR02MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b70a3b-b0c8-4b30-e5b6-08dcfcb57ae2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M/USkgIm0r4QnbZvSE7yLkhTuy6NTqudQ+KXAVMTjgFxBypoaHLG7nP5s7rn?=
 =?us-ascii?Q?fr+N9WA5zdpOVRn3L04f8wjSq+CU0WUDjOeNgNwIN2P7HQ2r59ohUCcMEEPT?=
 =?us-ascii?Q?U6eDe08+uVoAzbMOuhNHHtTR1eXw51l5GkJomwt/u9gEnpDQoPGAgFfDhNQv?=
 =?us-ascii?Q?DVrv9fKLfw1QrHBlM4qgBYJPGhyNox43aCntIcTvkvT8t/5TrRV+UJ0U9OxP?=
 =?us-ascii?Q?8qbxzndIWz1xAwedWMMNb2nG+b2ttCQjnb/0p12aqFPND6+tF64DdRCDte6v?=
 =?us-ascii?Q?k/5S6u7FnqyORDZ12tBkdgH40mc+TIZuOiFSOWV8JkBHqyFJkr3LKq+KEDl4?=
 =?us-ascii?Q?Bpp2W/H6UyOASTIUJDdtzIl7+DiKxUnvOq8EW7vq0rsRZNZ3uwi34W6RHwiS?=
 =?us-ascii?Q?E1xrPegVHbxbkWwPqqBGeapGpZAlJfouOm9RjqAs1tr1GjRXkyPosThkadER?=
 =?us-ascii?Q?RYqW4E3FkFaR1kiCSbpBaz0h3esburF9oXz3lCdyh06B6bovvDFdenwVEST6?=
 =?us-ascii?Q?xIfZWIIEgH09NaUVxxPQdwXx1jDeSluBVwLaHpQyOv/pH2qLI/suLzBaIWSq?=
 =?us-ascii?Q?hZLmjJkxkOj612/ML/MDahbc+VoAMp1EgoN26qMA4/RXr7z6X5O6z46wu1eR?=
 =?us-ascii?Q?6zG+xoFfXyCyQ58E31T2TB/x5OE49VmPZp5oxpsIXwoMM1WeH9G07IYU859n?=
 =?us-ascii?Q?cpIE7UTiVHbi3jcjmTOoxo5r13bxi12RWwmZ2PK9FHzJo8CIM89dYDEt8U5K?=
 =?us-ascii?Q?/oqnIu3bbayz1RprnPI2aGHxXuNsmCGuGL4Mqa2H1O2mNT0pn64lW7JCc1MH?=
 =?us-ascii?Q?1kFQxJ9liAzNwTreXAannNb42vMagIDOTPpVuoLfD60gK40EERxrLp6dYDFi?=
 =?us-ascii?Q?jbqjmPzsyYnJbRKxHo42P9F++4IpcL17iKTn9PfuF3J5jQ8+2964H6wjC6Ie?=
 =?us-ascii?Q?nBLHFP0bfy2brrSkVOoDwgsjlqPjJ33IL38t9HPB09osu4ck+18fTYSDqZkQ?=
 =?us-ascii?Q?Sb4eHIFI6o/GBeyv42bL3wBWR5QxYALdhKMir2fd+nHTV2J4w144IVmAWUPv?=
 =?us-ascii?Q?EiRCDNo5hduLcQuZrq+5fKcytpt7SqpZUaamdNCt4UED5/uWh5QBo91gemKM?=
 =?us-ascii?Q?c6HhCi4X8CJKGFKupwAet1mvUV+E6Fabx8xPVXIBXqiMtVkPWcsCSpD/ABsR?=
 =?us-ascii?Q?ZPawzAFVd8yW0raht72Tj3FT3dZjEUg6Nk8usHipmpjVryYkTseqCpuDZp6n?=
 =?us-ascii?Q?lziBehluwGxQZbYheWu+JyUc/VFvCme43qzdE0WdUoycrrNhapzROlrN6xso?=
 =?us-ascii?Q?sPxdj94CNTjbO2OIVQbrmx5IjMtUs/md5dxAZ2yDVX/huZr/+1D7FsL5xo5s?=
 =?us-ascii?Q?tG0Zc9wFFQhNYcI6tbEjI+ioiLxB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB5782.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9RxOlGxKiPeL8sar8/iyty6ib5oF3disbbCVJHdp99DhsFYRhzl7Xk0JS9HJ?=
 =?us-ascii?Q?CPOBj6K0hu639ayP1oHIYYoXxBR8k5KvayPyscmFpT7GXWWGGB87qM95XCOa?=
 =?us-ascii?Q?Ae9XtN9TYkkD4inGqowPcILA8G6c+klA6u8IbF6hc4ClCBeGC76M0T3pYPVw?=
 =?us-ascii?Q?fqNG3ruHh2QjebkhaLkk7/3yKr7K6K2UlXG4oYVvIbF3lRDbJn+55RXIAUNG?=
 =?us-ascii?Q?raAPQqI+hzpy1PlayHXLqi8lXE8evlLE+SyG3gVzoRX1q0KDTZEitbuoWQpb?=
 =?us-ascii?Q?Fpu/Q1+nOniTbIxEcu/9hJd/zytaqqSI+SRe+FlPsToAHJApRf61mmYMe5c4?=
 =?us-ascii?Q?CeXVQShM7h4jJz686ij5QliLShckcoFUGTVNlTaGHpnnd2odyclPFNhFVi47?=
 =?us-ascii?Q?4zRV2m1TEEKZJyao/67AD1zAWFZDrI4GTz49YcpPyDCRO2wXa5ueNtR89PjM?=
 =?us-ascii?Q?+nXD6o7IpfvuzrYEkan2v+JtM04pZ+q6srtnPVd0e646CsmjL755f969n23U?=
 =?us-ascii?Q?r7Zdv7rdudoNw1PMO+tAV17dD8b7cbr71kpsfcx8jxPnaCDKGwJgbgiDN4fq?=
 =?us-ascii?Q?nofU8q9cVOkvaUWC8woupXM5weQyvH4Lq9q9LnBb5iJQoUx4x/s+zjgdLUVp?=
 =?us-ascii?Q?wsONCqMpu5SILyD/zukKRcdKQJr+RmwU0938YbcfeRrNgRFISRnAFPD8vNCI?=
 =?us-ascii?Q?KUpwC+V2p3dYtJh3Kh7c9fPiDdv8q62aaS+LqJ3MElVBAKyExB1BLjEMkJB2?=
 =?us-ascii?Q?/CsTMFQaS63lHDWnTRDPjFpFkwk511Yfp2z/PGliWjqkuo9jDLXQt91Z8pZi?=
 =?us-ascii?Q?mZGbpzfqkNwr+Zpx2nkK3LxeLmwref5SjdZXQmBYeNv8hrVH8mDk59PsyMRa?=
 =?us-ascii?Q?k6j+Sfm/xQ++xCuqEjw91oD91xUjv9X4+c70wOIufrja221lPPOq0dkYZwH7?=
 =?us-ascii?Q?16k6eaWH25KASd+7m2X2KjdBblQFcKx/PBwFB+dC3vfY2URiQu+n+vUVe+uh?=
 =?us-ascii?Q?IC6ekYfzmnsl0YVcWEKkCDUp9Zyps/XqZEJBDUb0wLoAH9NF0d0Jf5RRUddO?=
 =?us-ascii?Q?XXPrLHuC+ILUuVRbgr301/oIVRQthl6f2RRaKwxfchGGS27WwW0VK9QX4FRu?=
 =?us-ascii?Q?tH7EiCqDiZWPv9hVFkh51ZbMePEzzwhM5NZurrjqAfj6JPESEPY8+XwMekmx?=
 =?us-ascii?Q?RBeGs3g0e/U+DwQIlmxyysndIqQ1gyWEFbSjy2otOvkV6dPX4NjOdAPRD7MG?=
 =?us-ascii?Q?lJtZrZef3iX6siqzXy8nYxvsZty5LU8SsALQpI7kkEFH9R4By8oGti3F4Jwy?=
 =?us-ascii?Q?55BiEbRF3BX9ue0gRJFpaT7pZoo8l1c4KOOy3CPJgdn9n63OxE+gTznP+OjO?=
 =?us-ascii?Q?o7kBUSB+3p4bLTr3XxNm6uQ2y91gBxYsIafFC53ZnAsW7uU+A+RqGUWGoyTo?=
 =?us-ascii?Q?g7MTV58EcHx6+vEBmrIr3bVTwHzchnRVQfM41EAWOvl9P0mXkyW+xM3B/N9D?=
 =?us-ascii?Q?Ds5r+Cy+6W5b4y3MW+WHABnDNfBGTfhmDvPN9i/vpEC8iev1NBiswH+RUALM?=
 =?us-ascii?Q?HF4+VVt21gPVsHVgLgMlEJmdk0Ob0PdE7ajM97z5xxhUN8M2HeeXm/gm/tGV?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b70a3b-b0c8-4b30-e5b6-08dcfcb57ae2
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB5782.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 09:45:56.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4beKTGOy3+x8nwS8ZhFKIU6q0TRqFwKyBXSVUPi4bTSP85vNhQon6sxNIMHgbT3g6XRmGk7FD/sKlbvi9gFQ4YVX6s6N88p7jWYRisRvOc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB5764

Unify the column width of the document to comply with specifications.

Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
---
 .../networking/device_drivers/wwan/t7xx.rst     | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/device_drivers/wwan/t7xx.rst b/Documentation/networking/device_drivers/wwan/t7xx.rst
index 4cf777c341cd..e07de7700dfc 100644
--- a/Documentation/networking/device_drivers/wwan/t7xx.rst
+++ b/Documentation/networking/device_drivers/wwan/t7xx.rst
@@ -7,12 +7,13 @@
 ============================================
 t7xx driver for MTK PCIe based T700 5G modem
 ============================================
-The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS platforms
-for data exchange over PCIe interface between Host platform & MediaTek's T700 5G modem.
-The driver exposes an interface conforming to the MBIM protocol [1]. Any front end
-application (e.g. Modem Manager) could easily manage the MBIM interface to enable
-data communication towards WWAN. The driver also provides an interface to interact
-with the MediaTek's modem via AT commands.
+The t7xx driver is a WWAN PCIe host driver developed for linux or Chrome OS
+platforms for data exchange over PCIe interface between Host platform &
+MediaTek's T700 5G modem.
+The driver exposes an interface conforming to the MBIM protocol [1]. Any front
+end application (e.g. Modem Manager) could easily manage the MBIM interface to
+enable data communication towards WWAN. The driver also provides an interface
+to interact with the MediaTek's modem via AT commands.
 
 Basic usage
 ===========
@@ -45,8 +46,8 @@ The driver provides sysfs interfaces to userspace.
 
 t7xx_mode
 ---------
-The sysfs interface provides userspace with access to the device mode, this interface
-supports read and write operations.
+The sysfs interface provides userspace with access to the device mode, this
+interface supports read and write operations.
 
 Device mode:
 
-- 
2.34.1


