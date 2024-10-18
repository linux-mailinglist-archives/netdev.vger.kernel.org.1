Return-Path: <netdev+bounces-137065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CF9A43F7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A8E81F2390A
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD92036F2;
	Fri, 18 Oct 2024 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6bvXIsG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A135155A2F;
	Fri, 18 Oct 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269646; cv=fail; b=lkLV5ScIYzdAH6Zk7khL6MafB85aCJdlH5IUUplTAHjwuttMLSkdDPX7agdliKuekFp5OjLQn6A1FR8kljuR4/PYJjc8Q+IanJGgth/WEs0g6lBdGUq/VD3SIZqHFtS0iwqi09AwwU9YQUVIixw31W0LnPo35+0b64MKa6BLt7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269646; c=relaxed/simple;
	bh=ijPf8xQURAkguHrKkbluKTmX4Rbsy78F/YO4SXBlVn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g11yfzOo7wt/FaDrWprqcf9iHJoVfIk++dizCNYT3N65SAg9mFOa7GjSkGKziN6zRqxL3Ofm38SEZw9OJLWQKUJueuwASotQh4nGcrFkxcB3oMGBc8SxWCmkNvF5KP6Fy8lvNgSo27wofLVEEQmAf9wMPCOUS3tn9KVVsjb1qv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6bvXIsG; arc=fail smtp.client-ip=40.107.101.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRTjFQGk4k3pBgcGkTON5HgohTmF42MF2OXUd1ltEOxJCwFFt5vzUdGOPRi2836kAVdDO3qZutSoQ2THBPU/Q3E6/VCbe43p1jspXrpxIq35PbvHJIR0XELODyjS1XSmlp/Fz0T5in13yHPGVAFWfYUSTiUS5S4F9ROYg8XZVhOaHrgw5p80Wjq3liAfRMJAZ9YXsX0uqzTGudEKI9HGEN2vz7WSB4/FNdo3b/zEy6z1rvnZBXi16NKtqL/G3GZQH8f7Es9u6AncISOV2hEU/EDRTnzO/6CZvVVViu4NeqvEtbEdCrSAIE5tkHMQJlF8PIaQz17b1wqJ6pYSAINZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=341r4yMqTpDZx6YA/+BUBxxmMZuGrPSGwcqNpHLT3kA=;
 b=TArJEhs2HMpq5DtDidQenZKADChwBsXyPkR8IDqJLBZVg6h0IHYBjJ/HGROvaEdm4fzwCxliTht+cI+6q7zprvl5a80ZFOS/b7jJwKvZY4zMGbpGC5P/+KshpC+eACoI4Yk3rBU5u3EwU6faf4P3vKGEqu00kMnykctMOseyJh6le2MdagMPmThOnodvfPLj5fKv0wG/BtJm4spxPN9TR4Q9VyWWRjap9heum5r0ET9mhPNQBb+PTU3MWuWiQvLpKxt8KuG3m8wsNvDgF6fda5gqMwSzTBP0p+9abbtBgnAhJ0PgWHYbcYlFZO1tNo2sLqRnxYEYQksDK9mR5JpezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=341r4yMqTpDZx6YA/+BUBxxmMZuGrPSGwcqNpHLT3kA=;
 b=H6bvXIsG/9Mu/ByG3ZpLXHRQaE4BULuV6Hs3ZNkdW1PvVWaqhjxWE5wIv8A+VJ+eOu6Wke3aYa2aGYFIoLZedFWcbZJ8MiTZcV0ybHi81JWIvPhI/mCw3cHsaWxIIyP2JDo5opRhCc2s7y2WcNBZvtMH+H/OHHUKcc7xY4nYoiw=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 16:40:39 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::c7) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23 via Frontend
 Transport; Fri, 18 Oct 2024 16:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 16:40:39 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 11:40:36 -0500
