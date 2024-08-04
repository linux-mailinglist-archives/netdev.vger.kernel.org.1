Return-Path: <netdev+bounces-115513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D602A946CD9
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 08:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3480D281764
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 06:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066ADF6C;
	Sun,  4 Aug 2024 06:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a/yvpRTZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D723FC2
	for <netdev@vger.kernel.org>; Sun,  4 Aug 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722754079; cv=fail; b=e+PJ2Ag9uymjcMutEGhXwRqY+FOes4w0nqMXl7FI3y8IpyOx9O0aqr+eygpT6GfIjXHJ7WDwN7Jp/OzVDPMnyemXycDNoR6raZQKcjmOlU1zUnf7x4wP7dKbapspxhYHHgBp+HI1UlZmLdrJ+LrIxeO3VoBe12nhRFJcYudjR04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722754079; c=relaxed/simple;
	bh=N21dl+Yr9ZJZE0wpFfuFSRyWYrRQmJ815fgjMTB4UXE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l0AWKD51hmy/RV9AL5Vmv9EMwNA3BAz5ZeRKt1sSqOmJaOd1prjMOYoo9v03tUkXG6JkLSDf1PJU6fywBACRg6KP3Kk5cWqqqIg/DIkwjYsGZ//gaFb9icRTiLrWxBL+FAZJ994Y/zmnM+nzE1/nOTvIATjjx4XmaTlz8P1wtYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a/yvpRTZ; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCOgiqIdq6VBDMc+gf8ZlyoW8cxnHQckATqlRRm0/43Aam3uC0xpkPUjQhyhv2rVc0NOrDYU/YxNYuBFgGXK8Bo3Kofj+4jvjzPxCJ+ZXrtZH4HnzQho1Qm7uRpxFd96y6owplOKgy/eIk6iYqjdP1lmFrqedjqgBE044UG/RFFzC9BQea990L9PtC5tYSOwQuLdkrC5sAIEnxnPKcrbeDVJZX7nxfuSVilhFXA2iK1UcloO6smUDc9VDsv755bzN7cwC5twu7ttV2zFHgM7VKxSqPPRJVxL9WQ5Ttwh8J2wBiPoGUpANk2FN6vA1aw6pixZWZPQwNaQQuFnWDaVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N21dl+Yr9ZJZE0wpFfuFSRyWYrRQmJ815fgjMTB4UXE=;
 b=W8pU6jh4OVQ5Vwg7ZwuW5JgUO4QkecrkIrxpevkj9d6R/1cYFnSthqjr8kEYrCLaU+DFBUVFIxGruYSUGTy8uLM53oxAS46Q1Q2iCB+dTg/LTPrJLfcTSAlRuV2Gx56bwQVf/Uj3R+0J8q5QXxxfLhXQd/MRO/gQLg3JO2GywwqAl8Jkf4JWNwJIIKc3ZR0GdAcBBcu4/rca+3Vr9IwL03DoXKkOVwTdrtmH6sRHuke4XZ5ZW1jWjIGyQtPTBFqmUCKnR6pp4qdpl+QrTV3qFLJBG90HYwna1mrla9jkddfhoQI8PfnsTB4+FLTKZa8cp+cgfuiSXTR/Wx3Qfef7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N21dl+Yr9ZJZE0wpFfuFSRyWYrRQmJ815fgjMTB4UXE=;
 b=a/yvpRTZJ1qIFC0+1+Cq09ctP6TMKA+pHZd1TjLcvqeJKm/Hu8heFiWcC2OAspsaCm+HURawkeOWuu1zTBzdJJ5FGFbB1NZhtS81EHsnYC1lH5ghoY0483TYuKKWNB6zwBIKcyfdxjz3ThqChusyZ8MBBZzC1WnLllq9ywaY1ZsaLqrOtSvu8mJrbFZhD0HEqXC17G2kJ8a5WEfyemj/16+7Qb+hBhZxdtdcNJjEjzZvPUNF8ccrbF6spyTJt8QK4L3KcBmbk4v2ERwDifM9pe90s/ilVTuZloKPdbFJplMuztoeu1JyMkXonxghjtW1gBVQxotsXF2+ZWYEA1v07w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Sun, 4 Aug
 2024 06:47:54 +0000
