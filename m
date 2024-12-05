Return-Path: <netdev+bounces-149349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 157129E5344
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB33016733A
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DB1DACBB;
	Thu,  5 Dec 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gAuXO5P1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5241946B3;
	Thu,  5 Dec 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396535; cv=fail; b=cAyaPIgqmkD6HamGyXBKRp909CbOlyq3BxIcTI94jnfIvdmVkAdqhRUcCFn6mjBNJCqY4Cx6Y9FqWKN5jBbAu82Df3xbrXB5Nr0zZgPUsSXtYp5jCk4lMRoS74aWIDvtebvMbXUF9DhE7xyIweSl7Vqusi2+cUQMIO1+/G1bpy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396535; c=relaxed/simple;
	bh=W6jmULg2SaXnqVQlqLUqWIyrfMl5WPYrCgSAERfOIx0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VuCyWjXPHKAQIQzPo4JHDH0KogCmbDqQ85cEaA0dUaIBLuW/Dh/dPUQg/SAZSmF35rcQQgXTEZMavlOXSoUiorP2m+kmaTuUfFxJTvXz8vJtr+ZtPzPyyapv/d5+YCZEM1nCyl+Fy3HnltyAVsBelWKqkwAEQmE5Hu1O8dxZOE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gAuXO5P1; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0X2qohuZywZOhZDYP+EPRDkUUpqmyNmEuH9Zadfn7hv5VsQREhCb9kR5ovmE6bVt+hgGVSGICwwKcR0CTJpbzt+FanCBwsaSO0Ukk7Uu6Qa9ONi9qV7mLznLLc2kLOTdsv0xq3obFgqKsI2nQ4tJjtn+wwKsOqbYb2VGvmEJlZdFGf+cDLd8Pbzu3l/3gU+zETIojs+isOHOIO6JUmRhslplz1vjhAe1k+vrvZrOEChboTPIUp3NGq7KYOFfHOdEuBNNiwbqfF4JqTls+GIDzpkZFt3kznrf1IJFpRZH45AJ3cNevopetNd5iPuYePTZaDBKazz4j9d2sEOXnA3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bAbqJzjg+5Zot9AIRxBD7sFSQQZdZrnLEPbQFmMYleY=;
 b=FVBtazqnqVIdWC9neghSe08dhFaT766LTMEfdFyDRepfVnFv8F//72jwFkmhpfdUdnymWZ/BIfRfINBCAZJip3gg8W97CVL8eIIA+k4UQ2e/jA5NSRus3iS2BtOuAA79ZDda++nMW9EENY9HMRXH1JZWAq1boYlXNNS0sB0KYwYrhuEcXeiGeh4xZfpEtLOwP7a5MsfQ+toPp12qj7+Qds8kupw0m65mUU1jay9tQsHdKulGunnhZLE+aBe24WKXQlVKnqNu77NYY24LF9Xq5F9nKxEa2/fzmKs3MHAAljBAm4fCbxxAZ6InZ983Gt7m56fj0nPY2fA+xEF1p1PVNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAbqJzjg+5Zot9AIRxBD7sFSQQZdZrnLEPbQFmMYleY=;
 b=gAuXO5P17RdK/YqvbHRUsrHbZIHkw5MuCzbA59hRIbg4CQ3yEacVZuNrSTYZe8SnQ9fXKKNSRsC1fftl0U3R0akYF5AS5sYf8jyDb/BEm/XbqWpXwy9eDyhoNDcgiBWqagd/bK6af+TQeGhVNg051NGjPK/kW2LC9/72gp78QtY9Zf4BjyVqedn4k6PQelcsOEnJ7ulMNYDSwB9w7ElxEIXm1rk5T0cnHBcryDQ8baogmkVX5WbfRt7xlbMbCQnMsR6HuvdibcrCONGXmR0WLmnVMN2Kr8e5l+jntwaTz1XCMZiYzpIHtsFTXcnTrYW7NNOlLORHrCJVIMwDGq2FzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 11:02:06 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 11:02:06 +0000
