Return-Path: <netdev+bounces-216006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70BB31671
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44551AE0135
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38182DFF04;
	Fri, 22 Aug 2025 11:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aqvKPCXb"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7846B224FA;
	Fri, 22 Aug 2025 11:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862527; cv=fail; b=uZaifcVIfb3fjbELxf2Dl2IczMRtmSUVBALqdwEtnog21WK7TX6Whdz6AGN2lqDnHsYvBDli7IPPkSxu3gybRkFTD2hV5OSX7cCX+TD7/eMXRUmsp3mOsvxmPzIVBzHX7w//pGyQUtH5YPTW4uebXyMl9fz40AASkcEzD4HPu1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862527; c=relaxed/simple;
	bh=u4+KrWXeFuUd8IMfeB0N9ZR+cXY02JQqO3RmXxnR6OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l3c+/MDBY89atvM80sp7I7heCDJxlWWd/8QEA/ZNXrRRTl0sD7+JFnZekcgsYE38UOgZthc6OC7flqP90Jbe0i+1rpnZZRBNOFVpp1g0j6JopJ5xWGRCEPHVTHnVFNpGKAnlDnbygjXfwJdU4YZVRZA8/fFKKuKZc5f+X+uHQXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aqvKPCXb; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD0vTP0FSoZF1bzBVjrhm6+iypf0Ujb8UT7wMtAb3tb1amnzV6kB5SdgShRIG2d7jigVCKBUhaFID5oocEI1dF5CIyVyOyV6MLxUUupJTIFCku6lkR53PaBWcEhS9cpTEgYyqlTz0OmvjuRm2Xv00fuz1AtbdrZJDE0heNAJe3ASTTt6sBTy/Yn8o+XIuf1X4jj9njPakx0yhK1QrYkTc52If5k658eIFaASY7cxuzbS4VVJ4autTC5ezFELN0VtnCq9uG8JfZeZtGIS6ugKh5Tw41nqyPNUNtH3U3kNJTX3q+Zz09/0MBZ5BsWWkeYGfXtaCw0ERCzU1YOzy4mzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KpUxgFzRP7UTAUuTmQGDV2mHl8pikVxIF27aOkidcQ=;
 b=eYeON302eEJ5YXcSafHq175XPROv2bq2VBLXLz6GNnuQXxjLl2sZ5PnEKxBTgApN4kJ/LhLfhJs3O1vI2ISM5+x5H6txTZEo0L28SKMTiOvgN7jOkNOEFSqIAA7O0YxzzX8CaMV4jKMX88MZ7uMMsZZaZ73Sj66/8KAqsqlTLmrjY3cyexYA0IE5eTzIDl8cbzRs/wrabPaNJYC8MNTa380mwuhFNj+VBXbs2aFPQdWxFZlAs/QUtp2nsfy+oeZXb+iXTZZOo9qx+TIR8/WEjTLvMnKKKMjJqbaULBRTgLdKPnnATkfqCqbGK1qJteueFoBuDQ6l9myjGaZZl0tu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KpUxgFzRP7UTAUuTmQGDV2mHl8pikVxIF27aOkidcQ=;
 b=aqvKPCXbE3bomQ1nm3QkQ6ypsFkQg4Syn3Rw9iwZChy5h8sjaYJ+yrS873CoMQ5MSF3KRl8rQe5tGzkWXytjarYw5ext9wS248btIutfuU6DsoGgpHP+8+I2+GjncSxtUGeLFFKgnl0+MvvpREvZ+bSM/wG5w8n9HsN1wQZChfMcvf+077jHwCddNzS4xqt74Fs4h2CpSahAe2lgN9rtrdLj6xijYtG2XLoDoTqCQ7/+KHm2KCRryBQrpNkZY9stHEzHGit0fNs1+88nWAOVQqIRhm4XPHla1jbk6yeu8CKXokNp051wEB/h6qpnERB7Zw5TIitJJ3uyS7cxHHfu6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10890.eurprd04.prod.outlook.com (2603:10a6:102:48b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 11:35:22 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 11:35:22 +0000
Date: Fri, 22 Aug 2025 14:35:19 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>, Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next v3 3/3] Documentation: net: add flow control
 guide and document ethtool API
