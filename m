Return-Path: <netdev+bounces-252084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKFaFT9PcWkvCAAAu9opvQ
	(envelope-from <netdev+bounces-252084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E765E91D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A590727FC4
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE20D4418D0;
	Wed, 21 Jan 2026 22:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZWP0QECs"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011071.outbound.protection.outlook.com [40.107.208.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F143E49C
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 22:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033304; cv=fail; b=kAUpc/k/R6M0EwNYIdfXg7QuMCaAjMU3nLXFQ5IyUwSQlmvyWzs0xZAAGO8w/I/Qz3v586Dh0jbkMr3eoAoiIHBvcQ8TyMpOaPrG7JOzzAGSbKGONkNo0V3LhkHwbdmk8WMm83g8+CikJ0iY3yhvkvF4mI0LWy7G3hZjBfSqvyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033304; c=relaxed/simple;
	bh=jOOSVfRKEEiUqggAyHTyJ7RvC5gn+W0sxfW2PjysQAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t70vVcTNKha2vBts4f9gAo8AIIgBO0lK82dPKhXNJl8WL0srhsXmK1yEEVjnI4XRUS+l1SrNoDE1t0gsbIwwu82axJsud0S5FxIcwJz9j5d6fLJei6+s/VBlarg66LK5398eYleC8+QLwGxND5XJBjoI69+6ka551JCL/Z3fjMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZWP0QECs; arc=fail smtp.client-ip=40.107.208.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loBACUMlOMXYEPfO2SnkJ156n0eYAeODfL15AM1R65vF/0AupHg01iLerBehn47HPDVtwWGVNDju+GE5uc+Tbtj0MRs5aQMJoI2yKY5opK0u/Tra67m0h+vfWNYxLnystFRYfOUxN3UmaU6mbKsyfl6+JFhx6tToPyZJBczsAinNmhixBvMS1LKbURQM5e35XeluUCVQrxLpbtiFtPipvSnxFYBnrMjhRDzfpBiCwDVACMTE4XZTKCVyoi3xVtGRK9J3LdkuS+0vWbIZ1YU8UAvO/C6X7EzqgFSkPCa9WIQQniBuLfOnkNwOeAemvh984cOnwy+FAZcFHNnFWaWwIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuVIEljlsi+QkA1Law23CkwRsoXpajUUYWnYWdvDJVs=;
 b=GdB+bjHe8EI49KvsAMf5pf210c3/vMh50Q4DFoTkiweZ4kJpu3esAXU5iGYpaRiSprUy2ECOvMBcOiCKZ+BEySRYQsFENa2o/qiomKexYe8rExeouRU6Z3FoNsbG4bJgiJiiLCvil/sWqAzP2L/QEpxfO2qrHaBLbIPu+HzBDCBFpxr5LxF82DGXY1IoR/3LwIIaRofb8wDwZHtkGwk6yY4l/mKwUT47WrJs9t5+uQGP3dDaHBPXGeLE/SHva2BxlH0BrnXUNo3uR6aTN6bY3cK8NGCxWA50IcEt1khDuSOEea6g0kAJN8mla8ROeYNcgEyudi4gIryDtswalD9FFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuVIEljlsi+QkA1Law23CkwRsoXpajUUYWnYWdvDJVs=;
 b=ZWP0QECsSxmJEFzNk6w5omNLA1d7eKtOOHxbf4ynpQW2fCMNJpdlXEx3fBWXMP1OCFqgikAoSxqW2Hv+/uvAazOtm/xmNTUK2q7D4h4eH9Rp2q3tqK87tVJa9ZvTD1nytp8lz6kePTlloQbXsz5MB4dh0jHKWip7qhU3F68FnZ7bJCz+v4/DV4Fy+PXLoItm3Lnx982Ot63+GNK8AUbtPSOejKaSntVgXd0a8Rp0u85VYhOp4vmABYFMNuGvT0/xyAt2DmDogPOzDeOgPf/0o/KLZ4VSH2UrVKFSK6n2Wpe+DaemiSk3w+7ui9hiDmvVUNDQ+QcVIFNrNrVXBfdjrA==
Received: from MN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:52f::13)
 by DS4PR12MB999102.namprd12.prod.outlook.com (2603:10b6:8:2fc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 22:08:18 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::4c) by MN0PR03CA0011.outlook.office365.com
 (2603:10b6:208:52f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Wed,
 21 Jan 2026 22:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 22:08:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:53 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 14:07:52 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 21
 Jan 2026 14:07:51 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v16 10/12] virtio_net: Add support for IPv6 ethtool steering
