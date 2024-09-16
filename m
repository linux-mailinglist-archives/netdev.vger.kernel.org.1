Return-Path: <netdev+bounces-128508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21461979EF5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BF91F23C88
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 10:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48A214EC5B;
	Mon, 16 Sep 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kABsjlgN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DD014D299;
	Mon, 16 Sep 2024 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726481366; cv=fail; b=F7gzU/Z+uvWKft0k3BEQQD16qfqWJcvY6QOssQBKfw/Pil6YpZWWAyZnIAJtP03DYC+IrOBS7o7C7Os2LcmjaI5/1K50V1fggSynuI0B3+A1hTmZ7Uw4i4yNRUJVKCTERWCPU3KUArCFKajwIjkDxuCqlNGqlsfYwBc5vper988=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726481366; c=relaxed/simple;
	bh=gH+z1peRXb47opVBO75kZKN1iXsVbhHvP7l27rFBjY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oj6s1L7m0I1xfmjStdxzFck6NBZOgO6BIGoe9/KMFaVwT8pYd5LpjPLxPspKcvuVhb7bMTLTjwZZK+DN6cQ5QqkiIL1m7PvX2zSsih/qliXRfSvufSU8/PF9ekHTMOWaQgGYTqOIoRJ6vjQxXrYNwdh6xYiRCz8i0n1mtrZzaEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kABsjlgN; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWYp7p37NbxAE4gO6KaKwwfejcV6cbS4ERxHYj/51/I7soEsdMlK0kG5jbAFFWcmbptbksnnhYMszo87BH4FrEOx22vuwycq6hRj3zAKbmnT7lGHgDh0O6DxeGbXuAFSE9PeYE2zCfxtrkKgt+8m4Utg8N3GWeT/QDILpSaTyLNqBnumLUdGqejusGn62FfemOUh42eHzkzAeOWjMDMjkViCdRyQickT5mGEsgpC+B5lVdMiF5Cjs/CCw5WdNu4dznfpSZJbYZ3qXnkyUtxdTBb1liNsT7SPgLg77XiaEM5BaPPCUF+Y+Zvk48vwhL6/lCJtWnPEO3qiWfyYhqfLfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crxu+uviVf9I5rsLtQAcBpGUEWkkADvaGv5naZZyvjY=;
 b=dACrK5qCZVH8P/9WPdKSf+Woj98Z6I/uch9OPrVZEyhenTT6QnE01nI80SQAoJzrVLJXpeEFHEe3itFsu5XF50NIfCSyo5we+nwqEVpI7Xa6BAZIaIpe8XjfhUlUj+VJ6pGSW+cuyIXQ7wLRGDmWzyJleb8I7FzeCIsxIV9nIje4zsTHrMdjkynI0Phso30UEHPW+VOpxQ0fGfEXQAdToLRVtj5HY8OKqQjDkj91JvFMZOxrD6QlbwQDEdzfFGDO1l/Mz7NdUynoInID2fpUZNFKezU9ZPLgPov+OwjAZbnrwz+LymEKlVp2xCKeeGbhVZB+NQnL2xJrt5+1q9SwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crxu+uviVf9I5rsLtQAcBpGUEWkkADvaGv5naZZyvjY=;
 b=kABsjlgN3Ou+MKqYLr+AohsliWyXa/BouQkWl+OZidPPKl0PoECY/wV4D8NukqnjCBxPLOvsY16DFm8pVQqCYYAbScSHFrwvVprI4p5VWJiN7z78fpFtEVQ9LwUW8gIfnASOiPS7z+mj4xYdRGOKbtA0OW5U9ge7kxq2w4ocyE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 10:09:22 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 10:09:22 +0000
