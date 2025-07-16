Return-Path: <netdev+bounces-207378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A145B06EEB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657003A70F2
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 07:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDB528A1EE;
	Wed, 16 Jul 2025 07:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dmUH7+jm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246D9289E03
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752650950; cv=fail; b=J/aaTH5/O2jyd+7j2HKsb1t0H9V1KcC297FE1orvPQKUyQ9iYIHROMod+qrO/C3wTfV7htLn1dnLPqfDG8KlQ637XtLWJmF7tuqKhhr+RIWwDvh3qeUp913jrBkM6GhQmrm/egi1W4vy4THlL2k6pMTVVCSfma5T7Bf2lQao71c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752650950; c=relaxed/simple;
	bh=abbKNmJ6UXPteGqrgzmwuLdl+xn9LInGHxdkGMPh9SQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzVNuczgqYpM1sZ0jhvLgyLtFPTx4yNS3ljkgxXJe0jPTaV6LzlMLc1+CXfc07ZXRESVU/WqtWyg+d+dmhlSCX0WgzTYupcOWeYFWkXXU8h0rDdodkIEBc1zNlyCfy7fLbrZNxyT4h/5D+iQkBDGzDmj3vT2KvXaOfwqZ3amQvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dmUH7+jm; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcmdhAA1yuQVk7NCGpfhYGhfUD1w+oytR20PkpOusmZXVv4U0qXBs7KrIUCtWSLjX63m+RI5YUP9PZjO5qqpxkmn7NmlGE5nwonOifNq7llE+56B3p6UD8QYSGiEqMfuPpN2tUYL0KwbNplGWhPUOuHgdg/OhzHdUYEUyo15Lnv6E82ozrECNz2HxOwEbHjSr0qcXPUoMNOhNMZqCmJ4yz/Nv3YvQXfO/PwjRCqzBt4KUjE8tte46D0xkf77D3x8WuD7QoQtk/vBrcJKyvWc0QUe3s5X5iUWSkfmzrHJQc3I/4tuln6qPiBeY2JzoF5j3oLc4lYdZ/fbj5JEEvTBhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g6TB1yg17BK6jD9r/M/2/w8p1AtQLnVX1WD0Uzkffg=;
 b=tgjjabuZewwDy0TmwR1Lv2a+vs+c/5+cMdRxv+EyIkwWPP31cJ7yPrRJn0R8eworRJX7urWnBFxW7YVSMFI0GzhGjbaHXQHZYc3bNJ4jyO+19DehsuHGJDxk97rUSwDbeydY3cGJDikQX81POB8Ba74CxAZz346vWTo9OK8rUjXrFqGSve3vtuZ/QsP4ZEickOecq4p8zpFB55d77xuE3GPTY//fyu5ulH4XxB+Td5/qCeAmul8c9fmXv4rnOTlV+w451cHHEeY0XIxZjKzjQkEcsuzlFP4zxbkpBcFxVejC7EqQLdA143f72N6uFdxXIUtpouNGmJQ0SI1rr8ukZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g6TB1yg17BK6jD9r/M/2/w8p1AtQLnVX1WD0Uzkffg=;
 b=dmUH7+jmmFCEU6Uxws+p6ANRWz/DRZBeqlbDbjcAVgFA0vD/BqjH3U/qeVzv+Dl8EB3tONnDds/u1Jg+RSzozf2bDq+6qZ+mqypKXSskScnk0ydxFhfpif3lwobO5sE/rIF69LAk/ChuNjmRo8zgNRooQNjB+yK8RZse7/HSFubPdxV13SpRKXGPjDWux9S4UBynYBJbCsPm6sSc2oCiMwAOITK5rqb6ThNedxIrccl/iWow9llhqQBHpxWvoFpv9QwRU24EW00Cc4NG57ivHr2ygA5HGUfzJbqFI6l+boTm5kst7pyT7DSHRojywtV767ykZ7xCtnAadyzzAOET0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DM4PR12MB6134.namprd12.prod.outlook.com (2603:10b6:8:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 07:29:06 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 07:29:06 +0000
Message-ID: <d1b673c0-f2be-49e6-bd0b-80e6518e6a6e@nvidia.com>
Date: Wed, 16 Jul 2025 10:28:59 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 10/11] ethtool: rss: support setting flow
 hashing fields
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com, jdamato@fastly.com, andrew@lunn.ch
References: <20250716000331.1378807-1-kuba@kernel.org>
 <20250716000331.1378807-11-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250716000331.1378807-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0025.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::20) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DM4PR12MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a1e677-aeff-4c39-fc10-08ddc43a7221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXh6VS85SVBQVjlIaW9RaU4xNzYxOGEyQ1ZQdFMvTHBtTlROdXJkYktrajJV?=
 =?utf-8?B?cmYxWXgwY3NZdDBpOVpGUVQ0aXRyclRJV0Vad3grSmc1ZkpJeStPeGdWK09r?=
 =?utf-8?B?NGllcXFCQTQ5bVB0UU1mc3J3eG51UW0zMDdRTk1XQUtUT3lSeUVRRjFya3N2?=
 =?utf-8?B?TmxDdmpkVm5rcWtXWVZnOGptR2VBQ0lKUTBTYkxNVTdJUzUrVlFjM0hKZUtK?=
 =?utf-8?B?c1p0c0lNMkRFODBnQXUxZmUxMWVRa1BjWHBDQUVaM3E5cmI3WDFEUFh0QUkv?=
 =?utf-8?B?Rm9FUitjcmZIbzlRQ2tBRXAwZVJLdjQzTkZlSkN1RThlenRiejJxNE1PY1R4?=
 =?utf-8?B?ZXdpOWJKdDlNMVFSYmFHWHJhWkVkNVpYaXVBL2xNLy93SkdWNDBhcVhmSDZB?=
 =?utf-8?B?Wm81YzBxMG04WUJjVEROelZ2MGV2eTNNeEk0dlFQR3hMRWlSSldlMXJOUEkx?=
 =?utf-8?B?RGhtRGthZmdxazY0SGp6d1NzejNaUFd0aEVlMm5wK3NvQ0NkTzNTbXRPcnRw?=
 =?utf-8?B?dTFHZmNqN3BXUnJqSXFtbkxDUDBKcTFIYit3d1JhbFBDOFgzS09kSjJ2azl5?=
 =?utf-8?B?dGJJbGVyVXo3d1RjZkZ0T2FzQnR0MUZBZ29FSXdpNlJYVXIwWUcybTV5Rmxp?=
 =?utf-8?B?WURrMDJDK2ZaZE5vOEdjSHpjek1sckJuS2Q0ZHZEUTNQTU5nWFBzeE9TY085?=
 =?utf-8?B?TDZtYmRGL0ZSWTVJOFNFdkkrUkxJd05iMTVMYkJLd29yMDNqZS93Qnc3d0hC?=
 =?utf-8?B?YVJHVGhBMlRLbVA0bC9meTFQb0Vyb1I1b0N2K1Y0Qkp1dXN5ekRtV1JqYlhX?=
 =?utf-8?B?MWYxR2xvdjdsYlJ5aXIvODNxVEV4aWp1cGFTVGFuWllhQ2tSckl3czJqWGp4?=
 =?utf-8?B?Q2RUM1VLTU9WT0NpVHhvVUlSa1RobkZRcXhiK2xPQ1lOU25ZYTZBcVRQTUlK?=
 =?utf-8?B?TFplK0xwQWMyZ1Z5R3dTTGVmN2F1OHZTUlNEc1JHMEY0dk9YMktrODE2T0ZU?=
 =?utf-8?B?T0IxV002RllKVUplMXNXMDBpc2U1U3hKeDhQQitHMkJ1R2huMk12LzhsWjBY?=
 =?utf-8?B?UkZFdVZSM1ArM2RjTDNmaUk1ZFB6bGdIcEl5Tll5cTUrU0hHL2ZyZFhXb3BZ?=
 =?utf-8?B?WW9WazZybzVYNzhtZjg5WjNXVkJTaXVUTWJtZGVHRHVxSnRVWmIrSTVRbXI4?=
 =?utf-8?B?YVVSV2x2LzFYOXpRSml0MDZGTTZXalVrNy9VOUZOMU9WVUN2NDN6V3dJNnN0?=
 =?utf-8?B?V0xOanZpcXFXK3dQNnp4eVZETkNzSU9pdU9zVzF4YUNsay9WYVZCbzR3NDRV?=
 =?utf-8?B?YkErUVdsaklEVnczbFk1d2N1K2hJL1NlUjl0MExzNjFjdU1YZFd5TUdGRE1k?=
 =?utf-8?B?VHUvTjlTYnFNTlRYUG8xQ3R0R0hOaWFRVzJSR3JveU1ScnNKVENqaVhSRjhj?=
 =?utf-8?B?UXBUanQvN3A5bStsRDJDMCtzcFRYbFBTcHptYUlVNWR3NGx5UHRmOVZmT1FT?=
 =?utf-8?B?QzJTQ0JWQUlWOUp3UEN3MmkzcGlXcUZKbmJjSWFSYm50V3RHZEp1TWtEZzZz?=
 =?utf-8?B?eG81emxYaGZOeG83YThBcUZnRTV4NHNGeC93Nm50aStVR29ESzNWSlpEekx4?=
 =?utf-8?B?YzEwV0treU5NRi84RllSMWpYZ0N2ckVzQXdXSzB5Ym9pZVFOQlJBM0lSYzNw?=
 =?utf-8?B?djdEN2FvV0tyam54Y3JKTzREYXNaRmlxNW0rZU5iN05xb0lRZ3RHTk9wcnh6?=
 =?utf-8?B?RzMzUGlxWjZoaUpCc005bENMdmtHTlpzMzlzV0lnOWx6QU83RG9oT0lZSzk0?=
 =?utf-8?B?WG56S2ZnVUVwTlZ0aTlzVWVYZFVQUExIN05ESUJPQ3VWSkhDQVBVVW1FaHZm?=
 =?utf-8?B?OG45a0xkSTFkTDZVazFYOUVJRko4dmVBTjdMa3dpWUgxc3hlYTNyWGhvV2RK?=
 =?utf-8?Q?hC9NejymZlY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnBScFZsUHhrSUFWOHphMkRwSVQxalB2cG4rckFxaUdaQXl2NlFmYkJWR2VV?=
 =?utf-8?B?Q0Y0ejhtN0pUWVArdEZEd1hZQUo4U1Rud0xwR3RYV2xnM0RvTGszUlp1c01r?=
 =?utf-8?B?aUxOZk80TWpYSEg1NmhpVVVVUXM2M0ttRmp3MUxMSDZSNjEwNVA5WFo1Q0FR?=
 =?utf-8?B?ZytORm1pNmhJT3RMMmY1NmF3NExZOWtITmlrSWd4YktyT2VFV2pIVXYyRm5z?=
 =?utf-8?B?VENnVHlNUzZ5N3Njb1IxcVA2MklBMVdXRTRSem9xdnhtWC9qZkMwS1BYbjRC?=
 =?utf-8?B?d2w0bTZhT0JEdHA4L3plVVNvWm4yTnFTTzZyaWRidHpMQWJYRGtzK1hjN1c3?=
 =?utf-8?B?cnorYTdYU3ZsOFdVeVFyd2xweGRZMEhXV2tKdmNDbnUvK2V0VkVPbms0N3g5?=
 =?utf-8?B?NWgyNExqRWJKdy9iVDh0VG45UGd6OTVLTjNUeDNGZGRwZmtmUXhkVFFHdTRF?=
 =?utf-8?B?cjdGdGdMcmtaZ0d1QmxlRzA5ZFBCYnU5Tm1laG1EczcvRGY5cVpuenZyNUNM?=
 =?utf-8?B?dXJhc2tBRkpMRzFXUisxOHhyVkV1R2NwOE5oVERSdW1HMzNiODExeEwvVU5p?=
 =?utf-8?B?UmVRdXFhd2Q2UmhtZm5UWmQ0RzRsdGZqNTBTRE9yM1hEQXU1QURiejB1VG96?=
 =?utf-8?B?bmFzZHZRQ0lhb0s3Nk9nVGdRZ2xmY0NIZ2RkNURiZFNCYm5uUnh1VWRHV3pj?=
 =?utf-8?B?Ym5oV24rV1Q4Y29yaE9RODNaMDJSU1JkL3lEWHdEUGRGU0dCeVRzbXZTdi8v?=
 =?utf-8?B?ZWVmSStzVVp0Z3RzanJuYzZSa0FnZldBQzRYUHdRVjgxdWdGbDVaUnFCdXhj?=
 =?utf-8?B?bW45NERkbHpuZEZITFN4Y3BTcExtNmxqS3UzclFqd1UvSGlOZW1OVUZCRDJi?=
 =?utf-8?B?T1RjL0VlbnVBRHJBOTlIcDI0cFV5SzFFUEtYRURhbS8zWGZDcWRJQnNYTU04?=
 =?utf-8?B?cVZ5Z3JnTE5nNFphV2xNZE5tYlJRRllsd2x1TmtxMk1nVXJhYnFvYSsveUZ0?=
 =?utf-8?B?Sk1mclJDcFlWKzN2QmQ3TGtzUkN5WVNVV0lVUXhBMFk0dGdNNzRmKzFOUEMw?=
 =?utf-8?B?cEhEUWN1M3VGaUZsRDI3MVcrUjZpbGppUGYwVmwvOGRycmxnaHN2T2hiMTNp?=
 =?utf-8?B?Z0ZYaitIQ1ZYdk8vVWxzcEYvdnZ5MnlzcDB6blM4WDNwQzhSZWVrTkJsMVM3?=
 =?utf-8?B?NFZRemxqdVB5bWg0SU8rL2xJZkFoSW9tUHlJWGx6MGY5NjdWYVdFaG9nT2Jj?=
 =?utf-8?B?NzlSRnBzT25DT0x0U2hERXhpVnQ4SXF1VDU0ME9PaERlOTQ0VVBlU0F1aHNn?=
 =?utf-8?B?MFdvd3FadzM0Y3hZM3J3WEpCZkYrTlF1K3BSbnVGOFpGdFFWSUdua3hDSTNJ?=
 =?utf-8?B?YlJHc0UxdnNTR21mSElyTkZGcDdoR1VWREJHOHJBU3lBZnpJMU45V2tzeGFF?=
 =?utf-8?B?Q1drb0NnRHBtOWRTU1BVVnloa00xYStzL1l5dnZqZ3o4WE40Vld6NklzV0JN?=
 =?utf-8?B?cXA1bjdxcXFhbzM5WjA3dURXWDcxQ3ZuSzF5cmJiNHN2aDU2V0dpckVGOHhx?=
 =?utf-8?B?eFdiaEhkR3dqQ1ZMbFJISzVGUU9VdDJGMXpJczBJMkpIZ3lEUklCQlBMQTdC?=
 =?utf-8?B?bkxpMVNlSmMvNFBEbFRhWjE2UStrYXhTTFRRUHgzSG8zLzdwQU1Jdi9pU3hq?=
 =?utf-8?B?bWdJK29IbThSR2hVNThzTzRNSVB3NHFhVDR1OUFyRkdPdTZHcjkyRTViNWR5?=
 =?utf-8?B?VE5STHN4MkZodnJyNzF1M2tjc051a1pGQXdLYVN3QjNIa1pFTG90ZUhneUFk?=
 =?utf-8?B?dkJlSHF1RlBydE91WHRMSGJOczVCOEVobmxOeHQzRStaS3BEa3JyTDBldVA4?=
 =?utf-8?B?SDkrRHhaaGczZTNkV1cvVW1IRS8rTWE4d0VKU2ZvMnE1ZHB4Qm82TE4vYktk?=
 =?utf-8?B?L2N6RWxsd255R0JxZ1RkK1k1VHR6bE9NY1UwZ05uRzZDMnhUYkZ5WkhlL3ZG?=
 =?utf-8?B?NWRma2VjZENoYTVnQmVXeWQxeWRUcnFJY0VCaXYwbEZMblR2VTZPekJTRThJ?=
 =?utf-8?B?bFgzc1VGRGJlZnptM0xYVm1RdFlMWHJtNVVoV3lreGxuOXpEaDNScXpRbUVU?=
 =?utf-8?Q?Rmvc9frR2kzkIC3ogA9a9hqCd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a1e677-aeff-4c39-fc10-08ddc43a7221
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 07:29:06.1786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2i1Ijc+fu1iKAb56asOwHjbQguHIWy+Ft37ShFsP6nDPDnDYoK1afUb39U3w2DWI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6134

On 16/07/2025 3:03, Jakub Kicinski wrote:
> Add support for ETHTOOL_SRXFH (setting hashing fields) in RSS_SET.
> 
> The tricky part is dealing with symmetric hashing. In netlink user
> can change the hashing fields and symmetric hash in one request,
> in IOCTL the two used to be set via different uAPI requests.
> Since fields and hash function config are still separate driver
> callbacks - changes to the two are not atomic. Keep things simple
> and validate the settings against both pre- and post- change ones.
> Meaning that we will reject the config request if user tries
> to correct the flow fields and set input_xfrm in one request,
> or disables input_xfrm and makes flow fields non-symmetric.
> 
> We can adjust it later if there's a real need. Starting simple feels
> right, and potentially partially applying the settings isn't nice,
> either.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Gal Pressman <gal@nvidia.com>

