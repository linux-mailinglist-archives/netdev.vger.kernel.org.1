Return-Path: <netdev+bounces-206098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140FB0175D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B4B3ABC9E
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C352620D3;
	Fri, 11 Jul 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DMv5Oz36"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D22918D;
	Fri, 11 Jul 2025 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752225246; cv=fail; b=hfQJ+8/ac4GhwGQY/y6nYGWRIDyJAdjU6MjkdrZRaZ0OujIK2kuiIq89CB9OMYvEvOHV7BoHj8reRg/y4oelPYpW1LM3AXFpJXiTsEkWFv2Ix/yLGE7i9cFLslZc/tBR9TpubUS8t6Eb5h3q0zvWN8mIwItp95usVdazQry7Z9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752225246; c=relaxed/simple;
	bh=/wlemSZCLrgV8MeUxIb+o+T2ycwMBAGKVRfWaRb/kt4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GB/wqXpNcbjzFOKtA02sjGmNOpqkwNbB3CZlTz9F+5aukcoVph90NlHgpUu4TUdyR4H3MYuAQ14gzMLx9XcNSH60Ayj8oMpHM+VT5yBdG2U9IEj02f+xF0qe/jYS40VecMK4P7PlcDWYmsp/dMbczU6wCHfmi5Sg1o7M8q4TGh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DMv5Oz36; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxRWFpeOCwCJqUqjlikA13n8q9vH7dHiFd5+x2IP3yTWtsQR8DyGmFoz78jHrSLpsX8p6yLgpjF7/qhOWLeKtLOQbjUfA8at74jUhLx0ds+ecP6eVls3gjIEAZjiv/ZBd+l+625sTcfQf2PsDibzWld1G38EaPTMxkIpluIHTcqZ9oG4IX9L7ophvhWsVTEaEClzZJRVRdm2OG2ateagiuwIbf56iHxePaK4F4xiuTrMa1POpjGfVU5h2norySGa5v1XzdBZOz0xKUI1wrpiXPvQ5h/2wi34bfCczhkGZumIY3TTsjiP1PBYIvNmcu6bqiy0LtfyCtYpcHZQifXGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mde3kLAUrMKmLbCBG9zyC/LBDTmnx8ucCutDHMNSf8=;
 b=xJs1umW+F+J527fD4P2hpCxoVUHfQFEjZ8KBmOngjtiPpNhREktvUU20ElxfrOPgCqgaodIdeWJz6A2xTAy7cvOF+JsEIh9FSlH6bccMXcJ03FS6Ey0M5l8pdeImby4MR6mdYfJuI5VZBlXfdK2nDrqtZeNu75JgCyaZbG339o9iV0UCyxbFDAv26hk5IicfdnZo891In6e1B6bGVoRXxdtqn4k2dRaZKV8fjAj7HgWblz0FLELnhzX6AY4oTbvVVrx8fdIYe0cbyKCrzgLBPVwzKT+sO9w+AGWpEedRlyiu6WvyZvXFrLRpLro+J9bGXsuBtbS8xdvm3rrnRQyGlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mde3kLAUrMKmLbCBG9zyC/LBDTmnx8ucCutDHMNSf8=;
 b=DMv5Oz364luCbSv4YTsmzdohCQdzUQLgQHuHRdtebsAg4fWagnfr6C61cTd1P3C9+jY+a3Tkd/0znC2iyKDfOKyHiNnDpg88NsJ09qTFKyvavEifqyZVikXS9XAEI6jgr78BzUB1meDpQSKMSN8+eF98WQtDHxiXJ+iqxzO7b0ZV1zyG1R0m/GjfWshECzvBsv6SqZCvi8RNSNb2ksLyRVLm9kCRhVOe8wgpFRqyb2DBRiniu2GSY7QBsXeEbleF7ZWYPhdegCb5CVZaNPps7UO0pq7St32EnDOqA2a/dR0gAQHtDuiYUaIc/5sz0isIqNuB8Hg2NBg8q4SCBUx9MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 09:14:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 09:14:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v2 net-next 0/3] net: fec: add some optimizations
