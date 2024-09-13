Return-Path: <netdev+bounces-128151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DDA9784DE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE048286A72
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D12E61674;
	Fri, 13 Sep 2024 15:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9EGnJqD"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A4152F70;
	Fri, 13 Sep 2024 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241396; cv=fail; b=niFEGNJU9UaFTnmQArkFOr3yrCtFAGfiu+TqHbLSqNe0XsPeUnwGduleR4uw9oQgnQW3+OnRKT/Bd8I5oaLtkiF2hc5Pd7rGfBJAA5SMIzGjVD9WmIZpx5GYECgcWQzjCYT24pDwDar6/EBs6XNEb/1as2+GoSl9dpOBnaZUnz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241396; c=relaxed/simple;
	bh=OkfpFZ3dlu/yXKeKghVr4vgnmKA9vBJvoCXhKjeRBrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s3kHEU5owmVETy8W3y4hlZ+3WcSEFNTBIbSC9hmZlH7POefwPdbuUFZy4cf+FEHUwiQi1/YCm7nxM1KBf7QBrNuH7avJl2n5D4mP3XkLsvMmQxfKkvRGnrpLE9mFm+eiP5C6vMqOZ0oi1QKyH0OtFchMP/ZIrX+kOtpe/JrIGDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j9EGnJqD; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN+/AZ86M3G45KE8RR5tO4K/lIkmT4a2aODfP5QGxEsujO+CnaeJCy2YIC2/eidujB/ujyynnvfQjO37TmEtTKkdiV1UMN5IcfQGxeOUrw1dTAcw1QdNl8azGiXPk56Z4Fg9w8eLNkhmaig5J9BfEzSiJYABTykF/hvO5Fm6lxArCrDrneUJoheaw6pJT6LYkzOEV7DHtzFtOWaNfN+OKdNfzzNTiSEX/M0K68aMiI2tUDHf5+5WYbiXJRS+h3ZmFtu4P6qlq0chMukvBYrdghKeswiaR4Cwpgut7JouEueiKn5fTqJJ2IxF34HSrYE0aRLzkims6of3QqYDu/0P0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjeTHLE74iaElKzNULJuZZHF6JMuMUe/6vhKO7LRSoM=;
 b=UYBqUktRzZ8EQ7KVEsUx42U8Vk3VgLqQ2gF0b5NODGLu/zi5acKZIAlsFPViHyTiExeb/4ZOFOiSqfuDKRyY2wxYWN5iV76YESmFrObi2LPv2gqfYC+2Egoa+TmUcNhsAFbAR5N6bsXi/roRIbX28+m8XBE7EeIzfjLsxszWQFCdB3527SXtI4KD24VqG+QnjJ7xBsnF0V5fAS6VcI8flmJwalvo8MtExGcvWca2UPb3TQR2cUog0qK35R6WeyTSu98iO4o/caD0U0YZE77LyfLnq03Ombgej+X8aO7tBeWIFIY5bpyyKj4siWV9+X/pZb9EJurb1WdhwQqdBeiFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjeTHLE74iaElKzNULJuZZHF6JMuMUe/6vhKO7LRSoM=;
 b=j9EGnJqD3uzFy/inR2ZnRmwWCxRM77sc5A82OIHuToLYsm5NH47ZxfPxtvAcOByh8JrhM0nfFyGsV/KYS/0524MfopbSn4yMXOz8ulV7dreH32a/12TqBPZr8mueeRWKkwlGLKskrwtTFed0IaSXHmblHD++oTXZ7K+CKSr+f86ImLWRew1jPZDVXFKmka14bPA3jxGNk3WBz6JkwxEdHxAFWi3JqaWMW2XwXu9HhMdrhyj1j8vP9+SoOrPt7RiXK3ZETeT5lTk4XMB1tnXGoz5eLQP3+EdIRPY5uK4O3IR+5u32d6SvDCUUFuoLQlVjMXPeNO9zQFjl5XMh8cevaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:48 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:48 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 2/6] net: dsa: clean up dsa_user_add_cls_matchall()
