Return-Path: <netdev+bounces-237156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ED3C46478
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5A894E9DCC
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA69309EE2;
	Mon, 10 Nov 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gDURIWOb"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249622538F;
	Mon, 10 Nov 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774141; cv=fail; b=h2m7tSknhPyqEqRAY4I1qHNbcPCZYfcNTAR7VBixGOBb7nuNSeCZe2vg7GSe87inhbcD3FT1yuyGrGJmdjf5aRJzpOkLF2duDNTUK00yFQfLtLz9d0b+M2GYIol/Uk/z2MLn258ni/jJ87rXQLLva8zm4TNfd4IMb87Xe+W1vAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774141; c=relaxed/simple;
	bh=xZUYUcFVb+0wv94PyFsj9zvQZfLjx+kDDafGKhHGRh4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A0Hxice5+sCUGxt9UmFS5gpJAkX6CCSnYd8O7hMjDPx1Q8C4tPb+yP8FhToGOOr/J35WHly5Urmt/lZghm1Wv3g06uME5Gb+Vekl4QJbuaoBPpNk8/JweDBC6cNGL7P571f+daJG7a5yS+7hzBlOx1F0hAmVtAHnsl4KmJOOQcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gDURIWOb; arc=fail smtp.client-ip=52.101.61.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6UB9iz3NwzXDWwJWwX0+YqZPlvybGV6SNpsvPd9tBnTTsEsMPpUIcvwXx6Hi8ViFBPktHzZGkhTsY21WU5n5/cZUXaLqUzJHjyVEhdSLLMZemAZ4JgkEp/03W6TPErmhWxs3gWvU8fNwZGMYLNnaDK78VUGgqLEdotZhj/bUl9MAtqncQZwY6eLgN+AufIaMEMjgETgOUi+JzYaQK4JmrLAtUOpT3mVRLehsZPipaTniWKvYV6OQfwdsNC6/Bbhz9I8A0K4670wKKpYNAPVzEe1SG0BkbwVCp7GxRBkFP4WNQKCsQkyJRjrS3PuQXOjCLLiKX0f02UIXohS1KavVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZUYUcFVb+0wv94PyFsj9zvQZfLjx+kDDafGKhHGRh4=;
 b=irp3EL241JsyhmgmMaMWVXYZQGKqK9glgoX+94kMV9w0BC6ZKcMyFXDRDEAvonufWH6cT5AIEc9St9Nsj8GyduX/OrLSWGgk7J5CmcHXjqUXvWsMuJwTMB1s1HHY+Sn/y8fI5VsZjrOoWKnYQfHqsmBmuEu29GHetAEv0xkNzZO6pg7mBLA+EHM2xjkmJzU5SZcn6Ww4a9+VYJ8lJmQ6uhIBQD/+op2c+Ny7XB4YlqDVSVS6e/eqZjUPonYn+ynVaHBgKMo/X1hffzRIP70QeZqBXEHMmX9Tzv4PfwTvx680uq70nUznzE0vEvw+TOrLkzRfS0jsjpozoQLJUH0Ulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZUYUcFVb+0wv94PyFsj9zvQZfLjx+kDDafGKhHGRh4=;
 b=gDURIWObU2czUFTgaRHzYnNB+GHFLvd4u5aFzfDApRpnPdZ2mrrJ+upOb2atK5JJdv8smBKywHxobF8/YalzYYoCAJ8maahpI8SLyPwuFMj929YPSawL/mwOCWu9Aj0xmUu3PVKN7YbosocGCp7S8XEt1zixe+u11dC+rNoVMlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA5PPF590085732.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:28:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:28:55 +0000
Message-ID: <b994c059-9f2c-4d79-908f-a3d62b31133c@amd.com>
Date: Mon, 10 Nov 2025 11:28:51 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 08/22] cxl: Support dpa initialization without a
 mailbox
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-9-alejandro.lucero-palau@amd.com>
 <20251007142200.00007840@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20251007142200.00007840@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA5PPF590085732:EE_
