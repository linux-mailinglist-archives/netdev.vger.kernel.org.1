Return-Path: <netdev+bounces-189713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BAAAB3513
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 12:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7CC919E0103
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820A32673B6;
	Mon, 12 May 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="uu/YWSyl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2088.outbound.protection.outlook.com [40.92.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6731258CEB;
	Mon, 12 May 2025 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747046424; cv=fail; b=HUEVAH1cmfKG2Xu8NkoxXlEcNwZbqhQew62+PdMR839n0BQuhxAEsieZNeIiC4qx6bQGwBIsr3qZYMMLvY6fTLqgOGDW1HstwzVSU1G9pxi5lhBA604j38QM+endMTUHdgReGvYY5pcNnwwpbQNzpURyVH9QrZnELN5emcd47Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747046424; c=relaxed/simple;
	bh=C1KEkbpeUiPlPzTY+Gk+nwOOnmOFgxnt6tzEO7wYbPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlRPJ0UEXP0kWgXtQVB3FuVyk7NqgZVtN8RYDjhu24e8IPMCDhIYxNvg6jJcqz4AcGwcpuYXQn2EP5MMXhp20PWpWnB6NSRbTOx+oTuMi/geJa/gdoVPlePSLpUJ0ZhW0H9vJO9hwD1g8CiKLMYRmPPDodMtURo0WOO6R32zqz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=uu/YWSyl; arc=fail smtp.client-ip=40.92.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w6cmrbWg0BqnzrEViQ/h0HUNBfFUCA2TqupF5InPCRcD1iHUsqqtVcX5CMNE11HxtSBzWJZ/7t4SmO6/571JmeNRBk2VAGqFjQiG9OYBNXafkSK18hi5V2BmI+hL7RyrHNKWf4aftGiwOB/EIy5Jhwu3ZITFmFKBnctbIchdUGE4r8ospXf7mXC6Z3tvEOGzxE7V+9ITpK5AuNm6j4Rai6jc1wD14KrTtoOOQE/mzfpbrQ8Drbgd04uq6V/0FGGP5y8dKsSKz9/JO9M5CYWfD1eSfv9nVSsTOkTAUj0Ktst55AKzid1NDGsIatlQO3E3lxTdjleucuma5fDwtDhZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pt6PtCt0K4xAbOpbSfpMKcBDyA9v9zCVBY6EuYAsJAM=;
 b=naK1JtrWhRxb4HogWcGAN1xo3IJvZgCuq041Qiv0Hpq9BaQbeFZoCptW3PLO2/QT8NSPyw0etDruX1tQXxrayJHkQl2aM4N2tUZZkwgwmnDIq0XHw9A6FVIyhk5nFakv1TH0PZi26y6GL4QshvhrDc+bBkKh+gMcxXGtFg+KpcF6SV907FrbylmjTu2TXgJITbHGBxoMlC6fFUBnbQF6jhhRzilcrSz1UCWNnpXzILKZquiYW2JW6K1wbCmD4vlzkMhBDR6o9FSytSLpUdixspe5+VqDADYjoawUOyJwztEL28/gL8JNfmqe/rRHbjzyLA2Hf1mCuKixTbCOyakb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pt6PtCt0K4xAbOpbSfpMKcBDyA9v9zCVBY6EuYAsJAM=;
 b=uu/YWSyl/wZt5aNBg8iPHgImKGGQvkeYvFkav0CqjbA0vaFikuwuMFryRVU3JtS7hAwZQShEnXV8eRAZzyY8RJB9pV2y/L2SEJWzlLIXqrlVLCMTVdZ2Z5MOCe7dQzR3hIqjXRsMMFXwTCMFO4aBnNuUzse6YeqITr2qoFULSxSnLYGO2oGKOIsl6R/fsaE0877DPRm4iY3jZZ+V3mPnoC7CxGARqS3VmeOcJxYJtBCwes7lAZN+SZwF+RJzmXfnN08Qfa23UtmGgkmATQucJdeAKghIp33oTlX3H64o2EfbYgTmZaNa/rPStvo/3TkaWfheSdiSD7fYM829Rl3H5Q==