Message-ID: <f43a3b62-2f36-6165-c142-b0bfc6fc32e6@amd.com>
Date: Mon, 16 Sep 2024 11:08:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 10/20] cxl: indicate probe deferral
Content-Language: en-US
To: Zhi Wang <zhiw@nvidia.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
 <20240907081836.5801-11-alejandro.lucero-palau@amd.com>
 <20240912121908.000054dc.zhiw@nvidia.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240912121908.000054dc.zhiw@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0344.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: c31e4835-2c90-4e92-f5c2-08dcd637a23f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REdSL1dwZVNobTAvem9FZzVmbUFNa2ZYbDBjSVIwalcyNEN0d0NYNCt3S05U?=
 =?utf-8?B?MFMrdHZmSEhwOFdTWEFNUTQ3OGcxY0xFYkdTMGtFWUFXQ2dFVkYwWHZWK3ln?=
 =?utf-8?B?ZUxiRjNCUCt2bFB4bU9KUHVnZkI5Qlhsa0pPbVcvQ1czWlVHZURMZVNtRnJw?=
 =?utf-8?B?eDNBRGtLTjUzLzVXdWI3SzdsMlMxd1JSdE5DQ204cTJHeS9RQ3krV09WU29a?=
 =?utf-8?B?WFo4RFh4a0JUUXcvYmp0NzB3cEwvODFrOE01dHNaVmZxV2N3dmJvQzRrRE9E?=
 =?utf-8?B?MHM0L3dheGZyNHpTSHpBTmo5b2xtV1cxL1F2Nlc4b2Q2K2czaTZyOStOWWo1?=
 =?utf-8?B?Q3pseHFjKzFnT0IwM2FaMlQ5Tmo5cFhLYUUyOHVVS3FleEFCVVZhQzlZbkFy?=
 =?utf-8?B?Q3R1MGVVNXJmTi90RThhK29JTkZyVndUWVd1SnVpdzVYaTJTRU9zWlpIdk5V?=
 =?utf-8?B?Mis3M2RJYjgyOVF1WW9qRGVRWFVPZVRSZi8rK1pSeGZ5OEM1RmhCYkxQQW9i?=
 =?utf-8?B?VDR3QXpMWUF0ODd3YzJmT0VyR1VWVmczcEJ6OUhYRUZ3MDgvU3cwbDB0d0Z6?=
 =?utf-8?B?L2gzNi9KTGY0NmlhMmhYZms2TnNZckNPUjVZWS9LTHhaazgrYnRFQ09aeXRs?=
 =?utf-8?B?d1VIc2Fta2EwbjBRNUEySlcwa04yaFF4ZVVWWjZIUzZnbmFJRGNNcFYvWmhj?=
 =?utf-8?B?U3JjaHBHOUVnOG9ZdGNVZUwxWUhWdmVKMHFXS210U3REeFNIQXp6OFhTalVM?=
 =?utf-8?B?djN3QXFLUmRjMmNEV1M1cFA1U1JKb2ptRGYxOWpna1Z5UmoyNkZKSHpGQVp4?=
 =?utf-8?B?NzlVY3VZZlYwRFQ2a3JkUmhkWWtZSnlBQTQ3aGphREZzU2cvL0I5aDdqdGdH?=
 =?utf-8?B?anJBaG42N2lDYktoWEJjRitZcTQvUnUrRGo2eS9Sb3RLL1hTeENxT2NmRi9s?=
 =?utf-8?B?aVNoZXQ4QTRIazMwcmVtNGJzWXJIV20xUS9MM3hiZlMySVR5T2U1S1pydXBO?=
 =?utf-8?B?T2kvY0hXc05YMy9BdjVWZ2xXVEdDd0tIZHV3cU5pbVRpTldta2Q3dW5UMVBs?=
 =?utf-8?B?NjhBVDU0RnRjMTEvSlNxc2hzSlRIdnhWK0VsRjJrd0UybUVuMm5JV2V1OHln?=
 =?utf-8?B?TjRKczlUWkVENHFvKzhsTXFGemsyQ0VOcUlTMVlOazhyYUFCN3dkRkN1UlpV?=
 =?utf-8?B?M2h4OFJMOTdIMzhIekdTRktiMVJaMkw1OFdzKy95VGlobkFEcWdEUTRaQVFp?=
 =?utf-8?B?Q0t2MEY5TzRUL21aTTFvWkdmODBvZm91NjFZNldFNXJ2cDRjbkNadlZZWEtL?=
 =?utf-8?B?QUlva3pGQTlvb2QvT0Y2WUJzVzBHOEdsaHZxMzV5MC9yNlFMSHcrcUlJNjgr?=
 =?utf-8?B?d2FwV3JFOCtYc3RnMC9zRG80c2xCZ1lOSUh2RzJOdHZzejlHWkdpZzkxWmlN?=
 =?utf-8?B?VXIxMGxOWlZtd0Y2UGVDR1cySGxNcG1xcTl2bVNENlAxNis2M1RMTTVhUThM?=
 =?utf-8?B?cm5aaVg2T28rYXlaanh5Ymc5ZVRwQUViV0I2R0twN0JBNzdFT3JKdUo4S0xX?=
 =?utf-8?B?RVlRbzg0cTJjREQyRVZmRVphMDRQM005eG5DUVNmNjY0T2lnSDNlQkRrRUt6?=
 =?utf-8?B?SGR6QUgvOFdLOElaQWpGS2RockJjRi90dmZtKzc5emU5YUZFaWxxajNmVE1k?=
 =?utf-8?B?RVVOZDRKNEVFdGVqcHpvcHlFbVZKRmxGalFWTEk1L0lqaGt3WnJVMFU5Zk0r?=
 =?utf-8?B?NUVSNWpSNUs1NUpGWUl1UHd4Y29NdGt3U0JYUG1XMGN2bzM1M3VreWFmdFI1?=
 =?utf-8?Q?MExMYZ3I+LuRv1QrkEvL4aMmacjrIhcJ5qoiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25oUEJyclUyUzR6OHc5cGUyeGtFeEhwL1FidnBtNGJ6NGFmTGFPL0h2TURH?=
 =?utf-8?B?NHBVNlVWc1FOK2JLblBLMWg0NEhpUmxCSUZaWWZaUmtKcHVYN3FGdVdIR3Rv?=
 =?utf-8?B?YzFCSEdmVmEzdUNSK2gxcG9rZEFQNVRkeDhXSktHQlQ5L29KSkhrN0g4ZDAv?=
 =?utf-8?B?UGszeU9ZOXNiOFFtQmRTZ3prNnNOd2pVb3BmNHUzS0RIS2MzamcrN05SQkg4?=
 =?utf-8?B?UFBjY0pRQ1RvN0FCRm1VeUFWLzluUFFkcERKS3MzcUNaaGttVzVINDdwRlVU?=
 =?utf-8?B?N1Q5MHdqY2JxQ0dEN2hRUHNNcXhqZFBEMlBqUDZqTFh2V3VCYU1yRHBQQUgy?=
 =?utf-8?B?YzU4cXFPVFpZRk9DbjRLZ3hJZjN1VXdhbzFBOWpSeFNJdE9JRWx2NyttNE9u?=
 =?utf-8?B?Tk5UVVduNTZaRmpBWWtlMVhhZGc1bm9qU0k1RXBuWkRVZTl0djRnRExVWEo0?=
 =?utf-8?B?ajU5THo3WktuTW5vQnNhWmd0R0lDL1BaMWFzMk5UZlo3aWdlUE1VNHJERE95?=
 =?utf-8?B?Y0QvbTJSYmdIU1dHOWk4VWxDZWZGanJUWXRlV2tkU0tmekx1V0lSRC9RNGlu?=
 =?utf-8?B?ZFNidzk4bHg4a3llZWVXTDVPQzFKNXY5d0dVeENUTVF3cndFRFhnaGYzRjFL?=
 =?utf-8?B?UmovUDJVU2lQd25CV0JSemRicEg5ODEwWHlKeEtLMjRrTE02Yi9SRlU5WjVp?=
 =?utf-8?B?S1VZaXJsU25SZ1JDZ1VGdEg4OUtPM1hpa3Q2VUh5WEZsQkdiQnUrNmkrTGZi?=
 =?utf-8?B?S29JRkxLalZZa3ZhZDhzS1FaMGZXSU5MMWRIK1JIaGNtZ3RmbXRzNkpUOW5s?=
 =?utf-8?B?azVqQ2kwLzZBWHN2OFRzZFNpOVRoQnVESlVsYnR2ai9uOUZLRUhrYTdJWEV4?=
 =?utf-8?B?Nyswd0JZblVpVWxPUlgxbnlSZ05PQ0pnVnhlZ0s2QzRvbk1MV0toaG9CYkZn?=
 =?utf-8?B?UXFwNXV3Y1duS1RDNXJCaUNGTFR3eTEzZkYzTHhIQUdST0x4Z3RuV2c0RTlJ?=
 =?utf-8?B?bzJISEFLL1hKZUxscklLK2g2aVZmeUY4VDNSOWdRS1VpVUpOeUF5UVp4a01o?=
 =?utf-8?B?OXpzR21zNVdFRmdWQzZzK0RnQmp3VVp0azVESEg4akhtU1h6eFNoWU1HN0o0?=
 =?utf-8?B?MUp1ZHRIcThHWTV2KzJvc01YT2tTdFVhYWNPWHlLcXdLRTVDd2Z0azZhRXZW?=
 =?utf-8?B?U2g1U1JMVW5TN2NmeG5rS1l2Zk95OXExVVB3N0hKbStJNUxBTjNHNTh3MUhP?=
 =?utf-8?B?RGxCVDlWY1cwclNveUVZaGsvRUx6ZGRsWGxBL05uWitqWlMzMmc5MU1HZGpl?=
 =?utf-8?B?bHQ2Y0JjZWQ2YlQxdFc4T2pYdy9sTVFXNGdWcng0TW05VXR0OEZUMEpuazht?=
 =?utf-8?B?U3oycmJRYzZHTnc3aE5CY2pqR1RHUG04NHhadVVUdmRSdW90alFFMzR0aFFM?=
 =?utf-8?B?TFlLMjlqNzRVdDk2YlBkTTRVYUdzTDB1TGthMklTVEdDbjA2c3NEUFR6NjhV?=
 =?utf-8?B?NmtUbUtWYWdaaVNCVE5oM0d4VmwrVGx1QnNDOVVJOWVpQ2I2NGtlRkNRVkpS?=
 =?utf-8?B?MXNnSGticktTTGpsZ01rYmN2a2ZqK0I3MUVQTnRkcG5HTU9UVnZGeDRXdDF2?=
 =?utf-8?B?c2F5STladGtZek5JYzluRzdnUFNQT2lSSnlURTlKR0hDdDBoK3ptZ0pPT0pa?=
 =?utf-8?B?Mm91ZlRKWkZ2c0FvWGN2d0dKdWYzdWdXN1g5OER4eVg4RC9JRVNjcUJ6a3FT?=
 =?utf-8?B?elRqNjZNdzJCZ2lMMDY5b0xadnUzcnV1NExicXByT1RCV0Y4RFd1WDdIbmZ3?=
 =?utf-8?B?eHUwVGYySFBwTDNoVGNsL0Q0N3JJaE5JQXRIYlUwcHhtN3E4WUhkbjM2UFd3?=
 =?utf-8?B?TUpuZUljN3MvZUNDYkdac0lMMVRNU0NYWkRsRkdyUEsxL1lDVE4wcDVuNGpj?=
 =?utf-8?B?azAwVVpPOUlXOUx2VHVFdTA5WG43R3JtYlpKckdpcjYxeHZvSnJPbzh0RjYx?=
 =?utf-8?B?TXIwbjdPNjRKSDk3ekdFR1Z4VmhER1BKL3lmNnh0KzFnYmdpaTBFcEJlZ2p6?=
 =?utf-8?B?bjZuNG5EaDJ6OUM1ZDRaYlVpczFUN0ZIU3BMNGI0MEJBQkhhN1FVZXMwZTZ3?=
 =?utf-8?Q?aL6cMLib0qCBEdibSx+qMmzWg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31e4835-2c90-4e92-f5c2-08dcd637a23f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 10:09:22.0631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGro6l1pxyHzBl9SptGZ73k2zNZeuxo4tBvycrQZaQvXDtTsPP3iexqu8SAAfXcDgrnYKPZ1t+Y39nCz9KL8sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986


