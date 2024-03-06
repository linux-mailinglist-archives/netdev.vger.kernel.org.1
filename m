Return-Path: <netdev+bounces-78145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB23874370
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C908B1F2697F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C11C2A0;
	Wed,  6 Mar 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NC6tHk1e"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6CA1C6B5
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766306; cv=fail; b=SX0bBHtvlSEp58+qNqQ82CVZnDRB2G3goHe2fU8kA5QOMnjJpRpzsv6rcQLDohuP4w4pHRHsBdtnqVGEkPCZVbAUJMn36VNk4+fKP7tjyI9n1qbJClU7UqjJejy8SVVdoWV2qv4DnObVsQObXBDv5PP7dgTWr9EQkMN263QPYtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766306; c=relaxed/simple;
	bh=S42lAv397YtQ8N9tGbFFqLWe5BcO5fAlGpPxFgLFxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qluFdoGOCJLVG2hYd5gIbnYsrB8I/Tf18IbIkX7ug223cDp2aS81CgbBE7OMbktYoqjxeHOkFbZV8joqOhJS6nfpYJWm0ULxTSGdgKWaxKiDlGeefBRkj4hxhgdG6NidtLSSzQwFgefDgUL72oEWCKNTDO2YVGTf5xGDUiNxNUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NC6tHk1e; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXoQZCRLbRvmRgEvBHMYy9rRvboY2Kk6B7+bV/ZSUHWA1QVYYNqgfsWtSpkUvY81IY9QTCvKcsBaKpdW5Kbexy60GcXE5CEkySiq19OJ3M3ijip5rAkLuL2mHQ5CkhL8GheAO/pPU2APAwjDTouGsVkptsGm2qcqH6rXlJerkF+viGykKBkStfNYnER8b4H53r+zCpHE3tnAG3QM03OyZnMp1++4e3Mk2SrJNjw+eStZy9ylbGF26U/EjYoCFzlSfIu5wlivtE19VVt+ttZUbWZGntuMWQkeqCR7ZA+KhiLTz0JaLlgDbmOPqLQr2Fg1k04+NoEqcxR9y6wrf2dIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACHKla89yuLcrDduCrv2OoreNT8Bm67EDSRtR1KO88g=;
 b=cyEeQB2n/lg/DqMPZT7kJ9bRaCdvblxmpWvu8xUeht8D+6z5RaMx7+16Ty/8qfxZZt/UsTt/nZQhHggTQReYZ4nLKziwlib54GV41EnBtNznI+2jbv1qMjHkVhyLReLdRGmscwzWmNkiI6sqGGJ81K3gsHvRhjULKgTIhPZVXJyiT2at34Uneng+KZ73J81tbaP2e1rvY7Y7zk5O/FKHGAdIUo/JflABA9bdE674IKWzqvNfLwG24U+5j5yLrjtIwcB7EL4bwzDvd3660/UkhtGLZZAgnZxP0BxNuUfJvr17bS96B+NEVdJjnE4ChLVEPP0K05vfgmW6stuVi7IG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACHKla89yuLcrDduCrv2OoreNT8Bm67EDSRtR1KO88g=;
 b=NC6tHk1el0nAlu85VllaMmjswAiw41sL3HshVMQq5FMF0/39nlOHtsY3qlI1VdacQyIohZp6PGXyaObEblKR0eOWxdZVo6i+F8lTDTXMKRefZrrrUVtlh6pdkv+TPgTdTfSQLuMxAzkOoRWdW8uRfkTNWw1eqskTSchnpzqCpb24LxYDP+4WmZC8WdcTdU+VfLRYEocD9mF0Wt/nl7+Hs7AnF9vlAYaBwN17HW7xcorRvMG/JJD7K20E6Fl7dGoh3Ij8XWTWEwi3xAFNvFcx87M8W/oF+psmRW0neu3yCYF3NoNAW2gsxiyxrWoRqKiYh4DAUcwRefOOalBYT/e0Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:49 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:49 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 5/6] net/mlx5e: Support updating coalescing configuration without resetting channels
