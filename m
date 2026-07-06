Return-Path: <netdev+bounces-305240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TMJ1OHg5TGq6hwEAu9opvQ
	(envelope-from <netdev+bounces-305240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 378857164C2
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 01:25:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=PANEDA.onmicrosoft.com header.s=selector1-PANEDA-onmicrosoft-com header.b=Ghq0PTZG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305240-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305240-lists+netdev=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01003303265D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 23:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF93E7BCC;
	Mon,  6 Jul 2026 23:25:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020086.outbound.protection.outlook.com [52.101.180.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1633CB8EB;
	Mon,  6 Jul 2026 23:25:38 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783380341; cv=fail; b=CD7IU38zO7mzfF3N6pX8yyZlPApfwIDD5k0irz5pBhGja+eSARHKBms3TbIEf7sLKBpwsLDE5ZNrTyIZK1JPc2/bbn/LjlYsuxorHhcUIJWL/W8Uj+dB75E2iQAkVhovKKU1X+pmHraOdH1uNS4/O/6uvxLxAJkr1IxWKkZ3LVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783380341; c=relaxed/simple;
	bh=sM9Wa/BrEOIYdpPdFfOnCgb4YTeTDTMe78K0ah1L3ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JStUVFjOjYjO9oJhhrIgzM8Rgdwvvp4MojOyRFfoF5JXkrWpi4TZBQmtajnXLHoklz2YOp2gabknMdk2kbE8Z47hOnrukQdeSpP2tAWYk7NSevgttMIbT4qf4TElThzTUKm+WXtm2I9xNIgecdtth24Wq2B+b2AqrX9QLvP69PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paneda.se; spf=pass smtp.mailfrom=paneda.se; dkim=pass (1024-bit key) header.d=PANEDA.onmicrosoft.com header.i=@PANEDA.onmicrosoft.com header.b=Ghq0PTZG; arc=fail smtp.client-ip=52.101.180.86
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UueaVNdxjViJ5kqaZLmFq0C0UkXu7WU3pov3skBFiDL5d688NdPQSA91rNHsjIIVaf7f6aRHL98bzpdA9HOuG6gz/i9Z9UMGAp9riFNj+lgcarpLAImjJUwDNVeaucEDCKcWDLmV4S/BrP3jpDBI1MdnDs97imb47Vq2xzYYLEDjgc/0+r3FPi6bRLN4NBLtkQ+HZpSDKxRZOb+zWBrmxCUEBAl+b1mgHRTMrRvE7u+q+/GIer/+FFJjIXVqgj0guFzpzYQ3iQN5w6Cr6xMo8WpO6acbPEOGKBfX0Ds6TolvThTRPGPjv7aGlsii5iOk3cQGKlsrZU2J64esM7J68A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sM9Wa/BrEOIYdpPdFfOnCgb4YTeTDTMe78K0ah1L3ws=;
 b=OILuzNKI9bC3mX9AF0ds+2ZrN9VWy6LX+d2SLHFVOtIbpvId6Wiu4FQc2Xj2xDLjfYC22kA040tJopOIaY35yitCi93NVr7/5CihJqUKqh11M3QjfzY+BF1i86pTIV1UVh1kkSy1XB++RNF0r+tX9otkTRDcc1x7xRTMhq3mSaEkvL1h7cCkma1iKasigxeQCYBK0J8mbDFKhAntMmI2SRMtKKFOsEhstPZA8EsZDQceNe5tmHnozwMrlEQM7jJps5HkHeiUiIv81Mse4sAEDzDu4vYVde5nGH4Zh9qB9aaQCyzLryXPI5Zob4wAGS1YgSjfmXCzSFjLkzf+GE2wIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=paneda.se; dmarc=pass action=none header.from=paneda.se;
 dkim=pass header.d=paneda.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PANEDA.onmicrosoft.com; s=selector1-PANEDA-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sM9Wa/BrEOIYdpPdFfOnCgb4YTeTDTMe78K0ah1L3ws=;
 b=Ghq0PTZGHZ1C6sIu3W/iZ6nLL/5JDv+g7LecxEyBfPrxUY70d8oYtngMSdi9FAKnp+7Pd+ZWlL8JjV3IC9iZhJSWVceqaHrmxQwFwT9ItNZwB6RnIUqsu/WPw6voTLEsTETWQBlpl/tnOL9plNjpW1h5gLBGYaY9/6r7s15rIFs=
Received: from OS4P279MB0403.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:1f::7) by
 SV0P279MB1388.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:3c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 6 Jul 2026 23:25:33 +0000
Received: from OS4P279MB0403.NORP279.PROD.OUTLOOK.COM
 ([fe80::9d1e:929a:6822:8d50]) by OS4P279MB0403.NORP279.PROD.OUTLOOK.COM
 ([fe80::9d1e:929a:6822:8d50%6]) with mapi id 15.21.0181.012; Mon, 6 Jul 2026
 23:25:33 +0000
From: Thomas Karlsson <thomas.karlsson@paneda.se>
To: Xiang Mei <xmei5@asu.edu>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "AutonomousCodeSecurity@microsoft.com"
	<AutonomousCodeSecurity@microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "kys@microsoft.com" <kys@microsoft.com>
Subject: Re: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
Thread-Topic: [PATCH net] macvlan: cap IFLA_MACVLAN_BC_QUEUE_LEN to bound
 broadcast backlog
Thread-Index: AQHdDY4S481ZgdFiBEeV/y1nwovnhrZhEUYHgAAC0QCAAAJQQw==
Date: Mon, 6 Jul 2026 23:25:33 +0000
Message-ID:
 <OS4P279MB04037D97A6ECD2021F1675C9EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
References: <20260706212556.3199234-1-xmei5@asu.edu>
 <OS4P279MB0403BDB88C2B7F4D4939DCC4EAF12@OS4P279MB0403.NORP279.PROD.OUTLOOK.COM>
 <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com>
In-Reply-To:
 <CAPpSM+QjiZxUOqK6Aor6gLehVj=xGQ0uAcuPm089EuSNRFeynA@mail.gmail.com>
Accept-Language: en-SE, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS4P279MB0403:EE_|SV0P279MB1388:EE_
x-ms-office365-filtering-correlation-id: 32f1bcd7-4c72-4fc9-a195-08dedbb5e064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|38070700021|18002099003|4143699003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 DRHXrizjOHdfOZqezYOyxKGx7fKQTC8sIpM52Uygg6vc6BQ9PsnofMouNzO1kl+rsvth2mHUhkCnOdYPIXhQUOfc3qqo/r4sRaHUttMO24G+hUMtTVmS78F2VrYrmYMVu4PIFChG7C5c6HYnj0K64wytyszXb+PWKJndNEkUyhEjAIjAfCa1GGONZ1MEp0IuazZPo2/ibjF07/jNnZRYoDI25fwfk8qpbWMZj+X5uoHRSxV67Gz4X6O0KM+FFzvm8I5y/BY0uIcMeQO9GZSz7ZUPyKDb+R/BApkN1scGoUYZ0dWPEHA4lClydXmCNiNpe3tZOcqzVqojIO3KwXmZtUkW41Ft5F+K6qbRlL0K24PKmYIczjJeBFIRY9N680AcVvRch3utbM2XNoYsUCuxitlVJJO9PLw8objMXSi7d8BbbI13D/aBxi6gPRgIzTo/FNXOkhParr0/HT0b5Hv+LEeQ3HjzLe9y/Qvx8l/97OoQHLvXxx4bra18WTBJWjrm4f5hc0vwOC7+S8ebRMp9gqrvjZKx+H5z5BvmARGnfgUpCZTZ6gKO4vDEiT5lHxlWsmHTDaAo96KoQHVGmcs38F8DS/qEJB+2v6wvYn75cQbIgMQiYt0Y6qC6+nX+S84ALroXnO2uCZMhIxm7uVmjcSD8M7philM5vT/MHBVVS7IfgfPQRQEoLj7nF3OZhPiO8bAl3Ks/UazJLShUDYER8SI/tGifZbRqRzDtGVRP7nw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS4P279MB0403.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(38070700021)(18002099003)(4143699003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFQ5NjBmQmNhdnNVRElQOExGRU9iRXF3d1NjSFNNaHB4UWc3T0RHc3FqSGJn?=
 =?utf-8?B?VFJJOVdzMWtsbXVneWlXSC96NW00ZnFwQzVqTjRMRmpCa2lUS0RyamRsKzd5?=
 =?utf-8?B?djVkWVpTamdhYzdTM1hjNGhKQWY0ZDRQSWRCV0ZWSzNqbmRCQ3lZMzhDaVlu?=
 =?utf-8?B?amdkMHU4a0F6VDRDTTQxRXFFZWpvb3lnRG1Jb0VLSmJDUmVscklFeURzZUxq?=
 =?utf-8?B?TlhRVFdIZEU5S2lxODBGanpNVmRJSjh5NXVGUG02N0JLZEtnK1Q2K0p1RHNp?=
 =?utf-8?B?TVMrS3hLcndDZ1dlbzdDSytLUG1XYjhrNmszRndlcU5wZkFPckcySUJCTDNN?=
 =?utf-8?B?NWNxc2VSZm5NRmMvVnlqUENmaUVreU9EdlZWWjFkUVc5ZXVmdjF1c0cycW9Z?=
 =?utf-8?B?Nm5qK1F2WWJTblF0OGorTmRWbTg2MnBPSUZWbHpJYm83UmYvRWV6dlpUNWpq?=
 =?utf-8?B?RXZWMDhET2RONXN6MHU0dEdQVzZRY3QvVEJMNmdHZjVFY25PdjV3ci84WlZB?=
 =?utf-8?B?cVhxT3FGMHZZT0VaMmNtWTNQY2lnWDltLzhHTktzMkM1NUJXWXN6RjNNcC9K?=
 =?utf-8?B?U2lySzRQRTRBSVdmLzczazJmbjdpSzVLa2xUTnA0YS9KbFFENU0zRmYwbTNO?=
 =?utf-8?B?T2RJTjNQQXQzVHhFNkZpYVFzUE1RMElVOGJtSy8yaWNXa2V2dDdPck1tNGhp?=
 =?utf-8?B?Z0NJTUZuVk5jQ2N1aWplWGVMelFPVmUrcVlQQzNNNjhwdGJQTVlLTlhqWkdq?=
 =?utf-8?B?L3RucDhscXNUYjJaV2tqMGI3NGtEcFJtY2FMN0cxMVNjT0RhSGZzUmowdGJN?=
 =?utf-8?B?WFIxTXNMR3EyWDdNVUFDTHlPZjZwb1J5WVJKN08xc1VCS1pZcThSMlBaZ3NO?=
 =?utf-8?B?aVdBQWhuWEM0MHRBSmpEZjZkcUtuc1l6UVJaOUJNazAwMGt4a3E0SDZ6N2Iz?=
 =?utf-8?B?cjZTL3NZRHNSdEV2ZUJXcmZySzhpZnRHOTcraThzak1wZGp1c3lwTmVIN3Zr?=
 =?utf-8?B?ZDZTZWxpQytrZGtSaExJTHlCaXBZVjJLM2dqbWN4cnNHWDVUUHo2SCtCTWZX?=
 =?utf-8?B?VG83ZHpOV011ejlXdkxyd1l6TUVydFFDUGpGYk9jaG9leWYrYk1XdmNqOXVt?=
 =?utf-8?B?azlPTTl3dXdPM0luMXRvMXZXYVVJMG5UWEZSbzRxZnBiemZOc3F0NDZpM1Y5?=
 =?utf-8?B?dzMwSjVrcWdRNUpNbjRiZUJmdjlmVzBvVmFtN0NSTHkzRGxrUkdXVG5MZDRX?=
 =?utf-8?B?ZEd0c283Si95TXdaNXJYenhSNFZlM05FS0pJbzl6eEJPTDYwckJJVzVKY0Q4?=
 =?utf-8?B?K3lTL09lVGxIZTNGT0xneDNNaEE4RUhUVGkrdERaODdXQWNsaTRuSHk1Nnc3?=
 =?utf-8?B?a2NBaTMvMi9tOEs3TGkwUlF1YzRoY1hhREtqUEtwK1d3L3l6eW56YnV1a3Ew?=
 =?utf-8?B?WEZuRWRJOWgxaVh2WDNqS0hYaWp1cWdhMm1UTzl0QTJxb29oRlcyR3crV2ZP?=
 =?utf-8?B?RXEzb0NEd0Ezay9aczRnRmZDL2NPY2l4ZVpBa3Z0dnNyR3ROVGhmUXhyTmpG?=
 =?utf-8?B?MWM4djJoN1Y4YjZXamVrelY4cm9mSmVHblJ6VjJ0TDFmMDVhSXlxV0RkbUdn?=
 =?utf-8?B?RFhzdGR5RHBMRnBxTFNKSWxWT0JONGc2VENLUHVJbGNaNHhvV21aL1ZtWWQ1?=
 =?utf-8?B?OHRwb3AxSmdyR0FFVWh5ai93K0U4MFkrc051RlkxYS9rZzJwcFphVXhER2lj?=
 =?utf-8?B?V09uWE5mNGJ4a0Nsc0JlUWxGaU1HaVhPQkV3eHJiTTZQcWxHZ1Y4ejhmekxF?=
 =?utf-8?B?WVZXVVJVR1RuVWJYSnk5U0d0YmxNOXcwNjVEZEREZkZnd0taK3FFY3pvbWhJ?=
 =?utf-8?B?dnByRFpHTXNrNzF1WW5aZDcwSXpyTlJ2SkRYSmg3Tm5nQTE1QU44RC9WSS9C?=
 =?utf-8?B?dlI1MUNLbDZXbm9USXZoWVZXWGI5TUQ2K0lPUG01N0JEZUxtbzNNZlNZM0w4?=
 =?utf-8?B?UERMcTdvbGdjelBQT2FTNVMybUkwdjVyZXBMbDJOakR1NFBvRWd1YVo0aFV5?=
 =?utf-8?B?ZlhKQlhkTzVTNWZzcjI5YjZZOU01VE9GeFVSK0w2RUI2RVRETVpSVTIvOTZG?=
 =?utf-8?B?YXZOR1VpS0QwVmNyS2daa3AyZXZZWjRxanlBR3NjaUIyWnhVeDRPdnlCdzJ0?=
 =?utf-8?B?eVBJYmcwVm8xYjlXQjNHZE1zVStKdUlxTk5ydk92QUpBNThLc2ZEWk9mZFNS?=
 =?utf-8?B?K1kyWVhWMi9rOUZKK1pkbzNwamdsOW9Va2Y5dFF5dndGdUlldEZxNnJSWmFH?=
 =?utf-8?B?dldPdXl0M2MrWmRrcVhuVG1IWVFTdmkzL3hhekxqVC9wa283ZzgzZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: paneda.se
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS4P279MB0403.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f1bcd7-4c72-4fc9-a195-08dedbb5e064
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2026 23:25:33.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e1ee824e-c05e-4daf-9c7f-12a2c63da8b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ThTDhp3VZfV3nz5RD+AZ0VtFPbH1x+wcTeUcdnK/zv8QP7MYzdT4fp0B6sIYaEpVPen5dQR9RbVzXHJ5Su+LIFf3K0WrAJo5zxBs9H4P2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SV0P279MB1388
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[PANEDA.onmicrosoft.com:s=selector1-PANEDA-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305240-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[paneda.se];
	FORGED_SENDER(0.00)[thomas.karlsson@paneda.se,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.karlsson@paneda.se,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[PANEDA.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378857164C2

SGVsbG8gWGlhbmcsCgpMZXQgbWUgZWxhYm9yYXRlIG9uIG91ciB1c2UtY2FzZSB3aXRoIGEgbGl0
dGxlIGV4YW1wbGUgY2FsY3VsYXRpb24uIExldHMgc2F5IG1lZGl1bSBsYXRlbmN5IHJlYWwtdGlt
ZSBhdWRpbyBzZW50IGF0IDFtcyBwZXIgcGFja2V0LiBUaGlzIHdvdWxkIGFtb3VudCB0byAxMDAw
IHBhY2tldHMgcGVyIHNlY29uZCBwZXIgc3RyZWFtLiBTY2FsaW5nIHRoYXQgdG8gNjAwLTgwMCB1
bmlxdWUgYXVkaW8gc3RyZWFtcyB3b3VsZCByZXN1bHQgaW4gNi04MDBrIHBwcy4gVGhpcyB3b3Vs
ZCBiZSBhIHR5cGljYWwgdXNlIGNhc2UgZm9yIG91ciBzZXJ2ZXJzLiBUaGUgbWFjdmxhbiBCQyBx
dWV1ZSBsZW4gbmVlZCBhZGp1c3RtZW50IHRvIGJlIGFibGUgdG8gc3dhbGxvdyBzaG9ydCBzY2hl
ZHVsaW5nL3Byb2Nlc3NpbmcgZGVsYXlzIGluIHRoZXNlIHdvcmtsb2FkcyBvciBwYWNrZXQgbG9z
cyBzdGFydCB0byBzaG93LiAKClN3aXRjaGluZyB0byBldmVuIGxvd2VyIGxhdGVuY3kgKGFsdGhv
dWdoIG5vdCByZWNvbW1lbmRlZCkgb3IgaW5jcmVhc2luZyB0aGUgbnVtYmVyIG9mIHVuaXF1ZSBz
dHJlYW1zIGNvdWxkIG9mIGNvdXJzZSBpbmNyZWFzZSB0aGUgbG9hZCBldmVuIGZ1cnRoZXIuCgpB
cyBmb3IgYSByZWNvbW1lbmRlZCB1cHBlciBsaW1pdCwgSSdtIG5vdCBzdXJlLiBMaWtlIEkgc2Fp
ZCwgd2UgdXNlIDEwMGsgdG9kYXkgYW5kIGFyZSBjdXJyZW50bHkgcnVubmluZyBvdXIgd29ya2xv
YWQgZXh0cmVtZWx5IHN0YWJsZSB3aXRoIHRoYXQuIERvIHdlIGhhdmUgc29tZSBtYXJnaW4gaW4g
dGhhdCBudW1iZXI/IFByb2JhYmx5LCBidXQgSSdtIG5vdCBhYmxlIHRvIHF1YW50aWZ5IGV4YWN0
bHkgaG93IG11Y2guCgpUbyBhY2NvdW50IGZvciBzb21lb25lIHVzaW5nIGl0IGV2ZW4gbW9yZSBh
Z2dyZXNzaXZlbHksIDEyOCBvciAyNTZrIGNvdWxkIHBlcmhhcHMgYmUgYSByZXNvbmFibGUgdXBw
ZXIgbGltaXQ/IAoKQmVzdCByZWdhcmRzLApUaG9tYXMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KRnJvbTrCoFhpYW5nIE1laSA8eG1laTVAYXN1LmVkdT4KU2VudDrC
oFR1ZXNkYXksIDcgSnVseSAyMDI2IDAwOjM0ClRvOsKgVGhvbWFzIEthcmxzc29uIDx0aG9tYXMu
a2FybHNzb25AcGFuZWRhLnNlPgpDYzrCoEFuZHJldyBMdW5uIDxhbmRyZXcrbmV0ZGV2QGx1bm4u
Y2g+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0
IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47
IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcg
PG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQXV0b25vbW91c0NvZGVTZWN1cml0eUBtaWNy
b3NvZnQuY29tIDxBdXRvbm9tb3VzQ29kZVNlY3VyaXR5QG1pY3Jvc29mdC5jb20+OyB0Z29waW5h
dGhAbGludXgubWljcm9zb2Z0LmNvbSA8dGdvcGluYXRoQGxpbnV4Lm1pY3Jvc29mdC5jb20+OyBr
eXNAbWljcm9zb2Z0LmNvbSA8a3lzQG1pY3Jvc29mdC5jb20+ClN1YmplY3Q6wqBSZTogW1BBVENI
IG5ldF0gbWFjdmxhbjogY2FwIElGTEFfTUFDVkxBTl9CQ19RVUVVRV9MRU4gdG8gYm91bmQgYnJv
YWRjYXN0IGJhY2tsb2cKwqAKT24gTW9uLCBKdWwgNiwgMjAyNiBhdCAzOjMx4oCvUE0gVGhvbWFz
IEthcmxzc29uCjx0aG9tYXMua2FybHNzb25AcGFuZWRhLnNlPiB3cm90ZToKPgo+IERlYXIgYWxs
LAo+Cj4gV2hpbGUgcmVzdHJpY3RpbmcgYSBsb3dlciBtYXggdGhhbiBNQVggVTMyIG1heSBiZSB3
YXJyYW50ZWQgdGhlIHByb3Bvc2VkIGxpbWl0IG9mIDQwOTYgaXMgd2F5IHRvbyBzbWFsbCBmb3Ig
aGlnaCB0aHJvdWdocHV0IG11bHRpY2FzdCB0cmFmZmljLgo+Cj4gV2UgY3VycmVudGx5IHJ1biBt
YW55IHByb2R1Y3Rpb24gc2VydmVycyB3aXRoIHRoZSBCQyBxdWV1ZSBsZW4gc2V0IHRvIGEgdmFs
dWUgb2YgMTAwIDAwMC4KPgoKVGhhbmtzLCBUaG9tYXMsIGZvciB5b3VyIGZlZWRiYWNrLiA0MDk2
IGNvdWxkIGJlIHNtYWxsLgpXZSB3b3VsZCBsaWtlIHRvIGhlYXIgeW91ciBzdWdnZXN0ZWQgdmFs
dWVzLCBhbmQgd2Ugd291bGQgbGlrZSB0byBkbwpzb21lIHRlc3RzIHdpdGggdGhlIHZhbHVlIHlv
dSBzdWdnZXN0LgoKWGlhbmcKCgo+Cj4gQmVzdCByZWdhcmRzLAo+IFRob21hcyBLYXJsc3Nvbgo+
Cj4KPiBTZW50IGZyb20gT3V0bG9vayBmb3IgQW5kcm9pZAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4gRnJvbTogWGlhbmcgTWVpIChNaWNyb3NvZnQpIDx4bWVpNUBhc3UuZWR1
Pgo+IFNlbnQ6IE1vbmRheSwgMDYgSnVseSAyMDI2IDIzOjI1OjU2Cj4gVG86IEFuZHJldyBMdW5u
IDxhbmRyZXcrbmV0ZGV2QGx1bm4uY2g+OyBEYXZpZCBTIC4gTWlsbGVyIDxkYXZlbUBkYXZlbWxv
ZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWIgS2ljaW5z
a2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4KPiBD
YzogVGhvbWFzIEthcmxzc29uIDx0aG9tYXMua2FybHNzb25AcGFuZWRhLnNlPjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZyA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBBdXRvbm9tb3VzQ29k
ZVNlY3VyaXR5QG1pY3Jvc29mdC5jb20gPEF1dG9ub21vdXNDb2RlU2VjdXJpdHlAbWljcm9zb2Z0
LmNvbT47IHRnb3BpbmF0aEBsaW51eC5taWNyb3NvZnQuY29tIDx0Z29waW5hdGhAbGludXgubWlj
cm9zb2Z0LmNvbT47IGt5c0BtaWNyb3NvZnQuY29tIDxreXNAbWljcm9zb2Z0LmNvbT47IFhpYW5n
IE1laSAoTWljcm9zb2Z0KSA8eG1laTVAYXN1LmVkdT4KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0XSBt
YWN2bGFuOiBjYXAgSUZMQV9NQUNWTEFOX0JDX1FVRVVFX0xFTiB0byBib3VuZCBicm9hZGNhc3Qg
YmFja2xvZwo+Cj4gVGhlIG5ldGxpbmsgcG9saWN5IGZvciBJRkxBX01BQ1ZMQU5fQkNfUVVFVUVf
TEVOIGFjY2VwdHMgYW55IHUzMiwgYW5kIHRoZQo+IHZhbHVlIGJlY29tZXMgcG9ydC0+YmNfcXVl
dWVfbGVuX3VzZWQsIHRoZSBvbmx5IGNhcCBvbiBob3cgbWFueSBza2JzCj4gbWFjdmxhbl9icm9h
ZGNhc3RfZW5xdWV1ZSgpIG1heSBxdWV1ZSBvbiBwb3J0LT5iY19xdWV1ZS4gQW4gdW5wcml2aWxl
Z2VkCj4gdXNlciBvd25pbmcgYSB1c2VyK25ldCBuYW1lc3BhY2UgKENBUF9ORVRfQURNSU4gaXMg
Y2hlY2tlZCBvbmx5IGFnYWluc3QKPiB0aGUgdGFyZ2V0IG5ldG5zKSBjYW4gc2V0IGl0IHRvIDB4
ZmZmZmZmZmYsIHNvIHRoZSBiYWNrbG9nIGNoZWNrIG5ldmVyCj4gdHJpcHMgYW5kIGV2ZXJ5IGJy
b2FkY2FzdCBmcmFtZSBpcyBza2JfY2xvbmUoKSdkIHdpdGggR0ZQX0FUT01JQyBhbmQKPiBxdWV1
ZWQuIFdoZW4gUlggc29mdGlycSBvdXRwYWNlcyB0aGUgYmNfd29yayBkcmFpbiAoZS5nLiBtYW55
IEFMTE1VTFRJCj4gbWFjdmxhbnMgdW5kZXIgYSBicm9hZGNhc3QgZmxvb2QpLCB0aGUgcXVldWUg
Z3Jvd3MgdW5ib3VuZGVkIGFuZAo+IE9PTXMvcGFuaWNzIHRoZSBob3N0Lgo+Cj4gQm91bmQgdGhl
IHZhbHVlIHdpdGggTkxBX1BPTElDWV9NQVgoKSBhdCA0MDk2LCA0eCB0aGUgZGVmYXVsdCBvZiAx
MDAwLgo+IFRoaXMga2VlcHMgaGVhZHJvb20gYWJvdmUgdGhlIGRlZmF1bHQgd2hpbGUgY2FwcGlu
ZyB0aGUgYmFja2xvZzsgdmFsdWVzCj4gYWJvdmUgdGhlIGNhcCBhcmUgbm93IHJlamVjdGVkIHdp
dGggLUVSQU5HRSBhdCBuZXRsaW5rIHBhcnNlIHRpbWUuCj4KPsKgwqAgT3V0IG9mIG1lbW9yeTog
S2lsbGVkIHByb2Nlc3MgMTQxIChzdSkgVUlEOjAKPsKgwqAgS2VybmVsIHBhbmljIC0gbm90IHN5
bmNpbmc6IFN5c3RlbSBpcyBkZWFkbG9ja2VkIG9uIG1lbW9yeQo+wqDCoCBDYWxsIFRyYWNlOgo+
wqDCoMKgIHZwYW5pYyAoa2VybmVsL3BhbmljLmM6NjUwKQo+wqDCoMKgIHBhbmljIChrZXJuZWwv
cGFuaWMuYzo3ODcpCj7CoMKgwqAgb3V0X29mX21lbW9yeSAobW0vb29tX2tpbGwuYzoxMTY2KQo+
wqDCoMKgIF9fYWxsb2NfZnJvemVuX3BhZ2VzX25vcHJvZiAobW0vcGFnZV9hbGxvYy5jOjQ5MTQp
Cj7CoMKgwqAgYWxsb2NfcGFnZXNfbXBvbCAobW0vbWVtcG9saWN5LmM6MjQ5MCkKPsKgwqDCoCBm
b2xpb19hbGxvY19ub3Byb2YgKG1tL21lbXBvbGljeS5jOjI1OTEpCj7CoMKgwqAgZmlsZW1hcF9m
YXVsdCAobW0vZmlsZW1hcC5jOjM1NjUpCj4KPiBGaXhlczogZDRiZmY3MmM4NDAxICgibWFjdmxh
bjogU3VwcG9ydCBmb3IgaGlnaCBtdWx0aWNhc3QgcGFja2V0IHJhdGUiKQo+IFJlcG9ydGVkLWJ5
OiBBdXRvbm9tb3VzQ29kZVNlY3VyaXR5QG1pY3Jvc29mdC5jb20KPiBTaWduZWQtb2ZmLWJ5OiBY
aWFuZyBNZWkgKE1pY3Jvc29mdCkgPHhtZWk1QGFzdS5lZHU+Cj4gLS0tCj7CoCBkcml2ZXJzL25l
dC9tYWN2bGFuLmMgfCAzICsrLQo+wqAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L21hY3ZsYW4uYyBiL2Ry
aXZlcnMvbmV0L21hY3ZsYW4uYwo+IGluZGV4IGM0MGZhMzMxODM2Yi4uZDRjZWRlNjM5M2IwIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L21hY3ZsYW4uYwo+ICsrKyBiL2RyaXZlcnMvbmV0L21h
Y3ZsYW4uYwo+IEBAIC0zNyw2ICszNyw3IEBACj7CoCAjZGVmaW5lIE1BQ1ZMQU5fSEFTSF9CSVRT
wqDCoMKgwqDCoMKgIDgKPsKgICNkZWZpbmUgTUFDVkxBTl9IQVNIX1NJWkXCoMKgwqDCoMKgwqAg
KDE8PE1BQ1ZMQU5fSEFTSF9CSVRTKQo+wqAgI2RlZmluZSBNQUNWTEFOX0RFRkFVTFRfQkNfUVVF
VUVfTEVOwqDCoMKgIDEwMDAKPiArI2RlZmluZSBNQUNWTEFOX01BWF9CQ19RVUVVRV9MRU7CoMKg
wqDCoMKgwqAgNDA5Ngo+Cj7CoCAjZGVmaW5lIE1BQ1ZMQU5fRl9QQVNTVEhSVcKgwqDCoMKgwqAg
MQo+wqAgI2RlZmluZSBNQUNWTEFOX0ZfQUREUkNIQU5HRcKgwqDCoCAyCj4gQEAgLTE3NTUsNyAr
MTc1Niw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbmxhX3BvbGljeSBtYWN2bGFuX3BvbGljeVtJ
RkxBX01BQ1ZMQU5fTUFYICsgMV0gPSB7Cj7CoMKgwqDCoMKgwqDCoMKgwqAgW0lGTEFfTUFDVkxB
Tl9NQUNBRERSXSA9IHsgLnR5cGUgPSBOTEFfQklOQVJZLCAubGVuID0gTUFYX0FERFJfTEVOIH0s
Cj7CoMKgwqDCoMKgwqDCoMKgwqAgW0lGTEFfTUFDVkxBTl9NQUNBRERSX0RBVEFdID0geyAudHlw
ZSA9IE5MQV9ORVNURUQgfSwKPsKgwqDCoMKgwqDCoMKgwqDCoCBbSUZMQV9NQUNWTEFOX01BQ0FE
RFJfQ09VTlRdID0geyAudHlwZSA9IE5MQV9VMzIgfSwKPiAtwqDCoMKgwqDCoMKgIFtJRkxBX01B
Q1ZMQU5fQkNfUVVFVUVfTEVOXSA9IHsgLnR5cGUgPSBOTEFfVTMyIH0sCj4gK8KgwqDCoMKgwqDC
oCBbSUZMQV9NQUNWTEFOX0JDX1FVRVVFX0xFTl0gPSBOTEFfUE9MSUNZX01BWChOTEFfVTMyLCBN
QUNWTEFOX01BWF9CQ19RVUVVRV9MRU4pLAo+wqDCoMKgwqDCoMKgwqDCoMKgIFtJRkxBX01BQ1ZM
QU5fQkNfUVVFVUVfTEVOX1VTRURdID0geyAudHlwZSA9IE5MQV9SRUpFQ1QgfSwKPsKgwqDCoMKg
wqDCoMKgwqDCoCBbSUZMQV9NQUNWTEFOX0JDX0NVVE9GRl0gPSB7IC50eXBlID0gTkxBX1MzMiB9
LAo+wqAgfTsKPiAtLQo+IDIuNDMuMAo+

