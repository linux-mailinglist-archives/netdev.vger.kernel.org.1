Return-Path: <netdev+bounces-252444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NIVJIdWcmkpiwAAu9opvQ
	(envelope-from <netdev+bounces-252444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:55:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 337BD6A709
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25AF7301FBCB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90B35B644;
	Thu, 22 Jan 2026 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JHUkkAC8"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689935B137
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099299; cv=fail; b=N4Y4tfSK55R569lIAnfo0G9/BaCRW3eOdfmd4HAEkFze+I4cFeD3kqu0lzTJ6obxxLCOEh04BI15ooAj1YMd9YZNcnTfWWfAkmuqg8E1NM28DIFUf9+Xb+v0JoX+qVd5F6XnH7KoS/BSXenNgATyxUhCIbplfJYhnvIJDeLjOBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099299; c=relaxed/simple;
	bh=+h0hA/Wy772Zd30w6Cmqq1SrRDnog8qMJX3J7khe7Yo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJIiJI0BGYlWOnki70NqMjQu3wkXqaikSDW6707A0aA5eM35IbwJmCGNMX0Xi54Lp6F3PoyiQy8Vl50QJOeIqmoKorIXD/oP9jSkSX12SyvONr7avhpg1N3bDQvBZHLGSJAzVB1cO5ooppEMPZPZzK0CD4ZqsRgVogxvoMHrKs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JHUkkAC8; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ml3YZkfYXzh2JO5XJvsepvvUEN/KIExcE7rBwTnCk7+rkA1rph1EiVvXMXFO6/Kr8yg5QEMuempyWpZklkg5owuMzAy1vXBhpKI1XoFy7rTcDX48s22J3v0g7nXcm5Ouu9Hg4LWni9+B/BdHW8JnsS8DTmT8HFmgZ7tEZohCEnrqRcp0skRcAr/cgtcxL8YdJV0qnYG9ySawM/USI6hf1STMuwjVLT1JYlHDvhUotLfQVrKE+exgQCaVTnzRaO8M+IsBiaCnSXwxJWPYiJXEr0dN6PEtZ0CZTdmOGi8bEcRStZzmp4UdzStXOp9/bIq5u1t+08wVTY/rNj0XKTM/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csx7X8SR2G+FDTcPa24hvedIxBQm4FfST7rQIYGnRkU=;
 b=sQ5wJAT5PTT4zuEr92m1dtu7Ue01eTtcqh7XVEr63LFyFnfq+DktlhsD0bBUOC41hmstvLSu9EgtsRLRCHvORY3KwOWL2eZxSTZGTz7fkeuO8gpR1bk+YWC5c851nB99ZtyjQBRPkM5rCOXkISzA3ewYnBIOzc+T/j8uLS0REWCcl6W8dPiwBbOHJaAdme4D/vUWr31CZC7aY1vq8VoDoeeuDAFREup9Sraqry2dj0zlweXr4qC56zquAUI5e1LCfv2/Qy9MPeB1Nup0+5ET/h05UJUxPMcR/lJjnV1LN+cs/M1nsIjsjPgMNqMqssa2isGY4eNfI7XOKhdgflPaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csx7X8SR2G+FDTcPa24hvedIxBQm4FfST7rQIYGnRkU=;
 b=JHUkkAC89IjkpESQg19m5C4zwW+/J/sBbV3Mb/geBek7cIWIiExyGa7IA9QgBN0mtAuTvxYcVgYG92+umG+WxHqo30/zOxz55O4tc4uCHK/MtPd9Yem59Mo2FTHOeWmUGhSlPesWgY7uCOqJrI4agrj8PMrW9mizt4EQIR02GzduHFxNrscF3hHnM/DuMVxZuC8fezcWyz+c54dSBHjR0jWjlRA4GRdeNgD2/Nb6lPlM1uRMWJf99oEwrwrVyVkhcOoXicnnFF0ZopveBaIpfriUgl4NY8sGSVJHBdApPFB0sOyuqCtnp3z2iXGk40Ynzi3MQDql84HzGczJMSlfgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Thu, 22 Jan 2026 16:28:06 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.20.9542.008; Thu, 22 Jan 2026
 16:28:06 +0000
Message-ID: <42c80a14-3d58-4e5b-b776-ffc31d70082d@nvidia.com>
Date: Thu, 22 Jan 2026 17:28:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/6] net: use netdev_queue_config() for mp
 restart
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, sdf@fomichev.me, almasrymina@google.com,
 asml.silence@gmail.com, dw@davidwei.uk, daniel@iogearbox.net
