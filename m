Return-Path: <netdev+bounces-147567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAA89DA41B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF53165557
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA71898F2;
	Wed, 27 Nov 2024 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="asfSM2Iv"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE68188CDC;
	Wed, 27 Nov 2024 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697008; cv=fail; b=oOA7Cw5Hj0cjGI8T7LZZD1z9drG3pQwULvDq+W8MPMIRh9bFIXmhSYw6zEgkXMqFpYxtHOg0t5koZ+t8ww4vnvQjVbLkfRNQD6QwxykYEdFWySk5eOjhgvaEwgfrs7iu8eQ2jan6Wt/qInsP0ZagBgCWV0E2Dif7j5xyazRLI+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697008; c=relaxed/simple;
	bh=OLUIH+0qnpxJOqqBBjR17WVDwF9p0xglS4KXkLZn4cI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eHoYHgyq3jR9fC3iV1vQQn5Xlg6jgP1PSKXkEHRCwFtHrCdeEg7M1LyBOlQJOab2+EZnn7P6FokSpG9VWjSIOwwBlHg6974+LssKIDFrlkVIwfiYofs5DT0H2vVWWeamjslOHHQRvbavcsF2GIitnpn80rRmv9DtxcxrszG7KQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=asfSM2Iv; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDg9bdSt+haX+VdI5tZD3rG3gm+s9NyzphZIX5CPY0AY09qejWUGBYVARkve73mBY7ki0b5yaAabNhlF/pD7pmUsjsuKdd1ZWl5mQFSl9NxtRpzjPpAI3jBJ3N+uzIYXPr/5GFkmNYiHYv36XWBms4gSswftqMtzPpCsVrUTLctb2TNI5dk1V3zgMElq7COo3jzf+F2xAKVfnzcS0N5+RmF/W+IrxRMHIZFSKkrmw+k7Qh7iA6nbDZcBSIHQ3SwOTSLDXSpCgKNK1Ju5KBficcvnv4evqsX7d/3BWCOBX/8tbdTV2a9pyUycnnK700hhJfDBKOkiteM6b9aAllkZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLUIH+0qnpxJOqqBBjR17WVDwF9p0xglS4KXkLZn4cI=;
 b=uzEV3Tsmyc/hPXTbHp2/EFkxXWmzapvpefmCYUd6BmRwDeEvva6HWgPwwyN0t1geddPRBcH9/aN0CC5bUU/wFEV7ssIoggINEj5HI8ob3g+/WKBa9BxKtEr+hFyDdcCC2kZVVA/sS6u3v+3lrbDECiTejbMemcgadqXZFjCMEklWALw8BlzrPfWg03CvokZxmccrEQMrRcEFTWE9sdFA8+WdCQOdwNBFFt+xgogeRNIGlWKqWPGJETqtfS+gmaX3sfQKM5gkAyfEdhlpsjoMlbHQwB3GgHhsO9jSa2VVtLZ86MzJHBm/Bf1jrRDMxn6LhxT91/uavRsGYqil30JXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLUIH+0qnpxJOqqBBjR17WVDwF9p0xglS4KXkLZn4cI=;
 b=asfSM2IvvFdnkPWRkCOxZgSLLL/WzT7/TwdygtOUTkFH8L9tgQKWBbid8oGZynvO5ON2zvQDBcR0QHdvOK+odpf1lWDsi/UPBSKVzLtJROzuEy0aaMXL+zxll7qcnKPGhsL5eH5tKQCZOsGKpZ06xfUgF4CvqVpA97LTbUWHoOHhGpYTM+vDRJs6RdEXivD9BetKC0zHNlO52egdEi9ZNGQ9bwSOMRbE1N6bIuYItT50ztlH0LIWwIR762XK0BDsFXaJuTK8hONv4D1MeFGTNiomGNBmBzKJzGkG71W/713Mz3LhTWEdEQ644gR9svcBScwaj8uZMo7+4a2q4/l0gA==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB6860.namprd11.prod.outlook.com (2603:10b6:510:200::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 08:43:22 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%3]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 08:43:22 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <jacob.e.keller@intel.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>
Subject: Re: [PATCH net v2 1/2] net: ethernet: oa_tc6: fix infinite loop error
 when tx credits becomes 0
Thread-Topic: [PATCH net v2 1/2] net: ethernet: oa_tc6: fix infinite loop
 error when tx credits becomes 0
