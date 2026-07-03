Return-Path: <netdev+bounces-304441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lja1GVZvR2ryYAAAu9opvQ
	(envelope-from <netdev+bounces-304441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:14:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D109D6FFF38
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:14:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=kM7h6A+c;
	dmarc=pass (policy=reject) header.from=altera.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304441-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304441-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E521930D8544
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17968372057;
	Fri,  3 Jul 2026 08:01:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E7372663;
	Fri,  3 Jul 2026 08:01:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783065667; cv=fail; b=TCdaB5aXe95/sTKgLM5SSN3jzKnkPgmSG6ki/e+JsMTGZCF3FK+3eZG2gMJ8/0jPfuPToZ8iHQ1y+pNwqM4O0aLnBC1WpymF6eFTYSx4IKhCW1c0egW1IDb/A+xCwYOcWSOU2L1nZzirAwINIzeiFfVIBglWmuhyBlTvHS3Gp6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783065667; c=relaxed/simple;
	bh=Sgo7ptyXT4ZTffsAUJNZVdJFxNyc9ytJ2i4WEYSNDZs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HQ7MisOIzL/zCZyCJC1R8EmSSykUxDnd4rhriu7Smd1I2C4S/PGc2ZFcTh5HaVqhckqYWoXrXXPVrRgwhZXlB4m9fwR0tF2DdrXnbNFWGfAvORAVbjXf8QjmGOBLyHohYoByhq2KRiHXdcZAxdWhZUVLR+/wXnvu/0qHZGlXaIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kM7h6A+c; arc=fail smtp.client-ip=52.101.53.43
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj9DZXS8HMNnGP8Fmk0DQBzWePd+JOqjSDZ3aio8FSw1GDc1OfhG/w0cew/TJiJK23rVmQLHZehd5dLXy5RmHozDX3QaM0nj5DbkMAgbiHLKaLr/x7X2Js6j8PGt94VXqzzC1VvIttsFu08JIw3+7Wkh+cJdxDGxhCNO5e8F/tl3QtSuyCHNunrPHwBJQsoeLo0bMWbUOuK+wKDFFZUrkJg90J+Ifyzh3w1vCD/evkudvMrGv+bI3SDIfVqYU+nkfTc/xeUdjni5eEL3WoEN1F17byjW6MCio/uFpbW0a1Ell2BBkGkG1lAItZ0IH1h/U2bx9loJRyPTWLboSnUQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgo7ptyXT4ZTffsAUJNZVdJFxNyc9ytJ2i4WEYSNDZs=;
 b=ctoxALaUNv5lgm+ZTdZSP4d5goW69a5+S79bC4vhiqdqt8v891Ndehfawo3QaIBKIu+OSWnBR0G+MC96enjEA4ZmzyvF49qv04QYMqR6K2JIWzEo+LDDU7jxl9K27+GLNY/hPLoepTRc2yMZLgTCN3AxYlDHKR1Ag5iY5GxJ56r+Al3/FaQ6mvCQ2otUXQi8zLBNWOIdccJxrZtIy0dPRE7opldZo3HB4giQarcuptDDrKgow6fljHclFupjhT/hJlSNeb8EDk3whP4ugINLo/hlLgIssYByL250GOm+CV9qCXmTQToheULrer5/5B2+KAZachET4xnWcffl2WKhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgo7ptyXT4ZTffsAUJNZVdJFxNyc9ytJ2i4WEYSNDZs=;
 b=kM7h6A+cN85x9nZ0Az5rVZhuzm19xVxyQ4C1e36038+SdoohPpA7FPIfdxT553HSzVrPhl2q0WMnDuvMgEd1Mm/ON9u/OrfCNm9gDbAomfh3H6kIUFI9AfbvrOWoUtd3ZEHZgE2xhfRkTo4DFQpUjdE8iQmKwm9bQNDGRHk6ZyB2t1kIwrp2PLbB01kKZJpM6wxJxMODpEAeTck3brsf6tf6xRpD8vgfOhr9jFAYBeF2vKPUgM1z00bgeAGK4ydNdoxqlEZi32A+YWCuJ3HRM3TL0pqCtmw/MEhfE5fTHWwAb06DtgxppzPHqDwknCHdLz9sp8T0oSt4w/r27A0MVw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by BY5PR03MB5249.namprd03.prod.outlook.com (2603:10b6:a03:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 08:01:02 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 08:01:01 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phylink: reject unsupported speed/duplex in
 ksettings_set() with PHY
Thread-Topic: [PATCH] net: phylink: reject unsupported speed/duplex in
 ksettings_set() with PHY
Thread-Index: AQHdCQgxESryTHoLfUCl9eH//drmfbZYVVaAgABkDwCAAri1gA==
Date: Fri, 3 Jul 2026 08:01:01 +0000
Message-ID: <7b70b51e-1fea-4de7-be31-90e9e79ec98e@altera.com>
References:
 <20260701031746.23448-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <37005060-acfb-4791-aa2c-caa3710d4450@bootlin.com>
 <c3a0e35b-a633-487c-bc08-d62f809047a6@lunn.ch>
In-Reply-To: <c3a0e35b-a633-487c-bc08-d62f809047a6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|BY5PR03MB5249:EE_
x-ms-office365-filtering-correlation-id: c12b2bdc-72b3-41ff-09e3-08ded8d93957
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|55112099003|38070700021|4143699003|22082099003|11063799006|56012099006|18002099003;
x-microsoft-antispam-message-info:
 TnKWEh7Zhq1FNDfZ93GvZjVgP/e/NYHmm6HqcLCg8xsflf+5PwwaI3uo8i47NzxeEuKnUEWRSkG7UpRFcceRDxsf+Sc0Xd3ItCZImVUwRimFlWcRVQnbFDMj4X9zoaAUqBWksxLu87NmmR12PtRE1HXsDXG0P8dSUf25QdrSbHd73Hy+g355Fp5C769UQkGJgjRcy7FtAdgf1HmCvaESHikzh9IODEw00Cn1aTebiPEif1h4RNoJXlO2JlADmUTcrPsnWzH5lcUmmBp/N/BzYM75isLtzTymoDMJzAtvvPDyHWtnFrrbunaZmvy9lrruwqVPPSFoe4Vo6jTFne3/Z9sQX4IO/Gs2Amn06cBnp8QHjoJ0VA4xPOlsNTQBLq821Upb4GvZXDr0U+Aj8tYJIDQ59onCTDSiPhNDRKI+solgUmPhoWVMeL9y2IcVYeYwF7Hi+EY5VnH6WHjpWVHrqLyAm9ADDEsKcHAtx5QmdALiUIIrUfNLYeTllSayobvn1rdZ3QeaUkmqYvmEIv1uUGz73iysqdgLpgag/OrH3QLrTnpIL8pjhix6v2h5zhoL84DQLLKcNhzd7WDtTHWhN0NvYt26Z1Qe+qA7k5fh3sD3Y/Kr4DKed6PzYif/31RN6mDIZkysrwalSAlbp8b2gat5Y2W11JcsMrbitINRYneiRRCwedmREdrlsUiQoHk0xHp23d4eHueFwHaxWPInmkJcUYsr9V1C17XnA/ZH0t8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(55112099003)(38070700021)(4143699003)(22082099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFMxTEhEYWdPRmk2Wm5GWS83K0JIOHVjSVdmSk05bU9qYVAvNk9rRm5GVVZi?=
 =?utf-8?B?QmVDRWp1QUoyd2dFK1RlbFZoOWp6UnFrcFFDMTlGYm5melJrNFVCcGY5UE1P?=
 =?utf-8?B?ajhTS2hJNnpqZTkyRFVqQzlkUDVLUVg2S3lZWnpYN2VoYmx3U2RZN3FkcUtG?=
 =?utf-8?B?T0lLRFhqTjNPeFdEUlNWa3VxQWhFRTFZaVlyRHNkYkltQXBJMWJmbFA0czJ6?=
 =?utf-8?B?V3hra2lMSTI1dDRVQlEwTmFIRFY5dDcwaUNKN095N3FudzFsL2Vvcld0NlNC?=
 =?utf-8?B?a2xWL0kvSU1jMEpwcWt5QjdEY3Bpc0ZhOHJMSjFPRFNSRWl6TkdmRU1oMUJM?=
 =?utf-8?B?NlJCMG1lQ2ZtQzFLQThRM05MZHNmUTN1OHQvWVFXcUZuelZoa25OZ0ljUTBS?=
 =?utf-8?B?TWxKZzRnb0NISEU0ckFGbytvWm1zOGdkSE9ScGJHeVdkclA0R1hEZ0ZSaG5B?=
 =?utf-8?B?aW1WTUthUDlsRklxRmlsUkhCNUhHbWtlQVVETkI0VWQydUtGNEFVUmkwaEgv?=
 =?utf-8?B?UHdCWmFxQzF4Ump5NUl2SlIvWTdYZEFuVWdrbUNMbGxFekkrZCs0STVxQzIw?=
 =?utf-8?B?bXpOWTFDVHpTUmFRUldaM3BDRm5RYTQ0dGx0K3c1RmpxUFdkUTZOLzcyQkJY?=
 =?utf-8?B?UVV1TS92dzZRMmxhOWVkVUN5V0R5bWY1WStuc2hjcWxDK2tjZ1diTTE5YkpR?=
 =?utf-8?B?QUtPQ3UrZHY1QmVsT2hBUWh4NkcwQ3ZZdlF3Vml6dWVqalVwbk5uZWNnSjNC?=
 =?utf-8?B?TG5rejZJY1NBaFhJQ256b2pFWk5lMmNNNUowWktqN2dsQ0JaWXkySjVJc2lH?=
 =?utf-8?B?NzhrdmJidEpvZ0cyanhOVWxwb3Fsa2pkYTE4QkNwK1pwdVBWSllrNkozcDV6?=
 =?utf-8?B?cmg3bERrL0gvWS9vMHpXbGN6dTRsVjV0VkRYTnQ2MXZZU0h2amFxMFJhQVBN?=
 =?utf-8?B?ZkNVVVNxRllXck5hRnU5MCtHek53Qmg4MVNsc0QwdFNwZ0hnVlJieHlqdk51?=
 =?utf-8?B?TXFTZStPbVB3YWJHaXlVTXI5SUQ0cHFjZ0JIdndmRmlmVjM1aVpRMnBDaGdj?=
 =?utf-8?B?MjU2RStGWnFCY2V1QUVhZFMvT1B5TUFIMzdRamtmRHhOVXRPcFlncEt0d1pr?=
 =?utf-8?B?bGRwWVRRTXQ0K091Vk1DYzBlUktGdTZwdTVCMy8vcXh3clp2cm8yRVFGQ1FZ?=
 =?utf-8?B?SlZ5UnFGaUtDRDFJN1FpcGREKy9CNFlaYnpCc3VyOGtUZnRMSEkyMVNiTzN4?=
 =?utf-8?B?Um9pUWkrbnpzRjY3UTUzSkZtandrZXFwV1F6WG9nYXM0bkgyTFlNZW83REFV?=
 =?utf-8?B?S0g0REJ3eEx5NWNsNWxGMWRZNEdPWW80RnoyNnpaektwVTJKRnlCL1dqWE1i?=
 =?utf-8?B?RHhHYzhvMjU2dFNYVG5BTUwrb0pVQS9BaG1HazVxZjBUdmwrRmhsc05SeEls?=
 =?utf-8?B?cnkwVTk5TXJueHNQek54QWZwdkdOcnkvNWNPUEVSWEJTTE10bFBleHJPYmVm?=
 =?utf-8?B?RHI0RTFyRU52Zk1QbkRERXRsWG1SRTNvQ2RDMC9Kd2txZGlJclJFcVlVVnEv?=
 =?utf-8?B?N0sxcTAvMGp0WXp3Z0JuSUNLMUwwTEtpVVhxdFF6QTBmZlY3QVRaUUZ5bUgy?=
 =?utf-8?B?MTdrOWNUOFlxWFhlekdoaEdhdDUrME5uKzhSNm5aU0JnV292SGk5eldNclRR?=
 =?utf-8?B?WGVSZUVUOVVNbXFPTU5qcGIwbGNSUW10bEFNOGdOK1ZYUkp4bHJQT05kak43?=
 =?utf-8?B?WUh1dWVPNXZDOTdLVXJOSlpDRzM2UzdVMVpkUXF6cU41SlViNWM2dHRtMXI3?=
 =?utf-8?B?aUp4UzZ2WDdtOUc1MUJSYk83dDg0a2UzVjFhYkFRV1RTS3oyZHZReW13WDFs?=
 =?utf-8?B?elJnL2hFQkxyNWIyUis2RkI5Wi9CK2lyNS9JcmdLTWtLQ3pwNnRkQ1F5Sldr?=
 =?utf-8?B?NVRQSjZRS3ZRbG5PK0NkZy9rYXZjbXRWcHFJQW5mdExzUEZpazhhUEhLMmxG?=
 =?utf-8?B?dXY5Y3lwenZXampmL0RyTXZBT2pDcjQ2UzJVdVJ2K05iejM2NExUK0M1RWY0?=
 =?utf-8?B?Y1FLc2FlRnVWdGNuWnloalFmb3VERWpJRkhzcnc5NXM3RlppemxpZWxVRzAy?=
 =?utf-8?B?aDBERGw0OXJzQThVYjY5bXdjRk8xUFBzZC8rQkJ5ekc4U3ZXNUZTb0tHdnp1?=
 =?utf-8?B?TTBBZUl3RVBuUU1OVXhNQm5jc0V5OHRNS3EvaXZaYnkrM0pVcTExOFZnR1dM?=
 =?utf-8?B?d1ZvUHJTb3l4THJWTTdlQmpMNTlxQmdzZjVtNFArNHRmN01jNldPVVhGd0pk?=
 =?utf-8?B?NkZZeGExRkxDcXhHZnFSL3cyaWMxNlB1WWFhVndIVlFMUjQ0MTNIeUxsakts?=
 =?utf-8?Q?7j4v4gKG9XQ3i3atzgboyhKf4JDoXbG3VoxNPCkkvlFh0?=
x-ms-exchange-antispam-messagedata-1: 1JOAfh6lHGmpkNlBm8dEeT1Oe8SRDt5j8kk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <220C586E9C863F438357A9E329251A59@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6964.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c12b2bdc-72b3-41ff-09e3-08ded8d93957
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 08:01:01.3604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88Xf/3vbSDzOX4Jf2rrdsX7nX0F8Ok/i4lgrxT4fiXL8PdWXH0PrOG26M8gtuNEYKHPMvFVoq6jMA+iBLNJd+ro4N4mCHcKLswHxt8BHIn4P1EGD9qBgX0DArKuppLsW7r8stznhK71hChwbt2L9eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5249
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304441-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,altera.com:from_mime,altera.com:dkim,altera.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D109D6FFF38

T24gMS83LzIwMjYgMTA6MjcgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4gSSB0aGluayByZWpl
Y3RpbmcgdGhlc2Ugc2V0dGluZ3MgbWFrZXMgc2Vuc2UsIEknbSBob3dldmVyIHdvbmRlcmluZw0K
Pj4gd2V0aGVyIHRoaXMgaXMgYSBmaXggb3Igbm90LCBhcyB0aGlzIHdpbGwgY2hhbmdlIHVzZXIt
dmlzaWJsZSBiZWhhdmlvdXIuDQo+PiBJJ2QgZXJyIHRvIHRoZSBzaWRlIG9mIGNhdXRpb24gYW5k
IHNlbmQgdGhhdCB0byBuZXQtbmV4dCwgYnV0IG1heWJlDQo+PiBBbmRyZXcgd2lsbCBoYXZlIG1v
cmUgaW5zaWdodCA6KQ0KPiANCj4gbmV0LW5leHQgc2VlbXMgcmVhc29uYWJsZS4NCj4gDQo+IAlB
bmRyZXcNCkhpIE1heGltZSwgQW5kcmV3DQoNClN1cmUsIHdpbGwgcmVwb3N0IGl0Lg0KDQpCUiwN
Ck5hemltDQo=

