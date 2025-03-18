Return-Path: <netdev+bounces-175720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9942A67421
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D457A19A5D4C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E920C016;
	Tue, 18 Mar 2025 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AaA6NUgK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BED20CCED
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301459; cv=fail; b=HgrJX5QpRPTpIBTfWUW6fiwHTqK5hMuztqpgqJ0IxAtEH0YIPhCZXwuMFiVGX/FycYzW1g7KmcvUvqz7Rp21aqp6gaWaa0gCI2KIqpwLI2sBCRdFo54xuMy8fN+qE4JsYMtdp6cQ9p/efdqNC2b26w6Y3YR5KmS1xymMzvnxRJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301459; c=relaxed/simple;
	bh=hWgGyI93ipc96qOJ1iH6j6fIr8ORowHDlPzAV/ly7i4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Po9TCUlL6Emj99KIhfu+7sdufkbZeLcueF1xK8uyIHsuvLLiEhUKbSbjE4Kk+0J52/DjOksW0WJJuUAmi6SOVhDo2iZj2EG1ry6RfMisvzF5xHjihDRT5tFpuh076FXBsYF6ptNTtl1EuV+sFqjtmdbXTvNXFNyBZ6B4Kmq3uMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AaA6NUgK; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rh+gVBpbtg6oQmMAa9oBJSNSdQsM/HKzVH/YCfofjQ7wMcJBQpBLgsE6drbDLIfWK5ZLpo9h6V6GyMMsXMwpuuo7lFpOjkFkq2mY7fIZ3HdtUXVZfmuJcVG1PMzh7BWv1lPjfMqkJJ7DGyL8aMobvyky/+SBGSY2kd9Xfgg5h2YeDkcRrHHpwgqLuLqf55cOvAS/28jfcMOyBKVtIARh9gL6x6MaKfeHCtrZ5mSO5PsNP22DUkOFcsJzBpAwMbY6IH/tanzGz6Lf9QIpAsY+/IAPcOLWaQ6YwtzNip7jXoS4ZgYxp5nFyTCkt8L7uQESaPMWvxbd5QC5JjifVwaEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nchx3MHk23omaJjzJmFklKIJIePofEk2MgIZTYJ0reE=;
 b=AEiKTNTnEfK726qr99QqiqtzqsnwjtApo8MnvAi21NbkSkfxv3SUXz5USv+sD47wHX8TAqcVsnbe0A3SGzWS4kJSPKyfOLkBlWHevJpXmM5QbA7wedVvLhD+0WG6qt0QtaT/gJ9IQTyqwtYZpz4YW6UmRae05Zul9JQ8dNTIZX/XqxVSlI6TnvIt8koyQXqj4710RpBra2Zx31v0t1/YYGimouf/nv+HZl5h3UdgOHvcgofzjZjpWFOVOroKAd7zkIz5zSGAygEDqzPxe5Ym4HOS+WKYnbp+MZkqQ0ptMYzMw+iub1ZZdFZeZoaRsLtkhTay/haOaZzct876t0jAcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nchx3MHk23omaJjzJmFklKIJIePofEk2MgIZTYJ0reE=;
 b=AaA6NUgKt6N0Tp1+GecZElmYRLIcGvHM3XNxrElRTB7CkMPzgLvRzH6PQONjKBLjLoQK9c8eweRBGIMCjZFO0b924MVM4lMi18SG7VFTn9PhDLEy3baCikzn7/f1jR5ZVsZ8syL9ruOC+GxuyJmJ9j4oLHIEEkBu8xiqMkiiYbaozpGe5v8UnI8v6gE2EU6Gu215HhyMMVmNli10l+/y85bruFm5aWaO70fxnsyjC9ALNaK2BBBDxbvK1X4xUzOYaC1AzsfKAckeKU9hT/IUesZbMLBGPw+cCrsZd+8M/XikYfGE0yAlBogpVqz/Q7BS62ApKqJOr2g3LsgmKraHEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:37:33 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 12:37:32 +0000
