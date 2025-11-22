Return-Path: <netdev+bounces-241010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C143C7D67B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 20:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11733A9A8F
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681132D6E5A;
	Sat, 22 Nov 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SmjI+lni"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD12D4B6D;
	Sat, 22 Nov 2025 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763840057; cv=fail; b=ZcJs48empdJJmVfqFJoq/ZZvHrMoTZH/fNn0vl1I4L9YJ2AQq2mQuC94t+6VFwf4vmUUN49hr72EQYhMxLn5K6JY6vcC6jE5wqJpYBXARTEdtJ0JaBmcm2RYHe8A32XviJ2xc9svpP13slJp1lEdU1hBt3d6GPpbJY0/7S9g8Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763840057; c=relaxed/simple;
	bh=CNBdbhDbu8S3IMGyq0aRjfUAI73IvZKf2hw35NgncQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GMz2ph0F9sOENQevVmAoMsfuIk7G0dlgCdIm22vq9h0yYv+HrjT2647eu+VY/cxVoZU1bJ7EjixeNkpNIc4EBsqz9085QupaiPmaI/G5Bp5ZInlUjHI39UG0QWqInQnZN1g/SMJxQjIS6YC+6xKjnZzkuk0lEOkUSL6HkgknUGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SmjI+lni; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqeaFLz2nihhs81CXyz0BB+hEisCWfvewbxlL63ZYWemmoqwie3ZKafZdx/bAVANvKTAoIICebwRtFUmpvZ1dbEphu4OnFvzC3yhQM4k7KVTFVUHrG9tFpcEXY5RI4FQJXUW2NGiphMv7Ps2spbFFGcGeM9/nQXodKKiZ8K9oWYS2EpEFp2msr/KFDiUkidA112QSztWYQ0O/l2BVTZZ4RZ5KvuCQGpm0vLSXS1QxO1gBK0UPgyEmn8crT/ZD9kV5OSDykwv4AM6OrjkvwhQYaaaLVzn5alTW/OPsoFgPPXS54rYIFk+KrvewAuwTGOsroaNMzxIL7u5cfKFBAxaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+suvX9L9ykqEocC+DDpA9Po6Ervo4BQo7MoybH/oOY=;
 b=JuvaC0NQqhI3Li3/iLoiW0HrptGxH8NTJpeKR3btMAWkQDmQZxhsxz9KMDeQbCU6BfTkapDKd99xS1wIE9NH+/HPkVuXE3oOA/sYim1cOYufFMFkDF+fXX9zJOXG4ujJrdCMpcLik/KerF9j2V4g5oBnnNPQ57JW0OF6+OoXJ6BnvXNUg8J7360IJf5iRCczUhX+u9pBntBGf6QHLYmVnCB03HeYKmexpXaC3rWLdBAXBu7RJDDl28jB1W2H67s2Fa7CRhHpbJF6t78NHHZuuH422WAwaYaWvp1v50wl0bL3kwkRKGov/4TPnjgofYxibQG67PUKbdIIX2QsFnGBJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+suvX9L9ykqEocC+DDpA9Po6Ervo4BQo7MoybH/oOY=;
 b=SmjI+lniczPGZNWmSha13SaSwxn9CbeOmktcdZOGFg2FdBon40sAryIgRIdysRymCMzlbBAJmsWrRNNm3nL65+zMmOvxEaAyDp0fNgolcNi7YGHJblDgqtVJve7VwGHp9EF2xmbVdPEZ3oFfYpn8BYeSln8PMTJOxfBDNW777tvk1ZE+qjTi+2aweZzI18LIDh1AkT8ARhTfvJEg8HCX73H6ZUiuZvsUfsBtuv4cNMjlpKuLW+WFrnk2JyJIcud+OZcwbWKE6RdFiJKxDBTPkGEkoE3RY5d8bdSiBNN60YRtFm3SPMGtnJNj2sahft0QOzhYLHqB5ppzH55Xy0lUGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 19:34:06 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9343.011; Sat, 22 Nov 2025
 19:34:06 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH net-next 6/9] net: pcs: xpcs: promote SJA1105 TX polarity inversion to core
