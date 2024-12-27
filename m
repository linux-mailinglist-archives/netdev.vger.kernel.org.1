Return-Path: <netdev+bounces-154355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5B79FD2F6
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 11:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A8283A06F2
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 10:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01D1DC1AB;
	Fri, 27 Dec 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d9XWgY0N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAB1D319B;
	Fri, 27 Dec 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295035; cv=fail; b=OrXWTkvhC94uIpoAeHqj+ViumdnR4IPyk0hIvNN7aKm2g6X9sTWf0CceTKHNi/Gd+CRwS5A2q94sLLcJoigNPcMnYIxXk79PWZv9sPnMIIuC5QIKhIpJg78ZnLTGm3DTuM5RV/IRflg9y6jc392QtP7sji+63CT1UmCOWnwDWn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295035; c=relaxed/simple;
	bh=hvsRYsH3IrQTn4sZi0WbGRoHrZGWwMOHD11vc9JANFA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ObpqGdgQ6bm9Lo2fjx3Uq0Yzw8QRFRV8tteh2vbEnKw4B5OlBopZ5xd9v9g7dzN5WXLN9U6rDzuYS1zsJ3Tu8w65S+W6URxlHaJG0ATj4N685NjzFl8uxqvjTSHE0DhfKejTvnH5d95Xu+PK5fi25Uh/aNg7rIwWXlS34Ddn1SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d9XWgY0N; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mToLw/gEJTH0Yc14VSJO8LhXZYneycPgVNrpL4gPa8TgCdgjeuJzxooseswZB1kKiSCEyWgZou9+Wx9cps5JjwwnQxf6gvf4QWJf1tQdCV/4Qeh9DJC5KyYpkCn8mRFcbApS0VHlgQ4+BLlpwMT9vqFANYSs0bRdqCqo9hljyMRccOUHMiNYqRv+Q3mW4UNxP0D60vLBW9UpAAxuRI8PRGgH/WXF2TuQBTV2EQ03x94NaNlHG1Tv4xS6Uqh2S6p4JomAPeZ16YMWOuX7PpyZPa7ImNMX5IEUBFNVOJUCCkBr0oez3ErP1zw3gpjGp3lHjPgw+d6EFEkX45U3QCmWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xoz/va92slKmN/dbSbkWSiYSnIF3tALV3X9qIcK/SSo=;
 b=R8ZdBBcjxkSdzSNsfSlF79pCoqz32BK3IRCnZHocTxOhMEEwmDYYz1KljZlb0jlYsEIPLF5CKhTmpivJNJIHH+o7vHQI7yV0tTm29ewmnmw/JAPrbvuXYMvbcC8+dC2FpIpKeLarngDdg8TMf4i7A7fpj0Xba8Dia5m5X9PKUyGnhKW+N0z8+a+Ac6NDFjN7ApiIhJqR6NO1jdGxELhi+5JrxPbY74ia3qzozq2rSU2ZYltYY3pHdGeQlqFUkPcyEzgiaREdaKpRXoqEIyGrN8djEUDAv4dyHWbD/e+/0kEUSOUIG2kC2RzCZPvwQOyVLSqJMHNVxr7Mitc04gAhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xoz/va92slKmN/dbSbkWSiYSnIF3tALV3X9qIcK/SSo=;
 b=d9XWgY0N9xud3DjAS0KZKqOoHGuDYRpc3W1xDEupjaZZcsTbmWSvOihMpMh8S8tn7WzC97IySOCs5ByInZCYBW0MM8N+W9PQ3CRUo/EpNH9CoVq0PaHFq+XT6FFAjhlYwKC4ZvOPR639PiGwaKjmB+Q3ou8G+CXcG+pJwgKu4kA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.17; Fri, 27 Dec
 2024 10:23:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 10:23:47 +0000
