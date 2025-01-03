Return-Path: <netdev+bounces-154884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A63AA00325
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 04:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6321884088
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80199189902;
	Fri,  3 Jan 2025 03:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gS7yqQpd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1414F9CC;
	Fri,  3 Jan 2025 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874983; cv=fail; b=ly2JbTnTB5NKB6LOaQ5Gn6qiTgpV5w7K+fFgl3vtCHV1HhLb4BzOXl/EdcoI0Sm2/nyL/7Fw6fYAUB+RVB1HRsurQtdK3Hy5FUs5XrNLlUs+U0Wsk5gG41w8IfT6R2lRr8NraO5nNCxjCGrgBEYDSH4UYUHXGxJ3Zb+O/em72vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874983; c=relaxed/simple;
	bh=mTP5mROlTayWXXbNZNigOcQqqh0oNZ4xJ7NdIvd99c4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IHroXN9V6EGCu+fSAz2f/qwL6iYU93Es8DzcB0e8i3aHg/dvk3V3onoxGP2eUq+OBBP1P44PpRxIUyiL67/P0U6K/UpE0xLWc+ga9ktFzXY3dNehKsHBLvZZ4crWdpscLV8WUMhMFLJZEvSU7tC3pz01hXxRIEDCUIeKhdA3nG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gS7yqQpd; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPnYzokJ0G7XGF43kJV2kFX+acGLyVm+5YuL8xl/Q4QtlNrrR9zeThCH5GAltqL1Bju50HBpD8ChRgba2RNdFR7A3XwrOqaNnR9pHZiWIlKmF4T6UZ0eDoCpFiqdx2FvdrJg2W1BAWYqR4G0z7hCS+k2qLjxi7Y2o0dqP+ZM+5YwUvabdxS5VKgkbINQYNRnNYR1tRPceE5k+2Z5gp5Agy4oruUKBJjjTLhc3WMxvywbipQHDwr5DzV8b0XvX1YumepPAv3tjMvi0XP+vq6+fr/I0CpiAuCylBR59Eb5tvFjpPYSZPmNnsWsierhBxi46TZZmALtrwDBsP8HT+U0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTP5mROlTayWXXbNZNigOcQqqh0oNZ4xJ7NdIvd99c4=;
 b=EkpL0G7YuA3ZCP6njPxCCJj9f0BIkNaQQkusq7mKSofoueOFCzc0/+qBrK4tLX4IetWgXJKYVVAFfK1+MHsG2018JYP89szh/kbawYH5aH0MAz6L0H+Ld3Tx7NIc84b8aocbXI2UX/3ZTq2UdZM7HlaZTGt2bvTt4cdUifKcojcQiwM8vqtDEPbbYnu/obv1et+T6CZdB8ZqRlEnemqvyRlc3f6EbJGJBfsrbjlT4cYoThGfm2jjXpvfate8hH13fOO/OyoeJsc/VzY6N2Igu69KN9MgGd2NyFw3/9GeD0g7DWqCT9ViozSty7jP1fVNLcXjAr462i7fAd/ZIeuX4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTP5mROlTayWXXbNZNigOcQqqh0oNZ4xJ7NdIvd99c4=;
 b=gS7yqQpd9rHty72AH13pCb2DtB2FgckYff2Mo7lqFY9KO6rch/HDHNE/Wny+cDm6FwX2KBa44ieD5Awiq0g/N2wC8fjEiC7EY1vjG4BIeJHQ7fXJFtblfYTa3CQ6ehlQk/jJOEy8NRd03ISyh7Uj4hkLMFLUc72DMVZ3pecm75ovnyIGqkoYZUF/cZD/7KjRrNGB/Ek0QKIDaP7Mvm/EyAQy+JYZm21iKhs+1IOceXsC1GlA/rqjvhQHdkJlPJK219G3fnl/WrodJ18PwshDGLrNrKZqlSZcj54bjiL3y3n+70T9wROVLCGKSUxknUXAH2It6fJ59JNNZveT4OxVIA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH8PR11MB8108.namprd11.prod.outlook.com (2603:10b6:510:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.16; Fri, 3 Jan
 2025 03:29:33 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::22a1:16dd:eea9:330c%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 03:29:32 +0000
From: <Arun.Ramadoss@microchip.com>
To: <tharvey@gateworks.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <olteanv@gmail.com>
Subject: RE: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
Thread-Topic: [PATCH net] net: dsa: microchip: ksz9477: fix multicast
 filtering
Thread-Index: AQHbTPIJzdKXH8nrm0ChagGLPbp9HLLjUxUAgAALoYCAFyxhAIAJ+K+w
Date: Fri, 3 Jan 2025 03:29:32 +0000
Message-ID:
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf>
 <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf>
 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
In-Reply-To:
 <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH8PR11MB8108:EE_
x-ms-office365-filtering-correlation-id: 51389607-668d-4d59-8f6d-08dd2ba6d707
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tm51anE1c3g3Mm9VRE0zN3lza1NKTFRhQTR4N2h3K0pVbTdwbThtSVFtZ3Ex?=
 =?utf-8?B?c2VVS2JaZDlyaTNUbHdTQThxZGZ6WUxtN2gvZWFhSmRDN2d1alorVXIrclV3?=
 =?utf-8?B?MnJFQi9acHZoUmJhdnd3cUpKQytLeEo3bFltTEQvZ3h2MWR4OGRPVXg5eW9G?=
 =?utf-8?B?bXFtMmRFWXNTaEN1RnJnU3JPVjlxWm1ObmM2c3VmS2s5WnhPeFcrWmN1V3E3?=
 =?utf-8?B?Nk10aHM1VjFSOERmUjhZOEdReTFENWVNclZJODR6RHhNeC9qWGM0ZGk0OFFt?=
 =?utf-8?B?TUlHTmNON3U4bjVoREVUVThEYW1xZWM0cm9IRUZzUjF3T2drUnh1Z3RWU2J5?=
 =?utf-8?B?TU9zMWp6Tm5iTHV6aDFOQXplaC9MdzhBc0dRSk92Wks0amNYMCtyMXd5UzRY?=
 =?utf-8?B?V0lBOEIrQ2EzaTFUVmROR25mTGFON2N4Q1dsRHYwWnk0d3lKSFpHU0lEc3Rw?=
 =?utf-8?B?b0d5M2tCMFpNRjRNYUVQNHJzb1dzUkVQQlF2OEhkT1FxaEZNOVpVV3FNZXpI?=
 =?utf-8?B?cVg0QVdaU2ZRMEtUdW1MTWhJU1Z0M2xrcGdPaU1yMmpka2w4VURIK1pPVVB3?=
 =?utf-8?B?M1Q1TzA3RXQ3NGZ6K0pKNXZjb1ROaXgwcGVzVW1VamVZL3BENjJydUV5QjU5?=
 =?utf-8?B?cHZRVXN6VXdkcnpvczRuakNJU045UCtWbE1FOUs1emRqWDJndE9YMjRHcjlC?=
 =?utf-8?B?eEpwQjB0aXU4SDhZM2ZXSzkxd3lUejZMTWF2YVkzMk53UmQvQ2JSdWNTdEFU?=
 =?utf-8?B?Vjlqa2ZlYStFa1BjM1FVZ1RzOWpReU9zZGJzVkdjc1JzUkRFNjV3cGpWK2tr?=
 =?utf-8?B?UlBCRVpDOFpqN0xqSzFJTnE5dVp5MG1JR2FxaitXem5kWFlXYkkvVzgyK2o0?=
 =?utf-8?B?bVo2SFhJbGljcVB5cENXeVBaREk4bThrNTlQYitzSHkvRGd3VUg1MlZVSlQr?=
 =?utf-8?B?VjM4cS9ueDlwOVREcEZORFhlNGJLeFY1TG9nU2RkNEVCcDAwTkkzM2tjZUdT?=
 =?utf-8?B?Y1U4LzFnNXJPaEx2bW1mMCsxWHBCZEZYRHlYbm1HMzUrc3g4NE5FOFJnTC9v?=
 =?utf-8?B?ZXlYNmNKNVJNN0RYY0o5Qkx6c1BKR1RPZ1kwT3hUUmZUWEI5bGFuL0JlMzFV?=
 =?utf-8?B?d0t0RjNxdmlQWWpWaENRN1FHeDNHdUU3NWFFcXhQV2xtWnVmamIvUW1xQS9O?=
 =?utf-8?B?YUxJZjkreHk0bWtMcVNsTXE2cytnNGhzcDVIcHpaNkZKZkV2UXNIRFY4cFdh?=
 =?utf-8?B?ZFhlTi9uVFRYSUc4ZktOOGttSEJ0bFRucmFCSEthaC92ajJ3blhDTnhIZGdL?=
 =?utf-8?B?TlNXTlhWUFJKaE5mdnUyVUFuWVZoblZuTGNRNlBRRS8zTzBtYTNodk5lZC9P?=
 =?utf-8?B?QmdIaVhCQjN6V3NBUUJoTWp0K09McGg1UzRBZVlwcUNJUVNxTFRYekVQQUJr?=
 =?utf-8?B?c08wMS92WXlSMmZvV1JRWXlvbi9OeVY5R0hXUjF5eWRtUGxQTWpkSWFGMURR?=
 =?utf-8?B?bGRwd0hqS0ZlZUFLUSsyRjZwRW5JeXF2YlBZb0pocFM5OVorQnlJRHdKYWJ0?=
 =?utf-8?B?K2xDUGU4MGJ4ZktLejZ4WXhRWHdlc1YyN1d5UldLVW1tbVh4N3FOdGlSZ29Y?=
 =?utf-8?B?WURubWNhVVd1MXpJOHdWT0UyNlFJRnUvNlR3K0k0TktBMnVtbzVHcVlDdmJp?=
 =?utf-8?B?MW9yYnhCMFRnM1dwblUrK1FHYXVYS2RkKzl3TVRrOUMzOFFLUEdUTXBIdzNw?=
 =?utf-8?B?U0pQcUdPZEtOc1Rnd1BxNkVDWGtkSWJLRkpUeFk5TFExbFdJaWYyQ3o2VFZI?=
 =?utf-8?B?a0lFWU85b3VTUzBDSGo4cGhBN0xIbmEyUmlmVEc4VFRNYS9ZamhEK05jeWRW?=
 =?utf-8?B?T3ZVRFRYeVdQNHV5d2F0SkNRQWdhaUlNV3hXMkk2bHRHVGJyRHZ2QlhrdWFC?=
 =?utf-8?Q?NoSe4bmn53NtvjX7tO8fTIxgFlOfAa6b?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS8xZ0hKaU10ZTNHaGJJbnVucVQxS3BJM2MwcUtxWS83MjZ3UDZMU2NXcUhL?=
 =?utf-8?B?ZzJFU2pPUXRVT2t3VyswV1BuVnpNd2Y1VG5wNWF5dlJ0UTNhM2NBdFFwN3gr?=
 =?utf-8?B?TUl5MHJSVW9pSkowV2NGQWxuOVlFZEhYcXhqWjYwRTV6S1laVmRUQ1JlNk5z?=
 =?utf-8?B?aDh5ZUlCUVRrVW9HSTRNdlB0akVJM2NJS1l3cVFrdHVXZWN0emNWYU5XRzRl?=
 =?utf-8?B?QXFIWEZIU1Njd2N1QVNQd0E2am5HUWZBbXlmS09HRlRrT3BiRXBsZG5Lazd5?=
 =?utf-8?B?N015MnhzL2dJTHY5RmVkQ25JUkNiTmRTZi9MK1NxUmpMS0gvZEs4MitoMll6?=
 =?utf-8?B?dThYNnF6Q3AzemVtZlN5cURsU0pCOGltUFZ3dTQxbWRDd3RpTHRIbEw3TmFO?=
 =?utf-8?B?RGUvcVJrY3NBWkRKY1krWVRFRVpOSWNJRWpnRm9VRHlUdDlqc3d0TWY4ay8x?=
 =?utf-8?B?VjRKd1hsazJ3QmJuTy9RTEFiWHoycVhLTURGVVZFOXZJK1RPdHFhWHh4Q04z?=
 =?utf-8?B?aHhDODJUc2o1WjJaWTFvd2NvUFlvMnk1OWo0S0lQdGMyc2NYQ2FCblJMUWVp?=
 =?utf-8?B?dm11bHcrUVRaUUIwZlA4L25jWnR0bWZsMFUzdVYyd0RINWRJdmV4b2J0Z1Z4?=
 =?utf-8?B?clJqWWM3dkFpcnRNbVRYa1RCOHlVTmdiL3IrNEdlMHZtMnZwZWptTXM4eXlh?=
 =?utf-8?B?SDVoZThPMjZiNVZ2cm5QUUdFVDdpNmw0UmNwSXV4d3NLUWdzeEVidDh4V3cx?=
 =?utf-8?B?R2dqYTd4czBlSkZGcFZwNWR4aFNUaVpqS0pxaDZHc1hScURTMjYyZHJkemQ2?=
 =?utf-8?B?RTRmTmtFbW1OM2I1NkRBSlpVaUJubENibkZyT0hBN1hyNzZNTDNZc3hqK3pU?=
 =?utf-8?B?Tk1pRG5MVGFDY3BrS1lva0FFWjdYRm0rVUJYTGtsQ1QxVitkbWx5a1VxeE5H?=
 =?utf-8?B?K2t4UTg1UFQ0SEFHZ0greHBkK2RlMDZ4elBubm1iMWlWNGJxUHZlRFc1WmQ2?=
 =?utf-8?B?Sk5pZUlKQldObjhJeFk2RWxvTWFGd2JkdDdkalJnQ2RzeXFub0E0N2Z1TkNB?=
 =?utf-8?B?TFJ1Wm1VU3lIc2RpSkp5UDVZeXoyUVVYRU51c0xuUGtuMEtwb2hpUXFUOGNo?=
 =?utf-8?B?enVMQTlTMm12SUt0MC9iNE5WRmJ5ZC9LcC93NHNweW5ZaWJPaVVBbTNIZ0h4?=
 =?utf-8?B?S1VHM3VOanZKSm5rL0ZjUjN1Y2RmVllNTFpCR3g3bzk5RmhNeHhzSFFTNVB0?=
 =?utf-8?B?U1ozLytZOUgwZHpFbFZpSmx5SHphclBFRUNOenhEUVFiaURBKytqbXlDM3RS?=
 =?utf-8?B?RDJxQXFOY3pPaTNjQXJjOSsvOFIzRGNFeHJWQWZFaXFtNEhTWWdEdGRHM3Va?=
 =?utf-8?B?ZXRGOTZDckhMazRManlPZUdkOEJ3ZHBLUFA0WFNvMEJCYW9rbVRjMkxEV0xx?=
 =?utf-8?B?WjJLc3lXL2hWL2g0N2tqK2YyRkhwVFgyaGpQdFdmSndlKzlFOW1zTndSdlVQ?=
 =?utf-8?B?WHh4Z0FtM1ZDZ1ptR21KdXlKSHBNQnluNEp0ZHhVZ0RkNFFBdWdYNkFCSG9S?=
 =?utf-8?B?SkdrYVdxZnVLRWlFcm92bjJ5OFV0Q29tS2FFQms3eFNRaUFYbkllQ29TV1F4?=
 =?utf-8?B?SFdQcFhuZkExbnlhNjdzNFpjYnJrQzhGMXZ4RUhDT1NVUmRJSllaU09lcTNB?=
 =?utf-8?B?WkovT3pJZWkra3RvY1U2NUxIYjRwdXc4NDk0LzFSOFgzMnhmbExFUjB2bXNK?=
 =?utf-8?B?cENPTVVtUnVWSEMvRlRja3N3cU5pcnFMc21pVSswRUZWeTFqVWF6aWZyN1Ny?=
 =?utf-8?B?RzdtZUl3eEdvbnRmTlIwQ1BWcUZuMzJtVDVYdU1LNjNHSGFXV1BIdWwxZ3Q0?=
 =?utf-8?B?UlBHaVBNcUN4c25Wb2lXSTRPQldXV0d0aVNYdUtpSzRWV2NRRE83NThPM2Y5?=
 =?utf-8?B?dTZ2SUV2eTlhcHYrRzhuMURDVHJIM2V4cFJSeng3MEMxZXZVNm1rRitEUTJn?=
 =?utf-8?B?V0xJVmtTYlRIbjVGSkIzbEppeWo3TFAyTEZmQUd4UllVUkg3TGNMQlNLUHE2?=
 =?utf-8?B?Zjl0bXk3WU14TlJpT25SME1OQzhWSytSaHNVeHc5RlhwY0NQZTlxZmtCbG10?=
 =?utf-8?B?aDNQLzY2VTNJSFRydm9sK2xzQzV2dVYvUERGUnN2U1RoaVpZNy9neldrUW4r?=
 =?utf-8?B?K2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51389607-668d-4d59-8f6d-08dd2ba6d707
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2025 03:29:32.8425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0huhAdyADxLChxMtIsk/4QdiVDNuOs1/3rClKpmsEtVwSY1e8dKPT9E86iMRBQOHCE6Pg6TLejffaD6uTCHQQfV69Z+hTFYG/jUIj6RhJxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8108

SGkgVGltLCANCg0KPiANCj4gQXJ1biwNCj4gDQo+IENhbiB5b3UgY29uZmlybSB0aGF0IHByaW9y
IHRvIGNvbW1pdCAzMzFkNjRmNzUyYmIgKCJuZXQ6IGRzYToNCj4gbWljcm9jaGlwOiBhZGQgdGhl
IGVuYWJsZV9zdHBfYWRkciBwb2ludGVyIGluIGtzel9kZXZfb3BzIikgdGhhdCBwYWNrZXRzIGlu
IHRoZSBicmlkZ2UgZ3JvdXAgd2VyZSBiZWluZyBmb3J3YXJkZWQgdG8gYWxsIHBvcnRzIGFuZA0K
PiB0aGF0IHRoZSBpbnRlbnRpb24gb2YgdGhlIHBhdGNoIHdhcyB0byBsaW1pdCB0aGVtIHRvIG9u
bHkgZ28gdG8gJ29ubHknIHRoZSBjcHUgcG9ydD8NCg0KQnkgRGVmYXVsdCwgSW4gdGhlIHJlc2Vy
dmVkIG11bHRpY2FzdCB0YWJsZSwgdGhlIGZvcndhcmRpbmcgcG9ydCBmb3IgdGhlIG1hYyBhZGRy
ZXNzIDAxOjgwOkMyOjAwOjAwOjAwIChCUERVIE1hYyBhZGRyZXNzKSBpcyAxMGguIEl0IG1lYW5z
LCB0aGUgU1RQIEJQRFUgcGFja2V0IHdpbGwgYmUgZm9yd2FyZGVkIHRvIFBvcnQgNS4gSG93ZXZl
ciwgdGhlIENQVSBwb3J0IHZhcmllcyBkZXBlbmRpbmcgb24gdGhlIGJvYXJkIHNjaGVtYXRpY3Mu
IEhlbmNlIHRvIGZpeCB0aGlzLCBmb3J3YXJkaW5nIHBvcnQgbmVlZHMgdG8gY2hhbmdlZCBpbiBy
ZXNlcnZlZCBtdWx0aWNhc3QgdGFibGUuIA0KDQpQcm9jZWR1cmUgZm9yIHVwZGF0aW5nIE92ZXJy
aWRlIGJpdDoNCi0gIDB4MDQyNCA9IDB4ODAwMF8wMDAwIHwgZGV2LT5jcHVfcG9ydC4gKDB4MTAg
Zm9yIGxhbjkzNzAgYW5kIDB4MjAgZm9yIGxhbjkzNzQpDQotICAweDQxYyAgID0gMHgwMDAwXzAw
ODUgKHdyaXRlLCByZXNlcnZlZCBtdWx0aWNhc3QgdGFibGUgYW5kIHN0YXJ0LiBUYWJsZSBJbmRl
eCBpcyAwIHdoaWNoIGlzIHRoZSBpbmRleCBmb3IgQlBEVSBwYWNrZXQgMDE6ODA6YzI6MDA6MDA6
MDApDQotIDB4NDFjID0gd2FpdCB0aWxsIHN0YXJ0IGJpdCBpcyBjbGVhcmVkLg0KICANCkxldCBt
ZSBrbm93LCBpZiB5b3UgbmVlZCBhbnkgbW9yZSBpbmZvcm1hdGlvbi4gDQoNCj4gDQo+IERvIHlv
dSBoYXZlIGFueSBjb21tZW50cyBvbiB0aGlzIHBhdGNoIHdpdGggcmVnYXJkcyB0byBob3cgdGhl
IG90aGVyIHBhY2tldCBncm91cHMgc2hvdWxkIGJlIGNvbmZpZ3VyZWQ/DQo+IA0KPiBCZXN0IFJl
Z2FyZHMsDQo+IA0KPiBUaW0NCg==

