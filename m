Return-Path: <netdev+bounces-239596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C17C6A17A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 15:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 392694F67EA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED5835A156;
	Tue, 18 Nov 2025 14:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0KEsHSg"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B863A1C9
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476780; cv=fail; b=pMmLzzIwBdgefGSxTkpOFbB3NSZBWyRmlCZmFFJnaHle4P1B8iT6aIHdG6piaBYHgFE/KsZjC4sNZoxpkkLau7QvSB61L5NS25Q/NSilvP4jUMQtD43Pf0GZsiqKCAOxhua7ET/4paZhMjTMDIl013KD85tgbsXmZklZzyuog6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476780; c=relaxed/simple;
	bh=78GE/eFuV6wNzggvuHwcimE8SJ3BBwqbTeDGQKr0n30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu2PdfwSp1jVGh+U0hJIvSKFcQYGemgICFSxSDYCcY5yaXgFcpbWzQcTvOIwzN5/U02M7s0e7WTURtnMcvcKsGXAMAELRZkyyFPIarMit27NFOSe1bO7WTJAtwBiNQo+3ZfJvFLvye1P98waLyKx/xbWCcz/Ag5UeVQWWBmE2Cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0KEsHSg; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D95MjTpz6NrdjeOoRbRnE3NGmbe6GnKZV3HX7VHj6djEkf3GPbw4hEbfO1jbqzb0U0RKkGurcNWC/NH+uGIEBOqv6Za/PstEvGJU9mRaO961NSmFgYzk1K+k3OAxt+9ii6SPSZcljcmjozfNfirUZh5cu9L2E0gshnKPGpR/y6h1yCX5kfeySF8DgnrwCNdz8Vj9+4Mixaqikkl8ocMt/4TkpZCnescbfmwJYWPlIKGmUSM1VuetK59XcFqIem7/p6rqlrxO7Kt3nFH8UbgjPKwGxaGUjEfoutX1skzMnl127S1lN/qLRkiYzsjTs5qounnc5aVvro55rLsrOj4uNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk3tv6NQCxGEAlv+UrD4d3ktxn5SWyk5swdzqHB2OUM=;
 b=dJGw/SPotLRbLUbEYBUabK7AyNVOFEloj0rhnFT1hY0M3uen+52LDAG1GWsiJM3Zkt2vJnzTxnC3mhn7A0rNA683INrn5+0s7KG/ccWwPQG3kl1q8TOebtAE2NRCINtBdbaHl7vtKvV+zJiEdpZK33+KDlLJ7MJF5YZcVJf+y1K4V5mLyXGaMNYClgI3T+rc1azz4nKYVlrIX4OPVSR7kPJ4dX1RTmFjdPkCrj9ubg8pykC59KSqsfQV3Lqfia3h4uGd3roZyPMw8EjJZOMLEQarfm1uD5r8BlJbj3wcZaVVNWrC21lLhNP3MmHW+GcZTO8GDBlkfFzXxryzturmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk3tv6NQCxGEAlv+UrD4d3ktxn5SWyk5swdzqHB2OUM=;
 b=H0KEsHSg+mXTVFFYmqvicY/F/3BkSy2tpfutzUly2GXT3EseyMpGrrk/dklvwf/SzThr02gGppkM5UWYjX8trGHNdHJnapiW7DY+7tulOdb0N+lWirfckDio8DS5gVFkIU8rY/kiNJKzDEpPGmdm2dl1E1HI3hJhmfc67F8SbtYC4LYiTkZwro1jfNuVe31+9GfSDpmjbgHS7srJ0Q2RJIzpaOW5JRDbGQ8NtAv/uXxjv0PrJrDsiAZ5QlQ9xDkrSdCY7OCd7QYn4POEP6ED980cPpN6S/ikcuH6SAjUd68ruVz53ZoVb0jiTBPGHMAlIy5Z4CQYKm1j8+51JXtxcA==
