Return-Path: <netdev+bounces-239608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D5C6A2DA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1317B4E5CC4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E43435E539;
	Tue, 18 Nov 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gp5bSlqh"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010068.outbound.protection.outlook.com [52.101.85.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D743735B15D;
	Tue, 18 Nov 2025 14:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763477711; cv=fail; b=HeM22d4GhJc4H72udjzuoVwCpBM29eLXDmN3SXsDvcsSh/eQzdcf1ZVVt74pTqjrYeWSP24ZPPG6VV7hbkyXOqWT6xNNHWMWlgSZAr7nKMh5a5SPa5f06P4rrdUXok/V0+XRSaBP/bVDdAwJve/xrYU05E0B/7HERl4AWVaozCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763477711; c=relaxed/simple;
	bh=la2vEyFoFcToRRUPdWxsB11ImzG5/llRUb7laWIuj4I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tK6euNpsYV3FNVVgFRpAypm5GYHFFCzBn4VHEGcfBUzIMtV+Zf0y+MJWVjN6WxyyIeEB2zJNE1S8mOoeezOH7SVaFlDvBLQUBSZ8wBV2L/xntFFpyTmwhHNmr9pfyFILCGaPAJmrdmT8zJBoV3UPAYvwM6UPXKvv1Lpr0gSFG0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gp5bSlqh; arc=fail smtp.client-ip=52.101.85.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtMoKEE3m3GvlbgvS6S1Q1uCMQ21ESrpXr/c8PPP2JhngiMOtuCMBKYmVInBExS80SqNAeHpyKbZKboIQk1H5zDRRyPfOoXGh6Tfjc+gv6mFoVq1eLkHqgwdiBWkOHTMiv1SadrF9Q7wjgM9jMMpdhqVR6ic0yrbSNSsHsggwPMBBgPDoISv6xGJy5tCnti3DP0QsoUpAvEpYxgugmZ0ZHtc/4BRrGyg0bbHcttu+d0I6nLWbhf7bVevvLuMI14pDuEM0aSmwmDLSpScDl96MNp9ZMbqAWlO6lUG2c5ltEM/cE72GdghQ5hk/4Rk98ahcpnbQmopqPnZH82R7h0Kfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9rh7OAhM+tucTUcZNIlqmA/3iBfUoy8c1FkxqMIsgw=;
 b=KFX5xpOqt+P244DzOWswNSnko5D9vsmsPEGroqE09gbZjP2VsKK65tgkNn81j7SieTdKWNqzhxm5HIkGuHO3GpxGZgN8oQ5J+8DpxH4HNtN+s50IKRKir8jE9FXLW0BnBoj73MLJ3lP7kItz6f5T4M8XV5tgjWw3JYDvZfgOR8SbN/il2ZORGSkqH3o06L9bFIEbLXBM5/2IQHvY1b2jPb87z/xbpCAe/gTSa1r4i2UaXf1g68i+xdpPCiNlryunWzcfFFvEc/KqfndR7I7/fPLx0YGJGfpBJiAQ/dO8MAG1UcxgEpOkF6jQKTwKMpne9MWD5kddKbL58KK2Z1QhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9rh7OAhM+tucTUcZNIlqmA/3iBfUoy8c1FkxqMIsgw=;
 b=gp5bSlqh2PzwqGJVrDn1oAbdHqXckoL/VID9K9zwC0NabMrv3ATiIRUEi9Ru89E5zqD/O046C49C8pnksDZrgvvjOE95+27PhG2Spc9WWo4uRnu9wexogJ+jGLsLwFPX5s8O8m1Mg/zoe8Ol+82kWopM7EBnIC654JlxJW1bLxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:55:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 14:55:06 +0000
