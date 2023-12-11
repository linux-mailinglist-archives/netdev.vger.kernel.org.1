Return-Path: <netdev+bounces-55930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DF980CDA2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CECA4B215C8
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF85A4D59A;
	Mon, 11 Dec 2023 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QFvzNu+t"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251E82115
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlTgzG+OJlInf+vIPYH509W14ZamGc6i0ICczn7IA8d2rHcDDYGcyUl4gm567waTDMHUmsbH1W0xBqdKjrC51cNqgTfZtbxHjJnDtUZV/faHLFUlkSEB7VskoxqsP52kXgSoGlGZzEc4KDLZEKQyjJb/B9ivvQATGjbDdMXYK/WuVoEi59PSge8MQkN9ni9+FbqqALinT7XcWSClJFLHXXrb2GEwhuF3hPZpaqKX3GIGqI5znpSI8LQ9Bp0qHDhpdRe0l/uQdUY6pSA3dc1kdjCrhlSFHK+IKt7QUKqb4xtWC7GwUiTDOM0somHxD1XquZSig1hkGj7VVLUyF9Bk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2y7nbb0vnAYfLBOXRjELDsfoAaUOLNFUFIkL/wwnUv4=;
 b=bGoreglCtYiwVyTzpNzfTyLrn8XFe+eFSRqcghSuEC6Dd26rXbdaXhxN91zM1Li1n6OtMEUlUTOzoED2MzocrPiwNOvH03Quu+x/4cmx/6yg+C+qvW9UVgyYckH7ffAJk2CjDtKc8UjK+IR10iFeN8p3Af8q/fCE8cn2nkFePZTEFgW+vzKBTvHbFotpN4WnZK7ywf14RiEAU2ymJcntgHQWtYdSEQdyNuMPBmW36MYWxMp9m41md7Vc9ZGzEsivnoW5zNmdj8kBu6fcYIXqBD4gpKkqzPrYD7hCBTvs2TR8I6DBTaYN3jx+WsQwD1zx/umENFYxbIoXrfnt2IinZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2y7nbb0vnAYfLBOXRjELDsfoAaUOLNFUFIkL/wwnUv4=;
 b=QFvzNu+t76BSqbrv4GCOSqEXTqnjlAgsw5qviZih7HCeTLcq/7QXQXDPVmFeTpnrFgiQa0+mxT8KxLotCgHG7RednjVdKGL8WHmK5txv3WrkgarWKW8fhB4xLzuUskTk1N34QVRLBJRTMGJiTtKsmWKKAeTNUGsdQeacjhJ5E8sCikNZHlwDK3eKafIOpc0txOWdVTfUMFJqvUZTRl5aUo/DTwXfe/Ig6m6WiqG4TLI1l7QUjPP5cnfQz5ZQF7+yAy2VAJUQ8m5AbyfMJi/tyKoPgHYfvHg+uY9Kj5V4/i5AO5Yu4AVE/I5d1p1ilmMyg95kVpFybYkqAwWW3w6KoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:22 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:22 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 17/20] bridge: Deduplicate print_range()
