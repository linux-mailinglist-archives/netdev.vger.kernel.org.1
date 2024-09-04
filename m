Return-Path: <netdev+bounces-124861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4696B3D5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 10:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879CF1F24B2D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D0B14F9FD;
	Wed,  4 Sep 2024 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="umPAlkDG"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BA170A0E
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436998; cv=fail; b=Qp6OJn5iPt0TjWdfgTerx4lkXJegH65O3XGuqug5gwqN2iW4kAkieXfSew2UupfVqSeccKVJs3/hWq1XAYsTxcdvsRIUtI6Lo9kCZlUmX4erY9WCDUY9LNeX2scXh1JbiWz/JjOobzvD3bVyR7l5R/P8zTEeUsv/tIriHnrBW0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436998; c=relaxed/simple;
	bh=XtXnBcso6PhgXANAlV8+AoyLkJWpdXi7fniToicrkIA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aFLHRlPG8+MmLdkogmmu2s60lYkemVZd1WJ2upocNu4cTaynyI9C0c0u9pGfSqvxKQi63MQsx05M/1CVfK0dgjdQPWOBwlFz84gtRBMyWyVhPlVbURpFjDw4vq2sP/mHz/+qxNY/DFzxIM3MJ9z0oE+iW/RV4BdtnYDMpqyGkWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=umPAlkDG; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZv6kFTSW7i2DjUBgZFvUdNB5AJDjPrSjtoBnxAcCH3p7/J+vpL0LoBvUPoj6r+DDIXa/V3Jfj1BsNJ0qS4Kv7nWbQMwa6x+Kna+urJCgqjdw1NamR7UhLoi7rjiCpzzTlKvDjUGdUvt5IVsw8ZUucbYQw1xkm8hNVFgGX1w7SXC5+QsxEctIoLE5ooVMzrOTxvUFT5ZS8C4Fgs1/JLTL6FyhnzfMyHULrmECT4SNPFFAl3/qQng1exaq3C71aa1EZKtrDmZq89Yw/OQbG2mwqeEObh6yXG1ec0F9Hi9xJgwp4VAyU5eh1MRk7NgQb8SNTq9Ov5H+e0niiOPVPs7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtXnBcso6PhgXANAlV8+AoyLkJWpdXi7fniToicrkIA=;
 b=ow4BSVJnHpyyoZvsFhgmmxHZTu/5QgjzxVjLdmd1p/3cW1Kt/fnCR2N5oj/KqN+2ppJNKCLRpVMkMvi9e8cdk5C/a3HIypZEZrESHwbxYWAKfzn9UaPFigSFIqHbsP3BqAgILJRXmGVVFiKDAYYu9xBX49u3IecmhnurCxWnK+BQgqSgLznrffkPjoMSQDnKvAxE4tNOPd0O694/xUJUYLPuN0MbLaQ905pj1wUiibWv0YoKJNqhHDAO36crk1oy5Pj7Wyr4XZX8b+YGcxgx5Gud0sG+lYSQGHQHq8I/G/VM5DJSVJ6JF8/V5GE9aXAyDTeSpNqFYltRwXogi89jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtXnBcso6PhgXANAlV8+AoyLkJWpdXi7fniToicrkIA=;
 b=umPAlkDGNAAR/82c3yN+/c+eVfrWBwuVkEzZNQGK9m16S0yplYw1dTxeIz2BXxnu561Oc28CIp6CufSgxGutVPd9ZobXNRNgbUMp84suREQ+TZzzBC5uTkiZZpafXoRQLRGUGY2F0O84giwi0XDbk7nct+LihUDD/4E98+UXbV1MiLEK9XFWH9Tqso/0rgKvpem6GzKUZxtgaBh0itn74uXyEkSoKX0lakiYgFFUiE2S1lChEX4J36iQ/+GFI94/xDBQbhFb+zrl51sgnpGAe6qjxemPh5XdTc3qP5/DAMiekrOje54gLKzw1S0dHYsn38QLo9sZ2+1FpXAmwq70TA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DUZPR10MB8265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 08:03:09 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 08:03:09 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com"
	<olteanv@gmail.com>, "daniel.klauer@gin.de" <daniel.klauer@gin.de>,
	"davem@davemloft.net" <davem@davemloft.net>, "vivien.didelot@gmail.com"
	<vivien.didelot@gmail.com>, "LinoSanfilippo@gmx.de" <LinoSanfilippo@gmx.de>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "rafael.richter@gin.de" <rafael.richter@gin.de>
Subject: Re: [PATCH net] net: dsa: fix panic when DSA master device unbinds on
 shutdown
Thread-Topic: [PATCH net] net: dsa: fix panic when DSA master device unbinds
 on shutdown
