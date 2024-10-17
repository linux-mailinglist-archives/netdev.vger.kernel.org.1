Return-Path: <netdev+bounces-136764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9979A300F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 23:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7A91C217F3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCFC1D618E;
	Thu, 17 Oct 2024 21:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IiDJNlVz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227C1D63D0;
	Thu, 17 Oct 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201821; cv=fail; b=pt6n2nuq0kcXgmXQb3TYjaKDDS0HVftuLuDSXpzIH6U3iHJ7+gZxKsGOSd5g9cTB03yFHBTY2BZ6KcAn46I2FJLNz2OLCCRi7IIdL6OIsnn1xSrQWfHWUSZJqyHit9Pcvb+H3bLWFZGRZa2v//2W7U0LVZ7g3hpdfQlGyZ0hVEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201821; c=relaxed/simple;
	bh=9Ho+0h2jU4Y54yF7a7DUfI7Q/qutQbhvSqSye9IfRJU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=JNkQVba9rjpUdKq0FQgGXm1KhgEyBEbbAt+LT1ZIKgxyHp3j3EEdEx9IFPN/C/6JwIKes+lRfeiOc89dxZO3k2qKVR3CCbeyaAA3WhptnmgVWxbAX9BVv8Ft+ryp01rqQh7w1FOm/IY1XGhSGBdXC7xiroQ1JBe9cdSyUPpnWFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IiDJNlVz; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR8fi8Osj9JQ97r+WDBWqv44JMOJM0osWqDzP1VR4u4PcSlOvL3Vh+DM1fC3/DbaMRev2H4XLdiOMkIDV7NN7ByF0jjYVAnScQimf0srD8aIZwO+gz8OMjMMWS1nGoM/ToQWFa9EdbMglkuUK1JNm6BN4MT3+Mn92jHm91aXxJLho29qFeB+HyTm7ski71aUBEJCh8+dSrFbWZcRCZMauT8qJvnZ9O1pWlLUmr90EPWRn7oQ+bguaDp301rbfjvVKlOnd7fOduDrzmlncLTcijOtftB9NMFdYxnlHJYfFdIebaXkD7PGUxCJGKT/LU1qelvmSaJdJXxosTyloUmCZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3RMbTgISAmyzE+QJDD/gHtMKzd7fEODWO9nLJExJDU=;
 b=CMlxuUf7VGLPzio5syIuhRp2lp3o+eIad6qu+/8GUOX0O3xs/ePcBz923G/Q9MKnDNKpLZ/qNG0nwWR1Y2HRe7AjI5vx/1WL9LyMKLblC/ZF63RjoL+gZ4VzYeXsrj2F/Oc+zazpI2rJoBTd4YrIVVRd2HwJkQ9klKf/rO92l/IydzV/kNC5eHPvFiKN3MMBBCwRCwQlHy8K9FMbRVWjzzZoQtD06oZnLAS3P3IA5B4J8+aGpU0JaVB1/77Fd1nezvEjM3fkW+ro3ltCv/8Q8V/Qyy26uCkkAMjAFzKGNjZ/sp1sJc9cOJCojI3XkEzRe5UuE5wLjykOJXxgI3xZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3RMbTgISAmyzE+QJDD/gHtMKzd7fEODWO9nLJExJDU=;
 b=IiDJNlVzmSeepX6490cL8KMApNdzlR9UvoYUuRiWLnnfvTWu4YGi9ee/5WrCJpLPZZclWp97EYucTFRgWzoBDMH3uEbh9xoW0ly5XUzSil1t4uJBdzwkv84AiduuRk2GFBdINCbEKIdRFm9+8lO1n8iEXJ7U2Ys+wTk+I3pIVY8=
