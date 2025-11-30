Return-Path: <netdev+bounces-242797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A7CC94FED
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C86244E1110
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E9E221F11;
	Sun, 30 Nov 2025 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DV4p3/uf"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010044.outbound.protection.outlook.com [52.101.69.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9A6274B5C
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508661; cv=fail; b=LUyB/UZtBlxG0vDGBfW3cSzfRQzIZ0jSGRW7hg8Ib26i/GpKWqDeLpmqHo1aVdhZC9Gdsj3ZD3R9wbp5uWo0INxi0shmblYNLkXIhE0N65/NGYGUoHETVmPMzQb3pcF2vfW63WRt+hKHCrwzpZ6hmGeARA6CjnPmk2Tjk0Jzo0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508661; c=relaxed/simple;
	bh=OHKCiLetENJb+RZQBglgOk8ruZN94P8QSYK3dyvcSmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhAryriO5FsUdNi+HZ2LsQ/HnH7U0rdUIFVyIp5CnTm9rcXnlcR4PYZu9Se32GD0DWcCQH8KhOYFo2U5yaAiZRqUZu6AdTmyEpvDrfHJYFUTs4KTkJq7pV1YkGnXVyCNsddQYo1wQ09jK/X7xXQ2kJx5hp9UeSNdhuS273Cvnyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DV4p3/uf; arc=fail smtp.client-ip=52.101.69.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrvN9UMTezMui5ocn5UdDg1EH3AdeTAsa9xmdO8B2b0XO0SrrpIOrWRWYHxbDFO3pW2YpBl5Qj4Sf8g3cD9bXUKQCcqOk6pwCcuBzxUNQnzjPfvY0afrBnusdd8ubR8r4Mi5b6hgH4ARR3wswAvaY9kXzSmTZqXhRe3n+9O0FkOy8ASxRtaN7E+crtHK+0KvAk03A6ylTr4xP4tnL9Mqis5xMPg/JnUbbPztyZmJ2oOoHKKuk/2D0asPw5J40NnhMK563vC4QD9hHvoVq2zU1Yngtw2kWrQ3oSiJr5pjuxgf1oE/AVqSCOUaGg5iNEJIc8sQmyQhZ55jImvSAyAtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+ZrPx3dwXskg0FnKPycBiphaAgO2lLhz23mXaonAOA=;
 b=Jr1USFxvKdL/u5YCvG3bVGxq/+Eh0+i4NfOYiZlwu1NZJmu70hMri1NsA9/jI5YPhg1JXs0XSLLlEXTpFMeEMAmqyDeCAiG4u+/jXWcG0EkUQBcjHFVhCKPfZRBJuMgfpQUhkiYfOJMIDpaG3JeLoJWG9o42ZuouMMnkJicD95QO48nXUQ9OsQHr5Qt8lXsLNfY9UcU8vb2EabT1zMeQ8fyPBrgKeEQRy/O4QVdGUULn9OwAfgTgoK3jZ0psLncmF0bxB85TS6KxBXKLydr6/Nygp/XTNcOWeUtB/N6Wd1c1XE3r1EOv66EvUQVgf+KXhNGRsnoonht5d15LgZRhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+ZrPx3dwXskg0FnKPycBiphaAgO2lLhz23mXaonAOA=;
 b=DV4p3/ufrZTWc+3IKXIPJNEd78Cwms/EYpeERrnHQPwc18Yk+7PsC2GCdBBz7/dWI9fX2kEPNnHHN4LXnECe9qyrgNCGfqf83LQCpH9OnTAcom74oxwDjvrSE3FjWBbc7RWbfCVFbBHZ1/ALp37kYGzWR0Q3jUwm61btwMlA6wdCvKQNzjc38LW+xw/CVLxF73GnHtHG1lKnKsln1zUKcQBf5TWtGafiUd6I7DC3b+sGilw18W6IuaUabJ2y/9HmIomv1G6wwnC3c0fxVL4CEPTk8VNz9olkCIEHBaccIL7pCTmexU2XTajYcJ1HBCVKep89RehMxyM/m3fB9Etltg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:33 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:33 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	George McCollister <george.mccollister@gmail.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH net-next 04/15] net: dsa: xrs700x: reject unsupported HSR configurations
