Return-Path: <netdev+bounces-127449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E49975743
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 17:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A75B1F22321
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176141A3044;
	Wed, 11 Sep 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iV6vfjmS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D178193099;
	Wed, 11 Sep 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069013; cv=fail; b=aeqF+O3d3jcGP/xj87cVv8Mp/hnAnAcI+k251ULTeNTlxc5yKZkOV3hWwyNA2Qjt4y/mN/E/nPq/vhzcT9THn2D8TPF/uY6/9/DZ6lXrkdq57wecL4GItIGN5U6UYrAlkXeIVsl6Gposnq6NqwQ/jNFFqGYle6n5ghorPtt5seM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069013; c=relaxed/simple;
	bh=o3eQiaqVmnByz0NiAaEjd2OfgyeIzJ/7NtzbB1llRmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ViBFjkEufZM74c+SC8NUlW/pItMvdDHfirJU7FXMnbBQzgC8fJmUuvzoff+6eWI0RQRh/xb//Ajc80uAF8a6i+O72jWq408S7NK1Y4iW2gur4bR6WNQKaiN0PagS/klPOFLvYOl+nCailgMhQMlfmzwqOlgynCfY+tFHrkvRTqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iV6vfjmS; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrummik1bfob7ruy2TZdSV4/js/57pkTYBCTR0/uya8ks9VCPMPQKlC5Pqne/5skLjJDXJrukyeWJa32F5AqWfKCfn4iaOONXhGvJxkRNkXnTxvcJ4YHqVYuPZ58RkIpgQheOCTKPCNHuPe/eff3drasYchlw1rIZ2KSnU2iaoPpQmgosHDLdweksh74iQghJNU4/FuMIzbtMxWpCFkjfln/WsihQnhHZMcoc4pjwnu6ZOrYZhUjZUxbeOd+Ci60IGC3tcmEvbxnGnjwXRc1ZApxYNtTWsewiGkjwPPJCo3qvXaMnhnY6a1DT1GX5qo+xQ2yZ4EE7JO0fiOAr+5P3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE+z43A2IpL0IVTLxJ4w8laSbNadIBiCVpXAi/6GJXE=;
 b=g6QRlolufUCGk62FAGRcjYSPnxHq7/2oP1VFsliKwaPrPCXOX7BM651EgZDfR7Ebq2YPtRxDNjKZJV5fg6fWQKnUHchEzwnA6lMp0Ltv04lpIMYd6MzpC0hKGws4cRkXNt9ZmnsbhVK6AfPZV8pyxyR+YlfEVMMth6/qy19uP1phenWfmDrq9XwN5Jt9RGaqoo57vKYa7qKiCiBS5RzKNlJPR0Gwv7/B52oP02CjzVfNWPMRLrYvBKSye9scntJNNuvv5ZH+1UzOq7Ns0kaN3n5qFzw7p+lEZ5+ZZ6584PDzz4dcETL/mswfjKdgNx65/JaQOMDxoWzQ2GXsxbdUAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE+z43A2IpL0IVTLxJ4w8laSbNadIBiCVpXAi/6GJXE=;
 b=iV6vfjmS2Nhso8znfk6BXNZlUIRpSvCDM2SnrpFPqv/Vp3/VkM9jQ+7CcLLe0jlhBoutJdq2YAvgS6/XhlO6Y2fFwEkhiHNs/4BSwNEEa9vCkQhsdDRtGEbX+Kk37e6uWSryxsmc/uMoxj0BeqGrb/c2yFa0YwAL6yn6EGTHayE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 15:36:45 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 15:36:45 +0000
Message-ID: <a5939151-adc6-4385-9072-ce4ff57bf67f@amd.com>
Date: Wed, 11 Sep 2024 08:36:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] bnxt_en: add support for rx-copybreak
 ethtool command
To: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, corbet@lwn.net,
 michael.chan@broadcom.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, andrew@lunn.ch,
 hkallweit1@gmail.com, kory.maincent@bootlin.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 maxime.chevallier@bootlin.com, danieller@nvidia.com,
 aleksander.lobakin@intel.com
