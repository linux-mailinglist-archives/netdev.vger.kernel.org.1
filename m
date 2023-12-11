Return-Path: <netdev+bounces-55923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8680CD9C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C73461F21912
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E84A998;
	Mon, 11 Dec 2023 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Hq9bf+6Z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EDD2101
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 06:08:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6fEfByv4iReYW2wSWHS3APawln9PqgToQNvNQbOwWx5LA7lwzwnKAmLW2HREunaqM3EbzLFH/F1v+FqtN2WPRJw24/ggLfeSF6shjXUn/Ta10WbJYzBwhrW6o59d8eXd/ToYUYFcV8dpjzGGoxG87IVH5Mr3Xc8R+he9REa0LhG7yfd6Jaab5v1ZMcUwUsmfZgzsKoqIGOYqIQT2/LyDEVlqjs8Oc5Zs3mUqVye+Vv8QpQSDTVakbkgSxAxI1IQCjPu+0mWycLor6QfqLEIG+sXYmtfKIw9oOrmg4FhxZj1OLF0n0WAnz4rQ0ZfU0KNREe4/bBvWooYvokpkYRovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LegqRqy5JA70RZJpAVqfQng4bUN2757Tp344e+7ljUg=;
 b=DO8/ZXGMddv/qukJWsbbNiUVoWvKdXRC6gSmJADTEuE4wFM7YBcoL/fQ6mcNkK+fowPlVfBGf3hRDPDjwV4fa75pY2eJy3uiQ9L8T72RNFmOzPVA5O0jIICJZhgLB+ASpJsvV3OKHsYQhbVid3WnAK2qOIetfS3zRZ8K3Y1/Y6MSBtETrwt0BsPMmQtcbEAASSftchTLejSzj0mwDlI4+SOa0iWu6fxG7QzGn/AX67gWndrK7m8Vqhv+31rCni+HdZzlvJPpLtIfy6OXsMcUwCNMrv5z0T6ondULsNpON1eCnpvfs5N8PsZVhxBaioiFiDWE57ARecGldiEu9hpNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LegqRqy5JA70RZJpAVqfQng4bUN2757Tp344e+7ljUg=;
 b=Hq9bf+6Z0FF/3VCtmjZeRE9Dnn/NTAxyxf2qEgvQlhDuEhgm2kUX3EFyXBv4RLHplKiVBzDcbZo2/GSwoBpKU6SqqY0qVHxEKgIB9sb6liealUlTpVj7Rp+UCev6mSKiv23GOG1ZuR/k7PrOApri7OgGsbQ6MlHxolutBijkRFTgoKzeExEov7QUX6+YBzAw8N5aHU2ZWWvLcsLR9E0T5FjBG4ByVnp+t0eA3z6GTtyATdQ2/FEl8SooHi9g/VCeBc/lhPW8Bg5HDJdDgg6gYNU4+6npJX7uacDjLe2O8p82uL/L0DPw263CeCh5XVbTZ81aFWL+MocSDBK8YCa6Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:08:32 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:08:32 +0000
