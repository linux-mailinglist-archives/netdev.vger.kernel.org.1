Return-Path: <netdev+bounces-258354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM94A2DijGnvugAAu9opvQ
	(envelope-from <netdev+bounces-258354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:11:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525E127541
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 21:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81B4300F51F
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 20:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11613352C2A;
	Wed, 11 Feb 2026 20:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DY8XWeS/"
X-Original-To: netdev@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E6280024;
	Wed, 11 Feb 2026 20:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770840669; cv=fail; b=qDWB4TwQNRXxRAWvEpyWC1q9hV0CdKd14hWdoycimIsxFQTkJCfynM7FFCAT49Tsg5Z6VgaE9BpQZrIKuGk2JHo6UUrn/bUyosPfkr5y+hlos9QM1p+YBH5J0yr0F1S0+DBlIz/4tsITS/m4qpXqLQPCLxvobdaXbi6KGoI4RiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770840669; c=relaxed/simple;
	bh=IG0PzuQ3lEDLSQia+l/8xGrIggMyMdhw+ITF5aZV87k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ofhIiShCz78QQwA8ebke5wCtHmOMGhTBKCwiGIs5yy/m/wVXqYvvhavYWpTo1uPZCBWrvUYeMFp0VZLui185ptVwhuflplg7gwYDAsr+4/x6lEkImzeAkwpJKlo3EuiPTS0Wi84PEKP+pdAB0hznGTjcxSkiMXZUXNyrOQaiaGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DY8XWeS/; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iO0BKkHxxF4K40xjhDo8c5TbwHVJeC+llg8v5MGdbwCcY/8fWBcJMwDK1mW8VgIFnGj8+FgUgVM9kpL7BzKsX9xao1slmcN7/DQvoc5iTzyLnVeMsqtmS7p/zTQapWM4IUcw/6tAj6hGs8yJuWFy8JKd0GQ7OKB90upRl1Kb64I3JrHdrP6/EjnmHFir24Qp6jGoJpQk414PEwinXkhJej34TZAxWMXm8Y/Ff3202gCUgCVQICuHk+oI8iCCJ0kPGntOR2Hc4VM4l64dnbWwiQ8l+evEuMpFC4Ob03koEUoEAil5aE0Rv7SCQ76iHLhxPm8sDVq89KyBTx50CClNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0MMS5MN/rLjS19qCtzVpfKQXoSvympirV/xOa7IQCI=;
 b=Vsuzi0D1Xg15O9vQCqgRTn6SFL+sMOW7UdJpdqioZDpV7Oj/eukwDZdzmeI7j31hmVBBSgutRvLCFIVVlkpR5fBxbByeJUqMUu5h7fkl70Fd71j4YBbjdM5qDwDlATq2daF1Gnm7LYqGAoT6ykN0xrXyHMPXOjiVHGGsWVc9v4m4ULe/r1WXJIw0iDcTDnR468YS+6F5ev5QN9soUjVkopHyXQ/Xd8Sc+k0lAH/3jalCevlhur6HMkiNPmV1AiWbej5RvrQMSJn8fISnVl6K0nTf+TRLoUCuZhjvpvAKEI81OYBb+2iudC0SKFn8TZggsECTF48YKHeatuRfaE3sMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0MMS5MN/rLjS19qCtzVpfKQXoSvympirV/xOa7IQCI=;
 b=DY8XWeS/yrnxlge4hsSvTD+x5i35HB3rHhPTvKMMnYx3Tl98Eb1iwJiEpLEJMqI5sbt8gkzCFv9HO2w7BLaL7E2Ywdj65cx93wc60IQGlLSJmEdDp8qHiQ7lZwP5KBDwZqG0C9ycxzQEEQp611kNaqCKDpTMWG4StLG9uM12DrXm19ki61K1rAaeNWIL0UjoUXy/OX53ODYA66vF5l6NGFQ6HUBjAlMf8SnbXynIu5JiBMoE5NwdS+7M6rXjiZVnTQVkH9/h/r7NI+9s5qA5udFO8tNzBwY8ua38pWcXa4jgDE40TkHtsWG/iIY1A0RWFkbHTVOv0fFuhUazdrgfNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) by
 MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 20:11:03 +0000
