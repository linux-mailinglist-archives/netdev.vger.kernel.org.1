Return-Path: <netdev+bounces-134085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB2E997D4D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C5FB22152
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCB71B78E7;
	Thu, 10 Oct 2024 06:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j8ty+avO"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013058.outbound.protection.outlook.com [52.101.67.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D681A3BAD;
	Thu, 10 Oct 2024 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542080; cv=fail; b=SYlT+pv9icUg/Ro9h5NBDKcNFgFDqYT4VNO8DlDGXTSWZL/qrAhjyr6GQAyoI9s5pHreU9jg4VPeGegSCa8j7yw7gLI/v5SkRbmFhKhpFq2Dg+ph0QrDydkHsnGS0bi7T2frflkWEbfxm/81ZeZZw0Xd8/v1mkYTS3dhmIZKMYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542080; c=relaxed/simple;
	bh=DFH2U2tcOlWRuXkuhE0ZkIsZiTkJb+ZQSOIA6x1GP7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rulk1VXeyJJ0D+6lEPBeSy46PBtf2LcRlaxeHOQPWEhOVvk7wHTyQJC5G1CPgGujdj2n3JeaoqeDslMI3xjr4UYT8SosMZF/lSbhC2I120Ug5i8qAUzNtf1y1xg3wy729Y2wrUIRJXozpZ2yNSoD1zIkOLAAbnU8Z8uzyrqQ634=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j8ty+avO; arc=fail smtp.client-ip=52.101.67.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDTRTmnudXRWSrmJLDB98TVVgC75d8dpvQtkIKrOQ2wwshxteuChgiXM9SFK7N3kWiK2FiEFX0KhxNfKjtz+3q1n+WaSeeR6OgOy2BLaiD/UbNSzaTxICrJ7LAC37lyzBb9U0aqWNTuUTTtu/imuuQpN3wfc8mEx/VuKWid15FQkhiplPLUO5fgqbsX3+Wtmz22DwFdrPDuRCoFobIOvotyKLHikjDaaJNVQ1h+O67x2YtWpZ3IoWQ3m+7bS5npaNAOb3QwMswzHz85r0YYFUo3F8HC3AM/pk/E7fz2KimQJFiIWKmSfVMWP4zn1uLh3MA1Gk56U1wQrsONvtdT/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDrBoty0lUlmxgxuE87jPcziV4yOASuLFXUfqLmJvA4=;
 b=uLEV+snJs4fkmk51YwcuY/tEFiYVSzZpBiC38p85naagoep8nZMNuvw47sJ2MI9GDZu135gW0fWzOa3vA84EXhe1Iv7yFlQyz0+sXD/lKNc6Oo7jZqK0JOBvoV5HvlkV/YkHBhfe9I6vIZkqQ3iQQ8zzPOM/UhIr6KnP7OSDjtunUH9pQ/a871dKHAw/LBbo2F6iM5Sj/WHb2DaLKLRQHNaoElcHNgsYlpI0rwz7Xt9dxW3oMmg+gCi9Jd/goPfLZcL0juuU7q7rvx0/ekTT3wuC+bVVF+4dsI+Q+Bbjk+HKlCgx89It7R+TZJpxymSzsNL1XTiE3/fTVqpEPSkSJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDrBoty0lUlmxgxuE87jPcziV4yOASuLFXUfqLmJvA4=;
 b=j8ty+avO+oucTdVxhxNAn7jL6r9qtNP96SqyO8DidveDf/rAquVs+wZTKoJ7Suc/pqOc6kdfXoYBGSKL8roOVaTth9jEoyvfRAja4zixeFFWsuVdvu2ZCogbm5bmwyVSbSHNFIIzNIRyrNNfDcR+97an8Bk/JQ1koyBf0UeAXISHkh0QT8aT3Mf0XgXODxzVMIpKLvLJkRv6KnWNhwjxCoSyxuPpOthyurGPagQnxq5uGyCGGN4EoLKT7OarPuIg9gg79p6Jkyw9clhsmWaMUkRuHw/l3Zo6BTjP9FEONAD9iYQcMYCwv3GySv2McL2JANyg331MgJftYqx3VAyLKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8101.eurprd04.prod.outlook.com (2603:10a6:20b:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 06:34:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 06:34:34 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 1/2] dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
