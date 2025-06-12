Return-Path: <netdev+bounces-196914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972E6AD6DF8
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E91C3B2921
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC9C22E3FC;
	Thu, 12 Jun 2025 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfrRvSLa"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2D23A58B
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724364; cv=fail; b=aiJE3E4Vew2lpVy/BkRwa+D1Ld+sEx1iNItn68sDGCePBDuUyR7s/7QOFteZy7iQeecLdGlvz5kK2TQAtJtlk97Mnz2K2/4Y11dPtINhx7diYXshDpzYleSE8sCvwnT1+rdcxbou1bZNKU6QUwwgL3HQlKhsJWPZtzYXHJUP3uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724364; c=relaxed/simple;
	bh=lpdwggubDljjyWayLjSkhrzA2yKoAING/K4woCYdvVg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UfZ5G7B97SQVXPOhzopnA+16p9Z3NBfMDj4quh/5RS745d+ON0iA69ciVITC5Atyjb0wSwW/DSJIwOkOQDt6otquFPVyiJSN1+R5zcQ0e72wb7kBoT3G1rOEdTjchTfI5F8rf6g3INF2dUpORXTxRaBioJVlld6r16qPhB3PiQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfrRvSLa; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3UwPj71LXQRRiuFY6oIZrM0aaRtKDE3LwnfKpw62zRVuoP4OvBjrXF3l0mNShsC1FzzUBfIzjX7os18SqPmpFSf8dj5/O8he8qbUoTRfY13uWh49nTLGGDoWng+Jb9jXkSZs6r/6BRIm79Fswfo4r2wIdqseA5ZBoijwla5zPEG1Cf1nZzSxCLy9MkTkcz2z34wZqn1sZQ2pWIAIKW/2/jWd4Vx9cT6xpdMf3zf2bf20j0ILHMuwcLHN7KMtYRpPMsboMX8gNc8CX4l0huUmi/g2xzPN408OJRF11wzLTRdfHjjCxZHhw5TRKKHCttdHBHd9YK2NQV2aXvPcNUiYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xssBfi/G4ve5NBxAPHglfEcYRUi67UqxWFG0lkYFVss=;
 b=SYSPkNqSHPdDdmabDg1dHH2LQFyMX8cY8hVofxZEu1b8Z402OMuU4Xhzwfu7mpB09D7LglbbNHtKrmHJCNv6scGf8yd7S67AcV1Lkwjamj/tcDA0vcD+eSriqdVe0VD+9HNGUb9lgv+9Ck4kZrYOCFggPXTMXnE2WnvdvIJSWt/W2MlghA2I6M7RlKvRFiz0+y21rEwJVh7RfBhBXe7eD6YWRBEZ/f3ZsS2YnTbUqYeIV9cfqE7D/grMNAfIxlnIH3w+nwGWSadl4kGxd+7Eh7sSqSS4Ia54IPb1j+cgERwVZ8S2QvX0vsR8joowYz/fyZ6luO/l9NP8gpHm4+GdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xssBfi/G4ve5NBxAPHglfEcYRUi67UqxWFG0lkYFVss=;
 b=XfrRvSLahRKhB9Om5B07ffSu4UrRqYjP27eyotyZBklQjFTyhjoTqkPWoEAcYN/QB/gluwnXrKqiQprLJVlc7j/hHtyAI+qE9RJWpQVwfSH3b51mL39eAK8mzviHm9OTYbd1guF0+5YernoelBtWtEH0TBjrvj6mIU43M0dA/jCmtFzbrqHjhjUcgdN5H6OqQ8Spc8sE0u2nWhebAXbOqJMxFWFHQK5oDdw/X4ScREpbLuNOL1g2QhIWffAeYVdFZmQTs1GerSGpUWuljFi+/l9BKvezJ/OiLEGuVysOtwdO+06kTMZJUwfk/C2OhqUhRmBaaHklBEeRJzhDAlhLMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 12 Jun
 2025 10:32:39 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8792.034; Thu, 12 Jun 2025
 10:32:39 +0000
