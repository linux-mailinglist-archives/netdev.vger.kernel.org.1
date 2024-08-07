Return-Path: <netdev+bounces-116521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EC94AA84
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 16:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9713CB2C729
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 14:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2028287E;
	Wed,  7 Aug 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9QITlrh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C8F7E0E9
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723041500; cv=fail; b=sBeU8qeRV4vk4ugAYGSSfXlXzlCw2G3id/vU1bXwhfcDY8M6tVZpIKKOxN27PcIS8QwRCCQGjx1e4GddU0aMhNgqgJubsp6TyiR+SBbJt8iM58l45pSkuWgXXOHCBlastvmsQE3qQ1Lm0Gm1/txrinWnw2RmcJm6Ba9MlMgN4bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723041500; c=relaxed/simple;
	bh=u/2ayBpaHhE6an5hqU/+cFsXEJvgKVef8dc1kaLC6Jg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tfmMkZubi7/euUtD9F4KSfi7Koj9UCzANwHFDS/dsbIbw6DPzry2kxO5BH86F/Bq3MlNakRpaKTOljB6AzPTTD/zaaS2HpI+E6J4Aw4q1IIJTvAyQJPysdgQwFZbwjH3XUDorX0tXr8UHO+puiXHwfB2V02O6eqHIiR7AotGU0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9QITlrh; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DHuTnjXoGvOI3XNmbAfX0NMX05wGCYbcRNKF+O63ZkUyAFTjaTGdVCP+DG8K//OK7xL/TAuvep1ZfMlAaIcIG8hKeuWyEhQTYdnNVcpGL/S4Cw29dnvA3bJ29ulydG29QukIfu1N5nScrqo1fn9hOzFEYvgIy1jctxGyRF1k3/4obgjiep1GBz/fp9MfuIOC19ZwhudokMvecMCCouE3bTUfIHCGp4UnU1YYGXuMEffvLn1ZRnzCCrME9+wUa/HsLcCy/TJm/fkOUm6VQqqu3Es4HaSIL3THHmfNZ1qkBEa0pHhh01VhwfnNclidEsgenwMd8+IJ3UwN/iWfcBWD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SG38JoFWDQcqKZFg4YkPDNFXt+H8+u5Dektyw+SeY4=;
 b=UcnoBeO9YnPR6KF+X1FtzFmfWSaycAe241BGGRVPJ+Ye5BZ8BBnIJvdLAMVGEIAckdve63mVok0fOi/o/efrIB47x8KuqO9kn4rd8D4HwRfAfWrhU0ExcdfvQJ52GF0aBkA+1NxNnZHvSzqXBOnRHUxd452WpEyCLL75NmHTewP3aDwmCcwdjk6dCjDtSML7Tywmr1wALEF9Ef9mlJjZ89gMGJkKdIG/RGOHLu05ZziHCMWpltQ7jmj2em6ywv360dcb7zzQXgf8hY7rRpiSrQqNuhum70qZ9yAE/t6J3hRQu4VO8jIX5Acm9NqjcVAIsyGthJIzD/gjaqBGVHajoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SG38JoFWDQcqKZFg4YkPDNFXt+H8+u5Dektyw+SeY4=;
 b=p9QITlrhaiorkCwmCmrww2+djR3Pscfl1rPUyQyjsbe8hOCmR6wNgqLUPlDTWK8BlRyp9urL6TPgPExQyu1+P+TlFYf1puz2kcP/ly0J22tekqsCe9e/jZPxw7R/Mkw4+oiWId105nZjno4DqrTAR0+BTaHoDpGVrhNyuu4ZjRgaeWk73pDZGh65jR6yoC+TUMjaPdaj2o6aB+7sa6QMLBWqTSwuJb9Fq4DdEtjhyqY2rgg7vPnvHZvRE4HjlqaXRemyR3wp1jDRvb5CwrdLpncVYni6Qjji8MNlRR4MnCwD8dT3ajwaAJI2acUh4P7GHefqeyB6VbHoB4xq5km7WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 14:38:13 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:38:13 +0000
