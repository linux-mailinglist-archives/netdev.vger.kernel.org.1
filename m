Return-Path: <netdev+bounces-271153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAo3Lmq1wmlilAQAu9opvQ
	(envelope-from <netdev+bounces-271153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:01:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA9318870
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF197305BCA1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B036C9E5;
	Tue, 24 Mar 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lwWR5P7Q"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B238AC63
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367771; cv=fail; b=b/sW7lIIRxp3KJ0w2cikaAJIT/S0NyH7g5OsZ0Hv4l5XNRw2CkOfng9QVMlYqUFW/vSrZkqDpCyugzp7TyaMkmeqR/yoJ6hMqW8EwRSMnfRnwt6cllOvRAeeo4X/cc+4yUDkbIAda87xBFwP/PO4itejULveZYjSfGCfNFXKJQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367771; c=relaxed/simple;
	bh=TexOWnkqNkt4KbYvCQauK4VO3+2xXZAoSApgJV6x7h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HausaKECJNCZ9oOt7tUjNjNxNC1ckfm4bQfAgqTXqo58lmnmxAayH0piIuijPhX66AhrDMyo/4GqB7dPEvFTIFMJ3SJmFppjwofvniQHLY1umZyGwlqoWcb2DH+V+i6O71Zhev5+IRBcbF4lbhd6NWx3GGfCSiJzLB4hrVwJi2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lwWR5P7Q; arc=fail smtp.client-ip=40.93.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qM+D03+Gbat4qt8T6bMnnhcHKgY1VfQP40/S5S4VaoMVgzVyul2A2QtQ+b06a/IqvedEs7f58AU8DuzUeerCanJ6nLjE+tQMVHhSypNEMhLOGePUFfiBVtRr915tgFDXjXBdewk1b37zUl3q9f0IKgS6PJ+7q2+MlPsiFLDABfPHNjUH2N/vlO7VrlLOOdE3ImuxdjAI44XkrLjnJUBPLIluToeaNvgjc4ZfDtIprjIaH3nfucqNEsON0gmKtXBI7jaldKeWBYxw/CcWLCgTliBzSlP8CZotHUvJVHBotavlps//DP8njhRl7oRC0Ll7ZsLQStyYNGvW53BMlA9gCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrdMr6KBu8niNqSBO6YqMBtMd5Px7MUH1Di0xEtGv7I=;
 b=hsRHPZI7yG1cpZJgekOlSbXMhhO+gcZSuCUMCG+B8fQBwdkkfmOejF/mzTfe3/ekTGQ18XuGSq8TEAxjbM/km21mZHUs3Hwid00chNee894l5wfzM4oie26pHOn1alu9f1iIMsBGTgzCAZ6laNNtFiXvCiuQUn8zA2+1fB9IiyN42ofBA7XIvRTg0fRrjujbm8CGJBgICKwsgnBVglN1ve37YsHYOauPeHNscvm83rwWMBLJfJWIdRiixF94CpqwF+V3tTvuou0ThEyWh7HIvIAREgmCckT6Ifos8WX5gGx7eljyL3/9NdrRt1gYrr6EsJUcd9JbnqEErgMf9bvqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrdMr6KBu8niNqSBO6YqMBtMd5Px7MUH1Di0xEtGv7I=;
 b=lwWR5P7QUi1ZrDN78N+zVR+7fJyzNbQeDT+PBFao5LVbOSc8LJqbYzMc5ziRzSCc0q5+L0byv4oETnKiCtePqNJYFZwuiTtCUHpzqa1eRrVsfbbb/1JuEI9CyFXO5DQJETgtSmlmswxvjRX38ZixqbIsK0vN6Apz4HH7bBSDa1LESO8dwSkM1zLu8KyVE6N2HqbxStmp8o1d5YnIvnVrtlQLfqzeCgk6fF5FTLsv3hKqjdu0OIs6zcNXuNCkrxsBs5uPwUFbqiS4c2Z2QNq9WvGf3UJd+JigQadXjaNHMYxmFdkAt11cZwFmoeEuQ72ESJOH4n77PgZVUAYiN3ZxSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by CH3PR12MB7668.namprd12.prod.outlook.com (2603:10b6:610:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:56:04 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3033:67fc:3646:c62f%5]) with mapi id 15.20.9745.007; Tue, 24 Mar 2026
 15:56:04 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	lirongqing@baidu.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 2/3] vrf: Use dst_dev_put() instead of using loopback device
