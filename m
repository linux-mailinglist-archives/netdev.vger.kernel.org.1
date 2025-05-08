Return-Path: <netdev+bounces-188966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13451AAFA41
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D301C07EC6
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36D5226D17;
	Thu,  8 May 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lxm46INh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077A8226888;
	Thu,  8 May 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708088; cv=fail; b=X/mz3ZBxbmZR7sfU5mMMO7NL6N7YMWvbsv7QPKkzHe7nV5/wM6kLBcX7oxBleGxADo/gRiz+JljQBbHDwaeQ3oOj2VjD2YrhuxPLWh0SQjtiX3KLvcjVa/9FC/33Hk4ybM758qolJ/+5P/gX9IyHWbkKE/UPsDsDyYeXRRgBXJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708088; c=relaxed/simple;
	bh=r9Ka/6gFQinXbfM3SIWJsn5X0qMEMFEw96ETv4jp6cg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nCfKigS3vq/P39fCBXYmWZYh5VNVz2IMVYYkfTabatoexz7Vd8nB4D9y1NvQ9MFlibikcVJO6LP/cFp7U5xIeDPEtrfR08yTeuyo2obDdVq4CHa84kILBXMF85G3tPF75m76c1fY8iLbsz3RbOgnSkrhSSfYbQ1sQmDQ9YgABCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lxm46INh; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ3xUnZJHdXmu7sbSg4+0hXXGfdHiUXXZK52OwuBIogbbBpi+ouKc7qk96XdAF04wPle90RnZmnPn+Tq507ASy+PKTnrDA3QkDs9y+a/4LgEQZIeIijQ75fmTS0qhhymTxlgkD9dQxl8hv0WvFIlXH/lYdUH0T80hXz8SEoWx+uz6V+FEnq3HNkgDmr5Km5g2E4tTp51FJ3jgYZDlibSHVcbq4Y4Xhjvk8tgk3kZp/rTPJlxsZx65Zccly2k4/VuPF9YNqoKTTyvWGrVDleBuzaM9WkLnOAmpRN9CXLoeLW1dxpJ6ktwEj6JAJvCMYUkXqMrrNENZsto3g3eUziLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax+jkitvurFjNvMZFi0ye/8+DZwo754FR54kpcZ7Ly0=;
 b=Hn0m/bpD+rm50a+PjAllHOLNEJ2JgBVmvp8qWdDge9HflsZEg11APNtg7d0nxm+7GY9NfwF9eCQW79XF1MtEnXJqPjBEYNd4mFJ+ckaUV0Df4Wy6r+SyxvakKZjOGiV6q4uVHTHmCuoMKksNih1orxVE/QQWHEWAlE8uJYHywV8dzOhgtdh2gUJmZ6yP3v2A5IyC5BDImSM96wkmfZWUSjAnbAjyyVJ6CcYIP/xpT5l5w4WpIL86JxMKlEXcQi6rgi4jqcpjsUwAE/HA8Py2o02u9lyQD854o4fv+qel1q7FlsA1tp+Lp0m+G8blkwc3Q6BRMVkDkZvsUEYAlPhxTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax+jkitvurFjNvMZFi0ye/8+DZwo754FR54kpcZ7Ly0=;
 b=Lxm46INh/TewifvWR2RocaSY9JdXiMp9v3XiagAqTq9g+JWcU14mMNsTGIQiw5ndqXElIDWUcPCHxw2l6p5pmI9//20mKFs3lrXLqNvcgS/nUQzcdRUkwK11moGP3toY5OgU8vLrRumjZ5hQnYkZ0mKkaEBeNLDSIumc9qvVf8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 8 May
 2025 12:41:20 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 12:41:20 +0000
