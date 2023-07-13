Return-Path: <netdev+bounces-17647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC7752825
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2EE2816B6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C669A1F19B;
	Thu, 13 Jul 2023 16:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EDB1F176
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 16:16:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24992E74
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 09:16:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHPtmbyEJ5yf2fqUqC9uJP0Mi45QYx2rf/Y1FFhiPjHF6OBHbt3IQe9mkzgzx4eBAwTG+V+mNrLqRfyRGP1L4qfdzICD9J0Ma87Qu7ThLY6Wuwb2mEE/un8Yp4Xq0/QUKpZy2ShtzGeR8Acm0Jc61Ib7u6dsWIKqFPSHaBKts+HPNOngU34GKxIQnIyy8Td8Pn4LxfLFReezSoF9fTb6ivvYnNoJXJ5odBN6Xt8Kwu8PXKBmb/1x3fKHjQpJhe8Z+oF8z8imiz2IyLgKs/g/OCJmpqsMhqKC/mwDwRZDqPIwT7ZC1nEJpIRfNXrKIS1Mt5UJkWozw4ZKqB2sMnTahw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yFrl5lKXUquqwQ+pvTFNFSur18/eavEj/sry0zXXvA=;
 b=c0iNsTFZ7hXcDDG80njRNGfGAMQwQfjsrqmE5OZyD64MtbB/Nd2KcKO+3mGU4LLl3SGzYHbE3AeVyjH0zkq41PDXu10J+RXI1WWACAAP/7MjDt8yWBs7EjTeJxDBcD0VNAEFYcSKzcQhVmOfFyP5/ozgItsZSFQtJdFa0uqUPOdHF2i8FqasecpT74S+O5T2gDY0IhnUGPTqy0ryWvsghUbI3lMZKv5oRugsAQBIFa2fj1tod7w3Ko9LQ7d5m+8xIlJg2zSew8PrSZY9ss5Br8qntJvRJ/xD9w5whcou0FuTwk4+gIT3X+vE6/h4zC6s67KUryKtfwcVdkykWMRc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yFrl5lKXUquqwQ+pvTFNFSur18/eavEj/sry0zXXvA=;
 b=KaHjRhRRGwAJ50++eHwMFmQ3rwj/L9P/ysVjuT5DgcpoImoGrj6Qys904wHUXCktrIdjudOE0IyvEkK7VLu2LkCw3b6A4nA4I4CLqlW8UPRsVn9JbSVMiH1wT9OlCckvxuGGEcMlnwflnqrSGYqdo10jQ3FCngmIehkqjcfIzEfdI+IgF9zVW1CvpJRoWv2+zZ8jMe0Jz7wVm+4iN9EPIZACi2xKpUCbLXSApkQxwUxqWospzUYgyPOMGVtnff4Cn/5VaXngx8Ddu3rzKzIUIkS/gMMgOypBQDXGacl/iMSrcnorVevMDYdLbSyd7g7Zjye+yMLjJg7mZgUkZv/e0A==
Received: from BN9PR03CA0971.namprd03.prod.outlook.com (2603:10b6:408:109::16)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Thu, 13 Jul
 2023 16:16:23 +0000
