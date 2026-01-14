Return-Path: <netdev+bounces-249776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741AD1DC00
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5061C303D320
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175338944E;
	Wed, 14 Jan 2026 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTVlDsre"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012024.outbound.protection.outlook.com [40.107.209.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D337F730
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384561; cv=fail; b=W+vQ68+Wcfq4JDazEOu5K2o0TxalvGOJK5Oai7paDso5vmL6YvD/BrBU32oJMZxm3tOwrVla49ZSlcHXhBufJaq88cJ/nVpfwjH+bnWY/n5N7v4Ar6xqZiEuH8f1WI3Mm+pufiC6Rn4AIMbLDm3BP48aQFonwJNXsTilYVlxCc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384561; c=relaxed/simple;
	bh=bMm+sLeymjrAKdNsBeMElqNiDRTTgTdrTBXxBqhTOLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neEuISXMx2k9quv2XtKZN/+JKqB6iuRu4iheb6w6RxvHN0TG8rwbZE9TfMTbtZz1jWgyh6TzggH8hoqu8r+BSLufBGMX+RS7wvW7enlFIeFZj2OOVjs8LrAlfaWOvgBgddBb5gv/vrWpXvqvj+q/f/dkEL+dsniGbAy29HWl3K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTVlDsre; arc=fail smtp.client-ip=40.107.209.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYAbYGEeRg2YFp9NUvs5e2Tx5Bvz/QpDh1THvM8UcEFPNcUcK7tbZuZQuSFSPMOjGswyR1afI91FVCKX/XuuTtuFgzL8AppuXLRix5zdPkvAnacbxb3gan9BovfeQB2fM8fgMU96+pHU+1QKtAFGEcB/Tv98fUsNZvGcgzEa3uTY6/xHFCVBe32rYRnnFSmp8QD7H5SxZ6i99WSdk/Dh7FCr+mrhhB9wDCWUB1GU19EuHHclrkSFbuKsgImWr4CHPXtE+eXya8dCJSWi1plj1nwwvH9dcoZQyZ32+1E5AcIyfGG9o+RJvF7C0a+s+fE2JRaOYnAjzmYglpmkOx5lwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NdlORdFDUdtUIYooeCuXWB3kB8ye50rKigjBCGpCUE=;
 b=WtIgraIY6mOCYJpdpiYDxHYOpc7XT2NWaoW6dQwMXPqQPMy5LvpSLZKHOhThYebNsJHyP+Ylcrre7A6qU8UySCXDKjC8zZwvim2gmM54ua67EMilFeRcY/EJTQs1ezOlSnxPWJ7yBYqOQifiDZWNkJcne+FoBVCszHGBhAz8XcH5EWL/s+tkpOvb8EsFjF1ealzl0jGsRZdSsjoXmCUdFLw1DBWcKwjb0pY+EiFDJEbGMX613YvcGYZoN+DVf4s1xOCAze6i5V1q9TEppTF1U3jSnT8EFUxFP7bQxptIgqW950DY7yDMvtSysckHEWls7hKW5cE0Gt2Wfc+6siOfYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NdlORdFDUdtUIYooeCuXWB3kB8ye50rKigjBCGpCUE=;
 b=fTVlDsrerA8yx6jkvJXzPyJvytk7NEUV5wtnki7s5zU3nNm+nhGyBadC5CLvboNWikI16dC5IRPChX/HGJDbN37+C5F+4JXKFbf2E4/cryf43f+aOLwJat5D4E/NlMjOW5NLDpUYf+V8IMIBRiFU5oVv8VV3x3pxnxjVsEhSAU1mxWXgUlsJhyyzD66J4SV1IRtCH7XhG9zifrUfbZGv6B5pKPtzJ5AueeM/TwJW+WqqzaaG/d/xtxxpRXvrapf4uPBOqTLOMAZ/snt47+/2Hu+2hW4V12+lrLwNkDRtVAn68PpNsTLIOoR7kkv+jdGMwGOqtSbRo/TDMy7iuqcdxA==