References: <20260122005113.2476634-1-kuba@kernel.org>
 <20260122005113.2476634-5-kuba@kernel.org>
 <bb985b09-fe29-4fc9-9c06-310ff3abfad1@nvidia.com>
 <20260122074602.3c41e8c1@kernel.org>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <20260122074602.3c41e8c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ba5f30-a659-4e1c-38af-08de59d33916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzdjUDF1NStCWUN3VFcrMkVUU3Nmcm5QS0V5QjdMVndLaTlJUWlyOGZTOEdV?=
 =?utf-8?B?TVhIRlBqZmt6VGtFbGFNK2piREs1T2dEVFpWYzlmZG1Lem1uV0VYWHVOczcr?=
 =?utf-8?B?cG9XZTM2MzV0aTc0c2xiZFVkdE9XTzdqMS9MQ1hBYVRCdTFaOUFDYnVxa0Zm?=
 =?utf-8?B?SkRYUTFBRzNHVFRZbkR0MjZDNnhDRHlIbUpmTVRXTkxwYTdkbWFnazg4VU1I?=
 =?utf-8?B?NURYY1RLTTZLQVpLRzNta0FnVHJqa3FmZlVvandVZkZINXYzdlg5elJwdUkr?=
 =?utf-8?B?YjhRWXhnWlJZdUcyL0RPNnQ4TjNaTmRXN1dua1BweVJ5ZUtrU3RXS2RIcXdM?=
 =?utf-8?B?OGJieXlDVUdqL1NUQTN5WXFjU3J4ajFWdnBNc3dPTjYvYjdCVGptc2d1Q1Ex?=
 =?utf-8?B?d1FPWnNkRnZnK3BQZWtveE1qUkM5QTlnay82REY4eG9INFJlNjl2K3FNR0Rr?=
 =?utf-8?B?UEg4Y2JqS0x6Rk5wNkpncmYweUcyc1FSQUVkd1k5VkJCd0M5dDhsR1EzenVH?=
 =?utf-8?B?bU5PTW9lZHA1Z2lXZS96WDdiaHBFRmtxVkdtMkNNZEhrZHpFMEwycDNIS001?=
 =?utf-8?B?bGNsUWdGaGlVSnkrRGwxYXNkMmRLU0RON3E5VitjWUhGVjF3MDU5ak50dWdv?=
 =?utf-8?B?VGM3OUxMYTBNNk43U01Nb3hBSXJpOFJqWUdXQngvVkkzR2NGVkdaNDVTaFpD?=
 =?utf-8?B?d0M1Q0E1QnNkN0taWjNIdkNiZUlJUnlHMlFzODJhTzFvUi9KUjhvTHhlaWpp?=
 =?utf-8?B?RDJGejdiUTNocUIyMUIwREgyMGFYN05wN2NYV3RLTFRCTGpCUW15cVNLQW96?=
 =?utf-8?B?MHdqaWRwYjNFVWh2eWlRMWYwTU1xSFFJY3V1dGZrK1k4YzE3Um13YzNaRGlU?=
 =?utf-8?B?TDk5eG1oV3BNZnR0SkFmVDBDNHlWNS9Ield1V1h1V2xrNlZBK3B5cFhDa0ZF?=
 =?utf-8?B?VUFNMnZMaFlhVmoxK1JySiswVVRBTldNRzQ4YW82YVFNUitCbTltczd3N2ZO?=
 =?utf-8?B?YldYdEptVzIwZDZ0VEJZU3hNZXZUZWhKeGNtUGlqSFpIcDdWWUw3aVpUNGgv?=
 =?utf-8?B?b0IwTzNRamtFVS9YZ0tHRGsvaUlXS1ZwRE9Ncm5ydjhuRS96ZVlIREdBODZQ?=
 =?utf-8?B?cGxtVUUwUlp1RDBOQzFtVWYwUzNmNHR1anltQTc5bUJDenlSWHhvSXNHVXlx?=
 =?utf-8?B?RzJQU1NoUEp3SzB1S2E1NXhsR1FDcm9JbkFTdm9MME5EUHEwYUhuazcyZlpG?=
 =?utf-8?B?VkxUbVVWRDRFMThiYTVCaWtyK0pQckVuTUpGMGlSTlNjNmhWT0xuTU9SRjV0?=
 =?utf-8?B?d1V3SlkyaEJFSUNLamhHOW9oak5oNjM0OWEzZEJJMUN4RVpyc3pjdllrcjRG?=
 =?utf-8?B?V1VJWWFkZXJSeDdlOVoxUjZhMHM0ZGRUUERwTmp2Q0p0S20xVEgrSUNGdkxu?=
 =?utf-8?B?V2U4WG9FcjlwMHZvc2FUaTBRdjVqN2ZZVGZJZ1JSS2t1Vkk3NXJKU2NRVnRa?=
 =?utf-8?B?RFdWNlhPdWs3b3hxcUZTcmNLWjE3SjhlRTVUbTlwWElZeEh3ZTJrUTFRUlN2?=
 =?utf-8?B?ekhvKzYwM2VKbXVPWTFsUWswcEI2TzFoY1lXbGtCNnVSdjFtSEhwdFRGYmpj?=
 =?utf-8?B?UFk0UlEzbk12LzlRMmNBbDFWMmpqRitKMEw1M2w0Z3BXdDhvak9aZmZpNFhv?=
 =?utf-8?B?VW5nT1hrdS96VUY0SG5BdkpGTFdFL2hDTXpQRVNyaWdiRzhlQzcxdG4yVUgx?=
 =?utf-8?B?V0twR1J0RzJlYnQ5QVFXRUZ6QkVHVCsxR0JRZWZKK1NkMmFvVG9rbUVSTGNR?=
 =?utf-8?B?ZWNHcWpSVkJ6NWNHcGphNEVkdzZ5bTdtZ1AwS3dzUWhDd2tIUjJHMm5DSE1S?=
 =?utf-8?B?QXJCRE91cElWaUwvcWdmTUFHT2tOcldSUkZRNVpFdFJiK0tFNUQ4RER5RVN4?=
 =?utf-8?B?UzE3RUJ1SURFY2h6a0wvOFlnWUVxZUVnMlJmbUZPa0tSRHhualRVUmF0MHFQ?=
 =?utf-8?B?UjNYNVp1Mkp5MklJd29URFQ0cUpJWFA0akZnVjRnOWhRanJPbUhlSUcvZXBP?=
 =?utf-8?B?Tnp1bDk2QTZjeSthS3hsUmY4ZGRsVEJoSXZ0UnFrTjVFRXhaZkJncVQwa3l2?=
 =?utf-8?Q?POKo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RnS2t3U3ZvSEp0UkR2MEdzVEFtZGRiNmRicGRnTjl5SXBVYUNqYVdKTm1v?=
 =?utf-8?B?ZnZQMVB0NGt3VmlKT1JvaGRmaTdYcGJpMmgrUWpRbG1wL2g0cGJzYkpaZ08w?=
 =?utf-8?B?Vk9xbmlEUFdEMHdzT1c0cHlxWXRqRVVyMlQwNFQ0U1VDOWtxcW9iM0llVnVM?=
 =?utf-8?B?RE5oK2orQXZoV281eTNHbDg1UUFCSHU3QVhObDc0THpWMW5OVXlPT3o4Vkoz?=
 =?utf-8?B?TFJ5Rjcrd3hKeXNqdFVHVVZnUGplZkNuZ2djMkxtTDlRaHR4WjVWZ1hEenpD?=
 =?utf-8?B?TmFzMVR3enFqRVhXSGhCWHM1OUdUYWdVSXFUR0pGWnVpTW1HeVBaM1YwT2Vs?=
 =?utf-8?B?VDZrSVhpTlZZMlZkTk0vN1BNTEFTZ3hJeStYTko1NjlDNXpUQm9FaEUzY0hr?=
 =?utf-8?B?U01iMzZvSUZyZlhSS2V1UDlNalAvakJ5b3dSWDBPUHc3K293eDVIdS9ZYjRS?=
 =?utf-8?B?R2kwRWtXa3pNUGhxSFY2Wk5HS1czMXdiWk54dkpEVmFVS29SMEhQL1YzN2tX?=
 =?utf-8?B?MFYvUDVxQjlwSjA2elVEcDRJZ3p5QU5Da01waXpqK0grLzVvT3NRQ29oL0dw?=
 =?utf-8?B?QmhEM29WK2RzOEJYaHhiZFpsR1BDQmFxY3h5Z2tmS0d1RXpPdHB0S2o1cUZE?=
 =?utf-8?B?M0x3T29FYXJ2aEpxY21Rb1RhT01yUjF4VStjZFJ0Z3d4c2hYbGNoSG84VXkz?=
 =?utf-8?B?T0M3eHZoSmFkOE9wT1o2UW1zUGlKdkRGZFhNZ1VHMlhqeEtvWTMzM2Mwa0tD?=
 =?utf-8?B?RXl1V3k2NG0xcTh6akRzUGhGMjdCWVp3eHZqSVNUSXgzeTI0S3ZhekwxSE9n?=
 =?utf-8?B?OXpxRzA1ZVBqTEZtQjRDLzErWitoSUt3Yjl5VStRaUJoYTgxR0VWclFMdnd6?=
 =?utf-8?B?b0dsVGVmWE5SR0dhM0FWL1J4dlUzckRQS2NqNkZuRDNSdThnS1krazA2akEw?=
 =?utf-8?B?QmM1Q2hXcHAzOXNZUWNuck1YVm5GMXlITXF6YnVDQXZVeEdZYWhYUUc4TWV3?=
 =?utf-8?B?MEJNSmxSRHBucDVESGIxRW9icWFYQ2VCRFo4dTA2UDMyenBBZW44N1JZMkgr?=
 =?utf-8?B?WkN4M1E5RkxxR1o2QjNaMFBsc2FpejFvTkY2MFY5WVlNYlBycnFtMnBpWk00?=
 =?utf-8?B?RHh5LzdlZ0I5M2JQWGhING1FcjU2dTlNV3dOT0MvK2FiY0kyOFpvSkdJOGdw?=
 =?utf-8?B?OVE2UjE4VUI3QzFRVXowT1MyWFUzU2FaRUpCeldCdVJ1bEpvZCtvRlJjSzRR?=
 =?utf-8?B?bVVLS2JjRTd6a1VpRDNlbDRhZlM3WXZwbTZGdmxIeTN3ZTV3U2ZUSDRNM09V?=
 =?utf-8?B?MElaaVhoZXlmakovbStCYTFjak5iUzJwOFhtc0ttVmVOeU5TQXdYenRlZDAy?=
 =?utf-8?B?VjRVSlFRU1dqYU00K21PSXJtemU0WDdSWkQxT0lpaUpPRjhyKzhzRVhEMHdB?=
 =?utf-8?B?SlY3ZkgrUUIxL2tYMjJVYSsyQjlhZmQxWlFvWUg5aHVQeTdwUU5POHNva1hY?=
 =?utf-8?B?eFFZeE9Wa2ZQbEFxZENnOW1tYy8zYVpFcHA1NHU2T29OSGoxTFhKaEJtZ1E3?=
 =?utf-8?B?enpZbU1JZVpHMFpPa1BWZmtWVWlDbmwwbTU0aHRCQ3gxcGhyRllyYUhmZ0sx?=
 =?utf-8?B?Slo4VzRvRmJkTGJLN2F4YncyWGRReE9lU0c3SkVuZVZocFBIcGltNzdIaDF6?=
 =?utf-8?B?bEhXWDFKUG4wR3ZtcXd4bjM5Yi9Ra3Ixc2QxNXFSREVYL0FKOHlJdUpaR05u?=
 =?utf-8?B?VXB1V2VxVjFQeVZqZldkT0pNR1FPOXRkSngzUyt2TVlPZTN5YlJuak1QZnNq?=
 =?utf-8?B?VzNmNXBUSG1mbUFkalg1NlNOMnRaejYwMEE1SFk5cUJIdVFDUXh3Ti9aS056?=
 =?utf-8?B?TzRCS2VWa21oZ0ZvRjcwOW9xMmZCQjBGMFhZUWZFUDBYTDJZbzdqTUdkazR4?=
 =?utf-8?B?OGM1eU9nUWNibjJrRW5iYUtxR2VvZVN0eSt0K1Iya1lnekdzY0hmY0YrQndJ?=
 =?utf-8?B?a01yRVB4L1crUG9xajZhWTlxeXVleTl3ZGFTWEhkWEtKV1V6OERDNjBhQk9n?=
 =?utf-8?B?QWVXK2RRaTMyenpFZk9kaURwdHU3OUozNDBOVklmdGZWZURJcU0wTE9iQnRw?=
 =?utf-8?B?WjJiM2hyaVpQeS9GWkJaVmVjcmFDUWUxSllSSGVDT1pkc2thNjVLa3YyTEp0?=
 =?utf-8?B?anIxRzNrWmg0WnNYbFdzM255REZkY2NPVFZmMHpJSUh5d0xOMmVVWjJjdE1y?=
 =?utf-8?B?alVWUlA0UXJZSkhVa0FMK090RHFzYTRuR3Qwdy9JQldPaUUrVmxyQVZsWW9o?=
 =?utf-8?B?V1l3aHRyWU5BQWFlbU94STRjNExmbFQ2cXl6QytxekZFRGlUSnI0dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ba5f30-a659-4e1c-38af-08de59d33916
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 16:28:06.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxF2ZyRIQWToAZpyN69aMPqi+lusvMGgbYjKPDHdesT8JdzvDZcSICaxKn1wi05NkD2WKOfGrU9yAgozoh0vew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252444-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,broadcom.com,fomichev.me,gmail.com,davidwei.uk,iogearbox.net];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dtatulea@nvidia.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 337BD6A709
X-Rspamd-Action: no action