Date: Mon, 11 Dec 2023 09:07:29 -0500
Message-ID: <20231211140732.11475-18-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0032.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::42) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 56adb06c-132a-4f27-30eb-08dbfa52a22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iuCBX6x9g10pbGX9Wa8RULz9RCu2pr0CkXvUDHzLtofM956G35Xj2PV2UtqAqLczeIP5t0g21HyRmYVkIQU89BebGK2z2ZAhSuEzwEifmB47dWIHf9qeztZpYaPA9fBdnQg/VAJKJib0+5ZpoVIDxKTkP6WqcAI2UyDa4emCkeoxWfNJFRqqkWcTqHEe7IZGhNDAT99tgZNo8StfpOWj99JrjcgfU0FX+Tk3L7vTbpOxZVD/lYAwURJ83VUJY+W9Qb0CckEnFR/eV574Yj42evgzoMfLPzZO0mTwpeBh04LWzT723rBDZ+OqJS7qB2WKc4GZ1zCqgG34S+YkssEnoJxlSi+EuVQtChwBm6Xl9yWxm+w3nVDOFeHCfGB7zncuF7H2jUivtkdbNrqQBEhmKt++QAyuqXNwl/csqajtbYHNWnqL7Pt+FUQuk5yOCIPW/yDWBUp4Bye1+FyxXDgdmfwItgj78h+8RBVzHzz6qiMAuvItgHHgjWmDGIaVRV9/ydpK6bj2EgZXOOrowOPdL46N7dqzaZjfoK5f9B1jFaLU4/nVvxvsLT58HC0sDQ82
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(1076003)(5660300002)(26005)(2616005)(107886003)(36756003)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(2906002)(83380400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tfsV3JzQzNPVPA0ZyQw4vAkiewTuzn4a65mqD0WC8H/Y7Jf14ZtRVuSGWBTA?=
 =?us-ascii?Q?9i9lzXUu2lCpHyJp8Lrd2y6Y56TUw9uFfT38PgdJbzUZucSX/b3QSgR9N5tb?=
 =?us-ascii?Q?jm9pZ3vRlbsfSjN/aE1OlO84DKbCKr/i8gWeA8VSmH2i7ez5RWyEyYZFOGb7?=
 =?us-ascii?Q?clRc1sFcSNMH3hj7tkk8kyTw9e4bvdMyE7kJlZbUGrPtOTXAPFNUAY5oGwFK?=
 =?us-ascii?Q?jgr0GEpAxWw9wJE5j27Vl9ljCnmpwK3Aaz53da2d08QnRxAatJu6OD/D5XK4?=
 =?us-ascii?Q?TwykIYKXUUVNVrNi8CHKO3X18GmCdvCDRnnzfnbghsLEF6gK3RKAKT6ESlg/?=
 =?us-ascii?Q?KfGCA/GZ3HD9upuAynV6ivr6szDKCrJPSzuHjnPe4cevBvqFTRb6+eki2msb?=
 =?us-ascii?Q?DCihx2e5OB4tQUJ2BeLRG937a8Fy2xqvBCtvwRR/IEV8BNNv/XqvxUpLBNM0?=
 =?us-ascii?Q?BxvHvMzn4+rTu5IaOq1xY+BLwtMQmwsDfCM6Thz+jbFvnH0vjEKVpB3BO9EO?=
 =?us-ascii?Q?9ISMt2swCS6M4qsfxElYmaOo4mFK3vuslxVF9khseBD8LOzNQzcKjsbYYHji?=
 =?us-ascii?Q?QaDDd0nqMHNsn920+KD1JqlrF8u9G+HCQdBm8vCmZ31KDFQ9050e+Rudkylr?=
 =?us-ascii?Q?m4TNNRDa/1/RtY0bYBVU4nVeqPG4aN7DI5Q7AKH4WHHfBWzIc+duGsbHiClQ?=
 =?us-ascii?Q?0B/SDIZd1xP5T+d5mLlEdWP+IyT2VQjYGIvpw5N5hxaO2P3OwXzld7nXmma5?=
 =?us-ascii?Q?R9x8Nr3y9Py8q0NNnnhPAh2QzsdGGQRqNxpmJGIKUXIsB29l5LI5USioVWeH?=
 =?us-ascii?Q?SDzb38LzP14XU3J1aI877z3JeAzhf/60fQOvDGNKqd+yJUl5tESZBy39HRg+?=
 =?us-ascii?Q?ZrfNw27rrgWG/fEdNqEgcoRO7ojUJ9d8252vdAymi3F/XvEqOprnbkka/6vj?=
 =?us-ascii?Q?1O179wnENRi2CztpDOfTJWM3g0HsJ4++H0O+axYbjhXtTDW6LfRHPAK8mla/?=
 =?us-ascii?Q?zJrx9THY5Xmaf5DEmAmxLffxBDAPZp9XpU1e9YWefW+PZ2KVJgJOxCZ4smCr?=
 =?us-ascii?Q?eSUCt7SMSPP4MoHlfl46wabCh3nRL9cL8PTUFd5SqTIqgLjgksUZjRZ+BxsF?=
 =?us-ascii?Q?tAKFUmELTuoXqgEy3y2+FFMoac5ZsjuDZ/aUESC8kN2kYozToFHw9D8/JemF?=
 =?us-ascii?Q?gm3yfw89+jtCNB0I/+/rIKFSYIy+cqD2HB1kE7AWFjDkZ+F7qEv2xmApy8fn?=
 =?us-ascii?Q?iBwfSbx9j+x9SGfZdVEQ3Icsg8bMNgtMeRU6km/2CaxE0OPzzGJml7jG6d5P?=
 =?us-ascii?Q?+rQ8XVwpAttg5zRdfwyTg8LFzZjQkVfzhInNLPWAIaYcZVTzzPfFLKjUNZgY?=
 =?us-ascii?Q?+2xHtXIXi4kyD4uuurIJDmcxVeVcbcCYotghi2XrWqfp/udJSCayrPI7Sqj2?=
 =?us-ascii?Q?Cbw5uYNbvyc21uTXnbZraYAuhD/m9hcnZiLUITuN8EubrqkaPBZ4pAFZAVN0?=
 =?us-ascii?Q?P7lU/2czyUO25oN6AaYItp8qNHJbfVN8UXjQG6bBefeZY0uFbQ1i5Eg+y6jl?=
 =?us-ascii?Q?cqy2t57cuKbEPbvhLNdUV2dTzBBkl4N3GzMbBTl1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56adb06c-132a-4f27-30eb-08dbfa52a22b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:21.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYkjWAlKM3PEMzAnVe5W7BTowGoBL5QZjncVERHXKTXb0PmEED0UjY3fbuyoxYIqD44RkRZWCM0cUfhkPXegbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136

The two implementations are now identical so keep only one instance and
move it to json_print.c where there are already a few other specialized
printing functions.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vlan.c        | 14 --------------
 bridge/vni.c         | 14 --------------
 include/json_print.h |  2 ++
 lib/json_print.c     | 14 ++++++++++++++
 4 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 7a175b04..05e6a620 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -590,20 +590,6 @@ static void close_vlan_port(void)
 	close_json_object();
 }
 
