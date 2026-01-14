Return-Path: <netdev+bounces-249862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA8FD1FBCD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D2D930D613F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EFE39E163;
	Wed, 14 Jan 2026 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DOr04Jf0"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D2C396B80;
	Wed, 14 Jan 2026 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404114; cv=fail; b=SWQrKmapaaySiP9Sz49Yj/rvSxO6XUGrQK7txspSI7vIwtaW3Dw7QZIn7YwXfaNGaC6vP+yTazQ1o9udX0peNqB4tFWl3Aks+W5Hwti6fVGbHB89Gf0k8gC46Q5/PNQRDZ51At04uBG/+bX6N15iCPSFKKErvWu1oITMV6Ms5wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404114; c=relaxed/simple;
	bh=PgCgojvfwuYghm+UFfXY2oo9N2RcW03QWGNb1Vr1ay8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m5zQ3fOKV7zAaVxx4XYeFtsFSzJP2SJyGvGdjAdIPFgNoEavqZ3cCkIXU2eVq5z5RTvOTS/R5dFhQyU/XpAkyopBuoerwcv039EzAy6Oao0+OP+jueECwlTfLTUaYevZj4TkUSS1KbipViLnWPwtmyTAbnQ021kh/CdiQpBVBNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DOr04Jf0; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve4nRllKe/3G8fRS7jYl7x/NfW/00eX4WNqXIJ7iu/pYW6xFDJCu6gO+3KyNXqMF6gAOYU9Wb85MfCGWyWIBBAM0/RMXoQvQku9M1witPmlsYfVtN8IElS3m65Yr+ge82lzOC+MDGWUg53u8nXqZTqLFKL1ziPxYzdWSCx/V5qQPlMUTKG85JqZDbHRmbr4252gni37KtD5vhTYPgB3q4Kxp9BvB7aL8WBo+3U1GZ/cabol587GPYy96ZDPtuAcgkeKrqFqm8NrA7kQYEPtyfq2nNGcLYQDXM1SM9blbbRtt2XtaHQoPzZBd9QtsrTzPEk597LYZRKFvCxKZmfO3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M37UiS7fAFUL+hufODtjw3na7vHSd63ZGwCVin68EQs=;
 b=LUM/wT6PsHZ59VrynPrjkCOj6YAuaR+tHX2f9rarJG2DQ/zhEBPSN45BnJDB7JLfGbPUEW++iCRkziNwh+2QdbC/YyXtuEi8sZmq6drNvlkwJrSopT+EOBEPs0+4BqsqdnosdLE4GmyJAVPJ8aciTTQVQIdPVsFnxPISvXmEkVlvY1vuXUTUAwAbgu9PJzEkAFkdoThjKbPJ3s2WjcX0MA5xbEfUzHslZHdN19mNc/LOjgtiarrC6XfA/g3Ovp9dqp7R2Nx4tc69viepe5bekh85edayzu1f6gQp/NUCjv7bTaE+0hMCsBahHxn4eerQgnChX/fPvOIzy0v0kwbNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M37UiS7fAFUL+hufODtjw3na7vHSd63ZGwCVin68EQs=;
 b=DOr04Jf02hiwZde8TkH6P+8vjeAIbuI4LS6ckgf3DTgvbPiVPe6n2honA7bLhrmrgLC28f+fEdartvzYnO9uoDZVmnn30taSEEQozJ0iFwuVNLHHGR09rOPsMnCVhf6i9A0oE/MnPmi0gKJGHuo/0ifH9lmNw4uKUcaoGTqGdwry58ZJ2ts7CMBHG2qRGKd64oHmffIH3rWjf8r11aX3b1LRti1V1pza9eJ8T+j6hMWKDe4/ReiuU4w3JVBADhF4sqrIO4+kwFkM3pvTgYd+UpOVRVEWUVnEA8CwAu62cjdJwy8x3hCvrakGgYGQkr7OtAORnXaLJpkwBzRk2VCoxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:26 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9520.003; Wed, 14 Jan 2026
 15:21:26 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: netdev@vger.kernel.org,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH phy 5/8] phy: lynx-28g: add support for 25GBASER
