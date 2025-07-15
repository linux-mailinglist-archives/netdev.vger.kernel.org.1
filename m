Return-Path: <netdev+bounces-206986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E45B050DF
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FC84A5E95
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 05:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA98256C6D;
	Tue, 15 Jul 2025 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="e8qokQPr"
X-Original-To: netdev@vger.kernel.org
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023076.outbound.protection.outlook.com [52.101.127.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416CB9460;
	Tue, 15 Jul 2025 05:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752557132; cv=fail; b=eYEGNZ3vI8KY00VA+JaQjk3icL+s5mA9RBrJfADFNyJbznOOUsYBmXBNcmHv2e+9Jv+nockmM+rM/wRc2dYDYXX2eCDJHXsgRdJBoIJjc8sC3v6O2zo/eVLy6PhwqkUZchx878uyDBWc6x8t/HIeUK/UpVtcDaNlSJWwgeq3ZC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752557132; c=relaxed/simple;
	bh=31wSdiCqYjr84x2N/fzsQGKd2Qq0R+gptyrm5Sfz28I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UTJnLDqE4uCYBz8S+6932yKjXk8FaZ3jFi0IlS2COOXQKydduvrp9LmrEpt8sY5HgEoSN3Z6hlyzjg/VivNXhwIpsg5wxG898pjk5umAlDmEGWqC049P4idBBmGXSDq2S/jcKTTBQz/gf3nMvxJs04Qn/rqV2WRuo18vRN1qR3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=e8qokQPr; arc=fail smtp.client-ip=52.101.127.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwTnof3wqgZarH35fHlnJgChKj1FzElEYxUo31BD+Q0VDlGuCvGPNDiHPC5N49pN3KrZOUcOI2KgBOUT3+kLAyEa03bsxippbTV4uCjKYHIQqNRS+bHaqCAwt3RpijZ4zqdvedvtmxop4CbgxRfaVbv7EbhjB0hlKHZEsIlGOxLDnJ13MAClmug/bU3pSewzaTST2bZHUDTnGKTO0pvevYRs0wVUIrwjUOPQFYAY3zF6H3fG2dpyk7srXs6zZYqOOSnCJM3KbwPw79hq5qRiMGIMLpnpt9Xr6j68EMJRZ/6FgR+TRwQOlFKGBp4U5rkk/6TaslDVsPVmqFrc555QRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBRLs//PbRdCpHXeM54SIUCFEUN2plb7o0oS/NV9sFE=;
 b=JFt9/gWft9fgWr/hyQGhqKt32044lh9wgmgiW5CF60nAd6r6FhzEdoW3a/vjxQdV2/V9HLd8hfgxFH99e/pIgS1qEo8oiJ5EnOqkdiAOieCxkj/vAn5kncYVFrMOoG2X2ntzDmqqMwmbuWOBqBPeEUcYBz/m2Vy0/LcNX+RVNxpGIhKwMWEfZ4msONZm7ihOhnGjxEUCKFYWGQVPXX46optnLiProIGD1cKXDyVcUEBA/JxlTsqK5ZPQucIz4P9bQW7p08tQR3XF/++qhVJYiInXuJJuWTZ5N7ZKsco+GDRyZWao5Fyylvk0ytrZLUty8kuU10SUlYtErTZI4Dc+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBRLs//PbRdCpHXeM54SIUCFEUN2plb7o0oS/NV9sFE=;
 b=e8qokQPrN9tpGWsez2hHV02JEoZodYzl8schlZW/29BqxRaC5kDzN05ExWsVYQHBBrYnHjnFxptC35HJohgagTeILQ21bnNalkzn9Ys/PBmZMeIHhBJLRp4lOYCAzVo7IKLVAm1bB5BZe4JGrhPdeKunekxFN1peJ1fV+QW9urb8uEjJvPmta4jm/VC0XP8f4VcC73fTeJDueQvYrVVixc+VWpp4DauXSFS2HUF56bDX6OJsg+XvS0QfdmuYNt+XubFLO4Zjkt1a/ue7ZNbExBqVGaHQwxUtzK5mkNimXnFnAQI78x8Tiy9w17VCZB+kBI3ZJgtgNL8MoxtwH+c8Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SI2PR03MB6661.apcprd03.prod.outlook.com (2603:1096:4:1e8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 05:25:23 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 05:25:21 +0000
Message-ID: <44e2d1f2-0455-4559-b3ca-cf9ba13bdd6c@amlogic.com>
Date: Tue, 15 Jul 2025 13:24:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Bluetooth: ISO: Support SCM_TIMESTAMPING for ISO TS
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <20250707-iso_ts-v4-1-0f0bb162a182@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SI2PR03MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: d716db5b-848a-4ed9-abf3-08ddc35ffe70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3J5aXprZi92QWJyQW5FaU1WMmFYaUhLajMxa3RmRXV2a0wyVDdlNktlZU1s?=
 =?utf-8?B?OGFFZnRDUTZRWjI2dks0MlNSc2lYb0lBcWRmT2ZzRVowcE50MXM0eEFKdThh?=
 =?utf-8?B?MjZXd3BJMXBtdjVHWmdrQXVZN1RaT1NSK2poMmk1bzRyL0lpVVFpR0JFcXN3?=
 =?utf-8?B?TWc1VnEzYVJuUllXS3RKbG40VUNERnJwVmhUYS9VT1V2Rld4SngxZXpOTFIw?=
 =?utf-8?B?YVZPZ0JXL2NGL29icnNOcUQ3ZC9Eamx4VkhKYWt5WmtGOTJFTm5RRTVteDUr?=
 =?utf-8?B?N1BBcTVyTWt3T1grV2d2eExRd3p3NDBDODZHY2RkeU1XUnljSkRwQmxVWllK?=
 =?utf-8?B?UlhvSW10K05zaFhZbWVNQ2VJRTZZRE01dXFxVXA2eHZTVjhtTC9MaERCQUJj?=
 =?utf-8?B?TkUxR0JKVmZSYzNHU3E5c2UybkJBdWlWOXFjeW11c1hkaVVPY2Jhc0c0WlIx?=
 =?utf-8?B?VG1KUlR3aFIrN0puSkRETlNSUFRxQlZzUzcxcFNFSHVVdFZKbWRkUElBbzRY?=
 =?utf-8?B?OHZkWEdqbUQrKzVJdnpuYkMweWtGRzhGaC92eGxZZVlWdStPYk0yeG9WeVU2?=
 =?utf-8?B?dFJnU014WTFEZE1raXo4NXcyVU4yYjhJOVBuNVQrTkFVczVFZ09ERngxZndN?=
 =?utf-8?B?a0g5U01BbnprNGNGdnZYUXovNkVIL1BON24xQjZVT2tvUnFlOVBDVkFKM1Bp?=
 =?utf-8?B?MlFvSGdOT3U3YUVHakt1RnhadWlrQWZHbndhanRqaEgrUktDT284RmNNcnU4?=
 =?utf-8?B?YWxKNWlDL0VGYUxpT1B1QjJMVXI3dGdoVXB1Q1JPdWV0cWxQWlVrcTQxK0th?=
 =?utf-8?B?M1FQbkJuMkloMWtJM3NUbEM2K3IvNklkdDJmbjVCekl4aGZhRlE0UlRYdlRv?=
 =?utf-8?B?dGw5WURTSGoybkFKaXI5RGdidFlUeXdIdUtNcFgvVzcvblBHdjkwR1RwakRs?=
 =?utf-8?B?Q01ySmloSEM2eHdjQlVESjBlMG84bWlRVGlEcGtNdERUc05iQUhIbWYwc0tX?=
 =?utf-8?B?OVJPVkVjM2R0NEN6UE5xd0lzQmhQNHFWOXROd3BSUHFueWF5L2xVREM3ajEr?=
 =?utf-8?B?aFc3KzFkNUlpN0hpcmRtV2lkUDRkNWNRTEN3ZjZZQ0h4VzR1Ylo5ODF6Mklm?=
 =?utf-8?B?T2k5eXBFVHcrQkZ3cmVpQnRyTGlrSFM3SEpYRVBFUFZTZk9RUkFPcFI5QUdN?=
 =?utf-8?B?TTRXMVBMR3lUUUtVTC80aUR2cU4za0R5UXJkdzhsUWxRd0I4UEg5UVF0b0hE?=
 =?utf-8?B?cE1wTk5RQnVpNlBRRmNTL2tyL3V6bDJ3RVVOV29NRlhiYUhNMEhXUFRUc3hH?=
 =?utf-8?B?NTFxd3lPcjhwcm5nYUR2cUlqbGNIRml2b1puWjY0bFhQdjdibUUwa1h6cm45?=
 =?utf-8?B?QW9EUW5ydThDSmVkclRsakNoZGFnTkNNYkU4NnZHaG9SZjRtRUZPK1BPck5i?=
 =?utf-8?B?aGV3L0ZPYWJDd0JqSkxEZmI0T0FYWjg1cUUxOG02aHRKVFo5MWlqWGtIelZR?=
 =?utf-8?B?YXpISmNkUmpWdHVOdGJWZG5MVjY5L2dXdlh6QnJyUW5ncHE1cnRsRldqTmdW?=
 =?utf-8?B?aHU4dkkzdFF3U0FvcC8zTUJqdlI1UWtBc29ibWJ3R0tXaDkvUGxBMWhudkZC?=
 =?utf-8?B?L29heSsvc2toMXNuaXB2TEFLMTYySGx2ZnMrKzkzU0p3SG9LWXlCK3h1K2N0?=
 =?utf-8?B?d0MwNG10M3VEMDVndjQvODQzMVNzVFJBRHlxRzYrdW83Qlp6V2NpSVpSektw?=
 =?utf-8?B?WElBaUxQZG5ZMGRURUdtdnpSMU5Md2JmQzViRkV0WVBhQXoxZXg1N0FaRi9W?=
 =?utf-8?B?eHRPUHhIVWVsTWRRYVRTU2pOOHA5alFRWWVtNVB2MmhFeGlFK0RRUGEycHRz?=
 =?utf-8?B?bngyelk3bWJieU5LNTFhT0txZGdIRjJmaGN1M2dyamE2UlRuR2RpNUh1VnBt?=
 =?utf-8?Q?RghG7eFEdfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkhVNkZkWVFja21XckV1K2svZnhxNHZvNjNvL0hiZHN6VHRyaGxmVXhtc3Vl?=
 =?utf-8?B?Mmp5OUxtMDdKaXJHcUVMVE5JMWJOMUZHanlRNTlMZUlYRytkQTBYd0c3U21t?=
 =?utf-8?B?UG9RWG41MnpSSjhDYTVkWUlsbURua0dHczQ1ekhNaGU1WUtPazRUNmVVNS9N?=
 =?utf-8?B?aGF6azBFVU9zbDdoWFkzSkRiaHcyanU3d1h6LzN5R2Z6dGNPQTNFOGlFczNR?=
 =?utf-8?B?ZWxSYU8yL2xrRExUbFRvaHBkMjQvZ05LeFdPQ0VDRFNPMDFqUDQva2F5N01z?=
 =?utf-8?B?cHFsQkFYblJYZ1JIUkZ5UXFiUUg0TTBjOUZjUDNSVWJiNlF4K3BXakJkazZD?=
 =?utf-8?B?ZndYeG5jN000WlJacWpiZ094bUNmSXY3c1Y4dDZ5Zm9QUzlsY2JXTEZtMzl1?=
 =?utf-8?B?ZXhyLzBsVGdqUzlVUm1wZHg0SkcraFd1UWlKNjd5NjFZdnhUdC91K05KSE94?=
 =?utf-8?B?Rnc0dXlFbjE5ZEdZV2MzREpPSzVjd3JPOGpWMmhKWGd2cGRiTSszVk1TMHFJ?=
 =?utf-8?B?OUFlYVVPRXM1UVBha3lieTNEdkU4bng1bW5xNVQvK1RuNmxpUHFtSUR6OHBp?=
 =?utf-8?B?d3l5V2lmMTRLcjVPanc0aCtuMDlaV2g3b2wxK0NESGNSbmJxbC9ONm9FMXdn?=
 =?utf-8?B?Sk51TnZmak9UcUFjWUc1Yys4MENsdTEzblg1c3Y1Z2RIRTRMeHcwbG5kVFFs?=
 =?utf-8?B?dHdFcS9wNnJkZXBZa1JsTDd1a2tlOWc3cDZtRlJ3OVZVbGVFOVU5a3V1UFJu?=
 =?utf-8?B?QTVYVGdvTVliNW8rR0R4czU4SFRFcVoyYVpySmRWQkR2NnVROWE1Ylc2eXVs?=
 =?utf-8?B?MHpEdjZadlgzbVA2M2hrRmQ1bnd6aUZHZ3hyMDM1d1JORXdnY2haMnNDaUI2?=
 =?utf-8?B?NGNoS1FJYXI4cHorcEhCVUNPMXVOb0JITFpoTUdxSExDZU1LS2QxNXoyZXZk?=
 =?utf-8?B?bWRuYllMOXozWnJmVllJUm9EM2hvT2VMSGJzN05HTjdDZ2lZWGtJY1ZzWWNK?=
 =?utf-8?B?bVVwQng3SUJGK2prSzM3ZkVJQk5CRFVuN21Nb2srTStCOGw2Vk52bTBKZjBC?=
 =?utf-8?B?bzl5WW5QV0w0TnhyZ3A0a1BPcWZFaFIwSWxpd2FJVnpkbjF4cW5wa2p2cEJU?=
 =?utf-8?B?bGNOU3lqczZObHVHY09RR05QdHpqTFBnWDZhRnc2WURYV1ZuQmc3ZENrOEVt?=
 =?utf-8?B?bkR4UFlkekNHOHl5Z1ZLRUNydVBrc05nWWRtUW5CSmQ3eGl2ZWFvd2xMcnp1?=
 =?utf-8?B?RmFEOFVCV3RMY2o4cjhKL1VHUm95cktiN2pvTzRsU0VMZkhVWEZ1aU8rbHl0?=
 =?utf-8?B?bURBSkNiUUxkcmFyNEtVTDk2QW1PRDFhWi9Dc1FoOTkxdE15VFJldWYwUGlM?=
 =?utf-8?B?aWZ0MldFcnlUNm9uL0RaSVZxNHB5ZkpKT0FFWlpBTXNFeVA3UGg1Nk9vWjNM?=
 =?utf-8?B?R25sU2JJK0lVSG1nWU5aZStneWN4ZENETjJGMmZvRjBmTGZ5T1I3TW9nOWty?=
 =?utf-8?B?Q1lIc3FwNE1YdnlhZ1pBcDFUa1FOSExiaEt0MnVBOHh5Q2dmRzYyUjhUMXVS?=
 =?utf-8?B?S3JGSXRvY3RSdlBMWGFKVWRPME5jVXhpYXhxQ3FuSkxaSllueFZ3Q0R2VUR2?=
 =?utf-8?B?aTBiUjhOb3NaMlBjcUdLbjlUQ0daVEVFN0hGUkdPZzlBTHU2K3IwQ1N4Umtn?=
 =?utf-8?B?dk12RDhEaGpuYW9jbW5SdFh2MlhLdGcySGMvSGxNUWcwd2JWSTUrd2lKa0cw?=
 =?utf-8?B?NG9TR0ZnRWxSeS9FQlRLUkJXanBHcGtIQW5BM2FpN1pwOWF4SysxY2d3WWlh?=
 =?utf-8?B?NGIxUDJCdlg0SURLMlp0bkxjTlY0TWtrUlBNcWw0dE9UVTY3TW80bUF6QWp2?=
 =?utf-8?B?THFqcVlEUGdxeXZaR2g1Nll1VHRVcTdyU29kbzVhc1B1YXpFUnZlMVQreVJC?=
 =?utf-8?B?TldQQ3ZBUXlNeHdHVnJlb3htbS9ETWNPTGxLUXQ1YWpiaHRMNHRmZnJzZkd2?=
 =?utf-8?B?bWhYclJZcGdZTFdDUkNxZVJUSDZ5RGRmS2FjOHY3b0w5S2pnMDJ4SHl6Ynlv?=
 =?utf-8?B?MlBIeWRpallZZytSVDl6RE9IR0JjL1k3NzdRa3ZpMHVxL1FLaUl1cW9iVGJz?=
 =?utf-8?Q?AOm+NO/dNMHknYARlsUjIKulh?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d716db5b-848a-4ed9-abf3-08ddc35ffe70
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:25:21.5644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8/aRdOo5q9PAuxOGEQnIDjoQalOznjXZu6L0yxIpfvVZHoUBBNMf0VOh99qAFF1/Yw/1ARuPOQdqAAEvxLUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6661

Hi，

Just a gentle ping regarding this patch.

Best regards,

Yang

> [ EXTERNAL EMAIL ]
>
> From: Yang Li <yang.li@amlogic.com>
>
> User-space applications (e.g. PipeWire) depend on
> ISO-formatted timestamps for precise audio sync.
>
> The ISO ts is based on the controller’s clock domain,
> so hardware timestamping (hwtimestamp) must be used.
>
> Ref: Documentation/networking/timestamping.rst,
> section 3.1 Hardware Timestamping.
>
> Signed-off-by: Yang Li <yang.li@amlogic.com>
> ---
> Changes in v4:
> - Optimizing the code
> - Link to v3: https://lore.kernel.org/r/20250704-iso_ts-v3-1-2328bc602961@amlogic.com
>
> Changes in v3:
> - Change to use hwtimestamp
> - Link to v2: https://lore.kernel.org/r/20250702-iso_ts-v2-1-723d199c8068@amlogic.com
>
> Changes in v2:
> - Support SOCK_RCVTSTAMPNS via CMSG for ISO sockets
> - Link to v1: https://lore.kernel.org/r/20250429-iso_ts-v1-1-e586f30de6cb@amlogic.com
> ---
>   net/bluetooth/iso.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index fc22782cbeeb..677144bb6b94 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -2278,6 +2278,7 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>   void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>   {
>          struct iso_conn *conn = hcon->iso_data;
> +       struct skb_shared_hwtstamps *hwts;
>          __u16 pb, ts, len;
>
>          if (!conn)
> @@ -2301,13 +2302,16 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>                  if (ts) {
>                          struct hci_iso_ts_data_hdr *hdr;
>
> -                       /* TODO: add timestamp to the packet? */
>                          hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>                          if (!hdr) {
>                                  BT_ERR("Frame is too short (len %d)", skb->len);
>                                  goto drop;
>                          }
>
> +                       /*  Record the timestamp to skb*/
> +                       hwts = skb_hwtstamps(skb);
> +                       hwts->hwtstamp = us_to_ktime(le32_to_cpu(hdr->ts));
> +
>                          len = __le16_to_cpu(hdr->slen);
>                  } else {
>                          struct hci_iso_data_hdr *hdr;
>
> ---
> base-commit: b8db3a9d4daeb7ff6a56c605ad6eca24e4da78ed
> change-id: 20250421-iso_ts-c82a300ae784
>
> Best regards,
> --
> Yang Li <yang.li@amlogic.com>
>
>

