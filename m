Return-Path: <netdev+bounces-232331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9D0C04253
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860FC3AF255
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD33260592;
	Fri, 24 Oct 2025 02:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P69RgDMy"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010031.outbound.protection.outlook.com [52.101.46.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4E225C816
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273600; cv=fail; b=F3qySfHGLHhMSSmxpAY5/lgU/3BDnquyjuc+fNiTLuIyRrw1c13py/f4KFMe0W/5+Uioh1ayIg1YR1y91qLMltW0Qjy9YVRXz35ARrqAHdbsfDyDhKvR2oCatqOWmzFrhlyozvLWMzfALMzQRxACMeQqHSEN/rGxvRqFBBru5Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273600; c=relaxed/simple;
	bh=d6BxyGuz2VZwWWCynoN/gZAIcq8hjZXAfhonedk6/oQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMjtO8AIczAPZkvPOfn23UG/v4Mz6gNnWGhDXOscRLXaEsxHQXXzh7TKDwYsl8SpX/PwkjfmujejzlHrelkFgoRUl10ggFa41D8Hwon8qqUZvIUK3DEA5aQ5o4+5qckPcx4Gcf3pfDFbraFgHoW+kaSCvhQaGfoTKGZm+fcaBSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P69RgDMy; arc=fail smtp.client-ip=52.101.46.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmvVVSGLWWGGU+Xqry5Qku4Qz4KldzVmmwy61T5WgqVfndZ+QWvEX0JTrsKE/nYrF8alOmRGvLTWAEQDh/qqCGf0UGJsHIb0KXsAkY+9WuOUGxtX3C/cEcJxQiKlhZAPaH344yhOOJzxsswHdovnZHacjdRYAWoQlhCF9/183icK1Hm6GcG2E0PD9xeMrFAHlYRuA/u/PzXhuTPA34Y7NxtANVxFKBc/yjGPPLPoYLoHBDdDkynpYejOfdMQNeXgltukZfvVuDQ74oMkcCRhzyW8q/WL+yKyvTwCKwaUpTqP3Zf0Uge5m+ZzZgsRfzF90/RsXJLEqEmjJ30K1VmNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxiZ/QLvI+bi6PxjpUMSZ3dwDbpj5JLf845ph67MyLw=;
 b=tX1uOZaD2ibjMqDzSqbWfhzr5jHyfVKGUHc9XzV36bdIze/oS7WgIAsbyzp589a9PbWKTYKsQHzjbjhWl6Pq4E7EN2y1WIpdgWK/5KJYezXpG2EXrYbO5A0F4a1MlVbuSSBu2efQ38lH5qrmfQ+mLwFYWEXJsjkGFlDQ7O5iKaiCI1k7v1EEBIsC12JpLygl/Zf7oAac1Pqzohu3ZAchQ0Ia505NlcN8cdNE1FKJ8YHuChaZLniC2JuLj9JEpMl48XRbaRhaMr26G7vXvO3LTsxtO4ledmKM5Ex3G5qqa6On0uyxtIrS8kywG2e5RbKM036U4Udkqk6IsigSUE3WWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxiZ/QLvI+bi6PxjpUMSZ3dwDbpj5JLf845ph67MyLw=;
 b=P69RgDMyVwuVi2iOkk44CmBDjLBfa7CSoykJ6gYGAeYFpMF4b7F4TX9ngMLbVZJP3nLef6/bN89xPC9OG8PpmWbsyaBwPGbLokL7uDy6O1XalTfqFWlZHAloKfI073t00RLz/CKWc4C6B3cQCPsD7zHMu9LiIakHRrD+UqeqhOiOzoBqtnjkHuDQqei+q2M3mxGyrVaAHbjHOmJRZ+o/Z3OJGiuesjMXxn+5wHbVuqMFxumYmTw0SHcQ6sOdmaAA9wvMEZW6LWvho0ZhiYZ0ZR91hoYL4IF5FHPIgT8MEwuDalWl3G1NUMxi/SkBzvD+/jENiB2KWbgoMebDCXqPUA==