Message-ID: <20250822113519.y6maeu4ifoqx4mxe@skbuf>
References: <20250820131023.855661-1-o.rempel@pengutronix.de>
 <20250820131023.855661-4-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820131023.855661-4-o.rempel@pengutronix.de>
X-ClientProxiedBy: VE1PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:803:104::25) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7909ae8a-e7cb-4976-b559-08dde16ffaee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dE80UkF4R1l0RnAzNWJ6VjE2a1N0QmRWYUdQZEZwc3VwcU55S2tjVktNbldI?=
 =?utf-8?B?ZDNWNFFONm5JcW5ac2NPSmxNcjRhc1ZtQitjZ1dPQ09BZnhRVlBqaXBVNEdG?=
 =?utf-8?B?YWJia1A5SW55a20yZGFmSGExQUJGdDFPS21GcytXZ3cxZWlSVnRLeWdwQnhE?=
 =?utf-8?B?L0dNWTVhUjNZU1lWYTB5MzVQOXRuWlBPeDlIRVM1S1ZYZXVLMTd1Y0VtYW5R?=
 =?utf-8?B?bU1YWllDdUtGTnk0dGZtM2ZTM1BBU2tyOTdweVdOODExT1o2bTI4Y3FiQW1N?=
 =?utf-8?B?Um5NUzJ4bysvZDQ4UFAxODdMd3pCQTNDdzd6dkVQYjRBQlVMUmZSY05FZHRz?=
 =?utf-8?B?SG8zVGZJU0VUdnNJeTJ0VHE2ZVgyVEdqc2hsaGNxVTR3Mmw4bEVpb2o3WHBn?=
 =?utf-8?B?amFKM1IwRFJaRkF1OTF1Q2xTZ1M1dE03K0c1T1NaTENvTWtXZktXbzNRM0ZO?=
 =?utf-8?B?L1RtbU5GS1hPcG5ncVRvVjdqM25STXVwOWdMVHR3eWZuRUVqTzJPTW9GQUl4?=
 =?utf-8?B?UXQvanpYSlRUOWVKb3grVmhTMjFvMHE0bDN6Z3FiWjlaMXNlUVhHZTF1V0lG?=
 =?utf-8?B?NHZXRVFqeVpQQXdnbDJhb01JbXZ2VUNpUmFRcnlvd3dNRWhOTVBDZ0paWDFJ?=
 =?utf-8?B?emJZNnRORm8rNlcvVGRGQVdJdmlPQ1N3QkhoU2VERytIcGNkcDBkejFOMldx?=
 =?utf-8?B?YVQ3SWRKQ3p1dEJvVm5FZjdGcWxpYS9OaUVuUmVBODdzRE0xd1BPMjJ2aDB3?=
 =?utf-8?B?QWtrdytPNVFJanRrc09sdC93N210aUtLNzVXc213OCt1ZDhlMkhqUllJVmtt?=
 =?utf-8?B?WksvaGpBTGRrQUhnT01rU1ArUVdaaUVKenROaDBKdGtUS1p6a1d5YnViRW5M?=
 =?utf-8?B?c0M1Mjd4eDMxc3JZeHM0d0RhTkhGU2N0QWRBZlFyOVFwM3RodlFuWVJ6UTNl?=
 =?utf-8?B?NzdQeUJoOFcvUE9ZSjJTbGh2akFhTm1KeXZoV0FpbjNmT0FiMkhacHIvWVc1?=
 =?utf-8?B?QUZFT1RaanJzV2xYdG9TQUR2NThFL1ViK0RyaGZrREJWWk82RTBSRjNvUFI5?=
 =?utf-8?B?clJjN2pUU2hxcnZha3FVZDJZaU1SQytiUFB0S29nYW1MVnJHT2h4Z0ZnRXE5?=
 =?utf-8?B?QVh5Q1RtUEUyMyttcUJjNU02Znd2OG54UCtpRkpvNlBOVGsya05GZnVLMXN0?=
 =?utf-8?B?eVViYTMycWk0VmZHYUd5cEZWODF0V0tmUXBqdFIweWE2TlZtV0xCcEg1Ym5r?=
 =?utf-8?B?akZ0RHhlbVZYVlNabys4aGtsOEMyQ0wxamJTQmxTd0gxZTdEYzdmcEpOUXh3?=
 =?utf-8?B?dm44MnNGeUZ3a1A5eVhrS3JBVGlYR1VqbzUwUm85Vnc4TVNrZTNtTDNsaDc5?=
 =?utf-8?B?OEJJbzJ6eTlkaS9KbU8zdjJpWXdMR2l3d3BmUGVuNlJ3c3lSVzdNaUx6d3Bw?=
 =?utf-8?B?blZJWXZpUDdrMzNuN01hNUZGWVRCaWdPSjJmZFlCREN0RVhRSUh4VEVWYUF0?=
 =?utf-8?B?c1Z1alh4QTY3ZjgvblNPbzE3bm9uNGw4V0w5cjg4SXNxVnJUQ3VWRVNJdG9Z?=
 =?utf-8?B?Q09jRkVRb3FmR3hYeUpBbFRDRmFjM2djTjZyR0Z0b2JHT1greWJTWWQ4dUEr?=
 =?utf-8?B?L0pidGhLOG9VOUtNUkpHcTVOWVZwN2VjYzNxalErandONHA0SnlwZ0Vuc0Yz?=
 =?utf-8?B?eVFMU1Rkb3FhRWVZYmlteE5Qb1dUZncxWmVsN1dBdjhMaHRNbEI3bDdxTjFY?=
 =?utf-8?B?bmh2NHFUYjg2WFdNL0ljcnZJd3drRnRvOXlUYllhWmx6MWxBSmJ4c0lsME94?=
 =?utf-8?B?cjB1VzBNcWgxQ0VXZWpIajdFQnRxZlJWcnRNeXdURGg1Zk9aQXNkY29yTWFN?=
 =?utf-8?B?ckxzRk1INEtYSmdHNm5vb1F6K1NEaXZXMllxei94dWJ0SEZualBQaUIyVlp2?=
 =?utf-8?Q?fFItItLqML8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1dLMTVGampiTnFYaWdhbWJnNjdCLzFSNUY1eFJtc0g5K2d2RmdHcUJXOXpm?=
 =?utf-8?B?cTRVK21LWVRXWnVSUVNwSTlJWUlrWkg3M2dFcGZicHZsdExUdlA4aDFXVnZ0?=
 =?utf-8?B?VDN5VUJTaEQ1V3owODdKdWUyc1ZhREsrblZyOU1YdlEvQjNxbTQyeGtPUEhZ?=
 =?utf-8?B?SDdLNHcvS21ubk9vSlA0MDNiWEZEem02NHZvcVJnKzlzYkd1QnR0M0FBTWdZ?=
 =?utf-8?B?aUIyWmlLRGhIR09wTmxYbTNwaU52ellVTCs4djYyeWFKVTJPcEw0Qnd5THp2?=
 =?utf-8?B?MXRadFNZMkxuZGUvRERJcnlPVGhtTHhWaFQ5YWJFeWUvVElqVng5QnJkZHFi?=
 =?utf-8?B?dDMva1RkZjVLYVd5d3pram1kWW9VWE8vUldyU0hocHRSQ0o2WDJKWmdtclc0?=
 =?utf-8?B?ei9MOTFDV0l6R3M3TnZCQmR3Zmh0MnNhMElQUUlnbmxDSGtBOXBCbEhpYmR0?=
 =?utf-8?B?WXB3bGx3Sms2WU9RSkdRVzRoTHZzNy9mZzhpcmlqVnlHRXFoU2U0cDkwbzFF?=
 =?utf-8?B?SXRwOTlXalJxNUlvTkJZdmFJcDRQSjJhZGpqdUhnN1FRZWhzUlE5WXVZQTIx?=
 =?utf-8?B?MVFNS2xxZ21XbXYrQ2lEWTNQL1VoeFoxdkRqRXBIR3RKUkx5YUg5RGlYc21z?=
 =?utf-8?B?MC9kV2h5K1BiMU83RTRLR1ByeEQwQ25pYmcwNmZBRDZCUTUzTmV0dThUdnlI?=
 =?utf-8?B?ZlN6b2I1eGYxMWIvMzBkbDNXMVhvbzQwTzlEV0FtSE8rM0h0WkRBNXA0OEV2?=
 =?utf-8?B?N2RkU21ROFkraENuak5jQ3Z4eTB2VEtnd2JvVUxJOTV5cFBBc0VuaWFjc3Fk?=
 =?utf-8?B?UmtoWERXUkEweFFPUTBNSi9qclJKODNodExQdmpDMDdONXlJNlkyVnB5VmRq?=
 =?utf-8?B?K2dhNnMzd1EzQkZEQnk3UG1PUXc1THpwTTU2UWFJWVpBTE9jOUtmejhDTGV3?=
 =?utf-8?B?QWpMOFFaMzFFejZaK3V6K2cxeitxWHhWYktFbFVYNCtva3dHaDR4SkhxZy9V?=
 =?utf-8?B?VHo2VG1GOHpoNitzMnl6Wi8vSGdGZEFiVXk5STJ5NTJXcmJ2R1VvYkx5N0pa?=
 =?utf-8?B?TW83dEZ0N0l0eGMyY0sxMnJXNXp4RUNDQUUrNEZ6OTI4c0lKNFdZZkFvdnJj?=
 =?utf-8?B?TlFNa2JyUm5QZTFBN1BQQndkcVcwTThSSFNQOTJtMktVdEcyR2tLZHRBKzA5?=
 =?utf-8?B?dFhyRG9yVHYvdE0xZElxU1ROSlFtZk9ISDhYd1ZhSWJDU2xoV2hvUGxnaThG?=
 =?utf-8?B?emQvQWdtN1l5OEJWVkg3WnZydThrSFd5SEJNYk9hYlJ2M0ZGSXNwMVJ1MUNo?=
 =?utf-8?B?cTdlamNPVmxwMmJzNkZNMjQ4OElhaWtBT2ZjVGllWXc3OTg5ekRzNlZIR3p1?=
 =?utf-8?B?Mm10UkoxSUJtL2RGYVpiRzhHeG1QZ09QaS9MZDlEQ0V5aUhZcDhCelJFaEs3?=
 =?utf-8?B?VmlFSmV6eW4xUE5rU2pQSFZIbXZMNFdYZjVvTVErYUgzaW5qQlI2WDlRaHFY?=
 =?utf-8?B?RXZmZkt0cEU3MEc3Z1NkWVRNYVBlbkR2eFROME15ZnA5ZllKbERRbFNRK01u?=
 =?utf-8?B?bkxBRy9wcEFObVo1eDEvQ2xuak1VaHlkdFpNVzJmY25NT2JBajRTVlNYQ1N6?=
 =?utf-8?B?aXpFdUdlWjRaaGUvaDV3MStUUDhWS2wzTUhqemUzS3JmVzk4WS9WQWQ3eXVY?=
 =?utf-8?B?Rm1rT2xvellhUStybEFTODBWZHJvbjhnamFyQTlRL3pPR3ZFcW9OQXVETUVs?=
 =?utf-8?B?b1dYTXRlOTdBakFoWjJ3MldhMGMvNzNyVnZyS3o3dDJGNFlTZlAwN3VSVnR1?=
 =?utf-8?B?RkQ4MXpZVVpJTmNjUlphZ0NoS2pGKzVFTmFJL1U2WlByVEFXaGdUREwzV3Z4?=
 =?utf-8?B?S3J0YytocE8wZlBoTHJOWFZhMnVvejVlQjJBcmdzNm1TMCs3S2Q1aEcrSFkw?=
 =?utf-8?B?cWhyWU1EeHAveExtK250NEhGOFRxblN1WlFRNFc3OGsrRFVJT2E3di9VZVg5?=
 =?utf-8?B?YW5ibHM4dW91L21IbG9Lc1ZCT2JmOGFWUzc3dFluSGs1ZFhyUWppOWhIYkx4?=
 =?utf-8?B?eTh2UzBpYzFZbFpVZTVJZXM2OTZJMmoxcjdSaEVNZDF6TVlVTGM3UXBiTFZ3?=
 =?utf-8?B?V2d6SkJjb0U5MFpaeTJPekJRaG9tZ1g0MHc1OUZIdS9XL2xURG4vMi9SL2xo?=
 =?utf-8?B?bDFGellVUG5iR3NKZXAvbTdENlFpakErWFZvaVhyQW9Ua3BITXBiQWxZUXhY?=
 =?utf-8?B?cjVkYWVsVDE1WGx3S1NqN24raU53PT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7909ae8a-e7cb-4976-b559-08dde16ffaee
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 11:35:22.6911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtzbnSeoIcsrDE7RRr+S/zxrkunrfWLsdQ+srUV9mHooYtO5GS6m433bZjBhFD0NzJQEUiEtYupDuSwl7UdHMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10890

