Return-Path: <netdev+bounces-258217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDvjL8s5jGlZjgAAu9opvQ
	(envelope-from <netdev+bounces-258217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:11:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4625B122186
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F0330209DF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 08:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024A34FF6F;
	Wed, 11 Feb 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mMrpRzcv"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010037.outbound.protection.outlook.com [52.101.85.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F053C0C;
	Wed, 11 Feb 2026 08:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797511; cv=fail; b=Nu7xuE2i22AVsZugUbfpmL+Nz8oVz+8Om0hwUYhmoRI0956v6QY7LUddrkiznA6jK2we4zFxiDIeyc0I14vhF+Rvksj7fh5Pb0vjnfe9GtQ/7128yjjLSvwVOcjTpR4mB7zrUkC81iSbkCKk151w/aR5jT49OoHGzZVq0fwpfVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797511; c=relaxed/simple;
	bh=p1l6KJf5I7Vb1BVNCHuc1u52CINt6c2PLBK+huqYz9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YGlxASdtqwZBb5Td6glhnzgkCKbmGyZAD3G7d70dIXCSTXid8JCImtZGRQD1JGxJusoKdm2LTqddJrBnYEAgc2gaBxShDY8AOclgm7PYy9e++gBlb8xnMtKWa7cho1T6MZOPzqPjRD8mZILAoT+9Pjjcy62UtAewl1aJa/DWn64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mMrpRzcv; arc=fail smtp.client-ip=52.101.85.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9iDI7Q+dHfR3smES+nMLoM4p3d54/5JGR5l3+suoPyld6rUiYAsEPGzWVKwKFaCjxVK+YskKp2GvByiSMypcfaD0wpzsnIHIYS3HC5jT6qtB/qBuPVB0ZPI7xgh80Q+1JOBY9aK50HNpsm+LviGcyVFnZ4YSiFr5sbZE6AuC6fzebIV56xxl+uh0zYzHuESUx4hlfYjeGgTI3o0oA5DihEkKhUyE+mRVsDexgqMvLT8H5p6WOpdG5yvoXgOTEVrkLY97EcGwW7gigrhimKlapB+JR/FGNMu4gpa/2FAHql06w98iLdLT7NiU2BjPt6G8E1wYFVOPU0yS6e7Ev+ROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRabceVk1ZolKIAx8ucmjdy8CRxV6Hyqe8uOXx6f8rY=;
 b=BxsFfzgNJ14ZVq4nsy2LY+bSAczLHUzhiGqOEFuVKQCWoyIKg0uu58vtI5ks3gusj8oOD5uqxFt7wuzvUsS+TMqdQnIoL/Bl3vXo7hUqfLscBnlvUQGTlFonVvB+ECe0ZUpAq/oRgxXcymYA/0Lu3mq/0yhSY9zNv6oCgWonsPlw3l3Srx0Td4txH/4JCTHBWMaU1gkawiW3aaZo5jSA7kgkG+2mIX1XhxoYEL4Ihnps6NCsQIRv1sajXvyr4fMdRopG6zzmQrGDbN8tFkh4BujEgnsfwDjMbAg8MkumqrQ1sGl/j/eJ59R4RsZ3EifzbwvVUDPvilRw04ZgW+seVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRabceVk1ZolKIAx8ucmjdy8CRxV6Hyqe8uOXx6f8rY=;
 b=mMrpRzcvikN5hdoRHok83vMAF7Mocn/jkVwhAvRzH+55u1iaoFf4VWra5FDePPSTjqafo69+WIdYNQlZ9xsgOkpP5il5i5iiB20K/mZ0tP5mtbsU9HjSoGI69J+K1oiXPk/BqpTrGIsYdSVW1arexuJL08YQBNWp8nCeEmSs7wBSf9LIGwrsd2uUmDPd1ujZvHDs2ZsOr81u9vUr+1yk5sc2AyQ28D6AF/YdvfP/VIEqp2Jke9+XfDUEnIJ1uJmdZIdJxoeRuuEhpU++axun+EtAwxOLiaLE8LhXwLIHnoxVzJ234kHWLPxeY5yRwuK/05LCHzDzROh4g56skrSqWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 08:11:45 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%2]) with mapi id 15.20.9587.016; Wed, 11 Feb 2026
 08:11:38 +0000
