Return-Path: <netdev+bounces-220887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A77CB495DC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 18:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2E53412DD
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB53128AE;
	Mon,  8 Sep 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bx8cnGol"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50D311588
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349798; cv=fail; b=bf1xOjbhacNRq2wxHI9EkfsnciDSeRMm1V1AuhmnFJvf8FEXRlQG8xgaOZEeqHQmHv6eC5dvVdyU+zIGue/mi9xdwi15vxKEuckm3HZwJ2vcT8Sofr4fIJ1AxcaaKk1hMwezGbJST0PEDduLoBaj3pRxgNkTEqe0vCMV3OmN/PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349798; c=relaxed/simple;
	bh=IKrOB4324136g73H/bUS4lFkZByacqQ6LSzoWFXNwmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZIWts7irj9ebAjEn1J1G1e+TcznFdoMmJzgbHRHRh4TwVaZ2btkwGYi4BmcT6OcsOcXwozoeAQDJHbdNonSYZHC9Ed7PDhv0fd8a8D1QAwcQSFQVvzTSJMRlm3SmDzOOUTJoyMu+orRgdzdtjQeyrPLTZoN4v1qMHhHwiIKazE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bx8cnGol; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5JpTdRFCby/gX6IRiHi/DrZc8ro6i1tjK8Zm1v3uxMLeSLhH9zIfRftN7vQbInofVub8qDNSKq0d4XZkqINaxA6AI9KnldXf5trVYx9jZ5Q15x21QJTtYmjCtQu/rdwUcionV0D9SDG5RK5V1lzY4PGyR94c0ndZc8gS+en5FQbf6NjwI8uED6mni60C5DJb5qC8JB/aDtxoS7K3LIBnrPeNnNcBqdD6XtdxHrHCUiv9QlJyZHyagaDX89Fe0uEjwqL+ZMz6rfYHQx2CmWqgfY2XfTbr620ilbDUdfg9BrGLZN+/PByBJLPD9bnT0S6XGCeOLLgHEwIrfuCOtKidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAtZ+bBGPjTgpN+R+AXFsmrRJsgz7OiMlWdN4EIQGvo=;
 b=WMePeoZa5gdDOuZm/rrvfX+5pJ4iQEyt1kenP8asoW8Qk2QfTWqHGnu1GY7iwAMfDmNpL0oN636/wrNQyPziEKsAh/DA7J9PKItTjaf+kQfhP6MhrleXBzgE7pdO1Aupe2cec07jP0SzWJxTPHLRr/0kBdEC7MKh6DkLG6yrjNHRmP77sIhY0dk6Ktu79ooFeOsWqafQnNYOJbDYM+4TQ4KecyTvcDci/D+OvYvyIQM2os+1CAXcMgOwMtW+2G6hsfryQ15iY1Z+yoQQz1ABroLYaUwtMyq/CjCKbZz6XAXTTQfjrkTmgRPCdaltMg9A2DgUXioypsfIZ141P/xvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAtZ+bBGPjTgpN+R+AXFsmrRJsgz7OiMlWdN4EIQGvo=;
 b=Bx8cnGol7omyF7uUhTmuMV13Macy0EQBk5b3Lv7heF+RFUR9bdesHET2ccv1HG6eKiSG2JaZXll2nrCZBcnzaFYNVpZj2FlCvOYGY4LDYBgCJAosZyl6oqxM9qoxbfiiiuh61+dTG4SVV8c7ni6x2TqM+HHQYaL3cN2Jdfzb1uw3QLtbmseTu+p73YpXyEUaxivfK9oXkpM7FLEQLkEWjKWDvjAwQixYZsHmSNOoFRjiAChfQ+XC68A0EsL+lhj2R6cOoOus+7nqSWg18/gf+VWC7pKrCMR16+J4SlefmNHbEhX7HUl9yvtZMNNlRXQyEdW9CSt6r+87v+wg0jOiDA==
