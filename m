Return-Path: <netdev+bounces-136638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C77169A2868
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866B128604A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772591DE3B7;
	Thu, 17 Oct 2024 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WU6kCcjW"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2071.outbound.protection.outlook.com [40.107.241.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCF5FDA7;
	Thu, 17 Oct 2024 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729181993; cv=fail; b=NXE8T7rLNaCJT0PmDR4h673VlCQad/PLw6UM+O+ECoF08YI9jQak0Q0oOrZb9aFCV8Ywn2tSNSHlb3NtArn1m9eksFiMOCOJsDBTsBoEbYshFMCTb60bFS5GRpWDRgckQcT4EA29mKcA9mprWZgKx7fmSs0Hhcfzct0Z2jPhHSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729181993; c=relaxed/simple;
	bh=w5YRo/s2cFQ38Oa/W+1U2aCYuVAvqQ9Pkq0LMn4c/to=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uTERTuLvZFe3BWTBZulixgwYCDZ113L4AqQbXP2AZ7etR3C02b4AqQBK3mi0l+Nt0J0HF16UgB3bR1bH8O2T0UMu473mbiDLtpmKWYUZiMUSQYoAH6yfb2EAfw1wlgVJLQLdUD1YeZzv4WGFKi9hBbaYylzXt+7UOQ16q0OJjdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WU6kCcjW; arc=fail smtp.client-ip=40.107.241.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/2GAqnr6r7YPuit+x05AjAEmxPGPRBwWlYEfo6e5s+hO5mazuXvuDP/BT3n3pt4NvbTygX1yYOc3ycsa8Oql/Sf35nXIdPfs8o/j6RqZsB5LLNoYZ4v/kZHnKWA1NkeEPjBuiSQui644A4VQrzHfeJ368z2OL3AS0ULef7DSxStpqtEa6nKM0CS/5TqJ1+1VnI5mJsLA8s/DcW32ZyWg2pEacEvwaKjp3wI2o/CzEKHBsDD0ZMyDU1TFcdfDIzzu99855zsegJRJxO5Z8T9oK4n2xOb/Px1NiLzgw1mSpC6WNmw0QLhc8EG6KL8f5BfQjlCWEk6iqoyGhD2xRIWWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW2AU9dQyLzcRwHF06qEAGxzOY2MGPGpibP4IethsI0=;
 b=oQuoMhAdDVnFP64cMIOS9CyYrBvJCZH6RmKoM8Tw7C4idK87STLiUddk+JGiZNcCnURaIEOLFkYje4Y9+LQm/w29AVrkim0v4KOmn/MVQNGvVXZBDr7H8rj0gJl+Gbcu8QHjPqBz69cI3tffQ+1aD5ia0gTue4UzryXRwkvb3uLN8d+yRnnHVspMZrw2ChFI0NTabE9Pa2Nj1usDqZWeTyiptcbgRK/7+HoQp1EpqtJRqt9Y/WnlHIgNvwzCPozAUYY310jns7saE0AYjqf6erHPg3pniCzFBbJQzbEnqdsVDk5SKvhsp7jzv5GwRyeIeCeA+rSCqpos3J9Yfh6yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW2AU9dQyLzcRwHF06qEAGxzOY2MGPGpibP4IethsI0=;
 b=WU6kCcjWUrAq12pcAMIl6kJ2PmuiQVb5KBtskcw2YP2fTvS3ppzrqN6udIJn/pf5chtg32rkwHQKejZOwvfjCsF8Mxrec3uF4/uMWvBGeKFVySgNDhjQRIeb9eQA7WmVP/FzWme4viLAEvM0YM/HMjz+lqwv6Z8RJu/0TiE114htjP6VwllDAP+d0AvpvGaKOT34tdN/JdIOW8Z0L9LdRehQADFYiq+LZyW6JYUb/c8onNcnH8x2WLAPnWWM0UxDdVgtgi5LNb58YkpGzkA5zuR2CQoM9vatCWMy3jcvkq1paI4W4SB+P4/TWzh4Io2OquRiN35mM/HAe68PiCquig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU2PR04MB8966.eurprd04.prod.outlook.com (2603:10a6:10:2e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:19:44 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%3]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:19:44 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Pedro Tammela <pctammela@mojatatu.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/sched: act_api: unexport tcf_action_dump_1()