Message-ID: <ddfe8dbf-a2ae-4aa0-ad09-fa5efcb62c12@nvidia.com>
Date: Thu, 5 Dec 2024 11:02:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for
 non-paged SKB data
From: Jon Hunter <jonathanh@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Robin Murphy <robin.murphy@arm.com>, Furong Xu <0x1207@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, Thierry Reding
 <treding@nvidia.com>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Will Deacon <will@kernel.org>
References: <20241202163309.05603e96@kernel.org>
 <20241203100331.00007580@gmail.com> <20241202183425.4021d14c@kernel.org>
 <20241203111637.000023fe@gmail.com>
 <klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw>
 <df3a6a9d-4b53-4338-9bc5-c4eea48b8a40@arm.com>
 <2g2lp3bkadc4wpeslmdoexpidoiqzt7vejar5xhjx5ayt3uox3@dqdyfzn6khn6>
 <Z1CFz7GpeIzkDro1@shell.armlinux.org.uk>
 <9719982a-d40c-4110-9233-def2e6cb4d74@nvidia.com>
 <Z1CVRzWcSDuPyQZe@shell.armlinux.org.uk>
 <pckuhqpx33woc7tgcv4mluhwg2clriokzb7r4vkzmr6jz3gy3p@hykwm4qtgv6f>
 <0ac66b26-9a1b-4bff-94b9-86f5597a106d@nvidia.com>
