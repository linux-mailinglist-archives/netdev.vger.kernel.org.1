Return-Path: <netdev+bounces-177546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2DEA7086A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 18:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE603B783E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13F261581;
	Tue, 25 Mar 2025 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VRKGRsgw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765861799F;
	Tue, 25 Mar 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742924825; cv=fail; b=ktZvGLRhiEoElasdRSCXV1nP2sAk9W7eOZ7N4NASnkZ/v82J9Zs1GkD22FYFzbwRynpb0T3v8W3YEHFR0bFpyeUFhPNznf8jWRxcAx6Klu386NHpOOXxLYuPJT8isPgDHZ2vg1w3q5t3YVB4AQAsw6JS8VJYuXDRBkRchyJXdZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742924825; c=relaxed/simple;
	bh=k8T+iRJf7tRJTDHClJ/wwGCl5TIo6ysZatL1V65Zu+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ILrQBUy8ePM5C+Q/tBY3Zo0ZtgAj9LQnUxSH38dOJsib5rSx42rI7Gzvjpeu4wjKHLM49QULaYB0uC7FZ7KGqHW3rqPyaMZl9Io7HLg9GK4nKolh0pH8073XdII/7hD7/msuMsVyrCkItMuwGP6Y4ayUcXpwlTZDp7dulkFN3zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VRKGRsgw; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTI1XG/rGX00soND/gx56CTOS1uXWiWUH4Cuk422w9KUjq3pnHBL7+A/+1tCTL3X5NQ5fxGu2F+dGwe/aztW73sYHs3sMa3WTVmrvgWKQn8HGxxnA3ntNUx0OTrxsSrIw7Uzj+CYF63KbpR+e6nvUP4O3QcsvGVayWuDVZl6hmEtpvu41U7YChC+yduy1DkjQwv7XBUTamb2Hq1DEg9f66zsOE28DFbJ1G6Hf3sWtEe5EGiTiezkMIajc+LrOx2w9lRawNx0zwUMZDH77ViaHsivr7z3RbrOG5VN6OjaaNIrK5LVA37Pqr1YaWhfGhA2D5mGluRF0qbJ4vdNX799lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8T+iRJf7tRJTDHClJ/wwGCl5TIo6ysZatL1V65Zu+c=;
 b=UgGisRXbXpKivrR0N302pZ86DmLbjfv/4DBa/Z/iUX1p+ghYXRKcOiZBVtbft2umAZfSWu4x4KUliajCsEQXB+Mmnrrhul6n9QP2pHnGrpL0BANsZuz+bK3XuVD54bKpm/HgK1srzn5jQ37gXJNao+gjfCozp0YnuDgVlVa0srRqDkFKAfhTDOeCNGX2Eq+zj99i4UZOQldJoYyGC7nIXk1NpWHedy3FkSTQy28D3UQ7rWcTcYiKZIxSTRL9NqIZ9ceXZxqofQO+cGlk+F1+/LywRxiY2RMTxLweMgFClARzz3tXZpcqXSuyFDxoOTYfFPF6Lq2OSD03C3c8WrsQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8T+iRJf7tRJTDHClJ/wwGCl5TIo6ysZatL1V65Zu+c=;
 b=VRKGRsgwp3qWbYP/tsfIKBWVbUdQzCEce7EekmqKgs2kle3jFOAWEnoD6KInlSK3+xQk1d0Z0Y0bPRa219nehHEJu6p+j9WN7f7cXi53m6lKquR/olxxTSe91deDB+hJnZWQ2LAIzxpGILunTPPsn9EGK6DBYAu+EfjPuF8A7VNEp+Iyz2iPZDduo2Cv++8TJa6UXs9wT0pRZ1YPIcVQ4qIWARnAnSj5Q8To8/663y6CRu6f3nywXaKsspxI++lSfKHwiz2Ap4hPD0F5L5VER8tHECHPH3DMhv8Zt1qYv7pVgM1iEN/+zPVG754vDTA/6MVzBrw1qF/OO9mHwQ+eAA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 17:47:00 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::3a8a:2d38:64c0:cc4f%6]) with mapi id 15.20.8534.042; Tue, 25 Mar 2025
 17:47:00 +0000
