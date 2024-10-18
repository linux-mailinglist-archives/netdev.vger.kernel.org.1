Return-Path: <netdev+bounces-136921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02F9A3A21
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4559EB273F5
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957A31FF7A1;
	Fri, 18 Oct 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C2tD3o4A"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810F192B86;
	Fri, 18 Oct 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729244151; cv=fail; b=ElTByp7KQ7+Uf4ZOEgg9eeW7eaP9R2GmN+KfoFRg/AFvZEoQly5cqzxXqr5ltQCDEYnAxWDDJ/GvSS7MDBaEFuMTHsubGI/XyAtD5ONLJcqY+M9f+ugxoavkzCY474D2HQC1KhSjCpcHQmRI/qyQVSDtSUpgW2HR6zmFpPvROQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729244151; c=relaxed/simple;
	bh=t8R/CS1vDiQcfneB47Oq3+8N5YyuUZC8dJjoXvqRzEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrfICtVcfRnBjq6RA7PWAqpXeDxFZ0qbq4ooS7ckILF2uVZYPwLJmeuBWp3zB/pAcJeUgwDyEYErAO4oDGEoHVMmgbHJ/1RHFRyZJqiM2k/8RT7nHChbJQfCb8cUq+l6GtmdgQ3Ofi4ZoJhzTKrsgbxDKWbiaQp7KSESIwvJjLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C2tD3o4A; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBoKeOQKffJq9iQnJ8WVoo9om3TO4fB2yeQa/ZD1V9sXUG5sgFfCwqO6dn1CyTM9AovIr9YZcLnKzjwnZ3l6alO6Ldl6nlYdsxDqtj0TixoU3QdZYSBScfeUxBZ0MRhiLyiK4xKrRX/49ppIEl0gy2MTev2Ve2OMuv9bOU1tByx2+UYMf4FSRtyyrBT4gamFA6Cluzmqg1NFrsUbJyTgubbeiS+kHwzZ8GEPjcfLuLD1eTmz/n8Pv3p7eDaDnI7auDb/yI/32JLmhoSlGbP7CTaT42k1MpCWmjZa03Ec4aOGF/nAP0PE6phre9RZWouf9KcEvwQ+PWMAdftg3Jk90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFHFA7Cfr/DvyLBbZ1B9uZ3G2FJhySsCxX5v20g122s=;
 b=b0QO+ufzmkMs4ofGjiP3OtlqhOf3HJVnd+FAMrVd5iPX/bmK7m3LARJaStUFUE5zeEKI9JmksoEuYvb3Bdsky6IXJ8yG9QhuD6B/CS7Axr3Fgl29dRPlF9qWASPJnrv5UZRQi4yTBVpBaYCuGiXTKAfKPClXyx382DDOxkXfbBNrCE18cej6Apr8wAqtN5i8uukaqsCzdbv/do0O+7JNh+o+c+Qqi3Ei6wjHpCQQUBRZnei7twILDUIykd2EpnowhjwxZoR1acSevwY6YzYZWOV1KaT7/ZOO265DctG3Yomnmkn80zARivg4u+IuUoE8+bUexslBIJsjkWSIL3hivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFHFA7Cfr/DvyLBbZ1B9uZ3G2FJhySsCxX5v20g122s=;
 b=C2tD3o4Axgb9ErtMRR3N2cCu6RsbP63qwAR0fjVGff0RgWOo+NRpRgP87nFVPVSqSPV9nkOebrH1gGPcabB0+N98pIYWxIZV8QT4gj8fJKQOEqyWvuSswbTbURQZcaspoyAx1lHSCYoaPOk1jljrUykJQ3UkFRCPxe8mAi/11Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW4PR12MB7214.namprd12.prod.outlook.com (2603:10b6:303:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Fri, 18 Oct
 2024 09:35:46 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.020; Fri, 18 Oct 2024
 09:35:43 +0000
Message-ID: <887362d6-d86d-ce2d-f4b6-e352b84c4d91@amd.com>
Date: Fri, 18 Oct 2024 10:35:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 05/26] cxl: move pci generic code
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-6-alejandro.lucero-palau@amd.com>
 <d5083432-787c-4e33-9d19-67c6a9051ced@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <d5083432-787c-4e33-9d19-67c6a9051ced@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0149.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW4PR12MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 813af437-07d8-49af-40fe-08dcef583c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2JReVlHL0NHUC9DQm9uZE5wdWREdnBHR1EwY0F2bUo4a2RGQ1F0YkpiZGZS?=
 =?utf-8?B?ellJMlBxNkhERGxTTm0xa1lxMzJTc3V0VGpMVDRIVS8yWE0zNVJKV1JuNWcw?=
 =?utf-8?B?Z2VrWGhQNmRsUjIzVGw5MHFKUFQwVjNjSmg2a082U2ZRdmo2WnNWSWxyMmox?=
 =?utf-8?B?NjUyaHV5NGFvTFB3N3hTSzhXY0ZMOWR4cGtTbWVXUGJrY2dhbnl6ZjNWczRI?=
 =?utf-8?B?RUFZcjV6dXdoWFNNYjlkMUNrbzlseGp2aGVKREorVjFIQ25EV2llUmF2dTZ0?=
 =?utf-8?B?azBTeVRkM3RtazNiZWQ3a2RuZVkvT1g0SXlvNk83aC9ZSFVacnlXVkZLdGUx?=
 =?utf-8?B?ajNIUXg2aTZBd25qUFQzMmJROWRGOFJnQkl6RkpaOU55MjRtbDFXejg0VlUx?=
 =?utf-8?B?dHExWUNTcXVKQnVuNTV6ZmtpUitndDBoRm1vSHRtZ0lLZXFoY2NQNWtxOXF2?=
 =?utf-8?B?WkE0N1lHZ2xTeitNUmpYQWlpTkxYU0lhY092UkZRYzNxMGJwcnROMDB2anpn?=
 =?utf-8?B?OUpTcU55SHBZU1YxWEtJbEFzMHRqdmJMcXh1ajNCUU50bFlURW9DVmJPMjdk?=
 =?utf-8?B?L3UvZU5ybjdSMnJ0eWdBY283aHkzbnJtSENHWjl3RzA0ekFRWXdYQXJnbVdW?=
 =?utf-8?B?UzhvdktzY0p1TDI2L2swaEV0Z2YxWHVyTkRlTFZJYk9iTTFMUG03Tm10ODdW?=
 =?utf-8?B?SlFjbG1zSjZLTWNpdERVY3JLSHVWVkwwM05KRGQ5S2dUeFBQZG5PWkl3ZEhN?=
 =?utf-8?B?WXNYMzZHUW9jcGZ2b1BKVXYyWEg4QWp4SXQyTE9vYmtYUzRGdFJGRFdkTVNT?=
 =?utf-8?B?cTdWaFNDMEk5RVVzYXlzVDhvcWFITS9QWXpmODM2T012S1dnclRVakg2dFQ1?=
 =?utf-8?B?ZkF1SGxSbEhRTEFwbStEaEMyMXRwQ2cvcE1tWnpwUFJLOWdKbHdrbkVvYlF3?=
 =?utf-8?B?b3EvSmhkZ1NVTFAyMHkzM29USG8rUSthZEhDS2M3aEtzWEFyOWZqTmIrVEVR?=
 =?utf-8?B?U3ZCNFdFM3dXaytLSmR4emo2MkVWV1dnR3U3RWkwSkV2aXMwT2RuNk5ueUVu?=
 =?utf-8?B?eXZ0R1ZlRE9ONjk4MFd5bXFQVUhNWFBaQVFEMVAxckRKSXlpRjNqeWs3b0RW?=
 =?utf-8?B?SDlPN1BtZEpjb3ZRdXg3cWI2Tks0d25xYk5qQ3FtTUl5WmVpZTNRclAyMENS?=
 =?utf-8?B?OWk5QkFUVHBjUWVLUStBRCtxNjdxMFZZdVpUWHZQMzZFMGN4USticDRsVU12?=
 =?utf-8?B?TWZVRElKeitnYzZmK0hiRkRDWTVHVzdyZjFLZTZHQmNEc0g4WG9NRkNaRHE2?=
 =?utf-8?B?Q2lqT0NEL2J4TDYzT3FtMCtMVlF0dFBzRXBHN1ladlFNaldDUUl3eWV1OTVv?=
 =?utf-8?B?cG9oOEdKa3BRQWhVcmRqOGRIZXBvSTg1bUFWRVZUa25rYzdMbnIvL3BmeDdy?=
 =?utf-8?B?Wm51MG1RT3RKdHRDbU9zU24yVjVGOFJROUZ3K25qQTFBN3FQbVZxc0JRVHNy?=
 =?utf-8?B?dVVjMjJOdjRwVjdRVlhxNDJqZklhRDdkaTYzc2ZlTk1VMlFQREpubUhIQzUr?=
 =?utf-8?B?NlBQaVZ5QVhzdC9aSk1yVlFJNU9WUHg0azJlV0t5ckszRG05TXhYaWVwa1Zy?=
 =?utf-8?B?YWpaN215WGNkYW9SVGNRM0txeThNUWs1dDRrZ010anBqY1BDSlpleUl4V3hC?=
 =?utf-8?B?Zmx6Z0dPZUlRL25VWWJqd3VIRHEwY0pVbzd1UFR6ODRRK1dnR2NmRkRLLzJq?=
 =?utf-8?Q?OqHIaqfYQ1HSMI/RPHOl3oFfXugIR6KZLS399Xp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2tSVm1xM3FvYWdKRFVlbDlxRkFvcjFiYzVtbFUrMnJBMVh3Tk1qSjROMnRu?=
 =?utf-8?B?V3Nkd2daaVlTS2VQZ3dNT2c3ZGdJK1dZRi9RS01YVlBib0tWcEoyUE9pQ21Q?=
 =?utf-8?B?eEJIT01PenBWWGx6Q3A4SWJaQlJQY1p2SDI5NG1YdW9BS0s3ZlhIU0FJN1JN?=
 =?utf-8?B?Z0hTZUNWSlNnS3plNllDeXlIWUZmYTlYaHJTQ2hLb0xtVmZDeHlmSlhEN1M2?=
 =?utf-8?B?V2twZ2FTbFBYUGJ2QitsV2htNGNVZVA5dGpLbWZnSFRuZFZVTUJOZUVlNnAx?=
 =?utf-8?B?NExxN08yL28wUStNKzBaSXQyWWNkNmVlM2pPdEFjcy9ReEdHWUt5Nmp6NjUz?=
 =?utf-8?B?R08wUmg3aWw5Vy9jNjY5VUVRMStna01rM1NPWlE0NlE2SURDN1BHVW1uMzl1?=
 =?utf-8?B?Tjk0Nng5aWkxQ1BSYlZtUVYwSjM1dTlGM2NZVXBLYXltMmVla29Ha0NWUnVI?=
 =?utf-8?B?YXZjV3crRHNyaW9hK284dUJGOU1oNjVhSnhqZys4UXdwL2dVa21ORTd1dDdj?=
 =?utf-8?B?T0U1QXR1Ynl3bnJKL1BQZjBoektVOFd4bHdpUWNTanNBSWhadmFxTW1Za3A3?=
 =?utf-8?B?M2RaNEFGcTYrWWIwa1BEYlg4N3Q0a3N0alZqcHRJU01kdEt2TFI2NHpGZUd5?=
 =?utf-8?B?NWFOdXRoc2FOYm1nckV2ZFUzTVFzWktQbVV6VjlIWUc4V2FRN0FDc2ZKb2Zs?=
 =?utf-8?B?WmZPV3p6Zi9MRVRaNEcwSzVGa2xSc3FPaE9FdDNNVzd5S2FuSjRoblVpbWZB?=
 =?utf-8?B?bFROMnl5d3BhVVJENDNhRWxHR0hkTkVUYjlDeEh4L1BpR1djd3E3eDVidFNH?=
 =?utf-8?B?RkJiSWpUQm5MMXVPVzZrSHQ0QnEwVHJ5M0UyTGJRN2tlWWpjc1BEK3dyazV6?=
 =?utf-8?B?Tm1oUkJyOHdOSDExWUV5Yy81TjhPNTJudG1HNlVnbWVDR090L3ZRN2ZmLytp?=
 =?utf-8?B?VWZKcTlUZzkvMlBFNUJSUE9UZ3B5dnE4OGxPcTVLTE1XbG0wOGZRbmtaZERz?=
 =?utf-8?B?aXhWOEx0UEdSUmZaeXF2d3IwZkRZRjVrQ09FTkR5QkllSFJhRFFUU1gwcmx2?=
 =?utf-8?B?R2NZNm5WSG1vb0lkUGVlWlRTYTRzR0NLRjFqVG5LRjZmNVhEYTRNZ05MM2xJ?=
 =?utf-8?B?d1hkaWpFbndoL3UvdXljdmFmQ3dzUFVLUEhlME5wd0tMV0Evb3UydkMyV0hF?=
 =?utf-8?B?S0tPd0UycTBYQjVyZ3YrTHBIc3N6WWhlYndaUE1rQmJORkJ2aVBZYXkxRG5L?=
 =?utf-8?B?eVFyTFQ0cU5lZDVvcGVMUFprMGF4Y3BVZjVaZGtLQXMxelBGQ2Ewc2U0RnVs?=
 =?utf-8?B?Z3BZSE1mRG1KOWkvVVdpNk8wNG1ybUR0aXY4L29nWWdGbjdWUWJudkRwTWtq?=
 =?utf-8?B?a0dQbXZndlVEMjZsa1p4TDVuSWhvRHV0dTYxK2F4WEtaYlQ4YjFHa1gxQ0o2?=
 =?utf-8?B?MVpLWVo5VGExa002ZWVvc0hBZDNQRmZyeXhvRGt2UEU0N1ZxTVVGQVM1ZWU3?=
 =?utf-8?B?Q0duVDFjd1hxYml2WmNvNVAvNVJiR3psODRDYVdxQjBaUEhxN21RWU10L3pI?=
 =?utf-8?B?amk0Z0lsM1A3UW1jaHVPM2htenZMYmRUdUpPYmhHSXB0NWZTd3dFZ05wbmZl?=
 =?utf-8?B?ckhIVzhUMGF0QlJXYUdaenM4TXh0cG9xdnA2bmREMzNiRWpSSU9DWU5ndWZq?=
 =?utf-8?B?VUFYTHNnTzFybG05dCt0K3o5dFpCS05rbVJnM0FUVnRXbTdiaFFtUXhGVXNI?=
 =?utf-8?B?NFdqK0NWbUhXSERpWTRDM2ViNkJaS3dnb25sN2tkYm9IUEFUNlRWUkhPaWts?=
 =?utf-8?B?N29neE9LOUJOb3R6MElPb3dpRzRGU1JOUHRJVGZSQ1d4b1I3N3pxeWQ3c2x5?=
 =?utf-8?B?b2U3K1dDdEpoMHZuc0pUaTNUcEVXTUZQMnQzMkgzRUx1bEtzL0JxMC9NY01M?=
 =?utf-8?B?eGxFZVZrbzBtTmd6UVhscU50RU9tSjRxK1VmK1dqZEN2eU5vNUFTWU9EbERj?=
 =?utf-8?B?RGZGUUowbXhyVHhlVU9OMkJSUkJDdTRpaDRHeFEzandLWTdDWXFVU3VTSHZm?=
 =?utf-8?B?bis2TUsvQjlZVlJSQkNXNSs4bDdnQ0dmRVNpbFRBckZINkNvd0trcXhYRk1t?=
 =?utf-8?Q?gVNVVpG9GuS34zaYgiQMMS2M/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813af437-07d8-49af-40fe-08dcef583c67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:35:43.1276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd/z6SdKsUfM9SUruRNLPBIm4vj1SGLaxesYtojTyZw7TZsLXBpM9PgA16pFRVp8YyAtjs45Uv5AcsSZ04K7ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7214


