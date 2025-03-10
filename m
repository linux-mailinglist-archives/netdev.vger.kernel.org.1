Return-Path: <netdev+bounces-173455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC9A58FAB
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827733A5ED3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3E2248BB;
	Mon, 10 Mar 2025 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jg/Dfyml"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120F62253BD;
	Mon, 10 Mar 2025 09:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598991; cv=fail; b=svNMPrzc8+U/KUCnV6XNgMcmG7pFB1F+hozIcRotxbFk/EWp0QZkdWiIoo7jWKTa+Y6wZvnDkIkVtjm6GpOElsj6JTJsQ5Ipne37WGjiJDKLNkJXXKh3kpG8aPk7T5BdXcoYl1n7dJjZyr7FYGMApiesSrm0YZO9mOilHeWboOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598991; c=relaxed/simple;
	bh=c8m0OfP2ho/HUwN3/UsohtMEsU4pMpZpf9tk/HPXy7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rMxj4s6+dSEvgBubDxx2tT2khaA+ZojA6daA7XFVJ5p981DjZL+R4atmcR78IBgVcbuNMQMvVZ+EqKkPD8XCkLFZyYVAfB34YPJhmMsaDe6oM6dH1tnsofscuYBPHd3HyRhcgUvvS2lEkUBPZzGae+TQfRv7w0BGTgmw5sYUI9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jg/Dfyml; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPmijrWv17/9SPkR68kSulttRcvZfI8yWRdJRjyf5zf8tqQbxU0O5foAslytsBUH1ESGjXCjBJLe/ZTeRg+SpGIA4diBXwxliivP5dJgUEUJ9J35ZQm85TJwoLZ5j1gPGbYYKsYn2KjvlytaJojBzFDSgvsYzvCnCEtXmahTd257NdTYLcBTOTwTaOiRlPyEwMmXolBhPUDq6+HCGgIIViOJsgXaE880/irC8zBIOons2eJcyJWbaUyoM1GxocESeqXfmto6uTsNxRA7Aw6xNIdHcjZ7PEhsAt/tv1YnuLn0AulOdShMfRD9USWyi1U1sKYhrI8DItDN4zmwj1vSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8m0OfP2ho/HUwN3/UsohtMEsU4pMpZpf9tk/HPXy7E=;
 b=DTWCFoqxX5lF9Fo4BAl8xXi9VXuAJhpzYiiCPvSNyMJkLaLfhy1ZQa0UYMOkucN9szz32v5KJ2Kn7Y0kSw6UPrbHvjtvdXg9r04da6eou94y+rJL6I8aWN9qxKmWY6Z1sB8gFSqLlHh5ZvoNhPu6VrMes28pbP8J0pTsA2W/siFyKSOXDB8pc6gBJo/gB6Mo3MoAFIDe6bgoOJzsH8NYLQmPlOCtHFsKauYRHg4RRiq1rkicblSksvu017XsgXXt9QzwVRMyeDp6/BUFemBVq0Pb4JkXSbZ+0/tZWSjqheJoeeoiY0nsOxHrcPtmlbv6GdsJHq771SoSKh7txli6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8m0OfP2ho/HUwN3/UsohtMEsU4pMpZpf9tk/HPXy7E=;
 b=jg/DfymlptBGUa6RZJsFpvit7Gjli+S33t+vQaAxwF1l/D3Amm8NN/vb9t28Te7THgQSvhaGkynadhg85+IduCG8A++YWAS7NKtQd4YIRjByuDgBUtOK2dX37aIo62Bc3VMTIzlnAwlL52HXf+ReVyaKoRJkYOH0wGGnHVMHAr6PHrRJR5YFy50rS/pn+s+o9MYrNTkAf3xWG/WDv4x6R89l1Suhupk2VQCWKkftEhphdVAlypKv8yJAQ+keXjEC0byO+UwxPSMd6DUrhdMzIsPWNemvzRnEueZejc1k5CgRBdf1eMs5mQdXEcjLPmX6TlW/3xJxLc+OLKIJz1WSXg==
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 09:29:46 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::b6b7:41ec:7dc8:773]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::b6b7:41ec:7dc8:773%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 09:29:45 +0000
From: <Thangaraj.S@microchip.com>
To: <andrew+netdev@lunn.ch>, <rmk+kernel@armlinux.org.uk>,
	<davem@davemloft.net>, <Rengarajan.S@microchip.com>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <kuba@kernel.org>
