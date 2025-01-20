Return-Path: <netdev+bounces-159812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435CA16FF0
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED1D1887D6B
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD961E32D7;
	Mon, 20 Jan 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cJ/BnGJO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B87200CD;
	Mon, 20 Jan 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737389813; cv=fail; b=huyHZnjYjSEaaLoIsLfjC6YVrjN9SWsz6kuCw8t47IxktGxw7QJ9qnptFIAr+34jfHQVFOWTGJ48ELvKWajw3w/udmuOr3mCYSsfTDFkruvaCsHvEKZ4AuwU2id7vVx3J/gKUS3wzy9q1ceVY27Lprr3s9g42QHiY8yTynlDqjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737389813; c=relaxed/simple;
	bh=iW7Bx9Ftl6ZNdLStTKV71kGWc21u+SIRUc/LsQGK6n8=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z+2U2PPXj/VWw+2QaSMnls6KP+CeT1du+7CCvUOmzJw0j9JaM8AZuuOV8wpaNL1r1Mnfb02Y4FUqsblj08ibX9ikf2UuhdtIHrBqgtBVnAwYBr1irjf5igRsG6u8IgpoTMEapnhdZe/QWw0skHy+X3i7lZgWkzetMDXkqsri/3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cJ/BnGJO; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIyxxLhk8ie6L7iio/tVelF8Xn/W3BqyvOko+JNJjHw59XUy4w98q6pyNRY97lTfwSpc2XrgPU4mKNbJyZAmLvmtUJZQqmixw0q94m86nQ1WPi2aeyyQZZpfpfb99NxJeL3ZOeAIcKEkA/wkiLMmAsQz82scv+yKXdlwtHa4I7SaEFKpOjcBhWYEVM5rwCIhb9i2mdyJgl2dAGWb0nZMtkwf6jENxp03WuWwliVt2b03/Wm4SrbZERe9+AX/gvQVETj10MJ5KkY5i7NJC2LGwNAzEG1lqPsganu4z/2KGuF6LTMYRdAv5XmQpkvnZhaHn21ijNi336LSOa/7X5VJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8LprH4P/ea2UEqL9z1up8CVkEcxCyNT7SNlv+Y8V28=;
 b=SEGsXQdcQO3oTYesvcEmZ50JyWNsvlHfi21Ma/2eUrwSkNCiPJ3obxknKScsaKoWhV1bryn80+SQih0dxR2q3/EYT5Nj6kTRpbJBC4FivJvDMeB9xdH8r3AmCWPwjQCx9tVT2puGryPcqS6g5AV+XFs4XULKM2ePxyjTER+vzx4MNH9bYIMrhpYb2okaOmn9Wjetco/Kaad3xEhOvpA5jjP8Eq9T5gcVTQ5H37zNKUelUlx/+bjqcn3Uue3UhIwvptYOC4qkmL4/qumySH62dt7sXh0nhVCDFm46UTZ2FnaUKOHj1QPb69HXH2iERGe20x0DyvuHkHaGG8cX08vuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8LprH4P/ea2UEqL9z1up8CVkEcxCyNT7SNlv+Y8V28=;
 b=cJ/BnGJOH59TV4lZrTqnq5PPqOHEO6kLFn5A9HZ0dbw6xhTvpt2lCNIDqRx0qxVknIczgo+IapubOrcUnqce3vmVtDixu2jwqG/sidS1r5XAmnvLUogrLEJGSLJVLNJ6EdHQ3gkGRQm91wZ1kCkj2jtU8eaKgyIPb6t76x4zCcM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 16:16:49 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 16:16:49 +0000
Message-ID: <09d6b529-57f3-290f-7e92-0291cdd461cc@amd.com>
Date: Mon, 20 Jan 2025 16:16:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 10/27] resource: harden resource_contains
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com, bhelgaas@google.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-11-alejandro.lucero-palau@amd.com>
 <678b0c0ca40ca_20fa29484@dwillia2-xfh.jf.intel.com.notmuch>
 <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