Date: Fri, 13 Sep 2024 18:29:11 +0300
Message-Id: <20240913152915.2981126-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
References: <20240913152915.2981126-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::18) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|VI2PR04MB10859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a8ef2af-2809-45d2-24fa-08dcd408e765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0cf6njNFtZnrAS+4VIy7DOoEDbhlW0y7bH1bWgrviiycKdmJCcIxB7IG94Q?=
 =?us-ascii?Q?Z6AaRgudgr6u/70BWK5hkICBK9pDMxlutCVTS4x0eSpez73LPTIYJlPX1Wwi?=
 =?us-ascii?Q?zJl84eBcr0zVNZ1OY16DCVzxwNFj8k/6IHXGkfDn44dcRjUzhRe5iHO1KNV5?=
 =?us-ascii?Q?hJ6tIW/rUxSrUSbFDSANrBuVwGEMwXln1vk0B5MlX7H9hV7Uhg6nykQI7GeH?=
 =?us-ascii?Q?C5+l0/u4vVqiRA9CCXVHqnKupGR1RtsBCGNujXbtUNsiPAzGuWSygWZWbRmx?=
 =?us-ascii?Q?PSxi1RS20ulf2h5K4RH1gMzamlBaHdOKvLKxPmFXMnmWdY3wv+MZ1/sLO4NR?=
 =?us-ascii?Q?AVEe2eTDIvqalkrLnt16pSfuPrrC4VhGXogWutWK5u+HqIVmmY2kGtAUEQn5?=
 =?us-ascii?Q?552kf3QIzoYLosl/82t59AhfV1HOW0IQ18iL+LhoMyM6YVyLxoko8yzu0EP6?=
 =?us-ascii?Q?QSKdUas90hP09QSvHb9TAMF2UPSBbVQgzlFTh9+9oSXk4upUJgqQOSSbE+Xg?=
 =?us-ascii?Q?JcQHYryvXeXqzX9lUkduM+UN86ACqDaAh6a145ntPUubbxZhLoapdPYpUswQ?=
 =?us-ascii?Q?PtL1rkrhEbKPYcmFogdnaPAFl1hhf+c8H4o/WtUGedEpDIhBWxoaaWj0dmss?=
 =?us-ascii?Q?/VTOyf8Lj7xrW+Ogxiv19T0UdoDkXzlIGrBtSTHk8iQfi1qOoivLXmpMwnAi?=
 =?us-ascii?Q?tQEd/WaFU1YInSy3bh339ZJTfv4moIuVSvLN82wKWF4T7RVuuvJ5zaXeaTGZ?=
 =?us-ascii?Q?4glfIbo7gWjRCMEbd/ih2tkIIU+3VbYs/t3WoddF/D7JzvtjQ7mo34w3rrLE?=
 =?us-ascii?Q?8K0VxI03zLH48I3iUP8MwAXaKpSwLwwHnaqsY96DzfJe8tPfArn+IGGKaVQT?=
 =?us-ascii?Q?u0beaM7umL8NO1AjzQKbqvBUNSG3WXc4xUvcc2OQVxbcstzGEqVRVIQXbIEh?=
 =?us-ascii?Q?fx9AF2ttRsEPO3b2rM1GgjZyWlS0N/I5fKsHwTc2J/XyozpEryi2D1fSoQeb?=
 =?us-ascii?Q?QQmgd87lEDaXJef5/OfLwokJxI85pH1CbruKRTfupNeBil3LdvgeY+8NUe8f?=
 =?us-ascii?Q?cEFIluRnD9Ok8LPjKfxtfXcd5TJQp0ktPZGnRIEj9NoZHF+SZABX5fhCGxs+?=
 =?us-ascii?Q?Qkq85rS3RwEaRVCPoq9dTpSbGuaDj45OkpsAjDzc7A2uUYNoyWojVvx9oKLm?=
 =?us-ascii?Q?/xXgkVeBD1c/I8ZN82Ck7Nqk0bLA6FouM6pp96he2RNTZHiwbwy05SBckCL7?=
 =?us-ascii?Q?BcJhXh+x90FNwf/iBYTXqkVrIQjVf7QLlyvCpj6Vhshevd1SrG/iXpK4avud?=
 =?us-ascii?Q?o2Nf+YJDdfpPX3BjIIvTXKzaRuoOHtxEZUYpUGSrayMDRF24zTLinkxBmaed?=
 =?us-ascii?Q?aEIA5wzhKal9kNzw43cM1rgfD+jAWEjlaolqjq26VsdrwUYBfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMPUar5DiNgS+g/majGw32xnj6K9OlKfyfcfF4SSnuLl5Iabe0PB+dd4d4U/?=
 =?us-ascii?Q?Oq2G2ecup7q7aCr/ZaYBNBL4Sq4yrHlRWioNcrl8ftWQfg1Q6F4OEb5jNMLl?=
 =?us-ascii?Q?T6IZ/EYd4GgAmY0DpzjURm4gqK44GOVR0dD4YyJWpjxc+m5pan7wrMiMKlNN?=
 =?us-ascii?Q?1jppNf9K10rOwsRRWBpQj7AwiLioWFPtJiMSdHW/KjIS1gTeaKJWpr153Saj?=
 =?us-ascii?Q?0jN1PBNPC+lsAN+2nFEDNYZ44qmpzhVVc20SX7AOqleyTTJC3DTvAqKokeDs?=
 =?us-ascii?Q?H7LcUymGBn4NQA7FJSB+oTAKuKOX4QFmYmI8rvPv/oDiWKDq5RV3rp0AzLFp?=
 =?us-ascii?Q?dzntdiG6x5xj3z7ir7FjwH7QtYbnhzzuigla5lbCpm+XJwfXuqyPrJEQzkkA?=
 =?us-ascii?Q?ViE9tcMpQRx7g7gTfdfZdwkxJvG3zZMGZe4PD+moIEo3ckpD/zuFzK3erR5N?=
 =?us-ascii?Q?2PEFMxqVMGDjwaeNmMELafH0C31S8splqSMTM1HwmUDENfsPSje3HwTo8VTb?=
 =?us-ascii?Q?CK0+1KbH8Ss8MKPVdIp4koAQCp6ZlA27XxcOYL4jui0nhk85QTAhRWWYPV8y?=
 =?us-ascii?Q?oF6LFl8eQ9VSWlmVKwi0/mxKe3ECqvsWjFPcnaRSeLQT9TaACgNE6CfD0SvC?=
 =?us-ascii?Q?OU8a2AWvypDlmKF/HnbQ8vP8nwOJzDVHVkNZd+b5s7xLaHQxS+YjSzDCvMs5?=
 =?us-ascii?Q?l52W4V4ImI3pgqjoHz1HNf294yRx2ZfCRPLa/CSfZ6x/sXmPr3/yYw/MMGDk?=
 =?us-ascii?Q?6bIZ8A9whUevNGIhqFbh4sOFlv4rX4gbWScdXyF6A15z2VLgzw/tHcNw9s2c?=
 =?us-ascii?Q?ddg7bnT6nRaDWAgiZl7/+jfYeKgXFljgCdCeaSbnPzyKRqNbkU3mAeJuFbG6?=
 =?us-ascii?Q?j9ECUWWka3RjUhBWtLCjOEDpopY8nI5Oa4/ZJLLpAGenI8/V32hzD9wIXE2D?=
 =?us-ascii?Q?0f+wm4p2PRjgN/xFISDU7iesyK/LS5Xsh7gY2F00SrWSticWJZ1SAktzxDmV?=
 =?us-ascii?Q?WayoaAlgCMgELbwkt1Oh5RpNkP+4ypsMrAiGI49NsG18dvaHOTALkvP3noCn?=
 =?us-ascii?Q?jkfTNrIqryjy7MmE346DfqW1/sFnLYSoPFhKOMTJSQdqQYVxTrXNs9FLTLXx?=
 =?us-ascii?Q?iLBYdN7VwXZeVgq+hhcQ4TC3Dhk3FXDfyha3H1+RFbq/4ShNQPpm+Vr4/kEy?=
 =?us-ascii?Q?221qqIA3Ha8R8IP1zgEOXmy7kDMl56DAZSJl8ACh2Heqc+eJEd2M7R9/NJVt?=
 =?us-ascii?Q?OxCeSavLircRqWC+1JV+ntTQiPpxgouIXDo95n9UkKGi6W9Mq1ui4TeDovxG?=
 =?us-ascii?Q?CLsQw4AfDSGqriRQRpIXNfCThCaZntJntbPLmn9wENDmp7RSQf0U71kWfwHW?=
 =?us-ascii?Q?GbfnEY+B3uxS8qpa8Xrp0dUgdFDryOJ3yz2CD92IDHclwtmBY2idytgdab2N?=
 =?us-ascii?Q?v/aA8Aiq1UyDPnahsvPcZDjz8FQyU4slmrIDwtJnCKq/+Fdym/Rh1vWhRiKp?=
 =?us-ascii?Q?tJJrMaDZnx2Lhi93arlEMH87yL+G9HZSCzXc85YYwqExAFKXFJgy9rSwxD/F?=
 =?us-ascii?Q?8E5ZtTZ2s7os+Ie5JGkCTFrARuKNJPdBQrYV556KObH91C2+z/SGtTg3xao1?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8ef2af-2809-45d2-24fa-08dcd408e765
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:48.7936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQb1puI78H570YYO+Uwu61XaLg+wbOAz65qgt0sfHPCXvGvHLwY//zyc5AtSPhmjJZls2JvatT7fG00ckxaCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