Date: Tue, 24 Mar 2026 17:55:20 +0200
Message-ID: <20260324155521.525292-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324155521.525292-1-idosch@nvidia.com>
References: <20260324155521.525292-1-idosch@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|CH3PR12MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: df74dcbd-21f9-4b1c-08dd-08de89bdda26
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	8WVk2FEwmzw3fUri/dkgvx7zD/v0mhuD+REh8oCTiH+upweqY3YWmqzm4UBJAPqAmrlJZ71UZBZqMbdYgT2G5f7oSL2sn5Fsxo+NlYi4fBr5HJe/2mzzhjB51PhP1rBnQA7vtvKw/7I4tyfViBHFR3HwK2vLADgwSYyFnFiHMYy6MRyLyiYmxhvG9kf42MrsgkWZDPNdqFm3OBWMpFv3+nOJVpHRhtZuEv7DF0O1sazlSn8cPx0ImAyT23i/uXu9uoDOvUi7zwFCig4cXyzj5d9MbDYTsZ0eYuPsvAuttLdbnynXRsw2fTbq+cGaf2MjOp8owYS58qLahg33g5AvakXsYaDTgMHfLQaqS/bqdm/utX7AzpxP7vXEy/9I9OWzBYn8VWmrerHGOjaziGlvMQSGcYdYyF8TGULI+WT30agLhWZ8qum8j6ZC+a5djgZYdHOkWIn9Xw5h+vyQ4Eob6/lBszG545iMe5JeOKcLr07kDh8IR3Y9ztG3sLFZE2tVh9bm1ru+ilfdVkw6lEiAgc5NT8kCDBsRFojZYCxY07oF8FdXLjaJiwp/EXi3HKsjZfFIWm+ZFwUrR4X7BOzn8PRtp268WcrEFbyOepxipw/xvHtklxd1nD5iUanFqnFGUzHAWbmrpXrpx58j2agb+qy96MBdkMGkjbJn494nX2gVjg3lCxl5+VY4jKGH2gLbh1zmNYXMSboKIgTtX2x5h/uY9rAb75ptcQHZ7S8vw6M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+XaE3TdrT1hsT3PHH9usVJM31/mtI2R+r9rUuJ0npKXMvPw3S+fg9t9kVV67?=
 =?us-ascii?Q?aflxQpESg504UvqGDifkEHCc9MDVhJVRuzvDomAolAju5oE6BItobMRvIUpB?=
 =?us-ascii?Q?4r0YnHRpQVCVsx72vHmxGYMDiefGSdGV6M7m9W6oi5DXZ1TkskLZczbqyBwO?=
 =?us-ascii?Q?ZE1IowgnAU2vM77HPMkOZRqNaifRveKJdL79v1RxYdud8/gYx6YrKJ6AYZYu?=
 =?us-ascii?Q?jzY4iSW5ooRmIyub7ClcG/IPlVe7lDKb+mVrHH9hT+XwEmJl8sEOY5QlB5hd?=
 =?us-ascii?Q?/GJpmpHqVw+7zNBvenKRNot/kXzxVf5aihvicG4ZRB31V707QcxpKsyJCqsa?=
 =?us-ascii?Q?ZQV88DZtipmbW8raQV5RZrRE6FuVohytarllsdOUFZeKN9h9ng3WLajush4V?=
 =?us-ascii?Q?ZX9osWNFGTp038y8AUfS/bZMZdAS7izgk5WTMZ055SRmPx5tftNSDbDD7XXg?=
 =?us-ascii?Q?KnPd0z1DlmbdU41gBpcfZUGWGPutMjAteDfZk4mmalNJl1Gu4ZMFcEWogI5L?=
 =?us-ascii?Q?+p1YJM/weUjYwoNXx4OjOLn+2YHxas8WgulaR/iVds60Q9kNooZVcJ4EuqJy?=
 =?us-ascii?Q?Myynx7YOyz3K7UqbhlPvRb5ui6oh8rNUVhwj/WNoB0c2Zo7lHL2Sh7lyCTG0?=
 =?us-ascii?Q?vvFdySpUuJS0ophjKyuY7NRlrdLMeXPeN1X48J3BvRp9vyaFBZ7PKmTGvTVD?=
 =?us-ascii?Q?tpIHgUyeYeSdpz8nUevgf1XAV5DE/TfS2wqIy3xHMUNr1aFrvLLh0NbL33lK?=
 =?us-ascii?Q?RegWV0CruegIwj/RNpIcgU8WDdR6iPfYj/ZrvmoFyc0lOUIJswMu2dux+1Yq?=
 =?us-ascii?Q?LoEtrJD3CJQlNwXUzWBworwJcnAP6IRRtfBtYQUd8A7E1gzpprgKOLLw56Hs?=
 =?us-ascii?Q?THOMdyrGOkVadsIVuEycP1m+qFMQUPRxT7/e3Dy7VAk/tFYk/ReKnwJtwClj?=
 =?us-ascii?Q?QoDaRK5I5FEOBjIturWCbSTlawmBMd2AIJ39MNUrilr8zwMnfDOyp+w4jGxU?=
 =?us-ascii?Q?Dt/o5ABnR58p/1YO0x3EF8lKF/10hdpOkLNWXP34GxpDTVu6EICF5/KsLTJE?=
 =?us-ascii?Q?i4E0ine89/glIdZ76lZn1n1LemwzO/TvEDKYof5OJ9WFM3zBI54brEVemTxi?=
 =?us-ascii?Q?8HerVCgDYEqpDtUsGRr6VVKanldcGTwwN4DCfbytsog0pF7l49BXWQK3+For?=
 =?us-ascii?Q?BbHGEmDPO2PEMTI8i3Huf0G7VFYhV3h6Qut5l20+mpGUfADuov02pcNrw/rH?=
 =?us-ascii?Q?K9BUmQA/NchAO2iWG3QkkSiuQcpzambar7ybJfYFDBwEzEOlweBIpZrFw+Fw?=
 =?us-ascii?Q?kCDwCSJ4Oj5HFTayui3njVvybO2Xsec/1+m6RxBdZSFHpYuqlxFK1/R1Zbf8?=
 =?us-ascii?Q?cpdTrticBNDweoXGyqkcD1xGo4Vim0tqXKdKC/mRyKtM8DQXIuxn1HR0MrMi?=
 =?us-ascii?Q?cYoCgl1ZWF6W+gAbTiRa0pmFGCSAJ/2hFxNqKBketp4kxvCPdbCgytbvNlVJ?=
 =?us-ascii?Q?gDVHN9zTXIh5OUU0MKDxc5oeicc5dgI7IMOEGs4NaLy9iRYbf8icOSArN26t?=
 =?us-ascii?Q?sqQavnl+4iW2LlAS4x3EgpCBvKxL5DRzLiKPpn1hTOrfz7ojj8Ykr0pFLtOs?=
 =?us-ascii?Q?v8Xohzp78dpj84McRYGL4HpSboQbINemLjomJfZ3Pt6LdcYhzdeAUyPEKOct?=
 =?us-ascii?Q?2gU7CMN6o0ZBEP9yvJnBqsWYOJ62vLa+BGZw7zcdxLqrHt17VzdWw/VV/yYe?=
 =?us-ascii?Q?Kg1n1Tpqrg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df74dcbd-21f9-4b1c-08dd-08de89bdda26
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:56:03.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PytF7M1pLOkNZ6Gp+ejPPjxohBmhvNIlPoiJBtOzl7Z5+rFZokon1fKl7+JgPeWvQRo6Pv8LFgWkSshGVwf8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7668
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271153-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88AA9318870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use dst_dev_put() to clean up the device referenced by the dst entry
instead of partially open coding it. Internally, the helper uses the
blackhole device instead of the loopback device.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/vrf.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 0952ab6a2571..bfc9ea91ac20 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -751,21 +751,13 @@ static struct sk_buff *vrf_ip6_out(struct net_device *vrf_dev,
 static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 {
 	struct rt6_info *rt6 = rtnl_dereference(vrf->rt6);
-	struct net *net = dev_net(dev);
-	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rt6, NULL);
 	synchronize_rcu();
 
-	/* move dev in dst's to loopback so this VRF device can be deleted
-	 * - based on dst_ifdown
-	 */
 	if (rt6) {
-		dst = &rt6->dst;
-		netdev_ref_replace(dst->dev, net->loopback_dev,
-				   &dst->dev_tracker, GFP_KERNEL);
-		dst->dev = net->loopback_dev;
-		dst_release(dst);
+		dst_dev_put(&rt6->dst);
+		dst_release(&rt6->dst);
 	}
 }
 
@@ -998,20 +990,12 @@ static struct sk_buff *vrf_l3_out(struct net_device *vrf_dev,
 static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 {
 	struct rtable *rth = rtnl_dereference(vrf->rth);
-	struct net *net = dev_net(dev);
-	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rth, NULL);
 	synchronize_rcu();
 
-	/* move dev in dst's to loopback so this VRF device can be deleted
-	 * - based on dst_ifdown
-	 */
-	dst = &rth->dst;
-	netdev_ref_replace(dst->dev, net->loopback_dev,
-			   &dst->dev_tracker, GFP_KERNEL);
-	dst->dev = net->loopback_dev;
-	dst_release(dst);
+	dst_dev_put(&rth->dst);
+	dst_release(&rth->dst);
 }
 
 static int vrf_rtable_create(struct net_device *dev)
-- 
2.53.0


