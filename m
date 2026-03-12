Return-Path: <netdev+bounces-267113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH68BMHXsmlDQAAAu9opvQ
	(envelope-from <netdev+bounces-267113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:12:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA6D273FE7
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 521E530BFD5B
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D23B4EBF;
	Thu, 12 Mar 2026 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="zkgHMU1s"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013046.outbound.protection.outlook.com [52.101.83.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFC01400C
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327930; cv=fail; b=U0Hfa5AADY9GiJX/7yVxPFqc8s0UbLyC6QATs6ABqd1ZXSvgWsQrO4FhjbaH2eYQVxwk7De8P/Wg+4SfrAn8qGgKzXAWItZrO3F5jo+JTM88ZkHabcw6GYn5qnyWzg8tSAwsF3IZsyLy+/6iOGrDWNUiDl/ZHlb6pGPLQspwMHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327930; c=relaxed/simple;
	bh=SA5/PiMKBDcO/l7Mf9tDqed39oZ0Dcqnnz1MYk6or9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RpRlilK0x9QOa842nebTxRUgmI8ONfx1+UokCAMJdU3njrqczx0Fzg2CUbyOwsxcsGngeeh62ld41vMLFP2iJ4Zws6Qy5PeIRuAerC94lMzpTcRu3tWcAS8YrUBuARDe1fZoofrDYf03C7o4/TKb4VPWNoNvP3MXwyBWXD9qQoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=zkgHMU1s; arc=fail smtp.client-ip=52.101.83.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLufE3bqR9C66eRK2sDdjOnGGgL2bbeB7lcH6WcJnZa/d02ftPZ/3gsJnqgio6Btdw4+Wt10U6HEp3xYhAwscAeA5GMCPCPwn40eZ6P6zUrTxje1UxWCKfe/3JrIXzY/Yb7Y66nfQGrUcsG7F+18pud5rBi9uVuPG7TC3zm0tYA45yh6NxJEib0mwcWxrFZi68micUAeyABlXgokLAHb+hMOr8eHgd+f4J7/+K1x95EAvOzksOxIaIGojcplJD1XprLhK8Jv8Uvz8pPJrcjthy/mankgD8lV2U/95vcvvnTsylryHRCIvw3Pj1lWY136tElJmKv5VgcDY6VSMbXjRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SA5/PiMKBDcO/l7Mf9tDqed39oZ0Dcqnnz1MYk6or9E=;
 b=N4w+dwrq+WO9BQQF7vfXxgCfYc/gl0tJC8mgkHug6/XuaoCIKztyd+jsaLGUdorv5RJJIQ23RF3RNyeT7BgoVVsjT4a43b5ZGKr6Cff7T9Ve0SCKIIz0EtbLkckuUfmz6iJnO2oVJmDnQq3ujUoJhiHFr9tiHqH0fwJMrK2n4PCpqeTvhlVqbNQ4vjoDbq/nrAKu0Sn2iDi52urcOGzscdn4tt9L2GArcXhd1TX/DTAlSPESwyHQ+KIjtDKsTpmtVFA5pgYziFZOUEGRFBzmSzrVxTDgSsyFlmgqSQel5kcepU2hwIg2mRpxf4abaUTx+wMSWTOZBMUaS04gLr4OOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SA5/PiMKBDcO/l7Mf9tDqed39oZ0Dcqnnz1MYk6or9E=;
 b=zkgHMU1svR/8tRxcaXpRJ61m6excYTccivqynG4D2yrAEBDSVMw9Lh/8Fz7wyVUlcJU4LHSfBvwz0sJjJuNk8xV2N5OUnFPFnBopSdx1WztiU+/2iSNPs8Dq00uyzJlVr34hqZU3ziKT9mu6ePmc4PrUnseOGN8nA2kNgiAVYbHGOU6muDGCzsEZllvMR8jTcYOBmUMiTCnTPD8FGSGDLKss/DWZsKyLsZViT5ZPt/sc0vnpniumwn35YAxQ1qJPp9I3PpFCne9dbxpqk6wKK8LZUKgMhSmRmbWIc6+5/G+z+b7YP7ULEjPJcYFFbVq56dvdQk3yDfmxntpBRz4jvA==
Received: from DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::14)
 by AS8PR10MB6722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:564::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 15:05:23 +0000
Received: from DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ea30:bdcf:399e:679]) by DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ea30:bdcf:399e:679%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 15:05:23 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"andrew@lunn.ch" <andrew@lunn.ch>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: move MSI data out of struct
 stmmac_priv
