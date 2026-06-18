Return-Path: <netdev+bounces-300480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jkFYBPsSNGp3NgYAu9opvQ
	(envelope-from <netdev+bounces-300480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:47:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B86A1527
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:47:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=windriver.com header.s=PPS06212021 header.b=YMdsOVFx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300480-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=windriver.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B546B3024155
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA1029B781;
	Thu, 18 Jun 2026 15:46:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686A233927;
	Thu, 18 Jun 2026 15:46:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797597; cv=fail; b=j1+nc2/cCEWOMwFaw+lOjsR4FDRZxVC/9LUa8ntuc1dzr4AnXZwZUO1F5EMex9bR7mbr2rzd1UOhwaJvDycnn8hh/8u79BTaZsIotMbbH9zMpsKwckA6MlqqhoyANlg387wHkM9PW2qeYvyTzlrBJQBCmq3IGDvApeqcfpjyL8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797597; c=relaxed/simple;
	bh=3XzAUGqobXhVvRqakC9tIRsSmKkjHapOHqbRxaA9JHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HdBZhyWPKdo4NAHrJuesMln1fNOdp71z8eMd9mtNYECuQYg0Bg/Qzx7Ad59rQNcw54/u/Mo5gfEqjzvJ9VBA3GRKYHtK3NISPJYjSCOzALhhZc3xIvBW90vqqqEjcppEXFlUHcU9EYfUIe5ClPbWpNAvnexZqjsaKECqK0G8QRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=YMdsOVFx; arc=fail smtp.client-ip=205.220.178.238
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFEgU0272558;
	Thu, 18 Jun 2026 15:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hCMnYqi5jQsCJx7xB3DlmZeaNrsq7BP+iAatRvxAT3A=; b=
	YMdsOVFx8HlM2bJ81SN5gshw2DQmGN7a5Ej8EKIuSU+fNhEQyTyVN4BO8ENRp0E7
	eehro+A9BectuGsQMSvH2Kb8z+2bXqpqb7kFj/h/ibXL6M1M+2JivIT0/DqBhXAB
	k4tJXvsVVj/QuY/Zp+DoT7noOOltS8lSQQdTSJ8Qg0+d+k8b17LnEWDU9h5zwmA6
	iDNITu5vyItR4cdj+DcUyITfynCoioa1sUtK2w0rI/UaCyoODjz6bM9tFXF5sfw3
	Y/App5MPOrAGIaDNZ+40Y/dL8ORyCMLZ+aOej7YveK2smihug5J00RTCAlj2zmQG
	yEFFOm9ptchM/aLVK6f74A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefc2u0p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 15:46:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ej0zYOxd6RyTP4O1KMA4pC5RIbadkMp04j+2JXMMIi7A2tIvQRT1n46yCL0PHhITHbPvRAgU4fMj1h0/wjty/9jXFVofygBknxKxUVplRTSfNR8NO27mRouszjM/fS5jgsSs7sAxKvYO4WhfsqEzBhm5+E6gYY4deMNOOeywgIE5DoO6LWt12OLniWvki72k5xynfJXUzi/68pDEFtFSmnreJkp4qbJJsYcZ/1Po/AThwOcDfu2h8QnNpaIgFQ3LdsJ0I62qI4gZdYT5Bjy1bXFrJJSJt3DntVaJC8u7Zl5P14aH/hbRSvtkY3jlPW5dBa2Y2jCpDJm9ElArsK4ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCMnYqi5jQsCJx7xB3DlmZeaNrsq7BP+iAatRvxAT3A=;
 b=nl1CmyFCj/BB47m2hb6ffEnVGbQdE++sYfwKsqc097iQFqsuEphGEffrv0HVl/oqpiC52q/QDGaSVUbIBOUxcIinyjaiDkOZgS8q0RMy9kewShwkgnCUDrOagG/dI5qf0/C5PfiuG2FldPEIk/Diy/v5/Vs4WHN0uYP/x3lkus74hwV+hNuusAqI2r46lF6xQlFiSY1sDlH6/xta5hkbEsYdA/zdgDTvJdXOvwFMZOJRnTuTuSBvk9aR4UcksQybagKZk/ir+Gajb0ImrT7ng88ut/w+wYnAxQHSJZz4N84p6FimhzPEAGlh+56SDUUI2T8e8rcnLvRnkBYnijh50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 15:46:03 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 15:46:03 +0000
Message-ID: <3a4ba3da-47ee-4da7-b0da-af500ff1a369@windriver.com>
Date: Thu, 18 Jun 2026 23:45:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
 <20260618150440.cLDwgyDM@linutronix.de>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260618150440.cLDwgyDM@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c9::8) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|CY8PR11MB6938:EE_
