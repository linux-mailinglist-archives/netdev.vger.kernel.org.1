Return-Path: <netdev+bounces-234453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70BC20C03
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48E0B1A650F2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B67F23EAB8;
	Thu, 30 Oct 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lEcEfnwP"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9026FDAC
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835745; cv=fail; b=t6XPa2yUFmGN50oWiMaYuCs0mlJ7iz7EtvW6f59/BdD2ZuP80Cd5FZjUe+eknyUqBCYJtc9/TnLeCVf01uRB9uoFVvJ+uReqyi748Igb/PB0PBXTTJOYOYtjkqO9y6TAc0PjcR+ctb7C3sfRhGRYy0okTP5sSNZS8WxnUo/Ov+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835745; c=relaxed/simple;
	bh=2z5CAMwDpL3QgbicmORdjkx42K6cPYVgg5QLKcCNo2I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KeIs29GUPaRKubMElbS88A468I+fqMJZ5JiwDyADPUBN2y99hBb5a8ZhDulZGvzFzyHjxIo9KrLHbKHBGrvsdPYo2xRRUFHOmpvK6DgngJ0k0xSpszt5UBxXcu4xithbWubzlBa7grOn3v1FRn9dKUtPANx+NwyXuNcsM+Y1K68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lEcEfnwP; arc=fail smtp.client-ip=52.101.56.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2MX43IsSBFeNrb2Fm9U8YrAeiuK4vIk704ecpoHIHxU3bDEKcNa92EbUwotKbz/B1gPRhwchsUyPzmLhgyL6GGMVaCGy2RVQ7JhKBOnlP06p4SeaIfHagEDc185Kar4+rutx7SVZ8WpZxSO+QiqaNH8UAZUGHQrPJGE5KZA5A8Tp1ooazrkZZ8jVJLcLt/SzU4IEJCDHyRMGrQWjacuNfFG4B3awi+VTy4vSj9nQKPf+q56iKbXKC5SkZFOhSw64xpFFNrkPrlEI+yoFx89s/yLmb6c7HiB0SsDOdRtqemFLhjyGZw07mDJCNz8Jv/g+yQ/adC4dcxxKjn43NrVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95gDTjppqckmkXR+04vBTTzr8hxISCRSg4zpKa2pofo=;
 b=GWQTQxds7KmRXAd0BHTdMf6F0uPOYOcI7DXoSyj2OnVIVDE/j3ab5aLVzJDLiuBzMqA/IzEhXpAR9PcgE865OQk13i9iCcZAxZ4RhuxP/VaQmVRqYBlpOUalzywk24fC9Fy9B9k4cP4qzrxrohU7X7pJ/CS2yTt/STWTre9OU3adVYfhV/SoEdkWQbBiUmqvno1lZNS00CGyTzwa7ZlJBo4ulZMCBLkzYs4tn1dXqfFP67ZFudqJ8zu5z+8E8LarKMT3/tRhSvppAhanKohhI5rGYkuxRzSRlQTfcsULbGbJyPBQ6RPQZo3lU7mhaDBYUs45BD19YgT7las/gqIHHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95gDTjppqckmkXR+04vBTTzr8hxISCRSg4zpKa2pofo=;
 b=lEcEfnwPwnZ8YaKhj1Sns8Zpsoq0iIHewz6Sk7ERM9s3lMZRRvp6i7za1zhuWGnJpcS13ku8ZA7Nz5YLPHy1aK9aVS0IefoJxHRrcuS3SwOqbpHcsugh6wrM0Z7dlgNPyJCJcDpdrMtNwDBhC2AngrqpX644uZS8Aechh4L3ocigjlaN5JZ1zARpUrA83L6R8vOIwJvUjLOiQ30eUBhjbD65uUfRobuT+HMTjv34wrsBQU1F8CZYaoWrk4U9PU+jruFkYPOdV2UWUX7tNoMisJ7V/v95ucYtL/VRObAPFOZg9Fhy4UT6FuhQSpy91pZ2D+j/0+GA6zJTv1bG3Iejow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 14:48:59 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 14:48:59 +0000
Message-ID: <8a7ecc3f-32c8-42fb-b814-9bb12d53e29b@nvidia.com>
Date: Thu, 30 Oct 2025 16:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Jakub Kicinski <kuba@kernel.org>, Matthew W Carlis <mattc@purestorage.com>
Cc: adailey@purestorage.com, ashishk@purestorage.com, mbloch@nvidia.com,
 msaggi@purestorage.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 tariqt@nvidia.com