Date: Wed, 14 Jan 2026 17:21:08 +0200
Message-Id: <20260114152111.625350-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114152111.625350-1-vladimir.oltean@nxp.com>
References: <20260114152111.625350-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::20) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf669dc-4edc-4bb1-d1b2-08de53809569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H6H1pfy7bcqnaBJ/5dxkS1c3OzSScA8IQz3epTVfsd6jATjcwoPz78LHLYCT?=
 =?us-ascii?Q?2JXRta2GU1873yW2g7/P81W5RMoRdaKgYTmXL/oUhjgcd3cn+Gz3ru0E+MJn?=
 =?us-ascii?Q?uG/3JKeh0Fg2ivChtERaTZafkUOLjGcXvilFO9MOuAGhd5PlWbuDGqPKOmxk?=
 =?us-ascii?Q?qJbSFAPrHeF2B5kbplobnGlqsLgHbXbI1u06xZQqhV2e0gHJYe5HvFBtYw61?=
 =?us-ascii?Q?SuajoUcGSnT1dzq1A5XqpI4kiIRYS7WBWywMV8bGq+J73qJmD4v3jNcamRJb?=
 =?us-ascii?Q?/cg6Y1tdHdvXZQiLdsVWtVmwL6TidV1UEfivCxR1YUFEpBvNXuKoeVvJ/Axo?=
 =?us-ascii?Q?fJnscFxPga7ZNTCGozo4z7PZd9yJjWCCOPxTIKxWNGb49+LL8RzuaS6DEikj?=
 =?us-ascii?Q?ySd2yDn7FVHGcZ32bWYJXcFjjjNpI143wlQyK0WvEqK1OyKVMN7z3uQFOuzP?=
 =?us-ascii?Q?7fbU3h0zqI4ROmOxLA3roPCg6Y3LSsqNB6dpVh2ATjYdEdgK9kvVjYTltFqJ?=
 =?us-ascii?Q?ISe7tHW9NlD1CKgT/ZIHhA5FpohzC5Q5/YzVuVrNK8dtc4lL89Zbkw/m+2jT?=
 =?us-ascii?Q?Ewf88UOZNX7mdRYrJ41wQo8QTSnLI4IhIBz595iVWbpkLyfGhh9tA2Fkc9Gm?=
 =?us-ascii?Q?v335KlV7B4+tHub+4hklW6i33ApQp8LFcXLVShX6Kk/EKE4grWAkGUlxhiOf?=
 =?us-ascii?Q?sEYuVScPbYfWrqhGEcAuSph+7ek6XJHT2/3y/UqfYPPICty41kLPtdxx4teu?=
 =?us-ascii?Q?HiayHRY7OmQyZe6Ol2WF3uLgCKUeE1Z3h6m+4mcbGuPFxArgHu1l72Itwo1Q?=
 =?us-ascii?Q?10TFge2EljGbhTbAZaLnuCdH/9jPGMThX9Al8ijnz7KSLedQibfOtDfwWBUq?=
 =?us-ascii?Q?Yue3EmHWnAfkbDvUU57fHG4KMcVpBspcmJfi7VtJCiKog3crCs+pAWRA5v5A?=
 =?us-ascii?Q?pWQ0TgenPqQu8g4KSKDHQhY5QHdUyCWpPbqpcnoOZK8r3EHbeWT9+cNbtRaU?=
 =?us-ascii?Q?ZVe6YOyNVi9himnBj2anjcg68b3nPEG610em+6FRsEYhBvFBj65HHimMN3N6?=
 =?us-ascii?Q?8rI4lvUDkV3PEAOW2vlveMUA1mFgAsPucwL4JsG6XhU3Ykbfiwxl1TYCEbbW?=
 =?us-ascii?Q?f9ADuz788Et545uof/nET1VCgprThsfrewpMfaY/LFKI05zkRSkDyqIIinHz?=
 =?us-ascii?Q?ckozOkqZrLora7YysqpC1nAa6mGL5gmik9/V1TLK1RnevRFjQfB86bJcU762?=
 =?us-ascii?Q?abCu1H04aL/Zbh+1WNdU9MVtfmrrqG3IWIVgPoch5iWTAUl2ucDLsJk1f4Cy?=
 =?us-ascii?Q?988SS5SCnA2roKJNXWIlVQEb1cbeU5eV9QUIqxLwxwI0V0cVeG9geXSKOg7a?=
 =?us-ascii?Q?9zTno7najhRI5Gi62EIkLgPtmFdyqdx7onh3xnyD7iXaVdFE+6WZdBTpXqPI?=
 =?us-ascii?Q?gAoehB1il40Eh4009hnN9sMdmbBRntMf6ePaOF9tw1GIa0SoVpQ91Mx708UJ?=
 =?us-ascii?Q?MphPoQUleZh9snCLKxN5EqubPrvsgH/oE/Q2+4nVFzB23hvS7ZZkghntxs7M?=
 =?us-ascii?Q?XOGK7xSwCNtU2s1hCrsIJkG+/c0LtWoL6L3I5P6to08El8K0bv7+3hrjZI1z?=
 =?us-ascii?Q?jPfbq1D88sYLvqUL8L2KTWI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F3Q9wBUEYTnN8QrN2YrC43nTKt0GF/Jdf9S00ZK1PAicSjnNZonO0kX9kDH4?=
 =?us-ascii?Q?q0XDORc+H6cGZ/3XgVxaHZuy882wLZcnrsnEnQnq5orvSGwbs6o0kEph98ig?=
 =?us-ascii?Q?E5PAVVn3DUatXv3fD3S7vGONGTwFRc0dmNJyVraXH7AbgeJqBW6m0v9iDEwr?=
 =?us-ascii?Q?iCgZcyGV0xr1QPGn/5kY6iSOIWHRPrHj1SWrasK9xQiLy0f/X45JtCIPPnLT?=
 =?us-ascii?Q?6cS3WyyDEnSTuRDSHDTC7ei4E2KHjNui2EjyBAYeiYi5YbqhvqaO+dPPTzDW?=
 =?us-ascii?Q?6iJ82byWXzBFolIPtCi8uNYITtEHavQ8ERmk5jc7r64hW8L2MbpnGSMOR3tE?=
 =?us-ascii?Q?rWVtRiDufbhqvNFISAWeEF22QqehaXpxvJp0lRV/PE29cQ+HzgmereLcEPVy?=
 =?us-ascii?Q?ucDNrNmraHDVzKm9FbK4mCnrFFvSs0cQcadl3IkUeXXlqKEPJoIDVmwL5lTD?=
 =?us-ascii?Q?BUxP8E+Uhi6vtePZ4YYs03U8/rXu0StsiRBs60s5APtr+emyZAPMuh6CEvi0?=
 =?us-ascii?Q?MaQjU2Xr+yxlQDqrAKo9d3bnssg9KdIqFrbvcXPZrngOPfUScwNeD8GkLtSO?=
 =?us-ascii?Q?YqJhpIljPEZZmMqyQxOoPtxqnom+M2h/YsrSBBIF7M49auraQUpNf3z1pQ2x?=
 =?us-ascii?Q?le3ztaYjiZFbRVHakc1UyECJ6Kex9Vqf2+IurB2aSIpneiCyMgpReJvBDotz?=
 =?us-ascii?Q?/57wxyp5UDvzhykeJOcuousnr1Rs6P4TRZoLoZLalDh0Y56YW4GLIDi6s7oh?=
 =?us-ascii?Q?EteSe4uwGgofKwMuRb0BbRgDjIft1afea6roK1YSNj6JPFfJfrNriEzKwhK2?=
 =?us-ascii?Q?9xwRWx1pjUqq0MZcnpi/BYl57EU6R0gglwncl0TsIekU3VKVNwlhFtwKS8Mi?=
 =?us-ascii?Q?cAjIyu5QSD6p+cq+Dwthqk1QY+A5+KeT+7T7qQxCkaLlw4mGfglj9FKquLRF?=
 =?us-ascii?Q?dlFcx2F84xbKltXLgTw7bQTgYeiI1VR8Hl0AYUY7YwjXGzbUt4G4KdjyrVa6?=
 =?us-ascii?Q?8GMiwb2S2JATeNWAuwMlEzoI3AHwcMp3K6LzO9gS6mrr8+2pq7DjuEy5nNXY?=
 =?us-ascii?Q?M65b7Y8qX9sPoOBOIkBghoWz1XapY5/zPPT0NsL2qtdIMgOgb6bV+uUv/H+Y?=
 =?us-ascii?Q?G0Lb/2e7ass4N/6okRXC24Ksh7j3OYQDxiA3ZJszR7kBefOf8XghY7FfRPBL?=
 =?us-ascii?Q?RHlfjZG+ke+05+ksTIpCiyGWBgPR8vS6W/vv8TkjIXcN1V8gkzdahMQyiwCf?=
 =?us-ascii?Q?t1O/rpZtGjGixK/7cz3nCgUODNdYXdwGRN+h4VVehcb+VEgbO5o/nRHmAx7X?=
 =?us-ascii?Q?pv9iZSxu+ExuQvbG7PTVHA3wXPYV1+VeNwz4qV8xqy9puCynjIqW5QmL319V?=
 =?us-ascii?Q?pWgmYnprSXwYoV1/NmweeZWx+hvsmbSMkw58cTC2TOmi2UvwHzGdfTHd4/tX?=
 =?us-ascii?Q?tRVwXiCvGlZa9MFPymlPOHc6eGmhuQBzqygKh2vJCys49BgSQdI9/J2akNvp?=
 =?us-ascii?Q?q927aP6oBfW3gBP52GVse97JBstmfWA0nHC3rIc3dT+7715QjB9Bg1QEJ78o?=
 =?us-ascii?Q?Fv9/pDexhpNi1DeAvQ5lQ/dsEPeNgs+jXzt+uTpHq8vLZAf51GsQjwt5cxB7?=
 =?us-ascii?Q?dFf9io1zizlJCwbdc/8sEh2Difda6RmvB7+TmSDsNcx5pgP+pOa8vspjJ5wB?=
 =?us-ascii?Q?g1ZhuhaJ2j5yQ0szfKqo5AUvReQdeg2eQPusrcBn6OkHPt0+1vXjU+OIWkQ4?=
 =?us-ascii?Q?NIpATxIFW09Qm0Id53k/+2vfWK88o+o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf669dc-4edc-4bb1-d1b2-08de53809569
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:26.2635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4arROIhSluZi65bjSLU1AI3ag7k//ArgJs0HMe82qOtLlPGlFTcUQpqIoZsoW+IR/BtU4cfYGIgTB0cIx8RbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Add support for 25GBASE-R in the Lynx 28G SerDes PHY driver.

