Return-Path: <netdev+bounces-179587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24426A7DBC4
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E84161298
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5838B158545;
	Mon,  7 Apr 2025 11:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="puh8K8Ig"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DDD23816E;
	Mon,  7 Apr 2025 11:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023766; cv=fail; b=lwUka2dQwAdqDDOxiPHyZRZNb2I1jv79zhJk98k1413+123wiXr+fQhoV2fZXAZHndbr7ZOkOP0e5n6pSpBiD9kfuz2hh7cnThOHQ1O34ddM85Lg6s30tuf51J434b2KiQ9Q5QYFqihBQstv/K/Kg23PgsI7wYTx75iV8S/RIf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023766; c=relaxed/simple;
	bh=rwpE08Jxtk6c45SYL8rTciwkLSprPd94ldrmFATCh98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VRFe7Q+/TNxVwkFWWTp0xU/5Rzvq+Y5dGhXIxVfIf1Nlew6sEoXKyOk0TcPdleuN6nf7dNwC6CbwXL0cPkUIhPD+Btw4ZHyG94FY99UJDoCldNypQuG04G+txs2h2yScVWXGpGHe7DvPvGg4TihPUV1diY7s5961h/p3NzVinIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=puh8K8Ig; arc=fail smtp.client-ip=40.107.244.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPbQ0NIL6BF/LniCbTZLV0rY0NFd0sZ4iRCcaaZ4vUOLinoTXOkA8JxVDkBpZiXZk9FYiQMoWqm+x1694R0oWEMl+SvktbaHt1NEOV+K0UN+WbDtIE/ZsQcyNdLWPdcDfcBumRNBH1xs82iRFpxjGfoxC0yXrjmdS4lsTY7X/3jYDe58XohFT4lyDqpQtF7OMQ0zmakEFRKFnDE7/u9qFYDyFToboSNovf1Ss7Dc3UaRoN/gAI1JQl+/ynCTnEbAD1vPF6p3/CRgojb0IXhseL3F8tPljEtSM2J+Ri6y6lfARi8c586K558dG+3opeHj6zjKc2pP66v1Aeh0KWbteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYHx+lDRVF6yN248QasXMWjpeYsPLu2AAKGPM32m9lo=;
 b=MWsf0lCn3CF8Ikphxx/DyYz9z9u4ng9z5TGym/WoiEjOA+3IbcSRLRjeB+PHHMifLFPtPJBQ9/9ohx2WF4QUqLYYUwaniiS40JEpcVQ9xGjUs96HVoI8rvzwop3aIi7fNgISenGAfJzMN08nzeyyIGticlI45vKQd0Y4HpSe6ALvmJKd8wNghBPYetGmDvrxv0TN8P0bhHUcQ6lWjb5pax9lqjssJQZLWWGljX9o6dRExNZ9LCKt5dTsc6z7VjhrA5gEQSau4hWt13YK2sSrxij3dADAHbIErcaA6eCS+HT9mnf/A6aXIFColFmZCjoPU7qFfbnfhSeQZ+QfYOcMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYHx+lDRVF6yN248QasXMWjpeYsPLu2AAKGPM32m9lo=;
 b=puh8K8Ig8IPueP48mp7D4GqrmvlAML35yFPmCaMFnGMV/go/kNIDNS8GQbBl1zcqk0yrqiYf2/UV4QrbN+ado9Ym9hubYnmXevS/tj5ORc+DCAqxk+w6KC2S4jnf+ho4hmjUFPf67PXs6E2whfer/XbGynKH0BdRxFbaQKUG824=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Mon, 7 Apr
 2025 11:02:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 11:02:41 +0000