Date: Wed,  6 Mar 2024 15:04:21 -0800
Message-ID: <20240306230439.647123-6-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0148.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 136ae847-9ee9-4ae9-c898-08dc3e31d20e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QO4SR0+RtuI7xROHyDOkltp21VGqR494NFfLN1Rtdil21LlmWwhvSeZA99nHI+uH26QTGgEJD17u0WmQrpx9FTE5ctjvs5pW25+9W6p/uCCB3tp5PZkRn/ne9bLDCWKRzx+18VW3wTTCGAGGDjIiANl9b/RIDtDZLxg2Nq7zSYCR00nrpZANBU8TmQQRTXRKOLMFgOtbyvnfzsMwaWwmIhE2N28/Bbxe4KS00m7KgXcuETIi+zpU0kmDrS6olrMznl4n0rsN6Mc1t9BUVwSLl4DW38+POYAm0fSQx9PgnFxYNfNh56mautojQQ53QsMYvoU6Bf6RG4vCNrLWawmvi+Cejx829o81+zaKT0hc1GXz3NFrD2BAxaWOMJ/OfmzK8v3a1E4pP0Z4RV3JCoU5MnqISYkCn+FQBSL6JiI451NkB/rWwN7tXJ1soT2oep4TvDUXAN1Wn5dWADIJrd3y6MihHOHPP12TBgi5j2a6HP/IYeVXd16C3HxCppv+o72NBRIWrHLNbgzU7LEUDaopklufYhsvMlbHd/dzEDHlCAN1sThwzuE61DYJJtIhphsRZ1YjJhSvP0pcCdlqJ66TWxu2BVgZ5J8tBAhmWrPcYdMLbP6dHFWpQXpRn2/dcKdDXQYxHYZv6VgGOBj1kjSzVMHIyutgmjfDoqrCZfDKeGo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJRnjg/b8nOPHi2+AK3KvdW8wSEXZOxt+gHxoE4/htpVXsl/3cZY2gfe+HRb?=
 =?us-ascii?Q?fJQnsRlGRc3Uq4Ji+/Qbmj4IyHoC8rFWFjG6819OSpHBtKQLX9iU9ThJVAff?=
 =?us-ascii?Q?DMbe5TgLVSN2PbZpbUZA5Vt6DNa+DlUY0/NaQ+uwA4Bt1yQVbMo+e1nCsNAl?=
 =?us-ascii?Q?UXEEPy3aTWl9pd649l5zfaQHaY7c/dsZ6AmQfTeOuCAfJcOKE4DYAeQi09fl?=
 =?us-ascii?Q?qBnFTKC1AirSl0fqpzvWze42OzH7TgZTaE7tOUyGQ3BSFwG9qWgbbSirHpze?=
 =?us-ascii?Q?SUHG9VzxidE5STtVg4LEJjxoarQ3riUlSl+zKVWlGSo7sNMB8wfDTL0fQXYM?=
 =?us-ascii?Q?412FL6fn/D79Bkw/HVdFqg5va9/kllHRflGxavRctOajlsLvezUIy6n2jrhh?=
 =?us-ascii?Q?nd4AmNoBRD60xnugfJBXay+pOeDP5OoP7UKHF8cnFeVv4RydILXZEkrK7h/d?=
 =?us-ascii?Q?vBK4HBKEdEADQBpPZLQLhHXkF9HU+vnN6swWB7TneMg91LtX4jGlL70TBs0t?=
 =?us-ascii?Q?YWpZtgQuslmK7gyLmMjvgmu+c4JnErQ1Y5DLcpEvKGHz854hOYGLGfTlHxf7?=
 =?us-ascii?Q?QvnrLlH8RUVW07d47wjcJSRn1Ly8TKMa6UggAUn3M1PCtt6jrL3S+/y5erXx?=
 =?us-ascii?Q?JkzPaVMFv87ar4VjUAGOsf4L4oo+rqsGr30uQFzhspjjzmAEI1pL/y0YMDv1?=
 =?us-ascii?Q?ic+kArAlegORnSj1RdAKTUQcIAY0wFpvl0acaJU8LoEz4D1JSBDq+MYu/vaD?=
 =?us-ascii?Q?N1Fh1PgILxBz46+7xROTGyoTL5runUJ67KEFr4T2XAkUJrTKauoazuWtUmIA?=
 =?us-ascii?Q?MoIHrOhCt7jR29CCamR8mBztzPtIaOn+uhq9Dj5qQcrjApr2vH3h2CpjxChG?=
 =?us-ascii?Q?aXgaQ+DrMbkl9WWd/jYclYfEzuVQSHkpHn/plpGcmrecjnhfYgK36c9LHWJ/?=
 =?us-ascii?Q?e1iLbXN9Ypbs4qjcrqKLMnISXlgeU7RPcgCaG8HmpnArHXJaLbEUt4+QpUFY?=
 =?us-ascii?Q?WrJd8UB1q7WvKqKcgY0L5nWuRH96y1WFvswfEwlKIHn01RXI0e9GH6tYdjJV?=
 =?us-ascii?Q?kTdA2y+hjLgeGmol5DRzmQNnlspBhXJfdToKWh30+WDCu68CsPCpglpT4je3?=
 =?us-ascii?Q?f79/HvSMf0f/TRKQ+e3KiOmlopQjCLQQG3KM77nkcdSvdlnDC2HuH93+83mx?=
 =?us-ascii?Q?/jDvoKPOgU1lCICwZtw8WCoBVcvAtcs5zNL+L6zz326XCP0KbSInrzaaph5K?=
 =?us-ascii?Q?iTFdkRfVFTmHiqFgV7Qh/Q1AelfY/MruT1phO+PsLmsmjJ/aQ5HTQ1nX28SO?=
 =?us-ascii?Q?c0pVoCElPkCYatLAayz4hp5Z4G4MIZZsvVdFXWnhQX+NHmnC40/tMFpmYE+L?=
 =?us-ascii?Q?IGrvOBwwppiOfsxYYJqPMlMFJ5qayYs7OFshhTY3jwGJZpeKRGsqSth8nJgA?=
 =?us-ascii?Q?QVFsRVpJQs409ruqVnnbjC1764bCCOiXwYZo8e04TyqV9OZG4FO8/cfp4Ay/?=
 =?us-ascii?Q?f4hMD9DaXaeOf2H81s3oXcK1zDWdwkoKFYc+pwoCPHmvcOeFKwXgCVqKi/U8?=
 =?us-ascii?Q?Hk06AfaAex7BDGrIz3X+aJLbMxio4VoZrcQ8NsgbAi1B5L9OeaxtmuwYqQMd?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136ae847-9ee9-4ae9-c898-08dc3e31d20e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:47.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZEdYTP2bs8Jzo7hPOyhXNUMRL8Aykqx2zLJQREAuvvl/L45HFN71bzSpp6sLDsiu6W4Rz8xA00UK6trH0jy0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

When CQE mode or DIM state is changed, gracefully reconfigure channels to
handle new configuration. Previously, would create new channels that would
reflect the changes rather than update the original channels.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  16 ++
 .../ethernet/mellanox/mlx5/core/en/channels.c |  83 +++++++
 .../ethernet/mellanox/mlx5/core/en/channels.h |   4 +
 .../net/ethernet/mellanox/mlx5/core/en/dim.h  |   4 +
 .../ethernet/mellanox/mlx5/core/en/params.c   |  58 -----
 .../ethernet/mellanox/mlx5/core/en/params.h   |   5 -
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  89 +++++++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 157 +++++++------
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 213 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   5 +-
 include/linux/mlx5/cq.h                       |   7 +-
 include/linux/mlx5/mlx5_ifc.h                 |   3 +-
 12 files changed, 470 insertions(+), 174 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 1ae0d4635d8a..be40b65b5eb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -319,6 +319,8 @@ struct mlx5e_params {
 	bool scatter_fcs_en;
 	bool rx_dim_enabled;
 	bool tx_dim_enabled;
+	bool rx_moder_use_cqe_mode;
+	bool tx_moder_use_cqe_mode;
 	u32 pflags;
 	struct bpf_prog *xdp_prog;
 	struct mlx5e_xsk *xsk;
@@ -1047,6 +1049,11 @@ void mlx5e_close_rq(struct mlx5e_rq *rq);
 int mlx5e_create_rq(struct mlx5e_rq *rq, struct mlx5e_rq_param *param);
 void mlx5e_destroy_rq(struct mlx5e_rq *rq);
 
+bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled);
+bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state);
+
 struct mlx5e_sq_param;
 int mlx5e_open_xdpsq(struct mlx5e_channel *c, struct mlx5e_params *params,
 		     struct mlx5e_sq_param *param, struct xsk_buff_pool *xsk_pool,
@@ -1067,6 +1074,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
 		  struct mlx5e_cq_param *param, struct mlx5e_create_cq_param *ccp,
 		  struct mlx5e_cq *cq);
 void mlx5e_close_cq(struct mlx5e_cq *cq);
