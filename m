Return-Path: <netdev+bounces-291156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id //cOG3i5Emrx3AYAu9opvQ
	(envelope-from <netdev+bounces-291156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:40:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDD05C1B3A
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 10:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05D3D30078E4
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 08:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD12F531B;
	Sun, 24 May 2026 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTJ5yYrv"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011054.outbound.protection.outlook.com [52.101.57.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553020010A
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779612021; cv=fail; b=Y+oGx8NzH99x9mxpMktlaE/dimJSixHFe9vqeWjo3xTZpkWVeJJbC9EBKXlWFJ9irnQLB0DV66ke7LTAbGpPVTtL+LIxx5FR9tW4UaH7pBQ+iREnGyu8NEtBQOnN0uXK7bqV9XOFDIzqqFk2NbHa4r3JeDaCNCB7IIkTk5N8P8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779612021; c=relaxed/simple;
	bh=w+J5tjTVaMW7z45NWluJlr2jES3Rq5xrhdnJVprcQzs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKthJ/6uEVhqLs8CqubzwL2vp8cUMlAtOZOTAP5NC4x0mqfVXIqEILiALB598I4H7NiHmpbHG9Biy3vumrwFyq947um1W99il4cWNOzlriJbZjOFIvZirK02/RW5iVVxUSpZCYEzChtnCxYzLKZKUCpDGv9gLrYDUbxIQlvBg6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTJ5yYrv; arc=fail smtp.client-ip=52.101.57.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KISGFUlvII4S5jVVHWVEzLlBT5vA8zkOxfZNdeLYmGqynWJVdjMiB/8XtFzJWxKBHYfOqQUVL7HdC+wX4BXDrrOV0NxIRGm5QhJrX3F9sizkTj6IleZHs0uOXhzuKp4lyqQgdtwvgYrPoPwbXriQVpTzf0FwHxF2mi/Ni7+8pc4po7KbytNYhuQiQVhKHIf7n6ppJh92UO+e2peF4R2+DZectktwWtkC7xSFmaM2Y0QiAZkFnwrRL1zxASWIZfJXxvsjfjhRmlGuVZxpOzk9v+qPIwf2uFTZblZzX/s2i/dCQi8seU047miCbvEVofIUsnShkPWFvtLssnBKqpA2hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+J5tjTVaMW7z45NWluJlr2jES3Rq5xrhdnJVprcQzs=;
 b=o1ikA9ySQxN8IFy/VCdK2/fE3IqKNYfW3I2VyUcZ5VqdMiAVQ/B7yrdFrFU4eb5hAl+nHlwrGTL1UTGTLezI8QqX7DdzqwSGlXNB8Q3HAgsR6DwrVadzZqTevc0NlDlwzxvT0XW/h4pwlhgTdnoQ6RSDv8L/oIggTGz+VGHgpHZrUH7KRMH2DP4eKk+4xpKksuiQcVqAz2QKizWH9tg6OplzgLxsns7eMVxpk8Yn0gHog+qgiVCA83PeQGDext14jOkT9gObf07xqBP3dxR3zT04DR25oKnR6cMKDfyRHraBK7id25H17m9+bsR1AAjOXD3sELKmxi3DCXzJYBEjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+J5tjTVaMW7z45NWluJlr2jES3Rq5xrhdnJVprcQzs=;
 b=fTJ5yYrvihzYyLU5vD9IdmOyVbADserxoSl7VbI+5XHmzgj8fo9/FSGcL1rqpDYz2GI0dvZtP2F+d1SxhuoSp96kDW3UzdSro3OeUJJcbH26YF/nBa0Or/ZJ6S+V5Q2c2E5LpM+o8v39jZtsManGxYwX0GY2sIpyMHAOgCGJ0nXfzI+JDT372I/XAU/QBfXloSfSVINBW4UPxykAE7s4f1VZF6AeXkSsyX/wbDGbX9T+6/uXkdEaV8u4G4MV7B4epc409Jd932G2tph+ohZ8KGFzPJADaeJKkPTGs1cqaeciHG7PXeG+fEktudsjPBF+RnLjiILqf1OeXfZB4/gXiQ==
Received: from MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16)
 by IA0PPFC855560D7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 24 May
 2026 08:40:13 +0000
