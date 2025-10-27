Return-Path: <netdev+bounces-233055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C77E1C0BAC3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F74E3E77
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4992D24BC;
	Mon, 27 Oct 2025 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mI6hH0XT"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013058.outbound.protection.outlook.com [52.101.83.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090352D24A7;
	Mon, 27 Oct 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530882; cv=fail; b=icoVnpT2Sjw5WHR/a2Tt/dVMkeJoHIo44wC5sUvJ3dJn/s3iX9fGjuepJ+8iWoyEhpE7Q3sSsP5MTvDzrcj9YhFs8P55iOu4Uj5Bq4phWup0eH452dVCmJ99quRsDuCceF2kod8LinxuV9agjnIcUY9YYtc5fNyHBNyDv5gtlYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530882; c=relaxed/simple;
	bh=Wbi4dZffeMflDy/IVVj2OZuq44Gm7Uut1ynMWTaA5Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5SpbxChyKG5zGgh72gto92oRHu7BvaVQZUG8iPJmherc4QWXYYizj0J7pZo115JpZEk1RD+GvlJfBsiGyWWiDCD6ipKsptU2w8rsrKvlouQJZAkNBA1yIGoNZMqmyf08LiK7nEqvvBcuEQPnMSOFana6D1L+mspqTUiz1lp3A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mI6hH0XT; arc=fail smtp.client-ip=52.101.83.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3dJF8Fz+w8ii8nWbGdnjIvDMkhbkWYyy+hgW+i8kkKQ3TjXttBFcxPpOQOszCdEYUiEIDtOqnLvi95qNwizNQvsp6p8x4+tj4Q8+H5R0+KVE+mnpkFgnlNYu4RTO+VLwCz+omB7wM34R5mEFvAYylCNcOp/hi3bXXKbn2fKyOCA5LVmBNvEmGYOSQz0jkmYHAUIijo4f6+PCaQcg0kw1YYykyvT6smq14Z/Dj0YSU//NaRtgEO0fRsTGyQTT3L64ZC5ldkkXR+B8RzAN/HF+AEKaVY/QfkiFN0vl427ncDtVbq0wJcGQ771D3mB9YvcEJllz93QjSK4j8eykNs9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkB8IuSLyquVNI1LT9Kb7sox6OgPVGtcsbD14OUPq5g=;
 b=sT/L/NrYyuDWoYj+TV6Sm2nPYR5qyS5euheeIUDIoAM+fL7O9/3b5F00cd7QsB8wl7ZievTL3tP66N7rUHRFsePLvsB1XJB3NMh+LKMDIYplENs3VrLAVERZNfHh8GeuK4q/ChOVYrPMtDY3GRrffWRQzUhQjeg8l9t3JfUvpZQv6WrRyHM99LtIepGeP2Qv3qPIuQin+e8CaH+qOHIJhptpXc1SB9BkAC0u1prcjPv2BxPBQRVUAjp1AfFUWVbm2Gf8bzoX0FnSUWqLYBQYAKtyYsYYXQ9hYl2eRBDzP6OksVekcW+mJ2gcHmZVMAUu0eZmQ9/dOAQFd/dRULGAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkB8IuSLyquVNI1LT9Kb7sox6OgPVGtcsbD14OUPq5g=;
 b=mI6hH0XTrfdSuAQ49v7apiiL5TE8zoxfO4wISEQafPFdntK0ZRkjX7i6XLahQTMJ74JHE1riEdAZ6dtqGCjcbvPoajndchqmfLFJ49+l27q99TWK2Lm7za/7YTCPz60mufxU00nGfbOYA+m7eImy1Vp7M4qY5hnpnhWXIFN6nWpJM4IAjKreEPjSR2dwAK7wtPIRaWAELHcblAxdkF1oOqGvu/zSFJstatobuoon6nZOmgzME89KQmHB7Hj6dAx6HK510cYxjaqldovUSSuhYWd+EqQ9GRfo7xrwSTfJ8Yzjq0JYFAXzYl5lX+qGjEv9KAy9CEem0F0Un0Zq9jt6Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:07:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:57 +0000
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
Subject: [PATCH v3 net-next 5/6] net: enetc: add basic support for the ENETC with pseudo MAC for i.MX94
Date: Mon, 27 Oct 2025 09:45:02 +0800
Message-Id: <20251027014503.176237-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027014503.176237-1-wei.fang@nxp.com>
References: <20251027014503.176237-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dba7a20-ca3d-4131-e3ae-08de14fda57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KlH1Bhjj34fGb9W41l+d+k44H2mqwJ1LOf/A5m99MGnbTc+ssjTBsXqpFK2f?=
 =?us-ascii?Q?idFBYYnH15OirWnyYg/YCA4fBiReMXONpRCMMBXaETTpWjDiiI9vKbRbaB+t?=
 =?us-ascii?Q?FuKTfHvGEbuMOJvOnVcFafYLfs/cPB8I57Q8szPc8PgSsptkxbK8EoOZRlao?=
 =?us-ascii?Q?vZyiNK4bPK60PomxryINha10Ldc4f6LEkOx6rQ0XQGnKDzFxUAQj2dpLZ5Gz?=
 =?us-ascii?Q?Nx7R7vkXxrh6gDzsjxmQrJeJGcYAXd+1XX+hjKdUFEUqvZ1lzPZxsyePacxD?=
 =?us-ascii?Q?i89iV+RauKgOqlpU7lvj6Q/puwWnd4ic6m54/dvuywBwSdSb9HOk+czUN/+l?=
 =?us-ascii?Q?Z14CY6H2rvNYl1qvQv7TH/LqqCIVAxNPazQpVtKD5yc3iItXbeQEPVZqZgeH?=
 =?us-ascii?Q?eYBYmfSGJfWibpJwIhcRHt5q/KIS6IRGn7znFILJ2ssI/Bd2Dv7MbfuzKvvQ?=
 =?us-ascii?Q?sdhpeNmbTyYrC6S/GNqrC5xN2esZMGk+Z/yIBcmElKAqGjyXGkqGo8WCPWQ6?=
 =?us-ascii?Q?CNoSXDfR4X7xk4+JaGipQOaaz0SGbBOfy2lZGjvaYPtSAm+LFuCgM3kCzDCB?=
 =?us-ascii?Q?oqHbhJ39rhEz5e/D1Ypol0s/TlpyzDw6NdksWyBpDhkMMrpZ6x1/FkM5AEri?=
 =?us-ascii?Q?hdkIKqdzJTUMyH7jkELHEymHawX3adOxxutI1/1cBp10dC2aGX4cuW5wTH9v?=
 =?us-ascii?Q?Nngskoj+RgkajkQgG6hy9IEKVdsNAq2p9sDgEhhf9XVU4Ta0Nh2P3Z7LtS4W?=
 =?us-ascii?Q?fLtazX20V9+LO2ZBVeApVNf7uhJZAzzr7S7aOxTRSYytYa6OpGT1CUrQomm5?=
 =?us-ascii?Q?bWYugW7qo7nHFo6BIrW8q4JMiJlViihN2pNo2EtSg3jT2SbgdrswihvBFBSR?=
 =?us-ascii?Q?4XhlbHmpRi9WSafz0YKTIEr+gIRfmVooMVRcJ+tMv86VyCb6xdAwBCzyZb/O?=
 =?us-ascii?Q?bxeXwSX8F1LR88QIQ85Z1jp0f6ZJpnON6Ppt5Jjg2qI9DxVPTUH519CGyDxL?=
 =?us-ascii?Q?PLsdP5l3fj68E/vosgJ3LGFuaN509D/7LOxqoKgVK7DLCmdB/kZ4pi+mhGEC?=
 =?us-ascii?Q?PfFFRd1J8+qaXtV0/0MTepGDfuyLoZWvxm0Vs0//R/hI5WBTR8TRDPRyUvfu?=
 =?us-ascii?Q?WPOJxduwWOAnJRXTRD2Zy3EnXaZy/q4zkPBSZzWFqNE/rwv/F0+OgYseoq1j?=
 =?us-ascii?Q?vgViFLldHjge2oFd/Ts8pubqRaBX1WdGfyqkxDA0mQyzA6OYCgXAGbX5+qDP?=
 =?us-ascii?Q?li4AVqBNHvxF8AP8LDXrTNVGpuGuSPuz2FBI30BcBpf6lnOxp42U5cpB+ylZ?=
 =?us-ascii?Q?NY59GjURKix6L/aFQtpO6c1+nJLPWlq2dbxbvnBs1V4/Q1uZmFUKT+FtqhpR?=
 =?us-ascii?Q?w+8UkvsnwwXgr5P5QtMOZ5AGnTB3dDbqzHBV1aiWis02BeT3XZn2yxag94pP?=
 =?us-ascii?Q?wSOI1218HBpWZBAWPg9dcPTVCzCJwtcVHto40NHqpNh/LGsFmSHv2khqMJqw?=
 =?us-ascii?Q?Iv5DJ0dSgsP/tted3pmhX5YZC7jz2aBIWkhgV6N8+I3dgb4E8vpo+6b3vQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5QYcdsAMBIdDbvdHp6NNNfY5sH7fqkyal7hszyGRJcngoWcHWZ8WYABO8pV4?=
 =?us-ascii?Q?F+59drBChvDdn910bCfZVqJAX9hDThgkWQUYysJFhZnvRalS6GBNrzmkNJmq?=
 =?us-ascii?Q?fzol0AMgLx0geOgjjrqyz2+SRUe9mWdiN6omnDh7UFZH2DU99ZffqBa0ihU6?=
 =?us-ascii?Q?zRajUzv2cb/+yijI+ZIKMen0R7bKrNGi3LsQkdN89h7YJg7sATYvuM3UTHkT?=
 =?us-ascii?Q?DMJ3VzJSn2qr1y3k98UdzYIHFMs+t6bck5OMacFfqdxG/28Ep9Dlk9icOu78?=
 =?us-ascii?Q?38RC+8AhyqhhTarrL2w6fNe0obPJPuPbx6SJZ+JYXgvQiQilirOGwNFOX8Et?=
 =?us-ascii?Q?iCsFwf676N4hZOcIsXbHZLHBbpwlDuvYdjPYbSZIra5W+mp0Km0kck815sPt?=
 =?us-ascii?Q?7UYw00DnSkourD/peChfsZ9XQJhTvZQ8th3ykUArD/lZazpA98UenAihNbsB?=
 =?us-ascii?Q?f3+ZuhbMXGWYNWu/qcEEojeYYWUQeawxaD262dfQ6K3asA9YuZ8xoyxfHd7C?=
 =?us-ascii?Q?t1lMT9zxndug07Ab+mk59Ta3Qe9r8erqW2Fh292Kf61NVmAiWa0LGNSkdSMX?=
 =?us-ascii?Q?qBQJgAsPq4kI9RV6RU7Y/GfPtbLoDtJjJ67rZZ63eFXUkpLaMBAryYoZp3S5?=
 =?us-ascii?Q?30Bn7aTVzMZS8GQTEd3kT13PEZbh5/W0cde8sr+8JWV2WMwA62Am5mw8hFqy?=
 =?us-ascii?Q?suFn2iviJg1ml5CNu9I+o2lx5XJIruoQvBHQtjRlWosx6ID8Jeu/94Ah9/eV?=
 =?us-ascii?Q?E4rTTlkx6JpENwEq2Zf59rki58z7sWSE5kP9kYSp1DXmY3BzqiuwNI++638U?=
 =?us-ascii?Q?nmdBvDza7UABm6tTboSh2BEFklylZBfgr9cYyeoMFWo+eaZRYBsDUlbxm2hF?=
 =?us-ascii?Q?CiPtpiVrJox96XCVpIQMI9GSCZBknO0sutJibYwP/o/tMYWkrEfEJ7fSj9sQ?=
 =?us-ascii?Q?mK1q6rowFzO8EYm0qn6h2s9ICWTXDxfAEEP2KQmEBOjX1vxI+fEHw1zSWIfY?=
 =?us-ascii?Q?smAgtKvCiR7rFKP5uXcJMqQ4iPNPY08+4W7md1jnmRn6tslhqUMtwC/sz7be?=
 =?us-ascii?Q?w7ysZf9PZz8ClLd9kHi1S9vwkVJFumHkuWDRkZyYG5v2iqJ17xYYawQEbC8c?=
 =?us-ascii?Q?ANU59QoFEPwKqVKi7lUy5fmYuCN8qRq2tTXBPSMEED5yrChBSYqCzpHwVC6c?=
 =?us-ascii?Q?mSPrDYzzpq8Ni1xlICUzAbiTYIkWV9nj73X30SPvQ6eTq/CzkI/5TlsNKmEa?=
 =?us-ascii?Q?85+/bvn7vwIuPBcYg9lr2r2XVmmSuqwohfX5hLDAMfBEWXemSL9PxvltLrbN?=
 =?us-ascii?Q?OO6X8kfgnFqOWEhwvdKiBcumIlJy+yeOBVY1IXC7v6R4b+uDwBD3PYUDDs3t?=
 =?us-ascii?Q?ltXObW+t1R0G9Yw/HX1jopPO2fupuPQdGzDqLc02FOR6J4672B//4bDtr2mj?=
 =?us-ascii?Q?SwZoHq5CDbUQhdbplbcmMiGeSJUMHJeRfs6BtIuq/3w6UtugtNBzEcU6Lj+b?=
 =?us-ascii?Q?j9rKivYLdIv8qxeySte+dHlovvuPqCZrf19riuMDFqWN5vfaI5sY79Oj00+q?=
 =?us-ascii?Q?NZvbwmOKMDzZsWi+bVDaVVgc5IM27dI/+q+OHz1+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dba7a20-ca3d-4131-e3ae-08de14fda57f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:57.0921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRfjxThsL+2Z3kLYUHkrtriHyb4L6oDGxmShY5tDT2VwJ80S8CbHAYA36f3XQ4kQMlORKy76TaG68RfKhsWUFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

