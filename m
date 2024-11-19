Return-Path: <netdev+bounces-146339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E19D2F44
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F021F241BD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712BC1D2223;
	Tue, 19 Nov 2024 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0HcD3fS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7331CCEF7;
	Tue, 19 Nov 2024 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046800; cv=fail; b=K8jZtof66/sOqMtACcrCQdxw09uKa3T1e4B/lEDHLHdRR7U2YrZPFjqJPDXDxkrPwGr1bM6ZCOd6eFN7I5dbyssMny9wkhZgEZS2k/5Rao1bG6JwMXoyV0MYtvkVM5LxKEGZOfhUfKPx4YL9xFAqOR8L1KzBowpfRKswofnIA1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046800; c=relaxed/simple;
	bh=8lR0SvHBS0G//ZX+A3ZrnClMOuQLs6UvXUSvJfZ8Tzo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p89PbOhorWtlm0plqYiYRcI9Su7anUD9+pSquUZqjgzVmKMaxg8N1FEi/YDSNkLU2vSq3Z/vCwPvlvQZJEHaM4ybmvA3ZgQ4tV00SOlgS1h/3pCjZ17Ddnz8Zt5igQEEtYwSMP+Iuqdr6IpkMwC8EDMGf4+GInGpBisJQYmNANU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0HcD3fS; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/31WZ8OOUA2tpWpTbHuGikwFKYu4BJNqZsHuwVm5le8Wx175rmMkl/h+1XRNJm12FOP4pigI0SnbJ1n9kx+GM6vGYZITyg95pB0ORf/4XkxGc2y3kobhtJkixCGG/a5DdvzQeLFHIDeKlp1lyce0fAEDheZtyb5sc57vypO6NSwddj0NeXLPPtpYf8q7weh+ffnjRp9UaHDVKQBBBRTmO8+C5DPn0zTvpsZlNF8ESHhvgWROD6K/0MqLk7ozgRJU7icOUIul/1Oeo78RYb2jFrnTtDqKqAQildHctcR9VVjxf5jhbiW3Wv2qD9Kdn6Nrv4qQV86KgBxH7YPT6qZeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8QLAsYJgmoQytJCm+lQnS0FH1vZFl2BqlVjoBoY2WU=;
 b=CFoR2uGDWMsCusxpK69w3ouK0hJnic4eyYVmrW5qnWwu1orXh6J5HE8FxFqZ6FWzKpBtlOYuYPtYS+27B2PeMRYYMAyF/1e8bdMSdvAMBvFwfXDKi2aHkDEW/l76l5t8vvax4NmwaBUTJ8fJ7GnWCDadfnmgxQoOZohxUnviK15q9F2pmhLjncEpPtj5b2KOYoZUTlY85OjYTe+0Tl0fFDCbljbF5wV52dw7jzRYL1StHrXD2YQojZUQQmsslj00UqbI8ES1BZpL+tKb8Lu3lLrDjVh/kjYxjTuPaRot9wXwBtz0Ahkrobw6DaulPzKNatNElO3TFa2UcyxNy6Gbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8QLAsYJgmoQytJCm+lQnS0FH1vZFl2BqlVjoBoY2WU=;
 b=s0HcD3fSgcAasmfXthFRsPTOmdLhpM83kOITAxTVhDveo9/yZR9bIMdX3QGfjamQhbIh6yxfQ3ya8VM5xIq3CsE0UUDJtLNRlFT0JpAndJMiCgtiVNxvq3zBqOOFgMYffL+oqT2GkgMqQ+1bJw7YhjBbbO1vshgNn0FH/XXz6eTBCcBhn3JLGe/KIycEeyIEcwzgHeAIlcej7BRKdagTD4/c6J9Ov1CmQNO33i85czBSw2OyTXL7sb+TXLcSsdToNCprp0qJoNoFxloEdbm7eq82ILSSWVv/KinbqnV4NLRqbIHvrz53k5jogXBS04eNKUaYx5iks6GEntSc7C08rg==
Received: from DM6PR07CA0123.namprd07.prod.outlook.com (2603:10b6:5:330::24)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 20:06:33 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:330:cafe::f3) by DM6PR07CA0123.outlook.office365.com
 (2603:10b6:5:330::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.25 via Frontend
 Transport; Tue, 19 Nov 2024 20:06:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:06:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:06:09 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:06:09 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:06:06 -0800
Date: Tue, 19 Nov 2024 22:06:05 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>, "Alejandro
 Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v5 13/27] cxl: prepare memdev creation for type2
