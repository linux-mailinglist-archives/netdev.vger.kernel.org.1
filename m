Return-Path: <netdev+bounces-174011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC86A5D05E
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F577188A8C3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70962641CD;
	Tue, 11 Mar 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BcBD/CLo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E501E833F;
	Tue, 11 Mar 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723565; cv=fail; b=PpQoHoghza2Q9zvHQgWGPrPovazIsBlGJC1M87HIFR1c78fAoutk4wgx3FW+9nFeTZswSKumi4SWGNKJZVD05aBleiUQPorhnLhw+EUX7+LXZnAEpac8okzzoXsXcADuIEhvU3QbgifTd3eGxF1HNjHd4PGJzMptEpu6SODgsNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723565; c=relaxed/simple;
	bh=rIfJa1dcsQFSFnWA0mmfy1KMQR79n0GNyt2kXpq3F9g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=W4Loh9NlUdOUVoerTT5Po1C+8gtLUeLgf3i84BCBfRvD6+pmZ8YPu6oGZ18PCXNn7mQL3ppa3SvjmS1htoW+Dmu+WgL9yXz0XZ7zgERinOM8kI/C1s+fidnUQWxbWYDdvxEWJoRR6e0HRqwoBQxSiPv3ewIl7z1hfuFPiQRO7JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BcBD/CLo; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiZljsDdh0+9fIHxWPjpFYNS3JCzkvxkr7u8nExJe9nUDlc4g8iZTuH3vgvOkpJ7A8BFnZ4k3F2WDNR93tC0ISGn1/7IPsp97lybstE8694pW1HqDxAYoinuWU9dQwbGaWlAlkKkHffxhNYtFo9GfUR06P8wdTawQ6tDEahlY8HZPpLtxKR/UL7crPZKwQ887L0jgy1aqXaoWI9vR180cmQA1pG2ptgk7BzIAupJdjvMY+NsWlR3Juw7b+zKsU1CmEMJ4I4rE1KlO67PdaNix7bUP/d8nq/s/heUsYnwUSjQdLOol4ZVbahIFHCwT58tjroioiAJSTkOfbYGBpPOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIqOPw+lYEkC0/U5WbkpRsg6ALop2Afr5FiU2Lxzz2M=;
 b=gGwcvftAWrmlOeF9W1P8BKkcf6QFjUkUQgwLm1ceMkpYzheinCaWp9dGtZ5mVACFnRaQKQPrtS3tL9wJaqxHZCuJWNejKm3k43nhF278tYhLz3r+Q0/VrsQcmB8hmP0ruiZ+98taHAH49vobThSMmUiNd0npmcp7lmQILjqwtOn4YyCnQBtZoBKhiHYiMgdESf1rxaxziruwI1gsfheSLRbn9GIZxTKoNc0IKCCU2GtI+YGhN1NbcMsb7Fi+HiU48kwXJqehHBjo557xe7rwlh6MNycqBx7j5rY9SFYkejGVzW4GUPW93aTEUS7RAjiRB95kMmLm+GIwQwGKwK4I9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIqOPw+lYEkC0/U5WbkpRsg6ALop2Afr5FiU2Lxzz2M=;
 b=BcBD/CLoiS8RumJAOAwQj0UCllNNeUsuPgGUFPJ9GUzxSqA3ejwgTUgdZgu42BdlsdtnFYua0p4AaTZ7WHVxQoslKbUV98xnKEG7Ce7XLQZReNXZWdORBL61YMfV0gZ48oWLZ5HRvJkHW4FBcHKXZWSrbeEQEeN4jB9XnITlR08=
