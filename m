Return-Path: <netdev+bounces-202591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183BEAEE51B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C617A95A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7029009A;
	Mon, 30 Jun 2025 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAVeGo1U"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE82737FA
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751302700; cv=fail; b=s4vucpPtkyifbX7NoQZva6LcXs7E6uS902nJs4QjdNnRmrob1yGbbxu/bLrDNQxyCbnbZcRtAa2X8M4mX26LKuq6J1xwBa5t0/UDjHypBVEbIGgYVdwPiKJA0DmnGdhfFUi+/3vcLC8yh0PXwvc1o1sMuZUY6vpcABE3P5Q8UHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751302700; c=relaxed/simple;
	bh=lO/a/5P8CiI6+FWUxfD/tBbo4Dfo5B6lISGmDrB0arY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ro3kV8gcqNnmIr+zU5znRusE1bRomMmZZnuv8/nSPT981zbaQyJKWfXVbLUpysw91dLEb2wyJanVB1pOrZmMla/MUx1gJ/i+yf37EaepiVZHAUX9Sp0L3C9Emto850m4+E93GqtaavWqMNDFfytGEyX/7O1jbe0wNu8DUrAiSIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HAVeGo1U; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISV2akHsBHhHlZDzC5Tyk2eaLrXa+Rmi2GCyyda1QP3d7xxCBECTTqEiAT3t4Ck0+wQ9SFAIZMixeStaKGRsPH8aJsjEjfFooIK2SmYzzaTadMNKMSE0/OLIBMUjZqASPnSSk/01CUMduF4OlCqmgogEo0hc9YSHNDvFLdFt85HDzo/RnMt6dQJV9iPjxIpgZVvVXStgi+g7OzgTKukLaHK0LaIZB3flS1Zuy28k9G2prye8eCvU3VYX9hDnSfhPdsh98gtdKOu1a/Eh5lnIwaeMApLr594kTSK7RUkZMn2bfdT4n19L6sUU6RlyIzYkvjshu3CYjg/zX5pzO8TwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlsZBwqm3miDv6mxIQ3JfVgzLCddVFn0mPp6QM0URcM=;
 b=QndXK3SpCvL5kWxkXULhH8sMCx7COR/7pKEOmtVdBEMvb0QNSsThAh4sskUn9hnzL3RtpZ/4Y/1CoGlgHWV5iViMI/3wVCQyOPkwVeC8rd8En6SAX1E/X8XTPuQn5nfDNiDvcKAu8OjPNM/k6ELMZu185DbhkcQupLnUsYtlrrqM5VmEu4Hc87vjwTvkZCPkadBOiLPye9WMZzxXZGZN/CfuhXCCpqwJ42gFUoDFn19bpRq+EHPEDh+YIkPMKz7Jk1pAKMBmYCgTbhWiuZwSuBSWNDHEUSkFFzxr7DyXrs/P9nXKhgg5gOUU4u/9RF3nxMv4t0wGCgurZD9ek+CxeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlsZBwqm3miDv6mxIQ3JfVgzLCddVFn0mPp6QM0URcM=;
 b=HAVeGo1UYQGExGc2wCOuykSxwtTYhnuyDzAe7IZaUsYvG042lWmwgf2Vzy71YL+5JtdvGrTkIbQp29qudHiKRuumj01pcWthJm7ZnrhfLBjBw9BDDmM4qVCwB+SOdZFhlapbdYlaUwSfY5b1Fdsg1PO81pi7gpvJPO3XqCNNm2wXrHcxGbw6cAoL42n60m4zLKfDe4KjcwFvZQcka9k5V0TM3LYCI8kkplpJEkl2W6+I0kdv3X8QpEaTvlaa9DjpaobN9aWjaxDZRA1bqluyAMR3osLtyoL0fof89GKTbTRmrf+a8KNDwPTEc5YB+5lTA2CN9cxP7LzkxRYlU+hobA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 16:58:14 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8880.030; Mon, 30 Jun 2025
 16:58:14 +0000
Message-ID: <0493c69f-b07b-4888-a8e4-fb7f5d5c12fb@nvidia.com>
Date: Mon, 30 Jun 2025 19:58:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] eth: mlx5: migrate to the *_rxfh_context ops
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, andrew@lunn.ch,
 przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
 leon@kernel.org, ecree.xilinx@gmail.com
