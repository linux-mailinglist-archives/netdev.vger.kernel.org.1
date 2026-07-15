Return-Path: <netdev+bounces-307764-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XOtLF7CPV2pUXAAAu9opvQ
	(envelope-from <netdev+bounces-307764-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:48:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB175EF09
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 15:48:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=technica-engineering.de header.s=selector1 header.b=AGXB0i1f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307764-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307764-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=technica-engineering.de;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E2530210CD
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 13:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1001C2EEE65;
	Wed, 15 Jul 2026 13:41:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023119.outbound.protection.outlook.com [40.107.162.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05B2877E8
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:41:48 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122910; cv=fail; b=aXcKwKs+6TH5GHa2ayNPEVBG03Qc/6NL8MBfvb6/NyQ8vBwtoAprF+ScjGNfWpcV/YF9JicKvgzIw9VAUHYjh4iC0k+tGDJ9/DhuXogkGw4O6zAvaUzIuYCDc1n51amjoG5Cshy91LnN/dmJJJABryuNdEXwuS5DY8xH1cTy9nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122910; c=relaxed/simple;
	bh=g5+RPGqr8z5Xr0lzDfQ3r9bAVQiKALN+w3EULAUr4mo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kYslGPVUJnV6G2YCErNuBQ1WnT6Wn/qCdAcVC/qIe3xrrty/PxLiO4VRy9efRXDJDFkL1aVSV4uL0tbX1hfgzWrMKV9MVUS2UKTdrmLGbToCc6xf4VSryW7MPZPdZcuL8jhXy4XxBeFtTjiHXnFX7gefNI6iw0QqrPYCv2o49W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=technica-engineering.de; spf=pass smtp.mailfrom=technica-engineering.de; dkim=pass (1024-bit key) header.d=technica-engineering.de header.i=@technica-engineering.de header.b=AGXB0i1f; arc=fail smtp.client-ip=40.107.162.119
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsZGUaIAB2x/MC4c0OWBt95xP9vtZeS9Wg37aB9sRXxqvVqTSZPjx2/IuGcOe2ValDieFeJ6PsE7ETAgYAblYFAHSua55qZWloc+cQ62TVPRK/vPni7PpwIsFYx0JZ2cdghCc8UTDuiQ/ySejETyZAGGag89MmkYXCItFIOA1pdIuJ9hAGG6fDdoBcstD/PFuEx33y13cJb8va5t4pkLAjF6zysfTsI04ZuHG3yPNTF3CkkGMZG4iXt+GwL8YZiCIpPT9kxT+z7GLVfff0/npASr2301/YUP5JQhQK1nOglEogDDmsLW3dW+Phsre5TEIFIHJuJo4mN8PN9vlftxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5+RPGqr8z5Xr0lzDfQ3r9bAVQiKALN+w3EULAUr4mo=;
 b=j+UpSQ2pKjdcIBdCq2RdnvOBnE/mg6XChYNTZU6JO83D0lPtHHWIbuy/S+dGhCTqIXTP+LFnzyqO1L3ut5d7A0AQ/legT/bBzr+u8Md1m9O+zYl0XnfeTcMOxZNyBr/2c7EJ+3d2yQQ74qc3p2FYIl4JqAU3wPFY+sxBe+x4jdEutAjHOBPRtaXyQ+5l/n7vXxDUGqSpMhJ/YhwdFxpg+rj3wjrMZyuF2fit6LJIBmapBpVY/RYwoDcXzrq3yXsCPsYO1h4ZGV21lHy9NzsNR9KkGTRcDLWPnUkmN7B4I4TDZTUyDkq77MY+r0E0wDwGEr8LRnApc77fqs03FyGkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=technica-engineering.de; dmarc=pass action=none
 header.from=technica-engineering.de; dkim=pass
 header.d=technica-engineering.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=technica-engineering.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5+RPGqr8z5Xr0lzDfQ3r9bAVQiKALN+w3EULAUr4mo=;
 b=AGXB0i1f8AhnPjdVzLR9Ka7Bo+/c4b474IbOlf32mglyNuWGbLVrUxsQY7K876SjTuE3u4+BcnbfofjGypxWI5yXk0L2aVmd9uPVaI3+ukreZNTl0OOp8Kuo3978shziXjpCDQqYdPlVI08kUF+FfSUs5uY0InPZei7fjO5dIgk=
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com (2603:10a6:20b:584::15)
 by DBAPR08MB5864.eurprd08.prod.outlook.com (2603:10a6:10:1a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Wed, 15 Jul
 2026 13:41:45 +0000
Received: from AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9]) by AS4PR08MB8021.eurprd08.prod.outlook.com
 ([fe80::edd9:a452:6f60:5e9%4]) with mapi id 15.21.0202.018; Wed, 15 Jul 2026
 13:41:45 +0000
From: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
To: Andrew Lunn <andrew@lunn.ch>
CC: Russell King <linux@armlinux.org.uk>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, =?iso-8859-1?Q?Dr=2E_Lars_V=F6lker?=
	<lars.voelker@technica-engineering.de>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Topic: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Thread-Index: AQHdEqUvQ2S5XVAteEurgYKiixGWIrZtcDEAgAC2GcqAAGmagIAAAGhM
Date: Wed, 15 Jul 2026 13:41:45 +0000
Message-ID:
 <AS4PR08MB80219505FEC2334B503C55DCB7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
References:
 <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
In-Reply-To: <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Enabled=True;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SiteId=1f04372a-6892-44e3-8f58-03845e1a70c1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_SetDate=2026-07-15T13:41:45.366Z;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Name=Internal;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_ContentBits=1;MSIP_Label_f4ba6aec-3794-45cc-8203-ba2df4db1a2c_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR08MB8021:EE_|DBAPR08MB5864:EE_
x-ms-office365-filtering-correlation-id: f3ec0335-6312-42e8-f0cd-08dee276cfe4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|4143699003|3023799007|38070700021|10067099003|55112099003|6133799003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 w1RlIeUDHfXFSugxHjAO9P/O8naekCU3Z1Dp6LHjEZDpZj0ToIWryktmxvil8hGyrrWulKjMPRX1guFmxbWfSEeNk2JVXGoD6sJEqNxlxx3cyebqJ2vRLr4SHdVCftK8kn4ljCQnr8S+xOqPOIyYESv1KcWwejGmnYSHh+F4AehqTnnEsRtjhJRjjEm4GyPj3NNgmqL2D8cVrdGja2tzgD4HE9fdxkwKRiIS0MfuVesJNhonde6tY+rbKxjpZzIzQ4fsy8qh+IO+NS9UHKIw4+mhaCL1u/oVSgtHGIWoLt/2NORsXZ5SN8eUoZjrtVTNBnqoDmzz/7wi6vTeg8fViBLqVKqbeq3myWq7rm8sE5ZOFSgFF8X2OuceDXV8W3oCGjGsnhdQUTNAJ9oUGwlIAKKExFZZ97NuwkBGXgR0Qhl1DDlZOQnOmhUOVK696n4/WjbqqUOOwKmWIeZ1qtvAGTt3i74PLEeZ40FjQM5Oh1xEes/b63yPdoWPUfM1v+oX32s1vmO89lCqVbKHW7MWB/2eJXMAqgW6cPKF5iMg2VCTHyaalNC2byArsxzzlZ1hriDsBa0EwD6CjN995J9CIot6w4UOsjM6qyrgZ9QWaVdRVM3iLBJGrWRfIslLBvhmfcPHaWsaM/x9huN3KQYyL9BdU83vx0nzHSzTqp2RGUwW0vzqBsb8J9T2tYbzVCjx1aY9mroqCzkSB3b9bIoLh9YtZYw4kFx3SmppmTkOdAw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB8021.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(4143699003)(3023799007)(38070700021)(10067099003)(55112099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?O50cQlLK9E/X/T2xkVzdkmDpqh9HM+QFOmFkEE0QzO9iOLoZGILsw1JloQ?=
 =?iso-8859-1?Q?QmGaN2df4kdWUf35vF2BIz0ZgIDchokmpAqs/hFhovUQX9aBwgYAEaSJvJ?=
 =?iso-8859-1?Q?QWM9ejlG2/bhvzHcnDwB9MhUZ1SDf5pJMMuR6B42yAFblIdXa/2v5fU77A?=
 =?iso-8859-1?Q?WcYFClOGVP2L/rIEeEVr5q2ziJL9PklK+R0WSX7VhgbCON6U5+Q2wAiVDu?=
 =?iso-8859-1?Q?FjoC0Gc99+99wmW6W2hPtRVVHzvxDtEmgb/G2EWVMiyLSi6m2L3MkJUWZs?=
 =?iso-8859-1?Q?VBxvmeW5mY8Vh2rA9bl3GmV6iQPOgzBBQ+Jm8TGetQP43jnGvv1Cu/rVIk?=
 =?iso-8859-1?Q?vm9OE/LWMptlSLkBLA4J+wksI8q5rTVEIOeqP69pKjziYZxwPgEQia2ZyJ?=
 =?iso-8859-1?Q?/DjZEoR5lS1VvyfWOLjpiOhYhX96Lkt+guH9SxFIWBwdU4SMKSUyCRViGj?=
 =?iso-8859-1?Q?c8ceExOrqoWt4CRAdWdAwFbCIzeKEVan/C7qEkqTJeJq25kpyeFzn6O3S6?=
 =?iso-8859-1?Q?/L84carAJ6DqS+Sm6oNrX22TeQd7xCTs4kGxIonkKbdoaYcCIYkElLv1wM?=
 =?iso-8859-1?Q?8hsDUpKaHqzwpjhSWGDys0VWURW2BsSGIVEczG72tI7A7jfvVGwzFNVNmj?=
 =?iso-8859-1?Q?tXX42hTtbyACtGXdvI+EQOgdWFVPUdKzIBS4z/i1Abz5TG0KRO9Wf3EjrT?=
 =?iso-8859-1?Q?DbHpxFWv07Bvn4b9SwGRPoCSFpLXJlurKNbs97mmJ5zMNkJ5Dr93x6AQaY?=
 =?iso-8859-1?Q?y+49Wcgwz5UaD23vnHH1x80xlz4wX5fn8bR2Ebb61ktNMzOvRQgRurdSOt?=
 =?iso-8859-1?Q?ea2DPf+jIogogHxqis5oD3iZw+mF+9TgZuMQgd8TCHAL6JDaNgIYw1JboE?=
 =?iso-8859-1?Q?Ma9rRe/jyRWNsLIZvWLos2gWEFxx9G3HzRDaCTt/7tEwT236J0Gh1ozj2N?=
 =?iso-8859-1?Q?7RJRUqw20pZ08k983R81Y4jMXXi6/C4O12tjv+9DcbxkimzA4f5NOAFvsz?=
 =?iso-8859-1?Q?az1zJsPsqaXWXjdwwtL7Z3vFU8N2pCKpaVuPFki9gqklVfL+/VuG6d9i0Z?=
 =?iso-8859-1?Q?CYskGT4oPs7ac55bAZo+D4GTqpGWCOl8L0By61xhqS0k8aVPQag5KVUwoa?=
 =?iso-8859-1?Q?rMuVO10hp8yhzVSp3xYrZS2RaidPE0mo+fQieCdFocrP04efspDZJ9ayCw?=
 =?iso-8859-1?Q?njeNvHdVWHka2p1WFsdZOG3Tv/M7g+tEc10PyC81HZNsBeapWitZebw+AN?=
 =?iso-8859-1?Q?0YBwZufRSUwg5QAJAuvuYarkSGj+FFRWNoOKDZgOk4u5esLuTVH6qenEoJ?=
 =?iso-8859-1?Q?FK1NZg9u0aTYKw4Lst1sp3tIcvjsOnH8RRuLbaPiQlkBcYURowosq4onut?=
 =?iso-8859-1?Q?V+uHEMqqMVNPvvw0xWgXTRfb1wVys8/lWm0C1fFFYre1u50WZi3Hb2kBZl?=
 =?iso-8859-1?Q?7TrdvSDIF57vTf4rHOy91z0UXcj3j6c6fCRrYj5DmWmPHSc5CRp6hfQ3hI?=
 =?iso-8859-1?Q?QgOeosklj9O3SYUQbQHI0MZS7OZcQi7jzxZZTj3d1ZgTHBOxe0/uHanrx4?=
 =?iso-8859-1?Q?lQRKdWz2H/+a69WH+pjcrGlNlr+BiSqf3Bt3JSxWHweQSJSE51sxm5yMxF?=
 =?iso-8859-1?Q?dtCjDjuCVgmB6dQS3FKXO6k15ntvpanA042O0aDmUh5wNu+Jq0CjaDBX+v?=
 =?iso-8859-1?Q?kTySzIm6QJhEPevGXtE9J5+DHZAbEz3frGOuMDv2eEmot+3gOSIUbpKzek?=
 =?iso-8859-1?Q?NvByunEeVnfRH8Mh/EpPEr2RPzUqRsCstYSRPaOzdTJvauXXv+FasDPEzJ?=
 =?iso-8859-1?Q?fw6uTbTcesi6K5HFSn/a2zY2PDEQsUU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: technica-engineering.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB8021.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3ec0335-6312-42e8-f0cd-08dee276cfe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2026 13:41:45.4888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1f04372a-6892-44e3-8f58-03845e1a70c1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4wOcV7MVGnKSFBZZUul3L2yG6KZCyW4DfuJLtJgSfx5POiaINvR10tXP73lNbyee0NzofX6XzdDDi7Wjyi0/NPEuiuzfQXnRIi5ShjTgdIK0hd6vaIP7xnQsotBc2wb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5864
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[technica-engineering.de,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[technica-engineering.de:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307764-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:lars.voelker@technica-engineering.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ayoub.kaanich@technica-engineering.de,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ayoub.kaanich@technica-engineering.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[technica-engineering.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AS4PR08MB8021.eurprd08.prod.outlook.com:mid,lunn.ch:email,vger.kernel.org:from_smtp,armlinux.org.uk:email,technica-engineering.de:dkim,technica-engineering.de:email,technica-engineering.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4CB175EF09
X-Rspamd-Action: no action

Hi,=0A=
=0A=
=0A=
> We would expect the code to fit in with the current architecture. So=0A=
> mdio-i2c would provide a Linux MDIO bus. You "third party driver"=0A=
> would be a PHY driver.=0A=
=0A=
Sounds fair.=0A=
=0A=
=0A=
> For NICs using firmware, you will need to talk to each vendor, and ask=0A=
> them to extend their firmware to support your SFP.=0A=
=0A=
That does not sound reasonable, given that the only interface needed to the=
 SFP/PHY is the I2C bus which the kernel could access directly (to read EEP=
ROM for example)=0A=
=0A=
The only change needed as far as I see, is to have the driver expose the in=
ternal SFP I2C bus (basically only the I2C read/write functions)=0A=
=0A=
for the case of the ice driver, the functions ice_aq_read_i2c and ice_aq_wr=
ite_i2c already exists, so creating the i2c_adapter from it should be trivi=
al.=0A=
=0A=
=0A=
If the NIC does not expose the I2C bus at all, then it would be understanda=
ble if a NIC firmware is the only viable path, but it's not the case here.=
=0A=
=0A=
=0A=
Best Regards.=0A=
=0A=
=0A=
Ayoub Kaanich=0A=
Principal Software Engineer=0A=
Engineering Department=0A=
=0A=
=0A=
________________________________________=0A=
From: Andrew Lunn <andrew@lunn.ch>=0A=
Sent: Wednesday, July 15, 2026 03:05 PM=0A=
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>=0A=
Cc: Russell King <linux@armlinux.org.uk>; netdev@vger.kernel.org <netdev@vg=
er.kernel.org>=0A=
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for =
non-SFF pages=0A=
=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.=0A=
=0A=
=0A=
=0A=
On Wed, Jul 15, 2026 at 08:09:56AM +0000, Ayoub Kaanich wrote:=0A=
=0A=
> Hi,=0A=
=0A=
>=0A=
=0A=
> > In general, we are trying to block user space drivers, by only allowing=
 read.=0A=
=0A=
>=0A=
=0A=
> So in principle, a write from a third party driver (not the NIC own drive=
r) is allowed?=0A=
=0A=
=0A=
=0A=
We would expect the code to fit in with the current architecture. So=0A=
=0A=
mdio-i2c would provide a Linux MDIO bus. You "third party driver"=0A=
=0A=
would be a PHY driver.=0A=
=0A=
=0A=
=0A=
> Our issue is that the NIC drivers (especially the netlink based=0A=
=0A=
> drivers), have no standard way to expose the I2C bus of the SFP=0A=
=0A=
> module to other drivers.=A0 phylink based drivers don't have this=0A=
=0A=
> issue.=0A=
=0A=
>=0A=
=0A=
> The current hierarchy is=0A=
=0A=
>=0A=
=0A=
> net_device =3D> sfp_bus (missing in many drivers) =3D> sfp (internal) =3D=
> i2c_adapter=0A=
=0A=
>=0A=
=0A=
> For example: ice driver does not create an i2c_adapter or sfp_bus, even t=
hough many of the NICs using that driver have SFP28 or QSFP28 pluggable cag=
es.=0A=
=0A=
=0A=
=0A=
So Linux Ethernet drivers fall into two classes. Those where Linux=0A=
=0A=
driver the hardware, making use of phylink/phylib, and those where=0A=
=0A=
firmware drive the hardware, eg ice, and pretty much all intel=0A=
=0A=
hardware, and most NICs which support > 10G.=0A=
=0A=
=0A=
=0A=
For NICs using firmware, you will need to talk to each vendor, and ask=0A=
=0A=
them to extend their firmware to support your SFP.=0A=
=0A=
=0A=
=0A=
For NICs where Linux drives the hardware, which is pretty much all=0A=
=0A=
NICs used in embedded systems, with a bandwidth up to 1G, and some=0A=
=0A=
10G, provide an implementation of the protocol in mdio-i2c, and a PHY=0A=
=0A=
driver, and it should all just work.=0A=
=0A=
=0A=
=0A=
Looking at the other devices you pointed to, one used a Marvell=0A=
=0A=
88q2xxx, for which a Linux driver already exists. And there was=0A=
=0A=
sufficient hints in the document to make writing the I2C protocol=0A=
=0A=
possible. The other device explicitly described the I2C protocol, but=0A=
=0A=
did not mention what PHY was used, so might need a PHY driver. But=0A=
=0A=
there are not too many T1 PHYs, so it might have a driver already.=0A=
=0A=
=0A=
=0A=
=A0=A0=A0 Andrew=0A=
=0A=

