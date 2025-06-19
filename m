Return-Path: <netdev+bounces-199390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CB8AE020B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 11:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559584A03A0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD62A220F59;
	Thu, 19 Jun 2025 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OjP0/A7e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0FA221267
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326575; cv=fail; b=Rb+n+/Nb6TYZPZmIIk9yOhoDEO5QNnC12eeUkPMDiwxwuFBcMFunHRwOnVQxeOxj+NBCJ3s02i1FOCXNsx3zpUKW48aCIP1tVoyh1tVNuNXeENppaAjMN4+yLDMZi1jQre8LovDtRrtKTZOWhNBIAtNq6CGtuik1BZCGe9aWd7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326575; c=relaxed/simple;
	bh=kiZhshCyLZ68BOauza+WngetIOYHGtDvq1myyZgrbO8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJjEYLYoyh21EVmWXaUOXB0Ce2eZaa2Bcmm36Rkx0zpZDtCk7sVnUYOviJXm442Dis6D7jwlNNKaaY1JHdC48ukOMZ+ccItspudC3p5jsaW54GMB112qP1iqPMJXopBbogfvl08qVlcl9wU+xp3dFKcs4yj0fzzPGxvKhj0aN5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OjP0/A7e; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF7t5wV3xgWEhUABCmoS8BSmVPBZx8pWHhrZmOd33xGnyifCnZRo1K8uXCjEUIjVtaJ6+srhtygfC6Eu9wXybanzRA3MJBNKUEOYYt3d3iA+8FZg54cmnf9NpzSLB7219t+3GOpY3wvIySRD5KEIvrHMSzJ/VwPVzWGVmszgOANrxVA/XzeIM8xvQz5RgrCw7fMUluJLTCDI4vzy07vSBNSCTKnj3FAgXOBp35N+r5iTVZZ3o8aQCItuiNRucCtU0YC0Jdsn2JRcodgHSfu9jhEW38JVntU3StqcocJZNfL2hafYZ8HLVZ3pU4hBbCOM9xBY+MQ2ekb4N5lNVzcf0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwnvfaVd/wLCocq4XLnDUzx+giiakC3fRqYfENQzeEY=;
 b=YWDNFbBm3GD10cyyXqDjfH1bkcSUF6cPwtAzLGEmfQmfbL5/ZditRmJvjLqVwvNMwn2vyv06DykW31YyDGfLv+4Ii3r6VVhqw/PZdOpwldoPwFPlJbpyWTg6JLnnGAEoV0whhGy+P7aqTF5cGiXWg4mERJ4/iU9xTVfDUxukviXdhSl+J8BmG0QR1Afsld0t05PJ/Eps1iCXo+YOp2UpcZBZgl05rRwajzuTR3c1tTDuW/AjYHUJ8lBu9lqFcWAyQ5FlwSq2lLuGQ4QqK0LU8nbZWKhwYZh26SownJy5v7BmiRj/59fqR0zmufZcPJlDqBdXMNmI6p4Li25Q/NQmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwnvfaVd/wLCocq4XLnDUzx+giiakC3fRqYfENQzeEY=;
 b=OjP0/A7eLLKECpbrvh2LeQEazp7jxyW/tw/ch7G3ZVV99n2kh2aWp7yZopAWqtsMGoKHXljY+Yxk2Dhg9bv1HkruYuj5ihPEyrdnhGCr47Q/WpLRyAgNh86lr37X/lQo5zzkahMQWFqx1+qCBXSizk/ZgMQkk5t4TJaDtcDt8ItAJfSnB4FlUlYMHABSzcXnvluNJg8URTAADdfD6I/+1c1Hys6wsjTcoKl6nrsBhuRR1sbQL4j4Cq6pF4/dQ+xRzn3G+X+hfSH0iJ/zd7tWrwnYy3MJXR6C8DjC3MZp/6qTnhH0tpdOQXzSIcTCEdz2UI8rec/uhF5R2+SUIwOLoA==
Received: from MN2PR20CA0024.namprd20.prod.outlook.com (2603:10b6:208:e8::37)
 by SJ2PR12MB8719.namprd12.prod.outlook.com (2603:10b6:a03:543::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 09:49:29 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::54) by MN2PR20CA0024.outlook.office365.com
 (2603:10b6:208:e8::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Thu,
 19 Jun 2025 09:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 09:49:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 02:49:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 19 Jun
 2025 02:49:14 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 02:49:12 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next V2] xfrm: hold device only for the asynchronous decryption