Received: from BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3e) by BN9PR03CA0971.outlook.office365.com
 (2603:10b6:408:109::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.25 via Frontend
 Transport; Thu, 13 Jul 2023 16:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT069.mail.protection.outlook.com (10.13.176.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24 via Frontend Transport; Thu, 13 Jul 2023 16:16:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Jul 2023
 09:16:06 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Jul
 2023 09:16:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Danielle Ratson <danieller@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 02/11] mlxsw: spectrum_router: Pass struct mlxsw_sp_rif_params to fid_get
Date: Thu, 13 Jul 2023 18:15:25 +0200
Message-ID: <36d2bdbfa67ec400aade1ba4816558abd31e0786.1689262695.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1689262695.git.petrm@nvidia.com>
References: <cover.1689262695.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT069:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d8ea98-070d-4614-6649-08db83bc8027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	twb9/EMXLYL5Rinp+pWaYeN4SAVHGkjSWYr/1I1jaEAW1hEITONNp3OMlF09dKeUbRGJEKUvL2De61HAb4+hW1QHCZmzhJJC+4jpgUkT7XojiGx4nSo9jxAb05OYk75/xys/WANx6mbx6PjP3cBbrGIfil0aYMZeUVuGz/qZJ4Iso4xdZ2e6rWJBa/O20AWBjkQ03quo4rY1GdGb5vju28X898lELM2KpijHGLIE7KzOg+uKPxFPeNo6D2QnaChar4lbPnARHjX49npUUDcwsuRBkWBruoo9pBUFpEZUUwlJxVKE+DIO22PS1Xzw5IgsmkXpHAKUiHur0v19GsVzA7uU0mID4LxQt3GpUXKsQ488LlTdAW1MJR1k8LZmnMBeCc+vwg6JbMUuOQkeC8GWKnhrzsNjTWN3stBXX+d5nB8q30cbwn7OCHdkcb3qoT4gsjvyzMxhQMMOZAh9vhK+4IMUf8Z1pAxY/g1D0NL9Jd6a47Z9DnvuRtTmD2+x42edT5PgdSwE1P7v9MpBjeEP2BAsjdtRVTykwD1ZHz9LT5MPTdfnePjdEKynm6RTmiAodb2F9skxNwK35d9+7xmNvOsbtDF+fvhob9NJYAS41qrmYIeL/MmPH8CkbUvSZ9Y5Pi3JMYIBFvhp9Fve1i6ThLPR46ibzkMMo24JtVtev8cxTINXZlC+/n0tXL2p3fmfPgn1PR4jnKt+JYxgVhhc64EsV2DXjgPNV0+HAzhYMK3XfxO7ctgNgAwCkNJCS9cE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(186003)(26005)(2616005)(2906002)(478600001)(107886003)(66574015)(83380400001)(47076005)(4326008)(41300700001)(336012)(36860700001)(426003)(5660300002)(316002)(16526019)(8676002)(8936002)(70206006)(6666004)(70586007)(54906003)(110136005)(36756003)(40480700001)(7636003)(356005)(82310400005)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:16:22.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d8ea98-070d-4614-6649-08db83bc8027
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The fid_get callback is called to allocate a FID for the newly-created RIF.
In a following patch, the fid_get implementation for VLANs will be modified
to take the VLAN ID from the parameters instead of deducing it from the
netdevice. To that end, propagate the RIF parameters to the fid_get
callback.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index b32adf277a22..adfb1ef2a664 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -139,6 +139,7 @@ struct mlxsw_sp_rif_ops {
 			 struct netlink_ext_ack *extack);
 	void (*deconfigure)(struct mlxsw_sp_rif *rif);
 	struct mlxsw_sp_fid * (*fid_get)(struct mlxsw_sp_rif *rif,
+					 const struct mlxsw_sp_rif_params *params,
 					 struct netlink_ext_ack *extack);
 	void (*fdb_del)(struct mlxsw_sp_rif *rif, const char *mac);
 };
@@ -8300,7 +8301,7 @@ mlxsw_sp_rif_create(struct mlxsw_sp *mlxsw_sp,
 	rif->rif_entries = rif_entries;
 
 	if (ops->fid_get) {
-		fid = ops->fid_get(rif, extack);
+		fid = ops->fid_get(rif, params, extack);
 		if (IS_ERR(fid)) {
 			err = PTR_ERR(fid);
 			goto err_fid_get;
@@ -8678,7 +8679,7 @@ __mlxsw_sp_port_vlan_router_join(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan,
 		return PTR_ERR(rif);
 
 	/* FID was already created, just take a reference */
-	fid = rif->ops->fid_get(rif, extack);
+	fid = rif->ops->fid_get(rif, &params, extack);
 	err = mlxsw_sp_fid_port_vid_map(fid, mlxsw_sp_port, vid);
 	if (err)
 		goto err_fid_port_vid_map;
@@ -9724,6 +9725,7 @@ static void mlxsw_sp_rif_subport_deconfigure(struct mlxsw_sp_rif *rif)
 
 static struct mlxsw_sp_fid *
 mlxsw_sp_rif_subport_fid_get(struct mlxsw_sp_rif *rif,
+			     const struct mlxsw_sp_rif_params *params,
 			     struct netlink_ext_ack *extack)
 {
 	return mlxsw_sp_fid_rfid_get(rif->mlxsw_sp, rif->rif_index);
@@ -9836,6 +9838,7 @@ static void mlxsw_sp_rif_fid_deconfigure(struct mlxsw_sp_rif *rif)
 
 static struct mlxsw_sp_fid *
 mlxsw_sp_rif_fid_fid_get(struct mlxsw_sp_rif *rif,
+			 const struct mlxsw_sp_rif_params *params,
 			 struct netlink_ext_ack *extack)
 {
 	int rif_ifindex = mlxsw_sp_rif_dev_ifindex(rif);
@@ -9869,6 +9872,7 @@ static const struct mlxsw_sp_rif_ops mlxsw_sp_rif_fid_ops = {
 
 static struct mlxsw_sp_fid *
 mlxsw_sp_rif_vlan_fid_get(struct mlxsw_sp_rif *rif,
+			  const struct mlxsw_sp_rif_params *params,
 			  struct netlink_ext_ack *extack)
 {
 	struct net_device *dev = mlxsw_sp_rif_dev(rif);
-- 
2.40.1


