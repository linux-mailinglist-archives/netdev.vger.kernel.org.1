Return-Path: <netdev+bounces-176996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E5A6D31B
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 03:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76411892ECB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 02:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077892AE8B;
	Mon, 24 Mar 2025 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="Rt51+tb6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.131.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC5315E96
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.131.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783990; cv=fail; b=nvrBAz9CDx+lPp48HTCvuIdV+dN9T7+dI4LE8sWLRO71KylKf9apR2q81G/Q3u5VirQdnhfIZQHW5t1QxhOixXcootMOAJMk1m8PAbPSbhEsVcVDSR2Gys45XtPFGHjzP+ddwbZKjZpUygYgNKmco8qsCDzlRc2jwy8TY5NOdqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783990; c=relaxed/simple;
	bh=4D0ofDg5rY0A6xOzv8b8BEqdSXQICspQ2CxZpq48ZgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEwO4AVJRo1XaTCcNWSzazpro4iJx/mxLVKF3PAQeOKYupSCgQ9qHxJ8WVLywfTS9+sHMg0vNJaarQmKITNJGqP2QSwBiLFxBjystNThXrgBlZw15raDFcqxwWRZ7TQd5AxY/lk2vmZIIiWUXvU6IdxCOw7VQNPIXNp56Ihabdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=Rt51+tb6; arc=fail smtp.client-ip=216.71.131.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1742783988; x=1774319988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4D0ofDg5rY0A6xOzv8b8BEqdSXQICspQ2CxZpq48ZgQ=;
  b=Rt51+tb6msLfiEyYuh9EddKH4HwPbzS6hSoInyUZooMh8icvv/r5hSdo
   Hk9cajyg+WXVnH8wpsxVyDBHXdcQcG2Tc6TQ4VNuPH/p+GY1ZDICG662k
   0kZdgR+hupLN6SpNPwZupcbJ8Ao5FAvlXViO91plhdrrUu7Rz7/5yvuW2
   8=;
X-CSE-ConnectionGUID: 7jtHaP4IT2Cqzxx41kDDxA==
X-CSE-MsgGUID: OPSQmEVnQlyu9fMmIycmCg==
X-Talos-CUID: =?us-ascii?q?9a23=3AKIAQXGkvyAFqG7//5GHNhRO4uqvXOSLf0FfZGxO?=
 =?us-ascii?q?ZNTxCUa+FWQPJ+49Ig+M7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ADeq3vw+eKeMxKGCyWWC1cRKQf+BQ2J2rJX4LqJE?=
 =?us-ascii?q?XppiKEClRKjyYpzviFw=3D=3D?=
Received: from mail-canadacentralazlp17012024.outbound.protection.outlook.com (HELO YT6PR01CU002.outbound.protection.outlook.com) ([40.93.18.24])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 22:38:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBbmAjJS+NaNVMN9LXbM/8RSWLsy/a7DStXiiVBp4pQQzdH6Ts96mymfSD+CvBhsvfE2BwUJZO1xRXKLu+KOEz90ZXutPG0vfjdPqzWCd0jRTTpbXSO07qdjUnnfsaoovJzn2Q/NYdlSOjt0cKvgR99zeU4p7dOonFYrP64eKlonAJwawo+whStG0/c3UAdSCZCIzlMlnFABNOXhJqOTFWzvQFDnNpgXcploaUSuymZdUqLXCmeGrROQlMMXiogjYv9ohYxRq5wWowFbXHTAlJa79SVefNYYjeq4N9w738EBfivjvWXnLbyW36WHzpad+SJj1wAhye/R27qJltiH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEBF31FDOySh8ZSUbXsOnfbnjK25/yTNiM4LD/j7u50=;
 b=vSndO6TuBPW2LZUmwpg2WR31J1DoJjrapwsJkGJyL22LaGZZZ4pAfEWC5qACjHJPMBBkKieAbc3AIC/54ceULFgo8jN3K3AAO8PZOZr1kiyU0NsUw/ECEoHec128+uw7r7tEjE86zXeEbkPJcyBz3DbEQvyFBqAXVCoo2+GU8sPqzl2zQTLxRbw38VKARrpHyfN5uGuI+ImDV4Pmn+n2XHC+JMRcaRDvWUzUxyLFjki3CduOYQFQOijakMPhlrQUPm+4aLxawO5/pvxc3Bg7WFdezO+CrDx4y7sgydVb3SPj0Kq2jZ70z2M+cwwFc3jyxi/94JGvKD+Dnv/TRmlVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13) by YT6PR01MB11055.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:13c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 02:38:38 +0000
