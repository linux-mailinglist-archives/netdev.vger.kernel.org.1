Return-Path: <netdev+bounces-128153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A257B9784E2
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7AF1F28D9A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B8577F13;
	Fri, 13 Sep 2024 15:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TLDd2ByM"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013057.outbound.protection.outlook.com [52.101.67.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5874418;
	Fri, 13 Sep 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726241400; cv=fail; b=G9P15xNBTZGtY1ZCN/bZgNukEgeFKAiWCRTIm/uMsFc6kobWNKYZWVsOSIXKxJp50xcl2ewLj0YYQuBdZyz4RA3b3Mi2awMUEQAtwi+t9zPqLNxw26O5L914RA0y6FHKUrQ/tjg4GDx34+TKzkzdeuEWh2sDpBml6kLYOoVjQg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726241400; c=relaxed/simple;
	bh=KVWVyoBg2tKcQbKCBA2erSCDIOauYYuwn4e7KjUCoYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZV/qQOn9I5XdrovP47ZGKDGkgTnfnmKrDDVhaJksAQio8yKBOp0auyyvYtTAyK3UHRGyHDCx5sq1NiJZQ7h3f0Yf4xmqJf8qlfNdZhnis/NezheTIR3mCuwwu8mFuCkAcUROIs8mdQDlmgL3/TOLONyoFqCRtCOpjeDmf/qcQ14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TLDd2ByM; arc=fail smtp.client-ip=52.101.67.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PL68MsaKh3VFvPuoHQATrCb7K12vdEClLyhPG8XWE1uDb0kv5zLZoi2ZQgUa0uj6Ld7e95bnFlQ8Bh8cfd/VOIJoSgn6+lxZHTAAvwVD6ODaBaKJSOATK6CAROo/kZK8/xOw0tYSWQSWIh39FWEc/47vghrLiqGof9T1sSrxoNias075mzbl8IPIZWDWx2ddz8Fa4lcge5jqw92HBuhOsqN1s2AdMA7L8/sEvFfNDKtUXOyD5b6SEtCeXwRq2CPmtBpJCY+ae5O3JREM9S3OQWxzMYrBZSjUHUA+MlKV/4XMJwhD4y/iUUpmBhkSz47KJ3RGppAwxNv+anIWPIC5HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jiq7VkQ5r0Gt4T+SnucsAAt3eUWkpw/ZrSEdYpTcxsM=;
 b=QfzQfDJuM11ncuFXsmCrt4Eiu3+qMxTPpLc8qJp+DZRKDnqrLW82Zl5/mezb8+FVZPNkLu/4BfQ7pcruvI6FgFsNC6WmmwSkf8YrWriMzTgyO5R3soW4goO1WIeNxpxQTNYoNC5x7720olsmm7TA31+fFBYyJX/S9jggsG1Gk5HvvPCCZKi7AJV0666nc7ytJ6oDfuEoas55o7p4sMxCwLoStId75KmnTGan5RwzUQyB6bJawtC0Y4mVrUVBDngPZUs0qyoZBIMt7nesiIjFpxkZV3gR9CrpgEr/KL1+UQaMlAeCxgGhG7gRFRjqBlBsDSv9+XYMdNg8F+b2T4FExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jiq7VkQ5r0Gt4T+SnucsAAt3eUWkpw/ZrSEdYpTcxsM=;
 b=TLDd2ByMsgUi8ZSq2UbX1S/aMAjZxXONfqxUi4NFRGFGMZabCOpRkeV/mzy1491yxSr7i0Pk+p3J9esIhOgkmyGdP6hOz+hHtNw2Wwft51XXtdycD/UEGw2RniUCaZr1HPAR0Nsd9dFAi1MdP/202WMhn9EgWw2ZvKhV5bIKnCcUaOAPWGPS3yKZnJp6O5I5nFbtzeAD+JBnK1mRkQKvyDU0xtdXifBd5lIXI9d0c8rBYxolIk/6hTFA+Snhgv52WUegXgdDoJoTgtKkU2F3itbhNK9B00e5u00hCwbC7g0amdvSZDRkXC+p1igmxA33grIlZhoAILj8wsYP462zSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI2PR04MB10859.eurprd04.prod.outlook.com (2603:10a6:800:278::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 15:29:51 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 15:29:51 +0000
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
Subject: [RFC PATCH net-next 4/6] net: dsa: refuse cross-chip mirroring operations
Date: Fri, 13 Sep 2024 18:29:13 +0300
Message-Id: <20240913152915.2981126-5-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fe90960-c944-4bda-e316-08dcd408e8e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Qd6tFvOJkPaz/tcruIlWHZgFP9icAK8Hnqlp1pmBxiiEk0sWYKIBLXE2sf+?=
 =?us-ascii?Q?7CDKkjacoSKZ4MQblgDVQiNjNZD321UrEMZtAgIzsX7fkBmxY5cCrTFvoZ9u?=
 =?us-ascii?Q?ZeovDu0psMSoB6acgzNzvEDxyPU/FC70nt/dg2isKhkJop/RqQv43hM34sXY?=
 =?us-ascii?Q?1uOtJr/AkJ7S/QjwzAIQUvYFdGJnltuYOLBWoRAwbuPm5pQJu/c2POg1GX3I?=
 =?us-ascii?Q?1J4I2bNyjyEpzcQX9wkXcBniMvJ6C+khPDl44rblFTBilcunt+7SI72VdzrL?=
 =?us-ascii?Q?TRidDC9UHas8wVgzpkgXZERQM60bGcfhfra06UDzSwX+9GRr56/DJAlQnnmC?=
 =?us-ascii?Q?hfjvofC2zeW/uckAgH5792SKixypg9WNXFqBydGDNngaV6RdNGjnwNw9U7yf?=
 =?us-ascii?Q?MKIXQV4Z30GbWQ82rFtdlkn4YQU3kPoOPsuHwsZ+O16l9w5dT69TpdJEdF2G?=
 =?us-ascii?Q?Vqdcmnk5doTzcaxiWMZRgfP/Wb5XblhdhlFiQiKDhJvNYU294I9AQ8vQ+o6G?=
 =?us-ascii?Q?79sxqRvorOk0IKDkW6uhNNYhlJnuaiP9JznPEOOHAvOumBrkqrDWXHCQlrPV?=
 =?us-ascii?Q?HpdwfD7ZGZAJjsuObjPBveR4aqak68AmAd2qi1m7w4KQaoQzmqKQnTQ8cS0a?=
 =?us-ascii?Q?lSTNJTpu7rGfY2lIMyqeKKSFDzKhug+Nqq1XmVfvP8ymBnMp8NqWD9/+soCZ?=
 =?us-ascii?Q?3xGZvH89vWXZAOh2u8GgVkzR/IFFUdCFaCjCzVDaZOLNRLz8I/Q1ajlyb7Z0?=
 =?us-ascii?Q?h30/QizgGP0ymR8y6Ho2DvcSLbZ8HhkYM9TAPXOnxGDFtK3HgUC7ayEMYpYL?=
 =?us-ascii?Q?c1H3dBnamj14GKiONO79QokLfvEL/+Ac7vfmSaP4f7D11XaovGFz97Hc5gRI?=
 =?us-ascii?Q?fw9TY8yHIljqOvb6uOkUxeEOUxvu8uCAsFsx25qUdsY0N/7Em2RzRowQfkAV?=
 =?us-ascii?Q?TS/x1ecLB3ZC6qMOyDzHhMj1IR5M0LztmpU/kjygG9lemB7h7Uosp4RzF9kn?=
 =?us-ascii?Q?yBnXmRMXTpqyFByimka3WdJwr+fLWWsnGqZvxPnb5dagCaahqPBDvB/FrQC6?=
 =?us-ascii?Q?8FNquVEmrxr5l8kL/Vpuik8xlD4P2l0jqMg3vf5HV7ibOCiZtKzpARm/AKov?=
 =?us-ascii?Q?QL2njFYDoQCr4JiK0I3lFS2rNu7cpaCAqqCQPufJF7VKxGtUmQLAUrgCmV8S?=
 =?us-ascii?Q?mt2sDHacyvj1bDGb24lYcGdQ0DF3nV7RWFgeR3Bq+SHX6cJ656tIFF0wP8vJ?=
 =?us-ascii?Q?+1vwjBZTJ9KqdezTTSRMCooVSYv8/uoFIx04Arkh1yaZLmrbgahx7nCACW4p?=
 =?us-ascii?Q?Cm7xpRA2SS841AGReMTUtaqRBA0g1XZx2OJXCsBuavfnVt8a0WmwENj9C8Ky?=
 =?us-ascii?Q?WE8wkTkPU0ycs9Vo8GnHWOSFL1PPvS9WsRjsfJQlM435hIRMpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CrGoPsej3W8IphdXvmMBAtvnRhhJemz/jen2kkBVr0iD0BXUi2yoLo7EVd/U?=
 =?us-ascii?Q?R23m7zzJqoVHA3y5KlLNgzIoaEUzY1sIzoD1QTE1/3FBa+hQGS59NewlnjIe?=
 =?us-ascii?Q?C0RLuUjPQj+DswZi1rpgGjDTsqVcUUwozfGs8XpYLhcv1pA5qnRbC2q0nvqG?=
 =?us-ascii?Q?UNUbclBlBzcDGaoO4+3r+qOw+s1pRN/LmgbBomQai0fU7arxJKTF2FjpT0A7?=
 =?us-ascii?Q?VL4F6Geko6wedNMnRQsCarwiYdiz0NwOiLsv3ufJS185IYbpSwf1UtcROsO8?=
 =?us-ascii?Q?1UOQj7QvW8y409mqjbWx9Baqo5O/B4P4zLgz+c2jVPUOQRyOKLuwTXEV3pS4?=
 =?us-ascii?Q?gytXVCRWePt8Ij9EuiaqdO09/lTK546kynvv4W3egTs0LjL1aEvIBPfMnOdl?=
 =?us-ascii?Q?jhFVSc9VZUtPLtpfhnOC0Sq7Uw/RVpZFORBa8HFmJHrASRt0oVVsIOC/QcSl?=
 =?us-ascii?Q?qGTBu+4YEMI7Qpsh3Mf0ROAZhdy0ODcf3y8KFhMdKZM9rAUuBENc4srlOGLv?=
 =?us-ascii?Q?nCGVIhBoOWyT/jfQmmbyBWk02QJEtK8WvA0kp698PQ7e+Cn1j14Z0D+A0DQa?=
 =?us-ascii?Q?Q0VQ88Lm0LKeNdI8sbFfaMn+vH0lJE67wKZo/uPtSRoM5B/At8LcFzQaDzNY?=
 =?us-ascii?Q?MG0j1BUlpO4m1+I7VCPqFqpRnlFvlJycPWMKmXUWZh4/Nr4YUrbSkOwBZfzT?=
 =?us-ascii?Q?I/VNzdO++997kzd/HDwOaoin/8WxWPrRYBTM2wLnnf0FHsJMQmVFVYkOMjkx?=
 =?us-ascii?Q?rjevbGmCMCCEoBmWH5y3FxgNzev9Cma8a2gL8b8rJtnorpUB2YGxXW/rOkyU?=
 =?us-ascii?Q?KwNbRgE9tOVzeNFR9yPhos88FFB0eatCJKrCb1pdPKOcmjMSm7Cw3TINEuFW?=
 =?us-ascii?Q?0cH3qctcW2gD0L6+grfP384+TW3QcvySdUkKcKqtOavXIruaReBwnpf7j0+e?=
 =?us-ascii?Q?FoZ5NzLthPv7xtqt1++IO0o/cq7cP2FbkYSvy8SmIMWx7qMr0QqYQqvNdILv?=
 =?us-ascii?Q?9JE0C8C7J27cAfx4YYcmz/TdGekEJcUdVlRp5ASw7GfrnybCetxAntQpEqCR?=
 =?us-ascii?Q?H/XRq/Pu0H2vmFcWIa1wLbuYyrxR7pSXgSamO6gW+G94/4LZQ5sPQD0GiL2j?=
 =?us-ascii?Q?nxN9MY0YbQwoQDGZPYoXjYwVYXc6wYxuHsN+IUpYxHF+Pc6zy20+9yIwf8/0?=
 =?us-ascii?Q?D2y4pAwzvlc8rlWstlHgiBa/35CclKILKEnIrMJnPAZw3ZufC9Wb+pwKgm5L?=
 =?us-ascii?Q?786ydLxJwynehpO/wM+Pqxd+eb/3FrNLltB+gL34Chh1AVhjXKAEOnTuxBJ6?=
 =?us-ascii?Q?yNr2CO/33e1eZ0z482n1vhRL9BkehLYjkYtgSAZSFebg3wckkT8D6zqgJt3a?=
 =?us-ascii?Q?N7017MLZH2j709WNRi832FFRzRCTPtig9FH14S7QTGf5ZX6vuERGJf9IABO6?=
 =?us-ascii?Q?omF6If16GcQRBFxAgD5NBmfWL1CofC6I3d27su+0xAX+DfV8krX7R9bLuTvM?=
 =?us-ascii?Q?cGGPDIqZBptubNcX7HQ+0hQXBepTzFyX83HbHRJYTki2XvnVVPBB8WpfrE0Q?=
 =?us-ascii?Q?aJGpVbSX52OyPf+I7GLaHaf9kFk99V+VNDR8zX8MnoSNVK2cRsOPr8HzLFO1?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe90960-c944-4bda-e316-08dcd408e8e4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 15:29:51.7118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvRA0KN7WCsOG3LDM70EYJ12cYtTOhqgKg58AMVTxwfUxbqU20Qf2FtNN/r5X15V5AyoOCHX38KKRFLHzQlyqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10859

These are not implemented but are not rejected either. Do so now.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 42ff3415c808..c8ddbe22d647 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -1401,6 +1401,14 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	if (!dsa_user_dev_check(act->dev))
 		return -EOPNOTSUPP;
 
+	to_dp = dsa_user_to_port(act->dev);
+
+	if (dp->ds != to_dp->ds) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Cross-chip mirroring not implemented");
+		return -EOPNOTSUPP;
+	}
+
 	mall_tc_entry = kzalloc(sizeof(*mall_tc_entry), GFP_KERNEL);
 	if (!mall_tc_entry)
 		return -ENOMEM;
@@ -1408,9 +1416,6 @@ dsa_user_add_cls_matchall_mirred(struct net_device *dev,
 	mall_tc_entry->cookie = cls->cookie;
 	mall_tc_entry->type = DSA_PORT_MALL_MIRROR;
 	mirror = &mall_tc_entry->mirror;
-
-	to_dp = dsa_user_to_port(act->dev);
-
 	mirror->to_local_port = to_dp->index;
 	mirror->ingress = ingress;
 
-- 
2.34.1


