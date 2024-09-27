Return-Path: <netdev+bounces-130073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317DF988030
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 10:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 532C11C208DC
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D247117E01D;
	Fri, 27 Sep 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Wj2AzHex"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AC718C1F;
	Fri, 27 Sep 2024 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425350; cv=fail; b=ZUYD6xedDlm14PVSn+5J33OAZWdAp91OTt41R6zMB8NMTpLS6rYokMEPpvPoU4KTliKe/ob/KUrNcDM4egBKAb8NXUtO3XLVs4WTeLQuFtzu+eHPQCw5ONSfmDBaQngoVKDK8pMCKZaSDxkSiW6K8LQYRs0SesGpZsvnODgMbJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425350; c=relaxed/simple;
	bh=p5GlO3Sj1JrbmDvd5ZwZewAMf5QeBjOaSvPi+kr51yk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QcDu2g4n5vUIGNfDHqij9ctHDi80vaUMP4vTyNecSztvujh57C/bXoA5MlTA/LFVHFe7GdaGSEB9Byj+BYBygvpqtRqG1QXq+Muj/aQPTp8rOjclspn+DFtdfogxUBN09jhFCxfesqlyeAK8/fXvqnsnVx0tMkOoUZEfqCskoeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Wj2AzHex; arc=fail smtp.client-ip=40.107.255.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI8ReCbTRN1qFKAhw6+D/7pYXri4zvSvS8oNHJbM2iF771I3YrRthPrgqqwGbFQzYoYSv2S4EUzpCPoz8D6qeb7SJvilb66msD3rqRo8HUnY3TNzXSEYFCdKOUQlZXr0iVkPeHTPjKcAX+hWgoNBuTOU5zYv2IQfza2cEOh1nGLgHFq6XgSa7FqhD1T+0NFLSH+rCgSDjffTjsbIeKRB3p8PNVWCNcIi9nA0wBcku6UVqBNTMLHDC/X/aF7Vt743Zs05y+Re/WaCPyrrACSM/aKyh29udQO5HrAYfEoo55xsiP06RVqkbu+AlU67vgsuW6V4fMqXD/U3pWfocSxpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj0ERSVTCpblKXgiUQZ3J8CtJ68VcGe3ifSoPZm9g9w=;
 b=fzEL092wAwhSM/BZ+sj9JEgLMfACwmfn15Cn5S6ANms7smju+md6Vab38L6JALOCdgIutuhQNOqjTEGJk1GpadT1L+DW0QsWMnJxoGH5jACjQX1mWKWGA+7RhIo3xuhueHuxmqj8Oeo+N/OY9F1XCSWnLq8x9uhxOIGKUIQSsRtOOY6f+q/jxNv+cbbTVwcpsMlFfaQR9CTSUsqOnv8AyEDF88AA58FDefsYmyfoSAk5wFtFGfLnxou5ge4mOrZ0BZB3WlxGPpG8TakPhNaciS3iSdAb93gqk4FLXi8Z7lFocz2kAeXVmNAHcpJY2Lqb27HTPZXxq9kjU5tdbeFGUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj0ERSVTCpblKXgiUQZ3J8CtJ68VcGe3ifSoPZm9g9w=;
 b=Wj2AzHexYW7EyggFfWy1jkiOjQXAjxR4/46BQIhtuVbV+D8u05E6TyxFTD86IonxHd7aEPnbRwiTLsXL9yNF2iwfizzVqEGcmo6PG1p3yzE777p5LNr1MJvVH7m7QEOix3GX/oCYwCptQy+6DirLE5czDQ7/tzUkVHLiipp6XVNfjqAnq+AXsqaUgUPF3jtuVpBPD6c0oVsOGb3OfX7c3wnWpUy2LZYn2qEwWQgApjn6DUnIqMM6PB2AWCapVkA52gUfm06moZFxVerCeB2ZpCPC2PoSNXut06lfNLg+hzDhi+UVZtXJgbupLumhEmwkH8sPSeY7D/NiCWIWeHIDiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com (2603:1096:400:22::9)
 by SEZPR06MB7228.apcprd06.prod.outlook.com (2603:1096:101:229::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 08:22:24 +0000
Received: from TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920]) by TYZPR06MB4128.apcprd06.prod.outlook.com
 ([fe80::2bb1:c586:b61b:b920%7]) with mapi id 15.20.8005.020; Fri, 27 Sep 2024
 08:22:22 +0000
