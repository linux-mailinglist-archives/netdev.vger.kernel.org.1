Return-Path: <netdev+bounces-112110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729EA93514C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CA71F22271
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 17:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58A144D07;
	Thu, 18 Jul 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hWt5hV57"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D7C63A;
	Thu, 18 Jul 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721324533; cv=fail; b=ht34kVPpsRTBrNC+ub7NSMH5pkokxO7rWyEaQj7WvVO5r3ixWumKJXyUTV6s7v6QJFn8k3YGdj9omLURTktJOXb0SgS/dUJcznHJL9TgTXuIlR7wc/w02ytslQ6GzzUjbz9a98fbgNeb7sjqvDH737KD869Fj2D8/b8dPl+zvTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721324533; c=relaxed/simple;
	bh=GS+9cX3HIWsBIIgsAAX0TZsRM4RqrXFSSILh5MvDWTU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XG0eG62XX/fVtnerplnoTAGEndzGZkcX4CmdK0qPg9dbbhQaKh135LkiC+ftdKwc59Y6D6g+GShg2CkchvndIE7wB7PA1A5Wg2X5E8qux9zgxzaEQSwMH1+U/cDw9MkhPwfkqsTLMROv2NtniI8gH0SztrBMHhpiKLn3twKd+5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hWt5hV57; arc=fail smtp.client-ip=40.107.100.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIXjAyllMpyDE7vkU9dsY4BpSYUnZhdZkiBrxn1bpEkDNe9GP/QjaOA79qnGPJa/ZQkYd57iKgzezYvAm1p55iJX4S/evENgVpKVBCfQ8+jFayIzs3eJzgtKKxOl1bCfvHe4VvW8tGddKIX1NYEI6k7JVVvAPmKWl5CFNQb/5QbcfAoUnknbYklFbfGXMXrt/zG5DBL1+VUlnab2qBP0P53pXrgxWkPCm5mIddCcAUUz9xPN5VOmJ0X1ECF9OnqKrLnbcQ+31ORBLcXfW2+eBx/LgWUvZfqWxqWS4YlLxmiBRDLaNj3t684wR32TpHG2i/Ai/mVq207o+8YkA4B8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdg2xGPFEx5LUvrDSzd34yhaIzXER3wfBLrCFlQ67ak=;
 b=r1mUnPT+WVmSUTQfSxGbq3LS9Z5FkPm3N0Da7DUWdNozGWKJJJV8eZTKE926Hs2NItqDuzdg9TEbQXHYaIE/0i4Pngd62RdgnOmclALwD6pZmrAxUXLHc88EpVJ7QzD/VZaUgKrE1KuunDW2pcyXfMJ8EHwY9tiA7RcpZUCfKztRd057I5fOazs99wtDnz9cx3xuml5plxIEg9RZXokF24is8D4/gl6/PpVPYRLgwnMg3Gf64ht0PtjLxi3mWQXl1xDQjQPR7uIlEnw6Xbt48TR6KRhRx6l3l0Cc7mZzfdlpMwRMulXBiD8G66K+mg8HbBdLLOo9DkR0oztS5XHJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdg2xGPFEx5LUvrDSzd34yhaIzXER3wfBLrCFlQ67ak=;
 b=hWt5hV57hJHJ9p4jRhLokx7hkB6bN0ow2uQw+jg73L5wqQ3BDVgVsIwvRWukJNRAFpkikSoxgPcn+ZrCc1lIhUnIHisFm1tB8cVB9/n8vA9DDJSW4LmRWaYAMG21HSmfdrcICZ1QAg+xDo/uyc8yYXRJNTLV6ArxNCOuERjZkucXizjA/M5eZhQNBRPCkKVn2QWOFrOt6BOzE95P4mqgVkoSeVcd5zCs8NU47ru4tuXX4lOGR5mYoEPrRKq9zHuEitE4Z6G7QikPErHE8BADOt5G91E8HWsF+1KQeY00O3CaxPfjDMoGR30x1ey0EU0eiv9hPC55EXV6LbhBKTov7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.14; Thu, 18 Jul 2024 17:42:07 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 17:42:07 +0000