From: Benjamin Poirier <bpoirier@nvidia.com>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH iproute2-next 20/20] bridge: Provide rta_type()
Date: Mon, 11 Dec 2023 09:07:32 -0500
Message-ID: <20231211140732.11475-21-bpoirier@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211140732.11475-1-bpoirier@nvidia.com>
References: <20231211140732.11475-1-bpoirier@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::8) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 58baf668-9076-4893-69ed-08dbfa52a85a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8Wd8Kuh8mtC/GL1NYrgo2hQvDi4D4pt8NjRfcwwRFq7co0H14dqjZBfNYDvbLXQONTI5Q59K+kJcDp+VNF7BIh04F460TFNDz4mAInjD0jsGMCmE5a0W8AjKXMJB1Se9QN4HAeg/HMyLTqIObuL934s7ByRycvYMnTepdIkeaXO56v6NEKZ+fypecvK1aG62Jgth0m3j7OTdao2gwj0Ihr4xzbvivhNwq24rygUmK2rrTGRS5059MuLbsEPT/y+x+tx6d+M7icbmldE8OKzBeH8jwKETa3IpFhQVnmcP5+/oWQHTTEXIfpZvpPc03Q0Gw8qvBCIvgruUA5MgVa1FXrG224YNrUWbwW7cvdpd9pRKIEEZCu5XCBkZ+o6XU1Tu6OFkxnlys/mcXnGDbftwwycEDj8c+s6ML6y5n0NInwfdc48lGLOU5oirHSwL0MQGhMkXrxhGcd07CklH2df59u9IR9C9PUX0s370ODTIWFs+UzNzi4vU/bm63vUnUxlhxVPnU6fgLeCnTZlgb7UvRGjK+VGk9nOXanS2ToPi505SltAsTi5bAAZboj61pLin
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(26005)(107886003)(2616005)(6916009)(36756003)(38100700002)(86362001)(5660300002)(83380400001)(6506007)(6512007)(316002)(66556008)(66946007)(8936002)(8676002)(54906003)(66476007)(6486002)(4326008)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vx+RknpQ+eHyiLQxnUvXaSJeLaCxDlmOt8V7O6mwNd7yPuMtyqgKBdsYJSnF?=
 =?us-ascii?Q?9INpK1a61HfnMBEMD50v2t9e5/Pb9jXDzmPB/FUB4qL9VWapoAZeIRcfHoGa?=
 =?us-ascii?Q?GBCLXyIoiP5q0qq1RwjalDSAlRCFToDwg7kBi90Q42JPatX8sItfnOTOWZ5k?=
 =?us-ascii?Q?8fpwe+DNGQSg+j+/grVKFyP76CsFICE8jUT9mCKuxerdoJFf9XXoOz+TYAEh?=
 =?us-ascii?Q?vdP4f68Gto3njsLv/1HNW6hgLzkz/jqu0BLx/b5axbj11fTcz0/0/LYq/JJt?=
 =?us-ascii?Q?694rxnN2e8e1JnVQq3/BTkey5LQIhlBgI3mJALc417tWEF7Iwhig6chnKOLf?=
 =?us-ascii?Q?4+dCRbVEsxwvdhU2ezAI4PZ4ff58NujeuPTwp7g+NrLemPRxwwVTPEfES1hz?=
 =?us-ascii?Q?QzNgmjpn3MJs50LsFcHNX/rbmdLAEE7YrYjmmeTCAnJyIpQmdmrzJsRbFKst?=
 =?us-ascii?Q?negDPL9rt6tVOI8NNK3oTWNtPLxm+vx935kjqo7VSBiXXf5TURpQJfX6/pAf?=
 =?us-ascii?Q?g9iL/PUqkoVp2LPIVlpsEDeby1nIZLm3/1wb8p5DMylv08V5fFN8MbON92rJ?=
 =?us-ascii?Q?v7/824fLAlRys00s1iXVk+3Abvhvz63TDjwOND8DRhO4FTvGnW+yaw1dIR0I?=
 =?us-ascii?Q?dpS7bLLH+GLbsLubuaKzBOxeuGb8vhiDjHq4iPXQX4v2Wmgknsb2z20U/b6G?=
 =?us-ascii?Q?Ec6Lzp+R0ntuq5S7DFv/ewob1UsoH2radB88yK7+wpl9EY4vpRFg0Xtpgn6y?=
 =?us-ascii?Q?6dqhyp8ingKnJ/NiLpsqnjEMBR9MuA9xQh1NTXuQz+U7aoFcY/1aOtkmY2ky?=
 =?us-ascii?Q?F43H7wOiqXvP+O2xzix5R0v+/FcEzojg6Kp1Y+P2iifeD3MM1DkA7+zu+0A6?=
 =?us-ascii?Q?V0PNol7HOPRzhqRVTcY5n5b0djLeKfB5s2mn3gVHaLAkrompSc/ewQVfq5Qa?=
 =?us-ascii?Q?j/AMTyjW03LaAloH6CnBN0tfYdbnjW8NHkMoVKUD5lgM3DeXGFyp7cX9Hp4P?=
 =?us-ascii?Q?0ZoMCcb6FpieW8xFs7gGtJcLtiA2puZvv9njty2kq27z0QJl2Y5KFzlLfCGI?=
 =?us-ascii?Q?lE3YumkyS+qXxe8JGIuDGGGPc7U2u86JAc/q8iNTlUp0ablJwW8LZO2P6aRh?=
 =?us-ascii?Q?dcke9EyTtU4IJFw9xPUnhUWMNaR0PoKzO34sOHHj1VqgB7s9aBxKYuCEc84+?=
 =?us-ascii?Q?GiarthARDF/wu+pgp9QXsVQ0fdBCc0H26CFzS5HfjRC8dTSxfxyWhpam4jna?=
 =?us-ascii?Q?Z39TlRvnkK5CqBn3moeDF3FGCRZCj5F06FSZkwVLfinAkVC93r5TI+mZggVA?=
 =?us-ascii?Q?H6uOswoNx2KaNJ0L5VfXiNjKdXfcBUbfn5FcNcKD5XGxvlmBluewK4rosMxK?=
 =?us-ascii?Q?dRNMeqz4urcSdJVvQEUfG/GT/Nmxx2KdDW2NRfYVTmhpQcckWumOPZSog2rP?=
 =?us-ascii?Q?uritz5tAyST7J0Mua01JAUe2PZdBK3FUakR2ROYKBaxGAh19VEANKfS7kHsu?=
 =?us-ascii?Q?ea6kCovVyE6t6iegcACKFByjxtuwpubd8h+Uiiu8RbK3B10GinffSOsuGEEx?=
 =?us-ascii?Q?AEo05xxSCbHk/4JfB2DuWmWwQO1bJ4Wm95ICoocPXEoM4a+Ah1QiCkLD05G+?=
 =?us-ascii?Q?aQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58baf668-9076-4893-69ed-08dbfa52a85a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:08:32.2846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN5zxE9F4YkGI8jx0Fnfsd2RrnMyFaUjkEQPXWBGl+r1sLsqoY9BGBd6d+WXKC4iuZJerVvexrublR3lIEH79A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