Received: from PH8PR07CA0032.namprd07.prod.outlook.com (2603:10b6:510:2cf::6)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 09:55:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:2cf:cafe::c9) by PH8PR07CA0032.outlook.office365.com
 (2603:10b6:510:2cf::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 09:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 09:55:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 14 Jan
 2026 01:55:38 -0800
Received: from fedora.docsis.vodafone.cz (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 14 Jan 2026 01:55:32 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
	Breno Leitao <leitao@debian.org>, Andy Roulin <aroulin@nvidia.com>,
	"Francesco Ruggeri" <fruggeri@arista.com>, Stephen Hemminger
	<stephen@networkplumber.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/8] net: core: neighbour: Add a neigh_fill_info() helper for when lock not held
Date: Wed, 14 Jan 2026 10:54:44 +0100
Message-ID: <accfea32900e3f117e684ac2e6ceecd273bd843b.1768225160.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768225160.git.petrm@nvidia.com>
References: <cover.1768225160.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: eb748061-5109-4df5-959e-08de53531cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JxIGIFgC6rndLYEiQE6sLN8Xz3gzGtd7f3wiZtQ1jqTplXSHE+IjluCOUlpD?=
 =?us-ascii?Q?+EIblrkZuTO+Zt65LYjChd82Qv6WcO/AByvIWwuUa0B49D4d2O8j8qWAHD4i?=
 =?us-ascii?Q?vfyGOSM/gHTYMgPl2Rl5r+Zgg2DERrnySnkN75XimQmNxNsyOZg+kx3xbobR?=
 =?us-ascii?Q?N7/J9YytAj2PfnBmOYddjc7eqJV4bAo1ai6nwe1PzImJvds94s5QxKj9YO8J?=
 =?us-ascii?Q?38waWPWlx+RdK9zbiNxjBLPdtELZtlvKKrTiUJQr+trVRdp8lfso9WK7+F7c?=
 =?us-ascii?Q?ClNdzB7izHMRjo3uax6TDCQC3LbEhgaSRmNOwLGd/XYoA4MWBcK/S5/c8Drz?=
 =?us-ascii?Q?HHQl/7dPJuflPL+iGIq3AjJsM8Egd+p0tClWY7Wlfmdi7l6VXgMQ9nicKdQa?=
 =?us-ascii?Q?53v3koHMoh8d9IEc3VZ5MxgErisFByTGxPvypciWnKCoeSVdYy/xc8oL9V9Q?=
 =?us-ascii?Q?BAIdnazlWdJCPRQ/ZM+t1pxMeFqZNVK2WYswVLJax0zeU6jTwBCVXsz8n8P7?=
 =?us-ascii?Q?OfFMldUqrQCyAJwTSpsbIGiqW+2grklQAXYP//SWeipMXZyDtMZKv6YvHueC?=
 =?us-ascii?Q?DtmPOWZH57/AszbBS3OIyOClQjxNEXjNQWDl8gNiMzJOM2Ng7maQxU/JpRta?=
 =?us-ascii?Q?ykFAPdmk/mqL5nEjO2+xUIXhOZb5P1VAQIGGo3cgEsxqtGC+yZ8Iw6dLDXOb?=
 =?us-ascii?Q?jyMNRF/Wz+ybrdkULlehdhXsM2XjgchXUND5PZ9LQK5RvdD7jf6Si3NTh25V?=
 =?us-ascii?Q?rUlwfWj2O5N7AID6d4HJ2tFdviFc/JhSBCEOCsSkbL1eNDr9zEZt3C0bqI6H?=
 =?us-ascii?Q?93ugjEVttoZmGwzxd7JwT5bk9OOUiSGgtW8uYTUhJiErTRIkzWJe4rbECvm1?=
 =?us-ascii?Q?KZCoAdeXF6cXr/M9MrWHnk0nyHZAwbicrpn0/lB3YqrCQgEAP+vks3iAyxKD?=
 =?us-ascii?Q?2ydF22HNpLgGIiAuD7+162QRZQa2RPft5FZI435Q/JUci81V8bGmp/cnMuFc?=
 =?us-ascii?Q?pioorPwnc91ftwpw2IxafbmU7jEcJugTtPhx9xslcRJZ+hkrT5hC9E7FguLK?=
 =?us-ascii?Q?+hRXYdiBz7ar0JjucfylAJhPXW9CaF09x0leMRrQkOeTGiQyGFc1kD9LgLqO?=
 =?us-ascii?Q?5pVjbLwHeHCYy+WB42kM/e+Xntq0cM/0hxeKk7JtzvS4yeqUk4Hk63CUa9hy?=
 =?us-ascii?Q?9Ag970ZU7FMrWO09ZIc5AgtIG+DE9JlZ3gbFwrjGRF/OwOUDnecPiabBn1zD?=
 =?us-ascii?Q?yOd9m3brdY8h8TiJ9gedaUrGTXGEho3htlKp1xkKtVwV4lDI0/iPRZGkgcvB?=
 =?us-ascii?Q?qDrbwvdZcLoG7+5FyucQGoS5tl+/t2iqr2Yg/632vCrLap4hGITkArr11srb?=
 =?us-ascii?Q?RPKjO57j4khQocFIsZ9me7QsKsEFNGyy6y5UV6dic3eAzQ7qtySc3odZjjbz?=
 =?us-ascii?Q?S2vCyTv4MVSYHtTMTA8sVtyWXItBe5PhTf+dUb10Fw25C3uQ9fE2WLfKa0Y/?=
 =?us-ascii?Q?vZIMYz8YZI0j7ozevdpwcRKLNWEIGPe0A8yY+OjCXq9iaFXKfyWnMLschqEW?=
 =?us-ascii?Q?vGmKouN5LBwdTyOYkJA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 09:55:56.1696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb748061-5109-4df5-959e-08de53531cc3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116

The netlink message needs to be formatted and sent inside the critical
section where the neighbor is changed, so that it reflects the
notified-upon neighbor state. Because it will happen inside an already
existing critical section, it has to assume that the neighbor lock is held.
Add a helper __neigh_fill_info(), which is like neigh_fill_info(), but
makes this assumption. Convert neigh_fill_info() to a wrapper around this
new helper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/neighbour.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 96a3b1a93252..6cdd93dfa3ea 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2622,8 +2622,8 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
-static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
-			   u32 pid, u32 seq, int type, unsigned int flags)
+static int __neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
+			     u32 pid, u32 seq, int type, unsigned int flags)
 {
 	u32 neigh_flags, neigh_flags_ext;
 	unsigned long now = jiffies;
@@ -2649,23 +2649,19 @@ static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
 	if (nla_put(skb, NDA_DST, neigh->tbl->key_len, neigh->primary_key))
 		goto nla_put_failure;
 
-	read_lock_bh(&neigh->lock);
 	ndm->ndm_state	 = neigh->nud_state;
 	if (neigh->nud_state & NUD_VALID) {
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, neigh, neigh->dev);
-		if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr) < 0) {
-			read_unlock_bh(&neigh->lock);
+		if (nla_put(skb, NDA_LLADDR, neigh->dev->addr_len, haddr) < 0)
 			goto nla_put_failure;
-		}
 	}
 
 	ci.ndm_used	 = jiffies_to_clock_t(now - neigh->used);
 	ci.ndm_confirmed = jiffies_to_clock_t(now - neigh->confirmed);
 	ci.ndm_updated	 = jiffies_to_clock_t(now - neigh->updated);
 	ci.ndm_refcnt	 = refcount_read(&neigh->refcnt) - 1;
-	read_unlock_bh(&neigh->lock);
 
 	if (nla_put_u32(skb, NDA_PROBES, atomic_read(&neigh->probes)) ||
 	    nla_put(skb, NDA_CACHEINFO, sizeof(ci), &ci))
@@ -2684,6 +2680,20 @@ static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
 	return -EMSGSIZE;
 }
 
+static int neigh_fill_info(struct sk_buff *skb, struct neighbour *neigh,
+			   u32 pid, u32 seq, int type, unsigned int flags)
+	__releases(neigh->lock)
+	__acquires(neigh->lock)
+{
+	int err;
+
+	read_lock_bh(&neigh->lock);
+	err = __neigh_fill_info(skb, neigh, pid, seq, type, flags);
+	read_unlock_bh(&neigh->lock);
+
+	return err;
+}
+
 static int pneigh_fill_info(struct sk_buff *skb, struct pneigh_entry *pn,
 			    u32 pid, u32 seq, int type, unsigned int flags,
 			    struct neigh_table *tbl)
-- 
2.51.1


