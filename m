Return-Path: <netdev+bounces-130796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607398B97A
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656DFB216FD
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368B19D08C;
	Tue,  1 Oct 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XfISaDpB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1952F3209;
	Tue,  1 Oct 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778164; cv=fail; b=XtgBYRMTV0Rfh2+Q52BSOY+qFRlBxJWT3458CVvBKWbb+dZS+WPDf989fCrGzG6ltkqkaO4TurKFfnwO89fR7mgR/BUOFrfZq8xKRzpwmeyweJADKye9Hbt6Jx8qqiAiD+28QChdasPtnw2EjRUdN5Cws9sIfbpGHu2IaolMZLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778164; c=relaxed/simple;
	bh=FdhF8bzeHTsoKnZ0pVwZmcBG2W+GIOufURG+J0XXZBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hVsSjzh0C+vlJPDs2S2jbku5Ew0qGG61YEf8j9RTAMDiqG6AAey+JnOB5g+o/Poaa13+Sr0vTBec7++c0BOicMeUeeDyKhv7oqCwzXUvOCKwSdOzlxVNp6R+rswnsUTH22Y1ntMhqvek526KUTOTxWJmvZdfqvYkOhql74zRaAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XfISaDpB; arc=fail smtp.client-ip=40.107.244.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnPwVSlt25sH0Hst48oazlulgZ+JISrKq9E45PmKq1KHGtvQd2EqbTzWTdpKGzxcab7M7bkq7KruEekFOMbcogruUGXIWYwPGqDUB04akwlhRFc9QO8Jff3EH8+hkldTbET+fSCrRwhoYUO9ETLbkH+44+QJaIGrHTaxlhR4855n40jPhNFxWYbQFhbxO8cgUrdXfNidaZzgbiPEU52Dho92J+yCxVZVWC/wyigNtw/t3Xl84kmpRtj/Mopi1tCTPioTMxTyL/m0KJIRt8UZWQBvCNMz5TBNBQKXkOfpSM5be8M82K7rqpiGHPBROccTLCFM3CbOBxCvhZbA8A0eKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXDgdRmIGEC0qPXQ3+BQT2DnyNNp285r+EZbsYDcOes=;
 b=DPam8aZhp8lxHzrHloMfm5tOztwZTJd7uhvGZ+ch62wcBePloKLoY3PwBRDNfeT2RrpWbBCJA4WFL0mhnQqx02896RxaaV9pA5YXoukEFTG7gSom2y2yNKhVb5/UlGi2sYMqQtJrDC8xokTbkFkAcfXNkT8rLiC3ztipPqonLwMtf/uCmcsfx6/AJVFKbhuN2u/u1Z4/xL7ydkSpMGdH4vbZQGWRbJPPqcvzcErpd/BzMjhKauYnQypGEX5kr9rrCDjT7TexcamhzNdvjGyo25qrjVS9/tpDe3PMpMSBF54TZTAJzB6OFYrgprzMRcpuBFQrS18OijEKI+QbvO+TRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXDgdRmIGEC0qPXQ3+BQT2DnyNNp285r+EZbsYDcOes=;
 b=XfISaDpBQmM+bEnJ/zKbOyDGMRezMcvf8Oc5LThoUKDscGH//XbbsVNKUMUID4l9WoskPWdUMvis5PTu6F4hAvjSIFkdd/bd3TE3cZiRiZxXvOdIOyXQT8Nv44W8et8/YmTUy+t+B8OIIJLl/olnu6s66cbWc9ipKJI++Av4KYhgLF6fnaAQJxiNChL9mvIn9QcyfILOfVQKnLTljvtO7XCzsCWllLNBwUXx3Wd53m7P/a4Xx1viVJJpS6IbUZXXT8/ta4ep9y0SFiV5WiwVqmIUJX0b9nvkQ/rxD+2r/Cqt1XNg6Va61N43zR3G7UZjfHHHKFVinbRTrnjVInbMjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 10:22:39 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%5]) with mapi id 15.20.8005.028; Tue, 1 Oct 2024
 10:22:39 +0000
Message-ID: <28f05bbe-78f6-408a-ae53-c40f6a86eed9@nvidia.com>
Date: Tue, 1 Oct 2024 11:22:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP
 is enabled