X-MS-Office365-Filtering-Correlation-Id: e4052fa3-a29d-4d12-909d-08decd50b403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|23010399003|1800799024|18002099003|22082099003|5023799004|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	s9Nb7WE83l6PVVW8bGd+1Ar/JlVdc3h8fnTElDpKU35x7/jULtX9PfQ1EWtHdSQt6YtZ+12x6AOQBlfg7JNyvi0p7+UwaOmQY8wbW4zWyv0oWDWh4T07iyxTHTlo/Klz8lOD0mhBOsmgfL2ESLX/0kgho+9DpCKCIn3texPosxE/4P+TexnJbKrixmHy3d4DU3erx76K519BaCmrlkHTzVl5aFx91IdeF2lzdGiRsoT2ATsGmOOTIy17CYkX0SVPod7ic5K2aqS2dpkriltHlANgEhA3eLaS26ZRfD2YmVj28WROYjP28gpGa59Jn3aoqmqjEYdBXtiS19IOanUFmmlZ6aqPrMEzu4U8A31CvdVusKpiqO249GD48XZEIkX6QBD31dq4MSJ4y/KbLoOwobbLM2fqy0/JM7UC4rFmQ0x5MwTmm4bgq1Sr1bO7uIc0RRzeUF8/N+AA8Zbryi9JNXqW7VWPCaYuMyIhwOtudtQ8M7mRT3zt22KDEGRIgF0XSi3x1khxTNyKC9Pe0lpeGpvuCg97uCt7q/II0JlBhHxZBOSntpYSisJhwfDZRHttI3gLkoQRyM0v3lyA9mUGc8FF8rt7GGNIuepbD3YQ0cLmDUtwg2agju1wZQjsldMERblYYYZoFytl7D/3iqx771AyYT1da1s6XbnYdbL4jsXedJvyJaQnyiCFYHwGdCMW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(5023799004)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzkwNy9nK2kvV2d6SWoxYjhKVXkrbmovMndUL2llSlVKM2ErbmNIcUQzVHZx?=
 =?utf-8?B?QURLWkNpR05NZnBycFpoVkc2TzFSMmE1amNyeVlXd1hHTmxoWFM0MlBQTUE4?=
 =?utf-8?B?blduSzMwU2Q2bDhjMElBdzd2aHVNVTdxbUJJWHNTQ25WRnBRV1J3RE1yYUNO?=
 =?utf-8?B?MXhROGhIUnhoREpFa0lWZmYxbWdBeUQ3c1luUTdRU015WVd5bERBUE1CSGRu?=
 =?utf-8?B?RFhscVF6NTk3cCtzbTJUQ3BBK2tRTnRZQ01ESC94Qy9IU0Ixb0pQUCs5dGJD?=
 =?utf-8?B?aGdzajE0MHFiMnZvb0pQWnYvTlBLR0RJc2V3RGExZEkxNTdVcCsyWksyalJX?=
 =?utf-8?B?MTZxM1NWbnpLbEZ1YkZ5UWozZFZGTnNEVHRhdUhVRG1Ua210TG5PZEJUOXNN?=
 =?utf-8?B?WjBqR2VQeXplaWVsZHVBRm9vWTFRM24wK0xSaXNQUTFQYzZ5VHdmVStianR6?=
 =?utf-8?B?eS9pd1AxcXlDbzNYS0NIWUQyei9BazBjSndSbTBvNmZxdkpDUmlJU2Ixck90?=
 =?utf-8?B?U2pzL2ZTRnZ1Yll6TWJlZDd2QWwxQjBFNEZFTmtwVStHMmZGdG85aERYLzBW?=
 =?utf-8?B?Ui9nTGxNeGJRb0RoTE5HSDl0L05vT0hmY0tTL3c0NzdpaE1lQkpkSkJzeU9Z?=
 =?utf-8?B?bzR0ZlBpaVhXOW5mbDB4T1VEMk84R2xkRVBFd3hvYS9rLytHam4relFQUTZr?=
 =?utf-8?B?S3Vsd2xFY3dJS2x4QngzK01hcitGYzE2MjFUanBHWHZvOE82ZXpuVkk1enBW?=
 =?utf-8?B?QlUvWmlSMytHWlJzMFF6ZFBuTUtoWDFwckQvR1d4TWI2VE9UbjFoN05TeG5u?=
 =?utf-8?B?cjZSbVlpYWhtc0tsQVMrNElkU1hBdm8xM25KOEk5QVNmWGthUUFwVVBnVHdN?=
 =?utf-8?B?d0ZNTU5qRFdoOUR1QUNqdGxzUWRkaHpYcUMzUlIzMmkwaUhWNGV2Z1paSkNR?=
 =?utf-8?B?Y3Nta0wvRU9iT0RlUnhGdnUzNFdMd29hWFBGYy8zY1dlbVM4VDJmWTZNNC8y?=
 =?utf-8?B?S1hlY013OGRadjBWbVVrR2srWXhPckpEUWowdE1ZdEpsWDdyS1VJYnNHR3Vi?=
 =?utf-8?B?QVE2c0dHWENTOHRYMUgyVGJ5bUt1MkppL3hZR3hhbjlqK1UyYmw3d3dCSkxw?=
 =?utf-8?B?cGJuT3RQUDE2YmdUbU04N2tMOTFHUmd5c1BnZHhneURpOGFjLytrZ0xFTU5k?=
 =?utf-8?B?cktSY2hEaEZ2SFBvRmRnbGZwUlladjl5MXZZYUl2RjJyNGZjL2x2ZlBDV3Nw?=
 =?utf-8?B?MjFiNVUvM1pFU0VHaVRYWWhJNXpXdkxMdEk3NCtTbFdxM25FRnBhdXVuejdz?=
 =?utf-8?B?NVlUSGJNdUJHZklDcVQ3RktPd0tWQldzMlR1VnJ6MHcvU2QrWVpBQ2xheU5q?=
 =?utf-8?B?RXpPeGRoU0JUKzdIbDBIT0tGQjFDemJqd2g4dVVJeGQ1T3BqMlBOY3ZFb1hT?=
 =?utf-8?B?eUZoQWRGUUpqVkxDdDd5RzhjVmpoUENXWTJ5eXU4Umw4TmJtZFFYUUNFaUxh?=
 =?utf-8?B?Z0l3ZGlqdmlFdk9KS2c4M3lVUlNZcU9WbW9GdWxhNmczV3Y2VGgrdlQvdGFp?=
 =?utf-8?B?QlE1ZzZ4a0lPZmdzVDdDZVh3YU05T3VpR21FOUpMb3dNU1dKZGlMaGpSZWhI?=
 =?utf-8?B?eGhhQWgwSzBQMEFtRHJsWW9RSVFidkhiYVlYajZub1A4MzROaXFmc29hMkh1?=
 =?utf-8?B?VHJWekxZTHhKV2U2bGRLbVh6WUY0Myt6VTlqRnkwcmhIQXBPRkRCdUJ2Si9t?=
 =?utf-8?B?NXhWNW4zczhSOXpZTkV1MkU3Vi9qeTNZejNON2xvd0JUMDJtQ1VWNXdSaTdh?=
 =?utf-8?B?MGdIN0FtbUROOGZmV2xlMlB1L2k5eUwrUE8xb0RYOFB6VUxWT2gvanI3ZUln?=
 =?utf-8?B?dkEwTGNtY3NaZzAzN0RYR254R0RUTEU5NWpuQzlaN1hGTlg5YVhadzBTemk5?=
 =?utf-8?B?bkI5SzZkWHhDdHVhY0RNTlB1dnBKODJPRnVyQWJrd1ZsVHNjU0xtbWthR1ZG?=
 =?utf-8?B?NUNyOVBVZS8yWHRYb0d2TGRMZEZFVkNqcS9NQ2VlVDRMTGRpaDQ5eWxGOVJ2?=
 =?utf-8?B?dDVsc0RxMG5wWE9raENaVlVNVkVkR09JcnBLeUttRTl6TUU4cGVVQXQ0Y2JB?=
 =?utf-8?B?QjB2VzlnUThGL2Fmb29VekFCYmlIQS9ndHE5aEZDTXFTdE00Ti83dW16YWhx?=
 =?utf-8?B?cW5DWEhxK1BINmJtM1RxSFJKTk9JdFB4ZmZucFpTVWdDV0tPR2QxaVJ4S1FO?=
 =?utf-8?B?UmRLMkF5QU5nRkFraWJZM3NmSTBBWWMzb2tWUk1TTDhFZVZCanRWbk92WDZy?=
 =?utf-8?B?VTJRSjVLVlFZYVNJbjRMeGZXSTEzRjdRZ1YzQWt1Q2FMOU9GVWN6UT09?=
