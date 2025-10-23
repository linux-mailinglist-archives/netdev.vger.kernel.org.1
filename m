Return-Path: <netdev+bounces-232058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB3CC00614
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8715018C15B6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BE304BD6;
	Thu, 23 Oct 2025 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b="fNJU48xJ";
	dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b="WAyYtBGk"
X-Original-To: netdev@vger.kernel.org
Received: from mx-relay21-hz2-if1.hornetsecurity.com (mx-relay21-hz2-if1.hornetsecurity.com [94.100.137.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF12303C85
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.137.31
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213788; cv=fail; b=Yowe4iPUceGmg/vGKsWBIzbgvzqXRoXLiJdQexNdA2iJI9NCBwz+KxXe4JTycWfyz2SIpnlWcYz2zLEs0QdMC29LIqZJXRVslS9xLVM1t8cc2F3rQQ5m+CJ3YHX8VXN/spGUgy9grsWTwDyhf2vqpmcQQOzLA/XWsTo9aTVjLD8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213788; c=relaxed/simple;
	bh=gD/umAvVKbqJdxjNm75EzveGXQwFZUgSu6jFFoJRr4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Disposition:
	 In-Reply-To:MIME-Version:Content-Type; b=akZbmHIg4SbeZj6OiFaKkFgVIz0yGTz5jZblwxwPktsHCgbqRER/vsUBH8NBokMT1iRvSf5Zl7XJAtlD1CsUx48zFE6/10JgLRWAlfkMq98zvx0yJsTfc9flXXWrbFzFOytKu+8Tkb0R9DWw91AAVCHfjuk/G/VV1qRrR5aww/0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de; spf=pass smtp.mailfrom=a-eberle.de; dkim=fail (0-bit key) header.d=aeberlede.onmicrosoft.com header.i=@aeberlede.onmicrosoft.com header.b=fNJU48xJ reason="key not found in DNS"; dkim=pass (2048-bit key) header.d=a-eberle.de header.i=@a-eberle.de header.b=WAyYtBGk; arc=fail smtp.client-ip=94.100.137.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=a-eberle.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a-eberle.de
ARC-Authentication-Results: i=2; mx-gate21-hz2.hornetsecurity.com 1;
 spf=softfail reason=mailfrom (ip=52.101.83.100, headerfrom=a-eberle.de)
 smtp.mailfrom=a-eberle.de
 smtp.helo=gvxpr05cu001.outbound.protection.outlook.com; dkim=permfail
 header.d=aeberlede.onmicrosoft.com; dmarc=fail header.from=a-eberle.de
 orig.disposition=quarantine
ARC-Message-Signature: a=rsa-sha256;
 bh=b0yOK6jH9i5V1c0LqGdQNTIguiSqXUOohjGpUFY+N7Q=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=2; s=hse1;
 t=1761213741;
 b=JD0CF4iDMKOnYVFZ02ZDWxGzIrCkFjkL/TTSNcoeRGf1ilmT0TjtPD8lbg6npZDskLD5RrcT
 cIDGEZJFE9OlQecjNzm/8qIZ9WUTHlui5pGuup5Qzx//AyKGwzoDR9Z6esMs8DIubQ1fbPejj8j
 NYoDW0Z5bCf7+aljBOwP8eqambz8V0sdUcRUMaQORUSrSnNBWXeELV+94SMPjGx2wslJLLTK69c
 2FwSow4u/2pHKqD5UniDwCkQ/mnmNx09jyJzrMJPTQiijfAlTgBxv6sP18GDaHYQ3QpUk7xnx1a
 wpzJ1khuJMk8C0z25pru5W48cft0pSplZ8aiyniLz+VfA==
ARC-Seal: a=rsa-sha256; cv=pass; d=hornetsecurity.com; i=2; s=hse1;
 t=1761213741;
 b=NXH3HXzDLo4xsqYchjsd+pAa92V7ulfHXwT1fu2ZQqBciwp6XnCnsnN5SYWWdfeh3LGhuh02
 r/j7lo9Nh771HbVshcCopnMmY0zPYnLeI+iwdaK4WHb12Y6r4ql1p0p6Ybx0l2Z/wBRTxxPdhHE
 fqQ7SwmOwz8fDCNsfKQcO/iQvmzUvFy0dcqvOMR4qyW3XSBrPv1ki24yGa8YllQN2u7Q8mZSXu1
 sQf5SUq1fiPmEEFT+rwdFYDCh+dSazDp3PkQzJ4lVdEXJkXkkYY/OTunRDnvmeJgo0Ptoszqnbh
 e0QARcnhQTm0M8U6pjibXfZD12OegthGdvGVVLdZta/bw==
Received: from mail-swedencentralazon11023100.outbound.protection.outlook.com ([52.101.83.100]) by mx-relay21-hz2.antispameurope.com;
 Thu, 23 Oct 2025 12:02:21 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsEk7H3r8SJOsAsLok4Dh2n1DWhu5SbYo8fRVnOVx1qblHjCm8ow8o1rnfEOnxu+ihZAjEROZaMOOV17wteFUDp86+Od2DXh12gcHZmnZJ0d2YoW7whiPAcS1AS/GgVU04pv9sZWMsYbBtCRfp9a1sc7XLtfwBEeEO6IbK3bn4LcWFQvvp5l+T+VgaiUn+LBfq2vDe+KRGGgqUC0ejbfnfSLpPg/hPmT40O0AtctqFZLo+h5qPa2pextLBmCAucv6RaElyif4DoouJI+u+EKUb0CPhuZE5o8UAAOk19GKS/niLXG5vuTb/d8qYhUW2CRdI4mQE2Lv4GRAKYb8UrSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gK63QYGaFCwT2oflY7M4MDkwRKTFr35KVXEt4EoUPU=;
 b=TNAtx+N6DTZY9sSY3D35MJouALbWa1EUQIG8qvRz82ygna+etFqPXnLnl2beYaq6IiIDm+02Q1zyAsJUl1vsbCLu8KM8MMMaQOgUK6+c8bbpCxymHw5H3OMR/6Y4lgH27e+rfS26HtbGMSMyf9O+/e4xjp4mpmIkAwjFUbS9s1katCGG0KAzFWX3NLuFPM1LHkK2gynxuN7c8Ty/KNPZPHskIiSERhrDBVkJf2SCOKtR464HceVYDcidjZcdm/Mi/XLEknglfVQ3Krhs5inX6D4/Hb70awSQX4uX/XxSgsBIo2waIwoZdCLWAPM6KoEvCArbtHZGx/CaXTTvK3Ay9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=a-eberle.de; dmarc=pass action=none header.from=a-eberle.de;
 dkim=pass header.d=a-eberle.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=aeberlede.onmicrosoft.com; s=selector1-aeberlede-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gK63QYGaFCwT2oflY7M4MDkwRKTFr35KVXEt4EoUPU=;
 b=fNJU48xJttguuWpzAct995WqYs6l5gmx+Rt1HKdF6P2fBhMWfMy2+gLJBNqDOqxpGHqJYWk/ihfTZCDnYLYxzYWzuoiWIJ0Z043fkidLq8Rdi9UMjZfyhkt+14qUtameN1AB+x7yN7huZMKUMw5pxADDqIIvRpd21u1HfW9VzhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=a-eberle.de;
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17a::7)
 by DU4PR10MB8949.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:56b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 10:02:08 +0000
Received: from AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856]) by AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::14af:ad35:bd6b:f856%2]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 10:02:08 +0000
Date: Thu, 23 Oct 2025 12:02:06 +0200
From: Johannes Eigner <johannes.eigner@a-eberle.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Message-ID: <aPn9HkM-mjQHEo9v@PC-LX-JohEi>
References: <20251021-fix-module-info-json-v1-0-01d61b1973f6@a-eberle.de>
 <20251021-fix-module-info-json-v1-2-01d61b1973f6@a-eberle.de>
 <0b99a68f-0dd3-4f95-a367-750464ff1fee@lunn.ch>
 <aPjxYbbiYAexF9nQ@PC-LX-JohEi>
 <82ab2f16-b471-4d60-850d-ee4b83712cdc@lunn.ch>