Date: Wed, 11 Feb 2026 10:11:29 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: forwarding: fix pedit tests failure with
 br_netfilter enabled
Message-ID: <20260211081129.GA475567@shredder>
References: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
 <20260210185129.480015-4-aleksey.oladko@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210185129.480015-4-aleksey.oladko@virtuozzo.com>
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 485fa28a-5452-4b3b-2f37-08de69452e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ankrd1FPTG9XMTFtV1AxR2lBSFJLK1p0TzVKWHpOUDJRZDVPSDVKK3JncU5o?=
 =?utf-8?B?MzlOODFJZnRSNjA5Rm1MVWFhUW11eGUvbE12QlM3WHd2L2xIMURidzVabzNF?=
 =?utf-8?B?cUtmYjVZV3JGbkFsNHBudGpzRU9NTmkrcmkwRzBqTVpPRi9WUFJtWFkrNGJw?=
 =?utf-8?B?SFRZeEcveXE3N3BrelNUMDFndkNWVTZIaVhSTGpVMW4zV1oyNjJiUG40V3Vu?=
 =?utf-8?B?bmZ4cnQ5WWxzTjFhNjhlZy8yZGtWNTJ2QytEaDRKNHhUZktZZFVTVWJWU1Qr?=
 =?utf-8?B?TzVTUEtPU2FQL2c4bU9yWjc1eDVYa1N4TEZDQUpiY1Zsck9JYzZZUDBCajcr?=
 =?utf-8?B?RlRPeUZPVzQzNnN1NGpBV1V5VFJNQ2ZiQno0M2dvS0FkeSs1REpRYmo2N3Rr?=
 =?utf-8?B?eFFMWWpBaWJhZVFMNDk4ZHRLdEF1YmNLcWxKdFdVQ0krVTdYVjRITWZ4cTBi?=
 =?utf-8?B?T1V5NWJmNVNQUjVOMDNrU0YrLzJZRjZCTlRQalNwZE80ZXh2Q1dLY2E2Snkz?=
 =?utf-8?B?Smd2VXBGS1lyVzdGbXF0TVNuREdaN3JGdzVITVRlUUhOdDdWTFNILzRpZEto?=
 =?utf-8?B?YTI1TVRRb1kvbDdTN3JLNzY1dlM3YWZHdzkrUW1xQUVkRndrOHVKS1pNU3RS?=
 =?utf-8?B?RkR2c29NZlZsRUxtc3c0TTRSb0k3cUpQVnljdlBRRjkySWo5VmE0cEJzY05K?=
 =?utf-8?B?SHJyYmJqUHpZdklWTmlOdy9mK2V2d05DUU9pK1BETXlLWG91N25QZEZhdE13?=
 =?utf-8?B?VUFQOUw4R3FidyttQzhBeGtVR1FQbmczbVdRVWxFaVordWZ6Q0xqZ3FvWUtX?=
 =?utf-8?B?em5yOEFBSDIrQzdycDRib0JLS3M1eUdDemFyZEdISGQ2d0xZdEQ3OHpSSE9W?=
 =?utf-8?B?Q0JiVlhISTdzVUlMb1NGODFYeXRpalNuL0ZuMTE0Tmw5QXdiL3BnaTkzVkpt?=
 =?utf-8?B?N1dvWWc2VWZLR0ZsdCtlaitJZFNqakYyQzkxUm5pdDdUck05bTdTZ0lpYVpy?=
 =?utf-8?B?VWcvRU5ZdGEzMU52OXcyaWJ5dmRCbjZCZ2ZoNEU3Y1lsWndmWmx5MnhoYmcr?=
 =?utf-8?B?dktPR2R4bU1iSEx3T3VCYlpJRXE2dWdWQ25DM0djU1MvSWtWQkUvK004NEhh?=
 =?utf-8?B?a0dQbFltSHU5dVBWN3F3ZFRlaHE3T1FJQ2dMRzk0NGg2VmRxaDBDNndCUUtu?=
 =?utf-8?B?eTZVRUhrWWFhQ1VDVDN5THNKVlhJaTNmVnNSTEl6c2RDQTlWSHcyMFdROUVR?=
 =?utf-8?B?TERaTEQ1MXppalF6TWt3RGJTTzhTVW1oNFBlQlJkdVRkaW1DMU44bzhvbFZY?=
 =?utf-8?B?cThZQWxzUUF6NnNRVmFvMktURy96UlpRclBNazVKR216MjNwMHFTaDdlQW5I?=
 =?utf-8?B?ZzZ1T0w5SmI0bUpDRFJ3cUEwc2IwOFQ2UE1saXBFOW0ycDIrTEdYWnFHN3dn?=
 =?utf-8?B?aTFRODArMkswQUZWdGNzcWdYUXB0QkluOGdHQUkveWxpcVBlb043MllNQ0RB?=
 =?utf-8?B?aGJ1RHk2ZW9tR0xxRTRkZ2NZQUlRZ1hzWEpzdU5KSUxWRDU3d1c4eDl4aEJi?=
 =?utf-8?B?ampHR2VhS1h1UGRJNmJDSFFuRnZHNmw0ZDFPN1dlYllqbktSaGdMd1BUbHpZ?=
 =?utf-8?B?aEdDSUUxTUZjMWhwMDU2eHYwUTJEZ21VQkk4MlltbWlHUzVrUFBBWi9HREwr?=
 =?utf-8?B?Q0FYTTN3L3lNWUdQQVp2VkE5d3N3V1dFZEFPRlpyNTgzUFVKRG5XL0Qva3Zi?=
 =?utf-8?B?c1JlRUw0YVQrSXZiQWovN1RQVm1nTnFKNGZhbFpIeDNNWGFpTXdaUzBZajZ1?=
 =?utf-8?B?Ym8zbUpPem9IQS91T2FON2ViV2txaElxMm0zSy9YYjBjZHlTaEZKTTFXMndC?=
 =?utf-8?B?Y2lkNGpyNnk1b2RhU3hGWmJFa3FYejdibitJZFZKWFNTU1k0S1JjeGxPd0s0?=
 =?utf-8?B?Vk9DRENUcmJMNUxsT1AyZkxXUUpSMEhHaFFsdHRRbytFUEtsYTVkaUFxVnhX?=
 =?utf-8?B?SExZOWN2dUt1N2UraWR1RVc3UkU0QndteHJrNzdBb01BdjlYSUdReEhXeEZn?=
 =?utf-8?B?SnpCOHZVeGFwL2NoMW1NWFE1OEc1cmJMRnhEU1p3Z0dKR2xCTlBsSTJuNEJN?=
 =?utf-8?Q?vfCw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE5hOGx5eFJTSGhHc1pUdUthczNnK0hJRkZhODdJY2YvbzMwMUo3RDA0elky?=
 =?utf-8?B?MlozUnMwNEhCWGhhUlg5WGpWbHR1ZkJaMHloVTBGNklMSkxjRGpFUEJucWdL?=
 =?utf-8?B?Snp5S1lJdGlLTzdPaHhORWlSbmNueTE3cVRmb25nM1FOL0ZCQzNWcU5ZOHZp?=
 =?utf-8?B?Q3BGbzEwNTR3WWZlRENBemFQbmVLTmk2eHFMZ0pqS2FNb2d6ekhYSUJxZTI4?=
 =?utf-8?B?TGVmc3h3SFpsVXNmWGpteG1CNlFKWDNBT0pnK2t5WnJtM2o2NzJ6b2NvaDl5?=
 =?utf-8?B?SGJXYzZOM2FZM212V0UzNERJT05Ud1c2VC9SdlBIRnJHZHYvTlJKZE5ER2JX?=
 =?utf-8?B?c2FGeEpxOFlPMUcwRGl3WHl5b0RGV01MZ1ZjQk1ycG9XMnZnbWY0T3pCQkVH?=
 =?utf-8?B?aVlwbUphUm9vejVPN1JSU0tRM01RR1NSWUFVOTNTdXF1d291bVlObmwrZU5K?=
 =?utf-8?B?QzR3QlREZ3pFL2oxdTRhdmhpbUFGN29INWp0azFpWDRvZnJCSTk1WmJ0bFZk?=
 =?utf-8?B?OFVGQjIzWWtvWnVGR2prM1JyV0NSY283aWJlZklIRmpuNmpOd05PVU1sT0cr?=
 =?utf-8?B?aHpFMUpoNDhacFJwSFdweWhMOUQ5Y0RoQm5CcHN3OG9wZlg3N1k0enRRR2Vs?=
 =?utf-8?B?cU5RZ3hCMVZVek52SnBYMy9pcHhSMmNGOXFrTFJvRHRnVCsrNVVEN0tJc1Yv?=
 =?utf-8?B?ckdaR2VYV2ZPbnJzKzZzZWUzQitwL3hWTTFmZFVISUtYWW9DOUtvUStSSDRH?=
 =?utf-8?B?dklzN25aQVBkSUswVTVibThvYS9Edm9lNFVmWUVHSEh4NmJpS0NkVE5HcGE5?=
 =?utf-8?B?bzV1WVBTNDJVNkVxMU9vT2Naa2RHK3E3ZkhKcndNU2dua3Vha3JzdGt3eitW?=
 =?utf-8?B?ejF3SS9pcUhZUnBhNXJlYzBYcURud0srV1lWRFNrRWx2SXZ6T2tSVTk2aEFG?=
 =?utf-8?B?OGlnZ2NLd0ZBTUU4RU42VjR4Q1h3VStUMTNDMlNSdktua2JqNmlYNEFrU0xW?=
 =?utf-8?B?aWtxSmplWUtnem9uM2l0dFhYN2lwTXluNXpJTFFYdkR4cUlseTUyNlNjbzA2?=
 =?utf-8?B?SXBkS0I3M2RtcGV0OFE0NGs3MmJrN2RyejlSVm5BTk9YeHc5UXNscG44dTBW?=
 =?utf-8?B?NVh5eU9uR3R4T0lTcW1Jam9jalFGUFpFcWEvS3R6M1FUcElvbzFHVFJCRjJ0?=
 =?utf-8?B?Y2FWcDUwOWp1RThOeTFONFNWMUhtTGwwWktLdzFDUXRiRXcvOVdPQ1FZTGlE?=
 =?utf-8?B?ajN3N3RFZ1NYSlN5MUpiVW9VOXI3dDQrQUVBdG1VVW0veE11aWJBSVRhUHpF?=
 =?utf-8?B?RzU2U2JCdEpQRmpta1cxSEhuRGI2K21GMkIyNnMzdXA3L0RFQjRIRVo4Tmdu?=
 =?utf-8?B?L3N2ajkwSlBNLzJtNjFDb1J3NGZhK20vcmkrQzAra2pFT2JXS1hTTlV0dnV0?=
 =?utf-8?B?NFpkaDJWQmM1cVlqeE8ycE8zcStuZmtXMk1XYlZyOTRTVi8rOWQrVGtlT25n?=
 =?utf-8?B?Z1BXeUFYWGpNMS9KNU9Rb2F0NWdsVGpJaWI4ZWZuQjF2ZWR5K2JQZWRMdzhh?=
 =?utf-8?B?T0k3SERlZ3JLT3J3eUU2UjdqR0tNN1diMEhrT2htVXlWNEk4K1BVQk52QjZo?=
 =?utf-8?B?ekMvSUxKK0dtVVIxZjJ2Y2pDYTZla281eGFoZlZiYkxVTXdZVVQ2VTBmNzZa?=
 =?utf-8?B?aTBPWVo1M1dYQy83NEhPNVlBUHNZS3hQVWtuNmwydGlvZ1ZGaGF4aFJibjVB?=
 =?utf-8?B?NkMydVhXWjhENExLL2RYazdYcGpFSHhHalZ3WEo4bnlhakNKQzArTlhuK3VB?=
 =?utf-8?B?MGNBNzE2ZzkrcGVlZTdqMVNxWXMwakFTc3QyZGg0eTlkRGJKQjF2cE5nU29F?=
 =?utf-8?B?RTEwWEREaTlmdmNITEQrb1RMNWdlKzBrWUFNdVA2NkZ6MkVqOGpwT1JDTDJ2?=
 =?utf-8?B?a01nMVphRDRGSVhoejZwTTlLQm5MQzJvTmVtSXpkQ2ZUa0doLy9Dak1wMDJy?=
 =?utf-8?B?aldTK1Q0OURDTEt1TXRSSWdVbythanJLUUVVdFpYSHNkb2xLb1dKMFgrVnpZ?=
 =?utf-8?B?NTV2Qjh3MWZhN29SODlzNEpUSDlVVXJjU25nSVVPRGQ2NGVHeTQ5ek5kVE5y?=
 =?utf-8?B?ZlVsNExmWEtxZEV0c1VXMlBESElsS3NTZGhMbVZKSTQ4YTJuVXJJSWtXZitl?=
 =?utf-8?B?OTRGaHBxUmwxd3ZlU3lTUkpSQnRPNXBSdEVsdnE2OCs1cHlVVDJiS2NPZjAv?=
 =?utf-8?B?VGtJempvbklqZUE5cFgxUm5Yc2FFMlhZaFlEN3BML2ViYnh3ZTF1aHBCZ0Ex?=
 =?utf-8?Q?lFo3foH1Femgg2GPg/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485fa28a-5452-4b3b-2f37-08de69452e2e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 08:11:38.3643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qcRFshJxetvLXAtI6Bs7fm1+NotlqoUZrFszcsrWmOUH8D57JxMxMsW52jpRfS22vdDxhTmwr/gigoQHBPWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258217-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,virtuozzo.com:email]
