Return-Path: <netdev+bounces-175687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8DCA67246
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 12:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130307A8EC5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22BC20A5F1;
	Tue, 18 Mar 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="L7SBXDgy"
X-Original-To: netdev@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0015820A5D5;
	Tue, 18 Mar 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295634; cv=fail; b=anuczkgSd62ML+UgKimb+SAD/JKQlvdq4CnVnBYBWbTOibuTb2Y8WiiNffXbE57SH88SE+hfyJ7Kak20F7wbKYYsiqnr5enKh4bfYCWRrE3QVE8S3JKfeBnVXLBxFw5dvltMbc6+3Racm/hm6ILN5BTPmvWXZQoGf53iQaBfn7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295634; c=relaxed/simple;
	bh=7hBn2wZhY7GjBgcIcOFWcXsqGzLeN90KodupPRv+Irg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZksRQLuXYNRwHjEfbTryiTS9O78QypN1m8BZeXhKlkVFet1p25FnLARCGbq1C/vyPO4bXWay7Sy8byt68qcvI1L49jm0xR4SWK3UR5ZGNIjDnvkdbHWxCcqo3oIo1Ffv3Vu9bmOa71UB8EToqNAaYmz9fSUi1dCYxdPu0o0z3qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=L7SBXDgy; arc=fail smtp.client-ip=40.107.117.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/Ntf0Bqa67UErxE3VBvQROu8WDYha/HbXAALsM2dxr6w6tx0gIAGedqE2ZLhUYBPQhuy5LKLa9Gwdta/1y84TFIjEOJbDHcPW5K5X69JFtUF5ylpPnJllKty9oVYz05A1gJp0W60tVpsgYYTK6SmB4lGHZtDe8RJh3y9GNX2mHzH+OL38X9rtoxd7fq4r9SW1GT1z1590ZnWqW/dWrtYCWuyHxMJk6XjO3rhU1gOYqdVe1N8XHX18QQzeQ2t/4tfG4OPzet6ITtziLp7l5Fmn3VP3GAT6QkP2906NIOBFLIyCvPWaJp0PQUfe8LuaA4SQIkbiOPZMNKB5ZP00Q1+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hBn2wZhY7GjBgcIcOFWcXsqGzLeN90KodupPRv+Irg=;
 b=qJzBP1ZBQY8m3AAtmedu8FNmdIDZlqOSDELNtjqHw37Jmn3rLtrr506MKowKUTtm0WAPxtARpDm3vkdGMBQHzhdDE+2EVXUhY1kz33dYdojZm53cfqlXz0+JmAyYXgFdU/CV17Ra1CqVV3g08QT381QnbTFz/Ea/CVK+OBHx7LV5zjaL+w+IN3JO31micrEXXRLYwI7B9kZaSH5g4G9Iyo0bmkjVNRHV1gBKgRXNMwCXzE+6Etc+EmC+3PuK/13utmPaIdVIcSC4qGVn7UN/q2zghiaVm3T7tOlQsTugKUKvHeu5GDe2VoDnkbZbGOTWeNv0NzvzFCEn/eyh3coSzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hBn2wZhY7GjBgcIcOFWcXsqGzLeN90KodupPRv+Irg=;
 b=L7SBXDgyL1yS4eR+VTLb9L7TL5zqbvXlUudCV1x4/FXD5IdBjDyJ3tbZiQDJFY17eV7QJUExCg1Qxataxnj2R+oBihkzaud7JR1RHIa/csk16qwiZnfMnuWW/9uEpYMlylWR2oswUCv3eHGYTt2+onRTCvH9hHHZL/E3mcgUfIPTYchOeI7KLe7iZJCabOZUI24I4cfTImYUq6juxKsNrJ9G+CJTY03zJAMsOpAnQyyy7HzaI5yGhUUAHOQlOz8Kl3yjQY0IvoMkFFQTDhAoltUu9dmYkvYiu2mRgzNFjPI3k2cXu+NikVvg6ZTC4+nVI5x9whm8VIbjnAeeA7jDpg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5914.apcprd06.prod.outlook.com (2603:1096:101:db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 11:00:28 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%4]) with mapi id 15.20.8511.028; Tue, 18 Mar 2025
 11:00:27 +0000
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
 =?big5?B?pl7C0DogW25ldC1uZXh0IDIvNF0gQVJNOiBkdHM6IGFzdDI2MDAtZXZiOiBhZGQg?=
 =?big5?Q?default_RGMII_delay?=
