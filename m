Return-Path: <netdev+bounces-276793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGoKOfAU12k1KwgAu9opvQ
	(envelope-from <netdev+bounces-276793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF5B3C5C3C
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48E603003BD7
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA71E3242A4;
	Thu,  9 Apr 2026 02:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2139.outbound.protection.partner.outlook.cn [139.219.146.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44523AE62;
	Thu,  9 Apr 2026 02:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702809; cv=fail; b=KqH4SFo9/1SXXV43r5UjET0+Md9pnaVpJZqYWvpdKIa6NybOrHrBYfdBVZQneKrh3+tXJVaakDsEfQb6KeIS9Hrbl9ui/VjlcOQ0LTa7CHefddf+DioJqEFncoIzAj93Q+AVsCwFE1sN7jLXEO0R0A1hMuFwo2TUMJWCwJo2bzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702809; c=relaxed/simple;
	bh=/Y2VA5veFYk0Y1H15C67jAwp76YSSXQKqeAwW8Ta59I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b52pTcoyVTQjB9IdDcPloo+o5LghIeK7DfQXowLGz0ZrLsTEDG95gGfX+Ntl5ShRJJd3KG/4pFDr6YAEhMAY51N/huBYewbMf6WmSxQJoaYSg7u55KR+i1pVkN/mv/KEz5VZR8ajGTC1haNHstRBJaxFh4CsYeHA/2I73tmaVPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtcRs2dcZQEQnXXS05K+oQj0xwi60CfF0y0xoNg05WHugG2BazpGfmcXg7ilveKl9eToMK27csog3j0+WzUQ7T1gIgzc1MHzlRdWNTzwzUJ/hmLMtWRtPMhunMPwBpxwT/fJNjI6e/u1fOQ9PEYvrAu3/whgynYa4+IzDJPfG2vb/uFzKmH9Y50X68wq/Ld3LB7KRNKoO7Jhhj2s3kz2Aeu3IuawRRs8L7M1SaRIF7gYjzB32njZB/MVR35JwttLYqvZmX7Ab94ikuxJvmFuH74V9TiYtm+jtG7PoxRfZ60mtuj3p++VnXEDfSs6e57EiybT1CtHhhYRKK59iaM02Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Y2VA5veFYk0Y1H15C67jAwp76YSSXQKqeAwW8Ta59I=;
 b=gWEPxJbvwmd0t6lzSWjac3YCeB47HKBoa2nZJiedoofvB06alzb4N6fPpDkufAQDfmhhsC5AmQwwAnBFYOUVhqS3PMIQk0ZzL4sqNrh7J+f+6mDJl4n6bx9uk+XqHr98NhjsuU2gOlpxLK1fSTUXnODfVHEAZgojcmJ4DSTEGdRxkq8ri8QJRpVlwV9AtUT9+kCdqErSzk8V0oExjvYW/ktKSgR5U6uXRCxvHyb6VnI5yPtkGZoJPGVuMltY/56NGRd87xqhSwHNG48iawRnhFop6lsJvyi0v45KjbR8K9uTblo1DuW+m6jm0vdbLQL9SBG538H2Vx5KT6Mm10Do+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0734.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 9 Apr
 2026 02:46:34 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Thu, 9 Apr 2026 02:46:34 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject:
 =?gb2312?B?u9i4tDogW25ldC1uZXh0IHYxIHYxIDMvNV0gZHQtYmluZGluZ3M6IG5ldDog?=
 =?gb2312?Q?starfive,jh7110-dwmac:_Add_JHB100_sgmii_rx_clk?=
Thread-Topic: [net-next v1 v1 3/5] dt-bindings: net: starfive,jh7110-dwmac:
 Add JHB100 sgmii rx clk
Thread-Index: AQHcxzPpSzxCtzZL3kCcOZS4bZuZ9bXVS7sAgAC7kjA=
Date: Thu, 9 Apr 2026 02:46:34 +0000
Message-ID:
 <SHXPR01MB086324F54E75BB7225E156F6E6582@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-4-minda.chen@starfivetech.com>
 <c69cf692-87be-43b5-93ee-38040d5cb1bf@lunn.ch>
In-Reply-To: <c69cf692-87be-43b5-93ee-38040d5cb1bf@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0734:EE_
x-ms-office365-filtering-correlation-id: cf132a0d-011b-4c80-dfeb-08de95e236b5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 G6LS4A1zg6CUTjfGv86zeHWgPPdKPhnFNBxJ9X7qkZ0Q9J/D8mdWMgfSQWMqA7LkSPqqzu8hNTjfbwHvpUKZXKEMI5T/v2YwPUgDkmHb07jMUKPbj+FsUzWwHXUrDp+xBOEFDri+uYppTmnXx0kjfqWCswg0y4odaVqcUJre+nr9ErqbTCW/wlJG1fKCF3i8zPgmiLtns+8IS9af5ubnbhRA/CI/aW5jy3+OMdRNUmyG1k6RFgjsHQtDL59iWgopDw4wrqD6FHFGMkluCI101DLPycQ7DC/5dTKpf7jiCuRgYCZIHl/m+nfY+8x0fPkaliV8B7emncG7BGrhpBDlJnEcU19/G5DbZhdiFVL134bB/sP9WCvmGn7l6iyuwKr+WLgoLlN+cYs5Xp/LnWJf2/lqZ7LBcwCkp4hCElJ4TemyCPgXmPxDj3KSrXkENAzuTc7qbLj44qPTM1vCnQ1qb1nNFCZUXVr81TN6E42NdYXrA/q5LtbfvL0rUip1kvN6mY35aO2uPbAyP3Gguw83oYTgWO7+wYlxGNwYMOnEfR97eI3x6LLqW+tChwmb0rBENVuWl568KhSxhHVsD6+ZlpfIdgMsbJBQj89VG3B54rI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bTU2cG45bHZ0RXpYU1lWZHFTc1ZKOVhNeWlGTWpYMUVCUDIzN1FKQWZDMTc5?=
 =?gb2312?B?Z1cyMXNydFdSbllmRE1oeEdvVEJ6dFcrSEVJNUVZdjZLeG1FQnlBUzhNMFFM?=
 =?gb2312?B?YWxqbjhrdTJ1UHBUM1RVMWVVWjhvbFJxcitKeTdCQnc1VkdkbklXUTFqa3N4?=
 =?gb2312?B?Q2dacWxod09VNVVSZEpwaThsUFdXTHZ6V3ZXdlZqMk9CbHpiUDRmcDdhckJa?=
 =?gb2312?B?ZEZVY09VemFnaTlpVllkMnpNNTVwcDFNNFhjdWZsK2hLdVBXVlJDVkF2Tk5x?=
 =?gb2312?B?cVFJd3lPY3BtOGlJWjRyRjRqQ3R2UzJmVlNWVWJtczg4a3cxSVYwR0wxU2s2?=
 =?gb2312?B?YXB0QU5NL1JBRDRXdGU0SW44eExta3hHTFZWNmoyU2VrOTVjYm5jQmVza2FO?=
 =?gb2312?B?VmRLRVVMQW1JYUJzb012MEpJMGxtbUJNYzZ5N2h4VWxmRVUyMFJRVitzVzNU?=
 =?gb2312?B?V3F2NkxyM2prWlJRakx6aFNnT0Z5Q29XMFBZNGtrby84UkQrcDE3akswU2VW?=
 =?gb2312?B?UjNEYjM5OGpZK083WlFNenlBbk9NQmp4VmE0cXdyNlZUWXloNW5tcGZIdHgw?=
 =?gb2312?B?eWJSVVdtSDc0ZzdSSUlla2VHSDJwTUdkNzZvcjJTeFBTT3g4T0ZmTHVjME1s?=
 =?gb2312?B?TGtWVnRCbE03RW1QMFFnY3ArNjNMamwvS245bVFSaHNYRytrWlFBRnNZSU5a?=
 =?gb2312?B?NGZrSnYzL3BoWFhnNkVvT1FZNFJLS0YvbzgwOXdoOUVCYTZEUG1ZUEMxRUVx?=
 =?gb2312?B?b3pGdGRlMUhGYU5zaml0blhwNERMVmtFdTYxYWhjUHIwWUh1TUdjdm1vNnJ3?=
 =?gb2312?B?T1FZRzdaNTZndDJXT3pRU0I5cWJIZ3dvdG5WLzRBUkl3eWl5SGhCS3hPbDha?=
 =?gb2312?B?cVdJU0E0ZVRRdlFVMnJaUno4dHVXMis2U3RlcUhvblVadGo5SVBHL21LNk82?=
 =?gb2312?B?OVBRaEVwaW5tOHJyMFNrUFNHMmJvZG9IYUxrRlRKSXhDRnJMT3B2MFBlNWhq?=
 =?gb2312?B?Q0J5U21lVC9mdkdtaW11RlVsdnlFR3ZKdmtCd2h5S0t0WWhMclpMbTVNTVVa?=
 =?gb2312?B?UnVkNzViWTFJUGd5dEdmTUhjczUrd3o4cWhWcDlXK0U3L0NCRm9Da1B5RFdX?=
 =?gb2312?B?N1IzSlVrdzNRMUphOFR3MzN4MTBia2t2K0VqS081T3granNMRGdQdU96dTBY?=
 =?gb2312?B?bEZpdWtVRTVYSDMzd2kxaWJGcHhIUEJrMzJBa2ZwbXNkcW04UmVLMGFMUFVC?=
 =?gb2312?B?MjJNbXZlUDlHdmVLU0RwZGRDRFNMR285eW5KNy9NRk5PNmN6VXFNZXpLaUN3?=
 =?gb2312?B?azFuekkxMUdhV0ZCaUw0Qjh0MVhXRW9yZ1F6dXF5eStYbzA5bEZpUGxicFZ5?=
 =?gb2312?B?L3R0NkxIWlBwT1lNbFA5bjRXNllpekdwc0F1QS9paGZac0p0QUlUME9WcmZk?=
 =?gb2312?B?M3B0UEYrbHByM2Rjb0VURlQxU040NEtYcjJjYUVGN1RRUXZiSEc2SkdPcjBr?=
 =?gb2312?B?OHpQbjhldWpxRHBXVU1veVNteHdtajNLK1RtUmNXM0VsalJhOURSYWgxVGti?=
 =?gb2312?B?ckZPMlAxNjkzMzVrdGpxaWE3dlJLZWFxVlRreTEyM2F3ejlSWHAxL0RZYlY3?=
 =?gb2312?B?d045VDkyUmtBdWpEZUdUbzJvUEIvSm90dm02T3NJR2NiQVdZTUNRUW5yZ3ow?=
 =?gb2312?B?V1RTMkd2R2JUV2xRWkJXaTRPNENCZGJxY2RhQ0hzNURXdHFCQzZ5czd0WmJC?=
 =?gb2312?B?a3c5TFRWY0Jaa1ZpbDJldjF5UnU0RGlyUjQ2ZXk0VVZZYmhlU3dKaW5OTzFY?=
 =?gb2312?B?UytmSFVkM2JURGF4V1IySmw1SUdBMTZjendSV3hYbzJzakJNKy9mWE0xaFZ5?=
 =?gb2312?B?VmJWTGhHcFFIZXhMZis5S0pZUjJwYzRHVXpZamM0blJOalM1bDNqb2lNQXBT?=
 =?gb2312?B?c29ZeFU3WGpwK082Y1Q2cUE0VGQ1OGNoeVU1VFY3ZFcvSUdmSWZYN3FwamJ2?=
 =?gb2312?B?YXF1enJrQ0dLeTM4Vlg0V3dpYjVmWGlSYS9DMThEZW4xS09ZYWZKMFNoaVJS?=
 =?gb2312?B?VitVd3ZBS25ablRzanFoSDVNMTIvcmUxWFlFWHJQZU55Q2xoQmFQSXpPR2d5?=
 =?gb2312?B?NWt0VGR6Q0E1cDI1R21NMm1FZ0VyRWg2QU1FNlJJaHFnRWNiL1pvNGUvZkJG?=
 =?gb2312?B?QlBWU0dBdGN5OWp1dmxTTmdEbGppZDJWYXI4eStYcTdISnoyeUc3K1JKQ2Ri?=
 =?gb2312?B?aitKT0dRODVWVlVtdE96d1pvOUVtVEZsbjkvMC82UnJpZDJ3bjN2eVlXbW9O?=
 =?gb2312?B?dlJ6ekZXekNEL2FmTG5zaDU0WGgwc1h4UWNsTy9WT1dydkNxbVJlYnBkdWtY?=
 =?gb2312?Q?MDW1wx/IrwssSlLE=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: cf132a0d-011b-4c80-dfeb-08de95e236b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 02:46:34.5851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iC6weaNqb2aUtJGRtn/nUIK1cWrN3eX0BJ2WQ9HzcrDit8Bh7RMDUB2Vf20c4+oNS2dH7GFrYzDdxY643rxRiNEZsYt8OeTlvH8QXKPLUp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0734
X-Spamd-Result: default: False [4.64 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-276793-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.417];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid]
X-Rspamd-Queue-Id: DFF5B3C5C3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IFNHTUlJIFJYIGNsb2NrDQo+ID4NCj4g
PiAgICBjbG9jay1uYW1lczoNCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGNvbnN0OiBz
dG1tYWNldGgNCj4gPiAtICAgICAgLSBjb25zdDogcGNsaw0KPiA+IC0gICAgICAtIGNvbnN0OiBw
dHBfcmVmDQo+ID4gLSAgICAgIC0gY29uc3Q6IHR4DQo+ID4gLSAgICAgIC0gY29uc3Q6IGd0eA0K
PiA+ICsgICAgbWluSXRlbXM6IDUNCj4gPiArICAgIG1heEl0ZW1zOiA2DQo+ID4gKyAgICBjb250
YWluczoNCj4gPiArICAgICAgZW51bToNCj4gPiArICAgICAgIC0gc3RtbWFjZXRoDQo+ID4gKyAg
ICAgICAtIHBjbGsNCj4gPiArICAgICAgIC0gcHRwX3JlZg0KPiA+ICsgICAgICAgLSB0eA0KPiA+
ICsgICAgICAgLSBndHgNCj4gPiArICAgICAgIC0gcngNCj4gDQo+IElmIHRoaXMgaXMgb25seSB1
c2VkIGZvciBzZ21paSwgbWF5YmUgaXQgc2hvdWxkIGhhdmUgc2dtaWkgaW4gdGhlIG5hbWU/DQo+
IA0KPiAJQW5kcmV3DQoNCk9rYXkuIEkgd2lsbCBjaGFuZ2UgdG8gInNnbWlpX3J4Ii4gVGhhbmtz
IA0K

