Return-Path: <netdev+bounces-200949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B2AE7755
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74857A21F1
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 06:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22071F09A1;
	Wed, 25 Jun 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GE6npXXQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63A130E58
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833854; cv=fail; b=pURoF5ia4NmnP6fYhJngVf9dnYSGsPOv0oEg2aQnQ/9WokRP2cKLWKqbTcxi3UD5gc1VryH+JxRCYgic/q6tN8tZH4Ne9Qf0CikOd2xXnP8KsW5cSezf9mjeczlh5LxKKi1+ttmbEm9RHKakqZPq5hxrnO7oi8Tgg/PMan89QR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833854; c=relaxed/simple;
	bh=XuBV7FQtHZyQwukfwdKxo9lbtPlqpnql38W+bDfEkZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SWPYGba1w0DcrHtdRX1gXKmwkYqa+vdWWRhRCGvgTz//r+x+3rhKLSYWEIko6PRBf2O4a6l3VOTNplheg7sMBm7LJVjVcaNxKe08N924mBNUDDlCr3nRGzwgLlnCCEEK4M+q0TRcQl2TE7ntOzy1IIrbm4ccsKD8n+/DeliEdmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GE6npXXQ; arc=fail smtp.client-ip=40.107.212.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJlp2qObwBOxyEqkqdMUwMUBlMFLaAcU4zdAnNmTPQdNTQ/m9JC8JRzAdn8Dw317pWiHeeZsJ/vNhs5y47xNor47xPwi2VeSBSO8GI88iR6E308SQPzpFZ6jvii5AwoWLpneX/Wp4NTCKHpsqxTH6A7Oi8tdNfxt2IHvUjSxXfBV2g2pGCetiV6PYA1iql168kh1jZIXTxsjcferPW3NfrHLxd3Vebew/FSnLMwSwRaefY8rRIn7LeZa7dqJwLVOPjHqjJYIK6jXjCx+ioU/NcvNLSQOZJ8edDUpcuUzERStkppCmvPKA8vMScI9tOL4OgN7xLInZopPgs0BsiTsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuBV7FQtHZyQwukfwdKxo9lbtPlqpnql38W+bDfEkZY=;
 b=GBu36F/0WSvrD34RXbn71OGhQldjdcNHsxp0exORaKqyTCRw5zwH6KrwqC2r9GUOpRlKwVKT45fJWs4OzzQ+2nNjzSnCLtkuoFs1VIcItXOR8RkI/zXf3sSg4rM+zylP/OBa8xSgSzul0KOViytzmJU/YII8tWFqhDj2xIFtAtGW6YJENbHelBw0+Q1F+DNKsPx9W/BvEl21o6Tlu0u87CJk1WY7qh2SVdDOHbvtm/Xme8yHH+OClYv6IN91EeELUpNwAaRMmFrDieshJDYH1iezxAB5+8p2sEzXP/W3Za8p031ozLw+mkiwIjQs2F40n0mZNVj00L8QPebIveJvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XuBV7FQtHZyQwukfwdKxo9lbtPlqpnql38W+bDfEkZY=;
 b=GE6npXXQxs8/o0jmrVlCHA+kD3kgJgZNvOZ69u3+NF+4B2tIqggbfRxZNz2P438NmYdpx7rjbd4iL+qNW1h/E/xrVTqJY3tejSC4pG8AvEKVkTdluooYL1u2PFKAYwkFIZW+xBCrMsLXlITSJgawq2UoQjMbgKdEbJAkbNCaSzsvUerE20wD/D/+t/iusyHjM5NQe1HGjgd8jBA9/fvDXv0mvjeqM9XEDCfgJiMQvEIWfiO7K+FrENMBFuDf3TxtAsUkxNrg8YOfaqLf6TetrWpdXJK09I0td6DIqBTNhAoizEvcRkiddg+AJWPaesAwpwH1uK3prNezrQNA7HS/Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 06:44:09 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 06:44:09 +0000