X-Exchange-RoutingPolicyChecked:
	g3NPF9IajtIjY8OWOz4Q14y8PFmMXdmgVwzElJDNEGCo4BE094pMvAQpH26N8B2fT/dCBjkvSZFlqkGLAGgrnf8zq9E+esDadLqSuZmBzRf3dDAGK7kgKFE1Jk+0D+yIDN1PasEVAqNHR6F6B+rXt0wBWnDcHzn+CTO9NPpAIcNNgqQmoetNoOmXaaPF/4s3TvmCARHsLBBVJK4D7zE9BBIyEwEH1uI1L4bYqysEmv8jBqxSFb59aCduHnZXvB3KWVJ3z7zs5mXlxihvBs03yax8ZeO+IebH7P4C8KMZ9qVHW77dOsc6nyv3dYW0EXXlBmi/PeBJG14x+pVphKJhbw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4052fa3-a29d-4d12-909d-08decd50b403
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 15:46:03.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQ7voQChBxxLJfCv6pf4Yt3Xq2x7hHHdWJLUcwmkwSkCfL6BF9BVMdNnAWCj+YHsmVRFi229jM9gmH43DEX61w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NiBTYWx0ZWRfX/qeFUK7vhNSu
 CWRS7O+OKr9jWqm+f5VxJfLe/h13g2ctyZ2NVTHg98VR+6UW51l5VmUOviYeNLRN/ny9bj0MviZ
 83qQR9wgNwnJf8tRrWgf0KwLQ54WaDN5+iVnQCvsmggomBUJQvGZ
