Return-Path: <netdev+bounces-195957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1B0AD2E55
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6071893230
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 07:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375127A92F;
	Tue, 10 Jun 2025 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gyAv1epr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1427A935
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749539304; cv=fail; b=tXE6D2kRJLkjvBnipxjJVPdnnR77wEXSc+t4vNA/y1zxTpb52Fy49E8IeOi958Ik5Pvf4DGoe/uM+W+ZvAJdMiesTu+sPrYlt1dJkrk0ufX+lLfc2PScXxMywg+APer3dLm2WLqAcsHYrUxZtIYvWodP16UTE4UUwNQyvcjeoEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749539304; c=relaxed/simple;
	bh=v3RjFPlhQ0MdZUr9lIDwSSFxPMLCCQkNwCQONF4BtZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6sDOaayTfEAF941H6V76FLQxph7UfIqY9MNpsFSeBBKbtB3BU3qwppWxMk08N5hrdCaQoaEy6Fp5+tMqJCwpgje0GVBvOXoEFCULc76rBWNhsYcfZ8vybIOLfvrmoDApS9b6R5hEyunE760HdcX6OrvV8s5R6mHM9aMzsasKJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gyAv1epr; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BbDMIWz6JfV3Q9rdGF8DezwY2fT3xuxf+xGH3AkjrziMx7OyPGDZVebR/W6AHgvq74x6098xcqL6CHyy/AZiAhyJ0SVewDIMuVgukyReU5cR9Fy4Zoq1atmQhInAWgC3WDkQ8kg3uN7M7RP7W+3PMWaN4ahKDje/5F28LSfgK91n3EH3Yqq35Y7aDgQYPl0xWD1P1lnYS7GmOLyZ/kD4yB6mlZY3xB11AXa54jJb4qjIHARn7mqBtUyjp/8RGTArjytjbUxWUrZD3LuDzCnutouyBARr9PYB3qPVjKGPWBzBVyvbha2rMEjxeD5mt1CWmW+o+qnS+8zstN9mS47puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAzGsiRBAxDjoNaz9c/KzM9Bf0nR3VCvcqbO9sqxT90=;
 b=EfQypfOZER42I0WG3qunE+cbITMGNCI7pHj+jurh8I89b9OIiblcea/Vp60sGwq7SYpkLdVP9c7V5OY84IYdKU/XBI3spvEqejpP7oHFnw/pRc33IyiONULdGgiRljvG1hY8SV9kQNYjsx7gQyf09eOfq/HKsapJcWkQMwJ8VXAnjOckPtI3qaHGQPmFnbriBnd34rIMeX6h9FIZyGb/jw6+EJq9YUuwwQHBx5qbTOVZxX0nDPULhXpHgDv10bYvaeRSuCC0zcrEoH0pxdWpKMxAnf1E+4itv0hvKqBoTIPaALD4WMF33yRs0llTUzwd1NKPhS+lJU02OjCXm86QPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAzGsiRBAxDjoNaz9c/KzM9Bf0nR3VCvcqbO9sqxT90=;
 b=gyAv1epre3dBGi6QjwV33XQw1HhfFHhV8CEcdq13OcDP6N0Hiv5GywHcsNdHY9sCf1tckHdZbN+JsUDvAx1jpl3tbZpPrsFkhNb4VSjgPoecdv28gS7OLgNN0ZWRC3+KMTNfMMHgUwIlNkDzFQYfvXaMRT1jbhQXuaNXFJplLM5rowJdu2IRRsRnE+W/DKEbRUcEPRa6gc5XsRRPAUfK+VDD/PtNdkNYZtRTTMCOyTfFzv6btffI2G97a7BRxMHxgF1IohFm2SXRRqdI5HiLRCnq44anh+XPe+ZlszTiWcu3/Rz1TzteQJSgWDEMr3vaUTeFU/WMLvin/UN7riQvXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA3PR12MB9200.namprd12.prod.outlook.com (2603:10b6:806:39c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 07:08:20 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Tue, 10 Jun 2025
 07:08:20 +0000
Message-ID: <66a64c37-19f6-4252-a5c2-f810ba6d3d0a@nvidia.com>
Date: Tue, 10 Jun 2025 10:08:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] Revert openvswitch per-CPU storage
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Simon Horman <horms@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, dev@openvswitch.org,
 linux-rt-devel@lists.linux.dev
