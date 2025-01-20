Return-Path: <netdev+bounces-159824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03580A1711C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B77C3A58F5
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673D6149C69;
	Mon, 20 Jan 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rT/V+7wT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E117E4;
	Mon, 20 Jan 2025 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393356; cv=fail; b=XXqJ2J5kwKUyNGQN0OzwtHAQwtDJqAM4pNyZhn+G4Av/OGZEOYugDiWae6KIIipXyLaxo9WayITW0uetywutyArycz9gDNlXI9PAUtMkNyaynrgMUaGwKxTjBerwFG5GOlGCWRI9lUbvX0ag3AZWbMa5tsvrUiHqoTs612qn0tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393356; c=relaxed/simple;
	bh=xZtbCMShnfp+k3+lj9Ptie3rLpJZ011f9xVj3ZKiRRM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oIz/4xaSecygCN4mEFtMEjgDqllzTKaqkt72QP3QlNmHikaCyfir7DrrtS3NKDHpLHCPsXpQOL4Tvmo72Wkaa153/zYtB9xJhozhNPLyw2Ukmc/IsaFII2oUaChjgy7CXK6lwYmU0WanxGFnrkL+bCjg1D9DjZH7ZoG0RYxNW4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rT/V+7wT; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5d/zrp2b+lIOPQt4+Q9iXD2r/egdSkRNzvzYug+FhC4TLY/o5YuahmZcIAvvndlet3mEG2Qzixou8bLvV/Qsm+DzKt8f2c2NDwGHFfAwwow9+pkxsSgInZw/+j9zrwy6bUFMAsM2bGUTePIsl1zIfZm5FWyAOuZZRvTxYUPAPvTE5GjXVadHhWf0ZX5xQF/V95lcf20JyyuQ6oCBPQ0Haip0W6s3fBAftYSyQjUBrakOfwl3O/0tQZQBLim6Kzge0slCWKQP3mwVfGdcjzXEBg5E1Ao4iwWIBL2t2NoPNuBiolMgii/bS34Wvtq2VTGGDuocGdtcXfdtsm2unOb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whAnBRvpJwfZDGMxq0/1YsBhb5dM++fO44NWvyc/pgw=;
 b=WqYIuLqxn9vYS6fI8m1VFqeYAGzb43pRH8f1IFos6W+uNh9D4XkvdrjJ623apbLgNzqnrCnMbph7q8CwL5djyAzO+zF6Xoazpu8+fOlMIr9VWNRgyaHR7MdLExVZlsFzrXpllydidKRzmsZxnN93gff2cEgbOHYkeLW2MBD0xGlXoqKKQDa7+vLhw4Ly0JJ/FSDQgoXgmMPUcuTuN9Wdcy8q0H2VsCxcYD5grSfqYi+UdGrQe2wpgNyRoldXpBFRPWO602ke4e6/FTbnr4GHt12pf63CmmYNPIfJxpjVUBLuzS6PlmN2+bF9ZNVOMP0xbXMXCPH/MuL2xJ70cp3BYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whAnBRvpJwfZDGMxq0/1YsBhb5dM++fO44NWvyc/pgw=;
 b=rT/V+7wTONge2+yCnqTwtwO6f5USVQRgFdYUztVquasEZ2wMHdg3RLrR1q1cB+rdO4y3/ZeCpq5jhR68j0bPP9s1dGTa8oxj6iZvHjp+H+6v+KGbBON9hiy2VPfwjdaYv2VKEWv6UKE8dJ8fve7ZcJ8GmX8d5EohUbrcIr9p3LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 17:15:51 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 17:15:51 +0000