Message-ID: <3ce6dc2e-b474-49a9-992a-55a6c33a480b@nvidia.com>
Date: Wed, 7 Aug 2024 17:38:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ethtool: Fix context creation with no parameters
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
References: <20240807132541.3460386-1-gal@nvidia.com>
 <20240807072137.34d300a8@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240807072137.34d300a8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0175.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::12) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 43fa2b4e-aeb1-4da8-886b-08dcb6ee910c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGZFYzROWU0vNFF2MVFqRFQzVnp3ZCtCVnVmdURITGIrYWtDTE03TG9kb2s3?=
 =?utf-8?B?dkdQUmJBY0pkNWg1NjlBbkw1L2R3TTluTGJyazRLUThmalFia0hOM2JGSGs1?=
 =?utf-8?B?YUEyVHdEQ2xTZktVa1dka25DeWg3LzFwNjJ2NkZLNzVyUWhUK3BoN29jelhm?=
 =?utf-8?B?dzRqc1hBUDRzRE1iaTgwUW9SNjNFV1ViaWJ5YitnejZONkNjb0MxQ3BUYlN3?=
 =?utf-8?B?Yk8zYW42b0tMdkI0RDBUL3pzc0Y3OGJuQVpDSzNKRU93cGZmbDhXbkhjeWVk?=
 =?utf-8?B?MFhRQkdQYXZVTER4ME9FNDA5K2hwZVhkZFR6eUhMNmluZzhJZGk5dVFuWWM1?=
 =?utf-8?B?dFVxTTZnVFFFd2tQRElvVXlaV0ExS1RlRjVSU0JoK1Z5YjRBcWZocUY3NmtE?=
 =?utf-8?B?LzZqT3A5SzUxb2lUTCtZS2ZISHlwNlI1VldUbEhadFlRdWUyRlJnWmRHc3pY?=
 =?utf-8?B?ZGM1cFhlM0xOSkxLZEpRbEtEM0pHcXRIYmp3ajFmTlFPdG5jR2pYUTk1ZkRx?=
 =?utf-8?B?NFlaMElVQlBEblhIbXlnZW93dFFKaExiQ1lpVjFhalN3SzQzZGNOV21qZjRP?=
 =?utf-8?B?SkJERmhRREZyS3pwSFpqanZpZ09NUThBdExkMG5NOS9FdzNMTFd2TitIZTdi?=
 =?utf-8?B?aEpJWERndkhxSVdCaVZickxDdHQ2SFJrYjhURG5vanE0VzV6WHpMSDlXVERj?=
 =?utf-8?B?NmJMVmxkbERwTS9zZ3RFdm1aNUdIOTY1THRvZ2pMT0dTekhoeGY1R2VYVW5Z?=
 =?utf-8?B?WVFrRXdjVW91TVVaMjl4bU9BbjM0cUtNSHJMU2k4L1lScVZXS1MxQUtCbUNt?=
 =?utf-8?B?a0lMUTVyWlcvUDlkUEhFdHIrOERpMUl3THV2VXNwL0xpenU4ekx0OXZoNGNF?=
 =?utf-8?B?MmxQZmFXaTJUYlJETFpDdkloVUFRUWlFMFhWYWVqa0M4emF6Z0xVOTFnb1B1?=
 =?utf-8?B?U0VMNlI0NFc5S3lnZVNJU3VmVXJmczd5aUs3VFlTdFV5TDI4a2JQMEp2eU05?=
 =?utf-8?B?aEdnZER6ay9EeE9NUUVYYUt3VnJJNmRsaHBNWkkxMjRlQy9nNUZ0TllxQXBZ?=
 =?utf-8?B?eDFnakpOQ2wxRWRNdjg4c3Uwdjk4OU9xOWZvK01GdHlSUWQvUk9MMTY4N1Rq?=
 =?utf-8?B?dzJISk5aQm5VdHlDR1NZT1VJMXhLbjRaZExTTHpFVENjcHBaM2Zya1JVVVl6?=
 =?utf-8?B?UmhCaDQ3dTNNQkdaOUpucGtSdkp2S1R6RHRTWFNVTVNZOXArdU1TL2tOVG1I?=
 =?utf-8?B?YjZMZ2xjU3UwaTErY2J4OEpDTk9qZnRuRVBRY0o1c0h1NkZkajlzbVV5NC9Q?=
 =?utf-8?B?VnJ5QUpiYU1rcU5DNTRpK1dqcitLNjRsRWtUNWlGR2YxMTJvRm8wYithOTlo?=
 =?utf-8?B?TCszZlQrYUorOC9tdHppaHVlUXRsNDlRSVcxNEJiRVlDRVQ0c0hCbENuTTRY?=
 =?utf-8?B?WmQ0WC9WL2hOUkEvS3oxT3pqZVZpamJMWUVCT2tpM0VnajkxRGhLYUtqTXVz?=
 =?utf-8?B?bXU2dlpmQ2NwOEVpSEdNd3BLRFdQK1EzRkRLWGVnT2hBeWhLMFp4VWgvMHJ5?=
 =?utf-8?B?Tm5FTHhsRnEyV2kyTFBkWDJIUnJicUYyeEpSMlNiZXUzdnNUSjRYLy9NZm1D?=
 =?utf-8?B?b2FOTGxSQlhscUszUGo4QnR0bWNsZkFNSHJyVDJGS1F4ZHgwbUVhV2xXRjdu?=
 =?utf-8?B?Y0kvS3p2cVgyWkxxb01TVHlkUzZ6NStjZGFIaVRBb1ZLZHNDamNPa25wV3pL?=
 =?utf-8?B?SmJtZ1lDM1FuSWUzY3I4TDFoQXBoTVN6Q2JvZUtCVGs1Ukc2ZGZra3NnaEgx?=
 =?utf-8?B?VHpGM3E1RUpCS0VGZjRQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZXSm41Y2tzNWZBTGVvOUhjbGFnWkUySDRLQ0NxZzdvcmtmcUw2ekxCOTVL?=
 =?utf-8?B?STZkbC9NRzk2Y3JoYlFvMWEyQ2RvSWs4UzVkRm9ZdmF6M1Uvdlp3djZWL3Rw?=
 =?utf-8?B?eXZ1elovNU91bW5aSktjMjRXaE1KYTl3dGtPcFRCdVN6U2VpdlV0YStYZVpo?=
 =?utf-8?B?KzlMQ1VOQkhwUVVlSjdnU1pKOFdpT09tSXZJWHRDTHkycTMxSWFDTDh1SC90?=
 =?utf-8?B?MWhRSW4wUE0waW40WjVlL0NJMEN3ekV6MmhaNGNMN21WaE10RUxCVXM4Q2hY?=
 =?utf-8?B?d0JQaTg0M1ZDMGg0ak5tU3ROY3ZseFpqb0c3MTdaNnBIOFNXQW9rMFkxZWpn?=
 =?utf-8?B?dFJ2SGltaENuWVJGNzZEeVoxNFFiMVdTc2d5WHFFZHl4SEFmNFdhVFZRZ2Zv?=
 =?utf-8?B?UU1WUXdHS0FWbndTRWdZWUp5VFVBQzQyVkxtTWM3SXN0RW5PWUZYQ3dYQTli?=
 =?utf-8?B?Yy8reGFpdHdRaElnb0tVa3V1cERlaFRhZlJNUktqandSWVFnUUthaVpwOXRZ?=
 =?utf-8?B?Nnh4THZYcDNzZTZoK3J3elVaYWM2N3NDajZ3SVIwNDdoTmpQQnBkSDhVK2NF?=
 =?utf-8?B?RDJLc3lCRTc2NWl4NS94ZnV2MExvV3R2eXVyKzR2aEErdXZuSTFFelBsQUhW?=
 =?utf-8?B?dDJKWmNLc1V6cVF3bXU5UGExYkdYVGFhaFh2b3FvaWNpT29ldDcxUXlXZzNx?=
 =?utf-8?B?ZzVPdUM4em0rTUt3VlB4Y2hxbTI0V21UZGIzLzdIOFhOTW9pOEpsbDVBcVBV?=
 =?utf-8?B?QktheHpFQlhOWnhQRWVRRzB6RStEUHhlMDRxRVZSVnExd1duWlU0MWdYOFBB?=
 =?utf-8?B?MFhmWk1OMlp5eFhOc0hqTmxlYi9EM1M0M2s0MWpzQURjeUlkNkdIRldMTk5v?=
 =?utf-8?B?WjJWWnV2RjAyZTlrL1Q1aWN6d0FGSmVndmg5R1JOQmU1LzRJWDdnWEF1dHlS?=
 =?utf-8?B?NmxpU3hKRGlpUG9tVHNERWREbHBXamMvZEJFdjZZVUFBRzlsa29qZ2llMGxr?=
 =?utf-8?B?UWkyV3VyUWhCV1JxK01xU1BDTWRsOWduUmtNTUZJUWpsbE9Ba2laSXZFQ3RY?=
 =?utf-8?B?OURNUXpVWWVyZDQ2Vk1JUllYeTR0T1VNMDhlNGVpVHVId1pHaE9DYkZ4SGR3?=
 =?utf-8?B?N28wT3VrRGkzRVpBbFZpL1gwV05oYlM1aHpzRlZOZ3VVMmZiemJsR01BU3Q0?=
 =?utf-8?B?b2c2UGhHam84b0JSK216dENoMks4Z0tLUE4xby9KcTkwc1FwTjhJeG5jOEw1?=
 =?utf-8?B?Zkpxdmc1N1hDRzRySmU4S1pDNGVDS0locDY4dWdTMFdZdXZraFBuMnJjZ2Mv?=
 =?utf-8?B?TEIvRlRHY3FaeHptOTVTa240bXcwY1dkNVJtWkg0TjZmRkVyUFIxQ0N0SUlN?=
 =?utf-8?B?TU9NdTNvN3BHYlRXb0VSWUIvVWd2blpSVEpiODEvV1M5Y1NkckJFVDFCUWNJ?=
 =?utf-8?B?OGZkT1BZV1NxZ0VDNm9tQUtNUWxyUEd1akQ0ZGdGNWp5cEtYanR5K3ZMTG54?=
 =?utf-8?B?VlozRmx4S1NuL0xPSnlJeGcrTEZjMlRkakRqOHFvRlBoM1pSZzJOTTV4Uk1D?=
 =?utf-8?B?RDZScDhLSS9QZm45ZzJvRFM0TVFibFlpdWdvU25oUTBHY0pLcGJHeVZPVVpO?=
 =?utf-8?B?bVNrS3FwQXh6TzNNNDhIbkFGejN0UUlSOTI3MUlCZlFrRzgzWUlWc2lpUHB1?=
 =?utf-8?B?eEplM05yVDBwejUwdGw5NjEzNjE5K09yYTRmWGd1OWZxOFoyT0JFaGhpODM5?=
 =?utf-8?B?R1NwTldWeGx5Z1pFem5LdFFrV0ZaK3ZkSWVwN3kvdU8rT3lKUUdlTDV2U3Nr?=
 =?utf-8?B?ZEpLVm5yMTBoMUJXc1BuckxWV0grMFJFNWFSVXVoeDVTOXdLbWM2b3dMd3dM?=
 =?utf-8?B?MmJ0QWRxNGNhclFPZDI4VXdTTGxKUWlPQ1hheVNmZ1dOU2Yxa0xGOHhUUXRs?=
 =?utf-8?B?SnpWRW12ZU12bG5abE5IRmEvN2krb2NoOTRwVDVSRy9KcmhIVlVnZlRVNGJE?=
 =?utf-8?B?M1J3Rm8vRGlxc2RLamo2U05ZcnluVXM0OXVpNjFjbUVaSjlQc0lYZjY0SE5o?=
 =?utf-8?B?Rk9nU0UwcStuY2RmbHVLV3F1dnpKS0ZZV3BwQ2JOb3ZXZmxoTHd5YXNpaFg1?=
 =?utf-8?Q?AwPKqzDkzkgUiMQ9pNg8VYNPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fa2b4e-aeb1-4da8-886b-08dcb6ee910c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:38:13.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbakWvLuwJCP8IFlV9V6uSi3sf0oAPcpgj9O5OPYEK9hnzuxxE504Tvpdy2007S1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918

