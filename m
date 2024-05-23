Return-Path: <netdev+bounces-97848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5918CD844
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E955E1F21509
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34751DDC0;
	Thu, 23 May 2024 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b="wnDAEcAr"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2090.outbound.protection.outlook.com [40.107.8.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065DE171AB
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 16:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481136; cv=fail; b=h02e18scpcaxyJoawYE6XJfuluAhlo2l6RHzqiMYPkeNg45rh9xOj56vsIeWLXJZM0p5dFnFLHfk+0VAZBxBMCiPPrs3Fd4/9zwiCkEpkrTmUNaf/HIOT8dxHSuHm8fSb+CbhVsTFcjykC27xvB4fGqG/tplEs0IZRSvrnJtkrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481136; c=relaxed/simple;
	bh=w0R8/Dghyog38i6rzHW7VjcQR59PrKmCLkvpD40jIb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XqZLr9P9iWFTgPQ7F7yk4NYg8jgDH7bsm+ZHu1hqLDPJwhtyDBxCpcJf4Ucq07XHS6M+2nH0YQ4xPQjP//oUFVkqcpkN9t7b8IDGOm+cT8Lih8wnhkW4crlKzzv5o+8Te5RKDVLZstTMQ9vvmZENYRXoD1g4yoFEnsELKyGHcFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com; spf=pass smtp.mailfrom=silicom-usa.com; dkim=pass (1024-bit key) header.d=SILICOMLTD.onmicrosoft.com header.i=@SILICOMLTD.onmicrosoft.com header.b=wnDAEcAr; arc=fail smtp.client-ip=40.107.8.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=silicom-usa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silicom-usa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTrYPkXyNaeUK6SMUmhIpm56kbZlHNDalvfxkdByZiuW+4/pMIdaWZNXiBbK1xb3hTngEeNtUtlhQKYX1nl3zUgnhaixJbcJlaPgkyE24QQ2LtemIn8qXTENd9zvKYXvcFYAeYe8hKay9H01CzLvnHEsIqaJzpD4mW6ZiefIxYlYSjPTk1L2GeziNHc1NzNzIUflwkcZf78ueCfY+qmi9pXIw+1tfEvNwloKaNktR5RR5+Kof1bWYByBSAjteu5cirHXnFGWSXzcnmXG8RCm8cpXSJOUnlz9vr0UBcat8Jn6hPxR1/BqDaiUKGwgQOWDd0bli4+X73/nkCxIJCixdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0R8/Dghyog38i6rzHW7VjcQR59PrKmCLkvpD40jIb8=;
 b=mDhQfuzXdQRLznvexzTCDnmljcYS6cJAk2m/TE90nfylV9J/9w3WVyWIXg0NcM9yEvnL1Ewzvz5kIn5Va71XpZkR1A1EBe5eXThbhCj9gC1sJzCxFqlE6FKTAy6bCWdbvB+T/mbZqPYMMzO6bMcsluYXQfuXxjvuz+H+k/CqgDPre/S/YCwUOCTm11w2olRkE/4KmD8cqF5nx9E+G9L+M+nbjwpKYP+k4u7QgPjD79EQ/Cj6TWRxe+d2x1dDPSBsXN6tOZ8RJSFEAJlG8ilIKP50hGSJqUnw9hgsNH05d8kwt2e4tDr4lnr7khcUuGhov3H3Y/pPeE3SR4Tul5JNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silicom-usa.com; dmarc=pass action=none
 header.from=silicom-usa.com; dkim=pass header.d=silicom-usa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector2-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0R8/Dghyog38i6rzHW7VjcQR59PrKmCLkvpD40jIb8=;
 b=wnDAEcAransL0jqUFz5cz7Rqkb/I5BjYR4OF2ru8ilwRxWOftBPpGXeFeCF0dejK5pFd4S6fLnmP84P96E9ieZD87JyBGQhAT5Hv9r4ekSZhxcgF5rIjpeytmAqjyAidjg6pyXGCNODL9nQ0aovy9jj/qocYwJ9A08Ybzv/pO0w=
Received: from AM6PR04MB5496.eurprd04.prod.outlook.com (2603:10a6:20b:9d::11)
 by AM9PR04MB8115.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 16:18:49 +0000
Received: from AM6PR04MB5496.eurprd04.prod.outlook.com
 ([fe80::4ac:ddfa:9476:b92c]) by AM6PR04MB5496.eurprd04.prod.outlook.com
 ([fe80::4ac:ddfa:9476:b92c%4]) with mapi id 15.20.7587.030; Thu, 23 May 2024
 16:18:49 +0000
From: Jeff Daly <jeffd@silicom-usa.com>
To: Jacob Keller <jacob.e.keller@intel.com>, "kernel.org-fo5k2w@ycharbi.fr"
	<kernel.org-fo5k2w@ycharbi.fr>, Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Topic: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Thread-Index:
 AQHaqxTYUzZ49rg8C060RnZ0M3bByrGh5VyAgAABhHCAAAcCAIAAQSsAgALTooCAAACL4A==
Date: Thu, 23 May 2024 16:18:48 +0000
Message-ID:
 <AM6PR04MB549643403E321AA968037310EAF42@AM6PR04MB5496.eurprd04.prod.outlook.com>
References:
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
In-Reply-To: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silicom-usa.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5496:EE_|AM9PR04MB8115:EE_
x-ms-office365-filtering-correlation-id: 038435a9-b7dd-4ce5-b1a2-08dc7b440781
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?RTlDeW5CcXFhK1ErZWpJN1B4Tyt2QXI3UXpHcEc1Z0I0TWJvdWZ6azVFVjMr?=
 =?utf-8?B?THlMdkNYKzNKRnplbXUyOTR1QmlIMlpybk5zS1lrNXVkMVYwNmxTRVBWZTRp?=
 =?utf-8?B?WmRjV2hLUTZReURZYU9xMlpUTTFFUGZBOFVqeVFEeTNRZWVQcmpyY3RvVm9H?=
 =?utf-8?B?R25zbEloSno4RDhvek56b095a0ZrZkMzbmpsSXFwZDJDNFdWekxmQWNVeWtG?=
 =?utf-8?B?UHJFcmlQU1B2TnozMHY2Vy9KMU8yMjdnS0FFYWJhZmYvRjN4R2tzM3RLZGpE?=
 =?utf-8?B?N2ZUUGxodmhWZW1LaEVqNjFzMmUyMjcxS0lCQXIwMFBnM0NaYnluUzhROWZX?=
 =?utf-8?B?ZFhoa2dpM3M3Y3crU2hUQ2lzTmdXRDFRRWVGUEswMjhNM2RqQnk0Qzd2WnZt?=
 =?utf-8?B?OEEvMmt1OTl0MXc4b1dEUlRBVE42THhUSVFUSVhpYzgvNCsraFg4OXVHeW9s?=
 =?utf-8?B?R2o5MUFYbHQxajRaNkFTMXdMSWlVLzNvNDdvUVVQd0tpYmlYSTFueHVNUGw5?=
 =?utf-8?B?ek5adGhqSXJzY1pZVFBESzNwYS9YamlmQVdMU1c5TzdRTitqSGFkOFVqU3g3?=
 =?utf-8?B?c09qb3U2T1Yyb3RmOW1mRkd6TE9IV1BrQ1VMYkRGcWlCcS9pbkV2RFdtczhX?=
 =?utf-8?B?NVdHZi92VE82Y1ZKMk1DckdrWGxZVG5mdG9BSk02UFNMOWtmZXVsbC9JbDJo?=
 =?utf-8?B?alpySW9jWFJVZm1QL056S3VKMWlmVFpvSHlNS0lFNmFsWUY1V0hhcWM0NUFv?=
 =?utf-8?B?Yk94Y2h3Mlowdy85c2ZTdjdzK21XSG5BVGUzeXdHcGRZRURHK2lUNlFvRGwr?=
 =?utf-8?B?L3dzNjhQU28xQkYvczEvU3VkYXJSODFnN2lxM3hlQXFpZTZEVlJHK0ZwaHhW?=
 =?utf-8?B?WGsyRE8zV2Fmb2ZLTnhQZ0JnOUNuZUFFNUZqOVdVZksrSElaK2x0WlpoZ1Aw?=
 =?utf-8?B?THdpcDJ1d04vQ01Yd0d0SWtLcld3REliNmJ0cjNMVm9ndkhYVnplWXpMVU9i?=
 =?utf-8?B?eWxKOXU1Yi9IVVNsYWExd3d1NEdCVEN0elBMRUtHYkVqSFNlTzFHZlNJeS9j?=
 =?utf-8?B?Rk5zOXp6QTYzU241Mk5sWWIvM0dob2ZuUTFEKzdYS3M2ZkNCUmxRMEF5YUhh?=
 =?utf-8?B?cXM2MVlUTEJ4b1I5MDlzOVhqUGk2T2pKR2x4SlA4am9Zb1Jub0xLSktlOXRl?=
 =?utf-8?B?bGJtNFJHem4vWEZaZTAvZ1JTeHMrUjlHVFNLaE5Zc3NMb2llM2YrenBqZjlM?=
 =?utf-8?B?blI4TjFoWjFtbGhHc0RvMHQ1Tm5jZ01IZXFwaGhkS3plYzFENWN0VmNKbWd3?=
 =?utf-8?B?aE1GS3lzdTkzYUlJaHJyc1VVQzFiSEtYbGY4NEx5d0lHZldSbm5RSnlZMGFI?=
 =?utf-8?B?MmlOUE9IbFFYc016aHJMMjRDaUpGWjB6WHRsc1d0dUQydDBvMVVxVVpOaDZQ?=
 =?utf-8?B?aGE3WS8yMSsrOXhjSVV3c1hoK0RGTmkwd2NaeWxSeXNQRUtibmpDN1dwV29n?=
 =?utf-8?B?K3dJNy94WmtzaFVGeFNCZi9VZ0lzTEFoa3RBSCttampvdUloVFgvK09VczZJ?=
 =?utf-8?B?ZHpaUzZoS3BTblZuNnBqNVB2bXBmOE41dllzWjdac0c0WktoWThDR0FiTHJB?=
 =?utf-8?B?SXZrZGs5OWhKejRKclJUellyNXloMGJJUWJSYXd3UndUdzdGdVFuQVdSZHdD?=
 =?utf-8?B?cXNGaG5LQ3hNOW9xcGl6N2VkQ25oaFpnclB1QlJ6R1RTc2tEMjI4TnYzeU5y?=
 =?utf-8?B?YS9wKzdJRUNSVFJqVEt6K1BjN1dHSUFwQlVTNU9VT1dzQWRHcE1QS3VOVGNW?=
 =?utf-8?B?QkRqcFFWR1FrSHJtQlkwZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STZJMmtLM3hvcjlLOWRwVkhhTWhjTmpsbXNMQ2VLaVRFenF6cmN3aXVSd0Zm?=
 =?utf-8?B?S0EwNlh2TWNHRUxmVEJyamIxMjYwUWJsQU1id2RyeWRLdnJEaXpQdVpUZndQ?=
 =?utf-8?B?a1ErRU5ZMmcrMm9CUnoyb3FIVjV6QStUY3hKS21IelZiTDViZlBvZzJyTzRu?=
 =?utf-8?B?WXZmUEhXUitOZVNrQmFVazhHcDE2a0hKa1NVcFkrZVVuOUh6TUhJWnpmTEln?=
 =?utf-8?B?UWVRaFZSWmszYTRxVWRTTUhEZW83Q1hrME8zVDBzUDJEdy9ia3VodWZTSVhM?=
 =?utf-8?B?REk5TzZKdUI2OGgzK2NoTHNGWlZYWlNTYXU2TmRscWdHdVg1UzNuTmQ1ZmJZ?=
 =?utf-8?B?WkJmODZrbDk3dzNJVmtPNFR0QU9IRkdIekpmRi83eHF1VTlCelg1ckpXeTBI?=
 =?utf-8?B?ejBBczBCSlhybGJ2aHZ5VS9vRVFyQXlxUDFJNmpqUGdTYWdYVFh1K1NxUWlI?=
 =?utf-8?B?N2xkZWVLT0ZPWm5KMmZsMVFLaEZDVzhSTkdJVVk4eUg5czhmR2VzNVN5ZDhn?=
 =?utf-8?B?UjVvd3pPa2NqOGJidmNWYnU4bzZ0M0Y0RXVoS0FUeFdaNFkzOURiSUhka2x2?=
 =?utf-8?B?MVhnMGtYWTdzZGpkL1h0TGtuOStUWFRkcHJoSmNabmhxeXBXQkdHSitNaGJs?=
 =?utf-8?B?TFdXQzhSM2Z1SzREamFJbXU5VkdKT2htekRhc2VzNEl1Y1ZmemQrbTRCTDg5?=
 =?utf-8?B?QjdFMUQya2lWZkllcXlHaUVBUXVJTjYzalBUd0laYmxXMkw2eUVjT2UzVE9T?=
 =?utf-8?B?dFpiU1pHMjZSY3VIN092OXdlOWtTdm4rRmpMeU5ZVGlHL1czVnlTcjZ5djRr?=
 =?utf-8?B?SWZscHk3WDMrVkVKb3ZadGN0MDdEM2tucUd0aGlmdXNSMGFZYU5sN09OU1Q0?=
 =?utf-8?B?dVlkNFJ4MlFXQWhlbllUQ3lVL0JZQTlvL3F4SmxvRDFJSHliNEZkdnlKMjBS?=
 =?utf-8?B?M1lEdTBrS3hZYzVFeGx2Q2JaY3BxV3FnbXVsWE1XbzBwZGJKbnozVktiNWxZ?=
 =?utf-8?B?T2lGakppYVMwZmk0dEoydnBpV0Z2SFBEYUFHTWVPNlBTc25NNUxYcnF1K0dq?=
 =?utf-8?B?V0VGekE0RGhMcytydnBIcldmWG4zOEtGL1BRc216ZlFsOXFVdTQveUlUWGMx?=
 =?utf-8?B?QmZKNHZSbG9NWk1kZHRxZXlxVjlxMFl0MTlER2ZLY0E2amN4U3lLOXR4NEk3?=
 =?utf-8?B?SUw0YkgrRi8zZkxCc2xWZFk3ZDRLU1ZybmF1bS91KzRBdG1iSjBqK3ZzbjRP?=
 =?utf-8?B?eDl4dFl4V1FBQnJvWUxnb28xRDFUaGRRaUZIOUlXSk9weDhFUWN5aFdWQ0NH?=
 =?utf-8?B?S2ROUkFNaFEyMDUyN2xybFEzWEZOVVNGTnhNQWowUytxWVNTWXcvdG12QmZL?=
 =?utf-8?B?T2cyTGY4d09LWVpJaVo1TlZjV0ppalEwWmFYZ3A3SlhaeDloWjNNYzNBeGg0?=
 =?utf-8?B?eTRJRzloY0lEcU9NWUtNa0xBY1BTSXVJazhKeXVHYkFlSlJCL1VvbmtzNi92?=
 =?utf-8?B?aWtHZytvZ3NLWS80TVdkRnpFWXdLbjZSYXJKU00zR3VlTE9sNTQyb25kYzNh?=
 =?utf-8?B?alBxMk5IUUxqVm14V3J5cG5WaWtJY0FVTjZaSVppZ1M1aEYvR20rdXNaWEF6?=
 =?utf-8?B?SVJrSFBMV3BmUXplQzJmOGQvQ1ZQdVRpZXRHZGEyQUxEb21lMEszTlkwY2Vn?=
 =?utf-8?B?NWttQ0Y2dnI1TUp2dDg2cnp5VzJETW5ITXNweTVNeVdtamM5b2lyZ0hqc0h2?=
 =?utf-8?B?ekQ0aitxcHdwTjBOUTBjZWJqZG8vWTNzZFRDVzltY09qdEJYeUFrSUVHODZu?=
 =?utf-8?B?VFZTRGxtdjVIN2VIOGkveTdudDVkNHE2RGhGejJTT1FOM1pEdFJ0K3Z3N1dn?=
 =?utf-8?B?TUd3bk9jTXk2UTJOVFJFVzczZzQrbHlHUE9HZzBKVEpCdlFnNjlvWnc4SVly?=
 =?utf-8?B?Q3RTSG1YWUtZTVQyZjJGYzU1N2tSV2FmNzlCT3pibkEyaVRrQ2dZcWUycVE1?=
 =?utf-8?B?bmtkamZlbTRwTEo1SWVGOUIxQURkVmxqV3ZOZHgxRkQrd0dBVit0YWkzNldy?=
 =?utf-8?B?NGdGc0taVTFUOWRyaVRwZjFLa25tSmxKWGhadWZtck0rNlR5Y1plUTRvd3N3?=
 =?utf-8?B?THc0SWFReTZBMnh5c0xBWnVxSTNMRFVDSFl6VExKelFKKzgwUnRRNTFPYXBi?=
 =?utf-8?Q?qs9XqRnZsX2j+p5sAYY1tHWhyBwZovS0bRaSOtidngS/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038435a9-b7dd-4ce5-b1a2-08dc7b440781
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 16:18:48.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq4katA/S8f6eALkLN3KC1CeMIziHAFnPJCIlmw0zHrrjL0tJeofhd9qZEbc0C0+SRcrShRXPAJxOP/Yas7IBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8115

SmFjb2IsIGluaXRpYWxseSBhIGNvbmZpZyBmbGFnIG9wdGlvbiB3YXMgcHV0IGZvcndhcmQgYnV0
IGJlY2F1c2Ugb2YgdGhlIG1hdHVyaXR5IG9mIHRoZSBkcml2ZXIsIHRoYXQgb3B0aW9uIHdhcyBz
aG90IGRvd24gYnkgdGhlIG1haW50YWluZXJzLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IEphY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPg0KPiBT
ZW50OiBUaHVyc2RheSwgTWF5IDIzLCAyMDI0IDEyOjE1IFBNDQo+IFRvOiBrZXJuZWwub3JnLWZv
NWsyd0B5Y2hhcmJpLmZyOyBKZWZmIERhbHkgPGplZmZkQHNpbGljb20tdXNhLmNvbT47IFNpbW9u
DQo+IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz4NCj4gQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXRdIFJldmVydCAiaXhnYmU6IE1hbnVhbCBBTi0z
NyBmb3IgdHJvdWJsZXNvbWUgbGluaw0KPiBwYXJ0bmVycyBmb3IgWDU1MCBTRkkiDQo+IA0KPiBD
YXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4g
Y2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRhY2htZW50cy4NCj4gDQo+IA0KPiBPbiA1
LzIxLzIwMjQgMjowNSBQTSwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiA1
LzIxLzIwMjQgMTA6MTIgQU0sIGtlcm5lbC5vcmctZm81azJ3QHljaGFyYmkuZnIgd3JvdGU6DQo+
ID4+IElmIGFueSBvZiB5b3UgaGF2ZSB0aGUgc2tpbGxzIHRvIGRldmVsb3AgYSBwYXRjaCB0aGF0
IHRyaWVzIHRvIHNhdGlzZnkgZXZlcnlvbmUsDQo+IHBsZWFzZSBrbm93IHRoYXQgSSdtIGFsd2F5
cyBhdmFpbGFibGUgZm9yIHRlc3Rpbmcgb24gbXkgaGFyZHdhcmUuIElmIEplZmYgYWxzbw0KPiBo
YXMgdGhlIHBvc3NpYmlsaXRpZXMsIGl0J3Mgbm90IGltcG9zc2libGUgdGhhdCB3ZSBjb3VsZCBj
b21lIHRvIGEgY29uc2Vuc3VzLiBBbGwNCj4gd2UnZCBoYXZlIHRvIGRvIHdvdWxkIGJlIHRvIHRl
c3QgdGhlIGJlaGF2aW9yIG9mIG91ciBlcXVpcG1lbnQgaW4gdGhlDQo+IHByb2JsZW1hdGljIHNp
dHVhdGlvbi4NCj4gPj4NCj4gPg0KPiA+IEkgd291bGQgbG92ZSBhIHNvbHV0aW9uIHdoaWNoIGZp
eGVzIGJvdGggY2FzZXMuIEkgZG9uJ3QgY3VycmVudGx5IGhhdmUNCj4gPiBhbnkgaWRlYSB3aGF0
IGl0IHdvdWxkIGJlLg0KPiA+DQo+IA0KPiBJdCBsb29rcyBsaWtlIG5ldGRldiBwdWxsZWQgdGhl
IHJldmVydC4gR2l2ZW4gdGhlIGxhY2sgb2YgYSBmdWxsIHVuZGVyc3RhbmRpbmcgb2YgdGhlDQo+
IG9yaWdpbmFsIGZpeCBwb3N0ZWQgZnJvbSBKZWZmLCBJIHRoaW5rIHRoaXMgaXMgdGhlIHJpZ2h0
IGRlY2lzaW9uLg0KPiANCj4gPj4gSXNuJ3QgdGhlcmUgc29tZW9uZSBhdCBJbnRlbCB3aG8gY2Fu
IGNvbnRyaWJ1dGUgdGhlaXIgZXhwZXJ0aXNlIG9uIHRoZQ0KPiB1bmRlcmx5aW5nIHRlY2huaWNh
bCByZWFzb25zIGZvciB0aGUgcHJvYmxlbSAob2J2aW91c2x5IGxldmVsIDEgT1NJKSBpbiBvcmRl
ciB0bw0KPiBndWlkZSB1cyB0b3dhcmRzIGEgc3RhdGUtb2YtdGhlLWFydCBzb2x1dGlvbj8NCj4g
Pj4NCj4gDQo+IEkgZGlkIGNyZWF0ZSBhbiBpbnRlcm5hbCB0aWNrZXQgaGVyZSB0byB0cmFjayBh
bmQgdHJ5IHRvIGdldCBhIHJlcHJvZHVjdGlvbiBzbyB0aGF0DQo+IHNvbWUgb2Ygb3VyIGxpbmsg
ZXhwZXJ0cyBjYW4gZGlhZ25vc2UgdGhlIGlzc3VlIGJlaW5nIHNlZW4uDQo+IA0KPiBJIGhvcGUg
dG8gaGF2ZSBuZXdzIEkgY2FuIHJlcG9ydCBvbiB0aGlzIHNvb24uDQo+IA0KPiA+IEkgZ3Vlc3Mg
dGhlcmUgaXMgdGhlIG9wdGlvbiBvZiBzb21lIHNvcnQgb2YgdG9nZ2xlIHZpYQ0KPiA+IGV0aHRv
b2wvb3RoZXJ3aXNlIHRvIGFsbG93IHNlbGVjdGlvbi4uLiBCdXQgdXNlcnMgbWlnaHQgdHJ5IHRv
IGVuYWJsZQ0KPiA+IHRoaXMgd2hlbiBsaW5rIGlzIGZhdWx0eSBhbmQgZW5kIHVwIGhpdHRpbmcg
dGhlIGNhc2Ugd2hlcmUgb25jZSB3ZSB0cnkNCj4gPiB0aGUgQU4tMzcsIHRoZSByZW1vdGUgc3dp
dGNoIHJlZnVzZXMgdG8gdHJ5IGFnYWluIHVudGlsIGEgY3ljbGUuDQo+ID4NCj4gDQo+IEdpdmVu
IHRoYXQgd2UgaGF2ZSB0d28gY2FzZXMgd2hlcmUgb3VyIGN1cnJlbnQgdW5kZXJzdGFuZGluZyBp
cyBhIG5lZWQgZm9yDQo+IG11dHVhbGx5IGV4Y2x1c2l2ZSBiZWhhdmlvciwgd2UgKEludGVsKSB3
b3VsZCBiZSBvcGVuIHRvIHNvbWUgc29ydCBvZiBjb25maWcNCj4gb3B0aW9uLCBmbGFnLCBvciBv
dGhlcndpc2UgdG9nZ2xlIHRvIGVuYWJsZSB0aGUgU2lsaWNvbSBmb2xrcyB3aXRob3V0IGJyZWFr
aW5nDQo+IGV2ZXJ5dGhpbmcgZWxzZS4gSSBkb24ndCBrbm93IHdoYXQgdGhlIGFjY2VwdGFuY2Ug
Zm9yIHN1Y2ggYW4gaWRlYSBpcyB3aXRoIHRoZQ0KPiByZXN0IG9mIHRoZSBjb21tdW5pdHkuDQo+
IA0KPiBJIGhvcGUgdGhhdCBpbnRlcm5hbCByZXByb2R1Y3Rpb24gdGFzayBhYm92ZSBtYXkgbGVh
ZCB0byBhIGJldHRlciB1bmRlcnN0YW5kaW5nDQo+IGFuZCBwb3NzaWJseSBhIGZpeCB0aGF0IGNh
biByZXNvbHZlIGJvdGggY2FzZXMuDQo=

