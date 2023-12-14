Return-Path: <netdev+bounces-57447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127B2813194
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ACDC1C21A88
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF0056B68;
	Thu, 14 Dec 2023 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O7S/2Fyc"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA4C182
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:28:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEJoXo7OlIpwqFXeizrpZMhmdo71H2aoAMx9nEPaDxaADUZdEHyf3CZKamKMc48oySrp4NmVC0DITUkMP922Fr9q8DEpkGE5HyJUJKIFK+yioRJFfxUOH52svt4eQ+kCVlJWpKZqx+UulNJc7AKAjE2Mgqniic+h+cJBUhINHlnIhcA+AJmtd8zw10cUs1wkGNee92IqC89xtznQRfeH5h5kmy0RWlju+XAqys3pP+j4kxA+FPYhDXZ2y6Ib9IWiCqU7Qt4OeoigEDaKbljmhWotTUHsKUXMp8qRSj7NaS+a5aNGrrICEZWVL8iq3aFPkmLcM3ZRr2WhxpB8+emwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=Ed4rrQN3xMBgw3Ve0CzTn5/MrLgU2xFugAvQGn3HJZREhCOzIg9IOJeMM+C5JCq7hOi3xG7wZWRhKFszdYH9IvZXmxSKIX87Ym0dqV84yJ+KkF0SVjoIOtAMWinrjqJoxV+zLPvWuxlow9AYi+IPeMZX0xVDkjhNukFgjRpw525uLUxYpNUh6h3vpl0PKvOdo5XajKRJdrQ/GBFglbrSq4QvzJP7t+Nkdv3/F8hWHcq1vav70znkJvAMdUx8F/5MK4RYluSjC4R2Fzjv8DukSiz+F0BQpWn1RD4O02Gs04WgIDfHrbAckqK15/gq8NvWO6pbHOtiFgXh42pZcMBMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa3K+d+tGObk4y9Zv/bhOSlIarCrDmSWoYqxxmm8F3I=;
 b=O7S/2Fycm7uhkUgn/8KiETWojsQlVWSV8F+Rm2elDIuiVT1zkYYCsilq+NxRGOVT+yZCXS6Vl/8MUf7tj6ha4nxerpjsTuya4Ry953MqFPCA/TaHE5TVUMlCX5Ucpa+FlBGGtcmKZdkysiz4+idVJkrL3Z8tLvez1xbjFne/LeI9b7cZPDQGgypCP2Ycw+ItBaoo60pLXhkBkz+gUaVglY38DhTPjY0l5FKfmO13Dh+GeXd2p5l6I4g7HXVIbAs2luPvpgUaNw6K/RXr6agDhxDXRDr/h1xOpxVbQQ3Mw9XB+gXs0OMakvi2BrDgYEnSBqmBcCOh8xe4yLAsTQ35dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:27:45 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:27:45 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v21 14/20] net/mlx5e: TCP flow steering for nvme-tcp acceleration
