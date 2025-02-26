Return-Path: <netdev+bounces-169709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B9A4554A
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 07:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AC1171B76
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F32267721;
	Wed, 26 Feb 2025 06:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FsNtP54U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38B81A4F3C
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 06:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550130; cv=fail; b=i+Ene0rQv8NmXgtDIB27Z1zMnuBAICe9KT0TlBXwhx8AjcINAHup2WoNMutUlR1CAF/QfAF9H3HB9vrHyUyIbs/b/TLL7L7gzXBv9/juWjJTyi3UqDF/y2Pcvj8ytanCMKiwo5ePwyMS6JHoV1Hdc3zzXyNIzXphmq1pqIiLbHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550130; c=relaxed/simple;
	bh=N6ueGjYeANggAZEDFrQuvLoZqwZsC1fKQPGUb8Xp43k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJsmQUa6LE2EDhrZOAjKf+CdZdHBt4PERhVDR7MkFNRM6MdVCofzg5POKHV8YelxvN+6G4pZvaRakqPUVnBKYvD8RmY0xWTkmub7fLD6lKDvoLJdz4SWsucvP/QrAes0wQsj4z8i+YQQPBfDENq3ERQkjYMZUSa9BdCoojxvn9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FsNtP54U; arc=fail smtp.client-ip=40.107.92.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9gLWS7bGrZFRS73CZpY4zXbat82bnHPKo7LX04ftBRU8n5gC6QS5lEKU+qyHA3FI4JwqYcrDNIebf1IudgTQmZkozOR+oTVGlnMVn0cU3l3vLYVDmZYHDELVnPbLH/wyLOCZBHp0ZDrOKX0/UOHgywQOTAEi0expwirmmPe+ZNaqaXWGB5bbOGIU3D7+BiiJIaUjS2YgpGCUJR5rkrKHVnrzyC5Tb9nSOlBuL/PtDoaTJGTqngvl9tiaIwkCj9vMQrEr3+wqaU9r/pFdVG9cMFUbyUVOruCuqLjRbXpVo/FPOztAoIA8/JiWch9fW3g5pwURC78ThWZM6Sistjbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=angKkyON2b0aG1nIS187ykR41HbTsffa4xnpcQjLdzM=;
 b=AGAK5ujafwABhdP0PnP06i+PjYup1esg7gqlC4yIj5Nvsn5m8jGJ/zxmR7NWfq21oOtVz2AsQhdlpeGUWjz7sCCI7ckDdoFKW2yMsVC9vDUuYEX7Z7Z4Gw59AMn1Zhlt0+aTNzH6mXGmcm+0B/vsSfI+oqcseidiKF+nUCGEOlk7w5hVXpwGuzVu0mv6VEZJ0apfW74bj8FT1XivpvxV1QPJVJILhS2R6gGKiztosz13xxRcz9YJyMqy+ByjLc+a8LklP1JXUE/+RAroe+HFjVdXyleW6AUj7HOCP6xjRrdEQmNZg0GhzODlVjiCtC7a3yIpCq2dtUhIt3g3b6cgfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=angKkyON2b0aG1nIS187ykR41HbTsffa4xnpcQjLdzM=;
 b=FsNtP54UrQ7m7uDVV5uXBilrfeeZVwxD57XQTqm1DZTxe4+M75IgsdavgSL0AUYknbAajigtY8ejx/PFajKWnd9TDfCHqOxRXdwsV7u8cWbWdYtog+LTULT+BaYZNW4XVk6p8mfxamBXrk6eaOvzN5ikQ1CRWRulEOixIPuevniSVIjj4ns74/KKxwSBZTSMi69/biWuQPCrD/OtMQx7zR5TLKAXQbUC6zDCQk9/Orf4fb997Liz3w0BxC0O/hDLgUDYCD7hAV8k7ZuAn22E/B8MYY52puNIhYCZbXyTZJ3xt0dUzLwGvHfiPRvWcrPyejWqHXZQOtkVHvsggWPkhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SN7PR12MB8790.namprd12.prod.outlook.com (2603:10b6:806:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 06:08:45 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 06:08:45 +0000
Message-ID: <8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
Date: Wed, 26 Feb 2025 08:08:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context exists
 in case of context 0
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Simon Horman <horms@kernel.org>,
 Joe Damato <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
References: <20250225071348.509432-1-gal@nvidia.com>
 <20250225170128.590baea1@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250225170128.590baea1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::13) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SN7PR12MB8790:EE_
