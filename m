Return-Path: <netdev+bounces-192604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C33AC07A4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333401883EA7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDAA22B8D5;
	Thu, 22 May 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R7f+4mLu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC67A1D54E2;
	Thu, 22 May 2025 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903763; cv=fail; b=O3KAhndcc1C51jJphpKDMsLvOV02K11TlyUKbPHwS4dA4DAHRcOmxUpPYh3mLngXJhte8iQm/Rkk+W32xxb5/JxaSrh2vrDUeAcm1d/jwB5gEtFpb2qrDzeNuvVdwJLkM9cigQ4rwMu2WHjxrCUMAYnESpAuMsdlti3a7di95mI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903763; c=relaxed/simple;
	bh=i5wENaweF3vxDNom97KFNxBAMQHj9M18XQGBNPWsc+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sWRPUVQt56mGOMZr90Jo+Bv7TsWQnE7NW1qMc5qU01p8oWbMk+VA/p/iRoTyG7vHA8+A52C1+wSVcf6lQPbqGh+S1hqxminI0fnbr/GWOi3S9LE1x9olwwjSbWFpl0RwbEzerxmKmSF+2E/B6y+k8PMSOK4lutc40SVtEIq32DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R7f+4mLu; arc=fail smtp.client-ip=40.107.95.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDHrhOxrQeEpqRXVPSFNWHoIwCezBOJJjVYhi9a9+hg+cewiuUejfMcnfkWLT3Hqf6vnKNsDDXjpvB01pTWgGrWLKnUzGdpe0Janw/668kLFHx+vyV7ffg98JLspRQbor6CNVK58YNISOYi8Ac3tnYtaoTDhrfc5bFkgYhMcisoQXpAkJd6skl0NLB+4VRMjEEWd5kvchi1hluqgXMphOCyW7ETs+FZ2Ad9i5KYEMvUt814m0IQi8xikjjkA/FRJW5PJMkxOc8TQ667k0a8gRRTBwenQb6b1lNV6GrWoW0PM4CtUXYiK0zAuuJDBCdYHp/gDKyVK1wYyZqKB5W1cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPq0hJ+PXQHnG3dSf+8XM+NA2deUjOAN12BtKKWByek=;
 b=yWN2nJmCeSTGp7aXW0g0LT7gc8rq8L0jGW1kllGI+br/l2uRva4/EZInE67p2tiOByXld0E2/Iq388vPzRlGhAMgFk03KWO/aJD9l5KuV1LGR8NUQJNkeF5K5VZazuTjbKgphu55M0sivT/6zzyFk9SgfCG9VV0CAnRaphBC4aj2wpW/r1Wt/uMqu2BqwUsYnu5+/f1b/tDagSjULpKL+HHGZcBEPxGN8+aobgykXIfbGZUklrsNAuUUqoNm45ErLAWuZcx5noh5vDcbt7wq4yxdp1qFO3rJr0nypdDo/R/5gwiRyVFs2l8V723fZovFne+4x5lRAKt2MajabyfUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPq0hJ+PXQHnG3dSf+8XM+NA2deUjOAN12BtKKWByek=;
 b=R7f+4mLuX6zgzgvlf9Li9IS2cBaCWRbsyVGiOLDZuO+rT9wqDztiHTJmp3jHHywtSg8MySWPeHJZ9X6NgBdyHoBxzDuWO84eMRTthFvqcIdiiWn1aDOQpsEuOVa9PVhj4e4cS+hmpiNou97fWFD+djZwceuoj1Ifioryud7PeIM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 08:49:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 08:49:16 +0000
