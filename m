Return-Path: <netdev+bounces-132963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2963E993E75
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CED7B20D04
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 05:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE813D88E;
	Tue,  8 Oct 2024 05:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OIeNRyBU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7094D139CFF;
	Tue,  8 Oct 2024 05:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366435; cv=fail; b=BX40AI52tAvZObZUEgnOm01yS9ZXQaAmj5RHFTCguesyk5sE2VJ7USfzNoE49nBclXvix3F8QAGle1fli9wAoF2U9u2FbHMSd6S+ZRxlB9Ixk+PponKzkxSWebEAgxUn1DJWR9oTBwCJei84KJUA5WsFCyQhO54+BAFuMHuoVL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366435; c=relaxed/simple;
	bh=OXFQftL2VtY/2SDdyasmR7X/I0Oc4Cbbk9rYxz7K9y4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VTPIt0kHwqpY4z1moCX1TSAi2rn3sghpIn3jI9FB2k1XNtJTvQ1ez2A+kSXncDrfP7L47PqPibjlt2p48pZvD7kEDw2y2hx4ECEexf3572Sfg3gkaSLK8oz49HwzVrqqb7s10cXb2pOfmfToWXDMjEoDMp+0nD2qQr5gDuQQ2rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OIeNRyBU; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QADJDLBhy7LIW2vQ2J6Lkl8BdJkAEzcd/buDhc846E0V9S3W9AoT076BPeVnE+YGtXAWxQaMRo/WM2NF58r7M44/KdPlc0Tm+dEH8/OE0XLdLN/saNTG3EhJeWPX9tOMBAmi27sDhZfpL6lkZ9QCskEUmt4fnoyFaoFuv2+jdrVIwTsNLNtn+93/1RbpI+I7QCm21wZFFKD4Qo5UY+p9TiPUDRZ2KIn4tRBBDD+GElAyc7B7EEt3TlpEuAfmbIUiRlYXb4Ll+tdDJZ1Kb0rBI88914ZGrX/1TRLWcTyjmy8iVhCquV8nZZKTtWITtWvfdJsNlQWtmlqVF3mTZFP6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXFQftL2VtY/2SDdyasmR7X/I0Oc4Cbbk9rYxz7K9y4=;
 b=I0zHabSoKNaOagNZzKl7ckMzG5NkRUk5N9QAujRTORSpRU2DSeovcNYxa+YgJsuJSeitPxjSPs1lK+D7wDp2gHYp3+MoKvIWtrMqsOkIoe+tsdqdLfCa7d1v89eB5vyzvPXw8ONU+pEH44KJiEEB9Ru0fbJUCYTs8etpmOwPVgX7QdRIUsE8KbWXc5wa/sB8MMQ7O/b6ZjfQkVlDp/vT0paBY2V+kMi3abcHwdMe29b4AvS/ZtLfGgQQExWqu5eGSBbBP9tddXdnBs2ZOK1s2sJUgNQSDrJD1t3BKZx1/S7xDFjrPay65FrodivNAIkC3bbxUBtn6eqxzkfFWUWnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXFQftL2VtY/2SDdyasmR7X/I0Oc4Cbbk9rYxz7K9y4=;
 b=OIeNRyBUiLICxjS8th23Ne64LdX3xSkilUCPXTJglvOYniGoaslweSZDrrYnizDX1thN4n3f3m0O0/J8wyj7E6A53vqmFROv6Mw0SKC4SV9LzwJEpHG1iXgjrLXkbNHkOSW29ZWepVwoeFQ+F75CHA47D0N0QmXF6yhpZnlnMrhXVWbcx8YitbgJC2v2LBm3i81GOQP9N+5ONKgg2vnbD5bSC2YfD5NYFMTMCYvG4ba3d5Hd/hSRkGywe9eunIKc3hdTyasHncZqHHaKpDCOMuzpSDs50iTOdpAEK355YzdYoMH6VcT2n5Ic0RM/2yp5EKpM4KOo5gQKw3nBur2rDg==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH7PR11MB7719.namprd11.prod.outlook.com (2603:10b6:510:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:47:10 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::84fa:e267:e389:fa9%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:47:10 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<ramon.nordin.rodriguez@ferroamp.se>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<Thorsten.Kummermehr@microchip.com>
Subject: Re: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Thread-Topic: [PATCH net-next v3 2/7] net: phy: microchip_t1s: update new
 initial settings for LAN865X Rev.B0
Thread-Index: AQHbE/7chW5i04kMfUu/XdWzSyiXUrJ29HcAgAP/AwCAAIitgIAA5uKA
Date: Tue, 8 Oct 2024 05:47:10 +0000
Message-ID: <61c1ccf2-1eca-43be-84db-e979de0ae0f5@microchip.com>
References: <20241001123734.1667581-1-parthiban.veerasooran@microchip.com>
 <20241001123734.1667581-3-parthiban.veerasooran@microchip.com>
 <20241004115006.4876eed1@kernel.org>
 <2fb5dab7-f266-4304-a637-2b9eabb1184f@microchip.com>
 <20241007090047.07483ee1@kernel.org>
In-Reply-To: <20241007090047.07483ee1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH7PR11MB7719:EE_
x-ms-office365-filtering-correlation-id: 1752d871-db48-4c62-a1cb-08dce75ca70d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RE5Bblh0Z3duQTYvWENma2NTY3k0cjE2V2o3ZWxodkZIM3ZVbFFtMllxZkp5?=
 =?utf-8?B?LzBVUXRKSUxOL0pKTTQrbGg2eWJ5Z3dRbWF5SUxsUTFYU0NiMlE4NjU5YSsw?=
 =?utf-8?B?OWVJNTFESS9oTlVpdC9qNVByRllVemlUUzF0UVZoY3FzS2dJRCtOcXRsRXk5?=
 =?utf-8?B?UWxmL1l2dkFJWkpKT2F6bG5RNVlNcmg3UjFyNWVBbjJtU0YycW15T3hSdjBi?=
 =?utf-8?B?K2VwSjMvSmdONG1IZm9OVlMySWRRTE1XWVJlVTRPcVJsanFpOThIR1R5Vi9Z?=
 =?utf-8?B?ZkhrblQwVFVvczNDakc3enhlRXIwQXh1Qk1rQ0w3WG5GZkdySkJyY0gwQ1hp?=
 =?utf-8?B?OXJjcERhekNyTCs2ajlYWW00R0ZqcndicEpWTGZjWmZOYy9hd2x0RXZJVHhw?=
 =?utf-8?B?d2FlbjJaYkxqQWpGUHBDRzlNUFFHaCtjeFJnam55QnEvTW42UjZhaER1M01w?=
 =?utf-8?B?SElJaWhTdjVWOVhOVG5Nek9xeEh2VDZ2Q3oyNXVUNjZNRE00UWZWRGRiT0FL?=
 =?utf-8?B?RklUN3NLNmt4Q0VOOGVtamp3VXluZWxUNzZuMEdrRmkrMnl2SXpkeDZCaEcr?=
 =?utf-8?B?YW1uakNkbmUyYXRQNjdzMDdsV0RlKzVmWmQzZHpYN3ZsNTVWYnl5d3RCaEFC?=
 =?utf-8?B?LzVtekNMMThHaFczZHZCcE5BQzBLNlpwNU5uRGNFVnJFVnBiSkNEMWR2bEJS?=
 =?utf-8?B?UUlRMlBpNjVROC9lQnBTaGF0dE80UDhvNzl0c3cvS3QzcGtmc3htNXExcHUr?=
 =?utf-8?B?YTlSeTBEejVHN09uMUlXYTRxQnFYQWZwdnhLSHpyZmsyUlRUcWo4QmR3VWJr?=
 =?utf-8?B?dWU5MjB4VmZRUTY3WVVvZU05SGRFem9hREwvSWdJcjM0cDA0QlJJWFpwWmlr?=
 =?utf-8?B?TkwzNW9NMFpxOUxiN2dhdldIamdnV0xvRVRkZDNOcWQzTVZuOFc5R1prRksv?=
 =?utf-8?B?UWkrWHNnNG5XQmNaR3JjaTdyTVpPYWoweGk4ckhXdVEzT2E5VThaQ0haZ0hU?=
 =?utf-8?B?SzZUVUJiY0hjRVJEZWdoOUsrN01SQUQ2UGNvR09IMW9Xd0k4cnpBUXFQUFVN?=
 =?utf-8?B?d00rUHFqK3I0QS9SUzNabTZDTFB0c3dDTnoxUHdEL2Q5Y0ZjWFYvVUtDVUJj?=
 =?utf-8?B?WXljZFFkWXoyS3dRdGVIdEFMZXdZaStFYk1lbXJJWTB6NzlYZi9ZT0U0R05F?=
 =?utf-8?B?WWlBcG5Bbi8wYlk3NUFRU3NiSmNlcFVHcEdiMHh5TjVsTVFLZEkzL2Q3QSt0?=
 =?utf-8?B?RmZnZmphQWpqczhYZUt6NVR5QlNXbWR1aTBPSnRpMmpKb3hIOERJK2hwTWQ0?=
 =?utf-8?B?ZS9oNGtqQ3NlbStjQS80ZTJnUkk3blVKZjV0V2hHcXBzT0dHZk1pSC85R2Ni?=
 =?utf-8?B?SFhUK3hiS2RVOGl5b3NtcExkUFNuK2tISS9OMXdWZ2lXQ0xXc0pFeSsxQWh1?=
 =?utf-8?B?OFZuc08xSWNuRjdEcmlGK014bnZBcyt1c2FyWmhiaVdHSDNsbitOTDdjRDhh?=
 =?utf-8?B?azh1emhEbE9XNmRlejlHK2I1eHIxbUtBWTNFVjhnbjl1Y3Q3U2xMMU5LYXJn?=
 =?utf-8?B?OFRBdk1EV3FOTE5VY25sYnFYZDFwdUVuWklXaWVGbVlNVGJaWHBWZ25Rb0FT?=
 =?utf-8?B?NnYycFdvOVBOd2Q2bjhJZWVhSTg2enpRZjNhNlNINkVscm04Mkp5MlkzcDEy?=
 =?utf-8?B?VDU2S0c4WDg4THArYVl4OFE3Sjd2eTQ0TzV2SEs4UlduVm5JZmRxS2V6Q1lK?=
 =?utf-8?B?Q0k0bGI3ZXpiSHJDZDdRc2c4VFVDSUZsK1kyalVCQTIvTTlQajRCU0JFaEUx?=
 =?utf-8?B?Tm5FbEYwczFEN3Fjei9vUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDNXem1hb21yVzRwOUxkRGhWLzNhU2hqQkdOWFUvQlEwUEgxd04yZkNqdHM2?=
 =?utf-8?B?dHhoc0RSQ1UyWGk3ZTRrenFDMWNlQWhUYU5DS2JvNTA4M204cXdaWWN2QkxP?=
 =?utf-8?B?a1dUMlJrTkhjT1Y0UVRrb2FyaEJkOW11WjM2Um9STVhYdWF4bzhWSjFGNEpO?=
 =?utf-8?B?WklVOUNsMGVyMDJNQUlOUzRZNnpJQ05JU3h3aWF1NzFBN2tNcVZzUkJRUHVq?=
 =?utf-8?B?WndxZVNlall2UVlTREREeVF1TFpCbU83ZVlKaVVBckdRZWxrUDhMeXJKV3Bu?=
 =?utf-8?B?NEJKNU13blVGU0Frc2RuK0Fjc1U2MDJMMldYekYybXg4NVY1N04rTXRnTnJQ?=
 =?utf-8?B?VGo4U2VxQTVERUJ5MlN3Z0NFLy9tclBJZmZmSGtRU0xUN011Zlh2SWZWV2tj?=
 =?utf-8?B?N1dkV01OVEpoY1VjM2RkemZpV0N3bWoxWnNtcmxvekNhWWdWMzAwUk1RVzFW?=
 =?utf-8?B?RER2S3dOanNwdXdPekN4bjIrc0FLYXUyUnhOOXdVZ2Uzd0s2OWFITDRrN3Ft?=
 =?utf-8?B?dGVIamt0Z24yNkVsQmN6b0RVMlBtVkdQUnh3YkxBQjd0bFZheENGa3puNnN4?=
 =?utf-8?B?YUZQdVdFcCtFNzdlaTlsaTkyZ1kzOU10R1BRYkxMaCtuUC9pQWpvdGJtMy90?=
 =?utf-8?B?aTYrQnNPd3ZPVnBvd3NTbzJjeXRwOFVRUHpoMkdacHZDaUZWZTZIVFh6NVgw?=
 =?utf-8?B?RzI4OWdMSVgrcUYrU1ArUVBEcDYwM2ZRUXZKb04xbDc1N3RoZUZFdzFUKzg2?=
 =?utf-8?B?ZmFIZWUrYnJRVUNzQTgyOVBDbUpBSzNOSG9kUDAyYVpXQWJQZXVMbXR0UGtQ?=
 =?utf-8?B?a3lBbWtac0l0a0ZpSTBIclVtR3BvVjhZNkJ1TVg3SGhxQUoydzVyT2phV1A0?=
 =?utf-8?B?S3Q0Qi9nem1tR1BtYW1jUEM2Uk05aWNWeWhTdXhqM29jYzc4V1EyYlpaN2pv?=
 =?utf-8?B?RkVPbGdOVGVGMVUxOG8wNUJ3Z1hxWDZHd2k1b2FOWDN3VkdXVXFkVXlhK3Bv?=
 =?utf-8?B?TnYzL1lBT2JTS0h3eXJYeHhsdWpHQTl2aVlGbWRLQjNvRDFPR0RyZmNpTFRl?=
 =?utf-8?B?OXBGSmNGc3NmUXBMeWNCVHIyK0JBbFF0MExuZ3lhLzNkRkVKVWdxWDdNSExQ?=
 =?utf-8?B?dDZ2Yy84cnpERzJjcjA2WkQvbXJlUFpQVlNUZU1MMGJ2SjF0em5wZ1VoT3oz?=
 =?utf-8?B?N3BPSWhvUTZ3a1Ard1I2QkxlbVY3VjI3R0hMa2t0RFVxcHU3L1JSSTJLUUh6?=
 =?utf-8?B?NkJmc1EzR3VjVDJ2RGZuZlNYNi9TK3FlU3g5YTExOHdxMWp0UEljOHNaMnJo?=
 =?utf-8?B?T1k3bnBCNG5zbExjN0JGblBwcDJESEhjUEZQLzJWbzd3WDBaUDBLS3ZUczYr?=
 =?utf-8?B?SXNZN3JKSERISlo1SmZlV1RGYWY3TEFlK1JsQ1VQb1gvQzZBNDIrU21PUVgw?=
 =?utf-8?B?S3k1cjNGcVZibEdPbVZiSzFyL2lKOHZEMGxXOVhkamMyS0YyYk5iM281Z0Nk?=
 =?utf-8?B?TDNXSE9xRWFoTDI1c0dXZ2Vpd1VZL2ppTFRremNZcGR6U2JZem1QQ1JjSTlv?=
 =?utf-8?B?bWZiM0tuNnIrSERUeEdvWjJzQ09LcjhRTG90eXpZdkNPWkhhdTdTeFo3RFdF?=
 =?utf-8?B?OEhVUmo1bkFsejJ3RFlXTWdrd3BwRlF2T0RMcG83ZTFCM3c3VERLNVZCK2V1?=
 =?utf-8?B?YmVBam5YNTMxeGpSVjk5OG9RTGt2YVlXQ0ZubzBJcktZVjZhdENkeEx4WHRn?=
 =?utf-8?B?cEp2NExTLzkxUTJNREUwamJnQVhaeThDRVEvMTcyZUU3amJjR1pSY3ZmU2Ez?=
 =?utf-8?B?Z29udDM3ZWV1ZE55TmVsRE4reHA5R2FCdGVTZDE5S0pITy9KTTByZDFvRVRr?=
 =?utf-8?B?M2VPSURSZEpRVjhVek56cUI2VXpYWlpHOTlhdFlwOUdFRTUxVGFYLzkxLzg2?=
 =?utf-8?B?RzFNcFBLL1R2cEcrdmRjZWc5dFUrMDFmUm8vZUFmM1ZKQ3R0UGdZZlo0QXk2?=
 =?utf-8?B?cnNTUnVvelJIdzc1TkdKek1YVmIxMGVQQkZHamhpVWRjNHkvQTFyZ1BmUVR0?=
 =?utf-8?B?OFZ1ZGppSko4UnIwQi9GUXJMalc0ZE82RFUrOEFQZ1c2ZTFMZWVSTnpPVHNq?=
 =?utf-8?B?VXpiRkk1Zlp3c2dKUlZ4a2NIUU5vSDJiNklzN0VoWVcrOUs5UFY2aCtQMDZl?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A16255CB33463E4BA52D1B1A8D92F4D6@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1752d871-db48-4c62-a1cb-08dce75ca70d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 05:47:10.5317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2cFFMuCSf6DqdBS7A5CKoEF/OsWtb+nd47PwX28MGFvH2EmPTNPQKqnlyy/ZzU/BeEg2bTLtz/66vHj9CxQ6c891NE/U3YTDTH5qiRw+f384fvaylS+P5OxvP2e3qDr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7719

SGkgSmFrdWIsDQoNCk9uIDA3LzEwLzI0IDk6MzAgcG0sIEpha3ViIEtpY2luc2tpIHdyb3RlOg0K
PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIE1vbiwgNyBPY3Qg
MjAyNCAwNzo1MTozNiArMDAwMCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWljcm9jaGlwLmNvbQ0K
PiB3cm90ZToNCj4+IE9uIDA1LzEwLzI0IDEyOjIwIGFtLCBKYWt1YiBLaWNpbnNraSB3cm90ZToN
Cj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IE9uIFR1ZSwg
MSBPY3QgMjAyNCAxODowNzoyOSArMDUzMCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+
Pj4+ICsgICAgIGNmZ19yZXN1bHRzWzBdID0gRklFTERfUFJFUChHRU5NQVNLKDE1LCAxMCksICg5
ICsgb2Zmc2V0c1swXSkgJiAweDNGKSB8DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgRklF
TERfUFJFUChHRU5NQVNLKDE1LCA0KSwgKDE0ICsgb2Zmc2V0c1swXSkgJiAweDNGKSB8DQo+Pj4+
ICsgICAgICAgICAgICAgICAgICAgICAgMHgwMzsNCj4+Pj4gKyAgICAgY2ZnX3Jlc3VsdHNbMV0g
PSBGSUVMRF9QUkVQKEdFTk1BU0soMTUsIDEwKSwgKDQwICsgb2Zmc2V0c1sxXSkgJiAweDNGKTsN
Cj4+Pg0KPj4+IEl0J3MgcmVhbGx5IHN0cmFuZ2UgdG8gT1IgdG9nZXRoZXIgRklFTERfUFJFUCgp
cyB3aXRoIG92ZXJsYXBwaW5nDQo+Pj4gZmllbGRzLiBXaGF0J3MgZ29pbmcgb24gaGVyZT8gMTU6
MTAgYW5kIDE1OjQgcmFuZ2VzIG92ZXJsYXAsIHRoZW4NCj4+PiB0aGVyZSBpcyAweDMgaGFyZGNv
ZGVkLCB3aXRoIG5vIGZpZWxkcyBzaXplIGRlZmluaXRpb24uDQo+PiBUaGlzIGNhbGN1bGF0aW9u
IGhhcyBiZWVuIGltcGxlbWVudGVkIGJhc2VkIG9uIHRoZSBsb2dpYyBwcm92aWRlZCBpbiB0aGUN
Cj4+IGNvbmZpZ3VyYXRpb24gYXBwbGljYXRpb24gbm90ZSAoQU4xNzYwKSByZWxlYXNlZCB3aXRo
IHRoZSBwcm9kdWN0Lg0KPj4gUGxlYXNlIHJlZmVyIHRoZSBsaW5rIFsxXSBiZWxvdyBmb3IgbW9y
ZSBpbmZvLg0KPj4NCj4+IEFzIG1lbnRpb25lZCBpbiB0aGUgQU4xNzYwIGRvY3VtZW50LCAiaXQg
cHJvdmlkZXMgZ3VpZGFuY2Ugb24gaG93IHRvDQo+PiBjb25maWd1cmUgdGhlIExBTjg2NTAvMSBp
bnRlcm5hbCBQSFkgZm9yIG9wdGltYWwgcGVyZm9ybWFuY2UgaW4NCj4+IDEwQkFTRS1UMVMgbmV0
d29ya3MuIiBVbmZvcnR1bmF0ZWx5IHdlIGRvbid0IGhhdmUgYW55IG90aGVyIGluZm9ybWF0aW9u
DQo+PiBvbiB0aG9zZSBlYWNoIGFuZCBldmVyeSBwYXJhbWV0ZXJzIGFuZCBjb25zdGFudHMgdXNl
ZCBmb3IgdGhlDQo+PiBjYWxjdWxhdGlvbi4gVGhleSBhcmUgYWxsIGRlcml2ZWQgYnkgZGVzaWdu
IHRlYW0gdG8gYnJpbmcgdXAgdGhlIGRldmljZQ0KPj4gdG8gdGhlIG5vbWluYWwgc3RhdGUuDQo+
Pg0KPj4gSXQgaXMgYWxzbyBtZW50aW9uZWQgYXMsICJUaGUgZm9sbG93aW5nIHBhcmFtZXRlcnMg
bXVzdCBiZSBjYWxjdWxhdGVkDQo+PiBmcm9tIHRoZSBkZXZpY2UgY29uZmlndXJhdGlvbiBwYXJh
bWV0ZXJzIG1lbnRpb25lZCBhYm92ZSB0byB1c2UgZm9yIHRoZQ0KPj4gY29uZmlndXJhdGlvbiBv
ZiB0aGUgcmVnaXN0ZXJzLiINCj4+DQo+PiB1aW50MTYgY2ZncGFyYW0xID0gKHVpbnQxNikgKCgo
OSArIG9mZnNldDEpICYgMHgzRikgPDwgMTApIHwgKHVpbnQxNikNCj4+ICgoKDE0ICsgb2Zmc2V0
MSkgJiAweDNGKSA8PCA0KSB8IDB4MDMNCj4+IHVpbnQxNiBjZmdwYXJhbTIgPSAodWludDE2KSAo
KCg0MCArIG9mZnNldDIpICYgMHgzRikgPDwgMTApDQo+Pg0KPj4gVGhpcyBpcyB0aGUgcmVhc29u
IHdoeSB0aGUgYWJvdmUgbG9naWMgaGFzIGJlZW4gaW1wbGVtZW50ZWQuDQo+IA0KPiBJbiB0aGlz
IGNhc2UgdGhlIGNvZGUgc2hvdWxkIHNpbXBseSBiZToNCj4gDQo+ICAgICAgIGNmZ19yZXN1bHRz
WzBdID0gRklFTERfUFJFUChHRU5NQVNLKDE1LCAxMCksIDkgKyBvZmZzZXRzWzBdKSB8DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgRklFTERfUFJFUChHRU5NQVNLKDksIDQpLCAxNCArIG9mZnNl
dHNbMF0pIHwNCj4gDQo+IHRoZSBmaWVsZHMgYXJlIGNsZWFybHkgNmIgZWFjaC4gRklMRURfUFJF
UCgpIGFscmVhZHkgbWFza3MuDQpBaCBvaywgdGhhbmtzIGZvciB0aGUgaW5wdXQuIEkgd2lsbCB0
YWtlIGNhcmUgaW4gb3RoZXIgcGxhY2VzIGFzIHdlbGwuDQo+IA0KPj4+IENvdWxkIHlvdSBjbGFy
aWZ5IGFuZCBwcmVmZXJhYmx5IG5hbWUgYXMgbWFueSBvZiB0aGUgY29uc3RhbnRzDQo+Pj4gYXMg
cG9zc2libGU/DQo+PiBJIHdvdWxkIGxpa2UgdG8gZG8gdGhhdCBidXQgYXMgSSBtZW50aW9uZWQg
YWJvdmUgdGhlcmUgaXMgbm8gaW5mbyBvbg0KPj4gdGhvc2UgY29uc3RhbnRzIGluIHRoZSBhcHBs
aWNhdGlvbiBub3RlLg0KPj4+DQo+Pj4gQWxzbyB3aHkgYXJlIHlvdSBtYXNraW5nIHRoZSByZXN1
bHQgb2YgdGhlIHN1bSB3aXRoIDB4M2Y/DQo+Pj4gQ2FuIHRoZSByZXN1bHQgbm90IGZpdD8gSXMg
dGhhdCBzYWZlIG9yIHNob3VsZCB3ZSBlcnJvciBvdXQ/DQo+PiBIb3BlIHRoZSBhYm92ZSBpbmZv
IGNsYXJpZmllcyB0aGlzIGFzIHdlbGwuDQo+Pj4NCj4+Pj4gKyAgICAgICAgICAgICByZXQgJj0g
R0VOTUFTSyg0LCAwKTsNCj4+PiA/ICAgICAgICAgICAgICAgaWYgKHJldCAmIEJJVCg0KSkNCj4+
Pg0KPj4+IEdFTk1BU0soKSBpcyBuaWNlIGJ1dCBuYW1pbmcgdGhlIGZpZWxkcyB3b3VsZCBiZSBl
dmVuIG5pY2VyLi4NCj4+PiBXaGF0J3MgMzowLCB3aGF0J3MgNDo0ID8NCj4+IEFzIHBlciB0aGUg
aW5mb3JtYXRpb24gcHJvdmlkZWQgaW4gdGhlIGFwcGxpY2F0aW9uIG5vdGUsIHRoZSBvZmZzZXQN
Cj4+IHZhbHVlIGV4cGVjdGVkIHJhbmdlIGlzIGZyb20gLTUgdG8gMTUuIE9mZnNldHMgYXJlIHN0
b3JlZCBhcyBzaWduZWQNCj4+IDUtYml0IHZhbHVlcyBpbiB0aGUgYWRkcmVzc2VzIDB4MDQgYW5k
IDB4MDguIFNvIDB4MUYgaXMgdXNlZCB0byBtYXNrIHRoZQ0KPj4gNS1iaXQgdmFsdWUgYW5kIGlm
IHRoZSA0dGggYml0IGlzIHNldCB0aGVuIHRoZSB2YWx1ZSBmcm9tIDI3IHRvIDMxIHdpbGwNCj4+
IGJlIGNvbnNpZGVyZWQgYXMgLXZlIHZhbHVlIGZyb20gLTUgdG8gLTEuDQo+Pg0KPj4gSSB0aGlu
ayBhZGRpbmcgdGhlIGFib3ZlIGNvbW1lbnQgaW4gdGhlIGFib3ZlIGNvZGUgc25pcHBldCB3aWxs
IGNsYXJpZnkNCj4+IHRoZSBuZWVkLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IE9oIHllcywg
YSBjb21tZW50LCBlLmcuIC8qIDUtYml0IHNpZ25lZCB2YWx1ZSwgc2lnbiBleHRlbmQgKi8NCj4g
d291bGQgaGVscCBhIGxvdCwgdGhhbmtzIQ0KU3VyZSwgSSB3aWxsIGFkZCB0aGlzIGNvbW1lbnQg
aW4gdGhlIGNvZGUgc25pcHBldC4gVGhhbmtzLg0KDQpCZXN0IHJlZ2FyZHMsDQpQYXJ0aGliYW4g
Vg0KDQo=