On Wed, Aug 20, 2025 at 03:10:23PM +0200, Oleksij Rempel wrote:
>          name: stats-src
> +        doc: |
> +          Selects the source of the MAC statistics, values from
> +          enum ethtool_mac_stats_src. This allows requesting statistics
> +          from an aggregated MAC or a specific PHY, for example.

"This allows requesting statistics from the individual components of the
MAC Merge layer" would be better - nothing to do with PHYs.

>          type: u32
>    -
>      name: eee
> diff --git a/Documentation/networking/flow_control.rst b/Documentation/networking/flow_control.rst
> new file mode 100644
> index 000000000000..ba315a5bcb87
> --- /dev/null
> +++ b/Documentation/networking/flow_control.rst
> @@ -0,0 +1,379 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _ethernet-flow-control:
> +
> +=====================
> +Ethernet Flow Control
> +=====================
> +
> +This document is a practical guide to Ethernet Flow Control in Linux, covering
> +what it is, how it works, and how to configure it.
> +
> +What is Flow Control?
> +=====================
> +
> +Flow control is a mechanism to prevent a fast sender from overwhelming a
> +slow receiver with data, which would cause buffer overruns and dropped packets.
> +The receiver can signal the sender to temporarily stop transmitting, giving it
> +time to process its backlog.
> +
> +Standards references
> +====================
> +
> +Ethernet flow control mechanisms are specified across consolidated IEEE base
> +standards; some originated as amendments:
> +
> +- Collision-based flow control is part of CSMA/CD in **IEEE 802.3**
> +  (half-duplex).
> +- Linkâ€‘wide PAUSE is defined in **IEEE 802.3 Annex 31B**