Content-Disposition: inline
In-Reply-To: <82ab2f16-b471-4d60-850d-ee4b83712cdc@lunn.ch>
X-ClientProxiedBy: FR3P281CA0189.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::12) To AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:17a::7)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR10MB3873:EE_|DU4PR10MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfd6705-b8b6-431d-cbed-08de121b39ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWczZStIT2xFMjNkQmt0d0I2QU1MeHFZMFBZQlZJeXZSV2k0bmVqQldnRiti?=
 =?utf-8?B?TUNtWmM1VmV6UzE0S2VxOHBZak1MZmRDeEtyN3FWZnpHMjh4MXVzZ3dLbnBz?=
 =?utf-8?B?MHhxaUoxY0cvUFlobmpnZ3J4OExlaUtzZ09Hei9nZXNQYlhzdjhGSDBJRlhu?=
 =?utf-8?B?WDJGTExFcnBzaklpNllIQWR5NDk2S2lNU2xhMU9ibW9USVRQTjFUNlczR3Zv?=
 =?utf-8?B?QnFQZnpzclVzYlVyTWNLVFRQcFBtaGxWZWVjMElSNGdrL0lQSDhsbzR4cEhP?=
 =?utf-8?B?Ukc0Uk9XS0wxZUJTazFHYlJKSHNDWi9EV0RuZzcyc3ZlNVRDak1nS0xRTWJK?=
 =?utf-8?B?VEk2TnF1M1dDeWRaNEt0OVBJWEV4K1RBcWE1MlVDTFp2ZG9FTXJwNW1mclox?=
 =?utf-8?B?TTkxRGZJYTJTazVVcXdIN3dCNjBLUFFIRkRxN1ZoYXowcVBGaXRtRU52L25x?=
 =?utf-8?B?NS93NFppbjA1ZTJwRTdpM2sxY1ZmUnhEakVnWU8zeGhBeDN1aXF2NGJiZkxh?=
 =?utf-8?B?M3M4Qk9YdXp6THhWN2M5c3kwelFWbjQzVjNaUDFReWo4L0tRK0RaR3R1RnNX?=
 =?utf-8?B?YkhWS1ozZ1h2dnQ3OUFaYjdOcXlxQWFTMC82Wlp0S0hoQ3R2MXVUY2JqU01O?=
 =?utf-8?B?dmZxcTRTTHFtdmJlSG1NSExudE8wOHkxdlhSSFpwT2QwaHBYUUlVSjNaQzM5?=
 =?utf-8?B?ZlNnL1ZEczZhb1VRN1ptTm43SC9XMzd2Y01PR1RHYnNCaUwybThBNmltTE5B?=
 =?utf-8?B?TGRrUHZUNkJsWUhkelBudHo5Mzk0WWwwczlNSDc5NGhqV0s3WkJIM1ZPZHJz?=
 =?utf-8?B?WkpiMkFkc3FEZ0JYVHFlOE5tM1lxS3ZOQldOSUZrN0xJM2cxZGQyRTRWOXpt?=
 =?utf-8?B?SVY4NFk3eW41TXQzQ3YvZHVHcWpmSC9Jam5iRVE0Sm96TU5jdWFyZVpWaUpn?=
 =?utf-8?B?WGY4Y1hvdE1uVUdtb1h3UDl5WElmS1Q5bkdpZzduUHJuRXNzeHY4RzBwRGtX?=
 =?utf-8?B?NThEUlVVYmFIUGpQQVdWR1lvakhyeko4dU91Y3BlV0twN1Z0Y3pSSlZ3bERw?=
 =?utf-8?B?dkV3MlVNWUpDbWF3elQxL1MrSUpjbG1aUldacldWNVg2TjduZ0cwR2tjeWlK?=
 =?utf-8?B?c0lGQXY3ZHlNdFYxaFFFYm91SFd4dUM5Z0p6YVU4S0lGWWN2cm41OFhSK3BH?=
 =?utf-8?B?RmFJWkVWWmxzeWNNR0JKaS9xLys5ZlViTk5WYkpFaDRudkV2MTU3QWU0bitm?=
 =?utf-8?B?K1lwMnIvblZsZjFOb1MzdlUwOG13S1dNY1NnWG5Ydk9tQ2RXd2JXSENsOE5o?=
 =?utf-8?B?RTl4RVF3WHBxOHA3cDlFNndTZFRjQ3ZaZFc5UzVpM29BWU5PWTdDcUgza0xF?=
 =?utf-8?B?bnN6NW41SEl6MFVxekJqSSt6K3ZEWTJxbyt1OUplMGx3RFlCOUZTVG9PYXAr?=
 =?utf-8?B?VE0xRGppNXlTN0N0SWlzREV5QnBWY0xqbld5WFFFY3duaENPOHFNMEVFK1hM?=
 =?utf-8?B?Mi9ZOXVsOTZsWWJ0bVRpaTlVRkpTbXFFdTZ6SnQ1cHRLbWJkM1Z3a1gvNno1?=
 =?utf-8?B?VnBhSyt5SnVrZzhnRzh2VXhMdzh6UXhEdGZRSFdvK3JKMk11dk5lL0xwYzh0?=
 =?utf-8?B?SUlKbTFkWVFmU0JWSzYvVkVoajgrSjIvaTdNamw3Znp0OHZWQUhXOWNQRkNV?=
 =?utf-8?B?aC8rRFdDdGdLTEJZTnMxWmw3a2draXdscUltaTA3Q0xvZExvZWZrTndXVUNq?=
 =?utf-8?B?bGdESkNib1pOZjZHaEszSmk5V3JEbkxKbVFXVGRQTVNrUStYYjg4MFdtcTFi?=
 =?utf-8?B?RXJ5UE1zUDcvakw0MEJZK2dVVXlUQTMvelc1eDVGVERneWZmR3ZmVXc4TlBF?=
 =?utf-8?B?RXN2dzl2c2FRd09SaDA4bGRDM0NCK0tRcEFydUgzSGxrL2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHNybGREeGJDRm51TXdjSDVjNXpTSkkxRFgwY2IwU0l6aXJWbzNIWnpTcnVT?=
 =?utf-8?B?WmxuU3FMclNDRk5aQ20rWXJjS0t3TmhxWm54TW8yVnZuZis2dzNHWHNCSERq?=
 =?utf-8?B?bkpXN2EyMEhNR1dNMjhqU3AvR3E0UFN4Y3RsNisyc1ZOQXRjd21lQmxDSXFJ?=
 =?utf-8?B?VE4wbngyMCtwMTlUb2JEc3ROcWxxWGM2ZDhrYWFQbmhzalJzV1RBbGtPYU5J?=
 =?utf-8?B?clhSVWRHYmtSZkNQY3lvNTl1Zm5RSjJIRkJCSzhiWUxSQXllTGJZbGJKVDlX?=
 =?utf-8?B?V2dHbVVGdXZ4MjdkZGE0QitSdEJJRENpMGVlV01jVEdlbXZPRGlaRy9aaE9J?=
 =?utf-8?B?Wmk2REpwRHF4VFhpVGhtOThXQlliYnovYjF3VXBJSncxREpEcEVyVjYvN3FG?=
 =?utf-8?B?U2NjdmUwbDI2aTE4QnBuOTRiMVFQWWpYTjA1QUpoYnJqcGxwSFlCSEZXQ2xE?=
 =?utf-8?B?WTNuU0RpS2c5aWhzd3NiTllsUzZLWExNd1NhSWUyY3k2OTRGdFBOZVY2L2o0?=
 =?utf-8?B?OVJnUE9mUGprTlErcDBLbWdqeVNFb3FwTmNoZnYxQXQyQlZLSHk3V2EzTGhs?=
 =?utf-8?B?TEtBVWRra1hSNVc0NnR5NVZIbzJWYnJFR3lHMEgvOHRpVkFXTFJjUzVHVXlq?=
 =?utf-8?B?YnU4Sjh3YXVIdDdockRnOFZJTFIzbjBqUUp0YTNpRC9FU1JhRjBiTXRXWmJj?=
 =?utf-8?B?aFB3bVVUTlNrL3lMT29FZGF4Sko4MHNuMXQxMEcwZUJXMm1MN3dxSllZKytx?=
 =?utf-8?B?QnY1NVBoTGFseG5zb2xBb2tKZ084czA2UDdKRW1JZGJ4eXFqcjh0eTgrVWtI?=
 =?utf-8?B?UWZjWmxHcjM3ZERLK3hjVWJtdEdwangrRUpQK2FPMXFEbUpTNVR3M0pVRkRH?=
 =?utf-8?B?OFBIeUZhcjB5bWxRNnBWbFJLNmM3MXVONE50a0VIZTRRMjNMZ3czdjlRL0tB?=
 =?utf-8?B?cEI5VkZGdEIrZTJrWWFHb3YxZXhTNGdQTkFobFhqOTFsemFOZWpxYVJiYmsx?=
 =?utf-8?B?MzNMS0pOODdpMERwbUEyN2U2NUt1SElOblZHWmdkQit5bldPRzc0VWJSd3lU?=
 =?utf-8?B?cnBma2pqSm5MQ080WGxQVXZkU0xuSGc5NE16RjV0OGo1SUNaMXdzVFhvVFhT?=
 =?utf-8?B?bjBlb2JTdWx1eWFLWmtKSkEvcHlETnpCaXNNNUY0SytmTGRiUEE0MWU5QVlw?=
 =?utf-8?B?QWVpK2ZoaFlGSHpGZHQ5VEZXZVg5a3pqdVBJbSt0cHZ5Mm43NDZScno3OTVI?=
 =?utf-8?B?QkRXOHJrdzczNXVmMmp0VUJrS2pjVnVBVW9Dd1F6OWlwOUp2NWttZkp2RjNH?=
 =?utf-8?B?QjZzTXF4YllzTTg1dXljY2ZoeG5FZ2FmNWlQMTY5UkNPdUVGeFZ2ekkwTTJj?=
 =?utf-8?B?YllKSXJTRGRmQm9jQ3hQOU5tbWpRajFKeFZndE1DZDN2cDEzWEE0TnMwd3hH?=
 =?utf-8?B?T3djK1hwbmpJYTdZMkhUdHk0MGtBUVhUbkx4RFFVcVNXVDgzMEtOemxCUkRN?=
 =?utf-8?B?U3RkcERrbUc0NjlhdUxjNEc5emJLSjljNjlZMXVHakVYbGQ3S3l3SVUzanQv?=
 =?utf-8?B?dGhzQm85djhSaVMrRW5jOUp6aWY3OTJnZ1RBMEVDQnJwOWMyeVVQeUlPYnYw?=
 =?utf-8?B?cXhoVHhGOGduSkg5QS9QNVZTZis2Sk0xQXZaZG94ZzFxaHI5NEJwVVZlaEhk?=
 =?utf-8?B?Q0J0ZGwwK044MVZNdkx0Q3kwTUNKZDdpRXQ3bllTenloWm4yS0dudHVrdG9T?=
 =?utf-8?B?QnN6ZkxZSnpXZ1hiMWVjZ3J1OC9IWVBzdmtHKytCNk1zSHQyWEJHYmRCRUps?=
 =?utf-8?B?VXB1b01XVFFkdUlQc3RBUWloT0JGLzNhYzh5N1ZzTkRzRUZjRDB0N2lWTHp2?=
 =?utf-8?B?WnVKNjVRbE1DUVNPYVlBa3dMOW5vQWJ5bkhuOXBXMXl1Q1hGYk92STkydWpO?=
 =?utf-8?B?d2VYdTducU01TGZNbmV0REF2ck1MalZtOEtBN2NEeGhLRWNHejljMzJ6b1M4?=
 =?utf-8?B?eWw1NTk3MmRsS2h4UXZjZ0VKVmExTWtwcnQvc2pVZFdhTmRVMUl3WUlHNXhP?=
 =?utf-8?B?cVZwY2hsU0txaWJBVnFYR1R6NkcxazdjTi91ZStzemt3UzdPR1NqemQxQW5k?=
 =?utf-8?B?N3djdDNUcHpuUHV0MlRITjdmQnh5MU9LTnFLR003RFZ5Q2dkNWxzd2ZkaEY4?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: a-eberle.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfd6705-b8b6-431d-cbed-08de121b39ff
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3873.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 10:02:08.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c2996bb3-18ea-41df-986b-e80d19297774
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MTn6s0fS5CI1aJ78sPYG7f9jNPyJ3UTwNk0uW6bnHw8wJzMnRKdMj65f7nZ/T17yRN33zGstfWb1V+za5wMv8ahzCD+J2HE+iLHRLItUpd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8949
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg="sha-256"; boundary="----8EEE68AB971FE1913D2AB5AA9C735E51"
X-cloud-security-sender:johannes.eigner@a-eberle.de
X-cloud-security-recipient:netdev@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-crypt-policy: TRYSMIME
X-cloud-security-Mailarchiv: E-Mail archived for: johannes.eigner@a-eberle.de
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay21-hz2.antispameurope.com with 4cshQp4QtHz17c8B
X-cloud-security-connect: mail-swedencentralazon11023100.outbound.protection.outlook.com[52.101.83.100], TLS=1, IP=52.101.83.100
X-cloud-security-Digest:7306bfe941f3dd16f90a8c039d02b5f9
X-cloud-security-crypt: smime sign status=06 sign_complete
X-cloud-security:scantime:1.667
DKIM-Signature: a=rsa-sha256;
 bh=b0yOK6jH9i5V1c0LqGdQNTIguiSqXUOohjGpUFY+N7Q=; c=relaxed/relaxed;
 d=a-eberle.de; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1761213740; v=1;
 b=WAyYtBGk4qpDnVz2tsDGAsm1pkJu5BCBzfo7OZhjGFmnxwqjQr3ssyGv9+0xi4rgaq8LZGDz
 KgCPnaVKstpHdI45ExDaiKWeLakrqWUi/OgF1a9nnrkMWpezMJ9bQyz9+KDxkouD0BFO3VcJaIW
 GkoKXTuXxirPrzEGHGV18fw2gobZktNwazpQdfpzj2ozq/kgy8hRhWqw58qMDrbXRSFaRre9tvN
 OlSRXyVAWaiHaBeQHHpk72SkbtXHtJBxFjj9ZQ/ek9zprSTS1gdb4l9Tfc3lkJmViefMLFgfOFq
 V7/Bxh1NOFycufEsTignayd2tW+eya0rJX8bK25NaJpJA==

