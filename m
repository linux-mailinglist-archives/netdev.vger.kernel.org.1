Return-Path: <netdev+bounces-151001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7539EC50E
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 07:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487DF284A5B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 06:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8702B1C68A3;
	Wed, 11 Dec 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g3ZO+Twc"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2055.outbound.protection.outlook.com [40.107.20.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71FA1C5F35;
	Wed, 11 Dec 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900057; cv=fail; b=rx0NIP27OwWgWFw3ciGzaede9rtY76LXcvubDpVXMAPk7b5U5U+KuTFRYfk0VaVn7SDcXheHJ2tsnkReCb+eaopQ24raU4C18EHCFGHj85T3NnrYZEgEHH35ZxCW9qbo/GwXVin/XqjP+GJd38jopbhHlq+j2ZxsEZapiP1UFTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900057; c=relaxed/simple;
	bh=E0b5d1t7ifrKI9eRpb1qN33rREfD3EXegMJd4Tjah6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pH4HPJV7VkGRoJJelmzk0qwSwPj9W73I8rfUw6id73rKPT/pz7tbsep6fhDYvx8IY2L1Nwxve+6lSps31N7+H6rkg6463j+WEz8v5rNdiwywS2Hjbbu+HY8wonAtEKOQb5GFqPZDDkIPAQeqWgUg/Xw4gHf3cRCT4qike4ySpiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g3ZO+Twc; arc=fail smtp.client-ip=40.107.20.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0nZLB2LzCS7eOFbIeFOKLaM19LGZ2IX2C+5oGjKKfgPm2Ylfd+hNEAnWI/SaBvnugCk1/4M7JzL4nwnzw2NglviffG3xT9ZrvZpJ7aFXGbJcX5WmNAXDCo4IJ10l3x7pa3rfGJ5fRp6ZuFNad2aE7wXzLEETQPLvDv/PXdzzB7ulcA9HSqBB2zxy+aEHAOByIz/nW+4v3QLJFzMAe51eNtK0XeE8K168G41/E7NX+SQ8969L+pMvsiNIJ9IJnBkun78FWC+22INcrEreNIEh1AHfwcsEMu7reQYt5S+iu1x6apJsggkdzKQt/NO/4wh+WStHpwc2M+Bt0IabF58HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXIuHrrJmtxWfBvspEgItbS+WW9KnTzgyG/V51XnT50=;
 b=P9FyYCaJmAPyyDlll6NI0Lo5M9OMrl5biwgU2TLmjeh2n/v1n5f5CwcC0Brqn3FbpYzm9cF+tLLdDqBJPZ4kMPmpHRpVxFxbz9WeY7jfaIjDKVFuqCkmtQL5wPVJnU/TKevdZSaKoonSZ5DkcgF5+a0c20AhqvzBhZdhN4qewznVizYowqvJZF8ct5ynRKd81io/a9rRBIyWXdD4JpHdlFW6Rw1OjZzexXTWOshF4wMNs/xv/X1Ei64ZWOTwvCI5Kno3HXSjas9Y6YzraZx2EQMM+tBf9duBvoVksWdgrIveiVmmT2A4OImxwkNhm9TFdkMmKvzfzcYEdKThHFAWxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXIuHrrJmtxWfBvspEgItbS+WW9KnTzgyG/V51XnT50=;
 b=g3ZO+Twc8lBK93PuMg7EsFdsEBPBgPz7mKNbbYVo8SmONALC5kpvgeniRf7bOV7TRWc1ZWqVc3oAPy4i3v7NCVkd4T0LwVIunTPmPO4Fdb0zXhlMHZ+dNEyFMN9IPX2w+DQYdyJSX07DSt09HhwND/NQCYzOqBjFc5aYQyRpGDmSyXpN3ZR3UIOpuhjBizxAWH0qwrxnJwCM56HDaYMb1yiqBpuXrutIISlAIZ4Qu1czeK7BfrnwPjGX8hZnRFkN0mBjYkcbriu2FovSyQl5nD9KTvdltMi0MSBb5B0eFIZK1c0IHA+IWnm63KWIPiMxH5SkHU4Ln+e4iTjxhKQKAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11042.eurprd04.prod.outlook.com (2603:10a6:150:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 11 Dec
 2024 06:54:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 06:54:11 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	frank.li@nxp.com,
	horms@kernel.org,
	idosch@idosch.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 net-next 3/4] net: enetc: add LSO support for i.MX95 ENETC PF
