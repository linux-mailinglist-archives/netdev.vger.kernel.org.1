Return-Path: <netdev+bounces-230531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FC3BEAE5A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 18:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344D47C2290
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23694253B42;
	Fri, 17 Oct 2025 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="qatcbQIj"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023141.outbound.protection.outlook.com [40.107.201.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D43225788;
	Fri, 17 Oct 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717298; cv=fail; b=f/kM6cxTs/EAFx3khJue/r0a6pg88VSA22GtIXo9s9RCF0Y6Oyx7K/hjXRwN5oEBhYUqtZCo2IHe+/STeI3PPDdGVJsyxfOjcbeUKPefEdpqBhLH6SUiaClYz+iAFaX1z4r9WubwcBfbALaoci4wgKugfml7sm4HLyp1mWgFkI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717298; c=relaxed/simple;
	bh=hPwjdr3a1FnTLyW4h5fez/7J1z7mexEzOe4XNw4CscA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EFWE5S3QygG+VAMV1TJPwuv4alJoMbzGIONcxUJMm1ZoPfyR6uifXo0ruf/mlAfBXNB4Bldbsg52Yw6Uhz/jk2kxTD8aFDwWTcuERGCQqatujphX4lQPIbbPa7KGTbG/Uc4M7LSPPEBkC/Bjsk/CC/LkvN50Pta1xPxj8fL3RSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=qatcbQIj reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.201.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDYDvDA/uwxvrslmNEUDlBTLNNMf7Sgax3Jl3+OXevZQDyTOez1flLpqaBREYPV8gWgJj2T9okB3ArzaiTaiYxSTLopwbCi72rr8iFkkLSgPO8WalxTlFmKCsg89q7VB9vJzCJCkYBPOWtm4AsQQR9RGL8TDeSABjwlJLOUhKLsDFrBoSMpgNwtrNP/XLZlljNh2q8Z4LlRYQlqjtRdEkmoZ2zuktiJmP/uB476RQmdRRjBQv4Sm9UhNzj+S4B+H02kC4M0Q7QVXNJ6APK1Crma2ilVRUOvk0aaxsovBRfv2UaxuRQL289NJxO8XBmTUJ/ckjNF3krdTv4LfpqXN5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOMBRXDYjjiWpmWjSlWAFYIFegJDFUGxbfiPWjgKeVU=;
 b=TGvyccpjyZa3nEbxIkjBHDfbpL06Ea5cuMbv4ZvFxsuUB+suJxm4My4kSgH65lgMIRZh9TJon6Qb9veQefwUINiOYVL0Lyf6DPebdmB7a3AXQvwchnjIqkGW/U3Sn/TGM7+4n2kq6rbMeGYk6HQYh6RtZy+acqAuJSfqMNahNibCoKzTh/ZCVG41jiWSyGUP/wNeEAeTM2mCk9obpuwPwRVcvonJaeGlqbSrFBlpBdy5RQ+I0h3GZcaRD8/DIIqdSIBWQsemGbfU0pqnem6UwtpLSMpP/jive1tTbpQfIiwo915prhFDbm1vtdoJ4dfK7wVHS/3IcCNUZ1rKUJiXqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOMBRXDYjjiWpmWjSlWAFYIFegJDFUGxbfiPWjgKeVU=;
 b=qatcbQIji98wj+Hy1YqYhNnfgkZimlVxny9yhoam1wcJgr1YtriCjhTix+CFcnMbDCJZ8QjteTxJwTtyL6wJjwHRI5SbTZg1fmYuG7Sz0wpfQjc3mpp7Q/fAOvuR01bQzm312il814SSwPozh8Tfh7w7VdYcFj/dAaP1lcdznxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH7PR01MB8145.prod.exchangelabs.com (2603:10b6:510:2be::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Fri, 17 Oct 2025 16:08:12 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 16:08:12 +0000
Message-ID: <99aa7b2a-e772-4a93-a724-708e8e0a21ed@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 12:08:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 1/3] mailbox: pcc: Type3 Buffer handles ACK IRQ
To: Adam Young <admiyo@os.amperecomputing.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20251016210225.612639-1-admiyo@os.amperecomputing.com>
 <20251016210225.612639-2-admiyo@os.amperecomputing.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016210225.612639-2-admiyo@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:930:8a::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH7PR01MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: ea2b311e-9a44-45fd-1536-08de0d975f02
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHZlWERabjZIYUtjR3ZLcnpPNW9FSVJoc3d0SjMxT242bmNmWEtrUHRuQmkw?=
 =?utf-8?B?Y1lSSy9uWDlvYThiNFJWNnoxN1FsdFE1UllrT2RVbU04L3BocmpDWVZxOTZJ?=
 =?utf-8?B?cTVkOG9KNzE1WXVOZTkwcS9ObzZUZllDQjRudktZY0NhTkRVUGY2emZERmh1?=
 =?utf-8?B?ZUN6RTcyQXRLem5NWHRpN0NWSjBKQUduQzJkTHR6QUt5L1p5S3JzQk9CZk0z?=
 =?utf-8?B?TVdVZjJiaFB1TUsyUUE5TWlsakxRZ0Q5L2JDb2NaK3FweGFNUTAvbDlCNXdJ?=
 =?utf-8?B?YU9qTnF0bnF4YUwrVkplYkJWcDh3RDAwMVA0SnNkSkhaYmRCRVdFUDNSTnBs?=
 =?utf-8?B?MUNlcVJSSEl0V2JyaEppUm9uMUsxTUlNdFBNOW93cGEway9SZHFiUk9HdDly?=
 =?utf-8?B?RHU1UXpnaStnSEZQcTRORUFaeTFCZVJUN2EvL21LdGZnU3lqeUJNbVBzblgz?=
 =?utf-8?B?YS9BQXNuaFQ3MlRmWFduc2RTWDdiNFQ2RExtRU9TS21xNXBkSWVFWHNCb0Zl?=
 =?utf-8?B?dVQ5SmZPenZ4RVNmZEk3dVlKbUlPM3dwVWY3U012bkdUMHZpNi9HWVpZSHlP?=
 =?utf-8?B?bDhFZzFCSXA0cUlTWU1vRHhLNW1nYTNIVzRYVWlxdU12VlgwTVFOV1Nzc3Fs?=
 =?utf-8?B?MC9HdElxNHpJTDIwTVZwVGwvdEl5YURQd0laOHpJUkIreUVSOGwwTS96Y3ph?=
 =?utf-8?B?WUszWkc0eEQ2dzVFRmhkYVNJRnpxWE4zRlJRZ0kvdnZQUElLcElLOGRzelNT?=
 =?utf-8?B?aDR4eU5kQ0JSMG1wQ2NSSVpSWjMvcDNGeTZwdEEvcXlOUXRPNTFYeXc0NlZ4?=
 =?utf-8?B?aFBXcHZIczhYalpST3hSRm1lUzFMd0R4OCtwSG1wRWRqR0prTkxIZ09wQjRR?=
 =?utf-8?B?SzFSZGpmeXFzSFF2UHFSdnFLR3hHMndwWUZMa2VVdStvaDBVTnZoUDdsMTBL?=
 =?utf-8?B?SU9UUEFWY1VCRWErMnkyRVpTSi9ndDgyYkxxN3MrMEV4MzNkSUh6Y3lyRTQ0?=
 =?utf-8?B?WjYxMGdGeUJBOEFPbnVWQklzdWJ0SFpUUzdyMDVnZ3ZLWU9MbHZETmloY0tn?=
 =?utf-8?B?Mi9JM2RVL001WU14dXpsQ1UyRjdDNjArbDJSck1sWUxPSlVuS212V2J3LzY4?=
 =?utf-8?B?aDB6VkY1M2NEdlZKS3NBYjdrUlFmSEFzNEJmMkRQRmY0VEFOWE84VHdoUWUw?=
 =?utf-8?B?aG8rRUVKcDAwZFkwR0tBOW9IUTFtMGpLL0lzN21JeXN6YTRiSlQ4bmc2Y05x?=
 =?utf-8?B?NVNRSURxdXRWTkwwY1FRdTRFNTBTNlB2RWc4bHFEWGZyUnpHbEhzemlHc3F0?=
 =?utf-8?B?UjZxYUQzZHVUT0FRWkNHMVFNTzU4RTVMWTh0UVpuU3BnRm1GR3RTZ25lQTJr?=
 =?utf-8?B?RXptSGVwVmUxSTl2Ni8rV1BTMDNsMk1QRERTQmQ4VUZ1TVR4WDdsbW1mTks5?=
 =?utf-8?B?enhDQ1VqSmQwVTNxYU01T2p2Q1UrNVN4M3BYL0JsbDVsOXJQek42WU9hQTZq?=
 =?utf-8?B?YXNiQm9tam5MZFBzVHlHZG1MWHZFRWRmWnJNNXhQMmQxZFlWRzM0elE3MFJt?=
 =?utf-8?B?U0ZCV01Ia3VDYUNPclVYVWdGOGJQUVEyY2h2Vit3elpjcjZPVkorYTczSG80?=
 =?utf-8?B?Q2xqMVU2d1VrQTB6Y3d2K3N5TjUzNDQzV2dzZmxIWk1tRnBzcnpiQlZ6eVpD?=
 =?utf-8?B?TXR4cFNYU1MxS2FlM0NuOURNSis1UVJ0M3hCQ0lTVk9qZzZ4bmNRRUllbUMr?=
 =?utf-8?B?SWl0bW9jVXdua01kUUJzSE9jb3VndDRQdHpuM0c5d0FNV1RlcG9yQm9ubVhx?=
 =?utf-8?B?SHNaL24zWUNsT0Y3UkZzRkh1anFDL0ZZYlJjcFgvWnk0TnB4YkkvSWtMaUlr?=
 =?utf-8?B?TUxjbEJrbHNackR1d0JBZUhZRVg5cGIrNUswc2duTC9vVUd1OVVHaEJVQzBn?=
 =?utf-8?Q?hqhbMrhXOAAzF/4HHjCtOC8ZqFmtN7Us?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUxLVFgxT3d2RERuSzludmpUbHhnOWZtYUJjTUduWHpVUHhXTGYvakJFYTM3?=
 =?utf-8?B?R0hxQ3hsV2U4Wm9sbjBCUUFyTWtQWkViZk5XVkpneC85WnpNcnpjZjlta0RU?=
 =?utf-8?B?MmtId29ONlFLYlhYWllha3Q0ZlJaOXBOaHl1UjhqWVVnWDhHdDZSa29MNTEr?=
 =?utf-8?B?Um9kTWRlakFPMWpVTk92bjFsOTYrRU50VWZYbmNwS01LSHpoWXFGVVJhbXJG?=
 =?utf-8?B?cEV2NnAvakUreThXcks1bHpUVVBwTE9ScmZuVjlxNE9YaG1CbEozeXBEbGhn?=
 =?utf-8?B?a1psMkpXbG9GUFByeXBQdnBzZjJSQUlCT0FKR2Jrd0Zyc2VxQ296aFh3bC8z?=
 =?utf-8?B?VXYvTDlxTWl5WEpzaDR2dzNYZVJmRVVOSHhYektLamcwVHVGeFFBYVR5LzI2?=
 =?utf-8?B?aGsxM3cwVlRtUk1lUmZHZEs4cXk0WmNyamFyanF0UWRZMlFVMFlKOGRJNXEx?=
 =?utf-8?B?SjNCaDYrZTZzeE4zODJqWnZKaGlQbE9ySVdrMGNya2ZzWVZXOGpKRVlMeDZu?=
 =?utf-8?B?Tlo2a3B3VllrTmxQTWg2L044Q3pDMnNQQys4eEVhZk5CZFZwVTlDVXplQmlZ?=
 =?utf-8?B?cHNYZk1XZnZXS2paTGFVbjVObmtFT3cvcnVNeXRSR3NZSDg3RzV6YVpKbmtM?=
 =?utf-8?B?SlFaVXdtbUc5c2ZqZmVyMVRaekMwdGZzVFVzc3VxeVFjbTZrRGpUOTBmSjRQ?=
 =?utf-8?B?UlVLY0FNRkJ5elBlRE9GQ2J6R3JMTHRkR1EzbzlZREhDTHlPZ2F5dEdsOVND?=
 =?utf-8?B?VnhHbXpmQmJYUXFZVzBmd2N0SjhMRzJKLy96REVqbFA4TmtGdHJPN0cxNzVV?=
 =?utf-8?B?SnpFNFZ5WmJnWFlQaTMweUtVNzRwdUp5WWlFOW5CcmlKZmcySDk2LzBIbjhh?=
 =?utf-8?B?eUNIc09mN2xMcGdTTjZVRmx5SE91bDBEd1FJbG9EL0xWaEtGczNTcUFPVmE4?=
 =?utf-8?B?TzZWd3RoN3hKem5nY2lOMG1DbEN2ZHdtQVZYUS9XeHZMS08yeW1wUDFsRmZC?=
 =?utf-8?B?YkM3b2VqS1VhaXBLbllHemRla1lqUDJUVTBzZTBqMzFpcEN6Visrd0FHMXFJ?=
 =?utf-8?B?YXFUS3ErZ3JEMU5WMTgvT3J6dkRTeGNJams5NXJ3bHFiVStuZmNuOXNyRGpn?=
 =?utf-8?B?aEEzRncxTVdIc2JodTNmR3lGVTRRN2JlV0lZOGViK1RDVWhhamdhZkJVSmlh?=
 =?utf-8?B?ejVpRkdFejBKSU5pekNEOWJDUmpuWFdlSzBnaG1LaG12TzhTaXNOaWFYd2Ur?=
 =?utf-8?B?Rkd6bk5renhKY0lGY09yTS9RZGVoWVdjMUxMc2QzWkVRdTVrZ2xVdERIZnZV?=
 =?utf-8?B?QnVKYVB3ODZJV3JEd1ZUQ2dqREZ6d05TMS9sbzNad1lJOS83eWMxMWxzS3Nv?=
 =?utf-8?B?SWh1ZmppNmxQalRJOXVwVGErR2pmUFlPbzJ2N3RWOWR3eEpSRW5rRTRybDQw?=
 =?utf-8?B?TnJreUxvK3lmR3BZdFg0czlia3JreUQreTQzNk1wLzh3WDRaK2wxT0VQclQv?=
 =?utf-8?B?UnhqVFhFZG13SEtQOVBTLzhqNklSSVg3bnRYTms1UFB5R0o0SGFTRko2ZUJw?=
 =?utf-8?B?MlRLcE5rZ2hHLzdHL2xEd2diTFo1VkJmOUlGaWQxOS81Zng0dGI0aUFGQ1Vw?=
 =?utf-8?B?Q1k5VDFjZDhhQ2hTbzNmNlpMUGVEREJudEdFcXJLcll5TFo1U3pKRmdySVJx?=
 =?utf-8?B?aXlsRitaSkl4cnBaWUM5bTduYWg3aGUxTlQ5MTZ2cHYrWHp1aG5zN3ErK0wr?=
 =?utf-8?B?WDNtU0w5YjBHUjFIQ0ZlN1JzWjBRaHV6eGdEY3dpdUk1ZmtQdmNWYyswS0dT?=
 =?utf-8?B?VjRvVldkdTlweEhCNUxnTFpXZkR2TnZxRG1OTFQ4eWVrZFIrNURZRkFVOFRH?=
 =?utf-8?B?N01OeGthaWNVTFFwdXRpcVpKY2JwYktwY2lCaXRETGdWU25YNzRmejllbVpv?=
 =?utf-8?B?amViMjJuanFCMlRleUdHTktWWkREd1I0LzhuUmdSR0IvMWZtaTVjcms0ZDRS?=
 =?utf-8?B?dzlPSFlqczhadkhTQ2xtY05wSmRENmxvVjl4N21MQjR1dVg1c0NDS2lIYkNW?=
 =?utf-8?B?a0dkN1U5TGNjQXFnZ2hUem5FZmhKNGZKLzdNRUpEZzBxSnZ3ODBwb29CeTV5?=
 =?utf-8?B?aExWdkorcFNaNnhNcUNHckFEa3VKeWZJT1pUWmV2THVzQUNqSDN0WnM5R1gr?=
 =?utf-8?B?eCtUOEpaQ2MyMEpPUEMzUW1mRlNkalBnclJBOXQvQlBpUjljdWoxSWV6cU53?=
 =?utf-8?Q?Qgripn9D4UfpLuedk209e5Ll87Hh8Wtbr68Hs2W8IQ=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea2b311e-9a44-45fd-1536-08de0d975f02
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 16:08:12.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNG64nwRCutmDquOYPfGjxezxKOG6hnLI/s2WF+S2z3jAwC+Qid86Bjvu7zBqB4Upl0mdnOxXZ3+F/9ga5IbTnKzMZm/krv4q/p/Xh6pN3zQoS1P9LWswiw9VHNBajIF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8145

This is obsoleted/duplicated by Sudeep's patch.  I am going to rebase on 
his patch series.

On 10/16/25 17:02, Adam Young wrote:
> The PCC protocol type 3 requests include a field that indicates that the
> recipient should trigger an interrupt once the message has been read
> from the buffer. The sender uses this interrupt to know that a
> transmission is complete, and it is safe to send additional messages.
>
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>
> mailbox/pcc extended memory helper functions
> ---
>   drivers/mailbox/pcc.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index f6714c233f5a..978a7b674946 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -306,6 +306,18 @@ static void pcc_chan_acknowledge(struct pcc_chan_info *pchan)
>   		pcc_chan_reg_read_modify_write(&pchan->db);
>   }
>   
> +static bool pcc_last_tx_done(struct mbox_chan *chan)
> +{
> +	struct pcc_chan_info *pchan = chan->con_priv;
> +	u64 val;
> +
> +	pcc_chan_reg_read(&pchan->cmd_complete, &val);
> +	if (!val)
> +		return false;
> +	else
> +		return true;
> +}
> +
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -340,6 +352,14 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	 * required to avoid any possible race in updatation of this flag.
>   	 */
>   	pchan->chan_in_use = false;
> +
> +	/**
> +	 * The remote side sent an ack.
> +	 */
> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
> +	    chan->active_req)
> +		mbox_chan_txdone(chan, 0);
> +
>   	mbox_chan_received_data(chan, NULL);
>   
>   	pcc_chan_acknowledge(pchan);
> @@ -490,6 +510,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>   	.send_data = pcc_send_data,
>   	.startup = pcc_startup,
>   	.shutdown = pcc_shutdown,
> +	.last_tx_done = pcc_last_tx_done,
>   };
>   
>   /**