Message-ID: <5e432afa-5a00-46bd-b722-4bf8f875fc39@nvidia.com>
Date: Thu, 18 Jul 2024 18:42:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
 <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
 <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
 <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
 <874f68e3-a5f4-4771-9d40-59d2efbf2693@nvidia.com>
 <CAMRc=MeKdg-MnO_kNkgpwbuSgL0mfAw8HveGFKFwUeNd6379bQ@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAMRc=MeKdg-MnO_kNkgpwbuSgL0mfAw8HveGFKFwUeNd6379bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0292.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fbc04fb-29d9-4fd2-b159-08dca750f199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dEhRWXh3czM2OHdhYzJmNU1QKytmK2RsbkN3ZFZCKzJBZSs5dTFDOGRqZ2cv?=
 =?utf-8?B?S2xsS3pGREFjS013ZTd2RUJRYmZwUDU3UUxibms3Rk9yV2p3QVY2NGV3dE1U?=
 =?utf-8?B?Ty9aQTdpbjd5cUNVZTNtUzNNVUZBZDVuTG55dkJveGZ0a1FsYTFhU0lmTW1Q?=
 =?utf-8?B?d0lHTWpxeWZkVGw3QTR4amFVQWE3NmdPSHJ0VFVGZ1ZlaS9MaGw4eHV2ZXFF?=
 =?utf-8?B?cksyV2ptWVdvSjRhTkZmOFhkTi9tSnd4dEUxZjkvaEpPbmNOV0lIMEV4WHoz?=
 =?utf-8?B?RGtoZ1FZWVMxL3Q5YmdjdGpSbGovcnBxT0R0cWFpNmVWNjQ4UFZhb0VwUnd1?=
 =?utf-8?B?a2VSa0FGYXlPZS81bjZMemU1aDJCL3psRnk5QkJ3NzJrcnVvY2hUTGdxM1hu?=
 =?utf-8?B?aWZyN1BZRUFVUThRTk5HejlRWG1qaFFjcTFRaSs0eWRMZWw2azNaWEE1RGFx?=
 =?utf-8?B?c2hoWnRnSnd0ZFdpT0tlUTZncXdUcmI3NXpIdXBBQzJic1U2SEVBT2Rld3JL?=
 =?utf-8?B?RHJrSmlhWURlZndja1VSZGFBZU9pdHZTYlpRVTVDOXJFV2FWTDZ5SlIxckc1?=
 =?utf-8?B?STZNVzlMTkxrclM4R1FWaE1TYlY0YUNWTFFoeHhWZjNOWW8wb3ZzVk9RZHJ5?=
 =?utf-8?B?bzcwSFVHWGpjaCsyaEljbTl2S3BXckFXb0RyaEhkQnV5VndaTFplU0VuWDJq?=
 =?utf-8?B?R1RrdFkyc2lTTU00b3F2elNMNnE5MDYvdmlSa0hrMXNiMjVrTVJZeDZMeTBT?=
 =?utf-8?B?a1BMMVVQTXJDcG42L3drUXFVWW9VYkRUaHhPOEJSZ0VaQ0JCTjBkK1lOajJ6?=
 =?utf-8?B?Rm9DZDdWNzZzRnk3T0dhN2hJUFZEcy9yY2pGOG8vajJrTXdkSXE2VFdVbE8z?=
 =?utf-8?B?S29yeFhadmVIeEVZV3dQc1RKdlBRVzBTTEgrT21BckJsN08xeEpXeFUvaEJ5?=
 =?utf-8?B?SFBGSS9FUWlKYURFb0VKQlJrbHVTaGpXRVd4R3RDVHpuV0RYWHRFNDh0aS9i?=
 =?utf-8?B?MmxVQjZQek5QaFQ4eE9EUDBWNDNXYk5ZdWFRcDROWEVlWk11SUJQSEFpdVBG?=
 =?utf-8?B?dEJBSWpTYVRpYVV6Y1FKNVR2SXBZamVseDZERlRJdGc5azhlZkxZdUFUTWV1?=
 =?utf-8?B?RFA0TG1FbnR4SmF5dTArRWdBSDdZTXhLRXNMT0FjZmNCbzBDRnZhN3JGa2ZF?=
 =?utf-8?B?ZG9CZW9iRk1MVXJmZHVrV0U5Nnp6aUFTQjAvQXRJWS9WSFJGZUZ3MlVOSDRN?=
 =?utf-8?B?eTZxbkF6TkE3OFV1UkFyM2tTV0MxYUxEVmdLKzgydVBWa3VFaXNkVHg3RFVP?=
 =?utf-8?B?VHZLQVkxS0hFaDNGdVVGcnVlbEpjL0lxNC85SEVrSHY2Ym1LWTAvTzZOSFlt?=
 =?utf-8?B?VGR0cVVScGJURzNjbDROc3VzYWYyb3dzRHlUM2xGQzhEcnE1YlBLL2czU04y?=
 =?utf-8?B?UUx1M3B4Z3UrQXZhbmhacElULy92MWlnR05YYTYrcGVPUlFkcHVtU1lBRDNM?=
 =?utf-8?B?cmNvS2locC9JRThvSU9pUGdpd01Ja3FzZlM5blNMK3ZPajlXMkNtWDdZYjFy?=
 =?utf-8?B?US9MSzlZZUpmTUw1MUZkRGZFcEZoTUxMS0F4Z1pVRUtvaGd2VnZLdlNPTVNo?=
 =?utf-8?B?c0xwK0hBNy9KL2tyNTNKQXgzOGl6TWJHUnVPUlNJR2dQY1RVM2lCNjNSMnRV?=
 =?utf-8?B?ZFA0WStJQVliOHpYWXVMajk5Zkx1WjhHTllqendhZ0l2VWlXSXhPMVc0WUdP?=
 =?utf-8?B?UGtGeENiZmdWd0RlWmVjRnYrQ3NKM3RTMjdyaUFpNGZWeHNta2YzV1JjQlRO?=
 =?utf-8?Q?hSErqKzkOGYQgzBDcCTy7NR87FBdcq5eXNjbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEtrM29URmpJVEgzNGxjenk4MFRvc09qd2tTNzRlZmQ1M2pHazMvK0RSZGRh?=
 =?utf-8?B?R3p3K3Jyd25zVENPb0M3dUNtbi9PZmk2Q0lmdGk2Z0RRUXV6YngvSnFWWVEv?=
 =?utf-8?B?TmVkNGI2V1pGQktxNzY4R3QwcjhBNjU1VVVuVGVqcGZuVXJ6YVp5cmluRmJH?=
 =?utf-8?B?clBVcHVUek1Ra0RsTm5KOE5haXpYNWFLYnYxbVhpNzlNN0FySXBYOVJXVit0?=
 =?utf-8?B?V3lrR0FTQWk5U1dHZHl1WXV0eThuQmRTNGsxcFlRQnlKU21mRXdyeWg2dVVx?=
 =?utf-8?B?WW9UU1p4SkNwMVd3ejBLZ1FBQUhFd0hjL2hqb2hWVmtpZ3JFSm9WUGFtT2xs?=
 =?utf-8?B?bFdocjFURDNRdGx6Nk4wYWpFRVhDbTNsRStVUzZyMHdQKzBrQjYyVTN2Qk1F?=
 =?utf-8?B?bTdGRU5lNkFPNGdJcERuT0RUR1JtelBCZWZhNjJRSUxkdXBMZENzbVR1eEhT?=
 =?utf-8?B?UXYzSWJaWm1KZVNVdmtvMTQydldpQ3dkc0dNUkdySktvdDltd1pGMGhnNXBq?=
 =?utf-8?B?NERMSTFicGJTT3NWaUR6MngxcFB5ZWtEd2dldGQ2cHJ6cWEyQzE0TFYwdnh6?=
 =?utf-8?B?Rmh2ajlmYk1kWUVOUTlHMHJOMGJIdUVaQWZGSWF1L3lVTGZMV2dkZmorbGNs?=
 =?utf-8?B?LzZwYmczVGZwaDVONWpEWE1GTElMSjdGZVNRRk5idFA3R0V6MVVLd1pwaDhR?=
 =?utf-8?B?S0dvTnBZSDVNb3pPWXdzNmZRQk4yMk16QW1GNk9Zd05kTlNPNEZGKyt4L2o5?=
 =?utf-8?B?UllnRVJEb0wzWHJnU09YSnhlbGZOWndUUU9ubFR3SEVLN1p5U21sbG5qdTF4?=
 =?utf-8?B?N3NrWHJHOG9vU05OdktrOHovOEVsWW85dUs2dDdDMnBvOTlLSm9UZjQ5eVlp?=
 =?utf-8?B?VnFNUDY2T2RYN3BmZy9tY1IzRUVOQUpYdGduaU9ZNlVvVEtJWFkrSHFTRnNz?=
 =?utf-8?B?N3FuZlpMOGNNcksvbDIyL0RkRnM1SHNmQlJDQTNjQjFrTzFKNFdmQVlic01w?=
 =?utf-8?B?cEdoZWhQamJwZm9PYmd1OHlDZVZqYTdyMTZSajJIOWRJRWRSOGl2RmdORExu?=
 =?utf-8?B?eng0VUUzSDkxa1RUOEwvZHVHS29ON2hZZE1WSS85TTVybFAwOHJXVDVKRXVI?=
 =?utf-8?B?aEdNZ2hZYUxZNUY3SW1MUWRxWEREbHNBYkN3WGxhQTFXUVVKdWloeWFLUFc3?=
 =?utf-8?B?V2FZckE5dnBZZ2lZQk1MQW4wejFnbTNnQW5kQzNTMHpjdlptVmFiRVRyV3E5?=
 =?utf-8?B?M0wyOFkwaWdPL1krYzA0UXlhak9hYklLTEF1UTV4NFh1UDVZbWF0VHE4anFO?=
 =?utf-8?B?YlZWS0RKVmVzRkpIU0pPYlNwSXJJWG81Sm9URjc1dVlKQnIxdlBZNHNaRmFU?=
 =?utf-8?B?eFFPcEI0enFYQ2hrZEVJUUVnQVZpMEd2eEZKOWtTekIydWt2NkhNTEF2aGdQ?=
 =?utf-8?B?TDU2R0VKNkZnUzJDRFBDUG1VQ1JVbDNyTThESHpDNXBybG9YNS9FNktaUHpu?=
 =?utf-8?B?L1BaUG85cnVKdjVrZlJOcHJqd01tdHFCeW45Ym1EejFUQVNZbVcvNitKTTVk?=
 =?utf-8?B?SitYTzdleSs3Tyt1b3I0K3Nhb0E4cUR5TGNiMEJGQnJLdjJOVEtSQnJEZ0JL?=
 =?utf-8?B?WXF1Y0VVSUhkZlpGeW41cjhLRUQxQ2VLVVd0ZXlOUUUrSnVRSk1WcHJiZHZU?=
 =?utf-8?B?TzVSb3ZmMUxBSXVwZGs2Q05zaS85Nk0wRy9jSzhjYjhFOVhuWVpodzR4aWtk?=
 =?utf-8?B?bVMyaHlsaUxUS0ZhS0J4d3BUMExQYnNHQ0hjclg2UGxrRXJVMnFCQnVzbVhz?=
 =?utf-8?B?UDZ3ejMzSXNWUW9kWHRGNjhxSm9oV2l2bFRqM2NJM2RKbzZ1RUFWbjcwZzFy?=
 =?utf-8?B?MzhNMFNPMFNGTG5MV3NUa1p6b1NZVHZobVprWVNlYXk4QURqeXZVRnBIcWsx?=
 =?utf-8?B?WXZ6NVhNcFhPd1NjZExCa2FHQ2xtTGh3dEhOT3ZVRXBrWVBaWi9BWnljSmdM?=
 =?utf-8?B?NysyNU9VNlNCM1dFVDhaOVJTYmFGN0cwRTc2eURLUjdLNnlvT1BLM2RyNjdq?=
 =?utf-8?B?UnJJai9qblllazlIaHkzVlljWHFDYVd0U2lwbWNWR0lkQXhSTExpaUpnVWUx?=
 =?utf-8?Q?0LbwQ1o5tIbDxYT2NdH8ElpHQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbc04fb-29d9-4fd2-b159-08dca750f199
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 17:42:07.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SIFum/WmDnL0U83+kMexMn25ae7UlBvaJYcu/D8b8SS4M9yJRoUpaq4Q/jQ0hbb2XfUtMX3a6nLLO1OX3mqhEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832