Received: from YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930]) by YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::d36e:ef93:93fd:930%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 02:38:37 +0000
Message-ID: <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
Date: Sun, 23 Mar 2025 22:38:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com
Cc: netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <20250321021521.849856-1-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::11) To YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4b::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB6572:EE_|YT6PR01MB11055:EE_
X-MS-Office365-Filtering-Correlation-Id: e499b35d-324e-4cd6-de39-08dd6a7cfad7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFZDZmViUVVpVDRJbk1KWENPTElETEpMZ096a2tvZmtYVExoYUNRclFST05D?=
 =?utf-8?B?NGx4b2lEeGUraHJ4VEhZN3dqUmJjQVVUQ2dvQ3IxK0NhWnFkQ2tZdnRyZ3Nk?=
 =?utf-8?B?RTBkVTd1YW5XMVZiWTZueEFzeGx6ajJmNTlhdHNDTUVmMTEybm1iS1ZFSTEx?=
 =?utf-8?B?cFZlQ2NCd1JpZGVnNERGQWZ2NmpPZUdtMTlCQllnUkcwV0hnc2VXVUxsWlRN?=
 =?utf-8?B?cDExaS9WbGJoY0NHQmF5d0N6L0QxTzc3VFpZaTR4TXdnMDZRenk4cTRJdktU?=
 =?utf-8?B?SDhrTW8vaStvSjlSL3l0c0owYVhEcWNCWEJyVTJhNDMza0ROaVgrbEtBT1Ex?=
 =?utf-8?B?Z1VpWkFnaldYVXo3NCt5dVl6SGgwa2YwS2hNVVJONElmVWFQTVVDQzlHR25N?=
 =?utf-8?B?dCtpVzI5cGtFTGh6OGh4T2ZVYk0vbm02U29oNHlBOUpjU2U4VmQwUFcyNDBP?=
 =?utf-8?B?dFlnaldENEJBV3JkdUFzV28yN1JSa0huSERLTUJpYzJCSGRQVDcySUFnOHlI?=
 =?utf-8?B?U05OanJVSUhEdlNOQWNDcnIyOWZqV014SWNVMGZZbzQ0ZkNXSTRIdTJjblFi?=
 =?utf-8?B?ZjZzSkUwTllZKzMyVjYvQVNFL0xQb1RMQWN0WkVsYWpVbzNZaGR4RzlVV1hp?=
 =?utf-8?B?c1dkMTc1ZTBzdm9qd2w4VTd6NlZvTG9jbCtmMTNEY3lFVS82UXIxd1crNVZj?=
 =?utf-8?B?bmEvUmRSMUNWTml3aTNHbUEwZERzdTZtUXBtYWExTkg2RHhRSFlZTmZVdkZF?=
 =?utf-8?B?NUwySHJ3b3Azdnlpd0lYVzR3N0xaVk1EREpwV01KY1lhYlBQYS82S0NqbjFm?=
 =?utf-8?B?L2tqSXZRUjE3U2RtUkZMQUlCV21rWkVON2ZGTW96V2dMdStvRFlUbEwvVXc5?=
 =?utf-8?B?ZzlibGR4YnVteXpNRGk0OHRyN3QwMmpWVDZYcmpubjc2Wll1M2NmNERwQVpS?=
 =?utf-8?B?U1gxektZcGozODBvYXlHL0pPWjN1d2ladTVzQUZ0b0xaSElLbElDMWZkNkFz?=
 =?utf-8?B?REhadlVBTms4QlF0ODcxZDNPWE03WVRueVVadjdsOHBYSXJnejVHN3EzNTBD?=
 =?utf-8?B?KysxSFF6MjhxeC9naHg2Wi9NdnNsRGRyM2M0b0JtVFdYWEdNVTFwZ1BCZUhQ?=
 =?utf-8?B?VWpBQmcxZlI3dmpOSHZNdkgwWi9rQ29yZmwrdmIrT0JBamZxRUJKTytxVThR?=
 =?utf-8?B?bm5tODE5Skd3VXlhUXE0NE1pK21qWXBwT2h2MU8rRTdLa1R4Uk41eVk3TnF3?=
 =?utf-8?B?NkxBbzAraStDcnRrODVPQjNWY2h3M3RIUkRCRzF4Y2pUa250cnc1QTdteWZO?=
 =?utf-8?B?eVZQa1o5UkNORWRUZHNadlAwdndMK2k5UDUveE9oZUdGSE9Qb0daQXFzVXRs?=
 =?utf-8?B?Mk5IeEN1SmFSWVc0bFUwQ1R4bmVncyt3YUVsOWk0MnMzbkVpUXI0WS9EeThJ?=
 =?utf-8?B?dkVjRVViU09VdXpXaVBuSGNycFJaZWZMWE9zUjdmcVBBaEVYRngraG42WVBN?=
 =?utf-8?B?NU1EMkdnSEtQQkxDZXc2d3hyZy9XSVVOc2JDYnJDUW9Md2FQYmU4aFVzVnhh?=
 =?utf-8?B?ZkhYVG1PS3cwNlNoeHdCS2FSYVg5MTlseVdKc25WaFg1ZmpuVEFXbUdHWm5L?=
 =?utf-8?B?WHkxRnkxU0FtR1ZyanZyNGExQ0lCcVcxdGUvbUt0MEhOb2JSWmN2Q2NpZkVq?=
 =?utf-8?B?NkNIT3EzQm1Wb0VMMHcxRkQ3dlV5bU5QTDJ2NnVYSXBZMHliQ25IUFhRTUox?=
 =?utf-8?B?Smc1aWI3T2picU5wREh4NTYwR0NnRE1ickd2WW4wS2cvRjdTWGkza0hLWW5v?=
 =?utf-8?B?S2plNFFubGVlMDRIbFJQVGZZMHpRdEY0R2c2Y2VPZWd5dmxwM2Vqd0lneG9V?=
 =?utf-8?Q?i8+GEXNSOn7AD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFPMVJxZEVpaDhHQzVsZGxrNGhXblpqWHEwNlhFWXpZZGxMZHJPOG81NHZR?=
 =?utf-8?B?MU5aL1JKVDZpRk8xdFFWU2YxdTY3VlR3Q3JISUhQT3M5S0M1Zlg1bFNZWjdm?=
 =?utf-8?B?TGxHODdORkh2aUhtaTN3K3ZzOGVxUmtCek1yeVJsSU8yS1ByaFp0NGZNMGZR?=
 =?utf-8?B?djM0MG9xQkswejdUNUh6Z2pqZlY5L3hiYlpjb0tDd04xZUttRTRHK0hrTzZT?=
 =?utf-8?B?eCtzaWN3cmlMVG8yK1JUb1ZkUUpWUkpGZGpFbTBaQjRwUU81WFZUb3dFNGlp?=
 =?utf-8?B?VmFBcjFPazZKZldsdlRSV1Z4aWlkSENJQThHdjBlamVzK0ZTOWJDekdFQlRq?=
 =?utf-8?B?QnA3eXlwdFNDdjBGYVlnZTZzb1ZvRmovOWNQVGRTWTlPV09XWjhSZ0xreVR5?=
 =?utf-8?B?bmNXYjlFdnZJelZGK0Eza1NEY3FxNUdKc2ZiNkN5ZVJ4b1RGc3dUdi9VNG1r?=
 =?utf-8?B?azAzczRvdm5QTHhkWnZ0U1czcU1ycUlnUFBXenZMQ0lLVUV3Wm1wTVcrWFBI?=
 =?utf-8?B?VTI3RFFoUUlTV3gxU3VaNElONnc2M0NjYjdyd0tidVE2eXVTc1J2dEZSUFVo?=
 =?utf-8?B?b2dERHlSczIrcnc0OHpYVUdQeUJONmRQZStzU1RlTXlhY3pMaFI2aXNYaW9W?=
 =?utf-8?B?emtQdzYwc25yazAvOE9lSEl3am1URHRWcWRneDdKTUNRY2VMSGc1azAxTnpl?=
 =?utf-8?B?TlgwWUZndXlnZEEzSnJlTkxId2xOUUl1MnBScE5WekFnQzU2NmY3b1NRRGRP?=
 =?utf-8?B?cUg2QjVRT3NtSmFtUGQ0L090czdmNVBHRWUwSjhUTmVrOHF2TlNJemFna2xx?=
 =?utf-8?B?UlpPTE1yWk90aTNkdkNBSmRmdCtOMG9oSWVlVVQ4czJpcFJseFZWT0JaOGVO?=
 =?utf-8?B?S3o5cTNQY2dBMDVWc0VmQXEwbHhCdlM5dWtFNVlZbi8vWUc2ZnBjaUp3b0VY?=
 =?utf-8?B?NzhiVDE1eHpKS3BXMVVrQVZDeEdWYUN4UEUzcncrZkR0UnRGWkIySS90NzZL?=
 =?utf-8?B?TnArc0NVT1RJMVRZVlM1SjIyUVBFZmxNOXdEazRTV20zdVlyb0dFQytNbEhW?=
 =?utf-8?B?Uk1ZeW9IV2lYTnF6cHdIdy9PWVhyWnNtd1A0OExKMEViUHZWNk5PemIxcmli?=
 =?utf-8?B?dXp3TXA1SWNXQ3dlNHVXeVl1bHJqOXljOUhncTcyYXM4cGNqMXZJSEVGL3pE?=
 =?utf-8?B?b0QrKzAwSVRBRWpjQjczK1RUZDd4d0g3Y29Ya1pvK0UxNnRhTzRiWXkrdlZX?=
 =?utf-8?B?WUt0dmRZL2hjZ1E4d3MvS3RPR0NYdjcvVVo0TDNQRkRwT1hHV2swQmlTM2VM?=
 =?utf-8?B?aWtrYk00UVNlcE5KT2VDOUJFVHZuL0laNEdrWmFocHRtZjV3UUtBUkxlUEpM?=
 =?utf-8?B?SnUwdktDUTFjMG55NDBUZ0VpRVcrTWg4MFR2UmROT3p4UmltZFRnbVg3NEJy?=
 =?utf-8?B?bU5XUnVqVmNETVpiR2F6TG5oT0hBNEtJMXpUVm81d2dycHZwT1JQa2dGNjlq?=
 =?utf-8?B?bTJ5YTU0VnJDVDZYTXlKMytDTjlWNTJtaVBNMDhjVFVuMnp3UmZnVGVsRFJk?=
 =?utf-8?B?WGEwZTIrUmlZYndZdytWRERhajZFS08xbXgrYmdldU10a09aeE45T3hqMFNq?=
 =?utf-8?B?NjJmL013TWlwRVFkWnNiN0xYYlpyeXRWWWpObi9oY0ZTdnBJSnVPUFFrdzU2?=
 =?utf-8?B?ckcvbjVvSWpkcHV5dXhKVnVyd0lBRGJuV09Jc0FXdEVtbkJGOVJ0Sk1xdmJ6?=
 =?utf-8?B?dEsvaDE2dVRCLy8xUGpSNmpoVEJoalUxbkhyOVRoeUhWRlpuSmRaWTdQeGZ1?=
 =?utf-8?B?TzNzWGxvVzlYTk1PeGFuV3U1YUZ1MkhnbkFCTmlIL0NQTzlIM0prZ1g3Yzg3?=
 =?utf-8?B?WGpqWW1BSTJHQ21LZnFZNm1FRGpLMm5ObS9HNmVqKzdkY24vM3c2ZDJuUUZW?=
 =?utf-8?B?Qzl0bXRaaTcrVDY3VXBOQVVDRDdEMHNQcEJBd0k0K1pjL0l5emVqY1J3RmtB?=
 =?utf-8?B?RzJHUWRtUHUyK0RrZ1JYaDdqdzRoeWNrVDY0MUdwRVY2a1V4N1FoTjc4R255?=
 =?utf-8?B?d3NjL00vcWI4MGU1Ym5nS0hMS1hMVVp1T1ROay9TSFdiVUJzRkk1ZjZ5eEZq?=
 =?utf-8?Q?NhnyF8TORB1OCMwNUNrcapUVR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ToR2w0vKEX9rGNwnxSyyT315Sfl9qYyu42GmtP4HiybzzMyyE6tiPfLrEBqTzhUjaRNw7kf5rl+NPTZsvWaQRBfyANJIg+BbCZ4Wjgr763wC+QqpiM9B1z9L2W7YXqIuoBobkIUjY8IXv3ldjnGyap9pB2uf75aykAK0BYLEyCK3Q4xRiYUmdTk8SuY46NI1ELxzEfVCr7Gv6S/z5tDuH//cCxJCgiB4N7K2XllJsz0yrlRgIhVbuLROlPNBXzmMlrL2CkgmvHCEyDr6fvEMi/iYRR67kkeAX24O2KcZnfVq0zj9UCJrANZZzpR51PvbHaLQBe9hLtSHeKiMk8qi0vNJMCEHsePOnOT/tZ4oGDMpw0OJFtlTHBZveLXqaZvoPgl1dRBn4ZD8ZXIDmA9ET2raynBdzQL38Jvb28wTLEsKS2Q4xR7pFd+UAo9bku0WoxPEsBHKvRBclJFfWbJc2Y4Si6ow6KmCpwgXnle7jtxi9UzdMXR1wM76lcIIE+evdwZiFyDH0WpWdGeZ8FCuUzMw0toHtlbLLdq74AYWJR7M+lQ0nt9Vk6zo6qsKEumdjH3a3t+yc5MrRp5a5QOZz4nPOZ8gCxudHwhD4lPJFDVl+Y5zWCqnrgXCZb5Rs0PJ
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e499b35d-324e-4cd6-de39-08dd6a7cfad7
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB6572.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 02:38:37.4888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRtH825HKz47axXTx06+Fkse/wS7zP3qd0BKUZ+YwVkqW1eDsloWcB16pgPFlvvmsMjZuiWTnaSx9bwivAE+9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11055