X-Proofpoint-GUID: Q1tjFsx9nzJFed1mf1qP2nxcg4bBD8Wl
X-Proofpoint-ORIG-GUID: Q1tjFsx9nzJFed1mf1qP2nxcg4bBD8Wl
X-Authority-Analysis: v=2.4 cv=ObGoyBTY c=1 sm=1 tr=0 ts=6a3412be cx=c_pps
 a=tlTDY7m+LisZJGavll/kMg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22
 a=B-5KCbuK2s8EsQyf86YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NiBTYWx0ZWRfX5pU1zcqqtqb9
 dK3zu8LWeNfSt0xYEuAsyY6Z5osDhYc42dUvtY3Fx9YTthwWiYvaixhM8M/JtkNzrzN654Xh5il
 VumCFgq0X+S8CIcwgserJERXrwm+s/W+dEKbJTZDDrTRgnbFUN7SssRdy9Bdgw7uSu73htVySnq
 8JwmvKj3L3y2fI9Lf9dOsuZX1hLz0DXIXpPfOXDwAW/j+q4JBSLpnkYpHUuposlynYAunG3Y/5R
 e0GKuo1qTfTUCF3/6XeRtNS6JcPT5UgIDLy7jPyv3ziERuvB3Fo2aKgZmx4h3M+zRXfOk9h5Bxa
 n/TIUNbhDZOtwKzr22TMdGQtnQ4RpDon76QQz6inHPWI54XzHf+GxhRCeV2kHv/GIEclFsYxfpI
 4XysA9MSNotC/rfpgG2lmJFpmd/uYByaV/oPVuTWroRIBuzsXnS+d40e0qa6fOHAVmlMO6btzCd
 myS/uYeVEXDBdO+EkTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300480-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,windriver.com:dkim,windriver.com:mid,windriver.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yun.zhou@windriver.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C2B86A1527



