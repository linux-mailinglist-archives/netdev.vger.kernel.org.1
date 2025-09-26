Return-Path: <netdev+bounces-226623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF6BA3090
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF796241CD
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 09:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAD129ACD8;
	Fri, 26 Sep 2025 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GVDxYiOk"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012050.outbound.protection.outlook.com [40.107.200.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDBF4F1;
	Fri, 26 Sep 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758877195; cv=fail; b=XP7C9F0dsdo0q8CqU6/Le9Id2+y6dX69a4t1cEVFreSutwkn5G3QxLCsfjTVYd/pw/Kmac7kcA+ZmOclrmmTlhZ/0CRmQ2op77ZQIfmXUTzjqTVIL0uGX2kxzSHcaHDiCCXOF5zTBQrJV8lg0CfwZdaD0JtYPoCOZNDuutsAuGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758877195; c=relaxed/simple;
	bh=KxbhNPr537gtz/DPIm+zJqT3fr4cMvM06Fv3VOM0Xts=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3XXwkpP2IyBqN+GuWtujqRQOxDE0CJ10VtmRz5r3/0FjYERvnez/PfQeg+hn+uggBW9ew40RrijYKA5PqALdxavjs2S+mQpuFZP4Aa3p+L1qA2oWcFZ5eSdU9bp66eRstGTrwD3gyER/iuYa8SXc2QLGKCcPLfE/huv8/xEE78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GVDxYiOk; arc=fail smtp.client-ip=40.107.200.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QWM5blXBk+7rH68H5yi8Gf043yaBsGkMCGNzgKxn14soC9RTz7ijUR3Ov4G3ZjY752tY1GRsGR5K1SK0gcpV6saz/iu5s2D3S4WL58TtR3n9SorgCAeUvTTpiMa7Tml+CqDgqKDZJ7RW5Si9mh0ey0Irs7h27Jkk6fHo1VwTxQn14ep6Ve70ZYQm8pPLdeZHiWVz9VA391cmNMg8qVn1t4Up/i2a/TTgWd73eiUEqqGAAATylUsV5hBIjQAF7YX0Zuk92c7T7Crrnw+CA4INAH/RUPolPRlScuo1y1cUndZ+/bZIEAQyZADYqJoL656upEhCUEZS8x06tvqVd0ECwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD71Kcn+jEx/RolgvyltpPWR0FpdMVvh3hBnGSr1oH8=;
 b=NRV2/myk8/ri/38oXGnFtWeP9B05tdlElzzTZCyEWC1kScJyc1pL7VrY0gZI5PZMXrG44isVCu31dW/Qw0ouPSq+yBIyWwy+PX3BBsNGag7JkPdXtzb6xZ7F46ijBHduvS2xMD//4EZFYQMYrl1B3oP/ShD7NgjLCIMAwELzzgMsgxNXCj66hLRPKw+SUXCes3Xrboz9ItRDaQbC44XwGsaCUVXudYER0fQIdLjoGO4fKLgMJNNJ+P9NfiCqiK1PvE0eZSE3FBN+A65moJEyDNH/oLfeCoyAKJzU/gpbIQAK0KFZB4Nh9lti4POGW0CrlfI85g9GPnuCSddKWe+7jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD71Kcn+jEx/RolgvyltpPWR0FpdMVvh3hBnGSr1oH8=;
 b=GVDxYiOkzRWYWzFp6KhGuC2f/qkFAKIPipETytqwX1PP+CRjdrbwPKBT06QMXwiTUNe7qJTR6O61W24b6eQJb/F2bLUH/JLLLQgp9DJIEk428Dl08/GqRQnmfhh6YCKIqIssmt+Qo3j8DN/h7Jle7XII0EAUAs2iMsyGO7Lp7Lk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 08:59:50 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 08:59:49 +0000