References: <20240911145555.318605-1-ap420073@gmail.com>
 <20240911145555.318605-2-ap420073@gmail.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240911145555.318605-2-ap420073@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0385.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::30) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea5ed70-6c71-4439-5b50-08dcd2778ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzExU0MzdS9hVmo2bEpOaCtpdnU3UXlWMkEwdXNOWVFKcWpnU280QlBIOXNx?=
 =?utf-8?B?Q0lvVXRTMDFtM1JqaWlEMXV3eHdYaDd5NkhGRGIwUVMwU1V1SkxmWitBaEVp?=
 =?utf-8?B?TE9Kem8zOTUvcXBFdzNTSm9DdGpINVJRdXdsZWxmZDNOQ25ZSUUrbm9EV3N5?=
 =?utf-8?B?QnN2ckFxMEcyTzZzS3JoblhQVHNtQnZqU1ZvN2tyeXVzTkQzdWFWN0dCWE5K?=
 =?utf-8?B?U2JIME1Kc01iT2dsOHBOKzg0OGJPS1RNYnlUM0tvdmZvRHltaUM4T1pkLzFP?=
 =?utf-8?B?QUtTb25aMG1sZzFycktEOXJlMjFTbk02c3V3QVBWb0JIQklvM1JFYTEvUUhF?=
 =?utf-8?B?ZzlsNFdyU3pGL29wRy9GaGQ4WExxdlhTM2ZJUWVoeTFFMmNWczlwUHhyR3Jp?=
 =?utf-8?B?eGRKemNZa2FLc29ZOFY0VmIzVjlVVzVZSWFKZHlKODAzZHdmYUZYTmN5bnBx?=
 =?utf-8?B?UWtXbmxpWm9JTXJoYU4veVorRDliT0R0U1BqZVozb0EzQ0Q4TjA4RktwMEhU?=
 =?utf-8?B?QVdKNks0RXhidmx5YXREb3o5SGl6eE5IWXFjN1RsS1FiVGVTU0N4d25IaVZk?=
 =?utf-8?B?YUlQdjZVYitEVHRDejVBTTl2Y1FvU05BOHo2RFlrWGJ3NE5wSHVGRml2YmlT?=
 =?utf-8?B?dGhPekJCdkNJZEZsalhWUng2Q1VSU2hLVXd2TnpmQmU4eDVDeGJvYmdVK1pX?=
 =?utf-8?B?bTNaMTg1TGtMS25xWWtoTUhhbjhwa0FYb01KeVN5VXJ6eUFHc3FKaGluY096?=
 =?utf-8?B?NWxQS0lCWWJiVkFoNlZ6V0t0M2doSjlIRDNxVTRvWFFLWjNvM0NnNllnNDdK?=
 =?utf-8?B?a2x5dnVVQ3BIUkd1MDEyK1NUcEJVZXZFRDZLUkFJUFVkQU15aGlnbmJiNlZI?=
 =?utf-8?B?aXQvL1pFMmh2aXhRbVFhbzc3NTMvUlRzd3g4VDhiSnRkR0NkaHgxWFVBZ2s2?=
 =?utf-8?B?RWRWREtwTTl1MkNBQlFEaHdtMEtKMGJSaDdNSzN6Z1diNWI1UHRhd25DRnJ5?=
 =?utf-8?B?YkZ0WU5NOGY3eWJxMW45TTNtTG5JVzRrNmwyYmdDWDUwbFlCT3g0ZWZ6cVRn?=
 =?utf-8?B?WGRqeE0vUm5BVVhBWHV5Wm5qblpOTVNCNXpPSFBxTlowc2tYdEsweXViYnRZ?=
 =?utf-8?B?Z3hiN0xBWHRXVW1CRHJidlZndDJ4WWFIc3d6YklVaWlPNUVlNGp1bndUN3dW?=
 =?utf-8?B?UVBHRk5BWTJ4MC9aZVlyTU00QUJEeS9UMUQ0WGttQXZLdnlHcEFaendxZHhq?=
 =?utf-8?B?V1dFQVBsdEIvSXN5N0tlYmF6OGNWL1F5Y2xFSG90WmlBQ0pyeEM2OGJXRUht?=
 =?utf-8?B?RDBVZDNWdFNvTHoxK1ZWT2R3R0c0d1ZCT2tvRmF3MHdYUE02N1NscjQ0bldE?=
 =?utf-8?B?SURIU2ZOM0RSTTVQZ0RSSzR3SHhSajRUZXkzVTAwSzVVV0g0cEF5c2JrTFpa?=
 =?utf-8?B?WmlHV0Z4OWpQeDRxa0o3VjNBYUVrc1NVRXlDMzZsbXFOOHFQWGFVYnZFenha?=
 =?utf-8?B?MG1LYzk3TXIzQ243WGM1Zm03SE42K09YWXN3MkxKMW5SeEJ4aVJ2OEFNSXpT?=
 =?utf-8?B?ZDg0Ym5QbXNYUUR3c1lBYkZrZldvRXRlRDVZN2MwRGhGUFFGWVNhZm9rcmZ6?=
 =?utf-8?B?VXBUYUN5Q2hZT2x6aWYwVXdIak56WXJ5U1ZYU0FLRmZTOUZFaEJZSDRFQ3JI?=
 =?utf-8?B?WXFMTDUwWk1ZWndBY2VJa2R3bGR1N2lvMDd4Nzd6RXBmVnZrR21nNDIzaGtH?=
 =?utf-8?B?Uit4UlR1dXo5K1JjS3BTWVVKdTY2ZXlubEpQSDlnTnJaNHVQWFVLMUxINVN0?=
 =?utf-8?B?VWQ4TkdEQ3REb2l0UWZlQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZ4QUlEVXFLcSt6WlBVMm9nOHArRzVRTGdBazJTV3NBRmM0ZDNNTXQ0R25O?=
 =?utf-8?B?aWZkTmk5YktXeTZaWUdxLzNQc21vVCtHTkJZSngwVCtUT3JjKzI3Z3dHalZE?=
 =?utf-8?B?QXVGRWpoWHJpVHJRZHBrRmUzZ3c3TGM5VDBaWXZ0N2JSNi9vMDFlRlorOXlM?=
 =?utf-8?B?RXFrSmxqYkpyanIvalozaVZtMW1CakFLN25Udm95UUZabFpXdlgzNjhLNm1S?=
 =?utf-8?B?NjhrQmJFOXlwUXdLd2ozb21laC95RzJJMnFFWTVGckgrNUF5aksxV3hySU1Y?=
 =?utf-8?B?ZVkzbGVjOEc1R2xEc05pUnBBMmN4RDZwUktlU0pCdll0M0pYakNGZTNBN3Js?=
 =?utf-8?B?WExkdFVrbG9wSFZyUXQ1QndCdjV4dGZNVWdDcU95emdsdlRsekUvMDRra2tk?=
 =?utf-8?B?ZjJrMEJsbmJnZXpsU0k2UkhGbGU3WkpLclJ5ZjF2ME4rWGREQlJwUmxNdUIz?=
 =?utf-8?B?c3NtK3FoalFOaGRNYWJidFk0KzZkbUVRbitMNnNtWEd1WkNsUDMwWHpGT0ho?=
 =?utf-8?B?NjlxYWpwSXdyaHlEQk0xUFVUUm1nak5WU29tTUZjcDl4L3FZNDBBT1cxRWMy?=
 =?utf-8?B?WVpwOVBvTVRZcEc3cFRPV2ZyOUcvbXprZmw2bENJempwbVdmTGpsWnUzOEJL?=
 =?utf-8?B?ZlhraE9iM2NnWC93Y3hUVGRzOGdTVUVoekpIRkw3RDRDZzJieUJYdS9LSlVx?=
 =?utf-8?B?aWNtZ1ZzbjJtT2oyNk9pOGpMbVpXMzdGNjNta1JRcjIyRFJJcTloZGFyMi84?=
 =?utf-8?B?M2N2aUdBdFo5c3d2bStrZEtVemZRcW9OeWN5MmJpbHc5ZHgrUlVhQ0tUL21q?=
 =?utf-8?B?c3JsTkdodjJTam0wR2VLdWRNN3ZHZXI3dkc3elN1Vi9Oa2p4Rm0zaUdvRGJn?=
 =?utf-8?B?WGpNMXFidU9DMDJWVmZtQTVJZlU3VkhJbzlIMXBoNE1PVGFTV2NpYTg1R1Z3?=
 =?utf-8?B?WEpIbVZ2YjJsaytYMTc1Yy85Y1hWa0Ribm5UWW16RmplMnMyNW4xQTlmZ0s5?=
 =?utf-8?B?VDh6TEVENGJOMWovZVhnRlpzRVh0dG01N1dhYUkzeG1zK2ZhWXdqaVNoZ3l0?=
 =?utf-8?B?L2xPaW1ZdklobzZOa3FJTGNFT25PUVRIUGswcFRtMFdwK2hGMGJmOTVBRWFE?=
 =?utf-8?B?T2VLT2tPUjVpTmQ5SE81ODNBa1RWaUpHUFptNytqYXNBblliRjhHTzhnNVZX?=
 =?utf-8?B?Y2gxWkNDWWxtTjdwZW9ZalArRk1mSE02RzdlYjVPcWRROThaZXQ1aVdMWWRk?=
 =?utf-8?B?VVB6QXZBQ2huL1V1d3RNMVY4OEw5YjVQNGNUYVpMY0JlUUFCY2YzMSt6citQ?=
 =?utf-8?B?ZGxiTTRLbVF2SFdMNUFZd0dEQ2lzYW51YnlGdXZHM3JyUEdScXZKcEpieUNi?=
 =?utf-8?B?YnAvRHNSeUVnV21IRlBSc0FFM202VnVtd2h2Skw5a0tnT1VQbi8yMm43Znk3?=
 =?utf-8?B?ZjdRalk4K0lvc1VaTDRnOTZWWm9NeGZEV1dxb1RiWklRbDVJam5SSlBtZjJW?=
 =?utf-8?B?MnNlQ1U3U0hJTXdydEdmazJnRDFFVnVCWGNIenJlcUJYZDZHaVFEVTFPL2di?=
 =?utf-8?B?dk55OEFKT3Q3bWR1OFlOQnhndUJZQnpvLzNqcEdJTUZtSVY1aktjRmx0clFM?=
 =?utf-8?B?Zms4aTE0aURaMit5ZFhBOVAvSzF5L1E1clRkbTNRY0MwTGRRZVl4QzBMVHBi?=
 =?utf-8?B?andxaDc4cTJiUzN0M2VmOHh0cWM4UXVRRmRtSGlSRmZ5UEJjSjB3QmxIdVE4?=
 =?utf-8?B?dlg1SXVjZlpwL3ovOGN6TFNvZmZaZ3lXSlFVTkpLM2d3MXBHYzVyVTBWNEs4?=
 =?utf-8?B?cmtqUlM3emVwWDJtR1JzYzZvR2l3QU1GQnBqOHNIZUU0dGlkbUxGMVJ3enpP?=
 =?utf-8?B?dk1PZzg4di9ucnR4L21ac3Z3VUViTVAzLzJqZTBDL01ZOEdDZ01kMzNiWDk5?=
 =?utf-8?B?N1FNQVNnQzZDQXlveHJuTlFPcm56OXR4d1NGbWF4MStsTEVybW4rL28rVFJh?=
 =?utf-8?B?Wno5bis3Wk0wZGU3MlhkYmE3SGlmd0lHNzF6dlRDRjc2RVMwQldLS1pIOTFk?=
 =?utf-8?B?L0V2bHpYQ3NTZW4zVlg3N1E3WDAzSjhhTXZMS3VEN2MvOGRubmgxSEpYb25y?=
 =?utf-8?Q?+y9EkvV3o+HOqSY6vxwT23XQl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea5ed70-6c71-4439-5b50-08dcd2778ad6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:36:45.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5Lom5ZkBeZHLpRAtg1vZlovpSx3xupHKUgYJGGuSt669ncHFyXWHXfvp+y7One9hmLSQ6zzYXYTSXDfBufPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601



