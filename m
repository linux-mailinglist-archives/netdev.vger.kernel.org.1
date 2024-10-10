Return-Path: <netdev+bounces-134303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21039998A82
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433431C24912
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 14:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD831E7C08;
	Thu, 10 Oct 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="onpEUy1H"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DC1CF29B;
	Thu, 10 Oct 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728571422; cv=fail; b=gvUb6ZMXzDyWqYLKO7DDNOJvhnp+v2jGUVQRqGds2T2NIGbrDaMOZqnv8jHEqFkyC3jfKvJJ/3f1x+DPRDwL8OiizxyLh+7X66xuiDbtn9SKkhimMVoeGzpsWqDWV28sGq4So2VACtSf86w1ifa6ETpZea8z0JSgy1Z/AR6kSxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728571422; c=relaxed/simple;
	bh=beGA/mZS1QC6k0DKEFpc8R0XHmTo9tVR2WIX1kx8TGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IYss6kWK+r42Hw9oEnz37C5cofJbqZStlQ2+dnKPGtDgcBB26MWg8O7uXZzRWo8aBwl8lWBil+EW7bOtKH7uPBLfilt+oWK7FKtCKMguBP44FpeW00VWANDJC2HzJab/UHy/araMQ37Xm7c+H97I5Vr90lM2zFr2rc8V+JEt5GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=onpEUy1H; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mSc+2b9XXWjcKKq+osoBrBv2sXRn3+kGtvYQZy16Y+3cmRLQ5ev8YjtGOKanOaYlzVlyfmBM5i1KPc+615NmLW7dgMUqGRUZIZgcyjKkCFCb71F/W1muQqt1GWDbMpkLrIFvtNeeRnLCHUg0cc8fQszK8znVBEj6h8exF40762c/u+DVaZr4cMqO7KwA/rxr3wj2t/hGE+g6cMjzQ91LhUlESqKdFj3KFYZ7Dtl+a0LmcHVP1W9zS1EFt3qpXS2g0Ij2YJS3te0YKVxjZNObHLuQhH5r9F7hA9FM3qw2+eyXsOBLN1Xcgq8PYU560NA+2m1R96zaV//AphEniTWHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6p8L9tQIshxzQ/jkMkyeeckr7g4eXjzANQewg82teZk=;
 b=eArIAR+18uUP8THQrlsp6JiNe5QzG7iIAMxBSPi089LcsgSfsvHsZnQ+0eYH/2lLLMGT6x1YVtdt6axC8G3LR0Io4bSnEPhV8Y3ORQTRVdpbg8mUXdSekCJ96SFRGvuXR05nB0Oe0l6zTu5FgXO+EXOKRblW/ctWDQQPVjt5Q0TJhd7Zg2GnLaIK5eUpz4jcM0KMHJw+WqvfGWVOwX+UjMz73FQrixwEY+4pJ9jNBwOLIcz5GoqsBSDVy8w8TyjaCVc5pGwfk1H+SmaDsGuntkl1zGBVG6yqspqbKIlrrXJr5164BRE+UjUq8IyMSLGD2jSXLc+gQaW4bAfqnMA0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6p8L9tQIshxzQ/jkMkyeeckr7g4eXjzANQewg82teZk=;
 b=onpEUy1HpEc4Oe89RedjyErUWC4piE6sblRLb/SSVr+zGrHZjBSU6NGb2DbdhFpl2LxsgE2kg9Co5SwWWgCx8oQ/xqk4uNoxskJaB001H662NgKgsVYFUvPWdwNLCVpMGijENY5WM0D2Hif6OjyeAZYBCDUD+u69ygQLWXRQYak2Grf9nEfZT24IIPnjL+6foSuODuxQKMg6FHYy26mrfmpxTruK6yoBWp4ztDrOVXCw8NA+V5peJig2+HIBghockndFFl3t+9RaFbkwaH5Mr9+wtQl/09Zw0QyEDF740XdI8zLvXnd9whPcZFWUGs0UCKcg9Vian8WBPDfgT5bWyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DB9PR07MB9008.eurprd07.prod.outlook.com (2603:10a6:10:3dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 10 Oct
 2024 14:43:36 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::6b9d:9c50:8fe6:b8c5%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 14:43:36 +0000
Message-ID: <aa10d178-3421-4759-bac0-2b187255db6f@nokia.com>
Date: Thu, 10 Oct 2024 16:43:34 +0200
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
Content-Language: en-US
From: Stefan Wiehler <stefan.wiehler@nokia.com>
Organization: Nokia
In-Reply-To: <20241010094130.GA1098236@kernel.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DB9PR07MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: ac9104c4-7f11-42ce-df7c-08dce939ebcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWYzWXRvQUR5NUlDRnB2Ym1ZR0pFMzU5RFlJWEhiN3ZYRXB2a1FGNUxSQlJz?=
 =?utf-8?B?RzBWTnJkQW4xSmZUNGlnTStQT2pPVFB3WEFYMzd5OTlHS3VhN2xmNWVFeDI5?=
 =?utf-8?B?NlIxSGlxWGN4elphRG10Y2tHczg1UkYyM1J4WmRtZTVxN01QTWxUeWZNMkti?=
 =?utf-8?B?bGZkYXlsVXNNYUVNeDhSUVJZeDQ3QTUvaFJuc0RGOE8wakNhc253Y0t0R2pz?=
 =?utf-8?B?YTRSVmIwV2ZIYmNLQ0FLejJhOTk4Vk40M1ZkUzd2SVpuNzgrK0E0SlQrOFNT?=
 =?utf-8?B?cTIxZnNxODAyZEJaUWd2b0ZhdkFEY3d5Z3hicXp6WG0zV0JGSFdEcEk2b3Ew?=
 =?utf-8?B?ZWtrUktJS2RHTk8vZUw5NGF0TTQyZTFUUmhrczRxSWNLRTNoeW5JZ1JvZGRK?=
 =?utf-8?B?VkljNFJ0SjlOdXRxMGtpQTFWNEh4a3pUWWMzdnVSbmdMYTUyZHVDelVhcHRo?=
 =?utf-8?B?Ly9RUDVIOW1iUnVNYUZvY1Q4SCtnb1gxajhpZHBpZ201c1g5VEVIYjErbXBJ?=
 =?utf-8?B?WEhIcU1tb0Q2UjJPajRGejFvNmc1N0N2dzdjemgyTXYxTWVFY3ppczZZRlBV?=
 =?utf-8?B?SU9yMkFhY2V0V0plU01EbncvVG03V2R6amN2bHI5RklOSUJTODk4U0N0M0hm?=
 =?utf-8?B?UE5qU1VHa21adm9mTithbGtPMDJ0RTcwU2U1WU1xSnBSSnBWbUdTaXRHUzlK?=
 =?utf-8?B?TTc0MjhtVGNGWE91NTJXWlAvbVUzQXRHTUNRTzZPMFovdEpwRnpoV2tiR2RO?=
 =?utf-8?B?T0JjSTcxV25xUHFBRytsQUFQRHJUY3BwdTJJUU1WdW13K1EySG03eThhMHU4?=
 =?utf-8?B?RHNFRFV1ZElhWERJSlh1OTl0OTNDTWY4VHhBWWZYdys1WTljd2lYMmV4VnI0?=
 =?utf-8?B?SHpId3RsMys2UFpJUmVzbjlXN1ZSUzNzQjB4RTRQZmZOM24zOTlaOXFJVWtR?=
 =?utf-8?B?aVBxbGorQTdIZyt0SDlIbkhCb3lGcVhkUDdwa01KNlFzcFl5SWY0b0E0WFJo?=
 =?utf-8?B?Um9vMHBsU0tXcFVSWWdCSzFTWnBiTC9DOFBxMXFsWWorTnY2WDhrU2NpS0VR?=
 =?utf-8?B?UkN2ejdxR3kzS1I3elpEa0dBWW95YkdOM250T1Q3cmVXekNscUxuWXFrZmls?=
 =?utf-8?B?UzZwS1lsWExHeXBvQVBuSStPY2p6akZBNnVjQVRJWG9pRDRrNFdhVzNXMjRT?=
 =?utf-8?B?amVyUFY4MVBCaVZPeHRVVVc4ZzQzUXpxbkpQY1FSVk1yenBkdnpBeGpvNzN3?=
 =?utf-8?B?UVJ1YzF1QURsdnhLUDF2Vk9SU2dYQWJCY2tFd3RjRnZKZDIvek45OFhEOGI4?=
 =?utf-8?B?OTNOT3l1dkgvYVRlTG01SUJZdTUrSjJ3WkdkZFRhb2VCZDR4VmtJY0NTclBw?=
 =?utf-8?B?b1VscHVYalU3SmFjSk1QVWxwTlBnM21WQUUwdUc4a3FOclZDclNpeVBraUJ0?=
 =?utf-8?B?Vjlnb1lmU2xiTjgzc2NBZ1psRTU5UXQ4M2FHeTNKbWVHTHJTRmlVdElkSDRp?=
 =?utf-8?B?a3RSaEhRNXptNWtORm1hNU9INDhRRHhXcENES1grWXIxREh4Z1ViOS9sRGZz?=
 =?utf-8?B?UjZQOWlvTkNqa3NQOUtQeXFka25NQ0pwc2s3VExFNitNVmpQMnZrMGVUaVFp?=
 =?utf-8?B?UzBTS0lRdlVkWFNZODgyT25tUDVXd1c1YWdIdmdEWWo2ZFdSd1puUWdvZDh0?=
 =?utf-8?B?WC9sTzhyTEZqWDc3a2IwWFNuUVhUTVMwbDQ3enUzWmVobE42WnlXRVVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnZXbk9kaUQxOWd1UlBBU2FXaG50Z051NURlTjlWNlRqRWZlRUlWcENGWWNy?=
 =?utf-8?B?b1h4c2xYd3pnbi9TMXljZ2haYWVlSFRsNmV5ZUNBY3psNFJqREtHR3RBY3c5?=
 =?utf-8?B?a0VoKy92T3d3VzV5cXErc1pJa2NicnI0dTY2bllJMmtnemtjNldSK0pkQk83?=
 =?utf-8?B?NHIvMndoWUwzbkVZS2JsV2JHYlhlZkFESHg0V05UTmZqclNtVWlrZzg0OWNO?=
 =?utf-8?B?WVl5QUNNdW9oUjk3Tm5PVStyd0dtaUdKR0VtMUJSSEZPTHB2KzZXRXQ5VUxR?=
 =?utf-8?B?cGYrNU5sRGY1LytFQnMrUVlyNUVKbTFDRTlmelp6c21OYmZRRVp3Wnp3SGRz?=
 =?utf-8?B?elFWK3pIdVJNVmxTNUdCa3lCOTdvdlJ2d0poMzlzbzVlK3ZTM3lzZmVnMTRT?=
 =?utf-8?B?NXpIaG5IN1d1dFp5WlQzeFF6OG4yYmRWVzhTeEFBcUZvSTNEanpTUTlWcWFV?=
 =?utf-8?B?T0orbE5OUmx2cnlsTkJXWDNoZE9yMGlLNjlRcGJJVkZnQ2x6WW5kdDFyV1Z1?=
 =?utf-8?B?Q2FIWUkwdDBJM1ZVTWNDRlZUdlBxWEtvY2I4dkRKOXdDc0dCUkN0dUVRaG5h?=
 =?utf-8?B?VHVPcjBqbTRxZG5ZNnB4dHNsQ3BLUlJwUnlKYy94ZDR1Q2xsTTE2bGI0TkVK?=
 =?utf-8?B?OGtHTWh3SDlrWmlrMlZLSkRjK2JXSzhmSVQ1VVVBSFUrek52cDRPU2FheTVK?=
 =?utf-8?B?elh0RHc5VjhDMnlsU29UdWVNU2l6ZzExcVplR0VqQzUzUDhNK0pqQXpRaHBu?=
 =?utf-8?B?enlnTHJVa3dSdW1Hc2NJNDZDM1FEMVB1a0ZWTnRmbktNMFZvY3FSRzJ4WEVh?=
 =?utf-8?B?TzFJWkl4TlRLSU03U0tEc0R3NFZFbVJKZUJjMU5yM2hMN2VSWDZ2UjlXM2pw?=
 =?utf-8?B?ZjFUdG5RODR6V2o1c0p4bW1lS0luNkhPZTVCTVRtOFIzdStjM0VVcnpucFR5?=
 =?utf-8?B?SEVVekpJbVBlTkQyd3NiMEpxdE9zcmRLQUQ4a3loVTFiSjRwYVVuV1V2cW9U?=
 =?utf-8?B?OFRpd1pVbCt4R242bVhtb0EwaEVWS2xqdnVtd2tFdWdiUmdrMzFnRURvQ1kr?=
 =?utf-8?B?T2VrVVdFY0FjSGpJKy9BdGZuZVVvZ0FON0lPOXk1ZEJWUjZBVTNtUjFDcHVJ?=
 =?utf-8?B?ZS9oR09vTWcyQTFKci9Gb21jcSs1OTRvTVdMNytKUEYrNDZLeDFyQ0FlTVhB?=
 =?utf-8?B?Z0tPRnp5VE03dGFpbVVGcDdrL3RwTDkycG5DdkplZHlsbzA3cnFiNDZHdUpW?=
 =?utf-8?B?SzZrcXRIYUxSOHkvdUVpQkhYQ0lyaDIySXBNNzZORktMaVJmREVOZXdOdzJo?=
 =?utf-8?B?R1VuNnZtMEhnamxuOVFhLzVQcVFXeG9aY2RQNDFPTjFDQkhTUEM1dHZobWI1?=
 =?utf-8?B?bFRoOHI4a0xQTVNLWHp6ZGw3VTh2dlkzbU1GeFN6UmUyV2ZBNWtLTDBOVklO?=
 =?utf-8?B?aS83cjVyV2w0SVN0eS9YZkgxcGxERTY0VVJvQ1RMbGNoekV2MkhtWEVUMXJk?=
 =?utf-8?B?V1U5bU1NNE83VmlEWWsvcHBkeFhDMWc2aUlTR0srd0tPRXdvWndsU0wwbnhw?=
 =?utf-8?B?VzE2WFVmZDl3ekx2OTJMMDVVNnU5SWsxOGtvbm8yb3pQYzZ0MlpaTE9OcHNz?=
 =?utf-8?B?NWxIQUhCRkRyOFZaYVJGQlppRElBZTNOOFBqMlpxSStoTUo0Vm41eGJ1MDFo?=
 =?utf-8?B?VXhadnNrZXRBNVJWUm9YaHQwS2dEbHAwQnBJVG5oYzY1Nk5rNVhkSWpLdHk0?=
 =?utf-8?B?RDV3Y2gzZlJGVVFHMXFrRE05V0JqYmhCeUtHVWQ2Q2ZZQ1M5M0pPNlltR1dz?=
 =?utf-8?B?dmYwMUQ2Z3Ztb2JjUGw0NDZ6dGtqb3pQMXFSUm9qU3ZVN3VPRXBvMzdNNWY2?=
 =?utf-8?B?cW8wekxjN3pWczhyMFMwMklUMlV5cll1RmViM2F2emdOcDFBNTg1QzBwREM0?=
 =?utf-8?B?Uk12TGUxenhqd2lQQjV6bHRFSldDczkyenV6R1hnMnlKaUJhY2lwUDZvRmJw?=
 =?utf-8?B?KzFqSlVTTWdVZC9Qdko5VDFjK0hTQlBjMjFIRXZZT1pZZU84Ni8zMEpYZ1NF?=
 =?utf-8?B?TjZrS2gxNUZockVMb3N0NmlvR3k5cWFQQlpqVWZRL3pUUHpZQmlOeHMrWW5S?=
 =?utf-8?B?YjFVeHpDNitlNTdWV3kwZjVoU3VVVVM1Uy9kN0dNazhDdEEvWmFkSzJKTjEr?=
 =?utf-8?B?ck1udElNZzF2NXRlOXdIWVJoUEpIdk5MdFpycDJvZWh6N3NnVG1mV2FydVZB?=
 =?utf-8?B?VVNaSGZteFVXblkyZllud0E3Z3d3PT0=?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9104c4-7f11-42ce-df7c-08dce939ebcf
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 14:43:36.0048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wNxRQ/UgazzXRW8FTCeGobEHDxQhelxzbCU111d3Arbl/HwoU4Z/9QJMT3AKfosY8Mfnd6uloKIju3L9/YZsF+P0Qw5zY6pniz4S/j8Yzso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9008

>> When IPV6_MROUTE_MULTIPLE_TABLES is enabled, calls to ip6mr_get_table()
>> must be done under RCU or RTNL lock. Copy from user space must be
>> performed beforehand as we are not allowed to sleep under RCU lock.
>>
>> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
>> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
>> ---
>> v3:
>>   - split into separate patches
>> v2: https://patchwork.kernel.org/project/netdevbpf/patch/20241001100119.230711-2-stefan.wiehler@nokia.com/
>>   - rebase on top of net tree
>>   - add Fixes tag
>>   - refactor out paths
>> v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240605195355.363936-1-oss@malat.biz/
>> ---
>>  net/ipv6/ip6mr.c | 46 ++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 32 insertions(+), 14 deletions(-)
>>
>> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
>> index b18eb4ad21e4..415ba6f55a44 100644
>> --- a/net/ipv6/ip6mr.c
>> +++ b/net/ipv6/ip6mr.c
>> @@ -1961,10 +1961,7 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>>       struct mfc6_cache *c;
>>       struct net *net = sock_net(sk);
>>       struct mr_table *mrt;
>> -
>> -     mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
>> -     if (!mrt)
>> -             return -ENOENT;
>> +     int err;
>>
>>       switch (cmd) {
>>       case SIOCGETMIFCNT_IN6:
>> @@ -1972,8 +1969,30 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>>                       return -EFAULT;
>>               if (vr.mifi >= mrt->maxvif)
>>                       return -EINVAL;
> 
> Hi Stefan,
> 
> mrt is now used uninitialised here.

Thanks, that was an accident, it should have stayed where it is.

>> +             break;
>> +     case SIOCGETSGCNT_IN6:
>> +             if (copy_from_user(&sr, arg, sizeof(sr)))
>> +                     return -EFAULT;
>> +             break;
>> +     default:
>> +             return -ENOIOCTLCMD;
>> +     }
>> +
>> +
>> +     rcu_read_lock();
>> +     mrt = ip6mr_get_table(net, raw6_sk(sk)->ip6mr_table ? : RT6_TABLE_DFLT);
>> +     if (!mrt) {
>> +             err = -ENOENT;
>> +             goto out;
>> +     }
>> +
>> +     switch (cmd) {
>> +     case SIOCGETMIFCNT_IN6:
>> +             if (vr.mifi >= mrt->maxvif) {
>> +                     err = -EINVAL;
>> +                     goto out;
>> +             }
>>               vr.mifi = array_index_nospec(vr.mifi, mrt->maxvif);
>> -             rcu_read_lock();
>>               vif = &mrt->vif_table[vr.mifi];
>>               if (VIF_EXISTS(mrt, vr.mifi)) {
>>                       vr.icount = READ_ONCE(vif->pkt_in);
> 
> ...
> 
>> @@ -2004,11 +2020,13 @@ int ip6mr_compat_ioctl(struct sock *sk, unsigned int cmd, void __user *arg)
>>                               return -EFAULT;
>>                       return 0;
>>               }
>> -             rcu_read_unlock();
>> -             return -EADDRNOTAVAIL;
>> -     default:
>> -             return -ENOIOCTLCMD;
>> +             err = -EADDRNOTAVAIL;
>> +             goto out;
>>       }
>> +
> 
> I think that this out label should be used consistently once rcu_read_lock
> has been taken. With this patch applied there seems to be one case on error
> where rcu_read_unlock() before returning, and one case where it isn't
> (which looks like it leaks the lock).

In the remaining two return paths we need to release the RCU lock before
calling copy_to_user(), so unfortunately we cannot use a common out label.

Kind regards,

Stefan

