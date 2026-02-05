Return-Path: <netdev+bounces-257347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBUzNAcehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:47:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40243F8312
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4B8E3022F69
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2163346AD;
	Thu,  5 Feb 2026 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJX9qJka"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DDA2EAB8E
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331652; cv=fail; b=UV2hDNDDh3zoTREMuCqNWYcLvnMZXVRtNyQqgry5KL1dkmqEvhjQcTI3zPW9UqQWf6rFxvWWGEf0se79o1CwEv5fSaF+OR/n5L2eDiZY0qFL9pdkm5i1oTsqZ3DkIXFdZ1QyImadRs9B78TpEnNhNeWTrJU1e+gmV2LiG2+Y9AI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331652; c=relaxed/simple;
	bh=rV+BYBScHZrwQo5VCoLAB9GLWd98W0R5QYE8DpXG300=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sE+vv8NeCku18GDQ+Kotq38SAPzzmBipswQRzer141v2CsCNAxlthuyrXb/Mol8gOB+cEY287pFvTMnSDCIeZXPuvAAfwbktachCrL/D3ixIHN1pOl49ou+t5WWYXwiw+7kbLGITL/ecJQ/I6DC41KQSaxh2h908ANbe08bO3Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJX9qJka; arc=fail smtp.client-ip=40.107.209.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EfaAN5K21s1Jbj6jjUn8vwn2IYd0j4obU0xUHawbiuKr5nBQowQ6Osz+jqpcQnpCeE1eMYFPdHx1o+kxyrs4Q1Vughkm/7wSN2FeC74y6nzmHd3OU7yaJjQ7+G8UxUAmeoipPuxRFUUCaaqSPUxHXCNOM1e1mzUw1YA6dlLMyKhiHBQ90OaJYGiQzuRR/aD67xNRW0A/tb4S1WTl6stK8ZpIf9S/uBaUr8oVILdzx695Z+1nXYgNM708gnrfmlHnesucJi7jrfa8+c/OyJywzhTstF6iOflgWWaZdO9ZQm5EUCXAbHWcXigj4nGPxW1sm110eLbJqnxAqYf6MFh65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=qfktx4Mal+usIqqVTSpTD0GAseXkV8spOe90nbpPk0au2xIn5oB0CPBkyiIoy79DtFtdC0wa1EA0zgkj9eg73rJonH8YWBSnhcGP1bypLZ2XpOrESFPNbi0Q1rKrzGoDFJXI3uXtASbtnlHfrwaMK6JiYV1DkyqFtC1K89J0txlG274hpAYoFKLvUe8Y5NIKc3HOske8TJIZ8KutRM4u1E+5XTakOrztZQe8MnoIBhDx06DRqh0tD7wg9fxcZo/Em6VrsjETje3Ls1Ti5jDX2lELt03rLNE2mGzX//GGMt6sDVZltn55bbhLmHFUsn1pWZClK9+aWk62Ydhub7Cw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R38e6nZvYGCaJHSLMq/L6GLkbMDDeQI+wiK3nJXoLUI=;
 b=tJX9qJkaZ8X99cCRzpxqNc+AZYXzmzu+VMwP7XgBVY1vrWMNYakkXrIDLt+uy6daJPYhoGM8PY+ZZg/vjQ6c+WiBX6+Yx9QJOdaWKVJ8BouIhE+DpLipZQkg61Y4eNem/yqMO5e+IwE+rM1qYFk+CiAXwpDLSKpRT8wj8XO6CmT74K5ddMkaASw1E+z4kuyFtCtpgbur+7XJl22qHN0GFOa6LmTZDN+tNEvkILRjobNTCaz65i8iv6TUKjPBwEaUiE2i/ftW4XMGIYcxZwA5ZG7Q5wToajOOuLb4V9JEindti7Lnq/O/+uhlR0hAC9mO/mMllASvAfxrJSsn7L4ESw==
Received: from BYAPR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:e0::38)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 22:47:29 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::c3) by BYAPR05CA0097.outlook.office365.com
 (2603:10b6:a03:e0::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 22:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:28 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:15 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:15 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:13 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 02/12] virtio: Add config_op for admin commands
