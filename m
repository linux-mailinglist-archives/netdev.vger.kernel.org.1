Return-Path: <netdev+bounces-108992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B751892673A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 19:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6EE71C22137
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D171822FB;
	Wed,  3 Jul 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRZ7zBqM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F80442C;
	Wed,  3 Jul 2024 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028015; cv=fail; b=ontX+LIcBt0ihd0jeD7j6OajDG0rXd2gUgMGbCxjWhTukXGkZDtp9dOX9Pqqji46rDM08Az67RLI9/PF5z7o4Dfovxm+kfBfWGopX57w4y9MUpmZ3qQRruYdZk3Sm+3o78sZVXa5r1/3W9H1yTTONy0AENWCE3AW9WZ5VdzMjTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028015; c=relaxed/simple;
	bh=ykf391GWnBD0lBW+EiYJxdyBNBxch5LVPwvxvBJSeRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FJElwQ/kYckTioRWGlNpPAwi5JZLeR31+vUe2oqzIqL/LJ7Gs73AHv6jEkLpdRwGLvJfPep/WAa4aGvmk+G5sgvW6bIs5Crs6VFMFIS2HfWhpKG2eaSjs+Dm9O0W3vdz8r1h9PVHLvFZf5I0j8NGHVr+PPYdBg20q2UpTvbIDdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRZ7zBqM; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep3TogJTNzzkCLjED6MpWee5N9tFgOxUSAeeRN3JSNis4X2XHXcTlARrZgy0E4zhn5pjSjZ8Z9JDy1AnrXdXBvaYdqGLC9yfp7FgRxPSp5r11ipG9CkwhMiCf/MCH11LmQIv+1COxwHOmJy6o6rqZ+so/DZCxuITqV6zinIU1PtF4ph82xsmNKGgdMISYwlzjtDX/F5BKD08i91mdtj3emm8cY7qU40CxAKETuXtOeiuxyhbLCjA/ZsBQ3NcVc/zRzhbYvTGt0NTWHqZvP8Ze3bmlmuZQgjrhM/hMvHbfXfBANZAWNFtMUhly4p3vUbrHQsHZJdAwvz5B39g+i3N1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKGEKMG0mtR6FVseku3lJxDecmmojqn3m+5MyJOhWrI=;
 b=LcylXO/yWJgEXYpM+75XeDR1kBkncSlxtoE5hOeC09IYMXzIUIHZhpt+IpLv7qsz06YG5q7mS/lHrI5rDm/tpawWY4lnEPXiyFAnbGFcYyfPdnIIlbMwbYXQFIFrVRJzNuDxK9mDdL7Jn5RBP3vpUpW9mKK9bVXYn/JoFQMgMWh/i5lEEITPcVuGxyUbM0KbloM1DBRAbF4yikdMit/sTu76ygSy2TM023n9sV9pTSKpB1Il/3u3wqC0oefuf7qKo7v1dW5sr8xny6YhnA9aIxSGW1tAhGJZBjAfepXPIbnMl7nNvK4yzZ5OQTnofwSDQIUdMNCdWTjK4f0qqEeXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKGEKMG0mtR6FVseku3lJxDecmmojqn3m+5MyJOhWrI=;
 b=qRZ7zBqMAELw0dTKL8z+uMXhPr4jMm1AVmxjqtnDlonoia4Pdvs2GcYsDsRWen0HbjLZpDj8ooK6dg6KNjDFHAtWxH1cigvY/4jspllQlkyRsEeiNI9mjS5LMMRNDpx5EPOfYIR1l48rk79Afm4KjBzEmKf85zkQK/EB3+l83MP3etNNLEX5j8wtR+2/Wnn7ALCwH72rJiF/DzIurDcINkmVDrSHKa/+uEPPRhZyfBGLtzvNsYNaCKipTrri8DENBjG5sNnt2QVtC3U8jvzWU9RGSPKmecy0Obe17nDLJiCMybTFU7b9RpfTUSfRTAHXqtFMYFG/VBAIxH4P3461gA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.34; Wed, 3 Jul
 2024 17:33:29 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::ab36:6f89:896f:13bb%7]) with mapi id 15.20.7719.028; Wed, 3 Jul 2024
 17:33:29 +0000