In-Reply-To: <fe48e2e9-5a13-78fe-d8f6-6c3faeecebcc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR2P278CA0047.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: a3879579-a461-4a8a-f66a-08dd396dd7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1FmdXYvRUJ0eWRxcm1FTEtXK3E3OUhIaGltMWt3L25WRUFzSmVMME05N3hv?=
 =?utf-8?B?QzdzNmxjMVQ1MStkRmt4dy8yM0hpcWdQTk5WaFN4R0VLRTZvT00vZDVsNzBh?=
 =?utf-8?B?VnRWZXQwRWI5TXVJbkhiSDRrSks4ZDdsdGFNZVZ5S2RmbjE0ZFVoU3piVXhV?=
 =?utf-8?B?dXNBL0s5Z01jOUZWeDFLaVIvU1NkMkhHMkpXV0IxMzZjY29UWTB6YUtYNDMy?=
 =?utf-8?B?SFp1TGVTKzZPQlBMVGZZMmh2UkFsWm9ndmhHZDBMUDR5VWh4c3lJdUltbWhQ?=
 =?utf-8?B?aGdpQzgwVGZabWd5dEk1bHRna1pjOVRIa3hrbEMxc1ErNmdqeUxSVmlKR2gw?=
 =?utf-8?B?bEV5SjVMUmJxMTdnTkI4NnFJZ2dWKzRUSExKejlmNE5VaHV5Q3UvWkNLdkU1?=
 =?utf-8?B?ZkJVV294a05US2ZsMUF1V3YyNlprNmR1V200SGF3T1hKYThSWGNOTWlkMGdV?=
 =?utf-8?B?dWU1TCtWd2RWYitnREhZVmRsc1FKbXlPYmpGY3p0U015OWVaTDBVRVVvL01m?=
 =?utf-8?B?T1ZzcW5QbHIvL3YwQnpPNE93UlJKMStubDBSM0pKT3QzZkEvVGtlTVI2Nm1u?=
 =?utf-8?B?RGJucEtDWGpwUnM1QXlNUUp6UVc1R2pzSDArRktmNEFUSEkrN09keTM5VDM1?=
 =?utf-8?B?bW0zREVna242NjBuYVpoNWJJQ3JZTVhYY0IxaUxpNGx4WkxWbzMwZ3lJeFUz?=
 =?utf-8?B?a0ZzNHBaQ2h4YzN3MWl2K1h0azNFRXNPWGR6OXRpNHRpbjB2NmNjL2YvQUNU?=
 =?utf-8?B?ZVZ2eUNQTWd3L3BKRksySCtCL0ZCYnJEZFJoRGVnck5sbkg5amQ0dS9IUGpw?=
 =?utf-8?B?MGNYNVpmYlpxazFBUlA4Rjh3bUhIc2h5OGx3dzlSMTl6eFRIcUE4UForakc2?=
 =?utf-8?B?ZmlLelNKN3ZuS01yMFFyZXRLQ2VNQ3F2WVpZbHNEdExEbXBUL0xiTDFpRHU1?=
 =?utf-8?B?Q0N3aVl3RGt5V2dXWCtSWG9DMEtMangrMm4yR0grR0FFUEhYeWRUUTMzSlM5?=
 =?utf-8?B?eC96SVlhb3lFNklYY05YVUg5b1BHOFV2T0R6VklIemZET3NzRjE3UTVnd1Rz?=
 =?utf-8?B?TStyaDdPeThCaWlUQTliVWlJSG9jRnZlYjBJMGlRa1dGaE1NOEg1eTJLOTJN?=
 =?utf-8?B?dC9BWENsUmZKNnVWVHA3SzhpQ2RlZnNJWnZQcVR3Wk1sWjFwdzl6YnczZkp4?=
 =?utf-8?B?VEhpRTRBU3VaMkVJc0Y2K05DMWtabzVVUmtLdU5acnRPWXBleUFnajVpSVhL?=
 =?utf-8?B?MnlCbVN4QVc4Sno2TGFneTZUVlp0OTFhYTcyYkEyeFUxTVErcjFCdWpWSjFr?=
 =?utf-8?B?UzF0NUZTTldqSzJNRGE4R1pJdVJuV1hvRzR3QkNVQzl5TExZeHdnSDA0cjRD?=
 =?utf-8?B?a3RFeDRHbEdFV1JkeWZkc3Bha0dmZHZuWWZlV0d5ZTlJbUhRN3pKVzlIZmZM?=
 =?utf-8?B?WWZUV04yWnNLS2p6WnZiU2FkTWhjT0xaU2JXcFAzMW81OXhpYjN3dklyNXRJ?=
 =?utf-8?B?R3pCdWFqOXFSc2xCcWw0ZlV0dDJkd2FzRTR6NlQ1NUpGQTNtK3BOTUwyV0I2?=
 =?utf-8?B?OFVTN0Ezbm1LQVU0VUJHVDNxckFkMnNUV3BrVlRzZjBUQ2JSVC9FVjBnYTg5?=
 =?utf-8?B?Y1VFb0c0TmhOdStmNTZ1WHljT0R4UDdhZVl5dXFRWStmYzljMzJFMjJCRVY3?=
 =?utf-8?B?SklCMmErYWc3YUh6QmhWV3ZXb3o0U2kzalM4N1o2ZTlwT3RwVHhUZlE4bnI2?=
 =?utf-8?B?TVVsaW01REtHQldDSHVrbFcyamhwVGcrU3N5RkNKc3BhcjRSYzFKQjBtbllv?=
 =?utf-8?B?SEZQT001dTB6QjI4WG05d2lwT2p4SEE4eWZ4eTZxSmNOUzVlcXEvNG5Tdno4?=
 =?utf-8?B?SkJlRkI4dUFPTmdhLzFYMFhDYW9RREk4NnRSYlByYVRlZTlFWnlTTGQ2dTkr?=
 =?utf-8?Q?V7PnQG7Wcqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWJFMG1DRmhXaVh5cGdDWVlGVTlUVkRCRFhHRlBOUzhiWlc0ZUptcVpjbWdW?=
 =?utf-8?B?M3VITHlEeUc2Q1kvSzIzclRKVUNid0Z0K1IwR0svcGlPRlRMR0dvYjFvOG1G?=
 =?utf-8?B?WS9CRUsvNmxlTmJUd1dRVnFWQWdUOFl0dkJxT0xyL0hBRzlKb2QyOHhiYlEr?=
 =?utf-8?B?MW5ZTHpJZy9jVGxycnV6NW5UQzUraFZ0Zmdlc2t0QjJjRHgwS3R0VHU4UDlY?=
 =?utf-8?B?L0t6L2FrODN4RW13d2xtTERla0VVWHB5WHRqT2pFbEV5Z0RYTVA3NVBIaDNw?=
 =?utf-8?B?am16WGErcHZLeGQ2Mi9sVjRLLytoMEhmRDJ1cnVLTXMzdjJxRklkYW80V3E3?=
 =?utf-8?B?YTRLMEU4c3RDSkkvZFhaU1kzUWNjQkd6SFd1UDFjd1k5QjlVZkgzbW40S29I?=
 =?utf-8?B?SWIzQWZqUzFPalN6bXpuZW05djNVQjlNM21XVGEyZ3h4ckxLR0w1aEFGVmxG?=
 =?utf-8?B?ZHRVNHN1WkRCdE11V0lCZzNlWjF0S3ZidWxLbnJ4RitwVzE0Y2FPV25WNFV5?=
 =?utf-8?B?eW1EOXlxR0tXc1NBVHFrbHBKOFZQNjgxTUJUNnJ4S0UwQzdzOVJsS1lTU0Vl?=
 =?utf-8?B?OEZJeEhXNTI5dG9zZTZFcHdCWWhydlQwVXBLYVlYU056aVVZQ1d6YkZBUDFI?=
 =?utf-8?B?ZzhPQ2Y5OHU4U1dtOEZ6czcrSHFqMGdpNHJ5ZFZkMVJpSjNVUmFCa0tCS0hv?=
 =?utf-8?B?bWFma01LT2dUSlJ5MG00b0FaTVpDeE5HV1huaEtWVnN6K201VDlWVUprZkxP?=
 =?utf-8?B?dXBvVDVVRThUYWNZbFlSMEl4V09ySVdpL1VRTG9tcTJ2cW9wNXZsS2ZaSkgx?=
 =?utf-8?B?MWM3SDh6cWJKck1lM3pKandyWkMzbElQZThnaGZBWHluajgwd2VqeGk1Q2pD?=
 =?utf-8?B?Z3hiYW5nZHZlVzZiZng2U0QrYWFmTHo4L0tyWHh5OEwyWjJFMTFucHIzd0xr?=
 =?utf-8?B?cUtIWGlKWDd1SytOMytPaDRxNnNJYm5KQ3hMR2hCaURXSk9hOFRyVkpvWmtv?=
 =?utf-8?B?RVFMVk9USEtCY0JwQ2d3bm5VK3JQMVFwUnVLR2tKY2JaV0JCQmFmN3R0UDNw?=
 =?utf-8?B?T05sKzdaYWFCWlZxWVhHK1Q5SWRpM2Zzb1J0aWlQRU51UC94YmhaM3RiT1RX?=
 =?utf-8?B?SVIxRkFLaHpjTUlheGJaWWMwdDVFZ21HNDR0WlFQa0tLbkdySTZFWU56Tlg4?=
 =?utf-8?B?ZnI4bXNJWDZ6clA5UzFIMlVvV3QwSy8rRmFKMS85b045TkI2SGJsT2JXTkRE?=
 =?utf-8?B?SmdPc1NlZlZUak9Wa3lKNHRTTURoWjFPWHJuUWtJZ2tqUFhJbEVZcTRDbmZn?=
 =?utf-8?B?M1hqMDZoc3BQZkduSHgyKzlsc1ZyU0xLMFB0U0IxelRJb1N4cDdqN25vZkQ5?=
 =?utf-8?B?Q0U3WlkrVDhvd0JQVHFIbWcyNHZNTHdTcVdNSlhSNHpXemtGcVg4cENWOHFF?=
 =?utf-8?B?TERDN1FIejVrOVB4UEVIR1V4bmRwbnhYWnVGeVY4VDlhR3B2Qk0yYi9xNHpV?=
 =?utf-8?B?WHJXMnJaQjVmK1Q1bG9yN0RuMjc5bDJFWFJUVERJRlNwQ3ZqdnBkdFBBR1ZQ?=
 =?utf-8?B?SENQRkVXSk4wQmd2a0E3UzBRcmlyWExIS3JOWmlmYnp6WnpDNzZsdTJMWUVC?=
 =?utf-8?B?Q0o0cDVCTFJWc3JLYVplaTBtU0pWSGswK3VNdHEyb2ZHMHYwdkkyY1VPYjN6?=
 =?utf-8?B?ZHRaTjJHbkQzRkgwNXBCdGM3Nnp4czhBcjdWTHZXVmZYVTlSWFVIQ2JxTm5T?=
 =?utf-8?B?VjJPYnpmVkFoWlhPQ3N3QWoraGlIbitrYml3ZnJOMzA2eTNxVmRZVFpKbFQw?=
 =?utf-8?B?TG5hWTJ2YTZ0bHU4MzB2WXJSV25ySDhPK05JbEtWR2E4M2tYTUxRZEZhQlJC?=
 =?utf-8?B?bk8wY2RvK1ZoOE95YjNQQ1JPQks1dXZYNVFIMmRYQlE0N0RoN2NUWGRJYWFm?=
 =?utf-8?B?OXczcmdlTU5QdklwRlBXY1N2MEg5cW1pY0EvNlpJdGpyRUtTdTJoU0V1c09x?=
 =?utf-8?B?SW5YbVhEN3Aya091OGdnSGxWWjlLd0FvTERMVjc4M3dzQzZNY3BlMHpVMEcr?=
 =?utf-8?B?RGhWUTgwcWJuc3loWTNCSG1tbmZOU0hoQ3I4M1UraDdXUjA0N3p0YVN5dHNp?=
 =?utf-8?Q?n6xz8259UMFRk8lyVCYQbvHbp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3879579-a461-4a8a-f66a-08dd396dd7f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 16:16:49.6733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1AbHeL9bDG/7b1nnl/qLk+XIcewHUFK8girZTGdCdBTiFt18sjK6BJZQup5RXj9RP1iIYx/9wR/eUbRGCTayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144

