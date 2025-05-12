Return-Path: <netdev+bounces-189644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B9AB2FB6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B8097AB46A
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 06:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7975F2550B9;
	Mon, 12 May 2025 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BeTL1Llv"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC251386B4;
	Mon, 12 May 2025 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747031786; cv=fail; b=MpC5nq2lvopuMjYs2s4B/BBLLRqzC2B+BfgFZ0fFg1lT0F/rOMTRclYhcXbodKj2NBFELfMvQ9f5KQUeWYYnPLw2UVOZNBMuSv1JTY2m2G2f/+3EZSfeXP1ToyQMoG4oLB2+swz0g3u8ZZo5j8Uw2NZ+RO4x8ZRmz0HgkOWAnoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747031786; c=relaxed/simple;
	bh=DejHSR1ab5TlIF35bkmtELgw0RuEGnGRZ2q9fq737nQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mGsysBRkexUDDsZq/MnkfedyonCxu5tZsjglvgCa+V5KTj+Jam/+i4/GnYEUjcuE+se7xnsLfPmpc4b7YOLWutEed2tbWULa0CPZ/nMoSOD4VgFeDPjURiPrlrLdwXlUDQ5zuZKz7mBE4wkGG5bJEbtB6CTaDm7dqo9ufNb6nAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BeTL1Llv; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGoIG0TQ0x32QI8h8BIL11nZy33L23Ipm6HUlZbb/vvaGpY43pgCztBz7fPVKf+sPOxUBEQLV2KmNuT4aJYLJk1fYdmjxBWMSmCmxVwwuc41ONskJ1u4QJuGV6EacrGdDB1Uos0Q0nl5bPjN1yHw97GHWBfeq9adudrkmiBibJMiCFGvvTo6uKHm7K/9WL2sY2AFbHio5i34ImdkqJeFVPZ/TwA049swq6L8obbBekyEDBr/lUANEikcRZJhru9b+X284KnJMDzrIb+WU/0Pmah5NOE91FvW92Md8WSXikBdwATDCe6qtq21n/KorYKCAsTjkDZSGVBMEzeedEDQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enhvxUmEEERJapc553Wrpt+LtZ1kBYdvtrCcaKiGvO0=;
 b=ZbCzXyZ7ju8FzAjzJxr8mfROS4xuPArY++0bLXgWq9gE68mDpjh52tT9/+dJ/Tytw6BY+3t3qOYa9tCsTVjTu017Lyo8ozCcywpeqkonTpTy3ZSXvdmXXpVvLCiQBoneUwQ7SPExdEK3fc9brh215D+OQhZtr/0q8Bd4AMIX9uI7Fpe/gKqRduyJrVCOTMYf/tBL/Qoug0+RnYr2l4SjEA60ObinB/LIoC5VIZCEcodJjHtXjmQX8lfJKuqHWc6C3Bh8IxHMU4Dw0vrT6/Aw0GEvVHIjCqx6lg1fM6VeZyvyOSFAOt6abbB7RaNIDigfIhgRIHSBGXpGOfRT30gW9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enhvxUmEEERJapc553Wrpt+LtZ1kBYdvtrCcaKiGvO0=;
 b=BeTL1Llv26dBWsQjKdvvPiGQuH+C34A+C8ZSc/DksJEjrdvqgouTEYzbnXHR+4hy1MANkUWBX/EtcuCi2xZ04TWWgIiQEtg12Fcr9YQCR7qG5UdIPFanah6Ddj3Al6agvi/sztOFSPmL7yULsHe6nJRsODyNcvU+33ZNqFzWf4RpkMHq3vyEe1r/1loVvz17WFz6baHdZYBa9zxLdfgnSzzO41LFHTPc8DtjFTQ+QcNvbOgztXfD2luFTjNuhPfJQGqM5oXH+4hqaoVaf/y6m7siyHPKkQ8c5+h+4aaixdiWK2cPJ03IXnfb+KEdiiQHJVCKhsQ2LNIg0liGujpANQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 06:36:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 06:36:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next] net: enetc: fix implicit declaration of function FIELD_PREP
