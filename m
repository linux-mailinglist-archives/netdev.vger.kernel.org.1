Return-Path: <netdev+bounces-266807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JLUOG3wFsmnXHwAAu9opvQ
	(envelope-from <netdev+bounces-266807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:14:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E826B8C2
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 01:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20207306375C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C732741DF;
	Thu, 12 Mar 2026 00:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2/r3idtM"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010039.outbound.protection.outlook.com [52.101.56.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6F1FB1;
	Thu, 12 Mar 2026 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274489; cv=fail; b=BzjedY8g1DlGSeRJq3vxVZYGI9jKrWbTBHico1ue6NPKhG3m3OWL1jfjsvnqtLStwTXSKQdHlRMuiQ/JxJPpzUmxrhGhusLQXQhYhDSAY+1LnDF+qWRq2CITEvVuEpEHkS1Hw40O+uwWU6iGRTzdqikcXJ6GV06TUZHUz7pWvVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274489; c=relaxed/simple;
	bh=ZwbPa8BV3A87J+E8hne0lsy8g3ciRl/ddUQdf1JV//w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl8eKUFAJAcAhJwapprrIfNrD7S+CJQlyVrmvm9s0rDEysPvOyYBZtkIulUz5IrYojPdc0KlzPM/O1Iy95eZYV9Rh/B5ZP1NvWUOaAYdXtUn2ERot3qv3afPPSF3qFF0iLizL0GOQt1o3xyYvDFtaCWpFYWqRB/KtTNXmTcJxeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2/r3idtM; arc=fail smtp.client-ip=52.101.56.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltayT1eXCz2ygL8pzFX53hEBSJ8HcZPgBEnuznwT3YVQ8RtJWggFHSPEShFPEdVWE4fdHkjJwW6nTcmjlwbrxZAVgT0HaDbu8V3Vee8BviNb8ZGL26mlm+W8aebXSDqtm2pAak+JvW4dC+AfSeiUn0UAV/HRi8cz084ialHNpgPv3pBtQ7xkTGrWnSVMd8qzd2dWhpNHlAEDcARDuZ2qWrHBpu0s0nkV79ir8ePSSeK/AUntlxWX8dFc6IDI3+jhIQz2ojXv47jAS7lJKHfeUfit41jKEd6JApZVSGu3YGIHTyRfvgYdJQ3PBJhIEvWmSw4vMfGEjLj/hQ9wsqYkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwbPa8BV3A87J+E8hne0lsy8g3ciRl/ddUQdf1JV//w=;
 b=Bwfhx8aUgtgnjJDFvaR8cxFiTCVn5vAYZkGSyZyCBrQ25A9JcwT1/35tQAJyDbZCNnMF0L7hsxrnfbehigypoOiLZ/ascxJegLwGCV/4hwZ7Zul1S62m4s2djWWirNmqqioFTgS2dm+Ys0EYCkiDWeZS4nPTgH8zJ+df3KUtFIzuQMD4eNropEu2QKBiy0qkATtO5qd+vWywBuZnFsFOn9JyxDSsyteObZJc80jjUanAjOmvuNMYaRnYqyHRlGRFBIyWa0mFiWNI37U4n7SX9z7/FuF+nmMNNlLcVuttTKRGj67ilVI97pW6QHQmuOILl8ZXgRv/aZWRNifpXqOcKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwbPa8BV3A87J+E8hne0lsy8g3ciRl/ddUQdf1JV//w=;
 b=2/r3idtMdTQIdCgXZZXj0eqWsj+PiDfJ1bjLaUDuYw+lkqHbRz2KywkNrLhpQjRMjXRVbhWlgWqq+IJJ/6CLEXm24YYk+cU8SxcNwd+ECsv8AbIXUbFYMdvqkXxZU5jPZmDhxFnLN9AnDXZLKiDMtSwl3PoxAqYcqXXb6w45FPAg+JvGZ53CY4K7tX+3EtdMUV1aEqfUajASP/1+XQl5K7NKMQXh1RVlOgF2LZkIJBhdFnG5pWb+LP2iDNdMFZPB/C8snDmkkIuCO8miU2gC/HrS7sQW3bNMbv+cjHt69DJViwHNA6Dw4vhnvXUm2pYk/CJAJm1lVETzyw6HzXmOZQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Thu, 12 Mar 2026 00:14:40 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::caa6:2f2c:cd5f:90d9%4]) with mapi id 15.20.9723.000; Thu, 12 Mar 2026
 00:14:40 +0000
