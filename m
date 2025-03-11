Return-Path: <netdev+bounces-174015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82564A5D067
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C31189289C
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191AF2641C3;
	Tue, 11 Mar 2025 20:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZJpzrxR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B6E1EDA20;
	Tue, 11 Mar 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723594; cv=fail; b=neCbt7gbMz7m8Fu6j3jE9zwOsaFJHQHhHG79XChDbWKGEEMw2CJmoNY2uttqNuNSIAo0hZEzRg0HUFZrijwZH3WfZWuPXYaHEfbT/JvmtsZWk14ZSyeFNEXKphj3KcbonWMiox4dkfSX32TKZA4rP0RvbIMC13nO3Kaz9NfpWAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723594; c=relaxed/simple;
	bh=Gi6LMvWAHJwef6BO7XLpBS8n4BmLz2eAtJ5fxrqyj68=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=isgxUug71FrrgoAQq3vjIci/nYoy4Zrqj0Qf3cwp5l7xESzMbpQDYUbxAzaT5P1s/+680lfQJCUvZtARCaLeE6HY5gV5ggFY79Kv5HNfp9JRnqYsb0XUWXfAg6ebBEq7FK4Gdvl8yFBEIIw34Towj5NynCbXtqXqcWogcIwycZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZJpzrxR; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWL0yTOKjMMbWy39aExBlweufZ8wRxaWjWK3mj/GUIiDCQvjS2D6Jzs08EBn0IA9n0ZpdY0ppzLgMpWMBRoKGBA0Y3XwsFNgQhwJ2Xv+utkyEUTXAwijk1Y6jPBBSGyAlHuZuyi54O7pYs7nThCHtQbS/fpB1zWe1wK3akKd7mKobkaasbU9Z35IjslBWpI28kkumSumTa0zU1sYP0GUeFBl8XaJuD5ocgrJci6uR9FuINfDWtV9iT/eD1PgjZUQX2ddXbxkBfpH+Q+Kl5d0ruIZeCmaNPW96kfz7cm/ydA4R+bIVykEKez6/w59e/ykKBFow8KTiaA31MI1WBgg3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQ4aWs6uNYQsYjkReWRhUnrH7zcpcBn7bgvAZnW9RJE=;
 b=WWUR4zRPeZyyAg2m7ST62hNu/NcNPBlCseZOiAAlJIjs9xNqjq15gEdfqOgHbodsrJKGA7OzKO00VbY8vIH8jCfuYB69AJLhuy0z+D6sGFdFZr+R9dbfuu0KntIJDfNpl7mSReRFNbZom0ss7cYozvbNJ45i866ggFUVk9QWya/YI/NzEc237+6aSz3I710ztffFxiOasIGiMA8tRqleJHPuwT/71ClvlRjBaz+CPRdgkDSoY9QetVkKqG3NH+U9lvmDvuOI394vSaUzsw0naRGGFGU0RGe9qhp/Admtir23UlGpncPXYCAXDxBriaGwfKe/LWQlFGFXlYqhZzAGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQ4aWs6uNYQsYjkReWRhUnrH7zcpcBn7bgvAZnW9RJE=;
 b=dZJpzrxRx4gCrmC/4UDOY6aKAbEK7RuyJeK9YzobbOAJPMkSbhjOuitzl+QJZWKL3tk/YSxckVeuUMwu5APRnHIn5jMVddctrqFiZ+vSAeVAz4b5gGsvpG+oeyeCxb+RRpPpMf6qOt6vaIMJEJ+BpRZreVib2CYH2uG1w4cqE6o=