X-MS-Office365-Filtering-Correlation-Id: 5699c894-761f-48f4-8333-08de204c5434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFhML094MEpua2xkQjNOa2MzZkdZcC80NElDM0FvdklFamV6aFhlSHFhMTRh?=
 =?utf-8?B?bFJpWDZGY0poMk15V3c1aHFoNlExNnl5aGk4bHZGT3YzSmE0cHp4bWJMdC9W?=
 =?utf-8?B?MzA1bGJpaDB5SlBSb3BBVll1Tk5JN212YW92b1BRN01pa2VlZ2tQTlM2cGh6?=
 =?utf-8?B?Rm95dEFHeC9OanpFV2cxZm9sNzExR3d1eVNKb1dEWnZvRm1VbnRJNWIwWklm?=
 =?utf-8?B?bFZKbzM4ZndPM3RMdUNOS0ZuM3dnZkU1NjZJNTRjbklxcEFNQW1DbitBeVBu?=
 =?utf-8?B?U1hVbWJvRHU1ckVFdjVXbFFPc3RZZThpRjg4WXFRemY5ZXVNWG5vKys1Z2w4?=
 =?utf-8?B?VlhtSEM0NlZEam5JYzZFYm8xWkptRXR5N1JmQnEweGZyQ3V6eVFTNGJTNS9o?=
 =?utf-8?B?T3pqYUZXaFNJZVl6TFdFczJ6RENsRGwweUxGVzBYbmlNdWRna1FuZ3hPTStT?=
 =?utf-8?B?MlRxS3ZyV1pzdkJPdWpuOEhDK2h2a1NhYnZQZTY0MXFhUXQ1VmhzV0dHcXFR?=
 =?utf-8?B?dTErYnZwejU1RHJrZkROZ2FMclRDWmtHUnoraWxwYzZidk5ycjhXc3RFOXVr?=
 =?utf-8?B?Mk40OUYzdkhQTUh6akZibDlHcHVxbHpKaW9GOVB6VnFQRGRGTWNnOXJTc2Mv?=
 =?utf-8?B?akVyM2sySE44UitJVk1mLytVYlc3aWRqaHNaR09JTUo4MWxQM0p0V1BZZFYx?=
 =?utf-8?B?MDNjWXZjcGV4N21Zb0NFT2cvdnB0RGpieitPYWczeTdZMlRXM28xbmdMU2pP?=
 =?utf-8?B?MlQ2SE82VjNtQjdWckJpY1FLaFIwZ2loNEw0bExVUFZENzdzQ0dOeVREU2tH?=
 =?utf-8?B?elhwVTJWV2FSc0tXWkRqcWhxL1VZR0VqQng1MUEwVThKc005SThTcGM1TW5r?=
 =?utf-8?B?TmZwQmxIQkR2NW9DbUhZTmhNb0NXMUtGSDZLL2crMFZCRlA5RHVCclYzbkJx?=
 =?utf-8?B?c2hLMCt5WExhdVczc013TVhmODJ2V0tKUDJoaE9XejN1M1JYMUd0eG5JbUc0?=
 =?utf-8?B?eUtuWmJJUFQzZnVPOWxZYVg5MWNOeTc4VFhxZGlsYk5qeG54NmMwV3o2aWNw?=
 =?utf-8?B?TXQxWWh3M21MZUVOV1RpcDI2UU54dTdURzJCTkM1aGJ3UENSRjRlVU9hd3l0?=
 =?utf-8?B?Vks4RlpRSnZMK21FSnBKSDJxN1UxcTZPTFcxVkw3R3p5OElua244VlJ4KzND?=
 =?utf-8?B?UHcyNkJVeGxyKzVJS0l2M1BGRWMzNFdxVWttZ1JUblhpakVyanVnNjBzdTlv?=
 =?utf-8?B?aVNtQTdDMVNGY2lqOWFDVnRnelEwS2M3SFlyLzZiQ3BOTXVZcDNiN0lIQmZE?=
 =?utf-8?B?cVZmVXgzamJFSVk3bUQyM1RqN0VBSXdDZWdDbHlkeWw2ZzVMdmdkL1drTnpp?=
 =?utf-8?B?NDdOZGc0Y2VqeVkwc2x3WEkzcm9MRFc3ZXdXVzlYTTBibVVCa2V4c0g5OEI4?=
 =?utf-8?B?eERlcldwQXV6bEFiQkxmYkVWSFJob2Vhbnl1OEd4TGtwZTNYQS9CMkxWYmtu?=
 =?utf-8?B?bDBnUzNuZDZCa053WWJzWElTRTNJckorTVI5TUpkT2NzV2Q0Vkt5OEVOY25q?=
 =?utf-8?B?S1lzTVJ5L2owenJsbzlaZWZQUjBKQ3dvbVlQblQ1N1diZCtkQWtwcnExcEhN?=
 =?utf-8?B?cmJnajN2SUZpOWNYM3BKektoQVRzV3RFRGw5THoybHYxOXY2cndXejE4RGJW?=
 =?utf-8?B?elNsSWQyNWZGNDdibUh4WE50b2VzdjhiM0tyY1dvN3pQQzZLSzlKaGM2aXl6?=
 =?utf-8?B?RHF1Sm5tSmJycU43akZHUStIcFhvRXplSnBUb0JFckFEWnJwVzhTVjdnU1V5?=
 =?utf-8?B?amFiNWRuSEc1T2RtVVJiZnFOYVlpdkxHNE1reUdVdk9PSVB2Q0FVRjRQMTRp?=
 =?utf-8?B?aDN2SkhXS3YwMVB4YmcyVDVKSTRNQ09lMjNjcFNVWCtVYWQxdmJ2YllqcGxp?=
 =?utf-8?Q?AbgxObHZyaeCFgATi5oGFHNwJGd+0SAl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S25USkNaTUw2ME5Gbjc1MkJKZ09DVzdvdCtJVGNuNytUK2kzRk5FYTY4a1hU?=
 =?utf-8?B?VTRRbDBpWktuQ1dOUHdkUHQvSGkvaGYwcno1OHFQQ1RMUTBlcnZWNStnbnhh?=
 =?utf-8?B?VGJrWFU2TUdxV1BmMmFQSzdRUWJUWEM4WVg3Zkgrakh3WkNhZ0FVSzE2LytN?=
 =?utf-8?B?ZzBlT2JnWVFBb0dHc0VleHhvRTVhTENCQW1QdzVKcjdVVDVaa2ZhQkRqR2FU?=
 =?utf-8?B?eGordWpNZHllcW5rRzFWQ3pIaVFzV1Flc1dkRisxRVFDV0lCRzJReVdveVBH?=
 =?utf-8?B?R2VVTWc5TGd1K2RvL1c4ODdYM0JIbmxmcm83NTFYYXNzSXJCUVZBMWd3cG5h?=
 =?utf-8?B?ek9rYTZJd3dYS2pNTVZHbWpXSmVGZnl6aXdTc2c5elZlRUxzaGtwbWNGNzVx?=
 =?utf-8?B?aytPdlFYbytiZy9tNEMrcGdZVUJsdlZ0WnVWakFZbHovQ0s3SXhmYVFQdElZ?=
 =?utf-8?B?azJLTjI0Um5RUi9MRG96SGtqd1NuK3U1d1lkQ25KWVhMaGtnL3l4cG9MdDQw?=
 =?utf-8?B?S0hRdkhGV1FGUFU5SVd0QjFyUVlWS2hBRHk5M2N1eERnY1N6ckdLMTBRYnNs?=
 =?utf-8?B?ODlwMEdReWFWU1VuZ2VPQ2JYOXEvamZ3QklmRlNSY2NCdnU5d25CdmFya2Rn?=
 =?utf-8?B?c240bmJYTzFtQmRBNXMvR1dwVkgyUERMV3JHSit4MisxM3hRNy85SjhwTGpu?=
 =?utf-8?B?bFpPVkdOYjJHeFhTeWtXclVJeVRaU2dFdkdhdE9SZS8wQ2pDWjZDNzRFS29H?=
 =?utf-8?B?cUVKZUh2WUlLM1ZDTDF5SVFWZmZPendSOVNNVGNsTVZRelQvaG9IZjFaZi9O?=
 =?utf-8?B?RE4wWFpQNjFFNzUzRzJyMWlic2ZscnhaRXZ2QTR5aC93OCtUR21PWWJ1WDM4?=
 =?utf-8?B?c09iWnNVUlhCZUdTVFJYejNwV1dpR045TTFNTnBRTFlNKzFUVTZzSmhIdjZt?=
 =?utf-8?B?Snc0dUI1NFU3ZTd0TkFhUzBYQkdUU1FYTUlsVkQ1YkpDY0huRlk5eWhSMXps?=
 =?utf-8?B?RGZUcWU4aGJXaEpjWkVYTU1meFBJMEhsK0NOb1ltRUlGOHViUVNOVi9QdnFq?=
 =?utf-8?B?T3VDR2c3ZUVVKzRJNDhSdkdhdnNucWVSYmVGK1Yxcm1VRmdFYkRMbmZOSU1q?=
 =?utf-8?B?dFRCNmhXZXZlVHFBZWFBQkhlV01DZ2VpZkIyN1orNTY2YmFiSXhHTWF0TWg4?=
 =?utf-8?B?M21tWGkzRGVKWTMrd0xLSlQrQWJEVkJJeTlEazdLZ0pYMEN3R1ovQlNmV1l4?=
 =?utf-8?B?K0RYRVNlZjBNTjFiU3FkQlJxTEVUUER5WVBiV2xOdkwwTVE5VFFtTnE2ekJL?=
 =?utf-8?B?UC9lZ2RPek9xckNiUldrd3BsNUZvSkNVQjNYUlhFODRJZUtMemh2OWJIbGxi?=
 =?utf-8?B?aVZzb1pDWjNDdHR0Wm9iRzRQMHZzRkhrQVU5ZWY2YUxSTEM1LzRlYTFjMzJH?=
 =?utf-8?B?TlJ3S0tVOTFyVytwMjhrWWlGOTc0eWIwaVlCVzZvOHV0ZmVtVHBJbktTaWdi?=
 =?utf-8?B?T2NWTzNNKy80TkY5ZDkvaHQybi8zdk9MMTV2UnJOQ3ZYUDV0VDdEZXFsMnlE?=
 =?utf-8?B?NEd5bi82THJzSnBIUTRGcEVJN2luY2EzK21vUHFENXAveE5Sa1o5LzI2YVJs?=
 =?utf-8?B?eE40T3I5OVFGY2htNEdaaFl5bWdvL1prZUIvMk5mWU1qVjdOR1BLR2xRazV1?=
 =?utf-8?B?cW1wNmc3Y1Y1TU5mNVNBOFJQNXg2bjZESmR4bG9aaTlQRzRiM2VvQkVpc1po?=
 =?utf-8?B?TlpGNGJqb3dFUjkwdlI0eG8zSEpCQ2g2RWNrVTgxb2p1c1c1ZjFSZU0wa3N3?=
 =?utf-8?B?K0dUakZHY0laN292S3d4bHlScjBxak5sbG5ralJQNDQ0R3FaWDZjblNoMlhW?=
 =?utf-8?B?Y0N4ZmpsUm9iS1pjbXBUSlhMa0hiQVBsNlFtTUdMTjQ0aG1yaWtad1ZQN2tK?=
 =?utf-8?B?WDVzNGZ4RStXZDVhSVhML1d2WkVyVzg4bDdLRHFDaHA3Q1BMenV5UnBSazdj?=
 =?utf-8?B?UVdlYVRaMHNnZ1BYZXRGTXFRbTh2NlRodlNwcDFwaTQ3TmF5aGZHVG44KzV6?=
 =?utf-8?B?MVk4MlhwWHg2cmo1bllZR2ZlbG5UOWU0NmtKVWVRb3F1SEtFTHRRYUNFcE1h?=
 =?utf-8?Q?Z4VCStEcAmmp40pJrOINV1pdJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5699c894-761f-48f4-8333-08de204c5434
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:28:55.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s4y1eFLP6bFLF8pD0VEIL9kJFM42uHNp6uZQJcSSsdOiSm0IwbvUXXbLmiluq05bUiXnkoDAN1MEDxnZ9WaHTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF590085732


On 10/7/25 14:22, Jonathan Cameron wrote:
> On Mon, 6 Oct 2025 11:01:16 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
> I think this also needs to mention sfc in the patch title as we'll
> need an appropriate RB/Ack for that part.


Right. I'll do so.

Thanks


> Lazy option would be
> cxl/sfc: Support dpa initialization without a mailbox
>
> but there are probably better options.
>
>> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
>> memdev state params which end up being used for DPA initialization.
>>
>> Allow a Type2 driver to initialize DPA simply by giving the size of its
>> volatile hardware partition.
>>
>> Move related functions to memdev.
>>
>> Add sfc driver as the client.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

