Return-Path: <netdev+bounces-225639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E52B9631E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8145C2E8075
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FF22561AB;
	Tue, 23 Sep 2025 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ba5zjqlX"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEE6248F58
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637208; cv=fail; b=BfNUF4aI6NkdfUzdF1XEyaOFllhlSgQliLqvbgM7KJrfUnQkUfdfmWihSsZbEo2lXRijuB2Um1Q/ustQKT7FgT/jnvdPfqfIkD35SUMSheXObzPpNaygiFBTL9zJzzf5CSN5YcDktv5xQtvP1GHycqrL2+9h9GyrIAT2Eomh53w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637208; c=relaxed/simple;
	bh=ODvkm5CEpH6U6EkzgLi+jnWBGcZ28576HmH87H+JXSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWjB+WQJmJDK0crsuksrEaVq1KUzevNcR0aAC45KUT3QacLcpvTOXzrjK0Sgumj9CByRNGauSg36oz5937A8OK67yfOsFPA3kNFHTOP3bY2IhdUSSpW6W6RyNRUGtX5YuPvaaCUEXLQUsKoGs1xzI5UJXEsbmPNQ8lqJ6Z3H088=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ba5zjqlX; arc=fail smtp.client-ip=52.101.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuips4ydGArLsFQnLM6ZgRWuLL5PG4aozo0Za/1sef43zSdRiaqvf3kvpXXoxDWj2JxqAQIcWyGwAAtPPN8o2104+qOF2/q4lOEoePkPzNgRIKP94H5j0o0ZeFfdMCrk/xTRPSGcHo+kCdqq2FOtd5vzgOCyScTk9H5MWZqBWS6bejf7mBckyjeHl0/lUdoD9YMNw/Vab+ZxBAG0MArPW4+L/XceMCMkOZji+dSc6Qu635J//vpVSVhn5vx9Df/odr6MFhUb+6LA0LQwkid6tgPosmyoclGx3DImR56+mum9ubiitSHBm9SrbOuLT6zcAo4ukzlOsbHlar2nExRa3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WR12xvUOEsQ18WHoX6O98YZ7Q+vQGgpUfU1+0xsHyzY=;
 b=jgcV7Y0LlvFLJaSLygcjBYXIBV2JY4xA40Ba+1OFkTUoecvVGHZhjUe3mghmMpjQQMc6PYb3Zhvux5Ti4MXeFxfB6jAXnCcEmiZEQnSwGbp3X9tfovMeIZzSO4XE48K1FUiHXIJvgp0OUQW7LlshqR6k6kjUIaLB3zheKFNVupImIpJslKFkR5Od/JBw0aVPDHCk09fTL9GjFS/BVavWPWL+tdxETSPSBNq4GphWgJ6Ozn9P1AqqsW3l+CFd+v8519uTRJdG6hDZdlskUmirMvPrlJXNQ+ZEMdEXMtPEv9zTfoK886zoFQ33LO2Q2MXfZZ7t/d+UgKDJKpB0oHCjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WR12xvUOEsQ18WHoX6O98YZ7Q+vQGgpUfU1+0xsHyzY=;
 b=ba5zjqlXT7+V+oBxONd172UcvZeaeuXGJY3zwT39pxUr18BEWSq/ZWUGXQAfXg7eQ1dyWCRwuW72abnd+SGTu6J2meRSvlLw3g6OLJtpXLL4OV48IfcmXYQ0MOXjo20Y8NWyp1UWGOwjE5UxTbV9tCe2wc0zvGRTCzQy+A1X+ehhS1/elK+JCD1T2dLb/+DcL08yODpp0e17G3H2X/8kPNSEVEsvVuypOxgKbl/4UJenEjzo0cLmmfQwGd9KbPdCCH4zNowR7XbfC19QSGg16ap1JYjFIEFz5yJI4KQWBzMQzoL5vQxmV60Oibx0O16oSIOQb6EKAUP7lzGheZ0HeA==
