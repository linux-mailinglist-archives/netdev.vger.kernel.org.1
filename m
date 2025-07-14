Return-Path: <netdev+bounces-206620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B768B03BDE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92876163612
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F346E243968;
	Mon, 14 Jul 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JK6k9T78"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3719242D9B;
	Mon, 14 Jul 2025 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752488889; cv=fail; b=Rfbca/tpWqCQG3WHuDSpOh3qlo2I2mbnRXTwCNeDClyS9VH0e6FuMtnNpa3M4hHtzU25fTT7i/6qivYmvd2NOM6Sl+9gLr10uWsRMX69zPCvf2DAW33aV/F296E1yKL3fq7i627vcgjEmqFsovrWR1Vrs87M8aGFLC6yUJx+WWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752488889; c=relaxed/simple;
	bh=gIoNfKkzGE5IDKPLIDR6/xYhZKh3MGW1u9H959oooe8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i4nFwrxDyZ2rn0IVlnkA6i2YdJiE31dsDtNTtquL+Ly+WvVBTeWKqfhjDpcmjJrn4d/lrhjlblrn4INIViRX+G4dqVsJsMW9+/A0bDeWimKDlDGejdr4JWvL+wBLMN53+aoyvSlwwvbXquF7IanB/wv0Nf0OkCYPzHq+0SqOdBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JK6k9T78; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQpQvIe0gExMJpYekqhfxaQnLZqRYrdwBUJxFhKkEJkc/DsoX1tyYjV9Nrg+O2kqiTevms11tix8DOL6IxUCerOej8mbE3s+Z4jiIdgbSRDcMebNhM8emuV71MfZrPE49BigYTkP9DERY0JZ6FOA+Xn+xcftEzrafLN1dlWT0P8v7ebHCXnavWPNM7/82ak7c83R8jMGDRxuMubhH61xdO873Lq0iNgRe00euO7ktOUbQcQXON4MJkHPRL3FByqymd4rKRZX0PNIT3zAqzuvisYdLY7+3nQshTh5jAyUYxE4Wy2343OdQM6lk/6pkF+reXcBKnV1CU8sw6ZbLCdXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIoNfKkzGE5IDKPLIDR6/xYhZKh3MGW1u9H959oooe8=;
 b=E9hZTTPDxvC9iunwCnhdgJeClLF4/sObkSYwodt2iWAYpgefZtPFSi7KOtrZz/I9fhdA3yeTZMYQI69uFIF0TamIFtP8DjQ0BHOcUL5N9DAu+h5p5lG+W3Ai5hrnvBzOIVltPBc6pXolxcm0Iw6e0wsc4tu65RYmveDCRK+t/94bK8KxDhkjopai5j6Q94uZzqpPPvg+XiBL2cLY710bC0+8Zgonrv7Rp0fZDOwLUykApcCwn/O9AGijk7y0/7YyTo7MGzpYPCdMH32yHr2h9au50PNAt/O4PFRWmyrYIfVeFkSeAOupvnTjMjIy8NNN9ZSA0QgSsS17yXpqHK8dFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIoNfKkzGE5IDKPLIDR6/xYhZKh3MGW1u9H959oooe8=;
 b=JK6k9T78QJ9rcQ/fLAfFHLXghYj+sQcl74Xo9skeRbywWnAblaLZrJw44osT0qIc9TyVoB5JWf7hosxXQxmX3nSSJ0jY2yhHfklylKWqYSPfJ0ecSAQlZEZmD2X6kLxaxc/O2swTb/MJCJm9PNaWyO7EngAWUf4tXAslsdLg2q9P+CCd+Wjkg2l5YZovg3Exgya82Aw+46WM3RRTJReHX2/AvATglq7AWy9SYs1tRdXRKB4w/Q9qwXqcRQ8g68VhOR1Aya7LrRZn5WuVSLQWHgnj/LhEq09OfiiJzF07n86W6QxZfDZga7isJ+PYzo6DnutfJwgi+8wwF3JTlQf9CQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 10:28:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:28:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "F.S. Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8A=