Date: Thu, 14 Dec 2023 13:26:17 +0000
Message-Id: <20231214132623.119227-15-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214132623.119227-1-aaptel@nvidia.com>
References: <20231214132623.119227-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0236.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: c095ec75-7ad6-4038-b6e1-08dbfca87536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wZdtxlZETfS9I0c73q/TyGXWWTqGUkCWuukDalU8hU8mz9U8AKVelal0s6VggOQ/MW94k1BtH34+53bcgVSLn55BYIdoJdmlZLc3FLeh93jdOwwBd1+CTPZR4kcS1I5Fn4HBmC4pFzmOQEfOU4/mJ1CartEI+ugkvtoChZ4j0pGtYaCbdzrOdj7zaXctHBJeEfO0WTgtGCkU/FbVBy4k4AvVQrivYiGaqkMt5nqGDwxBvnQFKefF3nzE7FkDHFQaWeljB/YVtWsO4acswVgw/BV6cuCV1ueoz4HWpof0qmFe/OBEdlydtnDgx5RP5M9Nla28oBwcsMpRWo1q1S2NIO3VQ+Ijtg/8sn+yj7Z1ZlTqVULYbN/3OR+2xxMM/qkHb2wCySmYvMdlovA2I7a8HwI9bKaxxdSP541iM2HHXxAaqCJt4pEljpo4plxjHhe1t9/CyGS4gMqJy/0JUmwW8dorg3GJgpTIjvHGYOtsZkCNKxEpLN8J5htaZhsinvVopx5/o+ZKTkfegxtwBupb9aZKWMAr95up5haN+iWLj17EsxPpUS/0GNli1nrkECU5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(41300700001)(83380400001)(38100700002)(316002)(7416002)(5660300002)(26005)(107886003)(1076003)(86362001)(8936002)(4326008)(2616005)(6512007)(478600001)(6486002)(2906002)(8676002)(6666004)(6506007)(66556008)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FprNNYYMdY5S/PQLFfmfVjkdLrIXmiOBrmfyCvw1vObP7jCeC6Pggd6X0Q6k?=
 =?us-ascii?Q?TMH8/eV2RAaEcvpcWCz3YO5tfZvhMHoVMHXSdJGvVBHEOCIHONbaA0eaJWYU?=
 =?us-ascii?Q?VoFwpNNAuPuUONIK/lgfQSamSGv3SgRxIeeMSjHgXqL4tXk/0rh1LvjcLLMe?=
 =?us-ascii?Q?5QSR7s4zmh+exwiM0O6itzKY47VTJUY0U8X8zx0/SXUltNprmzjda+o9fQ2v?=
 =?us-ascii?Q?hqKInXESLN3SEZ8tHBLOEDLSHfFQIfjB/T8aARigi9gJGKPXBGnRpQmLr4V9?=
 =?us-ascii?Q?eZOcFiwWr398P16vCot5Y/mFC339o+vFKjQTa2dQPjiNynP4bTOljVd5MNQs?=
 =?us-ascii?Q?W8aZf1RoquKGNcxb20l/q1vanlb3tGRqoMcXOVZF+rKo6qCdhDZCJCu0Jrfq?=
 =?us-ascii?Q?PWRo6fO8/oLx1VzdDPDr4lzJ+U4d/opzv7TePd8lzbTUOqBiplvGdqa1P7k9?=
 =?us-ascii?Q?5K0WtzQD8kGO5Tm8vKMsw3zOREdIvj6IGN00wigz1eRYw2KaQqUF0qnvt4/N?=
 =?us-ascii?Q?wIUNJz13Xpaj/j3GGgWkdOuTJzICJ8DtjYypWfW8dgks1ds59fPtp41doMdU?=
 =?us-ascii?Q?Dx6Sg9n7SUwfIa1zerswK1OshlS7F6BxV4MYpeg+H1zEmebl2jtvDbbA/1xf?=
 =?us-ascii?Q?dEOcWmvbLgXVD4stmALlOj1wPyQyFF2o+R+8Vwi15sbUF1d/pYNlMXrW10DH?=
 =?us-ascii?Q?eOmm+lbZBmaDtki9k+ipVi86AOTF7FYGF0/kKx3Pp1CdH6+7xKclzWbNc00t?=
 =?us-ascii?Q?qb6F4TUvhJGQGZhJu6V+YppIXpyIejKPPcaIW5brDA+BmBX5st+4hDsL68v4?=
 =?us-ascii?Q?sdUgHlNGGqdYsYvAZjPoRn8nbljqM8l2qj4Xt0kCGhaum4XCyGZZXgf8bHfD?=
 =?us-ascii?Q?jBp6EgQgt2dFoMxuVsbBfQ+awysoiN0QFzuk3CitBeGQd7fIC5zcq66eKEI/?=
 =?us-ascii?Q?QJVczenQYOuxu3+Cb9zABVrsxjmXQxmN1BL1eeDQeCHEQGqZhoWRZ6uKGZmn?=
 =?us-ascii?Q?nckWeaSimWvV8ghDoEHrWp+qnBaYN6q6LVbo40mSzHBNCkulAZhjXmkhk28S?=
 =?us-ascii?Q?ArPHuHtqL5osaa4KVC09cYYULeWt1lRyGx3BYA0N4DKK5a9sGuRVtxf6QWqo?=
 =?us-ascii?Q?/qWlDqKLE42aT3WxwhCX91fKErsqxyPgwo8jUfJPCf9cbAIYQDtji8ISOmPD?=
 =?us-ascii?Q?YFJaFKQlhW5vHsHkDSIuCwlEGJEQJVxjdS9XAeAb65j1frbK8GDKDk+7TZw6?=
 =?us-ascii?Q?hFcKxgOD26mjfCz24jZZC/aUwFIcLbY6hDMXhUK+j2pSZI2yKGpKooE3x9hu?=
 =?us-ascii?Q?iJDnxj5/v5O5gh1ZpS8csGjGM3pu9SQfLVs1YTDbT8hN/EaEUQ26sS68wPPT?=
 =?us-ascii?Q?lLxNK1IwffsSngMlkLkn2t+uO+kcpFNDlUQ+gvpG9YkKSFw/FP8KNbqKH4Qh?=
 =?us-ascii?Q?kG56FwEr1SDslfOj/VPyeRtBEGLRjnFNV9q13vlg6vU1XzYyn+85MaPKo/xl?=
 =?us-ascii?Q?a17Vqvu3sDGvGjNQ9DUaO5H01aqVQovsnIInfD3p5hhJi6cNUYnWZqvpWxqO?=
 =?us-ascii?Q?fzeeONwS6wQPXuKGoO8ph2fte7H5Z+FC6Fa37E/q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c095ec75-7ad6-4038-b6e1-08dbfca87536
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 13:27:45.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9tkibHuQY0Mo8CpWYmmV5OogE+by6H0LaEfVv9mG/y8S+7EiIddUoMgAd07K418iyrOyIexhQymngj93zWomw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

