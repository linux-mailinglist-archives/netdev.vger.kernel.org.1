Return-Path: <netdev+bounces-97506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475DF8CBC82
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 09:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0106282590
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 07:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041877E11E;
	Wed, 22 May 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="lBUZ6iYI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3D7D3F5;
	Wed, 22 May 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364697; cv=fail; b=JbfBpv8UBl19o3wuW+tQZxvBev/f3gsVKNfP8aufsOXgzHipfxWgPM7CaLWN4Ns1GDjmOxVS1ASJNHSlKbNCtkwotlYhNKbXSg1GSK8JwXo7OWXSY+ozf4XLFY15pjQC0DdNqd5c8hAeKvC/WoIC4bHltN6VYkJn143BXVyxLC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364697; c=relaxed/simple;
	bh=6p+5huMIhfFR8BZBqiTpvPOcYwgLWvV9x22/DBHCWco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQU3KnbyfeIjby/7ZzCvo/km115pAYDPEZDpc0u+GKO/HronQM6P3hNIjtoknyxAuSH2sZDgYko09jWYwYNEpSAtNiX1DKcp2NDivxQeRXyorfzpXrqM6wKabkCnz1cQ4ea8gn++OtHPlE38WTQOkpSXVGu8dUq6dQownN/iyrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=lBUZ6iYI; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVzt4bW7XAvGnyT58yq4WZc5TA4SELS3MfstiMNuPp9Y6sfV3xrtmonRtV7b8NWZfGZYnLcIuaYWXj5clZNZTxbI38WILjCrDkmdKWJreAiJzlJV/0Eueu8vWnRC7j1PjMLv2Y8m7zKNzxQzfVZq1KZBbDd315d14R4mHp6BF+vQbFeNvlVA20z15LqmibB0DS/EWMg+7h7gIa0ykpjGf4Kt1p44eSYlOu1YZuSdYQK7MvtapHRHfBYPlaXYxnVIJmXOSd0Ls+brPRhGrfc6BEMq2/9Sk3hmVzKW0u5IqAZiz3Vf1G3pbJvNYMRPPdGgjop+8/jOkQKM1avg+wUFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l91FsthMTo4M1kl2fNpm9M3mkG53yv9NwH959n0LbM=;
 b=CwULNLf5Enb87EQIdAxJNGRMRmgF/6fZ1mf/AnNy7C8K8wpCnX6M7s+lbZ5UDukVMeavGeE4pWSLn+8ARJ8DQs8bF3orG9BxUmMznjeZ4gxCFQfWnfg4G5McXbB2aSQ1US4DOo52Yl2mz83i9qZDnCn6EqVpx88AB/+/gXlGL4YuFWVOTd/zgsF/Y4RD4wNpm0sMVtK1xZWhU290+ZnUQT+jfLZ9QsUvaduZhaeh6LCA8/e1weBBaAFIvuq2/jBzWbmJuMOE+bSg6df2V3SYdHaBa1GRC/YGeeeiQvpCaMre77CeweAOr+cSEttpwVDB3q78iPFx3IppgoUMZYnyRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l91FsthMTo4M1kl2fNpm9M3mkG53yv9NwH959n0LbM=;
 b=lBUZ6iYIiQyd+YJ0X1OQIk4duonPTwL4tErZYiyV78cSWAxMu6+RMGbKG0j3yZjpJkt+fjk09AD3Tnh11HKhEy9rBfztXyy97a+oQzQKe8buSUNWVm6OCVOiBs79whm4EE9stAbbA+pOCGoTmEAuNVhd53llJ/34/bug+1u26zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from VI1PR02MB10074.eurprd02.prod.outlook.com (2603:10a6:800:1c1::5)
 by GVXPR02MB11110.eurprd02.prod.outlook.com (2603:10a6:150:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 07:58:11 +0000
Received: from VI1PR02MB10074.eurprd02.prod.outlook.com
 ([fe80::2de2:46f8:2073:2098]) by VI1PR02MB10074.eurprd02.prod.outlook.com
 ([fe80::2de2:46f8:2073:2098%4]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 07:58:11 +0000
Message-ID: <f77b9385-5934-4afd-b255-adb5c9c5cef0@axis.com>
Date: Wed, 22 May 2024 09:57:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] net: phy: bcm54811: New link mode for BroadR-Reach
To: Andrew Lunn <andrew@lunn.ch>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 hkallweit1@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240506144015.2409715-1-kamilh@axis.com>
 <20240506144015.2409715-2-kamilh@axis.com>
 <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Kamil_Hor=C3=A1k=2C_2N?= <kamilh@axis.com>
In-Reply-To: <25798e60-d1cc-40ce-b081-80afdb182dd6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P194CA0044.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::33) To VI1PR02MB10074.eurprd02.prod.outlook.com
 (2603:10a6:800:1c1::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR02MB10074:EE_|GVXPR02MB11110:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c49924c-df95-476d-f64d-08dc7a34ed18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDhtMkN2ZEl0a0psZFovSDVGSEdwdnd5Q0FJck9kL0lJSDlabmNsL3JtUThs?=
 =?utf-8?B?c2pReENaamUxa2ROYTU5M3FBZVY0THJpYzJodUJycERsRzdOUE1tY2l0YkZ4?=
 =?utf-8?B?VytsYTV2VEtoaFJhL0VLRzc2ZXdsRWMyTmdwM3plKzl1QkpwZXlzWC9jbzBJ?=
 =?utf-8?B?ZjNOL1BDOTdFa3F2aEZWUGNFUUdGRGxQZVJ3UWhIbjl3bC9FaHNOK2tEVWRj?=
 =?utf-8?B?M3BxVHRnamVNNCtwTVh1YjhVeTRkS1JjdVlBdk1nQUFxYjBqV2s2WE0vbjlo?=
 =?utf-8?B?NlZMUjE4Ynk4TDU3SkdONzJVdzRqRit6anVmMTFqZjVJNy9WK1ZENk5tSnNl?=
 =?utf-8?B?cXhxOEtCbzBrK2FQVmZxWmRmWis0cTRMdlBqd3M5UmhqMTZDaUhMdDQ2MWs0?=
 =?utf-8?B?UXNobVVucm5oYUFxSklGK3UvdDN0Y0FaUU5XRFkwaWtyUjRDWTNrYnp1ZS84?=
 =?utf-8?B?Y2REQ0VvRDYyZE91ajBwRW4yVXFMYW5ZVXU3VHBaNERpUFlReGxkL3RTWHNk?=
 =?utf-8?B?dnpCbGhoMG9JemNhZ3ZOR2tKeXFpek1YUFpUaEgvM2lVbVZlRDdZUlIxVEJn?=
 =?utf-8?B?alRGNXdvKzhpbkV4YThkRjJwZTE4TUFLalZzY0M2cHhIY3lIdTMzS2F5OHN0?=
 =?utf-8?B?L3ZLZitRMXdDL2pyckhzdVRkOTZCbkdWU2l0VGNpbFpKcXFTRk9kZ1U1WWJu?=
 =?utf-8?B?L0pqbUtudU9SdE5YVUtlTE9tV0JHTk1JTGlmVDh1NEJETUlkd21vRTE2a29w?=
 =?utf-8?B?S2I2NitMT3YwTVc1bFVuTU5XN2FOYXEremN3cmsyU1NWMFg1VER0RGtsak9K?=
 =?utf-8?B?dHlnR2ZBT1dYTDZMNHl6NlZlZVNpMk8vS3BuNDY0N0MwSTMycVpwS3Mwb2ts?=
 =?utf-8?B?NXpBbXBFeGk4L3VIb2RHZldvU3ZIM1hmcGJaZGo2SDcxZGtPTXNNeFVMUDNm?=
 =?utf-8?B?TUxMaC9ZY0ljR2lGRVNmaS9HVmU4Y093c1BTTlBFMUN1dlVQOUcwZGJBV0pk?=
 =?utf-8?B?a28rdVp6NTdGcGdJRnh4eEUvRDh0K3pZbHdqQm9lRGxKV0lmNW1ieEF4cTg4?=
 =?utf-8?B?Wmd1ZUxsY3phRkxGZUZaMjBOT0oweVNyc1lNRjZ0QlM2NENYYnRJRkxSV0Zu?=
 =?utf-8?B?RmU1YW5UMUdldDJxQ3JCT2tLdlcwREhCZzBrMTFTbE1FRTdGbG1Cem1MN0h5?=
 =?utf-8?B?ZnQzVXJjQW44SkRMWmlUb1Z1ZTBtZ2IvVEdyT21jQkp6M0J0U3N4Q05IV0JV?=
 =?utf-8?B?ZHVWazV6cDgwLzVNM2k1Q2w2UHZIT25TUnJVQmMwNWlDSjlWU2lGQlFzSG1v?=
 =?utf-8?B?VUJ5Wi9GVkd5bW1DZkFFK2ZiaC9vT1o3SnMrQ2ZReGhUeHZkRWZtcjhSN1h1?=
 =?utf-8?B?cjhLSmVvRStLb1l3VnJiMHJOUDRGK25iaVIxaStLM25SVHUyaU5aNmFmeTFz?=
 =?utf-8?B?SjlEVDhKVXVZcFhOTHhWOHQ3aHpORkhMdm41RUZTZ0tRRURIeDBGQU9tRlpi?=
 =?utf-8?B?UEF0eWpoeUEyRWFJM3hyVlA4cEpjL2xoayt5bUlTUVFUOVd6MkFjWVJyL09V?=
 =?utf-8?B?SERJWlRLK3JWWXZla3QzMTJQSnd1TGVlbERjTEFreFFCVnB0TDlrWC9lVnNi?=
 =?utf-8?B?eCtxemNMNGYwQkZmSmtKNW9QT3M3Z0N1T2V6OC82WENERUZwMWkybWRNNHVz?=
 =?utf-8?B?cVlmUi9oVVRGSWhBRWR6U2NocGo4aEs2ZDNtTXlWK0prdkEvM3QveHBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB10074.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1Z5SG1xcWRlazVXeTFmN3dYTG4wcE4xYWhCdDlrMmUrN3hsR2FUTUppOW1a?=
 =?utf-8?B?SVN2Y001eklUOS8ydjJ4QW9RMmhNU2tOWTdJdUdoZzEvVFhqR3JjOXlmY0Ux?=
 =?utf-8?B?S3BmS20wOHE3OWNhMTJLamNrVGpCUkszY2VnY254UUtUa2oxSDVRZXRlandB?=
 =?utf-8?B?dm1ITmdCeVJtd25ZZndxQ1QyYU0vUVoyQkJXNTNQcXZxYWFQS1B6bHR2K1Rm?=
 =?utf-8?B?Mk9jcHhhMVhDR0RlTGlrU2s4YVBvWlZvYkFPZWRMYWRkWDJQSlVOMnp0RkJD?=
 =?utf-8?B?bGY5OWpXY3pqVm5hOW9aMXlsQ0tqeVpYMExSVTlXeXB4Zzh4aEVqVDFhSVRi?=
 =?utf-8?B?ZXhrRWlZMXJ6K1VuZFFLNXY0d0FTMm9WN2Rta0tVdUZydDZQM3dKdnkrbHVV?=
 =?utf-8?B?VVZWMkdHcWczZ2doVUlTN0NFSlZWaVpUakpLM3JpQWJJUnVDT2ZOREdvREFO?=
 =?utf-8?B?bSs0bCt4RkVnRGZKbHVpRHBPZllqZlBxTk1ndnE5ZHJhcEhUbE1DallvRWhI?=
 =?utf-8?B?UDJlVk1LcVNkTXJCT3hiMG8zNWZYaG4vd1JyUkhGcGJLRzFTSjRMK3ByVmNx?=
 =?utf-8?B?THZubFYxNnk3QUdVVGtDZjZHanhQRlBjOGY1NmJTdTQxN1V4TjcrS3g5bGdJ?=
 =?utf-8?B?VjNzSVFPWjJLTExTNGoyMXVEbUQwTnhpNjV2S0JHUmNvMmJHWjZnNlNQT3Rm?=
 =?utf-8?B?UDFEWGRUZ1VuM0ZKQWpFaTdWWEJ5U2ZreFZLRS9WTW54MEgrOFZFcGxlcUJV?=
 =?utf-8?B?TkttTmd5NHQ1Tk1JRUlnSEczTDlBaDdOSks3OXdLVGJ4SEVUZ1MrMWFIckRT?=
 =?utf-8?B?UjlrejZSeUFaWStrZmE1T0ZCN3czZ3FFdzIxNWdRV250YVhxeEtDRW5NRSs4?=
 =?utf-8?B?bis0SHd1T2RNM2xkRlBaSnpaQXFnNUpOY3hOU1FLcEoyTWRUQTA1d1pDdktu?=
 =?utf-8?B?eHBlUHM4ZFVaaUpodEsrK0laZ2VHTG1keENKU2dvMm52ajk5bFFsV2lXYkg1?=
 =?utf-8?B?OGVwam5SS21qUyt0bVhkOXpaWkFXZVUyRk1zWDV3Q05BWFdwWnUwUFFoZUpN?=
 =?utf-8?B?RVNTTlN6aVFvTlBONlFIdXFKQ2JHNlpaOU40TEVIZzNnVUlGNG11UjNFV2R5?=
 =?utf-8?B?UUEvcGF1djNBaWNUZXBJcW5CQm1NWWpsSER5emtqa3JFVVhpc3Fpdkhoc3JD?=
 =?utf-8?B?U29hc211SlM1aUphOWlvUWxvSGlGRmw1elpqZ2NMaVhiUXRPUU9USkRYUktD?=
 =?utf-8?B?bjNKWVE4Mm1XU2NBTkVXcnNnaXhhbVQ4TlBqc1NhZUl3c1E4NUhjeWhWL21h?=
 =?utf-8?B?TWZ5MEJzbjJDbGNLN29UV1BRS1FqQnNMYk10TDJZbkdoRHh6WTk4aGJaN1dt?=
 =?utf-8?B?YkV1Wkh1ZXMwSWx0aldMSC9KNUxMZk0yUExLL21kaFhSdUNBeXA2NllpMmkr?=
 =?utf-8?B?TFhFb1h2WkNVY1pIZnUwUndldDZBOW4xRTJOek41dzZ2aEJXdmswdi9GamRt?=
 =?utf-8?B?ckY0WG03cERkOFN2YjRRaCtXS29xYWxBVWNqVlF1dW1DSlZ1RDFSTnUyMkNP?=
 =?utf-8?B?dk5YM3VkbXJMTlI4UVV5ZFYveEJFbDRBRjlNbEszS1lqbk9IZmsvT1RxUUlw?=
 =?utf-8?B?NEw2TEtGcTZNTzBJMG93WjhRSlV4VlJLOW1tMEtGeHNKSEJsWlVBWDVqYXZh?=
 =?utf-8?B?eDBiRi9DT3VkVUlMVW5Da1dQeXZTM1ZzL3RDdFVVQzRkUmpGOXNGeWVXWnVm?=
 =?utf-8?B?RFpnQ291Ly95QkpNQ1h2b0VNUlhuRmxiUUhKaHlpNmphNlZxRTJaSldVVXhF?=
 =?utf-8?B?K1pkakJubGd2RnhPdmY5VkR0N1J3MlJMQnRXRmR4ekN5VXlwS2J5cHNiOUVS?=
 =?utf-8?B?V0xmTkRoMURHcW9oY0tickRPWCtqSzJsY2l0dWxlbWNXYWhSU2hTeXdkSTFX?=
 =?utf-8?B?T1ZiY1lpN1gzcEcvb21RQ3RwRERQS0Q0c1YyVXlBUEQ5eUhsN2lLUFF6Q3FX?=
 =?utf-8?B?Q2dWL0ZFa1VCcDJrMWl0d3AzbC9KYjdhOUNFWFZCQTl5WmZ4T3Y5eE0yMGIx?=
 =?utf-8?B?Rlp6M3BXZkR1QS84eW1Jdm11MzZ3ZFZ1Tm93R1Vnem9HU09VQjNaTlgyRDRP?=
 =?utf-8?Q?Xm6S2wqTs3aoYKPWI8XUHW5nF?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c49924c-df95-476d-f64d-08dc7a34ed18
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB10074.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 07:58:11.5456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXdpieTtcXyI481bs6dMNu2CvEDmJo+xpU4oFHHVvESbLBHxDh0ACg/QCeiof0Ma
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB11110


On 5/6/24 21:14, Andrew Lunn wrote:
> On Mon, May 06, 2024 at 04:40:13PM +0200, Kamil Horák - 2N wrote:
>> Introduce new link modes necessary for the BroadR-Reach mode on
>> bcm5481x PHY by Broadcom and new PHY tunable to choose between
>> normal (IEEE) ethernet and BroadR-Reach modes of the PHY.
> I would of split this into two patches. The reason being, we need the
> new link mode. But do we need the tunable? Why don't i just use the
> link mode to select it?
>
> ethtool -s eth42 advertise 1BR10

Tried to find a way to do the link mode selection this way but the 
advertised modes are only applicable when there is auto-negotiation, 
which is only partially the case of BCM54811: it only has 
auto-negotiation in IEEE mode.
Thus, to avoid choosing between BroadR-Reach and IEEE mode using the PHY 
Tunable, we would need something else and I am already running out of 
ideas...
Is there any other possibility?

In addition, we would have to check for incompatible link modes selected 
to advertise (cannot choose one BRR and one IEEE mode to advertise), or 
perhaps the BRR modes would take precedence, if there is any BRR mode 
selected to advertise, IEEE modes would be ignored.

>
> Once you have split this up, you can explain the link mode patch in a
> bit more detail. That because the name does not fit 802.3, the normal
> macros cannot be used, so everything needs to be hand crafted.
>
>      Andrew
>
> ---
> pw-bot: cr


Kamil