From: <Rengarajan.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Thangaraj.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>, <horms@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 1/6] net: usb: lan78xx: Improve error handling
 in PHY initialization
Thread-Topic: [PATCH net-next v5 1/6] net: usb: lan78xx: Improve error
 handling in PHY initialization
Thread-Index: AQHbmKvwhOvgr0Px5UmLD2I3LzYJAbOEKZ+A
Date: Tue, 25 Mar 2025 17:46:59 +0000
Message-ID: <5f9b4b549d45c1c1a422c6e683a566b7a125f2a5.camel@microchip.com>
References: <20250319084952.419051-1-o.rempel@pengutronix.de>
	 <20250319084952.419051-2-o.rempel@pengutronix.de>
In-Reply-To: <20250319084952.419051-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|IA1PR11MB7248:EE_
x-ms-office365-filtering-correlation-id: 5d16cec9-bbf2-402b-22c4-08dd6bc50b5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzdQSnVZSS9SSFVnN3ZnMy9tWjV6NHlsSzhRWGFIRTczbDNKWUJXVHBJL0Fp?=
 =?utf-8?B?dUV5YW1ra1g5b0xMQzJvRk1UWGZvYUt5YzF6R1pzang1cFREd1liZnFSejFT?=
 =?utf-8?B?QkYraFpKUlF1VmJPRmZuRW9SZXZPUHpBa3lPb0syVEJoZTBPc21CUmVwWXcr?=
 =?utf-8?B?bmZ1RDVtUXBOUmFoNVZ5Z21semJ4TzlqR0dHWGROMENUWkhjaXlYM3ZLR1dl?=
 =?utf-8?B?dGkweHhOeEU0YStWaVlZZWFuZEJ4VW1HMHhUdUtYcWRYd2RZZ1hYenBibFBS?=
 =?utf-8?B?M1BpNjNGUUErY3BRd2NFMk5VWCtPQWVvWmdZVnJjNWZiQk1ESDVOY1JvN0J5?=
 =?utf-8?B?MS9Dd2hFNFZrNnBpbVhRMk5kZW5CMGZqTkZwNVlWQXlhc002Vy81Y3Q2RHZM?=
 =?utf-8?B?Umk5MDc3R0VDRWRoYmJ4Z1NhNEFadlhRdm9HbGRBSmpUSHlNWTVXOTJ4cDdT?=
 =?utf-8?B?S1FpazZkZGhlaVpEQ0FyYVJQR2pPOFhUc3ZRalI5UjczajhkNGpWaHd6Wk5E?=
 =?utf-8?B?TWxNTUw5c3RXZFd1OVFRM092NmhDaDRGcUtIOWMvVFJiN1dtWWF3VHQySzcr?=
 =?utf-8?B?RHdzYmh4WG0yMnJjV1ZSakNEVzkyWEswVDdWdEFNSmxkcUEyUis5Y2pLdlNh?=
 =?utf-8?B?NzNycW1xNHhrT1hlSFd6VlNzKzVHSkM3SFcyZGR6bC9ndFBIa1BYeHpkTUNN?=
 =?utf-8?B?bFhsc2tTVDJNQWZzdTJUa0VHd25qdDZIbHpHT29nWkpvbGdHSzg2b21oYi82?=
 =?utf-8?B?c0lLTzNtRnR5UUVRRS9PaWk5azJkcUJmS2ppT2l2YVZacnJHU0kwYWJSV3Jo?=
 =?utf-8?B?Y29LbjNLY2ZlVEowS28xWVlZNG5WOG14azNHVHI1R2VDbkxWemhlY3lRY3I2?=
 =?utf-8?B?dGZXTzVuajU3TkVrSmtHd21RNDBpaG5kWnQ1dTdMK0dCNnpFZm1XbUtxWWpj?=
 =?utf-8?B?UDl6MHV4Z1lXV3Myb3phQXpCWk1UOVRjenhCRlFEQk5VcWxWdlNscEJwaEtJ?=
 =?utf-8?B?Tmw3cEQzUjZ3Q1dWTUd0dHQ0L0o0NmNEZGVHV2Vib3NJY3NzNGMrVlJIdktr?=
 =?utf-8?B?cXlRTnF6OE80bnhMMG16djJ2OXlrMkxVNjFFak1RLzZqbmk0cTdyWCtaMjg5?=
 =?utf-8?B?Ni9FU3hRZlEyWkVEYUwwT2U5RS9KVVhNdWhqZ2ZEYWo4My85S1lERzNUMWRa?=
 =?utf-8?B?bUxmelJVQUlNQlc5T2taTEtFcUNqa2J5emlHczRSbkpQQzBFYUphUWdBMEM5?=
 =?utf-8?B?SSthaExwNzEyMS9ldXgvWkh0UEZxVmcrN01Xc2lremdQTVZNbXFBeS9seTdw?=
 =?utf-8?B?OHN0NVJSeW45SWI3cXl5bnlGc25OVWJsaU4reldjWFhjYmRLY2Q3N2RoMXlR?=
 =?utf-8?B?cEZKalJFS0dJeUZkbEIwRDRhRGk5UkgxVXlxR3ppVnVvaXM0cGRsNlplbHVI?=
 =?utf-8?B?Qy9tZXRSUkxTTFBaQVRPd2tTbllOUStSdEUzeDVLSENNQ1h6aHlmUUV0NEo4?=
 =?utf-8?B?WVhVMmpaNWRsQ3VONmw3MmMyd09FVU9URURmUVVyMzdOdUNpSXoyM2luQ01s?=
 =?utf-8?B?QTBNM0EwcHBVNWU1QTNxZjMwYVphWVhrMzhFemxxanpqS2VBYno2aG9KUVFC?=
 =?utf-8?B?K1orUkVIU1ZpUm01eTZxQXZmbXF0dFJFT2ROL21BVytoVzh1YWJaWm5FY2wv?=
 =?utf-8?B?bWRsYklkY2VFZUdKYldOTkVpOGZJczdTSmtDKzdVSkNZeG92QUFQaUpGY3Va?=
 =?utf-8?B?OHVBU08vclVOUERYclpCT1VDMFhhZUV2bDdNY3pXTTk3WXBZYU8vR0xQcmhm?=
 =?utf-8?B?MHlRQ3I5bVY5NXM5TVlRVDJHM2E1R3ZiVDcyN0JmL1NNeU42RTlhdTU1ZldG?=
 =?utf-8?B?MU8wQTc5NTZPQWtoSmdxVlVuRDlOQy9QME01WU5CSXVxT2RTWVJHWlM4WmRj?=
 =?utf-8?Q?Glt/Tw62XC3I7FAK/yVoBQuZjAS2ZB+D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0gzWWNOOGJIWmdpMVpGR2JSK2dtU2VGZFQ4WU1ZSTU2RGgwTDZ5cTZYODVN?=
 =?utf-8?B?ZjdZWVIyR3lsLzY1WDRudFNpYjVxQkg4ZWswSnRsRmN2NmduNE9UTkNjeDQv?=
 =?utf-8?B?eTUzZUplOU9aTmZKVWlWOUFadURCZ09LQ3NsTldKSC9hN1RYZHFUTDJMM1Ny?=
 =?utf-8?B?NXJJWnFOc2pVTmxGTEpVZ1Fxd0tiOVJ6bHdiQnF1eVJKV0NxdUZwa0s0ZmFK?=
 =?utf-8?B?RDRReElQNmNZcEtOYzlxQ0lLd1ZTWGQ1VEMwQ05iSTdSR1FXOHhRTGY2SlhP?=
 =?utf-8?B?R3VPZTNlWmRnK3BZMGFlVWpBaG91K0k3WVpUbGQvTkpRKzdKeHpxSWZMZjdB?=
 =?utf-8?B?MG0vcGRoQjJsZW9PZ1l5NTBYM2ZOaWNPWHFjVHpSSzJaRkpodUNRK0R0RUIx?=
 =?utf-8?B?VEtzM0ZvWDJQWEhtQTdXT3hjVExHeDAxOVV3N1N0QVl5NVBBdnpndGRxM05Y?=
 =?utf-8?B?SUFmUVplbXBLTURsVWhzNW81MXJnV3NUS0xTS0h1SmFraGlCUjdFV2hZc0du?=
 =?utf-8?B?bEFITC9OeFRWMUt5T3R2ZUlpR1F1TjU2YzBGdDNraUEwYVBRODNvWnZYeWxv?=
 =?utf-8?B?c3hUZnhhZjJyMzZjRi9HOHNrL0JUOWxhQWVuV1JWWWlKZTZEdGFUSkF0SGQz?=
 =?utf-8?B?V213b3JZK3BFL2F2ZE1KL1JwdzYzOU9pMWZBczF5Qk1wREpjMkY1WkRYbE4w?=
 =?utf-8?B?ZEdyenVENWJUQ25BeFl0eldBUC9aYlQxbjFuODl2eEwyNENGRGNheUZ3VFBJ?=
 =?utf-8?B?UUdHenhpKzdhT2pHZTVIK01QaGdwa3oxQ3FWTlA2cFc2ZWhMTDVzRTd3d2VI?=
 =?utf-8?B?VVlqZGF5ZHQ3S3ZkalR4OFB6OG05WjZoaWxOZUNndVNXK3ozRTZBU3prSURp?=
 =?utf-8?B?S3IwSlRvRjQyL01DUjdKU3E4Y3NpV0tOKzZhVXJVS0NGdmxUbSsvakxkbXAx?=
 =?utf-8?B?ZDc4Ny9nbWhqZzdxSVByVGpnQmNJdDFGa2RCTTNvc1JCbG50V2hKNmJTUDVN?=
 =?utf-8?B?SnJ5TmNMdXZuNlFpekpSZ3grTmhHRjJOMDF0VVVIU3h4djdFYk56eDM1WWdB?=
 =?utf-8?B?djc1RDYzNk84NVhiK0lVanlCMGpyTVMxck9ucnJLSlYwaFhFdkFQUkY5ZGUx?=
 =?utf-8?B?b2NmYUpsRkVRcGhoUmFxb05ZY1E4Q2VnWTVmSStrQ0lwTFd4dTgzdmozb3M2?=
 =?utf-8?B?UWY1TUNtQzlOc0tYN3E3ajVBa2o1UTZqak9TQ0pwQ1IxbVZ3NUFCVEc4SWpi?=
 =?utf-8?B?YUk4aHlmZTlxV1l2OVNRaDhoTjdud2FaR2lXL0tvZlJlR3Z3Z3h6aEl4eVkx?=
 =?utf-8?B?WHVyTkVGU255TExrRnVUcUZSYmNTTnZYZXp6OEJrSFBNeFovcnJjQmRvODVJ?=
 =?utf-8?B?eEpJTk5hTU9JOXQrVTdRSzNQRmxJTlA1ZnYxOGxOeGd3Y2FvZXZ6K25Ockkx?=
 =?utf-8?B?VXFZV0QyR2w0QkZGM291RUZZbzJ2c0ZFOElwT1RPWnJNS2dla09UWE1UOU15?=
 =?utf-8?B?b2pubG9WWGdJUzdQYnJ5VDhNVDRGSCtENTc3UnRWMVpaN1Rtem96T09LYnVz?=
 =?utf-8?B?R2tRUnZqS3pNK3ozMDNUK29CQmU1MXNDTzJaYUdYMWdiQ0hTbGpWZDRGZng3?=
 =?utf-8?B?eDh2K0ZQR2Q2eUFhL2lzUlpzY2hJUzVmNzVGbUh1SmlCc2RrOFhjSDRtTTJU?=
 =?utf-8?B?OGdKL0o0YTZ4azZHamRkNVA2OW5XZVQwTmRmOXNqZklKVVN6M2xzV3ZETGkz?=
 =?utf-8?B?czJLeExiaUM5cHZLS1o4WER4cWZZSGtudGlrbnZzVFBPRzJxeW9VL0ZNN1pL?=
 =?utf-8?B?VGZZZlZQSTYvUHpjSGpib011UzlKQ2xaNkVDbzFRZzBqdW83Rzlhbk9mWlZ0?=
 =?utf-8?B?M3M2ZitSZW9ENEI3UklnbFhlOXcyL0MrZVFNY3N4TktEdHNibmRYRy9WQVVY?=
 =?utf-8?B?N1N3RzRXSE01eENxb1B1Y3JPdWpROW51U1JMblc4akVpd05MK2tOVUlJVHZF?=
 =?utf-8?B?d3dYNDlUSHNBTHVQd21acC9va3J2R2pSbHNVc0RJbVBYWDNEcSs0MDZ1MUp0?=
 =?utf-8?B?WjFFSlBtUGU2Y1p3aStnSUF5Y3BhNERhUitUUHNsem5od0U2Ums1MDBLaFEx?=
 =?utf-8?B?UUM0ei9adHpuWnhpQWhzak9SRklsWkFJd2RNT0JuWU9TMFplMDV6TVhQWlJ0?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C8E172F64576F44AAEFA520258056B3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d16cec9-bbf2-402b-22c4-08dd6bc50b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 17:46:59.9525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j1EVnXr2KZArd9YO/fzwzWxlXKdTGkVnRe0YMb8pv26SkRukLMdacTogCd59Du+d5+YPPaPX7K9OG7TLilzFbgdFGCnI6z2k90ZfkhetOrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248

