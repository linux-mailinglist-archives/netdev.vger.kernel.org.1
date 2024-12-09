Return-Path: <netdev+bounces-150273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022F49E9BAC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81792819E2
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711914884C;
	Mon,  9 Dec 2024 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XYlVzKjd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409B313A3F2;
	Mon,  9 Dec 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761803; cv=fail; b=ZndzHJaOH8terFLqGJg6GBEXCk13SCv2Om9c+NFpHMEPdN+bNCjT9wZM22E2otfLgQo5tXM4xdv4iPtkTxSB7uLGlhGJFoZqU59M473D37OPnEwBihbWLTZt1afKl0xCjXhj9qT/cN0ER8jMgZhteLSA7mb3krhgc75hTOCObkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761803; c=relaxed/simple;
	bh=XV8D5ejhtGnkQg7xuFAXuEJ30SN7sabF5ddgibbmcO0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/Rrvai1i8GEtKrPgTErxqhswClO9vdgiVrNQPgGep/X6HJSfj/XIh5KHoS7KwuMsxYehvMBugx4Dd3KPJ+1/GMdlIVA6KHj6RK8GibmN3eoPkgil5ru7YStnC+GWxum8jwCKXXwY1J2MjnBdvA6xuZdWf+rBb5RONRD+mUvHjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XYlVzKjd; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUslStr+Vx8cdwGKmjDeUH7zeE4aL/dUg+ggmqq0oUF4IjX81J4jOKpuq6ISY766Y7LsQwj2D54Wbo//o7jic7HwABfnPoekVIfqSpl5iKWMJur02enAYpjoQ2yURW+9o4IPqwWbJ08KtFEXU3Efz7K2nomTc/SzxWsYdJqLfITRpyHm934PzfI98js5grOp0a+O/DMN28B2UZcJ7zbNkRVdrPRqBiV1n0+mKKxQLdwWB2ht3+Rn2cC6aByhPsJ9LAzEIHJ58fXeFvDRHTNSedV3Eqdv9eW3CrnOGUeUGjd7/gZysyzFSNyhW0hww0+2QcjmpMsm0ow26Z3+dxr9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJQD6vYe7DTOY/dDrwshOkAX6luwy+eUy6PvELf51bw=;
 b=LGCFqSYZsX5YO4ERXNL9CyfSb9v6ee54CLn6kNkWRN0rf1um+qQjDl0FBrFO1367L3y7AEB/xYKQIlfN+7ZaarjhwqD4+LdV4dMOoehvZTi2tVKMes64MRALuKxVb3n6lpLkDT8Az2rmdgvRUM0x3eihO0XSSU3dBGnYxYiODBnX2Aok6xNskWu/5lw9mAzJXDt0xd28aQbfGqp5YdkIZsKsF5iyeVDHYLqhj7ghYp9CJFhBtpgXuSprZB9n/EwhBkDvXycNmVWsv0RtxY5liI8dOlJcrqWl7qQcoeDHbYJaUlhH6ivR37yqAW7wB6wi19ODN7LUhYtg1aGr8kjqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJQD6vYe7DTOY/dDrwshOkAX6luwy+eUy6PvELf51bw=;
 b=XYlVzKjdmEbFykPVnzhZc/Z5Y6lI9hPhU+jo6nKi9pMKkTGjM+80GZCLDZ566bRR8MYVjHym1tI/6EpmJ7BNAaeQuL/RCE2+2+bvneW+oJKYEEYC6w4LUvNY+c9iGOL+94C1Olbvm7PjLqprBEPnNbUIm4aI1f29LzitOR1MUllo9TWu9xk6ByW7PvPR3syzsFqLaeQLzc2YorGuqBTHx0iuKinY/YY51tR0U3UPvZszqzlrXctzWSCDERNS5j3Ff4xP/k8SCiqJjVMu+ngkV+1HICOIqfq9SHP+JmON+gcsj9R2gcZPoABczrV52JO2ndF3P/JyRpLK4k33lu9Hfw==
