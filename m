Return-Path: <netdev+bounces-159851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE39EA172D9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 19:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7AF188587A
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5E71E1043;
	Mon, 20 Jan 2025 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PyALCd7x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E880BEC
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737399321; cv=fail; b=nXf4unI/hv4ed07GSh1ywaaV9LmE7aLBv4UQ8c/IptK4eVIlZfrcufg3LwhuaSGzJVRWT8p0BMSsF9aJy9a2fkZar9CAbWD4E8Mo2xDnVVdnjIl+Yji1Nz3VrZTdMXeCPWEINomuwyAUX8th/u2sgUrCNYrOMiooAAkQq+F4SIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737399321; c=relaxed/simple;
	bh=bYZt/vwhlkJ/HmX+irzRMrHP4866Yc+5Oyjp/CplfAo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cY1wcKpFzp4iB78om0jE8XlGkevHMONNy2TX487swp7HJkOhxvyC/LYJW04IPTxYoJBl6sn1WunBQF6OccpM19aH9+5+ZRHGkemagVdm84AcfMOtSTpSg/HwX9EsAOV37xoAp1rh8IacfBaSu1Vaff38Zdda42AyqfHLNH5TDoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PyALCd7x; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGIGaZorRXERuCVk/FxSo6m4NhUmwlH4QD5Z7zvsqrYODEUpemh04NBacskOyqKgEX0YuXhrooLI8GrKVLveYrxpnPxUl8lIWS4DiJGYgbQEVmCeYypCtSliYncFuYZWwKeTEPL4V0G4VwcbmQrXpHY5KahI6ymSfY/nAjfC788dUlBuMKZtWdbhJn9f1lqM5Xgyc6eAZE8Su4XGFHM/B3aF5k4pXVdrQ/oL4g6i5L+CwAmdxyxqlpvd8m95G1yH1E42o7GHbhydrasanRmR0oCDzpK2GHHHjqyFb3pdwK0eksXhmmRRCmMTCD3HtifTr1QCuEGoOSHiWCBWj4uH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2f5wuQcdUFq4VpBjBLBzp9tj32jUja5NniYkFyYeQo=;
 b=e+psDICkZMu6SLBADD1eKoue/MtFuCNh7Nm8ii5NVqpgrEtfElNCOIgnixTp8T4btcZYT1w1DmAwjKcUZrARtLSa1IxuiI+EX69w+lKlXI5kIpIQteb2DgXz2UKkVYooiCASNxZxAzfLFXTBiweoMHw004OrJPB8OzCqPeJBJhUlIok5O9/OgpPczVialNH7BxFwQh8XDVqbczwmgDZmBYIt3h5V7t/gH3QXM7Tm1S7NgJ5glmv2d3zeXK0iHWZ50wg0KJd/Z4hXXqk/uR2ImyGxwJPBkG608M849wdYafv+WfRuwx0JmeHVQkk3eB78585PUIELuQKe0CMIR3GzDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2f5wuQcdUFq4VpBjBLBzp9tj32jUja5NniYkFyYeQo=;
 b=PyALCd7xSICLL2mwqPn5tnSjnp/dZgxXdI1mCzhFfbY4aU5a/uyr9Nv24Uqq5kMitx1723Zw4htzkucCVHchkYcYpKKFk7i5rrHNZAK3uctkWud0sG1hsGazLMCwiR6Wi1KEzvCTt10r2rEi6NtWPNjWRDa4Gnek54ANTYrMnFKeO9nnLUrY0zkF+ukyf2LxLuLEWhy59XIjI/9K/I6hM4rbyOH78l5aCunX4MUqXjGG9EUvDw7+genLJA60iBrIcDBZICwg23C8QrOW5UBPXLM8RjQGw3NyHdZTuPX/CJ+xVxf0ZxAxYECb9gDTZQg4qvke4SJe1kes02DkmcD5Kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Mon, 20 Jan
 2025 18:55:13 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 18:55:13 +0000
