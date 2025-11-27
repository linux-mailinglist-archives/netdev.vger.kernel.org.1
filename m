Return-Path: <netdev+bounces-242259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B377C8E317
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC65534C1F9
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B3132E6A6;
	Thu, 27 Nov 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FpjwynnO"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB432E141
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764245378; cv=fail; b=HUjxRvEe4yjTrQFtwk2IcsMX6Tj7WxruV6/pHPNRlM+Xog9hKSH4JXuh15US7wnjydVKdVEvGCMIOSGjgMlyFhxIc80x4AS96QuYEOnuzgednWcbUIdeSO88j9LvJE/QW5DmOoNt8Uzvh3I1Y4Zu6WObZf7H9hSRjYc/E2/+4pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764245378; c=relaxed/simple;
	bh=Hh1IOq9f0Gp3jW9UMEZqpx6W1apRSkaDNn7erJN1bTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MScgjuDmYWSiKHORtC5gM8mlr5tqoQvTDio9paZYW5nEwftEmc+0A7yQAHW3Qyhb3iz5hrxCWuvf44cm3Vl+09uJ6l7TmV6lSOwJiF2CpQiDidCOmVwN+Au1py2V89840fDaXrnJ+odcF6OdjqN3zGcnXmIspZW7lRRQpHeI6ZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FpjwynnO; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGW2d6ESNElKP6OAYp6Z+vYMVccMBJM1yQJ5+aGEIsQv1bHiNRhvVFbighml889Q8E6fj66opKCy/xL1TwcRntQnoyet81VVIPi9uMNExNjKLj/GA6ai8mVWY6JAySRZ4i3dbrNFz+n19OWiJyeX9f61Cz9KY9s4ScbgfyouFQK6GeZSJxHxl3AQJZQkZhJEJM3LCV14I5IumHp7LvRAH2zHg0THdIUdpVSmFSA9/UZBXLZlrQd1JGrLzR/wiuUmMsP/o2i1kBn03514MsfkjyshBWIaNdXJdGGRCZHYOMvzq9HcbFyvzx0xVGWY0d91F+JUPK9sPU5GFI1GeQJoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edFDo434xsMTOisLodbFvAliB7/zn53Ie/KGWnng/MY=;
 b=onHzLC1gGhDA5UviXJvfbRguL9X5MKC5wW3sHR6hOGx+R8AZrpI4gG5mTQAeapIsxVIKaunz+qPeCSypwE3Qkbyoq/w/78Jl3Q//z2pQlYZlfuAyqeCX657x1A+Z96nihY/6deAeNvDb0ovZ6giS8BrQK5EnBTHW9AKfIvSqyA3p6ixODEFyRYaPf1PPvhDsj+PioPg1Z/fJYCf8fOk/3UNJOklpJvb5zR2iNAQSPm6YFAa4QFpktCJlrsrPAA6kZlJXOdf9hOM9a1jwP9STBpAGlWkW2h8MvGsgK4vLzQ74ZAxkds+OFLVZBIX/svscaS8S0p0t+CnFy9b3wPyo5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edFDo434xsMTOisLodbFvAliB7/zn53Ie/KGWnng/MY=;
 b=FpjwynnO/wvXt8MyqKPBfj6fBKPnnFU87HXJ1bNzbRP2BCk50zov2imYCY4BrjjyC/y+fhpDJ8eF/UaLv4u0Sbll5Qi5jMhy+EmvrCVbJzoj/ku1zcQjwAvkqo4mW24VwiXpjbLW0aIkfpga619sAJdEVIw7ZrrqBC/56QNdMPsCub0rzj7FblZiXFn36xXmcG7MBJZp8BY1SeNO64q1341NKeQL3yzm/puebDAgg8GqEVRaqGKnQxpgN1bmv4cbhcZtFvsQyhHA+4htN8d1WL9YpGG8KUSoJRc5dak5ez1wzzGABlH5Jwdg4+UHrccfV54KfgTpV5KEmYM+OoCRag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by VI0PR04MB11844.eurprd04.prod.outlook.com (2603:10a6:800:2eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 12:09:28 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 12:09:28 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 05/15] net: dsa: tag_ksz: use the dsa_xmit_port_mask() helper
