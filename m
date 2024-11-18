Return-Path: <netdev+bounces-145923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F29D14F4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E461F2353C
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42A01BD9D2;
	Mon, 18 Nov 2024 16:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JXiDdsof"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D321BD9C8
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945749; cv=fail; b=cLXRwpVuaLl4xu4rBIsJsnXhevlsEkqycdnPMDdi/rPwaZyuT56ZANL7ZXgMuCgf2J2kTnhmUl/ELOQfK4jCLvM1qjZ5iMnQVHT5uqEKewJKfVFs1nimEuqv2QKoOeR59vY6SlJl2yoRPHIVsSfjkR6z+UFMRwaKYBCviZ4kE1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945749; c=relaxed/simple;
	bh=CMM8GEri3fzYowwTwj9mR8hQ2lcNici3nttmfuF3re8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHKKGOLnj1MKvh2d1EEGHVmplsE6TfA9ui7QLj2vi/GBPJv+sd0HiF5I62Rr6v5lKp7SjXYy0OTz7TR58qSCkb3P+dghmkcjgnKgcDgOUa+le5lj34ZEVaU+UiJI6Sgh5Ot1Yo6HUCKDbNeVKNIL7tbCnlgl7I6Az2o/jq2AqVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JXiDdsof; arc=fail smtp.client-ip=40.107.236.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzLiFRfuukIpZI/QTO3/mD+1k7jpCKK+tUjytG8XeTKZ01kC0M+jN4IWTCtBDWwQVn1I8Iqo/eySgVmw8mqNs6ZXXtX+xn0z7P3IZg1mkdd2z6eW86PdvSDmAlHdgaYZSg7jXdLN5bhoQHjPDxzgPZTYERSn4wbH3do+onONUaS7jfRnKxursGdsrha4EZfDxLxdFwrMdDAxQx80jw/OXqd5+Tl3qAHlCs9msnhOiO+z4vC8crBynlL4s/DxjTX0idr9I8ddvupyNF8b/DLV/0TgApwHdIbTEamEik1jru7bCkeRh27KAMBqKOknFQQljKyP3fL1aliSPQ0xRVqc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rgVkuNK/eO4lOoW1xNYnnmYkrDa21FIY7tODJBvevg=;
 b=ZV8qNfOgfJsGcHHE3ml1QGHx1tu9pWdnxkYx0tQhFS6Tj70xwb9GDY9laHOb1ULPeiKcDlWzgx7nF13SfQV8ohuJR8v4q53CgbXXGI/W57DHD+XIiN0msjrMF/Uo3igGg1/w/93cldHjRujsUJIWCVBjaMXn4+70y9VVTWeq7JTJk2UTt6oIin59acRwPp8B/rqRXW9pV520YI3AHzdmnBSHYCK5nVRC+qkhbOD/FglcALdjju9HyCq7J0BbQ8FIaZujpKybnQp+dbFePm79Egr6xRgNafsNlVXPJxrTlRJ1wsMprSp8jWqGGlQ3Z1C6yjGfkUggP+XzP0WraBgf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rgVkuNK/eO4lOoW1xNYnnmYkrDa21FIY7tODJBvevg=;
 b=JXiDdsofKyVsq4Gu99LZDL1xJMlwF1TAyqRUxqKal+afs5q8JvXXojnUfuOk1Mt4NiKGN8uS7g8fTRkVvy/xQ0Kr5kKO31NuICyvuCBaUdXhUR4Rt5I6JNc0FwX6LFc3V791Fj4Mhu2Qo31IzcvUor8stkJxC4WX4tYMrm7/IUQSHaIDvgLvOEXvTFdLYb9TuWf1sYPozsNGixosb9KssVJWu13URxUyd9MUvp6cuSf5CiesAb0SY6pccJhZCJdNiwneqX3XykHmo/NhHtXMGp3H592LpQApbsfxrCXpSuxI3DSuOH3MvNi3DoABIGPquXi0lIOosYe6W/VJK7CH3w==
