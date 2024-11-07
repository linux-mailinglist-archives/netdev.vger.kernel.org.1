Return-Path: <netdev+bounces-143023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5181C9C0EFD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D597A1F23486
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB44217F27;
	Thu,  7 Nov 2024 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Y6yLzfL"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74BF21791F;
	Thu,  7 Nov 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007919; cv=fail; b=gXEAnQcJWyxXKP/RQX3lHiWUhi5qAZqmbCXyFSTPzZCE1m5AMQo5XoJtYOoN6a5m9hrF92tFOfa6J9m42D8x+ERPDqZbdkarTo0Gt4nlXkzHuCr4pIGyI9IEPT+UQMRAHKvxZiUKyGpNSIF+g3VIJHMfbgtHnKh3TWgvFJVH9nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007919; c=relaxed/simple;
	bh=hGAbkLdDLt3ROkDX5mpkU8ZRAmpkDqPsWBx1ls1K290=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M1LvvB50NvbKtzXrZ9PoeCb95VosdWYyxSy6MMIgeBMf8/ubjUcifJ5J0RgoQPbffXTgjGACy5EdRPKhnSyi1ktakKeCMG0rPyXEWxRmz1MV/8eGqQO1I93heWKP04fUj/MQhBKHI9ECfCT+3AUs/kGwAlbzZ3jb4eFsRrEMl5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Y6yLzfL; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4ccwMpH6AQik6tEC4IndvzaGMj5Ybb43xrv9VDHk5S1A/lf0Esg4FNybgQ4AO5m2B5Y9Ml0qzeKjUrpTNwa9Z+zePtEq5LDusa9+bhUnLKOQqDDWRaeS4i7eZn5EN3i4EP8SD8gYPbduVCkfnc6mBvSwZXFEFYoqcN1YEw/iHE4y6LVOeNWcpfa0DSBQG30wJY08q93ri1BYkXijqK+jnZHTOEOqApwmuZdK18Rf/4A7O85T9bLtsPDTHNkUaTKyrzMXqtdo1l6fhk1AePOPdrUyAlFvpMktQxZg2+4ix4EgZM05BYMAYFFwS1MtjXrrLiTn6pP2TQquLjuCNW6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bT6cVQr5ynrr2krvwXsw9JPWzwF+JsT2D1vKVtVre8=;
 b=I7AMyZZhNxA/lGdLuxIx+wOeqDYY1ekpBiwbQQJ3yC16DBjxOGvS/A4RDeOvNSBcTtUQ3D3lmI9gzZcPqV2zNbSJMw+gmws+EDtv0JpJUi4MIakWJzBJQy0FyGNJQwJFXNEkKiX20EvSva6mNfyV987Gf4VmGHfgfAn2+TF9TMGWVb/2/zHPR72DHRj0NuQAbQm2IE6xk4yPTz/N0JuomJW+7noVkxOk+YotKcSDUv9xILpzYwd75POFF3HIDMuODhKgCoCVKy7KaIv9Mmpa/YNKDEAC+Bc1h3Bo7fzBR9qc4JbFAyCG5zx0OPpHg2UZpREOvDCsvD/gwRERB9u3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bT6cVQr5ynrr2krvwXsw9JPWzwF+JsT2D1vKVtVre8=;
 b=5Y6yLzfLRiBB/T36ZpumiBnGbb3mv26ZBfBSo2tDlIDKMcvR03TwDYQpm4RSNKfbY109+8NsefW7cQR3/zd5f511zHFKq8Z33SWeV4WQJMpgrhpo1/MhUvrSG07F4agtn/bBQx7hwHeRsPWb1neGBeUfvB6HBWZPGURfEZqijpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:31:52 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%4]) with mapi id 15.20.8114.028; Thu, 7 Nov 2024
 19:31:52 +0000
Message-ID: <79f0ce60-58a5-4757-88eb-1cdc8a80388b@amd.com>
Date: Thu, 7 Nov 2024 11:31:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] drivers: net: ionic: add missed debugfs cleanup to
 ionic_probe() error path
To: Wentao Liang <liangwentao@iscas.ac.cn>, brett.creeley@amd.com,
 davem@davemloft.net, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Wentao Liang <Wentao_liang_g@163.com>
