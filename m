Return-Path: <netdev+bounces-247332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77525CF79AA
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 10:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F0EE3112735
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2663148DD;
	Tue,  6 Jan 2026 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="ZL26pxpl"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011030.outbound.protection.outlook.com [52.101.65.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2802314B94;
	Tue,  6 Jan 2026 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692495; cv=fail; b=a7fA66vMldphaYDnsG3H/ngXx34qKpfgadDB1WQTj4TtuqYX7wfr8JTbA+EDyKCfpq4dlJsIkJgNQZDEQ1NqP8guwnpDq5ObCEFmhlQ0rlH06LTZUK3HPDL/9vMICGZ07IUhH7F/AUqHS/tKvIESmjdV+z6sWCnszyWp4LE+06s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692495; c=relaxed/simple;
	bh=StXiZpJy2V1cZEfoRkypTJW2nzZnariTZTUHK1uHZxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M2apkJYMfmXX8514VLw5NDk3ekILZ6JIUeDcPWOLADvxPGTS/KAqUGtCcEerq2bfdmrM1rci9zOL5PHJ+lLnnDh7QexQKZu4DVoJVQvUBmbZMoXTd/fMwyojQN9B3PjEiQbaDN64NfCnE6ZuYERckTdSn9j2K+o7iuVTgnzMkzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=ZL26pxpl; arc=fail smtp.client-ip=52.101.65.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3NgdXr2LxjhDbk0DPNq/w+K0ZsNgl2suLD5iJkvgBgU1Y5SHQjuHgiJqBI8s6/1ng4NlI0UJXuMoaoKZA3xklkkXZD9ep5cOn177nfygfJc6FoMEwlIR35VB4ZOr2yvQxZvo1UOY8t7TI5di0oMAFTwj2XFAmYwLZq8smSzIo4Q72MlYrvjPaze9iphREG/c9oqPypQsXzn2lxSO6YTc5eVSE22/kLLNo52PMKZUiifsAAxh1hgK4bG2R5mUc3/dUavUFIe1WHSMN1EEvm8WOzIlmuoqOB69F92Jim8bMh/06srfuOU66reh7456PleMbCamuG4S4boChwzvzHWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StXiZpJy2V1cZEfoRkypTJW2nzZnariTZTUHK1uHZxM=;
 b=twnQUrxl2BgseO8ElstufO9D8vsQyuWcuC0o5eBCoEEWU5bOJwoLGoINUf8PPSvEVrAuFgilt3ECfotDacVTj/oBK2mEamakbTgaoxCOyWmLjnUb1rAIOFklCRIQDVsXeZ8Ej/FnukTUcmGcokPdgFGHzdvOMnKjLkUtZ9omXl5qsvJ0+7h34NoCSXSHzuOvwygiVKPsQMCQagipxAPSOhpocZ84IF/Sk3pDuFO3TjLSXKJAzhmpn/u8/NHiORnU6CVQpRGegZ2qCxc7ObB7XT/ZZWS0GagLy+x8ObkJfHk7jRmDwFldJf1v1TgygAvtzkMUuPBPZdHyyuoESbUp0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StXiZpJy2V1cZEfoRkypTJW2nzZnariTZTUHK1uHZxM=;
 b=ZL26pxplwFYSaq11ZAxk+DtHygA+lmZANZDfsC8Jmxovpg0aybIsApNVFd8NjffwmEhdIuZTA9xEDwzF0Pbltr2jxboE1ARGVg0u6Cy7AzVQsFy2REJdj/NEH1KqpDX7vMFJ3a0LCp5Seq5e4Cd2ovb2xyOc/pJPkunnQZZrDYPvRpoVTrgEfjnS+DC16LXBy2ZJ2ffLNqMVQcGwhYZfExTZqrdZEth9DeUrQExdQzj1qUgpgY57UCerZ1T3RtVYY9U2AS9DitfKS83bb6ZOIro8PF0ZEnSrBXP5nQI54RcB3YJZTfQhlEQoVCcRCDAYOefqxfI8mo3KtNDYXTN0jA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 09:41:13 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%3]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 09:41:13 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "robh@kernel.org" <robh@kernel.org>, "olteanv@gmail.com"
	<olteanv@gmail.com>
