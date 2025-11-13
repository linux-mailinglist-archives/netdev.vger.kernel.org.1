Return-Path: <netdev+bounces-238175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AFCC55463
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4C204346CB0
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2E299924;
	Thu, 13 Nov 2025 01:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mAl0hJ1Q"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D0296BAF;
	Thu, 13 Nov 2025 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762998020; cv=fail; b=c6+LxTWwl6ACVET+3Y7/dXmindUc0eWmjQUVMA2wg/GI88NAIzreygXbMhyJfzeHXBiMsZE1lyGWMKnLdeYPrUtBi9T0SPdzq2nNXCCrthcC62Hl4npVm+Ddwah0kbZwyFwondI8COftA1Kpn5YYf6HDDIkBHjqyCCgdc/9qGi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762998020; c=relaxed/simple;
	bh=PQGYTW7SjWeaC0BHwTtjW6HXLOy9qw5mPf/X1No5OGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F/LBAHglpsrLJMb1njPTKBAMtXkUhlrBJ7kcc/7MY9AVO9BcGaHpwsDoCk95n+JEeIr2bETbs8YwQ9EmVKehGujDLD2IOAIqEJyRrmBkL5S6wIURpl39Gd4qhkKMA8qK0WWgllY+AsnNek7BQ+yr+YEQY14XonEjTBgqma38bFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mAl0hJ1Q; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1eKgxG6PHnpgi9+Crzj7D/6bjpiv8u24W5W3VJTB7PHf+Km82UxRpOx4SKhrrgQJ5zMsbPX7JWMEY9MsR28+Jp6156YdytHBSoWheFjVPyw5tf2/JN0+CPQ3Xxwwe8hqTz87NNQVXV5pi36iRQdCGyDoYWgYpL+/qs+CwZLGz6b9kO9UP/ZRiNYfFmIkCeds9kv5ls8PD9Ws+C3ddkW8H2vVcUWbMmC1SV22YE9JAeRthG6OGB3ytnuHoiZuKsUcGqIfm/50sRqtr9Z9O94qF0dFwn2VQbv+OHkgje0M0LsuwL9EjTzH9oI5idYF49wHOckhQgZyBStNXznTKZY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQGYTW7SjWeaC0BHwTtjW6HXLOy9qw5mPf/X1No5OGY=;
 b=h/fGkfX2S3Tu+BHHhCRD0fUc8ehvyjpco01sHlm26Yns2bCiAJK757V3kDrbSJZnjWpM57O4muzHD9xBkEYsGcBPiycBp3a5VOYwKQTWdSsbHV9CeqEXxO+lopymvbBifmHYrTK5Vln73Odq71hWbn4ZQ0jGZw4k/zuIHYE2Wv7Lx5ilDI1Ls6Uu8KbWijlkETXV1Lj4wK9d8Nk+kjyFQGV+sNhTf8sBg3Ye8+r0ZHN22CdYvIv3EGS25dPW6/f9HZEqthLL6Hb6Mo1P7an9nksoaTKmPZgYKd4KDnqcrbfZI22135J2ttzcY1kOEAvQmlPI2yP7ZweQK3WOyqnnOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQGYTW7SjWeaC0BHwTtjW6HXLOy9qw5mPf/X1No5OGY=;
 b=mAl0hJ1QShXY01hwRpYlmnC2Bwrjgqg31gQ+3AD2o88wS0uaPtOEWCeUgfYBM70kU58AShyf6pr4V8CcRkRZ0XwiliA0ps39IezjXWbEU18bbD/cCSRGteTiCFEQBMwd7NY0WkWz/w8QP0hgTHXTl59Sl6rZwt62oPzBID/zsLKNpQ+AX7z5CSqPdUdCskAbZmXV0z0hBkyq4OOLa7j996Vrr0juieJZQPbO/qyD+qBfp6nbKfLoRctZrHnzSW+JL/nJ7+LKaqroBin2lRsmZo41E1sj2NzmURqIzDlNn+TjF64gfc4dBngd0+pDR3nHEKA/VZSVMajafQwwJMkFZA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:40:15 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:40:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Topic: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Index: AQHcUvIMuEthEp4yc06FM8zZbactabTvfvOAgABW4jA=
Date: Thu, 13 Nov 2025 01:40:15 +0000
Message-ID:
 <PAXPR04MB85109979C5B15727F510F87188CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
 <116fd5af-048d-48e1-b2b8-3a42a061e02f@lunn.ch>
