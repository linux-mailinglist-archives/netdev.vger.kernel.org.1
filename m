Return-Path: <netdev+bounces-217079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A295B374EC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410EB1B64D44
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C2229AB1A;
	Tue, 26 Aug 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="g3v8XzDS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2115.outbound.protection.outlook.com [40.107.102.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE84A28751C;
	Tue, 26 Aug 2025 22:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756247881; cv=fail; b=bFnXX/Da6ITjFzvJbLuoWOG6enLJUz0aMaAQNQs4YBEQIvcRg1HQXAxdL3qDtA12kJXm02TuRzfwwrszQ0iT0ckxPztp1a9vSeJE4TD9cEFp9NNmCgZQBm/T8gBB6lmCsaaeNlAeM6D+Rx+5wToJNtbrKGZfvGMZNQy0aog+qgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756247881; c=relaxed/simple;
	bh=8h79CH0TrUy8UzNs1haodTtMMY+fYGKETlo/itQ9Bgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UYoYdasdOGTIOtluJ1BVnHo9QP5yE+UeWVb3J+bgYMhDdZwJnjIzdzZ9L1SiF99KzE6sfka5blWr44+ZkQvI/GiErqChsvCm8hTtNK4ehjyP/k2pcKHa5ca6oKHuDD4R8na/3tSAhnCy2sc1GancrTc5/Bk1imkNbDBWgvnriyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=g3v8XzDS reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.102.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEXr2tcO+9fnblV/ucj3zSQruKklWnwTyGnpZypb9HspcBa+KPHsEqKljSKNjW3lBoIdm4ho2YS7xjfA4YPQ3TYps34hHZv7u7Kwq//PZn9PuDjMFkekVh1tyNvyaVWtIFkFR23VvfBtoY1LQvcnDjuwOsctkWDHNwRl+wTCy/UP2ROSpbeWfg/Ii9DQr7ao5Z2c+93NEUpussCfKyNS0BpGbSxni26HJZ5dNVhpuajcs7opSAKN4chQA7yT2zK2LzYmttWAfsYk26UWE3ZXSeDAtZZL7gQFdDbH2I+hpZ15WgE6SPHQKZywLcbSIzoJ1aaTER1uV9x2e8DeXVaQaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SrAhDGfNWW1Ow1ezIYRC2COloLQSyiZ5y7rikU6F5/4=;
 b=J8VBIn28T6OPJLtx1CzrQX4XbxOsukJrpDoNtiGXtGH6RlHUWoXYyFzWJJGLR1Kvd+P1a2W4v+9pkQmvclL4txCum1gbi91a1zJo2CK3nQNWaYzxb4RF4RakHqOqbUuT792NQhoDTy6QUJIDpmRgi2l6MUM3Lm6PEucTORhpD9ACligtzFUwHawMJM1PVQCSfeSCoy5DUe3QmL3By0lVKhwfMnV87lPltn1woBS1Ik3hNURlDstkME+vc4JsOwaXdlSvfK/cvGBgxWtfl4gQZYZDeJ4LmNYXNKieBEb9Vqabjf1+7w20+NB2C0TNpnnX0H/0mNSkomt1FMd+wUjAYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SrAhDGfNWW1Ow1ezIYRC2COloLQSyiZ5y7rikU6F5/4=;
 b=g3v8XzDSmEywHXjxn1PW7c0jUG9Z2I+gWA9o9jiUwXU3hHp/nezWKic7UzPkEUdWfMKraCMp966XD9xkQbA8k8NWV9SvU/wUv8r3U5UMfvHhDtbm1e34pDhFfI/MxrKaSCnJxP5ErAn6AZaaL7ytWtPRHR18aWt9OONxlIwd+io=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SJ0PR01MB7284.prod.exchangelabs.com (2603:10b6:a03:3f4::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 26 Aug 2025 22:37:56 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 22:37:56 +0000
Message-ID: <f3e65225-0560-4940-9342-7ba12807cff8@amperemail.onmicrosoft.com>
Date: Tue, 26 Aug 2025 18:37:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 1/1] mctp pcc: Implement MCTP over PCC
 Transport