Message-ID: <611fe2fd-d826-4ffb-9f5b-5eb7ba99ae62@nvidia.com>
Date: Thu, 12 Jun 2025 13:32:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: vlan: Replace BUG() with WARN_ON_ONCE()
 in vlan_dev_* stubs
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
 Alex Lazar <alazar@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20250610072611.1647593-1-gal@nvidia.com>
 <20250610072611.1647593-2-gal@nvidia.com>
 <20250611171540.27715f36@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250611171540.27715f36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0006.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::16) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7e0899-a5fd-463e-9f88-08dda99c7471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG5hdEhyeXpYdVUrRVFqNnh1RHZPTWN1cGtqR3BNZHdDS28xcUtjT1QrTUVJ?=
 =?utf-8?B?UFJwbHh6ZkR2YmNiL3drT012ZDMrUkNmVHJvaFVlckV5SnFqU1hTeVljSVFR?=
 =?utf-8?B?WjZob053RmRYRmhubmNsZy9HNEF4N0Nya0FxYVB0VGRaSi9iUkFxdkpCWjY2?=
 =?utf-8?B?NXhOR1FHWm01V1NiNk9BbzU1VG9YbnYzQ0JOYUpCZStSbXR5ZkhaalcvekRI?=
 =?utf-8?B?NzJlWmN4RW9ld2IyeGpyS1BuWG0xYVRmQzZBWlBWaDQvWEZMZGxTRkNMNGZI?=
 =?utf-8?B?SmNnNzhPbnR2NEJOalhXQ3F2eHdpNjR1a3FDYTZwNnRiUHZoak1lMmE5YUFC?=
 =?utf-8?B?TTRxNitpVzhLSTBZN0Z3NDJ3cEVmd3lqZVBOcVpsK29XVzMzZ0hxSTBodHEv?=
 =?utf-8?B?RWUwV0NEak42UnYxTU0yUnVEMUNjK01WeS9DTzRkRkVBV3ZIa3ErdFNLcTVo?=
 =?utf-8?B?QmF3eUt5VkFHV0tmQ0FQRE84NUl1NFlxZkRYMFM1cngwTmZTSXdGQ2Q4dEVC?=
 =?utf-8?B?bWl0TFQyK1RoblZob3laTXA3cVFLemVvTjl2QU5uV1dENVkwWllDSTVHRS9k?=
 =?utf-8?B?bTh0MEV0R1RqTjY1Q2Ewd3E0aXZKb1dTd2lDTFRRalFoZkJFdFJxT1RFR202?=
 =?utf-8?B?WkZiakY3eGdSTFUxMEpmV0RpcXhXK1ZaMFhPTGxSL1E0dEJrVmdqVmdxTndz?=
 =?utf-8?B?eWRQSHEyU2dFYVRscFZQSFVEeFpIQ1hqVkI2TFQ5Z0VHMi9QYlY5REZhbG1r?=
 =?utf-8?B?b2RqK2dUZC9maHRJbXpkWmg0UTRtYnlMdkYrNk9DZ3pxSzFsV3kxbWdiNnk4?=
 =?utf-8?B?cDQ3TGF5L04xdEF4NkxKWXhyRXkyUDhWK0ZJRExMaTVTL2ZrTGZ1RDRJV3dT?=
 =?utf-8?B?QUsvVjl6NnNRVldIV2xhRXNYK1JkVHNnTkpZZnVpN04zYk96UStadDNjeWpO?=
 =?utf-8?B?RGV6SXpEMms1a3lsSFNrMG5NSGFweGkzdVREUzYvNVFkbzZYclJVMWNHbEt0?=
 =?utf-8?B?TDNWSHF1WG1Lb2F2UnR0QUhMMlRsdFpPRXl1QmU0RzdRcEY1bXVvbFc1WnRQ?=
 =?utf-8?B?TmlBSU8rOHFYL3UvdkZVbVNxbHovU2VBRHpvQ3NUZDNjVzhLK0NPcVlLZmJR?=
 =?utf-8?B?NGQxME11aFZoOUFFbS9Xd21xRkRtZGk2eTJmY0dDcytqOHdnLzhpbDdCL0VV?=
 =?utf-8?B?bG0vL2h6emFEZFF1cXcycTM1RHo2ZzRaVTZEY2g0MENaMzJ1bHpHa3NQWFA5?=
 =?utf-8?B?UThrTElqZk1ZQVNOaTJwZUJHQXZWMDduU1lJWFN1YjcwdzR5aDdaZFZ1QjZ3?=
 =?utf-8?B?ME1RYTNTa081VTRnOVprRVU2Q1pCK3MzTFNjYVN1ckIxbGZEVHhYUTcxTlJq?=
 =?utf-8?B?dUFSelM2NjhjUjZQWUQ3NEI3Q3Fuc1lwNlphZ0FXZUxSN1VDeUxJVlp5eThE?=
 =?utf-8?B?UWF0cGhZazhMSk1XV2xXUE5RS1dsbmEvVEtscEZXYzllNUZqSitIVStQT0JJ?=
 =?utf-8?B?UjZWSW9pNlVWbGQyOWZMa0RVd0NxcVF6S0dlOUFOOVBPSStxWlRibzIwUlR1?=
 =?utf-8?B?cVpWN2pPUllmck90Mmp0Y09SY05GYWV1RUNTQUdobDZEa0FOQnBZZUlhOFBz?=
 =?utf-8?B?bnhMNXJpZGpFcEdrWDRBVlNSL2QxOG53NTlaa3RDVUEzYnMwekpQWEdPczRR?=
 =?utf-8?B?UkE3R1R4bFFTT1kxRjZ2YitQL0VKTGxpMzhEaVJwaXNjbVA3bkRacHpnd2F0?=
 =?utf-8?B?M1BVTmNXU2lBamkyOVRJZDVoVXNFYTlEWExhbm1VZ1h0YVJLOVJPbWlPVHJT?=
 =?utf-8?B?UGN1OVZBWkExQUJoekFwU1o4elVIRXB2TUFtRnU0YzdpS1h3RlA2UDlyNGpX?=
 =?utf-8?B?Y1dpQ0dnTnpyRXNzOEpTNzlKY25xanNPUUtITnpCTXNTUEx3d0YvVG1ud2xJ?=
 =?utf-8?Q?gYQmlBMBRgw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eG5xZmRUNzFQRE5MclF4RjU5UGhnZWVoU1hBQmZaV1pIalNxN0o2VGwzQXBj?=
 =?utf-8?B?UzZ2MTRxUXgxdWZYLy9OQVRreDQxRjNUYzUrdjhXcnV0R1FtZmJLRXRKdlBI?=
 =?utf-8?B?ZE1tbGROR3NHd1Y5RmdBUE5aYnpNdWN6RnZkWjhHSnVyMXRQT09oMnpSMXFT?=
 =?utf-8?B?Wnl4dkt2Um5Ccm1zQzhGNWZ0dGszNTlNTmdyVHBjVUVVTVl4dnhjVER6V1py?=
 =?utf-8?B?ME9oV2t5QXA3VE1SbjdqbzVsMGZsRmpIWjNCbG5zMnYyd1ZRWG4rVlNrUHFE?=
 =?utf-8?B?a01aV3ZWbjZUZEpJTUQ4TVhUZ2R1YmJEbHcrSHBqQ3pVMnhJc3F4enJZcWx3?=
 =?utf-8?B?REZWdTdHUkg0ZWVzbm1sSzdSUzFjNmhHbThqMHV2eXpyNkNNbkZMWmwxT28y?=
 =?utf-8?B?NkdNWFB1L0tNeGFMYU1KTmtyZVdzTmJGSkx3TXBWNzA1a0xKZXM0WjNnSzUr?=
 =?utf-8?B?UlN6dk1IZ0ExYkpjK1ZvWkdzZmlleVJKWml0ZXpPaHIxL3RDQnNzV3VVMk5O?=
 =?utf-8?B?SEhqZ2VJbFRVRnlXRDliZzV6OUtaN1Y1bU8xQk5FUHpXTzRvcnFXbWM3MG5Q?=
 =?utf-8?B?OTdlYjc5NzRnTTNPR3pocGVXSWlDVlZRRThSK3RudjJHU09NN1pVa2I5WXcz?=
 =?utf-8?B?ZmZNUlVUTDZ6Z3RqRk4vMlE1aVBSUHB5VHJXOERPYjVMeWVnT1VGWlVtWXdJ?=
 =?utf-8?B?UVVPMUl5Q1p0dmNCV0ZFNzRQU05taE9sWEgxYXBNU09MOGpJdTdsUDJRS3Z0?=
 =?utf-8?B?T1NNVWUxTWo2cERmV01aS2xMQ1UwTHRNaGZnY3JYTzZTU0Q2c2JWS3VFTVpZ?=
 =?utf-8?B?Q05LNExrblNicDlmN1VTWXZ0a3RFVkRtSGVwV1JXckMwQm1ndVNKSmlkUENR?=
 =?utf-8?B?THgwaUY2a1lpZk9NQjZIbWU5SDR1R0RpUmU4UTlUbGlTVWcvcnd5RkFuOGpy?=
 =?utf-8?B?aW5MZ0Zjd2ZzSzFQaDYzMTUxMVdaVnhvaFo0Nnd4amh0eW5SdXQvc1IvN1la?=
 =?utf-8?B?ZXNQK2wwVVVPdWJpMzM0ZWx5QTExbTNRcFNzblM1RVhwem90VW9ZemhBeW1m?=
 =?utf-8?B?QmkrcWYwNmtwYjJJM0xTSlF5OVNqaVdvdWZMbVVoVDR4YklQZzF3MTQvSTBr?=
 =?utf-8?B?cWh3bjlPQ3pwZnVpZjNGS1hOSXhZb2JtYncxTWd4MFJ3SVRMSXBZT2gva25u?=
 =?utf-8?B?N2M1WjV4d25iR2VwcnErdW41cG1IWmQyMGVyMnJLMER4aHZYdnJhWGs3Q1hO?=
 =?utf-8?B?M29FZDVtYWh3YlREOXFFb3cxM1RtSTFSUDNzYzgveThodHNHeEM5VkpSUDlV?=
 =?utf-8?B?WlFMQlpHeWo0cmUrMHUzRUdhZHFaYm14dERacGdvSUkyYWp1dWRMQTZIUDA5?=
 =?utf-8?B?a3g4SWQ4OVk4eHFMcEdCeUJ0a05vd1JydzlaOUdRWnJqZTFFSDVqSXovT0pq?=
 =?utf-8?B?VDNZSVkyb3BMUjRaU0xtdjFqZHk1aThTblRKSlVkbUthQWl0cGJTZEx1Y0xj?=
 =?utf-8?B?RTdTQ2lhQ3RTZXMxckRqb0hxd3hwNzZSKzZ6clkvU3NkSFRxdVBJNkFpZU1a?=
 =?utf-8?B?VjJZdzVnYWpPMC9MbFBkNDNLZXBQUHBjcWtYVllwUENuY3lhc01xei9kNVFq?=
 =?utf-8?B?MjNXcTVWZnZLZ3BYVkFwYStkbDdpenAwUDg5bXM2WjZmUGMzQVpvMHI4cysw?=
 =?utf-8?B?YWxHL29xR3h1VEpoRTFiVkNHSk5zS0lCQ2hqNWZnQjUyMGhTS3dyOStJV01q?=
 =?utf-8?B?YXZSVVdDQ3RiWTVzZDBtK3J0dy9FekI1ODA0cmY1OSsxMFJHUlg0c0UwMzZk?=
 =?utf-8?B?U2NFME10WUdGMVA0VTB4dDg5eldNVjB6bk5zbHJqb0lid1V6RlR2TTREWnR4?=
 =?utf-8?B?OUl4Sm9HSUFqaTIwWVcrcjlFVzRaSkxLSmFSS0hEOGtpbGF6MzhzVVpYRlZt?=
 =?utf-8?B?Z1ZzUVRCNHVQV05NVnRpNFlFbmF4RzVORHhXcE5VRDVpaEpETE53a21QQkl0?=
 =?utf-8?B?cVBjVlpPdEtsbjJ2L1pvaTgyT3VpQTJEaEdsRWNVdUpUMUR4SEpLQ3BRVVlh?=
 =?utf-8?B?RUJjTzI1T3I0T3ZwejdnVCtHRnJkK0d5MEFMUnB3Slk1NHN0Y3hRUGkzc0Yz?=
 =?utf-8?Q?gJpJvXPEe1fgiwfpbG6Km9rqG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7e0899-a5fd-463e-9f88-08dda99c7471
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 10:32:39.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHCPTM2t1vWT/HmO/rv3z2/tHE83gLAj+Qmegw7bKYzp8CAj4IGA96QVN2lXX9dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888