The ENETC with pseudo MAC is an internal port which connects to the CPU
port of the switch. The switch CPU/host ENETC is fully integrated with
the switch and does not require a back-to-back MAC, instead a light
weight "pseudo MAC" provides the delineation between switch and ENETC.
This translates to lower power (less logic and memory) and lower delay
(as there is no serialization delay across this link).

Different from the standalone ENETC which is used as the external port,
the internal ENETC has a different PCIe device ID, and it does not have
Ethernet MAC port registers, instead, it has a small number of pseudo
MAC port registers, so some features are not supported by pseudo MAC,
such as loopback, half duplex, one-step timestamping and so on.

Therefore, the configuration of this internal ENETC is also somewhat
different from that of the standalone ENETC. So add the basic support
for ENETC with pseudo MAC. More supports will be added in the future.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 24 +++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  8 +++
 .../net/ethernet/freescale/enetc/enetc4_hw.h  | 30 +++++++++
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 15 +++++
 .../ethernet/freescale/enetc/enetc_ethtool.c  | 61 +++++++++++++++++++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  1 +
 .../freescale/enetc/enetc_pf_common.c         |  5 +-
 7 files changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index aae462a0cf5a..88eeb0f51d41 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -14,12 +14,21 @@
 
 u32 enetc_port_mac_rd(struct enetc_si *si, u32 reg)
 {
+	/* ENETC with pseudo MAC does not have Ethernet MAC
+	 * port registers.
+	 */
+	if (enetc_is_pseudo_mac(si))
+		return 0;
+
 	return enetc_port_rd(&si->hw, reg);
 }
 EXPORT_SYMBOL_GPL(enetc_port_mac_rd);
 
 void enetc_port_mac_wr(struct enetc_si *si, u32 reg, u32 val)
 {
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	enetc_port_wr(&si->hw, reg, val);
 	if (si->hw_features & ENETC_SI_F_QBU)
 		enetc_port_wr(&si->hw, reg + si->drvdata->pmac_offset, val);
@@ -3350,7 +3359,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 		new_offloads |= ENETC_F_TX_TSTAMP;
 		break;
 	case HWTSTAMP_TX_ONESTEP_SYNC:
-		if (!enetc_si_is_pf(priv->si))
+		if (!enetc_si_is_pf(priv->si) ||
+		    enetc_is_pseudo_mac(priv->si))
 			return -EOPNOTSUPP;
 
 		new_offloads &= ~ENETC_F_TX_TSTAMP_MASK;
@@ -3691,6 +3701,13 @@ static const struct enetc_drvdata enetc4_pf_data = {
 	.eth_ops = &enetc4_pf_ethtool_ops,
 };
 
+static const struct enetc_drvdata enetc4_ppm_data = {
+	.sysclk_freq = ENETC_CLK_333M,
+	.tx_csum = true,
+	.max_frags = ENETC4_MAX_SKB_FRAGS,
+	.eth_ops = &enetc4_ppm_ethtool_ops,
+};
+
 static const struct enetc_drvdata enetc_vf_data = {
 	.sysclk_freq = ENETC_CLK_400M,
 	.max_frags = ENETC_MAX_SKB_FRAGS,
@@ -3710,6 +3727,11 @@ static const struct enetc_platform_info enetc_info[] = {
 	  .dev_id = ENETC_DEV_ID_VF,
 	  .data = &enetc_vf_data,
 	},
+	{
+	  .revision = ENETC_REV_4_3,
+	  .dev_id = NXP_ENETC_PPM_DEV_ID,
+	  .data = &enetc4_ppm_data,
+	},
 };
 
 int enetc_get_driver_data(struct enetc_si *si)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 0ec010a7d640..a202dbd4b40a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -273,6 +273,7 @@ enum enetc_errata {
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
 #define ENETC_SI_F_LSO	BIT(3)
+#define ENETC_SI_F_PPM	BIT(4) /* pseudo MAC */
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -362,6 +363,11 @@ static inline int enetc_pf_to_port(struct pci_dev *pf_pdev)
 	}
 }
 
