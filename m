Return-Path: <netdev+bounces-298443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id if5/LTdxK2rE9gMAu9opvQ
	(envelope-from <netdev+bounces-298443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:38:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD406764E8
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 04:38:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SHT0DpuF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298443-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298443-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EB630F79F5
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 02:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB88C37B00E;
	Fri, 12 Jun 2026 02:38:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C521219FC
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:38:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231900; cv=fail; b=JqwKMhBw0QI+UIgimu33hfvjYIUDLX+lm6FwnfLT2NQTRDmAAPJNz3NrE1gmX4/+RkIH153kRsC41EHXQfQvuSGg7Xz5YJrL7QEvtNRI4LgGzitlYJIvTOqPPjOyZoNSvYJYyR5OQolQY/qw5GDPWAmZkhehyIN4/aNP49yLoXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231900; c=relaxed/simple;
	bh=287vzPWnHfXoXXHNx4sglYb2M4s/pikRT86ieOxqcCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jtkEpxnRBdk5zN6cwOJEahnOIahcf60cT7nmRQnQf9VhOBdmhL44CrFOEL/JnxsyzRFvnEBvsgUP1ZlQtV4aHrsJZZGce58CuRp0GWmNQWWwSovx0O2zDuQMAtwNt/r9KbCxsCL1xgIbrzgd/g+MN++y7ah1Es3tY5ZvKtce5PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SHT0DpuF; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkXJQXtjpuvF2T8RXiB6OCCrvyGWTTX4gfn0dIjb6CHUnoqI0tdxWd/7i0ifmxglLYeZtqfAWieSUw1FfnEh44EQJ0/niMAW63rChv/SfUuACN2ayjEalM1kUD11aLzj5FdIaaI6HCCHrTGtZFoRVYDCm1rqWsJsjXUFtLK85Va6ehDW5kNs7mtUCBnhbGeQEzDp3CnRLHIMFxKi0kSYVkH2Xmhn2f7GYX20p5s9C47/AN42lGqeZhhTZJAHYaSo3gpJ3+LRxhIS3rca+8SVNJ5/cG6Zzpm2kI9PYZ/s4e52Qr3IvQU8Xcm74RiGO+LAsVkc6o3qdYLopOw90HXAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=287vzPWnHfXoXXHNx4sglYb2M4s/pikRT86ieOxqcCw=;
 b=UmsWgwmGV5fPWkPdu61/AZExEo3x1/eBHSH4LGj5kyXP8mcYIHCcRiaRBT9zhow8w5aUfcGcHocpU3TuZ1zgMOW8E6SuSIQ+2fwLUMMvcNWsEXhBs/AzUuBeM21eBg2E1rWughMzq1TBqhjd50AbnYCRh4+dRtOvaCW+z5AuCQVHLGOyQV1axhBBUUO6A6E5gAIbq5T5epCuNEqTq+6oAyTqMMVDR0pVtB+IAH+56IhmafzXHs8YpKbEUMyIGq8WKkckGskBSDntQXvvOTOSbpyL3basbWKdjA93HdNHOsWHOivh281sRLJ6ea7dsyGu6H71vT8V+h77kCrPAIfBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=287vzPWnHfXoXXHNx4sglYb2M4s/pikRT86ieOxqcCw=;
 b=SHT0DpuF/kqpYB+9cWmQQlCSNbGG04fJXY3K5yUpWQIDBVLtiUpegNQ5lkiNKHHhqHVtYdHzh2FTIDAs0fC3OA6KP+zuLS4g1hcF/oRVbM1tc4AGlqsvYm9pzxy3m+0MPO0GSohDbwCJgXO+c1WOUc2rcwBlFJR/ptzNFDwd0swFinTkVh8a5Xxuic6Q0wsVwrBn6kNdYtjG08oxWa1ppl78ZqfOmcS3/yhdcYTE2RoLOfUeGh+Fa+yIbH0KpeJwDAjs+rkVs4aOCq2tuK1EBnBau//FhU5Fg57sFWe0rerxi//2gS48hV0R0JkTkH9XA1fjws5jsLfk8piMUsmEng==
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com (2603:10a6:10:2dc::6)
 by GVXPR04MB12343.eurprd04.prod.outlook.com (2603:10a6:150:2c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Fri, 12 Jun
 2026 02:38:15 +0000
Received: from DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47]) by DU2PR04MB8629.eurprd04.prod.outlook.com
 ([fe80::9d04:7526:a901:fe47%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:38:15 +0000
From: "Wei Fang (OSS)" <wei.fang@oss.nxp.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "Frank.Li@kernel.org" <Frank.Li@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, network dev <netdev@vger.kernel.org>
Subject: RE: [PATCH v5 net-next 7/9] net: dsa: netc: add VLAN filter table and
 egress treatment management
Thread-Topic: [PATCH v5 net-next 7/9] net: dsa: netc: add VLAN filter table
 and egress treatment management
Thread-Index: AQHc+UfFrfHD77UPxEmcUFJ2rp6A0LY6L3uAgAAG/BA=
Date: Fri, 12 Jun 2026 02:38:14 +0000
Message-ID:
 <DU2PR04MB862940916AFE77DB0CA86C5488182@DU2PR04MB8629.eurprd04.prod.outlook.com>
References: <20260611021458.2629145-8-wei.fang@oss.nxp.com>
 <20260612021314.7C1001F000E9@smtp.kernel.org>
In-Reply-To: <20260612021314.7C1001F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8629:EE_|GVXPR04MB12343:EE_
x-ms-office365-filtering-correlation-id: b3d7c77e-1fda-4fb3-b686-08dec82ba759
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|19092799006|23010399003|38070700021|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info:
 JtfOTiOzUObAb8dax1oduKIAZq3rsgtEOXLfvFGvvV9dkfFY9zAsR2BvJQWZXeCQiuplPkCVvRR1Ntj8r1Skvdt54LiwYV+gvR0fmZPtFyN0Ilc9FezW17gPLZqgxOgDvsUc5xiEAfHco67mhZakz2sL0wa7umHFBazUnKFnt7mvj3JEuVC6LQNQBLg3TyTzIcqP9wOjikks8IFrbvrvAGWHLFMsnOWsFv6BKJu0KPl1jqhUKz99tWZuV8qewYq+oSRPCDPV9Pif6bqe18K/H0bo4Yb+699n3tYLjO9b0JF3XUubOMujfk+Q/J3E/GeyN/UEWj24JQRzHwY2ybHYFg1vcao0RT8+0YIFEGUjos4yIZrfVOPsrxa+uDeko3oRNXUkRcVh2WMwMynZSU4zL+qTg3PWOpI64iWWAb3Lpyq/Ws+d32FfEemwLWobIbSrzgu1jEOpbIr0kiwT/xmbOcyIpxwLk/kB/dtiyCIxsVhcRrwLCUdww6bEqrUwzI5GYXCSYmGcLOJW6lhfk0ixgSqPCfO+oJO35IGY1vxRSaUSSYeWP5zjq/08U20YXuKFOMAe9tOKszf8pwC8PuqT6zTiqFaU7f0Gb12ifejycJ3c7oxAlDbCZj/qBe6CpldPOULTrWNB0u8s8tHz1yB9Is/nFOn0//SlFAtlKweSM4DbeUtj4kUNEj7He6rJWqPdx9s4+7Jp1+u1HuzSVtRjb6OX1x0kwGvSZ1zeEffFTjy0qycS7LvLGjgmB6vh/FEr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8629.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(19092799006)(23010399003)(38070700021)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDcwUEtibHJEVVdpSE03ZFM0cXRNMnRzSHI3a1I0Z1pML2x0OERDUmFXekFy?=
 =?utf-8?B?SW1GWFhLZG5PS1BXNWV4cnBFWjhraGRQMmFhUnQyQTAvRHlSTEVzdUMrS0NF?=
 =?utf-8?B?NGRDNkhhc1lYNXNxQkNKTDVIcWk3M000RS9wTXFnRlM1SytZbURIUUk2ZnNt?=
 =?utf-8?B?UXNKSUREQzMxaDhEMXZXeWlvcXIzeDh2TUZLOHY0REQ4WG42RTlzb1E0MlZH?=
 =?utf-8?B?N3A1YnhyK3F0amZWTU93TmNYWUhxaTVWOFJMY08xSGJHMzF5MXcxYUhxRlU1?=
 =?utf-8?B?a0F3Z1prUXhPYmcvS3paVE8vUTdtNmVEeWw0NkVkRWh6MFBvTHFOWkdJSTR0?=
 =?utf-8?B?K3FVQUFxNi8vSkdwZlg1dHk2V3Q2SmpvWEF1dEhYaU5MMk9MQ2ZQVU1JczNj?=
 =?utf-8?B?WDJZL0twVjFWWStVV0VnNkdhMmRHeTEzK1YvckdURnErVWZWdlhLUjZLeG5Y?=
 =?utf-8?B?UFU3Z1puY2xMV3J0QlJaRlZpTUdZNjJwb1BwL21HUmhDTzNJdXlEYmZjTkNL?=
 =?utf-8?B?NFB0blZKWjBDbEF1Mm1jejRkN3VWcGt1dkNmN1o2MlVYdUFVb3BKOStNV01B?=
 =?utf-8?B?Qm1xR1Y0RU1LSzdMT2xVd0lHTWJNRXFMejN2YlBmYlpVdGhpNDRRR09qblh2?=
 =?utf-8?B?TklNVzhzbmVtT0lVTGxWeHVpUStYN2VZbHNqajM3cXhKMXRTWkVJZ0t6Unhz?=
 =?utf-8?B?Qm5VakM1NnZGNTZiZUQwWlR1eUpyRVBoQldpSHdUMDJLaEJpQTJTcmFDNURM?=
 =?utf-8?B?NzVyMEVNUzdzOWRxNUtZZjZubkF0WGJEUTR5RVBYbnZBa3ZZaEpNd0NZV2ZU?=
 =?utf-8?B?VHhML1l2bFh6Sm5tMStaSE9UcGFMdTU1RGJ4cHljMDZ6RkcyeHZadHhmd3Fs?=
 =?utf-8?B?TkhqT3RsWlNkWlZCeDN5Q3NFaGNpMjJZVm1TejVxRDFyZk9qYysxVEJDdmFZ?=
 =?utf-8?B?dnJVeHNFVmZLbEYzdGJab1dJTzRpaG9DMDlYazRzNTdqaTlDS0FDb1hoKzZP?=
 =?utf-8?B?dnY4YXRLMmF1ZUtTSTJEa3k1cG9YWEdua284MTBaZ0dhQTJ5VkZHRVRQT2hk?=
 =?utf-8?B?a3ovZThaSDd5RlRXODM0NGtMRWwyTHVNeldoWGxuMm5XT3dDaUxvZTAzcFFv?=
 =?utf-8?B?Q2E0VDJxWnVyenVnYWtreDE1b0NTTjhZQkV2VHZydzJ6cytCZVhmbjBwT3d0?=
 =?utf-8?B?ZUhnQ2xLQ2JEbjBBV1hpM25USC85aUhwaEZzT3F3eEhueDhpNWpKSDZRTWFL?=
 =?utf-8?B?NWJ1akNueHhSSUwzcDBBUHlFcWtMVEVuSEhGQzZtd3JYZUt3bFhDTzhmWEtC?=
 =?utf-8?B?Z0VuL0U4cVdsYWR2VUlLMk5qS095WlE5djlPb1BCZk9lbVlmZ3Zua3Y4VlNm?=
 =?utf-8?B?Ym1xRmtacnZUL1gxdmxsa1M4RUVOTE5zYXJYOUp6a05uaEptdEVCYXNGdFlH?=
 =?utf-8?B?M0hFWXVIYTI3MzVkTnptQ0RXYkhJMS8rcEo5ZmdXSm9LT0E2QjF4dzRqc0hZ?=
 =?utf-8?B?RUx3WjlMVXcyckVUeWZNNzEvNWtpaHdhNDl5VklxSDB6NDJ6ZkkvaUZMb3NS?=
 =?utf-8?B?Y1FyMEZqTzRYZkdRMTFGMHVvN3RFZmM0bDZXbGJwMTZSTndXNmFWUXhjN0pB?=
 =?utf-8?B?dy9qQ2tiSTRwWG5HdFZpQVZ6cmtsbEpQV0Q1K1BMdlJjcEJVS0JKdXVYVFpN?=
 =?utf-8?B?UmNwYXpoVlArb00zS2VVWDd3VldIVEpEOXdrSkJnTiswWDgvNmZtNVZOM3pM?=
 =?utf-8?B?V0xxME5jUE9sc3pnQ2JQTlM4VzNmQXJkRGxRVlQyOHBOUzR4WDIrNFhRdTFD?=
 =?utf-8?B?d3BhL0RnWTVabjNhNHE4ZVJXUGJiMlhFZ2gyTExhdzhQdHZhSHNZcTVQbCtL?=
 =?utf-8?B?N0NXdFAxRG42eGJrR2o2eUYwWkFudVJIZmVwOVNSZC82U1ZaQ0dNSExkaW1m?=
 =?utf-8?B?ckJlQVJ3RU9vRVR0U1BhaUppQm5WSTdyWWxLNjB2OERQcEdmbG8rVjdzdG0z?=
 =?utf-8?B?azBrUHZKZnI1czZwYWJhdTVRM3RhcSthSVcwOUtPbEpubjlVOVF2QjFUVlBR?=
 =?utf-8?B?eDVMWnE0eFo4d1BrcVV4QlZIYkd6R2pORjZMV0dyOWxlYWpybzRvbSsxMnNK?=
 =?utf-8?B?R3NkS2JVb3lEZEwxdGh6NEJKWUxSbE5TemF3c3k5MVhyWXZ1MzV0L0svL3Zq?=
 =?utf-8?B?bERPSFZKZHEzTFZ3aUU3cnpaTWQwME5ncXltRTJXUlJkOUJGaFN5djdMOXN1?=
 =?utf-8?B?TCt3SXYxWmJsMjF0akFJZytGeXoxaDZOR24vbjNPYmpCaUF6SnpJKzJtbFFK?=
 =?utf-8?Q?tBFMTY+9Wue6DRSLpa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8629.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d7c77e-1fda-4fb3-b686-08dec82ba759
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2026 02:38:14.9874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QeJ2zp5CcCy3lNqU/THVK+yvnPot06K4GXVKftiyT8e0feDoxNyu0ixNwpkwEIkGsNjYl6xGmjF+1FKWYOp4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB12343
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-298443-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@oss.nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CD406764E8

PiA+ICtzdGF0aWMgaW50IG5ldGNfcG9ydF9hZGRfdmxhbl9lbnRyeShzdHJ1Y3QgbmV0Y19wb3J0
ICpucCwgdTE2IHZpZCwNCj4gPiArCQkJCSAgICBib29sIHVudGFnZ2VkKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgbmV0Y19zd2l0Y2ggKnByaXYgPSBucC0+c3dpdGNoX3ByaXY7DQo+ID4gKwlzdHJ1
Y3QgbmV0Y192bGFuX2VudHJ5ICplbnRyeTsNCj4gPiArCXN0cnVjdCB2ZnRfY2ZnZV9kYXRhICpj
ZmdlOw0KPiA+ICsJdTMyIGluZGV4ID0gbnAtPmRwLT5pbmRleDsNCj4gPiArCXUzMiBiaXRtYXBf
c3RnOw0KPiA+ICsJaW50IGVycjsNCj4gPiArCXUxNiBjZmc7DQo+IA0KPiBbIC4uLiBdDQo+IA0K
PiA+ICsJY2ZnZSA9ICZlbnRyeS0+Y2ZnZTsNCj4gPiArCWNmZ2UtPmV0X2VpZCA9IGNwdV90b19s
ZTMyKE5UTVBfTlVMTF9FTlRSWV9JRCk7DQo+ID4gKwljZmdlLT5iaXRtYXBfc3RnID0gY3B1X3Rv
X2xlMzIoYml0bWFwX3N0Zyk7DQo+ID4gKwljZmdlLT5maWQgPSBjcHVfdG9fbGUxNih2aWQpOw0K
PiA+ICsJY2ZnZS0+Y2ZnID0gY3B1X3RvX2xlMTYoY2ZnKTsNCj4gPiArCWNmZ2UtPmV0YV9wb3J0
X2JpdG1hcCA9IGNwdV90b19sZTMyKHByaXYtPnBvcnRfYml0bWFwKTsNCj4gPiArDQo+ID4gKwlp
ZiAodW50YWdnZWQpDQo+ID4gKwkJZW50cnktPnVudGFnZ2VkX3BvcnRfYml0bWFwID0gQklUKGlu
ZGV4KTsNCj4gPiArDQo+ID4gKwllcnIgPSBuZXRjX2FkZF92bGFuX2VncmVzc19ydWxlKHByaXYs
IGVudHJ5KTsNCj4gPiArCWlmIChlcnIpDQo+ID4gKwkJZ290byBmcmVlX3ZsYW5fZW50cnk7DQo+
IA0KPiBbU2V2ZXJpdHk6IEhpZ2hdDQo+IFNob3VsZCB0aGlzIGVncmVzcyBydWxlIGFsbG9jYXRp
b24gYmUgc2tpcHBlZCBmb3IgVkxBTi11bmF3YXJlIFBWSURzPw0KPiANCj4gSW4gbmV0Y19wb3J0
X3ZsYW5fZWdyZXNzX3J1bGVfY2hhbmdlZCgpLCB0aGVyZSBpcyBhIGNoZWNrIG5vdGluZyB0aGF0
DQo+IFZMQU4tdW5hd2FyZSBWSURzIGhhdmUgbm8gZWdyZXNzIHJ1bGVzLiBIb3dldmVyLA0KPiBu
ZXRjX3BvcnRfYWRkX3ZsYW5fZW50cnkoKQ0KPiB1bmNvbmRpdGlvbmFsbHkgY2FsbHMgbmV0Y19h
ZGRfdmxhbl9lZ3Jlc3NfcnVsZSgpIGZvciBhbGwgVklEcy4NCj4gDQo+IFdoZW4gYSBwb3J0IGpv
aW5zIGEgVkxBTi11bmF3YXJlIGJyaWRnZSwgbmV0Y19wb3J0X2JyaWRnZV9qb2luKCkgc2V0cyB1
cA0KPiB0aGUgaW50ZXJuYWwgUFZJRCBieSBjYWxsaW5nIG5ldGNfcG9ydF9zZXRfdmxhbl9lbnRy
eSgpIHdpdGgNCj4gdW50YWdnZWQ9ZmFsc2UuIEJlY2F1c2UgRVRUIGFsbG9jYXRpb24gaXMgdW5j
b25kaXRpb25hbCBoZXJlLCBpdCBhcHBlYXJzDQo+IGEgbGltaXRlZCBFZ3Jlc3MgVHJlYXRtZW50
IFRhYmxlIChFVFQpIGFuZCBFZ3Jlc3MgQ291bnRlciBUYWJsZSAoRUNUKQ0KPiBncm91cCBpcyB1
bm5lY2Vzc2FyaWx5IGNvbnN1bWVkIGZvciBlYWNoIFZMQU4tdW5hd2FyZSBicmlkZ2UgaW5zdGFu
Y2UuDQo+IA0KPiBTaW5jZSB1bnRhZ2dlZD1mYWxzZSBpcyBwYXNzZWQsIGRvZXMgdGhpcyBpbmNv
cnJlY3RseSBjb25maWd1cmUgdGhlIEVUVA0KPiBlbnRyeSB0byBwcmVzZXJ2ZSB0aGUgb3V0ZXIg
VkxBTiB0YWcgb24gZWdyZXNzIChsYWNraW5nIHRoZQ0KPiBGTVRFSURfVlVEQV9ERUxfT1RBRyBh
Y3Rpb24pPyBUaGlzIGNvdWxkIHJlc3VsdCBpbiBoYXJkd2FyZSB0cmFuc21pdHRpbmcNCj4gdW50
YWdnZWQgYnJpZGdlIHRyYWZmaWMgd2l0aCB0aGUgc3dpdGNoJ3MgaW50ZXJuYWwgUFZJRCAoZS5n
LiwgNDA5NSkNCj4gYXR0YWNoZWQsIHBvdGVudGlhbGx5IGxlYWtpbmcgaW50ZXJuYWwgY29uZmln
dXJhdGlvbnMuDQoNClRoaXMgaXMgYSBmYWxzZSBwb3NpdGl2ZS4NCg0KRm9yIFZMQU4gdW5hd2Fy
ZSBQVklEIEVUVCBlbnRyaWVzLCBubyBWTEFOIHByb2Nlc3NpbmcgaXMgcGVyZm9ybWVkIG9uDQp0
aGUgcGFja2V0cy4gVGhlIG1haW4gcHVycG9zZSBvZiBhZGRpbmcgYW4gRVRUIGVudHJ5IGlzIHRv
IGFkZCBhbiBFQ1QNCmVudHJ5IHNvIHRoYXQgdGhlIFZMQU4gZW50cnkgY2FuIGJlIGRlYnVnZ2Vk
IGxhdGVyIHRvIGNoZWNrIGlmIHRoZXJlIGFyZQ0KbWF0Y2hpbmcgcGFja2V0cy4NCg0K

