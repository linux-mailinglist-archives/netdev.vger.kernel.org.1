Return-Path: <netdev+bounces-127750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9C4976558
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD511F2127D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D719006A;
	Thu, 12 Sep 2024 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JOLjtIAX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AF519CC0E;
	Thu, 12 Sep 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726132776; cv=fail; b=CUWO9RJFxoniO9bniyU+4+tFUn7hSO7HkF0Jt+PV7mpfv95Nkf0zwj1c2BaKiiSTJObetDKjxfByMEDHMchdaihGrMzdcsbmKksTqlm+4ZSBvTKCRhILDJDdR3Lo1t7ozoxYolqbJpORkgH81Qurh09NO7t3jMcwaXh/lh5CrzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726132776; c=relaxed/simple;
	bh=H5AVbBohTOF0NWwUReSC/OVgx8h3EiRs/Yc0Y2a+gGI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tteZQ8zbEIj1qvqQBHbhKG/wKt9BdqtlSKCLmHlVB+TyxkB60iTkXW9iOXDyfAabRqhv+P2ZWW8JR2jO1dk33lEAm7wgBAaxvJZbwll+g9v5jQPFP44sGWkmFgKjG2rnVbr1kvv9EvnkG1POr5YnWHs3sYYpIz1SbSz0XU3+348=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JOLjtIAX; arc=fail smtp.client-ip=40.107.237.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km39a+xFucsG1SLnRAADLf67RH62Edy4rV435LQfN2b2LKKnMjuhQ1VhH9Yk2llAdIwKDRiym+ocmLCPHgpAusvk+CxNdzcuNKoQrujwAVneoltQ4IZZi4CWwwc4lkaxySLvtjFlf7KV4OLUL/imySP+4M1KtzhMULeeNEiLW6H7lX5v3GjvztiLxN289w48USQ+TGzk657Ze4Y00x3NaGlo4yGfWwXSQbOrJZ391Pe+8F9hsDVlrALjTgXhIPxNe5FqRSe+ZNqiaW9nsP4j/FQ3Z+Kq7pedtcPW3pS1IpY0PpoP/z0/J4GgdIvFk7+KUhcJXQTPDXWoBR5IotG1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKwAS6KfhRsITTyk/NLYP9JKL2rP51u9LHfgRXEFo8E=;
 b=BM8B4ETl2pQdFcLASkFgrJXG5dm/Tq7XJQPYrSakb3VqkDXodJhoOBcXGHQXG6nJEz8TCc/B4xNeEeCiZRWljWFuAtbSBMQ91lDWWDYStUbNiiafvMu45INL1Don9kSL4qZYmqjhtohUQLwqDIs3WXJQ2teEgr8xzlnRFAmkWQ3phA4+8MFiCXgj0L7WfD1gxoxZV0H7SDsiALD0L+rSKKtd/KQFGZ+/KrHD7IhwObxtudMi9O6A0iEKbW7NuxwTWXPSobGBP8LSf0moAZObmHjv/6jQ6tnLbsRtKCR67gD6UaVKYr9dqTlzKsc0QGFjTLRm1DEgCDAc6yJidlGkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKwAS6KfhRsITTyk/NLYP9JKL2rP51u9LHfgRXEFo8E=;
 b=JOLjtIAXEu4plJAKsEegEKKusSK3Qen9oIAtTcU8/Wh3GZqviI6Zrupy+MwRerIi72CX9Ol+wnWw0dBFf5pAwCFRwzscIVeEtEolsOs3uSOEWCMfAPf1t5ymLjhDkmFuiz1bd3fo9bTwWrAPO7kvMAFqxmFrBaZYGbwdUsX/dMcnxKvPPEmTl3rwkN52R+qn3LDBrduZOBN/SWLGMgDy95l7DY66MCrkM8U1R/LvKGObYJhFs8cvS0+spMs86b5ZrsuKNWfz1y+bM0EZuaGcW6MLl08t1OZ7hmejMO8ZXdcY3uWxXw/exhSpJd+LHgNfpUgo5uF8MFGFufjnhgokyA==