Message-ID: <1f0e2207-8d99-4eb8-880b-8ba859f8e86a@amd.com>
Date: Fri, 26 Sep 2025 09:59:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 16/20] cxl: Allow region creation by type2 drivers
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-17-alejandro.lucero-palau@amd.com>
 <a3138cd0-455c-4247-be4e-c8f4f2c71e33@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <a3138cd0-455c-4247-be4e-c8f4f2c71e33@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 5530c698-ae21-4dce-a3f9-08ddfcdb0ca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0VxTUtTT2piS21DVkJRcjJhYUEvVmVOL0lUaEx5bWZDa3VFUi9tU01obE1Z?=
 =?utf-8?B?VXRzT2d5bTR6Ky9MejA5a1lHYXNJamlNYXB4dTdCUlFFK2xRRzVMdTVPMmZ4?=
 =?utf-8?B?dkNOcnJZSjkzYjllMjdvV2VUaEhjRGx1dnc5WVJPOS9pV2pNNzM5OUlXQWdu?=
 =?utf-8?B?N0FHRnluOUFVNXRLQUNuM2M0R1RLZkw4OUVWcVZyU0M1V0ozZHN4N0hXaWVM?=
 =?utf-8?B?dFVnd05HMUFScFFDc0licnBYRCtmbHJZL1lReTFQOWVVMkp3bVZEYTEwT2lJ?=
 =?utf-8?B?RlB3OUhTWUtlOEF6RXVjYnA3S1JMWktTOVZQMVpxaXZSWFNvS2tNODNGdjdR?=
 =?utf-8?B?Nk1YSG9PcXFVYmxyanpQbGZiQXI2dEhqZExOMnpOMi9PcktpREIvdGduQ0hj?=
 =?utf-8?B?R0paekl3N3VQdCtHc0JGaERqRjU5bWx0SWl1UDVqM0Nkd2VTWWJTSFo3d1lz?=
 =?utf-8?B?VHdFMUdXdWt0YUpKMnBvWUtuM3lXK084bW9ZL3VLYnBIdFdlY1Z3WVlmUHdn?=
 =?utf-8?B?Q0VVem15OElUbnN0TlVONUd6bEtWMHNCTmhRZ1lYSTNDeFFGN2dFOXFzNkhY?=
 =?utf-8?B?ejJhLzNJaDZMTG9IdFZYeFJPalhOdVNpSXRieVZRekxraWpzYytVM0tkM2hT?=
 =?utf-8?B?dUtiM2w3WWpWSHM4d2NYTGlBUHppb1ZZWmVuMXBTVnJIVEh2NVUzVUZzTkhm?=
 =?utf-8?B?UDRJWjBGOXNaanoyYkREK2FoNlV2aEFyei95RHFZdFhGSlNHZm9IbDE5UGRY?=
 =?utf-8?B?ZDNLRnZ2dGdsSitkazJEUUZjSzNpeXJ3VjNHTlMySlhEVXhEYWdFQ0V4cGNK?=
 =?utf-8?B?SXdoekEyMjRzdGtEek1XdTREK2R6NXZwT09FVkI4L1RGQ3FqZS83V2xvc2Fo?=
 =?utf-8?B?K3V3Ynh1N3FvRkV4WGFqV2ZuQUxqc3A1clhYY1lueUR5Yjhocy8xUFJCR3R2?=
 =?utf-8?B?OEhYOTJXWjYwYlgxQ0VKWlora3l2bTkyNFZoL21mN2dTdFNEWGxRRE9NWFFS?=
 =?utf-8?B?V2xiQWV3VXN4QkUyRlpyOXk5eXhKQ1BkVTNCZXpXOWtlVW5oWmpqS2NKdWdN?=
 =?utf-8?B?djNTMkF2VEhoQ25wWmN6aUZJdmhVRXU2S2NJRCs5VDJSSC80dlNSZmtXcGdS?=
 =?utf-8?B?QnlEL01Rb3NCOE5qNnVyWDAyV2RzU3lyT040SVU4T0lBL0JGcXVqbmljRGJZ?=
 =?utf-8?B?N0IyYmtQSFZ1MVVmMEJ4UmxUY1lZK3BxSXJnSGpkODQwbFFGdzE5UWJqaE1v?=
 =?utf-8?B?akNwb1dnWVR6b2tYQWltVUx4UEJ2Qk02NEZkRGl3V1h4OWNsZmN5TXdPQ1FI?=
 =?utf-8?B?K09uMjd5M1ZlK1U1UFNiK3VzSTR5TFpUMy9wNHNXZC9zdXYzRWZRZS8wVmht?=
 =?utf-8?B?Syt4d1dEOWFlQTgrNml3MEVmYzhKbWxyMGI3NXl5V3lPQVppTVYyUHlBL2Yy?=
 =?utf-8?B?MS9vQkFlbHJUMlEyM05hd1hRSXJKVFJOMEVJVWljWlhUdFNnNGhoMWdTSTho?=
 =?utf-8?B?TkZMU0FqQkJFbHhqUTZYV0JlUlMzeHNrNS93RnVnZ2p6ZlBEZFVVR2R5ZHdL?=
 =?utf-8?B?NzFxZXFoZ1VLNnh4Yy9CbHVHV0diTzBUTHNpUjR3R3JUM2ZBWHgzWXRyYkhV?=
 =?utf-8?B?ck5PN1VQcjlsTmZFNEp4SWg3b1FMTnd5YXkwcEhTaVJsOXc0RXR1elEzTjFU?=
 =?utf-8?B?ZkNXUmRWNnEydHJveFE2L0lOdnFJeEpad0JBaXUwZGg4ZWRBMTlrTXFlVVpW?=
 =?utf-8?B?anc5dG1ONmpNYjhGNGcyNk9HTzNYNmZQa09MUXZIRzVob0kwK3FSSXhXN2hG?=
 =?utf-8?B?VklTMFVhTXBMalVJajJreUpBSy9JSUYzVmZuLzc3NHB3dkNleS9Vb1FaYSs1?=
 =?utf-8?B?YU95czhXTlJQTEVNbDFueXhuR3U3UVVxMTN4Y2xsS3JyTUFkdGc2L1pDTVZZ?=
 =?utf-8?B?TjY1M0pVSVlJVXpuZldnQnVlRk9wdTRQa3hVZVZZUFJXaDdIVys0R2NNTXBa?=
 =?utf-8?B?eUxXOTNnMlQwZmZ6WlptNkovdjdTakg1UjJjNlhzbWd1RjFmai9HdXl4d2RI?=
 =?utf-8?Q?mn/4J9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFYwOWFhcGVPY2loL0Y1YVNBN0QwQ3FlVVZ0dHpOa2pNV2QxL0tNWkhzNU8r?=
 =?utf-8?B?Z2ZkckcxekNVRVIzdWg2VlJ5c2pUNmpWdXpkYVhJdDNEMjZIQ241N1c5R2JQ?=
 =?utf-8?B?azB0cTJBb2VSRldOWWNLOWVYUTh0ZDNONHg4ODR6a0tDeGhyQk5VTjZ6aEVE?=
 =?utf-8?B?RFNHOG1CU3JxUFRSaDR3ak5SWnRSeDIrTXI0aFhBYUo3SzExV0MxaGt0bUMv?=
 =?utf-8?B?OWZRWWxnb2d3Sk9NZVVrdTlPTUtkM3ZzRDBLa2gxcDdyREpCWWxEVzFLNjNU?=
 =?utf-8?B?L29UaUxSbnNoK0FkMjBxQXhZQ1E1bi9ma0twcmFPcWd2RG5PWVBXTDNQM01n?=
 =?utf-8?B?bmJUczNhUkJTT1F3SHIwSUtldk14U2I0Y0JNNXo4bGdWS0JjRkZJbnF3bDZ4?=
 =?utf-8?B?UFNjNHdDRC9GY09EMzFCQzVWRVpIbjNaR21KZ3ZpZDgxNUQvT3poK0pOWXZy?=
 =?utf-8?B?WlRZcVhabTh6UVliMHAvTDFKT04zTWhDR0dpUXpGMHNkbGp5QjNJNC9NRXpl?=
 =?utf-8?B?dnhZbk1CbVFoK2sxSTdlN2w0R0NuWDRUeXVIODUzc2VRaVE1c0doNm1kZDNH?=
 =?utf-8?B?Z1pwL0VacllsZUlsRkNpekN2UEZIYThSUGdKbWJsV3Nid05QQjlQQWhCR3JU?=
 =?utf-8?B?UzBNUnY5SVBFaDRoVUsvYjVaMHVPTWprTFI1UXpsdUljR2lTNmFER2VuZlFv?=
 =?utf-8?B?VUtDUkhGNjZZOGZDcVMxYTlnZUN4NE9QN2h2ZlZBT0poTExNM1EybkJBR3R6?=
 =?utf-8?B?WVdydUcwcVZDeFV4TnBUZTdsaGVUWklIc2JFUGc0Q2VnUEh3eFh5b04raXFz?=
 =?utf-8?B?aEt5eUt1a0s0dVFQSTVpaU5YU0FiVjVoZnZhU1plUjYyWkZMSTN4cHBTRTc3?=
 =?utf-8?B?ZlUxcDI3b2pieWdJekU2V1Y3V1cwYWMyRW9Ga21DUFFFVEJuc3pkcUM3RmE4?=
 =?utf-8?B?RlF2ZnhSSUJMeDJTRnd4UFVxdCsrZFpWblhhVXBtbmR5WDVKeEdMU2ZrL3Y3?=
 =?utf-8?B?ZWJmSnVtUVBNVzNDemxiMnY4aGJKZC9RZlZxSURKdFlJU2VJYXNjQlVXMzNw?=
 =?utf-8?B?QmtJbFVHOTM2MkE1UVFKRGZDWmVmeG1nZXdtaFE4YmRPQzNXNms4ZjBDQ1d5?=
 =?utf-8?B?eWVaUUQrUGxZY3daN2pRZXFmY1hhSk1uZTZrbWJ2WmwzZCtIWnJzMDBSUHZI?=
 =?utf-8?B?ODgwKytaT1lFRnhhL21HeFluMGdqeGVLL0NHYjhSbkdlaXovc1h2SGlHL3JW?=
 =?utf-8?B?Uk54Ni9SN2RxN3dFM09kVTg2dXVlNmQ3cjI4MnlBSmZwNS9ySlNrLzB3cGtp?=
 =?utf-8?B?QkFVVzZlWkc5NWZMTzk2SFpWMFQ4Mkw4MlVNT1ZmTXZjM3l0WnJXd3VNd25a?=
 =?utf-8?B?M3AyRW1wSTFPTTliTmo1RlNaMTdZNzgzMm5jV0dmQVZjYVRzRWVPSkdHbDNX?=
 =?utf-8?B?YnZxN2hjZUt6dlFlOGZJL3Y1Vlo5ZEs0NEdtZjZLSVJHdlRVZVFJSDdRczZv?=
 =?utf-8?B?SVMzYUN0d1VXNk55OUVGeHlyZStPTjQ4Q1VqSHI0Z015N2tpbHVWN1pHc3hp?=
 =?utf-8?B?SHVKWEZDVGs4SWo2emVhMFdLakZ1YnpML3k2M2dsNUpVZUhNZWJwTFNOWXlw?=
 =?utf-8?B?VDZReGZFZVc2TUtZSHRaZlRlWmw4cjdsczV0NjREbGh6dFRKSnNHT29weUh2?=
 =?utf-8?B?OE1QRjkzZ2NCbFZrMXJqenhLbFIxM1hlUHVWbE1WWnpURFk0T3VJQ2lDVmpW?=
 =?utf-8?B?cmMwYkNhZm54MmkwZEpuR3ZKQk1wdWJJdi9YY3dBbXpOVGsxT0tTdjg2YWpB?=
 =?utf-8?B?WDNYZ0NUdkZDRUZtenI2Y3BVeWhVaVF6Q0txUlFsbVUyVlkwN1RnV2txOFFt?=
 =?utf-8?B?UzdDMVBaUm44S2IvUnhZbDAwTFdLek16aXJXOThBZ2Ura3lGazBabk9kTEwr?=
 =?utf-8?B?dW9DT3Z0VDRXNFZRbVp6elVIV2NockliUUV6YXZSL05QYXJvZHQvVm1EZnNM?=
 =?utf-8?B?MllnTDliK3VleklvREJrNEFoUkkrcnZJN1IyT1ZNWEZZMTFITXpZTE92Sm5Z?=
 =?utf-8?B?ODgvVDBOTXpPbDVCcHdXUjRMbUV3djgrTXNoWG8veW1oSUVTdENLK0JRbnRL?=
 =?utf-8?Q?OHlegjFCov3M6XOeuACxDkyf0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5530c698-ae21-4dce-a3f9-08ddfcdb0ca6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 08:59:49.8423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XfSQk5lQndorvrphw24txSywEmYKxzD6wkcJnrOYtlq1G+rM70f4v7spLEreSRN9vPgXhug4A9HJKHpIevTTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465