Message-ID: <6bd86aa0-b0d3-d3b4-cb8a-8fa5d7a7dd0f@amd.com>
Date: Fri, 27 Dec 2024 10:23:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 17/27] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-18-alejandro.lucero-palau@amd.com>
 <20241224175324.00001cad@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224175324.00001cad@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0045.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::21) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 015eeb55-6f59-4ec7-efd0-08dd26608c3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZZYUNkOE5LZUoxZDlnTVZiTDd1cDc3cTFyY1NFTHhQWUoya0RnRWZSRDlt?=
 =?utf-8?B?Y25SVm9IM3F6VXdyQnIwNklqK1ZtbmJaNjlhYzhtL2R2dXEvTzdKc1FHMENr?=
 =?utf-8?B?V1pweGpRYjhTd2kzc2VWYUtLSmJLTVVHeVFvNGFGeVdqbzRnSG1hSW82MDAx?=
 =?utf-8?B?blFMR2REeXdpS3IrRkI4eEpEZ0hCMHB0cjBCdGpESjNmcFVpZjZoekl2bWhw?=
 =?utf-8?B?K2kyR25aNVd2bjFYYk9LMGUzMkg0bElWTjI0Yk9lKzZxYTh5UW52dVlhUlNv?=
 =?utf-8?B?VXI5MnRUVGxmTldiZFBXWlArd0lGa2tWTkM2V1hKL3ZVM0hjKytoQjRjWUFj?=
 =?utf-8?B?akw4L0h1UWIzQXVPRXFjWkhnMXN2T2U5OG5WZy9Jc0R5ZUR3dXZ2aUFVV09G?=
 =?utf-8?B?MFdLdkQwUmxEUDIxcFEvb2VxaERJRC9hV21PMGRIY2doYUVFdTZUdUxRQ0Fr?=
 =?utf-8?B?NkJYSGdvUThGTUt4UWxiU1pRNUJwMGVvVVJtZnFPQ0E4NVg0WkpBa1I4NGw0?=
 =?utf-8?B?WVZvOVJoTU55T1F5UW5VMWhVcktSVVpZY2tEVzUxR1o5MG9vN3ZHUW9SOEJP?=
 =?utf-8?B?Z3N2S0JPMFE2ZTh4R2Ryc0haQlZGVERrcG9iUkd4MDhpcUhScjQ3U0Rra1E2?=
 =?utf-8?B?ZUtRdzI1OHFOa1Yra3l4akpWSHUycTkvQWVEV080THRsT2UyaFpOMGFYMXli?=
 =?utf-8?B?SDhZRFJUTyt6TGg5RVg2ZmtaZEorUzN5ZE5VcEZPb0JZOHdWMmFLem4wMVcz?=
 =?utf-8?B?K2NhU2plSTRLKzBLTHBMNG5NdC9MbmJWL0tORE02ZE91VUxoMlpVUVNxQ2cx?=
 =?utf-8?B?YXFGcjBNSGt3WkpjdnRCU0dTWVFlcHcxNnpuejNhSXpUb1NVWTRyRitOVGJj?=
 =?utf-8?B?blhoTGlJNldOSmZlRkhteFN5MXlaMGllNmgyQ3JlOFBkdzNHV0kwWDNCV2R6?=
 =?utf-8?B?QVcxNTR2YTcyeDhSYkhTQld6N1FsMm54Yk50UG1KMnU1RmhKeGUvRDlKRW5r?=
 =?utf-8?B?RHc1aFRIMWdOdXlKL3BkUUFQRThCdkF1ZG9JeHgzRXFPNDZjbVcwVDA3NEpW?=
 =?utf-8?B?WDROWks1TFUwbTNBWXVNcUQ3L1hxTlNqZW9NRnp2RjIyUjBvcHRMNk5ORk5p?=
 =?utf-8?B?OUxOb2xSU3Y5Vm8zNXVHOGwzYzZFMHo3RDFpVkh3Y1VJb0kzTUl2UHZHSEhk?=
 =?utf-8?B?RzdBSUlRY3NnUDl1RzlMYTh1bTZJbkY5SVRNUWlyK3BsU01QV3JwTnIxcGMw?=
 =?utf-8?B?WEVzWGJyS0lmVzBsb2pUbmhQMUZzZ1ZpM2hvaFMyNzFZZkhkRmJwRmY2Z0NH?=
 =?utf-8?B?ZDZpR1pBcDE0MVRRdS9VQnVFM1hIVUpsVzNYblk1RFpVNE1mVzMwY2ZvWnJw?=
 =?utf-8?B?MlJ5YVhxVGN4bmRybUZDMDA3ZXZZbG9kUFRwN3FPaGJkdjZta2tPVWdLaXpR?=
 =?utf-8?B?U2t3eWg0dkN2Sk9qamRQaEZ2RktjaGJlRVBFUmc3REpBV2hub2gxc1hzaUo0?=
 =?utf-8?B?ZitiZmFHRk5iMGJETURTRXBhZU9hNENTcDFIdXZHbEExT2RwQ0hPNWV5Z3FM?=
 =?utf-8?B?d2Z3dWtqN3FxM0s4U3M0WU94YnNRck1wd0hqSFluZHlRMnNWM2JyVVVYUW8r?=
 =?utf-8?B?dk9sNWtsMy9Bcng0SGo3YU9nK3ZWVysxbU5hRllCZnozK1VzTGJWQU10YnBE?=
 =?utf-8?B?clBkZjJNRHJicjZJNTlhUGNXb3Z5TnUxSDdhWnpZTU55U3JmTjNyc3M2bjFw?=
 =?utf-8?B?aHpMN1ZYWTN4M0dnUXNydENJNHM4ajVxQmJCVkZ6aVNYQlJ0WitGbjVpdXBF?=
 =?utf-8?B?NGFJNk9KNDNXS0lpd3MwQ3hoa2k5SmVtMHE2ek1uMXBVSVJOY3VMRFU3RUYv?=
 =?utf-8?Q?CLtJzypekrw02?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFVSDVtbjc4Q3FCRVZ1V3NCSEhNYWNUZzJLcHVPTHArSHJaRnRaR2tiYUh5?=
 =?utf-8?B?NzhSWS90UUZNOENXNVQvZC9UR2NMMDBjNDJzOFlTS3ZRbVZlMXZlY3R6Ymds?=
 =?utf-8?B?L1IvU0s1TU1BZTRDRFIyODlSSjJ5aWpxaUUvVlFyOTJnMzE4KzhvSXI2WDc2?=
 =?utf-8?B?bGlYc2dDY2VmSkF3WXlnYkxtOHpSemE1THVhdURCY1RxRzk5VHlPaHBOVFVC?=
 =?utf-8?B?RzVTaUJ3Mk10OU45OUdkcGtoSGY2RVdyT1pEWkhGb0Rqem1OcFFjRFVCeFBl?=
 =?utf-8?B?UHRnVFNzWE9OM3NBUStpTTRSTEU1OVN6Qy9qZWU5dlFLR3podEdQdEdDZmhy?=
 =?utf-8?B?ZTdsSndhOWc5Tk1rR09LTUxCVFdML1JRR3lsTXFPRk5VVU02VUZpZEVmK2po?=
 =?utf-8?B?SVVrdGxQTWJrbXhZd2JxdWJWS0tERlRRa0VuR2xOcllEUzBsNkE5dUFIRS9P?=
 =?utf-8?B?K3dsbHVyeHR2bmxoZVlaTkc1Mi9XUHRDdnpZWUI1SHl3YWZXUHZDNnpjMXpw?=
 =?utf-8?B?ZUFLNCtaUEFYdmVybFp2ekg0ZXdUNzhSSy9QbG92YnVhYmtrTVgydnBkd1lM?=
 =?utf-8?B?bEVJd1NOQjl0WUV5ZHBGaU1BbFM3SjBpMExMWnNNQ3JvTnh4SWNkR1BNa09C?=
 =?utf-8?B?ejhwS3NodnJITm45OVIrR2daQURCK0svTVY3WjR5UHFUcWdXM05jdzhzdC9B?=
 =?utf-8?B?WTJCRWpwTTJIWVJFWmlQN2d0VkdKZXloOFYvUmVkc0pPS1VTc2ora2orcW9I?=
 =?utf-8?B?czBrcEpjdzc1UmJIQUx0clljMmNDd1d4emk1ekI1S3hqZ094bG9xN0IwVlA3?=
 =?utf-8?B?MFA2NmxsamFlWnFPdDNlam9oOGY5dHZFNjJGSFFoVFJJZm5Ca05vRGJ4WVJ0?=
 =?utf-8?B?RGRNMjV3bTRGK0hudXU3dHFtN0VHOFFPbVVSUStZQ1R5SGdhSjcvWHh5TWRw?=
 =?utf-8?B?Nnl5MDBiVERQVUVOLzVKRCtJT2J2aVpiQzArdE1yVWZOSDJtSzVRd2RNTS90?=
 =?utf-8?B?RlFrNitHekRXRVlLTy9zOHpreU40M3N4MlIwTWhXM0xubVFIWkNYQUNMSHZB?=
 =?utf-8?B?cnoxMTZXUjNFc3lsbUR5WUkrK2FuMThZcmN0Y0Y0WEZuNTUwRFV6ajByb1dR?=
 =?utf-8?B?WVo2UVJRUHYzUWpRNnpGejhlcnlEaUtycEg2MmwrVkVWN3NkTWQzS20wT3VP?=
 =?utf-8?B?MDFNV1o5QWJMWnpTdWg2T3dTa3lPekxBL0FiaFlvMjBxV1U5TmZRL1o3Zk0r?=
 =?utf-8?B?RnV0TFRwTnpBaTREcEdHZ01jbXJuWFM2ZlRqa0lFZFRWVXNwWm5SRE4xY0tF?=
 =?utf-8?B?VVBFQXR0Wm9vNEtwVjRMdFdQbVVqM29BT2pGTVE4V0dFOXpDcHpLVnlVdmln?=
 =?utf-8?B?eWR6bEIvUkpDWUNxKzJ1UkJnVWYxMDk4anV0bFlPN2xZNFNRcVVoclV0TEhU?=
 =?utf-8?B?OVpZb0NibDVKUUdFVG9aL0NlQVE4UElZalhHOHpGcXJqUzNmT1hxbXBaY3hO?=
 =?utf-8?B?UzN4WjI0MTV5TG5IMVBVV0NTcy9BdlJJZTZUUW1kaWRtQ0VSMHpTbDc2T3A5?=
 =?utf-8?B?Zjh3KzY2YlhaaTcwaG9lRDhRVm13clNwN1ZycHI4VStwUURxV3B0VEJQOUhv?=
 =?utf-8?B?MFdYR0dPcDB1TUM0Z2VSY1VYUTBSTDlKdnZOVzZjeWc5VGx2Rk9aZXkybmQz?=
 =?utf-8?B?MDhqNC9BamsvaXRRN1k0aWxpKzBoK1RXeGlmNUM2UmxXUnV4bVR2c3JrYnQx?=
 =?utf-8?B?bVM3WEh1TGZwTnhKeTA3c21RYVhtR2JqZ1E5RUlYR0llbEpTaTRVZnVBUUZ2?=
 =?utf-8?B?Ui9aT2ZtRFh6UUFMNXJvMnNTQ1o1U09YanRpNEh6RGdmZlZjOWhGSy83OU9K?=
 =?utf-8?B?b1AydkNOQlJOL3VGOG84SDVxRDY5NGRScEZKdUN3ZnF1blpnSkdrQkhodS9F?=
 =?utf-8?B?ZlpDWFRJOW5vTjR1elVPYStYbzNLMEhBdmpBZHpLS1BvZTBOL0cvcWthc28r?=
 =?utf-8?B?WlpSaSthVGhHK00zeWdLbWFjd0szK0o3VzNhWDVIYmY3dHZSMysra05LUERm?=
 =?utf-8?B?NDZWblJrUFBTTk8zNFlIbGtkcEw1WmRkQWgzN0lSRDV6cGVKUitUZFN5ODNR?=
 =?utf-8?Q?tErecH+dW1vcFZvTBrfl7BrWC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015eeb55-6f59-4ec7-efd0-08dd26608c3d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 10:23:47.0179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+NHsshKtiVSi8jLwVpdf1U6f8Qg+meuo8GY4bByz7AmUskP9DsZGdE5RJC+qy4nDG323Drwhnp599/iBuUTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231


