Return-Path: <netdev+bounces-258365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G+9HLf+jGn4wgAAu9opvQ
	(envelope-from <netdev+bounces-258365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DC5128065
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 23:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B375E303748F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18E33032B;
	Wed, 11 Feb 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qih4jaeU"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF2337BBC;
	Wed, 11 Feb 2026 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847852; cv=fail; b=ZJ3x7GR5ONbvVsE/njYm9JTdrPxh1qZwrvIOO2tjQ1jfMOcireFo96Lme310p/If6/TNb6oz4PfLSn0itVRyPwSqC6EiNyH+Pp74jwOOS5ezjmQfBEnILKeBvwOiY5Co6dEGrg5VK3vcdZaO1PK7oTTFSurfUgcZn5zw3bAzszk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847852; c=relaxed/simple;
	bh=yO4+2VWr5lj9p9ej9DtWaJKHh06LYNPDVh0UkSjuPC0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=REcGOGQmqvKw+ryfO/ELRUL+5ML+bF/ZnEAotCQXTnnFLZoIEJHFabxRQR2E3sga2zL63JtNsdEml2MZinHwgDtQR3iAlSvU/r5Jkp06pNn/qbR2G+Mdwg0jg2NqJIUCF5uQpv3vi4n1PplMbVy+4F5RQpxktGumhEgBz19pPdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qih4jaeU; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJqOA6Lm8YISUxlFrDD2Xc83ofQuUy40Eyf7T2woSzubB8eN5z1LorQTg5Ml1+DgpcXFbbl2WfPO79P3KexiduPG02cxxHq1eJ5l6uuof4LdgSF6jikOOJEYOiEDV1fcuh5Xp8Mk+EVOJRLmi5FW9yERz0Rjz43KXVulc6CWQjLpIcqH++jbPRK2/+jVeYIBgOdZl19zHDL0rxpbYhks70yrfAwfeuv3xKwxkEOVI2/MMKu0ciUfjikYhT+3h95LR8oiMaja9L7OxWBLXanswOGnDWPqG2r89g/hs6y7Rosr6fZV75dKIC6gA352JOlqF3EpU+rcfzK3AT+f/M5p9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fR7u7spMAXMb+qqivC57vAntWlvArAlaXNL52wsp7k=;
 b=laUTe3iKQEY7HKDX5r0d2iKlbU0egTDNfI/dz6Sc8Rj+iXMNvjgHgJ8YDGWm6ik+9y27DLOqVlU1LPXG4r9LwAFlwMwOMXj0cJNxs/w/iEhuFS+Mwi15PQNbLgRX/bh4mPnHhfmvdDvaYOHLotkXilkJmqEw02KwVW62DvxR/6Y39jILv2UCzrPINW66zXvfTTuIZg9WVbayMa7G1ynt2t5md0+QkbiYKTanLrCqq2l5Dk/XLCdUyYm1U8WPyensgK/hDYJPHAooyyyY3XHKe/yv6RH3FZUo278t0YiDMBcRSoESWx0ZzUu0XlGEaWsrunJ3NkXYu1ydseCd0VgmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fR7u7spMAXMb+qqivC57vAntWlvArAlaXNL52wsp7k=;
 b=Qih4jaeUdpNBmeU91MZWSpKv0rcBrCX62Qyq1YRjtobtQP87cW3E1G1J8k4i/QjPgj5WWih/Wux8K4OLK+eQgdrtHORMl1IQu+z53SlsLeDNlS/USl0dj0hspvKdGzRo4s76Rnf1Asf/UXSfkhNmFWxjWfpMfluNLtEgbMvO8Uc=
Received: from MW4PR03CA0219.namprd03.prod.outlook.com (2603:10b6:303:b9::14)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 22:10:47 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::f) by MW4PR03CA0219.outlook.office365.com
 (2603:10b6:303:b9::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 22:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Wed, 11 Feb 2026 22:10:46 +0000
Received: from [10.31.203.44] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Feb
 2026 16:10:45 -0600
Message-ID: <e98da3a2-bb86-4dc2-81e1-7120c4268a07@amd.com>
Date: Wed, 11 Feb 2026 16:10:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v23 11/22] sfc: obtain decoder and region if committed by
 firmware
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
References: <20260201155438.2664640-1-alejandro.lucero-palau@amd.com>
 <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260201155438.2664640-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: 3619bd47-869f-407c-2f80-08de69ba6815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHlWZzdESExnZy9qWDFZMjNwUStJck1RdG9GdTU1M2lpQlZxak1STnhJWjJI?=
 =?utf-8?B?NC9GTC9GMGtGbEJQTGxxQ0huTnE1R0tZdjlVeHZiYWdYb3haTC9iMjM5UWZ6?=
 =?utf-8?B?dGg4NnFyODBUWWNQUFhDN3NHQmh0ajAyOGFwUFBCV0dKc2FDUkUwYTI0UTN4?=
 =?utf-8?B?RmJxdmxmOXphMWlDMkY4SXU4dHlEa284cVM1dnp0djZ4Yk54Q0d2dFRBVVVX?=
 =?utf-8?B?aDljRHVvRUlGakFVQXBPZnJvL0I4SjJnd1E1bHpWTzVJMlFTZWE0SVd5dWNh?=
 =?utf-8?B?M3FBUEtBV29DNThCSFUzNElHaXYvelVpNHRNR2Q4cTE3bHptVEVPQ1BDRDdF?=
 =?utf-8?B?NENUNVFRSU1XRDdOQVpnRlFSMHZid04rMklLUklqbFlDM3oxS29FMklVamtw?=
 =?utf-8?B?dkxtc2lQRGVKeVJ4enFGbzNxSk15NWdYeko4ZmFJSS8zNko5OFVjMnc4ZUdw?=
 =?utf-8?B?WnVjRW12MXVrUUcxdmtOSVdscWFaeUV5YVR4VmlkWnlFcWNNZXZkTkVQZ1Jk?=
 =?utf-8?B?aXFpRmJWdEJCZWRUMDlGSm1xS1dRc0VGNGUyWWczb1A2cFFzQ2xaWkhPUUlL?=
 =?utf-8?B?M3lZRHpsSmZKMXdZNDBiY0pwQjRjdWI2RXNUUGR4d1pJajhBcnZMRW5LS25S?=
 =?utf-8?B?OFA4YkE0d1BuaEFBOHVad2lUM0cxQ3l2cXNvV2h6cHRHSndkREVGeVNMZXJz?=
 =?utf-8?B?Mk12Y1h2UGZWRU1LMUlPMHdUd3MxL3pRcmFxd2VTYkRxRmhaNExDU0x2SmRz?=
 =?utf-8?B?UWQ1Njg1SDB6cHdnZWRBL3hIV3l1c3Y3bjNqMkZKMUNFeHlYeXVTZ0I4UVA0?=
 =?utf-8?B?VFBVeGlJWEM5WDlCcTBCTTJtTmtjUjdLQzYwcjR4aktBZitTR1h6RUxzYkdE?=
 =?utf-8?B?WkdjUGpZNmJrYTFwS3gvK0oydDkwMVBURU5UVlFOQWFQRjQxRk02SzdWV00z?=
 =?utf-8?B?Nm92VDRtMEdydUJkdEIwV1RyNlJZWGI2MnlVVzBoZzJ0NWxTZ1I0MlB6L0RZ?=
 =?utf-8?B?VWxleFN1OGJ1dlJCSENqT1NTRjhHM0VJWHp1SStQZStmYVpscHQ2TWRhM0JD?=
 =?utf-8?B?RGJoUlpIRktHSElneGRxaW14YWI4clJiSGY2czZyWlllRzB6QkZaL3padndn?=
 =?utf-8?B?MG5oUHhibUpjMVF4VWpuc21ZS1JPalZ2dldMSWlsb0VWSEVTeVVWRlFHQWlU?=
 =?utf-8?B?c3ZvUnJmME1rVkJOdDkvUDJxTU1zbEs2VjdvRG4wNm9rdkFucmxmbUMyello?=
 =?utf-8?B?eGV1M3VCa3lWQ05MaWZCTFVxY0lQK2wwUkRrdVd2V3B2WTRpcGlJMFNxNURx?=
 =?utf-8?B?c0kxQk1EK1dmYnJWVklyaWRPZFFVUXIwWW42Qk5pc01hMW5jUy9PcFNuRjFO?=
 =?utf-8?B?aTR1VDEwYkx4c1pYSTNKeHNLZ3FYYTJzRGFUcERPbVdPZ3VFaWY2SjRyMUQw?=
 =?utf-8?B?bGRrbDB5Wm1OdjB4dStXNHd1dXJ5UzB2M3FEUTdjSjhiK0U1cEYxK0lZMEdQ?=
 =?utf-8?B?b084SERpZWEzZy85T1hIQzNVbTNNQU1HRzNzanpIMHBWRklaOGdhQ1pRUVRZ?=
 =?utf-8?B?SWpMWldiaXgxblJuY0tsaXRvcklpSEZzNmtmcVkrWWRZR3cxZDBkSzZaNjBN?=
 =?utf-8?B?UUtBU2Exc2tFK1dSSmxOQ1EwejdjQ2lxTjI4dXBCd3AvQ1pLaWVJU1J6T2t3?=
 =?utf-8?B?M1FZWERnckxMV3pBYlVXN2F1WmlXc2o1dDZCaU1KZ3ZtdUJZM1VrV0M2QUZz?=
 =?utf-8?B?Q1VTZlo0YjhjTWI0cEwvMHdDOWNnQmNGT3NsemdvSFI1TDUzYjVsTm5NS2Uv?=
 =?utf-8?B?cG80ajloVitJdHFibW9jZit6R0ZZbkJEOXlKV1FKdlBDQ2E3WlFZKzdlakU1?=
 =?utf-8?B?L0VCdllWNjZqWXVDZzBac054TVkweURHcm5ubUI2WVJzV3psR2Erb3JQaXdm?=
 =?utf-8?B?TlhQTjNXRk1qb2tYLzNURGJ6VWozaE5lL1lhUGcwT3ozSHRqTzNkaXpsOXVE?=
 =?utf-8?B?cVVjQ1VSTWhzMGp5R29BUlpET0VLNDFUUDhiclJPNDZSTTNDU3FGZUVkcGJP?=
 =?utf-8?B?Z05zVFNseVpHQ1kySzBrWU9icHpuMjNiWDZ0NWNyb2Z5OFlsMVNBc3pEV256?=
 =?utf-8?B?WnRTVGFzTjQzUGl3NmhCVDlRd3FwWndVa1dmcU5kQTRRNTVWcGlaNkdpSk1G?=
 =?utf-8?B?UUEvNHl5d1Iyb2Q0ZHdDQ1ZPVnl3blY5ZXpHc0tiT1VTandUdll4UlhvVmgr?=
 =?utf-8?B?QjQ3cVlmSWFaY3Z3WTgyNE5LYm9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dTGnrEQ3cgjwlkI0TiMGHDuMo9tP+E4WDtUkAMX7G0fEWfxNP3jIzkMFuqlFVK7EA9qopyXxrPESZI/4+pIqABRr46+nhlqmhjw5/aGQOu64xyfc9+egPzPZc+pKCmPpcTTSMNY1d7yR5wnWjf4527IC3KCqBWz7YkRwO6o2c0ctqFBmbIm3cAXhrEMJD3Y6yu9PZ9SlXbLVWmNGQtnh/pwDa/YwmhLAjSK2tVvxiUhdGGB5O9Ig5SXXF9qzVa1I526uSBiYGL8oxDhfpHQJcgHbSbb4lrYRcTbFyV0NCAiIa8pk/jNU7YVsr1K4P1A9JM7cZc8EVP0QX0aZEaiGSDfVQuF30Zz85oswqjrFKcz1jDzX8gcOS6yD0w9Jb4tBPs1eWyT0l8CqDZHerB8hUDzlQTRmffI3h2HDgBMsITSEFbiw3k0TrxxvOhEXkjfF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 22:10:46.3460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3619bd47-869f-407c-2f80-08de69ba6815
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:mid,amd.com:dkim,amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.cheatham@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258365-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Queue-Id: E5DC5128065
X-Rspamd-Action: no action

On 2/1/2026 9:54 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index a77ef4783fcb..3536eccf1b2a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -90,13 +91,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> -	probe_data->cxl = cxl;
> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
> +	if (cxl->cxled) {
> +		if (!cxl->efx_region) {
> +			pci_err(pci_dev, "CXL found committed decoder without a region");
> +			return -ENODEV;
> +		}
> +		rc = cxl_get_region_range(cxl->efx_region, &range);

Missing an empty line above.

> +		if (rc) {
> +			pci_err(pci_dev,
> +				"CXL getting regions params from a committed decoder failed");
> +			return rc;
> +		}
> +
> +		cxl->ctpio_cxl = ioremap(range.start, range.end - range.start + 1);

Maybe use range_len() instead for the second parameter?

> +		if (!cxl->ctpio_cxl) {
> +			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +			return -ENOMEM;
> +		}
> +
> +		probe_data->cxl = cxl;
> +	}
>  
>  	return 0;
>  }
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +	cxl_unregister_region(probe_data->cxl->efx_region);
>  }
>  
>  MODULE_IMPORT_NS("CXL");


