Return-Path: <netdev+bounces-115512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D027A946CD8
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A0281A2A
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12353DF6C;
	Sun,  4 Aug 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HVve+7Vv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6877D524F
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 06:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722754005; cv=fail; b=V52qmCaMZlOySIaGNznqZEZD4uXaA2b2RmOIuDqopZoFFUQcshbjb7R33KKYKKGCsIzQXopDPh0vtwYqfIKjksEX9+ai/vl4TjC85ZnhpyfjKP4MIl7mGITITG0pt5lf0JSEIFy/HthK76jVnCSmTmW4QVXQCeWxmlCcWV4Afrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722754005; c=relaxed/simple;
	bh=EDcHXlJj+BnzbmTH9+UJq1EO16ri9rl2PxFI5NACGN8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXKm4B8YSHKNA94Kwt1GRg3gDhaolxWpH0JwwIMIy98id7cOkUM35y4CNlgXlLIgSnM2uKZErR2KRyiYZi8BFnbV1iIbFZ3UJFgL3MXRHZctWt+Y9ySh/m4czKG26qGzVFCmpdGVhuMEdw6haktF4qfDVxkiLowDNrS6Hhj5Cw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HVve+7Vv; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpEOcV1zEfPsBw0S1ebBYRvDF88LoVQxW5lGeVzu0CddBxh+I1cOUV7VSnSdCKmsIC6AnjzLXI32x6c8UaPjxAyeyUhDlLNzOcWft0CGkyYYgVTrOuq/UgU+L55B/4sITt0Bn8rzefP16CZsYXVtZidEfOPs+Ia70jIqWJuXYJmQk2QltrQzGOqxdwwxP5dmJ0Zb010bndUFsvithnm2RG1iOPlZCJeU9a8rZYA/bPyznt5TdlBMtJp+89xoe8DvNGXx6e5Z78pP76bNDn0bpoqcuiq/ud9k5gL2h2H862O7rK2g/k6BzoK4tXPi9/uqdgRlDJ4EPxyF783RoVy8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5j+g+ppJYxddbiw9YBjCXs2k0Aeo8jVazzDUCz8lQo=;
 b=A+W0EjlrBNAvEJxjmh9lF7sHESgrw0BBiQjTZxvchwjQg8gjQfGK5pbCvkQt/zfivI3S4G7RNzY5vTs6hnTAeMSxNj49htCHejBqwC2Lu2PGcxFXqKcRlcXgesaXzgbv/M7Ul/yfqGHVWFEPGsVNWtTW5zBHavMFo59veCXWF9F/DW0EzTcjUOWe1cOO0UfXQWe7slcmydLXulVrYx3E9gnLsMZKRUP30UZ2knJaxOS5R21ODGr8Qbp6WR9k0mVne5o3Lt3GOaQPqaMi+nU1XZJkIx9oERBRBj5uMAl82lAPE4tQSvZo2WtJWHrjT98jH2RPZmLHwCIDAWgOkwQFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5j+g+ppJYxddbiw9YBjCXs2k0Aeo8jVazzDUCz8lQo=;
 b=HVve+7Vv2NtgMveTMmrezdPi7ie+jSr35MQNuxm5S/O25M3BZu9t6e3BqD5ef5y0LoluEjEUJ6RwQeihplKsy42YPYg23QeAmSfzVXm8gdsvwwFpWhGhddRLFwSOyOg0jgl4OkdOErjTUYCsJlIjhyTVAUU7LyoTDebyIrVP8o8rGx1yMwos7/Wcr4aFaEJuF1RBuuTMGS3TD8zSiUKWWK5wdKBYoj9ah2AhtxxrxDocAc4+3mTw5Ts2stcQMdLFuYwdim2fJhDrMpgY++jahKvnvICG+EHIY0X09a6XfZpt+zpcA+kxtaB5gjcs5LAeCc+rBh7IkHQXmpod19xuUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Sun, 4 Aug
 2024 06:46:38 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:46:38 +0000