On 9/12/24 10:19, Zhi Wang wrote:
> On Sat, 7 Sep 2024 09:18:26 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> Hi Alejandro:
>
> When working with V2, I noticed that if CONFIG_CXL_MEM=m and cxl_mem.ko
> is not loaded, loading the type-2 driver would fail on
> cxl_acquire_endpoint(). Not sure if you met the same problem.


I think I have some problems with kernel build depending on if CXL code 
is configured as modules, and even if CXL is not configured at all, what 
it was raised by the kernel build robot.

I'll work on this for v4.

Thanks!


> Now we are waiting for it to be loaded, it seems not ideal with the
> problem.
>
> Thanks,
> Zhi.
>
>> The first stop for a CXL accelerator driver that wants to establish
>> new CXL.mem regions is to register a 'struct cxl_memdev. That kicks
>> off cxl_mem_probe() to enumerate all 'struct cxl_port' instances in
>> the topology up to the root.
>>
>> If the root driver has not attached yet the expectation is that the
>> driver waits until that link is established. The common cxl_pci_driver
>> has reason to keep the 'struct cxl_memdev' device attached to the bus
>> until the root driver attaches. An accelerator may want to instead
>> defer probing until CXL resources can be acquired.
>>
>> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when
>> accelerator driver probing should be deferred vs failed. Provide that
>> indication via a new cxl_acquire_endpoint() API that can retrieve the
>> probe status of the memdev.
>>
>> Based on
>> https://lore.kernel.org/linux-cxl/168592155270.1948938.11536845108449547920.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/memdev.c | 67
>> +++++++++++++++++++++++++++++++++++++++ drivers/cxl/core/port.c   |
>> 2 +- drivers/cxl/mem.c         |  4 ++-
>>   include/linux/cxl/cxl.h   |  2 ++
>>   4 files changed, 73 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 5f8418620b70..d4406cf3ed32 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>   #include <linux/firmware.h>
>>   #include <linux/device.h>
>> +#include <linux/delay.h>
>>   #include <linux/slab.h>
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>> @@ -23,6 +24,8 @@ static DECLARE_RWSEM(cxl_memdev_rwsem);
>>   static int cxl_mem_major;
>>   static DEFINE_IDA(cxl_memdev_ida);
>>   
>> +static unsigned short endpoint_ready_timeout = HZ;
>> +
>>   static void cxl_memdev_release(struct device *dev)
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> @@ -1163,6 +1166,70 @@ struct cxl_memdev *devm_cxl_add_memdev(struct
>> device *host, }
>>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
>>   
>> +/*
>> + * Try to get a locked reference on a memdev's CXL port topology
>> + * connection. Be careful to observe when cxl_mem_probe() has
>> deposited
>> + * a probe deferral awaiting the arrival of the CXL root driver.
>> + */
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint;
>> +	unsigned long timeout;
>> +	int rc = -ENXIO;
>> +
>> +	/*
>> +	 * A memdev creation triggers ports creation through the
>> kernel
>> +	 * device object model. An endpoint port could not be
>> created yet
>> +	 * but coming. Wait here for a gentle space of time for
>> ensuring
>> +	 * and endpoint port not there is due to some error and not
>> because
>> +	 * the race described.
>> +	 *
>> +	 * Note this is a similar case this function is implemented
>> for, but
>> +	 * instead of the race with the root port, this is against
>> its own
>> +	 * endpoint port.
>> +	 */
>> +	timeout = jiffies + endpoint_ready_timeout;
>> +	do {
>> +		device_lock(&cxlmd->dev);
>> +		endpoint = cxlmd->endpoint;
>> +		if (endpoint)
>> +			break;
>> +		device_unlock(&cxlmd->dev);
>> +		if (msleep_interruptible(100)) {
>> +			device_lock(&cxlmd->dev);
>> +			break;
>> +		}
>> +	} while (!time_after(jiffies, timeout));
>> +
>> +	if (!endpoint)
>> +		goto err;
>> +
>> +	if (IS_ERR(endpoint)) {
>> +		rc = PTR_ERR(endpoint);
>> +		goto err;
>> +	}
>> +
>> +	device_lock(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		goto err_endpoint;
>> +
>> +	return endpoint;
>> +
>> +err_endpoint:
>> +	device_unlock(&endpoint->dev);
>> +err:
>> +	device_unlock(&cxlmd->dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_acquire_endpoint, CXL);
>> +
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
>> *endpoint) +{
>> +	device_unlock(&endpoint->dev);
>> +	device_unlock(&cxlmd->dev);
>> +}
>> +EXPORT_SYMBOL_NS(cxl_release_endpoint, CXL);
>> +
>>   static void sanitize_teardown_notifier(void *data)
>>   {
>>   	struct cxl_memdev_state *mds = data;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 39b20ddd0296..ca2c993faa9c 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1554,7 +1554,7 @@ static int add_port_attach_ep(struct cxl_memdev
>> *cxlmd, */
>>   		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>>   			dev_name(dport_dev));
>> -		return -ENXIO;
>> +		return -EPROBE_DEFER;
>>   	}
>>   
>>   	parent_port = find_cxl_port(dparent, &parent_dport);
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 5c7ad230bccb..56fd7a100c2f 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -145,8 +145,10 @@ static int cxl_mem_probe(struct device *dev)
>>   		return rc;
>>   
>>   	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	if (rc) {
>> +		cxlmd->endpoint = ERR_PTR(rc);
>>   		return rc;
>> +	}
>>   
>>   	parent_port = cxl_mem_find_port(cxlmd, &dport);
>>   	if (!parent_port) {
>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>> index fc0859f841dc..7e4580fb8659 100644
>> --- a/include/linux/cxl/cxl.h
>> +++ b/include/linux/cxl/cxl.h
>> @@ -57,4 +57,6 @@ int cxl_release_resource(struct cxl_dev_state
>> *cxlds, enum cxl_resource type); void cxl_set_media_ready(struct
>> cxl_dev_state *cxlds); struct cxl_memdev *devm_cxl_add_memdev(struct
>> device *host, struct cxl_dev_state *cxlds);
>> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port
>> *endpoint); #endif