References: <3edcad0c-f9e8-4eeb-bd63-a37d9945a05c@nvidia.com>
 <20251029164924.25404-1-mattc@purestorage.com>
 <20251029163311.3ad31ac8@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251029163311.3ad31ac8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH3PR12MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 930f2654-6525-49ec-d0e5-08de17c3756a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzMzbGl0U3hnVTJZUitWS09qRklBSjEwWjB2UkMzL0hvYVlKRVNqK0YzWnNV?=
 =?utf-8?B?YW5NenkvV05wVEVmU2JUOGJFdlZpYjFSZVpYYXA0bm1zSHFTWFJvTCtVTGtq?=
 =?utf-8?B?WFZWdXJ3aUxtMmFsbW40eFh5ejdvK2VVZTJPaUJxOGkybmNzYWMwU21tVDNX?=
 =?utf-8?B?bHdNRHphVmc4a0JGcU1MT1VqZUhSbGdULzlCRUtTaUphUitDUDNwSm5rYXUz?=
 =?utf-8?B?M0tRTHZqaUY2NVJwaHY3VEdtSWk2YnpWYnAzUjRUYndyQ2VPTWtPMzJPNGZD?=
 =?utf-8?B?UVBuV1gzSHVUN1hXSE1kMUZySVE5RGlFYysrcUhseEN5OU9ibGFkTEh2bzFP?=
 =?utf-8?B?V0JhZVRzNHdtWGsybG5wQUNZcklUYStOUGNBUjduTDU3Z0xyQzR1VURRWi9r?=
 =?utf-8?B?T2pPQ05HcGxHNUV2TmJSRnkvVC9CWTRFTmtHMG9XUXB0ZWhGWVZackJINXJX?=
 =?utf-8?B?cnBhcFNtZklRUWdTaFQ5TWpTNnh2L1hwVnF4ZCt0Ulp4UEk1akk0TTM4cGlK?=
 =?utf-8?B?SC9iVjFnQUhjMDE3c3Uvb1h3UUJIUDQ2Q2oxcFVJMUYwM0JSdDdINjdRc251?=
 =?utf-8?B?WDcxY3RXbVBlbUNiU3U4SHN1NUs1NEtROWxENkNsa24rVkk4aGM5MUM4QWsv?=
 =?utf-8?B?RWwrczZrZ0RoeU1CZ0l0T09pd3NRQW1JcnBja3JiTkx2ZFFrWEkvbExEU0Vu?=
 =?utf-8?B?NzBrOFgzbG8zMndpcEthQmI4em5JTzBQUXdPMG9FUHhQQ25JTEJBamhUL0tm?=
 =?utf-8?B?aHRubjZZZ2pleDc2elRJNnpvODRuRFNxOTYwOVZwQlBZRVl6b2toM2E5bWFu?=
 =?utf-8?B?QUR4L0YzU2w4cDMvY2J1NnJTbTZRdDdlUFVKeHpuZnlMNlI3SWovdHNpTlJM?=
 =?utf-8?B?dHBnTzh5M1JlVHRhdVpGQjhkZW0rdzFoM2lDdXp4NGlLUStYWStIQUVoOWhY?=
 =?utf-8?B?b0NaQlZ2UytiNGUwVzlsQlFlTnJLNjYzU1BYSUhsNTRpZ2hLd3ZVRkpXNHBM?=
 =?utf-8?B?dGRxU2kwOVBMTFpnY2xCVGRGUzF3eFlKdGw4WEphN2VjT21Jd24yaWVoVU1K?=
 =?utf-8?B?dXVCQUo3MXo1VnBtTVpFczh3MkdJZVFtUnlLUmw2bko1VCszMjR4Mk9EbUgz?=
 =?utf-8?B?OU12WnBxT2xsWUQxdzlIY3ZTa0s5SUlQQzRKZC9DVHYvSmYzR2hQNzB5MXNT?=
 =?utf-8?B?V3NoOHFtWUR0dWpudmhKendwd1VDVkdKaDZ5OFJaQTdXOE1zR3hnTW5EZldS?=
 =?utf-8?B?dGtEUDBwR3hFbnNxMldiV0xOVm5QbW56WklscE9QL2NuZEZqa2ZmVHZGWFZW?=
 =?utf-8?B?azRtcnN6K0dQcU9Vb2NTalJzbG1kZFZVME0xK2FLUG5yTG9tTHJFNGxjeDBh?=
 =?utf-8?B?K2ZVSkJPQTR3U3l5elQwN0ZtMjFzeTVzcE1tY0pTbjYrcEtGRkR1TFIrQVZm?=
 =?utf-8?B?bnIvV1luTms2dWpHSDJWcGtsVlg5cyt4ZnIrVzhEZm1KczhpNTB4Uyt3NlpM?=
 =?utf-8?B?b2FwT0QrQ0h2aHdtVmxVUnFGZVdjdHplYUtPbEsvTWZBN0I0dHpzMjR0T3Vm?=
 =?utf-8?B?bjBEdmJlQk05d1Y2MlZPcjE4MDFoTTFMVzZhYzdpNFl6VWJkYlUxMXA5bG1D?=
 =?utf-8?B?SVNabkd6cUNoVzlFd1hKNWMweXVjQTVHT2NaamRLK0w0aWc1M1ExOW8zYTNT?=
 =?utf-8?B?RnV1K0JVR2M3cVZnWTZTTHl5a1dRQ0VSL2pHWnMzV1JpTFFWMG4veVVSRXVQ?=
 =?utf-8?B?a1VpeU5QVVNFUm4ySWcrbmczWnlCaFU3b1pSYTFJa3ZrWFZvTC9EK1lXbXdX?=
 =?utf-8?B?bWRHcWdSMmxWdlpLR1IzSU1LNzc1YzRIZGxtOVJvR3c0dUUvOUNMdUFlc1hL?=
 =?utf-8?B?YXcxdkpHM1lLYmpxVnZOaE1LdnlHSXdLN2xiWHBKZWZrc0ExN04wS1oxc1Zn?=
 =?utf-8?Q?hz2jB7iqXoUJ7vkRuRm33+rYX+raTqn9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGp1b0MwcXEyUU9sTngyaVkrQ2d0T0tJTUVYSU42bWUvcHA3bmVkNHdoRVJZ?=
 =?utf-8?B?SVdVVEF3bG5OeG00MHNodmQ3aXd1Sm1pVjFjbUVvT3ZWSkZnMXpsWXpQTWpp?=
 =?utf-8?B?QlhSUkNkcTN3eHRiTXNkZGpzUGZ0L0hxK2pHSU9jN0VuZlR3NHI3dlptRGlv?=
 =?utf-8?B?MjJzQi9nRlhpeFM4Ny91N2FhK3lQSVRRMk9yUkROWlN2Rnd3WS8vcjBVdjRa?=
 =?utf-8?B?MUp2bEcwbVh1dGl6eVNURVFrSlY1a1lkTmtjbDJaNEcwbzE3c1lyK2NIOWY3?=
 =?utf-8?B?STdrUitPeThJOWNHbkUzbkNLd1Z2R0lWWFZyVWErL3h2bjQ2OE45YTBINkhx?=
 =?utf-8?B?Ni9Oc0I2cDNRN0hQQkNVU3BjQ2lWelVnTnRKSitPVUFWby9mc1RIS2FFWS8v?=
 =?utf-8?B?M3l5RHZyUU5BeEVRZCtVYzlWZU1rSDlRR2NIbjR4eG8rRGIzOTJtTW4zcGw3?=
 =?utf-8?B?VkRZejY4MjViTlVOOXlUMXFCQU1TNGhmenlJZHpjTnh6YXFPZVNNY1pxVDR1?=
 =?utf-8?B?RWtsNDRiaTBJdzBLbzRZTC9oZVhZcVBCTHd4aWU3VEk4Qk9HbWVodDhnRUgw?=
 =?utf-8?B?ZWVvZ1lrTUQ3RFUwZGpsNUJtc09lWXBlMHRvTHZvMytZYTlyakwxZlBhSllJ?=
 =?utf-8?B?ZmJuR004Mng2L2drVGo2Q3JSdGsyR1NwYkxvaGU4aFRoQzlVSmg4NXpsdEhC?=
 =?utf-8?B?UWIxTVhXR2FpWHA0MzFhdjdkYnJ0ZzBSb3A2WmlheTBoeHpkRytIYW5sZ2hX?=
 =?utf-8?B?dDI1ZlRNVXdiWEZoaGdIR0h1UGcreVBYNFZKV1hUWnYyQ1EzNkRLd21ORjJj?=
 =?utf-8?B?L21FdTNXNk11NnMrZVFhSFpWNk5UYjVLNWFFOUNvNWdYdFRvaXNGMEQyQmJk?=
 =?utf-8?B?cEtwVGJHMEc2VklqeW4zRDJoZXFHbjhWRVgveDJWa0Vmc0tJMlJMRXU0N1BC?=
 =?utf-8?B?UFRzcVUzcTZTOUxaMUNtWEdGU212V240NEtwckxDSWR6YldMcElUa3RuVE5j?=
 =?utf-8?B?U2t5aXNvWTZwWHhwSHZFTnhKNkVKbWp5ZUdiYjc2SkZ0NnUyOC9lY0JrV0NH?=
 =?utf-8?B?bTVkd0Q4NEdHbVpJU3ZGb0VRbFg4WmpibzM0V3Iza2pLN2lJNGh2U0N3VG0z?=
 =?utf-8?B?ZjYxNmozcWdadzRNRGVpSnp6ZWVzVVdKV01JZWdGRk5pT3FZcC9xN3V6TWQz?=
 =?utf-8?B?YjBONWo3OE1iYzVOWGNQTzVEclBEcFB2VFhNUzhNcjljV2VGSGJtVDFRWFpa?=
 =?utf-8?B?QnNNUEJUSnk3ZGdpR1VaU1FEb2NhZ1piRzc5dE9DNUdnT0MrR1J2My9xTTBO?=
 =?utf-8?B?N0tUVnhRVEMxY1p4OHVPblVnMklvZ2FtU3BoMmdLYVgrOVBVSE04djMzVkUr?=
 =?utf-8?B?dlVPZWwyTkVQMndKNG9ETnFpeVV1a0xPd0ZGeDVCKzA2Qkt4QXloaHR4K09r?=
 =?utf-8?B?Wks5ODBYdWdzZC9yYlBKcVUvV0pIMW9WU3U4R0FTWURUbzYxNWY0eHExVDhO?=
 =?utf-8?B?aVcrVTA1b3VMQkU0N0VqVGF6NWZGOFBuZGtheVIxSUJ1QVdGTnQ5THNwQ3Jj?=
 =?utf-8?B?MkpsMDRtY1NjTENIa0RYK3VUNG9VVFF0Vngxak5LLzE3OWR4Mll4NXpFaFRX?=
 =?utf-8?B?bldWd0Rac29CajdrWVBUUkhyRUdubHdhdkJHRGNpOFNCVWU5OUZxTWZZWjZX?=
 =?utf-8?B?Zmo1V2Rvb3BPdEtZNC9KQjBnd2JRWSsxWXVQaGVuQVRKWFhvL1Vqa1AzK3Aw?=
 =?utf-8?B?S3REYW1qTU94VFZzNFVxZURyUWhQaXNYWi9Ibi82ZkF0dTg1U1owREllNWlZ?=
 =?utf-8?B?dFY4cmhwTEQ5K3EvMTJ1eUpwbWdXUWwvTDdWZ1doSVpkMkg3dzJHZkRTcXJr?=
 =?utf-8?B?T2x5Q25VUGlVeVlpYWtuOVphVWRCVWtGaDluUUNXMUdPcGdyN3JGQXcwQ1lU?=
 =?utf-8?B?eksyQ3ZvRnNrMURrUWh5aFRKM2Z6RThSU2UzUUd5OGZJWWdaTDFid0I1aDg2?=
 =?utf-8?B?OFpObU51Nm1CWHROdDBaN1BWTTVFcU95Y3ZnTXQrNUZtU3VaeURPdU1oeXpM?=
 =?utf-8?B?aytvNFVNaEtQbEl0cm9iaHgrdlVVNFhPQW1EMFpiUDhRU2JuR2QwbytyTmxi?=
 =?utf-8?Q?ErJfU6SSELn/7bzQIo31PnJNW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930f2654-6525-49ec-d0e5-08de17c3756a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:48:59.2368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sKMWByleFwLNw98wC6INymAsb3U5CVjphCLoVxgFMu+oJvDuotVfbcf2DZ8tX2jg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7572