X-MS-Office365-Filtering-Correlation-Id: 647d5fa2-6b64-433f-f2ac-08dd562c0705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDJNODF6ckROaWN3aExIaUdMYTNydTg3U25ST2k4TDUzdUtyWVVXZ2gzWDcz?=
 =?utf-8?B?QWRKMUt2clhveTRnbGZMV0pnR1ozUEtuRmNWMFFlNHE5b2xCZ1ZZN1ZRRldO?=
 =?utf-8?B?NEhXb0pmdTRGelJ6OEd0b0ZBU1YzVXNOKzZINjVHZVVwZFRwRHl3ejN1VDhr?=
 =?utf-8?B?S1MrcFcxSGxzR05jQUNVZGJZWDRpSGJCbytpeXhoaWhmNzVnRFBJdGtkNXJ1?=
 =?utf-8?B?S1VMS0NIREVNRSt2aTVPMnk2Z2x0SXZxZWp6bWFUM2ZYWnNEQzh5NU9LQS93?=
 =?utf-8?B?VmczU3k1VlRncDltd05xZFIwRHpuVCs3c1lqWXpZR1lWNEhQYVR2VzlPbmVQ?=
 =?utf-8?B?RElESXZLSHNBNnhZRlBleERlbG0vSWJBQXlwei9uV3pwUktUMjY0Zm16bndM?=
 =?utf-8?B?eUV6ay9QS0ZOWVhUUVhUU3dFaE5EVHRLMncxeGRobGRQbndQN3Z2cGhkNlZ0?=
 =?utf-8?B?ekIxMmV2UFdVQ1NveGNUbWlCbVNWY2lXSC90QUsrNXFRL3phZjU2aCtNZnN6?=
 =?utf-8?B?RGVvenpnWWZPcjJVR1FWa3VxczF0ejR1RENqRjIyOTcxaHVwMG8yMXNWbHR0?=
 =?utf-8?B?OERSWDFpNGNrNTI2bFJBZk5ER3hiZGJSMHp3cndNY3hRL2tGNzhMYVprUytQ?=
 =?utf-8?B?aHYyemIraWladll1MC9RRkNvVUtpQTdCdXJJTG9IN08rRTdUdGVVTFV4U1BL?=
 =?utf-8?B?WUhnSnk4QTVNMXBtMlQrQ0MzVGZqZXFHTlBvUzVnN1RDUjFSYXVvZDRQV3FS?=
 =?utf-8?B?Nit5M2NicThrZHg3VTg1L0xLaWRYWmFvL2o4MEhCR283VVRFczRMSGFTdW9w?=
 =?utf-8?B?U0FuaXE0VERnZ3gzNXZHN01VelF1OWxWZUIyRWt4alJEb2xjMDIraGlaTmZm?=
 =?utf-8?B?eU83Y2VTMjRQSUJxZjJHYkVoUzIyWHpZTGpET09GSXNEL3FGWHFVei9aNnZx?=
 =?utf-8?B?L082Zm5kZng4TW5GZFlyZUJqeUhaalhLMnM2b3JrN3l0Y1dKZng4L0FNOUo5?=
 =?utf-8?B?QXMwa3VPdHFxa0FGZWd6WjlpdHpIOTlvUFp3QjFSZjRhRWUvS0taQlQ5Vk9M?=
 =?utf-8?B?M1YwamxpUEhTWkQ4NnlLSDlBczEwbVdKeTNwcEVRY0ExcjMrOCtJamF3RDlU?=
 =?utf-8?B?L0VjKy9LdUgwWjJJcU9sdGFsY2Vma3ZhdURXMDAzYWUxcGg2YW1OSlpBUXFG?=
 =?utf-8?B?VE5nOGxSbEJNRWRDYXZIY21PVWJoTHVkY3UwNkFERUc2NlY4ZlZvNjAxV1FP?=
 =?utf-8?B?cmF5MVMvOUhtWEF2MzU1eGxkZGFJTkxyZFhzWG44YWRvZ3E3R0Joc0VFV2hi?=
 =?utf-8?B?amN1NmdSS1phR1VmdmJFRmhXN2lLZEtqUkJZQ2wxUUJSSHV6Tm0yNk5oUHZz?=
 =?utf-8?B?aVFXcW9jbUxmK0FWRk16RkU1NWlKVk42SnIrZ2FjNzFCYk41NngzWldHUWlp?=
 =?utf-8?B?N3ZSanA5UVQ4VWw5cmgzajdlZFRmYkFzLzd1SDFIQURtWWlaWDd5cyt0ZVdZ?=
 =?utf-8?B?T2kvd0ZCN0xGZXg5M29HNytvekwxa2hwc3dHU1dSWWw5aFNsZXBKYzI0Szh0?=
 =?utf-8?B?d1ZTcTJ6bmZueUdoTmRlajNoWGZ5K08wV0E1My9sTFoyTjhrSTBVb240SjhT?=
 =?utf-8?B?UW91eFdraW51UG9KRmRYdTVXYnlYalpOdDREUnNCM0REWkYxY0p4MERwYklv?=
 =?utf-8?B?WFM5TFA4eU5aSlhINlpEbmNSQlNrRWJ0V3dmL240T3Izd3VYRlZHRW5QYmRw?=
 =?utf-8?B?MmY1OC9sTGJwZkxxS1Z0UmxEYXMzaERhdHNZUVd0SzJZbjhlM2dNODNHdmlE?=
 =?utf-8?B?TEh6ckloWUlUSzhCbktycGJ1SE5SRmdpNFFiWngzOEN5SnpEZm1ZeVAvQjhh?=
 =?utf-8?Q?rvBZkNKSinJ5E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHFqSUNsMmdsY0xJRkFuV0x0V0JrVkp2eis1a3RVVldiSTJpblZ6VnRGU2VS?=
 =?utf-8?B?TElqOStYVk9abFpEZ1paYUd4bzBTMFR2SHRxN29QN3h3eEUwcUVrbS9mbzRv?=
 =?utf-8?B?THlIeXVGRHlHY0cvMC9Ydzg0NGliMi9sWXo0QWV3LzdrbmFIWGpZYUZJbmR4?=
 =?utf-8?B?MVkrVVJNWkFpaVJwTCtRKzFWV3FMcFVESXhtVVdZSHprVzdMYVQwZHdOR2pj?=
 =?utf-8?B?ZXNrKzVvK1hPa3ZUcWFuTU1kVncyVTQ0aGxBRkRheGpPcFdlYmdMMVJuZW5m?=
 =?utf-8?B?aTd5WUxSdktyVXA5cGh1ZFZBb0s2c21GWTBFM1gzOG90VXlRRnFHVjZCRmdU?=
 =?utf-8?B?alJWM2ZQTjlYMVYyNXR5MG4vQXdGQlQxVkRkTGg2VFMyQ1kzWkgzMFhqQm1m?=
 =?utf-8?B?amZLY1NrUEdxYlVQWHVqSEVzYSsyaE9ucDBJUTdUUGlybU5OWUQ4bHpzUnEy?=
 =?utf-8?B?MlQ4QnhtZjllRTltcEVPS1k5QU9Bckt5Q2hmaURZVUZwTWNVNVhDTlVVV3Fw?=
 =?utf-8?B?bUx0QWc2VDBTOGIrcDJQRWJjNHpnN3RmNHlCaG9QUUdPVlhnR3ZPb1FUWVpZ?=
 =?utf-8?B?UjNGL2c1WTlOMkExWnNJMUFpYmV2Qll4QmxoOGQ4RHVBbllpUXdOVUozakMx?=
 =?utf-8?B?Zk4vTmxTQ2t2MGxCa21EaXhMTE5ZMU9SbmFQaDZEZGFNUmtlczRvUjFoY3dJ?=
 =?utf-8?B?NC9sclVDYVdhWndzN0hjbm1jZkhqbDhLRDVyWC81OWFqQ2lrOCt6aklNWHZQ?=
 =?utf-8?B?NG96aHB5OUVrWWw5NFRDbUZ2anZ6Y25iTnR6ZWtoZ2wySFRUZ0cyYjBNTHJv?=
 =?utf-8?B?VkJXTFRVZ1k0WW8zVnRIS2V1cXVyKzJhbEROMUpobWU1MEljRTRseHIyY2Nv?=
 =?utf-8?B?YWtJYkVQRnQ1RXpDOElJT0MvRU1xeC91bTlEeDZNRG1kTGlodVpITVlOaVhv?=
 =?utf-8?B?NVVDWUV0WEdhZU50K2xMbldXYWNvYWM1R0I1QitKdHNBRWNyVG5YS1pSUTVu?=
 =?utf-8?B?dHBRb2V1bmVIc24zcFcrc1c1RmV5RXJWREpZWXgwSnFPMkR1SCtzeC9kL1B1?=
 =?utf-8?B?NUplam5icHNNU1N6TDRZYzJLSEFYOXJTTVBwYkNKTmdWYXZlUHpuRnl0RDR4?=
 =?utf-8?B?Ui91bGh1bm94TlQwRFpRZTQ4WjRWSjR0dlVWb2MrTG1kaFk4YS9nYW9RejZ5?=
 =?utf-8?B?Uy9jR0dWQXpGdWxBVEF1aFovR0Y5L0hoR2l3bStwaU9NQ0QwcC9UTFhISWw3?=
 =?utf-8?B?U01Rby9yb2ZWQUpybExYS2d4aVVWMWgyeXFucVFjeW9qajNERlorWEhJZTNF?=
 =?utf-8?B?VldMTnVaRXdPNnVEdXFVUElBSFlVWlZRaWY2YUtGeHNIaUJEN2hwRy9ONFl5?=
 =?utf-8?B?WWNMQTZHNURac2huWnk3K1A3QkMxN09YaHRXQnBFT3Z5cmZnb2pJeWEwY0FX?=
 =?utf-8?B?NUppQ2Roa050SWp4TExEUnN2UFZzOHdtaWgzVml2cjhKVEIvV1JEdDI2eEl4?=
 =?utf-8?B?eTk3Z1Q2NENUQWt6dENaQzZQWnhpTUtHS1Y0OUVtSEFsYkRnQWV3NGh1Rm1z?=
 =?utf-8?B?Q0czL2cwZ2hKWkx4OURmQW9iNnFPbFFXYXJ1UGZjUnQ0UzR4djQ5OEppbkhD?=
 =?utf-8?B?ZjNad2QrM29ZNk53NkI5NG85dGZTeDVQWFdQZExVdENzRmVJaGo5czJwTWND?=
 =?utf-8?B?OG9EelFvak9IcS9VMjE2R1VTdFBoOGJWN09NOVhqNllEeUJ6SlJ6bG5Ua3hJ?=
 =?utf-8?B?N3VoN0NBODRIZWluVUY5T0NlbHlHTE81VzlKSkQ0MzBJS2hQYjRtZENCeVlR?=
 =?utf-8?B?RHV1b0xqaTBnOWNZVzBrM0pUY3FidHBGbTFhWVNOZFc0cEtob0R1elRjT2xr?=
 =?utf-8?B?V25pei9kdFFRS3ZWSTVzVUc3bkxFUzdiK05QakpEUnlzMkU5b3dHem03ZmJy?=
 =?utf-8?B?WlNlOXB6NzFnRjk5M2hRZkRWb0M5eTdHQlRaY1J4VllvOTBZYjJ0ZXdiMkpK?=
 =?utf-8?B?Z2tpa2JiQkJKWVhacllBK2V6bStscVp3cklHdmF0Y2FnZEgva2pTWGpHbngx?=
 =?utf-8?B?RHV4UlliY05qbTZyRTQ0YTNEelNyR3V3bFRSdWFWMWlLS1phL1NOTWJiUTkv?=
 =?utf-8?Q?xPPucdgm7oB46YA7y0u062Es7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 647d5fa2-6b64-433f-f2ac-08dd562c0705
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 06:08:45.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzYzD+819ZQLFfN3NRofA54LA/k3HHn/MRl6zrFCFTh6SJ8MUQfz9/kpir7ITAfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8790

On 26/02/2025 3:01, Jakub Kicinski wrote:
> On Tue, 25 Feb 2025 09:13:48 +0200 Gal Pressman wrote:
>> Context 0 (default context) always exists, there is no need to check
>> whether it exists or not when adding a flow steering rule.
>>
>> The existing check fails when creating a flow steering rule for context
>> 0 as it is not stored in the rss_ctx xarray.
> 
> But what is the use case for redirecting to context 0?

I can think of something like redirecting all TCP traffic to context 1,
and then a specific TCP 5-tuple to the default context.

Anyway, it used to work.

