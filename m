Return-Path: <netdev+bounces-151612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246F69F0322
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 04:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989CD188B299
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8A01547CC;
	Fri, 13 Dec 2024 03:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qjs0dOAb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BB81531E8
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060959; cv=fail; b=M8532qxbT9qIG1Qc4P27hsdNqtkSh1xijiGpHA3poXUry7TvOgGJYqXOGbdyQ/CJEdMpTn5bgjbBvqW9vn6+RMa5LYB8arpETVEjK9CJWCLqAiVd4vbmnqgLY+rZeFZBzTxgposCL/T2H6YTvTJqNdENEJ88rCzUE80IN4b75B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060959; c=relaxed/simple;
	bh=ahfEBCXgnztk5rRFUmF4KNQKEYzuabhhl+GLfHS/w50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LUoGGCK681GHbq0yf/1rofTjEqitX8Kc6rAeOryyBXBVl9YXAi/RwBzIkOPMI/LypXijDWCLNTOpn5/qzU4HTVPr+iUIo5zF54+5e74i2uRYk+rH5tJrDFvXf2qJW2m7pGv4fo2ZjiElDhVJTgCglpEQ7PMXd71L7CXnAwd12/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qjs0dOAb; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OG8j5HpFUo5kT+lifPy931y1JWZBjnqabYW+rALhYyf5K0PRBq6w1YAVae4sqCr9UkUi4r5RGf8YqJ68S1sD186wt5n5olQFf4OIYRZZKwsxiY5QQ1RDvJL9iAzqQ74Q8wIcsprHE7rYY45exldmPISEvaeeIvThjgVePFs0o9g86yYkp5t7wLT7KcSJxaP/P1FJh03Oe53QhxHu+rKZLi1AFDDvQRHB4xWwJsXl+1WutP3HI+RfSBxbjZGmIFeEvHSA2pLm0snFSbdj0iquy4hWdUb0xyIOFvEWzhE7d1hRlQD+pMKZP0L6K9ZWNpOrCD/RjlJufnI4BpNqF0GK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XADcR/yHvBLJksM9kUsNpWKj9nc0eI/UQwLCV035sZQ=;
 b=zGl//Mj3hWA8hDoQ5RUfZYStm8tRwfOSdmzLfZqOB2nzWsRRdh9/4zEIWDSP7o+gKudfzCrRf27bj1OotfVYnReuXxGXc2ORr5EMQYMaNdVArp3ucXKR9/U1A6txWMbJlmv8TTguTY254kHmCZ4QZ4zeQvZHBGzO9yJuv+cXv91dqjlQLNpe6DeXoEFh0qAbT1cgcJFqSpIj3q8UqVw3xGTHEPyc1hDho3jy0+/bGr5Csbvh76M+6J3gfXyEm7jOYo12rwV3CecVT8BrubX2/eekFdauCPUQ/Gq/mBG1mX9XpUr4k6t0WiLTxPLnuAwAH1Ts3icT/Oeg9JzxerkmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XADcR/yHvBLJksM9kUsNpWKj9nc0eI/UQwLCV035sZQ=;
 b=qjs0dOAbcHeiXhjHkRdkjRAnC1OHCJHS8vkuV8rUkRNzFgbJVKFaGwdUzMLhdBVN+oJmrNNvkWD0+CX36e8F4+dc17LDxqHfkxGJt+dQUhtsT4CtiN50S0mSPDxXbQSNiaGBjeaTkWEVn9iiypyVpZloOwfO7jv9goDe3iSDnNZXvR9kLVrI0SclASVq6pK6LQbqMoou0o9ukSt1DFH7FEGugR4ZsgRF3/ApnbYf3Ob13gFtb4HvtT7MPI2Sebtx1X84flNA+WVS3ySTYjlgK1Jfz+JZVC4LVDnk2zRh8cBns1fi7aRf0DIqbAHvJ6n9RlYtFv9o2LbPO1skLzs08g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4858.namprd12.prod.outlook.com (2603:10b6:610:67::7)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 03:35:54 +0000
