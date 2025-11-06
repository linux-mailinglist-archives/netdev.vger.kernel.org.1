Return-Path: <netdev+bounces-236480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C5C3CD8C
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943103A7786
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02C33FE33;
	Thu,  6 Nov 2025 17:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YRyUu3Jt"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848362C0F96;
	Thu,  6 Nov 2025 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762449953; cv=fail; b=ca1WyKuWzUzrdQgkdyksN4AYX4taSLnt3JGVvB+zSi4goeoSpw1B52sxVQxDDnZ/BnSP2r4l938xmd9ek1vMLelagCmmFm2JGhSZKjogzcfLZITAWVvT4yptlnO2dOr7rqk5SVEBCFtDASayxr45TqBmhX77SBR5k66QtKSeRvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762449953; c=relaxed/simple;
	bh=sEAYkte/XWJGqxEHz5zTx6hk4pqzZhkW9lrKD4M9nsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=skfKk9dRJIgPjNDen9DHZDS5Rq8Y/Um0aDn0TGXn6SP8NmfT3vAneNc0u0Lt0sIxmU19/Of3HVnvu/0asbmzTLQKQXjqhsKoG0s4VwfuTKj8Augq4BHlethrpHOjacGCzqcsaNSQYQ+COkyjUlz6Jp8EHIAohM/oe2ejJB5d2t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YRyUu3Jt; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPWCwuos7A1KtLHhr517mRTTrbf77uoS2CBPCVXj4fIoFdR14b5pp6LR+9K52V8AN8UpJ4D/46PNSS8qxnN9vG8yT7TFQRTPZDMV5w0/EP/zXciyqkI4VqM0Us0ESFFrf4pCJN5QcQ3C6PNMGFzN6eB5VpKLFjSepeqBStzmvbg336b7aNqBDe2jFs1tH+eWtTQCYmTrANzF6BD6tH4ClArOseA9IWz1mjWOS/kSWvVrsb/DYdXNLK/aOgylOTzBn27Jf8xvw28Pd07ikAtl1GmAWovCE1kXICmOGk8CyU4a0/aA9TAi1UT6DhF/PbbpJ3ke1c0LkdpO+E4tNbfkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHY+tew7WzzBRwmfjC1RWaXp/tEjn2b7msUwAFXsy2I=;
 b=OVnNZxLerB9EyOGSh7Fp32ugkAxdehkH9TogoIMU0s8PZKeI+ccwuG5Gf02jGQrf/zFyasuuDhZMWbjilkMguNWGJhBl7BpjKTR5Fj5Hjoj77Jy/GG2MaMFJmmJ2jSCIhFuRITp4mP7WpjcWHifhLQAHDrybmjSu7LvlkaXmry2KMRSboJ+wZT7mNA5xEhavxvRY0dRJqrSxrpPAKXNEW/5sHECAJ+sOyONxquzWosxIu82JUPFHvwUL504LQ26+xAZwKu6gacx6mZM0KPco4VbIYOfOwF27EzQmBN07dkINdtFbTWJcyeI1VJFuMTV/CcUB8BaqEmKsPCFawy7l/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHY+tew7WzzBRwmfjC1RWaXp/tEjn2b7msUwAFXsy2I=;
 b=YRyUu3JtoPh0l/3XIJWCQHhuINihBLKbVqXxheBbxiBIC+4w+004qapdyZldlekobeqD/rGq8cBUQeq0aAGHECZpokGatXGKCGn8KeNOIWdep4Nz82an6EjbYRIHS49Y7GsT5iOBN6i6BBQPvfaBnC+mov00nQJACVHIg2fM2T/X+ks7X5g6B6NJlQWbIPWt0L56X0VNORnLpb24xKLMAWJcf9KzCBu63+5eYL/kg6n5iIKw/LyvpYtc8KRFVZyyPYAWfzNUz/0eyTTTPeo3bHHY3Yw43pyWpirVpCmuzbtXrqRmhoB7rqn5Vaw1JlT6K+sTJsnFptnuKFzmLd5Hqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 17:25:47 +0000