Received: from MN2PR18CA0010.namprd18.prod.outlook.com (2603:10b6:208:23c::15)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 16:29:54 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::22) by MN2PR18CA0010.outlook.office365.com
 (2603:10b6:208:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Mon,
 9 Dec 2024 16:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 16:29:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 08:29:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 08:29:38 -0800
Received: from localhost (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 9 Dec 2024
 08:29:36 -0800
Date: Mon, 9 Dec 2024 18:29:45 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
Subject: Re: [PATCH v6 26/28] cxl: add function for obtaining region range
Message-ID: <20241209182945.0000082c@nvidia.com>
In-Reply-To: <57793990-1350-de8a-efc5-86dee5b215e2@amd.com>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
	<20241202171222.62595-27-alejandro.lucero-palau@amd.com>
	<20241203205355.000079a4@nvidia.com>
	<57793990-1350-de8a-efc5-86dee5b215e2@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 572e1882-9695-42aa-069b-08dd186eb670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lu8CjN4m0QpmTjnjmSt6RCeFuvNBRXmeEdzhJeGEVCyQYa17fwuT82WlD1VN?=
 =?us-ascii?Q?qZXr3kz6WgLb8yegpK8kv8mZrJbOLJeXypAk6UD9U43hmOm5XQfdMHAfCnvN?=
 =?us-ascii?Q?1NDXHvhYHpm0+dks0xpes/dwSjLNEGd0A0V5Ys9Qb21viaeV/0Xf1j5odI3o?=
 =?us-ascii?Q?4GcomrL8hywde1J/KOOBx1VvhmP1O8J39bLcru/TsCnY1v0dghb3ns/VwXge?=
 =?us-ascii?Q?u2SfEYkbdbNx/O4L2Pue5KWcoKs3GuhOoUa55h0TAbXutSUiExnNmww0cvt9?=
 =?us-ascii?Q?rpPOFyIjEN2vSLr1EmR22IMPxKzfQjCbr2q+su/6s0bBgL6g7mT8EbrKpbWS?=
 =?us-ascii?Q?2Tqx+OivpadWz2NABNvtdC+mGWTj4OI2T7YoPkvmF6nkf2w4ixqkEJMDRN5h?=
 =?us-ascii?Q?/GivoLRzWMPkBNflt3fgHB/q9AhWJKak4sYxEB8tkDXxNBlLCuxIH7TEc1IM?=
 =?us-ascii?Q?KT3E79xoSJ4zgNEVrCXABhcqAWGR4vmzlepk9mhCcL3CGwAvcQiRC922l1MA?=
 =?us-ascii?Q?bFWj5Nhqn6jRZmAsAHP0GhSXThH1sYZyBehvTaDCza5coMv3Hjmuup/E0PMn?=
 =?us-ascii?Q?EJ2bmC46k4s9v/nXIBirbifHWcesF4e40w2tpmLsXwrWjawu37CZpiUDXi3U?=
 =?us-ascii?Q?pf95F99/QYxglwurps9U0dyxDBqCVJUjtEN/XUARW7+MgXhFy531+fSug3iV?=
 =?us-ascii?Q?09nqr5ySAztZDHLoPIzLGEzW8DT1SkOaVYMN+mPvW0Hb0JtcTDNVEmbxZVJQ?=
 =?us-ascii?Q?aFJroE4EhefpN9KoGYOla9tUicCqrNj9qT7yLCE/7VMJM96hm+HCQnGO6SOr?=
 =?us-ascii?Q?aF592IOtNWW+T+vq/psUiszoGvlCrKOdMD9g81sbW2Kyua6v265dnD++9L/5?=
 =?us-ascii?Q?V/yeocAmrX6ZNt/ZxREMC3vc29ieaKidGSJv8YOboPt9BNYToIIcKQGwh7wm?=
 =?us-ascii?Q?XNDhILJ3UJVhYpOAwiL9anz8r93euU2t8ETJP+VBUUAmiGThIrRVUh1jHNQs?=
 =?us-ascii?Q?WSuaA3UCmr8S1AUqCcxQP5jjdVxSqIL3EtI+J0RUMcaBo3va/LtHTU+U0Ybf?=
 =?us-ascii?Q?0tovNLboHWp+9N2fKOpbN1lnb+ahEPm56g1DXwhTYNyMXCpTGXWXeawyp9jZ?=
 =?us-ascii?Q?7mDXVNVcLe8AyzMwyc6YLdCwMTJPZZEKZjc6Zhxs0IvAreSxh3uEIldCZC3r?=
 =?us-ascii?Q?lG5IpAD4fjD7RmEqNbINbrDjFlta2FQBRKnA/yMftQpabL87zqM7Z3CXyGZM?=
 =?us-ascii?Q?vBEJkbFhRRjx5VrU8aKgbqeiHCBVQAAvc8vQN4IbQobiT9zp4hfQpqf8zAd7?=
 =?us-ascii?Q?GPf9u++9vn8k6IzwjY3P3TmMc2EVFMJPnccqD+8RqzcRoks5cKotgPe45tQA?=
 =?us-ascii?Q?mrbV9WjjHFtkfB4EBuHZt2PLe6jYsfyhj16lCRZyy8t+dtTG2955vtLCwZCL?=
 =?us-ascii?Q?F5ucEi6KGaQAJHvdxnJdgObg3r6mZTW+?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 16:29:54.0711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e1882-9695-42aa-069b-08dd186eb670
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995

On Mon, 9 Dec 2024 09:48:01 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> 
> On 12/3/24 18:53, Zhi Wang wrote:
> > On Mon, 2 Dec 2024 17:12:20 +0000
> > <alejandro.lucero-palau@amd.com> wrote:
> >
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> A CXL region struct contains the physical address to work with.
> >>
> >> Add a function for getting the cxl region range to be used for mapping
> >> such memory range.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> ---
> >>   drivers/cxl/core/region.c | 15 +++++++++++++++
> >>   drivers/cxl/cxl.h         |  1 +
> >>   include/cxl/cxl.h         |  1 +
> >>   3 files changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 5cb7991268ce..021e9b373cdd 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -2667,6 +2667,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> >>   	return ERR_PTR(rc);
> >>   }
> >>   
> >> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> >> +{
> >> +	if (!region)
> >> +		return -ENODEV;
> >> +
> > I am leaning towards having a WARN_ON_ONCE() above.
> >
> 
> Not sure. The call is quite simple and to check the error should be 
> enough for understanding what is going on.
> 

A sane caller would never calls this function with region == NULL. If
that happens, it mostly means the caller itself has been problematic
already, e.g. stack overflow. someone wrongly overwrites the pointer and
the caller is not even aware of it. Thus it calls this function with
region == NULL.

In this case, we should not let it silently slip away. We should have
WARN_ON or WARN_ON_ONCE to notify the admin that the system might be
unstable now and some weird stuff happened and memory was
randomly over-written.

It is different from the second check, in which the caller is sane and get
a error code.
 
> In this case any error implies a problem with a previous call when 
> creating the region which was not likely checked for errors.
> 
> And if a log is necessary, I think a WARN_ON should be used instead.
> 
> 
> >> +	if (!region->params.res)
> >> +		return -ENOSPC;
> >> +
> >> +	range->start = region->params.res->start;
> >> +	range->end = region->params.res->end;
> >> +
> >> +	return 0;
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, CXL);
> >> +
> >>   static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
> >>   {
> >>   	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> >> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> >> index cc9e3d859fa6..32d2bd0520d4 100644
> >> --- a/drivers/cxl/cxl.h
> >> +++ b/drivers/cxl/cxl.h
> >> @@ -920,6 +920,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
> >>   
> >>   bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
> >>   
> >> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
> >>   /*
> >>    * Unit test builds overrides this to __weak, find the 'strong' version
> >>    * of these symbols in tools/testing/cxl/.
> >> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> >> index 14be26358f9c..0ed9e32f25dd 100644
> >> --- a/include/cxl/cxl.h
> >> +++ b/include/cxl/cxl.h
> >> @@ -65,4 +65,5 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> >>   				     bool no_dax);
> >>   
> >>   int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> >> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
> >>   #endif
> 


