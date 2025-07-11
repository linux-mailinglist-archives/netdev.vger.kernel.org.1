Return-Path: <netdev+bounces-206077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E5B01444
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E57E3B5318
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883901F4262;
	Fri, 11 Jul 2025 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bjE6sL23"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010010.outbound.protection.outlook.com [52.101.84.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1721F4177;
	Fri, 11 Jul 2025 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218262; cv=fail; b=n9zJQRw/QyJe1o+PV28mkgia7nKuHHwE5r2ztPcrftEQICqHc8vnzQwMz/U8gQiQ1xHjMaOBOtodS8Wbn3MXieehGzk5qbLZjPyzYtdVth3OH0u0gV/VLf9AkjUXlAmRruIlZKvozUN3AxvtICPQ7ltLe1jTsYyUOWOQ2TtMIgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218262; c=relaxed/simple;
	bh=+MszVhBph0akiEOThQGwwOG00p7YqLuiBdI31QVeUU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dytVgOGDqchhdoJTY71XxeRvqTgdKk4b3TGV6ba4YIBovUAbK0BGAUFTvsSo/+Ht/aDzdz5j1n0XqEq0DoYJq8iCp+FeId4bt9tuqTO8UnrlZgfiAjneLMHwDVxgeszT1rUOT3IVI+PDdX1nL7da1+SMQ8JvoTN/KZWmRK9YTZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bjE6sL23; arc=fail smtp.client-ip=52.101.84.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB8vE4IBXWp/w/9lkqW3vO61JURskHrvxf9UY1kklzOXpMyiUf5pHsr0jJ14GwHjjbJXkwphokqis1SyoGqKHVWCzod2bA2Rf7b0lOBiQEUt/HUhgnbaV1B/xENJkCLqPHuVoofYBh/9opiOQqCM3uDVA+V7tom6Ry8vekCd/8o00qHZBJvfQ5iwRHzfj+Qxx0eFwvNn2biPniMejxPVk0JC9HDdug8k4I54Rm2nGLuT1VYrsqkmrZ4YdOLoKPqd1tu3v+jwoJCITVLlEqjqE4Pw/57DfCIgyd/XQZfwLDFfgEpDsjaIyBZ0L5X2SJEHqRW+7iY8XHS7m+ILHN4FbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcuroD5TqVQUd8Sg4dZxeXYcnxjWf4Zdeqdi48xGIDY=;
 b=M2hu+kMYB92lzj/kj7VYt0E0m4LwyGAwaSP1vqa7MRHZg9xXSFEDLSTCIDwr8fCi7GSJCOEzBgkKIIFfkYJFVlvXKo1LRvPrernZE3jPSrRuaey4xm6D5kblhrcbzQ4x/a3loDb8UUEkNlF/vwPljzc4HRjmC4orl6Npr+Q71OERJILDswsrGZJx5JWDATIZr700e0RKES0quqCHAgBvYLxFNJ3rReVgREfttNlb235Xf8doYHj6EXlCaXkagh5vcIX/9GPkrC3zkgEM916MrQVpMiwOfL3rF7fUQWMQp2yc76FGLPklxS96+MSoL6la5PD+9pdAtIsuSFT0300q5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcuroD5TqVQUd8Sg4dZxeXYcnxjWf4Zdeqdi48xGIDY=;
 b=bjE6sL23c5JizXN5VtqirpCSqJk4zlkXeVKOwXXjYuQmNRJZFhsxY57siq1wpr1F8gJcFDQc1LTXwL+ZMebFTDUKgAq2m+QkYVb1eUlXvwvHeu3lDIH6HNLK0uL6fD7wVlo1WhRAsVbRmE5jspWzYWztwl2fE44CmPNTCKW45+nV9DGMWclr2Smgsqmlqx2EHWWN/gnIFgohgaaJIdKJyWavu9Yuents7/jIrzC0v714JBw878DaVNjUvwYy/GHmI4obWBTC9eZzY1bLJkPtoSHrst2z5BmzokDII6oXBuiwIZ7NrifHEr7QKhURu8QxEHosAFE63wPhoNj6RjV+RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11361.eurprd04.prod.outlook.com (2603:10a6:10:5cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 07:17:36 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 07:17:36 +0000
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
	pabeni@redhat.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net-next 04/12] ptp: netc: add periodic pulse output support