There are some odd characters here.

> +  (originally **802.3x**).
> +- Priority-based Flow Control (PFC) is defined in **IEEE 802.1Q Clause 36**
> +  (originally **802.1Qbb**).
> +
> +In the remainder of this document, the consolidated clause numbers are used.
> +
> +How It Works: The Mechanisms
> +============================
> +
> +The method used for flow control depends on the link's duplex mode.
> +
> +.. note::
> +   The user-visible ``ethtool`` pause API described in this document controls
> +   **link-wide PAUSE** (IEEE 802.3 Annex 31B) only. It does not control the
> +   collision-based behavior that exists on half-duplex links.
> +
> +2. Full-Duplex: Link-wide PAUSE (IEEE 802.3 Annex 31B)
> +------------------------------------------------------
> +On full-duplex links, devices can send and receive at the same time. Flow
> +control is achieved by sending a special **PAUSE frame**, defined by IEEE
> +802.3 Annex 31B. This mechanism pauses all traffic on the link and is therefore
> +called *link-wide PAUSE*.
> +
> +* **What it is**: A standard Ethernet frame with a globally reserved
> +    destination MAC address (``01-80-C2-00-00-01``). This address is in a range
> +    that standard IEEE 802.1D-compliant bridges do not forward. However, some
> +    unmanaged or misconfigured bridges have been reported to forward these
> +    frames, which can disrupt flow control across a network.
> +
> +* **How it works**: The frame contains a MAC Control opcode for PAUSE
> +    (``0x0001``) and a ``pause_time`` value, telling the sender how long to
> +    wait before sending more data frames. This time is specified in units of
> +    "pause quanta," where one quantum is the time it takes to transmit 512 bits.
> +    For example, one pause quantum is 51.2 microseconds on a 10 Mbit/s link,
> +    and 512 nanoseconds on a 1 Gbit/s link.

