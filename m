Return-Path: <netdev+bounces-174014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E92A5D063
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BCD3BA095
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692F52641FE;
	Tue, 11 Mar 2025 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qc/fA8Ro"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F72620F9;
	Tue, 11 Mar 2025 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723588; cv=fail; b=CYl8XZ4TaAy/YAK6XhjMAHf85JriGnu7N5grGPRzGg7E7280Efbq5vPu7PhJ0XLYPPfQxAPR1z9tAjeqlu+QFiaP0k5PUMKEFtt1LYSA09H/XJM4K12ExkhvaRYEY/qiJTs4cOpGYP/WuDpFaUJz8GcbEYWJ5+oprABns/Ucwvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723588; c=relaxed/simple;
	bh=WQEiZLpu+l3gy2kwYyhIg0HWKKbGrdYgpbvulVX/L18=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=rtsWAucC760qiyQ3Choc29NbphnzWOuuSX1VX9Q1qya4/c2781V0VhKv62vnoF/A0YgSmGax4GzGFMb8LQMByPcfNAkqU2FFKH3rDmbSqBksLkzEQ6/keFslC9V2K3JC1QHQq6Vsh1RIFrCCHUl6Rea3azOE2w1AGARwabiXSNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qc/fA8Ro; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i44BZRb8wrMMJHC/6jHmtpA+/xABgfrEeEN3NnQXv4++Z5M7M+hMbX5kV4rewI8MJGjFSP+knBRlSyWZ8GvB/PyfTf5lxiFxPWuDX8koXJaiioBrJu1zHftziLOFgBMdH44I06dbziO8C2xaWnWYPTECcctrbULaYnPHjQwP0GbibUGGsLaha1QA5jNiE+vWctS6V9EF0i5jr42lDHD40QhS1kFmNBxKrdWI44I4Z6lQhi1D/382XHblulAGOhrgoLLsy5pr50xA85H53Y1xlrpTFWcxopec8ESWET0l0uVyp2fjSqSax35BwzfBm8AJWJnEjPAPZ/Py3l088qvnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPtXZj2KozIHUecDweJuzdFC+tUtLSls0vtJom4FGg4=;
 b=kxiP4dBywOPRlGJMyaDkdx7RDUgP7TeG7ubq9erdiHnQqNAKBMVub8h3UTu3yBr6kbdGcpH1cE/g9erLsP5sxjX0Li/Rn6XkluEEYiXBjX2dpUddUHrYJH1qYghgQjmSGdytFSB3AcnvfmrIO0FWubAocd2EizRgSpsObkErvhNIwoJopl0b0uDVpaRKB6g4YSYT5HKwjCR9BLEw5TtU5WJpUE7PGzjfaKT7ttaPjNFOUmT/zwb+X8XIwFJlhq+XI0vI8Vh0khvTxR7+iEPd/tNBRTgtx9zarm95HMsRqTTN9QFFPzuFCnmAgWfFDNlxR8BREyhDA3sruTpKj4tZYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPtXZj2KozIHUecDweJuzdFC+tUtLSls0vtJom4FGg4=;
 b=qc/fA8Ro3fIzQocQeKWEgR8sARPR5AUDRg2WwpskuwHrYEEezcnI/myyOB7x6mLbDiUCq6qzMDoxUKNFtdku3fkYJr6cQ0z2mS8TrlO8u28t9yDb8NppKNJjSbN3LvThYjsfwu9tP9hphaxy/Adtxm1qeSCE+DySKod7Er3GL/Y=