Message-ID: <8a993411-26db-44c6-954c-e58eb12f9d82@amd.com>
Date: Thu, 22 May 2025 09:49:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 02/22] sfc: add cxl support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-3-alejandro.lucero-palau@amd.com>
 <682c3129d6a47_2b1610070@dwillia2-mobl4.notmuch>
 <172834c6-0cc7-479b-be04-5ccd5cf8aae0@amd.com>
 <682e09813a374_1626e100e@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e09813a374_1626e100e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: 436c24ca-6705-441b-c3a5-08dd990d88d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czFWdFlQdVFXV1crVnhXQnI4RTBXUDVGTTl1cjRoMWZaMUFzVTEzdWZLdS9n?=
 =?utf-8?B?NVZKemg2M0JmZ2pWMm5FT2MrcDhHVXFCMUpDNEtEOWRRb3dSMi93Sm9uN2Z1?=
 =?utf-8?B?dnRMdnE3U0hOY241VEF6TGpXbjhPU2hWaGJSdERzRjFSd3pzbHRUYWJUY2Na?=
 =?utf-8?B?bXh5c3JNN2pXTjc0RnJBRmxLMEUrNUlsblJhZlFvcVpzOW9qaldleTJwOGJ6?=
 =?utf-8?B?ZStoTWlFcnBZVEhOckNYWDFpeGtacE9qeW9qamNyNmVxU05nWWRXVFVzL1hH?=
 =?utf-8?B?aFQ2bnh6S0oyTy8xLzNMSmlNZGlRZFZXOUJFL0J2RGJMTmN6eEVvMnpTZFow?=
 =?utf-8?B?WG8yQ3RFV1NBWVY0TUExRVdiL1UzallNUml6eHdRQ0dhTmtwTzRBbHlYUEZG?=
 =?utf-8?B?SXhuOFFoVTR5Zkx4UlltM2JocCtRZVluMW9RU3dJVTdMd25VUFN1Wm9hQmt5?=
 =?utf-8?B?N3FFVzRiNCs1YjJLcmZBRnllWFdUR3ZwVGRUV3JjMVhML3dabFQ0bVE4N3lH?=
 =?utf-8?B?MzFCaFBmRGxHQWZJRDBveldzcWZjOEE1eTZjbVRwRjd4QzI5eDZJZk15cXRa?=
 =?utf-8?B?ZUpJT3ZhRW5iazUwSGl3aWV0WktYTkhLbW1VSHZIK0lUM0dHZ1J2TG5MVGxz?=
 =?utf-8?B?Z0dpMGIyaDNybXhSeCsvSzA5SVNRTHZTVFQybU9JN2FuNXlSbXRXN3llNnU5?=
 =?utf-8?B?SjNWby82ZGgvV0lMUmQ5NEVualNROTFtc2JGUEFoVTV2U2I1Y2ZWZGZKVG40?=
 =?utf-8?B?YnpQNmZLTHI2TkVVL1VpWGJXa2hvVnZTZkJJVzhpRm5BTXdCakhMcjdqY2Q3?=
 =?utf-8?B?T1NCM0EvRy9aMEx1aEVic0ZXRUc2T2gxSkFrMldZZllKYjZrUm1KY0hQN3NP?=
 =?utf-8?B?S2ZHZzRSMGx3N1RtNzVwckZmNEVoZ282aHZyYlV6SmVHSjlMOG5RcmxxOSt5?=
 =?utf-8?B?eitBRm10SDlYV21oMktKakpneVc3U2NIU0lmRzBRUHJjWjJxWGNSZXZQRzBx?=
 =?utf-8?B?Szl0SFA0amJZYko3TXFDWFZPUVRDRGNoR3J4Ykc0V3lXdEUreFY2YXJvcjAw?=
 =?utf-8?B?d0FNemh4QU4rakN0V1Z2enpyVis2eGRYMndIS2grK0JEM3BrRFRub3NoanBS?=
 =?utf-8?B?bWJCT0l2UGhqWnU0THc1K0FON0pRUllWWFdaejF4OHhlSm5maUxuRVFGYVBG?=
 =?utf-8?B?bTNJZWE5eDRXVnlGSlBQTmNwUGdiWGhLUUROMFA2WmJHNHErUU95WWNrMmNr?=
 =?utf-8?B?czM3RnZUV2d6WDh2RytFZDNyc1FVeTZWU1F1aEIvQ1dHOFA2MUdOcjdkMHpC?=
 =?utf-8?B?Mm8yQlFmcHM5aGI3TFZueEVKZSs4a3ZtMHpodDNRSGJhdHhUc0NyVmJuayt2?=
 =?utf-8?B?ZGxtTUJudnlnQ2lmSFRhaDBTNXMvSWhkOHc3WS96RlVnandvK2dvOUJJT3Vx?=
 =?utf-8?B?bHhFeHp3bkp1a1gyT0xOZ0JqVDlvNUQ0SlFRYTZZWFJJVE5lK3k0Nlpuc2Np?=
 =?utf-8?B?VUZQN3IvZXJUcUo5c2NySEtHdGo1MmJUY0ZwZ29UbjFLNGkxM05wa3NVcjZN?=
 =?utf-8?B?cjZpREEvYlVkWHNoaFRsbW9rbnNuMWFFbU9kNjJJS3A4eGs0TEpWUjhsQXV2?=
 =?utf-8?B?d0QwQ3Y2VjF1cmEzbFkrUnV6VXEvNzFvZlltTzhpQkp4cmYzNG1ycTJ2SXFn?=
 =?utf-8?B?TXVtOEl2MWtrUEM0TVlYZnprUEhla0hUVW1HeHNWeUNlaDJPeDc1R0t2V0w5?=
 =?utf-8?B?M3JXVk51MVV3VGlNSGRJek5MdDUzUkw5QzIvVzdkMWx3V25NbHhkNi93UTB1?=
 =?utf-8?B?WjlwK2VjMVZEL1RqcUdZRHRXTHpBWkJVY2RNeHZlTkVFNDAwaDFHWEhCc3BK?=
 =?utf-8?B?NlU0TnZnZ2llVk5lVVk0bFpxWUZ3OC9tLzlHenlRRW9VZUl5dllIdFpJLy9U?=
 =?utf-8?B?OU9HM1pRVWI2QWU5eHE4VzdFc2ZOSVF4dUVJMjNvNFRjUWVOUnZjRHpoNXVi?=
 =?utf-8?B?Ymd4d1grQVlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K091SmxHY2FrdDN3STZ3L252Rm9Bby9SU0tTZm9qRW9lbVQvQVdDQlVrWjNp?=
 =?utf-8?B?bGw5VEFvS2o3cWhYdkJ0SExVRC82dEc0VjEzZjRDUEFkZWkvVzlRa1RSWjN1?=
 =?utf-8?B?NjhFa3NXSlltYksvaXcvSnJaTWE0anB0M2tRSzdlS1F3NGF5cEwzSXhVTGl4?=
 =?utf-8?B?RVlSSGJFaGtKRnZCUU03Mmw0THVTY2x3Z0dIdTZ4dUFsRi9qZ2U4SmtHcDhQ?=
 =?utf-8?B?bHFTbGxoYi9VbG9rTmxRTWRRdHBXT2tNR0hhT3ZJWGY2R0t0TG5JdVBVTHhB?=
 =?utf-8?B?ckcwa1J4MUFIckVQUFJRVFNQUWt5emV3OWhJd3FQYmEydklLZS9sbEFWZUxj?=
 =?utf-8?B?dktRREcxWVMzYnpEbjRhdmY2eERQUENqSGxGOTRhd3dVQzl5elM2WERZak4r?=
 =?utf-8?B?eGdzOTRqdXEwbnlya1QrdSs4b0djZlZ0SGZta1VrRjhVOXJXcytUNjlnVFRY?=
 =?utf-8?B?YnZ6NEdYNE5WcjduN2d6ZU8zNXRsY3RseGxuWjlVdVJTMzhMMEV5Y1p2Tmho?=
 =?utf-8?B?dzd0YWlXSURSeUQzdHRVTzdRVThIelQrVG8wNWordENjM0t6VFlqLzMvamxy?=
 =?utf-8?B?a3pJK2F2WmwyWkZPbmNRRWUyd3Q2ZmJmYkszdkdCWkkvcE5FS1dHd2w5QkNF?=
 =?utf-8?B?TkFUNCtBNVpTcWRGMFdCQVJwNXo5Mi8weHpsZm1oM2pWcy84Tjk4cXZpRmhk?=
 =?utf-8?B?NzdoTHFkczRhdmozUFJPeExMWVdGVm5PWlFJR1NFY2dIbkE4aU11SHhHR1JG?=
 =?utf-8?B?L0QyRjh5NEdyTFlYaHV4RDg2RUFPWFRJMUY2WWMvd1Vsb1F0UlFZYlFRb0VZ?=
 =?utf-8?B?SXhhZEpmYlowQ1FUYmlRWU1lK1BwWGE0em5Wcm8vRmRaaG4ycWRnQlRsUjZI?=
 =?utf-8?B?cFprNHJ5Z1FWcStlUUV5L3ZsRk5mbE1PNnEvTTJuSHVSaEpNSklpOTV0K0JJ?=
 =?utf-8?B?d0k0bmp4cXFDVkhQc3JOTjBNZ2tGMDlaVlFxeVFObkwram9HRjIxMmpCQ29z?=
 =?utf-8?B?TnNPb0ptZ01IS0l4eFZLZHNBVlZKN1NmOTNnbmRUN3UxVlRoVW1seXNUd3hK?=
 =?utf-8?B?TERkUU82c2FHUFNrRVpXNE9BVThsSkN4NTcrY3VZVnBmQ1J3YWZjdE00bDl0?=
 =?utf-8?B?OU9UWDFYYjVqSmpxOUVXbEo5MnlzUHdIWEpyTllHYnlhcE82WkRWRzF4TUZw?=
 =?utf-8?B?ZEpjdXdiRVFMR3Y4WUFDL1NzSWdvS0NHcVQrZFB5VVdMZmEvNkFrWW92dzVZ?=
 =?utf-8?B?L0tiQlJzUHpYMnMwWXJLWTFjNUFYWEJOVHZsZEgrWE41bXVOSGQ5NitsTHBx?=
 =?utf-8?B?UW5XdFU5ZmhxMnhCOFJFcFpsei91UEUvTng4R3FFbHVjYW1TWWRMS3F6Uyt1?=
 =?utf-8?B?VVBYN1d1N214TXpTQlVhQmc5Z1RCQXVqWmI2cGJRKytrTkRrdmo2WUtEaDcz?=
 =?utf-8?B?ZXhzTzdjclE0SkJnMEdsdllPZThYdG5laEZhU0JlYmJKQ0o0YlY5bWJBNHda?=
 =?utf-8?B?SVpRZllMYWlGVTVrY01kSGxYQ2kxUFRLcXlmcHliOGFyS0ViTjk0T2dQSmRN?=
 =?utf-8?B?NE5HbW1Dd0Y3a2ZHWmtwWjlRNVhIK2xTSytoRmMzc2dDUk1ZSTduVGRHTlRY?=
 =?utf-8?B?RDZZTGs3U3UrZDBrOUI3TDdBRHV0UG90alpYTHRFcWJnQmZyMkhNK1M1bnlv?=
 =?utf-8?B?Um9CL3dqU04yNXVCRUJLekplODE4RDNFRndWSytYZ2JQaU4ycFFkc3htbGhY?=
 =?utf-8?B?WFBDWFQzOUtiYlVkdnczc0dWamc1YUcvRmZVbkZ5UTh2Um1zQkVQcGlIc3B2?=
 =?utf-8?B?ZUxHbG1YSTVSQ0U4Smx1eVRYNUk4QU1RMUNNVFM3eTVtbUNmVklscjJXQmti?=
 =?utf-8?B?dXZCb2dLVU94VUJ6NUoyY3FqaWorNHBXaHNqV3VqMTNEcUdRWjB5OXk2S3JN?=
 =?utf-8?B?U2RBR0JmbXRXNC9SaExmcjllRzZXMm01WVZYdkcwWjl1VGdYUElJMXNwdkxI?=
 =?utf-8?B?TjNQaUdBMVN2RXdubFYvYnpjTDlYTHFvSXZBalZDczFXWjdwQzZQRFRQTFc4?=
 =?utf-8?B?eVRaK3hQckpXeHZuYTRyZGF0VGZNMitUcVBDWmFmRk1DSUphS2s0UkxydFlm?=
 =?utf-8?Q?OdtqSnvlQtDOJs/cr/FCnObfn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436c24ca-6705-441b-c3a5-08dd990d88d2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 08:49:16.8078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcOy320EG41Mm6UoDGuMPmChpWTM0QWwxDdPlic9BmnevfCaQHyvLfIfaW/A+zVGWpJgtu7iNohX3y88nGqMew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043