On 30/10/2025 1:33, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 10:49:24 -0600 Matthew W Carlis wrote:
>> On Wed, 29 Oct 2025, Gal Pressman wrote:
>>> Allow me to split the discussion to two questions:
>>> 1. Is this an error?
>>> 2. Should it be logged?
>>>
>>> Do we agree that the answer to #1 is yes?
>>>
>>> For #2, I think it should, but we can probably improve the situation
>>> with extack instead of a print.  
>>
>> I think its an 'expected error' if the module is not present. I agree.
>>
>> For 2 I think if the user runs "ethtool -m" on a port with no module,
>> they received an error message stating something along the lines of
>> "module not present" and the kernel didn't have any log messages about
>> it that would be near to 'the best' solution. 
> 
> I assume you mean error message specifically from the CLI or whatever
> API the user is exercising? If so I agree.
> 
> The system logs are for fatal / unexpected conditions. AFAIU returning
> -EIO is the _expected_ way to find out that module is not plugged in.
> If there's a better API I suppose we can make ethtool call it first
> to avoid the error.

There are other cases which will return -EIO, but do not necessarily
mean that the module is disconnected: unresponsive module, i2c error,
disabled module, unsupported module, etc.
We cannot differentiate between them without the status print.

Changing the log level makes things more difficult, as most production
servers will not enable the debug print, and the logs would be harder to
analyze.

I asked before, maybe these automatic tools that keep querying the
module continue to do so because of the success return code, and that
will be resolved soon?