25GbE is sourced from a clock net frequency of 12.890625 GHz, as
produced by PLLF or PLLS, further multiplied by the lane by 2.

The change consists of:
- determining at probe time if any PLL was preconfigured for the
  required clock net frequency for 25GbE
- adding the default lane parameters for reconfiguring a lane to 25GbE
  irrespective of the original protocol
- allowing this operating mode only on supported lanes, i.e. all lanes
  of LX2162A SerDes #1, and LX2160A SerDes lanes 0-1, 4-7.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
part 1 -> part 2:
- rewrite commit message.

Patch made its last appearance in v3 from part 1:
https://lore.kernel.org/linux-phy/20250926180505.760089-15-vladimir.oltean@nxp.com/

(old) part 1 change log:

v2->v3: none
v1->v2: implement missing lane_supports_mode() restrictions for 25GbE

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 90 +++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
index 9e154313c99b..7ada581bbe4c 100644
--- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
+++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
@@ -57,6 +57,7 @@
 #define PLLnCR1_FRATE_5G_10GVCO			0x0
 #define PLLnCR1_FRATE_5G_25GVCO			0x10
 #define PLLnCR1_FRATE_10G_20GVCO		0x6
+#define PLLnCR1_FRATE_12G_25GVCO		0x16
 
 /* Per SerDes lane registers */
 /* Lane a General Control Register */
