Return-Path: <netdev+bounces-117221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6394D25B
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49784B21D04
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8627195985;
	Fri,  9 Aug 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FKYvWYte"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA5312B82;
	Fri,  9 Aug 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723214467; cv=fail; b=YHdPz8vM52yrzDrDsxeAFbbnUUGEf+B6kQ8UOpmhObbP1T5wb07Jy+WDLBtkvSOJFU2ZYM00ZCRebY+wNe9i9BVK1nIf4IZNCw7l7XxFfrD8pRNccrNioK6uqnkHGunznX4/OtRnnl6jVzQuIl7fqaR4CsUkMyHvHRQuOhMRXxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723214467; c=relaxed/simple;
	bh=Ryko8OfuQ1Esxoz9Z7XAYI9AugH0C0AvYgO4ppKKgao=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+VgWj0qOsDz9Y/a8917tTINsC8ZqwugoIddI6abY8SlLGBb7eAMlRw/1eT6o3FJ0nHxauI8coMLDS2BhzMR5HK8L351fsjfv/vIb2jTv7TSM8lMGGqR8Phxjhfnd8TgP9vh7FDSdaiUB7XZLiWkylWgNlfe+5JYmtSH1VzK69w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FKYvWYte; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/Qgqawg9G3VnVImYwaFLa3zMVyF6JJhHRFuuYx5zxi1R/AkUuWb4mccemmgkXsx6L5JNC4tqdBJF/ouVhuqLck28hb15S9Spj81Cxs6YW88C8dEDBD1szm8+GIxWDT0Al5BFVmyjEU6YmUSxhtEFU6fnKWdUyhnawFFDDjFnd82S/JkcLolu12LAyzUMvIqXE6lpvng24GTHA7p6znTHH+MYlFNLTc0pFuB0k4x5itzppsm/a4vUZVxY2FUBqLtqttm3bXV29a1LDQVhCD7ZB0xmhB90QatPgAGCpCocFHLe3d2M8U9sSUXF6Ene46NhtarEdzXP81vWOW8jpK+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE5vYfP2AB5fUzRKoqhLp6VQQeF7DWspqdtT+gSJJBM=;
 b=zMZgKN6oD4XkxeEIFpqg4mIEMqwtr+ZpaoIgbZ+hRuZJXog92yWZLe0uODF7iVPAztVxH0/DMomTPT4iG491HrfIqbqF5aqpx8QVOPuAKpTVVKIOgl8yCRqIsXJaRafjenQKEAFozyLk4/gpTR2FG0esSUz/Culy4MOrNzEGmh0lel4ta9HZbs1a+OJh6B2iU376oiZPf4LqLXERZjzyKzI9sJp3TLJY2O0Z7CRsC4bIqWS2tRb1tRV6OznoByByP3Tg7XCasvdDZ6WU5k0jPkzBX5qfV/iCC8Oi0s9kTF1iY59sp68AhycXH/IJZ3Q+61lL4yk8aox5CXTB6XfiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE5vYfP2AB5fUzRKoqhLp6VQQeF7DWspqdtT+gSJJBM=;
 b=FKYvWYtexXOWQGHH2m3AM6sbEIRvLU9kfoyhFyKdkIh9M5o+7nt6yhZA22afMIUPuY7oKtHwN+xoi2XuSp+JGKFAYhgctXUztdWekbOCTQ0JsYiDtDL3fCbuIfjku4TPbBtz/h/+UeIIKWtjWdNVYULPm0UMUdmdnVB4yGZ1edfTV1m+O7DWQp+a8Q0K7UyeeTfJ34pARHtobAZ+kxNOY/FjeL55qQsr8sUljpcPkNcwIi8pepdzjlK7ubchwIypH5bwrhoyxQNHTM52qdPAXClqPtozoNaigM+OsztFVqQVc1jnOySAlqa0nDtMshREaIp5HSCxwN5iyJ5qMUr+dg==
