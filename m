Return-Path: <netdev+bounces-228438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B23ABCADA7
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 22:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DAE14F2BB9
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 20:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B752741CB;
	Thu,  9 Oct 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LS49J9Ma"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5E27381C;
	Thu,  9 Oct 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760043363; cv=fail; b=bPddqyULR8Me01EPGWTpGKq5f5AaU5rondMi68zTMOR/zqQKpnAjAtKcBZ5j1FHqMIEp6KABXvsyLc09omqvbMdZbOAUpvRAYKOgUviwWMT9fPisBnneqtj+ruik4vS68X35xhf3P1uQyh+5Ad5/+Occ972Gf43Sqe4Ky8kaxA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760043363; c=relaxed/simple;
	bh=kXAT5isOoTrVT0kGhjZVtAe6RHD75lxZdzTDMQnnXbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=OHxVozDiP0ZIXtbXoguKR/nz+kIco7r4kasLmCiJouIN81QdNZ0JlOmyttmFxT6dszO5IokHiTFvHD7Ho+Ik9UG3YczHApG6Al91npXURYBp2mOQdQEJAkzWt3aMqudH6g8x5vMJc9poddCVI9/TJ7nGb0YVFHQ99AkQ1p+9yLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LS49J9Ma; arc=fail smtp.client-ip=52.101.48.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQs4t4MGbkVtEL0h+Gvra4GFJmK2uTXiABoLqlRWbBgrj+9zV/8VzjM2YtDsBKNuHmxImPoBOKpLJgKZV3ZbbY9jV6AapVAdupWH1nCS/GF/qsmpdlXj/iHsQgbMiJT2fAm3R/oUY2Uo/FQl8qhET9RjAymPwq8YELELucv91ObiGsEWKONqTHp1gBZ71yyNo0OBijFhxv7RrskTRX7rKusv4bxvFZvs2lr16O/rMcj2G6my/yV0vKPO7kxjzR/Da4CRL/mT0jCZadIXPoagIObzwy37MC+zISjBkPxX+Fwi6dtfwmkMoZcp9W5jliCaH6OgMGaFpe5b8ny9easLwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcAnCT4w3/469ATGI3dKyZV++xHVHdQ07/8PBksOuqc=;
 b=dhxTCZpzFSxi7Yu1wWE6L39z8LIOPh/dnV58i92KmdceEHE8W0lrECPOKhN4hW8Lx+0fEvboNiiIkIENwEjLlo2kjAB89iuo6mLhUa+0v7CJFx9QM+0DZooU9HgLkBQp9NtdUwNk5+Yp2MrhiTT0Lp4h7Cw2IDaBDHwXRlev2e0it1wxFoOyWCV1EQDSz0/XGaSZ+5sANKjDqgBTFAAZLfma0RauZeXLvS7sVJ6Jxdg5Rh3VW20HVpdYWDBGeP8mLBB8SiOxkH8i2D2h6XQKdUsA7OOBti3h7kVvRNTG6rF1/RQS3Uk6GKVh//1UFj4yIO5sCaWCPiWQiJlZfwO9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcAnCT4w3/469ATGI3dKyZV++xHVHdQ07/8PBksOuqc=;
 b=LS49J9MaE1ueTd7fNkq/dNzZ4qZUP2p0y+JXSEe6eljmZ6KH7tb4yepgIpBSZYatu4WbY4Fvv2dPwvENSeSBOH1mqAmrxPf+I0oDUK6fg9YA9fVf7JUSVwHpVLfPgbpdVwAyD4mN/VPWROFAtHBBSI482xGAgNODx6q72EObrCo=
Received: from BYAPR01CA0049.prod.exchangelabs.com (2603:10b6:a03:94::26) by
 DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Thu, 9 Oct 2025 20:55:55 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::d5) by BYAPR01CA0049.outlook.office365.com
 (2603:10b6:a03:94::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Thu, 9
 Oct 2025 20:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 20:55:53 +0000
Received: from [10.236.184.171] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 13:55:52 -0700
Message-ID: <7a3d3249-ee08-4fe0-a016-829ece6f7b8e@amd.com>
Date: Thu, 9 Oct 2025 15:55:51 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v19 11/22] cxl: Define a driver interface for HPA free
 space enumeration