+static inline bool enetc_is_pseudo_mac(struct enetc_si *si)
+{
+	return si->hw_features & ENETC_SI_F_PPM;
+}
+
 #define ENETC_MAX_NUM_TXQS	8
 #define ENETC_INT_NAME_MAX	(IFNAMSIZ + 8)
 
@@ -534,6 +540,8 @@ int enetc_hwtstamp_set(struct net_device *ndev,
 extern const struct ethtool_ops enetc_pf_ethtool_ops;
 extern const struct ethtool_ops enetc4_pf_ethtool_ops;
 extern const struct ethtool_ops enetc_vf_ethtool_ops;
+extern const struct ethtool_ops enetc4_ppm_ethtool_ops;
+
 void enetc_set_ethtool_ops(struct net_device *ndev);
 void enetc_mm_link_state_update(struct enetc_ndev_priv *priv, bool link);
 void enetc_mm_commit_preemptible_tcs(struct enetc_ndev_priv *priv);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 19bf0e89cdc2..ebea4298791c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -11,6 +11,7 @@
 
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
+#define NXP_ENETC_PPM_DEV_ID		0xe110
 
 /**********************Station interface registers************************/
 /* Station interface LSO segmentation flag mask register 0/1 */
@@ -115,6 +116,10 @@
 #define  PMCAPR_HD			BIT(8)
 #define  PMCAPR_FP			GENMASK(10, 9)
 
+/* Port capability register */
+#define ENETC4_PCAPR			0x4000
+#define  PCAPR_LINK_TYPE		BIT(4)
+
 /* Port configuration register */
 #define ENETC4_PCR			0x4010
 #define  PCR_HDR_FMT			BIT(0)
@@ -193,4 +198,29 @@
 #define   SSP_1G			2
 #define  PM_IF_MODE_ENA			BIT(15)
 
+/**********************ENETC Pseudo MAC port registers************************/
+/* Port pseudo MAC receive octets counter (64-bit) */
+#define ENETC4_PPMROCR			0x5080
+
+/* Port pseudo MAC receive unicast frame counter register (64-bit) */
+#define ENETC4_PPMRUFCR			0x5088
+
+/* Port pseudo MAC receive multicast frame counter register (64-bit) */
+#define ENETC4_PPMRMFCR			0x5090
+
+/* Port pseudo MAC receive broadcast frame counter register (64-bit) */
+#define ENETC4_PPMRBFCR			0x5098
+
+/* Port pseudo MAC transmit octets counter (64-bit) */
+#define ENETC4_PPMTOCR			0x50c0
+
+/* Port pseudo MAC transmit unicast frame counter register (64-bit) */
+#define ENETC4_PPMTUFCR			0x50c8
+
+/* Port pseudo MAC transmit multicast frame counter register (64-bit) */
+#define ENETC4_PPMTMFCR			0x50d0
+
+/* Port pseudo MAC transmit broadcast frame counter register (64-bit) */
+#define ENETC4_PPMTBFCR			0x50d8
+
 #endif
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 82c443b28b15..498346dd996a 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -41,6 +41,16 @@ static void enetc4_get_port_caps(struct enetc_pf *pf)
 	pf->caps.mac_filter_num = val & PSIMAFCAPR_NUM_MAC_AFTE;
 }
 