Received: from MN2PR20CA0049.namprd20.prod.outlook.com (2603:10b6:208:235::18)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 21:50:04 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:235:cafe::7d) by MN2PR20CA0049.outlook.office365.com
 (2603:10b6:208:235::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 21:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.1 via Frontend Transport; Thu, 17 Oct 2024 21:50:03 +0000
Received: from [10.254.96.79] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 16:50:01 -0500
Message-ID: <4b699955-8131-48d8-a698-999d90523261@amd.com>
Date: Thu, 17 Oct 2024 16:49:59 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v4 22/26] cxl: allow region creation by type2 drivers
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 49102a90-27fd-4e8b-90fa-08dceef5a862
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU9saldKSHFsSFptQnVVWEM0TmNDTXpGejkvNm1QZS9EZ29BK085dUk4anZz?=
 =?utf-8?B?enNvNzRzbTZxWGI2WE0rTnNRZndNQUZZZW5OdFRYNGpMenowaDdhOXBJeHJK?=
 =?utf-8?B?dUZRbzZHb3JDUEh4enV5dHJFWGl0bGxxRXFzdHE5enBuZzg1N0Q4eUJ6dHd4?=
 =?utf-8?B?SzF2Mkc1bkRYSU1XRFZLbk1vNlZXWit1dkRqelk1RW1haU05NHZSdTNGa0RW?=
 =?utf-8?B?ZlhZWStFSjllYkx2ZHN0VFRKa3luV3lsM2Yxb0QzVTNTN3hRZC9qbXp2MzB2?=
 =?utf-8?B?ekVuN1dGdmNLKzlNY3VYRWlsa0doRXVwbHdVK0FCMERZaXFZMUJ4c3VWbDlG?=
 =?utf-8?B?WmsydUJwQUFwT1RkeDRaVmJlaDN0R29FelpUS0dDY0x1Y3Z6bjNPOW1zdmg1?=
 =?utf-8?B?RVVHL0h2eExBcEhuTit6Z2RkRUtYUkNTdW0wZ3grVjV6R0FKSjZMOEF6YVFL?=
 =?utf-8?B?T1RhTnlPazBNc2dIc3pHcUJNVjJBL1UxR292T0J4V2lXYnBnbkpMMlQ3OGtk?=
 =?utf-8?B?aUhYZ2pFcU1kMHk3eDlsc1VXTVZQOE9mZ281UjlrUkFIWGJ0a3dRR3JFb2RY?=
 =?utf-8?B?dHNEVXJCZ2F0MDFleGdQV1BUbjc2YjMyRlBBU1N4WjFMWFBrUUlKdnBzbVRX?=
 =?utf-8?B?UGZHQVZZTnZCL2VKWmlUN2c5R2RoV2FDbW1lSnhlV1dOZlgvSkNCUUIyc0R4?=
 =?utf-8?B?RlEyK01FSVd3cFV2SnZGVWRjS2YvVmFJYU9id3ZhTTROcnYzL3JOL2QrWkFw?=
 =?utf-8?B?Z2FJZFVrblJ0ODBRcnhrOTVRajdTM2tNWjZ6OEl6cys2QmxDY1lLdnJkMHU0?=
 =?utf-8?B?OGZzdGdJaEY0YU9OU1ZXQTJTYzFJYjVhL25HbDQ0c0Zab2VDbExQN21naWZL?=
 =?utf-8?B?VDRFUi9IbmRjMy9CeWVPNVZWTGFnRTJWYjBUcnlvL3Q5Y0FGb0NiaG5YeFNv?=
 =?utf-8?B?Um1HdHd3UEpYbnJJNHNrYTY1TXZGWnhiYzFZN2J5L2pubUQxMFFmdlU2ZWx3?=
 =?utf-8?B?YVVoOEdxZHZMSjRtZDRwMmtMOTg4T3Q5UzVjejlrZkVqSEJOWFVtNW5KZWd3?=
 =?utf-8?B?TFIvSnNYdjVqZlpzUWp2dnUxaU1weGRvVE5iaC9SSzZWWUN2K2dueGM4b2xk?=
 =?utf-8?B?KzJGeU9wd094RzFmRmx1V3p5M1VrTEVNQUkrRVB1Y1dwUVRVU1p2R05qeDRm?=
 =?utf-8?B?aGMxcWs4S2x2c25qd3pGNDlsRWpNaGo5MWJoRVFrVzdITDAzU0Ura1F3b1FH?=
 =?utf-8?B?OUppTGJ2em9LcmxNMzNZdHZnK1hrVWVrUkE3cTRwbGNsSWMyNFo4ZlAxMGI1?=
 =?utf-8?B?SnpGakU4S1lKc0lNaEJpeUlmYnplbVd3THYvYUJQb1NSd1J6TXV6QTg4L2Er?=
 =?utf-8?B?Yk5uQXByZUpqZ0JtUXlacVQ3Sk5STmFrNlQ5TWV6a2V3dE1YRkk1WjNOU003?=
 =?utf-8?B?TkF6azNHWXJ6bUx0d0RnVEdrY21FeTNaTkhXK0xQK2NSdVJoRHg3NTE3bTBC?=
 =?utf-8?B?NjJ2ZlM1Tm9HN01mMFVqeW9uMmhNSUJHS2psQVJONmNUS3BNa0srNkZnMGRI?=
 =?utf-8?B?MVRSZ0RCTzhhTFhZcCs3V3FETEYyVDhiUmZ2U2QzcTUrcEthQWhKRW1oOFV0?=
 =?utf-8?B?WG8rTkhwMU1OZEttU2V4eUJHaXkrTkpROEpTaGlCc1FpVjhKTnIzVEJ5NzZj?=
 =?utf-8?B?eTRFOVByNXlJVXdnT3lSaFJSUkpxbXA5TVl3UExRdG1mTmViV3lWeUFEQWxp?=
 =?utf-8?B?dyt0Mi9jNHRXRHNXc1ZHMlFqZXdrUU5hajRIWGc2TmpaNE9aS3EySjFkaU9u?=
 =?utf-8?B?cVdpTGl5Tko3UWtkUHJJRGJpR21Zc0xvbzhxYXVjenBIeTdIb045NWxldFIw?=
 =?utf-8?B?NmVTRlpKRWk3aXZ4Z2E5QkMrZ1ZEWTVobUd4U0F4LzhKbWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:50:03.8572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49102a90-27fd-4e8b-90fa-08dceef5a862
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781

