Return-Path: <netdev+bounces-233756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026EFC17F94
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8071C66EAE
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E62E9ECA;
	Wed, 29 Oct 2025 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XBXnbfmc"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013029.outbound.protection.outlook.com [40.107.159.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF12E9748;
	Wed, 29 Oct 2025 02:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703274; cv=fail; b=gaTz4nw6wcMyHebI6jW4eGkEPOhhcxWKrYUuH7fAFTeSoyJGeTZRrGHoPZ/ZlfydXWp2FC/fU2ezleBILORVnmXPjkGkk4O8FAMygl+F/3ivaID9YRrKK8UEULXqOfMsY+Sm7dxOZsXbebhWNfYbL78Z0Ti4Qhvt1HVnHMbTKas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703274; c=relaxed/simple;
	bh=v+LGqaJDbaE4YQd5j1uIJhfEE4OuedcFLV6thO+nTs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V450KbGI/bLtSjJVO3DQ4mGz2fd7Us3l4xeyuVoHMgH55dM0MFVMkSeWzLfBiKMPI3uRKeqG6P9SJIe5I8B90mZXl8Q6sfRmHVa5XmCjzIORkPgGd3E5EKVdE8ClEqpE17fU1a8sFGKS+gbhDNw2zi3C/VZUPL+E1iMbCEUl3Nc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XBXnbfmc; arc=fail smtp.client-ip=40.107.159.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFJnxTw+g4NNH01ZRfbGfwv26SvnLbRbm+LQ8pTnESwqxa02MhlnWTB7t5ABI+1Ldg6qerj8yRcq+F29RU0lrqzmDEjEH4OS006vmJzZZA5usw+270jEb60pPzl8eazKqW89cszax+wh+byu1uW0VQst1d+aU1k8EjHyzuXY6oBD2WeRXJXVlsK+P1hqLe7NmhkQsWc9Ct7wjgbW19fe5KlydY/rIvA1EE4DfFYo39mMBZVCmVty0p9Tky7bH9V6bgsWyE7QBhOF+aZZ52uhXbsE+YOt0HQOg2c6DAZvSiHn8fOt26fhmJfWg1qBoT2FIFi7owAATaNeBinmvBBr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=FYCiWv2+DKtGhZWBaLBKPdRlEoHS/sFRIvOdvVlaAeqwMSFqoG24mbBxRCe7PH0yZp0zTAWyo7wp5EjripV2sJLLXUroEAT+vgOHS614c/x1Vbs1FJHzaIRAayejqFD7+eznBFqVZtANczSIaPAfaUQuSbN8d0WGrK90wM4PZNHlxXwk/ytf3yMJT6AJaAVMH+368eAJsp1G0ro5zIr8FShqcmHxndK04OUt/6TCbrcE0/0rV45/8Ik+0B21gtnavLMn8qVZPG1XbGFf8m2qSR3s6n0e1jaIZcsmvKqShG736gsir8SCH3brnFjiyN4joKbd91jRw4arb3CS0GY+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7L1QK0sOID1c4hot9AaVDS/DjDP4szS3yJcavVRnt4=;
 b=XBXnbfmcJwMGRxVw5XqqhGfZUyfA6H1oHWB8sOxqNlRk1Fx0evzb7UZL2dnDciVybsyZpBLAkVLjWbgGDb8KNmdo+hydyX4s+qdJtQglNh+AzyGaNZCqE1elvWraqtPjqFrtn9cee2LlrhMpjkWmchKpNl18VIjPkk2ECdxnH/AMh9A32prq4BKXJllHZFRsnctybKLzrXs9oAEYOiAlvnG4c59tusQQL3r1SdIdWYKJDOCLNMouixJEmGxyCat/tflgBt5WQcX9x4vp4cIC4DLmPoTTn29C9lLxn2yJcgTkVuSuBeVU1fsjRRylBwLajfY4r+/on7tJsL3HGRszkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU4PR04MB11315.eurprd04.prod.outlook.com (2603:10a6:10:5d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 02:01:09 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 02:01:09 +0000
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
Subject: [PATCH v4 net-next 1/6] dt-bindings: net: netc-blk-ctrl: add compatible string for i.MX94 platforms
Date: Wed, 29 Oct 2025 09:38:55 +0800
Message-Id: <20251029013900.407583-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029013900.407583-1-wei.fang@nxp.com>
References: <20251029013900.407583-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|DU4PR04MB11315:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a6a603-e328-4f6d-42a8-08de168f074d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+wr6T+YTggL9yGGnZrlbPGKImGW1LW7IntPQCaTssM0WCR0dKnpbE904GNY?=
 =?us-ascii?Q?SH/xU3WB+V26XjgXeMIGj044OnB53OVY0i/wNybt8SJZ0H+A6/+AdBNXSxDj?=
 =?us-ascii?Q?A0gfNaeIuOqdKkJP9R9e6pW5Q/t081tuJDnnwQVj+s2J6igr52ksHtLdYphA?=
 =?us-ascii?Q?Fh2Hkr3Ji+95lvFbPOS65kcDNBpo4dwFfIJuBFQznSScLywFlwysNaBnwjZY?=
 =?us-ascii?Q?lEe6Q7Jo6u9cZfna47yrMcFaPyzOV/iLJCe9HaMrnj+2raxcCSUc85xCfVcZ?=
 =?us-ascii?Q?yusNkDLzzdsewNzxsbt3A9Qx/KBKzQ0B6JKzxjbyWmHRmsDrHb8uDSsqCskl?=
 =?us-ascii?Q?ZHv7OXiG2UA24EdToLwP3M+bQa8keSK6SFWs+1r1qz6NR2jQQ5CSO8EpYlKc?=
 =?us-ascii?Q?R9uuH93Ir1ZvCjncbtTWcV0SSWpjFs82EDnAz8EIZSoSb24UiYF2Bf4fnfu6?=
 =?us-ascii?Q?MbFxLn6cYFz1/bfXHyyycPTfRueShG/B8ZdmfDPLEUAZ30K0m6eyILEt4NND?=
 =?us-ascii?Q?dK+ZgkQjxGX2pnHqG04F20lWv9dPloX/vVMqIFYvUKvDn16qXACH+nIY/Ydm?=
 =?us-ascii?Q?rHjiTF7LCTvSEMw3wJcp32LExMQVj0HICJzYa85HMa+PFsynFJktNorm9u18?=
 =?us-ascii?Q?6RP8DkQkAigDn/5X0+GFpfvM7GfMTZJChC6FAu1flypjEwQqNgsHfFHySkDE?=
 =?us-ascii?Q?PDlvjg8swIjvMIpyuXT7vKPDKk0UawssWYCb5kKqKuYWv4+WHLi6nLSHnCS1?=
 =?us-ascii?Q?72ADd5s6gUxHJgUYFX1GfpOcRovv+jesg/l4Vpv5FzRRAw3Ci9aDQDT2Te/m?=
 =?us-ascii?Q?bz5rpTGGA4JsY2Z1mkr+BBKM0lCHTy0b+0yvO4RKUs7+pS5JrTUBciX3ytUC?=
 =?us-ascii?Q?kpfDcFUo6evUWR2UdnY3o+rFHH8ldtHYSLwH8pCjtSxpHE5FzRicrEmHNkbL?=
 =?us-ascii?Q?75ylWBEtcLNsO8OkhDNV6NUpGd0gvI46h8dbnISzfPqs3qI4zR1xm+jbyQ2N?=
 =?us-ascii?Q?hfp5cooOQ8r7WeXupTidsmuWgoHCyZYhN5KUoxLEua5Fn10WlpZG2/VY+UrK?=
 =?us-ascii?Q?MLgV6Ud5oDpklosOciO2VxZlhl6lp3pef0Yv3tqBkeqotmqFVeIf2Uc3geZS?=
 =?us-ascii?Q?Wcczuyg/AGZjVFwIekaABwadeOY8n8+JcCviz54YTK26tyEL2Edni6yUXTiP?=
 =?us-ascii?Q?XwQPfQzbTe+6/Bcvh68fdKdCf/sCv0Hidz9bTuOViSAd0hz2xA1Xv46choTJ?=
 =?us-ascii?Q?lNTyyEba6SI2yJg7XXdcu9E3G3bTx9XuFo7ONXaIdjsb9uqnbeex8s1qtcKz?=
 =?us-ascii?Q?yo7zCKpYDcOZYzCmypBBhGmgaov9JUj76Dn1VV0ZwAdsUKtdOm6NNneCqqaM?=
 =?us-ascii?Q?8Gu2Cns6H1nElM9uep82VoJ7l2jjOepBnmq4pmuqm9krraPB5mlnxqeJV7SG?=
 =?us-ascii?Q?cFVbcFbDfedpI//Lab2p6q0zwhdJXSrD0o/iHkRBUOCsGHed+IhgxtL153dv?=
 =?us-ascii?Q?xRe/ZA8vsEohNC/Rql+TB4KRkxfYYH51gWgdtezJAzcS4tb2q1F5M3EYaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ol0O78t00wiq/Mk7ga1Bjdmc0K8yZAPwGUJ2BXcmLItKpbr+DUZffwWJE31D?=
 =?us-ascii?Q?szHL5aj0WegGqUFZqpVILb7eRHHThvMVwVAIO18V84qlE2L+tcNQOT2cW47g?=
 =?us-ascii?Q?NszhotOjYQCqfYETt/CgoSVJak8zstf7Hl605/KeMXwDr8ff8u8U3XhiJbAc?=
 =?us-ascii?Q?IQK8T+B+2PUjYBjhKFSVxKYjnHHezFi340cdXl5QvtY81ShIMjfzStKvMLR2?=
 =?us-ascii?Q?9IC083RK4LF/ov8/c7Yi5e8njSvPCYWQZdCxG02QUQazjLbB6tUaawN9/9rw?=
 =?us-ascii?Q?5C4dfolRq9z2wZWehALrt84yeczcNu9Pawswxtp58lp0ZYUL5IOe4F/Ae/li?=
 =?us-ascii?Q?G/cHS6c5m9eYeTWylKe8mW1Hri+/XbYhFOfAX3JsOKaBwM1luCiDZN4T7x3p?=
 =?us-ascii?Q?yfIAEKkEx4pQXcFQ3qTsNURvcVFCTzNNCvL+6VlIWwBZz/Gfnz6xK0ABwA1H?=
 =?us-ascii?Q?0uHc8A20mRjV+cr/asjFi3eaKw9TSXbBpfd107lamxAKCjbVRst9KT4NambQ?=
 =?us-ascii?Q?iU/bY/k/l0Tn4z6Hnfwz/VJk+7e+8VHHiTrMv0DKyCrV+2J8wLAmdQzQw9mc?=
 =?us-ascii?Q?2mN9k/BwZzd2iDuSFUeJn1Ki2QEY4sUA8g/bwn/2R99JBewwCNs8Vfp/j4RR?=
 =?us-ascii?Q?A4D5PjgpyzlI0s78frZOnrNmykTJ4OdsUOI17bhfL29jwf5gLCItZ+/9dC8i?=
 =?us-ascii?Q?hkrdTd2V+XOEqolak2q4WInCaT0tgNG8e0VxfWKr/KFZCW5zGO0c26Tb4Z08?=
 =?us-ascii?Q?h4biLPWs+e1eO11Y8H/ltLdWkyHgdenvvKiP2SSqp3luTrxiCTAlFT/7UipS?=
 =?us-ascii?Q?FwbuSGMuev7+SrRKclX2Kc7xg9Dx/PABTqWAQhvPpx5ZgFetuz9+vzyOVFbO?=
 =?us-ascii?Q?1IYYkRj/MGQoAHnEYfxa3j8rfQRTO0UveytpcxC+867QdmGZ0bkdO2aFyi36?=
 =?us-ascii?Q?uhZ8vMd34nikypx5NjBKdR+TE9wzSxrZLNbwEe1/83MHPr8sWD32DXYw+L2A?=
 =?us-ascii?Q?2Mxnyqm8aT4qq8pKY98Z9X1362SUV+SJEsCB/HJ8v0vuSeGG5HlSYKae8B2O?=
 =?us-ascii?Q?h0F14gW3sZfYEJ11eQ3YFz52P7veTAH+MUv85DS+qPkM1cbFpSRT0h2OrJQm?=
 =?us-ascii?Q?GQMwVs8sP3jBK1jf0uAmDqPCZarI4r2Rx5Cj2i4axOIZ011EoCunmjVBcVhr?=
 =?us-ascii?Q?Qi0c094UMMoYWziE5WFsMGX7fDaBiqDjbs63JfMfWWQIC/diiV95CaIeezdJ?=
 =?us-ascii?Q?QQbuoc31dTURKv6jNFhX9Ypzr/clJDmaux7TAAXiYk2EWM+8oim+xXhCmFUa?=
 =?us-ascii?Q?ZaoApcHeZBzw0HLeojXQK+J/Z2Lq7Hc1N5+GTPAvwV/LOgQB8Rc+EdtSZZSj?=
 =?us-ascii?Q?5Tzs+pjoNRvd6bgbDtIg3U1t8CauwEz+h7YpFKoZOBFciOA1L8sbNrrO0mPT?=
 =?us-ascii?Q?y6deTQ0e5gibGk6aqRm7w+d+rLSte8WxuBdxfw28vu16mgdLAvOR0ppC262Q?=
 =?us-ascii?Q?0uxjoOLc1klMX8tYCjvpOd6AnwdZ4g5Oerakhyd1/3FxXsTIZ/69OjcKxPAJ?=
 =?us-ascii?Q?IXJe09Rcj4SFC8RNNi13yzzuv5el4JN8AVyWFusm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a6a603-e328-4f6d-42a8-08de168f074d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 02:01:09.4561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tz3rH6wdH2WoqCiV4Gq0Gk28/QTTxc5HgVSM/ZmLOi693UqQPPd1tj0bIhAaBkFrH0YN3+XSWqDggZGZkj8qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11315

Add the compatible string "nxp,imx94-netc-blk-ctrl" for i.MX94 platforms.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
index 97389fd5dbbf..deea4fd73d76 100644
--- a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -21,6 +21,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - nxp,imx94-netc-blk-ctrl
       - nxp,imx95-netc-blk-ctrl
 
   reg:
-- 
2.34.1


