Return-Path: <netdev+bounces-207116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B934B05D04
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2514A2ED5
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01622E5B2B;
	Tue, 15 Jul 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YTzjMEfW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B252E5B39
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586149; cv=fail; b=EC0Dn/5yCSgyyNrzN7BPAZ8bqifo7hjd/PWahJjRqt5s99Vf1Lclii6sJGec1fssVSoGTsbUh/4RH7VBYtp+xlX/EH6iK+swMHQxmKND1z9wI+2io4NFV+WljZEok7UNMBGXBbfoQ9p/m5sRx9pK4pViwe+8WiBvRpXoMav9Fvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586149; c=relaxed/simple;
	bh=PVN+4NZoF4bSgls6OLtcCPRUFkzpltqSqss6KPQAQVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pzJZPy3cFf96EadpT1YJsyh0JYRc+Yi0sJ49XJZoCr5dAi/umnIekXW1L4QockFSgL6iaR9mKqaFidQkwAOCKkeMvtNchq0XWSsrM/brR/r9rdke/8IGeof4AWeL8iKjy8+frbfp9iLtahatENJnMmDKhpDCgDv1bbOjo+oEeoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YTzjMEfW; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp2SMOzC1s4bebuQ/plZDNDuBd66ybiFm3lNXJFDtd+aAvSLiD25V5q8vsuRlepQE64IUdDtuKaCaa1mNEYeWpEiIvEd4OEQoTdN1aDVn2Bd4L4Ou+D8lk30FgPKLbEsYY/X4bp8k9WF1B0i+HJ9z7fcYmBaMYqvpwYcUN3plFY1T4aNGxiKqil95cs3/SRDrW+xHnr4YfJ6RZ6XJdNg2WjeMeeTaz0DRuNb1GWKkeae+u2IGEZFJQPgeVMO+8lf7jnhCoEIKIcomyZBRewhHrqBeD19bUGkpfciW+SEyQF6oICITSeEMam5CePjbcpuSoMMq96DP1HS6nHKgi3ZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qugXGLBfYR5Dnc1jxyEJOdbcssAsmAGN5yXNdHZWyQw=;
 b=pYSGta7Iyt/7384f9MOqLlUDfiKs3vvARoPMClOmu+cUIIhe/r/hV0HGXvt49MfnX/utKkMsaHv5Qsx1M6bBOuLG7UYabyeTi/KobYLnC34s5SNSdYTnzZ6mP61VYymPuZeZmjzutsTWkJmSWwctOtLR7Tk3gP00wbIG1H2EOn5miv4otMhyWWDo2BbYVvVCWw5bSkPIv1imbnUQGJ8nSytPGj8Jl3lDJ9NCHH1Hl+Ea3HMjZF4kAmnftSBoXkwLjM+NygcTsVddiu8UDhCg0vXkaqHTRkzWYQqRd0lDbUEeOkglzBmaPvCl1GpJctYIUSpGyG2JAU6dr9bqEa2rrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qugXGLBfYR5Dnc1jxyEJOdbcssAsmAGN5yXNdHZWyQw=;
 b=YTzjMEfWf++7z+/77/1MmHZORbb7OMobkjMifu4j95qV4X+QGPsk6lGSq0TKK+pZ7vAlhTkmB3id8xntzd25SXgYo504tRsd0NbRoqR1A/6z7R95DajvUAbmiCyQIwYsWg4fPqGLsKyP5tLdYzG/UO96WBpVWFk2qX6xqW+l+ftU7/4YUeJRtXIdmocSAvXfaTj5K+NWnNoix05wukWdEmsmz4Zesj/7ZtaaSy504QrRHTHt5r5AGOhC160496nhhhXvt/6QIlEaMsK2JnwiayAeAi9HgP3PSqNxhN6AyYFHFe5NORbXRhqfuKeXhDHlw3OhFq4FXlpLV+vxvsakxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:29:04 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8901.023; Tue, 15 Jul 2025
 13:29:04 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com,
	tariqt@nvidia.com,
	gus@collabora.com