Received: from DS7PR19MB8883.namprd19.prod.outlook.com (2603:10b6:8:253::16)
 by PH0PR19MB4743.namprd19.prod.outlook.com (2603:10b6:510:29::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 10:40:20 +0000
Received: from DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305]) by DS7PR19MB8883.namprd19.prod.outlook.com
 ([fe80::e0c2:5b31:534:4305%4]) with mapi id 15.20.8722.021; Mon, 12 May 2025
 10:40:19 +0000
Message-ID:
 <DS7PR19MB8883DB4229F7505CA877A3EC9D97A@DS7PR19MB8883.namprd19.prod.outlook.com>
Date: Mon, 12 May 2025 14:40:10 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: dsa: qca8k: fix led devicename when using
 external mdio bus
To: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250425-qca8k-leds-v2-1-b638fd3885ca@outlook.com>
 <921b4a1e-caed-47a2-b5ed-d78cf67c5757@lunn.ch>
Content-Language: en-US
From: George Moussalem <george.moussalem@outlook.com>
In-Reply-To: <921b4a1e-caed-47a2-b5ed-d78cf67c5757@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To DS7PR19MB8883.namprd19.prod.outlook.com
 (2603:10b6:8:253::16)
X-Microsoft-Original-Message-ID:
 <72478484-a6f7-4d49-89da-97a6c86f1755@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR19MB8883:EE_|PH0PR19MB4743:EE_