On 12/24/24 17:53, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:32 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to  map the minimum amount of memory the driver needs to
> Bonus space before map.


Ok.


>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Comments inline.
>
>> ---
>>   drivers/cxl/core/hdm.c | 154 +++++++++++++++++++++++++++++++++++------
>>   include/cxl/cxl.h      |   5 ++
>>   2 files changed, 138 insertions(+), 21 deletions(-)
>>
>> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>> +{
>> +	struct cxl_port *port = cxled_to_port(cxled);
>> +	struct device *dev = &cxled->cxld.dev;
>> +	resource_size_t start, avail, skip;
>> +	int rc;
>> +
>> +	down_write(&cxl_dpa_rwsem);
>> +	if (cxled->cxld.region) {
>> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
>> +			dev_name(&cxled->cxld.region->dev));
>> +		rc = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
>> +		rc = -EBUSY;
>>   		goto out;
>>   	}
>>   
>> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
>> +
>>   	if (size > avail) {
>>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>> -			cxl_decoder_mode_name(cxled->mode), &avail);
>> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> This is reverting an earlier change. I guess accidental?


Yes, I should be using the function.


>> +			     &avail);
>>   		rc = -ENOSPC;
>>   		goto out;
>>   	}
>> @@ -538,6 +557,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: extra capacity to allocate after min is satisfied
> Includes the extra capacity. Otherwise capacity allocated as documented
> is min + max which seems unlikely.


Right. I'll fix it.


>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
>> + * how much HPA space is available for a new region.
>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	enum cxl_decoder_mode mode;
>> +	struct device *cxled_dev;
>> +	resource_size_t alloc;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(min | max, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (!cxled_dev)
>> +		cxled = ERR_PTR(-ENXIO);
> 	if (!cxled_dev)
> 		return ERR_PTR(-ENXIO);
>
> 	cxled = to...
> 	if (!cxled) //assuming this has any way to fail in which
> case I think you would need to put the device...
> 		put_device(cxled_dev);
> 		return NULL;
>
> Though do you actualy want to return an error in this case?


This handling makes the code clearer, and yes, you are right about the 
put_device.

I'll fix it.


>> +	else
>> +		cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +
>> +	if (!cxled || IS_ERR(cxled))
>> +		return cxled;
> Drop this with changes above.


Sure.

Thanks!


>
>> +
>> +	if (is_ram)
>> +		mode = CXL_DECODER_RAM;
>> +	else
>> +		mode = CXL_DECODER_PMEM;
>> +
>> +	rc = cxl_dpa_set_mode(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (max)
>> +		alloc = min(max, alloc);
>> +	if (alloc < min) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
>> +err:
>> +	put_device(cxled_dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");