Subject: [PATCH v30 12/20] net/mlx5: Add NVMEoTCP caps, HW bits, 128B CQE and enumerations
Date: Tue, 15 Jul 2025 13:27:41 +0000
Message-Id: <20250715132750.9619-13-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0021.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6c24e0-0186-4016-90dc-08ddc3a3916c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fi0hketkmGELsjSMufninYkPqLDgoxHjVHJ+nbyb8THQgk3F5cYKAQmkWtnC?=
 =?us-ascii?Q?QJxQb+Xg+QL5UZRHAZs1DvObEe1svdmukb7AQ30UFL1I/f8QCBKLf5xss6SG?=
 =?us-ascii?Q?tz4xYPGPZSLi3JaMu+nvQyfmXqQH6qw1PzqjmlZCCPRrYA9wdge3Q/x89Su+?=
 =?us-ascii?Q?c6z6WM+V9OAWao2QOwirptrvtsC4lH1PvqSLBXJFYN72IDv24pPa5IxGMehA?=
 =?us-ascii?Q?tVsN8IEd3VdfnP8nsrqXdI+a1Ca8k0Z7RcDZcIyatY4YyQNZiF+Om+LFlDbg?=
 =?us-ascii?Q?FrMNDoJm1orCGuHSDvmbgF4cXgppajERuwfT5iUeD+49G0O2o3HhiiLAiifN?=
 =?us-ascii?Q?3uL59H3iq+YKb7fA/2TUwPrxjSt+LexYcTqESpZnsEU/Qz57/0PclFeFA2xZ?=
 =?us-ascii?Q?8jYduzG7/8D7mVs2+11/xpBv50sf+A06ftb48IsasrNz9NrotJQV+4CwlgJr?=
 =?us-ascii?Q?xp8rLnGOyBF1sUQjPKzO0Gvi8VBabNaER7JRcH9k7rfKoBeOM0QQNR/Q4W1X?=
 =?us-ascii?Q?ymlKrzCMbwmNG/ssSsLMKNhWu1/tnJjK/CBSVX0LSt8vYmzZnpcwSIMfNK3d?=
 =?us-ascii?Q?ng8tel4IsDQAqJb0miBPy+/9sUNOCqrYxynHnvuK4qhXZh1LAWJNpV8lM5aV?=
 =?us-ascii?Q?4IZyNcVRXYy7f6FNkccgRmh18+nhMiTTmjFSgfVzakQwRs+hJWX1dE2a3FW0?=
 =?us-ascii?Q?CtQh6EC9hJgz1OxeJPsNbXUnbfWl5iE5m71jVHq9U5jcBNwu9NlIYyZATert?=
 =?us-ascii?Q?RYs/6ZQlOkHAze0PAxXfirLLTLgIRETT87yOa+BpATjlgG/T3y7iH/DdrBsw?=
 =?us-ascii?Q?KM64E3Pkgjq8a+v7nIrF3dHWQy5Xf/I3s3ym9AyxkxTokbI1IfVyWFcdGWXl?=
 =?us-ascii?Q?FYE5RS49JlKDZ8U6g3JxSRognxsGGQoQODkUnT4iYQsSYGKO2pzQaI9YGNBd?=
 =?us-ascii?Q?A8eCvFRdRPdB/ljMRA8ZH6zYiEdEJKqYBO8Uc62Ns2OBlt9xN0LQc6Lxn/67?=
 =?us-ascii?Q?6SuYIlm+aBAsy/+FPi1PirEnmypXNE43tf5tYouxGPKYFnXMbFOi7gXsrbMI?=
 =?us-ascii?Q?FZjOis2KbYMtXMgJvmhgltnC7QrLyTtO5OSz69c4twKyZCa1bue+sCeIOJD+?=
 =?us-ascii?Q?6d9CO81knvojwrIwdOxoRFRSuRjW9y1Ff5nu8SmUSVfh1flj+nHm7e/ArwG6?=
 =?us-ascii?Q?kFI8R2v0tT3UpSQKlVKInC12H9ZZeNffSbsw2nvpY+18SL97wRjq38y/g6YJ?=
 =?us-ascii?Q?S4Upyzg56kOVRs7YcNGANtIpR9POqvW1ek0WRuA8RWZoe/Qcng34zT+2lcCO?=
 =?us-ascii?Q?/LB0828QcZ9YUz/mbblIpxu+vKzzUsQ4Tw6NhELoelHcXfdAzmgj0ImGM01p?=
 =?us-ascii?Q?lNWX7ZdRzidR5jKb5Vf9ODYCALmR+SiqWKJfMyS0hTVempxy2j0rojHswZ0G?=
 =?us-ascii?Q?3UWr7tAiXdg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5dmIc9YStR0fQn+fsdMvrWJXWDOU6f/2tsqHjSAJUzmEh4P9C/dWbKsecytC?=
 =?us-ascii?Q?n+hdsOuhh/KQYnCaVsTgKczJqKjiyFBqIjeJ7HBez+ll0teH7bSZJpKZlIPX?=
 =?us-ascii?Q?09quvtvL7C2g+b9EpBfTgbR8IC1VQ2PtxRX0La0tM9yN/p0ZvIH3Nfx+7K3A?=
 =?us-ascii?Q?C1FDyF9Te7c2sfusq9wPcMW3KMJCqp3T1AGnJ+W5FPkFVepo7g+XNxmyl0AM?=
 =?us-ascii?Q?lK5RhBA2Riks3kt20oMnckWkhdp0FosMeiyp+TWGZdnYCESei4zjdYlnEVfJ?=
 =?us-ascii?Q?HsIFlhUyqv7uAKvPxc2nOD2/JbgR4lFUO4Xq26yTIODW7MczgAZSLl9nxY2j?=
 =?us-ascii?Q?pvZYM98IFkeso6ebT/JghEIH6YC7dWDGN/dKhjIO7czQD/IBdPMqNTtV93VF?=
 =?us-ascii?Q?UC/MsQ62n3lu6ujw43ijNXNnhyexeZH5PbPxanqAnlH0hwDgufxucV+RXt9l?=
 =?us-ascii?Q?L9+Op61dQCiUYYY53jud3aFl1kyTkNx+R/5+yU802cHCBtM2FFbRp+sLojdU?=
 =?us-ascii?Q?jQ5R3Jt7u+LLlaH+2qI+tMgJsaJloAZjtGoP+bDFK99UKOlKjC4SMwWtBoQ/?=
 =?us-ascii?Q?9P5RCLhjALXWC0r1j9gBwIijczWdeS5io14jbSTMIaD4oiPFgNugoLhlpbgZ?=
 =?us-ascii?Q?jt1MLTKTtP4+YoOqeMsyDHx4etx2VongwemJf1pfGiEUOjm77wTAG3UnMcfc?=
 =?us-ascii?Q?z6btedbWb+8tOzrVY4W9bmEhM4X+41bz82k2m8nPpoASlvAkYK9vj9Fd9kym?=
 =?us-ascii?Q?yyjz9aPuhkxn8TAR4nCIpQ/R9uE0FtkBgguPMbmg1/ieESy2aZDCltaI4LDt?=
 =?us-ascii?Q?w9SM793TNo1a0XgYRYPeOABNfiOUzI+ZcnbjBJCMd3oGgrbaeWZqsbxj4KQi?=
 =?us-ascii?Q?u9tVcN0BzLAYg1zM9YMvpLkdLC6pePb41lO0zc2Uphz3989KN82A0YTZSNW5?=
 =?us-ascii?Q?DED6oyVsPPcEmKIW28f7J5tjHK4ZIzr2vHoRN1VHhxv7jBSQ9DQfH3sr4aJh?=
 =?us-ascii?Q?g3vYtHiHboZtERjOTblJ9CN4HcuWDm9CwH8Zv/VTK216Ia/phkJWU6unmUER?=
 =?us-ascii?Q?gMsyRyBct/KSBKOeSaB0i8PGatt8dCEE2P7mgCremipeCmgBNzmNxt49BL3I?=
 =?us-ascii?Q?Sqe+VUUDcrn8MsiKHrDpZvv18UvhFlKXSBvEfvwXomT04p3vgiTm8LUj1flT?=
 =?us-ascii?Q?/CZG2pAjaUuRNOw68e+5IiEDX9YbLnCa4u8BU84DErIa9oUa60jGTEV6jzi0?=
 =?us-ascii?Q?h97/ROhAH6ZKLVNaIG2oRADYUCBz+erpeX1WYHrZ7g5wSJpPBDmzFlDx8Ed8?=
 =?us-ascii?Q?G3CCR6M4UsQ+qSSGMPgWxzestZgK2zuP2qkZzaH7eORWYqqxaxXtwJvToTe2?=
 =?us-ascii?Q?SXV6UwVTIlkSlRS+JZYSrQTkMvA/f7mPq/+Rlr5dqBgGxV9W87eNMABzlJXJ?=
 =?us-ascii?Q?Z29Q+NehjzIvrYD+ov8znjG3vu+f2wUTNThOMj7i14o89KuQY3ts4LTBiIlv?=
 =?us-ascii?Q?FRZbkE0l2Ig+4LxjvlYcN4ZRfBFBYVc0r5pPXO2JkQQ1+X2iwJ8UmmI7dHRM?=
 =?us-ascii?Q?YqUUGeZ4LxzMwC6/swx6Qy+oDaffCCj+kAZKpSJ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6c24e0-0186-4016-90dc-08ddc3a3916c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:29:04.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0pUB/qZhqxwH5iDtLZP+Fm3jRxQcv1g1ZYPd71spEerBvBLgL/dpVm5XcOnrnCTV8KzB5EYpuoAOKL5BpOnWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

