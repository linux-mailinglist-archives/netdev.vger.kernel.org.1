Return-Path: <netdev+bounces-55929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366680CDA1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C3E281398
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414404D580;
	Mon, 11 Dec 2023 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAg3Hq4v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05A2184
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY/RuwrVSJWlOrVyf2Q0HRWb2UWNeXZDVAp0DFNyCTo/aAx5AvoJT1aXkU/XKMA/u8xr+rYutNQfzXTtnLlvwEzvYUymzvoD6nFfZ83cBVD5MF4PKYusLgpZmxRJOme450NncM1cQ8OXnTLQFCai3GJ5RLammIibAPI7nIfR7IOIh/2FwjHO1AF/BMJVvbkaAarw/+YMBscH9I7IgY8jbQWGqLEUdQk3ra2iX5rTRSdRFKwlMOoQ9LANZuXaa8xCAwFEhF9Os5RyJFPwMFbTPqMe/jrKT72q0vXNwxcz19xgbTDF4QvnfrwR997Ykf2zMGLZ288aGd9faIX35ROTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njEYY3LhOSE3YnCoHAYfMkjS8e5mNXmAuah2L5uTQvs=;
 b=N0uEp0K1cea+vCc8GRekeUlbgwVMJs54Vl5wUp+UvDEqa3Uom8gDlwvBX6Lr4i9ijyqgxf5mSZMZ8fd5opsRgak8l1/p6KMezUGueLLrmMmJrxzXx8AJkcNs6AZnkWZFt+hBakIWztqfUBpR6/6gnG2CNV/qbwCFjDk5VZwmL7vQxHJFfVtK+N3gyViygc1nhZAY4n5AvD5IhrD+d1EbcWpnldbJtKrMLyaMvoHQdwKhSsqpBIBjkOPfFYS175beG+/f3ovf1Ej9/xwiJOTlIjZ6pa7Fnxwgdr3aEtJQNox3G8HK2ibuOWN9mcR2e4Q4ss6xiKqM1FBXu0ogL6rSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njEYY3LhOSE3YnCoHAYfMkjS8e5mNXmAuah2L5uTQvs=;
 b=HAg3Hq4vt5zGVJKSyFYjPQCmY1EkgX9szVBR5TlD7M4qwnfuqPxwZnwL1qh303jxkD/5YmwPA2aA1BKP3ZWge3J5ve56nsor6M95iT5lIapCrYLgITNKxwUVHefuxLBrYuFLyffszh3+z2TWHypKLp/HuDEK7DQOyOWmq3UJeMzwPVIQ2gpnEDLsOoRQLV020jj2/dAJECsB57W6JtUsPzpbpPaMuynVAxEV/LbwcrN879Sa46yN+cRY8BVW7KrAFynZ242ZJXIAzjjWrW6rOhEG/LHLJ4vVvWyVvzqsJ+WzpTlqwS8KmPFa/L+pWOTj//3NW7ohg4X19Tr+FL+fxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:11 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:11 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 11/20] bridge: vni: Reverse the logic in print_vnifilter_rtm()
