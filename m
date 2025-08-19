Return-Path: <netdev+bounces-214950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E2B2C47A
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C570E3BCC7D
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C4C33A019;
	Tue, 19 Aug 2025 12:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dqCrbzKd"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183743043D4;
	Tue, 19 Aug 2025 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608293; cv=fail; b=AWB4V8HrcF51dB6peE4N/yFKTLGG/bFoxNa2s9JPNco0mJSzxFlSBZOT3nI318DRxIaqRYDOELn6cb1M7JbWG+wOrjFZ6W5xAOVEjyIN4/Nr5nUp3W4ZkxdlthDV928T58A+jul5ppJ+Sqy3DCtM58cTc5wBxdWP3p+DzqA8q68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608293; c=relaxed/simple;
	bh=LhIuq5sFwgATTIpRihuHzRAI02wkOnR2aiET1QgGWiY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g4jMkYTCVBB9N5Jgs+6w/E7+WyHMgKog/tM8vi1TQvRnSJ95wpLuKQNQ5KVqkGxzI4LfIHyRm6P9t3iyUOQ3NJTKOJXhVCpoSSYgvdCSvDZVl686TPYFRtEFVrHRMcQjS9YQoqTGx+qVPMKrhwIsKNQotYhF4dEHSv9oVKMDGGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dqCrbzKd; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWAEr6neDWF/r/L0yHJBH+iAvQMoQZtKN7csIMSbsgOStGrkMvCMDWaneAUHGHZXTO+zNm3LBitirWOCqAALR+sPurHq0H3xW3y1WGL+jvpcpovQRy8oaiJleTEo8RFYtFWpDObq3mA7ujKpmfJg1cdhYd8lB9d9k5hjNGt9nNfmTJ0gIOeRrCTibASDHryRzN2ijMyYMH5tcHon3rDX9V4qkt2qUwRKKNPyR8Y6fFJzQ4WYXAmu/cd21UgsUBOGYW4tZFMaLIhdNWr/BM20cxPQAH35vxaqLyg4VP5s81uR6dtxSEofkAY2riR75uyNKX9ET2Vubw6OW/8Bfhl1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIocJ5K0O8k7NfyDalvEwSzXsLox5Ke46ckVBDyG7VE=;
 b=xt1cKkjYCiEiUMpWnq9Qpt93anx6bAVnVa3cxIEWdjzQGS+Q33qjQIBUHXR04WOyWMpWLUNH4m1dFHXC0HCjCgWdFfabN79WiVUW0eFs5XGDxpAtVv+dTBWrz3zmI5js4XtUs2RYEbygvrBOkn28+aps8oG1LK0SnLnJJvoPDBaUDS2iqTQkwLOBC3S62x47BDjJJ9k2FZ/lxqg34EfIIp55kMNC0xhuRktU7qjAz+nHoMAGMIiYvhQJNp7qCv0HG9s3bwhrAnRqDcu5jqOVACWpsFXZ/BkSTNx/+TCsm/D/xb15mGZf9u/Yzdgiatz7qlB1u41SRp5YqXt9Yh691w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIocJ5K0O8k7NfyDalvEwSzXsLox5Ke46ckVBDyG7VE=;
 b=dqCrbzKdRRf9AMYDzfdlRxRAK2cdNQMM+POh5wpJxfY+Ftpy9oqJZK0j8CGpS1FSW5VZuoGnuPBJBkr/oGDh37yxQQ0YT5gnYWi/CV8VwacYS2B12JrLoT6Hoyig8NSloZfzc3UQ+QUWYmsFyzBAc36dMMs3aIr75TMLd7F/kAcdVPoiJrcNdsDMtGDmRuK3fgMb40wu5W9TIpwj8US0e8bzDTpuT37mNS5aUL71ql1fYQI4fcFv6Msx+I1ODCpha11HO+nk8Q6/FhoIBkgZ7dgLWRmKk9/g/GIBmstaftYS0nE5rB9FO4rWO958/l+z3z1TsB6UzpKBeMbclKVPPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9946.eurprd04.prod.outlook.com (2603:10a6:10:4db::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 12:58:07 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Tue, 19 Aug 2025
 12:58:07 +0000
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
Subject: [PATCH v4 net-next 00/15] Add NETC Timer PTP driver and add PTP support for i.MX95
Date: Tue, 19 Aug 2025 20:36:05 +0800
Message-Id: <20250819123620.916637-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DUZPR04MB9946:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fa3123-c80d-42e2-6b83-08dddf200a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sw5s155e1hrpsWcevoIO2fNYGoCrt4Aun8j6wAp6OE+/FzjnVKhQtU9j49Uu?=
 =?us-ascii?Q?Ur8TDwkuPopAFFLy/fjRTafrOfakxnov/hYeemsnEupnJftmU33X50Kh5sUj?=
 =?us-ascii?Q?IDlYATFZWvyT6VmQPplWapx9fk6IiO0QucSU212psqArHhakuTZU0cIfkThT?=
 =?us-ascii?Q?k0TVOMoukKvP2NIQz4ddqVSdkC57cLjfhmr9sz+5BEp8T/2Yn+/GvGK69Rp2?=
 =?us-ascii?Q?WsZjMm9SHuwk77F51c21fGxoTazndh9b7B5N61MhVh96fbPvZFhyHWpwMED7?=
 =?us-ascii?Q?hvLVfNA4Uv8W8nE4KQwaQdT07qnALkiY9i8XObYmFq4tlqbF8kmn0fEZUxMK?=
 =?us-ascii?Q?xkhfMycEYLtDunQ8lZEZHgu3Fj+idwC4orSU41UjlDDfGWAbAl3+iXFDksAG?=
 =?us-ascii?Q?8op8pkRy1c1EZ82zyw3ABlxBWfSwa5DATCuYOeAL3UMC81F5D7XBZ7bNVYB1?=
 =?us-ascii?Q?pBvdsGTy1XgjbhSaVD/fj9yZxfWs3qs2eSWXBNfNgP4ydFLDDqWEDfyFDuJK?=
 =?us-ascii?Q?rAxLsJEVFXc7Vvs1m/+6Q08/8fx63EZ4wta0TtZ58JC8q5os1iuw2ZjIWXsk?=
 =?us-ascii?Q?sDI3R6ZZ2+tfvrYwxr1cXUkU/2jWJjg9m7mclhMzkY97VIUAl8fAaC5R9WN1?=
 =?us-ascii?Q?XvyiH1eDgIAS4Xa3aJrzFr7fR8zS+mMWKyVwjE0m7OBq/TG0OtALIgQ0Bcig?=
 =?us-ascii?Q?kDCFkCCBfbkqc98coRYwnHvf9MX+xVsAj+lD139N5gOcG2J9N9d5925+x5lq?=
 =?us-ascii?Q?BS0t5LDsJ0f223itEq3pOeLvz4PsVpX9Bm6JRM1PM1Nz+gr1mY9Tsr5buwHf?=
 =?us-ascii?Q?Nqa4ifUKMHH5QhZ12rResOzajhLrWUbvnASrZZfB+V7wJFn8fEqDb/yBc8/a?=
 =?us-ascii?Q?9pnrlkHcnfkUutAg6ku7d/wPWR71M5x7B5yav9mVoWDfppXQ2L1D9OmQTBZP?=
 =?us-ascii?Q?cGuIajxLh9IGFcDpEYgqyye6XXdEFzKBpjZwoZxlzasRO8Zm4a9r3p0kbgYO?=
 =?us-ascii?Q?LM52SA+f5oGwF5+xB6lWbHzIyP4LIzWD+nr1fXqrmCFcbCPkb1Huu5cd5B9W?=
 =?us-ascii?Q?mZslmXY3gF/Nfl9tUcdt9SylBRdfOhrYi1P9xGjzkUe9eDWXEjElZY9BOJQN?=
 =?us-ascii?Q?tUXiUjEAKtPGWtwRvYD0WyaI52IJnsRkHGxu32XLKbycnaCXd0Upe3HJUyx4?=
 =?us-ascii?Q?zV9XCEaXgqJmn7VJtsrr6iEu09eJADgEeNg6KYgO7L50VunjTHusmjIEHrSR?=
 =?us-ascii?Q?KRSnsmvOwdIjxAbHQNX9fGR9aqw/kfNZsHklUO/Y8pq201+bE3oFfDVg5kns?=
 =?us-ascii?Q?XTB6r0P1MZWivBaQLGcRW771i24lTk/yFE9WUxPOH9cLEFhMRqEjPrWW+wD/?=
 =?us-ascii?Q?+17eXMtvtG+fOm67ml+hJSU0tfiq8FVlcdr7xupX3LwLDfLKYwNZ+4cUkiLI?=
 =?us-ascii?Q?6UOUL5SeDiDqzyiKEss/IDnGExEWPAyhBPfvAsqGP308fcogZMXxKTJqvAXU?=
 =?us-ascii?Q?tlhkKK/KC4b3d1/CzfmesNRPhBNCAd4CSCIr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m/oYTnXFF9OINTsiNi03IkDjYTAbrjKPp0WO71QaSvsIxYySuCAresRaAhtG?=
 =?us-ascii?Q?MwPi5J83nFNGU2QA+ilNp7QSkTdafDT/gMjfG2Psfo5bV9QA82twLYpc1HrH?=
 =?us-ascii?Q?ehaJNGubRiOLT4X1vU5yztmunrrHYVsbmIz6Pjh4fc3N8+BbBK9wMLUtlLS4?=
 =?us-ascii?Q?lSW8aDzOM95wpN6j3Psk0jnyVYEf7QfwZ4oendJUrXPdFrFbT0y2cJojoMpL?=
 =?us-ascii?Q?cHN/ljNHI/uf3HZ6jfTNTCOrEFQSdLxRbCdipTMSX4OPM34LSuGE9xuizOhr?=
 =?us-ascii?Q?dBHlGAFzonFTna+mAYo8Q4vD/W7IpZXQTpwbVTXSNhdWF7QUrmV+cjwu8RZT?=
 =?us-ascii?Q?+X9ju6UGk3jNRKiaGoBLqLeN1w3AQWjs3vf0UM3oDgCXRZ7H+ys8TdPNN2qW?=
 =?us-ascii?Q?9XU24aaWYDEEhh61NMhnbm5+15AnwDIiBSlTqIQSn7J96KHfQA7hDbTuZnRR?=
 =?us-ascii?Q?UGHowItUXRxadvRyN2Vs57kxWbnMsU+FVFf+oqrWntf0KVZXtyaCWufl6BT3?=
 =?us-ascii?Q?yq7gCw/KyCVz/B8Xcw9W1a/DG3dQQohPwhQMKKgOG95YOxyTHsBHIhSy/Vo0?=
 =?us-ascii?Q?Y7IephFQMVjd5J6mD294jbHkR4tysHpP1ei9YBZEEtTfkIbv55eU8iDItY+4?=
 =?us-ascii?Q?Xp1MGNykd82mfrpUfETLDditWnMztD0w5VXBGbU4gZGSdrT9y6qHBlFj87pS?=
 =?us-ascii?Q?oV86nO9RhsGq4gPrNW/20mWcjZN8/aMujgCkACH5HPaNFkvBsptCEqbQbDV/?=
 =?us-ascii?Q?3bIUQ48M1pt9zH9YNu2NoflRCA3/PAwCIaBhlxg1/SB44mT4C4bPZ2AMKWvl?=
 =?us-ascii?Q?aUpoFcnsILpLyF35ocHCHYJD9dnU12TP3Rtna1/unjbup/brTaz6cMfnIaer?=
 =?us-ascii?Q?13fSaGw7lbmS2cq6YkOlJrRMjATI0M5JF6I9OLWm8KC8vSJ5EBE8G2a/h8Sm?=
 =?us-ascii?Q?67s5yw/z3iPiBcUV8sQuM8fpjqxWFNiGndXskvpva+wFaFWUoYVwmvRLoa7j?=
 =?us-ascii?Q?LJnN3Vwez1YCNeH+RpRJBxGwFD2KizWDQjBcJ21Au5mCkBXuqo5VvqthfGvF?=
 =?us-ascii?Q?EQiM+lmXdLoKAKgiyp0PcgLyWE8ZrhVp8eKZ0TZ7DM+EjbtKhyNj0aE3tHm1?=
 =?us-ascii?Q?SKaxA98eJw85MUcPIrdnojgufE949/S8IMNCd4NUVq83gA12NMZu0qjWyJQz?=
 =?us-ascii?Q?HZkIBl9QiNwqFmbsOFG4oJMBx8MmQ5A8xm/cIm5oAPwd9Fg9dVM6G3PRBPgN?=
 =?us-ascii?Q?FyZcTFaqNyyFueb/9lddy+dmBCic0n+tPCwicrYlHoFvoKdc1fcbCkL/OVRh?=
 =?us-ascii?Q?6AOTO6SPnI3BE/rUDkiiokPwa9Rj2vp2ijLawBi6MUjxv3Y4xH4WaJzcH4e5?=
 =?us-ascii?Q?6WvbEyMPdPW6/v8kHutGOO+fH08UhufRizzrEswwHHvIqFYPuAdDFlQGT3di?=
 =?us-ascii?Q?nMBzdSy20t7BzwyeID7NyHPPdjoFc7L+kdZuJZfaHp2odhYv0p+/cuj1gauo?=
 =?us-ascii?Q?hM6/p2iplMIDm3GTHF3MoM0JjRezvUGQM4t6LOpd2CdZ2WVcjiZxw59paOMo?=
 =?us-ascii?Q?mv1XAF9+HbCWLd+75GeNv+VILxm8kiVMeNsMbkHc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fa3123-c80d-42e2-6b83-08dddf200a87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 12:58:07.0391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmoIKjESb9gXelYvEDXoQ3JDjG2qxdNZLI+AoktoRDe4I6Pta61UiLab8p3jo3u/7LxH0kmHNRCPGLQPUGNhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9946

This series adds NETC Timer PTP clock driver, which supports precise
periodic pulse, time capture on external pulse and PTP synchronization.
It also adds PTP support to the enetc v4 driver for i.MX95 and optimizes
the PTP-related code in the enetc driver.

---
v1 link: https://lore.kernel.org/imx/20250711065748.250159-1-wei.fang@nxp.com/
v2 link: https://lore.kernel.org/imx/20250716073111.367382-1-wei.fang@nxp.com/
v3 link: https://lore.kernel.org/imx/20250812094634.489901-1-wei.fang@nxp.com/
---

F.S. Peng (1):
  ptp: netc: add external trigger stamp support

Wei Fang (14):
  dt-bindings: ptp: add NETC Timer PTP clock
  dt-bindings: net: move ptp-timer property to ethernet-controller.yaml
  ptp: add helpers to get the phc_index by of_node or dev
  ptp: netc: add NETC V4 Timer PTP driver support
  ptp: netc: add PTP_CLK_REQ_PPS support
  ptp: netc: add periodic pulse output support
  ptp: netc: add debugfs support to loop back pulse signal
  MAINTAINERS: add NETC Timer PTP clock driver section
  net: enetc: save the parsed information of PTP packet to skb->cb
  net: enetc: extract enetc_update_ptp_sync_msg() to handle PTP Sync
    packets
  net: enetc: remove unnecessary CONFIG_FSL_ENETC_PTP_CLOCK check
  net: enetc: add PTP synchronization support for ENETC v4
  net: enetc: don't update sync packet checksum if checksum offload is
    used
  arm64: dts: imx95: add standard PCI device compatible string to NETC
    Timer

 .../bindings/net/ethernet-controller.yaml     |    5 +
 .../bindings/net/fsl,fman-dtsec.yaml          |    4 -
 .../devicetree/bindings/ptp/nxp,ptp-netc.yaml |   63 +
 MAINTAINERS                                   |    9 +
 arch/arm64/boot/dts/freescale/imx95.dtsi      |    1 +
 drivers/net/ethernet/freescale/enetc/Kconfig  |    3 +
 drivers/net/ethernet/freescale/enetc/enetc.c  |  209 ++--
 drivers/net/ethernet/freescale/enetc/enetc.h  |   21 +-
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |    6 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  |    3 +
 .../ethernet/freescale/enetc/enetc_ethtool.c  |   91 +-
 .../net/ethernet/freescale/enetc/enetc_hw.h   |    1 +
 drivers/ptp/Kconfig                           |   11 +
 drivers/ptp/Makefile                          |    1 +
 drivers/ptp/ptp_clock.c                       |   53 +
 drivers/ptp/ptp_netc.c                        | 1106 +++++++++++++++++
 include/linux/fsl/netc_global.h               |    3 +-
 include/linux/ptp_clock_kernel.h              |   22 +
 18 files changed, 1506 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
 create mode 100644 drivers/ptp/ptp_netc.c

-- 
2.34.1