Received: from CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face]) by CH2PR12MB4858.namprd12.prod.outlook.com
 ([fe80::615:9477:2990:face%6]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 03:35:54 +0000
From: Yong Wang <yongwang@nvidia.com>
To: razor@blackwall.org,
	roopa@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: aroulin@nvidia.com,
	idosch@nvidia.com,
	nmiyar@nvidia.com
Subject: [RFC v2 net-next 1/2] net: bridge: multicast: re-implement port multicast enable/disable functions
Date: Thu, 12 Dec 2024 19:35:50 -0800
Message-Id: <20241213033551.3706095-2-yongwang@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213033551.3706095-1-yongwang@nvidia.com>
References: <20241213033551.3706095-1-yongwang@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a03:505::23) To CH2PR12MB4858.namprd12.prod.outlook.com
 (2603:10b6:610:67::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4858:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc31b4f-fb71-45bf-1920-08dd1b273f98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8I8AedppnAOSlxwEXSQ2IrXQ/6Kp4rCKfQbXs64X89jLC3E1rMAR/XPjK9t+?=
 =?us-ascii?Q?y3UaZXuCFJlvZfx0dzypSP3mxHU3FvwJkCYC1/cgwgiL60fE/at/wA7DMaPm?=
 =?us-ascii?Q?G81ft/uNnaWCLTpwKe4PFc8zTcGqgOp13N3h8MKwAvbUEryLLfkFIMxbHBVO?=
 =?us-ascii?Q?ykfeDz39/09AyyqJ5VlgvBsosixxVsHs7EW+1+VyfHPz1wOaoaSa199s3klW?=
 =?us-ascii?Q?JKJOJL7dn8LnVOYochAQxwho1oNZieuSirkrVeX0FdmmnZQahqk5iwD4r6AL?=
 =?us-ascii?Q?UnhLtW6/WkHI/nRWgyeMAatxGMnoNhnp+axVsDrIL9gcLRusFz0MlJAa8tuc?=
 =?us-ascii?Q?Q/FcoWDG22yM5Ql63K9rtqm45WT3eTRwe62Fa0vt+KjQdeRWlILiFGq6pVrd?=
 =?us-ascii?Q?OasLINwQyJoJ3SBaQGfOzit0H1JQqoHykq/tpn8lgqpMKVpwxEuUKCRjq+Oy?=
 =?us-ascii?Q?5PJHheUJNUy45DGcR0Ppomf0wBzx7xBPaJA2lRc8uKd9kTnxYvmqJp7dcXYE?=
 =?us-ascii?Q?m5hjuUw53DPuvx7JufNadWMwd4fY6VI6P5shk8oFgM9NNvwJ6QPz5kHnnPJi?=
 =?us-ascii?Q?uennYz1smkPo4S+E1ofAzL96vc+6tMXvWZx8Y2faEuCXIqu4TIJg8zwEP5qa?=
 =?us-ascii?Q?J9ux4O8lr554PFgdZ1MzXm53sxxbAi9X25VxfPfGuQfaWerffeks+avHMu2S?=
 =?us-ascii?Q?if4hcdvkymLWIrLycGqlx69bup2DEWexo492om1CFt2KNB9XoBMOk8b3yFid?=
 =?us-ascii?Q?qdeNYvRHN6yItctXryeHsRQm4gKgl3pyD6Bs26mqSfP/QIAF0NCvLDkZD5x5?=
 =?us-ascii?Q?d1xdCeJYt8SdT+RYJ/xpxVYGdUPIM8y2tBGJO1dlQkAoiLCbbTsFeCDXaj9m?=
 =?us-ascii?Q?XeOQVaojjQyLswOYLga5qnKT/2hVSzfVlYIdR4ugNZzwcUHzyjNUeBWy15sI?=
 =?us-ascii?Q?oEYdq1HJbLziGQPZC1Ep+I3v9wMGQ7zBVNkTtv0CaecNFL+J9Maa0JPnzsfY?=
 =?us-ascii?Q?AzZQiqpXZ9t5dzMLeJVE0h9yEg6b3Ar0oVOehQn4ykQiGOHt3xNq0PmgK+Ag?=
 =?us-ascii?Q?o0XbhS8I44DmBO+/x/prl7ehZkJk8ny3uq2r7IIPKllWfW8SBqEBe4xuIRcI?=
 =?us-ascii?Q?WcsXg8P37Zo3SWHXlLwAe/R1Ky93iNfkBZPLpklMzojcZJb05pxPE4IJZoTt?=
 =?us-ascii?Q?+qXy9iXJele//PKCNxLdIV8c87FVJRLlKpl5vuYafk3XURcglF8+SbQpIcV7?=
 =?us-ascii?Q?7Yukhd26AOXCJ8TuxM/nRQEx2TC9x+IzXwgii9lCtJBhnlaBEoCjWMRrnDeV?=
 =?us-ascii?Q?HR7MzxJOEe1LpTNJxUof0QOgY99OZZZBfR0EeEIOslSONg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4858.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMmmm57jj+cjuZKgKRxnzAbEzrJIh7Bi/wVLpPOKA/z9ITQTAJ3SrSdd48nq?=
 =?us-ascii?Q?vrXnTV66atNxr55bUxCkb0LL81bnCsv+/UarwWynnkFB37bvRUipd9QzkzKr?=
 =?us-ascii?Q?nXaMyH6ZBOfaCjwfehm2Ly4Z45OHu05hQA0ngF1aOZLke7Ayq9A5IPV0nwzR?=
 =?us-ascii?Q?d3Fzws9D8YTwPwGSI7Y5CKtULzJWoy5+VZ45Pl2fz/1aS28YamU838PwV49I?=
 =?us-ascii?Q?wFM8pw7qMi5OJoK1m4YkiwjmIl57wZu2ki07xHbsi6a+Wn0zgKvNMeoyv8Ng?=
 =?us-ascii?Q?OaAKXWG2XUUJ0A3MI6io737U6QgEuxqzYdrVmg9E4PyCzwyxGT/IbSFgXm4K?=
 =?us-ascii?Q?wi1UuT0SHGVrUXwIj+T/lbkS3R7E5isijGZBxx9ApItQTfYR8uQU/cGLr3dl?=
 =?us-ascii?Q?RW6Uze7uzgzz/+ceqh+1LR/s76aIFA2sBhd1y/nycCRvztNs8uQ+rQ2gYEDE?=
 =?us-ascii?Q?0xC6vnATFRSadfGsGvIGYH9zn7YBLyrDKT3eByT8B5wcXqrcinJ8VZsqFm3K?=
 =?us-ascii?Q?iu2ck3dLiXsKmR8cEoR+jeBcMaC/JxeMz11TyPvKMx4CHMnR9fNNRrNRNz7w?=
 =?us-ascii?Q?GgPanRWOoVq9jJ5BOlISGrXRXNYaxpMip5mGI2aulrn9MBNI2iejHtJI6xPU?=
 =?us-ascii?Q?IjqjipotTgZs4yhY5kYHzg+kjKtz+BE0bS3+UL+SbLyWL7RArV/8XHO9d5r3?=
 =?us-ascii?Q?cfJng1MnHmMnN2647xKifJQUEmAi5WjpZywGi5cga1NBDxPV3B+w3Vo01mGX?=
 =?us-ascii?Q?cHJVHrtmi25/BSnDOASdK51nDd04G20s2ytIR88wTa1UBbkJSWmd0A0bvyGI?=
 =?us-ascii?Q?mnUSahhMkf0tamgh0I7BiLoQ5DOfOx/pFyPTJJ6RoAKuvQFr4LPtD7HdQ5M1?=
 =?us-ascii?Q?L4ywvvoOxiP+TCXx+4FUiRfZEXPgoMlSwMAF02/cI8Fb4l3VT+Y7qid0dZib?=
 =?us-ascii?Q?yT/bGcgM83HOL444EMu0k69W/3ALhYp67xvB68PtfTEMxgGDCQLxRM8w+1VY?=
 =?us-ascii?Q?FHY6PYTZw2/zmttMZJDuXtho16Xwn5G1WcveE7dCJc/R6rKN26ufBfUUJETf?=
 =?us-ascii?Q?XkS/kaufTfPEn0IMtHcbeZTUHjr3MSqyvd+hGMzf5MwSJ+x3sUIosK4Et6NB?=
 =?us-ascii?Q?qYwXuz9n5IjZKYFtFHjfaUB0Ff6xKtTDNDmcgKOAHJGA1UF7+BJvf+l8Dt2i?=
 =?us-ascii?Q?nKiiOQrGXx9kSfxoXYXJ3zY11K13sg9qs4ej4boc8ZMSk4mUqM0X/Vs8enre?=
 =?us-ascii?Q?gW/Wbpl8OHTkO53kOEyrwgcjdsJkT0acPIcFFvcRZq63t3YxIRDV2jRDHLFR?=
 =?us-ascii?Q?RI5ibFWJuVKCqdGQlT0CnALVK0cWPiXvUfdGSaRkcVW4SJrIvaVmynI/KmX7?=
 =?us-ascii?Q?0tpxdyAShpA/H4JTWqieyIZ3OyffQXcHqNMOzwxmakrcmXS2WYtxsz/3Z2rj?=
 =?us-ascii?Q?aZ4NddJIK/oCMA5Aj++domQm/Zyyk6uleoQ1t8w/Hve2tFwf6TltKbp90PyD?=
 =?us-ascii?Q?Nv/bOBkkB2e6kCJLNFfpJ8fn0UAWdq7LBYLZHf3AvT203qv0+lehrZ9wpfZc?=
 =?us-ascii?Q?VOCVFKzF9oP2zB97vbn9oqYaB69BxbLPlPEeBHwj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc31b4f-fb71-45bf-1920-08dd1b273f98
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4858.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 03:35:54.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+zqseeL6H8b1YF3WYQVHJ/agyvg2RDQ1Jd5lvKx78sZ10yCL14jTEwLMtIzrGOdqF8dGzMoSstyltZjaERrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890

Re-implement br_multicast_enable_port() / br_multicast_disable_port() by
adding br_multicast_toggle_port() helper function in order to support
per vlan multicast context enabling/disabling for bridge ports. As the
port state could be changed by STP, that impacts multicast behaviors
like igmp query. The corresponding context should be used either for
per port context or per vlan context accordingly.

Signed-off-by: Yong Wang <yongwang@nvidia.com>
Reviewed-by: Andy Roulin <aroulin@nvidia.com>
---
 net/bridge/br_multicast.c | 72 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index b2ae0d2434d2..67438a75babd 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2105,12 +2105,17 @@ static void __br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	}
 }
 