+int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+				u8 cq_period_mode);
+int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode);
 
 int mlx5e_open_locked(struct net_device *netdev);
 int mlx5e_close_locked(struct net_device *netdev);
@@ -1125,6 +1136,11 @@ int mlx5e_create_sq_rdy(struct mlx5_core_dev *mdev,
 void mlx5e_tx_err_cqe_work(struct work_struct *recover_work);
 void mlx5e_close_txqsq(struct mlx5e_txqsq *sq);
 
+bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled);
+bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state);
+
 static inline bool mlx5_tx_swp_supported(struct mlx5_core_dev *mdev)
 {
 	return MLX5_CAP_ETH(mdev, swp) &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
index 48581ea3adcb..3ef1fd614d75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.c
@@ -3,6 +3,7 @@
 
 #include "channels.h"
 #include "en.h"
+#include "en/dim.h"
 #include "en/ptp.h"
 
 unsigned int mlx5e_channels_get_num(struct mlx5e_channels *chs)
@@ -49,3 +50,85 @@ bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn)
 	*rqn = c->rq.rqn;
 	return true;
 }
+
+int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enable)
+{
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		int err = mlx5e_dim_rx_change(&chs->c[i]->rq, enable);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enable)
+{
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			int err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], enable);
+
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs)
+{
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		/* If dim is enabled for the channel, reset the dim state so the
+		 * collected statistics will be reset. This is useful for
+		 * supporting legacy interfaces that allow things like changing
+		 * the CQ period mode for all channels without disturbing
+		 * individual channel configurations.
+		 */
+		if (chs->c[i]->rq.dim) {
+			int err;
+
+			mlx5e_dim_rx_change(&chs->c[i]->rq, false);
+			err = mlx5e_dim_rx_change(&chs->c[i]->rq, true);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
+
+int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs)
+{
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			int err;
+
+			/* If dim is enabled for the channel, reset the dim
+			 * state so the collected statistics will be reset. This
+			 * is useful for supporting legacy interfaces that allow
+			 * things like changing the CQ period mode for all
+			 * channels without disturbing individual channel
+			 * configurations.
+			 */
+			if (!chs->c[i]->sq[tc].dim)
+				continue;
+
+			mlx5e_dim_tx_change(&chs->c[i]->sq[tc], false);
+			err = mlx5e_dim_tx_change(&chs->c[i]->sq[tc], true);
+			if (err)
+				return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
index 637ca90daaa8..3a5dc49099f5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/channels.h
@@ -13,5 +13,9 @@ bool mlx5e_channels_is_xsk(struct mlx5e_channels *chs, unsigned int ix);
 void mlx5e_channels_get_regular_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
 void mlx5e_channels_get_xsk_rqn(struct mlx5e_channels *chs, unsigned int ix, u32 *rqn);
 bool mlx5e_channels_get_ptp_rqn(struct mlx5e_channels *chs, u32 *rqn);
+int mlx5e_channels_rx_change_dim(struct mlx5e_channels *chs, bool enabled);
+int mlx5e_channels_tx_change_dim(struct mlx5e_channels *chs, bool enabled);
+int mlx5e_channels_rx_toggle_dim(struct mlx5e_channels *chs);
+int mlx5e_channels_tx_toggle_dim(struct mlx5e_channels *chs);
 
 #endif /* __MLX5_EN_CHANNELS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
index 6411ae4c6b94..110e2c6b7e51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dim.h
@@ -9,6 +9,8 @@
 #include <linux/mlx5/mlx5_ifc.h>
 
 /* Forward declarations */
+struct mlx5e_rq;
+struct mlx5e_txqsq;
 struct work_struct;
 
 /* convert a boolean value for cqe mode to appropriate dim constant
@@ -37,5 +39,7 @@ mlx5e_cq_period_mode(enum dim_cq_period_mode cq_period_mode)
 
 void mlx5e_rx_dim_work(struct work_struct *work);
 void mlx5e_tx_dim_work(struct work_struct *work);
+int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enabled);
+int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enabled);
 
 #endif /* __MLX5_EN_DIM_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 35ad76e486b9..330b4b01623c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -514,64 +514,6 @@ int mlx5e_validate_params(struct mlx5_core_dev *mdev, struct mlx5e_params *param
 	return 0;
 }
 
-static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
-{
-	struct dim_cq_moder moder = {};
-
-	moder.cq_period_mode = cq_period_mode;
-	moder.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS;
-	moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC;
-	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
-		moder.usec = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE;
-
-	return moder;
-}
-
-static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
-{
-	struct dim_cq_moder moder = {};
-
-	moder.cq_period_mode = cq_period_mode;
-	moder.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS;
-	moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC;
-	if (cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE)
-		moder.usec = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE;
-
-	return moder;
-}
-
-void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	if (params->tx_dim_enabled)
-		params->tx_cq_moderation = net_dim_get_def_tx_moderation(cq_period_mode);
-	else
-		params->tx_cq_moderation = mlx5e_get_def_tx_moderation(cq_period_mode);
-}
-
-void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	if (params->rx_dim_enabled)
-		params->rx_cq_moderation = net_dim_get_def_rx_moderation(cq_period_mode);
-	else
-		params->rx_cq_moderation = mlx5e_get_def_rx_moderation(cq_period_mode);
-}
-
-void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	mlx5e_reset_tx_moderation(params, cq_period_mode);
-	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
-			params->tx_cq_moderation.cq_period_mode ==
-				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
-}
-
-void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode)
-{
-	mlx5e_reset_rx_moderation(params, cq_period_mode);
-	MLX5E_SET_PFLAG(params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
-			params->rx_cq_moderation.cq_period_mode ==
-				DIM_CQ_PERIOD_MODE_START_FROM_CQE);
-}
-
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev)
 {
 	u32 link_speed = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 6800949dafbc..d392355be598 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -77,11 +77,6 @@ u8 mlx5e_mpwrq_max_log_rq_pkts(struct mlx5_core_dev *mdev, u8 page_shift,
 
 /* Parameter calculations */
 
-void mlx5e_reset_tx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_reset_rx_moderation(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_set_tx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
-void mlx5e_set_rx_cq_mode_params(struct mlx5e_params *params, u8 cq_period_mode);
-
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev);
 int mlx5e_mpwrq_validate_regular(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index 106a1f70dd9a..4cfda843a78e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -37,7 +37,8 @@ static void
 mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
 			struct mlx5_core_dev *mdev, struct mlx5_core_cq *mcq)
 {
-	mlx5_core_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts);
+	mlx5e_modify_cq_moderation(mdev, mcq, moder.usec, moder.pkts,
+				   mlx5e_cq_period_mode(moder.cq_period_mode));
 	dim->state = DIM_START_MEASURE;
 }
 
@@ -60,3 +61,89 @@ void mlx5e_tx_dim_work(struct work_struct *work)
 
 	mlx5e_complete_dim_work(dim, cur_moder, sq->cq.mdev, &sq->cq.mcq);
 }