Date: Fri, 11 Jul 2025 17:16:36 +0800
Message-Id: <20250711091639.1374411-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::17) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f292f53-8ccd-4564-7e60-08ddc05b4571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PnaiECS/Yfpszbpq4mj6JTdygolDrmYP2MVzpoK+rca8GXrIllUe0EvHr6l0?=
 =?us-ascii?Q?RV0SebUAhaLddG/l3YIu3iVq4YONMv5FEsdu4FBtkx3FZZ1e6otQRHLuAmsg?=
 =?us-ascii?Q?nt7wHGXnulAAbcyr/kaJHRwQQnjReyO/pC2qJ3oPPB7L1u8P7CXJmhLcv0Fz?=
 =?us-ascii?Q?qcN4WNg54s1341cGP9xZKKJUrLS5eaXSsx9dN5kNSCn2d3Tfte1lbMxAkkQa?=
 =?us-ascii?Q?6AgPQTRsboZ2sHzfVNxEf0sw+5Yyq3ZD3/qfAD/qfseU9mZO5yERPTij+e/z?=
 =?us-ascii?Q?qkMnnkTDfpyMBwR2ufix19IuZSxxXvnxUk0MJ5aNm1pq+gsyW0do2rFKcD/+?=
 =?us-ascii?Q?G+PyQ7EFouzRxxZQQDeNDzUpqgXnHn0WwJTAvor6dEFost6huyOyC6qrxi9j?=
 =?us-ascii?Q?jvgK2X9FqohsTCkCAhPGhhJPh6Wg3POMCTEe0QqVkHhLarySX+6fcVko9ufQ?=
 =?us-ascii?Q?tSKel2Jswl8PCFG+mp9UFPhjJBYhbvcNMVtwccb9ISQyyK0bOrz3OgfsJKP/?=
 =?us-ascii?Q?yyIQuejjoI/NPBmjd7/Y0AUt8NLqScYDLXRBJQn/bXOiqVmymwi0AjWoSNFh?=
 =?us-ascii?Q?9yzA0HGL01VAw4DnCJM5CXcsofeQ12+UHZfRCkbiAgKCDuvJwc6ipq0R8Lix?=
 =?us-ascii?Q?iRwKaLwAPh5A4jjpi93sLLGk21prvUpTAVo7L6wZur+rRZVm095C649Ulpzm?=
 =?us-ascii?Q?hiVzJxYiHU+wdNfsDD1CzptbYzr91ue192H7WgFerOyi0QPDUfkMy0qB92ic?=
 =?us-ascii?Q?hxPQeZopE8ay9JO0p43vL/RDEdxR65M90gDIlkE9olPmkPWl81xMoYDxlzKo?=
 =?us-ascii?Q?5milEBLQGfdcUmxML+uQfOKWwKgp8QgoEACc+siF4GQqAbeyxUXZYHf7Rf9R?=
 =?us-ascii?Q?fUZ6Bvvf48byZC0rhPM6S1UNgwTpXnoVjMsYKs4wbiKwM+xKOCElwcq9J1ZT?=
 =?us-ascii?Q?NKijhtLRX/O94uxQIv5JUXR5VqVRgh3PefP2znD15myEFpamJMarZlW5/WBw?=
 =?us-ascii?Q?5u92rtdQmVOJtAphW8o9Rnw+jyMzTNM4tM2GVBHrmKLsERuSMEMHQ2tSxqSU?=
 =?us-ascii?Q?6eiJn0JX+a6PsdURAjdehxyYKKU/gFHWMV3DMjCIp4+4i0vZJNR4AVepFWP+?=
 =?us-ascii?Q?jmNsgPZLLSSl+nKLftbsuPqZ2fzl67nOH6Jv+w0S4yDRjh1nBfEsmzv2039q?=
 =?us-ascii?Q?QCVQbs0veE4oss7iwzUlBnuxhZsfgx89NBB6l4Szzl22nZF2tss0PNPStA1L?=
 =?us-ascii?Q?atnsxAoWX9Sujp56MRTNA20ghCWNMtpSKXNEJMEL9G5uLF0UunIn79E/mnxo?=
 =?us-ascii?Q?oBNG25yMsPZon404Lckj8KeLeCQ+8H1nA5Xu0DqZGwi9OWibGmMPnKCJHJi2?=
 =?us-ascii?Q?Te15pXRR15OTaON3KmRqXztTSwfegfRGEGMUix2JbCIGouYjdzhlQLrfC9Fi?=
 =?us-ascii?Q?+C2tzRqtQHirCTGzifVtkE6qibbGg9ORltshSUu7yubvdywQPJmJ7WKfQso0?=
 =?us-ascii?Q?cmYZ0PfrJlISRnE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2v6gAjbd3f4iJpFVZuKTH3WCX1XbjFsw1kXeNiJTFOpUdLIu0R6W8KO+Lfp4?=
 =?us-ascii?Q?aGNpjCaxNi7ox0baHNRgEKubMCmpKTGw/S+LxINcyhY2xoX32hXN39X9daEg?=
 =?us-ascii?Q?jnMFeDE2af3Kh2PCxcGRcTjSq4O7o555hWuX1NECKy8BqUZDGRBfR4H0RTi0?=
 =?us-ascii?Q?cLN1xSKpMUjYYIYAFGm9DRF+cxfmV39ZkoPVm1QxRk7QyPj+O7jJbjEe/PQe?=
 =?us-ascii?Q?Mh8383azyN36aqd5v9xijUHQCZJKW4R0szvpa+jGNCryzMn8DtS0yoQmqCcQ?=
 =?us-ascii?Q?h3F3mIEt1hjKqQSLMZmYEy+3XFWEvva3zTnBLqUOgbYVJo1GslgNFov6zCAd?=
 =?us-ascii?Q?QHpz6T5qLLmwYaFyiq8DzQx39JmN6xRqTUbUgdfTIus1VCSEEcAY5CSN4bG7?=
 =?us-ascii?Q?35kgNyaIdl1L96plTVPBaY9adKcWJDtKosZ10dZ7B3V9FmXAqCUtxuxSGpc6?=
 =?us-ascii?Q?XI7ZtJXbTehfVyaq16pm2imkAFYv9ey4i+ptv1fj2qg9Chz0+G4mnS1fb6Jb?=
 =?us-ascii?Q?SEbptUwmbbn6bgZkHK6nKfXBT75FkDV6yDHdP5yl1CLNd+ZufSF5iQE5epFm?=
 =?us-ascii?Q?p5jT2v6lx98oVDiv7T9VFr6FAd+ApL0vuS1eQbG85FgTvfio+kcrwq1EqwsV?=
 =?us-ascii?Q?xU7lzm2qVY9vgO89rDcqOm3FoUj0Dc6LNiKsryG3QSrkz1xxEEYOseXMHnF/?=
 =?us-ascii?Q?L0cWtm/E3TGQv0jGAKaegTsuWpDyVAhSzi4iNN90M1Jni9B6tQ4xXVltK5py?=
 =?us-ascii?Q?TSUwzX9y8b1AVlWsarWZ5F/ynjfidvi3yKjMcu9ntdRA3bmFbYwCpSDQLITu?=
 =?us-ascii?Q?VXvJyJc3hph2aodFJ4QCTLdK/TXRtYtW+RCn2TTj9EJQX2nbi1Evc6S8Ts2H?=
 =?us-ascii?Q?JnruuRgxZjtocUxWj38kZt9dDaegAITRuywZ/nmKXZSxFbF4COUcL9EGDHy2?=
 =?us-ascii?Q?2dpc+aRLZrYJ8SPBuQwRZhFmJZQc6endpBosTqilZXK30zNA2OVsrKQC5LJ3?=
 =?us-ascii?Q?7URgLNXqs/FPY554DIYIMmhKbAL2KPKt2w0RpKHslg6hLz6Em+oZ/uy4JDlA?=
 =?us-ascii?Q?otftFlFhmo7V0xnoQJm0B/0w1H+6y10anzOb+rbBOSu0qNSFrYzPTy611bxp?=
 =?us-ascii?Q?5Ztiz5qiuV3pVfvcH2o7kA7XV2NHtcA/nsJzuZcAJbiE7pDp4Hm2EycXnhe4?=
 =?us-ascii?Q?zBCzNZA91lvPkyrEj/SoA4xAJzL+tePIG6Lb01ZV9/uoP9TJyJVV/Z106uAv?=
 =?us-ascii?Q?+PkAT0zhrmk1VCY66nNMl2e4BrjhAg25TICpMirnVwo9wC/4Sn1aCsSCuhVn?=
 =?us-ascii?Q?kH16mdUFahk5+KgT2p72ZZLl2UCApMWfcy43eD/vqwFgsOGo+BX3L4/vRN05?=
 =?us-ascii?Q?/Gsv9FfD9ORrSmPXBA/+TdRDXb2VOoO/Q2KsL20C9G7gXgwbQQvauQ63qA0P?=
 =?us-ascii?Q?wXbs/AP3pKwBQPRaYeK3TAElHlKNIuwaspO8MIpsNH+BJ6Vb/5EM69Swj0eX?=
 =?us-ascii?Q?tDVOh6AuEXCrCIOGDEEH2tuOMkX5XxJ+Dh/mIGuh4yIsd6zveCqvxJiXeRMR?=
 =?us-ascii?Q?XVF1ksdySCxkVw453RazICtuetiK6wA3mCmpXJLi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f292f53-8ccd-4564-7e60-08ddc05b4571
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:14:00.0849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUavVodu6i7ltsXb2EEYgoxrOW13CZGTR8g3oGY07g4DY7BfUXMf9s9Y3GIsjX4fdepMZU7AXUbkxKTZhIfJHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

Add some optimizations to the fec driver, see each patch for details.

---
v1 Link: https://lore.kernel.org/imx/20250710090902.1171180-1-wei.fang@nxp.com/
v2 changes:
1. Patch 3: Change the implementation of fec_set_hw_mac_addr() to make
it more readable.
2. Collect Reviewed-by tags.
---

Wei Fang (3):
  net: fec: use phy_interface_mode_is_rgmii() to check RGMII mode
  net: fec: add more macros for bits of FEC_ECR
  net: fec: add fec_set_hw_mac_addr() helper function

 drivers/net/ethernet/freescale/fec_main.c | 43 ++++++++++++-----------
 1 file changed, 22 insertions(+), 21 deletions(-)

-- 
2.34.1


