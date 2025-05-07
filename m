Return-Path: <netdev+bounces-188539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3688EAAD446
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 05:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328FB1B67BC2
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2361C5F13;
	Wed,  7 May 2025 03:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I2vDHcBB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C31A0BF1;
	Wed,  7 May 2025 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746590283; cv=fail; b=oy6Iao8OveZ7plQ58XBJDN3Iy7DjlyM/ty7FY0lTUwVmgppdAWRQO7zxXcFtjiDMVvDjD7Y+e/dUHBeA6iZfWBzy9BRRRsPz0WiJAIlZhrnnwZZSZ/bIUETx23DLPA7Yz/JE16UWNGmwMyogrHuiGHwLIvmokA0+2X5zN/EPnXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746590283; c=relaxed/simple;
	bh=ASz/VmfkmRgOydNeLbsbx1AxoRywM2XjWEzQaU0H3+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JCXPfZRsSIk7gd6W3HxwGUxXRvSzkm4ohuTFD5SfOBNJzj/xucHBRMwaXUL/PhCIxUlfMI/46fn0FrJE921HGYnig/uHD32K1VIHCIIwicxkQ/BXxQNBsGbjFOuEc8YhOlhwRdpefGC+vC3XNUWmuddRyW15wC0324q5vfF/9Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I2vDHcBB; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3DntsjlnyE0KEUDkhzDC8matGvPDGuoD7wZx5/mdCAdMDv6FWwAAw07HYI4z4jeOt9z75BXiixDAx6HDzFbi3a8YPjMluB1ra3zFTGgYjTVlkKxCVMlWaDBChMYioXroxgBoHhzV2pzeYP4zBAyeBu9uMcyYiyleVJWaSw12CIpHy9tf4rAIU5+eb4D09qbKcGFyskjuFZdqARgxvYrucN9V0xLG/JQAU0bCXIRRhoWDBTZJ0OnEbMVsIjNTDhzCuaVaEEL8bEUiNnPug2mHDc/HL+isa7gzc6z7qB5WRkoiBXMh7XVmoH3i4VTd+BUhpMpZf87atM+vLdyDEImDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASz/VmfkmRgOydNeLbsbx1AxoRywM2XjWEzQaU0H3+s=;
 b=WrMUmtihnz9nrc7PNky7nMXCZpMygmvmFgnaF1TKbT5jpVXL2IYvazVi8zLRspOzDgw5TQ2O+RWqLjJbqS2lR2maWAjgVYZRt1Y8iosZT3HjMJN42ea8b1wY+bbKs0e2E35RYX/1zTczXkWjZdxYbCRGN1fO4ZZ+mSv+ONqsh783scviMN/xVbcuUYybDcgLz/IOIamV0mX27PpFej5sdFQwt/UnT0scQz70kjLfVLSLO686leWYdV5wJW76fFu6KAA/5RmrqtMwqHsTPyf5pg4ZtUQl81sJkS5md0jneO7/35A4DKZ2SwYtqI8ODRbYFVgWKR1ZtK67ddKkPqKnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASz/VmfkmRgOydNeLbsbx1AxoRywM2XjWEzQaU0H3+s=;
 b=I2vDHcBBW0qwbYFUs8nDDqvNyoLlivUKEbUR5DJzJuRIm/YMidNTN+WfU1o6mwoxhVesld1/S7C8Nf3FsGTbmpI/nB88A05ygHc6H1xx1WbaVEAzmCWj5ZXxTvLpU8nRaU1MnF7j6YYfr8nCRgYaCd+hQPUQ+FGj+LFlJOYo/5z37gSER5k4QRRCNEHNDK3uVv3nSghvmogr6I4KP0eaaSXIqPBjaHKlU7uyb+VUAWyi3CucNQzbe3w/0H7qoWEH3b9HN6H4p6ed/HKbCNxaJZI0x64l9/mC9hWzvSPWMZoewnkzyankb90SYx6jjzutj39HkO88diSCpGctpohjHQ==
