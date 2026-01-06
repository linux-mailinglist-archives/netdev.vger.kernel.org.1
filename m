Return-Path: <netdev+bounces-247400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D28CF9757
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D9D7300FA3E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860D93358B8;
	Tue,  6 Jan 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h7xA9WIk"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E001628640B
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718323; cv=fail; b=Nm7YygF9Qml6xe3TX5zBe8+IFrWdmACyhgU2a+0unCNHwff8pL7KO/FrH2aqtIVdy0YJl6JqsabjUNHxCAAF0F2MthbNuEomQulZhwZTrxPMSqddUDvWbAqqqZLUAOFbUEBPRtVfaWe1iBmyA8dsWTgM6JGK1+rsaE7q2aBF3Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718323; c=relaxed/simple;
	bh=WEEHkuk+UmJLiCJK+8Hcg8dNxxP2uiltP2ymk/ZHqAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeU68nt/oJ3IznFTXJurReyTp3OBcqc/lvFHBgXbZ2qd2IKahdDc5Q8YNa8k+A7lQUED1l8OEwVeCL3u4qBMMFJ7Rpv/3i83qxw0zRXSjUxjhXFw9aFrFtxUAWhAGnXUg0/EW6jYzSOcn3wZx0/ebsVTAMLeUKiRXBTwn/tzlSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h7xA9WIk; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Apl90Sg0mGcZ1lmHyyKsjBMzuK8Wy5QMr5aLR9Nnv/YkMMbXdfdlfxm+9EveDiMMsuUOsWCfBNMAe2+SMvFK7G4189I23mculp9IkA0NdqEeSFB5krz1cNbz7qP4qIJanaQ4/rQpI2F5wp8ZAdr30U8VKELhpFzIm0MfzyrwNFOMGvGwU2XYhmz1IYVRC2+WnX+Ub7YQjDOAsFRSxB+O7SEyDT+dVEB2Do3/bbD1p8MVxiY6jKl1HK9+mvbUTQzQn1AETVO0o1s5ENBQS/dbUAMk/8cAPvxsIhG48Qyr13DdJzScv5ZO6Xxf3QCp4j/NDzM1ZmUsumHdytcwdYttVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEh9UL0u2d5527Bd6OclTZnebG7m0RliPVixInQZy8g=;
 b=qAUMgw6ORXVUSaR7emgsln2gRHfiesXR/LKgUR2tDagBcy7eTpASDBVGGwP0nJzUs/lqwSpBCOvpK5VWWjgKHwk81/lq+VBKl5Kj9e6GTj700j8FV4AVmSZPbfB95ScRLsDZlZ303qQ3fgk3/i8WgNigm9BjeE9tvh0LnzzGU2smhimriIP98dVw62mRPEs23D+6adv32EvPMqfToA1DxJcDUCCuJ9eocRbBkjA3v2PKpAWev35TSCZuPsI/55M9sGSWK6FAFQNtKF5dxssl+yiAj58LG6hB11yjtQZsTKQdXpeD4Cehbs9mAvOVFzJHQABFaL3/BAwzKR+Au+G6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEh9UL0u2d5527Bd6OclTZnebG7m0RliPVixInQZy8g=;
 b=h7xA9WIkV0bR/ouAf5TgWbflhXMq5S2+jEu14R4elHRr99arn1EXR7RlxhB+U+FXSwCDEk90Nn9CpOW7XZ9WXuHDUizPvENFqHZH/nCPiDw2i/H7jnKFcBA6Efd3AuWoZoZiuDygA9dwtZi13r2a9+WojRM7/3LVdSExGGRvSNd23jv4y5Zav7Wcr762dSS+qImfcpwa+yLkEFacjjLejh+YI6eCLpUQJNi1eWvB4JPalZSRqfEcHR9NigmcY6KahTbbSQ0OwB/FuACs4dJG0vp55zu5BTwV2laK2m6Gu6wG9W94m5zRlB5oR+gV4jKEtsrcnRrh54xWgaEIrrAWlw==
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 16:51:56 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::5c) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 16:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 16:51:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 08:51:38 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 6 Jan
 2026 08:51:37 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v14 08/12] virtio_net: Use existing classifier if possible