Message-ID: <20241119220605.00005808@nvidia.com>
In-Reply-To: <75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-14-alejandro.lucero-palau@amd.com>
	<75e8c64e-5d0c-4ebf-843e-e5e4dd0aa5ec@intel.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a774aee-4b63-4163-c421-08dd08d5aa36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5J1cLOvw1RaIp+USa+ygEDuOi2ytcCZBIiMTDs5AuAEJy2LrCfsRBdTURAB4?=
 =?us-ascii?Q?HkRf5W95JvN5G9mG6TCPu07vRoZ9nuDaCK3B2/+qumwqOP1pR9DDbxd1Y4RL?=
 =?us-ascii?Q?pGb51neH8CMJ0GU/pB6/FM5Cu83q/U2vuaTW//3DuAOQkRvp6NahoALcBc9u?=
 =?us-ascii?Q?fFMAxZp0F5rmi+SsPrx/piYB57+EMI74o5NNhOCWbw7bqIix5KNHe5zOQkum?=
 =?us-ascii?Q?Pu4RZkjvBsT8oC0gYoPkgdTDNq5gzsXjLUn4UOQXFVjBnUYucKgVYVfm+0s5?=
 =?us-ascii?Q?ptPwQBReBourVvVz/iFEvOiXYJmfIEWm0PVLxYixJ+pTKUhhEvT/jhC79Uf0?=
 =?us-ascii?Q?+yDcUPvsFngTr1jVFiHQd46MqCwFtTGiXM4V29SURQrKF2Q0Kvy0+EgPcEJz?=
 =?us-ascii?Q?NcobxC2ww3c92Pp3pZ73wTOE2cEsCT3cO92f2/DTSk6/tD1TgdclmpCYov2O?=
 =?us-ascii?Q?0HDQJsmObk5gJ0y78KIlOOPbryxUcU91TeKk+zBMukg5rITnyFd53pBuOTaY?=
 =?us-ascii?Q?RG4csImU3SHxc24wAL2hINzwF5teHiNB1AbzwYwtO3ENSZ/krVRdcXxxhhlc?=
 =?us-ascii?Q?RwhFo/+XlJgxXyq/qKpH0TYfT6T2Em6UUfEQvLzzDJeO56XzfXpH2TnLxP92?=
 =?us-ascii?Q?U3N6/OeOg9CGDPujJF02p+rFBVGwbT2eJenexiA9QrO0BHbrBG3WEUOBHp6j?=
 =?us-ascii?Q?V4hyC032b7Sfg/vie4X8w/HhEyz/gCWv3sRrKOUqDwoX/Xsgfqgip/Dme5mf?=
 =?us-ascii?Q?8O0+9KjUMmYEB+UPPROrfwa3RR/sBGlIkyFpPu+Xt3Cjh+5oV8HKsEbjVgyA?=
 =?us-ascii?Q?4/PdyUvXqT3/bPSkzC9JOMCAORpe6b1bbb/t9QGAkDR4N27z5H3sewzY+ekN?=
 =?us-ascii?Q?/7stzm6faOTEFt/I8/CBeH68fTvw1o6JoF++fIgizdq6dh4kIejBCPE/TEgX?=
 =?us-ascii?Q?e+BTCdAX9A26+b8lNjVFnqSPR2aprqgRfR2NkSf20Znv4x+8+AFweb/Nfcy3?=
 =?us-ascii?Q?Hpzf/XVUi9MsLANghoTZ8BCGJ7+8i6hhcWnUW+0NxZ6Aijb718p1d5SJHeCD?=
 =?us-ascii?Q?CP82l0cyP0FUbiz1epF3ZeK4BHYWLDa6T8jOSxZs+0cDKFW+t/cl3GftmWDW?=
 =?us-ascii?Q?OXrP6FCaqxS7J081Xzdz8Sxgdpqmbm1MG7kBhUFRGwSGTLF8qPvALuGC0tct?=
 =?us-ascii?Q?dU7HD6PxINeN0mAP0lTCAxn9rHhiZOCNH3XoOrITS4NnaCotk0CDobqYgTFS?=
 =?us-ascii?Q?pnNRSdHyQRYZzQ1ouq1M/QV1UxbEMKAzFHeR9bMBsDCVAW7Wy+2e8JU5qoym?=
 =?us-ascii?Q?JhPuHWL5HfgH9yCwnmA4iG0o2Frn38VK5wtzQMXR2PpMlUTUwHTpZESZlz48?=
 =?us-ascii?Q?L/u/jRTjiv4oqz8BjD+sZYmPTQkqPZkCWHhVLjfqFL/36kbibw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:06:33.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a774aee-4b63-4163-c421-08dd08d5aa36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064