Date: Sat, 22 Nov 2025 21:33:38 +0200
Message-Id: <20251122193341.332324-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122193341.332324-1-vladimir.oltean@nxp.com>
References: <20251122193341.332324-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AS8PR04MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: 65babb9e-f791-434c-8548-08de29fe19f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|10070799003|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MWuPb+a1l9xlCZo2DaIb2T8co2/couUS+/xXV8GKP/bMKwVWlV6yAFtK6K/n?=
 =?us-ascii?Q?T+9uUQERzl8l/qwmjfy+QLrrVFVJDAOGX8EUihjlSzcUPBRLbwMYnUQNs1BE?=
 =?us-ascii?Q?FrJP4bUoDWoMYB2pehj39bDMuFbTCEYPTN1AmjJCUvkfTTkp8R1WRdv+ezI1?=
 =?us-ascii?Q?ssHY+6ddAQqPXaarHCBruDz9IxX63T788l5jSY4yPBJYCC78gS5X7mYrciWX?=
 =?us-ascii?Q?0CoytQ/COlBq/88TjlLuhwTfHUg0u/imZnwqUeiy+WLvGRegDvMrQaKuk3Ks?=
 =?us-ascii?Q?wsYsAean09cj1uHA4uQDs3pCs5zMD5B0Dedak1XmzLLy7sSEbUM+EXnSJYLX?=
 =?us-ascii?Q?bFXl6E8mhzFaadcFRApy23ugDrFZ3H0hxhACQevL3C/Q+BbwYBrzvwGysLLx?=
 =?us-ascii?Q?D68PZz6MMN9sbW+ekh4IS7tjmQ9BdPhRiVwXrRq3Bmc7hNfz9t6jJcZUnGFw?=
 =?us-ascii?Q?x/urZIGqZb/oSq9JYQyOw6XOQ8/BNUfXF8ZVUMaqT4j5BxX1QMR//55ogg8a?=
 =?us-ascii?Q?B60Ulg9CCmqii4ldaBp419vrZVSK5If2t/4gPtaTNlMk0vIZcxO4FiMfCtU5?=
 =?us-ascii?Q?TPAr3vWmCX4Ia5nr8Kt4sepXE3l5sM9yH25QVOGVys9UiR1n2BzQS4QkgZZU?=
 =?us-ascii?Q?cJBodbXQApms3iZ6OWT0xFIDwv3eKPhQHiOOAnD241LRcmVcQf1xAaxMDgtm?=
 =?us-ascii?Q?HhFPUss4GezJDbK6soZyjoGJBmZMPoyfcrSE9QAt2tklgXTJ2jMlayrk/rp9?=
 =?us-ascii?Q?zoiasp6i/swJOqYYDMhFCG0HLVEF/S+4V9s0DlmrGf7a37FPYHOphTN65Utw?=
 =?us-ascii?Q?ZFlQW0G/xschMd2owtExV+2WSt9UO0v+Gdcv0yXE8bUZbXzp6jBK52T+O/pP?=
 =?us-ascii?Q?+ld7n8VQPH3AXm5nyNU596wFHxieixp9Bv9dnenyx2AGI4HlfRCjbWkPlJFb?=
 =?us-ascii?Q?ANRXZvSnoeroj0JKyLT3ZeuAOOdUgbpl3yQ9nsCbKcUVbK3P6uxX/syAPIpk?=
 =?us-ascii?Q?a+22NXvGY10PF75jl3ltfRyFh3b4BmUQxGQ71t5Ftp26mY8s/NjpuIeT/zi8?=
 =?us-ascii?Q?nBjdG4IiyiBkiZd61Q0DVkc+9TqbjBnJ98MPBgXdhzWWYOI4PRiQa4QB5hJs?=
 =?us-ascii?Q?1U2ZTulLt2x+yYqfYOsLD2vdUMBO+VyDMIf+D6vBb4QEYtVFcFbmfEA1er8Z?=
 =?us-ascii?Q?f9haiZ8jFt6ExznGBLu72fv5TyWf6kohOjcTQEd3idBTFGSegO6QoqxIpZgs?=
 =?us-ascii?Q?ZS8k4S8QlXXP7DpJkgioJmep21I32nt1GH/TSUjadv/QVxHzdhg9yIwD+bO+?=
 =?us-ascii?Q?lDSeQyjpFS0He9qNSp4fItwu08pqV6+wyNLoopfHU1WRHCcG0dTZw+RKG0mL?=
 =?us-ascii?Q?66QYAA4GkgYAV6qlvloiv2KWyU+v2NAne0SInLkF5eqnrNt76MIUWXy39dS+?=
 =?us-ascii?Q?nrKnmkn5DC0nI5tSjy4sU7bcaB7GXzF/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(10070799003)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rCSIfhnesH5T9qNEWCO3Ol4E2Y/VjuZA4k/m1S60QNbydCJ31w/LRRrxZ7Ci?=
 =?us-ascii?Q?SMmnUe3RvYUrhazNv4Y/uKy71NtCn7fNlF1n6d6n20oNo9VVCe7xA7Wb2v/O?=
 =?us-ascii?Q?UFF5KPWy6Ic1IHf7yMOZPg5Uug9sE5GJknjv47xRkACICgl7tQV97uxx0vxM?=
 =?us-ascii?Q?fu+LF02YSAadfKM69wJsWZ4f8aeJHjCRRIe+OLhBhvlHq3YetXKk5U9+F5k3?=
 =?us-ascii?Q?4JT+Eynn7I4NsHS69/QXbvHu822sV0VJuyDdFGIEI/w2QmdzRt3e61wId3u1?=
 =?us-ascii?Q?kU1AXgYvB/OWB4JF+u8Z0NlfC4+Yiws+dNazR1qOGeqtS5RbS0JeowrA+e85?=
 =?us-ascii?Q?xLR73sFHOqgrCuVQfyRR7aZh9dG9IiCAh8YuRO5BwxoTOFpAKiBhjQzXjbMp?=
 =?us-ascii?Q?2AaTn3Qfh98r02DwfxX9+2djrSSb+iFGrw0Q4iaUFw+c/5tGVDtflPLCM6dI?=
 =?us-ascii?Q?sQu9md+Z5BWqEqDp1oYHXvyzbEUDNBSFu4gvkIq5fFFrT9cDGdINsk+2Ya4u?=
 =?us-ascii?Q?i0VPXDQZrV5Y3GS2HU2sysZ/Ds5WDY2XFtlPHffyqnDPNWkRfmm+xeMeesQx?=
 =?us-ascii?Q?yo3hIoQALGTOM3C5DL65++Ill+IYkXPj+NIdkhdDJEwYMbtNBc+sMo30aie/?=
 =?us-ascii?Q?FnF/LRXH8oN4Mn2jfg9Oz0FzeszBvVMY1lE7R+8sz5vk9yCSt9z8nkByX0Fj?=
 =?us-ascii?Q?CwYCjbjjSDFLpsX/0vO091YfLI4YHHxX/oNm4ntZrV34gvfov80fkUTWX8ta?=
 =?us-ascii?Q?9+Hwag7ZU2Pxj9lqfjd1IgvnKM6U78HDhAeZZ6k1DRwJ/I2ZEZTqaXp8YMCP?=
 =?us-ascii?Q?WpHemNLINkaZpPJeiCb2vUlDYBabv8LegOZ31iZn0HX3IbvWr68ickXcIZGq?=
 =?us-ascii?Q?Pj8JpuZCAHo8XIErFr8lRf0Ub4cpGrO5jSMbWJVX4YU7TBdh2/mAKmjIT/J+?=
 =?us-ascii?Q?TStXyf/jnqXT3PLozo+xhEa93JSZlhvwhh+t0ZSt9PpJIcPykSsw2uJCQvXg?=
 =?us-ascii?Q?2qpIDXErTLxfBBbcimnO67KZ2vLhVtm1VcluZH9KEhiE2ZypwZn9Os+IjP8v?=
 =?us-ascii?Q?QI5PTp3q4qGkrXfTzySK3XRjloLBafQVi4Gn2FaU+t2/BZg3BTQiIRBRODNE?=
 =?us-ascii?Q?5tDMscDJTea7OiG8a0XnSa9l5fm0/T0PqtSKVOCnZEqbCQCaL4aXuwBfQyMc?=
 =?us-ascii?Q?IZIU6RKU/xVbCdXQT6zPNe+cBA22V6SvKcxu2iQOVIxiCATaXKP02MvE9d0E?=
 =?us-ascii?Q?utremIsiWFbeFBJedu3Pmq1OoWEYR7Os9FTf0hYA2K84kx3dsjqAdSP2UqA7?=
 =?us-ascii?Q?qo0u33KAKoPuZH6a1Hzh07KVnxz98ODF+feA2eoKco0FWSa71UvLodQcusKh?=
 =?us-ascii?Q?UgzygtUOp1TyYTpNqLQFbVSbjJS8QVoTSZbMrG2jCIgiANmD2ckNXbo9ShFk?=
 =?us-ascii?Q?Fzq0gBpshZ0Fqr+cFPm50NgNyyncSOqmA7rJ3tYm4OtXuK7obe3vqvCKSYEQ?=
 =?us-ascii?Q?xrwbVFH+IyDDtBPM3thlzO84n176fY7wol2y6OPbGcVOvD/h3rveVcj3JnKG?=
 =?us-ascii?Q?UUnUCvseSawgmQ2cUgOYrYt53D2Vq3Xbi6wJoonEdiZOqTHJrRdn2dFM5CqC?=
 =?us-ascii?Q?4fx/Q+MyoHd2fPaGg/XbO9k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65babb9e-f791-434c-8548-08de29fe19f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 19:34:06.8465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHWK1jXGeuu0Y7EZUNGTVN3P1gNdpmEVDncCFtTF1zPCxBnL8EluVEf9EocS8HNN7h6P8/4cllJE8+ZV5ne5NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9510

