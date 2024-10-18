Return-Path: <netdev+bounces-137066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0936A9A43F8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77B181F243D0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297E203705;
	Fri, 18 Oct 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AVIsOFoj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531F202637;
	Fri, 18 Oct 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269646; cv=fail; b=XJ/DKSra7Db9S04/k7rkVn8vpNlKOXiw3yit2smupCQHBgjSZPRFyIpivFV9xJKdgDVRMOiR4fNOjwHJJgGSgXKT68woyZCFNVUgYkZ+xUWewXif3p4jJHlqq56ZiuYusKhHf+jIG63LJO4KN1F/MRSTh/+mqj/jTim2r2b9fhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269646; c=relaxed/simple;
	bh=WICnQUdONVFAsm67bbYsOGZ46haVdwmWNInarlKUh0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RRYibvoR1eHGbYuSSqIMUVzg4wlclpg7TqSViNV02Y1hEGu1fgwuCerEuOKNpIhvDgjjLYzRcoqerqkk9gid5oNRL4atNAHEJxlNoz1vQPHpebHOxgkvZvjvMbrOk5jjel2W7nxR71MbCLkmeJLSND1Jh2tfPYoGroSjonGQV9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AVIsOFoj; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUPZ/zNfOvawPWol1g2uzwNxGwOqfivHWQWmCXUMs0QkMoaddyrx8wUQ+hAImyxs4+fG51IjsuOuR+FDQ1URBkWWjJg9sV+I8idppVNsj5h0VuW67oj9bBIRcYVDBn2K9iEiY8JWd4ro77MKMeuJYM9PlffSTCWAYI6j7v1FRNyAJCX2SuIndF/pvoks1UQ5HRqeypuGxmRIuQW0KgmHEcN9Jd5xZSCrFrdm6X9Xlq9m7rJAyy5+n50tjWBItRKvNv4NZEoafaLuaoyEY/c1c3A0dK4rAdZ+OD8SIsTASrHjQW1wic+dblA7TgG3mGci2ZN8fVY8WdG+kJJO8O4BIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNginedhx1kg0EvLTZHwHz6NeQLnBMwNLkNY3MNsXnQ=;
 b=Ft8hGipL7/0nUfliFb3Fu4dQJQKP8ZJH//Gf4rT7oIzzEt+B5EGz0Xzhx5GDOq21Gn7sauSuGtkaScabexdeVKQYx+yT05ogD/UX2brwY2t0id0haQgTFHX8WdTc2CrH6Pv6F1YJMZhRRc7UvioIJdRU1YMMgckUWNXThyVOCvpchvwVCeIBbNHYUsRO5GBOHgf0J7HxxQMMw1YwxmT2lmZgWCt04ejndjXZFYcRiJIuPvtjJNzu/9FkZS26E3d8okT7bdQykc5b89UWzEi+mJOPotDbC5dJM5UxL0sDuAl+YOePT+N8T1b91vGGqMSHFpd+JHIzg9KMXG32oZrFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNginedhx1kg0EvLTZHwHz6NeQLnBMwNLkNY3MNsXnQ=;
 b=AVIsOFojs+KkTyZDyh/McRYrxhrRhvQZ8qCWObGtSgcoFK+CLlWWep1PcdL0kJxcyMJ95zHe8bdlXla0DPW4sb3YSArUO1BEFCU/a6RhoPmoGd+XTeTQyMk+IDYFL+sm79j5STmFyGW88n6rayQ7rzbAJqnvfKgBxCN1YSMekLI=