@@ -64,9 +65,11 @@
 #define LNaGCR0_PROTO_SEL			GENMASK(7, 3)
 #define LNaGCR0_PROTO_SEL_SGMII			0x1
 #define LNaGCR0_PROTO_SEL_XFI			0xa
+#define LNaGCR0_PROTO_SEL_25G			0x1a
 #define LNaGCR0_IF_WIDTH			GENMASK(2, 0)
 #define LNaGCR0_IF_WIDTH_10_BIT			0x0
 #define LNaGCR0_IF_WIDTH_20_BIT			0x2
+#define LNaGCR0_IF_WIDTH_40_BIT			0x4
 
 /* Lane a Tx Reset Control Register */
 #define LNaTRSTCTL(lane)			(0x800 + (lane) * 0x100 + 0x20)
@@ -83,6 +86,7 @@
 #define LNaTGCR0_N_RATE_FULL			0x0
 #define LNaTGCR0_N_RATE_HALF			0x1
 #define LNaTGCR0_N_RATE_QUARTER			0x2
+#define LNaTGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaTECR0(lane)				(0x800 + (lane) * 0x100 + 0x30)
 #define LNaTECR0_EQ_TYPE			GENMASK(30, 28)
@@ -112,6 +116,7 @@
 #define LNaRGCR0_N_RATE_FULL			0x0
 #define LNaRGCR0_N_RATE_HALF			0x1
 #define LNaRGCR0_N_RATE_QUARTER			0x2