Message-ID: <db9f1187-a994-49e8-a05a-58322a317102@nvidia.com>
Date: Wed, 25 Jun 2025 09:44:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: ethtool: add dedicated RXFH driver
 callbacks
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, ecree.xilinx@gmail.com
References: <20250611145949.2674086-1-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250611145949.2674086-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0016.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::18) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c57f6c5-fe23-4851-df81-08ddb3b3afec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTRXVUhaeG1FYWVPajQzbHNFUmpmL1kydFNPWEQyaUtncnNReWZtc3RzSDh1?=
 =?utf-8?B?Z3RXU1RMdklXVTZXa1pPbGgyRDZ1M3l5UU1CeGJqZndqM1lGMlVIaWxoLzhP?=
 =?utf-8?B?UlBjd3drWitnOGd5Nk94bXRtanlIMjhxdVROM2pGeGJyTDg5bHVNdzNQZGVa?=
 =?utf-8?B?VzBQREhIUGdKeU5KWXRNSnFJdnNMOWJNdmZFZEpRRzlzU01lTWlPZFp4cDQw?=
 =?utf-8?B?WVRUTlpUTlczY2tPUUxBeXZCSVdTSVZiVHQycDhEVzdMUXNSOEluZVFHb29B?=
 =?utf-8?B?MUVNUWJJTjlFb1NmbitHUHZOMVdMVHdsYUdLQzZ3Zlk5aXpabldpOGdMZDB1?=
 =?utf-8?B?K0NEbmZUSWZndHhDZGYwaXoxdUN2TGlQZzlmNTVlYmdQczhNMXdpaDE5bXVU?=
 =?utf-8?B?Nzhsb3hvRnlQNDdBc245b21NY2NNMks2SG1jODVYekJNZjI1NUFkbHljWHl2?=
 =?utf-8?B?WFdEeFA4eHFKUUtkbk91YkcxWURzMWVCekRuOWVSQWxnblBHZURmU1piUjh2?=
 =?utf-8?B?ZU04SHJObU1YVG9oRHgzN2hQTXNZRGFNSVE0WTJOQ25MbS9NTEtEU2Q1RGgx?=
 =?utf-8?B?VUQvc01uVlMzc3ZORGthYS8zWms3M25NR1lkRlo1RmhlQVVWRzAweFdDeEZz?=
 =?utf-8?B?dzRYK3lxSGRQY2h1M2Q4Q0xHbnFabzNFYTlEdE1KUUtIU3VvUDZsU01sbXBH?=
 =?utf-8?B?azlsOGhUOTgzelNBbTgxZTFsWjQvOTE0SHdlQ2l3a1kyYXdwVzRsNjR0VGY2?=
 =?utf-8?B?V2Zzc3JlTEZDWmhESmJ0M2Y0L2tXellVZE9ZUktLSFNJN0drZ1c3aHNNVW5F?=
 =?utf-8?B?QTRoREJrc3RZQjF1UWp1V2NueCsycUtWaldOZmo4NlpwOXlHaS8rK211R1M0?=
 =?utf-8?B?RjhJSGdnZURRNUtIR3hYR056ZnhqYTA5c3huTlhQNnB3Y0h1N0diZlRyL0w0?=
 =?utf-8?B?ai95a1FRZHE0QU9YUE5jOXVTR1hoOFIzS3grcHA1Nm1LVXJqUnpnZ21SV2Ew?=
 =?utf-8?B?TjdpMnJvdDJQVlBTbGRqVjlJTnZKYjJXa1lTR2JEdTlmeUJSS1BzeXJpNkNE?=
 =?utf-8?B?SVNiYUlzYVA3U2pFWE8zWHA2THBBSWg1YjFHRUVFK1Z2S3MrbldoWnhwRmpD?=
 =?utf-8?B?ZG9ldDVPWUgrS2xNdnJtckNBV1hzM3hZSmNQSTVsLy81WVEya0taeVpCMS9p?=
 =?utf-8?B?N25ucXpZWVROZkxEWXRJMFFSRmZDeXlHclo4cm1XTHIyMHFRTUdUTkI1cUpm?=
 =?utf-8?B?ZTZBVGVJbWFtVW9vdW5mZlBsYzRyZkl4R1BERXBWRkVNam1PVkZvRWZkYUYx?=
 =?utf-8?B?RWlmZHFvb09wRXplVGlYTVZHMi9lOGV0UitOeVg3VzhtS2J2a3craVhFeS9K?=
 =?utf-8?B?Y0lFQ3VoZFJnVTN4MEhVd3dubG93Z1FjQ3hvLzZFeXZmcnFlSmZLWVFqWlZj?=
 =?utf-8?B?RDE1TXV6OU0rUHFXeXNkMFJOWXRGTHpVamV2cnJ6aVF2SldXeFh2ZzFVYUh1?=
 =?utf-8?B?QTlIbXlBaU1sMnZVc0kwYzdYNVkrZ2JqMlFkYXlEMWxIR0YrdVVMOXZaY0VN?=
 =?utf-8?B?TXdidFlPYklYd3BhU2JKZDBWdmMrL0pLZWFiWEs0OVphRlpuSG9ORmV4a1Jh?=
 =?utf-8?B?bnB1NlhoL043NEZSRWJGYWZ4ckJEVUtVajVvWWR1dFlhUVd6TFA2azM5WVo1?=
 =?utf-8?B?K1cyOHh5VFNmZEYyMW8vc2NmMlJXNTNTckh2OUJ6OTZVY0h4Zy9LM3RUU1U1?=
 =?utf-8?B?bmpPNVBjaVJSMDdEZHhneGdKRFVqVXA0SXpZM1RMT2greWxHWW9GbUQ3Tmo2?=
 =?utf-8?B?aTZEUXNDN2VENmttaTV3aiszSE42Y09uWEw1UGhROVJ2Q2RDZThrRGk2Wloy?=
 =?utf-8?B?UkhLZjNwMnRMMVUzV3p5NGh4d1dtcW1FMGpJNld0T0pwYllNakY2dlFRYTVM?=
 =?utf-8?Q?Ke05OuRWvQ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3lkaXNvb2dSdGdLbGwzZlNPelI4cTA3LzFJdkV5VGMxQVdQMVRpUnMrOWlF?=
 =?utf-8?B?ZGVINGdUaGpTMXFDZDRoR3ltbDRMWkNibjd2eW55NU5jRVdqb3dQTkMxMjBN?=
 =?utf-8?B?Qnh0emVIWEtvc1VnS2h4OFh4a2hrNGduV2pXMys0YVJGZDJJLytGM3ArR2Fq?=
 =?utf-8?B?c3FRL3BiVEVTODFHNnhRNnd0d1Y1RDYxWndFVWl4dWFwODBib0hIYnZMb1lq?=
 =?utf-8?B?dmtVOFFEb3ZrL2Y2bC95cjgzeEExdnBGNEVSUkhROUZ6N09zUkZUK2kyaHBR?=
 =?utf-8?B?RTBwZ3JGb2xPQk1SeVlOTlZmUWRLdFZvcGIwVnFRS01ZY2hCQzZJTTVQd1Ri?=
 =?utf-8?B?WU95UlMrREk5a1FzYS9RbDZlOSt6a1czMys4WUt6Q1o2TklGamJyMXg5QWlh?=
 =?utf-8?B?LzhhRjhSOTdTUDVGSXRlNTBIMUQreFQ3Yk5MalluTW11Z1p0ZWlDQzBVT2pR?=
 =?utf-8?B?eXVqTGpaak0yRzE0M01aUFlUZFhHQSs0T0ZiRC9FM2dZREcycWQ4M3RDaDJy?=
 =?utf-8?B?dUFKSm1KdG9PNHpLamwzQjVyTkJ3N3Bmb2xKRlNVWFAydzRuRG1DSlVDK3NX?=
 =?utf-8?B?L0t4ckR3RDhOUnhuN2xRRGV3UUxpTC83aHVIdDFhbzg4T0pGVW0zNGVnamJK?=
 =?utf-8?B?S0ppMmtTTmtDTHR3QkF3KzVyUittUVpQb0xyOHR5UGUzdnYxdTZLbWY3Y2Za?=
 =?utf-8?B?SGNUS2Z4MGJLZ2JkT2lleTdZUUdGY2E4WHpGY3h6NVAxdVU5aytmclBNTmdz?=
 =?utf-8?B?QUlzNzlNM3I4TzJtNExmWFltZXpPWkhvWjE5QnF4QTh3VkJYWWZVSnpucmo0?=
 =?utf-8?B?aVdYYmNYMEk4QnJ1eTlJNjA3ZnI5Mjhhb1VoZ1NmYU13ZlVLdWEwcWVOOVBG?=
 =?utf-8?B?d0t3REpPcW5pcXVKbEg5bGJQRjAwMVVQZDRCdmR4WlVGVjdyNXhqZnpLQTN5?=
 =?utf-8?B?L2l6Qis4VHBjMlIzQUVYVmRHUWh6b09MeXdkZDk3TW1LSjVxR2ZYdlpHckh4?=
 =?utf-8?B?eFpCL3U3QjFjNWkvYTR3YlRvYWpJRDJQQjdiNnJZQ2pVbmhTbnpIeWpXamIw?=
 =?utf-8?B?bFZxRUhMNlE2c09uTkRKTEljcjVrU3llcTdLYzVCV3A2MWllT0R1RVh0cWRU?=
 =?utf-8?B?Si8rRnlyS3IwSHZ5M1NhOW9XWmZYTXJiSkl2blpiV2RvWG1TSDYwaUVRUGo1?=
 =?utf-8?B?ZUkrTG5laEJwRmM2VHpnSUVvKy84VWtWc3VqT1FqMkIzTi9HcnkzWUN4SURZ?=
 =?utf-8?B?MGJqNHlhQTMyMXAyZ0V1eTJ3MTlFMEkrNTZzUFpTTHlnVG53SFdvMW1DT3Nr?=
 =?utf-8?B?bDgyU0hDU3A5Nm1TbVNSMy9tU3kvS0o0dnhIVjhBYTVSczBxSXEvanZrV3Bh?=
 =?utf-8?B?TGVwVDgxb1F1b0E5UnhRVkpEODBCMm5lbVh5M2RHKzZHSGJmcTV0OFFtNDVk?=
 =?utf-8?B?TmtoQkhhdjRwYnpneWd5ejVvSStCL2h6MVRuUVV1b3lLbXByejk4TWM0R21w?=
 =?utf-8?B?bzNCc0R2UTdJREZRQU1uZzdIcFZiU1J6WjZTTkFEeUE1aE0yVzVyUDF4Mi8y?=
 =?utf-8?B?TXU0R2w3QWgzdWlWeVprSG9VNFpKelBKOFJoZGovMmkyaTc2VHNScG5PYS9Z?=
 =?utf-8?B?NFJJWUl1dzhGcytOL1dMaDE4ZGxqeExWc0M2Q1JEK1haN2JTWmFMMVdrZUpV?=
 =?utf-8?B?WlI5VXZiWlF5clgzaGhMakxkOGJNQ0Y5TG1DVXh3R3F6L0hNS3ZyY0ZCMWh1?=
 =?utf-8?B?UDUyUlZSNlVUOU1GTnYvMDNEQXRGYU1IYnFrQm9lNEJqZmxiR0EwRDNNNlhK?=
 =?utf-8?B?Z1d6ZGZINHU3eURnUlRLcmdHZHBOdWwrM2ttVHAvUGZ2SlR3YVJwNzRjOW9j?=
 =?utf-8?B?MHRMVzhjSVloWVVOVTRETThtOU9aNEJpWlBXVHE2UDNaWlEzMVJYc0czU2Zj?=
 =?utf-8?B?dTFXL001c1kwdVpwa1p2d3NieUlxZlBCWEpiUVZpQlBiMGwyTlh3emE2UG1W?=
 =?utf-8?B?QWRnb0ZZSk9KdkZGZFZnVHlyd1hBRm9FUkRKcmJDSm96bksvbjZCSzl4UUJw?=
 =?utf-8?B?OVlWLzl4VWQvS3N5MGJ0N1VDM1pWV3h6ZU44TEwrS0RmN0w5L3F5dUluLzY0?=
 =?utf-8?Q?JcCw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c57f6c5-fe23-4851-df81-08ddb3b3afec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 06:44:09.1626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKpaeRk6AwxSEu+w9enznECVEg/wWkzHAs/6Prv4FoWvZUWWialypj1z7PFSCFZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679

Hi Jakub,

On 11/06/2025 17:59, Jakub Kicinski wrote:
> The future of n-tuple filters is uncertain within netlink.

What does that mean exactly?

