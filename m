Return-Path: <netdev+bounces-179656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F51A7E067
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1E1C188D626
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737F1ADC68;
	Mon,  7 Apr 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EaS1NMW8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94352846D;
	Mon,  7 Apr 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744034379; cv=fail; b=WPZguJoFFFPxsTOQZTgDtHZT7Uedoe5WZg/AL/qVvkGQwGqeCqyPc4DSTOnfRM0yZ2xINICza69aDbwZH3rcPtfywYxJSFYpQMrkvnwdSayJhs5so6Gk+uz6ux8FugS7J8FOXPScx46wB0Gch/1DkP9PLEwt/Ex7f4VHo2o8LDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744034379; c=relaxed/simple;
	bh=l69tOAtOYwi8kFp08ThvBUmgxKqkWZJs/DF2Eq60qeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=N/+b+MJ+MMgQskOgtO1xZ/vZ/jcbKy5ZvU8zuJUEpi9ug7zKgTf5IXAHI7KAa8PQlarGaGg5EqESvflCzV1nIpp4w0NXOsRGfwmhkAYryg2Wdue676qcFNI3seqjSRrIN1yTObLga1wfjxYGhP9bE9nhrF7wC7qiY4d1ZD6c88Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EaS1NMW8; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMr94RlPP2I/mb7+8KFgtHM6N97AxAkc/5Lm47zuUz6iIwPqfwyfeJYvEqUa7vAV/ecW7s+8f3XhgmPU9xVSrGH7CAvNBUpKkv3RtJQTXZmVqzX5ZUj+k8PzrwJW3Ons8XYwdSuGlFSdL16R6pmX877hT5IxQFgG8BMnJWQVHKfFBZhGtSptQOTevrepFLLsCjugMPfVcpmQtstR4dCI9ymstxRc4QWg9dTW8456u+Z+O0mGYqKYKtMaNuPmNPKngSTyEQAdiGwb+wFrtidQg4yz+461c4nFRolrOEUgA3XAbCiHw6SgVDoeiF/2hNDEhAzgxpW4V3YOpPauuaCI+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztgv9jzwuxqdE//fTlk7dJ1/OW0cM0xdPP44xiACbzY=;
 b=M5SbseJXN5eHgkyCehVCjkPbQX6J0ZbHlBpz4abUvf01h1XVKtnQaBMlp7cKZ+LtQvNs0pn74hwKH+w+WPoJPGYDvKMH6Zg7hlqVO0OnWgkuTr/Tk7zSAeJ8ooCdQHMQi78ilbW1kkp/PXzJ+6m6GIBfMkAJBzkZR9CA3IHfC2/5yB6dBfGyKw1rQmor0y4a9lJt5HVoR/h97W3EOgVuqL2Xz3aI/mbFjh0/0KXLnYsidS0NZyaAjWrf5f3mUzC6nt9/Vmm9ifPSnnHKi8P+BXeBLKhqrtjoL62H99a5KubhSV/uMvX9rZN74bhzizDue+7APmrAl91CTnh3cQlQXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztgv9jzwuxqdE//fTlk7dJ1/OW0cM0xdPP44xiACbzY=;
 b=EaS1NMW8NLiuKSL1NP9RubEviYJKhSDk46k3zXHA/Ck9I1u95mLPBOkqI2SwQWCLX8q6m6zxKvW0cFiQAeAZsyDDON+iICiNauJ1cN4iIkbiGj9px/HSYXFsreGhRVZt1eYv72097DcmcMa2EdpjxaCpF00xvxfP8U0KTamGIm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH7PR12MB9255.namprd12.prod.outlook.com (2603:10b6:510:30c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 13:59:34 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:59:34 +0000
Message-ID: <9791f0dd-f7b3-4174-8b52-0e8767f153fa@amd.com>
Date: Mon, 7 Apr 2025 14:59:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/23] sfc: add cxl support
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-3-alejandro.lucero-palau@amd.com>
 <20250331183114.GE185681@horms.kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250331183114.GE185681@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH7PR12MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: f668f776-e883-4b40-3cc3-08dd75dc6d3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERha0doN1JCUmlubFpGSVRFRTFEUCt6em5JNk5QWEdQbUdGdm9MdUk1QVdq?=
 =?utf-8?B?T0lDUHdzTHE5MUczYnE0NnlpNnA2NmRNamQ5b1RuOEUrY3RKR00xZUZad0h3?=
 =?utf-8?B?TU9DQXhHRTU3ZTVDUUd3ZnJ6eWJnSlQ3M0RtdGJtOFV5ZXdPYjJSdUpGcjRj?=
 =?utf-8?B?TDRvR3lQSDFZTlFVdVBjL2pmMXZBdmVvalpFT0FOU1o5YVRQdkFaN29LeGpT?=
 =?utf-8?B?TnNIajdwYVlQZjBsZFptZ2pycGxwUERqSUdTbGNsaEpnYW9YZktkUEVBV1h1?=
 =?utf-8?B?RVpqamtwd2lXdVZ2YXdvT3ViMG1tUGFPQ3drSXJVYWdrcHpOcGx3b0JvSjVJ?=
 =?utf-8?B?aC9TZ0UxN2VjbWcxcG9qaHBFV21kc1dtdUc1OXVWcjlZSnVNQklNQ3pRQ2Na?=
 =?utf-8?B?NGtrRmlhdm9HeER6NS9kMko2b3VFUFQ2UkM1M1FNTjAvNGU1dW1xYnQ3ZE0r?=
 =?utf-8?B?T0VJZExRME9DTXI4YlhmVmtxeUdtZTljTkx1STZzdzdSdkNjZ0NrNGJFT2Iz?=
 =?utf-8?B?dXowTGJzaHFmSENYRW9BbTVkZFpPYXMxVGNISlI5dTNVa0lPa0czSW5JMHBT?=
 =?utf-8?B?MGc4M3Y3Y3FJd2QwTEMrTnBReFJKVVN1SjBUby90dmdXUWFOVUhQMHVIVUI1?=
 =?utf-8?B?L0VOWExONk9lQUpBSkw0a2ZIMlZ0K1RoWG9IQk42ZC81WW1NZ2RqcTNWQWlx?=
 =?utf-8?B?dDRpWTY2VlhEZEU4T2xxU1Y1bHRhTTVhUXkwdWVudjFheDdqZXlDaG5WUlI5?=
 =?utf-8?B?d1FDNk5GNENBWmJwVktBMXpXa1c2VHYvYVlmb1NpUXZrcFQxMFhxOUNIQTc1?=
 =?utf-8?B?eUJJMk1mR2NnVjd0bmJ1QnY1SFF6d0tzbUhoM01maHlqazB0MXFXbUtnd1RL?=
 =?utf-8?B?UXgxZDd2b24yREtUTTMxVENYUUNubC92ZWxVTlkxbHlTYVhJbC8xNURoZkgv?=
 =?utf-8?B?LzRQMXdaWWs1SU14VVpDTkdEbGxXZ08vUExrcFE3M2hSSzlaS3Irc0tSZVdJ?=
 =?utf-8?B?QWFZZ1JMT0wyUVd2L05SK2Z0TEwxQkNlZnlnakFxbE4xSzJLQnk3dUE5WHBs?=
 =?utf-8?B?ZXRNTXJFbkFveFlmOXY3QkdxNGlkT0ZtcFdmSTd6MTBWcXNuMzNOMWFUaFZZ?=
 =?utf-8?B?bnAzSURnaHkySzJwOGpFclowMlpKWlc5a3ZrNGUwc2NHcGNHR0lwaXpvVTk2?=
 =?utf-8?B?U2FsSzFQa0hORFY4NUJ0ZmNKVkpPbThySFk1OVQ2UU14bEdkREZTdUhHeUk3?=
 =?utf-8?B?bmgwSDVCeTREdHJzVTB3WGFLeEFrWHhtOUpmRFRVMVpIU2ZGWG9Na1BvZmVX?=
 =?utf-8?B?SFhPWFlmdXJKbGVMQitKQ3hwbytBdHpGQUxlMVB4Y1BWQzdqTFVjWHFrYlZO?=
 =?utf-8?B?UjNja2ZDZ0FCWFVHV0oxZ2JBQXpHZ1l0a1N1SFlYdlEvMElyWlZtTFFTTWRU?=
 =?utf-8?B?cmJSNVlBbHlvR1ZYMndPMndKOVRiWGt1Yng4SFFpWTlZSVdqTkFUTFE1bDVj?=
 =?utf-8?B?eWE4aGltcTFIYWwyQnlPSXN0eVdNZkdyNHRRMlZ4RnNIVkRFZGc0bnlHTFM0?=
 =?utf-8?B?L3M2d1d5bUJZY0c2VG1BdUJydnp2cXdycWh6SXNjMlR0WElpZGRXSG1CNjZp?=
 =?utf-8?B?NkRwTmNJS1ByTDNpWURReVBwN25oVjB4REJHWW5qUGl3VmhPTU8vYTJHYmdG?=
 =?utf-8?B?Y3lkU1ZFc3pQUEZzaUR0YnZqanFwT2VoNWF3ODhpazJ4STN4cjBjdVVlOEhQ?=
 =?utf-8?B?OC8reVF6cmdtelJKeGN5ZE13czFMVGswRWdhdnREVWF5ZGJIRVhiak91WTNl?=
 =?utf-8?B?VWh1K01Yc0ZsVENydFdQVHN0bUtyMHRNOTNLYlhQdEt3R0VkaHB6K2RBekFC?=
 =?utf-8?Q?zFuSMWyLqsQqb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVEvRjU2bkl2elQwMlRCSXd3ZFRzRmFnbGN4YmtHM25kU01JWG4xWVVhc09S?=
 =?utf-8?B?NXV2UTJUWWMzUFpxanJkZjdGQkt2cVRXUm1RbnpwME9ndy9UdXY0R3pRdERZ?=
 =?utf-8?B?dzNtZEhGcHR0SmJLSnllUTZRRTZmQ2dDY1cyNVcxMk1Jd005bStXRGl6cE9R?=
 =?utf-8?B?Sjl5T1oxQVU1YU5Cb0RIZDFuUjNuZjVXU2p1SEZUbTlrRHBPUkxvbWhnWFFL?=
 =?utf-8?B?bDdKRUpjN2JaQkhTR3N1SFlhR3h1ZDhyejhPWEhiTHVCTVF2VG5nSUNXcXhJ?=
 =?utf-8?B?aGRpSmRIQWJBdkFaSmo4elh4TFlrblhuZzN1RVYyOTF3Tm1iSHY5U0hNaHMx?=
 =?utf-8?B?ZzFlM0pEVmthWUdNSGFvaDFYZ0EySjUvU2l2cUduK0xFMEd1bCtGcE55UzV3?=
 =?utf-8?B?aGdwc2R4b0ltbTZWVGtLeDZVU21iQUpLQjdCRm5QYXNUMjdPY0t4bjU2WlJ0?=
 =?utf-8?B?NXg2SUtHT0NzS0FlUyszVVI5RHBHT28zclgxOEtKUFpRWTl6T09ja0JBTUJw?=
 =?utf-8?B?ZzVwUXBQMjBCZ2NWSlFYS09pNFp4VnJ6WjVzSEZDeGx0QnovOUQrdkJTRDRI?=
 =?utf-8?B?c3h4WTc3dkpZcU9WbVdqYnZiTDJlLzNkTGNEem9IUFJOQ09FOU80YVNReWow?=
 =?utf-8?B?TEhOS3RJUGdwQ0JOdnkwQmQxS1ozWnppZGFLZTRKVjB2ZGh4a1I2YkxxekdN?=
 =?utf-8?B?RUtJSzRlcFRqWDcvQVlXU2VHbFN2dmhzSUNueUdSNC9ZOVdNYXZIYS9WUUts?=
 =?utf-8?B?YyswT2tzMGp1NFAxTmw5bml0V25WS1B5cXlkTGdoV0RyUTh1Y0pYZGU0V01L?=
 =?utf-8?B?ZnNBL3ppMS9pQnUzbTFqY1ZnQTI4YytaRDZkVmVZVVZJUVNkWUQyMEFtd2Vl?=
 =?utf-8?B?b200aHVaNXZHU2lOdU9JQnFHSHI3UXpXQXVzWWdGSWJZeVd4SDhQM2EwWFgx?=
 =?utf-8?B?U01mL2lpM2VoREl1MG1pUnJueTE5U2IzSDlKNEdFeGFxZEN2Y1BFWEh2ZnRh?=
 =?utf-8?B?TitPelF6REx4aEZTNklxQzg4enpDc2ljRWpySGVGaTRZSHkxT2VkdHpNWXht?=
 =?utf-8?B?ZTBnNFNNWFMzSDRoSFpJS3FTTkdwR0VXQnltOFI0QVA3eXRlT3IyeGpTTUVx?=
 =?utf-8?B?N0VVTU05dUJ5Z3hDeS9xOXZJSWtpaDdSZmNXWHgrWVdhYkRFMmo1bU5TdXE2?=
 =?utf-8?B?M3h0Tlc2TGNKNTM1bFhrSVNlaFRkRytjM2xlVHJWZVhtNms0UFJXSHR2cm1P?=
 =?utf-8?B?MmJTNS9oamtCMEw1b0Y3RkhSVENOMnZiek5uNmdzRU9TWkZEVEFDR01WZWF1?=
 =?utf-8?B?dUsyQzBsSmxBdUI0L3pIcTRZSWVLT0NWcndLVVhHdmNMMzB4cGw4b0ZJc0Vs?=
 =?utf-8?B?aHRDaW1URVlyM3N2SGgzMmVyVXpYKzRBTTF5Z2VSazRKQVByaCtZamU0dkV6?=
 =?utf-8?B?cFQrM2VJY2ZHL2JWR1FwL21peFRNaW1DcC91cUhjSTl2MExVdDZRQU5UMnFG?=
 =?utf-8?B?Y3c2WHhMR29ib20rM1Z4NlFiaHNHNUV0UUtXbGZpNTlTU0wzY2ZxVGxJQ2JH?=
 =?utf-8?B?RnRQOFNocDJ0cHFqdnN3bWFtMHVDSmtDUjFLU3BLdVBFdE03ME00L2NHWHhh?=
 =?utf-8?B?YWNmelgxMHl4RTJWclZzK3ZOYytyVGNPRVExeDV1emQzcTV6bVlZaW44TGZF?=
 =?utf-8?B?RkpZU0Z6QVFTWGRtU1p6VUpNVlVNekVEQzBGYjlkTk8wUVJxRW1QTkh1d2dM?=
 =?utf-8?B?S1RJSzBjWUoxT0hwTk1nN3hqNEEycFhvT0tKOXVhNkpsdTEzL1JxTFRKRmVI?=
 =?utf-8?B?SGdSK2h0WDB0YlhhTnBhbG1GZ2RNQmJpU0hubHk1Qy9uVVNHLzQ0SUpRc0dU?=
 =?utf-8?B?c1l1SWoycktBWE5EUE5YYnpCRGlqT0I5Ti9PVURVUHhYQXlyREZWMDNyUUNs?=
 =?utf-8?B?RzRER1E3eENaOGpOaE1HcERBNGFOaDY2YVB4NFBKcXlLTzBOSXlEaHlCWkJj?=
 =?utf-8?B?NjFFY0ZmTFJSeGplOTNKeE1jcTJRMzVmY2NaZ1FlY3RQSXk5RWVNK0htaHlN?=
 =?utf-8?B?WmRUcDJid3g3Um1FVXgwRE1iWmpHUHp4ZkdKSEkxYXJVOWRCREc5SlRJcTN2?=
 =?utf-8?Q?yrKtKUdwbTwBSsofGBDc1ENgi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f668f776-e883-4b40-3cc3-08dd75dc6d3a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:59:34.7192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Xx3Q96Iy7MvzMKnitb6fAd/h2TcatiDgo//hk8Qsgy3fKf34zqxMQ+Rf0pPfIxjKBnaoiAmgFD/JCtzYxxCRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9255


On 3/31/25 19:31, Simon Horman wrote:
> On Mon, Mar 31, 2025 at 03:45:34PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ...
>
>> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> ...
>
>> @@ -1214,6 +1218,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
>>   	if (rc)
>>   		goto fail2;
>>   
>> +	/* A successful cxl initialization implies a CXL region created to be
>> +	 * used for PIO buffers. If there is no CXL support, or initialization
>> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> nit: will
>

I'll fix it.


Thanks


>> +	 * defined at specific PCI BAR regions will be used.
>> +	 */
>> +	rc = efx_cxl_init(probe_data);
>> +	if (rc)
>> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);
>> +
>>   	rc = efx_pci_probe_post_io(efx);
>>   	if (rc) {
>>   		/* On failure, retry once immediately.
> ...

