Return-Path: <netdev+bounces-146857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D38F29D6507
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 21:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946AB28143C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C6186298;
	Fri, 22 Nov 2024 20:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O4dLdSYy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C911632DC;
	Fri, 22 Nov 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732308351; cv=fail; b=MJup7rx1jKkfPE/N5NgM2VkSBREa9/YQacrigEEL7Y7VQAJkFJC8I3pOint6NCQ3Y8wKr35/AmDB8Oj/UzhluqSbptzaZpnyPeY8LoY98o3SRwN79V3Yld4zIf4orSDd/ENhCOhFiBpQ4eMwn4Mj/bcA/Wl9KFR5O0uRFc905Kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732308351; c=relaxed/simple;
	bh=pmRROtBFycyIp788ekj/82VmPp2jS1KFJhvvYOaJxXE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=eb96WvfYZOFyBIyGkglpPG3CNIFbRtIEEp/gLROv3sigPhC+nk3Qbh3YKrSHywD/efDU+edAMGE68/NGCv210OEFO6T280zusKKB12nD2PpL+4r2TdgcbelnRKYbPpTXfUIMAGVcnwPeZECArqxDZb512MqoN6j/dSOfp+rr4WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O4dLdSYy; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YreJZrpCRUSsdgLIsMwQKdA5vG5m+/dMPVUG44uJOxca7y6tH8biNHXNTIc7U/G2Lkj3fH1O5rS3SVsjw1HDRyKFn9lUAHIU/SouYgok6DmjrtEhZlMGWvmnG8DZYs7+11GMNemHTvmabl+9BjIa6s03q8uEPVdlKkwjkQcbCFe4bEjFqy1NboD1dDA5sMsk428RYuXek/xEfifHk4JmjlO26Vt3rnjcFh7lCupzI2IKUTz6G63jRtFO7k/8VKUdT1gLbx/NG9lIcLycO0xYYwgPyQ/0+0HnAGK4YivoYZhiQhnvr2myy3QfbkxrksJlDD8FH+pIVATfhEOz2q4DIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRfAXThd3qVd9VGfR5KL1b+gXBpACQtP3HFGAX5VCzs=;
 b=huTNuUKh7nJ7rxxGwVL9mimJNZrW7wVc6IXBXQkb/Empj2fLk2L3K44ojWr5COOLdZT24OZQ0Q/g7U5NCszJ/DL+vp0W6zF22bDoltZqSImBHZJNnfu8fk+g3BiREKiBBSQ9hYQOWW2Utwnl8RtuanXa9jU91W25PnTrLyqdujh6aUHx4jZZpQ2EfMk+kUu5RvrrbQeiGOXW+4+LENzkqIKO31s7v7KWeWrVTFfQCfgIKjN3FglNukhbikrVrIKNjeLR9sH1HV9ZPDJhvJtOw6qbF16KGzTygzqSX15FUHEwNfAWq44vul73VYJPkQNp3H+NNHAWwX86yc2gONPSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRfAXThd3qVd9VGfR5KL1b+gXBpACQtP3HFGAX5VCzs=;
 b=O4dLdSYynBhc+7gjKioZFtp0Ma+t7tkOv853rDn94MmnJlXX7MnQ+xqJfWOv5DSMalHjHxiekckbtkyi/vBTKZ/tvDAPs5ZVSuvgaAzpdnsd8Tgb+NDFKPHQs1dcIIafkNFhpOeUjqLmjnTr2IM2hi761WCcV1jrr6b+2rzwDow=
