Return-Path: <netdev+bounces-260298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG9ZMv4CnWkuMgQAu9opvQ
	(envelope-from <netdev+bounces-260298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:46:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DE180AD1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 02:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64AF330379DC
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E49E23A99F;
	Tue, 24 Feb 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="LziIS6Uz"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA181A262A
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897590; cv=fail; b=VXqQFm6vBL7sXBeR/5pjjud0ypL+ZLHa4C4YvSBZGZQhkxODQjI4F7NEwhaGKeM3NDJEpEkOLQoKCOatzaApJTUY/n/y5QbwLUG9O1X1h8y8ffa91DkvtaiBgu4MrtJ1j+iN4BIAmUgWWzewYX6NDQxdhZcpNMPKw0exgV6tIvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897590; c=relaxed/simple;
	bh=+oMRUarpHNmcLF6PtH/hWy6AeRVIvE9xj0k94L0jfqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bsdbKB5D3KEyR+lApnph//mQ4/gNALq9qmsX3X/k9IFhoeiAYl1HiWjCv0MGFoI0B1yUMiAO2ju2oe4wxI70JJuAwvUj3QW9FSh95l4dN7dhmTYTx8EHjb48+8Fxbdik7UuQFDa7CvyfqIm8xDZpFKFSy2KooCygx11iC2IRp40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=LziIS6Uz; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwv19hqk8T0GBSIEPtZxaMSfzJbzJke//paPn7DX175tCHTK9s42ibJgyn6/f3fSluFwr5tZYvU5+z6ezpiV2QUKPtho6w5MIgwaEvtzNf17vLOPvIwkkDtIMpQZwMwdthPfJ48fKIwQ1uUnYbCAXLaTXSH8taXPSsmpG8ztZeuCbU6m8OWSDXEsVdo7RTgmc5R48EViI0v5wU8PmMkLXkbOOG6rJyMOHxLOwwpGwsaMFwhzemZ5Hp+big5Q94cll7brbk7Y6+vyOTptmxir0np/XA+StbrWkPY6ygcR7+WwhYIZxTpxMd68cbmQi8KmJLSocUaZwdXgmJ8IqmsH/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxRxTzOV6Qpxx23KKC867/axgbmjlqZfNlf7qwBMM74=;
 b=RPJGd319qI9bG8QhaxXdnIwIcLOehpN1aJvASnzPDf9FwBGOQETGfDsgI9W4hDgZyBc+GoyLhKZnboDZUxR624j4LnjHMSSazK0Oh39Q1zGiw4VV+yFFNhrmrLYM+MN7CNpRqidKsptbo/AOEL2An3Wh5Nz4e0QsszeUi7fbrwcWHTfv918drI/j+dCPb780Ks2IOcYs2frowGw8QZH1Q1zsmm/lXyQdYIQLDHY4QZ8scZ82II9qGuQx1cYNCcNH82UxZSfoBHyhPWpRXpFQJYLE8W+1/De1FbbuwlyTl+vaMBlRD9sn8/dNQULMVoqtZDNGTRBHs3uSSGYVqVfW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxRxTzOV6Qpxx23KKC867/axgbmjlqZfNlf7qwBMM74=;
 b=LziIS6UzjEzvAHr4ZG6YNI0lnovTY7h5vHtO66PTdq9uz/1guROMl34ILUvdDbdEhq6Igf3O/1QwAKugbn7XihdHEONGIxlDI2IIUSKR+dTfrXXzufu8tOoXnvQ4RVACasRLvJpR+YYT+zryIEaiHR6MSSVkRN2jxWT/f5sjf8z+511DtBWIObhwHSS9mJDQdUQ6wJ8G7JxaOwy40yhuI541tUVp9Cada7OmvOI0ePstcff+l7iFPZsVpH22dVq7AQ2LIO9PgeHuTQsIWVX8l5yzOksxziSGc7PfQx9aMMYhkE7eDZbnvbCY26dXK4SKOtd/fjgjwHxEcK/o4PVidw==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 PA2P189MB2635.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:40a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Tue, 24 Feb 2026 01:46:26 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%5]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 01:46:26 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Simon Horman <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jmaloy@redhat.com" <jmaloy@redhat.com>
Subject: RE: [PATCH net] tipc: fix duplicate publication key in
 tipc_service_insert_publ()
Thread-Topic: [PATCH net] tipc: fix duplicate publication key in
 tipc_service_insert_publ()