CC: "hauke@hauke-m.de" <hauke@hauke-m.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"daniel@makrotopia.org" <daniel@makrotopia.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Thread-Topic: [PATCH v3 2/2] net: dsa: mxl-gsw1xx: Support R(G)MII slew rate
 configuration
Thread-Index: AQHcfmxQUwNwEKdFfEaLvWt7wIFuxrVD9pcAgAAZMQCAANSQgA==
Date: Tue, 6 Jan 2026 09:41:13 +0000
Message-ID: <5cd460761e5b163ac2c5c5af859a53a9ad76d3ba.camel@siemens.com>
References: <20260105175320.2141753-1-alexander.sverdlin@siemens.com>
		 <20260105175320.2141753-3-alexander.sverdlin@siemens.com>
		 <20260105193016.jlnsvgavlilhync7@skbuf>
	 <ac648a7e6883e68026f67ae0544b544614006d8f.camel@siemens.com>
In-Reply-To: <ac648a7e6883e68026f67ae0544b544614006d8f.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3557:EE_
x-ms-office365-filtering-correlation-id: a0b79308-c0db-4b73-340f-08de4d07bb5e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDJQb084eVdjWXhtZndZYnNseXRMWit4cXZrWGhiVXdRRytncktxY3ZoVXhR?=
 =?utf-8?B?TWZCemt3VFJKK21WRWJCZ2JtOU1iR3AxVG9rdGpuU3k3S3JqVTQrL2x5RXVu?=
 =?utf-8?B?NE1sZ3lLU2J3SjlWWVd6anc2NzJYQ09uWnNhTklFaEhxUTZDdUYweEdpWHIr?=
 =?utf-8?B?N2dWeHBnN2lieVNvWlU0UzVlNTBJUitwbHdlSWE0a2dXSFdZZU9rOTdtc2wr?=
 =?utf-8?B?Ri9ZeTl2anRxQktyZG5QOWtBOEY5VnlaUCtOcThDTFBFTzd1VmdycGJUaXRk?=
 =?utf-8?B?OHZaQ3J3TmlxLzcwcE0yVXpIZW9NR1Voamo0Z296N2sxNGJnMUZRcklMNlo3?=
 =?utf-8?B?WityUDMrbDFnUjhZbjJVNjNjMHRDMTRHekFiSHVLUHNtWHppM3BNQWM2NkMy?=
 =?utf-8?B?SUkvVzYyWXhOTTBDYXJEUmpPNFRPSFZBbzZqeWVzTW5rbEcxaHlBMUZFRlJL?=
 =?utf-8?B?YlVsb3FKVTNvVDRJN25rUzJLbzdMRjZwT3N2bEs0dFRaTmtXamtseC8xU2hs?=
 =?utf-8?B?L1BGNmRhZ0tpcUxIWjlTSHJOd3NiaEkxWTdVcjhXRnh2MGZ1a3FMKzJ1dCty?=
 =?utf-8?B?Q1ozVFdVcVg0WnBsQWpSS1h4WDJuSTUyN09SQWdSdGVHVC9lUm1KbVUzMXI2?=
 =?utf-8?B?dGVaVmZ0bHBKNHpnblg0dnc3M0llNnpaSHZJV2lzZW5NdmE2dldkNUZ6WUxO?=
 =?utf-8?B?RHBpWWZMWko4VW1jOUIzb2tCMTFHdUFaS1k3ZldpSTd5QlJ3RzZBdS8wVjdM?=
 =?utf-8?B?am1US2ZiMld4ank5OE40SVVQWnN0QWZlYWQrckR1VTNvVnFHU3BrYVFqdVlm?=
 =?utf-8?B?eGRIOXhwUEp4cTFXK1NMMFAzV1J3WnZIY2w2dUFoeER5cUZyRElJd2J0TTdC?=
 =?utf-8?B?SmlITlVETUxRd2hsZzFYZHBWTUdTWVF3SkM0bEJDRkQ3M0t3KzhpS2lSbFhN?=
 =?utf-8?B?WFJaNkg2VWFGR3o2L0NEVG5WckVLaXVQd05FS25sVEtoN2YxMW5lUER4dmdK?=
 =?utf-8?B?ZDJSa2FOWHNPNVVGSnBycS9jWmtwSkFwNGZGUHA0MmlxV0dMSVFFN3Z1cjNz?=
 =?utf-8?B?Rm1EL2pkUFR6SE9DeHBKT2dBVmNKS3JaWUlVUk41bU1aZ09OcUxYVHhKNHgv?=
 =?utf-8?B?b2NUb3cvL3ZLQU5NYUZ2UE1DM2ZKSDRwUGM3VW1IWkFHRGlETGdvY3Z3WUEv?=
 =?utf-8?B?V2NpVFF1cmV4NERXN0IvYk9pTmRtSkZlSUNLRXpkUU9oVStwZU1teXVQcFB4?=
 =?utf-8?B?K3c2RjBUWTFwT2JubFRNaTJ5L3ZHRlNhOUZIZG5jYUNGWmJwS3N6MFF5c3JB?=
 =?utf-8?B?MHJFUk9kTlJvRGp0QmhxUkFtaWUrS2paZlE3WE5QVWlvUkpuSXRsaFoyWm03?=
 =?utf-8?B?M0hscjhzY3NmZ1BCbHZPdHE1ald5L3FCL0ZQNDhVclFsN1F5dTJtV3ZtaEU0?=
 =?utf-8?B?cEVlMHhmamhSS2ppZTJoeHE0VzlQNE9ubVExdi95V1dIcnhhWTJXREFubnJM?=
 =?utf-8?B?QjVQVEVCNDEvM2tveWxSV1pOd3hyNmdPNDNZajN3L2MxSVNWYVRDcW9mSERx?=
 =?utf-8?B?a3JGVktpUHZiMCsvUzIydzUwM0ZmM0Vycjl2bENub3dWb2Eza1c3cTdMSWdB?=
 =?utf-8?B?OEFjNnN1Q0Z6TzQyWGV4N1VpcFV5YzlYbURQRGhtc1JjYkZZbXozaDI0aFZZ?=
 =?utf-8?B?Mk9jYkpENStzT21PZ1U0NUg4T05GemkrMG53R3lEa2FZMC9ySVFGMG1SUktL?=
 =?utf-8?B?bys2bzArTkVxaWxZd2VtVStZZWc1bE54ZmRsRjVhKzlFMmpxMStzVTROWnQw?=
 =?utf-8?B?Y2F1RzVVTGZPMFJING91WWpWdldDQW1qZWN5c1gzNzBFbzlqdE9WaHlERmJw?=
 =?utf-8?B?UUQwR1RrSjQ1K1R6OWNVSzlrRHhpWElXWFJGTFl2c29MQWdzdWpZYWMzb2ZP?=
 =?utf-8?B?V3ZuSFdsaitBcnB4QnlZb3JDQi9MaEMwYS9lSHRwWXdWUFp6dVkzTVl6bjBl?=
 =?utf-8?B?YWpkZU1XUzlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZVBaYm1WSURTL2gwV2xDeTYvN2owam10N0xUejhwNG1HM0JiOFZudUFWdGJi?=
 =?utf-8?B?ZUNoLzd5OHUvdlBTYjZ1V1BacU05Zi9GTVE5QnkrNmFnYjlzK3Z3aVhwSzRm?=
 =?utf-8?B?WnZRVWt0UTJSMmVGTlo5YVI5bHhQM0k0cEs0a1JNQTFNWG8wb1lJalg2QWJB?=
 =?utf-8?B?N2I0eWMyaWNYS1dhWkcvYTBwNzlkT25ZeHA4cjZqRllvR0FuMjFXbUt3aDNQ?=
 =?utf-8?B?dFJFaU1KMTFVZWVzZlVJY0tGMjhXNnlaM1JkYXI2K0FXdC9KLzJyYTZDcngr?=
 =?utf-8?B?ZDdhTi95eCtJZjZobW5NU29NRmxGSHVHTi9SM2pjOEVyeEZTZGlvRTFFSFBl?=
 =?utf-8?B?T1orOGo2U3UzdVA0Q3c4MjRJQ05CMW5xb1BuZVhCejVyd2tGL2xlenZlSXdx?=
 =?utf-8?B?M1NGaXdHZTUycnFXd3YxUTE4d28vNEl6S2FoNExidG1yN2pSMGVITDVhQXgx?=
 =?utf-8?B?M0VkZHNTWWpvZzh6WnUzanNpSkQ0bGcwR0xsT2lXUDREQXg2MmlXZXBmdWpP?=
 =?utf-8?B?S0NOTG96eitMeWVzMFR2c3dkdjF6c2hYL3Z6d05HYTZha043TjZaQnJkc1d1?=
 =?utf-8?B?VnBiak1CemVEajJqNlJQNUdCai9Vblc3d3MySmVsRGRyYmZIM1pWeVNkYkRv?=
 =?utf-8?B?Q3BCdFJuRW5jMDlFcXpPV2YxVmR0cDFIWm5GZ1hjYXIrbE9IL0J1S3JiWW5X?=
 =?utf-8?B?MDgwakpKV3RkTXFMc3h2NDJqZlRUYXhMVC91U2hLb2puSGRyNEhJdER1enZm?=
 =?utf-8?B?RFA5UVA2cTltTzczTE1QWlI2WVFhdkUvd05IRjZEMlVQUmZaMjRRMnh4SEh5?=
 =?utf-8?B?NEhPRThHN3g0K2c3dWIyOXdCWG1SU3JXakllc0J3U05LYnc3bTJld3V6L0xO?=
 =?utf-8?B?dGVBc05Fa0FIOE5LaVhHMldaRmp1WFZteURjK1ROWHlFLzM4T3V4cjhZZjRo?=
 =?utf-8?B?bnRmYUVURmtEejJpZ0V5Z2pTZ3B6eS96T1hOck9KNnQwbFhONklzRGRXakJX?=
 =?utf-8?B?djliVVZKQ1FLRXlySUdjeGkzSjA3ejlFZzZTOWZnSlRiY2pJMGF4aFg2VEU1?=
 =?utf-8?B?WXQzZG5GUTZrbDFJdFJHK2NXSzJRL2lBTWNmVDNlN3Q4YVNlU2RSZ003YUh1?=
 =?utf-8?B?TnpwTG11cDN2WUJDVzdjS2NycGlxTUJsNHR3S2N6SUZ5eFpWYmZVaWRRQlVH?=
 =?utf-8?B?Nnl5N2NabmRFcm1mUlR0akFuaDdZcUZWZ0pRdGNIbXpJb3FFOWhMeUJ6S2RH?=
 =?utf-8?B?R3JsMkltWU9ZaFlQZHFycjVSc2kyM3V2enVOZWw5ZFNwNHEvU3JPSlpoQjFY?=
 =?utf-8?B?MU5ua3hXODZtVHBkL1RYbTNMaFUwWGM3U2ZuNlFzdzZJL1cvaHFQcVREREVw?=
 =?utf-8?B?S0FxYzlNQXA5S3B3WGJlU3J1eE5sN1RCL2RXWi9QK0ZIMlpYWVR5MWNKdUVW?=
 =?utf-8?B?Z3R6RHRHZFdlWnVFaEp1ck9ES2N3S1BGeVBMek8zTzFsMWJlOTh6alFsTzUz?=
 =?utf-8?B?OHcycjZZOTdiYnVmanY0MDFUZzRZMjNiTlN4TjNuaWt5L0JnWkdEOU0rREhr?=
 =?utf-8?B?VTFoNi93TEtkWHgxV3Y3ck9lajljc2ZQSFFQdTFQZlRnVjQ0R3ptVjdLREtR?=
 =?utf-8?B?eDNuL1puZ3RnM0YxQ203TkYzQnU1bmpZTzV2MklNMURiNEZ3d0ZaMmhEK2xQ?=
 =?utf-8?B?WWlQaXV5dklNVS9SRm9CZ1Z1N1U4ZmFHNHFMVGt3WHJkMzZHNFM2Wm1zbllu?=
 =?utf-8?B?OVZhTGtPS1pPc1dLeVVkZkt5QmNDalQwd2s2UWJEQjQyVW1FOCtUaFlYSzdu?=
 =?utf-8?B?MHZrUjlSWWtRZEI2OEQvcWRnVUtRWU5xYlJ6eXo5WDlqNmxjQ0F6SmY0L1JS?=
 =?utf-8?B?TVAwem9RbmQ0cHc2Z3ozWlJPeXZlNWNJejZMeW5kKzE3SzN2d09ZOHJkTWVx?=
 =?utf-8?B?TjROUkljalZOUGhQM1JxOTkrclpENEg3dzVHSEdydDIzTXVQT3UxWDh2RUVl?=
 =?utf-8?B?aGh2RzFsMlV1dWxKWVF3dEJqdFNraitrZ1lpb0NsUDlpVzM5TXM5dU1hWnNX?=
 =?utf-8?B?OThZdVRVMTcwRU16NmRoZGw4VzlQbkg4YkRQTzhEMzdjelk4QjNUQVV5bXdC?=
 =?utf-8?B?NmZ6YXBaS0YvUk5GWkU5SmkzR3hSaGRZcTBVKzdmSUV1Z3lWL0hWODZ5aVdE?=
 =?utf-8?B?cWt6K21ZMjRyejllZHFSQ3h2UzdYYzl0by9hOVY2WFJSc3l4R3NJbXdzbEtj?=
 =?utf-8?B?dGIzZURsNTR6ZzNmMXJJQ0NKVnNEdndESDduVWFVOVBsS2VUWjArK0JBV25L?=
 =?utf-8?B?SVNXdHVxSWJ0aGlBejJ1NWNMNlREeEFUME5PYTNlRkNGcE91cjg3a2ZVcVhC?=
 =?utf-8?Q?b1eb0MEbXMTvz4I8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F9558AA398FBD45BE6B0D86A695340B@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b79308-c0db-4b73-340f-08de4d07bb5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 09:41:13.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pS7u25t3N/tou0SHnafRIliLONQOETgXFKwy4yYnC2uLSbO7TepSeO+Y1wqKEel8InsTQsrgs+uAdkh8a9gjTlQkg1z7dz7B25bJxsc0/MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3557

