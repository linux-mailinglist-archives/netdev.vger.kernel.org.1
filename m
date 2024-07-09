Return-Path: <netdev+bounces-110146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF8692B1C7
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38D5C28125C
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7915E13E40D;
	Tue,  9 Jul 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J/QrEpSJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147A1D556
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512439; cv=fail; b=Y6eawYWDQ/jE+Jf70lhp0wHTfaL7aA9HbIz1P+bMPeky5SzbacOHlaUDmz6iXfgOEl56LuxDChj+poceKQY08WxawjhbQF51tanf2IwAjRXbbusGjsN/dyhebN+1mSqRiaqzLqofTExRmUvGGRX/Ar7jIJJsOGwKU6wXdKU1YpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512439; c=relaxed/simple;
	bh=0TVivrlknfgjg353PKW/1hdqabm9qa0b9S+s8OJNIvI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rtUOCIW1zrqSsL/jDx0DE+CXJ2MUYEnD5ax/dfvjPFyguM2HNCQoDof1sCSQmcxPistgaCOenlJi5T5UXhYhk4H4uSkmJZd5eazbha22PrAOBGb2PWYDz8JTOuaMWQasWX0tSeH02EMxkcty6shIgtFemcgH/fAmgTwympQzzp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J/QrEpSJ; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwcCE5Fems4EP72fmOISQXDrb+BNOrH354+LsPkU30Of7W8brDEgI73Y/7HutR4Nqb1BozCSjCQEPex6xkGzqfBGTs19RfCBwXqgyNb8Qfu/RhyIbwCcLgbpDVC3VtZuEqw2v+myqMsJZrC+fG6EY9vLIBeVeM5KJp/nt//HS2V0aIGj6y3xcMs5I883++pW6XaMdE9z6/afcyuZ+Cml4aWgRKOdMjzGxHeku2vmt18kJ83BcZv/w4KwvCgHeYkLmQ0qAS7UpF9FSp2nnXrrBrbFoPvoG1FdWeKMY9bNCC8wvMH5/Y7MWhznYCTT27QsoTWb3wLnimZE4HyyC/REbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTIBAtI0eU+THM/i/t6e2QHrsCt8JQrRKwy3Ieh7KsU=;
 b=HSF7hjo1Su+QS5pnvWGyVQ4p3fK2OfB3Hs3gBT8vdK/WRth6A4T/d9hr9uQtOJZRCrrVnNDH0VP1GO7nsfH2jP+8MnQM9KdLZgEV5/uZsS2zzO+kFbPQ1QAteaIDzlpHBxTv+hBM5Oh29Abd2SzF/rw3d9eErWndEkckVXa+/LoYHYxi4vJ9BY22RLNJ05B/x6nQdBxj1XmjJaZPjRdA+8mmOvgweToVtVSdweN6Wi4ZYADc5eG5Ok+WpXvZ5jfDRu/oc8+nuliNyfaVpFzh2EYtIgEL9lJxff01nADcH0rSmT1FQahp0mx+JjoQOPPaj7PZdKS4r5xkbiGR2RgArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTIBAtI0eU+THM/i/t6e2QHrsCt8JQrRKwy3Ieh7KsU=;
 b=J/QrEpSJqZev0HDtcLIQfhQEfIZfaWKTG9+0rnk0iZbTbmzs06PAQb+3RJjSC+vOhJhG5vYInqC+m9B5jIAldP54tUNYr6rYzMArm4phBMSxu//2qmFELFleKbXN7cp79wus3YVfYl6ocVGGIfrhdm4e9t0WRI5uRdKQlD1GSgmn7BcDlO2fQVwybqVAoTJgx8P1L1/qnRbh1vpn4lzqhMCjAnZI9erUzGM+ZiNWudfwZibSaHALeLmjgyAVL4FR0jd63roAjeT+Q3EMu27T5Febnnggg64Lpv0WHVmbDe3jxSRbCXJI3UV6WpLwVO9YVAKMUtH62rDRDPWQEs33TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.35; Tue, 9 Jul 2024 08:07:09 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::10e2:bf63:7796:ba08]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::10e2:bf63:7796:ba08%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:07:08 +0000
Message-ID: <b1a5e06c-82fb-4b72-82af-36030cc78c81@nvidia.com>
Date: Tue, 9 Jul 2024 11:07:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethtool: fix compat with old RSS context
 API
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, ecree.xilinx@gmail.com,
 ahmed.zaki@intel.com
