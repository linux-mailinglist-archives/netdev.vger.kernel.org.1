Return-Path: <netdev+bounces-295112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5RqBEE7IWohBgEAu9opvQ
	(envelope-from <netdev+bounces-295112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:45:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E963E1CD
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:45:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=u3N6Z+hh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295112-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295112-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 211743015893
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A9D3CEBBB;
	Thu,  4 Jun 2026 08:39:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B853E16A3;
	Thu,  4 Jun 2026 08:39:25 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562368; cv=fail; b=q2bGfDWiQE59kX02P1XebBaZhYB+v/Q04UyBz5GYKY1D3MECVrFY8ry21ATpN5noUbWRzTlECeVBV9JmPUscg07gKo48xmt0Vg73Y0QtID0wu/Q2n5zLRMMBq0CcGeFvyAO0/D/Ts4y54aJTjLVxQRqsP3KrE05AdDLdBGvqWus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562368; c=relaxed/simple;
	bh=GHfHdxZk+MVXWWk7ko52f9arL7Br/ObW8JDtjfijL7I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6nhP0I+ZWW6zQnbpVW3W2Nr0rIAwyaOFF/zwByuRghUrUsCkxuLOpD7C6BvHzt6VThMEiS8LzFJAoF+5Uw/t68yp6ENpbUpMrN5jWoKm/rpKa3ah65SCLc0XnMSbpnINBUS7NPpru2xkhsuWbFKCof1StDIpkWZfyE+QwWKBoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=u3N6Z+hh; arc=fail smtp.client-ip=52.101.201.63
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgzP2fm5EPEPWUUIblx3ptAxSd0xG+yQlRDfkzmAXsfERapXRfJOVd5BiPpzs1u0F9EvY9H4rtYsoC/AZnA0HCRD/a8XC//vS7meSUKTkmZ3R2+wn+Pka3U7NeVEsFZlerduqHXbp3hgrJOcX9p8/kh/fSlCbMhvM1OFvuXlUADIEwBWE6u0DtAJAqX5Zht+LVS5Lh7sxsgWPicSZ/CdVhHMJxAorgY63J3WFZXUcIeVSUR3sbA92lia9D0QA1c8vVw8bdN4aUwba+EKsUxbuT/8jQUoGklNjXEy13ZXuuu8xIZbMAokm/8zBUgyIYqePypXDdeD7F6cdSIBjZps9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHfHdxZk+MVXWWk7ko52f9arL7Br/ObW8JDtjfijL7I=;
 b=LQRrn+qO3LeBYZLnZx8mZBHKDIRjferdK+l6gs788aqJFBPzW2o6ySi96hZSfnAH4CYx0Ks0pviPHRUUDpmLtyO5GQ5W4Cvw8fuffnUizzSwiThl/w4EKsRI2+JqE3RRTX4Pp2Y1+WP5JhGxmaDxNbYVbEKOrxcyDBBqgu0kZIs0LLHnrAUrYGxhSPId6OlYUErX9oJdzAhNSnSRufmOWg6lkMIbugYA2FR5ZBoomX2m8pqHyeH+MZ4sKIlSvbYt8ZquOA24dZ4E2e3S37D5vCI2eMQwMSND11sMekIM9tB79RU3E0g1cYAg5+wcRMKwJHK3at0IFpzirlSyvdqTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHfHdxZk+MVXWWk7ko52f9arL7Br/ObW8JDtjfijL7I=;
 b=u3N6Z+hhRGIaiXwK+4wCc7Ro1JFtY/F2J3LqtF5Kb7hSQP5E+ME92UppxSdLyxDyFFE2KQSn2vsMXT/BDg4JSqXB4PvqejyxtAXApuR3uc41qoukq81Z8Qa1kK04CfA8BxEbWJ6doeykaWv0wk+Ot144EcDbzao+Cv5UUqd7dAHlaaCCKbTEnxW7WUsp6uVsupdqGi89vV4Pn1jOTzz6hr9Dw88vpEUxUxNNEeRLCcbWN5JVYuHaGrvUnTY+UYSiwFdg8uILXKaJU3ONbMsX6PDCvopS+5b30DN/KH60JAEHUrYAZw3TMYe1qSIiL/pdMhti+rtzW+TooybO/X9EDw==
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com (2603:10b6:a03:432::18)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 08:39:23 +0000
Received: from SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775]) by SJ0PR03MB6964.namprd03.prod.outlook.com
 ([fe80::b965:bfa8:58fb:e775%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 08:39:22 +0000
From: "Nazle Asmade, Muhammad Nazim Amirul"
	<muhammad.nazim.amirul.nazle.asmade@altera.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>,
	"maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
	"Jose.Abreu@synopsys.com" <Jose.Abreu@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] net: stmmac: L3/L4 filter fixes and improvements
Thread-Topic: [PATCH 0/4] net: stmmac: L3/L4 filter fixes and improvements
Thread-Index: AQHc8yq14mUowTZ4DUiDhBxAt0o9VrYs0OUAgAFEDIA=
Date: Thu, 4 Jun 2026 08:39:22 +0000
Message-ID: <451fdf23-8feb-44a5-ab11-bfe8a7ed9b88@altera.com>
References:
 <20260603072925.27890-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
 <c56e74c1-fc3a-4d76-a17e-8a7d365d1e70@lunn.ch>
In-Reply-To: <c56e74c1-fc3a-4d76-a17e-8a7d365d1e70@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6964:EE_|PH0PR03MB5941:EE_
x-ms-office365-filtering-correlation-id: 5f7b1d35-2800-434d-4b57-08dec214c70c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|6133799003|3023799007|4143699003|4133799003|18002099003|22082099003|11063799006|56012099006|55112099003;
x-microsoft-antispam-message-info:
 dQjXR6vlESiOj4hHpkXJbFVkCGm/cCZ5Tn7zW246bVUozyTMScdstllXSoRz2ktwXFYiufErnjAo21GeX9c7A3/u2rRpt6ki05RLbBxUDnEaOYq7CLf7an4FmKG19K8zWmFVT1uehyKbzjebOAhg/xhC0Z0TjdlEMEGFPCwGiHF04QxmmRIjkYwNPR8W9MHEcDN1guceUAUl10dav50EFwqFIH6skXJN+ELAVeBSlsxHOUZVRpSX1HLg390FK/YmeHP+CEqsPqAuv7pS/cYnP121lBwHE93TZgrBg/mKqJrGrw/9E9beBj844i4nDZ7wJ2t2MCd85TFgcyRGg7HY/hEorRRCArXLYTXmyQwcaFFsltBx8tEUzaFOQvi6NGIaFoxptYdaQmTgOnyIVPoRnsSLNGbzpqz2MEVc2pSRzaRCWM4iNOCbFTNup1tGAmFQ3KVcf44oB6jTDE8cUVN5uJKtiM1XriQp4smHoyX9RQ5LhW48Kop7RmIgsgF98BxVMIsfuwykerOqfT1lGScC8DMULCLmQWeZUkfBhZOXXJ4hRzDsW5upDAUnZ7KwbItsLuwphxmiuvfXQmZXJ81FQE5IXDqR8xwvAYJQEYe2STJtINcnelnPMjXTIL7sWKvgsOJyrAKxcT2lsV6/Xv6uAFG03VP70IPE3nD9g+ytpcfAJhCr6BW7jR+utCV5Lkl22FzjWvu1GmTGDAGZTURqseVK1BbvS5zAIEQwfxerMB/y/+/w25ukWqWxr1aAIjBI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6964.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(6133799003)(3023799007)(4143699003)(4133799003)(18002099003)(22082099003)(11063799006)(56012099006)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2xaVFBEYTc1ZDl0aDR0a3B0d2d0RzlZeW83VW5jYXBzZ1FUbmhueG50U1NO?=
 =?utf-8?B?V0hHTGFRWHgwN0F1TUZLZjh3bjRjTlhBU1cvTFBpdjZsdUdMYU9wNGFMNVlJ?=
 =?utf-8?B?NDhHcldQV0E0MUgwMHJBdU4zaWpZemJ2YjFJMHRtaE01WS85cDRpUWpndk5u?=
 =?utf-8?B?dWx3SFZqcDZtZWhoQVRabis3Z3NMbUlsVDhRQjk2RUoxSjQ4cHMxdHlONVcx?=
 =?utf-8?B?b0FNZGw4bWVBeENRVWREeHZPdjdDYjZMbDE5amozTXZtcnpHeVkzYXZvTHJR?=
 =?utf-8?B?ZU4weXFOdGMwTGg2TWltZTRQMmdGSXVHVmU1TzNRbFRFUlYwYVlVelR3K1Rz?=
 =?utf-8?B?K0dMM05kSUhuN20vMk95ZW9OZkU0TjIzWS9NV3hYb0VwTWRSUkdhQm9rbVhJ?=
 =?utf-8?B?cHorbFZKTTBiMHJaekdnWENWNDgwQm9oaGQ4VGpIbDEvKzZpZ2t0aHRwTUEw?=
 =?utf-8?B?YkZRcmhQNFE4R0NuQkdYS2Y4SHVvb3RhRk5jRnRjT1JVcFI5bVlVR1Z5UkVL?=
 =?utf-8?B?c05ONWhRTkdiRnlJUUlrazcwZWtNU3p0L1VMYnZVcVQxQXduZFE0QTZac3Z0?=
 =?utf-8?B?ZTcrZE4zd1U3eDJoemRSb2lzUGRXUnR5bTFRd3ZTSU5rMEk4NEh1bTk3Tk9B?=
 =?utf-8?B?aXR3VE85ajFOc3FtVTdWanRvT1Q3UEF1S0tsVEp5enlScndwR2FkRnFZaXNT?=
 =?utf-8?B?aVJtM3J1dWN3eFhBcG5mN2lJUzVkemdRTjQ1cWVlY2MwUGw3MTRUSktyRC8r?=
 =?utf-8?B?aldxbis1eEFLOTBDUFg1bldya3FpN3ZPRm9oWWZ4a2hCYnA5Q0JYN0FERTZK?=
 =?utf-8?B?UE84Sk14TTMvczJBMUhxQ0lOM0drQVVmczJHeGRQbzc0OE5yRjR0YmV1a05S?=
 =?utf-8?B?bkswUnFySFdWSUFLdmNWK0NtWHI4Z3habXdxb1RXNno5NEQrdWhUdnlIWEpj?=
 =?utf-8?B?V0xxKzlwb2hGbG1Md24rcGFPd0xQVWpsL3ZOKzVlUXlsc3pMZHF1ZGVWQllP?=
 =?utf-8?B?TDFoZXdsaktIVERJYmVYMWJLSGZNSnVJUUF2b0d5Vk50Si8zNnlmME1GcWRV?=
 =?utf-8?B?T2taaHJyU0VQaWlFVm03VUJYT0Z4TVdSNXl3clVZaDlYaVpUQTAyKzRiZHQ5?=
 =?utf-8?B?RjJxY1pCRGVjTHczK0NibkI2VWR6bzczcGZwcEFsMmhZRVE4S2ZWM1FRaVVG?=
 =?utf-8?B?OWVNM1N3YXlwbmpuRGgydTRUYkEvYmpCNVpmdXNWN09TV0RKU1lmcURrNDlv?=
 =?utf-8?B?VGVlLzlIWlYxRHY2ZnNIZ0w4Z0paczdhT2JFZjB3Qm1WMXFnRGxDa1FyTnlr?=
 =?utf-8?B?aGx3OVN5ZTFUbjZTZUNYVVI3bmw3c0IvTzA1UnlvSmdTTXFiN0RNazRBYmV6?=
 =?utf-8?B?Sm9ubVY1dVJCVTN6OGh1WmhMSThZQTdVUjFyZkY4MThHTzFDaEtyZmJEY3BK?=
 =?utf-8?B?dTdEazdScjlqb1lDL2ovNFhuK3Z0L2ZNL051dG4wdUVJQjZ3cDJXNmRpZ0Rm?=
 =?utf-8?B?ZFZwWjY1dmM2Y3V0aDd0RldEMXlicURZUVdRVGxIVVR5RDlJZjUwVk9TNVFr?=
 =?utf-8?B?cFAvcXVqN2poQlh1MU55STRUUC9xVkNBZGFBTU5WMlVuVTFlbEZSaml1K3lF?=
 =?utf-8?B?YXJPc1YwMEVoQmtJMXhLbFcrTDQyWnVpRk55ZWVBMTJad2R4RDd4OTNTa3Qz?=
 =?utf-8?B?WC9XWWJEV0VFZjFRM0JHN0xCRzB1eTV0Slcvb20zRm5XSnpuMGx6WWU2R2Iy?=
 =?utf-8?B?c0VqR25NSjZES3NKUGJyQ0g1SU1nYm9PQ2x2WkNFM0hlR0d2RTV5NlEydVRR?=
 =?utf-8?B?MGFkQ0FTV3lkOGJ3VGFaUk1NMEt1amduR2h6QW91VjVPRXdpbWs1Zi9CNlRZ?=
 =?utf-8?B?REdjcWdyVkJ3aHFvOXNkZUFtT2o1ZGxIQlg4UjFYVCtHK0JZMyszc0lYUFkv?=
 =?utf-8?B?akNBbzQ2UWZEUzIrdjZXU3VtVnhZS29rclo5UG9yOG12TGs5Z2pkSkxNQ2Jy?=
 =?utf-8?B?OFZ2Tm1HYkZrT3B2NjRXZFFJUFplcExoZlJaSTdGYlY5amtrQ2NvWDZISWFP?=
 =?utf-8?B?ZG40Q0hHMnVJaVR2a2llUE9NbnNtZUJwMVNlTHMzcWJNTjVycXg0dmlmMHRW?=
 =?utf-8?B?eXp0MXJWTlpKck82Wm5zNmRPRWZRNlZSMmVZcFR0SUp2QUNEazZwYmtkK2Nl?=
 =?utf-8?B?MjE5M2Y0RjJpN2EzVUdmYXBMWXQvUGZXWExYelhVTmovbE1NQ0RiSEpIcTlk?=
 =?utf-8?B?aW5YOHFvek1IbXhzWWFKazVRMG5DNDlCTTVWMHkvV2h1UlNWOUFEcVFxUU5R?=
 =?utf-8?B?L3g2cWZ0T0ZUNHMxSlFJWWsvcUJLQjhXaEpRZTlkazJjeWwzTlR0QTN6bENi?=
 =?utf-8?Q?BXgKkN+zFxgY4gR4K8drqL8DJXF9tp2/CxqUhQqKHBArO?=
x-ms-exchange-antispam-messagedata-1: GxSEcySrobuurw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B2694DADCF6F448A414C3A5A1D91177@namprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7b1d35-2800-434d-4b57-08dec214c70c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 08:39:22.7140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +XGO/pZ/TkOIXHVTlu7yrzCvIuKgFjMwDfNxD3OpXTrX6dowSjfOR3TgON+UOJi+oxifIX4c12XbwCe+ZGz622LgjY801A1HzzCmf0A2+GaJrIVoxdlafBxnr4NDeHtiZNuiOtbqRg959iSNJ7Gnzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295112-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muhammad.nazim.amirul.nazle.asmade@altera.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev,kernel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:mid,altera.com:dkim,altera.com:from_mime,altera.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F9E963E1CD

T24gMy82LzIwMjYgOToxOSBwbSwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IE9uIFdlZCwgSnVuIDAz
LCAyMDI2IGF0IDEyOjI5OjIxQU0gLTA3MDAsIG11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbSB3cm90ZToNCj4+IEZyb206IE5hemltIEFtaXJ1bCA8bXVoYW1tYWQu
bmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tPg0KPj4NCj4+IFRoaXMgc2VyaWVz
IGFkZHJlc3NlcyBzZXZlcmFsIGlzc3VlcyBpbiB0aGUgc3RtbWFjIEwzL0w0IFRDIGZsb3dlciBm
aWx0ZXINCj4+IGltcGxlbWVudGF0aW9uIGZvciB0aGUgWEdNQUMyIGNvcmUuDQo+Pg0KPj4gUGF0
Y2ggMSBmaXhlcyBhIHJlZ2lzdGVyIGNvcnJ1cHRpb24gYnVnIGluIHRoZSBMNCBmaWx0ZXIgcG9y
dCBjb25maWd1cmF0aW9uLg0KPj4gVGhlIFhHTUFDX0w0X0FERFIgcmVnaXN0ZXIgaG9sZHMgYm90
aCBzb3VyY2UgYW5kIGRlc3RpbmF0aW9uIHBvcnQgbWF0Y2gNCj4+IHZhbHVlcyBpbiBhIHNpbmds
ZSByZWdpc3Rlci4gVGhlIG9yaWdpbmFsIGNvZGUgb3ZlcndyaXRlcyB0aGUgZW50aXJlIHJlZ2lz
dGVyDQo+PiB3aGVuIHNldHRpbmcgZWl0aGVyIGZpZWxkLCBzaWxlbnRseSBlcmFzaW5nIHRoZSBv
dGhlci4gVGhpcyBpcyBmaXhlZCBieQ0KPj4gdXNpbmcgYSByZWFkLW1vZGlmeS13cml0ZSBzZXF1
ZW5jZS4NCj4+DQo+PiBQYXRjaCAyIGZpeGVzIHRoZSBiYXNpYyBmbG93IG1hdGNoIHBhcnNlciB0
byBwcm9wZXJseSByZWplY3QgdW5zdXBwb3J0ZWQNCj4+IG9mZmxvYWQgcmVxdWVzdHMgd2l0aCAt
RU9QTk9UU1VQUCBpbnN0ZWFkIG9mIHNpbGVudGx5IGFjY2VwdGluZyB0aGVtLg0KPj4gVW5zdXBw
b3J0ZWQgY2FzZXMgaW5jbHVkZSBwYXJ0aWFsIHByb3RvY29sIG1hc2tzLCBub24tSVB2NCBuZXR3
b3JrIHByb3RvLA0KPj4gYW5kIG5vbi1UQ1AvVURQIHRyYW5zcG9ydCBwcm90by4NCj4+DQo+PiBQ
YXRjaCAzIGZpeGVzIGEgc3RhbGUgYWN0aW9uIGJ1ZyBvbiBmaWx0ZXIgZGVsZXRpb24uIFdoZW4g
YSBmaWx0ZXIgZW50cnkNCj4+IHdpdGggYSBkcm9wIGFjdGlvbiBpcyBkZWxldGVkLCB0aGUgYWN0
aW9uIGZpZWxkIHdhcyBub3QgcmVzZXQsIGNhdXNpbmcNCj4+IGl0IHRvIHBlcnNpc3QgYW5kIHBv
dGVudGlhbGx5IGFmZmVjdCBzdWJzZXF1ZW50IGZpbHRlciBjb25maWd1cmF0aW9ucy4NCj4NCj4g
UGxlYXNlIGJhc2UgdGhlc2Ugb24gbmV0Lg0KPg0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2Rv
Yy9odG1sL2xhdGVzdC9wcm9jZXNzL21haW50YWluZXItbmV0ZGV2Lmh0bWwNCj4NCj4+DQo+PiBQ
YXRjaCA0IGFkZHMgTDMvTDQgZmlsdGVyIG1hdGNoIGNvdW50aW5nIHRvIHRoZSBldGh0b29sIHN0
YXRpc3RpY3MgYnkNCj4+IHJlYWRpbmcgdGhlIEwzRk0gYW5kIEw0Rk0gYml0cyBmcm9tIHRoZSBS
WCBkZXNjcmlwdG9yIHN0YXR1cyB3b3JkIChSREVTMiksDQo+PiBhbGxvd2luZyB1c2VycyB0byBv
YnNlcnZlIGZpbHRlciBoaXQgcmF0ZXMgdmlhIGV0aHRvb2wgLVMuDQo+DQo+IGFuZCB0aGlzIG9u
ZSBvbiBuZXQtbmV4dC4NCj4NCj4gICAgICBBbmRyZXcNCj4NCj4gLS0tDQo+IHB3LWJvdDogY3IN
Cj4NCkhpIEFuZHJldywNCg0KVGhhbmtzIGZvciBhIHF1aWNrIHJlcGx5LCBJIGFscmVhZHkgbW92
ZSBwYXRjaCA0IHRvIG5ldC1uZXh0IGFuZCByZW1haW4NCnRoZSByZXN0IG9uIG5ldCBhcyBwZXIg
cmVxdWVzdGVkLiBUaGFua3MhDQoNCk5vdGU6IEkgbWlzdGFrZW5seSByZXNlbmQgdGhlIHdyb25n
IGNvdmVyIGxldHRlciB3aGljaCB3YXMgZm9yIHByZXZpb3VzDQp2ZXJzaW9uLCBwbGVhc2UgaWdu
b3JlIHRoYXQNCg0KcGF0Y2ggMSB0byAzDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NjA2MDQwODMzNTAuMTcwMS0yLW11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5hc21hZGVAYWx0
ZXJhLmNvbS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDYwNDA4MzM1MC4xNzAx
LTMtbXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFkZUBhbHRlcmEuY29tLw0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNjA0MDgzMzUwLjE3MDEtNC1tdWhhbW1hZC5uYXpp
bS5hbWlydWwubmF6bGUuYXNtYWRlQGFsdGVyYS5jb20vDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjA2MDQwODMzNTAuMTcwMS01LW11aGFtbWFkLm5hemltLmFtaXJ1bC5uYXpsZS5h
c21hZGVAYWx0ZXJhLmNvbS8NCg0KcGF0Y2ggNA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjYwNjA0MDgzMDM3LjI0NDA3LTEtbXVoYW1tYWQubmF6aW0uYW1pcnVsLm5hemxlLmFzbWFk
ZUBhbHRlcmEuY29tLw0K

