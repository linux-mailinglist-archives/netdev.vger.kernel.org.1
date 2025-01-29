Return-Path: <netdev+bounces-161478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D957A21C61
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BDB7188580E
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024061B87CB;
	Wed, 29 Jan 2025 11:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dkf6ghm7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759CC186615
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150655; cv=fail; b=Lskr1P+vtpuoYAY7EQ9KfOIFrhfub4BuLG8qV+ZtS6dWMYUoZNJNe5R5+gMNdaNm/6UPhhAH1j/zX2aBKBY+C3dswQzZN4mSMJl25t2WT/4KnnuHBPfwjxIsth7dlmQeHk2LH+X+Dcsp59UQ7bha5wzUl/aov5KjVlw69QmPGAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150655; c=relaxed/simple;
	bh=nITtL3kdG5VbxLA8O+SJ2mgflNWhU7BrJNUOkBoiq4k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIQDCOqpf52bjCJBcCxAQT7nCf08vExwhZ4W+0NCilAk67lSlctVVksI+MHCyeAtJ0zW6CJRH2Q0ET7G+/0hh8BwJImg5G0Up0R7j/PXBs6SFNtaIUlhbJMw0ssI5X3mWDM2TdgXrk6LWXhNZSFCZOCudX+dYXyWhJW6FNnZPJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dkf6ghm7; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugcR2+KpKgWhvK71lP5YLiAjxMudf/zlk0lVqgEGRsPKnEbitsMjNGFQl8wOcaJHkRqrb579n4vaeByiNpuKjD2pKmNQ5IU/LM3fx7peqHBBP8qjJxHoP34Kps2BtUwutDDWauUquANCMo0DYKls8sa56pMbdc845opDsXszSLEHX6Ma2U8aBmgcM5CX/p9wfYY80jN9Lf+jKJKTPlSibfsl1of0SjvMFJ4whJIxk7AKsxhdCTV3mY2IZpr5lhyQXm+lcIfjTpucibS9g6Bhz6rmIHSW9M8F6sWaHV3/gWQIi/o/t5z87cLC/YZJOcJc9Im3PQrKrQ12TCv8vsoW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++CvEWMq8BOFwMAPxKbzdwdhUs1cSYGspxEYQ3TfSIk=;
 b=Ob4CDdWEyedyB27AMuPYVZrGGrVcC5VPvbY7wwZX2FB7y/rUwfF3goYtrqVZMxk4ZSV9lwJwic6UB17yAZX48BabJn20OFxIGA1gEP40IGEmUCpNcwUkp1taWKgUGiNxmZAvDrgPz1se1SpXc1oxKEk8J2as3db83Uk51LJpjUb4/4wLhqSlfperlT9JDOVQ1bkuH+OsA9QfB2OHhoQIoY5NEJ3E0kFkqgUiE3aHejAETesn9ln6omDpyV0k0vXqKX0lY35SpAc9Lv9Rhi/VFNQzbub7PI+JkMv6AZgH1TJ0iV9ejjAfnxXCmRT4vUmLe8ke/sWk0GU+BVGjP0BF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++CvEWMq8BOFwMAPxKbzdwdhUs1cSYGspxEYQ3TfSIk=;
 b=dkf6ghm75fcDS9f7yoq0aFF2qdCjiiTIesnnr2efur/qb3L/GinYl3xXj4trg+j0v1AmLVTfHoHaSnJRPh+IGNE6uf4tczr+k+SYvT5Zn/zsqTKw494sQSHwDE3AMn7UPT466LhqBHj31zf3WfPN9kjS5sWpuisvOpWo9glnycFDoObZIGJtyE3WYsMRBDML/3Ig5Vw9+fVnNOogMBIxmoaXKSJdp/LU/cBY/B4Dm4HzcrPlmWVpiaC7+X3zuGAuGumZIfeiQVOF0h7jcMVcoo0rUFaDx5gdpIyLOhgx6qNqJKzLGOikpqw1m69Upxx6toxPmRF8A92XDGDTmgRzKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB7532.namprd12.prod.outlook.com (2603:10b6:208:43e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 11:37:31 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 11:37:31 +0000
Message-ID: <5efb4e9a-6520-4a36-a946-caa545e68f15@nvidia.com>
Date: Wed, 29 Jan 2025 13:37:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool-next 09/14] qsfp: Add JSON output handling to
 --module-info in SFF8636 modules
To: Jakub Kicinski <kuba@kernel.org>, Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mkubecek@suse.cz" <mkubecek@suse.cz>,
 "matt@traverse.com.au" <matt@traverse.com.au>,
 "daniel.zahka@gmail.com" <daniel.zahka@gmail.com>,
 Amit Cohen <amcohen@nvidia.com>, NBU-mlxsw <NBU-mlxsw@exchange.nvidia.com>