Date: Mon, 14 Jul 2025 10:28:04 +0000
Message-ID:
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
In-Reply-To: <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DBBPR04MB7515:EE_
x-ms-office365-filtering-correlation-id: c3466fea-9061-40ac-ef48-08ddc2c11e4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnZESTFGcXZ0S1lKditUdFNLRnFsQmQzR0E2SFgxYk1ZblZEYkNGZEtSaHlG?=
 =?utf-8?B?dklHOGJKc2ZPd1Jya1AxNHV6OC9OQ3o3enVBaDBnUU5zQzUrSHh1cVJkUmJx?=
 =?utf-8?B?RE00Zjd5VEVsVFZqaEt0Mmhua3FPNnNHUmhicGlEOXM1VFZWS1ExbHVYZlk0?=
 =?utf-8?B?VTNLSTEwZHd0Z0pvaFlsU25uOVdvblBPbjBCbSszbWdCc1dMMFBUQVNpenNn?=
 =?utf-8?B?cnZrRU5ZZWg2QnRGTEw2UjFHdkdjU3pYQWhqRFNJM3JLTzBKbmNIYkJhNmZO?=
 =?utf-8?B?MXJsSXFJYkE1aTUrMVZnaTlSNXVOOUJJMXFTS1QrS3JOK3VVeDZuaXc0dEF4?=
 =?utf-8?B?YkF0dHVZcTBpcE5uUkZqWUozTWlWQUNvZEx2RHdxeUZQK0FxVUpqV244YWRZ?=
 =?utf-8?B?dTljdFY4SndtbmZoN1RQMjJFckpXRzQ1SlVSdU8rYjl2YnE0YWNJL3RRY3VZ?=
 =?utf-8?B?bkYzMVBDUmZuRk9VUk94NWdKRS9rMi9nWC9xN1B2K2hZMjBtaTd2djRzZnl5?=
 =?utf-8?B?Rkg1LzFabzk4RFRJQTExd3JZSEoyRHh5Z0xmeUYwa0JZVmQ2UzNjU3hlcnpJ?=
 =?utf-8?B?YzAvMkl0a0RIM3pLSWZUd1NwNzhYNVN6T2R0eXJscFI4bjd2ZUwrU2R0aFVY?=
 =?utf-8?B?SnBlUW0vSHF0Y0MxTVJVOWpnZzJoYTJWSGxwbjZCWFd0QjNSaGp6V05oZTg3?=
 =?utf-8?B?UHhwZ0sxLzJlVUwxL3VtNmF6MjRWbm1zaUs4UjkrMHNSaFNtQmZGQ3c3a0RR?=
 =?utf-8?B?dHlaZGR5WFJ2eE5oaXVtN05RSkt2NmtlSlExNzZvYUtsVVJCamJZd0hVekF1?=
 =?utf-8?B?VHNzRzJhMzZoUXkvYUgyeU9PNGx2aUlBT1Q4TDBQRGN6VkVRTEpzeGQvR1BW?=
 =?utf-8?B?YWV3ZW9lS1BSeEJGMUZob0ZUdmwzYkFLT0JWa0FCZE5saExhd3hnOWxvQ1A2?=
 =?utf-8?B?c2o3OFdFNU5RMmVXUWQ3TzZCYW13MmU5YkJPbFozTnBnYWR6S0dPbmw5ZkxN?=
 =?utf-8?B?MU9LQWNaeUQzaUJqL3RrVzJwUjRac3FYS0lpUUZ4YmEyRU54anViUldTT1da?=
 =?utf-8?B?QktsREdRUGt3UEVSK2VxN1dmUXBNUzNHeHZ3QzU3NzBQaEMrK0tWSXd5RENl?=
 =?utf-8?B?RVpQV3RWTzVpcWRTWFpQdTRGZURHTDhUY25ObjIxQmdHVmV5YVBJRWJ2eVhB?=
 =?utf-8?B?aDdEVnUzeUNXMko5ZGpzSlBlbFNCUmJyckpxMitOVjIrQjhQNXorZGpKREo5?=
 =?utf-8?B?c0xUdkJvOG1BZHNNSW1xM1hDMVgvcmRxUVJseXZVVnpYbUhxYkpQU0o1ek5S?=
 =?utf-8?B?eFJRZU43eFFSMU55QlZyWmI0VGt4aEJxblhqTVRydEFQUGRMdlc4WE5pT2dK?=
 =?utf-8?B?VlFmMUxmeVJNSjM5QXloMVVtdlAzWEtCVDhJTHRyRFpBQ0tJa0JhZEFjZDls?=
 =?utf-8?B?aEJrZWExMEYrK3NUdFdhdmpKa3JMM3IvY1hXb0dCc0FJYXNWbUVCL2hSbmVt?=
 =?utf-8?B?cCtRTWdLWU9XL2wzVTRiS3g2ems2YW1MREtvMTVuQXI3cm85RUxORzM0bm8x?=
 =?utf-8?B?TVJ1TlVIQ3d4NDBwRENzakE5NGlXT2lJc3lSZ3JKWVM1ODVRU3RsVmFRSHRO?=
 =?utf-8?B?bWtJWnBoQXdjYkt5MUJSaVhabzVmOUVrT3ljTG5qT29hRmxVcllOUCtRVVhH?=
 =?utf-8?B?U0MwZ0JpcWEwSlRjQThUT1haa2RncVBBRHdpbGRhQ1NLUUlOd1R4ZHRJOXNY?=
 =?utf-8?B?dzVzL1FrcnY2Mzc5U3pqc3A3bW43eGpEc0FEenRaNUJyVkZtR243eWZ4cFJZ?=
 =?utf-8?B?WGk0NXlNVXhsRk55MFZIWEl2QnFvSVVJMFI0TS9WZENmelV1bGxFajBWSDNI?=
 =?utf-8?B?eDJmV2k2Wk5lNDhWdWJRTmFtbnZXM09QTW5VKzBGWU5hQk9Pb3haaUZWaFUv?=
 =?utf-8?B?NUhlQmYxVXlRUVBTU3hFcUtpN2M2UlJMSUFQa2MvMkM4d2JLRFFXSHdkdFBQ?=
 =?utf-8?B?UWtFZHVPazRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWZtd3lsV0hiaXlhY3lRVlhCSVc4RE5uOXRjUFFCNmhBblZGR0UyWUZNeitW?=
 =?utf-8?B?NERiZHl2Q1c2djdvUTVJd3pjeHZCQ1NqUDExYW82R2tiWlB2LzZUSU9rcnAx?=
 =?utf-8?B?UE9xRElmNVltZTFnNjVMeFRjck03eFQ4VG1wNkhUenkwS1R0WU4xSVcxMTA2?=
 =?utf-8?B?cXZ5OTRGWGhEOGJUVG1jWjRlTE9GMnI3ay9LbktmaGszMG8xQ0JsVDRySVo2?=
 =?utf-8?B?K3p2a2k3d1g3VjRsWDZUNlN5WXc0VXZVRW1nVUY3YzF6c2FUcHhoM2daeVFH?=
 =?utf-8?B?RityTlRVeFo2bm0wcWU1SHI3YXNVSGdBaVlWNGJFV2l3cm90TVcwQVAxblZj?=
 =?utf-8?B?TGw4SS91YTNaUTFvd2NrUWsvTDV5a2FVSHZTYWJKV1BERC9hSTlWRDMrK2Ju?=
 =?utf-8?B?Y2hXWTdWUGovd043RUU4RklqNzdBd2VXTjlpYXFJK01keGZzT0N1b1pPemFK?=
 =?utf-8?B?Yi81aFVrQkFaRmErY1hDZnRXTDhKMW5wT3FCUmFZa3JVSDRZMGNtSVZ5M3RZ?=
 =?utf-8?B?UGQ3ME93Si9VV2VuS2k3Z1RMdVFucjR3Vk4rKzdsZFkwUUU2MVBOU2ZnbzJT?=
 =?utf-8?B?SllUeTlST0lEUUdqVjE4YXRNRk8zbC92Vk5OSWNsams0dU5Ec3ZUQUR5aHRZ?=
 =?utf-8?B?TFVkakp2NUttQ1kzR0VUU3Z0Smd4dlRWemVGelFCL2g0c2RoVVgxejFpbGJh?=
 =?utf-8?B?VWdqTXBSM2VQTzJsR1hHaFBIU2FoNDJUc3MzdlRQZERCeGZZaWtHQm9GdWFr?=
 =?utf-8?B?cmorVFZsWkFpVytwNCtZOVgzRWswRFBKK3RmeFJQT2VQRCsrVzMvdzNaS05D?=
 =?utf-8?B?Z0lzL0FxQWtRM2J3UjJUdmxOUGcrZjloNjRNVzFBbDRDVG5uZ2NSUzFPYWo3?=
 =?utf-8?B?dm05N1NUdVBzRnE4SXlvQ05LWUtZRDA5dWh3K1dBYXBUNHpqb2tvQzBSNW1W?=
 =?utf-8?B?Yjkwd2lSNHZXT21FR2h5NVU4aEJ2MFphS0R2N05EN09nNWt5aVVuZTRBc0lL?=
 =?utf-8?B?aDNNRU1jUmM1N1p2ODVFR1NDN2llcmYyZng0YjczNGJtKzhMa00xK1ZFUURj?=
 =?utf-8?B?YVhxcjFjLzZmeUttQ3N5U1NyWm5ialJWWWIwcUhTdGdzeGFoUkVzelNLK2o3?=
 =?utf-8?B?bFRMdU1yMVZPeUJPaXhPa2R1K2xVR1NMT1czS1BnNnQ5Y2k0aWRWcStEVVNZ?=
 =?utf-8?B?UW4vaWxGK3lIT0VuNG5FWVRzbFdzYzRoKzFpUG1mUlN5c05BQ3hzMDU5QUcy?=
 =?utf-8?B?OFR3MnlENHBqdjUrcDk3TEVRekVrdGFYTUI5WTlCYnpSaFpFZGtlNENuRUNS?=
 =?utf-8?B?UlJJb0ZUVzFmTGxkb0dlY1VHaUpQSkFxNE1IMGg5Q09VRTZ5cnNhN0Y0ak9l?=
 =?utf-8?B?UW1FVGZpUkhQRFNBTzFVLzE3WGpFRnlwVWtvSGJ2N3lTLzk1eHc1c2xxT01T?=
 =?utf-8?B?b3d2b2FkdnJPTnJ5L1FualJ2N0NGd240UVYwMGdvYjVNODhPWGFHK3daKytk?=
 =?utf-8?B?VnhHQkhFRkp1MWZvZkUzSjVxZmVkcncxTTI4UFlMbjlJbXR1TkRsbVVRNk5a?=
 =?utf-8?B?aFBxdU5Bd1NueHJhL2VuZDRRWUhLejBuQTVnVDhxSzgwVzVwa0IxckVNMmtO?=
 =?utf-8?B?RGR4WUN2R2R5eSs0b25xazBvdHlmVXBGeFFBK2pkS2VRZFZsUC9xaWM4Tis3?=
 =?utf-8?B?UUM3Tkp6a01UNE1vUUgwMVVBcU1PZ2hTbFhXcmdKM0xmblIrQUZwZ09aVTJB?=
 =?utf-8?B?TUpXcE1iYk5ZWGdJc1hvenBPTEY2S1NJcGtVWittUFVpNXF4UFN0S1BTVHNY?=
 =?utf-8?B?dzJwWm90N0VWNHNibUFoUGh1MGVPYmVwNlBpTFdKa2E4VGRvbUpmb0gvMFpx?=
 =?utf-8?B?clA1ajN0bXlFT1dvZExPTFhVZDBzaDdub2ZRdXplVXpuQTJ2STRXaGJITXlT?=
 =?utf-8?B?OEEyUTRpelZpNUg1SUg1MjRCV3Nxdk1ENytNVHZiSHZSSzlwai9VamV3YVBn?=
 =?utf-8?B?Ly92elM0ZjBzN3dlTGFNSDVsbXh6ZkNJYUY2UGo5VGQ1Mi9lOHlDeTRNRW5o?=
 =?utf-8?B?ekNraEVwbUxHRnI4T3BVWDBxNkJNN2kxREoxZ2t2YlBuYTIzQ0wwQTRQV3cw?=
 =?utf-8?Q?IG68=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3466fea-9061-40ac-ef48-08ddc2c11e4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:28:04.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihJTAseoDXo3QDzkRgSy6a24PcOMyMcmo4auogmvqFbWZjrg2kpJQC/adByB7HKMpxoOHMX4t3X/CI6N5s/oQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

