Return-Path: <netdev+bounces-183733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2CA91BA6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E4B1644F3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C6024166D;
	Thu, 17 Apr 2025 12:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TdlFlKn1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580212B93;
	Thu, 17 Apr 2025 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891720; cv=fail; b=AjxSKpBloRlKv4/fl4eC7Q3Zzp6qEXgRRLzpZH2vEu4yV66QVxIfnXr5nHauA/IdOt15Ij27/FN50hUCqahYvxBELICn8E+6CqICynIQGSQ7nFRrFxylLt/PtofdnvWdXdPRbLe70mB1nkFizC9+w6Qk+xJD6kft6ozZKbC+fzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891720; c=relaxed/simple;
	bh=LppG8qAH0qsepLItNjBfdBvI9qZNjAoIRYw/BtC3Sx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fVrPhMjCujM8zwGYsgi5v13Bb24NEWZmP3Tmmy/h+IXf//a1d+RriC68lkadK69dYmXNwD1veO/2mzAVZtmo8PZ9mBaHq7nTY7N/V82JAF2EOvvPBLkYP61P1lkwkShGG+f/QKmdXl/qBfadgFPGWIHv65WyeisRSiB42ic0nTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TdlFlKn1; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRTHP9SP5wWccxlfzhuOgyoN7P8ZBHi3bSH+ht5v8O3ZB4w1Drn4UB1ZJv6DC/lVZy09Ug1ZSBDebZT0NsSzCP66ek85kysJHOrdz4pQdbwgzQ7HKPT5PMQZeDW0psrJcHD9cKHTffQhcMPdksy//Sc8MCRcG0nt7+zTrgzJMFhJDB07znUhRunVDp4LucqU8ynJWpsb86slskXvUqOYIiLojl5O5aCt5nJBzW4egkyXH20m8UVg6toI7LT3k0L37tNtntLBYF2lqdDcgx7sk5Dd3vdlkq+AQ53TbeQNSqWWTssCm8AqwnUdsSxOTSmgkhaZGYTAYw8SHlcLPVlf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oG/n3GnctxEJj5QYfISrju7BSPejWq6j7RXwYiXefgE=;
 b=aAlksiQtDt/PCGJbMsTH7T/Z1NSWeDyYbN0dK8KXF0BJ/qupLmbH7r9e2Yj1qEJ0GnkRhWImU4G5wMTg+CIYOD68VSq5BlzY7PkJGjjfn6/W1vIBScT6y4OaAsXbwEHyM2VCO4oTis0JpFi5c+EFQNtPvInc8vlTzdV5pDufZ/C5Ze9SFhauqaQ/mciQsVeYfwQp2s1WURYWFtZ9HFVk5em1sSdevercFaCjr9OQxpYv1t3G3YAsLFZqD7IyKRusQ35MtYy7jLrFG2wbxHsOZX/AXgPrRkCpM/aCEf36BqiSvXa7xTfhz2RX6P4KFFOMzSvbSo+PPqdNxyC2VqkbGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG/n3GnctxEJj5QYfISrju7BSPejWq6j7RXwYiXefgE=;
 b=TdlFlKn1AJSHdOK6z4B3ef0IVdktU53YSm1UTAEMQ1RrASafMhOjYiWZjn8UIckPMrsvBzBQPJqRYuNn2N/nSx4tROTvW1EDKyQl3TFK875ltpQ0pOgL2W7MOBOikhWvCq9RVSZ3C80Vy7neVJKBb1t6aQNAlvt4ApMPRaa1DVc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 12:08:35 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:08:35 +0000