On 6/18/2026 11:04 PM, Sebastian Andrzej Siewior wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On 2026-06-18 21:56:12 [+0800], Zhou, Yun wrote:
>>
>> The enable_percpu_irq() from mvneta_poll is not "lost" — it never
>> gets a chance to execute. The sequence is:
>>
>> 1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
>> 2. PM freezes kthreads (on PREEMPT_RT, softirq runs in kthread)
> 
> But napi_schedule() runs in ksoftird, doesn't it? The per-CPU IRQs are
> not threaded. That does not look optimal.
> 
Correct, percpu IRQs are not threaded. net_rx_action (which calls 
mvneta_poll and ultimately enable_percpu_irq) runs in softirq context 
via ksoftirqd.

>> 3. NAPI poll cannot run → enable_percpu_irq() is never called
>> 4. mvneta_stop_dev → napi_disable(): cancels the scheduled poll
>>      but does NOT execute the completion path (no enable_percpu_irq)
> 
> napi_schedule() sets NAPIF_STATE_SCHED.
> napi_disable() sets NAPI_STATE_DISABLE and waits until NAPIF_STATE_SCHED
> is cleared. So if NAPIF_STATE_SCHED was set then enable_percpu_irq()
> will be invoked unless it leaves somewhere early.
> However, if DISABLED was already set then it disables the IRQ source but
> does not schedule NAPI. This is probably what happens.

Your analysis makes perfect sense, and that scenario is indeed much more
likely. It looks like I'll need to update the commit message accordingly.

>> 5. Resume → napi_enable(): resets NAPI state but MPIC stays masked
>>
>> The unconditional enable in resume covers this case. When NAPI was
>> idle at suspend time, the extra enable is harmless.
> 
> There is no desc::depth counting here, that got me confused. But that
> per-CPU irq is not optimal. Is this a SoC limitation or a design choice?
> Having a NAPI instance with IRQ per queue and those configured and
> spread among CPUs should cause less trouble and is what others do.
> In fact is the only net driver using per-CPU interrupts.
> 
It is a SoC limitation. Armada XP's MPIC provides a single shared
interrupt for the ethernet controller with per-CPU masking for
interrupt steering — there are no per-queue MSI vectors. The percpu
IRQ model was the only way to distribute interrupt handling across
CPUs given this hardware constraint.

Newer Marvell SoCs (armada3700+) moved away from this model and use
standard IRQs, which is why the armada3700 path does not have this
problem.