References: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20241107021756.1677-1-liangwentao@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b3ff84-4325-48d7-dff4-08dcff62d4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0hkc2kxTEZDUWw1dCtpak4xZVd4V2t3TUZRbzUrLzh4dnFYTWFMclZTV1Fo?=
 =?utf-8?B?Y0FFTHlQeGxGZWxzaXRDUVBPRFdlREhEb0lOb3Vad1RrdzlJdWlrVkYyZXM3?=
 =?utf-8?B?Wm40VDJTKzFNWE9nY2VLNWk3anNVTXZwb0NuVURCSUlibVJxQmZiZzI5RXEr?=
 =?utf-8?B?dmNaRWEwNGRNZktMMUNtRVZoNm1kNTc0TEFjNVNnZUlqZHN1Y24vejZETUZF?=
 =?utf-8?B?aVo5QlRHRXp5aW5ZU2xId2dtY2kwN2pNWFhBK1dVOFFlME1SQUZtMWhOa3pq?=
 =?utf-8?B?aDcvL2VYYURzUEJ3Y3ZDaVhaYU43aE1sejBTU3R4V2N0SExUSjZJOGpSNk9i?=
 =?utf-8?B?a0owUkpaY0VJWHE0VDRjN2tDMGNya0VwWGZMUXdLT2ZHYWh6NkxTSEtJZUlt?=
 =?utf-8?B?VktzajBmbzdYVXd6NWZOS2llZGJVb1k5dE9waHRyM2VuZFFnMkMvZERnNHlW?=
 =?utf-8?B?Wk4zb1pFdnBLUHFqcDdpd0ZLMGRZTWJESzVnaFRnTTdCZkl4VCtCaTNkMlcx?=
 =?utf-8?B?Q2RlQmZxdzN2MUNiMEhTYzRvMmpLSHlwNW1SSlRYLzlPdlhMMlBmTVpCWVBC?=
 =?utf-8?B?eDBtR2hSVHFPTzE1SE5TVkJ3WWxJRmhuYmJETm50emJKa3hjalNvSWQ5OWlt?=
 =?utf-8?B?bHdoQTBJVFZzaitxZnhVNlJ5Sk4xNXBFS2lpTHBLeG1xdm53ayszYzdYRldB?=
 =?utf-8?B?bFZPQVNubDFINEpYdmIwY1M4VUJqRUl5WVZJcm40bFlFSmhsNURSS1JKWHBV?=
 =?utf-8?B?blUwTEQzaGpKTVAxSkV6M2ZPU1pjeVdJOEs1YnM4dFFMWVlLd2xPU2IvZFdV?=
 =?utf-8?B?OXhPbVJEWFJpMFRiSDNIMDE5OWRzYk9NWjdtK0tLT3lDam53VVlwRUZsb1Z3?=
 =?utf-8?B?RG10TTJYZU5VQ3poMTJ1N3N1YWgxcU5SRU1IdDh2L2tKY1BmODlQL2ZyVDRJ?=
 =?utf-8?B?eklnRVFsc2VXVWNGaDYvWGd4RVViQVBzVWJPZXNVY1U5cy81YnMzekxFTytn?=
 =?utf-8?B?eUQzaEJzTDBidWxmSlN2MXE4RkM1Q1BsL0VFTXI5R2hqV285emV1YkVycThF?=
 =?utf-8?B?cTB4RkxIaFZsTGZ5THRuV0I5bkhlb1BDeGZ4clpnNVdtQmppbHhOSGJLRUhw?=
 =?utf-8?B?S1pxMTVIK1Bza0l6WDJRd2ZERzVLOXB2dU1pdHJrVjByREVTdWo4TVE1MnQy?=
 =?utf-8?B?dmhZMytFTS9ZM3l6NTFHNUVRbmNNZTJUaTc0U3V6RXVMRVJFTmJmcWJ2RUVz?=
 =?utf-8?B?bWhrenNhZDJ1UzB2bFpkN0Q5WjVWZVJlTnliOTFiNE5kYVVNMjYzb1pwaGVR?=
 =?utf-8?B?ZEFoeTNsUUVZTjhLV3ZyT3hhcnNaRzM5QUpObWRlbGd5d2JlQUVmNGZ4Nys1?=
 =?utf-8?B?ZXU2cmJoN0xEdnAxM09BcDVrNlVnellxd1hURERhWW5xb2praXMyY01zM0VP?=
 =?utf-8?B?UjJJWXErQWZSVDVhYWRTMWQzMll0QmJBcTYxN3N5RE9teFdxQnQ1SXBsS0py?=
 =?utf-8?B?bnhrQzA0cjRxNGNJc3JqTDFjblhJdy9IM1dIRytua01BS0ZnNVRBRkpRUGhR?=
 =?utf-8?B?VFFHRjQzYXRVRmI3VVZHOGJUVFpWcXc3RWszWEduYWtZcWg5V0o0T3krSDla?=
 =?utf-8?B?aEIvTUUwMmNHZnlvb1FLS1pIRUZ3eXVURHBOaG5VaEg3YVp3QWlhYlF4aS9G?=
 =?utf-8?B?R3E4QngyT2hqM1ZFTHdmK2gxSndKWkpOOXd0OUROMDF6NW85RHQza1NRL2ps?=
 =?utf-8?Q?YFJJj/mPnBfrGmPhVA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZGRRanhpQkJ0QVg1Y0RtRTN1Tk50QTZ4NXV0SUhzLzlBczlGVjExak1xZDlT?=
 =?utf-8?B?VXY2RnloS1BER1NmY2FzZ28welVNTkN6bGYyRDFHbTlPc0pQMmRrQ2dQbTI2?=
 =?utf-8?B?bGtlS09HVU53am55cTc1YitpWGN2YXdYcWlKbVRKVnFuR1FIdXRMcjVJNXMx?=
 =?utf-8?B?WjA4OXZiV1Nyc2RIT3JJdlZUUlduR3RVaWhIMm9GRGZVcXBsb1ZjZHZDS2N2?=
 =?utf-8?B?ck1KMWwrWWhwTUpoZi8xVzFDWHhYdzBRYlNHOTVTa3laZy9oWlJRSEVjeHda?=
 =?utf-8?B?MHhERE9PRGVnU2RxL0hKWGtOV0w1Q3RyNHZqbklrVU0zVGEyejhWNlVPSUNm?=
 =?utf-8?B?Ky9URjAwRE5hb1ptS1pnWDBOZy9xKzB2SGxxeEIrSzJvZSt6OU9QT3NTem9l?=
 =?utf-8?B?alRsbURVMGVCMW8vWElnaVZjQ05tODNlVjVtTnRqelhFTUxiSi9pRTFleC9Y?=
 =?utf-8?B?YzB0ZFBVWFZra3F2YVp0YXE3NFZJWUJhMXZKbzJsWldEMXk2T0d0L3NFcEQr?=
 =?utf-8?B?NUwzK1FMcTZhY01BY2hobnFGNE9xTEVSeCs3cUNmcTZEN3JBalRsWmpWVlBw?=
 =?utf-8?B?VXppUkFidTl1RUs4dDI4dVNTZU1pMnZVaVQ5WHY1OG53OFlZVEVjSXBlTy9X?=
 =?utf-8?B?b2VoN3FQN2ZyOVRZL055ZHNhQTd1Q3ZuZnV1K2cvV2NvaWw0aW5sZ0ZVekFO?=
 =?utf-8?B?YzdTQ3VycU1icm11ZFQyWW0zcWp0cVFQaUlRdEl2bXBjQ2QrajJ4bURYdXhx?=
 =?utf-8?B?RnNyWHUzemhsNkM3bkNpREZpR1JLU3lEVnFnUnZmRjhSeUhNTUtnNkZZMTNv?=
 =?utf-8?B?ODJwZHBGNWc3YUlCdU1nUkNWOENBQ3VHVkNmaVZjNW1FWkpSR0dWTThhK09V?=
 =?utf-8?B?ZG91V2UrMU1CR3pneGp6dWQvYlp0WXNWa2FNelp3aUZjYm1Rb3lVUUNpVUNp?=
 =?utf-8?B?YldPRy9KUFBta1M1MCtJQ3JaMzRoV09RcWlRZURmYzlBZ0tkUUd2ODR3c3JJ?=
 =?utf-8?B?aVRWWXk5cTc5bWx3RDV6SUViVjR2K3AzOUoxSWp6Ty9oZjRWYUJScHNDRTRp?=
 =?utf-8?B?U3lhMlYraTNUWGF0TUd5bFByZ3FiUEUzdm5YQnV0dEZpbU8wVjI0QWFQNEli?=
 =?utf-8?B?L0xuaU42ZFQ2eUtaVTh5d3FJOWhZZmtaM0lDZ2ZXRHJWNnIzNVpRMXUxdkts?=
 =?utf-8?B?NXNja1dPdWpBUmZZbXpDVzAyaXY0L2hMRG9UUElBbVhyNC9pZ1NtT1RPbHl5?=
 =?utf-8?B?OTRrNXdZOVZWaWU4dzBDVmg5aFVFNlFkR2xybVhzL3BlK2VXQnFYalBFVGJZ?=
 =?utf-8?B?eC8wcVhzTFl5NllnLzV3YndMTEl3d0doaHdUWSszODdTa3dKSE00amtWengw?=
 =?utf-8?B?bWlwMmpvTlFQVHE5ZUVXY2ZoTHdkK21pUGtaME0wczZHallKN2t0akFMMmow?=
 =?utf-8?B?RVVRMEJjc09TdUxWS2ZHUVBITEVIcWtSUXdEU2ZMU0t3YzNiNFd0c2lhanRu?=
 =?utf-8?B?NkowV2YyaGNkc1ovQk9vS3FBaGpPZW1jK1RycmJZejNHUFFWVzllcTZjN1ha?=
 =?utf-8?B?R3NPMjRrY2ZLdDZaMDJmbC93RTU3bDlDdmoyN3NWN1VzYTY5NlA0ZDEzbTlp?=
 =?utf-8?B?ekJRVWk3aXFLVUpXSmlOUWhlR3VDaTAwWGo5cTJYNUY1UzBGOUF4ajg2OVlB?=
 =?utf-8?B?N0VQRU42SEJMb3pIZnhSbDd5aEhMaXVYdmo1c2h2TFZqYjdMckpWUitscE9C?=
 =?utf-8?B?RDJRK0hySGJhSUZ6QXBlMzdIUFFYa1NjRGJ4b3B2OFYwTG1FOEJDb29CQzlC?=
 =?utf-8?B?Q2ZyZ3J6ZWpLVUwxK0s4MkNzeFJrTEtIajNpeEhvczNxa2g2QWhIMjZPcTUx?=
 =?utf-8?B?L1BDZzZ5UTNJMDdML0htTEVvaktIQjMvdklqTy85VUtYK0E2NFZRNFZReDY5?=
 =?utf-8?B?cUpqeVlIVGdoQnZPNE1PNFhFZUxqQXBUakF0R0ZmeXBhOW9ITW1kZHhSYjRi?=
 =?utf-8?B?NERMcDV2dVgzRVNDVGtyQWE2MXBtNFhqc09ZVzVVTHVnSTNhUnRQZG0ydUZS?=
 =?utf-8?B?d0xSdDZIV2NZYTQ5dmZKTlZEZFdmT1E4VDRtd0x6c1ZXM1ozN2UyNy9wbXFa?=
 =?utf-8?Q?VA2zJGWKwKmKkd0QU0/8Gaf10?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b3ff84-4325-48d7-dff4-08dcff62d4c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:31:52.3166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atndOPx56xqZ/zLvzIldZzv5tu548qfqooiq5dJO8NStGvpQUcO/KAHabJwYeAX56ehqEE1AKw4EUP8KULLZvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732

On 11/6/2024 6:17 PM, Wentao Liang wrote:
> 
> From: Wentao Liang <Wentao_liang_g@163.com>
> 
> The ionic_setup_one() creates a debugfs entry for ionic upon
> successful execution. However, the ionic_probe() does not
> release the dentry before returning, resulting in a memory
> leak.
> 
> To fix this bug, we add the ionic_debugfs_del_dev() to release
> the resources in a timely manner before returning.
> 
> Fixes: 0de38d9f1dba ("ionic: extract common bits from ionic_probe")
> Signed-off-by: Wentao Liang <Wentao_liang_g@163.com>

Thanks!  -sln

Acked-by: Shannon Nelson <shannon.nelson@amd.com>



> ---
>   drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index b93791d6b593..f5dc876eb500 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -394,6 +394,7 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   err_out_pci:
>          ionic_dev_teardown(ionic);
>          ionic_clear_pci(ionic);
> +       ionic_debugfs_del_dev(ionic);
>   err_out:
>          mutex_destroy(&ionic->dev_cmd_lock);
>          ionic_devlink_free(ionic);
> --
> 2.42.0.windows.2
> 