The body is a bit hard to read, hard to extend, and has duplicated
conditions.

Clean up the "if (many conditions) else if (many conditions, some
of them repeated)" pattern by:

- Moving the repeated conditions out
- Replacing the repeated tests for the same variable with a switch/case
- Moving the protocol check inside the dsa_user_add_cls_matchall_mirred()
  function call.

This is pure refactoring, no logic has been changed.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 74eda9b30608..143e566e26b9 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1377,6 +1377,9 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	struct dsa_port *to_dp;
 	int err;
 
+	if (cls->common.protocol != htons(ETH_P_ALL))
+		return -EOPNOTSUPP;
+
 	if (!ds->ops->port_mirror_add)
 		return -EOPNOTSUPP;
 
@@ -1481,17 +1484,21 @@ static int dsa_user_add_cls_matchall(struct net_device *dev,
 				     struct tc_cls_matchall_offload *cls,
 				     bool ingress)
 {
-	int err = -EOPNOTSUPP;
+	const struct flow_action *action = &cls->rule->action;
 
-	if (cls->common.protocol == htons(ETH_P_ALL) &&
-	    flow_offload_has_one_action(&cls->rule->action) &&
-	    cls->rule->action.entries[0].id == FLOW_ACTION_MIRRED)
-		err = dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
-	else if (flow_offload_has_one_action(&cls->rule->action) &&
-		 cls->rule->action.entries[0].id == FLOW_ACTION_POLICE)
-		err = dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	if (!flow_offload_has_one_action(action))
+		return -EOPNOTSUPP;
 
-	return err;
+	switch (action->entries[0].id) {
+	case FLOW_ACTION_MIRRED:
+		return dsa_user_add_cls_matchall_mirred(dev, cls, ingress);
+	case FLOW_ACTION_POLICE:
+		return dsa_user_add_cls_matchall_police(dev, cls, ingress);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
 }
 
 static void dsa_user_del_cls_matchall(struct net_device *dev,
-- 
2.34.1


