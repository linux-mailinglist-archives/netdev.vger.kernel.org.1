Return-Path: <netdev+bounces-214897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D9CB2BAC3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 09:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D627A4299
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 07:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6638F2848AD;
	Tue, 19 Aug 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b="qxFesbXn"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023098.outbound.protection.outlook.com [40.107.162.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B943451B8;
	Tue, 19 Aug 2025 07:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588609; cv=fail; b=UNLRyAoawXAIPvqfznwr/kgFBrOM4FrbJAr/rsvcxWc5dqzCPF9uV6MbEOSiRJXGh+EGwPo2phsHZW1E1uSngKrGe5pkils9hgrSmIkp3taZWxHKQzRMT6KtF+8EX3yRNFOW2bl6NF6qb2SHrw9DzfSUtKY5TSDb+y5SujBVlu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588609; c=relaxed/simple;
	bh=iigVlsRbHCdPjSWPfEah72ofOOg53DjsJ76tyvxO7OE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QjxhacMzOVf7JZGkvFb1knpQGyhna0mNdeRLGHGkczPyWRadF2fnsUxDVVt5GeyWUNpH1AQisV4zu+Ub1KrDzVXFaXsQsBOME/8DSiHMp7+QXF/bGex3+07IYcFJS0w7DVT26K/YjNudN6PmpH9OuLir5GeYsUdjmwWbcIBY4ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (2048-bit key) header.d=kontron.de header.i=@kontron.de header.b=qxFesbXn; arc=fail smtp.client-ip=40.107.162.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLDYVylmfLKQ4TkXeavMVAVjiLQMTl1MBg5BZQJRGh891uIytcF9f9msL6s9jH0N2DeXtK40s0+CfIGKzh6bGqbKHVx1BXM0+cNHyBwJ9MNMId+iK787T1j4YZfc5L4xUgnebEZH2SNVbwE6TPr9G9SsmRz/L68vaa/KxsaiiJK/eF+NGbuOPnXqHr+tzazkrVwIW9w3QsVL/WqlHHluGNIKmuIefl8Le67OCn8sMIUA7EKhi+AcpDP7YLKl888+gHuDxDz9UCuScoS3kDb/zNeyXhBmQN58Do/ygSCnGB87k2/uGh/0K7vpdjatLtE+SlMewWmD6V62iJfaiYxtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSMX6DUhcQHxSYoG5YYTozDNiyT5dXUhhRfZfUMr8PY=;
 b=l4dPv8seubY9eWs9lZDyIqyu0Hh2G1oDRdX750gyRaN2bFW2ZtGEnwA4OPPjCHIUMeCfl1bHpXYXhssR391Ve48E+V3dZECIITHERoPNHSjT35O6w4PmSh+WxQQ3vV9rKKx9PLWeDt2US5Pv2iFDJPwzdMH+7CH6fKhvGulG+4Ojko74LyRKdBP5XGAHJTHJK7nwHyRT7ZzZn5Z7XZNB22h5OVF4SYprW1LBK5XNnHApvILmWWDxTdEnElzEnw/NkIWf4UqnDWMRAgbFHSb8mYDP35I13S2kfpxoqqT0fqOUbmfFcudpcCZAsdhXFd3rh+MUnP4hYb0hj0rIZO8AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSMX6DUhcQHxSYoG5YYTozDNiyT5dXUhhRfZfUMr8PY=;
 b=qxFesbXn5OI94SUyP/v0BoH3eYSCXJLASHNzhwjoBq2T2ufcG1LGJNNQU3ojz2UJ4Qmysm1b9nPAJu/8OqAm0bshyEsa4VIs/Q07lvRN+kv5KWuT0NQLwdCpCEy6WYFl5pg1m/x/IuHqmLri6qKZ5vC40UA78/9vGakIKQSWJN6627LjvyWuER0+pwNuzYTEWOqRNDGMrGYc6IGdA/96689VOuG8PQnQplQPd9nOcGcWoaFT5xE9gIFsce9066kbnJwajwtxP06/zCXjZczGkFb0zYdaK8sMV2ow6fXrPUSLVX7A+MEFViXVYOh8dEK4BJMQjFJNA3O5a/CjkFICeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB7582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:30:03 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:30:03 +0000
Message-ID: <8d6b7043-54f0-4184-ad29-3ef3ef4f7b05@kontron.de>
Date: Tue, 19 Aug 2025 09:30:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: microchip: Fix KSZ9477 HSR port setup issue
To: Tristram.Ha@microchip.com, Woojung Huh <woojung.huh@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819010457.563286-1-Tristram.Ha@microchip.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250819010457.563286-1-Tristram.Ha@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0334.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d46bff3-e963-4fb2-61f5-08dddef23671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3YvQXJrSnd0MkxPM21zN0MxQmJFRERxNFdqTVF0eS9qM25XUUtjV3JDL2wr?=
 =?utf-8?B?L2FQalVSUW5EU25wNmRwK2p1Rk5oR1VYSmM4YkdJc0Jqemp1UzFGOC94KzQ4?=
 =?utf-8?B?dnNZVGpXYjMydTg0bkorNDhIeWpxb0pVMGtVelp4cEVDeXBCdlAzTVF2UU81?=
 =?utf-8?B?byt1NWJSNHpaNGViaktEVWdxZVhSUUgzQnZpTCtSbnNJcExrem9kS0xmNE5Y?=
 =?utf-8?B?RVh4aUdIblB6VS9yR3VRd0JtNnY3amJXaEtnbE9Gb3AwcFpBQ09uOVVwTGJl?=
 =?utf-8?B?aVVGbmE0ZUR5V0tQZEY5NEQ3YjZCWlptU3VQVlc4SUhuejJkNWwreE9nQ3c5?=
 =?utf-8?B?ZnFnRzFSaUVJU3Q0bWg1RUpuWnoxVXkyeWZDNEJWZE0zZ3NvL3Y0bVlPVnRn?=
 =?utf-8?B?MVBVZVJHR2RuT0piNmdNdEVGa2FpcUFEb2xVc09jeE5XNTI0R3FQaDh3cmIz?=
 =?utf-8?B?VHIweUV0Y01LS0RCK0txRzIrcStuVktMeVFCdlExQ0Y2NU0vck1XSmY3b3Ft?=
 =?utf-8?B?Y3AxcUFxOEhRNHIzUm5DYmVXSHhiQnNqaElxMWlodDYvZFBBTk5pNThJTURE?=
 =?utf-8?B?TmpCRHZ6OHdSZXkyTitVRFRvSHJWN2dxQ0xMaE1oaEE4Y253Vy9BMForT0Fk?=
 =?utf-8?B?TnNadXlhd3pscTFQcmdXQ3dKU3gyaUxDYzZ5ZnJpUnFsUzZGRUFRQUJseXZw?=
 =?utf-8?B?VjJPTjdub25OcmtOaGd5ZEdwZ2FkeERiVmlVaHdvdzc5RWJya3A2alFBbk11?=
 =?utf-8?B?VkhjYkRqYUR1RFhvOGJnY2NEbU9JU0dzQ1BRMldOenlrTG1NdlJPMzNBbUtQ?=
 =?utf-8?B?MzRGNFVjOHF2UmlRdjByZ29OUE93S21pemgzUHgzWHNyTGR6UHphMlA2ZTNL?=
 =?utf-8?B?ajMrOWpNMk5mRnArWXN6SXVDMDN5dnZzdmQ0eDZDQ2JuTjdJa2lzYVdWUDkv?=
 =?utf-8?B?czBnRTM3SGFtUzcvenUvbVRESHFtdkZtUkgvRTQ1YXRRMEplVjJoYWlQczAr?=
 =?utf-8?B?SndtNVIxSlpUY0k4VDl1MHowZDJJY2pFUWVvSlo3RDI4RFpKdmI3UUkvc2lr?=
 =?utf-8?B?cDdpUk5Tc2VwRmpjQkNvVVU2M3VDVkpQV1V5TlAxN2Rvb2ZGd0x1WkFtUmNO?=
 =?utf-8?B?Z3J6NG4zY0FPYWpGeUl0cTNobVhGWWhxUzEwM05TUVFWMnd0RVFEM3kvQlhY?=
 =?utf-8?B?YTVvTkVzZTBmNFgyUGU2aTU5aWxscHgxU0g5UEtGeGVnb0ZubzF0ejNUWUk4?=
 =?utf-8?B?T2NmRzFNa2N0QlU4MUlpNGZkcnVnbmloYnkydFRMUVNLNEVTYi83Tzc4c2pG?=
 =?utf-8?B?NnNkMnI0aXpqMzc3M05IeGh1QXFnUVpYeHpzMlBWdlYzQXFzMFlzaDBqeFBu?=
 =?utf-8?B?WmRDcHh2Q2tiUG1JSHkycDVoa2NzL0FFMW5XL1NxM01sa2M3cFU3Z0FtLzFs?=
 =?utf-8?B?UUU2aElVdjdlOEM2SGxnTUl2bXlpeS9VSXBFb2prTmFJc0xETm5KREZ3Rito?=
 =?utf-8?B?dUxxOFplcXFmUGM1cjcya3N2alpnTUg5WlZtSS9nNFZkcHVjZlRjd2hnK1Bj?=
 =?utf-8?B?RVlXMHRMQWxFck16ZzM3MXA4S0JPNUZnZ3VFZy9seHVIb0sveVNzdVlZbkRK?=
 =?utf-8?B?Yms1Y0lkeXk5NHlHZmlFMXBwZm9kOG5lMXNGYkJZZjUxWU1LVnFJSEdOQ0hm?=
 =?utf-8?B?L2I2WUFRT2tacFp3Q29sSVFPWTBOOUhCbm0rWTNwS0VDbWhMQXcyK1o4T0c0?=
 =?utf-8?B?MEdXTDNGSTVrZmtkbGV2MzRrQllacTFIZkN3aXkwYjVDYk5QdjQ0WG5uRkgy?=
 =?utf-8?B?UFcrU0hwOWdDVHR2TURobVlxMHlLZ0oyMkpLeW9uejI2ZG5CcFdRajJHZk5K?=
 =?utf-8?B?dTM4MWYrL1dTNEtGWTNQRU8xWU9tdWFSU1lIV3c2VitLYlpxb0lXRzg0VXNW?=
 =?utf-8?Q?J7ZQPBXjeoM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnVxaXpxT2JIcThMNjIwWFRYek5NcXo5aEhUZjNsRm0vekdscnpUaHNjUmdv?=
 =?utf-8?B?a0JCdWE2dkV0eW1Lc2lhMTUyM2VqUHNjbTMybnQ1QmFmYXJiOU81MVdjS3ht?=
 =?utf-8?B?bFZEdTVVWGRhSGlZditNeEUySmlnVVlsZ2JhODVRa1pERng5WmltZys0YWho?=
 =?utf-8?B?VDMyd2dsUnFCRmlkVDEzaVZtWjJudTdrSDZuL1B1Q0ZacjFpT0lDWEZMWmE1?=
 =?utf-8?B?R1FIUjhmamdhRWplN2lWVFRQZ1MwWHVQZXZQaHNzcFJsZFp6YWhneGt1RVhK?=
 =?utf-8?B?YjE4Ny9LSE1OaUZIZUEzZ0FISjg1NWtvYkdHcFpCdXVZZndVNDg5d0tHTU5p?=
 =?utf-8?B?QlM4VFJ5RTJXT0VPNjBXTE9COXRveE9BUWhBNUVWVE94alBFakRaZVJZZXE4?=
 =?utf-8?B?T1FWVEx3T3I0MWh2dUlLS0pUN3lFWTJDZE9jNkhmck9aWEYrdnlHK1EyWCt5?=
 =?utf-8?B?V3BPSVlnSWM3amdBczA4NUIreWpOOExLL0ZSREhxS1dubU9SOHBGcGxCSmg4?=
 =?utf-8?B?YXFEcGdrS1NidlFnUEVHZWlveDhycEpSdHA4S2IzL2QxV2d6VisvT0ZIU2Jt?=
 =?utf-8?B?bXFJMER2UE9oelRUY1IyNjlta0pYamw0WEZZLzVuVitaZnVvUHZuYVJ4WEhX?=
 =?utf-8?B?YWRCTmdaTjVCOUZTakx4N1FySElveGdXU3ptM09jaGQvdUZBNXV3RHc4aC9K?=
 =?utf-8?B?WEVBZU5aSXZacW8wdWRtWktSZy8zajBSVGUrcjVkMEhEbFlDbyt2aHliWVky?=
 =?utf-8?B?WHozSWt6bkZuN3c0Nm1BSVArdk0rbncxUlovZWJmQ0Y4bU9mWmMyZklpMWp6?=
 =?utf-8?B?bUsvdDVEcDVvMm81VGhNeDF0TTgydXN1THhEa1pzemJqYzNMS1BhTXI4ektk?=
 =?utf-8?B?SnJRcXRiR1UwdkZzVWhzQ2Vkb2gyWlZCSmV1em03R3NsZG1NMFNWYlZQWXFp?=
 =?utf-8?B?MUNzVjE4NXF0UTRYWVRpbHBQVnVIbFhCVHFiWkljaEZneGV6OW5JVWpnVHNN?=
 =?utf-8?B?d3puWXlqYjdDSXBYOE5sQk5Qa1JKbHY5dlYxMVV6eCtKd3FWTWM0VWl5L3A5?=
 =?utf-8?B?MC80dzFZc2dqcWZTaWNrNHJKTTdKemg1MU5yTWZWR1RXUHQ0c0ZEcXRCM1Jq?=
 =?utf-8?B?TjdhMHNEWTFyWVlIUzIzSzN5V24rWkN4Q3N0WFNRd1dYZzdBYzRoOFZWa0Qz?=
 =?utf-8?B?b05XVTBkOWZhclAzTEN5NHBQR2RDa3RoTDIwZlltVUhyc0gxcnRKRGNBUG9z?=
 =?utf-8?B?M1lvaHYzZGo0L2dVYXh4dUxkaVdRSURWOWV2OU5tOGxsSDBNc0JsMXRORkt4?=
 =?utf-8?B?TzVuZHEybTlPYmw3WTNmVlZIVGN0U1dRNUoyQlZ5MXNNUnhCV2VRdkNjckNL?=
 =?utf-8?B?UFdJRTRFTnpyUzZOakd2OW54VlZkL2U5RjJ1bzBJVUFuRStxeHIwM3B1aDJr?=
 =?utf-8?B?UGRWelRUNlVibFVIZWdMeFFyeXRCUlY4Y1Eyd3RaQWlRczRCQzNqZzlYSE9j?=
 =?utf-8?B?VlN4U2d2bUVIUDBqbE9kN09uVjh5NEQ4dDhsa3VyZGY3VkUrb0ZGQnhEeGtV?=
 =?utf-8?B?TWl4Q001T0FVV2dyTFR5UEdqSXNBbU1NeWh3cWhkWjQzbDc4TnoyNGxSNlF2?=
 =?utf-8?B?bUJYam5wYlhMdzZZNUpjaE45VW82WW1kRmx5Y3lpWXgxOTNaUWhqQ0gwV3lj?=
 =?utf-8?B?S0lPV0FTQmIzTmRlZDU0Zm1GVWI0SGE4amx3bGNNL25PVGFOakVveTk5TlBP?=
 =?utf-8?B?VVNZdnRCd2ZMN2YvYjMxam9hNStKUW00bnBwemZOQXFtNVhDSXRzOHA1M2Rv?=
 =?utf-8?B?TW1JOWhxTVBCUjZnZHgxRUxKV0lwVE5RZnk3d05FRFNnRWhlcEpHNzdscGQ0?=
 =?utf-8?B?TlM1cVBERE9YeElZOVM3dFlnV0RvZzk1bTF1QzdIcHFuYXV3MjdOdHZ1dTV0?=
 =?utf-8?B?WTBKKzVIWTdEdThDSVZoMW9qSSt3VWRXSWJoeWdiejQxOFphQWRmWXBpTmxT?=
 =?utf-8?B?UFVZdC9URlV0S2k1SlFSeVJaaEZ0YjVQc1p3S1lNcVk1Z1k5UWxUaUJQRGdQ?=
 =?utf-8?B?N2xQYjdPbDh6NjdrTHh6T3V2RitkTy9XZmZ1dWhpZVk5eTdHRUpIUGNxQys3?=
 =?utf-8?B?dHpiK3V2SFlvbkRIdnlndU0rOFg2S1grT1hiRkUvSEVsb0hRWU1LK1kzektE?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d46bff3-e963-4fb2-61f5-08dddef23671
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:30:03.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+BQ74q8wfWLjcGWQLe1ktqnWFLXcEhuRCZtr5sqlI1kPWn4wHgLnKzcWmYqzBti2me61M3Fkq6To6HkmY1o5FCGtV2V7qcHbx9RrCV8M6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7582

Am 19.08.25 um 03:04 schrieb Tristram.Ha@microchip.com:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> ksz9477_hsr_join() is called once to setup the HSR port membership, but
> the port can be enabled later, or disabled and enabled back and the port
> membership is not set correctly inside ksz_update_port_member().  The
> added code always use the correct HSR port membership for HSR port that
> is enabled.
> 
> Fixes: 2d61298fdd7b ("net: dsa: microchip: Enable HSR offloading for KSZ9477")
> Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
>  drivers/net/dsa/microchip/ksz_common.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 4cb14288ff0f..9568cc391fe3 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2457,6 +2457,12 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
>  		dev->dev_ops->cfg_port_member(dev, i, val | cpu_port);
>  	}
>  
> +	/* HSR ports are setup once so need to use the assigned membership
> +	 * when the port is enabled.
> +	 */
> +	if (!port_member && p->stp_state == BR_STATE_FORWARDING &&
> +	    (dev->hsr_ports & BIT(port)))
> +		port_member = dev->hsr_ports;
>  	dev->dev_ops->cfg_port_member(dev, port, port_member | cpu_port);
>  }
>  


