Return-Path: <netdev+bounces-180316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9407BA80ED3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0903F8A0491
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE71DF267;
	Tue,  8 Apr 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ij2YPRz8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9F1BD9C1
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123413; cv=fail; b=VOFG0IrG19kmFijbqBRQT8//QASErmgzBdygirrjgDwfSMcuLRY3/N9vShYvS4Tm3xRdmH2UA4TCUl/FOkqXQ6mIUVhaqgiwVToSNvuC7LSSeCXpRQDtwnsl7UbtPAKLtrgh6pzBuAjQbdLluTgNC2l/vMfV9bNpguF9QCo5Dq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123413; c=relaxed/simple;
	bh=Dmd50aX69d7HJBeoDfXxSYh8xUEyIAYRQkDr67OkoJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kfCi7svGTm+alGLMXT5nihtC0ZXKz1afaRDQhrw4yIe1R5CQkh9PWwoqJTs+QxeMh+bsBagZvCkdj9hs9kv1PtnSYhT095dXgbG0khP2RcpYWaLUnl4K7C9nbH4CzWvDekDIPk40JcjEcCZxMSzA/1ZrvzZmMgWb9NKtucf4hCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ij2YPRz8; arc=fail smtp.client-ip=40.107.243.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnsM0xIo4M1XLDA+F8Q69xojV9FZveejzt0yjttr01vTuf7flec5+cFzzytbV1nzTluFN8qM/MfUeJYMMtXsX2iEWwxSw2LlUfJtuZXyJOQ3WDpTq1GsibaXuCPKe09HL7xlULMtuZKuPjECjSqrKMM04YuGGK87244N19p7bacamUbIWu7EyTL5VqHdn2grmm65ty9PQd1y0O4390HReZjtDU7XdrqyTHora0R9z4MA0x0QHSltT/T0UzsLrjqOPnTqbufo4Xz3tV4ZsLS/KJu4hFk1VfmDHY5DJlJYScq5w//v4F7TJY1fbE+lFkeVxpByOOYWJB+gW0Ao5AIvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cRfS+DlA+zMXgabdK+k1fyB3v5u5Dvtj7dLt8JjVYU=;
 b=VfJGVP1u3Y8fyBGAOVvAc+KI0c5To7BsJHXGlxSKYW8uaqzYr4vix8U/Qp3NEjohKVDEiT64+bM3Mtx6WZNXaThKB7ISJ7dYv2gWR/cn6649fv5oONHv1t73OlGqKwpcNYg+eOz4F+YZFeGOC3lVRRff+BD46dReMaoUiNrcB9JU0Z0mKs7lrjgcfReS0LtcMXwwq3Wzjga96ELNrSBWVxPaG3qgUCK1wxx5DnZln+U2PsyMIepH+32s34dRz8ZqvoJPMEJJ4gu9hzw63LEk7vJdkQvx8zX6hOypHRwta2CaSuWvk5G4DA0TUNDoeOj1cJ0ypCoUB4T2dxhzRapY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cRfS+DlA+zMXgabdK+k1fyB3v5u5Dvtj7dLt8JjVYU=;
 b=Ij2YPRz8hIY5y+HdpFAxfTjDVCg7bbHsvhssYxP4P6xvoPqMcXjYdfLr7foiwmR4K6ze771k1i16Rf5fNNHepmKxrONW0EPVXlXWjyLADIyC7hFHyXQzu8QdAROlyFtGH9GpoesquWg8Tgv71wKqw9Ze2hr5KGshjF1RBlPUXinlLh6Yn8ycSXYC17+bW+SOncXJT2wUi3oKXIETdbnw5viqMYOsuDjOKtBgQyBpmqBGiuB09hJi6CgTRLq0XUC9Eb4hiR6+9bhi/xr2M7oVQDPYYeHBVaWOleAbcDWqQp0c5wso5H8c+xzeZU590XlaJ/oA+OEgRu1f9AdmyV/omg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Tue, 8 Apr
 2025 14:43:26 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 14:43:26 +0000
