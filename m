Return-Path: <netdev+bounces-268593-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFE4IQdLuWnG/QEAu9opvQ
	(envelope-from <netdev+bounces-268593-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:37:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF92A9FCB
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2832C3037177
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8BE35DA40;
	Tue, 17 Mar 2026 12:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="KRAjD2hd"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010019.outbound.protection.outlook.com [52.101.229.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DF3BF680;
	Tue, 17 Mar 2026 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773751013; cv=fail; b=bc8IzzYbz2fmVhMPZH2On4ZDp1jeBQZ+ESLHmI4k9yxSfzAZESIiV2Zk5rEyZ+1dqjRNPTLdI3N3crqe3P9icHVyDoe7IH6Opx4962j2IXXaiAHVFg2yLyOx/yQoo/Z+vUtO8ZmK0KWyYDBJ7OaZhdCDTqmbrLaWyUCtmVVXqAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773751013; c=relaxed/simple;
	bh=OY4TuMMPYsUwlA0Y3IU/0c7OxQbHPqlnN2WQTDn+l0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbTVD8QbUHaRDBeF/hAeC5ZhdhheyVtHRr6CJm96Lyi9dIAnBQqoYjNG/SGd3p9ElA9G3SuVEoGv4hvtdytldX4Vsw6QeriQzHrJfYm4X3xbgAtIER7pZC5YT9K5fO1b4GhMwktdFCPHqCQfTmKGDmSJYlBzYWyIkA/gBd3HJ/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=KRAjD2hd; arc=fail smtp.client-ip=52.101.229.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg2/Q56uTbWQ0xXWdtNWppYbDZ/Pfa/NrbSgrxFh9PZxtUoZFeqUVfD7wyLqBEx73LEug9FJ4YK+KQSt2JKwsFVkpeCo0nUC60a1GdPgQY8YxKSdlX3pI+gix6yxK5+qgiYa46Yb2CZapRXbSCQTQj47MddT1svPTTAQWn4pBl0wAe7aZeu8nF6qcBOuKGN38MN4liYQsgh5aj9SzvaPVndhE/Pj7vYrSxc+XzaaXDcrJp5jZ4DPb7TwO6YKjU8G+XHvpOWdPXE4prcEgfvUrMqxFoq9IZHpt5HaraoubI4jNDFo4ncRL0IClN9fjEumQwi95nfSdf5qEiXlHH0MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OY4TuMMPYsUwlA0Y3IU/0c7OxQbHPqlnN2WQTDn+l0g=;
 b=VmYlikL6Uy39DFGFZkr+W5mBnCOIz+c/U3Zl3XRxhOmR7fN0VEcF/2scQSsdBssgDJgc7YYtIHAHKiACEWHcnT+Tp+MsHyjBYtUl6N1X2eXpfpKgD2RBJf/NvDGSbeddx092C6qKSw8c9k6qbD+PWO6hbruf74k0nTw6kis5vesGdR/xP4690yCkepMVPEqyu2jKZUlyzMY8b+9VX6OL3RslERdJOwgdxq+nKNMnGqSKvIsPyYom0vIG8BfFbpEj8giLrYwgrcCYcL0xDRLDyW80BgtaV7fSyf/+94jNVFdsmv1ns0HeFK6Rw1Qb4nfP5+UQSIUbUyM5p5xBzFuqtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OY4TuMMPYsUwlA0Y3IU/0c7OxQbHPqlnN2WQTDn+l0g=;
 b=KRAjD2hd7zIqFdSL6BWsnpbXSoAkkijpwRoxy3qgQvdHk1ch3SSLCrRnzIaybDeHTF7cLYBBLrEXtQmdeXBCdC+y4ZZhgzKAN+gEQUY16Lxx7Q0wxwMjlE85+VzhUhQqnBAa+9LZm/WzjyL2oZkAKfbREygGMdXtLqqo+qz7/so=
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:38d::6)
 by TY4P301MB1592.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Tue, 17 Mar
 2026 12:36:46 +0000
Received: from TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911]) by TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
 ([fe80::5b4b:dd0c:b302:7911%5]) with mapi id 15.20.9700.024; Tue, 17 Mar 2026
 12:36:42 +0000
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: Michal Piekos <michal.piekos@mmpsystems.pl>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Topic: [PATCH] net: stmmac: skip VLAN restore when VLAN hash ops are
 missing