On 5/21/25 18:12, Dan Williams wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>>> +void efx_cxl_exit(struct efx_probe_data *probe_data)
>>>> +{
>>> So this is empty which means it leaks the cxl_dev_state_create()
>>> allocation, right?
>>
>> Yes, because I was wrongly relying on devres ...
>>
>>
>> Previous patchsets were doing the explicit release here.
>>
>>
>> Your suggestion below relies on adding more awareness of cxl into
>> generic efx code, what we want to avoid using the specific efx_cxl.* files.
>>
>> As I mentioned in patch 1, I think the right thing to do is to add
>> devres for cxl_dev_state_create.
> ...but I thought netdev is anti-devres? I am ok having a
> devm_cxl_dev_state_create() alongside a "manual" cxl_dev_state_create()
> if that is the case.


But a netdev is using the CXL API where devres is being used already. 
AFAIK, netdev maintainers prefer to not use devres by netdev drivers, 
but I do not think they can impose their view to external API, mainly 
when other driver types could likely also make use of it in the future.


>> Before sending v17 with this change, are you ok with the rest of the
>> patches or you want to go through them as well?
> So I did start taking a look and then turned away upon finding a
> memory-leak on the first 2 patches in the series. I will continue going
> through it, but in general the lifetime and locking rules of the CXL
> subsystem continue to be a source of trouble in new enabling. At a
> minimum that indicates a need/opportunity to review the rules at a
> future CXL collab meeting.


Great. And I agree about potential improvements mostly required after 
all this new code (hopefully) ends up being merged, which I'll be happy 
to contribute. Also, note this patchset original RFC and  cover letters 
since then states "basic Type2 support".


