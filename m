Return-Path: <netdev+bounces-165398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6946BA31E72
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C1218848B6
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67331DC985;
	Wed, 12 Feb 2025 06:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lmgt2RIU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2055.outbound.protection.outlook.com [40.107.100.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5A2B9BC
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340341; cv=fail; b=HS1VZecbuu5ykdZG0bqlRTsjd3Ll9TlGscQ7FUI1mzsv/iLeoPkXxWzsaQjnltCMB/7XF/SYNqb28WkZff10gz0ksrCiJ8EfeK91o5bwzHUJtnTN/3n3x3AAWJBCouMnznOzcn3Es9qjzOUOKgAz/+SrnlxOuijDdXqdSrJKyek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340341; c=relaxed/simple;
	bh=Fy/EtEu4F3h+kJ+xYvDPBamYcf87Ip1rsu4G9OItEo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AMd2UtwXI+ICJAAMx0LPvkKOec0NKruaMPK+R2QqKeSK7nGK6tTkhsw5wN9MF6/KNJgyPHe61IYyJNhjHeT9hdem091kqaBMcFsJsjSlLlYb7ju+kTrMpyf7XOYLB4D2c0uXNfhdfJrfditRry4ZQ4BrXqLuYzTFWW40coAsWaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lmgt2RIU; arc=fail smtp.client-ip=40.107.100.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+RWSmwYcG3ZiyLjoiTnAsDvbBLVZ2ZjT4l2k7rMBKJJ+5BJrV951Xyicl6XexgOX9NCCC0+KHdoZQKXAxGRZG5hw2tD6qyM0VjaOL0goeWn41iPqSMf+U2S5ZMxxSCCFmJmxAyc2dFWDQQnLElmYF4hCpBsrqLbQk8Zv4ENEQ7DHVb0OHp8B4kHG/B288ok4vrdVZtCf9LnjW1zbw9xVSGqoh45Jy+HOhROGVo9KYPjfuMq4WaLxhQo/qyVvGUuT7VJblvYDeqm3ZXeY6SwT7G8yHoW13+XZCnF4XG+yryUKn88U4LDXVv0IfOhFvpMPlYzuInAqNou+JXioVYfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBH5o7v18V8zctoHAIp0WR0trlxtS5IP29/vVHBsWeg=;
 b=DJIqEv2kGk5niSLavKmi/AJ8hbO8eFIzwm2CJ1ysDtelnfax1luBc//UNQ9h0HGXkUtOWCMql6UGMye75VtDBP0LeWReZVTy5uq5Ns8whV/ik3Sq8VTQ5eYLha3DAW7+Hbgf9AJDN406KxEgq4HuPZRrJqY0DeTJwu4T1TIltoXdl0IgoppGzcJgH5KlYqBKgemVDaH4+prdqjOILDBPVqpBvwdXH0VgUJgk86GKrffP/gC48187r5atBz9ALIlxfs4qambaigW7jLsEtqJ5Fz1grZ3yl1aQzDRYKCkLq+Tdb2VcpnbmmnJwtNOi14muYfhp5umII34Wvlvw/KryoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBH5o7v18V8zctoHAIp0WR0trlxtS5IP29/vVHBsWeg=;
 b=Lmgt2RIUcpXOm2Fb54ZbMv7VU8ibRyUJ04E0Oazf+FvfmEB8sazbH4nsYQJO/BDoatSAvUuNUUExtx88axDjCQPez41KwVzJW5pGKWlqAhZJJr52B75HPv21aeJ1XKZcWfszvR0oCNxQq0nwhVejNcFy8sSvOVJVYv0nN1DFtKFk94sVC5WgYPiN/p5HMmcbAWXRjeKem2PYj8PvbOjzRjVNvzGktSmwk3p8XuDGXPpoDbTjizcbGYVmAk/Qw1eonm62L6Jv4iOPtmMxemF9XPdV0/ST9YDHVIdxpxkQ9MHdOJ99K8ytdJ3ANQXA4wtTIx9AxEN+uuctKWMfBP4XdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH3PR12MB8933.namprd12.prod.outlook.com (2603:10b6:610:17a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Wed, 12 Feb
 2025 06:05:36 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%5]) with mapi id 15.20.8422.011; Wed, 12 Feb 2025
 06:05:35 +0000
