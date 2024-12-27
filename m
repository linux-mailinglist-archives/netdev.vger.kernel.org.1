Return-Path: <netdev+bounces-154354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC319FD2ED
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 11:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF1116253E
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1701547DC;
	Fri, 27 Dec 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c7ETcbuG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995C146A79;
	Fri, 27 Dec 2024 10:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735293953; cv=fail; b=OPYrIDS6Ujy/MCR3tC6yPxYuYaslqsVuRGctkIq2758MDU6AKmfPW7WFEbwZPbxNI75S9d43eX1PDAyNCqgWzxZjYtYu6rJKLboyCcisQSZOryicOtwWYr/7jCKCtVcSMML4UghBIkucS4CbILUKhlLZcl4JWPtykggN0+2bnkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735293953; c=relaxed/simple;
	bh=Ba94OJefErH01kZHYHV+3wvqc6c+0ou/RteYuuD3GoQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p36by3pOsbayEOoCujxoCnnG4xXf1C7B9WW3Qs6q54wk6HUOk0ooW/zf6JD/X/YXTMc2/7i8H7Cx3Q41aHJ1CWnK2e2vyiwT907MjWpKeIkP6FPWD7rwAd9lQScNF7YdWdMLz+YZA3ouwA/FgGn0e4uLvYfuDtiDBqwJGOenKyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c7ETcbuG; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2v7zD4qoMb+0NOf7Qj6LkjOOLlJaDpABl75jYR8nhD7LGAiqXPum4k4TMx9HNI/H0Y3rIpEfKKnFQ+IVHZ0R4f+rwTCsgm1ZPjQMFub66PLdFEftFejUES4w6hyRJzvrwIHm4XYUyLpDeZjCL85HsYcQRL7lOKfBII0gBdNItEqqjSGmw2GxDw4SU0RzIzilQaSh4lgxsJ9oirm2V97EloycZIyYQQPhUVlAvWu0kxzL3jKQ/on35recNd2oz8k6Ab056NDsfOTaH1UkJr2L1nR9Xsu8baM9pRrt4EQ4j1uvy2J5HKtvGcZ0atznZ9rMooqx3KkicTh0FOTskcHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEvTsB5Skn6Ux+0LGkWCg7iZswL2OmW7JTYt8pTByVc=;
 b=BYPi9hAjRaIYR3qfNpgKp2Yu2l8LiOhpF9DoaC6DTieYLOoMg4C9FMZcZBcdMGriCGbROMUlV1sI8TD2pKPoCchcQctUmbfSkB7/vEC0BYLWDz1ZM2x+vwZGIo0TkfEFULbNEDhQgQ3C1RmFX/ghL5VQaby5H1YUhon58zE6xD997I1MsMsWC2cLWuQFZv00Oq85RiyUSCmeW6HAlvNze9YHQ0I43tzSGwz2daIAhiBO1dtLXflXsNOZFKrNwz7KR0Cq7drhnzRq17DBP7/Cf+BLvYANIE1LGP1s0tMECSw4+n08R5qcYQ+ZaTdsNyBh+71dxeqQA/ACvVyJ55Sx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEvTsB5Skn6Ux+0LGkWCg7iZswL2OmW7JTYt8pTByVc=;
 b=c7ETcbuG5J/lyuMLViljcquhzueWs+dzVXperOz/k788aqSvwYPCOXEOha7j4or7OmoW1oZL3L90yrHyr/kanAafutbPdsFierJjJkREtaVEuQVgAo2YGwqRssvpA8gkmecWFBXDzteovZiYizl8EC1JS6XCTUKmRZEol4WSJEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Fri, 27 Dec
 2024 10:05:44 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Fri, 27 Dec 2024
 10:05:43 +0000