SGkgT2xla3NpaiwNCg0KT24gV2VkLCAyMDI1LTAzLTE5IGF0IDA5OjQ5ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBFbnN1cmUgdGhhdCByZXR1cm4gdmFsdWVzIGZyb20gYGxhbjc4eHhfd3JpdGVfcmVnKClg
LA0KPiBgbGFuNzh4eF9yZWFkX3JlZygpYCwgYW5kIGBwaHlfZmluZF9maXJzdCgpYCBhcmUgcHJv
cGVybHkgY2hlY2tlZCBhbmQNCj4gcHJvcGFnYXRlZC4gVXNlIGBFUlJfUFRSKHJldClgIGZvciBl
cnJvciByZXBvcnRpbmcgaW4NCj4gYGxhbjc4MDFfcGh5X2luaXQoKWAgYW5kIHJlcGxhY2UgYC1F
SU9gIHdpdGggYC1FTk9ERVZgIHdoZXJlDQo+IGFwcHJvcHJpYXRlDQo+IHRvIHByb3ZpZGUgbW9y
ZSBhY2N1cmF0ZSBlcnJvciBjb2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVt
cGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+IGNoYW5nZXMgdjU6DQo+IC0g
bWFrZSBzdXJlIGxhbjc4MDFfcGh5X2luaXQoKSBjYWxsZXIgaXMgdGVzdGluZyBhZ2FpbnN0IElT
X0VSUg0KPiAgIGluc3RlYWQgb2YgTlVMTC4NCj4gY2hhbmdlcyB2NDoNCj4gLSBzcGxpdCB0aGUg
cGF0Y2ggYW5kIG1vdmUgcGFydCBvZiBpdCBiZWZvcmUgUEhZbGluayBtaWdyYXRpb24NCj4gLS0t
DQo+ICBkcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLQ0KPiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMo
KyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3VzYi9s
YW43OHh4LmMgYi9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5jDQo+IGluZGV4IDEzN2FkZjZkNWIw
OC4uMTNiNWRhMTg4NTBhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC91c2IvbGFuNzh4eC5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L3VzYi9sYW43OHh4LmMNCj4gQEAgLTI1MTAsMTQgKzI1MTAs
MTMgQEAgc3RhdGljIHZvaWQgbGFuNzh4eF9yZW1vdmVfaXJxX2RvbWFpbihzdHJ1Y3QNCj4gbGFu
Nzh4eF9uZXQgKmRldikNCj4gDQo+ICBzdGF0aWMgc3RydWN0IHBoeV9kZXZpY2UgKmxhbjc4MDFf
cGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYpDQo+ICB7DQo+IC0gICAgICAgdTMyIGJ1
ZjsNCj4gLSAgICAgICBpbnQgcmV0Ow0KPiAgICAgICAgIHN0cnVjdCBmaXhlZF9waHlfc3RhdHVz
IGZwaHlfc3RhdHVzID0gew0KPiAgICAgICAgICAgICAgICAgLmxpbmsgPSAxLA0KPiAgICAgICAg
ICAgICAgICAgLnNwZWVkID0gU1BFRURfMTAwMCwNCj4gICAgICAgICAgICAgICAgIC5kdXBsZXgg
PSBEVVBMRVhfRlVMTCwNCj4gICAgICAgICB9Ow0KPiAgICAgICAgIHN0cnVjdCBwaHlfZGV2aWNl
ICpwaHlkZXY7DQo+ICsgICAgICAgaW50IHJldDsNCj4gDQo+ICAgICAgICAgcGh5ZGV2ID0gcGh5
X2ZpbmRfZmlyc3QoZGV2LT5tZGlvYnVzKTsNCj4gICAgICAgICBpZiAoIXBoeWRldikgew0KPiBA
QCAtMjUyNSwzMCArMjUyNCw0MCBAQCBzdGF0aWMgc3RydWN0IHBoeV9kZXZpY2UNCj4gKmxhbjc4
MDFfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0ICpkZXYpDQo+ICAgICAgICAgICAgICAgICBw
aHlkZXYgPSBmaXhlZF9waHlfcmVnaXN0ZXIoUEhZX1BPTEwsICZmcGh5X3N0YXR1cywNCj4gTlVM
TCk7DQo+ICAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKHBoeWRldikpIHsNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgbmV0ZGV2X2VycihkZXYtPm5ldCwgIk5vIFBIWS9maXhlZF9QSFkNCj4g
Zm91bmRcbiIpOw0KPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+ICAgICAgICAg
ICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBuZXRkZXZfZGJnKGRldi0+bmV0LCAiUmVnaXN0
ZXJlZCBGSVhFRCBQSFlcbiIpOw0KPiAgICAgICAgICAgICAgICAgZGV2LT5pbnRlcmZhY2UgPSBQ
SFlfSU5URVJGQUNFX01PREVfUkdNSUk7DQo+ICAgICAgICAgICAgICAgICByZXQgPSBsYW43OHh4
X3dyaXRlX3JlZyhkZXYsIE1BQ19SR01JSV9JRCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIE1BQ19SR01JSV9JRF9UWENfREVMQVlfRU5fKTsNCj4gKyAgICAgICAg
ICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJS
X1BUUihyZXQpOw0KPiArDQoNCkkgbm90aWNlZCB0aGF0IGZpeGVkX3BoeV9yZWdpc3RlciBpcyBy
ZW1vdmVkIGluIGxhdGVyIHBhdGNoZXMuIEhvd2V2ZXIsDQppbiB0aGUgYWJvdmUgaW1wbGVtZW50
YXRpb24sIGlmIGEgZmFpbHVyZSBvY2N1cnMgd2UgZXhpdCB3aXRob3V0DQp1bnJlZ2lzdGVyaW5n
IGl0LiBUbyBhdm9pZCB0aGlzIGlzc3VlLCBjYW4gd2UgaW5jbHVkZSB0aGUgcGF0Y2ggdGhhdA0K
cmVtb3ZlcyBmaXhlZF9waHlfcmVnaXN0ZXIgZmlyc3QgdG8gYXZvaWQgdGhlIGNsZWFudXAgc2Nl
bmFyaW8/DQoNCj4gICAgICAgICAgICAgICAgIHJldCA9IGxhbjc4eHhfd3JpdGVfcmVnKGRldiwg
UkdNSUlfVFhfQllQX0RMTCwNCj4gMHgzRDAwKTsNCj4gLSAgICAgICAgICAgICAgIHJldCA9IGxh
bjc4eHhfcmVhZF9yZWcoZGV2LCBIV19DRkcsICZidWYpOw0KPiAtICAgICAgICAgICAgICAgYnVm
IHw9IEhXX0NGR19DTEsxMjVfRU5fOw0KPiAtICAgICAgICAgICAgICAgYnVmIHw9IEhXX0NGR19S
RUZDTEsyNV9FTl87DQo+IC0gICAgICAgICAgICAgICByZXQgPSBsYW43OHh4X3dyaXRlX3JlZyhk
ZXYsIEhXX0NGRywgYnVmKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiArDQo+ICsgICAgICAg
ICAgICAgICByZXQgPSBsYW43OHh4X3VwZGF0ZV9yZWcoZGV2LCBIV19DRkcsDQo+IEhXX0NGR19D
TEsxMjVfRU5fIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
V19DRkdfUkVGQ0xLMjVfRU5fLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIEhXX0NGR19DTEsxMjVfRU5fIHwNCj4gSFdfQ0ZHX1JFRkNMSzI1X0VOXyk7DQo+ICsg
ICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
dXJuIEVSUl9QVFIocmV0KTsNCj4gICAgICAgICB9IGVsc2Ugew0KPiAgICAgICAgICAgICAgICAg
aWYgKCFwaHlkZXYtPmRydikgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZXJy
KGRldi0+bmV0LCAibm8gUEhZIGRyaXZlcg0KPiBmb3VuZFxuIik7DQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBOVUxMOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
RVJSX1BUUigtRUlOVkFMKTsNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAg
IGRldi0+aW50ZXJmYWNlID0gUEhZX0lOVEVSRkFDRV9NT0RFX1JHTUlJX0lEOw0KPiAgICAgICAg
ICAgICAgICAgLyogVGhlIFBIWSBkcml2ZXIgaXMgcmVzcG9uc2libGUgdG8gY29uZmlndXJlIHBy
b3Blcg0KPiBSR01JSQ0KPiAgICAgICAgICAgICAgICAgICogaW50ZXJmYWNlIGRlbGF5cy4gRGlz
YWJsZSBSR01JSSBkZWxheXMgb24gTUFDDQo+IHNpZGUuDQo+ICAgICAgICAgICAgICAgICAgKi8N
Cj4gLSAgICAgICAgICAgICAgIGxhbjc4eHhfd3JpdGVfcmVnKGRldiwgTUFDX1JHTUlJX0lELCAw
KTsNCj4gKyAgICAgICAgICAgICAgIHJldCA9IGxhbjc4eHhfd3JpdGVfcmVnKGRldiwgTUFDX1JH
TUlJX0lELCAwKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiANCj4gICAgICAgICAgICAgICAg
IHBoeWRldi0+aXNfaW50ZXJuYWwgPSBmYWxzZTsNCj4gICAgICAgICB9DQo+ICsNCj4gICAgICAg
ICByZXR1cm4gcGh5ZGV2Ow0KPiAgfQ0KPiANCj4gQEAgLTI1NjIsOSArMjU3MSwxMCBAQCBzdGF0
aWMgaW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpkZXYpDQo+ICAg
ICAgICAgc3dpdGNoIChkZXYtPmNoaXBpZCkgew0KPiAgICAgICAgIGNhc2UgSURfUkVWX0NISVBf
SURfNzgwMV86DQo+ICAgICAgICAgICAgICAgICBwaHlkZXYgPSBsYW43ODAxX3BoeV9pbml0KGRl
dik7DQo+IC0gICAgICAgICAgICAgICBpZiAoIXBoeWRldikgew0KPiAtICAgICAgICAgICAgICAg
ICAgICAgICBuZXRkZXZfZXJyKGRldi0+bmV0LCAibGFuNzgwMTogUEhZIEluaXQNCj4gRmFpbGVk
Iik7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiArICAgICAgICAg
ICAgICAgaWYgKElTX0VSUihwaHlkZXYpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5l
dGRldl9lcnIoZGV2LT5uZXQsICJsYW43ODAxOiBmYWlsZWQgdG8gaW5pdA0KPiBQSFk6ICVwZVxu
IiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaHlkZXYpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gUFRSX0VSUihwaHlkZXYpOw0KPiAgICAgICAgICAg
ICAgICAgfQ0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KPiBAQCAtMjU3Myw3ICsyNTgz
LDcgQEAgc3RhdGljIGludCBsYW43OHh4X3BoeV9pbml0KHN0cnVjdCBsYW43OHh4X25ldA0KPiAq
ZGV2KQ0KPiAgICAgICAgICAgICAgICAgcGh5ZGV2ID0gcGh5X2ZpbmRfZmlyc3QoZGV2LT5tZGlv
YnVzKTsNCj4gICAgICAgICAgICAgICAgIGlmICghcGh5ZGV2KSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIG5ldGRldl9lcnIoZGV2LT5uZXQsICJubyBQSFkgZm91bmRcbiIpOw0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIC1FTk9ERVY7DQo+ICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAg
ICBwaHlkZXYtPmlzX2ludGVybmFsID0gdHJ1ZTsNCj4gICAgICAgICAgICAgICAgIGRldi0+aW50
ZXJmYWNlID0gUEhZX0lOVEVSRkFDRV9NT0RFX0dNSUk7DQo+IEBAIC0yNTgxLDcgKzI1OTEsNyBA
QCBzdGF0aWMgaW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpkZXYp
DQo+IA0KPiAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAgICBuZXRkZXZfZXJyKGRl
di0+bmV0LCAiVW5rbm93biBDSElQIElEIGZvdW5kXG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJl
dHVybiAtRUlPOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ICAgICAgICAg
fQ0KPiANCj4gICAgICAgICAvKiBpZiBwaHlpcnEgaXMgbm90IHNldCwgdXNlIHBvbGxpbmcgbW9k
ZSBpbiBwaHlsaWIgKi8NCj4gQEAgLTI2MzMsNyArMjY0MywxMCBAQCBzdGF0aWMgaW50IGxhbjc4
eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpkZXYpDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1MzIpKTsNCj4g
ICAgICAgICAgICAgICAgIGlmIChsZW4gPj0gMCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAvKiBFbnN1cmUgdGhlIGFwcHJvcHJpYXRlIExFRHMgYXJlIGVuYWJsZWQgKi8NCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgbGFuNzh4eF9yZWFkX3JlZyhkZXYsIEhXX0NGRywgJnJlZyk7DQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGxhbjc4eHhfcmVhZF9yZWcoZGV2LCBIV19D
RkcsICZyZWcpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHJlZyAmPSB+KEhXX0NGR19MRUQwX0VOXyB8DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEhXX0NGR19MRUQxX0VOXyB8DQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEhXX0NGR19MRUQyX0VOXyB8DQo+IEBAIC0yNjQyLDcgKzI2NTUs
OSBAQCBzdGF0aWMgaW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpk
ZXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGxlbiA+IDEpICogSFdfQ0ZH
X0xFRDFfRU5fIHwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAobGVuID4gMikg
KiBIV19DRkdfTEVEMl9FTl8gfA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChs
ZW4gPiAzKSAqIEhXX0NGR19MRUQzX0VOXzsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgbGFu
Nzh4eF93cml0ZV9yZWcoZGV2LCBIV19DRkcsIHJlZyk7DQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldCA9IGxhbjc4eHhfd3JpdGVfcmVnKGRldiwgSFdfQ0ZHLCByZWcpOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4g
DQo+IC0tDQo+IDIuMzkuNQ0KPiANCg==

