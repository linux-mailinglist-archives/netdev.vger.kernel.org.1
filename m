Return-Path: <netdev+bounces-161522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB10A21FAF
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A612F1885009
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5FB1B4257;
	Wed, 29 Jan 2025 14:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIuh8Ifo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCAA191F95;
	Wed, 29 Jan 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162320; cv=fail; b=YRMfwnHPYDDtfaBjqNDsof8FhlYWsvCLHx3OOCL3bxSg6cMsVo1usg700qBYfChiYh3LdHZwh49K52VeVDrWf1QBGRPDMiQ/YGXy/+1p89DI1vKG/uD6HEgYLsetO1IYW0N3Ulh/3cXhUny8DSsVpiviUrRXulkxQo0+m2BKsu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162320; c=relaxed/simple;
	bh=761QXyax1fikhX08rlR7WHOOrnXW5pLjN+yKhGnMiac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mIlbNSjvh4fLYIf/2L9xUtJ1cFwuv2GjrdmDNQCKgciCNiauWGKXc+ITCIT0T35KMwcN1GrnQMT43SKjTOqGY/94KyrjKnLx58bHHcOAFnUsWAw7lXXtxe/YzJzMw5DOzb3siptU/XeALVUXnFF2+mKkL1iGcrKrpwASmKynTEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIuh8Ifo; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aduf/xQ5Yj7RInB0BeV2mANOQrJ6+sQ4EYqooAeWrehofGySmUC9q9DHsyYByQHqj4kqjRtnZ9074NGk5LfzPcSsVzwhluX7edYIJsNtUgT8X2Pb+AyaIXvGx+GRiMDGtpQdh49A7x4heod0+kZ5MuU+UaMFwRxit30ckpDyn+qVPZAJ4pEc4Dt+7n5870MPXqBGEjR+aH3iRDwNyIlr4TsxcyF+KYL1MGWTHtWMwYXdfsAxy/2GnJ5IqN1o96JQm5V/4gd8enSGOj6m0zueiAnLTcIsmjCtIGfMaU/1tEeQinBktndK1L40LxsgWR9V+H16y8HwK5ThO0n5q9fAUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bl/7CN/1aSDoK7kdURx+lTtGBwEUh+6dntcmLvDMrwQ=;
 b=qrMGFn2UYSSgFKw6+SQaRi2YenaEO23/Nhm7o3wuzYFQxEZzmFOMvHuM02WVO4mj54dxb453q+TUrtCLJ/Ii2hmCc72mOUd1h9zYB0OQ+Sg5HJY1Ei5y5etTLcdu5RJNdeJL6Ye7tMZHsaKTTKqJ6XI5WzCRsgCH9j6JZlh+0VbdL6TzcBPjW/b5P2fgXshAE0wlZ1Zrq0AD2h1IU73V8HLdqnHFlPXKgIfnngamqNpuxNqcDftvEP9moESecTqw1hyv6ENH7IDbquOYVxNSe/dMmVRGzSlVCl15MjR6rDlPzVmAn7uyyT3HX31FUbKH+lFfu58HIg4Wu1B8Y27piw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bl/7CN/1aSDoK7kdURx+lTtGBwEUh+6dntcmLvDMrwQ=;
 b=aIuh8IfoopwVXlhxoK4LIyTM0wryubYfKgiLnbwuZllxkk4OlrrDis4m0IjKKz8yzSSdBz3VTy4PlX1u7FNNa+hK/DYpkb6fmF65MkGJGIPsE3ZENPL6uMllXwN47H/XOZZchAsim5dcdhlR84zvYIHBJosQt3ca4RgRUbFlDHkgzvhVBqcjpzFxYRHXDN+NQFKLu66uBGiizbdQ/X2O/B5JMqEVEPAFxlBW4OvPxFfmhQ522qClWSRN9+EoE/Y7otPAQOqFBjZs49wbPCYhHtAvLrXE4iJCZBmQ5eJEmU6uo7oMGEVfrSCw+kifPyXUTPK5mleD5oceLHuMeNmI1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 14:51:55 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:51:53 +0000