+
+static struct dim *mlx5e_dim_enable(struct mlx5_core_dev *mdev,
+				    void (*work_fun)(struct work_struct *), int cpu,
+				    u8 cq_period_mode, struct mlx5_core_cq *mcq,
+				    void *queue)
+{
+	struct dim *dim;
+	int err;
+
+	dim = kvzalloc_node(sizeof(*dim), GFP_KERNEL, cpu_to_node(cpu));
+	if (!dim)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_WORK(&dim->work, work_fun);
+
+	dim->mode = cq_period_mode;
+	dim->priv = queue;
+
+	err = mlx5e_modify_cq_period_mode(mdev, mcq, dim->mode);
+	if (err) {
+		kvfree(dim);
+		return ERR_PTR(err);
+	}
+
+	return dim;
+}
+
+static void mlx5e_dim_disable(struct dim *dim)
+{
+	cancel_work_sync(&dim->work);
+	kvfree(dim);
+}
+
+int mlx5e_dim_rx_change(struct mlx5e_rq *rq, bool enable)
+{
+	if (enable == !!rq->dim)
+		return 0;
+
+	if (enable) {
+		struct mlx5e_channel *c = rq->channel;
+		struct dim *dim;
+
+		dim = mlx5e_dim_enable(rq->mdev, mlx5e_rx_dim_work, c->cpu,
+				       c->rx_moder.dim.cq_period_mode, &rq->cq.mcq, rq);
+		if (IS_ERR(dim))
+			return PTR_ERR(dim);
+
+		rq->dim = dim;
+
+		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+	} else {
+		__clear_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+
+		mlx5e_dim_disable(rq->dim);
+		rq->dim = NULL;
+	}
+
+	return 0;
+}
+
+int mlx5e_dim_tx_change(struct mlx5e_txqsq *sq, bool enable)
+{
+	if (enable == !!sq->dim)
+		return 0;
+
+	if (enable) {
+		struct mlx5e_channel *c = sq->channel;
+		struct dim *dim;
+
+		dim = mlx5e_dim_enable(sq->mdev, mlx5e_tx_dim_work, c->cpu,
+				       c->tx_moder.dim.cq_period_mode, &sq->cq.mcq, sq);
+		if (IS_ERR(dim))
+			return PTR_ERR(dim);
+
+		sq->dim = dim;
+
+		__set_bit(MLX5E_SQ_STATE_DIM, &sq->state);
+	} else {
+		__clear_bit(MLX5E_SQ_STATE_DIM, &sq->state);
+
+		mlx5e_dim_disable(sq->dim);
+		sq->dim = NULL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index b601a7db9672..422fb0f16af4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -34,6 +34,7 @@
 #include <linux/ethtool_netlink.h>
 
 #include "en.h"
+#include "en/channels.h"
 #include "en/dim.h"
 #include "en/port.h"
 #include "en/params.h"
@@ -533,16 +534,13 @@ int mlx5e_ethtool_get_coalesce(struct mlx5e_priv *priv,
 	coal->rx_coalesce_usecs		= rx_moder->usec;
 	coal->rx_max_coalesced_frames	= rx_moder->pkts;
 	coal->use_adaptive_rx_coalesce	= priv->channels.params.rx_dim_enabled;
+	kernel_coal->use_cqe_mode_rx    = priv->channels.params.rx_moder_use_cqe_mode;
 
 	tx_moder = &priv->channels.params.tx_cq_moderation;
 	coal->tx_coalesce_usecs		= tx_moder->usec;
 	coal->tx_max_coalesced_frames	= tx_moder->pkts;
 	coal->use_adaptive_tx_coalesce	= priv->channels.params.tx_dim_enabled;
-
-	kernel_coal->use_cqe_mode_rx =
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_RX_CQE_BASED_MODER);
-	kernel_coal->use_cqe_mode_tx =
-		MLX5E_GET_PFLAG(&priv->channels.params, MLX5E_PFLAG_TX_CQE_BASED_MODER);
+	kernel_coal->use_cqe_mode_tx    = priv->channels.params.tx_moder_use_cqe_mode;
 
 	return 0;
 }
@@ -561,7 +559,7 @@ static int mlx5e_get_coalesce(struct net_device *netdev,
 #define MLX5E_MAX_COAL_FRAMES		MLX5_MAX_CQ_COUNT
 
 static void
-mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
+mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int tc;
@@ -569,30 +567,38 @@ mlx5e_set_priv_channels_tx_coalesce(struct mlx5e_priv *priv, struct ethtool_coal
 
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
+		enum mlx5_cq_period_mode mode;
+
+		mode = mlx5e_cq_period_mode(c->tx_moder.dim.cq_period_mode);
+
+		c->tx_moder.coal_params.tx_coalesce_usecs = moder->usec;
+		c->tx_moder.coal_params.tx_max_coalesced_frames = moder->pkts;
 
-		c->tx_moder.coal_params = *coal;
 		for (tc = 0; tc < c->num_tc; tc++) {
-			mlx5_core_modify_cq_moderation(mdev,
-						&c->sq[tc].cq.mcq,
-						coal->tx_coalesce_usecs,
-						coal->tx_max_coalesced_frames);
+			mlx5e_modify_cq_moderation(mdev, &c->sq[tc].cq.mcq,
+						   moder->usec, moder->pkts,
+						   mode);
 		}
 	}
 }
 
 static void
-mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct ethtool_coalesce *coal)
+mlx5e_set_priv_channels_rx_coalesce(struct mlx5e_priv *priv, struct dim_cq_moder *moder)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
 	for (i = 0; i < priv->channels.num; ++i) {
 		struct mlx5e_channel *c = priv->channels.c[i];
+		enum mlx5_cq_period_mode mode;
 
-		c->rx_moder.coal_params = *coal;
-		mlx5_core_modify_cq_moderation(mdev, &c->rq.cq.mcq,
-					       coal->rx_coalesce_usecs,
-					       coal->rx_max_coalesced_frames);
+		mode = mlx5e_cq_period_mode(c->rx_moder.dim.cq_period_mode);
+
+		c->rx_moder.coal_params.rx_coalesce_usecs = moder->usec;
+		c->rx_moder.coal_params.rx_max_coalesced_frames = moder->pkts;
+
+		mlx5e_modify_cq_moderation(mdev, &c->rq.cq.mcq, moder->usec, moder->pkts,
+					   mode);
 	}
 }
 
