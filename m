Return-Path: <netdev+bounces-271731-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMfoKKtBxGlvxwQAu9opvQ
	(envelope-from <netdev+bounces-271731-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE332BAA6
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFF1030193B2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672B371CE4;
	Wed, 25 Mar 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X6v4oAgx"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010012.outbound.protection.outlook.com [52.101.61.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFEB1684B4;
	Wed, 25 Mar 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469540; cv=fail; b=Ms0IeKvNOayx3Gmtt4oIj7LbspUr3fd/GRfzVwgC87Qb1mVzBLXaa8qvce43OS+dgp5q2BNQl6YQ0SX74LF/4xPTUV15JsYUzeGRDnlmAVSP9RXkwygacDdXJjCOq8XaFKoCtnQ4kwiCm/b8hazGNLLSGaPkgNNHyce5vwlLR9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469540; c=relaxed/simple;
	bh=0IKWc0pGRuYkvXfQXiFYeyZJ2ZnnZYz7y83x7LevGcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MHf4Ihjn0BeRsabIzLOJAd9fSg9DMHRi6Ti0bpeJbw4CFxYiZUOBIl4jUAB2JugczoXnI41wYQnlDiW0IZkHzxLB38idBl3OLIsRO4JBXNh749D3c6X/d824+odT3wOMytqIYhtpXu690bQr5A6iXONpy3wOt6kAszsbWAn9eEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X6v4oAgx; arc=fail smtp.client-ip=52.101.61.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eon0PI4oU/FjKQvg6PaiTdoTet8P5AY6YJHoJH/TmKv0+lw4LvLs/kkYtbfOk0MujX4l+eeH6882tR2X5W5dMFJat9p1Dp8D1bJIBz1v6cSzHzDtcH7BbL46ACwoltfSL+XTmTS0xu+01ZvHW+KT+v85RkRHHMbytjzNQfdX7AHd7PsuPTfoBwtlAP+OUXSqTyL065+STF1i1RjKMvfyNZfkvSgQuxuVN4rxeSgzs8lLYy2gkmKDWJd/jpqBbLM/7+gfhVsjpLhP63paL19GSdtF7H0JuntSbLJz19KSbNqpGLp5VZYZ9k0xyK6EeyGNwPXLHDhFr54Xk1RxD2aXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U10/QdBDRPCFiOPeqx7zADIJQOp/bPtUOPfEq6rEv0=;
 b=ZjHwt4/rwGmj+5b42xRX8btmLnwdtPZwtWNkGBVcgWh0kcJs+pVX9Fb+ySVAHEo7W827ZILBqMRM5ULRHtalG+eYOgeGQZmn9moy/px6fn4hIAeJ1H0dCAr8Z7Lg7RXiSUiO2dYd4FEK37qbfGauAVNThLiY39FuOsfS+uWXEW/ZPN4E0QrjivytLOQsKkSsavC1qvMndY+WgemaBJBBoTp7Wt7toqh22d0VyqNiKnl4bApX6jOLIVBsl/Cv2wSNcB75gcwCHAR1i+mRBtvl7RrG/6g316yePUU7yGB+Cj/sQDObAtnxMQ1m03XX6G8DfLscvHdtCk4cyLhBBQXEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9U10/QdBDRPCFiOPeqx7zADIJQOp/bPtUOPfEq6rEv0=;
 b=X6v4oAgxcqt9TAlaQpa+Rlji2nDzBTncQvqNWJMPoWbYPcjZS+Hf3OwWHSlZh0nSe7TWthPjZGRuI/S6ikwxomv6ZLjrTh21kgpTgPW6jluNZmuYBzpfwabAOtwk21FtHqgqHrRODXZBBjJIUAGNAlfDnAZz9siSz2o+TmagfQBr4leXtXz7iOwPpw3YCHgMfAF0CtievodhzZqCf0pX73yHPlZcYWqtgDsWLzu6KoxOv3u+/2lvqBgnbswC7SgOpjsvnVj2jRAh9cr28qWDbSoZw9pLS2dWCnnwWIvcb9Fyv3bw9SljBfy9rTeF/VBwXkRYDknlvNfWu7/KgqS2XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8202.namprd12.prod.outlook.com (2603:10b6:8:e1::13) by
 SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Wed, 25 Mar 2026 20:12:10 +0000
Received: from DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e]) by DS7PR12MB8202.namprd12.prod.outlook.com
 ([fe80::38fd:4146:aea:639e%6]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 20:12:10 +0000
Message-ID: <27376c12-33d7-4da2-acc8-dd42aa347e64@nvidia.com>
Date: Wed, 25 Mar 2026 13:12:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: bridge: add stp_mode attribute for STP
 mode selection
To: Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org
Cc: bridge@lists.linux.dev, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Petr Machata <petrm@nvidia.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260324184942.2828691-1-aroulin@nvidia.com>
 <abb8a10c-571e-44f2-a15e-1d5da288963d@gmail.com>
Content-Language: en-US
From: Andy Roulin <aroulin@nvidia.com>
In-Reply-To: <abb8a10c-571e-44f2-a15e-1d5da288963d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To DS7PR12MB8202.namprd12.prod.outlook.com
 (2603:10b6:8:e1::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8202:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f60b1e6-5138-4872-474b-08de8aaacba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	VqXOd0lpP3QnpFHJlSmMNfVhn/XzVfIerBQ32yg5QkAnSfu4ItLZQ9Qk0hyUr6URa1FgNNfFqln7nputETphwbc/uah2ceRG0f+7/5TYDOlY4b6XF4cUI9ZP/VmQv+zhTIOV8Txq9UNLhIlp0dXe0exkM2tj74bzvmV/tAJjniCkqWr5t3vdorEEVEYCfl7nZS00yNEqhlYEVM4Scl7ZC3BdTWdPQhrUVK+Gu6x4EjJvMsZ9apRYjZ6ekxMds1ttWTWI5qtDxDGwuMYSuhEmk9CUT5gJFJcR+BG+itvKSGig4KC47VQ1l6915DIxYUAwdtJQVQlvOE0ATcm+DCqERooe0kdEQkJzY2Ts5KDAWdzhEfT9KjheeiWk739M9UYngGrMumBvTobOuK/XoXMoPqsAvLRFeVeaAyRUs/NQGAcKdHfn88cLUV66ZSw5YVGBRO+3pCjAuQNj0wi1m3chzejdMnzvmMl6IWBF/tbpt7y8gp138S+gzmhtwP9HFep+xMhmZ35wV89qfQPehsKA/8E0ET3KYG5w4ArD3ZxB3RomCGseofMx1bR/ORjYlBtOFLXrrnk+lAalOijI2v5N+9tX2KFrYyTrs/cKHVkxxPWuLoHSxGTBF25Kfv2JOoAknjTB6O0mGsQk+Jr0IvaIeaL2wWWiqqJwlRpfkl2t38PrJGCP/haTn3ElVN4Bn5hAFJLp4nXwnmkxrWFAxEZmnBf+/wyJUuUvLyz8c/hYntg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXBRY0VJbllIeVJacUROSFRSNmZDWmdjTThjNFltY2FQOGNnYzhUeG9udGpC?=
 =?utf-8?B?MzFLcWZGNllmbStzK1dvekZIWGcvcU5IaWNqU3E0eGpSQ1ZKV1BBWVZhTzJq?=
 =?utf-8?B?RS80WmZiOW42RlNuMytwRGlUMEpXa3RvU3B5NXlvS0xsWWFUVEpya0Q3b3c0?=
 =?utf-8?B?ZUZrZjJrNVd2ZDBYTFVvVEJIeXhpakh6L2lnSDhzU1BrdVZvSTAyQm5aVEgz?=
 =?utf-8?B?ZlgxMS9OWWw2a0gyMWlCSit1eFR6OXZPcFRuV05rMER6YXNTNjMwNTdadzBR?=
 =?utf-8?B?TWpyTVJlb2JJZWpTdFp2NFBNdXZEUUY4SFlVNkdOam5IYzdzaVp2YmM3M1lU?=
 =?utf-8?B?Y0JsREZIMDhBc3RYVlk1NFppeDlldDNuaUJnckQrdEhrR2RJR2gycDY1c1B1?=
 =?utf-8?B?L29jaC9DZ3ZDb3piMk81MkQxOGIrVnRpcndvU1VKQkRJNzliS0R6Yjh0SFNC?=
 =?utf-8?B?Nm4wZmcxaHYrbWxsU2tNRUFtdTFMdDBzWUNlSGhyaXNiQXJHN0hMSnp6dVNp?=
 =?utf-8?B?Rmk1Nmc3NEY1bEdIS1dpMWMrYmVESWQ2ZGZkYXVueG5BL013dkVXcWpUdnoz?=
 =?utf-8?B?QW41SVhoditKTEI3bXRKa2dnSUlFZVNlY2pSbjZsdkJVZjdjWjRJL08vZ1lT?=
 =?utf-8?B?clppYWZQSDByMk4vNnBrU2pkS3ZoUDhuL1E3YnNvYTVIZ3BXZUtOMjAra09i?=
 =?utf-8?B?S2dmTHA3WVMrNkpDWEhpZWFuQ1QxN0Jqa3lOM0piNVpMRmlHdUJEZkdNd2R0?=
 =?utf-8?B?dk9LM0NiY2drSDEzOUsrS1dlZ2RSQmthSmVzTlVFZDJnNFZvK28rVU5iSmx6?=
 =?utf-8?B?aitnTG0vWVZNQmRJUHBkU2ZOeWV2NFEwSDN4KzZKZTF1YVQ2aXRZYWRWMUVB?=
 =?utf-8?B?dGowYU0vZ05BZUg4Q0FlMEp1TFAwQ015a2REWEczSEF5UnZqMzc0bUhIMUpv?=
 =?utf-8?B?c0ordGR5SElKQ3M1Q3NUTE5mRmxyR1ViZ0hkNXBkZlByVlVFL2lVYjV2V3B4?=
 =?utf-8?B?ajE2TjhrQ3dRa3JvRXE5VHdPT2RIV1NqeG1Vb2owanJtUkR0Qy9lRGxYWXNx?=
 =?utf-8?B?c2hiOUJIOXBBRm5nZWI5VndKSktrMVNlLzBQNTdhdTJzVllqZExPV2pDRFJP?=
 =?utf-8?B?YUd6YUYycTV0M1VEV0krSTlEWEZVWE8xaXBsU1ZZZTRPL0kvRUsrTlQ3eHdJ?=
 =?utf-8?B?VjZzZEdHMHo5Z1RabmNnN3pXa0hTSXV0MThMNDBWaFFCaUlPMjJPUmJ0K2hi?=
 =?utf-8?B?NXVPNHRkeUlZQ2s0L3QxQ2ExVUFZL1gyNk9ZV1VhajlEd3NnUnc1NFpYT2pM?=
 =?utf-8?B?dG9pYVpyQ04zRENVdUd4RzFaRVdWTmxIYzd1MFZaajVhSHpQY04zczlWU1ZM?=
 =?utf-8?B?MTdlSTNHaUNaR1VacmdFdFBhb0gwcWNwNXJ0djZudjIzSEJpRHFWOGFxK3Nl?=
 =?utf-8?B?Nm0rbGhtc1d6OUJ2SmMrZ1FZT1ZLZ2EwYThEQkx2TkdreFY5UHNSanlEc0Fm?=
 =?utf-8?B?Vy9ocERoTmxkZWk2QmF2TDIzRUZFWnZIdkQza05jQ2tPS3ptQk1ESndjeSsw?=
 =?utf-8?B?VFN1bk5VbGFiT2JiQjkyRHZWWDNiK0lKelUwc3BxQ3BQQVBMeWNaWFFiZDNS?=
 =?utf-8?B?WFdNQTlZSnljRHAvWkFoNk10cU1zMTlUVG9telR5anoxSExyMXdKNjdKK0lZ?=
 =?utf-8?B?Nm9oTkRSMkw3WU1IbEpLTi9KM3N6WjJFSVlOa3d6d2lRN3M0TFdERkZwQmM5?=
 =?utf-8?B?SVBVTW15VGxpOU1vY1ViMGx2THhKQVcrTVVBTmp2QWluQ1NycjBUUXl4b3A2?=
 =?utf-8?B?VmlnUm5DekZGdXd2a3VjaTNOdy8yTHFiUmtwVlhoc3I4cnBtZEV1OHNTQzAw?=
 =?utf-8?B?QU5uQTZhRytmSEZBc0FZOGwzcHBhU2I2QTFZTzJlL0ZieWYzd2poSzJGenFs?=
 =?utf-8?B?NFdhYUFmQkYxVU5JL1J2TjdYb0g5N3hOT01EYkFYcVRHbVd4ZXJheVBDQlk0?=
 =?utf-8?B?WGNjVUxsZk5OUk91K0Jma2MwaG5mL3Mrb0FvSHdyTWNoRUtPTThWZWM0OEFh?=
 =?utf-8?B?RGhZSWc3d2wycy96bzlBNXZlemlwejEzYmZSeTYrRFhFQlFpOXB1MGdNNXEz?=
 =?utf-8?B?QUpnOEQ2RStTQ1FGTWE3Q3l4TnNtMTloSCtBRTh1VU00cXdyMTByVllKU2VH?=
 =?utf-8?B?a1BaVkVoNkpoempmWis0YmdIYjVsUm16MWNSNEVLV2t0R3BCTmVXcHRVc1Bh?=
 =?utf-8?B?bUxGTDRTMnhVUkx1ZG5rcSt0MjZMQlhFVnJTUC9NUlhOYTNSRHVrSjN4dCs5?=
 =?utf-8?B?NGtlZ1ZtZVFuMHFrbG5zbCtTN1pFWC9lMG1MWU9HeE10c2tOMFJZdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f60b1e6-5138-4872-474b-08de8aaacba6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 20:12:10.1746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpJnEZDmwhQdBJNqUaGnI6Kow5zGZSLQveWC6xEGFhZsPyCCyRVY+urzGCEN/PxV/3BQ+0mmT2QQOwGlOGUBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271731-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aroulin@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6FE332BAA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 00:28, Jonas Gorski wrote:
> On 24/03/2026 19:49, Andy Roulin wrote:
>> The bridge-stp usermode helper is currently restricted to the initial
>> network namespace, preventing userspace STP daemons like mstpd from
>> operating on bridges in other namespaces. Since commit ff62198553e4
>> ("bridge: Only call /sbin/bridge-stp for the initial network
>> namespace"), bridges in non-init namespaces silently fall back to
>> kernel STP with no way to request userspace STP.
>>
>> This series adds a new IFLA_BR_STP_MODE bridge attribute that allows
>> explicit per-bridge control over STP mode selection. Three modes are
>> supported:
>>
>>    - auto (default): existing behavior, try /sbin/bridge-stp in
>>      init_net, fall back to kernel STP otherwise
>>    - user: directly enable BR_USER_STP without invoking the helper,
>>      works in any network namespace
>>    - kernel: directly enable BR_KERNEL_STP without invoking the helper
> 
> I like that very much! This will also allow selftests for
> switchdev/dsa drivers for correct (mst) STP state (change) handling.
> 
>> The user and kernel modes bypass call_usermodehelper() entirely,
>> addressing the security concerns discussed at [1]. The caller is
>> responsible for managing the userspace STP daemon directly, rather
>> than relying on the kernel to invoke /sbin/bridge-stp.
> 
> Should the caller directly manage the STP daemon, or could the STP
> daemon also just automatically manage bridges with
> IFLA_BR_STP_STATE=BR_STP_MODE_KERNEL (and IFLA_BR_STP_STATE != 0)?
> 
> The latter would require less changes for network managers, as they
> wouldn't need to be aware of (individual) STP daemon
> implementations.
> 
> But I guess either is fine, as long as the latter behavior
> configurable.

STP daemons can listen to netlink and automatically discover the bridges
with IFLA_BR_STP_STATE=BR_STP_MODE_USER (or stp_state=BR_STP_USER).

Will change uapi doc in v2 from

  The caller is responsible for registering the bridge with the 
  

   userspace STP daemon after enabling STP, and for deregistering it 
  

   before disabling STP. 
  


to

   No /sbin/bridge-stp helper is invoked; userspace is responsible for 
  

   ensuring an STP daemon manages the bridge.