The SJA1105 'PMA' code is actually PCS code to adapt to a custom PMA as
present in NXP SJA1105, that wants opposite differential lane polarity
in the TX direction, to account for an internal quirk.

We should write to the DW_VR_MII_DIG_CTRL2 PCS register from PCS code,
especially since the XPCS is about to gain more freeform support to
alter the lane polarity in the RX and TX directions.

The compat->pma_config() interface is kept for SJA1110, but is now
wrapped around a xpcs_pma_config() that handles SJA1105 as a quirk
implemented in common code.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/pcs/pcs-xpcs-nxp.c | 11 ----------
 drivers/net/pcs/pcs-xpcs.c     | 37 ++++++++++++++++++++++++++--------
 drivers/net/pcs/pcs-xpcs.h     |  2 +-
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs-nxp.c b/drivers/net/pcs/pcs-xpcs-nxp.c
index e8efe94cf4ec..37708b28a7aa 100644
--- a/drivers/net/pcs/pcs-xpcs-nxp.c
+++ b/drivers/net/pcs/pcs-xpcs-nxp.c
@@ -64,17 +64,6 @@
 /* RX_CDR_CTLE register */
 #define SJA1110_RX_CDR_CTLE		0x8042
 
-/* In NXP SJA1105, the PCS is integrated with a PMA that has the TX lane
- * polarity inverted by default (PLUS is MINUS, MINUS is PLUS). To obtain
- * normal non-inverted behavior, the TX lane polarity must be inverted in the
- * PCS, via the DIGITAL_CONTROL_2 register.
- */
-int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs)
-{
-	return xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2,
-			  DW_VR_MII_DIG_CTRL2_TX_POL_INV);
-}
-
 static int nxp_sja1110_pma_config(struct dw_xpcs *xpcs,
 				  u16 txpll_fbdiv, u16 txpll_refdiv,
 				  u16 rxpll_fbdiv, u16 rxpll_refdiv,
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3d1bd5aac093..670441186cc6 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -808,6 +808,26 @@ static int xpcs_config_2500basex(struct dw_xpcs *xpcs)
 			   BMCR_SPEED1000);
 }
 