Date: Thu, 19 Jun 2025 12:48:51 +0300
Message-ID: <20250619094852.6124-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|SJ2PR12MB8719:EE_
X-MS-Office365-Filtering-Correlation-Id: e704b80f-2440-4057-634a-08ddaf16958e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Wsvb2GV3+mzITc2d3O/chYsirnfj5W02qRx1tHrlc8DrhwazHJxo56FaQcu?=
 =?us-ascii?Q?OIeXewPsbdxSocEAdMJJkiXpyPm4OzfQUbxpi9oIgeqCnFn8mnYTjyc88I32?=
 =?us-ascii?Q?dyaILAhR18pIiAK1UcVhqZajDq2JzaZwINzqLoNGh6gHOINH+aZnt6T1EDWB?=
 =?us-ascii?Q?6OGPbwC/GkQOvfsxLA74Nfk59Nn6eVmMVyuIqd8+MoNBtG+/axShG3qQJcOt?=
 =?us-ascii?Q?RWEb6FAW5SQ1A6voelFQO7ZzKYDpOdBN+iEjpAKZjCyZSLjnsKnSLuBWoZzq?=
 =?us-ascii?Q?plLmyFsQctvQhLa6mjYIgm+NL678/J1HIybVtv9wZhEifXDPpxDFQAnIUFfo?=
 =?us-ascii?Q?7zj09g5rZ1aR/4Zdh85ii0XLKqvWiKHLsvf2YEthh1RN0Rb8qadrDz7Qo5Ry?=
 =?us-ascii?Q?p7Rsyg7c4LYZl+RSTTIFLoNfLWSJW/IBrHDTky/vDPlupwnsVpZ+h1Ey3438?=
 =?us-ascii?Q?rTDiVUZnoFSbm9m6Zt6zcG3v3mKfzmSZT5vqe5CozDOmwvhSdjZ5R5AqsGnt?=
 =?us-ascii?Q?aLenZ3Fsq4pt6kcnNI4e9CTIaQ80PXb2VglnI71ZZst4Kg5d7btw37nXQunU?=
 =?us-ascii?Q?xGD7yEr8tkFjIClcpeON07R/GCVI3vHry3x9axHdpnYU1dAzbtYLCPZ4MQ6O?=
 =?us-ascii?Q?9ekCPeaGTV+iGxk2PTestdJGxSNbJ7Yk6oft9eYQwZelaHMQisLYdEb+Zp4W?=
 =?us-ascii?Q?C8FrbmPUd8seMA+G2AytZgPZ0veTQ0TZZ/5X2sW6dgSSAMYa7gf1Q4UzwYRh?=
 =?us-ascii?Q?LluIytICZohX+GMQYXBLFCALdT+Gt3gz8wi2xH4omSTBp9hi1T+YC8jlCtQh?=
 =?us-ascii?Q?A3Ed/FizOCxjLHkQlQ9fqiVWi3QYxYjdNA9ZDmWc4qhyRTRUwTy8FOWRE3oq?=
 =?us-ascii?Q?YgixH1oc8qNZ+Jbk379EEOq7pJBUF9faBJrOWZkfCj6NJLxbUyeUQxc6cVYe?=
 =?us-ascii?Q?j2HrWdbFkcsHTjWva2LURo2978onuZmXtS1qznG9CkkK6yrlLdK2n5pDApxM?=
 =?us-ascii?Q?7aXoPAEtM/OMOnCupIGl7NA5PBpxPdWYYwJ6cEp/Q5+wh/b7Wb3S06DoB07p?=
 =?us-ascii?Q?0yAFmncSXGMcdtbG2V1Iv9fQZoVy1RfKsLgtJ/p9V2/0z8FoakB7xzJsvBFE?=
 =?us-ascii?Q?aeqAryQSwb61Qx7P8mbXaGxTrKH9pJZtzWIzZTHDWBPV5tCiPpkcBEe08ywH?=
 =?us-ascii?Q?FhZ9kgUVD8MX2NqTSLJgUY+TgVZ2E/onckdKqls+YVaSksowl4rX8NXBimEb?=
 =?us-ascii?Q?ZSam4ngpaQkrnvC0pmjpManbG4JcV4A3pi59GxdPYRilQTUjCiiFXLwp0E4o?=
 =?us-ascii?Q?DsrkY77vgX3LoiMePgnQxjtqyq7atGx8ABr/fhBLKUKUNRGbdNIsDwqLOxkO?=
 =?us-ascii?Q?WF/aVnWgzROsKkYeb9Xt1cb7kgGEldwDvo84xULh3qJGthRH9R9I4dwhjoGH?=
 =?us-ascii?Q?VGnFVsIgBZKIkD3XKbSkFVYzBXfcKOB7YLsjIa7JGkUhl20MUKqcV/AaNMMp?=
 =?us-ascii?Q?3y2zMy8/jXqfUvtnNW9scc55+7W3f8+u2mBI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:49:28.7626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e704b80f-2440-4057-634a-08ddaf16958e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8719

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
v1 -> v2
  - Keep dev_hold before x->type->input.
  - Move the check (nexthdr == -EINPROGRESS) into else branch.

 net/xfrm/xfrm_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 7e6a71b9d6a3..c9ddef869aa5 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -503,6 +503,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -649,18 +650,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
 			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
+
 			nexthdr = x->type->input(x, skb);
+			if (nexthdr == -EINPROGRESS)
+				return 0;
 
-		if (nexthdr == -EINPROGRESS)
-			return 0;
+			dev_put(skb->dev);
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.38.1


