Return-Path: <netdev+bounces-178682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA4A783A6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 22:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADD63AEBD3
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFDA21D5BE;
	Tue,  1 Apr 2025 20:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jGDT65Q6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE331EB182
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540594; cv=fail; b=J4LP7TCUIzWepCtzi1sQKNnAelZyGXE1u+mUsUmYRyA9lCmzEHBxsz/IXFAMwTb2rte1okXJeFCgBrSD7yVges8gt/w/csSeo4kIZ1gQ45meyOfpKPg37fGrrAhzpfoyj8bjM0Mey3AoF53YCRhZAEDJfqd1tcR5AUAP2cKq7X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540594; c=relaxed/simple;
	bh=bN5zLFyuWfJMWuBq9en6dOr5rcjrjfAvZrAM/7Boe2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IL5BwCUnLkjRI6KSw9LlwGxhpjAatk2v1LwccboYW9H5NbozJHZ4J94f3ewxSOgAwqR+rwJSxZO42zaPlzFZzfbYFVs83hFfWLWUKTsoEmq4jU/ubMnUN42uKmz6Tkx7Inhl8PlHmvXdHVVFscsrB9NMculx5oU263w/9Ia8xK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jGDT65Q6; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9yqTleramKYvNa1PbKZJHQ/+8rhsUS+QxQrXScdjCUmwVdHBLddQIdWfvTM8VYxB4fTkmewYiAefZhk0/h3/M2x55W+ZXhK4rIGUQQj2EVPG4djQatV0xWNSQqmjaLH/anwf0zlvtkNt2Ic/GYGfZif6Ks/NgLQ572Jj3GLhw8YWTz+nkL5AJXIfkJkSmn1kZZiK4F3HERkRojka2BXSh6Yg6W9PCQgHZ/vP9cAwnlJuvkF0Vg69JYSTsNxNvSb9sp+sNjUc4CrgkzR5SskiUzSivLetbCw05ylN682jo1U4xAZl0KeDFqaBsLfkl5jhBF59R54AYDziNCtypwXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUP8ibrdiRQp6MoJdBuw7+G+zx9SjJc0yYHQCw/ax9Y=;
 b=rWyQQsf+/tyii+2t1+EP3m1H+Rj5BJ6E6ohIJazHVWuLYCPCBwMtJv6NmJSvR63xMtC1I+OfRTtArKZGjgxqTGwyj/RnL2Tz0LWiqdVX2/MQNabEYeLIcLGtC5HGlIpgfyEzqqmvtUa/lgAVSxlg1H7ulNx+uhCfI2+ocySCltX3kX/An1Ligil30vw4FI5To6LcmuSFnRi2HZx1IGQDItU0lQj6nFdcy0zITozvwhqMXCQ1Ec5cXGHqWQusmM5uXBEbdRUgy+Yr7G2l5a9COV6WNC5/HeGkoR2jTfupLl60rAZZyjDuP5945Ggwpns1bKJOA/Ez1ECEejzUpx5Lhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUP8ibrdiRQp6MoJdBuw7+G+zx9SjJc0yYHQCw/ax9Y=;
 b=jGDT65Q6MvhCU2QFUa619fcm79AUuOb40iGR0lWZ0isgmS+fJYcFItq917iidEVTibKMnW7NxNDY6YGc04KhHEoOcNq3CMW/yaOUO/gvSROrmDfsaRNAiP9fnWewivjGeQdleM04c48vJBMXZ9b2nrSBWAAhUs4J2HzH8cKl0fnaak3TQfbGr776EZYOSK/N0qH6W9v1a2Ac6T3pF/W8frCvNe55kBrRIFitfyDCJxd3DgWczxxGmKzKaYLU5MUPsOxFISfA+VyhRqcL8bzt9N8dR3WSAWyHcKwJQNhJsld+KMClhmaMRee2VjWJZfCRgmq2GHXnNqD9n8owwdgNWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Tue, 1 Apr
 2025 20:49:48 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%4]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 20:49:48 +0000
Message-ID: <6ce063ee-85cc-4930-839a-36b3155c9820@nvidia.com>
Date: Tue, 1 Apr 2025 23:49:42 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>, edumazet@google.com
Cc: davem@davemloft.net, horms@kernel.org, kuba@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <CANn89iJt72meYXVex-K4JyQ-tR+J4bgHFR5PbcN7EYRGfcL5Tw@mail.gmail.com>
 <20250326223225.75860-1-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250326223225.75860-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|DS7PR12MB9503:EE_
