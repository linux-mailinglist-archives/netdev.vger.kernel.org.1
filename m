Return-Path: <netdev+bounces-228562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78B9BCE30D
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EAE19A6EF4
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 18:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71252459FD;
	Fri, 10 Oct 2025 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FBbdkmSt"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8F71A2545
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 18:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119733; cv=fail; b=J5SKsWBEAnIMKkCLxyf3SLxAajgoJ3GOyJ/BgJTA3QuXiOwML9JzGrRpG3fEhiv6NoQaVoInCULBE/fyEXo8DnzyJe0vG+qgNkD849zvOL5zQr5vZ7ULzqB5aw2e2waw4q4FTwAHvb8zkr6faKTPvqBVg5d55Gux2pkdOZFiyOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119733; c=relaxed/simple;
	bh=7CVkNSK09LDaf59qAgsrwcNGmGDVOjDuwSIjpnSJe58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s3GiO19AKKPk+jKmaDiFuKdxv30uklmorLngo2C7QyDe5jnOP2uDJ3P2uF4Iqy82Jcr9axRdlLsK6c3So0bT2TxSw4Fhq3xzhT9hCff/r7nxR0IkQ3iJgd+F//J5xSHeZr896by6ml6BWcJXZEMLbviUC8aiJG98yZXvF8QBOz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FBbdkmSt; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8k8cv+ss3X9UIyThrHVe/kdsQcNNZo1IJuxkavv+yTLQ96RP43M9GjZrRxhD4//hwlHywkMes2Erd4hkiF4PQRkGHpOPZ86PGmFigcz36e2YxkeWcSMqi2k4eEecZ0+OmVSqovnw3+ifoWp6iOrKNvsEVHa/6xyKxNuLd72gEzi+wYhXLmbVKCx+wCbckEoBhN4sWKwbMufdGtI+ZUoAZ5uUopnNXRdKc6IPE2JOhggHfRNr2tfsdOv8GJ4damme228/5Oo5OXXEFuyhKOHRYNCRaLoxg2IXTfxyH1daUL1khaOmza6S9IAzeKNTwzgWfNiVzn9taPQFMfuYhbu2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnkQxl3j5/ejEyRabrk6IAnXAodn/3smMjQOzr39sI0=;
 b=x/YuOzWYEUliNPwlDjStbyXsGnGgT651+n2d1sg6OeXdi0cv1QfZRCGfgz/fcXzwRj6kpGs0EE7+2LfFR//Qxjq8yRp4AxdMBr1mZ3UgObtsFEtbcfOfq8xTTyRx+70q7SSFh1F1peDHicfMZxJZdkldjZ9kQOOx0DIB1b6IXa3xRPY2AtFs9BHk3r645DXfPK7GuFxQUz3sMs5RMiaK76sufHGTBeRnjUWfWAqf7yfTVvLudW+/lqK3TYtW1a22N6SS1IIMGsf21f4oOuMSY03YOYAgCXnu687jppvx0ZOpfNI2Z5xevye3p1G5HFNDKAaJHZ563W18vrse4D9wiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnkQxl3j5/ejEyRabrk6IAnXAodn/3smMjQOzr39sI0=;
 b=FBbdkmSti8hcieKFRfCLuhBDzy7QcFPJuMNfcm6kpNc6icarFt8GlI3XBxr/31n7cOfYpv+2I5Mdwa70LYQT3eKBU7s3bCj60GWxke2EJHv9jfQwc61iwgKGL8qc7o4nZFJEPCqd9EnLuhrtzchvpHQF7M+gqS/3ZiaMuG4h0jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by LV8PR12MB9231.namprd12.prod.outlook.com (2603:10b6:408:192::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 18:08:50 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 18:08:49 +0000
Message-ID: <f0abc6b1-c23a-48a2-8ba2-4418570af118@amd.com>
Date: Fri, 10 Oct 2025 23:38:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: Avoid spurious link down messages during
 interface toggle
To: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, Shyam-sundar.S-k@amd.com
References: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
 <c7f455ba-cbe3-4660-9ac5-e68f5a18963f@amd.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <c7f455ba-cbe3-4660-9ac5-e68f5a18963f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::7) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|LV8PR12MB9231:EE_