Date: Fri, 11 Jul 2025 14:57:40 +0800
Message-Id: <20250711065748.250159-5-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711065748.250159-1-wei.fang@nxp.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11361:EE_
X-MS-Office365-Filtering-Correlation-Id: af40c618-bba6-498d-aa03-08ddc04b02d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mRUXFtTZUqG8nA4TuCP9PIYD8WXHASedA9RbSx4fbUV70r68f/Bdb0uy6TC6?=
 =?us-ascii?Q?X1SAP5nTvUc2npL5yxFuRHC7sXHj/H+gdh+z1pnPA9VEiNoq1RfFhvkclhfe?=
 =?us-ascii?Q?yl9L/nFnogohLQSZ9yuoejlrWj2xqhdcTWStz43MHolB1KehKhGM3KHqYkZr?=
 =?us-ascii?Q?+PTgRUUTIkOwWpbEvy0/xTUgJQBhUVagNshJinkPFbdOQm4ieZr2qD75FFpE?=
 =?us-ascii?Q?L6zwrvHEn7/PvzTnTsOmuWGT7fuzdkos7fatjKNw7GWrFvbOmHldV9MSdE7R?=
 =?us-ascii?Q?DnUvVzhfRjVCG2mQvFAmAmhhFiMgCQStnZNw7yFoOy/nm4L88eDX1wso8ZrA?=
 =?us-ascii?Q?qg3iU7bN910eLYUMciwid1oPMaxnX7Wc9AELufz4CIYSHRoNSgGtLv3PRGn7?=
 =?us-ascii?Q?rK56sMhkAOgV/CcY/d1TIDCEZwiFR65RpEbXQl27PaMUlTVA1xTevjj6s/XP?=
 =?us-ascii?Q?hGM2uc1Ahdw1jfrpx9LrSfkSfEsnX4jm2vuAYa4Sq1/QrLHqHXTs2iGI1lWm?=
 =?us-ascii?Q?LOZPy59Wyt42C0445/rmTlaN+yBcpixg9Ticc0S7zJk3jR1bRNyVGYBYm6oY?=
 =?us-ascii?Q?dN/BbEa3M0TZnj2UdyJ47q8GCVM587/Ble1zFm6bJVs1lMx4AlAmhgpfEC0H?=
 =?us-ascii?Q?aFlocrFn69eac7wmEN6I5sxfEDSYrPDzFhSK4D9ibC8oox2+eoPkV7AS59s6?=
 =?us-ascii?Q?un3/IH/8LoaqXRVcgkvwfuY3Ew/numCzysPab0dXuTD/l9A09sONOsJ8pBGN?=
 =?us-ascii?Q?sKbq0hYhCz7ihv4xUpUnVaEJJL1L7c+adSQDWb2ZpZN3XcMm1DTYCXoOqX0J?=
 =?us-ascii?Q?twfiCbjKOePip15sYF8HlkjQEY6unrg7GjPUgcQrGxpPj1FPUQWhTkVJv9WX?=
 =?us-ascii?Q?9ayCR0wK3FNvcrKNPj7I5dLRun1c3RUNZqrl8fKfjvFU5Nl6Sci9xDLxmKhV?=
 =?us-ascii?Q?aO5ZDfVQ1kWjSV3O3x3ErKhCBcQPRf2E9m3EiO94cG32ahWF+QXlC+TCo3UB?=
 =?us-ascii?Q?68FV0NEpocv9Hw0tCCHHYBtHDzuBHOF9FR/gjPCV2mqT6r+pbMzoUoEYVRUQ?=
 =?us-ascii?Q?6LatOd0fSUso2v9BhlC7/bVU6elN6kFEf9ftdD8dZ4RJKrXhkaC1ao2w+eWI?=
 =?us-ascii?Q?jXrVAf9jETN3i5RXDEhYoKYVFZ+5Q+hwgwYC/wjF/OlOAdazFy2FqPCXC5iN?=
 =?us-ascii?Q?YBO713PUI6zYBqLOJbPbH0+Wxe9p2oPXIza8Ae4PuGDthUNmzNQO/f1khLwd?=
 =?us-ascii?Q?6nNhAUNx+OvnxhbMkRwFlDIVPG/dRNKUs81utkDw7dS4WbacocDUXZYCKEGH?=
 =?us-ascii?Q?qzn8XtTKQVkM34a4z6qznAKddYKVvt0ejolEqegAeSFmcT+cCWQV4JpCtpYV?=
 =?us-ascii?Q?+cjY//xmQ+yVbkCsaeriJufIWg7Yw+3c8+slXdqSkpTpgS9fTg2PUsxIkdd+?=
 =?us-ascii?Q?Dz9SiO4J7tmrIfkGs5VPUw+umCqBW8xfS+Xd8pEXjccjAO+ZV4IeP9utAfQB?=
 =?us-ascii?Q?qbkeOk5pT+8ZteY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJCXSYf7GFfofproaSZMA3ZZTmCFQ/6+NFF15cH5hFe/L6yx4h+ho7468V9F?=
 =?us-ascii?Q?T2gpahQ7XG2JH2iVPQEmQtnyW5cydotyAAT9RyDXTuqbqonEpk7R5tlDhw4e?=
 =?us-ascii?Q?p2w4aw395JAT3YPLt/rE2ECou6kwviig9GVkxFUQzIjGyCWn0oEVcyAzEo9P?=
 =?us-ascii?Q?c9vNDSaLwt3THMU/IL4QNMuw3FbbYNrJdQO4z5dYrkbTQG8Mc+hvG+9xZK0F?=
 =?us-ascii?Q?NIVzJ/znpI/XcaKrGV/C3yz4JYwqDYMgwYkmX89azXxph5hz1QJsO/pEnMiI?=
 =?us-ascii?Q?e6MkQzWtaUqlGEBijIEmyBrNq9vbwxvYYpmLf+BKSfkeUczUPqUfhwX72oUH?=
 =?us-ascii?Q?uWlXi21FrDPnvVE1iCfE9b0ugVSn103ON0KJLhkDxJZlyrnaI7OkElv6lv0F?=
 =?us-ascii?Q?nQc87rLVLwp3zxJxHSORjC4X+ca/ftqT53Kju9P0WmA8msgqXx6Hukch1bBK?=
 =?us-ascii?Q?bYTBekOLJAWKc0+PtdWiSqgDHs9SXnujTzKMho9DLXHJzNPJViqeRN7+DZNJ?=
 =?us-ascii?Q?jbg2BlKDYu0n7jSB+AqWVxUfrxLN5bnvpxTwLWw9Iyg5g2BFxoLDWf4IAMJT?=
 =?us-ascii?Q?Jd0oCFI7rfJKfY1BxfOXvlMAbeLv2KqMLk7oUH04SdaCJ6tGCiE8upSLNyb4?=
 =?us-ascii?Q?FFmfkv0uQ/n7nimGPF/xoVz1xqZI2Vg/EYzGxfDPXOOkvWqcikbGIx16iqzC?=
 =?us-ascii?Q?QT+Q+863DQAo5G836d3yaxAPcRClc0Hj/aMR03smtV/kdmxRvP5PZqbFnIz0?=
 =?us-ascii?Q?UZhg9EF3ZVxNfHVbF2YmCbF3izDzGfdFAYMti/3Pd4NuaG01YdtRtd8jrf5a?=
 =?us-ascii?Q?cd8YNgGpj4S54lazzWAQwtG71rOH5jmTnkDTnVqTsTQH2hkImCpBZjYX9QXk?=
 =?us-ascii?Q?1O5XX+gBJoCEkLy6NCRxeF1+AnnlaXJXgJoOPvptoqQTiOvSntedYZbeQRVW?=
 =?us-ascii?Q?as1aATNYwJKL+jkv+rrpTLEpNREFFHxJhG3Y45h1tOLDOQXRiZQ5FO+/7Da1?=
 =?us-ascii?Q?t7ch/P7dLNSAhzgdS3c36tWmP6J6VlJ0Mq5Clp57Fa7htDlGTQXOWeJzAazn?=
 =?us-ascii?Q?OTbNNMMY3pcuwbXVWI+ojI6m7bnI64wbz0qZOrvJeh+C5vkooDgfQa5SLRM7?=
 =?us-ascii?Q?LUYIyqeRicwxzO1QfTxpzRbi3GsXuTOEPDOnMDiFPeJ/0BB+nUF0SBb84DOn?=
 =?us-ascii?Q?NkiwaqAjIHKXAK8k7vK3MPmSycxf6SlFxNdldkPXt/hDhDNktRq3UGL39bHG?=
 =?us-ascii?Q?Otj7f0q1ANUdIxx7RggLhaFijNZH7j72nxqeXE2LtUoKift6vbQj0WjJgjHs?=
 =?us-ascii?Q?6+wIgkTUajqbni6fXSYIYaZZkY7UE9P09W12q+H/RS3htVJd5WERF6KqfKIb?=
 =?us-ascii?Q?leQ1UpuUZPvpvM4lf3l5q/ydhBWiPbrBKNQvWROpFj43YaoLCcK1Bjz8o3yM?=
 =?us-ascii?Q?O9nSHnlu/KyKjZYMUw9XE7n1K4eOGU9vP2I2/VhD7IJe3bbApDeGKbhC7fTb?=
 =?us-ascii?Q?Is8/nKFGXFiojsTj/WFEAoRYASDpXjxtDa68TEC2Hkfh5jBv5j6UHiP7NSGK?=
 =?us-ascii?Q?23u/TQKMP8sdwoCIYhYOHqxD6M9Ok1LrUvJyf3JR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af40c618-bba6-498d-aa03-08ddc04b02d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:17:36.3419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZswbI/Mp7ve+1zO0x3R4fHqwPueVPst/SRbVI7n03z2tcugz7Y7E9l9+gB1JuoYr4aqYxcFUEvTyujwUTqN9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11361