I might also mention that the quantum value of 0 is special and it means
that the transmitter can resume, even if past quanta have not elapsed.

> +
> +* **Who uses it**: Any full-duplex link, from 10 Mbit/s to multi-gigabit speeds.
> +
> +The MAC (Media Access Controller)
> +---------------------------------
> +The MAC is the hardware component that actually sends and receives PAUSE
> +frames. Its capabilities define the upper limit of what the driver can support.
> +For link-wide PAUSE, MACs can vary in their support for symmetric (both
> +directions) or asymmetric (independent TX/RX) flow control.
> +
> +For PFC, the MAC must be capable of generating and interpreting the
> +priority-based PAUSE frames and managing separate pause states for each
> +traffic class.
> +
> +Many MACs also implement automatic PAUSE frame transmission based on the fill
> +level of their internal RX FIFO. This is typically configured with two
> +thresholds:
> +
> +* **FLOW_ON (High Water Mark)**: When the RX FIFO usage reaches this
> +  threshold, the MAC automatically transmits a PAUSE frame to stop the sender.
> +
> +* **FLOW_OFF (Low Water Mark)**: When the RX FIFO usage drops below this
> +  threshold, the MAC transmits a PAUSE frame with a quanta of zero to tell

I think quanta is plural.

> +  the sender it can resume transmission.
> +
> +The optimal values for these thresholds depend on the link's round-trip-time
> +(RTT) and the peer's internal processing latency. The high water mark must be
> +set low enough so that the MAC's RX FIFO does not overflow while waiting for
> +the peer to react to the PAUSE frame. The driver is responsible for configuring
> +sensible defaults according to the IEEE specification. User tuning should only
> +be necessary in special cases, such as on links with unusually long cable
> +lengths (e.g., long-haul fiber).

