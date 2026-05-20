Return-Path: <netdev+bounces-290081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0KExYPDmrB5wUAu9opvQ
	(envelope-from <netdev+bounces-290081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:44:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24F1598AE2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CEEC301F35F
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7434846A;
	Wed, 20 May 2026 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZDspGbF"
X-Original-To: netdev@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012015.outbound.protection.outlook.com [40.107.200.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659F426F288;
	Wed, 20 May 2026 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306258; cv=fail; b=LBODKCeGKwlrHjUhm22b6hgLL2pON+syELtj80i65M+zkqQqutQlb1XAVaKnBF3jFkktoaCmTlLroPWMgwt7Q3sG+Sn3wHpF/6PPoTZsr8bK0tuZEdvuz+PwNki4J3s3sWa8vGQLvxcafAwagVB//9smGZDmsd0eIJP6dZ4HG1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306258; c=relaxed/simple;
	bh=UAK/jnN3MYLVGVxku/3fGicS+nxOTJ6KxpLanIZjrgk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw/gcBzC/qCzetkxGQPiTPDV7ErQbBMSV52SuYaCSSF/ua08IdHJZ1Uyo34jWV3cj3AGWvGeq/eUqaJhYW1efrn9hgKJkVLKW5z4+HlB1qJwrfnTbEE4UfCEgBqyI5gJ6sptp3X5V4BKvmqVxnrbRK4s/khwbimGm7qm/x09aKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CZDspGbF; arc=fail smtp.client-ip=40.107.200.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvNERm5uyP8KNylurPX13Smansza/AwoDLi8WxxaeQ74Z2NwsbJy3XBzQk7iyH9UppUN/3m8mMZt3IlPeWpKOV9MwAgmvkCb8E2LTXcpZpkEe3sKpbBZJgsF8Al+ekHDHx/p0lEAIOc7T273PZW29X5EFIFQVUGPOWe1VVT0AcUPGeONFHbVNzFQ8DGwSbRQpboWFjfVFP6VqvNG6qe3VyVzj2ow1hxmWarnKH6U1/Ui8EDOaK9bFmhxhjZILZB0T61g4Gqo1t7A9NvjfMiZTAVWpUfABzVKwQX2ZVnj3LvGF2kvEyRWHS705EhZz4whqupkhsqQbt37xcApXc2OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTpvwWVihkXILLsJXnNk6QD2Lnxi8aqIpr/+Zov8AGE=;
 b=X3roaZQtu8cI9v/NTiqZfqF7MY8lIl84FSK/W1T8gvu5N5w4CtCVo1Sve3JpiyjRc0rQzFRqKRWO7vNYBuWLhliWmaXDQpEbZwHQGC92v2PWQ3t13Mh5EgVCI8oHKuHAEslYsmmmoMYsMYtMQEaaPUaRaNcdClZYenHPZ/6KYkiAS9rBpJMiMY7D8fgTUcITnBfRTEsqYMzQGCoEIknPKCUTBaNOzFdwq4wbn+JDq2SkhXPdHVSwoOlrZJGGLOcU9ohWpRFLbYB029FrCtM6P8pghfk2tGU9QT53DIRcrFeQyk7wuA3MxFYRLeyaSXXCZMlMJdUl5XwlILey1AqMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTpvwWVihkXILLsJXnNk6QD2Lnxi8aqIpr/+Zov8AGE=;
 b=CZDspGbFmWn0VSMdhFrB0arH/O1KR0PDrxaEvvOnxifvKCmRBhZ6PD0lMgwcckuAagIJ9LEX3GtNgwDXeMSfB0EHibe7YJ526Gr5LtBfxS0lrqh0gD6dA+vzqy8w6BG5daOA8hKO1He1qmECdNgVSkowTmBJyzlzQo58/BCqCP97KcN1DHZ5sUsRW0Me+OQkqjie19ULc8CVbb11ZQkCQ3brma1rD9mT9DNaJvwfijyfr5gJdUe+RVyaksALP7hs0CCrgFMgahukqYiWUZpS95mrFm0/g/a/DYiEme5BBykiyM5GX/FV6xQqWmp6Fmt/1jW1TSDp5UKnClkzId2r2A==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 20 May
 2026 19:44:10 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 19:44:10 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
Thread-Topic: [PATCH net] net: lan743x: permit VLAN-tagged packets up to
 configured MTU
Thread-Index: AQHc5KBs0dnPuL87QUaEqFq4Tj9HTbYWJ1eAgAEw5CA=
Date: Wed, 20 May 2026 19:44:09 +0000
Message-ID:
 <SJ0PR12MB811357174E939B5FAE254B4FC7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260515192357.3631802-1-davthompson@nvidia.com>
 <20260519183053.4ba5f3de@kernel.org>
In-Reply-To: <20260519183053.4ba5f3de@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|IA0PPF7646FEBB5:EE_
x-ms-office365-filtering-correlation-id: a4adda35-337a-4193-6ecc-08deb6a8297c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|11063799006|38070700021|56012099003|22082099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 BalBz1ceCWMkbrsSwZFhDkddGBQf7HSgk7L5VPycCbEviee2YonJHTHWUr3C5POf37qjSGYSnqcyKhdi3pyokOuTvnopE4MDe8sKxgQoHkSRSTsGFwukkVmwRqYTz3q2va8qJqaq0LywIt8IAg5BL6WdaeqvzFB0P0fYCxtrOwYYhLyWDnVFkid6QhR5Tba5J1F9f3BZCJcTWpOUbwkLw05hBf5qnMt+MgTfC5fU9JfWhw3Wn6c7naDHF+4FhXh6S5sHpPJfFIdnAz7OdsIn8Xt2NmmVkYwcy9+pJ71xoDZ38NISThMMShhoP3gTkD+NtYyYkvf++LshP1QhRSHRRvkSEHx79roYWN4qLeucI3AtcMqFI5tBiteDJKnn17RsgqDamvc4akWbkg/QuGTolLIBc2zGOImcPZWM15wbCPjiYhdvZ79+9xR/gk0W3oQ0VQiPiF2NSqsP+0bo3nuyCfWs9GgMAuhD7CZdBSGolfEq3WfdArbcjRlb0Eusvf/McMvms3d4cs322G8TrS2Q/cj6Bl9ZGQDA4X4Yux0cgywbGziPArDUdEV5oBcPqfUBx9uz7HUJJG2cAJ0WtO1FA2GhpHekp4IUKrLCYPed9pz/54RpDf+ssBNoAflZXP8GyrYeg/GuvCrN6IzBrUpeCtumVanPTPW1675Yrd+ESXO8RsF6bbY3MtLCu6moTuV6cl88snVZlcBTs1Oi9dKjpju8o7+rOVL+eIqcoMyxbmNLdgf5nlfnVkjCkZSqOPce
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799006)(38070700021)(56012099003)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yBLNoMdPGpQAk4O1cv2lbt/mqjHR+yEz+cEOUY/v0AKxTcGiAArpoT3e0PQD?=
 =?us-ascii?Q?HMcqUH2okKdnRZK0XUgQfyf/4g9g4cT/kPBo5Y3kqXMWpUGkGZGUojCSy6Dh?=
 =?us-ascii?Q?Az2/Q65LQ8s4ccI2buSQpbiMpdAM2uHFLliIGD0eT9UBVgj8NcRPAfCHLH42?=
 =?us-ascii?Q?0LtrEDAxD+wXrVBoIx85MFKu84WMa16H7OSNYS581eYN4098k71EXDI6Gfnc?=
 =?us-ascii?Q?fsyZVv0yqF16GVJmM6Vw6Ys2Y5Wt2a3PhRt3iI09e0zlFnJqafhNyCxVXQHx?=
 =?us-ascii?Q?Yai/dmgLYruVshAKe2ZkyTbzb4hheDH6Brv/PAAZrH3e7YoOhNV4+wYPjLj6?=
 =?us-ascii?Q?WY1X04kNpW4k7XC/fjhAoJjOjJrV5nhO4hvQC+rMoqFbXpnplvo3koFx5WpC?=
 =?us-ascii?Q?7hHOfvn+5wtwkZiW61zWpD6/biQ3NymaPRO2d8wEscPhyS05cGXO3uVKYv8u?=
 =?us-ascii?Q?8IoGreomHCe+xUenZ7J/WkT3J/bf+xs4w88Np6zTOKBMd7bg5/WFeOmoJc72?=
 =?us-ascii?Q?I6ceZdVEPo+bw1Df+DMNW9dTGLi9rtoT6hoUL9tLwBA0ChR1+SPe4sYM9CfA?=
 =?us-ascii?Q?V7kGWnZmd3KqpiYVhyDsJo0MrWOu9LSOkQY9r6M4OU6KtX9rCP2BgsWcFTji?=
 =?us-ascii?Q?KR4fA/9bhPqz/0X+5mixKH7gencOSR5iNHrr2h28fk2njLjAGvZE/Tgeyl7W?=
 =?us-ascii?Q?3deN2PimGiNFqtfx667CH2Wq0y//9CqgKu+D2Y3wH+4L7/YtlnTo0f9pOpzm?=
 =?us-ascii?Q?hi/Y5xzNAlJKdqBDXn0GW1eiQw4ltI56fooge1oWShnz4qP0k+68g136tivh?=
 =?us-ascii?Q?enzkMzLfA4NMcffGQHmXjYD27M6M3AvLWLUFPpDOrxpcFsDz521iV7ldQ2je?=
 =?us-ascii?Q?mMAdQu+JwAp7lrfLRb1st3OJjzWxicQV3aWXImcGWSYWgj/MRdvm+e+pVmy4?=
 =?us-ascii?Q?O5kxmOX7N8JHtusbzu1wYik9CWGyo5W+C4fYV2xgHPYv+XNMq55C0vp8EEv4?=
 =?us-ascii?Q?7FFahQ9KLkvGBcpy23iPO0nZj8g5ZWLm5MgUBUVH3bcWfO96tYWdM0dpN8zq?=
 =?us-ascii?Q?zDebck3pvb7UWxDm1WWbeBazeNdFbBNiw/ZA0BrrbixwgLqgxicbtqhUytfc?=
 =?us-ascii?Q?/DSO9g94ds9YCYtk5f+gJpc4Ivwgg0AuYUYc8QJ4FIDf98Iw67Dav0KbUr3l?=
 =?us-ascii?Q?hvKqmh+rUGy31hVmWArtMsYVHgp3g37EYitw8aRFGlj+QBIpqZxRvTWikFo6?=
 =?us-ascii?Q?mfEpUCwyi19bUtR3Vl97tI9hYUh3o3Bj0wZo755mfNRStb8C/dS3QFQ/fiYA?=
 =?us-ascii?Q?/xLn8mcn4EdzonW31LhA/v+iz2Ikexb9GR8Af8zJTKY76iP0JSDSXjKG3oNh?=
 =?us-ascii?Q?ePkyGASaZHP6XnpmXWpVrI1zOofjkftjlijas8SKQjqEJxLg+e1XlF3xBFv6?=
 =?us-ascii?Q?1tsMuJtK4koaxkJTs30X7r6T7NxFB6oTg+nDWQK7/hyAV+UzuxD8Vj31g7Gj?=
 =?us-ascii?Q?MlrRhvh8wzT9Um3Mwj/lkVABFH3mrDsxABDhdWvw5RU5Me6wXX6Kt6bCLIM2?=
 =?us-ascii?Q?7zaxzGRzrGNy0G2YTBSZPvfUxajgb4Njw3H53Cp7TxKS355ElkKE7Nb3L/7x?=
 =?us-ascii?Q?5csagaLGeqKHyHSkfIOpxAe+Td66QQnTAguiqsarfVgKlsgXrzni122AoBtI?=
 =?us-ascii?Q?2eLRqrQZmPTkZbMULUaBsnnq24ULF0k5gCvQfsHbgLYh7jrEwcul6Zj9PskL?=
 =?us-ascii?Q?XcPx6XDrYA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4adda35-337a-4193-6ecc-08deb6a8297c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 19:44:09.9691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEk4Onbl+odY5fkSkjSoaO3jifMsktjrv8IolvVm7pcWruwvkv8E+qmzrw0SINH3+MJ6BEL0pYve5cJGzzbi1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290081-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,microchip.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Queue-Id: E24F1598AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 19, 2026 9:31 PM
> To: David Thompson <davthompson@nvidia.com>
> Cc: bryan.whitehead@microchip.com; UNGLinuxDriver@microchip.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net] net: lan743x: permit VLAN-tagged packets up to
> configured MTU
>=20
> On Fri, 15 May 2026 19:23:57 +0000 David Thompson wrote:
> > The driver must set the MAC_RX.FSE bit before setting MAC_RX.RXEN to
> > allow VLAN-tagged frames up to the interface MTU
>=20
> AFAIU this sentence indicates that the double write is intentional but co=
uld you
> make that more explicit?
> Maybe mention whether this is based on experience or the AN?
>=20
> It's going to be invaluable if someone ever sends a "cleanup"
> to fold the writes into one..
>=20
> >  	temp =3D lan743x_csr_read(adapter, MAC_RX);
> > +	temp |=3D MAC_RX_FSE_;
> > +	lan743x_csr_write(adapter, MAC_RX, temp);
> >  	lan743x_csr_write(adapter, MAC_RX, temp | MAC_RX_RXEN_);
> --
> pw-bot: cr

Thank you for the review, Jakub.

Yes, this second write is intentional per Application Note 2948.

I will add a comment to clarify this and post a v2.

- Dave

