Return-Path: <netdev+bounces-233392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A2C12AA4
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CDA2402EBC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 02:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED8226058D;
	Tue, 28 Oct 2025 02:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RRShpj2Q"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120719DF4D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761618643; cv=fail; b=KFj4Np4ww8PNGnNpb9HT17QVtX9ZqPtwrlPw3TtTLiHWjJ3nwc8fGzYD+IoaO0OH9uyBYU9X8b83G7xHGWCq32tMI9xhmb9S2WHI3BZ/N7mYXbcQ36Lcpm8RVOO5HVVx8qrnXyF2G4PDeJajjpRmmG4E+6KP/VjdJ2+xIQ6l1XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761618643; c=relaxed/simple;
	bh=Xy6AaNba5rDr/pAX1VmEqEtdK1qOR+SXZR3wPFLnsrw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OE37x5BmcuAz68kT/843jHEFyxwRwDKvAdJNFT1c3ViREueOv/j0oZd/b0bM+h4X3CqZ3o+Pf3Br87zhl+GRV/NkJsvSYnSEPguBaJ4UqkQV2vmMLjsvak+AwOJ4GswBs+cyKvKDHecNP5SGXfkQjGe60ouBKE6+IKI72dT0Skc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RRShpj2Q; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIBMtViZWV+RBqqan5cxQiPJHzQc0mxjIBjriTfTnlXHjTO4ePd66Z9FdjyKXOvm8PrIbifljL3yV+OBwuHsmLPcImQSqE3vChfQzHhPg7bQb+ZQnnnr+6Swg44sXLoRhyZjtsNG8a6yzKgcveRJSyAoxL0hJL2mgvm4DK1UsqUejBcAW7byCpMK/eBjPTsYcylGYrUjhBKhN8ZaTzjDj4DG5ixRggzjUkX5mJz4lttQVQyrwU5xHFHmcDuEugIZRzFLxCnbYnF9C+IxoSN0DoD3f6awMvSwLmEJh9nVJtLsQaB/iEb1iEJDdoa8boOasYG3BACu53otgvWnSftnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/m5mn7Pin0OLqLTAJ1v7Cqq7t3NVRqeZv7L8s3MNOc=;
 b=JwXsvR0Egspbf4udqlemfE8Ej3eANilzmNQWxI7Ro0kgyTqoz1NIBp9crHWLGHqo5mNLV95F+zZucsbPDGj60LBYKMqJXFsjU6iD8WyOqGNXlv0uQPM+/q7RjgWikt4lv/jC9Z1edVUbHYIfHSWkX/6HCqLCEqkusTIWkRiUAb+q/TMZ0+z2OzxEjzGquxy1t5QzQnvQ4teGC3jGteI7I0uiPpVjCy7YMFw3ALSH62DozvMm/oNx8qidCqtFP3iQdIVleJAqiyka8m+9OJbeVDd6eUVkwWcI0uZo5b6RJeGqTcRUw+zJdxMKBIaCF+dnusP3IbjZXZpzuoTtD94HLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/m5mn7Pin0OLqLTAJ1v7Cqq7t3NVRqeZv7L8s3MNOc=;
 b=RRShpj2QBtLkNC5dfu7Jr3EjkQn2mCe1wU4XrGIc+8acn8MwIJXKsdT/pxNnCTV9Tzqwm3zY/rtaqy/7TElEqhijg4SY3Dh//oMo1yPtZJjebZP5S7YJ4RPWICbrk6ydMzxa7vJyM3VZYgb3GtMrh1i85auEflGsKi2J+DoiB5WRs27KjdxemMhtYqSUhG3wPpYGYnlOCKAVMYGo/f5wQrHZpX2CGqaCl7KOEeW1ih60n2rzkxJPdmIJvINpEHhgN1qDzTegZ0Mv8s4c3lclYBOs6aT5mCZVisPycmRv9cCLfZbaND6R8+3bBAziLbr7xfAHZNzbiWO4U6be+w9yTA==
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by IA4PR12MB9834.namprd12.prod.outlook.com (2603:10b6:208:5d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 02:30:38 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::f) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.17 via Frontend Transport; Tue,
 28 Oct 2025 02:30:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 02:30:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 27 Oct
 2025 19:30:24 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 27 Oct 2025 19:30:23 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 27 Oct 2025 19:30:20 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>, <sd@queasysnail.net>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>, Leon Romanovsky
	<leon@kernel.org>, Raed Salem <raeds@nvidia.com>
