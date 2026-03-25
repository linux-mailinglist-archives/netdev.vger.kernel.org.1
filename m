Return-Path: <netdev+bounces-271403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJU5K8R+w2m6rAQAu9opvQ
	(envelope-from <netdev+bounces-271403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:20:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 119733201E0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 07:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEC85302D940
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 06:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40A311C2F;
	Wed, 25 Mar 2026 06:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kG1iM2Pf"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012064.outbound.protection.outlook.com [52.101.53.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C15B21A;
	Wed, 25 Mar 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774419499; cv=fail; b=dh3n6/ln9lY7Cn7YQklmJ8hbq39EiCAoZ3Fbf63SV2ynmzJ3FyBxybi0B3U28GhTX+uvv7IM5XeivYKme4OXIfPvqvhU5XXPO4PzWy116VFplGk3QCYtZcuHi8WDg5FljvqTapGfWwCwJmDz82Spi2sHzVi+wk+dWI/2yTXofkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774419499; c=relaxed/simple;
	bh=kLqOp88ldBQnLw4/fbmbxcZNXko14qsNDF5+tSCVa14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a32/+CJbhZ9Vi+bQG4uw2d1CyrpgZ/tf5quFRCU852QkJ8itOc9fQL3joNKqYGEJfYeRE5lFUXSEAK2d88M4A6/fz9SiGEg6Q0Ch27MotQgmfPBiz0Pi0bO3M9ayoU72939NJuN6BIK9B1kw97hoA2O3WIphQ+MJejOh4Ci2Ibk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kG1iM2Pf; arc=fail smtp.client-ip=52.101.53.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NiqRPyxNdM4ckO9x3IbhcJgBtDPVYx1ej6FE2NoVwxklO462/Qj38ytJypF+cFZKOa8PP+co/ooc4B4MCPbx89X+7Qg2aKIyiQICBVXmoFYJC2M6KSrxfVGz9xRGI4SJQUskrcOmOmtGT8w29naU+TatcYeTeZzwSzVUmzai8lJnyR8vLPlNyeqMHbaQoYoxCEJM2otJeD3bYUeVj7ubVwl/6PYerMuyF1cOAoyGqVU9UjqvYKE5hnDOAjPZ0MdSDc8SPGN+DC7FgwAlvIBoB0TQF16P44vYVtG2vzVKf8Qy0gtPrdA67dEyrLdtEzSQ517mTjTnfmh05JtVkBY1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyMdTw8w4/TXucX7wDCtsG/LV1FjpBrFXJ1SgL5Zkzc=;
 b=UDKXhUOGEfaoZnVF/xVEb6pSWnLjyASfi2AG0L3gCvA7N6AgSRxf1d1NW15Fyp0cGAJnN2guk13UuTZS85wQVzfwUe7sXeGJMgEvc/UBTv4F/jhVZZGmwkzqjbI1k/3LHEcqV91lHyTZTt+Cl/aFCoOvI/AITTb+xb2YFDCKhH79/2fi7o98nThycObaZD3LqzEifXbN0gy9b2S/2afVm9QHLe36nYO2oT2BD3wF60CfVaMzxMcLu6ddn4QMMaAv60bVlo7qq1rvkhT7JExFHgYIMI4H4PnMTvQEqIi0nVNHIWnY1DiOgzTIM/VW1Txz8vXTnwkbVRa5IeUNYEhHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyMdTw8w4/TXucX7wDCtsG/LV1FjpBrFXJ1SgL5Zkzc=;
 b=kG1iM2Pf/8gKHGdsVWBHXZ5spAP0LHi13M3VcbI1rTMCOoE59qsp0cpS+YRBGg0hZfOsmHdi9xbLWHtPKqgOgCMezKoH11iWBIk0cZyyOLaFaIhCAUFgohhlUhftVZNr4dkxqukhI8jV9osezBUpTwgSATGDO9nJUOywywQlGFtUdhfRfWHil9Hsm9e4T6MiKQelzBsxr6Tl8xBxZQM2A2f10+E9x16qT7DMedx3afvV9N0eaScGEtZjyrbaLstEJ8LXgMyi9Ohw/7Sjk31f1agTyRATqhFyHrP2/varNXmOHBBOMgLjq9B45wb1LlbSCgL5eZ9gpLib4dspyB239Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 06:18:12 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 06:18:12 +0000
Message-ID: <5e0a6a5a-dded-449d-8789-e2a5e0a169e8@nvidia.com>
Date: Wed, 25 Mar 2026 06:18:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] dt-bindings: net: Fix Tegra234 MGBE PTP clock
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-tegra@vger.kernel.org
References: <20260324121631.771628-1-jonathanh@nvidia.com>
 <20260324121631.771628-3-jonathanh@nvidia.com>
 <177439307874.2078673.11304788250514370726.robh@kernel.org>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <177439307874.2078673.11304788250514370726.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 8420fe7e-d219-47d0-465a-08de8a364aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	irqqqPFK5n/dd+OQfPKUuYEMV6HaxpJMon6xiWCAggrxaebOqaissoKdOUMfHGqTB8DXw/pUUu5edYJ6c5q4aFepHuhzlJhpxCJ49LX3lb9DcWB57vt1Hs7/5uNhSMdUUZzxcVqxlPDJ/yh8NBN0THGntzXWnc04QZDrIvx4Um8gEVQmswxtTipR4cmi5zGG9EfvTVXcVaghWhDWHVjrNY0P2O6fM/VjkBFCszjnVReNjImAkOrNNwUNzRk2QJLTggMmbt42sLas4jVHpKpDu4+NfbDg2XEv3nc+IZHz9I1NDsyjhIgjDIz8Ci9DfwL1NV9kgESyMnk20M8DNHvDqgqkGcY2T/kgJxanvTWSJYFgrXr6qV043lMHWROVvbUmgx6y01YdBtF+hxOctLGL1FG13sFsL7/rAcCkAVJdpj12SmNh1jIO4W4UfLHeG0DRenMLfMyQ4IGUWlQzF/Jmh7WPjP/npDRfimFQeuxGtadJdYMi09TxmM0N47cEg5pgqVA1O95BJNaLh912U5sKyHxL0/efByR5hEUUPbpIrj9P7JnQ6NPO3s/mUSQ5AzrbiHXQkSD8rhjyWxRs91fTlO89VQcrDp/UgDmsLmT8sbb7FdccsjKSSm7yrbhhlbyYgqTT1Spk5dhjt2A2nqsqtq7HAWG8d1tDTZc3SVbI5Yme6D3C4PdWBVxnX39NlusuryQZgxaskEkdYB9uesWprU4sIv8DsStrItA9bL6EDmo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGxMdHNvWnNBNEVHMWF6STEvVzRrUjQwbEFra1dTQUFQVGhqblZoUlQ4YzE2?=
 =?utf-8?B?OFRQZkN6cmdKMFppbGFJbnY3NDBNN2dYRm4vU0JPUnFNSnNWRjhIUldIeWJ2?=
 =?utf-8?B?Q2h4TllCWEpuSVNJUy9zVGFoS3VabXZ2QVZIUU5KRlFWOXJHTnhlS1hTV2s1?=
 =?utf-8?B?a0dzcEVYY05FcS9CT3dSc0V3VUlrLzdkQ1dTMXByem1QbmdaMy9uRTVZR3NG?=
 =?utf-8?B?ZEMwcVl6ZEFveDJVa1RoMUZNMmpDNFlzRVM1R0VTN3psZjVLODFFcjNyZHdy?=
 =?utf-8?B?UGozR0Z1bWtZWDNCQVRjVUplbWxYZGJ5RmxHSTVrR0xtYUlGUFFVN2hHMkkv?=
 =?utf-8?B?aGE4dFh3ZG5xekQ4dldXSDI2aE45bzl6cmdNNzNGUWRiRXA3TjZtMnVZMnYv?=
 =?utf-8?B?dzRkREVvV3JkNGljeUxFWUt1SXdybGZEVjJPR1lzckMwMHVYelVpVFdWRUcx?=
 =?utf-8?B?RFRWVy9rVWtEMytleGdnbXdXZHA5a3ZnUER0ZGpMckV4OWt5V2xSVCthUkhV?=
 =?utf-8?B?RE9SZm8zNDB4RmZGRzlucjg0aVlWSGJOUjJlVnhxc0VBcFd2NW9WR05MTE9Q?=
 =?utf-8?B?TFV1aU83bEl1ZFBmdEptVGMxN0JINUNHblRvTU5jZTA0QUR1bTYzbHk3UGlw?=
 =?utf-8?B?NkNSNlJVN0VRYkJkQk5vc0xudFRUTXZDeFhkMUZTMzhBYlJTbUdUaEFwazBt?=
 =?utf-8?B?SDE1cFVHdDEvdUNvQ0NiSDNMaGZ3dGdqMjUrZmhGaVE0cUozOTdkcDB4MCtM?=
 =?utf-8?B?Y3ZmRnZGd3I5TVF0bnNjQ0JkT3hneVM2V1M3NGVVaGg2NFBncTNyV1JROFlU?=
 =?utf-8?B?UzJXUFpuN3V6blBad3ZIV3U2NkVhUWZmaUlxVkRxb2ZVYlI1Q01hUjFJenUx?=
 =?utf-8?B?WXNhMVNhU3pJR2puTC8vY1h6NmI2bFpVRER4WnpoS0N5YXhvSnpFQ1lrdjdU?=
 =?utf-8?B?bWllczBaSGhGTFlWZW5ZWXd0djRPYS9wVFl2SXNwb0Z2aThLMkQ0R3lFa0x4?=
 =?utf-8?B?R0poWE1JUkJkK1N0QlN5V0JVMnBaaExVdzF0OWk0aENMdGhIMTJqZk1MbXNH?=
 =?utf-8?B?emZnblhvVmt1ZitLeGYvWFpQc0oyV3g1d0kvM0l4bTlGK3JjZ3dtZ3pTMjI4?=
 =?utf-8?B?Tkd4YmV3OFlMSHZYd0hNejhWN2lISnZZa3hqcWNQeVR5dm5nVndYdnR0STVY?=
 =?utf-8?B?NHRJS3U0eGFoKzhrWnBSQVNiOEprbndKcFo1d3orZ0h3V1VHbkhpZTJXaGp0?=
 =?utf-8?B?dDVyR3ljTGoxemlXOGNueG5IZmxSS1RDRWRCeGNXUENlWEZueDVMeVVBQS9I?=
 =?utf-8?B?N2lYVXd6emFFa2lYRlIwOGNDQXhDZHZCQWI3VkpJbXNra3Rsbkk0REkxbkRE?=
 =?utf-8?B?djFzZ0Flb3Jqa2pkOFMxLy94SGxRMzFFMDZoNVZiVXdjTC96ampEZUx6STFK?=
 =?utf-8?B?U1lVOWdmbmVCM2U2R0pGY1k2Y1FCTzQvc2psYU5Va2RMc2hWM1VWVEd2MHFQ?=
 =?utf-8?B?UDVZY1QyZmFWREhzRjh2bkNKT2VXVU5zMU1rSUh3MVNaNzZoUDJRZHRJMkRk?=
 =?utf-8?B?STR4VW5LbWVkTUxSejRNY1ZKUFZsZUZNdnFDL3lzRnB5WnpkUE14UEE4anhn?=
 =?utf-8?B?ODl0MGpkRHB5eXZYUDd1bGpXbW04cmNsRHVhYjJ2dm85VytyQzdWZmFpNHFM?=
 =?utf-8?B?TEpuZ0hodnFpQ0RRS3dCZytWTUZhSGdsWG1MQ0x5WVdkeE43ZTNSdDBVa002?=
 =?utf-8?B?bHozNXB4dU93NDVKQ1lqaldRNXhjN1ZsU3JYekVnSGgrUWpRTm1sQ25QVTFm?=
 =?utf-8?B?elJlQWQwc3hnbVIzWmhvVy9VaWRTS3Q2YmJ4bTAyTW9TamRxWHR5ZDFLU2FU?=
 =?utf-8?B?WVhOVE9IdUFWSHpKaHZJUElLTk1HSlgwTEJZL3l0ZklmK1Bvc3JLbjJ3UG1a?=
 =?utf-8?B?OXRBN2tuVCtIcnJmYXcxU0tEcElmazFzRFdaelZGcnEvNjFhb05kYS9ybGFM?=
 =?utf-8?B?U3I0NU5LeWhPWUttSDBzSnRndUUvSE90RWF5OGRiM1VSVDZRSCsxTGUxdlg3?=
 =?utf-8?B?TzA3MW10RUZ0NXVsYVhUcXkzN0FKZDZGY3BnVHU4cVZaWGVHcnlWd3hhN3hW?=
 =?utf-8?B?SmJZK2tKNys2VTI1UDlkaURXbmRTakMxR0xDS0x5R1JzYzkrT29pRHozWk90?=
 =?utf-8?B?RTJTWHh3T0tCV2NKYlgwNi81alVwYXRHbzhrT0VGUk9RYXdrd3FZS2VyS2o4?=
 =?utf-8?B?VUVFZHdGK0VnOHB2VTNCMUpSNzUvdFlRQzZQRUlUTktQVXlpc05yNVpXUWp3?=
 =?utf-8?B?Uzlqa2RXd2dCRWY3azUyMytSVU1aRFFuRFhoUXN2QUUySCt3Mm9oOGNsaXVa?=
 =?utf-8?Q?B40m5UKfcjySd//KYM/nw6Z73PmfHA8Ru2GeItPl0sqGZ?=
