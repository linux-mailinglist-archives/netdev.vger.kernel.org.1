Return-Path: <netdev+bounces-232332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C9C04256
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 04:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF6F1A683E0
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 02:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21125C816;
	Fri, 24 Oct 2025 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBekj0Iv"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E602F25F988
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 02:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273610; cv=fail; b=fFWE6AEbdRIm/MeJmXP18GTYaZATFsSxGbZThuXqj5bXV5zVM2dNvpdixDwowfZPnqc+Wc66xKX9Uy3EV9N4VkvVg5PIta47gnz8eUS0BfcEnVeaEqbKAJJjjC0YSz1cGncclk4BzvRr0N3IoDRC0RGZjQBthiNO6Zzr1zfVoAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273610; c=relaxed/simple;
	bh=osG3lSugrD1KIvdXlj5rgty4Suu5KKr7Rs8zYAFE+Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEdpWUagnPQNXKg5I0ZpbUMwUDgaigm5nRnnlPI1xFBRjCLXUcV+JNzPwauUUrKGsJbD4VZ/ObNbQ9K10tNmp3hbRYiBpJTKX+frMZiHGoIKiQU+9+Y7C+7fACyZDERbqGyhEbLCp1Xhcoci9jyq5bJ/7UppZYo/WkBobZzFoXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MBekj0Iv; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D680NNo46SocfThsgMU/HRNofX19n3iEV4HmLpdNs6M4dhWEu29bVAoNpU/PKFsktrPRR4H9e0KSnoLArHTq3EweHQR7zMV+fXjnmO2TnZQrtvKILPGK3XfZuRWSOCMsBW2vfP9CsysVWtg3O44aJ3jYGzn5RUdQL/FTSeISzso9cJVmOq1zQ/8M+pkd0jP+Riif/Fwr1VFsEhYgbC8tsgmogdEAaO++j2xHntJs6mZeGjXfuegx54xB1I22XLedNXGcq+IzccXfFR+3ge1E3PXOURSQns9+FTeMDNfVpoKWL5gxzkOWqAsyqjLjJ008E/5wHomIWOkh1HWfQcuUPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/PxOvVZxCtIaCE5dPTviee072C7UVAN81w+s795fwk=;
 b=p7pytLJr2ZfIrvNNXw04fwd/b+RpeR2AJWL3fSC1DZP98edMgH20G3aA+3cgUQkSF3Q+EueUc+CQexBEiAjN7UGYITD5PHV0vvAeGJnF1pBLrMspRaActDnTL2qeHtzxp4BiN2323+6YBjy/QUwZgHJiLl4hCxm080mOhcRPrJoS5habT/Il9sDZDsmga1RoqiLOj6OZOjvqCF6PDt636gJDsroCM+B7ehALSM4FY3JzKt0szOGCYhFzXE4WSk0kzduGuh0p9DTQws+f1+b+/TMfclXTTFe6zDGQqv8Nqkc7rtJAEml0YZHs3i36s10k91Kb2mwnqxFf1bFMAV4DQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/PxOvVZxCtIaCE5dPTviee072C7UVAN81w+s795fwk=;
 b=MBekj0IvmpBdJD31UnXO7FF8xvMqFRNrtAoQdYtXGMl+CCWh5t39oby0FJtoug8go36hRg7+X3eAiZMtGj2oOc1Q1QPAJIsm8Wx7OPPf6Cq8IFAOCk7ocKx2EW3WhnCTIBbF8OAcrOmMLMfbnw/V+RmoPGJKcJWnMqaUc7QuG8LzC6IXftv+Rx3sDqGgzTEXsgAGN/ObjeVccJ9/N1UNRKXiQkFh3OmM3c26REpZsJLEz7+8b/vXBaha4Y2LQF5BbSlfzmGScPbbVEDWgyZDpcsHHaC6d/323pHB/XrAtrRlZ3opByyzCkLqON8H7ijojaEBR/GpadjkyXn99nzjgw==
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by IA1PR12MB6553.namprd12.prod.outlook.com (2603:10b6:208:3a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:40:01 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::d8) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Fri,
 24 Oct 2025 02:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 02:40:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 23 Oct
 2025 19:39:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Oct 2025 19:39:47 -0700
