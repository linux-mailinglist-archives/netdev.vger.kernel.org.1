Return-Path: <netdev+bounces-233065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B973CC0BB6A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D7A1899F6E
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 02:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB7B29BDB4;
	Mon, 27 Oct 2025 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/TEr+2U"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCA227AC21
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761533449; cv=fail; b=i5s3Ay5ofJJz0TVzNaEsqojy+jo3FU9ZfYfXC59P9F+nPcHE4ooIMtP8tRGzsbYiiQ5SLHu8Z3L/K8ouGJn4Ec2fOB1lkBBxDeefbZIX/kc9IcdF/0gfPKrkwQGmotG/+rFC6mXEyEro56YsNwmPQr0kUr5LIq7PnXh1QfJD+sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761533449; c=relaxed/simple;
	bh=Xy6AaNba5rDr/pAX1VmEqEtdK1qOR+SXZR3wPFLnsrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaaHIz/Gsfy2SD6tLQG/WwsjK8HHJ9Y5YFtmcIGDRuFIEfpPlw9ybj9kbqMxdN+8Pe8AiD4M4G4LP1Inao+48XtpM9JN1fYjAn7m+3tTcJfAK8DP4RGWAsGNcGK8sTReh3t81m4vkRXiRvjv6anjqb8hDZAArrx7RRayJ+MjixI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/TEr+2U; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DUYgWTuhNuw1ESpbLJuVyenYR/5WBhDqwAtIG5l2dDQ8bVjh3o7pdvJ4s4uu37aHCnShFpzY4/K8Ykszue1UM5JS3tucYBvfhPORHsb1CV/4fJWc4+Qm3B5eF794VLjF0W4pkdEnEiX92PLjAdCYJH1+9xdXaZQuYDcWWG2jMPxZjdVwOpUqeJ8J82dOKGkxeL3YIK+fsVzOIBmKd7IUGy9pYaf5vtqAcXeHF0eKqJt5r+gXRcRLzaFNOmYg5UNucYAlK0k/1F79akd8TbFsRebmdOmOo4E10ODpeF029XElEtS6DFXtIq1EUg+bRKGi6EEkkM0FzrXm/3z3Ls/PZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/m5mn7Pin0OLqLTAJ1v7Cqq7t3NVRqeZv7L8s3MNOc=;
 b=nzUUrIw/L6HsUpbu5YuvqVb333pIaxQmXEIdf7ybxCyEHoih4AyNJGkr3gQf7rGs0JNIjblgPV1YiPjZ5cowVFn0KxlZEyhoYq1HQwa9s+EDarN5P7xGfD6M9372Zhb2wh0RltLNmkQMpjikLMHH5OEntaCXcKI7E1ljhkFDhB7dAs48I53IDTkCSl24+CrslRvfMB7++yOAxF+TdRlSMo5isGLMWYEj1UUUWWw+ZEChZPKemnBxwMvAXGUI7kia2HRsMsFZidD8r06RpWhxNVLhiBhB6U1+1gy1EFYebg4MxTG05R9J+YNuIoSWObdvzsWxIlakkcBGirFcA0DX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/m5mn7Pin0OLqLTAJ1v7Cqq7t3NVRqeZv7L8s3MNOc=;
 b=Q/TEr+2UNPVPf3OpI4jY2YPgJq2z1KWj+VIW+NpCXIe0a0cC+L24+44IJ2r0j0NiIUS/i4ho/tPFocsUzXISoay6M7TEw08PAXYx7yWIpkKNxt6iuoWBpXOYBly06keISgoZGcoBazN/e69PzpmGJxzs84/6QTdz3zP4QfvN/2e34TxwqHvJjW9T7puc+1aYbYjR50NSYPp6b3sHTcra7Kgvm1RyHta8pYheqBs+6dhjM5HR3NKu327Id8AFKM5IHQp8UAcVemf7RdFAWJe727O5rMhlAHZb8nmsIvXzf+UWpk7v32/NSg1NaLZvz2tSm3cgEOLSEjFYMGZ/7mdMSg==