Message-ID: <0de6789e-9d19-4e90-a0cb-cf77f12428c4@amd.com>
Date: Thu, 8 May 2025 13:41:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
 <aBv7woc3z3KSMK8Q@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBv7woc3z3KSMK8Q@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0513.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a20c829-0fc2-497a-5c4c-08dd8e2da223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDVhOFBSNWpmTXJLbXB5MmVDbnJGK1RtNmlScjNPV3FSOFAraHdIS3R5OEpv?=
 =?utf-8?B?MVlWVk9pc0RwZUl6WVg1ZEtZUS9WWlN2TTBHRlVWMlBrRmZFQXpZdWpCMEdu?=
 =?utf-8?B?L2tDenVIeldYY01YTzdYcWIwc2x1cVkxVGwrTGdmWDhwWWJwQVhOVUUvTERF?=
 =?utf-8?B?U0RrUzQxdGZmT3c3QVVuRndUdFlHRlRocnpqaTVWRUU0elpwQ21wY0F0UzIz?=
 =?utf-8?B?UVhJcmNra3J3UkswVndubTNMeWdaeWtxMU9iNVF5d29oNnNVRmxWb0JQNkh6?=
 =?utf-8?B?VExLWmtaMUd0cTFVTllPUlpyRWxmQkU0NS94S1U4VmhBbGVkeG5XWFFIQW90?=
 =?utf-8?B?SVhqQjF6WHJBNWV0NUgzcTZRa0xFWis1bUdsK2tlcXQxY2VYRlBDZjM4d0wr?=
 =?utf-8?B?SUJtVHY2L0FUM0pxUnQyeGd3QW9EbWQybi9Wd3JzMXdWUi9EZmFiczlCbG1r?=
 =?utf-8?B?UDdCT0JBd0huVXUrbTVNRWMzQlBqN29QQjVMRjREVDlDUE9pT3NMU3hZVWZJ?=
 =?utf-8?B?b3dQZWhOQUk5M1lUdXpLcnUxR1VhUjFIM21VUFFsNW96Z2JvZEQ3dmRsa09T?=
 =?utf-8?B?U1hJNlB5YTVmQzVkYlcwNHE1Vm5neUpCZ2pOa2l5V0ZER0dFbGVxSGNXUUR2?=
 =?utf-8?B?Um9vMUprN1lGbG8xTWQ2K0hlMStqYXV2RXhtTUZBekhUNmhVZ1Q3bEswajVT?=
 =?utf-8?B?NTRKQldpL21YN0lIS1RpcUVwU3k0SCtiUUphMnY3VHFZQ2tFV0pFKzIweEZu?=
 =?utf-8?B?d3ZVQzdXYlJUY29CcC94R3pXeVFEc3h0T3dIU2VLc2J2cW5pak1DNzgvOVg5?=
 =?utf-8?B?RDZmMDJyemoxWXVTTzVjMjk3Q3JpS3FNb1NzeDAxZ2ZBNjlHRkF4NnZMS0NW?=
 =?utf-8?B?Nkw4SHdwOFhrYWxUcTBuWndSUHE3dTNZdjVITXR1WllmMS9NTVhIWVJ2ZEVz?=
 =?utf-8?B?Yk9PT0F5Yk5ZbEtRUmtpNEFHRGFNOFA5em1Tb3ZQWGJMUU9tV0NxTXhuNHB5?=
 =?utf-8?B?eWZnTnlJa3B3RlBpdTVVejYzOVI3WVNaeUtGdTJyMVZQeVNaYTdiSkZENUFp?=
 =?utf-8?B?T1U0c29HaVFRNlBYSTFWU1lIS1JTdWxUNDJBNGRZZjdoWStkM3RFbzhoeDQw?=
 =?utf-8?B?TGY3aGpKd0o3ZWJGYng1c0Z6R3Z6dWprQ2plNkdheW9LRnVBdEtlL3FKTm5P?=
 =?utf-8?B?TGs1SVpGU0R2WGQ5OWVWNDJ5MmRmYnB1bHp5ZFVEL0ZEWlk0YVcrdDVKQ2Ri?=
 =?utf-8?B?QUZqMHJ4RDgrcDFib2dTOU45cHdsS1JwdFBTUWFCUmtkaGJiS3hTU2drRndj?=
 =?utf-8?B?M3FzUWk0VkxHcGdSY2ZpUmlEa1oxNWRYeDdEaWd0NFNsUWMrdmJ2MTh2RHJH?=
 =?utf-8?B?a2MrcEJOYlF4TzBVSHVMRzVwc1lhUmh3cUVoUStuS2FrVXZzMG1NYzdoeWxl?=
 =?utf-8?B?bThPaVVFNTVNV011Y0EwRytKUjhoYlc4Q0NIblUwSkVIcEdmenh6V0NZemJz?=
 =?utf-8?B?Z251RXl6OE82N3E5WWxjQ0k2SkV3M2J5UWk5eFl6eXhJeU9DVEFVSTVJMU00?=
 =?utf-8?B?Q21aaTdCUEN2d1RtbkttNUpHUlZCY2VVZzVoYW1naFB5cDZPbnBRcERieFB1?=
 =?utf-8?B?cUUrSmxVNzVhd2x5T1BWYmVldFlIR25nT283YncvSHgvb1VIVmZMNFVXc2s4?=
 =?utf-8?B?TjZSNHV4WnJnekM5K2NkNGV1NGRheUhvUXlhb0FjSHhYYnhhcjgyYmNzSjZ5?=
 =?utf-8?B?OWdPRlN3T2dCK21sa0pvS04vbitucDA4bTlZdy9EcWVESSsxK2hTajh3UWZt?=
 =?utf-8?B?OEszeTdWUHkwaXJHOGtwWm04dlE5OFJmUHdtaW5wS3Uvclh6T3lzemdJUERG?=
 =?utf-8?B?WkhpNXZkeEZFZS9SV0ZvbWlteW9FVlNZVDJmeFZDSThBZ2FFMWYrWHp2UlBi?=
 =?utf-8?Q?D1mI4DKM6X4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3kxYWhCVTJXQnZVRnIzRTVRZ1VnQzdXdmFNcmpxRzdBT294MzlERnJ5VTRi?=
 =?utf-8?B?RXlHMCt0ZHV0VWRGOGhXdVZoZjY2SjB5QWhreDQ3R29BWkJiNHhNQUxqQnZz?=
 =?utf-8?B?TmVYZWxRYzlYL2ZEZUJKRkhnUXljaXJvVENrZnY2YlY2ZVVwU3hnbTBiT0pE?=
 =?utf-8?B?MTBXNFlZL0N0Ry8yWGkvTXpCT3E1MWp2U1hwc05hMjYwZHBXR1RlOW1IbkNv?=
 =?utf-8?B?WHQxSlFwV0UrZDFnWHVJU1ZtUEk4eDd4T2ZGVUpqR3ZUdUxkbWxqMy91bjRH?=
 =?utf-8?B?VUtTR0xJVUN3V1AvNGlDeVNZL1BUclJoSjJIbkxkaGJQd1Zmd3J3dElmNzJ1?=
 =?utf-8?B?QkdmaUpEeEdlY2kvTi94ZEYyMExiM3prcW1MelU0cUlEbFFOakdGNWsxMk1w?=
 =?utf-8?B?VmJTRjVOQ3V5QzBmWnM3VDRmcGtTMG9MQmZPWVA1TlplRnRHNzJwcjdsNVFN?=
 =?utf-8?B?SUhrWjV3a3BRclNwUU5hQTIwWlRsT0pjNGlCeXN4NUF0dkNPLzVWYkNoNFdo?=
 =?utf-8?B?ekMrbkxqZURqNTk3VTNka2RNNWIrdTJienBDRFVnR3dCbyt2c1ozNUk3VXhM?=
 =?utf-8?B?bGlLbVlSTGIyTmFxNTByaVcxYTFybGEzYlBOcTRrOEhxTS9HdTRwR1JpcWtI?=
 =?utf-8?B?d1ZPaUZsRXRzT29VTG5YU0RKeU45ckFvUnkrS1kybUpMKzZHTlBUZWVXM0dV?=
 =?utf-8?B?c1dUMisxZmFxMk5qSmVpU3lRUitibDJaY0gxTHFPVER1SE9rS28zS2t2Q0xz?=
 =?utf-8?B?NHdFM0hUNUJXbWQ3TUZOeUx2QkZtTGZCZkZoWVB2M1RIYVhRdU1iWlMzajFr?=
 =?utf-8?B?cS9QZDY5OTBwU09PUjE0UlJJSkhCcGU0RUhhanRqZ1Z3Ym8wQ2lRRTF6SW5Q?=
 =?utf-8?B?U3c1VzEvMmVESmFGQVdHUEFmeTBIQUNwdWMyL2FLOEp3YjBWWkxKZ0hqenc2?=
 =?utf-8?B?RW9WWHRQMGFPZ0wvTVQySS9ZbWdBZ3h1dzdaVUQwYlpHYkhSYmpYOUZnb1Z1?=
 =?utf-8?B?UXNQd3A4ZkllejNsV0RyWW8rZjlZVXJyOTRYcC9udmc1V3ZGQjY4d2NJYURU?=
 =?utf-8?B?c0xPWi90VEpUbENEYjB0TG1CUit6K0owRitSS29vSGFFT1FRaUtCaWJjU01z?=
 =?utf-8?B?azBWN2JBd2NHc2djSnNuWEtJYUhkNFJhcTZDQjdBeDN0dlZsQUI0Y1lSdmdv?=
 =?utf-8?B?QmsvbVJpN3ExM0k1VVYyQUcxTWNkVTRNQ3BLM2JTT09vNFQ5YjA5L042bXZs?=
 =?utf-8?B?V2p1NGZOY1NWZTFjOVgyS0Y1dlUrVFhIeUd0L0F3d2tWNjZ0V3B5aVRHSUhT?=
 =?utf-8?B?d0F1MTJxcGNaTmVQc2FseG5veXVEbUdPaFFKbEdWYitJeU5MbUpNTmJ0TThu?=
 =?utf-8?B?S1gxTHBFYlNhNERFcGdGaFJTNUlQdVhXU05SNm1oUHJyZWc1YnJqL2VUV2l0?=
 =?utf-8?B?dXQzVjFhKy9ZcU9CSXFXRzJVTDBnTmZmenBJSDhTSXRVZ2ZZb290aTBuT0Vk?=
 =?utf-8?B?aTZZZUYvWDRxTS9xR0xEaXJ2dFV6K1BHbGtXb0FlRGJ3YWRZcW9DWHBaU3hU?=
 =?utf-8?B?MmtLN2NuL0VvNmFLQkZvTU1mcVpmRFdyam9CNnFudVpETklqcVZXYVdieFNW?=
 =?utf-8?B?dGF4am1EWHJKSjlpTDlnRlJoMVVPNnlLWnBOaEppdVpFdkpIdzBDaTh0dFVI?=
 =?utf-8?B?eTFlQjdOTnRrcENoK041S1lHR3JVSyszOFZaZy83YVNHd2RpSUhrWmk2ckEw?=
 =?utf-8?B?aGtUTEJnRVhzblAvTU1LMTNuUHZISXlIdEdTUTZ1dWhURWM2akRSb3VxQ1RW?=
 =?utf-8?B?MVl3cFZCNVhoMUpmME9HNGUyNVUxQlQ3TFlYd0NVSTBGWDQ0SU1XSFRXK1R1?=
 =?utf-8?B?YitWSE5lSEQ0cGZkRi9OaWxxUjlpcDNlSDZiblRmWFVCaGVreExMK2RsYzZa?=
 =?utf-8?B?UkRJZldwWUhYQ0lwYzlWWk9IZ3ZTTlVZTVlLMFNBTWptamZIQUp3QUJMTWt0?=
 =?utf-8?B?ZFdWVHFWeU1tNDZHWWJmK01SbU1LdktLdmtudStlZ2U3c0hvWWJJd0VoK1Bq?=
 =?utf-8?B?Y3I0bTFBU1ptY1ltenhkOVpyUHB1aTV5ajhBOUlQbXRsbkxjTHJyVDRUdmdZ?=
 =?utf-8?Q?2x3ZVrH298Q6Wzs75UEQSMwwj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a20c829-0fc2-497a-5c4c-08dd8e2da223
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:41:20.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TanhMBl+JihB4T0S6IUIaRC1556OcYZiLLI+EWu5j+Vds1RYHadKZwufNSH4SPQ6wbTn6hcA425+MRDk1AsicQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3


