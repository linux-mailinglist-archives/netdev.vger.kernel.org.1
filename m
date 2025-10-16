Return-Path: <netdev+bounces-230001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A98BE2F43
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178A7188280D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7276832D7DE;
	Thu, 16 Oct 2025 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ehYAr+U0"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964932C327;
	Thu, 16 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611394; cv=fail; b=AziwIFrWcr6hgNCWHF/TmlRrJwJI4qwgyWQ567ukLDC5Ct6pWGG/XFaaQDJaXFzi4CxOIjnaHDkPXn+4Etjs3cWKGnAhToyoxXp8QidtKVV9REmg750GslNeRjzI0heEIDr3yPq2m5JhIRdOpBcawia7MVY7Qfm6a9QvEXX7QkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611394; c=relaxed/simple;
	bh=hYMYL6MuY+X7NJd8yCjkWb9/dJ5f0/7U4ayWIC9Y9lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdkwsH+v/rp8e1KP0Qtnde/uU1pFUKMEohrCSbdfq+51qP76FJrZhlNJ4Nk8xj/apMkyvNnIsHunyPPClVG0I8cZ8H8uKLj6y8S2Wrm/7lEN5rhP3EaFoxUUl+0dBk9z/jstxhz8X+kqDfa6r4HWYl56wwvxKc2kS87tq2C2G8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ehYAr+U0; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pU8LbJwGjUXPfAiGTDAT1A7eNtTFGNy5BwTMRsr9OgoDVL3yg007OMAeBFrFXY28z4GNEJvvXezJNg5AmUsjGnybfGcp5HXIZjWBhhDCqZ2sDGCvnqpSFRNpr7ZIXNeCWny5khvNK3CgAiEr9AiOtix9XlYRXQZgdU1pbeDVnxOkYMom2t8sb7rhVSjmhnUoZrX9q/YaxrKtMqPHkiocLLyuIHj2BZyXpUeVrOnHNuLfgwPK5plEuCHDup4LfHt9RrSv7uoP/ImeuwK+nc2NXIJZLZG2OprsK6sivaZ8IPnT5TkjZCybLSw49E3fKhxNlbv53tD+G1jN/d+5ss00gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YogAyEJCFjX6UzSnxyNH/ZAwjmbE7+fBhW/tAeoN2bg=;
 b=mq9PoYtbktrrdsIS19s32CblunRmO6keMHQI9w/hqJzGfiBjpSqJZrUfUPP9+Ocs6HlVhoXpxN3r3FrEl9EGsMMwJMiumF/ZtvHmIKl5iFFgRm2Oiin1BYslLmMO+uen/r7u/9r1agPftj8kHU7glZ/omPJ9loGC4vI0E+fu6TAUSrm7i1ALOr2s1EeMjHg3onLasjnAX/FuYG9/7NcIN460lvAVIRQrXrqNcxy2dnHwnxKUNYRdC4afNHrULVZnupO9A42N0G/1sRDPAWzKXsThTnsRRM3Atab9wpfvGtKY/jXXqo1Y76BVdyggIrzIO6TdzxPry/8QO2ptoCoDZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YogAyEJCFjX6UzSnxyNH/ZAwjmbE7+fBhW/tAeoN2bg=;
 b=ehYAr+U0+eKezvvcNNedugYWq88ahOIU5bCbM6BBqbcwIyPScHGHUgrm2/nvDpbo4nmNZxFqQRl40VJMqTTSa9BYjZ+CHe1At7ylw2ZuXzD4ohaor0c+/pRValFHkczyhpwyfAZkq9IF8nep0BCFUaoeEhNmhPNVYcr5F/ZLtshwULK5J+08HjQunz8WORrHcOMR0XUHdGQMIejUq+6aGAfKIVb8pvlGqd29b+mPQyLZ3OzAPTaVXWDUejXKTho51wK+qNRc16ph8zYZYAxNqK1X31y5vUwCUMHFgK5OR1CvIb2Jpaa1wUtm/vkQPAjBeEoBYclJxKtkFBCuBHasXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB9096.eurprd04.prod.outlook.com (2603:10a6:20b:447::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 10:43:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 10:43:07 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 3/8] dt-bindings: net: ethernet-controller: remove the enum values of speed