Date: Thu, 27 Nov 2025 14:08:52 +0200
Message-ID: <20251127120902.292555-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251127120902.292555-1-vladimir.oltean@nxp.com>
References: <20251127120902.292555-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0056.eurprd03.prod.outlook.com
 (2603:10a6:803:118::45) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|VI0PR04MB11844:EE_
X-MS-Office365-Filtering-Correlation-Id: c916f003-b6b5-46ee-aab9-08de2dadce63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|10070799003|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XZ/+80MuKHIduk4qPHN6u2mf/Cw5ztetu8OOCvAHOifIXk1PVBEjC4u4FbX1?=
 =?us-ascii?Q?RJOpYNzqqDIQu6aDaqOxSEO9xfp7gaI8tdrmjUZOVuL6I3XDX5kp4nUS1Gj1?=
 =?us-ascii?Q?4BkKnSWI+ALP9xrfi2a9Om4Hgrvz7NNCtmG4QbrFpz625+C5qCExEVmWND6I?=
 =?us-ascii?Q?EzZ/QU3y+Am16zoIFD2XnlbBzkft6kKH71aUsq4Ig7GhhDaPiOXM8a7Fp9Vn?=
 =?us-ascii?Q?b5Ojwi+DS2+sONb3BFoz6JCjh5kwZ5wg9p5hpyuPwRZO8OUFzHTk3zSxvxRP?=
 =?us-ascii?Q?Ye3jca0r5t9C5CjjhDYWdwYCqFpNRbGn+gDlSu5GK4yG/Rnz8ZxCADafg6QD?=
 =?us-ascii?Q?5k6V/iiftbM3q6IU6bW6PVUcVc646a1D0Mc8VDz2IwhyxOA5wfnjCGPKFg6Q?=
 =?us-ascii?Q?eIXBnCEqEb2sR6iP1PoQdhZcYilQiEKnDPxpAwDlfX2x/SDTZEli+P1S8wJ7?=
 =?us-ascii?Q?eZ4FzLMOl9AGA4OC6BX5/1OoxSTAUAi8Yv9Xst1oMgdWHqBPDN0eDAV38pqu?=
 =?us-ascii?Q?VQy5xuaZrPTgxVK16PLj9+lRZNkXP/NRh8rnXmporKh8l+j7YpEYTqtaspfk?=
 =?us-ascii?Q?Z3BNR91xQat+5zk/HCPzO2iibGzgV1XCNIzYwd6h44mm1/ItD2aqSmDMfuUR?=
 =?us-ascii?Q?T7hj55z8AA4UdBtVRwCXbKZDWY1rqzhn9oG3ZMuPaWAmz8RYa1CoWOz/HaBK?=
 =?us-ascii?Q?IMDSViEFb7UMBNMw0P5Hfh1TAedY7Sv2YHAzBoaDW/cbzn8ko1LoWmm//SkX?=
 =?us-ascii?Q?ioE/0tV5UKl9FZ/z17hdEBboJFQcEPzHg83tNtso/Ay6HHqCedYhcGVqAE3z?=
 =?us-ascii?Q?YOTz8BQj2tLbFgoWhshCjGSsZs3KD64BbGOh/ISjELoNTFElG33uoq6Jj6eA?=
 =?us-ascii?Q?HBd43SuKE5G+gJjpALwtfHN8yMNtpbLenu+96iWTCjJ4InAjILtktFwx/DtN?=
 =?us-ascii?Q?pQBOAlVCcIPbgH+aS9/Uu7OznXMaDWVFlM8x6A2Jmf6w5SlfB8uKI5F9r5Lk?=
 =?us-ascii?Q?WPJTOafnjz/27l/M3ej+IntlLUdIIrI4ZRjNsXGt/JdcDy3vzioGuXDNnJ6m?=
 =?us-ascii?Q?DN7gIFmjr/zdNjBu4TptkHvOVv9ERNiO9VvyHk9Bj/ahECVQTWGenCbGu/h7?=
 =?us-ascii?Q?7LYdwiHIXc2VGmm6ZlyDWo+TafgeWqk6NnEreOk53vmRk8dkrKjsre84e+g3?=
 =?us-ascii?Q?n4kQsDuky0+YFAz3FsS66En2pb/0Li4x+ewfL+mjmIa6xmlBwoB3TQSaLlPX?=
 =?us-ascii?Q?ZD42H1uq6zAjuxH0hjrS1aJie+xnDFqG9t3V1llaan1Pf2Wh3AP5hm4nJg2Y?=
 =?us-ascii?Q?RMPkfF7JHXo64nY3ItAJvvsnjY1eNMqsYqqFMnsZcn0YXCRt/g5+LwnH89Lo?=
 =?us-ascii?Q?U46nfieIPzVjD7G8FR+5qilStD4FSDnf2rYHvlWZQBW64CZZnhAhPENeq101?=
 =?us-ascii?Q?KkKUzCgdHDwYHw68bFk1lwaatJrLk8fN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(10070799003)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4qGge/JxbZtt0I075yxvI5bIJAwDqYR+AwkWiXjx0p6WF5dw88Hj/JyqTQSu?=
 =?us-ascii?Q?R7qFd4JKJByNa+r+fTL91lXgG6tsVH4zwj/h8AbCEVOqZZdJIN7r8DGv5s+8?=
 =?us-ascii?Q?Ama//1ncA3ZAecuFjLdgu/Tg8NMVv6AqrYtRtpBNWEqPHlP1NX7VDd7NqObv?=
 =?us-ascii?Q?ZGfSMUFhwnSgUocs9pLmmzfTPh4nA2k5b0WhOLSwjYbUjew7RbmMPyp7Wc/I?=
 =?us-ascii?Q?AiRReED/+WZItqU9RyUg8huJsmA7aA5zwJo/w4y1Eix1hcHiXMtb4+B/ofW9?=
 =?us-ascii?Q?cjuGB19PJi4sWSpjAfNHiyuc5ugrXK0UnY2OuAwmA8nnYx8Pl3nsVuyGvtcL?=
 =?us-ascii?Q?GqTEq1ONiKZzcMUVj7938Yu8vNf4yOaBvU3u7a8Fn9pAiW+IMSJWbcV2pNxj?=
 =?us-ascii?Q?+BKtYKxrZ1p3CXk22SwGWeCQB3RFGufiGFKJpRkNB1bCzSOcT+TqxvH6vQDQ?=
 =?us-ascii?Q?vRb2dEKNNA86arOFpZWfDc97PVKSH3gdD7nU1vsaDMi0i7zxapBksIFWOM6H?=
 =?us-ascii?Q?gJ6evOlqhh1SIeIwgC1s9FmH2jpuXStyw6E0qb0kVZ1G9L4h4NKMxcEJ3uuW?=
 =?us-ascii?Q?SWsZIojWY5wXuc9aWA54Ed78g6hJFJyMlqrUgGlnrOWtAgH938AvSGHs3w7L?=
 =?us-ascii?Q?Utygo4NuamLlxUngdKZ7EpEMFRsD1JEFT/2gVzRBLKwJI4Me/lFkvtUr0h3J?=
 =?us-ascii?Q?CltDMqQ+KrUxDLIQkDEAISvWFvFxvRaPNbbrz0m3jlCy/srxr8NNEOCeXMBl?=
 =?us-ascii?Q?isorq/Jk9CbheXrPoEGd8sKYP90/RoEeychhjdK/ISks3Sa2jEnpqb/mkOl1?=
 =?us-ascii?Q?yttNrQtgoCvYpfCHLzkqfFjDBWA/kHwk1NFWVXx/ndlA88bsbn4zsp85jQk6?=
 =?us-ascii?Q?6qq6YJxySltcae8DEPWbootHt9rHlVx14i31dHso2o6OlmAIrLi+0D/2teD/?=
 =?us-ascii?Q?RLyQA/I+Mv9ss0sLaUqSRAJyIhNzMcIn9/7XBJ1rhiz24X93jHBt/AswrbwR?=
 =?us-ascii?Q?NCNZlD+aibLEj7hZGR8DR/Cha2A9ffxUrX4UZ7uAi27kFt9jNkTGGbluj3pF?=
 =?us-ascii?Q?RN99iM5ZTIA+kczAzHf213gJukPTko2ylzoh/XuhC8wW1cBUMpMm8PtUfl5Y?=
 =?us-ascii?Q?H6N+3jEQSWKEQS8aE+9IoMkPlw3Pc2Rv/hr50UcTxyt4ak3+5YVQ4LF66Wd9?=
 =?us-ascii?Q?L0niVS6EcI3H0HATm3x4mV6eXRMwJ8zoPavMdb0sScCsXmx9z5WNQ5xi4XSy?=
 =?us-ascii?Q?5eeXSOgXhDdmo2BvjM550ofUUIejHXli1VOrmTE07krLYfMg5A7alRXcG4rW?=
 =?us-ascii?Q?+rV7uqZ0jn+42R3gCnjGwhR+5raqy0w+P/JMuJ9Wf3SbV4x3gIDZFfqKByTN?=
 =?us-ascii?Q?kRxyH6bOyn96ot1z0N0vJVkmE5zEvYj/qbEzNBAqn5aCu1wZAuWlru8+clzL?=
 =?us-ascii?Q?+DFPsY3Q2vx1HUvm8Asxo7kXLy72cWQkqydO1+/6M2W9Wdl60oOBKvTI/+S8?=
 =?us-ascii?Q?5rbAcd3IjTauzS5UahB4B092YBVMJMY8R+CQo8WxiZzJoaybWrmhhVUkU01m?=
 =?us-ascii?Q?5DLuEIEGJLh35E5WXYH6ZNpTmocz2KG2XXqef/WfkfVocz654KPtiQYTKxdp?=
 =?us-ascii?Q?XG95xeHU4x26wRgaKyJWf3KbwSaN4DrljNYawurf+LuqiCIfYMetSCYYimgA?=
 =?us-ascii?Q?BvZY2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c916f003-b6b5-46ee-aab9-08de2dadce63
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 12:09:24.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f79Z/ibMy8RleZ0TzmtOgHzA6Dr3IFrX8HHJLDHjrUuOpAUKRQhfNPF5n8PDGKTMAH+x+w8SQRP4D2x3DML09Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11844

