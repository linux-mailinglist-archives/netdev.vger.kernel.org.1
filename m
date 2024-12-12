Return-Path: <netdev+bounces-151474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D29EF9BD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2BD189AEAD
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFB82253FD;
	Thu, 12 Dec 2024 17:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lZBM8riZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9E222D68
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734025630; cv=fail; b=EPOOq0TfPMXAIRBXegPg9hMIOQ7/J/RIo5in6GzqPBRdUit8gLO2FL6lHs/UehH70nF6oMcT5WPnhIo6AX7jLuKoZfe8DuFz5wjkLOgy9zHUi5KmrIkuSxJYxPabK92RictCykksND+aP9KKlaGjbjFxKqb5gUqgUDdcw5i5fAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734025630; c=relaxed/simple;
	bh=cN6VD4Ch41kPiaCKoK5z4UxTC1fuSVzI1qCD5WR1pI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lg7GcRqA6jNd8wgoM1f7uUPndPX9FnDdT/QFVbcrepejTJGvV5p5hhD+a5fs0l9tQEIOZUUrbLUPI0ZJ5TFl08M3e+vuM7MhmjAI7sydfueuuaBHqN6Iqtg4DwZMDAsh7VKOFQPQN02S67flLBfxxRWBi1+kTR/qdU/xdmFitu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lZBM8riZ; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFHFQvSfHh/LI+yGo4VmewrQdNDLVRhs8Bw2bigzMfRG6JoGUx7UowwvowTgrFW/5EVryw/XeF1iXw13N8sfE5YRUnan2tqt4wfuk2SafBPDZjpkTwUyh7FI+uVf+Uh2CPRKqmMU8UuvcuQIk3EACkU6JAt8dwqFRRF2LrSLFQoUZ2o278WouHagoca/CPZyr9kNjDX0hjWJJlvK/st5RHrV4upmHtFskN4qSDUCLkOvmPTFNmOoQlclua/hrcRl7y2qH/S4n8Q0ANr8Kn3BDllO6drEws7QA6kgzQJm7ttzNVjIYmUqA7txZvh/UnnLAeLEzzz790YAuzMa2h7Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujAhhrSBR1x0YqAapcub3VRXVN6b/bODjJ9MhBnXrbM=;
 b=xEYfoN+Y3/Sq7NhmHrG0iHrfMvlJiEoVJCSL8GuXsPPrejDkXz501kUeWNsn2RCacOS2z2yh5V1DC7aQ+n5Sh4+4zK6RdI4ixSYE45gH3FA8E3DcxUthc/2qcyl9u3E4nrpECzvyR90SAwFW7TWXBBPC8FERBQTOmi1V5NV7T6OxbYZdz8p3nc040822I38aJ2U+uty/TQPTqiVXqDtfgJGLq9kF20igQRytruHSTnhgGLvt5HNWEkgl3UXQ6rethL7PAH1hBZdtAtleGJJu2sdqC6ZrXvRBYL0NxaYCFHEStoZ6N5063GWPy6Latp/5T+AmLzb3zPaZP/2Hvxw/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujAhhrSBR1x0YqAapcub3VRXVN6b/bODjJ9MhBnXrbM=;
 b=lZBM8riZXZpuYyEyRnT+im0bvFCSiR6bC0a4YJX9CFCzp5RIrjh+NtOx7xqqlcrQ2yfXZBL6mUL0ZyPN98nNM5pork1jkqst9yyZBwNgTdflOfutU1bFSPqmW5SGTi+Z0RSJOo7WCDlSAeXclPtvc9AKDs+NVvA44rRnZ7XgSdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.16; Thu, 12 Dec 2024 17:47:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 17:47:04 +0000
