Return-Path: <netdev+bounces-155655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0DA0344B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A171633DA
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 01:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D542594B2;
	Tue,  7 Jan 2025 01:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bmnjgl0W"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1E5259499
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 01:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736211810; cv=fail; b=cprghLvVND2GbogjWRcn7DSlrQM5Bs2KMf3KLFBPUny5S4YOPByNE9x8zISQo7FO4Z5dRn5YldSqn+qb10e+A+OkC1CTqUMBR6NmZU2Oa0Pnn7pDuEd5z1uoEStn1C9enp+YWWzZvt6OG0aXJMrPFIw0QRs71HnWKKf3ZLXST2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736211810; c=relaxed/simple;
	bh=9i7XpCiB4+NIUH6jJqvK6Y5bcG77b1miJWagUhT7cIg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h5PtT2zwb7KEtIcKMVtAybKdaFe9HhSVNnERusc4SkLBX6+vIEIv0sAh1WyVjZXoUSkIhQVA723u8l7dPw16VlGZVI3OY0DmhsmHc5+z3Bhpzh8PwZPEFFCJtwHX0YSLYlCjOYiP5Iv5lZ/5OaOfJOqvQ4VLDxpFcJyjYjiPub8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bmnjgl0W; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0/mKS8v31rxxhXNtw0YKMrTsTgNBQZ6TkkZu8NqkjEFwNePAJgIGo2ZJWTdB08CEOtZCi47mWACBDVMoGW+gtXHgGne3FKVzTyxZrulujzJHaG8nfWH4QX6y2bXhrnhIRvDVHW/Uyr059NhNetS2It2M0FqHQtnr2kpP7YZEFFxwpp6BHtnmIWEYAGe4oVL8DQ/H6XLobziac7v+2z2gUSvzOwrgKdEBS4b1XTzxmn+8cuYNIoHtjhBWLv3MHKzWQZ8LveC574UxlGhsGDse9hJGH4TUuQQVs3IR7pjSQIuAN/xLz0VxssCHy1kzTRXjpCzv/bARFKyiYh0PJzduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQYdDPHgajLDWo2UB/FQFtOfSacaaNY5xU5iSuZU5hE=;
 b=U2QusdGrfxVAxLC6iVq99cCRocGEuH2uPg/feL7FlMDUBmvO5y543A5FNUmaTnnIZZz+sxT+NLiwSm2WV0hCG2PnjcOQAsmxCKCDPWG+1YYq4D/SBNu5joALreKte9DqVRbfwohfyLFFgVe2OaCpdKTF16gMoOhjIpNyeCYigmOb90ky59IepUc6wMk8bJwoD3AqjCDuNTinlBT0ALbJi9iXxMFwvSiO7L+DpmMtrr8fb64haeDOC0wSZxLdOJAmE7ylfwJGZhlif4tdSz9vXtZlgNG1iT3Cynp17CW+P3MFFw8nVLLtE4OybqKUiBPXynTAdh5+qVN/MhSsl39b4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQYdDPHgajLDWo2UB/FQFtOfSacaaNY5xU5iSuZU5hE=;
 b=Bmnjgl0Wgi7AdjM+72P+KUGaRdPTdC+5lBSrVP2fLh0q/M9AUCOodkaRlvsxqb2SSHW71vKip+0907LNWmyGZRVDack+bclOcNzoXfydEz+TNPfYhQpaFaBfi+p58MvBq1xaKxVtNXBI9SjVBBJLpxbuSBjj5QZDZ5CINZ15prTz4fwA5H0XlDEARYi8iQDrlRcJMre5BTJI40Q3Hroh1Z0tvobU8xhiUZNcf2cKvTS9SB93M9z7ow5IhteyGXkrBZHpyEIB+kw8eXi7KB1V+GgrsOUYsTs6pbHHg4jZElEfj2BGlz6ruQ91JG2kORRnGf4JqBkF6AvLGc1Vcf+LeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 01:03:21 +0000
Received: from IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43]) by IA0PR12MB7722.namprd12.prod.outlook.com
 ([fe80::48cf:f618:fb6a:6b43%3]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 01:03:21 +0000
Message-ID: <2a8ac0ba-c917-4770-a10f-b44d9e7289a6@nvidia.com>
Date: Tue, 7 Jan 2025 03:03:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/15] net/mlx5: HWS, denote how refcounts are
 protected
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
 <20250102181415.1477316-4-tariqt@nvidia.com>
 <20250106163624.7cebcbeb@kernel.org>
