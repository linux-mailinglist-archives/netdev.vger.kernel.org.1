Return-Path: <netdev+bounces-189034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E026AAFF82
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C7218892F3
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B69270ECA;
	Thu,  8 May 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cnt7gOMC"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0752AE90;
	Thu,  8 May 2025 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746719276; cv=fail; b=CyKCU0GPr8OKfEO+2hPxox0uUtg67pWFYUMC4O+M6u/G6jy/kOfqWhOGYPCr3U6ruxBIkPxniTnCVdYJZeLN27ocDnbe5H5kaTAqUVyT5b3UZfLBqILM/0TgxtOZ8AN20xVQPlO1p+fo+r8PpKa2SDf0gWoyJ4EKy6C8jZ5/exo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746719276; c=relaxed/simple;
	bh=mA1bGVsO+YEJqoYVmH49NY+o5HWypke9Li72JQCSD98=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8lfgJTeywxET8wZfdrpHRg+tDiMrzAhvix6cWjRKI3sT2GwbA/51NoGu0eVkX5P50WF9CrDnWkxbv0oeWO2nns2E53TMgMnGRmlcMx3SbKY6kax3jX6Fc2mEvUcWSPxtIvPJrSPeaYffZ+n1+r/RoT4QLoxao7PAxfWYCw1U20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cnt7gOMC; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHly6K7Nn2RljLSbAu+pm0mobzKJJprILAYCAW2QEqHXfXjyCx4cH9rPI7Sm9pSBliewC9F5izAv7zcro040ygpTKa4Qh4xjMSJR371OCAuh14Twq/efd5sJXKUjiT+ZWuV2a6mD9VnSsTBZZRwbrQPXbX0XWTQPGJOILDxfdeMHQaZx2dd8oyzrMA5O6ADpDSrPqhi5o3ZiZiOK81ecimRlxaZnYM0azzfcR9z4I+J5l/LCXJ1yTcbiJZJkzGk67PbLj15gG0XIThPNmaN6v+HCV3bqyqnIqIbNSGSfKQ7OiK+q7V2x0HaQzPgFEznUGY2y7kxMV8FRWu237MLRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmb2sxapfBPnwa/xvbZpRn/5puoWhLHWCojtraUyq+c=;
 b=jtxsinRy4kyRKhb5eJImplOkWoFSaLdJ2ux5S6PCReIFtZQ7HFV89+FsmVCEBIqJs/Iq/JDfg19CLt1QP7CMhLxoxxY3nqoic59Q7stbpVlTKAWsEUGGnumu6bO7mwTcHw8nh7zeyukR/9zgQFHx7olWAhUvCRv2lSX2Hm9NYEWHsafBB/t52BVwkv6iq63JcNR5oRsYLfIr259jrBEmFHKoFgTCOnGcvbN2Sy5Y7Bl/F9JBtgVCW/bbKSa0U9gpFVAXrka7oE5iBcrg+pX+gNxoDn5bFv7K6RO5cdCkjgxlVRCL8dqeKm5lv+5lp2NsoRXu82zULRbE1U1x+X6FDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmb2sxapfBPnwa/xvbZpRn/5puoWhLHWCojtraUyq+c=;
 b=cnt7gOMCB0qj8pf8rBrXKyQNzqKxNBKjeimOe3mxzqo+XfO8XsJ8n+WkDi0RseZnKXKFwTluC8gkUgTqX0EHJl6nSPFL+XFGDHPRG0fK0uiOUCBvxJLh1qgvKfVfxF6afPfMDRlsr67eDHOCstvvUzQJCUd+x0FyIfjsAiqFW/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY5PR12MB6081.namprd12.prod.outlook.com (2603:10b6:930:2b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.32; Thu, 8 May
 2025 15:47:47 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 15:47:47 +0000
Message-ID: <75d51ce8-5bbf-4487-9660-1013d732a80a@amd.com>
Date: Thu, 8 May 2025 16:47:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/22] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-2-alejandro.lucero-palau@amd.com>
 <20250507153705.00005300@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250507153705.00005300@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY5PR12MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: a7916ceb-d9d7-4857-fc71-08dd8e47ae0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cms0OVlqUVR2WW85SEg0MWZuWEpWWGZoTC9uSzM3Z3dmd2htbmIycE5LTlRv?=
 =?utf-8?B?eGhBNUlFazVjbkZrSTRJSlZnZHA2WGRiM3c5UFV6dnhvRzRmZXJ1c2Z0enc0?=
 =?utf-8?B?RC9tZmhNZnM3Q2ZFL3A1aks4LzBOaHFvYU5NWDRua1JaTHMwbVpTQW1TQTBX?=
 =?utf-8?B?a2p1Q2pReXMrd3FrZDQvZlZYc0VCSXlYLzZZb1VkcG16ZjlxTDg1SVFiWUhV?=
 =?utf-8?B?TERqRjNmRXAxUkdwTFdrdG5ya1B5U0Y5Ni80ZEdBOWwwdmlGUlQwLy9HV09S?=
 =?utf-8?B?eHJESGUrZ1lzREo0TGFCcUFWNDJhVW9RVnN3SkFxb3hsdEx4cGtyYUJzMERZ?=
 =?utf-8?B?SytDbUR0SWhIOXlHSCtwc1UvZEQ1SDhHbWNLeGVCcSttZGVua1NQV01pN0Rl?=
 =?utf-8?B?NnJXanFJblRyUWFyNys0OGJjWEVURXdIaG0yUFh6RDU0d0huVkZja1prY1Jv?=
 =?utf-8?B?YW9ITUN1cTN6eXE1V0NVbldpTEdDRGVJa3hGV0RsdHBYSEVoYTkxRmt5VmNB?=
 =?utf-8?B?N3BaLytmS1REUHdGMmJXZEtHNkxHeGFhMzRmUVRJdlNwYm9qQkdkTWdaQm03?=
 =?utf-8?B?dS9RUE5jZmVHODJZcWRHREpxNm82QzNMUThIcGxWV1VpRTNYRU03bFFudVB2?=
 =?utf-8?B?cVVaT3hDNnJiOS9idU5VZUhnSDdCckhrQUIwekxuT3hJREVRWlRLT2VqSDB3?=
 =?utf-8?B?dXNUdFZLQjF4YVQwaW1GUGxoUUlSNEdpWmpTVXIxUDk5NFJNZnJPQ3pkOHhI?=
 =?utf-8?B?K1o0NVExZlBMelhqMkNQbTJYOU54YjV2bmM1YjBKdElSbkJja1pSckNhTFRk?=
 =?utf-8?B?TDgwbkFBTld6ZS9lSnBUMkVNTVZkbzVlYlJQTnE5Ui9XTG5DcGNNM1A4dDhD?=
 =?utf-8?B?N25uNjhMcENKNmlPQWd1ODh6dEJtaUs4VGJtK3padlJ4ZGNHMW5HVnVEVGUr?=
 =?utf-8?B?MzQ2UkFyRzJhOEpPZitSb3AxRjhLSXNsSWdud3pCM3VwbVd1dTVsRzB5SG9y?=
 =?utf-8?B?YnF1cHA1Zm81OURza2h2bUh1Z05ORnRBRDN1aGpZbjN2dWdvbHF4azAzUGlX?=
 =?utf-8?B?czZtdlpCUEo0M09LM0xSMVN0T2habEN1OGJ4VjBCeG5yM1hJYzh5ampEaGR3?=
 =?utf-8?B?SVJoaWw2YVRBNmdCeDMzeGR6L08wYmdMc1hRTjVMdkd6aEh2bkFZeTN6QS9J?=
 =?utf-8?B?RlpPbTROYVU1R1JrRVJNWmpONVlRT01Ec3VZZ241UzljTE50cGp4UFlNRWw4?=
 =?utf-8?B?WXV0MjRXckVSSlVKdGplejlaRDA3eXdtSGlXL1orTWJyYnBGazdraEVYdG94?=
 =?utf-8?B?QmJMenYvVmY1K0xNTFBYcjhGTG54VjYwaHhxUW9YcFlQYVoxeFVEYUMwV3hD?=
 =?utf-8?B?RnRSYXBpOGdRcFJnaUZWZkx6RjVEeWdGeGpIQlRpajJzYWFIc01nTVZCd05P?=
 =?utf-8?B?d1dmMDBFa2JBOFREcENVa1gvay92M1E5RGMrdklKcGtLcnUyaFdEY2ZSYWc1?=
 =?utf-8?B?QWVZRWVlWnhheG05ZkxkQkc2QlpyQ3RadlVkTlo1MGNwTkdnc3Y5UHJLOEdH?=
 =?utf-8?B?aWE3ZjRHd05kVDB1eEg2ZCtKK2NqRGF4bmtvbkNnN1NpTTZzNExCYmNHZ2Zl?=
 =?utf-8?B?aW0wMG1LcjE2MHVvMDRFelZuOUlGcHdXRU1xdUlrRWlCUGpJaW1GMnBsSmFO?=
 =?utf-8?B?dHJzT3FFbStTZTVycGd5Rkk1VUI1MTRLQ3BPeVRWa3psaXRoSzZibFBxNFA3?=
 =?utf-8?B?ZVhZczI5ak41Q2pUbkMzRHpsTG5DeW1MTnZYQ3U2cTNlcjlqb0dOdmFlVlRk?=
 =?utf-8?B?WkxpeEdaMkxLbWEvSEJ4dlllR21GR1hHWFZzYjR5anRBbVEzaWZYakp2bTFZ?=
 =?utf-8?B?ZWZtbnJ4dmF4MHNRdVJFZ2F6bTVhRFBIR1ZZczV6bTl0U01KUVN0L2daa1o0?=
 =?utf-8?Q?leG6IYOTRHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2tsZnJXeWNndzN3ZjhPZW1HSGVPZkFFanlMMkhmVG5vbzN0OU5Pd2F4RG90?=
 =?utf-8?B?OGJqZ1habXZ0MVdIcUxDVS9LVmFDZEhlOVFZdDFSQWUwK0xKajU4RjRvbjRo?=
 =?utf-8?B?M1V6WTNvQnRaLzRnbjlTZzhjalFkRHlZVmFoakcvbDlqUzFpR3o3T1JYcE82?=
 =?utf-8?B?QVc4WWxiWWM3QzN4bHpNYUt3U1JXWlljdU0zZEhkVFBYN1lSUkRWdXJLcGtE?=
 =?utf-8?B?ZVZuN2J2aWZEaldOT05FaHlVYXd0WkpCT0JjT3JoQUpoRGR2dVVQbk9HSkVU?=
 =?utf-8?B?V2hnWVozRHhJRCtsYWQxRTBZN3JBNmFBU0lFTjUvQVQxNlhQQUI0WTZxdC9q?=
 =?utf-8?B?bU1DVHc2REEvZkdudXBwSTNrSzcvMTcwQjA3RzVtcG9ZYWJHeUJjc05kZmFh?=
 =?utf-8?B?STdyY25OZ1F3T2wvOGpYZEUxMHFaMHREcnFTdm54WWg4VU5TVzNsNW9xVjR5?=
 =?utf-8?B?SVhhanpvb2RqZlU1SGhQZjZIUEE5b2doNnZSNEduUUFWdmpiY0h4YmQvV2h5?=
 =?utf-8?B?Y0lEYWVwWEtObm92MWpyNE15SzNlZXpaQlZlbTlPaHRnbUxFZXc2ZDhERW5p?=
 =?utf-8?B?QUduMHRlUGFQaVpmWjh4c1RMQ2ppNVV6THZwSkdvSnJLellkeUVLN1VXQ0FY?=
 =?utf-8?B?bUtTN3hiVG5nUXplMWp5NWU2TFdnYWNLVys5ZXorS0JKSmkreEpIWENxZ0xG?=
 =?utf-8?B?ZUVaQnFnbnRpaHNZMERoeVMrUEg4RnE2TjZ4dUNieWF0NjFDUmVHaGhwRkJR?=
 =?utf-8?B?enJpOVhud0pSdWU4dkQxUk1RZ0VkRTQ3K3ZIUlkwamhiVlBWOXVvdTY5emtR?=
 =?utf-8?B?ZDFIUUpyYjQ3UVlrODdxeGdaRlM2UzN6a1hOeHMrODdsM0VwVHN3cWRaR2xX?=
 =?utf-8?B?U01qMTI3bVlJaTE1ME1ZNkh3cG9ZTm5YY3FNakJBK0NyQk9NT2pScEVkK0Uv?=
 =?utf-8?B?UVpERm9ZNzlNc0l3VkhmMUdYZWZoWGw1ODVEMnVsdk5iblhsVDBVdkpMZ2VM?=
 =?utf-8?B?V1hMTSs3OUZBYjZIcGlDcTNUeCsvb0RTQlplbjZvNDFKbWFrOXlyV2Mvai9B?=
 =?utf-8?B?dmY3STRuWjJDZS9YQzZ5d3Bkc3E4Y2NUSU1vMHFINTBuVHZtandqWWNMbTFo?=
 =?utf-8?B?WWhLNzJXQVJkQ29Ba3V3dEpHSFlkMVRpTWg5MkgzdjVIUXkzamFZQWhSWHFZ?=
 =?utf-8?B?Q3dEbEZueWk5MHU3NzEwZzQ2Y1lUWkNYQTJqMkM0Z0V1VEg1a1ZoWDg5cE1v?=
 =?utf-8?B?SXVlcktncVUrMS9yck5ucnFxN0luWmtLeERrQ1p3MUlETUpSdEJCL0NwYWpz?=
 =?utf-8?B?WEpSbkF2KzNhNUI4WTZBcnpSbGxMQmR3bTVpdldSNXkralk1VFYreEpYV3d4?=
 =?utf-8?B?d2dJMEZIbzc2NzkweFdxU0hxc2gxaWVnN2d2cnBvbEpyNXFMWVVSZVNCeEVN?=
 =?utf-8?B?eEswMUJzVy95KzVFVHpJaE5wNWNjbVlha3ZGckNpUGEvaWw3Q0I3WVI4cXQ5?=
 =?utf-8?B?VTl2clIwbTJoRXpjVFpaRVk1OU92eDRwbTdJK3o4L1NVWWFCWjZrMEhkL1V5?=
 =?utf-8?B?RFEwcnFWbnpINnI5K3NUTy8zM1RQNFdFNUlKVzhwQktXS1JCS0RwU0hlbUhm?=
 =?utf-8?B?cnc0SmRod1MvdVY4aDRXcStOMytXZ0ppL3pteEErNE5lVW4wRXRzSU5qU3lH?=
 =?utf-8?B?bmNZdHVaUnIvTkxLNnlGYTF4L0JsSUZjY3V0RlZwbHZqQjkxSEtQeTJvV0Fq?=
 =?utf-8?B?OXZZOW0vSzZ2cURQcGxMWUwzVUVhWHRaNGdxZG10MHhPblZocEsxVmpkbitG?=
 =?utf-8?B?NWtwUzFZS1I4aTA3YXl6V1VFM3E5dDhJTmJ5b0FaNTJyMXBSWjVaK0VoVUZD?=
 =?utf-8?B?T2Rwd05md0VaenYyUG9QQnhJZ1ppT3A5L0tPZFZwczdIMFc3dUV2MWpMdXZT?=
 =?utf-8?B?UDQxbStkVXNiQTRreWtFTlR3TXdHdk1XZ2hqS3ZpTVNOSU5RUzFSQklIcEs5?=
 =?utf-8?B?M01HZVBUQk9TeXJyUGRNL2h5dnhvRDhLZUQyM3VzZHRxbXcwQ1ByTnlwUkVZ?=
 =?utf-8?B?Q3U3OEQvMTVPSUZKdVlPOTJuSElFSEhqMUlMSUs4dzZTdFRvQUx4NTdlZEpP?=
 =?utf-8?Q?W76DK7u0YyQDmOXdhUh5zg949?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7916ceb-d9d7-4857-fc71-08dd8e47ae0b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:47:47.2865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQzl2XKo+OTsVhpW4RrxsElVL9224l40l2URyctEJVQK4UaDSXCNahjjWM3piLQ1q8+2cG3K7dvoj0Z0uowt7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6081


On 5/7/25 15:37, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 22:29:04 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> new file mode 100644
>> index 000000000000..a8ffcc5c2b32
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
>> @@ -0,0 +1,210 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2020 Intel Corporation. */
>> +/* Copyright(c) 2025 Advanced Micro Devices, Inc. */
>> +
>> +#ifndef __CXL_CXL_H__
>> +#define __CXL_CXL_H__
>> +
>> +#include <linux/cdev.h>
> Why this include?  Maybe needed in a later patch?


Good catch. It seems it is not needed.

Removing it.

Thanks!


>> +#include <linux/node.h>
>> +#include <linux/ioport.h>
>> +#include <cxl/mailbox.h>

