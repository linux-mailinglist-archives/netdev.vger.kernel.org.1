Return-Path: <netdev+bounces-122000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3495F86D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 19:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FED1C2258D
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 17:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B5198E78;
	Mon, 26 Aug 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uE594LGu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B5198A34;
	Mon, 26 Aug 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694173; cv=fail; b=ChoYJrQgInNErOGGp+BHZ/Udl9NJKT8AjBBWegLdvpwXClPW9Ztz8OvE14AMdK1Kiw08osoj7N0maDHKeaCLXOPXRWkMx+fWOR41q0VHQaqM4Th1gScciz/V8l4kiKladH3ZbLFxZNzS8M+/gPTAF+6PcqrECfmpU0lrXRvrVV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694173; c=relaxed/simple;
	bh=zJky7vNmRv2JA2yi5L8PEweBvoVg07l1/zw7RDL211E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MM541+CW2cXrnOymhPDB+VRh4ypf1pb4jO026BK1qOpf8JdXHeyMnklGV7OKhEP2X2f9BaxhQ4bLnBocB3W3rs6xSsT1QPCeMQsgXypAzxJO+7ia4SGlraHxdGoXsBPxLPbh0ve2Tsg44fdjZ3cZ8QTAhg/IJY9tyx+H+atbiZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uE594LGu; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkIXWv78Zux6dlffo7Wn4zUXTmXguDe64Uly2cL+dtWCMv9/vjm5dnh3gViBduR2I6bouQd0utTyiOK/dOrQDZw6SkeidARPGblIV6V3YOxAwGKCsTLcRKJZN4OeWzmVgroOKR36hFXml8zrDc+zsQopzsqBQD9d/JG8BwBdOG4X6mc6k5OZY8wL9Cep93ZAPp97dpqk5AWevn4/chkPLRSL3dNuyfAryU6jTO9sSlFN/9NAEiLrgRsdQF68stC/sI4paZpvxP14BeFuRaOyFMP3BKamGukVhofqopRAVr8lza4ga+tRid44eQRzP6CvzenrQqt8+wp/4K/lu+fu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueBTpgi6j8528zGDbioSTFoD0F4KUUPfGF2+MDRuJhM=;
 b=uWK8nGI8U2CM5hmJeGImbLdqasHlojPu2/f7NY8/vAIekAhsEr+SortLREHSmuat8tJb17KeaOBe+fk/kfb1/HwWHx0asQa3RAO53rRFk/cgSV8r0SVNu3h+hOAY10lo17vFjt7rteD864Qy1H4X/n424C2MMZ2GYtARli+ZwaN2DwVYNV9BAHHE6T86X3MIGgdH2RVJUzA3NzCsCT7j0de5mq716ZJb8Qu2cVSefPXdBedqQ5uUJn00PZrmWndZ6KyGQSTJKa5LeOEjoYneQoPOOvW9/B5GGXNKnvWdvlTSUiu8MpUamx7FWQC9OU+LycBzoBUU4JVbqgZETko4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueBTpgi6j8528zGDbioSTFoD0F4KUUPfGF2+MDRuJhM=;
 b=uE594LGutOqhgMl/3I7Rg3UMDu5B9W3cqR2NLuBMsaIWCASgikwve/ChSdbZp/asX9Ak15Du9ey8cGdJ6vSGrX8OD6ewqtgKy6KjIeSg2zE4DeoIAaOq9Gc8QU2ZQuHNwe+1UFNgzRWln41w8lVFOACLmwxG3X57Wlk6js5l4AUbdMklnmRAke1HvY74O3Te/HIbZu6qL/otFBKHZ6NDaCdvHx1VDm02WCgpJEoq9GvRILd4N+n0VijSpIbQ5mICqU2yOOC727+VoxIMlu2q8sio3q+j8YBAk/rphptymbHB2TQuHt4EWK4yee3Y2oUfii+67zModCP1hP2IekfExg==
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 17:42:47 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::f0) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 17:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 17:42:47 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 26 Aug
 2024 10:42:36 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 Aug 2024 10:42:35 -0700
