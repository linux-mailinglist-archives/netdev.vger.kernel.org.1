Return-Path: <netdev+bounces-128537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D227397A273
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DA91C25248
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887581547EF;
	Mon, 16 Sep 2024 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KCFqfmfH"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C411514FB;
	Mon, 16 Sep 2024 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490384; cv=fail; b=Nf8aTdG4LyPpJbyWPgqRdHbXetO8E8Bucu7L/3+sFR1QI2b0YYQ6Q87SzrIgbRbo4ojodD7ncQAWswaIeMvCKAhl8esg9taUS5PiAjqg+kJHX5B0NJEtdTHPvR2CQvewqLVDoqMJqVX80xFf5f0EBci+LXSFOq3iJjOfkPbP6O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490384; c=relaxed/simple;
	bh=rhuvX03Xyl18cxs7IfaaP6oBBDYm5PjXgGS9rI5ty4I=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QzhFtwowCQQ4Gs6PbsfCpQ92xMCER+EGcEt2AQZ5t6J0Z98ATEAjEAAmP9gYeWxqnUnEMmwxfLTlY7BbDpPq3jkfI++tesdHt/AOkPOUQXKzF7+uBpgPAISklK1OxRuGr3PW780Ko+kceff+wnpTfK7YcpXd6c3LsfL+psLtlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KCFqfmfH; arc=fail smtp.client-ip=40.107.101.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwk7l1lbVAedQdF7I8dFm8Kfmw92ECgR5ZjONjmBxL5A0qodWPkX4dKh2RwV9tdiNcvVTfidUuNITiaeltpQt/BNh20hrYw5/1srRyJLwyDHr6TVJl2926jOz7OWV4WEyUYdyN6QyY/CVv8jLUwWygP2xT+YRsecwd7qobSNRHXylPvkY8/xKQRynFSUMIRJZuV3NnysTGu7fbUZhEa4ITrKZr5bsoyleOBf1pezlVZxduJr51XunCbzMD2/kPSAHGxbmXCFqsfU/siVvKlDcaSrDj5Jm5KUAGbORIL4n+cBRHGUhBpH7OgYQBTflevClGrC6/8cGVKaTOICZzE/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxTgrCZ+8zNKCO4E1Rld8sm2kkagjGTagoGgZf/bKtY=;
 b=Xh6aD0Spz2hLb19g5MTLtflST9H67V3gY8bH8WcZOG1xqwX2FH6K8W9Kql7+251hoOBrbHpNFlaIW15YNcHy8IhSnYXi813EhsB1S6DY4jdHbcUETq+wDb8f1jTNs3CJ/JIQxU6WSHILc1Ldm3QdtE23esxVv3x3+beanP7Kh92i9GEgVhyX0qsamW2V4xuap/1eK5Yq/BvYGnx9vsTMSllmWWNB7RtSY6G4yUnX8O8f+fJcYOOXKlMKu/Ow3BTAvX7mXOZnyuKQJP1WKIsC/PREwa9c4YKRsJzpw+2z4jnJdEsC5Qwfjpwkio3rcNEbiw2Kc3dgndqpMmXAdHwwtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxTgrCZ+8zNKCO4E1Rld8sm2kkagjGTagoGgZf/bKtY=;
 b=KCFqfmfH8nuFDLiYyRwV14Sd+qdMCpSs5m9aHt2xIsrD1DtTVYtVjW2+2BaLw6hZm6jJueKimAaNVUhQHckS/C1B2L8zXxvFDRo6NVxItd1oPQWcwPIVixJS250nkUzXRs4CG4gmbdvqLrcI+eIzX8v25H64vC7gd4cdraGBpIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 12:39:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 12:39:37 +0000
