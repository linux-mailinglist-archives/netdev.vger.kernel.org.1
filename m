Return-Path: <netdev+bounces-186712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252DAA0760
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F80F162A6C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 09:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06F61FE478;
	Tue, 29 Apr 2025 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H8cC7HQN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4253EA63
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919203; cv=fail; b=lTXPL3zbM5gYQSHlWBq51hNq8Br4MWJgfq8QtMPjQUHuibNdCBD0dQmYitZwZn/lyMj2ziW/f3KMHi9swo7tv3Kbm3wtqj1zfr4ji7f4TKz132nURd2ABBG19WnoVpGkHeR0nxvvyELsyvrztQxUIElnGwkKCwSvIANSiZrm3v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919203; c=relaxed/simple;
	bh=qTI1YflaSYgyQbWf8SzWdwerBSAQsBj9cgdfb01FNfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VtO1S5YD791MW2FZOH9w1HupwVtgEE6ivDfM1ZvBy8Skpb6AyDPIlMFuFflB38aXCVHp5zkbhGi85OPTxFKJuxn9J+nSdxy+Px/KomIuVnnev5UvrekRfXBP0mD5Z7nOxEg7+qFHzw2olWx6KfX81X8o7tXyF1iW6Rn5gjKxVuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H8cC7HQN; arc=fail smtp.client-ip=40.107.212.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VO7rVT8txi52vFN/qev2cx6tdSd7qa2P9pTtDeubwFPDPJ2yDBbUoJiRqd+AKIGUeztDFj8dd22sRdq6Jm4c3drcUstn6YLC9lxo0Aj4VzZVYPo3voaGqDInZpkgLWwrTF/SSI8k++H5C/TCu/w3fA+aQakp18k69O6Jcuupm3hRGVLHXMNBQxFG1/sF/R/HsTyGhJYf3hqnbXqk5GdRLNNDgBolDcVf3jz7Q0cSize1e+JcBntWNIxJzbtkA3Nw81ZqaJh+yhKsBwq7wS8CKkAHyrWRDGGuuJ7uslp2Lz2P7FeIxJqIOy+2gS7I+sS8onSieMx59OLrVYCUjhbLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vISoWFqmVpmRR9WRn4nt/moZGDZTamQKaDSt4jb969E=;
 b=UiMmEJAkp3s6Ytoz1qBf8xcSf9c9DuSQMr/JZPbM+y32Y04mvK8BS0aET3ncJb296TEnE+x2cOEmYdXsuZq3j1z7dZ0q+qdsNTf/c0mqcz7KzK0xFuKsD0LNLdt2xX7v1/b39Hp3MfHxLRV038d0oWe9+TQpFxrVINPgJw38WkyE3mNI98qbJWwLcsOSDKkkjcUJyWR85xLlOQHE/6osp0AfO7HfSPufwrbpmEMCfz5ARowRxoNnmgNMojZbBrYewK85FIWRX4J+u6DTXD/mdoq/I27tyYdgwS0TqOfJPCC9pny/syXoA68KVwdfFDue6mPFdK719mrPoOap2hulvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vISoWFqmVpmRR9WRn4nt/moZGDZTamQKaDSt4jb969E=;
 b=H8cC7HQNREXl6uLxInRjvYpKjD0GSom6W9ed+yBTCkWJtwFSbibT+H3MqPBmD++19IUPHLmcBsA3oKyEhJVePeoN7gn0VnBmPdJNMFD3CaCCHEsyLfe0ovdDi7cbFIyA4KHv2oYdp+j1WuSfsO8imhKqUyroAdxR3BpojZSj5MzssE6RMWsjmrkOKRCLPKj2q9rVAma7FjRc4WWfLUO/v1I4mf11unQykk1gTuP8nLJfxdx1Sp0BY10hJhOMJ9Ecb9dacob6rHA660jOe9SDM/e/tPLW9TyZm2x0lEw7bU0z8PAfToJUjJ5Q9eOVa7f2SdXtAGuhk26Xpq3mSaOvfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 09:33:19 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 09:33:19 +0000
