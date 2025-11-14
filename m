Return-Path: <netdev+bounces-238654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91825C5CF32
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C95B3B0E02
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 11:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F05E315D2C;
	Fri, 14 Nov 2025 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="sWUpRUzF"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021093.outbound.protection.outlook.com [52.101.65.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF93315D5C;
	Fri, 14 Nov 2025 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763121265; cv=fail; b=L2AnKckjBGCd8j5Ur7RYEMaJG/s5RwcKbdlglkV3MONqFcqS3eh65av7sH6pUuKNtsHyDetVi164AdUo1ScfFbq0izpxGaU92I760xwGieoIPO5FJAXgFPVtDbQovBWLywa4ZiyCV+hHpfdnnx4tpHIqeHnssac1moBFi4ijUoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763121265; c=relaxed/simple;
	bh=W5kfKFSUDKBJyBr3QGSh4jSUO9pqoLp3ZRhVuvL+Q90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LXaM2RG4QkhGbAi+cWeO+art8f8dVkKetVzdJWw0aNHuDnz68wJFAYViF8kuWbdz0UHR668af1TIt0h+sfRVzbaUx4s9vxaKoqVZRNXy1kj/JnNwUoHfn0Z3J5mo/u9OhKUWdPS7gI6e2syGeBIsh0xZ/ZtO+ccFh+aY8bHQd/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=sWUpRUzF; arc=fail smtp.client-ip=52.101.65.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl1T6I93JCWImWOfwo5kPShUmXhYGjIpyUdzuDHSHPNFLLWrjuwTXirQG+h8Ye71a9x3BYQoms4cxuas+7+XYaRxrWgjJNEV6ns/rh032CVTwQuTw1uNhDq67VF2ccp9o0QtP7JemcAmI4Bf3iajssZSokSIFHhHvS6q3nTy+lUSpTX03v2BGsSqxPjSBOtUhmrigOtq3ndu6jr++vFutb0AoF+ZMIMeqS8v7SEAeC7ViEs6kcFIPDiTk/z+IwNY9iAsbXdgWFdzM6E6h15CtDdqlD2Vyhn+rxMWgkHzZWAg9KJawEi2b8oQQietP2L+JmDdfMvuWhpYc30fs4W1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeK/OrzVewb4yujlkIWrXHD5EgraSbiSwNzCaVaakQQ=;
 b=NXDYqERWN6r6fAuufndKaPflJou3p+fEeSobw8S4XE2VkoywWyxLBz/rv6fN14VYXMdnqQi5toZpAcl7MFMu9YA0PMNZzRSgfr9tVvz0gR6z/9V5qOmu10GDZunond2QX3h7LJUHHtGSic+/2DVSCh1SFXSqigz5LCvTLvYoXbFKNPePszSDSZsPGjcbI8+7CqHzhu7D31c3O7Ewr+qXn+5L5f7/bK2jHvwbKtnNhl5cr4viTf/0kd6QHFgx8Mt19oknWR6MnvWtWyNkwcGBg4/BIXtsGqU8UrDfnXx0fO9DpQepjmPh6yvSMOsz1UE+tZDJxFGWYZKkHv5ZzjhxPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeK/OrzVewb4yujlkIWrXHD5EgraSbiSwNzCaVaakQQ=;
 b=sWUpRUzFIC7AMxk2NUGvyqfgajPviNXOhh3FkJ0rNtV+Qu7BvLqJ4V8n7N5ushh1F8ZZq5eZIj1g8NPIl4xwYcKBfWt85MBD2/GO8feBYx++SuT8PO+XGpsCHTraqAA8yDOquxIFAChD4i4DbXTL5I1vTbGWt3a7oA74L4DL+Nvq3KIskcWsCy8nBqGIx79mBFyDtwTfLKKwZck9sHd3JtTWDXTAAstpzR0Yul3lPfH5pMsRxhtuB941yn3u25DR8sk6puwZTfh433CHTKVOtR1o0S6BYWpA3tX6W4JV3d+HcfBbl/Zcbdi+6aa0+wVazlBBzsn2jLA9zntOXi0+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from AMBPR04MB11741.eurprd04.prod.outlook.com (2603:10a6:20b:6f3::7)
 by VI1PR04MB7023.eurprd04.prod.outlook.com (2603:10a6:800:12f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 11:54:16 +0000
Received: from AMBPR04MB11741.eurprd04.prod.outlook.com
 ([fe80::c39b:dab3:ae88:c5ba]) by AMBPR04MB11741.eurprd04.prod.outlook.com
 ([fe80::c39b:dab3:ae88:c5ba%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 11:54:16 +0000
Message-ID: <0437ae6c-b2ec-4883-90a2-d83d280f9f34@gocontroll.com>
Date: Fri, 14 Nov 2025 12:54:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: fix doc for rgii_clock()
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251114-rgmii_clock-v1-1-e5c12d6cafa6@gocontroll.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <20251114-rgmii_clock-v1-1-e5c12d6cafa6@gocontroll.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To AMBPR04MB11741.eurprd04.prod.outlook.com
 (2603:10a6:20b:6f3::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMBPR04MB11741:EE_|VI1PR04MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: c40cdf14-71d3-428d-6c5d-08de237489a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1FRbHUyTlMwRXJlbFM3eTAwZU1uTzFsWERZa0gwaFdISGl3emtkRDRxNkcr?=
 =?utf-8?B?ZnJtaHhRU05rblVHUEFlZy90SnIwczNtQXFVQnF2STNXOFIzTlBQOTRsVnpz?=
 =?utf-8?B?N1RXRHVTMmYzVEczQk90RzNrNVRwc1JtRitMa0Fjc2ZTRGFGWjRkM1RsRUFR?=
 =?utf-8?B?SVR2dW1nQ3QrZlp6amxRQy96bC85TUk5cEhkRnRBei9yTURka05DeFBLSU9o?=
 =?utf-8?B?OUlmV0Z4SVN5VGdadXNWTWxiWkFzSjRkV3hFYkpPNHI5MzBHNFl5UTZMdml5?=
 =?utf-8?B?ZmdHbnhnQzFxeFdJcVFCVkVoSXpMcmxocjhtUU15SGc3QUxKckd4QXN3YThX?=
 =?utf-8?B?NVlwdTNCUWdybVMxV05LbGNKSmNWemZXNndqQjE5Rnh6U0dmOEloRTl1WllS?=
 =?utf-8?B?YUxYNTM0Q2piek1WVGk0dEtHZ295V1VORXhqNHB3djB0Ym1KYmhLR016N1R1?=
 =?utf-8?B?WjVsZFFzMFoyWThuTVBWa2tUcDJ3OERmbmpEVGpSWC9WZzRPZUY2T0RlaUNa?=
 =?utf-8?B?RGxocVBuM3NxcEZhSWx5ZWlYRmdIQ3A4aWhzbmtVYzQ0eEZ4Nlp6MXY1RHha?=
 =?utf-8?B?YTJaalhaY2ZYSjYvMVpVamdxN20wd2dXUG9sRVNqUXkzSk1LRE9tdVU5dVFV?=
 =?utf-8?B?YVF3ZHloMk9Oc0ZtbGxuZzhMQ0d2L2ZLWlpvNWhEYm1uQ2RUMVBEd0dRWk1n?=
 =?utf-8?B?MFVnYk9FSzc3QzhURTJFQytYam9DZ0hOMksrN1hzYzJBaS8ybFBLQXhIcVJN?=
 =?utf-8?B?SzAyaCtaeE1TRGRndnhab1VyenZSRndISEVXWEdaUGVhY1RPYjhjMU0xb3RM?=
 =?utf-8?B?T1I0VVIyNllDRFgreUtaeEZUUHJlc0ZWck5vdXNBYlNKVSsxOEcrcVlOYS9M?=
 =?utf-8?B?Q0tPQlVmdHU1MTE2M3JKQlFQV1E5WDlkQnRibmF2SEZURUZxYnJxYlJlanlW?=
 =?utf-8?B?SzdZcDZOZkFFNjVqMG1ZMWJYUEx4T01oci9RNTVCSXNpaWZaK20wZDFkanhI?=
 =?utf-8?B?VEY4TXhhM1NRd1RjWXZWS0Qwb0xYSmNZZ3dvTFRHaHRReTI0TitXME1ham82?=
 =?utf-8?B?VmZXdUNiN3V0UkRDSUxpNElIM08rcFB0SDg4dlNpN0M3Y25xMUpuSHdMUVZi?=
 =?utf-8?B?dXo4d2tDU2dQY3FZam14WFRYRkVyUmdSZHROYlpUWXlxaUlaOE96VldNMkEx?=
 =?utf-8?B?WkpHWTYvTURvY3BwK3k5WitOT2hTbEdTejc4dVR1U3NDR1pVOEVUa1ZrN0VO?=
 =?utf-8?B?RmZYamNsRHdaUGtnaEdGNm5uaHUxeExxU3VUYVRGUXo1aEFqVW55bHZaM0tO?=
 =?utf-8?B?Mi9ZenNKb05EVk9FcUZyRXl6MmpNYVlCbGFYM1h4TWV5VGFrMlpienFaRDRy?=
 =?utf-8?B?VFhlQkpFZFZDRVZNSzBvUVV3c3F5M3hJbjJuYU1FaURPeDgxU1EwTlljQVhs?=
 =?utf-8?B?YkdFUzBiZ3RnVDdPZnVBakdlc2thWHV0dGtGL2x2YnNCaVZWeFRVcDB2Q00v?=
 =?utf-8?B?ZUNkOURkblVqQnFCTU1ORTlPSk1CSDNLOWZ6MVJ0eVQyL01HZTNVajU5VGlx?=
 =?utf-8?B?bXY0Z2ttaG1hSHVQN3d5WVNBcEczKyt0MmI3VE9wTzFYbndYZGx1SW9YTTN0?=
 =?utf-8?B?dWxxN2NBdnVYSTdNaFNuM0VwTlowVm1WRzc3SjdCTnVOekVIcm8xMVRpYktX?=
 =?utf-8?B?a1ZQWGtLaXVkQlRySXAyWTJzM3NHYVVXeCtGRkdUNWtXUG5PaVphT1VYbWF3?=
 =?utf-8?B?dit3L2Y3S3FqVzlIOVFSR3RUbzZBZXk3MWg4L2xOckl4MjA1K3hIWHJIM0t0?=
 =?utf-8?B?RjlPZFBuMUdqa0RnRS9qV29nRGUzd2hkcUN5VE1rQ0V3cVkxcmNxSUI2VVNs?=
 =?utf-8?B?enVmU2I2SmxpT3A0NFZqYTRaYiszbzdCVE0rMm12ZlloVEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR04MB11741.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhCVk04TFAyeFZUbFI5QmRCTkgzaVpVVGpwUG0rc3NoTUxIaG1UeWJWbTV6?=
 =?utf-8?B?eHlTWVlGenROUXNTeTZsZ0RncGFJMXFuKzZYM2VyT01oTTNMa2pNaFN6OENP?=
 =?utf-8?B?MkRzZ2xlQkI3SHBjMlp1am5uU09UZTRwKzU4YWd4TXVab2ZTNEg4bEhFVVJ6?=
 =?utf-8?B?Y1IvcFJhNkRtd3pteGlOclFEcVhVOEFhdXRlQWowYzdPYnN4SVovcVZBMUd2?=
 =?utf-8?B?REhjdFJIK3VwaXRaRm1HUUtubVNkeXZJcHpzRDhNUTUwYmhNMm0xVlFGYUZJ?=
 =?utf-8?B?eHdYSHhWcG5iNzZLT1ZSRVhkQUpNdW14ZkpaUFZpY3N4NjZ3YUh3RWlUN1ht?=
 =?utf-8?B?bDdDazVROHRpNDJHaDllNkUvSUFVekNIUjJLZWRaNzlHM2FTUVMrb2VHR3Bm?=
 =?utf-8?B?QklmankyL2huekxuQ0RNcWNwdnNEdnQvK3B2ZnpjbElKT25OclIvUGowRDZ0?=
 =?utf-8?B?OFMzOGprajF1WG1aVi9vLy8vSmR1dW5LZDZwLzkvMUNuV0pRWklPdFFBQ1Va?=
 =?utf-8?B?V2FkdldaQStrdlZhSXZUQTVEaTJGK1FvdU5iYk9WZ3NkOVAweWwrUHFjclhG?=
 =?utf-8?B?Wnl0cm13dXJ1aXczSzN0d2E5ay9JOU9ldmpKN0xRNTRnTHZ1ZXNzRG9ySFZr?=
 =?utf-8?B?UVRHVjNqb1hyK25DNHpMdzdqc0tUL3pucktwOTJibDMwZmpnUjJTYmFMZWdj?=
 =?utf-8?B?bjk1Zk9UOWNiQmdKTjl3blB2b0lUQXNTd2pyQVRsWXdxMWYvUnl2MTVrSkZD?=
 =?utf-8?B?ZXZ6VVdxbHJmeXBiTW5GbnZqQWg5anh0MXZIQml3dnF2QkIrLzB3K2puS0tH?=
 =?utf-8?B?UHN3UFI2NWg2azVEeFpmckE3VHhxSzVWNjlxcGhrQzQ5aE1sQzR5bk90Y28x?=
 =?utf-8?B?Wi9Ia1JVdVNGTVJNMDMwdU93NXBEaUZBbkJsMy9iYmIwVGxEOUxScTkrdUtU?=
 =?utf-8?B?b2hGb244WDJBMmd0UUtqNmhJemVmOGVndzZCdCs2N1pCRW04djlkV3FaVVNx?=
 =?utf-8?B?OFdmVGdaM2E4cEJqOUVWYzg2WmkwZnhZTG1LREZENTNJY2VwcjUwRXdSMTJS?=
 =?utf-8?B?bTNrTnNrTXhPRWtCV0h6TG9aYTJIN1ZYbDR1Uksxa0JPV3FJYlhvTnBSTHZR?=
 =?utf-8?B?TWkzTVJ2a1lzbmMxWDRyWEs5dzlxWkM5YWl0YTQ0ejdzd1J2ako4RHFNZEU5?=
 =?utf-8?B?Y0FHRVljV2VveDlzRkc2dlUrY3YzZCtiTmJpWFZ0V1JMeVFuZ3dMdTd6aXNY?=
 =?utf-8?B?NHJFQWlqSzExZ2tVOU5jWFdVMGh5ZXBCZjkxOXNWZjhObTRRMzRJVmRBLzdh?=
 =?utf-8?B?QVYvRHNjNWtOYzJhUysrNE9DMS9QTDZaUXFXSHltN3Q3Y3VsR21XMlBMNVJr?=
 =?utf-8?B?RUpmaFY5enNlTStTd3RwVmZsemdWUFk1WnZvUDdTaVI0SlVyajFsSkdvcjdH?=
 =?utf-8?B?RFA2a0c4Y3NQRmdTYjFSNTN4Nmh4bnNieCt4aDVyL2x6ZlU3ZUdUWEhBY0NF?=
 =?utf-8?B?dmZsRmY5RXgyOHg1bllSK2hzUUJSSFpETGloazdqQVVXb0VZbHBIb0lOQUVj?=
 =?utf-8?B?VEN6clVLeTJ4YzNVbkp4d292ZHA4RG0vZS8xZHpXL1FWbmY2dlRDZGp6Yktw?=
 =?utf-8?B?MTRJUzBLNmVnNjJKVDhrZWowNytVWWhWa3NNZ1QyYzVDdFE2ZVVjeXVmb1pp?=
 =?utf-8?B?Z2JsS3g0aGEvUmdpVmVGZldlZDJvK3ZFNTRNRTdmRndIYUkvQU16bzJGVDVQ?=
 =?utf-8?B?UG1ZUFZBKy9paGFxQWpYM0ZnbUJDRkhVSzgyWTl6QnpicXVMYjYwN2FyWHVu?=
 =?utf-8?B?YmxKZWlnN3VOcUY0bitrcGZkS3JjZ1lYa2J2MEZ0ZjNQT3hBYWcwRCszS2Iz?=
 =?utf-8?B?TkJEclNoUmdWd00zSS8rMElCbTdKaGU2T09vaHB4dG11MzZMZk0vMm5kVlZJ?=
 =?utf-8?B?cFJ0WU1nRUZQVmdtVmxHTjRNWWE2VTZQWGlyUEFDRU1TRm55bDZXNDlkbmJ6?=
 =?utf-8?B?eCtrSW9LWHNCQVorTTdySytjOFI5RFpoaGJQaVp4MUNYN2p6bXNXbGtlaTUy?=
 =?utf-8?B?OXZDOUxzVXVOQ3Y4TGliZzdFV0hOb3FWZEJtci8vcGl5MkMydmxQUjNtSTJ3?=
 =?utf-8?B?bVh2MTRHZGFtN1dRei9rTTZkNkhuc0d5ZE9oUFZjK2pRL1U1b0RlaVRwOG1s?=
 =?utf-8?B?R2p2YVlCUno0VXZWOENrYzNoTy81L3ByNEFma29JUi9OVDJyWDlTUHVRSktI?=
 =?utf-8?B?d3pnK1lIRlJ3NDFGcXZ3d0IzTEdRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40cdf14-71d3-428d-6c5d-08de237489a5
X-MS-Exchange-CrossTenant-AuthSource: AMBPR04MB11741.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:54:16.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7zd28xIj3CL/jNgyE/lEPdyCe1cMZWh/TkOprFbeTShxOvA2pKrR18vDw9JoYTSMDL39IdZh1wk1bA1BqWUD9xtaYg9Hkh5SAs0fp9GqAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7023

forgot to add fixes tag, if it is needed it is:

Fixes: 91695b859263 ("net: phy: improve rgmii_clock() documentation")

Kind regards,
Maud

On 11/14/25 12:39, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> The doc states that the clock values also apply to the rmii mode,
> "as the clock rates are identical". But as far as I can find the
> clock rate for rmii is 50M at both 10 and 100 mbits/s [1].
> 
> Link: https://en.wikipedia.org/wiki/Media-independent_interface [1]
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> This patch is also part question, I am working on an imx8mp based device
> with the dwmac-imx driver. In imx_dwmac_set_clk_tx_rate() and
> imx_dwmac_fix_speed() both rmii and mii are excluded from setting the
> clock rate with this function.
> 
> But from what I can read only rmii should be excluded, I am not very
> knowledgable with regards to networkinging stuff so my info is
> coming from wikipedia.
> 
> I am adding this exclusion to the barebox bootloader, but I am not sure
> if I should also be excluding mii as is being done upstream.
> ---
>   include/linux/phy.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index bf5457341ca8..e941b280c196 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -296,9 +296,9 @@ static inline const char *phy_modes(phy_interface_t interface)
>    * @speed: link speed value
>    *
>    * Description: maps RGMII supported link speeds into the clock rates.
> - * This can also be used for MII, GMII, and RMII interface modes as the
> - * clock rates are identical, but the caller must be aware that errors
> - * for unsupported clock rates will not be signalled.
> + * This can also be used for MII and GMII interface modes as the clock rates
> + * are identical, but the caller must be aware that errors for unsupported
> + * clock rates will not be signalled.
>    *
>    * Returns: clock rate or negative errno
>    */
> 
> ---
> base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
> change-id: 20251114-rgmii_clock-1389d0667bf7
> 
> Best regards,