Message-ID: <d2fd0806-6bda-41a2-a1c0-78cf55d15654@amd.com>
Date: Fri, 18 Oct 2024 11:40:36 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/26] cxl: prepare memdev creation for type2
To: Alejandro Lucero Palau <alucerop@amd.com>,
	<alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-14-alejandro.lucero-palau@amd.com>
 <ae4e2c7c-f0f5-4e83-a1a6-83de2c254015@amd.com>
 <e3a4aed5-e3b1-ee00-1b94-6e45ee979fa7@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <e3a4aed5-e3b1-ee00-1b94-6e45ee979fa7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: d40cf491-29ce-47c6-dc29-08dcef939962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVdZbmsxOTBxaVpWaUlEQ3kwWlE1RVk1MDdJbnNPNk43QWtSREJ6bUgrc3RV?=
 =?utf-8?B?MkJHQ05NZkNQRmhlQ0tyZG1mbk9NSWxkZFZKRHJUcmxCc0hHd2JseEV3TVho?=
 =?utf-8?B?Qlg4QlpLZ0NiUStiWTdkU0lIVk4wMFJVeW1oL2g1cS9iSWUrSzBRZE81Qm9n?=
 =?utf-8?B?SVBSL3FqMzBMa3kybWtDT0M2TWFuZmoweWpJbnMyRW1WNmgyWmJBMG1RK2d3?=
 =?utf-8?B?MWNYNjgyelgwTVVtTTA5ZXNadFJ5Y2ZHSEJuWTFZVk5vRFBxUVBnRFNBVzRm?=
 =?utf-8?B?QmFSOFdEZzUybXRob0duS0Q5WXBKZzJwOVFCZ1c0UnNVWEdWYnpKbHJreEFK?=
 =?utf-8?B?Rmx6aVhBK1BvOU1xV1NvcEcydzJPTXJ1VTI5clpnU0g3L3ViRGtjZWQzdTNF?=
 =?utf-8?B?UmxSTHZ5bEVWb0RGZG9LTzYwODBhUXNnYVkrT3F4WkNjWGRySVZZTURselFF?=
 =?utf-8?B?OGdORWtzWVdPZzY3R3MzU3h5dk12RVgzWXdXRU9SZzJMWjlSRmdhcFBQRE1E?=
 =?utf-8?B?WDVic1doRjl6UW8zOEtnc2pjUFBEQU1vNXNxN21FS1JsS2RMYjRjamdPTkpE?=
 =?utf-8?B?Z2dkMWFYUG9OMlZVeGRaUGtxdmZrN3ovcHpTMTgxRmF3SWE4WUt5VjN4c2p5?=
 =?utf-8?B?MmdoVmt1bkJheU90K0p3VmRHbTFQeVFscXJpVHVuNHN6cG8vV0F3dU5lR0k0?=
 =?utf-8?B?UFJYQzNUM0Y0OGMxbnJCU0drNTBERHR3R0J5NDA4N2creDVjR3RkaFhyTm1Z?=
 =?utf-8?B?aXJTT0pyUERSS0NHSDRDQWtVSXFpMkpBZEVrbFVEVXFUR3NGSmYyeDM2WlhF?=
 =?utf-8?B?aXEydHR2TFVOaC9TR255MzJpdEdUMzBBaEJiR3B4VVlEMTdxbnRsMG13anJC?=
 =?utf-8?B?dXVVeXBUUXZUaVNYQUczNk5BdFphVHd1aUg0bzlNT0VRd1I0Y0RaWWVBb1ZF?=
 =?utf-8?B?MUx5TWx4azRibXpDSlJOUEplWVA0WmNOWmt0cjZQUkdzUU9wcnpLU2g3MVNs?=
 =?utf-8?B?dTlOK0xRelpNTTN0KzJ2MUFqbk1VZHRCNlFNeHg1Vld6bzBNUU92b1pNZTNN?=
 =?utf-8?B?SWxDbDlNVnl2Y21MaEtianVCOEtqeTFOM25pOGM3SzNlamhySnplam5KWE5a?=
 =?utf-8?B?bjNyaFpCQXZFVDREZmNDQ2pDbDV0eHZIWjJQT1pTemlQaU94N0ZSUTdTaURv?=
 =?utf-8?B?Y1RGWlF0Q1d5aGRFbzUxckN5RzNFUWVMSCt4R0Z6d2F1QUhaS04wNU51WURF?=
 =?utf-8?B?S1NnRjJnL3h0ZHJjUjZXZmdWZ2wveVF4Z2dvcHBOVVNETm9Jd0d2K0VIUnNv?=
 =?utf-8?B?NHdWVzkzL0ZlUDMyakF0WTdVK29hamtYazVxQU41SE5Db0ptd2NwaVBNaVhx?=
 =?utf-8?B?eUl2YkU3RmVmTHAvY3U0UGZhRjQzZ2FadU1WNGhZMldjUWUxR0RhSU9aMWJu?=
 =?utf-8?B?T3RkOUF2NlRxdk1iSVlCOEdNdW4rUnVFTDE0WVVqdFZFRllQcExQTGl6REtk?=
 =?utf-8?B?ait5M0ZRL0JnbUhrb1Rhbjgwdk5rUDQrK3hmcDFzSTQxZDFBaFhxZjRRVUha?=
 =?utf-8?B?NWw3Nit4WHB0MEtUZzVpUGthOFBlK1hsMW9OczduWUxubzJkenBKZmE5SEtt?=
 =?utf-8?B?K1duckpzUytYUjdjbVB3VkJFYmFjekhqSkR1WVVwaGN3RUkvekNmbXdCdzda?=
 =?utf-8?B?WDNta1UwTFNPc2Q0ek5YNHZBOU5TTW1WSy95NGQwbkZpNE8xdkpRQjE3K1Ni?=
 =?utf-8?B?VVVrQmxGK09zSEV2WllBNlpjYWpNWHUrbUJrZnFCMHVOdzJrK0dwMEVTY2Ix?=
 =?utf-8?B?Sk9YbmxKeU1hMWdqUDl3azhia2hNd2VhUWNQTkR6VWhIRmlySDgveWFTb2tk?=
 =?utf-8?B?aXFHMS9aaFIvdEljc2VjTG1VVTZCWWg0VmVXbUl2NGpseEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:40:39.1454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40cf491-29ce-47c6-dc29-08dcef939962
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287