X-MS-Exchange-AntiSpam-MessageData-1: vSsqkQjW9j1djA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8420fe7e-d219-47d0-465a-08de8a364aca
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 06:18:12.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jpT4aqokeLwQd0enPaBBG3lsIoZYQoEbMSsoj0p+fA6T1n6HDQrOIPMy4OOrL232Z48/210gb0UMf4002O5eUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271403-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com,davemloft.net,vger.kernel.org,lunn.ch];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,devicetree.org:url,Nvidia.com:dkim,0.103.194.128:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 119733201E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 24/03/2026 22:57, Rob Herring (Arm) wrote:
> 
> On Tue, 24 Mar 2026 12:16:30 +0000, Jon Hunter wrote:
>> The PTP clock for the Tegra234 MGBE device is incorrectly named
>> 'ptp-ref' and should be 'ptp_ref'. This is causing the following
>> warning to be observed on Tegra234 platforms that use this device:
>>
>>   ERR KERN tegra-mgbe 6800000.ethernet eth0: Invalid PTP clock rate
>>   WARNING KERN tegra-mgbe 6800000.ethernet eth0: PTP init failed
>>
>> Although this constitutes an ABI breakage in the binding for this
>> device, PTP support has clearly never worked and so fix this now
>> so we can correct the device-tree for this device. Note that the
>> MGBE driver still supports the legacy 'ptp-ref' clock name and so
>> older/existing device-trees will still work, but given that this
>> is not the correct name, there is no point to advertise this in the
>> binding.
>>
>> Fixes: 189c2e5c7669 ("dt-bindings: net: Add Tegra234 MGBE")
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/nvidia,tegra234-mgbe.example.dtb: ethernet@6800000 (nvidia,tegra234-mgbe): clock-names:3: 'ptp_ref' was expected
> 	from schema $id: http://devicetree.org/schemas/net/nvidia,tegra234-mgbe.yaml

Yes this is expected until patch 3/3 is applied.

Jon

-- 
nvpublic