Date: Mon, 11 Dec 2023 09:07:23 -0500
Message-ID: <20231211140732.11475-12-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0264.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::11) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: b84ce03e-9ea4-43db-e597-08dbfa529bc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qjXUnK1qhE52vH81ZNk/cffgb1K2AUspxDUOZXBp6/i59IzcAztdJkjrF8me0il4LsR0ZSLhHAGAqjd8EYI4NTy/ITezwHi5ce2onO9r9lZC9ToexfK0eqNMBBfGrcpCFFawyQBicrEVO8mF8hSyf9gB7FqBU/mUQSL41x8m8VavcvVLpIc41524sDzQSidUTxeFggPzEM65fUuB3YpHMDFne1YwKbi38p4flnKm9WuofHZ6FpPRT9UftlDVdpeTeJnjoHg+MgvV9lMWbqjJvTpXMDWNNmQNM9kUh0EVBubA6eQLd8es3B4ELrkT01DBIc5Co9KRPa9TiSipfco9SXNxUCg+2+kyiSwaUD6WF9NFWAFSoG7OjwoLnfHSgZ2pUmEO60GC41NolL+XGKGD87Ummr93T4WF3dbuADG079curzAY6f2zbOIcPrKYI47J3as12Xc8tUCvB7PUTQrWe6uao9qLYw9OGFGVNk9Ybg20RVPkpVqhNgsUWfOWLIPvgqd89xoSrDS/c+UM5yqAUEnzfiep03ggzajAgaEvQDfk1nBEn0Apum/B863xHhW3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(2906002)(316002)(6916009)(66946007)(66476007)(66556008)(54906003)(5660300002)(8676002)(8936002)(4326008)(86362001)(36756003)(6512007)(6666004)(6506007)(83380400001)(107886003)(26005)(2616005)(1076003)(6486002)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?94uNcCRs23SadIEzJkeyj+dGz94JDQVrnnsImbfXu3Qy73K9O1LnTTk7+27/?=
 =?us-ascii?Q?kMvaNpdidJeGZZifYQTYGV0oEQ86gmqIh0EVQDkH46ozoE570i2m4cNfIuWg?=
 =?us-ascii?Q?jWDhGagrOPibs/a+DSzCbBy6tRFX06838XkOWuXasZMyAc2lub6PmGkNBGfg?=
 =?us-ascii?Q?7jQdFTlytSkawfk8Jypkf99PQ38tjboCoFC0QUJo8lqL6uYAiKTI/enbO4FA?=
 =?us-ascii?Q?uh1hOK8XdWaHP6Ghg7ZGiGERKHdJws54Jddj3Mu+IkhxuUUQpY8RSK9nghHk?=
 =?us-ascii?Q?re0rC2bxCyjJmykgLnHmLYCVM5HqbCLTuwbLufbDO8sAZfy0ctHLkX2Ak+xk?=
 =?us-ascii?Q?1zGhXBERvFGLrJhDoCWae/doHSJ9mXRJDDmucD+Ha3gF7R2FlO6iczLqsRp6?=
 =?us-ascii?Q?2BPo6AnocmQP6eiwLMUii5YaLwMP8M9uvrsdwOtBFqhRfzsRlVWC+jAlz0sg?=
 =?us-ascii?Q?gIgXhEEq+ZxyoL7jyYmUNy4f1L8vJmMI7AokCsDtEzRSd9SYShT50e/aJdXX?=
 =?us-ascii?Q?nWFVQYKeGMs8uLQ6Fe/Pwq4+HRuOjDPV73Ga75HXNiYfk9EP/Y35GOUrOvY9?=
 =?us-ascii?Q?B+3goeHT5Hs8hS8o5MQwQmkI/BifHByLJGzX4FkZTroUl05nJX6Lwl4XpVAM?=
 =?us-ascii?Q?31c9oPhacRYr7ZUIsbycoR9vS6+Vojm7zWYxKKq4oTxE//Tlv5Ic1t9D0anN?=
 =?us-ascii?Q?PKX4EKr0GsQg85lHySRUpGy9yMtpX1cT1D1qyGBuzpY4wgcGpioNZM8J7SDh?=
 =?us-ascii?Q?qv+0s0M7NuwLzkvDdU5fuKBf7Mvk/LPLqvIsoptLALRLMsGEtupoHjpTIXfk?=
 =?us-ascii?Q?4XTYXQXOljwdRAYH0P9qByI0DxLQo8bpb5ZlKMdWyN9KG230RNmIU2mahZRu?=
 =?us-ascii?Q?1cYft7UJzIyJNnzMmKQ7HZJeks2Z0NOYKyUorUkRzHCPwOPD0dVu0258jw5n?=
 =?us-ascii?Q?6TKN5B8XuVsw83wrR4ytaKnoqxW3KE4gb49BaI77oKUTBTLap+j/iF9L4R9o?=
 =?us-ascii?Q?kZPxJaMrxvyfYM5lT2i8JxMzMyUpjkILdpWznl+q360fPBu3Nsx9hHiaW7Zp?=
 =?us-ascii?Q?3xldu0xfn9QYtThZtP2f56/bqWwCyTZhc9u0Xu6tzyOdIS5h8/zGmgKn4oi8?=
 =?us-ascii?Q?e2A8UhoQpX0KefSbDLsnXj6Lz4bOzZg+E9vJqzAIuxfIm43w2h/m92icyhJd?=
 =?us-ascii?Q?4hIfObpwDNRuEqnFuO3Y5jkVJtkWJpLXqmU8ujS3GUfVHyqZkM6JX/OyMxys?=
 =?us-ascii?Q?3pvz9FYS6RwPAMBI0YXIg4tf5+JXCs2xnk7CR9O3g1vFFFtq4sLoL4x4uNoc?=
 =?us-ascii?Q?xAwzrZSme/hAGPAavpJsiSySIeBQvOlzPt2+vbjsol+akhSNp2UHlksfraQP?=
 =?us-ascii?Q?hrCipo6218p1CoPc0Ec03lnf056DunA7oFHePxnkbtrbOn7nHTSCEKoiAveA?=
 =?us-ascii?Q?b6f55iMWYyGHnbVW0lfIXKJAAtHYehOUkaT0NoUTlnr3wK6VPqSd2lqh7zaV?=
 =?us-ascii?Q?s6vE14ifdqY9bx5ezeTDK5WCxdhJi9hE1SmfUeFdt2VzsMfGF2JBNvUWuW0K?=
 =?us-ascii?Q?AqvprDoHYH7+FegT8T0M4y5fkU1nOi8JrI4oQPgL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84ce03e-9ea4-43db-e597-08dbfa529bc9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:11.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wu5HOF5Y7D+eNb73lZNI6mKCJGjVDDKl4g4PQYyJZRrw/W7hxGPvYh0lMvS+MhYuntI58G6QZVVn4wOWPevSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

print_vnifilter_rtm() is structured similarly to print_vlan_tunnel_info()
except that in the former, the open_vni_port() call is guarded by a "if
(first)" check whereas in the latter, the open_vlan_port() call is guarded
by a "if (!opened)" check.

Reverse the logic in one of the functions to have the same structure in
both. Since the calls being guarded are "open_...()", "close_...()", use
the "opened" logic structure.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vni.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/bridge/vni.c b/bridge/vni.c
index ca5d2e43..b597a916 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -296,7 +296,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 {
 	struct tunnel_msg *tmsg = NLMSG_DATA(n);
 	int len = n->nlmsg_len;
-	bool first = true;
+	bool opened = false;
 	struct rtattr *t;
 	FILE *fp = arg;
 	int rem;
@@ -332,9 +332,10 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 
 		if (rta_type != VXLAN_VNIFILTER_ENTRY)
 			continue;
-		if (first) {
+
+		if (!opened) {
 			open_vni_port(tmsg->ifindex, "%s");
-			first = false;
+			opened = true;
 		} else {
 			print_string(PRINT_FP, NULL, "%-" __stringify(IFNAMSIZ) "s  ", "");
 		}
@@ -342,7 +343,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 		print_vni(t, tmsg->ifindex);
 	}
 
-	if (!first)
+	if (opened)
 		close_vni_port();
 
 	print_string(PRINT_FP, NULL, "%s", _SL_);
-- 
2.43.0