Date: Wed, 21 Jan 2026 16:06:50 -0600
Message-ID: <20260121220652.894364-11-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121220652.894364-1-danielj@nvidia.com>
References: <20260121220652.894364-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS4PR12MB999102:EE_
X-MS-Office365-Filtering-Correlation-Id: 99287fbf-7074-40d2-7143-08de59399501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MGm4928uKpOrnyYXiuzWBtrnGKhCOk7hcU1WwoBvxD0PxSJm8J17mMUL6U/L?=
 =?us-ascii?Q?Tagh8UabsPxgnIrHPKy4yNoYjTXFqfnBgjjakW5owrbwtw7Y4wj06Qjwrhqe?=
 =?us-ascii?Q?ToTMMGwk116GtP10dLoG/0iXizt5pqdpRKB4y5gO+CkutPWGWguGF/oKfdI6?=
 =?us-ascii?Q?fEisOnh6xQ05qSRGNXvtk0ZgTJbva89XwkS71HwDd5SEcYG3kS7Tikw56Z8b?=
 =?us-ascii?Q?PyXVg0w41HXnGteTEzV5CBFaDxnmOMLxsKrvBjn7Pa5TePBMYhKDLoVYHs3F?=
 =?us-ascii?Q?jwkoEDE/ZkP2tLgB1HEM44RhSAa4TgaXpWe0FMeJvoGg0MaVaI4xV3QSoD6G?=
 =?us-ascii?Q?oLKoZaxam2OROfNjYF90YTe+yAlmyd/BmUyqMS/7T2WsDu6NJNmlMuzlaY9G?=
 =?us-ascii?Q?2/NrrcY+OKKmkTANJfPP1SUjiHlt7BvkUMlvD3n5YkzKtBVb/UM3AiKvJK1S?=
 =?us-ascii?Q?CkCtjUxmv1IlOuLvanzWNqgNeoSVVQXsMcDs8/S9WdqVgoNkSBTQbyU5Q7dN?=
 =?us-ascii?Q?KtbOGzhE3RCIkbQW+MlAXo0LCk95Gb7NNK13FTybBmNpCgUVtwq5Pp897tBC?=
 =?us-ascii?Q?jiCnapsAdaTph5JSvHU+WQJygZLpz9Gw+J2IfS37/LbBeGx8l177wuygIyqV?=
 =?us-ascii?Q?Bc11kUVbVjELEn8Wa1fU/kde3o/5s/rSo/3xcoSkRoPh8y/Iqkv6QEhgA9Yf?=
 =?us-ascii?Q?ngn6z7dELh6uXBj4x81eE8YH8Ob9unLsCklnjnnRXH1t1Q/7eUvHBIE3lh8M?=
 =?us-ascii?Q?B39Hc0Om7HMwj0xz4T+avtccL+/HXD2HvUeYvHX8E1uduoBPifbXyrnz36q5?=
 =?us-ascii?Q?c4Idxu+YnwrpdC5ilD9R1Z6F3cRyYTDlRS/1cdNM0X91CuUJ6/lu84xmY+Zh?=
 =?us-ascii?Q?djqseZEbwZIN4VaRq54hSs1eqG636wlMpU5A+o4N1wEZDpAGgOesMVHaceCg?=
 =?us-ascii?Q?6bznLlofkouf1Ehriej1JrvchWtfwPxp5MeFb/FR6ZCtWT5P7QGO/qzJ+LiK?=
 =?us-ascii?Q?8WHNbJWgQJwVcXTzRsNsShmcejIQx2bn+F01P2YZbci7zL+7Fv3KFd7JL4jw?=
 =?us-ascii?Q?tC7dyR1yf00Na7rjojmTPVRGN6Fwm66v1y1df6z3Mo7FVZQisQ337v+gHSCo?=
 =?us-ascii?Q?V/Hvolzhl2wSnLC8ZYLmf3E/xxtUi0//0VvH3e//AOuNFNMD2WnG5pBsSu6n?=
 =?us-ascii?Q?E+jwPAz0TNmn7Kb8bWEqySubvTsE0DPDQxrJr4GRK7ZSdf26mkXU0F5tgyLL?=
 =?us-ascii?Q?wtBb2Wp72SSiKc7igPUyIfu8gCOK+Nf296f9s6fUVhttsL2BclTdwVpnkMV7?=
 =?us-ascii?Q?FR+lsI99D+NOI5XOZVlCzoUFDj/BjWsbbZneBNIGMoxyqW2irET6ebhTa/q6?=
 =?us-ascii?Q?UMBhAIuxFrl8tpsIZviJZfsWu3itdq1hOGvc39rZPAK7lxpEdGB9sFasoed3?=
 =?us-ascii?Q?03pUk9yQCDIwOgOSZw6pja5RDx0UOWmEaIH6iEI7JoseO5fyH2C31KA5azs6?=
 =?us-ascii?Q?kszFYxQv5/SvHYmQGh8oxSFIAmOTofPtYOwlFdQ3OsJ8MIX0DP3wAvr5726h?=
 =?us-ascii?Q?pA1ItGlTszofi1cD9DcyQTVWr8FFcAs5VVexkfnLEASmcSkok9VuCJnn28KB?=
 =?us-ascii?Q?P2T8vIZdLzPD6iE3kNk9Tvtzpuv2GkPd8fnByAad0/lthK3f4VKHFlBiFGC5?=
 =?us-ascii?Q?WWboAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 22:08:17.9303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99287fbf-7074-40d2-7143-08de59399501
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252084-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,Nvidia.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[213.196.21.55:from];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DWL_DNSWL_BLOCKED(0.00)[Nvidia.com:dkim];
	RBL_SENDERSCORE_REPUT_BLOCKED(0.00)[213.196.21.55:from];
	DNSWL_BLOCKED(0.00)[10.129.68.7:received,213.196.21.55:from,216.228.117.160:received,10.127.8.14:received,52.25.139.140:received,10.129.68.6:received,2603:10b6:208:52f::13:received,2603:10b6:208:52f:cafe::4c:received,40.107.208.71:received];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.129.68.6:received,52.25.139.140:received,10.127.8.14:received,2603:10b6:208:52f::13:received];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 16E765E91D