NETC Timer has three pulse channels, all of which support periodic pulse
output. Bind the channel to a ALARM register and then sets a future time
into the ALARM register. When the current time is greater than the ALARM
value, the FIPER register will be triggered to count down, and when the
count reaches 0, the pulse will be triggered. The PPS signal is also
implemented in this way. However, for i.MX95, only ALARM1 can be used for
periodic pulse output, and for i.MX943, ALARM1 and ALARM2 can be used for
periodic pulse output, but NETC Timer has three channels, so for i.MX95,
only one channel can work at the same time, and for i.MX943, at most two
channel can work at the same time. Otherwise, if multiple channels share
the same ALARM register, some channel pulses will not meet expectations.
Therefore, the current implementation does not allow multiple channels to
share the same ALARM register at the same time.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/ptp/ptp_netc.c | 281 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 250 insertions(+), 31 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index abd637dab83b..5ea59bb20371 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -54,6 +54,10 @@
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
 #define NETC_TMR_REGS_BAR		0
+#define NETC_GLOBAL_OFFSET		0x10000
+#define NETC_GLOBAL_IPBRR0		0xbf8
+#define  IPBRR0_IP_REV			GENMASK(15, 0)
+#define NETC_REV_4_1			0x0401
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
@@ -61,6 +65,7 @@
 #define NETC_TMR_DEFAULT_PPS_CHANNEL	0
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
+#define NETC_TMR_ALARM_NUM		2
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -69,6 +74,19 @@
 
 #define NETC_TMR_SYSCLK_333M		333333333U
 
