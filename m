Return-Path: <netdev+bounces-149444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5849E5A1E
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 16:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE28F188587B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 15:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B36322256B;
	Thu,  5 Dec 2024 15:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T5J0FLg7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B6222586
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413474; cv=fail; b=WnQZHSpbfhizEUbKfEwjMGOTnk/ABXMb1z0Wy9zUSgnPLuLBYmVaJlEXtg/Oh0Cwrrbu1KEtD37k9iu7IV5fGMXY/Mj4TCBj8e8Xp0Uq2/igzeXmrV8xsk2PrrnQ4FEudcF9WQmhNbWa3kU33iaKm2NhB+XVopQYISZVif6Red0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413474; c=relaxed/simple;
	bh=YEHkgNLx/tb0gfgEQeQSwN8XQpdkOocjCoraYk9M8F8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHvzNL8KcprqWqhBmxflPL74sSW90Z5vAqVLUcOW9VoGatVBnlk5XMmxpRvMJBjy8G8TJ4fvo5H7wUf4WkvO5HuGyLxXUj3514rckX7DaRhKubY1sQCLfZcU2KLvTY1tF205DVhbNPEx6OkwK4nsG5BloW2ZM22OoX6DaFz3Irs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T5J0FLg7; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyJaDRWo3rfcOp5cnJhs1ek29RZ9LMb7XQety7Mlnn4j5iZI2hO0lJO+/8NL6rs6jsGltyFwyCFFtJrvgcQJJIzrteoYB+r2v/0EsFAOTacjP+PR+e6+N8q8D08+cfv2dRITn0t6RZxUzxpOq40ccCqeIbLjHNSSopsZX7FyPPWHpa5X9NqvMUJl46v6pcfrsm8mT+T7E5BewD7Yc5NLaYSQbesqmRena3nt4gOmcUzMeRMd4UvCC3OucL+IRUcG3n8dfRnn2xeg6u9P6RB+KZmQcLlYU2pHu0h4PqxpoBe992hfLSFichZdkFc9/Df9oJSxE6noCboFfJUFtmps8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie9AdLveZSKME6RdU2O1lJU2FprlCLYC2C2NNUGm5T4=;
 b=HT9vgZmqOVSgbWa+K8U6hA86lJNJFVI5PeglKV0fbCU9uLriSX6VAk5sRGNhQ1H89oGlSFLB3myRPVF2LvE/hGCA4lus0+bjP+ccp4vjlBEQmDeGTVJowMtGGbYKj6Y4a5VmzCz9rHvLGA7el/BfEgsk95gKgWKUpvItAZTvndp8Z6rWJbMhW9FFGDRem3RWYKTvpn9uqYJTiGoS8nrGeaY8WyOZI8CiwSKEUJFfd+eVbrB4NJxu84gaS/oBG6vX72o3IiXeFUm/Ub5GcYcnSrHLL8hYD9nVARztkdqmMMrg0RBP629yQSeXrZiFtXtOuivHNEGiu1V/RsDu2nDDmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie9AdLveZSKME6RdU2O1lJU2FprlCLYC2C2NNUGm5T4=;
 b=T5J0FLg71Nbij93mC8/xSjJQcEPtlTmCKcXFI5MKWGgySbLdyuDf8gMe9IU81EsNpxACQG2g1kCNEKnY2BqBM+YsVhVJw+uGXnW7zf+A3mzU7lXq8AmeKjOo10iR8f7IA1fRXGD/nZrBOwhJDTu+30YA97Kc3CLIumjGB1Bvn6vnHkHjsJPti4FaXJBT3RZ9+prnVwnptKRbcOCuJvOrkDIDRi2ji7GGJDRSY1i3XDbE9tAmiUAlzt8xxz/Ca952fKM3TdAOcyiivF5VrchMWX3hXpj9h0v+la7wRESRBV6p8fIg/AkVdwAIW5lzE6J7h93azNR6meKnY1dF4VCTeg==
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 15:44:21 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::df) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Thu, 5
 Dec 2024 15:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 15:44:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:07 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Dec 2024
 07:44:00 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Menglong Dong
	<menglong8.dong@gmail.com>, Guillaume Nault <gnault@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 07/11] vxlan: vxlan_rcv(): Drop unparsed