Thread-Topic: [PATCH net-next] net: stmmac: move MSI data out of struct
 stmmac_priv
Thread-Index: AQHcshnFshdFNRptYUCfq4Ta73h+wbWq/xaA
Date: Thu, 12 Mar 2026 15:05:22 +0000
Message-ID: <b5b47ed3a98720b82f82217f6d7c3955559e121d.camel@siemens.com>
References: <E1w0evD-0000000CzY1-19rN@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1w0evD-0000000CzY1-19rN@rmk-PC.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5689:EE_|AS8PR10MB6722:EE_
x-ms-office365-filtering-correlation-id: 034ecdca-7bf7-47b0-a8ae-08de8048c8ed
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700021|56012099003|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 ecWDxenjGvjtvcrzu6wevubAXqPj5nBohKUnJgW1r53KbBJJc2rmW0qy1rpnWJAraReDB3B8tWtqWc7TS1fpmhUhQOpy/GfHKMnpL3Y8WvZ9CxWDDP6kMMdpkn/K7H6Wc1t+1rULOzFMlH95gCZGxqnffyLIFvVWsryIkgzaeBB1FHUuPk9bXLvXsA5K1uSbqsUjjvWtm9ThUCNDtoB8w7C5e90zueBeaMMclvVhNarvRf7jWF7q3Tv0iY729NE3wZAqux23ADHEXbAkdgHc195a0H3RLa17UVQjUZK/nf1f4EPyHo9vB3Fn4qh9agbGUfN3bACMZu1N7aMole+sbvcqCAB9al6fD7pDEPsOK50P6LDk3b46GpAILbn+A1za0c8Syt9Kfi/y4xSmtKw7G1W4lvmgjRRGDNYeLxptLcFGxZ/M4pPJNxqvSYjRDAhqTtYwbHcNZx8vosXghxkH6QoAuluFFWQA76hCQr0pNOLToHdLYyNnBw54LJZ4j1cE2S27cEGb+YXIwLCkEClHBfdJhGts3TysPP/duOWLgZApREhhoWOBRSA9VZU+2zQcn+Nn7TAFbn1gklXvM3GTiXyPupd4BWVuMnLz0tqRXecqw5IIxQGzTN57cnNv5YQ7DTLtUpyXIaCdtHkuQrh6WjqtKNvtk6k612NHQlIrrPS+IJ580sEnA0f38/MRUYatYQgZVzsfdcE7uAylzVqyvMjAsSi1J6c79K4cVkPwxnQ4yqHloo80PB+hviuHB3PDXLg5W9XQ8nQpnhpvUEEGAVKlo0io7HeJ4DcBa0pWDhM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUROa2taNEh1TWNPQmNDWUNVbmhVUDIxTnc1d2xUZGhlcm80dDlEUjhUTVAz?=
 =?utf-8?B?d1NIYnI5eUthNUdXeFFLSnYrMEUxdkZtend4Wk9GcitKcGVvUTdld2VBZnpF?=
 =?utf-8?B?M25hNnUybWFtWmNZQUtldGhxbkVrWXIvZ1Vxd0U2Zm0yV0lPRHVjK3BrZzBW?=
 =?utf-8?B?V2UzVEw2VC8vRy8zbWszUTlrL3A1UVJSTTVqdXUxeXk0REdmZnBKalZBMGky?=
 =?utf-8?B?WXFzY05pY011SFBnNlhGSFRnUE1WZWtkdHVCYkdxUUNtZm9OWWpnVEdQb0I2?=
 =?utf-8?B?cEZheFM5TzhjR2M5U2ZrVGZLVmRwcVhyYmQvVmltbWVzVTRIUGthMWdYMVpl?=
 =?utf-8?B?WW9TTittSG9ZSnhHaFZkRXkzcldVZzkzZ1dmeXc4Mzl1ZFdOUDNoTjB5dTcz?=
 =?utf-8?B?TWUwNXpmUFNTUm9jRHdoaEgyZTl5L2d3TmtUWGRNTzNzY2x1L1Z3YVhFenh6?=
 =?utf-8?B?WFlHek8vQTRhTXBRdWJDbXkwOWtYNlYrUEV1UDF1cWdxU0xDSUZpQy9VTFRN?=
 =?utf-8?B?S0V0eGViMXk1MG5ySCtBZEtRYUFUS2NxYUl5Uzh4dm91Y0RYMHVBUGxHOCtu?=
 =?utf-8?B?Z1VwczZjK1VGVGU4YUdDbEE5VXpTMy9pb0V0VmpzbWZreUxtS2xETUh2aDlR?=
 =?utf-8?B?ODQ4TWZnN2ViN1NLR3VkdldBdE1qbHJHU1AwNzgxV2pxWmFVTW0ydkJkaGYr?=
 =?utf-8?B?R3NSQ0M4cGQ3ODJaY3lzZmx1YUdEb0J0RGVGVFZ0MXVQd3VGL0pMckdOZkxN?=
 =?utf-8?B?SWxCbE41VHNISEp1RFhjWTM0ZlBaWUZINVF5eVNxT1ZoREpNbFBpRkhXVjZK?=
 =?utf-8?B?NkZ6R0xxcERYUnNNUUwxQVZESXZRSm5KWkdiczdoWU1HdEwwQTk0azQ0eC9o?=
 =?utf-8?B?UUdWa3BzbGhocWFaMVNwWlRHK25oOGQxM0QrZUZqQmlhbFAwNmxUYUNmM3lI?=
 =?utf-8?B?TFZGZEdwakxvZElGOFlWOHZJR2M1RksvaVJWWHdkQ1hKQk5uM2JIMnN2V1E5?=
 =?utf-8?B?NWM1aXB5ZVJQL1Z5SXEvQkxtd1ZOZHBPN3Q1cGJ1ekx3U1JXeUlpVFd0VVM2?=
 =?utf-8?B?UWE4aUE4VEFjU2hvQW94RFpXaTFzcmlLWjZzS1R3UU02YUw0NXc4c3V0TGxK?=
 =?utf-8?B?QjlRcld2TlZmVGdCVHZNdUhQK0trTExXQWhWYkwyYTJnMkdTSTlTMmh4MzRW?=
 =?utf-8?B?bHRyL1pUQ0l3SHBYeU44VTlGTkxJMGpFNUZIS2FlTElGNmUvbkU5OXE3QXdL?=
 =?utf-8?B?dEhPQnN6NzFKWE5YaG9VSU81RWgxTjl5Q2M1ZlRnUHpybzhOS2RRMmhWa2hB?=
 =?utf-8?B?S2dyMDJmcUlUaWNKazRtbDJqYW5aU1U0TUNvb3YxUVVPTFl6TUM3SzN3aHZN?=
 =?utf-8?B?UCtDWG45bWVYaUcvWFhFWFhleXoySmpCcEJZcFV5dWlpcVVja2NkSDhHbXVX?=
 =?utf-8?B?UHZoWEFNVWhnWmtTVUNJcG5FaldLMWNLM05VMlRFRyt2N3krQlN3cTFoMkM1?=
 =?utf-8?B?Nm04bmMrZkhwTkhyZ20wWmh4RnAwSWNqRWh0SUxJUHJzUkMxZnVZMk50eHdH?=
 =?utf-8?B?aHhJWktxd0E3RlBRR1hsaGtBRmgvT3pIblBFM1I3TjFYV3Zadk85dDhoMXBl?=
 =?utf-8?B?TSsxVUZrTzBlU1FCZ2pyb1JVcXllKytaQ2lWd0w3V0NnQlBUSWJYRFBDNVVW?=
 =?utf-8?B?NG1mQ0c5RTc1dXBLRlFKalI2a2pKdy9rT2s0aUxESUdwSUpDYXg3dVFWT3R5?=
 =?utf-8?B?TnJpeGxjSjlLelJJdWRCSEhKK0YwdzdCRTRzMm5iS3VLY0RsN0MySUp5ZE56?=
 =?utf-8?B?WXlOTWVZSTdzcEtPeE00dXloTE80aGNOZm5waU1VaTUrUnlQcGFpbEJQTDhx?=
 =?utf-8?B?UHhBOGVkNTRwdUQzWVFiT005UTdFVTZibXJuU3Nib2xpZ2FvNWxxQVhDQlB2?=
 =?utf-8?B?bEFYZzBhYWlSZUc2Z05qS1BRT1BreDJUV3d6Tjc5cjZBeTJQSFV6YjVseXZE?=
 =?utf-8?B?OFJDV2szRWFiL2xOM0t6NmZXWXUyOGpDTEFkQ05QNGNLbVhLQ2hvSEtXV2dG?=
 =?utf-8?B?VklzVWUzMkRKbHdQT0kxckc2UW1SeTRnYzBhSXhBSFZySmg1djNEdUh3a0Mv?=
 =?utf-8?B?dUNscVRsS3dKU3BmQWtVVjZTTHNETEpPeG10N3hHYUE0QUt3b1JEUHB6aElh?=
 =?utf-8?B?UkExNEFMYjJGTSs0VlVqMTJ5SUk4clkzWjJyUkU1Q2tPWDczbTBXaXpNLzY2?=
 =?utf-8?B?L2RsM1hzYWY4UmNQQlUxbEhRT0pKaHJsQVJRYkpHWTI4NnRDMjRpVXBaQ2JM?=
 =?utf-8?B?RTNDR3orSzhTVUhHUHhVNmVmZ1h5WDBxM3FEVTduQjdkMGVjYU1YTzVicDho?=
 =?utf-8?Q?astWTdgE53Q7Vtml90rqd/NXHNkMwrIVZjChcJ5mD8OTg?=