Message-ID: <b80bf69e-85f6-4e7d-8774-dc88878b45f5@nvidia.com>
Date: Tue, 18 Mar 2025 14:37:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xfrm: Force software GSO only in tunnel mode
To: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: Christian Hopps <chopps@labn.net>, Cosmin Ratiu <cratiu@nvidia.com>,
 Yael Chemla <ychemla@nvidia.com>, wangfe <wangfe@google.com>,
 Xin Long <lucien.xin@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 netdev@vger.kernel.org
References: <20250317103205.573927-1-mbloch@nvidia.com>
Content-Language: en-US
From: Mark Bloch <mbloch@nvidia.com>
In-Reply-To: <20250317103205.573927-1-mbloch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::8) To CH3PR12MB7548.namprd12.prod.outlook.com
 (2603:10b6:610:144::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7548:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b33d0e0-6806-43cf-e01d-08dd6619a76c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXEyUHpKbktKcitPcm5aSXB4d095SHBUT1A0bmVnUURsUnBUYXczK21mdVlw?=
 =?utf-8?B?VkpOT1BCcGFvWG1xOVlXd21obVQ3YnlCeStnSGt4RUpqOWRWMmUwZnlPRitP?=
 =?utf-8?B?ODVnc1N0eVJ0MnpGK0NSTkJLWWpCNHQyWlJqTlZpdEF0akpVVkR3M21XcmhL?=
 =?utf-8?B?Ky9zeHdjOWVBSnFpSmcxQmFLcEJheDk2OEVOVGp1UjFTVkdiU1oxYmcrWW1w?=
 =?utf-8?B?UzIzb3JMdlAxTzJudCt2cGJNVnduUHY2dW1GSkU5cU5Lby9VeVBKN2g4MGdG?=
 =?utf-8?B?MkFCdmRrcEUrSmdmYzBJbHc3enB1NDZkRUhhZUx0ckJWNFV1a1U3elZCVVFE?=
 =?utf-8?B?Y3lXZWpadEZMN1YrQUZDdVRWWnU2dUIzRFFlVmwvZ2pnTUI4UHRNMVZoaWJT?=
 =?utf-8?B?LzNESGVUKyswN3hEYkhJL1duck5DVmlvU1R5NzNnVkt1cFdKU2VuWWFRNGpy?=
 =?utf-8?B?YnJSaTE4WExvQWs2VHRzRFI2SzZRU05iWUdTYkdDVFM4c09xNUNaR2VJelRP?=
 =?utf-8?B?amtyOWgwMVE1Zll2UXhPcGw1WWc4OTg2dE9QdXRhMlJXYy9uZVZJbG1PRHNh?=
 =?utf-8?B?U3poalk0MHl0VGVPOG04VTBtL1pnWDV4MGtQcm9MSGJ5NDBNdmJiMytaRU1G?=
 =?utf-8?B?QXpaUXdnUXRSNGJ3Z1pucnA3MjRDYUNiQWxOenRjUC9hZUZKTVkzNzhnOVAw?=
 =?utf-8?B?WTVSN0tZMThVRXdBdVhYMGNod280bjNNOHU2QkQ3VjI5UERCMSt6cHVKVnJ4?=
 =?utf-8?B?cFZJTEp2N2g5Z093RVRDeGppcHZob0JMSllkVHlkMEtON2doc2ZONDNFSTU1?=
 =?utf-8?B?U0d4SUY2c1FjUXFvY0NqU2laL3g1R0RGM1RtS1E0SmVtREpUZUYwZkx0anh6?=
 =?utf-8?B?Q0dvck9kUVo5YUpuL3hCSDdFZXJSdldLUzg1bWc5dnRieVMyQ3RXb2xNdGE3?=
 =?utf-8?B?UUtkZVVCM3BWUWVqdUhYMU9KcS9zNTRpWkE5T0EreW8rYlNlcS8wdCs4bUFr?=
 =?utf-8?B?QVorOVcrL25TMWZmb0RwaFhQRFVEUitRYkx0a1lrR0VJSG9BMzhBeFpNYW5E?=
 =?utf-8?B?aFZyRTFjSE5na0JxWkhsV1NGY3hFS3FQSjZEZDdiMHQ2TllVY3graExpQ002?=
 =?utf-8?B?c1hDd1ZTQWdQTzE3M0dKck5LcjV4ZXE3Q3RTcVN6UlBaTExjZHJrSmdwdzhh?=
 =?utf-8?B?K0VpNWxQQ0ptdlpndU4rU0xRV2pJSHIzYzhhb0llVFh5djNKWWhKQWdGdlVi?=
 =?utf-8?B?eEpTc1NjM3ZTQldrK3RTVjJhSHVWVUN1SmhuY3I2SUZvT2ZXc3NRSGdUNnNa?=
 =?utf-8?B?QnJWMGxVYVZmMzBLRmIybjJlQWpoS2Z3UTlYVGZDbC9HUnV1ZHhYd2hoTVNw?=
 =?utf-8?B?bXM5a1pQYVFLalJvU1ZsVS96TVBPS3VTd1lnaWRxZFVGZjFJbnJBUUNpaTJi?=
 =?utf-8?B?VjJubm0vSUorbVFidjZyMkx4WE1pWnlTMkZFcy9obFB3cHhMWThMcVF5V0Ft?=
 =?utf-8?B?QnFPYUtGSlNYaGx0T0xFeVBuRkhHQnIvYWNQa1dMaWhtejR5ZXFhM3ZSbC94?=
 =?utf-8?B?dk9US2kzRkJKY1Evbmt3NG1nOGVTbDJoSS9xdkxFNHhlamNuTE9CZUorSUlj?=
 =?utf-8?B?MXp3dzBDcjk0VXlDU3JwdG9Sc1czaTZTWnFiMm5PWnloM2lSLzJlL09pSmVJ?=
 =?utf-8?B?MUk2dUNjRG1kTHVGeUY0VTRuWWVZclVWenhhZEFTRmFkcjIvTFBHem1zY21W?=
 =?utf-8?B?akcxakJoYllOcGdYZG9FVlhHMGgzaEtsc0xOdC84Z1UrLzlQaWpDSzZudTM4?=
 =?utf-8?B?Mzk1QnUxRXRkd2s3Y1htUkd6Qm5Xallib2VxbmpBeFpkVU5lMkd2aFh0WkE4?=
 =?utf-8?Q?OKKkIXaV2HKh7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7548.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0RRR0NmSm13ZWJDazVzNXp3TTBNSnowY1g4b1NUMHhSY0R0VWNYNVoyQXVq?=
 =?utf-8?B?anRyc3FuRHJiaC9nbVFvYkFDVDlxUHdlYkNTL05IN1NtVy9YVGVkeU1nd2Zt?=
 =?utf-8?B?QzNwei9TRzA4cFpnRTBWNFVkR0hRSnFUZVZDQ3d0V3VSTVVyTlNIbGZ5cHha?=
 =?utf-8?B?RklPM3dPNUk3UEUvYUlqczBMblhNMW9ycHFXQ3F2OCtuYVh2bkFRK041TEx3?=
 =?utf-8?B?cFpwMStsTVVhaSthTlpuY29RaUN0bzErZWJWVWw5cWdZT0hzMkRDaHVXNnNS?=
 =?utf-8?B?am0zZkdZNlR4WEltam5UbGFoRjAxOU9UZ3lyU2Myc2dtY3IrMnFRM1J2NTNV?=
 =?utf-8?B?UUdPdnpvUHUwaVk4aktTNEdoR2FGK2dvMXE0RGc2bEpnOGlxV3hVUHFteVZa?=
 =?utf-8?B?NHNNRUVXNGRhM21wZkt5N01pUjl1TTA0di8zVTVxTW1ZbWtTNWx2VWZMdUcv?=
 =?utf-8?B?Mjlqc25lZ1ZhSHFjRGhaTjkyU1VZZUkvOGhIaXcrdkVMYWttMUt4NDVJNklH?=
 =?utf-8?B?bnRRVXFhN1MxYWxuZFg0dDg0Rlo4d01YSVEvQzVud0dYNGwxYlZjUUtVVjFN?=
 =?utf-8?B?UXdTQlJBazRmS3YrWkpvcHpyRGlkWEFoUGl3OVFYTS84ZmtmTnFCRjF2UXFw?=
 =?utf-8?B?aSsvTVVUN0JFYzVJT0ZVaEJLWmloQW1LVFN3U2pza0h6TzJPM0FxcXdkTDFS?=
 =?utf-8?B?bk8za2hLdVZTb3FXVzdxdGV2L3cyTzJkREJnU0U4MThtZUlaRVI3SExpNmVM?=
 =?utf-8?B?eUJESHJxWHJqNWxPR3FuUFkwcW5OdHQwZzJha04vOTlWbkZuVjI2dXpNYlRQ?=
 =?utf-8?B?U2RoREdnZURJdFFPbzZyVEk3eVJ2alZON0NGR0NhM1dxVzdZdi9CMzZuK1Ja?=
 =?utf-8?B?UFB5UEkzUXhpcFNJVDFLZ3BBMTZINGV6VEZ4cE5zSjJWVkhCVllhdU9XVWVQ?=
 =?utf-8?B?VDlmL1RxUnNhUDRqVHU5VTZVQTc1WTVPWmRBYXQzaXcxSTl2ZEMzSTFpTDVP?=
 =?utf-8?B?a1hRMnNucGZHVldoV3U2c2FNcmdmcTFyRUJDVHdFSytLdXcrYkNPRlBTODEv?=
 =?utf-8?B?R0NvYUowZ29FNFBFZDdEUkpOZ216ZDhERVlXS3VJM3NEOXhlT2VmVmxqOWt4?=
 =?utf-8?B?NWIyOHRrNndEMzlCekZncit2OER1U1Q0MEpzK0FKdnhyYUNQSks4aENjYjhm?=
 =?utf-8?B?L3h5M01OTlo0N0NzTEF2UUI2Rm1FbVJxRmh5ZmY1S0VwMU5kcm52bElJaXJj?=
 =?utf-8?B?YkxZeWZrTldWc3VrME5vRmZGcDFYQnBzTTdEaWowR0JNelVvcUM0ZVY5L3k1?=
 =?utf-8?B?eG8wZmUzS1gxUVBPVXJob0EzbDUyalYxS2FNY3FhNDZ6QWpWeWFMTFlTcE8z?=
 =?utf-8?B?a0RHY09aREFpUWt1ZGZZb3VQTGZTalFVSEpZaTNMclFUOXE0Z242RCtXUDg4?=
 =?utf-8?B?TDBaMzViTjlZN0x2b0VJSjRhd2V0aUZUbEZaVS9HVjlkakp4UlNNdEczZGpp?=
 =?utf-8?B?RkdRbGI2cG9WTTY4SjBBMndJUTBKcGI0UFZYTFdVdVBsWUlER3NlUVM5TG81?=
 =?utf-8?B?enNYRXhhVm5rRlUzOEhBYStnMnlROW9zWHVSQVF0OFlRSXZLMllRcGZCcXEy?=
 =?utf-8?B?TzNmd0xWZmJQZC9NSFNxMVBsT0hpWThlelJLbEZKSnBUM0s5WG0ybTZGVk1l?=
 =?utf-8?B?cFYxZm9hbXFJZS9oYVZ2M0lZMGdpM3BqQVZxZzlvcWZ3ZlpsNWtUZXJXN0c1?=
 =?utf-8?B?L21EMnJDZXZtZllJTkVTZFpDYTg5NHdRRXNpL3Z0UE1DMm1xejJZYlZyYkQ2?=
 =?utf-8?B?MWpwRTM3M0VKdTZ5SE93bCtGSEZaYXl5Z0liV0pFcUxhZmhlYmpobVpYdm0r?=
 =?utf-8?B?ZGpxWjhaeTlXUzBSNDAzZUEvZUVYWi8vNE1JRFVFUW9TRFNxUnYyeWdBQmdJ?=
 =?utf-8?B?aGx2R3dqWWtQdGg0RXBqdnAwTXBxSGdVd0RJTWNHTGRQNUVXeUdMb2hqS2hC?=
 =?utf-8?B?cjlMeUNGRlA5QkcyTktDZjNkbktadEdyL0Q2ZUg1MnZSaDJzcmZOcEV3UXAz?=
 =?utf-8?B?WXJyVnhmUkx2ZFhMYU5JWW80ZUd5OTQ3RUR1NHBSYjlQQXhiTDZDUmFkd3dm?=
 =?utf-8?Q?RMRg1KnTDecgpE/QJs/qWa8xq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33d0e0-6806-43cf-e01d-08dd6619a76c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 12:37:32.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLq+RWoj9cVFCILyCnYz84jcWV1IKJ0fTCkr+7wRlzGGhm0773xHOWjCyHfie8soOacgqixv+Xvtl26jiHmxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349

Apologies for the confusion, this patch was already sent
and accepted by Steffen into the IPsec tree. Our testing
didn’t detect it landing in net, which led to the
mistaken resubmission with the “send it out before the
merge window is open”.

We’re fine with waiting for it to land via the IPsec PR,
so please disregard this version.

Mark

On 17/03/2025 12:32, Mark Bloch wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
> mode. Unfortunately, it is slightly broader than necessary, as it also
> severely affects performance for Geneve + IPSec transport mode over a
> device capable of both HW GSO and IPSec crypto offload. In this case,
> xfrm_output unnecessarily triggers software GSO instead of letting the
> HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
> a back-2-back pair of NICs with MTU 1500, the performance was observed
> to be up to 6x worse when doing software GSO compared to leaving it to
> the hardware.
> 
> This commit makes xfrm_output only trigger software GSO in crypto
> offload cases for already encapsulated packets in tunnel mode, as not
> doing so would then cause the inner tunnel skb->inner_networking_header
> to be overwritten and break software GSO for that packet later if the
> device turns out to not be capable of HW GSO.
> 
> Taking a closer look at the conditions for the original bug, to better
> understand the reasons for this change:
> - vxlan_build_skb -> iptunnel_handle_offloads sets inner_protocol and
>   inner network header.
> - then, udp_tunnel_xmit_skb -> ip_tunnel_xmit adds outer transport and
>   network headers.
> - later in the xmit path, xfrm_output -> xfrm_outer_mode_output ->
>   xfrm4_prepare_output -> xfrm4_tunnel_encap_add overwrites the inner
>   network header with the one set in ip_tunnel_xmit before adding the
>   second outer header.
> - __dev_queue_xmit -> validate_xmit_skb checks whether GSO segmentation
>   needs to happen based on dev features. In the original bug, the hw
>   couldn't segment the packets, so skb_gso_segment was invoked.
> - deep in the .gso_segment callback machinery, __skb_udp_tunnel_segment
>   tries to use the wrong inner network header, expecting the one set in
>   iptunnel_handle_offloads but getting the one set by xfrm instead.
> - a bit later, ipv6_gso_segment accesses the wrong memory based on that
>   wrong inner network header.
> 
> With the new change, the original bug (or similar ones) cannot happen
> again, as xfrm will now trigger software GSO before applying a tunnel.
> This concern doesn't exist in packet offload mode, when the HW adds
> encapsulation headers. For the non-offloaded packets (crypto in SW),
> software GSO is still done unconditionally in the else branch.
> 
> Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is set in xfrm_output")
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Yael Chemla <ychemla@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  net/xfrm/xfrm_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
> index f7abd42c077d..42f1ca513879 100644
> --- a/net/xfrm/xfrm_output.c
> +++ b/net/xfrm/xfrm_output.c
> @@ -758,7 +758,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  		skb->encapsulation = 1;
>  
>  		if (skb_is_gso(skb)) {
> -			if (skb->inner_protocol)
> +			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
>  				return xfrm_output_gso(net, sk, skb);
>  
>  			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;


