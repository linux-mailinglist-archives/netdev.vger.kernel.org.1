Return-Path: <netdev+bounces-251785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIDkBIJ8cGktYAAAu9opvQ
	(envelope-from <netdev+bounces-251785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:13:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3CE52A70
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20EC94E3A10
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470B44D00E;
	Wed, 21 Jan 2026 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g8i79Y5w"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930144CACE;
	Wed, 21 Jan 2026 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768979515; cv=fail; b=SJ9tphBtrHAM2rFBC9/f9F+y+lm2hFrL6sXEIOwX+dLrh3/WElhjgXpRK3DjQ1TbYhHh8CsOJeN+gAh50QeNFwz2ZTsxLq0HL2CC3TL9S5d/uE7jYKg3IJQpxwXhP497gdxLYM4vaI4E9YgspBEj+XRnrkky2/XNUo9iMAqyGXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768979515; c=relaxed/simple;
	bh=4zf/wIqxz5OWzyRtKPoVMnevx7RcfpxdTlVO9k8ELIc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mKj5Zyz7jt+F0gBOjaIyC4nbnclMWjW0HWlghVU8ABRsm9QkYqOAVBiG0GHfA4z1GAhu/uwoDOVWHalCiOZbmeOAAfYywJWVyftwA0S959h1AN9D2JFVhgA7I2WX91w9e/hu7ATbpM5OMP+Z6XsYmEV6x9gA2yDY5QMPYVdh+aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g8i79Y5w; arc=fail smtp.client-ip=40.107.209.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEu1lmKtrbSFOZaxu4E2r0zx6ix4RhP+1h60uwqdzqlSdUrY80lLfhxsHve7ixWs3VDesvUOWpqW7v7r872jfPlKTQySp1+Wt36yTvXGvelGe9hHKIA6UzyICBgnilv8B6YZYCLay3kJmdLCfNBV5gdrLk+ADiaKa63IXCpmVz8H64XJlqSMInZwDrEpjkL1izHfGwTwWGBoPzoUQL/vGBC/I7/XuxaiZKNlKP6G9Xcq0QVCS20SQcpnNsUZRPfE5zj+WwBCcasqhy688k2lu8fQsqWul+lyDND17z12I7IBUY8XTXSKexgUyScVnzBdmHq8lJtc8gyZHeNG3AzBdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWXjzasG5TD3GCKIgxnyxnRwXAa216TVufqEHMnj2es=;
 b=aKPe0MBrbT9gaOi+UyCIQ9dkhwqJpkJPM2xEXZsjSmnFZo7nYHf+5bpQw6fzCXFNoIYy4nUMD6Af98j9wSmbnrQGbvfOLaWmyzVXroLNnGmTH+Uwv251GhD7FjXIDWLf4nwNRic2/aPuZ4JJSHGSkEfXXZP0fACbPK6y9hzDEK80U2tbtYpfXFiOU1M3R73OcMTBZ+40o10Lwsh8ZviSGJDEjYoZe/XD3t/RFo1W23rMtvvPUSs18lK1Kz2pWzamYlQUe2zacZiF8N2SNa8ZyyiQRrRAEkmjRcsHCLX0QiZ7IxudR2vDaI0ITCP18C7kWmw74cPIFeQo5U0iQ1uo3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWXjzasG5TD3GCKIgxnyxnRwXAa216TVufqEHMnj2es=;
 b=g8i79Y5wqDZGaYqbzgfAwyIdQgwU2OJVOYwIqNChnr4NnCNHVBcv1FENlUtCSjs4FRxMQCGGlB3VFADuwdD0fVw9cHpvCGGAv732RsruWIzLC0/IWT3UaxgPCUqeyKWBZvfQsCCe2irTNMq7j0iIO2+wJvBXZ5SrmFBQ3JVjHJDeoZm2i+l7c9gsRxbdx1szsJWJIeBNkZdonDfQWwe1XigmRJQM1eDVRd3NdOsgFyHHT26xwiUnqJOD+H+g5LIsziEQ1UNbVhep+x8CUxCtOodX48evg6Dp7hF1Pa75bJrCjrPbzLsscJyonQKWr4TaLl5Xu3VVFSYfeMR8/5Wa6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.9; Wed, 21 Jan 2026 07:11:47 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%4]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 07:11:47 +0000