Date: Mon, 12 May 2025 14:17:01 +0800
Message-Id: <20250512061701.3545085-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c790a7a-da69-4498-a07e-08dd911f4ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iZaAFykdAv+qtAwSWlWOFvNYHZu9a1WHzaN8DYnudVh2XUx4WXyWPNUxGfHq?=
 =?us-ascii?Q?58TWFlL97GTWT1JIwajcuaGdrtNP6XpsmmdMIc/NwwPKRIMxBRrvLh1x6Ouh?=
 =?us-ascii?Q?4VZ8C8BUDuE5huv5HLL+H6z+p+9HoLwJbtvYF6ly59AuKfxpHUCKD2UyeUAM?=
 =?us-ascii?Q?fF64KjNBo08yWAv8r9RVbK71xQIeld5Nbon1R470g24xTSqQjFfKqDYBnNCt?=
 =?us-ascii?Q?mtfYYX+Tb8yWm+RhelKg4RALckFN/3AVkb2nq+JGrt5guIjZSEOPP9ukK/Cz?=
 =?us-ascii?Q?MQXKP1hp6088wmafIDR4u6qfjbs53uHzV7p4eP+UZK86aX7gE7rWRhah+LC7?=
 =?us-ascii?Q?2N5QT7Lzxpr+QqMTOIYpPB0Z+iHIWzJjXrcAsRZ28F0qLELkFSSwjHCFa/bv?=
 =?us-ascii?Q?dCM9Bvnp6zxtQhpI8bgHqMCIwezVkUDJINfU3Fip24+b2d7bxX+fhAqQzrC7?=
 =?us-ascii?Q?FAvFNigkc2IpV/FtGhcDY0kbJFOajUreTQ0zhn8fM6BxDoGBUizHoxFj/geg?=
 =?us-ascii?Q?sybLArqQRSdbvhrxEz+0tK2P3hkVQQxY23CVXAHLp/ndYJiAPw/1dFO+lqUt?=
 =?us-ascii?Q?vMJMGGzC+ZN3UhhPCbXJOZSxBqq4XamA5Vf7kRGODT1ssYChXTRXBp1izOwl?=
 =?us-ascii?Q?MZjkCkgvZWy90RKBi3G5N3hZbliO+/oRhx5WQhIu0dzmWKjcAqwsISrQruXd?=
 =?us-ascii?Q?oYtqR/ntVWbAjmwW3gOEK29nzdtFysm8JsZNGG1v4ceEH+5VCX0ahXOC5pee?=
 =?us-ascii?Q?tAUQ6f/UW0HP1hShabmmR4Io61kx7iKdbtWgvmeEUjMtU0rDM07h9jHk7z3a?=
 =?us-ascii?Q?AEmI2rLcXaVAAipvCeXqADRlHMON8uhL/QGy8KOw7ozif+INVMHhLxL4HfcT?=
 =?us-ascii?Q?GySyy1YmrVRYLB3SjadFMujWP9n9Y/4gcD2HsIL+Qbbdow3K27VEjj5dK+zr?=
 =?us-ascii?Q?VeJquz9b7y1MW8wQ15/iB18/qqakZLmHuMeRrb7qHezO9j83SDqsgVUxMopG?=
 =?us-ascii?Q?453seWivQaVMsVb7TfS9arscQtwuo8pt7aLH2D/CZu8hte4FaQ2UGJcMqgBj?=
 =?us-ascii?Q?xeOOXTA0IiSyPSoJ3oP9W3r+ZfhIWbOMTmTtvne3MPVaGQAQgv5cI0LXxFkU?=
 =?us-ascii?Q?CG22XdAI4A9YKsjbzABjjhcuSMihgTCKfA8Q5CXFa082uxAC0+a7t+eolB0B?=
 =?us-ascii?Q?+yd9IlJTnGdPQIx/bCoYfgtSZvFu16RQGAhFfuN/bSCFi/LxDAeZSc9yQ4pG?=
 =?us-ascii?Q?TLzA4201TL2mHWv/uptADRxcra0eSDA0I7HrH32dxpCQ4EnchrBjB6V59Tfm?=
 =?us-ascii?Q?dyIzIidOVlyHjjzyKBDGho25VRUnd5bp62us68oOPgfD8YFZMO14xMpINspy?=
 =?us-ascii?Q?6aV7CxqjRQ8LUwyYuInCMMFjZSZCx1X43mum0ABQTJ1/2eZb+uZemF5rH28i?=
 =?us-ascii?Q?IIuUaH2+rL1P3ofIs/EJXV+vxnxYrMQ12mc+THZfpKczEp9wyNDxKDmkKbqs?=
 =?us-ascii?Q?G7Q3pAaoJQp9O4w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lj5Jtx9+s8LNDW1gNmnlpXAP3m67j8/m93sfGIo5AP1KkssawNu+IFYpL2pc?=
 =?us-ascii?Q?QeWGAUDBmJAHeXT5rcgvY69jisG7GUg2vsIw3Ij9T9eUEw37XN80o608BghZ?=
 =?us-ascii?Q?p6Ta/VoBSzQebSsJI1qt2X/leg3Lh2fZ7/z4Gioa86b54Pmjljbu3eVKCEeR?=
 =?us-ascii?Q?ymBXdNoSWfCD7vL6OKEaHnFHkN4mTHwoeQtX4/kSwOoUdV+JYbgHybkDGhjz?=
 =?us-ascii?Q?XkSP7SDkLaW7jVp+kNBfgqgzB4ORYjP5hmVrmcq5ork8YnemK67ERka5m3W3?=
 =?us-ascii?Q?LwEJOeE01yngum/ieyIk1QmVI2gnl5y4IvKmdUCJwxPoEHP5kLc2/+CygpYk?=
 =?us-ascii?Q?6PwiuHirtFGhf/sxXvjTXRj3wH3giCXomNwfjgLV3kBEvPXZBpvaOX9hCUP8?=
 =?us-ascii?Q?YzUGpLDGSYezbJWe0BpktjqE8VLymT9qcAf4mfGccKheqh7FFop9UoavqJxU?=
 =?us-ascii?Q?BSJMEnQ6JmONGstBMOnh+umzhc9KHZAS70FwX4gG6fwFZy86dH/Gby9WORXX?=
 =?us-ascii?Q?C+GYOH/5ZQVGDRrpz6B79162L/AoboltoHZn/TyeQ3O+u/fjoQme7RuuCgNW?=
 =?us-ascii?Q?CvOtnik/UYXv97m5p/YN5vPjpcPzolVsvb9Sz2mcBVhcceTlZz2kJ51UJCir?=
 =?us-ascii?Q?h9jNbxqZicj5Inckh/wl01fX2YJ8VdNeLLy2yx15n9tHYvxswhvNeIfiZ19m?=
 =?us-ascii?Q?subDn0K29A7+3phEX7A+hNFWM1V+ZoRpzEQZ4DG+0/ty+D64NnWlIbq+l4gE?=
 =?us-ascii?Q?+bHaaKXpry1SKqw86RV6lbcPWYFac3YA97jwO7STGtkYtVQnkSHD4vb4x2DK?=
 =?us-ascii?Q?FhENkYBdCCkWROpq3NXbQ3fQOWz0LF7rMvd3R4YKG1iyXXGgwMMHkxmgcHtZ?=
 =?us-ascii?Q?NxZLWIJ18LXPLfmHUBC1xVqjrphyq9yqkucA3f7pq6pzXmf0INwL3TKzRxOa?=
 =?us-ascii?Q?xI6HM9T6XscZHflmp03SOhPXt2z8Y0xeT8r8cGb62wFJQVadabn0hAhJSTwD?=
 =?us-ascii?Q?WwJlVXGt9xiSx7uF5PWf/7saMsUFtZnKPkh0cj6sN/RNfZcPM/30FzlVz28O?=
 =?us-ascii?Q?LQedyTX0G0xvktv3VS2ZdOqCLpCpuOXoEOHjDD+4sWc6/DmW6v8RiXsKqRG/?=
 =?us-ascii?Q?MQ5lWZCHg5V3Lia5vGStGWWaSFFEWKHJSO9nBBB3xbRqaEfyhg1lRXe60wlJ?=
 =?us-ascii?Q?tq/+vJjtRO9PdVUdke/FPntlNiopLfCl23GNTXmKAdQJEHRgAutFpc1jdM7J?=
 =?us-ascii?Q?Tmf1+I67ifMFUyBtwA9tnd6ZWZz/cYtgde0+c74mcP+SZb7YKg6BN1d+4Syw?=
 =?us-ascii?Q?FYMacQgmMWORtSMbe06vBovzmEnwJ4zTYQRFRlVFCh0KbTsWua6D6jiUaKy3?=
 =?us-ascii?Q?ge2LKPlV+5DTsP4zQIlFbGWkmV6U1KBmliiCCCzM13aCs0y7H52wzfEXnRER?=
 =?us-ascii?Q?tegDtO/MVk6971YKFCA/6L73SwUHF2DJY48CRHERzcxcBEOdwFW1kSfUL7t8?=
 =?us-ascii?Q?0hJoILLvcK/p/tBjXZ//V1xXxnFXiomEaIfiSrAifhqQNvy8afPK/eOaHkjn?=
 =?us-ascii?Q?u3S7T01BuhzEav3d2NrmqGGUTqTaPSk29sCokYcR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c790a7a-da69-4498-a07e-08dd911f4ef3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 06:36:21.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avVFFrYiVmGC/RbCyh9qSK5l3mG2QDthXSmQ12TDe25GA/BQeJSCJCdOzP+0h4cua6nZ3197tCJLh0ze5AuLaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201

The kernel test robot reported the following error:

drivers/net/ethernet/freescale/enetc/ntmp.c: In function 'ntmp_fill_request_hdr':
drivers/net/ethernet/freescale/enetc/ntmp.c:203:38: error: implicit
declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
203 |         cbd->req_hdr.access_method = FIELD_PREP(NTMP_ACCESS_METHOD,
    |                                      ^~~~~~~~~~

Therefore, add "bitfield.h" to ntmp_private.h to fix this issue.

Fixes: 4701073c3deb ("net: enetc: add initial netc-lib driver to support NTMP")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202505101047.NTMcerZE-lkp@intel.com/
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/ntmp_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/enetc/ntmp_private.h b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
index 685b388e7ddf..34394e40fddd 100644
--- a/drivers/net/ethernet/freescale/enetc/ntmp_private.h
+++ b/drivers/net/ethernet/freescale/enetc/ntmp_private.h
@@ -7,6 +7,7 @@
 #ifndef __NTMP_PRIVATE_H
 #define __NTMP_PRIVATE_H
 
+#include <linux/bitfield.h>
 #include <linux/fsl/ntmp.h>
 
 #define NTMP_EID_REQ_LEN	8
-- 
2.34.1