@@ -601,15 +607,16 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 			       struct kernel_ethtool_coalesce *kernel_coal,
 			       struct netlink_ext_ack *extack)
 {
+	bool reset_rx_dim_mode, reset_tx_dim_mode;
 	struct dim_cq_moder *rx_moder, *tx_moder;
 	struct mlx5_core_dev *mdev = priv->mdev;
+	bool rx_dim_enabled, tx_dim_enabled;
 	struct mlx5e_params new_params;
-	bool reset_rx, reset_tx;
-	bool reset = true;
 	u8 cq_period_mode;
 	int err = 0;
 
-	if (!MLX5_CAP_GEN(mdev, cq_moderation))
+	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
+	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify))
 		return -EOPNOTSUPP;
 
 	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
@@ -632,60 +639,74 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+
 	mutex_lock(&priv->state_lock);
 	new_params = priv->channels.params;
 
-	rx_moder          = &new_params.rx_cq_moderation;
-	rx_moder->usec    = coal->rx_coalesce_usecs;
-	rx_moder->pkts    = coal->rx_max_coalesced_frames;
-	new_params.rx_dim_enabled = !!coal->use_adaptive_rx_coalesce;
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
+	reset_rx_dim_mode = mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
+							       rx_dim_enabled, false);
+	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER, cq_period_mode);
 
-	tx_moder          = &new_params.tx_cq_moderation;
-	tx_moder->usec    = coal->tx_coalesce_usecs;
-	tx_moder->pkts    = coal->tx_max_coalesced_frames;
-	new_params.tx_dim_enabled = !!coal->use_adaptive_tx_coalesce;
+	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
+	reset_tx_dim_mode = mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
+							       tx_dim_enabled, false);
+	MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER, cq_period_mode);
 
-	reset_rx = !!coal->use_adaptive_rx_coalesce != priv->channels.params.rx_dim_enabled;
-	reset_tx = !!coal->use_adaptive_tx_coalesce != priv->channels.params.tx_dim_enabled;
+	if (reset_rx_dim_mode)
+		mlx5e_channels_rx_change_dim(&priv->channels, false);
+	if (reset_tx_dim_mode)
+		mlx5e_channels_tx_change_dim(&priv->channels, false);
 
-	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_rx);
-	if (cq_period_mode != rx_moder->cq_period_mode) {
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-		reset_rx = true;
-	}
+	/* DIM enable/disable Rx and Tx channels */
+	err = mlx5e_channels_rx_change_dim(&priv->channels, rx_dim_enabled);
+	if (err)
+		goto state_unlock;
+	err = mlx5e_channels_tx_change_dim(&priv->channels, tx_dim_enabled);
+	if (err)
+		goto state_unlock;
 
-	cq_period_mode = mlx5e_dim_cq_period_mode(kernel_coal->use_cqe_mode_tx);
-	if (cq_period_mode != tx_moder->cq_period_mode) {
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
-		reset_tx = true;
-	}
+	/* Solely used for global ethtool get coalesce */
+	rx_moder = &new_params.rx_cq_moderation;
+	new_params.rx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_rx;
 