Received: from DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::4f0b:dec1:4317:9b86]) by DS0PR12MB8069.namprd12.prod.outlook.com
 ([fe80::4f0b:dec1:4317:9b86%6]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 20:11:03 +0000
Message-ID: <9f535014-80eb-4f57-b047-3638579bde9a@nvidia.com>
Date: Wed, 11 Feb 2026 22:10:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] selftests: drv-net: rss: validate min RSS
 table size
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org,
 Willem de Bruijn <willemb@google.com>, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, noren@nvidia.com
References: <20260131225454.1225151-1-kuba@kernel.org>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20260131225454.1225151-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::19) To DS0PR12MB8069.namprd12.prod.outlook.com
 (2603:10b6:8:f0::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8069:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f347ade-de66-4cd9-773d-08de69a9ae60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUc4ZEFKL3pmU3cwUWh6YkRSN0xqNlpzNlJ2SnBBczBqSVZPYm53RlVSbEFz?=
 =?utf-8?B?YUdFOXNyK0c2akNDWGVmWGk4RVJWcVFzUmRsUDl3b3pGcmgreGRXaDVXV2o5?=
 =?utf-8?B?djcrQVhCOEFPZUVqS05OeTVYRW9aT1B2VDMrQ1Z3MlhqWVdUK2RrcGo4aGZz?=
 =?utf-8?B?cVZJeDZoUmwzZWdIQjFORnpoWTAwNnIxTnFCNGNBVHlVaDFKclJPVVFGSUlz?=
 =?utf-8?B?RkQ5cEJDZVo1RnY4RDFlM2xmcUFLczhxUmhyOHNkV1B3U0k3SVZQZTlxd0hP?=
 =?utf-8?B?dkVMRkF2ZDFXcXdqVDMzWmkwNjE0dzFNSzAxbHhKK3hYVkNjdDQvM2NObmNs?=
 =?utf-8?B?c05XS2UwSWtydmZ0ck54NlFZTGNSWm9oN2V4ejJuRWdXeHl6aFF6cFYxeVMz?=
 =?utf-8?B?L1NjNXpRRTBoK1FzNGpwcXgzRElubXFJdWFnNm80eVNRK21RYzNQV21BSE10?=
 =?utf-8?B?bEl6eHVIU0Z1ZHBtcGJZVEpwNjltSFdXdHhMSXN2amQyV25TK29HakQ3Z1FE?=
 =?utf-8?B?R0hnSk9GbUxuaUVqMWFjWXV5OU4vV091NkRBL3VjRGxYV2w3a05UUnhBQUhX?=
 =?utf-8?B?RHp0aStwUTRYRVJ2VVFRMEpWN25rWmh6VU9PWUdVcmRCRyt4MU1mbUIrU1FI?=
 =?utf-8?B?aThoV2ZJbEozaWxvTUJvdGhmeXFjN0toM3ZvVXZEYm5DMFVMU1hBdGdFT1pr?=
 =?utf-8?B?cnJQQlZVYVRWK2IzZ1dpV3Mrbm03M1dUZVNGaDlIeUp4NnQ5eHFJTXRIazdq?=
 =?utf-8?B?QlpxcHJWbWlnZG1RcDlINFA4cHhRVDAvTGFxMjZBQnFMR2RndzZndTRxSzVs?=
 =?utf-8?B?M3hNREZXV2FQMElJakxOYmZXQ2d4eHVidzRSVFpONzJTQ2pDMk1XTGZyZ3JU?=
 =?utf-8?B?NGdDV0JFcktpRU4vZnZPNlBINDJrNjFjeW1OblZyMEFMbXZlWXZzWC9PYlpC?=
 =?utf-8?B?a2hudUs5dVFNMmxVQVpsQ1ROOFVLMTYrOFluWVB1dXF3bnI0YlJqaHZiRGZo?=
 =?utf-8?B?WmlwbDBkWUgxb0lLSDEwTEtseXlycmQ2V1liN2ZUbHYrcUhwRVhXc0ZQUUFa?=
 =?utf-8?B?MkxndTRESndHZ2hHV1NyTDFKdEpqajlqdHBwQmtxQ0w5dVQ4SlVZejJqYVlh?=
 =?utf-8?B?WWFxR1YwMzA5MHFkYktuWTI3QWxISUQ5K3lTR3dRaHFpNXhiNFFpL2VoeE12?=
 =?utf-8?B?WldCQ0s1djVVanNNejFLMWJUNzFxR05QT3hxcjFneGhzdVJFdk0xaldkOXQx?=
 =?utf-8?B?OTZYVkttNUozYVJiVGI1ekk1RFV1bXZYWVkzLzdtZ2dWT1RWamVTRDZzc1gv?=
 =?utf-8?B?ZjRwc0JBcTVOMW9nbnJ5eU1HM3JvaDErOFJSTWQ3c3FCZ3hsTDVSaTUxZTYx?=
 =?utf-8?B?dnB0aENmQ20rQ01SWmdTRlFrdzdUbmxhYjdQK2hyMWwzNkgxUnpyT3dDYUQz?=
 =?utf-8?B?M3NqQmtiTkljM3ZEZFAwMjN6SGJidGNkTGF3VlBYRXREK0dVWldFOXRFa3pE?=
 =?utf-8?B?Yi8zUGRhT2FoZXdUeWVhWUtHeVdsbFFwZzh5ZGY0VkFrYTZ1b0pXRDdIdmJm?=
 =?utf-8?B?eGpWcXM3bHVwMlBFTjQ4YmQyWjh6WTc1amRTNmVudG1KWnpqcnhIK3lQK0tm?=
 =?utf-8?B?K2NXN00xRFB4WDN1Vi9xbXBjSGVFVUVjNlR3WktSZGx2TjVKV1dvbnRjbWY5?=
 =?utf-8?B?ODhZV2s1bWhQTHc3YjBobWI2VWdDMXNUOGVQNXFabnZSb0xYbUxWazdXVWlG?=
 =?utf-8?B?TFRWODQrM2MxUmJReWlWNi9JQXJVdHl0L2tNSHArTXJRRC9naVZSRVhyZUsx?=
 =?utf-8?B?cGRHZkQvSGo2UjRGcmlPRDRZeGtBWG5zY1dkMk00RFY4L09hc055MWRHZmVt?=
 =?utf-8?B?TTRHdUlEUG9lT0hKamdUeWIwd2NweGZmdExPWENHc0VmWXFML2hoRkxtNG1u?=
 =?utf-8?B?SlQzNHZpcEtHRW5XTHBvQ0RjZ05LOUYzKy85bDhmNUE1cWlTQ0RDc3BnZ3g2?=
 =?utf-8?B?Um9RRWlycUI1K3E3NEFVb0wzd0NuNFNHZVQrSGlkOHpMU1NmcXhQcGwyZ2VB?=
 =?utf-8?B?YlJFVTlRVXdvUVEyMmphbks5dVRPY2pDcW52Y0RzbDZ0cjIzQks0a2lLRFdY?=
 =?utf-8?Q?HdfQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjZBNUpLajFEZVB1VmhMUCtwZlZxbi9qeVVHVllScnN2Zld4OXV5R2ZVa3V6?=
 =?utf-8?B?MWE5am5hMUhDam1ITU1DL2ZTMnA0djFmR3RTQmQ5SGF0NC9aelNsV0xzR0t0?=
 =?utf-8?B?L3NFT1FlTWNFd09melh6cndtRUJYSmVtNGsrVmlhMTBsL3FKcnN4NFkxUTRy?=
 =?utf-8?B?VUhnaEF5eVVmbkZVQnBJMHRuZ1AzdC9rclB6SytuNkpOcUozL3c0SEVLMEhm?=
 =?utf-8?B?UkRlRVlPUktkOTBMQmZ0c2txTXQ0elRZNnVwb3VWZWIyeVVZamUvemJlQTJh?=
 =?utf-8?B?aEVlTExyOUk5dHJLRnkrNXR6elF1MHVIdDhqODVVVnFyVUd3MnBMMWd6a1p6?=
 =?utf-8?B?OGxEYUM1MEpwSDdZUkRpYjA0OElnQ2R3OXkvQ3ZxWG1yYW9XcGJTYUQ0cVlo?=
 =?utf-8?B?RzB0YWpkdEhSUVROTllTeGNOckZCQmh0THhQTW5mVE9udE5FVE1BbFJrMjhZ?=
 =?utf-8?B?K3d4MmJFMUVPK3R1RGh5bHFoaWlMRG9uOGtHTlZEVEp4OU9IZUhIVG5xTSsr?=
 =?utf-8?B?dVRzb0swek4rSkdjVW5PNVNrbEtxOUlWTjA0ckN2WFg0RFVlWTE4TlR0WFJI?=
 =?utf-8?B?b01LRVh1QUtQRWpTS1Fvb3AwNGtHZVc2YXFHb3RxRldlWXBEeWcxRzFRaVVF?=
 =?utf-8?B?NExrbVE0V0NDcXdneExzZ3JKTm9ROS9MbnE2Sm4wejhoa0syYWdrV0RXSTM0?=
 =?utf-8?B?NjJOZnpRdGd0MGlOSXRSMmF4QVZSVVVBV0VCUDlwUlM5ekIvRjd1T25uUzZK?=
 =?utf-8?B?NXRkOXJpbXRlQ2xmZ0RPNjdVTzk3d3drbkVHSVBIK0wzNkVHYWxTTiszVW9W?=
 =?utf-8?B?VDd6Q2dvR3pKeU1oV0JoNktKVnlRVmVrNU9kYU1aRWZEV2ZnWmtCd21aYVUy?=
 =?utf-8?B?eUJhZXlkZkhtdUc0SUErYWZVT3NDZXVZWmt5SUdjeHg2a3ZGdG1JRmN5aUo0?=
 =?utf-8?B?RHY5VnRpRXdhd3dxVlBELzd6TlZxaFVPSUhSVU5wZnFNaU9sdEkzeXJuNzRL?=
 =?utf-8?B?VjNQN09EZnROVFB3dW13bTQ2Snp5bDB3YnJzTEV1S05jamZ4bitIVHBBbDB6?=
 =?utf-8?B?d09tWDNsZHlxZERQZDNOMytvOHh2VGJkczJzdGxOK3d2am52UkF4WWY4WWdG?=
 =?utf-8?B?ZE9sV2E0SE5KT2k2dGlmN3dJUXBXUTMzWnRNYTlxTjk3cUFMNUtSbFlRNUp4?=
 =?utf-8?B?czQ0YjUyU2hpbkNuQ2c5eUQxYUJoM0Y1cVFUSUlWS1ErRDZZODFSaUR4UkpN?=
 =?utf-8?B?VWZyaU1LSVRSSnJtaVJIUGZZL3Jmb2x4UFk0K3JWTWV4UVNoUzl1Y1NPVlE0?=
 =?utf-8?B?elVXekszaTY0ZGZtenAwQVNlcklTNDVuYjNMaXBZQ283b1ZneWpJcjU0L2FY?=
 =?utf-8?B?RHFTQTRtcHJ5ZEZjSDBMdHgwUGZNelExN210LzlTRHdUUjhRVUlUVDVNaDhn?=
 =?utf-8?B?MFlwOVNFUGEyMEFYczNEWlJRdmY2K1d3Tm53TlVEc3JZcXZuaGZzb3Nta2NS?=
 =?utf-8?B?UVdqcHk1QU5jeFJ3N3FEY2NEM253Y1JmMXU1UzltMDUxS2RlWUdGS0JtbC9Y?=
 =?utf-8?B?MTJsaERVRWhmVVFyK0lXelNsYnlVSG93cUpwSGpiUnVOTEROV2Y3RFhHblk4?=
 =?utf-8?B?NWhyWVhVTFhxbDd1bmZ2czhoZDh1VTlsUUNIbjRxSlhFbS9xZm9Eb1pyeGxn?=
 =?utf-8?B?d1F0K0JkNUIwS3JFUVpiQnAxQVl3S2RKQXdtUEl2Ylg2QUxQNjh1L1d6ZitO?=
 =?utf-8?B?VFZFTy9wRFowQ1ptK2VYTGhyZWEyYmF2NnRvMkR0YW55NDZDUXRtVmJFRWFW?=
 =?utf-8?B?RmdNNE1qcXBoRE1mVDlEcStCL0JWTkJnak5oK1FuT3VOTVd1QThsWGI4RGZB?=
 =?utf-8?B?RVl5SE1LakIycG5BRUtpV2JGVzNSRnJEZC9hTy8zK1c3RGZ6T2laL3FaaWRu?=
 =?utf-8?B?d1BhK0MxZVlmUmhNVjdOK2VyZGlvMzFLZUhMTjVBVU9VMzJFdkIrd01SaWM0?=
 =?utf-8?B?aEVzZmVDQUVqYktkZnVVZGU1ZXJxOVJKRVN4ZkNEN3BaRlREdEYxbXkrWjNk?=
 =?utf-8?B?T1JYOUREVTZha0laaHFFem5rTEI1T3M5N0FQeXhOeVVNRzZHRGwvT05XY2dD?=
 =?utf-8?B?TlVhYmhHU1JidWJmMm96V01GNHUraEVHTkZydEZJOCtLbSt2QVBiOFZMRnlO?=
 =?utf-8?B?UDNyR3VWdk9Wa3ZFZXpCZS9ONlZjTWFUajdJaXQvd0htdWd6VWFicFA4Ym1t?=
 =?utf-8?B?dEFvU1FWMWdvZDhTN09pRzJEU25McE14eXhCUEVaSWVPdjdaYmp1emdTbEYr?=
 =?utf-8?B?UGRrMlhFdTlZSEU5WnBNQ2ZZMWpHY25RZTBiclZXWDBhU052dXdodz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f347ade-de66-4cd9-773d-08de69a9ae60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 20:11:03.1178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbEhsCyRkZoVSE0XvVLEabLPV5EXY/V/pAbi4afunqpNTPAGozfXAC+aQf2XPTQgk62kbIF76DpIv9zDiMDaGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258354-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ychemla@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rss_ctx.py:url,lib.py:url]