X-MS-Office365-Filtering-Correlation-Id: d724a2cf-8bdb-4ef8-ed03-08dd715ebdbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bSswUExyazZqSTVTM0FaQUdEa0F1c2hpMlVJS0pFZGFMYzlMMElMc09GNTVP?=
 =?utf-8?B?WkxtbXEwWTZtY0JZVVNhU1lmaHRlZm9qUGNaTnZsMjd4eWNKZk5vSGY3NGFS?=
 =?utf-8?B?eFFEWHhYd1Y5bWRJWVYyVkY4QUNCektMTE1KWkZBV0pSVzY0R1JnRCtiZXRK?=
 =?utf-8?B?V1QvRHlrTEJrSDhWVjE2VVFHY3BSa3VSV2FlNlZNRkVCa1hDdHNWeENIb1o5?=
 =?utf-8?B?QnlhUEp2bHI1ZkxtYnZUVzIzQ0g2MlBOTUdEcG0zd1lSWFYwbFFqQXBZczdE?=
 =?utf-8?B?aXM1bTVBODhFak5Qam14dGpMNUd3OUVwV2VPR1NFTXQzOHNmN0lkSlFHU0Jj?=
 =?utf-8?B?V2JSWnZKREhwV0pJVmc3TTN0M0xqZE5GMmpramkyMG1VS1QwcnI2U3hVN08y?=
 =?utf-8?B?ZXQ3TWRURGQvNjF6ZTBPaDRBUzFZU3h1NWY3bUlJUmx0d3F4QzJTSEYzTHVx?=
 =?utf-8?B?dzlLTnpHSnhFWmJwZkRGZGgwa2hzNFk1L2dVemM5V211NUxFdlFHaFQ4Q3hT?=
 =?utf-8?B?aDNuNHBKVUIyMVIwVDhvK2NpNGNvcmljdmFvV2xOajNobTNseG1iSTJPOXhy?=
 =?utf-8?B?THp5NFVKaGlhNGF1WXhteVZ5YjJLZXU5YXZncmtIcEJYM0FPUDFLMnI5VkYz?=
 =?utf-8?B?ZGFtWG5jRXg3V3pXcXMvMmo5OWZvbldZa0p6L0Y3UVU5amxUU28zbW1TOTJY?=
 =?utf-8?B?NllJSTZycHVmak9sQ2tVeVpUSWMvY3lmY24zV2hCZno1QWRWVm1kdEdXVzZM?=
 =?utf-8?B?WDFoSVZ2Q293SC9TUzZTL3Qwd2JiSjF1OW1QZkNLbWhWQi85MmcwSUdUZlNs?=
 =?utf-8?B?RnZGSjNENE5ETGdiWU9QTnNnTW8xeHl6cldIeDdBSm9WcU5KR2VZYWY4ZnZT?=
 =?utf-8?B?ZkRzQUc2ZDlQV2xQdjRYL0dzQThaTHBFc2xFWUQ0T1ZsVUlIaHpVaHl4VEVL?=
 =?utf-8?B?aGNjV3dLL2wxYXRXUmxoZ0JldzJ6NDg2Z2lNSy9TcUVacktkQkdodU1tK2Jn?=
 =?utf-8?B?M0s2V012dFhVT1BObkZpRjV3VlhWWFcxWVUzMEc0ZFUzWEl2TWFtS3VIRUdF?=
 =?utf-8?B?WmcwYlNGVU13a0F3T3hCRmcxMGVPeUt6V05ZMTlBVUQ2UXAzSEYyMjQvVFJM?=
 =?utf-8?B?b3NpWWx2ZGp3U0hFRnBaWENHVFFJSXFvcnN0bjBwdUhHRk1XcHo1cUovbWxL?=
 =?utf-8?B?cTlUdkJEZlFCUFVIRlVHcGtNWDZUQ084NU5JdC9VRloraE1HUEU5bldJMFE5?=
 =?utf-8?B?bGxGTHRRNHpxSTBldFhrb0NqQWVIdkZpc0FZTExhaGw2anpvbTBhQzJmT1Vv?=
 =?utf-8?B?d0FtR0pLUjBzdDZnNzJMbG9pSVBOMkdhVjJHZHR1NzgxRkk4RldvNWUxaVJQ?=
 =?utf-8?B?VHAwd1VHUk9KOW5Wd3NPMHNBd2l2eFZ4TlZLeklDVER0QUxHRjRoQzVJZUNY?=
 =?utf-8?B?SnpRRHhwQVphNkErcGMzdTBlVk41WWc2a2djcUtKL0dKTk85azVocHYyelFy?=
 =?utf-8?B?THdONkU2OHB0dk1tdzM0Uk83Sy9EeEVNYW9XMFpDQWtGQkZIeS84bVBJL3kw?=
 =?utf-8?B?V3owZ0RMZTkvTjhFb3VKTlM3K3FVa2JkNXhwTDloMGNVYlJWTWprRmlubFhB?=
 =?utf-8?B?a093UExWajlnT3dJWjdJZm1lL2c0eEg0WVYyZ3MrNDI4OHNXNzdkUUV4eURo?=
 =?utf-8?B?QUk0bS9NcWxheW5aaFJIRkpGVGlQQ3pNNmJKMEhmS3laMmFLeGpVUmVOaU5j?=
 =?utf-8?B?ZlZnQU9DYWtybkc5SzRFQnhPNm53SHMyMml3R09yTmEzTnZKNTM3UVl6MUZM?=
 =?utf-8?B?bjZ1UUhua21pUTNNQ1owNk56Wi80MUErbkpvV2hkMys3THJqaStOTTk5aFdi?=
 =?utf-8?Q?kTsOztRYWAblm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFdtYXh5cGE5KzhiTU1uZlg4ZExzYzFoSjJpSnVYS25UVFdiU1NhTVFGYlIv?=
 =?utf-8?B?WlNyNHdjaDhwTzgvRFpaL2tRRnRGTjVsTEF3eEcrT0IwOFB3aFoyYTAvQVpL?=
 =?utf-8?B?Rnp4MGdLZCttY0NaOUp0RWh5QXFPMnlxNnhUems1OHRBaTVLblhLVjJnL05m?=
 =?utf-8?B?UkxOT3NxYmJCdnBzbVA1QThxWStLaGlBL1BJczJXU2hmSnNPbEZQN3VwMTFK?=
 =?utf-8?B?OCtURE1aRFJDSDdiVGxqTE5lUGdvUFBNRXlIRVkwWllqcmdpVzlWKzg4bDFa?=
 =?utf-8?B?bHJxZUcvdkE1QktZemZTRUlTWUpqam9HVzJzMVFwQmxCRGZiM3JtMm1KeURP?=
 =?utf-8?B?NHZqZFFnSDlWMkFnL3llYUFKbnZWVndxa29BL3Q2YmhtL0ErenRzcW56ZjlX?=
 =?utf-8?B?TmVBOEJ6Y1pzWXBqa1BqMVRlblFqVkVvZDQ4OW5XS2pUVytXUGVwTi8vRzFo?=
 =?utf-8?B?RFdLN2ZkZnFKZVgwUGM3MzZ5c3NVSnRwanlrYnQ2eGZrcUsxVzdmL2luMzZo?=
 =?utf-8?B?RElLYVg3SzlNYUlVTUVjZC9Kc3BJK3AvSkkraG1IVDVKdlVXZTRhVm1MUFM5?=
 =?utf-8?B?eldPbkhNNW9jNExiZ05mNWR2UHBScE4ya01WNlV5U1ZPUVIxSUtickJOK0V0?=
 =?utf-8?B?a0pBYWhRTklIMHdYNjhnY3VQbTBZVU8yVy9ka1hkOVdYVFlKVVJPQWZHbTlL?=
 =?utf-8?B?Myt2YU96QStrbjhkczgySE1uTUZBMmhObE1UcGZsSHdhNW0wL1FrOWFFSmJ4?=
 =?utf-8?B?K0l3WXhNTzdnVGVjOUt6N3lsdjB1bTRLbFQ3SUxvVnh0ckU2RjU5M2ZHclVJ?=
 =?utf-8?B?WGRsNTluQWVHY1FVSzRvMnBWanRJcEt5bFpqWWNrTUIzankvVnVLQ2JQWHRn?=
 =?utf-8?B?NStEUThBUFhJMDZvZHdiMzE4VXJlakhTMXl2MVRuYW0yL054VU94bVdUUnND?=
 =?utf-8?B?anN3cklIdk4zWGtCcU5QbW53YUtrU3ZESmFVUmh6blZuREM1NEhaSTF6aEYr?=
 =?utf-8?B?NlVwczBmYnFXS3hyR2ZuMElDRjdvOUFjQllER0c2S2xLTDlldUdsUGo1ZGxu?=
 =?utf-8?B?azV2RjIxVGFRNVlDcUIzVWNzN2ZDZTZFOVltMFQwOWt3ckUxMnpoK29HM2tq?=
 =?utf-8?B?eWlOSjZVbDZwOXJid0VQWmNraDc4VXkyVkFLcUJHQXA5OWlVVWk4NGVseC9l?=
 =?utf-8?B?dTMyemFNdjQ3R2lFOWlPTXN6K1E3REY0QnJYTlFIWkZtVjdDMVBlb2MwTEdt?=
 =?utf-8?B?MDNyL001RUNJb1dwM3cwR1FlVFFtRkVrSXBVeU5xTjhUem84ZnBMd1V1Skw2?=
 =?utf-8?B?RitNMU94QzMyUUd4S1pIcjRGTURrZ1hIZWFmemRnSlVjN1l1MmtjeU1TaGd2?=
 =?utf-8?B?NTlkUXBYUmYvUGNWTllUTUxoWnJFU2hFd2o2UjJ5MjVqVGFidnRsS1JmYXda?=
 =?utf-8?B?ZkVTRlFaWWhMaHV4eGpmenlXWWh4MFE2ZG1sUVFZK2pPcVdwMzVjNkkrVmc4?=
 =?utf-8?B?ZnVvWlczMTZOUWliZlA4NWNpbW4zNlNTNFlqRTNxVU1CRUl4MkRJVmhTQnZF?=
 =?utf-8?B?cUJYeFhSTHBTRG9TNmtQdU1Ybk52ZEJxcDdSajR2YUFIY3FsWTRWVzZIeVdQ?=
 =?utf-8?B?RjZGdlZTR2xkSU9wVGNubDI0eWs0U296YnN4QnpadWdwZWg2ZHgyOEVtN1pL?=
 =?utf-8?B?U3kwcU5TSWovUEM4N20yM3VyRm4rOTBOM0lSSTZGWDhEWkZqYXFTTEQyR1N1?=
 =?utf-8?B?aUJNNzZqZmk5N2Z3R2wwSTRMdHdmd0dqaWFwdGMyelkweWc3clNLaDhaeHRX?=
 =?utf-8?B?N1JUUTZCUUhBeE5Nbm03UDJ2a25BT2ZkQ2RqdUVDNDhEVCtkY1ZNY2pMZzhG?=
 =?utf-8?B?YlZCRXp1ckZDaG02czdxaHNZbWlHMWhnWkZQYVZTSWMvekl2U2hRWjZmb00w?=
 =?utf-8?B?Umg3NFNnb2R6NHJERWJBN1N0ZklNSm92YkthWjNqLzBnUlRPNUpsZ3FObUc2?=
 =?utf-8?B?R3p6OEdWZ2d4Q0FsbE5vTUxUZHhjMGtkdWRrL200Z3JHSndBMmlRN0psVjU3?=
 =?utf-8?B?emhKdHZKOWVvZjdGcDN1eDlxRTJJZFZZSjRpMERQSDRLbTBIYTdHRDdCcStQ?=
 =?utf-8?Q?XE+6+TxOi+/R1zSsAAIg1nnjw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d724a2cf-8bdb-4ef8-ed03-08dd715ebdbe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 20:49:48.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33rG2081JsVevCRJq5J13BbvYgV2LBcfwxnR17hG/LE4EEV/rnBur5+5Sr2yZBE2yfyGvADAmNLUvJWDBvOfJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503

