Return-Path: <netdev+bounces-250561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA058D33198
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32DDC30C2B77
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 15:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C523396F1;
	Fri, 16 Jan 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="GnmZ2sgl"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020109.outbound.protection.outlook.com [52.101.69.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFCC2D6E7E
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575950; cv=fail; b=qk9xM1Z0RLmiP2EOgF7HUI9qNsH+oVYB/sGV0fK3jYmflDzHCWZQdeaNMuwM8IPY0wbTL6+nKSDwJpdQXPCE/QDJ+hK1IFqFhhINb6NJzqENgZYA6SoP7Wrlcya+3GwAKyoyoXROsZIJfnvfApKeTR9y3WTV/oQ6Td3rsSvlQmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575950; c=relaxed/simple;
	bh=REHYklhItlz3gYs5uHG3Y/VBeihxM8efpCpia1bknO4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mh2boKiI3J02UnX4Qb2g5vzLeUhFG13GaZpGyoGB3CHcw42EP7cySn4N/QLEh8u4ynppAhxKSc91M0rjP0yUx1iJ1YKtLMP5DIq7cjQByA5dQJFxjTNScJh6ripQ42jgYkfWieOGLDVhSETVVgOG2cwTTmJbh2k8sItudquqKrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=GnmZ2sgl; arc=fail smtp.client-ip=52.101.69.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBpOxbOHTbzkYJrqqpMWPuswXND9gH6/ZuB2+don+B4ZqsbogRyZ3yA97t5dPkKnR4ZnUpmfhPjVysFjAzGcyyox7eCzl7nnBpoc5003+lAlVH8LjdkqPYIWihgA/PneoHds/ScAlpVN7WzQ6oBddSGV+2nmDEFwX4ha2n1jFrsixJoZKW2AdcuIVmxKz1ENv+NyJpkEgMWtJOAhBayWiR/xQjlW1MYVnDrixLnPb/Q2zD6pYIorPi1nYs6+Md/Z2qJpmfJ6nuQonnzbERb1wt6jkrWGg2WlN0nwLBMFndKOm5Rxv0ta/k9I8x2PxLfB0RCmhaAa8CKrtXswGWQSQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaW5Hw+61nAfRbetgUuXuww8smar/TnqRsyULdD/IP4=;
 b=Pel1v0HI3ir9vUJflUr/bAIDi/Vebg7wsXYRw4HoGGuUANsWHYJXGYxAO4F24GGdDsosB5sCwJSDnsNGGwHVJCTrJOVpSx5PQtAofCSN7QV4Lzl/nMKvFn+VRK2aCSjzBvIngyaSK2h3Ei72X0YkNVPMvX78iNugogPIWHfJgNo+jFVxXf7vNB8XEk4MbCKUm3Pin/zLuJ9HFJ4KS+KYZVbFFA/M5qFdNykLpyaa6XQKmMNRpnhnfnau2gi1cZgNeKZrP12l5gBrAreAkHlGa5a+eUccqIr3BetbFPj241TyDdw3xO4ukXW9oR76FUv+HHl24e9HmQeMJsupwVxVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaW5Hw+61nAfRbetgUuXuww8smar/TnqRsyULdD/IP4=;
 b=GnmZ2sglEL9A0GVFYRePahc0k7ZB0wsGpf0PR/KyHwJMykwoDgtxdGk/SouRNOfh6u9at8mNcG11l+fGdfaum4UB7ub29Vzk4AMZ7ui3LlM//N9axSERPeJGhAtQpTfmcLMVCrkvH3V2d5HPu3+NN20Ne3YcIKr/iOcJuFvp2VyVAFz2tvlbTVMDhiOWWrNWhfOOVx+eWoOGp2FxtRu7ErXKZb8phcP2u6M5B/wf8/InJfqkqTX0xkQm6Grfcfq1FazrXAf28ecEtIXr3tcCMedU1dmvwpioFtkoXA1U+GTwQXS3xL2l+Pjaux71iY02STPIw6ewTtEcP51F3aftUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11) by GV2PR08MB11489.eurprd08.prod.outlook.com
 (2603:10a6:150:2a6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 15:05:43 +0000
Received: from VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093]) by VI0PR08MB11136.eurprd08.prod.outlook.com
 ([fe80::e3bf:c615:2af2:3093%5]) with mapi id 15.20.9499.005; Fri, 16 Jan 2026
 15:05:43 +0000