X-Rspamd-Queue-Id: 4525E127541
X-Rspamd-Action: no action

On 01/02/2026 0:54, Jakub Kicinski wrote:
> Add a test which checks that the RSS table is at least 4x the max
> queue count supported by the device. The original RSS spec from
> Microsoft stated that the RSS indirection table should be 2 to 8
> times the CPU count, presumably assuming queue per CPU. If the
> CPU count is not a power of two, however, a power-of-2 table
> 2x larger than queue count results in a 33% traffic imbalance.
> Validate that the indirection table is at least 4x the queue
> count. This lowers the imbalance to 16% which empirically
> appears to be more acceptable to memcache-like workloads.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - no changes (see patch 2)
> v1: https://lore.kernel.org/20260130192912.826454-1-kuba@kernel.org
> 
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/rss_drv.py       | 88 +++++++++++++++++++
>  2 files changed, 89 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_drv.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 9c163ba6feee..a64140333a46 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -35,6 +35,7 @@ TEST_PROGS = \
>  	pp_alloc_fail.py \
>  	rss_api.py \
>  	rss_ctx.py \
> +	rss_drv.py \
>  	rss_flow_label.py \
>  	rss_input_xfrm.py \
>  	toeplitz.py \
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_drv.py b/tools/testing/selftests/drivers/net/hw/rss_drv.py
> new file mode 100755
> index 000000000000..2d1a33189076
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/rss_drv.py