Message-ID: <94e91bcc-6257-4edd-bc61-eabbfd547110@nvidia.com>
Date: Wed, 21 Jan 2026 09:11:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: net: fix wrong boolean evaluation in
 __exit__
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Joe Damato <joe@dama.to>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kselftest@vger.kernel.org, Nimrod Oren <noren@nvidia.com>
References: <20260120124733.604590-1-gal@nvidia.com>
 <20260120154413.6fe90947@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260120154413.6fe90947@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To PH0PR12MB7012.namprd12.prod.outlook.com
 (2603:10b6:510:21c::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a721b3a-2e7d-4f2f-afcf-08de58bc567e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzBzbkdqZUFndmp5T1BCSHE2OTdVaXNmVUU2YVQrQlpNTGUrVDQ1VVp2djRD?=
 =?utf-8?B?SFExSCtVNHVDYlhoa05XeklRTW43U0FNQTdRb295SjF3L0h3RzFTN1p0Sm5U?=
 =?utf-8?B?TUFELzdCbmFNQ1R6SXMwMHNhZExzeVo1OFBuMW9RZlFmUnA1NUc2N0JWbmRQ?=
 =?utf-8?B?anJiWTh1UFJrZnlTRlFTOVE0MHp5cE9QaHN3cUJYTFRwVGV4TDJTQnd1aGdE?=
 =?utf-8?B?QytBUWUvUi94N29QUmczcmQ0ZEJvbDA2Q2p6Y2hFcnVvejNvMnJ0U2cyM2Qz?=
 =?utf-8?B?RFZUbThpV3lBbUhsbitDaWl5cG9kSFBmWGNMU2RUV281V3pwOVdRbis2bGdJ?=
 =?utf-8?B?WHVyNjNIRlpLU2Z5UzV2a0pydk1SUWFwcFZLdWhMTjcwaXhzZ1RsdFhsRFA0?=
 =?utf-8?B?SUdxMWZ6UnFMdHkzVzlHZlFIbVYzM1NJZWNNOXZLdW1sVWpWWHpxRHF0QlNp?=
 =?utf-8?B?M3crSE42N2dYWHZkbUhJREp6VldnbHRRQy9WSTRwS09meVV4SHRWY0ZyZ2Zh?=
 =?utf-8?B?cThiZzF3RFI5QmJuajMvWnlnMk5FcVI3cGcvQlpEZ3NYbVk0cEFYOE1OQjVp?=
 =?utf-8?B?N2w1NmI4eVgvM0VyZWdIYk04TUdrS0xmNEZENlpzQnl6OFdUbFV4RkJjUzhq?=
 =?utf-8?B?ektWb2tBZ3lHWHAzZFRKT2QzODNTTnlxcnJsMStQVm40Z3JDbDRSeUJqd2RB?=
 =?utf-8?B?WVR3K09LNGVrNTdPQlVFT1k2UkhLckJhaklBQmdxb1VRZDcvZUFDL2xUUEtv?=
 =?utf-8?B?dFEzZFRqM0dOSVRsSWlDOGsvWThnTE56QW96elBxMU94azE5L1BhRmxFdzAx?=
 =?utf-8?B?NGxJQ3FUYVFqcTVmZVNLb0Jwanc1Y3I0MVR4TlYrWnA4cnBTQTJSQ09FY1ZZ?=
 =?utf-8?B?MWxSUFlBNExaZnM3S05GTUNGb1NHRXQ4bm9MWDZxT05kRkY1anBwNTNTQ2pL?=
 =?utf-8?B?SG5jckJFYk1PQTUzYjE4dm04SHRBSDVzeTVmekxTWW9mN2J4YzdpUCt4YU5R?=
 =?utf-8?B?SjRvM1lnVGlKRjJuWmpnZ3JDaHB3dUhYelQxVUtHZkFUZkdoNExnek13RXRS?=
 =?utf-8?B?RlM0V3JxemdFNng0MXVqMjNCUmtMaDVOKzViVi81NmE1VVFnVThKeW9acnBN?=
 =?utf-8?B?dE1DQytDTHJmT0JVNXNNZDR4Rkk2YmRKcUxPKzdqdm92YmZyNUZwcWc2ZHVT?=
 =?utf-8?B?Y2FZNEcva0gybi9ldWg5NGFaNjNud2IvV1FMTEFpOGh4Uno0Mk5CTjAxSk1K?=
 =?utf-8?B?U000V1lrQUlOdDgza0Z0UnNqSW9uekg4YkpvOGVicVZXWm5YQlVJSWRLNDdx?=
 =?utf-8?B?VUJjdlllOElzS1lrT0Rod3JqU1RJSjRLV0h2VExhclBKbHZ0eHlXMnEwYjM0?=
 =?utf-8?B?bi95T2wxUzhQNEpxcUlVMklNTzA1NU1FVm50T3hhbHNkSXRCMXo4azdpWEdW?=
 =?utf-8?B?RitwWUx1RGJpd21oREVDOFk4RlpvWnBJd29jaUlCWlBZYWtnZkdjczByVkJV?=
 =?utf-8?B?N25XSkNuQTdIZUZ6TDVWT3FScU9RWTl3U3ZtOS9uMXlKRzlKYXM4ZmMwWFF4?=
 =?utf-8?B?SnhhZE9lbVY1K3lxUzgvWXRpSkMvTjNuSjV5NmhoN08yVzRuY29jK3hRTFlF?=
 =?utf-8?B?QzVmYmxFTFB3TVcrdUowdWNZNGV5dG1vZTdsdmdLZnhGVy93ajI4MTRnbzJj?=
 =?utf-8?B?emNUS1NHczk1NHpROG0wUGp6MjY1Qk9QN3BtdWdHcVdZOHBacjY3ZkROaEx2?=
 =?utf-8?B?TnRaNE5qZjlodmNuVUhrSlMzZkwzOUtodWpvdk10T3lQdW8xZy9LaXVyS2NC?=
 =?utf-8?B?TExEM0kyRnRDQWF0VXY2SmxLNmNJZVZFL3pveG4xU0FzdDlyNlBUekZ4cFEv?=
 =?utf-8?B?cEtYZEU4VUlvS0hnd0FhcTI1aWpQVisvNnBKclV0OEpNZ0NpcTI3V3hGK1h1?=
 =?utf-8?B?cTdHRm85QmZtTEVITlRsT29OVXc1RzlZbTBhSEF5N2RkK0VzMER0c1krM1Vr?=
 =?utf-8?B?SmtmVWVTdmJidnJqcTYyZDVrREtEY0U0a1pUMElMeGVhczdETURKQUdCMG5x?=
 =?utf-8?B?bWhwa3NVMXlHbmNEamtKTk9BUk9jSUlZcEpOYXZxR3N0NWFSZk01b1NybHlU?=
 =?utf-8?Q?vMAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7003.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWZCVzJJRUlmcU90NzluOUNEUVhlU0RTd3NUMkNvV3RZZkhxaHRqMS9odXhl?=
 =?utf-8?B?SWFaNG9wS29xT2hxU3VLeFBPa3M1dXJoS1B0cFJXTDBIckRDaWxPbEs2WCtP?=
 =?utf-8?B?WC9HQ2Vhc0ZFb1E0QnArR01iSVpFWWIyYmg2QkNyNHU3aHlheHFHWC9HRTFJ?=
 =?utf-8?B?ajFVVk9qNGhiS09kV3hESXEyeWJzNThJU0NrWHByUmJlUndmNE93TXV4RE94?=
 =?utf-8?B?VDFkRC9abnB0ZzlFNlY4clRTQnFDRzludmlySnZnZTYwOVo4Z0dISnJkY1JO?=
 =?utf-8?B?UFI5ZFpwZDFVblZQWEkxbi9Ea0RYVmxrNTBiV2l6cTBoSlJ3bk5uSlVKTWJu?=
 =?utf-8?B?a2NkejFBQi95T0d1eDZmMkg0eDZKOUU2N0F1YXN3UEtGL3ZyTkJtenUrMm1P?=
 =?utf-8?B?M0N1SGdrRVlzZFlYVU5ZQlRTRXBIdXBrdFErT0VUSnA3TkVSODRPVEh6Tmpk?=
 =?utf-8?B?MXZicmVKb05RVW5RT1MwREduZUx2YTBxR2xWUGxoZ2dKUDljaVNiWjd2S0Ir?=
 =?utf-8?B?TEoxSm1HbjB3blJkTTBNN2NyYy93Mkc0a0dTWWRTTUtYY25RYW5FTzBWUjJJ?=
 =?utf-8?B?TVg1eHpDRkJYTzhZWllsMkxWMnR1eVNoS0pmaEJNWE1MajMrTmk2ZmIxRHdp?=
 =?utf-8?B?SGNTbXZaRS95R2QyL2hYZkI1cnljWjJwQjN5clNLaCs2aytFNWF4YkF2bHJi?=
 =?utf-8?B?bkw4ekx5VVVZRmx0UVFaYTk5WldVNWs4bERQcEhPaW5qU05yTC8zd3NDT3Ey?=
 =?utf-8?B?V0NhRndKS0VTa3FOY3VCWUpZVmZjWmRvdzFFTEVPWVVVM1dyaFQ5NE9MNXJH?=
 =?utf-8?B?TXk2SzZBbHJ6cmltWGM4Vm9NVS9icVM0UEhnRlZCQjdMejNTeWlPaWhqMkhj?=
 =?utf-8?B?Wkk5NkJsSE0wZWVrMERhRnFhVGFrT0hPdFVNOUc4SE45eUYzb2s3SG5SYWRu?=
 =?utf-8?B?OFhXZG84OElYamJtNVRPVUszUFlPZEJWaEJ0OFpFRmVHQXBUTHJWVnJoelhX?=
 =?utf-8?B?SXVUcjM2SEVFLzVnbkVrdStaUDlLRmpNYXhUY1pBU1RpbjRBUHlFcGhiWHpD?=
 =?utf-8?B?c2MyVmR2Q09kVmd2SEw1RmYwLytLU3RLeTZyRWxrMVNMc3dLTDlheHZOUnBz?=
 =?utf-8?B?YXoxaXlmcEdWT2VQQk9NSGhyaHZLQWFtUzBMOWVLNk1XRjZ2ZTJ5TU9hcUN2?=
 =?utf-8?B?Rmw1U29YUDR5cXU0Zms1MlQ0enVZM3QrQVNNSWQ2N21hWDAzdVdBc2JwUE9r?=
 =?utf-8?B?M0NrdForSUF0Y2o3TW9mSUpPT0ZtZVpvRGYrcnB1OExmczk2QmFsZFNEdWNW?=
 =?utf-8?B?SFdZQndxbUtuRnhpY2o1Rjd1UVZ1WGlMMjVFTXZ6VHExc2dURmd3VFdYSkhC?=
 =?utf-8?B?RlFHYXY1K2daNTd4NDhNcCtRYUFuV0taUUx1NS9UcVNCQnN4MXBaRHJRQzVP?=
 =?utf-8?B?c0pHVjA1azdldklxUDdDODVWMXlPaVI2alpob3E4SWFvTStycVJKdC9JRENE?=
 =?utf-8?B?ZGFxZDA5RFpRWWJwcnpqbVdScXdiNjg5QjlLUlJFY05pZDkvZkRza0pRTWdF?=
 =?utf-8?B?SVIvMVkwZTZWbWE3K1JEbjN5VWdYdEE0MHlCVUtlZkdYcVdRSXd2RmxyWjBT?=
 =?utf-8?B?TzI3eTFWcC9Ock9INVhpdjBOQW53M2s3d3dPMkpmMUxYUitSM0JXOXc5cGtm?=
 =?utf-8?B?U2lLQzlCMmpuTHpxTThwSUpIR0x6aHFKcUJGcmVKUjl6cWNmT2R1d2Z4am5p?=
 =?utf-8?B?aU9IOXh4d3NhRlkydGhaaVZpQlhkRUlhVUdDbm5hcGNlNmE4blBkVjFZOTVs?=
 =?utf-8?B?K1M2ZTZHczNLSVFrVkZPUEJLNWRoR3ZLM01aek4wSlhBRFJIU09xc3ZyQmkx?=
 =?utf-8?B?UUlhLzk5VkNobDh0elZiajFlSXpXZmEvamFBcXV6M3Y4WWNCQmcvTjFoYzlh?=
 =?utf-8?B?NmtjUzBlaUZObE1PSnNsa0pHRjFkdC9peXBMZWZON1g2Y0tnaWM3K3hldk9U?=
 =?utf-8?B?NTgwcHhzWFlSN3QzZEZTR21meFljWmh6NGNHOExRVDRwTVp3YTQwUzFFcm1R?=
 =?utf-8?B?aUFlMGlLaHEwYzBIK2dST0t3ZFNvMmVQV3IrQW0wK2l6WWJJQmUvRUpEWklR?=
 =?utf-8?B?cE1FdFZRdTI1UmdCSW9TSnlwbnRSYXpsUTRWUTNqa0wwdlYvS3gxc3lkMnUx?=
 =?utf-8?B?YjJmYTFLUk5hWjZVUmhMM2RuKzB1bzJhckR2dEUrT0h4U2E3Q0k2MmwyYXZs?=
 =?utf-8?B?TnAxbnJrS1gxaVFmUzFDSUk5QUJLVUhmaWlFRlpCaTNKaUg1cmVOQlVRZUNK?=
 =?utf-8?Q?mfSzryOoMIpep7X9nB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a721b3a-2e7d-4f2f-afcf-08de58bc567e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7012.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 07:11:46.9780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISRMXUHHvHCknX1/JzZRwDY3dy0xwlq4b5RoKcs3cRX4KLTYkkDhqBX4Dz6Y8vf5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gal@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DE3CE52A70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 21/01/2026 1:44, Jakub Kicinski wrote:
> On Tue, 20 Jan 2026 14:47:33 +0200 Gal Pressman wrote:
>> The __exit__ method receives ex_type as the exception class when an
>> exception occurs. The previous code used implicit boolean evaluation:
>>
>>     terminate = self.terminate or (self._exit_wait and ex_type)
>>                                                    ^^^^^^^^^^^
>>
>> In Python, the and operator can be used with non-boolean values, but it
>> does not always return a boolean result.
>>
>> This is probably not what we want, because 'self._exit_wait and ex_type'
>> could return the actual ex_type value (the exception class) rather than
>> a boolean True when an exception occurs.
>>
>> Use explicit `ex_type is not None` check to properly evaluate whether
>> an exception occurred, returning a boolean result.
> 
> Sure, the checkers complain about this, but I don't see an actual bug
> here. bool(terminate) must evaluate correctly, we don't compare it
> to True or False explicitly.
> 
> To be clear - the patch LGTM, I'm just not connecting the dots on why
> its a fix at this stage.

Right, the code probably works regardless of this fix.
The reason I submitted this as a fix is because surely there was no
intention for 'terminate' to be non-boolean.

Take the patch to net-next instead?

BTW, I encountered this issue while debugging some tests and dumping
various states, the value of 'terminate' confused me.