Message-ID: <d20eede9-19ea-c6fe-bf46-189ddc96f610@amd.com>
Date: Fri, 27 Dec 2024 10:05:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v8 15/27] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
 <20241216161042.42108-16-alejandro.lucero-palau@amd.com>
 <20241224174201.00005bc7@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241224174201.00005bc7@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::17) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bd1d64-632c-43b6-9a92-08dd265e0698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2lWa3ExeFdmUG8xY1IrWmJIaXg1TWNxaUo4RGpUWTVUeW9lRWs1Z001ZWtn?=
 =?utf-8?B?MTUxMmxORmNVdlNjZFBQbm43VGpkcnNjcGZobTh4MWFMRVB4dXltS1crWHNM?=
 =?utf-8?B?RWdscjdnNU1nNi81d2lIcG5kRjltNi9EYmRaSlhqSXc0K08va2VaWXdidHJT?=
 =?utf-8?B?cWIwcUV0Mm96N09ZZXZSY1dUSStXSks4elo2dldFcWljd09HQ24vSFcyZFJM?=
 =?utf-8?B?ZWxQeitFdHo0VXBOcGNSS1RvdFRpdmtHSVYybnNvSkRpM2pvcVVuUHYyVmto?=
 =?utf-8?B?Z3NVbHJTazhmaEgwVnZoRTVWR09HdDM0eFo2dHp1MGkzb05oYzlSMGIraXIv?=
 =?utf-8?B?aW4zSFprMlRHMmJoOGkyVjVtU0oxVm81alZWSDh1eWpSaHE3TG9QYzhZRVdr?=
 =?utf-8?B?N2JnNkRna1FIZzBZQW5zbThLTW1TYmtObGIwb2lhVk1VNEptOHBmL05UeGI5?=
 =?utf-8?B?cm1uWnNOSFhFemdaMUFrZ0Nkd1ZqVk9oWmd5Rkh4SC9kVGNST054c28xc3JO?=
 =?utf-8?B?T0JDUEpKUFV3ZHJkTXZmQlJxNWkwVlNCWEdwUGRlVXp5UjVXZStXOFNqTUcr?=
 =?utf-8?B?bGNJTVJ6VjVJKzMwTkxtR0tnMHFGV052TE1YbC9QYWFyb3JYdTVXWG82RWxv?=
 =?utf-8?B?MTBiRWxYRkVjM2lLemxQaDVvMUZFN1VJMEJRNElKR0pralJMV0RuVURqODR1?=
 =?utf-8?B?WWNnSWI5UUhvZFA4dmxzVklKVnZhc25mbGY1cTl4Ulg1QUsxaklLOHFVdEpE?=
 =?utf-8?B?aDZSc1BZdzFNRkVBVHRkKytybnhzWmlFQUY2ZTZjekw4bndvMEtxZTR5V1JF?=
 =?utf-8?B?WUJIenptY01MaTllRUpPZHI5aWNNUmVlcWFObUNyQXVOdDJTTkwvQmdKL2hP?=
 =?utf-8?B?YjBha3F1L2hMTjEzTHI4K203QzZ3N3ZiLzBrb095VjE3RUY3MkpINkh0ZTJW?=
 =?utf-8?B?QnJYNThlRkZWYVIwWWh1QVNseVUxMmNYSkhTa05QWGd4MVplZWFGdlNVTlp0?=
 =?utf-8?B?YnF3eE95VUg5bmxacUNhQ2owU0VnT3FpbCsxb0NGWUFWSzdjK056SHhKRnIr?=
 =?utf-8?B?L3c2Mnhra2prcUFMNm5GekFXZEozdnlUeW11blZvYzNaanB0TW5wN2dxR2hR?=
 =?utf-8?B?T2p6SlNYNE1XK2twM3lRU1JtcFEwQTIreU1pMFI3clZQUXNKU0tncThOeFN3?=
 =?utf-8?B?cm5RZ3k0SndueTVHQlprNG1uTDdCZjZaOVBKT3lpblAyaVpuanRhNmpIdFRW?=
 =?utf-8?B?VkdmRnhKelNtMlg1ZERrZGY1OEU4Y3F4M0dRL1IyWW1WK0xOUC9ISElUa01x?=
 =?utf-8?B?Ykkya1JDazltUjlaMFhVWXNhV1YvdmpKdnB1OUxTcFJhcExjQkhiSWVqbGRj?=
 =?utf-8?B?bjZ3UkJtcE5aUTZ6ck1aWmZiOFdlNjJ3ODV2VDN4aFhlVHZsV3JBYlZrc0V5?=
 =?utf-8?B?a213M2ZaazlMWW9UeGV5TkpGUlM2YmhnZERpK3BiTzM0cldYSlJHSnh0bkY0?=
 =?utf-8?B?WlptOWI5REdLVGpid0NNQUxuWlNpM3ZuaUVOa2RIUGcxOWs5YXRNTEpyQUEw?=
 =?utf-8?B?VithTkt2RnpIdGh3eGZYelZXSitoamMrUVdlQXRWenQvNEdXYjV0bk1rMHd0?=
 =?utf-8?B?UVovTDdFbDhpRkgzbEM3ZjV4MWhLU1dNcEVhM2hQWUMrbmNFcXcrcVlzN0ND?=
 =?utf-8?B?VVlkSFZVNGpSZHpYbFllMnY5aHRVZWVwbWJzbWRtcHREYlVBLzcwZVJ4NlBx?=
 =?utf-8?B?dTVIMGR5Z2pzTElQZ3RrYmk2UXlJeUZvVmV5dm1oK2p1NWNDaEpSWmMzaGox?=
 =?utf-8?B?SERxZHd0ZkZzeE0rSDVkRlRqSlBFd3JPa0VWTUY5anBmb0tGMnRxVTczbWYx?=
 =?utf-8?Q?+8VPmx5BptQX0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXcwVkIybDRQOElWQktJTjgrZGd2eWpPWXZqZ1hDUDExWjJqeldFeVM5eC9K?=
 =?utf-8?B?bWdSRHV3cjlueitUSWZJNWJqL2hBYzZ5R09RbTFqUjNKT1dnbFc5WmwvRmhx?=
 =?utf-8?B?VDBpSCtpSXhOWC9YK3d4RFU4bUNOTmNKcm0yTkNOWE1hQWdhWWFEaVl5VXcv?=
 =?utf-8?B?QnNIK3hnaHRoWkNyWHR0ZVh3bCsySXFkYmZHTHJCQzV0M1NCMzFsdHRSQXo3?=
 =?utf-8?B?eFBQZkNIazVqV3h4bytibjZsOHBxcmMxMm5zNUR3amZuM1ZaZkVmQStnT08z?=
 =?utf-8?B?VDdTZkJ4eVM1dEhPNnplN2tTcE9XRlkxbHZZVXgvWE9vMTJiM3ZCbUUrcWFJ?=
 =?utf-8?B?Mjh6cHh3QlRLRGJuYWpzMVpzTkhlTmJjdWw1ckFlU1dqeStTZW52NzVHRDNR?=
 =?utf-8?B?OWttYjRQZXVqaW01QXl5MnhxSDJYRnNXQWUzbkI5WDlXcDZjZ1FibWNvaVpC?=
 =?utf-8?B?L3lXdnBEY1dMblBDYWZNa0tvcVE2M0JjZ3d3WnN4Wk82ZlRlT1BmMEwxNjU4?=
 =?utf-8?B?VGpjUGFCQlcrZ2VFS2oxV3VIWUxoSUwxbHRZaUpSZjBUSDZRdm45czYxblB6?=
 =?utf-8?B?M3JaNUczeDFnRlpHN1RKWlY4b20yV09LVkNFeDhBWnVwN0pvSyswUEFFd3U5?=
 =?utf-8?B?b1IyK2pJSmVyNjhqT254akZZV2JqeFlDN0NBbEU3QUJvK1lHVkZodHhja3Bs?=
 =?utf-8?B?OEtvUlBGdUZzaFovdXEwcjBQVldRTlZ3R21TV0JJS3BpcmRnNzBqb0I1VlFn?=
 =?utf-8?B?Yk0wMnRXYlpSRlpjZVBpVkoybXg2RUpkbzMxK0FtVWJ0R1pCWThvcDIwQmdU?=
 =?utf-8?B?c0ZYcnRZbHZNV01DeTF2dEFPcVVFaitIcHdzZnNxazBGN3JUczB6cXBxa1p0?=
 =?utf-8?B?QWxsc0k0ejR5Ti80RUF3eVlwdk1GSmVhMVA0UzhxZU9NZmQ5c0hQVWJBdzJ1?=
 =?utf-8?B?Ylhtb1ZxbE1Mdm8xbDNaUStCR0JJWTJGeVU1U2I0LzFTd2tieWlOc1FhWENF?=
 =?utf-8?B?Y2VYQW81K0NCOFR5NzV2cklHR3Z0anJzaU1nN2M3bGhZMTk3bEg3MGt5NW9Y?=
 =?utf-8?B?dVBsMmV1WnMzMnczc1Bob3lYYWsrYmdrK2RDRjFiQnhKeSsyVkhCY3VSUmNW?=
 =?utf-8?B?emlWenN1RUMyQkNnYnRBWE9oWElEeGRIb2JDbVloSVBiVVpaOTZpWW1lcjBD?=
 =?utf-8?B?N2dPWTRIOEZ3RG9pMkoxTmxXclA5OVdWUm81K25kV3ozOXBVV0hDS1hkd0pS?=
 =?utf-8?B?eU91Rm03ZFRmMHI4a1RhZXhaNnFwM3ZFeGxpejMxbmxMalI2elRLMWxPS041?=
 =?utf-8?B?NFo4V2haRS9DNFBOWi85RTVyWHIwb0I3Z0Vrb1YxNzljaWVzM29rNStPVW9w?=
 =?utf-8?B?ZlhvMWozbDYwMEJyQWgvNlA4TGNXYlZDdm4rQUtIb29SMXFZM1FpWmVqemZD?=
 =?utf-8?B?ejl4MGpmanZsVkdTTW9NYWp5TnE3Y2VxalBYWXpia0JBWWVkTHRiOTZiMkc1?=
 =?utf-8?B?UEVGMkN5QjdhcDRKa3Z6NjBZZENidEsxRHI3Q0kzbC9SS3p4VDgzQnV3V2xO?=
 =?utf-8?B?djhrMEtOTGN4L3JLUHhVZm0zVm9jOFdaUnplaUhXbWMzZzFLUzMvbVJmb3da?=
 =?utf-8?B?aWMwQ2dndHp2UXRFVnRRSThyWHQ2TkJ4bEF1WldTL25UTHdQZk9iTktLZ0lM?=
 =?utf-8?B?VGF6ZUZ3Z3k3S2ljWmpuc25SNUNib3p4Yi81OG1KMXJFVFpzYnEyQkNlSnBQ?=
 =?utf-8?B?MjExZnVEb0JLMjltbE9CbHRIYnBkMXZ5eUlPdGxYVXRxcFFlay9RUnZRSE9C?=
 =?utf-8?B?ZjA2ODVTVEVrUVFVbDkvYlRoN2YwQnB3dGFFRnplb1l0emJhUmVJbjYyS0Ir?=
 =?utf-8?B?U0crQmNQR2VmZjNZSDNnUG15UnhySHozMXZOV1ZqSHFqRnQwNTh4UVQybzFR?=
 =?utf-8?B?a053T29Ud2JsUDVwbVdaZkNvYWlYY216UytYd3YzbmVXR2h5TjduS1dicUhz?=
 =?utf-8?B?RHk0R0xTSEVJUWNodXRQcWtKdHBtRDcwWUV4ZW5yT21lL1diUVdIbDk4Vmcr?=
 =?utf-8?B?VHhDWno3STBmQ3BtMmFqZWJXSVloK1FJL1J5NFJSTVVuaFBHeG96VWVkL2Vu?=
 =?utf-8?Q?2r8bZ2oV3b1cacUn9StOmSJtQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bd1d64-632c-43b6-9a92-08dd265e0698
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2024 10:05:43.8706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oycBzZAClRkmGg/j8JRZgFc7vtC4tHMKLwQecfKw/GmyryNvKbV+4Npqw8Z7DtJ1AGW/KRTqB2OLN6f+ANQkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888