To: <alejandro.lucero-palau@amd.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 382d83b2-abd9-49ba-1ef2-08de07763c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0tvNVZqby93Q2NDRHdrM0lQRDRCaS8zTkdlQVRBa0g3eUhXQ2VuWVBwKzJJ?=
 =?utf-8?B?R3pYbWNIaG1PS3dmQnQyVFluWnBCTFFGWUVicXR2bkRKd1FkWS9lelN3QUJV?=
 =?utf-8?B?QUMzTldTajBsZ2dwMjJIZTlZWmUxNUN2VTNuai9RK0VSbE4xU3M1RXlMMUpx?=
 =?utf-8?B?Nk9xd3NkSURNUmx2VGJmdlRJYWJ3bldPaTZuY2l3aEJqVTBBMHR6RmZkUjN0?=
 =?utf-8?B?R2xCbFJqNWkvZTF2cWxuQ2xnMHF1QWYzdy9LUkRrc3lKUVExaVJ0aDAxWXdJ?=
 =?utf-8?B?eGlOMi9PQ1R4cUMzQjB4cjRmWDFENFVOYVl5R2ZZU1BkK1E0VVd2Y3g3dU05?=
 =?utf-8?B?RkYreUVSZ0U2ZDNmSHJMZDlxczhIaEZvdVNxcDJrd1NxbE45VVhXTmtCZ3pa?=
 =?utf-8?B?OUFzRnBjeU1TNHBNOTd5MTUybVNBUDBOcC9RZ3IxeklURFRSZlBHanRXbDNx?=
 =?utf-8?B?SlRzSFpLeERCMlpFdTRlWVd4aW1BQ1lZQTcycnp3WkppaXREMVpXTlpoZjN2?=
 =?utf-8?B?Y1JJeDdjWU1XN3QrSXcxQnpFcDYwUGJXdTZUOEtVMXYxOThhWW9yU1NId1Az?=
 =?utf-8?B?UHYxcU1iekhyeGFDdENQaldjRkx6WjJQbXgzU0U5d2dHNFN4MEFFZmE5dVRn?=
 =?utf-8?B?emoyRU4xYTFDU0ZML0ZUdjM1aXN3SnNYMFZlaGRKaEtjanBlZzVINi8vSCtC?=
 =?utf-8?B?M09OUlV5U3hRTmZkS2ZkTHlNMk9tNXpaQ1J2UVVPWCtCcEg0VzN4d1IrOTht?=
 =?utf-8?B?clNJeEg5dzF5SFZmUmZqTDJUSk9qalFzWVdyUE9rODZ4Ny82STk1VlRvdis3?=
 =?utf-8?B?MGI1aXNZL0Z0U0o5V0VtOUgrNUlVdllWQmx5VkV1MnlHVWxNY2R4M21FK1Vj?=
 =?utf-8?B?ak1JWDlNN2lOSFliV0plTEZmdUNoM0dXVFZRQ2RIUHFrRVJITUtvYmRXOTEy?=
 =?utf-8?B?RXF6Vk1OcXc3NzkrRlowaG5OY3dDbWprM01TWDMvaVZpdWRqQ240ZkN2Q2Ft?=
 =?utf-8?B?UGE2MUt0dFRZd3lGMlY1b0V1OHYrcjdrTU5SSEJxdXJmNEN0Y2hrekQxTGpL?=
 =?utf-8?B?c1I1dGcxd1hobmlWYWdyeENGWkNvNUVsTGQzTEo2UHZOenZGN3lHUUFuTWgy?=
 =?utf-8?B?UFJuMDNDcG9jZUdMUmVjR2lTd3VZdUc4ZkExWWxoaGpJZEQ2OTYrWC9sRlIy?=
 =?utf-8?B?bGNIY2pQbG1oNEpCaEJhYXVCd2JsaGxCS2NOdUFTMTJtUXY1YzhnNlo2R3Bk?=
 =?utf-8?B?ODVwWUQ3QllvL0paT3FKNUVkOFBIbGh4dHM1ZHJxMGhuWGhjR0VBOXpxc0N4?=
 =?utf-8?B?SDB3K2cxUVEzbEY4bHhrMmVqWVJHdHRldXgrNUlWZkJwRkhOMHA2TkdmSi9u?=
 =?utf-8?B?MmhZYk9SWjBJN1NHNkVicGNpWGhJbEtDWWg4RmJybFJLVU8zeGVTSExpdlRp?=
 =?utf-8?B?QkNQbVo5dU05N2RTMUMwTVozOTN3YWFOeTlWbzBLUkIydnJnNENETGFNckIv?=
 =?utf-8?B?MVhqS283NElTWWZUN3NMMHJ5Y3dFYm9wK3JJaFBMNSt6b3Q5WUZkeENEMTZy?=
 =?utf-8?B?eFFpZjNUc3M1eXlmeGhKbVhOSDFSdVltaEJGd0g5aC9xdHNTZnVxeDBBYllt?=
 =?utf-8?B?cFg5UXo2V1ZuelhJajFsSUl1MHJuSEYwMVBzcWtuWTk1Q2JiRlhDai9Ncm9n?=
 =?utf-8?B?eHV2b1NYOW1oa0xjTEM1d1RuZkxLODBjbG85UWpGRFhZbFdJYnBJaThCN2Vn?=
 =?utf-8?B?TnVpdHd5UFk5N05qQTFpUW1xa2d1enQ3ci91bHBqRk45R0J1ei9ick5wMTFj?=
 =?utf-8?B?QUNhWmx6T3JpVXA5enJvY2JzV1FhZTdxUFg1ZFBFNDdJWEdFcEwxcUE1TkhK?=
 =?utf-8?B?MkhES0krdFkyZ1VGdThEb2YzNEk5ZkNVWG1tcGFLeU1XbjNHT0tOQmpMaFZm?=
 =?utf-8?B?RzhybVJ2d2FmU0VFYWF0Tnc5cWthSHYxRmFsREs2eW1BQ2Qxd2ROL2lFTElp?=
 =?utf-8?B?SUpVYzQzUGY4TXpNdThGb2VWcVNPSktTL3hqTU56Y3V5S01scGpsUFVZUVNY?=
 =?utf-8?Q?W0jMmM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 20:55:53.4287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 382d83b2-abd9-49ba-1ef2-08de07763c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773