To: Jeremy Kerr <jk@codeconstruct.com.au>, admiyo@os.amperecomputing.com,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250819205159.347561-1-admiyo@os.amperecomputing.com>
 <20250819205159.347561-2-admiyo@os.amperecomputing.com>
 <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <88a67cc10907926204a478c58e361cb6706a939a.camel@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:930:cc::8) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SJ0PR01MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f82090-dd34-41b0-ff43-08dde4f1335b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VjQTRIbTZ6WjhkZzFVWXVBQXg3MzhMV05YSWltTmVISmx0MUFLSzlRUUJB?=
 =?utf-8?B?TXlxL0p3bkY0azhUdVpxN29zV3UxbXBLWWNGVzA0Mzl1RlF1K2lOQmg4QThQ?=
 =?utf-8?B?VXJmaEJYMHRsRUhBZ2lUM1JWRWlmditlM2hPQUM0ZTdReUZZSnlFQjNySG9n?=
 =?utf-8?B?WkhUbjU1UHgzRjByTzU5ak1WWCtDM2RlUWh5ZXZpM2ptN0dvRzNjZ1JUdUs4?=
 =?utf-8?B?RVJVS01GM1FnY3p2T0t4d3lGRVpLVXEwOUZKa0Roa2UxQnNiNUZrTVFwQnFm?=
 =?utf-8?B?YitRRUdhK0R0TEpITkRLTnpiMGdLRFI0RXBmbElyNWVwelFyYk8wbzd3eWxh?=
 =?utf-8?B?MVZqa1lQSjB2d2RDUWE0bUx5bmZldDhoa3ZMWTBvTlQrWnJ3aTZqNFNyQ1E1?=
 =?utf-8?B?VWRNeGhxTlVGQlUxdlhsdmNqd3dneTY1bVFxc1lGSEd5RFFOQ21rY2ZpWjRE?=
 =?utf-8?B?dTNpZFBnMk54bW5scG9vU3J5N2JVaDNrb3I3Y3pHQXhVaVpUdFVqUEQrYmRv?=
 =?utf-8?B?a1U2N1RsbHllTkF2QTdnNzNORmZsZlZ3N0FZYUI1ZDFMY0VVZnBqSjJNZ2Rl?=
 =?utf-8?B?eEUyYVh5bElXWmR2SFpBZG1xaVU2cGhsNThtZjloVHRmVjM3QkMvT0NGdTVM?=
 =?utf-8?B?RFYwTnNPTlZ2L0RNNG9ITWN6RGdwTlJKckJuaUFoZmVRcVVPZzJCZ1hCeFVq?=
 =?utf-8?B?ZG5tWEwzN3Uzd3lXRm9ndXFUOWRhMDAzNmg3ZWNYUHVNMGNIRWxidVhuSmgy?=
 =?utf-8?B?N3BKUXZWanJ0a1Q3TmJTZ3FUT2JRQzczbXJPUVRCcDlwZWwxV1VjbVRhQ1dU?=
 =?utf-8?B?UE1ReTZRNEtIM2pQLzR6TWxUOExBa3U4M25VdVV3Nnc1TmxVa1BVN1p5Q2hx?=
 =?utf-8?B?TlBVUkxUKyttVmoyOWRjZDBaTXJNN3gxZm5sZkFPMGh6TU9VeXMyOXZYbnZN?=
 =?utf-8?B?R3pxWTJxaEpSSlRqNC9MQ2E3eTg1NVQwUkQ4eTdnb2lRRlpOTDlrSU96RjVL?=
 =?utf-8?B?ZnhGU2ZrcFJsNm1Yem9GbEV3bjVTRjRxMGZHSHpKU3N0bzFhQkJyU20wbEd4?=
 =?utf-8?B?NkpzMXBRd050bzUrcmEyLzNKK2xpZ1c4S1UrUlp6M256N0RnallScWNRY3Vp?=
 =?utf-8?B?R2draGUxVWQzUmRwWjdWekVCYWJzQ3VBeUtrRklycjgyMEl5YmxhVCtOcHZl?=
 =?utf-8?B?a3NGeXp6TXJ0d0h1VjhXT1d3UXc3MVVrT1dTSkFoSGQ0VzBqZks0SEZGU25O?=
 =?utf-8?B?SmFXOHJvTkZhS1Y4bFdkUk10K2ZoZmRnNHZ1UVF4UzZXcld3djBoV0xjMDlS?=
 =?utf-8?B?THBvSEcrL2N1bXBnaE1KZDVRSEp1ekJrNkxtN1NoS2Y1TnF2dm5XTlZFK0F0?=
 =?utf-8?B?ejVUaE0vVnU4R0ZRL3JraGVhTW0yampWS3hreUVwalJWR3RieCtrSkEzRjZo?=
 =?utf-8?B?Mm1lVTdCL3ZVYUt5cGFLMk9xVGREckxhUUhlU1ArNmluUWgvV0JGWXArM051?=
 =?utf-8?B?N3gzQWZPeXdjbkVLWmkvM1BzUlAvUXFhcW4wQVF5alptMmR3UWFvS1AzY0J4?=
 =?utf-8?B?SDRENVFuOHBrWGhzR3hFekxub2kzdmd5ZjZxREdFQjB2RGRydXJyMHAvdXhI?=
 =?utf-8?B?L3lGdnhvTHF4bmE3MXBaSDRWb1F3NGdUK1dYKzlRWmFFUzdQcVBzcXFRNDl5?=
 =?utf-8?B?N2o0Q2NqeUYvMUJsb1VuU2g2N0RmVkdpaDVwSmtBTnFSMkMwWFU1YWg1Tms4?=
 =?utf-8?B?OXBtK3hzU3BKc2hzWnMrZzFOclg0S0hidUgzQVYwc3d6YUZzSzBqRTlWeWpP?=
 =?utf-8?B?Q1c3NnFEQmdHTlJaZXRHZHAvWGczU3h0MzI2V25UQ2M3SGlFb0I3MnMrSnZj?=
 =?utf-8?B?MkV4S3BOeVpPazZRVGsrNGczK29Ub1dzcGt0K3NFMXh0eDA2RmhrTmp0Mkp6?=
 =?utf-8?Q?JS4KSMSr0Ok=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk51MENZR2xrOGJXOTlXbk5xV2FoSnpMOG5aRkJyVGVGUHVXMGZaRDhoMjdL?=
 =?utf-8?B?dmJVc3A3MTA4MHhuNmNGZ05TZ21YWFdDSGQ0eGZPMmxjMm5yV1VkNnlJeURQ?=
 =?utf-8?B?a2I3cC9Md1ZPTGMwUVJ5WTBrMnNhUktNSDNKakUrYVVqeStJaEZpdDZCNUZN?=
 =?utf-8?B?WG5LVzQvYTQ5NjFwOFBQRVl1clZMd0Ivejk2eGdPTkcxY3FrOHFyczdpeXJV?=
 =?utf-8?B?T1JidFRDRGhaeTV4LzFCNERYOVBBbGtoUXB1YmJ1VFFnZHJhOWpLeno1SEZG?=
 =?utf-8?B?Sk43NFJPdGJvYkt2SnoxQW4zWmtYMGhLQ3BxWndnR1doZFlDWkJsWGw1MW1Z?=
 =?utf-8?B?d3dTcGkvNC9BM2VkbVFpdGpBT2Q4bU0yL05TWFk4NGF2ZlZpT2syUmFwMGY5?=
 =?utf-8?B?VE13TVE4YVlpQ0ZFTm96NUxZWUpSd05vcXFIc1VKZUhaK3V0enBySzgvVStO?=
 =?utf-8?B?YkxGSEpIYnZLUjMxSzFIL1BkaHFyYjJrRWVML2Vkcm9heTFIQjlOclBzRkR6?=
 =?utf-8?B?ZEMramlXOTY2a0gwZDN0NkZMTkFINEd0ck10aHdhSFZETFpOV29vYklXVmZR?=
 =?utf-8?B?ZWVWOUU1U3V5ZDU2ZERib1ZhWWlwVkUvUE8zU3Evamp6TkxDNVdoWVRzQWV1?=
 =?utf-8?B?Y3VaOUhiU0xJVmc3OWxYODBiRVdNdmR3a0tEaDRVRHFmSjdxYXBoTlo1c29M?=
 =?utf-8?B?WU1iZytiMVQ2TnhIYk5NM0o2S1I3TVRVTlh2TzhNM1NXSm5aTnFwU0FBaGcz?=
 =?utf-8?B?clBuSllRUW9TNlJhRnJ4ME4vOW9VRkhLaTFacnZrSDJZaHIrNHI0NjhzSDhq?=
 =?utf-8?B?SjdES2xrR0Z4cW9XK1ZXNVhqNDJiRmhqajcxMEsvK1I5eVZuS1FseklZUnk0?=
 =?utf-8?B?RmVySkp3QnAxeUFQNVY1dU9vT1E1Qmlld1dMRUNjTDFyU1cveHpuQitGV3VF?=
 =?utf-8?B?NXNCeUw5eEpmUUdUbGxqS0VGVmZScUtZTWNzVzZLeG5IUjNnaWx3c2hHWnQy?=
 =?utf-8?B?b0hYUElsM096MkRCYUVGMHo1dHBqNHlPTWxEcy9UZU9hVThyWlBZbWxpcFFR?=
 =?utf-8?B?elJjN3diaTVGMGp4YnNwSkpTbFZONkZMc1h6QlpYKzRzZUl4aFo5NGtvMjRF?=
 =?utf-8?B?RlRNTFdjeDRNdFI3V3lGR1ZMRlJBNWJGM3FxRi9mUHpZcEJlV2Jjdko2aVc1?=
 =?utf-8?B?enE3Z0VtL3pxaXhyeklXbko3NHBLZFkzVDh3eUd6OSt4MkF6MXhGYXdHdjh3?=
 =?utf-8?B?WXNqRWQzUFJrUGhYK0JMa2dKQXIyZjhRTm40czA3eWl3amNXR1cwRFhLQU81?=
 =?utf-8?B?bjV6dXZSN2M4ZkYwTUI3ak1TODdrTUdITGgwV3E5QmI3QU5aTTRXdlJrZkw1?=
 =?utf-8?B?aWNuZ01uMjE2WXV6OUFtR3VVTzJnemVVYlZOcWxxY3ZVMlRhUTVReEtNRVdZ?=
 =?utf-8?B?czJHY042dHpZNUNHK3ZQVHo1Qkc5S0tkU1ZnRlhaQjRxZ3dSRzB5VlQzM2M4?=
 =?utf-8?B?MkJtM213NGkyWlc1aGdLUll6UEJGU0lRcWtwYWJTSVNZNUpZZHZGbkE2L1g3?=
 =?utf-8?B?RjlrZnZKdjJlSVJnS2owTUtXZDdxSVROWXRjRnBDK25jcVpTUklmNlFwQ0hR?=
 =?utf-8?B?NzZCVVViU1Y5OGtybmVpSE1MQUo0MkJCeUJ1WXBDckxYcDFteTJUWU83b1hq?=
 =?utf-8?B?dHg5UHcvTCtxdUN0WE84UjR5aEcvL25zcTRSM1AwVDVQSndaYnp3WHhKS21U?=
 =?utf-8?B?MGQxaGQ2TkZVYUpaUVBlS3pEdjlETjJXV2duQ2JDUHFJYXJnak8rV0h6cWVM?=
 =?utf-8?B?RWVPckV2L3dRV3o5OWk1cWdnMUtpYkhKaEFMMHl4NXN6MmswR05EMXVudmx4?=
 =?utf-8?B?WjRuYXpzMmJ6U0g2akFNQTVIZzByWGdham15WGFVU2lrZWZHNmJNLzdIcWd0?=
 =?utf-8?B?WTBYZzJDdUlPc0dENmRLY0QrS3RGTll6djg0OWk5UHpUeVZzMDhpVmhzcHp5?=
 =?utf-8?B?ZldGOHl3MjhqN1JNOHZLUTVlQ252YjJPR3ltV0NWNk9JK2N2azJzUHdXY25M?=
 =?utf-8?B?Y1A3UWs3Y0hVQm5zQXcvdGtpZkVCaG92UEs4NmJNSCsvWlZIRElJZllRZU5O?=
 =?utf-8?B?QlVoVGFLaHhwYzRZZ1IxRC91U2tEUzdBMzMyeW94dmo1UXFHYitPV2ZiblN0?=
 =?utf-8?B?NWlsVW5lRDNNRU5pSG9CQ2F0MUZZZXVHeS9DZXcrRUp1d1ZTNkdrZXJmR2Ir?=
 =?utf-8?Q?LgcyiQdUAYW88GzBSOkY+IvFLcUWOUQeMspzDIxVrw=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f82090-dd34-41b0-ff43-08dde4f1335b
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 22:37:55.9607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAQXPgizjb36R9mLXMIG1xax3+HzMWk5QNYmB/L3wCaPLSiVmjfi7P2oNxj3tfN+wEq3opk4pMTJ7C1BAAwhYzxtLB08kLgxeNWpBLmqEsJuFAF8o/l84j6Bwj2ymKzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7284


On 8/22/25 04:21, Jeremy Kerr wrote:
>> +static int mctp_pcc_ndo_open(struct net_device *ndev)
>> +{
>> +       struct mctp_pcc_ndev *mctp_pcc_ndev =
>> +           netdev_priv(ndev);
>> +       struct mctp_pcc_mailbox *outbox =
>> +           &mctp_pcc_ndev->outbox;
>> +       struct mctp_pcc_mailbox *inbox =
>> +           &mctp_pcc_ndev->inbox;
> Minor: I don't think these need wrapping?

The outbox and inbox lines are longer than the mctp_pcc_ndev line, and 
they depend on it.  This ordering and wrapping passes the xmas  tree 
check and keeps assignment with declaration.