Received: from BN9P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::8)
 by BN5PR12MB9537.namprd12.prod.outlook.com (2603:10b6:408:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:39:54 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::21) by BN9P220CA0003.outlook.office365.com
 (2603:10b6:408:13e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 02:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 02:39:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 19:39:44 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Oct 2025 19:39:44 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 19:39:41 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Subject: [PATCH net-next 1/3] xfrm: Remove redundant state inner mode check
Date: Fri, 24 Oct 2025 05:31:35 +0300
Message-ID: <20251024023931.65002-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251024023931.65002-1-jianbol@nvidia.com>
References: <20251024023931.65002-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|BN5PR12MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 443fbe9a-ebf5-4d1e-9cc5-08de12a69d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6pXjXVTvRAno92fCBl83PKpEkw575J7uQNB+y2GPNmC+r6VxT5dsOiMWZk8p?=
 =?us-ascii?Q?ihGV2ZlVad4r4ODnC+fUaysK3QJetVWdrjAlGp+h/Jenw12sv9DZm3YbY+67?=
 =?us-ascii?Q?chPaBmhN3tFrb9M/FkNbMbtbnXtQ/u//qCRoTkdZMpDNkQl/+WlHJzl/eIU4?=
 =?us-ascii?Q?CTDd/8FokeMOI4S1BG+YXz0GtsClATHVRwEkXmv1rik+txHRnDK4L/SJkE5b?=
 =?us-ascii?Q?AY2wXhWOid6+zEHkDySBzalQdDzoxfQAaSdZ2KHa/XGQYqf1N6owzPyETDsg?=
 =?us-ascii?Q?Vsmdhq17jJUpVjqy/LDsBZBIxn5TiGkQN0BGaPO8PLqkBD05pcTlIrU/Zwb6?=
 =?us-ascii?Q?rqe/nZZpy/X2tyEghCdM4uny8bCBCTuwbWT7GBZB25KSsmKYMjMV6gDh8oVu?=
 =?us-ascii?Q?se7tHMT0zrLcuWnrbqdnDqC+MfEQyHZweDLqqS+q4SJzgVAUUi363M0o6BSl?=
 =?us-ascii?Q?lh5eH+77tTM7RLtP7IkVIPDm4IIZ33wbTKWENLKTVbtRr0CdXOc0p8GDX/7u?=
 =?us-ascii?Q?EDsNaPP6Uj0tyDB3ui9iUN9O6dtFkRCDGEP1bNQ0SAKNrRGeUKz128g7DB2f?=
 =?us-ascii?Q?HL742oSuykbLSS/zqxees9zaQRV20tV9TFxHHIFZoK3woIyDUrtrwgE4J+5b?=
 =?us-ascii?Q?9OB6y5XQFA3APP+y/EjJl63zk7Qfe6mDGExPVrpvnyW6uLBKr0S8309vfw6x?=
 =?us-ascii?Q?1AccMh6g4qYcjGWlvdnmdbXxsMIZBRusbGmxl2rBeessI3BpkUFv9JZwi2p5?=
 =?us-ascii?Q?yhBhkgge1djwqkmjwiWyJDVn7Xvsfy4lQUIAoqJYSHAkBuezPLAfk6gaQMfM?=
 =?us-ascii?Q?mpFXLMUClzfIK3e1PiPPe5YD2TPThDF2k6SQMw14BwEbl6+mDnQBlUyfHocc?=
 =?us-ascii?Q?oU+sokLiWLJ63VQFVRpd/Yk0TQd5zs9Drezg9woBZGvHuJqloE2qhsEkKI40?=
 =?us-ascii?Q?2ATOI6aS+06+ua3r1o3E8VWdg09b4cUg4hgezE/8PZWlLh8nVbStoL2KAZto?=
 =?us-ascii?Q?MSTUsto1+MGrMfyJSnNTFagwM6jiBdY3Zneqju6P7pjZSTvpx6sH8qCsLaTc?=
 =?us-ascii?Q?f0TyRgtq9hmWS8XNoil6EXRvoQ1c3Z1DAxGVD1nJ7PEuqA9a+pZQ11+/nFKt?=
 =?us-ascii?Q?ehOTqHAzzmUX/hnZZqvKxBmQ3CNsu0md4GRUsM3LUQe/xXSTX93pr9GFUDrf?=
 =?us-ascii?Q?ThuE9onRKV2leWibEaisHyWMJAHlEMPDYNwpat2aJV/PW4TtGazhSndSc/pr?=
 =?us-ascii?Q?pqbepFvus0aLxyNgEt8lX183wssZy1s8hqdu3WMA5qEsPKH9yxMAoyJ+be/b?=
 =?us-ascii?Q?WPvxwEJlxUqVbDvSH5QJ1H+PQMN94bjmuQucSCZ2/lmUqELo08Ky75OMYj5z?=
 =?us-ascii?Q?LGyjTFWDgkNY/JPdptpNN8lmhEmiEEFtBd8ms4nybGy2MtOn2PGY7UG5qGSk?=
 =?us-ascii?Q?V4v9o2UoDqxwdzhdCyFCrAyjvYgqaM7MzLgx+VLssndkxaCXO8LgNL+kjoS0?=
 =?us-ascii?Q?bXFmr3422r3Xrh3uYXU3AU9hufpNMc31HKndl47/1/7cVc/29/Fk3EPvfIon?=
 =?us-ascii?Q?ViYOec81r+5nHoFfpqg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:39:54.5867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443fbe9a-ebf5-4d1e-9cc5-08de12a69d66
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9537

This check is redundant because xfrm_ip2inner_mode no longer returns
NULL, because of the change in commit c9500d7b7de8 ("xfrm: store
xfrm_mode directly, not its address").

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/ipv4/ip_vti.c              | 8 +-------
 net/ipv6/ip6_vti.c             | 8 +-------
 net/xfrm/xfrm_interface_core.c | 8 +-------
 net/xfrm/xfrm_policy.c         | 9 ++-------
 4 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..91e889965918 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -120,14 +120,8 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
 
 	inner_mode = &x->inner_mode;
 
-	if (x->sel.family == AF_UNSPEC) {
+	if (x->sel.family == AF_UNSPEC)
 		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
 
 	family = inner_mode->family;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..67030918279c 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -364,14 +364,8 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
 
 	inner_mode = &x->inner_mode;
 
-	if (x->sel.family == AF_UNSPEC) {
+	if (x->sel.family == AF_UNSPEC)
 		inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-		if (inner_mode == NULL) {
-			XFRM_INC_STATS(dev_net(skb->dev),
-				       LINUX_MIB_XFRMINSTATEMODEERROR);
-			return -EINVAL;
-		}
-	}
 
 	family = inner_mode->family;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 330a05286a56..7084c7e6cf7a 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -389,14 +389,8 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 	if (xnet) {
 		inner_mode = &x->inner_mode;
 
-		if (x->sel.family == AF_UNSPEC) {
+		if (x->sel.family == AF_UNSPEC)
 			inner_mode = xfrm_ip2inner_mode(x, XFRM_MODE_SKB_CB(skb)->protocol);
-			if (inner_mode == NULL) {
-				XFRM_INC_STATS(dev_net(skb->dev),
-					       LINUX_MIB_XFRMINSTATEMODEERROR);
-				return -EINVAL;
-			}
-		}
 
 		if (!xfrm_policy_check(NULL, XFRM_POLICY_IN, skb,
 				       inner_mode->family))
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f866975..a1d995db6293 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2711,15 +2711,10 @@ static struct dst_entry *xfrm_bundle_create(struct xfrm_policy *policy,
 			 */
 			xfrm_dst_set_child(xdst_prev, &xdst->u.dst);
 
-		if (xfrm[i]->sel.family == AF_UNSPEC) {
+		if (xfrm[i]->sel.family == AF_UNSPEC)
 			inner_mode = xfrm_ip2inner_mode(xfrm[i],
 							xfrm_af2proto(family));
-			if (!inner_mode) {
-				err = -EAFNOSUPPORT;
-				dst_release(dst);
-				goto put_states;
-			}
-		} else
+		else
 			inner_mode = &xfrm[i]->inner_mode;
 
 		xdst->route = dst;
-- 
2.49.0