Received: from BYAPR02CA0047.namprd02.prod.outlook.com (2603:10b6:a03:54::24)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 16:43:11 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::a7) by BYAPR02CA0047.outlook.office365.com
 (2603:10b6:a03:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 16:43:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 16:43:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 09:42:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 8 Sep 2025 09:42:42 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 8 Sep 2025 09:42:41 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <virtualization@lists.linux.dev>,
	<pabeni@redhat.com>
CC: <parav@nvidia.com>, <shshitrit@nvidia.com>, <yohadt@nvidia.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v2 07/11] virtio_net: Use existing classifier if possible
Date: Mon, 8 Sep 2025 11:40:42 -0500
Message-ID: <20250908164046.25051-8-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908164046.25051-1-danielj@nvidia.com>
References: <20250908164046.25051-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd8c38f-9f46-4455-ee0f-08ddeef6cc38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mjn2ep2UagH5ecpKNSmY1QApVmMEwWwjcreINeKu6LpydMEQWDoL7/7uE7nE?=
 =?us-ascii?Q?RLSS5YnmAujXhR7G0LK0H3ALRasSYZQkPwB3j/SLdGePluAif94ooEcN5KJD?=
 =?us-ascii?Q?xGztvBnMH60udB5tlGbD9g/Hf+7cROagpj4q3rc6gYPZabm2FoUhkiefS5sW?=
 =?us-ascii?Q?+BWCvXuUNy7C2rG3AzA6lMH8EgOcCIvYwu8onafkN4UPFglR8HCbi5/hZdUK?=
 =?us-ascii?Q?cFuVIiF7KWL9B66XFmnBbDhy5MUCqcCszhyXdYubfdWjBNw7n2LPJt1Gmq7f?=
 =?us-ascii?Q?RXYvkEpuDMetvtyQUBsldTTxuAYBEQdj1sqrbuPNMGg6Xv+A9nUb8acCg9yQ?=
 =?us-ascii?Q?MPFTZanW3d4thxWa7dhbIgRfpIToCMLoHZDJP7/wpM2ou7GJNcAzE2uM1PXZ?=
 =?us-ascii?Q?2ib9wXezn2aUeE7J8CnnRKgSZZTecqtzmcXFYKILxaBSltqzzpttoSvo1+bH?=
 =?us-ascii?Q?z2R8h0HZHiIDuRJvGt6Ja/CKsVy8Heywl8oWGUuGhh7hEG/u6qyor+Adfifv?=
 =?us-ascii?Q?tR2D3UyGiltlU4tCXK4FhAY6v2EtFT/qIF1t4yL+Ul5niTE3apaykWCqOjmA?=
 =?us-ascii?Q?dKg+vNMzeEpeLo7EAlGAWxzdphMUSq24M+mddtN+aRHwirxRoNQUziLbmnTp?=
 =?us-ascii?Q?HALIoN3yCljPvGdBA5iMBxvBM7kZjMgtxQsy6fi58r0Epf/EU4ZPwvyabgmn?=
 =?us-ascii?Q?UdF/GWwdqYqJieRGrwH97KvIJEFYcHv4f/ISxuOKwOL8c6+EyDH1TCsRVb6i?=
 =?us-ascii?Q?rpQ17KwePPzUOniGRNugivCOkaRrfixc+SBH8PHDHoM2meZh6iqy/VwVvkvl?=
 =?us-ascii?Q?aioOiYcqkJb/CD1X8BX80hBSdERG3ls6nzuxgagIRK7FOK0JsIJ59XIL4yUU?=
 =?us-ascii?Q?lVaAvy3JnvXNqTxZmR6XV/YOWkSkvwe1Run3GCRdJg78vlGa7xAxdIHNJALs?=
 =?us-ascii?Q?vCuP1RXkim3ABTQ6LjTi2p9y9/6yCF3fJAtfIZfDhbgsvq1Ch3tkHFxEw+Md?=
 =?us-ascii?Q?wPhYF96HKUwqvQlmSeiLuSzCZI6m+/rDN7KG3+5ZgCxpN8hZQmP6znwyJXA+?=
 =?us-ascii?Q?8VGsZid0LvmNwvBK0CGyPWkN//E9dSSYVoGyWI3V1YUOdqFFQRtXptvEGbto?=
 =?us-ascii?Q?DIYisqo4k2OIt+l0hnKByFnMyH15wc3btSbDKRW5Jtv3lVWlVDPmls/aDNuT?=
 =?us-ascii?Q?2s/U16gPHSnVKkySVQAxya9o1klDOx3wGukyP7xd6+ei/8i8JYWW1nGrnMRn?=
 =?us-ascii?Q?LbQJ/6487k3v4zevod0MCTeAFVD0fi270OjnG3cs1UkqhXBL7cTuFtGaNqR4?=
 =?us-ascii?Q?uyvFiejELDXOGkL4+jyQupalAuUlRVJwTgSYXmNP28iWV9zvG0IKNkltnHaF?=
 =?us-ascii?Q?s9iHsDPN9zHIR928pyXW9n9r3HE7rnoCWA/LhZl0PBIiBRRYN2U4xbdal0DG?=
 =?us-ascii?Q?EuABRTXmAFlLZD4xHvsEgSBt56KfV0kj8EQiqRWrS03PEaHWzfTMObemR/AT?=
 =?us-ascii?Q?r+k2WgaxfBFyo64Rv0xnUVUG9XKdNYAlTTr+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 16:43:11.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd8c38f-9f46-4455-ee0f-08ddeef6cc38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

Classifiers can be used by more than one rule. If there is an exisitng
classifier, use it instead of creating a new one.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
---
 drivers/net/virtio_net/virtio_net_ff.c | 39 ++++++++++++++++++--------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/net/virtio_net/virtio_net_ff.c b/drivers/net/virtio_net/virtio_net_ff.c
index e3c34bfd1d55..30c5ded57ab5 100644
--- a/drivers/net/virtio_net/virtio_net_ff.c
+++ b/drivers/net/virtio_net/virtio_net_ff.c
@@ -17,6 +17,7 @@ struct virtnet_ethtool_rule {
 /* New fields must be added before the classifier struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -105,11 +106,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -117,27 +131,28 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
 	err = virtio_device_object_create(ff->vdev,
 					  VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
-					  c->id,
-					  &c->classifier,
-					  c->size);
+					  (*c)->id,
+					  &(*c)->classifier,
+					  (*c)->size);
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
 		virtio_device_object_destroy(ff->vdev,
 					     VIRTIO_NET_RESOURCE_OBJ_FF_CLASSIFIER,
 					     c->id);
@@ -157,7 +172,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				     eth_rule->flow_spec.location);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -340,13 +355,13 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
-	err = setup_classifier(ff, c);
+	err = setup_classifier(ff, &c);
 	if (err)
 		goto err_classifier;
 
 	err = insert_rule(ff, eth_rule, c->id, key, key_size);
 	if (err) {
-		destroy_classifier(ff, c->id);
+		try_destroy_classifier(ff, c->id);
 		goto err_key;
 	}
 
-- 
2.50.1