-static unsigned int print_range(const char *name, __u32 start, __u32 id)
-{
-	char end[64];
-	int width;
-
-	snprintf(end, sizeof(end), "%sEnd", name);
-
-	width = print_uint(PRINT_ANY, name, "%u", start);
-	if (start != id)
-		width += print_uint(PRINT_ANY, end, "-%u", id);
-
-	return width;
-}
-
 static void print_vlan_tunnel_info(struct rtattr *tb, int ifindex)
 {
 	struct rtattr *i, *list = tb;
diff --git a/bridge/vni.c b/bridge/vni.c
index 2c6d506a..ffc3e188 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -163,20 +163,6 @@ static void close_vni_port(void)
 	close_json_object();
 }
 
-static unsigned int print_range(const char *name, __u32 start, __u32 id)
-{
-	char end[64];
-	int width;
-
-	snprintf(end, sizeof(end), "%sEnd", name);
-
-	width = print_uint(PRINT_ANY, name, "%u", start);
-	if (start != id)
-		width += print_uint(PRINT_ANY, end, "-%u", id);
-
-	return width;
-}
-
 static void print_vnifilter_entry_stats(struct rtattr *stats_attr)
 {
 	struct rtattr *stb[VNIFILTER_ENTRY_STATS_MAX+1];
diff --git a/include/json_print.h b/include/json_print.h
index 0b1d84f7..86dc5f16 100644
--- a/include/json_print.h
+++ b/include/json_print.h
@@ -97,6 +97,8 @@ static inline int print_rate(bool use_iec, enum output_type t,
 	return print_color_rate(use_iec, t, COLOR_NONE, key, fmt, rate);
 }
 
+unsigned int print_range(const char *name, __u32 start, __u32 id);
+
 int print_color_bool_opt(enum output_type type, enum color_attr color,
 			 const char *key, bool value, bool show);
 
diff --git a/lib/json_print.c b/lib/json_print.c
index 602de027..072105c0 100644
--- a/lib/json_print.c
+++ b/lib/json_print.c
@@ -374,3 +374,17 @@ int print_color_rate(bool use_iec, enum output_type type, enum color_attr color,
 	free(buf);
 	return rc;
 }
+
+unsigned int print_range(const char *name, __u32 start, __u32 id)
+{
+	char end[64];
+	int width;
+
+	snprintf(end, sizeof(end), "%sEnd", name);
+
+	width = print_uint(PRINT_ANY, name, "%u", start);
+	if (start != id)
+		width += print_uint(PRINT_ANY, end, "-%u", id);
+
+	return width;
+}
-- 
2.43.0