Received: from PH0PR07CA0034.namprd07.prod.outlook.com (2603:10b6:510:e::9) by
 DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.24; Mon, 18 Nov 2024 16:02:22 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::9b) by PH0PR07CA0034.outlook.office365.com
 (2603:10b6:510:e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20 via Frontend
 Transport; Mon, 18 Nov 2024 16:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:02:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:52 -0800
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 18 Nov
 2024 08:01:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Menglong Dong <menglong8.dong@gmail.com>, "Guillaume
 Nault" <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH net-next 08/11] vxlan: Add an attribute to make VXLAN header validation configurable
Date: Mon, 18 Nov 2024 17:43:14 +0100
Message-ID: <a4330e6257a32632521c4e35cbab114287406dab.1731941465.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e3afff-bc47-4710-18c6-08dd07ea62a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1riTPF/7vbKRITvrmlxfypE6D4nezPlFPmUfDzupub4Wyu80kY81BDJXCxha?=
 =?us-ascii?Q?6ufq9I1L9GTuLmcLRYzK4dYIbkRVnZoirIACoU8xbe6c3MBvga2bX8bV+VJJ?=
 =?us-ascii?Q?+7P4ELYyR9FUzGWbcIKUWjEnzgbQBXJE3U8K46QGWxwoGvcoZt8qYJHj0FRV?=
 =?us-ascii?Q?4jylKwWr3sowmRCCBMep+nc0PzT/830j6NPRdcYFk+h1C8zv7PRqaty+NVdy?=
 =?us-ascii?Q?EuFsl7EhyB3Cf4gwIjPAb46VrkD7CxyNR/4bYsO6UnaLEXxxwIqOv0JSzdEX?=
 =?us-ascii?Q?vF+4DvEzGeFW1xlZ5D2K7I+4Mlud5nlR+cBo1xzn/AxdBdMZRSrWebgElPoW?=
 =?us-ascii?Q?NujiuJVRsOtaS8TufHwyoQXxl27H+swVq9E++Lc5JbX0ovPaFKDUjxsdcT8g?=
 =?us-ascii?Q?4PF204Pyf9AnD2Nnx1lxRwXSwoAgM+PsbkiL5ZzhZBwMeoogCk1lwzxsibmW?=
 =?us-ascii?Q?AH9GCsPBVE19SHmlJmoAU/XAyckuvsMWOoSoVrEP5EJLrhR5ZHhJQJXuNtuj?=
 =?us-ascii?Q?ycOrx9AEF1jthBfsS28JJejEax7VHhmBNvyjUxxyyl4+q5938shzcJDJsUcT?=
 =?us-ascii?Q?U8XPaRi8al3CCDcjGsWdxLHPSh8O6H2ajQAlXPfRR5pWxJVlaWBLenoZKNIT?=
 =?us-ascii?Q?rkGLiXiCtoIPHBpuOklnXXnDztF6lAkYyFTIG32ZiiDpxNOPkjvfwVimJBzt?=
 =?us-ascii?Q?ZfaDf7InNd0bqmaTve5DB/pf2/7IkGuvVxgadIqtA0ndP9Dij9oHBXAWA0aF?=
 =?us-ascii?Q?iMiYUoWkx1+0zbBRULE3IAWRPChkxhsGTZr+M4W/3+78CuOmD1TSKkG1eqrm?=
 =?us-ascii?Q?aWfUhrqaOAONl+44bSw9/FjDDXysjjoiKVfb+FyGJk37qnv67D9RdPkUizkr?=
 =?us-ascii?Q?5A9RWtIiYhV+XsX7x69jmBqv/Kbd4G+cx6IOkBcjQIJMg+URcb5UgxdaVYyy?=
 =?us-ascii?Q?wFu3zoIvt3vZXmhUZBJGLjHd68lc91e7Gbw0fLS09urdr3gsko5OU6bSvo+f?=
 =?us-ascii?Q?YDFuqGDuvsXIC3gct2piMis9Cuq+Owm8+LJH6Phr0JXKs6D/KR73v8Mmzp4x?=
 =?us-ascii?Q?1McxvtIR36zFfAuDJ5PMfPXrmpJF3CgQULlohbrK/GFntbUeDv/3XcmvFk/a?=
 =?us-ascii?Q?f/OfJMAwBnNn4USYaV2q1HyoPe9+prXwjleOULkrVEBrvj5UUlzsXokGekhi?=
 =?us-ascii?Q?DEM3ABxGQPfJQkmWZs2b5HWXXbsEMTWBi1CtWWmxk6mWAQg8P9AfHwzapbfQ?=
 =?us-ascii?Q?UcdBZHVPcsu1jUWnPtqFMca2+cmgN7w2uJwy9DjuOvOez221GgDEuSY8iMMv?=
 =?us-ascii?Q?TqUOFx8VKCkzHrCK5/nFp2oi2evh2j+k0/8WzLWjDqnrOxfg5EIpcMe1z2UA?=
 =?us-ascii?Q?6wHBJlwBDwGGupOueCzpny4f40hkBBlOCJOf/yCUBKQ3PFJ4fg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:02:21.3916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e3afff-bc47-4710-18c6-08dd07ea62a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374

The set of bits that the VXLAN netdevice currently considers reserved is
defined by the features enabled at the netdevice construction. In order to
make this configurable, add an attribute, IFLA_VXLAN_RESERVED_BITS. The
payload is a pair of big-endian u32's covering the VXLAN header. This is
validated against the set of flags used by the various enabled VXLAN
features, and attempts to override bits used by an enabled feature are
bounced.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Menglong Dong <menglong8.dong@gmail.com>
CC: Guillaume Nault <gnault@redhat.com>
CC: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Breno Leitao <leitao@debian.org>

 drivers/net/vxlan/vxlan_core.c | 53 +++++++++++++++++++++++++++++-----
 include/uapi/linux/if_link.h   |  1 +
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index e5c7b728eddf..4aa9bacf4a2c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3428,6 +3428,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_VXLAN_LABEL_POLICY]       = NLA_POLICY_MAX(NLA_U32, VXLAN_LABEL_MAX),
+	[IFLA_VXLAN_RESERVED_BITS] = NLA_POLICY_EXACT_LEN(sizeof(struct vxlanhdr)),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4315,13 +4316,44 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 		used_bits.vx_flags |= VXLAN_GPE_USED_BITS;
 	}
 
