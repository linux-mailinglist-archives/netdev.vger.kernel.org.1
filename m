Return-Path: <netdev+bounces-128164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32F9978579
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 18:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBF21C21FB7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 16:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C0861FEA;
	Fri, 13 Sep 2024 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s1NldoRt"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F24D502;
	Fri, 13 Sep 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726243694; cv=fail; b=S7cl4jp5fOKSXYOMDYVktquwMQ2MpM/Obt9T3WV2/TCgRhvKNoA87QZwCo6BULGZjx8wz66vE+5SGi3WJySx55+XQD1Ism/S22TmchMPaJJFukwEmGSlg1besjRIAxxMIzvlkp8R61kGvBaFKuOInbA0wMFtrfZo/EaqpzO+DcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726243694; c=relaxed/simple;
	bh=YiQJ+UZBx9Ap6k2seE7vxPQ2KOe1vZzLLM489pRE/0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FGTqwTLgPmSPVT67GdKPXMXEW9PqmcdPLjEG6HgYp3kFWiBN0u76gbMiWuuLBtmGv7g1BNf8V8gSmJPn1DnhQL/Gf7iGVSQprs46Y+hZUIyiVX34KimT32XyHcT8buIEsBqPaYXvzmNW5Gm5ohxQj6Hc0RBuT2NUOrOERngXY5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s1NldoRt; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Frr48OC72uE796Nn6zUctQFZDXUcb4I6oGGGulOLFmIe/u9YiysBDopA5I/34leCdZL8of09xFkSJIqdCZKygPJ1K6F1v1DJUFMWHwNTLc+pL8iJO1lhzD572uKOYZzV60Q9LSMrST1kXFh63rfaDXWw/Gevx5yBfb9CAWJIgG3U+m9mNgoBQWVNloH6BFMD4IyfW9IFx3bQyVcMdfy2GCG844T73beAH+e76yMIMHJW3txK3XeIJemigOv8jePvdRdL9skfW38gLxJgknnLLP2A+K1GEdiaEtDREyiwnzNee/dvT+4Wr8ObjKY7MjLoD6qbT2brYtLiApPO/Egybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGS0ygu8zZftqu2g5lYPOpHkzfU6XeJsTJMl04U7fSo=;
 b=uWaES1APWf8wD+RYDN/uIjHEJX2G2rNT2e1b92Knq0M51K79imJMbUFD0n79aN1hsAULtt3a/hrPDK/67bv6kXYoqFECAdb5oD9P0XKzVaI4zxw8QOXoDCxKhYrLljY1k894lbg/1KzsxfekPR37qVV80CwGjbmGIv+vvD2aE7w+CCLU1fNDGa+l2xIEaNpk6I5Zsh5cOzlAQ5zxxLLxwBA7lM8xYVzyJjT8wpgO96Hq6uR7zqboGbOMeQqZ7UNLL2FxNM19/yQkAnEI7Mrw8srBr0T7J5sBD9SizaGFgQN9ZO4ak6Fo4TJMK73cFl2fPCWX3g9KViQZVeDwNAlhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGS0ygu8zZftqu2g5lYPOpHkzfU6XeJsTJMl04U7fSo=;
 b=s1NldoRt6IS0UUFj++GIgWTOvbqizg89REViNej4+wiK7dG+PcTBt/UUK65RzaCsmJ2yBomb6IjKR0aYd/5suaX5mTTi9INQYE9n5osIBEJvUBgBEHXwFSy+kuCp6w+lZIgiq6z5I2Nrbcd05nMkwE+QfQFWgJ3/gAxf3WtvkB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 16:08:10 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 16:08:10 +0000
Message-ID: <53a6c904-161b-4665-a0c5-fda1cf838654@amd.com>
Date: Fri, 13 Sep 2024 09:08:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: Handle threadirqs in __napi_schedule_irqoff
To: Sean Anderson <sean.anderson@linux.dev>,
 Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