On 5/8/25 01:33, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:05PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>>   drivers/net/ethernet/sfc/Makefile     |  1 +
>>   drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>>   drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>>   6 files changed, 129 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index c4c43434f314..979f2801e2a8 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
>>   	  Driver-Interface) commands and responses, allowing debugging of
>>   	  driver/firmware interaction.  The tracing is actually enabled by
>>   	  a sysfs file 'mcdi_logging' under the PCI device.
>> +config SFC_CXL
>> +	bool "Solarflare SFC9100-family CXL support"
>> +	depends on SFC && CXL_BUS >= SFC
>> +	default SFC
>> +	help
>> +	  This enables SFC CXL support if the kernel is configuring CXL for
>> +	  using CTPIO with CXL.mem. The SFC device with CXL support and
>> +	  with a CXL-aware firmware can be used for minimizing latencies
>> +	  when sending through CTPIO.
> SFC is a tristate, and this new bool SFC_CXL defaults to it.
> default y seems more obvious and follows convention in this Kconfig
> file.
>
> CXL_BUS >= SFC tripped me up in my testing where I had CXL_BUS M
> and SFC Y. Why is that not allowable?
>
>

Not sure what you mean here. This means that if SFC can only be a module 
if CXL_BUS is a module and you want CXL with SFC.

You can have SFC as built-in in that case but without CXL support.