+#define LNaRGCR0_N_RATE_DOUBLE			0x3
 
 #define LNaRGCR1(lane)				(0x800 + (lane) * 0x100 + 0x48)
 #define LNaRGCR1_RX_ORD_ELECIDLE		BIT(31)
@@ -269,6 +274,7 @@ enum lynx_lane_mode {
 	LANE_MODE_1000BASEX_SGMII,
 	LANE_MODE_10GBASER,
 	LANE_MODE_USXGMII,
+	LANE_MODE_25GBASER,
 	LANE_MODE_MAX,
 };
 
@@ -407,6 +413,41 @@ static const struct lynx_28g_proto_conf lynx_28g_proto_conf[LANE_MODE_MAX] = {
 		.ttlcr0 = LNaTTLCR0_TTL_SLO_PM_BYP |
 			  LNaTTLCR0_DATA_IN_SSC,
 	},
+	[LANE_MODE_25GBASER] = {
+		.proto_sel = LNaGCR0_PROTO_SEL_25G,
+		.if_width = LNaGCR0_IF_WIDTH_40_BIT,
+		.teq_type = EQ_TYPE_3TAP,
+		.sgn_preq = 1,
+		.ratio_preq = 2,
+		.sgn_post1q = 1,
+		.ratio_post1q = 7,
+		.amp_red = 0,
+		.adpt_eq = 48,
+		.enter_idle_flt_sel = 0,
+		.exit_idle_flt_sel = 0,
+		.data_lost_th_sel = 0,
+		.gk2ovd = 0,
+		.gk3ovd = 0,
+		.gk4ovd = 5,
+		.gk2ovd_en = 0,
+		.gk3ovd_en = 0,
+		.gk4ovd_en = 1,
+		.eq_offset_ovd = 0x1f,
+		.eq_offset_ovd_en = 0,
+		.eq_offset_rng_dbl = 1,
+		.eq_blw_sel = 1,
+		.eq_boost = 2,
+		.spare_in = 3,
+		.smp_autoz_d1r = 2,
+		.smp_autoz_eg1r = 2,
+		.rccr0 = LNaRCCR0_CAL_EN |
+			 LNaRCCR0_CAL_DC3_DIS |
+			 LNaRCCR0_CAL_DC2_DIS |
+			 LNaRCCR0_CAL_DC1_DIS |
+			 LNaRCCR0_CAL_DC0_DIS,
+		.ttlcr0 = LNaTTLCR0_DATA_IN_SSC |
+			  FIELD_PREP_CONST(LNaTTLCR0_CDR_MIN_SMP_ON, 1),
+	},
 };
 
 struct lynx_pccr {
@@ -486,6 +527,8 @@ static const char *lynx_lane_mode_str(enum lynx_lane_mode lane_mode)
 		return "10GBase-R";
 	case LANE_MODE_USXGMII:
 		return "USXGMII";
+	case LANE_MODE_25GBASER:
+		return "25GBase-R";
 	default:
 		return "unknown";
 	}