On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 

So I ran into an issue at this point when using v3 as a base for my own testing. The problem is that
you are doing manual region management while not explicitly preventing auto region discovery when
devm_cxl_add_memdev() is called (patch 14/26 in this series). This caused some resource allocation
conflicts which then caused both the auto region and the manual region set up to fail. To make it more
concrete, here's the flow I encountered (I tried something new here, let me know if the ascii
is all mangled):

devm_cxl_add_memdev() is called                                                                         
│                                                                                                       
├───► cxl_mem probes new memdev                                                                         
│     │                                                                                                 
│     ├─► cxl_mem probe adds new endpoint port                                                          
│     │                                                                                                 
│     └─► cxl_mem probe finishes                                                                        
├───────────────────────────────────────────────► Manual region set up starts (finding free space, etc.)
├───► cxl_port probes the new endpoint port            │                                                
│     │                                                │                                                
│     ├─► cxl_port probe sets up new endpoint          ├─► create_new_region() is called                
│     │                                                │                                                
│     ├─► cxl_port calls discover_region()             │                                                
│     │                                                │                                                
│     ├─► discover_region() creates new auto           ├─► create_new_region() creates
│     │   discoveredregion                             │   new manual region                                          
│◄────◄────────────────────────────────────────────────┘                                                
│                                                                                                       
└─► Region creation fails due to resource contention/race (DPA resource, RAM resource, etc.)

The timeline is a little off here I think, but it should be close enough to illustrate the point.
The easy solution here to not allow auto region discovery for CXL type 2 devices, like so:

diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 22a9ba89cf5a..07b991e2c05b 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
 static int discover_region(struct device *dev, void *root)
 {
        struct cxl_endpoint_decoder *cxled;
+       struct cxl_memdev *cxlmd;
        int rc;

        dev_err(dev, "%s:%d: Enter\n", __func__, __LINE__);
@@ -45,7 +46,9 @@ static int discover_region(struct device *dev, void *root)
        if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
                return 0;

-       if (cxled->state != CXL_DECODER_STATE_AUTO)
+       cxlmd = cxled_to_memdev(cxled);
+       if (cxled->state != CXL_DECODER_STATE_AUTO ||
+           cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
                return 0;

I think there's a better way to go about this, more to say about it in patch 24/26. I've
dropped this here just in case you don't like my ideas there ;).
                                                                    
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxlmem.h      |   2 +
>  include/linux/cxl/cxl.h   |   4 ++
>  3 files changed, 138 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d08a2a848ac9..04c270a29e96 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2253,6 +2253,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	down_write(&cxl_region_rwsem);
> +	cxled->mode = CXL_DECODER_DEAD;
> +	rc = cxl_region_detach(cxled);
> +	up_write(&cxl_region_rwsem);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2781,6 +2793,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3386,17 +3406,18 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static void construct_region_end(void)
> +{
> +	up_write(&cxl_region_rwsem);
> +}
> +
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> -	struct resource *res;
> -	int rc;
> +	int err;
>  
>  	do {
>  		cxlr = __create_region(cxlrd, cxled->mode,
> @@ -3405,8 +3426,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
>  	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> +		dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
>  		return cxlr;
> @@ -3416,13 +3436,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s autodiscovery interrupted\n",
> +			"%s:%s: %s region setup interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		err = -EBUSY;
> +		construct_region_end();
> +		drop_region(cxlr);
> +		return ERR_PTR(err);
>  	}
>  
> +	return cxlr;
> +}
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	struct resource *res;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> @@ -3445,6 +3485,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  			 __func__, dev_name(&cxlr->dev));
>  	}
>  
> +	p = &cxlr->params;
>  	p->res = res;
>  	p->interleave_ways = cxled->cxld.interleave_ways;
>  	p->interleave_granularity = cxled->cxld.interleave_granularity;
> @@ -3462,15 +3503,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
> -
> +	construct_region_end();
>  	return cxlr;
>  
>  err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +	construct_region_end();
> +	drop_region(cxlr);
> +	return ERR_PTR(rc);
> +}
> +
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	rc = set_interleave_ways(cxlr, 1);
> +	if (rc)
> +		goto err;
> +
> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
> +	if (rc)
> +		goto err;
> +
> +	rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_region_attach(cxlr, cxled, 0);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_region_decode_commit(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	p = &cxlr->params;
> +	p->state = CXL_CONFIG_COMMIT;
> +
> +	construct_region_end();
> +	return cxlr;
> +err:
> +	construct_region_end();
> +	drop_region(cxlr);
>  	return ERR_PTR(rc);
>  }
>  
> +/**
> + * cxl_create_region - Establish a region given an endpoint decoder
> + * @cxlrd: root decoder to allocate HPA
> + * @cxled: endpoint decoder with reserved DPA capacity
> + *
> + * Returns a fully formed region in the commit state and attached to the
> + * cxl_region driver.
> + */
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region *cxlr;
> +
> +	mutex_lock(&cxlrd->range_lock);
> +	cxlr = __construct_new_region(cxlrd, cxled);
> +	mutex_unlock(&cxlrd->range_lock);
> +
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +
> +	if (device_attach(&cxlr->dev) <= 0) {
> +		dev_err(&cxlr->dev, "failed to create region\n");
> +		drop_region(cxlr);
> +		return ERR_PTR(-ENODEV);
> +	}
> +	return cxlr;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> +
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 68d28eab3696..0f5c71909fd1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -875,4 +875,6 @@ struct cxl_hdm {
>  struct seq_file;
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled);
>  #endif /* __CXL_MEM_H__ */
> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
> index 45b6badb8048..c544339c2baf 100644
> --- a/include/linux/cxl/cxl.h
> +++ b/include/linux/cxl/cxl.h
> @@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>  					     resource_size_t min,
>  					     resource_size_t max);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> +				     struct cxl_endpoint_decoder *cxled);
> +
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>  #endif