Adding Bjorn to the thread. Not sure if he just gets the email being in 
an Acked-by line.


On 1/20/25 16:10, Alejandro Lucero Palau wrote:
>
> On 1/18/25 02:03, Dan Williams wrote:
>> alejandro.lucero-palau@ wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> While resource_contains checks for IORESOURCE_UNSET flag for the
>>> resources given, if r1 was initialized with 0 size, the function
>>> returns a false positive. This is so because resource start and
>>> end fields are unsigned with end initialised to size - 1 by current
>>> resource macros.
>>>
>>> Make the function to check for the resource size for both resources
>>> since r2 with size 0 should not be considered as valid for the function
>>> purpose.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>   include/linux/ioport.h | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>>> index 5385349f0b8a..7ba31a222536 100644
>>> --- a/include/linux/ioport.h
>>> +++ b/include/linux/ioport.h
>>> @@ -296,6 +296,8 @@ static inline unsigned long 
>>> resource_ext_type(const struct resource *res)
>>>   /* True iff r1 completely contains r2 */
>>>   static inline bool resource_contains(const struct resource *r1, 
>>> const struct resource *r2)
>>>   {
>>> +    if (!resource_size(r1) || !resource_size(r2))
>>> +        return false;
>> I just worry that some code paths expect the opposite, that it is ok to
>> pass zero size resources and get a true result.
>
>
> That is an interesting point, I would say close to philosophic 
> arguments. I guess you mean the zero size resource being the one that 
> is contained inside the non-zero one, because the other option is 
> making my vision blurry. In fact, even that one makes me feel trapped 
> in a window-less room, in summer, with a bunch of economists, I mean 
> philosophers, and my phone without signal for emergency calls.
>
>
> But maybe it is just  my lack of understanding and there exists a good 
> reason for this possibility.
>
>
> Bjorn, I guess the ball is in your side ...
>
>> Did you audit existing callers?