Content-Language: en-US
In-Reply-To: <0ac66b26-9a1b-4bff-94b9-86f5597a106d@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: 723c9aa9-10df-434f-a66f-08dd151c41df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWMrZTVYem1nbnZIZUwxNjJUTFZFM2JMR2VKQXFBbTdhVlp4aWJWNzBTQ1hN?=
 =?utf-8?B?YWc1TTFjOGQyd25ZMXVOZ1FIRktMOFJNSzJib2Zna1ZhUEdxdTdkMFJLcEZn?=
 =?utf-8?B?ZTVOU3Jhb0VjcVY3anppZmN2VFh2L3BVNUwzNEpQTE5GbTZhZjFsR0xQS2xT?=
 =?utf-8?B?M08zUzcvNktzbDZYZ2k2c253ZzdONm44Wlcwc1BzcytHcTRScUdKeWM2TE5w?=
 =?utf-8?B?MUdGQklMU29XcG54dzlOa1JSMFVxT095QVp2SU15cVdyOVlwMTFvRVZ1dW5T?=
 =?utf-8?B?RTNYeGlFcDRLQW5CdEdGajNkQjFqZGszaWovdzhyUCtZVno5SnlVT25SeXNj?=
 =?utf-8?B?ekU0d0w5SXVtbXpiNyt0K2V6WVRseXlYU0Z1ZlhPU0d1dGpDZkdnbjUxL1B2?=
 =?utf-8?B?bURxWFk2MlRrdE1pMXF1S3QzSUlmbHRHK29qNFFJNllJL1k4SENuNmlzWHlF?=
 =?utf-8?B?ODhYVW05dGJEOUNURXpIZUliRC84cFF6L0ozRGNWbFBXZ3B1NlRmc09SVE1y?=
 =?utf-8?B?MDVDUEpUS2xlU21ZWHdKOW96K1gvU01JUmxTWnpMalc5T2tSMW9zdEdQQmxI?=
 =?utf-8?B?bllnZGpuVEhVcXRFK3RvY3FYWkx2cFJpd0hwZGNCdUJSY29oRklqZWRvaDZV?=
 =?utf-8?B?RGpBcklQbktpVjRFeDZOajE0STdXY2tHWEt0VzFuM3dFemZ2SC9zcUUvZnha?=
 =?utf-8?B?TEVlY3YzbWxJeU5EbnpnbXcvUjQxcm54Y2Z0YWEyNjVSajNlRmtzTTFSUnY5?=
 =?utf-8?B?UjlHYUwyd0pXckNQYVBkMUtMTHpJcTRZRHJzTHM3dXM0dklJVWo2eUNEam9V?=
 =?utf-8?B?M0w0MGVoMDdldVlycUkvZGkxaXV2aUc4akJiZXM0a0ViL21ZVEdwWExyUjk0?=
 =?utf-8?B?QnBHWE9WdE15R0ZaNk9yZ3g3QTlGdEczM1ErT29qWXQ2cTRMRmY5cVc2NmNQ?=
 =?utf-8?B?NjBsRGl2WFhWekxCLzJEdFRVTGtiMHNYcWNBR1FPNlJ3bGpvU05rUjc4R2Iw?=
 =?utf-8?B?Vmd4SDJ2UHZyNTVIeFRnU3piQkpZS1k4WUpNVDdiZ29hYTByUlRaNEVwQzI3?=
 =?utf-8?B?YmtxZVNlekZ0dkdTT0JZcFJUV1FvRGVJRWZpQzlUMXN3TEFGbU5heXdzclQ0?=
 =?utf-8?B?aHF2MXJzTEZQRENIK3hKeUhNcGtYV0RNWVJyUlRNWFRSVzJPNENOUWhmREIv?=
 =?utf-8?B?Z1BqUkkrbEtKQktjZDJvOHBSM25NbGJWbUthUHRJUjE3c3NOTW1WOVdtVUpS?=
 =?utf-8?B?Ny82dlV6TUNxUEhxVERKMElsR3owT0E1dWtYU2o0cUk0SFE4emlTbWxINmlQ?=
 =?utf-8?B?RWY3a0c3cDdQUnFiclVMbDBZcjJHMDY1MzZaK0p5UGlaaURCU1YxL3ViNW81?=
 =?utf-8?B?WjVTSkVlanFtMy9xUjcxck5BQzMzY3VJK3p2QmFyYm5pcWhBNU41d09YM1Z6?=
 =?utf-8?B?aDlWSy82eGRjQ0hoU3NEZlhJaGg0d1RObnoxUk92RmN5ckhFYkM1a3IvM2ho?=
 =?utf-8?B?THJIcXg1Z3MybmVFaURhMDlaQ2QwcytONXMyNnlseEtqcERBMTdmTHJNVVhJ?=
 =?utf-8?B?ZVpiOTJrNzFGcWhSV1hZaVZIdHBBZVlsa2Z5WWIzWUNJd0FEZmVFWmFnekJi?=
 =?utf-8?B?c3ZZMHhjMi80VVFPSFN2cmI2OHE3VER1OGl4R0xkMmhpc21RRzY3RkhvUWlJ?=
 =?utf-8?B?NEhISFVaQTRlRlpBMUJuRVMvTjRsTTZGSmYxTHRqeGpzakpJaXRqaVJucUFv?=
 =?utf-8?B?U3FOa2t5eDUvWUxZczNGSTF2UnlWVlQzb2tpNkVIYkNQVmxOcVp3YTcxWWdi?=
 =?utf-8?B?SWhleHpHWlBFajNxRUl6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW9raVpHSWlzUU1OTGcydXFBc1d5SHpkMXhBZFcxNjQ2YXJ6L1JhNy9rZXlM?=
 =?utf-8?B?QWV6VUZCc21zMWNtcmplVHYxUUFJNXkxZmUzdFNGV0MzZ2cvemdtZW1TWk5D?=
 =?utf-8?B?ekM3bEQ0U1liQmM4S0tFUmVHaXlYc2VyMVAzTDA3aFIxZ0xMMy9MQ2hRMlhl?=
 =?utf-8?B?dUhnUmpjQWlGL0NZQzRxeU5LckI2ckFBcTdLVVFlR2tYY2FrNG4yWEd1Q2lt?=
 =?utf-8?B?K0xoTzlEYUxwMDdDbmw1M2FFZGp2aldxRG9VbWxGU3NvUGFaV3BWeDdnZUZL?=
 =?utf-8?B?TW0wNzA5TVRIMlRxM1J2d05kNEFDaW5FYkQ2dHd4V04rQ0lpa0RWZVJVUnJI?=
 =?utf-8?B?TzRrY2tYRmh1YWR5WVdKQ0J4cmI3NndnZDVRR2ZBT1dWVmdUZDN2RlhoVzVk?=
 =?utf-8?B?RUhEd2E5QWlSLzVUMmR3S05ZV1lTUE4ySjVHWWE5RFhCdkRKbWZlYjJTaFdo?=
 =?utf-8?B?b3hVei80VWs4NG1jTERBTHJvMFh3bVV6NE1oUXBRV1pOR1B0V0tqcTgycGdJ?=
 =?utf-8?B?RlBPU3hEcjdMTm84WWtMRTBXak80Vm9EbitoZC96U1BlZHJLUzVRRGhMV1Zk?=
 =?utf-8?B?SzhUN1ZjYW1QaS95UWo3dFRnOU45U3JZTHBhWStpb3drNWFvQnAyNWV5TG92?=
 =?utf-8?B?eWUydVBnYVRqNE9wOC9HZ1F2MEVpVVJrVGdPUFNuSEtFc0s0U3lYN2dRTitr?=
 =?utf-8?B?WGh2MGwwMW1kQWJLV08zMHRTaENHTSsveXo1OVpIY1VsbWFXQmlCLzFrckNV?=
 =?utf-8?B?dnpISFZTNFV2WHJQYW9DZ1Bob2lLaTREREJPS3dVK0FaZEs2bVFaRmd3RnNT?=
 =?utf-8?B?Vm9iY3NJOFBVMGpaTElJY1ZGVHRzWEVPUWlHVEFsVzJBMi9WSXpLREFZV3hr?=
 =?utf-8?B?QU1MRC9DUk5ROHdzSU9TOFhYc0MzeTdySVlhZmRoRHl4RHFkNXM0a2FmM2l5?=
 =?utf-8?B?UDk3b2dpOHpsejBVbE9uS3NUS2pmdWtxbHJ5ZDR1Lzc5bWo3NnIwWS9MMGdp?=
 =?utf-8?B?ZkV4djlkdzRnb2FSVXBseWJrTWFQUW54VXlORTJsTzFVMG84cVVPTU5kd1k4?=
 =?utf-8?B?RDBSTVFXUlV1bUVHM1FHczdFcUJrYy9uQ2tPeS9aSVA1cUM4clhZTUtWRUl0?=
 =?utf-8?B?MklhY3JuZU9RR1E3eXNtVHpWSndaaFpjczh3RzBWN2djdmltdk5EbHhmcFVi?=
 =?utf-8?B?eEZkT01SMTRWdlU3Wjk5RUlHL3gzNFdBWkFWNXlWMENJWlQ3UkN3MmdLZG5D?=
 =?utf-8?B?WlVic0N3SldXU1BBS2RVclRmNll3OGhnT3k1b092Mm8wZVdBeWJQSUY5MU9X?=
 =?utf-8?B?akxaaGN4MjhhQW84YTNjYldiZ0JCdjhzVE8reEQyNTZZS1VCUUNFY3lYUzFx?=
 =?utf-8?B?OE90Y1AzS1lXT3Iva0dXU0FOSDBiOTdTeWQ0WndNU2xmazFCRVhhM2d4SXBw?=
 =?utf-8?B?M1NHSG41VjdOcXdmTEF6c0Jrb09DZ3J2VVhmWnJ5cFpXSFg0MWNaT25yQlhn?=
 =?utf-8?B?ZnpBRDJ0aVdIODcrOVlRTGNkUjRaK1hkZlFGQmM5cWljekFPcVJldWtzNWpy?=
 =?utf-8?B?VHlGQzNscjJvLzlqYlczNU5iZnM3MnRiMUttWUtsZFNFYmV5bVdIWHNpdWRZ?=
 =?utf-8?B?Ym5FZ0FxQjZoUnMrMXVpOEV6SlBtc1luWUtLdm11cWVOQ0N6bXVwZmlESGxq?=
 =?utf-8?B?VU5KRVQ3cXhJck1VaU14Ukl5UEE0QkNXK0wyOUxyYW1WVU5ZbU0wY29zNzN6?=
 =?utf-8?B?ZU5peDU4RmFjOGpzZmc1cDZ5SVBUcHl3VUZvZTJLRE93K3JNL3NtamlETmxT?=
 =?utf-8?B?T2J4R3hLUEM1QWViRTB5QnVTMzRsZHk5N21PcWlaMGpSa1p3ek9RdmtrS3pm?=
 =?utf-8?B?SnZPM1RqOSs4UkRaRmlPT0doRVVyRzh2NUVnTks2NEhIWWVzS3FCdlJIRXVw?=
 =?utf-8?B?am8vNldXVkYrV01wZmNtT1UycURxVmVhOW9oMUdNdEpxUktZa002VzdXa1c1?=
 =?utf-8?B?UWx2VVZhZXhob0doOGpaWDJ3MGo4cFA5Qzc0QUd3eElLRDBlMXFSL2xVMmta?=
 =?utf-8?B?dTREVlh6M2Z1OHk2RG9Ld3ljOTVPbWYyQ3VjN0sxbkhHMmF5bXhsL25xRnMv?=
 =?utf-8?Q?jAxL09XFdy3jR/n/zrgN9tqPK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723c9aa9-10df-434f-a66f-08dd151c41df
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:02:06.7360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpopsH9HHWtutlWdo4Kg3aAhUfk2Hfi58ICOq3r5Nxsw88rIaxo0DDD9XxJM7hCD4ffLWXk2WlbyEzNuN7bNlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548