On 10/17/24 22:49, Ben Cheatham wrote:
> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>> initialization.
>>
>> Move helper functions from cxl/pci.c to cxl/pci/pci.c in order to be
> Wrong path, cxl/pci/pci.c should be cxl/core/pci.c.


Oh, good catch.

I'll fix it.

Thanks


>> exported and shared with CXL Type2 device initialization.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c | 62 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h   |  3 ++
>>   drivers/cxl/pci.c      | 61 -----------------------------------------
>>   3 files changed, 65 insertions(+), 61 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index fa2a5e216dc3..99acc258722d 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -1079,6 +1079,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, CXL);
>>   
>> +/*
>> + * Assume that any RCIEP that emits the CXL memory expander class code
>> + * is an RCD
>> + */
>> +bool is_cxl_restricted(struct pci_dev *pdev)
>> +{
>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(is_cxl_restricted, CXL);
>> +
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map)
>> +{
>> +	struct cxl_port *port;
>> +	struct cxl_dport *dport;
>> +	resource_size_t component_reg_phys;
>> +
>> +	*map = (struct cxl_register_map) {
>> +		.host = &pdev->dev,
>> +		.resource = CXL_RESOURCE_NONE,
>> +	};
>> +
>> +	port = cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> +
>> +	put_device(&port->dev);
>> +
>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>> +		return -ENXIO;
>> +
>> +	map->resource = component_reg_phys;
>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> +
>> +	return 0;
>> +}
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map, unsigned long *caps)
>> +{
>> +	int rc;
>> +
>> +	rc = cxl_find_regblock(pdev, type, map);
>> +
>> +	/*
>> +	 * If the Register Locator DVSEC does not exist, check if it
>> +	 * is an RCH and try to extract the Component Registers from
>> +	 * an RCRB.
>> +	 */
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map);
>> +
>> +	if (rc)
>> +		return rc;
>> +
>> +	return cxl_setup_regs(map, caps);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, CXL);
>> +
>>   bool cxl_pci_check_caps(struct cxl_dev_state *cxlds, unsigned long *expected_caps,
>>   			unsigned long *current_caps)
>>   {
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index eb59019fe5f3..985cca3c3350 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -113,4 +113,7 @@ void read_cdat_data(struct cxl_port *port);
>>   void cxl_cor_error_detected(struct pci_dev *pdev);
>>   pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>>   				    pci_channel_state_t state);
>> +bool is_cxl_restricted(struct pci_dev *pdev);
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map, unsigned long *caps);
>>   #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 89c8ac1a61fd..e9333211e18f 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -463,67 +463,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>   	return 0;
>>   }
>>   
>> -/*
>> - * Assume that any RCIEP that emits the CXL memory expander class code
>> - * is an RCD
>> - */
>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>> -{
>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>> -}
>> -
>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> -				  struct cxl_register_map *map)
>> -{
>> -	struct cxl_port *port;
>> -	struct cxl_dport *dport;
>> -	resource_size_t component_reg_phys;
>> -
>> -	*map = (struct cxl_register_map) {
>> -		.host = &pdev->dev,
>> -		.resource = CXL_RESOURCE_NONE,
>> -	};
>> -
>> -	port = cxl_pci_find_port(pdev, &dport);
>> -	if (!port)
>> -		return -EPROBE_DEFER;
>> -
>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>> -
>> -	put_device(&port->dev);
>> -
>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>> -		return -ENXIO;
>> -
>> -	map->resource = component_reg_phys;
>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>> -
>> -	return 0;
>> -}
>> -
>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> -			      struct cxl_register_map *map,
>> -			      unsigned long *caps)
>> -{
>> -	int rc;
>> -
>> -	rc = cxl_find_regblock(pdev, type, map);
>> -
>> -	/*
>> -	 * If the Register Locator DVSEC does not exist, check if it
>> -	 * is an RCH and try to extract the Component Registers from
>> -	 * an RCRB.
>> -	 */
>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev))
>> -		rc = cxl_rcrb_get_comp_regs(pdev, map);
>> -
>> -	if (rc)
>> -		return rc;
>> -
>> -	return cxl_setup_regs(map, caps);
>> -}
>> -
>>   static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>   {
>>   	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);