To: Furong Xu <0x1207@gmail.com>, Ong Boon Leong <boon.leong.ong@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, xfr@outlook.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 regressions@lists.linux.dev, Thierry Reding <treding@nvidia.com>
References: <20240919121028.1348023-1-0x1207@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240919121028.1348023-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: c968b1a0-fb4e-42ee-6579-08dce202f9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFlta2pnbVdKQTBZd1k1SHl2NmhLTDBHRklzTmo0d0JtaCtVSTYycjhlcVE0?=
 =?utf-8?B?TXRFOUkyYlVWbUsvakRkdU1NSmJsMWpPanVxZzdhY3JvZVdyY3BZMUNJL2tL?=
 =?utf-8?B?U2U2MHZJL0hIdkNiWjl6dEd5VUIzSWZjMDcvTHAwZUxHSzQvY011TkxIM1pB?=
 =?utf-8?B?ckVvWGQvTDV5RFJHK2RLSzBoMmVUY0FiaUZ1SkZvK2JLQ3g0TzJtV0JwdkJP?=
 =?utf-8?B?OXpvUmRvenRsNGRVTFZjR0UrV21HUGxQL2UxNU54cEVrS1JWbkU5SG5hRE11?=
 =?utf-8?B?RWZacWpGZm53VlM2b2FtdFM1Y1pRbWY5ZG9PekhIMnBSeGtHbm9pbEE2TFdZ?=
 =?utf-8?B?dXMrM2srK0pVSDl6L25vOWdzUlUrWVpkV2FpakRkRTlIVmRnNDlvL1duVDJ0?=
 =?utf-8?B?S0lpNDlVUGcvV1ZNT1VROE16VVltUDZGZ3J3N0ZaSnNidXphVW11bFlONito?=
 =?utf-8?B?VHJoemVCVW03RFF3VExMWHN6QWYzd3pWTXQzWXBoOGJZZGcwQzNSb2M1WW9Y?=
 =?utf-8?B?S1IxU2xCSlU5VHZSRVNuemd3RVJGNnBIdW95OGJuajNkKzBUaWFyS3pDRWhU?=
 =?utf-8?B?YlpQSEkrQnU4YWFnU0JEYUNyR0tuM2RCY3Jzak9RWmxCL0FQdlhZYzZTdUYy?=
 =?utf-8?B?ZDI3TU5IWnlaM3RXcDhybzVrWGxkMXlCeXpPR2RQNVdKMUpwamk3RnpBZVFj?=
 =?utf-8?B?bytLWjJyaWFDbVMzRG1sQTZ1ZWpRNitSaG1hSk54WVcyRHZNSGlrWUlNakV3?=
 =?utf-8?B?Q3BsdEpSZEhhSzl6L044SVVDK21RUUhyQU9EVW1JNUdTTmNJYndnaVVuOHVi?=
 =?utf-8?B?SE9sQ0NQcHFnclNtZVlMOHEydjczUzZqVFZyT3RMQmp1WEVMTVNhd0pUT1hx?=
 =?utf-8?B?b2UzWjEzVWc2Mjhaa21KaVRha3c5dXFXc2JXR1ZXRWFnYVg0b2N3UjRKTS8z?=
 =?utf-8?B?SEIrandQRGtlQzdWNFpFemZ0ZWtpRisvQUpwYW5PNStzVmRXNmpSUzJuOFA1?=
 =?utf-8?B?VCtmbXRHVUJUYktIbXNYVGY2TXJuUVRSOER0VzlzZWRsS3BFcXhFRm5yc0pw?=
 =?utf-8?B?U0VNcmkxeER1cE84WWpQUjhHMkJ5YWhJb2s2SVp2bnVOWnFJWkRQMGM2dmMy?=
 =?utf-8?B?a2krVzY5eDdYQ1VhdU1Xd1lyaVpmZTNwRFB1Q09IZEM3MXhzR21jS3R4RWcv?=
 =?utf-8?B?RllpdWpiNGgrUVhhUXF6dGdwTnU4NXJHdHNBVklLTVNwRTdWTHd2NGMxQkFr?=
 =?utf-8?B?dk1EZEhhS1lyV0JVWDZjUEJnWWxKMFFXM0JySmpYTDVuVzc0UW8yYzJQUUtF?=
 =?utf-8?B?NDFVRGFmOEJmTzNpOUVXM09McXBzckNYYlArSGwyZVdPdGN1Ym9uaDRmcEFC?=
 =?utf-8?B?OGM5YVRkdHlTaVdCdnJmN0hUMnppZGxwOERleVlha1FadDdJT0JDdHBXS2Zu?=
 =?utf-8?B?U2pTd0RXM1ptSWJNQ1hFY2oxb01sM1NHOVlQTCtkTUVCbXhuRU96SGZ4WkRq?=
 =?utf-8?B?OEpUaGd2a3dZTE0rYWNsc2psWXJmU3JWSW1qL3YvQmI2aWNpZ2ozTkVTeGl2?=
 =?utf-8?B?ZitZT0sxcHpuK1pYaFJwVWJCcFRJYmM0Q1NSVFRUNTBZTER5d1VuR05IUTV2?=
 =?utf-8?B?TkkyeUVzVWo1bEs4S0l2dHJnSTdnT0JRNkNZc3FNYld5T0RpaWR4bzVJcGxQ?=
 =?utf-8?B?R2NxdnhiQ0VuZUZYSWRYYTF1TFVzNjZkSUNYVHZFZ2Z5OWtaK3dLRk9MdTQr?=
 =?utf-8?B?TDNobEVGbEwzblVHVjdxNmk4ZmxpYjZHZjFwMnJ6eVY5SlJEcVhISllTN016?=
 =?utf-8?B?YWRsVmU3VTJNUnV0Q2dNbkxsQXdMSmJiQzRscjNhQUNJWklqRHZPRkRreFVh?=
 =?utf-8?Q?/BAyqcvMU7adB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0plTWc4R0ZiWS82cjVWcjMxRW5tTWNLOG1qL1Qxd05mbGlJSjJoWGtWRWpX?=
 =?utf-8?B?cmh6NTczSFQ5Qjltb1crWCs2YktkajdaaUlrV01qWXJqcGZjZEt2K0kzQ2pv?=
 =?utf-8?B?K2NrTWhoN1FWRHFLbnYvT3NUVlRtRTZZc1ZnM3NjNTFJYmRiT3RFeGJ5ZWox?=
 =?utf-8?B?Ky9vQW94M2NvQTFrYjFVbXdVNTFWNUlDakNLei8yRUVNb0ttTk9RZitzU1hp?=
 =?utf-8?B?TWF5TEJmeldvVVFEQkhYOGlRdUc5WDBmd1lHTjc1Q2FrZW9IRzh4Qm9sTWxH?=
 =?utf-8?B?Misva05seXg3OHkvRXlESXNIajJUbnVUTzgwZjlKR2htMDJJUk5XWHFDeWY3?=
 =?utf-8?B?ZkJiQTJCcmRaY0JGa2dmdm9OemFVM3YzN1FxRk4ycktPYXp3T2J1RmYvU1Yv?=
 =?utf-8?B?OVFYSUIwcU92ZmNXL0EyaFhCYURwOUwwOEptY24zcHRjWEF5OUMxN0liUmpi?=
 =?utf-8?B?cC9WQ2Y0MEZUcThRbGNadGRyM0UvM01GU1RKQjQ1cWhBemhLMHZJc3dyVEt6?=
 =?utf-8?B?NytXOWV1OVdhSC9ZQUMwN2NubnJXZG9JdjlyczZ0bDRkMFRBeTJUb2V4OVlC?=
 =?utf-8?B?ZGFZdEg5dTRIMVppcWRSQXExaWpwZVNwbjRxdzhRUnlCUTBpVFJ1anBzbWRD?=
 =?utf-8?B?dDh6b1JuYjF5M3BkUkozeHNxQjZ6bjIzWm52b0lmemlQajlvT1J4VnJFMDVo?=
 =?utf-8?B?Z3N3c25NUDZJNXBvZmh2WWJRVzZMQXZQVFIwbTRDemYzTi9hMlY4aEM4cFFW?=
 =?utf-8?B?Z040OTRsTmU1ckI0M1p0ZG5EY3o0UVN4bjBacVRyZmMySWMzWm1KWkE4ZzFv?=
 =?utf-8?B?WXRQdTgvc0dHTW9pSUVyRVM3Mk5acjQ5YWppbTQ4bVFpc3hWbzRIcHpFamxu?=
 =?utf-8?B?WTZFTEVVZVBLN0lwNmZYbytMZitZNERONEtScDdKeEl2cFd3aGpUZTRDN1k2?=
 =?utf-8?B?UWoxQy9xSU5BMzZOOFdsUXNVUXhrSndocnVrU0ZHSDFXMHdZQUpMd1Q3T1pl?=
 =?utf-8?B?c0cxNzhiSHcxbnhNK2llMWg5d0NXWU02WksvNnY5QUx4VHpOY1ZSQjlwSTRI?=
 =?utf-8?B?VU9DY1pkdmgxWGdBRC9IZVkrQUc1MG15OGFobzhSd3hCK09rNytQVjVzNzVK?=
 =?utf-8?B?V29LRXFXeU80cGdlaEdScGRjdFRhV0lpNVJacWx5T0N5ZE9tMEdsYUNBRlVV?=
 =?utf-8?B?d3ZuaHV5MWduUkFJbzV6ZFNxdDQ4bmttZG9yU3dabzBrM0U3L3FFOWxsWWIv?=
 =?utf-8?B?Sk5sbEJ3aUhTSkdzblNxL2tHTkZJTno3dHIwNXUzQ0lKbTZ5NXE3a2VkajZ5?=
 =?utf-8?B?MkdYWk0velQ1L3l2b0lMdENsTjdoMHd5ODN0aVYvOERGREdoMm5pVGhKbGlK?=
 =?utf-8?B?WlFBRDVHZ244VkM1c1JJUFhSbEFLQldyYm9zQ1hiaUxUbG1WQzRnZkZKYzZ4?=
 =?utf-8?B?NVA2S1ovWDZ1dVluakZid2dqbHpIVXpsRnRza1hMd0hsZ05RZUwwMHVCaWhB?=
 =?utf-8?B?RFNreVFQdExJdkZVNExXTjVWVG1yNm1vbTdXTkhPMWJGYTBVRng3QWh2QmFl?=
 =?utf-8?B?K1RwNU1iSnRPcytkbGQ4TmxZaGJDYlVYcWcrcDcwMGc1b0lZZzB2cDhOSWRh?=
 =?utf-8?B?UjhIUGRkRXJ6ZzRLWkN1RWtuRmM2d1VkVnk0Rmd2Ti85S0ozQ0wzcUwxK2lt?=
 =?utf-8?B?L09NWVhxQWR2V2Z3eUc1NTNqTmRjc2p3a3A0UlFBNG5HMHBhVVBUTjd5V203?=
 =?utf-8?B?TlFIQUE0TXIvRi90UzBIK3F1YllBRFZOZ2VJWnR2dTdENjloTm96NmxDcUJp?=
 =?utf-8?B?UXhjcEw4QlVvMnBOZ3ByY2pkdnBJM1VZWmgzVC9ka0MxRmxiRFVCa3RtUWxj?=
 =?utf-8?B?bys0UVVaR0Y2M0RFeHd5UUxwL3VSSjdNZDluYjIzVm8rY3JnVFFDekpieTNY?=
 =?utf-8?B?T3dPTmo0allSV2RqUXdTK3F6MEJqdnRvOHRVOG9KTFB0bDRhNUtTNUttREpF?=
 =?utf-8?B?LzByUVlRVzhSQ0liN1I4Y1JEVWJXb1NrM3VRZlFJL3N0MVNpZnhJZkZrRmJl?=
 =?utf-8?B?c21PMXFwOC9UNnVtS2F2NlA0ZEVDTVpTTGd4SEZwTkpMeWN3ZDNiUHVTWDVE?=
 =?utf-8?Q?pBLoh00q7FW1Uhom62yGaeL7w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c968b1a0-fb4e-42ee-6579-08dce202f9e6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:22:39.2510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FztbK7zQa8LwA+of8bzRFSiszro2mkyfiefeIRMV0cL3LFI307nYJM7DjnKS0MNqXEL6x6j0PfLda4STuZlVJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981

