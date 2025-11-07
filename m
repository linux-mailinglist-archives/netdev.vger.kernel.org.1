Return-Path: <netdev+bounces-236623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6174C3E6E1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 05:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F33AC7E0
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 04:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A702BE7D7;
	Fri,  7 Nov 2025 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FAnIS/Hu"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCADA231A23
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 04:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762489006; cv=fail; b=oOjAmSQYiAaEG2XDGmc2Tas2GmnI4jy+XWyHWaggUDBD7iT6jskL7IY19osVPiionNJc4hj2PsZ7J7VBHLdKndA22uIecas6OajgGbeO8h9mUmaDkZRti0mszS+q4drG93vLtS6gs2sbQjlk4PCZ/mbM+Hg37rrIxHSZKpioAA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762489006; c=relaxed/simple;
	bh=5pjo7sF9f3GY2NsvwUEU1kJ7RJo6V1Fhw50heBHE1ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8tjpO58gtueP/8/9LyUc22Lnu4maq1S8iB0SzJXOgvausriQtVuvE+VVdQMhKLctS4LadPG2Zhj89AjLN8azHtBQ8jMRm6TIr0TC8S4lrKQ5uYVaSZz8/RCMjvc/o40WZbJ+W2UM63p47F7r6ocR6SdXN6WlXL75joZx9YyusY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FAnIS/Hu; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uz/+wNdfXwBj4ffg8wyt052h3NmzNkcmrLJl92JNY6wuLgOSALt+QN+QyiGuWaTt0uS0eTGDPtpmKipDLtnj0QIqy7LO60pgzhBk8HKJg1iD7JWl2qPdGhFwtoscnyajRdBTq+JI91jFzu3wT9/xuvcUWDDrSNCOxYjZg+ebmt1Z8fCLGbI9pK4iyAd3HfcJS70y2Dqvg5c+pSG6T3Y8XCLhpLeUfjOsR/pZ3MBMaitH39Z81Nxma44nQJCGlXX7rTACjzJWwyDqlugqJRooLvDlXMR/XNh1TqZOviFSVIvAZj8G3pg8pCumHbiHBNa4TYup/8BGMRJ6Ur8gZPt27A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShMzyarDpc+gGOpDXPv47o7iMuAlCe2KmIYG81/DF8I=;
 b=yU5WwDpicFmTFJd3bl+pS2Rf7KHVHUjJkTlc3aMY374XE2aOxFGEW9XcO7uJOoC6P9IALi8t8HlOpjeaAHwH7GwKS3BPqHKfff+8DSHIiQcLk3bEo/cmwZt+SO+jc69F6mw+HM+1DCB4ZxcEpmsTxU/YgDNrkTgxH75lWLUgMak10CwUlRF4ghnPcZs+L8ne7TggVf/jDLyJPcjLFW5JyLAsfLvpPed7x0wBG/fY866Y6f8RKGiBLNAJkISiDSOTy9YN7z8TQH02UxGpEHwr/MZw/3k0RWDAMjU2vZFI/i0ic5Ck8mL6kuGaw25e1yFVZ3YcCcieIygPiqtRZ+XWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShMzyarDpc+gGOpDXPv47o7iMuAlCe2KmIYG81/DF8I=;
 b=FAnIS/HuyvyZzvwUX2H6TDYeSjBNL0m14qrPtdVbHx9OLdyR0jkEFSR6HIcyeoMGWbsHkfuSmyP6Zz/pZirJabLzBkdvwj0urRHRGEb4G/4GP4QqmC8F0UmYs7LHwPtacXOaMtMz2Sl5OnD9xerArulhFb3ekhZgX6sWJHtnAgWjJrMSFNC35XLPImjpai3uur8QhUcsXvkcZ8Sk+DUEfGZxQVuoFpeP+v0ByV0/EPb7Rq1hEBP98WCWB3rOpspny31tSXIfpu717FFLtKWLdzY+L7nLnwSZv66INlJ5/slk8C1L1rClEtN3JxFpDBRGTJNX5l3f3cUIM1KnrzGMog==
Received: from DS7PR03CA0353.namprd03.prod.outlook.com (2603:10b6:8:55::13) by
 SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 04:16:39 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::1d) by DS7PR03CA0353.outlook.office365.com
 (2603:10b6:8:55::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Fri, 7
 Nov 2025 04:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 04:16:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:27 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 20:16:27 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 6 Nov
 2025 20:16:25 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v9 08/12] virtio_net: Use existing classifier if possible