On 07/08/2024 17:21, Jakub Kicinski wrote:
> At a glance I think you popped it into the wrong place.
> 
> On Wed, 7 Aug 2024 16:25:41 +0300 Gal Pressman wrote:
>> -	if ((rxfh.indir_size &&
>> +	if (!create && ((rxfh.indir_size &&
>>  	     rxfh.indir_size != ETH_RXFH_INDIR_NO_CHANGE &&
>>  	     rxfh.indir_size != dev_indir_size) ||
> 
> This condition just checks if indir_size matches the device
> expectations, is reset or is zero. Even if we're creating the
> context, at present, the indir table size is fixed for the device.
> 
>>  	    (rxfh.key_size && (rxfh.key_size != dev_key_size)) ||
> 
> similarly this checks the key size
> 
>>  	    (rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE &&
>>  	     rxfh.key_size == 0 && rxfh.hfunc == ETH_RSS_HASH_NO_CHANGE &&
>> -	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE))
>> +	     rxfh.input_xfrm == RXH_XFRM_NO_CHANGE)))
> 
> only this validates the "is this a nop", so you gotta add the &&
> !create here

Indeed, I was too concentrated on shutting up this check.

> 
> That's why I (perhaps not very clearly) suggested that we should split
> this if into two. Cause the first two conditions check "sizes" while
> the last chunk checks for "nop". And readability suffers.

You were clear, I was hoping to split it into steps/patches.

> 
> Feel free to send the new version tomorrow without a full 24h wait.
Thanks for the review, I'll try to send it tomorrow.