Received: from SJ0PR05CA0062.namprd05.prod.outlook.com (2603:10b6:a03:332::7)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 14:20:03 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::12) by SJ0PR05CA0062.outlook.office365.com
 (2603:10b6:a03:332::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9 via Frontend Transport; Tue,
 23 Sep 2025 14:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 23 Sep 2025 14:20:03 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 23 Sep
 2025 07:19:43 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 23 Sep 2025 07:19:43 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 07:19:42 -0700
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<alex.williamson@redhat.com>, <pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
	<jgg@ziepe.ca>, <kevin.tian@intel.com>, <kuba@kernel.org>,
	<andrew+netdev@lunn.ch>, <edumazet@google.com>, Daniel Jurgens
	<danielj@nvidia.com>
Subject: [PATCH net-next v3 07/11] virtio_net: Use existing classifier if possible
Date: Tue, 23 Sep 2025 09:19:16 -0500
Message-ID: <20250923141920.283862-8-danielj@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250923141920.283862-1-danielj@nvidia.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 5072662c-6d59-412b-4a81-08ddfaac49ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rO+okW2X82cxWPQhnIOhduvKvg+ZniHtM+lOejIcGSSt9YaOwSZnjqBFjk9z?=
 =?us-ascii?Q?Rp3I93revSSTf8Z7n28nxEe5qB6G5R4mreadjQaa5K2N5+T2YZX7B8xjPpVJ?=
 =?us-ascii?Q?QmbI/QsxSEEaYX0CRyV6tCuoB0FffIe5OHYbxf3VYCZTTTG8uZFwBLFmFaOi?=
 =?us-ascii?Q?g5H5YjW4YRZSlql5c4MchZPfen11txH/VCJLUbBkXNo9EbSCKcHlDExy5etd?=
 =?us-ascii?Q?SlGcHMgbTz6hZeemgAYsnImYtU6ZIYS4Fphtwi7CLB+jjIMWczVv1HsqPWZ1?=
 =?us-ascii?Q?Sp159XtfNh5695yfDonllctMnMuYMPprV1bL4/gDyXVBhuze4OPYKEDO7csD?=
 =?us-ascii?Q?CobFYUtLLYyta5Dq+/aBvGjPRRnQ4KNdkn+z8+4thQcR1s5mYC65TrGkcM/L?=
 =?us-ascii?Q?M98Bfdq1QIJOMlkFf1qcGKKLcPaHqRsP7NeU284enJOBjWxdaXK+fiGCGrYK?=
 =?us-ascii?Q?oyQW62Gl4/aMXcJxlPSiqpA7Ku8g07QEOb0sJDPIyt70FAMxNnWjojEGErbG?=
 =?us-ascii?Q?jDEg8zTlbTasY29IWjd92LIIswyZldH8yQTrduSMaAQW4OXAS3gTYP/nSH3g?=
 =?us-ascii?Q?8DC6npCbLXo/n0qlJP5KyZLp13GltvNjx1s8nXgWuFSKE+1ckUWzwv7KMSn6?=
 =?us-ascii?Q?tKAz5LVs8es2jZtB1wtS9Df3/YT69nuVM5LndPm78Bf265hz0z03lsGE5HmR?=
 =?us-ascii?Q?13mulDasgO8A4xrEGIq1QkK7ugr4CBiG+pDjl2m3Oj4k6PX8hcqHHUKGSRfo?=
 =?us-ascii?Q?xbvMKkOo2WZ4bqEWgRHcy50cEMUhV69luBZ4875FYTZ8pNpT0s/clThBG/IB?=
 =?us-ascii?Q?y2jzWW3K8ebVZ1pML6h1LihNO7iMY7jp7euf/VCeX4+0duIE0/WnHwdwDqFF?=
 =?us-ascii?Q?6wTlbsgd0djACWAyZki/MjRQL11rpKjM9+UhkdbDAWJVUBQjcv3EgfIn3ibY?=
 =?us-ascii?Q?wDYEOuNrGLG0GIR+0fx6ONtLCJ+UjyxEBi+XLV6/X0kIO0Rmee5dMR3WEsnc?=
 =?us-ascii?Q?x6LoEN9F1TGuXYyb2dTgKfTtG/lWFhI9LD2ZVmtANBpy1SawyOFD4yYeKSej?=
 =?us-ascii?Q?yW/hMNkWYFL7ovUhUbGGpwITdU90LUlooBoxH0ULAbiAl6tgWA5oQXGgWbt/?=
 =?us-ascii?Q?nNPoOU6H6GzvK8QNYBXR30xr0AuZK+KuEvDsOWib0/T5XayjyiZ9cokLBpSx?=
 =?us-ascii?Q?ZbGw1U59rdycdLKy1UkRHwqMbG4m8s4UxVSddR27hJ8xZa/Tkl935eLybeuo?=
 =?us-ascii?Q?ID26jw6SywYXkRzStiioWbEYR+2Ee7oqf4iR1MKyla2LcrygSTm6Lj1/ckLt?=
 =?us-ascii?Q?Si5t1RBvCjuw2jX+6PfK+sDp5n09XEgYpRwZUSvAIYZAcy3qyR/ggtg3bKn9?=
 =?us-ascii?Q?f/F2Zv0Dr9Zt8j2r1uH5y68HYuWvaj4lNd7WQQsx960N7j6GKqmX2ltFfFiL?=
 =?us-ascii?Q?JtV7FTPv1z2QjeAcENr12CksuoUxHIaQz1vNwHPtyQhzQ798pX5j5r3BWNtN?=
 =?us-ascii?Q?fGbjXF2hZWMg93mhf6KLAEt1hBseVXT8uMSL?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 14:20:03.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5072662c-6d59-412b-4a81-08ddfaac49ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223

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
2.45.0


