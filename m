Return-Path: <netdev+bounces-189146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B1AB0A49
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173984E005C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63B26A096;
	Fri,  9 May 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="spHC5VxV"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2087.outbound.protection.outlook.com [40.107.105.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A002690E7;
	Fri,  9 May 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770965; cv=fail; b=cIHMzrBN0kDRyT85hRTvUNa6FN5fi9Y965fKze/bnD3d37EBLTcpJlCnIbqxpya0LfuIvXpig6ILX3MvBnx0hDcevU/Bsoy7u863K12bt63h+jb6pevki7cQMtrt8Xgxe5oCApxVtgELSUimEi0sCjz0NHJcQQyvoGB2K2+1QNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770965; c=relaxed/simple;
	bh=c5Stb/MZLQrk0D5tXIMbBgbCMHNcMbz9xm1ngm7CLCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gl/dO4BbdXo/hPuqLObHB5QhOqhdfrC1PkSZU/qWCQSexNuzezN9PVAt9rRrDM4qYVr01ErzvU7LNiA2tWNrIM+W5aVBfCf42so+CpR92cDZ0JfAt3vHvGr6osruPf9yg+B0WOG8YsbCxLcDjDWXyBGx0u6kX/E9pZsGKkhcU7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=spHC5VxV; arc=fail smtp.client-ip=40.107.105.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bEthjy/4CGjYK868FexayZjwlWPs+bUFB3rtfh2GmNCi8lOJchTt4AUjHKsL17wcn2D14J9mqPkZKV3I7Z/7CS6XtO9RRJn2O7xJAG16OfbC4/gDUoVoZHNi5bT+FFuc2yYiCclLG4+9AiZsh61ixzeviOJT8F0+SAAcGrRnpJ7V77EDbwo5AfPOktytPeV6zXyDML/ziUS6ZwBl/KCRTSxwrzs14jYash2J1+Xbfmz4jjXEtSCO5ZQoFblgsXiCdCoo/9MuUyNfS4iFbOdlVQ+Xt4cCH5wxzYoXx1+TQ4eDQhwx8CYJLmGSNtfRVHRXlP7DLphVtn2CTM2tbRsDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDokrRmhzZu07iw69pPSSMduM6gkmPUFCD5TiMRG250=;
 b=L1eCeE9UOGzeRuKQf9jYS4yYFTQl8q1ns8H5MK6X7UDcxyEpafpPgotDpFfcHPByqRFjZEBuk6mMMw2L/1boizy9WY5tyMOoq3JdRRrhJ73e0qK/Hk0RCRJQddDDSvJuzPZ9gduv/OBJXsfUJmEsF5xeWG9Vu28oehCsl1AkKPSUao2grGby0ebENF/WZPu8f+3psofXPVRY6Y8Vedgb87N7r2+c41RXHfUd6fEugqwbL7uuc86Uyd2fP+WIwxl4OSzmDqAQPIYvUVsv2Qzq1p3ZJBGhGeQxoqeaRScLC8E2V9XVHGw4Pve8R+Tyoy6pWxJN9SsPCT3VoJMe/uzFrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDokrRmhzZu07iw69pPSSMduM6gkmPUFCD5TiMRG250=;
 b=spHC5VxVBise8h3jUAH+CN0AqM7Cvuz7nVjwqW76cmI0lLbkSIdky676C0VMhk8eerSjIERJqr+PUH2muedR+1QuSpUDzPtjb7p2AEwxS/1aXiVJAonMZmPa0laAKc4yDkV5l/OGJ+9erU/1Cd9IIk9Gon1Wtuu5u8qtE8+R+m5vSLZXa4XvfdPbaKopRQOJlAhgiC6mr2wHLBQF6Z5i1HXTYEPSeCnKEFJE4sz2VAzZDRiSoiPKIe7EggD7WBPyCa16Mg5uH8dsjBxp4uWDWWC/z0JJU8CjvGx3bqbuf7QgAJEqyZROfGuYxfIPH/p1UCtwhU8NDr2h60QeOqoWGg==
Received: from DU2PR04MB8935.eurprd04.prod.outlook.com (2603:10a6:10:2e2::20)
 by AM0PR04MB6993.eurprd04.prod.outlook.com (2603:10a6:208:17d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 06:09:19 +0000
Received: from DU2PR04MB8935.eurprd04.prod.outlook.com
 ([fe80::3a2e:f437:702e:b41d]) by DU2PR04MB8935.eurprd04.prod.outlook.com
 ([fe80::3a2e:f437:702e:b41d%6]) with mapi id 15.20.8722.018; Fri, 9 May 2025
 06:09:19 +0000
From: "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: =?iso-8859-1?Q?K=F6ry_Maincent?= <kory.maincent@bootlin.com>, Andrew Lunn
	<andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 0/3] dpaa_eth conversion to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Thread-Topic: [PATCH net-next 0/3] dpaa_eth conversion to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Thread-Index: AQHbwBeED8Tb5lZS20eY5NgYnSRZD7PJ0VBA
Date: Fri, 9 May 2025 06:09:18 +0000
Message-ID:
 <DU2PR04MB89356DD964DEA8357F3317B6EC8AA@DU2PR04MB8935.eurprd04.prod.outlook.com>
References: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8935:EE_|AM0PR04MB6993:EE_
x-ms-office365-filtering-correlation-id: 4aec6d1c-d957-4b78-2ae7-08dd8ec008e8
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6Gc9Hakw9cZCn/apLAWqsCkX2Wo9Ajd62N541YxxdgZ0kYoZGzV3DCAPz6?=
 =?iso-8859-1?Q?sqgoGe8PrwBHkSR4ImEDZcQV7eUfEjkTO/eL0IAtl151XIGtNyhl+ku8lg?=
 =?iso-8859-1?Q?Ad4gCIq8o1aaJL+Sy+Vp/sgIU6nvuPl3qLCxdsj9SL1dySHkHX2yG4nj/f?=
 =?iso-8859-1?Q?s6r8IjagQSqsKqlCXt8ck5B1HxGp8fylQ8zvcsD8fkljMrEqmWt52f4Cmm?=
 =?iso-8859-1?Q?XuwG5JsLTuWG9dx6W/2vUWjmL4LxREp8XMed9m2jJRr7l1Z10kA+nCBDl6?=
 =?iso-8859-1?Q?r/Ch+IQVJnpQjleI+uEtffhAQ1x31IlhEiBSZwSgXkuAyKGSGX1e6l923g?=
 =?iso-8859-1?Q?uUTQJ4TN8gmVzYRozoJhMU+fg0kqjDijmF0mEDNeJMPQoeIC/EAzvIL9/H?=
 =?iso-8859-1?Q?EMwmq7MWqdY7Fv/QWf2DfjyUvCPclPYmuO7i3SrPKb9IU6vPWnNV5kIW9e?=
 =?iso-8859-1?Q?Nu0awyVt5uyHF0vi/3cl00snV2RWtk02GimuCh+TT3wqGdO2KrXx5M7EUZ?=
 =?iso-8859-1?Q?plJF0w0ZYkrHR3znP+kBEr/SlteUcQoUbjqBghazKXZVGy8WgMJt7j+u3C?=
 =?iso-8859-1?Q?L3SYDilkYwp2aVkoCuEJTyMxk48135FT6tAlmhi5z//sXs79tgCWY1qv86?=
 =?iso-8859-1?Q?GVXHrVZGEm68PASQspkS0QhZ2IPnpwunC1HkAwJ2uys7pRfkuWJhCB22WF?=
 =?iso-8859-1?Q?E0n9ajwBHWD0iZPK5kFtHCUxucTqPOBiA3s/SxNoxYj4qzVS/gK/EL5GdS?=
 =?iso-8859-1?Q?AjVbDNyOtMOufEwukFl6g9ZrhYoLjNpbk5eQLQ64ec5RozdK/FeBWR8GKY?=
 =?iso-8859-1?Q?77gKhqm+CoveeTJWpfxuEl3EegQDaWawNLGqH64Bi9zlWPo1f0EyxL/Tgr?=
 =?iso-8859-1?Q?dSSGgBVEFAkc/nq4ySugWUHqhGtt2+MI3hpzZ0nDJhROCJUeH7ODrdLs8K?=
 =?iso-8859-1?Q?wyfRbeqnd1W8Ec/WS7qEsMltuS+E6XVRF1g+wICcs6oEkBdZwU+SxZtXkB?=
 =?iso-8859-1?Q?efS3DYaxdW0T7/Uux6zJaPBBAC32r+cXWMoqDTx6c/NQFlrKvNA2Rzr4CS?=
 =?iso-8859-1?Q?M9owOHrYtQXHHXV1u8Bngrq5pk7NZCCQdnTthNhEpqY/V77WC0OD0mtSiI?=
 =?iso-8859-1?Q?RRo5CRE4YPtYrspysV+fs5qWW1ThQTAz6O4TbdO6mFx+ZfaVf621Gt8I41?=
 =?iso-8859-1?Q?bRAThi05muiztz9I/tQ08W0aHprrdIKOPGLB+LlIIYXhuhg6UGqXMgBqCe?=
 =?iso-8859-1?Q?61oLRa+Fvtx2uJsZMGaJ+Ce8tavlSJnjEYMP0pW4/sb6fRraKh83cxhmdN?=
 =?iso-8859-1?Q?nIH5m5uv5LlFEip76gVZpnLDJPIcVdzKx+baUBZuK1XZlae70zWfRrbTAy?=
 =?iso-8859-1?Q?NzyJXRmgSnD/NzIhW9LfsD5ENILCbB7r9Z0nhB1isA5fgjIdD7oLXB7yJN?=
 =?iso-8859-1?Q?nWlGgRfnhSNTSqAg4Q6Mq2PEijtOecE2NMOTA7WA5s4IuCT7XU3HdYTHgv?=
 =?iso-8859-1?Q?RPeyDJjvZN/tjxByyIqhKV45l1Obog8qRDZUp1EeTEiTsy/2qavPUhMXsf?=
 =?iso-8859-1?Q?xI+n6nk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8935.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6F9qoKgjpDXUZF5eLkms7FotCUY2exDag9XJGGGFp9qcv8eBVrcz8TMDM8?=
 =?iso-8859-1?Q?WpwjfSbT93XRv6aI3wAzykE0HsqiSXxwkkygqYIys9Klg08aBEsaEB+ayX?=
 =?iso-8859-1?Q?JyXnjxkH99DUgYvu8EjD83fKCDnSKCpXPoggD/iqvVAjxWCrZqW+2EClwk?=
 =?iso-8859-1?Q?ZloMhN3Ok0eaQvuJ4QrE2PBnfa01y5Nh+fenaK/UyZ53sjWUT4pMFR0j9t?=
 =?iso-8859-1?Q?xH7cleXwoXNlJEMdA1Un3e9tBpEy1rjQKjW5H9FWQc3xqrSp/AmJsNFN2+?=
 =?iso-8859-1?Q?5tbl3kkZSylb4eFTUhuxj1JzXiNn+arYBYEs6wiRb64FfroY1JFO0cXpSN?=
 =?iso-8859-1?Q?e9DXrTta616m7EElqkz9vAqIPHj3H3ruhqZTDCBEBKXQRPLloOxsIMmShb?=
 =?iso-8859-1?Q?vejItmGIBb3FscpYnSijyU6Ceg9i5q1eLMb1PQ2qW6+jkEOtFthREpeX/S?=
 =?iso-8859-1?Q?a7AAtsz3geh3g4TjvET+BPmBpInHXcu9vZwz6yWgu4td/7gotyp8WYqGxu?=
 =?iso-8859-1?Q?lgAvsrCjkDghF5IqI2hH7iprdxhcKa4AGpIZ8n8rsChgHyHqbnpEKFKL8h?=
 =?iso-8859-1?Q?H+WgOYnOhtgAsjglaEYXutFYoTrukk2oSKT57bL6GtoCpIY/dD6cNwS2Ul?=
 =?iso-8859-1?Q?ffB0r8Bp7lszDdhmlQp+OHJS8H6+YEScfNGJIxyO0PCbsGpeoYtsa8V7UD?=
 =?iso-8859-1?Q?qYsOyyM4bdUAstQ29tctrZ9iI6+36JeweDDXTFPeRlirBDkY/H4hhs4opO?=
 =?iso-8859-1?Q?294A1vWp8KgpNmwA4XeXUxTvN0unbVTSCuhDRrElrkknLLUcwYvzsv7J9b?=
 =?iso-8859-1?Q?KpMOUzW9eh4t3dBjfKTRecmIWvVKYkgEIGtCyZciGePORtBOO6SL4dcHvy?=
 =?iso-8859-1?Q?jQ1Q6d/ojC6t8ArNO1ytiOwsc7W2FsTbvu5jZKM+VC9Nlqyp5Jnk9iQzKV?=
 =?iso-8859-1?Q?P1lQ2CzM16S+vm3VHsbjuL8Mza/lP3zGfMoDVReID/VqnakXhyt3HrdUXP?=
 =?iso-8859-1?Q?AqTU3X6Kp81GMRt26mre47lX63nkFA5muvMdPKbTlO/zEdIKQC6gMYo6Zp?=
 =?iso-8859-1?Q?GHvpc0IFF86x/BTQbqkiDJroYruV6oEhSlpo4W6YWfQnEe5+vqAuJkOHfi?=
 =?iso-8859-1?Q?aO4yiB6+keiAvpxMnTp6LnnMrKKonl7w0Rb+hltpKVwmtp9q/TS8Cm8rnU?=
 =?iso-8859-1?Q?4WkmGFbv8xDntdnMSsALT2+NKwNo+4IiGXOKxgdYabhZZxLOh7B+pOchqg?=
 =?iso-8859-1?Q?g4tY/FMaCB0tJd8wo2n9I3GzQvREnz6y91GMAXBglETsHM9Heo7AaecLBI?=
 =?iso-8859-1?Q?5+KJahC5oiTk5Qs0XRBbt5uEQXoCo8ZnsDh81QjkWbJqJmm/WiM9IXR+yo?=
 =?iso-8859-1?Q?2x6gHRWacducv642aEUsIBK7aluMfjgoXkQdJxOV2ZNwJ5il6ZAAa0XWKR?=
 =?iso-8859-1?Q?CTgLNNGXz+xs3KJcR+hASU/kYlpEd5M8xCA9MnnDwn5OGF3mQswnGpiboa?=
 =?iso-8859-1?Q?6U5f4nRvds8TQ3O4JHHldurfCvPZ9PcAkwvOfqc0TVC6DqpvzOO03IuacC?=
 =?iso-8859-1?Q?eQy4XaEEJyHcyyP4EtS8bRlSEeiEt7iQtpMrfwmyVv62YkIdkg95im1e7P?=
 =?iso-8859-1?Q?xXGxBzi+j1pbKdGPQ3/oEbsT8uNzIsGBxH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8935.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec6d1c-d957-4b78-2ae7-08dd8ec008e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 06:09:19.0286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rPk8QATiGF7Hn/aMtRft7yeK+lXV4ATB5tAiwmgD/+0NYHVCVYJVjwd/vwrLhZTdmtn0C9VFvkmANXEw0v0DkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6993

> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Thursday, May 8, 2025 3:48 PM
> To: netdev@vger.kernel.org
> Cc: K=F6ry Maincent <kory.maincent@bootlin.com>; Madalin Bucur
> <madalin.bucur@nxp.com>; Andrew Lunn <andrew@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Richard Cochran <richardcochran@gmail.com>;
> Russell King <linux@armlinux.org.uk>; linux-kernel@vger.kernel.org
> Subject: [PATCH net-next 0/3] dpaa_eth conversion to ndo_hwtstamp_get()
> and ndo_hwtstamp_set()
>=20
> This is part of the effort to finalize the conversion of drivers to the
> dedicated hardware timestamping API.
>=20
> In the case of the DPAA1 Ethernet driver, a bit more care is needed,
> because dpaa_ioctl() looks a bit strange. It handles the "set" IOCTL but
> not the "get", and even the phylink_mii_ioctl() portion could do with
> some cleanup.
>=20
> Vladimir Oltean (3):
>   net: dpaa_eth: convert to ndo_hwtstamp_set()
>   net: dpaa_eth: add ndo_hwtstamp_get() implementation
>   net: dpaa_eth: simplify dpaa_ioctl()
>=20
>  .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 41 ++++++++++---------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>=20
> --
> 2.43.0

For the series:

Acked-by: Madalin Bucur <madalin.bucur@oss.nxp.com>

Thank you!