CC: <phil@raspberrypi.org>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink for
 improved PHY and MAC management
Thread-Topic: [PATCH net-next v2 1/7] net: usb: lan78xx: Convert to PHYlink
 for improved PHY and MAC management
Thread-Index: AQHbj44+urFtMNt7IkGXtUISmB5lBrNsHc+A
Date: Mon, 10 Mar 2025 09:29:45 +0000
Message-ID: <1bb51aad80be4bb5e0413089e1b1bf747db4e123.camel@microchip.com>
References: <20250307182432.1976273-1-o.rempel@pengutronix.de>
	 <20250307182432.1976273-2-o.rempel@pengutronix.de>
In-Reply-To: <20250307182432.1976273-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|CH3PR11MB8562:EE_
x-ms-office365-filtering-correlation-id: 1bc325dc-5431-4b2f-502f-08dd5fb6189f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXFHZ3dyd2srVGw1SytqbkpncUlJSEJzcktuUkNBNmJ3Ykk5NTdFQUpRak9r?=
 =?utf-8?B?eGdNeHk2aXgxVTNiZ0ZTWUlYRHJ1ZWlLZVlHbFd1OWpwQVQwd2RRTGdERTkr?=
 =?utf-8?B?eXliL1lLZ0U3L3VYZGE5dzBRVisxT1RpM3hFT1RNNVU5SS8yQU1RRVVWN1p5?=
 =?utf-8?B?dnhFSEV3NWcrbWhBT1NjMnZhN3lVS1NiZnJralAwT0FNWVVWbmtMUjZYbkNq?=
 =?utf-8?B?M1ZEdm9PNDBvNXoyN2VlWk43SGR0YmtqRUpKdGVWd2g2Qlg1QWg1STlKTjY5?=
 =?utf-8?B?UENuVDBZaDBCTDNZTXlpcVB4WlhxSzJhRFRORC9jS1NrZGUxTWszbkc3L2py?=
 =?utf-8?B?QmNSc04rSjR5dHR0OTIwTmJwSDdiaHBTSkJKR0JmWDU1SkVDNllhNVZCK0NP?=
 =?utf-8?B?U1VCMDIwVHhqSEtPaGVZVXM5RERmVXlWT2pPSlRXMUJOMENiTjE4ZUVVL1Bu?=
 =?utf-8?B?bmVvRUlmSU1PU2FWdlp6KzFqT3pybzNWQTgwUmIwdEgwTWdoRThBZFhJR1d1?=
 =?utf-8?B?bjNHOVpabEllVFBtcEJKRHE3THpOUkRZRWo0VnNnSkFsdDhOQXc1U20vTHVY?=
 =?utf-8?B?SzI4eStFb2srVUhSZVZvbElNMVIwd3JqYnlubk5GRjc4YXVNZE45MHN2dlF1?=
 =?utf-8?B?aldRS2JqeVRqY0REdllZMm5VMGk4MTQxc0xLbVpBazdBSWhNRUNRV1B2blFZ?=
 =?utf-8?B?a0k5b2JpVm1qazdLM0J1UFlIeXdrOTVwdTgzM09IQnJuN3RkZU5qZHlnZlow?=
 =?utf-8?B?MWdXQmpZK0ZaeXRWaE5JdDN6S0VkRjN0U0J2aTFZMTlybGlibUpuTmh0b0JX?=
 =?utf-8?B?WmJualRROHZUc0JRQnpEemlWK2JDU1ZMdHBlc3RzTVFXNndoTHVmeTNMWUd2?=
 =?utf-8?B?L1Q1OGpCUkRTN21VY1FtZzhzdDA1V2x3VWRGTkNaWXNrSi9vd3oyTzFwaFdw?=
 =?utf-8?B?S0RWdWsxVGFkdmxKS0RxY09PeXg3b0J6WFB5UG9vNGpnWTlLOVJPQWthV2dH?=
 =?utf-8?B?SWhnV2tqcTNmQWl4eGkrSS85TVJhMUltTVducmY4VWpUV1dBUjJ4REg4cXdK?=
 =?utf-8?B?a2hYejZ2RC84Wi9KYTV3NEwwYytuclNVNkRTWHIrYjlqdzBBajROcnZVaUd2?=
 =?utf-8?B?OVNqeWFSb3pRc25RdUZTY21BMGw1VGw5M29mODVTMnVUaU1abTJpRFpHY2hJ?=
 =?utf-8?B?RmdmdjhidGFrdmlJVlRwajNIdDNvdk5UNGVVODZLYytxUW1SS282WnhNd1Ru?=
 =?utf-8?B?ZXhCZHBZVGY1enhrTGNYRlJ2eStRelpaLzUrL05GUFdWYlp2UEdqTHZyMVlJ?=
 =?utf-8?B?aEtEQkZSaGtpOFZWRnhwYlhxeFY0a3NKaVhvRFZoZFM2c2oyZzRyWllqTmpD?=
 =?utf-8?B?K29nd283bm8wRC9nTVU3SU96WS9OZFgyQ3ZtNnh3dmRzZHdMWHQ4SWtSODU5?=
 =?utf-8?B?V0Nmbkc4blZRSTZPb0hhcDNCdmJCekk5WGVMekhDUGNqY2I1TzBBNitqajRU?=
 =?utf-8?B?MUhycEN1T1A0aHRCV3NhTnNBQ0dKUTJMenAwVlJSVk8wWml1aU1wRjliOEtq?=
 =?utf-8?B?RVFPb3E5eXJRRmUrb1hMR1FUUUF3Z3hReUlncVN6R0FFVStBUTNIRlpjTHhN?=
 =?utf-8?B?eWM2cS9LSlZqWGVKbzVHZmxvWEtCeU5oY3JxMzVzbUtsWmp1clZXRUo1Y0dv?=
 =?utf-8?B?SWNHRmF4M1FadzV1RUVSMlJQSi9xWXNPWDQ5aVoxZktQUnFZWHBlTi9VTld2?=
 =?utf-8?B?dlFWbzU0YS9IUTRQZXNXSFVHZHpmS1puSENrKzR2Ym9oczlodXQzS0FYWkdp?=
 =?utf-8?B?b1FIWmVZMnJyaGpaTURNREhnR3BYOEtUZVRQZ1FxL2plNVFHYkliNG9hdTBG?=
 =?utf-8?B?a1dqN0RLUlF1MjhwK05SbWFnYXk3a2lkbmh3WFF3d0NnQ1RCYmdOS3I4OXYy?=
 =?utf-8?Q?aSZS23RWIpmQ/PsuiQj8llUW2EjVd1CG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5112.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1VKcW05MFJMY3ZOMThxZGMvMDUzYSthM2ErSE9tRlFvN3BRWEtURmdQU0l4?=
 =?utf-8?B?MHZkUkRQeDF4SnlaMTVlUkJVN1YybW9STkVzeG9ibTdoazBUMkIyNGxTNHh2?=
 =?utf-8?B?SkVxekcwZG9tK3lqOWp4SHlQaUdlNWZOWG4vS2RjRjBKRmVUK0x3WWxENnlx?=
 =?utf-8?B?RGI1LzNTeW43NUI2c05BSHUxTVc4YkRWTHZhcHZpQVRtNHJ6ZUZnajc0aWtn?=
 =?utf-8?B?QWxzMjljTXY2T0JxenhwUzVlVlUzTVVtaGhmKzVUbG1hckpRWEd5Z0RoOUNz?=
 =?utf-8?B?NDFpdkxiczBoQWR0U21UQVViR0tKdkZrNHhZSXVINy8zMy9mOGoweUhiTGFt?=
 =?utf-8?B?ckllRmw4b1hzM0NIblVqbC9UUFI0c3A4NitYb0RMOTBMNVJXNEU5NHc0Zk9X?=
 =?utf-8?B?TXliYlpmZVpXSFM1Mkl2RDdMRGJnTmxDTVJDTUhSTkVodTdPZUt1RGVtZWZM?=
 =?utf-8?B?TU52N2E2NWpOYWx5ZVA2eHdNdEFETC9qWFpua0RrZEdjZnAyYlN1MlV0cGZ5?=
 =?utf-8?B?dHpMMG1vWEY1SVgwSFRsZUpiOUFqU2s2OVk0aFNMb3c3L29SWHVpalc0eStF?=
 =?utf-8?B?dGdQTHJDbUI5T1haYUh0UHN4YnZyQUM1YStuc3Uxc2VZZzlSc1RNMWdHbTND?=
 =?utf-8?B?eHdzbXRCQ3F6aFZEN2cyS2pUSTYxckIwV1QzVEFjYVEwbFRQZ0VsMGExRGFR?=
 =?utf-8?B?Z2JxQUVSdFBmcG5SMmZYSW0vLzhHcGF5R1hhSGVhUFJqcUR1N0cyMG0xdFZU?=
 =?utf-8?B?K0hmTGN0OU5mYytBSXh2S29PK1pVaU9wSW5ZZm5TTmN2ZkVvdlhlWFQwZkky?=
 =?utf-8?B?WEpEcFoyNlNOVGt4WGVndFIweWkxRlZPTmhPYmtQWmsxd210Ym9pa1c2OWNV?=
 =?utf-8?B?UXRac1RWcGdoeWVlN1pFNENRZS9oM3YvU1EzNXg2eFZ6b0MzSy9Sdy8vMG9W?=
 =?utf-8?B?REhXVWE0MG9yMUlhd3FIVUV1NTVEWDQ4QUY3WnAxL3BWSVp5azFIajRqVzVz?=
 =?utf-8?B?aWZjNUVLODhRTTM3Y3QwWFd2QzFHSXZBZU41S0o4UEJUSm9rS3UwTjVFSFZV?=
 =?utf-8?B?dis5bnRnZzgxSU03ZDc5dTM2ZjV3SlBpYk5Bb0RpMWFMcVhQTTRSNzlMc2dE?=
 =?utf-8?B?RFdGZ1Fsc3ZwWXhXZ0tJRFE4S2V0SVZGTSszQ1FmbFBjZjZhZGsxTmpOWkZv?=
 =?utf-8?B?YWlENDhDdFgzWmdaQ2dFZFZ3UmV0RlVHbFB4ZTFTMGhENzNoRVBYV0FBMktF?=
 =?utf-8?B?V0xzeG9jcFJhSWh6OHpSbmxtV1JyNTlnVXpFNzFYUERBM095Zll4cWZqdkxq?=
 =?utf-8?B?cWpCRVhxdWQ3WGZybzVBL1RuT2huSjFMWWUyZC9XOTlFSEtmK3lOSGs1dFBD?=
 =?utf-8?B?a1g1TmQ1Q1QwVTQvWmtEamxmMlBWREIxZUk0cks1SUJ5NFQ5ZjJIZS8ra3Jw?=
 =?utf-8?B?Ry9DVVNDQmNNMU1Nem14dVVqM3N3WWtTZXJXRmdGOVNESGNpZTVWODVVTzZR?=
 =?utf-8?B?K2tQeDZ5MmpFVHZSa0R6SFNKUUhWL1F2QW1MQzlhREgyb3d4eVArYUh1YURE?=
 =?utf-8?B?TGIzUDNiemJ4cXBVWXZvV1piMGNLL1JCMk1zZUY2RUVDT2R4MkM0LzFVeENw?=
 =?utf-8?B?bmhCWlpPK3VZTkEzTG5mN3I4Z0lqbzZmdi8rUjQrcXVYWWRVY3RRNFdleVBJ?=
 =?utf-8?B?VkUyNXRZaEYxZUZ4SVgzQ0lXZFFoeC9zVHBDUHFqM3M0aVhsaytMd3BwbitW?=
 =?utf-8?B?aFlwTzd1eFkyOWNWVXp1TjZxandCWGppbWxZWG1YU3dqNXlpc2toUUQ2K2t6?=
 =?utf-8?B?blFlaWtZS0ZTOFpXR1M5eFhKNExGWXdMVHQ0ZUJzV2ZQNGxmTmVDQURBclZ2?=
 =?utf-8?B?dkJEckZNSmxTTnBPNjV4Y01ReEdENjhnekV5b0dtaml1VjlWVkxxbnFwOHJD?=
 =?utf-8?B?K3k2b1YwN1NmRk9DRm1PaEs2SlNmdHBlS0d3cW5sSDJ3TDB2OGpnaS9kQ2FF?=
 =?utf-8?B?RnA0VWFlTGlBb3FwZHhaUmYxZDFXY0JZS1pualVxZkhKZFBpTVpSaXZRT2tQ?=
 =?utf-8?B?bHFnVTNXMWpseW9mcUxtUWh3UFNQY2NLbmVLK05WODR4MFJFZzVnNURLSmVz?=
 =?utf-8?B?VzBlSVdSL0xuVGZ3bWtzY3Z0V0wvTFZIMTFGQ2RDdWdpY3cwYjNOZ0FOQVlv?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87C728170C3244C97D3C4D3DA9C3BBB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc325dc-5431-4b2f-502f-08dd5fb6189f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 09:29:45.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhnJ9EF14QwjHQVWGygig6sThg0HGTZIcVyT55K7z29dApI0xXdMK8WJztU7rO8kiWmpSYuuH4sLMVDtAK72Ibxs+M71yxHmy2dE3Ym0IE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8562