References: <20250610062631.1645885-1-gal@nvidia.com>
 <20250610064316.JbrCJTuL@linutronix.de>
 <63dcf1ff-7690-4300-8f76-30595c14fec1@nvidia.com>
 <20250610070629.0ShU8LLr@linutronix.de>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250610070629.0ShU8LLr@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0074.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::28) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA3PR12MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: 547a52e2-5a3f-47f4-145c-08dda7ed948d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cCs4M3VjNzBYODVPL3dNQUNNVGFmQUQ4K1BYZVhWK0sxUW5XZmdKZFNwWE9t?=
 =?utf-8?B?VlZKTlhMYXpzRkt4MUtMcWhyd1dwRTBiMWJ1N3V3MFVnUzVlVUgrWHBrYkFH?=
 =?utf-8?B?WE1NWmNlQkxyd3BZMk1ZZjNoYjVKYWpBSGZpQVE4VWFPMndiQ1R6WHY0NXJj?=
 =?utf-8?B?eEg4WTh3V2FaMEY4S0ZVdi81WnBzV1FzVEM5eDVEa2RQMytLZjV5Q2hKajFh?=
 =?utf-8?B?NmtFMCt6OUtrSjVYZ0hvWk1VY0RVVEpRLzE4VU1aYXE3M2pMS3RScjUrYys1?=
 =?utf-8?B?aUxwWmEyU3ZDODRnZXNwZHdKdWdPS3NXTEhJVHpLVDZXUGZrbGN6YVNpYWhN?=
 =?utf-8?B?YWRnenlmS1QzbzMxcXNBVy9zNnNlQVFUTW1rNnhZSnhGZEVJK2dnWnVBQWEw?=
 =?utf-8?B?SDVsTUVZZitJQ3pYRFNkOHd1ckUxS1IwekJSUkNrMnNLVW5oOWE4bFBLT0Rj?=
 =?utf-8?B?V0ttN0JVSkh2MFNjeUJvSXo1TmttUE1MRlZXNHdBeVpjWFEwejg0MWQ0WG1W?=
 =?utf-8?B?S2t6cDdCK25YbHZmM2F4OUsveG1pbTZ3M29WK0cwQjd3NUEzV0tIZ0dRUEpI?=
 =?utf-8?B?YnRaZXFLclhrK1dYZUVHRVVndE84RHZ1MTNxejN1NCthZjVGTmU4clJtNXZP?=
 =?utf-8?B?WmJNdFlkRkFSRmdVVGRxUDQ1TzYxcHBLNWx3alUyWDdmcU9BTk5EaXFlZTI0?=
 =?utf-8?B?Tnp5akttY1BaUG9LZ1hPY2NUKzFJSnRnVXdLUlRLMlg4MnJYMHVLcTRhRE8z?=
 =?utf-8?B?L3ZzQUVSZlgzWU4vY1l6Q3NOQjhocVlmcWJkeFdsaFE3SlNXWS83c0tqd1pS?=
 =?utf-8?B?Q3lxQXJKWVVrVUVwN2Z4OFJoMUI0cVNPRDdRWmtXTnQ0a2hFWnR1QjJYQjRw?=
 =?utf-8?B?bHIxUEhveGdUSDhPd1ZxdEREaEpta0NKTFRWWHU3R3VXRFVnQ0U0R0loTnFt?=
 =?utf-8?B?VS9oT3R6QlJuUXgweTNrODRsYSt2bStwOTl3QWVJRkdyZmE3YkI1MEFqMEVl?=
 =?utf-8?B?T2xaY2loNnRWN3RzZFFFVnhYaGVzWHNtdUJTaXl5c3J5R3FuUGVJV2xyYlJZ?=
 =?utf-8?B?MDRnL0k1cFd1NGpPUHZJb2taaGZ3bDEvVVRkbmYxSUxKRlljZWh0QW1ubEY1?=
 =?utf-8?B?Z013Wnlra2x0U3RrZnZ0ZDRuZW9EU00yM1JQMERkWmo5UXFmVnB3azNOTW1x?=
 =?utf-8?B?QVRjY3BTMWljbXJ3ZFlSUkxhb0RFT0tYUkl3Z3pTbDBVRnhhSnI2cFlWMm9F?=
 =?utf-8?B?WjR4UzcvK216SkdraVYwQmgxb1NXc2k3Sk8rNE9JSkRqSnVtNEY4bUk4Nmpu?=
 =?utf-8?B?aVNrQy9Oa2ZqaWt0ZlhLTCtjalE5RitjS2FNUmFOejh6OFRVdWVpMEJMc2dv?=
 =?utf-8?B?amJaaFNpOXBJZyt2ZGlOWWtWTTVUbmRtWlJaSTBIbWZOQTg3OW1Qa1pQa1BD?=
 =?utf-8?B?aWh0RTI1N05tTmhnZUw1clk3MlVKK2s2cDNWQ25CSVhiK3R4aWR0T1FISnJT?=
 =?utf-8?B?cUNjUnViL2w5ZlFxL3JVa3VraUxzNGNxZ3dVdWhzU3pSL0dFR21ZZ3BMcDlh?=
 =?utf-8?B?dHpyRThFOC9paVc3SUxRaEsrZDJJa3kydjZ6Vk5VeFlmRHM0eW95TVFZTlR0?=
 =?utf-8?B?d2FsUUVWWjVMa1NzWmdxVkdVVHM4YWF3aGwxa0pudXFvVTNvLzhhMXVOTlBE?=
 =?utf-8?B?VGhMRFdEajMwd3lTUHZzZnEvYmdybmZtcnMyTlpQZjFPY3RGelEyMzRsZUNi?=
 =?utf-8?B?dUhBUGI1dG1RaHM3ZnVaUFR6cTJvU25jY0dTUW5BVjdQMUJibDhFN3NHYUQ1?=
 =?utf-8?B?cnNaclVvR2tmVE1taVhjNDFUaGE2TDc4OE4vdjlmNm5LMzh3S0hOSkhmblFB?=
 =?utf-8?B?bkhEYzZpSE5sQmVKMlhEZmJrWXBWa3dWUVRWM3ZsRDQ2YmtoN1AvUDJaWHd1?=
 =?utf-8?Q?Z7MWizPnhMw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXU1a040c0tuelBTVElud0JPTUlUbWRMUys5cmJndGEyd3p3M1p1elV4ZXJz?=
 =?utf-8?B?WlhtSG9iOUp0SVNjdEtxNEoyOHJPcVh1cmNWZTZvQlU4ZVQ5VnpoaE1OVnRs?=
 =?utf-8?B?VXlQVTBKaFl4TFIvT2RKQVA0ZmpkTG5kanVhZ0pVSmk2MjRJNU9LRnhpSDBY?=
 =?utf-8?B?VEN2RWRPT1ZVdU1vNnVWSHpkNlRyelN1ZlpoRFJncWkwUWtQQWFRQUE0Szho?=
 =?utf-8?B?VVJsVEVnY3VoeW5URHk1enRlOEwxbnliWUVDaisxK0VjNWxMY0JPL1JVajdS?=
 =?utf-8?B?U1JYNXJrTTI1N0RPUXo3OUpVYVkrckVQYmVqNFM3UFZ1RFJVeGVKS3p4RkdT?=
 =?utf-8?B?V0h0cmF4NWxxOVI5TXk1Yk1vV01qbTQyQzZZbXVQTnFrSm5qRVZqaTRCQ1lE?=
 =?utf-8?B?ZU44OW14eDNOWEgxa2hsV0lxWTRFd3pFUFlVNzZPaFI0MXhUNW1DM1NCY1Jn?=
 =?utf-8?B?WmM5anhSVXk5aWd0WkxZSEs3QlAwWUxpYzA0dU55WVVhTEN4eEtjK0tFQjB1?=
 =?utf-8?B?ZGRYdmUvSFNlZmkycVdVa3ZZRTcyN09IUFZGZnJRbFdGQWx0eTFRcURvc2ZC?=
 =?utf-8?B?aWdGTWRoY0FGdlJlbHpST1granlIWlNlRERHVlpSN21zTys4WjFkWmJNak9n?=
 =?utf-8?B?ZW9KbnljT3M2RVJvWHVobm1YcHhwVVhYMXV1WDBHVkIxcHJUY3NqQithV0cv?=
 =?utf-8?B?OGpPWUFCYjNUMXFCL29vUVQ0dktZb1JIRHNwekN2Zml6S21NNlVJU1Rmc0sy?=
 =?utf-8?B?K29hV1Q4VEF6UmVzZmNiS0dxYk9HdzNPbGZLTTZqck1iemhTZENPcStVTGxr?=
 =?utf-8?B?dTdVS0o4cEZxMVVPSVRidEtRdUt0U2NlT1JFdUVheHRWTnE0QlZhWFBMU3Vl?=
 =?utf-8?B?bm1IUnREWkNxaVl0Q1BFRnpKQzJwN3JBS1dwRk1kOWxvMzMvTG1teU13VEo2?=
 =?utf-8?B?MTFTemc3YWxITlJFQlFSaFFuaDk5cGxDd2FqK3BKZnc5WU9Bb1JkYWdPakJn?=
 =?utf-8?B?RXVkbEtBeS9sSEQ1QUhhblFBY3VuamcweFMvU3NYcDNhMWNQV3Vtb3dXNis1?=
 =?utf-8?B?UHZBN0Nab1RSRXNRQU01VnNoMG9IQXBmemxTOSt3eS83dHQ3cUtWZjlJRGpN?=
 =?utf-8?B?SUZBRUZjVVU3eklwdEQxcktUTUJtZXZVQzNQVXQ4TFBpV0JiTlQrT1FoME9n?=
 =?utf-8?B?RGlyT0greUJCTGU2VkV3ODBQckF5b1JsTURXMVNqVk1tSDB2RU5vdGR3WWkr?=
 =?utf-8?B?S2pNUWQvZ1o2OGdrcjhhY1JUZnkvN2hMVXVTMURIN24vMnoyVnJvNGhUMXVk?=
 =?utf-8?B?Ly9TenlwMVh4d09RQm04U1dRVitJNFNwQUoxSkk1YUFad2NEVzFNTVB0eGpv?=
 =?utf-8?B?YWJXbE9KaFEzbTFKc2FsYWNSY1UzT2NsUCtweXA5d0d3VUlxbTJJN1lycXlC?=
 =?utf-8?B?ZTJITjR5amtGMkl1TkZvTEptN0ppUCtvSzNRUDNvZWdDL1Q1R3VlNGZzVTVj?=
 =?utf-8?B?aTFHWUl5SUFtenViZW1HU0drektWMDcxVWpmQU45MHRNcUM1amRMck9BT21P?=
 =?utf-8?B?cDRpVWdBQnpTQ3FEa09ydUVzVzVwZ1dqZVZaNjlaT0dMS0hhU290S2VBYkRm?=
 =?utf-8?B?ZjJ1S1VUbE5IRks5eXlKdDJYcllJNlM5dkE2a3BDMVowSm84Vk9uVWdHc09x?=
 =?utf-8?B?VFJWNXZDMUUwOWZkZlQyc2dTd1NheHBzZTJQWjl2R2VZc2ZxRnZEQ0VvMHRX?=
 =?utf-8?B?NUZVSUxNZlBPdTNTN3pwVjVoanZCeElzS1Ziejg3c0xvL05FaHUzeGI2V1JY?=
 =?utf-8?B?aGVEaTZab2I0WnBQcHY2QlZwTkZ2MjVxYStOVXhuYW8yVmJaTWhhS01Rc01t?=
 =?utf-8?B?aVAydWFVWjlyQ3loWXRPTGFFMktQYmZlVDBvTElTcFpwK2M5akQ2dHVuZGxy?=
 =?utf-8?B?VWFpZzJNeEtKeGE1TU84VkhRZGdTdGpHaElDa2x1Z2tjcGdBT253Rk9VNDVt?=
 =?utf-8?B?cXh5K3RDV3Iwa2VLODNBYTVHdjE0UEorcGx0K0NScjdBNXF1SjlVSDY1UWY0?=
 =?utf-8?B?RGsvaWxLSEtoMFV1NE9Va0hBS3dpUHJhL0dsNjZ4cG9RSTR0bjlQaGxPOUdl?=
 =?utf-8?Q?IafgMdZGfIgcG/euHPblO5CRx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547a52e2-5a3f-47f4-145c-08dda7ed948d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 07:08:20.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQkxeM89LWdogs9LB5G0Yv4mGlXjo2aC/Jm6GXM6cVdjopHvIYgi7Hnitc78e5oo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9200

