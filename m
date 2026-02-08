Return-Path: <netdev+bounces-257826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFyACGmWiGnzrgQAu9opvQ
	(envelope-from <netdev+bounces-257826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 14:58:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA14108D6C
	for <lists+netdev@lfdr.de>; Sun, 08 Feb 2026 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1961430053C5
	for <lists+netdev@lfdr.de>; Sun,  8 Feb 2026 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B442C0261;
	Sun,  8 Feb 2026 13:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o10eKLQS"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7E258ED4
	for <netdev@vger.kernel.org>; Sun,  8 Feb 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559060; cv=fail; b=saRWSB05l6HMO9XbHaJS/UZK6anawFyqV45gzEVElNYCin8Al/FEgLpDvBcsa6yZ96HakJ9u2iFPdp+g+m0OiPPMs1dPwZMQOK4iK5WelahJYqq6ONOVVRKTe4QXLbBhL/A+tx5Ic0qnHcwgjER/xsYi2HwBuxmJzIQel8zm1dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559060; c=relaxed/simple;
	bh=wnuKcXKXxSeZCc1835PSioSzEcd7Csc5vY5gCVfCzYw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KaEKtmnVQEP0eIw+TbX0VHnjEtFp/sLvk9USXiA3tlAz8JRmPviwUxgWMWWNIp9ibxBfxBzdv/dHl3ey8fWqrrzaST5z1/9g7i/qzU0LQ6wy5tPIRqKKNUnxRT8Tq6M6XPdUcbP1a4mV7MiFowhWVCU6lcW09msvy7VfWk8EIao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o10eKLQS; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PFTkT9xKzaFUKallXDFq2FCs2Grh1stBTbtfc1jhTTkEHKZ7vTfZ8F9buH1/AzQdsU2BXUYezyw3BqbpMZU6Hev+AVgpsL2LU59casl2tAE1gEi7tVlEUwnMte/71mplq+NsTl2un4/ZwMUS0jrMqGgRJNZrphBg3i3kOYLdrJQ8aDmVliBYhXoqUOq1bdyqpGzNChw9sUkn3ahc5MhfIeD2movYoRbPFwhR2/WZ5exwCXIHHuZiXHWQc6DC/agsVO+SgLuWG5fZqGuVkkoyn3n+DsU6nRWczz8uxpoeAY6VMR//9jwgWKSu0pAsBWYTiWyhUp5qzeum768+tmtWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtqpeVktajWE9Xab5jAD83cL/zrlnds+Sizmw+ko9aU=;
 b=JjXqFOFVdfaZEp3Llp+Ym8rb/7o3W1BkZd9n4S8sYbVjloMuyHFkVdRipu0/MX8W0qPWuyIT9pS7CQ2s355EdBvuueVc+gvkIFqq91UEgM09ZewJMdNWI+LpxjxwpjB4wK0JztjrbelI9EH9KS9l9qI5xaYKsChYle1SadQnvC8TDn+EXx0ZwB+TkKlJhgSBJ+bCx2HJNyYYkYmm4gB9DqXtZCEsgoPF35dHsndMyu83rVw+TcG1XSGoY9413R/Tm+WA56/78ESKgYBid3Xd5xYVylzhtrTzDMS6ZEemnnuLrEGkTIigMzMwo0fAvAm3JRj5kWskin8q8e5Ci0l/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtqpeVktajWE9Xab5jAD83cL/zrlnds+Sizmw+ko9aU=;
 b=o10eKLQS1fyWWAZgklrTq9EpE3EJf0RcpkqRwtT7ql3YLGmCKKOtljXPFOvWnkARd/s9VIZoOaRaoFq1ynW6Eq/Zt6sDY2lGnxxKaOY7iUtJicPe+yFYnzqTJ+3wFSDuTSjTo002/hcsQOu9Wc9XvQ3la2OKZUO3kgUsXps/Xfrr3qotY3nEACQFxSLrKISQZyxIfQmhVGEwVwTMQZUA38Ojc80dpEHoPgIjvP+xzZiYFCDwSciP8904n1dllovG+LcLbccJqf01MeSbLUx3P+ppItmCFed0Id8Ab7G0QS1GxJwzDw4ib3Vd8kiFjOrqV74PDZ9sixhzNy/qZpx9Tw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6748.namprd12.prod.outlook.com (2603:10b6:510:1c4::5)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Sun, 8 Feb
 2026 13:57:37 +0000
Received: from PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe]) by PH8PR12MB6748.namprd12.prod.outlook.com
 ([fe80::a91b:e47b:4f8f:57fe%6]) with mapi id 15.20.9587.013; Sun, 8 Feb 2026
 13:57:36 +0000