On 9/19/25 21:59, Dave Jiang wrote:
>
> On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Support an action by the type2 driver to be linked to the created region
>> for unwinding the resources allocated properly.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++--
>>   drivers/cxl/port.c        |   5 +-
>>   include/cxl/cxl.h         |   4 +
>>   3 files changed, 154 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 7b05e41e8fad..20bd0c82806c 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2379,6 +2379,7 @@ int cxl_decoder_detach(struct cxl_region *cxlr,
>>   	}
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_detach, "CXL");
>>   
>>   static int __attach_target(struct cxl_region *cxlr,
>>   			   struct cxl_endpoint_decoder *cxled, int pos,
>> @@ -2864,6 +2865,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>   	return to_cxl_region(region_dev);
>>   }
>>   
>> +static void drop_region(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +
>> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
>> +}
>> +
>>   static ssize_t delete_region_store(struct device *dev,
>>   				   struct device_attribute *attr,
>>   				   const char *buf, size_t len)
>> @@ -3592,14 +3601,12 @@ static int __construct_region(struct cxl_region *cxlr,
>>   	return 0;
>>   }
>>   
>> -/* Establish an empty region covering the given HPA range */
>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> -					   struct cxl_endpoint_decoder *cxled)
>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>> +						 struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> -	int rc, part = READ_ONCE(cxled->part);
>> +	int part = READ_ONCE(cxled->part);
>>   	struct cxl_region *cxlr;
>>   
>>   	do {
>> @@ -3608,13 +3615,24 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   				       cxled->cxld.target_type);
>>   	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>   
>> -	if (IS_ERR(cxlr)) {
>> +	if (IS_ERR(cxlr))
>>   		dev_err(cxlmd->dev.parent,
>>   			"%s:%s: %s failed assign region: %ld\n",
>>   			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>   			__func__, PTR_ERR(cxlr));
>> -		return cxlr;
>> -	}
>> +
>> +	return cxlr;
>> +}
>> +
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>>   
>>   	rc = __construct_region(cxlr, cxlrd, cxled);
>>   	if (rc) {
>> @@ -3625,6 +3643,126 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   	return cxlr;
>>   }
>>   
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled[0]);
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	struct cxl_region *cxlr;
>> +	int rc, i;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	guard(rwsem_write)(&cxl_rwsem.region);
>> +
>> +	/*
>> +	 * Sanity check. This should not happen with an accel driver handling
>> +	 * the region creation.
>> +	 */
>> +	p = &cxlr->params;
>> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> +		dev_err(cxlmd->dev.parent,
>> +			"%s:%s: %s  unexpected region state\n",
>> +			dev_name(&cxlmd->dev), dev_name(&cxled[0]->cxld.dev),
>> +			__func__);
>> +		rc = -EBUSY;
>> +		goto err;
>> +	}
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
>> +		goto err;
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			if (!cxled[i]->dpa_res)
>> +				break;
>> +			size += resource_size(cxled[i]->dpa_res);
>> +		}
>> +	}
> Does the dpa read lock needs to be held from the first one to this one? Is there concern that the cxled may change during the time the lock is released and acquired again?
>
> DJ