On 9/11/2024 7:55 AM, Taehee Yoo wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> userspace. Only the default value(256) has worked.
> This patch makes the bnxt_en driver support following command.
> `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> `ethtool --get-tunable <devname> rx-copybreak`.
> 
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v2:
>   - Define max/vim rx_copybreak value.
> 
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 24 ++++++----
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++-
>   .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 47 ++++++++++++++++++-
>   3 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

<snip>

> +static void bnxt_init_ring_params(struct bnxt *bp)
> +{
> +       bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
> +}
> +
>   /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
>    * be set on entry.
>    */
> @@ -4465,7 +4470,6 @@ void bnxt_set_ring_params(struct bnxt *bp)
>          rx_space = rx_size + ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) +
>                  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> 
> -       bp->rx_copy_thresh = BNXT_RX_COPY_THRESH;
>          ring_size = bp->rx_ring_size;
>          bp->rx_agg_ring_size = 0;
>          bp->rx_agg_nr_pages = 0;
> @@ -4510,7 +4514,8 @@ void bnxt_set_ring_params(struct bnxt *bp)
>                                    ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
>                                    SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>                  } else {
> -                       rx_size = SKB_DATA_ALIGN(BNXT_RX_COPY_THRESH + NET_IP_ALIGN);
> +                       rx_size = SKB_DATA_ALIGN(bp->rx_copybreak +
> +                                                NET_IP_ALIGN);

Tiny nit, but why did you wrap NET_IP_ALIGN to the next line?

>                          rx_space = rx_size + NET_SKB_PAD +
>                                  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>                  }
> @@ -6424,8 +6429,8 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
>                                            VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
>                  req->enables |=
>                          cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
> -               req->jumbo_thresh = cpu_to_le16(bp->rx_copy_thresh);
> -               req->hds_threshold = cpu_to_le16(bp->rx_copy_thresh);
> +               req->jumbo_thresh = cpu_to_le16(bp->rx_copybreak);
> +               req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
>          }
>          req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
>          return hwrm_req_send(bp, req);
> @@ -15864,6 +15869,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>          bnxt_init_l2_fltr_tbl(bp);
>          bnxt_set_rx_skb_mode(bp, false);
>          bnxt_set_tpa_flags(bp);
> +       bnxt_init_ring_params(bp);
>          bnxt_set_ring_params(bp);
>          bnxt_rdma_aux_device_init(bp);
>          rc = bnxt_set_dflt_rings(bp, true);

<snip>

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index f71cc8188b4e..201c3fcba04e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -4319,6 +4319,49 @@ static int bnxt_get_eee(struct net_device *dev, struct ethtool_keee *edata)
>          return 0;
>   }
> 
> +static int bnxt_set_tunable(struct net_device *dev,
> +                           const struct ethtool_tunable *tuna,
> +                           const void *data)
> +{
> +       struct bnxt *bp = netdev_priv(dev);
> +       u32 rx_copybreak;
> +
> +       switch (tuna->id) {
> +       case ETHTOOL_RX_COPYBREAK:
> +               rx_copybreak = *(u32 *)data;
> +               if (rx_copybreak < BNXT_MIN_RX_COPYBREAK ||
> +                   rx_copybreak > BNXT_MAX_RX_COPYBREAK)
> +                       return -EINVAL;
> +               if (rx_copybreak != bp->rx_copybreak) {
> +                       bp->rx_copybreak = rx_copybreak;

Should bp->rx_copybreak get set before closing the interface in the 
netif_running case? Can changing this while traffic is running cause any 
unexpected issues?

I wonder if this would be better/safer?

if (netif_running(dev)) {
	bnxt_close_nic(bp, false, false);
	bp->rx_copybreak = rx_copybreak;
	bnxt_set_ring_params(bp);
	bnxt_open_nic(bp, false, false);
} else {
	bp->rx_copybreak = rx_copybreak;
}

Thanks,

Brett

> +                       if (netif_running(dev)) {
> +                               bnxt_close_nic(bp, false, false);
> +                               bnxt_set_ring_params(bp);
> +                               bnxt_open_nic(bp, false, false);
> +                       }
> +               }
> +               return 0;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +

<snip>