Received: from CH5P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::23)
 by PH7PR12MB8779.namprd12.prod.outlook.com (2603:10b6:510:26b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 9 Aug
 2024 14:41:02 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::f5) by CH5P223CA0006.outlook.office365.com
 (2603:10b6:610:1f3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17 via Frontend
 Transport; Fri, 9 Aug 2024 14:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 9 Aug 2024 14:41:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 07:40:46 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 07:40:46 -0700
Received: from localhost (10.127.8.11) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 9 Aug 2024
 07:40:43 -0700
Date: Fri, 9 Aug 2024 17:40:43 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>, <targupta@nvidia.com>
Subject: Re: [PATCH v2 08/15] cxl: indicate probe deferral
Message-ID: <20240809174043.0000011a.zhiw@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|PH7PR12MB8779:EE_
X-MS-Office365-Filtering-Correlation-Id: db972046-062c-4194-127c-08dcb8814a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvpIbr9LUsMGdqtaozoqpLGA8gpHPy5Z79n4gRS3gqrosKAOhJMKWLDEOjqQ?=
 =?us-ascii?Q?pVQA5i1TF8JcXFXen8ulasz7F4KbuHcVLS1QJBWe/lc1Tldum2OegDKYeNCe?=
 =?us-ascii?Q?CIUgHGf1GgsY+izQWRJjSUQjt+00FcgpPQb7lyh/pEQ+zMnFiPr+7SfETZ6d?=
 =?us-ascii?Q?gdExf39EQkN/KBKDJtEe4W0tLOWMIbSOOdEtGAv6b9xafhH1lZ7R1kPO1yhZ?=
 =?us-ascii?Q?c/oIENYi7DptS7fGDDObi6wazIF/apjOojxbAe3qx26zLeBFELu2eaXX/Rl0?=
 =?us-ascii?Q?2pwzWPYcK2QbAZOLQF9HvC/Yi6hmnfM2NDUw9yD7U1ejsrS6Z4UyE9aHvcCd?=
 =?us-ascii?Q?ffwkY8unqDIwN4lwQ2Zg6r0j6gX/VQeGyjrQTwX6YErBIQ/pZ4hMrQPr3BAL?=
 =?us-ascii?Q?wqCyoXHuSzW8B7kXQdEVdCdW1f13PLDkZxlpRpeF06OcdKVeRLBALms6ipVW?=
 =?us-ascii?Q?JetISxk/F1ILezd9UGJYT1+pQUqkPCbfuDY7X4d4CClEwDzhjz+c/K6a7L6x?=
 =?us-ascii?Q?6u1lezZ0V0bM8/FiLUF9aqS97ih2NzodV5JVjdAVwPmYjb0OE0xXZqEBik8e?=
 =?us-ascii?Q?BqsEEfYwjjZAwzamygftR6j4mPnKezPmmJW6rVbV6RA6WN0OCc2OyohFEBzm?=
 =?us-ascii?Q?tTA+XltCUEQkOPJC7AY3ZK9nI1zGGOJ6YoJIoPbAF0Kassmoy1d2SF3DycY4?=
 =?us-ascii?Q?aX4ZE6GEQ+BUCdcyzU2v5tMRVb1MKXZyHMkFQ1kPJAgxW6FptG94kP1mF0fj?=
 =?us-ascii?Q?JuGy+StVhjU9CQfmmTSNni/uY1N+OR4fN0U6JFr9yI4qVRthwMqKsgmN8crK?=
 =?us-ascii?Q?tGlvHi5YLLALOrMCJZokGnufwjperkOSt83BZlDm+FQWtB9TkFEK30CY1bXZ?=
 =?us-ascii?Q?JjHK+2BfpyrB7WecEt4ZJjyNE2CkKGQD185kMI+DEsIzv07rpGpQRbiScp9p?=
 =?us-ascii?Q?KmVz1AF3yiO90cjEWBB9HpzDx/1+uvz0vPApDPemBppblcpXZPvhAquzCpnY?=
 =?us-ascii?Q?dN+xJ4+LQVEykP+GLcY6KrWVDUoGc8HIhc8+Qpu19cDHxqVUumCd0FjOw8Uo?=
 =?us-ascii?Q?3kiwUEoHEoSGo0AZcMN+kQ+EWfU97SP7/SC5aDYzUCTT3hdBszlOSvHpmo1F?=
 =?us-ascii?Q?B0sFrVyx5f0fDn+iegNjjmgwvLdPZuRhgRvfItlb/3CDC86//dw3NFeA+FKg?=
 =?us-ascii?Q?TAJ1DXRqdDQqb+3UOl6lbfB3iBEHGGYBD5t+sfbrOIsbLsPfU7+AhGIkW2HX?=
 =?us-ascii?Q?8/hiZCuBcVWGkOfmnhniq+pGmOHZ/asB8L/kqaBuyp5DKMtIgw2Wn7qxmVrv?=
 =?us-ascii?Q?dyJW73kfgEL2h/YEKCHSt+XDEDVKl8w432ItmfL2/pWjfWa/qAdwudlnkPKI?=
 =?us-ascii?Q?NzIxF/wufogAiaV1rjt23yAX1UM2bn6xiqjTKSRqd2iZafT1FzCWdhYlMJQF?=
 =?us-ascii?Q?lj+8wH92PcmCH3exTnl2yKntIodBiibh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 14:41:01.3791
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db972046-062c-4194-127c-08dcb8814a3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8779

On Mon, 15 Jul 2024 18:28:28 +0100
<alejandro.lucero-palau@amd.com> wrote:

Another spell check is spotted besides others review threads. Will
circle back with more comments once checking the users of the APIs.

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
                                         ^deferred
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> The first consumer of this API is a test driver that excercises the
> CXL Type-2 flow.
> 
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