+static int xpcs_pma_config(struct dw_xpcs *xpcs, const struct dw_xpcs_compat *compat)
+{
+	int ret;
+
+	if (xpcs->need_opposite_tx_polarity) {
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_DIG_CTRL2,
+				 DW_VR_MII_DIG_CTRL2_TX_POL_INV);
+		if (ret)
+			return ret;
+	}
+
+	if (compat->pma_config) {
+		ret = compat->pma_config(xpcs);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 			  const unsigned long *advertising,
 			  unsigned int neg_mode)
@@ -859,13 +879,7 @@ static int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 		return -EINVAL;
 	}
 
-	if (compat->pma_config) {
-		ret = compat->pma_config(xpcs);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return xpcs_pma_config(xpcs, compat);
 }
 
 static int xpcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
@@ -1341,7 +1355,6 @@ static const struct dw_xpcs_compat nxp_sja1105_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_SGMII,
 		.supported = xpcs_sgmii_features,
 		.an_mode = DW_AN_C37_SGMII,
-		.pma_config = nxp_sja1105_sgmii_pma_config,
 	}, {
 	}
 };
@@ -1500,6 +1513,14 @@ static struct dw_xpcs *xpcs_create(struct mdio_device *mdiodev)
 	else
 		xpcs->need_reset = true;
 
+	/* In NXP SJA1105, the PCS is integrated with a PMA that has the TX
+	 * lane polarity inverted by default (PLUS is MINUS, MINUS is PLUS).
+	 * To obtain normal non-inverted behavior, the TX lane polarity must be
+	 * inverted in the PCS, via the DIGITAL_CONTROL_2 register.
+	 */
+	if (xpcs->desc->compat == nxp_sja1105_xpcs_compat)
+		xpcs->need_opposite_tx_polarity = true;
+
 	return xpcs;
 
 out_clear_clks:
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..2a92e101da1b 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -113,6 +113,7 @@ struct dw_xpcs {
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	bool need_reset;
+	bool need_opposite_tx_polarity;
 	u8 eee_mult_fact;
 };
 
@@ -121,7 +122,6 @@ int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val);
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set);
 int xpcs_read_vpcs(struct dw_xpcs *xpcs, int reg);
 int xpcs_write_vpcs(struct dw_xpcs *xpcs, int reg, u16 val);
-int nxp_sja1105_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_sgmii_pma_config(struct dw_xpcs *xpcs);
 int nxp_sja1110_2500basex_pma_config(struct dw_xpcs *xpcs);
 int txgbe_xpcs_switch_mode(struct dw_xpcs *xpcs, phy_interface_t interface);
-- 
2.34.1


