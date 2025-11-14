Return-Path: <netdev+bounces-238575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E7AC5B41C
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 04:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43B3F4E039A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 03:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD9C26F2A0;
	Fri, 14 Nov 2025 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XT8ekLg9"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932B270541
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763092748; cv=fail; b=DTJ/UokDFz+2tIS+dgWL/Y3IJ2G0nfkqqnss+YHDVJiOV8Sw+DjB5UySwn+SecHaw9cBmP8I6YjMekL2I1ZQbOLF2jHpubLZpQYarW8eygwfyHR8QUAKmYlHtRqZPMqpKeWlqVORYBhft3Wy9Jsb9fTu9iZ/nAGVqK0Fb1X/2wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763092748; c=relaxed/simple;
	bh=0EPrSYeLDHWi13lA1FIa2q+3adlJJMDOfwVdWUKJpqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1jV55Iu5rITgVLYZtINatoSx3+gb+tSxMXmdyWtt9FjcfeDomInGuSSTboZnkA4fIOj83G6B3fmp4bzt1ROrSFhy1Svk6JsC916sXHQ+lFlYrvGerPbjmDGMdim+4FhS5b/Neu8fjJhrXQDpUyY/vjVAk7HHKZ5UjtnnlZcMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XT8ekLg9; arc=fail smtp.client-ip=40.93.198.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4KZh5jBTwfBl6fHIEjkk//EysAm5CiWdV4ahji8I+w7GPKsf0pQHRW+ZkKohcXn8L9nyoneMKuS1lIq7F6Zwu95eeLUBXu0epjs90h5fXdxFeBztB+yPoX8Nz7FkSO3DwU3W65mI4yFiaWR5lOYIJRUGYMUX7lUEQFN2mGJUjnx0D2xfh5z+wTTxa4OdVYZvsNf9aKVezYt+2T8zsDZf1nSBtalmTC08YQeOGEK5MpFFj6up1PcKmjqxCwp1yN/UgicNQ1DdYCxnM6GD6MUhRm1HWrcgG2FhlOBT59R/weqHjiiYiNan8IktIn9i9oLD/F0yhYx3toK8oMGbxtNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4yTSraXOJmZP+DpQeJgH+aU8dnEEMTojbiN1x9Affxw=;
 b=PgQoYKIo02rYU0B6z0pbr+TYijUUPodFGeW2p5K9w2t9F4j4o9euYT3jqLT/AaYUWvLyWyZuIDi3Tr2UGu1ljUChdQDmnQ0+clsDjGeuA8Fz13YxhZwSDjBRRijf1+l9YftPM+dO5pTGVoCatE1aqJLaAnjcjL6T+ZqHFvyVpz/CuB+M3HWxtEiZ9GtipbYw9fFpdW2itnJIKasmjnLvLINtthefa3wksptkPaX6XmcC1bxToIXh0wwaLgYtIzZ1CobFjrmQXNEIoHehkAT/gFpmUF8uaowsLGq8lY56tZtwqEyjykssurPfWC4OkKj9Fg7on4Xlu1U/cxwdohrt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4yTSraXOJmZP+DpQeJgH+aU8dnEEMTojbiN1x9Affxw=;
 b=XT8ekLg9sD3wzCUG0F8CexEwck+h1h8FqLErT76UcB3HPY3DYCcImvxMc132ERnm68S8aT1FUEmyZimAj+KRMQXoj5ECnpodAiKhgIchEVB76vE0dbtSIn1sv1qdoE7at4wZY9/0RwEfQOVDk4L3qlppcaPY68I1xlQ0ITJ5GMtuJBbrw/jGMVkz5Yy+Cswv34g/nJ3iQvzYlrheqYizl+F1lXB5GqXPIhypwaFSXLEKcRt/V9X8tb63o+L0AoIYPIJ5Xd3d9Jb6G7BT1FGB5dwJN7/LVbbCwuhkq6d2/JaKdZ7h6za2FdLd3ZaeDjBzadlKO8qhjHc10fNDG5mlnw==
Received: from MW4PR03CA0244.namprd03.prod.outlook.com (2603:10b6:303:b4::9)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 03:59:00 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::f6) by MW4PR03CA0244.outlook.office365.com
 (2603:10b6:303:b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Fri,
 14 Nov 2025 03:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 03:59:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 19:58:46 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 19:58:45 -0800
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 19:58:42 -0800
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Sabrina Dubroca
	<sd@queasysnail.net>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH ipsec] xfrm: Fix inner mode lookup in tunnel mode GSO segmentation