Date: Thu, 16 Oct 2025 18:20:14 +0800
Message-Id: <20251016102020.3218579-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251016102020.3218579-1-wei.fang@nxp.com>
References: <20251016102020.3218579-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 95727cec-62eb-4ba2-cf2f-08de0ca0cad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|19092799006|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYmcgjVyGn3Jj/aVreZReQbb5yoeU4L8r3GKBM9EAAz61MhiFMOj3u92jJ+X?=
 =?us-ascii?Q?wKDCnaH2i8C3e/WkF960ryqjjeXtDqbrEkj6hlijxY0/bqkqHogoS7CZMWSI?=
 =?us-ascii?Q?9lvLnbdyzDor1YGjYVztdTGTWEeBmVq/sRIAYX5Q+9uPjqYTsJgTMd1X11HI?=
 =?us-ascii?Q?VzA/HxwIzMgoQfxo8Csrf/7ctqGf/AbJ6zhjmkRvgi3iHysTL1Pw2Hckh4EH?=
 =?us-ascii?Q?TBH7wqXkvREHS1a1Wdx6+msiEzTT53WmY1S53fHDZ24uZ4osAThTYoYtrdGe?=
 =?us-ascii?Q?N4lS803krHoIWfEiKDc5axJ1lo/DIu56gupTfCi3QEpMtcKa9EwMCc+U5ejm?=
 =?us-ascii?Q?99pbEdVX6s+TDXBFakaP+jk2n/3miCOUHTX5zfqS6BJKvWJYKE/S9DzCrBFC?=
 =?us-ascii?Q?+rl4yNdz9xHM+PhbsjZPxBhib4WwcDL1nPIHRK6QIUjyKCVYFebHbwGra9GR?=
 =?us-ascii?Q?bmhACpr4TyvPNOWvI53fFzVbf5Z4MnubwiLgKh5HB0FNddo5Su/uaUUd6SN7?=
 =?us-ascii?Q?4Zqn7RcfzdmDCVYO548nOVYwue8vRehZ9NnTlqPImkP9/FEl1kNBDEliHIAV?=
 =?us-ascii?Q?wEXRMxMjoIVMXvQlY8xt0DhEYvsUhJGit34QOQG7kLZb+wN6e7PicZil1qit?=
 =?us-ascii?Q?p9Pw18cHffAHHkzd5rWHClt63RK3+bLsZyeFSvwayMWSCKsP+lzfXHpXZEb6?=
 =?us-ascii?Q?B0hvvklvsfDDYIBGXXP1nDAY3P/w9AP8A2HOsFBBnEQnIop9R80ANor+0Vma?=
 =?us-ascii?Q?wMCwyb8XQUUvT9hJ/23ddY1m4AagQYw+5JQdDAbMezBhWJ1E3ShWNMdutIjA?=
 =?us-ascii?Q?6wUElFgmUA0mKgq/rsDJKEi6qEQ+n6exEMIR6yRVGfUD3LcUEDkxKVPAJjte?=
 =?us-ascii?Q?PhmvP9rNr6oFsgvXvIL6GxP9+7DRgGzHKQg0JAJV6RZDAqkEbF9NG5b20ipz?=
 =?us-ascii?Q?b78P2r1j79GkONN3uOPTrtJ2rBh5ljwKPkUbi8ad65JTHSplAok2YG0JInHg?=
 =?us-ascii?Q?79H8bUqMDDVhRYzv6cj0npu7Os82ewn5dlm6F/PAZYy8Osv36KNmWkUC+X2c?=
 =?us-ascii?Q?6hcOY2h5U1N+MKbRoOAWa99KkYgsioN7YqQMy+0Ao7uieeveMeVH11W8E1S1?=
 =?us-ascii?Q?dKEii+BxNt/lyNHaj+hWsMZpvlXiCgpD7icI88ruY6dPmYAoSMYpJhD27nmI?=
 =?us-ascii?Q?pLzKxtkDQt7Md5Qd+4SmW+CwVwUOqFmvu0Kd82UFpunfcv8aobyKiY3zWtWF?=
 =?us-ascii?Q?9yrXU4Yx8/oOhbAc0T/FvBhAPgsxuNiia7jhibFEOBdBSy7fS2eOEeKHlO7/?=
 =?us-ascii?Q?wWTHY5vEZMeVRm1yqOEEIKDILpO9JflxtVjCj9J2rZhclRm9J7WTRV6FN4GM?=
 =?us-ascii?Q?9nszggEzD0EzQiX7YzG6mM44uxcKTvOK3TVHoE1egbpz4A9LHz/Qlf832u+R?=
 =?us-ascii?Q?ylI5TPE6My7/o92PgOV67Ijyu0Ba55yq7Fe/j35vOa/o0an9L749hlNAnpAQ?=
 =?us-ascii?Q?j/fB8igw/2cMmv45ZVARHt2fjj/8s3VFKBc7x+xrkwo4kEsoKmFsDK18hw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(19092799006)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CLp+g45TfnhOdF9jK5u5CoA8483M50A/HxnIQXYR0J8JtNfsZ09J8o1BtFI7?=
 =?us-ascii?Q?u87sNRviGoBJMaTRD4SpfyQ95anPcOVHVd/hYfIHQ1KjGbmKI3hYuN7KyteK?=
 =?us-ascii?Q?kf/xhNIp8nam1Y7GfMib5w4iNhcHxfvGbmwvNQYrnpcNOSlbT+YAKsFManVl?=
 =?us-ascii?Q?nMGebfYJEjRHBKv2Zl9QipKJtj9ZAePrlPAv5J93OOCpl50sF1++B3C+jnfy?=
 =?us-ascii?Q?EjHgK/ChQJpJn+4IhjpD4xwVFenwMoNmhSHmwtI0xDPhGj9wfPIX/8x7B0sr?=
 =?us-ascii?Q?CnjGtPsmOGdNvfUTMNzT4BNPFPdjnWTKPk3vLL7SzDNjfeseg9WAgMUJcxBJ?=
 =?us-ascii?Q?ZgCuZLtTIVIAS1vidXn2YNeNRlH0GD/JX3xut6aMuu8xaofX0soPxn1IlkeH?=
 =?us-ascii?Q?y7pYvY76RLHZQB7E4/o+ZMWGAZYj/NJisPkyIGnawDGsOcivY1a8Ut8TlVgB?=
 =?us-ascii?Q?Jjo0upBLUmq6+BrL/AVC+/d4kyOP2Z3kquRUX1lJEnBOdGdDvppWURpYvrjd?=
 =?us-ascii?Q?PQUlgQeTNdp7MKVO1SNENUAalwg1BpWiJw0tsltqYK+uiBy74VDvf8T5RL8F?=
 =?us-ascii?Q?zUwjIxarVpS6mhs/++rThK6Y7A7DuWQFp4286j5Cr0zxGEumHaWOre5SgU4W?=
 =?us-ascii?Q?9SWJ+BSIvUl9TzkynqZ33gvPTXJZnX8F08WvF3ClpkTcTviU8GBDgVKXgQKk?=
 =?us-ascii?Q?Qs5kYsuYQ1rHFZWZ6gW3GmFjkH2APYJSkLzqh33tZ9kHbdeMuQX8wAQoFSlz?=
 =?us-ascii?Q?2uDrZTBuphpGmTTEMiCuM79O8C7/RiyZfnTYAvtVTi5u8LNj7QFFDnra1VLG?=
 =?us-ascii?Q?bUwmKXtcd2dUhSrOBlDXiHJHFVdcTlGfw9NIXG+fm0KfbcsDfKK22cDp+krN?=
 =?us-ascii?Q?fhA1Hy5LVydKXi3REdNH0eRxavqhU61k8BOOckE+feUQOfswykafmx8pBoO7?=
 =?us-ascii?Q?MgPFiBMOSQJDrE/o6uX55mBTSWEuLV+PHhu/4UGDpJr3s7nM0tB55wVPyb6P?=
 =?us-ascii?Q?hQMHnsTTONjo9rG6n34lkmtQ8mLRjOd/uBLI+JweWsiEwF+90bsPL7h+GgL6?=
 =?us-ascii?Q?XEK6H9wjZYKE6yTcLVMJynzXQtxzvnRcNTuwsGsVPB3P6jg77XRnbqdKMS3r?=
 =?us-ascii?Q?r0rOCKb8NlbFLnWpuhYC1aoKeZOYeMgvzkEzmvTBepcgAfofMB0dtBjLVTj2?=
 =?us-ascii?Q?+crrQHdeqonUtGt7s1tWAzBv1V+bCmQUhoi3SuFieVzXJfhojPUHtkyhzQtS?=
 =?us-ascii?Q?KaYcYDDVE3OYDLx369aewNJb4yhLitukLi9do0UTwX5y2KiiLdqyF19l1tWX?=
 =?us-ascii?Q?wPfpp50os0RTghAedRukiEwyJ+osEzaLK5Hlw/5+goqGxFVIRBd+LHVH4G/+?=
 =?us-ascii?Q?XvJ/93rBloPeUNsBn+Dv+0EUL8BuUNOTma/G0+UextUfNcTaMyVZW/OeI6NS?=
 =?us-ascii?Q?0337WzZSKyhfnuu1WCly8DuN122IqWE/MNiYccibeoHs/+90K7Hz1uvJOJH7?=
 =?us-ascii?Q?0/N5YqeMEvKH9ODRhQVlmaydg/YBgYs6BeFGTpqFPfnHpQepIhZ4qQddctnh?=
 =?us-ascii?Q?4zv8D8xIWUhyM1KD5AdD3D/t36NWnrwBJTQbq3Mv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95727cec-62eb-4ba2-cf2f-08de0ca0cad0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 10:43:07.3230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/Vgd1+fokvBFQdQuSOsYSzhvNeDRB7bkadAk+q6+0OI0ECqweadUkzyv2yC887YltSlwkApVP7HIaMdrHQ14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9096

Some fixed-link devices have uncommon link speeds. For example, the CPU
port of NXP NETC switch is connected to an ENETC (Ethernet Controller),
they are fully integrated into the NETC IP and connected through the
'pseudo link'. The link speed varies depending on the NETC version. For
example, the speed of NETC v4.3 is 2680 Mbps, other versions may be 8
Gbps or 12.5 Gbps or other speeds. There is no need and pointless to add
these values to ethernet-controller.yaml. Therefore, remove these enum
values so that when performing dtbs_check, no warnings are reported for
the uncommon values.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 1bafd687dcb1..7fa02d58c208 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -177,7 +177,6 @@ properties:
             description:
               Link speed.
             $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [10, 100, 1000, 2500, 5000, 10000]
 
           full-duplex:
             $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1


