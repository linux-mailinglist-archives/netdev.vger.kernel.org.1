Return-Path: <netdev+bounces-148516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D369E2376
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2F2EB45E51
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160B1F666B;
	Tue,  3 Dec 2024 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a36W5TtZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB01F473A
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236409; cv=fail; b=j28wK16Rc24a9Fy/tC4m3DwVwDIcgqIN6hiXqNgQ97zfcEH3rRoFqWraKQ/WcITJk4sXwgXjEN8c/gdiqrXa11kY8DnMvcXY0Yj2REJ4oMRr487UCCL1j0sP1Vy6j3cR/qiXW1QywO7JSW1nT37dADTysaik3E9BeiMLtWGL0w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236409; c=relaxed/simple;
	bh=gVD042tNwq8oKLWlK3ZioRMSmv5DowCb7/1j5JxG8uM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7+WwMSr2oC9jjrpi55+FknRg59GuGbz6uYn+YYuttIGQAc+6JV7Zcm41UAi6Jx7E3TCCSbkYzQGCfulqP9oQEr6CRetd+S09sxPsUawo+UyooXjmowg7UjC682cevWuCBjXhXlfMrMGjrDrLPQw5uwUSS9qGZx4K4yGsAq070U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a36W5TtZ; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7b8JhfGOom6XICoDEZBPiLAKKsiD9MlSVwjHi1sgMgCPLTyli8rlWA/GwDc9o0UXcLmrN51iw1ROX3QciBaOvxVk5o8Ix1DMZovbT3Unc6JJMykR8y3oo5q1e7yYFUX16LkcBNTpLsgSF33lpOV6jhMcmzR1yB3XFgVsROIrZe7BCPmIv94EYnTiRQv/K7+hBVZuzgmKt+ZkQ+Pltss6nsc3LHshc3pQVe6Aox6vJe54VFXmY7S6ZN5syQmcIeKXGdp2QybL9Nqk5uV1+ZcLdyAAjX4DlZMnH1ojf4sezp9ILa0koJGJPkjo7H4XIKnDKDFW3ikwxaabtwrxZrROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTITGDel/3gDf5ViIed9lSwMnl3wRcq6dSwfN1tseBA=;
 b=StOEHlUhTTU/OELkE043vGSdI1sucnZMm1xKggzFEHqmZ2flF84tUgihEecPi39z/RSzIkrx2QnaKQnyRwLSfzFIaZUiNZQeuc92poRncg5EFlLT5V9LHyKiNZSl00SMhyVKKNzyk/KPGtyCbEqooRnEi0qg9Bo4aTjjdzJuqyQLreCOno8lGbtu7LA1oEhmb2ySredOFdptvjwSsQkJW129MCQ+rRjkDeag4K/CXjxaRq8HuN68OnXRX8TA6DaldSN1UkUssisXSqPA/L1aiD6JosWnZP/Gd8PUFvWsrnPRf5jrcjK5p1Wauzi5+zERKiAsDo1afkvVoe63TpTMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTITGDel/3gDf5ViIed9lSwMnl3wRcq6dSwfN1tseBA=;
 b=a36W5TtZj8VEskX9/2zgd5bk/JEBfHEYCkLAKvW2JPhQ/BumPqsiMPnK8bAp2b+AuPT4VmYSyP6f1pAs8IcUbsQJJ3viJzpCowYx6+VznszSW5o3g+jvpfGX/TDhYbzhV4XXB5wcS8IGTovdxz07JO1OpVFsdcVr0Q6uGAC2K/F1UurfJvJ36TdvVDp9eYWFJh2+M0Bj5r+ta5nbypHbhW8VJ1I02Steu5eV79DG09Kmq62AFteslQ+dIj5PDTDyKvrtvCMr5XeqrhbTOoSylSHgDnl2kvAWVWN9KurkpfXi16pFkjyTPCtlSYAiQgpjT0LZCcnTw9HUr9OmWpz2Hw==
Received: from MW4PR04CA0347.namprd04.prod.outlook.com (2603:10b6:303:8a::22)
 by IA1PR12MB8493.namprd12.prod.outlook.com (2603:10b6:208:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 14:33:21 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::be) by MW4PR04CA0347.outlook.office365.com
 (2603:10b6:303:8a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 14:33:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 14:33:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:33:07 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 06:32:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v1 01/11] vxlan: In vxlan_rcv(), access flags through the vxlan netdevice