Message-ID: <3512ccd8-650f-4c05-b2dc-1c4588b39c87@nvidia.com>
Date: Sun, 8 Feb 2026 07:57:33 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 00/12] virtio_net: Add ethtool flow rules
 support
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
 virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 jgg@ziepe.ca, kevin.tian@intel.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260208065456-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Dan Jurgens <danielj@nvidia.com>
In-Reply-To: <20260208065456-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0045.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::20) To PH8PR12MB6748.namprd12.prod.outlook.com
 (2603:10b6:510:1c4::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6748:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2a11f9-4a79-4ef5-374a-08de671a03f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEdTTEI5bVZGQ3diU090S3ZydVJuUCtNbWMxT3ZxQ3dzbFdDZ3VWa3puRk4w?=
 =?utf-8?B?MXhuWnFOdWVycDlaYzAxOE1XYXpQMnUvMVVCZE1vU2ViREVnWHBHUGZRSmRZ?=
 =?utf-8?B?SndXSVdxNU5mWW5JREIxK3ROL2V6UkNkSTFyaytSOUxCQkhKaDY1bXRlOHh4?=
 =?utf-8?B?c3g5Wkg3UVpVMHBNL3Vra2FFMDRodUh3T0tpL0g0L1UybkV6S1BWVkVNZzIr?=
 =?utf-8?B?NFI5enM1VWt4UFYreGQzWkFoVDNQMWR2K09xTmFaQ1kxQTQyZG0xUHFTUW1i?=
 =?utf-8?B?R2RuZjQ2ckpOYWJGN1hwY3BVTEN2aEdsODB1K2ZmeWhWTDVWRnBaUEF6NXlx?=
 =?utf-8?B?dDlVQzZ4WFB1bUE5WG1UNThYR0lPQXpVZkdlMyszcE1FcWVVWHhrbjFFZUR6?=
 =?utf-8?B?dE5XWEJ5TlBxdlRCTDhXU1BLS0pTSWJ4Vm13cndFMVMzeUkzRlR1K1YvSjRD?=
 =?utf-8?B?YVo1OVE1UzkzRWZqYk5Ed3VZL0VIWjArbVRBWVBLaFNiNXFydjI2Y1pvaFBC?=
 =?utf-8?B?a1orV29ybHpHbmlSbHY5ZWI1WHBZVkJwSVJQYXcwd2tiaUp1WjBMaXBjWlJY?=
 =?utf-8?B?R2Q1MmVHbmt1U2JvTWlUUVpBa2Z4MnB0RjB4UmQwZXVSZENlS0JObFczUExI?=
 =?utf-8?B?SzZJTiszSE1XN0RjMEtYbTJRZlVYTTZScDVXVnp5UjVMY3N6cGFmNG1TL3dx?=
 =?utf-8?B?cGsyeVZ5UTBFTWhUVUkwWFZEbW0zRjlsZ0xsVFZhOUpPK21nWCtMNE0wbmRu?=
 =?utf-8?B?L2s1LzVTRy9Ud05pa2FJTURHZVFjbzRTNWd0NHZiUkZJN0xPUnV4Y2Z0VVNy?=
 =?utf-8?B?WGoxSVdneStqbCtqZ0ltbW9uV2x1UmlWVUg5SHphUkhLLzBnZGJqT2QxZUtj?=
 =?utf-8?B?aGVlRkZJelJDdEhqNW5oWEpEb3pvaVFWcXF3OFRUZ0R3NGdjb2UwUGhXa0hY?=
 =?utf-8?B?VmRtcUNvdy9OdXd0dXpmSEpGT1VIbS9aWDc0NmZ2Y0owamhqekIwam53NHk0?=
 =?utf-8?B?UXlsbm9vdVB1djY5RnZLdmtVbWMxd0ZqSlEyWVJ1M1IrWlA4M0w4SXN5Vldq?=
 =?utf-8?B?ay9iTEtxVFUvdGx0UDZZSEVqZTBmUkNhUmR6N3piTVROS09pbFY2aWZSa2N2?=
 =?utf-8?B?UVcwaUlLckJML1hsZXd3ZUJ0bnpyYTFXZHRNQ0wveklDZWVsU3Jpb1pEcTJt?=
 =?utf-8?B?U0JYcml2cmhSS3VjOTJQSjhkbkxORFhOS0s5cUhzbEdEa2p0RFNSWVNGOHAy?=
 =?utf-8?B?anplaXMvcHpVMXJFZlVtZlg5bGlyMTFBbnhsalBFNjQyalJwTi9pSll5R3Zh?=
 =?utf-8?B?azFKN1ZWK2EvSnhDU0ptcGsrVVhDRVB6UlFTVitrUXVMb2xJOVg1MDZrMEQ3?=
 =?utf-8?B?WE50OGtvL2RnbWJ2eFVUcnB1cUh2V0ZZTTQ4UXZXUEZvbTJ6TGo4eHN3ejUw?=
 =?utf-8?B?c3MwQmpBbnVBSVU3QzQ1UHhYZUU0a3RGMVgwc3JJaUtTT25HSkMrcEFPblRY?=
 =?utf-8?B?MWtWOWJHc0NybUJhN09ldHZNdnFCRERBV0FqbzMrNVQrWFpjWXJrQWc1R1Vi?=
 =?utf-8?B?SlFQNDRGS1hTNm1EZTB2YTJmQmhqNFBGY1dobE1JMElJREE2MUQ3Y2ZVUTl2?=
 =?utf-8?B?aFJFNkF0MjVMUkxCc3dkRzZNQnNWdk8raXFkWjc1YmEwSnNQWmErdTVoMnVx?=
 =?utf-8?B?Q0QzSzRwcUFmLzZEWlBJL3VTWVF0cVVhY0xKTWxQb24yaVA0K3NCUGZ0Z3JH?=
 =?utf-8?B?NlFuZm1sYjZJZnZqRkUyMmt0TDBDR3NneHpvN2N6THhyL0lQMm9DWDFSRGlr?=
 =?utf-8?B?T1pFUDJQUUoydk5qdFRlNVpleFJQZDVBMmprOFpMOC9BYzkvRDRKWDhBbDFO?=
 =?utf-8?B?aFJtTjY3TDdxaHNrSHVUM3A5aEpKZk5iUFEvNG8zOERjVVJBdG5xMVhuenFh?=
 =?utf-8?B?NjJkTHorKzR1aFU2V1k1cnNRUitEQ3hONEJlRm9TZzlFWjdGZnJXM2IvQ1I5?=
 =?utf-8?B?eC9GWXZSZGZudStqR3pyNDdoWHQ3YmpQUE1FVUpZakZma290bDMzY0pUTnN6?=
 =?utf-8?B?SDA5ekMvR1Y1TW1ldzlRUzhqdmY5VVppTXJvdUhJbkw3Uk5wcGNibjc1cXRY?=
 =?utf-8?Q?E6eY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6748.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VlA1dyt0N0huRSsrNlpxYUsrUlRZSkhvMDhRcFRKaWdLQVdjUmUxWHFpYWcz?=
 =?utf-8?B?dlFYdHg4Zmp2ZWN3Y2FiTnZHa2RIVnpJbktjak4vR2NzWmdWZ01KeDZpQVpy?=
 =?utf-8?B?a3R0N2pYNk1iSDFLRTBXMHpuYnl1T2xoNEwraGdKZWtyMEd0VFRySUZYYmFo?=
 =?utf-8?B?MXUxSzJwRUl4QmI2VC8vRUJqRmQybUNpNHJxSFNXdVR2Z29jWFJoanIvYjNR?=
 =?utf-8?B?aFhCWnpLZTN4SUZ4OHo3cE14TFA2QUlSUWg1NlB1UU11bmN2OFZzTWoxUVJy?=
 =?utf-8?B?dUVpd0t6TmN3b21vNUEvWDhEVFpPWmRYWnJLVExxalJCSTlsL2ZsamFibUZK?=
 =?utf-8?B?VUgwcjZ0YUhScFcxYkh5bFZRSElaNFN1YmlYNWxDUlVSMnBkczVMWnJIZStw?=
 =?utf-8?B?aTRIdW9ERnFQMkxDYUhBVzlXM3FPWlQ1TXZsUDgxRVVqVFJubDc1NEdKTWVp?=
 =?utf-8?B?OEYrMlpJcWtUV1RJcG5FTDBUMFhlRGNGa09UM0pRMStKRlBsQUh6MnlLMngv?=
 =?utf-8?B?b0czUTNEQWphOVNPYTZDZHV4TFdPQThDYzVRdnZXQ01kRjlXdTBEeCs2TUgw?=
 =?utf-8?B?TXNWSWJXSHVpYkRpTGhWTmdSR0RIS0RLTnpBaWQ0Rk1PTFF1c0hlV0tadjdT?=
 =?utf-8?B?WnNuNTFLV085QTYrejJoOHcvdzRGQXhiS2F2UWFYVExuMXhzdFBRZ1MwSW5X?=
 =?utf-8?B?aUt1NlpJT2VtTGY5aGJIVVZ5VjFoOHhMVW4vQlJpbXY4R2NSdzl3UjF5T0I5?=
 =?utf-8?B?Uysycm1ESm5SMHFOUjhRUTVsUGlya1dNeVRkQ05PQXlmWHRucTltdHMwS21q?=
 =?utf-8?B?VnM2cnFOM3hQQU1DMUU4YkJManp2QXFubTFPaDh2NDRZMk1ISGpqOFZoYXlB?=
 =?utf-8?B?ZXk1eGhabjlFZzFwUUlRTmVERWxjWDdGTUFqbEhlQjBJeERQakwwTXJXK0VQ?=
 =?utf-8?B?aDNzSmYwUHFyZkk0REhlZmFtMHQ5akwzck80eVlHbm5UNnl4U0dVSkRaVjRT?=
 =?utf-8?B?TW1jZjVlRE5laUZIYlNUeVNKMGVnQVZ6UHZiK1dlNmVlbUhvbTF6V3RBVnpE?=
 =?utf-8?B?bksxNjM2SjlJNnF2bmpRYkZjQXNZelI4WnBzUmxFbGVJcHlrbG0xK25GWG1y?=
 =?utf-8?B?SW5IYm1sU0NRb3JLWHUvVzNkWGhETFM3WDAwQWh2Zk1yYkovOUJ4RXI5N0Fn?=
 =?utf-8?B?d0hCejEwQTkrcXo0K2JzVm9FSFBKN2xnTUI2ZjBsYkIraHFmSCtTQmNLaSs0?=
 =?utf-8?B?WW5QaXhoZ0VyeURqTTF1Ykt5aEtzaFNSU1lid2hPYlRaemY2NVBwTTFDeHBt?=
 =?utf-8?B?dlE1eUk2SUhHWkJlNnNBdzFqb2dRS3E0K2NGaFl1bjAvVU0ySTFuRTQvZUlx?=
 =?utf-8?B?ZzFHN0ZyVVRNWEU4ODB6b0hNR3JySldidVB4bWlaUmZGa2JHTkZiTzFNeWZz?=
 =?utf-8?B?dnh2QXN0VmN1d3VwL2poVWw3V1NrTXBORVNuRUkvckVxdW5RaXp6OHlyOGw1?=
 =?utf-8?B?emU1ZlNwUzhIRURJcURpMmx5T0ZzRTE3MHhHbnR5aXJFdzhuOEpSNXVtWERj?=
 =?utf-8?B?V0k4VlhHQkRMSmx6RzdkdGJHWW5wWCtTYXd4QUd6cDVhV2ROVEM4d3ZiQTdh?=
 =?utf-8?B?NmlRcnIyYUxCRTZYbE81MFNjK3h4bktZRGIreTg2R0hnNFdzcXBGQUtXZ09l?=
 =?utf-8?B?WG44a2hBdlM2elBsN0QwR2JnM29kandSdVBIa1ZDMzE4SEdjQ0hzemdHZ1Fz?=
 =?utf-8?B?ZkhTN21nVW1tMHE2bzdrajl6MW5oOGNnMWY2RjdzUThSdXpKa3VmWGE2QkMv?=
 =?utf-8?B?L1lRa0JLQURyNWF3M0FwSFhTK00ySHQvU1pqNmRiYkhXTDdsNktxa05MUDJ2?=
 =?utf-8?B?YVR5dkFONDJuSGNiczk2RDJpYmwwVlVxK0puQzRBeE96TnAyLzFheUorMVNH?=
 =?utf-8?B?SmxnNVhkNUpkZEdKUzNuS1FKeVN6VjIyQ1VmbTMzcUZBYWNkRzVZZGJCVk4v?=
 =?utf-8?B?eU5ld2gwNjFHcXRmaERhb3YxQi9mbHZjZmQ5ZnVjTUsvMS8zbDFIQUpSM3VO?=
 =?utf-8?B?d2lkK1A1K0ZBWGwySlRXNERIK1FhaHRnazNHcTdaNVNySFdFUFZHNzRLK1ZJ?=
 =?utf-8?B?SFBBNTFZaDRxUnFpYVNQejRCbU5ZbWJOc1h2aWFPWVZEdTBScHQ3K1E0QVNQ?=
 =?utf-8?B?Qmw3T3o4SlEzbktaZVk2ZlNIajNZU05pc3ZjckFEdDdlSk9DWTF0YlorcU9T?=
 =?utf-8?B?YjY3QlpzR2R0N1ZSNUZXNEwvNURvclJBNjdjUXlQWHpSU2VXdzl6cktmdEdF?=
 =?utf-8?B?OEZDUlBKcFRMTmxxSzBzZWxMcmk2ZzdOREdXRW9BQ21aeDBqcDV5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2a11f9-4a79-4ef5-374a-08de671a03f0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 13:57:36.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XWA6Uxq6XyfUbrHLg1fwyrje5zUEKbf+Lz5nrVWXwg/Yekiv4cD+30UEE3e4fn9OVwgzQiQyxYnSWT0FsmKeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-257826-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielj@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.975];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 8DA14108D6C