Subject: [PATCH ipsec v3 1/2] xfrm: Check inner packet family directly from skb_dst
Date: Tue, 28 Oct 2025 04:22:47 +0200
Message-ID: <20251028023013.9836-2-jianbol@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251028023013.9836-1-jianbol@nvidia.com>
References: <20251028023013.9836-1-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA4PR12MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 6806615b-ea9a-4d53-83b8-08de15c9faf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4/kz+wQdW4xz/gfFJIZBnKsZtedF7d0UD+PAQ+G4HtqVCZhDzcNOwfvRqabA?=
 =?us-ascii?Q?WERCTW9gS1zF3BmO3h5EncrHa7TfNlZMfqjMcRSRyiDa8V8Rm+h7Dv3oeA5k?=
 =?us-ascii?Q?GVcfe0VB2QU+SwCONPKtF1MSOiykQs9gNXTybnkwMkRd1NVXr1LJSxylQeOb?=
 =?us-ascii?Q?xSB1oClnnXKf7dO/2RDR1LOZFwaYhGsJL4THEaiXxpnuHr4loWnT3LSmn39V?=
 =?us-ascii?Q?EIydpltujWu0Ovpw36KmAfLAEbX87vNjchA9kM6ILLX1QPZACGPst1HDW3Mz?=
 =?us-ascii?Q?fANArataP30ZWFx2u7cbJxsR04wZ9QcMJOsc5SVgittNRYdsksDZcPqNViab?=
 =?us-ascii?Q?l6j5QG793w3PRgBM2jL/K2hYDnGQ+ThbKfQKm70vTpRuV1x+DgR/e2nEQkLc?=
 =?us-ascii?Q?UGet1sK45Mk8J0/QtSaZF2fAOGr8QOzrU94uu7WiZf7/JX23u4iUJqcv/olX?=
 =?us-ascii?Q?a6Z36rfeSMj1+xLGX3560uXt1u6tdfIZxfBSRGjhu/k8DqvbMQndj+fGBn7R?=
 =?us-ascii?Q?F6ftRTock6B2C344imnkM/a1dPzfQZGaokvqqehDao6uJIIaHynPkwGqgZGJ?=
 =?us-ascii?Q?97vqeuakyaftPkV0bIPwKOuEkRWDqkqtXqJ0GwSIzkwdJhV+UPCrN+rA3GjG?=
 =?us-ascii?Q?v3go+AXXgjUVwNTtw9pA2wyQzc5Hpj0ZlAaHnZLb2x4MKJC/h8SzD1Ou03nd?=
 =?us-ascii?Q?FFTkPRyedyHFeki7jheV8UihJ4VBdrubu+La29Ki/8JGZMnAv8Ed7L8gzOx6?=
 =?us-ascii?Q?17wDeQT0AgyUIhgj9f16e7GYu8WDrTEteu3I5gwVn2Xbm96NQjqCcNRv1XvJ?=
 =?us-ascii?Q?1R7EzbArq8ACRvzVLDhSic1UO/lvWHeyNf0TaXZwfexe3fzd0P2klkaoYNI5?=
 =?us-ascii?Q?tJ6pPyGZ1h+MfX9MRAixgHfwP+/lUIwvievApN3gUIisFKhRJilbITjEeayw?=
 =?us-ascii?Q?hEd3DUsTN8oMAN+SbcSUm7CqdDamLHgsllxAc6WtX3XGVYDKps/UUVVG3PMQ?=
 =?us-ascii?Q?Vx1DIRzXhhA+LQg6WQzsd2bwvUnpcSS9K9HDTE9Z7eK3E/5UcyS/KDOWw2YY?=
 =?us-ascii?Q?sAgBzjEdO9JxOCM7IvX4W2pG+DoJmiCCyjEJ+egfbOzJJfHsevGYJK1zQjlZ?=
 =?us-ascii?Q?S/MnkGYrztqDwrc7klqDFFii1nrZYYs9dNUxg0CVQqGHA+VhhHjUnXsJtzV+?=
 =?us-ascii?Q?JezJtjPRrJJ2Cravl3kw/R3BnE9CBSAPMP6iqYAVyBllokdK3O9fDU1xe7GY?=
 =?us-ascii?Q?DZ7CWhzcJ4JzNIFwS5o1ApZSpuk7lpOUO/WmEyYb5cOH0LWc3/shnyxH3qaP?=
 =?us-ascii?Q?e9msDWKSmih+J8ApgkZJRzXUtm4xv/O2hdqD2rfaS+PJecubsZULZvOlYWw/?=
 =?us-ascii?Q?xX7OL/mkyo4U5hCtaL3bdY1t8ndHJjHcd2Q0CyiSchW5ubgX+fsd2bfUJ2B7?=
 =?us-ascii?Q?ZuGPqcXXUrREFHRiaTKATxhHKEmgswsNvEtusxNeC+BzaLf60fRwo44oxH21?=
 =?us-ascii?Q?Yflm+86Germ7RD5w51J9/x0OaAg0NmT3VF6DsjWAgbsfywUYP12c5EKmpmc5?=
 =?us-ascii?Q?QmZl0c42j2IrnYJriVI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:30:37.5693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6806615b-ea9a-4d53-83b8-08de15c9faf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9834

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