Factor out the repeated code pattern
rta_type = attr->rta_type & NLA_TYPE_MASK
into a helper which is similar to the existing kernel function nla_type().

Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 bridge/vlan.c        | 12 ++++++------
 bridge/vni.c         |  4 +---
 include/libnetlink.h |  4 ++++
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/bridge/vlan.c b/bridge/vlan.c
index 05e6a620..5352eb24 100644
--- a/bridge/vlan.c
+++ b/bridge/vlan.c
@@ -851,7 +851,7 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
 	struct rtattr *vtb[BRIDGE_VLANDB_GOPTS_MAX + 1], *vattr;
 	__u16 vid, vrange = 0;
 
-	if ((a->rta_type & NLA_TYPE_MASK) != BRIDGE_VLANDB_GLOBAL_OPTIONS)
+	if (rta_type(a) != BRIDGE_VLANDB_GLOBAL_OPTIONS)
 		return;
 
 	parse_rtattr_flags(vtb, BRIDGE_VLANDB_GOPTS_MAX, RTA_DATA(a),
@@ -960,7 +960,7 @@ static void print_vlan_opts(struct rtattr *a, int ifindex)
 	__u16 vrange = 0;
 	__u8 state = 0;
 
-	if ((a->rta_type & NLA_TYPE_MASK) != BRIDGE_VLANDB_ENTRY)
+	if (rta_type(a) != BRIDGE_VLANDB_ENTRY)
 		return;
 
 	parse_rtattr_flags(vtb, BRIDGE_VLANDB_ENTRY_MAX, RTA_DATA(a),
@@ -1086,14 +1086,14 @@ int print_vlan_rtm(struct nlmsghdr *n, void *arg, bool monitor, bool global_only
 
 	rem = len;
 	for (a = BRVLAN_RTA(bvm); RTA_OK(a, rem); a = RTA_NEXT(a, rem)) {
-		unsigned short rta_type = a->rta_type & NLA_TYPE_MASK;
+		unsigned short attr_type = rta_type(a);
 
 		/* skip unknown attributes */
-		if (rta_type > BRIDGE_VLANDB_MAX ||
-		    (global_only && rta_type != BRIDGE_VLANDB_GLOBAL_OPTIONS))
+		if (attr_type > BRIDGE_VLANDB_MAX ||
+		    (global_only && attr_type != BRIDGE_VLANDB_GLOBAL_OPTIONS))
 			continue;
 
-		switch (rta_type) {
+		switch (attr_type) {
 		case BRIDGE_VLANDB_ENTRY:
 			print_vlan_opts(a, bvm->ifindex);
 			break;
diff --git a/bridge/vni.c b/bridge/vni.c
index ffc3e188..a7abe6de 100644
--- a/bridge/vni.c
+++ b/bridge/vni.c
@@ -319,9 +319,7 @@ int print_vnifilter_rtm(struct nlmsghdr *n, void *arg)
 
 	rem = len;
 	for (t = TUNNEL_RTA(tmsg); RTA_OK(t, rem); t = RTA_NEXT(t, rem)) {
-		unsigned short rta_type = t->rta_type & NLA_TYPE_MASK;
-
-		if (rta_type != VXLAN_VNIFILTER_ENTRY)
+		if (rta_type(t) != VXLAN_VNIFILTER_ENTRY)
 			continue;
 
 		if (!opened) {
diff --git a/include/libnetlink.h b/include/libnetlink.h
index 39ed87a7..ad7e7127 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -275,6 +275,10 @@ static inline const char *rta_getattr_str(const struct rtattr *rta)
 {
 	return (const char *)RTA_DATA(rta);
 }
+static inline int rta_type(const struct rtattr *rta)
+{
+	return rta->rta_type & NLA_TYPE_MASK;
+}
 
 int rtnl_listen_all_nsid(struct rtnl_handle *);
 int rtnl_listen(struct rtnl_handle *, rtnl_listen_filter_t handler,
-- 
2.43.0