Thread-Index: AQHbPMhaZGBfrNF0BUS5LNV5KN1F4LLJZtAAgAFwcwA=
Date: Wed, 27 Nov 2024 08:43:22 +0000
Message-ID: <ff2a0770-6b40-4d1a-9f51-4fa7e2dfef4c@microchip.com>
References: <20241122102135.428272-1-parthiban.veerasooran@microchip.com>
 <20241122102135.428272-2-parthiban.veerasooran@microchip.com>
 <b48da380-3071-4a94-911d-8d742d9120c2@redhat.com>
In-Reply-To: <b48da380-3071-4a94-911d-8d742d9120c2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB6860:EE_
x-ms-office365-filtering-correlation-id: bf64f184-e398-47f7-9e06-08dd0ebf8d51
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VE1XR211b2l5Um00K1dOeUNqOUEvekhHV1R4cWpwN1NpY25TemNCNjZ6TnBO?=
 =?utf-8?B?WHUvNXQxMGtEQUJjYURlSStZUnpid0M5bHA5Y2tCbGNVeGR4T0VGWHlUU1Q1?=
 =?utf-8?B?dlJrcHdYOXlGZ2toUktzZUxvZDJmaEN6cFcxSE5vcEVZWUx3a3dZcndUQUNq?=
 =?utf-8?B?MmtpU3JXTUoyU0ZySDF4eGQ3dmFFWUl3RXV1Z1d6NGV5N0liOGZFeDVrbjND?=
 =?utf-8?B?Qnp2WWlTeitJNFJRVitST3FuTytsdm5SNmh5bURoQk5aNGJSRnBlekxTSFBQ?=
 =?utf-8?B?R0NXZHN0YW15RUlJYXRLWDlTTGpVMDMrdzlUcnRwNk96cjNUcE8xVGJwVFpQ?=
 =?utf-8?B?ZjJ3d3RSWXk4aW52d0VPdTE1TkZjaWl0cEh0UFdFOWszNC9YdWIxaGxaOE5I?=
 =?utf-8?B?OHowMnhKWG1VWVU5ZGxLb1E4c09IRUdGMkhlZDhEWHdsQlJ4emNhUkFhcXpZ?=
 =?utf-8?B?V1IwU044OVFlREV4Z2lEa3VDN1pXbXY3WGRtZnFoQlJyVDcvMEhyYU1LTzg4?=
 =?utf-8?B?cDBTSUdXTjVvOSt4V3pnWlNtcHZ1N2Jtc1lUME9rL3dnMnNSM3k4dUVPM296?=
 =?utf-8?B?eGI0TGNERzZNRE5Oa0VMaUhGRHZFTk5sWHYvZlNkM3JpQll2a3NHdlhOV1Fr?=
 =?utf-8?B?cFUrenZlT3FMYStJU0t3U3lRTEQ0SHNWOHJ0Nkk4NVZCRVBaQXh2TXBmVjZW?=
 =?utf-8?B?RDZqNnVhY2tHNjI1N3RYWndtNXV1bTRlTVpzV1phcWZQOC9wazRtTHhudVFB?=
 =?utf-8?B?bWVWT0UxVm8rcFVTYmFqOWErc05VZnE0TVJUZ1JhODVtN0pNcngxM1oyc1dr?=
 =?utf-8?B?RTlJQWJ5bVZ5TUowR2duM1ZBRExJWW84dkt2eW1La3YwQWRnbVVqcmVUOEp4?=
 =?utf-8?B?aU8yWFlwNVdQc0JSbm4wOTZnS3NwVUFFYVhzYmJQVmJseXluZkhKeHU3Y1RM?=
 =?utf-8?B?dFY5cFRoZHR5MGprQkVyZFU2a3UwdXZ3VGJGcitnZ0JWb0grL293eDNNMGxM?=
 =?utf-8?B?VTMwejdzell1UlNNbVRYSmNYYld4MjkreGwya2hQa2FTR1dITGZROVBjL2w0?=
 =?utf-8?B?Z2gwL2psY25qYUxjTFJlWXlKSlMxcEc5akhnQ3FITVhVTkdGR3U0czhJYnBW?=
 =?utf-8?B?SldwN3NIdlNXUm1YUHQwUk44TEJBWFdLMTl5WnB4a2d4ZzByZyt6NUdWTmlY?=
 =?utf-8?B?eTIyT1FoNC83OUhIMGdQUkxZV283SUN4M3FzOGpTRmdvVi9NSjVkYjc3L3kz?=
 =?utf-8?B?b3lHMDgvYWZseXdvMnlvZVphNnpZMnlFMW0vL0pKcFlkRnU4YnRXRTRtTGVs?=
 =?utf-8?B?U09yMHVCanMvN2t6YVlEaTZkRHA2WXVwWlNSSkVpTkFBaUJRVk8vWTBOL1BD?=
 =?utf-8?B?dVRhejhZeE4xRlB4aHFZUTZORDFlRVg3azNxK1MxQWoza01icDdQN0p1Z2Jz?=
 =?utf-8?B?Y3NMMGRCRGU0czlmR29wRWpGMlZSTzU4ZGV1aEl3dmh6cVBoR1NvVWxtdXY3?=
 =?utf-8?B?c05NakprZ3RDZXBsVXd1VjMrOTlBZ1d0ckcxK3dPUVB0ME1YRFRPSmRnMVIy?=
 =?utf-8?B?ME1qUHl4VlJhK3kvUzNHeXUzUlBtSzl1U0NCR05zbGtjb3NXWHVSNTgydTlR?=
 =?utf-8?B?QjVOazdvSCtvWVRkbUFlbTY5R2tJcHVoZjc5bDZZTE1DcTFXajFIangxSDhZ?=
 =?utf-8?B?Y085b2xCMlEvV0NZRDlNMGlNNGtCWGlaWGg5TVE2Z1dySXB1L2h5ZHUvRWxU?=
 =?utf-8?B?MXJ3dWJVbi9aVHNXT1VkeVY5VGVQUXp6eXgvN01PcmIwUjBVM2FGaklseE0w?=
 =?utf-8?B?dUlBckhhUzd4ZHcxWDJnVFFjMVNyOHBnMzBFZkl6ZU84N09PYnc3UStqWWdJ?=
 =?utf-8?B?T1BpbWtQV2pLRGlVLzV0WlN0elRQc0ZwM21paTFudEJMTXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmM5T241aVEzbTR4VXhDZGJLREJuRVF6YUVzVXd4VVViMmgwWVJZajFvVlZC?=
 =?utf-8?B?RzhuQlNEcGEwS1pJYW1pb3JWVEc2WkphN3lDQk03ZkMzVXRubi91TDkwRjFX?=
 =?utf-8?B?dzk5MWkyVWgrRmxHSUlDREU1ZS9TdGFUeTJKOGw0NnlVc215TEordlNwRnhK?=
 =?utf-8?B?US84SVl6cHVVdWZrbEhmdEQ5UDFEcjZjQ1RuUlNWQ25QRFdWOHdMY0o5SWl3?=
 =?utf-8?B?cHczZFJyd05TdVdlVktqT2ZyeC84dmtVRW9sS3dMZG03bkowcWQvUURHQUNh?=
 =?utf-8?B?RjFTclgyMm5RUkI3OFM4bjlSdmlJMXNuK0tpQ0Z2dkxaTURTdTk4MGdFc21D?=
 =?utf-8?B?bC81eEJ2Q2JiN0pub0pERWRrUzJXN2xFWjNVVHIyekVmWldzTWdoQ2x4cnA1?=
 =?utf-8?B?UlZLUmVkL2hNVlNVck4zblR4Sit0M0k1NU5jVVREclBVQkxlWXpNL1RrREFE?=
 =?utf-8?B?NDlmZ1ptQ21JY3djVUo5bWowdlFaS0tSd1ExeUlueVB1eHlUSjdvZUx0VXo0?=
 =?utf-8?B?VDRmUytvaHJzM3h3eDlIS2I5RmJyVkFxMWdNSTZ2bXNub3BxL1pzcWN0aW92?=
 =?utf-8?B?dnQzdi84azZTK3lnSFRuY2xhQ2FtV3lSNHNiQzRPNWlCYlRtMHhIN1pXQTVr?=
 =?utf-8?B?OVlUWTZtTkN4Q25EZDlrL2VBeUxjcXhWeGwyVkVBbHhoZTREbkV4akRwcmlD?=
 =?utf-8?B?Z0tnNEZ4QmRueGQwTGhWaGEwR1VLWWs4ZjNzQTIxMGk4aktweWg4c3NEMnZ3?=
 =?utf-8?B?R2U3alkwTlJ6L2pseGd0ZmU1YnZkVS9RK1luUFNFbkZ2aVUzQ0p5NzJPbTRm?=
 =?utf-8?B?ZWJIRC9WVnNMZ3g2dm5Pa09ubjVPVnJwc3hvR3p6T0UxVXc5WkVIMy9RMjlo?=
 =?utf-8?B?RFNDUG9iaTlnMjRVSjFPbWVvM3d1cVVPZFdpd0xENWZ5UTd5ajBCNG9DTGEw?=
 =?utf-8?B?eUFjWTluY2tIL1BhTTZZR0VJL1NKS2RXbEpBMlE3QmlLYUM3Rk9CdzUxdERa?=
 =?utf-8?B?V2l0cVZsWWpmbnNlVEFNMFl6WVZqa2RBUXNrelhzUWFjdlUzMnA5SGlwL2Jk?=
 =?utf-8?B?TGpma0hVeHVzNnVpR0JmamZUZUFGZXg2aEdia1d5R1pMcm1vU0tzNksyc1l4?=
 =?utf-8?B?Mk52UkdiKzVyUEl4cGJBcU9KZmcvL2RrRGJjbEh3ZHc5aGxNbi9CVXdZeTdB?=
 =?utf-8?B?VWRkQmNuREtXVm1JUnpDTm51VE1pNmgzTW9TZFBiWko3YWNpdmdBRnBTMisv?=
 =?utf-8?B?SGxzM1FvdkVwaklkbFpRL1I4YTdxUlFGaEw2RWxFR1NlQy95L1BHWXhvdlJn?=
 =?utf-8?B?WEM2WFdaTjIwUGo2cm5jTHNmM1FaRmc3bXJUdHdaeldKZlZtM3QxbzVIS3hX?=
 =?utf-8?B?S3VlZEQ2d2VqUTdGblhKUnRDMFBYeXN3TDhsWVFIOTRpRUtQeGpQY2tZZUhm?=
 =?utf-8?B?UlY3RFVvYm1TQzlNTFBLWTlDc3dhRytYZThEeXkrbXVPa0FGWEtGWTVLOGpi?=
 =?utf-8?B?aXZoVU5CSjloTHRhYVNkS0xONlZVMmIyWWZKSWFCN0htYXlCeVA1emFyRGZv?=
 =?utf-8?B?dTlnd0lTYk14VUVQMWd5WTJERGwySHdiMCtBWUVRSVhUd2dxOUhVS2x6WE9U?=
 =?utf-8?B?Q0dHNTdFb2RaQndNcmh3T3B1N1lzbFgyR3ZSL1hxRmRVMHZhL1ArQW9OcnJZ?=
 =?utf-8?B?MWtHWHJUVE42UFhhWEs1QTVDaHJJMm13VGNvZWh1dTNQeHNtUTFYNGxhalEz?=
 =?utf-8?B?OXNmZWtXdlA2Q1FReFJVMVJXOHIwdVNoN2VRRzE5dEI0Um51dlJaWlA5MGI5?=
 =?utf-8?B?UFNQWWR5NVd5emRaRlR1ejhFVG1CSVBsSGNJbVV5NXdtd1kvYnVaTjI5eGZk?=
 =?utf-8?B?TDI4QjJoV0N4ZnRXUzZ2dXRFcC94N0I4SnhDR0t6S25IeTNCNGFYK205ZlhZ?=
 =?utf-8?B?aGpyNExReDUxTklLVzdJRGhnekFUWHdGQ001TUtmYXVNbG94bnZnRmYvc0VI?=
 =?utf-8?B?OER3RldZY0xpZEJ6ZlN0NVFkMXBnMzZObU5oVkZKbE1Fc0RVMFBiSE50bG5x?=
 =?utf-8?B?U0tUYWVKN1BvRmhXbkdKcXU0ZzR6amZwem45aC82SlRkQzJoTUI1RWM2aDdN?=
 =?utf-8?B?eG5qN1dQSWRhZzhUNXlxMER2SVh4R1pNeUxKeVovbUxyOUEzQWVmRUw4Lzlq?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37CA1DF9025EFD40B8646C0BA1D39A67@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf64f184-e398-47f7-9e06-08dd0ebf8d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 08:43:22.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: up62SZISxjHkXlBGqLFteMkSEYnC+/f5XMq9/v+gI5ch2MJ6Yc0JpYif3B6VTqdNPwNYEmodUljlzU1ZuakzZttL7EawoT4R0ML6XwHWDI3HBoXa83LSoljnBtMSHu8l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6860