From: Ben Ben-Ishay <benishay@nvidia.com>

Add the necessary infrastructure for NVMEoTCP offload:
- Create mlx5_cqe128 structure for NVMEoTCP offload.
  The new structure consist from the regular mlx5_cqe64 +
  NVMEoTCP data information for offloaded packets.
- Add nvmetcp field to mlx5_cqe64, this field define the type
  of the data that the additional NVMEoTCP part represents.
- Add nvmeotcp_zero_copy_en + nvmeotcp_crc_en bit
  to the TIR, for identify NVMEoTCP offload flow
  and tag_buffer_id that will be used by the
  connected nvmeotcp_queues.
- Add new capability to HCA_CAP that represents the
  NVMEoTCP offload ability.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  6 ++
 include/linux/mlx5/device.h                  | 51 ++++++++++++-
 include/linux/mlx5/mlx5_ifc.h                | 77 +++++++++++++++++++-
 include/linux/mlx5/qp.h                      |  1 +
 4 files changed, 130 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 57476487e31f..a1b437b91c4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -294,6 +294,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, nvmeotcp)) {
+		err = mlx5_core_get_caps(dev, MLX5_CAP_DEV_NVMEOTCP);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 1f53befa2514..bd6c25155dfb 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -265,6 +265,7 @@ enum {
 enum {
 	MLX5_MKEY_MASK_LEN		= 1ull << 0,
 	MLX5_MKEY_MASK_PAGE_SIZE	= 1ull << 1,
+	MLX5_MKEY_MASK_XLT_OCT_SIZE     = 1ull << 2,
 	MLX5_MKEY_MASK_START_ADDR	= 1ull << 6,
 	MLX5_MKEY_MASK_PD		= 1ull << 7,
 	MLX5_MKEY_MASK_EN_RINVAL	= 1ull << 8,
@@ -822,7 +823,11 @@ struct mlx5_err_cqe {
 
 struct mlx5_cqe64 {
 	u8		tls_outer_l3_tunneled;
-	u8		rsvd0;
+	u8		rsvd16bit:4;
+	u8		nvmeotcp_zc:1;
+	u8		nvmeotcp_ddgst:1;
+	u8		nvmeotcp_resync:1;
+	u8		rsvd23bit:1;
 	__be16		wqe_id;
 	union {
 		struct {
@@ -871,6 +876,19 @@ struct mlx5_cqe64 {
 	u8		op_own;
 };
 
+struct mlx5e_cqe128 {
+	__be16 cclen;
+	__be16 hlen;
+	union {
+		__be32 resync_tcp_sn;
+		__be32 ccoff;
+	};
+	__be16 ccid;
+	__be16 rsvd8;
+	u8 rsvd12[52];
+	struct mlx5_cqe64 cqe64;
+};
+
 struct mlx5_mini_cqe8 {
 	union {
 		__be32 rx_hash_result;
@@ -906,6 +924,28 @@ enum {
 
 #define MLX5_MINI_CQE_ARRAY_SIZE 8
 
+static inline bool cqe_is_nvmeotcp_resync(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_resync;
+}
+
+static inline bool cqe_is_nvmeotcp_crcvalid(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_ddgst;
+}
+
+static inline bool cqe_is_nvmeotcp_zc(struct mlx5_cqe64 *cqe)
+{
+	return cqe->nvmeotcp_zc;
+}
+
+/* check if cqe is zc or crc or resync */
+static inline bool cqe_is_nvmeotcp(struct mlx5_cqe64 *cqe)
+{
+	return cqe_is_nvmeotcp_zc(cqe) || cqe_is_nvmeotcp_crcvalid(cqe) ||
+	       cqe_is_nvmeotcp_resync(cqe);
+}
+
 static inline u8 mlx5_get_cqe_format(struct mlx5_cqe64 *cqe)
 {
 	return (cqe->op_own >> 2) & 0x3;
@@ -1246,6 +1286,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_VDPA_EMULATION = 0x13,
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
+	MLX5_CAP_DEV_NVMEOTCP = 0x19,
 	MLX5_CAP_CRYPTO = 0x1a,
 	MLX5_CAP_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
@@ -1487,6 +1528,14 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_SHAMPO(mdev, cap) \
 	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
 
+#define MLX5_CAP_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET(nvmeotcp_cap, \
+		 (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
+#define MLX5_CAP64_DEV_NVMEOTCP(mdev, cap)\
+	MLX5_GET64(nvmeotcp_cap, \
+		   (mdev)->caps.hca[MLX5_CAP_DEV_NVMEOTCP]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f4a5b814a8f4..6476c98a3925 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1598,6 +1598,20 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
+struct mlx5_ifc_nvmeotcp_cap_bits {
+	u8    zerocopy[0x1];
+	u8    crc_rx[0x1];
+	u8    crc_tx[0x1];
+	u8    reserved_at_3[0x15];
+	u8    version[0x8];
+
+	u8    reserved_at_20[0x13];
+	u8    log_max_nvmeotcp_tag_buffer_table[0x5];
+	u8    reserved_at_38[0x3];
+	u8    log_max_nvmeotcp_tag_buffer_size[0x5];
+	u8    reserved_at_40[0x7c0];
+};
+
 struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         reserved_at_0[0x6];
 	u8         page_request_disable[0x1];
@@ -1625,7 +1639,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         event_cap[0x1];
 	u8         reserved_at_91[0x2];
 	u8         isolate_vl_tc_new[0x1];
-	u8         reserved_at_94[0x4];
+	u8         reserved_at_94[0x2];
+	u8         nvmeotcp[0x1];
+	u8         reserved_at_97[0x1];
 	u8         prio_tag_required[0x1];
 	u8         reserved_at_99[0x2];
 	u8         log_max_qp[0x5];
@@ -3775,6 +3791,7 @@ union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_macsec_cap_bits macsec_cap;
 	struct mlx5_ifc_crypto_cap_bits crypto_cap;
 	struct mlx5_ifc_ipsec_cap_bits ipsec_cap;
+	struct mlx5_ifc_nvmeotcp_cap_bits nvmeotcp_cap;
 	u8         reserved_at_0[0x8000];
 };
 
@@ -4027,7 +4044,9 @@ struct mlx5_ifc_tirc_bits {
 
 	u8         disp_type[0x4];
 	u8         tls_en[0x1];
-	u8         reserved_at_25[0x1b];
+	u8         nvmeotcp_zero_copy_en[0x1];
+	u8         nvmeotcp_crc_en[0x1];
+	u8         reserved_at_27[0x19];
 
 	u8         reserved_at_40[0x40];
 
@@ -4058,7 +4077,8 @@ struct mlx5_ifc_tirc_bits {
 
 	struct mlx5_ifc_rx_hash_field_select_bits rx_hash_field_selector_inner;
 
-	u8         reserved_at_2c0[0x4c0];
+	u8         nvmeotcp_tag_buffer_table_id[0x20];
+	u8         reserved_at_2e0[0x4a0];
 };
 
 enum {
@@ -12510,6 +12530,7 @@ enum {
 	MLX5_GENERAL_OBJECT_TYPES_ENCRYPTION_KEY = 0xc,
 	MLX5_GENERAL_OBJECT_TYPES_IPSEC = 0x13,
 	MLX5_GENERAL_OBJECT_TYPES_SAMPLER = 0x20,
+	MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE = 0x21,
 	MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO = 0x24,
 	MLX5_GENERAL_OBJECT_TYPES_MACSEC = 0x27,
 	MLX5_GENERAL_OBJECT_TYPES_INT_KEK = 0x47,
@@ -12525,6 +12546,8 @@ enum {
 		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_IPSEC),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_SAMPLER =
 		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_SAMPLER),
+	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE =
+		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_NVMEOTCP_TAG_BUFFER_TABLE),
 	MLX5_HCA_CAP_GENERAL_OBJECT_TYPES_FLOW_METER_ASO =
 		BIT_ULL(MLX5_GENERAL_OBJECT_TYPES_FLOW_METER_ASO),
 };
@@ -12903,6 +12926,21 @@ struct mlx5_ifc_query_sampler_obj_out_bits {
 	struct mlx5_ifc_sampler_obj_bits sampler_object;
 };
 
+struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits {
+	u8    modify_field_select[0x40];
+
+	u8    reserved_at_40[0x20];
+
+	u8    reserved_at_60[0x1b];
+	u8    log_tag_buffer_table_size[0x5];
+};
+
+struct mlx5_ifc_create_nvmeotcp_tag_buf_table_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+	struct mlx5_ifc_nvmeotcp_tag_buf_table_obj_bits
+		nvmeotcp_tag_buf_table_obj;
+};
+
 enum {
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_128 = 0x0,
 	MLX5_GENERAL_OBJECT_TYPE_ENCRYPTION_KEY_KEY_SIZE_256 = 0x1,
@@ -12916,6 +12954,13 @@ enum {
 
 enum {
 	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_TLS               = 0x1,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP           = 0x2,
+	MLX5_TRANSPORT_STATIC_PARAMS_ACC_TYPE_NVMETCP_WITH_TLS  = 0x3,
+};
+
+enum {
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_INITIATOR  = 0x0,
+	MLX5_TRANSPORT_STATIC_PARAMS_TI_TARGET     = 0x1,
 };
 
 struct mlx5_ifc_transport_static_params_bits {
@@ -12938,7 +12983,20 @@ struct mlx5_ifc_transport_static_params_bits {
 	u8         reserved_at_100[0x8];
 	u8         dek_index[0x18];
 
-	u8         reserved_at_120[0xe0];
+	u8         reserved_at_120[0x14];
+
+	u8         cccid_ttag[0x1];
+	u8         ti[0x1];
+	u8         zero_copy_en[0x1];
+	u8         ddgst_offload_en[0x1];
+	u8         hdgst_offload_en[0x1];
+	u8         ddgst_en[0x1];
+	u8         hddgst_en[0x1];
+	u8         pda[0x5];
+
+	u8         nvme_resync_tcp_sn[0x20];
+
+	u8         reserved_at_160[0xa0];
 };
 
 struct mlx5_ifc_tls_progress_params_bits {
@@ -13333,4 +13391,15 @@ enum mlx5e_pcie_cong_event_mod_field {
 	MLX5_PCIE_CONG_EVENT_MOD_THRESH   = BIT(2),
 };
 
+struct mlx5_ifc_nvmeotcp_progress_params_bits {
+	u8    next_pdu_tcp_sn[0x20];
+
+	u8    hw_resync_tcp_sn[0x20];
+
+	u8    pdu_tracker_state[0x2];
+	u8    offloading_state[0x2];
+	u8    reserved_at_44[0xc];
+	u8    cccid_ttag[0x10];
+};
+
 #endif /* MLX5_IFC_H */
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index fc7eeff99a8a..10267ddf1bfe 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -228,6 +228,7 @@ struct mlx5_wqe_ctrl_seg {
 #define MLX5_WQE_CTRL_OPCODE_MASK 0xff
 #define MLX5_WQE_CTRL_WQE_INDEX_MASK 0x00ffff00
 #define MLX5_WQE_CTRL_WQE_INDEX_SHIFT 8
+#define MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_L3_INNER_CSUM      = 1 << 4,
-- 
2.34.1


