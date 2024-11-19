Return-Path: <netdev+bounces-146343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E396A9D2F67
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 21:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736C41F23459
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 20:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E114A098;
	Tue, 19 Nov 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cgUmg2Am"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B91D0F5C;
	Tue, 19 Nov 2024 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732047810; cv=fail; b=BwSwFvDDUGv7AD5eeYxye+FBA+fNiLv2cV4LMdyqwxknV6HRxXzg09SEoolc0FRF0d2ydR5GaaI1+j3YRUfHIFKWMajhshBKTPOffRHRn5F7GTMWNGvG75mPZUDwoYy6e+Y7gZBMFB9fd2OavGP5mBPg/8fZBKpL/jhvx4RYsHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732047810; c=relaxed/simple;
	bh=hbfHoZhI3dp/7d5a1sezboT2gbMiGcYsu5+LkNx4iUE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXJ07vVRq0F+Sy5+amQalVZ8qlSHNGHACdiFHVNSeMVNxZ27sKZtlZMpx2hnA8qoUtI4NvTcOe9sqdQv9evni4vNBqWNm9b5aPuC1aIqQTpDElUQJK1AWIyuyXsNUzTGcx98EvJMuqCDZosdFc83MBud/KC4jzNaz81M7NUS0UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cgUmg2Am; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQUh/1DcSvo1VBxotBlnuWFkhJ0z9psMu2XAdNQHyWTj9Ip4QlUyskDmDjvgmzrHCCAErYZ4YaERYgCh4MFmRsCOajjwQ3gjJotBh+ixZzwLmCoD7i5KWlhHNU1y5wRvDLZug5rMUlYimiCV39eL3WI8RTpeLD7oKtBvT7kV+KuMLU9fSBTeYA95aQ46KXHgh1d++IPWTepCAldB+TIUfcRsL7+WUxMotIEVQnOzNSL6J+j2uudX8rxOjfFPCjq77CLRCGgk82K0UjqQm9BxDt9HsfPj4Da9AdrELIg/J1QIIy8z5z+QNUA2y11SBMb80fng8UmEy2I5+8ZMO0A+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5eV0LssPGyndMGcC8cckacQYjZ1wX+E088mcnEMAxU=;
 b=uQ3XcY1tVEgok5tyy1EuJHMJijH30MpH54/lWCUo6HatfCTU5PO2v4uxv4f+ihYMLz3OH1UBIUgfcVJinPctVyKAZ3LS7bZ2SAIMJewZMZblp0XO+lhu2Uqn9EtrkjPFBVCBuHmJzxY1ThnVEoqLw3pHbcbRCaSAAhXASY2F6DPMOsxfNSWTS6ZpcqThxWbNfYi2u1EJsh3ClK/eHsPp9vSiCkSh4lo6k35N2OpTe/4ZtE+BzKc9k1p+cMma0BcHQqXsE3DYkeeSKX6ZYr5+uVXl0wTK3AYl0dQ3T6saGjJQ/WxzMYEO61Hmiro03xK1Uf6pXh+gHuBFa/hHyN74Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5eV0LssPGyndMGcC8cckacQYjZ1wX+E088mcnEMAxU=;
 b=cgUmg2AmErBPm/tvk3ibnM6ouYkAsTQo9jwgxov1D1e5a+MiBYoKK+yY3JsudWLRsUBaon+S4gwRDzmjnqpOct7lLBnDFC3XF7agERxuWCLXNrOJ5ScHvjXyZIETCQXAMxFta6Y6V2KJbiHdTWC/9qrU31R0w9QFF6+XtOeuw6YxK8rLit1sKOwL90g/CNr9J66TWWF9yOLQK6a9nbVKG/RNMZzTyA5BZwky9uZKIZsWgcmoGnOqgZCvml32MtfgYjekQa5KlT2LlrpDL03x7rbJuRAO181QdQbs6eBBvBv5VAb6ByiGDQayArZOJ19ZQqAMmjio42/IeeRZSx+xvQ==
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by MN0PR12MB5884.namprd12.prod.outlook.com (2603:10b6:208:37c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Tue, 19 Nov
 2024 20:23:21 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::25) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Tue, 19 Nov 2024 20:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 20:23:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:23:05 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 19 Nov
 2024 12:23:05 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 19 Nov 2024
 12:23:02 -0800
Date: Tue, 19 Nov 2024 22:23:01 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, Alejandro Lucero
	<alucerop@amd.com>
Subject: Re: [PATCH v5 21/27] cxl/region: factor out interleave granularity
 setup
Message-ID: <20241119222301.00004269@nvidia.com>
In-Reply-To: <20241118164434.7551-22-alejandro.lucero-palau@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
	<20241118164434.7551-22-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|MN0PR12MB5884:EE_
