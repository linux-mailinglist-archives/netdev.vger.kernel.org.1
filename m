Return-Path: <netdev+bounces-303274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y6q5DcfeQ2oVkwoAu9opvQ
	(envelope-from <netdev+bounces-303274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF96E5DFF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=pAiVVpo7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303274-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB693010DCC
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5C52E62A4;
	Tue, 30 Jun 2026 15:13:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D49279903;
	Tue, 30 Jun 2026 15:13:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832437; cv=fail; b=lpg3R3/klsQpU3PWYH8z6VkYbicScIrLR4MoJM9R7kip2+gaTl5QfdgkORRs3yW6R5/ehql25L42lsut83fWjDqg20MToQyN3hBQgjvWnRKRUDAbUoaAa+B7CkzpWqEMpuzeS+7WlEWfYWdKxdHdKj6tjF8wfkWtUCAaMIvl/Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832437; c=relaxed/simple;
	bh=rM6OvZZe13aVxpDsb1hvvGn8Q17YnmVIbt+aAcb9Ak8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tU/l+nv1Dj2OQoJgtrZ47qXqQMYsbEbgfsPCfrk+BY/tRUMwc5JcITmhsxnGRdigThGrFj6ueDSxXtyPmOAp8hX7sVP5HuzWSSKrKDy2gfh/iPs9bP9aae9CBgOe2nkyn6d8sxtESNUvhkB3REgS0HLVWDRrPvvF7Mh/fWU6104=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=pAiVVpo7; arc=fail smtp.client-ip=52.101.52.69
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/0tgSTS6LoammThCaIJ1VzrjSIJ2+QQIf9wFpP11avZggp45AkZVcIHkhIy3RVwIr7NHXmZokHNZa9UmihmuX746QoNX5nSdOyY8KMnVpumifhw/GCRF5egam0SA9KQaIhXU4aD4cWRiDhAb46UaXIiuygGNIxYlu8OKlNjukycVCuWyf2RWEx/NidjB0e6Reb4yuraXLDcxTmV/scNAwtc4CMVsWg8rZI8ejBomlJF//GOm7VxMe2XboQjG7o2Aix8C3CRTVxFJD3tp0rzLDF9HAizr+cONEy9BHDMZMyNTTj41QDP4xWF0XQN8TO4tfGdMOesezgP8YPIleC8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rM6OvZZe13aVxpDsb1hvvGn8Q17YnmVIbt+aAcb9Ak8=;
 b=cvOqc88K5UD50eNnjrgo99Q5EXis/6TB5T60YxG2j84iWosg+VXsFWUDJa0scX0pKDIxukBJvIyacCzT1bx8m8/Ao+1s5F2MCSf6A1gSDVcqYqKMEb7FPRjO00ka9XFa9jb7aQ70Ci3YUFb/tjqHoGXHQBwS4C9pTyu5NLjRnzntFwQoXClh+7tj6umhV+vKuIz4ZPGNoZ15Zx7REhiaHF/Vfh7A7nUjByJ7JwJ9DCvvhA2BTqURkscAirZJBI2zJX0t0d3zKNx2lrJadiWubIg746xsJNUVkbiHGKbrc459jB8b5GlqPKnKdJ+0/eOXyH8WloD4hnIp1vbs+5+Uhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rM6OvZZe13aVxpDsb1hvvGn8Q17YnmVIbt+aAcb9Ak8=;
 b=pAiVVpo7qR9KenlbOr9hwk6kyjjjSWCRUhVIcZ9t5Nu3czxFpjTc9xg/JHhwF1367tClPFx8JGTUWHtXhzZ5syGOaDW6PAJF9WZUjTrJ+079VCyTaanT2WFzAC9b/br/zjCb3S+xIl0SGVXl8D7E7bHhHhFR4en8Ox7dtikF9H8v2GncgtZFuGrS5K+1HBypYUtw3y7wpGvqzhpYyAMjhXnyFjH5Mza18F9IY9mTz8xEOc5ZmhltMy6hI+QnjzfZn1LPVQl3Dfe7q4mtMXaGNLM8OLV1adXTMFUNYgrwYvvfw/U542rn0gPE6K4mp0rS/he4ez8GYBIbi3yfvJnixQ==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by DS0PR03MB7608.namprd03.prod.outlook.com (2603:10b6:8:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:13:53 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 15:13:52 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>
CC: "dinguyen@kernel.org" <dinguyen@kernel.org>, "rmk+kernel@armlinux.org.uk"
	<rmk+kernel@armlinux.org.uk>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Topic: [PATCH 3/3] net: stmmac: dwmac-socfpga: Add mac-mode DT property
 support
Thread-Index: AQHdCJS3s6rWWjcH10Ox3xzcAVXL37ZXISCAgAAAjQCAABNGgA==
Date: Tue, 30 Jun 2026 15:13:52 +0000
Message-ID: <b6c52ac8-32dc-4a58-83ec-ef600b306448@altera.com>
References:
 <20260630133108.27244-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <20260630133108.27244-4-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <4c285993-978c-4d9e-a8c5-c3b36baa6840@lunn.ch>
 <7c57bb08-b72d-44bf-be44-f1bcb2aa9a84@bootlin.com>
In-Reply-To: <7c57bb08-b72d-44bf-be44-f1bcb2aa9a84@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|DS0PR03MB7608:EE_
x-ms-office365-filtering-correlation-id: e6df01fb-555a-4406-598e-08ded6ba3241
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|38070700021|3023799007|55112099003|22082099003|18002099003|56012099006|11063799006|5023799004|4143699003;
x-microsoft-antispam-message-info:
 qg9lg0y4zAPzXJK5Z0M1TBJX5OoLNh1nXOPRqhYI4jJdCydoFTfD519CgSUSgy9tByaf1Y+hEcOMAmWNBkQXlI4dXHRUifshZIG1hSTxrEBjU1zJiy2yi0IDNx+5XhdIBF6q2x7WEM+jihSEuYFezVg80feGsPOZ/2l61rtHb0rYF6UScLcv78L1myATDhosmm/5CLV9Bn9OtvHtHLoa7SCx/D8HrXu81WSk9k9Wf0I8DrxQwmG0aJS1FTenoGLVp7+lzWiipeWehEdwNDoNDjXmNMH9D0lKW3VufJzaaubVIbclT1Rn8dwmtRq+oN2v4BtA9wqWy21P443ZHr/wSyxlYzFtzcPtgNzEREsIhRTPmymJa1jk6RcQ07rP4y8YkPIhu5nNju4RSJvRSj5XFaoB00hO1mWXpss3jnfXvguFdNEEL54M83hOSia/X13PB0G0+9Qz7FlMAenCWqCtnUXeEt+9DgQYy83dWLvhIqMiQps6Ff2EhgNX3g/hKifNLqmMuvduZJtJiC5p+nbCKpNqBehIBdcLWLnO7XV18tjW8KZkdMWwICiWMKPW1xDSMyv5FGUiXP/ECAdRfgQfIqLGqt5rNgMp2B0aZwmN1ocOPccbvCewEi+w/zon1dA6QcZR7ybchvO4AnQEo1GC6A7yT/57ed9/cJakAFdeLo6AByBWGONrQAKtZczGvXGtvcXqfZxq3TD2XC6j1WNN3fa3LeawPLbJ6q9WluAU5Ig=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(38070700021)(3023799007)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGNkQ3YzNjVQYVR4VExnaGo4WWtzYUlyTDQrTkFMK3pYQTAzRHdwSnlnVThZ?=
 =?utf-8?B?NWxpLzJSdktwUW83VlpBUElseHJFMjVmU0IwZE9NbytNUkVtT002QmlONXU4?=
 =?utf-8?B?R2hyTlltKy9IQ2Fxcko0WC9oN1B4Ykp6YlBiZVlqWFJmc3FQRmhqL3ArUVVF?=
 =?utf-8?B?U3gvM2pqZHVybzVoSHNLb1VzbHNPT2FkZWtuNzBtZUZ1OTRnVVlmWDd6eEth?=
 =?utf-8?B?V1p0RzJjeHhqT0d0Q1ZETndRQUROOVZSZEtpemFtT1pTT2VwdkVza25CajBp?=
 =?utf-8?B?Zm1seHFrcWZMeDV6NHlXY1F4Mlk1UmU2empUWkVHZnVOUDZGeGw4dlk1TDdD?=
 =?utf-8?B?eG1aZkpiRFFPVmFGMVo1Vm9TV1Q2bHIvcUtLaVhBaHhlckliTDVFU0EzVi9z?=
 =?utf-8?B?SDhNQ0dleVNOMGhOK0w0SUZhcjlpY2gwZW40SS9CVCtsREVISHlRRmF3T2o4?=
 =?utf-8?B?ZHEwaUdiQnRsODF5N2JTVkFTa1NMb0VPdjRSV01GdjE3RDY3UUtYcFo4bTBI?=
 =?utf-8?B?Vkx5cG93UFVlei9FSnRxU3AvczJiK2FrVzdYNkd5aFNTWE5rNGtmRkg3WGRj?=
 =?utf-8?B?RllrWWZGMTY5cVl5dXFEMGFvcXFQdkhXWWV2TzN0bEJXZ043cVd2Nis3OXVo?=
 =?utf-8?B?R2xWU0JPdWZ2TWJGeTZUaUFYa3QrNmNKOElkZW9PZ0F1NjBnSWVYdnh2MDcr?=
 =?utf-8?B?VE5JWE16NlFCM2lZaUt5ckVXTVZTZUlUbHFDZVBnNEpkSW5xMjdaL0RmWm51?=
 =?utf-8?B?ek1LSklta3E0czZKQm9sdzBOZm5IM0haL2l6NVZ2VDQ2cEwveEVUZXJLRSsw?=
 =?utf-8?B?TzR0dDFuSnExYUF6RG5MbTZRSktzck9qV2RDSUNSKzJkSlN5UHdBSCswL1BS?=
 =?utf-8?B?M1o5VkZxald3TjdHdWQ0LzNneUxjeEhnWVd3bVJIeWl5cmVLL1pUVHRvMEFF?=
 =?utf-8?B?ZXArUWZFWU5sZHBuck85blFndGdOVVg2TGtmMHV1aGN4SXcvMnFXNWowQVZC?=
 =?utf-8?B?UUZtbkN4YWllUnVoUjJxbmlSZmxzcUUrMy9lRksydXViUC9JTnJSZ21tcVVN?=
 =?utf-8?B?VzJOYm5CVnd0ZnBodmlRZVpURHVBRkpLWTU0NlZZR0cvNGJLbUZjZ08wS2Qw?=
 =?utf-8?B?cWNLQzRNaFcyN0FJQ3JNZ2VkRGVpTkk3THFXekMyS05YZkt2aHYycFozc3p3?=
 =?utf-8?B?aEtTdFc5VDFOZHlrM29Hc0t5QXpnNktTdGdDa1ovaCtmZDhuM3RGSlI3Um5W?=
 =?utf-8?B?OUdPaVpjQXFJOFZIYm1MLzU4c2Uva2JkYkFLcHNEWVhzRkhWenRmQXFqd3dM?=
 =?utf-8?B?TFFIOG1TY2ZXRTU1VGw4M0d0NFFOczFZdzg4TjVSeDVsbHVIcGpnVk8xYnRQ?=
 =?utf-8?B?T0tZc0t3cHR4RFlmcFhmb21BYkd0MGIwcjVneU52aEJvc01zZG83K2VLSEIx?=
 =?utf-8?B?Y21hcExhVWJ6REFzc2V4eW8vcDVSRm9UYzhOdHdGd29TNWRpcWlHVmxhNlgy?=
 =?utf-8?B?dWx5VE0vM3N3M2E4a2N5amVkV29BbUJqbWFIWGVaWitySFJET3pJc3Y5Yzhx?=
 =?utf-8?B?NksvWWxZa1dkV3Z2VTdKOThDaWExbGhFaW9EZHlGUkNaUzBRSy9CYnczbGdC?=
 =?utf-8?B?WkdWdlZnbFhWUE1sM3VsRVA3clpYOS9OdkZvTTVocFJZbFMzOE5pQ1A1UXBM?=
 =?utf-8?B?UzBmbExpNFNyYWhmSStKeC83Qmpkdm5OSXFoMjVPV3d3cnAxZFpZOThHdkhv?=
 =?utf-8?B?QkxGQy9XS291THhvSG4xcEIrNXhVOUtjYW1DZDlLaTZHb0lraFdyWFUzOVlh?=
 =?utf-8?B?TGhuM2wxcGZ4eHprc1pUNDZTYzRMUXhPT3RTV0xxbUxMUXYvN0V6M0M3ZVBJ?=
 =?utf-8?B?WDNyVmRsbDMyUE45TGI3SnNpVS9WTko3V3pLYTFjVWRaajZXdGRVVS9jWmpS?=
 =?utf-8?B?NVQ2R0Urc2dDU3IxOTdxS1J6L1VBTU9KMXpKOTBkS0RUV3dzSzd5ZGVQMVZo?=
 =?utf-8?B?bTBnMVdoQUNJM3BqWFBYRUt4OG5BWnpmUTJyMnNEaVZ0cjJWaXVUZGFsWFFC?=
 =?utf-8?B?OHhkdVNjWjZMRnRYUWVJcHd6OFlkV29ReVpRaTJHNnFSS0VLcUVwVDBHSlRM?=
 =?utf-8?B?Nmd0TzNwMzRGOTh2SkJtVlI3emxPRXlkeXkyMkRrbTJIWEJoTFNFZlY0QlZq?=
 =?utf-8?B?SjN0bjlKWFNxd1N1SGdqcEROcE5BMitHa1l5RWszZ0UyckV0emhFUUJKY2FH?=
 =?utf-8?B?dmgxWDNIaTVtYnRBSUEwN3FMV25zT0Vlb2dQY2NsZ1I3ODNJYnI0cTVqMXls?=
 =?utf-8?B?cWN3Q0RPcmIrQ2w1bmdWa3hWdlZlM1pmaXNaZitBZWRSNU05UEIyeXJxL1Bj?=
 =?utf-8?Q?RJcmqWIsNzNg60E1FDuHYbs/mW0mi1CmWj/qk0SpI1On7?=
x-ms-exchange-antispam-messagedata-1: 440uBHAw5j41wQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8BB63A304284094B954DDAF4881019C9@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6df01fb-555a-4406-598e-08ded6ba3241
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 15:13:52.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+SEvwCKYEMdX4y21k5NBH2z8PrSqPSYjL9Bd20GYAMZEGfjnZ8r+kwHkpXQ8tGO/LigvYkgtr0NSRllK3zycwlaPBEpALYBL0RzDPus1M8QInrijxuxFWybPrIPMzd/EpkuCy24bkcXAYRbh++0VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7608
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303274-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:dinguyen@kernel.org,m:rmk+kernel@armlinux.org.uk,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:robh@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[altera.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ACF96E5DFF

T24gMzAvNi8yMDI2IDEwOjA0IHBtLCBNYXhpbWUgQ2hldmFsbGllciB3cm90ZToNCj4gT24gNi8z
MC8yNiAxNjowMiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+PiBPbiBUdWUsIEp1biAzMCwgMjAyNiBh
dCAwNjozMTowOEFNIC0wNzAwLCBtdWhhbW1hZC5uYXppbS5hbWlydWwubmF6bGUuYXNtYWRlQGFs
dGVyYS5jb20gd3JvdGU6DQo+Pj4gRnJvbTogTmF6aW0gQW1pcnVsIDxtdWhhbW1hZC5uYXppbS5h
bWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20+DQo+Pj4NCj4+PiBSdXNzZWxsIEtpbmcncyBj
b21taXQgZGU2OTZjNjNjMWRjICgibmV0OiBzdG1tYWM6IHNvY2ZwZ2E6IGNvbnZlcnQgdG8NCj4+
PiB1c2UgcGh5X2ludGVyZmFjZSIpIHJlcGxhY2VkIG1hY19pbnRlcmZhY2Ugd2l0aCBwaHlfaW50
ZXJmYWNlIGluDQo+Pj4gc29jZnBnYV9nZXRfcGxhdF9waHltb2RlKCksIG5vdGluZyB0aGF0IG5v
IHVwc3RyZWFtIERUUyBmaWxlcyBzZXQgdGhlDQo+Pj4gIm1hYy1tb2RlIiBwcm9wZXJ0eSwgbWFr
aW5nIHRoZSB0d28gdmFsdWVzIGlkZW50aWNhbC4NCj4+Pg0KPj4+IFRoZSBBZ2lsZXg1IFNvQ0RL
IFRTTiBDb25maWcyIGJvYXJkIGlzIGFuIGV4Y2VwdGlvbjogaXRzIGdtYWMxIFRTTg0KPj4+IHBv
cnQgdXNlcyBHTUlJIGludGVybmFsbHkgaW4gdGhlIE1BQyB3aGlsZSB0aGUgUEhZLXNpZGUgaW50
ZXJmYWNlIGlzDQo+Pj4gUkdNSUksIHNvIG1hYy1tb2RlIGFuZCBwaHktbW9kZSBkaWZmZXIuDQo+
Pg0KPj4gTWF5YmUgeW91IG5lZWQgdG8gcmVwcmVzZW50IHRoZSBoYXJkd2FyZSBibG9jayB3aGlj
aCBtYWdpY2FsbHkNCj4+IGNvbnZlcnRzIEdNSUkgdG8gUkdNSUkgaW4gRFQ/DQo+IA0KPiBZZWFo
IHRoYXQncyB3aGF0IHdlIGhhdmUgb24gQ3ljbG9uZVYsIGFuZCB3ZSBmb3JjZSB0aGUgSU5URl9T
RUwgdG8gR01JSSBpZiB0aGF0DQo+IEhXIGJsb2NrIGlzIHByZXNlbnQuIEkgd29uZGVyIGlmIHRo
ZXJlJ3MgdGhlIHNhbWUgb24gYWdpbGVYNSA/DQoNCkhpIE1heGltZSwgQW5kcmV3DQoNClllcywg
QWdpbGV4NSBoYXMgdGhlIHNhbWUgY29uY2VwdC4gVGhlIEdNSUktdG8tUkdNSUkgY29udmVydGVy
IGlzIGEgDQpRdWFydHVzIHNvZnQgSVAgaW5zdGFudGlhdGVkIGluIHRoZSBGUEdBIGZhYnJpYyDi
gJQgZXF1aXZhbGVudCB0byB0aGUgDQpDeWNsb25lViBFTUFDIHNwbGl0dGVyLiBUaGUgWEdNQUMg
b3V0cHV0cyBHTUlJIHNpZ25hbHMgdG8gdGhlIEZQR0EgDQpmYWJyaWMsIHRoZSBzb2Z0IElQIGNv
bnZlcnRzIHRoZW0gdG8gUkdNSUksIGFuZCB0aGUgUkdNSUkgc2lnbmFscyB0aGVuIA0KZ28gdGhy
b3VnaCB0aGUgRlBHQSBIVklPIHBpbnMgdG8gdGhlIGV4dGVybmFsIE1hcnZlbGwgODhFMTUxMiBQ
SFkuDQoNCkJSLA0KTmF6aW0+DQo+Pg0KPj4gCSBBbmRyZXcNCj4gDQoNCg==