Date: Thu, 17 Oct 2024 19:19:34 +0300
Message-ID: <20241017161934.3599046-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P194CA0053.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::42) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU2PR04MB8966:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a09a5c-ef9d-4d04-da77-08dceec782f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gLa0ETniSEs5/uOgrKm1ztJWo674KyKQ6d4doHGeQaPt32IouTW5HoJvgMlP?=
 =?us-ascii?Q?ezozZHXlKn8160MO9OkMcSDjBmrc1xjCUZAn5f2saBm2zb39WzCYjKTlQgG4?=
 =?us-ascii?Q?cpY5wmnJMa92faSE7I52npYqyyY7y8XStIlTkLgHE+PXNacDUk9gg53JkIDD?=
 =?us-ascii?Q?vvNVh/8+nvbL35bk48S+ldJn8dawwFDLgxyVqpPUk6MNIk31PNFjnSnLhAkc?=
 =?us-ascii?Q?FkhkXfNuUIxcAZZZrlXI2NgTM1zkNrYdFaOggeebdSZY4DUoulVjfXDUqWwa?=
 =?us-ascii?Q?F7hPKa46hfMjIsHHeoQpwB0SBopLs4mF6zJyF6sbA90cqIB5xlkOGJVJ2EtB?=
 =?us-ascii?Q?BKiGJXP4x3Z5BVyOf/Rs/epzVJtInfEXzO0evHRlT6vQowaGmVaeyimophC/?=
 =?us-ascii?Q?GtEi94S5hYEXsdEilN5+1Mcz/K6EES4jEjREVQPQLNm/ihKlymT9A2yDm4jT?=
 =?us-ascii?Q?8qYbZmDXSLy21mcvzJo9wYUy6arR1bYD033NMjKIccCrG2joG+vKYEh3Y7P9?=
 =?us-ascii?Q?xz1rKqPHwZlltFmnAesEos8s+ykyZfyRjWNVu90cDYd98R71BGKT0j4wqXAN?=
 =?us-ascii?Q?NKTvFjr7PbJDJwGRObwn10ql1EOyfxSStAE4elM65sRSHL0YBzQ63kMyy2sK?=
 =?us-ascii?Q?ehxbaGtMc0JUQWvWfxNkVFTTpWLSBXHSmyJc3ZzAigg1XaDS6NHyCRqk28hx?=
 =?us-ascii?Q?VJxcBGo5M0V7A4pYJv4AxImBXkszVXJVdBwKO/oVlJ89njgQ7gwWfJnfnJHs?=
 =?us-ascii?Q?V54vN67/aT7HpbvqWGbjgOcvIxydjCDi2Gd+ch6VjNL4c8p+lYMdChnQ4U5v?=
 =?us-ascii?Q?KNKUlJIqJE9LDeKG3Mk9LUPQlLlAJjxsQj2MZ8NzWNKEykvxz4SY1WkO+6WK?=
 =?us-ascii?Q?lNn5nu6waZXf430gb/9TIVecgo/r2jXjTN2W/XiEC6CIfVbshvDllotQNH3z?=
 =?us-ascii?Q?rZsU0E0B7c2SBP4jyago1fj+eO8lDZpcubxeuNfcMy7krtFIgf8Biav+m4sq?=
 =?us-ascii?Q?Iz2XEos65QhiOm9QMur8d89mHBGU6cEGJvZaiciK/Nq/eqe2qzwrf3chonGk?=
 =?us-ascii?Q?rWdn7rv+4CTAzW0XtQLqRpiGnStoBUDVqs6oWctSILCxlek6Dj+WbHvkZwx9?=
 =?us-ascii?Q?PuBOphxjnbgHj+JDopuAJtNgOESsH82UTVja9Af6WgJll8JjhLtP+cdQo1L5?=
 =?us-ascii?Q?5PaeIAzrcOgP3+vy60NwKD5IWqiJI5ENegW4j4ujeiJDh+byGdxtQW7ZQ1OA?=
 =?us-ascii?Q?f5E8Ha81GRHVJTZ9Fgd/kweM8fFavpC87brd8AUv9Ok32FrXNtMHs6IewcxS?=
 =?us-ascii?Q?ZXholUTZoszMYlmzb6IZgHQa+0jE0riublr2f0jX2PX5okoe/9BnmeCWbzww?=
 =?us-ascii?Q?PsTuMXU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/ykhL+zWCyakZn9vOiYGkT1ShUemZBYmR+6N4NyeRNLUfBZVZjoz8VyV62rD?=
 =?us-ascii?Q?7tPtBnN6Tq0ICgbdhTiT3tPUAuBssUvVYcN+rVNYAIpk8QuepJs6fSf3qUK9?=
 =?us-ascii?Q?hIuO6QAGDJWfw/72NWSIasPddS6xyRcb+JvUMe+r8ygZvBxNLFv5r60X26f2?=
 =?us-ascii?Q?oAhEpE/xfEdl+/Fwl0gfreSu0mHimxj3qC+TTpYvpOXPrO0QtOpGmPkaL09M?=
 =?us-ascii?Q?TFKIdL/mtlSv0TH32vgazXh1WOGvynzHqqTFmgRiL8n2WKJKdLoWGOIwZn9Z?=
 =?us-ascii?Q?sf3db2S4hZm8fMrzkwDuVcUbDQW26y8lyGFJsifGq4LWFmxczCy5fxfn+rpg?=
 =?us-ascii?Q?zKCgYxUaz3umjiNyGRcxywAoN/ns+H1S0G+R61g+RljcM3p6COOI3Kj/ZSdj?=
 =?us-ascii?Q?RaMOwX5OVc+UyAg8HfnUXO79k70xICSlVTVxV71r52UaUWw/80U247BZ85SZ?=
 =?us-ascii?Q?uNU1FXdI2a/vXVCqE6q4yStsVWx0Zw9Tfqe1VkFjSQjibYlTWu12CKBL4tkl?=
 =?us-ascii?Q?pDKZYqaGTJG1qHz6kn/8+ub76uV3StFc9/Ykfnxf8RXfLj7lg1pvOJwch3Y4?=
 =?us-ascii?Q?UJMMjT48FFba0WPg0wFfvz49EFHCD8e0s8TUt7Vq3JRcwycfuWX4YBbcL5dK?=
 =?us-ascii?Q?7MvV9zTj5CSJLVf9wTLlnQ8cpn1mYOBtqFkAbYBI4kuYSWHlNSy3xfkXdG0i?=
 =?us-ascii?Q?naeTOPppeU/FYtj+mMhzlg9nWG413+ahqvdtbm/0cmt4sVyl0LvdqAPoteoB?=
 =?us-ascii?Q?ZND+DsWmjnbE6r8lsp1GIp6QW5yQxYn8B1ZD1Ow4pl50lCw1IFB5Iq+jrHIR?=
 =?us-ascii?Q?2QmJ+/ig4S5ZZvhe4lpsQF91HnlSVVUfZauD99s1oEYHAeaHbdE7sJBpG+Y4?=
 =?us-ascii?Q?0h/qyQ9t/ykyz6W51/ieLAxL+C1ZfrC6i49A5AMEI9pLzFnUKlMUuafhMpbC?=
 =?us-ascii?Q?gO38+jdd6vHldy/FEdqBSQ8LwCWhkvK7HNlDqhDT8wSjbkyscx1EYkN3t9du?=
 =?us-ascii?Q?Zl/tpqgIS89+XLC0bo+rgjg1HYf20U3Xf2pWc6rHuPu6Fy9CUm2hXIulua2I?=
 =?us-ascii?Q?aEmo3IjhdMEfSuScAFjET1Tt/bBg1jNU+GOK2OFcuxl9VbS+PepAOJQJnotA?=
 =?us-ascii?Q?6SekN881Nwy1PqRNiMQalPYb67aTWX6ANO7vUIKu0PEO+bCet1TsQM278Nyi?=
 =?us-ascii?Q?JDJpVV9eLnQAX/dfjiaK0zg7y19906k7cH6fvNGEPt72bTQN1shrZD4KZx6L?=
 =?us-ascii?Q?Tx1TYXqZSd44MyGPUUiEleXnGjDMXoNq3id7WSiifVcCsMcOJmPfCBpMOkQU?=
 =?us-ascii?Q?L5kewsaenoFqE+eEmeC+vEy8ihraJCZmUayjxYaiaJa0LZ+8oGbO+JDZJSGF?=
 =?us-ascii?Q?S9kzINdfnBEpt2u/249+2lQbdrHGKZU7eAoSh837Y+aHMyxe3AolKQeQkDWb?=
 =?us-ascii?Q?H+GWieH5ETlVQ6H86AFUd7vnWM1sPYgDb6F0PN4TqNps4n7GhRFIPR0RenRg?=
 =?us-ascii?Q?Vg/U5G7yJtKpwYZUI+4WdgcIpxfC4UFv8VSV4KTFMkHkbCDrshX+RLgF5N/d?=
 =?us-ascii?Q?w3Gbz5+HwJ76n6Mop9gapixg1NDmx8rFQ5y3nIK8ZBw+L2QPvlQuZSZvlWzf?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a09a5c-ef9d-4d04-da77-08dceec782f3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:19:44.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrZIOLy60fqEQS2xZl+Fa5bdxGxFjZzX6nVsescNJqyzIB4/WYbFNI18yiZlq68REKBpfaEGjU0oEtoHMySH7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8966