+enum netc_pp_type {
+	NETC_PP_PPS = 1,
+	NETC_PP_PEROUT,
+};
+
+struct netc_pp {
+	enum netc_pp_type type;
+	bool enabled;
+	int alarm_id;
+	u32 period; /* pulse period, ns */
+	u64 stime; /* start time, ns */
+};
+
 struct netc_timer {
 	void __iomem *base;
 	struct pci_dev *pdev;
@@ -86,7 +104,9 @@ struct netc_timer {
 
 	int irq;
 	u8 pps_channel;
-	bool pps_enabled;
+	u8 fs_alarm_num;
+	u8 fs_alarm_bitmap;
+	struct netc_pp pp[NETC_TMR_FIPER_NUM]; /* periodic pulse */
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -195,6 +215,7 @@ static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
 static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 				     u32 integral_period)
 {
+	struct netc_pp *pp = &priv->pp[channel];
 	u64 alarm;
 
 	/* Get the alarm value */
@@ -202,26 +223,93 @@ static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
 	alarm = roundup_u64(alarm, NSEC_PER_SEC);
 	alarm = roundup_u64(alarm, integral_period);
 
-	netc_timer_alarm_write(priv, alarm, 0);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static void netc_timer_set_perout_alarm(struct netc_timer *priv, int channel,
+					u32 integral_period)
+{
+	u64 cur_time = netc_timer_cur_time_read(priv);
+	struct netc_pp *pp = &priv->pp[channel];
+	u64 alarm, delta, min_time;
+	u32 period = pp->period;
+	u64 stime = pp->stime;
+
+	min_time = cur_time + NSEC_PER_MSEC + period;
+	if (stime < min_time) {
+		delta = min_time - stime;
+		stime += roundup_u64(delta, period);
+	}
+
+	alarm = roundup_u64(stime - period, integral_period);
+	netc_timer_alarm_write(priv, alarm, pp->alarm_id);
+}
+
+static int netc_timer_get_alarm_id(struct netc_timer *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->fs_alarm_num; i++) {
+		if (!(priv->fs_alarm_bitmap & BIT(i))) {
+			priv->fs_alarm_bitmap |= BIT(i);
+			break;
+		}
+	}
+
+	return i;
+}
+
+static u64 netc_timer_get_gclk_period(struct netc_timer *priv)
+{
+	/* TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz.
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq.
+	 * TMR_GCLK_period = (NSEC_PER_SEC * oclk_prsc) / clk_freq
+	 */
+
+	return div_u64(mul_u32_u32(NSEC_PER_SEC, priv->oclk_prsc),
+		       priv->clk_freq);
 }
 
 static int netc_timer_enable_pps(struct netc_timer *priv,
 				 struct ptp_clock_request *rq, int on)
 {
+	struct device *dev = &priv->pdev->dev;
 	u32 tmr_emask, fiper, fiper_ctrl;
 	u8 channel = priv->pps_channel;
 	unsigned long flags;
+	struct netc_pp *pp;
+	int alarm_id;
+	int err = 0;
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PEROUT) {
+		dev_err(dev, "FIPER%u is being used for PEROUT\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
+
 	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
 	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
 
 	if (on) {
 		u32 integral_period, fiper_pw;
 
-		if (priv->pps_enabled)
+		if (pp->enabled)
+			goto unlock_spinlock;
+
+		alarm_id = netc_timer_get_alarm_id(priv);
+		if (alarm_id == priv->fs_alarm_num) {
+			dev_err(dev, "No available ALARMs\n");
+			err = -EBUSY;
 			goto unlock_spinlock;
+		}
+
+		pp->enabled = true;
+		pp->type = NETC_PP_PPS;
+		pp->alarm_id = alarm_id;
+		pp->period = NSEC_PER_SEC;
 
 		integral_period = netc_timer_get_integral_period(priv);
 		fiper = NSEC_PER_SEC - integral_period;
@@ -229,17 +317,19 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
 		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
 				FIPER_CTRL_FS_ALARM(channel));
 		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
 		tmr_emask |= TMR_TEVNET_PPEN(channel);
-		priv->pps_enabled = true;
 		netc_timer_set_pps_alarm(priv, channel, integral_period);
 	} else {
-		if (!priv->pps_enabled)
+		if (!pp->enabled)
 			goto unlock_spinlock;
 
+		priv->fs_alarm_bitmap &= ~BIT(pp->alarm_id);
+		memset(pp, 0, sizeof(*pp));
+
 		fiper = NETC_TMR_DEFAULT_FIPER;
 		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
 		fiper_ctrl |= FIPER_CTRL_DIS(channel);
-		priv->pps_enabled = false;
 	}
 
 	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
@@ -249,38 +339,150 @@ static int netc_timer_enable_pps(struct netc_timer *priv,
 unlock_spinlock:
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	return err;
 }
 
-static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+static int net_timer_enable_perout(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
 {
-	u32 fiper = NETC_TMR_DEFAULT_FIPER;
-	u8 channel = priv->pps_channel;
-	u32 fiper_ctrl;
+	struct device *dev = &priv->pdev->dev;
+	u32 tmr_emask, fiper, fiper_ctrl;
+	u32 channel = rq->perout.index;
+	unsigned long flags;
+	struct netc_pp *pp;
+	int alarm_id;
+	int err = 0;
 
-	if (!priv->pps_enabled)
-		return;
+	spin_lock_irqsave(&priv->lock, flags);
+
+	pp = &priv->pp[channel];
+	if (pp->type == NETC_PP_PPS) {
+		dev_err(dev, "FIPER%u is being used for PPS\n", channel);
+		err = -EBUSY;
+		goto unlock_spinlock;
+	}
 
+	tmr_emask = netc_timer_rd(priv, NETC_TMR_TEMASK);
 	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl |= FIPER_CTRL_DIS(channel);
+	if (on) {
+		u64 period_ns, gclk_period, max_period, min_period;
+		struct timespec64 period, stime;
+		u32 integral_period, fiper_pw;
+
+		period.tv_sec = rq->perout.period.sec;
+		period.tv_nsec = rq->perout.period.nsec;
+		period_ns = timespec64_to_ns(&period);
+
+		integral_period = netc_timer_get_integral_period(priv);
+		max_period = (u64)NETC_TMR_DEFAULT_FIPER + integral_period;
+		gclk_period = netc_timer_get_gclk_period(priv);
+		min_period = gclk_period * 4 + integral_period;
+		if (period_ns > max_period || period_ns < min_period) {
+			dev_err(dev, "The period range is %llu ~ %llu\n",
+				min_period, max_period);
+			err = -EINVAL;
+			goto unlock_spinlock;
+		}
+
+		stime.tv_sec = rq->perout.start.sec;
+		stime.tv_nsec = rq->perout.start.nsec;
+
+		tmr_emask |= TMR_TEVNET_PPEN(channel);
+
+		/* Set to desired FIPER interval in ns - TCLK_PERIOD */
+		fiper = period_ns - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+
+		if (pp->enabled) {
+			alarm_id = pp->alarm_id;
+		} else {
+			alarm_id = netc_timer_get_alarm_id(priv);
+			if (alarm_id == priv->fs_alarm_num) {
+				dev_err(dev, "No available ALARMs\n");
+				err = -EBUSY;
+				goto unlock_spinlock;
+			}
+
+			pp->type = NETC_PP_PEROUT;
+			pp->enabled = true;
+			pp->alarm_id = alarm_id;
+		}
+
+		pp->stime = timespec64_to_ns(&stime);
+		pp->period = period_ns;
+
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(channel) | FIPER_CTRL_PW(channel) |
+				FIPER_CTRL_FS_ALARM(channel));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(channel, fiper_pw);
+		fiper_ctrl |= alarm_id ? FIPER_CTRL_FS_ALARM(channel) : 0;
+
+		netc_timer_set_perout_alarm(priv, channel, integral_period);
+	} else {
+		if (!pp->enabled)
+			goto unlock_spinlock;
+
+		tmr_emask &= ~TMR_TEVNET_PPEN(channel);
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		fiper_ctrl |= FIPER_CTRL_DIS(channel);
+
+		alarm_id = pp->alarm_id;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, alarm_id);
+		priv->fs_alarm_bitmap &= ~BIT(alarm_id);
+		memset(pp, 0, sizeof(*pp));
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
 	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return err;
 }
 
-static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
-	u32 fiper_ctrl, integral_period, fiper;
-	u8 channel = priv->pps_channel;
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
 
-	if (!priv->pps_enabled)
-		return;
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl |= FIPER_CTRL_DIS(i);
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), NETC_TMR_DEFAULT_FIPER);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_fiper(struct netc_timer *priv)
+{
+	u32 integral_period = netc_timer_get_integral_period(priv);
+	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	int i;
+
+	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
+		struct netc_pp *pp = &priv->pp[i];
+		u32 fiper;
+
+		if (!pp->enabled)
+			continue;
+
+		fiper_ctrl &= ~FIPER_CTRL_DIS(i);
+
+		if (pp->type == NETC_PP_PPS)
+			netc_timer_set_pps_alarm(priv, i, integral_period);
+		else if (pp->type == NETC_PP_PEROUT)
+			netc_timer_set_perout_alarm(priv, i, integral_period);
+
+		fiper = pp->period - integral_period;
+		netc_timer_wr(priv, NETC_TMR_FIPER(i), fiper);
+	}
 