X-MS-Office365-Filtering-Correlation-Id: 783fe87f-bb07-42cb-f441-08dd914163f8
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBLERCSHXadvhc9ELuiLr8N5OYgAMAs9WyyQl1Y6W2bN3pEphz8FLs16qqSnR9gGxLyCQy8djTe8xwbT3HBVaZvUo9FhaJmARwbt1nTdcDzm4STfhaQibSpRGkQLbL7yYbnOSKOzDkdRxB30vPqM3agsdkZ6dZRyaghxsPQGP2bab6hznsL3iRrLi6vQ/330weyPV74KRZ6z4ozTTbPScTQHwsKu5DcMpS+YYmroJWDmwknUEmGC2WUXLZHw3LIKQ+8+DNoxJOg6M8UpwUl2h71mNnHCKfyNWVrwqPmAbe6g6fh8orYvGnPY/fu6WnVT2JfSN8kRPm0+624kibukpypqRFeF42+hRctLbmPswRS8zWm3pqD2BUFgggLKUIy4fpqSm3ptkKQUfJ+DQ9P50MSY4fzjKKoHyPZoJeHsB1imMJnGE+lbJLoMUQig9LkacVn9A/D8LQ6IsTvfCDrLXYwnuTDr/c6yX4Ab4gxv/UweuVk5qfN2mrdMG1hEyJNyay+qYrpTF2I/fg95RHeXCfUnYPFEg/riiEVMfmvzjg4UP+R8/+Sb/WkJ+ZURhTKJhlxlDxfzmRXA9AajOG9O8fRat0I8T5ko3zl0xzT38FjTsqsX6coV8kZFUpgHNPg/uclrSc6GBCTSkcB+9Y0N86CScs7GVkaaGOXnV4S4l3JB1VSKq3d2WJCPt6wJT2k7UCo/JprxSWq+8owZdElbYVTCVtZ/0dHHZB2IQyxSMJwEcY+CQZdGe1MXdbTfyFa+jt1WQyihnl+Sj4K0LCrk7BayouLfn+BUyay7Ulu5j8Ivg8jctSJ9uNwG+gc+nFAF8bxO5sPyl01Ghw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|8060799009|5072599009|15080799009|19110799006|7092599006|1602099012|3412199025|4302099013|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW1zU2hWQzU5WGtuRC9ORENSZUk4QStHd1JKTWIyRFVCMzVXT1lMc2o3Tmti?=
 =?utf-8?B?c29BZnVPTHFYR0lRMXhnOXBTcGV4MmRQNHd5elBWVlQ3N29JaEdXQzJ6NCt4?=
 =?utf-8?B?QXBtUTY3MW8xeEdyRTY0VDF0c2oyNy9CMTBMZDk2Y0VsaW00UExSdEF3SWs5?=
 =?utf-8?B?QnhqeloyUXRtbmlFaXM5cFQzL1ZSN2FsTU01Qmo0UHlydUg3R3dFTjUxNURJ?=
 =?utf-8?B?VldZQ01RK0t5am1MRTF2bjJLZFNUK3AzN2tXV0V5cURvQjZHVGtyUUF4Tmw0?=
 =?utf-8?B?VmdVUDBEMDBWaCtVbDQyenB6bEprV0JFVldXNThUSjJTT05ZV29zb2F2R0V5?=
 =?utf-8?B?UFIyeXl0VU8waWVOQVJaaHR3WGpNd2E0OWxSa2ZuRzFpY0lVMVYzak5Uc1JY?=
 =?utf-8?B?MW1uN2Y0aisvcWtMeHJrYXUrcGhWZG9FTk1ld3pvUUJjMmxuaTNaYlZPaUM2?=
 =?utf-8?B?MkFLQjRpbjBCT3BuOFR3WFdWZnVtNU1ITGtRUkJpU3FCQ2FFNXVkS3VVT3Zq?=
 =?utf-8?B?RlBRdkZYSVVZdjh3R3VtWTUyR29sdDRFUmxyRklwd29sYTdCQitqR3l6NFBl?=
 =?utf-8?B?WHB2SUdRNTNFMFNiRVlOMUFvRkJ2MkN2V2hRd0NYVUZDZ0FqMkQxZmpNcWhQ?=
 =?utf-8?B?YlV1ekVRaFRpd2lYN3dMTWRvZExsYjc1eTA1YzVDVThWdWhndmlXSEU3M1VH?=
 =?utf-8?B?MVNyWkl2TW80M0hhT0Irby96K0tLd29qTGNwdkNzeEgwWjQ3dzhURzZzTHR2?=
 =?utf-8?B?UmFINjdkUlpZU1hKNHZ2QktkanZvdFV4RmtLdCt6bnllcnFTeXo2RVd6SkFa?=
 =?utf-8?B?QWJjamFoelowbDN2QjJYUU51WDlwNTZsVVFjSldPZVJBMEpBa0VVNG11dlh5?=
 =?utf-8?B?SE9UUlRSeEVwdEpjbGVqK3BzUTh5OFVsNkVvbFJ5M3N0Tk9mUEl3MXArc2NX?=
 =?utf-8?B?L25KVzBCLzV6MXNId1g2alRSNVZKNmd4OU5HNEJVNDNTdXM0UE1NUEJXNDJh?=
 =?utf-8?B?VktEVmkveDhkMTFKM1pPT2gxMyt3VlMrMWpTT1p2OGx4YnArSDJ6ZGpKYUxI?=
 =?utf-8?B?UFR4WWNWTVptaENrbjFJaEJNNVVVaFFTdk9WNVNLSGFyRlNLaDg1dVZmMGRL?=
 =?utf-8?B?aC84TVdBNmQ5dlNPOVJoYm5WcWdMUmZ2T3g0bWVuL3RDc0pJQUQ4SkNVb0lI?=
 =?utf-8?B?T0FyVENxUFVRT3J2bVlsQ3ZPV0Y0MEtCZTk3Y2QzTjMzeUxyWm56TGpic3VQ?=
 =?utf-8?B?WTYyNlA2amxuaDlJcTZsR1VWTERUUVdSN1hZbE1aYmVta0MxcTRIS2tVU2lz?=
 =?utf-8?B?RiswV01ScUV6MEdOWkcyTWhRRWl5bFU3aDFzUStJYXdyUHFBaElpTG9wSUNU?=
 =?utf-8?B?N1Y0UFd2QTZzM1I4TW5TaG9mcUs4TmVTRWp6RVJKT1d2WXlFdHZpck1IdnJM?=
 =?utf-8?B?Sm5kOFhoQzVNa1JmRkwrcjNQNks4Z0hOTW5rV01wUmZkcXdkNGg0Qk9ndmlq?=
 =?utf-8?B?OVExTk50UzRxWTRYVFUrMFNaK2NQeXlvOUVBd3NXMlhKMGdhVXlIeTFPbjl3?=
 =?utf-8?B?ejNFdFU5d2IyTFc5V1BMOTBTLzQ3Wjl0SmpYZ3NSM3BsV0NtTy9XYnYyMm83?=
 =?utf-8?B?QUNIMmlJc2lFZG82UW5tOEhOSXU0djN3eU9IY3NaQVpheDlvam9ORlZHRWNI?=
 =?utf-8?B?djdVLzgwelM3bkdWQnhaQUFNam5KLzdEUUIvTmpNVHkyRXlicHBVdmloL3hT?=
 =?utf-8?Q?ttcZvAXOvii7gqVbuCJbxGRhQE9JaRq/B3/L39O?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUxka1oyMTZwb0Q2TDk0YTRyeGJMSmlBMkVRRmw0T0hrS2orTGs0dmZOQWdP?=
 =?utf-8?B?OGhIM3RuK3hvUDdWOVpsUXJvcWNDdDB6YU9WSmJld25hd0lLWncyYzNpcWZw?=
 =?utf-8?B?WUdZTjJTd2VUbHNNWEhuczhUSmlVNExCU3UzSDJub0czOS9xNmVnT2gydEZQ?=
 =?utf-8?B?VzE2ZTB5U1JBMHZ6YlZIY2VEa1U4c1RNcUxkZ3JXcUdwbVV1eWdKWE8wek0w?=
 =?utf-8?B?ZU85V3A1cHJ3UUp0NmJCdnRsUnYzd3hDZmdQcDN4dlM1V0J4ZmdBdkJkZm9z?=
 =?utf-8?B?bTFqNmRvQjBwbTFmbXFIOUp2cDJUTzRINWdrejNGVkhJdUxtL1RYL2Q2b09o?=
 =?utf-8?B?amVSVXdOa0VIRVUyWGFFczJqcUVCQ0NjbHVSdnBuU2JiY3o3M3pRQVhJZjVp?=
 =?utf-8?B?bGhucUpDbUdZVjN2K2tveXI2NlllMUg1ejd2U2NtUjFOR3JVd0RhbUhBVkx1?=
 =?utf-8?B?K0dEaEZ3OTFJc0NJRkVqblovbi9DWitnNCs4NlE4UWp2eFc0eGNMcTRzUUky?=
 =?utf-8?B?dzdYTUFncjY0ZGlFY2ZGMENPVkZNZU1Ndm1RcGlnaGVKMnAwTzZCaFpWQzJz?=
 =?utf-8?B?VjFMbFdjVVNEZzFlMVAvNjBRUHEydWQxUjNuV1krenkwK1o3RW5rdDNqUHpD?=
 =?utf-8?B?U25FVXdQTUdwZnpYb3FJOUFZcHZMeldQaCt5SlQzY0VDTVpIVko5dEdXR3NV?=
 =?utf-8?B?NXU3VmtIclNQelYrZGZEZWc3aUlzUi9aSGN0VXlvTkNEVHkxQzY4TDlFd2pn?=
 =?utf-8?B?M3hzMVcwekR1eFhuV1h0TFB0dmg0cEd1UHBZYVZaSWt6UUh3SDdRb2dlSEdi?=
 =?utf-8?B?YmlMUis1RE51NWMvdGh6VTgzVjZiTGxaWTRCcThua1Bqazd5OGVjK2V3Ynp6?=
 =?utf-8?B?c2lpRHgvcVRlZ3dSemxBdllYQkd2WGNzTTRwZUpPbkJrT1NJZENkbzAyYmZN?=
 =?utf-8?B?Wm1tRjh1LzRuRGFENkh1TGhCd3VOYkRRZk9mMzE4MUJGbDVBK2xIcUxJSHZk?=
 =?utf-8?B?VTJtaXlic2Nrb2xzbjR1aktndUhKemJEbHo4M3k4QU1YbWRWUGx5YWRrYWN5?=
 =?utf-8?B?MkQvSGtBUFpQTUZKemhScTFZb29ybFFleDhSZWFlWG5NeEtqMnhaMzFaVzd2?=
 =?utf-8?B?cVo2TExyWUgrelZnNlkrMW0yd0paVjJjNitpUTBqOFNwdGN1U0tBdlBUeFlU?=
 =?utf-8?B?cmx5eEpHaDBMQ2RST0I1ZFB1bkdpZDFqZFpPdE1zZDhlV1dobHNBT2VVdVpF?=
 =?utf-8?B?c1c3VTFrSDBkNm9oRlE3UmN6Mks4NUVLbXNwTFpyTEcvcWRGZ1NXaDVuSFB3?=
 =?utf-8?B?T2t3NkJ5NXlyeUZJaXQyZVR2a1liNjhjNSt3dHRzWkhObWNRT0laeWVWRkYv?=
 =?utf-8?B?Q2RiMTNUMzBvQXlWVmlmR0ZpNS9iNU9xS3lhREIwbTF6WWcrZzJrMHpYTkxn?=
 =?utf-8?B?b0NITHRqSDR2dTRmVjY3VnduRDdwejkvZkdvWWZYSXpsS1pNcXc0N2pabDVq?=
 =?utf-8?B?aWNJTWRIN1p4blBHaC84cXVyUFNpeXFNZnZRSEFpSW9EaTNMa2RHRGIxRFMw?=
 =?utf-8?B?aE1ScDM0M1llMDl6QVNBOHczQUg4N1Qwakd2L3U4akE1ekpwNUU2a2ZXOXMx?=
 =?utf-8?B?Q05YRG83VDlURExBZG1YUkEzeENEQlMwUlRTMVFhblNQVXVxK09Wd2xLSWh2?=
 =?utf-8?Q?Tti9X25mx83rsWwLgqzO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783fe87f-bb07-42cb-f441-08dd914163f8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR19MB8883.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:40:19.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4743