Date: Sun, 30 Nov 2025 15:16:46 +0200
Message-Id: <20251130131657.65080-5-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ac62eca-65d4-4241-a2f8-08de3012d250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgyYJQeFgafamdY6LzjqJUcY1YZ+lHzn3ajKON8UyXBBnYX/Sevd/JTHw9q6?=
 =?us-ascii?Q?CfyqKxFnljT0tl9I5ezUycXOLhCzA9XtotBDSoUQKZsht5Kx5gqhfs5HdLrp?=
 =?us-ascii?Q?ZdUdUg6PmLXz3Ah0HLdiKpMpYFn56HlMEVQ9XWgcWmV1ang6CBEYkIq36DXR?=
 =?us-ascii?Q?1upMDXXIK2LvIDfOYebZKlyUfT1gU8vTu5I/LTnhGMRgrOZ33dLkKsRIJ3zK?=
 =?us-ascii?Q?JCWDCkDZoMt9tKBf/eJq4pH1Q/gkUnUxILluSYmSBEtFqc3vucNeUWcIKYGQ?=
 =?us-ascii?Q?KIZXISfVstXskTbZtVFNAyRB/H81hjb8OiVcCNvms1w8gR8HMOupU3geJM4l?=
 =?us-ascii?Q?hOKco/vh15hxKvefjuH7WZ4GlqXLav6Fw2TJmwR8rB6ME9iGdpN/3BgVO+Xh?=
 =?us-ascii?Q?qbjX5CKc/5UK/B2YRgP/EzRE0T3C2gkZnorsJng+aBaMpIXxuKk3BtmhFF2I?=
 =?us-ascii?Q?3+/aWV1jYPD2FSHbjbuMHoENk6lYEMNSxZRZpdKqV7mu+Eme5kMt/nhUguP/?=
 =?us-ascii?Q?V1aSjSSIUrLyOIjHSXaHF+qT78/4cxp+oXrUF4teKX3iCQK83TisZWB8vTA1?=
 =?us-ascii?Q?LjeEDcmIGUhIDX9kGi8ZCYADvWypBEGPf1shTizLav8OSUQuXYJ5ZC98aKz6?=
 =?us-ascii?Q?kG3id/A2U2h+VJetduD+PBwupvbDhwEmQA+lxrFTI88Ng98/E/e3QzHQYHKj?=
 =?us-ascii?Q?H9xNadhy8LpGsBBv/Uey8xFWwRadiKZGxrYl8mScswtA9e72fVhrZhunQ0lx?=
 =?us-ascii?Q?iLczxDGa8b+nV97bL9ApP6Bc5qwBv5IdmnIhFA4BA7Vr7MANwfDt8ASdnwCE?=
 =?us-ascii?Q?m0JP3/h/eClG1vhK7mSBrn6dKuDQcl5SGLmiZzcCAl8YlLQF+24WzxIQjGsP?=
 =?us-ascii?Q?i0xplo6iin+tIZC3Cq5msgavfxM6mfCx1Oz/lc+5fH12e/dOvb4D/vaTIi7K?=
 =?us-ascii?Q?rcWJ5gtPXfRczdwAltifX8Z3T/RGzsTwWv33h/4jb/I3QowgwgdYNO7ujrPD?=
 =?us-ascii?Q?qURdhoVUlUb+JBnz2y9jOHBSkQotxT8A1VpkNIQPLs7q97069Sn08sEUS5Zo?=
 =?us-ascii?Q?14JsESoAROtbHcRsALy4W114d+2aBCQU48BRWCGZvVpS3upu+L4BmboaLZDr?=
 =?us-ascii?Q?hWoOlAeM/8MIwoo3Q/f5D4Q2l4PbBkdkMtboHsRfWNWRt6KTDN2bNXP1AuLf?=
 =?us-ascii?Q?DcIxGI+CVZkvuAutjm1f5kc3kCAK+eCOBod6WqNEHJNzKGxVaMOiiVoo0UU9?=
 =?us-ascii?Q?yk9qmtU54Hr8rv3Lp/g5LC1btbsBo3iQJpngLSSf8xRkxaENW+agmTLpyD5V?=
 =?us-ascii?Q?WDv8nW7oGqb2+YspscI1JNlWt+U+yWm3xPTaGL8fknolUtTkGvC3fNaJPW0u?=
 =?us-ascii?Q?jWogQAgQgb53DRwzAtU69leWIDx6Ir3JqGUKsX1cquo23W0GT90QWupzWuxA?=
 =?us-ascii?Q?VzKJ6g/GH5tjhzt/BGUPOtyq7kSZgLxr/SiDawNPD7hLxk2SKSQjTnj0zRqX?=
 =?us-ascii?Q?Mep1gnjqSqsNYpWjm0ROIwtvoKxpmh3wC1Hr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fI2qcmPh797EO2pE+pjfTxOIzGgy7GCBbhXDig1vmXPuPO7Vez0eWa5PS6De?=
 =?us-ascii?Q?zgzURor2HQyb34DjofBcYzXK9BY9EQoqkeQ8HHP0GM65wHF2XdaN7kkihtwh?=
 =?us-ascii?Q?BxtzjjWTFgK4vj9ycok7PU3TAb4KooSoZ6Frr1o0aa480lig1wn3o0sShILA?=
 =?us-ascii?Q?ub7dyjSEzMpiBVUnU2nr9cVKggYGZYOfl5UbD0MSo7CkW4b/OI/ZHNXuPtA0?=
 =?us-ascii?Q?7MNBvn3hWxKCipZ+xElD0dTkbpVPQOgrQp0Jq69JJPkRrxDf2PW/3GC8ekWM?=
 =?us-ascii?Q?R9qULdug5Dz9SltAHWr3n4WqN1kbnegcTcr5l3s1s3J/VQSRJFkfBQqJFKpQ?=
 =?us-ascii?Q?5qCVFnXsmqR2TIFag2s3gID6xMrkDNsrgJxjq9Q74r7qyPcNGNe9sBpQdnfv?=
 =?us-ascii?Q?/2odKJJ7aOyxlcIy/hZ8II1JfxKPkz1UUD3JIRq2KCQ80CQauoydU3uUCP45?=
 =?us-ascii?Q?rvGiS4KjUqRfNeVgbSJ8xH4/a1NiLcEyDjKrArdDauR6NdjNLqV9peMoNYVp?=
 =?us-ascii?Q?56fOXXV4mhlVcUPZgpYqGEqChjE2IiKTB1yjHROQwPEOPkZn6UfYd6Jofjk1?=
 =?us-ascii?Q?OBl0fuwc/rT87ZPG2Zc4kdIEwBANor2C+OV3TIOrgrU+zLZvXcSX2AlkMPaW?=
 =?us-ascii?Q?jt5MHjxtzMT22pcWeTe4qLLnsRnq17Dg1T0C/ayBADTFRfpUPAwMzBHthhVM?=
 =?us-ascii?Q?2S0qPYbp/3kIIJq1FD+K4X6J8LqyJkdPKS9gotlqCYd5WrxDjdrKCBav3UOJ?=
 =?us-ascii?Q?r397+0fOOv4jW6OC/kUXNWF4GW2FLYuQyJ3q/JbkMOwlUUh68+o6B5QqjhKi?=
 =?us-ascii?Q?ZmwpgiQ1hm8xujQeWoBqAmFOZeyDk2xAwa5m3TlSmYy6PaEMJfwCoHScuits?=
 =?us-ascii?Q?+waCuqUGVbmqyjiXJDtYwHwSnJh6CB2RcLMYBl7M2N2/qhtjXNRknbblPzHs?=
 =?us-ascii?Q?e942+42j2/tjs4ZLFcbBpIzOx0XxZN6GIcGhrvMPSwXoA3VGCILwqJqR7UUM?=
 =?us-ascii?Q?+QMCfyZRZ3Qgb72H1UT9Z/CEzMQkEQpj4RdbIbU7Yqv2QJCIE3Cqed9Dd0k5?=
 =?us-ascii?Q?sBmRC4U6etoVFZJYVSzE3yVhvFo4bgpr8L3EH+7CpbFPIUr9WRC0Jtj9FY3N?=
 =?us-ascii?Q?uHjz5h2KTTZkPa6mqfYk5371jS04S4vtM5BPG+BRn1r5Xkqr/JDcBJ2tXq8i?=
 =?us-ascii?Q?DO9N/mNhM09cfRiFuViLiHCfsTzjeSkkxGsrfMP/Pb7cFkZMbxvh8FQNiku8?=
 =?us-ascii?Q?7ispSVX3ct0GQCoXxpPDHqtqzCQZ+tvamNshj7dlUKhpmxspn0DTQLjCGNFq?=
 =?us-ascii?Q?V2eH8XU6GTA/g8dy2G/YOP2FPUVh9JIc6CWmPtgLHOg3MQPNGRk1MaSZ3jUy?=
 =?us-ascii?Q?JZGlHbR6YDmimDI6dBUO5hro+RxnjoQwR/wzTstBJ05BwGYQJ1ltsxdjo8SE?=
 =?us-ascii?Q?H+Uyv1m2jWrSAw3mXUL7/M+NNMumaJq35cxPrGDbUaQaAR9bt0ar3ARwTJy0?=
 =?us-ascii?Q?+FdCzdBJ8/ms2/g0fmj8z45mPP8Q2UBUof+D9V3oLdpx9M3Vmcy/ziHhd4H4?=
 =?us-ascii?Q?rgW6vx2SgMA9DVi5vQz/3nZpon/JrZScowzII2Tpjgm8Sn3nh5TBs/8BUX/X?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac62eca-65d4-4241-a2f8-08de3012d250
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:33.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DGl6m7XF6keyR+nsK3toEzwJfuvH0KrEpcsUI39CMjty8kDqxCwkiQTJjIu5vLdlDBHYO0MZqGnPsMA05Oezw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