Date: Wed, 11 Dec 2024 14:37:51 +0800
Message-Id: <20241211063752.744975-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211063752.744975-1-wei.fang@nxp.com>
References: <20241211063752.744975-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0237.apcprd06.prod.outlook.com
 (2603:1096:4:ac::21) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11042:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2cb3b7-84f1-4fde-bd64-08dd19b09dfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pk/1bLveIffikwaTYp2GF1DaduVwAg6XwLg87VWB+8C75jjnYAtQ4ColNRdq?=
 =?us-ascii?Q?HypqvJ/RqHQ9vS+wLdDqs2gs+ZtVwWoF6Prl45giXGtEnR38P8kAeKWKSLQN?=
 =?us-ascii?Q?vuy/tTmoH4GwhBsCizcJ9Ij3iJ6vDSMMLRcybLIi5PMHQONIYPW7wQdO6ZhI?=
 =?us-ascii?Q?ztCvoE6e2VzV4veiLU5Hk9GT3Cu4Wkuoj4pRFEPN6IF8KMCoRaWxjcY8Eajd?=
 =?us-ascii?Q?+yGM+jIALrPHOzYHUofykePJ7a4JvZ7UaXDz2+oF5sb8mSmWVr+7c83w+guJ?=
 =?us-ascii?Q?J5eFQAqvViW6wm/0TyenY+yhYTYt3HSRsDF0bJSc07RmXl19udN8mbX6fSYX?=
 =?us-ascii?Q?IKl6X6bjAMz1267wtOsvLlueE0f461WYUDL4RXXhTP8gm2+PgyQ9lE01q6cH?=
 =?us-ascii?Q?68C5HOw226ZoduIEVbjQrRlTt0LprElwqpkwhMldo723sWODevvzxiWWOk9P?=
 =?us-ascii?Q?301UwJqYugxV72avNKws7f6mn2DYFp9gcwLvGSegYmOlKB0eU/Uah4YKqtYA?=
 =?us-ascii?Q?tLxQJaVkEdSlOsh2jnrni92YqRGvMtay+GKLLASHsjymkb6Om8tfBzvvJCVi?=
 =?us-ascii?Q?RHt7S8T+vjZlRYSvSNGZi4jAE93WsO0nrnMiXx1T1Kq+i19ERSr0AGOshmHu?=
 =?us-ascii?Q?Zfj5nTISTtkse8C5b8k3GQesElqweUW6c7OP5wO1rZ8qL6LcsiCgbqvzxEos?=
 =?us-ascii?Q?C3Uqz4IMVT+SptHSgk4jkQdfakoUvnVJ/Pid+hZWtCc+THBTcV8xqrgjbRu9?=
 =?us-ascii?Q?/2PHKR3qseIn6Q+jsRxGPoZQpc/B6ZQ6BEHz57HSvh2K/QHRBwWgvUMV+fhf?=
 =?us-ascii?Q?ag7uKoNY1Lf6Ts2c175oSxfBqSn0HH2ge0iRtSO2Mooqax0cdm6aKzAb1rhA?=
 =?us-ascii?Q?OQrAmBwB33Y6xa4SBpnqKskEGR6N7uBx9qE8mQkoB5UGbnhbyZoVGWrV1m5O?=
 =?us-ascii?Q?Ij6EYLYLICqlHRWtQRjzxfbwL6qeJT1uDNCqTlzyixkiasdSG9C5HRSkp5yP?=
 =?us-ascii?Q?Eeo8oN5L8SegYEh9ymgTjXzXLkDs/cuTPEY0rSWUtOQ9bq+UgmyTDfi13euv?=
 =?us-ascii?Q?Sd6pAh17Oo4zVY102BZC/TZ/wElpMRfzM+UFwsLPjcAIOLLZS/0UTMs9P2sR?=
 =?us-ascii?Q?iDps3YdGLvwUxWs7S/5/5Vv/8zmduocvcBmjI95NguvtDhybyCIQrENEtpMX?=
 =?us-ascii?Q?xmVhxoxozmsnypNPzp6UWcTJvxUInS7DgDpxVd5CqmyxyBqmsxDDBj/tdZzK?=
 =?us-ascii?Q?Me1F9Zzc1WzOrh2SUPaODMsDP5MYVJvU316faFZpxawAshy3wPyLSvP4QTCl?=
 =?us-ascii?Q?bfUK3761KQvMX1c/qQqheL5Pge3KUcTvE/TIXwKJZMM6tXZ/bM371lg+uy2e?=
 =?us-ascii?Q?rtwP6jtjOnfQGWqInLRJxkLqdAlaYth0fYPLYtuFipUcXN5YEBvZlDRFetMW?=
 =?us-ascii?Q?9bQOphzCsqY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4udc03qVORKpr1+KJr+lItU8l6Cy8YKP2tUXkKiMaYkkDRvD8xufkNqWPCwA?=
 =?us-ascii?Q?38gonUI2dNWDlzqLv6nrN6ShsilakkAFImxPMEd6OLm6bUIzSMcpUG84Eded?=
 =?us-ascii?Q?nY/afjiaV4zhGXWNqImnfBA3yHq/Kegmu3qDY7OMgmikwCl1tf2ryerlKN8i?=
 =?us-ascii?Q?rShw+PjKiecjCVOOQKPADkyXstAhhLnjpHN9HklKOoni4rVysrriYai7uaqL?=
 =?us-ascii?Q?LmX4keg+TikkA+bAtA+egcUBRjfFODXnsm7tTCQio3yFlXa4HdLDmXj+UfZx?=
 =?us-ascii?Q?7z36D3k+Gwtbj3pyWI359LrPnfdDxRgpY4E1tTjZmkqawDAZqceF9Xp3Cp9+?=
 =?us-ascii?Q?I7di8cNARn9soz98TGWDGoHxyESEaDVSDxRCnv7Sz2cfJK6CoxH9XodkBxZm?=
 =?us-ascii?Q?32bYKJ/ayVE9gswzqQkD5i5ftb8xWS4x1dOHCdPJHV17Qb2EI8Qv+hVmpRcl?=
 =?us-ascii?Q?ZR5bZy3lXNG8r/286vr+qOU5WMoTGFqIIHn76GbxFBFJdvkd8U2if69nJNG/?=
 =?us-ascii?Q?rIds9oZz0N4HrpdDSdR2VqOmJl0MEuuVU+gxxdHigerjs3ovSeoxJZEWEJKL?=
 =?us-ascii?Q?8Rif0Ft9EW0rJ7VZuzBqF+pWv+SJw8wBPUKPsUXC9cN4xoYOxTH6UW2SdxGw?=
 =?us-ascii?Q?JkX1Z3Zrs9tI+UejA0dz/Wk+GGH9lL8Kn3OHZY+kMkspDFXPfrakjLIJFBVb?=
 =?us-ascii?Q?3NnZDTgF60hOjg7vKYH6LgR6TLQsz3FNs5u1dGmaIdgTfmHVtGRbm6mot+Gt?=
 =?us-ascii?Q?UPnC8+sO+GNhfnWmf6Q/nJyBUava9bEwkM76glkrQbGfBH4ugBkbhZtGo3NG?=
 =?us-ascii?Q?uU2y3dufjAybgJQeBRtpPLX+UU651VJig9BBe+F+jKTF6DNPpP72q0Abj5QI?=
 =?us-ascii?Q?np5wjxdrK3jTtiJTbA2T6xcXteyGHBwvlxOzSFdLErywtMPZZYZVVep0uB8m?=
 =?us-ascii?Q?WEPRXA4EDrIcJasNPojt1eEVRKArLrwZvKCpfYBRwl0BAuhQ7+ZKpRtTd0aT?=
 =?us-ascii?Q?nUml522RImmWCZIeAb2G1XYlGiATsB47+tIeDuYNFUfDm2/0w+WTYQZIHclv?=
 =?us-ascii?Q?BrMd2D7iQKmx3qNNdfIOJgGr1gx3JykR0T1wRNu45xHDnT0MtLKk90xEeO87?=
 =?us-ascii?Q?2eLCPtOIYU6A3JWEreTu9KpPhau4gj3+LiemicANH/OI3qtI5gKGgYeHgG3e?=
 =?us-ascii?Q?+1ajQ12mcyAvao8CSGiPay/Fqwv/qPaLpJYKRIKI4G4cFsSxTB/GP21CBcX1?=
 =?us-ascii?Q?x71ZnW5VcKnyZ0LWbdBfLh9d1/jwNSr3KHM+twdmichy30E+U7IZ6RKL5kt6?=
 =?us-ascii?Q?GcjW8cWzkSwv/BDBDz+u7qEEtWXDOTZJ/Spx4fm27YAxsm1W0jBG5vNFUTOK?=
 =?us-ascii?Q?aEUETWzOqrrHXzmUrmt1bwqMLqZUAOEImWvgNITYUeYEwf+S0eR3+RH9fpGx?=
 =?us-ascii?Q?Hb9p4klcS1rnblZOWMQsPidADA+ydzyPMYLe5kM2rIcx9nkCmJ971YgeyT4t?=
 =?us-ascii?Q?ArBashtPhCuoJz/ClsymWBl6wdclaeepUMmETrObmBtg/DSi135uqds8vczC?=
 =?us-ascii?Q?nN/qsmefa9O7NuMfl+CQfeX7uLRaHJZmWb4bRLAj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2cb3b7-84f1-4fde-bd64-08dd19b09dfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 06:54:11.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXWR/zEuSI+DCakWOz1I154mZ+7LfGq+F6jXHXvUdDMpVgdvu54TRY2M6iOz8J+FQsAWV6Q4pAeEqtczIX+Aow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11042

