Return-Path: <netdev+bounces-233800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E60C18B59
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE5041C87283
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853ED3101C0;
	Wed, 29 Oct 2025 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YdX5Dw2d"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7A3101B4
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722533; cv=fail; b=aKvFuFQrlQTzxe2u6QyvKNCIAD4IxSa39xO8tmqAL1mP6YWNNnFzojNZgkOHXEO4SCbs5BcXUp4dpGaupsXGEYwZgfyb6lLyH/DD8Y5/xKRJOdjftNEep5eZkMMKxrgxvsGg3yOqUK6wbR/eTYftESNMLvqVzswcDDVlVmTH4CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722533; c=relaxed/simple;
	bh=IRSAcPZhScTp1qHMxAiBK4/5lC9rp8U+S9KEVRNqiAc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDrd0P4zoMkovksV39wc9pTMNUB+ksR52hgriKFp8AE/NWbnHwxLJj2cR1E9KrI7sOymeklCsZJYfu64vJbCu3b4KSP6qlFsO7QCpSyM4Ejyrq27U+MPIIJNNpZ0Vhu0RwZoU+9glPD7t2+K5TEBXIRFuUUVbqUCpFZAhUdR9nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YdX5Dw2d; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHfTcK2y19eJbs8PIpX/I9XDxKM+hK3QfRWgLD9aB4B9zzBjpfj+vWfdxKzoIvbX6OhYb2h6zxkmTOE5q8Qs7DuF+UORjM2buMD8beBqoKIEIXa4cXCf1Wb2i0WcVMnCTWMJQRv5kcNWTQ2MZ+HpYv53KE/y7zwI2DD1VkmjVjX2WprDnYIj81WnztqGOUpXPcM+RVoDKR03vPkHSDamSXv7Q+Ue45UvzK6Pcz2H9KPdMj57Yboklfeab5+c9aUWVS6eic4uHtHOZKOzBvxExuZ8xsykA73LW8CFcTCKcuz2TyWyS/tN80dgshv/d34mrKt+n/971qiMNrHIVFjjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voB0+sngC0cqxoMGxUDh7aijtTLixAAgWYq+MEgOZMM=;
 b=tGfjMM7jbpHdbgMztLfEebeFqtgNDiChAorZs8loUB2GW17DCqN7dIZod8tykDYvZMhabr1/e1NlXa/ufRH1nQtebNBiwP2QCaF1761d6pP2Asga0O5V/bj7CEHK1FPi1jNhSkFY53EgeQKrdy3kiQ9x5sfQHcCXGRwQ+HWiHj/WnJLf4qBPr/R/o80bxceo3upIZuNCNXrEHXgItIiIls5qvxrc3dqd9CWHjuM73HBtYiKfz8wAe7Z6ms6Jjrqy/8ktaCfTbSeWzVzIEeZwlgHJFb1M/C5XeKjJz3R5ViInYqMdwPInM+7GjQSkG9IA32rl21uQCbkLW0cXko9UmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voB0+sngC0cqxoMGxUDh7aijtTLixAAgWYq+MEgOZMM=;
 b=YdX5Dw2dfN0UQAxk6TfD92x648pZQhsNdqPv6hAI1aaD/yHYrZJw3C/FsgU3M49ehWLVR38jAWQW7QF2nxERDjjBylPeEQv5+fF3Txp2XXupdLWzvab9Sp8aXkxOu1Y3UR5od0BShyaA8j6atBfAxVTTtIjXIS0dxq8sC4HpCzE3noPFPXpJxK2RRJBROhlMJpLXl2QTReh1gB0t3jZUU8mXEijqriBecZt8ZGEKEIG+AoAQiWieZZKTzEVfEJgP1wFGL6LVoHGs9FFY6OLtA17XwLDig/Krf4d3Qj0JkXYhCThGuiOC1GwTY954PElfeBJUi3A9pbvnul2xbQkHfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 07:22:07 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9253.018; Wed, 29 Oct 2025
 07:22:07 +0000
Message-ID: <d34542b5-6c45-4d73-86db-655b32e00eb1@nvidia.com>
Date: Wed, 29 Oct 2025 09:22:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] net/mlx5: query_mcia_reg fail logging at debug
 severity
To: Matthew W Carlis <mattc@purestorage.com>
Cc: adailey@purestorage.com, ashishk@purestorage.com, mbloch@nvidia.com,
 msaggi@purestorage.com, netdev@vger.kernel.org, saeedm@nvidia.com,
 tariqt@nvidia.com