-	if (reset_rx) {
-		u8 mode = MLX5E_GET_PFLAG(&new_params,
-					  MLX5E_PFLAG_RX_CQE_BASED_MODER);
+	tx_moder = &new_params.tx_cq_moderation;
+	new_params.tx_moder_use_cqe_mode = kernel_coal->use_cqe_mode_tx;
 
-		mlx5e_reset_rx_moderation(&new_params, mode);
-	}
-	if (reset_tx) {
-		u8 mode = MLX5E_GET_PFLAG(&new_params,
-					  MLX5E_PFLAG_TX_CQE_BASED_MODER);
+	/* Only set coalesce parameters if DIM has been previously disabled */
+	if (!rx_dim_enabled && !new_params.rx_dim_enabled) {
+		rx_moder->usec = coal->rx_coalesce_usecs;
+		rx_moder->pkts = coal->rx_max_coalesced_frames;
+
+		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
+	} else if (!rx_dim_enabled || !new_params.rx_dim_enabled ||
+		   reset_rx_dim_mode) {
+		mlx5e_reset_rx_moderation(rx_moder, new_params.rx_moder_use_cqe_mode,
+					  rx_dim_enabled);
 
-		mlx5e_reset_tx_moderation(&new_params, mode);
+		mlx5e_set_priv_channels_rx_coalesce(priv, rx_moder);
 	}
 
-	/* If DIM state hasn't changed, it's possible to modify interrupt
-	 * moderation parameters on the fly, even if the channels are open.
-	 */
-	if (!reset_rx && !reset_tx && test_bit(MLX5E_STATE_OPENED, &priv->state)) {
-		if (!coal->use_adaptive_rx_coalesce)
-			mlx5e_set_priv_channels_rx_coalesce(priv, coal);
-		if (!coal->use_adaptive_tx_coalesce)
-			mlx5e_set_priv_channels_tx_coalesce(priv, coal);
-		reset = false;
+	if (!tx_dim_enabled && !new_params.tx_dim_enabled) {
+		tx_moder->usec = coal->tx_coalesce_usecs;
+		tx_moder->pkts = coal->tx_max_coalesced_frames;
+
+		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
+	} else if (!tx_dim_enabled || !new_params.tx_dim_enabled ||
+		   reset_tx_dim_mode) {
+		mlx5e_reset_tx_moderation(tx_moder, new_params.tx_moder_use_cqe_mode,
+					  tx_dim_enabled);
+
+		mlx5e_set_priv_channels_tx_coalesce(priv, tx_moder);
 	}
 
-	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, reset);
+	new_params.rx_dim_enabled = rx_dim_enabled;
+	new_params.tx_dim_enabled = tx_dim_enabled;
 
+	err = mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
+state_unlock:
 	mutex_unlock(&priv->state_lock);
 	return err;
 }
@@ -1872,12 +1893,22 @@ static int set_pflag_cqe_based_moder(struct net_device *netdev, bool enable,
 		return 0;
 
 	new_params = priv->channels.params;
-	if (is_rx_cq)
-		mlx5e_set_rx_cq_mode_params(&new_params, cq_period_mode);
-	else
-		mlx5e_set_tx_cq_mode_params(&new_params, cq_period_mode);
+	if (is_rx_cq) {
+		mlx5e_reset_rx_channels_moderation(&priv->channels, cq_period_mode,
+						   false, true);
+		mlx5e_channels_rx_toggle_dim(&priv->channels);
+		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_RX_CQE_BASED_MODER,
+				cq_period_mode);
+	} else {
+		mlx5e_reset_tx_channels_moderation(&priv->channels, cq_period_mode,
+						   false, true);
+		mlx5e_channels_tx_toggle_dim(&priv->channels);
+		MLX5E_SET_PFLAG(&new_params, MLX5E_PFLAG_TX_CQE_BASED_MODER,
+				cq_period_mode);
+	}
 
-	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, true);
+	/* Update pflags of existing channels without resetting them */
+	return mlx5e_safe_switch_params(priv, &new_params, NULL, NULL, false);
 }
 
 static int set_pflag_tx_cqe_based_moder(struct net_device *netdev, bool enable)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2ce87f918d3b..a24d58a2cf06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -961,20 +961,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		}
 	}
 
-	rq->dim = kvzalloc_node(sizeof(*rq->dim), GFP_KERNEL, node);
-	if (!rq->dim) {
-		err = -ENOMEM;
-		goto err_unreg_xdp_rxq_info;
-	}
-
-	rq->dim->priv = rq;
-	INIT_WORK(&rq->dim->work, mlx5e_rx_dim_work);
-	rq->dim->mode = params->rx_cq_moderation.cq_period_mode;
-
 	return 0;
 
-err_unreg_xdp_rxq_info:
-	xdp_rxq_info_unreg(&rq->xdp_rxq);
 err_destroy_page_pool:
 	page_pool_destroy(rq->page_pool);
 err_free_by_rq_type:
@@ -1302,8 +1290,16 @@ int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *param,
 	if (MLX5_CAP_ETH(mdev, cqe_checksum_full))
 		__set_bit(MLX5E_RQ_STATE_CSUM_FULL, &rq->state);
 