On 05/12/2024 10:57, Jon Hunter wrote:
> 
> On 04/12/2024 18:18, Thierry Reding wrote:
>> On Wed, Dec 04, 2024 at 05:45:43PM +0000, Russell King (Oracle) wrote:
>>> On Wed, Dec 04, 2024 at 05:02:19PM +0000, Jon Hunter wrote:
>>>> Hi Russell,
>>>>
>>>> On 04/12/2024 16:39, Russell King (Oracle) wrote:
>>>>> On Wed, Dec 04, 2024 at 04:58:34PM +0100, Thierry Reding wrote:
>>>>>> This doesn't match the location from earlier, but at least there's
>>>>>> something afoot here that needs fixing. I suppose this could 
>>>>>> simply be
>>>>>> hiding any subsequent errors, so once this is fixed we might see 
>>>>>> other
>>>>>> similar issues.
>>>>>
>>>>> Well, having a quick look at this, the first thing which stands out 
>>>>> is:
>>>>>
>>>>> In stmmac_tx_clean(), we have:
>>>>>
>>>>>                   if (likely(tx_q->tx_skbuff_dma[entry].buf &&
>>>>>                              tx_q->tx_skbuff_dma[entry].buf_type != 
>>>>> STMMAC_TXBUF_T
>>>>> _XDP_TX)) {
>>>>>                           if (tx_q->tx_skbuff_dma[entry].map_as_page)
>>>>>                                   dma_unmap_page(priv->device,
>>>>>                                                  tx_q- 
>>>>> >tx_skbuff_dma[entry].buf,
>>>>>                                                  tx_q- 
>>>>> >tx_skbuff_dma[entry].len,
>>>>>                                                  DMA_TO_DEVICE);
>>>>>                           else
>>>>>                                   dma_unmap_single(priv->device,
>>>>>                                                    tx_q- 
>>>>> >tx_skbuff_dma[entry].buf,
>>>>>                                                    tx_q- 
>>>>> >tx_skbuff_dma[entry].len,
>>>>>                                                    DMA_TO_DEVICE);
>>>>>                           tx_q->tx_skbuff_dma[entry].buf = 0;
>>>>>                           tx_q->tx_skbuff_dma[entry].len = 0;
>>>>>                           tx_q->tx_skbuff_dma[entry].map_as_page = 
>>>>> false;
>>>>>                   }
>>>>>
>>>>> So, tx_skbuff_dma[entry].buf is expected to point appropriately to the
>>>>> DMA region.
>>>>>
>>>>> Now if we look at stmmac_tso_xmit():
>>>>>
>>>>>           des = dma_map_single(priv->device, skb->data, 
>>>>> skb_headlen(skb),
>>>>>                                DMA_TO_DEVICE);
>>>>>           if (dma_mapping_error(priv->device, des))
>>>>>                   goto dma_map_err;
>>>>>
>>>>>           if (priv->dma_cap.addr64 <= 32) {
>>>>> ...
>>>>>           } else {
>>>>> ...
>>>>>                   des += proto_hdr_len;
>>>>> ...
>>>>>     }
>>>>>
>>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
>>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
>>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
>>>>>           tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = 
>>>>> STMMAC_TXBUF_T_SKB;
>>>>>
>>>>> This will result in stmmac_tx_clean() calling dma_unmap_single() using
>>>>> "des" and "skb_headlen(skb)" as the buffer start and length.
>>>>>
>>>>> One of the requirements of the DMA mapping API is that the DMA handle
>>>>> returned by the map operation will be passed into the unmap function.
>>>>> Not something that was offset. The length will also be the same.
>>>>>
>>>>> We can clearly see above that there is a case where the DMA handle has
>>>>> been offset by proto_hdr_len, and when this is so, the value that is
>>>>> passed into the unmap operation no longer matches this requirement.
>>>>>
>>>>> So, a question to the reporter - what is the value of
>>>>> priv->dma_cap.addr64 in your failing case? You should see the value
>>>>> in the "Using %d/%d bits DMA host/device width" kernel message.
>>>>
>>>> It is ...
>>>>
>>>>   dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device 
>>>> width
>>>
>>> So yes, "des" is being offset, which will upset the unmap operation.
>>> Please try the following patch, thanks:
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/ 
>>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index 9b262cdad60b..c81ea8cdfe6e 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct 
>>> sk_buff *skb, struct net_device *dev)
>>>       struct stmmac_txq_stats *txq_stats;
>>>       struct stmmac_tx_queue *tx_q;
>>>       u32 pay_len, mss, queue;
>>> +    dma_addr_t tso_des, des;
>>>       u8 proto_hdr_len, hdr;
>>> -    dma_addr_t des;
>>>       bool set_ic;
>>>       int i;
>>> @@ -4289,14 +4289,15 @@ static netdev_tx_t stmmac_tso_xmit(struct 
>>> sk_buff *skb, struct net_device *dev)
>>>           /* If needed take extra descriptors to fill the remaining 
>>> payload */
>>>           tmp_pay_len = pay_len - TSO_MAX_BUFF_SIZE;
>>> +        tso_des = des;
>>>       } else {
>>>           stmmac_set_desc_addr(priv, first, des);
>>>           tmp_pay_len = pay_len;
>>> -        des += proto_hdr_len;
>>> +        tso_des = des + proto_hdr_len;
>>>           pay_len = 0;
>>>       }
>>> -    stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
>>> +    stmmac_tso_allocator(priv, tso_des, tmp_pay_len, (nfrags == 0), 
>>> queue);
>>>       /* In case two or more DMA transmit descriptors are allocated 
>>> for this
>>>        * non-paged SKB data, the DMA buffer address should be saved to
>>
>> I see, that makes sense. Looks like this has been broken for a few years
>> (since commit 34c15202896d ("net: stmmac: Fix the problem of tso_xmit"))
>> and Furong's patch ended up exposing it.
>>
>> Anyway, this seems to fix it for me. I can usually trigger the issue
>> within one or two iperf runs, with your patch I haven't seen it break
>> after a dozen or so runs.
>>
>> It may be good to have Jon's test results as well, but looks good so
>> far.
> 
> 
> I have been running tests on my side and so far so good too. I have not 
> seen any more mapping failure cases.
> 
> Russell, if you are planning to send a fix for this, please add my ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Nevermind I see Furong already sent a fix.

Jon

-- 
nvpublic