From: <Tristram.Ha@microchip.com>
To: <bastien.curutchet@bootlin.com>, <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
	<horms@kernel.org>, <pascal.eberhard@se.com>, <miquel.raynal@bootlin.com>,
	<thomas.petazzoni@bootlin.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <maxime.chevallier@bootlin.com>
Subject: RE: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Topic: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
Thread-Index:
 AQHcq8BZxyCiqHlsBEeDQ14VW7yu3LWftUwAgAAtaoCAAANygIAAH+SAgACs27CABX1SAIAAhfyAgAJuqICAAB8cAIAAEK4AgAAReQCAADL0AIAAeQwg
Date: Thu, 12 Mar 2026 00:14:40 +0000
Message-ID:
 <DM3PR11MB87361761E911D6EAA0311DF2EC44A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
 <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
 <20260311135610.oox5ahxcyvxkuegw@skbuf>
 <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
In-Reply-To: <c9c990b2-0fe3-4329-9a1a-e29aa0c9a6a6@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|PH8PR11MB7045:EE_
x-ms-office365-filtering-correlation-id: 4ea01de5-0295-49b8-30f2-08de7fcc5ab9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 rAXug7boQYAbSWCBaFN7Cd47S7FmSX2zBKg+7IvVFCNEpjCT6P0OBHK+iioUWTwMX+BdKpzkmwK7hLje3G6b+7D0Zgl1Oq3aTPDMPdaxzQELniFeoIaVuGJBMtVh7aWx85RIHAU/c1nq+NXbpNoI27mmcsR1c3POFpI4WtwqB5MbJAjuKJJe3lKSm8C5mYA1fXpAkY6vPMjNBHps3yZG+X+zZu3xldd7YCHyvtXDBW566SJkE8SJMUu3RJ75jC3Qk/0I+O2rNfsPItBIZ8PyUWjiz8dfSOsGuosRMbbb8M5FmB7p0rLRCNlWH75XwtImMp6LyfUJvExfISRsnN7H+kTM5qnC7yIAd1SFVKxH+JDGxJ/H1RreJ+Wnfm3+eUaSMU1Kbf8OF/s+GXdAoIOCubr4AUFWrezKemrQUFI+/qpCPbHMNFMRYoSzfmWitDh437iu+Uz7lq04Ah5MJnx4Ke5e6U/JeX6gqI9lIvOW+znman0yATFwKSjpShPy0HvlZt+Tk0KlF3/HEn4XgnD66F3i4LG6IhryafP+uLMGw8mOr8H0yfkt7gJ0nH9eh8r5f40Yt++UGVufIlV4wsEIhpwyXXrRRMaOSqC1NehFnuVNrIPUL84j5uX7b9g4FXBbLJKzpIc7Hg5C8YQ1J88hnKUwcdyRI44v5fnmRkEuyDq/9/czAJ8D1kf/9pZViVKAaP4q/qdIrjcP407t/0umFzREQuWaG+pPzKD8Yd0CZx1VXDpR4crpwQeVfHKjtycZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RitpTXI2Vnp6V1RxekVKZW1KY2lxVWJKcDBlMWVRU3BnU0p3bnVMZEpHaTNj?=
 =?utf-8?B?THozbVJCWEt1QlIrN1pDL2ZOcC9uK252Y3ZySXJqNkk4R253aGNsZWtGWnBi?=
 =?utf-8?B?NFA2NEh2bEgyYVFCd0orWTF6V3ExOFhXRHZ1aVBUODNraFk0K2h4VUhOdWF1?=
 =?utf-8?B?WEw3NUtEeUJzcEF3ZGRURFJ4VlBIejhsU2pFOCtlMG5IWkdmNEpiRWpyQVZT?=
 =?utf-8?B?bmhiUkRmSXZicWJTK1M2YUNJQk0yODJNeTdMcFZpS25FV0tVTU4rNXE5cVU2?=
 =?utf-8?B?M2ViV0grR3pTYUhxeWcvZHVFajRONzhyRWovRloyb2RFRUF0ZlhwYnU0R041?=
 =?utf-8?B?RVJIQVkzS01sK1NDd1I3aUZBZDZXcU5rbDR1MHJRMWg4NjMzUWprZlZ3Zy85?=
 =?utf-8?B?bGlkWHNJYUluSWRlUk9QMmYxTXpQQU9kaVVybEgvVC9mVnVRb2FRNXEyMXhP?=
 =?utf-8?B?c25yNkNhZUptaldLQyt3czRFWjVjTHI4MkdVbE42TFE5ZU5rZzFYdjNyYUwy?=
 =?utf-8?B?ZHhDUHJqMTJ4bWl0Wkw4TXV1YVJ3RHcyckhORnI5Slg5enVoUFcybGpJeG5p?=
 =?utf-8?B?bVU0NG02eDZIWGxndHlnd0JnZ2VJbHl0eExBRS9pQUtpMUYwSnZ4MlgxU3Rx?=
 =?utf-8?B?VnErSFArcE9LVnF0S0FSRmNtWThLMks1TU5GQmRCUzlDbkNsYjlWN0pVWlBl?=
 =?utf-8?B?SGdCNldWNldKVlJnNEZMQWdGeGl2cDlxL1lJRTg0Zm1RN2ZEdWNGd0YzTC84?=
 =?utf-8?B?T2wxL3Rqbm9LSE11SUdIdkFkbU5wUi9ZQWxLaEFpT09PMXhJNFI2QStjdmY4?=
 =?utf-8?B?VllmR0NpMXpnRTQ1NWwrU0I2bTFyME9MVHF4WXp1ZnJXeUF3SnNPQnBRSHNW?=
 =?utf-8?B?REVYVmpORkJ4SEY1Nkd3MGNqT3BJY1A5cjVlVVA3Y2l6cFJyU1BMZ1VvUG92?=
 =?utf-8?B?UWcrSGJpVlpaWG1KZ3RGNFloOEZ0YnJoeHhBcU0xUFBnMmRpUUdyaXU1RDZ3?=
 =?utf-8?B?ZlZUT01hL2FCeXBDb0VnOWZ6UTViU0hNWjNsZ0lYS1p4clRlQ2JuNmxRWlYy?=
 =?utf-8?B?bWFUUjhEcG9mZWxhVnlVSlNWblR0a21JblBlaVZ6OE81QVV4R0JqYTVCMDJV?=
 =?utf-8?B?ejd0cGdHSjNjUnpaYWNVbnhuUmpCUVFiazVvZ2FCU1FvNXFKc09yUmZWRzlo?=
 =?utf-8?B?M25HRG5OK0w5U1Z2QlNUUXFFV0VXR2hMemxML01jc2pZcUlBc1BndSsrUVR2?=
 =?utf-8?B?Q1lyNGRtdzFyZDBYSnlIaHBXT2dpSXovUU1iTEFPc1gzYkJTZVJUK0pBaWhU?=
 =?utf-8?B?aHNmRC9ObE5EaEVXejBMbkFyblFrLzQwUURMQk1xR3g4WTVIY3o2NUZpUVB1?=
 =?utf-8?B?MmtqSWJtaUg4TDQvK2JPVzd5WmRXLzBCOERWcHU2M3V6ZkZvTkpTc2VvQ0w1?=
 =?utf-8?B?WkI3emZWWGc4RExUVFBHeXJseWRDYit3Z2QyZlNpQlhuejNJQ21YQ2EyeVJ2?=
 =?utf-8?B?SEU0YWtDbDVyY1dsallSbmNFK2pTWnZFdlNzTzVSOEJJbWRQdmFhUnhDZm1H?=
 =?utf-8?B?Y0hRNS9DQndNSXdheVI5R3FkTmVsU3A5N3pBV0xFUmMyK3dtdExkdDFKZUlo?=
 =?utf-8?B?Q2lkNXI2SzdjOWoxMTc4c1NwRG9EY3NSMXlBQWNzOURvNXAyMWFwRUwwcmZ6?=
 =?utf-8?B?ekJuVzdxN2E5c2xuYksyRDBuMUxXZlQxbnRnRUFUblo0NnU4T2M0QU9nUTE1?=
 =?utf-8?B?ZFArakd2aXZoMG1UVXZ5R0ZOcGZsWndoRjNLaEtBSktReXI3VnBVeDNDUzBn?=
 =?utf-8?B?N3RVemVXRGd1a25lVzYyUTZKQkVZTkdmOEN6YmV1NmdlaE05VzVqV005SkR4?=
 =?utf-8?B?Q3I0NUZnZ0JhRENSYlcyY2N1dnI3cEtTT0dSeEhWMWFRaU9hSmMySFNGZWZj?=
 =?utf-8?B?VTNxSTVjd1VkRzhmM2pyc09RT3NSSmRnVyt1OUZkQkgrZFhPc0NFd2ZiS1Bq?=
 =?utf-8?B?Nml6M0UyODRJRlNpZnlvRmpSUWJBY3lLcklpRklVL0hobHdKRVBPNWlnZWdZ?=
 =?utf-8?B?S05KdmppYkQyR01kaUpqTWpLZWNNSUZxcnVEUkNtdnoxVXFkQkpJZ1VjVXps?=
 =?utf-8?B?SWpIWGdMdXhwOWtsa2lBL09jTUp1dTlFT0MyUm5xWThoSDhQMXNVWG9Vbzkz?=
 =?utf-8?B?MG1ud1hHQTNhbnJOV3B3a3pad0RDeWNqalhlQkpXRXgxYUQ2OU1ObmVZQ2Qw?=
 =?utf-8?B?WmFxdi9SYUZTZGgzOC9tb2drYUtiRzFGaDBwYkJlNW9FWU8rQXErYTlwaDJY?=
 =?utf-8?B?VWJHb2ZBWUJ3eTVUQXdHeEdiN3hDYzBabSt0b0ZXQ25tc2NQOFdpQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea01de5-0295-49b8-30f2-08de7fcc5ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 00:14:40.4701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRVSXfnmI9JbJIhuzOZX0NmP1qAd57AnyS4iXgu1nr4cpzrs313f05HJzen1TjerQ2V+9XwSCVe9WhQeI5ceH3VXjgM9BHTh6MMjMvdcivw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266807-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	FREEMAIL_TO(0.00)[bootlin.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[Tristram.Ha@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:url]
X-Rspamd-Queue-Id: 973E826B8C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBPbiAzLzExLzI2IDI6NTYgUE0sIFZsYWRpbWlyIE9sdGVhbiB3cm90ZToNCj4gPiBPbiBXZWQs
IE1hciAxMSwgMjAyNiBhdCAwMTo1MzozOFBNICswMTAwLCBCYXN0aWVuIEN1cnV0Y2hldCB3cm90
ZToNCj4gPj4gT24gMy8xMS8yNiAxMjo1MyBQTSwgVmxhZGltaXIgT2x0ZWFuIHdyb3RlOg0KPiA+
Pj4gT24gV2VkLCBNYXIgMTEsIDIwMjYgYXQgMTE6MDI6MzVBTSArMDEwMCwgQmFzdGllbiBDdXJ1
dGNoZXQgd3JvdGU6DQo+ID4+Pj4gSSwgbW9yZSBvciBsZXNzLCBtYW5hZ2VkIHRvIGZpdCB0aGlz
IFBUUCBzdXBwb3J0IGluIHRoZSBjdXJyZW50IGZyYW1ld29yaywNCj4gPj4+PiBidXQgdGhlIG5l
eHQgc2VyaWVzIEkgcHJlcGFyZWQgdG8gYWRkIHBlcmlvZGljIG91dHB1dCBzdXBwb3J0IGlzIGZ1
bGwgb2YNCj4gPj4+PiBpc19rc3o4NDYzKCkgYnJhbmNoZXMuIFNvIEkgdGhpbmsgdGhhdCBJJ2xs
IGdvIHdpdGggd2hhdCB5b3Ugc3VnZ2VzdGVkIGFuZA0KPiA+Pj4+IHRyeSB0byBtb3ZlIHRoZSBL
U1o4NDYzIHN1cHBvcnQgaW4gdGhlIGtzejg5OTUuYyBkcml2ZXIuIEl0IHdpbGwgcHJvYmFibHkg
YmUNCj4gPj4+PiBjbGVhbmVyIHRoaXMgd2F5Lg0KPiA+Pj4+DQo+ID4+Pj4gVEJIIEknbSBhIGJp
dCBsb3N0IHdpdGggYWxsIHRoZXNlIEtTWiB2YXJpYW50cyBidXQgSUlVQyBLU1o4NDYzIGFuZCBL
U1o4OTk1DQo+ID4+Pj4gYm90aCBiZWxvbmcgdG8gdGhlICdvbGQgZ2VuZXJhdGlvbicgb2YgdGhl
IGhhcmR3YXJlLiBNYXliZSBhIGdvb2Qgc3BsaXQNCj4gPj4+PiB3b3VsZCBiZSB0byBoYXZlIHRo
ZXNlIG9sZCBzd2l0Y2hlcyBpbiB0aGUga3N6ODk5NS5jIGRyaXZlciBhbmQga2VlcCB0aGUNCj4g
Pj4+PiByZXN0IHVuZGVyIGtzel9jb21tb24gaW5mcmEuDQo+ID4+Pg0KPiA+Pj4gV2FpdCwgdG8g
bWFrZSBzdXJlIEkgdW5kZXJzdGFuZCwgeW91IHNhaWQgeW91J3JlIGdvaW5nIHRvIHJlYmFzZSB0
aGlzDQo+ID4+PiBzZXJpZXMgb250byB0aGUga3N6ODk5NSBkcml2ZXI/DQo+ID4+DQo+ID4+IFdl
bGwgSSdsbCBmaXJzdCBhZGQgYmFzaWMgc3VwcG9ydCBmb3IgdGhlIEtTWjg0NjMgaW4gdGhlIGtz
ejg5OTUgZHJpdmVyIGFuZA0KPiA+PiB0aGVuIGFkZCBpbnRlcnJ1cHQgYW5kIFBUUCBzdXBwb3J0
IG9uIHRvcCBvZiBpdCB5ZXMuIERpZCBJIG1pc3VuZGVyc3RhbmQNCj4gPj4geW91J3JlIHN1Z2dl
c3Rpb24gPw0KPiA+DQo+ID4gSWYgd2UncmUgc3BsaXR0aW5nIGRyaXZlcnMsIEkgd291bGQgbGlr
ZSB0byBzZWUgdGhlbSBncm91cGVkIGJ5IGFjdHVhbCBzaW1pbGFyaXR5LA0KPiA+IHNvIGFzIHRv
IG5vdCByZXBlYXQgdGhlIHNhbWUgbWlzdGFrZXMuDQo+ID4NCj4gPiBJIHRvb2sgYSByYW5kb20g
ZmVhdHVyZSwgdXNlciBwb3J0IHNlcGFyYXRpb24sIGFuZCBJJ20gY29tcGFyaW5nIGhvdyBMaW51
cw0KPiA+IGltcGxlbWVudGVkIGl0IGluIGtzejg5OTU6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbmV0ZGV2LzIwMjYwMjE5LWtzODk5NS1maXh1cHMtdjMtNS0NCj4gYTdmYzYzZmUxOTE2
QGtlcm5lbC5vcmcvDQo+ID4gdnMgdGhlIHJlZ2lzdGVyIG1hcCBmcm9tIEtTWjg0NjM6DQo+ID4g
aHR0cHM6Ly93d3cubWljcm9jaGlwLmNvbS9lbi11cy9wcm9kdWN0L2tzejg0NjMjRG9jdW1lbnRh
dGlvbg0KPiA+DQo+IA0KPiBJIHRvb2sgYSBsb29rIGF0IHRoZSByZWdpc3RlciBtYXBzIGZyb20g
Ym90aCBkYXRhc2hlZXRzLiBSZWdpc3RlcnMNCj4gYXJlbid0IGFsd2F5cyBhdCB0aGUgc2FtZSBh
ZGRyZXNzIGFuZCBzb21lIGJpdHMgZGlmZmVyIGhlcmUgYW5kIHRoZXJlDQo+IGJ1dCBmb2xsb3dp
bmcgYXJlYXMgbG9vayB2ZXJ5IHNpbWlsYXI6DQo+IC0gZ2xvYmFsIGNvbnRyb2wNCj4gLSBwb3J0
IGNvbnRyb2wNCj4gLSBUT1MgcHJpb3JpdHkNCj4gLSBNQUMgYWRkcmVzcyBjb25maWcNCj4gLSBJ
bmRpcmVjdCBhY2Nlc3MNCj4gLSBEYXRhIHJhdGUgbGltaXQNCj4gDQo+ID4gQXBhcnQgZnJvbSBz
b21lIGZ1bmt5IG5hbWluZyBkaWZmZXJlbmNlcyAoS1M4OTk1X1JFR19QQzEgY29ycmVzcG9uZHMg
dG8NCj4gPiAiUE9SVCAxIENPTlRST0wgUkVHSVNURVIgMiIpLCBpdCBzaG91bGQgYmUgcHJldHR5
IHNpbWlsYXIsIHJpZ2h0PyBEbyB5b3UNCj4gPiBzZWUgc29tZSBkaWZmZXJlbmNlcyByZXF1aXJp
bmcgbWFqb3Igc3VyZ2VyeSBpbiBrczg5OTU/DQo+ID4NCj4gDQo+IFRoZSBiaWdnZXN0IGRpZmZl
cmVuY2UgSSBzZWUgaXMgdGhlIHdheSBLU1o4NDYzIGFjY2Vzc2VzIHRoZSByZWdpc3RlcnMNCj4g
dGhyb3VnaCBTUEkuIEl0IHVzZXMgYnl0ZSBlbmFibGUgYml0cyBpbiB0aGUgY29tbWFuZCB3b3Jk
IHRoYXQgZG9uJ3QNCj4gZXhpc3Qgb24gdGhlIG90aGVyIHN3aXRjaGVzLg0KPiANCj4gPiBBcGFy
dCBmcm9tIHRoZSBvYnZpb3VzIGluY29tcGxldGVuZXNzLCBvZiBjb3Vyc2UuIFRoYXQgZHJpdmVy
IGN1cnJlbnRseQ0KPiA+IHJlcG9ydHMgRFNBX1RBR19QUk9UT19OT05FLiBJdCB3aWxsIGhhdmUg
dG8gcmV0dXJuDQo+IERTQV9UQUdfUFJPVE9fS1M4OTk1DQo+ID4gZm9yIGtzODk5NToNCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyNjAxMDcta3M4OTk1LWRzYS10YWdnaW5n
LXYxLTEtDQo+IDFhOTI4MzJjMTU0MEBrZXJuZWwub3JnLw0KPiA+IGFuZCBEU0FfVEFHX1BST1RP
X0tTWjk4OTMgZm9yIHlvdXIgS1NaODQ2My4gUmlnaHQ/DQo+IA0KPiBZZXMuDQo+IA0KPiBJbiB0
aGUgZW5kLCBpdCBmZWVscyBPSyB0byBtZSB0byBtaWdyYXRlIEtTWjg0NjMgaW50byBrc3o4ODYz
LmMgYnV0IGl0J3MNCj4gaGFyZCB0byBrbm93IGZvciBzdXJlIGJlZm9yZSBhY3R1YWxseSBkb2lu
ZyBpdC4NCg0KSSBqdXN0IHRyaWVkIHRoZSBrczg5OTUgZHJpdmVyIGFuZCBJIGRvIG5vdCB0aGlu
ayBpdCBpcyByZWFkeSB0byBkbyBtYWpvcg0KRFNBIG9wZXJhdGlvbi4gIEFjdHVhbGx5IEkgY291
bGQgbm90IG1ha2UgaXQgd29yayBpZiBJIHJlZ2lzdGVyZWQgaXQgYXMgYQ0KRFNBIHN3aXRjaC4g
IERTQSBjb3VsZCBub3QgcmVnaXN0ZXIgdGhlIHN3aXRjaCBQSFkuICBJZiBJIHJlbW92ZWQgdGhl
IHBvcnQNCmluZm9ybWF0aW9uIGluIHRoZSBkZXZpY2UgdHJlZSB0aGVyZSB3YXMgbm8gZXJyb3Ig
bWVzc2FnZSBidXQgc3RpbGwgdGhlDQpNQUMgY291bGQgbm90IHNlbmQgb3V0IGFueXRoaW5nLiAg
SWYgSSBza2lwcGVkIHRoZSByZWdpc3RyYXRpb24gYXQgbGVhc3QNCnRoZSBNQUMgY2FuIGNvbW11
bmljYXRlLg0KDQpUaGUgZHJpdmVyIGlzIHVzaW5nIERTQV9UQUdfUFJPVE9fTk9ORSBzbyB0aGVy
ZSBpcyBubyB0YWdnaW5nIGludm9sdmVkLg0KQnV0IHRoZW4gSSBkbyBub3Qga25vdyBob3cgdG8g
ZGVmaW5lIHRoZSBkZXZpY2UgdHJlZSBmb3IgdGhlIERTQSB0byBjaGFuZ2UNCnRoZSBTVFAgc3Rh
dGUgb2YgZWFjaCBwb3J0IHRvIGFsbG93IGNvbW11bmljYXRpb24uDQoNClRoZSBwcmltYXJ5IHB1
cnBvc2Ugb2YgdGhpcyBkcml2ZXIgaW4gdGhlIG9sZCB0aW1lIHdhcyB0byBlbmFibGUgdGhlDQpz
d2l0Y2ggYXMgdGhlIGhhcmR3YXJlIGRlZmF1bHQgaXMgZGlzYWJsZWQuDQoNCkV2ZW4gdGhvdWdo
IEtTWjg3OTUgd2FzIGFkZGVkIHRvIHRoaXMgZHJpdmVyIGl0cyByZWdpc3RlciBzZXQgaXMgbm90
IGENCmNvbXBsZXRlIG1hdGNoIHRvIEtTWjg4OTUuICBTbyBzb21lIGZ1bmN0aW9ucyBtYXkgbm90
IHdvcmsgY29ycmVjdGx5IGxpa2UNCnRoZSBjaGFuZ2VfbXR1IG9uZS4gIEFuZCBJIGRvIG5vdCB0
aGluayBLU1o4NDYzL0tTWjg4NjMgY2FuIHdvcmsgYXQgYWxsLg0KDQpTaW5jZSB3ZSBoYXZlIGEg
d29ya2luZyBLU1o4NDYzIFBUUCBkcml2ZXIgd2Ugc2hvdWxkIHN0aWNrIHdpdGggdGhlDQpNaWNy
b2NoaXAgS1NaIERTQSBtb2RlbCBhbmQgd29yayBmcm9tIHRoZXJlLg0KDQpPdXQgb2YgdG9waWMg
SSBmb3VuZCB0aGF0IHRoZSBOQU5EIGRyaXZlciBpcyBub3Qgc3RhcnRlZCBpbiB0aGUgbmV3IDcu
MA0Ka2VybmVsIHdoaWxlIDYuMTkgaXMgc3RpbGwgb2theS4gIEkgZG8gbm90IHRoaW5rIHRoZXJl
IGlzIGEgbWFqb3Igb3ZlcmhhdWwNCmluIHRoYXQgYXJlYSwgYW5kIHRoZSBBdG1lbCBOQU5EIGRy
aXZlciBjb2RlIGlzIGFib3V0IHRoZSBzYW1lLiAgSSB0aG91Z2h0DQp0aGUgZGV2aWNlIG5hbWUg
bWF5IGJlIGNoYW5nZWQgc28gdGhlIHJpZ2h0IGRyaXZlciBpcyBub3QgcGlja2VkIHVwLCBidXQN
CnVzaW5nIHRoZSBkZXZpY2UgdHJlZSBpbiB0aGUgNy4wIGtlcm5lbCBzdGlsbCBkb2VzIG5vdCB3
b3JrLg0KDQo=