ENETC rev 4.1 supports large send offload (LSO), segmenting large TCP
and UDP transmit units into multiple Ethernet frames. To support LSO,
software needs to fill some auxiliary information in Tx BD, such as LSO
header length, frame length, LSO maximum segment size, etc.

At 1Gbps link rate, TCP segmentation was tested using iperf3, and the
CPU performance before and after applying the patch was compared through
the top command. It can be seen that LSO saves a significant amount of
CPU cycles compared to software TSO.

Before applying the patch:
%Cpu(s):  0.1 us,  4.1 sy,  0.0 ni, 85.7 id,  0.0 wa,  0.5 hi,  9.7 si

After applying the patch:
%Cpu(s):  0.1 us,  2.3 sy,  0.0 ni, 94.5 id,  0.0 wa,  0.4 hi,  2.6 si

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2: no changes
v3: use enetc_skb_is_ipv6() helper fucntion which is added in patch 2
v4: fix a typo
v5: no changes
v6: remove error logs from the datapath
v7: rebase the patch duo to the layout change of enetc_tx_bd
---
 drivers/net/ethernet/freescale/enetc/enetc.c  | 257 +++++++++++++++++-
 drivers/net/ethernet/freescale/enetc/enetc.h  |  15 +
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  22 ++
 .../net/ethernet/freescale/enetc/enetc_hw.h   |  15 +-
 .../freescale/enetc/enetc_pf_common.c         |   3 +
 5 files changed, 302 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index f31b7e71ef97..aca679509d83 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -530,6 +530,224 @@ static void enetc_tso_complete_csum(struct enetc_bdr *tx_ring, struct tso_t *tso
 	}
 }
 