Message-ID: <2a18060e-8415-45fe-bd93-831ceb72db03@amd.com>
Date: Thu, 17 Apr 2025 13:08:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/22] sfc: make regs setup with checking and set
 media ready
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Zhi Wang <zhi@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <20250414151336.3852990-7-alejandro.lucero-palau@amd.com>
 <20250415142512.00004edd@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250415142512.00004edd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0136.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: b125ad31-13e6-481e-66b1-08dd7da89430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djNrZTdNWTVOd3pQY09tekp5bng3V3VrSjFCZXoxK0NIb2NSMTAwSFFja0Rz?=
 =?utf-8?B?MWE5V2MwamdDTlRlbE82YWJrWkVXdGhVZ25JMjFacStaaDc0c2JLa2FpeFZ3?=
 =?utf-8?B?aXlZUWtORnU5NjZjWGNBUnpJdkRxaDM0Y216azNJU0ZZcGE4WXVUOGV1Z1k0?=
 =?utf-8?B?am53RjVDSTNHVTJIakVoQ0NmenBrbGJ4d1I4YUoxRFJld1pkTlExSmgrMC84?=
 =?utf-8?B?V3NuSTBDdEY5T3Y4SFhFaXBFdm9LbWhndHQ4bHMrdHA4Q0VqYWdja0JaQVc1?=
 =?utf-8?B?dmRWWWhNYWhzS240dWYwYzlNM2xQVFRmQkJ6bVd6ZW1PYWdxYmVFVVl4TmJs?=
 =?utf-8?B?RVpHaFh6WWNja2tQWnFHV0hGSVBOL3o2anFreHRLTXpPUVVtYStzbUpLYUpQ?=
 =?utf-8?B?ZzNpVUJsUW1odWNjVmJ3TkJ4SklYWCtqTkR2SkZkbVY0QW5QMHpyc00vN2Ex?=
 =?utf-8?B?MHZvR1FOcDF4QW9odDFDMVFxWHkxYlYvWVNSUE45eExIS3lFMVhGaFd3UlQ4?=
 =?utf-8?B?dEhsUW1xYTRtVFlTbHE1eW1IT1ZqSlFFS0xKNnh4dW5mVG9NNXYvOE55UkZk?=
 =?utf-8?B?ZlN6ZnptQzN2K0VEc2pGemEreEpFYXcvZUhXYmc0YnJoTGJRWURLeDRqR3E1?=
 =?utf-8?B?M1lwWVV1SlRJT09EcFlQYno4eU5oR252OHBqblFXYzF4bThGNlFBUlhBcWV2?=
 =?utf-8?B?MXlYVWVhcDQ1SW53aHdGazBjSFl1NEw4ZmFLb3VNSFl6ZG1OVVRmbU5FR00z?=
 =?utf-8?B?aWNnL0RnTTZzMnp5by9YMlZ4S2lLRlRWUHphd1Y0NWxvajdGMytQWkRWTlNx?=
 =?utf-8?B?THVkTk1sOHM2cGlyUDVoYzlsaGZCRHhEd0tuSkNDd0FZZHF3TjZ0K0gwMzk3?=
 =?utf-8?B?cXQvTVZIRnRYSjliU0pEeTZLV0RjK21DWFhvV1AxeWdaSUVkYmo2Z2dmVmVx?=
 =?utf-8?B?NU03Ym5yeGtzd2hieTdZSHFXTTB1NEZUNUVzb25QNjE4QTVQd0dxblVPSUxB?=
 =?utf-8?B?dFg2bGdtRllWNmY2YWJoV2dIMm93SXc4QWpaYVdQM0dHeXRuZ093VzBtaDUy?=
 =?utf-8?B?OG94UTNZVk1ERnR6YnpIWEZQVVA1Uzc5dGV1SjZ6TWtDZjlnZlcrd2NpZ2I4?=
 =?utf-8?B?eUZKd1Fwa2ptUDJvd1J2TlFCUFE1T0x0L3lnVHYrandvME05RGYvSGVnUEFT?=
 =?utf-8?B?NWtHQkY3Q0tHaER1amhqMjVra3BXQ25LYlNvTHNqMVVML0tVeFErSlc5NXRz?=
 =?utf-8?B?TTZwVjBPN3JIVk8yMHZJdmVSeDNYSk5FQlVXZFFVRDQzcXkrSGFwMGlITXBJ?=
 =?utf-8?B?cjFlc0k2ZEVvelFVbWp6cU9FZHZVbjIybmRrN21qa0lPM2hKUGNmQVZBdXRW?=
 =?utf-8?B?eHl0cnE3ekxFd2V1Vkx2UDZ5S3RXSkE0T3U2RU51aFZRNmFlcXlxK3N3cncz?=
 =?utf-8?B?cjkrenc5emt4Qzc4OUd5RFZ0cFRFdy9iU0t6NnMzWER5RkRWNEhLbkNhUzli?=
 =?utf-8?B?MlhjSDk0Tll5eHpJbkUwMFBoSDU2SWJySk1XekhKK3dCaDlkQmlYSi9IT04z?=
 =?utf-8?B?ZGdGeHA1OGZtZ1lBYUtFWDFVYlVhT0FHNTVSSDMvcjFYM200RTFnWFFWRWdx?=
 =?utf-8?B?VzhCcWxSVUJvdVpaZ3ZkbXhLUlpzVVJGaHIyb3NWcjBTTVZBTWpONDdsZ1h4?=
 =?utf-8?B?MWlTTWdPaEhrZnFDcmFVYWxBOFRqOUhlclJSYkhrZ1VMam1ZNHpVdVR6WVdr?=
 =?utf-8?B?NW1wckZ4ODFhQ1dRZTliV3FFbFhXbU44a1BxMEdaa0NCWENPNW9xNWdHNlJh?=
 =?utf-8?B?SXV2OGJzSlI3aUE4MmR5ZThINGpGOGlsK2tUVmVEU2ZZcXNKZXA1Q0J6YmtG?=
 =?utf-8?B?LzdaYXZMTjdXUkRYemZqeHhXd0UvTjVlWWRGTTgwUkhLWTNIZjNMTU5rVXo0?=
 =?utf-8?Q?U7r9jOp+TN8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUYxZjlHTkNwT05VRDB3bTFMK2pud2I1eEgxMk1tTVJ2T1BZT21HUHhXUFFT?=
 =?utf-8?B?WGJ5aGh2QnlEYlNhck9TYkRXZFpiL0xnMVkzaVdxdklXYlhkVm0wRVNCNkly?=
 =?utf-8?B?S1pycnVqSnZPd01NVDhITVErYlFhdW00QlpyV0lxK2tPT2tjc1Y1WG5GSmRI?=
 =?utf-8?B?N1lQZWIxNXNOdSsvSTczNGxqejd4T1E3aThVWkkwYVlUK2FxZ1RqbnF3V2ht?=
 =?utf-8?B?ZEd2aUMvK1dSL0JZbURpS2tTVUQ5ejYrTnB3d1dqbzhQaDhkUHRuNThLL1hs?=
 =?utf-8?B?bHE3OEs3NGZUL0piTGlWcnFJR3RnNDlUNVJnZTM2aWNJRUptaG1uTmc4eTky?=
 =?utf-8?B?bklodjVkMGREcFlOQVd5ZTc4aE91NjVCR1B6SU4vKzhOeUVuKzdoNFdUcnN3?=
 =?utf-8?B?aWMrSWF2TFRURXdwRUNmcE80RFZpckZBMm5rUTJKYms3cG1wMlhXZ00vZWdT?=
 =?utf-8?B?Q1FqWUpLYjY2LzFqdG93VUFpaGJTeWVua0Y4aFpMSDhydWsrdElUZHA0cWt1?=
 =?utf-8?B?Wnh1SXZzc3gyOERhMHZWNGpyblQ4Yk1rR1A4OVNIN0lzM3Q2L2g0WFAwcEV1?=
 =?utf-8?B?S21JUy8xVmVkKzI1VCtDaUEzNVhwb3ByRVhkYmwvelNFdXEvR0JyMTJTZ2JE?=
 =?utf-8?B?bEhSZGFFK2RzQjN0VElMU2lLVEUrYjJ3NUx6V0hMRUZWbVI2cU9kSXozMzFp?=
 =?utf-8?B?YysxWkZIQWdhMlBrNEJVSFcyVjBSUUVDZFRCVXV4b0hDVEZaRUJOdUdaMG1k?=
 =?utf-8?B?Zml0Y2NrcjdFQlFzSzdFUGxQSkQ0L1hzM0dxMTE3T1VqRVQyN0tLZmUrbmVv?=
 =?utf-8?B?MHZTMHc5Ym9HNDl1MkRHZk5idyt3VUk4bFdYdG5qaUdzT0prNldIaklGNzZv?=
 =?utf-8?B?SmFxeHZRQkthL1B2R1dGMFFpMzdNMTE4V3l6OFY2Q2Y2NXREWHZST3RyUmFa?=
 =?utf-8?B?bTJCNGZpVExzbi9BVjNrNm42WG1MSkF5L1o4cm0vcEZpSUZsNU5WYm9kZWp3?=
 =?utf-8?B?aDhhWkNWNG1RemNqSzJDeU45UFpPL0REblJudjlLalZrTFQycXJSeHZjM3do?=
 =?utf-8?B?cnFjT3V1S2R3bUZXK1BObG13ZEFzWWswSkwxVU52SFMxdWFEL3ZGdVFQcHhw?=
 =?utf-8?B?SnltWWVSakhFNzBLSGpseVNHalZwNkpQNWIwM2RSZ042enpUWXpqZnVEdmE3?=
 =?utf-8?B?RTlhUTRwRThmTWNwSkw3NU1MTStabnNlWFJZMmh1bmsvSlZDQTJsSm1NUnlO?=
 =?utf-8?B?UjN1YTFBU1ZVbGoyYU03cFFoeklFOVNXK2t6b3ZDdDI4OFluWUdMd0EvN2NM?=
 =?utf-8?B?VVV6bTk5RXF5aFczS09NRmlPRlN6S0FaY25QSWNMZWtSd2JXOW9yUWtkdkdo?=
 =?utf-8?B?WjZIU3ZLbGZwdG0ySGwvK2dpRE5TcUpsVHpQOGJmVDB0T2xxWkppN1VPYThM?=
 =?utf-8?B?R3Q2WDFJalpmckRud2tzNFhZeUZBcXlFS20zUVE4RStGSTViY0o2ZEdoNElK?=
 =?utf-8?B?ZitvZTdZT2d5MUNMRzBSNUlHbFQ3YW5RaGFCZWxYZ0hhbDY3d2ErSXg3RCt6?=
 =?utf-8?B?MnFsTDg3L240Y2pQemlMYkFVL0VWbDZOM3NMRkZ6cTFRL3ZtbHF2a3M2NXZB?=
 =?utf-8?B?N0tCRitlT2JmM0FVUkxOSklIMTFFTTY5bHhJdmRnZ3h6azRHc3ljK3ZIdk5v?=
 =?utf-8?B?MUVmeXBkNGcra3JOK1JISVNQakNmTlB5NXNHT1drZ1RKdXJneFhnb1Z1RjBJ?=
 =?utf-8?B?czcxdFNtNDJoL1FBbklqVDhZQVBSd1BlK2EwSTB5SWhlc0tZZFpBRGpJVUk1?=
 =?utf-8?B?S3VGOGtaTERnSjZPZFVIQnA5L3dJc0cwYXlSd0pEZ2NEVjgxMXVuVEZQV0FP?=
 =?utf-8?B?dklvRzdVYmFrZDhaU3AzMkUrN1BuMDk2NE41UEhzRld2WlloWDhXQU5GaDJw?=
 =?utf-8?B?eElJZnFjZzhYY1RVVVJOTGtKVmtYV2hRcTIzcEEvWWJCWXRKUTdURndDQ1VS?=
 =?utf-8?B?dXlKeUQ0N3ErZ0FxQ3psUFEvZW1XTnBuek5nMENvZzN3eFo0WnZ4N2gxd3B2?=
 =?utf-8?B?MEhFbEYyeTFPU2QwSDh1ajE0aVJ6bXYvT0thQ3VYNEpXaGVGS2JoSFVlQkNm?=
 =?utf-8?Q?Oh06cqqQ9B9RW+/22mfvhD71r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b125ad31-13e6-481e-66b1-08dd7da89430
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:08:35.2166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QPPHkTH1epWm65JIBQa5ik4JZ1kn8a+JiRFqRYbBlzdIdWiFjSLb0Rq5sDwPgA2bDwrn9w5zHA87gU9TJ4v/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374