This is an S/MIME signed message

------8EEE68AB971FE1913D2AB5AA9C735E51
To: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH ethtool 2/2] sff-common: Fix naming of JSON keys for
 thresholds
Cc: netdev@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
	Danielle Ratson <danieller@nvidia.com>,
	Stephan Wurm <stephan.wurm@a-eberle.de>
Date: Thu, 23 Oct 2025 12:02:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Am Wed, Oct 22, 2025 at 05:34:12PM +0200 schrieb Andrew Lunn:
> On Wed, Oct 22, 2025 at 04:59:45PM +0200, Johannes Eigner wrote:
> > Am Wed, Oct 22, 2025 at 03:32:24PM +0200 schrieb Andrew Lunn:
> > > On Tue, Oct 21, 2025 at 04:00:13PM +0200, Johannes Eigner wrote:
> > > > Append "_thresholds" to the threshold JSON objects to avoid using the
> > > > same key which is not allowed in JSON.
> > > > The JSON output for SFP transceivers uses the keys "laser_bias_current",
> > > > "laser_output_power", "module_temperature" and "module_voltage" for
> > > > both the actual value and the threshold values. This leads to invalid
> > > > JSON output as keys in a JSON object must be unique.
> > > > For QSPI and CMIS the keys "module_temperature" and "module_voltage" are
> > > > also used for both the actual value and the threshold values.
> > > > 
> > > > Signed-off-by: Johannes Eigner <johannes.eigner@a-eberle.de>
> > > > ---
> > > >  sff-common.c | 50 +++++++++++++++++++++++++-------------------------
> > > >  1 file changed, 25 insertions(+), 25 deletions(-)
> > > > 
> > > > diff --git a/sff-common.c b/sff-common.c
> > > > index 0824dfb..6528f5a 100644
> > > > --- a/sff-common.c
> > > > +++ b/sff-common.c
> > > > @@ -104,39 +104,39 @@ void sff8024_show_encoding(const __u8 *id, int encoding_offset, int sff_type)
> > > >  
> > > >  void sff_show_thresholds_json(struct sff_diags sd)
> > > >  {
> > > > -	open_json_object("laser_bias_current");
> > > > -	PRINT_BIAS_JSON("high_alarm_threshold", sd.bias_cur[HALRM]);
> > > > -	PRINT_BIAS_JSON("low_alarm_threshold", sd.bias_cur[LALRM]);
> > > > -	PRINT_BIAS_JSON("high_warning_threshold", sd.bias_cur[HWARN]);
> > > > -	PRINT_BIAS_JSON("low_warning_threshold", sd.bias_cur[LWARN]);
> > > > +	open_json_object("laser_bias_current_thresholds");
> > > > +	PRINT_BIAS_JSON("high_alarm", sd.bias_cur[HALRM]);
> > > > +	PRINT_BIAS_JSON("low_alarm", sd.bias_cur[LALRM]);
> > > > +	PRINT_BIAS_JSON("high_warning", sd.bias_cur[HWARN]);
> > > > +	PRINT_BIAS_JSON("low_warning", sd.bias_cur[LWARN]);
> > > >  	close_json_object();
> > > 
> > > I'm struggling understanding the changes here. Maybe give an example
> > > before and after.
> > >
> > 
> > Shortened example for laser_bias_current, full output at end of mail.
> > 
> > Shortened output without patch
> > $ ethtool -j -m sfp1
> >         "laser_bias_current": 15.604,
> >         "laser_bias_current_high_alarm": false,
> >         "laser_bias_current_low_alarm": false,
> >         "laser_bias_current_high_warning": false,
> >         "laser_bias_current_low_warning": false,
> >         "laser_bias_current": {
> >             "high_alarm_threshold": 80,
> >             "low_alarm_threshold": 2,
> >             "high_warning_threshold": 70,
> >             "low_warning_threshold": 3
> >         },
> > 
> > Shortened output after patch
> > $ ethtool -j -m sfp1
> >         "laser_bias_current": 16.168,
> >         "laser_bias_current_high_alarm": false,
> >         "laser_bias_current_low_alarm": false,
> >         "laser_bias_current_high_warning": false,
> >         "laser_bias_current_low_warning": false,
> >         "laser_bias_current_threshold": {
> >             "high_alarm": 80,
> >             "low_alarm": 2,
> >             "high_warning": 70,
> >             "low_warning": 3
> >         },
> > 
> > > The commit message talks about adding _threshold, but you are also
> > > removing _threshold, which is what is confusing me. Is this required?
> > > It makes the ABI breakage bigger.
> > 
> > Removing _threshold from the child objects is not required. I removed
> > them because it is somehow redundant to have _threshold at the parent and
> > child. If a smaller ABI breakage is more desirable I can drop the
> > removal of _threshold in the children.
> 
> Thanks, that makes it clearer. Please expand the commit message.
> 
> As to ABI breakage, we have to consider, did this never work, so it
> does not matter if we change it?
> 
> 1) Does the first patch suggest it has always been impossible to get
> this part of the module dumped in JSON format?

