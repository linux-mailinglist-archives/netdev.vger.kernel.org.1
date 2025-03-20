Return-Path: <netdev+bounces-176408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3999A6A1A8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119A51891857
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300521481B;
	Thu, 20 Mar 2025 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TKa+pj+d"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C21519BE
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460251; cv=fail; b=tF6yVcpR1HucZrMzDit/vhYs5SRaKJBHkC3FIg8n3pWxQ7HQKcXICLfETblLO3hsg0gQ/aXzJq5VbMLqTpvmLmtao4rNcixEXEpIYZJfKGDlfBDwJ4z5rWPN/Rzz5T8SG70JRmZTVRMW1fIB6vwZXLfCB7m7nxE/FqHVLM6By4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460251; c=relaxed/simple;
	bh=7RzlZ1u/9i3RiYCwACUwRnWAeDSiwnYiO3HstpS7Yig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BTOJQ8n4T3aDRPkY/PBBC5uE0NTpI8z3x3XNvLRaO+2YoZypcO5fhsIDLZLmMdG/+/L1H4Z0UvWQBBta7CwukNZrdVh+WY4cPyM7ZnuzjvDyK+9kTg7G/TKf3l0gcCgHcnV7Z49XlxDSAN0HA/OCiL9zQUWVJwurqqpJFHrIpyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TKa+pj+d; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6uZWXbhQbduQedDaMQFPEYnrAKtfqlDpXWt/8pig7pxfIN1aNnTV8iJ71rqWsYspIhTs6dzTR0QeqaBTj5haRGGkuXAfoq25pg3BUZA2jK/0Bgg0uZiSDhCLaWiS23W3pSSnYPzU26+xv7vFZTFyfE1DtxKl4sw1uSIW4gS62vUCmSrbWPo7RAD4f6V0n7MCg/WITHTobwIC/E8dhS+Yqt5tVw81pj8372NnxuJvqEZNm5IE7EKElgIaeCB8jOI/DF75Rxlbvsr5rwT3o+h9Pf7iN/m4r8owaF/nYd7LeRD92iEHMTjCazEZh7v8k9lDqja5y7xIIWv22JuPB/Rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rFg9xf/oN+qjiFL6hokwFBaW+kfJZ9X0gruG7OBWM4=;
 b=KCl2d8AceYFBBdCJZiOGm2Dxl39dPjxvX9KYi9STtqlTbyGn7b1Neb2O0lJYCq6Si6HnbDGZl/QAOG5sPya/K7+k34vVXBWK+xnaaV8y5NZdFX3cKTYFK6Cy5irmJTuWNziBgVIdbhBCPYNT5Cn9OwJtZc9k45jxsB3746DDPUpYYZRGFgcW8O+Rk9hbOmZXqJJR8XxqhmbXN2M6yn2sZ4d20pzRny+AGyhX9BaSKh4eGrpK8qQusEgzRDSejiJqdm8hlxfZuBOdMB7ul/8Z96b6LBPeNiv4HUtD0ffedeTTaJawaMqVW9gFc91w+MJklYLf68oXhdOKmwofn9cYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rFg9xf/oN+qjiFL6hokwFBaW+kfJZ9X0gruG7OBWM4=;
 b=TKa+pj+dK86O6cqUjkskx+xJpQBrs0nkIwX9QhIGIVTYA0K4XoOOqZ+hVPCg4sfxFyvTfaID19G+uOuq5DaFk/B9j07dCVd9dB+hUHWUAg4ugaXa58hPuMZRUTthZUVNtIPMgm6Ggf2Nhl8joELE7JiCbTAss/t6NXYw3qtI6cnTG3paG7e5zOmVvNn6caaPWotlwcWtIoAb0thsgLPRU1TdmrbjhsF8Qxkm2EVF0yvlEH0+SISJU9Eqc2fX/AtCALG/3u3V7idbQgPV99IEFn+P54hGxZyKN35CxaXFUNfhKSn9cfL11v6wbDbuuGzq8zUACaoal8+6VEg8GB51nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:44:06 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:44:06 +0000
Message-ID: <fe4b2e7b-1704-426e-99e7-da55375b676d@nvidia.com>
Date: Thu, 20 Mar 2025 10:44:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5e: Fix ethtool -N flow-type ip4 to RSS
 context