References: <20240913150954.2287196-1-sean.anderson@linux.dev>
 <CANn89iL-fgyZo=NbyDFA5ebSn4nqvNASFyXq2GVGpCpH049+Lg@mail.gmail.com>
 <e127f072-e034-4d21-a71f-4b140102118f@linux.dev>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <e127f072-e034-4d21-a71f-4b140102118f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed19585-6503-44b9-9386-08dcd40e4321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkg4QnBTVFdWdE9qcTUzSnoxUm9MT29mL3BIVWpSanM4bnVnQmR2ckF6Vnkr?=
 =?utf-8?B?V3YraXBUMTc5YkxrZ2xHTVJha1pSSmFTWldrRGE2eGo1VzN1MVJuV0wzWTh3?=
 =?utf-8?B?YUtodXZTdDNiVkUvR0RBWjRjMUNXZDhWMWtIV0tFVGRyQ3g1RXltVXh1L1RZ?=
 =?utf-8?B?eVNNR3hCYmc4Y0k1ZTN0ZE9MbU12QmJIMFd4c2lwYXZsVzNHK1Qrb3ZmcHN1?=
 =?utf-8?B?WW5HdXlUTVN5RDZrblVhY2NjaU1OY214eWhxWGdPdWFaak1Va0U2RkI5WmRr?=
 =?utf-8?B?cEprSVZiNE1xYXh0dDkzdENDdDYwdzBYeUtIRjhhbDJpa3BEa3hIUzYyT3lO?=
 =?utf-8?B?Y0MwV3dYTzd0OWgrcGgvTndyMFdpOHdnMnVuSDA3MlZDOWlWbWUyVXhUcnVn?=
 =?utf-8?B?K2NwcUpyc25Jd1NYdEx0emdyTmNYbGZUNTA2NkpNMU1xdGV4eGNjMWhDTS9H?=
 =?utf-8?B?T04zbXQ2alRrYktadHBJN2lGaHhkMnIwb0laTkZ1SkhmVmxYazRCa2U5ZUN1?=
 =?utf-8?B?cWFkcDZ2VFlmM0hId2RFVFRIc0FsbWV6NnE0YTZPNzNxbDltZElVR2U3WWYy?=
 =?utf-8?B?Y24rMVkvNHdGZWIxZzFWRzMzcnBYdUlXRU1iTkJJSUQ5blZMcTNMTDhHdEFM?=
 =?utf-8?B?TEVRZlJ0VWd5Wk4xU29pTExzaXNLZ3VBNlJhNnI3ZVdhRCtsMmN5d09rQkgx?=
 =?utf-8?B?ZU8xZFVqTUtGc1d3UnZHNXhES0VlMG10cklwang1cyttL1dyaWFvNkxydWY3?=
 =?utf-8?B?c3d0Y0NXdlpDbWZzZ0Y2WUxRQlhlSndLQVFzNk1iK3RUUTNiWUZRZCt5SWg3?=
 =?utf-8?B?QlBGT3QwMUVuUE1QRTdsUjA5RnV3TlBvTGpCbzN4aDMyRTlUaGJlTWJoT0xO?=
 =?utf-8?B?TFZIeG5ndm5PTlAvN0V6VEp5cjNnakQrenVXL1Q2OGdySk5PVkp6TDN5d1hZ?=
 =?utf-8?B?RGdRTVV5K2lsZG55d0VBYmpxeDJrK3VNQUV0QjZ1cDBCWVk1QzdCOFh4MHRl?=
 =?utf-8?B?ZDZxbERKenpKTURlZ0R2Vnh1VWhxaURzTnJxbWl1WGpNWHArN1JzY2phWjBI?=
 =?utf-8?B?bThDbUxPdkkwTWRpN3RYNzBCdUNmcDdlTjNCUUNYMDhzTit1V3VUYUZVZEJM?=
 =?utf-8?B?SVl1aDJESW00c0ZyUFV3NFNFa2U4aDdjYkZVV2c0Q2ZxSmRLMzBHU0RBWmtQ?=
 =?utf-8?B?RXJLYSttK2FSZkVJT1AxQ1A5cHBrL3Vvejc4NWt3NlZzUmJiOE41ZGZzNm9L?=
 =?utf-8?B?bEJBZWNPUTJGY082cjlrNXQ0Ny95aHNyK1pRdGp3WTFUR1JxakR6ZkdIZEJU?=
 =?utf-8?B?dTFmTngvbFBwNkQ5RHFzcGk4NDRxS1IzczR0ZnFTQVgyZEZFQVBIZjdIVzBW?=
 =?utf-8?B?ejZBY3hNbWVJVGNoZm9GWTVSaE5hMU1kSnN0WW9aaGZVUnFuNnZnR29EZEpM?=
 =?utf-8?B?LzFoY01oQkJKVEJMY1RkMS9aNnBQaG9pNk9adWdTajYvRmxGOEhnQ2ExWVMy?=
 =?utf-8?B?cG0yZmdFdjZrZ0svbWg1TnZWc2xUTlBmdmxuT3lsaEdHem9JSjZzVGIxUncr?=
 =?utf-8?B?aFRuSTF3ZTJHUXBIOC84QnZ5S0lJSzYrYUdyYm40SzJpeE1VZC90eUVPZ1d1?=
 =?utf-8?B?WTdkeDN0ek1DSkJNYXByQ3pFUklGeTRNd1RUWXhoYTVpZkkxeE50MXNwRXJC?=
 =?utf-8?B?ZXpGQkNIQTVDZitmbExObkdKdXpEM29YVENxTkp3UitEWTdmT0tZbjdGVU1l?=
 =?utf-8?B?ZHluZDVoVWRTbkdsKzNDdDlST2ZOK3JuS0ZxdmpFcERvRzVmSjVYaW14azJK?=
 =?utf-8?B?Y2NoSlp2ck40QkQ1L3ZwZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0g0TkpRT2Evd0l4WXZ1aU42dWt5R2VRUEtDb2NPekdhb1c5bkV3eGpNcElS?=
 =?utf-8?B?WjJUdGZhalgyYS9xejBDYjdrWnpjc3dxRVFQL3pPYmJzakM1SXZacTdlTmYy?=
 =?utf-8?B?U1NCRGpRekdGRGhkbzFqbGhpUDlSNDN6RXJieUhkbFBBQUhDTGJnd1N5ZVRM?=
 =?utf-8?B?STk5Ui8vNE9GMTJIU0RndEp1OEQrK0huVUZrclJXNkU2M1RUd0VWVWU5dEdm?=
 =?utf-8?B?NnlaRitCTHUxQVp4TVN3eGFoSFRLMWg2MXNhNUdDcFJjZXZCMFkzZHVNK1o5?=
 =?utf-8?B?QjFVNkU4VEttd1BoeTh4bjRlMFFINzZWTHVoMm1Kb3ZoZU5xN0NEdWFNYkRD?=
 =?utf-8?B?N0xBcmtmbk5wK0RJTFRvNXMwRUVvYmd1bDlKWWVSUVVsc1pTUTlDZldJT3hx?=
 =?utf-8?B?Y2R1cGJROWp1aTRJbE40Wm1makh4NUpQOVJ0enM1elo4MWpET29waFY1ZnZy?=
 =?utf-8?B?MG1KenloUlFpc3lsTmVMNHJYNnltYjAvRnY2SHlOV0RON0h0L2tjV3lrU0hO?=
 =?utf-8?B?Q2x6emg2dnFwNTc2WUgzOUdrMkxERm85c09XeHgyd0FqcCt1WXorSkluY0NT?=
 =?utf-8?B?RUFORUJNZktMY0U0bWlDMTluMmlud2FzWkV0Tytyai9DQnBZdlRtRzNYOEtD?=
 =?utf-8?B?MHQxQ2xkejQ5dEM2ZUY5dmVvRGFNbi9kZmFCWmVrK3BabU5BdTVXNzNWZURx?=
 =?utf-8?B?Y0s5ZUYwaUxQRXU5QVY1dmplV3RYOVplVHgrNXFJSjFrcmJXNndjQThVVDd0?=
 =?utf-8?B?U09uZWtJS1ZnWHF2eWtXQzlCbTBPOXQzRWs5Y3lKM29mRkpZZU9lS0pVc3FJ?=
 =?utf-8?B?VTlNQkZBSG14bEZZMzdhRFo3YlFzN0hqbXBhV1JJYSthdlNhMjNVMnAzVjdV?=
 =?utf-8?B?SGdFdkdpS2lGc2JqS3I1eEZhTDF4d1hjT0NVWnBXTnM2QlR5ZWtvQTEwc1Bn?=
 =?utf-8?B?SnFHRy9TUkNJcUxha3RkTVIzRWErRFR2VWVTMXlocnVBemxMcVV6ZWlNN0Jq?=
 =?utf-8?B?TFpuN2VBd2Q3QTIvcmUxeThoWUdDSCt0R0prVTBKeGVKcEpuRVdXYU5aK3ZE?=
 =?utf-8?B?TCtzSWZ4NmFkL2RqbDM3eXQvK3FsMVAyOUJVSEw3VTVvSjg3Z1k3dHdFQVBw?=
 =?utf-8?B?ZGcrcHdqL09OU2hBWk5Tbjl1S3d6ZUFzQ2R0eUk4YnhlYVA1bW1Dd0t5THpQ?=
 =?utf-8?B?ejBXNC94TXl4ck5FcUZ5dnJnLytKUHRaUWxXeFVyMkxIN0JxM3N2a3FES2lY?=
 =?utf-8?B?V0R4VEpxSktjUzBiSTVpL0lYL2pTYVVHT3JSY1B6MU9hMXhsRE9rQ0NCSnFx?=
 =?utf-8?B?c095dFlsZ0U5VzhxRzFwYUFDWHNBMzdRVDBjUGpESmpZd0dqajBtdEZPbVMz?=
 =?utf-8?B?RkpMNUFlSlN3akUxZzQ4TkNuWC9BYjlMOVI3SENHcU12QU4raDBJTFhYVzNW?=
 =?utf-8?B?U3VRc0Y3b0VmNjhQU29ITEpGOU40OUIzMkxsZDBzMnl4RDBSLzc4SWRCY3px?=
 =?utf-8?B?eS9wV2JVWG5PcTZHWUE1ZDR3M1pUYjBoS3lQbVB3dmRzZWxtalFoMkhoQlIx?=
 =?utf-8?B?MnlZZGRlRmxWVnFYa0RsQWN1S0piKzhxMyszWXZOMXduVWc0S2QvMS96QUps?=
 =?utf-8?B?SXZSbXhjSmt0ZWRTVzErNld3aEk5M2xYYlBlSG9Td0NYNTA5ZkVVSWhlTCtl?=
 =?utf-8?B?UlVaMy9ONEJkMjVQd3RHbU5ZZjRWY1pqY2wzclhYZFkvRXJJaThsaURFUDlD?=
 =?utf-8?B?Mlhtdzd3bVFPU1BBYytaam5XM0lvdmN1dkd3cStNUi9HZUdTMG1ZcGlsODB6?=
 =?utf-8?B?bWd1WDRrZ0xaaWcwdDZ5WDFvRDJPMEdpUmRMa2N1aHhnVC8xankxY2dobGdO?=
 =?utf-8?B?UWwzdjhCUmxQVHZhVzBKQ0xrQU5HSCtzVFYreXNydkFWcDFwVjFCVWZCVE95?=
 =?utf-8?B?aTBpSHg3dGRhZlpxY1R5YitrT1RBdUJvbDVDd2lvd0tRd2NhV0RuS3Jnc0V1?=
 =?utf-8?B?WFhKcG01TmpLVUJVMU1oaXA3Qnoxc3E5RVVxMWx0eGFhTG1BeU8xYzEvU0hG?=
 =?utf-8?B?ckdTbHB3cGJuKzNFWFB4ZElkK3RLcnFoVzRhNjN0WVFjY2lDd0w3REcyQ3pH?=
 =?utf-8?Q?ezQKif9aqTE3Ou/9wdmOHSz75?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed19585-6503-44b9-9386-08dcd40e4321
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 16:08:10.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0u6RMqPtev7xXYKspR2SOrA9MDAgIQb4K4L19IRyWMPuvZXu/kO9EW+CQRvyfyXsbDngH/w+Twl6MSH2kTd0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197