Message-ID: <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
Date: Tue, 8 Apr 2025 17:43:19 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
 <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
 <20250401075045.1fa012f5@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250401075045.1fa012f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d125621-4235-4abd-5ac3-08dd76abb863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDFPMGszS0FGLzhYcW4vckZtdDJ4b0FyQmZSaHVvWWJ5VW4vSCtpWlZVS2F5?=
 =?utf-8?B?OGxxZTFhanZSRC8wcWJicFhObEVCRnp1WEF2OFB3b000OVZwWG14bDB5MEdv?=
 =?utf-8?B?aDhnUFpULzl4VFU5WTJxOTBHQzN4MHRENFRTVHNKVXFmSkNxKzFWUExiUTlZ?=
 =?utf-8?B?V0pxeWw0MkNRWTNZb2tjYWUvZEhTNGMrejRlTkJRajJ0N1VwNVNyZDVCd1R0?=
 =?utf-8?B?bG12RTk5cWdLem42dlpGV0lzYWJwWlpKc2RHTzc1Qk1VYnIwZ3FBQndNcDc3?=
 =?utf-8?B?OEM5QTFOdG5UOVIyWDlNc0VRdGQ0ODZqZGFFSzN4c01scW90QlpOa1p0cllr?=
 =?utf-8?B?MHBTM1plVWZaaWh3OWllb0htUjVab2R3RlJCR085VkVDdmdYa0NndXZicVRw?=
 =?utf-8?B?dEcxZkVrS2dGaXdpNzZ6OUxFWWxUOUsxb0luNzgxRndMOHkyS045SERhUjVU?=
 =?utf-8?B?WEVRbE00cmVnQXNTZEJUcmc5aGliQkQ4ek1UQk96YTRCc1MwRy9Ec1I5QVR4?=
 =?utf-8?B?Kyszbm9zZ3M3bU1ISjVtSFFabVVRY0dYdnV0dE9OZXBKY0tTdmQ4T04rTTdU?=
 =?utf-8?B?bUZVeG8wV29KRW5abUFhS1h6VXhnOFg3YitvQkxyZVhSSWVVZU9zczc3eGJO?=
 =?utf-8?B?NWc0bERQNmNUZFpLbXVPVCtPeE1ZcUlNOEp0NDh5Q1gwTnlmZlRjMXVGRlJY?=
 =?utf-8?B?ZjNVY2w5OFNGNDR6aTFRMjJmMUpqQkxJa2lIREZEWS83UFU0VVJ1bForeS92?=
 =?utf-8?B?eS9ZZXIvTjdCeTBHQ1ZGTDFzNnEzUENSdkM3bjI5bmNMbDlaUWZROGVRbW1C?=
 =?utf-8?B?c0lyZDBEdk5HQ2JVQ0toNDZ6cUFic00xTzZ4aDJwV0RUL2FZampmeElNTnFa?=
 =?utf-8?B?d3BGK1ArdU1nWjArcVBNQkZ4TWhWQndrZHp6WTFzMCtRd2krOXJGVkdLSjlP?=
 =?utf-8?B?aE9RektzM0REcnpaNWxranRBQkFidnJlZ1UzNlppQUovM3R2eVM1Y0xWQjhH?=
 =?utf-8?B?VjZjaXliZVlLanpjb2pYQ09hN2VSdno4SWd0YnlHMUUxeDZ5by85T1JzTTRI?=
 =?utf-8?B?SjBpZ0dlU3NBengxMDNKZFNPQ2V0N0Vjam9FaUhwQSt0L3lMVlRtNHU4WGpn?=
 =?utf-8?B?endwZFVZd1NQYmZZK25Tc3VlcUcydjNsbS9QVDlSMDA2OTNjOXAyTml6OEhN?=
 =?utf-8?B?ckhhbXRUcjRvREl1NXB1elQvWFlHdkFseVhqZFNMazJwTHRFWmhncURwTmpn?=
 =?utf-8?B?TUozRmxOV2NjaFFxTGJkRGYzeWU5NVhLblNITGJvQldJQmxmTmJTRzBFUmkx?=
 =?utf-8?B?bHlzR0V3Zlh0Wm5Wc1FvbUFiOHJrV3JwbDdiOHhxSGV5cDcrZzlrZGUxMUhH?=
 =?utf-8?B?c3B1Wi9RZTBQakxsbzQwdUdkNG9aM3c0TU1NU1poU1llbnZ0TDVpWTNlTU9M?=
 =?utf-8?B?WmFLQjZJc2hFYlYwNHZiZmpSaExaSVlhQXB4cWhVMGZocXQ5ZUVTVTAyOWIy?=
 =?utf-8?B?NFljOGZrU1VtVmRZZVFoSHYvbkwzNTRWdnB0YXRtY014UWtmaG9hNlJLeG43?=
 =?utf-8?B?ZW04YkxncXd2bU51SVlncVZ5MU5NZSs0UEF3UFF0M3JqVjhhMjg4UWt5eXlk?=
 =?utf-8?B?TjAyYXlyVFlXcFFpZzJadjMrSUgrdFJkWit6d1NOMDZPYzBya1Y5WThZenBJ?=
 =?utf-8?B?eDRXQk5hM1JMUGFhUXBiUDVvUjVMbURrKzhsYlkrRmZLcElESTc0MEhwL1Nj?=
 =?utf-8?B?Tzh5eXE0cGZ5ejg0eXVvVDV2bHJYcituZFBmTTBlb2hkT20yTGZDQjUyMGlB?=
 =?utf-8?B?NC9XcHBvU3BTVjZzd0VhWDRkcGJ4U1YwS0pHdEFVbFY2Z3BMSEhXUFo1SFFF?=
 =?utf-8?Q?tlbo9OWG8dIGy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3BsLzN6M0Q3MUtEZ2F0NzQ3YUQ3NG1KM0JYRklEUU10dlUrcG1TNnFMc0pT?=
 =?utf-8?B?c21GRDBZMm5pMWZRNGIzZWpMdUY1R28wdmpMU1NRb2N2Um52NXNITEVIZ1RP?=
 =?utf-8?B?ZFpuaEVjcHBmY05nZkFueWI4Z041QUZEQTBDTXdvcUtOaHYzbE5BQzdvLzZK?=
 =?utf-8?B?NUFwRFJWNGJSYjFjZFI4b3dGQ216bmxna2x1WjlZWUlNa004VUk0cGMwMk5Q?=
 =?utf-8?B?aHRkR0JyQ2Jqd2ZHRi9Rcm95Rlpxd05YcGpOTERYTmV4aUxzNjhWRzFyK29h?=
 =?utf-8?B?QWt3VlVNdEZIM0pkNU5zN3pNNk9EREJHL2NqWjN3N1BYc0FPRUkva054YUJZ?=
 =?utf-8?B?TDJvRWtFTEt6QnZyL1ZuMDZ1dk4yeW1BQlpxOUhLNFdtQWRmWDl5cnJkMzhT?=
 =?utf-8?B?N21nVExlcmJwYWNybXlZbjRBdHh3UHNJU2NmRW0veDNNSmZYb1dhcG45U0F3?=
 =?utf-8?B?VlZJTisrbGdyOFRSNW5rcURNTGN0VWNuQkJDKzcyMDJHb2FIQUZVTGtTN2I0?=
 =?utf-8?B?VG43clVXOXdLaFh6S1c2d3ZTUDVpR0lFenNPSkNOYnpFclhwKyt6anZreEdl?=
 =?utf-8?B?bWRDaEdsYnBCVUZUVEkvdlBRQmMwdm5GTmlLOElqV1dSaGhsWXNEblpNZFJ1?=
 =?utf-8?B?TGNmYzJ2b0lLaVVDRGdYbVFmRVhXYUdjNUt3b1FnR3N1TlFKYlU5bER6blVr?=
 =?utf-8?B?ZnFrQlRxdVBaSVd2TkkxUDBkOGcvYy9ZcjdHUHNWb2ZHM1NGVFl2bzJ6NmNR?=
 =?utf-8?B?clhnMnE3dWM2SjVEMzJpK2wwZVNLYVd2ZzVWRlBacGc0ZTZoOVV4WmhDVHJ0?=
 =?utf-8?B?Z0dFc1QwZTRST3dKdHQwYk5TZjNQUUt4NWFmNHlBZDhvZXNRR0hTMHdMcnZy?=
 =?utf-8?B?SC9nRmxDcTJTQThUZ2RqKzZVUVkvSWs2bFkxdlBMVDFwWiszRm1LRUgxMlZ1?=
 =?utf-8?B?aHgxdzNkOHFiR3VIR1dwUmRqTlE0UmRTcGhKd09EeFZTckt5NjI3UC90UnYw?=
 =?utf-8?B?LytXeEJIeUUzTCszQ1lCUGxsU2c1NkQzZjZFRDlCLzYzMkZnUm1ueXZOU3lP?=
 =?utf-8?B?cGd3MGUzM0ovMmhUNHh6YmxTbWszR2lwNjVCa2NXcUJ0N0FhVk5tdml5VldC?=
 =?utf-8?B?OTJCbWs1Q1JUZEd1Z2g1aTJReFRBeWlQTDlFQmIwZmVXZDdCN0lSU2xjYkl0?=
 =?utf-8?B?TlpVdkd6Y3NWTUljT3Q3VkNOYm4yM0ZTWEdabmJNNE5wcVVCTEJZUFkzcWRX?=
 =?utf-8?B?anNyUVRrRmY4YjUwZXlmZWNPMzFZL2p2OTRwR0xjKzZCN3F0T0VzM1lhemhn?=
 =?utf-8?B?Vi91aWxWaEp3V2VObThyTE12M0V1dERtSEdndUo3cUc2QjlnbDNMQVZVSDhL?=
 =?utf-8?B?eG4rN01mZ0htblJZTUVPNFczSHZrWE5KbUFHWXNlMVJHVjlPZW12ZnVxQ0g2?=
 =?utf-8?B?RExaYnYzTVVSZFFEZXhibUQ3RmJjakpGcU9vTE93cC9JcGQvQmUvZmIyM3NH?=
 =?utf-8?B?V0s4aC83TEhhR2VtSkZuTFFWL2pZSktxQUc5ZzhvK09tb0JGMmVnVVJWaEhn?=
 =?utf-8?B?OW5TZitvV1lIWnJoeVNwZDJySTdkVDJVYkRqSG1tUzBSandFSDZ5aXdFcEZI?=
 =?utf-8?B?UStzVm5RVEZOKzVLRDYvUmUydElOWVZjblZadllTbWp1ZUlVcGIycXpNUE5I?=
 =?utf-8?B?T1p6SlZyRVpCeFU3YnZHVFl2QkhRcG12b3NONGtuQ042dzljYmY4MGVUWXZ1?=
 =?utf-8?B?VUJ4a0gwZnhCVnVUMGd5T3RKU1JUQ2RMU3VLM2loazBuUkNXdjN3MzZmTjgy?=
 =?utf-8?B?TmlBY1lORVo2NEhnZnFHSDQ5QUQ3cVdnUGhnNjlCRkxjM0o3aVpMdmcwWWlZ?=
 =?utf-8?B?U2FUcXljRStDeW5HWEZ0N29JaFBoYU1VcHM5VHBDUWxpaWZ3b2J0blhEcUZX?=
 =?utf-8?B?TEludjFJN2Q3NkoxaXlQWjVLN2I4am9qcUNxRUJQK3hVbjc4VEdQYkVzaE1D?=
 =?utf-8?B?cnI2My9KcXE4SWlsaHo0RjF6LzBMTlZTeVBZRmxKMml2UTRMWUNneHdqQ3Nh?=
 =?utf-8?B?WlMrMFVEYUhMODBCWVd0eTBmbW56NHBxZDFVSEROYnR1OE1TQUl5eGViTjhF?=
 =?utf-8?Q?0L5puxFW6hL16aU8rd2BCfkiL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d125621-4235-4abd-5ac3-08dd76abb863
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:43:26.5534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gMWIuIi1laRbgkgAWE3M2EBxBozyTfdS6DKktN5M16I37D2RxPIhVcOW30FpLJT89DMAcAZsRXWXt5fCiNVpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794



On 01/04/2025 17:50, Jakub Kicinski wrote:
> On Tue, 1 Apr 2025 11:35:56 +0300 Carolina Jubran wrote:
>>> As mentioned in Zagreb the part of HW reclassifying traffic does not
>>> make sense to me. Is this a real user scenario you have or more of
>>> an attempt to "maximize flexibility"?
>>
>> I don't believe there's a specific real-world scenario. It's really
>> about maximizing flexibility. Essentially, if a user sets things up in a
>> less-than-optimal way, the hardware can ensure that traffic is
>> classified and managed properly.
> 
> I see. If you could turn it off and leave it out, at least until clear
> user appears that'd be great. Reclassifying packets on Tx slightly goes
> against the netdev recommendation to limit any packet parsing and
> interpretation on Tx.

The hardware enforces a match between the packet’s priority and the 
scheduling queue’s configured priority. If they match, the packet is 
transmitted without further processing. If not, the hardware moves the 
Tx queue to the right scheduling queue to ensure proper traffic class 
separation.
This check is always active and cannot currently be disabled. Even when
the queue is configured with the correct priority, the hardware still 
verifies the match before sending.

