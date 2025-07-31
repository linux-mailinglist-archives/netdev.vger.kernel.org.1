Return-Path: <netdev+bounces-211266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AB8B176B2
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 21:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDFC1C26C98
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B297D230BC9;
	Thu, 31 Jul 2025 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="0/aw2tm1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2121.outbound.protection.outlook.com [40.107.93.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DA376;
	Thu, 31 Jul 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990560; cv=fail; b=WJmw/dBWAC20j2A5X4aAljdFkAdZvIHvga6Xdg4+Ey+RCds5xE+T41xQncakccx1onYIsAc6tjJffY624YKw28piKWQfJBUHB3mZQHMVdt2uBD6u28X88yKTQlXTKnThhZDSPiXbFkf6VBfn8XbZHdCkHqLkNTv/QU2zhl45P2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990560; c=relaxed/simple;
	bh=2gkoQ1vMK5U+6rnqNw5vkiON8Vj8j/p6h0oXb3N+ohE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EYqU7teC7NieGbG6rOfrCUiJRSVW9Uaavyyt5Qpu/UZ4HUJrTpTMkTiXaEJsZfwWpPBavZ21sqhcRndfchuRBtPyx3c7yfvKRkby8R4ldsyhfSi9ojhgCItJWscQUTwf0CLd1Pgu1n92pQWoj4qOaPhHk2A7FDc6+UwYvspRCnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=0/aw2tm1 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.93.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToI9/qeohTYek/4thxwWcwrpneGIIpaqG59qKEgTluFy0Ugd1UPN++6GF2+gR+GmCtW+aPLTC25tkyWNyu5qaeO2ngKPAgGn+rQmdXzdRbLU+sGBW7OXrb2Gzvvm9FMRDMi9ims2v3yjeF8ZnWM7VNkZNtW7eR85JQcK82hhmI4ncEhPQlmDCGKmOQOIOfDV/BsFxSJ9a/8VHE7TE+i23tQ6okowc9n6h4z01qR0X1pj6olFaqVzNV9RJOyyLrrhL/4pnlsUxqHMP9k81ZfvNG2PEj7ljxecUi697OxkVX5iYoSJejQxEUGZTTHP/ioudcHggQMlgTNnPcqhlm7ejQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYddEtAipMaMjCV23/dRWBtJqo9wU5nEi4zP576LGOo=;
 b=IAtu3GTQzryYSywtA/3FZqikDDpAedixN2sjQpCmaut5g1gROIy9LGFGyufnmW4+UbpJQytxp389DzSwZN9UgE4D+0jLjsg2K2shcKCYAbcQW5+QrDLw3fJ+ZmH4Zo3DtrYH9z26qAnM1hC+lJQmP6u8fKzFcxsN06jrOAt5vT/Mg0TItF+rv8gvKmSuMu742tsX92foFATc9ZbRC6UPWT4dJxVBgBRU7r1zixY41cmYAulUE8x44jMKOFGwQCDjZkW7zlsS0OJD27zxvx3cXMuaw6FsVrBWc3rhehWXDPttAZxqBbGn2FwBcLnWYsWP1343hZSzXzpsPVnACEiPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYddEtAipMaMjCV23/dRWBtJqo9wU5nEi4zP576LGOo=;
 b=0/aw2tm11gzha56NIJMCXLnhizTJBkvGZRrBAuIZNywAHl0KFuEkwyZoLhAolS3kqXOhNpPlWtaze6+LAGbB7OTEeLLLP4/xE4F0jVSxdUnxjOfbxb5IaWaoOQjGCrM9YvSEJrtlt6DqEhl14I9O/8a9AdrmDQL6GscycH3yeWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 CH3PR01MB8664.prod.exchangelabs.com (2603:10b6:610:1ba::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.14; Thu, 31 Jul 2025 19:35:55 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 19:35:54 +0000
Message-ID: <d8ac05a9-9229-49a4-b7f2-8d92060ccc63@amperemail.onmicrosoft.com>
Date: Thu, 31 Jul 2025 15:35:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 1/2] mailbox/pcc: support mailbox management of the
 shared buffer
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250715001011.90534-1-admiyo@os.amperecomputing.com>
 <20250715001011.90534-2-admiyo@os.amperecomputing.com>
 <bb544194-d8af-4086-b569-4a4b4befd6ad@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <bb544194-d8af-4086-b569-4a4b4befd6ad@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::33) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|CH3PR01MB8664:EE_