Message-ID: <d7343bd3-3f74-48b6-8d8a-4d486af6e0a1@amd.com>
Date: Tue, 18 Nov 2025 14:55:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/22] cxl: Move pci generic code
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Ben Cheatham <benjamin.cheatham@amd.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251110153657.2706192-1-alejandro.lucero-palau@amd.com>
 <20251110153657.2706192-7-alejandro.lucero-palau@amd.com>
 <aRZ25zHGGDyhqUlS@aschofie-mobl2.lan>
 <c8efb22b-57c7-4db5-8986-72b1b2cf605b@amd.com>
 <aRkx3OhRHQrCEhow@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aRkx3OhRHQrCEhow@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: 07afecbd-8d3f-4ef2-c139-08de26b27657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUl3M1E2dFlKRWQrc2dVdlhWVWROZmJFYkQrNUwrUVVJNFBDdXA0dWJSSDdz?=
 =?utf-8?B?bjFtbTlNRmdPRE9oTXcrZDh3UmM5VjVVQ0QvS2kyY0dYWGhVQUlOUVhLZ00v?=
 =?utf-8?B?RzFhTkN2L3Avb3pnRVZNQ3ZmcTdiRmh0ZkhzeEJlQ0JUYmxKbW1qZU9VMUFr?=
 =?utf-8?B?cFlrMFJidUx0WHJFTjFFSm9XRUJ6YVdhWnBjcjRLQ0xvVG96dXpaa3liTTR1?=
 =?utf-8?B?TGlrV0M3aU8zSWE0bzJDZ3dCY3pLS2dPNlZJQ3RYMTEyLzI0WHB5Yzl4VnZD?=
 =?utf-8?B?WVgveFBlUityalF5QkJrWGdLc3J1eCtlZnY3YTJNTW9IZzVrQWVkdDJsKzhs?=
 =?utf-8?B?R0dwVjExNDdsN2FWa0pFbXdnVTR1WFR3NjRWUGJWWUg5eUR5Ymg1dUZxeU9y?=
 =?utf-8?B?cGNZV2xhNDdNdHBmbnc1VU45emJUY1J0cmNUaHFhQ1c4SnE1VWczQ2V2bVI1?=
 =?utf-8?B?eG4rclRvRVpHejE1S2dRaXMrTnQvT29sNytDWWFIMnZJSTJwc1NBdElxY05w?=
 =?utf-8?B?ZjU4N3NNQ3JTeGgrTHZreXRXWko2R0NkTEV4NDZwRCtJd2lUYkpnVkNkZmRs?=
 =?utf-8?B?amRuWlBnaUd2T0ZraklHT25rbFZhUkljeTcxMytRTmdublBUNFFZL1ZsMDNY?=
 =?utf-8?B?TGo4S3FKaTBwT05KSEdaU2ZWUTVIbmtQRWt0UUVjbVFXY21JSVk4Z01OZWhI?=
 =?utf-8?B?SmpIV0hibUM2SEFtdUJoeTJFT3RZVFJhbWNkWEpvSTU1SVRMVlZMWlBKK3Rs?=
 =?utf-8?B?T1JoTmhuVFg5TFhMSnZvVUZ4YXJlZVNNUGdqTFZLMzdGK0RrVjdEQnhKSzIr?=
 =?utf-8?B?K0g5ZlVzZmg4R09RVXFxUWFSQ3dJa1hqb3cwSEdoejVET0lKVGliem02cXds?=
 =?utf-8?B?WG5FcXNTWlg0djcvalZoTHFEUTg2dW9XN3BlZ0ltRUxGV2g2eWR4VEM0MEtj?=
 =?utf-8?B?R1Z5MERYVW9XdU1iZm1RcE04UHp4NjhKbkswTTJtRGF6TVZRS2N3eGNnMEpR?=
 =?utf-8?B?aVQwWmppQXErcExub2tsdHZ0OFh5TjhpcU1nM1ZEMkNaWmR1Mm9CZHliTXpS?=
 =?utf-8?B?SWlTNDJJZ2gzUTR6M3h3MmpTU1VINVVVeW00eDFhS1NkVXd1NkFoU0RXbnRM?=
 =?utf-8?B?cUVFeW15SzhXS25RVFArRzRuZUx1MUZIS2ZORk9yYXVNOGYzYlJCa3NHZStt?=
 =?utf-8?B?SzNsOSsySmgxYTlZNWxQRmp4NFN4RGpsVjJKVFF1NGFkOTE5bHlMZ2tUZ2JY?=
 =?utf-8?B?N2FzZTBVN0UrR2x0NjBpRXNYRmFRYmo5ekRnTHVSY1YrQUVLb2RvMGF0YVJm?=
 =?utf-8?B?NlhuL1d1ZEtzZDFqVTh4SjVsSjkzNjNmeVRSTEFMeVdTM05mVzdiQWU5ekZw?=
 =?utf-8?B?d05tcHNCdzNZNVRBbDFKM2h6d201S0grTGpiWC9DdlM1T1FOdjR6Y04zalkv?=
 =?utf-8?B?VE94aDRFbUdLOW5XNFRwZXBEUnNwTmpMeXNJMTB3UTFZK1M2K05LUlMyUHNK?=
 =?utf-8?B?K0V3TjZkTE40VWRFOXNtWUVCOHhTMlNsZUNiWU9tT0h3NnFtanNUeFV4WTdq?=
 =?utf-8?B?emMvMFlqRmFiamgvd1BhRU9iY25MTVRGbTdDMTNNUituZHF1cWpKTVVZVVB1?=
 =?utf-8?B?WUJqMVpQTVJ2ZEttd1ZWTFFIdlBwTXNoenV0RG92eG8vZGIzYnY1RTdibmhM?=
 =?utf-8?B?a29zUGxQSlJIS09JVWlBUU43dkxwZEFKOGUrWmpGZFZldWhkQjJEbFY1K2NX?=
 =?utf-8?B?VDlQVzRib2tmaTQyM2dMQWJNTTFEQlJFNjhGZGxRR1luNHhxK0xEaW1pT2di?=
 =?utf-8?B?Mk9ZcXJFbURucEl2VFhYbTdra2o3RjY2MGduZWdFa28wUnFYeG56MVpCY3R2?=
 =?utf-8?B?S3IzUXh1U0R3N0c3N2xPbGJWWnRMMUppTHZYTDVSMTY5bjFIdW5nRExqd09s?=
 =?utf-8?Q?G4TE03C4HVSY4Xpl2Pycd4ugbQX1n8gw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wjh6aDFEZjhlMFZvSnlwNmppWlpVT3M0dngyTWR2QlJYWUR2MWhVM0pBTXdX?=
 =?utf-8?B?RERPVzljeklabWl3TGhjNGl3Z05sbGRVS0NHaDBlTnM0OERtanFQcmlQcFgw?=
 =?utf-8?B?NWVVclRiRWtVWEcrYVNjRWNka1J3U0krMzBLVUhmcURDanhnTVlZQnZ4b2tN?=
 =?utf-8?B?RVR0aHB2dm12dklvNnVZZkt6clVjQUJBSm51QXBEWTMrWWM5dm80dVZRRWdR?=
 =?utf-8?B?ajFCYzlnbmZkL205N2hGQTc2R2QrdmJNbW5DR09DNnBUKytFNzByb2pHbllj?=
 =?utf-8?B?V0pmZ0pyalFqQW03VTBHc1k2TFpYd0tmQkRjYUR1cnFZQlhwWU83RWY1S3A2?=
 =?utf-8?B?QUZvTW5RQWp6YTFMdkdIZ3VHYitiR2N1YndQSnNvVFg4SVdNZ0RUUCtZbDJN?=
 =?utf-8?B?Tjc5Q1V5cDlsNGdabHk2SFZkTWt4QXA4OWU2L1BLSkVkZWpwbWF6bDZ4c0hk?=
 =?utf-8?B?amwxdzZrVWs3Ylg2WjRlayszczllVVpRNFlPWU8yL0RRM09JTDhjQ3p3NUN2?=
 =?utf-8?B?dGQ5ME5mM3hJdVRtc3VsSUFEeUpkQVVRcHlNT1NVd3hCUzVMZytiZVkyVlkz?=
 =?utf-8?B?K0Z0TUpRdCtqYnBleHRmNmRyNGx3SnJSWXpUMmxabVFxSVpSTWVadjVtenlR?=
 =?utf-8?B?UUJOQ3RHcUhLZmlyVTBYaU82VTBTVzZmR1ZVV05TUVoya2Jyd0RqdmtJL3Va?=
 =?utf-8?B?Mmp4RGRqOTNidUsraEd0N21tV1NBK2JQSDh5Y2lzTmFhREEzbE1kUHdxLy9V?=
 =?utf-8?B?RUpybUNkSnkwSmlVVmlPV1hOUmxsZ1ZqUFZhSW1EeitnRTFwbEpibEFaNFdQ?=
 =?utf-8?B?T0NuTWNlZkhyaU5qekJoRy9DMDBnNFUwVUlYS1M2cUhXRVJFTGUyQjYxVDdi?=
 =?utf-8?B?RjhSazBxd3E3aXJ4QUpQRGFld240M20xNWhOTmIwOS9rVW5Ub1BISkJvRmw4?=
 =?utf-8?B?UWlWQWZ0Zkp5ZjdaVkQ2Sjl5dVF4T0Zrcm5KQ1U4dWJHR1gwaU82MS9xMWVZ?=
 =?utf-8?B?MTVmZ2JBU3FGY3VyblhWSXl4TVFuYWZSUG5IdnJrU3FJdS9ONFV4K0FibzlP?=
 =?utf-8?B?dEF2K21Sc0NHZS9Gbk5rT1k4RWgwdkw5Q3p5ZE1wK1RXTUtZZDB3N3hRbHJw?=
 =?utf-8?B?M3B6V2llSnV2b2FTQ093dG9EUU9RSXdoYzdQcXpxUk5UZXM5TEc5ZVVpTmpx?=
 =?utf-8?B?Z2hxNGhQSnVFV2llVXpwVkQ2Z1RTNFkwTkJzdkhnS3lXc25MRlVzaE9tZlRB?=
 =?utf-8?B?OUk0b2JvZlZQVW9kQ3RVL3NneFczMDIzZ1VjanVyNnJOaHJLYU8raWMzR0t2?=
 =?utf-8?B?U1pnSndoSGZyeEUrVmJRKzl3Uy9QRlVCNkNNUjR0SWFML2xodVJ1MFU3OU1C?=
 =?utf-8?B?dG52Qm9WTHg4bHdJUzYyaU5mNzRZalpSd1NIbjdUTzRzRDNPbG0reVBpYWJL?=
 =?utf-8?B?UkdjbkpmMGFuTHN5T1l6TWZtS0J6eXBFODNEaUFNL0RUdU4rWTZIZmJVMTVT?=
 =?utf-8?B?cEo2UXV5UmNHcldNMWVQWDNBblEyWjhaVExzaUJGRnhXMjl4ZFVnaU1kQjFm?=
 =?utf-8?B?TVZpVitRVmhmNWRZampnc3BYS3dOR1RnY1hSek8rTWRNSEg3TnAwZGptNFNC?=
 =?utf-8?B?OUlxdTZ5SHVRU29QZXBZRHA4WmJGR0ZPdFV5Zk9kNk82dFlkYWxEeDZnTFdm?=
 =?utf-8?B?TERGN0N5WXdBRmU2enR2b2hjRi9nUGhHVzBtQlZXRnQ3NGhiclR3WXRvY0tq?=
 =?utf-8?B?TVg5U2EyeHlFRFZJam5XNzEvMkpaNjRYTFRyLzhwV1RaemZhZFAyU2hpNEVW?=
 =?utf-8?B?ZFRMTVJJR3hQSTZDZEZoRzNuN1RheGRad3pYb1lGWExYcXlyRFk4OXlOUHNY?=
 =?utf-8?B?RFd6dEE3NGFZcFBqQkZSd0FJMzlaSHZpWTl0cTd6N3JQZjdyNG1Da0JWSXRx?=
 =?utf-8?B?ZXBSenBtTTFmUENqU0JLZDFwTyt4Yk5VU2JnTW1oZFBRWWs5bEFZeGdjUFZU?=
 =?utf-8?B?OFlUVTVLSVRXcEViN1hDSThldnlkN1owS2xaRktSS1h2VWdGUGZsd25FU1hh?=
 =?utf-8?B?Qm9BeCs2Vlh2empDMHBlTkZObzF6NjBuS29kWG5OS29wMVpIa3RKUHhXZUow?=
 =?utf-8?Q?Cg6oS+zYfWuDmqzk1OZzv+fCW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07afecbd-8d3f-4ef2-c139-08de26b27657
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:55:06.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+jZwvzxddFPqckPup6BuRfkVnb8+S517vLfMaaZbrISPE/5d46CLfw4OtT6+AnYafnXHiJ682lX7WACIcAtkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265