On 10/18/24 5:49 AM, Alejandro Lucero Palau wrote:
> 
> On 10/17/24 22:49, Ben Cheatham wrote:
>> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>>> creating a memdev leading to problems when obtaining cxl_memdev_state
>>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>>> managed by a specific vendor driver and does not need same sysfs files
>>> since not userspace intervention is expected.
>>>
>>> Create a new cxl_mem device type with no attributes for Type2.
>>>
>> I agree with the sentiment that type 2 devices shouldn't have the same sysfs files,
>> but I think they should have *some* sysfs files. I would like to be able to see
>> these devices show up in something like "cxl list", which this patch would prevent.
>> I really think that it would be fine to only have the bare minimum though, such as
>> ram resource size/location, NUMA node, serial, etc.
> 
> 
> But this patch does not avoid all sysfs files at all, just those depending on specific type3 fields.
> 
> I can see the endpoint directory related to the accelerator cxl device, and information about the region, size, start, type, ...
> 
> Not sure if the ndctl cxl command should be modified for this kind of change, but I can see "cxl list -E" working.
> 

Sorry, I guess that's what I get for just looking at it without testing! That should be fine
then.

> 
>>> Avoid debugfs files relying on existence of clx_memdev_state.
>>>
>>> Make devm_cxl_add_memdev accesible from a accel driver.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 15 +++++++++++++--
>>>   drivers/cxl/core/region.c |  3 ++-
>>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>>   include/linux/cxl/cxl.h   |  2 ++
>>>   4 files changed, 36 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 56fddb0d6a85..f168cd42f8a5 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -546,9 +546,17 @@ static const struct device_type cxl_memdev_type = {
>>>       .groups = cxl_memdev_attribute_groups,
>>>   };
>>>   +static const struct device_type cxl_accel_memdev_type = {
>>> +    .name = "cxl_memdev",
>>> +    .release = cxl_memdev_release,
>>> +    .devnode = cxl_memdev_devnode,
>>> +};
>>> +
>>>   bool is_cxl_memdev(const struct device *dev)
>>>   {
>>> -    return dev->type == &cxl_memdev_type;
>>> +    return (dev->type == &cxl_memdev_type ||
>>> +        dev->type == &cxl_accel_memdev_type);
>>> +
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>>>   @@ -659,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>>       dev->parent = cxlds->dev;
>>>       dev->bus = &cxl_bus_type;
>>>       dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>>> -    dev->type = &cxl_memdev_type;
>>> +    if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>>> +        dev->type = &cxl_accel_memdev_type;
>>> +    else
>>> +        dev->type = &cxl_memdev_type;
>>>       device_set_pm_not_required(dev);
>>>       INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>>   diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 21ad5f242875..7e7761ff9fc4 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -1941,7 +1941,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>>           return -EINVAL;
>>>       }
>>>   -    cxl_region_perf_data_calculate(cxlr, cxled);
>>> +    if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>>> +        cxl_region_perf_data_calculate(cxlr, cxled);
>>>         if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>>           int i;
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index 7de232eaeb17..3a250ddeef35 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -131,12 +131,18 @@ static int cxl_mem_probe(struct device *dev)
>>>       dentry = cxl_debugfs_create_dir(dev_name(dev));
>>>       debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>>   -    if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>>> -        debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>>> -                    &cxl_poison_inject_fops);
>>> -    if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>>> -        debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>>> -                    &cxl_poison_clear_fops);
>>> +    /*
>>> +     * Avoid poison debugfs files for Type2 devices as they rely on
>>> +     * cxl_memdev_state.
>>> +     */
>>> +    if (mds) {
>>> +        if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>>> +            debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>>> +                        &cxl_poison_inject_fops);
>>> +        if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>>> +            debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>>> +                        &cxl_poison_clear_fops);
>>> +    }
>>>         rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>>       if (rc)
>>> @@ -222,6 +228,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>>       struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>>       struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>>   +    /*
>>> +     * Avoid poison sysfs files for Type2 devices as they rely on
>>> +     * cxl_memdev_state.
>>> +     */
>>> +    if (!mds)
>>> +        return 0;
>>> +
>>>       if (a == &dev_attr_trigger_poison_list.attr)
>>>           if (!test_bit(CXL_POISON_ENABLED_LIST,
>>>                     mds->poison.enabled_cmds))
>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>> index b8ee42b38f68..bbbcf6574246 100644
>>> --- a/include/linux/cxl/cxl.h
>>> +++ b/include/linux/cxl/cxl.h
>>> @@ -57,4 +57,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>> +                       struct cxl_dev_state *cxlds);
>>>   #endif