On 18/07/2024 15:59, Bartosz Golaszewski wrote:

...

>>>>> TBH I only observed the issue on AQR115C. I don't have any other model
>>>>> to test with. Is it fine to fix it by implementing
>>>>> aqr115_fill_interface_modes() that would first wait for this register
>>>>> to return non-0 and then call aqr107_fill_interface_modes()?
>>>>
>>>> I am doing a bit more testing. We have seen a few issues with this PHY
>>>> driver and so I am wondering if we also need something similar for the
>>>> AQR113C variant too.
>>>>
>>>> Interestingly, the product brief for these PHYs [0] do show that both
>>>> the AQR113C and AQR115C both support 10M. So I wonder if it is our
>>>> ethernet controller that is not supporting 10M? I will check on this too.
>>>>
>>>
>>> Oh you have an 113c? I didn't get this. Yeah, weird, all docs say it
>>> should support 10M. In fact all AQR PHYs should hence my initial
>>> change.
>>
>>
>> Yes we have an AQR113C. I agree it should support this, but for whatever
>> reason this is not advertised. I do see that 10M is advertised as
>> supported by the network ...
>>
>>    Link partner advertised link modes:  10baseT/Half 10baseT/Full
>>                                         100baseT/Half 100baseT/Full
>>                                         1000baseT/Full
>>
>> My PC that is on the same network supports 10M, but just not this Tegra
>> device. I am checking to see if this is expected for this device.
>>
> 
> I sent a patch for you to test. I think that even if it doesn't fully
> fix the issue you're observing, it's worth picking it up as it reduces
> the impact of the workaround I introduced.


Thanks! I will test this tonight.

> I'll be off next week so I'm sending it quickly with the hope it will be useful.


OK thanks for letting me know.

Another thought I had, which is also quite timely, is that I have 
recently been testing a patch [0] as I found that this actually resolves 
an issue where we occasionally see our device fail to get an IP address.

This was sent out over a year ago and sadly we failed to follow up :-(

Russell was concerned if this would make the function that was being 
changed fail if it did not have the link (if I am understanding the 
comments correctly). However, looking at the code now, I see that the 
aqr107_read_status() function checks if '!phydev->link' before we poll 
the TX ready status, and so I am wondering if this change is OK? From my 
testing it does work. I would be interested to know if this may also 
resolve your issue?

With this change [0] I have been able to do 500 boots on our board and 
verify that the ethernet controller is able to get an IP address every 
time. Without this change it would fail to get an IP address anywhere 
from 1-100 boots typically.

I will test your patch in the same way, but I am wondering if both are 
trying to address the same sort of issue?

Cheers
Jon

[0] 
https://lore.kernel.org/linux-tegra/20230628124326.55732-3-ruppala@nvidia.com/#t

-- 
nvpublic