On 27/03/2025 0:32, Kuniyuki Iwashima wrote:
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 26 Mar 2025 23:10:04 +0100
>> On Wed, Mar 26, 2025 at 10:55 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>>
>>> From: Yael Chemla <ychemla@nvidia.com>
>>> Date: Wed, 26 Mar 2025 15:46:40 +0200
>>>> On 17/02/2025 21:11, Kuniyuki Iwashima wrote:
>>>>> After the cited commit, dev_net(dev) is fetched before holding RTNL
>>>>> and passed to __unregister_netdevice_notifier_net().
>>>>>
>>>>> However, dev_net(dev) might be different after holding RTNL.
>>>>>
>>>>> In the reported case [0], while removing a VF device, its netns was
>>>>> being dismantled and the VF was moved to init_net.
>>>>>
>>>>> So the following sequence is basically illegal when dev was fetched
>>>>> without lookup:
>>>>>
>>>>>   net = dev_net(dev);
>>>>>   rtnl_net_lock(net);
>>>>>
>>>>> Let's use a new helper rtnl_net_dev_lock() to fix the race.
>>>>>
>>>>> It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
>>>>> dev_net_rcu(dev) is changed after rtnl_net_lock().
>>>>>
>>>>> [0]:
>>>>> BUG: KASAN: slab-use-after-free in notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
>>>>> Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
>>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>>>>> Call Trace:
>>>>>  <TASK>
>>>>>  dump_stack_lvl (lib/dump_stack.c:123)
>>>>>  print_report (mm/kasan/report.c:379 mm/kasan/report.c:489)
>>>>>  kasan_report (mm/kasan/report.c:604)
>>>>>  notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
>>>>>  call_netdevice_notifiers_info (net/core/dev.c:2011)
>>>>>  unregister_netdevice_many_notify (net/core/dev.c:11551)
>>>>>  unregister_netdevice_queue (net/core/dev.c:11487)
>>>>>  unregister_netdev (net/core/dev.c:11635)
>>>>>  mlx5e_remove (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) mlx5_core
>>>>>  auxiliary_bus_remove (drivers/base/auxiliary.c:230)
>>>>>  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
>>>>>  bus_remove_device (./include/linux/kobject.h:193 drivers/base/base.h:73 drivers/base/bus.c:583)
>>>>>  device_del (drivers/base/power/power.h:142 drivers/base/core.c:3855)
>>>>>  mlx5_rescan_drivers_locked (./include/linux/auxiliary_bus.h:241 drivers/net/ethernet/mellanox/mlx5/core/dev.c:333 drivers/net/ethernet/mellanox/mlx5/core/dev.c:535 drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
>>>>>  mlx5_unregister_device (drivers/net/ethernet/mellanox/mlx5/core/dev.c:468) mlx5_core
>>>>>  mlx5_uninit_one (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) mlx5_core
>>>>>  remove_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:965 drivers/net/ethernet/mellanox/mlx5/core/main.c:2019) mlx5_core
>>>>>  pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-driver.c:475)
>>>>>  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
>>>>>  unbind_store (drivers/base/bus.c:245)
>>>>>  kernfs_fop_write_iter (fs/kernfs/file.c:338)
>>>>>  vfs_write (fs/read_write.c:587 (discriminator 1) fs/read_write.c:679 (discriminator 1))
>>>>>  ksys_write (fs/read_write.c:732)
>>>>>  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
>>>>>  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
>>>>> RIP: 0033:0x7f6a4d5018b7
>>>>>
>>>>> Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
>>>>> Reported-by: Yael Chemla <ychemla@nvidia.com>
>>>>> Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
>>>>> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>>>>> Reviewed-by: Eric Dumazet <edumazet@google.com>
>>>>> ---
>>>>> v5:
>>>>>   * Use do-while loop
>>>>>
>>>>> v4:
>>>>>   * Fix build failure when !CONFIG_NET_NS
>>>>>   * Use net_passive_dec()
>>>>>
>>>>> v3:
>>>>>   * Bump net->passive instead of maybe_get_net()
>>>>>   * Remove msleep(1) loop
>>>>>   * Use rcu_access_pointer() instead of rcu_read_lock().
>>>>>
>>>>> v2:
>>>>>   * Use dev_net_rcu().
>>>>>   * Use msleep(1) instead of cond_resched() after maybe_get_net()
>>>>>   * Remove cond_resched() after net_eq() check
>>>>>
>>>>> v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
>>>>> ---
>>>>>  net/core/dev.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>>>>>  1 file changed, 44 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>>> index b91658e8aedb..19e268568282 100644
>>>>> --- a/net/core/dev.c
>>>>> +++ b/net/core/dev.c
>>>>> @@ -2070,6 +2070,42 @@ static void __move_netdevice_notifier_net(struct net *src_net,
>>>>>     __register_netdevice_notifier_net(dst_net, nb, true);
>>>>>  }
>>>>>
>>>>> +static void rtnl_net_dev_lock(struct net_device *dev)
>>>>> +{
>>>>> +   bool again;
>>>>> +
>>>>> +   do {
>>>>> +           struct net *net;
>>>>> +
>>>>> +           again = false;
>>>>> +
>>>>> +           /* netns might be being dismantled. */
>>>>> +           rcu_read_lock();
>>>>> +           net = dev_net_rcu(dev);
>>>>> +           net_passive_inc(net);
>>>>
>>>> Hi Kuniyuki,
>>>> It seems we are still encountering the previously reorted issue,
>>>> even when running with your latest fix. However, the problem has become
>>>> less frequent, now requiring multiple test iterations to reproduce.
>>>
>>> Thanks for reporting!
>>>
>>>
>>>>
>>>> 1) we identified the following warnings (each accompanied by a call
>>>> trace; only one is detailed below, though others are similar):
>>>>
>>>> refcount_t: addition on 0; use-after-free.
>>>> WARNING: CPU: 6 PID: 1105 at lib/refcount.c:25 refcount_warn_saturate
>>>> (/usr/work/linux/lib/refcount.c:25 (discriminator 1))
>>>>
>>>> and also
>>>>
>>>> refcount_t: underflow; use-after-free.
>>>> WARNING: CPU: 6 PID: 1105 at lib/refcount.c:28 refcount_warn_saturate
>>>> (/usr/work/linux/lib/refcount.c:28 (discriminator 1))
>>>>
>>>>
>>>> 2) test scenario:
>>>> sets up a network topology of two VFs on different eSwitch, performs
>>>> ping tests between them, verifies traffic rules offloading, and cleans
>>>> up the environment afterward.
>>>>
>>>> 3) the warning is triggered upon reaching the
>>>> unregister_netdevice_notifier_dev_net when both net->ns.count and
>>>> net->passive reference counts are zero.
>>>
>>> It looks unlikely but I missed there is still a race window.
>>>
>>> If dev_net_rcu() is called between synchronize_net() and dev_net_set()
>>> in netif_change_net_namespace(), there might be no synchronize_rcu()
>>> called after that and net_passive_dec() could be called in cleanup_net()
>>> earlier than net_passive_inc() ... ?
>>>
>>> Could you test this ?
>>>
>>> ---8<---
>>> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
>>> index bd57d8fb54f1..c275e95c83ab 100644
>>> --- a/include/net/net_namespace.h
>>> +++ b/include/net/net_namespace.h
>>> @@ -337,9 +337,9 @@ static inline void net_passive_dec(struct net *net)
>>>  }
>>>  #endif
>>>
>>> -static inline void net_passive_inc(struct net *net)
>>> +static inline bool net_passive_inc(struct net *net)
>>>  {
>>> -       refcount_inc(&net->passive);
>>> +       return refcount_inc_not_zero(&net->passive);
>>
>> Hmm
>>
>> We want the two oher net_passive_inc() callers to have refcount safety.
>>
>> Please add a new net_passive_inc_not_zero()
> 
> Sure, will do.
> 
> Also, I'll remove the weird do-while {} and do everything under
> ifdef CONFIG_NET_NS guard.  If it's disabled, just calling
> rtnl_net_lock() for &init_net is fine.
> 
> ---8<---
> diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> index bd57d8fb54f1..c91b13e6fb12 100644
> --- a/include/net/net_namespace.h
> +++ b/include/net/net_namespace.h
> @@ -342,6 +342,11 @@ static inline void net_passive_inc(struct net *net)
>  	refcount_inc(&net->passive);
>  }
>  
> +static inline bool net_passive_inc_not_zero(struct net *net)
> +{
> +	return refcount_inc_not_zero(&net->passive);
> +}
> +
>  /* Returns true if the netns initialization is completed successfully */
>  static inline bool net_initialized(const struct net *net)
>  {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index b597cc27a115..408659d238b8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2077,38 +2077,43 @@ static void __move_netdevice_notifier_net(struct net *src_net,
>  
>  static void rtnl_net_dev_lock(struct net_device *dev)
>  {
> -	bool again;
> -
> -	do {
> -		struct net *net;
> -
> -		again = false;
> +#ifdef CONFIG_NET_NS
> +	struct net *net;
>  
> -		/* netns might be being dismantled. */
> -		rcu_read_lock();
> -		net = dev_net_rcu(dev);
> -		net_passive_inc(net);
> +again:
> +	/* netns might be being dismantled. */
> +	rcu_read_lock();
> +	net = dev_net_rcu(dev);
> +	if (!net_passive_inc_not_zero(net)) {
>  		rcu_read_unlock();
> +		msleep(1);
> +		goto again;
> +	}
> +	rcu_read_unlock();
>  
> -		rtnl_net_lock(net);
> +	rtnl_net_lock(net);
>  
> -#ifdef CONFIG_NET_NS
> -		/* dev might have been moved to another netns. */
> -		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> -			rtnl_net_unlock(net);
> -			net_passive_dec(net);
> -			again = true;
> -		}
> +	/* dev might have been moved to another netns. */
> +	if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
> +		rtnl_net_unlock(net);
> +		net_passive_dec(net);
> +		goto again;
> +	}
> +#else
> +	rtnl_net_lock(&init_net);
>  #endif
> -	} while (again);
>  }
>  
>  static void rtnl_net_dev_unlock(struct net_device *dev)
>  {
> +#ifdef CONFIG_NET_NS
>  	struct net *net = dev_net(dev);
>  
>  	rtnl_net_unlock(net);
>  	net_passive_dec(net);
> +#else
> +	rtnl_net_unlock(&init_net);
> +#endif
>  }
>  
>  int register_netdevice_notifier_dev_net(struct net_device *dev,
> ---8<---

Hi Kuniyuki,
Sorry for the delay (I was OOO). I tested your patch, and while the race
occurs much less frequently, it still happens—see the warnings and call
traces below.
Additionally, in some cases, the test which reproduce the race hang.
Debugging shows that we're stuck in an endless loop inside
rtnl_net_dev_lock because the passive refcount is already zero, causing
net_passive_inc_not_zero to return false, thus it go to "again" and this
repeats without ending.
I suspect, as you mentioned before, that in such cases, the passive
refcount was decreased from cleanup_net.


warnings and call traces:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 4 PID: 27219 at lib/refcount.c:25 refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:25 (discriminator 1))


