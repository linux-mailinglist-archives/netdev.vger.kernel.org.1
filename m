Return-Path: <netdev+bounces-233052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A56EAC0BAAC
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5563BB8EE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472072C21F4;
	Mon, 27 Oct 2025 02:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfRGrpOM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE32C21CC;
	Mon, 27 Oct 2025 02:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530867; cv=fail; b=GWszI6Isl9c/skEXikrSmNpEwQgJzyXRKGA2/YaPoJuSEbInHPBhjlECysZEaSVkesma4Jl0VmcsxKSvphPRyPYFkk7Hw4qzZvkJzK10P9ImwxOYg+ySEKlVkX3VePG0J+0nl3XE2403/yRu77K5WbeRtozRP19An06NXTRA7/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530867; c=relaxed/simple;
	bh=FP1P/y7my8T/hNt4yjfAP01XbCJa0tIrY6oh+g6XmQI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6NpMqAq+5PVyZZ0iM5RQo270ookn967I7zWqdvXANjVAuo2XNaw31eCTaW2NEZeL3/YeuYpJssH2VSxz/OL5w97L7M+rtSlQ3NEj3dB0Iqbxtb3gNX7xt6BFG2f9wKmTlVjL3PG+yN5KoOAjHLuykvviIkP52s1y/17ogKigVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfRGrpOM; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy/WNdILCx4BrabdmM8GHV5AqmtQmCq5DC/Qd0lWyU9Xph9/rjXphnOOQr+UCb3swRGRVi50DLKuc1fNb8qCSaLH3Ce1iGwpzrXu12BDvCQ1aj9sCPYgW0EMo3Dyyb0AwCdwVF6Vcpvk7oBvGvwxfZAEOafgCH8wCyKYL1vZ/YiQn7xR8PxGMmujzAcN7zWq+slg5BPt/hKCa3XG2vPfFlG+w3TtvQFb5KFyXpjue7piKv//fvBCTgHq2/mcphCaaT+WmWQ/2P+xXI+V4pZzM7JymUFj3eUBPrhvDg2jqlXtUJjDvTIvfJVR8dtk6s7eCdRbPVUp5nwoTopf0vklwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=EHSQDUKb+k1/xkvBQkKwF4oX8z+a5wQdELQhUJ5UHpUOonHe8m25508BeDiVVJm7O1Pa32sxrD5zi5isCIRWhzBWTU/8s5es1ZBpZ+mWraIUmT0ANYg5rTaJeqaiYa8jAiMc3z4exaeUGrhaakKOw7jskPQd3rrk/DXb19WDGpO5DpWuYBMYU4vP3KcRfHL0p/kz/ZueKI4Svw50C4MF0Lwt3p0cZMtu8pPvKCphBi46D8tZRBW3gHsAHDiMqArLdZPFT0QNqFyu/5NTd+y4AOc/j+8OXf0KM+lWTzHygzwXmYUjPsBRlUI5KweiPhBh2tc7gPXW3y9AhF/f9X2Xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S7+KNeDfkoFNkUqTI1glSbFcerzk4r9cw2K9G6/OMQ0=;
 b=IfRGrpOM4bBrPf08o1r8f/guX9d3ddGgIZdbpMexujGF9lZ3hFYZi1E2CNsDGIj7csq898PnRRVp+gfqC7Mqtju7hvFJl3Tz+MVmtr6FqrykmDEx99F+dIgc/XPXcC9ZYl/xg51pvHcdMMfvz3pGlXieKvUk2Pjv8AcVvbY2LMbYV/OV0OvJm8c4S0oJ8p7o9vDffsf5Iv6jq4uV8vc6iO4YXBHPGDPZ+2gjyXqZAoYgh2rB6hu9W1pSFUs6POI7k53DBUCu+fIpCd/51kstnl4CQiWr6YzFlothh4Y6p6mtfdNxMiils+J/QOs5II9EFYG0bA1xV3qjCrApOHlSOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8942.eurprd04.prod.outlook.com (2603:10a6:102:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:07:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 02:07:42 +0000
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
Subject: [PATCH v3 net-next 2/6] dt-bindings: net: enetc: add compatible string for ENETC with pseduo MAC
Date: Mon, 27 Oct 2025 09:44:59 +0800
Message-Id: <20251027014503.176237-3-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3940155a-ad80-4357-6fa6-08de14fd9c62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|19092799006|921020|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ktopzpv3JGv6jKPcYbtICY8YhJLA8uQIwc3qcVcOB1gHEytnyA1Q8RZ0r42y?=
 =?us-ascii?Q?Nf9vrPXahlYGHBO4WSM+mWQJsiSPO1Pej2c4iZ92xitRB3Fwdn/jBVPWqczi?=
 =?us-ascii?Q?Emom4Vkxx9PFsJZ6HTLYhU/2TG0Hh19JaDeDFk4eVQzM9AHuAjb9SDZq0xlq?=
 =?us-ascii?Q?ptrs09h88TY+HSWTMv/jzUhSbf5ySp5fudQJH4av5EfjaAsd/k/Hy0KnwbL8?=
 =?us-ascii?Q?oyUfqIpSAAD27y43Liur1xCBje9qDOwmmC/MSiHsDUbzJ461TWNQCh3n7/Sv?=
 =?us-ascii?Q?G3t4bA+eF0OarFzj2ADqRGba+19h4ICQ1aQ++L/LL9GTyf/2Q7LyQrZYKdsX?=
 =?us-ascii?Q?orSHoiNUCocjz6m2hwrxIY5Ag6ch4NqomavcMnuQ7TVO7ksuegyGqWCVz1XT?=
 =?us-ascii?Q?A3C3spJPNgLOfT4QGCNcSDOfmEbM+mibu2rnA2RkVIzkEEiH3Xb8DTCFhcFO?=
 =?us-ascii?Q?wjdjq+DqB1w9wp4FQD8j3gjq3gzjGFFTg/XZBA0znp+J4WpeEuRplEqdptOD?=
 =?us-ascii?Q?z+I6iSjJ1LdA/HV2BIu1QCuznhIdvMefKJMqLqe6eJbaJmZexGFBImIWi9td?=
 =?us-ascii?Q?vo1YH1atWaeiID5ufADVACpQfDEpV/66pF4csWfikTLiKlsv7+w4GgrQaK8x?=
 =?us-ascii?Q?4belY2+p7N0BGXXW8nE/W31RSaLk6lvk+YENyuNp9xdaLCg6v2eIYN2N0Ltw?=
 =?us-ascii?Q?kjTt0V4gamqlMiTfJlS/PcNiv5TTQRoDqjGL7+hAP6gz4hXm/ulAzNraSDlW?=
 =?us-ascii?Q?Ow5gfKNr7D2xAmD6QJyyCTmKE5lLXOXmnYI6w2aA/Hoty7/uq2qd/l7d++JZ?=
 =?us-ascii?Q?epnwjnDUYlqXPeOgiuH/Xj3NyznFIlGZXiWgAtNK3se91kb1mkUPaGJmjsaz?=
 =?us-ascii?Q?JeZL1KTENcpKdiXla6DwUQALqZ1U7rC/o1nRlgGJH1D36sFDagWaVA2oRy4I?=
 =?us-ascii?Q?D6eivFJJQbd7vGQYfmOcNttWqy5f59fsjYKkF8qMfAgsBcWNd4CrTUj6uj2e?=
 =?us-ascii?Q?NxqWh1WhDwJbHepO0NYr0iMVM8LVGvn12z+2qOV3ZlWUoz5ofAB6Sc+oH8Ld?=
 =?us-ascii?Q?Yb5JOaXrJWlwLU1a5oEqqyNh8idzuyyfjB0do49JeSklr9GeIPtfPa7vF2wh?=
 =?us-ascii?Q?yUQOmD/wB9iRBKT+QYsqzBWZBCZUXJ6UDjaqHcE6jFyE2k5CWdxHk0JfxD2J?=
 =?us-ascii?Q?oqd1mk6HFInkc8MlYnmGIlMBl70kg3x4/hJ6fF0p1eOoel1Qu4AJJcJpKZDR?=
 =?us-ascii?Q?9Krgw26kTSTkqveUiGpHm5EBvdJc4dNROh3ZHDRhouVeytQdJLh+Vd717Gmd?=
 =?us-ascii?Q?hueVdBYtEwsYPGPsMhz1AANiC18zUyvALUwP5GTQdN6gvFKp4YD71l8fBMTU?=
 =?us-ascii?Q?p1TdefaauCa7df1IJX197mryDrJqTmT5Nbk9a2Qnys7wEsrqlFSC7y81q4ge?=
 =?us-ascii?Q?oK1bAv0s9VFiZXjpuyVBnYrp267ipp6l276JXeZ3zNsg3cSUj6quHgtHOU1n?=
 =?us-ascii?Q?p1JMKgvd9zSlDO5McOXkFy+YCD26ah9iLSdY1YnkXcbtIM/9kGbqWc6kyg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(19092799006)(921020)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTWUI46mQnGiyS0PFJH33/npIAkY1mwniy75Zt/sYYFP6qUQcerkgq256GpM?=
 =?us-ascii?Q?vZfvvJNh+hP/eW0OtGJnvJcJyAol4I59IRYzPymMYwfiSklcdZKfCo2xkS+u?=
 =?us-ascii?Q?OwPCzTPpRMC5WtS+gEqS3BHw1ktOA4iXSnO2W51yZj559xsM4XhbHnzQ5GY/?=
 =?us-ascii?Q?ZEU2N/U7sJ3KmORyApBESMRFGXcD4FGFqLD9HshhT1MPqnH2s8Fqx484CxNg?=
 =?us-ascii?Q?dEe9j1WFWi1Xlj/lWAvNQlY+2vxu1jX5rVyUP7M7jGlwNqyIq0WKCfVNRwxn?=
 =?us-ascii?Q?VIhS2Wt+YJJ3UVvxy6Sm3EkxQjBR3YKyfegIV4QR9azqxfFMy5jWjywGKEFf?=
 =?us-ascii?Q?N7r5/UOAu/UfU4LxNpT3/y2q7tHA1jPKOneo1E/jcg0VijAppaURiQyuAtKn?=
 =?us-ascii?Q?HM0GMelDz29O6WnXGp2iKzgmReMNFRtZlz5O7ZvtJ0H4zXAlRCFBfJbCs0si?=
 =?us-ascii?Q?eWE9iKZkU8OPUfLbmvNFFAvNlD8iGZ4xeI5hrLlDjolPJ5O6OXf8La+Ui3hT?=
 =?us-ascii?Q?7F7VR5Bk1zIINoRZS1eJmZndBpGasr7cW8bCwx4RmfNV1GwQNNHbkM30ZIdC?=
 =?us-ascii?Q?Hn6GrTleKSJqlY23zX9Gf1nhG2TVMtBuYoXKUl8zZwPwnYh5hYVLix4x//+3?=
 =?us-ascii?Q?IQV9cPTBX4S+mrZyX5vheCN/4dT7euf4GyNh9S9GfmROH0k6cF9s+IZmhGrf?=
 =?us-ascii?Q?4fY448m8Joj03+xiqUz+zRloCE865RumLeztzPPy2XtIxgi7JgpGNCxB7ETW?=
 =?us-ascii?Q?VWbe7DKc0vM0n9GwTuEuP8oTP1YDq1S+N6oPdB4l022fnwx3HEXW/VCo8Quf?=
 =?us-ascii?Q?+Dl3s54T+04rvfeKL+Dzmraw8uA2eobkr+trePKQWfNKuIU1zutsJWrJac59?=
 =?us-ascii?Q?0Le1PCEA0nt5vR/XPtQuIGnNXUCra37D79lNNsv82Gl5BXKvYl0CoHOuKM4F?=
 =?us-ascii?Q?oH+zXlf3FbfbD9d59Hrb7qxH9NTljs4M/NRe0lc9k+MCz2LastE9uNB/Pe2G?=
 =?us-ascii?Q?2WvB27Yr2a7P3culEM5iXmcb17IbsHTOjQ2xVtNiFZBBG4vVEScTr7O+TYKv?=
 =?us-ascii?Q?NNLBiqyN6shpiCFz7Pco6YnN7Axb0ijrwq35jHFqYlgbKFOYxzGb3nFirqvP?=
 =?us-ascii?Q?ntY+rLxNYejklX4l2JBZN2dI8/ExolI93ScwmrH9jQMKiFd2X5j28C6JhEBG?=
 =?us-ascii?Q?SgVp6aex4rQboMbANW7nfLgO2I14Tgz8MdHdHScAIxoIxGDJlZFlZFUKcjve?=
 =?us-ascii?Q?ItgeiLeizzNioSYt8peQaFPt4I2rT7941kTGz5oMFs39kK2awY0ITzeQIgBT?=
 =?us-ascii?Q?zWSUbkLTfqh2fkJ5La5LDNc3dK+X7ggqbXfy2wTPCu/yt731GJdbxlPjbWKv?=
 =?us-ascii?Q?8zoH6Ckahg3hCcd/NpXRH5YrpyNEkNMZPbq+tfS6hTMJ9lLiwWeiR9eZD6a5?=
 =?us-ascii?Q?gL+l85bo6HTnxNSBKu+dWKc7PoDpjfdZ9RR+fIKougGmiySWAmS+UOTQ8WFB?=
 =?us-ascii?Q?QYllz34CWs0sNQD9OpvItYz3DSx+fnm+mYBhGCIEuew0xfKM47hmcmabeT2R?=
 =?us-ascii?Q?7PGUpvwKGD1BRlRZce364tZYd6MZXy1X0NbUDyLm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3940155a-ad80-4357-6fa6-08de14fd9c62
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:07:41.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIk71VnUdtUPNggNT/4S1w8r8+vw1cG2RW/dcaCMdb7uU90zFQpIuaqCkKVtKZXjONkbbOy1EhE4RPS194FcJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8942

The ENETC with pseudo MAC is used to connect to the CPU port of the NETC
switch. This ENETC has a different PCI device ID, so add a standard PCI
device compatible string to it.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/fsl,enetc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index ca70f0050171..aac20ab72ace 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -27,6 +27,7 @@ properties:
           - const: fsl,enetc
       - enum:
           - pci1131,e101
+          - pci1131,e110
 
   reg:
     maxItems: 1
-- 
2.34.1


