Return-Path: <netdev+bounces-214963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C4BB2C4AE
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74CB524022E
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD6341AD4;
	Tue, 19 Aug 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GJvJIPE0"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3689340D87;
	Tue, 19 Aug 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608436; cv=fail; b=PdnR1f+tgeC/wQhHfWEaYHoxgMu+NCAzrMTgwBPfqYOkiFROwRmi5W2WiYpVaJXFk/HTNfBDfV1PMSbS24y4SD+uveJrRRH64Q5NIwqrVnjOEylm70BgiZIzKv42OwT+wiExooB6XFurSfdpWyAdxr5K6qqG5gMDEMXzZcsaPlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608436; c=relaxed/simple;
	bh=cYS0HXE3B4wJQStICvzXd5lCHjpfNL+pjnnjmMYPBQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eYWO6xrYa3lhBXcfmyqgSY6PnLWuGk7JYxueFPG66tCI3LM9Vbt4CtXXGROzRXE/WRdtnlPSNAnqGOB3xF4+qXo+KTl81X07wSj7XidsaWXZxEs1WN5E7ySFxbWb+Modc6vy+KsrhWu7hfzBfo+r+2ox/AlGpoEVVICs7FZBLFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GJvJIPE0; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=On33biMZZQXeOAqkuaeoo0tp3Zf0NhmYOrpU8MJB9Egdp8ITwfZdat2gwFX1UeRnKgQv4F0Ef4ihx9dPU6b+/v0j7eqbXGiQcbJB3hgIzy+yAL6Acd3xjGDQR31/aegoP3B3tR2xvaYMBfpcpABc526VTLkgOhnP1OxFYz00pLYONGm7cHk8Dnz8+YBkjkMFBPffRtFk3BuFgXY64Bzhs9oqummEko6GyiijLO/ORc4EQPuDhR7Cf8QRp724LY0ovaZygX0WKAy0RLWswVbW3MGQogcAB5yWUBXICgaeDejPtSJ0ULzKUsE7rP6qs6HKHR3G5m+Df8keW+zTmFl+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=j6gxXC6aLsuvitrQKOH8KIobl9bqhFbPAw5f5Zw55YB97PSmlhFViNoB+bLPT69C6hgRXDPrksukdjrdZrhFox6Am8D1lVb2f4We1NnQDsVXYRih/DpCu8HGuluWrzByOT040/N/40FlaKvRj2mZK2GDsvUk2VogG1uFQ8yzx0K72Z6cRz0OZG9vpM9RkUj3AReKenGhb0j//eCta89/Mh9f4ny3Q7MNFoqeHjjSZW22jvD87Vn028DOeISq6898ZjVEks0B6r39fl2oZncCUCwN5Wfv93mTsv4MeubUXDqBpKIeRieQmtsvB+Zfe8pqnWzNcEgLzgvQiw5QVNMB5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUbNOOoRgkXrJ9IQbAo5aU7HeAXkeG4yXtSm9rmzo7I=;
 b=GJvJIPE0Y/vjBrkbuWNqCtjgVewUyazwHhWO9pfVNACCwFurk/w1RierJ6pqRhLnPD0wuSnXw2HlRdbvUA0JPQLqcYVb6DX2E1sLHftqj4MhxOvwS3bQxsxkt5dWreVnqXbR9yJ4ntdWj5IAXjvWYY15D7N1s267QWZh5+82IXOny7CstwAJ0EtYgbTMJW0/YpgNGI26AUMcNASyOhzsVEn1xuSJToadOq7WPI9SMpp8WbnkRSc1lclZ9fBnr8DlSDRIGvolaQhl1Ib4JVnMxOjN+r5HariH/vLMenpD9rKB2Pg9NnxpjOXkNeNp3VEY3eGIgjHDfwvH8r5ZCJal3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8992.eurprd04.prod.outlook.com (2603:10a6:102:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 12:59:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:59:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v4 15/15] arm64: dts: imx95: add standard PCI device compatible string to NETC Timer
