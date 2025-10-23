Return-Path: <netdev+bounces-231991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7A3BFF787
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AEF518816E5
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 07:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E532701BB;
	Thu, 23 Oct 2025 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g01nXbx+"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE801624C0;
	Thu, 23 Oct 2025 07:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203776; cv=fail; b=BATV78Gsx1lnzOTPUFN/Bt9N1reaxJyREucTXjtumd5p2QX3GFSfT5dhgmKUGqgKB/gw5R1rpNHuMWNUtZTBomr/sDlbDeOFhigoNNmpord9sRZmC9q9bjkmCF8X9naU9uvEPrJWAm92Oxm35S2PHeCtuGJsaUoCavTMIisAmts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203776; c=relaxed/simple;
	bh=Wvqf3J1k9fwL2WK/Sp8tlF0rtqUFIZ/lIP1K07Po8cE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=psP2x8r+4KyhM4wWUPQYiqOhMgYhOq7qfeEg1RABixL4jolQtZk7d+8DCzl70u1V000IhveNXZOvPoMGekbK9fN31gJjUZC8Ss/VPPLtuTWJvpmYFxe6aMCoX8uMm3yhpdrqQ5q1cv0mtdz2NIQzpwhfw/xGoPn7PLaRgXgXA2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g01nXbx+; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OesmZuYURUNuqrAGO/d8LJ8kJKD/GdgqXnkvEMA5qK5EdwhhHVTh6w5Xk6kreVmFdzbPJCVtK6fKkvoxO6EgjxUKN1yZgHGEEOg2oTiK8AluUkcXoUU0ShNW5EnCoZYH+0qYpJ8SuDJh4GSTaygUkaFHbk5/G0k6k33oNi4kDdKTNp2vYa3yStmq45mjrIvDZReNs+fzhkiCC5rPU8Jo7bxAIcJGVQs8HWun+Tiojf45hp4E7u6OdRrCRVSHhxrpUDRWhtq91+KF6MXjQz8KgY03lUJp9Jx8kIdEe6AWAYtOFgEhxncQ7JMVu46h2YtZl0X4o/qNF7uBigJQAbUsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHk9xpcgc31wd32RZ+oS3mmj0wmz1iac4M7SFkm1pX0=;
 b=RA5GX4SGLQ2G6htfamzNxpW9fNYZ92yGQQSYY54d5W0ScojCSBZx4IZPO56r+7TWFT5J4ppj1iSUX7h99BiQjuiGSUMqgy78a+x5wAeE4q5QMHs1eTxudBh1IV0pnAc90p7ZwCOhzLLDhh2D6c4SkhWGlB5Yk2nNw9uiapD0UlJ4JclgWMGhnh7afDwnBTS/cjsPUw4//Z+Od43H6OAQyWOi0zd/A6fTEsA9z9qZqZO1ykqUBIcdtlr/0ewOQbjIchH23JP3ZFBqd9pHr8K9PWdCI2XgZFMWEO/oNMAv+/bXl3fpk1ROY1H55xMEMaWj+OFfhvH3YxDM94FjO9Uoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHk9xpcgc31wd32RZ+oS3mmj0wmz1iac4M7SFkm1pX0=;
 b=g01nXbx+9JUIBm+E0bcPcoqwq/LO+vdfsbdOCIGMVyKg6UeAZvf0k5qCbuAklpr4zoPh7SR2oUJ37IROg8KaWY1H9F73Nwj9iuG/VIABk8Zto0U41pKLtcw3T9geeF3SFJKT7fLGLbK05Afj3CibxaV6eKmqzzGpLv/jRmtYCy5XGRM52V015vtzdPDjqfyO+AQw4K1/F1GGaoyXdfIk8XCiTWBXaB+yODy0M1FWP1Et05uAgQtQ+wMtK38DF1PcX8n7BTEOCPylAGfLGezOP9hJeMkz/vrwVylv3cl5TsAnyK5S17jZXCtPj+eigbsgdWRVUVAIq8bCGiWinrAo8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11697.eurprd04.prod.outlook.com (2603:10a6:800:300::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:16:10 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:16:10 +0000
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
Subject: [PATCH v2 net-next 0/6] net: enetc: Add i.MX94 ENETC support
Date: Thu, 23 Oct 2025 14:54:10 +0800
Message-Id: <20251023065416.30404-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB11697:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e250b2f-d568-4b33-6eef-08de12040a65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|19092799006|52116014|1800799024|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QL77qD5NsUbMG/z8bC6zJmc2+vDhDLxlHDn2dJKwYbnbVe9rhExRCrtDJmSw?=
 =?us-ascii?Q?B+ej6pkCO+3lBgaZXY/4JxQ47d5xVQoIqxQkLfOZdmqhrNlqg7c83nar1NZu?=
 =?us-ascii?Q?tuxdQJkwtjuqGhhlQj04hUwoT9RAjGRYaGvSnTl2hggzjf21z16CHLcPMors?=
 =?us-ascii?Q?TzImN+eJyGN0MFn1g7Cma8vytlH4TCanvnwxHQm8pLmMLThe9PUgbyN6hfHy?=
 =?us-ascii?Q?Goxy/aVhHBoHj5GhXGt7A8XT4qpjGIMapYPdoefhn3BBthONOf+mTYGNO/2b?=
 =?us-ascii?Q?zfUbI1IKIrXVpoU8kpgEPwc8xKru2VIH2mry86k82I/b8afIcCn9ld0lFKRA?=
 =?us-ascii?Q?jdRR4RhEKM6zYi0UeC+LQed23vUHKdVJXrq1W7rUdcoCp65vAqJ52SiNMLlt?=
 =?us-ascii?Q?1pjfW0rW6KpgMrCCJ9/1pRq4EihkLg4TwrZfcuqrvJ8qJaWE4aGTiuJ5YFye?=
 =?us-ascii?Q?SyMFR8plq+zaK9t2OF3afgRfJSSPfQrTHnPArdVBTkpC3VE8Lif6fZVcZSzS?=
 =?us-ascii?Q?84ZeO8dpzgTU9gwmhdq1QhQW0kRAM3AywboKhSnRpQrsHniYSb+xMDqIbSOn?=
 =?us-ascii?Q?DFqYHwr0zd2fguYP4riUy8K+PPcRPLR0W/GCAm2bci4PbepCo3GhNCFqJJwM?=
 =?us-ascii?Q?6fih3yqI6XB8b/QxcTdf4Hzi66XrkGhymr57dpzucfxe0Esempi/bkGp9ie0?=
 =?us-ascii?Q?SaHWWhcgSmbSo/V8w6FW/elSEWZSgIUN27MkBrneVDST/BwFlNInw8ivzUAa?=
 =?us-ascii?Q?Hb+ERR5eVz13bcZ2cqEftKB/9iXgWtv8LysZhT/9FRRVD5wQWlWKhkzlk86B?=
 =?us-ascii?Q?S70X3gnI2551FKUbM44pQOh5AtY7n7At2XKt7Hy6bR6EXpAEZWnsrNDyDMBP?=
 =?us-ascii?Q?iOeNU0cZib+zX5MRPIPsiIbSsNbo6kSNmkL3EcHBQ6rpKFGKRrsHjgua4+t/?=
 =?us-ascii?Q?6nkXy37GaQLAn8fNfi7/MQQCs/jUFRAPrOg9wnoi3D7iAJH7wmng5Kxysnv2?=
 =?us-ascii?Q?OMQxA+ndF7l2QnGZ9/vsczDPRTxpeifq02PE4O/syryILmMLQCZeiIQi3Y8J?=
 =?us-ascii?Q?g186liX5IdwW4+c/Ev6zm1/0WQytwzzUWgDLAgiGew2MxC46aoIX1jGB8X8+?=
 =?us-ascii?Q?UGoRPNEa5CjTeHacl4KviA0+ZmEoVy49UM8hbVy+ue7eFAvqjNzfXa7W+FHd?=
 =?us-ascii?Q?eWLsq7Riuwgj0pFnuzixsodMuU/L5iZJzyRlT7x7dS1hQWjf8JxIOR14yixu?=
 =?us-ascii?Q?wRMdvOoU4bJjgTOw7e+RtPmpHj3EA79y5YlPwjC/6enItS0Nfq7TTP+L2uV5?=
 =?us-ascii?Q?N4jnqHfsNjYIlrLWWY8vuYbw9zdzb8tnboLoki4Vx68TOWAN76WLtsGonrVY?=
 =?us-ascii?Q?+5UNOLhXgFbaoAJg3OhokY8T3kFmjCscalNq2nCuO6vUg0kL8KihIJcH8TfG?=
 =?us-ascii?Q?ZWRBjh+TfJIRTNxFEm+yS8TDZJzYbvSfwQ5tOG54JVjviuPSqBXGmhx0liMK?=
 =?us-ascii?Q?wpdZTOnuxHu9AGj0d1YHjs0J2nKb8VOlGUPz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(52116014)(1800799024)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLA1vfu9hKr7c+oqyVT13ihZzVJHk/NkbI7zYg41nja/8g8qvAvq2fUirHo2?=
 =?us-ascii?Q?8q2786S3MaC18JEkoub6C1a8gteAaYCjAm8dZdIuxLhERMiBNEpeaVV/ZoZ4?=
 =?us-ascii?Q?B7peZU/gNhYsNW2ofIKCnJWvFBcdWYL0O0cUy/hbunlHh0peScqkCbyiMaT7?=
 =?us-ascii?Q?qyNppr4JtBjZWlJ16zNxixulJ0nsgRzd8WdImFCV5xSqnXzySJUifdig+gSl?=
 =?us-ascii?Q?WMvSBsqHZqqGsFbi/g45ASDy+vGl+p9ORHfKKWCUNzXeIhkG6pp6walpUadJ?=
 =?us-ascii?Q?6T+WlTlcruimitK195GvOPr2GkKKg/jFI2MBnAO9aCOC8+/mqwjfPOSPVNM/?=
 =?us-ascii?Q?sWLhaNq9vMNEegv/lH44Od7/JEsAP7k6O7HqXuxj/IkJw2eAwzk961GWh8cW?=
 =?us-ascii?Q?NUKLDj1HXSFhd2ht+4pH7PCPIJK89VnE43+qJZN5H3z7miOFWRN6A8Qrbu5J?=
 =?us-ascii?Q?CTaSrDebgPMQOYZes3se2qjklVlCJiT/qg7CZdV489NlSAISxDtpA8ilQU3K?=
 =?us-ascii?Q?WzDX3OOw0Etbr5E7QH0WDqpiVQroMmGWC2t3R4LjpbHzOIT+m+CD7Mce+UVI?=
 =?us-ascii?Q?kCjBB47WdGEjkY/vRom+T/pFRp3agEOT4YbTvFtLirdL5QabG3QXWzCTDWCO?=
 =?us-ascii?Q?57QlHckQJIq+v0Wtnj99b7cewG6WI/8qPFpIFNZdsCsnh9xeoTYPIwfxkM40?=
 =?us-ascii?Q?smvstazj1a8/UR0YRE+JXv3991eWR5xVRrX+5Mk4V42rnzueTT7xsL/3ik74?=
 =?us-ascii?Q?dvJLKRhQYfpwZ26ajRIJbs0dWmRONJGlKtcKt9ddf1UEcTdxTLHHpsS/2wmG?=
 =?us-ascii?Q?4DubIm31S3HnyHnIE7072F2ZFfOu7CD2sgHTKUqnOb21PyztPdUgAiduK+TH?=
 =?us-ascii?Q?+M7RWp445lWXeOWPLG7cBn2ErgWcNulhxVTzloipDNfvtSpKaZ0QoUvKaU7o?=
 =?us-ascii?Q?TaA9eHKTvXkf9dZIXFdySYpj0VzTakVBFi8t3BlJ4Y1ABiVSZggwv6w8QXGH?=
 =?us-ascii?Q?xJlasI2wCUM3zrJv0TIACaWceaaGABTnyDF6TvQB+xQKY+vbK6DyaO8leHWB?=
 =?us-ascii?Q?cjoWIn8HzhAIPAEtLD2ibxjQsNpS81KENc8PXIbL47EslcX1EflkrsmtgXjn?=
 =?us-ascii?Q?esUaOk10sWrocaDEukXADDWTMvVa2Q2dOVZO9cCzoqfQTApywUG/aPSzDGxl?=
 =?us-ascii?Q?oc73j0MXvhWVyEqENC0kqdOY5sb+xobpfYCOP/+7hr5SC44Gc5Dy14fjAi2q?=
 =?us-ascii?Q?7/uhcmnp4HUNMoJvGyJ3jhAzkjAn6oXJvYsXGR21/EAevfLKl61CNFyRdc18?=
 =?us-ascii?Q?JWGSILGTa/O0Z71kG3FkkXw5JbP0AcsjUEIvMcw3m++kflBbPMgF81PE8oQ2?=
 =?us-ascii?Q?FEM0V8rixJC149uZtUz1p86VWRU4MS4s9RnQVOyp14PMT1jLvIHR8svKFoop?=
 =?us-ascii?Q?tCTU7yuyAyYQ7kgZXy9v9EVpqD8ornQ0DwEGwBUPsjCOX+7Elv5bGDooISCV?=
 =?us-ascii?Q?ubh0n/WernxeKb8xqtT2hHDDQWHYMjxLjPs60LPAOs4eO8XJyW85MnCD3YK1?=
 =?us-ascii?Q?JUshd1TlpUV+ze+BHvZ89hAnDG8q43OUbPotqLan?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e250b2f-d568-4b33-6eef-08de12040a65
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:16:10.0354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm9Zdu0aeELg6GVpd3j9KyJcy0TjalJNiATjTdFxQ+kud+ije9Dm5YnZ7GmL3RUK01kaMeWxaGs1uF45DJs1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11697

i.MX94 NETC has two kinds of ENETCs, one is the same as i.MX95, which
can be used as a standalone network port. The other one is an internal
ENETC, it connects to the CPU port of NETC switch through the pseudo
MAC. Also, i.MX94 have multiple PTP Timers, which is different from
i.MX95. Any PTP Timer can be bound to a specified standalone ENETC by
the IERB ETBCR registers. Currently, this patch only add ENETC support
and Timer support for i.MX94. The switch will be added by a separate
patch set.

---
v2 changes:
1. Correct the compatible string in the commit message of patch 1
2. Remove the patch of ethernet-controller.yaml
3. Remove the patch of DTS
4. Optimize indentation in imx94_netcmix_init() and imx94_ierb_init()
5. Revert the change of enetc4_set_port_speed()
6. Collect Acked-by tags
v1 link: https://lore.kernel.org/imx/20251016102020.3218579-1-wei.fang@nxp.com/
---

Clark Wang (1):
  net: enetc: add ptp timer binding support for i.MX94

Wei Fang (5):
  dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94
    platforms
  dt-bindings: net: enetc: add compatible string for ENETC with pseduo
    MAC
  net: enetc: add preliminary i.MX94 NETC blocks control support
  net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
  net: enetc: add standalone ENETC support for i.MX94

 .../devicetree/bindings/net/fsl,enetc.yaml    |   1 +
 .../bindings/net/nxp,netc-blk-ctrl.yaml       |   1 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  28 ++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |   8 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  30 +++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |  15 ++
 .../ethernet/freescale/enetc/enetc_ethtool.c  |  64 ++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
 .../freescale/enetc/enetc_pf_common.c         |   5 +-
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 204 ++++++++++++++++++
 10 files changed, 355 insertions(+), 2 deletions(-)

-- 
2.34.1