X-MS-Office365-Filtering-Correlation-Id: 02402b77-f014-4cf8-6235-08de08280ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmNSRTgvOGFjUVFoSHJEZHBDclROMXZmcCtTYTNoV2ZjWjNScUQwZDF6MFU3?=
 =?utf-8?B?K2lwQ1h2ZjBoRVhVNDcybGVCdlA2djlxVHFUSEtORTJOaEs0N0U0QkU4YUpr?=
 =?utf-8?B?RzVZaDh1VXZLbjZDcmo2SFo2U0hDSElydnpSYmptdlhudnp2dWx2bjdqdFFE?=
 =?utf-8?B?NW5FbTZPQ0Fpd0Rxd1NJL1IyT1pEdUdQeEcxQ2Jta2cyL1FoRlJmTlF1RHBl?=
 =?utf-8?B?bGlseHdkRjFIaVRiK1dSYnN0Rk0yeE5YbmFlYXBzTWhSR1R0cGdyVFR0Zm54?=
 =?utf-8?B?T3NMWnpQMUpGdmtLbHNiZUc5cVZvc29LMFNFMWlUeE1CWXZFMUFjZ1ptbmgr?=
 =?utf-8?B?SHg1Uk1uUlhrYmhWc0t1MFFOcFBGMFkxNjJBR2NaVExNRkRXYldoNFFObi9N?=
 =?utf-8?B?UHJ4NEl0SWF4S240WVlhQmpOT0RZQTdaMXhibDVpZ25NLzNWcjh4VTgzdmZh?=
 =?utf-8?B?clpmbVJ2bjJqcFYwYVVTQ3BWZkFTaHFwVE1iOWNqZXNxSzduZFBobysxMHlE?=
 =?utf-8?B?QXZYNTROVE1RbG5SalFROUVvQ0tEbzNSaDlCWVVUVkJtLytzMTVqbkZCOU5D?=
 =?utf-8?B?eVB0dGxreFg1YkRlcndrR1hyclFWTWVYdkdmdUxCT0RhR21tK3BwMEtVVzhz?=
 =?utf-8?B?WHZSeEE0SERRclBZNytrZ2JtUndJWlYzUFNkWnJGbGROUEdXZ3lzRStQNTBD?=
 =?utf-8?B?K2p1QmZ3U0h5UXVPQzFwM3dDSC9QM0JsR051SmdNaWVMcmpTNmFLZllHRUVV?=
 =?utf-8?B?NktWeUpUY2d3d0IvUm5tMUNzSjlNWXFpaEVOSm9hZjUwM3ZONFcyQXlOUmhs?=
 =?utf-8?B?anNDLzArWnVnazVnUEc4UTV3OFkySG9CZGZ0Rm5WVDdOUEpLZUtzT2ZrTXBD?=
 =?utf-8?B?OG8rTnlBNlJzbnlVeHRjNEVjTFFvVG1rcVBxYS9NQ0xqc0tMWkZUdjZ3dklZ?=
 =?utf-8?B?RExtYjdnWDFiWlNPSTJQdmhpZ3BoemxrdUEvelc5MVVyTzRxUlUwSDZCZ280?=
 =?utf-8?B?VkJsMGlHdHEwTWhHMVI5cnFvazhNb1JObWhwbmt1Q2dESGFmUk1yRmdSUXpT?=
 =?utf-8?B?NGw4NkNUM1BOK2R5TENsNFYrY3oxSXZKeU1SUWszSnpuMTJCVTN3cW9SZHpn?=
 =?utf-8?B?aW9GLy9KemNIcTFXbmV3bDVkOEFkaUovazhPNHlvdERoNGdYWk9hVTVONHVH?=
 =?utf-8?B?UGxHblE0QUM3Rkx1SGM0eFdwbG9adnl1ck9hc3p3dlY2SXI5eElDclQ5T0px?=
 =?utf-8?B?MlY5VnZYVlIzVGkrMUVISmZ5ZVAzeXMwcWZjbUhFZ0wvcEZWUmczbG5CenFl?=
 =?utf-8?B?cWswL0p2clY4RGNOVVJ6UllQTlZWb2NaOEVUbjdwemppSVN2RE5uVEtHZGJG?=
 =?utf-8?B?aDArVFhwcEJFQ2FBa2pBYStwZ2xaVGFpUGIxV0JOaTNWM091TVhpR1pxb2hi?=
 =?utf-8?B?REdTdmJ1bVl2bFBxZnNybWFucGlZK1hmQ3VRWllwczNIVG1qSWsrb2lmT3Iz?=
 =?utf-8?B?WEFvZE5NT09reCtrdVdBeUpnTWpFckpad3FScDdhQmZYL1l0UHFLRGxWYjk0?=
 =?utf-8?B?NkZjMVlxODVnSkFzQk1YUEVWR3IyM1l5NXhxVHdFV2NVOWxyeUUvZWxRSE4z?=
 =?utf-8?B?ZkdKVHNDNGMrSDZGZ2IwSDY5ZjhBeFdhN3VEejA5NTdZNXhuWklIdlh2WEFj?=
 =?utf-8?B?VTFtWXhrb21XdFQzYnBIQlpPS0Fmb1JxWHUzNXdIY0dUQlpJQU85NGxpNS9l?=
 =?utf-8?B?VnN5alpsQkdhdzVaYVl0Y3doL3hnRE5SUVlSMktQOHRiYzJzNlpzVFZLZTJB?=
 =?utf-8?B?QWRaOVluM3F6NDRRNWdIQlYxV0UyalU5R0Jkb2R6SVYxendGeTF6MzlFNkhE?=
 =?utf-8?B?VWJFaG9vZ0htZjFGNjFQem44d2p3eGo5VStpa2xDQ2RQUG1DUnplVWsxVmJG?=
 =?utf-8?Q?kng5SWCzu9EwJ5XiXgMyGTZIyfVjFjpG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTd6K24zWE5OcFQ4Z0wySDd2VklJZTdZam02OU8xTGNEbEFnM240Z1RBZW1L?=
 =?utf-8?B?NXYwMTJ1RW54MDdEYmRLWXNqUWQ1eGx1QzVYOHl4L3VKbU85djRlRDR3MVNX?=
 =?utf-8?B?dUhtcVdtQzcwaXlhWE5oTXo3ZElKTzRtSVVwY2JJd2pOaGVmZzBFR3pwNnpn?=
 =?utf-8?B?TTVSaisydkdZb1NvWm90Z2hJSHF1NGVCdDUyTUw5YVpJbDl1YTYzNmNwSDRh?=
 =?utf-8?B?cU5ZS3k3VlVTY0ZFZnhTMDVPVmtENktkUXdManNKWHhjSnIzK0VKcmlVT016?=
 =?utf-8?B?d3h6Uk5kaEYxaDM5R1pTU2F3SWNzSlVrcDlMMW15UHp6bVpxSzRYeSt1VEFS?=
 =?utf-8?B?TU41QURnTDVCU1cvd0JKMlV5MDJySG1PTHFaNFBvdmVpQm5jZGgvSnJwKytw?=
 =?utf-8?B?V3ZJa3lCa2U0RDZ5YUQ1dkRldFVSR0tMUUptTW1xU1d5YWMxRHdmS0xHMjIw?=
 =?utf-8?B?M00rZ2MzMGhwMkhTYWt4cEQ3R2dxeUlhYmIzQXhvekdORUFxWHdOWjBRUkp4?=
 =?utf-8?B?M2RNVU1WUHprWC90Y2tGYndGRndHYkFHenVkYTUrYklrL0QwTk5JRlRsaHZx?=
 =?utf-8?B?QmhPYk1HeXFNWHNreXVOaU9XQmp5a0JkdmxLZVJJTXJLQTA4RnFjSjFIZ0p4?=
 =?utf-8?B?UmxSWW1OS2s4b1FpNWg5M2RTUmtYc1dsWTdEU0k4Z1dhTFdualdsUkRoZXc4?=
 =?utf-8?B?VW92bmgwVjRuRElGcW5INk5aeWZXSFZHYVN4cVM2bEpPMG1BOGNhYms0TGxF?=
 =?utf-8?B?WnArSWE5K3RoTDd6WEpjeEhLM2RxTHVrQWNDY3RlbFJmZUpadHBzS2tTRytu?=
 =?utf-8?B?L3dNSDR2VW5ubVV6d3o3bjhTUWQrU05IWHFuUDJuRS82UFViazZnNlVBeUlV?=
 =?utf-8?B?Wm9aWm5ZMzBja1RuR01HMkVjaldUa1gxdWc4blRSTXpmVU44Yk4yQzBMN3JO?=
 =?utf-8?B?eGtEQVlNbEtsK0lYbExkTnVhTG5qcVVtNWRXby9yRWFxU0IzZTRKY2oxMUwz?=
 =?utf-8?B?SGRWWmRKVloxbmpLQWg4UllkUlFyYTlramVxQlErMkZaM1ZOOU5zN2xraXJx?=
 =?utf-8?B?Mk5KZ0JJbkZoU3VFd3FYNXlEY3Vvb0Y1RVNKNkovUDY4OWVLR3I3M01rNGhj?=
 =?utf-8?B?RmpxMWVtOXd5QmVLajlzU1Yvb1FCTU4rdjVHSzBOdU5WQjREQ3RUdko0cERz?=
 =?utf-8?B?RmdZbEFqQjA1a2UrU0VGdlpMZk0xRG5nMXpHaXFqSVk1clVQQmRzUFlQNkZY?=
 =?utf-8?B?RnZERVY5M3djZ3lBaTdvTVE5S2syRmNlZTdrRFp2djAvVG9tdWlaVWZHbHRu?=
 =?utf-8?B?d0Nxc0xYcDg4S0RXK05jeUhlMVQ4MmkxYjEwYmxTcnNHMDRNME9aVkxPSDdZ?=
 =?utf-8?B?Y2NMUEdiZmw4a2hadlFLT1lveXJGVU5uU0hJWWNxMW9Sdm5QU2NDdmM0ajBm?=
 =?utf-8?B?L1k3VTBMd3JSVlVRK3I0RUJvc0ZJTDRMWTJRYXcyK1BGYUc3eFE5RHVNUGhv?=
 =?utf-8?B?ZTJOWnRsdnA1eGJsUVF1cmZpMXFlOC9JalpzRjIvRGVuM0w0YW1LMlpSdkNT?=
 =?utf-8?B?b3VtS2taUnYwOFVzUE5oRi9YNG5maGsvUCtTMmZKMVVPOS9hZGk2WHF0OXAv?=
 =?utf-8?B?dVpqbXgrNVVnQnJvYkZ5RTZRWHdyWkVRRWFOeUc1MXhYaVBMUWlvd09ndlFn?=
 =?utf-8?B?TE9SekJ1SW1peXdYNHFDTkNtekllSDRNbUZaWGxYeEw5Wk0yd3d5eldZcmNT?=
 =?utf-8?B?U1UzUUZ1bmFISXY0TDRKbVp0bHBpZEtjcjZvTnBjOGx3NmlYU3hKWmVJaTNx?=
 =?utf-8?B?b0ZCaEx1NGlrVEkwV3hCb3VOMkNFTGZ5aUhnOG5EKzZUd3hWanROejMvbXVI?=
 =?utf-8?B?WExEbXhFN2RkYXRzZUJ3V1FiOEhSTk81akpLVmxDaG5UdUlVejcrYnY0bHp3?=
 =?utf-8?B?VU5FREpPYzAxaHdYdlhJcWFYODVyL1dpclk4QXdoWnhtdE9vYWxlWU95Z2tK?=
 =?utf-8?B?NzlRYlVGMEhMamZnZ0haUUFwVzBmbk5taDBXNUNlT1VOc1p2d1YvNXN6blZC?=
 =?utf-8?B?YWdlYWxBbXEvZE9Lbm5Nbkl0RlhyZ1B2bWhaeGFVdU4zR1o2MlZrTm9leFFq?=
 =?utf-8?Q?nSg1BFY+VEcDBesdgkFGkUwqG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02402b77-f014-4cf8-6235-08de08280ffe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:08:49.7322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6t01G0JQnsbNUoodffmZHszCeaQ5QKEDTSqdXFDSkuiIJSTUlvxjyyoWRWC/Ipu40RQZhfZR0ZnnKjNlGDsqzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9231



