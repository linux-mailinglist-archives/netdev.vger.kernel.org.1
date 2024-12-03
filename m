Return-Path: <netdev+bounces-148638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29BA9E2C0E
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E8F3B24F86
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 18:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994B1FCF41;
	Tue,  3 Dec 2024 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S99qAfyj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9911362;
	Tue,  3 Dec 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251849; cv=fail; b=fH2eLPeGTwxKYA1xDw1V73Eq5+9/o2QFAi6cG6EkKMkppItXo17hig54/MBd7HW7lqTXjE6oJVWbJ9aQN9FrziESEG4E5qjpUGeJ1uMV/BdZVfwR3GmICrduvmmk6+hPt6KdlgxCy/JBZibhUkg0i0ZDmPjOicSpf0GrRJ/Txzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251849; c=relaxed/simple;
	bh=69wsSv8V1V3hFGIbzKtKvpCa7B4EnmxWUajdvohxfQs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoUK5LAuW83Eq6yN6ftUeJJ5GNlN8oTLPZKgkmJQFVV2fQcuYcNDLLTjP4MqeONxSTtPQ1mvAdq8bkJ2veVnU5nDOidUs7Z2PpmdbSYX7kO82nY/dWqQ217GOOyIqUBEgq3UyWLGFI0X9/KxySGtJTFZXWA3PwOp1OU3KwW2L7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S99qAfyj; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCFzL8jeUtt5W/2zMhi8RIClkMK1itDIloZWwZB6hyMVPx9X+0n5P3WGXY7dA56jWyxbdF1lJz6GtzPoxtbdxwz9PAaetiXWlQ9lJNVzMzKkvBjXmgbMf69Ko/kp3L5iGlrbQclXCfA3+RDNLzr+HNU4+uXcKaYgpHHP4OKmKDEOVDx6xMdvCtTcvGwviY+arCy/03Xfy3hs9O+Y5JAee0jrj/qm1C+olcICod6kptC13BTZl4+4qL8Mmb4ENEKhzititi8mI8blCqht5ACHG1B5hdYSsgJfg8ahOruNhTqWMexdwPZ5gvkE915CXIXnNJm77S0RmUKg/7b52ECSqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dag2rVqwYMHHconFzYyEctoAFuJfPztY55tFI9pzPcA=;
 b=Vr9uq/8I6zRmk1qkn/cvrWWAwK2MNz/OM2ttHfu4nGQOyMUVTYc5MuweIWQbsAhoOxIpl48Aq8oYcFL57EyFtWISzPFg4TlUP48SZ32AiTYR7ap2Qg+iiUFR0G8o+GRRlsaKKkxzO4xuP5u+xe9Mq54wq4jVa17WUa5SHjaN5hsOb0FlXoCGkEpEx+ze37ULG918Ei19Is7rIM5RFKaw8MBDP0fnY9PdzBzZvuwG5OOZXv9uxJRH6RBfJ94K8d8qE+gC4Us1lt3lbPzTk1vbkP98aMZbaXaKwJjFdxwc6hwmWD82us50wwz7QY/6fW/T9q7DequZitEMYJhDeih5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dag2rVqwYMHHconFzYyEctoAFuJfPztY55tFI9pzPcA=;
 b=S99qAfyjSvnQrRLxU9ieQZPLCFYGJTrE+1BQe12DU58OvA/D3GzjOa186VbYiK59xFAiGh1pkRuf6XeCe6OwKYU5yg6COSL6Zp8y0Db8vvkHdtNkaZYMH2PS21RnDrho17sawAOMst+jXIdcHKTMgdIYC5mn9T5cxo2LAKyy1BLSw7OL8YujHr/fOKNE15zt8o587l4hzdVaReKLc++98vuqAQmwj0Q4kTTftOI5fwbTEaViOyECuEC1jZk3e7Lb2VhA1rnyDnp80eowkdsRd562DhRbr2zUKjiv1tZFEHNLj4A1uBi39XHdMcaVfTfw0eQtFBPHdbhysi279nSvsw==