On Tue, 19 Nov 2024 11:24:44 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> 
> 
> On 11/18/24 9:44 AM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device
> > when creating a memdev leading to problems when obtaining
> > cxl_memdev_state references from a CXL_DEVTYPE_DEVMEM type. This
> > last device type is managed by a specific vendor driver and does
> > not need same sysfs files since not userspace intervention is
> > expected.
> > 
> > Create a new cxl_mem device type with no attributes for Type2.
> > 
> > Avoid debugfs files relying on existence of clx_memdev_state.
> > 
> > Make devm_cxl_add_memdev accesible from a accel driver.
> > 
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > ---
> >  drivers/cxl/core/cdat.c   |  3 +++
> >  drivers/cxl/core/memdev.c | 15 +++++++++++++--
> >  drivers/cxl/core/region.c |  3 ++-
> >  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
> >  include/cxl/cxl.h         |  2 ++
> >  5 files changed, 39 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index e9cd7939c407..192cff18ea25 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -577,6 +577,9 @@ static struct cxl_dpa_perf
> > *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle struct
> > cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds); struct
> > cxl_dpa_perf *perf; 
> > +	if (!mds)
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	switch (mode) {
> >  	case CXL_DECODER_RAM:
> >  		perf = &mds->ram_perf;
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index d746c8a1021c..df31eea0c06b 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -547,9 +547,17 @@ static const struct device_type
> > cxl_memdev_type = { .groups = cxl_memdev_attribute_groups,
> >  };
> >  
> > +static const struct device_type cxl_accel_memdev_type = {
> > +	.name = "cxl_memdev",
> > +	.release = cxl_memdev_release,
> > +	.devnode = cxl_memdev_devnode,
> > +};
> > +
> >  bool is_cxl_memdev(const struct device *dev)
> >  {
> > -	return dev->type == &cxl_memdev_type;
> > +	return (dev->type == &cxl_memdev_type ||
> > +		dev->type == &cxl_accel_memdev_type);
> > +
> >  }
> >  EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
> 
> Does type2 device also exports a CDAT?
> 

Yes. Type2 can also export a CDAT.

> I'm also wondering if we should have distinctive helpers:
> is_cxl_type3_memdev()
> is_cxl_type2_memdev()
> 
> and is_cxl_memdev() is just calling those two helpers above. 
> 
> And if no CDAT is exported, we should change the is_cxl_memdev() to
> is_cxl_type3_memdev() in read_cdat_data(). 
> 
> DJ
> 
> >  
> > @@ -660,7 +668,10 @@ static struct cxl_memdev
> > *cxl_memdev_alloc(struct cxl_dev_state *cxlds, dev->parent =
> > cxlds->dev; dev->bus = &cxl_bus_type;
> >  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
> > -	dev->type = &cxl_memdev_type;
> > +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
> > +		dev->type = &cxl_accel_memdev_type;
> > +	else
> > +		dev->type = &cxl_memdev_type;
> >  	device_set_pm_not_required(dev);
> >  	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> >  
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index dff618c708dc..622e3bb2e04b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct
> > cxl_region *cxlr, return -EINVAL;
> >  	}
> >  
> > -	cxl_region_perf_data_calculate(cxlr, cxled);
> > +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
> > +		cxl_region_perf_data_calculate(cxlr, cxled);
> >  
> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  		int i;
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index a9fd5cd5a0d2..cb771bf196cd 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
> >  	dentry = cxl_debugfs_create_dir(dev_name(dev));
> >  	debugfs_create_devm_seqfile(dev, "dpamem", dentry,
> > cxl_mem_dpa_show); 
> > -	if (test_bit(CXL_POISON_ENABLED_INJECT,
> > mds->poison.enabled_cmds))
> > -		debugfs_create_file("inject_poison", 0200, dentry,
> > cxlmd,
> > -				    &cxl_poison_inject_fops);
> > -	if (test_bit(CXL_POISON_ENABLED_CLEAR,
> > mds->poison.enabled_cmds))
> > -		debugfs_create_file("clear_poison", 0200, dentry,
> > cxlmd,
> > -				    &cxl_poison_clear_fops);
> > +	/*
> > +	 * Avoid poison debugfs files for Type2 devices as they
> > rely on
> > +	 * cxl_memdev_state.
> > +	 */
> > +	if (mds) {
> > +		if (test_bit(CXL_POISON_ENABLED_INJECT,
> > mds->poison.enabled_cmds))
> > +			debugfs_create_file("inject_poison", 0200,
> > dentry, cxlmd,
> > +
> > &cxl_poison_inject_fops);
> > +		if (test_bit(CXL_POISON_ENABLED_CLEAR,
> > mds->poison.enabled_cmds))
> > +			debugfs_create_file("clear_poison", 0200,
> > dentry, cxlmd,
> > +
> > &cxl_poison_clear_fops);
> > +	}
> >  
> >  	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
> >  	if (rc)
> > @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject
> > *kobj, struct attribute *a, int n) struct cxl_memdev *cxlmd =
> > to_cxl_memdev(dev); struct cxl_memdev_state *mds =
> > to_cxl_memdev_state(cxlmd->cxlds); 
> > +	/*
> > +	 * Avoid poison sysfs files for Type2 devices as they rely
> > on
> > +	 * cxl_memdev_state.
> > +	 */
> > +	if (!mds)
> > +		return 0;
> > +
> >  	if (a == &dev_attr_trigger_poison_list.attr)
> >  		if (!test_bit(CXL_POISON_ENABLED_LIST,
> >  			      mds->poison.enabled_cmds))
> > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > index 6033ce84b3d3..5608ed0f5f15 100644
> > --- a/include/cxl/cxl.h
> > +++ b/include/cxl/cxl.h
> > @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev
> > *pdev, struct cxl_dev_state *cxlds); int
> > cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource
> > type); int cxl_release_resource(struct cxl_dev_state *cxlds, enum
> > cxl_resource type); void cxl_set_media_ready(struct cxl_dev_state
> > *cxlds); +struct cxl_memdev *devm_cxl_add_memdev(struct device
> > *host,
> > +				       struct cxl_dev_state
> > *cxlds); #endif
> 
> 