Message-ID: <38443fee-bb05-49a1-9962-f5309be5dddb@nvidia.com>
Date: Wed, 3 Jul 2024 10:33:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v7 02/10] octeontx2-pf: RVU representor driver
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, sgoutham@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com
References: <20240628133517.8591-1-gakula@marvell.com>
 <20240628133517.8591-3-gakula@marvell.com>
Content-Language: en-US
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240628133517.8591-3-gakula@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:806:d0::29) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: d984ca86-0e6b-4397-6bf9-08dc9b864084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXU5dHVPeWdHRkRRejcwUzZKVnNGdFNFTVF3bmR2WmFXN2dWekZ4Qk4xMnJa?=
 =?utf-8?B?a216QWdYL0tMbDZpd3B5VmlYcFhWWENpMmlsUDdxUEl6Y0YvVE1qcUxoMXVi?=
 =?utf-8?B?SWVLeHJxYzdIdWtkQ29DbVpEY3dONVFyRW1lbWxzeHZtMDkyTUdmUnh5VU1h?=
 =?utf-8?B?OGJPM0pYVGpWUWJuNmp3YTZoekYwQVlxQkFnK1dKYk9BTllCTzVyaUo5QmVx?=
 =?utf-8?B?aHJXNllEVjhCNXlmT2hhMTdjOVJ5V3BzcTJYdVNrcm4zR3pNSzBpSy9SK2hj?=
 =?utf-8?B?eDdVUTlTWnI4Vkd6YjMyU2RVbVpJQzY1ZDNETWFRakRxRWtLZ2hDdFpKNWU1?=
 =?utf-8?B?NEg0Sm54TUlTT1lHeG16d0IwVXpKc1AyQ2h1cTVISEN1a0lRZE5WdG1ZYk9C?=
 =?utf-8?B?SExnMUNTRzZGZThxdTZQRy9wQUNITnFsMGdtRzJ2ajlQd0J3dTZ1L1g1Y0p0?=
 =?utf-8?B?N3h5blJlcW11cXlWb01wMzVOTnJ6M2NFaDFrV1ZNTTIwOUc4aFgxWTdGOE1j?=
 =?utf-8?B?QVV0TE1uYVA3VlBQVkJEVDhHWEU2c05mbzFYSnZjOTZhQWxKS1RDTWtpRm5O?=
 =?utf-8?B?NGpzUWpDUHlYUkIxTHRQZzVJT1FBYS90QXhWRWN2SEhsQk9LM2dlZG9KbU0v?=
 =?utf-8?B?MVVQb1NOQUp6Wmt6dWdMZUlYcWlDS1RnWDJ2dG91STdEcnhJSlRnRGErYWVD?=
 =?utf-8?B?S2F4YUthYnlxa1REQmpocHJ5dDBhLzYvcWk2UWcwOGpKN1lTZ25JNUZRM1Zu?=
 =?utf-8?B?aTc1azNnVlI0ZG5qR0hBeU1DcHpuMGhhWm9uOVZOOHdqTzlWei9TcC9FNlpz?=
 =?utf-8?B?Y0RBU3Y0cThIZFUyUm5UbmZMUU9Md0dyN051OURKRWkrN1lEWjc0OGxjSTVY?=
 =?utf-8?B?MHlnL0RTRTlvbEZzT0hXbUk3WWJqcG1ReGpGN2UweVRkYm56QU9oNFUrMG9G?=
 =?utf-8?B?OU4xOHFJZlFqb25zcnV6S1F5YXUwcGhvc0RXZCt5NlVSdktHelB4V1NQZ3Vr?=
 =?utf-8?B?TmNPSXlJMElKNCszL0lPM1d5ZXFnZTFWK0hnQ1IxZHdTTk4xODZZNEFLT0Q5?=
 =?utf-8?B?ejBvdUhaWTlIalY4V1hOaDI5SUczL0V0clY0bStXS1QxYm5ubE9FUDNGWHNL?=
 =?utf-8?B?anNGWmwvdFB2bytVWWRaOGxIbDVVZEJ3eHFEYjZRMGptemM1Z2dONjVFL1A2?=
 =?utf-8?B?WHJidVFpSU5uTldSUlhaRWF0bkF2Z0o5NkpFMnpLRTlxdndNN0Q0V3dxMjN2?=
 =?utf-8?B?QkdGZTlKR0U1czV4b2xnbTc3Z2dlazRqTHVlMlZnTHBpYzhPOWVmeUgyNm1T?=
 =?utf-8?B?eHJEODBWM08wZElrdk52cDdSV0tFYnQxQldGUHloY3JTVmVITUxWS1JXRFZL?=
 =?utf-8?B?REZLa2d3bktZOHNBcjFXVzAyWUFCOVNKMVpjTTZGVVVZd1owNU1rZnh2Uk0z?=
 =?utf-8?B?OHJQZkZ1WWRRTmp1Rk1RcGJOcXczYnE1MUlrR3JkUkN1Ym9JSWFZUW1tMFB1?=
 =?utf-8?B?bGd1Qkhob2I0VWU5c3dDRm9qRFc0SWtlcHpMcFNtZzBxQXViUW9HTktmTnoz?=
 =?utf-8?B?QzdBNm1sSXlxcWtHU0R0KzVDR1U5dHlrNkhZbnpzR3pSM0xTdjF0Mkh6d1dW?=
 =?utf-8?B?dC9OdmpTbXl1cEc0WW5ETXJKUGJPUnM4d3ljUmVmME12LzlscWc1aUxTQkhE?=
 =?utf-8?B?Z21lWXhoSytYSkZZQmNINmFGU25DOHhqK3FzUzlOOVQxSkRCcE8rUUNObFZi?=
 =?utf-8?B?Y3JkL1lqdEwyY1JFcGpBeWpCd25YanpiZ3dzR3Njcis0STVjdUhUeG52czhs?=
 =?utf-8?Q?ehCXyEnMI4UzjM+zSUcvm6Ethi9lySYNEFPRM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akVnd0RmUXQwVEpVTnVOeUwzamhnakNERjFKaS84RkEyU1plOU5RU0RKS2Rn?=
 =?utf-8?B?dEtTdE1qYk9FTGZpQzV4QnRXOG9qVmpUS3R5YitQQ1paTlA2MjVDdW9QaFpn?=
 =?utf-8?B?YUNFRjh1RW9OUEJEQjNGOTRUYXUzbWRUc041MHV1c1dPN0pVNjN6b3F3VW10?=
 =?utf-8?B?YW0ydThnbHg5NmwvWUxBWW9RQklJTzNMUm5ka3FIMWhkTkRKV05tbFMrUUhI?=
 =?utf-8?B?UWZQZGlNWUhTVWdpQ0RzMTlPK1ZJNHgrV0trMmZRRnk1ZHR3R1hYd0s5dlF0?=
 =?utf-8?B?TkdBanl1eEJiVytxWUMyWHVJS0sraGd1VVNZSUN6eEErMGZjOEd2aEo5QmJr?=
 =?utf-8?B?enh6Njk3c1dZTW5mQjJ6V0xWV0J4MXFvUm5xZmFjUEE3QnZRdkJPSWNqaXd4?=
 =?utf-8?B?QU1WZkEwM1YrYWpUN0hkZHV3Zjg1TXNQQzkyd0N1SWIyNDRybkh5U3JKYkxu?=
 =?utf-8?B?NlVMT3VyNW5SVEJUNmE2SjVMWCthY1dpMGhXUzROSlEwWVI0clZHOHlGcjlC?=
 =?utf-8?B?VzYyWGt4VFUranZ4emtuaEFyWFdhZDMrKzBTSGI2czEyVE5IK2UzWS9VS3NQ?=
 =?utf-8?B?ZHdzTFVmeGhqN1pPaDNER0V0QVVadmJrdUtPZXYxM3FlSEJXc2JJbzREYXFj?=
 =?utf-8?B?TUs2ZDNBUmdGY1dXc0tFRU4rbmJBZnl4YzB3QUxWeUFYSjJaQUZLUml2Z3dz?=
 =?utf-8?B?ODNxSTBXZm9uVSttbjNhMG8rUFNhaXZ1a25lODQxN20zWnowWStLOUM4OFl5?=
 =?utf-8?B?TllDaVNkNkRqWU5ScXdkUmtYQVZMNWtPMlVURTV1Nm9ONDBPUWt1cHl6UGpK?=
 =?utf-8?B?bEs5U0VqekcrbzhObjJ3Q2V4VjFmVjRCMDNsL0IyNnJiR2tRcHNIdHY3MnR3?=
 =?utf-8?B?UmI2Y1cybDRoY1BMREl2L2pJT3U4dlJWN1NLSWh3bmlXN2hkV0VEZDVzMGww?=
 =?utf-8?B?bCtoL0poajJ1UlArM1M2cllQSEtuUEtMWjlqc0tVSGlrcXJwMHUwTzI2TUQy?=
 =?utf-8?B?VjFrcFpKMW5uMnFOQUJzT3IrckNVdnEvNWgxYnBQMmtqYXZvOHRWcXpjdTMx?=
 =?utf-8?B?SEppNWZSUVFONkc1WWZBaGpxM3hCeVlSR0JkLzkzU3V3UkVQNElkRGg4eHFT?=
 =?utf-8?B?RVcrKzNvZVpvbElsNUowUnYxTnNNdkxXb0dmRWR6L29CSzNncEg1Rm9SSVpr?=
 =?utf-8?B?TFJxMWtMWERsdjEwWk5lc1JsZjV1aXZxZCtLaVd1MTByYlNxV25TYmpMRHVD?=
 =?utf-8?B?VitvWjVOUzFLbXBEZCt6YjFtREZMdmtYMWF4dG9KWm5QcS9HMDRraXZMS1Jp?=
 =?utf-8?B?RTZPN05jQTVUbFJyVEd2bTJ0S3g5RVkxamhTZDkxbkc4NCttUjdIQy9oTWNQ?=
 =?utf-8?B?cmptbzR1cnZEc3ZYUGNPT3RKbjcxK21HKzZNUG5KN0tDMjA5SklSOG1rejdP?=
 =?utf-8?B?WXVjVHVBcmEwNWFKSkpHR05wNXNlVFN5dTlwT0RQWnhpb2g2a1YvWDVlWm9M?=
 =?utf-8?B?ZWlCeG9BOUlGMnVBd2VZMFJ0TkpxeTU5Ujl5YURMYktUOHBtTWo5N1FvWjIy?=
 =?utf-8?B?dm5vaTRsaXVVZjdHbmJFeE4vcjI0NEJhTjVkVnd1aGU0TUllOHFzc0d6cHlR?=
 =?utf-8?B?QXp3b0NjU3lVbnRDZU9jT3hHQVhRR0NRazNZMUZmOUl2Nzc2UjNSTjd6UkNk?=
 =?utf-8?B?V3FNUlU3Y1J2SlhEZFAvOWpoUlBnRytLTlc1VklxQlpwWlZiM2pTNS9xL3BC?=
 =?utf-8?B?MWdoYVpjL0xBVmtPcXh5cDNKUFJtci92Ukk4Tm5yeUtjZEc5Qm93by9heVlD?=
 =?utf-8?B?bDhNYUpLYVI1YWpVVDRucHEvNlFMNnBLdmNTa2RBRTVnMzRJREc1cG43LzB1?=
 =?utf-8?B?ZGw2aUlhM3RQK05ZbzIvcHkyWmVGclF4ZGFGKzdtVU1Jd3gvODgrNFA2QmZo?=
 =?utf-8?B?ZEdCakRpZVJhREZaQkRJZytFdTlDNmU4NmE3Wmo3Y2Q3VEN6Mnl5cGhXdEhn?=
 =?utf-8?B?M3NOai9oUGxQM3laaElpQm0vOUg5Um9xREhpcEcwSy90KzcvZDBtcERtYmlO?=
 =?utf-8?B?WTRQQkZZU3BKNkl3U3lGN2ZzV0wrR2pRbHpjWTVaMVhSWWZ3NHVaakMwZTNB?=
 =?utf-8?Q?Yzj55seUf5lDxVLmwSxoTm25Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d984ca86-0e6b-4397-6bf9-08dc9b864084
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 17:33:29.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VnOnrOyi8elrd0+CVcXfBsdDvclE/xNxit70dZsbFHvbjRmtBHrUyJKtix9f+GW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260



