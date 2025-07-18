Return-Path: <netdev+bounces-208087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90763B09B01
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 07:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A771C41275
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 05:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A691CAA6D;
	Fri, 18 Jul 2025 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="DCZNO2iQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2126.outbound.protection.outlook.com [40.107.236.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59BF11CAF;
	Fri, 18 Jul 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752817733; cv=fail; b=AToRKLNaKY8XDazWWny0rLN4epawbo27VVj/dxX/n9tSAea5V5frKG/dQv6kMd8XJdcWd+l60a0jdUAOREi4F17mExgvfepGKSBllwDUI91M0wkpvuMvXV76aBfjJtpS5L1LPmsIK1tZMRAbKYU7Yr372q5fyiJo0ZoLHS06FyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752817733; c=relaxed/simple;
	bh=nQBi2Y9cOcP/6ZhokVPsbMHrOYGDyilWsotX6F5Z4P0=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ia3qLIimytQLnaubQ4Z52za44LUZv0vba/nFvAfIQ3cFNM07mqiKo1ha/nbNEIsbDjxLtzwia47q3EjDpwS93NAOxVWlETleMc4Ys3diB8poOIuXicDkBMr7+nRVASHNxJocBX1K5buDPviUzEI17azJ2550zTetLg64Vsoy5jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=DCZNO2iQ reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.236.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwqL+KURxM540VPortfCjj8oXMHBcXgkiqaT2b9Nvc0gFeo/ln1WQQ0pBMGmSmwOvreFrE8cGwDdeZ7uRWMeXtXT/P2FPp+99pylUHEErrzwxLv7J5NcGARcRW42oiRctUXJUhVwWnNBju2AzrqxD72TVB7k/3HvA2m09b/oZc/++eK3P4LbAxji2tGe3cQUeNzQ6iJDTqsPxBqPBePY80e1gdPk6dh5n44O1d3tZ0nCJxgkWNXqL9UsyHAeRYVBrgGKwHTklUIxfGAXI3WCNcaIE1QregLhETw1pWPuapDZ2d/bE0IvHBBtiMGLUPvKoWcbvJwNfq7IH6ydIi5gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63Umk6S/sUhLDiofefCz0kPBl2GMPWUIpcpVkXvqbBs=;
 b=yqp0F122CoYVQASlV3GEKSzc7gkSYRcnxKTbirb6ykKHoDMx2dZ8aLuFM8lIKbcdPQ5+k6ybZFk0RxbesE+atR33aGH7pHavjQjv8IvOybXd5q6XGGqB+4680QbKwQrAN83rR/XS8C3+qLalvxtZqVIOuKwOSMZAlh1ffd6PoOq2IA3Z7UfdMdxpOdx9eSRB4GCMhelJ4tRhtYTC6H4dflEcuByLk0AUOvBm63ukcyd/UWAKImuCBLWWp7xMlBbCFUcf7UrMNgoAnE6al4d8iT9/Zr5ntoR3IrbacBGNIBaXVNMWJE54raMXijWlC61a9URrcSY44ka0Jm3tZsr0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63Umk6S/sUhLDiofefCz0kPBl2GMPWUIpcpVkXvqbBs=;
 b=DCZNO2iQ5YtwETuQdmt6WcHfcIS4VsSb/NrNdPEXDSfeQbBLeeio20Vpd+YSoW1nL2g/RLcqvfdUf66Nvs4R8Pq4aO8SHRujc2OJbqjHjuaFcwX5ln6t4voCGWyhYIUC/sRDOHzEBsWpu+epdQJ7oe6K/y6MdOr+2K7JpyRTdWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7994.prod.exchangelabs.com (2603:10b6:510:28a::9) by
 SA1PR01MB6638.prod.exchangelabs.com (2603:10b6:806:1a3::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Fri, 18 Jul 2025 05:48:49 +0000
Received: from PH0PR01MB7994.prod.exchangelabs.com
 ([fe80::7d00:d756:f1e3:2fe8]) by PH0PR01MB7994.prod.exchangelabs.com
 ([fe80::7d00:d756:f1e3:2fe8%5]) with mapi id 15.20.8901.036; Fri, 18 Jul 2025
 05:48:48 +0000
Message-ID: <5182407d-c252-403a-bb62-ebd11b0f126a@amperemail.onmicrosoft.com>
Date: Fri, 18 Jul 2025 12:48:30 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mctp: Add MCTP PCIe VDM transport driver
To: Jeremy Kerr <jk@codeconstruct.com.au>, YH Chung
 <yh_chung@aspeedtech.com>,
 "matt@codeconstruct.com.au" <matt@codeconstruct.com.au>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 BMC-SW <BMC-SW@aspeedtech.com>
References: <20250714062544.2612693-1-yh_chung@aspeedtech.com>
 <a01f2ed55c69fc22dac9c8e5c2e84b557346aa4d.camel@codeconstruct.com.au>
 <SEZPR06MB57635C8B59C4B0C6053BC1C99054A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <27c18b26e7de5e184245e610b456a497e717365d.camel@codeconstruct.com.au>
 <SEZPR06MB5763AD0FC90DD6AF334555DA9051A@SEZPR06MB5763.apcprd06.prod.outlook.com>
 <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
Content-Language: en-US
Cc: Hieu Le <lhieu@os.amperecomputing.com>
From: Khang D Nguyen <khangng@amperemail.onmicrosoft.com>
In-Reply-To: <7e8f741b24b1426ae71171dff253921315668bf1.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0236.namprd04.prod.outlook.com
 (2603:10b6:806:127::31) To PH0PR01MB7994.prod.exchangelabs.com
 (2603:10b6:510:28a::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7994:EE_|SA1PR01MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: bc44a4fe-46ea-474a-40fb-08ddc5bec479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkdxOGxNWjFCb3RWMVNqeVJsT0pzd211cXZFS1R4bTBaY1RjbStqdDlPaGtE?=
 =?utf-8?B?NmxsUEgrRFRxTHprclVFc1UrVVd5K1J2U3g0cTlIelI5QzEwbmZycytTWS83?=
 =?utf-8?B?bVlRNi9aYzVJWjNuTituSDh6OUZpdkV3YlNrbTh4ZWxIUlpQeEZLZWtJSlZV?=
 =?utf-8?B?NEJWMllRSzZjNms5SzUvTU5LZEY1aGt2YWJrK3FEa09JTThVSFliYU1ZemJZ?=
 =?utf-8?B?Z1FKQUdxQ2V2Rm9FSUVBZmdpUmZ3Rm1MWGhrZDFXQ1pTL2RGZjFBN2hXTGJ2?=
 =?utf-8?B?SWZQWmxKOExsWTBSNVloSWZKZll2MmpmaWFuNTh6U0Y0dkp6NW8vQVp2ZE0y?=
 =?utf-8?B?NG9HZGxBRHFpYVpSRU11dExta0I3aWg3OWpET094YTZjTHRXaEc1ZFRxbFNU?=
 =?utf-8?B?eXJVaVJuVkFzK1kyTnlHU2VKTmkzMWdNUGdndEliS3FISTlQRjhkak1HMktD?=
 =?utf-8?B?NTZxTHk5QXB0eVBuRytUOERBNDludUNkK296dStCS0NVRFhza0xaVWFwdm0y?=
 =?utf-8?B?ZExEYy83ZzltUU4vaG10M2ZmYTJIdkdnbzVGdUx5Y2dEckY5ZlpVS1hURlFl?=
 =?utf-8?B?Vk1qMW0wMnJYQ3V1R1dOS2haR201SFhTbkF4S05nYVgrU0ZQTGhCYjgyL0F6?=
 =?utf-8?B?a3BabVB4WkxXZll6N25INlhXSHV0VFdrdXVCWHc1VXc4VFl5SUlJL0hLRzhk?=
 =?utf-8?B?R2NhK0IvWVczZ0Nsam9DNFJ5UlVVNGwzTzRvOFhqTUoraVh1czVxekhyWmRX?=
 =?utf-8?B?RjdpcTRxOVJZS0VmVHBISkNTQU1mK2Y4TEF6UUZUdFpsanIwUzZoYTFkNlEr?=
 =?utf-8?B?NDVtT0QrTGpJRHlBOW45TnpSb08ySGlKNm1Jb1EwUzh0SGY3SXFqUlhzVHBG?=
 =?utf-8?B?T24wdlZUbHBMS3lOTmxMdXRKV2hGVmVjcFpTdTMxc1hRT0Y1SVNxenNzTFlW?=
 =?utf-8?B?S2Z4V01GeE43NmRJZ09QeUxaeVpSbDY1aTg0ZHdFSHNpMUc4bnlkckhQSmhW?=
 =?utf-8?B?Z0U1dnBRbFFQOG5pVUIwcU9kNmFGdE1GbURPOFh0bW11Q1lZZDQ1cEM3eFJD?=
 =?utf-8?B?T2NUcWFQdTVCRHh3QXlLOGcyakUrU3cxenV1M2RHcEt4VXhZWCtxNDhsSUxO?=
 =?utf-8?B?bFdKMjlTM2FSUGZja1VEeTVCUXcxWUFwS2g4YWtYUGQxQlZVM1p1RnQ1UEFH?=
 =?utf-8?B?QmUvRGhYYnllbS9HUTdMWjlicEZHYk9wRjZySGNiV3U3MEE4NmtROHViZDM2?=
 =?utf-8?B?UEhzL3JWOVd5dDZ1VXBxcGZVaWc1M2RGYnRzU3RXMm4zeERNTmQyN3RXNzMr?=
 =?utf-8?B?RTdXTDJjQjdlRUxkNzVNazkydWtQYkcwcXJRNnVDSlJIcTIxZWNQamo1dmUx?=
 =?utf-8?B?WWpWcE8vQStDaThwQlIramgwM2p0VmVXWm9rREo5S3QvaUhOand5RHRvNDlm?=
 =?utf-8?B?NXFzNmRtajF6NEZVeDc3dExnMWhlVzBqNjk3TnBDUnZiNDdOcHlEN2d4S3R5?=
 =?utf-8?B?cUFkRnpnbXF2THFIVHd4NVRrYW9kYkVtUFpZdVF1MnN2NjdRU29yTFlxYmV0?=
 =?utf-8?B?cFVOQm54NDdrWnZLM2tISzUvaVdmeWlmOFZSbUpNejBiQjZyRHlnaWtJWkdW?=
 =?utf-8?B?T3lCMzBvUngzNlhVb0FjbjVydVFSMVp3MGl0aU4xRGNCUTRMd2p3bjFzZWNP?=
 =?utf-8?B?TUlBMi9RSVJpdTNjemJNV0FFcm54ZGhMc3UwSXBpL0VzWVdjWmNxM3lWd29h?=
 =?utf-8?B?Tmp2dlFpRXFnekJFS29PTjFHbkZWdVM4VERDMGxnQnFYSlduMzdaY2hBWVRH?=
 =?utf-8?B?bEord3lsS2kzRi9lYm5WRHJzOHdRemVLQldqNDNaZ044YVQwMTdENEVONGJK?=
 =?utf-8?B?SzF2aWVqVGdLQUhYbUVManlyVUpBSEN1N3U5dFEvaWpCQ2xXeGwzK1lGMGJE?=
 =?utf-8?B?aGkzUVQ2Zml3V3V1NW9URklnQ1Zuemp6Z21VRGROQWc5NWRMMDVaWExZbmJr?=
 =?utf-8?B?K2tQanhFOG53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7994.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFiaFc5eDQ3WmxYZGF3YWJOQlRSWHdJaE1HZWtKekhXOXFUVTdtbUE5ZkNP?=
 =?utf-8?B?NGVrdFVQVWJEYW1aTjdhNFIrUlhQTVFDbTAzTWNWUFJZaTJXNkNBM1o0T3Uv?=
 =?utf-8?B?eEUwN3dYOEhPSWFmbFFEWVFjTlhmQ1BMcmE1Skh4S2UvQVdpMG84OEVrcGF1?=
 =?utf-8?B?ZWtjdTBacTZPQVErakxPc1hiaWlNK3hYVmtEc0l6QVhLeDh4SXgyTnNhV21G?=
 =?utf-8?B?MGJiWGdESzZaZk1NRE1ZQUFGV25NdnNNU2h1dDlFVzNJU3AwL21yb0VXMkdK?=
 =?utf-8?B?V2hSU01KMHhGN1ZhU2Zhd3FoREtjQ2NJQXVrRGw3cjBvR3oyQmZpendCcnVs?=
 =?utf-8?B?YVBqMzkrNjRNQzBoZnF3K3hQdnExVDJ5UFVvS2ZwdmZUNWQ2aEJTcnJLSUZP?=
 =?utf-8?B?U2xwUUdaNkpneXUrTXNWN3ZPaXdnQ2l4RlI4bWI1b1JqUTUxVlRMcmNWRmNZ?=
 =?utf-8?B?V2lnWWhMS1VaYm1Sd0twOVptZXY0OTBXa1FLU29ZV1o4OFgyOXBEVXpYVTdT?=
 =?utf-8?B?Nm52ZUdTOGtFWUxZQUtreVN0emxmaEd4Ymw0ZzN3NWZEZ2IrSzlFQ21GenYz?=
 =?utf-8?B?V3dZRVFsN0FqcDlKRG5pVmh1L2dBaVVuVm4zR3VkWVg1K0s5MmJSMW56TEdH?=
 =?utf-8?B?NGVuWGxtRnZVRVV3LzQ1Q3dLT2hpZEdQT2VGMjNYeVd6ajNMTEowZTJWWnVN?=
 =?utf-8?B?YkNQUEQ4UXJPMnJCa1FRSUtNUWhZcEZ0cHVpTGZlMjVjaWlFWi9IMW5hSmZN?=
 =?utf-8?B?TVdmRkVLcTNiOUc2K3V1WjF6bFg3bUZRVENuU2R4R3dBaXRQVnZXc1Bid3E4?=
 =?utf-8?B?R3U4d2x0NzlNUjNVZExLTXljcCs0SkJZSHdoMi9zTTNHVlJDOVhFQzBYWGFk?=
 =?utf-8?B?ejQ3MjRmMXJVMkp5NVdTZ3hFdlQ4eTZnYU1NanBMUkVrTnhEdURsRzFxUmZS?=
 =?utf-8?B?ODgzbXpVd0FvTFc3KzFEcUZlekRxeTF1eWc3ejZtUVhKV1FYVm1VVU51UjJl?=
 =?utf-8?B?VWVLZENPNDh1NEhJTVI3WUlPb3FJbEd0MjZPZ3hqbHJWdGYwb3pLaWdrQzZV?=
 =?utf-8?B?NGd1RkJsbEZxY2JXN3U4VWQ4T2pZTzg5OGFIYUQ5MzlGZXI4VHhyaWZ6NDV3?=
 =?utf-8?B?bWtSeVBlTHA0dkxIL2ovYWd1b1ZTVFRZQlBtYTAvb3RiOVFHbkM4OC8xTlo0?=
 =?utf-8?B?S3hBbGVYQ1VmdFBvSEsxUmVySVlXTFJHTmY4RXZYSndlWUU2T2FFZlhvUThU?=
 =?utf-8?B?czJSTXZqWlhLUy9PZklUckRlNEI4TWI5eit0SmtaZ1c0WFVsOU9yOStCQTBv?=
 =?utf-8?B?NHRzak5wekRJSktTdjEybUYrWVFPVDRWZklaQUdYMjd2S1N3RnB4TmVNaE9Q?=
 =?utf-8?B?TWhiWnZQUytVajhURTBLOFJOYU9mYUhwRmkxYllUckdOc2V2SDltNkdLVzZL?=
 =?utf-8?B?QVFtNlVkTFBaT0ovemxUOU9HczFobEw4SXhMOWpEYkppZEw0cG5TdVFvajJI?=
 =?utf-8?B?Q0N6VWFmRlIxQXhpWEpRZVJHVHpoSEZqYjFiUldBd2g0aEVhVXJUUlV0bDZr?=
 =?utf-8?B?YTBETERFRSs4WnlHdFlOMlMwNmdITmJFVzZEK0dwaFVsa2pmNUV6cXFWYXM2?=
 =?utf-8?B?cHlIQUtQMlpUSUV0QmMwYlJ3QVkwWUZQVTJXR2RSTVBNek5EeUsvODFKK0ZJ?=
 =?utf-8?B?TzQ4NnR2em1mMDNxMll4dmY0cUFJcUlyUGZ0Lzh5T3ZFcXliMTJKaFRrbUhX?=
 =?utf-8?B?VXAxS3dZWFFKVmdnSjZLcmRKbFpYNnYxbWVYa3VGOG9DbUFzRnp6eVEwNGJu?=
 =?utf-8?B?WjVGTVJ4OFhWa00vc3l3MklpeHZGRFJ0YjN4bEN6eGZubTQyYUJITzV2Rldi?=
 =?utf-8?B?Z3BaZERVYlZDSmZyQXVySFlPWGt2VFBaMHJVTjFzQkJjaUkwRXMyeEtEYmtE?=
 =?utf-8?B?eXIrSEdTZEM4OXdQVkV0bEx2WmpDejRTb05XY29ZN0gybEVUc2cxdFJFOWUv?=
 =?utf-8?B?TnVtaW9oTkFveEwvT1hiQmhiV0lrNzYyT3FkKy9VZWVPckxZM3MvL0UvVW9S?=
 =?utf-8?B?R3NhZVBaY3FyWG1KaG5MYStEVmhUYzZvUmpvbmczK0NxdWlPVmF2VGlncEE2?=
 =?utf-8?B?ZC9ncHpqbUp0Q280aVcrRjZvNWZnUEZWdjFOdFhJM0FXVnQwLzhIK2JPZG5G?=
 =?utf-8?Q?RS7bsMrIu4i8PvzcLdiDLHQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc44a4fe-46ea-474a-40fb-08ddc5bec479
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7994.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 05:48:48.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzAs+fPu2udnAnk5V014W3vO6LlfLqrHvJA6v+S67mbwLmBMA+TPQovM/caJSegBbDShXY71tqKYhZhfnIV25KUvfno365u7a9Z7QuZv483xF5f4FqkktK2bMC5zXFYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6638

Hi YH and Jeremy,

[+CC Hieu]

>> Could you share if there's any preliminary prototype or idea for the
>> format of the lladdr that core plans to implement, particularly
>> regarding how the route type should be encoded or parsed?
> 
> Excellent question! I suspect we would want a four-byte representation,
> being:
> 
>   [0]: routing type (bits 0:2, others reserved)
>   [1]: segment (or 0 for non-flit mode)
>   [2]: bus
>   [3]: device / function
> 
> which assumes there is some value in combining formats between flit- and
> non-flit modes. I am happy to adjust if there are better ideas.
> 
> Khang: any inputs from your side there?

I believe segment 0 is a common valid segment and is not reserved. If we 
want to combine, we might need another bit in the first byte to 
represent if it is flit-mode or not. But I am not sure if it is worth 
the effort, rather than just separate them.

As far as I understand, I think we have been discussing the address 
format for each "Transport Binding" (e.g, I2C vs PCIe-VDM vs ...).

According to DSP0239, I suggest we should decide the lladdr format based 
on the more precise "Physical Medium Identifier" (e.g, PCIe 5.0 or PCIe 
6.0 non-Flit or PCIe 6.0 Flit Mode), rather than the more general 
"Physical Transport Binding Identifier". The specification seems to 
suggest this by the wording "primarily".

     The identifier is primarily used to identify which physical
     addressing format is used for MCTP packets on the bus.

Transport Binding Identifier used to be enough, until they separate the 
address for PCIe-VDM non-Flit and Flit Mode. I am afraid if they add 
something new again, we might not be able to retrofit.

It should be safer and easier to get the format right for each Physical 
Medium Identifier, rather than for each Physical Transport Binding.

So my opinion:

- 3-byte for non-Flit (0x08-0x0E medium type)
   4-byte for Flit Mode (0x40 medium type)
- Drivers should be able to advertise their Physical Medium Identifier
   alongside the existing Physical Transport Binding Identifier.
- We can document a stable lladdr / Linux kernel physical format used
   for sockets for each Physical Medium Identifier, not Physical
   Transport Binding.

Sincerely,
Khang