Date: Thu, 6 Nov 2025 22:15:18 -0600
Message-ID: <20251107041523.1928-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251107041523.1928-1-danielj@nvidia.com>
References: <20251107041523.1928-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SN7PR12MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a0598d-52b9-48dc-f778-08de1db4730d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HGBdUTdu/hUe/+BEJPhVgZcFp6niJgZebqH5PjfzIdBtRJxk5W0glBTO+7pD?=
 =?us-ascii?Q?xUoGf+aqdVbBG/IZuNjGLgz0M+E9dTn1CIsQAbNCjnVi5SwYAJJI2UlIHb2j?=
 =?us-ascii?Q?4CXALqQfmpVqVQklPNgu//aeuW35mSOQo51BTw2S1TNrgR1bMfGbVEHtDCFh?=
 =?us-ascii?Q?xXfeBlMhETA20RVlSvhMK1jrNNbt96Z+BqCRhNgv0P/FQWFT8fMHqDr08DIq?=
 =?us-ascii?Q?iqkZXIZoLxfbA0xBduHSZi5OU+8CKao7srNGF8J1z0Sh/Fl+ZvAr2UrH6IxW?=
 =?us-ascii?Q?G58eZ+zUC3v0wibeIE5G/eyL1/qkdUqsPjKorxXn/JXwv/uIf8ZjG4lD/wCY?=
 =?us-ascii?Q?nlze2IOhcRwqWKYIPNEi9rmi25cjaDbkLhc8KQzPgytOX/yY8oY8VTqoRMqz?=
 =?us-ascii?Q?jd532z5FS9t2UqJJeMkdtjH3Hql+3Uw0FfTY6hBfAP8LEbgRTH/SXLquyj14?=
 =?us-ascii?Q?kNSbT9CbEumlYqRo8U6UGdXtFs0R2RHnwjaQYPZFj/BvBazNUvDPQsLKu93o?=
 =?us-ascii?Q?x116ZHiKMns9eZGxnC2bWAXWHBgqPH9uBaqz+CMt3NzLQVqcEbTzoEpGgryG?=
 =?us-ascii?Q?haX0fI4VQjFUahON0lkw0AbkUDRwOLz21SrKRScsGXKOnvaaCBXKgg8c2yMm?=
 =?us-ascii?Q?jGn8gWhSesqVrSPaooDFTV5Nnjlqm0LsOQrMQMZzBz/LZr51QEmEkpnjfMgF?=
 =?us-ascii?Q?SZY7JoP4fWAw/4MmuRQuCv2HlwejodtOEV+IvVVMoxIoRwYkCKtG5m8xa3RN?=
 =?us-ascii?Q?OQj28cFoJFJV5Ni6mJpn4QYjgv3jwipxkIJdyXjdMrJcGivdCCQ4YXtxTuPs?=
 =?us-ascii?Q?3WRYzBpMCMyKTHyWE4uMLSa45KGX4gU5R3nNCleDw2ZW8suInspQHoDyzIqV?=
 =?us-ascii?Q?NMmn1k+9nTIrQ9LRQ0NdAMZkEdQ6mn/gi044J3c8V5qskIsHAOmQRSmlamXd?=
 =?us-ascii?Q?HDnGRUlecR2TYDwQr8q2bLriNqpj9J9y3ButOX1ApZdKrbV3QsYPDdTQ0aim?=
 =?us-ascii?Q?PJoSzUO1MfTLvkM3tydpypDvWMGrg3Lj6qIVSk0DnUuyYWjALwEoJJMxfZjS?=
 =?us-ascii?Q?jNiJPaiqcZTUDvRc+/0PuJOJFVQOOx7JJ+829Hw6FjkhW8Otgp/aQR8yDyzd?=
 =?us-ascii?Q?SbVmuUdXlSGl3E9GoYiPcJbaVZ0tNp4g+wLXVnVnXMdpgCrfoYBmtzaduxBN?=
 =?us-ascii?Q?5gWVc44kp0x/J125HVMJKbGCjwDo/ydWdIb6lZv3FqqvfPxx4eTdldkfqRwI?=
 =?us-ascii?Q?xHyc2M5W7DZdwl+MH7JCIrqGeSmhARnr4FTdY9rL3rkSquiCmQy1rufDqQGg?=
 =?us-ascii?Q?cgRvDH1QaFwacZRSbtuS27uhDTJO6sok+S57EqSIym87cLqmuEpdSPQeKVlA?=
 =?us-ascii?Q?BRmzZdug4LcpTDm4Fhdhd9VcV/H/flMhfGql+acyF0InHYwvqO3e5S5SjBYu?=
 =?us-ascii?Q?R7OrFX7yXPt8Grq+YLjVh6nj/AE1DdKA5a9Z8TTjCcrxVjNpUxwzVLltP+aT?=
 =?us-ascii?Q?o6oyWixjwsH/CZVDKd6BSgkqvevFGdP2Zx9VokuoXyXcbFA6j0p9Mg9Q3OL7?=
 =?us-ascii?Q?G68ha0nLt/zwoptP+6c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 04:16:39.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a0598d-52b9-48dc-f778-08de1db4730d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6837

Classifiers can be used by more than one rule. If there is an existing
classifier, use it instead of creating a new one.

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
---
 drivers/net/virtio_net.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b2539829b126..7c29fb41a668 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -299,7 +299,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -6811,6 +6810,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6904,11 +6904,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
+		    !memcmp(&tmp->classifier, &(*c)->classifier, tmp->size)) {
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
@@ -6916,29 +6929,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_admin_obj_create(ff->vdev,
 				      VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-				      c->id,
+				      (*c)->id,
 				      VIRTIO_ADMIN_GROUP_TYPE_SELF,
 				      0,
-				      &c->classifier,
-				      c->size);
+				      &(*c)->classifier,
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
@@ -6962,7 +6976,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7143,14 +7157,14 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
 		/* destroy_classifier will free the classifier */
-		destroy_classifier(ff, c->id);
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