Message-ID: <aedc55c4-9a76-480e-afc0-105991aac04a@genexis.eu>
Date: Fri, 16 Jan 2026 16:05:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
To: Andrew Lunn <andrew@lunn.ch>, sayantan nandy <sayantann11@gmail.com>
Cc: lorenzo@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 sayantan.nandy@airoha.com, bread.hsu@airoha.com, kuldeep.malik@airoha.com,
 aniket.negi@airoha.com, rajeev.kumar@airoha.com
References: <20260115084837.52307-1-sayantann11@gmail.com>
 <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
 <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>
 <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
 <aded81ea-2fca-4e5b-a3a1-011ec036b26b@genexis.eu>
 <f0683837-73cd-4478-9f00-044875a0da75@lunn.ch>
 <CADJVu8XP_wBudwOrT1OLhcZ3-9Qoci8FQzw+yyxnogiC2Asx5w@mail.gmail.com>
 <fc018e11-3957-4b2e-88a8-777057091923@lunn.ch>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <fc018e11-3957-4b2e-88a8-777057091923@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00011B63.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:6) To VI0PR08MB11136.eurprd08.prod.outlook.com
 (2603:10a6:800:253::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB11136:EE_|GV2PR08MB11489:EE_
X-MS-Office365-Filtering-Correlation-Id: 3add9ed0-7b43-4aa2-a10b-08de5510b867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGhkL0dxTFFSYjc1Q1VZcG1lYWxJRnl3REpQL2tNbEU0Y0VaVVNEYzBLbS9x?=
 =?utf-8?B?ZDV3S2FId1V1MjI2bzVIZUdrYkJWaGtKY2J3cVhFcHdWTkpFN0FSNFpRTDgw?=
 =?utf-8?B?U3lXc1F5OXJ5a3cweThVVkdoWFpsTGRKdDJOaUVxL3U4aFBuWVJkWldrTnNW?=
 =?utf-8?B?ZmprNndJMnRoS0YrMmk4Y2lZM0xsREVwNnpwOUs5VHZKUDM4emVvVUQyVDY0?=
 =?utf-8?B?V042MjVVaXhKYmVRUGJYcytUT1BsRVd1SW1YVVpnRzNUZ2ttNkFJS0V4U2Zi?=
 =?utf-8?B?NnJ3c2FUeG1LeGRLM0FTZmpDQklFenhJTk9COUJtSDBOSnB0U2pjR0dHS0ZN?=
 =?utf-8?B?OURaS2ZQWnFoL0I1bWZWSTJCQjhOUmovVWlkK2JyS1llSXZ5WURuVC9jdWtW?=
 =?utf-8?B?QlNmSy9XUDg2YnMxZ3ZzWGMzdHlUR3F4Z0ZVdmtoNFpIMDR3MDhtTzFjL1dv?=
 =?utf-8?B?OVdxblo4WGR6aTNrMDNwSG9zblFtSXJhZVNKTFpPbGM1S014b0V4SnhpZ2V1?=
 =?utf-8?B?RzMyMVcxbVNzZ2ErMjZvUWZZUkJGcnNETmtEZXZWaVY4MENUeTFuZzlRclhs?=
 =?utf-8?B?NXY2R01VMXVTL3RlTGZRd2c0RXpXdjVhOUpwUHNnR3lJMnYzMUJ5QmJENEFq?=
 =?utf-8?B?NER6Qmx3S1JLeUIzVWNmOTN4THdHZFpQWFJpYVI4eGRrMk5ha0YyanJBUi9u?=
 =?utf-8?B?R1krbWtJUDdjNmJSTStVbXNteWRoMlhldlp6UlhORk51VEQrRUxJYzhKRjJn?=
 =?utf-8?B?Z1E3aDNJTjlGbGhwSjAwMm43Vk5xSXFXZUhrWmtMbDBGck4xcE5JTXBkQ2dP?=
 =?utf-8?B?ZzhkbjNMMThHN3BjRWl3ZGY0MmV1a0VZN1FDa3JpNXFaNE9CY0VUcmR6VFRH?=
 =?utf-8?B?VFlvK3ljUDl6WE9BZTc1cmhpckI3ekxiSnh5ZXFzaElFTjQvUnVrQkg3ZGpr?=
 =?utf-8?B?ZUlaY2hKTFBoVU96RWY1WFZLOEJkNHBiZzNrek1qVkgvNnd1akhqWTNmTkJU?=
 =?utf-8?B?bkhCNFBEbGNCeC9YSE1OaGh6M3BOQTBiU0hNNlk2bzBVdXp2b2Z5bkcrQXFt?=
 =?utf-8?B?bFVxNDRLT0Vzb3h6aUdGNldSRVpYTEVmbGRGc0IwMENpcE9SeDJZZGVlLzd1?=
 =?utf-8?B?SlpZYVp5VUZLWkNBNnhXYXM0Skt4aWxlZ0lQcEV0Z3pOZ0lNVWhyclFQc3p5?=
 =?utf-8?B?N0NrS2IwL0xBeVdWY09xTWJNdUoxb0RUOHY4czJERW1ka1ZtK3VNVDBWendI?=
 =?utf-8?B?MHRORWJIN3ZTMEpMemtmaitQMWVNWlRaazBPSnlkMWJHQmhYYnhOemtONEtY?=
 =?utf-8?B?OVN4S2dVSnRsNUx6RnNxYW5kamxvVjRhK051VlYwMzI0MUxiSGVLMWxLSmx6?=
 =?utf-8?B?YVJvc2JjVm8zSnJjS3FYVXdzd3liSXhjNWhHL1FjWDVSNEdFQ3M0NTlxKzlE?=
 =?utf-8?B?ZXR4MGs1dEFLbnJFaStBZG0vWVJJeUI1Y0RQdXBkRUwwL3VUbVp3ZFA4b2VL?=
 =?utf-8?B?cXNQYmIvTU9yRlFCQmt6ODV3NnhXcStyVDJidXM4Z1BOVFNTUUszMjhSNlhu?=
 =?utf-8?B?dmZBNDVwMDNQTDZ5S3hLRDlaQThFWkhzYVhMRXNKSW8xd212Z1kxSnFTRk1p?=
 =?utf-8?B?d3hOTFRGZW1pUXRoTDNneUhaWHVQV01vUENUcE0wb1RiQURUeHgzYU4valV4?=
 =?utf-8?B?dTBKUzJZc1NCZDN1cmxzQXBxNk96OTJiKzdmcjJ6VjlrV2Y1SFp4MGpUamIr?=
 =?utf-8?B?Y3hSWHdyYkNWNkQ2UHRSSVJNYUtVemloNU1ZYXNuOTRJdkR0akpFVUxFK1JD?=
 =?utf-8?B?YmNOL3gzc202eE9GOHZrSmR4cnAvNEhxWjhsdnpaSFRnditLMGYwWlUrSS9i?=
 =?utf-8?B?bTREak1DT3N2R1NXMHdmZGRQT0gyaUtNeEdqZHBIdEFUOHl1QU9rTGRtdGho?=
 =?utf-8?B?amQrQzVwQzducVY1OUtxT0dsbnV2V25ObDd2TVVVVi9LbDJaZHhlNE1uVHdx?=
 =?utf-8?B?K1B6Z3MwckhTdC8wWmlaVkNsWHJmOUx2MFhqRXI3ajFPSFBIV3BLbkhteUIv?=
 =?utf-8?B?bytHcEpFNXB0VmQreVp1YkFYaDhMcGViSTRmUEwrZkx1K1NMdGFMOXhNVExH?=
 =?utf-8?Q?Oifk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB11136.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bHcrais4cEVmbGY3dHdXaml2RkhWMDBXaUZmdkhFTXJiWmNnVVhQaGxvajdU?=
 =?utf-8?B?Sjh0M3RmdVEvc1B0dnpMczd3Qk42d2JrbUs4eWkrbktEOWVpRjM5bDNJVTlF?=
 =?utf-8?B?T1M5VUdUVHFXVDhlbENtT1JwYSs2dUZDZmV4dzlUbVE5R1Nlc0hqOFdyR0lQ?=
 =?utf-8?B?LzhvSnRDM2o2cGdnU3M1TGdFcEk3MXUwS0RvOSs3YkIwSWhUMFhYemlnR0tW?=
 =?utf-8?B?OUlkdEJBUXdNdGVyNTNtbHliUjR1ZktkK3E4SWg0bDBUNXBLQ1hwR2xwYjQr?=
 =?utf-8?B?Mk52Wk5raVQwZFhMTzdON0tHRTEvRWxoZHpOTXgzWHl6K3VWSG8xKzM0eXhT?=
 =?utf-8?B?UG4wbE9MeVRqUkpHM3loWWp4M0RNeEFYdmNrY09XYmVQM0Zjamh2L3ZNcWUv?=
 =?utf-8?B?aEtXK2oweVpISjRNbzFTd0xzTUNZY0tpWUZWSzJRV0FmdGVaaG5NTmsrRzFY?=
 =?utf-8?B?WUx0NHRlN0FYZ0NVd3dabk9mQTJpMGk4MnZzZm5jRnkxd0RPUjJlNVMvK0RX?=
 =?utf-8?B?U3ZQVENEWTBQK1hKV0NzVUhYQ2VrR0xlTzRCWGNnNk85OEFUUjdlVi9kTUhT?=
 =?utf-8?B?OFU1SFh3aS9STkJMM0JGSlFDTUY0TkxjZksxOTU2R2t6dVFJK2VxZzZ0N1dY?=
 =?utf-8?B?Y1BPTE02bkYxZmJaRG45dSs2M29ZTHA4RW9RTDI4TFZFM0ZWY21sd2dWL21v?=
 =?utf-8?B?a2JkMld0d0ZKU0hHbHJrU0I2ZzFjbk8xT0RIb1VlS0JLN1pubi92dEhvUDFv?=
 =?utf-8?B?elIvSGJNb0p0SFRNUmNBcVF4clRvU1pHWk9VQkRrYTlJNlova1NhdEhxMnRY?=
 =?utf-8?B?K3hpMFk0clRzOXUvOHVFcDBrU3Bxa1JtNlVyMXd0UldWWjNqdVFNK2ZMNmxK?=
 =?utf-8?B?Sm0vRWM5RjVmWjUzSnhVcXppalBKSHhpQ29rOG56S3pxc2o0WEhMeEFZQWNj?=
 =?utf-8?B?bVRrSjlaM1o2ZTFubHRBcnB0NFZaMmZldXdLVjdQa2VrWnk2ZmdVYkNzZ0xx?=
 =?utf-8?B?MkNLekg0WnFxb0Q0NXNJcXZ2dEdVc0RCelY1T2NSaUpBaElTYmUzNW1SdWlO?=
 =?utf-8?B?N1VIeVd1Z24xWkg0bjlaODdYd0kwVjh6QmVuQWEvRXRGbmhITldxM1ZWc3Fk?=
 =?utf-8?B?eTNUS28wVEVJUmRpQ0pWTHlVci9ZRERRL0g1ekR6VnVxRm5jWEhZM2M2RkVw?=
 =?utf-8?B?d1lWZzA4VzMzKzdlamoxK3M2R2pJZnZSTENteWUyU0NCYXJTMkFBVDNKR3ls?=
 =?utf-8?B?MFJlU1dKcWdmT3ZnYUhJZm1KZ1RYZHBONEIwcmtXQlRwek12QXNmZWpXSk4x?=
 =?utf-8?B?VmdWK1U4RmdhYTNrbkQrUGhPOTAzZ09FZnFVOEFNdndocVJTVHRxTm92QTU1?=
 =?utf-8?B?R1A3TGtvZ0hOVFhzMVF6S2gzM3ZNYzNlOXMwTzhkN1pzMFM0VE12dkRLdGJz?=
 =?utf-8?B?U0dCQVVOYytMTStGcGFXK3pQaXpFc1dsVGtMUktuZ1pBeVM4YkgyNXZLZXpH?=
 =?utf-8?B?TGxzNjd4YWJDN3NGWDNwcmFFb1dPalQ5TStVTWhMRFRsTHo1cTRlYmtHRGVz?=
 =?utf-8?B?OUxIUi9FV3pCdFZBbHNYbEc4TGRPQk5hKzg1VGtvdjZobmhRSlp0cU0vK2lz?=
 =?utf-8?B?OFNJNjJhTE10dkU1MTdhSHhlbmZhZllPbWdPRlVTclhOZ2xYWmJ6bDNOb3RX?=
 =?utf-8?B?L294MkRoR1Yya2IyVG5mOGFSVW16V1RCMHVWR3pNNXNtYzVueFBwZUVzaG5s?=
 =?utf-8?B?dDJvYjlMYVFsWTg3RVdVeGVJdEFJVzMvSjVSa2hNSUd0cGxOSnc1TVFleDlm?=
 =?utf-8?B?YTZXbkNxV1pKOWNLdnlWQXo0eUdYMldPWEJRVnJZdVJ5SlZEeU0rTXhCMjdC?=
 =?utf-8?B?enh3Q3FYVFRTWStxYnllTjdFcmhrZ05jaldwaFRRUHg3cXN5NmpYMUdCejdN?=
 =?utf-8?B?dFNrK3A4ZTRCRHFGRks2YXRPL25heVlCdlcreUh5RHR2Rk1WbU9CRm56QU1s?=
 =?utf-8?B?OUx4SzJLUzdSR1I0dFNxZTRmQ2Z3ZGhLdHpMOEdOaytmRGFGSDliSG1GVFV3?=
 =?utf-8?B?alVUWlQrYitENmZDWE5xZk5Zbm9tcDBxaCtONGd4bndxS3h5dnFwcE02M0pl?=
 =?utf-8?B?bWl2TmpzalhoeUpRRERGdGRaamM2aE8yN3E5M0syUi9kVyt3TFJHRVdUeW9E?=
 =?utf-8?B?MXFOSWpyRWxHdUNjbmJpbXNFcmloVzBvRngvejlQS1RINklJRXNPelE4T1FF?=
 =?utf-8?B?a3V1dGhUall4dUUrbTE5SXpUODZhWlF4TEZRL1V4dEwxQXJBNlN2dVpjQTEv?=
 =?utf-8?B?UVNzTlIrdlhHTzhndFlOa2ppTndVMUhUcGNwSXpHTDlIVys5RlhMWHA2SXo4?=
 =?utf-8?Q?e7ZLcYZq6zcppnFk=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add9ed0-7b43-4aa2-a10b-08de5510b867
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB11136.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:05:43.7153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: auwTzSU8V3L+WgD/sjJgQZine72Lmbl4zDtJI8SToRSCOVXUbe6N0oiLVSiTyMop5cdst5mLz0kkbpQ9e3pIsQMJ5639i7nIUsR//7T5+Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11489

On 16/01/2026 15:56, Andrew Lunn wrote:
> On Fri, Jan 16, 2026 at 08:09:51PM +0530, sayantan nandy wrote:
>> Hi all,
>>
>> Thanks for the review and comments.
>>
>> I checked the AN7581 HW and it does support MTU sizes up to 16K. However, as
>> mentioned by Benjamin, larger packets consume more DMA descriptors, and while
>> no extra buffers are allocated, this can put pressure on the descriptor rings.
> Does the hardware consume DMA descriptors for the full 16K, not just
> the number of descriptors needed for the actual received packet size?
> That seems like a bad design.
>
>        Andrew

The descriptor buffer size is configurable. The amount of used 
descriptors will be the received packet size % descriptor buffer size + 1.

MvH

Benjamin Larsson