Date: Thu, 5 Dec 2024 16:40:56 +0100
Message-ID: <4559f16c5664c189b3a4ee6f5da91f552ad4821c.1733412063.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733412063.git.petrm@nvidia.com>
References: <cover.1733412063.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 255f1298-ab29-48cb-c5c4-08dd1543af84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jscxwBYMdMjuSLcBAQy0wO5SkXkdvab7jq7FokMGn4PWo+xn6w99GNWHQXD?=
 =?us-ascii?Q?CvVIZ/UqhlzOSwfVHop7SLYmGQZxawj2AZ0xKPnlbb/pJl/SGQ+Hxix5dyRx?=
 =?us-ascii?Q?WLJm2+0BicyfDiFWZDvCs8B5LZQU7ehNDzWBzvR3vp3rmSJE+sEMjawB2SH9?=
 =?us-ascii?Q?sl6aNW9Zfp3JFK8PnvwubwUrFHcSmOnWQdwQW4oq0QUvJGuYxiPnc6NUg6IA?=
 =?us-ascii?Q?AVkpVbzmxaTHuUqlto3LKfgJkOVz6QAnLE+ydLGKx/OxXe7hGtU8PGqge13g?=
 =?us-ascii?Q?MzWbiQeeUf8fKP6+M3gWcr2Twc90xZchELTI4B0Fed0IDjwQt41Fe9+fl/gu?=
 =?us-ascii?Q?mkdpQpif83H0GydrsaCyI6HmclwUlxgSNwI3bG0iJDpLI9Bs7UBgPdPg2vdH?=
 =?us-ascii?Q?4+MGITwCRaFCJZKVLOtbJvWmR4zjmNfTHBHQ6ChS08HuhSmY1ih3RUyezK/s?=
 =?us-ascii?Q?JhFzXfbmbjUu2GYtmCrxLSHtdxau/8lL420xPZoSCA3QNm+q/SIbO8QMm+um?=
 =?us-ascii?Q?nvz5SdDpNpVEdVuzZiseObAB34WzSKnaM7i2YCW4PW/cNl2OraFNx5JTCsS6?=
 =?us-ascii?Q?V71TyhH5CwDBQw4JKcMtvaSKPy3mJdqkLj0TUW/lxY8+sOnmzWitYCiYNPnr?=
 =?us-ascii?Q?x6EZ7CBrxByScVXsUM7hsRGdsJamc+W+QCH1o9xEWt7lEg0w7aoN9dz0QVSQ?=
 =?us-ascii?Q?PdfW00iqtTymM6VCcY82HQ4o1WHavFb5zjbR8MwJOV1JNVbBi2uFGwAhQN0c?=
 =?us-ascii?Q?QLxaS31qugFtMePdc789TLWD7zZJS10KON5OIAfOoijjcDlMHBp/O95XFF2S?=
 =?us-ascii?Q?r4+X1uTBqfpToPcJIrCb1ud8yHAqKNv5HH4+frT1OHCtkTN/Bfg32ZfIhou3?=
 =?us-ascii?Q?nTRskiQIBLvuf7sa8xzlsS++FcW5fxw4G+fH8lTKejGWNe1slkvbkbfDivuk?=
 =?us-ascii?Q?6WzNAxmW3OkrrnZPQuIJV/FQn9q519eA18DX/R6iP8ZsDyFKxgwqqnhlWXAc?=
 =?us-ascii?Q?o52xDUjU+or2NBaVC5TIH1HviI+rc55Cxu8guVXVBAHJMU0xmfWCbAPmjbpb?=
 =?us-ascii?Q?4zLeJWbuXqAyxp+huibtoXHhsX2d9S57hqu9HiOV8elzU5LeX/QydQz0hqAz?=
 =?us-ascii?Q?44Oonir8YrKS5VgdtT/AkEuOLuC9LM5EsbfzkGWo8c427FPUBEKjuspjRjay?=
 =?us-ascii?Q?RRiMjX773xLWIy+OuXjXtgEYFF0Fr2FTbprN3kjvxlOgP5nbaWVNz0euc4QF?=
 =?us-ascii?Q?uGHfD8InB4LXRdf8Kt2wnly4l9SuF9zdJojVO1QVeDQQUt1O5djTabCdn0Em?=
 =?us-ascii?Q?IDU5GVHP7y7NdNv40tzSjclGk3PVF06je0leDj2ZKa1CcLnz/2wHTzh0jEVO?=
 =?us-ascii?Q?V13+9FohEZEFIpqUV5qalGhysuk00XAdtBYEF1ckce3yAV+Q3h2qF+0XtIx/?=
 =?us-ascii?Q?zKBhO5l+LorvTJdJSGJ49T90yVckGxsF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 15:44:20.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 255f1298-ab29-48cb-c5c4-08dd1543af84
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972

The code currently validates the VXLAN header in two ways: first by
comparing it with the set of reserved bits, constructed ahead of time
during the netdevice construction; and second by gradually clearing the
bits off a separate copy of VXLAN header, "unparsed". Drop the latter
validation method.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index b8afdcbdf235..b79cc5da35c9 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1670,7 +1670,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	const struct vxlanhdr *vh;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
-	struct vxlanhdr unparsed;
 	struct vxlan_metadata _md;
 	struct vxlan_metadata *md = &_md;
 	__be16 protocol = htons(ETH_P_TEB);
@@ -1685,7 +1684,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (reason)
 		goto drop;
 
-	unparsed = *vxlan_hdr(skb);
 	vh = vxlan_hdr(skb);
 	/* VNI flag always required to be set */
 	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
@@ -1695,8 +1693,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		/* Return non vxlan pkt */
 		goto drop;
 	}
-	unparsed.vx_flags &= ~VXLAN_HF_VNI;
-	unparsed.vx_vni &= ~VXLAN_VNI_MASK;
 
 	vs = rcu_dereference_sk_user_data(sk);
 	if (!vs)
@@ -1731,7 +1727,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
 	}
 
@@ -1745,8 +1740,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		reason = vxlan_remcsum(skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
-		unparsed.vx_flags &= ~VXLAN_HF_RCO;
-		unparsed.vx_vni &= VXLAN_VNI_MASK;
 	}
 
 	if (vxlan_collect_metadata(vs)) {
@@ -1769,19 +1762,12 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vxlan->cfg.flags & VXLAN_F_GBP) {
+	if (vxlan->cfg.flags & VXLAN_F_GBP)
 		vxlan_parse_gbp_hdr(skb, vxlan->cfg.flags, md);
-		unparsed.vx_flags &= ~VXLAN_GBP_USED_BITS;
-	}
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
 
-	if (unparsed.vx_flags || unparsed.vx_vni) {
-		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
-		goto drop;
-	}
-
 	if (!raw_proto) {
 		reason = vxlan_set_mac(vxlan, vs, skb, vni);
 		if (reason)
-- 
2.47.0


