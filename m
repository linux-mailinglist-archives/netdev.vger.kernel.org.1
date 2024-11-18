Return-Path: <netdev+bounces-145915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4389D14EC
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6E2284078
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906271BD9D9;
	Mon, 18 Nov 2024 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIPRfQhH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AC31BAEDC
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945708; cv=fail; b=Q4lTGlLK5NTlvrxTpfNoVccU/ZVEH0Ac9lfSKKtzVq2B6FtS64LCRDgMM2k06U+V3ytK72m2J5C6lOwnaflmxeHkB3/l+g8RrB7Qm8xbO1A5nHKM607I4Fjx9qai+soon7olWjLnc+sUvJRX15h8H8w6BmD1ioKYYVTq/gYZTAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945708; c=relaxed/simple;
	bh=1Nt5flOnIs2KdgOTK1Rn7k0fsKc+v5aIWnXwOXuXonc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oV3ItM0bRi3Lhwtq9FO17gmLPeGjM42YQlf2vgotxEiW0CDecPJQQE9wcLxqekXMpA+7bN2QNBi3VRnKAi05w11zCsgM4LG5bTb6uS26CTz32+WgoPXbGbJW4njmH20FcvGrE1pQbQXSboPsSAzFW+T3r+FjtAOloRhg2JryqgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIPRfQhH; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZVZlxItYTd7yjPX9WZXaVj3vJVs8N4Jw2OcL16U1sP5vdZSzJov7fwIEXV5v8ehqmOMpRH/wDyaw4ag5ZE4AdxbTHds8w1Iz2k6BS0rUf9E9JgT6T8HF5oajyNjK5x4+fgQYGeJt8p31JIZetO6J8Dj4afzIZejgwQxZRZILb4vhdRUVx/jzMrdJ3bUsZm6Dk469bxOwYH+HjNmdDwXRymRNNw0AAnLsYdHSFx4NPX6OATPhPbdq1bosQbpIt7DJOQA41XJKrC1g3ld9FVZgVNNzJnJSrAed5/t7ooRGEfo428uMgEuqg0R7N6UeC7oSqb96TkfevvN97xow/C8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnw53MBIUTmm6mPBugC73g+K4Z4/LqO+rap3UjyYOws=;
 b=Kp/fiu6wLzSXSWo3+1e2PEZiK4pU4aJS+IcxjfrdXRdEUtnmcOr1Ue6a8B72GcIUHtl1rm9n4qcC7YQt5bghnuVXBtdroSrOuZFQktGAmRFq/biG8uugcd6vGjavlndXjstsWKNswflJNXCFr53ZpOvvLb/U5gmN5CfBoTUd4i7diQ+nnuIAjJ63LqyLHOwBmZtaoPd/tocmTu4aLXfgdV+TwtufbX4LZQH3+Q2E7GReFdBwjWVg9NowVndce+Evr4YX8C5knZDhsrHvB68xgnPMNwSMQQFIP1My0VUkIynML6kIZpirvbvH1fDTFO5iYnTQLirW9M1FDYiIIjScLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnw53MBIUTmm6mPBugC73g+K4Z4/LqO+rap3UjyYOws=;
 b=cIPRfQhH/OUG/j8+JZkiHz2tGorWJHOZryTYLySLBtGNafTYwcIfT5J0YKBo5ejuQfJSJ1afmGas4cdb+a/Qcm1j1eDDNHBjqAc3LyMxlnAPyQQ4xD7eHYMbhHFmu86rt5quz9qMqeYwLck0cnmmd4zreY+fGoMF17rWypogFVIcZ1/8lfXI9mqwLyz56HNJdx1bHh3lSQMuDrXP0d/N2IFA6smyyoBGiC3YvynPei2P0+KO0NNCOTj8Hp3+JksmMBRsjhU/W8bz+tQ/JtOFvru4c/17Kki4b+whnx9fFEOweNVn3ZjfxGwuS7+Du2HNE02/2jrKk7MLv8v9HqmUZw==
Received: from CH2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:59::28)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:01:40 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::5b) by CH2PR03CA0018.outlook.office365.com
 (2603:10b6:610:59::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 16:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:08 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:02 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 01/11] vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