Date: Tue, 6 Jan 2026 10:50:26 -0600
Message-ID: <20260106165030.45726-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260106165030.45726-1-danielj@nvidia.com>
References: <20260106165030.45726-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c6a76a-4de7-42ad-7767-08de4d43e6da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GcOoWVD4Q+LMXDEQRWIXFEXATBa3o1HUhoNHJ5WRkkXofDKFeNRxsxX31JwX?=
 =?us-ascii?Q?pRoEnA+rzWEOvhv4I1CYkD8g72VkJzILcBrPwk9umGDnhEqwcyi1i6ZSz+Al?=
 =?us-ascii?Q?bTqVLTnuldYNCOQB0WJ32KsvGPpfaJIGX0XXlUvz6rlHKncSxmRYV8BZICFp?=
 =?us-ascii?Q?N8nS2tNsC2SRhD4C8HR75uleqlNRV5qZzMxTd8aaczF9cv6sZHsmgjGYYr6n?=
 =?us-ascii?Q?ttEA5R13g3gGXV+8KktBdA4RjR06UeU2s7rIMuZ5xEmj3QJElO7odORAI4Hz?=
 =?us-ascii?Q?PDiSTAETVzNuCFi1RqAXXH7KEuriNOHmI8vh6PwE7X0zYlo+RJqr9Hon1lDQ?=
 =?us-ascii?Q?tLac+nGKssarQhDAmvZyIyINMLIDqjmpfLe1Ei/1nCfsgp8khD4h2E6eQhJZ?=
 =?us-ascii?Q?VE56kSHQprVo7X5M2P5qlZBtIY6Noku2Xwh1KqFBMBouzoYUdNnEdjpbnPJW?=
 =?us-ascii?Q?Wex8MzLH6bq33gzoPpXa/0heeq+oWrk7JANlKYwKt6o9t8i6Ce6PsFXrF4D9?=
 =?us-ascii?Q?r4mdfAFluJVYvwRczSHg3lvxuTcz9vXZhguqE7KTNyhIvJ9gE4UJB0WhY7l2?=
 =?us-ascii?Q?jWYE1JFyJ/FZca98+Kvn/fwN47Dk+ZRUyvahcIdNJA34kv0WTay237E0b4Fn?=
 =?us-ascii?Q?RRhmNpDeQGYwpKxjMPc3doHUYALF4gpJ63MGtD1AV2kEJs/nfVHBxdJTD/xb?=
 =?us-ascii?Q?4XhalI2pE/VArArstiiZl7f9/L115p8NIRpPGywQWBU53g1j3F4En6aZERYu?=
 =?us-ascii?Q?2JnKNh5oTgmfLcLfqvZEWh6SoWdJJUoVccNjposJk5w7jkcnSBxT+4i073ZD?=
 =?us-ascii?Q?PMDmCS5sBmSEm2k+2MkdHezLjY3Tx8FBHEZcWs/nb6zuhDR9CIA/P1qD70FX?=
 =?us-ascii?Q?+WDFscbUc35t5gWfcn2/e+A7HrogoIj3v6SUe6jEN1uZguI1By4ylzpK6Vhb?=
 =?us-ascii?Q?6rs3uvGz/bhsD+9UP+hx+j3DDqqtFpKvWUSg58hDhdrZoOWuchSkuo5rmtcs?=
 =?us-ascii?Q?FellU0bDdElzQo9DdC8JBawt8pRUHOyX4c/Vgl20YhOU4S5pmRcULhB9o8rD?=
 =?us-ascii?Q?gNQiFD5ueyyczLRzun/f0qxmO6FrGzJW2WdtuXbGzFEZCh62riAjVwBGOxEy?=
 =?us-ascii?Q?uimEBJTc+LLOSExPC6AlXCgAY7zxLb3x2YdZrL1YtmjX113wlSSOcKxUYSSZ?=
 =?us-ascii?Q?qw9NuwRqyALt+WtnetrCcR/mgEev65IMPgtwAcAizFutozWljVMECDou787+?=
 =?us-ascii?Q?LBOnnJvrdBzY/0dlic1QGijDv9l+fSmatEqlC/p//A+7w8zsSZw8lly9H+Q4?=
 =?us-ascii?Q?ZBJWG9KUe/AIJd2gxrW+fxWBWRZrF8v4etDNMeatxzE41LeoJb9MAjIfT5Jy?=
 =?us-ascii?Q?ybqGMcyjIvEnOmi7UMDi9n8Z5kx/3Qq8EEMpXQsLm2+Wi+1VUH91kA6J41vC?=
 =?us-ascii?Q?HAivZAZDbQbDFDxDZqG/GB9Sexfp+j47y85KdI+bhDUGoXQcWB01Z2+rgWdS?=
 =?us-ascii?Q?bVnYKCyGUoUkQwax91fshvWJSBrY8AALlKbsBuI+sfw8A3M+ktFPUT0apiRr?=
 =?us-ascii?Q?0co9VaGDrTF85na56Z0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 16:51:56.3059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c6a76a-4de7-42ad-7767-08de4d43e6da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

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
index 5194596915ce..8bb90de377d2 100644
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
 
@@ -5825,12 +5825,13 @@ struct virtnet_ethtool_rule {
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
 
@@ -5918,11 +5919,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -5930,29 +5944,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -5976,7 +5991,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -6148,7 +6163,7 @@ static int build_and_insert(struct virtnet_ff *ff,
 	}
 
 	c->size = classifier_size;
-	classifier = &c->classifier;
+	classifier = &c->obj;
 	classifier->count = num_hdrs;
 	selector = (void *)&classifier->selectors[0];
 
@@ -6158,14 +6173,16 @@ static int build_and_insert(struct virtnet_ff *ff,
 	if (err)
 		goto err_key;
 
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