Message-ID: <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
Date: Mon, 20 Jan 2025 20:55:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in
 (un)?register_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com>
 <20250116025435.85541-1-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250116025435.85541-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0045.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::33)
 To SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: aa864097-0119-422a-6acd-08dd3983f8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0UvVEtRUGgrN2thQjdsSXlkQm9nbkxHM0Z1RDN6RnZUSU5jQ1pIaVh6L2t2?=
 =?utf-8?B?Rk1hYnZxRWZORzV0TzJFTHZSVFVZcHF2NnF3ZzVBTW13TWhRT0pZNmxteC9B?=
 =?utf-8?B?SHA5TjJmQTZaVjZqKzlhSGlCZmxHTkJnRm53R1B5L2l6ZmFoRU5sZWVLcG91?=
 =?utf-8?B?QkNXV2YzdFptRE9GZE80RmJobnZvakYxZFhxb2wrbkQ5OWtCSHlWYWZrWkRR?=
 =?utf-8?B?RllVRndaOWJEQUlzdjFJaTNPM2pSQXQ5bncwQmNmNWFKRmVWUmUwUVpwaWk2?=
 =?utf-8?B?MUZvblAyeWxJNGwvS2FUcjZXSHpBcGJTWGdqYkNsYWZxQm9ZcFFSRE55MUR6?=
 =?utf-8?B?RFZPeEhUQm5EcVduN0RLcjJEUWxaVDZUaGhVeTBON2h3cVF3Tzc3aHNETllX?=
 =?utf-8?B?em90Z2UyaHFEekVoRTlyQitZT1JkQVAvcUxrKzFqUmxNV3crTENYOVB1MG9Z?=
 =?utf-8?B?WFpuNUdhWFVkY21ad3R0cllJR3lwY3VIVk41aVNkY0dCS2lvaDFxTHFxR0JU?=
 =?utf-8?B?U3FVVVhkbXZ5VjhycERlT3UzV3lxZXVNRnNTM0JmdEp6TU1PNnVCTEZNd0lL?=
 =?utf-8?B?eXZlVWlKVVJLb3Q1MElucWZRWVcxb1ptelAvalI5c1phSjNJeGVqYWR0WnpH?=
 =?utf-8?B?Sm04QVhLMFBUc0VvUTlENHZ5UVl5VThzZXltN0cyOWlNYldQUXJkcFlYRzR0?=
 =?utf-8?B?czlYVWFnRDFDTlc2TVZDZnJTR3Jibk5LYWpkc2xPcG9RSFNyeHUwUmpOOG0v?=
 =?utf-8?B?ZVlpOXE1VUZybnZiZXZmQ3NUK0ovWHdBelExSjhkUFprVzhzS2hWUnZWanNp?=
 =?utf-8?B?elIxTkcrU0FYVTI4bVhoWGZLRTVqU1NGNWYxMjNML25rS05FTUNya05EVUNG?=
 =?utf-8?B?ejZ1d2V1dFlwM2dCdDE1Y3QwdWtwTDB3bitiMGZYS2pRSlRFbTJ4TjZ6Nkhx?=
 =?utf-8?B?d2hOUCtTSTE4dm5hcEcwOUtFRmkzU3g3Y1ErZkFpZzdCWWRNSVV5eThUeTda?=
 =?utf-8?B?L0I0cmxJT29CQjNsdC9PRDBaRzk5TjZuOTJvK2ZSejNtUzdMRElGLzVEQ2ZV?=
 =?utf-8?B?WHp4Q0RIWml5Z0pNN1lpRTdzWWZ1TDBjUlRrNFY1VGtoNGoyVjg0MW1mNkN6?=
 =?utf-8?B?YlFzMkxWU2M1R1V6bVp5NlpEVUV2WmFVcGczbWl1aHRQcnlNOGRXTDA0clkv?=
 =?utf-8?B?Tm92cDR6cTVZNTB6TzlsamRCRkw0VStrWUhRZFJjVVdzNWdLNWhGalVtTW1J?=
 =?utf-8?B?LzlmK29ZWVlKYlZTNlFrbjZGdjBtMHBwWGRHVGpYUmFJcFlmVnBtditaTEhK?=
 =?utf-8?B?akErYVBMVW5aY2s0WGRqaitabUxrQXkrN3l3ZnY0RTVSS3lVVUlKZmNWdWlJ?=
 =?utf-8?B?WUo1ZjJtd0lOZ1BHazkvbGF6L3RubWk5RGh3WDhzSkN3dlRMMnZNS2JMRU5i?=
 =?utf-8?B?UW9iaFJLVjFMclFpeEEvS0I1bEEzN2lBK29sTG5lREV4dENveDhDWFFmNHN2?=
 =?utf-8?B?b1dmOVY3Y3BldzExd0pMTE1HS2hiLzZSMzBUSjNickxiK25Dcmt0by92R3dO?=
 =?utf-8?B?VXg2TVEzaTJQMzlxMGxtY1JETU4vc3BzZEZEd0E3S1hiU2VtZVFNaFFQUHRF?=
 =?utf-8?B?YVdTcldRRktCM2FKeGRBTHQ0OStDekx0c1lud3RoRHFMKy9oeVpVMlB0TFQr?=
 =?utf-8?B?cThzbXU2OUUzTGRGMzNVNldmbXVYdUZDQlIyeHVHbU5HY2trL1MyUXBveEQv?=
 =?utf-8?B?VFA1bEpiNi9TSXRqSXk3NVJpM05VTFpBaGtLUW5IWkV4R0JydGZmRDlpZG9S?=
 =?utf-8?B?U0ZKdDl1cjJxd2FuVTNCd2tta09weUhybHZtSCtUK1hVU2lWZFNZRjM3VUpX?=
 =?utf-8?Q?Osvfx2zid/R8f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWxqNG13eDFnSlNON3NSVE05M1hFaVNzeUdPWmhpUnNsbmxRZ3ZWNE5KWDB2?=
 =?utf-8?B?ejZYdTdTWGxSdzZKdzVDeUJqQTUydThNRGRxWFR5eUdZR2FhZE13dnpWTEVj?=
 =?utf-8?B?ZmE3SVZHVnpNZS8rQ3paK2NUUnREZW12c2x4dSt3ek94ZWdOcGJCem1Ed1Na?=
 =?utf-8?B?WUMrV09UYUxxdzQxOHlacCtCZnYzOFlqdXRQWEtKRjN2azN5ZTlMZ1VFVzli?=
 =?utf-8?B?MUdMV3BUNDdKdDRQL3Z1cWFOMFlPTHB2M2hNeUo2LzhwMEhVTWczRmJwanBK?=
 =?utf-8?B?NXdrMHljR1JTRHBReEtyR3Jib2FHOEI5SkdUWFBJb1JUZndzK2dJQVE0ZUNr?=
 =?utf-8?B?MldlWWZQZG9WcWliMVE0NFhZcXcvUDk4eTk1RHB0TGU0TWQ5MmgrRVRCaURO?=
 =?utf-8?B?aVVoaXpRWG9nV3VSd01PdjFRRm0vM3FiTlFOY1NQbDhJYkdBQ1l3NFhUSUVG?=
 =?utf-8?B?c1E0TTFJaVhBSDlrdzRRMjh4VVlWRXZ4anB3YjBBaytZdnhzRUxCTi9rVmMy?=
 =?utf-8?B?WjlxMDFJZmpXekhFV1NlUDNlSVdLLzJGZVNBS2xQbkl4ZStzSzhnc1hyTU1p?=
 =?utf-8?B?YTZxS1FnY2NSZ0I5REt1dUdVUFFWc3p6SzNNaVJlREwzZGd0ZXB3VkRmVHRS?=
 =?utf-8?B?andEZ1hVOGl6VnFDWmxrSThydEhwVkl6L2VoMklkQ0ZVblhCUmp0SUhMa0Ja?=
 =?utf-8?B?OVlvRTNEeTFRcyt5NDNBVG9EUjN2R1lyTzhsOHpCSUMrZGdYb1FnUTdyaWk2?=
 =?utf-8?B?Rm4zeXl3MEhFTzRsVWQ4MGRZMUwrSGg2SUZFV0MrZXNyNElEWnlCTHZ1bVJN?=
 =?utf-8?B?WWVKbUdqU0VPMDA2S2lFQU45R1lSS04weHVoazc4SGxpczJJZGNKZVUybGdv?=
 =?utf-8?B?TGhia2lnL0UyNXYyK2dkdVFuaUJDUW5pM3BhcTN4cmNVRWhNdHoxVzRBQUZv?=
 =?utf-8?B?aUlNZFlqT3RuQkt5clRlL1A3RkVDdGdtUXRXWFVDUG1BczNzL08yczRVVjlV?=
 =?utf-8?B?SU1MdEFNN3RuMkhNaEdtQTNLa3BUVFlrWTc1aENNWU9Tc2ljQlladE91ZU5C?=
 =?utf-8?B?Kzc5dEZ2MUFuektwWHA4TFNUTTVKV2R2ajRxYjNlbDhuZVhxN0o3VnhZSk90?=
 =?utf-8?B?enFuNmpMdUxRQ2hZVWpqRWJQaXQ5LytDZEF2RGM1b3crWk9VeXRNWnRBRVVB?=
 =?utf-8?B?WSthYWRqY3RLdWhkSjd0Sk5uZG5vU05LeHVqdHBuZGxnQTZlR21tNkxLQWZ5?=
 =?utf-8?B?N3dVQjdXWml5elE2blhxM0ZQZVBCbUM3V0RsWXBvU0tWcmhaVlhDdDh5Rlo4?=
 =?utf-8?B?UTRTMHZkbXBCcHZNSXlDUkJiSnVUZk9vRDdhSTl1NENVNEUxeWZCdjVySDBL?=
 =?utf-8?B?V0FVYTBDQmtOdW4xbnFKKzR1cDdDQ2FZeEhVQkRoQU5wa1VOOTl0ZERrTjUz?=
 =?utf-8?B?c2ZoVk9lak1pbTBNbWVhbUhaQXdISUszaVlqRlZyZ2tXaHI5SFV0Qy9yUjZx?=
 =?utf-8?B?NWNLTm44Y2FXNGFubWFCV0ROMVZoeGxYcUFoeExiQnVsamtsY0M3ZG53SGlZ?=
 =?utf-8?B?WEx3ZTBWMlI1eWxuMTVPZnU2NGo2bVBiNnQrUzA1YmdzcUFyMDV6NHJFK0xa?=
 =?utf-8?B?ZG9wVnhqb0VDc0VTeFpKMnlPTlNTdU5xNzFSTll3bGJmeGV4aWJvREQ3VjZz?=
 =?utf-8?B?dlR1NytsOTgxSll5cDU1UDV3TE1PaTJsbWp5cFFOeG9QdTJRQ3JObGJxR1NF?=
 =?utf-8?B?ZUpVYmZvcEZqM2l4NSt6TVc2Z3hYU3RZby84ZEFiNnh5REtMM1RrWTdkeS8w?=
 =?utf-8?B?OWthMlJRNkJ2a2pVd085RFlQZ01jMC9odlJFWFJsT1l5dlVqd3BwVzNhTDR0?=
 =?utf-8?B?R0JiSzR3YklHV0JoLzE2a3ZQU29wMlFTR1ZwV1pGZWxNNjA3NlhwMFZ3a0lz?=
 =?utf-8?B?T2dvaWRGU2tkUjhtSGt5UUc0QnNURzlaRVZWVFNHanZTUWFHcTBWRjAzYndr?=
 =?utf-8?B?U0VjMzBMM3RzdTkwWktUelFibTVVNzA3TDJZWkZZdFJ6Q3JXS3RLdXNBdmMy?=
 =?utf-8?B?MWVnWHM4dTRIZ016RVF1akNmNW1kUE41VUVMck84RGl2T0U5S2tCSXJYMm9Y?=
 =?utf-8?Q?SDAveY8iWOxfcKN5YIBZlMWHy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa864097-0119-422a-6acd-08dd3983f8aa
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 18:55:13.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RYavzVNJ3RZVhl7KocMqrAgJkV1EjEghMXtpN+hAH4DL+sI0kQUqPpgnzmSXuTMzsHMHg6Ih/N2M0WhGvSpqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072