PiA+PiBIb3cgZG9lcyB0aGUgb3RoZXIgY29uc3VtZXIgLSBldGhlcm5ldCAtIHJlZmVyZW5jZSB0
aGlzIG9uZSBoZXJlPyBQYXN0ZQ0KPiA+PiBjb21wbGV0ZSBEVFMgb2YgdGhpcyBhbmQgdXNlcnMs
IG90aGVyd2lzZSBpdCBpcyBqdXN0IHBpbmctcG9uZw0KPiA+PiBkaXNjdXNzaW9uIHdoZXJlIHlv
dSBwdXQganVzdCBhIGxpdHRsZSBlZmZvcnQgdG8gYm91bmNlIGJhY2sgbXkgcXVlc3Rpb24uDQo+
ID4NCj4gPiBCZWxvdyBpcyB0aGUgRFRTIG5vZGUgb2YgZW5ldGMgKGV0aGVybmV0IGRldmljZSkg
YW5kIHRpbWVyIG5vZGUuDQo+ID4NCj4gPiBlbmV0Y19wb3J0MDogZXRoZXJuZXRAMCwwIHsNCj4g
PiAJY29tcGF0aWJsZSA9ICJwY2kxMTMxLGUxMDEiOw0KPiA+IAlyZWcgPSA8MHgwMDAwMDAgMCAw
IDAgMD47DQo+ID4gCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gCXBpbmN0cmwtMCA9
IDwmcGluY3RybF9lbmV0YzA+Ow0KPiA+IAlwaHktaGFuZGxlID0gPCZldGhwaHkwPjsNCj4gPiAJ
cGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPiA+IAlzdGF0dXMgPSAib2theSI7DQo+IA0KPiBIb3cg
ZG8geW91IHVzZSBuZXRjX3RpbWVyIGluIHN1Y2ggY2FzZT8NCj4gDQo+ID4gfTsNCj4gPg0KPiA+
IG5ldGNfdGltZXI6IGV0aGVybmV0QDE4LDAgew0KPiA+IAljb21wYXRpYmxlID0gInBjaTExMzEs
ZWUwMiI7DQo+ID4gCXJlZyA9IDwweDAwYzAwMCAwIDAgMCAwPjsNCj4gPiAJY2xvY2tzID0gPCZu
ZXRjX3N5c3RlbTMzM20+Ow0KPiA+IAljbG9jay1uYW1lcyA9ICJzeXN0ZW0iOw0KPiA+IH07DQo+
ID4NCj4gPiBDdXJyZW50bHksIHRoZSBlbmV0YyBkcml2ZXIgdXNlcyB0aGUgUENJZSBkZXZpY2Ug
bnVtYmVyIGFuZCBmdW5jdGlvbiBudW1iZXINCj4gPiBvZiB0aGUgVGltZXIgdG8gb2J0YWluIHRo
ZSBUaW1lciBkZXZpY2UsIHNvIHRoZXJlIGlzIG5vIHJlbGF0ZWQgYmluZGluZyBpbiBEVFMuDQo+
IA0KPiBTbyB5b3UganVzdCB0aWdodGx5IGNvdXBsZWQgdGhlc2UgZGV2aWNlcy4gTG9va3MgcG9v
ciBkZXNpZ24gZm9yIG1lLCBidXQNCj4geW91ciBjaG9pY2UuIEFueXdheSwgdGhlbiB1c2UgdGhh
dCBjaGFubmVsIGFzIGluZm9ybWF0aW9uIHRvIHBhc3MgdGhlDQo+IHBpbi90aW1lci9jaGFubmVs
IG51bWJlci4gWW91IGRvIG5vdCBnZXQgYSBuZXcgcHJvcGVydHkgZm9yIHRoYXQuDQo+IA0KDQpJ
IGRvIG5vdCB1bmRlcnN0YW5kLCB0aGUgcHJvcGVydHkgaXMgdG8gaW5kaWNhdGUgd2hpY2ggcGlu
IHRoZSBib2FyZCBpcw0KdXNlZCB0byBvdXQgUFBTIHNpZ25hbCwgYXMgSSBzYWlkIGVhcmxpZXIs
IHRoZXNlIHBpbnMgYXJlIG11bHRpcGxleGVkIHdpdGgNCm90aGVyIGRldmljZXMsIHNvIGRpZmZl
cmVudCBib2FyZCBkZXNpZ24gbWF5IHVzZSBkaWZmZXJlbnQgcGlucyB0byBvdXQNCnRoaXMgUFBT
IHNpZ25hbC4NCg0KVGhlIFBQUyBpbnRlcmZhY2UgKGVjaG8geCA+IC9zeXMvY2xhc3MvcHRwL3B0
cDAvcHBzX2VuYWJsZSkgcHJvdmlkZWQNCmJ5IHRoZSBjdXJyZW50IFBUUCBmcmFtZXdvcmsgb25s
eSBzdXBwb3J0cyBlbmFibGluZyBvciBkaXNhYmxpbmcgdGhlDQpQUFMgc2lnbmFsLiBUaGlzIGlz
IG9idmlvdXNseSBsaW1pdGVkIGZvciBQVFAgZGV2aWNlcyB3aXRoIG11bHRpcGxlIGNoYW5uZWxz
Lg0KDQo+ID4gSW4gdGhlIGZ1dHVyZSwgd2UgcGxhbiB0byBhZGQgcGhhbmRsZSB0byB0aGUgZW5l
dGMgZG9jdW1lbnQgdG8gYmluZCBlbmV0Yw0KPiA+IGFuZCBUaW1lciwgYmVjYXVzZSB0aGVyZSB3
aWxsIGJlIG11bHRpcGxlIFRpbWVyIGluc3RhbmNlcyBvbiBzdWJzZXF1ZW50DQo+ID4gcGxhdGZv
cm1zLg0KPiANCj4gQmluZGluZ3MgbXVzdCBiZSBjb21wbGV0ZSwgbm90ICJpbiB0aGUgZnV0dXJl
IiBidXQgbm93LiBTdGFydCBzZW5kaW5nDQo+IGNvbXBsZXRlIHdvcmssIHNvIHdlIHdvbid0IGhh
dmUgdG8gZ3Vlc3MgaXQuDQo+IA0KPiA+DQo+ID4gQnV0IHdoYXQgSSB3YW50IHRvIHNheSBpcyB0
aGF0ICJueHAscHBzLWNoYW5uZWwiIGlzIHVzZWQgdG8gc3BlY2lmeSB3aGljaA0KPiANCj4gVGhl
cmUgaXMgbm8gdXNlciBpbiB5b3VyIERUUyBvZiBueHAscHBzLWNoYW5uZWwuDQo+IA0KVGhlIHVz
ZXIgaXMgdGhlIFBUUCBkZXZpY2UgaXRzZWxmLg0KDQo=

