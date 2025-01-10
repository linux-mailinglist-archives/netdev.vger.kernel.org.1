Return-Path: <netdev+bounces-157263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB1A09C1D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5B2169039
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67304214A91;
	Fri, 10 Jan 2025 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bUyCzNek"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D4213E62;
	Fri, 10 Jan 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736539088; cv=fail; b=Ks4gT9rKCoGnQAznaV7yZqNGDAHRDS0eD0ZJ0Fmkq/hm4Whel+hRCyqNmAAsuesTQxHEVqisd/MV1gfEAjGKZ4APvQqz5qGyB23Um85l6Ct3/bFTlrMPuKNIDFfjmm9QTIur8SkYO7Ash3346acwZ+D7vptkMs9vi6vjpnRyqqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736539088; c=relaxed/simple;
	bh=1FIlYne9OkhvQAVfhqLS8oYLJgDOkQy618D42u5oSnc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEOlZRI05laDLKi3XI/kIUYcoaPna20aSW8xbZBNfApzVHmgOcLiR1S9AUF54qwIkIIjCx8sZr2/LtbD+HepNO2W2X0zvzF+Qydf07j+o3sUY5aoBsIu7oa6e1h2KHxEsSC4mcP8+ZnqbGNgAfaQ2UCG1IXqkHEyoLebvWmaY78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bUyCzNek; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iXHz1VGYC0fm+oNbzMg4jPuBMXsHs5LBN5yoycCNBucwW848PyKuHAufqOzQ/e63gCXKncOiLsWTS3NuzW4ilzmo1SVVKLVsaPhzfaVsxoNpI8csCj+DmaYzVm8hQ60gMkF8KY1XIhCdH/EsLOIb2MpUsx4F97QZZjoNx3TQ2XrtlahkqIMozkApkFW5oYIBXuLYZOw29eaoJeGlE68K+arrWDlPcc5XB85RFTQYu8d1ouit4YHg/LZU8kqm1uANkAzivtEz+CAR35+w8NXclpSP+23qHDdbrr2LCFa033f7CPUI5Sm7hTP9NRU3YjGkSiRZU4OioXStYCxDBhRneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiuaoMNCaGCXO1852EdU8Z/srMADMVLQoUQLpTkfDdo=;
 b=RzhFrw1XIw1Lpyc7sZDxZrbbfGbHHVUbWRWFWUUqxnb/0ia6C+R+CJamhBPPQPMskT7ePx5gD4hhq87l56YYLa41r9rUxV7ZKcIitMDfvHXxm8LnZOT/FZusaFpktS9YKtG4ORFNyYo9ev0eNBfWMLSmodLJ6BvZa3zvgzbtAyE5V2V5bRhxnsd7kKhk1BA6tcOSxiEpKB4N8FSByFAaGURgvGgLG7Fyd1cn9PLwfcogqQRla87bWVpJ+p13QE4KGI4pgs6SK/uw1vn3KpHwUjoLIbi6iM61dW+lHwOe4hkaC02GXez+BHXtrObdkekzid+TfIZh1uQMFPDdjJ9WiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiuaoMNCaGCXO1852EdU8Z/srMADMVLQoUQLpTkfDdo=;
 b=bUyCzNek5sj49jqrs23bsECGLzJH8SZLzfSG2ZRB+VEvcFcJ0PoitRgnEyxzzZtGBcIwF5pUamWeUFlSbmZSiH4LHavmrHuj7d+9JpROnBTwAyZrdPmEtSx7HS0RiR+b1VhSJXKFJiRy5RRHG4XP+xytwUUdHYDGhLOMijgOhOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 19:58:04 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8335.010; Fri, 10 Jan 2025
 19:58:04 +0000
Message-ID: <1e6a7cb4-6d56-4350-a4f1-0167a7f377af@amd.com>
Date: Fri, 10 Jan 2025 11:58:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
To: Sean Anderson <sean.anderson@linux.dev>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
 Daniel Borkmann <daniel@iogearbox.net>, Simon Horman <horms@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org