On 16/01/2025 4:54, Kuniyuki Iwashima wrote:
> Thanks for the report!
> 
> From: Yael Chemla <ychemla@nvidia.com>
> Date: Thu, 16 Jan 2025 00:16:27 +0200
>> we observed in our regression tests the following issue:
>>
>> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x22c/0x280
>> kasan_report+0xbd/0xf0
>> RIP: 0033:0x7f70839018b7
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> __kasan_kmalloc+0x83/0x90
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> kasan_save_free_info+0x37/0x50
>> __kasan_slab_free+0x33/0x40
>> page dumped because: kasan: bad access detected
>> BUG: KASAN: slab-use-after-free in notifier_call_chain+0x222/0x280
>> kasan_report+0xbd/0xf0
>> RIP: 0033:0x7f70839018b7
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> __kasan_kmalloc+0x83/0x90
>> kasan_save_stack+0x1c/0x40
>> kasan_save_track+0x10/0x30
>> kasan_save_free_info+0x37/0x50
>> __kasan_slab_free+0x33/0x40
>> page dumped because: kasan: bad access detected
>>
>> and there are many more of that kind.
> 
> Do you have any other stack traces with more callers info ?
> Also can you decode the trace with ./scripts/decode_stacktrace.sh ?
> 
BUG: KASAN: slab-use-after-free in notifier_call_chain 
(/usr/work/linux/kernel/notifier.c:75 (discriminator 2))
Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
  <TASK>
