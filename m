Return-Path: <netdev+bounces-257354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OXiM4UehWla8gMAu9opvQ
	(envelope-from <netdev+bounces-257354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:49:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BF1F8363
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F839304480B
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC71221540;
	Thu,  5 Feb 2026 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="muVym9pM"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE483337B8C
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331664; cv=fail; b=W3BIA3bKHWSkGDiOmyJ722XWEBlDrWPkAWr3HI20aoW6Co2QvgsM1bHhq7L2FUA6V4D4CJ1iglTV904gYK2AJlRV9Q0R+53E2CPtpgbm4dXu4I3UOXFhfV9CqKI053KSCzWZNwXTxnWh+xLZ3KoaeBRlWl/o0HnQAJpfNVPJoJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331664; c=relaxed/simple;
	bh=+FrtVUTG0x9V1qUKjOjs4LeMxY7QGdychtyxzWqzKEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cezfwyEMlIWJb4PISss6xkoDH/oXGPYI/Pj2+2t40DM0LXDoAR0OblMDg1Cp26UcMn+FgVegwG0O+mTITJWRaXWeJhTTA/Hdum3tUyqHp0RuANzFTCdsk2q7VKELkTZ1zqxO9XtFqrVSdMuid45fSpnuQnIcLXzPWUa/XRtyUFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=muVym9pM; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKkq/jJ8oQWEJZM7LdCV82iIgDFWpP6gFTUCmnx03CoSIQvkfenReqDJFMQqmgtMa0a1bcpfelztqLtc/fxA/lD0C2mnSu/FjOUYctfeILNCx5gM6atwK6fXzd8GqbqSUhHaNXTleGx6jwIBWY3xrCSAx99RLsYOWV0hHKNxX3yngAaVfSQTqfni0z8SlRcHcq4ndHgI1j9SUNCF2rxeLllUfRRoB/1862YCPgRO5U6Lg0zGVq++GddErgmlWa1zBD9IybA1cn8Rdt1Ce60s9CDTOY7ROAJqft0nsHAWXJemUyjQS9CjY/LqPKbHP1OqYsejLSI8K1s/j/neM7UETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=pNkVkLMOh4nGkGeSEBnsg2tiGZdNVMalaUcpN+Z6sXpmcVbMljbN45D/W18o/J23OGVV+7ttf2TnEQ6SYY06VWgR2yGSTjNRVOCS1NowWnmvgSqjt9GmHFnDiPkn0lJLf0AgIWwR7V42eQj3NQpNNoOpkJwoyTw243/3zgbZ9KEZALEWxEFVTbe2cI0JPz/9RiJE3prcUa3eTNdFfwdj+ofk9/TYPpaiocKftcfF5D68K5PYQZrunCTgEX1SG0xv1ZCi2fYs7nqNeWnOsfNtmSCuuYqJ0Qkj+mcaLOVrcTVxEnkvahVHhPdN5kVgRAxFUfRVU8Z/rhB8PZzqldjgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKXsToYtlVJyQJxh72m4uHXpcNX0aF0OkedUdR01jQY=;
 b=muVym9pMK48kze+lPto3Prsgez062C1XzHfFSZPsc8j8005qkvZc08JUpu8Ld3WlKgxmMs73BXWqXRJj5QZsH+/GXFxvq1WSdFgXpiUjDG3b4aFwdhUv9N9nmrTDMpTOHsPZXLjejsDca/a3ylMx3vaBuPqbMCBsbKcpX1tvqi9op65Vw9yBqGRtVu/u6C5iSUf/w5PbqTf/Unc0mGMsbujHEf9GHvJyaGIS+nY/qKsyfgUJAaGi5l8uMhbUECCgHRY0sjX7iz/Zh23wZXxHWpB0Befe5o/oOam+jwr+KnHgjm9BNBsZHgFEZG5i+pbB9zBCsbBOab9FAHg+ggU1cg==
Received: from BY5PR13CA0025.namprd13.prod.outlook.com (2603:10b6:a03:180::38)
 by DS4PR12MB9586.namprd12.prod.outlook.com (2603:10b6:8:27e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.14; Thu, 5 Feb
 2026 22:47:37 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::ab) by BY5PR13CA0025.outlook.office365.com
 (2603:10b6:a03:180::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 22:47:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 22:47:37 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 14:47:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 14:47:26 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 14:47:24 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v20 08/12] virtio_net: Use existing classifier if possible
Date: Thu, 5 Feb 2026 16:47:03 -0600
Message-ID: <20260205224707.16995-9-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DS4PR12MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: edd8cdc0-9ea9-4112-5e68-08de65088f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z2B6qBbUge48GiPlGEDk7+Hg72q4dz+DYjx+Bfcf+tZOJGIbd0Il/BZXq70K?=
 =?us-ascii?Q?+6Froej3ky/L5HV4qJoQHBfKr/8oxIqn18/7AwDRWRQTE1ipnX9JUsn2NX48?=
 =?us-ascii?Q?V3xIu7cEt1OxS+UXkh6q7xlSUhkaNGLxAtBVyrqguzBRk+cysvLQNA4neMN5?=
 =?us-ascii?Q?2hZDFO153/eEGL0KTRza92chUXdiHDiQMrJSuZ6yRGdWyng/ot7ecc4Aaqu0?=
 =?us-ascii?Q?xakl1ND0inQqD99WzDDMcgEKRbcpOSCLb2gZoNqKUuEB8lpY6RgvLhM3qTkA?=
 =?us-ascii?Q?brFkq12jla6/PJSOtnA2Y5ALNXWi9ms9MQD6ZK1utyHSBm1q75CNFZr1S6X4?=
 =?us-ascii?Q?PvsCHP/2myRIhq1SBedaHlluxJbwD9GlnUv3SJ7mcWSNmPqkMYw8OjcMem0E?=
 =?us-ascii?Q?RyKUlX7h5l3mYBAu+BGkwqVJg8z80LbtqDobPfOE4HvtQmshkVbveXxrh5w6?=
 =?us-ascii?Q?6jtYWm+o47gPHaKmhMnCUclkhw+WdhNG99KjtWIm8ZkQWn5Bj02CCXfH2Bz2?=
 =?us-ascii?Q?rCbbJEwomGOYwXl5+MoxnAIKeOFn/HXBOtTuLJWhx3SjLd2zoVe2WBsY0RIY?=
 =?us-ascii?Q?IHYAGHjcIcOGIsozJA/aXyMTRzibl+z2of63iPyJ9udyXtD/OItGlMgMh3Lr?=
 =?us-ascii?Q?q6ikY5dvcAECdu33y8s5hqNDnPsPTl220zg7s/d8vJ9dYyw7DXUlIMj4+Tu8?=
 =?us-ascii?Q?6BDB1osc2Fql/e2pJCgqi3Od9FTEuysqysNT8V7EAZvotbNZd+5YyVPYDt6C?=
 =?us-ascii?Q?wS3w+cyV7ytSbqfRMpMOyK0gVOQsvF0C/yoMJlSifUSqI5nn6RAY2sXVhx+D?=
 =?us-ascii?Q?BRJFelAkF67b/LODq1MfoJKopvshVJ/CiAWiFfzAc3hWOo55Z7BzcI+FhgiQ?=
 =?us-ascii?Q?MaVBCgN1qw9ZdYzOQIInk18RMWMuNhuQPz/wUbQSrWOLrklYxXDEFY8Oboi9?=
 =?us-ascii?Q?/qFPINdmzlIs2tBZI7e7mP3fWxvIPfBgXf3IPH6b2KFDvhWie65Wkcwq0SUe?=
 =?us-ascii?Q?BujltNwGceziXjhaJGdrxpvK0qsMQ5j6F9WiL+oPGx0VhjMD9tI142+9pWuh?=
 =?us-ascii?Q?c+YnulNmAh8FAckOVtAuW+088ABUjv8iKefIn/zDsnoFAEg42L+NJ3Pcv0Tz?=
 =?us-ascii?Q?TEFmy1gZTyjfAn5DvrknhQGh7z8bjwxLrFJqPBuYp5CAAmLpbt9qdSoMpiFK?=
 =?us-ascii?Q?IcWR2i1EzvHibVGQcdUVBPULlFf898rJhXXgbX4DIRDHJgdVkA0fnLXTnGJx?=
 =?us-ascii?Q?YwAFJLqObvL4f4uF0sT0VZUXrkkIAgO6CGDpK7D5iVcAjwQ+5bQPHd75w/zq?=
 =?us-ascii?Q?jiSPczCchcQ9U6mT0qy3dNTCF7GykD/RGT2NJiLpKk4V/REKBYb+Lm8k/rbt?=
 =?us-ascii?Q?4JjkmVdRLWSOMsPodhaxDgA0OjWgeeVfI3iu1DiMxA/F61XiALFdj5fc85Y+?=
 =?us-ascii?Q?d8HnkNoLTd/zu4lOH1WZKr6Pco4B5Z7im+Xo/uCsaHXaWmxmsMML2jilegoQ?=
 =?us-ascii?Q?2HoZ/BqONmh3uz22C7N8L7oYWc4XujlfUcBHL8/L9u5nN2bnFiOBTPtd+n0N?=
 =?us-ascii?Q?niCyyI73u7pKn5/rW2A1wqJemEndbglXzTI9m0Rm5BIzn6pz64Udq9jn7PTI?=
 =?us-ascii?Q?+E59FnXMIVEqKiwzC7OmfA/2xHktrSefBOLqoe6e1f7y731H9+wko92BxR4b?=
 =?us-ascii?Q?J2c+tg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I4rSPPWhfX420kqJg+iaZe10pYoCUmnxCFBPThYFRoXfBUX08KEbxIA75BXu8OwJyiGYS+Ff6u9Q/A43BG0RoFeH+hN0snHhCQqYoeaoLeJznOsQhT49b2rxk6xEDrdOIoTZtudWJB8JyNlAlaNn+LSWiJZdVjeLenocvx7Asf51qbgvZp4kIwRO72yRP19iKFZ35aWJXS4JO7sztFLjQXxremDji3BYvPU/VuAHt08q7ASNl916voUVorIQa7JIsjuwyysSO7XYpIpXVBLHxlWq7BVFokav4GfQH2nabYHXng/NoxN9Ah/+KJuEjSLUFQWiV2y1g0I3SOsAtRZ2IzdYbu/7KpwBXSE5Bqp21ROVKkTqgwwdCwgS2Iw+X97+o7+98sKQpqVcU/zl1ITuqwkDDQQMDTJg30B3DYWyCAaySiwxouCjTshjC/iuy+59
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 22:47:37.4833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd8cdc0-9ea9-4112-5e68-08de65088f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9586
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257354-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,alibaba.com:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 44BF1F8363
X-Rspamd-Action: no action

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one. If duplicate
classifiers are created it would artifically limit the number of rules
to the classifier limit, which is likely less than the rules limit.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
v4:
    - Fixed typo in commit message
    - for (int -> for (

v8:
    - Removed unused num_classifiers. Jason Wang

v12:
    - Clarified comment about destroy_classifier freeing. MST
    - Renamed the classifier field of virtnet_classifier to obj. MST
    - Explained why in commit message. MST

v13:
    - Fixed comment about try_destroy_classifier. MST
---
---
 drivers/net/virtio_net.c | 51 ++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 27833ba1abee..5cbf26d8f7ad 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -32,6 +32,7 @@
 #include <uapi/linux/virtio_pci.h>
 #include <uapi/linux/virtio_net_ff.h>
 #include <linux/xarray.h>
+#include <linux/refcount.h>
 
 static int napi_weight = NAPI_POLL_WEIGHT;
 module_param(napi_weight, int, 0444);
@@ -302,7 +303,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -5740,12 +5740,13 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
-	struct virtio_net_resource_obj_ff_classifier classifier;
+	struct virtio_net_resource_obj_ff_classifier obj;
 };
 
 static_assert(sizeof(struct virtnet_classifier) ==
-	      ALIGN(offsetofend(struct virtnet_classifier, classifier),
+	      ALIGN(offsetofend(struct virtnet_classifier, obj),
 		    __alignof__(struct virtnet_classifier)),
 	      "virtnet_classifier: classifier must be the last member");
 
@@ -5833,11 +5834,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
 	return false;
 }
 
-static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
+static int setup_classifier(struct virtnet_ff *ff,
+			    struct virtnet_classifier **c)
 {
+	struct virtnet_classifier *tmp;
+	unsigned long i;
 	int err;
 
-	err = xa_alloc(&ff->classifiers, &c->id, c,
+	xa_for_each(&ff->classifiers, i, tmp) {
+		if ((*c)->size == tmp->size &&
+		    !memcmp(&tmp->obj, &(*c)->obj, tmp->size)) {
+			refcount_inc(&tmp->refcount);
+			kfree(*c);
+			*c = tmp;
+			goto out;
+		}
+	}
+
+	err = xa_alloc(&ff->classifiers, &(*c)->id, *c,
 		       XA_LIMIT(0, le32_to_cpu(ff->ff_caps->classifiers_limit) - 1),
 		       GFP_KERNEL);
 	if (err)
@@ -5845,29 +5859,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->obj,
+				      (*c)->size);
 	if (err)
 		goto err_xarray;
 
+	refcount_set(&(*c)->refcount, 1);
+out:
 	return 0;
 
 err_xarray:
-	xa_erase(&ff->classifiers, c->id);
+	xa_erase(&ff->classifiers, (*c)->id);
 
 	return err;
 }
 
-static void destroy_classifier(struct virtnet_ff *ff,
-			       u32 classifier_id)
+static void try_destroy_classifier(struct virtnet_ff *ff, u32 classifier_id)
 {
 	struct virtnet_classifier *c;
 
 	c = xa_load(&ff->classifiers, classifier_id);
-	if (c) {
+	if (c && refcount_dec_and_test(&c->refcount)) {
 		virtio_admin_obj_destroy(ff->vdev,
 					 VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					 c->id,
@@ -5891,7 +5906,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6063,7 +6078,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6073,14 +6088,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_classifier;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		/* try_destroy_classifier will decrement the refcount on the
+		 * classifier and free it if needed.
+		 */
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