On 10/6/2025 5:01 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from Device Physical Address
> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
> determining how much DPA to allocate the amount of available HPA must be
> determined. Also, not all HPA is created equal, some HPA targets RAM, some
> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
> and some is HDM-H (host-only).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Hey Alejandro,

I've been testing this on my setup and noticed a few issues when BIOS sets up the HDM decoders. It came down to 2 issues:
	1) Enabling "Specific Purpose Memory" added a Soft Reserve resource below the CXL window resource and broke
	this patch (more below)
	2) The endpoint decoder was already set up which broke DPA allocation and then CXL region creation (see my response
	to patch 18/22 for fix and explanation)

The fix I did for 1 is a bit hacky but it's essentially checking none of the resources below the CXL window are onlined as
system memory. It's roughly equivalent to what's being done in the CXL_PARTMODE_RAM case of cxl_region_probe(), but
I'm restricting the resources to "Soft Reserved" to be safe.

The diff for 2 is pretty big. If you don't want to take it at this point I can send it as a follow up. In that case I'd definitely
add that auto regions won't work in at least the cover letter (and in the description of 18/22 as well?).

---

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index acaca64764bf..2d60131edff3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -784,6 +784,19 @@ static int find_max_hpa(struct device *dev, void *data)
        lockdep_assert_held_read(&cxl_rwsem.region);
        res = cxlrd->res->child;

+       /*
+        * BIOS may have marked the CXL window as soft reserved. Make sure it's
+        * free to use.
+        */
+       while (res && resource_size(res) == resource_size(cxlrd->res)) {
+               if ((res->flags & IORESOURCE_BUSY) ||
+                   (res->flags & IORESOURCE_SYSRAM) ||
+                   strcmp(res->name, "Soft Reserved") != 0)
+                       return 0;
+
+               res = res->child;
+       }
+
        /* With no resource child the whole parent resource is available */
        if (!res)
                max = resource_size(cxlrd->res);