SGVsbG8gVmxhZGltaXIsIFJvYiENCg0KT24gTW9uLCAyMDI2LTAxLTA1IGF0IDIyOjAwICswMTAw
LCBBbGV4YW5kZXIgU3ZlcmRsaW4gd3JvdGU6DQo+ID4gPiArCXJldHVybiByZWdtYXBfdXBkYXRl
X2JpdHMoZ3N3MXh4X3ByaXYtPnNoZWxsLCBHU1cxWFhfU0hFTExfUkdNSUlfU0xFV19DRkcsDQo+
ID4gPiArCQkJCcKgIFJHTUlJX1NMRVdfQ0ZHX0RSVl9UWEQgfCBSR01JSV9TTEVXX0NGR19EUlZf
VFhDLA0KPiA+ID4gKwkJCQnCoCAoUkdNSUlfU0xFV19DRkdfRFJWX1RYRCB8IFJHTUlJX1NMRVdf
Q0ZHX0RSVl9UWEMpICogcmF0ZSk7DQo+ID4gDQo+ID4gSSBkb24ndCBoYXZlIGEgcGFydGljdWxh
cmx5IHN0cm9uZyBFRSBiYWNrZ3JvdW5kLCBidXQgbXkgdW5kZXJzdGFuZGluZw0KPiA+IGlzIHRo
aXM6DQo+ID4gDQo+ID4gUkdNSUkgTUFDcyBwcm92aWRlIGluZGl2aWR1YWwgc2xldyByYXRlIGNv
bmZpZ3VyYXRpb24gZm9yIFRYRFszOjBdIGFuZA0KPiA+IGZvciBUWF9DTEsgYmVjYXVzZSBub3Jt
YWxseSwgeW91J2Qgd2FudCB0byBmb2N1cyBvbiB0aGUgVFhfQ0xLIHNsZXcgcmF0ZQ0KPiA+IChp
biB0aGUgc2Vuc2Ugb2YgcmVkdWNpbmcgRU1JKSBtb3JlIHRoYW4gb24gdGhlIFRYRFszOjBdIHNs
ZXcgcmF0ZS4NCj4gPiBUaGlzIGlzIGZvciAyIHJlYXNvbnM6DQo+ID4gKDEpIHRoZSBFTUkgbm9p
c2UgcHJvZHVjZWQgYnkgVFhfQ0xLIGlzIGluIGEgbXVjaCBuYXJyb3dlciBzcGVjdHJ1bQ0KPiA+
IMKgwqDCoCAocnVucyBhdCBmaXhlZCAxMjUvMjUvMi41IE1IeikgdGhhbiBUWERbMzowXSAocHNl
dWRvLXJhbmRvbSBkYXRhKS4NCj4gPiAoMikgcmVkdWNpbmcgdGhlIHNsZXcgcmF0ZSBmb3IgVFhE
WzM6MF0gcmlza3MgaW50cm9kdWNpbmcgaW50ZXItc3ltYm9sDQo+ID4gwqDCoMKgIGludGVyZmVy
ZW5jZSwgcmlzayB3aGljaCBkb2VzIG5vdCBleGlzdCBmb3IgVFhfQ0xLDQo+ID4gDQo+ID4gWW91
ciBkdC1iaW5kaW5nIGRvZXMgbm90IHBlcm1pdCBjb25maWd1cmluZyB0aGUgc2xldyByYXRlcyBz
ZXBhcmF0ZWx5LA0KPiA+IGV2ZW4gdGhvdWdoIHRoZSBoYXJkd2FyZSBwZXJtaXRzIHRoYXQuIFdh
cyBpdCBpbnRlbnRpb25hbD8NCj4gDQo+IHRoYW5rcyBmb3IgdGhlIGhpbnQhIFRoaXMgaXMgZGVm
aW5pdGVseSBzb21ldGhpbmcgSSBuZWVkIHRvIGRpc2N1c3Mgd2l0aCBIVw0KPiBjb2xsZWFndWVz
IGFuZCBnZXQgYmFjayB0byB5b3UhDQoNClZsYWRpbWlyLCBhY2NvcmRpbmcgdG8gdGhlIHJlc3Bv
bnNpYmxlIEhXIGNvbGxlYWd1ZSwgaXQncyBPSyBhbmQgaXMgZGVzaXJlZA0KdG8gaGF2ZSBUWEQg
aW4gInNsb3ciIGFzIGxvbmcgYXMgU2V0dXAtL0hvbGQtVGltaW5nIGlzIGluIHNwZWMuDQoNCkkg
ZG8gdW5kZXJzdGFuZCwgdGhhdCB0aGlzIGlzIGJvYXJkLXNwZWNpZmljLiBEbyB5b3UgcHJvcG9z
ZSB0byBpbnRyb2R1Y2UNCnR3byBzZXBhcmF0ZSBwcm9wZXJ0aWVzPw0KDQpSb2IsIGluIHN1Y2gg
Y2FzZSBqdXN0ICJzbGV3LXJhdGUiIHByb2JhYmx5IHdvdWxkbid0IGZpdCBhbnkgbG9uZ2VyIGFu
ZA0KSSdkIG5lZWQgdG8gZ28gYmFjayB0byAibWF4bGluZWFyLHNsZXctcmF0ZS10eGQiIGFuZCAi
bWF4bGluZWFyLHNsZXctcmF0ZS10eGMiDQpwcm9iYWJseT8NCg0KLS0gDQpBbGV4YW5kZXIgU3Zl
cmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K

