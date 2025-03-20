Return-Path: <netdev+bounces-176398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56664A6A0E4
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 09:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE86189D175
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 08:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B6205AA5;
	Thu, 20 Mar 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fTdjWHGq"
X-Original-To: netdev@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023100.outbound.protection.outlook.com [40.107.44.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2D17991;
	Thu, 20 Mar 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742457784; cv=fail; b=g58cDRxSM54AtTSdy2/g9Yr1olnEYzDsExaML2WzuKulwcRXlBQY4wcK3DvpjCIvxghM59K9ouaorlymCiFdbBCr/J+bHEubXe1q7atocrUrIfCLviAgMKMWUQosy4ckRAtag0UXJUYYgTvlAqQ5U8HXtyd9d1CwMU2PQF8bBOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742457784; c=relaxed/simple;
	bh=G6wpwEq/YzWn8sdrEY9VDeADhrJzIJVOBhCW2OwmVWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Il2Q81kub3HO25OCmnO6EX4ZdZsSKIuDhWzB13lza0nybkIEWFErh+iS1QyIfFW/oqwbaFyUqikWSXB1g6Cp7EMWCAg862VxZt1WQPoSmcB7bSpLr591EHCTaKYStJD7g9DYC1C99hZUv5JdUighebbf132OPXX2ym1cx9+AbrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fTdjWHGq; arc=fail smtp.client-ip=40.107.44.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7pqupRrn2yCBNPGoppp5ZWJCoFeifm+nVh/QwcE+ZGlXDBmkssS0289ExU6ASQALq0dPfGoXcv92wv5EvLvoVkq5TqdnyoclvlOltmZYD6MpjoDc3RGZx21ZV9IpiROXcMZavPyla2FMRZtqUjqajr32wGZIq3n4FbxGSBl0SbDArmzeUdLtCs0034G1GfSKpre1BjWQnYVDUX6xATUhTi+xMqu4SqPnsSy5BEJWjNxK1CXuJSWcoA8q9H+4Ku3KEgHuhef8rk1INWktbV6UQC0aDUdf4Ha6E5ULqdkH0JrT/mKkzUuru6blwXrQaCzFvRxnRr4o+8A2h3UdwaX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6wpwEq/YzWn8sdrEY9VDeADhrJzIJVOBhCW2OwmVWQ=;
 b=oD72Jd7GXnX6mKDR7KkM55I8zfOp1lNYT5RIPHaKNhambkBfFUDyPI2GLBGFUV6Zgp3yt+HbK2fA1h/nl0DTWtF7L2DrlizLUwo9jnc9SVtkq8PUz1aYCzlh8mVDT+o+cDHWhH4v55CXDlJeAc2MjlrdHyjUTCeYUPfQt7hjm4mBdPeXFE8/UmRNj9pCGmwpJdmd6+ldz5s1/ZqvwjTU4XaIYH6H8An/tu1VkxfxMbnYxBDXtrFCvdEM2WWqByqVpmIcMdNVp9WIbiaHow/Uw6PTxr0DY7dWJuWBXt2NzQasmEodueYCK6d0qxbEYJtfaROFd75kpbw/lChOMHEPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6wpwEq/YzWn8sdrEY9VDeADhrJzIJVOBhCW2OwmVWQ=;
 b=fTdjWHGqjEo7CMB3yJV5mFi9qdm22UDvh8sdP/rUKaAezH0xdHRe74ui9LQa3NWZelXfXLBExcXzqQvi4JblGOKFw0E0deKLFa+dkx79EqonqfcIKcpZFsjEJd3RvR1qNEMFc7N9W9J+EGGVloGROUtLth+VSkqvTcz4N4RVo+OXd5rW43NtHpJ+ALT4H4ic3ODen5IvHFWxVOkhx3bAlZ6zSquku+XYfhREtBpMbz0TCHkjJ1pKOOsTGgr3NERLpc2J8b1k1parvRpQ8kj1NUMzAXWoqp6WWrT21zwOWpXNdyyRKlytygUJZ/k88Pe42IQQ/H9QwVeUOkx52tWn+Q==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by PS1PPFEF7C8A25D.apcprd06.prod.outlook.com (2603:1096:308::26c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 08:02:52 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:02:52 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "ratbert@faraday-tech.com"
	<ratbert@faraday-tech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, BMC-SW <BMC-SW@aspeedtech.com>
Subject:
 =?big5?B?pl7C0Dogpl7C0DogW25ldC1uZXh0IDIvNF0gQVJNOiBkdHM6IGFzdDI2MDAtZXZi?=
 =?big5?Q?:_add_default_RGMII_delay?=
Thread-Topic:
 =?big5?B?pl7C0DogW25ldC1uZXh0IDIvNF0gQVJNOiBkdHM6IGFzdDI2MDAtZXZiOiBhZGQg?=
 =?big5?Q?default_RGMII_delay?=
Thread-Index: AQHbluiaGC/JF+mxZkSS5mpUqJVheLN3TZeAgAFq1tCAADavgIACv42w
Date: Thu, 20 Mar 2025 08:02:52 +0000
Message-ID:
 <SEYPR06MB5134848FBE9454B23E15265A9DD82@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
 <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
 <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8c0195dd-50b3-4f30-a021-c5b77d39d895@lunn.ch>
In-Reply-To: <8c0195dd-50b3-4f30-a021-c5b77d39d895@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|PS1PPFEF7C8A25D:EE_
x-ms-office365-filtering-correlation-id: 32c798a3-c522-470b-88d1-08dd67859d54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?RlRPcDZhOEJnSWw1dmUrekprOXFCRHRpQ3BFemtkaS9VU0tQai9oVjgyWUErTUkx?=
 =?big5?B?SEVlZHhaOGJmTjdvb0dTMTVXeWV1WmJ5SjZEd3g3TmtwanJqRXBtcVlZaUFnMm9G?=
 =?big5?B?TU5rZkZ1bkEycUZVOENNN3RSczZUQW9yQjRwemVHRzB0MW5hdExjbUFENFZ3U1BQ?=
 =?big5?B?eUJyMFFaNUxWNFR1a3JqMDBIUVhBa0psalgwc29PYjdEWmtjazl0UGxNZWxkM1Zj?=
 =?big5?B?Ty9CU0JPb1Q0NzlKTzM2cW1LOElDbmM5N3NmcW0yV3ViYnNmVWFOTEZFRnRjV3ph?=
 =?big5?B?V3Y1cUNweDZBNCszSGtxNmlYMHpIdFQ2MnhhUEcrQkl1NGFueE5lMHBvdXBJNU5i?=
 =?big5?B?OXV6dWpEaUtxTnlZelNxT1RzOWM3WHR6S0E2YzV4RFhSSFNnQmRYNVF4VHg4b1dp?=
 =?big5?B?aGUxa2x5ZzdRMGZCRy9pYml4c2RmMU8xOTdKN1h5MEgvQnc5cGEyTDNHQ2twWVRr?=
 =?big5?B?bmxPR2oyRE0yaTFJY2NkZkY5bCtINHhDcUZXSWUvL0l5OVo3WGc2U01ydDF0clV1?=
 =?big5?B?bU1RV0pwcTZhMnk4cGlyRERPcEp4YklQbytZSUhzZzFXdm5IK2svQUpFSnJwcUZJ?=
 =?big5?B?NUJ5TlpQbi9kS2lUUzcveXIxVnhNRS9HbkJTRlg3blRRUFJBTmVpVm1Xenl6L01m?=
 =?big5?B?bTlJcG00VTJqQlJoMHVYSXpXZFlkMUZyTlp4ay9JYmlJa1ZRa0FkUHNSUjk0a3FZ?=
 =?big5?B?OHFJQVorK2NYeFBJTCtkWEZMdzZhSlRSM3htK2dBRjNpNFZVOTVzeUI4U0hjMHpE?=
 =?big5?B?VDlLRHd2SWVoQktoV0d5RGg0OTY0NmRhMkwyYm9jeEJldUN4SU5UeEVxUXoyTEZv?=
 =?big5?B?V1RHTHhFUUNOdm0vNnJycXRMRlZNR1dmMGdFSGgvRk5aWlN6aklUR1dKOHFGQXJ6?=
 =?big5?B?enZpb2dqODhNanR1K3EzempRcGxQcTNEdnN1dSswbERuclNISlladWhpYjBGYVpB?=
 =?big5?B?S0dDaTcrMElWUjFUQTBWTThwcFVCM3RBOTF5R1hWenVXZmhOTFUyRHNxSkd5bGg0?=
 =?big5?B?Nnk1d05laUFSaGNHRWJhTUpndjlldFhKNE1XT0VrY3dDQ3RiVTR2U2o5ekp5TVBT?=
 =?big5?B?U1JxbUJwN1F0cEo1am9RZkF6UmRqZkRXQzNjMitkcUVOVTBaZHd0bWdzSlNlZy9C?=
 =?big5?B?cDlWeTk0OGZwUmU4QVRjcnJ6MXd0MThvUDdhMThQYzVzUFNnWU9KNlZ0aHNBd1hv?=
 =?big5?B?aXRUUkRVcFZVREM4bVNpOGpXSGZPK0hyRlE1RzFiUVNqNC9RSXgwcXBjMXNuaW9u?=
 =?big5?B?Kyt1S2F1azREOE5YenkwaXJPUC96bElwY05UQnRmS2xqUE9jTVJDdTJ2YUc5eEFT?=
 =?big5?B?dUx2amU5bHV1eWRWMUExZWFrQWlDRk9BNW1TRDhGRmtWQVl4WDNxVVZnMUtxWXpR?=
 =?big5?B?aHdmMk9MM0tBUVBIbXVNVnRzUWRkWit0cEwrekxOSnMyQ0ZlNjlRM1EwR1NmUm9v?=
 =?big5?B?VlNvVWs4KzFqOHdMRnMwVjNuNndPR00wSWlrUmkrUEduZVNwMFJYOGdqZWkzQXdC?=
 =?big5?B?a3RGTzVVdzJvODNTeUJvNDJUeThTSWhjcklNR0E3VVdMNDEvTGZxYlpiWHNibEQw?=
 =?big5?B?VGg3Ulo1ZFhTT2QyNW82Mzg5ak9vUGtRT0RicjVsK3ZHWk44b3g2TjlRVUhHZU5t?=
 =?big5?B?VHFsOVhhL0l2ekhnS0hSeThQdSthU29mbE9kcm1QdU1VbVRYclRoSzYwRmhUVksx?=
 =?big5?B?dmQ3eHduU1Q2L0ZDWWVlUnFXWUxVUnp6dkJyV0tjbkRXcUIxYkZYdzNiY2VqUEs1?=
 =?big5?B?K2tIVjJsR1dSTnllTTBDYjJDdFI5WmtBL2dlZlJYRW5pYS9MdkNFSStUSG04VUdh?=
 =?big5?Q?hgDqJQoTOBQIvl2gK24RGicNMOgfDFE7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?SDcyNFk1YlRaS1dYZy9BUUZYcFl0STZiSkthaTlIRjVKL1h5cHY0TmNzS0h0Y3Ry?=
 =?big5?B?QXFhWWVJWTRnWDBNYzgzRmRZQ0NKQUhpNklZdHVIUHBHZjFObDE1aXgzOGZYRzFz?=
 =?big5?B?QzRYdjlwQlNyVHh5M0F2TW1nQWxtaVdObGxlSDczNmRORFpZaXk0L2F3bHVvNzFh?=
 =?big5?B?d05JSDl0VXgvZVVtajdCbUxUcEFrTHBranovVGRzOU81ZERudWdxNUZ3VVR2ME1j?=
 =?big5?B?Rkg0MjdHS0xVRk9EN2pIZ3dxdWJYNVRWT3BoT3B0OERmQmZITmxHWjVBQTZ1eHZx?=
 =?big5?B?dGlMb3BqVDFMVEQ4K3Y3eHRJUkQ3R0pTZ2pYaFZqTVV2dDZwamRUQnBsQVV5WFJs?=
 =?big5?B?a3FveHZUSWRSOGJvT1BCQzN0bFFSVVh1clEvbk1zUEpvUGNLUkNVTzJjMjBxZ25j?=
 =?big5?B?TnVUWFZCQXM3ejZzUlFWUU10bDJodEtYVjNvTVNha3NnaVFlQzByQ2puT09zdkdV?=
 =?big5?B?Ry9KcXU5NTcvSVUxUWt2UnY0eEtsUFY4UmVRcFM1aTlvT3kyakJIWUNLUUJ0L2pD?=
 =?big5?B?YWZ0NXQvWnJqVmNVZG1qVnpiRXBrOSs1R3FQUmFBTHk5NjFHNW1rNjkvWktoUzlI?=
 =?big5?B?dk5sdUtRWmROZHJtdExhVVVSWERHZ3R3VFpBWTE1b28zb0hwbkZTWXBYb2gycCtR?=
 =?big5?B?b2cyL1F0ZVkxYWRsT2dmcTJqT09OUEE1QkhtVGR1U1RMY0l6SytLQXJpWkpvcTdD?=
 =?big5?B?YWlmN1FmTjVZVWl3ajl2S3BLK0s5UXVpZXg2bUVQNlVjajUyd0FiUjdTVkdkTlZF?=
 =?big5?B?aVZONjQzU1VOdWl3QmFyTkgwY3QwcEN2bHd0N3VZa2NTeXA2ZXY5MElKc2Nkc0NQ?=
 =?big5?B?WlZqVThuMDJVaG1Nc2t0UG1COW1HKzFndTB5a2daV1R3WW5wVW40TW1heUg5NEhK?=
 =?big5?B?Y3pCelhrUmZKRjNtNDl4UWV0V0ZBL3ErdjNmaWtPZkdsR1Z6c0d3VmdMVnZFd1lv?=
 =?big5?B?Sit2eWhKQmJaK3pTeVY1cHNGaURCZDVNNUVpRGdUUjRxR25IdW8zdGxweFFxYlhv?=
 =?big5?B?bGpjNHMxWmExUXQ5TUplRDBqVUZRYys4Tkh6L1BZMjBjSnRWZncvNWxiR1JySG1G?=
 =?big5?B?dERSVlhaNDZ5OStnQzJGTVc5V0xYeXdsVXkyRHAzYTYzUFZGTkpQZjVXNEFhbHl2?=
 =?big5?B?bWQwc1p0bVNTMjU0RTh3d002Y2t6N0NPM2FlU3N2b0VWcnZ3SGJBWHBXTzZkWFZD?=
 =?big5?B?M2ZYSzVRYnd3ZkFMbDR3ZGlTT2ZpNEFheFI4dlEwU3hvNlN4MGZXOU15UDBZSTJs?=
 =?big5?B?T0NIWmdxU3pNdHYxcFBxNWlvc25MMkdpWWRFRTdGcmgzVy9UUkt0bkJ0cHhpWW4z?=
 =?big5?B?R2plQ2l0ZnB6NXgza2YxZFlTTWJiS2ZxMitnOFNQdTcrMmVtM3ZIWnozVXlzR002?=
 =?big5?B?elVXS3hxUVo0NmRJSmVkalRpZFA4N2p4RmVGUU1aY2xETThINy9lazYybGJSdzJM?=
 =?big5?B?ZTZzbzhqUUl4bDl4b25wbFRveXVzdXI4ejROSDUrVnlqNDBGblplV21mVkhjOURk?=
 =?big5?B?bUo0MTNPNXFoSXkwRzdyNFcrZ3VtTEdITzdiRGQwNmZMVGdYWUpHMWFUL2Z6VXd5?=
 =?big5?B?dUszNkwya085MFRUbDd6Y0E5TUV6VHd4U3IzYWRXeGJhMFJXYVE2R1NmV3h4R0th?=
 =?big5?B?QnZEU21ERmx4WGNjcVZXd2QydEZsR043d0dkS1dOSG9ZV1dqVUdkOE1ORkJlRTg4?=
 =?big5?B?eVhKNDM2L3o2K1FqM3BXc1VQSm56M01xdHh5RG1WWFI2Yk5FMUoyREU1cTBIeTNN?=
 =?big5?B?cjJ5NUxJQmh2S3h4R3RVU2x2RnE3YTNpeXFOVmJVU0tTYkQ3SWc2QkdadlFrS3pF?=
 =?big5?B?RktPSGV2MTY3QjFWQ2NVNWNCMUdsMEhjTWlzaVkveTJxY0JIL21nOG94UUYycE5D?=
 =?big5?B?bDBFSHo3VXVTd3EwUGdlZTA2M01DUFRoaEc5N0MzTy9BTEQxVStlSm1pWHhtUS9K?=
 =?big5?B?UVRJdlVJUnBpZndkWkhWYnZYc2cxUWlSSjFWajVCNGlmZUo1N3VSV1Raa2tsQlMr?=
 =?big5?Q?ND8DvSlAErcAJAUs?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c798a3-c522-470b-88d1-08dd67859d54
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 08:02:52.3714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRKhbms8G7N6beNqc2td7Jwy8O09a2PPmmuVUY8bQgtxRT+2kVQvh4fCnyS3CuiYh5hwzq+Vm7p89cxXWpVp5bFgI5JhKXCm6M4vQAX/Wig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPFEF7C8A25D

SGkgQW5kcmV3LA0KDQoNCj4gRFQgZGVzY3JpYmVzIHRoZSBib2FyZC4gRG9lcyB0aGUgYm9hcmQg
YWRkIHRoZSAybnMgZGVsYXkgdmlhIGV4dHJhIGxvbmcgY2xvY2sNCj4gbGluZXM/IElmIHllcywg
dXNlIHJnbWlpLiBJZiB0aGUgTUFDL1BIWSBwYWlyIG5lZWQgdG8gYWRkIHRoZSAybnMgZGVsYXks
IHVzZQ0KPiByZ21paS1pZC4NCj4gDQo+IElmIHRoZSBNQUMvUEhZIHBhaXIgaXMgYWRkaW5nIHRo
ZSBkZWxheSwgdGhlIERUIHNheXMgbm90aGluZyBhYm91dCBob3cgdGhleQ0KPiBhZGQgdGhlIGRl
bGF5Lg0KPiANCj4gVGhlIGdlbmVyYWwgcnVsZSBpcyB0aGUgUEhZIGFkZHMgdGhlIGRlbGF5LiBJ
ZiB5b3UgbG9vayBhdCBkcml2ZXJzL25ldC9waHkvKi5jLA0KPiBldmVyeSBQSFkgdGhhdCBpbXBs
ZW1lbnRzIFJHTUlJIHN1cHBvcnQgYm90aA0KPiBQSFlfSU5URVJGQUNFX01PREVfUkdNSUlfSUQg
YW5kIFBIWV9JTlRFUkZBQ0VfTU9ERV9SR01JSS4gVGhlcmUNCj4gaXMgbm8gcmVhc29uIG5vdCB0
byBmb2xsb3cgZXZlciBvdGhlciBNQUMvUEhZIHBhaXIgYW5kIGhhdmUgdGhlIFBIWSBhZGQgdGhl
DQo+IGRlbGF5LiBUaGUgTUFDIGNhbiB0aGVuIGRvIGZpbmUgdHVuaW5nIGlmIG5lZWRlZCwgYWRk
aW5nIHNtYWxsIGRlbGF5cy4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlcGx5IGFuZCBpbmZvcm1h
dGlvbi4NCldlIHdpbGwgZGlzY3VzcyBpbnRlcm5hbCBhbmQgbW9kaWZ5IGluIG5leHQgdmVyc2lv
bi4NCg0KVGhhbmtzLA0KSmFja3kNCg0K