Yes for SFP modules it was always impossible to get this part. But for
QSFP and CMIS modules it should have worked before.

> 2) Because the JSON is not valid, how do most parsing libraries handle
> that? Do they exit with an error, the JSON is invalid? Are they
> typically forgiving and just return one of the two values?

Regarding RFC different behaviors are possible, see
https://datatracker.ietf.org/doc/html/rfc8259#section-4

But in practice, it seems that most libraries just return the last of
the two values without reporting an error. Observed this behavior with
Boost.JSON, nlohmann json, javascript (running in Firefox and Chromium),
jq, php, python and ruby.

> If it never worked, we cannot break anything, so an ABI change is
> O.K. You need to state that in the commit message. If it might of
> worked, we need to be more cautious, and i would minimise the changes,
> keep the redundant _threshold, and again, explain this in the commit
> message.

For SFP modules it never worked, but for QSFP and CMIS modules it should
have worked before. So I will try to minimize the effect for QSFP and
CMIS modules.

For the biggest possible backward compatibility, I would suggest:
* Keep the function sff_show_thresholds_json() as it is, so threshold
  values remain unchanged in the JSON output
* Only rename the measured values if needed to avoid duplicated keys
  * Keep name "rx_power" for all module types
  * Keep name "laser_tx_bias_current" for QSFP and CMIS modules
  * Rename "laser_bias_current" to "laser_tx_bias_current" for SFP
    modules
  * Keep name "transmit_avg_optical_power" for QSFP and CMIS modules
  * Rename "laser_output_power" to "transmit_avg_optical_power" for SFP
    modules
  * Rename "module_temperature" to "module_temperature_measurement" for
    all modules
  * Rename "module_voltage" to "module_voltage_measurement" for all
    modules