On 6/28/24 6:35 AM, Geetha sowjanya wrote:
> External email: Use caution opening links or attachments
>
>
> Adds basic driver for the RVU representor.
>
> Driver on probe does pci specific initialization and
> does hw resources configuration. Introduces RVU_ESWITCH
> kernel config to enable/disable the driver. Representor
> and NIC shares the code but representors netdev support
> subset of NIC functionality. Hence "otx2_rep_dev" API
> helps to skip the features initialization that are not
> supported by the representors.
Hi Geetha,
I'm trying to summarize how all representor device works, here:
https://lore.kernel.org/netdev/39dbf7f6-76e0-4319-97d8-24b54e788435@nvidia.com/

So in the RVU representor case, IIUC,
- it has its own PCI func id?
- it has its own receive queue (unlike ice which shares the rxq with 
PF), does representor netdev support multiple rx queues?
- it has its own send queue (always use qidx=0)
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---
>   .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
>   .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
>   .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +
>   .../net/ethernet/marvell/octeontx2/af/rvu.h   |  11 +
>   .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  21 +-
>   .../ethernet/marvell/octeontx2/af/rvu_rep.c   |  47 ++++
>   .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
>   .../marvell/octeontx2/nic/otx2_common.h       |  12 +-
>   .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
>   .../marvell/octeontx2/nic/otx2_txrx.c         |  23 +-
>   .../net/ethernet/marvell/octeontx2/nic/rep.c  | 223 ++++++++++++++++++
>   .../net/ethernet/marvell/octeontx2/nic/rep.h  |  31 +++
>   12 files changed, 388 insertions(+), 18 deletions(-)
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>   create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>
> diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> index a32d85d6f599..ff86a5f267c3 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
> +++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> @@ -46,3 +46,11 @@ config OCTEONTX2_VF
>          depends on OCTEONTX2_PF
>          help
>            This driver supports Marvell's OcteonTX2 NIC virtual function.
> +
> +config RVU_ESWITCH
> +       tristate "Marvell RVU E-Switch support"
> +       depends on OCTEONTX2_PF
> +       default m
> +       help
> +         This driver supports Marvell's RVU E-Switch that
> +         provides internal SRIOV packet steering and switching for the
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> index 3cf4c8285c90..ccea37847df8 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
> @@ -11,4 +11,5 @@ rvu_mbox-y := mbox.o rvu_trace.o
>   rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
>                    rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
>                    rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
> -                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o
> +                 rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
> +                 rvu_rep.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> index e6d7d6e862c0..befb327e8aff 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
> @@ -144,6 +144,7 @@ M(LMTST_TBL_SETUP,  0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
>                                  msg_rsp)                                \
>   M(SET_VF_PERM,         0x00b, set_vf_perm, set_vf_perm, msg_rsp)       \
>   M(PTP_GET_CAP,         0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)   \
> +M(GET_REP_CNT,         0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)   \
>   /* CGX mbox IDs (range 0x200 - 0x3FF) */                               \
>   M(CGX_START_RXTX,      0x200, cgx_start_rxtx, msg_req, msg_rsp)        \
>   M(CGX_STOP_RXTX,       0x201, cgx_stop_rxtx, msg_req, msg_rsp)         \
> @@ -1525,6 +1526,13 @@ struct ptp_get_cap_rsp {
>          u64 cap;
>   };
>
> +struct get_rep_cnt_rsp {
> +       struct mbox_msghdr hdr;
> +       u16 rep_cnt;
> +       u16 rep_pf_map[64];
> +       u64 rsvd;
> +};
> +
>   struct flow_msg {
>          unsigned char dmac[6];
>          unsigned char smac[6];
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> index 30efa5607c58..cbdc7aeaccfc 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> @@ -594,6 +594,9 @@ struct rvu {
>          spinlock_t              cpt_intr_lock;
>
>          struct mutex            mbox_lock; /* Serialize mbox up and down msgs */
> +       u16                     rep_pcifunc;

does rep_pcifunc mean the VF/SF's pcifunc, or rep itself has its own 
pcifunc?
> +       int                     rep_cnt;

does rep_cnt mean number of rx/tx queues in representor?
> +       u16                     *rep2pfvf_map;
>   };
>
>   static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
> @@ -822,6 +825,14 @@ bool is_sdp_pfvf(u16 pcifunc);
>   bool is_sdp_pf(u16 pcifunc);
>   bool is_sdp_vf(struct rvu *rvu, u16 pcifunc);
>
> +static inline bool is_rep_dev(struct rvu *rvu, u16 pcifunc)
> +{
> +       if (rvu->rep_pcifunc && rvu->rep_pcifunc == pcifunc)
> +               return true;
> +
> +       return false;
> +}
> +
>   /* CGX APIs */
>   static inline bool is_pf_cgxmapped(struct rvu *rvu, u8 pf)
>   {
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> index 785ef71a5ead..02d83c4958d9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
> @@ -329,7 +329,9 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
>
>          /* TLs aggegating traffic are shared across PF and VFs */
>          if (lvl >= hw->cap.nix_tx_aggr_lvl) {
> -               if (rvu_get_pf(map_func) != rvu_get_pf(pcifunc))
> +               if ((nix_get_tx_link(rvu, map_func) !=
> +                    nix_get_tx_link(rvu, pcifunc)) &&
> +                    (rvu_get_pf(map_func) != rvu_get_pf(pcifunc)))
>                          return false;
>                  else
>                          return true;
> @@ -1634,6 +1636,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
>          cfg = NPC_TX_DEF_PKIND;
>          rvu_write64(rvu, blkaddr, NIX_AF_LFX_TX_PARSE_CFG(nixlf), cfg);
>
> +       if (is_rep_dev(rvu, pcifunc)) {
> +               pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
> +               pfvf->tx_chan_cnt = 1;
> +               goto exit;
> +       }
> +
>          intf = is_lbk_vf(rvu, pcifunc) ? NIX_INTF_TYPE_LBK : NIX_INTF_TYPE_CGX;
>          if (is_sdp_pfvf(pcifunc))
>                  intf = NIX_INTF_TYPE_SDP;
> @@ -1704,6 +1712,9 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
>          if (nixlf < 0)
>                  return NIX_AF_ERR_AF_LF_INVALID;
>
> +       if (is_rep_dev(rvu, pcifunc))
> +               goto free_lf;
> +
>          if (req->flags & NIX_LF_DISABLE_FLOWS)
>                  rvu_npc_disable_mcam_entries(rvu, pcifunc, nixlf);
>          else
> @@ -1715,6 +1726,7 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
>
>          nix_interface_deinit(rvu, pcifunc, nixlf);
>
> +free_lf:
>          /* Reset this NIX LF */
>          err = rvu_lf_reset(rvu, block, nixlf);
>          if (err) {
> @@ -2010,7 +2022,8 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
>          struct rvu_hwinfo *hw = rvu->hw;
>          int pf = rvu_get_pf(pcifunc);
>
> -       if (is_lbk_vf(rvu, pcifunc)) { /* LBK links */
> +       /* LBK links */
> +       if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc)) {
>                  *start = hw->cap.nix_txsch_per_cgx_lmac * link;
>                  *end = *start + hw->cap.nix_txsch_per_lbk_lmac;
>          } else if (is_pf_cgxmapped(rvu, pf)) { /* CGX links */
> @@ -4523,7 +4536,7 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
>          if (!nix_hw)
>                  return NIX_AF_ERR_INVALID_NIXBLK;
>
> -       if (is_lbk_vf(rvu, pcifunc))
> +       if (is_lbk_vf(rvu, pcifunc) || is_rep_dev(rvu, pcifunc))
>                  rvu_get_lbk_link_max_frs(rvu, &max_mtu);
>          else
>                  rvu_get_lmac_link_max_frs(rvu, &max_mtu);
> @@ -4551,6 +4564,8 @@ int rvu_mbox_handler_nix_set_hw_frs(struct rvu *rvu, struct nix_frs_cfg *req,
>                  /* For VFs of PF0 ingress is LBK port, so config LBK link */
>                  pfvf = rvu_get_pfvf(rvu, pcifunc);
>                  link = hw->cgx_links + pfvf->lbkid;
> +       } else if (is_rep_dev(rvu, pcifunc)) {
> +               link = hw->cgx_links + 0;
>          }
>
>          if (link < 0)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> new file mode 100644
> index 000000000000..cf13c5f0a3c5
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU Admin Function driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#include <linux/types.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "rvu.h"
> +#include "rvu_reg.h"
> +
> +int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
> +                                struct get_rep_cnt_rsp *rsp)
> +{
> +       int pf, vf, numvfs, hwvf, rep = 0;
> +       u16 pcifunc;
> +
> +       rvu->rep_pcifunc = req->hdr.pcifunc;
> +       rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
> +       rvu->rep_cnt = rsp->rep_cnt;
> +
> +       rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
> +                                        sizeof(u16), GFP_KERNEL);
> +       if (!rvu->rep2pfvf_map)
> +               return -ENOMEM;
> +
> +       for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
> +               if (!is_pf_cgxmapped(rvu, pf))
> +                       continue;
> +               pcifunc = pf << RVU_PFVF_PF_SHIFT;
> +               rvu->rep2pfvf_map[rep] = pcifunc;
> +               rsp->rep_pf_map[rep] = pcifunc;
> +               rep++;
> +               rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
> +               for (vf = 0; vf < numvfs; vf++) {
> +                       rvu->rep2pfvf_map[rep] = pcifunc |
> +                               ((vf + 1) & RVU_PFVF_FUNC_MASK);
> +                       rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
> +                       rep++;
> +               }
> +       }
> +       return 0;
> +}
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> index 64a97a0a10ed..dbc971266865 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
> @@ -5,11 +5,13 @@
>
>   obj-$(CONFIG_OCTEONTX2_PF) += rvu_nicpf.o otx2_ptp.o
>   obj-$(CONFIG_OCTEONTX2_VF) += rvu_nicvf.o otx2_ptp.o
> +obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
>
>   rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
>                  otx2_flows.o otx2_tc.o cn10k.o otx2_dmac_flt.o \
>                  otx2_devlink.o qos_sq.o qos.o
>   rvu_nicvf-y := otx2_vf.o
> +rvu_rep-y := rep.o
>
>   rvu_nicpf-$(CONFIG_DCB) += otx2_dcbnl.o
>   rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> index 772fe01bdf98..d297138c356e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
> @@ -29,6 +29,7 @@
>   #include "otx2_devlink.h"
>   #include <rvu_trace.h>
>   #include "qos.h"
> +#include "rep.h"
>
>   /* IPv4 flag more fragment bit */
>   #define IPV4_FLAG_MORE                         0x20
> @@ -439,6 +440,7 @@ struct otx2_nic {
>   #define OTX2_FLAG_PTP_ONESTEP_SYNC             BIT_ULL(15)
>   #define OTX2_FLAG_ADPTV_INT_COAL_ENABLED BIT_ULL(16)
>   #define OTX2_FLAG_TC_MARK_ENABLED              BIT_ULL(17)
> +#define OTX2_FLAG_REP_MODE_ENABLED              BIT_ULL(18)
>          u64                     flags;
>          u64                     *cq_op_addr;
>
> @@ -506,11 +508,19 @@ struct otx2_nic {
>   #if IS_ENABLED(CONFIG_MACSEC)
>          struct cn10k_mcs_cfg    *macsec_cfg;
>   #endif
> +
> +#if IS_ENABLED(CONFIG_RVU_ESWITCH)
> +       struct rep_dev          **reps;
> +       int                     rep_cnt;
> +       u16                     rep_pf_map[RVU_MAX_REP];
> +       u16                     esw_mode;
> +#endif
>   };
>
>   static inline bool is_otx2_lbkvf(struct pci_dev *pdev)
>   {
> -       return pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF;
> +       return (pdev->device == PCI_DEVID_OCTEONTX2_RVU_AFVF) ||
> +               (pdev->device == PCI_DEVID_RVU_REP);
>   }
>
>   static inline bool is_96xx_A0(struct pci_dev *pdev)
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 2b2afcc4b921..8078d1c1fff9 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1502,10 +1502,11 @@ int otx2_init_hw_resources(struct otx2_nic *pf)
>          hw->sqpool_cnt = otx2_get_total_tx_queues(pf);
>          hw->pool_cnt = hw->rqpool_cnt + hw->sqpool_cnt;
>
> -       /* Maximum hardware supported transmit length */
> -       pf->tx_max_pktlen = pf->netdev->max_mtu + OTX2_ETH_HLEN;
> -
> -       pf->rbsize = otx2_get_rbuf_size(pf, pf->netdev->mtu);
> +       if (!otx2_rep_dev(pf->pdev)) {
> +               /* Maximum hardware supported transmit length */
> +               pf->tx_max_pktlen = pf->netdev->max_mtu + OTX2_ETH_HLEN;
> +               pf->rbsize = otx2_get_rbuf_size(pf, pf->netdev->mtu);
> +       }
>
>          mutex_lock(&mbox->lock);
>          /* NPA init */
> @@ -1634,11 +1635,12 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>                  otx2_pfc_txschq_stop(pf);
>   #endif
>
> -       otx2_clean_qos_queues(pf);
> +       if (!otx2_rep_dev(pf->pdev))
> +               otx2_clean_qos_queues(pf);
>
>          mutex_lock(&mbox->lock);
>          /* Disable backpressure */
> -       if (!(pf->pcifunc & RVU_PFVF_FUNC_MASK))
> +       if (!is_otx2_lbkvf(pf->pdev))
>                  otx2_nix_config_bp(pf, false);
>          mutex_unlock(&mbox->lock);
>
> @@ -1670,7 +1672,8 @@ void otx2_free_hw_resources(struct otx2_nic *pf)
>          otx2_free_cq_res(pf);
>
>          /* Free all ingress bandwidth profiles allocated */
> -       cn10k_free_all_ipolicers(pf);
> +       if (!otx2_rep_dev(pf->pdev))
> +               cn10k_free_all_ipolicers(pf);
>
>          mutex_lock(&mbox->lock);
>          /* Reset NIX LF */
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> index fbd9fe98259f..5dcdd8b65837 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> @@ -375,11 +375,13 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
>                  }
>                  start += sizeof(*sg);
>          }
> -       otx2_set_rxhash(pfvf, cqe, skb);
>
> -       skb_record_rx_queue(skb, cq->cq_idx);
> -       if (pfvf->netdev->features & NETIF_F_RXCSUM)
> -               skb->ip_summed = CHECKSUM_UNNECESSARY;
> +       if (!(pfvf->flags & OTX2_FLAG_REP_MODE_ENABLED)) {
> +               otx2_set_rxhash(pfvf, cqe, skb);
> +               skb_record_rx_queue(skb, cq->cq_idx);
> +               if (pfvf->netdev->features & NETIF_F_RXCSUM)
> +                       skb->ip_summed = CHECKSUM_UNNECESSARY;
> +       }

Does this mean representor have only one rxq, and it doesn't support 
checksum offload?

Thanks
William