References: <20250110190726.2057790-1-sean.anderson@linux.dev>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250110190726.2057790-1-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 0740ced0-da39-444e-bf7b-08dd31b1181c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3gyc2J0ZkNvNjd6T0RLRkp1MTRCT2JtOTY5bTJzZHhSQmhBU3ZjWEdqV1RN?=
 =?utf-8?B?UWJqTHpTdEZJcTBPSHAzUEJIbnNBUUw5cGpaYzZJTmdKNDhrQ3dDY0Rob0J4?=
 =?utf-8?B?N3Q0UTNLSkErRVBXaHRiQkVaTWFCSnRaMnZUdUUzNVdjK1M0ejY1SGtWbWZ0?=
 =?utf-8?B?N3MwZ0lGUzF5UndWSHltZVV0enRyU0dFdE1kWWJER0c3NysxOHlJY082MW1k?=
 =?utf-8?B?RTV4bTlmY2hBb1FLQ0dtSVd2aHA1YjZPK05FVVBjMWdDdmM1eUxHc2FNU2tV?=
 =?utf-8?B?SFN5SENDYU1oYld5MUZJTU1wZUxTSXpKOVprREN1TVVLY1VRWWhXMG9sL1U5?=
 =?utf-8?B?TzZnUUJ2UytXd2dPbHc2WDVhcGt6SGQzT0o1a0E5TzkrNnhwMkVtMjlVOUl5?=
 =?utf-8?B?am9LQjZDTVlYdzQxUFdBV0xtMXdKaSsrZUhmYVFiOXVFN2U0TVJYUlpWbk1v?=
 =?utf-8?B?M2N5b3M3d2VscUVsMGJZdkpHNjhWZGN3WnFYWkVRVjROandhcE1ZK0ZOcVg0?=
 =?utf-8?B?YVBQNGVkQnlhR3U0WmpuZHJQVTI4MVYzQ3F4dnlIMFg1NG92YllVekpNQ0VX?=
 =?utf-8?B?c2IrMVFKdjFsZTQ3K09YcUQyTjBGSXVCYm9uOXNJZUVhK1lFdm9ObGxJRVl3?=
 =?utf-8?B?ZUJGbWZ6Y1NOTXZZNzltcWU5djQvQ2Q5UnhDdWZ5eEJ3QTNYY0VjOW5OWDVI?=
 =?utf-8?B?dS9rMWJDTC80RkNmZEJjN1M0WXZrZExWQXBjZmdhTSs1VWpLMTEveHpKR1Ba?=
 =?utf-8?B?SUQxNjJTSFB6akVwT3J1TzZpK3pPM2pBSXJPYnFOR2tLY3ExWDB0V095YkhI?=
 =?utf-8?B?T1RjVVE4VzUxRXVzd21xblB4WkRxVmwwNEhtVmZ1M0dFbUQwaE8xMmw2OHhm?=
 =?utf-8?B?ZXdxWGZDUW9qYnJncnhyMFZ6N0RGc043OTkzMzVPS0p1UVhaNGVHQVZ6Zm41?=
 =?utf-8?B?U1VmZmJKYS9ZZWFTZmo1amNMRkh5WE1zQjZKelJtd3lvZkxHOHhUQ1IzMTZz?=
 =?utf-8?B?b0YyM0xFZjdjdE81TTkydm1HMGNubGpjOEdvazgveVpXSlgrV2QrN0hXbU5i?=
 =?utf-8?B?ZW9BWDQyRUJteGpmVVFSdm5KVnR6bE1Jdk1xY3I5SDVJRnBGREtNL3B6WlMr?=
 =?utf-8?B?TnFSK2JqTDRKVTg1ZWt1bVhwbTlGdUs2V3pwbXZmLzZQWHdjZE0zYTJhd00v?=
 =?utf-8?B?cHJjZWx6YWtJcVA4Y3FnNksyTXRyb3BwL080MjFVdEt0VlFuM0FCSHZIa2pG?=
 =?utf-8?B?eTdBVmJPS1Qzc2RuZjAzckZuNEhDekN5STJJTE41TENGeit6ckhDSi9xUk1u?=
 =?utf-8?B?bnRxdldzK2NVQmVWcElPK2RheXZSVlJNVXJ5cDJuQUdjUHVkd3NYNkwzdHJk?=
 =?utf-8?B?WXRqNzQyN0szNVlTeDcyM2Y5aVpsYjRUQklEWlhDdjRxdm9NL0Y4TmprOExL?=
 =?utf-8?B?YytHY0JYb05kTmNsVy9GZWNKaThUMFRGY3JZZlpKQmN4VTRjSUowU21sdzFX?=
 =?utf-8?B?Nzc2eC9yTUVuN2dJYkI5NzdYQy9xNU15MWcxTlhyUmhhRjBuVTJ2dUlqV2Mw?=
 =?utf-8?B?aEF4OFNtS2VJSVNnQlZIWFpOMFdwWXRmYVpjdkp4ei9INWs3dTNacDBxbXpV?=
 =?utf-8?B?bzEyNGxGMTcrcWpFTHB0KzlOdTUrSW5KWU16U1FUZmNXalZkUG1ic3NyTk1I?=
 =?utf-8?B?UEZYMlRpWWdmZHpoOStLZ1hFU09YU1MwSzJvY3U2dU11YVpIWXVBNUx4UVZ6?=
 =?utf-8?B?MWRFcFVpVDJIOEc3Nll4VXlDS0plaHg5OW5CajRsVEsyd0U2Yk1CaGpsRHow?=
 =?utf-8?B?VWtVa2hkaGNRUFZ1L1RqdmNQTGd1N1pISUYzNXhzTnlKUUd2T3F6Mm5xQXBj?=
 =?utf-8?Q?78fnw5SPwIW/t?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHJMSUxESWx3UDNaZWNaYUsycTVtVlVNT3YxRXJzY3FpTk5YZjlnUGFrL3hm?=
 =?utf-8?B?Tml1a3JWbFlweDFnOVZBZVg5elVZb084Q0xKTXpsQ3J3Njk5OFZrb2U2SHVN?=
 =?utf-8?B?VjdlS3pDTkZVTitMb2JCQUFHMEJhMlJkMEMydzVBcHdMNjhCcmFjUU1VQ0xw?=
 =?utf-8?B?OU9EdE12eWIvQ3ZxMHlxZi9Mbng4Znp3RVUzMmlTQzlZdm5HaXVQaXpZVGlX?=
 =?utf-8?B?cFkxNlNaZnZ1OVF6N0FYL0ZDbkZPaWp3S2RtMmNHYXNIdEhnaHdlcTJhUU1N?=
 =?utf-8?B?Y0pRM3EzTjdLdDFrTFpWUjZKOTNLamNnZHF5SW5waHNJcEwzZ201NVMyZXB2?=
 =?utf-8?B?U3kzdmVHQzJTWXNJRnhSV1M1N2lJZUVlcjUwUnhPK2hjRVE0a2ZIMUhlRm4z?=
 =?utf-8?B?OU5BbTVSVmMrNVlNMmpyRDk3bnN3aHFKNUFCR05iRURqNHl5Z1ZmTzBZNjk2?=
 =?utf-8?B?SG1TK2QxdUJnSlZ1Z0JaZzlhUDAreWR3VUJIMHdrZUhvU05JczRWVlFaYWtI?=
 =?utf-8?B?VmtCRDIwbk9teEg5eWU4T0VoZU9DN3VSSE1VMGNoZU1RV1p1Q1RXeWNKOTlV?=
 =?utf-8?B?UGh1SEE5REJRa2RzNlhJUDVCR2VEWDdUd1cwc3AxZG5Zd2ZUVXdqMldpelU4?=
 =?utf-8?B?aFl6NjVETGRnYlk5MmxMY0xWSUVVb1l2L0g4VFNXQWgzZDg5VXV1bW9ubnRw?=
 =?utf-8?B?dHJwVnFmQkN0dWtrRlh0dnRWV25uaHNyZGMzMzNOUnFkeCs2ZEJCVUF5SXYx?=
 =?utf-8?B?ajNZOVFRcG84RVdlcDVUd3BaeUw1bHB2R0NKOTNuZmxYbzFQa2wwajlLM3dD?=
 =?utf-8?B?TFliK2xVNDArR3RESStLTVVZUGVCVkY4NlNndzROaHl4eTNsc3A4eG1SV1l1?=
 =?utf-8?B?M1BrTWRISkcxSmRqRC80NnAvQTV6R3ZKUmpwVzBVZVBvYzg1ZzRXOENzQk1Z?=
 =?utf-8?B?RWdiUTRZOVcwbHliZE82SDN1MGk0Nml4bWJpR2RKdU1WaFg2ckJmOVZFYUl0?=
 =?utf-8?B?ZDRiZGwzaEtUcGJaWUF2TmJ0UjhRM3hhR1ZVbE9Kb1FDeXptT2MwVE92blB1?=
 =?utf-8?B?bHBYWFNUMEZGTFFLVnYwVXhhMTNaMmQycXRid210dG9uK1l5c3A2V1QrK1Z4?=
 =?utf-8?B?K3hYNGlDRi92YVBCMmQyd2xpeHRnditoOHdaL2lzVWIrWXdnR09BYlRreGdR?=
 =?utf-8?B?SWF4eFpIek5WZmxDUzZFcWg2Q0lOVUI3YmVmeGtQRDFITU8yb0NTSGs2V3Rx?=
 =?utf-8?B?ZDJDTW1OTytpd1ZQVllhZEFxSmFtdlFvb3J4b3NJN3h5VEdFZklUMEtnRHVS?=
 =?utf-8?B?OVZZeWhCUTFkZGlFNnBqVmVtL1ZZRjdMN1RsenJNRG4yaHgyVThsQ3NOQVZZ?=
 =?utf-8?B?dXRQL25rM0J3UGQzNTNzOGFENnUxL0pTdGYxdTFIM2ZRYUMvR0hLTnNNYTh2?=
 =?utf-8?B?NUJKc2xPVnZmL0ZwMW1Henplb2xRZGNMOC9wUFZKbm5QNHlVaWhUZDJyVE5L?=
 =?utf-8?B?Z0pDdFFkbTNuQTh4U2dUL05QSUJvZDZTODZIZDlvMm81T2VlbVdqQWxEdVdP?=
 =?utf-8?B?bVBKN0hFalQ2QVVKMmVsTTFWVFhmVlVaNjhXT2JJaHB0WGxKU0JYeWhrYk1n?=
 =?utf-8?B?LzYwcS9lVVRydzNVK0FlU0hoR2lsUiszekp3YVA5eXRZZ1IzdXUyZk9VU2FZ?=
 =?utf-8?B?K0NENGYvYTFMQ0JMTThpa2lWeXMzeUdrSFVTVEVJSFJNVjZFd1NuV3JGQ2ZH?=
 =?utf-8?B?N1pnOFFMRnBnZUI2dU5SeDIwUHRTbVdJSHVGaytxY3BNQTZEdGhrbjhOWTBY?=
 =?utf-8?B?cGozclVDMTlEdHhEK2JWbVQzWTgxejlib1k4L01jUFNjSXBIM1hMRU9YZW5q?=
 =?utf-8?B?MlFGT1lnRWpmbDQxZXl5UGNmNnZzV2NKUTA1dE8zSFJQeS9rQzM3V28vcjB2?=
 =?utf-8?B?dExra3FROEQ5RUpEL1o1MHdIZEM5WlV3TkNjSlFTNk1GRFFUdmtrODVIZVVS?=
 =?utf-8?B?OVlHR3YrUU8xK3JEQXhHbzNiZ1FPeFFvMVhkSy93MDNseGRZbWVsQUQrZVBO?=
 =?utf-8?B?S000WThENkxwNmN4ZmxGTW9qL1lwMEV0d0FWeU84K3RZL1BvRnFEaGNtUEFW?=
 =?utf-8?Q?gzktDWtF5a37yIh4Q+ugFUAiE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0740ced0-da39-444e-bf7b-08dd31b1181c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 19:58:04.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjydrV6mc8ap5fVwJVt5ISttbAszXUKNj4VBHlbElSHgj1TJ6Hy+7GPwFzjaQiJaX0pITdqEWY3ObOZfo8Tc1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