Received: from MN0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::25)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:01 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::18) by MN0P220CA0007.outlook.office365.com
 (2603:10b6:208:52e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Tue,
 11 Mar 2025 20:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:00 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:05:57 -0500
Message-ID: <6c473551-4415-4635-aa05-32739e864efb@amd.com>
Date: Tue, 11 Mar 2025 15:05:57 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 09/23] cxl: prepare memdev creation for type2
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2e63fd-0ed7-488b-8e7e-08dd60d82517
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm1lY01TYmZFTDBtdE9tY1FuRXdnQkRCdjgyZFVnVDVpc25kc3VHdWxweHFV?=
 =?utf-8?B?ME1FOUhOSXlrSWZYWWljSUh4VjVUWGdCWDhuWmpSZWtDRnNDUnIzb05KYmZw?=
 =?utf-8?B?L2x5SytpV1lCS3B4STJUakcxU3hVN1NHang0SEJZL2d0cEQ2SEJ4SW1zb3dS?=
 =?utf-8?B?S1Y1eWZqaTU2OHhrN1NrYjBWaG91NFlnbzRack8xSE8zVlZQN3BlRXpUclll?=
 =?utf-8?B?VDJHbnNlWnMvZVJSbjJaOTBMZDNFcDh4MVZMYm5VWUxnanpBR0U4MFBGTXBh?=
 =?utf-8?B?elNNUTFSTzZFL0VMc21SdlNzSFY3VVFEYWk1dWZpRWhqVHh2YXh5bG5jZGcx?=
 =?utf-8?B?ZEJhOTZ6MTNnZWFNbkFPaDN6dEFZSS9wNm1UR2ZMTXV0YkFSTDFna0ZUSk1W?=
 =?utf-8?B?cUV6Y2Foa2x1ZXIwWHJxS1VqbWhCVDlGVGdwQXdrVkU0eDhSVkRBbVErSXJx?=
 =?utf-8?B?UVFFV1pkbDlQaGJJRTVmUko4Vks2Ykw3OVVodEJGQmxxWnVHK0l3NzltUzZa?=
 =?utf-8?B?MmIrMURTUDNyWk9GRy9OL3lqN2wreEhuRmdBMnMzaHR3NHdIcUJXUGNIYlFW?=
 =?utf-8?B?SFhyZlQzS2RWOURZQWNkL0FEUzlWTExYTzI0dTlhYjdwRTYwTG1xSVpES3FY?=
 =?utf-8?B?Rk0yZ1FEUjRoTkVLejV6OG83U2RUMWZhMTFxZDhjOGFndk1OZHRNOVR5NUdZ?=
 =?utf-8?B?dFZrU1gwbnNVeU1uMU5TWjY4SU5Qa1pDL1JZVG81NTQwTFJNckNKWTlKMXl4?=
 =?utf-8?B?RWVvR21jUGJuWVlETXpRNFF0MnNSMmU2NURQdTlRNGFvNGhJYXFCdHV2QnRR?=
 =?utf-8?B?RTFoTVBVQ3F0dnVmN3pBRWtiK3VlUVU1bkR5QWdPYi9mUnE0Z2pqQWhKTDNr?=
 =?utf-8?B?ZnBZNTY2YXoyWERKZmhyM0tUOGhtdVlDQnBlUWo0aEg1T0I0dk1FYXZ1WU1v?=
 =?utf-8?B?dmc5SWs0Y1dsMW8xamVpMEQxU1hjUW1ESE1GK3FNNVdMSS9PQ0NhMVZ5QnhY?=
 =?utf-8?B?QllGa0lYVG5kSHJoTGNnbjVQd3lTdGk3VkdXemFPTkl1NFhRTS93NFFHemox?=
 =?utf-8?B?WW5GQzlSMFdEdTJpSTRTTWdhZXUyM3FtcmVMZ3U2TE5zTlpWbG0rb3NIb2dr?=
 =?utf-8?B?bnhnVG1rc2dZTFRIUEwwdGJJVzQ4TTVVTWV3aFZoWUZQaGg0d2F3cGhVWUYz?=
 =?utf-8?B?NzEvdk5zc2dyUEdnQnBsczJNSlRjU08waSt1UkpjaVQ0cVIwS2svY2Z1MzEy?=
 =?utf-8?B?d2pTaFBZWmFBRnBFdzVJSUs4M01SVDg5U3F1YmR2clpqYWtlSUlqbERKN0Nt?=
 =?utf-8?B?dUdKYVFCYWhjMldsemdDaVlFeHhFcFp2S3M3ME5LNG56RkY0VjlOOE0yRity?=
 =?utf-8?B?OUlGaXhkU2FBQmR3cmdlNU1KbzYySndVeTJJZGVaSFBVRHNrMWF4R1dySjg5?=
 =?utf-8?B?NEozWERWNDRmNDJETitlMk1LRmF0eStUSW1UcjBsRkkvcmEzWDBTcitJejRp?=
 =?utf-8?B?R0lKZkU3SzExWkh3VXYrWEUzOHdkNlZqMjFDbGZXSGdQUGVZandoR3V0TmQr?=
 =?utf-8?B?MHg5RlArSnNFSi9CZVNYK1lyMXUyZkZrRndadHd4Vi9JL0cwdlZPVTZ6WHFZ?=
 =?utf-8?B?ODNBTnhzcnUzTDNpZkIwSGp5RjkwNDJGRG5CVTduSDdYSisrN2RLcVIvTHl6?=
 =?utf-8?B?b1Rwa3B3cXJvQ3puMi9hWFJ0TU9HKytYWWhHNXhrTmo2dmM2aHpvWnRJdU0r?=
 =?utf-8?B?R2gyZlFUQ2lMSHZLNFQvMXM3ejVsK1ZBUjJVMzd6V3Vsd1NKYkNaaytFNTNM?=
 =?utf-8?B?aE4xMjMvaUJnaFZMR0pjeER5aFhPaHJYTENLRk1KUU9SY2JuRWZaVnZxTGJX?=
 =?utf-8?B?aGtlS29HR1BHU0VPbHo5TWt0TEwzSDYxenliY3VvS0dVZkNLTmxvNkxleVRr?=
 =?utf-8?B?V3liOHE3em9YQzlDMFRrTDV5clNXN0xKQUcyeFF1dVpTbVNvUmpYMzZ5R2N2?=
 =?utf-8?Q?FphCqAO7Slbf+n38JUGoCHMy2D2fJk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:00.7044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2e63fd-0ed7-488b-8e7e-08dd60d82517
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accesible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>