X-MS-Office365-Filtering-Correlation-Id: eb6051bb-b12e-425d-cd71-08ddd069771f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEZqejJpM3BjWTNwVXdvd2hKR3YxYUp2Y0FPandycUkzUVF0d29IRkhXS3Bl?=
 =?utf-8?B?MjQrekt6UEtWNk1lTVVPcEhtM1pvOXNudVg3cm9XRWYyc3hXRXg2eDFKUjRQ?=
 =?utf-8?B?emluMzM0eGUycTl5aUhrVzhIcGRJZFZaTTBpOWxBeU9URW0ydUpLT0YwMlNN?=
 =?utf-8?B?clloK2J6dnhHaTh4dU1XTW1xdFYxSkRtckZ4ekxLVE5KaEo4UXlqa0RrZEVn?=
 =?utf-8?B?bU1hOXhmK2lEa2t0NWNPT3NVd3pTS296VVdxZDNUY0lKRHlJU056K282K3U1?=
 =?utf-8?B?bVZYMkxCSFBVTll5RDZXb3NsVEQvQ3o3ZXFpZWVZeEVyN2s0Ym1ValRLeXh0?=
 =?utf-8?B?bnJGREZUL1U5R2FHaEtTSisySVpyZkZuQXF1L2RNcjFqM2sxdnd4enlJYXg2?=
 =?utf-8?B?OGpEdnZ4UVMzYVJ6RTFHNFdjVzBrdm95N21XY2pseU1Qdjd2SlI1ZVdPZDIy?=
 =?utf-8?B?blAzWG9RR2tHSEJHek1zRFk2dTFIZ3VORU54eUFHUFhhMWEzcUEyU2ZqdjR4?=
 =?utf-8?B?UXpYTmE5RTdyK3R2KzUrSGJZY0VBVTdKckcyeFB3d1VSRU9pdVI1SGNCZysy?=
 =?utf-8?B?S3NzSGdUZE9BRWREQnFOTTZ4OWxBaXR2Ny9oaG9XUm1iS1BBTEFielRPMi81?=
 =?utf-8?B?VXpBTXdPdklPRmFUYnVDVGpnMDNITnpTbTY0SU5kdmZVVm5hdHFaV0U4azJP?=
 =?utf-8?B?dHNwVnp2a1Y0NXhDSXM0TVFJL2lWT2RrTnE5enUrVUdFUU96SUpBYkNISU02?=
 =?utf-8?B?c1g0dCtGbDhkZk5PK2pWNjIwUWQyTkNVZ1pTM0NCU21ZbmJXdTdvT0U4c1VE?=
 =?utf-8?B?RGFlRG91WmdOc29FOWlJc3liR2UxSFlYalFUZ1Vhbm43L0hFdVdpNGF0dlA0?=
 =?utf-8?B?akpLUUpiOW1NL21XWkVIckJNOHlCVWRnZ093Wk0vLzh3RmRSdlV1MHppZHhZ?=
 =?utf-8?B?ZmVwcU5FcGdkblhHcU1qdUtueHdPaWQ1VEhleXl2RWUwZW9xeDB2ZzRiVUtr?=
 =?utf-8?B?ZENiYWJVR2ZQbGpleFlUY1h4WFdNU1RLaDNXV2lwaUlBN0JYbVFWdnJnbmVk?=
 =?utf-8?B?Y1pKc2h2L3IxUE1PaGRaM2JneWJ1Z0NmUkE0dGhuZlYybVJwMURRVmNDUVNI?=
 =?utf-8?B?U2xSb0RoaHdaK0pHV2xPakV5Q2haQUdnR1pZWFVsalc3enVBQWsxOTlYY09p?=
 =?utf-8?B?d3NWVUxFRCthNWg3UDZHTi8za3JGYW5sNzlCdzlyaXNzT2l1Q3JIWjZhTG9x?=
 =?utf-8?B?WEJ2c1NNNG03NXNETTg4RVRSL29uWlkrZC9PTmprclpWaXVqSW1oTUxSWFR4?=
 =?utf-8?B?Tml2cmczZXNhZk9ndklwaENGaUsyV2xmSmF0U1ZmbTREd0dvSk1Jdk1FSFRG?=
 =?utf-8?B?V3YxaFZTNVlacS9OSmVSWGFWTHFsbU12T3JHQ2JNdjQ4UWFqVzJwQW54YWVW?=
 =?utf-8?B?cEdOMy9LL0lhRVJKSS9CQTdJK2dMYk12WUhNM2I5c2tWMUNHeVc5SVpXUnNy?=
 =?utf-8?B?VitsUG54N2thYmwzWTRPcVBzeHM1K0RxdXhreVJYTUtwTmcvTnlocmRxbnZN?=
 =?utf-8?B?VktjaWFhV0QrT1RMOGJndE5UVHEzNkRoVXVDVHZGbTdmcGN0aCs3TXJ1Mlpo?=
 =?utf-8?B?Y3BGbk1kZzg1enBBSWdLcTJXMUxiWENsUEUyTUJhZXYwNktoT1pMejVHRWJZ?=
 =?utf-8?B?Sy80Q3dWejl4cTNxOUpwQ0crYkN5ZHViWkdlZmxnZWMwdnpzZ2tWUi90cEdC?=
 =?utf-8?B?cjhCSWhpVnhoNk1WUVUzckJJV29hQW0xckJ2bnIrUGVDSVAwYW44UEhrSXRn?=
 =?utf-8?B?TXJneUpRRCtZWFJrUEhNeW1jRzFzWUpnQkgrU2xXVWZUSzZNajdSNFZ2QU0x?=
 =?utf-8?B?YUZIUC9naCsxUDMxTnZDRDdqc2JUM2lJSEs2ZVBpTFRIU25kcGZISnM3Wnpr?=
 =?utf-8?Q?eM5SeuSN/y4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWRwYm5Kc3NvdjdLSHRUdEM5bjdRWC81NGIyTTFvS0x3T2FpeTgvMkRoQm9X?=
 =?utf-8?B?SUtUNWJybFY3UEFaQ2hSbjlpckZvTkZzTUJlazBUN3ZIVnJ0K1RlTXRZeUZJ?=
 =?utf-8?B?SFI0MEIrdzF0eDFGTlZreWRMeSt4djBWVTVicWxpM1FaQUtwOUl2SjgxRm05?=
 =?utf-8?B?d0lvSjVpR01rSEFzZ1NIQXh3KzBGWVpqd04vYXFlQkdmQU9IVVlKMmQvdlh1?=
 =?utf-8?B?TlNQNWtpUnJlWS94QVR2N2JhN2creVVMK3lJMDFzRnB5aU9ScitGWjdGck9t?=
 =?utf-8?B?ZnM5VWJsYXRFNnJOMi9hRjhPQjd6ODdubmovN0J5R2Z4VHY1dlJUQ3VMVzBu?=
 =?utf-8?B?ZU15Z1BoSDluWXlXVTNUMXdXWGFRTXFMdjdWMHlTU2xkSVphaFZFaGNIR04v?=
 =?utf-8?B?dnlXSmxEMktmbit2OHJvaVRJRE5IbDJPWWRySitEWXBmK1lBYjY5YUJ1NzRR?=
 =?utf-8?B?M3NROS9xaE9uZ2xTR2hNR0ZCR016ejdiVXVRRmRPdDRmZFFlSURSR2ZmaE4r?=
 =?utf-8?B?TllQQjUzenhqT3FXSmhJdExObTJldk1KWGZ5NHBXWVB5NmZEOWhTSTdDMk5C?=
 =?utf-8?B?V2NkWnIxY1FlbHU2QjYvRHFBZTcvVTdiWVVYcWZRSFlLY1NibFdXTzkxc285?=
 =?utf-8?B?dmIrRHhMMmhOOTNpQ205SUY2UWtLUFZSdWkwVjlnTVZqOXRWQVVmTUpVOGpD?=
 =?utf-8?B?d0s2bG5RbHZXektRN0NmTVlveGpuT3lBS2grVkg0UnRZVFptN3RyNmU0a1Bp?=
 =?utf-8?B?QXV2NENqbFgzUStmK21GV2lsTk1Bcm0vTGJnSkxJRlpSYW00eDJwenMrWkhN?=
 =?utf-8?B?b1ZBVHdDWVl3czJVUlJJZTdkckdrY2hydmhHRUdBNTdHTDdNamFSWkpZKzBq?=
 =?utf-8?B?M3doVkV3SjBhTVBpd2JQcWNUbnNFTUh2SUV5dEdnc1NsYlc2NWJjVkcyR2Nt?=
 =?utf-8?B?MVNKTmFCSmNGeDI3TDFJY1VwVVFhSHJDYUlhV1E1MmxyeHBXYWtYZlBITWNm?=
 =?utf-8?B?U2twV3c1VG8yd0NOMDlxSEhPNGwxTlNTWWhtTDF1cnBvdVBzdWJTV05CMFNU?=
 =?utf-8?B?VW5PTTdENnVDK05haGZEWThmejN3VnRESHBPbGdNVzF4dFJsZDlYR2h1SkIx?=
 =?utf-8?B?M1RNOExpTkFYei92WUZ2UTlWVDR6dzBGVGxqYWQ4aW8yb1hiU2VBL3RBeGJ0?=
 =?utf-8?B?eXIwZE1WVFloZ2dkazJQK0N0aUJFZTVZZXRTb0hta2dZbUpCeW0vSUx4VkxT?=
 =?utf-8?B?SzZQR1VTNkpqUjdkdElRZ2puOXdwOHVIakNmWmJySWJna1ZGT0NTVTA4U2h0?=
 =?utf-8?B?YnBJRjl0U2ZPUWg4b3ZnbGVPS1BxbS9DTkRKblJxTHdrQjJsKzR1M05HSjJs?=
 =?utf-8?B?em5PeDFWUENybXhjS3RwSmtPR3JrOVZXV2hteUhWMmpkbWM2a3I3VGdyMHBC?=
 =?utf-8?B?TjFZWXFCNjZTbEtpd294YUJ0bGFGQlhoVjZTQW9xK0x1WHBoQnhUR1VINlRy?=
 =?utf-8?B?cXJ2aGtkNzd1dmlNMFVwaUY4bWxnckMrUmc2TzlWQWp1L01vVldHNTFrUGhq?=
 =?utf-8?B?V3dVeG9kTWk1cllhVVVlanQxYkNwU0MzUHZIdHo1SnRQV1RFcDdlbVl5T25Y?=
 =?utf-8?B?WXJISi9kaHMyMkNTRVdrSjJmQ1FCUDFyeGNwQ1ZZcE1hOTJOTkZoR1VpVDAr?=
 =?utf-8?B?SEdQMXpDWUR0UXNFMnMwSzVUOTl0bWlTeUpDVWRpRjNvS09wMWNEK1NSQlpU?=
 =?utf-8?B?cUk0R1NLYjdxSyt3Y1lhOWMzRVdOamQzOEMyeGYyNWx2NHJ4ZWUyR2xuKytU?=
 =?utf-8?B?WGs3dmVtY01Qam5LZkFuUEZXbU9YMnNGbVg1T2RMOStyNzc3c0R3Zm90RExB?=
 =?utf-8?B?SzA5Uk92aDYxUFFVRmp3QVpVcmJKQVpSbElZUXpDdXMrQ1NURmJjbmJEMHVi?=
 =?utf-8?B?S0ttZllZbnVqQld2Z1VvOUYrbWJnTWNHZ0FURUlkZmxSNHRlWS9ZUFlURmhs?=
 =?utf-8?B?SWNSUEFraDErSVVmbTVMQXphZTIrSWNPM0ZJQlZKZm16UFFZclBrTktqVDBE?=
 =?utf-8?B?VzJZdDJMM3I0L1RXZTh1OWtPOGwrN2NkY0F1V3ZwUnU4cE1yVjh5OGMxMzR0?=
 =?utf-8?B?QnR3bG1OdGkrWHNrQm9ZcUlLOXhlTmZRWUxicGI2Nml2S2ZsdVdUdjFvRlhn?=
 =?utf-8?B?RU5sWjlDZ1U2TFZFTlh5UU5oVmRPbml3ZnNlemJ2TDk2aEg3TWhsWW84K1A1?=
 =?utf-8?Q?rR/0RZrXuBwb+0uoCtt8+Tz05AyVO8A/MqTjKGjX90=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6051bb-b12e-425d-cd71-08ddd069771f
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 19:35:54.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lggSUAXNroN1pc51ywYJWcc6hetbb0TPwC7YQ2kEqFATqSMPeDY5HOoKHEPRjRUeAL7mazMXAP52c6hONNY6pupjwzE1KnrO3c2Dzvx/W/0PLfwuvdgBRPIW5TEXDQHq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR01MB8664