On 12/24/24 17:42, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 16:10:30 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
> is created equal


Yes. I'll fix it


>
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> A few minor things inline.
>
> I think you also definitely need a SoB from Dan given the Co-dev.


Right. I hope Dan takes a look to the patches, and I'll be happy to 
include that.


>> ---
>>   drivers/cxl/core/region.c | 154 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   8 ++
>>   3 files changed, 165 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 967132b49832..eb2ae276b01a 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -687,6 +687,160 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device *host_bridge;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "%s, flags not matching: %08lx vs %08lx\n",
>> +			__func__, cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * The CXL specs do not forbid an accelerator being part of an
>> +	 * interleaved HPA range, but it is unlikely and because it helps
>> +	 * simplifying the code, we assume this being the case by now.
> because it simplifies the code, don't allow it.
>

Simpler. I'll change it.


>
>> +	 */
>> +	if (cxld->interleave_ways != 1) {
>> +		dev_dbg(dev, "%s, interleave_ways not matching\n", __func__);
> Dynamic debug does all sorts of magic with printing, so don't add
> __func__ in any of these.


Yes. Fixing it.


>> +		return 0;
>> +	}
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	if (ctx->host_bridge != cxlsd->target[0]->dport_dev) {
>> +		dev_dbg(dev, "%s, host bridge does not match\n", __func__);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
> Add a comment here. Not locally obvious why we'd only look at parent size
> whilst check if the child exists.


I'll do.

Thanks


>
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +		__func__, &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
>> +			__func__, &max);
>> +	}
>> +	return 0;
>> +}