Message-ID: <8ab734d2-f565-4b6c-910b-4794e5e382b0@amd.com>
Date: Mon, 7 Apr 2025 12:02:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 12/23] sfc: obtain root decoder with enough HPA free
 space
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-13-alejandro.lucero-palau@amd.com>
 <20250404173838.00002ebb@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250404173838.00002ebb@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0195.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: e899c176-b7e2-49df-35c5-08dd75c3b71f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alNPaDc0d2ExVGZBeENyVEZQenBwcWxic2FKWUVQYkhoSjdJeGhLcDZLU0FK?=
 =?utf-8?B?QUR1cmwyVE1XemtHbDJBVmlBeEJXSnJGTm55U0w4S2RNUitacWdlYk5oem4v?=
 =?utf-8?B?bDhlSGxsYWZ4RXRlUUt5Z2pkQ3FYdWxndVZGRWRSTXNvSStGM3V5QmhWeUlB?=
 =?utf-8?B?YTRMallTdFFmRmF6MXM3QW0rbmdQV3ZZYnJucUwwNklObWREdHovK3k4SGpU?=
 =?utf-8?B?dVVuc01mWk9wUm9uZ3FaWERCRHZRbUJNRENIdVN5T1R0eU5tczB2M2xDSjdW?=
 =?utf-8?B?R1J5cnRMK2JwMk1YK2wvanlsdXlUSXNTOExRZ2xBWXRLNHhyWldCN3B3SGFI?=
 =?utf-8?B?ZlZiMmFNWlNCcW00TEg5WnJ5YWlMaTNTVTNUQmpuNCtYbi9ua2I0RTFVNDRm?=
 =?utf-8?B?NzdPUkdaSmE2TzhVSmVKWUFnWXRyaGJRNFFRZ1JrdlhDa3lJcmRuMFhLYmdB?=
 =?utf-8?B?YVludWVPbGZUQUJiQWIzWmc4blNZdmI3cHluMXpxRll4b3MwRVBMN3liS1ds?=
 =?utf-8?B?MjMycFAvb01weURDWm5VUlhUYzhsNmMxUWJZSS9EZVp0Zk5rZUJXZUNqc2tW?=
 =?utf-8?B?Yld5emxQT3l3Z1NidzVLenVxN241SVkrYit3d2hYYmJ6RDZSMjdvM2hyVW05?=
 =?utf-8?B?OEZJbCtRQ0ttRW1IOTA2b2UzV1BYQ3ppcU1jWFp0cmtQMzNzY3c0TWN2bnNu?=
 =?utf-8?B?NzJtazZkSk9WRkNHMDFISDZtQ2lyVmNYT3ZMTi84YUVGVUR5RkxTbE4wUlo1?=
 =?utf-8?B?U3NkVXd4dDZPSGNBWXVkQVhWalBVOWx3cEhJekRBQUg0OEJneGkxcFBYYVJv?=
 =?utf-8?B?a2tZbWY4UEx6eXdvWUszNnNBR3hMVlg0dHdLZnZsWXZuR0NzRDRudUdta1dS?=
 =?utf-8?B?ZGk2bzg5OTd1bDE4aFo4UThtTVFYUkdNcFlIakF1ZWF6aUxhSkJ2a1VWZUVE?=
 =?utf-8?B?ZTFYUDF6bWo0bFZWSThHclEzT1ZvN05NTGY5Z2xkTmRubGR4K2E5N0t5bHVE?=
 =?utf-8?B?TTM4MWxhV2YxR3Z3OFIzTVlvSFpKN3FMVFk2V3pMZW40VCtQQksybXlqd1o1?=
 =?utf-8?B?OVY5WXZnRU0wMENEZCtKR29WakJpL2N5WWVUSloxT2lDcktUYXpFd1k4Wlc1?=
 =?utf-8?B?T2dCOWdsTjhWTG1EZjZhRWJCS2dWV2lXVlQzOHRNazNyMzlkMXRiRXVRclNq?=
 =?utf-8?B?QnNjSWpuTzF5dEwyUjZQVVVkOExMUVdRdTI2K1luSnZiSnovS08vSVdCbGJ0?=
 =?utf-8?B?OC9Yc0FmR2ZjelJETTNzWUlBcXhLREFVaVZjcSs1Slc0V09uZjRwWnA4RWda?=
 =?utf-8?B?aDhFZ3I4QmJzRU5KbGVTZXkwTExYSnJSREJWVjFJVkpCVUpWRUdWTFc1NTUr?=
 =?utf-8?B?Z2ZNSHNYeXNsb1JnUGhWYVdNWlZhZ0tiOGpkbzJmTytiK1h0aGtMdnRPYTh3?=
 =?utf-8?B?ajF4QlRiMlRweE1iK25Va0xUd1ZmQUh2bExnTUk0WTJ6TFlNQytnQndocXR1?=
 =?utf-8?B?aG9GR1g1WFBoNlI1V3ZvRHZ1NVVYTGxvTUlVMlpTczUrTG9vUVhGUmtxNGFu?=
 =?utf-8?B?dE9uNThramFYMGdwejFtVEdOL0hiRHh3c2ttS3RTK0NXSDR1eFlFVzFiVGVy?=
 =?utf-8?B?MTE0ZHVKaXVna0tqcTVDTlFOcnhoQlF3UWQydjVsTjhVT0JaUEo4MGsrcjNr?=
 =?utf-8?B?YmlnQlFBVm5KU2s2dGpWSkM1dmxXZWViWU5EVVVqWTZrU0lTVnJJT25ZTHE5?=
 =?utf-8?B?N3RwbXBDTFR6Vmp1cUNuVW9WV2pkWXlpUUd2VTVPVCtRdVFxWlF5VmVPR2k4?=
 =?utf-8?B?ak9mR1FwYXdFZ3puby9pQ0p0aUFtYlJ4ZG5iQm95c0paaU1YRlA2NWhzU1lu?=
 =?utf-8?Q?k2ygRPPM6fN5T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MllHSnNEMEI0Q0IvNDN2bmRHTWZpOTl3RTByMUMyUlhpdi95dmMzbUl0ajN4?=
 =?utf-8?B?UXpybXM1L0EwRXhIRHpMVmhrQ2tkYjRYWDBWbGxPKytvK2lSTlRqYmxrZUhW?=
 =?utf-8?B?aVoyNFo1b2gwL3BnSjF1MkJLS21KR2YxMjYzQzdVSW11SjBUaExUcGpmcGJU?=
 =?utf-8?B?UnViNkxNY1A4Qk12VldBSG1CbUQ0c041VHFrYmFhdGtxNXk1L1QzQy9ESlQv?=
 =?utf-8?B?Q0YzTzdjLy9BZnpFOGhBUFN3VXJSdmlScUNnTWVuMDROQVFISHpRMXF2ZS85?=
 =?utf-8?B?bXg4cFR5ZlB2QkxTOTJCWDQ3UHZxcmNPOUtvekFsUjNLYXpKUWFpam0zM1lo?=
 =?utf-8?B?eFNPMUpXZzVMTTVCbkgzREp4TG1uZXZIakdUaG5vMTBqQ0JUaE1VTnl4b3dX?=
 =?utf-8?B?a1lXMityZnEyVC9rbzdaTVh4a080V0tNd2ZwMCtORkpDaU04MUE4enh3TWVy?=
 =?utf-8?B?K0czQWpDS2ZDVmIzYnVMbjc5S3o0d2dMdFExUE02TTg4OG9FTEI2K0ZFdVZy?=
 =?utf-8?B?WEJXMU80OXJ2TUgrRjhDV1hlR29TNERFL2JuT1lvdlJ0ZHcyMGFzQWw1UUlU?=
 =?utf-8?B?L0w2SlVXVEdPUVY5YUY4YU9BdkpHSmVxQUZmeFFvQXlaUmZKUi9IeXBmVnpU?=
 =?utf-8?B?cDd4T3ZQNEpabVBUZVFtNzJyVldRMGxFNElzNEliQ0Y3akNMY1M3bGtRZHRm?=
 =?utf-8?B?RjN5RVFnekdjcEdPVy8zWEtrRHJCU1MrQUJobUJTaFkzSnVCcjBYcVZYQXlI?=
 =?utf-8?B?NDdaQ2Z1bXpTUVh3UWRST0lRRHV5cTRQdVA1NDFva0ZNZjBNbmNMVmRmSXZ2?=
 =?utf-8?B?R3RoVjUxUVJOUFBacldKWVptZ0dTR2xySFJoT2dWZjhhSm1kblhVSjAxTFR1?=
 =?utf-8?B?TytwbkMrRnZWYWdZL3ZPZ2FObjIyTGZpYWFVZWRaaVRkTDhMVldER1ZhSEFS?=
 =?utf-8?B?eUw1TUhOdmJwTWNQQnNpajRlNlpkbUtrWkFnaHh3a3d5alpDbm0xbXBHTDAx?=
 =?utf-8?B?Wkh5ZTVuWFFWSFkybUlEWXpyUndGV3VNL3FlMm9DZitmcWk3SjlPMXNyY05D?=
 =?utf-8?B?T25DTDEwY0dLblJIV09KRlN4ZllYRkZ4YWJwaEJpTVN6NXd3QTlHZ3Foekov?=
 =?utf-8?B?RXhwVzB5WVBwdHVNWGVaRVNmY0RLekVOeTdSNXZjbWlwM1RzUmMva21TSTRY?=
 =?utf-8?B?QWh1WkR3aWROQUdtZlhuaC9wS0s4MXJicUlQSVpjVVV6aUFSSm5mRVluUENU?=
 =?utf-8?B?ZHlmd2UzV3dDMTBWUEc4UlRIQk92My9PWENLUm9tMzV6T2ZJQjBmdlFsbXlB?=
 =?utf-8?B?MHJpQVNFd1Y4L1hUL3ZlSWFDdThFMUtTemxKck1qaFVNK2dnRXpMSXNCYmc2?=
 =?utf-8?B?cXRxdmY4L1ZFbytrOVQzbnJ5bHE3RDNOMW9INm5uUElON0N1YzIwV1JMRTZw?=
 =?utf-8?B?K1Q1Yi9YNXFmOUc2OTZicTd0TFRxcUlLK2RPUUxwWWRSbTI0N3ZFVktkR2hU?=
 =?utf-8?B?ZDZHWUhTMTI3NUZ4T0JobklRRWJKckw5MWVLZDVObWlQUkhRaCtQM3J4Nlht?=
 =?utf-8?B?emVPUTQ1MDZvRXhvSlNJMmpDbm5Td3BqSHBQZzRxVGJ3clkyLzJ6SmpXRWVT?=
 =?utf-8?B?a2dnLytxMXJvSVV0N1N1anMwTVlOVjdBWVNUaU9mRGt1dmZSL3kzdmxrRlpm?=
 =?utf-8?B?VXVvRnlROHN5eXR3dTVybVRXenFua2c5VE5CQ2doOEhKMGNWRjllYkwzOEJ6?=
 =?utf-8?B?MWJVcm9UeTZITDlKbEdSd0xQVW9BWkw5SUJyeVlUZUk2QzY3V0ptaEJkRlh4?=
 =?utf-8?B?UXg5VzJhdUhtMk1nc0swMi9lcVhiV0JuSHppLzkyYjRjVTlmUGtRcUk3bzh3?=
 =?utf-8?B?VlEvRlk5WlhuMG0wR0RsbU0vWmxudWJZSlJwVzJRdFhiaGVMNjhOaTdmVVlr?=
 =?utf-8?B?TmppRHNPOGlBbm13V0p4UCtsUGNHcURZUDNnQ2c2bzBiVlpjdTNvTjB1T0Q3?=
 =?utf-8?B?aGpiSmlCdDdQUm44c29NMXBxNnpNMUtYZFFwNHVrUnQ2dUJ5eFFicVc2ZXBw?=
 =?utf-8?B?WXVwMG5ONUlYdVZ0OG5mWW13TzE4ZzcwR3RrVSs3UU4waHYzdEs3WExrcjZm?=
 =?utf-8?Q?iOUp4DBFj52Qv4mdkGO4VKxJZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e899c176-b7e2-49df-35c5-08dd75c3b71f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 11:02:40.9858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVtu+UdVj6gKjV1jCzVJChpviyNSZ5CI93oCkaGSu1RMyigqsK9I2G/dHsYMs6XWCUDgsnsaaLuBDGKIdHX8Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281