Message-ID: <3d364d65-6db7-4daf-9657-8f547b850710@nvidia.com>
Date: Wed, 12 Feb 2025 08:05:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] eth: fbnic: support RSS contexts and ntuple
 filters
To: patchwork-bot+netdevbpf@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250206235334.1425329-1-kuba@kernel.org>
 <173920504025.3817523.12316203538556886634.git-patchwork-notify@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <173920504025.3817523.12316203538556886634.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0666.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::17) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH3PR12MB8933:EE_
X-MS-Office365-Filtering-Correlation-Id: 790eaf46-cd75-4e0f-8ec3-08dd4b2b43b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3B0bkZ1V2FHSHZ4WTR1bDQ3MEhnKzJhbkN0aUJVRlJZSC9GVGJZU3ZYMHhh?=
 =?utf-8?B?RTdjYnptVVEyNGg3MHVLQXJBUjd0bHNCZEk1WEZnWHRham5DbE1UNjVKSXgw?=
 =?utf-8?B?aTVNRTBveHBHdlNKWHJxYithVkp2VEdha0IvOVYwaWQycjIzNWpDTzhPZFZk?=
 =?utf-8?B?K2hiRE05cW8rRThjNGxzM2FCVS9VTUJ2TVZSc0N6ZWxlOWxCVUlGeTBVaWVl?=
 =?utf-8?B?RnZObVlNcDNTYkFXYXduYnpwQXE3alB5WGIreTVseExLSFhXa1NpZGtiYzYw?=
 =?utf-8?B?N0V4bTc4Mkk0UEtxb1IyNWlGQU5YUEJQOEtVMEtSRFBkOGZKWFdCTjdNOTZJ?=
 =?utf-8?B?bjFHdDdQUEUzUmw4c2NLYlBDZkNPVCtnSXgrWW1ZRmZ5ckN1T0VTTE83SThS?=
 =?utf-8?B?TE9IOEpQbWd3Q00xc2RVd1dWekJibzh0UkJEU21ieVdJcGpXYnAzanhVOXhw?=
 =?utf-8?B?WUdSQ09IMTA0VUdRTVJlWm5mNkRXem82M2pacXAzTGNJblZ3Q0s3UTY4OE5z?=
 =?utf-8?B?eFBjOXhuZGUvNUpZejV5UTBBTzZwYWF1VTlhRWs2U0tacnBaV2JzTmVHQW82?=
 =?utf-8?B?NGFBbnNlOExoZXNvaTM2UldUR2tic2plVk91YzBkYXZ2ZlQ2V09ZUkQ0TVdy?=
 =?utf-8?B?eGV4dDIxOFJDdjVDL3FlR0lYOUNub1NicU5wSEVGNWwrd1l5WGVuNDF1QWF3?=
 =?utf-8?B?YnliMG85ekRGU0ZtUytJUG1qaEJmMG53ZkV5NjdHc0ZlQ0pYYWdCSHRvcHRj?=
 =?utf-8?B?aW5FZElMS3hpQ2hDYmNCUHVCWnFIM3hRckUzUkVwY3NxMXRGNmd4SWJJdGQx?=
 =?utf-8?B?QWNwU282bUJqOVgzNVNOM2JnY1VqL1l2Z1AzVXdLUURqUXBERWZzMUR6aG5y?=
 =?utf-8?B?YnRTOXBTOXpXNTBCSE0raFhvT3V1aU94OUN0dXp3UzRoaHQwcWV4NDNWYVd6?=
 =?utf-8?B?TW5UbGh3SW14eENFZTlYVlRRS3RiSVlGL3p4VWFlbStFdEFPQUE3U0dzY0Q5?=
 =?utf-8?B?NHgySTB2TG13RHU5eStDdmUrcjBJbmNpRUx4MjJYcHVtVkd3cDlWMmJhZE4v?=
 =?utf-8?B?OFl5RjZ4RDZPY1Qzc3ZYeFN1UmdxVGQxY1BacEdwaStLU3ZrREtnQXVmTnM5?=
 =?utf-8?B?RUluWStjdVFjR2FLSVJlVnE0cjUweElzMVVvbHpVQlNwbGZiZy9XZi9qdGMv?=
 =?utf-8?B?Y0R3a1dsK2Q2cVU2WUdSaXF0eUt4UnZidGVIa1FPanlIL0k3N0E5ZkdkNlJz?=
 =?utf-8?B?YytjWFZGN2dleEltSFpjMlZSZGlSVWlRZE4yVUVaNDFXZVlxbVRhQitMRXJO?=
 =?utf-8?B?WWpjZkkzeE1ac2VQb1RualpiZ3dGU0pWTmRSaTR6Uml4elY0b083K1hoUWNz?=
 =?utf-8?B?NlFUN0dNZUZheVFuZnFWZytvTEM0c0hSQjZWU0lCd1IyeUpRTGNMMi8vWTFs?=
 =?utf-8?B?ZzJSWklJRklHNDlVVGFKWjRQVXVCZ2U1RWREaFdFNmNuU0o1ZHhLbWJSMzdP?=
 =?utf-8?B?QW9FMDZyL1RNZTdBRnB1V0Vsd05Od1RvWitKaEFERDJPU29ZeUt3dXJQMmd4?=
 =?utf-8?B?UVQ5WU50aTdUZGcrQ1BNWU5OZFgvSFkrUEdtTDl6VUw0elgxSUt6emx6T0ZS?=
 =?utf-8?B?ZWpIQmI4emQxWmYrSGFVVm5Yd1p2NEFFdXN3R2MvQkp1MzloeVI5WU0wY0JY?=
 =?utf-8?B?Rmp3MWF3Q3B6RDVuRFJuZ0REaTlLWDF5a3p6a3M2aUNTaTdqbWZ0V2FHazBY?=
 =?utf-8?B?NlRoYk5mbFhJM0g2WTFqcFV5eU1TUWQrdklSZit3d0VUckxCaEw2MEJDZENm?=
 =?utf-8?B?cjZiRXJaSUthd3FUSlVoZmZNdHMxTkF4dENjK0F5d0lNdno4V3E3WDZwUlFZ?=
 =?utf-8?Q?dm7zz5QE2HQ0G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmttckhFZ0lOL2l5ZFJtMTBzYTVYZEdGd2M3a2dSSTBSMkVsaEJlWmpqNUFE?=
 =?utf-8?B?MWdBVlVySlhvTmFmMjhJcW5JRjRJZHVXYUZ2QkRFUHhpcGFob2xyUFZMd2xF?=
 =?utf-8?B?b25vVWdBRmlpeThoS2pwZVlTRXlnSkxRT0w2ZU85bk5SbUtzNDYxTHVWdWpS?=
 =?utf-8?B?RjZUM3FPUmQ0alArVmxXS1laVmovUG9GZ0NHVzZDU25Cdzg2dnVPOC9UZXBI?=
 =?utf-8?B?SXVKS25JT2M3bmZMbm9SdkY0MExxVmdGaURacDYzVUg3cFlteU0wOElCRVI3?=
 =?utf-8?B?OEZpZDhZMnpFaEZ0cXJ6clMyR0w3M0dlNWdhQTkrRzJSSmNNTXBWU0FWTVVv?=
 =?utf-8?B?aG1GMElGZzFldWM0aHVoTXBFWDNzZWtJRFB2YVVET0k0cnJZcUhSM3FqbXVy?=
 =?utf-8?B?RUlEaTZOSDZMNkhrRWpzeXhDV3NlQ0NSaCtMQU50V3ZndXdVT0pZVTF1VEFZ?=
 =?utf-8?B?ZnNXeUNpb0FoTHhyU1h4Z2tMTlhlbkVMS0JTSEQ2MmM4V24vZnZjWlB0YUxp?=
 =?utf-8?B?cUNVdzR2ay9LN0MyTnd3aXB6ejNTT2lvRnFZTXh6K1dPb3pjOWhienZMZDdS?=
 =?utf-8?B?Q1h4dUV6eklubXpPM0FqQU0yNS82dCtWSzFieDN4QTUzdDJ3YnRNUDNUZ0cy?=
 =?utf-8?B?K3kwbXZyZFVaR3loOUNKSEtSZHY1aDZuSzlEWFZ5TXVGSU5VdFFka0V3cWtP?=
 =?utf-8?B?WkpaeElTU3c5ZU5JdTgwZjR2T0kzRTZnZmFJNHIyRjNoYi9rUlFOb3JMTW1H?=
 =?utf-8?B?QlFxUnBVeDhhVy82UHJvOXRzZEhzVnhUVzdNQmFGZU1vUXQzRUFROXVWVG1a?=
 =?utf-8?B?eFgvV3RkYnRSNXd1bWVXTUxZQ3puanJuVDZncE9GT2NZWjdrcy93U1dmeGk4?=
 =?utf-8?B?cU9BbWZoKzVpV1pLNnRCQTNXNmI4eGtGNVRUSDFZY3BTVWFCZGpxd3hmcDYv?=
 =?utf-8?B?bzE5ZGs1ZUExWTdvN0hpellXSGkvdThKV0hSc21hMU92Uzl3SXJyZW1WY05Y?=
 =?utf-8?B?T0FPS2FxcTZMeXBGanYrUFJRVXdrbitoZFp3WFQyQ1ovY2Q5VWxzM1hueGN0?=
 =?utf-8?B?ckhPWlVpanhLeXVhWWJYWFZJUi9WSnN1bFBhNEh0ZnlyYkdWc3JBS1RRaTVl?=
 =?utf-8?B?WmJadHVGTjgrbzFtcm1vVkVFSVlZbGNadnE3bkhqV0MwS2hrRXZ1OUpMWGNY?=
 =?utf-8?B?VVdyYWxuaGNoZWwxd1h0eEFvb3hDK1FtTUtuaU0wNzJwR3FVenY4Mkd0ZFRJ?=
 =?utf-8?B?L1dvSVpyRVBuVmtWZTB2eGNmdE1vbVpPTnVLb2o0YTNiRUxWTm9udStPWUt6?=
 =?utf-8?B?aDFkbmRMVnNUSGJnNkR3K28zR2Y0SnZ3NldPeEhhbUFaL3Jsb0h4azN3YjZ6?=
 =?utf-8?B?SlBwdXZGajhFdU9aM2RYU3NlT3RDR0ZLRWNxTEF4b2RLbWtWZGVoZlFWUVVR?=
 =?utf-8?B?aFRreFc5QzFjcUowWGYxRDFOTGdHVm80eGFQbzNIYTNwYzlTRGtyb2wvMUxy?=
 =?utf-8?B?TlA0R2pUa0RCdnd2My9EZVExeEV5QkV6UmRIa1RMVE50MU5GLys1N3JEMThI?=
 =?utf-8?B?eHYvREREZ2dmbWtvaUJpVkZxOGtxUmZHUE4yVHZFT2k0ZEZhbk1OL2dBUWQ0?=
 =?utf-8?B?bTNKRHFEUUZmY2J6Z1ZLWjdwUDZuak11dWM5cEdKOHk2Y0RDRnh3UENlSTM4?=
 =?utf-8?B?aHQ1ZFhCL1BWMCtQWXBPSGUzZXo0S0ZtTHI3ZEhvdm9ialF3NFVhbXBIUG9Y?=
 =?utf-8?B?RXRZZitYRFF3QTBKbVJBNHA3MWIwYStHdFNNYnVaem5mWlpQcjd4Snl1WDJO?=
 =?utf-8?B?Tjc3akxFYm52QmJ2NWVQTm9PdjlZc3cwMUF1MGJWUWhDTS9rdkNXYTBSLzRa?=
 =?utf-8?B?dnZwdVUyUmFQT051eVFCRXpHOWR0T0cwdjN6aGdScmp1eXpPZG9WQWJHZWNJ?=
 =?utf-8?B?cmR5c0wxbXRzc1pEcS9jUmJWN05Leng2dnl2VVZadVd3TUt1TlpDbHl2eFg0?=
 =?utf-8?B?OG83OWtCSEY1NlZTSUxnZFF3TzRMOUxxYml2Ti8wVnprc0p2NEpDT3UvSmx1?=
 =?utf-8?B?QVVSdHk1T2Q2M2FkSDhJQnIrZ0JEMnlBUGJBUHZxRWQwd2Q2ZFZlMDBidGlS?=
 =?utf-8?Q?g8uUjkM9apfihW/TmG/mH2l5O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 790eaf46-cd75-4e0f-8ec3-08dd4b2b43b6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 06:05:35.1619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXaiyolY/jOtnz49EgShcKBm3j8J7SxixtWDKaCfYpUjV1DLi4Q2j7ZN1bV2q+mN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8933

On 10/02/2025 18:30, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

You ignored my comments on patch #1.