Date: Thu, 10 Oct 2024 14:19:43 +0800
Message-Id: <20241010061944.266966-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010061944.266966-1-wei.fang@nxp.com>
References: <20241010061944.266966-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AS8PR04MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 149c16d2-fa45-4ca7-67d7-08dce8f59add
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sBAk6F0DrKiam3/TBS687WcWwP/Ee/ELJmJd9hcTwySxKUcLVtLBld3dNgME?=
 =?us-ascii?Q?e+gcLQOoAULKxiuP6O4nszz1yNdkMqTA50TAJdKOUjHitw5YHFTSrU0g1cfD?=
 =?us-ascii?Q?a/J5kuSfk2xiSKx5bcZMaN6a5iU7m/MQAb9WS+2PO25NEcNu1rlDMVvkybMt?=
 =?us-ascii?Q?LfKOyNwUzB3kvecoAzI6i3p6n0oHe+klLwLHCFW+L2yI37jmGnhXnZoVS8pk?=
 =?us-ascii?Q?b5tGREjIy3QdE24AG3cVrrcENZ1KGti7hSzvMgvotgbouA+Ew1DfTTaJEb0r?=
 =?us-ascii?Q?nmahe8zLfe0SHx05vLS0Yd2werY3ApsCNefZdF3MMACfxoup1wcZEwnl4qLo?=
 =?us-ascii?Q?TnZfwKv+R7gZ0stcRLeC5hjLGMhBtFIXpTvCuNVOXUwJnWtEo0F02w2nmae1?=
 =?us-ascii?Q?5bTPYNkw8/8lDN6SrEpFI5frhYiSfioGdbHTPlq8atqtge4Kmh2dLdxP3hAB?=
 =?us-ascii?Q?0Ug+dt6Nfa2UZhgWwRyXpiChYdenFIJL2jfgPd1QXaAu4EICYxLYiCFYd+m+?=
 =?us-ascii?Q?p3rO+z1oaSLJ/wd7OY9IM07thyu7c5WKRTHi6juXJmoIPgvIe5AIJFGyotBP?=
 =?us-ascii?Q?eGcuip8G2txiNFWif3/a5jp4G2KzdHYXL9jLGs8y5VkyypUUR+dZ0r4F0qdR?=
 =?us-ascii?Q?jBQHvXPdkfvG19LIqTfuqrHTZ2rhft/WbzqQUgQYWvfyRIjZs1qDQTe4cxIH?=
 =?us-ascii?Q?QCOGW9o52auURot4u7pfzSZmjsq2+AedJVjgyKruI0TEG7+WGBonfTcYAd/Q?=
 =?us-ascii?Q?KMuIVnLdaDJYv1HwcLr3p6e2FnD1lTWemFMi96ohB4UmoNm2JR63pQjRpFZu?=
 =?us-ascii?Q?si7H3PFuehknqqd8p+6lPLvMDempBEvbwiMYzt5RJCFVg5rzKEzgBU1L0MiR?=
 =?us-ascii?Q?OEP3Y8BX/mZi4AJJaLEaq83vKlMSJ5X3Um2ibchrdtUOUnImhKpkWctZlhn9?=
 =?us-ascii?Q?0rVY7iHdlwFYX1bIlXWQ81eW63WiipOnYBmHe/QDi+BAgtKCVjax+vn44H2/?=
 =?us-ascii?Q?kgxf+403YGBF42Y/CCadsV5IcgN0DZAD3rv3WU7XZz1ryjEfMZMAgAn9BzpI?=
 =?us-ascii?Q?nDms4GtO0QDF1SbtFBAR9RcBQoaNaSZo9nCqKKk8QAKURJdyOAypCLbOdxEU?=
 =?us-ascii?Q?UR2FndmJ5+XnH+R02etFW6/LrrPojEpPOTTqUAdKmW3FcH26UGvTi6xGbb0X?=
 =?us-ascii?Q?R8hgoGc1OYvwNAwI8VLYeSsBiSt068nQFhH8pkGgceaWyPlufDYn7TLRVanc?=
 =?us-ascii?Q?y1NckNvtknhyndPWhf/+nyMaLPiIGd0428OYFIMSnaSg6aeEruArgKf/jl9q?=
 =?us-ascii?Q?43aJzwXWVtDSq9hs50ZkvetX5AwT8ltg4SZ1W4truQwTvVBQg0nC70hxngjN?=
 =?us-ascii?Q?0jRpuCc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jAOS8Znef548MrrAZXVcSr6EPh2DQ0aipIdWlTTrV5LN+SWFpMkIjDGxh00T?=
 =?us-ascii?Q?4YfmLCqKIe7ktUCS5Ut32PfXKJ9rYpyOPJvG8i5dESKq1tuP5tB5zSqpcYZ3?=
 =?us-ascii?Q?K9j5QShBMo3o+mAs7g5PvWZGvKfAgteg1CpKprStK1z3BfGIkMXbXPLlIp3u?=
 =?us-ascii?Q?gV9LeqByvS2n2Uib9u3RgFf0Tfq+t+UE07FjrZSOA0DrOF4qpppcdH3uijbN?=
 =?us-ascii?Q?j7lFLwBfjtly/QW7ZjT6IgZuMC7REqO2FPRIIEXVMAQ3Q1xcMFvyMl5xnGc4?=
 =?us-ascii?Q?2XyBcX0yHr1C6SmkdzLX0tClBoWKun+wFPrsdkNYGOhSRjVHt5AXLvI3BRv+?=
 =?us-ascii?Q?IpU4QiCE+vdde0SgMtxnXtrDDohoX6U1iByra55Q48RgckdXFB50F5wZWUpK?=
 =?us-ascii?Q?2GjTInq/CeIbN4s+kaUYnRB2cuOhMRvYGm6qMx8jH3SdUaWc+fO01pIbJxik?=
 =?us-ascii?Q?tuV7LcjU/f1x59/BO6xOYfbyyG8aFRiAkK8Xh7lv5E5h7nvpW7hu7KQzzJBm?=
 =?us-ascii?Q?slGDUlq3KezRAuVZx3FCS4JA4EeafY9HsX/GzssPupKqYynRDY4X3uOhOsIK?=
 =?us-ascii?Q?LBE938HRckIDva3v6YGTGd3NDKtYUmv6ofHMmoW/7xBaKmXua7GuY/ZXAr6H?=
 =?us-ascii?Q?HostXiNm/jguOsTX2VMTdLnrxeRUDBWZc6CbcMflbD/oPax6vrKnH3xsUe/r?=
 =?us-ascii?Q?gSS5alpnHTIYFfRs/0+Td55CV3hNVoCBcgcEZc0TRCax/0tZaLEgKeD7djX5?=
 =?us-ascii?Q?MZ/8UOBf2fiIuAe5krye4mVbtwBZhSlBxxoQTm1xUaG5TVI09LBWGTTARGEv?=
 =?us-ascii?Q?2bpI2e9gYjQ2+WW7S3yt9tdCQKzADvt9DVWNM4vF/3iqVWwEX5QIbXU67LEw?=
 =?us-ascii?Q?Qdw2cM/3Be1rG/M1m4tPTk+YkE7UR3B6kLPyBRhkt57z94NAuvj/UyC9LYOh?=
 =?us-ascii?Q?SWkK3YhJ4WTSrjS1MVQ/GAzvaLby27jLZwgEpGv3ifTOy0FFY8MZiUxuUCF9?=
 =?us-ascii?Q?p8wjUXXh5PJElpf9ssjt0xFBCYF7Dz7/udtsw6TSjBW/uhHO4HDJ139kOT7C?=
 =?us-ascii?Q?Xt2EqggF9q+BINCA7HwmOOXN5eWxXpJZucWhA/EcKdHo9FNRTEhYYY3VqFYB?=
 =?us-ascii?Q?d6KlS92tgnU9mMn9ACktuL7Qr02agi+uOdCxLKHauUGdJ+gipBfFBGoWfKHk?=
 =?us-ascii?Q?s+zsvl+AeColKVeCXxx+gvw4JzpBTpeyxrtWnrBpBW0gh65M25pvAQ0NYjBh?=
 =?us-ascii?Q?9NqzICDO92asR7KgQlvBfD1HA7qOs1owfbpkybWDLJAex7i5dBfjP0LN6hAA?=
 =?us-ascii?Q?BoW4DgTz9ntKF/PpQ8sx/uBJJs9OZyf6dMx6k4wto3VVfvzKP0NwwmMgLj4Q?=
 =?us-ascii?Q?Z/LBd6hV8Kwt0HxBmad6+Il4CsXthKNDno4Q6dAZ+SL8GkYxqTZhFnlwRV1q?=
 =?us-ascii?Q?eLmkrpre78+eULxwze5bzRrm3dEQ5Rc3cs70LmSs/6q1MRN09I5o+p5shYsU?=
 =?us-ascii?Q?6CloQe12L6tjYtYq1aAqrdcZC1Lkbxx5Hw2JEs1ofTEic2RFIf3xqCaeqwk7?=
 =?us-ascii?Q?jaHCIUvCiDHv++ImuGKiuyifPcvJrLWSF8+mdgRj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 149c16d2-fa45-4ca7-67d7-08dce8f59add
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 06:34:34.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNwxWOHsHR/UnwnLosMxnAElpkI6sdQfUHpo2UaKBbZCKBHm2EoGP7SqOV5/IPHMzAhYOoWqOixUqJvrxJ+5hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8101