References: <20250126115635.801935-1-danieller@nvidia.com>
 <20250126115635.801935-10-danieller@nvidia.com>
 <20250127121606.0c9ace12@kernel.org>
 <DM6PR12MB4516969F2EEE1CBF7E5E7A03D8EF2@DM6PR12MB4516.namprd12.prod.outlook.com>
 <20250128141339.40ba2ae2@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250128141339.40ba2ae2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: dda14965-7e91-4d2f-b380-08dd405950cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUV1ZEVUYlpidHpqVjZKdFltd3Q5UW1LOVJtL0pWNjU3clpmUmVqakpkUlFj?=
 =?utf-8?B?bmNINE1FOXNrR3RvcVZTN3psTEtidVBET3M4NFdBQk1lZjZGRVJ6eGlZcXBz?=
 =?utf-8?B?MzI5N091dzVaMW0yQkZnRVJNSVZQNWJwY3FCNENjdVNmZnhXMFAxaDZaTG4r?=
 =?utf-8?B?aUgzeU82ZFoybnlCOTFHeXNNUVVJZEtZSFprZXM3bW96TVphcjJITDBva2pv?=
 =?utf-8?B?aC83UHNRczhjVmVlM283bnRtTk5KSkFFTjYzY3NkWTY4TFFjK3VoTXNzUnJW?=
 =?utf-8?B?emdCU1YzU2pwNlZXZjYvdEFYVUlSdGlWRjBUMGk4M0dUZGdjRDZxQVRKWStq?=
 =?utf-8?B?NkhFK2w0VFhlc2Qva3FYOWtXVlhtSk1SZUNPbmwvZ2VhRVZLdXN2T2xzMVRh?=
 =?utf-8?B?WkI4dlFrUHJ0cjlHc1JGcXZzMHM1eTFlU0gyNXRmekp2bGFzRjNFU1JhdDBs?=
 =?utf-8?B?eGdNTkgxMVptTGlheUVXQlYzckJsWEQxMml5ZUcwVkFYS2lETG9xMVRTWEtO?=
 =?utf-8?B?aFB3THdVdXU4ZnVRRWZjNEVFMkNZOHB5Wmx0SFBjNjI5a3p5dkg5N1M0WXgz?=
 =?utf-8?B?RndjeDNZa2hUdEVuQjBjZk1HdmpCSlgydksvTU1CeXZEYXgxaDlRT051QWEv?=
 =?utf-8?B?VlhuRGRVR0F0RmpaY3pTdkx2VG0yL0EvZGpPNk5UcDJSSEFJSzRiWW1id0tj?=
 =?utf-8?B?dEJsUXVyb3NWRVl2L2pESmg4NVNwUndsQmNXdEtTWFF2VUtobGo5UVRzY2pu?=
 =?utf-8?B?a2NmWVBuZVA3VTN1MHN4bVRIT0YvazIySjdUbWovRU03aUMzd0lsNFgrWlJr?=
 =?utf-8?B?Y0k5cDJ3QWcrQ0tjQldFaUV4eFZwamZ2T2JWMUVrejk3TTVFcWlVUFVKbHlT?=
 =?utf-8?B?WDVmcFg0V1M4V0hiU0FDRkUxcVBnMGY0V1YzR3Zvak9waWdxSEN5MVl2SEFP?=
 =?utf-8?B?b0hBZVZNMnVvU251SzdRaHh3c0dpaDlOZmNJdFRSc1NvQXd0dlZvVVdTMU9z?=
 =?utf-8?B?OUFuT0M0WnVSTjUwMDdkWmpPdGxmSTVIMjRGc2didWtLWjlQNTNQcHh6Tmcy?=
 =?utf-8?B?QkxmbFg4RzRpU0tDZDhTc25OY0xMWER1dGtQdmNuc3RHUjB0Z1FmcjNnK0hT?=
 =?utf-8?B?akJpQlVrNVdnVGRTTXFTK1JqalpJQWl5VW9YbzZWZlZoekYrcEtrTmFxNVhE?=
 =?utf-8?B?YmdNUHAybDFzYWVWWCttZUdaZFpwM0dIU25tM2dGVkV0WHVxRnlOT0dFOVdS?=
 =?utf-8?B?VXZyc3ZHMGNQOWUyY1g0VmYzNy9nNzArcUJYdUhNRkM0aG5zNkJvUVE1bnpL?=
 =?utf-8?B?V1VYcXhISTVUUjhXcWFFNW92aUdnYW9RejFRMXl0d2VycXp0Ris2VHVoMFlO?=
 =?utf-8?B?UXFPZnk3ZUZIVDlNQk5aZHNtQk5uQkhReHpmN0psQnl1SlRFY2N2MjMvcXUv?=
 =?utf-8?B?MStCSzhIOWhob3BRWFlVYWNXdHQ2M21iNS9OSXVlbk14V0Fvb2MweXlibHhO?=
 =?utf-8?B?WE9venR3N1VBWnlUMVphdUJPKytrT0pxL1NoUUQzL0JWaTlsVndBYXd5QU1s?=
 =?utf-8?B?TzNnYU4zdGZWaEthWll3bVZ3SlVoejF5QU9FMUE2cTh2N2lUYml3SjIzUmpL?=
 =?utf-8?B?dzd5ZlBDUi9TcFAzOC9yS3lSSGlhOWUyZUx4ZEFSMy9FQmp5aHIwWkhUS01I?=
 =?utf-8?B?eTRRK3NNWEs4dTNxdkZpQjI1Tm4yZWM5elNsNlAxbXBTUTBmR3cxZUgvYUZz?=
 =?utf-8?B?SDR3ZGRmQmVBY3lHU015dit0RzllbTFZdWxKOWt3Um12OWJLUHJGanJ0VVJl?=
 =?utf-8?B?QUthMHFjN1VBb0dEWXZXRXd6WDFMTGt0a01kZHhaMGxKcklXaW9CWU9BWWFB?=
 =?utf-8?Q?Zswy4OFDBAcnF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0tBaFo2bnliLzlWeC96Z204N202UEdEeEdWcmZhN21VZXVVUW9xZEozTVFU?=
 =?utf-8?B?UXRwZGtDVzBoSXZBdEZuNVdlOU10UmxwK0dxclloSVp6VXdpS2R5c1k4a1cx?=
 =?utf-8?B?RzRPck1ab1lNZ2thR203UDlYTUJJdWFwZmZsZ3hHMHVHMDczS2xqZzZ1Qi9F?=
 =?utf-8?B?ZkNJR0kvTE5DVmdZN2Evb0hCaDZSTVVvRTZJRlBvRkwzYzBTa09VVzFuREVC?=
 =?utf-8?B?RW1wSXY5YVlCaWEwVG5KSVNwbjRlejRDYVU5UXVaZ0psVm1qODEzRG1HNUY2?=
 =?utf-8?B?Y2FYOERUa0Y5eUxyL0ladFg1K045ZEZobjdTSVV6RTJFMW1yTWNIZlRucmR1?=
 =?utf-8?B?N0pZekhXRUlPVTl4K0tUWXZoV2Z4aW1qaTRlU3l5a1VTUHRvWVhiaE90QzIz?=
 =?utf-8?B?VkdXOGhqUDJqZkFYREozbVNpWUJiYzY4RVRNOW9QOUhYZEJuaFlOdk1ScE1S?=
 =?utf-8?B?bWJJamNMZTFoU2t2UHNtNkdWM0MrdlVRejhpMHVER1lpWmNXeW1udXhPeEtX?=
 =?utf-8?B?d1Q4L1dnMHpaUHVXbmJ0c3UxUTcrVkpWd1M1SlFaaitlRTl6bkROT28zRm9D?=
 =?utf-8?B?cXV1cXZIOGZNMVAvdnBycDNRbEtJSTRXaVIzV1JjZXNTSmJDODNUaGRmenI3?=
 =?utf-8?B?L2swa2NGSHBqbnJ5eEdtNC9Ib3ZIUFJTeEU2bG8zQ1RIamt5dGVic2pkcXBH?=
 =?utf-8?B?bGhIaUd0Z1RlZEhTNkhhRkoxSVovWllTY3pReUttK2V4SHBvZmJidVgwUkls?=
 =?utf-8?B?REZPNE9kR0dGck9vdFdEL292VkdEYkhlbzduZnB0Z0dkWHpYYktIREdOalRj?=
 =?utf-8?B?aElrb25qRUFPcm1qWDhTcENUZG1YWkZySm9ScGhqVkthTjlLOFJqZEFELzFi?=
 =?utf-8?B?QklEU0ROWEZPalpWcWhyaFVacDJMOUovRlBlU2toT002U0RHYjlMRWRJaExV?=
 =?utf-8?B?RnVUdVZaUjcrWWtqeHdOWW9xY3hMSW9pVVlwYXhtMERjL0ZuUDhGeW55Nlo4?=
 =?utf-8?B?ekhaNTJXeFEzZ2NmTDJMUUtGSGdDc0dBVGRNWWhCWFNpb0sxNnJqNHdoL1h1?=
 =?utf-8?B?dlczWnlZVlBPbHdLZmU2ZlVnOXZnQWJLV0lGa1BrM0F0dC9PVlFqRVB3ZUNk?=
 =?utf-8?B?T2xFSCtJQlVqTmMzMkUzTVlLNjY3V1FPTTdleU03cjZMOWtSdThQNUwxRm9r?=
 =?utf-8?B?d1Y2eU10T2dCdmtTR0kwdDFNWEx0WEY4OHNkL3RNYWlabWRlOWZINWw3ZnlW?=
 =?utf-8?B?c2hnTVNOb3M5YVFzYlc4L3A5emljdEZJdDdXUTJvVFJ4a3pjNk5KNmJTbmFt?=
 =?utf-8?B?dWlTRkVuU3d2Wkx2YUxuazIwdlNDSlhpWVlBek1FcURyczlqbU5SZ2t1cXJK?=
 =?utf-8?B?RHcwdHBnZG8rem5FZE1yYW9mVm8relRkWEZSSFZLR25QNDJFV2h6eUpqTmZI?=
 =?utf-8?B?cCtDbWpTb2ljS2NtaWpCSlVyekJPc01nMW5ydU9sbFdNUG5ONkNHWDU1SlV6?=
 =?utf-8?B?SUJnUjlyR1R0dWdrMHg5aWV1Z0FvWG9XYy9rb3BSZzVYL1ZrbnhpZjlwVFpy?=
 =?utf-8?B?SmNTSjQ5cEhkb2lFS25mTXFsRityMjhPYnhSM3p3UXZ6WnZ5Zy9HYkpSS3dm?=
 =?utf-8?B?SWgwc1plZ0F5ZkRyeURBdVBIbFcvQi9tdzRWbnNWMWlXdUV4MkJaNVB6MjV1?=
 =?utf-8?B?RWtJU0VDWHhmc1owM1R1b00weVZnZUJBWFJYWkt2Z3NtaDU2K0pUS3BmMGVq?=
 =?utf-8?B?NmtMK0x6N1BuTXJnVW1URDRtRzRtZitlZzdIVXEzWXZ1amlZZTNFdEcxdDBx?=
 =?utf-8?B?WDJkbmNhUWpnT0lsK2VaS0ZsUlZ5Q2tlUjNaLzNEZ09kUmR1YXlRUWRwc1hV?=
 =?utf-8?B?Vk9qK3VQcUNkVTk1UGpncUIwYVQyQlhwYXRGWTVLTDd5SUlGZDZqeDRjdGtS?=
 =?utf-8?B?a0NnVm41eXhuQ3JwTnV5Q085SjZuZ2RDQ2daUDBBTjZJWEU4dXR5TTVNYWhG?=
 =?utf-8?B?bWVTRzBSZ2Y0OU4vUTVnQ0RmN1ZENnBqVEJZNlE5eVF0VG96dmp5aXRCenEr?=
 =?utf-8?B?YWRKMy9rbWpQNUY4TlprK3dqLzRsOWpkeHNhWE90MTRBNko5NDEzTDQydWxP?=
 =?utf-8?Q?0DZBsHs+BqC0/fQ4gFCe5uSit?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda14965-7e91-4d2f-b380-08dd405950cd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 11:37:31.1087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BBYpDirBfNTmh6B2Scq9hQ9mvQJfRtSc6iqhcyLqUwQNUakxhXlm/SF2liTV8dqn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7532

On 29/01/2025 0:13, Jakub Kicinski wrote:
> On Tue, 28 Jan 2025 13:23:42 +0000 Danielle Ratson wrote:
>>> On Sun, 26 Jan 2025 13:56:30 +0200 Danielle Ratson wrote:  
>>>> +		open_json_object("extended_identifier");
>>>> +		print_int(PRINT_JSON, "value", "0x%02x",
>>>> +			  map->page_00h[SFF8636_EXT_ID_OFFSET]);  
>>>
>>> Hm, why hex here?
>>> Priority for JSON output is to make it easy to handle in code, rather than easy
>>> to read. Hex strings need extra manual decoding, no?  
>>
>> I kept the same convention as in the regular output.
>> And as agreed in Daniel's design those hex fields remain hex fields
>> and are followed by a description field.
>>
>> Do you think otherwise?  
> 
> I have a weak preference to never use hex strings.
> I have regretted using hex strings in JSON multiple times but haven't
> regretted using plain integers, yet.
> 

+1, jq won't be able to parse such json.