Received: from PH8P221CA0049.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::6)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:39:32 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:346:cafe::d9) by PH8P221CA0049.outlook.office365.com
 (2603:10b6:510:346::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 14:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:39:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:39:20 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 18 Nov 2025 06:39:20 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 18 Nov 2025 06:39:18 -0800
From: Daniel Jurgens <danielj@nvidia.com>
To: <netdev@vger.kernel.org>, <mst@redhat.com>, <jasowang@redhat.com>,
	<pabeni@redhat.com>
CC: <virtualization@lists.linux.dev>, <parav@nvidia.com>,
	<shshitrit@nvidia.com>, <yohadt@nvidia.com>, <xuanzhuo@linux.alibaba.com>,
	<eperezma@redhat.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kuba@kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>
Subject: [PATCH net-next v11 08/12] virtio_net: Use existing classifier if possible
Date: Tue, 18 Nov 2025 08:38:58 -0600
Message-ID: <20251118143903.958844-9-danielj@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118143903.958844-1-danielj@nvidia.com>
References: <20251118143903.958844-1-danielj@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: acdffa30-91b8-4fc9-98c6-08de26b048d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ai3lcjjF/eXs2vyoWaXFAcC/vF7WGfqcPfA27quOqgirUw38c0DnpQuUIuSN?=
 =?us-ascii?Q?rYW95w83t5fAinmtl/cntimb5V94nYAEdCDAOU5lxBNgZU4m9JAsUz9rtYnC?=
 =?us-ascii?Q?Kq4p14R+rug4k3gSYCMQpA8c/VArkafVW8Dp4t1k9wTWjItkxV+GX28Fx4nE?=
 =?us-ascii?Q?e9Jh2Wo475OUavKYRcx058yj+jaJBerpjYpIsIGbcEi2QSNui3cYzzPua8l2?=
 =?us-ascii?Q?eat5pmpL45MEpvDmcSV301oH7Ap/Huxhw1EL1IVjrFk/Fi0+r5gQxsGBegM1?=
 =?us-ascii?Q?/Iq4B98NSAOq7z/IgvZBxOCetUxTeWAK+H9paQhyGz+dppuGcCCdSjaaPZ1k?=
 =?us-ascii?Q?uJa5fxAEjU0be8uLTbyOUNAPr5Jo1IJCvYbfdedHV/JiQJ58g/a+U7metrxc?=
 =?us-ascii?Q?FNcl5DejJyVYpCCHDovz0kJskyYPA8D0GwfIAvlA1ijtoUPTvmlBnCUldQWY?=
 =?us-ascii?Q?7LpEuUPjb8vWHA45QY+adAnvCPa8wcyYUO3ikCLDWLax/8KL3dmxOBbzzxee?=
 =?us-ascii?Q?m2oOuVukm9ApU09Vcf2mWFqHPWahnzbUdK9h96jxVVK16kW0AfWYK7Q6jQHt?=
 =?us-ascii?Q?SwU/htkoLX9F2VcuuTA/RMNCzAJxf/ZxQbgp0CrYkei/VuNQsvqM7dhWArjZ?=
 =?us-ascii?Q?XW5WY6gaeM0aPCXLejq8HJInzv6WUt9uYmDBmOtPNEJdXhT/Pc1NVePItAUP?=
 =?us-ascii?Q?7XNbfb+vsTzo+F+Fi8S6r3ZaRxXUyw8xzul1ZcM944JTrkviCFds6ENQYqno?=
 =?us-ascii?Q?WXHusPhUFvAD3zFbkcLg2WuulLYF5HhRA3cCoUfmDmkjaJnUP1pSQcBBvTjo?=
 =?us-ascii?Q?ZwiRtGUIit5MsiPRLoqyRxE8wC2khDKoRi6mYrWmbAIe/jVz+w9uKfcst2+P?=
 =?us-ascii?Q?Is9f7695h9aJ2cWVVFx8suLh7UXCQfF+2tb9igx/+QTx8cLY9FemO6xQ/zEq?=
 =?us-ascii?Q?rrq8eFjesTXAp7NGA+42ELAk1ja+WF7aqBMdIVIp77YEqheq3f45FtCvf31J?=
 =?us-ascii?Q?sokNkNcOb5StfQmXaGdFPdM2350R8e6P4efk49A/ARO8DRvCultqJkv3+dBD?=
 =?us-ascii?Q?KN/suw8If3VMGulAdQ00KTFPI768WKeKM1rphjOsrKej7bAPskequK0oRL4D?=
 =?us-ascii?Q?J8nF0tsrA94uD/fVxqlQzn1x6M8k2nvQOGz+WP38Y71tSdt2ijcB6Uw/wKd3?=
 =?us-ascii?Q?k+BTKkUeVw3NplUdc3B7Xuad/P1DtS7n9FujRLOFgeIa/x5Fnu4JxAxs+l8L?=
 =?us-ascii?Q?H9QE3Y5Cboc79raqfb8aNXaVlTkhj5vbv7EAzRrnRZ2YW1bcsMxR7qqkPM+C?=
 =?us-ascii?Q?4r82u30Oe7dzCSl/YgxDPoB8OfpM/LBQwqiibEUDs6Et1z0DxSAF7lGcAfF7?=
 =?us-ascii?Q?E1ZA9dtFCs1PG2jK26qluhoRihM0L6Ml+oMRt+WtamZAOeFRnB/Ge8+vHh7T?=
 =?us-ascii?Q?NhmvU0jG1R/sfcD7+4VRc4EWubwbkY6Anpq79x2MRVN7ZF6VuJ/VXQhkYoAM?=
 =?us-ascii?Q?MCZx5ZEB6ZStlisGTK0dXVWcNC908j22XnNpc6I7190OOnns+0+I5r6s8Wky?=
 =?us-ascii?Q?OphjyRzTpsXHtQQ3nHA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:39:31.0131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acdffa30-91b8-4fc9-98c6-08de26b048d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621

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
index de1a23c71449..f392ea30f2c7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -299,7 +299,6 @@ struct virtnet_ff {
 	struct virtio_net_ff_cap_mask_data *ff_mask;
 	struct virtio_net_ff_actions *ff_actions;
 	struct xarray classifiers;
-	int num_classifiers;
 	struct virtnet_ethtool_ff ethtool;
 };
 
@@ -6827,6 +6826,7 @@ struct virtnet_ethtool_rule {
 /* The classifier struct must be the last field in this struct */
 struct virtnet_classifier {
 	size_t size;
+	refcount_t refcount;
 	u32 id;
 	struct virtio_net_resource_obj_ff_classifier classifier;
 };
@@ -6920,11 +6920,24 @@ static bool validate_mask(const struct virtnet_ff *ff,
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
@@ -6932,29 +6945,30 @@ static int setup_classifier(struct virtnet_ff *ff, struct virtnet_classifier *c)
 
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
@@ -6978,7 +6992,7 @@ static void destroy_ethtool_rule(struct virtnet_ff *ff,
 				 0);
 
 	xa_erase(&ff->ethtool.rules, eth_rule->flow_spec.location);
-	destroy_classifier(ff, eth_rule->classifier_id);
+	try_destroy_classifier(ff, eth_rule->classifier_id);
 	kfree(eth_rule);
 }
 
@@ -7159,14 +7173,14 @@ static int build_and_insert(struct virtnet_ff *ff,
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