On 12/06/2025 3:15, Jakub Kicinski wrote:
> On Tue, 10 Jun 2025 10:26:10 +0300 Gal Pressman wrote:
>> This code should not be reached, as callers of these functions should
>> always check for is_vlan_dev() first, but the usage of BUG() is not
>> recommended, replace it with WARN_ON() instead.
> 
> Did you try something along the lines of:
> 
> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
> index 38456b42cdb5..f24af2988fd9 100644
> --- a/include/linux/if_vlan.h
> +++ b/include/linux/if_vlan.h
> @@ -81,7 +81,8 @@ extern void vlan_ioctl_set(int (*hook)(struct net *, void __user *));
>  
>  static inline bool is_vlan_dev(const struct net_device *dev)
>  {
> -        return dev->priv_flags & IFF_802_1Q_VLAN;
> +        return IS_ENABLED(CONFIG_VLAN_8021Q) &&
> +               dev->priv_flags & IFF_802_1Q_VLAN;
>  }
>  
>  #define skb_vlan_tag_present(__skb)    (!!(__skb)->vlan_all)
> 
> 
> This should let the compiler eliminate the dead code completely,
> assuming it truly dead. We can still replace the BUG()s as 
> a of cleanup but I think the above is strictly preferable as 
> a solution to your problem?

Makes sense.

If we're going in this direction, maybe just provide a stub
is_vlan_dev() for the !IS_ENABLED case?