+static void enetc4_get_psi_hw_features(struct enetc_si *si)
+{
+	struct enetc_hw *hw = &si->hw;
+	u32 val;
+
+	val = enetc_port_rd(hw, ENETC4_PCAPR);
+	if (val & PCAPR_LINK_TYPE)
+		si->hw_features |= ENETC_SI_F_PPM;
+}
+
 static void enetc4_pf_set_si_primary_mac(struct enetc_hw *hw, int si,
 					 const u8 *addr)
 {
@@ -277,6 +287,7 @@ static int enetc4_pf_struct_init(struct enetc_si *si)
 	pf->ops = &enetc4_pf_ops;
 
 	enetc4_get_port_caps(pf);
+	enetc4_get_psi_hw_features(si);
 
 	return 0;
 }
@@ -589,6 +600,9 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	struct enetc_si *si = pf->si;
 	u32 val;
 
+	if (enetc_is_pseudo_mac(si))
+		return;
+
 	val = enetc_port_mac_rd(si, ENETC4_PM_IF_MODE(0));
 	val &= ~(PM_IF_MODE_IFMODE | PM_IF_MODE_ENA);
 
@@ -1071,6 +1085,7 @@ static void enetc4_pf_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id enetc4_pf_id_table[] = {
 	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PF_DEV_ID) },
