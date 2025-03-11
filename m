Return-Path: <netdev+bounces-174016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B018A5D068
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F5D1897F58
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD91EDA20;
	Tue, 11 Mar 2025 20:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gLcsgldR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB7230BFC;
	Tue, 11 Mar 2025 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723603; cv=fail; b=JY+Fqb494nmiDBanloX/dzROFSmf6/ZCtdSKOs1DEjJYY+539KmbdbRZce7mrUCSwVdktEUU9sykHGlWOORrfd0ylbvw6r8rkhWJYVtB+rA+JY6tu33nDJrQM4CM1JVUZjaZRWwBVByqmsUhdrvHbcG3HRs1RbI7s6oLo+htB4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723603; c=relaxed/simple;
	bh=iAmz441RIHFQJsRwDw6lAUgd7Wg7T7p2ZL6jsgGVQb8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=WMkSMT6I9+K1o9m1PQ5qlQk2Rtw/7E+Ze4zd582/6QMla/ZHBADwsMYl23+JN5GIVRNzl8KiUZl/oHlT3QdGTIuzgxG1o9S2nWqZd8nMwPja4lijtu9/kzZf1IUUKFNzI8S5cBJUDRHxsbjQpKqCOnqZvm832eXKVDQqMTC5Z6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gLcsgldR; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9QQEfSzuPKG+/ng2j3Aw6zYw7kTq71VxeiiNWJU2iQNjwrGUPPrTCyS2a94rmqDekK6zBIkSajKOgHCxJqf4kSjzf/vblO5Gg4nxu809cbj5vudJi5umi43eljcsVZgMF22uMRbkfcJkgVDqGZ2+/iqaL2ojNagbGOkV3Eg9UHbqChBZWqSGEpoHlkiQfKLnPtQuxJ54Nk7blphJr/ScXFdI0DlgJ3JfoE78tzMvXbg0dWLg1By7Lq4Xbgvy/4sY6uxVJxg88nFpZgwb3LtDBJnBMBPW2EdHSZK5Mnpy481sLkJJSKMQs3/ceaWPrNgfBL1aB0jv4dP2dbX9Gd18Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwp2TbIkZX8teefhXQJJIgBwvWUzhpZFLFa9dM7rOmQ=;
 b=e3yog15t9w+0wVfzHVRTZU9UZRQJrxfoOu7BuW4BSbU5t2NmLBeXt7KdXwwztC20iw6+tWbQ0kIade8VqTL1HRhYZL/jTwwQQmU1hUEpUlKMg+/aNBC6l4ZuVYwx5wYwgPtUIb8o9jlL90ko6YQCsdN6PUqlEKwFZmsXuRMVizsaSq/1tpvpioeze9AiUrupg2X4KAbCjpKyBdstrzAghb72GlnYcR0QTTcRVJ5K/KDpppSUQ5SO3ts8zVXQ3idOKFd2rwrYkaXf+ubJs3qFxZAk308/ylB8RRPGA4bq8cXsaJgPA6F00r5Onk+c3hv9xluWqqPccM3S4B5b9wcBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwp2TbIkZX8teefhXQJJIgBwvWUzhpZFLFa9dM7rOmQ=;
 b=gLcsgldR1SEiOMxkKgKV9ZxPvKlzv73zNGOz5DGt6ylaZUSa7NWmidYPzYaiUoht6JXpI5as5PQwPgI2DUY6g7hGQv0WzQDkkjubiAcH2u7XPHooaLYqj5OsJPUl/e5gD7Rr9luKbAXoVBr+kyrc3Gw8mnHxyXAFh/cEgh/JYJQ=