Received: from BN9PR03CA0677.namprd03.prod.outlook.com (2603:10b6:408:10e::22)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 20:45:45 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:408:10e:cafe::ac) by BN9PR03CA0677.outlook.office365.com
 (2603:10b6:408:10e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 20:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 20:45:44 +0000
Received: from [10.254.94.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 14:45:43 -0600
Message-ID: <a633d595-88e0-4c7b-95d9-31dda88f712e@amd.com>
Date: Fri, 22 Nov 2024 14:45:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v5 18/27] sfc: get endpoint decoder
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-19-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20241118164434.7551-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f45d47-44e3-4218-2f59-08dd0b36a317
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDRPUzh5Y2RPa09zMStXY3lsd2c5cmhRWDF4QTRsS3g3NGtER2praG9NSEo1?=
 =?utf-8?B?akFlOFFCUzExWDV2eE01S2d4LytYU0VKbnNsRHptTzR2M0g1VFNyeHNRQzls?=
 =?utf-8?B?c1VaU3ZIQlJoK013d0JnbFJESmNOYXpHWk1JbkQvV0RUZGk2WDhvUDI4d3pw?=
 =?utf-8?B?NGZ3MU8zSFNkcXJJSXdOOG9YUG5OU0pISmdVQXRTZ3hXYXZsSFFhd2RLYml4?=
 =?utf-8?B?NDJrb3BYdkg0TmlIcDN3MnlzUURaSXFBMEpNaUhlU0Q1Q2d3NHprajRUY3Uz?=
 =?utf-8?B?VDlhZG9rWnk5SVVLSytiOCtLempadE1KWDliZGFlZVQ2QnB0ZUFNd3JlNUYz?=
 =?utf-8?B?WHROaERMYkxla1VuQVhXL2R0OUN2SE4rUUk0QzUxNVJlaFVjanF0VkEzdm50?=
 =?utf-8?B?bXFMVjBFaDViRnZlRnAxcXJWcHdUbDlFeW5BcU50dUtvL2I1YkF2M2tzMmJ1?=
 =?utf-8?B?S0xWeXRuM1VMOW05QTl0c0s3S2diUy9wWkErN0NLZlhnV1Q3MEZZWjJJbWwr?=
 =?utf-8?B?dFFyYzF3eWw1NkZqcnhEYWlDZ3p6dWtzYjZ2UFdsdnkxU2U0UWcxR2RqTXdO?=
 =?utf-8?B?UGJhUjN5MEMvbUtlYmcwamtEZVFYc2NNcTNoczlWRStZS3d5NnNjVjFzczZH?=
 =?utf-8?B?ckpMWmRKVk1GUGFFUUxybVl1OVFTcTdYWm44Q2s3NFBEVmpoTnRuTkJFM3Js?=
 =?utf-8?B?M3VYOXF3RG1BK2R4RWpaeGc2ZlZLMDgzc1g3S0FtTmV0WGcrcDUrOHVWNElr?=
 =?utf-8?B?RkFoUlZnSllkUVYxd1B3aTNiZ2xYN0hDOFF2NHNyYW1uaXhKdjlYMFZSaFNW?=
 =?utf-8?B?cG9QaHYzT09mVGpla1c3cVpxbVUybENGcmJ4Q1VoZDVGRFhlaWVES0xFc25r?=
 =?utf-8?B?cDR6WGpCNkt3UUVaczZDQmY2d3pveVNJaGp4K2w5WHQ2NmM5NjNBMVJFR2dE?=
 =?utf-8?B?QVAwRGFHSm1MZWd6ZVA1MGVtSzY0MW9EOFo2cCsvZ2dBQWE2Y0orNldtTGFq?=
 =?utf-8?B?bjF5NWdQZ0hYOXZPVG9wZTJlUlpLQ1ZNaTdrcmxHdkJXcS9mTHdXelhxaVhx?=
 =?utf-8?B?bEcvSG9kNlZQYis2a3F6RW5WTCsyOHJBK3dlRk4vd0JWK0FhbTB6azVBSmN2?=
 =?utf-8?B?djZlcmQzb3M4clhoOGVsdGUvUkluUlB4c0w4ejhpNExIWG9EU2ZMTGlNczFl?=
 =?utf-8?B?WVp5cEhhL1dEME5mU0d2YUxla3dBN3BPSDVuRk1IWStqNUhLTHRHUzUxMWY5?=
 =?utf-8?B?L25VcjBtaExNK0dMK3RoVzBseXRPaHhMU2VwZDBnclE3WUNyc3V0eEhpTVJW?=
 =?utf-8?B?Nzk2NFc0b05md0lJTE1KV3h0NmQvRzY2UGhRanNqY1NRNzhwUkMvMWZ0N3pV?=
 =?utf-8?B?T1pkUndoaU9ZZzVyb0xlcXpFNTZtSFBPNW9SVnoydHc2SXdRZmltSmk4eHdU?=
 =?utf-8?B?cEIyL3FzNGRSQmZzWnJzb2d2cmFqMmNFenVMMGFsYkhOaExma0ZGZFpYa2dR?=
 =?utf-8?B?Y3ltRGhWaE1XSnNDRnNITkdWd1lQY25CdGdONWVOcGNmS3Q1azQ3ZTJEczdT?=
 =?utf-8?B?VGF4VWdVb3FkTStrM21PM2RzUGovOC84OWVkRjhpWXRmTHZ6OWkyWU1ldEt3?=
 =?utf-8?B?cER4ejl0NmlLMHVadklvQjFYSTNRSys5aGpoZzJiSUgwTjdVZElsM2hpSEg3?=
 =?utf-8?B?RjhydWM2TDhzYnN3dldOdzh3OHZUd0w5bHdtVHdBQk9CQ1Q1OWNiR0hwYWVm?=
 =?utf-8?B?QnQ5R21tbFZNVzdCRXVhOEhGd3NybE5Ma3didlRPSjhMWTVIQllJRHhYZk9z?=
 =?utf-8?B?Nnk3dnRXOU0zUDdIVTFoZVJpNzBhNTRIRnY1TDFUZXhpbGNVYnc1RDJ3QWVL?=
 =?utf-8?B?bjB4TnA4c3lSdFdxcjdYV0NaRWFzYk9BZENXWWl1N0RqaUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 20:45:44.8042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f45d47-44e3-4218-2f59-08dd0b36a317
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Use cxl api for getting DPA (Device Physical Address) to use through an
> endpoint decoder.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 048500492371..85d9632f497a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -120,6 +120,14 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err3;
>  	}
>  
> +	cxl->cxled = cxl_request_dpa(cxl->cxlmd, true, EFX_CTPIO_BUFFER_SIZE,
> +				     EFX_CTPIO_BUFFER_SIZE);
> +	if (!cxl->cxled || IS_ERR(cxl->cxled)) {

I'm 99% sure you can replace this with IS_ERR_OR_NULL(cxl->cxled).

> +		pci_err(pci_dev, "CXL accel request DPA failed");
> +		rc = PTR_ERR(cxl->cxlrd);
> +		goto err3;
> +	}
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -137,6 +145,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
>  	if (probe_data->cxl) {
> +		cxl_dpa_free(probe_data->cxl->cxled);
>  		cxl_release_resource(probe_data->cxl->cxlds, CXL_RES_RAM);
>  		kfree(probe_data->cxl->cxlds);
>  		kfree(probe_data->cxl);