Message-ID: <787bbbdf-12ec-4a82-933e-448631c83d19@nvidia.com>
Date: Tue, 29 Apr 2025 12:33:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/5] devlink: Add unique identifier to devlink port
 function
To: Simon Horman <horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <1745416242-1162653-2-git-send-email-moshe@nvidia.com>
 <20250428123329.GA3339421@horms.kernel.org>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20250428123329.GA3339421@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0123.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::20) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 3123be20-3a3d-4b51-0349-08dd8700e034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmhIeFdjOFZORHRlNjRyVFFVWG11OU84MHpBVkdaY3YzSnRZRUZ5dGV0STBS?=
 =?utf-8?B?dlJlR0ZwOUhSN0dKY2JYcmkycXpMU3RGZTYwWTU5aUhPRXlnZ0tuQ1AzOUpN?=
 =?utf-8?B?enorNERQTjJjRDNGNXozZEpJU1hFUy81aVhQSjYwQWY3RjRIdjVPME9IRzVM?=
 =?utf-8?B?enhjUE9xd0ZHUlQzZ1hndUtBV3p4MThXRG52NEJ3ZDhGK2Vpd1dRZUxDb1NB?=
 =?utf-8?B?YlRFRGw2WEx0ZzUyRllibFYydk82NVZvMWIzekFhUHp3QTU3TlVkU1NYem1y?=
 =?utf-8?B?MzV1U3lIbmF1c0hEL09MZ1BRRWwzSDNVQ0dHR2JiZ001NVpsQTZ6a3F6WGRx?=
 =?utf-8?B?czNhakk3N0RlYWhIWFJ6cExzSmlZVXdwd1dtMVNIeThrTzRZTEJxWWlRNTFy?=
 =?utf-8?B?UHMzNWlFY1QydFowOEVFODBMU3JwSWYwTXBKellNK1VLZ2lXWVJCNzRkVGFO?=
 =?utf-8?B?M1pFZ1ZWNk94bENuVDkwclNLOFRsUnFCV0ZLeW1obWU0OGZ6a2w4TzFPSlNP?=
 =?utf-8?B?aVo1RW9ka3F5bGZYUTdINnZDRS9pUXI2dDFNNEhYaWk4NlRRc0xoOW02RlZY?=
 =?utf-8?B?bm9DRVZCNXp0L1dITklXYWdHWVNuMWxtT0lGV0Nwa1VUQmJidENKZDlHZW1W?=
 =?utf-8?B?QS9TdTBxL0hDSXpqSlpxakwyVExxaksvUkRoYWx5OHZEWXdDdFdzV29QN3o2?=
 =?utf-8?B?WE11NzErSHZPS244UVlEb0FVeDdEaXpSQXVKR2hGNHpheFQ4YzFqcU5ERDZ2?=
 =?utf-8?B?cHJuZGxybDQ1ZXkzMGRzSTJoNDRvZWRFUXQvZmpCY0htdHEzeFIzRjBTNlpI?=
 =?utf-8?B?MWxFR3hYTFU4dmNlLy91UlE4T0d1VWpyZnFRM0VtY3crNForWU1hYVB3Wlpl?=
 =?utf-8?B?N0FvM1F3TUx0UW1GL3F4aEpRUXltMFRLNUNwRlhwb2htRk5Cb1c0RVNoNFBP?=
 =?utf-8?B?Q1A5czFTVmpXNlRkemZOaS9jbWErS3FZemVKd1pwYjhMdlhJamxWMHkvMzli?=
 =?utf-8?B?dWhyd1B2NzJ0Y0ZzTERLaTZYaTNGUEZ0RlRBNzJxZVdtUXVYMTk0U0pLZXVJ?=
 =?utf-8?B?YjkrcVVUdFpHSUhxVStqQlhkSnBtclhSNHh1Y1AwNWhSejYwcU40bjg0VUp2?=
 =?utf-8?B?dXdLVERMc3NqSkhuTlh2TUNLdUVyZUJNMmZlbUdXdXJockRNNTIySEdBeFc2?=
 =?utf-8?B?SFhIZjYyNG5OR0dMZnQrYTZWYkRLcVRHNTRVZE1qdy9jL1o5UFFFNHBPV2h5?=
 =?utf-8?B?SWVHdE93Q2NUTytReHAwS2psVStqbFhiNjBUaitLTmtWOUZJaEtPYkdvbndS?=
 =?utf-8?B?dkp4WGhHcGl5NlJXOXQ1bHVSQ3ZodFhXK3RFM2k4NUtUWU1ZVFFJakFUMWhR?=
 =?utf-8?B?MkNZUitBK0Z6RGFPOUZHTlc4b09aMkpCbnh6ZkR1MWZrSFAxRHpDUnhySnNn?=
 =?utf-8?B?cjFzZ2Y1WVNnalNNWWtnQmNuSW1lbG11QTVvSjVvcUUxc3UrT2s3RzByQnhh?=
 =?utf-8?B?STVYVUYyMG12b2x5NVBGUUtwRGxzOTl4dCtSb3dMdEN5M0ZPWTdNbHdBVVFN?=
 =?utf-8?B?dGNXbDBuVkZVTU1qOGV4QkJEclhvVHUvS0dmTk9zUjBvekhhajExOHRkcWs4?=
 =?utf-8?B?Q0RVUE5VQnByNUx3ZjFTdG9wbjhZdklBRWJ3Q3dWT2ZiOXIwMCt1S2lNYU9z?=
 =?utf-8?B?RnNSV1N3TGllNkZjanVwaEFSSTM4Yzk3ZFRway9ObllVdHBqeUJQdS9kSHZJ?=
 =?utf-8?B?SjNvejNNN0pDN1l4WUVwR3NzN0V3NWFjVWZiNEE0UnlFNncrQ3BYV3RVaVRV?=
 =?utf-8?B?UTBxVlA4djc0aTVBcG9DSlF4alZNOXZ2dmdYT1A2c0xzRlV1aHJROG1jUzV2?=
 =?utf-8?B?bzEzSFo3Yko5Ykd6bzRPVWhKQlBmZUh3cEtCVklEN0dJT1BCbk5pdzZmQjVS?=
 =?utf-8?Q?G87+yA5iaAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5549.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czN5YURzNXdEcFNQY25rZ0RYK21STFJKdExwT3EvMkR2TGhXbGdWMXZscmVP?=
 =?utf-8?B?VnY2eDY1U1pkYUNpcVF0ZFBpazFCRldyS2NRVld0SHdFUEowdmdEM0pyMVk1?=
 =?utf-8?B?QnBISVNwZVNWcHV1SXh4UUlGY2dZNXp5Y04waHRmM1hBWUczbmxxWTRPV2FS?=
 =?utf-8?B?VkRhWCtWdjdNZDRRTzBYelNDMUpBUjNYdGIrNmJCVTJnWXd6T0N0Ty9DczNS?=
 =?utf-8?B?T3dTQkYrOXR1b1JRbE80bVZaRHlFSFQramlGb0NrS3ZXU0IwVlJmaXkrVXB4?=
 =?utf-8?B?enlQa1FUaTJmY3J4amx6YUVTdm5TZG1xbFRvV05SOGtmN08reWd3NUo0K3Qz?=
 =?utf-8?B?bVZrdkpxSEdpNUNudUswdmVhaU1uSm9zWHRmWWpPbTFNSGF0RkQ0MjJ2VWtv?=
 =?utf-8?B?aE9OVjM4VmxnS2NabWh5Rll5Y0xZV3MrV2JBc05TSmczS2FGRDh0c0tubDdv?=
 =?utf-8?B?bzc2OUtFbG1nSmxXWkJjV3BVMCtJNzhxK0YxOE9sR3BTY2ptbWdZQTl1cFpZ?=
 =?utf-8?B?UGlsUXRMQUkwKzNZYVhuZi80UEFEdGp6c1RCWFRsK1k3NlRKU1NWWTBaaW54?=
 =?utf-8?B?L29Gc3ZCQTYxdEdRNlh3dHpwQjA1d3V2Ui9IbzIzeWxPVHF6cUpiamQ3eTNt?=
 =?utf-8?B?bmt5TlQxN0pLWStzbzQ0SThycTNwemUwQzNZZE4zMlU5b2xVQ0dDeE1TTWpo?=
 =?utf-8?B?YmsrMVByY21IWnFwREcyUVJ6YmxUSHNPRzZuditEbDh2N28rTUcxR3BiK1Ry?=
 =?utf-8?B?YmZDYURieWU1THBjTzI2RG1aR2dXc0xpM3lGcDJBRG1JQTEvKy83ZEdzOEw5?=
 =?utf-8?B?RTFBVGNDUnhWM012Qi9oTDN4YjZDQTE5YWRLM3dMYjduQ2dYUXZ4Z3FURTlE?=
 =?utf-8?B?L21sZXhaVGxjalZNd1lyVjRPTnFmNm1PZExqY1BjYnZJemR3MzFFeDRtZ0pQ?=
 =?utf-8?B?WHlhdVdIczMzZVB2VlJocGVmWVBwQThCY0dyeEV0THV4d0k2bGg5VkFyOFBm?=
 =?utf-8?B?d2pEb0hnaURmelc1RUJiQk1TMmR2UG1GQXhGc1JjOUR0aFlCVzFmSnFPbHMz?=
 =?utf-8?B?SGlxR0Njc1JETDUvdVc3MGkrV2loU2FVVk4vMTFLNE1MRUJHN0wzcDN2TUlX?=
 =?utf-8?B?NER1dU5iZzU5c1hnVnhQUGFUZmt2clpOSElJd1R6ck5qRHgyOXlMZkR4a2kx?=
 =?utf-8?B?VmkvaVhXdkk4Ui9uYnRiZXhZZkZOMTgybUNZTXYrUXRXVzNUN2Q3K2FwcHB1?=
 =?utf-8?B?NENZRm5wSW5pcG1yNnUrclowQmNpZDJuOVErTmpxQWVoV0JWVzJBTDhkNnBJ?=
 =?utf-8?B?VGwwU1ZrR09IYWUydXcwZ2pTamppVWNDc1poQTRmQUdNQkFkVFcrVG1VTWkw?=
 =?utf-8?B?NS9aeFBuMlhOa0xpNkdSbGthYkI3NnN1dm9HblN3SElDYS9rTzE2RDhkRlJz?=
 =?utf-8?B?cWRqbkdhNUttaHcrclhvTjBuOWR4VXVsNTVEVlVjRXZlNnhUMXBubDlXWksw?=
 =?utf-8?B?OUJtV042SXdKek1iM3lPcmpudkRobWpOWFNmSzc5OUdzZXZSYmRocU9wWEZF?=
 =?utf-8?B?dHp4UEVaWXNrcVJGb2p2SUgxY0VRWkJXQitHODVWYjhaVTVrUVY4VnlDdm1Q?=
 =?utf-8?B?YmV1Vlhsc3BCZ21RZEwvUEI1UzFXdm1rMUMxYjRVZE1tRFhkSUNjb0lYSko5?=
 =?utf-8?B?WnR1eG1yREhlclJLRk5laUJySnp0SHdNTnc2Y0JPSEtBbjA0aW9VOEpEajVl?=
 =?utf-8?B?WW1INCtVMTJqMGI5NXU3NC83d0thM3NkbXluVFp5NVlGMHNmd2ZhZHNENEVo?=
 =?utf-8?B?UlJZRUx0d1RHNW5pVk9SMXd2Y2xhNWtsZ01GWFFWL1I1dlVscHhsdDhYVmQy?=
 =?utf-8?B?Z3BVTktDQjdxRDhLTmx0aDFvTDEya1ppMGw2cEQyemMrVHVZTkI3OUx6QnJB?=
 =?utf-8?B?MFZLdWpQeTY1SktkcEtrWUl1RlVudXpGSGQxQjc1NDVVWVI4clBGeGYvTXlR?=
 =?utf-8?B?RTdNRENCeHpjNmVObUc5bFIyR3lrTDdpNzhFOXphOHUxRTNCdEs2Q0pFOHFX?=
 =?utf-8?B?ZDVzSzRoRi9jN0ZHYis0Y0RsejI1YTBQek1oQlFqcVBibzJmTnQvaXJZSCs5?=
 =?utf-8?Q?xZYuNanvUuhALlhxOgBDY5u12?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3123be20-3a3d-4b51-0349-08dd8700e034
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 09:33:19.0749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKTiGgs/AlrgD8qyUlR6CnDNAoJYfWc40YfXleiZfFbQarroYdtYsO1bQpwpyHETq4XXwN1pC1DKRqr9drqmBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413