Is there some reason that this patch is not showing up in the 
maintainers queues for review?

On 7/22/25 13:10, Adam Young wrote:
>
> On 7/14/25 20:10, admiyo@os.amperecomputing.com wrote:
>> From: Adam Young <admiyo@os.amperecomputing.com>
>>
>> Define a new, optional, callback that allows the driver to
>> specify how the return data buffer is allocated.  If that callback
>> is set,  mailbox/pcc.c is now responsible for reading from and
>> writing to the PCC shared buffer.
>>
>> This also allows for proper checks of the Commnand complete flag
>> between the PCC sender and receiver.
>>
>> For Type 4 channels, initialize the command complete flag prior
>> to accepting messages.
>>
>> Since the mailbox does not know what memory allocation scheme
>> to use for response messages, the client now has an optional
>> callback that allows it to allocate the buffer for a response
>> message.
>>
>> When an outbound message is written to the buffer, the mailbox
>> checks for the flag indicating the client wants an tx complete
>> notification via IRQ.  Upon receipt of the interrupt It will
>> pair it with the outgoing message. The expected use is to
>> free the kernel memory buffer for the previous outgoing message.
>>
>> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>
>> ---
>>   drivers/mailbox/pcc.c | 102 ++++++++++++++++++++++++++++++++++++++++--
>>   include/acpi/pcc.h    |  29 ++++++++++++
>>   2 files changed, 127 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index f6714c233f5a..0a00719b2482 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -306,6 +306,22 @@ static void pcc_chan_acknowledge(struct 
>> pcc_chan_info *pchan)
>>           pcc_chan_reg_read_modify_write(&pchan->db);
>>   }
>>   +static void *write_response(struct pcc_chan_info *pchan)
>> +{
>> +    struct pcc_header pcc_header;
>> +    void *buffer;
>> +    int data_len;
>> +
>> +    memcpy_fromio(&pcc_header, pchan->chan.shmem,
>> +              sizeof(pcc_header));
>> +    data_len = pcc_header.length - sizeof(u32) + sizeof(struct 
>> pcc_header);
>> +
>> +    buffer = pchan->chan.rx_alloc(pchan->chan.mchan->cl, data_len);
>> +    if (buffer != NULL)
>> +        memcpy_fromio(buffer, pchan->chan.shmem, data_len);
>> +    return buffer;
>> +}
>> +
>>   /**
>>    * pcc_mbox_irq - PCC mailbox interrupt handler
>>    * @irq:    interrupt number
>> @@ -317,6 +333,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>       struct pcc_chan_info *pchan;
>>       struct mbox_chan *chan = p;
>> +    struct pcc_header *pcc_header = chan->active_req;
>
> OK, so it looks a little strange to re-initialize this later. Would it 
> be better to not have it initialized?
>
>
>> +    void *handle = NULL;
>>         pchan = chan->con_priv;
>>   @@ -340,7 +358,17 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>        * required to avoid any possible race in updatation of this flag.
>>        */
>>       pchan->chan_in_use = false;
>> -    mbox_chan_received_data(chan, NULL);
>> +
>> +    if (pchan->chan.rx_alloc)
>> +        handle = write_response(pchan);
>> +
>> +    if (chan->active_req) {
>> +        pcc_header = chan->active_req;
>> +        if (pcc_header->flags & PCC_CMD_COMPLETION_NOTIFY)
>
> Note that this is the counterpoint to my earlier patch that only 
> notifies the platform if the platform requests it.  This is part of 
> the specification.
>
>> +            mbox_chan_txdone(chan, 0);
>> +    }
>> +
>> +    mbox_chan_received_data(chan, handle);
>>         pcc_chan_acknowledge(pchan);
>>   @@ -384,9 +412,24 @@ pcc_mbox_request_channel(struct mbox_client 
>> *cl, int subspace_id)
>>       pcc_mchan = &pchan->chan;
>>       pcc_mchan->shmem = acpi_os_ioremap(pcc_mchan->shmem_base_addr,
>>                          pcc_mchan->shmem_size);
>> -    if (pcc_mchan->shmem)
>> -        return pcc_mchan;
>> +    if (!pcc_mchan->shmem)
>> +        goto err;
>> +
>> +    pcc_mchan->manage_writes = false;
>> +
>> +    /* This indicates that the channel is ready to accept messages.
>> +     * This needs to happen after the channel has registered
>> +     * its callback. There is no access point to do that in
>> +     * the mailbox API. That implies that the mailbox client must
>> +     * have set the allocate callback function prior to
>> +     * sending any messages.
>> +     */
>> +    if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>> + pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> Is there a better  way to do this?  The flag is not accessable from 
> the driver.
>> +
>> +    return pcc_mchan;
>>   +err:
>>       mbox_free_channel(chan);
>>       return ERR_PTR(-ENXIO);
>>   }
>> @@ -417,8 +460,38 @@ void pcc_mbox_free_channel(struct pcc_mbox_chan 
>> *pchan)
>>   }
>>   EXPORT_SYMBOL_GPL(pcc_mbox_free_channel);
>>   +static int pcc_write_to_buffer(struct mbox_chan *chan, void *data)
>> +{
>> +    struct pcc_chan_info *pchan = chan->con_priv;
>> +    struct pcc_mbox_chan *pcc_mbox_chan = &pchan->chan;
>> +    struct pcc_header *pcc_header = data;
>> +
>> +    if (!pchan->chan.manage_writes)
>> +        return 0;
>> +
>> +    /* The PCC header length includes the command field
>> +     * but not the other values from the header.
>> +     */
>> +    int len = pcc_header->length - sizeof(u32) + sizeof(struct 
>> pcc_header);
>> +    u64 val;
>> +
>> +    pcc_chan_reg_read(&pchan->cmd_complete, &val);
>> +    if (!val) {
>> +        pr_info("%s pchan->cmd_complete not set", __func__);
>> +        return -1;
>> +    }
>> +    memcpy_toio(pcc_mbox_chan->shmem,  data, len);
>> +    return 0;
>> +}
>> +
>
> I think this is the pattern that we  want all of the PCC mailbox 
> clients to migrate to.  Is there any reason it was not implmented this 
> way originally?-
>
>> +
>>   /**
>> - * pcc_send_data - Called from Mailbox Controller code. Used
>> + * pcc_send_data - Called from Mailbox Controller code. If
>> + *        pchan->chan.rx_alloc is set, then the command complete
>> + *        flag is checked and the data is written to the shared
>> + *        buffer io memory.
>> + *
>> + *        If pchan->chan.rx_alloc is not set, then it is used
>>    *        here only to ring the channel doorbell. The PCC client
>>    *        specific read/write is done in the client driver in
>>    *        order to maintain atomicity over PCC channel once
>> @@ -434,17 +507,37 @@ static int pcc_send_data(struct mbox_chan 
>> *chan, void *data)
>>       int ret;
>>       struct pcc_chan_info *pchan = chan->con_priv;
>>   +    ret = pcc_write_to_buffer(chan, data);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = pcc_chan_reg_read_modify_write(&pchan->cmd_update);
>>       if (ret)
>>           return ret;
>>         ret = pcc_chan_reg_read_modify_write(&pchan->db);
>> +
>>       if (!ret && pchan->plat_irq > 0)
>>           pchan->chan_in_use = true;
>>         return ret;
>>   }
>>   +
>> +static bool pcc_last_tx_done(struct mbox_chan *chan)
>> +{
>> +    struct pcc_chan_info *pchan = chan->con_priv;
>> +    u64 val;
>> +
>> +    pcc_chan_reg_read(&pchan->cmd_complete, &val);
>> +    if (!val)
>> +        return false;
>> +    else
>> +        return true;
>> +}
>> +
>> +
>> +
>>   /**
>>    * pcc_startup - Called from Mailbox Controller code. Used here
>>    *        to request the interrupt.
>> @@ -490,6 +583,7 @@ static const struct mbox_chan_ops pcc_chan_ops = {
>>       .send_data = pcc_send_data,
>>       .startup = pcc_startup,
>>       .shutdown = pcc_shutdown,
>> +    .last_tx_done = pcc_last_tx_done,
>>   };
>>     /**
>> diff --git a/include/acpi/pcc.h b/include/acpi/pcc.h
>> index 840bfc95bae3..9af3b502f839 100644
>> --- a/include/acpi/pcc.h
>> +++ b/include/acpi/pcc.h
>> @@ -17,6 +17,35 @@ struct pcc_mbox_chan {
>>       u32 latency;
>>       u32 max_access_rate;
>>       u16 min_turnaround_time;
>> +
>> +    /* Set to true to indicate that the mailbox should manage
>> +     * writing the dat to the shared buffer. This differs from
>> +     * the case where the drivesr are writing to the buffer and
>> +     * using send_data only to  ring the doorbell.  If this flag
>> +     * is set, then the void * data parameter of send_data must
>> +     * point to a kernel-memory buffer formatted in accordance with
>> +     * the PCC specification.
>> +     *
>> +     * The active buffer management will include reading the
>> +     * notify_on_completion flag, and will then
>> +     * call mbox_chan_txdone when the acknowledgment interrupt is
>> +     * received.
>> +     */
>> +    bool manage_writes;
>> +
>> +    /* Optional callback that allows the driver
>> +     * to allocate the memory used for receiving
>> +     * messages.  The return value is the location
>> +     * inside the buffer where the mailbox should write the data.
>> +     */
>> +    void *(*rx_alloc)(struct mbox_client *cl,  int size);
>> +};
>> +
>> +struct pcc_header {
>> +    u32 signature;
>> +    u32 flags;
>> +    u32 length;
>> +    u32 command;
>>   };
>
> Fairly certain these should not be explicitly little endian IAW the 
> spec. It has been a source of discussion in the past.
>
>
>>     /* Generic Communications Channel Shared Memory Region */