On 4/4/25 17:38, Jonathan Cameron wrote:
> On Mon, 31 Mar 2025 15:45:44 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Asking for available HPA space is the previous step to try to obtain
>> an HPA range suitable to accel driver purposes.
>>
>> Add this call to efx cxl initialization.
>>
>> Make sfc cxl build dependent on CXL region.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/Kconfig   |  1 +
>>   drivers/net/ethernet/sfc/efx_cxl.c | 21 +++++++++++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>> index c5fb71e601e7..7a23d6d6d85f 100644
>> --- a/drivers/net/ethernet/sfc/Kconfig
>> +++ b/drivers/net/ethernet/sfc/Kconfig
>> @@ -68,6 +68,7 @@ config SFC_MCDI_LOGGING
>>   config SFC_CXL
>>   	bool "Solarflare SFC9100-family CXL support"
>>   	depends on SFC && CXL_BUS >= SFC
>> +	depends on CXL_REGION
>>   	default SFC
>>   	help
>>   	  This enables SFC CXL support if the kernel is configuring CXL for
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 5a08a2306784..4395435af576 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -24,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>>   	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>> +	resource_size_t max_size;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>>   	int rc;
>> @@ -89,6 +90,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return rc;
>>   	}
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
>> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					   &max_size);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
>> +		rc = PTR_ERR(cxl->cxlrd);
>> +		return rc;
> 		return PTR_ERR(cxl->cxlrd);


OK.

Thanks!


>> +	}
>> +
>> +	if (max_size < EFX_CTPIO_BUFFER_SIZE) {
>> +		pci_err(pci_dev, "%s: not enough free HPA space %pap < %u\n",
>> +			__func__, &max_size, EFX_CTPIO_BUFFER_SIZE);
>> +		rc = -ENOSPC;
>> +		cxl_put_root_decoder(cxl->cxlrd);
>> +		return rc;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> @@ -96,6 +115,8 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	if (probe_data->cxl)
>> +		cxl_put_root_decoder(probe_data->cxl->cxlrd);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");