Received: from CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::15)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 16:40:36 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::ee) by CH0P221CA0045.outlook.office365.com
 (2603:10b6:610:11d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 16:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 16:40:36 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 11:40:34 -0500
Message-ID: <7a94adae-6fb2-4505-8988-4b82c1e2dfe6@amd.com>
Date: Fri, 18 Oct 2024 11:40:32 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/26] cxl: add functions for resource request/release
 by a driver
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-9-alejandro.lucero-palau@amd.com>
 <47168a34-f0f8-457d-8acd-88f0dd3ab914@amd.com>
 <13ea7d73-d34c-3368-2055-afd7a735f5dd@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <13ea7d73-d34c-3368-2055-afd7a735f5dd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf715cb-cfde-4203-8b10-08dcef9397ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWJ4aVk3Y09iRkJvcmVWTTRzOUx0eldwN1JBd1pJQ1RZbFNrYkU0SjM0NEpk?=
 =?utf-8?B?aUxZSWgycXppU3VTcXVoVGlJbi94c2s3djM1enZMRHBVcVF1YTVjWFdpUzc3?=
 =?utf-8?B?V3RCWFpEYklPcE1VTnR0V2x3NWZydnE5WENVNHM0dldwRm1laUdoM282L1BO?=
 =?utf-8?B?QjJhK3U1Y2dUb1I3S0NNam9lRURScFZIRGpXUmRVZVMzVk5NYjNValZQL3ov?=
 =?utf-8?B?dzM5QWl1N2xDZmlpOXA2UFFjeGxKRTl0RWw5TEZzYmpDUmlIZm1wTUFTU3ZN?=
 =?utf-8?B?cFM0ZHpEcUtGckpiTVc1Smd2dUs0ajJERW1NUGt3S1BjSkFNbllqS0Z1dUhO?=
 =?utf-8?B?NlBVVVgxVytKeEs2ZnNiYTJrZXFsVTBEOEpTUysveGdqcmFKWWNKdEkwZzlB?=
 =?utf-8?B?bld0VnRWY1ZHa0NXZm1FcjU1cW1rSTJWcmt1UXBTaFhnRldsbmVUYlY4Wmor?=
 =?utf-8?B?TGVCUlUvTmMwVTlDNmhCbkh0M0ptZStVRlhaV0N2QnRVMXNZOG9EdWdCcHhM?=
 =?utf-8?B?bmM2aGQxeVRjU1NqV1FlSEUyQnRoS0hqcHZiNXJOWHB2VHFmazJrVVltUU9F?=
 =?utf-8?B?RjNLUWdua3pHdmpOd0JqcTNuSWdxUE9BNHEyeFRlRVgrcWVEeWk5eHdJcCs1?=
 =?utf-8?B?UytUUkU0cWFKbW12WEoyVG1hbjZYMmsvWHd4aUFNMnZrejA2R3BrVEF3T2Rs?=
 =?utf-8?B?SlMrWkFCR0ZFOXlLSVR0Um8waldLbWVUdkg1aFg0M1JQT0pJeHkrS1BJa05U?=
 =?utf-8?B?NDlGeUV0Y1laSWR3QkRXNWZ1L0VGT2tORU5sZmhhTFdBVkFQVTBiT2c5VWZy?=
 =?utf-8?B?UXN3UloxU2hDVTY4M2hMWGxyU2tvUGJ1cmw1eUIyZzdvOC81eGV4K2Rja3RV?=
 =?utf-8?B?cis1TjFJblpmT0pYSExsZ1pZSm9hbmVCWWYyM2lSRVdXV0h5eU4rNVh2MEI2?=
 =?utf-8?B?L3lzQ1lDakkzQ2F4ZFNtUWFmOVBKL0JVYmJUamY2Nnc4UVFZUHRsR2w5Znhw?=
 =?utf-8?B?Wm5YL2lHbmk2MHdLWDJNUDBCa0NobGpGV3doVzViK2wrUVBlOTB4WC9LZUJx?=
 =?utf-8?B?alc5VmkyNERaYkdMWit4MFBXdTdRY2E0YzFRYWNVREFpd0xrT2h4SVFaNDdj?=
 =?utf-8?B?eW5OSUNnbTMyOXgrMnhTRFl0UmRxZktrSjc5N1l3N0ZoL3N1c3h3ZVh0UENi?=
 =?utf-8?B?NVoreCtMbFI1eFROOVM4UnZNdzhMQUFLYTQ3VDAxSnBKckJiTnR0V0x4VDZn?=
 =?utf-8?B?QmVqVExIcW9jU083TU9OdDNuK2FjRWViaHVpQVRZbWI0ak1JYzNoK3FIVWRi?=
 =?utf-8?B?V1ZGWjBIK3dhaU91Ym05Y3VXU1d2cmNnT2NsNGg3YVUvaTF6djhvQURIZmVl?=
 =?utf-8?B?cEFSZnlJYVdCQ2U5bFZtK3Jsc05sTVlPd3ViTGtUUXlLV0xGdVptbWsrZFA0?=
 =?utf-8?B?ck85VkdjR2EyNlAxTFNlcnNCaTR6OGtGb0ZLaUg0OFFrR3RCWlJLWGhqdGpD?=
 =?utf-8?B?ckx0aWNVc21VaWwrbktUTCthTEVFSW1VOUY0Rk9LcC92UmVDUkcwTDFLVHVF?=
 =?utf-8?B?alV2QjVDT0gvMTFoTVFjMUdpeE43eTBXVEVOSkMweUdPcHZwK2lySVRwc2J5?=
 =?utf-8?B?TmVsTWdmOG9QQ0Z2dTFjd2pSc1A4dkYvZDkrMmJSVGd1S1lJT2lCem0rSXQw?=
 =?utf-8?B?eTV6cUF1dnlBbHFWU242YUI1aGExY1dQczZiUk1vMkxtOGowMHBtSEFNUzR2?=
 =?utf-8?B?YjUvM3BXSnNKRlFuTVNxVVQxVVpicWpXeHJoTS81VXp6N0dBbGpDdXdWL2FP?=
 =?utf-8?B?ODJNeE1DVjgxRTRnU0oybERXQ2tINlJCb3ZrdEtpUW5mdm8zWW11UW5PMWdT?=
 =?utf-8?B?NEptWDZWTDZUMXM3a2JUWHpybGVVMXhab1JRR0lFRWRJRkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:40:36.2859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf715cb-cfde-4203-8b10-08dcef9397ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351