@@ -501,6 +544,8 @@ static enum lynx_lane_mode phy_interface_to_lane_mode(phy_interface_t intf)
 		return LANE_MODE_10GBASER;
 	case PHY_INTERFACE_MODE_USXGMII:
 		return LANE_MODE_USXGMII;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return LANE_MODE_25GBASER;
 	default:
 		return LANE_MODE_UNKNOWN;
 	}
@@ -588,6 +633,20 @@ static void lynx_28g_lane_set_nrate(struct lynx_28g_lane *lane,
 			break;
 		}
 		break;
+	case PLLnCR1_FRATE_12G_25GVCO:
+		switch (lane_mode) {
+		case LANE_MODE_25GBASER:
+			lynx_28g_lane_rmw(lane, LNaTGCR0,
+					  FIELD_PREP(LNaTGCR0_N_RATE, LNaTGCR0_N_RATE_DOUBLE),
+					  LNaTGCR0_N_RATE);
+			lynx_28g_lane_rmw(lane, LNaRGCR0,
+					  FIELD_PREP(LNaRGCR0_N_RATE, LNaRGCR0_N_RATE_DOUBLE),
+					  LNaRGCR0_N_RATE);
+			break;
+		default:
+			break;
+		}
+		break;
 	default:
 		break;
 	}
@@ -665,6 +724,11 @@ static int lynx_28g_power_on(struct phy *phy)
 	return 0;
 }
 
+static int lynx_28g_e25g_pcvt(int lane)
+{
+	return 7 - lane;
+}
+
 static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 			     struct lynx_pccr *pccr)
 {
@@ -680,6 +744,11 @@ static int lynx_28g_get_pccr(enum lynx_lane_mode lane_mode, int lane,
 		pccr->width = 4;
 		pccr->shift = SXGMII_CFG(lane);
 		break;
+	case LANE_MODE_25GBASER:
+		pccr->offset = PCCD;
+		pccr->width = 4;
+		pccr->shift = E25G_CFG(lynx_28g_e25g_pcvt(lane));
+		break;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -695,6 +764,8 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 	case LANE_MODE_USXGMII:
 	case LANE_MODE_10GBASER:
 		return SXGMIIaCR0(lane);
+	case LANE_MODE_25GBASER:
+		return E25GaCR0(lynx_28g_e25g_pcvt(lane));
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -703,7 +774,12 @@ static int lynx_28g_get_pcvt_offset(int lane, enum lynx_lane_mode lane_mode)
 static bool lx2160a_serdes1_lane_supports_mode(int lane,
 					       enum lynx_lane_mode mode)
 {
-	return true;
+	switch (mode) {
+	case LANE_MODE_25GBASER:
+		return lane != 2 && lane != 3;
+	default:
+		return true;
+	}
 }
 
 static bool lx2160a_serdes2_lane_supports_mode(int lane,
@@ -1019,6 +1095,9 @@ static int lynx_28g_lane_enable_pcvt(struct lynx_28g_lane *lane,
 	case LANE_MODE_USXGMII:
 		val |= PCCC_SXGMIIn_CFG;
 		break;
+	case LANE_MODE_25GBASER:
+		val |= PCCD_E25Gn_CFG;
+		break;
 	default:
 		break;
 	}
@@ -1143,8 +1222,12 @@ static void lynx_28g_pll_read_configuration(struct lynx_28g_priv *priv)
 			__set_bit(LANE_MODE_10GBASER, pll->supported);
 			__set_bit(LANE_MODE_USXGMII, pll->supported);
 			break;
+		case PLLnCR1_FRATE_12G_25GVCO:
+			/* 12.890625GHz clock net */
+			__set_bit(LANE_MODE_25GBASER, pll->supported);
+			break;
 		default:
-			/* 6GHz, 12.890625GHz, 8GHz */
+			/* 6GHz, 8GHz */
 			break;
 		}
 	}
@@ -1203,6 +1286,9 @@ static void lynx_28g_lane_read_configuration(struct lynx_28g_lane *lane)
 		else
 			lane->mode = LANE_MODE_USXGMII;
 		break;
+	case LNaPSS_TYPE_25G:
+		lane->mode = LANE_MODE_25GBASER;
+		break;
 	default:
 		lane->mode = LANE_MODE_UNKNOWN;
 	}
-- 
2.34.1