On 2025-03-20 22:15, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busy polling.
> 
> This is used for doing continuous polling of napi to fetch descriptors
> from backing RX/TX queues for low latency applications. Allow enabling
> of threaded busypoll using netlink so this can be enabled on a set of
> dedicated napis for low latency applications.
> 
> Once enabled user can fetch the PID of the kthread doing NAPI polling
> and set affinity, priority and scheduler for it depending on the
> low-latency requirements.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This
> can be done using the netlink interface. Extend `napi-set` op in netlink
> spec that allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabling/disabling threaded busypolling at device or individual napi
> level.
> 
> We use this for our AF_XDP based hard low-latency usecase with usecs
> level latency requirement. For our usecase we want low jitter and stable
> latency at P99.
> 
> Following is an analysis and comparison of available (and compatible)
> busy poll interfaces for a low latency usecase with stable P99. Please
> note that the throughput and cpu efficiency is a non-goal.
> 
> For analysis we use an AF_XDP based benchmarking tool `xdp_rr`. The
> description of the tool and how it tries to simulate the real workload
> is following,
> 
> - It sends UDP packets between 2 machines.
> - The client machine sends packets at a fixed frequency. To maintain the
>    frequency of the packet being sent, we use open-loop sampling. That is
>    the packets are sent in a separate thread.
> - The server replies to the packet inline by reading the pkt from the
>    recv ring and replies using the tx ring.
> - To simulate the application processing time, we use a configurable
>    delay in usecs on the client side after a reply is received from the
>    server.
> 
> The xdp_rr tool is posted separately as an RFC for tools/testing/selftest.

