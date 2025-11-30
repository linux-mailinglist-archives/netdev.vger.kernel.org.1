Return-Path: <netdev+bounces-242775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 256F8C94CC1
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 10:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4007345962
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D56274B5C;
	Sun, 30 Nov 2025 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cjPZ6o7u"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010026.outbound.protection.outlook.com [52.101.193.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BEE27280B;
	Sun, 30 Nov 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764494036; cv=fail; b=J2WZjphejzMgoGKV2w3UqhoRqfkGDWsC68CF71HhBmuopS9gPeTnj0bseeeoPMfyT5qVlMJUeNFdRV5HNtdIPwyNGh3NODFxH8LKQLgvOfTo5O6c1vvJYL+r5+dFIYUBpcvWFvjYAantj8uaXTA5NKAV6j53Vp8TwCsOoKmMRug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764494036; c=relaxed/simple;
	bh=6HK9cf83OSga6pDF+RZrzqwGiWeDTC2QWSn4X+mPK5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PPox8MafrNHXpz2Q4Cyq9aEA0vNx2UerQxNU0WHmCXiEq9kUzo39BClion7E/U0yzDJo6MrN7j9B8ZMvYUUcQQKsCEhYweB2lQuPDS6T86MHtZrV4bTKigZ4yoG6b0/+iAOX/DZxSxLw+1bzBK6bcShiuc/j2rkAI/Saky0odyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cjPZ6o7u; arc=fail smtp.client-ip=52.101.193.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeKV453vNupjIQNY9E0ch5r7e/gUmFJToriMMjIcLbST7W/i4latVyWBGyvt/fFoGFDEBGRB5VQw2dUvV3wDP8VTqo7lclxPnk92sksKWXYbiYoYOCGF6Gdi9/71nBnBExeAwzSAEsGcYNJxCKsEEDhcLsGB6vFJERUkUGEB4log7sLCTmRGHt7n4GuWE9o3PJxL0GTHMaOEOHd1Y1MYzfZwwkFgfS2+Z1ZvvunTmybrbZ7YowE5XzBxK6OyFswrirEoSaDtFWJTtKT7rm7GaPnkvjI5UJGrupWiPaHh6TD60zeAGHist4AIWSSnGKV97tz9XqaxpSSSCOcTYvdL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HK9cf83OSga6pDF+RZrzqwGiWeDTC2QWSn4X+mPK5Q=;
 b=UcZJKlShVJ2VFbYlTcq+bd/4PyAWwnSORvBHRTx+YAK83MgTpW6LXWAruFB/m+0+Cgtu/wwQSkUglPP2R+yraqFnxt++xTchZ3LuttzlQG6dOt/3dYV92C00GfLxo2amCc7eVjXsji5P7K0PetK4laPny5ENEaBoBkKlW/8AKu8Ee3a/+H+ZAcAQLmjfDzFWUOXRLDvah8YHLWl1EGXKdlcMGpNOz1MJkhEoQ3CGcd/c3leHqdHKa31fW3Zs+VX5aGCNEwUW2EpIqdiIrRrlXFoIZo/Wk5ft0Nlx0Ux6f0QIrIPLj9wi28ZHrEDX4ZoILX7IUEcrZup8ItbvAURowQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HK9cf83OSga6pDF+RZrzqwGiWeDTC2QWSn4X+mPK5Q=;
 b=cjPZ6o7uPaDyqYKB6SGhJ5M97GeFsV8e2rsd+e4Z5fhbbgzLGoQzI36Oc6HXVJz+3D/fjIMubuJdHT/FBZGRH0dytsbH2gtZziMIWpULS5lgZraRHeBn1/bK27TbAHfgxU2D9VfTQqU1n2aIPo7JdVVICkO0ElCVvbXTzyuiInE7otoXdegci7WL6NMF0LwUBAJqZgFuEW7YpVuSd9SM62o2U7ZS1fho3jBOOJEEc0FKz1+VwQua9TS82GWCzfiwvvfMmKK7PvFasE5DY5pSl4zynztTVksGoq77hln7qHECMu++4NAG11RmpJyf44/BQj2trbfCa7eIkKUK+tCTYw==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 09:13:50 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%6]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 09:13:50 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <kuba@kernel.org>