Received: from MN0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::14)
 by IA1PR12MB7520.namprd12.prod.outlook.com (2603:10b6:208:42f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:36 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::d5) by MN0P223CA0004.outlook.office365.com
 (2603:10b6:208:52b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 20:06:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:36 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:33 -0500
Message-ID: <67ddf266-5dc4-4680-bc2b-1fee9713b53e@amd.com>
Date: Tue, 11 Mar 2025 15:06:33 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 17/23] cxl/region: factor out interleave granularity
 setup
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-18-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-18-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|IA1PR12MB7520:EE_
X-MS-Office365-Filtering-Correlation-Id: c34435e0-e179-4b39-0b58-08dd60d83a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzBWbE4xd01FcTkxWklGOXVtdzdXVFJUazZxNi9XbmIyMzZRdmVzMEliTllH?=
 =?utf-8?B?bVVYRUZTVWx1eWZvTTZUWU9IR0xocnhTbzVOc29aM2VyVnBvdkNwWjJLNGhu?=
 =?utf-8?B?S1NtbTV4TndhaEloRkdvWjBKWmEwZzlPdXRUVU04WVJEL2MvVndNOU9HQm5i?=
 =?utf-8?B?N2s0UFRiSkcrOHdxSC9DQkdsUjV5TW1IaDFzUUpYZ1RaK0NMbFdvVWx3aVVM?=
 =?utf-8?B?eG5sbmRLdm1pNFpETmZXNTFBenpwamVySytLamdxZUdSSzdYWlAxZG90ZjdJ?=
 =?utf-8?B?aWlHMFNhYm1EOUxnYlhWbjR3ZHlXN0VxeFhlOG1uRFdLWXhEY3lQR0FML1Vl?=
 =?utf-8?B?aW15a1p2TndUMmV6enFEWStqOW04TzlrSi9wejNLWktiand2VVE2YVhra1FX?=
 =?utf-8?B?WVAvUXMvSllkNGlVQlBGaXdwbWlDQ1lUaFNrN1pjdjNaaG56endqcWRzM3VE?=
 =?utf-8?B?VDd1dzRRMDJ5aGx1dEZPUXlzM252QTVicEswTDF4TFU0clc3SWxCTGcwUFEr?=
 =?utf-8?B?MENsSnJMaDJ1VVNNUmI1NWtCT05UMUNUTGpYbnFhT0lqQVJhWStmNUFJOWk2?=
 =?utf-8?B?UzVhSnJJRU51bkNIT0VNSUczcFRjL05yVlFYRmZ5WEFOenBJOURySXQ4bXBu?=
 =?utf-8?B?dGJCYUlZYU1VZ0hvaWRiUFVHZFlIZVdkWXNQanQ3emI5THZ2cnFWd0tNZTFj?=
 =?utf-8?B?NzBUWWtIZ05HeVVZUmJORDRDQTh5UVBBUHhUOC9EbEtTY3p2TG1kenQzdi9Z?=
 =?utf-8?B?TGJKK0kxT0ZrOWZHYTNiZFYrV1UyL2NpVmV1ZzBQcU1sczlTL3pXM3JpOGhz?=
 =?utf-8?B?T3FUSzRYYU01RUQ1ZWRjbnlsV2crVFBIZkVQVUlYWmxuakp1UWNXdk1RUkV5?=
 =?utf-8?B?TGx6SnZ4TUhqQnVSVStEa2ZObVhrbmtxbE5JYTVJdGNsUFV2QlZtNkJ0Nm4z?=
 =?utf-8?B?SEZrbXV4dHJYKzlISVNzL2tkbE8yRXBjQ0pLY09vYUdwcCtTRjN5dGFFT1RK?=
 =?utf-8?B?VUdkYzVHelpTZWRudlovSFdCOC9XamNFaVpkWDZHZXNaSzE3dVJoU0FmUGhn?=
 =?utf-8?B?Rzl6L1FXaGwxWGxzeUJpMzlHZVpnZkpvd2xqNDFrZkhRY2s3Z2hyZkVvR25B?=
 =?utf-8?B?ZTdjYUF3SnZ2WWlIdVBRdUE4azhCTXdWbTdERDhibFdHQW0ydTAyUTJmekxo?=
 =?utf-8?B?dERuaUs2aFRrUEZlRjJ3WVI5TzJ2czN6OGdBbTV5U1JtQnZPY1g0MDhUd1ph?=
 =?utf-8?B?NE8zVDFMWHIwRC9PbWl2OXBvT3NBWURKZDBRMG13aVBvWUJWVmZNM1NTSmJH?=
 =?utf-8?B?Vk5oSXBlOWpuL2NtYzBSWm5WVTRGVU1pWjhVK0RJa0gyQzVRZWF0aE1rM1F0?=
 =?utf-8?B?OXBWU0ZtcXBaa0JaQVJiQ2g2K2FwZVp1MVo4ck1NR01panVwVVB2ZTFGc0ZY?=
 =?utf-8?B?QytmZTBPMUdMNjVRSEhha3Y4UXRsYlBxY01lc3B3ZjhJSzNrM0FTMlBGZkl5?=
 =?utf-8?B?bGJPdnRoblVDaVFVUzRaYVhKVkZiMEtvdFE2VmtCajNoYlZBdlplY2o5SE1L?=
 =?utf-8?B?RlJvMzQ0YTB5NGt6TlFnOXZPK2RuWnJVTldmNWxqMXJxTFVGUnAzZDhvNFZT?=
 =?utf-8?B?ekx6UWd1Qmp0OWRvVyt2cHFlb29GWHpMYXhna2dUaHhEOHkreFNUWW9IV3g4?=
 =?utf-8?B?cGdpWW12Vm5LREd3N3RnY3pVLzEwRWlERnNPS3FJYVlkcWZYOEVWeUYva0Z6?=
 =?utf-8?B?TGNLS1NQdXdYeFN4OUZqRExiY3AxeUxTTDNVWnYwS242ZUF1ekMzendkV3Ru?=
 =?utf-8?B?UmVKNjJUMkRZaG52U3pqeUFmN093R3JubENhZ1dIdmZwVnJYYkcvcThZbDRG?=
 =?utf-8?B?Z3RxT0srb2pkN084SWJ4THV5WFhlc3l3c3ZZdFd0UU1mVGEvVk5peTdrTTZK?=
 =?utf-8?B?a1ZQUnR4aU9TYldYQjZ1SVlQMTVoYndXS2YyQzBFSktZOTZuNkZSTDFtQkRH?=
 =?utf-8?Q?cX4X87rHOdG5AI3GxnwNXo3F3/BJW0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:36.0874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34435e0-e179-4b39-0b58-08dd60d83a25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7520

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave granularity.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