On 11/16/25 02:07, Alison Schofield wrote:
> On Sat, Nov 15, 2025 at 08:16:29AM +0000, Alejandro Lucero Palau wrote:
>> On 11/14/25 00:25, Alison Schofield wrote:
>>> On Mon, Nov 10, 2025 at 03:36:41PM +0000, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>>>> meanwhile cxl/pci.c implements the functionality for a Type3 device
>>>> initialization.
>>> Hi Alejandro,
>>>
>>> I'v been looking at Terry's set and the cxl-test build circular
>>> dependencies. I think this patch may be 'stale', at least in
>>> the comments, maybe in the wrapped function it removes.
>>
>> Hi Allison,
>>
>>
>> I think you are right regarding the comments. I did not update them after
>> Terry's changes.
>>
> Here's how it looks to me, and looks odd :
>
> Terry moves the entirety of cxl/pci.c into a new file
> cxl/core/pci_drv.c
>
> Then you move some of the things from that new cxl/core/pci_drv.c
> into the existing cxl/core/pci.c.
>
> My question is, for these pieces that belong in cxl/core/pci.c might
> it be better for Terry just to move them there in the first place?
>
>>>> Move helper functions from cxl/pci.c to cxl/core/pci.c in order to be
>>>> exported and shared with CXL Type2 device initialization.
>>> Terry moves the whole file cxl/pci.c to cxl/core/pci_drv.c.
>>> That is reflected in what you actually do below, but not in this
>>> comment.
>>>
>>>> Fix cxl mock tests affected by the code move, deleting a function which
>>>> indeed was not being used since commit 733b57f262b0("cxl/pci: Early
>>>> setup RCH dport component registers from RCRB").
>>> This I'm having trouble figuring out. I see __wrap_cxl_rcd_component_reg_phys()
>>> deleted below. Why is that OK? The func it wraps is still in use below, ie it's
>>> one you move from core/pci_drv.c to core/pci.c.
>>
>> I think the comment refers to usage inside the tests. Are you having
>> problems or seeing any problem with this removal?
> You may have seen, Terry's set had build problems around that function.
> If you see it is no longer needed, can you spin that off and let's do
> that clean up separately. Correct me if it is indeed tied to this
> patch or patchset. I don't set it.
>
> Thanks!


As I said when replying to Dave, I will send the clean up ahead of v21 
where I will fix the patch description


Thank you


>>
>> Thank you.
>>
>>
>>
>>
>>> For my benefit, what is the intended difference between what will be
>>> in core/pci.c and core/pci_drv.c ?
>>>
>>> --Alison
>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    drivers/cxl/core/core.h       |  3 ++
>>>>    drivers/cxl/core/pci.c        | 62 +++++++++++++++++++++++++++++++
>>>>    drivers/cxl/core/pci_drv.c    | 70 -----------------------------------
>>>>    drivers/cxl/core/regs.c       |  1 -
>>>>    drivers/cxl/cxl.h             |  2 -
>>>>    drivers/cxl/cxlpci.h          | 13 +++++++
>>>>    tools/testing/cxl/Kbuild      |  1 -
>>>>    tools/testing/cxl/test/mock.c | 17 ---------
>>>>    8 files changed, 78 insertions(+), 91 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
>>>> index a7a0838c8f23..2b2d3af0b5ec 100644
>>>> --- a/drivers/cxl/core/core.h
>>>> +++ b/drivers/cxl/core/core.h
>>>> @@ -232,4 +232,7 @@ static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
>>>>    static inline int cxl_pci_driver_init(void) { return 0; }
>>>>    static inline void cxl_pci_driver_exit(void) { }
>>>>    #endif
>>>> +
>>>> +resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>> +					   struct cxl_dport *dport);
>>>>    #endif /* __CXL_CORE_H__ */
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index a66f7a84b5c8..566d57ba0579 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -775,6 +775,68 @@ bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port)
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_reset_detected, "CXL");
>>>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>>> +				  struct cxl_register_map *map,
>>>> +				  struct cxl_dport *dport)
>>>> +{
>>>> +	resource_size_t component_reg_phys;
>>>> +
>>>> +	*map = (struct cxl_register_map) {
>>>> +		.host = &pdev->dev,
>>>> +		.resource = CXL_RESOURCE_NONE,
>>>> +	};
>>>> +
>>>> +	struct cxl_port *port __free(put_cxl_port) =
>>>> +		cxl_pci_find_port(pdev, &dport);
>>>> +	if (!port)
>>>> +		return -EPROBE_DEFER;
>>>> +
>>>> +	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>>>> +	if (component_reg_phys == CXL_RESOURCE_NONE)
>>>> +		return -ENXIO;
>>>> +
>>>> +	map->resource = component_reg_phys;
>>>> +	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>>> +	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>> +			      struct cxl_register_map *map)
>>>> +{
>>>> +	int rc;
>>>> +
>>>> +	rc = cxl_find_regblock(pdev, type, map);
>>>> +
>>>> +	/*
>>>> +	 * If the Register Locator DVSEC does not exist, check if it
>>>> +	 * is an RCH and try to extract the Component Registers from
>>>> +	 * an RCRB.
>>>> +	 */
>>>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>>>> +		struct cxl_dport *dport;
>>>> +		struct cxl_port *port __free(put_cxl_port) =
>>>> +			cxl_pci_find_port(pdev, &dport);
>>>> +		if (!port)
>>>> +			return -EPROBE_DEFER;
>>>> +
>>>> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +
>>>> +		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>>>> +		if (rc)
>>>> +			return rc;
>>>> +
>>>> +	} else if (rc) {
>>>> +		return rc;
>>>> +	}
>>>> +
>>>> +	return cxl_setup_regs(map);
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_pci_setup_regs, "CXL");
>>>> +
>>>>    int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c)
>>>>    {
>>>>    	int speed, bw;
>>>> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/core/pci_drv.c
>>>> index 18ed819d847d..a35e746e6303 100644
>>>> --- a/drivers/cxl/core/pci_drv.c
>>>> +++ b/drivers/cxl/core/pci_drv.c
>>>> @@ -467,76 +467,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
>>>>    	return 0;
>>>>    }
>>>> -/*
>>>> - * Assume that any RCIEP that emits the CXL memory expander class code
>>>> - * is an RCD
>>>> - */
>>>> -static bool is_cxl_restricted(struct pci_dev *pdev)
>>>> -{
>>>> -	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>>>> -}
>>>> -
>>>> -static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>>>> -				  struct cxl_register_map *map,
>>>> -				  struct cxl_dport *dport)
>>>> -{
>>>> -	resource_size_t component_reg_phys;
>>>> -
>>>> -	*map = (struct cxl_register_map) {
>>>> -		.host = &pdev->dev,
>>>> -		.resource = CXL_RESOURCE_NONE,
>>>> -	};
>>>> -
>>>> -	struct cxl_port *port __free(put_cxl_port) =
>>>> -		cxl_pci_find_port(pdev, &dport);
>>>> -	if (!port)
>>>> -		return -EPROBE_DEFER;
>>>> -
>>>> -	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>>>> -	if (component_reg_phys == CXL_RESOURCE_NONE)
>>>> -		return -ENXIO;
>>>> -
>>>> -	map->resource = component_reg_phys;
>>>> -	map->reg_type = CXL_REGLOC_RBI_COMPONENT;
>>>> -	map->max_size = CXL_COMPONENT_REG_BLOCK_SIZE;
>>>> -
>>>> -	return 0;
>>>> -}
>>>> -
>>>> -static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>> -			      struct cxl_register_map *map)
>>>> -{
>>>> -	int rc;
>>>> -
>>>> -	rc = cxl_find_regblock(pdev, type, map);
>>>> -
>>>> -	/*
>>>> -	 * If the Register Locator DVSEC does not exist, check if it
>>>> -	 * is an RCH and try to extract the Component Registers from
>>>> -	 * an RCRB.
>>>> -	 */
>>>> -	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>>>> -		struct cxl_dport *dport;
>>>> -		struct cxl_port *port __free(put_cxl_port) =
>>>> -			cxl_pci_find_port(pdev, &dport);
>>>> -		if (!port)
>>>> -			return -EPROBE_DEFER;
>>>> -
>>>> -		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>>>> -		if (rc)
>>>> -			return rc;
>>>> -
>>>> -		rc = cxl_dport_map_rcd_linkcap(pdev, dport);
>>>> -		if (rc)
>>>> -			return rc;
>>>> -
>>>> -	} else if (rc) {
>>>> -		return rc;
>>>> -	}
>>>> -
>>>> -	return cxl_setup_regs(map);
>>>> -}
>>>> -
>>>>    static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>>    {
>>>>    	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
>>>> index fb70ffbba72d..fc7fbd4f39d2 100644
>>>> --- a/drivers/cxl/core/regs.c
>>>> +++ b/drivers/cxl/core/regs.c
>>>> @@ -641,4 +641,3 @@ resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>>    		return CXL_RESOURCE_NONE;
>>>>    	return __rcrb_to_component(dev, &dport->rcrb, CXL_RCRB_UPSTREAM);
>>>>    }
>>>> -EXPORT_SYMBOL_NS_GPL(cxl_rcd_component_reg_phys, "CXL");
>>>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>>>> index 1517250b0ec2..536c9d99e0e6 100644
>>>> --- a/drivers/cxl/cxl.h
>>>> +++ b/drivers/cxl/cxl.h
>>>> @@ -222,8 +222,6 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>>    		      struct cxl_register_map *map);
>>>>    int cxl_setup_regs(struct cxl_register_map *map);
>>>>    struct cxl_dport;
>>>> -resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
>>>> -					   struct cxl_dport *dport);
>>>>    int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>>>>    #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>>> index 3526e6d75f79..24aba9ff6d2e 100644
>>>> --- a/drivers/cxl/cxlpci.h
>>>> +++ b/drivers/cxl/cxlpci.h
>>>> @@ -74,6 +74,17 @@ static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
>>>>    	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
>>>>    }
>>>> +/*
>>>> + * Assume that the caller has already validated that @pdev has CXL
>>>> + * capabilities, any RCiEP with CXL capabilities is treated as a
>>>> + * Restricted CXL Device (RCD) and finds upstream port and endpoint
>>>> + * registers in a Root Complex Register Block (RCRB).
>>>> + */
>>>> +static inline bool is_cxl_restricted(struct pci_dev *pdev)
>>>> +{
>>>> +	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
>>>> +}
>>>> +
>>>>    int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>>>    struct cxl_dev_state;
>>>>    void read_cdat_data(struct cxl_port *port);
>>>> @@ -89,4 +100,6 @@ static inline void cxl_uport_init_ras_reporting(struct cxl_port *port,
>>>>    						struct device *host) { }
>>>>    #endif
>>>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>>> +		       struct cxl_register_map *map);
>>>>    #endif /* __CXL_PCI_H__ */
>>>> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
>>>> index d8b8272ef87b..d422c81cefa3 100644
>>>> --- a/tools/testing/cxl/Kbuild
>>>> +++ b/tools/testing/cxl/Kbuild
>>>> @@ -7,7 +7,6 @@ ldflags-y += --wrap=nvdimm_bus_register
>>>>    ldflags-y += --wrap=devm_cxl_port_enumerate_dports
>>>>    ldflags-y += --wrap=cxl_await_media_ready
>>>>    ldflags-y += --wrap=devm_cxl_add_rch_dport
>>>> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>>>>    ldflags-y += --wrap=cxl_endpoint_parse_cdat
>>>>    ldflags-y += --wrap=cxl_dport_init_ras_reporting
>>>>    ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
>>>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>>>> index 995269a75cbd..92fd5c69bef3 100644
>>>> --- a/tools/testing/cxl/test/mock.c
>>>> +++ b/tools/testing/cxl/test/mock.c
>>>> @@ -226,23 +226,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>>>>    }
>>>>    EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>>>> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
>>>> -						  struct cxl_dport *dport)
>>>> -{
>>>> -	int index;
>>>> -	resource_size_t component_reg_phys;
>>>> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>>>> -
>>>> -	if (ops && ops->is_mock_port(dev))
>>>> -		component_reg_phys = CXL_RESOURCE_NONE;
>>>> -	else
>>>> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
>>>> -	put_cxl_mock_ops(index);
>>>> -
>>>> -	return component_reg_phys;
>>>> -}
>>>> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
>>>> -
>>>>    void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>>>>    {
>>>>    	int index;
>>>> -- 
>>>> 2.34.1
>>>>