-void br_multicast_enable_port(struct net_bridge_port *port)
+static void br_multicast_enable_port_ctx(struct net_bridge_mcast_port *pmctx)
 {
-	struct net_bridge *br = port->br;
+	struct net_bridge *br = pmctx->port->br;
 
 	spin_lock_bh(&br->multicast_lock);
-	__br_multicast_enable_port_ctx(&port->multicast_ctx);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+	__br_multicast_enable_port_ctx(pmctx);
 	spin_unlock_bh(&br->multicast_lock);
 }
 
@@ -2137,11 +2142,62 @@ static void __br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
 	br_multicast_rport_del_notify(pmctx, del);
 }
 
+static void br_multicast_disable_port_ctx(struct net_bridge_mcast_port *pmctx)
+{
+	struct net_bridge *br = pmctx->port->br;
+
+	spin_lock_bh(&br->multicast_lock);
+	if (br_multicast_port_ctx_is_vlan(pmctx) &&
+	    !(pmctx->vlan->priv_flags & BR_VLFLAG_MCAST_ENABLED)) {
+		spin_unlock_bh(&br->multicast_lock);
+		return;
+	}
+
+	__br_multicast_disable_port_ctx(pmctx);
+	spin_unlock_bh(&br->multicast_lock);
+}
+
+static void br_multicast_toggle_port(struct net_bridge_port *port, bool on)
+{
+	struct net_bridge *br = port->br;
+
+	if (br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED)) {
+		struct net_bridge_vlan_group *vg;
+		struct net_bridge_vlan *vlan;
+
+		rcu_read_lock();
+		vg = nbp_vlan_group_rcu(port);
+		if (!vg) {
+			rcu_read_unlock();
+			return;
+		}
+
+		/* iterate each vlan of the port, toggle port_mcast_ctx per vlan */
+		list_for_each_entry(vlan, &vg->vlan_list, vlist) {
+			/* enable port_mcast_ctx when vlan is LEARNING or FORWARDING */
+			if (on && br_vlan_state_allowed(br_vlan_get_state(vlan), true))
+				br_multicast_enable_port_ctx(&vlan->port_mcast_ctx);
+			else
+				br_multicast_disable_port_ctx(&vlan->port_mcast_ctx);
+		}
+		rcu_read_unlock();
+	} else {
+		/* use the port's multicast context when vlan snooping is disabled */
+		if (on)
+			br_multicast_enable_port_ctx(&port->multicast_ctx);
+		else
+			br_multicast_disable_port_ctx(&port->multicast_ctx);
+	}
+}
+
+void br_multicast_enable_port(struct net_bridge_port *port)
+{
+	br_multicast_toggle_port(port, true);
+}
+
 void br_multicast_disable_port(struct net_bridge_port *port)
 {
-	spin_lock_bh(&port->br->multicast_lock);
-	__br_multicast_disable_port_ctx(&port->multicast_ctx);
-	spin_unlock_bh(&port->br->multicast_lock);
+	br_multicast_toggle_port(port, false);
 }
 
 static int __grp_src_delete_marked(struct net_bridge_port_group *pg)
@@ -4304,9 +4360,9 @@ int br_multicast_toggle_vlan_snooping(struct net_bridge *br, bool on,
 		__br_multicast_open(&br->multicast_ctx);
 	list_for_each_entry(p, &br->port_list, list) {
 		if (on)
-			br_multicast_disable_port(p);
+			br_multicast_disable_port_ctx(&p->multicast_ctx);
 		else
-			br_multicast_enable_port(p);
+			br_multicast_enable_port_ctx(&p->multicast_ctx);
 	}
 
 	list_for_each_entry(vlan, &vg->vlan_list, vlist)
-- 
2.20.1