On 10/06/2025 10:06, Sebastian Andrzej Siewior wrote:
> On 2025-06-10 10:03:08 [+0300], Gal Pressman wrote:
>> On 10/06/2025 9:43, Sebastian Andrzej Siewior wrote:
>>> On 2025-06-10 09:26:28 [+0300], Gal Pressman wrote:
>>>> This patch series reverts a set of changes that consolidated per-CPU
>>>> storage structures in the openvswitch module.
>>>>
>>>> The original changes were intended to improve performance and reduce
>>>> complexity by merging three separate per-CPU structures into one, but
>>>> they have changed openvswitch to use static percpu allocations, and
>>>> exhausted the reserved chunk on module init.
>>>> This results in allocation of struct ovs_pcpu_storage (6488 bytes)
>>>> failure on ARM.
>>>>
>>>> The reverts are applied in reverse order of the original commits.
>>>
>>> Is the limited per-CPU storage the only problem? If so I would towards a
>>> different solution rather than reverting everything.
>>
>> I don't know if this is the only problem, we can't load the module
>> starting with these patches.
>>
>> I suggest continuing with the reverts as I assume your new solution will
>> be net-next material, no?
> 
> It is a regression in -rc1 so I would try to fix this on top of -rc1
> instead of reverting everything.

Thanks Sebastian, looking forward to your patches.

