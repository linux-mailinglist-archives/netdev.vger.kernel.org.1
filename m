Return-Path: <netdev+bounces-171297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA38BA4C6D4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84403A8335
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3632321B9CF;
	Mon,  3 Mar 2025 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eBDYHjPb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8473421B8E7
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741018440; cv=fail; b=aWWEImJFFdj3c/ghTK7wu1cYhlOGsqpW400t6/kZJD8do0x63Vj8E6MSXB2QCQTDX27PClNOdpUK06WRvLzthOt/LxoWPn4DKpAhG4lnwOYSd50NajdMBpSOL/LYz9vzRPk/5Np860O+6BvZMna3BNa5jDkSUhNxSDnKHQ+zWeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741018440; c=relaxed/simple;
	bh=DTPl2dJ2wBWMueSkrijklUjeqntGI7bLNAIs5W6J/Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FS/pr/at9uIiNjWLtmgCPp3D/ohD8rGVA6JB1JVwly3Oxy8g0LsGdyqmjSEATK2IcotTD3BwZfWhdrps2QwVCrWZALmGnX+sCAmTYeqv1P2EY738/LPlKRUfGY0l4ON2BqIcD+iDEOXMCUpi2XoWXHl170FO5oJaAhhbBL+u4Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eBDYHjPb; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOwWtVm0f/s5G9VQli5GITBdISlzGt5CSSy4i5+CswwuWhDyG2Bap7Gu8kYoJ6gpaAP9L5qh6RailDArMAG2hI3tlIgC7NhGT6hq97H09yksMpLjcw6GoXTq6bBCOOP1G/gV64lUDIbf9A+zEgBHvd7gyaJVc9dOtMGFrMtciykS5ohaAiHreKO3PFFtMmBPNGurXCFV1WbDTXV0ODIscj0AStk3gwSQYBDK8vRLKyyRHKQTqcLEXGTKyb7WGejyeGOrmUP2c57qa9gv7v+1QVHlyPi4Oyr0IAUW279qEV1+/OK0I6Pew+zMHhZfGX0DiWx19ZG3crbHYGTFpeOs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBy8zsDnVaK4Z82b0FZZs/DgrQeZWCNUfvEphtp/+gM=;
 b=y48C6hacAF0obVSyibaXN7xQukgUtsPGytApD1ynrBNGURCbQJ1wGPfjVFP0tAPIlJKsRD72FwvXVHwrXEdnXqTTqSe36fqk49omtU0kK1OWx7KnS9EFAfCxzbaIeezn84g/YtXh8YtU4OOynE2nywKoMJuPnIZKU4rKV4QM6bNtvcvN3bQGtzIIWd3A7GvT3NeoCGxNifc4BWCr6HESob4x6AnDdHzTZO22ek3NCuirIkcNBlhADh9xXkmLGQ10h6e54Es9oi5Zz1XGUKqHkSN76ke7GmqHk0GWJaHcAg59gebz9QWXK5fjPb1cJW21N5a2b6lCm+ueJODm4HBPOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBy8zsDnVaK4Z82b0FZZs/DgrQeZWCNUfvEphtp/+gM=;
 b=eBDYHjPbkqFV8cHuBP5ZuH4flg7l51wBhOKK1XR3ltMR9XpQQn/kmyVwN035jnodOlWc1DQrTII2+qfaV3pYoUeK/4eWoKu1DiW40lzc6UNMFO0uHpvVsRjTS62I7dqD1ba6cF1xHk1u8h0Za5Ww/askxO5Qaj2g0mBj0j6WKMzM2nhHOFVQ2LDfQWEJvdKywUkU4/c+CP3Y5PDU/BWLS4OMuINMNlfU8pAnBuj2nxRiOjhKDVWrxMbi013B2EHdJIhoAyCp8aF3jHTYzfuDwbRVnroyo5C5KdoxW7ySuz0Se/2O5+ZjArTCLjij0OdlXR15r/ws9ufi2x2Wb5ZCsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 16:13:49 +0000