On 9/13/2024 8:23 AM, Sean Anderson wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 9/13/24 11:16, Eric Dumazet wrote:
>> On Fri, Sep 13, 2024 at 5:10 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>>
>>> The threadirqs kernel parameter can be used to force threaded IRQs even
>>> on non-PREEMPT_RT kernels. Use force_irqthreads to determine if we can
>>> skip disabling local interrupts. This defaults to false on regular
>>> kernels, and is always true on PREEMPT_RT kernels.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>> ---
>>>
>>>   net/core/dev.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>> index 1e740faf9e78..112e871bc2b0 100644
>>> --- a/net/core/dev.c
>>> +++ b/net/core/dev.c
>>> @@ -6202,7 +6202,7 @@ EXPORT_SYMBOL(napi_schedule_prep);
>>>    */
>>>   void __napi_schedule_irqoff(struct napi_struct *n)
>>>   {
>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>>> +       if (!force_irqthreads())
>>>                  ____napi_schedule(this_cpu_ptr(&softnet_data), n);
>>>          else
>>>                  __napi_schedule(n);
>>> --
>>> 2.35.1.1320.gc452695387.dirty
>>>
>>
>> Seems reasonable, can you update the comment (kdoc) as well ?
>>
>> It says :
>>
>>   * On PREEMPT_RT enabled kernels this maps to __napi_schedule()
>>   * because the interrupt disabled assumption might not be true
>>   * due to force-threaded interrupts and spinlock substitution.
> 
> OK
> 
>> Also always specify net or net-next for networking patches.
> 
> Ah, sorry. Should be net-next.

Is this worthy for a fixes/net tag?

Thanks,

Brett
> 
> --Sean
> 
> 