This isn't used outside act_api.c, but is called by tcf_dump_walker()
prior to its definition. So move it upwards and make it static.

Simultaneously, reorder the variable declarations so that they follow
the networking "reverse Christmas tree" coding style.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/net/act_api.h |  1 -
 net/sched/act_api.c   | 89 +++++++++++++++++++++----------------------
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 77ee0c657e2c..404df8557f6a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -219,7 +219,6 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[], int bind,
 		    int ref, bool terse);
 int tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int, int);
-int tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int, int);
 
 static inline void tcf_action_update_bstats(struct tc_action *a,
 					    struct sk_buff *skb)
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 8e705b212c14..839790043256 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -504,6 +504,50 @@ tcf_action_dump_terse(struct sk_buff *skb, struct tc_action *a, bool from_act)
 	return -1;
 }
 
+static int
+tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
+{
+	unsigned char *b = skb_tail_pointer(skb);
+	struct nlattr *nest;
+	int err = -EINVAL;
+	u32 flags;
+
+	if (tcf_action_dump_terse(skb, a, false))
+		goto nla_put_failure;
+
+	if (a->hw_stats != TCA_ACT_HW_STATS_ANY &&
+	    nla_put_bitfield32(skb, TCA_ACT_HW_STATS,
+			       a->hw_stats, TCA_ACT_HW_STATS_ANY))
+		goto nla_put_failure;
+
+	if (a->used_hw_stats_valid &&
+	    nla_put_bitfield32(skb, TCA_ACT_USED_HW_STATS,
+			       a->used_hw_stats, TCA_ACT_HW_STATS_ANY))
+		goto nla_put_failure;
+
+	flags = a->tcfa_flags & TCA_ACT_FLAGS_USER_MASK;
+	if (flags &&
+	    nla_put_bitfield32(skb, TCA_ACT_FLAGS,
+			       flags, flags))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, TCA_ACT_IN_HW_COUNT, a->in_hw_count))
+		goto nla_put_failure;
+
+	nest = nla_nest_start_noflag(skb, TCA_ACT_OPTIONS);
+	if (nest == NULL)
+		goto nla_put_failure;
+	err = tcf_action_dump_old(skb, a, bind, ref);
+	if (err > 0) {
+		nla_nest_end(skb, nest);
+		return err;
+	}
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
 static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 			   struct netlink_callback *cb)
 {
@@ -1190,51 +1234,6 @@ tcf_action_dump_old(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
 	return a->ops->dump(skb, a, bind, ref);
 }
 
-int
-tcf_action_dump_1(struct sk_buff *skb, struct tc_action *a, int bind, int ref)
-{
-	int err = -EINVAL;
-	unsigned char *b = skb_tail_pointer(skb);
-	struct nlattr *nest;
-	u32 flags;
-
-	if (tcf_action_dump_terse(skb, a, false))
-		goto nla_put_failure;
-
-	if (a->hw_stats != TCA_ACT_HW_STATS_ANY &&
-	    nla_put_bitfield32(skb, TCA_ACT_HW_STATS,
-			       a->hw_stats, TCA_ACT_HW_STATS_ANY))
-		goto nla_put_failure;
-
-	if (a->used_hw_stats_valid &&
-	    nla_put_bitfield32(skb, TCA_ACT_USED_HW_STATS,
-			       a->used_hw_stats, TCA_ACT_HW_STATS_ANY))
-		goto nla_put_failure;
-
-	flags = a->tcfa_flags & TCA_ACT_FLAGS_USER_MASK;
-	if (flags &&
-	    nla_put_bitfield32(skb, TCA_ACT_FLAGS,
-			       flags, flags))
-		goto nla_put_failure;
-
-	if (nla_put_u32(skb, TCA_ACT_IN_HW_COUNT, a->in_hw_count))
-		goto nla_put_failure;
-
-	nest = nla_nest_start_noflag(skb, TCA_ACT_OPTIONS);
-	if (nest == NULL)
-		goto nla_put_failure;
-	err = tcf_action_dump_old(skb, a, bind, ref);
-	if (err > 0) {
-		nla_nest_end(skb, nest);
-		return err;
-	}
-
-nla_put_failure:
-	nlmsg_trim(skb, b);
-	return -1;
-}
-EXPORT_SYMBOL(tcf_action_dump_1);
-
 int tcf_action_dump(struct sk_buff *skb, struct tc_action *actions[],
 		    int bind, int ref, bool terse)
 {
-- 
2.43.0