Received: from DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703]) by DM4PR12MB8558.namprd12.prod.outlook.com
 ([fe80::5ce:264f:c63c:2703%5]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 16:13:48 +0000
From: Wojtek Wasko <wwasko@nvidia.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	horms@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	pabeni@redhat.com,
	tglx@linutronix.de
Subject: [PATCH net-next v4 0/3] Permission checks for dynamic POSIX clocks
Date: Mon,  3 Mar 2025 18:13:42 +0200
Message-ID: <20250303161345.3053496-1-wwasko@nvidia.com>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::29) To DM4PR12MB8558.namprd12.prod.outlook.com
 (2603:10b6:8:187::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8558:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: c3301e05-3275-4c74-99b4-08dd5a6e619b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXhZZXNtZDRNZ1JSY0tVMHF2bk9xeWN4blIzaVlya1IxMXVOdHgxUHVzRkU1?=
 =?utf-8?B?Uk92VHlQTCtrVTJJOFlXV0dHdG54Y2lTNHdZZHJDM2REWFJERnNmYThFYU9I?=
 =?utf-8?B?OEw0WkU3N1k0Si9mU0ZGQzhRUHVwd2pHa0VkZ1ZIRkd2TzJxekl2WDVWSUox?=
 =?utf-8?B?NmlNZUNzckUyQjRJMGVnN2JyQTBlYzZTQk9Md01IdDZBaGJIaXRwNlZ6QTBh?=
 =?utf-8?B?dzg1bkdZWURqNTBLakNwK2Y0VVh2TW5XMkFCejNBbHY5aVAwQmQ3SkpTS0o5?=
 =?utf-8?B?M1JGdWNRMEUrOC8zd1RhU1dhbXlzYWVZem1RYnlxeEtvaWwvWWYvdGFsNnFP?=
 =?utf-8?B?Ry80cC9jeVZWN2YrRmNMVlViTHpEUFZpeTJtVHRSaWZlajRCeVJ4SE1PZFdF?=
 =?utf-8?B?bjhWK25HaDhHS0ZOMUU1VGd4dEVYZG54S1kvSE1YUW5QY2h4Q2FlZ3lPUHdB?=
 =?utf-8?B?Y1kwSWk1NTh0d1JQTUdJWit1anYzaEJoOVBqT3NVNTIxc25ObFMxNmR0Q2hm?=
 =?utf-8?B?ZExML1d0OHVBY2F1WWVrRzV0QUxMaHFyZVZFR3J0UjR4OVhjYXFaUmMwaWtE?=
 =?utf-8?B?Rm5WcHgzc1kxNmNpNWNLTG9vdTAySFlyNW1HTnBEMWF3TVlVOWVkMVFsbDYx?=
 =?utf-8?B?ZUNYRGxob0VRY1orZVVQeDhpYnlaRWhObVUydElsY0xCVHh5THI3dEd2V3Mr?=
 =?utf-8?B?WTA5eHRKVTlFR09sd3FwZ3hDK1gxQ1FkYkY2RDBKVTNraUtCTlVtMXZVek1r?=
 =?utf-8?B?NUsrMUNKbUFHTjQxdEEzREpPVE5DYkdleitHZFB2MG1EUEtNdVgyQkxHUGhP?=
 =?utf-8?B?TFJ1Qkc5N1FPWTBHVk1KU20wRnJPNkFtZnpkT2ZUbUJXRk9YMHY5c1NTMy9C?=
 =?utf-8?B?OHZEU3FYb0xJMHVjbXVaTE1FY0lBa3E1QkZMMXB1cWNjREFTbDJsUzE2eldt?=
 =?utf-8?B?WDVDaEUxMzRaRG81NGVqVzdnZGZQdG5GLzIyQjRVVHRJVXhYbk9MVmJNMk9k?=
 =?utf-8?B?ZE1aNndiUTVkVWFhQnJ6Rk02aW0wOUFzcUNEVnlxMTR3WVU3U2ZoWmtoQ3Q4?=
 =?utf-8?B?L015WTFJdnZSa2tWa3MyMWNkaGw3ZDBweXhVc0VtTEV6bVJQMCtTYi9aRFJh?=
 =?utf-8?B?UVVQelJWMEk5cXNlY3E2d3hvT2FSOFFoZlF0SDNDZ1lNSGxqc0lyTzhKNllO?=
 =?utf-8?B?VG14c1hxZXhEbG5qRUE2UjlXakFrVnFLUUlQQVFqSStQd2hFek11WEpiVXN0?=
 =?utf-8?B?ZWJSNnpKMW92b0tiM2lraWwrN3NiNU5NYnQ4SmdreE1vbFFtTnJCbnh0b1Np?=
 =?utf-8?B?RlN4TnYvdUdYR09OM1pyVGRHb1ZUVVdoVmhHSU0vWlVBQUhPeG5oODlOVWF6?=
 =?utf-8?B?RGtoK1VIMkZrRWFRckxmcFVtVzNsT2hndHFFUTBYSTNCZXJueXFLSkE2MWlx?=
 =?utf-8?B?Z0REc3pCQzZKT09sajlkODVVTTJxOGFja1NjckdwWmt2WG4rUXk5d2NpSU43?=
 =?utf-8?B?RmNwWjU5clZFQUN3c0gvUHBFTUJNbVBja3dSWlBBdTlNMjJDc2VINUtRR0tp?=
 =?utf-8?B?TkRNRGx2RVROZmtHSjNyTC8vdGZnZXdFekNCM2ppYS8wNnRwM1NNTDFZWE5E?=
 =?utf-8?B?bjdkUmtqMkFJeWVvaWc5QzQyZHdYTVVhU0VXemNTSTB4dkw5RnNmWlc4YXBU?=
 =?utf-8?B?dHQzY2NpclU0ajJlUCswWTRJZ09OTTVUV3hIeXNqejFmckhGQWFBanhPSG9G?=
 =?utf-8?B?ZDVVYlpqQlVSWDAxRDFvTDV1L0grWEswU0l2ZTM3WmRwN3lxMUdJc3k1UFF5?=
 =?utf-8?B?Z21zWC9WSm1FUDN0aVBuVHRuUlhyN256Q09WY1hRQ3pIaEo0ZkVNdXdCSkpH?=
 =?utf-8?Q?8BrmnggBEoSCU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8558.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1JaWTVZdUFtVmtLWDN5UXZpVFhZbExYZkJGRVk5SXZFcHp5WWlKZmxQQmsw?=
 =?utf-8?B?elVNUWM3RDJvZml1Zm9tNm83SDFVdEFBc0FaK3ZuVDF6UUhsRnE5ZmMvZFlz?=
 =?utf-8?B?VDc5cEJ5eVBTN3NRZndaZ2xyVjVFMTNITFhsRWdKcUNCWFgvRytwRW5CUjU3?=
 =?utf-8?B?cTFJeTBxZEZkRnVtQmc3WnpsNkhNSmtscUI2QnFBU3BxZGlYTjdqSkJ3SzR2?=
 =?utf-8?B?MnZ4RFJhanJYcjR3VjhXb0ZXUG8zMldTYWFVa1RmdklCVGJhYTF1LytTSlh6?=
 =?utf-8?B?WmZJWWpDVjV3SnVZMW1NNnViVUlVbEt5eXdiak92K0NJRjhsWmVNQitVT3Nt?=
 =?utf-8?B?OGFnT2Q0MURpa1Z1M1drMHJDZFp5Q0xWV0gvWjhwb0hFS1FCUWRWWlBxLy9O?=
 =?utf-8?B?cm9LL2Voa3ZpOXpUL3dLTVZQTlRFNlp3RFozbkhLSVI1THBMeFl3WVpoTU43?=
 =?utf-8?B?dXVTMnBZdldhZTUvZDdDMnpxcEZyQkFyN0pxZmh6L0sxaXNaQ3pYdmNzbFdG?=
 =?utf-8?B?N3VMMFZqeXY1UVQwVzVFTGtXb2VhMUIyekRhOEcvS2Y2d3hjVFRyYzdxd3Y3?=
 =?utf-8?B?NzNaekxGcFM0OFg4VDhzZnY5UWg4cGp1eThNVE0vQURtd2NWTS9GbFV2bE5S?=
 =?utf-8?B?eWk0RU4xTXF1Y2dYbkNQZFhGQTBsUytRVEIxckZhRGhUNWxQZXZiYXc2VHR1?=
 =?utf-8?B?QWVaYjlPNTRKRnZCQXV0SCtmdExxS0FZRnBNbGZrcjlXWjFqZEo1UXF2dnM3?=
 =?utf-8?B?RlR0OVZuZzByR0k5YlhFOVl2NWpuMVlFR1A5ZGJBcTlrMFdtaXZCQWVVZ0ZT?=
 =?utf-8?B?RDh1cDJJL1hRU3BzVEdkTjE0TXBMUG1Ua1R1ZGthUytwRGI1QmRSblFkMUxi?=
 =?utf-8?B?cFlzd242ZzNZYWNxUmEwWTdJRDNaNDZFb0NpclBLVjkvNEtkbS9DK093VjJn?=
 =?utf-8?B?OHN5NS8wRXV0dmk1UUN3S2lGRDc2U2o5NnByd0xEZElNc296TnBLVnFMWGMr?=
 =?utf-8?B?K056dlZBSVdnZ0hNR2sxcUxlSXJlZnVxK240Q2gza2U2cU9FbWhzeE5SRU14?=
 =?utf-8?B?bGRMVk1vQ0xTTk1VYWxtWUJvNFdTYk5jSjlSc01Rd2xLdXdHRDRIM3ZZNkd4?=
 =?utf-8?B?SGF1SjMzaFhDY2JVQ0QxZUZTSE15SEFlNEJickFMYmxXeGNBZlhXRS80K2dI?=
 =?utf-8?B?UjVEdXZ4eHVsdVhIU09yMXFFWXY4VnVWU3hKYUdiTWpLZjRRZGtJV1hRajBR?=
 =?utf-8?B?THNTN2lxVGR4SktXVUMwbFFseUUweWdTVHNjRi84QnF5L0toVm1hZEttdXhv?=
 =?utf-8?B?K014R29SdEJmcmhwZStnM3U0WlBvYXZIRS9ZWUI4VE1sM3hlVlJRUG9kd21L?=
 =?utf-8?B?a1RvcG5QT0wrRS85YTNCZWxEMmJWY0h5VnhKZnM2NzdzTHJ5U2RSZlRDTkhu?=
 =?utf-8?B?dGtpMzh0QzRaUmRpMG5zWDlkeXpYSTJWOTRJSUkzVWJsMHpVTXNvL21INi8z?=
 =?utf-8?B?a09Ba2lZenQ5WFZhYUsrZ0xINzN5SWp0KzV1OFVzTHhsdFpQSXB1UlQ3NGxU?=
 =?utf-8?B?ZVlqU3FzT1JvZ0ZzT01uRlZpUisvdHVHclkrcWRNZ0I5ZXArZ1A1S0d5ZmVx?=
 =?utf-8?B?Yk5Fcy82c1krUFl4UnMxQnA0SGg1NHI3SzZzOFg4VlYwK1Nwa3BDWEtkVjhB?=
 =?utf-8?B?Nnl4NG9zb3BLVFQ2ajYzOWVxdWJiODVEcXlDTVNJV05uRENEY3BoZTNUanE0?=
 =?utf-8?B?OUE5YWlpWXY3NzN1UjRJbjRLM21oRnF6bFdFNGhZakpSVUlRTFltcGdNQmJL?=
 =?utf-8?B?RFdXUkthcjQ4eTg2MWt4a09COHNva1pMR2JzZ2NUZWtNbkFoYlYyK0ZITWhN?=
 =?utf-8?B?RjVEbXRzQUgvelhyS0lUWW9LcUcwWWN4bkpsOE1nNU1pUmYwcmF0bHpQdG5F?=
 =?utf-8?B?ckJES0I0RkpKZ0F3WDRGV2hsK0cyVWd1akxvTStidHdTd0Jib1BsUEJrL09U?=
 =?utf-8?B?VUJUQ3RFTjB4UkNqeVlHSzRQQTROQWZYZ2JzQjc5WHVlOWhkd3FzV0ZvMlQ5?=
 =?utf-8?B?dHoxYjgxclIyc2tBNitYbnExSXBuNmFKZHZDUHdma0pPRFdpYm56TkxaTVdk?=
 =?utf-8?Q?0vrsb4qIr1c7ut0e5icn6s7er?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3301e05-3275-4c74-99b4-08dd5a6e619b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8558.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:13:48.8836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWMjAzGQ5xro2hzk54LxLb/5S+Gyz8ftW9EFahtp4m63MVRHOknysol5PpJdOTi9NrLkHGLEOMnJ8adZqa794g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
clock API by using ioctl calls. While file permissions are enforced for
standard POSIX operations, they are not implemented for ioctl calls,
since the POSIX layer cannot differentiate between calls which modify
the clock's state (like enabling PPS output generation) and those that
don't (such as retrieving the clock's PPS capabilities).

On the other hand, drivers implementing the dynamic clocks lack the
necessary information context to enforce permission checks themselves.

Additionally, POSIX clock layer requires the WRITE permission even for
readonly adjtime() operations before invoking the callback.

Add a struct file pointer to the POSIX clock context and use it to
implement the appropriate permission checks on PTP chardevs. Permit
readonly adjtime() for dynamic clocks. Add a readonly option to testptp.

Changes in v4:
- Allow readonly adjtime() for dynamic clocks, as suggested by Thomas

Changes in v3:
- Reword the log message for commit against posix-clock and fix
  documentation of struct posix_clock_context, as suggested by Thomas

Changes in v2:
- Store file pointer in POSIX clock context rather than fmode in the PTP
  clock's private data, as suggested by Richard.
- Move testptp.c changes into separate patch.

Wojtek Wasko (3):
  posix-clock: Store file pointer in struct posix_clock_context
  ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
  testptp: Add option to open PHC in readonly mode

 drivers/ptp/ptp_chardev.c             | 16 ++++++++++++
 include/linux/posix-clock.h           |  6 ++++-
 kernel/time/posix-clock.c             |  3 ++-
 tools/testing/selftests/ptp/testptp.c | 37 +++++++++++++++++----------
 4 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.43.5


