Return-Path: <netdev+bounces-211211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA98B172D0
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367C43A47F2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C5E2C1592;
	Thu, 31 Jul 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="r2LmZWYg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2058.outbound.protection.outlook.com [40.92.41.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D92264AC
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970810; cv=fail; b=ap5YjEkAn7kl0xQsbZhqEnlTXmDTu0EWRNlxMBc3N1S9cwJR6PCYy8PNMhjZuDbrFaMS5FF4r2YYHizXs2EY+0XkT2ysxshzt7YcWf5VnrG54Cx9egZ+bIEirq57kbaCMMnFDLxHArYAmmXpEiGq7BItnr8o6NFW4ATzBCMNTyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970810; c=relaxed/simple;
	bh=yF/yfQOZllakARmgBf3mVAqtkhw2bncVba5wrxRczo0=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=iJqR1BAPLpU55pQrC8yNiv+852r4wv/S+dQMTjGLw/R6xcDOKUav0bB1DbSrzghoT7k8I/0zodDws8sQOj7r3BaDTDZCr1Tf6l/5vw5RVh3VX5D9/pVWbYdkBc6iIJbywaVGyaPmGIjAPL+AKIGjb/cB/gNK1ZxlWL7URrABwR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=r2LmZWYg; arc=fail smtp.client-ip=40.92.41.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgbUU3nKmKhDf8Q7wdLTABWw1ysXrK7V6p/uAtDjVds6g07HpV+V+oAp7xB1K/6tzxGC7wsUI5cF+vrS1de2L1PR9NgNNHL2J26TBNEyfTjumd5B7jHEpRlN1x8d5aHqRABokY/sQTo+PJv7dfGFYWdwne3GVZbU+V0wQmcJ23+DwQ4qjrxzCi+mga3m4dP6/j/67oX4ac4amVFySRTibyAIWdUHjxFUFIg80zBhm93OedaWZbNQGHqk4JmIr0fYUEnEfQAF7ZxVCzuRQKaxpYm6NMH/4Vn4g2VVmevgNRKJ3bygOR5rA12wc9vTn+7tspBvC9oZAN4FEs7O2OgCtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xua2M9XOOp+c5NmZz4QROXZiAynCPmFfAqfu419L1QE=;
 b=Bqk+2jwxCGND17CJghFmlmzZVZt5lFjyxNk+Ej9bv++/UJuzR0pIuOJc/c0vFhGuv1jc+oUGrb6GkGBDxtZnIy306OXgwreM4yFvBGlqyHwQcNlpNILvlQ5JdeNobMRxSXFdO62ySxUJE7Zu3IfSFyeVgIdliJtwgZYElaVWqwU31o7gfllLvhfijQX6r1TLCIz2A9RzEOSNCAo0B4gvqyXW9SiI4bpYuQZH3MhJ0N/vh6688Q+BZoU44YcqT5p9Qnm6mqCschc8MBylV0WAGgKBOeSctlPptfg1AA+XOZXm7Qqi5vD5eYQU2xLuvkK5w1YHg41lk97ri84RrpcA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xua2M9XOOp+c5NmZz4QROXZiAynCPmFfAqfu419L1QE=;
 b=r2LmZWYg+Gp2/apJcTxOPVGB3MQk6PO/TckQ6bWWKQqhHxhaShAlc8HQewhuWSqQsKSsXzbxUDEVyfFBH+6NeFzhJava1SGpTJ1dBPJzESqmVrDzQPYYCWjns2p1ZSNtrdU78wGLo6FjGr/lld4L3FgyC6Kl6BSaPxDuSnqIyHlvsoMfuPO6Ktl5iGFt43qQiJsi9mPQJeki12R1vHJDdobzxEK5nQ1PMv7uOgFaicbbQ5A8jJPdBROkToVl0HvDmVwXN7tcYBpwlmEYOTTtToxTanK+7OWWOda2heGu009tyCjyQVBYjLM+1UroZAP8FQ8VGIOk5hZP+GnITzRL3Q==
Received: from CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e0::12)
 by PH0P221MB0686.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 14:06:47 +0000
Received: from CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM
 ([fe80::d72f:94bd:4550:e685]) by CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM
 ([fe80::d72f:94bd:4550:e685%6]) with mapi id 15.20.8943.029; Thu, 31 Jul 2025
 14:06:47 +0000
Message-ID:
 <CH3P221MB1462BC768A36BFE9E37E2CB6D327A@CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM>