References: <40a43641-adfa-4fbe-902b-a6c436f3ccd6@nvidia.com>
 <20251028214839.5015-1-mattc@purestorage.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251028214839.5015-1-mattc@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2071f094-1aab-48d7-2e06-08de16bbddb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWN5WWtZZnZqaHZ2QTFyWDVDVmVwdkkrdndSblF0YXo0ZWR5dC96MCt0RnlZ?=
 =?utf-8?B?eS9tWkx6U25GZUFQUWRMdSs1dS9YQVl1TFhTTDBkTGhKTFpEcWFGbkJ1ZjhO?=
 =?utf-8?B?cUJRVWh0dmRzM0FhMlZFd1ZEbzNrNVBlSzUvaEc3UjVHSm1mUjRVTVpWc21C?=
 =?utf-8?B?TlJoeGU3K2xvZlE0dlNsVnFhNkIyb00vUkNXRnp0WFFDRmM0N2V3VFMyanZG?=
 =?utf-8?B?TjJVUHNXeXNhVnp6VlZYVDIyci9NUHMzMStyN1dpdlZTczh3d0U1T0sxZzdj?=
 =?utf-8?B?SkdPQkxwNE40bGEva2RlOW0wbmRQYUw3ZG14VURwa1JQMWVVeXF3S21tM01J?=
 =?utf-8?B?N3ZpOXFtL1lBaVA2eDFwRTBRWW9LamVUekxzNGlhUFZwdCtkQTJVaW5KcHBD?=
 =?utf-8?B?OXdMbmlzOC9wM2JaQk5iTjQ3NjYxNUtzV1J5bHdVZkM1QnBQVnZLUzZOOWg5?=
 =?utf-8?B?MGdpN1FCL0VYTkMwTU9vdU1SZk5MZU1NdmM1ZXNmdG5yWlNtNkdXK0dtRmtI?=
 =?utf-8?B?ZDVqdTU0SEM4bzFSTE5xa3ZSZFZ4dEVWVGtNNTREVmNXbGNiRnNDVzRuTnRs?=
 =?utf-8?B?TUJqMlJoNTZKZTJoZ1pwMTZqTkZPVHlQL3MvMlZNSmc5YnAybFFObVJFRjhT?=
 =?utf-8?B?VnhlUGFQSHFpVDZ2dHZUN2FGaTRLbzVuVm1nK3QzN0UxYTRQdDl3eUY1blRV?=
 =?utf-8?B?Snp2eWp6VWN6d2doNUk1a3k1ZWRKVUJVWnY2UDhEbFVGZG5wVTk3b05lUGhD?=
 =?utf-8?B?a3FOZjVBVWZ4NHRiWDkwUzZRZ3J2ajU1ZmFrUER6dVMycUFuM3dxcGRvT0RY?=
 =?utf-8?B?QW84cUUxQUxMRlEvS3duQ0N5UlRiQTNDVkRuSUxaWGNDTjh2T0lTVnRmZldR?=
 =?utf-8?B?RndVOVdPQ2Qxay8xc1NoZlhUVmxTSkoyY0QzTFVIZDIrcTZrY2RWY01wQkgv?=
 =?utf-8?B?WEgvNytSUmV6MWd5NTNlb25BMmxzZjY4eUNRTERxQmpMaG5ZQVBveDRMbElC?=
 =?utf-8?B?ek9pdzNMZU9Md01aQU5WZDRxK2Q5eFJmUVZqU0I3MEhTZ0s5TUZpbXVON3Ry?=
 =?utf-8?B?WHNJQXEzMHhOb2l5RkpDL3owRWhkTFhTNGo4SDJveFFwanYzZ0lvTVlHNkVt?=
 =?utf-8?B?UXhYUFJhU3BqNXl2VDM0Ym43NUNEVFpraHJJcC9VSUhaYWNiZzRHdTU3T2pl?=
 =?utf-8?B?RWs0WERvMGoyQjd4Z1p5anBzbE5ZQTBXK25xUjMrWXZCM3NnbG9JZHcvRUpu?=
 =?utf-8?B?ZjBoeUtIdVRkOGRDR0F5RFAxa1NrUlFEejdYNE5YMzhOUm9EVEprbXMyUWcy?=
 =?utf-8?B?Q1hCWlRpck95Y0wyOStXMWxUeVl2cm5QQmZqMlJHTTNyZERmNjlkQ1J1UG9H?=
 =?utf-8?B?WWVIcUt6Ryt6TFBqb0kzaDZSTXE4cnlwb0JnaWc4bzhQUm8yRzRiZ29mR014?=
 =?utf-8?B?Vnc2NnVxUEo0cU1IbmdOZXlhMERrd29zbnM1QXBXSnkwWjFuYmRUams2MFVN?=
 =?utf-8?B?U0YwcHg0YTl4Tzd0UHo2VzJsQ2NQQ3NDQWRrbVF4bHhjdExtd2dNWGM4UFVI?=
 =?utf-8?B?aTVYa1ZZbGdqcmQ3S0RrS3hLZVc5MjBjOXY4cnpLVGZ2QjV4VVlkR3dYWEVN?=
 =?utf-8?B?NU1ROXN1SytZUFh5K05yRlR1a1U5TnZmdit1T3BkN1pLUjhNcmVEdkhTVWJV?=
 =?utf-8?B?VXFzaE1PSi80NjFuMmgwZVVpdThjYzd1cmd6UzRzWW9ETERBaGgyN2JHRXE2?=
 =?utf-8?B?Q0Z5SERlYVNVcHRDakdLRUZxcWpER1lXOUlHSFlQb29HVDI1TDJWckllRHpS?=
 =?utf-8?B?eWJxeTZGY3JrZ2hialpoWXdFWlhZeW1Ld1c3VlJKdjBSTTg2RzhyM1lTSWxY?=
 =?utf-8?B?aTcrTWZyU3FhY3o2eE81c2RabE1tS3FFM2VYSVFTT1JtZTNLdGo1MWVxKzdh?=
 =?utf-8?Q?C7IAspSIbp4DXK0vOp6a6ZroJiExNQbP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmtYUStrcHh5ZlVoYlR6Zll2SWNueXphOGRhNmxObkhKSFRHMWtsWkhQZVE4?=
 =?utf-8?B?SWdVa00ydmtZL2p1TzVFTGR5anA3enV4Z3BFNlhIaUg2RG10YkNNT09ObmtF?=
 =?utf-8?B?ekNmdXBod0VzZnJ0TEdzRHIxMnFyU3VCcGFUS2dwL0t5NTJLVUdPSmU5MVdB?=
 =?utf-8?B?L1VwM01FV3lBMHpNZm1Ha3JTZGxldkNpT052UFhueTNFZ1hJdVNnRVg4TzRF?=
 =?utf-8?B?MGlqSW51K2I3KzYvQ1ltZUIyVXBac0VXWndLS1I3M1ZJR295OHFRamdISEVx?=
 =?utf-8?B?WWc1MndRQkFCTWUza2VWVkJmaEl5anczOWJHaEZ5ZDh6TVdSRXk0R0krS1o1?=
 =?utf-8?B?Smh3TTZ2bFY2Uy9JTGI0MHNWS0VQUlQ4RktxcHRXWUFQTDZSYXRHckl6TTBU?=
 =?utf-8?B?T0I5L05nQlNhbGlSMVdtYllLT1pkMUtjSVc1WkE5REtPcVkzVHBQUXRkeTVH?=
 =?utf-8?B?b2pmbXNlYllmc0xnL3RZdWJFdGNaZFZ4cGlTdFNJZjZvWE9yQ2NwVGtXWEor?=
 =?utf-8?B?K0h2MTE2UG1rWDBLZlI4eGE3aThIcWkvdXdjMno2MCtnUUl6dWNKZjA5T3BY?=
 =?utf-8?B?MVdzN1J4YkFzcmJTRGNucUhPdnVkbDFIM1ZRUUdMN09DS3duWjgyeXpUaUpq?=
 =?utf-8?B?dHNBUWJFaG1zTGdEQUtkcFhoVlRpWUlUOWpkOEV1a0g2MUJXdDNDQXJ2ZG03?=
 =?utf-8?B?OFNjcUc3cTBNdkpHSG1DM05FUERXeWVmVS95dHNGR2tZUnd1RW53REZjVk5S?=
 =?utf-8?B?My9WMTYxcDREVGIxazQwT3JRSEFIWmc0TWdGa2RMand2U09kZkdaKy9xOWxq?=
 =?utf-8?B?Unl0N3VNRTBtWVI1RSs2YTZmQk41UjRYUUVUbTBGUlpiRDNzZmN3T3BEVCth?=
 =?utf-8?B?Vjhpa0FRWkpvQ0xBd0ZUZ2tjVjl5bGsya012TUFnRnJpS0ZabE5seUUrVFlO?=
 =?utf-8?B?R2R1Ylk2TmRUU2xwU1V5MkVmU2N4RXNMYXl3VlF4SFRQUmFQemswTm5WT25u?=
 =?utf-8?B?b1h2VVg3MFZEdmQ5bjNFczdBVnBxRjJRR1NLaGhITHM1Rk41Q09nRzlKYSsr?=
 =?utf-8?B?UmJHUUhrZDJXd2Naak04blhqOTdvY0Q0bG0xY2orVXF3bVhhdURmOFVETDdZ?=
 =?utf-8?B?eWVOZ2lOOGZ0Q2Q2NjNocGZQY25HSW5qWDUvSjFuNGxyelIvb1IvTnNITWw1?=
 =?utf-8?B?SVpWRThlTFoyS1JyZmFSaTdWRFFrUWhYanY5cm4vTS9ld2VhZ1pDTVo0Q0Uw?=
 =?utf-8?B?QXhrY2U0eVJxRlZJWE9vSGx5bVhwbjRQeVFjTGtPRHBtWjFXK0hHTkJGTXNR?=
 =?utf-8?B?Rk9HSm1rd1pQWnlHNzhlMDM0U1c4SzJWWXJvd2krbG1aSjZzWVFyU1VOTHBn?=
 =?utf-8?B?OWo4T1lCUDliYjYwc0ZxVmhpN0VIczVNMmxwU0ZXZVdEQlVIYXpIUEZrSnl2?=
 =?utf-8?B?ejkrQ1VHcUNyK2VFUTNYNzdURkxaSVZNbFNuaXFhTVlpRndmcTN1M1BoT09B?=
 =?utf-8?B?aG8yMS9wVDZFKzUwb0pBYVBTTDUwSDlKamJ4MmpXRThvandrSXlRbXZNZkpC?=
 =?utf-8?B?TTdsWFh5aFcySDRpMGRWcTVKSE1OK3lpSEFzTUlxY2YwRjVHYS8zWU4wbnBE?=
 =?utf-8?B?VVE5a0RDVDVaVXFWZ3NYSnhxYk9OYmdyZDUwUlJhdXFseGdmT3cxZGR0ZGtT?=
 =?utf-8?B?bWJEemhhUDdHZFpIRDRWeHljQ2FlcVJoSUNka2lBbjBOcklYNGMwZngxU3Qv?=
 =?utf-8?B?dHB1a3Qzdk5XMXVodHJIZUdoc256NWZmQ0VTcUFvbTJMcVRTTitiQkdtNFgw?=
 =?utf-8?B?RThFNXBGWXU4RS9qTTBBb0lYakNsMk1vanVIejJEb3A4bXhYRjJEdzZwU0sz?=
 =?utf-8?B?aXNTRHkvZWYwWUlhQzd6VnJIb2o3U1l4WUdxTnN0VWhsMC9FcGRyYnY2WVF4?=
 =?utf-8?B?NDYzOE8vemFvZGxlSjhGcWRLWTlqSWRRTHZ0dXc3U0s0NWkvNzMvaUZQSnEr?=
 =?utf-8?B?TXFMTkZ6TTVQd1pNTURTZnMzRm5Ca1pDYkNOdGVSaG16NlFjeWRZb0VTd3lm?=
 =?utf-8?B?MGVvelVYZFJ0bmhHUlBCbmhJSWgzOWgyUXdJOUlGaGVyWGV5SnQ2WTYybDg0?=
 =?utf-8?Q?dVJo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2071f094-1aab-48d7-2e06-08de16bbddb9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:22:07.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGzAgwcZonkkub33M87KCpv7Al789GsylHgsuX5xxLuI3YNJA7jwiNifweIk1Qj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On 28/10/2025 23:48, Matthew W Carlis wrote:
> Tue, 28 Oct 2025 22:27:39, Gal Pressman wrote:
>> And if he knows, I would expect him to not run the command again?
> 
> Sometimes a user is a script or an inventory automation tool. 
> 
>> It is an error, as evident by the fact that you only changed the log
>> level, not the error return value.
> 
> I don't know of any strict convention in terms of when error return codes
> should have associated log messages. I wonder if there is something more targeted
> that could be done. For example, if there is a "physical presence" mechanism
> & a module is not present simply skip the logging.

Maybe the problem is that because we returned zero on error the script
would wrongly continue to try the queries?

Does it stop when an error is detected?