dump_stack_lvl (/usr/work/linux/lib/dump_stack.c:123)
print_report (/usr/work/linux/mm/kasan/report.c:379 
/usr/work/linux/mm/kasan/report.c:489)
? __virt_addr_valid (/usr/work/linux/./arch/x86/include/asm/preempt.h:84 
(discriminator 13) /usr/work/linux/./include/linux/rcupdate.h:964 
(discriminator 13) /usr/work/linux/./include/linux/mmzone.h:2058 
(discriminator 13) /usr/work/linux/arch/x86/mm/physaddr.c:65 
(discriminator 13))
kasan_report (/usr/work/linux/mm/kasan/report.c:604)
? notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 
(discriminator 2))
? notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 
(discriminator 2))
notifier_call_chain (/usr/work/linux/kernel/notifier.c:75 (discriminator 2))
call_netdevice_notifiers_info (/usr/work/linux/net/core/dev.c:2011)
unregister_netdevice_many_notify (/usr/work/linux/net/core/dev.c:11551)
? mark_held_locks (/usr/work/linux/kernel/locking/lockdep.c:4321 
(discriminator 1))
? __mutex_lock (/usr/work/linux/kernel/locking/mutex.c:689 
(discriminator 2) /usr/work/linux/kernel/locking/mutex.c:735 
(discriminator 2))
? lockdep_hardirqs_on_prepare 
(/usr/work/linux/kernel/locking/lockdep.c:4347 
/usr/work/linux/kernel/locking/lockdep.c:4406)
? dev_ingress_queue_create (/usr/work/linux/net/core/dev.c:11492)
? __mutex_lock (/usr/work/linux/kernel/locking/mutex.c:689 
(discriminator 2) /usr/work/linux/kernel/locking/mutex.c:735 
(discriminator 2))
? __mutex_lock (/usr/work/linux/./arch/x86/include/asm/preempt.h:84 
(discriminator 13) /usr/work/linux/kernel/locking/mutex.c:715 
(discriminator 13) /usr/work/linux/kernel/locking/mutex.c:735 
(discriminator 13))
? unregister_netdev (/usr/work/linux/./include/linux/netdevice.h:3236 
/usr/work/linux/net/core/dev.c:11633)
? mutex_lock_io_nested (/usr/work/linux/kernel/locking/mutex.c:734)
? __mutex_unlock_slowpath 
(/usr/work/linux/./arch/x86/include/asm/atomic64_64.h:101 
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:4329 
/usr/work/linux/./include/linux/atomic/atomic-long.h:1506 
/usr/work/linux/./include/linux/atomic/atomic-instrumented.h:4481 
/usr/work/linux/kernel/locking/mutex.c:913)
unregister_netdevice_queue (/usr/work/linux/net/core/dev.c:11487)
? unregister_netdevice_many (/usr/work/linux/net/core/dev.c:11476)
unregister_netdev (/usr/work/linux/net/core/dev.c:11635)
mlx5e_remove 
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) 
mlx5_core
auxiliary_bus_remove (/usr/work/linux/drivers/base/auxiliary.c:230)
device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275 
/usr/work/linux/drivers/base/dd.c:1296)
? kobject_put (/usr/work/linux/./arch/x86/include/asm/atomic.h:93 
(discriminator 4) 
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:949 
(discriminator 4) 
/usr/work/linux/./include/linux/atomic/atomic-instrumented.h:401 
(discriminator 4) /usr/work/linux/./include/linux/refcount.h:264 
(discriminator 4) /usr/work/linux/./include/linux/refcount.h:307 
(discriminator 4) /usr/work/linux/./include/linux/refcount.h:325 
(discriminator 4) /usr/work/linux/./include/linux/kref.h:64 
(discriminator 4) /usr/work/linux/lib/kobject.c:737 (discriminator 4))
bus_remove_device (/usr/work/linux/./include/linux/kobject.h:193 
/usr/work/linux/drivers/base/base.h:73 
/usr/work/linux/drivers/base/bus.c:583)
device_del (/usr/work/linux/drivers/base/power/power.h:142 
/usr/work/linux/drivers/base/core.c:3855)
? mlx5_core_is_eth_enabled 
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/devlink.h:65) 
mlx5_core
? __device_link_del (/usr/work/linux/drivers/base/core.c:3809)
? is_ib_enabled 
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/devlink.h:58) 
mlx5_core
mlx5_rescan_drivers_locked 
(/usr/work/linux/./include/linux/auxiliary_bus.h:241 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:333 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:535 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
mlx5_unregister_device 
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:468) 
mlx5_core
mlx5_uninit_one (/usr/work/linux/./include/linux/instrumented.h:68 
/usr/work/linux/./include/asm-generic/bitops/instrumented-non-atomic.h:141 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) 
mlx5_core
remove_one 
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:965 
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:2019) 
mlx5_core
pci_device_remove (/usr/work/linux/./include/linux/pm_runtime.h:129 
/usr/work/linux/drivers/pci/pci-driver.c:475)
device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1275 
/usr/work/linux/drivers/base/dd.c:1296)
unbind_store (/usr/work/linux/drivers/base/bus.c:245)
kernfs_fop_write_iter (/usr/work/linux/fs/kernfs/file.c:338)
vfs_write (/usr/work/linux/fs/read_write.c:587 (discriminator 1) 
/usr/work/linux/fs/read_write.c:679 (discriminator 1))
? do_user_addr_fault (/usr/work/linux/./include/linux/rcupdate.h:337 
/usr/work/linux/./include/linux/rcupdate.h:849 
/usr/work/linux/./include/linux/mm.h:740 
/usr/work/linux/arch/x86/mm/fault.c:1340)
? kernel_write (/usr/work/linux/fs/read_write.c:660)
? lock_downgrade (/usr/work/linux/kernel/locking/lockdep.c:5857)
ksys_write (/usr/work/linux/fs/read_write.c:732)
? __x64_sys_read (/usr/work/linux/fs/read_write.c:721)
? do_user_addr_fault 
(/usr/work/linux/./arch/x86/include/asm/preempt.h:84 (discriminator 13) 
/usr/work/linux/./include/linux/rcupdate.h:98 (discriminator 13) 
/usr/work/linux/./include/linux/rcupdate.h:882 (discriminator 13) 
/usr/work/linux/./include/linux/mm.h:742 (discriminator 13) 
/usr/work/linux/arch/x86/mm/fault.c:1340 (discriminator 13))
do_syscall_64 (/usr/work/linux/arch/x86/entry/common.c:52 (discriminator 
1) /usr/work/linux/arch/x86/entry/common.c:83 (discriminator 1))
entry_SYSCALL_64_after_hwframe 
(/usr/work/linux/arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f6a4d5018b7

>>
>> it happens after applying commit 7fb1073300a2 ("net: Hold
>> rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net()")
>>
>> test scenario includes configuration and traffic over two namespaces
>> associated with two different VFs.
> 
> Could you elaborate more about the test scenario, especially
> how each device/netns is dismantled after the test case ?
> 

we set up a network configuration which includes two VFs isolated using 
two namespaces (there’s also bridge in this topology), we pass some 
traffic between VFs. At the end of test (cleanup) we delete network 
namespaces, wait for 0.5 sec and unbind VFs of NIC.

note that when I extended the timeout after deleting the namespaces the 
issue doesn’t reproduce.

> I guess the VF is moved to init_net ?
> 

this should be the behavior in case deletion of the namespaces happens 
before the unbind of VFs.

>>
>>
>> On 04/01/2025 8:37, Kuniyuki Iwashima wrote:
>>> (un)?register_netdevice_notifier_dev_net() hold RTNL before triggering
>>> the notifier for all netdev in the netns.
>>>
>>> Let's convert the RTNL to rtnl_net_lock().
>>>
>>> Note that move_netdevice_notifiers_dev_net() is assumed to be (but not
>>> yet) protected by per-netns RTNL of both src and dst netns; we need to
>>> convert wireless and hyperv drivers that call dev_change_net_namespace().
>>>
>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>> ---
>>>    net/core/dev.c | 16 ++++++++++------
>>>    1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index f6c6559e2548..a0dd34463901 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
>>>    					struct notifier_block *nb,
>>>    					struct netdev_net_notifier *nn)
>>>    {
>>> +	struct net *net = dev_net(dev);
>>
>> it seems to happen since the net pointer is acquired here without a lock.
>> Note that KASAN issue is not triggered when executing with rtnl_lock()
>> taken before this line. and our kernel .config expands
>> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).
> 
> It sounds like the device was being moved to another netns while
> unregister_netdevice_notifier_dev_net() was called.
> 
> Could you check if dev_net() is changed before/after rtnl_lock() in
> 
>    * register_netdevice_notifier_dev_net()
>    * unregister_netdevice_notifier_dev_net()
> 
> ?

When checking dev_net before and after taking the lock the issue won’t 
reproduce.
note that when issue reproduce we arrive to 
unregister_netdevice_notifier_dev_net with an invalid net pointer 
(verified it with prints of its value, and it's not the same consistent 
value as is throughout rest of the test).
we suspect the issue related to the async ns deletion.




