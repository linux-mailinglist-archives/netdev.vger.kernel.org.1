Return-Path: <netdev+bounces-273869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELkuFyGOzGnXTwYAu9opvQ
	(envelope-from <netdev+bounces-273869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:16:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E403742A7
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 05:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD1E83071A63
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 03:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27782378D82;
	Wed,  1 Apr 2026 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dxl50PIO"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0263A3783A2;
	Wed,  1 Apr 2026 03:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013129; cv=fail; b=seX71Qqig/Bvv1z1CS0Ix8opzJYHWNgW04geoukuuO7PYB1UulvcfKnyJYSQg5XSa/G4baMCinX1LJ1in1mUoSt7U7HNO1Uzm0XbNmuup3uFamy7mdp8WI1BGhuvjmsCqSe2avn01KU89j4Mf/TbBSLk/Zm/AcJxEjGvAzbMICA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013129; c=relaxed/simple;
	bh=at4L4+tWBbq9oPXrJ77iC0D8LJA3O7JvG+KdzqDtmiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O37iqa3+FoNRGGvSOtAG0PlpHIuQ+nTlt0q1k3oVkEgtcYoEC07AslW9y8PKkJiIWhWjoEFe2CcvS4a0Xr5YiKWhf+Jp7GF0C/jV7pKoZ5JXIeVQVGbwSox94hnTXEBLRF0ZsrikaB/dlH8xS6QvOn+PmbaOK3ohMbjocOlVyTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dxl50PIO; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmsqSfdyQREMCZdoQBWwHyrf71d+FE8FtgFhdJ2kUn4dm9BY6fTF7HakPh8I6r79TCEybbkP4TVtWPW04U83dbqg8dJlMkcODxn6kmpvH3wJoA3qPXtTZciR501176g6OoQME80GFYUWFbXjuGbddweOQlrh1YQP1s3j2uaHVaGRdleYUwG8VeMoRGjviHm4kUBYDcnItZf8KVqg2G4dJOLdu/VP8IURjonSp520s+rULhpA/8kfaPtLkyWqJQclGbEcWau+d/vTylq2sncuxFxVHRArJjYeFwtfXhW+IW8D9uh6b+8a3A3n6vqGcmJvu/DJ2zgcciX45S1T4s6r0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at4L4+tWBbq9oPXrJ77iC0D8LJA3O7JvG+KdzqDtmiw=;
 b=edKCDIIDtSb7MvLSEo4WZqh1qyjncOKSWDew5qy56o8CU9ydtrwuz41IoItdFQBjzdBSpihvV+7vTxbMMV2nCmKFfrW5EyRYXj0fHjpSJKQxRsdTPvd5gB8lPtEBKdv+LJW9zyAeWsfoRnOIjSS/aOalfau4yl2sXehYQ497CmZHFdSTTu3AaFgDcM+4fK4MgZwdqmKwfXmJisWAf55fPLrImJj1AJ2AbwzLzbdVRNARB20AwkEMLIw0v4sH/Bid7syaMLbiqvYU0wC8cFwAyWjXE1B3qfzGZc3f2JFTAR47eEeNG52r2qRw7liGJ1CyuUjillw2/hJ68hHavp5KpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at4L4+tWBbq9oPXrJ77iC0D8LJA3O7JvG+KdzqDtmiw=;
 b=dxl50PIO/ppGwDYOJ0gd3Zwi0I9BMiTowhw9OLyyLuZ+nIsa+v4RuC2pUAcIjx7X2ITSfLVpSM19MYfoP0dQtwxZICNBtO8kxBb3X5ixNq5NMAk7YY1p5haLlODOq4Vi9tmb84o6IXqDrrKM8o+ruUglxp4JGH6CKLrDiB8FyQ9+KZRuZbIH1D+nn+4iaTup86j6IsHYm2ZzusV/SdstIj0dB29Egn8htv3953vG8kTjVmVLA3ovvI23DXhJwp2S2aXKolJng7qwI56eiYPVfVTMMDzO9UwrxDaHJRIIz2PeNTogCVjg6uGDT2fpXZVoZ7RjnuC72o72TrXGIGXbog==
Received: from SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 by CO1PR11MB5121.namprd11.prod.outlook.com (2603:10b6:303:98::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Wed, 1 Apr
 2026 03:12:03 +0000
Received: from SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf]) by SA1PR11MB8278.namprd11.prod.outlook.com
 ([fe80::3a83:d243:3600:8ecf%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 03:12:03 +0000
From: <Parthiban.Veerasooran@microchip.com>
To: <andrew@lunn.ch>
CC: <piergiorgio.beruto@gmail.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steve.glendinning@shawell.net>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-usb@vger.kernel.org>
Subject: Re: [PATCH net-next 1/3] net: phy: phy-c45: add OATC10 Sleep/Wakeup
 support in 10BASE-T1S PHYs
Thread-Topic: [PATCH net-next 1/3] net: phy: phy-c45: add OATC10 Sleep/Wakeup
 support in 10BASE-T1S PHYs
Thread-Index: AQHcwEs6ol5pwh6wfkmKOAIMSG7lsbXHJ1MAgAJitQA=
Date: Wed, 1 Apr 2026 03:12:03 +0000
Message-ID: <4c1eb339-a32b-44df-9989-561eb01c6825@microchip.com>
References: <20260330134222.67597-1-parthiban.veerasooran@microchip.com>
 <20260330134222.67597-2-parthiban.veerasooran@microchip.com>
 <239a7455-5cb6-4cbb-b9d6-1d48a0cadbc8@lunn.ch>
In-Reply-To: <239a7455-5cb6-4cbb-b9d6-1d48a0cadbc8@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8278:EE_|CO1PR11MB5121:EE_
x-ms-office365-filtering-correlation-id: f9fba695-0c4d-4caf-9089-08de8f9c7276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 yhnSgu+ph7Av20fqNiWgnIvDhENZKaJzyAXah6N3HOUFfT62945MIQtXakLX582+Uq1UlcQiPk+TiVWfYJTGNHKArdayw3Mv6amDeLT5Q44tqAhRcyPm0ooaRdEi7wakUIoDYxXmDL/DWVXAnxJ+ROYc7L33zKyqtSIUibUEfsEqbjqdmHAtX9XIMMf9GZA5aG+tGbrhWo60eYYf9KQdUafVmA0waIjzP9ybz+RXpKYSEK8sdI4Soy9UovlG0g4Peu5S32dpJGuwEK8Nngo1hcEbs1+FXYqX2VBk+fhysVqlBEdE3ZFGSkVYhD2/Ikd3ODNgKuyxDD9vXE3CeaW25uYwsofSu+UNbjZEV5IF7WUt5cwTT+xFNGjrhZ51vDBJCohO5Wbe6Hrlg3AaiBkXRZOI6TmiRa4QHxEUKPkdBVJeJxDWLbzI6aAAGDa3mvdW9lykuBq2BoV8GS0zJyf1Z7chsrJrSAb1S8+BUSiDsDZETmgjNe2Y6cjBiSecyoA82IvynHyMuIQRkQEVw1++QNmdeBMQvSTx79wpPbZ0a0Vy3mkI3tXro81+UkOHbyhbqfem51hcm5oHWTBndBBA9hF7JNtmZ6FoIwmpdc2U16J9C0UZPE1tPZ2NKKKQDB3LeHtg4YrgkxAG6zHMjvSY95rGYuEQkjXrt8XRQX1t1Ay/iqcxkKGlFj1r4i86TlGIMLVn2YCRpiTcvZAscL7BCFKP54hadXz6PR8i0YmPuFwVmwJRo2wbtrdNwoNJOYk8WV5RZviXRAcx/eqbmJWcm0317Rcdj1snBASzJxs7o1Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8278.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MEUyNTJFU2s2YW9CQlJ4QXA3V1lIa1JmTXpuM21xTlpnVHBFK2dzQ1lGNWFP?=
 =?utf-8?B?Uzh0d3NBUytlUTNmR1pLSkMwWDJ2WTBxcDVmaS9GVGRuVXpFMkxTMDJsM3h4?=
 =?utf-8?B?WTVQTFdTend1SHRBRWtiVGw5c0VkOTNVMzR6dmtNU1d5STV1NVFzNTlpVitz?=
 =?utf-8?B?aVJsQ0pxVkU3V1JMZ1IzV1AxNG80M3pDK2tjbFdiYTFabHVQTGFPNFdoK3pY?=
 =?utf-8?B?VWl6QWJHL2pIUlBZc0Mrb1A0WmJBQnZXTUJUeXBSWnNNM1MvdUpVUmdQSkNu?=
 =?utf-8?B?MlZsWi93aHNPSElqOVgvL0VqOC9CeTJpZFhXeXNrNk5JYVVEQ3ZmdytSeFJm?=
 =?utf-8?B?ektvejZxU3JDWFpWQ0NDWG9wMnVUaFRnL25Ybll4Y1J4d3pqSTJjc1BqdElJ?=
 =?utf-8?B?R3d2aFdkMFJvWXNqc1c0S1RyVVJoUS8rUmVka0NDa1U0M2hxb1ZzMFZ5ZzQ4?=
 =?utf-8?B?TFhXcEtaOTR1RVFmTDRsdk9WUmc3ODh3ck9QempNRE1nN0J3N3FybGxKSm5n?=
 =?utf-8?B?cWdRNzlRZFdtOGxlN05UallWTm9xZkpBdlRraW1TbGxZMkpVeDkrTVVFR0Na?=
 =?utf-8?B?OURsd2RVSDNlYnpmWHB0a0p4TmZDL1R5S2MrdkJENFlhcHVMZXBUSUI2SHVo?=
 =?utf-8?B?a3BtMW9UMUZ3QkkxRWlHV0dHa3p2SnpqenE2T1h6M0VnWW5QRnk2N01pejVl?=
 =?utf-8?B?Qjc4bGdBanI2SjNmeXRGOEdrN2NUTEdsYWNEOEpkeC9jRWNjOVV4S0EwSHFu?=
 =?utf-8?B?QnNEWlpYeGxlWFJIRmxLN3Rqb2cxcktheHpTU3JobkQ5b2dWRDJXRERXMkhO?=
 =?utf-8?B?ZG5RL3g5aldTcmhIL0RQcjhNWlh4UTBQeFVibHIyYjMyZmNGQm5XdTAyeW1P?=
 =?utf-8?B?b3hQbkNjT0FsRUFoR1QvYjdKTG9nT01zZmdha21qQllGelBPd2xzMkx5VUNo?=
 =?utf-8?B?NG9NRVQwZFQ5N3dldEhycjhQc1NycCs5NnVHVGNuSkQ4VVVjRyttNStzZGVS?=
 =?utf-8?B?UHJOVDdNbGhvczdWMlZBMCtNaW01UjVPWkNCeE9HdFlIUDBucGNibW02L3Zl?=
 =?utf-8?B?UkdBMm5jVzZWeEorT254UTVHM2JLL081UDRqalNTNXB3WEUrUXZ5ZTV1eEta?=
 =?utf-8?B?YVFHREJsVG50V0hQVDNMb0RkYWhJRythV1puTVh4MEh5Z3JDVDlkR1laOVVk?=
 =?utf-8?B?SXp5V1Y4dFBoOEpweUhJTzFGZmk1anhNdEVBZVl6WFEvZ25CN2NGUTY4Skkw?=
 =?utf-8?B?dnV2S0lmNFRDbVZJdWhnOFlSSUt6Um1xL1JVcXp4amIwOFJUODAwL0xPUG05?=
 =?utf-8?B?MFBCQUpnajMwUzdlN2NSLzY2SXQ1cDg3RHlPTFVKdTJjOWhWQ1FWd0tMZndB?=
 =?utf-8?B?WC95cG5CcEJ1SlRRbjNNMkRhK29sQW1pelpvNzBiUzNIMXoxWDJaWk5USGVu?=
 =?utf-8?B?My8wVHBjcmx5bkw2RjFhZjNuY1NhY2Qyd0hITFNrYjk0M2VML2t2NS9vUE55?=
 =?utf-8?B?aTZCSkh0bUZ4RTU5dDR4OXVQVzNpc0FtUFNiTjVkSkZ1cWt5WmRVM3BzVVBp?=
 =?utf-8?B?TktpbzdOZDJwQ2NZekl0YkVhZjhaV3JyUXdiMEdocWE3dmgvM1pCbnM1VnJu?=
 =?utf-8?B?cG83SDhKVVBuWDVHTWFNYjg3cEhNVGVNUzFqNUVCc2s4NHdQSkk2V1hrZ3R4?=
 =?utf-8?B?TE11eEhTUmQrMjRyQkFOTUE1ZXRtZjhYUTBpMlBZRjQxU2d2OUt2RkcrNUVo?=
 =?utf-8?B?L0V5R0FScDAvaURIUklwcVlMaHU0bUhtMHR3eWdaSFFHRjFhTG1QT1ZGajdM?=
 =?utf-8?B?T3RjeXY5eFF5WWlkS3pHRjZLU0E2TWFidkxWcnRSU2hOdUwvbWVxVnI4Nmgy?=
 =?utf-8?B?a3BiRFlXcDdXQ2U4WUNjUzFPb2lVNjk4ZTc1UGVEUWsrZnNyd295VWxTMS9v?=
 =?utf-8?B?RTNaRmdMM3hYb0FjUVNEd3RPVk1HZ0lJRkRHV2VhYnZSN2tuZEZ4Z0hic1Ur?=
 =?utf-8?B?eFIzOE9mSUN2QXJIK3ZCSEoySVlpUjVwN0RoL2swTThqam5DWXlTbkJCRUxm?=
 =?utf-8?B?T29nV0dwdjA0RVkxUi9rMFBJM3U0UC9RekRISHNSNmdXY1lueVgzekhuczQv?=
 =?utf-8?B?YmY3MlJjemk3Q1NxblU0RDZNTU5ZM3dsTitLbSswQUt3ajcyUkJGOFc1a3dK?=
 =?utf-8?B?VmxMUGVSVVcyT2FNSzk0aUZTcHhJYUVnUVdOWU5BQldBM2s5VTdTbjJTQnM5?=
 =?utf-8?B?RVFzM2IxKzJacG5UVXVIeDVHMG10NEJIUzB2YjR3OU13eWFRbTRibUpaeXIw?=
 =?utf-8?B?RDM0MkNUamFrMUU1c0JpdnJqRDVPdDJncG5JY0prMk92eU9WRUdkZm9NbjFS?=
 =?utf-8?Q?5bCm/vnykL0cWT08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6627E02C7B5AD4CA05043DA1FDC9550@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fba695-0c4d-4caf-9089-08de8f9c7276
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2026 03:12:03.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlIF96hEa15aQjbZhaRTorVS3h5X+m5TNboboM7QS5wfey8CCAps3mh/o7We9uJpmLUebkMlthqwgApDcn3bxA6YywTjkUROFHrDvSYAnVple9ekN2XW2hfJ+TPDty33
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5121
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273869-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,shawell.net,microchip.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Parthiban.Veerasooran@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: B5E403742A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgQW5kcmV3LA0KDQpPbiAzMC8wMy8yNiA4OjE2IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gKyAgICAgLyogQ2FjaGUg
UExDQSBzZXR0aW5ncyBmb3IgbGF0ZXIgdXNlLiBUaGVzZSB2YWx1ZXMgbXVzdCBiZSByZXN0b3Jl
ZCB3aGVuDQo+PiArICAgICAgKiB0aGUgUEhZIHdha2VzIHVwIGZyb20gdGhlIGxvdy1wb3dlciBz
bGVlcCBzdGF0ZSwgYXMgYWxsIGNvbmZpZ3VyZWQNCj4+ICsgICAgICAqIHNldHRpbmdzIGFyZSBs
b3N0Lg0KPj4gKyAgICAgICovDQo+IA0KPiBEb2VzIHRoZSBzdGFuZGFyZCBkZWZpbmUgdGhhdCB0
aGlzIGNvbmZpZ3VyYXRpb24gaXMgbG9zdCBpbiBsb3cgcG93ZXINCj4gbW9kZT8gSWYgdGhlIHN0
YW5kYXJkIHNheXMgdGhpcywgdGhlbiBmaW5lLiBCdXQgaWYgbm90LCBpdCBzaG91bGQgYmUNCj4g
dGhlIFBIWSBkcml2ZXIgd2hpY2ggc2F2ZXMgaXRzIHN0YXRlIGR1cmluZyBzdXNwZW5kLCBhbmQg
cmVzdG9yZXMgaXQNCj4gZHVyaW5nIHJlc3VtZS4NCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3
IGFuZCBwb2ludGluZyB0aGlzIG91dC4NCg0KWW91IGFyZSBjb3JyZWN0IHRoYXQgdGhlIE9wZW4g
QWxsaWFuY2UgVEMxMCBzcGVjaWZpY2F0aW9uIGRvZXMgbm90IA0KZXhwbGljaXRseSBzdGF0ZSB0
aGF0IFBIWSBjb25maWd1cmF0aW9uIGlzIGxvc3Qgd2hlbiBlbnRlcmluZyB0aGUgDQpsb3figJFw
b3dlciBzdGF0ZS4gTXkgZWFybGllciBhc3N1bXB0aW9uIHdhcyBiYXNlZCBvbiB0aGUgTEFOODY3
MC8xLzIgUEhZIA0KaW1wbGVtZW50YXRpb24sIHdoZXJlIHRoZSAnbW9uaXRvciBhbmQgcmVhY3Qg
dG8gd2FrZSBldmVudCcgYmxvY2sgDQpyZW1haW5zIGFjdGl2ZSB3aGlsZSBvdGhlciBwb3dlciBz
dXBwbGllcyBhcmUgc3dpdGNoZWQgb2ZmLCByZXN1bHRpbmcgaW4gDQpjb25maWd1cmF0aW9uIGxv
c3MuDQoNCkhvd2V2ZXIsIHNpbmNlIHRoaXMgYmVoYXZpb3IgaXMgbm90IG1hbmRhdGVkIGJ5IHRo
ZSBzcGVjaWZpY2F0aW9uIGFuZCANCm1heSB2YXJ5IGFjcm9zcyBQSFkgaW1wbGVtZW50YXRpb25z
LCBpdCBzaG91bGQgbm90IGJlIGhhbmRsZWQgd2l0aGluIHRoZSANCmdlbmVyaWMgUEhZIGZyYW1l
d29yay4NCg0KR2l2ZW4gdGhpcywgSSBhZ3JlZSB0aGF0IHN0YXRlIHNhdmUgYW5kIHJlc3RvcmUg
aXMgUEhZ4oCRc3BlY2lmaWMgDQpiZWhhdmlvci4gSSB3aWxsIG1vdmUgdGhpcyBsb2dpYyBpbnRv
IHRoZSBsYW44Njd4IFBIWSBkcml2ZXIgaW4gdGhlIG5leHQgDQpyZXZpc2lvbi4NCg0KTW9yZW92
ZXIgSSB3aWxsIHJldmlzaXQgdGhlIGltcGxlbWVudGF0aW9uIHdpdGggaW50ZXJuYWwgcmV2aWV3
IGFuZCB0aGVuIA0KcG9zdCB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFuayB5b3UgZm9yIHlvdXIgc3Vw
cG9ydC4NCg0KQmVzdCByZWdhcmRzLA0KUGFydGhpYmFuIFYNCj4gDQo+ICAgICAgQW5kcmV3DQoN
Cg==