In-Reply-To: <116fd5af-048d-48e1-b2b8-3a42a061e02f@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8564:EE_
x-ms-office365-filtering-correlation-id: 8fb40732-4226-48c3-44b2-08de22559862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1LfdzKv8HT6+7bRvGRqXZwAQ3Dfv0EIz4rmWqSDYqS3o3BcVuiZs/mVCkQ0d?=
 =?us-ascii?Q?pUyg9ZqoOjdxls54WKzAfNfCXec+63o2fZK9owUhKZpT36h2HjJLjE8zx5CT?=
 =?us-ascii?Q?eYElMZcCyZ+CkYWgu8eNjmDrF8BT30osaQMFDLQzgT7Pg9K6U0an5aevK5+4?=
 =?us-ascii?Q?NOYnsMzv8yy3HG9NuEgifm4i06T87S4tr/U27hJ9yA1yxbSwUCGbvnPWFwiA?=
 =?us-ascii?Q?08InzyY9JNNDtl81Enfx2ktpkNpN7ly5GHdeag+KKbptbniYP4KHGPUya+HN?=
 =?us-ascii?Q?1ntv5/PCiYgxy8FzYdKNu5lYmrtNJWEDuHK2Tv4svOHiK6W2fxwQANadeQ8+?=
 =?us-ascii?Q?UIgwdvHGv4ikNlG7vPjSBRaKcvv0f9YeGwuKGrN80TgfO/Z8llbnMMhTVagP?=
 =?us-ascii?Q?QIiouuZmd3hpwdBZUWJrHUe1Yl01ukEXWKLyH03txEPzL6GB9c78N30Y9ILy?=
 =?us-ascii?Q?LX7WImUhM1MgLJi3OJd5i3XSvnNurQDinUmfY8G5ZDHR5K34v6/2uVk2bK2m?=
 =?us-ascii?Q?xv+jMIQLbgFt7YM6ozqmwTQSzITtDZM1bozfcMLMI9w+6nvJsQYXouag8cmD?=
 =?us-ascii?Q?8e/OuWAR0h9kJd/MZz1sfiRakmlxocFN/X5MuE1IUJAgMt8FmXV6iVdQ8b1G?=
 =?us-ascii?Q?D7P2js8Qhcu0hWFHasCdeEMAIuDk/zuSQtcJIpwDmtEiDUJcrEYTdb0fSJtt?=
 =?us-ascii?Q?IDBisATKQyVMXelWbEmuV+hEUz/MNAWC/VPe5y3H9wwNmXOKDjtK6v5LDiu6?=
 =?us-ascii?Q?y350zRozHNQUrdop3KVzmC+QR7g1naSyu/5L69Wq41CFn1eBoQ6gK1MScRvW?=
 =?us-ascii?Q?LFkS4gLc/1XaDxS3OQParh6KKtEL48jfNGG2uCkKhKdiFsw+tw6Odc19p1fP?=
 =?us-ascii?Q?2XNiDlSxa8D/wrgFCO+eTfML7Gsk5RO01xnPOctvuCyG/VXxjkiklXsKyDXa?=
 =?us-ascii?Q?uY57QY0lIqeKAM8OlOvQ3SLISjyoDtgF9UqnoD6G1alpCs3ruY23oXb9v8fR?=
 =?us-ascii?Q?rJ1Cqi35odMHswBkDUALHRp3GhI2h4KGknoyldS7RwcCGKGDrZScG4gwnKjY?=
 =?us-ascii?Q?QRh9mZoEuoycoJTZa73ehsLm6+kCw2l+sbD+2nBNUQNS21AydxuoM3obq6Tc?=
 =?us-ascii?Q?9jx3hPTKywvx70cI1hM07SutnYkqZgJsP4EED/JvrKvphAFjRut5OS6EH6/O?=
 =?us-ascii?Q?6ugo/trjiph0FzIuwXL9dFUQal/cKv8J4mWyVaLn41/h2Rc/mMEdKrlYsK+S?=
 =?us-ascii?Q?LBOGTBSsV7+SYOKoM+5wHqRr553FBi5OxpG8n/v2yFooH8kWBiPgFd9yhNLm?=
 =?us-ascii?Q?J1Yr5hvHrh1kRU5q6TWBJRl6+kJUskfelcfYvwIoRlq7apG3TYWLJjjOBESf?=
 =?us-ascii?Q?t34dZ9SKVsCGpMJo1+vhP7gJk+8iPs6/+CecoZ1iRR1y1+bI2nbVawEh6Ysu?=
 =?us-ascii?Q?XCZeqTX8nO3A4fYtHHeuc3hChRNVNCI2rkObjUxnQP49A3Mvm2lQgOD55IWd?=
 =?us-ascii?Q?5XPou5bcU7bihSxlrsbunCfjAicvMXN43ySk?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PGijoUPozSnYPA5dlgj/KHw9KOQqXjJb6z5FnZHuZkzhBnRW9kKXulrCJ3Vt?=
 =?us-ascii?Q?VR38NR2MIKNWTnTDBcrbNefw6zG82P0EePrbjeFqte6Yx5b9ZkrSxhenb4mS?=
 =?us-ascii?Q?LW31j2nj1hXlJ7RxM51kSxDSsnyBmVGAGl9t/6OlRhvk6c9BA44co91Umgc/?=
 =?us-ascii?Q?neeZjyRiE8AYIdQkOlITlZr8JusAAPOBDQJCxmvKQODq1O7dXrzUG14OIfKK?=
 =?us-ascii?Q?0R9VbHIDJ/dTcnTkGghT18JEE8bkM+krJVktCewmJw7hDlOTcK9CL+yCYjpv?=
 =?us-ascii?Q?eL39cMrpHci6ByWtgQuM6fHKWywRlpBEacgWIOd3mFSkSyuByQ+appgr5LF1?=
 =?us-ascii?Q?k5OZpe8WVK1MHGHkR+KZt095WZ7M13fdfUewAsUDd8xhxglrHTTdPN5Ht4GC?=
 =?us-ascii?Q?HTYkH9nViQpFMzXBTLh91WhRhwHrqtAhxMizmiBIzO5pFBtmrY9r3OtorHs1?=
 =?us-ascii?Q?e6KyDFIE+Yv31panFVdCRdi8Tov/QtczAiBLElhA0pfmh+gn2F4f78fXvvyz?=
 =?us-ascii?Q?fo+TWOh24tCYP94XUD3NxMXKSjqukqzoStqcZBQsPJ0eXJN0IoSV1d7pyqFu?=
 =?us-ascii?Q?YbNy+56LukgtsUEIZJRRzBGRyXbPpP4Dcn2YH9+h9w9gr3dii0K4Oidv9ed2?=
 =?us-ascii?Q?XMYPdxDP6wrWgnKkfcDCqGhivxtIsW80slIa1bpNJ7lzmu9vNuP92vjdkOpZ?=
 =?us-ascii?Q?TRzunDZQ4t/9Vvzqlp4BO4yPhwxHTnTHP7n1pWVph4QbREcs9lR8UKFSIDj+?=
 =?us-ascii?Q?9XAX018NvvF/Dkf9M2X9XVK06y3uoGOmVKR91nPonLlrQzZl7OWF/U0tCZQK?=
 =?us-ascii?Q?f2uVZj0wZ+LKad+RzYWlLmuPEWrLckMXr2n+k3tuw0mXxKAlWeFmLAlDveMM?=
 =?us-ascii?Q?u7/dfadlfC1GcqbM2B7eSC93cy/qOQTsRj2xjaT1aidZn7btEfXbYekM7VPo?=
 =?us-ascii?Q?1nIIYAnGOWOSQbfyQeUTV4/Ajp3Lbh+dDohqCeIQYVxg0JSm8aIJqy0GTBBR?=
 =?us-ascii?Q?unEr2i0v9YWgzt9Pk7H9auaH/YiuRwXT7gknHg9Rlu4iHXfJObKcdbJPIHMF?=
 =?us-ascii?Q?HsdVAhWh2excxE8iR7oYHKHc0z1pokXyQ2eVTwcYISlYUeKaB/QneTLPT3no?=
 =?us-ascii?Q?jnQ7Tp0BVWBvPTtWes0zBjTbZ1veSkkhXcDcWSxpDJppaOgNYpV00etjQwvU?=
 =?us-ascii?Q?XrJ2/6ipmPGA9eaK4RDDLzUUaVBJoxDPAXCbqKHohs55FxERNSqmi7eqjHcr?=
 =?us-ascii?Q?hTJazpbU98yEl3WfdEnC5KCxWH35MDY99wRnrkzqez/5xS6oAhh4Qqx7YkTo?=
 =?us-ascii?Q?FIcvG2mku85AXPw8ALpCsBm+LvE18d5GySCTNsCLPQT9vpaEmCxG+QsL3Gxh?=
 =?us-ascii?Q?S1oqP8Xr9RkO/4kSqhvOzYRAwR946C9xR4xfmIacKgV/3Onxu+ga5Ov7XKGx?=
 =?us-ascii?Q?OO9Rh88J4bUo8TPLRlao3L7jRYZBpkyPeErfv3Xcu6QB4XpNnzArVykoFILb?=
 =?us-ascii?Q?G2y7Frs1eEquj8tSiQmy6ITQDBwMKotkpwB7nQLzuEgrOh2ib26pFd5MjXlw?=
 =?us-ascii?Q?uLQRzV/NUUBCyrn3/OU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb40732-4226-48c3-44b2-08de22559862
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 01:40:15.6739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ws6UdTayGBwvOKxEbgsl140+D8iqUiaejxbHvX7Zp2HvqnaVDbYhSwwY8nDMACPedO6oolE9pVCW3NBrU5zLdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

> On Tue, Nov 11, 2025 at 06:00:56PM +0800, Wei Fang wrote:
> > The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec:
> > change FEC alignment according to i.mx6 sx requirement"). Because the
> > i.MX6 SX requires RX buffer must be 64 bytes alignment.
> >
> > Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
> > buffers"), the address of the RX buffer is always the page address
> > plus
> > 128 bytes, so RX buffer is always 64-byte aligned.
>=20
> It is not obvious to me where this 128 bytes is added.
>=20

Sorry, I misremembered the value of XDP_PACKET_HEADROOM. it should
be 256 bytes.

See fec_enet_alloc_rxq_buffers():

phys_addr =3D page_pool_get_dma_addr(page) + FEC_ENET_XDP_HEADROOM;
bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);

I will correct it in v2, thanks