x-ms-exchange-antispam-messagedata-1: SXxiKrbUcljfRSIiE+4OgKIFTYl55b3vzTQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBA0B5F73F9EC24BBB774B5CF6922507@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5689.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 034ecdca-7bf7-47b0-a8ae-08de8048c8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 15:05:22.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNN2JHWxNRTz5BrggnIB7WpVpf9yzOwF7//gZNrngsxxl3lU1JxbDkI8jyKcnXQCjgSzLuQscUFSFIz6OcuOmWo1fiRrLYtZEHYDB1cKHao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6722
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[siemens.com,reject];
	R_DKIM_ALLOW(-0.20)[siemens.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267113-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.bezdeka@siemens.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[siemens.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DA6D273FE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

T24gVGh1LCAyMDI2LTAzLTEyIGF0IDEyOjEzICswMDAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+IE9ubHkgdGhyZWUgcGxhdGZvcm1zIHN1cHBydCBNU0lzLCB3aGljaCBtZWFucyBo
YXZpbmcgYWxsIHRoZSBzdHJpbmdzDQo+IGFuZCBpbnRlcnJ1cHQgYXJyYXlzIGFsd2F5cyBhbGxv
Y2F0ZWQgd2FzdGVzIHNwYWNlLiBOb25lIG9mIHRoaXMgZGF0YQ0KPiBpcyBwZXJmb3JtYW5jZSBj
cml0aWNhbCAtIHRoaXMgZGF0YSBpcyBvbmx5IHVzZWQgd2hlbiByZXF1ZXN0aW5nIGFuZA0KPiBy
ZWxlYXNpbmcgdGhlIE1TSSBpbnRlcnJ1cHRzLg0KPiANCj4gTW92ZSB0aGUgTVNJIGRhdGEgb3V0
IG9mIHN0cnVjdCBzdG1tYWNfcHJpdiBpbnRvIGl0cyBvd24gc2VwYXJhdGVseQ0KPiBhbGxvY2F0
ZWQgc3RydWN0dXJlLCBhbmQgbW92ZSBpdHMgaW5pdGlhbGlzYXRpb24gdG8gYSBzZXBhcmF0ZQ0K
PiBmdW5jdGlvbi4NCj4gDQo+IFRoaXMgcmVtb3ZlcyA3NjggYnl0ZXMgZnJvbSBzdHJ1Y3Qgc3Rt
bWFjX3ByaXYuDQo+IA0KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yL2FZdHE0eXB4
WFR2bl9JczZAc2hlbGwuYXJtbGludXgub3JnLnVrDQo+IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwg
S2luZyAoT3JhY2xlKSA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+IC0tLQ0KPiANCg0K
VGhhbmtzIGEgbG90IFJ1c3NlbGwsIEkgZGlkbid0IG1hbmFnZSB0byBjb21lIGJhY2sgdG8gdGhp
cyBjbGVhbnVwDQp0b3BpYy4gSGlnaGx5IGFwcHJlY2lhdGVkIQ0KDQpSZXZpZXdlZC1ieTogRmxv
cmlhbiBCZXpkZWthIDxmbG9yaWFuLmJlemRla2FAc2llbWVucy5jb20+DQoNCkJlc3QgcmVnYXJk
cywNCkZsb3JpYW4NCg==