Date: Thu, 5 Feb 2026 16:46:57 -0600
Message-ID: <20260205224707.16995-3-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205224707.16995-1-danielj@nvidia.com>
References: <20260205224707.16995-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MW4PR12MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: c9ef5ae2-9ac8-497d-e786-08de65088a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PFtUnWA1SU4vPFzsonxVmCL/3ZBgb6BCx7aoD56IXLAEVFJAXNffAxG/rxO7?=
 =?us-ascii?Q?J0tSQHF8Rbpy0zugAl+BnN6Pre2oqA+K9q4dYS9TVicP8SreikGWgEIJLs0N?=
 =?us-ascii?Q?q0heaJ0o+KipdQjtS8IpRGXPpW3OTecR2XT5k8vldOYBxT5ARbJDmWDs+nDw?=
 =?us-ascii?Q?635XKwLJkLFsbGR64tg6knMSDzBSiTYjaK9zfYi7AiKfaXGhKwoExoWj+rKo?=
 =?us-ascii?Q?zHw7uxvnh45oe73V0xAx+vaGfbVh6ZxtJxMVrkpDvsTgdKD0XRJ0E5dQQ+1O?=
 =?us-ascii?Q?op3e+mNe/CQFBu/3Q1Bf8UEPNiJ+4xh/L/1SgvVGu1iCu3kp0mr0sg+LDpNM?=
 =?us-ascii?Q?C44D94eWGn4dLI88MOOxzSKr9FA5LU+OLONFn3lXCGDWM5u+xUCLTf9aOxR/?=
 =?us-ascii?Q?jnNhcXwFHc4RcYx7IkuWaMlZ2xxAYr8m31NKkB/ygqrkxCz0dJeBmoJquESc?=
 =?us-ascii?Q?4Q7FRSB/8lRsedHgLsknRXNg3waL2mAc7T9RudrYqeW9zowqAZnKG37Rw1Jl?=
 =?us-ascii?Q?r4vKVqJhe3/2fmyAqSiJfl2giDKqyhwniMGe6oxmugukp1mJVdnpEuvtEN15?=
 =?us-ascii?Q?s09Ii1QNhhcP+QbCUJvwTLS+ZW5EQSzvhEeAgX1OfXDPwHW1SaV5Rh7CS7pW?=
 =?us-ascii?Q?yCZGNn8fbp1RhqaAPRTd9tHX13wBKIzmJNxgRTvgQ/MYxXnTIGQM+gzA68RZ?=
 =?us-ascii?Q?Wem9oTc5+1Lfrj46Mz1dbvObJbkPt2OjpNH7DbmSldm5+BdPEBHtAAhUFL8C?=
 =?us-ascii?Q?qf3FP2Xc6NrCCISbD07Hz47AyAIxf0KK7149XDCMvetorh02yUPgtTjAC/ls?=
 =?us-ascii?Q?sL6DgZ8uAc8gGu7+Gdk9IHU1mVGXVexwZybeVNpmYZ540fLDrEjOGwfo5psW?=
 =?us-ascii?Q?/IlzH0pU3iVEheVAfvMtGdtHQsPKDtiPZ0r2GBHcnhsX24eqj+Fc2ybLdhVa?=
 =?us-ascii?Q?rMfzFvuOW9Njfij+XZEQLSadxz2UYkc/B6ohdS0KFWxoORcOz5Nvk2H7YpqK?=
 =?us-ascii?Q?CYahyBrndbCGvqT1gEFGwEJJN4UOn0V2+JP1i2ElD6qbwPtQq6dXUIYcilKY?=
 =?us-ascii?Q?8ixgpi4/yBVt4p0seZedD33ev77TKsyzGc/x2KCVnjTZIEqc2nxqjo5SZmFd?=
 =?us-ascii?Q?zrec9BBJley2BQyj/BEGSpO2cC1VG/SIG6y44CKsnOnFIWccBxjd6Nu0Jam0?=
 =?us-ascii?Q?V1q0YAqTUMCdsUxCzg0kvZH8DyqerRPrP/U0O9TSo7i51pRtvxaRAWuLjtMq?=
 =?us-ascii?Q?eYLcuJW4mRt5kt24Cv+SyAbVR0b1+Of9Qu2z0iwid2dTbrTf/SLc2plbFZnF?=
 =?us-ascii?Q?AswXFdraTm55RiOJQhl4skyTvxejaDopfNgAC8WR97fTumIKadn1I+KnAo1h?=
 =?us-ascii?Q?r5GdTmLP8nwZZo4A0KuioEYnlmCdSvQrtmrMrclA0oR9xNx2KH3r9xNn5NDJ?=
 =?us-ascii?Q?JqA/QuLf75OXhf6gB2O7gPDHey0eZGL6iYCW+QLdagbLiUcMm7DC7ODJB8wT?=
 =?us-ascii?Q?I8sY/j1Nz4dTnfUVDDYznxb8SJjhlowtIve5pJWaLJQvEwo4VtJ8AHbOJybl?=
 =?us-ascii?Q?J45CgU2DVHsLSYn8QCitbosOG0rvaoefKWvwEyPZqH21e0Bz4/UACRh50eKs?=
 =?us-ascii?Q?2r+Qq7kuVSNfeEItIFWI0XdqEu9ARSaH7E27cZDY3RXFtN0nbcKy4IZJU12G?=
 =?us-ascii?Q?rAXcQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oSmsytEgmidzBY/vGS94E1k1TS8Ersgehzem4900guMOKDE6srKaKkc3zrMQFkxcun909XSIj7Gi+vJk4AzgV7bXZw3o72jLUCnpJMon/N0amAGPqlVb758I5TC5kn27GNQwWygAjjaMFxtxHx/bqtj5hFEbGWz3s+8JWzhmS0d/RiR5bYyQNZUTEXsXrWeCbHbJrlZdNApIBFPOfMo/jjaV3kNZOr87YEwS4yEHmOyeckogpnEUBj6jiK6mhcvUaY9usNotroZtJOnOD84bVJIBoGKf1JD72rTmqarNhSx8PG9DcrursFhC3x/Q0+YZKjoMSKWGiZKxuKQpW/73osd39UnK0GnMgl/Yu2kN1p4qJS50eNNr9ulhbglX4QcPegvbtqws76g9X3G1JL15imD9QlzxcHp6GsmHUrSu95avqWxjXrXPGpBn7/8HOjnG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:28.7522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ef5ae2-9ac8-497d-e786-08de65088a4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257347-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 40243F8312