X-Rspamd-Queue-Id: 4625B122186
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 06:51:29PM +0000, Aleksei Oladko wrote:
> The tests use the tc pedit action to modify the IPv4 source address
> ("pedit ex munge ip src set"), but the IP header checksum is not
> recalculated after the modification. As a result, the modified packet
> fails sanity checks in br_netfilter after bridging and is dropped,
> which causes the test to fail.
> 
> Fix this by adding an explicit checksum recalculation using the
> "csum ip" action, so the modified packet contains a valid IPv4
> checksum.
> 
> Note on IPv6:
>   The tests in pedit_ip.sh also cover IPv6 (test_ip6_src, test_ip6_dst).
>   The csum ip action is harmless for IPv6 packets since IPv6 has no
>   header checksum — it will be a no-op.
> 
> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/forwarding/pedit_dsfield.sh | 5 +++--
>  tools/testing/selftests/net/forwarding/pedit_ip.sh      | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
> index af008fbf2725..310f96fb2274 100755
> --- a/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
> +++ b/tools/testing/selftests/net/forwarding/pedit_dsfield.sh
> @@ -156,7 +156,7 @@ do_test_pedit_dsfield()
>  	local daddr=$1; shift
>  
>  	tc filter add $pedit_locus handle 101 pref 1 \
> -	   flower action pedit ex munge $pedit_action
> +	   flower action pedit ex munge $pedit_action pipe action csum ip

