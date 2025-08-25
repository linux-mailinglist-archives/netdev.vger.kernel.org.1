Return-Path: <netdev+bounces-216347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B943CB33398
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E66E7A8673
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 01:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6A3215F6C;
	Mon, 25 Aug 2025 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DXa56wYt"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ADE18FDAF;
	Mon, 25 Aug 2025 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085778; cv=fail; b=k+fKS+5MkTumrlsiD2TFW55b/BbbHM7qwEprsV95cOGuLv7VRgz5yuPDqAHKrhu+RIrDGXH3DbD4B1gGi/fn8hF2tITwnIryqoSLvdkx8G6fcDV6qKHihTrkuu7V55LMBUFJj9Ja/HZ3mms+LxXYFSuijRynKgxODBWjhTxTBkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085778; c=relaxed/simple;
	bh=fEh7pVWyOc7TFg+0Fvn+qQtVQ0fq2tN5mxVSh5OF5Sw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V6d3ah0WNj5yRoA1IGhO3k2CcgD8vOU2nAcJOJBIBMAVMJS0lAwdlDiqpVXZGfaZ1mw7BW4WfhCUrKsGNooIkqm0gef6IoJhzkC73drApDTGcU518wdQ03XyfqMSG9+0NtQt9qeUuZa34e38r+6T2LUKcVT/tvy5YJCAleOhIzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DXa56wYt; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXSX4ymK21X0GApf7jd52fD5gEjwxN6nqsN95sSSchaKD1BzzY/SJfSWmx4zHbgpTaxQkd/s4SgrZ6wHlHL8JYmx5GG7pAzRiz+p3/QvQ/UTIa/oDqekSH5PzU9eLghcKovGvz1k98jhCbqk47M5QRGWrC40W3aapE1xvgRXe+96cqc/ySyMNdDBVjWSUNDatD9RVwhPU4aFWJV7YUzZdNUtZ8UKVqgqXRjzam7+DMJ5AtW+9+M5pFb7w97g+hcSKXM/mNNStvIoxuGpkFn48JxBo48Duc1tz9HCyKtNVc5xGqm9LHOHHNdYNh0t0HQ852ng0w5/uFWXwS++4Hudtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uaKrhXlWcufKkyU+Jr84iy7Y6JnYTJNoRKkfdhIoMs=;
 b=QzLRSWocAEE+eQCJPvh/TDj/HNgtBRnDyoPz6knMBM7y9W0nffK//lgCkbu92MHCwqve0TwmNp2p44k3uYWpeDoU74QBaEfKOWuAAwavONqYVDcKFCTnIV87SBzQ4/7S6bxjGPZYMWRMLFX8SithnpZL6ZzXigBZ9aBHsha0AIcp49sMPSIDTFDGIKbvFBAeEn1AJ1xmZkXYyE8PzUkzyjR9dxqsCacgpi/Og8LDt0QaFC/f3Sc7s7VRAB/t7+iDx104xf8BHP+MeLUUvEC6Fc1F34BvVoPqTb57OEv3hZzeKF0qW4ASCGrl9UbnV6m3DgGktnZou37izqp0FqNXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uaKrhXlWcufKkyU+Jr84iy7Y6JnYTJNoRKkfdhIoMs=;
 b=DXa56wYtohNMVNr4Uryazq6tEAuD/RXsvZEQwkF3hQpRg2Rc9+nHTSOBdHAKHoHJifobmXV/h8CPeXoqxz8Jfr4EYJfavceCzxrHrlVHMdwxQTmesVBVEFdDzgUDBGDYPKsZPM20gU8XIZT4KNH1FM3wSttXfrrFhPesy0BGrODBD0r5tTERqPuHJHQ9ssJ7lBmq3xUqsxTUfNIN9ZFMWqKWfLm6IUk5UtZ4YC9bvbrsc0bCFCXZnOeNqBbd5IV6oB42iKiva/F/+JJVCqhURM9/zQeFoBaFWcgxjorTS6GZkl41jrVJgwfvBg4mzANTjiCUxNjwPB4HdN3d7BLmVA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8259.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 01:36:13 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 01:36:13 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso1Ue9PAAZZWkmtSe1X7IJrlLRuVqwwgAIyggCAAhIy8A==
Date: Mon, 25 Aug 2025 01:36:13 +0000
Message-ID:
 <PAXPR04MB851036E98561133AF4945FA1883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
 <PAXPR04MB85108182AB184083B5F32D3B883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB9185F42CDE16107E3A29FF0B893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB9185F42CDE16107E3A29FF0B893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8259:EE_