As discussed here:
https://lore.kernel.org/netdev/20240620090210.drop6jwh7e5qw556@skbuf/

the fact is that the xrs700x.c driver only supports offloading
HSR_PT_SLAVE_A and HSR_PT_SLAVE_B (which were the only port types at the
time the offload was written, _for this driver_).

Up until now, the API did not explicitly tell offloading drivers what
port has what role. So xrs700x can get confused and think that it can
support a configuration which it actually can't. There was a table in
the attached link which gave an example:

$ ip link add name hsr0 type hsr slave1 swp0 slave2 swp1 \
	interlink swp2 supervision 45 version 1

        HSR_PT_SLAVE_A    HSR_PT_SLAVE_B      HSR_PT_INTERLINK
 ----------------------------------------------------------------
 user
 space        0                 1                   2
 requests
 ----------------------------------------------------------------
 XRS700X
 driver       1                 2                   -
 understands

The switch would act as if the ring ports were swp1 and swp2.

Now that we have explicit hsr_get_port_type() API, let's use that to
work around the unintended semantical changes of the offloading API
brought by the introduction of interlink ports in HSR.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Cc: George McCollister <george.mccollister@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/xrs700x/xrs700x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/dsa/xrs700x/xrs700x.c b/drivers/net/dsa/xrs700x/xrs700x.c
index 4dbcc49a9e52..0a05f4156ef4 100644
--- a/drivers/net/dsa/xrs700x/xrs700x.c
+++ b/drivers/net/dsa/xrs700x/xrs700x.c
@@ -566,6 +566,7 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 	struct xrs700x *priv = ds->priv;
 	struct net_device *user;
 	int ret, i, hsr_pair[2];
+	enum hsr_port_type type;
 	enum hsr_version ver;
 	bool fwd = false;
 
@@ -589,6 +590,16 @@ static int xrs700x_hsr_join(struct dsa_switch *ds, int port,
 		return -EOPNOTSUPP;
 	}
 
+	ret = hsr_get_port_type(hsr, dsa_to_port(ds, port)->user, &type);
+	if (ret)
+		return ret;
+
+	if (type != HSR_PT_SLAVE_A && type != HSR_PT_SLAVE_B) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Only HSR slave ports can be offloaded");
+		return -EOPNOTSUPP;
+	}
+
 	dsa_hsr_foreach_port(dp, ds, hsr) {
 		if (dp->index != port) {
 			partner = dp;
-- 
2.34.1