Date: Fri, 14 Nov 2025 05:56:17 +0200
Message-ID: <20251114035824.22293-1-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 409892f9-44c2-494b-e0d2-08de233224ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jbLMj9IQGd1JxsgmSBFkjW8xzo8ATn6vBVr0RFVycagwhKQfP/1EWoWkKqSU?=
 =?us-ascii?Q?PMi3/HEpzt8mbB5UOAEajq5KHKHpqrxTk97BLEOYkUFYk5OLce/fcn+ssBVp?=
 =?us-ascii?Q?aBGscePQHTcfUClrMIlpHmij3lLuUuNkDATHX4ocMKTRifRerT1vkyCuPLHF?=
 =?us-ascii?Q?Xg3nEjIQbAxRocrRrgKxgY2O1u6zOzHqq8OF2LpSVNX+uGlfAPSirke2n0D7?=
 =?us-ascii?Q?c73lL9zu8g47pFerACDjWq262P4FENUOlqVXSoa8oxKzHHaByphtd7GZz23v?=
 =?us-ascii?Q?ANSmTuEJd6t/gA4SFqIlIYduNwidv/0ZWGzF30nwAXQHdygqjsZ/SU/nUlM7?=
 =?us-ascii?Q?p6OQRS5kzVIotqQjBLAtnkT96SCdFl++r2LiGVF1Ps8EpwCAAfoafn615SuL?=
 =?us-ascii?Q?K9bW/I6oCFKdZhzOV/wi7UWrRz97A0/LeTnVXecqx/nzBUcJXj5mlwOmUKqG?=
 =?us-ascii?Q?BlTaVBQUolxH8Py1BlU63s0eiBnpqINWkKASczlGxFPEdKqcOhcwXq75Ld3e?=
 =?us-ascii?Q?3OF1PJgOGag7WI6e5TgEOkm5O6gZOCKmc2WKpEQSEyTHAj1KuE7Azl1RBrMK?=
 =?us-ascii?Q?YWefWqQCBNh5flkNojq+A30pWpkpImH1jK1kTo3mu6zEvt/IIVmSxMDd0HF6?=
 =?us-ascii?Q?x5r3233Yv1p1Qpo8QtfngsiThqzo2b78wpsNLtcMNxkND2qz2bod56puZo0s?=
 =?us-ascii?Q?f9NEuxmq0haDkDa3htZ3HhUvuCk9P4hxy1HYJu8y3EORUS5QWUA0XlSduBcD?=
 =?us-ascii?Q?e4MV1MgG4p6DiAhBPY69B6CxrHPDgu2OA61ydAAR1S1jbeqY+GTuXw9+fcbA?=
 =?us-ascii?Q?lPC8CXAWjzTRj/Lz9jw0NJDVrT8EwY66jvbaJHZAf3x4beBdY0+F1WOCE82+?=
 =?us-ascii?Q?A/sMDfMq7FaGZaxcAuZSaI7SjWpfxMP2ohHsNxOg74sIcRQtghrQFk57NI6R?=
 =?us-ascii?Q?iIFD32q0/je5bvEZO4ENnAYm4+ydCj3fOtlCi99c0PNGuDtk/fr+SI/LlpE3?=
 =?us-ascii?Q?jAWCeuP0oIGSAwxOTvD9HxFfjdz8vH0tRXfl9CwljU2iurFvP0N/mmf8Uv1o?=
 =?us-ascii?Q?K/8IOFpbH/Ln5eMWMvAAmOZMSLrETZuTmHGwS0+kXAgvCypfx03cyiF6Z5Zi?=
 =?us-ascii?Q?sN5vTL10bjPbwahVND383JNIk0UP1t9cK6CvbrnqBxz1hhIgvL2+oPt4LyhV?=
 =?us-ascii?Q?kdxYvAOE03bjE3OQtBY0CqGDWsV3ye1RpHyWeerCS8xCdPNc994ImAzI/iSX?=
 =?us-ascii?Q?i6E+Nw+db4nW8JOM10Yrpx9fbjzpKLALvDSPFcYhg7dGuRD7i2LjRsr5LQD9?=
 =?us-ascii?Q?pnkGIu4dyA4stM3TUnvpGcIad8UVYrcF6zAr23oE0bxr/JiwHWPHGFVDQ/Ko?=
 =?us-ascii?Q?9M1y2Unnlbv0y4pJluEl6yaJ3cy/VBJUl2LIyrAm4AUbggZZic6sL2b+W2KX?=
 =?us-ascii?Q?Pe0dgOqnPjmSeXDgUvNsbfsoHZttTE7e6iTb4ixJ1QpRqmU6es51RJAMXa3V?=
 =?us-ascii?Q?qg26rj+KXoCY4zyi00SwZuYxdYRTQsRkl8NIIjCFARQ02vos241+bkJRbD74?=
 =?us-ascii?Q?87r9IsQUyMQ8GaudwU0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 03:59:00.3448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 409892f9-44c2-494b-e0d2-08de233224ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473

Commit 61fafbee6cfe ("xfrm: Determine inner GSO type from packet
inner protocol") attempted to fix GSO segmentation by reading the
inner protocol from XFRM_MODE_SKB_CB(skb)->protocol. This was
incorrect as the XFRM_MODE_SKB_CB(skb)->protocol field is not assigned
a value in this code path and led to selecting the wrong inner mode.

The correct value is in xfrm_offload(skb)->proto, which is set from
the outer tunnel header's protocol field by esp[4|6]_gso_encap(). It
is initialized by xfrm[4|6]_tunnel_encap_add() to either IPPROTO_IPIP
or IPPROTO_IPV6, using xfrm_af2proto() and correctly reflects the
inner packet's address family.

Fixes: 61fafbee6cfe ("xfrm: Determine inner GSO type from packet inner protocol")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
---
 net/ipv4/esp4_offload.c | 4 ++--
 net/ipv6/esp6_offload.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 05828d4cb6cd..abd77162f5e7 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -122,8 +122,8 @@ static struct sk_buff *xfrm4_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET6 ? htons(ETH_P_IPV6)
 						     : htons(ETH_P_IP);
 
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22410243ebe8..22895521a57d 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -158,8 +158,8 @@ static struct sk_buff *xfrm6_tunnel_gso_segment(struct xfrm_state *x,
 						struct sk_buff *skb,
 						netdev_features_t features)
 {
-	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x,
-					XFRM_MODE_SKB_CB(skb)->protocol);
+	struct xfrm_offload *xo = xfrm_offload(skb);
+	const struct xfrm_mode *inner_mode = xfrm_ip2inner_mode(x, xo->proto);
 	__be16 type = inner_mode->family == AF_INET ? htons(ETH_P_IP)
 						    : htons(ETH_P_IPV6);
 
-- 
2.49.0