X-Rspamd-Action: no action

On 2/8/26 5:55 AM, Michael S. Tsirkin wrote:
> On Thu, Feb 05, 2026 at 04:46:55PM -0600, Daniel Jurgens wrote:
>> v15:
>>   - In virtnet_restore_up only call virtnet_close in err path if
>>     netif_running. AI
> 
> what was this AI specifically?
> 

It was the AI review bot, forwarded by Jakub on v16:

> +              * remove_vq_common resets the device and frees the vqs.
> +              */
> +             vi->rx_mode_work_enabled = false;
> +             rtnl_unlock();
> +             remove_vq_common(vi);
> +             return err;

If virtnet_ff_init() fails here, remove_vq_common() frees vi->rq, vi->sq,
and vi->ctrl via virtnet_free_queues(), but the netdevice remains
registered. Could this leave the device in an inconsistent state where
subsequent operations (like virtnet_open() triggered by bringing the
interface up) would access freed memory through vi->rq[i]?

The error return propagates up to virtnet_restore() which just returns
the error without further cleanup. If userspace then tries to use the
still-registered netdevice, virtnet_open() would call try_fill_recv()
which dereferences vi->rq.

> +     }
> +     rtnl_unlock();
> +
>        netif_tx_lock_bh(vi->dev);
>        netif_device_attach(vi->dev);
>        netif_tx_unlock_bh(vi->dev);
> -     return err;
> +     return 0;
>  }
--
pw-bot: cr