X-Rspamd-Action: no action

This will allow device drivers to issue administration commands.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

---
v4: New patch for v4

v12: Add (optional) to admin_cmd_exec field. MST
---
 drivers/virtio/virtio_pci_modern.c | 2 ++
 include/linux/virtio_config.h      | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 1675d6cda416..e2a813b3b3fd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -1236,6 +1236,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -1256,6 +1257,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 	.disable_vq_and_reset = vp_modern_disable_vq_and_reset,
 	.enable_vq_after_reset = vp_modern_enable_vq_after_reset,
+	.admin_cmd_exec = vp_modern_admin_cmd_exec,
 };
 
 /* the PCI probing function */
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 69f84ea85d71..e36a32e0a20c 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -108,6 +108,10 @@ struct virtqueue_info {
  *	Returns 0 on success or error status
  *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
  *	set.
+ * @admin_cmd_exec: Execute an admin VQ command (optional).
+ *	vdev: the virtio_device
+ *	cmd: the command to execute
+ *	Returns 0 on success or error status
  */
 struct virtio_config_ops {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -137,6 +141,8 @@ struct virtio_config_ops {
 			       struct virtio_shm_region *region, u8 id);
 	int (*disable_vq_and_reset)(struct virtqueue *vq);
 	int (*enable_vq_after_reset)(struct virtqueue *vq);
+	int (*admin_cmd_exec)(struct virtio_device *vdev,
+			      struct virtio_admin_cmd *cmd);
 };
 
 /**
-- 
2.50.1


