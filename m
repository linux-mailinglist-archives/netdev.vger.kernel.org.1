Return-Path: <netdev+bounces-150922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD069EC1B5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB971188A233
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF51DEFF9;
	Wed, 11 Dec 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ewd03D+r"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3151DE3A5;
	Wed, 11 Dec 2024 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733881796; cv=fail; b=UXj+RfvdltR13Y66fa9/6JWi3lGiJsiihopWV4FqPskrcSR1UAIaZfUXTGbbQA8Sc5vE/Q/j6/0TpaJvmYc3cFNSmPTsNDtxyE3B2mZX9OC3QL4newIhAxRLPVZ8VhC8RZnyQEPWrO3P0ReBdPCgXmQTbn3+2hItQ5s3+sG/mRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733881796; c=relaxed/simple;
	bh=Etl8WhcOqqYR272od+qZqdCn0Txlx7v7LF1PHWQxHIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ELNr+MX1TCfDfEgRuY3SBBrSyU/4GV6KhwVG72vclsrkLy/MQU67oSvq5+W/cdtqs0epJzvk7jhxdSUnxji7n9cdR07k79/ZNSGxXQacKXaMT0YzyiOf59+On7fsaD3g61lo5k+BroDdZ6oqDiZrgpmiKVW30+0kGm1Rr8viATY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ewd03D+r; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIOdmDHZICopvk2uma3VPZUp3WRm0WdCRue/ytK6hnGX1ZxIY7eJthBNFT0Qrg/Xn5F9+G1J/I780HZFfCTQERX4Tw4IWKubKyKlspBPciiFDCqOD9iHFa1BoAUEQF5b/7SqoU8Tzmx1fCiM2FDPURxMH34wFgVlZlVtfNH4i6mXyja8oNziLnxYtdWv0+qh6/HKXJDbe8Jt1g/86xIaFdyyvtQt7GNRgqFKn1o46jHRj7ppy94j8EIfzZYi3oGmOo5gqllzpQhQ7AIOe5XhiJC8P46C6Ww2dW2zaT4ikCa4ChpGs35ZjPofVTpxcKnUB/THxHGUQtUIHu5Q5D0hoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etl8WhcOqqYR272od+qZqdCn0Txlx7v7LF1PHWQxHIo=;
 b=bzztS6Zg8zC8mKE7sebu/+ejO5iUozJn1KPAhg6nUHSsCyiOLgvA2Z6NK9LlPaE5F7JuoHl9lfMFVG6pS0bzvUW/GIXKCbp+ypDJSoPU3xF3nwexatFESdv7FQhkJodoDwPcINNCXaEeYnUf/H9TWX7OadStHWWjCIpV2tDvyammxWf+1tQsS7VLjSUiZH1K+lY7uAUsk/e3K3eochAxH3vsud7+XDUlSDNzpY1EhSv3xLEHWKds1CGPE001WFM/oWG3qRFX+DW1z6e79sJ80VvBGCuOX8/IynOIY4BeXD0NiuxTnVXXqrCfuTFRhr69VjowbMWN91bRQastzYnnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etl8WhcOqqYR272od+qZqdCn0Txlx7v7LF1PHWQxHIo=;
 b=ewd03D+rFX7KIAfnxp0iKyFjoUnAanyls04AsDfrQNe0vW9fU7wpWjzB9SuKjveLy6NUaP9/SetBoo3OlohVTQCxleha0qLI/c7b5OhMPBQHVCH2YheSp5D/7BDoOlBZzkMnntG/EVPazlfNSOL+P8T9OTw4hHdYtNS6hmFBWErLZM7Wps93Ti86Gl6Qg8ERyAEqR0cMW4ea4NCsLahJcsvxhwhJ6ZI8a200Ex8Q2cxWu04LMNjOkfFXNVN2MqJgn0zPwR6Rz/3MBvIko3rQHkhS/MlsoMaKy5wWo1C8HDDPQ/F+bxCNsdhKlVeIjV4WXtLdAfpBBSc9HgQtlCUwjw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7298.eurprd04.prod.outlook.com (2603:10a6:20b:1df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 01:49:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 01:49:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"heiko.stuebner@cherry.de" <heiko.stuebner@cherry.de>, "fank.li@nxp.com"
	<fank.li@nxp.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Topic: [PATCH v3 net] net: phy: micrel: Dynamically control external
 clock of KSZ PHY
Thread-Index: AQHbR39SNqGVTmwHjEW5jLsNZX4FgrLew5eAgAAGOPCAAXJ9AIAAD69w
Date: Wed, 11 Dec 2024 01:49:50 +0000
Message-ID:
 <PAXPR04MB8510008EBDA6EB1CF89246F8883E2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241206012113.437029-1-wei.fang@nxp.com>
	<20241209181451.56790483@kernel.org>
	<PAXPR04MB85104EC1BFE4075DF1A27B93883D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241210164308.6af97d00@kernel.org>
In-Reply-To: <20241210164308.6af97d00@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7298:EE_
x-ms-office365-filtering-correlation-id: 0851ddb2-fd8f-494a-94e4-08dd198619c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?Ni84Z3NBT2hmQU1pTkt1dEVmTEMralZTckV0U0gzS0V6SU5uK2Iva3hlUDVo?=
 =?gb2312?B?ZHBqM0RoZWpXOGpuRUVYaEpWVHFiMlJ6T3FwZTNCNGJJK0Q1Zko2RXVLeFhH?=
 =?gb2312?B?V1pyNUZXL0J5WnAzOHhURDIyYWtqczEwWXRESXdnN2lpTDZySlUwd3FMeHhJ?=
 =?gb2312?B?RDI0VGRTNHZTQ2t6VDFQRkpVaDJuZzB2UzFOVkF2M3NTMnc0K2ZXU0pTSFY3?=
 =?gb2312?B?bW5aRldSMGEzRWdyVzdvOFFtTVExcU44T2l2RE43V3M1WWRGNkJxM1RYck1j?=
 =?gb2312?B?Z0JHL2t3bER3NWxYTW5ZTFExNnhxaC9Qbjl1KzNUTmlYODU2T1NNN2RkQys2?=
 =?gb2312?B?YzhLejFQUmFnMzJPMkc4cHREeEJZcjc1RjNyQUlUMTc5Nk43Rm94N0Q3R3ps?=
 =?gb2312?B?VVZBUWxjLzhtcVRUMEcwVzJEcStEaHh3YzhUb2I0QlEwWVZQUFgzc2VsbnhO?=
 =?gb2312?B?bk1UMzNibWZkUDQvSHZHNEhmNE1SZ1ZvYzg2TktjOEtJM05Fd1pyT2F3NEZ5?=
 =?gb2312?B?eTMvWnZSVEJlUWJweEUreW5qL0VVUTZJbXdmdy95Q0xZZTJaNWdOWklPZkNK?=
 =?gb2312?B?Nm5WZGdNc2psOUZnRTM4UnEzTzZqaHVIMnZmWlVmNnpwcGpuWEZDc3VCSEZH?=
 =?gb2312?B?UDVyaE5oWkkwV2xEaDBWNnlzdENDZFFWdi82d2xnemJLZFhWZnIreUxDQ3g2?=
 =?gb2312?B?ZWgrVjkrY1NVbGcyYXE0Zm0wdWR1K3dEcERzTjBVaWViNmhzUGZ4Qkc1cXFi?=
 =?gb2312?B?OTYwd1N6Uyt6R2ZoeVZLZ3NwNlR0N3FmcjZ2SXVaZTlPSEM5dWNlbGFRa3Y0?=
 =?gb2312?B?Ri8vUHYwdnRGTTlxRHJIOHJ2SFpidVlNTlVjSmZtbkxudzZoNjIxV2lVOElD?=
 =?gb2312?B?czNGeUFSNWtzNU04cXVHbGk4ZDgvZFgzZXB0TGJETksvNW5vekVLZTY0U3JB?=
 =?gb2312?B?TUNUZTNBa1hBWHBYZzFEMUJIajl2aG5sc3orUUZqL2x1dUl1bWprdC9zV21a?=
 =?gb2312?B?ME1IRTdSWUwzSkFsSm91R1VCTUxmQ0RZMUgrYzBoUVVWYzJrRGx2eDA5Wmdl?=
 =?gb2312?B?Mk9JakE4VDRtUUFyYS80SGhoZkpWYXE3TFF5dmQ1b1JWQ3lrVmVXWWFleXN0?=
 =?gb2312?B?RGpGSXJuTVFzWjJMQXhJcUhCTEV6dXVzVTh1b21zcHhFdDBGZWxJQWdJd3hD?=
 =?gb2312?B?bjJKVll3MVdOY0ZrV1BOTHlmV01aVmEyOElkcWZRSWoxWVhzY0xVYmtzTzgz?=
 =?gb2312?B?cVE3UGkvem80OEU0NFV5d0dUZzVTclhHQlU3djhpQm9PUlB1UHBIQzNQSGlw?=
 =?gb2312?B?NlFzRjRsckF2cjQ3UndwVHdTRk5RbFNNeWx0aUp2VXVkRUdqOEZ0SmFYNlY2?=
 =?gb2312?B?R0VyMDZiNzN6OEtrS1Z3aUlzMjRQc2JlQ3ZmWjBIY3UzSWhTcUVZV3dYQmpY?=
 =?gb2312?B?dzZiaDRBQUk5VDhYZnY1cmlFOVVhcmN5RDFsN2hsOS9EYkpoZEZXYXRUc2hT?=
 =?gb2312?B?MG1wM01xcmMrc2pUdjZid0ROV2lSNkt4T3NrL25WaWRRNFBtR2JhNnVmdGs5?=
 =?gb2312?B?TDJHM2Rtc0dicS96RVRnWkRXbURlRmN0UUtaeFp6N2ZYSGhzYUNQU3BpRllz?=
 =?gb2312?B?VlF0WU1sMGZLbWRwVG1PTTBUQ0l2M3N5aGs5OWlhUTJ5MFZRblFQbHoyb05D?=
 =?gb2312?B?VkRyMkJSTHN4NnJLOWFXM3YreVIzdGtJRnByVXUxaE1hRnV4UmM2Vzk3QnZF?=
 =?gb2312?B?RmVtd2tMNERVZWlXdlh3RW54eXFPQ2lCTWt2UWk1bVZza2hlTEZlMmc3VTZU?=
 =?gb2312?B?RXVJUzlxTDFuVWF0dmk1REVEaGoyajFJZTlQb2htZUZqcytLaUtETkI4TjBJ?=
 =?gb2312?B?VW5NT1hVZHRzSnJITXErQzd5Ym9pSmVxQnlFV0tHc0wwV1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MGVBcFh1YnI1L25Ic2FZRUM4bE52Z1BXd1hJTTVrL2pFRWpZVDFXcmpPeGxa?=
 =?gb2312?B?OEI3WS9tdUVwdjJzMlNGTlorVlRTVGQzYkRYYmhUWFU5Q3FqaGprZVVkWjA5?=
 =?gb2312?B?MUV6amozZDRLbUhyRjlWeTdpV3hFcUk2bVlXNEJYSEthVldtYVptVVhyV3ZY?=
 =?gb2312?B?WThJS2hhRVg4dkpRRi9HNzF4SHQ5SXBBbGdDc0RGV1YxNnRvK2k1NVk0VXdT?=
 =?gb2312?B?OUxCeHVXU1d6OHkrVUtlVUVCQkVYN2tBTzBsdlRsZ1QwRzhYZGg4TWdhME1u?=
 =?gb2312?B?c1ZPZmx6TlF2YVlkOFVZQk5pdWtjd1JsekMxanJ2MFJTTjF5YlZXMDFCZVFp?=
 =?gb2312?B?ZStONk41cm5uWFJ5cG0xZG8rc2drcVNLNlJodktZSmxVQTB1ZTR1QThuZVZl?=
 =?gb2312?B?d1JlWWpycDREeGlEcERMKzZxS0xNc3VZdy9RTENrSmN3L29PN2c2dzk2a1Ex?=
 =?gb2312?B?TFZWVFJhem1vNHVka0RUUnFCSEE2Ri91OXltRkVhemdzNm9LVTlRcFAwVXYw?=
 =?gb2312?B?djRCRm9QNVRWMVEvTzdSVE9BY2tWay8vTWQySEZiTXVWSENrZXRDT1hwZ3Z2?=
 =?gb2312?B?T2lUYXRiQ0t5bFNYMXNHZG9EN2plelhOK1NTRk9vZjFpNHdiUFNrL3Q2MERp?=
 =?gb2312?B?V096UzVoUkI0ckN1VkZsTTh1K1pESXRDT3ZEQTdCdVJYNnJ0S0Z0T25HSWtp?=
 =?gb2312?B?WEZLTndFaDE1YW1hdVU5M3VncnpBNXhKUzA3eDAvK2NOVzJBSEY0TWhYb1Ir?=
 =?gb2312?B?bmROdFZlNlFOWFJYWkJ4cXpZSHk4L0lpVXpGZ1IvdC85aUE5eFk3NTFwWkdz?=
 =?gb2312?B?UE1QSS9FQkZFVjFGR3dnV3k1aWtoUFJUMDR1N2h2VjRBaWdHbVRQY1JKUWlB?=
 =?gb2312?B?bEgyOFBGck5ZS0ZuR2NjS2Zid3A4MUVrOUJqM2JnVUFLOXM1UGlLb0plbVEz?=
 =?gb2312?B?a1hzZlNBL0luZDM2MXpqUGRDNE5JNmxGTEM0TkpYb2ZPT1k5RDZ2QnJTKzJt?=
 =?gb2312?B?S1VMUGR3dUVJREc4WFJWREo0YmhTbEk0aEFHdVJ3eVdoMll0dzdKZS9yYlkz?=
 =?gb2312?B?emJENGZwZSswLzlmL1I0Y3IwbFFTK2pCeWpQTGRWQmNFVEQza2MvdG44NlZC?=
 =?gb2312?B?ZmdCbEl3UjVVdHE5QzlOejJNWjc1Nk9LU0Q0SHNLVk9tZXZPak91VlNKMTRY?=
 =?gb2312?B?RWNRWXBZdkY5UXpubEs2SkJlM1RtTU91V3ZVME1uYkk2d3J1VVJkTEUwMnNa?=
 =?gb2312?B?Z2tSZ1duZDZENmNLQ05DYVNrRmsxZTJ6d0QxMW5EdzZ0bklTMHFQYmh4NzJq?=
 =?gb2312?B?Z0svN1gvQnc3aXl6byt3UHFNRXNBc3IxN05WZTd1eVdUUmdZSUF3NVFKRzBZ?=
 =?gb2312?B?LzRXS0NjeWQrUVpjN1pSd3VUSUxURG15R3ZKUDY3bDB5M0QwWTE0QWl3U0Zv?=
 =?gb2312?B?eG8wVHBZcGpmSUpzYmtKSmxUaGhBQUVLRFNBQWdRUnFLaUVYSS8vNmsxQnB0?=
 =?gb2312?B?dEx0dXEwMldhMlBwZngrbWNhSmRieXVhcHk5cEQ2TXIwUXd5b3Z3b2FQd0Ew?=
 =?gb2312?B?cVEwY2hFa3Bsb05rR3RkWFZHUGhwUno4VjYyNUZlZjBWS3B2bW1yVEdpU3B0?=
 =?gb2312?B?WHR2eklHM2NSbVdublN4YkNUaVAxVHhIcGJoOGdsYXRJenZwdGtVd2hROW9J?=
 =?gb2312?B?djZhZGE4UWpSNlpiWnZXZS9BQ215MzVDVGNhVVd2UmxTdkVpTkdVc1ExMHVz?=
 =?gb2312?B?aW9hZlJwc2FyMjNZWDJNL0NnL3B6N3NRb0JsQ0dJUklQV1ovWUxPNVdPYTN0?=
 =?gb2312?B?WUtZMGxwM2ZXZldhNmo5VHkvRm52N1VnL3Jtai9OY2U2SXUwbFBnN3RBS3B1?=
 =?gb2312?B?L2ZocFBGaGZMa0Q1WFV1OXplUkRlS0ZpRXZhYm10MWkzc0lIM3NtK3VGOTRS?=
 =?gb2312?B?Y1BoSk1kMHVWNjhQbjF6VUdsM0toUkQ5aElkc3BuNngzWkU5SkhsNjhWVTAr?=
 =?gb2312?B?VjJrYUZJOU9Kc2tRc0NNUjJBc2x1Y0pWNnp6Z2dJUm8vckEvTytnTVIrM204?=
 =?gb2312?B?UGo0OUlWLzFZa3hwY2lSYWNOSVN1d1RUQjdpOTRLVWxCOXlEMnJMOEx4QjJC?=
 =?gb2312?Q?hf/k=3D?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0851ddb2-fd8f-494a-94e4-08dd198619c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 01:49:50.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IsGGW+zDQBiWm+ZB6J+Mkk8rZZ0bUBAlWf1AR5N7jOzqKACp9F/7NDpqVXTzSA8lXE8L8gmKLaiKvywCIuD9aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7298

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI0xOoxMtTCMTHI1SA4OjQzDQo+IFRvOiBXZWkgRmFu
ZyA8d2VpLmZhbmdAbnhwLmNvbT4NCj4gQ2M6IGFuZHJld0BsdW5uLmNoOyBoa2FsbHdlaXQxQGdt
YWlsLmNvbTsgbGludXhAYXJtbGludXgub3JnLnVrOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0OyBl
ZHVtYXpldEBnb29nbGUuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsNCj4gZmxvcmlhbi5mYWluZWxs
aUBicm9hZGNvbS5jb207IGhlaWtvLnN0dWVibmVyQGNoZXJyeS5kZTsgZmFuay5saUBueHAuY29t
Ow0KPiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgbmV0XSBuZXQ6
IHBoeTogbWljcmVsOiBEeW5hbWljYWxseSBjb250cm9sIGV4dGVybmFsIGNsb2NrDQo+IG9mIEtT
WiBQSFkNCj4gDQo+IE9uIFR1ZSwgMTAgRGVjIDIwMjQgMDI6NDU6NTcgKzAwMDAgV2VpIEZhbmcg
d3JvdGU6DQo+ID4gVGhlIHNpbXBsZSBmaXggY291bGQgb25seSBmaXggdGhlIGNvbW1pdCA5ODUz
Mjk0NjI3MjMgKCJuZXQ6IHBoeTogbWljcmVsOiB1c2UNCj4gPiBkZXZtX2Nsa19nZXRfb3B0aW9u
YWxfZW5hYmxlZCBmb3IgdGhlIHJtaWktcmVmIGNsb2NrIiksIGJlY2F1c2UgYXMgdGhlDQo+IGNv
bW1pdA0KPiA+IG1lc3NhZ2Ugc2FpZCBzb21lIGNsb2NrIHN1cHBsaWVycyBuZWVkIHRvIGJlIGVu
YWJsZWQgc28gdGhhdCB0aGUgZHJpdmVyIGNhbg0KPiBnZXQNCj4gPiB0aGUgY29ycmVjdCBjbG9j
ayByYXRlLg0KPiA+DQo+ID4gQnV0IHRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIHNpbXBsZSBmaXgg
Y2Fubm90IGZpeCB0aGUgOTlhYzRjYmNjMmE1ICgibmV0OiBwaHk6DQo+ID4gbWljcmVsOiBhbGxv
dyB1c2FnZSBvZiBnZW5lcmljIGV0aGVybmV0LXBoeSBjbG9jayIpLiBUaGUgY2hhbmdlIGlzIGFz
IGZvbGxvd3MsDQo+ID4gdGhpcyBjaGFuZ2UganVzdCBlbmFibGVzIHRoZSBjbG9jayB3aGVuIHRo
ZSBQSFkgZHJpdmVyIHByb2Jlcy4gVGhlcmUgYXJlIG5vDQo+ID4gb3RoZXIgb3BlcmF0aW9ucyBv
biB0aGUgY2xvY2ssIHN1Y2ggYXMgb2J0YWluaW5nIHRoZSBjbG9jayByYXRlLiBTbyB5b3Ugc3Rp
bGwNCj4gdGhpbmsNCj4gPiBhIHNpbXBsZSBmaXggaXMgZ29vZCBlbm91Z2ggZm9yIG5ldCB0cmVl
Pw0KPiANCj4gSSBtYXkgYmUgbWlzc2luZyBzb21ldGhpbmcgYnV0IGlmIHlvdSBkb24ndCBuZWVk
IHRvIGRpc2FibGUgdGhlIGdlbmVyaWMNCj4gY2xvY2sgeW91IGNhbiBwdXQgdGhlIGRpc2FibGUg
aW50byB0aGUgaWYgKCkgYmxvY2sgZm9yIHJtaWktcmVmID8NCg0KRm9yIG15IGNhc2UsIGl0J3Mg
ZmluZSB0byBkaXNhYmxlIHJtaWktcmVmIGJlY2F1c2UgdGhpcyBjbG9jayBzb3VyY2UgaXMgYWx3
YXlzDQplbmFibGVkIGluIEZFQyBkcml2ZXIuIEJ1dCB0aGUgY29tbWl0IDk5YWM0Y2JjYzJhNSAo
Im5ldDogcGh5OiBtaWNyZWw6IGFsbG93DQp1c2FnZSBvZiBnZW5lcmljIGV0aGVybmV0LXBoeSBj
bG9jayIpIHdhcyBhcHBsaWVkIGEgeWVhciBhZ28sIHNvIEkgcmFpc2VkIGENCmNvbmNlcm4gaW4g
VjIgWzFdLCBpZiBhIG5ldyBwbGF0Zm9ybSBvbmx5IGVuYWJsZXMgcm1paS1yZWYgaW4gdGhlIFBI
WSBkcml2ZXIsDQpkaXNhYmxpbmcgcm1paS1yZWYgYWZ0ZXIgZ2V0dGluZyB0aGUgY2xvY2sgcmF0
ZSB3aWxsIGNhdXNlIHByb2JsZW0sIHdoaWNoIHdpbGwNCmNhdXNlIFJNSUkgdG8gbm90IHdvcmsu
IEknbSBub3Qgc3VyZSBpZiBhbnkgcGxhdGZvcm0gYWN0dWFsbHkgZG9lcyB0aGlzLCBpZiBzbw0K
dGhlIGZvbGxvd2luZyBjaGFuZ2VzIHdpbGwgYmUgYSBtb3JlIHNlcmlvdXMgcHJvYmxlbS4NCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9QQVhQUjA0TUI4NTEwRDM2RERBMUI5RTk4
QjJGQjc3QjQ4ODM2MkBQQVhQUjA0TUI4NTEwLmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vDQoN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9waHkvbWljcmVsLmMgYi9kcml2ZXJzL25l
dC9waHkvbWljcmVsLmMNCj4gaW5kZXggM2VmNTA4ODQwNjc0Li44YmJkMjAxOGYyYTYgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3BoeS9taWNyZWwuYw0KPiArKysgYi9kcml2ZXJzL25ldC9w
aHkvbWljcmVsLmMNCj4gQEAgLTIyMTQsNiArMjIxNCw4IEBAIHN0YXRpYyBpbnQga3N6cGh5X3By
b2JlKHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcmF0ZSk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlO
VkFMOw0KPiAgICAgICAgICAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgICAgICAgICBjbGtfZGlz
YWJsZV91bnByZXBhcmUoY2xrKTsNCj4gICAgICAgICB9IGVsc2UgaWYgKCFjbGspIHsNCj4gICAg
ICAgICAgICAgICAgIC8qIHVubmFtZWQgY2xvY2sgZnJvbSB0aGUgZ2VuZXJpYyBldGhlcm5ldC1w
aHkgYmluZGluZyAqLw0KPiAgICAgICAgICAgICAgICAgY2xrID0gZGV2bV9jbGtfZ2V0X29wdGlv
bmFsX2VuYWJsZWQoJnBoeWRldi0+bWRpby5kZXYsDQo+IE5VTEwpOw0K