Message-ID: <9a18b887-dbff-d2d4-1446-8f327fd9777f@amd.com>
Date: Mon, 20 Jan 2025 17:15:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 13/27] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-14-alejandro.lucero-palau@amd.com>
 <678b11ada467d_20fa2949b@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <678b11ada467d_20fa2949b@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVAP278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::24) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 98f0ca23-713f-4ac2-a390-08dd39761707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJVOHlwY0M2U3l0Q3BnVm5ISmJQbE5kaUIzaU9pTTNqa0phdVozRXFhQUFF?=
 =?utf-8?B?am5WRmZSSDhEOGpOM05HVGNkc28zVXA1YUIwUkViVGgwKzF3YzNRemxKaEVq?=
 =?utf-8?B?NEZuTFV2SkhORDczTmhtWmNsL2N0bk96M0xWMFN2V2xIUVNvTlJnVTdlNHdn?=
 =?utf-8?B?N2M0OXRHT3NkaW8vNWdCYXJDRHJwdldrblQrYXhlb1pSUmNhbzVQdUIvamNK?=
 =?utf-8?B?QnEwRUFYSW5DZGNEbEM5T3gwV3R0SEphWUdYVHJVbG1wVmxvR1cveVlKMTVr?=
 =?utf-8?B?clpmRlF6M3RLSTNxSHBlYXJ6MmVQYjV6K0Rud1g5Umw0ZGEwZkc4QjhNcEVm?=
 =?utf-8?B?bVVHQVNpck84dnZZZmlDOHAxMy9EbjZqRWZ6VDJGZHBFKzFoMGZEcFhGeEdr?=
 =?utf-8?B?bUdHZnE2V2plZEpnVHJhTDVIajFWUXZjNkxKaHo2dWZIRWZFS3JxWWp0UWhB?=
 =?utf-8?B?OTVuUmMySHJvOHpaQ1h0Z3ZKV25QNXhvMHNhVkVjTXhVcUlzSFR5d0QrYzZk?=
 =?utf-8?B?dGptdHJqVnBLK0FZR0pUbEprblZobXAvWDM4bEpFZXVjTWZJNW8yZUV5TVFH?=
 =?utf-8?B?dDZ2YTM1QnYraVMyMHRZZEp5d3ZSZkNUMXhtcGN0a1JCd09LVSt0MEZ2Um9V?=
 =?utf-8?B?MEdPamlMOS80a3Z5ODhTNnRHeTNFUm02Z3RzSDlzNE9LdFJ3MjZSa2dLOWN5?=
 =?utf-8?B?UDF5dWlHREFnSThqeUx2TnNYTVdreVhhMUdHcFFDZTF1bG5FSWRESUJZdUtI?=
 =?utf-8?B?VW5xTWt1a1VoUllGcStmcE9DSmx2NHY5dUlHdHh3TUxiOUFoMHhMQXlkRVFT?=
 =?utf-8?B?NnNNU1hKckpMUVo0MWN6ZFpUcHcwd2IzNjNkZW9UWFJ3aFQvMitLdUowYnVP?=
 =?utf-8?B?U3YyUTlNOWROU0JqZTYxQjBRS1dHK2lvNnlxUkhhNm9oSUV6em92T00xQ2gv?=
 =?utf-8?B?ZW5wditRblZlMURSR1cyYzNNaDJPZlF6TGRtRTd6cXBuSWFZUDlJWmcvZTVQ?=
 =?utf-8?B?Ti9GZWRLRGtkU2x0OFg5OHFYTXovbEU1ZXpsVTFRVTcya0hoczErRU1xUlMy?=
 =?utf-8?B?SU5Xd1JZZVBjOHo2SU8wZVhoUFlrcFZXRXozOWZieUFmMjhNVW5QZDNKVVNp?=
 =?utf-8?B?em5ZcWFlYlhoM3kxNHlUY1BVNFk3SmtaUnAvWHg3RFh5bkppQ0xmUUszUDd1?=
 =?utf-8?B?Ukt3SFZBOEV5VmIvOHQrMm5lRVl5UndXclFoaEJZdnBKdUZIOWZIcmEzWjdH?=
 =?utf-8?B?Z2Vjc3VicXV0aGxzUWJqc3NmMjJSQXU5NHpiOWhVTlBPZDVxL3pEYlJJRUZT?=
 =?utf-8?B?dWJiYTVaeWZ1Y0VDa04zbk9NVG9KSG5IQm5GSkJZN1hHQThEWEYvbHFUenht?=
 =?utf-8?B?ZGtTellyQ0lYNG1GZnhOcGV0ODFQTmhpY0xaRWdPU0VGbWc2QWJGOGFtbndh?=
 =?utf-8?B?T29BSDNsL3EvMStyQ0RaS2RBeDNsU0diTWdCelhHNkNvQUc4TjFpTzBWNXNO?=
 =?utf-8?B?MytOZVhlREZ0Q1JzQk41Q3pFc1YvSE91Z1k2TWowNm5PdzBzdTk3dG9zQlpr?=
 =?utf-8?B?Y0ExVDF2RkFwZFE0eW5mSEFrMFFDamtDVHhIa01SNE5HTXQxVTdpck1tOTU1?=
 =?utf-8?B?RVVmV0ZiWCtreFBvYmQzeWM2eGJ3enhCNEN6K0d0bHFpMncreDZqQ1Q4NGRx?=
 =?utf-8?B?Wm9RWGRpZWVGVmhqVXJWanFuNEYwNk9LVzY5VkdnVGVYczI1endvT0EvZllW?=
 =?utf-8?B?QUJZUXVHbHB2bUg0Z2E0RzNiSVlDbUV4NjVtRVVHRjlPTFlaS2FGNXd4OGZX?=
 =?utf-8?B?OWYwWXdFYkt6WTlDTmJKdUtJQ09QM2dla0JxVXFsU1pRYU9nbFBHd0JmNmFJ?=
 =?utf-8?B?dzduWFZFM3NxdFh3N3RjMFM0SGdJNHBmbEhxYlFNQ3pIbjQyOVRjb0xlSTVX?=
 =?utf-8?Q?RYcnIeUbsqo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skt4Y3NEak05UFVLRzMvaUwyZnJ0Qm1nMlNYRDJvQzhBWXFpalQzY1VjWUxG?=
 =?utf-8?B?a0hqUEw0WVQrTFdNanpZRVVWL3FoNVRNSWIxYmQ3YjBHb2Q3VStkZ3pkcnRO?=
 =?utf-8?B?dHJwbXI2UHB1cmlQMGttMUFyNDZaVFc1c1BrQ2lPWjFlYkpzVitpa25HK0Vh?=
 =?utf-8?B?ZmhwU3VXeGtMZW1qdFl1MWNyYTUwcTgyK05NelJkOUlmWXBCMThZYUpBSDMx?=
 =?utf-8?B?K0EyaXFHOTcrbTFKVGdidG05ZU9jeXJoNUNpU1ZTbU85Z0RDNEt0b3FnbDB2?=
 =?utf-8?B?SnU2OG9yMm5hbWJqdC9LU0ZZRUhzaEg2OVFoWXhpRElPeHI3ZVRwWUNhQ0dB?=
 =?utf-8?B?WEU3b1YrM21hNjgvcS95RU9PUzdUUUJUSEZGVTFoaFhxUkY1WXdhZVVKaVRr?=
 =?utf-8?B?VGZydElyR2cwOU1iUzY4TzdNR1IvdUFZQkhKWXAwbjhmNzZXU2pqenU2VnY5?=
 =?utf-8?B?ellPck9jeUFycmpJSnlQbmhuVUxySmdCdFJ3VXNvdjhRcEU4dHB0M0ZFQTAx?=
 =?utf-8?B?S01OMEluVGZIN1BtQkthbk40SWx5WlM3b3NGN1I0T1pqdnF2YWpwNlV5eWJC?=
 =?utf-8?B?MUdjK2ZMYWxpK2FoMWtLTjdCd0tDbmlpeW1UdFhYWGtJUFBQaVA1b3NpZVNR?=
 =?utf-8?B?UFpjUFp4QXpSWU9jWSt2UGRXR3JSOVlRWDdOZFNteG9pQWEyZThpWEZPY2Ry?=
 =?utf-8?B?R0xxTW9nM3JFZ0FIR2RoOFdSelNjOHFTU0I4M1RCWFlGR1pZVmV6Zm5rWGFx?=
 =?utf-8?B?VVkyVG1kdHRwNGpucFpPV1F1MGtWRk03NTROa1NsRjRiOUhscGg4YzJxeDh6?=
 =?utf-8?B?SVhXZVdvNDFQd1d1QnY1UTRyVko4a1FjRG02ZXJIa3lCOHlHbHFJNzFRbkYx?=
 =?utf-8?B?V3hCZEFzKzg4OHVxYVZpNjhUTjY1ejVJRm1tTkNxS3cyWkt5ajl6d2ZhMkU2?=
 =?utf-8?B?K2dJS3pSY05HRHFERXYrWDllZVZwZU9PbWNRZHRENkxwY0J6ZUFyWVZpdktK?=
 =?utf-8?B?VUdBZ05CZERWVnNETWVQU0VVeDFrbmRNbmNzMVc2dmV1VDNyTVBaL0ZHRDFx?=
 =?utf-8?B?RGQ5RGtFTVN3LzFmR1M0bVVxVnRweFNRVnMwWW9ZM1BMcVZMaCtlZFd4WUNj?=
 =?utf-8?B?M1p3ZXBwOHp4ekRvbGxVS0UwV3dkakUxbmxFOWpmRG1xc1RGMnFOVExBZHdD?=
 =?utf-8?B?ejArbVEwZ1N1Uk40MUtnN1paZzF4ZkRTYisvaXNVNnYyMjBYZVNOWXJ2ZENP?=
 =?utf-8?B?ZTA4dkUzeFhGeUs2Y2d3NldIMmhvWXpRQUNJOVlFWFUwWnZxWnBXakpiVHNN?=
 =?utf-8?B?Q003aVhBMGZJakU5YkliNlJjeVNUQWpWbVplVmlXemoyRXV4cnpiVlJTQVNL?=
 =?utf-8?B?Y2tQSnBHSHBCZUNQcUNZZytZL3NpYldoSHN4NTNDUUdQU2dLZVk4K0JxUGF6?=
 =?utf-8?B?TWtzYkJuaXJWRGRXWXY2ckNUcWNKTzVZYUhzeHVEZ1FPK2VQWE1PbjFpQjhy?=
 =?utf-8?B?MmJ4K01jQW5TaXdLNmpPdWNHL2dwa29aR2dFOGVZUGFwSVhxRW8wTy90Z2Rp?=
 =?utf-8?B?UXYrSDh1RXJyZER6eEFwMG92Vzl0blo5M2lBaVRHcU8vRUVNa1VQM2pDcFk4?=
 =?utf-8?B?b2NxbFFJMU84b3RYY2lUK2MraWFjY1VaeDgrVWtWRDNvTDlOV25PMDBSNEsv?=
 =?utf-8?B?NFppWUVCN3hkbjF0dFJvMkpIdk0zeHBxbDJRUE8wN0hVUzh5akM2ZEM4NnZX?=
 =?utf-8?B?bXg4SVVxL0NxcExqaFphTHpaWjZyaUQ4R3c4TlY1YTlvc1RaeTBPdUZpUFJB?=
 =?utf-8?B?SGJJNDc4U1JKemVHOVhYdkNFRFRIbzdhQ0ZHeGFsVUhNNS9VVHF0TDdsdDcy?=
 =?utf-8?B?a0xZZ294eFBoUFo4dlo2K0JUb2lpNy9ZUU1TeDYwRkJOL05yamhjVEZ1cG4y?=
 =?utf-8?B?bnFLM2xPN01yMXRiUWpveHpPTUhrMGlDRndXNkJydlU1eFh0NnhQb1dRNmR2?=
 =?utf-8?B?VXh6QUZ1a1JGRDhQdUdkM0dDbUFsSk1pQ2huT0RUeVYzNUh3a1pEcnppdTR6?=
 =?utf-8?B?QWp0TGFBMVlWUE5uWUZ1MjhibDFuWkNzUktLZzhWZlp0QkpROGZGbUswVlpJ?=
 =?utf-8?Q?N4hIMocPXJY+Nd/Rb9REMoaRT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98f0ca23-713f-4ac2-a390-08dd39761707
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 17:15:51.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0yMEr1wvPwrdAriohjlYqW2D2CNluAFniAL94hgrxMt5d4RrGz8XzrUqnuolfa3qzXU/IPdzjpqgsTrTnXpe4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208