Received: from MN0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::26)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 20:06:29 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:52e:cafe::c7) by MN0P220CA0016.outlook.office365.com
 (2603:10b6:208:52e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 20:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 20:06:29 +0000
Received: from [10.236.184.9] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 15:06:27 -0500
Message-ID: <6eee0c18-962e-42da-a414-56ffb0954c4d@amd.com>
Date: Tue, 11 Mar 2025 15:06:27 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v11 16/23] cxl/region: factor out interleave ways setup
To: <alejandro.lucero-palau@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, <benjamin.cheatham@amd.com>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
 <20250310210340.3234884-17-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20250310210340.3234884-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: d273d6e0-eaaf-4bb5-ea55-08dd60d83630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2JkdVIvcHlqZDdkMW90NlRxN1ROeDJwbytJWUNMVmlZUEEvenNlVWxmaEpj?=
 =?utf-8?B?V2E4UjB2SXBGWFEyemRWaThzaTFvV24zOEN4N3RScjVkeTFDaUxJQ3JEbmww?=
 =?utf-8?B?NmtOL0N5SFBFNUtIdEZoTlhoTmlSeFR0QnlFM3pwSlZYZDR3eXBkaUVaL25P?=
 =?utf-8?B?L2dHVnRTZTU5NUhwQlRORklIL3VaTnpyU0pNcExvS3BuV0hjZFJYdU1BeWh2?=
 =?utf-8?B?L3VLTFVMVE5nbXErTjllZ09iQ1hYaXhTSXFUODhPOUZndkhSbHcyM1VZTmhp?=
 =?utf-8?B?eWlUdVZ4UFRzVWRjYnRwaFBoZ3RBc3BiSW9uUkFGeUdLT1hWdFB2VnY5QnBs?=
 =?utf-8?B?Znd5anAzSWxxR0o3SU56dzNhZWVtSGRBWVY5cFFubmx1NFdRemtuQnFhL050?=
 =?utf-8?B?dHlpZ1h5U3Y4UkE1WTI2cU9CcEtscmpsZTJnc0d0Rm5GZjhOZzJRZGVnUDNr?=
 =?utf-8?B?NXU2QkdJRmVNN3d2VDVWemg4RjRmRlk4K0gwVXNGdllnUkNteUlWRkhsRndr?=
 =?utf-8?B?YXg3NHc0OEk0Ri9Fb296TEFqYkpvMU9zcHFUYk04NHdYNmEyMi9pbzkwWDVx?=
 =?utf-8?B?bUdLWUNseUdudlVkTkJpL2NvdkM1UXdWRE9VWSttaXA4TGRLYWRxYVJGdGQr?=
 =?utf-8?B?NlgyWk5kZ2NiUUhUNXpLWGRlMExtZkJndTJSS2o3MXVrTm14V2NTTnZlZzRK?=
 =?utf-8?B?YXNZWlFEeFUzbFVQc0VBVUtnMUt1MHJ6U1l4SjhIUVB6dk5Hd0ZwSlRoODQx?=
 =?utf-8?B?WUpIUnZLbm5OYldPdElucERiYW91aU52bHU5YTkvMmxiRUg2d21wa0hHdmhY?=
 =?utf-8?B?U2FnUnRseHJyZXI3K2JFN0pMbTVHQzY0ajYwdy91czZQSmJ6YTVXQ29zVTdN?=
 =?utf-8?B?alh3UW5TVmdsNUVVd1FFb084UkZsajJEWTZiSFIxTHRTUzR3bHNFT2RCNjE0?=
 =?utf-8?B?dkZFcDlsT3MvU1cyTVRJQ1FBN0VJaDhJdVF4WU0rTEpFZnhLaHltOFdCRXpZ?=
 =?utf-8?B?Z3phK0RUTVVJMmNGZEh2b091cFRQZzlJRVVlbzJBYnlJa2xGaEF2UFN3RGky?=
 =?utf-8?B?bkdPeWNCazc1eDJCQ281K25YclFYU3NGZ0tsMmRkTk51WG83bjRKVzB2TzZC?=
 =?utf-8?B?YlFrUVZWT3hRYWtZajM3UVVDa1ora1NBZWtUNlFYcTRmOWs4T29xL096blkz?=
 =?utf-8?B?UTdZZWVoV3lDTCtIL21Nd2Q1ZHFxOTZIa1hUb0o5RDJDTnZwUkhqNFp6clc2?=
 =?utf-8?B?bXNUcHBxSkV6M3E5VFF5R2QweXZrYzIvdXdULzJvcU9NVGxId0kvb0grYytC?=
 =?utf-8?B?c0I0VFVRU09nSm50U1EvNmpaZEpSSXJJUEY5ZzlKMWhQSUE0bWtOdVN6Mmd2?=
 =?utf-8?B?bjgxSC9jMVBJMnBSMFUzWWEyRnNTYmY3Qy9HMUxRSHNYLzEvU1IxZGVZVHU0?=
 =?utf-8?B?cGdaNkZISzNicWhwSld2MVI3STlDZDR4RmhlTWVyQTkwMDYrR1hxVmpFdzJh?=
 =?utf-8?B?R29YL3VpbmJZSnhzRCt2TEI5WUcvRE9qKy9qa3cwQWczc1puT1NaV3BPampV?=
 =?utf-8?B?OGY3eHhUMUkyTzJOcU53cnFsazdLcVBFZlF4ZHF6bmVLU3JoTytIeWxGVFdY?=
 =?utf-8?B?cTNNS0I0dU9INkpXNWVxUWk3cEV2TEd6TjNBZVpNSXhFdWZGdlF3TFM5MXl1?=
 =?utf-8?B?Ykx3alVNSnp3UjRiRXJnZmNWNlZjMXlDcVVuUHhIQWE0NEUwckRnQ0h0VzFu?=
 =?utf-8?B?Ym5NZDRJWjNMM29XV0t2RVlDd1ZNQ0lCajVzWUNuVW5kQ2I2c1Y5U21vekVH?=
 =?utf-8?B?ZlIycE94RGo2M3BFSkljcys5N0p6OXBwc1dIc2dieXRlcWNOcXZpalY4SDBs?=
 =?utf-8?B?S2JLT1RNSFBYUG05Q3cwcFovUFdYTFl1am13U3J3QldSVU5peW9mZmxSc3RE?=
 =?utf-8?B?b09abHZnRHhhZlhYL1A4UDlKazhsQkNya0ZXMmtndzVUaUtwbVJJZEhRbHJ2?=
 =?utf-8?Q?dnW0TdbrpBEr8dgiRuRqn8E5n1D8JQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 20:06:29.4387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d273d6e0-eaaf-4bb5-ea55-08dd60d83630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

On 3/10/25 4:03 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common
> helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