+	{ PCI_DEVICE(NXP_ENETC_VENDOR_ID, NXP_ENETC_PPM_DEV_ID) },
 	{ 0, } /* End of table. */
 };
 MODULE_DEVICE_TABLE(pci, enetc4_pf_id_table);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
index 71d052de669a..5ef2c5f3ff8f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
@@ -435,6 +435,48 @@ static void enetc_get_eth_mac_stats(struct net_device *ndev,
 	}
 }
 
+static void enetc_ppm_mac_stats(struct enetc_si *si,
+				struct ethtool_eth_mac_stats *s)
+{
+	struct enetc_hw *hw = &si->hw;
+	u64 rufcr, rmfcr, rbfcr;
+	u64 tufcr, tmfcr, tbfcr;
+
+	rufcr = enetc_port_rd64(hw, ENETC4_PPMRUFCR);
+	rmfcr = enetc_port_rd64(hw, ENETC4_PPMRMFCR);
+	rbfcr = enetc_port_rd64(hw, ENETC4_PPMRBFCR);
+
+	tufcr = enetc_port_rd64(hw, ENETC4_PPMTUFCR);
+	tmfcr = enetc_port_rd64(hw, ENETC4_PPMTMFCR);
+	tbfcr = enetc_port_rd64(hw, ENETC4_PPMTBFCR);
+
+	s->FramesTransmittedOK = tufcr + tmfcr + tbfcr;
+	s->FramesReceivedOK = rufcr + rmfcr + rbfcr;
+	s->OctetsTransmittedOK = enetc_port_rd64(hw, ENETC4_PPMTOCR);
+	s->OctetsReceivedOK = enetc_port_rd64(hw, ENETC4_PPMROCR);
+	s->MulticastFramesXmittedOK = tmfcr;
+	s->BroadcastFramesXmittedOK = tbfcr;
+	s->MulticastFramesReceivedOK = rmfcr;
+	s->BroadcastFramesReceivedOK = rbfcr;
+}
+
+static void enetc_ppm_get_eth_mac_stats(struct net_device *ndev,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	switch (mac_stats->src) {
+	case ETHTOOL_MAC_STATS_SRC_EMAC:
+		enetc_ppm_mac_stats(priv->si, mac_stats);
+		break;
+	case ETHTOOL_MAC_STATS_SRC_PMAC:
+		break;
+	case ETHTOOL_MAC_STATS_SRC_AGGREGATE:
+		ethtool_aggregate_mac_stats(ndev, mac_stats);
+		break;
+	}
+}
+
 static void enetc_get_eth_ctrl_stats(struct net_device *ndev,
 				     struct ethtool_eth_ctrl_stats *ctrl_stats)
 {
@@ -1313,6 +1355,25 @@ const struct ethtool_ops enetc_pf_ethtool_ops = {
 	.get_mm_stats = enetc_get_mm_stats,
 };
 
+const struct ethtool_ops enetc4_ppm_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_MAX_FRAMES |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,
+	.get_eth_mac_stats = enetc_ppm_get_eth_mac_stats,
+	.get_rxnfc = enetc4_get_rxnfc,
+	.get_rxfh_key_size = enetc_get_rxfh_key_size,
+	.get_rxfh_indir_size = enetc_get_rxfh_indir_size,
+	.get_rxfh = enetc_get_rxfh,
+	.set_rxfh = enetc_set_rxfh,
+	.get_rxfh_fields = enetc_get_rxfh_fields,
+	.get_ringparam = enetc_get_ringparam,
+	.get_coalesce = enetc_get_coalesce,
+	.set_coalesce = enetc_set_coalesce,
+	.get_link_ksettings = enetc_get_link_ksettings,
+	.set_link_ksettings = enetc_set_link_ksettings,
+	.get_link = ethtool_op_get_link,
+};
+
 const struct ethtool_ops enetc_vf_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES |
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 377c96325814..7b882b8921fe 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -378,6 +378,7 @@ enum enetc_bdr_type {TX, RX};
 #define EIPBRR0_REVISION	GENMASK(15, 0)
 #define ENETC_REV_1_0		0x0100
 #define ENETC_REV_4_1		0X0401
+#define ENETC_REV_4_3		0x0403
 
 #define ENETC_G_EIPBRR1		0x0bfc
 #define ENETC_G_EPFBLPR(n)	(0xd00 + 4 * (n))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index edf14a95cab7..9c634205e2a7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -109,7 +109,7 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 
 	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
 			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_VLAN_CTAG_FILTER |
 			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
 			    NETIF_F_GSO_UDP_L4;
 	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
@@ -133,6 +133,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 		ndev->features |= NETIF_F_RXHASH;
 	}
 
+	if (!enetc_is_pseudo_mac(si))
+		ndev->hw_features |= NETIF_F_LOOPBACK;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si))
 		goto end;
-- 
2.34.1