On 1/18/25 02:27, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of cxl_memdev_state.
>>
>> Make devm_cxl_add_memdev accesible from a accel driver.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/cdat.c   |  3 +++
>>   drivers/cxl/core/memdev.c | 14 ++++++++++++--
>>   drivers/cxl/core/region.c |  3 ++-
>>   drivers/cxl/cxlmem.h      |  2 --
>>   drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>>   include/cxl/cxl.h         |  2 ++
>>   6 files changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
>> index 8153f8d83a16..c57bc83e79ee 100644
>> --- a/drivers/cxl/core/cdat.c
>> +++ b/drivers/cxl/core/cdat.c
>> @@ -577,6 +577,9 @@ static struct cxl_dpa_perf *cxled_get_dpa_perf(struct cxl_endpoint_decoder *cxle
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   	struct cxl_dpa_perf *perf;
>>   
>> +	if (!mds)
>> +		return ERR_PTR(-EINVAL);
>> +
> The references to @mds in cxled_get_dpa_perf() are gone
> after the DPA partition changes.


OK


>
> If an accelerator has a CDAT it will get qos_class information for free.
> If it does not have a CDAT then I wonder how it is telling the BIOS the
> memory type for its CXL.mem?


AFAIK, this is not mandatory, and the BIOS will look at CXL DVSEC for 
finding out. So no perf data is mandatory.

FWIW, our device will export a CDAT via PCI option rom since we have to 
avoid the BIOS doing things we do not want to like testing the memory as 
some BIOS seem to do in some debug/test mode, and to advertise this flag 
we discussed in v1/RFC for the kernel doing nothing with that memory 
when found in the HMAT table.


>>   	switch (mode) {
>>   	case CXL_DECODER_RAM:
>>   		perf = &mds->ram_perf;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 836db4a462b3..f91feca586dd 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -547,9 +547,16 @@ static const struct device_type cxl_memdev_type = {
>>   	.groups = cxl_memdev_attribute_groups,
>>   };
>>   
>> +static const struct device_type cxl_accel_memdev_type = {
>> +	.name = "cxl_accel_memdev",
>> +	.release = cxl_memdev_release,
>> +	.devnode = cxl_memdev_devnode,
>> +};
>> +
>>   bool is_cxl_memdev(const struct device *dev)
>>   {
>> -	return dev->type == &cxl_memdev_type;
>> +	return (dev->type == &cxl_memdev_type ||
>> +		dev->type == &cxl_accel_memdev_type);
> At this point the game is over in terms of future code that trips over
> the assumption that all "is_cxl_memdev() == true" devices are created
> equal.


Yep.


>>   }
>>   EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, "CXL");
>>   
>> @@ -660,7 +667,10 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	dev->parent = cxlds->dev;
>>   	dev->bus = &cxl_bus_type;
>>   	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>> -	dev->type = &cxl_memdev_type;
>> +	if (cxlds->type == CXL_DEVTYPE_DEVMEM)
>> +		dev->type = &cxl_accel_memdev_type;
>> +	else
>> +		dev->type = &cxl_memdev_type;
>>   	device_set_pm_not_required(dev);
>>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>>   
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index d77899650798..967132b49832 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -1948,7 +1948,8 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>>   		return -EINVAL;
>>   	}
>>   
>> -	cxl_region_perf_data_calculate(cxlr, cxled);
>> +	if (cxlr->type == CXL_DECODER_HOSTONLYMEM)
>> +		cxl_region_perf_data_calculate(cxlr, cxled);
> Per-above no need to worry about @mds reference in this path.