I believe that this is going to be a problem when running the test over
a device that does not support "action csum" offload.

Can you instead set "net.bridge.bridge-nf-call-iptables" to "0"
(assuming it exists) and restore its original value at the end?

>  	tc filter add dev $h2 ingress handle 101 pref 1 prot $match_prot \
>  	   flower skip_hw $match_flower action pass
>  
> @@ -229,7 +229,8 @@ do_test_ip_dscp_ecn()
>  
>  	tc filter add $locus handle 101 pref 1				\
>  	   flower action pedit ex munge ip dsfield set 124 retain 0xfc	\
> -		  action pedit ex munge ip dsfield set 1 retain 0x03
> +		  action pedit ex munge ip dsfield set 1 retain 0x03	\
> +		  pipe action csum ip
>  	tc filter add dev $h2 ingress handle 101 pref 1 prot ip		\
>  	   flower skip_hw ip_tos 125 action pass
>  
> diff --git a/tools/testing/selftests/net/forwarding/pedit_ip.sh b/tools/testing/selftests/net/forwarding/pedit_ip.sh
> index d14efb2d23b2..a53ee3b1ef67 100755
> --- a/tools/testing/selftests/net/forwarding/pedit_ip.sh
> +++ b/tools/testing/selftests/net/forwarding/pedit_ip.sh
> @@ -122,7 +122,7 @@ do_test_pedit_ip()
>  	local mz_flags=$1; shift
>  
>  	tc filter add $pedit_locus handle 101 pref 1 \
> -	   flower action pedit ex munge $pedit_action
> +	   flower action pedit ex munge $pedit_action pipe action csum ip
>  	tc filter add dev $h2 ingress handle 101 pref 1 prot $match_prot \
>  	   flower skip_hw $match_flower action pass
>  
> -- 
> 2.43.0
> 