Received: from localhost (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 26 Aug
 2024 10:42:33 -0700
Date: Mon, 26 Aug 2024 20:42:32 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>,
	<vsethi@nvidia.com>
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Message-ID: <20240826204232.000009ce.zhiw@nvidia.com>
In-Reply-To: <20240715172835.24757-9-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-9-alejandro.lucero-palau@amd.com>
Organization: NVIDIA
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 16701a84-5107-4ad2-cde0-08dcc5f67fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cid3mCvW4LpuayBNmo0Gpq44l5Na9gldbb3NhV9eWB23OXHOmUK4883Pqu7B?=
 =?us-ascii?Q?nhnz8tw6tHEfaOO4EQNTnVc8pYS1XlwEBSbnkqDMaH9XoIerOitpxGEKiYeS?=
 =?us-ascii?Q?1+pU409f6gTRd1ZG43he6lbyUJgtZfJNENv4vAEdGg8fcGc2Qf+MA8QFmJc2?=
 =?us-ascii?Q?81NaMyhC00buZaIaL1SQY6py63t/BwPwDG4VdmyRZ4IVu3ExMp8DhuzzVBRR?=
 =?us-ascii?Q?BJby5RrSK+gkDf11xaj6S2jiD/vJkHFrGfnlagta/rfRr9SzwKtZdy0ti/Iw?=
 =?us-ascii?Q?k5bpkfXjDnnuuUW0sliVpFiUOeZnSLRkAQNO9eAaX+/1FMqZp8JOE79AXP2u?=
 =?us-ascii?Q?q+rOZBGfM7Wizs8xd1el0IvSwm+8UPtQIO7H7sBWnT0drkDiqLLu9mgXvyS7?=
 =?us-ascii?Q?YqpsKy+TfeQW2a6xrojTtjOmA9JCCwIW7BgFe6IniQkKNz9BGY4kIneLbm3V?=
 =?us-ascii?Q?rcdkgdN2s3G06hKn+qWQjIwBQI118ULf83lQQHkQM9gpOW4/KxFfuAAIhQfQ?=
 =?us-ascii?Q?WRugAjlCh6kIYVhaQ86PYMFaJ7X7WcXrkRUDv1DIba1RdB+CeKOlVp07+oYd?=
 =?us-ascii?Q?d0wgqZ0O9ZP7aQEhPFbVP8uRmlwA0N7XHYaRqT9H6Z4LmiIhv0jxbqB7IAn5?=
 =?us-ascii?Q?pwfdWkitRE8FH5IlxGPv2ocnfM0qWyLWqhz0ATbjQC1/V4aCSHT3a5B0lEl1?=
 =?us-ascii?Q?5/WAN2D+Yp4sMitpZ7URvyy0Sd1NNrjKepOHP5iP+LVYFzQKJxPrIa75C23c?=
 =?us-ascii?Q?HjWRcfjsxbR9G/n4M57PQQaOu2UOQdLkobsEb6GZrrbBssGpFJHt8F1kwHOK?=
 =?us-ascii?Q?iftIaNd0y1rQsDH0MSEAcxaQgiT62lYEq4n4P6NSm6GYjGCOdojZaBOsdsTp?=
 =?us-ascii?Q?o5c66j/W3q0+5hS6+ztsR8FryqEOSm8TKZPJjTeY4WSgMmdV7RkjFKPVcgMV?=
 =?us-ascii?Q?h1BSa4c6paGWZkAi5lb24NKrvAeDLmuJmkVuHRSYmCIz9fDneTISr/uQxFci?=
 =?us-ascii?Q?u1/Pm8WbBCL5WdOzYDK1RYEby2x9vahK/T3AKRteQB3R1/6lWHFQykxrQuFr?=
 =?us-ascii?Q?Zau5lXWwY6B5jByLF5VpWu8OR/ScRVV2LT72JWPFeDc2t/OtpMEZpXoiGaJ2?=
 =?us-ascii?Q?3lQDH8b56vGN67fB/sSkNeHeAsGzzMgA5TdB8ooEMTwaZa09dFA9FmmodBEU?=
 =?us-ascii?Q?vNnUjga7oEYVKNJju4+ywBXxVrFec4GLr8QtDx+wjXVgkVtineDVhGG6SpzR?=
 =?us-ascii?Q?8ujaRxd/2LR3k4qbrOzndaPRakay1ALYFi7HljRQpJTAdhfjORGTn/xCP1md?=
 =?us-ascii?Q?vs8MNwiOr0cj2kHKKvu356SQ+LkiGGrKuQCzeFl8HFpfYZ+WPtJ9CkmGdGtf?=
 =?us-ascii?Q?Mgcq3utEllaCDAaSncMD3Wme0l5NWKsgNbRvAjMJd6v3VIKGKgQyXVv2PXIm?=
 =?us-ascii?Q?mH9edRgBt0zYEw6p/jpsbPqxH4PN1Z1U?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 17:42:47.5363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16701a84-5107-4ad2-cde0-08dcc5f67fcb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

On Mon, 15 Jul 2024 18:28:28 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first stop for a CXL accelerator driver that wants to establish
> new CXL.mem regions is to register a 'struct cxl_memdev. That kicks
> off cxl_mem_probe() to enumerate all 'struct cxl_port' instances in
> the topology up to the root.
> 
> If the root driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci_driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead
> defer probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
> accelerator driver probing should be defferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> The first consumer of this API is a test driver that excercises the
> CXL Type-2 flow.
> 

Out of curiosity, when and where do we probe CXL_DVSEC_CACHE_CAPABLE and
enable the CXL_DVSEC_CACHE_ENABLE bit for a type-2 device?

Thanks,
Zhi.

> Based on
> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m18497367d2ae38f88e94c06369eaa83fa23e92b2
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c          | 41
> ++++++++++++++++++++++++++++++ drivers/cxl/core/port.c            |
> 2 +- drivers/cxl/mem.c                  |  7 +++--
>  drivers/net/ethernet/sfc/efx_cxl.c | 10 +++++++-
>  include/linux/cxl_accel_mem.h      |  3 +++
>  5 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b902948b121f..d51c8bfb32e3 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1137,6 +1137,47 @@ struct cxl_memdev *devm_cxl_add_memdev(struct
> device *host, }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has
> deposited
> + * a probe deferral awaiting the arrival of the CXL root driver
> +*/
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
> *endpoint) +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d66c6349ed2d..3c6b896c5f65 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev
> *cxlmd, */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index f76af75a87b7..383a6f4829d3 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,13 +145,16 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	parent_port = cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (resource_size(&cxlds->pmem_res) &&
> IS_ENABLED(CONFIG_CXL_PMEM)) { diff --git
> a/drivers/net/ethernet/sfc/efx_cxl.c
> b/drivers/net/ethernet/sfc/efx_cxl.c index 0abe66490ef5..2cf4837ddfc1
> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c +++
> b/drivers/net/ethernet/sfc/efx_cxl.c @@ -65,8 +65,16 @@ void
> efx_cxl_init(struct efx_nic *efx) }
>  
>  	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
> -	if (IS_ERR(cxl->cxlmd))
> +	if (IS_ERR(cxl->cxlmd)) {
>  		pci_info(pci_dev, "CXL accel memdev creation
> failed");
> +		return;
> +	}
> +
> +	cxl->endpoint = cxl_acquire_endpoint(cxl->cxlmd);
> +	if (IS_ERR(cxl->endpoint))
> +		pci_info(pci_dev, "CXL accel acquire endpoint
> failed"); +
> +	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>  }
>  
>  
> diff --git a/include/linux/cxl_accel_mem.h
> b/include/linux/cxl_accel_mem.h index 442ed9862292..701910021df8
> 100644 --- a/include/linux/cxl_accel_mem.h
> +++ b/include/linux/cxl_accel_mem.h
> @@ -29,4 +29,7 @@ int cxl_await_media_ready(struct cxl_dev_state
> *cxlds); 
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
> *endpoint); #endif


