Return-Path: <netdev+bounces-137458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2079A680E
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7851C2208A
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C851F7098;
	Mon, 21 Oct 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="XK3f9ePh"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023138.outbound.protection.outlook.com [40.107.44.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6A1F8EE6;
	Mon, 21 Oct 2024 12:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513212; cv=fail; b=dyXZnR0L5m0o7Y2ESzXalJDOqLcDUseMXi1ChVD/QpIQAOkvuKWHLCaj3pMr5AXms4sR9ne2v+16h1cxIWUYH0ELliLF1Nlo1YaojwCDtoXUtBQkC/LYv+hPyyCinxA2VG2Po1jZCr3OZjFVfAJXNhIc4QsdU5JVgJ0ciNBV0yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513212; c=relaxed/simple;
	bh=4iGeHZ4xFAEd+YPtvQeJvJgE4PUldCHgeBr2PduMYLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r+9hDOSQUlktpfbh/JjuzoTpF63z/oQFhINUpmXdHzX2j7RWkpcnbDGeLGYG7S+FUtK0PppbMJXKvm4CYH8QMfUZl9HIwXYdbp0NK/490jsMlF1iX33vyMONbrsMfGx+SYodmyP/vWLj1SbZTwb5flUus3PlUJWRtTmorcSde1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=XK3f9ePh; arc=fail smtp.client-ip=40.107.44.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahDP7u568XmfkhR98Br7CDnsk7M9JRbhwQ+jTdmtDg10W2fIldmj4rlVJgYTQakdTQE4NARCPigHQ1QxuJ7pf9xgTLBrqBwyNzoP3wXzJlmxlZa7pZT4Q/kN2LSsKPn1rEoH9wOZbleoenEJbUKYjj/6isNP4+P9eDhPDHVw/6bIhJfzdUd07ruAP24YvJpnkaaF18AgJsa0a7x7LsZbAAmeK3rC6ZbX/L+lGlPEdpAz/WZMK2Pl+eVL4JK16v2t8JleJVudHFS8C7/Z7vi7OcPw2KPOn3wLdgPm7NEh6fx9MZRlb/HU+1dxEGDE3ZsK7xe8BvmWmpWNB86HF0934Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGXffHZ85k+1NwpCqPZHM4x00JUjsTeCP7wMz64KX9E=;
 b=ajge8TlZ/XhV9iCqxxGi4zEXicp7x0Juzm9U0F/Fk3uFcmUS5AI7lV7HlEBFNv4U+Lcec70eRgbzKSLOfVDyCSRqauf6vVMUv9Tu9o38+ILyZVu1+2BW/iBo/Y7M1ZdqGdPmgxSKmiWVM+1F41JrYHfBaEIZNVoXsaA4majYjHYx84UnfV5d0A0VAAq9cpfyTau52yDn9ZISd2WsvtaI3WyGD3Uvst2V/FRFWpl641CIzKmr85SlWlifDOa/6sUBhEJeZF0ryBRVwURk6Keaithoc5XKgZ/b4HgULVHE4l/RLK6tnJql/etrbjOM5ldjZaMUZ7uU92gaKmwbQ3KDMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGXffHZ85k+1NwpCqPZHM4x00JUjsTeCP7wMz64KX9E=;
 b=XK3f9ePhnk1oNHvSEhpjXfsYQQUs/kj+ZoMeRoJpfhX1JM8EsThuCbU7VvyBVBhzRUca0CLcE97pV0lgMAs6zWnoCyRAM1KKff+BM58BHjNzY/ojJqTEcZeamSP+SVKs4gm9GkBrHYpHcsKTs+lI3H/8s7D0YKoSkf6y1PxW+ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com (2603:1096:400:1b5::6)
 by SEYPR02MB6268.apcprd02.prod.outlook.com (2603:1096:101:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 12:20:06 +0000
Received: from TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b]) by TY0PR02MB5766.apcprd02.prod.outlook.com
 ([fe80::f53d:47b:3b04:9a8b%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:20:06 +0000
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
	Jinjian Song <songjinjian@hotmail.com>,
	Jinjian Song <jinjian.song@fibocom.com>
Subject: [net-next,RESEND v6 2/2] net: wwan: t7xx: Add debug port
Date: Mon, 21 Oct 2024 20:19:34 +0800
Message-Id: <20241021121934.16317-3-jinjian.song@fibocom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021121934.16317-1-jinjian.song@fibocom.com>
References: <20241021121934.16317-1-jinjian.song@fibocom.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To TY0PR02MB5766.apcprd02.prod.outlook.com
 (2603:1096:400:1b5::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY0PR02MB5766:EE_|SEYPR02MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: b173c1dd-1eb7-4c42-ce23-08dcf1cab277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zLnCYAnxxmk72i4z+kth1EZUQNGykOSD5D2bm8RBXLa4vlo0UXPcWBZ5g8D8?=
 =?us-ascii?Q?iSdCKhtfSi3ogrsNfxdv+pWKTYvQNw11SLfdV32GEDS7tVp7anWPlDfPNrek?=
 =?us-ascii?Q?T97yGS/+UBGL0HpY6G2qMNCnkrx9gIdZweshICg2OBta/xx7fX0vWY1KBdj1?=
 =?us-ascii?Q?ZwnWytecaRl+CZF6xOXguD894wlcKfyHdEqWbziOHLj5LcaGcSqzlMzObg7M?=
 =?us-ascii?Q?V2rrbf52YGBec+lq6/zMbboQAOEmGN7PrSmyVnzwDBPR4sImc5Qw4Qx3G7CC?=
 =?us-ascii?Q?kGYBYNimcd+mBlkHaatJPtrDKvJeGB79dKGXShl9mJxo+7nOCUegGc4fBrp9?=
 =?us-ascii?Q?Dzf2HyGmR/VDIDwS6RNh3bV8kFE0RePONAVpw0LGE1s4Eqqc7ig+dajX7CcA?=
 =?us-ascii?Q?RhvtgGrNLNBPDft/ygaxpBz97QYxoPcqmO0jCfmObs/YIzVH7XD02ypR0wwx?=
 =?us-ascii?Q?dtfrh6ns7XxG0ntJYfrlcR+P1b6XM715i8cPnmAcZb9ys5o3bceJ0NSusBrk?=
 =?us-ascii?Q?WThV0Ane9r+Sfpx0q+YT2qWw4Tw9bQ4QJB3u5s27S9TUCoNmrJMv1gitfCG8?=
 =?us-ascii?Q?sgjLt+iEjY/uQ29jo4ciWMsaAWNbc3JrSyiDC73Bf/wedruk6JsatVfidkTE?=
 =?us-ascii?Q?DpSpEB//rh6v+CWntnSdFpsg5mv/ZP/4cPVpJgulQVKO0chyM7jPf3dTeK2X?=
 =?us-ascii?Q?4nSAl4r0pZaTEXsyuAOvvVppmqtO1K1ZH45d/lbt2DAvJwAp+TmJ5n2JfRxs?=
 =?us-ascii?Q?tESPQJ8kmqosJyUZs9hVsbN5GYoivbixUycuty+jgJWbigr2exlaQ5cxkh9l?=
 =?us-ascii?Q?5xPpSh8C3rCIZqVz982FNbxRwm0MnThBjUp/b7+YAxXXqSM+eHm9LG/bVYGx?=
 =?us-ascii?Q?t4vWe37pKVoMEXaO6mLAfl77TmnUsog65eyuFu5U1qgrfuC5YaWPLC/kwf8x?=
 =?us-ascii?Q?JKS7XTZg4r/6ycWcqUwhKUFlV9SpvxKsvAJz1Nm2QbTcrSQ7uwxm/Ijv0RAB?=
 =?us-ascii?Q?QcIkk3cOh9LwdxCDE/W8BPqJJz8Qd1HEPuf9nBocRkf3p9wUVKtOMdqSEfsZ?=
 =?us-ascii?Q?bh/CMOQQXz4aXyrGUW//BwcNSKJCov4RwhPma8AVOOwMiijqAFXz9K7c0IMM?=
 =?us-ascii?Q?pIlnubB/Rs3X/IFRSh7OMXkzzsBe+hhyWc31IVys3q9zMDDwuBo8QYgkFXY5?=
 =?us-ascii?Q?Gn/0LsEU6e4sc8++c1q/ukSu42acGPUcc08JAweY3rAUAzc7aP0Xxqb8cMTz?=
 =?us-ascii?Q?8nw4W5sZTZLQZ+jIzMV6rDgbIEIbZa7C/KRRbcu67KZJuxfncV0f+AQzPYFB?=
 =?us-ascii?Q?17ox5g0QdAoa/dgSdvPRIon/5IajWvqP6k1elo616fCogg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR02MB5766.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eReUs5RKpDOGfKh5M29NllIMq+O8mMzPLnN0SHkbH+v00y2YMcKqrsWUIm0L?=
 =?us-ascii?Q?UgLfiXoYKjZN/C/d03T7xuMlyVZq++h+UyxfMCQyf7H+F2iLb40Itlj/e2Dl?=
 =?us-ascii?Q?ORFjnHCXyrYrHaXGr5x8GyRulLLo/gUQ4tXuM+u3yCOIJ6KOrmOOfEbmrcZT?=
 =?us-ascii?Q?GRjsnY5bHG2gOVmtxZdDB5PDh2WH5FaekAOoJJWSFUE+1FNQA6mar4HgEQs1?=
 =?us-ascii?Q?otK4tHuDDbwAJ5aP758a3Ao7nimv2l2TTz8VyhP+deR0CYmop5/SCsHLB0Gp?=
 =?us-ascii?Q?/Ly8bldfqzWvY95QlJ5a6NuibNi29wWkrpcaEFnkIX7CwFxLwjhFNbDqYMb/?=
 =?us-ascii?Q?Z0xvbr8SRMxAupV9FM2krQfnSf26rKfRdEorGGBYQ6Vsx7+vCyRse15eLirm?=
 =?us-ascii?Q?dvLBfu+u5GJ3uuczveLv8yHq1mWv4SwdIyYRPGeI+F0nIwefd5STcDNDimhk?=
 =?us-ascii?Q?vxDzdRciFgm28S+A6lsASN0wqmiJIG5lFgFUPQJEJrPxAm21ZH6xFi5YV7S+?=
 =?us-ascii?Q?p+4eNi7/JZWAsFLAyEdZeJDLR4Jc60/3k4rZDhZzlSvS/6OcBRFqNDZFYFoK?=
 =?us-ascii?Q?1IWmZOfpbBBrUp23/3/pXi9xH9crqS3zfxZ/Qr1HKuEPG07B6rgpQPsxINSp?=
 =?us-ascii?Q?TWgzItLnKPB8tbzcc+J683xQKztL7InZrsy9GzexkbpTf4GFnw0JACLD36Ps?=
 =?us-ascii?Q?yfuT397kzM6ae1f0tfc0wKPbJXkXCuPHptFHhQ3PFK2QFST8a7Nmgrto+2iX?=
 =?us-ascii?Q?nCPc6UJow8FX3vuLgw7tMnzLVZ6zDzKae1VV660WUBWRKpUZ715a5Y/uUfUt?=
 =?us-ascii?Q?4Fuy6lPPTusUYvZ3u/5dvtc+T7FC5XW7GcADfVEPzRnenVGwv909zu6QH2Uz?=
 =?us-ascii?Q?LTdmyKb0zkKT4ciKCz+scPZRON3RTQK6Vk4mxqQhx8OO6VKC9v9FjsJeVNJn?=
 =?us-ascii?Q?Nirmd6WPlc1DHNsnn1JSWSniP9QTY2f/rmMcE1il5IjfC36ZWqRlL0A4tq0b?=
 =?us-ascii?Q?rJoi5Oa1MMb9SfDHsVLEPf4qgeZ2F+d1FUeZwawdLuSyi8LZlXNBF2SO0qt8?=
 =?us-ascii?Q?gFeH/N9mBZHrilItqCbUBrEbAVRkbfoX3XFfRTSRa2rJpsSLIuoqcsyFk6dh?=
 =?us-ascii?Q?BDTSQ+RG4riCcaKawIv2wIpQiFBL9ex0JElseJgvtvF+8+wb8fZH3gJVWud4?=
 =?us-ascii?Q?KNdDhZf/R3EiQ0y5941dq2hsPoShjf5dUk31T7jD6JLSvIwitUzJ5wTGJuKq?=
 =?us-ascii?Q?j8XUmU703J11pF00bOv2mf4Sq81HINTMxXg9SjT73dBIfF6S+oVMBaghmPG2?=
 =?us-ascii?Q?zZeclm+m6ZLaQlnp4ZDLZNhUTVd+eXFrw6pqm3v3y0+Uxl8yr35WE2f52BFh?=
 =?us-ascii?Q?f/bZvVa9dpLiwYZ4JfzVQDqo3/8H5rGUT2wcKnyMJEZ/ttqUVLxsQJDQF/Jc?=
 =?us-ascii?Q?qke15yfuuFrILfQ3c7ubRscJeCWI6KEWnyLqvjW/Ey3I43EJdU2BXfFIFeCE?=
 =?us-ascii?Q?TC0PoT7L917a4CL31moExVl0lcw+4a1YV6YxO207xq/+i0Ot289wJiMBoBvM?=
 =?us-ascii?Q?Nh79cADex30uhdq/jonLpZs7KWo/ygBJdyy+RpIXqNsqeJzw/hNFSGPggQOe?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b173c1dd-1eb7-4c42-ce23-08dcf1cab277
X-MS-Exchange-CrossTenant-AuthSource: TY0PR02MB5766.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 12:20:06.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwb/wFkMiQumiv4E6rtJWikvtIR68Y3QxOu6c7KIY112aY1BhF1c0bGJht82aV9eo/aNOgbQpRmaZVmcnFdlWhsJEa9vKd2t4J2z0KSqLqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6268

From: Jinjian Song <songjinjian@hotmail.com>

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
index 625f5679c3b0..f1abdfaa6418 100644
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
@@ -120,13 +127,61 @@ static ssize_t t7xx_mode_show(struct device *dev,
 
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
@@ -840,7 +895,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	t7xx_pcie_mac_interrupts_dis(t7xx_dev);
 
 	ret = sysfs_create_group(&t7xx_dev->pdev->dev.kobj,
-				 &t7xx_mode_attribute_group);
+				 &t7xx_attribute_group);
 	if (ret)
 		goto err_md_exit;
 
@@ -856,7 +911,7 @@ static int t7xx_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_remove_group:
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 
 err_md_exit:
 	t7xx_md_exit(t7xx_dev);
@@ -871,7 +926,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 	t7xx_dev = pci_get_drvdata(pdev);
 
 	sysfs_remove_group(&t7xx_dev->pdev->dev.kobj,
-			   &t7xx_mode_attribute_group);
+			   &t7xx_attribute_group);
 	t7xx_md_exit(t7xx_dev);
 
 	for (i = 0; i < EXT_INT_NUM; i++) {
diff --git a/drivers/net/wwan/t7xx/t7xx_pci.h b/drivers/net/wwan/t7xx/t7xx_pci.h
index cd8ea17c2644..1d632405c89b 100644
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
index 35743e7de0c3..26d3f57732cc 100644
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