Received: from mtl-vdi-603.wap.labs.mlnx (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 19:39:45 -0700
From: Jianbo Liu <jianbol@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<steffen.klassert@secunet.com>
CC: Jianbo Liu <jianbol@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"Herbert Xu" <herbert@gondor.apana.org.au>, Eric Dumazet
	<edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
Subject: [PATCH net-next 2/3] xfrm: Check inner packet family directly from skb_dst
Date: Fri, 24 Oct 2025 05:31:36 +0300
Message-ID: <20251024023931.65002-3-jianbol@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|IA1PR12MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 27797767-5e33-4248-8217-08de12a6a19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sy72nmqiZbf162kVCARigkhcC5E5xLtN+xlZNe/gNP1C1aD/lc4vjV6bfXYA?=
 =?us-ascii?Q?Siqu7iF+0CGQuK9UvqAWQJGZ4NEIBrF6rfpV7+fgLylc/fkpOd42Zh+KI7Ft?=
 =?us-ascii?Q?8/swlz6aenLcs4fSxOTebN1Z568TDXm4dzv2iWCfDOdtxMnsxRDaXatH+6Jn?=
 =?us-ascii?Q?FOl/aGLpmUiDuY7PP6jgv5vXarJNZkVLZrCeSKiaK9QOZC9/5WPvY31myn7A?=
 =?us-ascii?Q?J9OkbdZgS81XC43TlaUrj+Q3xxWMLsz3+DF1lUlWY294LnyGSP0kEHs3vWyY?=
 =?us-ascii?Q?cCYd+5Ma9jbYjQ1wt2VhrXAMhwUBAyj3FBaxNoAeYTEn5Wrs2/oLtUzwWzEt?=
 =?us-ascii?Q?MZIbr18hDJkxrhP/ZupKbNTb2nakX55idatpnGbvKNbZt57VsvxaWXqRzgei?=
 =?us-ascii?Q?gRy+LIDClaOy+Gij+jdl1vfux3OOq/tncvRMd5v15yDGENV3bMWK1ujcCLyl?=
 =?us-ascii?Q?tcBwnqBuV50Ued4rDa266YdkC1MTwJs1eE73NRsWrx55gu6MGGw8oDiazbYm?=
 =?us-ascii?Q?ij74LUO8ZFCctPbWP7Z/b1Y4Yvq0ywwjCccexcsbbz1BdIxZpkAcLG4Ja93H?=
 =?us-ascii?Q?nvxxDywdvP1lhyzmUKToapFeb0ibKOll8p0SkeLg54QuMkv2e515EYe+zLqb?=
 =?us-ascii?Q?U5Lcq/CkjJ24DPtPdeM06jTwUK66N4PkKchLYestjQ2mt3K/56I2FCiEQJRl?=
 =?us-ascii?Q?D3HQq/58Eq7NgdW81BJXrDvQNdRqMH7xiprj8RMAHLQ5jxIAG4I4JgzKfD7p?=
 =?us-ascii?Q?H9WkkGkddwSPPwd9roQt4QYTQq7k0+HbM4ZKZIIHQimll9QH4yQ+bNqySbb5?=
 =?us-ascii?Q?zOCLr5bkjJIwz3C7FOw0Rh+UfM+wdg1wxae43yeOOKJ5SviRIQqqPq1KKyqj?=
 =?us-ascii?Q?CKT9zVDnWT8sq0Vx24WyApehIQlexr091l7HjTDDlbbFNvJ+H8gWacf92lNu?=
 =?us-ascii?Q?J1XKuaOK+QxeQvRsLjGCI2bJjNn60BB6nnVZMR8c6bvfrslrjhmwkNfw9M+4?=
 =?us-ascii?Q?2wI0IAEMJfrs9OV5I3PovJG3iZwmqVxic9I1W7Yu/ej1GOZscPKxo94XQF4S?=
 =?us-ascii?Q?paGjfkUiY66LNg6oWPM3UpN/mu7M00PhsxHKsK0W5dp6E4taaBo9Wwi6qefk?=
 =?us-ascii?Q?kX58eMhm5aIsGCHafi5/dfNK5H2EiDCJ/lG7ssESkqznrb/RXG8CFC1b1WTs?=
 =?us-ascii?Q?YY+K+XnucOs/m80XOag71v8ckK1y/Az9Gq39YfWVW5ebRUP1G04MTgJLNYCJ?=
 =?us-ascii?Q?boSV2zzP1IfeIXQ5eSFUMQ683nQqN0S/8u3UpdUr9OYk0/NcRU9LQCJX9jTg?=
 =?us-ascii?Q?lXOjrwA9jQTK/VAEnmU6V4SYezByM2QiInXCEhN0L/WPg8CMMoG2qeX/0eMB?=
 =?us-ascii?Q?6GRt20/LKEbrG9AW2zlzzJ1u0G9L1dTY9U0DYmalnGy5WaN4kpRL7MadsrjX?=
 =?us-ascii?Q?04+fccTJC9pfPalUe5b25y9XNGcOWQiLdPgQ1eT96T+L7qYiwvP7xTSJTgTm?=
 =?us-ascii?Q?feaXs4lLG3mg6383YEABt4+fym4dZcEDWxQEld8qNo7oIuYUtYbARe6Yw68t?=
 =?us-ascii?Q?kCZv1izC8EIOY8lHn9A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:40:01.6483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27797767-5e33-4248-8217-08de12a6a19b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6553

In the output path, xfrm_dev_offload_ok and xfrm_get_inner_ipproto
need to determine the protocol family of the inner packet (skb) before
it gets encapsulated.

In xfrm_dev_offload_ok, the code checked x->inner_mode.family. This is
incorrect because the state's true inner family might be specified in
x->inner_mode_iaf.family (e.g., for tunnel mode).

In xfrm_get_inner_ipproto, the code checked x->outer_mode.family. This
is also incorrect for tunnel mode, as the inner packet's family can be
different from the outer header's family.

At both of these call sites, the skb variable holds the original inner
packet. The most direct and reliable source of truth for its protocol
family is its destination entry. This patch fixes the issue by using
skb_dst(skb)->ops->family to ensure protocol-specific headers are only
accessed for the correct packet type.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
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