X-Rspamd-Action: no action

Implement support for IPV6_USER_FLOW type rules.

Example:
$ ethtool -U ens9 flow-type ip6 src-ip fe80::2 dst-ip fe80::4 action 3
Added rule with ID 0

The example rule will forward packets with the specified source and
destination IP addresses to RX ring 3.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4: commit message typo

v12:
  - refactor calculate_flow_sizes. MST
  - Move parse_ip6 l3_mask check to TCP/UDP patch. MST
  - Set eth proto to ipv6 as needed. MST
  - Also check l4_4_bytes mask is 0 in setup_ip_key_mask. MST
  - Remove tclass check in setup_ip_key_mask. If it's not suppored it
    will be caught in validate_classifier_selectors.  MST
  - Changed error return in setup_ip_key_mask to -EINVAL

v13:
  - Verify nexthdr unset for ip6. MST
  - Return -EINVAL if tclass is set. It's available in the struct.
---
---
 drivers/net/virtio_net.c | 99 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 7ce120baeb41..4878ade43ac1 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5851,6 +5851,34 @@ static bool validate_ip4_mask(const struct virtnet_ff *ff,
 	return true;
 }
 
+static bool validate_ip6_mask(const struct virtnet_ff *ff,
+			      const struct virtio_net_ff_selector *sel,
+			      const struct virtio_net_ff_selector *sel_cap)
+{
+	bool partial_mask = !!(sel_cap->flags & VIRTIO_NET_FF_MASK_F_PARTIAL_MASK);
+	struct ipv6hdr *cap, *mask;
+
+	cap = (struct ipv6hdr *)&sel_cap->mask;
+	mask = (struct ipv6hdr *)&sel->mask;
+
+	if (!ipv6_addr_any(&mask->saddr) &&
+	    !check_mask_vs_cap(&mask->saddr, &cap->saddr,
+			       sizeof(cap->saddr), partial_mask))
+		return false;
+
+	if (!ipv6_addr_any(&mask->daddr) &&
+	    !check_mask_vs_cap(&mask->daddr, &cap->daddr,
+			       sizeof(cap->daddr), partial_mask))
+		return false;
+
+	if (mask->nexthdr &&
+	    !check_mask_vs_cap(&mask->nexthdr, &cap->nexthdr,
+			       sizeof(cap->nexthdr), partial_mask))
+		return false;
+
+	return true;
+}
+
 static bool validate_mask(const struct virtnet_ff *ff,
 			  const struct virtio_net_ff_selector *sel)
 {
@@ -5865,6 +5893,9 @@ static bool validate_mask(const struct virtnet_ff *ff,
 
 	case VIRTIO_NET_FF_MASK_TYPE_IPV4:
 		return validate_ip4_mask(ff, sel, sel_cap);
+
+	case VIRTIO_NET_FF_MASK_TYPE_IPV6:
+		return validate_ip6_mask(ff, sel, sel_cap);
 	}
 
 	return false;
@@ -5892,11 +5923,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
 	}
 }
 