On 22.01.26 16:46, Jakub Kicinski wrote:
> On Thu, 22 Jan 2026 16:06:40 +0100 Dragos Tatulea wrote:
>>> @@ -195,8 +199,11 @@ void __net_mp_close_rxq(struct net_device *dev, unsigned int ifq_idx,
>>>  			 rxq->mp_params.mp_priv != old_p->mp_priv))
>>>  		return;
>>>  
>>> +	netdev_queue_config(dev, ifq_idx, &qcfg[0]);
>>>  	memset(&rxq->mp_params, 0, sizeof(rxq->mp_params));
>>> -	err = netdev_rx_queue_restart(dev, ifq_idx);
>>> +	netdev_queue_config(dev, ifq_idx, &qcfg[1]);
>>> +  
>> Is it ok to assume that on close we always resume to the default?
>> For now yes but maybe in the future we might want to save qcfg to the
>> state before mp_open.
> 
> When we add the ability to configure the params via Netlink we should
> insert another chunk into [__]netdev_queue_config().
> netdev_queue_config() should evaluate the config in reverse order of
> priority, so:
>  - get defaults
>  - get device-level config
>  - get per-queue config
>  - get MP overrides
> 
> On close we are clearing the MP overrides, since we don't have
> per-queue config we revert to defaults (as you say). But once there's
> some overlap with device or per-queue configs we'll go back to the next
> level of config in order of priority.
> 
> Did I understand the question right?
>
Yes, that was my point. The order that you mentioned was my concern as
well.

> FWIW I think something that'd be a major usability win would be to make
> MP presence imply per-queue HDS threshold of 0 automatically. So that'd
> probably be first on my list of knobs to extend the "priority" model to.
> 
You mean to set it to 0 during MP queue lifetime and then revert to
previous value according to the above priority list. Right?

>> With the very first rx-buf-len series it was possible to set a
>> rx-buf-len via YNL for a normal queue, switch to a MP queue and then
>> on MP queue close the configuration got switched to the default value
>> of rx-buf-len instead of what the user had configured. This was
>> not convenient.
> 
> Yes, not sure IIUC, but the fact that clearing the MP didn't
> automatically delete the MP-related setting was the main reason
> we ditched the full qcfg for this use case.
Ack.

Other than that, I reviewed the series and don't have any other
comment. So FWIW:

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>

Thanks,
Dragos