+static inline int enetc_lso_count_descs(const struct sk_buff *skb)
+{
+	/* 4 BDs: 1 BD for LSO header + 1 BD for extended BD + 1 BD
+	 * for linear area data but not include LSO header, namely
+	 * skb_headlen(skb) - lso_hdr_len. And 1 BD for gap.
+	 */
+	return skb_shinfo(skb)->nr_frags + 4;
+}
+
+static int enetc_lso_get_hdr_len(const struct sk_buff *skb)
+{
+	int hdr_len, tlen;
+
+	tlen = skb_is_gso_tcp(skb) ? tcp_hdrlen(skb) : sizeof(struct udphdr);
+	hdr_len = skb_transport_offset(skb) + tlen;
+
+	return hdr_len;
+}
+
+static void enetc_lso_start(struct sk_buff *skb, struct enetc_lso_t *lso)
+{
+	lso->lso_seg_size = skb_shinfo(skb)->gso_size;
+	lso->ipv6 = enetc_skb_is_ipv6(skb);
+	lso->tcp = skb_is_gso_tcp(skb);
+	lso->l3_hdr_len = skb_network_header_len(skb);
+	lso->l3_start = skb_network_offset(skb);
+	lso->hdr_len = enetc_lso_get_hdr_len(skb);
+	lso->total_len = skb->len - lso->hdr_len;
+}
+
+static void enetc_lso_map_hdr(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso)
+{
+	union enetc_tx_bd txbd_tmp, *txbd;
+	struct enetc_tx_swbd *tx_swbd;
+	u16 frm_len, frm_len_ext;
+	u8 flags, e_flags = 0;
+	dma_addr_t addr;
+	char *hdr;
+
+	/* Get the first BD of the LSO BDs chain */
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	/* Prepare LSO header: MAC + IP + TCP/UDP */
+	hdr = tx_ring->tso_headers + *i * TSO_HEADER_SIZE;
+	memcpy(hdr, skb->data, lso->hdr_len);
+	addr = tx_ring->tso_headers_dma + *i * TSO_HEADER_SIZE;
+
+	frm_len = lso->total_len & 0xffff;
+	frm_len_ext = (lso->total_len >> 16) & 0xf;
+
+	/* Set the flags of the first BD */
+	flags = ENETC_TXBD_FLAGS_EX | ENETC_TXBD_FLAGS_CSUM_LSO |
+		ENETC_TXBD_FLAGS_LSO | ENETC_TXBD_FLAGS_L4CS;
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	txbd_tmp.addr = cpu_to_le64(addr);
+	txbd_tmp.hdr_len = cpu_to_le16(lso->hdr_len);
+
+	/* first BD needs frm_len and offload flags set */
+	txbd_tmp.frm_len = cpu_to_le16(frm_len);
+	txbd_tmp.flags = flags;
+
+	txbd_tmp.l3_aux0 = FIELD_PREP(ENETC_TX_BD_L3_START, lso->l3_start);
+	/* l3_hdr_size in 32-bits (4 bytes) */
+	txbd_tmp.l3_aux1 = FIELD_PREP(ENETC_TX_BD_L3_HDR_LEN,
+				      lso->l3_hdr_len / 4);
+	if (lso->ipv6)
+		txbd_tmp.l3_aux1 |= FIELD_PREP(ENETC_TX_BD_L3T, 1);
+	else
+		txbd_tmp.l3_aux0 |= FIELD_PREP(ENETC_TX_BD_IPCS, 1);
+
+	txbd_tmp.l4_aux = FIELD_PREP(ENETC_TX_BD_L4T, lso->tcp ?
+				     ENETC_TXBD_L4T_TCP : ENETC_TXBD_L4T_UDP);
+
+	/* For the LSO header we do not set the dma address since
+	 * we do not want it unmapped when we do cleanup. We still
+	 * set len so that we count the bytes sent.
+	 */
+	tx_swbd->len = lso->hdr_len;
+	tx_swbd->do_twostep_tstamp = false;
+	tx_swbd->check_wb = false;
+
+	/* Actually write the header in the BD */
+	*txbd = txbd_tmp;
+
+	/* Get the next BD, and the next BD is extended BD */
+	enetc_bdr_idx_inc(tx_ring, i);
+	txbd = ENETC_TXBD(*tx_ring, *i);
+	tx_swbd = &tx_ring->tx_swbd[*i];
+	prefetchw(txbd);
+
+	enetc_clear_tx_bd(&txbd_tmp);
+	if (skb_vlan_tag_present(skb)) {
+		/* Setup the VLAN fields */
+		txbd_tmp.ext.vid = cpu_to_le16(skb_vlan_tag_get(skb));
+		txbd_tmp.ext.tpid = 0; /* < C-TAG */
+		e_flags = ENETC_TXBD_E_FLAGS_VLAN_INS;
+	}
+
+	/* Write the BD */
+	txbd_tmp.ext.e_flags = e_flags;
+	txbd_tmp.ext.lso_sg_size = cpu_to_le16(lso->lso_seg_size);
+	txbd_tmp.ext.frm_len_ext = cpu_to_le16(frm_len_ext);
+	*txbd = txbd_tmp;
+}
+
+static int enetc_lso_map_data(struct enetc_bdr *tx_ring, struct sk_buff *skb,
+			      int *i, struct enetc_lso_t *lso, int *count)
+{
+	union enetc_tx_bd txbd_tmp, *txbd = NULL;
+	struct enetc_tx_swbd *tx_swbd;
+	skb_frag_t *frag;
+	dma_addr_t dma;
+	u8 flags = 0;
+	int len, f;
+
+	len = skb_headlen(skb) - lso->hdr_len;
+	if (len > 0) {
+		dma = dma_map_single(tx_ring->dev, skb->data + lso->hdr_len,
+				     len, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 0;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	frag = &skb_shinfo(skb)->frags[0];
+	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++, frag++) {
+		if (txbd)
+			*txbd = txbd_tmp;
+
+		len = skb_frag_size(frag);
+		dma = skb_frag_dma_map(tx_ring->dev, frag, 0, len,
+				       DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(tx_ring->dev, dma)))
+			return -ENOMEM;
+
+		/* Get the next BD */
+		enetc_bdr_idx_inc(tx_ring, i);
+		txbd = ENETC_TXBD(*tx_ring, *i);
+		tx_swbd = &tx_ring->tx_swbd[*i];
+		prefetchw(txbd);
+		*count += 1;
+
+		enetc_clear_tx_bd(&txbd_tmp);
+		txbd_tmp.addr = cpu_to_le64(dma);
+		txbd_tmp.buf_len = cpu_to_le16(len);
+
+		tx_swbd->dma = dma;
+		tx_swbd->len = len;
+		tx_swbd->is_dma_page = 1;
+		tx_swbd->dir = DMA_TO_DEVICE;
+	}
+
+	/* Last BD needs 'F' bit set */
+	flags |= ENETC_TXBD_FLAGS_F;
+	txbd_tmp.flags = flags;
+	*txbd = txbd_tmp;
+
+	tx_swbd->is_eof = 1;
+	tx_swbd->skb = skb;
+
+	return 0;
+}
+
+static int enetc_lso_hw_offload(struct enetc_bdr *tx_ring, struct sk_buff *skb)
+{
+	struct enetc_tx_swbd *tx_swbd;
+	struct enetc_lso_t lso = {0};
+	int err, i, count = 0;
+
+	/* Initialize the LSO handler */
+	enetc_lso_start(skb, &lso);
+	i = tx_ring->next_to_use;
+
+	enetc_lso_map_hdr(tx_ring, skb, &i, &lso);
+	/* First BD and an extend BD */
+	count += 2;
+
+	err = enetc_lso_map_data(tx_ring, skb, &i, &lso, &count);
+	if (err)
+		goto dma_err;
+
+	/* Go to the next BD */
+	enetc_bdr_idx_inc(tx_ring, &i);
+	tx_ring->next_to_use = i;
+	enetc_update_tx_ring_tail(tx_ring);
+
+	return count;
+
+dma_err:
+	do {
+		tx_swbd = &tx_ring->tx_swbd[i];
+		enetc_free_tx_frame(tx_ring, tx_swbd);
+		if (i == 0)
+			i = tx_ring->bd_count;
+		i--;
+	} while (count--);
+
+	return 0;
+}
+
 static int enetc_map_tx_tso_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
 {
 	struct enetc_ndev_priv *priv = netdev_priv(tx_ring->ndev);
@@ -650,14 +868,26 @@ static netdev_tx_t enetc_start_xmit(struct sk_buff *skb,
 	tx_ring = priv->tx_ring[skb->queue_mapping];
 
 	if (skb_is_gso(skb)) {
-		if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
-			netif_stop_subqueue(ndev, tx_ring->index);
-			return NETDEV_TX_BUSY;
-		}
+		/* LSO data unit lengths of up to 256KB are supported */
+		if (priv->active_offloads & ENETC_F_LSO &&
+		    (skb->len - enetc_lso_get_hdr_len(skb)) <=
+		    ENETC_LSO_MAX_DATA_LEN) {
+			if (enetc_bd_unused(tx_ring) < enetc_lso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
 
-		enetc_lock_mdio();
-		count = enetc_map_tx_tso_buffs(tx_ring, skb);
-		enetc_unlock_mdio();
+			count = enetc_lso_hw_offload(tx_ring, skb);
+		} else {
+			if (enetc_bd_unused(tx_ring) < tso_count_descs(skb)) {
+				netif_stop_subqueue(ndev, tx_ring->index);
+				return NETDEV_TX_BUSY;
+			}
+
+			enetc_lock_mdio();
+			count = enetc_map_tx_tso_buffs(tx_ring, skb);
+			enetc_unlock_mdio();
+		}
 	} else {
 		if (unlikely(skb_shinfo(skb)->nr_frags > priv->max_frags))
 			if (unlikely(skb_linearize(skb)))
@@ -1798,6 +2028,9 @@ void enetc_get_si_caps(struct enetc_si *si)
 		si->num_rss = ENETC_SIRSSCAPR_GET_NUM_RSS(rss);
 	}
 
+	if (val & ENETC_SIPCAPR0_LSO)
+		si->hw_features |= ENETC_SI_F_LSO;
+
 	if (val & ENETC_SIPCAPR0_QBV)
 		si->hw_features |= ENETC_SI_F_QBV;
 
@@ -2102,6 +2335,13 @@ static int enetc_setup_default_rss_table(struct enetc_si *si, int num_groups)
 	return 0;
 }
 
+static void enetc_set_lso_flags_mask(struct enetc_hw *hw)
+{
+	enetc_wr(hw, ENETC4_SILSOSFMR0,
+		 SILSOSFMR0_VAL_SET(TCP_NL_SEG_FLAGS_DMASK, TCP_NL_SEG_FLAGS_DMASK));
+	enetc_wr(hw, ENETC4_SILSOSFMR1, 0);
+}
+
 int enetc_configure_si(struct enetc_ndev_priv *priv)
 {
 	struct enetc_si *si = priv->si;
@@ -2115,6 +2355,9 @@ int enetc_configure_si(struct enetc_ndev_priv *priv)
 	/* enable SI */
 	enetc_wr(hw, ENETC_SIMR, ENETC_SIMR_EN);
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		enetc_set_lso_flags_mask(hw);
+
 	/* TODO: RSS support for i.MX95 will be supported later, and the
 	 * is_enetc_rev1() condition will be removed
 	 */
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 1e680f0f5123..6db6b3eee45c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -41,6 +41,19 @@ struct enetc_tx_swbd {
 	u8 qbv_en:1;
 };
 
+struct enetc_lso_t {
+	bool	ipv6;
+	bool	tcp;
+	u8	l3_hdr_len;
+	u8	hdr_len; /* LSO header length */
+	u8	l3_start;
+	u16	lso_seg_size;
+	int	total_len; /* total data length, not include LSO header */
+};
+
+#define ENETC_1KB_SIZE			1024
+#define ENETC_LSO_MAX_DATA_LEN		(256 * ENETC_1KB_SIZE)
+
 #define ENETC_RX_MAXFRM_SIZE	ENETC_MAC_MAXFRM_SIZE
 #define ENETC_RXB_TRUESIZE	2048 /* PAGE_SIZE >> 1 */
 #define ENETC_RXB_PAD		NET_SKB_PAD /* add extra space if needed */
@@ -238,6 +251,7 @@ enum enetc_errata {
 #define ENETC_SI_F_PSFP BIT(0)
 #define ENETC_SI_F_QBV  BIT(1)
 #define ENETC_SI_F_QBU  BIT(2)
+#define ENETC_SI_F_LSO	BIT(3)
 
 struct enetc_drvdata {
 	u32 pmac_offset; /* Only valid for PSI which supports 802.1Qbu */
@@ -351,6 +365,7 @@ enum enetc_active_offloads {
 	ENETC_F_QCI			= BIT(10),
 	ENETC_F_QBU			= BIT(11),
 	ENETC_F_TXCSUM			= BIT(12),
+	ENETC_F_LSO			= BIT(13),
 };
 
 enum enetc_flags_bit {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index 26b220677448..cdde8e93a73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -12,6 +12,28 @@
 #define NXP_ENETC_VENDOR_ID		0x1131
 #define NXP_ENETC_PF_DEV_ID		0xe101
 
+/**********************Station interface registers************************/
+/* Station interface LSO segmentation flag mask register 0/1 */
+#define ENETC4_SILSOSFMR0		0x1300
+#define  SILSOSFMR0_TCP_MID_SEG		GENMASK(27, 16)
+#define  SILSOSFMR0_TCP_1ST_SEG		GENMASK(11, 0)
+#define  SILSOSFMR0_VAL_SET(first, mid)	((((mid) << 16) & SILSOSFMR0_TCP_MID_SEG) | \
+					 ((first) & SILSOSFMR0_TCP_1ST_SEG))
+
+#define ENETC4_SILSOSFMR1		0x1304
+#define  SILSOSFMR1_TCP_LAST_SEG	GENMASK(11, 0)
+#define   TCP_FLAGS_FIN			BIT(0)
+#define   TCP_FLAGS_SYN			BIT(1)
+#define   TCP_FLAGS_RST			BIT(2)
+#define   TCP_FLAGS_PSH			BIT(3)
+#define   TCP_FLAGS_ACK			BIT(4)
+#define   TCP_FLAGS_URG			BIT(5)
+#define   TCP_FLAGS_ECE			BIT(6)
+#define   TCP_FLAGS_CWR			BIT(7)
+#define   TCP_FLAGS_NS			BIT(8)
+/* According to tso_build_hdr(), clear all special flags for not last packet. */
+#define TCP_NL_SEG_FLAGS_DMASK		(TCP_FLAGS_FIN | TCP_FLAGS_RST | TCP_FLAGS_PSH)
+
 /***************************ENETC port registers**************************/
 #define ENETC4_ECAPR0			0x0
 #define  ECAPR0_RFS			BIT(2)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
index 09ee86d09170..5518c0dba1f1 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
@@ -28,6 +28,8 @@
 #define ENETC_SIPCAPR0_QBV	BIT(4)
 #define ENETC_SIPCAPR0_QBU	BIT(3)
 #define ENETC_SIPCAPR0_RFS	BIT(2)
+#define ENETC_SIPCAPR0_LSO	BIT(1)
+#define ENETC_SIPCAPR0_RSC	BIT(0)
 #define ENETC_SIPCAPR1	0x24
 #define ENETC_SITGTGR	0x30
 #define ENETC_SIRBGCR	0x38
@@ -554,7 +556,10 @@ static inline u64 _enetc_rd_reg64_wa(void __iomem *reg)
 union enetc_tx_bd {
 	struct {
 		__le64 addr;
-		__le16 buf_len;
+		union {
+			__le16 buf_len;
+			__le16 hdr_len;	/* For LSO, ENETC 4.1 and later */
+		};
 		__le16 frm_len;
 		union {
 			struct {
@@ -578,13 +583,16 @@ union enetc_tx_bd {
 		__le32 tstamp;
 		__le16 tpid;
 		__le16 vid;
-		u8 reserved[6];
+		__le16 lso_sg_size; /* For ENETC 4.1 and later */
+		__le16 frm_len_ext; /* For ENETC 4.1 and later */
+		u8 reserved[2];
 		u8 e_flags;
 		u8 flags;
 	} ext; /* Tx BD extension */
 	struct {
 		__le32 tstamp;
-		u8 reserved[10];
+		u8 reserved[8];
+		__le16 lso_err_count; /* For ENETC 4.1 and later */
 		u8 status;
 		u8 flags;
 	} wb; /* writeback descriptor */
@@ -593,6 +601,7 @@ union enetc_tx_bd {
 enum enetc_txbd_flags {
 	ENETC_TXBD_FLAGS_L4CS = BIT(0), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TSE = BIT(1),
+	ENETC_TXBD_FLAGS_LSO = BIT(1), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_W = BIT(2),
 	ENETC_TXBD_FLAGS_CSUM_LSO = BIT(3), /* For ENETC 4.1 and later */
 	ENETC_TXBD_FLAGS_TXSTART = BIT(4),
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 00b73a948746..31dedc665a16 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -123,6 +123,9 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	if (si->drvdata->tx_csum)
 		priv->active_offloads |= ENETC_F_TXCSUM;
 
+	if (si->hw_features & ENETC_SI_F_LSO)
+		priv->active_offloads |= ENETC_F_LSO;
+
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
 	if (!is_enetc_rev1(si)) {
 		ndev->hw_features &= ~(NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK);
-- 
2.34.1