I'll adapt it.


>
>>   	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>>   		int i;
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 4c1c53c29544..360d3728f492 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -87,8 +87,6 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>>   	return is_cxl_memdev(port->uport_dev);
>>   }
>>   
>> -struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>> -				       struct cxl_dev_state *cxlds);
>>   int devm_cxl_sanitize_setup_notifier(struct device *host,
>>   				     struct cxl_memdev *cxlmd);
>>   struct cxl_memdev_state;
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 2f03a4d5606e..93106a43990b 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -130,12 +130,18 @@ static int cxl_mem_probe(struct device *dev)
>>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>>   
>> -	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> -		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_inject_fops);
>> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> -		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> -				    &cxl_poison_clear_fops);
>> +	/*
>> +	 * Avoid poison debugfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (mds) {
>> +		if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>> +			debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_inject_fops);
>> +		if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>> +			debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>> +					    &cxl_poison_clear_fops);
>> +	}
>>   
>>   	rc = devm_add_action_or_reset(dev, remove_debugfs, dentry);
>>   	if (rc)
>> @@ -219,6 +225,13 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>   
>> +	/*
>> +	 * Avoid poison sysfs files for Type2 devices as they rely on
>> +	 * cxl_memdev_state.
>> +	 */
>> +	if (!mds)
>> +		return 0;
> It turns out that nothing in the poison handling path requires 'struct
> cxl_memdev_state'. So rather than key this rejection off of @mds ==
> NULL, I would prefer to find a way to make this optional relative to
> data read from 'struct cxl_mailbox', or 'struct cxl_dev_state'.
> Conceptually there is nothing stopping a CXL accelertor from supporting
> poison management commands on its mailbox, it's just unlikely.


Right. This is the easiest path for the initial type2 support SFC 
requires, but I agree it should cover other options as well.

I'll work on it for v10 and if not a major work, I'll do it.

Thanks