-	/* For backwards compatibility, only allow reserved fields to be
-	 * used by VXLAN extensions if explicitly requested.
-	 */
-	conf->reserved_bits = (struct vxlanhdr) {
-		.vx_flags = ~used_bits.vx_flags,
-		.vx_vni = ~used_bits.vx_vni,
-	};
+	if (data[IFLA_VXLAN_RESERVED_BITS]) {
+		struct vxlanhdr reserved_bits;
+
+		if (changelink) {
+			NL_SET_ERR_MSG_ATTR(extack,
+					    data[IFLA_VXLAN_RESERVED_BITS],
+					    "Cannot change reserved_bits");
+			return -EOPNOTSUPP;
+		}
+
+		nla_memcpy(&reserved_bits, data[IFLA_VXLAN_RESERVED_BITS],
+			   sizeof(reserved_bits));
+		if (used_bits.vx_flags & reserved_bits.vx_flags ||
+		    used_bits.vx_vni & reserved_bits.vx_vni) {
+			__be64 ub_be64, rb_be64;
+
+			memcpy(&ub_be64, &used_bits, sizeof(ub_be64));
+			memcpy(&rb_be64, &reserved_bits, sizeof(rb_be64));
+
+			NL_SET_ERR_MSG_ATTR_FMT(extack,
+						data[IFLA_VXLAN_RESERVED_BITS],
+						"Used bits %#018llx cannot overlap reserved bits %#018llx",
+						be64_to_cpu(ub_be64),
+						be64_to_cpu(rb_be64));
+			return -EINVAL;
+		}
+
+		conf->reserved_bits = reserved_bits;
+	} else {
+		/* For backwards compatibility, only allow reserved fields to be
+		 * used by VXLAN extensions if explicitly requested.
+		 */
+		conf->reserved_bits = (struct vxlanhdr) {
+			.vx_flags = ~used_bits.vx_flags,
+			.vx_vni = ~used_bits.vx_vni,
+		};
+	}
+
 	if (data[IFLA_VXLAN_REMCSUM_NOPARTIAL]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_REMCSUM_NOPARTIAL,
 				    VXLAN_F_REMCSUM_NOPARTIAL, changelink,
@@ -4506,6 +4538,8 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(0) + /* IFLA_VXLAN_GPE */
 		nla_total_size(0) + /* IFLA_VXLAN_REMCSUM_NOPARTIAL */
 		nla_total_size(sizeof(__u8)) + /* IFLA_VXLAN_VNIFILTER */
+		/* IFLA_VXLAN_RESERVED_BITS */
+		nla_total_size(sizeof(struct vxlanhdr)) +
 		0;
 }
 
@@ -4608,6 +4642,11 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		       !!(vxlan->cfg.flags & VXLAN_F_VNIFILTER)))
 		goto nla_put_failure;
 
+	if (nla_put(skb, IFLA_VXLAN_RESERVED_BITS,
+		    sizeof(vxlan->cfg.reserved_bits),
+		    &vxlan->cfg.reserved_bits))
+		goto nla_put_failure;
+
 	return 0;
 
 nla_put_failure:
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 2575e0cd9b48..77730c340c8f 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1394,6 +1394,7 @@ enum {
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
 	IFLA_VXLAN_LABEL_POLICY, /* IPv6 flow label policy; ifla_vxlan_label_policy */
+	IFLA_VXLAN_RESERVED_BITS,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
-- 
2.47.0