Date: Mon, 18 Nov 2024 17:43:07 +0100
Message-ID: <c890e76d13543021e20f7d5c1a3e2ebcdd677974.1731941465.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731941465.git.petrm@nvidia.com>
References: <cover.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e758830-daf5-4604-9d7f-08dd07ea48a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLUQvIcXWbbWYNVgV+99VQoOd/KgC0ayD1NyrIetYdq9ufnvC49ybUcXlyrO?=
 =?us-ascii?Q?/GcTEEo7QiCdIAKGE5xzEao460rjqPn9e/OgNpUgJZnEsxLhUSoWPFEBc0IR?=
 =?us-ascii?Q?1TIGi5I5mfeINPBbbpreyguzrXDyakaIzDsNrcYQepF5a32EcCDtWuFjOTDz?=
 =?us-ascii?Q?FumTDyR0zTZYErRq2uFyuB3iHJwEHOecRnrQWXaXp6oy+1iiCmMdhwag3RE2?=
 =?us-ascii?Q?EFbLFZf5C2fVzUB4PiPeiKAQt2q84U5dYVnLVhEYduy0OSuNH7r/Su54Xu2W?=
 =?us-ascii?Q?Z1a5nG6hxFWpcc2KXz7Bs3HASOAmCd8SigpImdYlvZPbyZpb0F4al/338sBY?=
 =?us-ascii?Q?GmXxCpB3h4AZJPdTMGiuoMDLhewJLOJ+LB5/+1i09q72MzaY/hKiJGpKqTER?=
 =?us-ascii?Q?Apzb192iGNOyu2fqNeD2S4bBr+A+kEf/deLTL7gngk+ffOZJ3HO/BZrfyebL?=
 =?us-ascii?Q?tnmRlI7iL54WH4BbJ08SyWmhw1S+0oRrj2BmGqKCg6VZGq4sPbob+NlpNG43?=
 =?us-ascii?Q?T2239EQMXLX828aJo5mrV8SlIzVCC5+AMV6b2TnOwq1gAcgCeQOJqT91RHjv?=
 =?us-ascii?Q?8i1TBxLX3VQf+5BI/tsK3+5s/+cCfwNjC5YJeRedeHOiEQ0ssM2b3KR132uW?=
 =?us-ascii?Q?kB0LgCGDWffswKlnwVJJgtnfNaURyrj8gCCsT6bJbnsYf4r+Sy2ucjtcBsxJ?=
 =?us-ascii?Q?jFTs2swvGX8djwqW0G9NSkZ3ELprGFM7sWqeTTtTIwfzDX1n9ExaCU/8yakt?=
 =?us-ascii?Q?CUpykX6fiDtA/eGxWYq0ENTfrVGujWyx63YOJ4LL1EqB2U8AYDjGO570whxE?=
 =?us-ascii?Q?TPLitGGguGYWeEgGWxFs/sFshhi9eaU+IV4Sg10/WHNX4tQ54O+7WNatN0fb?=
 =?us-ascii?Q?BEDrC7c4g4oqYwlFARI0iQpfnkAz0IM5yXR+idgiAqXw57CrCsV8FxRSvaLA?=
 =?us-ascii?Q?rB5QsgmnWXBIWlU9ChvbpcYJw+ysaUpJHvXVo6hw/+xFwr8FyoY5G8TCdyRS?=
 =?us-ascii?Q?cc0wkTSQY8zr7/jWt9ER28YmXDSjXBOFI0Wp2IDSkiGaM6UOP6mB0BaPZ4AG?=
 =?us-ascii?Q?kQt7ROfFJIg9YAcOkAlIbMw0SwIOVR6yEHEC80gzz2H+18nSYLXCg6M/gTY7?=
 =?us-ascii?Q?50+pzIlpP96S+2wGasaquk8MHcwmfHZWiKsaNfms6oshT5Nhg/LgXxZ7YxlK?=
 =?us-ascii?Q?8YIMhbmIuajfPoXzQlGA7Po0uuOb2r8fT4bMjbxXDzL0Hol5+Rg2aV/XGlAN?=
 =?us-ascii?Q?B/ZAg0GjM3IbKAHBXL84zRWndsO3zaK3NJY7N39pcDVQZFGrnAQ4EqQPaRZY?=
 =?us-ascii?Q?ZUa/F61DGB1lbyuCK0qHCuWlvevMFg+LYlXcVrPB1CgAAuYnJB8ZIvhu58XM?=
 =?us-ascii?Q?pGJyRx0FtJRAQ+rVs2QBuQ2zO7M+jKGvMqLAP6IbPhlfriE2Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:37.7339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e758830-daf5-4604-9d7f-08dd07ea48a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455

vxlan_sock.flags is constructed from vxlan_dev.cfg.flags, as the subset of
flags (named VXLAN_F_RCV_FLAGS) that is important from the point of view of
socket sharing. Attempts to reconfigure these flags during the vxlan netdev
lifetime are also bounced. It is therefore immaterial whether we access the
flags through the vxlan_dev or through the socket.

Convert the socket accesses to netdevice accesses in this separate patch to
make the conversions that take place in the following patches more obvious.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index edef32a593c3..071d82a0e9f3 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1717,7 +1717,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	/* For backwards compatibility, only allow reserved fields to be
 	 * used by VXLAN extensions if explicitly requested.
 	 */
-	if (vs->flags & VXLAN_F_GPE) {
+	if (vxlan->cfg.flags & VXLAN_F_GPE) {
 		if (!vxlan_parse_gpe_proto(&unparsed, &protocol))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
@@ -1730,8 +1730,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 	}
 
-	if (vs->flags & VXLAN_F_REMCSUM_RX) {
-		reason = vxlan_remcsum(&unparsed, skb, vs->flags);
+	if (vxlan->cfg.flags & VXLAN_F_REMCSUM_RX) {
+		reason = vxlan_remcsum(&unparsed, skb, vxlan->cfg.flags);
 		if (unlikely(reason))
 			goto drop;
 	}
@@ -1756,8 +1756,8 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		memset(md, 0, sizeof(*md));
 	}
 
-	if (vs->flags & VXLAN_F_GBP)
-		vxlan_parse_gbp_hdr(&unparsed, skb, vs->flags, md);
+	if (vxlan->cfg.flags & VXLAN_F_GBP)
+		vxlan_parse_gbp_hdr(&unparsed, skb, vxlan->cfg.flags, md);
 	/* Note that GBP and GPE can never be active together. This is
 	 * ensured in vxlan_dev_configure.
 	 */
-- 
2.47.0