References: <20240702164157.4018425-1-kuba@kernel.org>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240702164157.4018425-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000452A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::34f) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ce10d6-f4ae-4c61-bd76-08dc9fee2110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHBEcDVXWFh2WmUxaTMySHYyTlo2ZnplUmFXWlAwRXBkWXQwdFA3Mm1xeXFh?=
 =?utf-8?B?bHBqU3FGelVWOHY2ak9Vekk2TkgzSlF0U09LQUpnd3c4NDU3a0JjZGVKMlA0?=
 =?utf-8?B?QTM2bndnWGd4TDdjYW5pYVNzWmcyMzBFNWVKTTluZUpHQk5qUy9jMWZ6c0lH?=
 =?utf-8?B?NE4rRGJBMmQxMkwyWEd0WjVwUlJhZm4xdnU1WHhtQ1ZjeWUrdlBKQWVid2xr?=
 =?utf-8?B?QXg0VDZqdTY2RlRVMXY0eldaeUl1Q0JBZWZSZ3BONUpRd0psbGFpakxRRnNY?=
 =?utf-8?B?dE9INTlNYjdJSGpQK25Mb0ttUDZITlI4cm16TU8xWXZ5WTRuRm50ZWc4WFFP?=
 =?utf-8?B?ZXQwRVFqQ1RvM3pZYm9kdDYwTkJQckdWdk1KakFJejFRT3hXdWl4N2wzR2pz?=
 =?utf-8?B?ZldlS0pWNStITWU0ZXFzNEp6VGQ3WnU0c1Exa2x3VStLV1A2WGRveVBjQ3JW?=
 =?utf-8?B?RENyeGUzdjFmYkJlWGo3RmRqZVV4Znp2Y1JwUDIrSFZ1aWd1N0xSMmtpWExH?=
 =?utf-8?B?TjJ3TE5xK1dHd1RXV2l1ZE1ld25wQ1dMVnRXZWkvRTh5TndyYXFFd2JjRVBI?=
 =?utf-8?B?MnVFRlhMKzNkNXYzSUc3TjJtMjAybm1Rb2RoMkwxTkZlUmxIV2tnNndOQTJO?=
 =?utf-8?B?UFRwVThxMGN4Um0rM1V2dFlZR3JUdWZiOStJa2FTY0ZCeUtpbUlNSTNDWC9I?=
 =?utf-8?B?NzJHR09kUjY0V2NVVitvWkg0RE42U1FmSXJCUzI3dlN4ZElXaDd6bEE2OWQw?=
 =?utf-8?B?djlxZzdkQlRIZlAvMGg5TDgxMDE4SldNNzRCSlVldEp3YWh5STMyWEJGTVdk?=
 =?utf-8?B?dzViSzZWUnNpdllkaCtLRkhpTmF0anJFQkVwL09DdytOK0U5bitaWDhBa25l?=
 =?utf-8?B?eU5sSXFXd2w2WUhQTUpOWjdCcHJGODZrYTZOclo2aW1sT0FDT2wvY09pbitp?=
 =?utf-8?B?T1pGK1B0QmhqM0ozTDMxOGZweDl4VndvdkNjMXdDQlMwUEtnY0RHUEY2ZEoy?=
 =?utf-8?B?YlUwV0RiQUVXanJabktnM1piRGRVR1RZOTVaaExPeFl6UTd2VkhIMkpsWVkx?=
 =?utf-8?B?YzlhMXNpL3FEU05PZDlpYmJ6NTZKK0tiSk93U2JibFZmV2hzRVVMOHJ4Wk9V?=
 =?utf-8?B?dEtWUXJqaUgveUM3Z29Ra3ZnVkw3U0k1MHVPbHZ1RHJjQm9Jbms3R3lpaUdZ?=
 =?utf-8?B?a2d3UUVsMWlXd0d5bWt2SldLbm1oMVIydUx2dHFXejJtU2d3cWZFcUpMSTdJ?=
 =?utf-8?B?NDF0UXNjd0l2ZlFLdUNjWUVVQS9uVWl5c0FOa1orUnFkb1hFZGd5c2lJUnlR?=
 =?utf-8?B?MUN3Q1QvNWwwTDRNUW83MHlsWElVWmZkYjRFY3FGVENrWVh0aWZ0Ulk2Y1Rn?=
 =?utf-8?B?RjB3OEZSRnh0MWE1eFNZdllLbVBBblM4cTE4MHloSU9hY3gwQmJBdzIzandP?=
 =?utf-8?B?K0tlNGhRcTBERXNhVlowdHp1TUU2RkJGMTRESUJXNVg0VzZIUnFRci9aVWtF?=
 =?utf-8?B?VFVjT3Jtd3Nuay9hQ2NFanRwQkhpdVpjZ1ZUdGpXWGNlZkpXV0IzOTZodGFx?=
 =?utf-8?B?cnkxa3AzZkhQOEZ5TTcrcXhOdXRKWFpTYVlQYzJqMEJqeHVxdFk2MWI2ZExD?=
 =?utf-8?B?bUJtZTBFWndINjU2dnJFcExBcEx5TG10MWRMbEdSUzhvY2g1YXVHYW9lRm55?=
 =?utf-8?B?UVhUU1RHSmVHSHQzSU5qckl2Ym43RTdtRThwaXRwV1JYcDJsSFFGMDdnODJt?=
 =?utf-8?B?ZG9Id2FTeXVaR1ZlRXVtSXpjWGZhL2ovbjIweXp6MFlUaDBNNFFaQ2Z5TkRW?=
 =?utf-8?B?ZzZJa2ptU1JwdkU0K05tdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTlPQjdadFZkQ2h1ckxDaHhrQ2VxandlRzV4UmgxSXM3QkJBRjZmaGFybmpS?=
 =?utf-8?B?dE5pOXFHRzcySXgyWjNQVFJOb3dFWHRrZzc4eGUzNU5uMkhFWnVYLzdNTW5O?=
 =?utf-8?B?ZzZzdWhvSFhhM3ovNXJ5dG01M2hPUDBJVTRMd3Q2L21mT0RXQk1uUmltTmYz?=
 =?utf-8?B?R0ZpTzhqQUpyM2FJNHR3ZWxZRm9HQTg1eStjbWJCYnFicVpBZG1GV1dISFEr?=
 =?utf-8?B?eXpSelIyNWZrL1ZQcVF2dHB4VDV2czJtTzhiSWJDVnBQZWpqaDQrTUFoOGo3?=
 =?utf-8?B?Zlh3MEJJckZ0T0VYN3VkMFZCZzJFU1UwNW5HQXpiY3pudU9lVVJrdjRBRjZp?=
 =?utf-8?B?L25DUC9JNFdPWWtHT3ZhRFo2eFk4TE1rbWZhYTEwMWJCKzBZazlUOW5JSDNn?=
 =?utf-8?B?b3dQQnVPdXlJVTBoY3R1OEJsVXpvcDBFaHBoQXVubXZpd2lIRFh6UC96SHg2?=
 =?utf-8?B?SVkxcCtlYTc3bUFEWG13eHdDMXZqMXg0MGV1Z3YyUUJsRkV2VXk2WTJWbTE2?=
 =?utf-8?B?d0RUdFRMcUpVL1lMZFdNbjhqa3daT21BNlhaUU03UDdpbnNrZWZMOGNNdnhR?=
 =?utf-8?B?bDJzbm1NUE1rY2liMjZYa21DWER0VldiYnVPWjhrS0ROSHBrbGlabGlGZmI5?=
 =?utf-8?B?ems4bWFhRmJqZzg1WHJKdHk5MmJpSElEU2tkcUNnN2NkTExtVmZ6MHhoK1lo?=
 =?utf-8?B?ZWNmTmdJRklSYThvanN2M3lESUFaSkxGRDJoclA4VTdaN3NyWUkrR2Q3WDhp?=
 =?utf-8?B?Q2x1WXczWDZNaFZFVTNBbDR2M2VuSDdVOFVIMkU1eE9TQ2M0UENaUHU2WmJJ?=
 =?utf-8?B?YWVXUXNUdkF1aGFYN2NjVjREUkdrZWFZd3NlZ0RVNHQ1bVcwVXdPNTQvbkxF?=
 =?utf-8?B?Wk1xWFlDYVBzYlFqS2t1dGhhSFRVK2VLaE5ncnpYVXVsY2ZHQnh1MnBQVjFD?=
 =?utf-8?B?bGorY3FvaUo2OTJyQXB4QUxMb1J3amFnVHFYN3ZyM25yajIyNUxDaWlrUnIy?=
 =?utf-8?B?WjNyL1RrUFlWWmNQcEZYUzByVDhmM1E0eFhDWEc5SElacTFJSUdoUnhHcTlD?=
 =?utf-8?B?RkNTbXFtczdVZ2MxZVpEd2NNeCt6bzZsUnRnVUdYc29xRmIzQnFibk9vcUJT?=
 =?utf-8?B?TzJjTWVCSnhrRGd1NVJqUXduRzc2eWl3cXNmSkFmd1dERElRVzRlcjVHSWor?=
 =?utf-8?B?Z3V0dStFRVpRNE5ZWWNycVpvRkhDS1NIU3pPeTMraU1xakNkUit0bTZFTGlq?=
 =?utf-8?B?cEYxNHAyU3UybFVwcS9UdVBlZWpzdUxtS3NxbFpMWjR0RGtsNTllVHZnNW8x?=
 =?utf-8?B?QUl0dWg1bUZRSytYc0FlNjFVV0RLMmcvWU81OHU2VnY4RnlwYk9lZksvWFZx?=
 =?utf-8?B?VFFBc2UvUXJYb0pDck1nSTBBc1RuNjhPeVIza1hSc2ZLdStZUEpaRTcxSmJ5?=
 =?utf-8?B?S05jbG1POENBekIwczBrRW1LY2k5dlFLSGZoVUtna2VFL3ZJL2FtRmdJWklH?=
 =?utf-8?B?UFdiSzZqenoydGt0ZlI4LzhQbEJ3S24rK1BWVmM5MjFxLzVidDNzQTlOaWY2?=
 =?utf-8?B?WHljRkd3aWEyNmRtVzdSNFdlZUl2QnkvblFBQTd6Q2NwVDFpb1VZUWxZT3BN?=
 =?utf-8?B?aDF3YmNlTjQvY0FWNFpHODhnYnVzVXNCTEU2M3h4QXpHQXFGLzFxc2hFbWg1?=
 =?utf-8?B?Y1BwVjhicFJSdjBWMlpLQjB2MjZDT2xEQjg1K3pmc29qRjAwYTFiQzZVSVJv?=
 =?utf-8?B?ZHhGZjdDL3laVG10cEFuS0h1TkY0TGI0MDNuSTdGL0ZmVWR5b2pFOHZtdjQv?=
 =?utf-8?B?OVpLNTBVVGRleWs2bm41S2VlVVZYbUtLbWl2L0RxcDZhYWRPTW0xZzlWWFhj?=
 =?utf-8?B?R1EyZzY2dFZ5S2t5SXk1RE1mSXNoR1JQUUtBT21Tcmg0RkpwOWxHQmI4VGhR?=
 =?utf-8?B?ZjRQME5vZzlBOGEycHZYVjhycUhheUl4VVhONDA4Rm44aHFnUmJ5UWJ2Z2tJ?=
 =?utf-8?B?Z2RGQTlIR3JBak5nTHdwKzZrUUc1Qjd0bWxuY29EZHRYdEJvK1VoeDF4UHVY?=
 =?utf-8?B?OWd5WXluaitJVWFNN2Q1Z0hxOGZsQTlIdUplTmV4dDVudmxsZGRNN3YyUVVp?=
 =?utf-8?Q?XdBE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ce10d6-f4ae-4c61-bd76-08dc9fee2110
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 08:07:08.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzNnTRw/fAe/kt/Knu07OqbkldHmiSpxAdRvlMVzShleTlXwYyXyRei6VxwrEwYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204

On 02/07/2024 19:41, Jakub Kicinski wrote:
> Device driver gets access to rxfh_dev, while rxfh is just a local
> copy of user space params. We need to check what RSS context ID
> driver assigned in rxfh_dev, not rxfh.
> 
> Using rxfh leads to trying to store all contexts at index 0xffffffff.
>>From the user perspective it leads to "driver chose duplicate ID"
> warnings when second context is added and inability to access any
> contexts even tho they were successfully created - xa_load() for
> the actual context ID will return NULL, and syscall will return -ENOENT.
> 
> Looks like a rebasing mistake, since rxfh_dev was added relatively
> recently by fb6e30a72539 ("net: ethtool: pass a pointer to parameters
> to get/set_rxfh ethtool ops").
> 
> Fixes: eac9122f0c41 ("net: ethtool: record custom RSS contexts in the XArray")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

FWIW, better late than never:
Tested-by: Gal Pressman <gal@nvidia.com>