Received: from IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c]) by IA1PR12MB9031.namprd12.prod.outlook.com
 ([fe80::1fb7:5076:77b5:559c%6]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 17:25:47 +0000
Date: Thu, 6 Nov 2025 17:25:43 +0000
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Mina Almasry <almasrymina@google.com>, 
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC
 page_pools
Message-ID: <qhi7uuq52irirmviv3xex6h5tc4w4x6kcjwhqh735un3kpcx5x@2phgy3mnmg4p>
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com>
 <20251105171142.13095017@kernel.org>
 <CAHS8izNg63A9W5GkGVgy0_v1U6_rPgCj1zu2_5QnUKcR9eTGFg@mail.gmail.com>
 <20251105182210.7630c19e@kernel.org>
 <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izP0y1t4LU3nBj4h=3zw126dMtMNHUiXASuqDNyVuyhFYQ@mail.gmail.com>
X-ClientProxiedBy: TL2P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::12) To IA1PR12MB9031.namprd12.prod.outlook.com
 (2603:10b6:208:3f9::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB9031:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bdc666d-ed0d-4c7f-1bbd-08de1d598632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZZcnYwekhEY1NwSWt1eHlCY0xrSWovaldQQ09UVjJ5WGljR1RTK0Y4UXdt?=
 =?utf-8?B?anNaV1RUVkp5K20xV2NqdnpYN2twWmNnNnJNVWRkblFiV0N1aDRzamxpNlJK?=
 =?utf-8?B?KzBPem5SeUxDSzFOWkNYcVNiVkZ5Z1VLUFF3U0IrVnlwRWFiSkl3NDR0dFJ0?=
 =?utf-8?B?WTFKSC9MRElQd1ZMRUZZOUlFNEg0MlloNkUyVDhoREwzbGs1TWZwYXNMUzIr?=
 =?utf-8?B?SzJkNFA4VFhrK1JzbmdlV1ZhSEZHRy9Fcm14NHhoOHA5T3hSbit5NUlGTHJ0?=
 =?utf-8?B?VmtYeWgrUjZVdjNJaTZ1SEdNaXYrbWtUT3ltRW9LVkhkYm1YZXVLNnJDL0R4?=
 =?utf-8?B?OG14NFlVaWUwNFdHZFMzZm5uNERIY1VwbVY2S0Fod25oMHFjeU5Qa1M1M0Zw?=
 =?utf-8?B?RWpWVUJsYnc0Uzg0NnQ5TFV5d3VweUNneWJ6aXJuSC9TYk5KNkZCWDFSZFNp?=
 =?utf-8?B?OTZyb1dzOWZOL3UvZ0w5UGd0N0plclM4SzhtRUNpOG04NkFuSElFcS9NajFE?=
 =?utf-8?B?NCtiWjM1Q1FxY3JYbTJMQ1NBbXBpZUhiV2hBc1JJZGtpUkkxSWs2cTU1WjhS?=
 =?utf-8?B?ZW93aWJId0lZOCtVT1JYTFBFSmM0T0crZ2hYNStvME9SbHZITm1hcFZtUlJu?=
 =?utf-8?B?dm1GZ1luVnVMRFI5ZWpkdnFLbExvY0hzS29SOWVhZlUyUlAxMjE4clBubmR0?=
 =?utf-8?B?bCtqd2orK3ZlVHRZb1oxSFVDYlVLZXYrRDcxVXk2KzJIVStvYXRLd0xXZUEr?=
 =?utf-8?B?M0RzdExZSThiVWdIdHY3azN2cUFWZFdFdlNwbWdlUDIvWjNGWG9HeGpNWFpi?=
 =?utf-8?B?bFdnSU53aUVQU1BkZGovbEJwaDgrWHNrUXlBT25PRFJUVWZaMG9aT2drT0ll?=
 =?utf-8?B?UmJoVEdzZkNuREZxbG4vWmY4bXpRN01WTEhkL2Z1aEMwaVdOdnA2TklaNmor?=
 =?utf-8?B?eWNkdndrVnZPcHFLTlZ3Ujd0eXJFZWRrLzZoajFsa3JaSUFtSEljZ1hId2Mv?=
 =?utf-8?B?RUVOVllRU3ZYN21KMmg3K0xPMGkxYVAyeVA5RUlxMHM3clBiVEZaYk85S1U4?=
 =?utf-8?B?Zm9leDRRZWhnME9KOXJTbGtkd3lZUFc5OTkxVDVrZjNhNHJMejRyRjJCTlpU?=
 =?utf-8?B?Tjl4WU13aUxYRjdwbDB4c3MrTWZCaXl6ejVUNW1sdm5XYko0VmhPM3BnWGMx?=
 =?utf-8?B?MXB4UXBuSjJIeEh2UmhkZHlXZVY3ZlR1UVRmbk9ocjd6LzFxamJHeVdqcFZk?=
 =?utf-8?B?aGJKWGI1STRKWnA1RDlsR05IMGR5QXQ0eUJ5VTRHME5raWxETmEvNU41dU5B?=
 =?utf-8?B?UW5qS1QyczlFT1Z0dGJLdGd2OE1uTTRBOFpqVGxtRFNwU1JkaGdwOXQxcWNn?=
 =?utf-8?B?K2ZFaStvRnU0dVFweGdxY0lsOE9pa1lxYnFUMzM4Q2w1Vy9KakgrZFhVVGpD?=
 =?utf-8?B?L0d2SFViSHRGL0tDOU1KdWdDL3lacm04ZnNGcmd4UWVYempTK1lieW5mL3ZN?=
 =?utf-8?B?ZWIrQWxVUUtENC80QlRrZGJhc3o1Y25VT0hmdkxDeUZwbWg0c21Dc3prWlVh?=
 =?utf-8?B?Wk9hNEpwMytMT0d1SzlsZzh2YmVRemszeWpONFBxWXlDa25oMHlpOU8vQTJh?=
 =?utf-8?B?TU92MkQzV0M2Z2FidlhkVENQbnJLRERRWXVBRFM4cUdxQzFqZE94Vzh3MWY0?=
 =?utf-8?B?SStnZFBZVHJ2NkpYWVJtMWd0NXltayt1RzZiT2hETElsdWxuVmI0aDc4WWEv?=
 =?utf-8?B?eFZuY0gwM0RNY0FNVGlIajRuRWRoMlVpQzU4d1FMa1dBRkNkZTRBempjNnQ5?=
 =?utf-8?B?alE0QnlETkR1VE14MkRydFJmU1ZxaCtjVUVRNFlxWlVHN1ZKQ0lUV08xdThL?=
 =?utf-8?B?eUlrNGlYU0V4MTFsY1l3Mi9UdTJiVnpYY3FMeGtOSDRCWm8xN2xNS2g5WW1V?=
 =?utf-8?Q?abrzxEnJhNnZCXBbLcGgf1uImk3BLuER?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9031.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHc0aklwa1NyZitySlRMRGhxV3VEUjNFZ3VDaDdyS2pvSSsyRnlWTE04TzdD?=
 =?utf-8?B?eEY1eDBJMkIzYWFsUUNHWWRhY1dQWTVZNUhWZjJtZ1V1RkJDUm1YZHl0WjJx?=
 =?utf-8?B?VXhEeTJBQXlLV3VGejJmbVd6R1AvWHVSZjVPc2xwUzMwSjlXcWJSWmc4dzND?=
 =?utf-8?B?NkgxeWVoQlZkZE5vZklrQlcveHJJeHRBVGxsckJ6cFRKd3ZpWWpQaWlxRlRy?=
 =?utf-8?B?cHdQMi96bjJHQjFrbEpTdDBKTEVzNUlRNlpZamhIYS9Yd2xRdDNTQUxrRXls?=
 =?utf-8?B?V2hPN01UQlV1THpMblJuVCs2eWZ6cURRT1FLYkYvRVA2ODdjenFJYTJDQTZr?=
 =?utf-8?B?Mkthd0FjUFBPYzFBQXpZb01mb05yVzE2KzUvQjZFcFhoN3NUNGRhaXBDUDZa?=
 =?utf-8?B?SEdEWmRKSU0zd01EMm9pZnBYcmhGcytNWDIraFV6Y3JtRzVGUld3RUFwby9M?=
 =?utf-8?B?Q01ka0RkbTdQdHlEUnpUL2ZvbkFBdXhCZE5JMWRneTA0OUl4bFkwelIrM255?=
 =?utf-8?B?RzRWaFNwa21hOC9ENDBtSEhuU2dQR3poSTAvN1BtbmRiSTVQSWpndnFCSDFq?=
 =?utf-8?B?a09RMXNaWGVpWVZXRmlZNFNwTzR3QVN0aFlCUzYvWkFTWVJtdEFzZjFFUjk1?=
 =?utf-8?B?bkRqNmpka3piNzVRc3k3emhZbmYwNTM3TFdNT0QzdER3YjJiV2MyMnZRaDJm?=
 =?utf-8?B?TnlHZVhuemZxQ0Y2SU4wZXpPaUxPT0JYaFdVYnU4NmkzYStKMytobkNLOE9S?=
 =?utf-8?B?ck5YQUlRT0tCbGlEazdSTTBGTGtLZ01qYWFPSy9IY1lYRlBOK0FBTzd3Z3BN?=
 =?utf-8?B?dDI0a0JrR3BZeFN0NUtDbThtM0NnUGlLcGhwSTVXT3kyZWZVazFUOXdtNXJy?=
 =?utf-8?B?MGtLa0RzNTJyQmkxNzhCd3U4RGpBby9pcmRwZHFjeEtLQmFqZjhmZ3pLMk4y?=
 =?utf-8?B?SktqcURndnBob2NHWkhqTVhTYjlsUjRjc0NGSWF1cTRQK1ZTL1BCOTBZN042?=
 =?utf-8?B?NE42a1djSTBIbmhIVFZDR2VyR3dWekhVM1ZhYktUUGtyb1JIQ0FvTU1ydm5W?=
 =?utf-8?B?czJkSHFCWlY1VVNDOFVOdHhId3VzZlZYSVo0RW5SY3lJbmJSa1VQTXArUm5J?=
 =?utf-8?B?aUN2dHM4cmJDc05XZkoyeEozRG9LSGJncFRDdkhibzI1Ty8yTVhScEg3UGlI?=
 =?utf-8?B?UFVOc25YQXJqYm5QQlFwRGFFK2dVdGVNSXlDVlZobjJXb3VFbHBnZ1VWZnkx?=
 =?utf-8?B?cWZqdDFERkZLTXJvMVZnZk4rYjNTYXZocEtuenk4V09WWVlOb01pVlQ5OExx?=
 =?utf-8?B?T3hEY1JjbnV3cmF4QUl0T3ZieGlyWWxVOVVISTFUYzlHbGxCRERUUTh5TzMy?=
 =?utf-8?B?Ly9lVXZXdmtwMnZhZEFwa1NMQ2I0SnVYVDdRVWYwTE1MZzU1M3QyZlVnNVRw?=
 =?utf-8?B?WSs1Z3pvUVplM01VWURndW4waGJUUC9qenlkQVBaM2VDa0hIYmZXMjFoa0VS?=
 =?utf-8?B?T1JLeXI5NldJUzVOOU5Bb1RIZ21sYXJBNjVtUUwwRmhEWDdZNjZSNTlCeGRz?=
 =?utf-8?B?VWgxK3FTdDlZc3ZzN3VJWmk1ZDVhWGVmbG9NTmZKKzZjWEZaeWgrZDM3L1Vs?=
 =?utf-8?B?dFI0bUxXQzFMMWlPd0d0TDlrZElxZkhIRUd0TTBlUnVnLzRMU3U5dHhYYVpM?=
 =?utf-8?B?NlBZTVdMOE9nUW52MDJaRGU1QkRFMlh0T2FBdXVLZStVbVBrcGJNSkFQZmJI?=
 =?utf-8?B?UzVEMis0Vk9QczdBS3lnNGdsNDZMNUZPeEthQVFlbjcwdjhlWlk4eEFIZG91?=
 =?utf-8?B?Vk9VR0RocnFNN0lvRSs0SVMwMzhka0VDbFpsSVZJM0xUMVdZNEM2QkRUdGdt?=
 =?utf-8?B?WnpEOFZ5N1N2ZXQxWjFoaTFZajhSOVgvQXVpWlUxMDB0NElLMERHeUo1TmdR?=
 =?utf-8?B?K0RzaTZaNDZPVEhkbHkydWk4b1lhdXpiMVRXZ3cxMDB2bGxXZFB0c3NoUXNj?=
 =?utf-8?B?T3N1RTFod0JUdTU5bEorVnlyTVEzTmFkVVpqLytNUnBVOTd4V2lMajJxK0V4?=
 =?utf-8?B?dTZpZ09ZZ1FwOVNEQkk5MFJIZE9IdVo2dW9DMDV5RmhuU2pWKzZSWXBiUHNZ?=
 =?utf-8?Q?yieQ8Tzjtzr/pGRc55qD5Rpjr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdc666d-ed0d-4c7f-1bbd-08de1d598632
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:25:47.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTcQVBRWQVdHIyYU6ggkDDY89xa5WcRzi5HSHs/bt9a+ywQ4PhThKNDho8V1klpqupb6kedc22ugfOLR3I+I7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

On Wed, Nov 05, 2025 at 06:56:46PM -0800, Mina Almasry wrote:
> On Wed, Nov 5, 2025 at 6:22 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Wed, 5 Nov 2025 17:56:10 -0800 Mina Almasry wrote:
> > > On Wed, Nov 5, 2025 at 5:11 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > > On Wed,  5 Nov 2025 20:07:58 +0000 Mina Almasry wrote:
> > > > > NCCL workloads with NCCL_P2P_PXN_LEVEL=2 or 1 are very slow with the
> > > > > current gve devmem tcp configuration.
> > > >
> > > > Hardcoding the ring size because some other attribute makes you think
> > > > that a specific application is running is rather unclean IMO..
> > >
> > > I did not see it this way tbh. I am thinking for devmem tcp to be as
> > > robust as possible to the burstiness of frag frees, we need a bit of a
> > > generous ring size. The specific application I'm referring to is just
> > > an example of how this could happen.
> > >
> > > I was thinking maybe binding->dma_buf->size / net_iov_size (so that
> > > the ring is large enough to hold every single netmem if need be) would
> > > be the upper bound, but in practice increasing to the current max
> > > allowed was good enough, so I'm trying that.
> >
> > Increasing cache sizes to the max seems very hacky at best.
> > The underlying implementation uses genpool and doesn't even
> > bother to do batching.
> >
> 
> OK, my bad. I tried to think through downsides of arbitrarily
> increasing the ring size in a ZC scenario where the underlying memory
> is pre-pinned and allocated anyway, and I couldn't think of any, but I
> won't argue the point any further.
> 
I see a similar issue with io_uring as well: for a 9K MTU with 4K ring
size there are ~1% allocation errors during a simple zcrx test.

mlx5 calculates 16K pages and the io_uring zcrx buffer matches exactly
that size (16K * 4K). Increasing the buffer doesn't help because the
pool size is still what the driver asked for (+ also the
internal pool limit). Even worse: eventually ENOSPC is returned to the
application. But maybe this error has a different fix.

Adapting the pool size to the io_uring buffer size works very well. The
allocation errors are gone and performance is improved.

AFAIU, a page_pool with underlying pre-allocated memory is not really a
cache. So it is useful to be able to adapt to the capacity reserved by
the application.

Maybe one could argue that the zcrx example from liburing could also be
improved. But one thing is sure: aligning the buffer size to the
page_pool size calculated by the driver based on ring size and MTU
is a hassle. If the application provides a large enough buffer, things
should "just work".

> > > > Do you want me to respin the per-ring config series? Or you can take it over.
> > > > IDK where the buffer size config is after recent discussion but IIUC
> > > > it will not drag in my config infra so it shouldn't conflict.
> > >
> > > You mean this one? "[RFC net-next 00/22] net: per-queue rx-buf-len
> > > configuration"
> > >
> > > I don't see the connection between rx-buf-len and the ring size,
> > > unless you're thinking about some netlink-configurable way to
> > > configure the pp->ring size?
> >
> > The latter. We usually have the opposite problem - drivers configure
> > the cache way too large for any practical production needs and waste
> > memory.
> >
> 
> Sounds good, does this sound like roughly what we're looking for here?
> I'm thinking configuring pp->ring size could be simpler than
> rx-buf-len because it's really all used by core, so maybe not
> something we need to bubble all the way down to the driver, so
> something like:
> 
> - We add a new field, netdev_rx_queue[->mp_params?]->pp_ring_size.
> - We add a netlink api to configure the above.
> - When a pp is being created, we check
> netdev_rx_queue[->mp_params]->pp_ring_size, if it's set, then it
> overrides the driver-provided value.
> 
And you would do the last item in page_pool_init() when mp_ops and
pp_ring_size is set?

> Does that make sense?
It does to me. 

I would add that for this case the page_pool limit should not apply at
all anymore. Maybe you thought about this but I didn't see it mentioned.

> I don't immediately see why the driver needs to
> be told the pp_ring_size via the queue API, as it's really needed by
> the pp anyway, no? Or am I missing something?
It doesn't. The only corner case to take care of is when the pool_size
is below what the driver asked for.

Thanks,
Dragos

