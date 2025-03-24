Return-Path: <netdev+bounces-177144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF94A6E091
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C22170507
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6A22641EC;
	Mon, 24 Mar 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SDzNzPij"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE86C2641D8
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835973; cv=fail; b=OYur26DYXlqAHsD/edJ1cwcCKP5p4/t/Z/j+59ZkE1TGUgb30foid/NFzjCboqyGgij6bF2MlPrBc0eSzaSDMLwnsnu5yqhvisBMwkkw3hVRIronCL0AzyWuR6w1DPtSJYAOcLEWPQhoeyiPp+GAVWfVikmPwFPEx+v4lO7AklY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835973; c=relaxed/simple;
	bh=5vSXPHqWSh9N1sKuRJ3yYy5RHixTMlpHFfsVfdOa+7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fmwVK9buN5N5L7AlatSn+qAUQZFp1T6mV4kKYyBrusuTYAlM6p4YovNI2KQRKRj6NnZxEsq7LmyEtkINQ5Ez3001xKA38Ij8MSTEbraqEgzJMephptqFJGvT7cTRT/YcdnnXbn/n8/762O3GyBI7Z5ulifbTltZnwNbQspvT/K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SDzNzPij; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnW+3vT2P8LBl1y1ZTbhqX5a6KnXAFpJJXNM09yu2iH2NzkZeCsQlS5JIPOP0AZ9iIDpQC2v8oaDYYlD9+QHJ6JMM+e5jicA202ACPg8okMczNuJfjkeugIcg3EDAfgofcYH77aJrk2nTPsuhZPb9yNBmFiAWOTlv3sIHxeB9mZbiqTfL2LnNxtaRfXIlX+5pE2tpRtcD5ao6GUIwut/rP1Vc/e8GRsclmTMH2ktAw4VFSuDkxZJHohzTw2qL7BV1mdOGQNvFAPc70bcavK4T2u8HAace9n55/NUouUSiiqstjsVFvWbso6xijV7BOLyvjhktCA/YDWtYSYkg2oPKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vSXPHqWSh9N1sKuRJ3yYy5RHixTMlpHFfsVfdOa+7E=;
 b=is7DMaXRwRLBqAJFkZAU32b0ObqwJ46MFUIoZwURcqD4qqIy4Bf4hQZYfG00yhC2YCRPaWUw3yKaisN7/A5swnxfS+vN+EosxxcylWzOmzbmgr2p2nwRv05LCaZCvI7ObxAVIMNg7+jnLfm7xWd8Ie2fryNBE8gLlDPhl4yJzNfMn4cdX+RwB+w3H890gMgZDiljHIUFiYLUfhyr0RVfDKc9yO8m2cxnrqbfrNUnBhDekUaDopwct/5RueBwWr2PEASXD4bT/8PBdd68TMzYp5vvpRU2mnYdlPC4HssilQW9dQpEJJ9L9tHJqoIf7Jetqn4QUnkP4eHzqF6iKQK5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vSXPHqWSh9N1sKuRJ3yYy5RHixTMlpHFfsVfdOa+7E=;
 b=SDzNzPijZLUw5wQqBp/NtsEbQV5k0gQoiDEXjsoYxQQ0ZXXBCE8Gg19py5oN8hNFxm/NtD10Ks7S7gKubWiqqEaRPv6r+d9DGNqz1BWF1z30qv7PphXM2gdWU/G7h1TvUt2Wuhy3BG9PLee2w3d3gtjO0Ps3HN6nEDEzH0WHg69GAfOmZlxeEg7hXSIXhhnh/h4yTsMZ2KJjQ8/c5FsUY19AJMsQj7IsBOT3ZoaL/OpOpUoi0D44XXdlBXGtNT0aTAjkJ0lmPdy8tB2147ckegq7m9Xn8ctFhgeACSMWKr6D0LM98iXyKKWEVJWOo8d6dWQl+kB+Svymdk37na05Xw==
Received: from DS0PR12MB6560.namprd12.prod.outlook.com (2603:10b6:8:d0::22) by
 CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 17:06:09 +0000