-	if (params->rx_dim_enabled)
-		__set_bit(MLX5E_RQ_STATE_DIM, &rq->state);
+	if (params->rx_dim_enabled) {
+		u8 cq_period = params->tx_moder_use_cqe_mode ?
+				       DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+				       DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
+		mlx5e_reset_rx_moderation(&rq->channel->rx_moder.dim, cq_period, true);
+		err = mlx5e_dim_rx_change(rq, true);
+		if (err)
+			goto err_destroy_rq;
+	}
 
 	/* We disable csum_complete when XDP is enabled since
 	 * XDP programs might manipulate packets which will render
@@ -1349,7 +1345,8 @@ void mlx5e_deactivate_rq(struct mlx5e_rq *rq)
 
 void mlx5e_close_rq(struct mlx5e_rq *rq)
 {
-	cancel_work_sync(&rq->dim->work);
+	if (rq->dim)
+		cancel_work_sync(&rq->dim->work);
 	cancel_work_sync(&rq->recover_work);
 	mlx5e_destroy_rq(rq);
 	mlx5e_free_rx_descs(rq);
@@ -1624,20 +1621,9 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	err = mlx5e_alloc_txqsq_db(sq, cpu_to_node(c->cpu));
 	if (err)
 		goto err_sq_wq_destroy;
-	sq->dim = kvzalloc_node(sizeof(*sq->dim), GFP_KERNEL, cpu_to_node(c->cpu));
-	if (!sq->dim) {
-		err = -ENOMEM;
-		goto err_free_txqsq_db;
-	}
-
-	sq->dim->priv = sq;
-	INIT_WORK(&sq->dim->work, mlx5e_tx_dim_work);
-	sq->dim->mode = params->tx_cq_moderation.cq_period_mode;
 
 	return 0;
 
-err_free_txqsq_db:
-	mlx5e_free_txqsq_db(sq);
 err_sq_wq_destroy:
 	mlx5_wq_destroy(&sq->wq_ctrl);
 
@@ -1802,11 +1788,21 @@ int mlx5e_open_txqsq(struct mlx5e_channel *c, u32 tisn, int txq_ix,
 	if (tx_rate)
 		mlx5e_set_sq_maxrate(c->netdev, sq, tx_rate);
 
-	if (params->tx_dim_enabled)
-		sq->state |= BIT(MLX5E_SQ_STATE_DIM);
+	if (params->tx_dim_enabled) {
+		u8 cq_period = params->tx_moder_use_cqe_mode ?
+				       DIM_CQ_PERIOD_MODE_START_FROM_CQE :
+				       DIM_CQ_PERIOD_MODE_START_FROM_EQE;
+
+		mlx5e_reset_tx_moderation(&sq->channel->tx_moder.dim, cq_period, true);
+		err = mlx5e_dim_tx_change(sq, true);
+		if (err)
+			goto err_destroy_sq;
+	}
 
 	return 0;
 
+err_destroy_sq:
+	mlx5e_destroy_sq(c->mdev, sq->sqn);
 err_free_txqsq:
 	mlx5e_free_txqsq(sq);
 
@@ -1858,7 +1854,8 @@ void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 	struct mlx5_core_dev *mdev = sq->mdev;
 	struct mlx5_rate_limit rl = {0};
 
-	cancel_work_sync(&sq->dim->work);
+	if (sq->dim)
+		cancel_work_sync(&sq->dim->work);
 	cancel_work_sync(&sq->recover_work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
@@ -1877,6 +1874,58 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
 	mlx5e_reporter_tx_err_cqe(sq);
 }
 
+static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
+{
+	return (struct dim_cq_moder) {
+		.cq_period_mode = cq_period_mode,
+		.pkts = MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_PKTS,
+		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC_FROM_CQE :
+				MLX5E_PARAMS_DEFAULT_TX_CQ_MODERATION_USEC,
+	};
+}
+
+bool mlx5e_reset_tx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled)
+{
+	bool reset_needed = dim_enabled && cq_moder->cq_period_mode != cq_period_mode;
+
+	if (dim_enabled)
+		*cq_moder = net_dim_get_def_tx_moderation(cq_period_mode);
+	else
+		*cq_moder = mlx5e_get_def_tx_moderation(cq_period_mode);
+
+	return reset_needed;
+}
+
+bool mlx5e_reset_tx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state)
+{
+	bool reset = false;
+	int i, tc;
+
+	for (i = 0; i < chs->num; i++) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			if (keep_dim_state)
+				dim_enabled = !!chs->c[i]->sq[tc].dim;
+
+			reset |= mlx5e_reset_tx_moderation(&chs->c[i]->tx_moder.dim,
+							   cq_period_mode, dim_enabled);
+		}
+	}
+
+	if (chs->ptp) {
+		for (tc = 0; tc < mlx5e_get_dcb_num_tc(&chs->params); tc++) {
+			struct mlx5e_txqsq *txqsq = &chs->ptp->ptpsq[tc].txqsq;
+
+			mlx5e_reset_tx_moderation(&txqsq->channel->tx_moder.dim,
+						  cq_period_mode, false);
+		}
+	}
+
+	return reset;
+}
+
 static int mlx5e_open_icosq(struct mlx5e_channel *c, struct mlx5e_params *params,
 			    struct mlx5e_sq_param *param, struct mlx5e_icosq *sq,
 			    work_func_t recover_work_func)
@@ -2100,7 +2149,8 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	MLX5_SET(cqc,   cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
+	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(param->cq_period_mode));
+
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
@@ -2138,8 +2188,10 @@ int mlx5e_open_cq(struct mlx5_core_dev *mdev, struct dim_cq_moder moder,
 	if (err)
 		goto err_free_cq;
 
-	if (MLX5_CAP_GEN(mdev, cq_moderation))
-		mlx5_core_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts);
+	if (MLX5_CAP_GEN(mdev, cq_moderation) &&
+	    MLX5_CAP_GEN(mdev, cq_period_mode_modify))
+		mlx5e_modify_cq_moderation(mdev, &cq->mcq, moder.usec, moder.pkts,
+					   mlx5e_cq_period_mode(moder.cq_period_mode));
 	return 0;
 
 err_free_cq:
@@ -2154,6 +2206,40 @@ void mlx5e_close_cq(struct mlx5e_cq *cq)
 	mlx5e_free_cq(cq);
 }
 
+int mlx5e_modify_cq_period_mode(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+				u8 cq_period_mode)
+{
+	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
+	void *cqc;
+
+	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
+	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, cq_period_mode, mlx5e_cq_period_mode(cq_period_mode));
+	MLX5_SET(modify_cq_in, in,
+		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
+		 MLX5_CQ_MODIFY_PERIOD_MODE);
+
+	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
+}
+
+int mlx5e_modify_cq_moderation(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
+			       u16 cq_period, u16 cq_max_count, u8 cq_period_mode)
+{
+	u32 in[MLX5_ST_SZ_DW(modify_cq_in)] = {};
+	void *cqc;
+
+	MLX5_SET(modify_cq_in, in, cqn, cq->cqn);
+	cqc = MLX5_ADDR_OF(modify_cq_in, in, cq_context);
+	MLX5_SET(cqc, cqc, cq_period, cq_period);
+	MLX5_SET(cqc, cqc, cq_max_count, cq_max_count);
+	MLX5_SET(cqc, cqc, cq_period_mode, cq_period_mode);
+	MLX5_SET(modify_cq_in, in,
+		 modify_field_select_resize_field_select.modify_field_select.modify_field_select,
+		 MLX5_CQ_MODIFY_PERIOD | MLX5_CQ_MODIFY_COUNT | MLX5_CQ_MODIFY_PERIOD_MODE);
+
+	return mlx5_core_modify_cq(dev, cq, in, sizeof(in));
+}
+
 static int mlx5e_open_tx_cqs(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct mlx5e_create_cq_param *ccp,
@@ -3959,6 +4045,52 @@ static int set_feature_rx_all(struct net_device *netdev, bool enable)
 	return mlx5_set_port_fcs(mdev, !enable);
 }
 
+static struct dim_cq_moder mlx5e_get_def_rx_moderation(u8 cq_period_mode)
+{
+	return (struct dim_cq_moder) {
+		.cq_period_mode = cq_period_mode,
+		.pkts = MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_PKTS,
+		.usec = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE :
+				MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC,
+	};
+}
+
+bool mlx5e_reset_rx_moderation(struct dim_cq_moder *cq_moder, u8 cq_period_mode,
+			       bool dim_enabled)
+{
+	bool reset_needed = dim_enabled &&
+			    cq_moder->cq_period_mode != cq_period_mode;
+
+	if (dim_enabled)
+		*cq_moder = net_dim_get_def_rx_moderation(cq_period_mode);
+	else
+		*cq_moder = mlx5e_get_def_rx_moderation(cq_period_mode);
+
+	return reset_needed;
+}
+
+bool mlx5e_reset_rx_channels_moderation(struct mlx5e_channels *chs, u8 cq_period_mode,
+					bool dim_enabled, bool keep_dim_state)
+{
+	bool reset = false;
+	int i;
+
+	for (i = 0; i < chs->num; i++) {
+		if (keep_dim_state)
+			dim_enabled = !!chs->c[i]->rq.dim;
+
+		reset |= mlx5e_reset_rx_moderation(&chs->c[i]->rx_moder.dim,
+						   cq_period_mode, dim_enabled);
+	}
+
+	if (chs->ptp)
+		mlx5e_reset_rx_moderation(&chs->ptp->rq.channel->rx_moder.dim,
+					  cq_period_mode, false);
+
+	return reset;
+}
+
 static int mlx5e_set_rx_port_ts(struct mlx5_core_dev *mdev, bool enable)
 {
 	u32 in[MLX5_ST_SZ_DW(pcmr_reg)] = {};
@@ -5026,7 +5158,6 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 {
 	struct mlx5e_params *params = &priv->channels.params;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u8 rx_cq_period_mode;
 
 	params->sw_mtu = mtu;
 	params->hard_mtu = MLX5E_ETH_HARD_MTU;
@@ -5060,12 +5191,16 @@ void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16
 	params->packet_merge.timeout = mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_LRO_TIMEOUT);
 
 	/* CQ moderation params */