Received: from BYAPR11CA0047.namprd11.prod.outlook.com (2603:10b6:a03:80::24)
 by MN6PR12MB8516.namprd12.prod.outlook.com (2603:10b6:208:46f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 02:50:43 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:80:cafe::82) by BYAPR11CA0047.outlook.office365.com
 (2603:10b6:a03:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 02:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 02:50:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 26 Oct
 2025 19:50:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 19:50:21 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 26 Oct 2025 19:50:17 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky
	<leon@kernel.org>, Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec v2 1/2] xfrm: Check inner packet family directly from skb_dst
Date: Mon, 27 Oct 2025 04:40:58 +0200
Message-ID: <20251027025006.46596-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251027025006.46596-1-jianbol@nvidia.com>
References: <20251027025006.46596-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN6PR12MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: e15b8902-c13e-45e2-eb2a-08de15039edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aJuoZ1UxultZw7ka0yNAkvK7eCwSVLwEXWrZcmy9F0u8IxpIh/efSLXoT3/M?=
 =?us-ascii?Q?QtVuwn6ngS9MI7xoricolF/uBMQkOR0S8wuoyqllw5xTBPcMTZ+xd/A/GybN?=
 =?us-ascii?Q?/yQ366VOPXGpin03WujKZ+Z8sQWsAaxhxV2shmDL3d1loVPklRzJZsmDpkUk?=
 =?us-ascii?Q?oFG6DEqImkefUOofEHiisCY3ZfnCJTnkVsvsgksu/v/3TLWiMyYgE3Kd7vjM?=
 =?us-ascii?Q?a2z1O8N4rxvWEtIV/E6h0TR2G1RjShULxXjiafW7wRO0yH7mr62szwtl5+1r?=
 =?us-ascii?Q?tBEIysfM9hsqcaZJmVji9uBlybfXAXfcsLJMoxcoiscdtKKHG0CpjoXWwU47?=
 =?us-ascii?Q?jUz9VJ7bzS6uH527FZ5+twxZgM9io8VWFWoBqXbd4fHvbTOvn7JpOZNBe/yq?=
 =?us-ascii?Q?/3fT9XgopE+JgdqEs3IhPcuW1ocJC3V64VP4g0zqEc5bzRztE28Vg3vkqRMH?=
 =?us-ascii?Q?d/SGPpbfidXRFsn05XxO0OBBs0y4fZDrlirGi5Zjpjnw5IEr+DXcjvyevC/L?=
 =?us-ascii?Q?r6LTjt3oxto58FqTVfTPgIetuycLPZQrDt4nM+7R6IzvH0YxoNhHKiY2ULcM?=
 =?us-ascii?Q?2FcMLynvwshS0wq+DXQ7MC2QbJ3INMwra96gYIG9rqXfjCBXyByKvhD+OX2d?=
 =?us-ascii?Q?0iLQsngL2RSGdrRyTquzTxIHwWDEtJkOyY9cm3Lj66etKIs+euiDGOTzq/Ey?=
 =?us-ascii?Q?vzpcFwZKwvfwP4DBfFo0EcBttMyUfyFv8oGzTRFsy5Lhx+ekwgCiFIPkqCPB?=
 =?us-ascii?Q?uBhaW0XBgydeQn3f1W8Aw53F29U+99V9mWDOTgXk4RE9Oe66mq9nAsdMfWaM?=
 =?us-ascii?Q?j20i20q9p9I9t89FzurwtGZblyX1vbouoLGljkIi2dychlTHfPu1iS53fhhD?=
 =?us-ascii?Q?/iBowOWphoMl2th7sKwQc5HfgEVhmZKbcvUHnvDJxKEyqoaTweAWwPXQFxsT?=
 =?us-ascii?Q?QgJhoN5+DrXj72/0EQgOUfI8HCKcBcZCte2zxoTgEJSLrWVaAMcZtAQn96av?=
 =?us-ascii?Q?QDMID8TDZm3X9cXw1uG8/ABreSgvWNd3GFUSuUm2K8fR/IlRiJ/eyX/0fzEm?=
 =?us-ascii?Q?AZoYIN0hvVPK7WO6dMZppVmCcwupzaZmr2S/1tC/d5y82ttiUr9ISVcv1X6v?=
 =?us-ascii?Q?OrnZJUEWY2sXHhPfsIVlcbaaEz5RVU/xBM3I5QYwAXCDBJ+YZTLfh3d9fUVs?=
 =?us-ascii?Q?w9C7YxrUIwdCNDWVALBLCT+VxU8BObfkVCH7GG+V0SBLye1C7q+FjB2hn9LO?=
 =?us-ascii?Q?NxPJvYNNn87m6s2FO9GgKpc2Q43kYxJki6VDe/S4NXlRhl4JiIrh7XzXpvQ0?=
 =?us-ascii?Q?A118Nck6ZHki6eXLsxjKvwa61oT2heGco/++m1deS/lwyEwVs2uTtuoaQJXs?=
 =?us-ascii?Q?urXqakE5N1kAot42SAVAyuTHHw50Vz2fCN+bTzi/Z7vKZBto1Rw2bEinSawn?=
 =?us-ascii?Q?YyhSj9SZVo0l1pwva+9S/iMAJMy1RbPtfch02Xnr8+0c5VDLoBRu83qlgLSu?=
 =?us-ascii?Q?wZOmcncGRDd6u49QNxm+Qq2NaLFdUOKxFLPUXZ/UL4iv9/X371hRRyCYqleJ?=
 =?us-ascii?Q?bqFVNKIhwVj1jPpN9B4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 02:50:42.6617
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e15b8902-c13e-45e2-eb2a-08de15039edc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8516