How would user tuning be achieved?

> diff --git a/include/uapi/linux/ethtool_netlink_generated.h b/include/uapi/linux/ethtool_netlink_generated.h
> index 46de09954042..0af7b90101c1 100644
> --- a/include/uapi/linux/ethtool_netlink_generated.h
> +++ b/include/uapi/linux/ethtool_netlink_generated.h
> @@ -394,7 +400,25 @@ enum {
>  	ETHTOOL_A_PAUSE_STAT_MAX = (__ETHTOOL_A_PAUSE_STAT_CNT - 1)
>  };
>  
> -enum {
> +/**
> + * enum ethtool_pause - Parameters for link-wide PAUSE (IEEE 802.3 Annex 31B).
> + * @ETHTOOL_A_PAUSE_AUTONEG: Acts as a mode selector for the driver. On GET:
> + *   indicates the driver's behavior. If true, the driver will respect the
> + *   negotiated outcome; if false, the driver will use a forced configuration.
> + *   On SET: if true, the driver configures the PHY's advertisement based on
> + *   the rx and tx attributes. If false, the driver forces the MAC into the
> + *   state defined by the rx and tx attributes.
> + * @ETHTOOL_A_PAUSE_RX: Enable receiving PAUSE frames (pausing local TX). On
> + *   GET: reflects the currently preferred configuration state.
> + * @ETHTOOL_A_PAUSE_TX: Enable transmitting PAUSE frames (pausing peer TX). On
> + *   GET: reflects the currently preferred configuration state.
> + * @ETHTOOL_A_PAUSE_STATS: Contains the pause statistics counters. The source
> + *   of these statistics is determined by stats-src.
> + * @ETHTOOL_A_PAUSE_STATS_SRC: Selects the source of the MAC statistics, values
> + *   from enum ethtool_mac_stats_src. This allows requesting statistics from an
> + *   aggregated MAC or a specific PHY, for example.

Same here.

> + */
> +enum ethtool_a_pause {
>  	ETHTOOL_A_PAUSE_UNSPEC,
>  	ETHTOOL_A_PAUSE_HEADER,
>  	ETHTOOL_A_PAUSE_AUTONEG,