Message-ID: <d1f4eff4-415d-4d0d-95d7-c7c1c813cf2a@nvidia.com>
Date: Sun, 4 Aug 2024 09:46:28 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/12] ethtool: make
 ethtool_ops::cap_rss_ctx_supported optional
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-5-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240803042624.970352-5-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::11) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b479aad-7db1-4ccc-2074-08dcb45130d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWtrdDN3c2dJVDYwNE83K2dENkdYNklEN3J1bzlYTk1KWGlCcHMzcWtBN24z?=
 =?utf-8?B?K3lNTE4zQzJZQ3dTL3d5RUFPaHl3YUNPNGJiSzI5UFZ6WklhS3dHQ2lZSUxR?=
 =?utf-8?B?SVZIZDhLSkdNUFd0Nnp4YVRCSHg3VjFFUUhyODhRUEZPeHBVbkY2SmhZQ3Yz?=
 =?utf-8?B?OXBTQnRUdzVNYStLWWtSMW1NSnBpK0JnU1paVjArOHR4Y3dFaXdaKzNicXNE?=
 =?utf-8?B?STFuUWtiZlRnU3FBOUp2WFRHTVBIaW5oTGdZUkRWUzNxOVd6T25KblVOZW5X?=
 =?utf-8?B?SGxlbEV5eTRkTlVDcTk5M2ZWY0hOdUE0a25hd1drQjZURUMxVVZjaC9sM0dV?=
 =?utf-8?B?NmxVempRM2QzVE02ZkdvdWlMSjc5YThlZU1wZW0ybDdkNkxjc20zRURuanI4?=
 =?utf-8?B?OGM0LzNzVUJkL2R3UVU3Rkg1WG9Sc3FRTktPTUpWQmFlYnM3eHpVUHJFVmkr?=
 =?utf-8?B?YnQ5OHRkNExkcDJCMWc3VlhVUUhaYzlGeGpiZEoyUUNKMUlLR2pkZ2lUNjFr?=
 =?utf-8?B?QmJQd2x3Y1RLTHo4WHVUeldHM3M1cnhYUWM4M1ZXdGpmVWljOTlZVTdFb3Bw?=
 =?utf-8?B?Ty9qNDM4SEpNd2ZnUzQwa0lUWlBHSGlRczRuQ0dveWNobktIOFFuWkpzMXpz?=
 =?utf-8?B?ekx0bzlPNXN0M0tLNGQ4ZkpDTytxNktqakJTTzlVY2V6VGpZVDRnaGNEQVJn?=
 =?utf-8?B?ajd3Y2l5MGtNQjhDY0tmNFB3VlJKL3djT1lJL1h4V3FXTVJFa0NVdUhTU1NO?=
 =?utf-8?B?aVMrZFJhd0VvUVdoc29ycElHY056REFVaWZBM0RxV0tYandWN0l5dW9mc25r?=
 =?utf-8?B?UDAvTkUvcTczdnoycDF0WHpWcnlNRjI4d1FYY2dGWXpqNDl1R1FGK3dBZ3gy?=
 =?utf-8?B?RlBIcjlOeGhqSjBwY2VidEFYSm84d2RySVYrTzFUMjQweFM5SEtUSmM1WjdI?=
 =?utf-8?B?cVViV1U4Y3g2ZWF1SzhHVHpHWS96RFlZSExGZk9ZWHI4MGp1ckE4ajlQWldK?=
 =?utf-8?B?MVEwbjRGWkxEV3ZXZU1FZXFOMHU3cE1QRnRoMXIxZVBXTllpS3VwcmZkVmlH?=
 =?utf-8?B?VmVzbG5Pc3MrM3pYeFlwVVJrV3pYNFUwNUlYM1NKWXRUWUFPNGFmTUwrSEJl?=
 =?utf-8?B?MksrNjNaY256S0c0R0hxQUZKZ1VrSElRLy92bld5dmVTWVdQQVV1NHVWU2tO?=
 =?utf-8?B?N3pSS1FDaDNjZHNkZTgxeHdoS2J6Z0RJNjVVWjFRUDFFOVZyZEZIbU5lNDl5?=
 =?utf-8?B?WWN5WXlHMENYcS91cXc0VkJCREFvNUN1d2tpOW8vcnNpdVd4R1NBMTdjUjZr?=
 =?utf-8?B?dStwd3psbWI2dDlYTFRsMEhmQXo0UXY5VW1PeXhDWkl3RGdaWUZ6anF5Sk9E?=
 =?utf-8?B?U2k3dnhPOWF5NEVxN3BlcXhocWdRNWprRzVxY3AwWmgyZ2lINVhWZHBrb0k5?=
 =?utf-8?B?eW44dFMrMVU3bkRqYmQ0U2svRS9pbVNOazR2OEtJOW5mdWVyK3MyMGt1UnBp?=
 =?utf-8?B?SkdvcW10OS9ybjRNRE4wT0NzNDE5eGFpOWpTS0VEOTRrNUhWWVFTTkUxSlUz?=
 =?utf-8?B?T2RjYXZ2L0s4bWVHQkFFYlVqTUg3SEJjQ3pMcGZYeUFDNTRXRXN1Q0g3OEcx?=
 =?utf-8?B?ZnZjc2lzWXpLSG8vdUx1K0s1TDVRVmNIZkpYSVI2S0tmZTV0Yzd6dkR0aVZB?=
 =?utf-8?B?QWlzTkZxSWh1UFhYVUxXRnhOd1kzR2NCUnpGTUdGdlh3L2tzT2lUS3orUUQr?=
 =?utf-8?B?MzFtb004RU1xUVBJOHNTdVVFdDFiRFpkYk5LTkJQVGZKd3loTUh6QlB0c2ZP?=
 =?utf-8?B?WTJJTkMyQlNNb3M0UGZNZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a29mMlEzN2dwWmZIckdnZFpBZ25CcW5UZEt0VEFXY0VpZmtXNUphLzZuMmxy?=
 =?utf-8?B?U3FKa1ZFWHZVMjFpNDR4S1hYY3FLcTBuRUYvZEY5WGhXcG1XYVpENFBrQks4?=
 =?utf-8?B?U0QrMjhuaFpzRm9Iby9UZTBFS2lpMUtjZS85bFczWSt6NXRQMERkQUlBUC9o?=
 =?utf-8?B?cllUekh5REpDbzdWc0lYOHFvZDNwMDZuMGRiTDNKcTBBbWsrRFo5bStvZVdm?=
 =?utf-8?B?QTlqRm1lZ0tvMnFCV2lpNlBEL3d0R1JOTWJsSnMyd3luekFOWlBGL2s1ZDFB?=
 =?utf-8?B?U085WnVzbkliSmhpTHFYSnJZU1ZHVGNPSkRpait3YTd6bjViS0NGdkJDQ3pp?=
 =?utf-8?B?akVpUlJjS3E3Q3k2aFRqTzJmbFNWd2REMUtSaVRQaHpSNER4ZnRvYUZ0ZFAy?=
 =?utf-8?B?NmRCUUdOQk95SW9VTzIzNUdiZFMvNk8ySVBRUmdpMHNaMEtvTUxGSStkWUg5?=
 =?utf-8?B?RXE5RDUyWU15dEhCOTBFQXI2Q1ozUGpxZzBJblJITlV4Q2hFb1pHZFRmKzZu?=
 =?utf-8?B?Mm1obTk2ZjZ6NlJRNlhVWHRKNjI3MkdWa1RrV3pZYUhHVGdYWWlqNGdPbllL?=
 =?utf-8?B?VzE0OG5tMUdhekFENGxpcHd2cEozSURNZ29sVjNVbVpiUVlFTEFYbHcrWXdW?=
 =?utf-8?B?UE43VGdZWGxlaFNhZkt1RWN2SDQ0eTVIakZ2TEF5bElxOXBjSEtQY1NncHNX?=
 =?utf-8?B?dXF2NmJvVTZ3Unkxand5anRkTk9Pa1JkcVVvTjViOWxJcDRKWEFkNzh1UE1t?=
 =?utf-8?B?NmI1SFk2VVZDTG1BS1E2a0VaTDVkRmVMV1VML01oSm9UZFJ4N0NWZGQrYXdk?=
 =?utf-8?B?ejkzdmdhNWMyRlJPSWw5bjEyRUgrbTc0blNOZjBhTk9BcDBkajRQaFhIRDlC?=
 =?utf-8?B?KzM1WDBGZGxCMmYvTGNBNXZzb1ZEZy91T3d4RWNyVUxVMlZjelEyU3lCZFcr?=
 =?utf-8?B?MzNBU3VudGFBM0VyZkQ2akk2aFVneW1sQWNnZnI0M1NSeHlZL0I1UzdudXdy?=
 =?utf-8?B?SzdGUlNSUFM5UnBxelE5MFNGZDV5UTI2aktVTTBRZE5WbXJFOEdiZW1rSnVS?=
 =?utf-8?B?QmlXVFE2WXY4K0ZXTGpLTlUrR21sajBTU2FGZlpZRkk5TWd0d0F1elI2eGY3?=
 =?utf-8?B?WkhqSWcwZVpmeWtwRUpDSFlmVVJJNzQ1MHl6NkZqTlhWQnNmZmgvbi9JaGhY?=
 =?utf-8?B?UHlnbmRaQWJDYXcyVDFqRVkxblVQeGlSTHZXajJsMFZCV1FUTG1BNzZ4eDVh?=
 =?utf-8?B?U0FlZzNwZ0VUUnh0SkdLdFJXMkhHZTNCZm1Ncm9GWFR0dXg2ZG9aVXQ5SkRn?=
 =?utf-8?B?S21PUWlEQWN4R3BFcldGa1lxNExSMng4bUdBNGRlMVpPeGRtbmJ5d1BKTUR4?=
 =?utf-8?B?ZlUvOEpaVzJiV2RBTElSRVdraDVGVmVJWllaQWRhQzZzV3ljczRWSmNRL1d1?=
 =?utf-8?B?cXZQZUw3M3ByUHFGdlQ4aUZUMjNKdkg3MUU1K0d3T1lyTUVUZndUaUhHdmdS?=
 =?utf-8?B?RWozajRnbWZCeU43TXlHSGdqOE5COXI1VjlVTzV1SmtCM0FmQXdOZEdJaUdW?=
 =?utf-8?B?QzFCVmI2b0dCSEo4V2ZWOXMxRWZmUTNPQmpmMFA2UFhCa29SN2VDa1BTVWRO?=
 =?utf-8?B?WlB2dFErVkxMMjl1djkvWitZQVRVTlBhb2VqOEczbjB1ZGJPeE0yNFZFZkRo?=
 =?utf-8?B?Y05xd3VMSUEzeUY1ajlUakVHZkZra2c4WmJ0ZlRaV3NidnBSYmtxZ0ZCNUpn?=
 =?utf-8?B?ajkxckhKTjAvaEZRYXJDQ1hjUG1pQU9mdU1INjREZW12NWVWQ2tvVjFvS3c0?=
 =?utf-8?B?b3BpZkYwUGFBbVpjOTFzWFR0Wlo2cGJUazc1aEVpWFNhNnIwUDlrd2l5cWNy?=
 =?utf-8?B?WUJCMFFNK0IrenBEUVRzM2tGaW9oSWJpRzQxUFcvZzFJNW9KSjFVK2dIRVVX?=
 =?utf-8?B?V0xPSDZxcHJaZjNld01NVmpNWllTSFhUZ2toZGlLU3Erdm5nUGxYSisxb1ZV?=
 =?utf-8?B?SDBLVUs3MlV5MEVxSHRmRUN0aXBXOGxWVUlldnV3Y21YRTJDOUNqcUZ4S0s1?=
 =?utf-8?B?ZlR5THEwbCtlVFFvM1piZGlGR1orSWtLNFJpaHVQVjBQYWlXUDhCUmRsWHMv?=
 =?utf-8?Q?DXh0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b479aad-7db1-4ccc-2074-08dcb45130d0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 06:46:38.6646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKPLknkPwZ/D1JQNn7GUQluTUxhWl0/X1zlkub+nWHpdPrTt5IT8Nhyvwmk/BrYX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

On 03/08/2024 7:26, Jakub Kicinski wrote:
> cap_rss_ctx_supported was created because the API for creating
> and configuring additional contexts is mux'ed with the normal
> RSS API. Presence of ops does not imply driver can actually
> support rss_context != 0 (in fact drivers mostly ignore that
> field). cap_rss_ctx_supported lets core check that the driver
> is context-aware before calling it.
> 
> Now that we have .create_rxfh_context, there is no such
> ambiguity. We can depend on presence of the op.
> Make setting the bit optional.

Reviewed-by: Gal Pressman <gal@nvidia.com>