-	integral_period = netc_timer_get_integral_period(priv);
-	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
-	fiper_ctrl &= ~FIPER_CTRL_DIS(channel);
-	fiper = NSEC_PER_SEC - integral_period;
-	netc_timer_set_pps_alarm(priv, channel, integral_period);
-	netc_timer_wr(priv, NETC_TMR_FIPER(channel), fiper);
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
 }
 
@@ -292,6 +494,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 	switch (rq->type) {
 	case PTP_CLK_REQ_PPS:
 		return netc_timer_enable_pps(priv, rq, on);
+	case PTP_CLK_REQ_PEROUT:
+		return net_timer_enable_perout(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -310,9 +514,9 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
 	if (tmr_ctrl != old_tmr_ctrl) {
-		netc_timer_disable_pps_fiper(priv);
+		netc_timer_disable_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
-		netc_timer_enable_pps_fiper(priv);
+		netc_timer_enable_fiper(priv);
 	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
@@ -342,7 +546,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 
 	tmr_off = netc_timer_offset_read(priv);
 	if (delta < 0 && tmr_off < abs(delta)) {
@@ -358,7 +562,7 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 		netc_timer_offset_write(priv, tmr_off);
 	}
 
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -395,10 +599,10 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	netc_timer_disable_pps_fiper(priv);
+	netc_timer_disable_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
-	netc_timer_enable_pps_fiper(priv);
+	netc_timer_enable_fiper(priv);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -427,6 +631,7 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.n_pins		= 0,
 	.pps		= 1,
+	.n_per_out	= 3,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -671,6 +876,15 @@ static void netc_timer_free_msix_irq(struct netc_timer *priv)
 	pci_free_irq_vectors(pdev);
 }
 
+static int netc_timer_get_global_ip_rev(struct netc_timer *priv)
+{
+	u32 val;
+
+	val = netc_timer_rd(priv, NETC_GLOBAL_OFFSET + NETC_GLOBAL_IPBRR0);
+
+	return val & IPBRR0_IP_REV;
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -700,6 +914,11 @@ static int netc_timer_probe(struct pci_dev *pdev,
 		goto timer_pci_remove;
 	}
 
+	if (netc_timer_get_global_ip_rev(priv) == NETC_REV_4_1)
+		priv->fs_alarm_num = 1;
+	else
+		priv->fs_alarm_num = NETC_TMR_ALARM_NUM;
+
 	err = netc_timer_init_msix_irq(priv);
 	if (err)
 		goto disable_clk;
-- 
2.34.1