Message-ID: <c874a279-c673-e789-bbf2-6fa68deb9537@amd.com>
Date: Mon, 16 Sep 2024 13:38:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 09/20] cxl: support type2 memdev creation
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-10-alejandro.lucero-palau@amd.com>
 <740c2831-4131-4471-b0ae-23eb816e0600@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <740c2831-4131-4471-b0ae-23eb816e0600@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0241.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: f78df759-751c-4266-ead6-08dcd64ca009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dmpHRFE1YUxXRThRYmE3MjBZT2RMR0tIRTFoclVpb0RlSWFVOUpKdE5malNv?=
 =?utf-8?B?MDdRanJuZlhjZ0JkRVA5NlhxbXlqYWxncHUwdWhGeFpRek9rbCtpUEo4d216?=
 =?utf-8?B?ZjZjMnROcWlDMC9pVU5sdFdlQkNYQ1o2T2FtNW5wcmZkOFBCWDltVXVWdDFR?=
 =?utf-8?B?cHBXRkJ2UUxYUUh2WjNZUGpyWFpSRVkxMVFwMlkrZlRoOVlLdW5JLzhCV1JG?=
 =?utf-8?B?dkc5UWxjL1djU1FsQWhiLzNja3VjKytsdEZTOFRSRlVKZjNadVFlUm8ycGVH?=
 =?utf-8?B?R1RzN1FsU2NGMUhqRmFraTBGcWZTczRqUmpNS0FyYU9LK09iMVEyR211QlJ6?=
 =?utf-8?B?VWxNanltc05yLzhaeGlKbEVDSVIyZjBwTDVhRUxORTJPWE1ORzF1ZHRIOHFy?=
 =?utf-8?B?S3hrMHhDalMzV2wzUHdmY3g4U0pCOXlGOE1zN3R0R1ZYTHVqTkhWQWgwRjVy?=
 =?utf-8?B?U25NUjdtU2tKWG8veTJtWWJJTHVMR01EZGg5Y1RlRU1oVmZHUjdkT0crWHRj?=
 =?utf-8?B?M2tDN2lNUDRkZnJuamlSak1zS21VRURxVGt4aWtLTy9veFdiaUpTZ0JjdTEy?=
 =?utf-8?B?NWdTSVZWTjV6cE8zYXVBTmt2eWhlRm5yYWxNSGU4RGFOVi9pSVBhRnUvOTVi?=
 =?utf-8?B?RGVmaVRadzhTYWdRdXMyYS9BZGNjTER4VExjY3ZLVXFldzVnalBCMVZTTFZm?=
 =?utf-8?B?S29ibGNpSXlyUWhxRVpEQStwVWdWenlBVnIySHBJT01MM0VhWUh4WTFMWVBD?=
 =?utf-8?B?MkhUTXhMTXZuR3hRMTdQMmM5R2gvVjhVOTJpaThkTW9tTkpDYVFQQWpUZFF3?=
 =?utf-8?B?Q3R0VEVXazRXU0RXTXNDcUFqd0I5UzMvMi9KdTZnVVpoMlphOGc0ckhCYmhM?=
 =?utf-8?B?NUZMS1lxZjFwSlJ2cHMrS2lyNU9IOHZqUngyZnEyRWdNUHFoTHU4cTR0OEts?=
 =?utf-8?B?Mm1HY002elROWFR4ZXNhYWhBM2RWR05Vakc2Uy9xUkY4UUJwSzZ3VVFnS3ly?=
 =?utf-8?B?Z0dUNVJ2a2ZTejBZS1hITnNKTmJlQkNRZVNlSDNNZGNBOGZmWVBNSStqRmlk?=
 =?utf-8?B?cmd6bVdUK2RobGp3aUlpeG9iNGpJNGlkcHR0Wmt4MCtLeHlHR1lKVU40N1hY?=
 =?utf-8?B?Y09OajBNTEJTeXpsOFBpamtJNDlrdEpFdlZRK1lOeDhtdGdudnJiVTF6NzNt?=
 =?utf-8?B?aXkwNGwwU0xvVUVPR1ppaE0wVjd2VEpDUG1hZGVaSzVER0k5RlhsbnRBNG9U?=
 =?utf-8?B?QzNlKzBFRlRqK0hYdmJXV3FHR3N6RnZTRmh2NXFsK0YwNkpxVnNibnlUeGcy?=
 =?utf-8?B?cVJIbURoclBmTUZwK1RWZzBTKzI5OEhVcldXeC9yRExMTUJybjNXTHpwMlFO?=
 =?utf-8?B?dVhDaXZnQlpVK0xUZlRDREJmOGFFUWd2Z0lVeFNyVlMrYVdBendmVkZhQ1du?=
 =?utf-8?B?RlIyYVhtUzE0b25VeURrQkE1Z0xjc3VaYW9qQjFiQ1VNWEJIYndvL2Q2OGFP?=
 =?utf-8?B?SFlIWjZEOG1lbkhORlVyR0U3ZHR6QmU2VmRiYytoV0VQWnBWd0FWRERSU0hX?=
 =?utf-8?B?V2xzL0RsVyt2eWtqaEc0cTdCTXFXOTZtNkJPZDN6d0NuWjdoTWRGbVVPODBs?=
 =?utf-8?B?QXFJRUZLZjNZOFJqdG1KQllVSmtLZDMvU3pXbDIyQUE4TVJYNFdIRXp2azg1?=
 =?utf-8?B?SFBHN0lsYUlGUkpGWGlBSGxBRVVEYXo0Qkg4Y1BpTHdHRjllWlV1NGpKdjlz?=
 =?utf-8?B?ZXNxSHd2MjFYRk9SazdHSnpVQ0ljZVgxTW9xa3pXZDRLWDk4RkJ5S09ZSTl1?=
 =?utf-8?B?RmtmZFptc1hUSzRCYmxJNW9rREgrakhENnRybnNCOHhqa3RCalR0N3MwS2xk?=
 =?utf-8?Q?qlgIWFK4ZWx2M?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWFqRVF5Skl0M0lZMTZMbmhSL1UycnVOYUNVVHhFcEFRSmY3ZTZmTjFMZjg4?=
 =?utf-8?B?R1Uxb0cyRHlmL3F3N1ZRT2xPdzNlcUFBWk1TTUJhRTBiNGdIOEwwQ2NMb2FD?=
 =?utf-8?B?WHJRdlVQa2V5UmxmS2diV1VvRFpJaGI5OVRKbDB0V1lSWEhCRDlIR0xqR2pN?=
 =?utf-8?B?clErUi9VQzVLS2pRZ3l1OG8vU1ZHRHM1Z0FBTmNVODl1SDRCejN6NFAwd1Q5?=
 =?utf-8?B?OGMvSU1YK21pM2o2SmZ6a3pCS2FCb25DTmNMajdpU2QzQnhIT2hXbzQvNDZl?=
 =?utf-8?B?SSt2ZmNqNStHTkdGZjh0TDlQZURxTDBVdTZUM09YTDVIaEY2UnBCbUF2NTVR?=
 =?utf-8?B?K0UxMTVoRWlXT1UzUDhuMFdBTnEwVXE3R2NuSjcrUWZSdGtkZlprSUQ3YmRN?=
 =?utf-8?B?ckM3ekNYMTBsdGNaZjBKZUg2bkRDV1J5bGp2SDFWaitlajlSUVlmcERycVY0?=
 =?utf-8?B?ZktxdWJhOE1ObkJKVG5MMGlLMWltdks1aUlIQjJBY1NTZmxod0RuSlpIWDRW?=
 =?utf-8?B?VmJ0VnFDYkZqbjR2TUljZ3l3aU1rTHhreXVVU2hxRjBwTnhVSG5BOEFKTXFS?=
 =?utf-8?B?MjhTSW1zVzVEc0pjYWovaDFiMEx6NTU1OFp4WWZPR1l6WFZpbkRxaktXeVIr?=
 =?utf-8?B?N1BsZmJ6bnZiZlJERXVUZTgwektxb2ZqTmRkc2QyTEU3WHFrUUtRM0p4VHZw?=
 =?utf-8?B?NkZTbCt5OG40MzRRVE1UaUNRZEs0UTNKc2tyVHRRaGVWRjVwcjc2b0p0WEhz?=
 =?utf-8?B?QWVwQWZRRWxnKzd5K1BlaUowRGhEdTkxVm44MU9VVHBnM3ppRnh4VE54MTdW?=
 =?utf-8?B?cjFDNjBvcTFHbk5jRHM5NmNHRkozQklab2VQZXo1REdkZmVKTldWajRNNU9Z?=
 =?utf-8?B?b1A5eXhLbEFSNzdEd0ZmaDFzSkVqTVNha0JnbUFDK0E3Q0h3RkdFUEFVOVVh?=
 =?utf-8?B?MTlYTGNuNGYvckFnRCtyWHhEcGcwbVBNOUtrd1BEbDlnSHJ3S3pVaE9BSFJH?=
 =?utf-8?B?eGlYV1UxMkwrWWJ5aGxnUUNoM0hSZFVUeWJ2QlppRlpkbTJrU2VxTTAzd3dK?=
 =?utf-8?B?eHMyM2FFV3dRQlYydTgwcEYwOGVmMzBwNSswc3VhbXhTSHlpa25HY01UVzE4?=
 =?utf-8?B?MU5vVEYzZzNYSzFGRmtQSm5uTExOQ01JUEtiNktjZ1dxVWEwaFczaElTS1Bh?=
 =?utf-8?B?U0RjU0NKUW9YdG1BcDRUTjlxc1psb1A0NXN1ZXQydFRrYXZTYlErZFVHdUVm?=
 =?utf-8?B?TUt5c09uMk9INUpPM1QwcStDQittWTFIRFhwdVRJNlpMWjZLanlpSzl1ZVBM?=
 =?utf-8?B?bUZoWnhOOVl0NVJYRERrSlJJV1VjSGxhRk4zTXFocExpK2lsbjJPckNXUkdm?=
 =?utf-8?B?akJPVUJEeXl4S2xlTEVMOGpZU0NYd3VnVWlDYkE5WEpNQzNwdmNkbUNhVGlX?=
 =?utf-8?B?Q05VS2t3WUl5Y01uajJNaUFvRkpCQ0ZqTGxNYk5iM2JBdUE1Qk9lbXhMNGVS?=
 =?utf-8?B?Y3pyRkt6RmRGd0xRcjRqekdvM1ljRk1tem44NUwrRDdUVzladmF0SWFwMVF4?=
 =?utf-8?B?RFQzMGtXb3dzSk8wZ0Y5cCs1d1NXcFc1VUxodHBtZHE2NS9yMzRtR09OMk1u?=
 =?utf-8?B?RkFubkQremVrWFNwVFAyL2V4ZDFrcGlERlNkejJoR2FGZDFnMDExcVFNeEFI?=
 =?utf-8?B?a2hkWGFKdnhDUmR2OU1ZZ290OUtQMzFwVzBnYVJ4d2dRb3pCamh0aUpuOXpy?=
 =?utf-8?B?K3JpNmJla0NscGRoZG01cTlsdXhyNEEvT25KZ0MvbTBneGpZSkRBUEJmNGJi?=
 =?utf-8?B?TSt5LzFYV25NT09aaWk0NUwxMU1CdHI2SnM3YStSS2lLYnZ0Zll0Rm55c0pN?=
 =?utf-8?B?KzE2aGFJcDRTZjdtSWg1b244UmJjck82QWh0dzZ2aWpzMjV1RmZGcjl3REdr?=
 =?utf-8?B?bXkvbTU0WTdLNmpFdzJxQW16R0ZHb2JhQk01bTdwRVdQMVlnd0s4eVdoNkRt?=
 =?utf-8?B?YmNES2xpcEhhdDVOQ3lyVHF6R1lxK0NieGI0eVJHaGV0dm5oMHo0aUcvaWNI?=
 =?utf-8?B?VXdaRDZkOWxDOHhVYzV3SmVDZVBmalBWNUpXajNuTStFN2p0UEdSY0ZzMDNj?=
 =?utf-8?Q?4KywKg/YReWfbdiPtKTrjVgvb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78df759-751c-4266-ead6-08dcd64ca009
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 12:39:37.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqL/GN7RQnpAVBp48NNC6/rGWrEPlPRtoCNxqjPyDTR/qi6Yr5pnlc36i0FZblhk+MkgmwhOLQdSpvkjYmXhdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714