SGkgT2xla3NqaSwNCg0KT24gRnJpLCAyMDI1LTAzLTA3IGF0IDE5OjI0ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBDb252ZXJ0IHRoZSBMQU43OHh4IGRyaXZlciB0byB1c2UgdGhlIFBIWWxpbmsgZnJhbWV3
b3JrIGZvciBtYW5hZ2luZw0KPiBQSFkgYW5kIE1BQyBpbnRlcmFjdGlvbnMuDQo+IA0KPiBLZXkg
Y2hhbmdlcyBpbmNsdWRlOg0KPiAtIFJlcGxhY2UgZGlyZWN0IFBIWSBvcGVyYXRpb25zIHdpdGgg
cGh5bGluayBlcXVpdmFsZW50cyAoZS5nLiwNCj4gICBwaHlsaW5rX3N0YXJ0LCBwaHlsaW5rX3N0
b3ApLg0KPiAtIEludHJvZHVjZSBsYW43OHh4X3BoeWxpbmtfc2V0dXAgZm9yIHBoeWxpbmsgaW5p
dGlhbGl6YXRpb24gYW5kDQo+ICAgY29uZmlndXJhdGlvbi4NCj4gLSBBZGQgcGh5bGluayBNQUMg
b3BlcmF0aW9ucyAobGFuNzh4eF9tYWNfY29uZmlnLA0KPiAgIGxhbjc4eHhfbWFjX2xpbmtfZG93
biwgbGFuNzh4eF9tYWNfbGlua191cCkgZm9yIG1hbmFnaW5nIGxpbmsNCj4gICBzZXR0aW5ncyBh
bmQgZmxvdyBjb250cm9sLg0KPiAtIFJlbW92ZSByZWR1bmRhbnQgYW5kIG5vdyBwaHlsaW5rLW1h
bmFnZWQgZnVuY3Rpb25zIGxpa2UNCj4gICBgbGFuNzh4eF9saW5rX3N0YXR1c19jaGFuZ2VgLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPg0KPiAtLS0NCj4gY2hhbmdlcyB2MjoNCj4gLSBsYW43OHh4X21hY19jb25maWc6IHJlbW92
ZSB1bnVzZWQgcmdtaWlfaWQNCj4gLSBsYW43OHh4X21hY19jb25maWc6IFBIWV9JTlRFUkZBQ0Vf
TU9ERV9SR01JSSogdmFyaWFudHMNCj4gLSBsYW43OHh4X21hY19jb25maWc6IHJlbW92ZSBhdXRv
LXNwZWVkIGFuZCBkdXBsZXggY29uZmlndXJhdGlvbg0KPiAtIGxhbjc4eHhfcGh5bGlua19zZXR1
cDogc2V0IGxpbmtfaW50ZXJmYWNlIHRvDQo+IFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSV9JRA0K
PiAgIGluc3RlYWQgb2YgUEhZX0lOVEVSRkFDRV9NT0RFX05BLg0KPiAtIGxhbjc4eHhfcGh5X2lu
aXQ6IHVzZSBwaHlsaW5rX3NldF9maXhlZF9saW5rKCkgaW5zdGVhZCBvZg0KPiBhbGxvY2F0aW5n
DQo+ICAgZml4ZWQgUEhZLg0KPiAtIGxhbjc4eHhfY29uZmlndXJlX3VzYjogbW92ZSBmdW5jdGlv
biB2YWx1ZXMgdG8gc2VwYXJhdGUgdmFyaWFibGVzDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvdXNi
L2xhbjc4eHguYyB8IDU2NSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+IC0t
LS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMDAgaW5zZXJ0aW9ucygrKSwgMjY1IGRlbGV0aW9ucygt
KQ0KPiANCj4gIHN0YXRpYyBpbnQgbGFuNzh4eF9waHlfaW5pdChzdHJ1Y3QgbGFuNzh4eF9uZXQg
KmRldikNCj4gIHsNCj4gLSAgICAgICBfX0VUSFRPT0xfREVDTEFSRV9MSU5LX01PREVfTUFTSyhm
YykgPSB7IDAsIH07DQo+IC0gICAgICAgaW50IHJldDsNCj4gLSAgICAgICB1MzIgbWlpX2FkdjsN
Cj4gICAgICAgICBzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2Ow0KPiArICAgICAgIGludCByZXQ7
DQo+IA0KPiAgICAgICAgIHN3aXRjaCAoZGV2LT5jaGlwaWQpIHsNCj4gICAgICAgICBjYXNlIElE
X1JFVl9DSElQX0lEXzc4MDFfOg0KPiAgICAgICAgICAgICAgICAgcGh5ZGV2ID0gbGFuNzgwMV9w
aHlfaW5pdChkZXYpOw0KPiArICAgICAgICAgICAgICAgLyogSWYgbm8gUEhZIGZvdW5kLCBzZXQg
Zml4ZWQgbGluaywgcHJvYmFibHkgdGhlcmUgaXMNCj4gbm8NCj4gKyAgICAgICAgICAgICAgICAq
IGRldmljZSBvciBzb21lIGtpbmQgb2YgZGlmZmVyZW50IGRldmljZSBsaWtlDQo+IHN3aXRjaC4N
Cj4gKyAgICAgICAgICAgICAgICAqIEZvciBleGFtcGxlOiBFVkItS1NaOTg5Ny0xIChLU1o5ODk3
IHN3aXRjaA0KPiBldmFsdWF0aW9uIGJvYXJkDQo+ICsgICAgICAgICAgICAgICAgKiB3aXRoIExB
Tjc4MDEgJiBLU1o5MDMxKQ0KPiArICAgICAgICAgICAgICAgICovDQo+ICAgICAgICAgICAgICAg
ICBpZiAoIXBoeWRldikgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZXJyKGRl
di0+bmV0LCAibGFuNzgwMTogUEhZIEluaXQNCj4gRmFpbGVkIik7DQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiAtRUlPOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
cGh5bGlua19saW5rX3N0YXRlIHN0YXRlID0gew0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC5zcGVlZCA9IFNQRUVEXzEwMDAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLmR1cGxleCA9IERVUExFWF9GVUxMLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC5pbnRlcmZhY2UgPQ0KPiBQSFlfSU5URVJGQUNFX01PREVfUkdNSUksDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH07DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0
ID0gcGh5bGlua19zZXRfZml4ZWRfbGluayhkZXYtPnBoeWxpbmssDQo+ICZzdGF0ZSk7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbmV0ZGV2X2VycihkZXYtPm5ldCwgIkNvdWxkIG5vdCBzZXQNCj4gZml4ZWQgbGlu
a1xuIik7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gICAg
ICAgICAgICAgICAgIH0NCj4gKw0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KPiAgICAg
ICAgIGNhc2UgSURfUkVWX0NISVBfSURfNzgwMF86DQo+IEBAIC0yNTc2LDcgKzI2NzEsNyBAQCBz
dGF0aWMgaW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0IGxhbjc4eHhfbmV0DQo+ICpkZXYpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlPOw0KPiAgICAgICAgICAgICAgICAg
fQ0KPiAgICAgICAgICAgICAgICAgcGh5ZGV2LT5pc19pbnRlcm5hbCA9IHRydWU7DQo+IC0gICAg
ICAgICAgICAgICBkZXYtPmludGVyZmFjZSA9IFBIWV9JTlRFUkZBQ0VfTU9ERV9HTUlJOw0KPiAr
ICAgICAgICAgICAgICAgcGh5ZGV2LT5pbnRlcmZhY2UgPSBQSFlfSU5URVJGQUNFX01PREVfR01J
STsNCj4gICAgICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gICAgICAgICBkZWZhdWx0Og0KPiBA
QCAtMjU5MSwzNiArMjY4NiwxNCBAQCBzdGF0aWMgaW50IGxhbjc4eHhfcGh5X2luaXQoc3RydWN0
DQo+IGxhbjc4eHhfbmV0ICpkZXYpDQo+ICAgICAgICAgICAgICAgICBwaHlkZXYtPmlycSA9IFBI
WV9QT0xMOw0KPiAgICAgICAgIG5ldGRldl9kYmcoZGV2LT5uZXQsICJwaHlkZXYtPmlycSA9ICVk
XG4iLCBwaHlkZXYtPmlycSk7DQo+IA0KPiAtICAgICAgIC8qIHNldCB0byBBVVRPTURJWCAqLw0K
PiAtICAgICAgIHBoeWRldi0+bWRpeCA9IEVUSF9UUF9NRElfQVVUTzsNCj4gLQ0KPiAtICAgICAg
IHJldCA9IHBoeV9jb25uZWN0X2RpcmVjdChkZXYtPm5ldCwgcGh5ZGV2LA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBsYW43OHh4X2xpbmtfc3RhdHVzX2NoYW5nZSwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGV2LT5pbnRlcmZhY2UpOw0KPiArICAgICAg
IHJldCA9IHBoeWxpbmtfY29ubmVjdF9waHkoZGV2LT5waHlsaW5rLCBwaHlkZXYpOw0KPiAgICAg
ICAgIGlmIChyZXQpIHsNCj4gICAgICAgICAgICAgICAgIG5ldGRldl9lcnIoZGV2LT5uZXQsICJj
YW4ndCBhdHRhY2ggUEhZIHRvICVzXG4iLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBk
ZXYtPm1kaW9idXMtPmlkKTsNCj4gLSAgICAgICAgICAgICAgIGlmIChkZXYtPmNoaXBpZCA9PSBJ
RF9SRVZfQ0hJUF9JRF83ODAxXykgew0KPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAocGh5
X2lzX3BzZXVkb19maXhlZF9saW5rKHBoeWRldikpIHsNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBmaXhlZF9waHlfdW5yZWdpc3RlcihwaHlkZXYpOw0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBoeV9kZXZpY2VfZnJlZShwaHlkZXYpOw0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+IC0gICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTzsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIC8qIE1BQyBkb2Vzbid0IHN1
cHBvcnQgMTAwMFQgSGFsZiAqLw0KPiAtICAgICAgIHBoeV9yZW1vdmVfbGlua19tb2RlKHBoeWRl
diwNCj4gRVRIVE9PTF9MSU5LX01PREVfMTAwMGJhc2VUX0hhbGZfQklUKTsNCj4gLQ0KPiAtICAg
ICAgIC8qIHN1cHBvcnQgYm90aCBmbG93IGNvbnRyb2xzICovDQo+IC0gICAgICAgZGV2LT5mY19y
ZXF1ZXN0X2NvbnRyb2wgPSAoRkxPV19DVFJMX1JYIHwgRkxPV19DVFJMX1RYKTsNCj4gLSAgICAg
ICBsaW5rbW9kZV9jbGVhcl9iaXQoRVRIVE9PTF9MSU5LX01PREVfUGF1c2VfQklULA0KPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICBwaHlkZXYtPmFkdmVydGlzaW5nKTsNCj4gLSAgICAgICBs
aW5rbW9kZV9jbGVhcl9iaXQoRVRIVE9PTF9MSU5LX01PREVfQXN5bV9QYXVzZV9CSVQsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgIHBoeWRldi0+YWR2ZXJ0aXNpbmcpOw0KPiAtICAgICAg
IG1paV9hZHYgPSAodTMyKW1paV9hZHZlcnRpc2VfZmxvd2N0cmwoZGV2LQ0KPiA+ZmNfcmVxdWVz
dF9jb250cm9sKTsNCj4gLSAgICAgICBtaWlfYWR2X3RvX2xpbmttb2RlX2Fkdl90KGZjLCBtaWlf
YWR2KTsNCj4gLSAgICAgICBsaW5rbW9kZV9vcihwaHlkZXYtPmFkdmVydGlzaW5nLCBmYywgcGh5
ZGV2LT5hZHZlcnRpc2luZyk7DQo+ICsgICAgICAgcGh5X3N1c3BlbmQocGh5ZGV2KTsNCj4gDQoN
CldoeSBwaHlfc3VzcGVuZCBjYWxsZWQgaW4gdGhlIGluaXQ/IElzIHRoZXJlIGFueSBzcGVjaWZp
YyByZWFzb24/DQoNCj4gICAgICAgICBwaHlfc3VwcG9ydF9lZWUocGh5ZGV2KTsNCj4gDQo+IEBA
IC0yNjQ2LDEwICsyNzE5LDYgQEAgc3RhdGljIGludCBsYW43OHh4X3BoeV9pbml0KHN0cnVjdCBs
YW43OHh4X25ldA0KPiAqZGV2KQ0KPiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4g
DQo+IC0gICAgICAgZ2VucGh5X2NvbmZpZ19hbmVnKHBoeWRldik7DQo+IC0NCj4gLSAgICAgICBk
ZXYtPmZjX2F1dG9uZWcgPSBwaHlkZXYtPmF1dG9uZWc7DQo+IC0NCj4gICAgICAgICByZXR1cm4g
MDsNCj4gIH0NCj4gDQo+IA0K