Thread-Index: AQHa/qDhxv3gRVoD0kGEjqt23Tbnvg==
Date: Wed, 4 Sep 2024 08:03:09 +0000
Message-ID: <c1bf4de54e829111e0e4a70e7bd1cf523c9550ff.camel@siemens.com>
References: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
In-Reply-To: <20220209120433.1942242-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DUZPR10MB8265:EE_
x-ms-office365-filtering-correlation-id: 7849dc8e-bfd0-4866-0f5a-08dcccb80448
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YStJMTlaSEt0cWNmMmp5OXVHMVcxVWMxcURueUQwbnZEUGFBUlhqWGhtWTAy?=
 =?utf-8?B?U0ZmYXBWOVF4cVVKVmgxaUdIMTVQNURkSVkvZ3J5Zi9BSExZMmNLNFMxOVZi?=
 =?utf-8?B?Wktzb2x5eGYxWVFHMkMza1QwOG91clhPL2k4eXB2K2IyVnhuQldQYk9EeFBw?=
 =?utf-8?B?eWIvL3NCaHlwNW5CelBsMi94cktoNkMrdjA2eVh3Mjd4REM1VXNwRjNUQW95?=
 =?utf-8?B?Q3daY2hDN0FydnRpN1dqVEk5NjFIdEovN2ZaMkJNcU9lMFZYRHVlUG1Wam4r?=
 =?utf-8?B?YnVmS3Y2b0xQanZBNk1yNXNLZVdLbXlONU4rSjFha3RQc3N6WG8xT2lWQTU0?=
 =?utf-8?B?NWZuNkUxY2hXSVlzSCthRWpJYnZEV1V4d1pmOEFXT090WTlwdFZ0WGRGK0ZS?=
 =?utf-8?B?WDVlb1FvUkFkblJQTGtPZ09VK3hncURTSlNOMmh1aHl6RkI1bE5FcTU0YkI5?=
 =?utf-8?B?ZVcxcGVoQnFRMElaeG5HY1ViWGhoT044Q1BtcFZITHh2WHp6TXNZc0VlUDFr?=
 =?utf-8?B?aGROVHEyQk95MURiS1g3ZjltWWRqcmsrdVpoSmlOUE9BNEdDN3dqQmRGNHdY?=
 =?utf-8?B?UWVFdTN4TWhoNG1PSlJ5TGFpa0ttbVlIUmhiOWsySm1SSk9LeDE2cHNMU3ZI?=
 =?utf-8?B?cEFMWlArZkZNc3ByRjNVTWl1RFZRcVc1d3dpNHZvSE55Q29YZHg2OGpkcVVD?=
 =?utf-8?B?bUwvbWZsS1hlOGY3WlJPeDlvcjdaK1FLQXVIdGZZZU5DZGgyVEdhNDh6d09H?=
 =?utf-8?B?ZlN4T2dkRWFuOXdpcHprRzVldDFFNUdvVmFrS2hMRytzdDliSFJDVnZuRkww?=
 =?utf-8?B?b1lGNnVvUExtQkJSWVoyM1B3RXJWL3RsaXNXT253QnVIZnRQdGlVVGRuZTBX?=
 =?utf-8?B?V1J5Sk1Held3dnJXcnZ6ZDcwN0g3VUQ0dUVzdWdYaTRTd21yRzEyb0VBTHZr?=
 =?utf-8?B?SWNNcXA1MUY5VHdhMkY3MGRHNFdGc0lRRlFiUjFuWW5zSDc5YUJQL3dVS1lP?=
 =?utf-8?B?UmJFVndKNWlWTExmUzZqTm1xai95cjM5MG55NkdPZkFtZ0xFaWVyTEMwejIv?=
 =?utf-8?B?LzNnMnRRNktyNDQvSlVzL1lMQUVDekh1ZGN5UWdyMWJvSG5OSzNxakZEVkVx?=
 =?utf-8?B?bjhFY094cnhyb1JNb2Mzamw0Ly8xVzU5RkY2Rnc3bU5vc2JQZVdPODRCemVV?=
 =?utf-8?B?SjRacExwWWdQR2l4ZjZFd00rSjBjZVNFejdIdHpndWdBT2tWZVZUZDIzbUgz?=
 =?utf-8?B?MmJ2UmNnWlVKZ0RhbjNnM1RUdzAvYjBlV0t0YWV4b3d2UDRTVEhZVnhGb3Z4?=
 =?utf-8?B?QXZ1U0c0S2NWQTB1ZHVpZnpGMzZsem5TWlErQzM4NkcxZXFhR1FSbUh4MVFp?=
 =?utf-8?B?SmVMaFhmZ1pGcFdUUm1pcmNUZ3VhQ3hnVnU2alJNeVJwc042d3o4MW1HMDFq?=
 =?utf-8?B?blhZMlhOWUo4NlB5cllBOW45VWt1allrNXJzcWREL3pUSW5wZ2w3cnlkMGF6?=
 =?utf-8?B?QTBXNm9HUVZjZ3dPQ0JJbkpXY1JEdEhkWU9yVW56bkdnVFlURzJ4VmxuakZu?=
 =?utf-8?B?MUUrNExmV0NUbDhPc1VNQTZaSUlkbEZHaW03aDlHN09HM3dVMStQYk4vaGc3?=
 =?utf-8?B?WkYvdWRLZXZsY0t1VW1uSVZaMTc1L1BSVHJmK25zRllBbVhMQUs0Y3U1WVpk?=
 =?utf-8?B?K2MzUWtKZXVzQmZNTU53K2ZDTnV0d3JXSUxlV2JSSXZrTWcrWDRxeXZkeHB2?=
 =?utf-8?B?aDZONkJGMGIwM1hOeVpjZHRwVDhxVVhUd0t1c1M3ZTJYY0xWeHNnQnROUVFm?=
 =?utf-8?Q?AoVXV3iIE9Z04JO5DmmZi8RxGLQmfJHZ92TS8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXRhNGNLMUpjK2tma0d3bnQwSkFZbWlJZmdtL2c4MzhxRzRPeCtRMFhGM1lO?=
 =?utf-8?B?aFNreTgyc3lKaDIwVEhZQWZNc1VvS0pLVjVCMG5sM0gyT3pKRXdTZXpEVkN0?=
 =?utf-8?B?dEtEWCs5Tko1NkhERUNsTFZyUE9vdVFQRjE1b241TTVObGg1SGx0Z3V0M0Z4?=
 =?utf-8?B?cnBBYXpWbGZacFhaMEVBemRyQmZhbW5RQ3Ftb2VNZVhsMHB6eGtQeHI4bDdq?=
 =?utf-8?B?L0t2SXJZOG8ydkEyN3NVY01BMGFZY29TT1pXbld3WkdmRjl0cHgvNHRMeWpo?=
 =?utf-8?B?UzhDUGIzSjQ5UFlESFRPeHpnVkRlcUgwb2l5Tm1JRTllb29lOUpwdE5sT1Nm?=
 =?utf-8?B?ZTFpazJwRURBaHdudmJZVGF4aG56NmZISEM1V0xMYWkvTTdMNk53M0ZFbTRI?=
 =?utf-8?B?SElQNDRXYzFtdG11MG0xQ1ZrNjYrbFI4V0Q3TW1DbGdSdGVTU25OaURTd05k?=
 =?utf-8?B?Mkc3ejdUU2t5YUhPL2xuY0p2MUE2ZVR3MnF1VnAvbGtkR3hTS0REVHJMTWFR?=
 =?utf-8?B?SmdhRE1ORzhLWTlxaFA4QXV6VWFMMjJjckN4V0RiYWc2L3c3eHdOZDZyZ0lr?=
 =?utf-8?B?bFRwU2pGcjJoQjQ4Uk5CWGlsNXpNbHpxcjZkdS9SSFhRVVFuYzFWbzExN3VG?=
 =?utf-8?B?SGJwazMxNFBweW9JM3FTL0YrQmtMbE1mQVQzWkdPU1BpcWVEVnZneC82eTRh?=
 =?utf-8?B?U1ZQRjlMNGhHT1VYdnJQR2ZOMkdBSXpMelR1ZHowcWxDMDFVaUdzdUhiWXBi?=
 =?utf-8?B?NC9XSVM5U3hkS25pSE9vMWV3bjdtMzRoQ2xCMHpoaE1NUVFjcWNOZWFzbmtW?=
 =?utf-8?B?M0pCaFRCMURrMlFBUTZuWTBZZWhSMkJaME9HQllub0l0Z0NjRjVJRGdoOWp6?=
 =?utf-8?B?VXRTRStBWXZyYUJlM21FS0hjaEJBYzh4Vk5BR2s4akhFOXdZMkJkZkhlS2hT?=
 =?utf-8?B?WjVXVGxnYndtSm1ZWkc1T3NublVMdEQyMU5RSWNyYkpZMlBaS0h6azdiVUVm?=
 =?utf-8?B?eFgyb0FYUFNXY2c1K0hjSHlzOWtveVlJNU5scDc2TjJieDUycURCY3FOb0NS?=
 =?utf-8?B?T2JSSEtiV01jZ0luQmcyZmRXeWZtQ1ZoZm9qaGpqSFRrRzNPNEF5dWVHWm1W?=
 =?utf-8?B?c0U3WkNnTVlQUXUwQTNldDlrOHBxZ2FEUnF4MmYzRWtCektQU3FmcmlkeVQy?=
 =?utf-8?B?V0FWa093YTlHMmZhdTA3aksyb0xxOFVKUW9FRUlWNnE2UkJqTTREOTBjRGh6?=
 =?utf-8?B?b3NZY0tKNVhra0lkMG9wK0hqUmMvTURqbG9sMnF6SjJKQ0gwUVB1eTBqQkht?=
 =?utf-8?B?RlNYNWttOWMvb3ZDMFBkWmQwWXpzRE14aTRkQjdoWExiKzZPWkVqaUtnWkwv?=
 =?utf-8?B?MXdJL3RJMTYzMHRPOXoyOXB3d25KaUdnQVBuOHhKeTF6MUx5WmRmaC9TTlAw?=
 =?utf-8?B?dGRYc1F5c2tlOWtWQ09wUGxxYUgyOUtRL1RGTUpwc2pKQlZZTk1jK0hhczBu?=
 =?utf-8?B?STg4WEtiaDI3T0RMU3ljbUd3VFFyaVRUNS9rSlBKMjV2bHlVZGY5R2hHS21D?=
 =?utf-8?B?TWZ2QUhOZWhSazZlZXFNdkU1R1FaMTZJb2owUFRlVEZ5cmxUR1hVcWlnSHpB?=
 =?utf-8?B?WEFsNGMvZ0VJVjZLQWZ3TVR6UGQ2dnFZcTEwNTAxWlcrSmkxNlA0OXkyZWhS?=
 =?utf-8?B?a0JIeG01K0VqdklOdWdXd0lJZmY5OUUxaU5zTDNjREF4YXlPQ2NlM1FSWkdr?=
 =?utf-8?B?Zkt6Z2t3Q2wvN2gxaklHZ1FLWkFKQzlSTFBETURvN3VndlF2NHRPbklQWE5w?=
 =?utf-8?B?eSt0TFZSTC91WStqNmx4R3lOZTNKODFlaGg3bGtnZ3RHM2JZZlpoajA3V2R1?=
 =?utf-8?B?bElkR0J2eVVIYlhNMWlySExHVUFjbTYxMVpyRmx1R080UkJsQmFNazlNcHFp?=
 =?utf-8?B?NStZMFVQUVNrUjBGLytJbFlPbEducHRSaFp2dEM2cXh4YkV4QlNVbGVkamxV?=
 =?utf-8?B?SXVVSTF0NnNxRWhSME1Ic1NmK1Q0cmN4NVB1TUNGc2hQNVVSVENIUmtKbVNr?=
 =?utf-8?B?bERzYWx2VE1xdVRZalQyWTE5SzhjTit5d1FMMmVndU5yVFhEbHc1OFpYVTRr?=
 =?utf-8?B?bnNKSGYyc040a2VkNnUzaDRDN2tpam0zdWZmWUlpMVZSVzdobFI3dWlmTHh0?=
 =?utf-8?Q?/r3k1d6EAmYlTEDnLGPIzns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <068A324B1B00BA4491181B41E69C7CA2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7849dc8e-bfd0-4866-0f5a-08dcccb80448
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 08:03:09.7540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1zJ9Icj97gEe5FeXrLU9DzphkWfjAJJYlGQoTDGrSEIwSna3N3N8MifOewgh/RAVJQ4DnwZXdCe6dbiNeaCxTkmsRa/9gaysQmuOH4BIN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8265