Thread-Topic: [net-next 2/4] ARM: dts: ast2600-evb: add default RGMII delay
Thread-Index: AQHbluiaGC/JF+mxZkSS5mpUqJVheLN3TZeAgAFq1tA=
Date: Tue, 18 Mar 2025 11:00:27 +0000
Message-ID:
 <SEYPR06MB5134A69692C6C474BDE9A6A99DDE2@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20250317025922.1526937-1-jacky_chou@aspeedtech.com>
 <20250317025922.1526937-3-jacky_chou@aspeedtech.com>
 <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
In-Reply-To: <5db47dea-7d90-45a1-85a1-1f4f5edd3567@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5914:EE_
x-ms-office365-filtering-correlation-id: c43de59a-fdda-4a0f-886b-08dd660c1793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?big5?B?cERJWFNTUEVMWEViMnRjeGtqZTVrRVFXMjlMUHpJNWQ0bmcydk50YmdQdko0WUcr?=
 =?big5?B?M0JvMjZKczJaeUhpbjlZZ0NzYW9NMEtWbjRSZFBLSTBOejVIQnQ4ak9pdkJKczg3?=
 =?big5?B?RlM0NVRQcVZUNEw0UndMMk1UWUFJUlJReFZqT0lPTmJOaDIrSm9QYjQwVUF1VDNr?=
 =?big5?B?MGRGVUp4VkxCYVd0bkJKMytTT3dzZElqWUVkU0VkUlpmb09MSzQ4VkxCVG1FVUE3?=
 =?big5?B?VS9lVm5ndEhRb1oxOGRPMnV6TlJvYWVwSFlQMW9xK3VZVUhVRHl5MzFvb0htZVBz?=
 =?big5?B?OXJyN0tOcW5oL2hNOHFGaVlHcER2T1RiOUFtUUsrT2Fya3BOT3ZtbHpIdWtDSThT?=
 =?big5?B?Tk40bG5XZUpTbTNPMldudXhVS3lnMEFTOFp1dHk3cGUyNXo1Yzl3Tk14aGsxb1lH?=
 =?big5?B?bzNHV0s1dy9Qalhod1E1MFZHOEgwOVJLZ3hMclh4NVhDR1dLMWJSN093YkZPdzFs?=
 =?big5?B?WDVRc3BUVUJUekRjL3lwTjA0Y3o2VGRPMVMwcHlVaU5EMjNFT1ZtMmI2UGNyYUc2?=
 =?big5?B?TkVjeHJ1dVRiR3Z1WjhUTUVyZFZlMzJtdzVTUk1lQVpzOXlHV1ZyTEd0QysrYkU2?=
 =?big5?B?OXZhR3AwRk0zeS9SNjFtZU5YaHpFOWtOenBFSHRTZTJ4d2V5ZHNRYlpDMW1XV1hu?=
 =?big5?B?eDlVNTU3M1FQdzc2Nm82VndUODdqWS9RZ09aV1ppZUdYbGpVK2I4NWZEY3NSYUxI?=
 =?big5?B?Mnp6aUZOYnJJcUpjSXNON1A4L1cwNE1GcWJLN0g1SFBCVFI0ekNtQkJCZWZ2RHBN?=
 =?big5?B?TE1HVGZULzZyTCs4QkFrZXVQVXkrUGhERVJBUUFQb1kzbEFPWFphdmExUnFpWUFM?=
 =?big5?B?RWY5Z2ExRGMrOGl4WGZzWlVXL2h1SUEzTEgyZlZGRWFtQzZvM0ZFV2J6bVZUM3Vy?=
 =?big5?B?cGJRQm04MjR3bG8rWTRTNHdBTUJQbU5tQjVQM2dxWVJGNCsyNXRBSmtKVHg0UDVE?=
 =?big5?B?a0xOTC9rWTNtOWEvVHZ1RzhrckplUVh4MzZvRzVxbS9jS281emk1TDFhdVFySlZu?=
 =?big5?B?UXdSU1hkMGlGcThtWHZGRXJOM1N4Yy82aHdwYVlsTkFwczVmYjU0Y1RFM0I0eXhr?=
 =?big5?B?ZVNyTXhQSXlKNU1IZWFIdldrYjgzY0lnS1Y3eTFHZjl6NzFGeDVRenlyd2ErQ0Vk?=
 =?big5?B?aFpJMTZZdjl5OEdvMEpRZHpmYWowQldUVHFRUksrbE02M2NQNDB1RXpnTnhIeG45?=
 =?big5?B?S05nNDF4c3NOVWdXaXlTVzAxWXd1Z3lUTEtzK3VCTkRTa09aeWdkRlgvZlIvQXRq?=
 =?big5?B?Slp4TTRkcFQwUGpjVDliUlZQTlpSd2l3eEhJeTlZN3ZvVWx3ZWwzQy9JRzNlWndn?=
 =?big5?B?aDNEb3RNYUxFMjJYNFBMb2Vpem56VWN1SVp4TVRENjdzYUdjOUppeEtreUR4SGtE?=
 =?big5?B?NEIxSnhzWTBORkg0NUdITVR6WnVFWStqdUE1SWowWGN3VktITk5WRWJXaVNLMWdC?=
 =?big5?B?UU9LS3ROVzZYQVBOaWZoS0Y1UjRMYlJYV2N5b0NVcDlXVUplcVNXN2pwb3ZXY3h0?=
 =?big5?B?QS8vQXdONjI0cXdUUUVaWjkrSEFtZjNKNVNGVmsvSkRHWWdGdjRBQUpPWnNSRkl4?=
 =?big5?B?dGdTT21sTE53bVkwdnQ2L05pOERJdDk0dzBOUlhBclcxMnEzQ2ZWcDYzVG5nQVBL?=
 =?big5?B?RldxUjJudUgreStmZC9FOGZ1bDg4WVd6dzVvMGMrZGdOZ25pbmRzanpGYWs5VVZn?=
 =?big5?B?TU84Vm1OLzRhSyt2M0xLZ3FXVGNiUnlsekRwYVNQb2dCNHBDS2FjS1NMVGE2dHRL?=
 =?big5?B?NDJvMkluSHphZFNmWFdFZXNLRnVtUDRQbWlBaUtWM1VSUTBMZ3NGVDVSSEdMaVF6?=
 =?big5?Q?3YZX5yKC6eI3PDnmz4/ziJ5KbLzmUs0G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?big5?B?aGE3NGhQdVhZUEMxOFFpdFk3dDFXS3F3amFwQ0pHRFhSVnFxdmp5MUpSYzcvbGxC?=
 =?big5?B?WUJuOUdRRng5alV4YUwxK3NyUytzZkpjOStjazZ1UHplTGtBV3N3NTdpR29mbGl0?=
 =?big5?B?REF2N0hpUXpwMEhseG05NVJhR1NMZHZlbUpnWjB4cXdQOFpPRHFUU0MzTEU1MFUx?=
 =?big5?B?TFNFWUI2QWFDSkpwMTFIK2I0ZytoeEZRQ2pXRmR6SzNCZjNkaDh1Y0lCeTVuTlpS?=
 =?big5?B?V25VU2pLNVlUVGhKTnNVMVFib2xiRkNJRGJMQ0xKemhFenRtbWtmYVdVdVdWc0Qv?=
 =?big5?B?cFV2cFFNRkwxYVM3MTBqQlR0b3dhWHJPVGpNUlVwd2ZqNU5icThNbENIK0dUcmlJ?=
 =?big5?B?aGMyNFprcnZ3YjZhSnBLZFJOMXNMcW5OMXAwdDhrMXV4WW9nT3d3b1FaZmZ3L0xt?=
 =?big5?B?QlRxWUZLMnJPT3VpTi9MK0lPNzRzd3pTeitXLzRTbXJES3lZbWhGL2k3UUxsZVl6?=
 =?big5?B?ZThmREVFOEhuanpxejhLZGt6UVBWd0tlVkhucWh1WDBhYksxL3RxeVRhM292dFd4?=
 =?big5?B?Z0I3ZzRkanVFbEpWVUFIaHRjSjlvUXhicUtIbmhQZHdVNzFOSGk1OHc0azFlZVU3?=
 =?big5?B?SUdZek04MzdiZCtUR0daeUIwT2JxSFZKWVZoMHdPcjZobXBnNzZ6SkZ3MW1VS3Fi?=
 =?big5?B?L0gzeWZXWElQdE1jM1M4V2dITk9hRmd2Vy9QaEprZ2htdlpneUpPbXg5VWRvUlA4?=
 =?big5?B?bHoxVzRHRk5RZTVyRXhscEhPQll5NW1TcmNJNzYzUlhvOE9HZjhuNEp1QWN6TFV3?=
 =?big5?B?RVhNKzdqS0JIWllyUWc5czNGbVBmdjlqMk40OXBtQTB4S0NVaWVBU2RJSHZZVENu?=
 =?big5?B?Mm0vdXExRkdUY09rMGtydi8xVTErVVFnOXl2QUhRbThTNDFvOHBrbFd2MkxKOTRF?=
 =?big5?B?QWdJM05aaDFkK0hkYUtJK2J5QUlxbHYwV0xlTXRwTG1kYVNqZU81bnNoTERmOEVn?=
 =?big5?B?MHdnbHZaQWtUTDZydUN5cXZvRzI2ZThac2JXQ0IzY3h6Q2ZwYTlCNG9nTUhGeWxR?=
 =?big5?B?czhUclduWkdlbjJxWWpBc0VtdlE1K0dPMjFaaFhLWFRlMmhjUW1QR0U2Z2ZXTmNR?=
 =?big5?B?L2kwUExaSVdMQ0p4LzVUZkpzWTRpSml1VnVqTWdGSXl5bEpxRkdYelg1Y3FkSkFo?=
 =?big5?B?TSswSUFUUkxsRllHRlB5dTY2dEZsWU1tM1NFdWxvd0h4Rk9lalE0ZS8zU3R2RllR?=
 =?big5?B?VmpJN0ZMTlFGTzYvcS9IdkpLWFI1QUs5blF3VkhSTjdZUDRkbnFPQmNNR1NXdHBi?=
 =?big5?B?VWtBWnA4Y0t2ZkZoQVNUcGYyK1RWZXEveXB2YVU3b3BpaHVaL1k2N1JnMit6T0FP?=
 =?big5?B?bW9ucDBNSjNGZml5ZXhLTndHZkFJeGNrMDZleVhrQjNJOG44cGNzQXZneVRvQzRI?=
 =?big5?B?OHJId1RlWnVGT2Q4UTEzbDFZMkRXVU54V0R1S3EvZmJYM2IzazlvSDNWd3pCRGMv?=
 =?big5?B?YmhIU1FvT1NzcVBESVdLNlVjOGVGOU9vT3JIRS9nL2UvMDFwL2gydXdRR0FKcWtO?=
 =?big5?B?T3pScW4vVGZXK0NwL1VZYUYwZ1dRc2ZoQTQrVmJYOXBWM0FyT0QzMUxBRjQwQjRK?=
 =?big5?B?U2pXYmNJL0xOK0ZmYTFVaXl2Z0JaVmZzV1Q3TVZTVmR6ZEZhNzVVYlczRDlWVTFQ?=
 =?big5?B?cEVFZngwY0dTZitLaytxZ25lVDA5dTB4bjdXbW9LeHJ6RVY2OWFSK1pOYTFoUVRQ?=
 =?big5?B?ZWZqaWJkTzN0bU44WHpsR0oyWWpVSGpMWnhVdVRrUTNzN0lMSGJjb0IxakxMVzA5?=
 =?big5?B?aGVIZUgvME1tcEt1dVh2SHVhZVNyRElFY3dTV25QZ1ZtOWhVU3hOVlp4Sk1JYmJw?=
 =?big5?B?RlNabVlvbllWUTlkbHF4MlVpUWRTUklKcmtpTEJpQVZ4YTcvUXl3dnYvaVdaYjBs?=
 =?big5?B?THdLb2Q3Z2tyekF0ZWR0ZXZyVXNmem9pVFBSNjJMTm5HQ1JjTWtrdkFlanA3dzZ0?=
 =?big5?B?ZmtWV0hVOTRjZzZudTF4eXo1QzFONk1yaWpTc0JoZXl0QWVkaGhPWU91T0czaWVz?=
 =?big5?Q?cfhpxHUq67vi3CF2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c43de59a-fdda-4a0f-886b-08dd660c1793
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 11:00:27.7412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeREMYTeCWqcZhWRyRVIWrxUEHTuFerB9fbjULXM3/l2MVOPCECAm/J+MaS8bX6unq7TaaDdzzGHUF78D129DNajGndwNsyFUJQ4aT1ZuG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5914

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmVwbHkuDQoNCj4gPiAgCXBoeS1tb2Rl
ID0gInJnbWlpIjsNCj4gPiAgCXBoeS1oYW5kbGUgPSA8JmV0aHBoeTI+Ow0KPiA+DQo+ID4gKwl0
eC1pbnRlcm5hbC1kZWxheS1wcyA9IDw4PjsNCj4gPiArCXJ4LWludGVybmFsLWRlbGF5LXBzID0g
PDQ+Ow0KPiA+ICsNCj4gDQo+IElkZWFsbHkgeW91IHdhbnQ6DQo+IA0KPiAJcGh5LW1vZGUgPSAi
cmdtaWktaWQiOw0KPiAJdHgtaW50ZXJuYWwtZGVsYXktcHMgPSA8MD47DQo+IAlyeC1pbnRlcm5h
bC1kZWxheS1wcyA9IDwwPjsNCj4gDQo+IFNpbmNlICdyZ21paS1pZCcgY29ycmVjdGx5IGRlc2Ny
aWJlcyB0aGUgaGFyZHdhcmUuDQoNCkkgc3RpbGwgY29uZnVzZSBhYm91dCBldGhlcm5ldC1jb250
cm9sbGVyLnlhbWwuDQpJdCBsaXN0cyAncmdtaScsICdyZ21paS1yeGlkJywgJ3JnbWlpLXR4aWQn
IGFuZCAncmdtaWktaWQnLg0KDQpldGhlcm5ldC1jb250cm9sbGVyLnlhbWwNCi4uLg0KICAgICAg
IyBSWCBhbmQgVFggZGVsYXlzIGFyZSBhZGRlZCBieSB0aGUgTUFDIHdoZW4gcmVxdWlyZWQNCiAg
ICAgIC0gcmdtaWkNCg0KICAgICAgIyBSR01JSSB3aXRoIGludGVybmFsIFJYIGFuZCBUWCBkZWxh
eXMgcHJvdmlkZWQgYnkgdGhlIFBIWSwNCiAgICAgICMgdGhlIE1BQyBzaG91bGQgbm90IGFkZCB0
aGUgUlggb3IgVFggZGVsYXlzIGluIHRoaXMgY2FzZQ0KICAgICAgLSByZ21paS1pZA0KDQogICAg
ICAjIFJHTUlJIHdpdGggaW50ZXJuYWwgUlggZGVsYXkgcHJvdmlkZWQgYnkgdGhlIFBIWSwgdGhl
IE1BQw0KICAgICAgIyBzaG91bGQgbm90IGFkZCBhbiBSWCBkZWxheSBpbiB0aGlzIGNhc2UNCiAg
ICAgIC0gcmdtaWktcnhpZA0KDQogICAgICAjIFJHTUlJIHdpdGggaW50ZXJuYWwgVFggZGVsYXkg
cHJvdmlkZWQgYnkgdGhlIFBIWSwgdGhlIE1BQw0KICAgICAgIyBzaG91bGQgbm90IGFkZCBhbiBU
WCBkZWxheSBpbiB0aGlzIGNhc2UNCiAgICAgIC0gcmdtaWktdHhpZA0KLi4uDQoNCkl0IHNlZW1z
IGlmIE1BQyBoYXMgYWJpbGl0eSB0byBhZGQgZGVsYXkgaW4gTUFDIGludGVybmFsLCBkcml2ZXIg
Y2FuIHVzZSB0aGVzZQ0KdmFsdWVzIHRvIGRlc2NyaWJlcyB0aGUgaGFyZHdhcmUgZGVzaWduLg0K
DQpJIGtub3cgdGhpcyB0b3BpYyBoYWQgYmVlbiBkaXNjdXNzZWQuIEkgdGhvdWdodCBmb3IgYSB3
aGlsZSB0byBmaW5kIGEgc29sdXRpb24sIGJ1dCBJIA0KY2Fubm90IHN0aWxsIHVuZGVyc3RhbmQg
d2h5ICdyZ21paS1pZCcgaXMgY29ycmVjdCBmb3IgSFc/DQoNClRoYW5rcywNCkphY2t5DQoNCg==