In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
need to determine the protocol family of the inner packet (skb) before
it gets encapsulated.

In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
unreliable because, for states handling both IPv4 and IPv6, the
relevant inner family could be either x->inner_mode.family or
x->inner_mode_iaf.family. Checking only the former can lead to a
mismatch with the actual packet being processed.

In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
is also incorrect for tunnel mode, as the inner packet's family can be
different from the outer header's family.

At both of these call sites, the skb variable holds the original inner
packet. The most direct and reliable source of truth for its protocol
family is its destination entry. This patch fixes the issue by using
skb_dst(skb)->ops->family to ensure protocol-specific headers are only
accessed for the correct packet type.

Fixes: 91d8a53db219 ("xfrm: fix offloading of cross-family tunnels")
Fixes: 45a98ef4922d ("net/xfrm: IPsec tunnel mode fix inner_ipproto setting in sec_path")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
V2:
 - Change subject prefix, and send to "ipsec".
 - Update commit msg.
 - Add Fixes tag.

 net/xfrm/xfrm_device.c | 2 +-
 net/xfrm/xfrm_output.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 44b9de6e4e77..52ae0e034d29 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -438,7 +438,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 
 	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
 			    x->props.mode == XFRM_MODE_TUNNEL;
-	switch (x->inner_mode.family) {
+	switch (skb_dst(skb)->ops->family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 9077730ff7d0..a98b5bf55ac3 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -698,7 +698,7 @@ static void xfrm_get_inner_ipproto(struct sk_buff *skb, struct xfrm_state *x)
 		return;
 
 	if (x->outer_mode.encap == XFRM_MODE_TUNNEL) {
-		switch (x->outer_mode.family) {
+		switch (skb_dst(skb)->ops->family) {
 		case AF_INET:
 			xo->inner_ipproto = ip_hdr(skb)->protocol;
 			break;
-- 
2.49.0