On 10/18/24 9:58 AM, Alejandro Lucero Palau wrote:
> 
> On 10/17/24 22:49, Ben Cheatham wrote:
>> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Create accessors for an accel driver requesting and releasing a resource.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 51 +++++++++++++++++++++++++++++++++++++++
>>>   include/linux/cxl/cxl.h   |  2 ++
>>>   2 files changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 94b8a7b53c92..4b2641f20128 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -744,6 +744,57 @@ int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>>   +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>>> +{
>>> +    int rc;
>>> +
>>> +    switch (type) {
>>> +    case CXL_RES_RAM:
>>> +        if (!resource_size(&cxlds->ram_res)) {
>>> +            dev_err(cxlds->dev,
>>> +                "resource request for ram with size 0\n");
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
>>> +        break;
>>> +    case CXL_RES_PMEM:
>>> +        if (!resource_size(&cxlds->pmem_res)) {
>>> +            dev_err(cxlds->dev,
>>> +                "resource request for pmem with size 0\n");
>>> +            return -EINVAL;
>>> +        }
>>> +        rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
>>> +        break;
>>> +    default:
>>> +        dev_err(cxlds->dev, "unsupported resource type (%u)\n", type);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_request_resource, CXL);
>> It looks like add_dpa_res() in cxl/core/mbox.c already does what you are doing here, minus the enum.
>> Is there a way that could be reused, or a good reason not too? Even if you don't export the function
>> outside of the cxl tree, you could reuse that function for the internals of this one.
> 
> 
> Although they are obviously similar, I think it makes sense to keep both. The CXL accel API is being implemented for avoiding accel drivers to manipulate cxl structs but through the API calls. With add_dpa_res we would break that, and calling it from the new cxl_request_resource would need changes as inside add_dpa_res the resource is initialized what has already been done in this implementation. IMO, those changes would make the code uglier.
> 

That sounds good to me. I just wanted to make sure there was a good reason to have this set of functions as well!

> 
> Moreover, your comment below about cxl_dpa_release is, I think, wrong, since inside that function other things are being done related to regions. BTW, I can not see other release_resource calls from the current code than those added by this patch.
> 
> 
> So, , I'm not keen to change this now, but maybe a good follow-up work.
> 

From what I've seen, cxl_dpa_release() is only used as part of device cleanup so that's probably why you aren't seeing much usage.

I agree with you with regards to the extra stuff in cxl_dpa_release() with how the patch is right now. I think if DAX region
support ends up being adding the extra region management done in cxl_dpa_release() may be required. My reasoning here is that
at that point we can expect more users than just the driver accessing the CXL resources, so a more managed remove will probably be
necessary.

If I'm wrong about this, then this patch is fine as-is.

> 
>>> +
>>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type)
>>> +{
>>> +    int rc;
>>> +
>>> +    switch (type) {
>>> +    case CXL_RES_RAM:
>>> +        rc = release_resource(&cxlds->ram_res);
>>> +        break;
>>> +    case CXL_RES_PMEM:
>>> +        rc = release_resource(&cxlds->pmem_res);
>>> +        break;
>>> +    default:
>>> +        dev_err(cxlds->dev, "unknown resource type (%u)\n", type);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    return rc;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_release_resource, CXL);
>>> +
>> Same thing here, but with cxl_dpa_release() instead of add_dpa_res().
>>
>> Looking at it some more, it looks like there is also some stuff to do with locking for CXL DPA resources in
>> that function that you would be skipping with your functions above. Will that be a problem later? I have no
>> clue, but thought I should ask just in case.
>>
>>>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
>>>   {
>>>       struct cxl_memdev *cxlmd =
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index 2f48ee591259..6c6d27721067 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -54,4 +54,6 @@ bool cxl_pci_check_caps(struct cxl_dev_state *cxlds,
>>>               unsigned long *expected_caps,
>>>               unsigned long *current_caps);
>>>   int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>> +int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>> +int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>>   #endif