On 10/10/2025 7:00 PM, Tom Lendacky wrote:
> On 10/10/25 01:51, Raju Rangoju wrote:
>> During interface toggle operations (ifdown/ifup), the driver currently
>> resets the local helper variable 'phy_link' to -1. This causes the link
>> state machine to incorrectly interpret the state as a link change event,
>> resulting in spurious "Link is down" messages being logged when the
>> interface is brought back up.
>>
>> Preserve the phy_link state across interface toggles to avoid treating
>> the -1 sentinel value as a legitimate link state transition.
>>
>> Fixes: 88131a812b16 ("amd-xgbe: Perform phy connect/disconnect at dev open/stop")
> 
> Did this always happen, that is, did this behavior exist before the recent
> changes to detect short drops in the phy link status? 

Yes, this behavior exist before the recent changes to detect short drops.

> If it didn't exist
> prior to those changes, then the Fixes: needs to be against that recent
> change, possibly limiting the amount of backporting required into stable
> kernels.
> 
> Thanks,
> Tom
> 
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 1 -
>>   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 1 +
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> index f0989aa01855..4dc631af7933 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
>> @@ -1080,7 +1080,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
>>   
>>   static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
>>   {
>> -	pdata->phy_link = -1;
>>   	pdata->phy_speed = SPEED_UNKNOWN;
>>   
>>   	return pdata->phy_if.phy_reset(pdata);
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> index 1a37ec45e650..7675bb98f029 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
>> @@ -1555,6 +1555,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
>>   		pdata->phy.duplex = DUPLEX_FULL;
>>   	}
>>   
>> +	pdata->phy_link = 0;
>>   	pdata->phy.link = 0;
>>   
>>   	pdata->phy.pause_autoneg = pdata->pause_autoneg;
> 