Hi Jakub,
Thanks for the test addition. I wanted to raise a concern regarding the
spread factor requirement that may apply to mlx5 and potentially other
drivers as well.
The real issue arises when the hardware's maximum RQT (indirection
table) size isn't large enough to accommodate both the desired number of
channels and a spread factor of 4. RX queues/channels serve multiple
purposes beyond RSS - they're also used for XDP, AF_XDP, and direct
queue steering via ntuple filters or TC.
Artificially limiting the number of channels based solely on RSS spread
requirements would be overly restrictive for these non-RSS use cases.
In such scenarios, we'd rather have a slightly degraded spread factor
(< 4) than limit channel availability.
We'd appreciate any feedback on this approach.
Thanks,
Yael

> @@ -0,0 +1,88 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +Driver-related behavior tests for RSS.
> +"""
> +
> +from lib.py import ksft_run, ksft_exit, ksft_ge
> +from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx
> +from lib.py import defer, ethtool
> +from lib.py import EthtoolFamily, NlError
> +from lib.py import NetDrvEnv
> +
> +
> +def _is_power_of_two(n):
> +    return n > 0 and (n & (n - 1)) == 0
> +
> +
> +def _get_rss(cfg, context=0):
> +    return ethtool(f"-x {cfg.ifname} context {context}", json=True)[0]
> +
> +
> +def _test_rss_indir_size(cfg, qcnt, context=0):
> +    """Test that indirection table size is at least 4x queue count."""
> +    ethtool(f"-L {cfg.ifname} combined {qcnt}")
> +
> +    rss = _get_rss(cfg, context=context)
> +    indir = rss['rss-indirection-table']
> +    ksft_ge(len(indir), 4 * qcnt, "Table smaller than 4x")
> +    return len(indir)
> +
> +
> +def _maybe_create_context(cfg, create_context):
> +    """ Either create a context and return its ID or return 0 for main ctx """
> +    if not create_context:
> +        return 0
> +    try:
> +        ctx = cfg.ethnl.rss_create_act({'header': {'dev-index': cfg.ifindex}})
> +        ctx_id = ctx['context']
> +        defer(cfg.ethnl.rss_delete_act,
> +              {'header': {'dev-index': cfg.ifindex}, 'context': ctx_id})
> +    except NlError:
> +        raise KsftSkipEx("Device does not support additional RSS contexts")
> +
> +    return ctx_id
> +
> +
> +@ksft_variants([
> +    KsftNamedVariant("main", False),
> +    KsftNamedVariant("ctx", True),
> +])
> +def indir_size_4x(cfg, create_context):
> +    """
> +    Test that the indirection table has at least 4 entries per queue.
> +    Empirically network-heavy workloads like memcache suffer with the 33%
> +    imbalance of a 2x indirection table size.
> +    4x table translates to a 16% imbalance.
> +    """
> +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> +    ch_max = channels.get('combined-max', 0)
> +    qcnt = channels['combined-count']
> +
> +    if ch_max < 3:
> +        raise KsftSkipEx(f"Not enough queues for the test: max={ch_max}")
> +
> +    defer(ethtool, f"-L {cfg.ifname} combined {qcnt}")
> +    ethtool(f"-L {cfg.ifname} combined 3")
> +
> +    ctx_id = _maybe_create_context(cfg, create_context)
> +
> +    indir_sz = _test_rss_indir_size(cfg, 3, context=ctx_id)
> +
> +    # Test with max queue count (max - 1 if max is a power of two)
> +    test_max = ch_max - 1 if _is_power_of_two(ch_max) else ch_max
> +    if test_max > 3 and indir_sz < test_max * 4:
> +        _test_rss_indir_size(cfg, test_max, context=ctx_id)
> +
> +
> +def main() -> None:
> +    """ Ksft boiler plate main """
> +    with NetDrvEnv(__file__) as cfg:
> +        cfg.ethnl = EthtoolFamily()
> +        ksft_run([indir_size_4x], args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()