SGkgUGFvbG8sDQoNCk9uIDI2LzExLzI0IDQ6MTQgcG0sIFBhb2xvIEFiZW5pIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDExLzIyLzI0IDExOjIx
LCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiBTUEkgdGhyZWFkIHdha2VzIHVwIHRv
IHBlcmZvcm0gU1BJIHRyYW5zZmVyIHdoZW5ldmVyIHRoZXJlIGlzIGFuIFRYIHNrYg0KPj4gZnJv
bSBuL3cgc3RhY2sgb3IgaW50ZXJydXB0IGZyb20gTUFDLVBIWS4gRXRoZXJuZXQgZnJhbWUgZnJv
bSBUWCBza2IgaXMNCj4+IHRyYW5zZmVycmVkIGJhc2VkIG9uIHRoZSBhdmFpbGFiaWxpdHkgdHgg
Y3JlZGl0cyBpbiB0aGUgTUFDLVBIWSB3aGljaCBpcw0KPj4gcmVwb3J0ZWQgZnJvbSB0aGUgcHJl
dmlvdXMgU1BJIHRyYW5zZmVyLiBTb21ldGltZXMgdGhlcmUgaXMgYSBwb3NzaWJpbGl0eQ0KPj4g
dGhhdCBUWCBza2IgaXMgYXZhaWxhYmxlIHRvIHRyYW5zbWl0IGJ1dCB0aGVyZSBpcyBubyB0eCBj
cmVkaXRzIGZyb20NCj4+IE1BQy1QSFkuIEluIHRoaXMgY2FzZSwgdGhlcmUgd2lsbCBub3QgYmUg
YW55IFNQSSB0cmFuc2ZlciBidXQgdGhlIHRocmVhZA0KPj4gd2lsbCBiZSBydW5uaW5nIGluIGFu
IGVuZGxlc3MgbG9vcCB1bnRpbCB0eCBjcmVkaXRzIGF2YWlsYWJsZSBhZ2Fpbi4NCj4+DQo+PiBT
byBjaGVja2luZyB0aGUgYXZhaWxhYmlsaXR5IG9mIHR4IGNyZWRpdHMgYWxvbmcgd2l0aCBUWCBz
a2Igd2lsbCBwcmV2ZW50DQo+PiB0aGUgYWJvdmUgaW5maW5pdGUgbG9vcC4gV2hlbiB0aGUgdHgg
Y3JlZGl0cyBhdmFpbGFibGUgYWdhaW4gdGhhdCB3aWxsIGJlDQo+PiBub3RpZmllZCB0aHJvdWdo
IGludGVycnVwdCB3aGljaCB3aWxsIHRyaWdnZXIgdGhlIFNQSSB0cmFuc2ZlciB0byBnZXQgdGhl
DQo+PiBhdmFpbGFibGUgdHggY3JlZGl0cy4NCj4+DQo+PiBGaXhlczogNTNmYmRlOGFiMjFlICgi
bmV0OiBldGhlcm5ldDogb2FfdGM2OiBpbXBsZW1lbnQgdHJhbnNtaXQgcGF0aCB0byB0cmFuc2Zl
ciB0eCBldGhlcm5ldCBmcmFtZXMiKQ0KPj4NCj4+IFJldmlld2VkLWJ5OiBKYWNvYiBLZWxsZXIg
PGphY29iLmUua2VsbGVyQGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhcnRoaWJhbiBW
ZWVyYXNvb3JhbiA8cGFydGhpYmFuLnZlZXJhc29vcmFuQG1pY3JvY2hpcC5jb20+DQo+IA0KPiBQ
bGVhc2UsIGF2b2lkIGVtcHR5IGxpbmVzIGJldHdlZW4gdGhlIEZpeGVzIHRhZyBhbmQgdGhlIFNv
Qg0KT2ggeWVzLCB3aWxsIGNvcnJlY3QgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBy
ZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+IFRoYW5rcywNCj4gDQo+IFBhb2xvDQo+IA0KPiAN
Cg0K