Date: Tue, 19 Aug 2025 20:36:20 +0800
Message-Id: <20250819123620.916637-16-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819123620.916637-1-wei.fang@nxp.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8992:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b734fc-340a-4591-e9f4-08dddf204bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tqRXZS5ZA6nwr55g9vatSdDg5OEteE0e8GpE9IDJ8/ZWLvcuU2NQ1vyT5qAp?=
 =?us-ascii?Q?VJOJGBYaDNcbqlhlyRwrjSKb02WiK56BbFm1V6ENTI2mxlO5zPk5eN43SXJ3?=
 =?us-ascii?Q?upmlQpeVmXoCNmlulvG1V8Tc6kXxT2ugSZ/5eEyGKs26qqJstyqyjOaVj3HK?=
 =?us-ascii?Q?kekau3o5NFkB0gEXnqCfmVrF2JKdWGJQTQSOAo7hOEc3EE26SqwGcAm6uMtl?=
 =?us-ascii?Q?YoLFFtDIX1K3Kl0RGqp7Enq/Hsqg02e/1cLdQmXn5G3lbPWueKb2zHaOuNkh?=
 =?us-ascii?Q?znO6rUMd9/dBHijm4GzEOIwluINFQHgzG3YfQgLwyMmoVssDOGHDqlHbIRG1?=
 =?us-ascii?Q?uyO6TJ4pr9HA0putkVh54LD2NPCBq8qlwZb3Tj6t7Ifb7wB3xPdHe2mfQeJA?=
 =?us-ascii?Q?7l52scClpT4mIz6biq+9om73VHMcQYUsh8V9hSSI8WPlm6hUTtc00PdG+95c?=
 =?us-ascii?Q?8iLyJQYk/5uCfaQrpGWJZK1Yy2fJL9nQJV5DoJkO9BEd6TU0WGja5TUECBlo?=
 =?us-ascii?Q?rPl/yNIxkRPQ0i99wDhD7HCngBC/ZKGJpmgfnwUnluSqN+S3iA+/ufCbuEWf?=
 =?us-ascii?Q?sveCYS41LuFrx2gAxszM78SCFG37HwtV6I2lIfe+cMB/M+RhMPiv08l/7wlr?=
 =?us-ascii?Q?DvZrdJcTmwcCUh1I+C+wfnSPhB4YOknT2LJMLnCuXEIs5T2usCSjLQaoy7rp?=
 =?us-ascii?Q?35k2bo6AYYAyCfJgk52KSC+L6NzxEjHB0K+poK95wMLPYLHN+NVaaNFVJWMG?=
 =?us-ascii?Q?9zUSTgMWjc2OFNAXWVQdSaE1HYNQUu0p85qdUgUbXEpW1UvHw31FufirA2N5?=
 =?us-ascii?Q?5TQSHvo3R3yN3Y6+ymrH1V9ep/OB9/2jQ8s7M4nWHZlIyrula4v6M+FIogg5?=
 =?us-ascii?Q?jfQb/yOb4Fzq57/bp0KmHeCU0mHU6cb4gGd4+aNu4WVrra/uYacy6X0GUMvN?=
 =?us-ascii?Q?+s+BlU7jtVFMxW6wXDRgSii9ERuUtwYkHrbFLrpGaWAgb/N2ktOWXE2Zfl15?=
 =?us-ascii?Q?8mp2F1T4cJdEhxBlvQSuZLL0G5oDZLvL8m8QIYURUO3sr270MbkCsSj8WSgn?=
 =?us-ascii?Q?ITCRvnkcqnmYPyTO2/PNPMGKq195UFmYkWa6vpseAt5XoGOYSxsOLmULv9yy?=
 =?us-ascii?Q?m+rarRKrt/nNXwhOm+oot6e6P0ESWOgEcTeipS0gYRMJazcX27gmJlq68DX9?=
 =?us-ascii?Q?0LZPoOk4zgtlSh9LJvoZ8G08rViArgrn5sD3cjK2yST8dZNCYyHqBuPlZA17?=
 =?us-ascii?Q?eK5b5N6FHvJmRgK1DcaOkhPs32XQd/sg3aci45n2w5hXCaWxTdGmkGcuN7mm?=
 =?us-ascii?Q?BEFyPeSzt/Vxtw6pmbdlUjAQC3pWP8v+CrHZzY1EjVAeRZ4sTHwighdNIRjs?=
 =?us-ascii?Q?BQXYlCfi2XHoR8nweS79WqfnDXh9r89ZtJASHbmwEVCLUN+3j0uDcvT3M/Ov?=
 =?us-ascii?Q?/ykg9jYYXJHBatZZM4IlanRFA+aHfoorjuJSBou2DSUlwO1eNsrMJOOePBMz?=
 =?us-ascii?Q?1sq5vdQ3JrwE2Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uqSPZzWNwtR2CooPFcJzyscxO1OEgOrEFz9P12GzkvmtHsJb99gakMxWMmMs?=
 =?us-ascii?Q?SmqtjnwcnDdljdKu5+VXFykBZfCX3GcWR2k+KD1aPmOkqFzDyp1a5esE3shm?=
 =?us-ascii?Q?aMcbbwMtmflKdEJRSD7h/+fZto5EwotsrDopDwsFH0urM7RwJwuRBR5dZL+N?=
 =?us-ascii?Q?kK+Sb4SvysZ4sC0nlVwqD/rNZ1PRdGc8Jt8+mSNOo1BWVsJocs27HbyJ6hFC?=
 =?us-ascii?Q?hjkJ5fX9uRM6rknLGGTOvqA0LZADcVHGkpuimaXUT1Ndg6hEC3jEEyfWT4yy?=
 =?us-ascii?Q?eYpfrwhKWWMqHS/lTwvtwLkjoTHNdVeBTfN6oGOx+Jep+zCVAWGC0S1NK/up?=
 =?us-ascii?Q?2ciLEopGkvijZwUxhy0T4NXvusDSg1oowUTfE+ZNDyF2FwdETvRI2IkXaS5D?=
 =?us-ascii?Q?ARwsp+sWy4M2Vn/QBh2/IEHrgS6+swH5g8wFT0RHSQLG7JDDyNOyQUcFzcFZ?=
 =?us-ascii?Q?fRjD8oxBTYzEJ8UiV+mvKhMN6+tXwlXXYSduXqC+Fgnvv6LU+O67SpbGf9/s?=
 =?us-ascii?Q?YJbuRZRQa6wlAhAKy9OTfn/5jl9OlyaPPLrdEs2iKSfs1xPYQ0GIxleZ54i8?=
 =?us-ascii?Q?zSGtQjV9dXPRzUW/eelD7ceJj8DRAbnjZ0IoDOckkLSYkKS1YW+AFB/iy7jo?=
 =?us-ascii?Q?KGojlg2sHsF5XYdhyQoKBhGspbwwOEPVBd2+VIDYiNGATrCkPgTsXtDAM0ME?=
 =?us-ascii?Q?o11pcjZQbQW6eVOUGw9EitU8RhdKv+xXccndbeHsPQ2j0CHo7AkxPoPHjBqt?=
 =?us-ascii?Q?ttAzRpyaQyf/YG6zznEMAjZz0pyIRbkWoAkHyykCYodZplEOoOSKaZEOR+yG?=
 =?us-ascii?Q?bJcdov1ML0ehmetKe4ON0AaiKtaYT/Uvjz0cS57ZoVK9doyd+xSTPFRv05oX?=
 =?us-ascii?Q?cdivAopxFteGq3TfXeQw0DEMcOk95N/wQ/ZgoDkT0GEyhMH+QpU/BcY+lb5O?=
 =?us-ascii?Q?P9dwBxJrhUtxEBiH+/sfnDZ0d5vUKLN7OTyrHbUC6beE6NOMTbLOW3JoNv4F?=
 =?us-ascii?Q?rSTrXrB0aodMH4Ybb3WL3Qo5wlWVVVgVCObv+22JDnE8lt5l+CPBoHRw7jvG?=
 =?us-ascii?Q?4ZHoVGUZwuz0h5et31JLe9rzBvOAOv918jX5LcBaDyG6w5Jv8tYCSbh/72f1?=
 =?us-ascii?Q?Prh0oHes/CTz5eQpwJGzl7oA9zbY2zNhVwaweci55/+MQhuBJymwlD/wTwlr?=
 =?us-ascii?Q?bP/Sck/UV7rzVwnkLkl7+XV11pCti8/Dk2tNapyU1sQ0z1Wl53le6NUKEIL/?=
 =?us-ascii?Q?4X24/3dshQpIScfsLYCycyRL+Fdi/ZhrY67v5Qd0cvrp9gyxDPscjuIJVTps?=
 =?us-ascii?Q?mpVXCB+i1Qww63npOd+ANu3HQakNQ7aoo8B682HNZfXQmB8/jPIoZzFQDBcM?=
 =?us-ascii?Q?Dicdp9CyDHOM1+bOdEUpqxSIB55IHhnQdmow6GmBnLDIc6m0K8nwXRbgZmN6?=
 =?us-ascii?Q?PuJIf54BHoqU7RQQEz+P0OrCf092pjuI6ALdrgJYvRtJkzZON6jqblNlASZl?=
 =?us-ascii?Q?rPfZ/5WVqbtNmvVHulQIajfupceGv/Z3iJB0cpiKikK8jWftJiPF8P6Cjand?=
 =?us-ascii?Q?Fno8rnsrpnTaLQYvsfH+Efw9w1bJXZAkDAbO8HbZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b734fc-340a-4591-e9f4-08dddf204bf9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:59:56.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+fyyLW86EMGXWv1HBwyQI6O1T2wiReQiZGlCVbljslMeLcydMyWjYjWDqqtp6SvPt886TrJg0L1DVKBJAZTmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8992

PCI devices should have a compatible string based on the vendor and
device IDs. So add this compatible string to NETC Timer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v2 changes:
new patch
v3 changes:
Since the commit 02b7adb791e1 ("arm64: dts: imx95-19x19-evk: add adc0
flexcan[1,2] i2c[2,3] uart5 spi3 and tpm3") has enabled NETC Timer, so
rebase this patch and change the title and commit message.
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 4ca6a7ea586e..605f14d8fa25 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1948,6 +1948,7 @@ enetc_port2: ethernet@10,0 {
 				};
 
 				netc_timer: ethernet@18,0 {
+					compatible = "pci1131,ee02";
 					reg = <0x00c000 0 0 0 0>;
 					status = "disabled";
 				};
-- 
2.34.1