Message-ID: <812b36ac-2fcc-4107-99ad-a44e3e2eda71@vivo.com>
Date: Fri, 27 Sep 2024 16:22:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] atm: Fix typo in the comment
To: Simon Horman <horms@kernel.org>, Yan Zhen <yanzhen@vivo.com>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240925105707.3313674-1-yanzhen@vivo.com>
 <20240925200539.GA4029621@kernel.org>
From: yanzhen <11171358@vivo.com>
In-Reply-To: <20240925200539.GA4029621@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To TYZPR06MB4128.apcprd06.prod.outlook.com
 (2603:1096:400:22::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4128:EE_|SEZPR06MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 7316835a-5082-44f5-a028-08dcdecd82ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|43062017|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEdZWkhuWktDeEpSK2hQRldXejUwQUhpNmZsTjRnVzRyRW9RMkdHQkR0TWVG?=
 =?utf-8?B?TGs5cXBpM1MvbVk3VXFZeGFQRkQwYTVaMjhlWUNkL016RjRUVnpPdTJuQVhi?=
 =?utf-8?B?YkpQUDBJcFN6Tm82bmF6WVJ1dG5rUHZIdzdtVVJPc3lKdmFhYWZYeE1DdmtD?=
 =?utf-8?B?RWFkS3JrN1k3Y25jbXJRNllXbm5uakFGMGNCQWp0Qkd4ZmoyNTk3TWI2QXE4?=
 =?utf-8?B?aHFOcmREeGZ2cHllWjNjNkhXdWhPS2xoTHVweFBGT1BPSWdDaGhHQ3lMU3p1?=
 =?utf-8?B?MXhaR2tWeDFGRDlaS3Bqa1YwRWtHNG9ZSGJUQ1VTeWcxS2NEMmN5OE1ueDBO?=
 =?utf-8?B?U2ZXSURrOVNCVXZnNTVEZkxvMzFJMjFUbzZuYmV6TlRTNE1Ma0VUc1ZMNG9U?=
 =?utf-8?B?OTAwZ2Z5RVU4RkF5Ny9DRG5pcWpvdjU1QWVnRHV3M2FuQXdTOWxxSGNZVHg0?=
 =?utf-8?B?N05GdmRMZXFHbVRKdXIxajU2YkRXek4wdFBYMjBvSkRxL0tUdzRwK1FJTWd2?=
 =?utf-8?B?OTJzRmg0TStnZkR5bUozMUdRWTVpRGlmTGhqTVFaRzNJYnIxaUZyMGUzTXUy?=
 =?utf-8?B?TnV0UHMyUExQVC91VHlhTExoalVzNFo1aC9RQ0RWL3dmdEtZUVp4emExZlZa?=
 =?utf-8?B?blVhZnVPZ0Jidmd4MXJNWmEzbXlrd1htVGhsNlFNdnVmblY1YnRYdGVnSkxk?=
 =?utf-8?B?czExUmJuOWsvUUloTHZTbEJPSHlxMkkxTWE4Q3lxSEV0Q21WcjBsZjhtUEJB?=
 =?utf-8?B?MGY2TmFlYkdiTUh5TWxmbHM2bGtRcTFhM0ZPSEtpVVd2TXJZczdEUWREc0tq?=
 =?utf-8?B?U3ozNUZiUk5HQ1FCdlEwL0c3SW45TGxoeit1bUsxZC9acHBoS2JlMkZNWlcw?=
 =?utf-8?B?UzM3bm1zZzZlMjhQWGpYK1N5MGI3WW85d2JzZXg2eGZMdmFxaWxLTFlleVZQ?=
 =?utf-8?B?U0pvMWJ3dHFPSjI2VU1QdHFtMkVUNE43ajhZVkN0RTFvTUtZdUdleE1CTTFD?=
 =?utf-8?B?YkRMNks5UzlrNGlkUWJOTkl0alhtRTFTSWxrU3NtUndBWklZYXRjbHhlZFNt?=
 =?utf-8?B?Y3ZzTU9CRk1xNTZudmVtOVlTYmd3N3kxOHJJQm1RWVRUR1ZNYVhxUXZUTWRH?=
 =?utf-8?B?TndNODlSWjVRdnRGdk1IMERnZXZLQXVxRGhIS2diOVJWelJLYXd1VjV3dk5o?=
 =?utf-8?B?WGcrYlFLa1dPdGZYeEROKzNOZHNZSFM2UjVXaXNOSkgzRXNqaWRoektxUXFl?=
 =?utf-8?B?MnVYWFpwalVqTU1UWG1iTlZKdE91MTdLbW5XZWZYRkFuKzBPV1NVa0xReUpZ?=
 =?utf-8?B?QzRQUVg0VXVHaGVpQW1OUmtvcG1ZaVcxVHpBSkJac05mZU91am5rL0laaGx1?=
 =?utf-8?B?bDZsa1N5bVRBaDBYTHhKZW9FTFpGeGdkNFVvZ24wT3hIY3VQMnk1aVRjdTBQ?=
 =?utf-8?B?L3loSzFhV0srWlE2SkVJaUdjTnIvdjNzZVN6NDVjYmVnb1VDaldlZExRTmRq?=
 =?utf-8?B?dkNheloxTkYxaTJjMERyNWtmNm9aTVk0MmNTMWw1Mmh2S090UzljelpzM1dh?=
 =?utf-8?B?cEdJeHJqRjRjelNRMkRBN0E1OWpKQzBNb2U1djEvdU43UUFRalhSRUo3MDFl?=
 =?utf-8?B?SjNFZURRdm5nWCtBZUtHaGdkM0dOMDQ5RnJwTmZidGx3c3F6SXNiV3hBT0Js?=
 =?utf-8?B?MjNWQTVoU25UREE5V3IrUzA0eEZVZ1E2T3BmelpFWmpJd096RG5aZFd0S2hx?=
 =?utf-8?B?OUt6Ynd3UDUyMW05Lzd1NktEWGZ2ZFNveGs2bThEd2pkdWZsMkpFSU5McitQ?=
 =?utf-8?B?RS9weWI0dnVFaURhai9lQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4128.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(43062017)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnFOQVdmbE91WFVQZUxxSC9VUzlvWHlnTDlHVzVEY2NHOGJxUWJ4bzgvYThE?=
 =?utf-8?B?NE5RaFVLdXd3Z1cvYWVneUpNQ3ZFT1hxY1N5T29QNDlkMTU5OHFJMkxvZjN0?=
 =?utf-8?B?azZlOG9HS1lERHdsZWtaNXVWZ2xBeGp3ZldvcU4zRkF0djRIcEtwTmNwaWZP?=
 =?utf-8?B?YThSMENWL2pRcmxIbnZwUlJZcmM0TXgvNDljdVJhb0RkWXArSWxrR1BHcXN3?=
 =?utf-8?B?MzNpc042S09PQm1oOVArMXBtbE8wYjYrMHlFVWg2K1A4SEh5VURXQWZVaS83?=
 =?utf-8?B?bUY3ZHlpTW5DaC94aDBZNXo3OVp3SUt1OXZEbGxpT0VpYTY4bkI5bFpRMlgr?=
 =?utf-8?B?REo5RXJjb2NKVmxIVkZkdmQ2VWFBZW1yaHN4QjY3bDVwaFFRcjBZMEF1aTl2?=
 =?utf-8?B?OVVnTkpDTC8wM2VJTXB4V21XYm1rMWlJYVF0aG02NnF6M1IzL3dLUUI1MWl4?=
 =?utf-8?B?Mk9xNkgyUUpES3pVQWRkWlNDT2w5QzRDV0VBK3h3eTZrNzhQbHFsUkhrVTdM?=
 =?utf-8?B?VWR1Z3ZuVnI1UzhjejRybURMQXNPU2gwMGxWa0FIOWdjSXFuNHFHaXBYRGU3?=
 =?utf-8?B?SWZwQlY4OWdZL1JQekZ0aTRVblBVQW81YU5VS2NJb0plV09vWHJIdWFBVDBa?=
 =?utf-8?B?YyszVXRjS0ROTi90QUFVYTNIL0VKZS9pWmpzNCtvRU40bDZZQkE2SzlqYVhh?=
 =?utf-8?B?YW5CcVlYRTMvS01DdlBTcUE4QnBpYmwvNWFXSGRCSVZEcEt4aXJCd0lrQUdX?=
 =?utf-8?B?T0x5VmlCVktKSmxmZHNyQWhLM3FWZUUwR3hROWxXTDMxeFZPVGxQMi93bk50?=
 =?utf-8?B?TTQrWWgrUnlHVkNxRm8wbjQ1Z3BHdkRzSzNSWUs5a3Z0Y0R6NFk5bERNYmNL?=
 =?utf-8?B?c2d3U0VUWVNFdWJvTVh5dzJrdjJwdHJrSXNMOUVGdTJTWGk4aU1sV0lOU2FE?=
 =?utf-8?B?aHNjTDN6TGtGSG5XenpDOVZnclVSZDBQbktZOFdVU2w4ZkJ3VUxXTVhaN1Zw?=
 =?utf-8?B?T2Nwd0IxbDFlVjdxQWFzT28yRDd5dGxvSEdDYWVwaU1CK0VCS2YwSDhNQzk4?=
 =?utf-8?B?Y0E3RVBUOXpxNlZLKzZxM0lwVXVKa0k1QmFDcEZmRDY2amhOeXE2SU9HTnkz?=
 =?utf-8?B?a0hmY2lLc3ZEOFEwR2dwSlQ2aThIY0k4NHpTY0kyc2F4VkZ3WmpaSW10MUZ5?=
 =?utf-8?B?VEZNTEdZUDhCV1VKS2ZJK0ZNZTNOaGFpdFJjblUvOThTNkw5ZkxOenBxQXg1?=
 =?utf-8?B?UFoxcHIrd2doRVprQWpqVUtqNWJ1Z3BjQkFvSy9wYktqWmJLUVNoVHhKU3pr?=
 =?utf-8?B?eTFYd1VkUU5TMnJtTklJVmxRQ1N3bEdyZ3FzNWNVRzF1bkhjbkJNTkNKelhQ?=
 =?utf-8?B?ckh6NGVaelBoQW9xT1RxVEs1QXVrMFJ3WUc0K0U0V3JSVEpCWjMrNmV6czVs?=
 =?utf-8?B?djYrM0FsK0JZSGhnUDFQQTRxY0VhZFN0elZoVVFobDg1QTRXemZPVUg2WDh5?=
 =?utf-8?B?NmJsc3VPVFNLLzQwMzN1Y3NTVHg4eUZQSjR6eGVxcXFuSHBhTEFqb1BrY25x?=
 =?utf-8?B?OU10SFdjMlVEdlA5VTY3andocDVKVGJHMC9HVDdtOUY5NFFsYmsyTG0wcmVp?=
 =?utf-8?B?OEpWZzhiWU1rWWVlc2hmUGEwTW5TNXdKMFI4T3dNTUo5RTMyTjdIcWpNVzZv?=
 =?utf-8?B?V2lUSXVsbGpBSEVoQkxyU2pwSWtrVThsN1lFNEhtZHA4bE9ZUU9DRCsxaFh2?=
 =?utf-8?B?VnhHbHYzcStQS3pHQXl0MDlmYTBRa1RiSjVkS09wVFdNTE1lcmlwQktVajRa?=
 =?utf-8?B?OExhVzVrVVNNOUVrWW0xS2RBK3RZYTROenZLUGZoQUY1eWFRVnJ1aWVoRE9P?=
 =?utf-8?B?TXRLMk9qRjBWNVBQK2xEd0VRTUxYRTgrSlh0OXRqb0JweWMveWFqWVYweGNM?=
 =?utf-8?B?Ui96dS93dVZjVGhUNDFCbXpFNmtuZFNXc1lsQk8yYm96dThNUVZBWXVBM3Nq?=
 =?utf-8?B?Qm5SbFVPR2RCWjhvd3BjV2V1VFpzK1lZSXgrWlJFRkE3WS9FSFM4cHUwbkFJ?=
 =?utf-8?B?ZEczREhpVEhaOTY1SmJJd3pNK21CeWxzU2FPVVV1TDdJSHk1eGlhaVZ5NDQ5?=
 =?utf-8?Q?hY3te3+mugmv6kwLyuAkKia1N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7316835a-5082-44f5-a028-08dcdecd82ee
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4128.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 08:22:22.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM6AD84jkLWhLF/Dr7KUYlVxj5JoYD64cx//J+HUF7DDS18rjjgCFZa7W8RYGmDFTb1DqkZcdO17ly8uirnD0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7228


在 2024/9/26 4:05, Simon Horman 写道:
> On Wed, Sep 25, 2024 at 06:57:07PM +0800, Yan Zhen wrote:
>> Correctly spelled comments make it easier for the reader to understand
>> the code.
>>
>> Fix typos:
>> 'behing' ==> 'being',
>> 'useable' ==> 'usable',
>> 'arry' ==> 'array',
>> 'receieve' ==> 'receive',
>> 'desriptor' ==> 'descriptor',
>> 'varients' ==> 'variants',
>> 'recevie' ==> 'receive',
>> 'Decriptor' ==> 'Descriptor',
>> 'Lable' ==> 'Label',
>> 'transmiting' ==> 'transmitting',
>> 'correspondance' ==> 'correspondence',
>> 'claculation' ==> 'calculation',
>> 'everone' ==> 'everyone',
>> 'contruct' ==> 'construct'.
>>
>>
>> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> Hi,
>
> I am curious to know which tree is this based on?
> I don't seem to be able to apply it to net-next, linux-net,
> or Linus's tree.
I apologize, I may not have generated the patch based on the latest 
branch. Is the net-next branch currently closed? Should I wait for it to 
reopen before submitting?