Thread-Index: AQHcoiaa1FZXXZJSSUepJ+xjmWZjc7WQjl6AgACLU7A=
Date: Tue, 24 Feb 2026 01:46:26 +0000
Message-ID:
 <GV1P189MB1988F5D0A73D769C8C2CB3A4C674A@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References: <20260220050541.237962-1-tung.quang.nguyen@est.tech>
 <aZyNa__aB_RUozjJ@horms.kernel.org>
In-Reply-To: <aZyNa__aB_RUozjJ@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|PA2P189MB2635:EE_
x-ms-office365-filtering-correlation-id: 0b39ef33-6c61-4d80-f7ed-08de734685b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pHUKyVjCS4kSySvTsFQWxHkiVUxDNYsQnci/8/G5OeJLZuRJ4T3Vu2+J981C?=
 =?us-ascii?Q?sF/ALPaAZ8jLMPBGaAaeHwBSwp4jjhc2Q0JJZ1tupJb0hTtSTSHC1FQyGCGm?=
 =?us-ascii?Q?Am63CfGifodqPaoUhxRs6RrKR9nzoSlB6/0o/ck5Y9zRZXs8Ihww9nw7DCSI?=
 =?us-ascii?Q?8WQKkiI8KG8IGnkpGkCfAhyHe18peY/rOj4qatkDaLXhsaPqfNB8UeDhonC2?=
 =?us-ascii?Q?5DktqXHl0ujb2qT7t+YNGkdts6MMqhLhPIFU9h7vXkdSf/RikpWoajnrRR5V?=
 =?us-ascii?Q?8ZeKiVE15QQD5uC7OUz2VDJL0nadeRjHVk4Od3RvjX5jiIj8gPSMSVvsZL9v?=
 =?us-ascii?Q?3F+WWpPoPljUss/Q/1ToueAv1Ffn4Wiq2tA0J6Iw9NXNhqmU+xYr6aPkSIE+?=
 =?us-ascii?Q?Z4+gtVOTAUluXwBptBFTH+XVSQXwOKsXk3E9cYagdBCo+D5BjpQJppDid0ZB?=
 =?us-ascii?Q?uILTddiEdCmnxQFMtpOmPfRWS0eDgeC4nZTQjj2GQ5sS4fb6SDptI0bBg37E?=
 =?us-ascii?Q?Iu4+IU95qahA8h3MiWr+d91/YZbOMhbwrbjAnrk89e9G8YO+15KyW3AsE5nK?=
 =?us-ascii?Q?otv1u+dCBT+rbKWj3GxMwto9VnY1xMTphfmdmATHPxlUlYj5i2YlOx7bplxD?=
 =?us-ascii?Q?1AJDEhW7jjelzPpQqPbBSHbR34DyAZPB7fdWcSQ4mNxbB7GiJyi9Q4uHsSwr?=
 =?us-ascii?Q?i8G0HWSH51EzqY/ATEsAg5O4Ds/qgkRH3SR+kgn7tVxfuuF9Nfu20FI9Q97o?=
 =?us-ascii?Q?mmJO4vkHgSnAzKy/pHA4jotB/RTZyEXBpDsNmufp2LnpgqOsS5xWNoXmucum?=
 =?us-ascii?Q?gySp+rRwF7AY1fggaL2HL7qYNgvOfEeZk8l4fb5/cPf/ZHzCe6BS/llKDKuN?=
 =?us-ascii?Q?+pZmrfhEC2qHVirrWYypVliBBEVzLu9/URYc4CY9G8Itmayej4EzSe/fLalv?=
 =?us-ascii?Q?7CkZYIcoGM42bTf9JMzZItGeLAGtK4hPAh4tOAAmCr7a+kRhbtnXPRzQBc7o?=
 =?us-ascii?Q?OJ+2rgOj1Xa7Jr2RCgsLJmtat14Tn8PKCrYExYj6bgbqKo1w9qBOAJj234rt?=
 =?us-ascii?Q?OfXQfxsYgx+AE18WdD9Tpczvo8sKc96BcFZIcNqvby+EtiaGTYY2p2L38tGu?=
 =?us-ascii?Q?EO1X0DvIVA5T63a3sKakCbutIp3NLfrzN99yJHDTn/5BLeZ5wvQ+xU8loYon?=
 =?us-ascii?Q?ZC/IAVPXbJUYnrxYY4Uw8Ncrs+/FPIbgQr55eDWEXaqmAKtasLtPDlkDMWTv?=
 =?us-ascii?Q?j5YBm+r7JYF6YOCaRQ2HSIopmxh6EqOo6pnlAzHBSEAQ9hDjdawACH5spEFi?=
 =?us-ascii?Q?6b4ewmiV8N3tV6JB44A+eVXYZutBJ0CHPEZ1+5mqTy3eU1qpykw40KCG4XWE?=
 =?us-ascii?Q?BYzqDLJ0CHT3U7K8EoqYYeHAExXFwAk4uEpA5O6pI3VvAbZS5cTtlCU1slqr?=
 =?us-ascii?Q?eEbIpaKFB0lKdcVHTuUHGw68P+1TNLgA6nDry95AG1Xw7jXHN0dSPPFYZMsB?=
 =?us-ascii?Q?X8h//Qs7sHhM3DNM0dNS7lieikqJyGDOR0xdGdK4jvLzXxrup7XECsE7AOUI?=
 =?us-ascii?Q?xl3F3Izw4XoMK6vT1J5vrYwEbkaG40kWclYA2mP7Mhj6SsWjrE4dzMD1m5Sl?=
 =?us-ascii?Q?F+s6Ag+IYRVrN9sICfHZHfI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qPmYKC8XZzg8IbJi8tAsZ6IbfyYYTim7HnnmN7CNmRzKTJxTkjygoy/Yomi5?=
 =?us-ascii?Q?bgOlYvrW1Xy+PDHJLc6bn3BrG7lgkkUJExt5Xuqy106RlBE74VdByrehMVcQ?=
 =?us-ascii?Q?DZeWTNVlsfylhfDteXYf39FY9iaOkXynyR7zba8AVzJq9kH6NftaOlYU2Hot?=
 =?us-ascii?Q?+s6/1Pr53+D+gThVH7ONXme+eygKmtj8zRI0ZOl4Y5KXAD5TO5OBU9/Xhm6B?=
 =?us-ascii?Q?rcYGwIhzK/HO0lhumHJI5kmQ7v9DxoEAAP6AedojFFIa/eufP5dbgYRk+fyd?=
 =?us-ascii?Q?RDtV4y1fHHj1B0q0CJx6SNBRVwjJkNq9nsIXM/BdiBdpqJJRc6PxoMp7D6JE?=
 =?us-ascii?Q?WcV2BkqLeCTdepjOiFjLduDqGTiQXLyybNaJiznE8kaYKXU/itSnHcBDsLNU?=
 =?us-ascii?Q?bAcym66q/IFA0R6uWFam8+taznmSWHhQvBPzUPwWU/dP6lKsrnCze0ys2t6v?=
 =?us-ascii?Q?c1ady/gdsSRz8nHp6S0pdc8lVTj1iyTU3GzsegMnBSNK4pm18e+6BRzkhIE5?=
 =?us-ascii?Q?A9kunFOO1YtvHkdPlR7T62RbKZ/Bb69jTPYnbo/iksYAM/J4uja6AgO04wR+?=
 =?us-ascii?Q?MK/liChQaFnv1ag3P3I12Plj2WmUyLxfafD0JuNRRTJ7MrWSuvvONrs1Wypn?=
 =?us-ascii?Q?sOpMFBRTq9B0RNu7ybta+HsdZZKNq2JREpjuiAB6w03wcufwj8P8wzhlIhso?=
 =?us-ascii?Q?K59WkTFTfao3XilJhinaCRZ/ymG/X+zovCE5Iw8l6173rlUoFg3fyooxao+K?=
 =?us-ascii?Q?viFfzYVj1TigpJXXDGmSv5as1pBe6hW9tihrvXHeXsrZ0astyLpqrwXBCsVH?=
 =?us-ascii?Q?lm8UofpQk00TCTudp3HlXrV563L27vLFktyudmeco9OKbe/iBVzW1Cg9Dhd4?=
 =?us-ascii?Q?kjFcbfW7U3K4tVGMkOTofEnqA53xZxduueqfyPsA1t4crHAOpSgSNmu3Un9x?=
 =?us-ascii?Q?TLLB3fXeqe7zu9TTEGwhedrc0asbWAyIy7tgSvUUb56HYuAN4pypZLh9Rdi9?=
 =?us-ascii?Q?bB6QBgKYTp1AS/EomHZyRuVBeQlMkPP9uAfDjn/w1D1awK1Mpoa5WGW7D171?=
 =?us-ascii?Q?hb6BMxGk/fjbg5VlCksytH6LrWNOWWt3XIPi0bYQ32/0nofcOQGqZxWdVuF/?=
 =?us-ascii?Q?JUXriAZlLFczzCVj0X16ZNf10l0Hm9clGSpPzn5P8I6amM5hisr7jKndcSp5?=
 =?us-ascii?Q?LYv+YPMoagZqkO+DwP9jzQPIOgHclcWd5hH8oSTo7hQCWnnrHVgNCNN9ITVG?=
 =?us-ascii?Q?t42n34kqktRPczXIVfNG83xuOd67pTwodncH7XJdF8MpKM/DxY2/Ka7WkTlw?=
 =?us-ascii?Q?H/zDXA4GFNfvSAUPGWjn2C8ot88h30QSR7/0nZsXFnLcnZrHvxcnMR1HZUH1?=
 =?us-ascii?Q?sjPOpJEwIRC4jqVX8bUgq1m1RqxPqC4t88hXj27tyOjuIHW/JPOFWEjocC1m?=
 =?us-ascii?Q?aT0tPbPrSZxqndIKMJ/wvJ/gnYTMzKF0/JFOMH8bJrYRhAC8jfWNX+/qAfGc?=
 =?us-ascii?Q?bs4obb1j1u7y492GT3vo5E4ikJSTwcakgEtLzuMNkzswLWYlMOQEoj6IrVTM?=
 =?us-ascii?Q?oKXGnDmyGOuLpJsZm93oLnsuLjzeQ8Z7ZQFEVLP2VL56kQVd9uMmLfjsrOAq?=
 =?us-ascii?Q?WWDsGS6jaRtcCvWW6TgOzFCAiZDRfSD/ubr0dNW5x+StchokQYySSPQJUed8?=
 =?us-ascii?Q?COYFnXJu/6xJICUGkvw+KNOvQd6vrEsYwkxorjJnjAdkasZxf7TRjQPKBcc4?=
 =?us-ascii?Q?S2dtJIoWWg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b39ef33-6c61-4d80-f7ed-08de734685b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 01:46:26.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tAQUaAFeWbENNUK/pv5ibC4x255trmSVYmin8QxSDcTlihcRe1y6GXgrRceu7QWb4EIpP4kwmlp4Dn+eckGTg76EeyVqd2nW1zoQjZjOYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P189MB2635
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[est.tech:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260298-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[est.tech];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[est.tech:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tung.quang.nguyen@est.tech,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,est.tech:email,est.tech:dkim]
X-Rspamd-Queue-Id: 703DE180AD1
X-Rspamd-Action: no action

>On Fri, Feb 20, 2026 at 05:05:41AM +0000, Tung Nguyen wrote:
>> TIPC uses named table to store TIPC services represented by type and
>> instance. Each time an application calls TIPC API bind() to bind a
>> type/instance to a socket, an entry is created and inserted into the
>> named table. It looks like this:
>>
>> named table:
>> key1, entry1 (type, instance ...)
>> key2, entry2 (type, instance ...)
>>
>> In the above table, each entry represents a route for sending data
>> from one socket to the other. For all publications originated from the
>> same node, the key is UNIQUE to identify each entry.
>> It is calculated by this formula:
>> key =3D socket portid + number of bindings + 1 (1)
>>
>> where:
>>  - socket portid: unique and calculated by using linux kernel function
>>                   get_random_u32_below(). So, the value is randomized.
>>  - number of bindings: the number of times a type/instance pair is bound
>>                        to a socket. This number is linearly increased,
>>                        starting from 0.
>>
>> While the socket portid is unique and randomized by linux kernel, the
>> linear increment of "number of bindings" in formula (1) makes "key"
>> not unique anymore. For example:
>> - Socket 1 is created with its associated port number 20062001. Type
>> 1000, instance 1 is bound to socket 1:
>> key1: 20062001 + 0 + 1 =3D 20062002
>>
>> Then, bind() is called a second time on Socket 1 to by the same type
>> 1000, instance 1:
>> key2: 20062001 + 1 + 1 =3D 20062003
>>
>> Named table:
>> key1 (20062002), entry1 (1000, 1 ...)
>> key2 (20062003), entry2 (1000, 1 ...)
>>
>> - Socket 2 is created with its associated port number 20062002. Type
>> 1000, instance 1 is bound to socket 2:
>> key3: 20062002 + 0 + 1 =3D 20062003
>>
>> TIPC looks up the named table and finds out that key2 with the same
>> value already exists and rejects the insertion into the named table.
>> This leads to failure of bind() call from application on Socket 2 with
>> error message EINVAL "Invalid argument".
>>
>> This commit fixes this issue by adding more port id checking to make
>> sure that the key is unique to publications originated from the same
>> port id and node.
>>
>> Fixes: 218527fe27ad ("tipc: replace name table service range array
>> with rb tree")
>> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
>
>
>Thanks.
>
>My understanding is that ->ref functions as the portid.
That's right. In function tipc_sk_publish():
tipc_sk_publish()
{
...
skaddr.ref =3D tsk->portid;
...
}
ref is set to portid.
>And if so, this makes sense to me.
>
>Reviewed-by: Simon Horman <horms@kernel.org>