This results in only two keys renamed for QSFP and CMIS modules. As a
side effect this also aligns the key names for the different module
types.

What do you think of this approach? If you agree, I will update the
patch accordingly including an improved commit message.

> 	Andrew

------8EEE68AB971FE1913D2AB5AA9C735E51
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

MIIQNQYJKoZIhvcNAQcCoIIQJjCCECICAQExDzANBglghkgBZQMEAgEFADALBgkq
hkiG9w0BBwGgggw7MIIGEDCCA/igAwIBAgIQTZQsENQ74JQJxYEtOisGTzANBgkq
hkiG9w0BAQwFADCBiDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkx
FDASBgNVBAcTC0plcnNleSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5l
dHdvcmsxLjAsBgNVBAMTJVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRo
b3JpdHkwHhcNMTgxMTAyMDAwMDAwWhcNMzAxMjMxMjM1OTU5WjCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTCC
ASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMo87ZQKQf/e+Ua56NY75tqS
vysQTqoavIK9viYcKSoq0s2cUIE/bZQu85eoZ9X140qOTKl1HyLTJbazGl6nBEib
ivHbSuejQkq6uIgymiqvTcTlxZql19szfBxxo0Nm9l79L9S+TZNTEDygNfcXlkHK
RhBhVFHdJDfqB6Mfi/Wlda43zYgo92yZOpCWjj2mz4tudN55/yE1+XvFnz5xsOFb
me/SoY9WAa39uJORHtbC0x7C7aYivToxuIkEQXaumf05Vcf4RgHs+Yd+mwSTManR
y6XcCFJE6k/LHt3ndD3sA3If/JBz6OX2ZebtQdHnKav7Azf+bAhudg7PkFOTuRMC
AwEAAaOCAWQwggFgMB8GA1UdIwQYMBaAFFN5v1qqK0rPVIDh2JvAnfKyA2bLMB0G
A1UdDgQWBBQJwPL8C9qU21/+K9+omULPyeCtADAOBgNVHQ8BAf8EBAMCAYYwEgYD
VR0TAQH/BAgwBgEB/wIBADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQw
EQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9jcmwu
dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5
LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQudXNl
cnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEFBQcw
AYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOCAgEA
QUR1AKs5whX13o6VbTJxaIwA3RfXehwQOJDI47G9FzGR87bjgrShfsbMIYdhqpFu
SUKzPM1ZVPgNlT+9istp5UQNRsJiD4KLu+E2f102qxxvM3TEoGg65FWM89YN5yFT
vSB5PelcLGnCLwRfCX6iLPvGlh9j30lKzcT+mLO1NLGWMeK1w+vnKhav2VuQVHwp
Tf64ZNnXUF8p+5JJpGtkUG/XfdJ5jR3YCq8H0OPZkNoVkDQ5CSSF8Co2AOlVEf32
VBXglIrHQ3v9AAS0yPo4Xl1FdXqGFe5TcDQSqXh3TbjugGnG+d9yZX3lB8bwc/Tn
2FlIl7tPbDAL4jNdUNA7jGee+tAnTtlZ6bFz+CsWmCIb6j6lDFqkXVsp+3KyLTZG
Xq6F2nnBtN4t5jO3ZIj2gpIKHAYNBAWLG2Q2fG7Bt2tPC8BLC9WIM90gbMhAmtMG
quITn/2fORdsNmaV3z/sPKuIn8DvdEhmWVfh0fyYeqxGlTw0RfwhBlakdYYrkDmd
WC+XszE19GUi8K8plBNKcIvyg2omAdebrMIHiAHAOiczxX/aS5ABRVrNUDcjfvp4
hYbDOO6qHcfzy/uY0fO5ssebmHQREJJA3PpSgdVnLernF6pthJrGkNDPeUI05svq
w1o5A2HcNzLOpklhNwZ+4uWYLcAi14ACHuVvJsmzNicwggYjMIIFC6ADAgECAhAl
5qzXGH8Da+FSta/hHFZ+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEb
MBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgw
FgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENs
aWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIzMDcx
OTAwMDAwMFoXDTI2MDcxODIzNTk1OVowLDEqMCgGCSqGSIb3DQEJARYbam9oYW5u
ZXMuZWlnbmVyQGEtZWJlcmxlLmRlMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIIC
CgKCAgEAwEFNcbuq7Ae+YCfg2alacqHWh08bvE6bFOZZ1Rxl1w/sFuXUwJ8o+gbB
TA/mmITzst+fnsjwMmrjtCecn8wILPitSD2wXy+yiaWmn8ywuBBw8toRX0xSMgif
KM494f9SSFjJDOgZGmAG+umMO6v5KNA1K0wSWrlZmG0yC0pzp6FFVVyMnp4/vJh3
6BuYgOf0s7KK5ShCQ4mKOD0dOOcMTBFHcQuD8d2Ha9lH5KzF4CVR6W3p+DUs2r6o
WwSPc0MrTqq0Ci9KPaKmvxzMQRZqSqa5ySqyw4guw0vnPYwtS0BEYZM+mL/5BwAP
Uga7nUg/9tjzyEgUY3tmimfWD0UIi9oDHT59n4s5iriWcnZNS5dAWnu7NqEBs+w6
lpWo2g60mmxPULNnwSUYxqdfXn5udIde0boYLKfEy11JC9xkshXBgLPhq4xTkbWs
fkoH+EQyEdep5AhaLeTsJHpw0tp2whpeH9Fwck8tx/nWtudo7bfYZUF4lDtyEHmi
p7UJa6x4LKEO2XFlY5v6ZOfVAm+zqNWEdDGO3bfv3HO5ciIHjXHLVFx/XI73OVsC
aObazBuEcqXafTK9ThLS5Sh4uZ3nLv3n5m8m/UUUKbOmOI7MTId7WlP9hOeNAzEu
SiA/n8VFk4RO7iwajXximGU/0rxuUJtN7RJFumksH7sbO5ypjCcCAwEAAaOCAdQw
ggHQMB8GA1UdIwQYMBaAFAnA8vwL2pTbX/4r36iZQs/J4K0AMB0GA1UdDgQWBBSz
BXMVnJ+omSJdNUgpzP64lg+gRDAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIw
ADAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwQAYDVR0gBDkwNzA1Bgwr
BgEEAbIxAQIBAQEwJTAjBggrBgEFBQcCARYXaHR0cHM6Ly9zZWN0aWdvLmNvbS9D
UFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0
aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCB
igYIKwYBBQUHAQEEfjB8MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LnNlY3RpZ28u
Y29tL1NlY3RpZ29SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTAmBgNV
HREEHzAdgRtqb2hhbm5lcy5laWduZXJAYS1lYmVybGUuZGUwDQYJKoZIhvcNAQEL
BQADggEBAMJhsGQW6C4UBZr7OpMg/n65GOd5Iy7i3vXW7gO7sgPe1pHYi1LJZ68J
lB9sP93yDViPMJ4Cir+/QqU7AtLyKkf+oo8nQTlx5gQeJnftZ/O6RkCS20I18GxC
aRDRRwD2JViL5Dk9uB87sV5DlOZV8w2VNWh+mm8wZGonaQ3NoNX+7jHcF5QX23Hx
x8ikwfv4jj3qajpv1l362Wl5FySKhdEXB/hhyxLjMfHEYs8PKHnjeWGbMPnqyTtt
xgnK+Gtmc4fjSlRf8Nzpr/q3iPppdSOmVk1lGmaGTJ+7ItiA1OTcFf7Atm8GomFp
QXdyoI/DW3zj355K+YADYhwhosfaQY4xggO+MIIDugIBATCBqzCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdv
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQ
Jeas1xh/A2vhUrWv4RxWfjANBglghkgBZQMEAgEFAKCB5DAYBgkqhkiG9w0BCQMx
CwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTEwMjMxMDAyMTNaMC8GCSqG
SIb3DQEJBDEiBCCKlBYn3qm9qkygUyCgY01Yy+k7O2U07F3WhxmWgqJ/XjB5Bgkq
hkiG9w0BCQ8xbDBqMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUD
BAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAH
BgUrDgMCBzANBggqhkiG9w0DAgIBKDANBgkqhkiG9w0BAQEFAASCAgAWOE56qv46
lE5EFWJtyJYE48tthRokRctagQCSxWPfOlD8tU8N7F6scLMh4aEdo+JHlQkxL9nk
KDtYxDt6lgAmUWQu6MpsAAgfRPceFEo/L0RR+xkVSDQCWofaZlM9jPi6dLXTKOHJ
TB2Z4Uy7nxqiezFmoxE3QP97s5l12GispqyNRsyGprSWnRtBMOpfkNrTsv0h2jZt
SED4Jqua/+qgldrG69yHW0HrzYVs/5ee2iXC1pgwYQqR6koA4tVqQcJJurtDe1Re
9BZ2kMji5fyMz8uVbHszAdOqooOZH6P6+y4GzZPUbzRDGUsBgUlvhn/jsUsCdhGR
hKKLILWrqeadqyWGPTD437+P1ZY+O2+J4OszEpbA76A0q3TNkF3s4TML2rSx+ChS
PV5YEBc8J9VzP64Y7kJBMP1VdVR9+xSppCzi8LYuH5wr1bNZHlXq2AdVgTvbxsP/
Eh1V58BtXgi2ml5b5pzuapoGFmHTyzUKiwQCyRGdCdzPb7jpYMHQMOJ5JcfABbFu
LygegRCCc07BhHefLtz5bKOOfXVwtQfgyHvoPdR3vNJnHlsEPucNV+haF/Hp1rlN
d6aqM/6LEfKVH6Ntujbnh6EjcJt9m57YeTAvq2hngq8l8yRntMsYE5hVaV+8/FvT
UyPYhZvN0QE6CGu3bYxL/zSnJDxmEkLE8w==

------8EEE68AB971FE1913D2AB5AA9C735E51--