On 1/10/2025 11:07 AM, Sean Anderson wrote:
> 
> If coalece_count is greater than 255 it will not fit in the register and

s/coalece_count/coalesce_count/

Otherwise looks fine.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>


> will overflow. This can be reproduced by running
> 
>      # ethtool -C ethX rx-frames 256
> 
> which will result in a timeout of 0us instead. Fix this by checking for
> invalid values and reporting an error.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
> ---
> 
> Changes in v4:
> - Fix checking rx twice instead of rx and tx
> 
> Changes in v3:
> - Validate and reject instead of silently clamping
> 
> Changes in v2:
> - Use FIELD_MAX to extract the max value from the mask
> - Expand the commit message with an example on how to reproduce this
>    issue
> 
>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 0f4b02fe6f85..ae743991117c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2056,6 +2056,12 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
>                  return -EBUSY;
>          }
> 
> +       if (ecoalesce->rx_max_coalesced_frames > 255 ||
> +           ecoalesce->tx_max_coalesced_frames > 255) {
> +               NL_SET_ERR_MSG(extack, "frames must be less than 256");
> +               return -EINVAL;
> +       }
> +
>          if (ecoalesce->rx_max_coalesced_frames)
>                  lp->coalesce_count_rx = ecoalesce->rx_max_coalesced_frames;
>          if (ecoalesce->rx_coalesce_usecs)
> --
> 2.35.1.1320.gc452695387.dirty
> 
> 