References: <20250630160953.1093267-1-kuba@kernel.org>
 <20250630160953.1093267-4-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250630160953.1093267-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d6f3947-8231-42a7-c34e-08ddb7f74d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUNRSDdXalltb2hscEFOZWxMcTkrRlBmbmdtQisreE5IYzdiZWtSck9JYzJs?=
 =?utf-8?B?blZsQys0RUlPc0VtT0srcGNsVllrVVA0WVhKT1l5M3d1OVY1SEtZYWloUlc2?=
 =?utf-8?B?cmNYa01zZ05xRU5XaEFzRVl2VUoxQzZraDM4WHpIOTBSUFVZdFdtS01TSGgx?=
 =?utf-8?B?amR2dVo3TXMzcXJkMlVTSldSUC9abGhMbTJVa25sNS9UdncvTlNVVE9WSmZM?=
 =?utf-8?B?VVNRRGNVczgrNUZGZC9HWTBqU2F1Ujd5MEJrbVJnN3Y5ZTI1TGRzRXl2RXU2?=
 =?utf-8?B?UURFTnVJb0l3L1paTXQyRXNJSTdBUmNLNkE5YzFMcnNxRG95TkxGY1hlTXg0?=
 =?utf-8?B?VmhaSVRjYzZSQ0VMbmpTR0VVc0JCQ2phQkhXNkhEVmJTS3hpLzNxZXZKalJm?=
 =?utf-8?B?QmFaSnBVRXZnQjd3OXN1VVZiUEEwTGoxVXdSUVBCQlEvbU5yQ0d3WE5qUWFw?=
 =?utf-8?B?YzA2NDN2VjVua1VuaDJPY0RYTGU2U1dFKzB4eEMycGdhemMyVTc2REZBMnlk?=
 =?utf-8?B?R0dkM3RDZGQxb3BSS0lsOEdjdmE5Znk5bzk0SU01TFJnQSsrRHRuS1AxS2Yz?=
 =?utf-8?B?NDZuQ3pkNFdUenpQc2g1bWFIUlRhN3VyQlpUYXZrWXBOSnk3K3RCTEVPRFl1?=
 =?utf-8?B?RGMyS05SWWllY2xJaG5OczJWa3oveGRKS0oxVXJRazhucVJxMHZOQkZyVDh1?=
 =?utf-8?B?REs2MVFkOU1YdDVsalh1R1FiU2I0VVZQa2gwSTRqdDc2RDRrS3RZRER3YXky?=
 =?utf-8?B?WkRuRDluandIWElheEN1WTJaa3cyQW5KQ1h1N21DaFU0NXRFVmpYTE91N2dK?=
 =?utf-8?B?ell5T2h5WmhrcHlBcy84N1JIT0llc1UzSjFpa0RBR1JJY001LzllVmc2UTQ5?=
 =?utf-8?B?ZHlPS2J3UExyRlpndzhHRnZURENuQTBjaFZUcXhpaDR4Rm81K00xd3gvbGc0?=
 =?utf-8?B?bUQ1bmdPRG9HWTkwL2hVUDdSMDUwMGEwYUF5Tk50R2dFNUY5SjRxbklPZTZN?=
 =?utf-8?B?aFBkVzRkczZTZW5sdEpWdHFBYTdIVE15MGpYbzZnL2F2azBOYVh0U1BBU2dW?=
 =?utf-8?B?ZVp1V2FxLzZjOEI5SmJqbGtveUNIbW96ck5jelkrZzlVYnpNUFQ0Y2hwODEz?=
 =?utf-8?B?Mmg1T2JETGVqU1dDUDMzeHZKbDBaOEF4enJpNTVIbmVCWWlnSnFxNEptbG5I?=
 =?utf-8?B?THJUVjRsWDJUcVRIenRydXZhellzN3hHcndNSFVPaEJMcittMFlIR284eFov?=
 =?utf-8?B?MU5DaWR3UFFkYWtRemNQWGM0ajdQOTRaNDN4TUdjVnNUTTlvbWxDU2M4Yms0?=
 =?utf-8?B?eDA4RVovRXRoc2x6VW5McmZlT2lkb09BWFJaUkU2a0xVa0dFRTZLSWpsbTdB?=
 =?utf-8?B?dHdTS2lRdHdiVytnbFNLeUxUa3hsR3IrRmlyZHBwa3pMQlcyQWNMakxqVnE4?=
 =?utf-8?B?MFpEWXBTa25DUi9nblhneWNpUlN6bXhsWlhla1I0R2Z5dVJmZWZNZEgwcmFH?=
 =?utf-8?B?WWMvWENHRnZla3FxRWRBemFITUNUaFRwblBlRk1KdDQwNkhLc1pKZjBrRFk4?=
 =?utf-8?B?b081MkZlSml2YS80V3dGOGFUaHZDU3dhRmdVQlNhNkl1VEc0eDhnajcwV3dn?=
 =?utf-8?B?UlNLckFkb2lzRSsyaEFWRFp2NEJBZnRrQU9BUjNRZVV4b1lteXQxajZDMEo0?=
 =?utf-8?B?dHFsVnBwcVpGT2pCcUVRb3pkajlKdW1vemQ3OGM2Qlp3WTREb3NwRlg5VjRr?=
 =?utf-8?B?UzBaK0Q0b2FQQ0x6NGdSNWMvKy9uQW1JSWtEU3dvMTJFYVg1UUhLQSsvR3NG?=
 =?utf-8?B?U0V6YmpSaENNNzg4cGl1YnNadlNSS1I0RFN1dHpzajh4UnJCSzNuOEZHSkQz?=
 =?utf-8?B?V2ZuSzZzNkQ2akw5Qk05RFpBcWd5RkppM1A1MlJxTUR5Unc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTB6eGFaZ2JaNVJ4RDUxQ3MzZHh2RXZMOXhZb0EycXhRK3BqTVdaMDQ4anJT?=
 =?utf-8?B?R0JLRGhTTDlhQ3lHS20rTFpSamNlQVdPVHpjWGdnbzY0bG8zNnVxOUNjdTZL?=
 =?utf-8?B?cjRMeUxkajJZYWdWYnZMc0lqcjZHSlA2UmNuL0laVWVjWlJwdGUzT25ic3Ji?=
 =?utf-8?B?WjlIN2IrQkQ3ajllMWJMMzB5OFlhVGNBUWtpTkZ3RklHb3c3cnN0bW8zcWdF?=
 =?utf-8?B?OExJYSszZEYwMXNqdmFKOFJTc1lrWG5tcjVVbXA1WDlrOUhBNVFkdDFoYWhD?=
 =?utf-8?B?VmZtVm56LzcrQWxGWG96N0dTUHlxUGRKUVVCT3VmKzlvL1NYWk5tdXNCYSsz?=
 =?utf-8?B?ZlJsTlg5aHIrNjkzMW9uYjh4aDlXV2YxQUpZR3oraFErMDZzaDMrZlc5SzlO?=
 =?utf-8?B?dy9aT1VhUitldFRlMnVMVlRhYXRhM3hFbXJTNFpnSTlDNHN5YUtjemx5SWw0?=
 =?utf-8?B?ZllHTnFOWkNPRXZkUEppcnZ1bmlKaTJDb2h0dkxWNVN6ZHVxSG1EZUdYbTFL?=
 =?utf-8?B?Y1hyQmt0L1VBazB4THRaYlE2MTBBRk90aHZZcDJOb01qRUhqRXkxelVyZGRG?=
 =?utf-8?B?dEUxeDZxYitGSllFZTRpc1RhcFVhblhxT2h2RUgzSlJadTRqclYxTEx0R01s?=
 =?utf-8?B?cXg0eWRvQnpMa2Nwd3pJVEtzcjRMYkJhVGdnd3BaUlJCSnloYUxLb3cweDdw?=
 =?utf-8?B?M2ZnQk54VUNQTTA4elFEZURHSGJtYlFNUVM4SlIxSEpxRVE2VVc1bDVwUklJ?=
 =?utf-8?B?TTc0c2ZOOHR2Z1EwNUQ5R3pJeE0yMmxzVUl2cVB0MU9TTW9NMXY1UWdqNy91?=
 =?utf-8?B?OFVzOU5QTytLQjFNMnZXRTBtSGxMYVZnc0tLWCtIYlNscU94ZTBsVUMrZmhy?=
 =?utf-8?B?TGRrRy9RV2RjYzFyUVkyb1RTdkpPcHlMK0lsd2g1QzZjUTZWbndqZmozczdU?=
 =?utf-8?B?NTBaaUhyYVdQb0tVR1dvRjk4ako4OUFSekZJdWlDWUR2QkczaGpQenZaQk9B?=
 =?utf-8?B?TFY5amdnUjRQQnNKMzFoREVGTUYrRFVLR0hYRkJ4L3pla1JLSEd1SEh3YkFw?=
 =?utf-8?B?QnpaTVJxcy9DMTN6d05PRmJiWlhjY3ZGaG52dDZ4Zm1xVzRUNU16Qkk0MkZu?=
 =?utf-8?B?ODlzSS81REFLNmR6VTJvQVlGM0hLMTRpUUgrU2ZpM0J1UkFNdUlaYVcwZDBs?=
 =?utf-8?B?WkFSMml0QVo3YXJQdWREN25lYkNMU1FPQWFnVDcvb0VFRnZMcy9OQmUwNG12?=
 =?utf-8?B?YTJUV0JwdDBYYlloekthdkJYYVo1b29jMFBsMVlCeDlJQ0dyNUYrbEdBblpt?=
 =?utf-8?B?Vkl0dDdxelBRL2N0VEtsa0Nqei9yWWZyaWZlQmZHdlkreDAvRHpXWlFTUzVV?=
 =?utf-8?B?cWo2U3JEWVUzQ3ZqUzdKemVHQVByUDU0dEVRSHRGWmNHRUYvM0lNa2F6UUpW?=
 =?utf-8?B?Y3Q0Mk9SQS9JbTM0a1ByTjhUV2pKUG5IVk9SRWVGY3VxWFJCbzZTdVllbHp2?=
 =?utf-8?B?RGJGYnU4Y1h3N0pzaDc3cVMweHVTV0l1NGpaTzhZZlBacjVGMVdseW9WeWp0?=
 =?utf-8?B?TktwRjdhUHdOREJLRnp3ekpsZG9jUkczQ1Y2MGRBb091Uk9LNDBESnRhQTdk?=
 =?utf-8?B?aWM1VlVUcHN5Z3I4Q0J2cGtiTUJUMFVoWEJXa20rU2VJR1RkQ2RBcjRkclhT?=
 =?utf-8?B?YWlOL0svbGZUbUpGTUE0NlBnMG9XZjRqbllBS2dncy9CRzV3QkpEUHlFS1VK?=
 =?utf-8?B?dDRtc2YvUHZ5V2I3YTMvcXlveTBibTBKWWF6dERkVjBycWJ3aVJkenlkK1d0?=
 =?utf-8?B?dzJvNGQ5RHNibGcyYzE1SWRvdmF0Y28rVDNDdmZ6UDA0RUgrWGhtaTRNcEpJ?=
 =?utf-8?B?QmRic21vMlZqdm9SN2Q3NVgxSDJyZjRsNyttL2wwWlJPUVhna2hmZE9GeFB2?=
 =?utf-8?B?MEtEZGZFZDVqN1NDZm4yRjNzS2V3dS84dXpLL0d5NUVWMmdOTFR3M2FobFFR?=
 =?utf-8?B?Q2FodDlkNDJ2WTV1bktXb25yc1llRXc5aVdXZDArK3YvYUUrYnIyZWYxbkYv?=
 =?utf-8?B?c2pxTGZ6WXdTR0xCQ0NvYXlzbXUyUEg1RTZhYy96Skh4eFhNVGIwdVdEcWQy?=
 =?utf-8?Q?DkXoKc0yPxywbWMTNhxOxxzjb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6f3947-8231-42a7-c34e-08ddb7f74d75
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:58:14.4172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZKyX6lVksbiNNfYXGOpzvyv52tcJF2ysW3RMiqkgXiRnbaeb5uQYb/lCgjNLdOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

On 30/06/2025 19:09, Jakub Kicinski wrote:
> Convert mlx5 to dedicated RXFH ops. This is a fairly shallow
> conversion, TBH, most of the driver code stays as is, but we
> let the core allocate the context ID for the driver.
> 
> Tested with drivers/net/hw/rss_ctx.py on MCX6.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

FWIW, I started doing this a while ago and then got distracted by
implementing the netlink counterpart of set rxfh (code is slowly going
through internal review), so a welcome change, thanks!

Also, the ethtool ioctl set_rxfh() function was a nightmare, so its
simplification in this series is a great change.