Date: Thu, 31 Jul 2025 10:06:40 -0400
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Dave Hill <davidchill@hotmail.com>
Subject: PATCH: i40e Improve trusted VF MAC addresses logging when limit is
 reached
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0328.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::20) To CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e0::12)
X-Microsoft-Original-Message-ID:
 <dd0c3b8f-fdfd-4418-a19b-952869c119bc@hotmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3P221MB1462:EE_|PH0P221MB0686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc25768-8218-40d2-83ef-08ddd03b7c49
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwWI/ipfH6K//MLhOAzBuT06EC4ri4ZnsN11cZ3GGy2/coSYYZ4wxY66jROhOU7J1fQ955PAeDFW6glU90Kd5HqJNIsFAiBIfxdv5vO8lD7spuIZoc7GiKOiUAaR5+rMggOoYT5B0Qis6BMln+QiSXfa+Wr719gQD20SxuKo7IosJFB4n/msHGtV0+hvYmEqNtziHu/eAy2iD2KvOaLVFy6gAg4CW040SNNeGg4qhdttUzBh584CAi2YgelOTLR7Dssi6bo9S11zPrucenfj4BM/vXXFOi9eJo/7u0ux/h/EfDfaiNwf1QJwz9/C2zNjvKE4oAq23MTibELydJA1ddosClC0ZcfXRXXAJOwGuW02vkiClyKcdQt5lp03B4WxiEjyL+Sp9aXdyze0VWlm0DhWOJgk3DPXt1QVI2Vc7rrNo2mhiOdcvuxoeXMwEHXd7iLIsJzwxsOagCvBpHiM3SqNdt2g2MPkobpIc49sYZs/CnelwMBSzXkU5YTGvLGsA+OIJVbMd98xcOhVksGywzwF1BrllVidpWVXx/JRhdC5bb8Mq935t2sjSVqFbzvrsEGhrItRAkkNqE+vI7Wwrk1cBnzLoCERFNXWP5MR3+U078ww4xNN5p2FAOuI5oXOdjY9bUNb1EhnGTrmmKaQIO84blxDk+ykwWrPQvo4DkLxg/6YiegMTzpdgaQMmK1A+fksWm6FoO+bax7DNXyjIwW5CdSUAW248WY3LZ20W55dF5xfcFi0aJMYwkVdweDxMO4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|6090799003|461199028|8060799015|19110799012|15080799012|41001999006|40105399003|3412199025|51005399003|39105399003|440099028|13041999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEdZQitReXZWbHRiK29lcWVRR1lWMkJBRmxnQ0l3bWhVWHRGSUpPZEFPU0ZL?=
 =?utf-8?B?SDRmWDlCM3JBZ1RlaktlajFGeURsOWhucTRZVmsxUjBEalM0QzVLNnNLeGpM?=
 =?utf-8?B?ZnlPM0w3NUx6WUpFN1FvaXM5aVRFZGxCK0xkQlFWRjh5VDA4aXhtWnJTaHZM?=
 =?utf-8?B?Q1d6Q0ZKMHIzQW5LZWpJMnhXK0t5UlRJKzExT1ArbTcrUnh2Zk5reXNHdGZY?=
 =?utf-8?B?Y3FoZ3JFTDJ1dnduWktyQmVINFEya0pQbGpSL0pqZE9qSzBlMFNjTTVYdWRl?=
 =?utf-8?B?cDVmbEQzR29mS0tkYnV0dVpFRWl4SDFTNjQwdkxIaHZWL2h5SDQ2S082YkIr?=
 =?utf-8?B?emNMdG5UVGtMMkpEZmtETXBjeTMzODZDVkEyc0ZnMWRRQmZ3bVEyTEZqL3BI?=
 =?utf-8?B?V1lFb3FjeDNRNHRnOHBYM1JLOW5CcktueUdFMEc5WjhDeTNMYlNLck9PQzV6?=
 =?utf-8?B?WUFIV2QrSmphWUM5ZlRxMU5idWlnMjduNVpFbWlVdGZFK2xHbE5INTFaY2t2?=
 =?utf-8?B?UmYxK0c0eDAzZmRTOHI5QmNmUXZCZVJUV254V1JMTzlQaDlGZk56ODNZUHdn?=
 =?utf-8?B?YkM3UDA5eTJ0VGlQSVRWQVk3QkhmL3pZZmpZR3N5OVZNLzM5emdLOG42aWhj?=
 =?utf-8?B?aDJKL1Mwc2xHUlVVNTQwRW1xSU50d1ZzRisvM1VPWHl5RUl0T2daempRT25V?=
 =?utf-8?B?NHJ0eTA4cWtnUjhvWUMwY1k2RzBEZU9GS2NXclRwTE9aZjFtUDdFM25MYkpn?=
 =?utf-8?B?MnZ4L0dQTUdlK0twQlVpRTNVb0ZTdXExbEJ6VnlvTzZTVW5NRnpZaVE1YzJ5?=
 =?utf-8?B?dTB2Z1RRekdDWEs5cTZlRHRsN3RNVUxET0IreUtNYUdLbHVxQzZLRzFTWEdp?=
 =?utf-8?B?M3RYZC8wSHo1a1k0aGYyd2hMOGJpbDNIWVlPcFhLQU1QWDdnb0Jpb0tEdEhI?=
 =?utf-8?B?Q25XTTN1T0FUUGlRYjN1VDMyYTdZKzhRbXN3OTlqakpMMXJ3V0JaY0MvaWd4?=
 =?utf-8?B?YThSdGZseGhDRWt0TG1QWDQ4TzA0ZUVRbWVsTjk3ZzFYVWlBdkZwcGpUNzdZ?=
 =?utf-8?B?bFBrZS91RXROWmtQUk1INWUxRmJpTnNEaGJUd3pGRXVEQXhVdWNqT29rYzQ2?=
 =?utf-8?B?VUZ4ejhkR3hJdlErWWhVYlYveW04VWtWM3h0ZzEwMzdSb25oY2JjUW8zY2FJ?=
 =?utf-8?B?YzFXK3oySng3RG8zVHg5cDlHaHJRYnd4cmFrbHl6RXRjVmg3NXY5Zzlna01t?=
 =?utf-8?B?cENsVmthUnN3UXhadXNDWExjdE9NSmFMSk5MWHNtVTNCeStSWHJJTWpVYTV6?=
 =?utf-8?B?bzNwN0l2eGp0WXdOa01QNE90a0FJanc1eDk1UzVxYU9nRDBQeERWVnJQQUFB?=
 =?utf-8?B?TG5vTXRqTGltenZBRFBkaTQ3VlpIeUtqSFNTVnVIQmFyMzRUbFRhZ01iNi9O?=
 =?utf-8?B?czFWWUJybytZM00zKzFnVXVUSzR3WjllZ1JJczRmQ081c1hSaXNZMnJvNENE?=
 =?utf-8?B?amV5STRGSEREREtQLzNuaXgybW5EcGdJbDMwbVJLYkFJVzhBNkNKUmdoK25k?=
 =?utf-8?B?STdNbzV1dXExanFhVXBuWGxIN3RKY3VDem9jREorWUNGeStEZlVwb1dYTDVy?=
 =?utf-8?B?RlFPV3VaaXA5bityWm5MR3dncmlMUUJMSFVPMFFYV09LKzV1K2tMdzdieU41?=
 =?utf-8?B?bGJtcXBxL09XY3VUNW5UWXpua2JnQ3lzWFBhdFp0ZWRqeFRIMldpVk5NenIv?=
 =?utf-8?Q?W2ENjljRDI6V6SvZAg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aklFbzY4VVgxaXFPU0JYcTVnUTlRcUZNckVNTkFYNWcwL0g2YWVXNTc4VlFz?=
 =?utf-8?B?SXFLMitFTkI2U0ZNT2VMZkNVY3haMlo2d0k0TWdDSjJTVlRnOTkrS0Vha3Br?=
 =?utf-8?B?MW5LMlA1dkUwdzJKSzgybHF5aFdDbUNteFBOTWhldXB4VlFpajBrWEU5NG5F?=
 =?utf-8?B?Y0NubEFhQVhBdmJYT2xZbVMxTUIzcDVidkgrVnF0V0NVVnpsMzBsVU4xQk1r?=
 =?utf-8?B?S0draGRjUXMzTHQvR29hUk1pU1UwSzJ4TnhUOGRBR09FS3RQTWQ4blNZajJP?=
 =?utf-8?B?SEtrN1lFYVV3eWZvaE9YaDZuWjcvbUw1MEE4RzdJMjF1ZGYyUjNIZEhvYk5k?=
 =?utf-8?B?K1ErR2JlM29PSjNlbVRuRkpOaEg3OG91VUJOVmJmZmVNUmRwd3FCbk9tNEJ0?=
 =?utf-8?B?WVlhMmhxejN2eXM1TjJncUF4MnN0NWg1Qm1YQ3ovVXNubnNiUDk4QzZ1RFAr?=
 =?utf-8?B?VXdvYTZhbDRCVjZxYzZycHFIa0J6dUxzUDJidGxheXpRcWJja1o3Wm5lOXhk?=
 =?utf-8?B?KzBVOUFzSStUTkVNL0MvKzRCSnpjTEhheEZ4aFFVdnNLZm1zNURyT0NkOFI3?=
 =?utf-8?B?WXZTdU14OVB1ZW5zZktQRlNZRUMxNXVBNmJaZ2pDQUZXVVFUWFBxalB5UlZS?=
 =?utf-8?B?YWxqNklJRWd6OXZKcTRLcm13dXdnWk93N1AxVFhnWmVsbkFxLzBOaTRDVWVp?=
 =?utf-8?B?Y3ViMnJUMDZJdWppYkF5bkc0MzR1SitNZkU3U2ZEMzlvcFJpbHFWdkd0THBs?=
 =?utf-8?B?WGlMaFZ6ZHV1UndPVUsvR1ZpRW9tc3RnWjBZN0pBZEllNVFFMjJMSExqNjRY?=
 =?utf-8?B?M0NUWXVjYmQ5UFJ6SFlLSGdQS3Y3NEVGdXBsb1Evcnp0M3pyVWJxeDJOdHZr?=
 =?utf-8?B?Mk1Bd29YbEErMy9XcVFqcTNLb0EwTksrbDhFcXpBei9VNHI0VUQ1RlV6aTZl?=
 =?utf-8?B?NDNGM2VFajhjM3NJT1pybzRDZDlVdGpFNlRpMC9EU2tFQ0p5bkdtdkQ3Kysr?=
 =?utf-8?B?bjUybFBTODNlV1FnMS9jcHFYWEhONWhxSzczZFdxTm5WMm9aRVFwUzg5cmNx?=
 =?utf-8?B?U2cvYlh6amYvNEN2SzRXUUZTeWR6MTNOTkJIOUJzQW9KVDlvRVRzMDl2VUlM?=
 =?utf-8?B?ZWxPUXB0ZFZIaGQ3L2gvUFdWdGFNbEpORnp0cWdKVE1Od1pEZW5yV0dqMHRt?=
 =?utf-8?B?QktUZDVQOXBYak1iVVdjYm9URHZBaEJaR0pOeXVUbW9ZRkFVK3VMRm9ydHQy?=
 =?utf-8?B?T0xBUEV0OStXRTJxN2ZUaUJsMGdsUlI2Z1dKMG93d0EzMUpIKzl6UkZNc3cr?=
 =?utf-8?B?Q21rdW1pS0NtNVM2ZHJMSXF3YlR5TjRVcTMwclFKNE56bUR6ZE5oK3B0ditx?=
 =?utf-8?B?aG0yWDIyN0ZDc2dzY2I0azNuUDNJL3VSMjBlUjJQNVdqejVmenV6WlY0NFVs?=
 =?utf-8?B?WjhpK2VtaFFxN3FON29iQk5NTTIraHJwNE5xL1dzRHpISHBUaWJES3hpZGVX?=
 =?utf-8?B?NDFoTlUwK0NKUEVSZXF2a3gzdzNJMFhOTnVmemhpdUhId0N4Um5pSThSWW9O?=
 =?utf-8?B?Tys2bFcyUWFwVjE2V3VQTkhJam53Zm5vaUV2YmpjeTFlcFVUa1ZKbDc4RHYx?=
 =?utf-8?Q?1KJ2SVLpK8GTZLYpjxmjn4vxliZOEZRwilsUCG80QkjA=3D?=
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-4c7ae.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc25768-8218-40d2-83ef-08ddd03b7c49
X-MS-Exchange-CrossTenant-AuthSource: CH3P221MB1462.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 14:06:47.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P221MB0686

From: David Hill<dhill@redhat.com>

When a VF reaches the limit introduced in this commit [1], the host reports an error in the syslog but doesn't mention which VF reached its limit and what the limit is actually is which makes troubleshooting of networking issue a bit tedious.   This commit simply improves this error reporting by adding which VF number has reached a limit and what that limit is.

Signed-off-by: David Hill<dhill@redhat.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c 
b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

index 9b8efdeafbcf..dc0e7a80d83a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2953,7 +2953,8 @@ static inline int i40e_check_vf_permission(struct 
i40e_vf *vf,
I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,
hw->num_ports)) {
                         dev_err(&pf->pdev->dev,
-                               "Cannot add more MAC addresses, trusted 
VF exhausted it's resources\n");
+                               "Cannot add more MAC addresses, trusted 
VF %d uses %d out of %d MAC addresses\n", vf->vf_id, 
i40e_count_filters(vsi) +
+          mac2add_cnt, 
I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs,num_ports)));
                         return -EPERM;
                 }
         }

[1] commit cfb1d572c986a39fd288f48a6305d81e6f8d04a3
Author: Karen Sornek <karen.sornek@intel.com>
Date:   Thu Jun 17 09:19:26 2021 +0200


