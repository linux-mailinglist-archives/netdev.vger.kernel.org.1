Return-Path: <netdev+bounces-272914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MStEugryWknvgUAu9opvQ
	(envelope-from <netdev+bounces-272914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED9352472
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70CCE300CFCC
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686B373BF1;
	Sun, 29 Mar 2026 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="d82onZ/w"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023087.outbound.protection.outlook.com [52.101.83.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061136EAA4;
	Sun, 29 Mar 2026 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791650; cv=fail; b=cH6+ImzzMc35l9uM/jrApHHPE2KR9ZTTTGnSjJA+w3tOSJ5arraKkdLjdzUDWmSwTzlGFFExAgaLztJvSAhRBYzw3lcGVRfM0Kf6WfUwfvOQ9KkTLl4BEg53VCmtIPETL3bN4g+TrFpCtnL5OXizzC8C09XXtkTImA1PSNekD34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791650; c=relaxed/simple;
	bh=+mdfebFqb9tFzvocEgWYHl5W9LZP6UtmHIkpRnXDiNg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIxxabJ0T8KJjAqm9MVqEVeykF0+1IWhmZqXiUwG2fOFRkDONSkS+qPAr8wDNTgf2oAbc7T4sHT2n4V/7PcZka8nwnP2+RCa+f5Zvk7j/PGiHSmhx1/y6pu2e3t73R+WRMVajb0JRc5tEww4L3nUGqQnYzNmbTA9V1jk5NUCsmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=d82onZ/w; arc=fail smtp.client-ip=52.101.83.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KphWP202U4bGHDWTGjwjenck6q0mtw6AouDbV5kHRuFk4+cooSFDQEXWNaKgOiZgW9K1bX0dbaTbae/lNkvduiDRC5s6HgoZjoewl9OQyaHoKo3SJlq6AueEMJ+E/aJ+xKidpuKiqWL8f/HsyNeI80S21X0Ecf/Ui5C5tmnly57J/PTFtjbKnKn98SMdoqLtS21HByVZsljK1LIRHDSwYHubIKp+ZLykW6+YIaYqQpN8WkJEhB61qtoOKJpyi/RUu1SdpKGftBywTT8YfiQhQWte2g/6Vj+1huIEe99ccyb4kQZgdGgoGJMQTuKPvJHRm1suNMZhPD0xqxJKIs5YfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jvffxLoCBgjG87056ZyPh5owZY2FyeuDQKF7B3dGugk=;
 b=vKscX+lseFdMTW+N1mCgPhEs1Omieu1T++KnoiqTB25J3njP7rDnQQY7Jv1ZCr0TnVihN881hIR25sb6wPfJu2UJLDydLWTn1eW8VjjmiRk1ltwd6aJEv8dI07Us6fwB4XAc8lgcCgZMLnMkscCiPhoWSeJggJ4pjz8xWvh2t/LUyk4+jAVksNLI7C0kwEg6+otIaL6qoUY7SY0rFUt7IX57sTZvcnYiZnhg/Xl98wM44GS5WSKNrX1J1HyHs1cnZ/5sxkNny5crb9iRX3ne1zkwIgyN9IMTnwwurz+P4Vr7029ZKGbdnhrWQtbnZc4qHOMdm/v4oY7tsV7CxCF6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvffxLoCBgjG87056ZyPh5owZY2FyeuDQKF7B3dGugk=;
 b=d82onZ/wX8SSjSmNvcI6NNuL4RzKYXrX7V4Y1/Egz1o/+g7HwHA5kzLQvUbCCRiu1cDxRfv3wuA85D9GousbLp2C/IxVcyPt/U6F2ga8+G514CRiFFEaYPTs2iEyQA9wbdKM2GMs/vff+RTXagHpExsharHrzTg/5Xq0XMWYlPIGQjSJxxrIB3z3a466kFdMdYKo+mt3U7ChG+OzWaMWiD/YXoS7Kr5UMkUZeTcB2PfzL1xbvkCOd/6aqHKDthFahkOnTdxCLTK/8vHV5EFGF8kYB7G/apfqRqkVw3tpnvUYGHxnCchgWtBosH1xvZUL0lupGg1qAWzac8TyEfJqzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com (2603:10a6:10:2ad::14)
 by PAWPR08MB8887.eurprd08.prod.outlook.com (2603:10a6:102:33b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.25; Sun, 29 Mar
 2026 13:40:45 +0000
Received: from DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f]) by DB9PR08MB6697.eurprd08.prod.outlook.com
 ([fe80::bdec:3e95:6614:441f%7]) with mapi id 15.20.9745.025; Sun, 29 Mar 2026
 13:40:44 +0000
Message-ID: <a64e0f7e-7073-4355-a3de-e8d93e2c795c@genexis.eu>
Date: Sun, 29 Mar 2026 15:40:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] net: airoha: Support multiple net_devices
 connected to the same GDM port
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 Xuegang Lu <xuegang.lu@airoha.com>
References: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20260329-airoha-eth-multi-serdes-v1-0-00f52dc360ca@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To DB9PR08MB6697.eurprd08.prod.outlook.com
 (2603:10a6:10:2ad::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR08MB6697:EE_|PAWPR08MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d94f2e-3605-42a6-685d-08de8d98c6ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AiwFPG/tMGgs3sgoEVcR16sbNiaTcYpuTpHn++jbRoQ4uxMPsWQ+RGWjH+ddOlVAcSTfKIWzH9TAeuWv7lWaPlPbtneCtWsqc+auqNphLzJfIWONRMUyuOObKBqOqkBmn00Le8hoOxwAQYxO7zT7Y6UcITnuotDAQIQ0FSbA4evg3aE1FImWQmtFjoU2E88k6DgdBwVWGAPuo9kkW9VzJfeWhZ+aAbo9G+A6QbzMP7q1RoIEFySdOQqY5izwEnWqjtIEtgtu6scxXbKfJ+qHC7bypn4FgbKu0cc8sNL8Em6C/hjtsdpSzT89Yle5HX15N63ibuViN5hnMtgNRM7d+CVHbfwGv+InYhPMBKB1NPFqx8xO6NfIAHDpvkTwrs3ogl0WYPai3pjT1Uujg4NMIaT7KwpzGXOCB2WMzBHTyxyZ0RWiGkJFWZwgQmIRhyX7cOQKhfImL2n2vvTIoUOvvQV8GaHLRPEL03M4qCVZ9bm6R73aI5FTeGaPv2AoR1yQTaH4hFEBgv3ZSi0HFfMXM/cA9zjqKEdBe8bV9eApmwR7Mh523g+UH9IRWTR3ClXR+Jmfy0nUO8cFptnQBAjvBNCo5FYY+bDOBThquhhLff0Qe6wGUEUEM3VUmEJB4VQVZ0JpGv8f7ZwSgAlQU+TfC1MT5Si91BtnDqxDMptoIvp8Jo5NCOV69WcFlzwD92QYAt/vLt/N4QGPiPs0gLOLPlAGan6PvqxUb0DqT7RJcH8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB6697.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1hpYjF0MkZ0dGVQeDVnMXVSYStsWnA1SHFVcUdWKyt5ZWE4NzZhWnROS0JX?=
 =?utf-8?B?S3p6UXp6cytaR3lObndOVnhkc3VpYUhFRVNuUjhKRVVZU1FBaUJDUjF4dkV3?=
 =?utf-8?B?ZUVHN211RE9hS1ZHcDV0ZFF0SlhSOEVIcllMMzFEYjhrM1FFcDh2UzlCS01s?=
 =?utf-8?B?TFp1VlJtYk45am4xcDdqVDhWbFNGelVXWWhWdEpXWkJicDVabFVzK2hEMUpw?=
 =?utf-8?B?aHNaRzVTQ3BnZ3hOc3p5SHAzMGhhdjlNcloyQWRYSHdIVDhrNytlSWhqRHZE?=
 =?utf-8?B?MzFobVNtNWoyWnR1aDJvSUlkRTZZYzdtd2JyRldNZE81czBMbkxRNnoxbVY4?=
 =?utf-8?B?b1Fjd0s5dUlLNkJEbUlHUzdscnVtTlduTzlCb3d1Ty9wMVQ1VzJuRnAzcjFl?=
 =?utf-8?B?VzNCOFRjZU90ZE50MGo1SDB2czVTRGU3aUZNZ2Q1Mk43b0NoTXpsQ3V5WUwv?=
 =?utf-8?B?Wld5NzVmRXBaVjBHc1pjSSt3OTRlSkkza0dzZWFjTzVidEhDSkVTTXU1WFY3?=
 =?utf-8?B?MDFWenJXSmp1MHo5N2ZLekhzYnI1Z0hvbzU2eGVtV1UzamVKNnNhd2VuWHVG?=
 =?utf-8?B?UWdpWHFnTG8xUmpYK2x6RVZMOVVWbjBMTExnV1gxcHBTY3FsTnhnNk14RkpW?=
 =?utf-8?B?NU1mell2RnllV0RGeGpQdy9EalJPSzRVUHNtbDIvYjdZSm95VXpvcXRzbEYw?=
 =?utf-8?B?VTJZMEZvbDV4WmhvVUdkd0g3bWgrcC9xL3M0M3NFMDF5QWh3NXVVTGlRTURk?=
 =?utf-8?B?T2Z1VDNBMU9pZE4wYitPSC91Mkk3YUtDSHpCVFZQUmxINDdLMGhkRnlZbCt2?=
 =?utf-8?B?TVdKcUgxMmJBMWtvYVlYYi9oUGtTZFp5U2FIYWF1V1J1dzk2TStFR3Z2b0FU?=
 =?utf-8?B?eUFuWjRpWUNEc3hORktWYmxZVnJidmtiemV6QnFWUWZwcFcvWklZSmJkMS9D?=
 =?utf-8?B?clhlQ2NuenFsRng0Uy83aHVrTzVFcXhJeXdWKy9vZVJhSmNTQ1FDMm1PTFNk?=
 =?utf-8?B?MVlOUUo0dlZKOFE1RVo2VzFOSXF3QklBZWkzQ2xqY3NlQjhSZHNab082SFhR?=
 =?utf-8?B?SkFRTlZxTjh1VWxRcCt1S1gvcXAvK3VZMDlGeWFLZWExMGFwWldySHRmZnBz?=
 =?utf-8?B?akYrT3RTc2x2azhKQWFHMGo1MnF0VGc4NlE2MUpUZEpPZm8yYllRM05va1lE?=
 =?utf-8?B?WlI2ejBwdGFSbDJ4UTk5RE1IZXZ4TlI5Uys3NGVLMUhEUURMYkR2N2NoS2ta?=
 =?utf-8?B?bjJpZWlkbFBVVld1eXRINFdhek1OTmZwMU04ZkF2ZUk0NXl5Uko4VDVhTE5z?=
 =?utf-8?B?ZEpPNWp4OUdGQlFXWXVBTklUUkJaLy9PcWpaUmRHUGc1ZzN2NUdQd3VYcWdv?=
 =?utf-8?B?c0pZSHhEWEZjVlUrTlRKejVUU29qOUJJRHNLbW9zb3dDL2I4Uk9veGd1Nm8v?=
 =?utf-8?B?d3NiVmhrVm44RTRRNWo3bjhraWIyRytDMllrc1RGb3lub3VEVmVkR2xYQ2Q3?=
 =?utf-8?B?SG1rbGJsY3JLVkRyT2dwTTRTVFZoTm9PZzgrM1hhLzlOcjdONmllREZNWTVV?=
 =?utf-8?B?cXRyVzhBb1JlSW1UY3Q4aHljZ2JjdmRGSkxET1diS1IzaEJ6dEVzQ3ljMjY1?=
 =?utf-8?B?OU4va21vdSs1Q2paVmdOenJqdjE5V2hpRE54dFl6dm1LUlMzR0w5ZTd4elBJ?=
 =?utf-8?B?YlREM3kzZ0Rkd1lUbDRoMU03bzloZ3liMXlUaUhKRzVULzVaRFpNQ0lVNnNh?=
 =?utf-8?B?M2NycHlyUnBvSit4Y1U5bm9leE9SL1MwZVlXekc2T1lBNWYreU8reHVRSmIw?=
 =?utf-8?B?YmtNczBzT1FURXd6UnVtMFc3VytmMlNTOC9zT3FEeTJPcmtOWHF4NzBqeUNY?=
 =?utf-8?B?ZzJucXR4NTQwcW1YSlNUMFd4eDZsNGJNVng4MGNPTHhGZFVJays0bWVGSGU4?=
 =?utf-8?B?WTYrMjlydmk5MUFXSTRRTkN5bzI3TFBCWXZLRDlRWEdESVdTODZuRW83ekRJ?=
 =?utf-8?B?T3h2d3AxV2pob2ROK2wyV0FjWU5tVnFwcENhTVlacUhweWNFOURvTEk2N2lR?=
 =?utf-8?B?WDladXkxSTFFRmlVc092c1ZRL0hjYkZTZDZPOVVITzUyRVZFUUVsNVZ3TStE?=
 =?utf-8?B?YjRaNS93UG8wekExSmRCZDNXQ253WE1WZ3J4bi9TelJwRThWNzBkZ1ZQSXlW?=
 =?utf-8?B?bWZLM0lzOXZ0SGVLMVF2OHlqQWtJWXZOOTNOWkJhV2tzQWEyRXdFZnRVenlh?=
 =?utf-8?B?aUEvOUJVTWEvZlRNcm9EMXhWZ3ZBL3pBZHdxRXJiSmdoK21TaWFaWkNKQXZD?=
 =?utf-8?B?dlN5MjY2ZTFaeGJ1WHpSNHA5N1RaRzkyM0ZsOGl5QzJPaWhaelUvbC8vSW5n?=
 =?utf-8?Q?jDC/KgMQPvQl/KSU=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d94f2e-3605-42a6-685d-08de8d98c6ee
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB6697.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2026 13:40:44.7294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTPjteBXkFKR+pv1F8WdEgcisYqH3EnvzZ0zqVMS2IzL1/0VtCz9aofKdYFsHHMrfK+IzINLmxbytUzzuYMS/8jqzQp83Am0s1x+8fpnV90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8887
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[genexis.eu,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[genexis.eu:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272914-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,airoha.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin.larsson@genexis.eu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[genexis.eu:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBED9352472
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi.

On 29/03/2026 15:07, Lorenzo Bianconi wrote:
 > EN7581 or AN7583 SoCs support connecting multiple external SerDes (e.g.
 > Ethernet or USB SerDes) to GDM3 or GDM4 ports via a hw multiplexer that
 > manages the traffic in a TDM manner.

I think the word for this is arbiter. I think the common use of mux is 
as a more fixed data path selector.

 > As a result multiple net_devices can
 > connect to the same GDM{3,4} port and there is a theoretical "1:n"
 > relation between GDM ports and net_devices.
 >
 >             ┌─────────────────────────────────┐
 >             │                                 │    ┌──────┐
 >             │                         P1 GDM1 ├────►MT7530│
 >             │                                 │    └──────┘
 >             │                                 │      ETH0 (DSA conduit)
 >             │                                 │
 >             │              PSE/FE             │
 >             │                                 │
 >             │                                 │
 >             │                                 │    ┌─────┐
 >             │                         P0 CDM1 ├────►QDMA0│
 >             │  P4                     P9 GDM4 │    └─────┘
 >             └──┬─────────────────────────┬────┘
 >                │                         │
 >             ┌──▼──┐                 ┌────▼────┐
 >             │ PPE │                 │   MUX   │
 >             └─────┘                 └─┬─────┬─┘
 >                                       │     │
 >                                    ┌──▼──┐┌─▼───┐
 >                                    │ ETH ││ USB │
 >                                    └─────┘└─────┘
 >                                     ETH1   ETH2

A more representative picture is like the following and in the GDM2 path 
there is a real mux present(not relevant for this patch series though). 
Thus I think it is important to have the distinction between mux and 
arbiter. (Feel free to reuse the following illustration freely).

                 ┌─────────────────────────────────┐
                 │                                 │    ┌──────┐
    ┌─────────┐  │                         P1 GDM1 ├────►MT7530│
    │   MUX   ├──│ P2 GDM2                         │    └──────┘
    └─┬─────┬─┘  │                                 │      ETH0 (DSA conduit)
      │     │    │                                 │
   ┌──▼──┐┌─▼───┐│              PSE/FE             │
   │ PON ││ PON ││                                 │
   └─────┘└─────┘│                                 │
    ETH5   XPON  │                                 │    ┌─────┐
                 │                         P0 CDM1 ├────►QDMA0│
                 │  P4      P3 GDM3        P9 GDM4 │    └─────┘
                 └──┬──────────┬──────────────┬────┘
                    │          │              │
                 ┌──▼──┐  ┌────▼────┐    ┌────▼────┐
                 │ PPE │  │   ARB   │    │   ARB   │
                 └─────┘  └─┬─────┬─┘    └─┬─────┬─┘
                            │     │        │     │
                         ┌──▼──┐┌─▼───┐ ┌──▼──┐┌─▼───┐
                         │PCIE0││PCIE1│ │ ETH ││ USB │
                         └─────┘└─────┘ └─────┘└─────┘
                           ETH3   ETH4    ETH1   ETH2

MvH
Benjamin Larsson