On 4/15/25 14:25, Jonathan Cameron wrote:
> On Mon, 14 Apr 2025 16:13:20 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping.
>>
>> Validate capabilities found based on those registers against expected
>> capabilities.
>>
>> Set media ready explicitly as there is no means for doing so without
>> a mailbox and without the related cxl register, not mandatory for type2.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Reviewed-by: Zhi Wang <zhi@nvidia.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 753d5b7d49b6..885b46c6bd5a 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -21,8 +21,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> Can do the = {} trick to avoid explicit clear below.


Yes.


>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
> I'm not immediately able to find where found is initialized.


I'll do same than for expected bitmap.


>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -43,6 +46,31 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	bitmap_clear(expected, 0, CXL_MAX_CAPS);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_RAS, expected);
>> +
>> +	rc = cxl_pci_accel_setup_regs(pci_dev, &cxl->cxlds, found);
>> +	if (rc) {
>> +		pci_err(pci_dev, "CXL accel setup regs failed");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Checking mandatory caps are there as, at least, a subset of those
>> +	 * found.
>> +	 */
>> +	if (cxl_check_caps(pci_dev, expected, found))
>> +		return -ENXIO;
>> +
>> +	/*
>> +	 * Set media ready explicitly as there are neither mailbox for checking
>> +	 * this state nor the CXL register involved, both no mandatory for
> not mandatory


Fixing it.

Thanks!


>
>> +	 * type2.
>> +	 */
>> +	cxl->cxlds.media_ready = true;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

