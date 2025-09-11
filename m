Return-Path: <netdev+bounces-222114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EFB53293
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C10648044B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0BD321F33;
	Thu, 11 Sep 2025 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="BFG2ewkU"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013036.outbound.protection.outlook.com [40.107.201.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55F727EFE1;
	Thu, 11 Sep 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594552; cv=fail; b=NhgrzQ/+j0gkgGB4VY530ulkJszFKr/H2oqHWu3lJjDagdS32xOMKRwC14+iGZDJ4eZT6339i+0Zx6yjqzp7Ch4xIpfbxuCMVScCbPzlaNI2GX9GzPDst1tiUToe9JxV6HsudjVSEW/lF9dOHbxfjq7YowquK5dW/TsfE1QgACE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594552; c=relaxed/simple;
	bh=026lu37zB9KWyDcbVY3LPcY+QRCm1tnPID9DM4JY/6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I/fSyYqA/dUDmbxuAx6UHkxc9WMOekZsEdyzicQIFCBVQZpbhK3X8CfaFHg8etSxA1e8yTzax6GuagBHZ7qBB8n5PsOEbpAwL65jNzZUw/yGA0lMH8zyIqtDA3G8kKi5NPA+oArMOMhhdazhwOjDAgVA9klrDJSr5oQIIA1C08k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=BFG2ewkU; arc=fail smtp.client-ip=40.107.201.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxVE2dWV5O1XbgiDIuLEmuZ7IigtvKdaUp9KA8soPobBsA3usPu2/DYWKESGIXAeBRmGNGcjbU8NMuDp29rA3Iv5UtxwkTCiTKAY/4IOjBeK/ppBotQCGv4UUXwXyAI5UT5yvaDzZM48nadQfLgbMK8TUPB+ga/p/emNhcIzQUfzMijOOY6slmVx7wO3UfiFACjpfwXK1KCveMgdDpuAST+x1PSB5FJa8QjCGhNAAC4XBjyrPZr+isoZvg+Ebr3xbbcZHG9JmMPYshbPpekhLEBDge+F6OHkr++cbd1CmEXW6A5r3UwhiBQcJSE6Pgax65nUcUOcJsRsKt9zjdb5YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6TRPCuVrrDK6/0PlR0drNjSBgNYBEI/ZiE0oFMzZz8=;
 b=UAITQX/ohqRiKrm3GuPO7vAPZZvlcCx3MC02Q7wYcpjhlCkOqnPtu9T5ttOzV8DdjQHerBwTwjITSeXupHN18moCM0H2iXuNIMMiRAM9aW2GUwxxlVixtxdjxheXYH+cGd3ISK6Xaj+5TiPji4QVudLObGuMpBNzaN++c0YYcRK6P+fdK3hR3oEi8/plVd/RjP6Xpec4CqyQQ2VSthFe6NXd1dvCWaMclmHEB2imx1XOE+SMezWxaFgfvYZJRiibqAVQgtmVkdvbWIv8Pt50Y9aBQvAVHuav2J7qQZj3/MSjCuyFP+5L0S5UKcExwhrBXkCCwYOCq1O+L7aJogCFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6TRPCuVrrDK6/0PlR0drNjSBgNYBEI/ZiE0oFMzZz8=;
 b=BFG2ewkUd6JrYk/Efbu8lfKJkd5AFArZm17/jA2jwM8bsf9/DZpY3uufdNNKD1G5Bwik3HJWQHPWy052EEsUWtzyh8+6q3wstKg7kUuCkrYGs0e+Fjqj8+7GWdq71OMYud5jgIFJJBQWFf5Z+4FHbeN08ep1ptGnHnxje6V5SDjQUybx0RSDroO18cEAALa5KZtZp/fQuJW4bgeasCPkzFpGwl3v1GFIEVJmDRf4E0Fym8BzOxzRtqbZcg7f43Cty3LZnrfvJJ7WOM+Eh/CS2e+ryb5lLcnnqcZH6756qdskc79Z1xyH2u11E8ntndNSycgQH9Uu02DfWqZekqkBVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5371.namprd03.prod.outlook.com (2603:10b6:5:24c::21)
 by BN9PR03MB6092.namprd03.prod.outlook.com (2603:10b6:408:11d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Thu, 11 Sep
 2025 12:42:28 +0000
Received: from DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076]) by DM6PR03MB5371.namprd03.prod.outlook.com
 ([fe80::8d3c:c90d:40c:7076%3]) with mapi id 15.20.9094.017; Thu, 11 Sep 2025
 12:42:28 +0000
Message-ID: <2d00df77-870d-426c-a823-3a9f53d9eb30@altera.com>
Date: Thu, 11 Sep 2025 18:12:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: stmmac: est: Fix GCL bounds checks
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>,
 Rohan G Thomas <rohan.g.thomas@intel.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Matthew Gerlach <matthew.gerlach@altera.com>
