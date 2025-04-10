Return-Path: <netdev+bounces-181389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A114A84C2A
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 20:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8694A673C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED9928EA7C;
	Thu, 10 Apr 2025 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nQCdgaNP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FBD28D85A;
	Thu, 10 Apr 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310177; cv=fail; b=iLqJ1AI6CF76XXSv5hO2xdKmnjdn0Zy/Xiwh7hNZqio72Gl5LdBETqE1YFnmSHvVEb6nu4Ijoh3XCv6oG9NYGLQK625X3JeDiWil7wj3+7+KZjVV5nQSJurlttaaUHehcahCHOmjkhJ9fD2pBH4jx3s1grq3d0/Ffz20IQCGsGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310177; c=relaxed/simple;
	bh=W5du4nxHJvPoC1zO7ENv1i6gnQ/TN+uHu9N9CZm89/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i3zOXKHUKswh2ud5G161KcFgMQL9vswySvz6Mf6XLv6xiS6lkoZZl4IbzNksiFZiTXnrxqtf58GK5TL14nvo5tMR6ziNzRlbIuacV/lNk1rRRjFHaStNYqY8VYPl1/9jvf6IlSYrHNwXIp/vplBtEkqhbH26J1tI/IEyqAdo37w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nQCdgaNP; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCimQ+U3RTEmLsQ6hLANS/pZmy4xwRycAE2irSJ0juQ8tsAD6RzsVFQH/MpXPdFoRKFY9AhHLmdPHPGoC7D5fYk3KTPt6+BXJKl8WU/rZVkuoJq8DV79ysbHnG/U9QXKeAiMF0YaMDNf/sB/OSb2EF8KfBclyc3caJo7DY+lLb0N/6nHzeL0b+JPMZMkvGd7yK7IBXz7W7+GA8gqFjjMqBgexVzhPr/wYGBwDWTzMRiuDFvhJA6JU8yv+R9OwCHfefSIfHzJz+9vwBEVhEyvGl7PGv4OG1/TWeypeKKdSSjLECXvIfytwPxAEt4of0mv148WoRWQknfYBysQwf01Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5du4nxHJvPoC1zO7ENv1i6gnQ/TN+uHu9N9CZm89/w=;
 b=sFsxgl4bMTzYvCktOnj59PW2kiPxcbacKwm+b21b53vYv7wai7MC//rjZ/KeHmZHbaD8sbuJNAki/o1q6lon2DmTRBl+EjQDe03iMFpa8pUUFnSEvRPMEs3Dv2jDPVbniHKekNiODVbwYjs38hKug+Ze+/CQfL8hB9J0VUwErVwI3bj7R3ofesij0cOJR88Ks1Hkd8+ugvqaFI4iT7cFaEkdqjl5Jj2FYzZ0KqTqGIoNG106GR7apEiW/qdZ5ad2nybY+MuxWfh8NNYz772mUTTDEaLlqg245IZf42bz5e0QfSpM0EmnyNqR/BGOxqrenLknp9+WHwKa1H7bTNvE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5du4nxHJvPoC1zO7ENv1i6gnQ/TN+uHu9N9CZm89/w=;
 b=nQCdgaNPrvr7tuOUMV9nA+nUFrX9rsGWioixgSgl+AGkVk+jCHGIF4bATPDrrbDzaM9b29Io++1RyOPUZYKibhwP7GQwpbxSyq8dhDQrpiBYbpCWu1YNqZWxxHs1VF+pGLaDfq5X/nnnPdAcuGrFplVr3E0Jerh0KPn3K6vJ+nCD8rVq3M/WLXaUNbAYjxywbVXScKfPvjfwOBIb66TVWb1NH7RBDMHzdduNGvSKAJAZMWr+cBMf36x/U7s0Etn1mw1Qz8zv9O9nvacoXmFFjuPrdz5gpPTEIyV/ubDDcRTKmi+rhUkCjYnV637p8L1t2bbCamMN4SszQD8OKUk6fw==