Content-Language: en-US
From: Yevgeny Kliteynik <kliteyn@nvidia.com>
In-Reply-To: <20250106163624.7cebcbeb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0508.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::15) To IA0PR12MB7722.namprd12.prod.outlook.com
 (2603:10b6:208:432::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7722:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac3c60e-3cae-4fc6-0c13-08dd2eb71459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5qYmI4S0trSE9pbXdtNW1waTBiTlI5VzdIUnBndWhTSkp1ek4vU1NITmNP?=
 =?utf-8?B?ckNpRUErTjhtc1ZZbFRjRjNnR0lwWkx1Y0UvMzkrNjVWTWFZRHJiTEU4bUVD?=
 =?utf-8?B?REZtdmpZamtXdFVjeE84TWZ0MHRzbDBrYkNEU3FGVVdJYzh6U3RIUEh1K1Qw?=
 =?utf-8?B?dTNpai9kaG0vOFlhY2xLZWtoYU1vQ3QwWjQ0eTFLT2FoRmxsWUZmanZieVpi?=
 =?utf-8?B?cXR0WVV4M2NkcGE3aEc0SXFJZ2Jvb0FuamtoNE1PSE9ZNmwzRDVpYk43d2x4?=
 =?utf-8?B?bFE0OXJscEJCU0JQMGx4YlptOGU2TDJuSU9yVFJjTUZwVHppMjBkMXJ4Rnl6?=
 =?utf-8?B?TkZNQTAxSWZYRVpkM1d1b2RIb0h5Z0ZJTUJub1NSYnVobHlxOERhT0ozSWhL?=
 =?utf-8?B?b0ZMek9YU1pJNzlsQ2lkV2NSaDYyaElWaEovNnZzZk9IV242Qk9FOU5MaUNE?=
 =?utf-8?B?YjRac2ZxUjBkMGFORlI2eDFoUUh4ZHlwbFJzRjY5U0tZeGhuM3ZjaVNPZGN3?=
 =?utf-8?B?dFZ2UXBTNk1QeXF3SlNwYWYva2RnVDVpTm5GcTV6dVNVZUVCeGRzU3dldmdm?=
 =?utf-8?B?cTQ2a1drUlJpcTR3NHNOK2FLNE5jYnJxZEJ4OW1PZTQ4SUVIUG50MFJ4b2NP?=
 =?utf-8?B?cTFJeHppazgySUgvODZqOWFIRFVBTGJzZVB4OHVHZkNoWHJNalpzdko4WTN2?=
 =?utf-8?B?NjYrYnZmSG9OaWlvVTN1YkUvZytYR2JzTTlLMVd3SXdxMXpwa0NkVUp1NFpx?=
 =?utf-8?B?VWpEMnFGL29CUGVITS9PZ2Y1S2cySlZ3bkoxVnZQRWxtUnNPcTZ2MVZKY0Jp?=
 =?utf-8?B?T3hIUDFPd1MzYVE4cURaeEphbUZ0VlhqZ1JBQzE1M2MwRzZ0ekFGSUpQMFhs?=
 =?utf-8?B?SVN3am4yVmVrejBwN2hlSFJWWTAxcERnVHVXOW5heXJXckFoWGU5N2JxY3VD?=
 =?utf-8?B?cVFZcUdhK0dzZVVweUtQYnlpRWc5Unp4cnJTRUdhd3BFZEhOMFFXUENjQXE0?=
 =?utf-8?B?a1laeW5BWU5xa01FdERlVFMvaEdseXB1emNhNzhpeksrZzlBZzh6NTFIYnFT?=
 =?utf-8?B?cUh0aSttUHZ5YnhWcVJ0dlVrRXc4K2R5Wkg2azJYaXA5S1RMQUhtS0FKRk85?=
 =?utf-8?B?bXZHbklKMlp5YVh5M0ZNSkR4Qzc5NDhGMXdIT3RBaHZUbHZqZkNub2tPK2k5?=
 =?utf-8?B?T212ZVdaNC8wQjNUWVRSSGZENkdvcHlzYURUN0NuamRWZWxlQzUrZVl0ZlN5?=
 =?utf-8?B?UGM4azMzRnNkUlpXb3hTaXZBTVRIczRvcXhydWxQdWM3dnJxM01YYzRmTGhQ?=
 =?utf-8?B?RkxoSzJSU0VKNm9uSVExbkZnMG9BWS9FMVI5azJidnFXeDdmT0xTdFA4RmlW?=
 =?utf-8?B?QmszMUQvbEhhbFhjN1hreFZ1WEpmUW1ZVk56RmN1WGZ3QUl1eFVaaGV0YWFH?=
 =?utf-8?B?U0M5YzBvTkVSaXJyM0xuN1NSK1BrUG5hWHZybEczR1p3TWhNNVVQZEFaNThW?=
 =?utf-8?B?SjM0T3lSeE9DWm04ek12aU5QZWl5ZUtOQngybGIyS3ZjQjMyL0czQ1dCVW1W?=
 =?utf-8?B?Smw4ZlJkcVcwNjNyalNONWZxYmsybjlMVFFnajNpZlJTRzVNaWp0ZHNrdG5B?=
 =?utf-8?B?U2pseDRnblEzQ0hRN2dJMXh5KzJKdXNkbGl2bVhXZjl0eHdESjBQQy9xcDB1?=
 =?utf-8?B?NXltTjVKdkwyTFhZUXNuZm4vK1p1SzhLS01TZkhpY0NkSWl0OTdlSFUyV3lI?=
 =?utf-8?B?WTlJT242SHVuSGFaWEczcHhWMUIva0NXWDQzbjVsKzdNdUdxMURQZjNCTjYw?=
 =?utf-8?B?U2cxcWtCRzRtUWdhaVo3L0x4MU1iaWtuMzZjS3ZQWXRhTWplaHl6UjhWWlFX?=
 =?utf-8?Q?hM39rtpvlgieX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7722.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1jRzJqZW8yNGlhamE0dG4rcDJFVUQ4NDVFZ3RMbkpaZHNHWStSSFB3QUZ5?=
 =?utf-8?B?bHFFTThtOU50NFdzR05IbG1pQytKeTVIdmsxNHRTRFpJQ3N6SDRHZVN1QjQz?=
 =?utf-8?B?ajU4MmlRNXhmUWZpYy9xdHVEcDZBb0tPL3ZiYnZQcGRSVjdjMThGN00rcTl5?=
 =?utf-8?B?N1Y1bVQ0T2pPdzdOVnNlc0xibFVpTjQxSm5WSFdQZG80bmNQNjJIVW9wb3k1?=
 =?utf-8?B?dzkwa21FTVg3a1ZXb3NtSnNOT1JRaDkxbVpwQmpOdVA0Wm9OcEdRY1oreUNn?=
 =?utf-8?B?R05mdVQ2UXRWUndoNHp2UmlDT3JsNDVPWld3SzJMTXd4Szk5SENuYytDdkdr?=
 =?utf-8?B?NDhQYUM2Ty9qK3lTcUF4eDVtanp3bWFjOUtMVldkamhUdHNnWmlFbEswTUht?=
 =?utf-8?B?MXQvWlZ1am40Rk42U0xZbEQ5VFFSNzlrSVIyR0VHZ1Z6SHozQzRtbVQwb3lF?=
 =?utf-8?B?dlpnRlJNZTZYenZia0tHTFJNVExHZEhBdWVUOWVONE93QW95K1M1eVVOOUxy?=
 =?utf-8?B?S1JBMDIvNlIzOGxYaGZVS0F1Mi9hejMrS3NGcTd3UEViMU1Cc1pSWXI5RVdy?=
 =?utf-8?B?OU5OeFBoY0xvOUJzMXNjWHVRenJHUm1iaW42SHg4My9CdVN1NW9STTFpSitF?=
 =?utf-8?B?TkVUK0lMblMyYkxXbE1obmZCejY5YmJBR2h6RDFhdHV6NkdEeXlYdWUwMys0?=
 =?utf-8?B?L2pBODVCNGFic3Z0M0JVY0NGRUFjbU1EcVFJLzQrTDV6eFl2RE0wRkZGakxr?=
 =?utf-8?B?NUFNSkE3S2pPdGd4UWZlaFNaZ2h1d0dCV3lyRzgzN2R4SGhYQ0FRZDltS3JI?=
 =?utf-8?B?UUhlbVZ6NmpjR1RTRkEzU2t6bjZON0RYRnc2SEZmbnltZFlSSkNYMGhYTjgr?=
 =?utf-8?B?YmF5TGp1clN0OFJ5NXJwWDBHdkxYbkhDRFN1MmpCQ2JReERaaCsxZTRMclFK?=
 =?utf-8?B?dGE5cTA5eDNVa0p2YThVYzdyNitFSlR4dkdnQkh3K0h4eDdFTEc4cWdSYm03?=
 =?utf-8?B?RlRFNzJZRnN2Q0NteDcralplOENvOU5VNDhwemlUVVo2SldtSnJPbzE4NGY5?=
 =?utf-8?B?a29ORVVBcVpRcGg4L1QydmMwa1czdWIyN0NWZldjai9BZ0t4RWtGMk92UW03?=
 =?utf-8?B?dWFWS2tkSlgxUkhDaXdqcEIrTlFjNWlIQzN6bERxMTRtdHY2WVRwd3VLMlJN?=
 =?utf-8?B?THNpWEdnVDZScllaL3p1Q282cTlyZ0NYVUpYWTEvS2NLd3JCM0hqK255cVBa?=
 =?utf-8?B?RU96amhmQTNnUmdaZXVjNCt4WDFpWHVXdTQzQ0Qvc1dRMGNrdElRbE82TThl?=
 =?utf-8?B?OFl2S0pWSW1VbW0waFNuMHJDS0RqbU1qV1FLLzdkSjRZdXR3R1FyVlhtdXht?=
 =?utf-8?B?cFpWWUJoQTdrejJWUmtpcjBtNTdOcG15dHBqenJUUjZBMXB0M1lPQ05PYnRq?=
 =?utf-8?B?OGZBOTNVTHpob2haMzVKODl2Sk9ySGo5UXUyZ1ExeVRYaTRJV3Y5TjNka2Z3?=
 =?utf-8?B?SldGRHUwOGd3dk0xSXpHMHlhYnZpdFEzTHV3RXg4YkdsK2FwSUxha2Z4UnNE?=
 =?utf-8?B?ZmlFMCtrNnRxVFA1blpIK1pLYTN5WUt1SDZvODM3SnZIbDBSWjdKUzhGMVAy?=
 =?utf-8?B?dXVEb202L1ZZWW9SWUttWEE2QnQzbjI2Y2hReEM2dGpqVVpUL0ROdVBSUlZa?=
 =?utf-8?B?KzBOUEVtbzE4UjBxUVJ2dUhWaXVVK3BlTTl5ZTQwN01rZmNLbXlDSkNHcm0w?=
 =?utf-8?B?d0l0ZkxIaWY5S1JXOUw5bHBra0hnazFraUt5UU9RY1lLRWFRQjdDVFppZ0ZV?=
 =?utf-8?B?dGsrQVZlM3Fqa1ZOK29zNWNnWWM5dWlQcTdzTzhJcWlNUHBsWjlVUXZETGlR?=
 =?utf-8?B?UFc0Z2NqU0RmUXhsTjVCMDRLZDF4RGlRdTRQZjB0S3B4MXFZS3dEdmVmL20w?=
 =?utf-8?B?SEM4QlBTdWRHdHp3ZFdSNmxkMGNOR3U0UUJKNXZxRjB6NlVUMkpHVFZiYWxW?=
 =?utf-8?B?UUx2L0RvRk5QN2lYS0FxM1ppK2VGMUxPQkdmRFpaNXFKOE8rUURRRWJ5WDB6?=
 =?utf-8?B?ZityWFdrU1BOVUVHZ2lFaks2R1ViVjVZait6Y2tkdFNsbHA3WEk0Y2FZQXZm?=
 =?utf-8?Q?tVP22VlnLgrIc0GLY/ZME7yF0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac3c60e-3cae-4fc6-0c13-08dd2eb71459
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7722.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 01:03:21.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K09/PHEJVXsBkgPoLGfHdJamj2tnCI5ggfgkOAUm/1uBpFebN3vjwA2dqKm0y6bJ9nDjKimDTlAMYf7Pr6FcKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639

On 07-Jan-25 02:36, Jakub Kicinski wrote:
> On Thu, 2 Jan 2025 20:14:02 +0200 Tariq Toukan wrote:
>> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
>>
>> Some HWS structs have refcounts that are just u32.
>> Comment how they are protected and add '__must_hold()'
>> annotation where applicable.
> 
> Out of curiosity -- do you have tooling which uses those annotations?
> Can smatch use it? IIUC the sparse matching on the lock state is pretty
> much disabled these days.

Unfortunately, no additional tooling for this.
I wasn't aware that the sparse lock state check isn't enabled...

-- YK