CC: <piergiorgio.beruto@gmail.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Topic: [PATCH net-next v3 1/2] net: phy: phy-c45: add SQI and SQI+
 support for OATC14 10Base-T1S PHYs
Thread-Index: AQHcXsJy1zTuJioNC0+nLc9DoQDlrrUHZEKAgAORgAA=
Date: Sun, 30 Nov 2025 09:13:50 +0000
Message-ID: <fe02fb6f-b9f9-4fb1-ba63-893ae18f0376@microchip.com>
References: <20251126104955.61215-1-parthiban.veerasooran@microchip.com>
 <20251126104955.61215-2-parthiban.veerasooran@microchip.com>
 <20251127184417.203c643e@kernel.org>
In-Reply-To: <20251127184417.203c643e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|PH3PPF23335A1E7:EE_
x-ms-office365-filtering-correlation-id: 3053f53c-b1b7-4c4c-43b4-08de2ff0c693
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q3ljcEF6c2JmOG9yRFRFaTFBbjBjSWNCZU1OM2xqNWhLTCtWbHU1M25UNDV3?=
 =?utf-8?B?dHpoZHVoSlovRkdrakYrbDNDSzZ3SlljVFIrNjFRWjJEKzN4bkNZMThLRytF?=
 =?utf-8?B?NzUyajhPTnhDSnBIMDlFZ293MTFjbnBNK0hGQVRHTmhpV2RuUzFlVldOYlVF?=
 =?utf-8?B?YUtOa3pleWtBV1pJaHNRdTBoLzY0V09IMDcxbGpzOVJkTjFiMXRrV2Fwakx3?=
 =?utf-8?B?NEVLaG5YZFk2VWRNaWt5M29XY2lPaktteXhFRWY5MUtHUUdQUFdKOFVseVdv?=
 =?utf-8?B?MVRVNjNDa3ZRdEM4N3BsN29QVE93L3ZUckE0cVc5VkJjbHhYeklVMDRLeThB?=
 =?utf-8?B?L3h3ZnJxY3hRY1F1ZFMyc1ZOa1RhN2VCcU4yOVJaQ3lKT2E0ajNxd0o2Uk5Y?=
 =?utf-8?B?V2FINmNKaHJNMU1lL2ZOaE9uSTJzbUF4RldGamJuZzIzTm5NbzZBbkJJMmZ1?=
 =?utf-8?B?WXREbWNKRGF0MHQ0U0tEYXluV0tJQjZ4L2tEbjRuY2puenFWRmtRVHg3MEdu?=
 =?utf-8?B?czRLSTA0bG9lYjB6OTlZSUgyVGJFaTUyZld1UXpJU0NJdEtyUW1zRWM3NVhq?=
 =?utf-8?B?NWhEUEdpanBCUmc2dGszTW5wL1huZUJLc1RCOURtcnRkUVJpTG5ZUkQ3cFpM?=
 =?utf-8?B?SHp4bEpseFQ4dE1EcDBNQ1FSVGxrMk5YQkNVRlMrU2l5MHFHYWZXaS85Ry96?=
 =?utf-8?B?aWs2NmlJWWhFRXVtV2d4SnQyQkRRd3JENDJwNmZQL1FwQVZ4akxHamhidm03?=
 =?utf-8?B?T1IyQUx1YzJ5bDZjUkZDR3pYTW1hRCtpTk5xV0dpcURZZmQ1WllDeU5sb1NL?=
 =?utf-8?B?S3gvNnVtR25YYnhuY0JaOGtpTXBkU051dWtzOExvTTgrb3I0N093a05NZ3c0?=
 =?utf-8?B?YzRSSG9UL2JFN2pMQjJuUHZmNit1d0Z1MmhtSVB3MS9Ia0ltMmxxUVZqcDRD?=
 =?utf-8?B?UG9jU0ROaHE4clRFUFpRaVJRZlpnWGtZZ21nT2R2dlF4bmh1aWRMcXR3ZTV4?=
 =?utf-8?B?YUthUG9yWk1weGdqK0xwOHJ1Yzc4b3J4NUxDT29Tblk3b3NqbDhUL2lkeFlh?=
 =?utf-8?B?ckxpbHV6UWljdm1DUFBrWjZ3TUQ1M0RvMzRsayszc0NKdFA0NmczY0YwQnBO?=
 =?utf-8?B?YUw3RUMrU3pwZm5YcHR1eGsvZVZ2SDZkYVErMnc4elNlV1A1NHJORTZKNEFE?=
 =?utf-8?B?cmVMZnBQYnl4b1ltcnlTZlFKMno5WlJXUEV1UWdLSFF6L3ErZi9Vb3FEdlRQ?=
 =?utf-8?B?QWhUSGZWSmFrT2poWllGcEZIUUhVYW40aklqanI3RU9BVnUralJuYU9nVnY0?=
 =?utf-8?B?ZXZSek9MYTRXdURjMVdkK2hHaWtRb1VBMGl5U3dUbXV3dkx1RnVodEo2Q1FN?=
 =?utf-8?B?blY1c3Fpc3FhemNKSkx0UHMwM0JhTHdrU0VSSU13b0JtTkEwVlBYZ2lqR3V1?=
 =?utf-8?B?SFhjbGwzWlZ0QmZqc3E5UUllSGNjemdyQmphNHhHR0JjQ1cvOCtTN2lHVXUz?=
 =?utf-8?B?MHZTdklDQ3h3WkRja3BoSDZ1ZGswNHA0QlB2QmVmZVRtWEFkZ3NhVmtwNGNr?=
 =?utf-8?B?Y1BKcFBINUpyOW95VGVweEdsL2xHUllFVGs2dTkxdXFsdUg5TkNjV0o4SEhn?=
 =?utf-8?B?c0dIdzFzOFlYZ3cwdmF2M2NXTUxnUWdReC9TWWFSelREQlhpSHltQ2YzQnBQ?=
 =?utf-8?B?azJTSjhtcHp4VE4rMWJMbDVRN0pLL1JhMVJIeE14cEJlRTNQd0pWZHMxeCtx?=
 =?utf-8?B?a1ZPOFc5Z1BkaVF5UzlrdGVEOENyKzVuWElNOGtZdmpFVW4wMUxCRm53R2JJ?=
 =?utf-8?B?aDlzWkNYbjZ6bU4ydzVFY2QwOXRRalhaNVlZV2x3SGNzd285WEtxaW8xUFBY?=
 =?utf-8?B?OUJ3MFZsQVVzU0RSN0c0Q0lVSEVHaEtkV08wTVorYzNOVUIrMUFPZm55R2My?=
 =?utf-8?B?cjlkbHQwMmFaT2drVG1IVWxiRjlFWHE1NE9DZEl0RldTVHlnbURVbmFWSElN?=
 =?utf-8?B?VUpUNE5SM3QrNk1GSjMrSnF6VWJyUWFhczM3a3Jyd1RMVUN3Q2VJUHB5WERS?=
 =?utf-8?Q?8ymvJH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEl5UlQ0MS9XRVJObG11UXNLUnJodnRBU1VDeFlNdE9KWkhBaUtaSHRGNk1Y?=
 =?utf-8?B?U25HdStHTlU3SUhXNHorV2tqS1RoaCtTQTlnNkJGMzYxM0pqYS9CV3NrMXBH?=
 =?utf-8?B?ZGJLRXBCZUhSOG5kU1ZKZThyMGpiOU44TWJ0UUJTVWxOWXo1aWY4ejJidjZB?=
 =?utf-8?B?U0xiNFFNZWVncFNmUmtpUGRXVU5COEx4TmJtYS9Eb29iYXZjYml5Q1VmR0tF?=
 =?utf-8?B?R1FUVlNPcEw1SThtaGZ2Yzc1VHVNcEd1SWd3d01jamFTc3FtM2s2WG9lZGFW?=
 =?utf-8?B?YWcwVkVaaEs1MVg3WllNZ3J3RXNlZ1FBY3JDZUY5TWtEVDk2SHNqZ1NFVW9q?=
 =?utf-8?B?UEtscU1Ga05VNzZLV2NKc0o4MGFtZ05aZk9RcjAxZ3U5ZGJHK0VmOXBpMXJ0?=
 =?utf-8?B?TVhzQjFQL0VNUlRFUjB0Qzd2MU5VVjR6UnlqbE11WEI5eG5rTWJEY25LaXNT?=
 =?utf-8?B?aElmSDNLT2g3SG1NQnhlNUhRUFBvWHl3djBMbnA1aWNacno2dWlqN3pubFlz?=
 =?utf-8?B?Z1duQU9QNlAvaFJvLzJIVW8yRlBwakpoRFN3cmk5a2JDWjVXOXU3MkF1Um1n?=
 =?utf-8?B?K3NSUHdFVHBadEVDL0lmd1dNdVlaNjBCWHRVWHMvQjM4ZzBWTGNXOHFxTFVn?=
 =?utf-8?B?eEJJS3cyZDNWaFgweFcvNC9Jb3hjQUQrWWFWWlpuK2ltWE1pL0UrNUZ5eTFZ?=
 =?utf-8?B?K2xxb3k1dllLTUdEbjlCV1poTkJ2V3l1dkxJOTZueWdNMEdCRVZuMGpGWlBL?=
 =?utf-8?B?SDgxdmxGWmo5SVcxeUJHOW5xWVhEbEJTUTlmYTZOWld2blBTRWxtZm5JTTBG?=
 =?utf-8?B?VVg3U2MydlVCQXFqR2RwcTc0WUJ0a0NQQUk5SitLQzgzTTNzWEp2UVRGVHFE?=
 =?utf-8?B?SVRycVVBUUg4R0RyRlFIeUp6VGswK3hQRm9YL2hjb2lyaitNa1ZxY2RKandI?=
 =?utf-8?B?YlUxWmxXb2V1UEZsSWYzOU5lSCtKZTZDbVlNU0Q2aHZmYlAxVlZLNUIxZnZH?=
 =?utf-8?B?WWo1cGFzUHdaYWVkenB6eHpUc0F4Z3ZLSHpXWUZ0ZjN3VEJKODhiUXMybFZ2?=
 =?utf-8?B?blNMQW1lYXk0WXJ6Lzd4V0xkeEhsTWdEemVLRGhKdnd5OVQwSXdDNVBrbWhD?=
 =?utf-8?B?dG4xdlBNZkROaHN3M1JWUGpqZ0Z1eGxpV2xpdENsOFZ4eWlvcm4rSk1Nbndi?=
 =?utf-8?B?VTEyZXVlYkQ2Qk5ZbklNTnpHL1Z3aWFYWE5oY015aHRueVB0dmVyYTU0Ukln?=
 =?utf-8?B?MXQ1V0lZQ2dzZTl3dmczZ0pNMHhLaG12YSthdHF2cFV4MUJTdHZIMFlJbnF4?=
 =?utf-8?B?aXVJY2VzTndsL3FtTW9qQk1vOGlDbTFLYmh3WFdQaXEyY204Y2JqTXZWZmFK?=
 =?utf-8?B?VEl3YU43SVg1aDdwTkF1aXJrVGUxcmNDdGNBRG9MY01iTXBtVDdLT0NMakVq?=
 =?utf-8?B?VGR5NzQ3clFVKzRrZm9TYStrV2luY1g0NDJCbFpaQ3lXUkNSMWpzc3k0d0pz?=
 =?utf-8?B?SlhHTmlUMFBZb0FSejhvdThQbWZxU2tTRWJVa3oybXorcVAyNXdpQTdZZFVY?=
 =?utf-8?B?bzViZWM4OTF1dTNOaEM3eVF2TmVQMWtDZU9RbFBPQkpUaTBjSnlTMXBEM2VK?=
 =?utf-8?B?akhrQUpaMEhIemd3OVVvZURIdURhUlRCTkc5QUFLbHN5dGp6ME5nalp2aDR3?=
 =?utf-8?B?a0huQXpHbjdZMmx2WDNIc1ZJV28zSGlFTWd0SHBqdjBpcEtwTWZCY3BRc0Ju?=
 =?utf-8?B?emxQakNDK3FoZFJWdGxtR3d5a3B0Z1YzaXl4a2RVb25uVEJPL0lQZWJONHNO?=
 =?utf-8?B?RGFVelVjNElybENxdERHbUZDTW1VVmJsc3ZaTzlNTVc1VVo4elFyQ0VDZjh3?=
 =?utf-8?B?V05MS1ZJWWJJbStUQ3VlaGhuZ09yb3JOSFhCaDlybXdlaEExQVppZnpOUzZZ?=
 =?utf-8?B?WmFJb2d1WE5rUy9ONWV5dHlxZ2FPdGIvSHdYZWlOUEVCUmtoWHJaWHdpK0FE?=
 =?utf-8?B?L0lBOHE5clZvMFZOa20ySzBkQzFSNjZqK0RYQ2pJWXZvQzVuNFlNblJ0aGpE?=
 =?utf-8?B?cUJTOWl1VkFmdWZQdWU2Um02cXlYd3UwWHlRenhNR29pMFJJSUVuSGZmNm90?=
 =?utf-8?B?N3R2RzFPY05OS1JFVmdLYVlkZjFzZUtuZktYeUNXRnpsTFlZdFZIZFBPc3Vr?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A3B861ACBEEB74F8B384065759F44B9@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3053f53c-b1b7-4c4c-43b4-08de2ff0c693
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2025 09:13:50.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzUCShgsKR4kTU6kPf2D83iOCdluJTJaj23VScPd9WQch/9O4CCVeZIAc9UzClsMyciYIajRFR1TaBcfhmXlhgvGXkZ3KPU9chLm0QpJ2+7HXg3SsO4pm9B8lpe0TAXI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7

SGkgSmFrdWIsDQoNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoZSBwYXRjaC4NCg0KT24gMjgv
MTEvMjUgODoxNCBhbSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gV2VkLCAyNiBOb3YgMjAyNSAxNjoxOTo1NCArMDUz
MCBQYXJ0aGliYW4gVmVlcmFzb29yYW4gd3JvdGU6DQo+PiAgIC8qKg0KPj4gICAgKiBzdHJ1Y3Qg
cGh5X2RldmljZSAtIEFuIGluc3RhbmNlIG9mIGEgUEhZDQo+PiAgICAqDQo+PiBAQCAtNzcyLDYg
Kzc5Niw4IEBAIHN0cnVjdCBwaHlfZGV2aWNlIHsNCj4+ICAgICAgICAvKiBNQUNzZWMgbWFuYWdl
bWVudCBmdW5jdGlvbnMgKi8NCj4+ICAgICAgICBjb25zdCBzdHJ1Y3QgbWFjc2VjX29wcyAqbWFj
c2VjX29wczsNCj4+ICAgI2VuZGlmDQo+PiArDQo+PiArICAgICBzdHJ1Y3QgcGh5X29hdGMxNF9z
cWlfY2FwYWJpbGl0eSBvYXRjMTRfc3FpX2NhcGFiaWxpdHk7DQo+IA0KPiBrZG9jIHNheWV0aDoN
Cj4gDQo+IGluY2x1ZGUvbGludXgvcGh5Lmg6ODAwIHN0cnVjdCBtZW1iZXIgJ29hdGMxNF9zcWlf
Y2FwYWJpbGl0eScgbm90IGRlc2NyaWJlZCBpbiAncGh5X2RldmljZScNClRoYW5rcyBmb3IgY2F0
Y2hpbmcgdGhpcy4gU29tZWhvdyBtaXNzZWQgbXkgcmFkYXIuIEkgd2lsbCBhZGQgdGhlIA0KZGVz
Y3JpcHRpb24gZm9yIHRoZSBzdHJ1Y3QgbWVtYmVyICdvYXRjMTRfc3FpX2NhcGFiaWxpdHknIGlu
IHRoZSBuZXh0IA0KdmVyc2lvbi4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gLS0N
Cj4gcHctYm90OiBjcg0KDQo=

