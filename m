Return-Path: <netdev+bounces-182065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE900A87A6C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8B73B28DD
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C325D54A;
	Mon, 14 Apr 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hmTYtNxx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80011A5B94
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619233; cv=fail; b=c6WrIVunxgKJpn9vDoCvW42+ObP+HJftgbZJBrUPt7dxz+FlwWkcdG8zxnfpkrv+Nnr74dhn39VVzfkE+KVtcL2hCChcSjQ1nIGmXYlv3e+KcvJcDP/CP0NXYQz7bK48b24dhuwpry7eBha81TY1gzo7amja83+1geM6dW5vdf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619233; c=relaxed/simple;
	bh=V+UQzvTwRdFURvC2mWFwMEx5d9h93eNAX5N/djV2f+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1Nl6OJwW+8pOq130peAsjpv2xzS5hnz4T9Mub9JRh4oQxO7/OnXg9152onp9Z6y3XXts9w/sZWr+uDSW0ryJIJ/oKKCeHKp/hHNuQaufc9owECImY06/jhd1BytMGIykgX70LsSZbO0Y2udSBqiAFsSG3CBBoR2t7d1slsU4sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hmTYtNxx; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZxcyrJT0QxyZ8DF5TGa2pGsPGyYwJSQlaRqE8k0E66KUu5QakVwyQ5NoxON9oQO1ytFQsL0O+tZ3qmXDoF7QgwzD4xzUVUtTo3lHn8JvjBFnFq7WFaW/UyE7YDrlkHXcDx/eUqKIATqexqLyicLLcQQ7e7FNNw73ZSsiXIdrhBpBRFvUWwULndlD7AAlm2MKjnkf5kUfpRHfW8jK67h7LGO+HqTrNdhPFWuAkMSc7XS6pGUn/F9j9T5mJacnQ4BzvHJtSQgcidXwSHBzqm60zkRIH5Qh3cP+CGHcPz9n1XQimN6Z8X/7OfVBbOt0WnwP6ib2+z3op6mOrrmSmIqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ClVclMGFUovhZwYEFxi9qVoPptxZYPSyUDC2wkYQos=;
 b=alSVzFy6jI8IDfwwwEp2rx6U9jmzKJUI3bA+Y9aH3Nc8c4oLybNc5JSNbp9NO2Zps8kjbMOTzbXEGEQBDj07v7otrx5aeV7DJ4jGZ13v8WvJDQdhHPUHlF+hhHcwnJFsgYSbJ0Sx0ISy9cppAwhcL8L1L4POenN95v+CPwATWXzL1Jk9GVoG09Yk7MnGXYNAIiZS/NpUwvLSHjsLnoRG7hjulG+XtHKOYdQ0gEYs8BtxWTaJa02YVcbTggcTYeFvhMhWY6ZUGzn2Lu3yDwECZSpcZURsU7ymqRTcAakGulMtyr32ziybaOzDQTJW61IsN0TTQtwfwqWzWGfmzieqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ClVclMGFUovhZwYEFxi9qVoPptxZYPSyUDC2wkYQos=;
 b=hmTYtNxxU4/WKwmU8kExI/s5qeoSx187KotiPgslLjVOE6UIP3SbqncLqMS+ZNKlB2hNVyMzlWUpoAO0WvrYJpF/Itwv5xGU7g0UrVKELgbBAxnOdXCeNBEPxAN+T1rsmp3LDXGfhL0AbqFQa/gXQf6kHmcPjlGld18fXrdawnlichsYfM7gkpeuOJbaoYVE6negBiZdY/jhm4gMNVleVhbzHkbJgBxqFgsstO98gz1ejqKkW1uGnLgp4vuF2JV78Lm0ywFWAcJFhMY5N8Kip/pg/42+IG2GbOhFWH2XrXUOu7cbjuAkDETmiexQWrMK0T97NPgPYT47J5v1StM0tQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB7141.namprd12.prod.outlook.com (2603:10b6:303:213::20)
 by IA0PR12MB7556.namprd12.prod.outlook.com (2603:10b6:208:43c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Mon, 14 Apr
 2025 08:27:07 +0000
Received: from MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2]) by MW4PR12MB7141.namprd12.prod.outlook.com
 ([fe80::932c:7607:9eaa:b1f2%5]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 08:27:07 +0000
Message-ID: <9768e1e0-3a76-47af-b0f5-17793721bb0a@nvidia.com>
Date: Mon, 14 Apr 2025 11:27:00 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "horms@kernel.org" <horms@kernel.org>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
 <20250328051350.5055efe9@kernel.org>
 <a3e8c008-384f-413e-bfa0-6e4568770213@nvidia.com>
 <20250401075045.1fa012f5@kernel.org>
 <1fc5aaa2-1c3d-48cc-99a8-523ed82b4cf9@nvidia.com>
 <20250409150639.30a4c041@kernel.org>
 <2f747aac-767c-4631-b1db-436b11b83015@nvidia.com>
 <20250410161611.5321eb9f@kernel.org>
Content-Language: en-US
From: Carolina Jubran <cjubran@nvidia.com>
In-Reply-To: <20250410161611.5321eb9f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0373.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::20) To MW4PR12MB7141.namprd12.prod.outlook.com
 (2603:10b6:303:213::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7141:EE_|IA0PR12MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 43b6d23f-6cac-4406-1ce1-08dd7b2e24dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTJ4TFZOendYMkRFV2xnVHAzb2VwM1lUd0gyNjJ6bEp2Mm5rUHpNWVpTOHBY?=
 =?utf-8?B?Z3MwUjU0RFhHSU96VFZRSGpuWENidTdFcE02bEx4cW9uWXNXOHV5MnAwYlM0?=
 =?utf-8?B?MVZCcDBiTkY1ZEZxQmVJR0lJVmlSM3JaU1VsbWo5cDRqY0xwNHoySXpINlRK?=
 =?utf-8?B?OWZaMDRqaVh1ZGNYSnlPVWRCSTdDYklrTVM2WFVBVUNjZFV6aXY2K255aXhO?=
 =?utf-8?B?Rms0bTA3ajgrZU8vWk1CMUc4elQ4VjU4bXgzRzFFdlZYbzJPcU95NDc2ZVlt?=
 =?utf-8?B?R2ZrOGJVQTNvTTVRaDBoZFFRZjZZOE1jZTRPc295VXoxa01EZCtQUE9JUmlQ?=
 =?utf-8?B?WTBKUkQrMXhsalFWVVlGWVRUS0ZlVEp5V2Rvc1c2M0lCMEVxeVRiQlJxYUQy?=
 =?utf-8?B?N3NpRHRaTkptN2ZxR3dKWC9XV0kyUzVXcmh5ekhpWEdzOG93K3Y1Y2dvNCtk?=
 =?utf-8?B?ZGl0VUdYbWo2MG5mZkMyRmJnd3pDbEdRdnVtc1FVL0lNK3IrQlR0RmhQNy9o?=
 =?utf-8?B?S3NXbktaT0NwZmhqcnplMVRiMmdIZzBiL2N6bU9JRUNaSVF0dGZrRlZyRm1a?=
 =?utf-8?B?V0lzRkxXRklmNUhlSTN6UmZldEJaSWNLVzMrZk1KRjQxTnFybTJCRHJVSlc3?=
 =?utf-8?B?RWMxRkFoWS82bExvSXpnMG0zMk53OU81cTRsKzhMTno5S3FBTHMxRDQ2QTNS?=
 =?utf-8?B?TGtmYm1EL0JHdE9XYlRTTmNORGZkUFRBcDhLNDZiNW9xL1lVUlJ4SXNWL09o?=
 =?utf-8?B?amtOandvK1V0Wkx3bGQxV2EyS0gyRWhDaksxcWlmTGRsOVNoZktCQ1F5alU5?=
 =?utf-8?B?bGNhUUZEZnE0c2EvVWJMRTJCT2cwMTFtdUcxd3ZFQUhIcFR4akFnaHhoOXJ1?=
 =?utf-8?B?M00yM1ovTmIrdytlWTM5UEYyeXhXSDdRR3lwQXZ0TFBhcGI3eWJWR2thaUpU?=
 =?utf-8?B?L2NyMWdvYXJQdDJxcjR6Z0swSm1uaGRVWEF1TWpBd3FYZDZZM0JWNlNTSlNk?=
 =?utf-8?B?ekdvV3lDcmgzQldRVlozVzRtOE1BbE5DUCtvTjRWRGNBRHFXOWtNNElBTjdq?=
 =?utf-8?B?VVlYTG5jTEpTbjJMNDdYbnNjVWdjUG9UZDBlYStSUUptcExuQkpTYytlazda?=
 =?utf-8?B?ZzNxMTZpd090NkwyUWFhOUE2WEk0UnhjMVlMWlJJWkc1cUlIckY2RjM2SG1H?=
 =?utf-8?B?anZnU1lCM0haQ0NYdGd3aDJVRU5CUXJ6ajhDWDJUaVAvNWtMQmlFTTBBTGx3?=
 =?utf-8?B?Qmp6Mk05ajR6ZS8wL0tZZ0QrZlVUR1dRalVaQUw1dlFMd05yVG5Eem04YS9G?=
 =?utf-8?B?OUc2bUQ5QWQreFgwTlJsZnNtOUFSMFlreFFjMEZKUXEwWDJsbDlveCtIWDVm?=
 =?utf-8?B?T1B2R0dtVGcycm1qZjhwZjV4NVJsaVVlWm1DS3M3UDkyK29VSEM0bmFTMnl1?=
 =?utf-8?B?Q2x0T1RYNDJTS1JjbFJTRXlxTTRCRmdjQmpiUEViY2MxUkIvZzhGSm4vczVZ?=
 =?utf-8?B?aW9HbUFlWmRjMHpuZFlTTDZhY0x1bGhzV1ZUdFJjTDdlTS84aW1zeUs0N0JH?=
 =?utf-8?B?MjRncXAwSm5UeVdYdGtYMmNtSUt2QjdvS0RRc0huSHp2L0dYcVI2OFhhS3JW?=
 =?utf-8?B?bWhFTHpnUTFVRTNMU2Q0ZjJJSnJKdkFEQ0xwUFFTbG9xaXk2Vm1BWEFNcVp0?=
 =?utf-8?B?c2ROZ0gzTVpUWXJ4VWQ1OGJCeTR5WTFnbUtlbkE0dlRMS2dSVWZld2FpaUJy?=
 =?utf-8?B?YXJaZWlYSkxDejh6NldnS05NM3ZuUWtUTTBuVWcyZWVscm1CM3FPVlR3WWlt?=
 =?utf-8?B?ODhjSDk3ZGFRVWQwNWJHaHBJdTYyYzJ5VkxvR1NCUWxTMXU2YzdqaU14QUds?=
 =?utf-8?B?VWdlMitXNW9iY3FmSE5EbUZFT2Nianp0YU1wdHdyNDFyTEQ5ME80SnpFTXFD?=
 =?utf-8?Q?GSSFCbMPtG0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7141.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjdHZzBZdm9jWFB1Q2lGZHJENGduRWtGbTBJUEF5azVzNmZ3MU1HWHhuSDFW?=
 =?utf-8?B?bnduZmJDL1YrYmJzVmlZcVlmdnNNM0VWWjFKRWVUbHIwbXpXYytLaGFCVFVX?=
 =?utf-8?B?amNQM3JpS3FraEg1N3pmQW9QVFMzd0FpTG9KN3M2VXlpVWJ6K2M3bmRicVJo?=
 =?utf-8?B?Wkl4YlFUSEQ1blZtUGlxeDdLZkNSUXN2ZkNhd1h1NTlIYWc1REdOeitNaFVx?=
 =?utf-8?B?Qk9QYVlqTndlSlFSYUkxNURSenB2eGRGV0tTOThwS3A5Vzkwam9ndjQzMmEv?=
 =?utf-8?B?ZHVVVXRsakRFWFRRSmZvcGNLOUtSdTljeHI2NG1ramE5OVA3dTc1WjFWYXJU?=
 =?utf-8?B?ZnNPRmRsa010QjM2MUY2VzRNN0VXN0RGY01QV1A3SzhWcmtXeTBOdkpQUXBt?=
 =?utf-8?B?dlV1TlFwc1FvMTMxcmE0TEZLVURxZC9BaGozaUFJUnkzRWsyZmg3UFBRRkIr?=
 =?utf-8?B?L3RXVUpqOVM3cnh4eFVmd25VWHFpaUJ2QkI4MCsxNmlqN0JRc3RIaEp3WWlM?=
 =?utf-8?B?bTZTZ3YydVV5QWIwbm13am9KRlFQM0FWcXYzTEpHR0phQjR1MldTaVFQZDAv?=
 =?utf-8?B?dldGVm5tdW5XS0JiVmFQUzBtVEZjYzFVTkJtQXpvV3FIajdYem5OUWhybVNY?=
 =?utf-8?B?T3I0dkFWdnRybFFMY3lJOHRjejVnSXpWS2dXa2xaUE54ZnpBUk9ubWVrTGdL?=
 =?utf-8?B?cVZUR3pSTUZxTXhFbDBXNHBmbzNBcW5sbFVodWwwNmZhaVl0dUtOQmJndXdE?=
 =?utf-8?B?S1NOVGdJZ29GWVg5ZmVVSHVlc2ROeXJxcWR2UGhwbml2RnQxL2NmWVN5bDFt?=
 =?utf-8?B?TVV3ajNSL2JjR0hiSGhlaEtRK2lWV1JrMmN3YjZaRmdGUGJCUzRjMVRpSThF?=
 =?utf-8?B?c0dOZlloNlA0YU1KOE0yc0RqUkVLUDZaOTIwUHcxY0MwYklFeVgzQVFpV0hP?=
 =?utf-8?B?MkI0VVJFcmcwYjAwUEhFWnBiWnpMSzFaOXp3YnBEQmlMdElZUWlBNVpMV05o?=
 =?utf-8?B?MlNXNFhNTE9Vc3B2SFRCV1pTNHBOZFZNSEpaNkR2OVZZY1RWWmUvS1FsY0t2?=
 =?utf-8?B?cWY3VGhKbEVxbTFuUG5FdHVlcERiK1NVeVhoZExQTGZPVTN2dWxFaFNlbXNv?=
 =?utf-8?B?eWhFdldPWWJWc1NpWWhmNUZyN3J1TWh4b0dwNk4waUVBVlBNTlJlR1B3V1hU?=
 =?utf-8?B?dWZ3OWIvdjE1ZVNFaklaZ1UvRStZb0RtajFKODdJVDR0TXZQMkNHdktmN084?=
 =?utf-8?B?bVdsRFUyWVUxaHNGN1JoYTVkVHRrc0FwbFdlRTVkVzZBT0JVV0lQK3g3cDhi?=
 =?utf-8?B?dGRaamZOLzEyZzJ0SDdTOExheVdSZ0Rjb0h0Y0p6ZzZaRTl1djhnaXlKRFNa?=
 =?utf-8?B?cThWc3NaSlBIbUxmc3RLQW8zUzhpeVZUSVVWdzZyZ2dKd2k3ajNnRWhyRnBS?=
 =?utf-8?B?bGMwUEQ2Wi96bFVHQXRxZjB2Z2sySTM2UVd5WUtyNE1CaE8zNWpERkFEekRG?=
 =?utf-8?B?TlFxTFZDSVNuM1RuT2U1QkxmS0toRTY0VEk5eFBDSmcvNWJrOWRVdTJYb0FG?=
 =?utf-8?B?WWJKK3l3WXRaaHVMa1BsSXlMYlVVMUpwUU5WdVhhR0owUlJhRStTT1laVktT?=
 =?utf-8?B?MU80bWY1RVRnSDJ6SnlpYVFRNDlvSjhPUzlSV3FqK3JEVEtZYzN0UUtoWEJY?=
 =?utf-8?B?K0d1R1E4U0tOVUQyM2lyMk91R3RJKzFsVnllWXVjZ1hkVVlRbW4xcGJPelpo?=
 =?utf-8?B?SXJSTlNzWnQzNkJNSjRLK3MzVUExYnczUW11Y1VKbklrS2xDbitXTFROTWtt?=
 =?utf-8?B?WjhJZnBvK0JlbDVVRnJVVjhZWDdoN1lhVzZFem0zK3ZDWTZXcC8rblA2VFo5?=
 =?utf-8?B?MUVZTTk3K25aWXRyTGdSL2dFcDcvKytYQVd5ZUxZYUZLQ3d0NkVEZGt3UlFs?=
 =?utf-8?B?eGtQajlEd1k5azIxQzBqbE5rNmFRZDVFOFlQNS9UejlsTlhqekR0TG04THZK?=
 =?utf-8?B?UnpwZmRVSTdzSHJvSzNNWmlSYU45TFFYNlNTZ25HcVQ1SE1meHBwcElpMGxG?=
 =?utf-8?B?Z0c3OGoreFRzbGVUVGNSZzBRYUlsNHcyVmk0eWp3cy9QazZwd2dJVlBpOTBu?=
 =?utf-8?Q?cjNj5vG/o2bh0U5RrcpW/A4Za?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b6d23f-6cac-4406-1ce1-08dd7b2e24dc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7141.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 08:27:07.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7aD9KwQHMmHOXeXnBScxQiGa/qW3AIoUwnsr4hdTHszHn1ABQlZ3XN8bGd0AVJA4w4Pgs5X7oujxC6zEdCJwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7556



On 11/04/2025 2:16, Jakub Kicinski wrote:
> On Thu, 10 Apr 2025 18:23:56 +0300 Carolina Jubran wrote:
>> We do configure the correct priority-to-queue mapping in the driver when
>> mqprio is used in DCB mode. In this setup, each traffic class has its
>> own dedicated Tx queue(s), and the driver programs the mapping
>> accordingly. The hardware performs its default priority check, sees that
>> the packet matches the configured queue, and proceeds to transmit
>> without taking any further action — everything behaves as expected.
>>
>> When DCB mode is not enabled, there is no fixed mapping between traffic
>> classes and Tx queues. In this case, the hardware still performs the
>> check, and if it detects a mismatch, it moves the send queue to the
>> appropriate scheduling queue to maintain proper traffic class behavior.
>> The priority check is always active by default, but when the mapping is
>> configured properly, it’s followed by a noop.
> 
> I hope you understand my concern, tho. Since you're providing the first
> implementation, if the users can grow dependent on such behavior we'd
> be in no position to explain later that it's just a quirk of mlx5 and
> not how the API is intended to operate.

Thanks for bringing this up. I want to make it clear that traffic 
classes must be properly matched to queues. We don’t rely on the 
hardware fallback behavior in mlx5. If the driver or firmware isn’t 
configured correctly, traffic class bandwidth control won’t work as 
expected — the user will suffer from constant switching of the TX queue 
between scheduling queues and head-of-line blocking. As a result, users 
shouldn’t expect reliable performance or correct bandwidth allocation.
We don’t encourage configuring this without proper TX queue mapping, so 
users won’t grow dependent on behavior that only happens to work without it.
We tried to highlight this in the plan section discussing queue 
selection and head-of-line blocking: To make traffic class shaping work, 
we must keep traffic classes separate for each transmit queue.