Hi Furong,

On 19/09/2024 13:10, Furong Xu wrote:
> Commit 5fabb01207a2 ("net: stmmac: Add initial XDP support") sets
> PP_FLAG_DMA_SYNC_DEV flag for page_pool unconditionally,
> page_pool_recycle_direct() will call page_pool_dma_sync_for_device()
> on every page even the page is not going to be reused by XDP program.
> 
> When XDP is not enabled, the page which holds the received buffer
> will be recycled once the buffer is copied into new SKB by
> skb_copy_to_linear_data(), then the MAC core will never reuse this
> page any longer. Always setting PP_FLAG_DMA_SYNC_DEV wastes CPU cycles
> on unnecessary calling of page_pool_dma_sync_for_device().
> 
> After this patch, up to 9% noticeable performance improvement was observed
> on certain platforms.
> 
> Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index f3a1b179aaea..95d3d1081727 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2022,7 +2022,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
>   	rx_q->queue_index = queue;
>   	rx_q->priv_data = priv;
>   
> -	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
> +	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
>   	pp_params.pool_size = dma_conf->dma_rx_size;
>   	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
>   	pp_params.order = ilog2(num_pages);


We have noticed a boot regression in both -next and mainline v6.12-rc1. 
Bisect is pointing to this commit. Reverting this commit fixes the problem.

This boot regression is seen on our Tegra234 Jetson AGX Orin platform 
that uses the drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c driver. 
We are booting with NFS and although the network interface does come up, 
we fail to mount the rootfs via NFS.

So it would appear that we need to set this flag for this device. Any 
thoughts?

Thanks
Jon

-- 
nvpublic