Not sure I understand the first question, but IMO, this is related to 
more complex setups than current Type2 expectations. I expect a single 
CXL Type2 device and without interleaving. This protection is needed for 
a cxl region backed by several CXL devices (interleaving) and where user 
space could try things in the middle of this setup.


>> +
>> +	if (i < ways)
>> +		goto err;
>> +
>> +	rc = alloc_hpa(cxlr, size);
>> +	if (rc)
>> +		goto err;
>> +
>> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
>> +		for (i = 0; i < ways; i++) {
>> +			rc = cxl_region_attach(cxlr, cxled[i], 0);
>> +			if (rc)
>> +				goto err;
>> +		}
>> +	}
>> +
>> +	if (rc)
>> +		goto err;
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto err;
>> +
>> +	p->state = CXL_CONFIG_COMMIT;
>> +
>> +	return cxlr;
>> +err:
>> +	drop_region(cxlr);
>> +	return ERR_PTR(rc);
>> +}
>> +
>> +/**
>> + * cxl_create_region - Establish a region given an endpoint decoder
>> + * @cxlrd: root decoder to allocate HPA
>> + * @cxled: endpoint decoder with reserved DPA capacity
>> + * @ways: interleave ways required
>> + * @action: driver function to be called on region removal
>> + * @data: pointer to data structure for the action execution
>> + *
>> + * Returns a fully formed region in the commit state and attached to the
>> + * cxl_region driver.
>> + */
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways, void (*action)(void *),
>> +				     void *data)
>> +{
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	mutex_lock(&cxlrd->range_lock);
>> +	cxlr = __construct_new_region(cxlrd, cxled, ways);
>> +	mutex_unlock(&cxlrd->range_lock);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	if (device_attach(&cxlr->dev) <= 0) {
>> +		dev_err(&cxlr->dev, "failed to create region\n");
>> +		drop_region(cxlr);
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +
>> +	if (action) {
>> +		rc = devm_add_action_or_reset(&cxlr->dev, action, data);
>> +		if (rc) {
>> +			drop_region(cxlr);
>> +			return ERR_PTR(rc);
>> +		}
>> +	}
>> +
>> +	return cxlr;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, "CXL");
>> +
>>   static struct cxl_region *
>>   cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
>>   {
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 83f5a09839ab..e6c0bd0fc9f9 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -35,6 +35,7 @@ static void schedule_detach(void *cxlmd)
>>   static int discover_region(struct device *dev, void *unused)
>>   {
>>   	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_memdev *cxlmd;
>>   	int rc;
>>   
>>   	if (!is_endpoint_decoder(dev))
>> @@ -44,7 +45,9 @@ static int discover_region(struct device *dev, void *unused)
>>   	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>   		return 0;
>>   
>> -	if (cxled->state != CXL_DECODER_STATE_AUTO)
>> +	cxlmd = cxled_to_memdev(cxled);
>> +	if (cxled->state != CXL_DECODER_STATE_AUTO ||
>> +	    cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>   		return 0;
>>   
>>   	/*
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 0a607710340d..dbacefff8d60 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -278,4 +278,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>   					     enum cxl_partition_mode mode,
>>   					     resource_size_t alloc);
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways, void (*action)(void *),
>> +				     void *data);
>>   #endif /* __CXL_CXL_H__ */

