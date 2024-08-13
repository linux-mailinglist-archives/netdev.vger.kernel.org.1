Return-Path: <netdev+bounces-117946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74A494FFDF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54734B25474
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6163F770E2;
	Tue, 13 Aug 2024 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pqsoA7jC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E858ABF;
	Tue, 13 Aug 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537838; cv=fail; b=jMaNLX25SV0KhKzQlhpiPJD9RP++WbXGIAyH7WATA496Y9KUkTmui+BpLHxO9i2nr5SXTQQdatbz7CM2uHZRy1pzr8p1kNJVF6uSprwgD3IZynkbYzn5WCy51NyN5GezVXW22fRkCaU3scCZz/uh7J9DldnZSYYV3QJwui0CMLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537838; c=relaxed/simple;
	bh=tYAyfG2YzxOXjq13G0mqcf8VvkYAKs9iMAIm4fB/egI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZOjGnz+nDFrLin863apc63ySVKd/TetmSRPuNjlLMriBUke9y/lJKEjp6FS3XCj/Ahl8Qtc4ktmRe6OKJ4Nl6prH4NRywKSwjttclRlEJQkZq/dgyzjvew/IkAB2kR3yZygFpbj6imEo06uuNE7c3abt/0wz7vSgWBIWyTDzb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pqsoA7jC; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKM3FPVQwssm6c1bzQGw54VU/jx/QIXIbGOCP1k6FgKqdabIyXfOjGMcBzYM0cmPkSWVjoBmmBU5DdCDRtnb0cCwmfBRgqHeKs0Lrdu4SX33zAwxNsK9j2RR4LIeUAOXCGtKHjcqFomzuGA1PqsXgfFtjdnc/q+pAdW3w/eeXPb2VuEZ2FzxPxna+phZ3ZmpNI9RrR6XVBctYyq0M/NugDK04FNBEluXBHj1a5a7SNpcI42J/OZgsH9BJ9yXMsVfAK8g9FReTEnKqKCksVbj9jBeGGWFZfq26N/krWxRm7W+2IfLKwCIzWBd5l1DMQGvXr3qXYSergcc7fB+2OQeLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu5bJ5SyJliqs+NVcAjf7ZNvxvXoMYKGo1uxvtTp0ac=;
 b=TFz4OdKZJLImj/2zdONXivz2dls3FPZ6X4U9ZpXERy1HuG7b8aOvmLv5x/ew4BOcz4KY/9pG6IKD5mDbizOYvEyqubR92OaHR41ucGNSuTnzSF/nM2bRwUv/dYvisitLxmgPCaRubvRUjyRq1ZyzNL08rjeW1bs7Uoj3AOHF8IukPyhfyIG7fTDEtGccc7zAF0eeydaTAjTID8UVbZmVYfdZBaZuYfIgyb01lA84wfgBaJoGIXExPrso1DMISYrCtRRIUelx8YfohZcSyyEzzWGEQucH3yq/Rf8XUJ30NPNRDDtnOWUsmJC9RBZqMv2tvZ0RQWZxy5B13g9YG/Lp6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu5bJ5SyJliqs+NVcAjf7ZNvxvXoMYKGo1uxvtTp0ac=;
 b=pqsoA7jCaUZwWuk8FQ/7DBt+glyan/rOliL/2dcmc6ZZurx9NUtSqMRjfhkd/rDuHl9WH+bdw1SbtMvUOCIfF8Z9uihfSF17mRV+ED+w+LjyO5ubUR++jilTz3OYw5g0u59TwjP9MNG115UNXo/oOfid1Suq4L58lNVKV98BQBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ0PR12MB5634.namprd12.prod.outlook.com (2603:10b6:a03:429::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 08:30:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 08:30:32 +0000
Message-ID: <c9391139-edc4-73a0-3ede-d67c40130354@amd.com>
Date: Tue, 13 Aug 2024 09:30:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240804181045.000009dc@Huawei.com>
 <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
In-Reply-To: <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ0PR12MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: f35a154a-52de-4438-c2a6-08dcbb723252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFhzbWxWOFdxcVRVeFladm0weHVLNkpBNGRZemNINzVydC9FamdpRExSWjBS?=
 =?utf-8?B?YUdudHFrL2c3ai9Jc0dtN2xKZnB2c3VPZzFxUlByOWdCQllFd3hHZXE0eFly?=
 =?utf-8?B?RHVJTW4rQ2FDRFhjVU5uZGtJTHIxWGl5M2htNlgyUnJDODQvQStpbnVrR0I5?=
 =?utf-8?B?cU9kTTRZTXVhK1A1M2ViZ2xFaEs3aFlzbS9XQjF2M1Zad25QQko3Rm9RcVF4?=
 =?utf-8?B?UzFCYjRRTXNvNmZ3SnR2aDdWeDY1MDBOem96NHdkaTFXS3gvY2RtTzZyeWhh?=
 =?utf-8?B?Q3hzdTYrY0lvWXYzNDZqZXBVZlQvYTd4VmJqM1ZkTFVJSWwwTGIyengvOFpI?=
 =?utf-8?B?Z2RsM0hpcENYd0xXRHE2MnhKdXJoTmJFWkRNTkgwbldHY3FoQnE5R3UrR2Fa?=
 =?utf-8?B?MU5BL3Fyam1ZWWZwSUhpa2hrVXBNTFptOEJzWlVKZWVBemNrb056SlE3K2V1?=
 =?utf-8?B?bytXTnNkZ1Q4d2hKUXFRRjh2OUpjWkx6Nm9tTkdHblFCNjNiQ0l3OHRtUWNF?=
 =?utf-8?B?Zzl1c2JYVjBlTEFrRzlZMTlSL29JRmNxWDlwTGQ2d0Z6MVZzMTBENDdmdnd4?=
 =?utf-8?B?cnpDQlBCRTk3UTZST0ZZaVNGNnVtdks5VlN3clcwV29QYnJUS3FwZnlmeWdp?=
 =?utf-8?B?b1pYVUhRVzgzUENMVjVSZUVzL2xFRlBieXA5bjFRN2F0OUU4WlJvQ1ZiaDVV?=
 =?utf-8?B?alNzdGpHRFo3aWlFTFNYQ2dlNGFmc08xc1lQRFJGWDZXYVk3eHI0UHB6OGJz?=
 =?utf-8?B?dU16M0V6TVlwN1gxUjFSRUJ0SnlwMllmVk4vSU5LTFpMWDZGU2cyWCtLcmpL?=
 =?utf-8?B?cHpkenhtb2dtUjdnUE1DdkNPTE96dUZXQWJoa04rb1Q5SU5YMGxacXdsUnZV?=
 =?utf-8?B?RGh1dHBidnFPM0J4YThGVVd3UVpWYndxZDhxYUZHRFArclNpdVlQTjJIUlVR?=
 =?utf-8?B?OUZCN0c4eTNQWk1WdmN6VGt6c0RUOUdpZUF6NnhIUnlGYzE4eXVNdHlBa1FI?=
 =?utf-8?B?dXNKSGV1M2hnVk9kSFZCd3NKcEdkM1FFaHdsdy9GTGJIaWEvQ0FLWE9id25Q?=
 =?utf-8?B?MmtDblVIR01GUVJlUkl2WG43TkNKV0NPMVVRR1FIdDZQeFMzZ1V1ODJSVnNY?=
 =?utf-8?B?WHZGZythZGxBQWxHYXZUc2FoWU5YVWY0aVlWS0V2UjR3RmVLZ2tnem0vaEdi?=
 =?utf-8?B?STVyUVBWNG5sNldteXZ3RXVTeUhpOTI4NnlFTVN6aXFpQmlpbjY2R3k3dVYx?=
 =?utf-8?B?YjgzbHJlc1pTQnJ5UE1YbjZONmlSdVJ3L0VOS3pMZnZjOHNHUFlhM1FYOTA5?=
 =?utf-8?B?MG1wZGQ5S3NERzM2N1gyelFoUEhjb2cvNVhzamVkSFRQQmxhMVB1NExRRWNI?=
 =?utf-8?B?aEFrTDRTMis0UU9Td1p1NXEwNE5uVnRJUFRnMHkzU1lUWG9udFlKemZtNkI2?=
 =?utf-8?B?eERUOU0rdDB1enJPZG5KQWM4ZTc3SlFnNTlORW00b0Q1alhOT1F1VjlBNFhZ?=
 =?utf-8?B?SjRISGpsZitsSmhJdHFPdnZTd3Y3U1ByaGZoZUdJa2xkdmxxYjBiTi9ENVln?=
 =?utf-8?B?YWtxRXpKMjc5aW9lVDlDN1ZibjJWb1l4UlNXam9NQ2FOaU1wZUZlWWVSS1Jz?=
 =?utf-8?B?TzRyTnJOK1NiSFN4TDZhbXlMQ0MzTkhEejhGczl2Z2hiYXVEUDc1dG4rOTdn?=
 =?utf-8?B?MkFqUUhmZGVoQSthZHhzOHRPVU96ZUFGdnZxc3VmS0pTVzdCVHQ1amY0U2Uy?=
 =?utf-8?Q?rwrD8vr1WaBd5lPVUw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXpGTnVCNS93UmVlL1AyeUZnUy9qOVZaV3dUbHFuaVE5cEdBbFkvbzFkL1Ja?=
 =?utf-8?B?anFqbUV6MnNNMGRJOTJPam5pL0w4VzFOYmxmT2hxZ2ZsSVUwd1RPaHArRVpM?=
 =?utf-8?B?akJDUzFtcDBoSkNaVmpPdW80OEJXOHczMlA3dmtSdFR5SkZXdFk3ZmxTYzNk?=
 =?utf-8?B?UHh5cjJ4UWZVMVNtT3JIUHFsVnJUdUxOWHRxYkx5QW5jRlNSOUh0TVZ0M2ps?=
 =?utf-8?B?OVFWVCtrUHRYNXcvbEMreXFNUVlzZnNqYlBMeVpaVmhCUFZqQXhCNzQwSlBQ?=
 =?utf-8?B?OXZoSUFsTmQ4d1NGNGU0VnJ2bDlaSHFLSjdhU3RNOUJoNnh1TGpjVVJBYmNl?=
 =?utf-8?B?SGsyWGlTcDRxSVZWa3RHaFRTSE43NlhVV2xLK1RkaEk4N0MyMG81ajExMDhM?=
 =?utf-8?B?dWI5RzdIVFNhVHJNSkZmdEtNVThpM2ltb09LQkFWR29POW4yZFBoaVF3M2pj?=
 =?utf-8?B?OGs0Wk9UOTlSK1V1eVRVbnRzWXRBZ0Q2VkY4VHBUUGwxbFB3cEpWTVFzQmRG?=
 =?utf-8?B?UE9KYkJRc2IyZHdLTzB4MUtUdEhzU294Zm01ZTg3am93SS9RSFRJV3BkcmVv?=
 =?utf-8?B?b2p1Q0JCdHgxbDA0NW9NTGs2SFNpYjlHaWdVU3dBYUNyWDBCUG92cjhtTzBM?=
 =?utf-8?B?VWtIdnJCcmptTzY5TXNyUnNSRFRhNWZZU2E1Mk5lQ1JJK3FaR0xWVUF4bFow?=
 =?utf-8?B?MXRZSVJSVVJVdTlsL0JkMlArVzYzQnhFbCtycUNjUHQzQkRRWWdmdlRCbGx0?=
 =?utf-8?B?THJ3bDNkUzNTWE5zOS9sMXpwdWJFNXJSa1NZdlhpYXlDc2owR1hHMXFaaUJ3?=
 =?utf-8?B?MnNvM1pQTnhpeHk2NDZoaWF2QWRKS1l1R2UwSER2NEY4V013c0M0NXJpSEw0?=
 =?utf-8?B?VjNmZGU4bTRKS2x4V3JNQXpFSStJOXdEcHZyUlJYZU14WFNXYUs2NXlSK3dW?=
 =?utf-8?B?N0k1VWR1OG54RUtGWGVCNXo2LytmbzRlTzhIQXF4Sm1mVm9XMmpUWVdtYkE5?=
 =?utf-8?B?emZuUzFKTnFJZFg1K3dVMmlzSVZ0Uy93TGd5NHJ1MzBzL3J3ZnVpQ3JHYXI2?=
 =?utf-8?B?cElMQWloT2JTcHU1OElORHNyQTlKU0RWblBSaHV4bC9HV2wyTklTNTVjU01y?=
 =?utf-8?B?WENCSGFHRzJ3Q3d2L05PYS9WMzNJWUJDSzBCNHlUa3ZEcGlwVDBZMWZkdExq?=
 =?utf-8?B?L1FyNVBKbzhhTHhHNm4zc3g2cHorMDMwbDIrQ1U4R0xTelRqaUtwNFQ4Tkp0?=
 =?utf-8?B?ekJLclB6c0FtWGNSam5qRngwS3dsTDFwSHBqUzAvLzdseWdrclZGYk9vc0gz?=
 =?utf-8?B?WXMyWW53bFlBR1hvK3YydUV3eW9CeVlkSnE4cG9PSGNQRFp6V3lXWjZJMVZv?=
 =?utf-8?B?dE96MUVPS3RxMkNTYlVZRjF2T0dUejJHRlJYdXY4WGRHWmZjYmg1WFcyUURO?=
 =?utf-8?B?K3EvcEJLWXR2Sy9pajlZOEYxdzFOT0h3MVNOQjdFeUVwYjc1ZFlMWjQwTFlU?=
 =?utf-8?B?eDJmUzBCak9xQkIyUHZkeWczV2dtL3VhamdjdnVZdVFwb1RwMjNLL1pXUGM3?=
 =?utf-8?B?U3FTV3huWWhFZnVqTXBmUXZ1WC80YitlMkY4SnlaRHQzcm1pMmcrV1ZSR1RP?=
 =?utf-8?B?c0p6c3liOVFaMndaZlJvV3BBY00rTkR2dDNpdmlISng3Z2JFTEtFMmRaN014?=
 =?utf-8?B?cE9hSmg3K0xSOU9LMk5TelBGNXBwekpITTVpMlBsUm1ldG91S0Jyc0ZEK2V3?=
 =?utf-8?B?VG9iaXM3M244UlV5N2E0M1RaQURzRDBTUEFwZ01KOWw4QzdmVmdySGx3OXFv?=
 =?utf-8?B?ZG8yQ3UzeG5sMHZsS3hiSG12TjY3cjFXZUVBa1lzTmJ6UVgySTQyYVpBRUN2?=
 =?utf-8?B?dmtvbnNzaEFCa09VR0hMRWY5MkFxeXQ2YmpOVzNNV1NuRE42aGhuQ29kaTdp?=
 =?utf-8?B?QlR3V3pBOGhtUEdKbVRuOHJSdFhJaXlxaklkZWUzeWM1WDdGaVJ2eWVzdDJD?=
 =?utf-8?B?V2x3NHVWQ1duWUxjQk1VeTJTckdXc1VRdjNnKzZRQitIalY3VmxJN2xUb2Fx?=
 =?utf-8?B?VnNybWlUdXIzU1U1VThhL2JQYU9Qd0RRME1Vdy9XdmxvbENiM1Q2dXA2VW9U?=
 =?utf-8?Q?9QngC8ltUgT1gg2iqFSkltqn/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f35a154a-52de-4438-c2a6-08dcbb723252
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 08:30:32.7095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwQO2nwxPhAc+u3db7LS2sDi7I1fP+v2z+B8jnW7zs/ZIn3mqFdWv/6E3NbvGJ0kqdkuxWtLAdIvpHx8a+/MAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5634


On 8/12/24 12:16, Alejandro Lucero Palau wrote:
>
> On 8/4/24 18:10, Jonathan Cameron wrote:
>> On Mon, 15 Jul 2024 18:28:21 +0100
>> <alejandro.lucero-palau@amd.com> wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differientiate Type3, aka memory expanders, from Type2, aka device
>>> accelerators, with a new function for initializing cxl_dev_state.
>>>
>>> Create opaque struct to be used by accelerators relying on new access
>>> functions in following patches.
>>>
>>> Add SFC ethernet network driver as the client.
>>>
>>> Based on 
>>> https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>
>
>>> +
>>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>> +{
>>> +    cxlds->cxl_dvsec = dvsec;
>> Nothing to do with accel. If these make sense promote to cxl
>> core and a linux/cxl/ header.  Also we may want the type3 driver to
>> switch to them long term. If nothing else, making that handle the
>> cxl_dev_state as more opaque will show up what is still directly
>> accessed and may need to be wrapped up for a future accelerator driver
>> to use.
>>
>
> I will change the function name then, but not sure I follow the 
> comment about more opaque ...
>
>
>

I have second thoughts about this.


I consider this as an accessor  for, as you said in a previous exchange, 
facilitating changes to the core structs without touching those accel 
drivers using it.

Type3 driver is part of the CXL core and easy to change for these kind 
of updates since it will only be one driver supporting all Type3, and an 
accessor is not required then.

Let me know what you think.