Thanks very much for sending the benchmark program and these specific 
experiments. I am able to build the tool and run the experiments in 
principle. While I don't have a complete picture yet, one observation 
seems already clear, so I want to report back on it.

> We use this tool with following napi polling configurations,
> 
> - Interrupts only
> - SO_BUSYPOLL (inline in the same thread where the client receives the
>    packet).
> - SO_BUSYPOLL (separate thread and separate core)
> - Threaded NAPI busypoll

The configurations that you describe as SO_BUSYPOLL here are not using 
the best busy-polling configuration. The best busy-polling strictly 
alternates between application processing and network polling. No 
asynchronous processing due to hardware irq delivery or softirq 
processing should happen.

A high-level check is making sure that no softirq processing is reported 
for the relevant cores (see, e.g., "%soft" in sar -P <cores> -u ALL 1). 
In addition, interrupts can be counted in /proc/stat or /proc/interrupts.

Unfortunately it is not always straightforward to enter this pattern. In 
this particular case, it seems that two pieces are missing:

1) Because the XPD socket is created with XDP_COPY, it is never marked 
with its corresponding napi_id. Without the socket being marked with a 
valid napi_id, sk_busy_loop (called from __xsk_recvmsg) never invokes 
napi_busy_loop. Instead the gro_flush_timeout/napi_defer_hard_irqs 
softirq loop controls packet delivery.

I found code at the end of xsk_bind in xsk.c that is conditional on xs->zc:

	if (xs->zc && qid < dev->real_num_rx_queues) {
		struct netdev_rx_queue *rxq;

		rxq = __netif_get_rx_queue(dev, qid);
		if (rxq->napi)
			__sk_mark_napi_id_once(sk, rxq->napi->napi_id);
	}

I am not an expert on XDP sockets, so I don't know why that is or what 
would be an acceptable workaround/fix, but when I simply remove the 
check for xs->zc, the socket is being marked and napi_busy_loop is being 
called. But maybe there's a better way to accomplish this.

2) SO_PREFER_BUSY_POLL needs to be set on the XDP socket to make sure 
that busy polling stays in control after napi_busy_loop, regardless of 
how many packets were found. Without this setting, the gro_flush_timeout 
timer is not extended in busy_poll_stop.

With these two changes, both SO_BUSYPOLL alternatives perform noticeably 
better in my experiments and come closer to Threaded NAPI busypoll, so I 
was wondering if you could try that in your environment? While this 
might not change the big picture, I think it's important to fully 
understand and document the trade-offs.

Thanks,
Martin