The "ksz8795", "ksz9893", "ksz9477" and "lan937x" tagging protocols
populate a bit mask for the TX ports.

Unlike the others, "ksz9477" also accelerates HSR packet duplication.

Make the HSR duplication logic available generically to all 4 taggers by
using the dsa_xmit_port_mask() function to set the TX port mask.

Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/tag_ksz.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
index 0b7564b53790..9170a0148cc4 100644
--- a/net/dsa/tag_ksz.c
+++ b/net/dsa/tag_ksz.c
@@ -120,7 +120,6 @@ static struct sk_buff *ksz_common_rcv(struct sk_buff *skb,
 
 static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct ethhdr *hdr;
 	u8 *tag;
 
@@ -131,7 +130,7 @@ static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
 	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
 	hdr = skb_eth_hdr(skb);
 
-	*tag = 1 << dp->index;
+	*tag = dsa_xmit_port_mask(skb, dev);
 	if (is_link_local_ether_addr(hdr->h_dest))
 		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
 
@@ -294,21 +293,12 @@ static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
 	tag = skb_put(skb, KSZ9477_INGRESS_TAG_LEN);
 	hdr = skb_eth_hdr(skb);
 
-	val = BIT(dp->index);
-
+	val = dsa_xmit_port_mask(skb, dev);
 	val |= FIELD_PREP(KSZ9477_TAIL_TAG_PRIO, prio);
 
 	if (is_link_local_ether_addr(hdr->h_dest))
 		val |= KSZ9477_TAIL_TAG_OVERRIDE;
 
-	if (dev->features & NETIF_F_HW_HSR_DUP) {
-		struct net_device *hsr_dev = dp->hsr_dev;
-		struct dsa_port *other_dp;
-
-		dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
-			val |= BIT(other_dp->index);
-	}
-
 	*tag = cpu_to_be16(val);
 
 	return ksz_defer_xmit(dp, skb);
@@ -371,8 +361,7 @@ static struct sk_buff *ksz9893_xmit(struct sk_buff *skb,
 	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
 	hdr = skb_eth_hdr(skb);
 
-	*tag = BIT(dp->index);
-
+	*tag = dsa_xmit_port_mask(skb, dev);
 	*tag |= FIELD_PREP(KSZ9893_TAIL_TAG_PRIO, prio);
 
 	if (is_link_local_ether_addr(hdr->h_dest))
@@ -436,8 +425,7 @@ static struct sk_buff *lan937x_xmit(struct sk_buff *skb,
 
 	tag = skb_put(skb, LAN937X_EGRESS_TAG_LEN);
 
-	val = BIT(dp->index);
-
+	val = dsa_xmit_port_mask(skb, dev);
 	val |= FIELD_PREP(LAN937X_TAIL_TAG_PRIO, prio);
 
 	if (is_link_local_ether_addr(hdr->h_dest))
-- 
2.43.0