Received: from SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430]) by SJ2PR12MB8691.namprd12.prod.outlook.com
 ([fe80::63d0:a045:4ab1:d430%7]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 06:47:54 +0000
Message-ID: <2c5f20a3-7327-4e92-ad54-e8f43833ca13@nvidia.com>
Date: Sun, 4 Aug 2024 09:47:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/12] eth: remove .cap_rss_ctx_supported from
 updated drivers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
 donald.hunter@gmail.com, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-6-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240803042624.970352-6-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To SJ2PR12MB8691.namprd12.prod.outlook.com
 (2603:10b6:a03:541::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8691:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d2c52b-443c-4372-4564-08dcb4515e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkNORGZ6STcreE44WkU4akRqM3ZxWWUyczVSQXRNOEI4WEc3U0tJaTVtZHNu?=
 =?utf-8?B?YVBBbDNLRHIva3dmejZoUklFS0xUZEpPQ0tiZXhiajBiMjJad1drK3NIRHlJ?=
 =?utf-8?B?V3pvRFBFVDQxa2dNU3hZRnFFa2ZDZHdvbzRqQnU1Z1UyUmZ1SUJaUzU4Si9u?=
 =?utf-8?B?Y3JqbzZoRE1KdFU4WkhlVWZ0emNlRkRPakpQUXJpMGxDUktMZnd0ckc5WStt?=
 =?utf-8?B?bWFNUW5pRldRRUdpZ0N5Z0JqaFNZVHJhREpqR1hiWWxVSjZhVkd4OER0ZEYy?=
 =?utf-8?B?a2dJRVFtUCtrNVkzenRSeGJodTM2eWx0c1RROWh2TWxxcVpaeG5EdTBKdjFo?=
 =?utf-8?B?Y3lvWVgxbTNCSG5wYmVYT0RjeWhIREFNb09na1ZvbzlvUEdMOTZBTVZ4NGNC?=
 =?utf-8?B?a3BYdWpzY1VrcEg3YURveEh6eEJsZ1NncUJTN1pFWUlQeHRldUVVMkw1ckpm?=
 =?utf-8?B?N3RwTnlKWERFY2hpSitBeUFIdVp5UUhTUHBxSWJHWnROSDFaa0VscTA1MXUr?=
 =?utf-8?B?SDZINnJvTmtTeGtjdWxYRHlwS3lsYUxVTDU1T1AraExBdGJ6cEVPQjVZY2pm?=
 =?utf-8?B?RG1FM09iM1ArNkQrNUhmWkZxL2R1T0RocEMyTlVvak5oSG1nR0Fyb3BLSUhw?=
 =?utf-8?B?ZHF1b0FncEoyV0ROeGFmMkFkQWViVm9qVFY1dHZOcWpZcHkvOGlEbnhBdkYy?=
 =?utf-8?B?VzVUMnN6MWlmcnZSTmdUOGhZVXpaUWoybDVjR29lZThHZE5aZ3dlSlV5R1RJ?=
 =?utf-8?B?Q25YY1htcExHSm1wVWVYUVZkRmZYOHlCL0NnZVJZeVpkdGNmOUZjMHZack5r?=
 =?utf-8?B?WkJmOVNjK2RCRWxMN0pmbyt4emxESDRDUHo1dnN6Tm96QzQvY004YytqejNn?=
 =?utf-8?B?dkpFRFB0RTBTZm02Qi83YTcxNHl3SE5KeVVzQzdQdDJUaHpDcjZKMm13VjR4?=
 =?utf-8?B?cGVQRmNES0k1Y09UU1QxL3djQzhBdGhTayttVkl5UWUrcm5kSVQwUDhWRGZE?=
 =?utf-8?B?WmFBckhGclZTU2pvRFVCbm1kTHVsQk9NTStnNGRqMnh3YUtiMEp1bmN6NlFY?=
 =?utf-8?B?VlFIcVRzT01DbWxBMGVyekNEZzBIOFcvdnBDdklkQTN0RkpDQnhDWWtOeXFJ?=
 =?utf-8?B?bG5kdlgvSitna0QxU2VWZWw3NDdHL2hNTitma2J5WjM0R3lOMGJCOFVlVCsx?=
 =?utf-8?B?b21vWEtvbTJIN0pmWEtDTkRBT3V2VlppUzZMNkdqSnd0dVEwYytnNmd5d1dV?=
 =?utf-8?B?RTc3aC9GTFRnRGRONytJazIyNitCZVc5UElHSDdIMWhsZFJZcDRuR01YT0Nt?=
 =?utf-8?B?NUlQcUM2MzE2UVZ6L0prU0pDRjErSHFCM3liZGhESEtTYWlsWG1leEpBbExu?=
 =?utf-8?B?ZEN6ZlBRc2Qzb2hJWHk1dmlDNUoyRXN0aUlWL0o1aWc0ZnVKRk0vZjhIZDNI?=
 =?utf-8?B?Rmg1QUt1MHNKeHBjbnBHc0wvbkxMdTcxZmZyTXEvSXl3SFo0T0R0SmhlaHlp?=
 =?utf-8?B?VmRLeTMvV1lXMStVQXc3M2pVa3B1VTgwTkVvRFpNYi83bHBKVmxKbkpUcTg2?=
 =?utf-8?B?OUh4ZEdFN0YxdGtJZGpOc3ZvOUw0dFlUZ2s3dUtQZmhGNVBoazRmSHNaSU5h?=
 =?utf-8?B?eFIrRStvTzhuMXVNMmFteDNmSHJkaFYwcGg1NlpuUTJFVS9GWVFyUDBHVnpP?=
 =?utf-8?B?UU5SNGRzd2FlTVVrQUQ4Y1dRZDN0MDBBNE5tTVZNUWJleHRraS9weDkwbzBr?=
 =?utf-8?B?bmR2b0Z1aWkxRjZtMmUxTzlmZUV3ZW5zdHNaU3lSZkJVMzZWbmIvTDRlbExJ?=
 =?utf-8?B?dWJqU0dPOFFwb2luaUFHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8691.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3VzTkJ4K25IM05FdC9zVysvQjkwWUp1TGtkTGdJZUZPYXR0d3RoZlhvcUpE?=
 =?utf-8?B?cUFydVFGSFI2NTN6WDBlenZ2WUN6eGMzMldXSXc0NlVrUHVxM2JyMGoxR2xn?=
 =?utf-8?B?MGdiU2RTS2JCODVEamZUdzVHRm4vTXY5U2QxaUZXTEJFRFF6Mjd3Z2ZRa3Bs?=
 =?utf-8?B?eWVEckZhakI1QjdKYk5udEtYVVY2QlQyWkNqNGlJMWhTTnRUclhNLytmMHdn?=
 =?utf-8?B?K0JOb0d0Ny9ibzVSblhNbmJvZ3BGNFlQUlFOaVRpR3VWV1YvQklZUERRK001?=
 =?utf-8?B?aTh2NkxDd0VYa1ArZWt0bElyY3lRMkgzckNYRlkrSkVvVTdmK055UFgxbS8x?=
 =?utf-8?B?ZGhsei9NZzNxam9KVUxMUXVTQ0dTZGt2bFdMV1BwbWYzRmtPTkJ5aHBvUHFk?=
 =?utf-8?B?cEhCdEZ4dGNuQkNrSFpWZlZKWlhwTnNPTm8zK1FLN2RWTzg0R2ptdDlQK3pI?=
 =?utf-8?B?bHlRWGlyMmVlYUQ5V09xSU0wajRzOVk4a3YyNVU2cVBHcWxqcEZHL2NTK3R2?=
 =?utf-8?B?STNlbEMvWTBwRUlyVGFOZmxITnBwM0hvTFhPR3NIRmFrUHYvSGxDenJPSE5m?=
 =?utf-8?B?d0plQ0R3Yk1DdlRHdzZpUWtJUnpqNUZUNkZlVUxVTFBVbWVKYUhFQkE3UEo2?=
 =?utf-8?B?T0JnSStPYlNlRVBsVGZvRTk2MnJuSk5aQ25iUlJza250STk5MWZPVHBaMW1O?=
 =?utf-8?B?a3VmWmwvczg5UGZkcmc5TzZwTDZUNGRYYUluZ08vNW1TUUJOVTd5ZEpKa1NC?=
 =?utf-8?B?WmpMcVhiNGtNUTZHb0xMdlZJSWJtOXFLRlVCZjR3Q1hZZnNUUFdUOTNmZmJW?=
 =?utf-8?B?bVpmdTFwSVp3Tk9NQWh0NmJIV2VqT1I2aXRNd1BROFp2dERBMlV3VGpQSXR3?=
 =?utf-8?B?dnliMjVLL0owNTViM0F0Yk5LT25pQ0Z5bUZqbU9Pek92akdTMVZjN3ExV0hw?=
 =?utf-8?B?bSs1Z2JnWjZiMUdISEcyTzcxN0NZazFiV2NNTllpOXU3RTRwaXR4cnB6VlRP?=
 =?utf-8?B?enV4ZCtLM0JXRThaS0ZDWXUvS0l5SjB5QXhQVExubFVudDFOSEY3c0xMT3lI?=
 =?utf-8?B?TzJTVXlsd0IxNmJ1THhvKzhkTjhqdndHZHBuaE1WNjV5ODBLVW4rR3M3NjZ5?=
 =?utf-8?B?TFNBbjFRTUdiVSs3aWxuTlhibkNwRm9MQnJkbXRXUThNWFBGbjBpdWw0dkZC?=
 =?utf-8?B?YjNndCsyZGxzbnM2cS8wZTBBZ1NOZ2x6ZG5RdVBRUGVqQStJMGVlN2hsd0pW?=
 =?utf-8?B?YVhMYVhNUFBVeS9NKzUwL0IvVk53ejB4OFRrOGxqNmRIOVlYdmc3NlRORXJv?=
 =?utf-8?B?NGI3eDhGWnFyc0pMUjZ2NnFtUG01WG1UV2pRNU43MTRNNzVrQ3pBMmpabURj?=
 =?utf-8?B?VThjNHJ6WHp3c2krVktzMnVNajJYL1RNY2ZWZkNnbjVVaHJwSVl2ZVNyMmtO?=
 =?utf-8?B?TzhZd2g5YXBNcXZJSE5yVmVSbHV3YUtTQ2MxUjVjcTZXUFFYYngxdDgvVVNB?=
 =?utf-8?B?ZXlKeGpNaWh4RjZkdW1NTDZMeWx1MmVBbEtLL2VJVFBubjkzRkYrVmU0SUU2?=
 =?utf-8?B?WnhPV2dKQzFDYzVBYldteFNYek44S21nM1h2UWpyaGxuV00zd05iUVRjMW50?=
 =?utf-8?B?bUxoOFd6aUk5VUVDZDBVNG5hZUI3VnlGVkYweDJJVDNHb2ZQQ0hvVFdKL3F4?=
 =?utf-8?B?LzZVNGJ0R1lTd00zMG1rRzhxcTVoN2tDTDhySktCUzFycFhNSm05RUFrRVk3?=
 =?utf-8?B?ZHo3VUJoS282Vnp5WWxveWJaQk9JUldnUnNnaHhBbkJoZC9ZbGR3Wm4wRVJ0?=
 =?utf-8?B?MjRDM2xGSHFYcFl2cE5ZQVVSUmUyc3hTNWYxdlVxL2JSckVleWZZdzVDR3Zm?=
 =?utf-8?B?bkNwZEZwWFhvM0FjNy9lTHcybFdXOHEva2VNY2RXZkErdmxKdVVmRmZXOHdh?=
 =?utf-8?B?SEliejh5MVpKVTNROVlrZHppOTN2eDNTT3BPR1YwWDRUNTZUcU9Oek5FbnFO?=
 =?utf-8?B?QUJGRHcyQnkzRjRaak1UV2RKSnBleENGeTBlcmtnQjJ3RWkxaGlDSWJFQTJW?=
 =?utf-8?B?NHZXNWVhQ0EvYXR6cC9CdkRUK2dyMERoSWdkSk1YSkYxc3JZZGN3amZSYUN3?=
 =?utf-8?Q?O+1c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d2c52b-443c-4372-4564-08dcb4515e09
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8691.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2024 06:47:54.5805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjfM799nnrPx8SFee1FJAFLHi7vPjmRwbq4rMk2ghPlIF4Co/J2MyLwwVlg+59Ss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468

On 03/08/2024 7:26, Jakub Kicinski wrote:
> Remove .cap_rss_ctx_supported from drivers which moved to the new API.
> This makes it easy to grep for drivers which still need to be converted.

Reviewed-by: Gal Pressman <gal@nvidia.com>