Received: from DM6PR11MB3209.namprd11.prod.outlook.com (2603:10b6:5:55::29) by
 DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 03:57:55 +0000
Received: from DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924]) by DM6PR11MB3209.namprd11.prod.outlook.com
 ([fe80::18d6:e93a:24e4:7924%3]) with mapi id 15.20.8699.012; Wed, 7 May 2025
 03:57:55 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 2/7] net: usb: lan78xx: remove explicit check
 for missing PHY driver
Thread-Topic: [PATCH net-next v8 2/7] net: usb: lan78xx: remove explicit check
 for missing PHY driver
Thread-Index: AQHbvwQh4XVa7hsS2kmjSFIOFyr1J7PGiVUA
Date: Wed, 7 May 2025 03:57:54 +0000
Message-ID: <33ddfd32a5566f4990ded4334282df723e88a77b.camel@microchip.com>
References: <20250505084341.824165-1-o.rempel@pengutronix.de>
	 <20250505084341.824165-3-o.rempel@pengutronix.de>
In-Reply-To: <20250505084341.824165-3-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3209:EE_|DS4PPF0BAC23327:EE_
x-ms-office365-filtering-correlation-id: 6e9b9ca3-e729-4409-3426-08dd8d1b58d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SlRDenAzWElBZE9HdEExSVk2SlFHOTV0S1Q1enczUmZqY0lXRjY2cHZkYnd2?=
 =?utf-8?B?aEllMVhlLy81Ukt1QVMzMld6aWNEOCtPUGRMT2s2aXFpckJUUmVxYzlLVVVC?=
 =?utf-8?B?ZUZKYk5VKzRabXgvbGpiZGxMZjl4Ujc1d2JjdC9KK0lnK01CdW1kdlNRbU5R?=
 =?utf-8?B?b0ZuTmRYVmNYWWE5eTdLWWdPLzBnNXhmY3JqNllEeHJCa0NaY1F5Tk05aDNN?=
 =?utf-8?B?bzBqR2tyNnMyOTFoUmF0TXVQU3V2QnhUYzNXYm5qQ3N3a2pKbjU1bmRHb2Zs?=
 =?utf-8?B?bmM1eXJqU2drR1FmU3UrRmZTZkVBSzNORk9wdE1pVmRoM0ptekQ2TzNENWp3?=
 =?utf-8?B?Q3cvdFRKMXZUbGdxRmU2eVlNaGt4Q09QQmtJdTZMMk5GNTF1SW80cUVjeE1G?=
 =?utf-8?B?elk3U2N1b3dpNkNTdVVXSWMveGJKZnR3SC9idDhaZFo3a0N5dmRuK1Y4Ym9C?=
 =?utf-8?B?d3g4R3VGRW45WXJSdE9PQ250RENMRTdVSW9FK3FJV2FWUnRVVWJBbm9UQytQ?=
 =?utf-8?B?R1NaN0o5Sm15ZXNDVXpxekRPVXh6bnRsV0h2TnVrYkJlVVUydVI3enlGN2FH?=
 =?utf-8?B?M3paOGo5MHNvenBLQkxUanpxR291ckh0VnBra3pNQ2RpVzFTWHFDTzVJTEFX?=
 =?utf-8?B?NGxHY3Jqa3ZYY2pobTVPc1F1Wkt6ZlB1TFIwcFNwbkZhT2FBdis1ZWFvcHpN?=
 =?utf-8?B?NWQwSWtLS2d4RzVpSTIwMHVMK3VFZHU0em1IQjFNODJIU3lqMnNha2hBWWZU?=
 =?utf-8?B?Mjh0OU9DM093c01wNHpZcTRiRU44UWNrSDB3eHR2aG9HS2d0alBvdzlDenox?=
 =?utf-8?B?V3NPSEtjZ204S3ZIcm9FSEVuK1hOT21QWmI5N3BlcHR4Tk5WQkJmVmU2REJI?=
 =?utf-8?B?MzNnSnM1WnFwbFpqeklIZmhTdUhiM0daRkFHT0xqbE1oa2NHa2dsWnRoTWM4?=
 =?utf-8?B?OHpqTGFlYmgwWG9wY3JITWFGMlNrSlc1Yi9kVXBwcEJlZG4wL0RvcnREZjBU?=
 =?utf-8?B?MHNVdzR5K3MxTmRpWnFFeGJsalJXOFJIY04yYUNaWTZ3WnpuVlhrR0hFcjZ6?=
 =?utf-8?B?R09oZjdlTHgvRmpBMXFNVHpqUm5Jb2lhTkhMckZrUmFhRWozRkF4cG1zSGMw?=
 =?utf-8?B?MXJuT2gza2QxRHpoQnM3djVOMzFYNi9QYUtZTTlLR0N2U0lFdURIYXF1d0Ri?=
 =?utf-8?B?aXFySlp4a0V4UDBVc0FvbWVDNGJBTzZ0Z1NvYWZha1pmMmVDRHA4UGY4MVBa?=
 =?utf-8?B?TjRid3g5UTNDQTk5SEJqRnluTkNRU21UTGQxR0Rjbmtvd3VoZm1vMklhekh1?=
 =?utf-8?B?NmVZQ3BaOGNWWWRMLzVGRlZ0ZHJUMkp0bnp2WG1NeC9wdWR5WWdkNm1yTnhq?=
 =?utf-8?B?K2FCN2xVd05uWjdja2M0QWVaRllrTkd6N2V3cFc0TlJ0V1RRQ2tQeXVqYUJU?=
 =?utf-8?B?U3h3Z1BmVUowOVBSWVl6Q0RGY0ovZ1ROMXJkSjcyc3FjWG5RNFNqZ3lvYVR3?=
 =?utf-8?B?ZUxCNjNwZUV5c1p0eEZJMUFZS2VRdTVLZ0p2dXNJYlU0RFVORjM4SElRdkVG?=
 =?utf-8?B?OW16T2llMzdFUTdQbFF2aWgrUW0vM04wTWt1WFpzSk9YT0xQQlNvR0VyOFRv?=
 =?utf-8?B?Z2dEMHUwYXNkemRCVzNBZGg0YW1uZStBaW5VY3NvU3VMUzBHMWRXbFc0RWJX?=
 =?utf-8?B?KzJMRExSZ3B3eThZbWhCbTlkOVp4UDNUaHhvcVdUT1RRekNVd0FHcGk1eGps?=
 =?utf-8?B?YWVKbkJjZWpSSXE5QkRVZHZTVE1NMlpyWGtIMDZwT0xJQXFVTzdQNGZNSlBZ?=
 =?utf-8?B?dzlCbDZHZjJIdG1zNmdDSUI2TVJPOFMrQUdqTFgwYWRDcmxUVWZGMFRQbUtH?=
 =?utf-8?B?eWlQeDVmVy96SmRNOFJTWEU0T2VsdVlVeUpaMjlicHFhTy9CQTRXUHh4RElm?=
 =?utf-8?B?TERuRGd0VGcxL3RneE5SVHI0T1pWNURuSFBBY0VPcGkyWlViM3piL1kxQXNv?=
 =?utf-8?Q?N3UfpaZnsMn3AwRmDtlznkXIp7gC4A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3209.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TTZKcmhycEJSU3hiNmtqWEYvZW9SRTY0YVhxeWltQWhLQklocjY5NlpkOG5j?=
 =?utf-8?B?TW1FUm1QazY4STlQM2ZyRHFTczhtYjhKUW5nWW1nOUdseXR5a3pRUzh2Yzlu?=
 =?utf-8?B?ekVvYVpYTEZURFc4ZytEOStWQzBCQ042OTU2Rm5JVWRmam1hQ0QrM3RPNjBX?=
 =?utf-8?B?VGxuODVnZjFNUnlmU3JRQ0k0amlvYmp3ZDVxOGVrOFIreU4ydm5pbTZKa3Bq?=
 =?utf-8?B?SG1KclRFQUNFQjExUEpuRUZtMTgyUUJyQWFCaEZGY1lzOEZqTlROdll2Sm9i?=
 =?utf-8?B?Z2NtRWdOTVkzVm1Hd1duY3hndDBEZk1JQzVYenh4OHFrQXVOb00yV1RDVXVT?=
 =?utf-8?B?OFFkSTdXNGZ5K29PRkc2M21reTFqQi9qc0RhNVBYdi9ScXFKbnZCNDR6TGV0?=
 =?utf-8?B?eTVjOFZ3SFZRY1V4SFFJV0FpalExcVR5YWV1S2RERWJvbFlnSC9vd0o3NzZJ?=
 =?utf-8?B?NkZFUlR5R2N2TTZQOFRoeGJhSDZDSi9FaE5jWExXZU1sVktQdkZLdDFYVDho?=
 =?utf-8?B?eWVLeFJadHI2YktFVGF0anQ2L3h0T0UyZkQ1eUhXdjd5L05pTFloNWJBL1JK?=
 =?utf-8?B?OEpFRG5vbHBuQklqRnhUR2F4SXQwOVFwNitKdHFFMUpReStZTS9kR3E0M0Nz?=
 =?utf-8?B?NjlSY3B2M1VBZ1cydFZKdWVxMXdLWXUvditsMk91M3REUmpOOFg4WmpmVmkr?=
 =?utf-8?B?VmFod05hN1dVM3dvNGEyL2JxVS9UVkh1NFFQdVFKTUdIUE1yZm1VSlV4Y3lY?=
 =?utf-8?B?K3E1ekJ0WUw4WU9XQkMzY3loNjg2L05mSzU0bktUMk9OMncydW5qZWdxT3d2?=
 =?utf-8?B?cnVQcGxlZ1JSL1M1NWVpZVpVODFWdG9IdGtMSmU5aVBlYXZVZFJ4cTMwYk1k?=
 =?utf-8?B?clF2WDE1WmZJOW9Eb3NyYUJxekdGYXk4ejhkSG5VeEV4a2NMbmNIMFdBWC84?=
 =?utf-8?B?Q1BJZVc0Qk1PbUZIOVIxOEkrN3FCS093RWtRZ0JIV3NGRFQrSUFUeE1sbDkr?=
 =?utf-8?B?SldpVTRZRlNsR29lQUtreGJNWG5odW01d0ErckhSOEd6K0J1YkthNkdCVHJY?=
 =?utf-8?B?eDVWbHdkMWNDY0NOYWt2aW9PNWtRSHFNTnozdlVsdW02SmpuMzNWdlptT0F2?=
 =?utf-8?B?VVJTUytuT1dVLzFsTGtWY0J5OXN0dytPZmRULytxaDlmQmpEOG5RRTJxdGZD?=
 =?utf-8?B?OGJkV1FtdlB6RlZuK09haE1sTUdCSUx0RkpGNTVnVDFtUDBwRjA4WWE1bjUr?=
 =?utf-8?B?YjlyTWxiT3EzS2VEeHdnTmgzSzVCQVJ1bkd6L1pKNTIzMHZIMnBKVXdJOG5W?=
 =?utf-8?B?TXVhc3ZwS01hYXdpUUErMjkvNFh6dThtTWRUZVNzZWJteGNGVXY3WnQwejVn?=
 =?utf-8?B?N2dzVEtqWWdrMXpvWUpoN2lJbXpXQVdPbUQ1Q3dTeEJoQkFYTVlEbE1iVys3?=
 =?utf-8?B?OElIalZqck90amZkRUFBYlJOR2d3aVNySFNSbHBmQ1JpZ05nVWQyb0xXbWRJ?=
 =?utf-8?B?VmZZbVp3SmxDdWNnNDAzZVIyZ0JrbWJmaGt6ZmFvMkx6alJTKzU2Z0VUL2dC?=
 =?utf-8?B?Sllja3RLMUZsQlhhMEk1SDJaeDA5MzluNVNCMC9YVTRwU29wUU5RRVRjTzVI?=
 =?utf-8?B?OHJ1MldvNXVVV3JxUTlmUVZPVzFFU0tqRlFtamN3ODRycnQzYm5OTEJEeTlQ?=
 =?utf-8?B?Z0grUjl2OFZuMGEzS3JJRFlSUjJienlacG1EcDFGQ3VnOHNYb2VOQjJjQ3lO?=
 =?utf-8?B?eTNqdllXbldkUmZGUzFQMG5ORFJJbGFEeW5QSmlWN2NwN0lQT1dER0czMENz?=
 =?utf-8?B?VmFmYko5eGliUEJQeHA4QldxVWl1WGp4RXdHUk85Z1NWUlczcG9NZmRiUDE2?=
 =?utf-8?B?YmhhSFpEOGhYaldlUWwrMURhSUFMV1dvVzFYTVQ1K2VEc1hyUlk2VDB6ZndL?=
 =?utf-8?B?TWhFVWtDSFp4WG1CeURsUFRkOE0va0YrSTdFdGZONDlCU0p0SEF6cUNMb1d2?=
 =?utf-8?B?TnZpK1dXR01IWithSG0vQ3FaZUxTbGJlL1h4cVFyeWFOS1RhYkFnKzd5ZmVT?=
 =?utf-8?B?aHVxa1o2d1BDaGc3eVZseG9reWd2YVRacWxzSXUzeXBab3Jkc0hTT2JOcHRh?=
 =?utf-8?B?SFpXZlZMM2VXUit4UHBJL3Q4cFRSK2x1ZmRBL0hGRG5lRno3dXFiUXVpUm1z?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98613B116143B14DBB8B2FDEBE2895F5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3209.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9b9ca3-e729-4409-3426-08dd8d1b58d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 03:57:54.9705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jai2gnM57gbGSmpQgEeYZKXByfKvE2sEKxoQfbQ28jydKd1q1pvpS9Ho4FLBFR92JLVIvMTfXe1AcaJy3nGBHYE3Shk/mJzFfCZLtBOcLG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0BAC23327

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDEwOjQzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBSR01JSSB0aW1p
bmcgY29ycmVjdG5lc3MgcmVsaWVzIG9uIHRoZSBQSFkgcHJvdmlkaW5nIGludGVybmFsIGRlbGF5
cy4NCj4gVGhpcyBpcyB0eXBpY2FsbHkgZW5zdXJlZCB2aWEgUEhZIGRyaXZlciwgc3RyYXAgcGlu
cywgb3IgUENCIGxheW91dC4NCj4gDQo+IEV4cGxpY2l0bHkgY2hlY2tpbmcgZm9yIGEgUEhZIGRy
aXZlciBoZXJlIGlzIHVubmVjZXNzYXJ5IGFuZCBub24tDQo+IHN0YW5kYXJkLg0KPiBUaGlzIGxv
Z2ljIGFwcGxpZXMgdG8gYWxsIE1BQ3MsIG5vdCBqdXN0IExBTjc4eHgsIGFuZCBzaG91bGQgYmUg
bGVmdA0KPiB0bw0KPiBwaHlsaWIsIHBoeWxpbmssIG9yIHBsYXRmb3JtIGNvbmZpZ3VyYXRpb24u
DQo+IA0KPiBEcm9wIHRoZSBjaGVjayBhbmQgcmVseSBvbiBzdGFuZGFyZCBzdWJzeXN0ZW0gYmVo
YXZpb3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVu
Z3V0cm9uaXguZGU+DQo+IA0KUmV2aWV3ZWQtYnk6IFRoYW5nYXJhaiBTYW15bmF0aGFuIDx0aGFu
Z2FyYWouc0BtaWNyb2NoaXAuY29tPg0K