Message-ID: <108592a6-de5b-4804-92ff-c7d4547beff0@nvidia.com>
Date: Wed, 29 Jan 2025 14:51:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/4] net: stmmac: Switch to zero-copy in
 non-XDP RX path
To: Thierry Reding <thierry.reding@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Ido Schimmel <idosch@idosch.org>, Andrew Lunn <andrew@lunn.ch>,
 Brad Griffis <bgriffis@nvidia.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Joe Damato <jdamato@fastly.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1736910454.git.0x1207@gmail.com>
 <bd7aabf4d9b6696885922ed4bef8fc95142d3004.1736910454.git.0x1207@gmail.com>
 <d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com>
 <20250124003501.5fff00bc@orangepi5-plus>
 <e6305e71-5633-48bf-988d-fa2886e16aae@nvidia.com>
 <ccbecd2a-7889-4389-977e-10da6a00391c@lunn.ch>
 <20250124104256.00007d23@gmail.com> <Z5S69kb7Qz_QZqOh@shredder>
 <20250125230347.0000187b@gmail.com>
 <kyskevcr5wru66s4l6p4rhx3lynshak3y2wxjfjafup3cbneca@7xpcfg5dljb2>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <kyskevcr5wru66s4l6p4rhx3lynshak3y2wxjfjafup3cbneca@7xpcfg5dljb2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ddc7b1-f3aa-4b44-445b-08dd40747848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFNKM3JnY1lZME9qajhOZ1VFalZZbVdncXplVmRXd0t0eklJNlgwSGwrQ05l?=
 =?utf-8?B?OThtYmhtcGxSd0hKeWRHV2ZSNmxEbTNnVUIzdVlXWHp0b01kMDVRL1Jod1Za?=
 =?utf-8?B?d3hjV3R1RnhDVjhWbk5OWVUrRGt5YzBMMy9KYmVyUGtoOTJ3eGlKQlVBY3lm?=
 =?utf-8?B?QVM1dlU1Uk05akRQYWdTS0l2TkZQRUpmK0NGeGoraVFXK0R0bTI5b2VFbko5?=
 =?utf-8?B?aXJ3WVBkZnpNYi9JNjA3dWYxS2xoNmw5KzQyZWNCSjFtdVBqa2Rjb2hxL1FV?=
 =?utf-8?B?a0xjZkZUaW1FTU5MYVpkSC9uUTJNRUF5a2tSaEdGaVpHN1g3eXFhM2cyWDB3?=
 =?utf-8?B?NG5uL0ovTkJPSXN0K3NHdGxONjZtbVp3Y0kvZ3VUdUJsUU93cDFFMDFTSUI3?=
 =?utf-8?B?RjY3bjNxd0FHbHlkV3N0akRIM3dVRzIrTEJ0RGRUUW1aMVFZM1VpbEFBdUlx?=
 =?utf-8?B?Q2ExWkVjZXl5MHBFdjhyZ3JkWjVwV0JRdXJpdjJQQ0dLQWVLK0JjUHFoTjhC?=
 =?utf-8?B?Ymhkc2t4c1A2MWdHUTUvNnhYSm5UQ0Fjd0RBSUVYUDlidEVvNzBqdko5TGR1?=
 =?utf-8?B?K0xMUm1TM2NXWUZtYlRLczNtMDdqcFJuWkhDb0hvazJNVXE4TU1YRCtmL00z?=
 =?utf-8?B?emUzY0c5M2JNMVJyeWV0QkpVZnl0NWVvbjByWkljazlIWEw3SUFUcFJNVkp5?=
 =?utf-8?B?aU12d01IblRpaDY2bEh4c1kySmVJTmVPRTJmMWd6WUo2MXJDZnE2WWFuWWl3?=
 =?utf-8?B?NTJVeWxNRHozUkhnMDB6Yno3SlhNTlF5aCs4TnBObXdxNmN2bnhBOWZnaHUv?=
 =?utf-8?B?eitpSERCckhUcGRxVTU3T1RldGNjNm43M1krYmV5M1VuRWptWFhmckJyWCsz?=
 =?utf-8?B?bCtEWnlVQ0hBdzIrQVVneFRDekJ5SFB5Q0Z0MG1yMDRmVmRPTlM2OXBpL1ZI?=
 =?utf-8?B?eU95dmNvVFFOclZhMHZ1RG5LQjZFellnaFlmcmxtNU9SWFRxT0dYNWxYWWY5?=
 =?utf-8?B?VE44VkxpS1JiY1lLSWRlMnowMnVBUkJZZnhmQUZBLzZmYUV0VTZrZTJUQkZt?=
 =?utf-8?B?b3NFZVpIQkJ6R2dFZTI4ZXFFakZuRUkzVWwyOWNXR1g3ZC9YTFp2MjBmOEJY?=
 =?utf-8?B?WkJVZVh0Z0hUYnZvR3lFVnN6ZzBOYVdQNmszaVNQSG5BSG5mcWZWTStYdTZG?=
 =?utf-8?B?enpPNXdZc3VGbFh2UFo0aVlFNTFEQzBwV3BDTk1Fbm9CUVQ0dTdZelZUOEVF?=
 =?utf-8?B?cUlITDdMR2w1UEtUdzd1bDdTOVdzZGF1ek1KUTFMR2ZBUkNycXNmWjVKTllV?=
 =?utf-8?B?bk4yMXFoMDgwcXpyNlcxdlFjS2dYbUdTL0JwUUhHZXkrLzhZY1ZKdnBpaDQv?=
 =?utf-8?B?S09RUVROZnRmZ2k4MGF2NWNnMmxwUFNqcGdDZEVXU2R0TjVadUgxQ3J1WmEz?=
 =?utf-8?B?WGRtMUFPeGNIeHpXTjFhc1duZmNXN3J6OEtRVXJRTDlieHdCNDFXWC9qWFhX?=
 =?utf-8?B?S1N4TFhCcDFEcE1MVk83YUFwKzdtMTNjdzFzWmlGOGxCUUh4TjI5dDRmdDVZ?=
 =?utf-8?B?cWx5eUttSCsrMGZwQ1B1SXM0aHVNcnBoKzRRTnY0aDZ6cnp0OFdEM0h4Ukhw?=
 =?utf-8?B?cHNTNzAvc2dLb1ladEcrWGJqWHo0bmk2OVpySWd1UHpSNjVyUzQ3bENqNmh5?=
 =?utf-8?B?RE9pSTdrZFdVMkw4bjJZSCt4K1VwUFZoMVJLVDA5dVJTR0t6bHBxdVFkLytk?=
 =?utf-8?B?bHZBNFNpblBVblNwdDJJWm9Ycmk5NHNiblhVVjVka3E2Uk5LdDcyUEJyc1RD?=
 =?utf-8?B?dEQrYTQvMm56MzRzM1RicmdNREphWmRvQjBibFdoVzMrL3NxM2Vpb2FZVXB6?=
 =?utf-8?Q?0tTlvBaX/PBP0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3doaWJDQWZBdlJBdHRyd210WVRnZGoxNE96Umg0U0RvSkpRR2FjSjRiUUJw?=
 =?utf-8?B?aWRHYWRmSGMxaXdMbGhYQ3htdWFqMnBOYnU4RGNoMUZRazJvNnVVenMvSXpr?=
 =?utf-8?B?RnVGaENGKytOVjVYcTRhRVZFL0JMWWtOcGo3cTRseEJML0lKRHhDODhzUGhD?=
 =?utf-8?B?bitQUG9sbHZxODhBcEt0ZEZDeUp3cnRGUHU5ZEh0UTQwTzZQaHJMVjVuY1hl?=
 =?utf-8?B?UU9vaDQvb2lGZkxQeFprYm5OUmt5Q2Q1eVhQbnpJemlpSHlSbkNhNXJqclRu?=
 =?utf-8?B?ZElQeXpBejZpN01uc3JPdWtKQzh5eFg3akRRUThZM1FKSW1Iai81RnBmRysw?=
 =?utf-8?B?S29LbEk2aWVMUWNrUzZ5eExrcnZmMDVXZWRaWG1yL2oyZzJmbXJQSHpuanFn?=
 =?utf-8?B?ak1MLzhwWng1VUZBWklBU0N5d2hwb1c1ZFJKaVhyRFNvemVsU2xaa0xKUFYx?=
 =?utf-8?B?NWZwNlZ3alFuaEJYVEdsNFE2akdhUkNYRC9oSFhxUmNmVzZ1TWxwUWh1bTdw?=
 =?utf-8?B?RUFTLy9vMHFYd2J3cm1kT3NjZ015d25COWFXVXFvUW9kTXhSTG9QdllTQ1My?=
 =?utf-8?B?dTc0MFN5L2VSdXJoRlVWQ0lCZVViWjcwZkFEQU4vMk5MS1l3VUJtcWlJYXhp?=
 =?utf-8?B?aGZBd2NGL1IwUWhpU0JCaVVqdzlTSnRXRFVTMWpLcjNHdThwU2l2cTIrK3VZ?=
 =?utf-8?B?eGpiejZHZUFrejRJbXIydG1DdnkwNFVZQjl5eWlBS29BcU5nUHpPc1gwWDd0?=
 =?utf-8?B?MVZaVk5aZEJKTWdLQnZuczVIUEk5TlYxVEhUUHZMM3l5SHdwbzkwN2JteWJV?=
 =?utf-8?B?K3RNVzBBMmYzNGoxUC8xbEFsck5GYXdJNVM1RG5FdmErYWJjYUR2MHZIVFJD?=
 =?utf-8?B?Y2k0L3pnNDkxQkdoQVJrRFhFWStNcE5pTlFqdmtjWGllaXRRRXpleEdGTGJN?=
 =?utf-8?B?ak5mNDZtcktLc3JqNUhxTTdBK2xsd2QwUW1tTnc1S3hPK1VFaUI4UjY0STBE?=
 =?utf-8?B?OVlBcmJNVnhNaE1WMExQekZmNUNOSnNCM3F2U2NXTDBzNURPOERPREx3RmRs?=
 =?utf-8?B?S2lMZHBjR2dIbkhTT1B6VHpjeUN2VTVZa2Ricjh5dGJPN09VT1Uwc0pxYTFv?=
 =?utf-8?B?MXRYbVdFWCtEa0tWTGpGaExvWkNkczU0Q0pIYVRnd1Jmb0xsT3NIL1UydTBs?=
 =?utf-8?B?aEtYQTgvcy9EdmxqK1JiS3p4Mzk3ZVQ1LzlnWU1RdXIvV21pMXQxRkVYSTV4?=
 =?utf-8?B?VjNoL2E2bmlWVzV6TytydkQwRTJ5OTUyeTVyNEFwQmR0VWdtdHBjSE50WW1h?=
 =?utf-8?B?V0NjT0R6OFpSMkcveXFRbVY5ZGRsdG1rZVRQVmRIcm9mTFRoUnRxT2xVN05Y?=
 =?utf-8?B?RGFVNVExUGFaY3NyamwyNnR4Q2hNVVcyZnVEa29iSjRmczYzQU5rZ0FWajZD?=
 =?utf-8?B?dU94SE1UVUZ0V0hVTVVLTUJoN3dTeHdabzk0ODI4QUhoVE5WYytQQytJVCtO?=
 =?utf-8?B?ZHRFS1RzdHFQVUhrbnVLMGZxRWxOWXRsTFZxbGN0Vkdvek10NmN4N0RmY21E?=
 =?utf-8?B?UmVzNVI4M3lFZXUweS9xK0dudENEdmxiMDhqbThPWm4vMWdqVHZoc3psMDZE?=
 =?utf-8?B?T0xwVWVFTmFVU2l2UVlmUlBzRDM1eFgwVDdpSjFQZ3ZLa2NHQ1VPWWJESmdv?=
 =?utf-8?B?YkZWWWtUZkF1alQ0YmVONlRvckIrRW1EdWIxelFUUEZSUWN5K1RVUExCRmts?=
 =?utf-8?B?ZEN6a1NYSnY4Tk1JVjJuTDVhUjFIN2ZINHAvTzlHRmxrK3NhTTFqQmFvYVgr?=
 =?utf-8?B?dXRCVWthVHAzYmk5U05INDJ4RW5ZWS95REYvYkt2MGdKbHlaL0E0d0VlbEtR?=
 =?utf-8?B?QTdPNGtrdER2bmhZVDdlaDExYWt0TnV3a2VDNXpXazY2cEhrM0dKRExoak9o?=
 =?utf-8?B?SFFod1ZiMHdMd2pPcStnbk1mOGxlUitvQlJ4YmxOaGhTZ0dNTWRVeGk0NWZM?=
 =?utf-8?B?VTJmbXRlVWRCUUlLaHZMM1FjZURvUTMrOHg1ZlMrMThwVnpQYWxoTkdpZXFL?=
 =?utf-8?B?OFAwcFdVa1Myd0V2bEtMdVgzT3pnS0pObFVsOVN5bEt0T0JuakM3a2hUR1pv?=
 =?utf-8?Q?+yJqG0NYi+L3FqrFiT2KtNxMM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ddc7b1-f3aa-4b44-445b-08dd40747848
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:51:53.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk7WDLjLp373Ln9+n9dEVsPydz0EoIxNti+CyWMSqvZcvq52ONStNswovLnA3pLWkybV8k4I5tsGLOof8CTX2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