SGVsbG8gVmxhZGltaXIhDQoNCk9uIFdlZCwgMjAyMi0wMi0wOSBhdCAxNDowNCArMDIwMCwgVmxh
ZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiBSYWZhZWwgcmVwb3J0cyB0aGF0IG9uIGEgc3lzdGVtIHdp
dGggTFgyMTYwQSBhbmQgTWFydmVsbCBEU0Egc3dpdGNoZXMsDQo+IGlmIGEgcmVib290IG9jY3Vy
cyB3aGlsZSB0aGUgRFNBIG1hc3RlciAoZHBhYTItZXRoKSBpcyB1cCwgdGhlIGZvbGxvd2luZw0K
PiBwYW5pYyBjYW4gYmUgc2VlbjoNCj4gDQo+IHN5c3RlbWQtc2h1dGRvd25bMV06IFJlYm9vdGlu
Zy4NCj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVhbCBh
ZGRyZXNzIDAwYTAwMDA4MDAwMDAwNDENCj4gWzAwYTAwMDA4MDAwMDAwNDFdIGFkZHJlc3MgYmV0
d2VlbiB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzcyByYW5nZXMNCj4gSW50ZXJuYWwgZXJyb3I6IE9v
cHM6IDk2MDAwMDA0IFsjMV0gUFJFRU1QVCBTTVANCj4gQ1BVOiA2IFBJRDogMSBDb21tOiBzeXN0
ZW1kLXNodXRkb3cgTm90IHRhaW50ZWQgNS4xNi41LTAwMDQyLWc4ZjU1ODUwMDliMjQgIzMyDQo+
IHBjIDogZHNhX3NsYXZlX25ldGRldmljZV9ldmVudCsweDEzMC8weDNlNA0KPiBsciA6IHJhd19u
b3RpZmllcl9jYWxsX2NoYWluKzB4NTAvMHg2Yw0KPiBDYWxsIHRyYWNlOg0KPiDCoGRzYV9zbGF2
ZV9uZXRkZXZpY2VfZXZlbnQrMHgxMzAvMHgzZTQNCj4gwqByYXdfbm90aWZpZXJfY2FsbF9jaGFp
bisweDUwLzB4NmMNCj4gwqBjYWxsX25ldGRldmljZV9ub3RpZmllcnNfaW5mbysweDU0LzB4YTAN
Cj4gwqBfX2Rldl9jbG9zZV9tYW55KzB4NTAvMHgxMzANCj4gwqBkZXZfY2xvc2VfbWFueSsweDg0
LzB4MTIwDQo+IMKgdW5yZWdpc3Rlcl9uZXRkZXZpY2VfbWFueSsweDEzMC8weDcxMA0KPiDCoHVu
cmVnaXN0ZXJfbmV0ZGV2aWNlX3F1ZXVlKzB4OGMvMHhkMA0KPiDCoHVucmVnaXN0ZXJfbmV0ZGV2
KzB4MjAvMHgzMA0KPiDCoGRwYWEyX2V0aF9yZW1vdmUrMHg2OC8weDE5MA0KPiDCoGZzbF9tY19k
cml2ZXJfcmVtb3ZlKzB4MjAvMHg1Yw0KPiDCoF9fZGV2aWNlX3JlbGVhc2VfZHJpdmVyKzB4MjFj
LzB4MjIwDQo+IMKgZGV2aWNlX3JlbGVhc2VfZHJpdmVyX2ludGVybmFsKzB4YWMvMHhiMA0KPiDC
oGRldmljZV9saW5rc191bmJpbmRfY29uc3VtZXJzKzB4ZDQvMHgxMDANCj4gwqBfX2RldmljZV9y
ZWxlYXNlX2RyaXZlcisweDk0LzB4MjIwDQo+IMKgZGV2aWNlX3JlbGVhc2VfZHJpdmVyKzB4Mjgv
MHg0MA0KPiDCoGJ1c19yZW1vdmVfZGV2aWNlKzB4MTE4LzB4MTI0DQo+IMKgZGV2aWNlX2RlbCsw
eDE3NC8weDQyMA0KPiDCoGZzbF9tY19kZXZpY2VfcmVtb3ZlKzB4MjQvMHg0MA0KPiDCoF9fZnNs
X21jX2RldmljZV9yZW1vdmUrMHhjLzB4MjANCj4gwqBkZXZpY2VfZm9yX2VhY2hfY2hpbGQrMHg1
OC8weGEwDQo+IMKgZHByY19yZW1vdmUrMHg5MC8weGIwDQo+IMKgZnNsX21jX2RyaXZlcl9yZW1v
dmUrMHgyMC8weDVjDQo+IMKgX19kZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgyMWMvMHgyMjANCj4g
wqBkZXZpY2VfcmVsZWFzZV9kcml2ZXIrMHgyOC8weDQwDQo+IMKgYnVzX3JlbW92ZV9kZXZpY2Ur
MHgxMTgvMHgxMjQNCj4gwqBkZXZpY2VfZGVsKzB4MTc0LzB4NDIwDQo+IMKgZnNsX21jX2J1c19y
ZW1vdmUrMHg4MC8weDEwMA0KPiDCoGZzbF9tY19idXNfc2h1dGRvd24rMHhjLzB4MWMNCj4gwqBw
bGF0Zm9ybV9zaHV0ZG93bisweDIwLzB4MzANCj4gwqBkZXZpY2Vfc2h1dGRvd24rMHgxNTQvMHgz
MzANCj4gwqBfX2RvX3N5c19yZWJvb3QrMHgxY2MvMHgyNTANCj4gwqBfX2FybTY0X3N5c19yZWJv
b3QrMHgyMC8weDMwDQo+IMKgaW52b2tlX3N5c2NhbGwuY29uc3Rwcm9wLjArMHg0Yy8weGUwDQo+
IMKgZG9fZWwwX3N2YysweDRjLzB4MTUwDQo+IMKgZWwwX3N2YysweDI0LzB4YjANCj4gwqBlbDB0
XzY0X3N5bmNfaGFuZGxlcisweGE4LzB4YjANCj4gwqBlbDB0XzY0X3N5bmMrMHgxNzgvMHgxN2MN
Cj4gDQo+IEl0IGNhbiBiZSBzZWVuIGZyb20gdGhlIHN0YWNrIHRyYWNlIHRoYXQgdGhlIHByb2Js
ZW0gaXMgdGhhdCB0aGUNCj4gZGVyZWdpc3RyYXRpb24gb2YgdGhlIG1hc3RlciBjYXVzZXMgYSBk
ZXZfY2xvc2UoKSwgd2hpY2ggZ2V0cyBub3RpZmllZA0KPiBhcyBORVRERVZfR09JTkdfRE9XTiB0
byBkc2Ffc2xhdmVfbmV0ZGV2aWNlX2V2ZW50KCkuDQo+IEJ1dCBkc2Ffc3dpdGNoX3NodXRkb3du
KCkgaGFzIGFscmVhZHkgcnVuLCBhbmQgdGhpcyBoYXMgdW5yZWdpc3RlcmVkIHRoZQ0KPiBEU0Eg
c2xhdmUgaW50ZXJmYWNlcywgYW5kIHlldCwgdGhlIE5FVERFVl9HT0lOR19ET1dOIGhhbmRsZXIg
YXR0ZW1wdHMgdG8NCj4gY2FsbCBkZXZfY2xvc2VfbWFueSgpIG9uIHRob3NlIHNsYXZlIGludGVy
ZmFjZXMsIGxlYWRpbmcgdG8gdGhlIHByb2JsZW0uDQo+IA0KPiBUaGUgcHJldmlvdXMgYXR0ZW1w
dCB0byBhdm9pZCB0aGUgTkVUREVWX0dPSU5HX0RPV04gb24gdGhlIG1hc3RlciBhZnRlcg0KPiBk
c2Ffc3dpdGNoX3NodXRkb3duKCkgd2FzIGNhbGxlZCBzZWVtcyBpbXByb3Blci4gVW5yZWdpc3Rl
cmluZyB0aGUgc2xhdmUNCj4gaW50ZXJmYWNlcyBpcyB1bm5lY2Vzc2FyeSBhbmQgdW5oZWxwZnVs
LiBJbnN0ZWFkLCBhZnRlciB0aGUgc2xhdmVzIGhhdmUNCj4gc3RvcHBlZCBiZWluZyB1cHBlcnMg
b2YgdGhlIERTQSBtYXN0ZXIsIHdlIGNhbiBub3cgcmVzZXQgdG8gTlVMTCB0aGUNCj4gbWFzdGVy
LT5kc2FfcHRyIHBvaW50ZXIsIHdoaWNoIHdpbGwgbWFrZSBEU0Egc3RhcnQgaWdub3JpbmcgYWxs
IGZ1dHVyZQ0KPiBub3RpZmllciBldmVudHMgb24gdGhlIG1hc3Rlci4NCj4gDQo+IEZpeGVzOiAw
NjUwYmY1MmIzMWYgKCJuZXQ6IGRzYTogYmUgY29tcGF0aWJsZSB3aXRoIG1hc3RlcnMgd2hpY2gg
dW5yZWdpc3RlciBvbiBzaHV0ZG93biIpDQo+IFJlcG9ydGVkLWJ5OiBSYWZhZWwgUmljaHRlciA8
cmFmYWVsLnJpY2h0ZXJAZ2luLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBWbGFkaW1pciBPbHRlYW4g
PHZsYWRpbWlyLm9sdGVhbkBueHAuY29tPg0KPiAtLS0NCj4gwqBuZXQvZHNhL2RzYTIuYyB8IDI1
ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvZHNhL2RzYTIu
YyBiL25ldC9kc2EvZHNhMi5jDQo+IGluZGV4IDkwOWIwNDVjOWIxMS4uZTQ5OGM5MjdjM2QwIDEw
MDY0NA0KPiAtLS0gYS9uZXQvZHNhL2RzYTIuYw0KPiArKysgYi9uZXQvZHNhL2RzYTIuYw0KPiBA
QCAtMTc4NCw3ICsxNzg0LDYgQEAgRVhQT1JUX1NZTUJPTF9HUEwoZHNhX3VucmVnaXN0ZXJfc3dp
dGNoKTsNCj4gwqB2b2lkIGRzYV9zd2l0Y2hfc2h1dGRvd24oc3RydWN0IGRzYV9zd2l0Y2ggKmRz
KQ0KPiDCoHsNCj4gwqAJc3RydWN0IG5ldF9kZXZpY2UgKm1hc3RlciwgKnNsYXZlX2RldjsNCj4g
LQlMSVNUX0hFQUQodW5yZWdpc3Rlcl9saXN0KTsNCj4gwqAJc3RydWN0IGRzYV9wb3J0ICpkcDsN
Cj4gwqANCj4gwqAJbXV0ZXhfbG9jaygmZHNhMl9tdXRleCk7DQo+IEBAIC0xNzk1LDI1ICsxNzk0
LDEzIEBAIHZvaWQgZHNhX3N3aXRjaF9zaHV0ZG93bihzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+
IMKgCQlzbGF2ZV9kZXYgPSBkcC0+c2xhdmU7DQo+IMKgDQo+IMKgCQluZXRkZXZfdXBwZXJfZGV2
X3VubGluayhtYXN0ZXIsIHNsYXZlX2Rldik7DQo+IC0JCS8qIEp1c3QgdW5saW5raW5nIG91cnNl
bHZlcyBhcyB1cHBlcnMgb2YgdGhlIG1hc3RlciBpcyBub3QNCj4gLQkJICogc3VmZmljaWVudC4g
V2hlbiB0aGUgbWFzdGVyIG5ldCBkZXZpY2UgdW5yZWdpc3RlcnMsIHRoYXQgd2lsbA0KPiAtCQkg
KiBhbHNvIGNhbGwgZGV2X2Nsb3NlLCB3aGljaCB3ZSB3aWxsIGNhdGNoIGFzIE5FVERFVl9HT0lO
R19ET1dODQo+IC0JCSAqIGFuZCB0cmlnZ2VyIGEgZGV2X2Nsb3NlIG9uIG91ciBvd24gZGV2aWNl
cyAoZHNhX3NsYXZlX2Nsb3NlKS4NCj4gLQkJICogSW4gdHVybiwgdGhhdCB3aWxsIGNhbGwgZGV2
X21jX3Vuc3luYyBvbiB0aGUgbWFzdGVyJ3MgbmV0DQo+IC0JCSAqIGRldmljZS4gSWYgdGhlIG1h
c3RlciBpcyBhbHNvIGEgRFNBIHN3aXRjaCBwb3J0LCB0aGlzIHdpbGwNCj4gLQkJICogdHJpZ2dl
ciBkc2Ffc2xhdmVfc2V0X3J4X21vZGUgd2hpY2ggd2lsbCBjYWxsIGRldl9tY19zeW5jIG9uDQo+
IC0JCSAqIGl0cyBvd24gbWFzdGVyLiBMb2NrZGVwIHdpbGwgY29tcGxhaW4gYWJvdXQgdGhlIGZh
Y3QgdGhhdA0KPiAtCQkgKiBhbGwgY2FzY2FkZWQgbWFzdGVycyBoYXZlIHRoZSBzYW1lIGRzYV9t
YXN0ZXJfYWRkcl9saXN0X2xvY2tfa2V5LA0KPiAtCQkgKiB3aGljaCBpdCBub3JtYWxseSB3b3Vs
ZCBub3QgZG8gaWYgdGhlIGNhc2NhZGVkIG1hc3RlcnMgd291bGQNCj4gLQkJICogYmUgaW4gYSBw
cm9wZXIgdXBwZXIvbG93ZXIgcmVsYXRpb25zaGlwLCB3aGljaCB3ZSd2ZSBqdXN0DQo+IC0JCSAq
IGRlc3Ryb3llZC4NCj4gLQkJICogVG8gc3VwcHJlc3MgdGhlIGxvY2tkZXAgd2FybmluZ3MsIGxl
dCdzIGFjdHVhbGx5IHVucmVnaXN0ZXINCj4gLQkJICogdGhlIERTQSBzbGF2ZSBpbnRlcmZhY2Vz
IHRvbywgdG8gYXZvaWQgdGhlIG5vbnNlbnNpY2FsDQo+IC0JCSAqIG11bHRpY2FzdCBhZGRyZXNz
IGxpc3Qgc3luY2hyb25pemF0aW9uIG9uIHNodXRkb3duLg0KPiAtCQkgKi8NCj4gLQkJdW5yZWdp
c3Rlcl9uZXRkZXZpY2VfcXVldWUoc2xhdmVfZGV2LCAmdW5yZWdpc3Rlcl9saXN0KTsNCj4gwqAJ
fQ0KPiAtCXVucmVnaXN0ZXJfbmV0ZGV2aWNlX21hbnkoJnVucmVnaXN0ZXJfbGlzdCk7DQo+ICsN
Cj4gKwkvKiBEaXNjb25uZWN0IGZyb20gZnVydGhlciBuZXRkZXZpY2Ugbm90aWZpZXJzIG9uIHRo
ZSBtYXN0ZXIsDQo+ICsJICogc2luY2UgbmV0ZGV2X3VzZXNfZHNhKCkgd2lsbCBub3cgcmV0dXJu
IGZhbHNlLg0KPiArCSAqLw0KPiArCWRzYV9zd2l0Y2hfZm9yX2VhY2hfY3B1X3BvcnQoZHAsIGRz
KQ0KPiArCQlkcC0+bWFzdGVyLT5kc2FfcHRyID0gTlVMTDsNCg0KVGhpcyBpcyB1bmZvcnR1bmF0
ZWx5IHJhY3kgYW5kIGxlYWRzIHRvIG90aGVyIHBhbmljczoNCg0KVW5hYmxlIHRvIGhhbmRsZSBr
ZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1YWwgYWRkcmVzcyAwMDAwMDAw
MDAwMDAwMDEwDQpDUFU6IDAgUElEOiAxMiBDb21tOiBrc29mdGlycWQvMCBUYWludGVkOiBHICAg
ICAgICAgICBPICAgICAgIDYuMS45OStnaXRiNzc5M2I3ZDliMzUgIzENCnBjIDogbGFuOTMwM19y
Y3YrMHg2NC8weDIxMA0KbHIgOiBsYW45MzAzX3JjdisweDE0OC8weDIxMA0KQ2FsbCB0cmFjZToN
CiBsYW45MzAzX3JjdisweDY0LzB4MjEwDQogZHNhX3N3aXRjaF9yY3YrMHgxZDgvMHgzNTANCiBf
X25ldGlmX3JlY2VpdmVfc2tiX2xpc3RfY29yZSsweDFmOC8weDIyMA0KIG5ldGlmX3JlY2VpdmVf
c2tiX2xpc3RfaW50ZXJuYWwrMHgxOGMvMHgyYTQNCiBuYXBpX2dyb19yZWNlaXZlKzB4MjM4LzB4
MjU0DQogZmVjX2VuZXRfcnhfbmFwaSsweDgzMC8weGU2MA0KIF9fbmFwaV9wb2xsKzB4NDAvMHgy
MTANCiBuZXRfcnhfYWN0aW9uKzB4MTM4LzB4MmQwDQoNCkV2ZW4gdGhvdWdoIGRzYV9zd2l0Y2hf
cmN2KCkgY2hlY2tzIA0KDQogICAgICAgIGlmICh1bmxpa2VseSghY3B1X2RwKSkgew0KICAgICAg
ICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KICAgICAgICAgICAgICAgIHJldHVybiAwOw0KICAg
ICAgICB9DQoNCmlmIGRzYV9zd2l0Y2hfc2h1dGRvd24oKSBoYXBwZW5zIHRvIHplcm8gZHNhX3B0
ciBiZWZvcmUNCmRzYV9jb25kdWl0X2ZpbmRfdXNlcihkZXYsIDAsIHBvcnQpIGNhbGwsIHRoZSBs
YXR0ZXIgd2lsbCBkZXJlZmVyZW5jZSBkc2FfcHRyPT1OVUxMOg0KDQpzdGF0aWMgaW5saW5lIHN0
cnVjdCBuZXRfZGV2aWNlICpkc2FfY29uZHVpdF9maW5kX3VzZXIoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgZGV2aWNlLCBpbnQgcG9ydCkNCnsNCiAgICAgICAgc3RydWN0IGRzYV9wb3J0ICpj
cHVfZHAgPSBkZXYtPmRzYV9wdHI7DQogICAgICAgIHN0cnVjdCBkc2Ffc3dpdGNoX3RyZWUgKmRz
dCA9IGNwdV9kcC0+ZHN0Ow0KDQpJIGJlbGlldmUgdGhlcmUgYXJlIG90aGVyIHJhY2UgcGF0dGVy
bnMgYXMgd2VsbCBpZiB3ZSBjb25zaWRlciBhbGwgcG9zc2libGUNCg0Kc3RhdGljIGludCBkc2Ff
c3dpdGNoX3JjdihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LA0K
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcGFja2V0X3R5cGUgKnB0LCBzdHJ1Y3Qg
bmV0X2RldmljZSAqdW51c2VkKQ0Kew0KICAgICAgICBzdHJ1Y3QgbWV0YWRhdGFfZHN0ICptZF9k
c3QgPSBza2JfbWV0YWRhdGFfZHN0KHNrYik7DQogICAgICAgIHN0cnVjdCBkc2FfcG9ydCAqY3B1
X2RwID0gZGV2LT5kc2FfcHRyOw0KDQouLi4NCg0KICAgICAgICAgICAgICAgIG5za2IgPSBjcHVf
ZHAtPnJjdihza2IsIGRldik7DQoNCj4gwqANCj4gwqAJcnRubF91bmxvY2soKTsNCj4gwqAJbXV0
ZXhfdW5sb2NrKCZkc2EyX211dGV4KTsNCg0KSSdtIG5vdCBzdXJlIHRoZXJlIGlzIGEgc2FmZSB3
YXkgdG8gemVybyBkc2FfcHRyIHdpdGhvdXQgZW5zdXJpbmcgdGhlIHBvcnQNCmlzIGRvd24gYW5k
IHRoZXJlIGlzIG5vIG9uZ29pbmcgcmVjZWl2ZSBpbiBwYXJhbGxlbC4NCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