Received: from CH2PR05CA0070.namprd05.prod.outlook.com (2603:10b6:610:38::47)
 by MW6PR12MB8834.namprd12.prod.outlook.com (2603:10b6:303:23c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 18:50:40 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::5a) by CH2PR05CA0070.outlook.office365.com
 (2603:10b6:610:38::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.7 via Frontend Transport; Tue, 3
 Dec 2024 18:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 18:50:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 10:50:24 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 10:50:24 -0800
Received: from localhost (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 10:50:21 -0800
Date: Tue, 3 Dec 2024 20:50:20 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>,
	"Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v6 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241203205020.00002f82@nvidia.com>
In-Reply-To: <20241202171222.62595-25-alejandro.lucero-palau@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-25-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MW6PR12MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac00e98-f7c3-435d-e058-08dd13cb6205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6SKgt3NfCyZoEY4nl4gAoAkUTTjhwM2LOsPoyMek1aF8KWw0uKq9iQ/O/YyO?=
 =?us-ascii?Q?A35KyZdW7psU5NjWnHVlF/gk5gm0R7quMKCGqgPy6LFJ5ewEst+gzf5rygP0?=
 =?us-ascii?Q?9O9yC/dJUCNMylma9ZNozY7z2JbjGfIuQIC25GE/RJPqsj11ptyWg23ZpUnS?=
 =?us-ascii?Q?30UL4gWjsMH385kqwUXDghxT+KjefQff/7rph8unvXtd8PpgbElhPxyx5Mr+?=
 =?us-ascii?Q?DYVgk6XL9/0Rp0cj+VyiXnYBeSBvzpJ1gtY/VRH9h2NvmnTh5vyNEEQFU6SC?=
 =?us-ascii?Q?8FpAr6Ah6bgCOE97kAMc7lWzpLPiuJ2E6tUEVYnYeSlkS2EGBUCX7UK4ylmw?=
 =?us-ascii?Q?mtUcERhJfizQistENFLjtlAlkcrkIzvpuXzWIG8OkI/xUu3dHi7y3TIUJ9vl?=
 =?us-ascii?Q?1YNbmswh+WGu1HhIIJcEoA1MSUew6fZCscAheDXUGtB3kjQzJrdpsoLlIAIO?=
 =?us-ascii?Q?GIHHmDmIgQtrr037/SlnPHzgpbErWmblnsAKSTWD33HPolaSkdtJEz6EOovX?=
 =?us-ascii?Q?PyYa95fYN2hmDG4EaXkCkVlLerwoIA+uQ2+sS0goqlMWRS6u6vphiJLjFnWX?=
 =?us-ascii?Q?92ucoCln41YF8mtaVACn8WfZh8LWo52e+YjDw6wFmZvbRCfZHf0zQsjwPvkW?=
 =?us-ascii?Q?AgbChXJ1QXJ46gVD1+/mWQlhCZ2o+24g7be3RS3djzbvmlKwzvbf/XnuajOG?=
 =?us-ascii?Q?UWaeWFj4c8tTxJKNLOx6Y6iECUx2Uh4MLM1Xh5O7z92CMwida+B+N+Iaan5a?=
 =?us-ascii?Q?HLW/ejEVfwBeA0OOmVQ3O0mcqu0FknI31xNKKl3ZIaUWkEHUL1zBeTxzzRLz?=
 =?us-ascii?Q?Nfuj7EVPhzNg/NQdB8DjyTmLXJmjeyJrcok49LTwuHvxIiY+Zp/YqIiFXeUa?=
 =?us-ascii?Q?zJ1PKGkBUFv+K1qN3shd7QVlqEAawruL0KxrbXtax94oB61Sa9qdTdW/27qe?=
 =?us-ascii?Q?xeDFJyKg42mjuqPW7hjnITpZL9t5DZmKvOn7g+8sVWoge7sr60cv857xIvIH?=
 =?us-ascii?Q?QGDcsD9P5tqUFTNnL/cgKc3PSR5ejwOoqTDOAc1zAr03OcFg57Nt1kVl8WOl?=
 =?us-ascii?Q?/2Z2R/DkptjNV1gWGY5Uv/z7qF85bu4uATanhQzdDtPzlzbv6PyHB1r9dEY9?=
 =?us-ascii?Q?ryBuu18IgDB45UnzKQpsszvBxLJoasO3BCLSuthCl6mrQlHUAjSPGOuuF6B+?=
 =?us-ascii?Q?0Cj2TMnheFslQo8K5bBmUQE8WhWXNSZYsq3ZGWSP4LEY47AT860LkYNxnVaI?=
 =?us-ascii?Q?rxPYm+ublGFevuNYu/U0efJVaVMUgy/+9Cpe5Ejcs1gXfRP1e6KUd35qhNjV?=
 =?us-ascii?Q?e3MPA4UAVZ85drqoUJuUbdSvGBJxdiOyssEOTDp3i2+NnlHvKPXMF0kmBXvo?=
 =?us-ascii?Q?QKKS4AF7Ol/zkawJK83+B5JKciqtnToi3nvmpEw0WesSqAodiue/8B1gaM7r?=
 =?us-ascii?Q?DIWHPYHuzVMbQnkDuVW0x6bPtxDg6n2j?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:50:39.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac00e98-f7c3-435d-e058-08dd13cb6205
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8834

On Mon, 2 Dec 2024 17:12:18 +0000
<alejandro.lucero-palau@amd.com> wrote:

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> By definition a type2 cxl device will use the host managed memory for
> specific functionality, therefore it should not be available to other
> uses. However, a dax interface could be just good enough in some cases.
> 
> Add a flag to a cxl region for specifically state to not create a dax
> device. Allow a Type2 driver to set that flag at region creation time.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c | 10 +++++++++-
>  drivers/cxl/cxl.h         |  3 +++
>  drivers/cxl/cxlmem.h      |  3 ++-
>  include/cxl/cxl.h         |  3 ++-
>  4 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 79d5e3a47af3..5cb7991268ce 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3553,7 +3553,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>   * cxl_region driver.
>   */
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled)
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax)
>  {
>  	struct cxl_region *cxlr;
>  
> @@ -3569,6 +3570,10 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  		drop_region(cxlr);
>  		return ERR_PTR(-ENODEV);
>  	}
> +
> +	if (no_dax)
> +		set_bit(CXL_REGION_F_NO_DAX, &cxlr->flags);
> +
>  	return cxlr;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> @@ -3704,6 +3709,9 @@ static int cxl_region_probe(struct device *dev)
>  	if (rc)
>  		return rc;
>  
> +	if (test_bit(CXL_REGION_F_NO_DAX, &cxlr->flags))
> +		return 0;
> +
>  	switch (cxlr->mode) {
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 57d6dda3fb4a..cc9e3d859fa6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -521,6 +521,9 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_NEEDS_RESET 1
>  
> +/* Allow Type2 drivers to specify if a dax region should not be created. */
> +#define CXL_REGION_F_NO_DAX 2
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9d874f1cb3bf..712f25f494e0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -875,5 +875,6 @@ struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index e0ea5b801a2e..14be26358f9c 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -61,7 +61,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> -				     struct cxl_endpoint_decoder *cxled);
> +				     struct cxl_endpoint_decoder *cxled,
> +				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


