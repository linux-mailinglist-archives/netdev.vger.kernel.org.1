Return-Path: <netdev+bounces-258136-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id RqgZAapqi2lKUQAAu9opvQ
	(envelope-from <netdev+bounces-258136-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:28:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A3C11DECA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC2453007539
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04838884B;
	Tue, 10 Feb 2026 17:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B8MgP372"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B325A354;
	Tue, 10 Feb 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744485; cv=fail; b=mjqjFU7WjxulbcY2pR8BB/NHrEV/dR2Y5KJ1L0gc2Z/CDvqZpt5dv6tl+7nuUMAV0FscDDAV5fYq1/XSg5J6on5P+SnWmO0O1yr6nF1SwKtFDiOuYnx5wlDFWQZgqccbzNxLi7muJYAK41jlT8X9S6i+4+WUM4mJ2FzxqYrfmt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744485; c=relaxed/simple;
	bh=RSQJKPhtZhFM6AxYG6xu6w1ovFJgeBDed66eerIPAoc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oayRlGRe1ajmfufun9IcCAgF9qpl5DNO3EHUHXlLu8T86RMZDWDeoPkXXI+SWvDdKIwCWuGc/zinpZ9iyZYnizP/I0wzSaV25aiy9xbejxqvuScb2DxZ5ECIk+e4CPYNW1e2ZaipXkTxQ+WNfcd62w1pybTIXfGbhocsv2w/Mps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B8MgP372; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8RkgRUQaTBWTcL0kz9sw1oKyq4TctcvjjF5jb+hwRucQkXfaGb2NVr45yVmeznhumGrj5KtjpOzdWgnxSmjtAgJHf9NOeYh5bLctDFT2tNPu8lM759nRRyGQt5wQm6W31AsNaOGI0CNEBrAz7MGooJ90Qa8OXwB3l27MA41i9x/g8oi95RgPDHGDydgGGibqMX1w+psN1BceHAVD7LQ6NoKC1tsBZ1nzAEp7Hbyot0P/Cy660g5G8RAthQbEbUg+O2rm1McdZiGNA9OMXsjvo1DVt/nOqgO7gR01F+UaO+PUUWgKV0gGNhIXeZ4Bv0lQ047cmSNU3Sf3Tio7uA+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cstK84dcUuyRVSOuTcQxy2W31zuB/M0IW6tDX+QlZJk=;
 b=MPdMZMYemD0MtjKHNlWv5En6QANEO+9WBdM0PhXJ0uSMBDeZA34I83Qv3wGdEP1zJrAk9vPsH1lJJYVKx8cyAd01oMXkFoP/O/6BM0zrxb7bvjyEYoMyMswqSf2FsJ2UCczgXdKGOQXPb8OWsbSHTcAbQJyFCPhOjMMhx5FMrVGiZBT65pHJx56yZWC7DFm0xDu0DRICUdWYczxVn5x2pqPdK+Pc5Ha+HQQoTdQx6+/+o94EvAlIBExHyxlKawuGlHL9mVnKpxanlJVygMJEWPVzNYDv68dfYd5RpdankXhd85JTMEqH9pLRUjaC5rtnTnKjBHkvM9LOnzIy1oaoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cstK84dcUuyRVSOuTcQxy2W31zuB/M0IW6tDX+QlZJk=;
 b=B8MgP372Sz5TvFhC1dvh4YMkcCdnsYwzjYuYmVYfA9UKLrhQ8vdfRKL5E6MJQWRMumf7jmPx3cCaVAcfbmpf85pTJNu8rYQfLr1x1zq9L5OT5NIaCnS/eS8qoiQduEhiPzJ9tBkBUIH9p8N9kjvRrtNTuiLYMpnRoqPfbtwS/JAQ/NJ5ydeB2NqO3TccsfZXUT8gxqvAX0oKeOhZlAsmzeFqdU6oSrOFTWcqBUBJxuhQluBsb2E+w2e/Q/vHdMwHx0pTaqMtnr4JIkLUH1XMdLSXrihveTETrw2MPrVakB59eFgwYDUQTL2yghJeP6TgI2vi2+m42QnJFMTmJNzISQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by BN5PR12MB9487.namprd12.prod.outlook.com (2603:10b6:408:2aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 17:27:58 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9587.013; Tue, 10 Feb 2026
 17:27:58 +0000
Message-ID: <e229a820-e2e0-4dc7-a6c2-03ad6f2bdac3@nvidia.com>
Date: Tue, 10 Feb 2026 18:27:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf 6/6] net: enetc: use truesize as XDP RxQ info
 frag_size
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Wei Fang <wei.fang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kernelxing@tencent.com>, =?UTF-8?B?UmljYXJkbyBCLiBNYXJsaeKImsKu?=
 =?UTF-8?Q?re?= <rbm@suse.com>, Eelco Chaudron <echaudro@redhat.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Toke Hoiland-Jorgensen <toke@redhat.com>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tariq Toukan <tariqt@nvidia.com>, Nimrod Oren <noren@nvidia.com>
References: <20260203105417.2302672-1-larysa.zaremba@intel.com>
 <20260203105417.2302672-7-larysa.zaremba@intel.com>
 <20260205005901.gnju3zmqimtgeu2b@skbuf> <20260204173401.282899d0@kernel.org>
 <20260205122953.lscemcctayrvszdu@skbuf>
 <aYSP344FT-JlylwY@soc-5CG4396X81.clients.intel.com>
 <20260205124638.hxzvjiocephzlrk3@skbuf>
 <aYSZw4wbd-nvLTuD@soc-5CG4396X81.clients.intel.com>
 <20260205134046.pggwyosutj7ggi4i@skbuf> <20260205175408.30ab72a1@kernel.org>
 <20260208125934.f4n5mri2pit6s6gn@skbuf>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260208125934.f4n5mri2pit6s6gn@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|BN5PR12MB9487:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d0f811-be2b-4bc5-bd83-08de68c9bbe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0NsQWJzQlRNOU1XSEFSV2o1cklOek05NTVIdU5jOWlTM1lwaGp1VXZmWU1H?=
 =?utf-8?B?K08rcFI3NG9EcVd2WlNIUUIxK2xPQ2hGS2JXT1NOQ1FieUkxMTI1V2MwTHNS?=
 =?utf-8?B?Uy9EOWpoa1BZazZUNDNuNFB4eDFpS3EvQ2l0ZWNQSDJIRjVoSk1XWCt1N01z?=
 =?utf-8?B?VlNUMDZIcGhJY1JJTW5kamF0d3drTXZCYVBmdVZnVnpGSXB4UVZhTmtrZHBE?=
 =?utf-8?B?WW5ySm42SkMyT3AwTmZPM0F5NGxWdnYyM1oxSDUxZmliMFBoelZLWFgzN1JX?=
 =?utf-8?B?MUJWSHFqRThNY3VFYmZPTmJ4NkxTVG9WbHprRks5ZkFteDZGdHBTb3oyRWVY?=
 =?utf-8?B?M0pDNWdxaUlCMnV5cVFWRTNWWStZTFF0RDZkMitJVWJ5L0NoLzN3VzNnbzRs?=
 =?utf-8?B?YmdjSkM2YWZCV3FRUFlOWUQ0YXlLcHpZWUlYVGs4Z0RtVFprVVVBaHM3K0Yv?=
 =?utf-8?B?VS84cHF1cjNkYXdDcFZKcE8vUzVRdHF3TFNUN1RsdU1mWFQwZWFpeG9ORVdx?=
 =?utf-8?B?dlJvQ0p3Q3VVSVRNNlhDM1BhaW9CNnQ3SHJOUG0zU2k3NzRTREZ2NE9QcWY4?=
 =?utf-8?B?ZFVxazl3ejhpWW8xUXN5N2NGdU5RSjRrQ0ovVnVCSHM1akYxaVFqTEF5RkFu?=
 =?utf-8?B?c1dXajJrZHR3aS9YVDdOd1ZKQm9BcDJmenJiY3o3RGV6ZzY1K1FFdGJETFli?=
 =?utf-8?B?eTR3SzlBRnptdGNJY1lZUFFmU2VUUXVCZzE5MklPTWw1aTRWOVlhR1NsWUd1?=
 =?utf-8?B?dUFJc0phZHh3Q3JBbUtjWEN6Y1NTRnhjS2F1ekljR1VyTElQSVRHM0s0UHd1?=
 =?utf-8?B?SmtlWGJCT0dwa2VmWnlSZXdqWk1maUQ4QmpVZFZZOVVyUFNQbFBIR2VWQVJx?=
 =?utf-8?B?SHpZNXVCbk81UUJZTFNwdXRiZ1FBQ1I2dzN6QWJOS2FHUHRuTDZDeHVFbUQx?=
 =?utf-8?B?MGpQS1d5T2szZHZidTFaYnNMUjBUMWxiL0V6cjNGbTB3Z2o3WU1wT2RMcWpK?=
 =?utf-8?B?VVVJdGVDVDZuQXdmUE1EWkpYTFBMbmdrSGtQdHhMQXFUeTNEcExXVTZwWm9S?=
 =?utf-8?B?aG5RZ1JYby9vdHpIeU9lQnBldkFyeVJMbFpSUE5XM1A1bHNhdjNKVFNhUXJ3?=
 =?utf-8?B?ZDlRZmFkdnhDWlprUWlrV3hiaDhpS0wreHlBb25jeVNTd05zRU5ySmJiclBO?=
 =?utf-8?B?M2tlaitnYzBSeE4zWmZzNjdUUTJFYUZyYlpodVQ0K2hDRnMxcVRrRzZsakd4?=
 =?utf-8?B?SHU5RUtrc3dseTFBWDVRRXdWKzJyRlAxYWxJZUMreG5qNjhRalpCckl2WWJC?=
 =?utf-8?B?c2xGakI2aW0wNWs3WGNnVmwyZGJRb2c3MXpLUEt3dWxsalRaeGc4c3B6bHFl?=
 =?utf-8?B?Y1pUUFJ3RndJRVA3MnFENGd6RHpzY3R1Mm1OOEhKZGIvYjlaYzhxak4yYXNE?=
 =?utf-8?B?ZGRZNnRPNTBTaXVHQklRK0d4UytLWXhqdEJ3Qys5QkkvdHFSbnFMeTlxbjdU?=
 =?utf-8?B?cFBCQ3FtaHlIYUtzaWdlZE5sY2s2MG43cG5WUWlkdis0MzlsVGhRYno3SUpx?=
 =?utf-8?B?TStZYUZmU3pjQldBbUIvU2JwaEg4Nk9WazUybzM2dlVVUjh2TldvRTZ2aUFn?=
 =?utf-8?B?TFlMalowaEM5d0NRTEFkSWQxYnRqclpOWjEvYlFLVUF3dG9ZOGtjSmpUTGRP?=
 =?utf-8?B?NTlRUFl2THVCZFl4NG02Y3g5eGxva0lqbEpVbmQ0RHdXUHRhMmZ2YWlNdHpL?=
 =?utf-8?B?eXBEWVlyeFlyRXJmdEx6alNnTks3S203Q0w3MGY0ako4T2RtL0xrTW8yV1BQ?=
 =?utf-8?B?azVBaFdSblNxcVRFWTZmdkFjYVVVVnNyNXErejZJd0pFOFBrTlR4YlhCUXh4?=
 =?utf-8?B?ZGJ6dGdHNDBIbnRFdjlIZmFuOHJQZmszRExHYUowaldzV3IydmpyTWk4RjNX?=
 =?utf-8?B?emNVVS9KRmJSUXArSGZ5RUpsUmsrWEFzaWVBN1dKMFVZTlJpVUhVL2pJU1Bz?=
 =?utf-8?B?R0cyNHNLWmhudkpVKytOTTg5Y25aZTgrdHArbEJJSVhLNzNIVGE4Ui9FVE1M?=
 =?utf-8?B?aHJxVnJpRWtQd05USWJ6STYxRE54dEVqQkMyajk5K1AzWGJBQ3RFUmU3c1N5?=
 =?utf-8?Q?KKJA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVBCbXptcTgvVVJ2YThDUDVFb3hWZTV2bXBYTWEwSXlKVGNmaVE5TkF1bjcv?=
 =?utf-8?B?TFdzYnRGNUJ2blBrNCtVNXhBL2JxYXM5dkVoT3hWM0QrSEN2NUgxa2daWWMw?=
 =?utf-8?B?UEI5S0FoZXllSjdlcHRGNUgvNDk4aFVOemxlTEN1SHpnYjlVbFhRajgwNTZ0?=
 =?utf-8?B?VmtEUmI2Z3k0S0ZpRW9tdWlweGRrNkRIS2V4eCtRZ1BTL1BRU2NoaHJuR3NN?=
 =?utf-8?B?SGcraGtuNTJGNTFXUnlTa2lHUWpMaEQ2OVgvKzVxV2x6NlgvWGYySExQZVAv?=
 =?utf-8?B?SFRKdERsWEFFbURLM1o0Q09nOHhXVFJvT0dKdXVXS1ZBVmM3SE1oZXhWOVBB?=
 =?utf-8?B?OUpsU01VWEo0MFFvT2NIY213eDBZS3hvelpBMzV4V0pLNXdZNWsrVGFqdHJh?=
 =?utf-8?B?NkhJdDlFeVVJOEZuTkhhRFVZRU9QQUZSUHRHcWUwV0tZYVBYL1JtcG55TTZJ?=
 =?utf-8?B?WHE5UE1hQWFvWkV5OWhLUWpsdUMvQkYyUVFRNzRIaDd6dkJHLzRpZ1doV0VM?=
 =?utf-8?B?L3ZOZlEyWVFZQ0xVZHZ4bGhvdjFYZ0IwSUJjNXlQTDVqT2oyQlppM25KNXR5?=
 =?utf-8?B?L2w0d29mZHFFQU1hUWV3Y3BnWk5iTjNaOHZxWG9pT1ZTZjdoSzIyS1JibG04?=
 =?utf-8?B?anpyVXVjVmhEZWMrNE1WNU5zbHJXczhZVlFSbzhyeGs2SjU1T1JhcitxZHNR?=
 =?utf-8?B?UzQ0Yks0OEZiYTlBNkdwb3NPUFpqSnMwditEQzQ1eUlheEJYalZnT3pSNVVK?=
 =?utf-8?B?K09jdDFiaVp6aVpwaUxva2tHenlqbmdoS2JuV3NHeDVHR0RlRWx6a0FXZmJh?=
 =?utf-8?B?TEd6elVsNDkvK3phVGl6Mzk0TUppT3M1S3FMbXNQNkoxU0dLOVk4ck42SGdV?=
 =?utf-8?B?cTRLbkw0U0NIdTd1bWtBcDFGMGM0MUh3bVhmbjI3SDFqdjdzZkxQTllGQjRp?=
 =?utf-8?B?VXZYekxsemoyenIzbjBVS0ZrRndQajJqZGtLNlBkUmlUM0lrdW1GekVNYlFx?=
 =?utf-8?B?VkN1MTVhZk40UXUyQm83ZzRvaG5BMVYxMzdZYkxKMEJHVkxZZ3dGRkgzbUNY?=
 =?utf-8?B?MkdNNWFiM3U1Rm1ocWJDN0Q1TW96R2pOcFowbnV3dGRvMmVkL1JwaEsveXdB?=
 =?utf-8?B?WUx0MytoY2cvQThQMWpEblRxeFJVR3l0STg3VjErT1p3M2FJVlkvYUw0UkNB?=
 =?utf-8?B?STVqSlV1SGdxZnF5TTBOam9mWU9vQUdabmNUWWFhc2MxNnlsWCt6bTA4bmZJ?=
 =?utf-8?B?aWdFMG1nVGJtR3EwWGtJcU9KTDcxWGhXWS9yZFdERUJVN3VaVWs4TzE1dVVD?=
 =?utf-8?B?YWFwZGh6SWt6Y2pZYUVXSGdKQ3FiampFcHhLN3E3VzNWU1l6ako4TnduNDhq?=
 =?utf-8?B?dlUvRFlDWjZMbUtjN3lKUkg4Wm41bFVHSTNWY0N0c05tclRKUGdyaUpQMXN3?=
 =?utf-8?B?UEZqOStRdWJsSFZxRHlEc3FlTW1KZ2tYbkdsaXpweVFSalV4YWh2aGQ1TzRJ?=
 =?utf-8?B?SmZhVXNESTRvS3pGbHpaOHRLdXpKSFFZRzMzeG44WmdFNXExT1AyTGlHTEFq?=
 =?utf-8?B?UEZTSTBON2N4ZDQvREU4UzBlMHBqTnpnUExseURPa1RaRWdiMXlpTUpuRUt5?=
 =?utf-8?B?SnBxOGNmSnVHeGFJOU5KVEpUdkxUOXJ6QnRtY1VNSGRoaVdKSmVhblRHVzI1?=
 =?utf-8?B?UUQwNklXTzhWV0pSK0VBMXRUdGowNFRPM2JzaXprYUtRN2Rkc1gwdXpNUU9Q?=
 =?utf-8?B?TktKZjRtRHRQWUQxRzJ5SnpaTWxvNnpBMWN2NzJ3cWJZbFN5WnlQVnh0a1pw?=
 =?utf-8?B?OEE4UW9pcnQ5akhidlBDUGg0ck9Kc3V1UGpPL3ZJOE0vRk1CdkVQTkVhaHBK?=
 =?utf-8?B?bVRlWVc3b2oydzQyVFl3R1dTeERLR3dYVEpHdUxxN1E1Sk1UciszNWMvZHB4?=
 =?utf-8?B?TTJyR25DSTF1cnNuK1A2Z2ZBd1hqK0MyanoyMzN5TEQzWU5uYUlTTFNnTGZR?=
 =?utf-8?B?MWhxeDc4WS9Hdm9vYVZkZklVS1N4cWNjdDl1V3V6SHhCSDlTRkRvSG9jMXV2?=
 =?utf-8?B?Y2RXemhoNGRiRFU0Y2hzSFc4bFpOVWF3MVVuc21tU1JUc3g0eFZQc3lQeVJl?=
 =?utf-8?B?Q0kwMGhQZmpKVGFTUkEyS0o5OU1TRXRVeERlRlZLbGdKeW9IeVhnYUVyT2oy?=
 =?utf-8?B?TVdtQjFzcTJ1bC9tc2NSSGgyb3FyNVdKTUh0TmRKb3lYalFSa3ozVlp6KzNU?=
 =?utf-8?B?MWszeHhPY3dzcnJFcWF2TmtiLzNETXhUdlNkQmhWaDhiSHhWWFdkV2RaZEx3?=
 =?utf-8?B?MTRaK0dFYXhlNDNsWENWTzZjWW0vMnBSZCtqZ0UxeWJ4ZVhMUzJBdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d0f811-be2b-4bc5-bd83-08de68c9bbe9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 17:27:58.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShZYJWKY+fFbpEIz8KxdFbjqE0ef9ziKApKzKB3aD52jJ8+POfL8gTUrvQn2dyR+bs4ihNVhRwceGISpT68rVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9487
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258136-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[45];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,lists.osuosl.org,nvidia.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97A3C11DECA
X-Rspamd-Action: no action



On 08.02.26 13:59, Vladimir Oltean wrote:
> On Thu, Feb 05, 2026 at 05:54:08PM -0800, Jakub Kicinski wrote:
>> FWIW my feeling is that instead of nickel and diming leftover space 
>> in the frags if someone actually cared about growing mbufs we should
>> have the helper allocate a new page from the PP and append it to the
>> shinfo. Much simpler, "infinite space", and works regardless of the
>> driver. I don't mean that to suggest you implement it, purely to point
>> out that I think nobody really uses positive offsets.. So we can as
>> well switch more complicated drivers back to xdp_rxq_info_reg().
> 
> FWIW, I do have a use case at least in the theoretical sense for
> bpf_xdp_adjust_tail() with positive offsets, although it's still under
> development.
> 
> I'm working on a DSA data path library for XDP, and one of the features
> it supports is redirecting from one user port to another, with in-place
> tag modification.
> 
> If the path to the egress port goes through a tail-tagging switch but
> the path from the ingress port didn't, bpf_xdp_adjust_tail() with a
> positive offset will be called to make space for the tail tags.
>
Jumping a bit late in the conversation...

We were recently discussing this limitation when trying to add growable
tail support for multi-buf XDP buffers in the mlx5 driver (Striding RQ
mode) after lifting the page_size stride limitation for XDP [1].

It turns out that it is quite complicated to do in this mode with the
with existing frag_size configuration...

The issue is that the HW can write a packet in multiple smaller strides
(256B for example) and setting rxq->frag_size to it would not work for
the following reasons:

1) The tailroom formula would yield a negative value, as pointed out by
   this series.

2) Even if this formula would not be the issue, frag_size currently
   means that the underlying storage of each fragment has a size of
   frag_size. So the number of fragments would explode in the driver.
   That's a no go.

3) And even if we would change the semantics of frag_size to mean
   something else so that the XDP code would use frag_size as the available
   growth size in the fragment
   (tailroom = skb_frag_off() + frag_size - skb_frag_size())
   we'd still be very much in the "nickel and diming" space with less than
   256B to spare.

4) The only sane way to do it would be to use a large stride but this
   would kill small packet optimization

So +1 for the direction of having a helper allocating an extra page from
the page_pool instead.

> I'm not sure about the "regardless of the driver" part of your comment.
> Is it possible to mix and match allocation models and still keep track
> of how each individual page needs to be freed? AFAICS in xdp_return_frame(),
> the mem_type is assumed to be the same for the entire xdp_frame.
> 
Wouldn't the allocations happen from the page_pool of the rx queue
so the mem_type would be homogenous. I was initially worried about the
cpumap case but seems to not allow tail growth (frag_size is initialized
to 0 in cpu_map_bpf_prog_run_xdp()).

[1] - Disclaimer: XDP multi-buf fragment growth is still supported for the
      non Striding RQ mode.

Thanks,
Dragos