Received: from BN9PR03CA0738.namprd03.prod.outlook.com (2603:10b6:408:110::23)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Thu, 12 Sep
 2024 09:19:29 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::db) by BN9PR03CA0738.outlook.office365.com
 (2603:10b6:408:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:19:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Sep
 2024 02:19:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Sep 2024 02:19:13 -0700
Received: from localhost (10.127.8.13) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 12 Sep
 2024 02:19:11 -0700
Date: Thu, 12 Sep 2024 12:19:08 +0300
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
Message-ID: <20240912121908.000054dc.zhiw@nvidia.com>
In-Reply-To: <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-11-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e76884a-2bd7-4a57-0a10-08dcd30c00d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4JRu4GlsekjXQeuzeu3LcdmBKM7N1vR6tIv+/DwdP0xCiNK6BUlOJrh4ChQ?=
 =?us-ascii?Q?u11qa571y3vV0BwLbPzwivH97CBBnoYumISpHOjKWddQI0iaakCZpRhJbW/0?=
 =?us-ascii?Q?I4TWaY6QCGODdgEMXdSDpnVaxK+KGtbjNuKRVjtdnUD0V+Euri8NoZvJrfxe?=
 =?us-ascii?Q?yDwQ6OZpazNgwQU0LLQmhuyCrzbs44rmXraA044amEr2W49P/2ICMx6DwUF6?=
 =?us-ascii?Q?9q8JthIZD465WifBZSIn02HaIGIIOsOkwgNJtH6WKbfBOK0muCjKeqjQGIbq?=
 =?us-ascii?Q?l3gtMExiuwRHWHPOl6DIWAjLcBm9+JBQf4LJAzOUWYrbdC4z7cbjPFqk97Ch?=
 =?us-ascii?Q?qE1PgoQNTxEliKZFlyEtQSN7LB9Qx8oLQupokLZoM1uNdDsEdSt+NKVfjG+n?=
 =?us-ascii?Q?KmQoCUBlLsLNBV6Ip3EY8trbhmyePR+IxglxBvX2ghYw2drMBa6ndb90LqD1?=
 =?us-ascii?Q?aWcTX6ODJydlxflmRonw/uhuEdgUrI5ZbogRhLK1viyY+6UBqCg42Vw/66vV?=
 =?us-ascii?Q?81P3lcQCvjCYNgx6hLa2xXQsCThyUzvE6Y0GM1063D9VURG9D263ppipstFs?=
 =?us-ascii?Q?xWnQWvlKRubyuE7p1U0uDTD0jEGtpiNeA/ilAvzGG8XcQ+x/FkZo2Fzxekvr?=
 =?us-ascii?Q?riruzXMQoum05/NW6z2Z5WMgctx+5BW96tP0Iztgt5VeQKoJoDFfnpacyw7K?=
 =?us-ascii?Q?oozN9cTu05Ls0WqB5jnHapPiNUzYQRxmU9Cdi7MGJiDHnUee5kUE84gWOKYi?=
 =?us-ascii?Q?4Sr6pbSDKu6wvkctuevA0XnwFH7nACuOVa5Yj7GN1T0Qdu/xwAM4Qz3iSM2Y?=
 =?us-ascii?Q?rvkbM9AVUaYvVHArPN9chHImyxHwtcqb2p58LT08fszujlBFump35gzoLkjx?=
 =?us-ascii?Q?GoP+uk0ohnFnO/bf3cSt/wnm+3KjtT0aeBwTamqquAlepKUEGVxhkPA61b44?=
 =?us-ascii?Q?Xalr3hnaCx5r0Odv/Con5G2b7PEBf5tb+YH7BSC6/eMtuz9rB6Bas2Zd7/pb?=
 =?us-ascii?Q?WVL4oJJxIfoVYaGG9PDdc+bBJuaKyRGe3oEpSjwBEidOSdB1p2mhvUNEY8vK?=
 =?us-ascii?Q?0pbPJgy4/OoZ1FedEnArdXpfGQDZ11yuTALaFeJ12uewTeKEuHYROa43OXNl?=
 =?us-ascii?Q?6ehuxRRl6+8mutkXhqFvpHA56PW6MYdpWcUeLfrDcaj/ZZWSaFRaRtCg56zk?=
 =?us-ascii?Q?jsR4KsB/RjO/TH1bN/qU/LfPHkOT8iJsbfTwxn//cG1yLEIMz3sSb3fs0PYT?=
 =?us-ascii?Q?3V/iKc7sejZQ3libx51bWm+nZqsGfbme26um8NWf4sVSFhNJqIs0V7B9wUly?=
 =?us-ascii?Q?wHTzJP8wVp5dM6FSJ7I+lEzHJM/XSgcbQBIPr5JVP/ie5xIVaZljm1hcP77K?=
 =?us-ascii?Q?wjTnhcWGZ6dHupa+xKDu2wCqb/CTVvIlH+c6LSw9xmx1ZzCN9DUD+EhrvrPB?=
 =?us-ascii?Q?au7Rv6e7xOlSRxE9HtJNRW/vxmBY0gI6?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:19:28.5744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e76884a-2bd7-4a57-0a10-08dcd30c00d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756

On Sat, 7 Sep 2024 09:18:26 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 

Hi Alejandro:

When working with V2, I noticed that if CONFIG_CXL_MEM=m and cxl_mem.ko
is not loaded, loading the type-2 driver would fail on
cxl_acquire_endpoint(). Not sure if you met the same problem.

Now we are waiting for it to be loaded, it seems not ideal with the
problem.

Thanks,
Zhi.

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
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.
> 
> Based on
> https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 67
> +++++++++++++++++++++++++++++++++++++++ drivers/cxl/core/port.c   |
> 2 +- drivers/cxl/mem.c         |  4 ++-
>  include/linux/cxl/cxl.h   |  2 ++
>  4 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5f8418620b70..d4406cf3ed32 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -5,6 +5,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
> +#include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/pci.h>
> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>  static int cxl_mem_major;
>  static DEFINE_IDA(cxl_memdev_ida);
>  
> +static unsigned short endpoint_ready_timeout = HZ;
> +
>  static void cxl_memdev_release(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct
> device *host, }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has
> deposited
> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	unsigned long timeout;
> +	int rc = -ENXIO;
> +
> +	/*
> +	 * A memdev creation triggers ports creation through the
> kernel
> +	 * device object model. An endpoint port could not be
> created yet
> +	 * but coming. Wait here for a gentle space of time for
> ensuring
> +	 * and endpoint port not there is due to some error and not
> because
> +	 * the race described.
> +	 *
> +	 * Note this is a similar case this function is implemented
> for, but
> +	 * instead of the race with the root port, this is against
> its own
> +	 * endpoint port.
> +	 */
> +	timeout = jiffies + endpoint_ready_timeout;
> +	do {
> +		device_lock(&cxlmd->dev);
> +		endpoint = cxlmd->endpoint;
> +		if (endpoint)
> +			break;
> +		device_unlock(&cxlmd->dev);
> +		if (msleep_interruptible(100)) {
> +			device_lock(&cxlmd->dev);
> +			break;
> +		}
> +	} while (!time_after(jiffies, timeout));
> +
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
> index 39b20ddd0296..ca2c993faa9c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev
> *cxlmd, */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	parent_port = find_cxl_port(dparent, &parent_dport);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 5c7ad230bccb..56fd7a100c2f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
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
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index fc0859f841dc..7e4580fb8659 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state
> *cxlds, enum cxl_resource type); void cxl_set_media_ready(struct
> cxl_dev_state *cxlds); struct cxl_memdev *devm_cxl_add_memdev(struct
> device *host, struct cxl_dev_state *cxlds);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
> *endpoint); #endif


