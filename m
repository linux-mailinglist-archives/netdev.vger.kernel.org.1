Return-Path: <netdev+bounces-145919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C2F9D14EF
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5349284C74
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6F01BD007;
	Mon, 18 Nov 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="meY4WFos"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00A91AF0A0
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945730; cv=fail; b=fdzfikAoZOlAhu8zUxuIIM1Yi84UuhLc2zj78bhcL/6BxJ5cWxIeRY+Ouu7OBE0wiP8gtineXW3BQo8EqjDYev1kiC928WHyeKQAaeHsex7PC3VCmMhRgQK4mcGQ/dTUQXX7/9AuEXf94cjLHCARUUO75sQ3s3dLFcOYCPN4zME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945730; c=relaxed/simple;
	bh=n0R6ny29ZLCyfiaHx7UDOoD9mhDKecWoBAvNTcEZqBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cjn+EU6GXYNb7kcS89pOckyB85Fun3so8fyRMb1UzMNJK2q0G6gvVac7z2aPL9LI6rTBJrCDlPD26mS405p7oBwf4sNP+5vIlPGnqo7onGQODY1ZyNbmx9mukseGXEOYYc5FIGd/PkJGVJDceI4RdWVbv5ZhxJMgjDA76jxSV+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=meY4WFos; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWvtpx6svDFO8jm80QHOHaMMvOaqVjV0ST7spO8vDHlIijBI+US3Sxr/HKdFfpNui+i06gDKNGzSo8ELBYj4Y2vxwSV7wKDCeRk352nRY2scxys4cY+YTZ5deZW1vU8je8kWINDx8aUTHDNcgGecIup1F+NM7GfP6LH8z7F9K4DPCOnikayJR+2NA4B7ZxF6FnXVCBFFGQdL3DxuN132sH9eyGtqeNFHhiv8D0IMlmM4HnX0rUGDCa3ShhtDZDMA18JmyoQ96oJ2ytCGnv8JZeBavvGXg3fc9pS7vtryXHHc2QZniVSK01ZUifLNUDvGmEriKFEWdkmIFr/qe1wodQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIHi01/Z+YtIIm7cT62DBMYhYScRuMQ5r6lCsqLvdPA=;
 b=bzq8A1UavoNrd4TQnrttMEa9HNwLHX5vD25FuXUSImuBx/sDyNBygeFJfMyigEY8iWyJvjaL269mutsZyurK9cXllmEdSkALn9902JPqzUMRHoaoWVqcZcLvJi0xzwIuavWwYGG9lHEFrBkntL7oJEogIjYb8J5ooBzKFHqWkdg7w/h+YZbPBgenyPAVyUg1s5A/IVHKnW3g/MBYT+yNQ8pYzfogdxXCyQ4qPD8HJr3WEgOlKdUQWrEaWdCRc5CAZhrr+0PXZNnTn5/1k2FTqv0PFXdv32aYvNQubw50Lizqgp4R3PuJoxgJ0e8hVeJhrtYCslM3Ko0yjD0MlqU9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIHi01/Z+YtIIm7cT62DBMYhYScRuMQ5r6lCsqLvdPA=;
 b=meY4WFosWvaxLcCFjXleqJA159tcdsyVcFKvySqvV5qGN1ckp8eNJKsN5lf78mYI/fT43Mag4wcO4S8BileO3B2cVBh7gUEYkW0r4DPnHnwPGbC1GuMOY9InszM5wXi4CsqX+EXDvWB1s/iQDRQ4fzCwgc8bHenA+DmwJHms11WDaS7I3XwJdRFBa/i3UvafRyPCOVxrtab7TdrwDTo76E7YXhnXmfihcAffxPbJ++lMNqrssRkbp/Y/84GGciC5XJt4XF43SQ6hjEOequA/wLKEfm9ga2N2NGP0767ltuL/SncpYEG3VrpGIZw2We4d9SjgqlCDVIEJSqWVtL+Sww==
Received: from PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::11)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 16:01:55 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::6c) by PH7P221CA0034.outlook.office365.com
 (2603:10b6:510:33c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Mon, 18 Nov 2024 16:01:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:01:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:27 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:21 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 04/11] vxlan: vxlan_rcv(): Extract vxlan_hdr(skb) to a named variable