Thread-Index: AQHcs8dAGKpeXN4mC0mptZ+btcTY7rWyp1dg
Date: Tue, 17 Mar 2026 12:36:42 +0000
Message-ID:
 <TY7P301MB1984C5D71A81DFE5E8EC94D4D341A@TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM>
References: <20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl>
In-Reply-To: <20260314-vlan-restore-error-v1-1-4fc6c3e2115f@mmpsystems.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7P301MB1984:EE_|TY4P301MB1592:EE_
x-ms-office365-filtering-correlation-id: 86f4144d-71fc-4913-af7d-08de8421d827
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 ulV538HaOwr1Y18/0jiA1SQucuPZSA+v4qHHXR4si4h+vdVeYfShntnrKhzKpoR72S+oeAIZ168aYLfb8voWANrNDFoJ6HK+1sGs51u1SgpFH2Ieo3AWNFbcas1YRVDg2DoqXaxjmjqGb3+OizSDtaGhtMoP/PUyITPPj8I6b8X5nCErOE/iy2L0V8xO1eETVaBll0qfLlYbvXB6oL7E50nxYwcv3851mjaJUCgxEQrdOzVYNGj16EqbM3tzVcRy9tGIqMJORy+s/XN5kwG+Ar1ngUBrVNgw37hk0OvaHZZbbdwdD09VPuktIB7SOlz33y+eGYibkuScl1bM2Ttdl/aTkCzeYZDQ0eG0q7GRtX4moitJ7L1hSetx67DiIC6vW2L0/dETp6la4H1S/bhaV0/jvse540c0ee6YzT8G85xGHpUb5QuqUaVT9S/HBWCidZHSgEgNtFx9xcMb23yu8RFq1u9p4uXMli4GNtksCKdtCLvSPRd4uJ/7/sYwMANZ3lkzz5d5eAEGKnPreKxko2JAiDz1QrL8Z9E/kNckbz2wTihMgDvyMyZLh3HqeYu53UCPKwF9X7+8wxclTKnEZECdM5cddBN5WgZdYBf9z5cgiIVFtaV58QH7y9Pg/dW6Dgel584BdV0wiMbqIh3scKCEcQMulbQTV5gQ2/6aNp4ps/ed7zlTfPr1xV4CV6A3NFyC5eT9JuRlEe2MkxNNVYjFm3AQrxOO7OqFU1C2vUns/3gEbvOZ8vq6lYKazYj5AsbWJ9d5X8bgJn/J3oQDXu95jX/XrBJQyJ6tcu3oQkU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1JZbjhvRGk0VlBkVmVXanY5a1dmMkkyMnArdkR6NmlBbnRlWnZjdFlPQzlW?=
 =?utf-8?B?bkttK1loZDNhcjlKUFRYZHRScXJmdnVweXZvb0szYWkrTlViNUNBOU9lMDZz?=
 =?utf-8?B?Q1VCa1IvMzd1N1Zieit6Yk1udTFwQWJOeUh6amt5eEpocFluNStvZnVpT2tZ?=
 =?utf-8?B?N21xSVFLS0tzVUVXL0N1R3JpWmloSUt5c1RqMHMrc2dLeGIxTnZSeS9mOG1O?=
 =?utf-8?B?SkZ1Rnl1MkdPdDdNWG44QlFsbExHYTdpZVQyWVZSa1ViV2tsNGVoVDJBZG4v?=
 =?utf-8?B?N3N0QTBjQWFhNGxzUSsycjB6UUFSWWhWcmVTNXNDLzdsdEZGcVU0Z2I3SHZ5?=
 =?utf-8?B?OUVqTFo5c3oyMzh5YmVFQW1VOXAyR1NFZTBUM3VmcHRYWEhuUVpmQXQvaHBV?=
 =?utf-8?B?TDQ1RDVtVnZCVDYyZkVoSFBYVmwwSmt6T3RTNFNyOFY3Y0Q4SUxGWThRRDNr?=
 =?utf-8?B?aXdRa3NTZmVHWmpSYWdVR3ZNNFJBSFFYSzJqa3h5c2gzZEMrTjZxeldBOGpG?=
 =?utf-8?B?aGpwQ1ExcUJxSUhnR2pWMHlSSWU0ZTl6aWovRGxoVWl4SENsc3dVN1FmbFF6?=
 =?utf-8?B?U1Bmckc2Zjd0STNaOFhTSEhOMTNnNys4c3dJbXJWY3lFT3I5bGkyM3l6Wk53?=
 =?utf-8?B?OVlyMDFXY05TUk5rUUJWNXVIaUNibEUvaHI5RWJ2a3J0WnljYTQveEpiMHF4?=
 =?utf-8?B?aXQ3SmdUc2cxcEtxVEpveUgzSGZHUmg1SkQ5bnlUUTlld1ZTdVhwSk9tcUlU?=
 =?utf-8?B?TndHU2FIY3IyZTNRMm1vbzlESGFVV1U5UW1zV2ROZmZmZXQybjdFb2pCYks3?=
 =?utf-8?B?SEFtaDEvYkxtUGFnaENiNWE3dGlXNkpWWkhTaHFacmUxVTJMZ0ZiMm1jczZP?=
 =?utf-8?B?QllXaWUyUXMwL2lMUzZOSCtEK0w2NUI4L2pYUlloMnRadlpaTmV2Sm5SQWN1?=
 =?utf-8?B?SStZeEZEdWo2Q1dmTjRLa0Q2OUF1ZWl6VlFhdDlQUS9wdXF0czBmc2ZTZ0F5?=
 =?utf-8?B?OHF5d3hqTllEdVMxangwbG5US05peUduYzBBYWRBTVB2SWQveFVTSnBGWHFr?=
 =?utf-8?B?aS9pUFF6NlpxaFZSc0xKVmJTQlJSTEM3MVI3elpLNzY0RkNtdXNVNVhubVNi?=
 =?utf-8?B?Tm56bjc5QnRsdlRQRHA2bWZGQ3VMQnErYkRZdkVQeWZWRHhNQzNMRm1vQVpM?=
 =?utf-8?B?MlZUOGpXUExwOUx1d1dXd214UUJ5YUlTZXpxbEtEMnNMcDFHQ2l5UzlkQnAx?=
 =?utf-8?B?dGhXbHlKTk5CRGhLOEx2R2M2NlZmQ1JhM2JJRVdrOFVFd2hUVXpBOWNUMTk5?=
 =?utf-8?B?KzBpbUlSSEI5YUNHR1VoaHBwU0ZOUktPblBOSVVya3NOeEUvZVVIa2lBTFJs?=
 =?utf-8?B?QjhRWTdvT2RKQ2Fqb1kzRUVEaFRjWHhzZzNuZmNQM0VBdXIzZFpuY1JFQzhV?=
 =?utf-8?B?RW5aUCt2SXUrMWlLeVZxK0o5OE1aT1lQeVQ1d2szaTJmVEs2UFczVVBUVUhG?=
 =?utf-8?B?ZFc0STdJb0NVOHRHNzNHc3I0b01xYkIvZjkyVkNWREphd3NFb1NxK0dQajJi?=
 =?utf-8?B?by9VZUlwbnA1Wk9aeHB4eGFzbWJOVUJIRm8yQ1A2WnZudERiNHRCSS92V0Rr?=
 =?utf-8?B?bU15K3M3ZXhMZnRxSUtBUXpzM2Q1MkhPazN6Rkc3dEkvY0pCeGxkWENQZE5t?=
 =?utf-8?B?ZTh3eEV6Wmh0ZWh2dDBPTmd3YVY1WjFYRUVoWlUyQXA4aTJZTVExTndzMUJy?=
 =?utf-8?B?b0lIV3hONXV0ckllRVVMY1lGYlY1ZGNiMnh2WEVQTS9QWUYyVDMzNlMvRVBs?=
 =?utf-8?B?UVNzc0hTQW1uMUtveFZXdkRoZmlpUnA1MmxidDhwR0ZHZ3cvR3JCZ2lsanZZ?=
 =?utf-8?B?ckMwTXRsS1drRDNyK01CRWgwbkhTYnNZSkJoSHFMaVBzaERwbVJQOFQxdURQ?=
 =?utf-8?B?NFp0SEdtaHlJVlVFTTRkdXM0Q3NSVStlNzlRdlVwSk5iWStTQXFqUnN2S2J3?=
 =?utf-8?B?cWxSZEFIZG5xdWJob0d5V0ZXZFZGOUU3VmNJcjNBLzUvYnVYN29MaVlIN2F2?=
 =?utf-8?B?dUdua2pGRFZCKzVnZTJrL2hrbTlGbXhqcWF6enUyejJJM3BHbFdVbkVSNTJO?=
 =?utf-8?B?WEc5LzR0RndUeVlMMmpjSnlxVmh2cGRKWjlSS1lRU2ZnVjhra3pacFd5Z0dT?=
 =?utf-8?B?bnF5bTZNMjhCN3dmamNQOGxRbmNRNnZiV0IrWjlyZWlHZWJPanFwcFFNMFpN?=
 =?utf-8?B?ejVrSHBjVGdnWnljMDBuV1hEWVJhWWFKTlZsYTZLYlI1OHhrYlJjVnkvK3lh?=
 =?utf-8?B?RGRPOHE1ZzlTSzBrd0Q3dFRiSkVtbnJDc1BIUDJVU3h5MTFRZ3NRYjVRUHF1?=
 =?utf-8?Q?MWrw/YYl6FwRx5oI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f4144d-71fc-4913-af7d-08de8421d827
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 12:36:42.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETnjXpCh6rFcv6kR9YSQS4Y2T/HFrz+bE+VZPgyp0ZSbJoI0YVvn9Qk5VlKKLgc8tEwwS4ZtgwjoeYBmVHlUxndtjb9C6hFwFI64xs3PbFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P301MB1592
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-268593-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[mmpsystems.pl,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ovidiu.panait.rb@renesas.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,TY7P301MB1984.JPNP301.PROD.OUTLOOK.COM:mid,renesas.com:dkim,mmpsystems.pl:email]
X-Rspamd-Queue-Id: E4AF92A9FCB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgTWljaGFsLA0KDQo+IHN0bW1hY192bGFuX3Jlc3RvcmUoKSB1bmNvbmRpdGlvbmFsbHkgY2Fs
bHMgc3RtbWFjX3ZsYW5fdXBkYXRlKCkgd2hlbg0KPiBORVRJRl9GX1ZMQU5fRkVBVFVSRVMgaXMg
c2V0LiBPbiBwbGF0Zm9ybXMgd2hlcmUgcHJpdi0+aHctPnZsYW4gKG9yDQo+IC0+dXBkYXRlX3Zs
YW5faGFzaCkgaXMgbm90IHByb3ZpZGVkLCBzdG1tYWNfdXBkYXRlX3ZsYW5faGFzaCgpIHJldHVy
bnMNCj4gLUVJTlZBTCB2aWEgc3RtbWFjX2RvX3ZvaWRfY2FsbGJhY2soKSwgcmVzdWx0aW5nIGlu
IGEgc3B1cmlvdXMNCj4gIkZhaWxlZCB0byByZXN0b3JlIFZMQU5zIiBlcnJvciBldmVuIHdoZW4g
bm8gVkxBTiBmaWx0ZXJpbmcgaXMgaW4gdXNlLg0KPiANCj4gQ2hlY2sgcHJlc2VuY2Ugb2YgVkxB
TiBoYXNoIG9wcyBiZWZvcmUgc3RtbWFjX3ZsYW5fdXBkYXRlKCkuDQo+IA0KPiBGaXhlczogYmQ3
YWQ1MTI1M2E3ICgibmV0OiBzdG1tYWM6IEZpeCBWTEFOIEhXIHN0YXRlIHJlc3RvcmUiKQ0KPiBT
aWduZWQtb2ZmLWJ5OiBNaWNoYWwgUGlla29zIDxtaWNoYWwucGlla29zQG1tcHN5c3RlbXMucGw+
DQo+IC0tLQ0KPiBUaGlzIHBhdGNoIGZpeGVzIGEgbm9pc3kgIkZhaWxlZCB0byByZXN0b3JlIFZM
QU5zIiBtZXNzYWdlIG9uIHBsYXRmb3Jtcw0KPiB3aGVyZSBzdG1tYWMgVkxBTiBoYXNoIG9wcyBh
cmUgbm90IGltcGxlbWVudGVkLg0KPiBzdG1tYWNfdmxhbl9yZXN0b3JlKCkgY2FsbHMgc3RtbWFj
X3ZsYW5fdXBkYXRlKCkgd2l0aG91dCBjaGVja2luZyBmb3INCj4gVkxBTiBoYXNoIG9wcyBwcmVz
ZW5jZSB3aGljaCByZXN1bHRzIGluIC1FSU5WQUwuDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZXRo
ZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvc3RtaWNyby9zdG1tYWMvc3RtbWFjX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L3N0bWljcm8vc3RtbWFjL3N0bW1hY19tYWluLmMNCj4gaW5kZXggNjgyN2M5OWJkZThjLi5i
YzA5NDM5ZWMwMGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L3N0bWljcm8v
c3RtbWFjL3N0bW1hY19tYWluLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNy
by9zdG1tYWMvc3RtbWFjX21haW4uYw0KPiBAQCAtNjg2OSw2ICs2ODY5LDkgQEAgc3RhdGljIGlu
dCBzdG1tYWNfdmxhbl9yZXN0b3JlKHN0cnVjdCBzdG1tYWNfcHJpdg0KPiAqcHJpdikNCj4gICAg
ICAgICBpZiAocHJpdi0+aHctPm51bV92bGFuKQ0KPiAgICAgICAgICAgICAgICAgc3RtbWFjX3Jl
c3RvcmVfaHdfdmxhbl9yeF9mbHRyKHByaXYsIHByaXYtPmRldiwgcHJpdi0+aHcpOw0KPiANCj4g
KyAgICAgICBpZiAoIXByaXYtPmh3LT52bGFuIHx8ICFwcml2LT5ody0+dmxhbi0+dXBkYXRlX3Zs
YW5faGFzaCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQoNClRoZSBzdG1tYWNf
cmVzdG9yZV9od192bGFuX3J4X2ZsdHIoKSBjYWxsIGFib3ZlIGFsc28gZ29lcyB0aHJvdWdoIHRo
ZQ0KcHJpdi0+aHctPnZsYW4gcG9pbnRlciwgc28gbWF5YmUgZm9yIGNvbnNpc3RlbmN5LCB0aGUg
Y2hlY2sgZm9yIGVtcHR5DQpWTEFOIG9wcyBzaG91bGQgYmUgbWFkZSBhdCB0aGUgdG9wIG9mIHRo
ZSBmdW5jdGlvbi4NCg0KQW5vdGhlciBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byByZXBsYWNlIHRo
ZSBORVRJRl9GX1ZMQU5fRkVBVFVSRVMgY2hlY2sNCmF0IHRoZSB0b3Agb2Ygc3RtbWFjX3ZsYW5f
dXBkYXRlKCkgZnVuY3Rpb24gdG8gY2hlY2sgaWYgVkxBTiBIVyBmaWx0ZXJpbmcNCmlzIHN1cHBv
cnRlZCBpbnN0ZWFkIChORVRJRl9GX0hXX1ZMQU5fQ1RBR19GSUxURVIgYW5kDQpORVRJRl9GX0hX
X1ZMQU5fU1RBR19GSUxURVIpLg0KDQpUaGUgcmVzdG9yZSBvbmx5IGRlYWxzIHdpdGggdGhlIEhX
IGZpbHRlcnMgYW55d2F5IGFuZCB0aGUgdmxhbiBvcHMgYXJlDQphbHdheXMgZGVmaW5lZCBpbiB0
aGF0IGNhc2UgKHN0bW1hY192bGFuX3J4X2FkZF92aWQoKSBhbmQNCnN0bW1hY192bGFuX3J4X2tp
bGxfdmlkKCkgcmVseSBvbiB0aGlzIGJlaW5nIHRydWUgYXMgd2VsbCwgYXMgdGhleSBhbHNvDQpj
YWxsIHN0bW1hY192bGFuX3VwZGF0ZSgpIHVuY29uZGl0aW9uYWxseSkuDQoNCk92aWRpdQ0KDQo+
ICAgICAgICAgcmV0ID0gc3RtbWFjX3ZsYW5fdXBkYXRlKHByaXYsIHByaXYtPm51bV9kb3VibGVf
dmxhbnMpOw0KPiAgICAgICAgIGlmIChyZXQpDQo+ICAgICAgICAgICAgICAgICBuZXRkZXZfZXJy
KHByaXYtPmRldiwgIkZhaWxlZCB0byByZXN0b3JlIFZMQU5zXG4iKTsNCj4gDQo+IC0tLQ0KPiBi
YXNlLWNvbW1pdDogMWM5OTgyYjQ5NjEzMzRjMWVkYjA3NDVhMDRjYWJkMzRiYzJkZTY3NQ0KPiBj
aGFuZ2UtaWQ6IDIwMjYwMzE0LXZsYW4tcmVzdG9yZS1lcnJvci1mOGIzYTFjN2Y1MGENCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTWljaGFsIFBpZWtvcyA8bWljaGFsLnBpZWtvc0BtbXBz
eXN0ZW1zLnBsPg0KDQo=