Received: from DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af]) by DS0PR12MB6560.namprd12.prod.outlook.com
 ([fe80::4c05:4274:b769:b8af%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:06:09 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: "stfomichev@gmail.com" <stfomichev@gmail.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "saeed@kernel.org"
	<saeed@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Topic: [PATCH net-next v10 08/14] net: hold netdev instance lock during
 sysfs operations
Thread-Index: AQHbje0W2l3ubLQ/uUepzvoMt3824rOCiKAAgAAI7gCAABCogA==
Date: Mon, 24 Mar 2025 17:06:09 +0000
Message-ID: <8e5bf1dffe7c5ae2191e9082dcd0f72469b4fc0b.camel@nvidia.com>
References: <20250305163732.2766420-1-sdf@fomichev.me>
	 <20250305163732.2766420-9-sdf@fomichev.me>
	 <700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com>
	 <Z-GDBlDsnPyc21RM@mini-arch>
In-Reply-To: <Z-GDBlDsnPyc21RM@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6560:EE_|CY8PR12MB7171:EE_
x-ms-office365-filtering-correlation-id: 5af84b8a-30c9-4752-3ea7-08dd6af62c22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RnI0dmpGejF6dHlEMXgrUFRZMzFTeElONStMSDZDRDhBYUlNNC9iQnMzMGR0?=
 =?utf-8?B?aFVsZ2phR2VhRk8rTXYrREdPWkxjV0U4MStMbTFwQ09JZm0vWDdQanFaVzFz?=
 =?utf-8?B?aSt0ZWk4NVdQS2RsckgyNENpMXlUQW9CU1NvVzN4YUoxaDNOK2svcFdTeEJQ?=
 =?utf-8?B?SzJocWpZUzM2TGlEUjlKbDEyaU41eFRmR3FNUS9uM0E0VHg1anJ3K2ZBMmRR?=
 =?utf-8?B?cXhyWGxpWDFlTnJyaVhVY1VDdU1BOUlhK1p6eGdocEF4TytXOEwzTE9adDZH?=
 =?utf-8?B?enBmaUFhUzBuZFNQQ3BEYXN5M2RaK21MRGhwS0pGS0tyVVVQTWU4bmNIanU2?=
 =?utf-8?B?RUZqT0oyMjhBeTdrSXpZWFVQVlI3aDVURFZKUS9wOTkxc3I0ZFp4ZW9ZL2l4?=
 =?utf-8?B?SEtHNVZ0eVh0aGtvWENjeElIQXFWUUk3ZzBrOXoxS0FYcXJzSnNCQUFBRUlS?=
 =?utf-8?B?M2tWODdNZVBzRGVvYXRIWVFZR1k0WlZKbFh2RzVhOUloeE0vUE1Ed1pOeTU4?=
 =?utf-8?B?QTg2eGlqbjRMcmNjS28xZXhIWTFRQkgwVkROb251UVlBSkpEalhiRWZFYko1?=
 =?utf-8?B?SEp0bEEvak1veGVzQmMvNGlTUVJYVFFhUlBvT0lRc2k1Zyt3N0xITWE5VUlv?=
 =?utf-8?B?Rm1BM01UTG45MEFjTmZmTUlESW9NMlRjYWorVm5CbjNCTmUzUGZEK1dtSXpj?=
 =?utf-8?B?Z1pJN2ZydDNLZEkxR3VaMVpqb2h0dStmMHhkSWhCa21wSFRwd0FxWk0yeSsx?=
 =?utf-8?B?ZWRIY1NGZDN2MFQ2cEFvdm5KYnFYYjVqUUF6VlRjMnBtNTcvMHQ5d2UzR2Zj?=
 =?utf-8?B?OXkxUnkvVGFPRGlQVjg5ckNtUExhOWpQY1czRlI2TDVJYk9XWGs4UTNBdXJT?=
 =?utf-8?B?dy9Bcmc1Q3B2NVhRZXhFTEpodzBnUVJLbURqckRCbTlMeTRuUTMybGdsRWxp?=
 =?utf-8?B?OUhMQU9XeFhNNkF3ZlM0cVQySm1BOXZtWWZnZVdkZ1FRZytZZ3hpa0hUY1l1?=
 =?utf-8?B?ektsSWV2L1lwbEFOWCs0VUZZaHFzbFBiMnExMkhxSW4zeC82QnRoN2YxRzVq?=
 =?utf-8?B?VElYVGNNeDNwSVVzVVo3dDVUKy9XekkxUjVpMmZTcWtKWTFHbVUzaHhuTWJQ?=
 =?utf-8?B?aktVdzE2SE1DcDlUSDhvZ0JxdXROWUpPQWEwMTNRb1h5YnZEYldJQkhoZmlm?=
 =?utf-8?B?akp4ejQyLzRrbGIvMEIySnFYeHJZQndhdCt6SWI5OEJVS0hqM1BRNmVWT3ds?=
 =?utf-8?B?dEpqSm5uVEdiQWZNcldpYXJBdnp1UFhGVHdEc3JOUUh4d2JkTHhwcFBBYVA1?=
 =?utf-8?B?b1NIZW5oaUw0OUl6RHdHd284NTFzaFQ5SzBCWkVXSHJ3bFExVVNpMmZCd0hK?=
 =?utf-8?B?Ly9xSWhuTWdlTE9LUVZ0NnZZbjZpZnZLcnU2YVpONUhuSFdWbnoyWVB3QmZx?=
 =?utf-8?B?RkdONUpJN01WNHM3TDJiSldML3psR1RTYlJRdVdNWmxKU0xsTmdjWXBnUkha?=
 =?utf-8?B?V1JYR3luMWZ0QjRVZWN6VzVteWt6OUUyR1M1ZWFUdURtMm1VZXBqVDY5RXlI?=
 =?utf-8?B?ZHRVSGhTMENMYkhSRndSQzVpSjJFU3lKcUg4cjhrNUtOQ0FkalpDVHk3YitB?=
 =?utf-8?B?QTZtMWYrTmsvekVvUEdqaDdzNlM1ZUdIRVZJU1JHaWtLZjdsVVRQQXRrK3Uv?=
 =?utf-8?B?T2g0aC9BN3BHMEgrN1Z1ZmFGSFpvM2VyVzU1bTdyRWpZeUlqYytXaWRIWHls?=
 =?utf-8?B?b2JYcVM2QnZSOEVwVDJRVXhTc3U4UDVaMVpST2I0UnJMNVZkWXBmZVhyVEpD?=
 =?utf-8?B?TDgzU0pzajF6MU1YOWlOT1dEbUd6MmR5T0tDZWtBanNTTk5WZEJLK1pYZTc1?=
 =?utf-8?B?c0lLQmJzV2sxbTAwem9WRnovQzJJTm1rTmh6Vm1pb0djajN6NHBBZk1ZVGIv?=
 =?utf-8?Q?PBsj5ylYuzXYjIlKPZnGRP2nfbtXcoO9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OE9CTWVUMzVMSmd0RWZIaXFSRGNLV1J4TWFWOElHRDZZUG1wYW9yaEFHKzE5?=
 =?utf-8?B?bE5iYzVxRkJ3VS9ENkU2M3Q0VjdQUE5RK2pCZTdJZkkzUy9GSWxiVXZscm4w?=
 =?utf-8?B?RDBtN0dTTzhRdG5mZnVQSEIvb3J1d3RTaWhIZE9HNC9BaWQ0eVdjSE53ayt3?=
 =?utf-8?B?bDY4ZVgxdnB6ZlN4My94cVliODNkTUY3d3hHeFBsZmdMVmJ4ZjBWU01NNS9k?=
 =?utf-8?B?eElub294eGQwb0puNlV4L2s3NEJIZHV3cnVoZ0RaL1hMdVUwZG9xLzRNdlda?=
 =?utf-8?B?cjU2L2JDTmYyNzNXMzdtN2xaQmt5Z1NyN0pDNFZwMk9lVnEwcFNMNHlEcUtV?=
 =?utf-8?B?dkk1STZyQlVnemw3ckozU0MyenpIV2NjNkJNUGlHcjlyY3dkZm9Jemo2Z3Bv?=
 =?utf-8?B?NUEyM3JTZkhQZDA1emtZYkJjZGpEcTB5aEZNQnpNWUgyOE5VNy8xdEEzSkVs?=
 =?utf-8?B?d3NpQW9MWVdreHVNWmRLMFBXNGpUV2cvb3R5RTliRWJvWW50ckw3MkdPR1J5?=
 =?utf-8?B?UEZEUlovZHBlNnViT0Jib01qam94WEV3YjVpUXgxdWZsZ3ZQOXJ3RjlTZkY4?=
 =?utf-8?B?U05wc2ZoS2pHV1BZb0xYQUYxT2tHalBiOTdNNHV3K2J3QzZYanRhYlRKcjgx?=
 =?utf-8?B?QXpLNkU0elNzMWF5N1d5OXA3eVA2THV2ckp0OTlMSDI4MzJVYWQrMmx1aHJn?=
 =?utf-8?B?NU9ZaHk5Q2xUcjdxWDNsS3FyT1ppUzdNdnBJUkZ0OUdUMklaWHR6TnJ3QlJs?=
 =?utf-8?B?a3dYNGVmdWZnU1U5Skk2RmpubktRNWtiSHd3VWdxOTZqcGJWYXZlakkxYjhz?=
 =?utf-8?B?NFA1YUF6aWdpRlNMd2ZoU0l1U3BNRHJ3RE5jTmZiK2Q5YWcxaTNVYUZDbDRp?=
 =?utf-8?B?ZUdJTkJZUXNKaHpsT0NkRkRTZEx0N0FCdWlRL0NxZkFtd3VlSnVGaHBtN2px?=
 =?utf-8?B?dmtEV1hNcWIzeU1wbW9NMDB1OGV4aTQ1bm9uUm5ka1FlUE0rQ1FsNHpZVnQ2?=
 =?utf-8?B?TUtlV0ZySTRZSDRxbjN2dW5hNUE0cHA0ZU9vd0l1WFBqMnJ5QjZTYWpLWWty?=
 =?utf-8?B?WjJQUG1KMjIwVFRVUVFNWGlHQWswbkxXVE84eFcveHNMNlFDdUEybTRIREpl?=
 =?utf-8?B?YnB6R2c2Nm5nVGZ3cjVxZEJyOUVvWXhsSUg4VTcvTDdZNnBBRnpZdFlOT3VO?=
 =?utf-8?B?MVZNR2NDRGhqWU1LMENFK3l1SE0rbkxwY2xUY2dhLzA0NEc1bUxEVUoxcURV?=
 =?utf-8?B?YVZvcnAyaWpxd216RUtqb1ljRHB0YzNIMjg3MUNVYkxJeU9pSWtsNFIzUVAv?=
 =?utf-8?B?NDlrSHN1bGFwWmZRN29zZFBoVXZYVDA3dlltdzI0ZEVoWWFHaFJKZVVRL2hN?=
 =?utf-8?B?akJNZk1YcW5hemE4ZTdkOUpXTCt5OGVvSzU3Ym4xRENQM2Y5OXdGeGFwZkgr?=
 =?utf-8?B?RGtpMVFXeFBVdnE1UnpZcldJUlUzelJ6Y1hmdExBRG94akI0dUlObnpWRnlE?=
 =?utf-8?B?aUpRM0FQaTRRMlpBSUJINFlEdU1vV1RKbUtSNk1oTXc4STlPT2lVM0RHOFYz?=
 =?utf-8?B?ZzRhMTlEdm1Sbkxpc1BJT3JoQXR4cVl0cjY4WVZyNUpQU3FJMUFtMmFSMlFN?=
 =?utf-8?B?VXUybExQNnpjNXppbUc4MktRSnhNZHR3L0tBL0J5YWNwVjRETDl3S0JuOFFo?=
 =?utf-8?B?d3FBSEdlOVRxRFBlUVNyMzdBTFpSZFprazhaMEx3ZVZ4L3VmS0V6OEZSaGx6?=
 =?utf-8?B?STNkd1BrVDkzK1ZLQXRaNUZpd3ZVOG9tNXIyOXFWTXd4V1B5MjFlaCtEcTky?=
 =?utf-8?B?aFBXa01mN1dNbERiQzUycnFXRUVIbzZ3T3VOekduSUFQdEhmV2d4NHd4UkQy?=
 =?utf-8?B?LzAwZk5JN1VldmdCaThvU2xDMTdBS3FSUkoxb1doTFlvUiswTTdpdlVuSHRs?=
 =?utf-8?B?NHZMblVBNUVVWUIrNTlxbzN2bXppOUlnNmJQQ3dadHpRZmoxajZoTGlDcGh6?=
 =?utf-8?B?ZTZQdEhyOXhUSWZJT3V4d3dxcmhzTjh0cjhBa0M2c0tadTFjUU1yRm9UeXh1?=
 =?utf-8?B?M3J4SEx2YlBCOFFjS0pva0ZkcWFkN2lnZGU5K0IwTWZNWThvNHVNbnFQNFZm?=
 =?utf-8?Q?zyrzJgTFAgC3ZA7bitZ+CcpDY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7459FD2648624445A451A1CA71E79707@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af84b8a-30c9-4752-3ea7-08dd6af62c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 17:06:09.1068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5eoVv+lpvGmbgHGZr/AzkPGW0y7VgciOPblRGv8R/XaLMWU60a5Oybzj4ln1emh8P0DD+skr1ypYOMwjo3EXfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

T24gTW9uLCAyMDI1LTAzLTI0IGF0IDA5OjA2IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+IE9uIDAzLzI0LCBDb3NtaW4gUmF0aXUgd3JvdGU6DQo+ID4gQ2FsbCBUcmFjZToNCj4g
PiBkdW1wX3N0YWNrX2x2bCsweDYyLzB4OTANCj4gPiBwcmludF9kZWFkbG9ja19idWcrMHgyNzQv
MHgzYjANCj4gPiBfX2xvY2tfYWNxdWlyZSsweDEyMjkvMHgyNDcwDQo+ID4gbG9ja19hY3F1aXJl
KzB4YjcvMHgyYjANCj4gPiBfX211dGV4X2xvY2srMHhhNi8weGQyMA0KPiA+IGRldl9kaXNhYmxl
X2xybysweDIwLzB4ODANCj4gPiBpbmV0ZGV2X2luaXQrMHgxMmYvMHgxZjANCj4gPiBpbmV0ZGV2
X2V2ZW50KzB4NDhiLzB4ODcwDQo+ID4gbm90aWZpZXJfY2FsbF9jaGFpbisweDM4LzB4ZjANCj4g
PiBuZXRpZl9jaGFuZ2VfbmV0X25hbWVzcGFjZSsweDcyZS8weDlmMA0KPiA+IGRvX3NldGxpbmsu
aXNyYS4wKzB4ZDUvMHgxMjIwDQo+ID4gcnRubF9uZXdsaW5rKzB4N2VhLzB4YjUwDQo+ID4gcnRu
ZXRsaW5rX3Jjdl9tc2crMHg0NTkvMHg1ZTANCj4gPiBuZXRsaW5rX3Jjdl9za2IrMHg1NC8weDEw
MA0KPiA+IG5ldGxpbmtfdW5pY2FzdCsweDE5My8weDI3MA0KPiA+IG5ldGxpbmtfc2VuZG1zZysw
eDIwNC8weDQ1MA0KPiANCj4gSSB0aGluayBzb21ldGhpbmcgbGlrZSB0aGUgcGF0Y2ggYmVsb3cg
c2hvdWxkIGZpeCBpdD8gaW5ldGRldl9pbml0IGlzDQo+IGNhbGxlZCBmb3IgYmxhY2tob2xlIChz
dyBkZXZpY2UsIHdlIGRvbid0IGNhcmUgYWJvdXQgb3BzIGxvY2spIGFuZA0KPiBmcm9tDQo+IFJF
R0lTVEVSL1VOUkVHSVNURVIgbm90aWZpZXJzLiBXZSBob2xkIHRoZSBsb2NrIGR1cmluZyBSRUdJ
U1RFUiwNCj4gYW5kIHdpbGwgc29vbiBob2xkIHRoZSBsb2NrIGR1cmluZyBVTlJFR0lTVEVSOg0K
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNTAzMTIyMjM1MDcuODA1NzE5LTkt
a3ViYUBrZXJuZWwub3JnLw0KPiANCj4gKG1pZ2h0IGFsc28gbmVlZCB0byBFWFBPUlRfU1lNIG5l
dGlmX2Rpc2FibGVfbHJvKQ0KPiANCj4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L2RldmluZXQuYyBi
L25ldC9pcHY0L2RldmluZXQuYw0KPiBpbmRleCA3NTRmNjBmYjZlMjUuLjc3ZTU3MDVhYzc5OSAx
MDA2NDQNCj4gLS0tIGEvbmV0L2lwdjQvZGV2aW5ldC5jDQo+ICsrKyBiL25ldC9pcHY0L2Rldmlu
ZXQuYw0KPiBAQCAtMjgxLDcgKzI4MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgaW5fZGV2aWNlICppbmV0
ZGV2X2luaXQoc3RydWN0DQo+IG5ldF9kZXZpY2UgKmRldikNCj4gwqAJaWYgKCFpbl9kZXYtPmFy
cF9wYXJtcykNCj4gwqAJCWdvdG8gb3V0X2tmcmVlOw0KPiDCoAlpZiAoSVBWNF9ERVZDT05GKGlu
X2Rldi0+Y25mLCBGT1JXQVJESU5HKSkNCj4gLQkJZGV2X2Rpc2FibGVfbHJvKGRldik7DQo+ICsJ
CW5ldGlmX2Rpc2FibGVfbHJvKGRldik7DQo+IMKgCS8qIFJlZmVyZW5jZSBpbl9kZXYtPmRldiAq
Lw0KPiDCoAluZXRkZXZfaG9sZChkZXYsICZpbl9kZXYtPmRldl90cmFja2VyLCBHRlBfS0VSTkVM
KTsNCj4gwqAJLyogQWNjb3VudCBmb3IgcmVmZXJlbmNlIGRldi0+aXBfcHRyIChiZWxvdykgKi8N
Cg0KVW5mb3J0dW5hdGVseSwgdGhpcyBzZWVtcyB0byByZXN1bHQsIG9uIGFub3RoZXIgY29kZSBw
YXRoLCBpbjoNCldBUk5JTkc6IENQVTogMTAgUElEOiAxNDc5IGF0IC4vaW5jbHVkZS9uZXQvbmV0
ZGV2X2xvY2suaDo1NA0KX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4NjVmLzB4Y2EwDQpfX3dh
cm4rMHg4MS8weDE4MA0KX19uZXRkZXZfdXBkYXRlX2ZlYXR1cmVzKzB4NjVmLzB4Y2EwDQpyZXBv
cnRfYnVnKzB4MTU2LzB4MTgwDQpoYW5kbGVfYnVnKzB4NGYvMHg5MA0KZXhjX2ludmFsaWRfb3Ar
MHgxMy8weDYwDQphc21fZXhjX2ludmFsaWRfb3ArMHgxNi8weDIwDQpfX25ldGRldl91cGRhdGVf
ZmVhdHVyZXMrMHg2NWYvMHhjYTANCm5ldGlmX2Rpc2FibGVfbHJvKzB4MzAvMHgxZDANCmluZXRk
ZXZfaW5pdCsweDEyZi8weDFmMA0KaW5ldGRldl9ldmVudCsweDQ4Yi8weDg3MA0Kbm90aWZpZXJf
Y2FsbF9jaGFpbisweDM4LzB4ZjANCnJlZ2lzdGVyX25ldGRldmljZSsweDc0MS8weDhiMA0KcmVn
aXN0ZXJfbmV0ZGV2KzB4MWYvMHg0MA0KbWx4NWVfcHJvYmUrMHg0ZTMvMHg4ZTAgW21seDVfY29y
ZV0NCmF1eGlsaWFyeV9idXNfcHJvYmUrMHgzZi8weDkwDQpyZWFsbHlfcHJvYmUrMHhjMy8weDNh
MA0KX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4ODAvMHgxNTANCmRyaXZlcl9wcm9iZV9kZXZpY2Ur
MHgxZi8weDkwDQpfX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4N2QvMHgxMDANCmJ1c19mb3JfZWFj
aF9kcnYrMHg4MC8weGQwDQpfX2RldmljZV9hdHRhY2grMHhiNC8weDFjMA0KYnVzX3Byb2JlX2Rl
dmljZSsweDkxLzB4YTANCmRldmljZV9hZGQrMHg2NTcvMHg4NzANCg0KSSBzZWUgcmVnaXN0ZXJf
bmV0ZGV2aWNlIGJyaWVmbHkgYWNxdWlyZXMgdGhlIG5ldGRldiBsb2NrIGluIHR3bw0Kc2VwYXJh
dGUgYmxvY2tzIGFuZCBoYXMgYSBfX25ldGRldl91cGRhdGVfZmVhdHVyZXMgY2FsbCBpbiBvbmUg
b2YgdGhlDQpibG9ja3MsIGJ1dCB0aGUgbG9jayBpcyBub3QgaGVsZCBmb3INCmNhbGxfbmV0ZGV2
aWNlX25vdGlmaWVycyhORVRERVZfUkVHSVNURVIsIGRldikuDQoNCkNvc21pbi4NCg==