Date: Tue, 3 Dec 2024 15:30:27 +0100
Message-ID: <534fd8e3835d30c33bba3d77f26f017bcf6b7923.1733235367.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733235367.git.petrm@nvidia.com>
References: <cover.1733235367.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB8493:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ebfb34-65a2-42b0-eca0-08dd13a76f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wp412NdwYD6D1KsRcFh5B44NXUwF31IC2n32ENmKeMpcrB6oC/ZijTBTWZ/M?=
 =?us-ascii?Q?pJpWa/3LAl+uOec3HWyfB0khunBCMpOklNwV9aCjzmNukaS176PyCVhDVQxA?=
 =?us-ascii?Q?Rtei7zNBZvUn+BVLmvRcSdR7cWD/QAQ6uMIZvslE1xvaC5j6xpvLFhMlrvxB?=
 =?us-ascii?Q?MSIbOr4MZpgSN2anhvX0zvL1jk8FPNBZmrAoeH3AyWmGsRgQOcpbix0FKw54?=
 =?us-ascii?Q?JSqynvFptpm9Oc8zJkIex5ML/jcDOCz4ytmxowgqxrKTdGi6jYpF7l8s1AmP?=
 =?us-ascii?Q?OVmi5mQu05dS8m1kKZUnor/XXEQbvtfy0tuFrZbsOgRHdWMlZnmTB4gvWe8I?=
 =?us-ascii?Q?kI+yQK3cAmLKxO8rjGf1rqiRerf652utAnUAs7ezqEMCQYeQHFnZvXQ6irDN?=
 =?us-ascii?Q?ApV+rQynsmoMuwrg18nh32ll/53TAOAM4H06YcwyJX8fnKkcAfUbhFl2EJtp?=
 =?us-ascii?Q?p/xHWS9A2GTmLH5GVYk3fSywnSINJpn9HaEyqsqxehdsZB8eRSlGVkizu4KV?=
 =?us-ascii?Q?VZxlPLMJdxp0mlyuniOO4yPDGzJFAXOewxNKHhWRQTmOk6Qjgei1L7iooHt3?=
 =?us-ascii?Q?i9iQNEj6GhT71NNZ5lj3f/bPp7HZtUQuZeJWNjuCEcbcOwpE4I52DNBYEmOc?=
 =?us-ascii?Q?oabFT2KXQ7yTDVGbz5FAtpyi7R/80XnNR24Y3Xlv1RZit8XrODfYjp68TzpG?=
 =?us-ascii?Q?RDnAY3Wue2MWwk5IvhYOiy0EqGJ1JgKjRJGfvdqzFzfO7HUMcAUv8a5OjzpR?=
 =?us-ascii?Q?E7xElRqEBuOP67MPz9lm6e5m2Wgcw1GgKSbpdskwii5GKF7Fv/qeEv59mc/U?=
 =?us-ascii?Q?FB90Kty1TZ8M9rmLsxZjvJOuXcN20CZatr8WkyTX04xG79kSf6uR76xwAsDr?=
 =?us-ascii?Q?Svf8C7w5B/WBQ/GaGf3iPbtTpk6uN/RDLONXYEGKHcs+rx0zjqF+5SuEXjzH?=
 =?us-ascii?Q?qhQOHhqMnvVtv4i9mq/IcZCNchnBn5ueRmD689wgDAF7hNUKWZivgJ0w+kXZ?=
 =?us-ascii?Q?9f7QMpEwGMiDY7iwnOz0K3cBJ6hG98j5VZPDYvIqybammTbMYnZvs+RrFSxH?=
 =?us-ascii?Q?qNqcfnK+ws7nvg1/5xyQcbPBGT4yU6IB729p9m2lWWcHJOrhKaLHNWL47AHe?=
 =?us-ascii?Q?nzepglDZoYN6ocosW4M+4wJ11/SEka2AmAboyZsEEhCBRbSOYoOG/lVvqny9?=
 =?us-ascii?Q?DVzu+letedjSeO2A9wj6mw+twh9HnANX9i9RAPdqjoNl0EuXe81o1k/iavor?=
 =?us-ascii?Q?Mthq2pKrdx3tWQ6fFyNTKpdUCYmEdZdQiQ0jbRSGyVfefEyNnmiZsQxE0TQZ?=
 =?us-ascii?Q?S5P3t7lf2ZLz742JqTonOFVhmwv17Xq+q9DRAMni65Jh/WvO1ULGv7AJA0U0?=
 =?us-ascii?Q?82iARgBjStGS271u0n7rl/O0i5zEw7+vzX84wgk8Az867uZ2rCSnA/FZPRSX?=
 =?us-ascii?Q?5k4bCsxvS8YTnw8StzhG6/s9p5nzz/kT?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 14:33:20.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ebfb34-65a2-42b0-eca0-08dd13a76f7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8493

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
index 4053bd3f1023..d07d86ac1f03 100644
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