x-ms-office365-filtering-correlation-id: 37ed8f22-d419-4a47-667b-08dde377c6cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VOWQLB2AiR+nonKs+tvxatCUTLONfqsDGjlI1/wJ9+nCGuyDb2icBkfPteTz?=
 =?us-ascii?Q?gOgPZLhXEt7qZt5Pyuv/KwdCuGqPnXkySvG4aG7loYeUhbsOG7lYUf6OxGvo?=
 =?us-ascii?Q?37KmsRLsj8dN48D5YpHweumqJV6kI5oclnuZepjU4Qy3kkufUMpJjhg2OSvJ?=
 =?us-ascii?Q?XdgNvEqZcCAzDitfQ4M9b86IHmCtM/COh3Rbr7ZIZcn9OWpZsGzOJZQOm+Od?=
 =?us-ascii?Q?0cADr1saxmxWJNEwMaUpGKREK26253w+RLlHXtjYY3pkGKPDDmlKQ/skuKGt?=
 =?us-ascii?Q?bZGgoUFHpJ2M/pNNkde/XCmtMwEUCvMEqmtUqxscS7kaeFCHF4iNX/fauB49?=
 =?us-ascii?Q?BFshh/JU7DBH8+OGDw91jx0C6BI0uyCwBIDTOdki0aFhw/HZzPvZXIcYf0wB?=
 =?us-ascii?Q?KK0YF4xug0F2oKoWxJ00IX+0ryt/077wmYFKXqi76MmnUJRa+E+5YSx2GUbx?=
 =?us-ascii?Q?cYpBxxd4tie7i7rd1YMN6dU3TWnY5ZZ0bOzhJaRQOMelfHS4ypm1Uslc0lU+?=
 =?us-ascii?Q?ddECJp303ttvHm15P/iFskN1DGz4uxA7LqfJ9FDeQTkPh7+/9PQW9YOMSnot?=
 =?us-ascii?Q?VagPKoBkho3qbysv2yB4IxIokieEpC+HNTK6boEWeGaPYPMSkKt5xR533nfL?=
 =?us-ascii?Q?4zI+uGVyJvkHMYuW/0S5JA6ey002URmysKMX2WrwiGbS4AxvrApmGerddStf?=
 =?us-ascii?Q?5buRrASL0AnRHQyGTlfpSVoziCAzUODvUlX9uvHz2/J3CwjOgWz39qjNq+K7?=
 =?us-ascii?Q?umTdLc7PBeVmPwY+5gAZu+UXh3BbyzfRyVlCzN/wjrd0hhKdNlb/w/iaqd/I?=
 =?us-ascii?Q?/csz3USYaqE9TvQSD9OM10IF1hcE9bbZWizhJm40WPmzhGPMxjdcTpMjor30?=
 =?us-ascii?Q?cF7ZfA5WKM4v1emvOXMBDTtM3Jph92CWsrVgRWYqp7NJj+/5vOlVRyr+cp5Z?=
 =?us-ascii?Q?B2JUfjyysXLBwZAIE/afcBsjYJ7g4o4YT+W2G2H0dnXbCDK7Djw/G8QPhQvu?=
 =?us-ascii?Q?HVA1Izb3OYgQlIsZkqd5g40aWcW1g3FMFBMJNHVfiQKV67fdum5/e6fC7D9w?=
 =?us-ascii?Q?Fo2ygUWk33d98ovu81H4pHCSfaCKkPQ8vePHXcfBsfSYnrBjcuI9IvVikmgU?=
 =?us-ascii?Q?OFeS8JhEq3VrmH5kmqwm+/vFNiKMZhIFh4rB2jwSR7EkSLl9aaDEgUvA8Q9a?=
 =?us-ascii?Q?W5BsJKPw0cQdRa0a4s4qg6U2gAaxV6dDlMKI3GT1leZZgSrfk5KZ59P6at/W?=
 =?us-ascii?Q?yuqsqGetMlgEr7e4a409e/ZtCvCPeADTk2lhxfIjoiDMYnJvNt94Om1afwcE?=
 =?us-ascii?Q?EzMxLAOi8D/h17K9rG9AoOIWY5/hj0VMEj67vf5XY5jQPEOeHWHPUNwrN0f8?=
 =?us-ascii?Q?HVsS83etQ7I/JKi6YyA4nFBsbnwuhl7RqKGuUznf1aKmil0yMxMzwfzmDgZF?=
 =?us-ascii?Q?vvA/EjgfFNr8p88d+67/YE4cBGU4GBdkv/ki9L8n2REydK8kMtfElg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UZymOqi/QCGOMRysm1YH/w5XQVvZ/pnDfSNYiyDKYdxs+fHZf1HA4k8xfOVi?=
 =?us-ascii?Q?TQOgU1arDywDaB6UF/9K1tvsTsl27SWk2f12FwoEiY6cNDm6FcVCJAY1xJ+T?=
 =?us-ascii?Q?3nmPHV5InPy3c+RC6amZHPl0WlVs6BIe2mdNRRVhMv7uWOlCq0BoSvqH+3YB?=
 =?us-ascii?Q?1R4hrOxDbWDECz2hYdkW8xEQ1FGrPKh8vPcqER5L8VKgT2kPkq6PM7RdQaGC?=
 =?us-ascii?Q?1o/WWZsbi/jxXaJmmmzO/7GZK31NyPikRSjGvk+WCaJ2/3oRINPuk+7HDpN6?=
 =?us-ascii?Q?dfoNj/RDgXpNAldBCekYGywRVcUxfcL7eq4R4YWGrybAM1GlaTfLm4FEAYEG?=
 =?us-ascii?Q?J/Lz+j7HmtetnlKrEuA2v4ULI24b3fPjfC+Y2+YZpwblun5da0uY8ND3MQiC?=
 =?us-ascii?Q?c6aeP3gng8JDYt9CFdnAQ4DqznylfDaeRi89FpOTMUxPyLxcVwF0RHipUBFp?=
 =?us-ascii?Q?lIFJGYJz1x8bmBBs40o1Z0pRNIaONCtu5bRYQd6UG92pqo2AVj9OY5j3yYsg?=
 =?us-ascii?Q?8hz9oiRWkLNjHh6uURB11ta5lG3Z91bjZFGR70V1tmDyy9CKNQp9/SEQi8Qt?=
 =?us-ascii?Q?wf85pvpwiMRcAsl+hTSEAach3TRO4WyNC5UuNrVeWgus98QZ6/sq4w3lx/b3?=
 =?us-ascii?Q?acpknU8VIjpjLTdeKluBmOjiR9qNK34TCr3se6cWz7YiShfPDy+ofu+mV8tG?=
 =?us-ascii?Q?pnzt6rxBp7LnNWzMBuV5cuqXukqthK5Y8KUziAtGic8soUMbrg+szVkkpbM4?=
 =?us-ascii?Q?CIMsR0k6coINTixUOT7GjT/G2H8nWzaCyC6luQZdu0K5/d5XoButHxz4LhwQ?=
 =?us-ascii?Q?vD1BS74XhRio3jA2Rz4a4LA0+Z9OZRSCKFzQh8v/Hz4rTxdLtl/GLCdX4AUN?=
 =?us-ascii?Q?dZsWBM6W00GQXUonF7sTCJFjfcCn0PUUTz/qN/6Ftm+zmbpfm8a1NKrmsGd2?=
 =?us-ascii?Q?XMJvnG890xupC2PBpnAT2fiLJqKdSkXZcb7yQmImkEqUHknwsNvR9SgT3BYi?=
 =?us-ascii?Q?feFcRaKvNNLdVnnEgoFB97QzmbrskRfNCpD1FcN4yasdmOwxksujpkAcpzc+?=
 =?us-ascii?Q?JdlCLw6I+Kf/E8bNpxRDBiKV8tOJOq39ng2TfMXQGKZVhRgzUb7JQ0ETDKIX?=
 =?us-ascii?Q?vps3T12hMTqso293sabMyN7qr6qe6kwllyQX1HA6qquewx99QZFXwdoRuXu3?=
 =?us-ascii?Q?lDckuUdGlc+lbCKVXUc9y/cv1ykz4AWmh5AFZUdOmetqBn0OI/z4GAQKkGlK?=
 =?us-ascii?Q?GxGAOgHp1YTBrzCeyH7runiR0OZPpyNA3czGhsc1imDSuJ8jirGRfjjLBaAA?=
 =?us-ascii?Q?MYaB7NgV9fDnfaQqgEO88I3FKDFB3rw8OgyIGzzfGMsepH7XORSn6j5yabLa?=
 =?us-ascii?Q?PQSjgYz6Kw8RYGquk0v1tbTYG//wYUByor4NU7wxFbMbWywwt8+TY5QsaSpa?=
 =?us-ascii?Q?u35968QMjOywc1AYVQ8a+jLJ3hEnuwHVbEmYIJa2xhNUlWbBUCC+T6SaVnrk?=
 =?us-ascii?Q?m2B2HasIrsA6J/83x/OaXNkShyQaFGjBxbYfi9GdqEYU6lboPm5DvYchUgMb?=
 =?us-ascii?Q?Zk0PPgx19YEDyfkwz7M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ed8f22-d419-4a47-667b-08dde377c6cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 01:36:13.1888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gKDwJ+zSXUax8tmK16kFQXIS51anaIcid4aNbBaptCsJ/fplphE+F/osqTNyhcmlL468W3yvHKWdAE8fIfDYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8259

> > > +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> > > +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> > > +	int order, done;
> > > +	bool running;
> > > +
> > > +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> > > +	if (fep->pagepool_order =3D=3D order) {
> > > +		WRITE_ONCE(ndev->mtu, new_mtu);
> >
> > No need to write ndev->mtu, same below, because __netif_set_mtu() will
> > help update it.
>=20
> It will only update the ndev->mtu if the driver doesn't have its own chan=
g_mtu
> handler.
>=20
> int __netif_set_mtu(struct net_device *dev, int new_mtu) {
> 	const struct net_device_ops *ops =3D dev->netdev_ops;
>=20
> 	if (ops->ndo_change_mtu)
> 		return ops->ndo_change_mtu(dev, new_mtu);
>=20
> 	/* Pairs with all the lockless reads of dev->mtu in the stack */
> 	WRITE_ONCE(dev->mtu, new_mtu);
> 	return 0;
> }

Oh, I misread the code, so sorry.