Received: from MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::c2bf:954f:fdcb:4b65]) by MN2PR12MB4517.namprd12.prod.outlook.com
 ([fe80::c2bf:954f:fdcb:4b65%4]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 08:40:13 +0000
From: Danielle Ratson <danieller@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "horms@kernel.org"
	<horms@kernel.org>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, Petr Machata <petrm@nvidia.com>,
	"o.rempel@pengutronix.de" <o.rempel@pengutronix.de>, Ido Schimmel
	<idosch@nvidia.com>, "andrew@lunn.ch" <andrew@lunn.ch>
Subject: RE: [PATCH net 7/9] ethtool: cmis: fix u16-to-u8 truncation of
 msleep_pre_rpl
Thread-Topic: [PATCH net 7/9] ethtool: cmis: fix u16-to-u8 truncation of
 msleep_pre_rpl
Thread-Index: AQHc6kCbwlVrU56mIUOfNkqYiQvII7Yc3TNA
Date: Sun, 24 May 2026 08:40:12 +0000
Message-ID:
 <MN2PR12MB451742209A05903FDBDBBA80D80D2@MN2PR12MB4517.namprd12.prod.outlook.com>
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-8-kuba@kernel.org>
In-Reply-To: <20260522231312.1710836-8-kuba@kernel.org>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4517:EE_|IA0PPFC855560D7:EE_
x-ms-office365-filtering-correlation-id: 697fcaf4-f783-4be3-5dd0-08deb970126d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|3023799007|4143699003|22082099003|38070700021|11063799006|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ryLbm1rhv07sVyabDP2kS/U3D2PnmfV2qdDZ9pz4KJxGa1VM4ECkNr6LHuFmFHnWvxK5IWcAwiK3egg0bE0UO+Vkg2n8ZPiWJvMS7CrX81eSvAQsU/wg1VoQvTPqb9fnu2Xr4vkkH1I56hBbP4G7ll25HxnUAEFO12LRqoQupipNlImLWsxxxBcf1m2R7vW5p5h0YW4JH9+pbr3gtmFjD5d1+abjfXS6cGKZ5J+nLptolHRnLM0CHZOUJ9zJoTIGmb+ggPcH2toPpXZSlWWsrda+oVFrMLgCgmw4KfWbAXLRYCfPKBuq2qYLT4g+Mf+IuJ76OlvV9/wkEbQH5wUcSVLRKx757Ftf0ZUzOU3q6FxEpo3EVtON30+/lI0aq+Xa0889hWUPCiXrr3Y4KRV9+IoPuWioKIKgeOATTb7YCXOuOeeivs9/GAtiU8zCQnTBVYFJIcLDX4B0kyTsOQn5u0bJxZhkcCFVbqf7Xny+BvYHq4YXJzVnlN0fzWfkZKB6ShGLRMuWRmG2RDCl2WABFmaY+86fHEVCYAJHyeHru6rfWISEJ1C1qrpinEy0qMUAQPl5zlZexEHUylBUi7Y0OOYM4OSw8t2em52D/u6PECdbgdtNLNo2UsXQ4rwCO4XyJQtALnRgtotsdEPK6swjHjRv4pABQZ2LtP+IXer5ZBDjIQEkm7pv9k2tIzyXLFH0wST8jrDbvhmBlojHmyHk9DEEMf02m6UI2CRuTcsV3p3ALlhV1VjJ+zDROT0EUlUR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(3023799007)(4143699003)(22082099003)(38070700021)(11063799006)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V01TVzA2RldFUVVWWnJKOUZ2TGlMZnZqWGRYRFNmaHlaNTNIWXp2V0NTMVBG?=
 =?utf-8?B?RUFSa2VUTDY1ZEZVMm1mOUpvdUJoazZsZnlnaFl1d0NYWUh1UjNnMHp6WTU1?=
 =?utf-8?B?ODl2Skg2TEdYYmZUN1YzdTRWc3gwcGlvaGpjcXRoSThLZGdWOFBVc3lUYnhX?=
 =?utf-8?B?Qm9VWFhpTmVlWU8yZzVEK1JBYjR3TzVqaUVkN2RUYnpDaStCQ3lMc3YxbWR0?=
 =?utf-8?B?MWo3K1ZIbDVwL0t5NXpwZnY3RVk0bFJVQS9wYjUyL3lPM1VKWDJZOGNyaWND?=
 =?utf-8?B?ck5VNkEwNmlsenN3WlkwVndacmVKMmVhdTBxd2Jkb0NuNnNiVm9NeVJiQXJK?=
 =?utf-8?B?WDVKdmFkYm45eGN2TFF2cFFSSmhNYS9KY3E0UWF3d3gvaTN0bjFRWndWU2I0?=
 =?utf-8?B?d0JOcjBpUXdXaXlwSnpIV0kwa1hsZnlvTjFQRENHRUVrNC9STlFlTHBMNFRm?=
 =?utf-8?B?TEcrbTZqL0VlSmZnQ2t6TmEvOVZBV05idm1iVDJheWlMcGNoQjlhbnh5bjhL?=
 =?utf-8?B?dVV2T2J6ZjlNUHZzYVpUV204UFJEUHhhWFpBZEYrbWYwQUtScGdrMzYrRFVY?=
 =?utf-8?B?RWpobjBqbEV3WUs5NjFLYTg5SXN4TTJDdEhjZlFpMWtrY01EQTdXTDZjQ3pS?=
 =?utf-8?B?dFdFL3VvZWlwNThnSjA4Yjd1RmpGdWhBb2twUUpnMVRpL3JWTmhRK04rTDRP?=
 =?utf-8?B?aUo0Yys0amJMNEl3K3FkNmNvdHJHdWlQSlBHWHJObDVMZ1E5MGo5MFdCWVpE?=
 =?utf-8?B?QTM3VUg2aERja0tScVJIc3BiNHZ3R1ZCMGFJMTJDSkhEa3VWK2Exak1OaUxv?=
 =?utf-8?B?MnFoMzY0S2tWMXlpUW1INDFXdGVIM3JRQ2tRV3Z2MHc4QTIxYUpBNEtnSC93?=
 =?utf-8?B?MlNaR2ZTTXVQUFBHUmlXcHUyZ2JGdDg2VzREaHAzbVhKa1p4YWM5K3lNWTM1?=
 =?utf-8?B?SVpPeVNrcklPencvWkIwMzVLZnkvNTFFbWJ2UWdtbG1XQjJQZklENVo1YmxJ?=
 =?utf-8?B?NnRqK005WjBtaDVpMUJSZVNJdXRMWGRvRHBXclhKekxMMVZ4ZTJRaWpKMlhx?=
 =?utf-8?B?YmZPQ0h2NFpiZWdiUjNmeTdJellid0lFSXJDay81U3RUS0t4OUQxS1ZLeVF5?=
 =?utf-8?B?a0JsTi9KMWpEWUxpZ0pKWjBNd0I1SklkUTZ0WHgyVk1mclJIcUNadVNFRzdw?=
 =?utf-8?B?RUxyZ1dQMjFSMDlEVlUxVjh0UC91ZTY4Y0xXeVpDbzJBNFJJSmswYnVobUpa?=
 =?utf-8?B?RkpsdUZmdTJ2TDBoTlFLNTJ2QWpBUUFEa3k2dU1rdDA1YU5UdG1CcVBzbTFH?=
 =?utf-8?B?bFRoYlRHeG1qNEFSaDF2cmlzMTFXWXNWV1NocWVyUXM0WVpiZnJLS1RNV3Yy?=
 =?utf-8?B?T1BITlVjS3dQMmJtOUN3cXFjNkUrWEQrbnhiV0dMK28xME9MUlAxNXR5dnRR?=
 =?utf-8?B?UzhxbU1GVGl4QkhlWVVSZjBzMy8wbCswaS8zcTlJdHI5cFFERHlVWXltK3dB?=
 =?utf-8?B?UHg5dStGMSszYTVFVDc2U3BTWnRRNHVWWFBkWXNBaG1oTGJPWWg2TlJGeXRQ?=
 =?utf-8?B?VmMyOWxkZzAvbmFka2licEt3T0dhOG5ZaURqS3psUWlLK3BlcGxDMW5VNDNC?=
 =?utf-8?B?ZzZlVVJQTjM2dHRlRzZZSEpJVmVDYmZoUzBPUUlkYVllVGNoQ3IzQmZ1b2h6?=
 =?utf-8?B?MDVLOU1DU2pjUmkvUG1CdzZtTVA4bnZWQnVZaUtMbk9XeGF0UkIxd0tZeXdj?=
 =?utf-8?B?NmNUYmtlSDV1aG1VTkVOYkM5RkNKYS9EZmxKU1Q4UVBTZERuZmJ3d3BBT0gx?=
 =?utf-8?B?Rmp0K3AydzE4ZHkzbGJ6Nzc4cjZsNk9zcEhNaFF0TGRCYVlLZW1uVXVHTW9H?=
 =?utf-8?B?cGJNV0lzbWVOenlmN3JFU1FLQVdRY3ZBRGZhd1VwZHdiQXd3Y08xV3pPMzZT?=
 =?utf-8?B?cDNyYmcxZjJXbHlOWlB2cThRZjJhMFMxY0hsbXhrbUU5dEphdCt5bHV1M3lJ?=
 =?utf-8?B?aG1kWFhVc2xZWUEzYndMbW5qYS9OYlRycWZBSyt1aWxEUlBBZC9wbE9WNG1y?=
 =?utf-8?B?U2FyWDlRRGxvb2w1ZDlsNG1ONnd5dXJDQkY4UDJnS01NUkdSZGZ6djJodDlx?=
 =?utf-8?B?WE1EMjFVamNxdngrbExJU3FDZVJjOUZuY3R1ZHhxbXlDekFoSUNlTTgvV1Va?=
 =?utf-8?B?Y1hvNUpjeVB0dkJuTVR0UWVYb2RoT1ZnOVRPdEo5WFBEZGw3Y2NJMWJCd3JG?=
 =?utf-8?B?LzB5eDJQdTZTQkZPM3VIZzN3bytSOUxvaUhFV3k3dEw5R0dvb09DRU9md0Vi?=
 =?utf-8?Q?O+Mit2+nMTKbyOpt93?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 697fcaf4-f783-4be3-5dd0-08deb970126d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2026 08:40:12.9467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Knoitjo52SGJ4NL0QHI5KZDQkdDlREIMH6RQUZpD3nPsCxBu4CGwBP+/4jXSJ2Hbql1XIJNgQMh6JmkeSwDZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFC855560D7
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291156-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danieller@nvidia.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.007];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pengutronix.de:email,bootlin.com:email,MN2PR12MB4517.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: ADDD05C1B3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYWt1YiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgMjMgTWF5IDIwMjYgMjoxMw0KPiBUbzog
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IGFuZHJldytuZXRkZXZAbHVubi5j
aDsgaG9ybXNAa2VybmVsLm9yZzsNCj4gbWF4aW1lLmNoZXZhbGxpZXJAYm9vdGxpbi5jb207IERh
bmllbGxlIFJhdHNvbiA8ZGFuaWVsbGVyQG52aWRpYS5jb20+Ow0KPiBQZXRyIE1hY2hhdGEgPHBl
dHJtQG52aWRpYS5jb20+OyBvLnJlbXBlbEBwZW5ndXRyb25peC5kZTsgSWRvIFNjaGltbWVsDQo+
IDxpZG9zY2hAbnZpZGlhLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+OyBh
bmRyZXdAbHVubi5jaA0KPiBTdWJqZWN0OiBbUEFUQ0ggbmV0IDcvOV0gZXRodG9vbDogY21pczog
Zml4IHUxNi10by11OCB0cnVuY2F0aW9uIG9mDQo+IG1zbGVlcF9wcmVfcnBsDQo+IA0KPiBldGh0
b29sX2NtaXNfY2RiX2NvbXBvc2VfYXJncygpIGFjY2VwdHMgbXNsZWVwX3ByZV9ycGwgYXMgdTE2
IGJ1dCBzdG9yZXMNCj4gaXQgaW50byB0aGUgdTggZmllbGQgZXRodG9vbF9jbWlzX2NkYl9jbWRf
YXJnczo6bXNsZWVwX3ByZV9ycGwsIHNpbGVudGx5DQo+IHRydW5jYXRpbmcgdmFsdWVzID49IDI1
Ni4gU2V2ZW4gb2YgdGhlIG5pbmUgY2FsbCBzaXRlcyBwYXNzIDEwMDAgbXMgKGl0J3MgdGhlDQo+
IHRoaXJkIGFyZ3VtZW50IGZyb20gdGhlIGVuZCkuDQo+IA0KPiBGaXhlczogYTM5Yzg0ZDc5NjI1
ICgiZXRodG9vbDogY21pc19jZGI6IEFkZCBhIGxheWVyIGZvciBzdXBwb3J0aW5nIENEQg0KPiBj
b21tYW5kcyIpDQo+IFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5v
cmc+DQo+IC0tLQ0KPiBDQzogYW5kcmV3QGx1bm4uY2gNCj4gQ0M6IHBldHJtQG52aWRpYS5jb20N
Cj4gQ0M6IGRhbmllbGxlckBudmlkaWEuY29tDQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogRGFuaWVs
bGUgUmF0c29uIDxkYW5pZWxsZXJAbnZpZGlhLmNvbT4NCg==