Hi Furong,

On 27/01/2025 13:28, Thierry Reding wrote:
> On Sat, Jan 25, 2025 at 11:03:47PM +0800, Furong Xu wrote:
>> Hi Thierry
>>
>> On Sat, 25 Jan 2025 12:20:38 +0200, Ido Schimmel wrote:
>>
>>> On Fri, Jan 24, 2025 at 10:42:56AM +0800, Furong Xu wrote:
>>>> On Thu, 23 Jan 2025 22:48:42 +0100, Andrew Lunn <andrew@lunn.ch>
>>>> wrote:
>>>>>> Just to clarify, the patch that you had us try was not intended
>>>>>> as an actual fix, correct? It was only for diagnostic purposes,
>>>>>> i.e. to see if there is some kind of cache coherence issue,
>>>>>> which seems to be the case?  So perhaps the only fix needed is
>>>>>> to add dma-coherent to our device tree?
>>>>>
>>>>> That sounds quite error prone. How many other DT blobs are
>>>>> missing the property? If the memory should be coherent, i would
>>>>> expect the driver to allocate coherent memory. Or the driver
>>>>> needs to handle non-coherent memory and add the necessary
>>>>> flush/invalidates etc.
>>>>
>>>> stmmac driver does the necessary cache flush/invalidates to
>>>> maintain cache lines explicitly.
>>>
>>> Given the problem happens when the kernel performs syncing, is it
>>> possible that there is a problem with how the syncing is performed?
>>>
>>> I am not familiar with this driver, but it seems to allocate multiple
>>> buffers per packet when split header is enabled and these buffers are
>>> allocated from the same page pool (see stmmac_init_rx_buffers()).
>>> Despite that, the driver is creating the page pool with a non-zero
>>> offset (see __alloc_dma_rx_desc_resources()) to avoid syncing the
>>> headroom, which is only present in the head buffer.
>>>
>>> I asked Thierry to test the following patch [1] and initial testing
>>> seems OK. He also confirmed that "SPH feature enabled" shows up in the
>>> kernel log.
>>
>> It is recommended to disable the "SPH feature" by default unless some
>> certain cases depend on it. Like Ido said, two large buffers being
>> allocated from the same page pool for each packet, this is a huge waste
>> of memory, and brings performance drops for most of general cases.
>>
>> Our downstream driver and two mainline drivers disable SPH by default:
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c#n357
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c#n471
> 
> Okay, that's something we can look into changing. What would be an
> example of a use-case depending on SPH? Also, isn't this something
> that should be a policy that users can configure?
> 
> Irrespective of that we should fix the problems we are seeing with
> SPH enabled.


Any update on this?

Thanks
Jon

-- 
nvpublic