Per the RMII specification, the REF_CLK is sourced from MAC to PHY
or from an external source. But for TJA11xx PHYs, they support to
output a 50MHz RMII reference clock on REF_CLK pin. Previously the
"nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
this property present, REF_CLK is input to the PHY, otherwise it
is output. This seems inappropriate now. Because according to the
RMII specification, the REF_CLK is originally input, so there is
no need to add an additional "nxp,rmii-refclk-in" property to
declare that REF_CLK is input.
Unfortunately, because the "nxp,rmii-refclk-in" property has been
added for a while, and we cannot confirm which DTS use the TJA1100
and TJA1101 PHYs, changing it to switch polarity will cause an ABI
break. But fortunately, this property is only valid for TJA1100 and
TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
invalid because they use the nxp-c45-tja11xx driver, which is a
different driver from TJA1100/TJA1101. Therefore, for PHYs using
nxp-c45-tja11xx driver, add "nxp,rmii-refclk-out" property to
support outputting RMII reference clock on REF_CLK pin.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change the property name from "nxp,reverse-mode" to
"nxp,phy-output-refclk".
2. Simplify the description of the property.
3. Modify the subject and commit message.
V3 changes:
1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
2. Rephrase the commit message and subject.
V4 changes:
1. Change the property name from "nxp,phy-output-refclk" to
"nxp,rmii-refclk-out", which means the opposite of "nxp,rmii-refclk-in".
2. Refactor the patch after fixing the original issue with this YAML.
V5 changes:
1. Reword the description of "nxp,rmii-refclk-out" property.
---
 .../devicetree/bindings/net/nxp,tja11xx.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index a754a61adc2d..5f9f7efff538 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -62,6 +62,22 @@ allOf:
             reference clock output when RMII mode enabled.
             Only supported on TJA1100 and TJA1101.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id001b.b010
+              - ethernet-phy-id001b.b013
+              - ethernet-phy-id001b.b030
+              - ethernet-phy-id001b.b031
+
+    then:
+      properties:
+        nxp,rmii-refclk-out:
+          type: boolean
+          description: Enable 50MHz RMII reference clock output on REF_CLK pin.
+
 patternProperties:
   "^ethernet-phy@[0-9a-f]+$":
     type: object
-- 
2.34.1