Received: from CY5PR11MB6462.namprd11.prod.outlook.com (2603:10b6:930:32::10)
 by PH0PR11MB5030.namprd11.prod.outlook.com (2603:10b6:510:41::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Thu, 10 Apr
 2025 18:36:11 +0000
Received: from CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643]) by CY5PR11MB6462.namprd11.prod.outlook.com
 ([fe80::640:1ea2:fff1:a643%3]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:36:10 +0000
From: <Prathosh.Satish@microchip.com>
To: <ivecera@redhat.com>, <conor@kernel.org>
CC: <krzk@kernel.org>, <netdev@vger.kernel.org>, <vadim.fedorenko@linux.dev>,
	<arkadiusz.kubalewski@intel.com>, <jiri@resnulli.us>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <lee@kernel.org>,
	<kees@kernel.org>, <andy@kernel.org>, <akpm@linux-foundation.org>,
	<mschmidt@redhat.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Thread-Topic: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Thread-Index:
 AQHbqV2+K5ewoIcBuU2czqcsXcly9bOce1aAgAALE4CAAFzYgIAABPuAgAA3ALCAAAw3gIAAEFnw
Date: Thu, 10 Apr 2025 18:36:10 +0000
Message-ID:
 <CY5PR11MB6462CF4414B3B0A87EE35780ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
 <20250410-puritan-flatbed-00bf339297c0@spud>
 <6dc1fdac-81cc-4f2c-8d07-8f39b9605e04@redhat.com>
 <CY5PR11MB6462412A953AF5D93D97DCE5ECB72@CY5PR11MB6462.namprd11.prod.outlook.com>
 <7f24f249-f49a-4365-930f-f4ebe502c6bf@redhat.com>
In-Reply-To: <7f24f249-f49a-4365-930f-f4ebe502c6bf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6462:EE_|PH0PR11MB5030:EE_
x-ms-office365-filtering-correlation-id: 7217396a-c8b6-43cd-c658-08dd785e90a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MnQzMG5iVG1XMGpWay8zWjFhQWJYUGc4Y0pScUdzK1NqUHRaOVRvZG1ZT3Bn?=
 =?utf-8?B?VjV0ZlZXMjFtRzYzQ2lzeHVDcW1ZSDQzaUNaTzdNNkgrZzB1TURRVTd6K29o?=
 =?utf-8?B?d2t5K1g2dHdBRXhqbXZicDU3cXBzeFUxSVplaWxGazV4Z3JWZWJlMnp2VnEw?=
 =?utf-8?B?eENHZGwyN1FCUHF2MHl4SnAxU3BKTzBrVGMwcmhWL3B6dWI3MmVaZjREclNI?=
 =?utf-8?B?VDZtM1hDRjFJcmpkbkpLQjdEN3JKbXVXOWxpUS94OGJlWUhtUWJ2bzV0TGZi?=
 =?utf-8?B?SUpJc1VkUDZsNlV3bHhNRkxxSWNoVVNDaFcrM09DMm15YVhpU2V0elhITjF6?=
 =?utf-8?B?UkU2MzRmc2o0a09TSmhEbEU2bVN6U240NGJyOGhodEJhcDgxK01scXEyaE5Z?=
 =?utf-8?B?TkhUc0owYUpVSVI2cWJCSUR1ajBNTmVwSDRueXB3dDVPSjRDWDRwbzhneHp3?=
 =?utf-8?B?MXN3TmNQRkZ5SkpTNEtlcnRhRWJpU1VteVV1aDFIWkpMOUdXMTNHYnlHYzVl?=
 =?utf-8?B?S0dFRmozUnk0SjZOMzRPenRVVUl5b21YZ1hHSDhHWURSUkxicUw1SjhNOHIy?=
 =?utf-8?B?c1dRVnhiRnVaazE5NVVuMUJpNmtCZ3MwTXpFMVJQNVNVK0FwT2hueVk4Y1pT?=
 =?utf-8?B?dnRmNDBPOWhzd1phcW85MnBwdEJpQ3JFZTF2OHlnclFiYVRuSGNEc2FCZERk?=
 =?utf-8?B?dGZZa0pQZFIyYXkxcTVHUTRBM0ZmaGF3aXNTeHRoZ0tEVXVRcy9ac0pzRGYz?=
 =?utf-8?B?OXJoYTRqOW4xRTN6Q213aDNOL2ZSemlzNXhEWmZGQUNjWlN2eUFsRjhZUXRP?=
 =?utf-8?B?cVREbkJ1V2REdjBad1dnVSsvcWJBZVhUaHJSSUUxaERGL1lCeTdYRURob2w4?=
 =?utf-8?B?czB1d254NTRVT28rNXc4QmloOUhWVWN5bHdmU1M0aGdRRWdyUXpRdjV6ajU5?=
 =?utf-8?B?cUF2NUtYWGZYRUxkUEtvcDdKZVU3U0Zib2RtdkkyWWtXNERUOHNMbERWTkp1?=
 =?utf-8?B?ajZydkwvVktScE5PSFRYRlNGeDJFTnpzN2JUL284WGtiMW03dHg2MXdzTTc0?=
 =?utf-8?B?UlgxblUwZm9DMC80dWI5U1JHSWVtNEp6bEtaZzhZQVJKRnIwUDEzZlJRdE5s?=
 =?utf-8?B?c3lVMXMrL3ZTL1JWSk9mRkkrdHFjbVMxYURIbTl3SmRDTlV6MFZUcDRFVUV6?=
 =?utf-8?B?SldjS3k4dUl4ajFDZEZpV3pwS041cndmSk1hT1Q3TVZLWTJ0cU9jdk1KQy9s?=
 =?utf-8?B?aE1IVXp1NThjSDh6R3BJR2ZEUFVWVThxUVpNUzlOTzRaNnpBWXU0YjJISmxZ?=
 =?utf-8?B?UUYvMTBNNE5IRWdhNVVScFNPY3RsblFzRzNxRm5QK09WdS85OWt6N0FzanRY?=
 =?utf-8?B?dHlUcFlEOGVLOFMxdnAyZFI2bktOVm1ncUFYTThqcGJjdk42RG5rbHJ6M2dy?=
 =?utf-8?B?bXk3ZDFoN1daNDUyV2t4S2xJVTJOakt0ZldYenY0ditaQzdlS2pjVFB1ZWJa?=
 =?utf-8?B?ckh2bnlDZ01xQ20vQXdFbkpyd2twUkZUSlNQTGQ3ZUcrZnFSN3NZaTRGUDBp?=
 =?utf-8?B?M0xRWWpTeTlDdWxURytGNzJRZkhRRHZ2Um5xUEgxdzdhVDdXR05ZZW00YXB3?=
 =?utf-8?B?cVpEeWpTMEROTnEyQjVKRGJnOVVnSHZ4enFyOURrSGZFTnc3b0pCSFFhQ0lt?=
 =?utf-8?B?bXg5OVhQaU9pek1SSjVhc2x4VkJMem5qWEN0cFNyNVlzTk9PbmJOMGJNV1E5?=
 =?utf-8?B?cm5RZFBoaWgrbUU0VVJ4MnhRc245NThpSUtSczhoWkZWZjJKQ2duNjMyODI4?=
 =?utf-8?B?K3FCYWRidE9iU2VpWWFjekZ5WTNYMmlmLzJBemVPLzdNdnVQY2ZRaXVXdHJ3?=
 =?utf-8?B?M1JSVFo1NXBhOXRWektxbFNiQk1IaWFFaDBYcHpkYXBBekFPQy9qYW01eEtT?=
 =?utf-8?Q?tuKXbjep0/i/0P1dcLLZYUGR5I2GbHbK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6462.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zks2QmFtWTF5bnJDN0tjaFAzWVdFbmlFVHE5cVBVWWVVbzhIZXFqZVBIak5a?=
 =?utf-8?B?UXgwOVM5d2ttdk5PdEp6TlRBSmhiOFRiUHBpVzRyMUpFeW5tWklOM29RNDN4?=
 =?utf-8?B?cHBRMVNYc1JHVnA4cFR3S3VaUmlsSlZrK2F5dHBUUHU2ZUFsRnVCWUFqRHNu?=
 =?utf-8?B?L25GUThzQk5SOEQxQnIyaG5SR2dReWhXdXVtQkxNSWZsKzBNQkpYakQxdFgw?=
 =?utf-8?B?RFN4S2VGOFBxRlRjbWJ6OFY3aG16RGJ4VTFJMUsxUHIvclNybmMvdVVXOWli?=
 =?utf-8?B?clRCdSttZnNEQktiR3dKUUZReUlJa2J0ZGFxUTQ3dFVIU2huRUxSWFhmN01r?=
 =?utf-8?B?aHo1OGt3Qm1wRnBMKzF5OUxpMmZWMUU3akZtZlpRb3h4OE02K29uQ3IxVHdH?=
 =?utf-8?B?a2lLU25tV3RoVTR3ZTVmL2JsK1J4dklUeTVtNFZkQWUwMUowRHhBS3VBN3Zx?=
 =?utf-8?B?ejFGcE14a1JIS1RwNWt5bXUydFFsMHV4bUpoWVYvQTJLK0RGejFpM05qMmlT?=
 =?utf-8?B?djdVL0E4SXp2UlMwU2pRejNYUDIyd3VBTFVSdE40cUFnZjJGWWt2RDladCtK?=
 =?utf-8?B?aWpSN1FENmFoaHlzS3JDMk1VdVNxMWxYZzRhbm9IM3VOTzJOMTZMeWl1N2V5?=
 =?utf-8?B?bTVOOS9UcG02MXlQTm14OE5JdEtacElWaWIrdUhXM1ZTcjlseDRhMDVDeGg0?=
 =?utf-8?B?K1NKVDRmdW1oQ2oyanlzbllobVQzQ0swNUNORFU5dU1Idk1YUXF5dnp3MjZM?=
 =?utf-8?B?QTdVZ25VOEIxOEV0dmgrZXhBSm81ZFJ5R1hHWVZMa2Fod0d3NXRqZm9yaHFI?=
 =?utf-8?B?VHR1U3dGNVRFaUhWSCs0aFZDN2tuY3NLUGdXQ3RSR2lOdXJKTEFEaml2dUhP?=
 =?utf-8?B?MzBLdFVodkI0c3VGZlBFUlAyR0dqMzBQSWxRbFFFck4vZVorTGxXQytWaDlt?=
 =?utf-8?B?MmNkRjRMYzBVWVprOEY5R1ZlQmN5RjBieFFCSVk2bWFUNW1zMmEzeEJzdFVa?=
 =?utf-8?B?ajcxa05SWEFSWlFJWHZuZ041S1pWbGZtbU9Sck91SG1FaUpZQ1ZEM3lrdGht?=
 =?utf-8?B?RUdsS2g0bmxHNHRVWmoyQ3EycXRhTFBlbTFNSjRBTUFURWRtSGVBdEtxV0Qw?=
 =?utf-8?B?VDZQN05sa1p1OHVtNGVDem5CUlBKbVpLMUt5a2liYmN1ZmpUODBjaThyanhW?=
 =?utf-8?B?aVBxcFJjZGxIWkZyZGdsUTNzT3A1WVZqTVFiWm52czNLZytiNkIvcDZ5SUNT?=
 =?utf-8?B?VGVZOHhzMlpJMVVIdjVlaVNnK2F6dGRpOEZRRWdwdGxxVW9oTlhsNXZmOW54?=
 =?utf-8?B?SkdpSFoyeFZ4dG5jVkdBWHNCYXpTR0RVM1dNVTNORGJTWk14OXJXSVEvQWJq?=
 =?utf-8?B?d1ByUEtKLzk2TjdhbktqYTNvWS9NYnpqeDN5dituSzNKRU0wUkd5clNzcncv?=
 =?utf-8?B?dHFGUXlSejhQZW5pRGdoNGtWa1dLTEMzaW12TWZOUlQ4N1g4S1JBbjdidVl1?=
 =?utf-8?B?RFBqRFFNT0gySERLaHpUN2FsV3ZLVHhxMkJnM0lGS2lkeUxaMlhiS21pRlow?=
 =?utf-8?B?QlFJOE5DTUNWaURBQTAxOUZtUWRqREZqN0JwcmVBMnJXcUdmb1pVTkt6aHYv?=
 =?utf-8?B?OTlZR1BHVDM1VjEyTnJGOXFic0lhcWZ4ekxCMXpzd0U0akdpWklHRVJ4Kzd6?=
 =?utf-8?B?NmZ1MWF5bFFyZ3Zxem5YTHVCNzM3cVpuYjFzUlJidldIS0ZWQU12amJJUERE?=
 =?utf-8?B?ck1qbVord1VTbld6QnhqSHFZTms0ZkphTVYrU1JKRlIxZmxTSXVSbDJJa0Vo?=
 =?utf-8?B?NmZ2OGk0UlZpR0tXb3ZuVVkvWFRNTk00Y1FnTWFNcy94TUlyTGE0MEJYY0Nj?=
 =?utf-8?B?WFRwSVQrbUYwZnNwYkU1YjhmOVBjZEJ2bUkybW94QjgrSjFkTk1VL1lIbC91?=
 =?utf-8?B?N05ucURUVE5pVWF5SWVMVFpja2xkODV6NGpXMWFET3lYc1dVdndZTmZhQkhi?=
 =?utf-8?B?VGxobE1xbStZSVgxa1JOcy9GZkhzVUd3dTJIaWQySjJPekN6MnEwSzN4cVVD?=
 =?utf-8?B?Y21kaUJyaHQ1ckZIZnhhQXZ4ZTRsaXJwMlRrWG12UGFyTk03Q0dDM2xDelNq?=
 =?utf-8?B?Tmk2Z2NEMXppbFJVUEtTSXdtWHIxVzYvK2c3d3BwV2tJbCtyTnZKT1ZFL2Rm?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6462.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7217396a-c8b6-43cd-c658-08dd785e90a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 18:36:10.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XUEC/z0nVXgKzBHWs+Rv+gMdOd6mbE7SEMCoFCaPpYEA2suAwPnJ0KkGID+wCE+w5SjIseKW6yDWsrmJaEDqSZJObPvzJ5XmxDnC3Bb7OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5030

SGkgSXZhbiwNCg0KeWVzIHlvdSBhcmUgcmlnaHQsIHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgdGhl
IG51bWJlciBvZiBjaGFubmVscy4NCg0KUHJhdGhvc2gNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5jb20+IA0KU2VudDogVGh1
cnNkYXkgMTAgQXByaWwgMjAyNSAxODozNg0KVG86IFByYXRob3NoIFNhdGlzaCAtIE02NjA2NiA8
UHJhdGhvc2guU2F0aXNoQG1pY3JvY2hpcC5jb20+OyBjb25vckBrZXJuZWwub3JnDQpDYzoga3J6
a0BrZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyB2YWRpbS5mZWRvcmVua29AbGlu
dXguZGV2OyBhcmthZGl1c3oua3ViYWxld3NraUBpbnRlbC5jb207IGppcmlAcmVzbnVsbGkudXM7
IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3Jn
OyBsZWVAa2VybmVsLm9yZzsga2Vlc0BrZXJuZWwub3JnOyBhbmR5QGtlcm5lbC5vcmc7IGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc7IG1zY2htaWR0QHJlZGhhdC5jb207IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1oYXJkZW5p
bmdAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzE0XSBkdC1iaW5k
aW5nczogZHBsbDogQWRkIHN1cHBvcnQgZm9yIE1pY3JvY2hpcCBBenVyaXRlIGNoaXAgZmFtaWx5
DQoNCkVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KDQpPbiAxMC4gMDQuIDI1IDc6
MDcgb2RwLiwgUHJhdGhvc2guU2F0aXNoQG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEl2YW4gVmVjZXJhIDxpdmVjZXJhQHJlZGhhdC5j
b20+DQo+IFNlbnQ6IFRodXJzZGF5IDEwIEFwcmlsIDIwMjUgMTQ6MzYNCj4gVG86IENvbm9yIERv
b2xleSA8Y29ub3JAa2VybmVsLm9yZz47IFByYXRob3NoIFNhdGlzaCAtIE02NjA2NiANCj4gPFBy
YXRob3NoLlNhdGlzaEBtaWNyb2NoaXAuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6a0BrZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgDQo+IFZhZGltIEZlZG9y
ZW5rbyA8dmFkaW0uZmVkb3JlbmtvQGxpbnV4LmRldj47IEFya2FkaXVzeiBLdWJhbGV3c2tpIA0K
PiA8YXJrYWRpdXN6Lmt1YmFsZXdza2lAaW50ZWwuY29tPjsgSmlyaSBQaXJrbyA8amlyaUByZXNu
dWxsaS51cz47IFJvYiANCj4gSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgDQo+IENvbm9yIERvb2xleSA8Y29ub3IrZHRA
a2VybmVsLm9yZz47IFByYXRob3NoIFNhdGlzaCAtIE02NjA2NiANCj4gPFByYXRob3NoLlNhdGlz
aEBtaWNyb2NoaXAuY29tPjsgTGVlIEpvbmVzIDxsZWVAa2VybmVsLm9yZz47IEtlZXMgQ29vayAN
Cj4gPGtlZXNAa2VybmVsLm9yZz47IEFuZHkgU2hldmNoZW5rbyA8YW5keUBrZXJuZWwub3JnPjsg
QW5kcmV3IE1vcnRvbiANCj4gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBNaWNoYWwgU2No
bWlkdCA8bXNjaG1pZHRAcmVkaGF0LmNvbT47IA0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgDQo+IGxpbnV4LWhhcmRlbmluZ0B2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8xNF0gZHQtYmluZGluZ3M6
IGRwbGw6IEFkZCBzdXBwb3J0IGZvciANCj4gTWljcm9jaGlwIEF6dXJpdGUgY2hpcCBmYW1pbHkN
Cj4NCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyANCj4gdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiAxMC4g
MDQuIDI1IDM6MTggb2RwLiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4gT24gVGh1LCBBcHIgMTAs
IDIwMjUgYXQgMDk6NDU6NDdBTSArMDIwMCwgSXZhbiBWZWNlcmEgd3JvdGU6DQo+Pj4NCj4+Pg0K
Pj4+IE9uIDEwLiAwNC4gMjUgOTowNiBkb3AuLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0K
Pj4+PiBPbiBXZWQsIEFwciAwOSwgMjAyNSBhdCAwNDo0MjozOFBNIEdNVCwgSXZhbiBWZWNlcmEg
d3JvdGU6DQo+Pj4+PiBBZGQgRFQgYmluZGluZ3MgZm9yIE1pY3JvY2hpcCBBenVyaXRlIERQTEwg
Y2hpcCBmYW1pbHkuIFRoZXNlIA0KPj4+Pj4gY2hpcHMgcHJvdmlkZXMgMiBpbmRlcGVuZGVudCBE
UExMIGNoYW5uZWxzLCB1cCB0byAxMCBkaWZmZXJlbnRpYWwgDQo+Pj4+PiBvciBzaW5nbGUtZW5k
ZWQgaW5wdXRzIGFuZCB1cCB0byAyMCBkaWZmZXJlbnRpYWwgb3IgMjAgc2luZ2xlLWVuZGVkIG91
dHB1dHMuDQo+Pj4+PiBJdCBjYW4gYmUgY29ubmVjdGVkIHZpYSBJMkMgb3IgU1BJIGJ1c3Nlcy4N
Cj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBJdmFuIFZlY2VyYSA8aXZlY2VyYUByZWRoYXQu
Y29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgICAgLi4uL2JpbmRpbmdzL2RwbGwvbWljcm9jaGlwLHps
MzA3M3gtaTJjLnlhbWwgIHwgNzQgKysrKysrKysrKysrKysrKysrDQo+Pj4+PiAgICAgLi4uL2Jp
bmRpbmdzL2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtc3BpLnlhbWwgIHwgNzcNCj4+Pj4+ICsrKysr
KysrKysrKysrKysrKysNCj4+Pj4NCj4+Pj4gTm8sIHlvdSBkbyBub3QgZ2V0IHR3byBmaWxlcy4g
Tm8gc3VjaCBiaW5kaW5ncyB3ZXJlIGFjY2VwdGVkIHNpbmNlIA0KPj4+PiBzb21lIHllYXJzLg0K
Pj4+Pg0KPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMoKykNCj4+Pj4+
ICAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtaTJjLnlhbWwNCj4+Pj4+ICAgICBjcmVhdGUgbW9kZSAx
MDA2NDQNCj4+Pj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kcGxsL21pY3Jv
Y2hpcCx6bDMwNzN4LXNwaS55YW1sDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdA0KPj4+Pj4gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZHBsbC9taWNyb2NoaXAsemwzMDczeC1p
MmMueWFtDQo+Pj4+PiBsIA0KPj4+Pj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZHBsbC9taWNyb2NoaXAsemwzMDczeC1pMmMueWFtDQo+Pj4+PiBsDQo+Pj4+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwMC4uZDkyODA5ODhmOWViNw0K
Pj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2RwbGwvbWljcm9jaGlwLHpsMzA3M3gtaTJjLg0KPj4+Pj4gKysrIHlhbWwNCj4+
Pj4+IEBAIC0wLDAgKzEsNzQgQEANCj4+Pj4+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPj4+Pj4gKy0tLQ0KPj4+Pj4gKyRp
ZDoNCj4+Pj4+ICtodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kcGxsL21pY3JvY2hpcCx6
bDMwNzN4LWkyYy55YW1sIw0KPj4+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4+Pj4gKw0KPj4+Pj4gK3RpdGxlOiBJMkMtYXR0YWNo
ZWQgTWljcm9jaGlwIEF6dXJpdGUgRFBMTCBkZXZpY2UNCj4+Pj4+ICsNCj4+Pj4+ICttYWludGFp
bmVyczoNCj4+Pj4+ICsgIC0gSXZhbiBWZWNlcmEgPGl2ZWNlcmFAcmVkaGF0LmNvbT4NCj4+Pj4+
ICsNCj4+Pj4+ICtkZXNjcmlwdGlvbjoNCj4+Pj4+ICsgIE1pY3JvY2hpcCBBenVyaXRlIERQTEwg
KFpMMzA3M3gpIGlzIGEgZmFtaWx5IG9mIERQTEwgZGV2aWNlcyANCj4+Pj4+ICt0aGF0DQo+Pj4+
PiArICBwcm92aWRlcyAyIGluZGVwZW5kZW50IERQTEwgY2hhbm5lbHMsIHVwIHRvIDEwIGRpZmZl
cmVudGlhbCBvcg0KPj4+Pj4gKyAgc2luZ2xlLWVuZGVkIGlucHV0cyBhbmQgdXAgdG8gMjAgZGlm
ZmVyZW50aWFsIG9yIDIwIHNpbmdsZS1lbmRlZCBvdXRwdXRzLg0KPj4+Pj4gKyAgSXQgY2FuIGJl
IGNvbm5lY3RlZCB2aWEgbXVsdGlwbGUgYnVzc2VzLCBvbmUgb2YgdGhlbSBiZWluZyBJMkMuDQo+
Pj4+PiArDQo+Pj4+PiArcHJvcGVydGllczoNCj4+Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+PiAr
ICAgIGVudW06DQo+Pj4+PiArICAgICAgLSBtaWNyb2NoaXAsemwzMDczeC1pMmMNCj4+Pj4NCj4+
Pj4gSSBhbHJlYWR5IHNhaWQ6IHlvdSBoYXZlIG9uZSBjb21wYXRpYmxlLCBub3QgdHdvLiBPbmUu
DQo+Pj4NCj4+PiBBaCwgeW91IG1lYW4gc29tZXRoaW5nIGxpa2U6DQo+Pj4gaWlvL2FjY2VsL2Fk
aSxhZHhsMzEzLnlhbWwNCj4+Pg0KPj4+IERvIHlvdT8NCj4+Pg0KPj4+PiBBbHNvLCBzdGlsbCB3
aWxkY2FyZCwgc28gc3RpbGwgYSBuby4NCj4+Pg0KPj4+IFRoaXMgaXMgbm90IHdpbGRjYXJkLCBN
aWNyb2NoaXAgdXNlcyB0aGlzIHRvIGRlc2lnbmF0ZSBEUExMIGRldmljZXMgDQo+Pj4gd2l0aCB0
aGUgc2FtZSBjaGFyYWN0ZXJpc3RpY3MuDQo+Pg0KPj4gVGhhdCdzIHRoZSB2ZXJ5IGRlZmluaXRp
b24gb2YgYSB3aWxkY2FyZCwgbm8/IFRoZSB4IGlzIG1hdGNoaW5nIA0KPj4gYWdhaW5zdCBzZXZl
cmFsIGRpZmZlcmVudCBkZXZpY2VzLiBUaGVyZSdzIGxpa2UgMTQgZGlmZmVyZW50IHBhcnRzIA0K
Pj4gbWF0Y2hpbmcgemwzMDczeCwgd2l0aCB2YXJ5aW5nIG51bWJlcnMgb2Ygb3V0cHV0cyBhbmQg
Y2hhbm5lbHMuIE9uZSANCj4+IGNvbXBhdGlibGUgZm9yIGFsbCBvZiB0aGF0IGhhcmRseSBzZWVt
cyBzdWl0YWJsZS4NCj4NCj4gUHJhdGhvc2gsIGNvdWxkIHlvdSBwbGVhc2UgYnJpbmcgbW9yZSBs
aWdodCBvbiB0aGlzPw0KPg0KPiBKdXN0IHRvIGNsYXJpZnksIHRoZSBvcmlnaW5hbCBkcml2ZXIg
d2FzIHdyaXR0ZW4gc3BlY2lmaWNhbGx5IHdpdGggDQo+IDItY2hhbm5lbCBjaGlwcyBpbiBtaW5k
IChaTDMwNzMyKSB3aXRoIDEwIGlucHV0IGFuZCAyMCBvdXRwdXRzLCB3aGljaCBsZWQgdG8gc29t
ZSBjb25mdXNpb24gb2YgdXNpbmcgemwzMDczeCBhcyBjb21wYXRpYmxlLg0KPiBIb3dldmVyLCB0
aGUgZmluYWwgdmVyc2lvbiBvZiB0aGUgZHJpdmVyIHdpbGwgc3VwcG9ydCB0aGUgZW50aXJlIA0K
PiBaTDMwNzN4IGZhbWlseQ0KPiBaTDMwNzMxIHRvIFpMMzA3MzUgYW5kIHNvbWUgc3Vic2V0IG9m
IFpMMzA3MzIgbGlrZSBaTDgwNzMyIGV0YyANCj4gZW5zdXJpbmcgY29tcGF0aWJpbGl0eSBhY3Jv
c3MgYWxsIHZhcmlhbnRzLg0KDQpIdWgsIHRoZW4gb2suLi4gV2Ugc2hvdWxkIHNwZWNpZnkgemwz
MDczMS01IGNvbXBhdGlibGVzIGFuZCB0aGV5IGRpZmZlcnMgb25seSBieSBudW1iZXIgb2YgY2hh
bm5lbHMgKDEtNSkgPw0KDQpUaGUgbnVtYmVyIG9mIGlucHV0IGFuZCBvdXRwdXQgcGlucyBhcmUg
dGhlIHNhbWUgKDEwIGFuZCAyMCksIHJpZ2h0Pw0KDQpJZiBzbywgSSBoYXZlIHRvIHVwZGF0ZSB0
aGUgd2hvbGUgZHJpdmVyIHRvIGFjY29tbW9kYXRlIGR5bmFtaWMgbnVtYmVyIG9mIGNoYW5uZWxz
IGFjY29yZGluZyBjaGlwIHR5cGUuDQoNCkJ0dy4gQ29ub3IsIEtyenlzdG9mIGlmIHdlIHVzZSBt
aWNyb2NoaXAsemwzMDczMSwgLi4uLCBtaWNyb2NoaXAsemwzMDczNS4uLiBXaGF0IHNob3VsZCBi
ZSB0aGUgZmlsZW5hbWUgZm9yIHRoZSB5YW1sIGZpbGU/DQoNClRoYW5rcywNCkl2YW4NCg0KPiBU
aGFua3MuDQo+Pg0KPj4+DQo+Pj4gQnV0IEkgY2FuIHVzZSBtaWNyb2NoaXAsYXp1cml0ZSwgaXMg
aXQgbW9yZSBhcHByb3ByaWF0ZT8NCj4+DQo+PiBObywgSSB0aGluayB0aGF0IGlzIHdvcnNlIGFj
dHVhbGx5Lg0KPg0KDQo=