+static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
+		      const struct ethtool_rx_flow_spec *fs)
+{
+	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
+	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
+		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
+		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
+	}
+
+	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
+		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
+		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
+	}
+}
+
 static bool has_ipv4(u32 flow_type)
 {
 	return flow_type == IP_USER_FLOW;
 }
 
+static bool has_ipv6(u32 flow_type)
+{
+	return flow_type == IPV6_USER_FLOW;
+}
+
 static int setup_classifier(struct virtnet_ff *ff,
 			    struct virtnet_classifier **c)
 {
@@ -6033,6 +6086,7 @@ static bool supported_flow_type(const struct ethtool_rx_flow_spec *fs)
 	switch (fs->flow_type) {
 	case ETHER_FLOW:
 	case IP_USER_FLOW:
+	case IPV6_USER_FLOW:
 		return true;
 	}
 
@@ -6072,6 +6126,8 @@ static void calculate_flow_sizes(struct ethtool_rx_flow_spec *fs,
 		++(*num_hdrs);
 		if (has_ipv4(fs->flow_type))
 			size += sizeof(struct iphdr);
+		else if (has_ipv6(fs->flow_type))
+			size += sizeof(struct ipv6hdr);
 	}
 
 	BUG_ON(size > 0xff);
@@ -6099,7 +6155,10 @@ static void setup_eth_hdr_key_mask(struct virtio_net_ff_selector *selector,
 
 	if (num_hdrs > 1) {
 		eth_m->h_proto = cpu_to_be16(0xffff);
-		eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		if (has_ipv4(fs->flow_type))
+			eth_k->h_proto = cpu_to_be16(ETH_P_IP);
+		else
+			eth_k->h_proto = cpu_to_be16(ETH_P_IPV6);
 	} else {
 		memcpy(eth_m, &fs->m_u.ether_spec, sizeof(*eth_m));
 		memcpy(eth_k, &fs->h_u.ether_spec, sizeof(*eth_k));
@@ -6110,20 +6169,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
 			     u8 *key,
 			     const struct ethtool_rx_flow_spec *fs)
 {
+	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
 	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
+	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
 	struct iphdr *v4_k = (struct iphdr *)key;
 
-	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
-	selector->length = sizeof(struct iphdr);
+	if (has_ipv6(fs->flow_type)) {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
+		selector->length = sizeof(struct ipv6hdr);
+
+		/* exclude tclass, it's not exposed properly struct ip6hdr */
+		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip6_spec.tclass ||
+		    fs->m_u.usr_ip6_spec.tclass ||
+		    fs->h_u.usr_ip6_spec.l4_proto ||
+		    fs->m_u.usr_ip6_spec.l4_proto)
+			return -EINVAL;
 
-	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
-	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
-	    fs->m_u.usr_ip4_spec.ip_ver ||
-	    fs->m_u.usr_ip4_spec.proto)
-		return -EINVAL;
+		parse_ip6(v6_m, v6_k, fs);
+	} else {
+		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
+		selector->length = sizeof(struct iphdr);
+
+		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
+		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
+		    fs->m_u.usr_ip4_spec.ip_ver ||
+		    fs->m_u.usr_ip4_spec.proto)
+			return -EINVAL;
 
-	parse_ip4(v4_m, v4_k, fs);
+		parse_ip4(v4_m, v4_k, fs);
+	}
 
 	return 0;
 }
@@ -6193,7 +6270,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 
 	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
 
-	if (has_ipv4(fs->flow_type)) {
+	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
 		selector = next_selector(selector);
 
 		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
-- 
2.50.1