X-MS-Office365-Filtering-Correlation-Id: db24cb54-ce40-4ba5-9b31-08dd08d802ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sh4olhre9A18XOp1o5fJUcJPi6IOzC/cmT2XgaEDKyPDkDs7f09/GkTYcjI+?=
 =?us-ascii?Q?a1JEtf8sDIGuCKaxWxKZRHS8DNN6dIuepwLGv1DF5AXcV9OrDVZfMSSTIH6L?=
 =?us-ascii?Q?IQbYE9gArhHxgmO8PDVebCmrhjGEEuS/6Z6X6hv6/Y+y5ejRCFtjTVbxtKpu?=
 =?us-ascii?Q?+SyaeF9ZfKf+RjDNUmldGlDYaYfhtLiFXKChPFWuU5rUK2enfLxcdlYpRdnU?=
 =?us-ascii?Q?VZZaKrZFNBN3aa8n3d8W81NXXLd2iSKL7jET6s3mSup9pfUf4SROWD7Y6Rtj?=
 =?us-ascii?Q?sgm8RNZAmHu3nbt5QLEXsG951HpTRDMCk51fOye+Go3acErYMVhB01ik+tpm?=
 =?us-ascii?Q?AEpeflrVZXpxUk0Rg7IMG9uzkjIh6peafpFiyhalspS6IMVrfCP0inq/nrDr?=
 =?us-ascii?Q?UNk1PdBZiJ+9v/61mma3lTOPvBmYDVF7G+5hz+233dvyNIlrUmM/Qc+mPiw0?=
 =?us-ascii?Q?8D7hopzzGhKUxwyeacA0dVWcnasCYLAjcsOcuSFOvOR5aBJchgO6t6SYstfQ?=
 =?us-ascii?Q?f5AlehB21KKv7pjH65DVgagELN4hGzcV7gk4tizmXJxMZHUTWVSp+TjdrnyD?=
 =?us-ascii?Q?dXS9K/wPW3FEgjVGAHa+2oOcTTL+T1ffD4oYX1kEoGeEiHjfa5qbxNZe1AvR?=
 =?us-ascii?Q?EUifmYvDJUZ4rYR2PK5AjA/AVfL2sxfNYRy9lO1Z5QuHsi6fsjRDFSmqURBP?=
 =?us-ascii?Q?1/NiAU/FPgP4iHIBq6fz1ASko+K5Dq0J2tXJZaEkIpJAiKqqCNLGgN8K8hTC?=
 =?us-ascii?Q?7CsAkpxsJ5yzQorP5nZZ0H7jFJ7fs5HgHXeLTAc+lARhaTYN/7oOIehaE+4d?=
 =?us-ascii?Q?k+oF5sOGgQ+7fryCJrPwhHWDW1OgqfBl/SKox6SDfa5RrU/CQNfw8Ap9Sen9?=
 =?us-ascii?Q?v4qoXcIEXhe/cjsam64BjEMTqH7YxO1ndQBERrCl6SghxMdwK3vMBGVbQDUt?=
 =?us-ascii?Q?yKttDbnwErcS+wprQFUFJTBiqCz6jy80xGACcizthJGEHKPUcBe+hr6zK/MY?=
 =?us-ascii?Q?O1HobPJytv65EyI4JBCNtvwbZkJPfdNILReTY+TW/xhw7mJabXC/2jmzT3pE?=
 =?us-ascii?Q?i47xmvYajsvI04tKgR4ZtBPAmwH+UFCF/ODhm6kyTO1Q+fgHUn7CbLgi1PMt?=
 =?us-ascii?Q?F5ErRKGkdjaValhMeWM34yFPUfF5LopREu8YizBGAPKp4wHu3AMw3e5/mM7z?=
 =?us-ascii?Q?RbyBx4xoVNibY/no75Ngidgw+EWVV9jI7IhpWdTu6Yo/aZA5EanA26AXBLvS?=
 =?us-ascii?Q?mOfDFaQpfnDjVKvMic+idrrYh/YatQPjI/Wnsjn8iTe9ghg+nQUX0rcUgLdw?=
 =?us-ascii?Q?EprK9BPaRtKiWSTUPGZn7gl36ZsEc7v5fB3ktCXsFJjUOnPO4akNeX0fZNsZ?=
 =?us-ascii?Q?6IgR+87OcQ7sCcFp7u36qqGjWbTBzwVDjmhOlajvStmz4ZLn6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:23:21.0065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db24cb54-ce40-4ba5-9b31-08dd08d802ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5884

On Mon, 18 Nov 2024 16:44:28 +0000
<alejandro.lucero-palau@amd.com> wrote:

LGTM. Reviewed-by: Zhi Wang <zhiw@nvidia.com>

> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 39
> +++++++++++++++++++++++---------------- 1 file changed, 23
> insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 04f82adb763f..6652887ea396 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -540,21 +540,14 @@ static ssize_t
> interleave_granularity_show(struct device *dev, return rc;
>  }
>  
> -static ssize_t interleave_granularity_store(struct device *dev,
> -					    struct device_attribute
> *attr,
> -					    const char *buf, size_t
> len) +static int set_interleave_granularity(struct cxl_region *cxlr,
> int val) {
> -	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd =
> to_cxl_root_decoder(cxlr->dev.parent); struct cxl_decoder *cxld =
> &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc;
>  	u16 ig;
>  
> -	rc = kstrtoint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
> @@ -570,16 +563,30 @@ static ssize_t
> interleave_granularity_store(struct device *dev, if
> (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
> return -EINVAL; 
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
> +
> +	p->interleave_granularity = val;
> +	return 0;
> +}
> +
> +static ssize_t interleave_granularity_store(struct device *dev,
> +					    struct device_attribute
> *attr,
> +					    const char *buf, size_t
> len) +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc, val;
> +
> +	rc = kstrtoint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
>  
> -	p->interleave_granularity = val;
> -out:
> +	rc = set_interleave_granularity(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;