On 28/04/2025 15:33, Simon Horman wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Apr 23, 2025 at 04:50:38PM +0300, Moshe Shemesh wrote:
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> A function unique identifier (UID) is a vendor defined string of
>> arbitrary length that universally identifies a function. The function
>> UID can be reported via devlink dev info.
>>
>> Add UID attribute to devlink port function that reports the UID of the
>> function that pertains to the devlink port.
>>
>> This can be used to unambiguously map between a function and the devlink
>> port that manages it, and vice versa.
>>
>> Example output:
>>
>> $ devlink port show pci/0000:03:00.0/327680 -jp
>> {
>>      "port": {
>>          "pci/0000:03:00.0/327680": {
>>              "type": "eth",
>>              "netdev": "pf0hpf",
>>              "flavour": "pcipf",
>>              "controller": 1,
>>              "pfnum": 0,
>>              "external": true,
>>              "splittable": false,
>>              "function": {
>>                  "hw_addr": "5c:25:73:37:70:5a",
>>                  "roce": "enable",
>>                  "max_io_eqs": 120,
>>                  "uid": "C6A76AD20605BE026D23C14E70B90704F4A5F5B3F304D83B37000732BF861D48MLNXS0D0F0"
>>              }
>>          }
>>      }
>> }
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   Documentation/netlink/specs/devlink.yaml      |  3 ++
>>   .../networking/devlink/devlink-port.rst       | 12 +++++++
>>   include/net/devlink.h                         |  8 +++++
>>   include/uapi/linux/devlink.h                  |  1 +
>>   net/devlink/port.c                            | 32 +++++++++++++++++++
>>   5 files changed, 56 insertions(+)
>>
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index bd9726269b4f..f4dade0e3c70 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -894,6 +894,9 @@ attribute-sets:
>>           type: bitfield32
>>           enum: port-fn-attr-cap
>>           enum-as-flags: True
>> +      -
>> +       name: uid
>> +       type: string
>>
>>     -
>>       name: dl-dpipe-tables
> Hi Avihai,
>
> With this patch, after running tools/net/ynl/ynl-regen.sh -f, I see the
> following when I run git diff. So I think this patch needs these changes
> too.

Oh, right, I will add these in next version.

Thanks!

>
> diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
> index f9786d51f..1dc90bde8 100644
> --- a/net/devlink/netlink_gen.c
> +++ b/net/devlink/netlink_gen.c
> @@ -11,11 +11,12 @@
>   #include <uapi/linux/devlink.h>
>
>   /* Common nested types */
> -const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
> +const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_UID + 1] = {
>          [DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
>          [DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
>          [DEVLINK_PORT_FN_ATTR_OPSTATE] = NLA_POLICY_MAX(NLA_U8, 1),
>          [DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
> +       [DEVLINK_PORT_FN_ATTR_UID] = { .type = NLA_NUL_STRING, },
>   };
>
>   const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
> diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
> index 8f2bd50dd..3a12c18c6 100644
> --- a/net/devlink/netlink_gen.h
> +++ b/net/devlink/netlink_gen.h
> @@ -12,7 +12,7 @@
>   #include <uapi/linux/devlink.h>
>
>   /* Common nested types */
> -extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
> +extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_UID + 1];
>   extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
>
>   /* Ops table for devlink */
>
> ...