Received: from MN0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::31)
 by DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:23 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::66) by MN0P220CA0002.outlook.office365.com
 (2603:10b6:208:52e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 20:06:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:22 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:20 -0500
Message-ID: <e100afd1-74de-40f8-9d0b-0951db6096c5@amd.com>
Date: Tue, 11 Mar 2025 15:06:20 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 15/23] cxl: make region type based on endpoint type
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-16-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-16-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fccfb9e-f1e7-46a5-8efa-08dd60d83247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEVVNnFaTGJjc0I3RmllUnd1RFdQU2xlMEJZeVNSd01wUENmdVVVc0ZsWjhP?=
 =?utf-8?B?WW5oSUJzcmcyV0xZSW92WUhwZEJFdFhMcVFqLzJYcDZaall1SS9KeUhqSDY5?=
 =?utf-8?B?djJVYTJRUE10UVZkdjZlZDVIcnR2enhJdlVOd1R4VUwvRWt2dXVVeHRyMERx?=
 =?utf-8?B?bm52cm9HOGRhT2txaTUxMHlpZTRvSng0SUJCUFk0ZEZscG1sbktwRUViOTlU?=
 =?utf-8?B?YTBGYzR6MVZ4VUI2OFRocVUrVFVjeExkWGpnVUhQMmwxN3pPL3RodkxoRkM1?=
 =?utf-8?B?STFVanNLdW5mZE55eWhsNGhSWTBTWUVKMzhMV3M4OGVmZEg5TWVJNzM0UU5G?=
 =?utf-8?B?cXNOV3RraUswSms1c2RDMmZPRnpxeWxZKyt0K2FrdVd6ZnBsdFFBcUN0eGNy?=
 =?utf-8?B?SjJ3Skd5OElLdnppeDhidVhVTnNtMk9KVEdtRlkyUzJlaFd0cSthaFI1dDEz?=
 =?utf-8?B?azF0d1RkdGpxQ3B5dFo4M1RBUGI5bUFRTmZaZFk0M1lqZDVtVFVYRGd2WnQy?=
 =?utf-8?B?aSt4Y0hSNks3N2lKR1NoSmJDcS9JR1E4ZldMdlFsVUV6VVY5bVVtaXBPNklr?=
 =?utf-8?B?cGo1L2RQRFFMM3dXTDBSMklSZHZobGpqTDc0UjNjbDFFa2sycUNmNmYzWTFV?=
 =?utf-8?B?cWVXa0NGSGpSYWppOEl3bEIxT09sL0g3VFJlYitjMTFFU216Z1UxV0h6K1l0?=
 =?utf-8?B?c3Y0VmhwMHZ3ZU9Uc09qNkd1UE1OaStORHA0UWphYkZBUWRrUW52RUEyWHJR?=
 =?utf-8?B?OW5YTjVGSGhxL3dWcjg5TGhhYk4rcHRaWk96WFRXUURuT29ZYytIZFJXM2Zh?=
 =?utf-8?B?RFJNVnZyU3BhblhXV2FZZkYrWjYvSUN2NUptMHpYcExVbkVNRDRhOHFDTnhH?=
 =?utf-8?B?WXpYeFhLeWZZbU83VUljUXE1THNjakFwdUxSRlIzUmY5c2RVUnd1dDEvMjAy?=
 =?utf-8?B?K0k5eXFzcW9lK2FjbGVoOU9JZkFKcUhndE1ZTmxwRmJWSlNnQzcrU3o5WTZ4?=
 =?utf-8?B?dzMvUy9waGVTZVNyUFo2L3cwUzJ6RFZMb0pmOGF4aTJnMGxLS2FrZXZxY3Rn?=
 =?utf-8?B?dDN1Y1paVnVJRHFTOHJVN1VQRkpPWWhNU1NDUUlZcXZMdGFDTldJWERxT0M0?=
 =?utf-8?B?dlNWUWtvbVlkakQxNWw5U1hyOUQzSUptY0NzUEtRbjFEUnFQd2RXWVVZNXRr?=
 =?utf-8?B?cGtUZXdYZEQxQmNWOHZrdE1qSUo3cWJ5ZnpMWVNBeHVEeU45b0lGNHhkeHhp?=
 =?utf-8?B?MnIrYllINklONVhqRG41aEFJVTVLKzkrMXczZUludk0xZ0NPUy9lZlAzTEpZ?=
 =?utf-8?B?Q2ZhRXo5Y1pYdk5pZUwzZmRMTnRudmZDSC9uTm5aTHF3ZlFBMTg5N0xoYzZy?=
 =?utf-8?B?d0sveVRCU1pNWDRBcmpCSUM0NHRCc0tJSVFMM0lSMExNQlFuL09zMUVsa1dV?=
 =?utf-8?B?d3A3ZzVtdlNhOHA4Wm85eklVRkJ2ejh3ZlBlRWlFMzAyY2lkOFFmK1daS0R0?=
 =?utf-8?B?T24zTzV4SWNXc0ZFRjd3K215MnBIcnNGVW1lLzREaTZYSjNqMXJqbWZDYW41?=
 =?utf-8?B?TFBoVCthcjh3WjRmMVQycW80SU5tK0Y5MHRzYlpRMEVJakRzRDFma0lKZVYw?=
 =?utf-8?B?Y3RnMGNrSUMwT1MveVY2eWs1aUgwUGc1bXk5NTdkUTMvbTRFdzhnUzlGemg3?=
 =?utf-8?B?OTQzVi92TUlZdDZOWVF5d1ZtWEdHOTVhVThDU2N3YXNVRUNTb2RJRk5RUEJX?=
 =?utf-8?B?cjB4eFQyOWpSR09aOU92eTJYTTkwWVZWR2tRRDRMdVc1dGxkOEJ3MXNON0pZ?=
 =?utf-8?B?QXZ5T2wzdnBUeHpDSXhRZVRyUVhKWm9VSGVYSW5kekJBSmtodzlKaXYzdkxT?=
 =?utf-8?B?V3FpNVRIUE1zM2NST0pmclpuc3drQjMwbFNhSzVLSGN6ZDRnNnRZd09Sa1N1?=
 =?utf-8?B?RFZZOC9kWWJEdzB4blpHMUQvLzFkdkZvYUJqWGZMaW41Z3JnQWxQNTZCM21v?=
 =?utf-8?Q?yCtNSQyrqBYPBo25Cj109UgzYAzZb8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:22.8762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fccfb9e-f1e7-46a5-8efa-08dd60d83247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current code is expecting Type3 or CXL_DECODER_HOSTONLYMEM devices only.
> Support for Type2 implies region type needs to be based on the endpoint
> type instead.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