On 9/12/24 19:19, Dave Jiang wrote:
>
> On 9/7/24 1:18 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add memdev creation from sfc driver.
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected. This patch checks for the
>> right device type in those functions using cxl_memdev_state.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c            |  3 +++
>>   drivers/cxl/core/memdev.c          |  9 +++++++++
>>   drivers/cxl/mem.c                  | 17 +++++++++++------
>>   drivers/net/ethernet/sfc/efx_cxl.c |  7 +++++++
>>   include/linux/cxl/cxl.h            |  2 ++
>>   5 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index bb83867d9fec..0d4679c137d4 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -558,6 +558,9 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
>>   	};
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return;
>> +
>>   	switch (cxlr->mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 836faf09b328..5f8418620b70 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -468,6 +468,9 @@ static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
> I think instead of altering the sysfs visible attributes, what you really want is to not register the unwanted group attributes. Or basically only register the cxl_memdev_attribute_group and not the other ones. Otherwise it gets really messy. And whomever adds future attributes need to also remember the special case. I think you can refer to core/port.c and look at the different decoder types as inspiration for creating different memdev types where it has cxl_decoder_base_attribute_group and then tack on specific attribute groups.
>
> DJ


I think you are right. It was a quick fix for having things working and 
not thought about it in detail.

I'll do and fix it for v4.

Thanks!


>> +
>>   	if (a == &dev_attr_ram_qos_class.attr)
>>   		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
>>   			return 0;
>> @@ -487,6 +490,9 @@ static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_pmem_qos_class.attr)
>>   		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
>>   			return 0;
>> @@ -507,6 +513,9 @@ static umode_t cxl_memdev_security_visible(struct kobject *kobj,
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_security_sanitize.attr &&
>>   	    !test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
>>   		return 0;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 7de232eaeb17..5c7ad230bccb 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -131,12 +131,14 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -222,6 +224,9 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	if (!mds)
>> +		return 0;
>> +
>>   	if (a == &dev_attr_trigger_poison_list.attr)
>>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
>>   			      mds->poison.enabled_cmds))
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 14fab41fe10a..899bc823a212 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -83,6 +83,13 @@ int efx_cxl_init(struct efx_nic *efx)
>>   	 */
>>   	cxl_set_media_ready(cxl->cxlds);
>>   
>> +	cxl->cxlmd = devm_cxl_add_memdev(&pci_dev->dev, cxl->cxlds);
>> +	if (IS_ERR(cxl->cxlmd)) {
>> +		pci_err(pci_dev, "CXL accel memdev creation failed");
>> +		rc = PTR_ERR(cxl->cxlmd);
>> +		goto err;
>> +	}
>> +
>>   	return 0;
>>   err:
>>   	kfree(cxl->cxlds);
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index 08723b2d75bc..fc0859f841dc 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -55,4 +55,6 @@ int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
>>   int cxl_request_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>>   void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> +				       struct cxl_dev_state *cxlds);
>>   #endif