Message-ID: <719d6da2-d425-4d04-8948-60523997c60d@amd.com>
Date: Thu, 12 Dec 2024 09:47:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] ionic: Fix netdev notifier unregister on failure
To: Jakub Kicinski <kuba@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, brett.creeley@amd.com
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-2-shannon.nelson@amd.com>
 <564b9d98-4d64-40ab-a523-4487712430dd@intel.com>
 <20241211202840.05c0a461@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241211202840.05c0a461@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: e41ebfd9-ff76-49c0-fd4e-08dd1ad4fd38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVJJd2plTUtRQkRBR0lGMm1zYnBjdndQcFdSVzNtcEZKVkswamRVbmI1RFVH?=
 =?utf-8?B?TEhYVm9zQlI1VFI3TlNiODJvV29sUFZUYnRsSTdIYmVEa21EMWphUG9xYk9U?=
 =?utf-8?B?WThWTU9JR3RRNUJKeWYrbGZ5WlhLMFRXUndJbk50RythVWZ2ckNBVHM1ZUJM?=
 =?utf-8?B?bTFoZENSaUpoRWZhcTVIZThNRWVTeXJ6QnJWNnVDVUpnaFQzbnpzSWsxb1Zz?=
 =?utf-8?B?SUx2UDRneXBQNUhtbVRCcFZDRzArVThnOE9DcEhXT1ZIcVNxODFxSUFhdWJT?=
 =?utf-8?B?RFYvZjEyZ1JvbWFLWWx5NHUzd0g1YUxGcmhtazkzaUZZTnh1MHZRdjJIdmlo?=
 =?utf-8?B?UnM5VUVtaXp1di9aOGpxMVJqTFpiZUVYL0dKQ09Rb1JPVTZoVENqM1RPc0JJ?=
 =?utf-8?B?bUFBTHgwMFdDUDJlV0U2eEQ3VUhBUTlVelJBWTBXRnZtSE9KNExUM29DLy9i?=
 =?utf-8?B?WWNRd1pFSDhkRzcvcWhGMVZrbWhtQ1orUkVsNkhBakpBeXVHMjRQLzBCaTJv?=
 =?utf-8?B?NnpkZ2VsWSsra1RvZGVGcUFFeU9jYnZwSlc0RkFzcVRNbGxhRGJucXJTdVk0?=
 =?utf-8?B?WTFwZTF5NGxvVHI2eHprUHJRZG9Ocjl3eGZVMnBzNlVKa1NrYkFKcXF4NFZD?=
 =?utf-8?B?UzVGSFhObCtxSHFvN09MS1ErVXVMK1BJYmtldzBVZEtJVnRKRnVXTW9RZDFl?=
 =?utf-8?B?UEtVeGRyOFAxbENJWVZsZGZVdjdoQzgxcGY1NWdsZG4wa0xZZTlreWZTQ2JN?=
 =?utf-8?B?LzhWNzdVWFRORklHNDhOZmQ0VFl6TkQzSWpTdlpXTGRONWl2aWtJMGk5OHVw?=
 =?utf-8?B?THBlQzZiZXBzeWkzcW9NTGN5aHZZcW13MmNMQ0lnMnZndVduOFE4dDN5MXB1?=
 =?utf-8?B?eTRPVlhnYVJwSkxTZy8wbXd0WUsvZjl1cUVQVnJ6TnQ4Y2xyajRIMUIvTHBN?=
 =?utf-8?B?Z3gwQVlONTBXM2dVMkVndjEwS3BtRzdUQmlQc3p5SE44ZjU4dnJWMENoS21o?=
 =?utf-8?B?Ky9NTklnNHBFYkZKVGlucWExa2lDYWlSZTlVc2VodldUL1dTTmh4RFI2U3A5?=
 =?utf-8?B?akcxWWQxZ3hHSWE1K2VrMEIvVGZNWkNVblpWRDljN1NOSGRraDBzb2dPRVBH?=
 =?utf-8?B?SWtjRjl4UU1ja25jV1VDdnZFMm9MSzlIYVB6ZXZtN2FHUkhaem1UM2oxUHRK?=
 =?utf-8?B?T0RnZzZxUlBEODlIWlBBNkdaZi9MTDFURGg5alc0L0lUM3FtMFluODAvNzNq?=
 =?utf-8?B?ZUpNbE1ndzNjRlBMci9VdCtCNGRnV3ZEbFNlZmk5dmNpcC94eUZ6bVhhTk9W?=
 =?utf-8?B?clN3Rjg3clY4WERZN2JjRUROQ2NmZGI3L3pSZmtQb3BRZU1TNUwvZzJxeFZy?=
 =?utf-8?B?N1lRbGdGMkdMb1Q4RTM2U015Z2NISVFvcEhUSnJ0a1c5YWsrRzNtZ0xzVTJq?=
 =?utf-8?B?K3ZpelY2aitGbDU5dVV1c0hZQURkM1daZGRFbE1BWktGMVlEUnJIc0xwMVlT?=
 =?utf-8?B?V2Q2Tkg0UEpGNWZ2QUxVaFlOa0srVjRlWll3Z2EyQTVVOUJvdWRYOU5mdWlM?=
 =?utf-8?B?OGZZUWtORnpwdUozUk1BYjRFSk5QUkcvU3BxSzJWS1gzMnhEZ3lJc2hLb25z?=
 =?utf-8?B?czBWbGVla2ZXWUhvODROVWtLcUdOQ3RkOTY1dkdvMnVFSmZmdXF2SXZwQ0dV?=
 =?utf-8?B?MGVHYlNTeDQ0MmU0cmRTcVgvUUQrTWFnZDhMU0VjSk9Qd1BXVm1iaFFRaFVo?=
 =?utf-8?B?eTYyTTFSZm9DUEdabDVIak1xUkVuKzlzNWpRZytyeUhsSjh0RWVzRTNOQ3pw?=
 =?utf-8?B?ZEgrTy9vQk1xY2RrRlFlZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alNST2cvek4vMERIcCtCbUVHNXJBTlJrdGVqd2JubklLM0ViTzQwUWRxNGVN?=
 =?utf-8?B?RmVjMnJrdTM2enp0b2tEUjVtQVE2c0QyeUJwWmV4dmJhS0J4aGhZNWgvR0RU?=
 =?utf-8?B?a1Zpczlyc3p0bjhxK0lodTVXd3N6NGxpOVdnSnkrbjZwNmRZeGNkeGpVcU9n?=
 =?utf-8?B?MWZ1a3FTU2JpM2lTbWZGcTR4Wnp1d25HNWJzZEF0MlVRUUpwbDl0dXQ5cDAy?=
 =?utf-8?B?MjFJeGVpaXN6cVdwUWorY1lnR28wN0hnV1BkdFJFY0o4RForcjROUUNvb09h?=
 =?utf-8?B?SWhFdzU4TXFYRzhzcUp4aE1BNGV3VFFqai9nR0ZTVk1waGdQV0ZxZkJpUnF2?=
 =?utf-8?B?bFZybXlZSklUY3craGhtL1hzVDk4Y3RWZCtRZnA3cGY2ODVTUjNCc1BKRHNK?=
 =?utf-8?B?dTBOYkFyQ3plV1A1WVRXaHBFOS8vSm9kZzBZb0tYak82aGFsR0FONkYzL3h2?=
 =?utf-8?B?NkMrcDdqZUd5VzB1UlNiK0tuVU9XWXRic3VxOXJ3cGEzZDFweGNlakZlaXlz?=
 =?utf-8?B?OGpwUWFDQjI2d1NxVDFHcnlheGRjeWxZaHd1Y3BhSkkvSHZyOXlsWjV5MUYx?=
 =?utf-8?B?elRaWXRiNXdLVENwMEVvZmZTWmZnYWgrVGs4V2ZHeTVVdWxLQk0vakVNT0dK?=
 =?utf-8?B?VVE2TUNtQmhGV1lHQmVacVZ3eUZrR0tzSzNNVjhFVEcwVEJWb3FjdEh2eExR?=
 =?utf-8?B?MXBXdDBod0ZISjFmSUd3K3Z3a2VsREFWZWNtcTg1MlVhaGxPbFdFNHhvWnhM?=
 =?utf-8?B?R3dxczBlOFhLMkxiUkxDQkpGTkRwUVhUMDBxOStIeVJ2cE1nVWlpOERjN2wr?=
 =?utf-8?B?NXFSRkhxZkloWjNCMENibEh3L2xIZys2T0JjUS8yUWhmV011bVFXekNSTjdp?=
 =?utf-8?B?U2VQWldOdGkzazZTVGZzUFQ5aXY4M0VCM2kySzloTDI5c3pJeHhYVitIVUlG?=
 =?utf-8?B?Q2VyM1J1SXlmVGZMZzRoWHVwTjFwK1RZZFpKZ3Vpbm5aNHIxMTY0OEJTbXhy?=
 =?utf-8?B?V1k0N2pudmYyVFpsTkNQSERtOWw3Wk8xcmt4RDBRQkh2Y2pZY21teTBCOTl6?=
 =?utf-8?B?Snp0b3NWNzhKUEpkWHJUNjc1TWIxbGlucXFLWlE1Ujg0cHdTM095NmxJeFd0?=
 =?utf-8?B?N01ZL05BQlRkRndUb2x3Zzg1UkpGcXA4QnJvK0FnZXZEQnpuZXRnY3lSU1ZY?=
 =?utf-8?B?OUhGUnpzSGFiOFM4OWVMT0c4eGtLMkgraHJqRUk3bTV3UHo5azF2VGJDc2xC?=
 =?utf-8?B?VWR3WTRCTU9icXZuWEdTaWpjL1lNMXBheFp0amdKbGVMbW1qem4xMXZDdGp5?=
 =?utf-8?B?UXUyWVJDNm9Td3pGa09tUFRIRUNXWFowU1VPczVPQUg5b1lsWTJOSHJuVGs4?=
 =?utf-8?B?SDI5MFNOb3hqdm90WGQ1Z0xxaHNMRXp0NFlCbXpBMitSYmdWNGdMYUh6bHVI?=
 =?utf-8?B?MklhM2xMVnhaK21rMUcvZTREaGpueVc0L0JQWWMvRzhDRHFzd2YzSHRraVBO?=
 =?utf-8?B?MFZhM0tkN3BIbVlPZFV0QWQ1dUlSbXp6bjlRUUxrS2d0MlhwOUJ6VXlXS2Iw?=
 =?utf-8?B?ZjlubUk1emJXbndEQkdmK3hLdWRVR2lBeGFOUDM3NHc5dDdOeUZnclFwOS8r?=
 =?utf-8?B?aVZ6YThBeWxwTGgwMFFDdmM4aHFVdTMrWFVQRlhqWUlDUGQzUGN5VEtTbDFn?=
 =?utf-8?B?bzZpazBzcGMxV2JsTEEwdFE2NWF4WUN0TWFyOTdEZXJDd2ZNazBwSEJrc1hL?=
 =?utf-8?B?d25IcXREc082b2JxNGxqSk52a2xUMnBWWmR5OG90WmlPY09URlR0NFB0Q2ZB?=
 =?utf-8?B?WDlQTkc5RHl3Q1dmVEtWTnZTL2ZqcHdyQjVFdVNvWjI0UHlKYWg0MDg0Nzlt?=
 =?utf-8?B?dFpsZVZ4VUJ3OEpURTJaV0xDYm8wSk03L3l5VGlvQWNwWnA4c2FZWFpIV0hx?=
 =?utf-8?B?QXBySVl3eTR4TVZBaFIrQ3p4aGxRZ0JQTUVncEdtTHBDV1psc2JoTVgzQ2d4?=
 =?utf-8?B?N3A0Uno3aW1VNHZFWnVia2tXUWwxNlYrTVBxcXloSzVPbGozWnFnV3hpZGxs?=
 =?utf-8?B?OU5MMU5XMTJIWWU1TUExYmxWUm1uL1F0T0JTTGdBcjNWb3VDaWY5L25kdkRW?=
 =?utf-8?Q?wdA3yUWBWugUBpdx/TFbLWwgO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41ebfd9-ff76-49c0-fd4e-08dd1ad4fd38
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 17:47:04.3123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +GeJ8tnnrz+1dl0XhiE+DQcPi07c0CUbkIMJg1IiqFiwwy9BM/NnykB9Yp78OMO7W4vHVHP612d4e7Qs2y8aZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

On 12/11/2024 8:28 PM, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 12:59:31 -0800 Jacob Keller wrote:
>> I'm not certain about the inclusion of cleanup to drop unused code in
>> the same commit as an obvious fix.
> 
> +1, please separate the nb_work removal to a net-next commit
> --
> pw-bot: cr


Will do - thanks.
sln