Hi Andrew,

On 4/26/25 01:15, Andrew Lunn wrote:
> On Fri, Apr 25, 2025 at 01:19:28PM +0400, George Moussalem via B4 Relay wrote:
>> From: George Moussalem <george.moussalem@outlook.com>
>>
>> The qca8k dsa switch can use either an external or internal mdio bus.
>> This depends on whether the mdio node is defined under the switch node
>> itself and, as such, the internal_mdio_mask is populated with its
>> internal phys. Upon registering the internal mdio bus, the slave_mii_bus
>> of the dsa switch is assigned to this bus. When an external mdio bus is
>> used, it is left unassigned, though its id is used to create the device
>> names of the leds.
>> This leads to the leds being named '(efault):00:green:lan' and so on as
>> the slave_mii_bus is null. So let's fix this by adding a null check and
>> use the devicename of the external bus instead when an external bus is
>> configured.
>>
>> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> 
> Before merging this, i think we need to finish the discussion here:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20250425151309.30493-1-kabel@kernel.org/
> 
> It might be the whole internal/external bus is going away...

I've been following that discussion but haven't seen any update since 
April 25. There's also no 'guarantee' that the submitter will actually 
follow up based on the feedback provided. Either way, could this patch 
be merged even if the decision is to remove the internal bus from the 
driver because this patch accommodates for both scenarios by adding bus 
id of the external mdio bus which would be needed anyways. Or am I 
missing something?

> 
>      Andrew
> 
> ---
> pw-bot: cr

Thanks,
George