Call Trace:
 <TASK>
? __warn (/usr/work/linux/kernel/panic.c:746)
? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
? report_bug (/usr/work/linux/lib/bug.c:207)
? handle_bug (/usr/work/linux/arch/x86/kernel/traps.c:285)
? exc_invalid_op (/usr/work/linux/arch/x86/kernel/traps.c:309
(discriminator 1))
? asm_exc_invalid_op (/usr/work/linux/./arch/x86/include/asm/idtentry.h:574)
? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
? refcount_warn_saturate (/usr/work/linux/lib/refcount.c:25
(discriminator 1))
rtnl_net_dev_lock (/usr/work/linux/net/core/dev.c:2091)
unregister_netdevice_notifier_dev_net
(/usr/work/linux/./include/linux/list.h:218
/usr/work/linux/./include/linux/list.h:229
/usr/work/linux/net/core/dev.c:2130)
mlx5e_tc_nic_cleanup
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:5355)
mlx5_core
mlx5e_cleanup_nic_rx
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5765
(discriminator 1)) mlx5_core
mlx5e_detach_netdev
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6391)
mlx5_core
_mlx5e_suspend
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6403)
mlx5_core
mlx5e_remove
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6431
(discriminator 1)
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6507
(discriminator 1)) mlx5_core
auxiliary_bus_remove (/usr/work/linux/drivers/base/auxiliary.c:230)
device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1273
/usr/work/linux/drivers/base/dd.c:1296)
bus_remove_device (/usr/work/linux/./include/linux/kobject.h:193
/usr/work/linux/drivers/base/base.h:73
/usr/work/linux/drivers/base/bus.c:586)
device_del (/usr/work/linux/drivers/base/power/power.h:142
/usr/work/linux/drivers/base/core.c:3856)
? devl_param_driverinit_value_get (/usr/work/linux/net/devlink/param.c:778)
mlx5_rescan_drivers_locked
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:550)
mlx5_core
mlx5_unregister_device
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:448)
mlx5_core
mlx5_uninit_one
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:1587)
mlx5_core
remove_one
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:281
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:973
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:2034)
mlx5_core
pci_device_remove (/usr/work/linux/./arch/x86/include/asm/atomic.h:23
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:457
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:2426
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:2456
/usr/work/linux/./include/linux/atomic/atomic-instrumented.h:1518
/usr/work/linux/./include/linux/pm_runtime.h:129
/usr/work/linux/drivers/pci/pci-driver.c:475)
device_release_driver_internal (/usr/work/linux/drivers/base/dd.c:1273
/usr/work/linux/drivers/base/dd.c:1296)
pci_stop_bus_device (/usr/work/linux/drivers/pci/remove.c:46
/usr/work/linux/drivers/pci/remove.c:106)
pci_stop_and_remove_bus_device (/usr/work/linux/drivers/pci/remove.c:141)
pci_iov_remove_virtfn (/usr/work/linux/drivers/pci/iov.c:377)
sriov_disable (/usr/work/linux/drivers/pci/iov.c:712 (discriminator 1)
/usr/work/linux/drivers/pci/iov.c:723 (discriminator 1))
mlx5_sriov_disable
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:209)
mlx5_core
mlx5_core_sriov_configure
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:195
(discriminator 1)
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:222
(discriminator 1)) mlx5_core
sriov_numvfs_store (/usr/work/linux/drivers/pci/iov.c:450)
kernfs_fop_write_iter (/usr/work/linux/fs/kernfs/file.c:334)
vfs_write (/usr/work/linux/./include/linux/rcu_sync.h:36 (discriminator
2) /usr/work/linux/./include/linux/percpu-rwsem.h:62 (discriminator 2)
/usr/work/linux/./include/linux/fs.h:1785 (discriminator 2)
/usr/work/linux/./include/linux/fs.h:1921 (discriminator 2)
/usr/work/linux/./include/linux/fs.h:3035 (discriminator 2)
/usr/work/linux/fs/read_write.c:675 (discriminator 2))
ksys_write (/usr/work/linux/fs/read_write.c:732)
do_syscall_64 (/usr/work/linux/arch/x86/entry/common.c:52 (discriminator
1) /usr/work/linux/arch/x86/entry/common.c:83 (discriminator 1))
entry_SYSCALL_64_after_hwframe
(/usr/work/linux/arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7fb7b6f018b7



and another warning:
 refcount_t: underflow; use-after-free.
[ 3860.462923] WARNING: CPU: 4 PID: 27219 at lib/refcount.c:28
refcount_warn_saturate (/usr/work/linux/lib/refcount.c:28 (discriminator
1)).


[ 3860.479887] Call Trace:
[ 3860.480199]  <TASK>
[ 3860.480478] ? __warn (/usr/work/linux/kernel/panic.c:746)
[ 3860.480849] ? refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:28 (discriminator 1))
[ 3860.481327] ? report_bug (/usr/work/linux/lib/bug.c:207)
[ 3860.481797] ? handle_bug (/usr/work/linux/arch/x86/kernel/traps.c:285)
[ 3860.482190] ? exc_invalid_op
(/usr/work/linux/arch/x86/kernel/traps.c:309 (discriminator 1))
[ 3860.482610] ? asm_exc_invalid_op
(/usr/work/linux/./arch/x86/include/asm/idtentry.h:574)
[ 3860.483057] ? refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:28 (discriminator 1))
[ 3860.483535] ? refcount_warn_saturate
(/usr/work/linux/lib/refcount.c:28 (discriminator 1))
[ 3860.484007] unregister_netdevice_notifier_dev_net
(/usr/work/linux/net/core/dev.c:2135)
[ 3860.484569] mlx5e_tc_nic_cleanup
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c:5355)
mlx5_core
[ 3860.485148] mlx5e_cleanup_nic_rx
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:5765
(discriminator 1)) mlx5_core
[ 3860.485720] mlx5e_detach_netdev
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6391)
mlx5_core
[ 3860.486337] _mlx5e_suspend
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6403)
mlx5_core
[ 3860.486853] mlx5e_remove
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6431
(discriminator 1)
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6507
(discriminator 1)) mlx5_core
[ 3860.487377] auxiliary_bus_remove
(/usr/work/linux/drivers/base/auxiliary.c:230)
[ 3860.487824] device_release_driver_internal
(/usr/work/linux/drivers/base/dd.c:1273
/usr/work/linux/drivers/base/dd.c:1296)
[ 3860.488347] bus_remove_device
(/usr/work/linux/./include/linux/kobject.h:193
/usr/work/linux/drivers/base/base.h:73
/usr/work/linux/drivers/base/bus.c:586)
[ 3860.488776] device_del
(/usr/work/linux/drivers/base/power/power.h:142
/usr/work/linux/drivers/base/core.c:3856)
[ 3860.489167] ? devl_param_driverinit_value_get
(/usr/work/linux/net/devlink/param.c:778)
[ 3860.489717] mlx5_rescan_drivers_locked
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:550)
mlx5_core
[ 3860.490376] mlx5_unregister_device
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/dev.c:448)
mlx5_core
[ 3860.490937] mlx5_uninit_one
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:1587)
mlx5_core
[ 3860.491471] remove_one
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:281
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:973
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/main.c:2034)
mlx5_core
[ 3860.491948] pci_device_remove
(/usr/work/linux/./arch/x86/include/asm/atomic.h:23
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:457
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.h:2426
/usr/work/linux/./include/linux/atomic/atomic-arch-fallback.
h:2456 /usr/work/linux/./include/linux/atomic/atomic-instrumented.h:1518
/usr/work/linux/./include/linux/pm_runtime.h:129
/usr/work/linux/drivers/pci/pci-driver.c:475)
[ 3860.492378] device_release_driver_internal
(/usr/work/linux/drivers/base/dd.c:1273
/usr/work/linux/drivers/base/dd.c:1296)
[ 3860.492908] pci_stop_bus_device
(/usr/work/linux/drivers/pci/remove.c:46
/usr/work/linux/drivers/pci/remove.c:106)
[ 3860.493344] pci_stop_and_remove_bus_device
(/usr/work/linux/drivers/pci/remove.c:141)
[ 3860.493918] pci_iov_remove_virtfn (/usr/work/linux/drivers/pci/iov.c:377)
[ 3860.494386] sriov_disable (/usr/work/linux/drivers/pci/iov.c:712
(discriminator 1) /usr/work/linux/drivers/pci/iov.c:723 (discriminator 1))
[ 3860.494786] mlx5_sriov_disable
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:209)
mlx5_core
[ 3860.495327] mlx5_core_sriov_configure
(/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:195
(discriminator 1)
/usr/work/linux/drivers/net/ethernet/mellanox/mlx5/core/sriov.c:222
(discriminator 1)) mlx5_core
[ 3860.495919] sriov_numvfs_store (/usr/work/linux/drivers/pci/iov.c:450)
[ 3860.496358] kernfs_fop_write_iter (/usr/work/linux/fs/kernfs/file.c:334)
[ 3860.496819] vfs_write (/usr/work/linux/./include/linux/rcu_sync.h:36
(discriminator 2) /usr/work/linux/./include/linux/percpu-rwsem.h:62
(discriminator 2) /usr/work/linux/./include/linux/fs.h:1785
(discriminator 2) /usr/work/linux/./include/linux/fs.h:1921
(discriminator 2)
/usr/work/linux/./include/linux/fs.h:3035 (discriminator 2)
/usr/work/linux/fs/read_write.c:675 (discriminator 2))
[ 3860.497201] ksys_write (/usr/work/linux/fs/read_write.c:732)
[ 3860.497598] do_syscall_64 (/usr/work/linux/arch/x86/entry/common.c:52
(discriminator 1) /usr/work/linux/arch/x86/entry/common.c:83
(discriminator 1))
[ 3860.498070] entry_SYSCALL_64_after_hwframe
(/usr/work/linux/arch/x86/entry/entry_64.S:130)
[ 3860.498580] RIP: 0033:0x7fb7b6f018b7