-	rx_cq_period_mode =
-		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
-	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	mlx5e_set_rx_cq_mode_params(params, rx_cq_period_mode);
-	mlx5e_set_tx_cq_mode_params(params, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
+	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
+				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
+	params->tx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation) &&
+				 MLX5_CAP_GEN(mdev, cq_period_mode_modify);
+	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
+	params->tx_moder_use_cqe_mode = false;
+	mlx5e_reset_rx_moderation(&params->rx_cq_moderation, params->rx_moder_use_cqe_mode,
+				  params->rx_dim_enabled);
+	mlx5e_reset_tx_moderation(&params->tx_cq_moderation, params->tx_moder_use_cqe_mode,
+				  params->tx_dim_enabled);
 
 	/* TX inline */
 	mlx5_query_min_inline(mdev, &params->tx_min_inline_mode);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index d38ae33440fc..92595ada1f70 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -806,9 +806,6 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_params *params;
 
-	u8 cq_period_mode =
-		mlx5e_dim_cq_period_mode(MLX5_CAP_GEN(mdev, cq_period_start_from_cqe));
-
 	params = &priv->channels.params;
 
 	params->num_channels = MLX5E_REP_PARAMS_DEF_NUM_CHANNELS;
@@ -836,7 +833,7 @@ static void mlx5e_build_rep_params(struct net_device *netdev)
 
 	/* CQ moderation params */
 	params->rx_dim_enabled = MLX5_CAP_GEN(mdev, cq_moderation);
-	mlx5e_set_rx_cq_mode_params(params, cq_period_mode);
+	params->rx_moder_use_cqe_mode = !!MLX5_CAP_GEN(mdev, cq_period_start_from_cqe);
 
 	params->mqprio.num_tc       = 1;
 	if (rep->vport != MLX5_VPORT_UPLINK)
diff --git a/include/linux/mlx5/cq.h b/include/linux/mlx5/cq.h
index cb15308b5cb0..991526039ccb 100644
--- a/include/linux/mlx5/cq.h
+++ b/include/linux/mlx5/cq.h
@@ -95,9 +95,10 @@ enum {
 };
 
 enum {
-	MLX5_CQ_MODIFY_PERIOD	= 1 << 0,
-	MLX5_CQ_MODIFY_COUNT	= 1 << 1,
-	MLX5_CQ_MODIFY_OVERRUN	= 1 << 2,
+	MLX5_CQ_MODIFY_PERIOD		= BIT(0),
+	MLX5_CQ_MODIFY_COUNT		= BIT(1),
+	MLX5_CQ_MODIFY_OVERRUN		= BIT(2),
+	MLX5_CQ_MODIFY_PERIOD_MODE	= BIT(4),
 };
 
 enum {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f7f1f058491f..ccb668303b03 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1668,7 +1668,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         cq_oi[0x1];
 	u8         cq_resize[0x1];
 	u8         cq_moderation[0x1];
-	u8         reserved_at_223[0x3];
+	u8         cq_period_mode_modify[0x1];
+	u8         reserved_at_224[0x2];
 	u8         cq_eq_remap[0x1];
 	u8         pg[0x1];
 	u8         block_lb_mc[0x1];
-- 
2.42.0