Date: Mon, 18 Nov 2024 17:43:10 +0100
Message-ID: <f566f0ce32fc204edb4404a4c15d96f248a32b0a.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b7a089-9958-464d-344f-08dd07ea5213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?audaivTAEvOw2gZNDLT7x/aHy2gLAawGauqWiHUbh0CL4vGn1bFFXBZFCxL9?=
 =?us-ascii?Q?CwKjGGSRE4/ZfPQZXEl/euVc2G5ax5wz+in+FZ54QYCOMutLM9eG9ZMoOGEq?=
 =?us-ascii?Q?kTu5AatsR/fj6N8hyX1lF6rp2+3KImq6Y2OV/+/y8x8Yc/NRSE4106ypd0Rh?=
 =?us-ascii?Q?MisylBTPoLao31+/ewdSgueYwQxs/mvb+8btazFY6yVvo0kVzu801Jn5WM1W?=
 =?us-ascii?Q?9AUeWQlnBzCj+uREkzHeW4vcgDrrbMZV0BlMQbX+LEGksN0mPNcNpSz9HvCL?=
 =?us-ascii?Q?oPVZzQO6ycs3lhfQbNE3VDuSaHtHzoa0IHe6xmCPr3/Wd+Xuyr7HC8fWRZkO?=
 =?us-ascii?Q?NfohgMAAokRdQJnOycxa8VjeElQJeNnM+TNnzx/POQ2nePCfSZm6rwkNRMvI?=
 =?us-ascii?Q?KIGd5kwNaNOCLixhkT53r6y5kRQV+fzVDZSSscQ/8xFWml88j+miucAqMrhz?=
 =?us-ascii?Q?AKvVdkgIUTlWJMC2diPRn0wu8di407jEoc01+GM6WbvqQgWOLiFti5/xUY+T?=
 =?us-ascii?Q?Py4TFstHqc67IZXCf/z9/odo77n+z7ljyUCXUEjJ/9Xae6M0gLb6Mo2lB61A?=
 =?us-ascii?Q?z00aJs/5Jo3QQ35Yt4VGpanUhWDj+q8KXXlSdxh0vf+f2T3EvbOdh9+ZCJqc?=
 =?us-ascii?Q?Gp3NWGtNCw+rj1BTXBeNjRYZG/vrqAGUsAs50DT+sLvRiPX2cktqDUvIhy7T?=
 =?us-ascii?Q?DsXF8VBKsKHoHjdxqswQvjm7rmwQSp1oeRwgwsyogQg5L+HzyD601FLMIEjn?=
 =?us-ascii?Q?PJ5HwonmZRIKupkq2gowIH4GQC/NurEhUoo2SzhYFs7i0MiUsThoJyD6T8rG?=
 =?us-ascii?Q?ES1yXoG+PNcci3ThNtqN9uUNvTcYg39YYwjSSgqpazbjNv6jNJZBUOXnWqpM?=
 =?us-ascii?Q?6D2mN1gKaAiEt1BOyy6+bdTxGGH4tiCwtG3sy8GiJBh7w/9/1o++vxr4wge1?=
 =?us-ascii?Q?1hwraJo+5BQe9ROiBrgF/2NudfSjxw9j8CqPW+TYYOfu0X4ekpI/O1lu4IFj?=
 =?us-ascii?Q?v4m+X3uEP8W5dhBOEPD/8B6jJ7X1vrd1zPu0aBq028pT/W+UTdfG46NowpIn?=
 =?us-ascii?Q?IigbqRRKu+HlOnWSYvLG7spX2Qb+CnVnz/XW0jfFd5ouc3CLpk/LtDwWb1LT?=
 =?us-ascii?Q?Z32pvnq0U/2J8vcY/6HgRk0amqz9rAWz/J0U7I8ByTq6Q0KHAiFTMTYZC8tj?=
 =?us-ascii?Q?4Y2kwD25Bb+8zbB4vUMOBlkgG7ToUNKYVM7c7fttrmG40xS9d3+aoEZoVtyq?=
 =?us-ascii?Q?kwVHs7SSvsmlPeFTKuF2+2LLDizeIYpjTZ7kCnD3n6ou5rbCt/3zN7FW+7E8?=
 =?us-ascii?Q?YEGAWyOmy5mzuacD8G3wicLz/g0CWtCHfL+Nm2TakzjDZkLdXA6Dw1BDMrQ+?=
 =?us-ascii?Q?OQ+eoz/qEL3WaRh1ZMghAKjbkIZkhjLzztBNAqdXe1h9DUgrPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:01:53.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b7a089-9958-464d-344f-08dd07ea5213
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

Having a named reference to the VXLAN header is more handy than having to
conjure it anew through vevery xlan_hdr() on use. Add a new variable and
convert several open-coded sites.

Additionally, convert one "unparsed" use to the new variable as well. Thus
the only "unparsed" uses that remain are the flag-clearing and the header
validity check at the end.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 835dbe8d6ec0..95d6b438cb7a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1667,6 +1667,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
+	const struct vxlanhdr *vh;
 	struct vxlan_dev *vxlan;
 	struct vxlan_sock *vs;
 	struct vxlanhdr unparsed;
@@ -1685,11 +1686,11 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		goto drop;
 
 	unparsed = *vxlan_hdr(skb);
+	vh = vxlan_hdr(skb);
 	/* VNI flag always required to be set */
-	if (!(unparsed.vx_flags & VXLAN_HF_VNI)) {
+	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
-			   ntohl(vxlan_hdr(skb)->vx_flags),
-			   ntohl(vxlan_hdr(skb)->vx_vni));
+			   ntohl(vh->vx_flags), ntohl(vh->vx_vni));
 		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
@@ -1701,7 +1702,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (!vs)
 		goto drop;
 
-	vni = vxlan_vni(vxlan_hdr(skb)->vx_vni);
+	vni = vxlan_vni(vh->vx_vni);
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
 	if (!vxlan) {
@@ -1713,7 +1714,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	 * used by VXLAN extensions if explicitly requested.
 	 */
 	if (vxlan->cfg.flags & VXLAN_F_GPE) {
-		if (!vxlan_parse_gpe_proto(vxlan_hdr(skb), &protocol))
+		if (!vxlan_parse_gpe_proto(vh, &protocol))
 			goto drop;
 		unparsed.vx_flags &= ~VXLAN_GPE_USED_BITS;
 		raw_proto = true;
-- 
2.47.0