To: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250319124508.3979818-1-maxim@isovalent.com>
 <fadfb5af-afdf-43c3-bc1b-58d5b1eb0d70@nvidia.com>
 <CAKErNvrbdaEom1LQZd6W+4M-Vjfg+YRzgEz3F7YWoCXB_U+dug@mail.gmail.com>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <CAKErNvrbdaEom1LQZd6W+4M-Vjfg+YRzgEz3F7YWoCXB_U+dug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00004531.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::35a) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c14cdb5-cfbe-4802-9cf0-08dd678b5f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdrYWE3TmJ6S2pteExWSUNBL0hSV3pyenZrdTFGaThjUmRNOVU1S0xCcFlD?=
 =?utf-8?B?Wkt4RnpYTGF2a2ltKzdEUXg2cGdWLzhhR2RvOXRHYk4xVFZyRWluWmlYTHhU?=
 =?utf-8?B?Y2FtUTJsNmM2M3ZtRVRJOG8vUGVFK2RpK1dsVDJqazlkTW1FMGtleDJJdVps?=
 =?utf-8?B?OHlqSXRjaGlTU1IwenRuUlFZV0wzTUFiQnYybW5pRmtsMW9odVc2aCtldkJL?=
 =?utf-8?B?UURJcHV2cmQ4bFZnM3BqSXpiaXB0OU4yM3YwQm82T2VRSFJTTXpiR1MxR1hF?=
 =?utf-8?B?dE9MeG96eG9pOUIzM0VmOCtsZkU5RW96MWNxVVprMUZzZUdzV3ErQ3ZaT2JC?=
 =?utf-8?B?Z3EyUTg4OThESnNxSVYzbDRhREFiZlI0dXBMdDNxNllzRjdjYnpRQTN5YUJZ?=
 =?utf-8?B?bWNmS29kOEVPUWFUUE5NaThMZkxZN3JkdmFMMklVeHE0c2pweGlmWW9OcERi?=
 =?utf-8?B?cUxDUSs1RDg4dDgxZFVKV3JHN0JaQytJWDMzQXB6VUlnVDQ5WWlIZHVKQ1NJ?=
 =?utf-8?B?QURrMUQ2UTF4bG1lNWxxaEZ2cm96a0ZUdmNSYkIzYVFVNUl2MnA0QWFZeExS?=
 =?utf-8?B?UnF5K1dIZytaYXlMMW1CMjk1dEs4YTR0R1BKSnlVUHRqK0VTeUg3dTY2RWxE?=
 =?utf-8?B?cUlDYk1Yd2RjUUJXSUV0citpQkwvSG9POUZha2V4STlISnltWDh3RjZVT3Ja?=
 =?utf-8?B?OER2aGJteFluclNIUFVxNzhMb3hCdmtyL3pROEMvUlYwM1dKeHFOcWpBT3F1?=
 =?utf-8?B?ZFNJbncybWQ4SkRMZ1Z1dUJ6S0Fxb1dpRk1XczBha2tYZkNGSWg5MGEzaEQ5?=
 =?utf-8?B?bVRNUE95cERVNmNhbDczaTQ1Mm5qWmRkRlhoNjZxOVFGc2UzMFlYdjN2dXhi?=
 =?utf-8?B?MmxjVXNMRmxxRmNqeTAxUGloVHZmdkdyQkxuYUkxMUFkYWJEaUJtR1VZNEgx?=
 =?utf-8?B?UHV1RGpWbzllVmFRYVdSdzBMaitnUHYySy9LWm51Y0F2bEVLbUhlNWkzN1hX?=
 =?utf-8?B?Q3FVaHpDRTlYVzNreHNLL2hFM2RTbGl2VGFLR2RLaVFvVlBPVGt6WUZINnIz?=
 =?utf-8?B?SDU5SklTTDJEMjU3SGR6S2ZBeTQ4cnVpWFRoZkYvQldNcWpoMStGY2FSbERU?=
 =?utf-8?B?cUFqOFlEVXExNW9EM0xWTlB6ZHBSZ0Q3Vm1WSmhMTmtLUHNBRjZuVjJCK0I1?=
 =?utf-8?B?S25mbHcxbjVPU0JieFFRKzIxS1pkRDY0WFVhNUIwelA4RFZzZVQxeXlIeElS?=
 =?utf-8?B?Skt6N051RDNPakRsMzl1U0s2YTRWUUpPVDZxQ3hEN2wyMkl0ZWFrQUJQb0M4?=
 =?utf-8?B?RHRuOUJvUytXWVFlaDg3NmFMV0UxdlppYUR6cUZLSXVhN0hEb1l2dFJiL082?=
 =?utf-8?B?a2xiMEpqTWJPMHdRR2FVMWJrNUlXdmI2Vm1mQzc1L056Ui9TeGxrOUNFYnJm?=
 =?utf-8?B?NW5rUytjOGt4eHFQa2pLdUt6dXRSMWhReWNjZWpueVdBSWVocXRibEJlaWQr?=
 =?utf-8?B?bDJMc1pySHpONWZXR1E0NUtLdGRvZGFYdFBmdkhNMHUvV0YyMDV3MTJyM1Nx?=
 =?utf-8?B?eXkzS0FTYjlPYStDUFJXZTZTUEdmODhtKzdndDhZem1uY0wzdElJdmFWeGZH?=
 =?utf-8?B?K3FZQjBscENOZkQrYmtDRlVYMXpoUU0zaEIxcDc4RUg5S1p5UVUwRGlVbU9C?=
 =?utf-8?B?VHk2bmpuUkd6akE1OThIMVY1L1B2QXJVWmJoUlVMSGFjSkNuMy9hUUhRRG9x?=
 =?utf-8?B?Q28wUHoyWXMzWm9LVzl0WjQ3WXZYZVFzR1ZaZzk3SjdsWmpuZEYrNWtVV0ZD?=
 =?utf-8?B?aytZSCtlalBuaHhrRnhFOWlsTGR6M3NrRHF0b1Rhd2x3Uzlqdklic2NUZkQ5?=
 =?utf-8?Q?WzHSl0fEsr/Eo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTBpVnptRUg1Y1FEbmljNktQd1VCS3VrRnBacEVtUXMxRGJscUIxbC9DZ2gy?=
 =?utf-8?B?QUw0S0htNjNYNGVodmlyT0ZBTlpvS0dRRnVqUlVaZjhtQkxKSW1VWTFhczJn?=
 =?utf-8?B?UVpmMkIxc3Z6dEJ2R2wrc3hoM0VjRnZRVEtReWdtSW5POW5ZREpnWERxTjFN?=
 =?utf-8?B?YXhNZFVVZmRXN3VWVlRvNmZlVmo0SXM4LzlIc1hEOFF2YUE0dDJjZHhlS3Bm?=
 =?utf-8?B?bWlsSVF1UkRRU2Z6RWtvckZsYWhUR3hKWklQR1Axck9zRk9lYUdiOUw5TXNJ?=
 =?utf-8?B?THk5enRFQWkrRFdJNDhWeFhvZThvT3BPcFgxOFB0UFdDZ0pleVVSa0hmUVhE?=
 =?utf-8?B?Tkl1K1hVdkJ0Wmcvc1VkeEZkR2V1SFRXVkpYQmFOc2NWTTFIZUZWQjVNQ3hW?=
 =?utf-8?B?bDM3eVB3M1NzTk4zWWFwdWhQS21XaWtVRW96SjQwdzE4dXUrUGFGTytkeVlh?=
 =?utf-8?B?TkVxRmVTbnN0VGNwZE5jRWd5V2xUYWZ6SnB0SU4rcC8zZVdmb25CcFZLVkY3?=
 =?utf-8?B?cXAyZW5oMWdOQWkvdW53cTFod1dBK0J3L1lndC94MUl6TFZEVkxDYmZpdVJu?=
 =?utf-8?B?eEZJR0h6WFVGc3R3U1orOC9hdFJja0Z3aHFpc1RKalZabXZUci9lNnFrcUYy?=
 =?utf-8?B?S3ZyNGw5WmZDRWg5M3pFZHg5UERXeDVYbHVOYVVELzFlc056YTUvZGtWYXdt?=
 =?utf-8?B?cGJEU3BOcnpNS1lYVDQ5R3dYamNqd2J5V0dOajJnN1FOZ1QxWHFwZkc0cllt?=
 =?utf-8?B?K2E0WWUwS1BZdXN1cGFVcDcxOVY3dmtUVERKaHVFTm13dTFkSlpZMTNaZ1la?=
 =?utf-8?B?UFgraEREZ0RhNXBGL0RTY2pjdVVGUFdKdnB1SHZscndOaWtNU1J6b1prK1dW?=
 =?utf-8?B?WXhBclRYM3d6TTFwNFlFL0dKVXRaY2JGUmVHTzFmSC9Hd0pxa1puN3I0QnZW?=
 =?utf-8?B?bVdnM0dQY1VQdk95UmJ0d3JWMkVwUEJQeWhQRWY0L0FQZ3hZWTVONzJzZXNP?=
 =?utf-8?B?emdOa1JrM041eVFJUmZjNGVPQjFqMUMrVFhhOGdyejNTbzV1SlNqZkQ5bmxs?=
 =?utf-8?B?dGZsdUpMSnhDaUdqbjRQNk1UemlyV3dLZGEzdWRaSkdBTkdIY2hqZTNXaEo3?=
 =?utf-8?B?UDlubGRId1VzU2wzVndIWm1TSTNCdExjZXp5aFAxZ3YzMy9PZWlkaC9hSXEr?=
 =?utf-8?B?NlBWc1BwYmNDY2ZScVhxejdqamN2VXlnUDZISE1yZGJxSlFFSUlWV1gzMmF6?=
 =?utf-8?B?bjF2d2xqMTQ1MGtCNFRUZ3FhUThZc25mVUFMVG5hZ0d5bWdDQjAvWFcxSC9D?=
 =?utf-8?B?dmcvTFIyS0JQWm9VU3JjQkIxV2JkaXdVNGRNUVE5RWpXTmljOEt0WFNiWnFM?=
 =?utf-8?B?RVh5NHNRalc5NXJKSWI3aDJoR0FsSThqSzBIdDRRcndFTmJRRGNBODFVY3F6?=
 =?utf-8?B?ZjdYbjR2eEJjdjNzMTJzT1Vwem9ZWDJpTzdLRjh2SHE4dEovUzZiaUJWZElG?=
 =?utf-8?B?Tm5SZmwzZHVuWXJXTGR1RHFCU2tCeUY1d1pYQXJpUG1ha09tZG1HOStBS0d4?=
 =?utf-8?B?QUFjUFpiT0RTeTVhOENZQXhSYWFGam93T1o1WHg1aHBLNy9lUkgwQlNqODNW?=
 =?utf-8?B?UnlTdE9tR2lyenpSUHJIQU0rNkpQYjBGVmVFRlRWU3lBVlZxS09QdjNuWjQ5?=
 =?utf-8?B?SlBxR1VRNU9GdzN2Mlo1VEcrWFV6S1dHSld1WGh5TXc1aGhSbXI3U1JjZ2Ux?=
 =?utf-8?B?Tk5NQ1BZeE5QTEIyM25oa1N6UWhtS3hUWWI5UmVCcFFURzlqYUg1RzVtQlNT?=
 =?utf-8?B?TEVKOXNCNVpISnY2NTFubGhHSXhQR01WUEdxeFZERU1QQmlCa2hXWFhZQTVu?=
 =?utf-8?B?QzREVDRLc1dtM3B5Ym1lWTRaUmFnYlk2L1dxREpmWkZsbXZmaXdwTVFQNmpN?=
 =?utf-8?B?Ry8yQ1VUREI5R2ZuTlhwMFJBeENXQXRFeitRajJIb0RBRy9QYjdRY3IvNlMy?=
 =?utf-8?B?SG9RWld1TmJWMDBKZ2VrTGJmRkRIdEhmQUFzVitjWkFFVG5jbTBpS3ROR0Yr?=
 =?utf-8?B?bE1sZHpnUXNYdWt3WGt1dmJQelk3ZnIrWU9XWndmQkk3N3VyMEFEMTNQcG1i?=
 =?utf-8?Q?Ltx2FkfWFG+tKzrlwWwNNSWjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c14cdb5-cfbe-4802-9cf0-08dd678b5f9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:44:06.1318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD5oc2MvGImcgXmonVXvlON3hBRSebteGBYvGpZIvf3PrySO3hGjhBc63wMLVhq3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606

On 20/03/2025 10:28, Maxim Mikityanskiy wrote:
> On Thu, 20 Mar 2025 at 10:25, Gal Pressman <gal@nvidia.com> wrote:
>>
>> Hey Maxim!
>>
>> On 19/03/2025 14:45, Maxim Mikityanskiy wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>> index 773624bb2c5d..d68230a7b9f4 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
>>> @@ -884,8 +884,10 @@ static int flow_type_to_traffic_type(u32 flow_type)
>>>       case ESP_V6_FLOW:
>>>               return MLX5_TT_IPV6_IPSEC_ESP;
>>>       case IPV4_FLOW:
>>> +     case IP_USER_FLOW:
>>
>> They're the same, but I think IPV4_USER_FLOW is the "modern" define that
>> should be used.
> 
> Yeah, I used IP_USER_FLOW for consistency with other places in this
> file. If you prefer that, I can resubmit with IPV4_USER_FLOW.

I don't mind, up to Tariq.
We can followup with a patch that converts all usages.

