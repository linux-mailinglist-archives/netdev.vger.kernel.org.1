Return-Path: <netdev+bounces-157502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C80A0A758
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 07:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7245B3A8933
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEDE13C816;
	Sun, 12 Jan 2025 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="htUyu29b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CF14A8B;
	Sun, 12 Jan 2025 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736663873; cv=fail; b=OQOd9DSLDFp1QWHslBNqaY+HUxAwzMTD6pZ+jwpyBCeDmmSm2Gxu9ZCTkRqYIo0pbeflKUndxJeSoDyN3g+5JtbWr0ucchzUK8SQRvDm84gZ0RidXjUf3f8iv5CD0RB8VqBh2286ysB4YsBjanq0o033S1c2wRBctPiitVFJ484=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736663873; c=relaxed/simple;
	bh=Y0vHFfFybLzEtRVYHTTPopga/+0OS1mr73bpP7VD9m8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OQpkxw9u0bIxX58GO/GCjFYuYI7sr5C3RHa68yWwNF0Wd9yDCMe2zto+tYBFb2caRtUb9nTMKjJtOPen/uaFrBJPap6ZPxA5/KLwdPxI+xLVBE85zfSyDbcvVuUzThCQ6aRWExy0JCIG6qxi4CuuRk+HP4TlO0dBpcPvxZ1c1dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=htUyu29b; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRkQIuTNhoUnOq6R3gXuOU1OF5Xz3+T1FnAEkesf7hA1K/UnQNa9rmZ980VEpuWxX0ocmj/V/0FGN+O3DkWk2xMF4UJ5h/ofKbZn+aViqhLsCKEbRSxEZCs3InFTymtBMX1b2bPu7DV2ae5aP7uEIcR9S1fa30D+j/5nq4S809Z95VW6iDhWLiay7kHi5mGv3EFhFYzvE1oqLXiIqTOCt4HLSYHQxYt5jCKFaPcmL+gR5zCHq1JDDoXvgKaPXKaPJApZgVskZXE6zpTbK4humRvFfzwxaNJDetvssOC8Plv8IeKDiE6of+OWy3/KEyLrUnxLfNSGQnLDFIXu8ODrNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+vlT677xD1bkEJK0+2lcqjRoI3g3CoSbHDw4qvvPf4=;
 b=wM3CVNorNCe/rrUCr5/OZTeLn95wPyim2f2HZS1nkzdPyrtqVJBLp+V4v6FOpbMDTbwqnjCfDPL85cwI8QLCYntetB/irXufxbpI4XGlyDT4BaBycxn7CftwBX7I0WEhYFcFeRHwxlfk+4xunaLKviVR85U5EXNUqRNjJMSH9tIO/mnFL44TPY0l+je2tWSOVz3LDxdBf79A+qVHDmiDsa8NIfd9yFOyz5exX9UjGZnv6jdLeYypSn/jovgxLBpANx0QokyxM59CPUkf7jOHA3U9tJlIFMB/VqS1x/nw7g0hHAAEsvK1BWl3tYextMU4J7hXoxx+DuJypxf3nbJuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+vlT677xD1bkEJK0+2lcqjRoI3g3CoSbHDw4qvvPf4=;
 b=htUyu29bsM9lIupq3/gu55F2ib97fcsfcaYo0typ95hubeVitSd68e9Jo8LR5qdgKvi+FzkQbKKOz7qm74ou5d+pJoRDhRSrzmONukioGOKZvsJaI9au2UxEk2NhTBiScjx7uXXMRAy9sWE5EuKRTxT2KBWSlYa7f0lndEgww36TZIoK9McVrEZ4ZRPj8aiNbz1WugkVVHP45lmxDgcOnC9M7EGAv+1ye9XJJ670HNTJtY+wo9Ae/fzsqTDzy6nuvUcWB03USfma/A8aDdLzSb8BdCrMJAWEsItLC9admgSUEPJktPGfSFi7geMGVcxX24qlL1t8HQbm/Va0TR2yzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by SA3PR12MB9131.namprd12.prod.outlook.com (2603:10b6:806:395::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Sun, 12 Jan
 2025 06:37:49 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8335.015; Sun, 12 Jan 2025
 06:37:49 +0000
Message-ID: <cb27ef1b-d316-42ed-8781-69bef7dc76b8@nvidia.com>
Date: Sun, 12 Jan 2025 08:37:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: Silence false field-spanning write warning
 in ip_tunnel_info_opts_set() memcpy
To: Kees Cook <kees@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-hardening@vger.kernel.org, Cosmin Ratiu <cratiu@nvidia.com>
References: <20250107165509.3008505-1-gal@nvidia.com>
 <53D1D353-B8F6-4ADC-8F29-8C48A7C9C6F1@kernel.org>
 <35791134-6c58-4cc4-a6ab-2965dce9cd4b@nvidia.com>
 <202501090852.AA32AF8BD@keescook>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <202501090852.AA32AF8BD@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|SA3PR12MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cf4042-de0a-4a60-7204-08dd32d3a1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zy9ZZm95dmhtWWJQM2FvVE1uVHd6aEpFZUF2UFExQnZxdGtsTGRIL1d5Ungv?=
 =?utf-8?B?UHVVMTU2OHVDUjE4SlVRSXl5NFVoYjFUZ29McU8wNGxlWU1OTnVYcUtUOWsx?=
 =?utf-8?B?MHpLZzF4Z3k4WWxicG5VVC9ibjN3S3J4eE9uQjI5aU5qN2lpU3ovd0NDRC82?=
 =?utf-8?B?SWFiQStHZW1xUHNCdGppMzh4WFBHTmtxemtNM0NVb1N3WUNXQUkvK2FPMlE4?=
 =?utf-8?B?QVYxaFdOVmdod2pESUtFOUdaUkpiY1RzZnRKU2d5SWthOXRJcTRwdDYvVzRo?=
 =?utf-8?B?djJvL3NMakxHaEh1Qk05K0pzQ0xaeEYvMlB2UDExWitpUkpsUnNnUlkrSVNx?=
 =?utf-8?B?MXBQQ0M5TXFQT2ZNVWlHOUNBS0NCOUdqS2hobGpJZytZejBsV3FWMFZ1Rll0?=
 =?utf-8?B?eVRZV1BFWm9hUEt1bk1nNVZnWkdHOGgva1FSUGk4MjN6Qm9URVBONCtUQlc3?=
 =?utf-8?B?UjltWENJazFFTUt4TjN4N1B1NTRhY09jK0hwUG1lL2lXYXFhcDNNUkF3NVR1?=
 =?utf-8?B?dUNENWNVcGg5blBBZkJvYWg0ODlFZUJ3MnpTY3V0R1lLclBEVWYyV3JaZFlJ?=
 =?utf-8?B?ZVNqcVEzRmozTWFPR05jWmwwcktRSFVpQThmeGp5Lzl5azBkRGQrNndkcmNn?=
 =?utf-8?B?SWlOOGV2QTlXT1psL3dRMzA1L1NDSm9DWDlRaE8xU3FmK3hqaU5QSGQ4K0tO?=
 =?utf-8?B?VVgyckE0RSt3RFNIVTNXU2lEOSs0aUFtRmJQaWcrNjRJNTgzbjVLc2hObk5i?=
 =?utf-8?B?WldCY1RRWUZIN3VsemdYNVlJa1FFcC9NRzN5THBETUsxZGlEZlN4RDl3elNZ?=
 =?utf-8?B?QmhQRnVxZXdUSGVlZFFoaVhmNnZGTU9MYnY0cHVNbE9FNzliRVBsSmtqMHNh?=
 =?utf-8?B?bUg1Yk4vVXd1QThwdGN1RlU0Uzh5dCtQNVlEK1RtVEFNK01nWEpmcEJFdGwz?=
 =?utf-8?B?V29ENlZkQVlRZGFyUmZ4TkF4Q3ZXWXFkU3V5Q0U0OHk4UDVZaEhOMFQ1YU9J?=
 =?utf-8?B?L1IrbHdOVXVWMFVuU01DTVhmaVkrYXdmOVRucGJpVHdpOGMwWDdQMVZvbE1R?=
 =?utf-8?B?SGhkVnlVdXNOZ3ByQmVqcTY5VlZPcnBvR3FqZXluY3pqV2V0SjIweDladEk0?=
 =?utf-8?B?WlJGTFhnL0EwaFc5dTV6Zy9qZDIxSU10L0RKdkt1dmJtNTFPaTZEeUUxNGQ3?=
 =?utf-8?B?WFJYaTVSeml1MlRpMWJReTFsUTRwUHc3bzNvTDYvUFYzaUV3Z3ZYTEd5anEv?=
 =?utf-8?B?T3pqVnB3UU1SL3JMbnhVdlpnMy8vT1lqY2NkSjEwSnN1VVEyMy9vdzZyY1dB?=
 =?utf-8?B?WUJoVmhYSjl3QngzZkhVOGNYQ1hNcFhQU240T21pb1RlZWFVSUxhQVJRczVx?=
 =?utf-8?B?c2pJZWo5cFNqdGtaNmRGQVNCYkloamJ2QnBKaDkvR0pXMUpwV09QMllqSnpx?=
 =?utf-8?B?RzE3MG5MenhUMUdBN3AyejhreUptUllYb0I4ZUlycnhmTzNvNFZxYndoMXh0?=
 =?utf-8?B?blpaNlRxQXA1OEN6dW5za3dIY3dUUXFEOU41UzZSc2NZV2pZUXhFeVN4UEFv?=
 =?utf-8?B?Yld1MlE0T0loelJ5aitKUURYSkE1c0htT0ZyaGpKYzFKd0NmZGRLZStlQ1FW?=
 =?utf-8?B?a3FXa211NW13OGhQOUlta1liM3FxVjYzWDdYbWQrcXkwTE84MUlIdE9OUVNy?=
 =?utf-8?B?Q1JkNm8vWVJtKzUwSmw4Q2NwWlpDODFEYmNJblhyWGp1azhwZUpBYlRhK0Na?=
 =?utf-8?B?ZVY3RmlCUG9rOTVhTW1qa1FnZndDU2V2anNKaEVyQmxmaTlOZnExK2NKT3Np?=
 =?utf-8?B?NCtqQ2g2VENlb0o0Qno5NElLVmlQS3p3WVkrWGsweTdHTit1TzFYVjZsejNV?=
 =?utf-8?Q?q5UWz8VCpFoOg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0V4eWY3ckhUWVBVUW9rTlBzbjBuZTVYSzY4eDhvTXpCLzR6UlVyMFM4SURM?=
 =?utf-8?B?TEZTbUdBd1ZybWZKeFk4aitmaHFPVjErUnR6WVNlaWdDTUJDL3FZdWkyaFlm?=
 =?utf-8?B?S0pOYXRsbGVaNmt0SlZCYU55K0syYXk2WVN1TkJ1V0hBcjQ5YjFwdE5wTHBv?=
 =?utf-8?B?WFQra3BTbTd4cVdNLzJRTVdad0phOHhhYmsxaVRESCtnOTZtQmt3WjgxRCto?=
 =?utf-8?B?WXNJaFZHazJSVVJKdzF1TEFWeDk3SGZTR0JRUjU1ZWFiTWxBMHVLZUx6SEJk?=
 =?utf-8?B?UGlldXh3SFBoazNEMGtjalJPRWJOYzVrQzVqTlg0U3lqaGphdGdmNG5CUUo4?=
 =?utf-8?B?VXErWHRGSmtkUjFORGxLZkFSa0xuZSt6N3g1c0VuUXVtL21Fdkg3WlRIcjhN?=
 =?utf-8?B?Z1RaUUVSb1M2bFFtZ3ZjTnRmZ0UvQlhuMWRUWjYvMHEyNk1nc0Eydml2b1R0?=
 =?utf-8?B?T0FncXVDdHdqdWp5dzVOR3Q4UkRtN0Y5TGFvMm00RGFHOHJQcTd1THNHZklP?=
 =?utf-8?B?ZVVoekVQSGdEb0pYSXQ4bEJ0MGxYR2gzUGhmdk5sdDdRajRXcWhxVitQYVJs?=
 =?utf-8?B?MUx2Vm5VWmxPdlFUTy9OMHBrbjJFV3NKRk5uZnQ1TXpscWNzeHBNcktLSlUr?=
 =?utf-8?B?V0NNZCtOZmZZRllNZXgvbS9mWnk0OG1zSTY3a0Q3Z2R3Zi9laUhDOWpZTWRU?=
 =?utf-8?B?VkJQeUNqaXJCaC85dU5PQm9QUEoreHNjRHB1LzAzVkpyYTZBLzNrVDBtb1dT?=
 =?utf-8?B?SlVwYTZMWlVkWE5qL3pYekZwSm9PM3JEaW9neUZIV0NxWWN5S2txWFptcEhO?=
 =?utf-8?B?bHFRb0wyaWk5QzVWYkQycVdwaWNFeWJWV09hckg5c0hTdUdOUVdXZVZLZlQ3?=
 =?utf-8?B?ZE1wNUdQeVQwUVVjNGVwRXFhMkZHcXJ4c0liV1VvNUFNYythQkd4MU82TFVM?=
 =?utf-8?B?bmpPcG56ZFhvOWU3ck1aY004a0hOaWVKWUhVanM3dkNockdxTmNUSmFTUW1n?=
 =?utf-8?B?SldBRnJDb3JrOGp2dS9qUVNFdWl3S0owMlhIZDh4cXMxaytBcEE5cXlHbU5N?=
 =?utf-8?B?N3F2d3JDSlI2bjJ4c0RQWE5HOE9oK0NueDFJb295Z2pqWUpmSHErU2FKeGxG?=
 =?utf-8?B?RFd4cmNsd0ZJb1I3S2VHWGpXdnF1Q0VyamtmYWgrQWMyQVY4eXcxZ0YwYk5o?=
 =?utf-8?B?U295NFgxaDRuazN6L1hZVU4yYmFXVEJIOHBielFXZmRlVWg4K2wrbU02THoy?=
 =?utf-8?B?c2g2N3pNYmFTNlQ5aEVqYVFmcTE0T1V2VkVpOWxmRElsTzhsd2lRRUlGRExM?=
 =?utf-8?B?bUVSbEdHYlhLblVIVVJaN1Y1aWR0cGJHdFY5a2tUa1VLajhDQjVpOEluazQr?=
 =?utf-8?B?WHVtLzU1TE9UTklnNWxJZndHSU5DZFZzK2dGdmQxaXErc1RlWXJmUS9RMlY1?=
 =?utf-8?B?czR5SjZING9XZTZFVyt6K3hqMlFoOVNFTGN0L2hSYzk3aGRTcW9mbEF4Uk9R?=
 =?utf-8?B?WFp5SjZtQXZkSmhMdzIxMFpkZjlWMzByMlMxVC9NK2dNcVBjMnM0ODEvLzJh?=
 =?utf-8?B?SkMxYndlMjNvTExQUnVOMlJ4K1ZrV2x0VThZVjc5RHJsTjQrK1NGUHJkV0VP?=
 =?utf-8?B?RmVjZWlJMnhzQ1dsVU9seGxaTVpxbXY3UHNPUktTK214NlFMZ0hHR0FEd2x4?=
 =?utf-8?B?bmlpMWlxS2s5YWwxcG5zR2UxTlYwemRWaUZRSk1UaHcvaWdwSEI5bGZIcFdw?=
 =?utf-8?B?dVZHTy94MUxlck5SRWU0SzZ0VkFXckswNUlMemIxeFE5eVFQcGF4L0JTRmcy?=
 =?utf-8?B?Q3FzZzVqQWNwNzNjUXhqRExTaDMxc2NUSE12T0RnZXgrOE4rRUJTYkM4TEZx?=
 =?utf-8?B?a0d4WEQwVk1RbndWYmNTN0RaSmZCaDMxYUE4Y2tubVlYd2wzRnBDcWRSWWxa?=
 =?utf-8?B?Rnh2eDhjbG8vTmhiY3VIRlRuL2RDZkpBbE9TeTFQdGdlUVJCZnlOdnBYQ0JB?=
 =?utf-8?B?VUVxUzRWUjJ4bnRXRTQzdUtXMDlNQWdGWmJLOExVNmJNZVY1dkdjN2ZJbW1z?=
 =?utf-8?B?aThxMlFxNUxiYmtqWURrd2RINmZqa0ZsUkZyQjltWkozTkkwTUdmWWxtQmcw?=
 =?utf-8?Q?V6wWh0MXVz/QqZ361GzpL+RyT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cf4042-de0a-4a60-7204-08dd32d3a1f1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2025 06:37:49.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JgzNYCoHgBEy395Z6PMB2zRnI99OU9hEicn9g5nSS4srUomTZ1OVTKwYWhW2SIcF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9131

On 09/01/2025 18:52, Kees Cook wrote:
> On Thu, Jan 09, 2025 at 11:00:24AM +0200, Gal Pressman wrote:
>> On 08/01/2025 1:28, Kees Cook wrote:
>>>> This resolves the following warning:
>>>>  memcpy: detected field-spanning write (size 8) of single field "_Generic(info, const struct ip_tunnel_info * : ((const void *)((info) + 1)), struct ip_tunnel_info * : ((void *)((info) + 1)) )" at include/net/ip_tunnels.h:662 (size 0)
>>>
>>> Then you can drop this macro and just use: info->options
>>>
>>> Looks like you'd need to do it for all the types in struct metadata_dst, but at least you could stop hiding it from the compiler. :)
>>
>> Can you please explain the "do it for all the types in struct
>> metadata_dst" part?
>> AFAICT, struct ip_tunnel_info is the only one that's extendable, I don't
>> think others need to be modified.
> 
> Ah, sorry. If that's the case, then just ip_tunnel_info is fine. (Is all
> of the metadata_dst trailing byte allocation logic just for
> ip_tunnel_info?)

Yes, thanks again!

