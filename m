Return-Path: <netdev+bounces-135229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA199D0A5
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 17:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2992821D1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 15:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D21A0BE7;
	Mon, 14 Oct 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="iLrZnPP1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12599611E;
	Mon, 14 Oct 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918337; cv=fail; b=qVyo6aS2gbhAw6oHdZtMCHTV6yU1zVoy7u3cf/0B5ZPz+kSfJBziuErQHBObZhx6hcr4h/Kyd4us69DBTXBqEAjD8psO3Io9Fr4UGHeJ9DMxW9KuK+HqkSK0edfRC2NxPBGrQX3E0N60wYiUJtmXpggn39DO1JoaAy16JupRszk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918337; c=relaxed/simple;
	bh=RomCONd2twQu6Lyo1T0vRWM2VX1p39SEdyI6yKDZa44=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CKfOzlhMGEt7jYrEACYu5wuCqXSoiK+h+eAN50wD/CehWopvqwGpfP91qtBVdmoRSUgEQvCvQUgGZRDCn4tVojvsgGz8mz+S1DYmjg82oQr/QnBb/V8tKE+j6rGIfNlWf/0UvHOXR0tNBuES6At4PMuaEhBFLe/ULIjxajO16hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=iLrZnPP1; arc=fail smtp.client-ip=40.107.20.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP5n5KhFOyQt/WwrFUWddizuZMi33nPTROSkglcaxTLE1A+oJR4/mOylQRkmMUBo1npKmuqMzsfOAk44uOM9hs/CAfSL99JQa+WKsNs6af8KKxF7YGAsoynoQRryUczJt4m21cL9FSHASDDJsnY7jZ2wLeGhTbw0wt3s0jvFs4AM+stOtEBls4y0XexC8g1YTryGGSQxQWpr9qfr0Zu/KJ0foiwOBOYXQFTtvF2kgtQV5MGaWQUpVjetCKx8+6vU1UNVP9idgbYhnkrRPMZNTfncmCIh/K+6JHT3fJGq58pb0SxZtZZ4YJITskbW8hp/XN++BvTB2Sj/+5mk+zYj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrUZ05OJqMqUpaoNo8xXKz/NnpIILMkBv49aF5wVUG8=;
 b=u5lh/BnKLRF5gWkCdbu9WmpPfUHwSwQZ5KBZ6ZQoeGVVIgOf4sEcIFzPAgwTzWzmknCqk+VrL4LRXtomUe5NqDpTIvz+pI5RyF6Y6LR9pFkgsppYNzLSMfyPh/o2tMXIGkX4IkzpLvW3BejjILyyNJep9bla2ZRemsdJgMqTzYeBGFXJEZ08t4EPKddlP3Qo9WGstBngLIrCC/5KOK/ox2mdhytAt/zl6OD6DdMIJq+mglidJsg5SvITcjEy6mKrFkMO+B2aepo25dlyOO7xhRjI8vpLaxoD8NvJp/jy4JapchZmXCdqkxmuQs/8CMolu4lft0L3qE4MabCZaeAxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrUZ05OJqMqUpaoNo8xXKz/NnpIILMkBv49aF5wVUG8=;
 b=iLrZnPP1gwEnARhkrzooeG9dcBzkJZbokfvrC86WZgA9+evDwTY27TWQBfKBBRNdl/9SgBJqXjIDcwJU4lcHHcYcpZ1Poy2J+b+uvefacQlquP/YtE6VO6wmbs5v+0wTIPX2m/64pzAvADuW81Jwda+Ot5Ea7cPrOjlLqqnSRjt56LQlkdVO/kVmzyIHuGXCtQNJ50ZJ1J1hGnDxHHjzu3/Zt7Wx12oRR2Oo9EMRVgbaQBlTm0VtuBdn3mKOyN8BrKDnxTpxAx5zO1E164c8BRhbEa7eEkxk0nn3bnlZiJWnbvoK5gVJL6Z/MWihnqy7HmTih16TmD9qHPP5VMz+bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB7964.eurprd07.prod.outlook.com (2603:10a6:10:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 15:05:33 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 15:05:33 +0000
Message-ID: <cc3c8919-c56f-4a78-80ec-afe7fb028061@nokia.com>
Date: Mon, 14 Oct 2024 17:05:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/4] ip6mr: Lock RCU before ip6mr_get_table() call
 in ip6mr_compat_ioctl()
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241010090741.1980100-2-stefan.wiehler@nokia.com>
 <20241010090741.1980100-7-stefan.wiehler@nokia.com>
 <20241010094130.GA1098236@kernel.org>
 <aa10d178-3421-4759-bac0-2b187255db6f@nokia.com>
 <20241011101623.GF66815@kernel.org>
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20241011101623.GF66815@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d89b9a5-898f-4db4-162b-08dcec61a683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NMK3FsTzFSUW9iczJ0Z0tEYlhzTHR6NWRoTXhHdVlRa1N2ZlNoNVZZUTF2?=
 =?utf-8?B?VW1Zb2tTNGxwSHNwUkdzOVQvaDNIZjczTThxcThvQ1BkcWd0R2dqMGtJZHZn?=
 =?utf-8?B?dVRtR2h6TlVvbG52OHVuOUIra1RRSloxdUJNRlpsNk4xTEdoWEdESmk3eFpJ?=
 =?utf-8?B?MWV3NnBNTFBpd0VMa3U5bE5Ta1hyOFdhMHpScmRPSkJzSG5MMVhzSk9lRUow?=
 =?utf-8?B?WVpRMTFWRDJNcmx0OStxdW9heThDWVN4YXVhekZmQmlzaGRwcUVySEFGejgy?=
 =?utf-8?B?UXlkckZxUHhlQmVsdWNsSWRmY2N4SkNQTUh1VGRGZFh3Nm5IVjh3YjNTYnph?=
 =?utf-8?B?c3RFd1VleGZINisxRmI2UllRL1lMQjJmS3pFT2paVFVXaFU4aUs1L1NPdHZQ?=
 =?utf-8?B?NWp0WHo2cGJuQVB6QTc4ZXNJYW1VNXk4SWNrUHc4VHB6anIzZ0xFTVZBTFpK?=
 =?utf-8?B?R0lkRFFGdVVDVVdGbEdDckxOaU5YZUpacy91cVR6Y3J0M2FkTm5MWmp0T3Vh?=
 =?utf-8?B?WFo5cnNvMFYxRzJ0dnhrc0lEZ2UwYjRSVnZhb2YzeE04eFc5MHBKVXphLzYw?=
 =?utf-8?B?czV0TlJvZ3RBRm5oVFZnRzB0NUV1WkcxUUhpdVo4clJyZ0hDN0JZa1NCTVVT?=
 =?utf-8?B?OFdPYmpoUDQ4Rk1HQmluOEY1Y1ExREdXNUJtaW1CaGJDK1J4d0pETWdVTmZ4?=
 =?utf-8?B?V0JBK2pvaGtNcFVuaEpEQ3dHdDFmZjJFOFlwYWZ2K05tZGpVNFlKeHhuQVhS?=
 =?utf-8?B?U1hzTitMTnJZeGZQWCtTMEovelpkbkI2eTBKUmpweGs0QWNFYlNVMjNWQUh0?=
 =?utf-8?B?WlZJVUJid3NseGR4SmZ0cFZGbU1vRXA5QzdDMWVpdzNUOGlEaG52bEdlREdz?=
 =?utf-8?B?Uy91d3hvcDFySytsbFpyRlJCM0x0N283aHJpNlhNOWtmZ0oxOVBTSlhOby9s?=
 =?utf-8?B?ZUlrT2RFM3lYT2FBRCtLbjFLazZxNFlQNitCMWRENS9ZNTN0cjdQWkRzZThz?=
 =?utf-8?B?RG92YVM3cVdIZXR5SGdvdWNTVmlVQU5VSy9CNDZReE5IbnFPUmh1NHVpTkNC?=
 =?utf-8?B?T2RVdjhQNmhZVlF1Y0dlUERoaDA3V1NJY3B2UGtvVnMrT3NXZXZkMjdNckw1?=
 =?utf-8?B?Sngyejh2ZlpMQ3VTK3JYVlFQQ0dEOVVSdjBlM2pjWG91b2dCVG15ZHRZYlBO?=
 =?utf-8?B?ZnFPMmFyRlBKR21BOVZxc3J6VmhZTUFUSUl4N0MxVXMrYmV1Y3NURmhDd0ZF?=
 =?utf-8?B?ZEJtRSt6REloNjRFUzNUUDZkcDFEOEhzd1ROV0RsUXJhaUhPTHlEd2tXZjRX?=
 =?utf-8?B?Tk5PUllheldFT2dZV3VwTXZiN2ZFbHhUc2xJUUNJNlBvQllTdzVWVzFvTlVD?=
 =?utf-8?B?Zm9QVnZMclBMVnpqOUJIeUpNMEJCb1hHSWZLcnhFK0pYQTIrOFk1bUl6dGVa?=
 =?utf-8?B?Zjc3K0Zqckxjbm13d1hkdmdCOFc1RjlPVDNFcnRCRXF5cUZVSGM3aHlaNmtR?=
 =?utf-8?B?UXdQajhqaFlPRGlDbkRzWThmTlE2RTg4ZVY5dWcyck4xOS91WDdRS3BHdS91?=
 =?utf-8?B?empYaG1OME9qQTI4ZkxlemFCeVdmL1RSOWdjVTNQK0FacjgycE5uYUtKbDV4?=
 =?utf-8?B?aTBGTmRCWWFQMzN6U1dVclA4SWllNllFN0lBamZIV3JIcm5Pa3dVRHlQcXZX?=
 =?utf-8?B?M3E0YnVaM2lvMUg0aFlNc0w1T1NRb3dUZ2d0UVBBMkxyM2s0Y2h0eGNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3JBenJOMGwxd1d2djVLcVVmYXdvaHROMUJoeisrb1VNWEZoMjVuMVoxWDc5?=
 =?utf-8?B?UVlMY05zaTQwK0JhbFlmN1NNWDlVbzYrMWdycEIwNDBUTVp3S1Azc1NyKzdN?=
 =?utf-8?B?L2NUUHlZdkdnUlk0b2d1RWhVUDRQQVdRbGx5eC9BcWEwOG12U1VxTjhMcWdO?=
 =?utf-8?B?QnIvYlErSmQ4UkxtczFoTFBFaXlPWHRkdkwxN1RnaTFSNTNwdzJNbCtONzVH?=
 =?utf-8?B?VnJpNDJ2RGdCQzJ2Y2JLbG1IaGtPQmtHVXJuQm9pd2VhREtxYXdaM3hyY3gw?=
 =?utf-8?B?Y2RFQTUwcjF1d1l3bEpLTHpBWVVST1NrUldGb2RsNEZPb0RRZVFKYVpYVk5M?=
 =?utf-8?B?UHZ2WHYvT2ZhT1ZnQXlYd3RwSDVWOEF5UTNYMG1vNk9Fa2NLTFpzZTFhay83?=
 =?utf-8?B?S2lUSk9MNTRTV3dpZjNQTW5mMjJOV1dOWVZJZG5UNFZDWENER2JPN3lTSjIz?=
 =?utf-8?B?ZXZhR2wveXVvdWQrcy8vNHZwV1hmUzhnQXc4RVBIeGE4bmEvazFmZEJKTDB6?=
 =?utf-8?B?dDU4V0pvYS9FZng1OURNRHJDOWdUZjdkZ2t2SEhRT3VsYzhzWnhQT1IrMEc4?=
 =?utf-8?B?YnN1cStKRjBOdGRaUjlyZkFnZG00YVJ1V2w2YnJ6RmNBQzh1LzNpdERDSjBW?=
 =?utf-8?B?eUdsQmVJV1Q5eFhjVkl6VnJvbjZkTjFIQ0RQU0hyYjBzaFZzcWdPWUlHeXoy?=
 =?utf-8?B?SnkvMzRZT2tyc1VOWWFrZVhSb0J5STJoVEJ2S3pldmF5U0h1NDdaeDdubkp4?=
 =?utf-8?B?UTBxay9BWk14ekR2bVVpVVBZQnN2UFkwakhYc0U0LzJDTktqV2VCSG91Mmd3?=
 =?utf-8?B?SExUZjRPWERpMHlGQ01SdytyVmVVY3R0Y0ZJMzlhVVplVlRsUGRmSStFN24z?=
 =?utf-8?B?K3BEMG9jbHU1bHJzVXJWRVh1VTlqVlgrMFlrNUhzY0J3L1U0VnFGTnprUjJJ?=
 =?utf-8?B?TVRaRXFrSHpXNStpU1FoelBIa2YwWDlQemtuU3VDd3dWMGZENFhVbUpVOGN3?=
 =?utf-8?B?QmYvTGZHVlZKTTR2Z1lVZkRBdWFBc0VDNFYwZnY1dnpUZlovc3ovYTJ3SVFo?=
 =?utf-8?B?bzZGcHRJODFUMSsrN0pLeUNPQ0NzdmdWZ0l4eEdhNjAzTmx1UjkvVGRveG5i?=
 =?utf-8?B?TlBGT3ZUc0lFUElZUGxXTW9pUlc3RHQ2dW5TOGU2dFZQK2dDRDhlUEhQMDVG?=
 =?utf-8?B?bXVWSUpYVGp0RkdBeFkraW9BcHEvUXBDQ3EySXA1QnM5R1Y0bHRTcHNGejN0?=
 =?utf-8?B?dVA2dGwvc21VVEJBbHhkQ21qRitQY0lzQkZheTFDRWZvcW5wWmcyVjNYSCtn?=
 =?utf-8?B?a1pnamdObFNrelg3TVJydHlBcGpPbmlST1JCN3p3VDZ6NjhvNVoyU2lWSUNU?=
 =?utf-8?B?WmRpeDNGQnpDc21XRWJGamxzc2xzcjFzcFRJT3EzUlM0b09UVUduejlWdVpL?=
 =?utf-8?B?Nkc2L1RpQ0o2ZXV4eFVqVmsyYkdBRTV1R09HbkdmV21MZzlQRkpMNmFvNnIz?=
 =?utf-8?B?YU5YQVMrYksvcE5MWS9zRUxpeDNlRzc3N3cwUzRveDl4MGRqMFJaNW85bDVs?=
 =?utf-8?B?dytoQ1hsQ2dOMlBoRTZ6Syt5M1NyZnlQV0dMYjNLZUkvT2FpWitqV1oyOEhK?=
 =?utf-8?B?N1NUbVlZYVprK1pMalA2VzFIVFJyME5uU3hCTkNXS1RMcjRFS1NrcCtTWWNY?=
 =?utf-8?B?dmt6Smszdk40THFJTWtTeG1CVkFLMG5XRTU4cElNRFpEa3pwcFNCTUJrN0to?=
 =?utf-8?B?VERlSkZ4NSt0UFV4Z1JvZkFCd3VyTUJZSjhzbTFvVFdOVHptcUU4aklYUFp3?=
 =?utf-8?B?U0hCelpoZVk1bjF2RGlkam1aSjlHWmxmM0lwQ0Q5ckcrV0JUeXhBSDYzMHNJ?=
 =?utf-8?B?clV2bXJkTFc0aVJObTBkOGM0NU56U3ZmWU9PRkJQWmV4ekozdXRNaVBoR0NS?=
 =?utf-8?B?TkZvQ0pTWllDbnVNWnBTV1JiMUFieEwrSkp5dG5Sdloyc2tMRXNYWVpQRGhP?=
 =?utf-8?B?UU4xaGVvclJCRDlwT0tIb0czam8xMmNSZ1hqdlJXSExqWStscjhiZnNmNWt5?=
 =?utf-8?B?dzFPTkhyZStJeFlCcEI4OEE5OXFMbk84SnA3VTA3Q3FRV2tZQjFRNEZDV0RG?=
 =?utf-8?B?WG51T3hLVjFlK0RlSnR2TXltVlZNMkFWQWtFSmtUWnBtQmExelBmdUkvS09L?=
 =?utf-8?B?OUdoZ041RjdLdE5lcTZNS09lZVdpZm16NVRwL1RabWZvaE5WRXNTbmI5YzVG?=
 =?utf-8?B?NnZzczFJSVk2aXBuUGc1dExCM0lRPT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d89b9a5-898f-4db4-162b-08dcec61a683
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 15:05:33.0236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgBB68gwkkGk5I0JTAW6hJuI/2la1iuc26f0xhglrSjAGzsk9M7PdYd7WbA9te3CmfE/MnqRD8rNZideU46z2QndjvLkQ9OT3w63QqQPfw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7964

>>>> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
>>>> must be done under RCU or RTNL lock. Copy from user space must be
>>>> performed beforehand as we are not allowed to sleep under RCU lock.
>>>>
>>>> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
>>>> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> 
> ...
> 
>>>> @@ -2004,11 +2020,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>>>>                               return -EFAULT;
>>>>                       return 0;
>>>>               }
>>>> -             rcu_read_unlock();
>>>> -             return -EADDRNOTAVAIL;
>>>> -     default:
>>>> -             return -ENOIOCTLCMD;
>>>> +             err = -EADDRNOTAVAIL;
>>>> +             goto out;
>>>>       }
>>>> +
>>>
>>> I think that this out label should be used consistently once rcu_read_lock
>>> has been taken. With this patch applied there seems to be one case on error
>>> where rcu_read_unlock() before returning, and one case where it isn't
>>> (which looks like it leaks the lock).
>>
>> In the remaining two return paths we need to release the RCU lock before
>> calling copy_to_user(), so unfortunately we cannot use a common out label.
> 
> Ok, sure. But can you check that the code always releases the lock?

Yes, it should release the lock in all cases.

Kind regards,

Stefan