From: Boris Pismenny <borisp@nvidia.com>

Both nvme-tcp and tls acceleration require tcp flow steering.
Add reference counter to share TCP flow steering structure.

Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index c7d191f66ad1..82a9e2a4f58b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -14,6 +14,7 @@ enum accel_fs_tcp_type {
 struct mlx5e_accel_fs_tcp {
 	struct mlx5e_flow_table tables[ACCEL_FS_TCP_NUM_TYPES];
 	struct mlx5_flow_handle *default_rules[ACCEL_FS_TCP_NUM_TYPES];
+	refcount_t user_count;
 };
 
 static enum mlx5_traffic_types fs_accel2tt(enum accel_fs_tcp_type i)
@@ -361,6 +362,9 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 	if (!accel_tcp)
 		return;
 
+	if (!refcount_dec_and_test(&accel_tcp->user_count))
+		return;
+
 	accel_fs_tcp_disable(fs);
 
 	for (i = 0; i < ACCEL_FS_TCP_NUM_TYPES; i++)
@@ -372,12 +376,17 @@ void mlx5e_accel_fs_tcp_destroy(struct mlx5e_flow_steering *fs)
 
 int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 {
-	struct mlx5e_accel_fs_tcp *accel_tcp;
+	struct mlx5e_accel_fs_tcp *accel_tcp = mlx5e_fs_get_accel_tcp(fs);
 	int i, err;
 
 	if (!MLX5_CAP_FLOWTABLE_NIC_RX(mlx5e_fs_get_mdev(fs), ft_field_support.outer_ip_version))
 		return -EOPNOTSUPP;
 
+	if (accel_tcp) {
+		refcount_inc(&accel_tcp->user_count);
+		return 0;
+	}
+
 	accel_tcp = kzalloc(sizeof(*accel_tcp), GFP_KERNEL);
 	if (!accel_tcp)
 		return -ENOMEM;
@@ -393,6 +402,7 @@ int mlx5e_accel_fs_tcp_create(struct mlx5e_flow_steering *fs)
 	if (err)
 		goto err_destroy_tables;
 
+	refcount_set(&accel_tcp->user_count, 1);
 	return 0;
 
 err_destroy_tables:
-- 
2.34.1