References: <20250911-qbv-fixes-v1-0-e81e9597cf1f@altera.com>
 <20250911-qbv-fixes-v1-1-e81e9597cf1f@altera.com>
 <aMKxc6AuEiWplhcV@shell.armlinux.org.uk>
Content-Language: en-US
From: "G Thomas, Rohan" <rohan.g.thomas@altera.com>
In-Reply-To: <aMKxc6AuEiWplhcV@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::11) To DM6PR03MB5371.namprd03.prod.outlook.com
 (2603:10b6:5:24c::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5371:EE_|BN9PR03MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: 70513048-8a36-4bf9-3a53-08ddf130aa67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjI5UTJIam5sVlphalJxNEhWejkzWnh1SEZzdkFpcUxxYkJPSmFvdWhWdysz?=
 =?utf-8?B?eDdKQ3paWnA1RzI4Ky80RkFBUVVncExqNlZFMTJRU1Bac1ZMQjFEbkIzVGNj?=
 =?utf-8?B?aGpLZEJjS3ZxdS9US1JSZTcyTE84amMrMHdkYWFGa090SXN1SkdZMVh4TThw?=
 =?utf-8?B?MEM5YUZ6OElHMFppUGsxVis4bGpEN0xhOVlYQXhkM2dRdVJFVmpXMjUrQjhQ?=
 =?utf-8?B?eXdpK1RWbkx2MmJmWEY3dXA0K000TVRTZDZJaDNwL3lTOWhxSHVRSkJvMjAy?=
 =?utf-8?B?ZTVRQkdnOFpNT2VtY2V4RjZhOTVYWDRsb1h4TXNNS2phQlNXY011TzJsajZU?=
 =?utf-8?B?VERsN0huWmhkR0dLbHljZERPTnhmUmM3R2FlK25MSUN3MDAwN2U5b3NoNzJu?=
 =?utf-8?B?VlhvTXJHem5PNEhYTExXaGlUajhUL1VsNEFUWVlpeS9kT0sxZWhIc2xkclh4?=
 =?utf-8?B?YUg1VXBwcUU1WVFLQ24wYTZIVlcrREE4S2s2MUpNdE52cUxjMVE3K3lhRWZ2?=
 =?utf-8?B?Y2FJZzQrMHJ3VkUwSDBJYjJYSWpPaC8xcjBBU2V1SkZybWppVGRUZlpoQ0pj?=
 =?utf-8?B?dmx6ZllYM0ZlblVoSTY1NXZWbUtSa01HZWFPY1E4WE9wN3pkUUpXZzhaZGkv?=
 =?utf-8?B?ajdacDlSbDZGMENGempGRzRKMGxJenlVTlBHSW90TDJQWElEL3VHaVFIZzhK?=
 =?utf-8?B?eUVpbVh4WFQwZXoxNTZGK1BMLzV5Qys0UGIwT3lnNHNyVzY1RlBwR01DdVQx?=
 =?utf-8?B?Mkx1WEVHNmp6aGVMR1dJd1VlK1JKVUpOUDJZSFJaTTJER0FvZ1JXWnppSUt0?=
 =?utf-8?B?M05lUHdad25Ma25ZTkFFMENGaCtmMG1YaHVCWGVKM0R2WWNtZkxnTGI1OFlr?=
 =?utf-8?B?V0NHd3pFV2dXRHVNV3lXTjREdW0xTzVzdW9sWFd2aitPOFU0VDVkdnpZYmcz?=
 =?utf-8?B?ejdCaGo0V0ZhSEVvU1RIYW4rdUtxczBWc2ZJMDgyOElMbVRGVDNBTnNsZWdI?=
 =?utf-8?B?Ym5YRU9TNU91dDhGdzlBbFNpckh4WGRYUlFyaDhubFY4Qm1jNXJvcHJaT0RK?=
 =?utf-8?B?SnpvdmFWQjM3K085cENyWTQxQnBSTUNOdGRWRm1kL2VvdmV4L2pqRFVBdy9M?=
 =?utf-8?B?WWRJQ3YxSWdxNkdHK1UrZFFidGhvZXBvVVVEMm1tQkp5NFFiS2dNa2FDVE5i?=
 =?utf-8?B?MXlidEM1dnp2QTRhTmoxbzFOdERhNzVjalVwWVBkSUo5T2RIbk04NFZTRGFF?=
 =?utf-8?B?QXR3dkR1cmVOaXZZRlRJb0o0UHpLUENWNk5kczdsYmNET0llWmdSaDllSnZl?=
 =?utf-8?B?QjdFZ3N0dU5SZ0RLaHMyVFpjZGJFN3AzZElRaDFFOGJtTmVHK2g5V0JMakF2?=
 =?utf-8?B?WjE3YlJkSUptUHFRR1g0UVNIMHJHemgrYlhBd253cFhGTjVvTW9kRjNQOTdD?=
 =?utf-8?B?VGM2Sk5uMWlOVDBIVnZDVEFaOVh1ZzlaUWpTV0tadEg5Z2R2QTBUMURaTkJU?=
 =?utf-8?B?R2tnbFhQN1duc0J0NFVJdGRIajg2VnQ1TjVwdDkyRDc4NXZWVmZVN0FtWkN6?=
 =?utf-8?B?bk4vaWQxeEhSaEx2VVk2cVlLVzZ0SHJQekJJSFB1clNJS0FodzBKdUlrR1pZ?=
 =?utf-8?B?QmZ1N1NJSGVwb09XUVpZRVZKZ2gwQVdJdSszUHhtNHhzNmRjRmZPU2JEQlov?=
 =?utf-8?B?eHFRRFpBOTUvN0hzcy9IczdBYlVudlFMWEszaklJdjVFd3hVYU9UZ1BQUm5y?=
 =?utf-8?B?b3JpQ2lwZFZoTHkveG5oREZEZkdyR04vSk03Rm4rSTJFb1RWMkcvckJpVnla?=
 =?utf-8?B?TlltakFtUzU0dFJadnZ0dERwaXYwTU5Mdk5ISktCYVZrNU43aUo0ejFieGt4?=
 =?utf-8?B?RkpMQkkxaGZpNDBZVU0zNUtLeW5leU10VlIxNlJtb0RPbW9kRk5jVlFPTnRm?=
 =?utf-8?Q?BIwmPuKQruU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5371.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWs2SlBSU3Z2SnJIK2Jla3JXeE5NaXh3TldzM1UyYVpFUHpYSU1QbnNmSko1?=
 =?utf-8?B?d3hreGs2Uzd1a3M2VzdxWHJTVStvZHRhTmlrOHh5S0psYnVUaTVCSVljUlp1?=
 =?utf-8?B?cHRlMDVDYSs5eHFQc0NlZ2RKNW1XL0Y4T2l5bG54SG5xR2NUdGdieFUvOHVV?=
 =?utf-8?B?TW9DcmdhcmJvOFVZcUtjeGFlcjY1bEpKSlpUNWR1VDJUY2NYTFVIeUE5Z3FH?=
 =?utf-8?B?aXJaUXNZQUdOeXpGTC9kVFdwNGNmci9JdUhpOFdyMkg5amM5NDIxY2N3Vkdq?=
 =?utf-8?B?OWZtVzlnQXRTVFBJTElOalFsY0JGTFZSb0RZa2YrRm40WVM2NTMzZWxENHdJ?=
 =?utf-8?B?QUlzYjV6V2NXNXpjZUlWek5vN3RRN09GWlNYZ2dWUllkdHBhT1ZubThVbEI2?=
 =?utf-8?B?bDJ5RnpsYTZjQzZKVnlUSHp0OUNTMmc5aHdCM2pUWjdYUWM5WUVoby9GdE4y?=
 =?utf-8?B?d3gzWnZRTzRnYjhKb0g1TjdwRHJ6MitkQlExTWlkbzZtNExyOEtpRUdZcncz?=
 =?utf-8?B?TU9ISkR5VUhhaDRJZXJQZ0NJN2kyaFNRMzBYZVIyVkUrYnFzTmVqTXZrRlZj?=
 =?utf-8?B?VVhObk8ySDBodlNQNFFNSktOSnNNS3BoVDZkSUtxMC9Va2U0UU0yQTZhZE5s?=
 =?utf-8?B?c1duWFVQRU4zd256TFZVbHgrV2NKdzN3VGxsRnptVHNPYXhiQ1B4K1Zid3Jx?=
 =?utf-8?B?MnNWYUpDTnUyT0s4MmJRb0lsUm1VR0dBQ21CQ2JQNllYVERaM0QvRjVObUVt?=
 =?utf-8?B?Vjh3OHVldkZDUFhacHIxMTFEZ3dJbktSOGRid1VYZVZPaERZcUxPNVNPZUNs?=
 =?utf-8?B?V0JzQTFKM2NRaUpYVzFDNUluYmlzWWUwNDFVamE4d3BtZXBQR09odlBIckZ3?=
 =?utf-8?B?bUNRNC8yZ0NVUktKTG5EekxzOVBVK0tITnlPSTV2bmNmZDB4dWxTSnZRTkZI?=
 =?utf-8?B?alptZURyZ2k3d0syUmFvVElsOVB5ZWNiSS8vTkJXY0hTT0gxUmZ4NmlRdS9S?=
 =?utf-8?B?ZU81cWgwcFVVQks3dU5NSy93Sm9NRG9tNFplUm1GU0tyNFFsZG5YRzNTYUVm?=
 =?utf-8?B?T1MxdWlMajdkRkJlelVYeDcya050ZWR0YVUwa3ZkYXVDOVhsRDFSYTN2N0M1?=
 =?utf-8?B?Q2VMbzNEK0c5TU5XWHhhbFltaXEvOTN3cElxYnlSSzZFNWJCUllWMU1qWWhD?=
 =?utf-8?B?L2NSTHJqSVh3Tmc0N09KVVB6WnhUMVF0ZjVQOXJpSURiOGdwZ1hLUjgwWEF1?=
 =?utf-8?B?anU5VHpZaTB1NVh4M0haWlRIR20rRkNpZjNnWHNLdGd0cjlkTWp6dXdOK2Zs?=
 =?utf-8?B?TS9JWHlkT2FLMUNCVjFhcTYwaGU3R1J5V0FxOEU2UWdKWTRzNU1YU3hIVU16?=
 =?utf-8?B?Zi9wc3hSOWpkTHpiaW1ENGpLNkhEbTZEakk3ZjJibFE3bWtBYUNxOE92c2RL?=
 =?utf-8?B?NFkxTVpvRGpCOERFN1Bac25RYTZqSnR0T2xLRnNxamxzTEljMXBXaEpZQjZj?=
 =?utf-8?B?YWdoeTNnRmxZaVlOY3JXNGhKdGlJRnV0QWhHN2RpUjJZM1psNVp1SndMaXgx?=
 =?utf-8?B?VkRkWGp6V09CUWxSc3p1WnE2S3NIQ05oenk4WmxRd090VG5uTGFuM3dGREJt?=
 =?utf-8?B?R1Q2UGtUUy81T0ltVmM2Z0dKMktGVEQzV21SK2ZWWktpVHJOblhlWGxZZ3Q3?=
 =?utf-8?B?REpEL0xlcEIvNFhaa1Bzb3UvMS9sQU9QS2ZHLzJ5enI0Z29DUW1SbW1NWjdr?=
 =?utf-8?B?S3htOHNwclpXZWNldWNjeVBzamVrTDBqbjhXc3ZPTjlRRkYyVnN1OVhlZjE3?=
 =?utf-8?B?K0xhenVsc1Rqc0lGZnphbk5ETGdxT0FQZ1lJTzVMUFVjcjhKcTN4V3kxcXdK?=
 =?utf-8?B?WHV6Q294dTRtbnZkdjdzODRuWU9YRjdFeiswblZCblJvOVZnTjdON283Ynlp?=
 =?utf-8?B?MU5Zb3h6QVVTbzREV3VJQU9od0NTZ1AxcnkvMFJBb0t6RHBicWpLckpEazlN?=
 =?utf-8?B?TEZud1hER1hqeXBNZDIxaXFrV3VMZGFjTTJ5N3M0RXNGY3BFQVRqekRuT25v?=
 =?utf-8?B?a01hZW42aS9JdXRQaUlQM2Nsb0M4c05MZHZGZUJ4TDV3VC8xWFBJVGV2WmVP?=
 =?utf-8?B?em5JZHNhSHA4NDMrM3p0aDk3Z25pbldCMmJRaFZ6TTMyaDhxM1I5Ri9HL0px?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70513048-8a36-4bf9-3a53-08ddf130aa67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5371.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 12:42:28.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbyZmRnN3w8rg/nz6J8xhOCJP6WKeiIbF97CVJIQZ/D55meOU8zJvoNU98A0nA9ME7hSCILtfxBnrTttq2Nk8kOUsSFvDRAHPcEobMbvia0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6092

Hi Russell,

Thanks for reviewing the patch.

On 9/11/2025 4:54 PM, Russell King (Oracle) wrote:
> On Thu, Sep 11, 2025 at 04:22:59PM +0800, Rohan G Thomas via B4 Relay wrote:
>> @@ -1012,7 +1012,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
>>   		s64 delta_ns = qopt->entries[i].interval;
>>   		u32 gates = qopt->entries[i].gate_mask;
>>   
>> -		if (delta_ns > GENMASK(wid, 0))
>> +		if (delta_ns >= BIT(wid))
> 
> While I agree this makes it look better, you don't change the version
> below, which makes the code inconsistent. I also don't see anything
> wrong with the original comparison.

Just to clarify the intent behind this change:
For example, if wid = 3, then GENMASK(3, 0) = 0b1111 = 15. But the
maximum supported gate interval in this case is actually 7, since only 3
bits are available to represent the value. So in the patch, the
condition delta_ns >= BIT(wid) effectively checks if delta_ns is 8 or
more, which correctly returns an error for values that exceed the 3-bit
limit.

> Best Regards,
Rohan


