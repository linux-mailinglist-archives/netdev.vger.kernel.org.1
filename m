Return-Path: <netdev+bounces-209593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A267B0FED5
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 04:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D785964830
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EA31A0BD6;
	Thu, 24 Jul 2025 02:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JuVe4/Ob"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA3C13A41F;
	Thu, 24 Jul 2025 02:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753324572; cv=fail; b=Lhf7eNw6s1HZ+ftUsJZEQmv7UstQXy6WPgBwPCSJy1Pm9YvTIPFYzkTg66FOd32gYQqbhlIVk+XuBZruwxHzGTDJnsWYgXXgzt/9uedZH0gY7wRkWDbYnhdqUKyzj/BxkGLoxo5d/h6mIS0gwz/8m0ggyM07/81TZijGy+LRP2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753324572; c=relaxed/simple;
	bh=wMqPH0221yhberMoW5veGvRlFfejuMuJB/HpRAg904M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bk9jY47qTY0z9DmE8waMqlYhDXQsqL5mUjIkTc1pgfQlM0cmcF5DqdzxpkhD24lDk4sabSHWLobDh3AWl0yFon9KOJAhqDZpfqFQ2jTZcpHJyosBCrivbyqJtLSosa3P7Q2ByKw8ck4EjdtGZVfIlqTRa9q8MymBLDJOHHeXqtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JuVe4/Ob; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAp+TGCqYulA6aJfZRqYDN9fOLXAW2+vUj9+HpJlWlJo9m8VIb/mQMmJoEFx4xrVZ6iRlqzK5giNnUJ/spvOCDyTnDeFQw5zdGKuj25NOywTRl6TcEZhT1Lq87mUXQKfQEwZ/M7zPRQ96o/RlROAw+ocG0T3ZwkVMqXKYBOMX9MceuyEZAfbRYITDRp8jGR8KJgIwgXJ8uA36IiyPG9LA/jkqfI4by4Oj5xR7VLuwB74N4x/mP72HPe1gvRbg+KTcdAT/TM5PeD27iG5cwI51vog1uxrtuV0l8jN6/aj1XF7kk6lwJARhbHDrrxHak48WaBiEbB5swz2gyGuDtIWRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yieAe8N2LSJzJmlznwz70T+DF/bTtz1pv219vkD7ARM=;
 b=iRzHApIQy08yKCBjDnIbR8QLHYkEGuz+qTJcij72yEXp1UqMxak1E/hDwSOrlD0tBaacZI7q6nsnirglV9Bsol4DFfeyVWwuTN9SmQwRwuJTpVT1+LJHKxkr1RxM/Z6CmXr0JxQzsWadLll5A1Rn0MXKjogRKkvWvu+Gn1zDMLCYSEIUmvU4vH8l4De3jBcVTBv64QDbMGQp/ZKWYN8iPwKFNU81FTCEdkCGuW3JiqQ+DiSE666Rance0SF+E0DwDHDQj15ItSABAp0uawWrJ93LBkl00eKUjdGiP7x4ruBYLcUNqcLKdkaC40Ubzdqiisa4JFZNEYx9VPkytYIrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yieAe8N2LSJzJmlznwz70T+DF/bTtz1pv219vkD7ARM=;
 b=JuVe4/Ob18z20LnljHzNxrn4HnMx9f+zDWbB3mw5dpQ6EEz1kWsoSKn9YXM8NKe41BW4yU7ozTW21MIsf2RTbHhqK8HHQbbpZOgSAHLEVYKMNT8pGctUjL2cP69fpHuC7KF6SQZqflOtGhmwhAsoQltoFKi9xRSAY89RXe4fk/i571lbY6MIZ6wZO9hS+Btb3LfJIo6vOjDetZ0zuvnZUWFs7YTLkmZzXWXuwsgyHDCyXMrQyNkrazqqpib0yLgGkSn8qUlel0MT0RIaQgbg5Mx+Nz1mpCdqIffVRiGWb+goNgmL5MCgteKhlv81muFksF088+TxfatmurrIZfF6fw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10782.eurprd04.prod.outlook.com (2603:10a6:800:25d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 02:36:04 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.042; Thu, 24 Jul 2025
 02:36:04 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Thread-Topic: [PATCH v2 net-next 03/14] ptp: netc: add NETC Timer PTP driver
 support
Thread-Index: AQHb9iZqIKdSDIDCCUCMd3Bsvy9xQrQ/6+YAgACrDvA=
Date: Thu, 24 Jul 2025 02:36:04 +0000
Message-ID:
 <PAXPR04MB85109C7DC309F3490BCDC3E1885EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250716073111.367382-1-wei.fang@nxp.com>
 <20250716073111.367382-4-wei.fang@nxp.com>
 <20250723160900.x57uikenvbd7223c@skbuf>
In-Reply-To: <20250723160900.x57uikenvbd7223c@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10782:EE_
x-ms-office365-filtering-correlation-id: 0aa2ef66-c35c-4187-3058-08ddca5ad620
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?TrOe+xY/zZuyAb348D2puv/uFV+cqsWS7k5JRlAy4fFGRIvmQUpVdHM5zst8?=
 =?us-ascii?Q?T+iL+HDm324SzmdjHgY+keNUQ4NE6gufPAriuDnw5OFN+KscrSo5YWQkprSt?=
 =?us-ascii?Q?imAePj1l1TGi91bR1weRQsZCQFPtUQ+4G3tkXoYR49ncZ5N1q3qunPtFJpjW?=
 =?us-ascii?Q?Ojb/e+DZerYkoO/g7y+KEKZKXBxJEDx6cw7QqcFa17sGjlgQbrXi2UIMXRyT?=
 =?us-ascii?Q?iWOrD8DFevoIBnrO1ZrhbfubltbDYwiukhNZMZp+xqOhsEUtXO7QjYbq/4iO?=
 =?us-ascii?Q?92kSr1rvqAnCD1rEGj8FemNdjMiHnCZhcI58axQh0m6qiZ9iQ8DhfbDtmyjF?=
 =?us-ascii?Q?tBHvSc/9ll9uUv4QZNvtpcNzaxQ83EW6wEQo0o4iZMHdqFGR/YZur4S8A6yz?=
 =?us-ascii?Q?2m0c+NmipiV/JXb4HpuaFo3BmmXHgW0HGRc0xM0quqRovnd0MrUg9RHDzv5k?=
 =?us-ascii?Q?d5aykfaDviuokSVMeMqmN+VZBhLUlZJlpQOXgldBsEeryqMarlYivE8B5WZx?=
 =?us-ascii?Q?rLQyGYkvWFiuTF1HpUEX87ukQWCpcpnL0oAXpuQgHFo6VzfANL/g49UJUHdz?=
 =?us-ascii?Q?5AYCzIr76B7T+di3MnvoVMvRUUAgxqaKBG+RKHOHQ07XzQDaZ6+poZXoSpas?=
 =?us-ascii?Q?GNGd0EAP/bNEiPPlP5a1fkbljcrvRB8T9BHttVYdr01UAV9PuSMuFM1n6BVw?=
 =?us-ascii?Q?Ebq/MBteg5PnphKcWTmJOwegWT1cSogZm8Rm3KSBSOpSATnfRDM1Woa7u1mW?=
 =?us-ascii?Q?zjNwZ+6ZO+7fa8Ukt/Q3iLGzeGNEvX+Kw1/89NnzzOb71r0jY0o7oUxJacgc?=
 =?us-ascii?Q?MUEZ7WOOcgYwSOt7VSYq89G+OsR4Zyp4ZyMQurxdIZtl5jqkCt0XhFayPd1M?=
 =?us-ascii?Q?xTelvCiZmh5kyqsJXT8xef0YvqwrphPsTF1d9n5xFQGs2hse0wvkEdA/vJYj?=
 =?us-ascii?Q?hrugB/UTwSXzE20muYQFR0I+Om1nPbB15Lrt8RksscbusZLnBT9+Y+T+R/rc?=
 =?us-ascii?Q?VgA1Eop86Q1UgHydFxqP5O40+0GqHQ9xUZtaQANQKNU839tc+cpHyS58JyfK?=
 =?us-ascii?Q?3XXsHqjUkANooUaO6FKEeh9FCXasTM2G2Cbm7RG/CajDWOzK/9v4L5tcOO5L?=
 =?us-ascii?Q?aeLxBKHYS+uGsU56eGcILBx2W4EMsXMKb5Cyv3iT2qagY+cxfLLNuHUus/6L?=
 =?us-ascii?Q?lro/KGxJ3i8wxCkDCVDxdp9ERAboHoAb+xk6deRdG6mTxjKUrRtwhzT2pYGB?=
 =?us-ascii?Q?kUTVQ/2BRj9az+FlIQgCgX28biqhNUt78fmhzbZ9UPppvWT7p/nUbrUXLmty?=
 =?us-ascii?Q?L6lVE3nbbOvzacVsGOoaATvZYjUqQI+4EhcxT4uvGLnS1HeVjcVojCocau3v?=
 =?us-ascii?Q?w2CxbDFb7qGpQE8vSd5cNQ5BReZ76+J5u2tbUKED2rhYqbkBaR+WWJLb93jt?=
 =?us-ascii?Q?wuJ25cJz29XYJZz1J+IiXhPda07U7jm30d0l24a9kjrAsdcpwMg/Fg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ge2moLkLGc7cYTAGe1eHpd6gr5fYrtJ3Rq/wblMY53UE9ExG2vL+W7D9KX3D?=
 =?us-ascii?Q?JJRCJ4VH2lq0JUs+27RanlSs41UOmd8g3+Kl2wp3C7T2CpyDs+XVYtcPs/7e?=
 =?us-ascii?Q?cad7YmXlWn2WTQS6CZIMISaB/b97nPhuUzC2HytsKjfWCri2ue8v8DJU0Xmt?=
 =?us-ascii?Q?89V6P7BghFQYOcm5JVCvdgLUDo6V9fgIXSiGwvnleuRRB+FRibAP+XKb3ozP?=
 =?us-ascii?Q?Db6l3PciI/JDmY4RokUbVfbq4Ct5ODR+L3Vj2kT3fkAoZeVRBLR3WBFBfvJO?=
 =?us-ascii?Q?3fTBkoW8pD606wV+l4d0jKyFghT7xTgNPFCGdM7LuSJ88ZrmCMO5JgGFuvae?=
 =?us-ascii?Q?/jjRrQQUkTh6Sb1T5u6x+ZslSH5B8rR95hDz8Jyqq5oWR9DJlmdq/x6eQarn?=
 =?us-ascii?Q?qgSQWwjqXkaWsFA5WXXrrh0FkMXBlKUlLYyajcmV5xFjKJQH/j//lMWVqo6N?=
 =?us-ascii?Q?+BE/mAe4Dou9O3ieGh1B++9z5EqSHzo5pMwIGy5hgI9+/PJUok9vVQF5Uixo?=
 =?us-ascii?Q?S77duOcjUWM0Ieq7ByghSTzJ7iGkA+2czO+ZVvZ9Or4xtt069KSOMSgz5sl6?=
 =?us-ascii?Q?BAnVkkJoTZS+/pq23ARvQzrXiA+lghp9j2gHi1UCahfqJaRte50EzQ753R6a?=
 =?us-ascii?Q?OnIms07G1+jxMLLDHelDFa+OaH0K+h0ie7cOAz4ERsbyrYanKm1/yCKcN//e?=
 =?us-ascii?Q?Ue+NsIEqqWigIFTdLkThhVArCS6O+M7stWXOKfLaB0pRBpWE8GTWSIzF4uth?=
 =?us-ascii?Q?omoT3WJBo047M0nxCaDpOUj2HnYkwPepa8OVaZfvd2MaDO+ZMFNHEuTaaT3q?=
 =?us-ascii?Q?TSZnOVTcVCA88AK/ylrnzuLh59PorWqMTF0tpxkt/SApohBmZWMK/f0RdJ/I?=
 =?us-ascii?Q?zFYNkg6C6xBeRTsZ4n5Kh0Fqj3VpA/8h2G4tllran3xNg21aUUslPmvaA321?=
 =?us-ascii?Q?kFNzE+m6qcbxEnAJU08ST7ZJBL2ZVDiaEgG/fdGJ3tH+JIZJlPqwIqt139F+?=
 =?us-ascii?Q?Sgd53xfVUvNkkVZcYlMZziaBSzjk6Gd6W3Xdg6Elix1Vu/ln62y+xF4LWAo7?=
 =?us-ascii?Q?l0CNXS9mzbqa3UF/YIUyMzvUTnZK6D2y1w4qlBJ1oH03XfDycY1og1wXCim4?=
 =?us-ascii?Q?ztCrJ4y+qp1npI/jUXyfE6c6S6mF4mh1spRYf3yo55sON0ZpNDI0njpEm8G+?=
 =?us-ascii?Q?MTDd21OjDsUzlhE3PwSMo6aINwckNj5Tz97Cj1dVOUSJKKEgaagins8M8zrw?=
 =?us-ascii?Q?EWk/bZaBLjB1HxBwgCyvNJXS+oqrlGGvvzxjMW5/bM/ldgxSPVf/2AKtJT3D?=
 =?us-ascii?Q?WyiepGRM8R6O4gUN2L48lK8ht5f6lF1eu32XpVwsxIfFTOQROniOkE64GqYY?=
 =?us-ascii?Q?QBLFYpVZylK7yICtKpo+DQmzLt5CbNCGVyGCQ54fmHyNIjusOXTr4Xrzo58e?=
 =?us-ascii?Q?m+nRlDHe+/8efor1ttuNbofVJSvTUWq6zqQPkq/n64/KzHPlce2DC16qEUK3?=
 =?us-ascii?Q?UMhud92odjnH0ffVnXMTI091P0ouz+gkPP5DU5pYikiIRCkTIQtw0xdcH9JU?=
 =?us-ascii?Q?rukujC4jUEjVfygG+Nk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa2ef66-c35c-4187-3058-08ddca5ad620
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 02:36:04.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SrRQE7zJISGT7s++qJlV8XyjA6c0ZV4x2BRdI7mPmDoZm8uWK8dNHh6oyEBKGX7Pt7zXerBp0cqTNW2Ks8+QWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10782

> On Wed, Jul 16, 2025 at 03:31:00PM +0800, Wei Fang wrote:
> > NETC Timer provides current time with nanosecond resolution, precise
> > periodic pulse, pulse on timeout (alarm), and time capture on external
> > pulse support. And it supports time synchronization as required for
> > IEEE 1588 and IEEE 802.1AS-2020. The enetc v4 driver can implement PTP
> > synchronization through the relevant interfaces provided by the driver.
> > Note that the current driver does not support PEROUT, PPS and EXTTS yet=
,
> > and support will be added one by one in subsequent patches.
>=20
> Would you mind adding a paragraph justifying why you are introducing a
> new driver, rather than extending the similar ptp_qoriq.c?
>=20

Sure, I will add paragraph to explain this. Thanks.

> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2 changes:
> > 1. Rename netc_timer_get_source_clk() to
> >    netc_timer_get_reference_clk_source() and refactor it
> > 2. Remove the scaled_ppm check in netc_timer_adjfine()
> > 3. Add a comment in netc_timer_cur_time_read()
> > 4. Add linux/bitfield.h to fix the build errors
> > ---
> >  drivers/ptp/Kconfig             |  11 +
> >  drivers/ptp/Makefile            |   1 +
> >  drivers/ptp/ptp_netc.c          | 568
> ++++++++++++++++++++++++++++++++
> >  include/linux/fsl/netc_global.h |  12 +-
> >  4 files changed, 591 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/ptp/ptp_netc.c
> >
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> > index 204278eb215e..3e005b992aef 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -252,4 +252,15 @@ config PTP_S390
> >  	  driver provides the raw clock value without the delta to
> >  	  userspace. That way userspace programs like chrony could steer
> >  	  the kernel clock.
> > +
> > +config PTP_1588_CLOCK_NETC
> > +	bool "NXP NETC Timer PTP Driver"
> > +	depends on PTP_1588_CLOCK=3Dy
> > +	depends on PCI_MSI
> > +	help
> > +	  This driver adds support for using the NXP NETC Timer as a PTP
> > +	  clock. This clock is used by ENETC MAC or NETC Switch for PTP
> > +	  synchronization. It also supports periodic output signal (e.g.
> > +	  PPS) and external trigger timestamping.
> > +
> >  endmenu
> > diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> > index 25f846fe48c9..d48fe4009fa4 100644
> > --- a/drivers/ptp/Makefile
> > +++ b/drivers/ptp/Makefile
> > @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
> >  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+=3D ptp_ocp.o
> >  obj-$(CONFIG_PTP_DFL_TOD)		+=3D ptp_dfl_tod.o
> >  obj-$(CONFIG_PTP_S390)			+=3D ptp_s390.o
> > +obj-$(CONFIG_PTP_1588_CLOCK_NETC)	+=3D ptp_netc.o
> > diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
> > new file mode 100644
> > index 000000000000..82cb1e6a0fe9
> > --- /dev/null
> > +++ b/drivers/ptp/ptp_netc.c
> > @@ -0,0 +1,568 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/*
> > + * NXP NETC Timer driver
> > + * Copyright 2025 NXP
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/fsl/netc_global.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/ptp_clock_kernel.h>
> > +
> > +#define NETC_TMR_PCI_VENDOR		0x1131
> > +#define NETC_TMR_PCI_DEVID		0xee02
> > +
> > +#define NETC_TMR_CTRL			0x0080
> > +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> > +#define  TMR_CTRL_TE			BIT(2)
> > +#define  TMR_COMP_MODE			BIT(15)
> > +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> > +#define  TMR_CTRL_FS			BIT(28)
> > +#define  TMR_ALARM1P			BIT(31)
> > +
> > +#define NETC_TMR_TEVENT			0x0084
> > +#define  TMR_TEVENT_ALM1EN		BIT(16)
> > +#define  TMR_TEVENT_ALM2EN		BIT(17)
> > +
> > +#define NETC_TMR_TEMASK			0x0088
> > +#define NETC_TMR_CNT_L			0x0098
> > +#define NETC_TMR_CNT_H			0x009c
> > +#define NETC_TMR_ADD			0x00a0
> > +#define NETC_TMR_PRSC			0x00a8
> > +#define NETC_TMR_OFF_L			0x00b0
> > +#define NETC_TMR_OFF_H			0x00b4
> > +
> > +/* i =3D 0, 1, i indicates the index of TMR_ALARM */
> > +#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
> > +#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
> > +
> > +#define NETC_TMR_FIPER_CTRL		0x00dc
> > +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> > +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> > +
> > +#define NETC_TMR_CUR_TIME_L		0x00f0
> > +#define NETC_TMR_CUR_TIME_H		0x00f4
> > +
> > +#define NETC_TMR_REGS_BAR		0
> > +
> > +#define NETC_TMR_FIPER_NUM		3
> > +#define NETC_TMR_DEFAULT_PRSC		2
> > +#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
> > +
> > +/* 1588 timer reference clock source select */
> > +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from
> CCM */
> > +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> > +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> > +
> > +#define NETC_TMR_SYSCLK_333M		333333333U
> > +
> > +struct netc_timer {
> > +	void __iomem *base;
> > +	struct pci_dev *pdev;
> > +	spinlock_t lock; /* Prevent concurrent access to registers */
> > +
> > +	struct clk *src_clk;
> > +	struct ptp_clock *clock;
> > +	struct ptp_clock_info caps;
> > +	int phc_index;
> > +	u32 clk_select;
> > +	u32 clk_freq;
> > +	u32 oclk_prsc;
> > +	/* High 32-bit is integer part, low 32-bit is fractional part */
> > +	u64 period;
> > +
> > +	int irq;
> > +};
> > +
> > +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> > +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> > +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct
> netc_timer, caps)
> > +
> > +static u64 netc_timer_cnt_read(struct netc_timer *priv)
> > +{
> > +	u32 tmr_cnt_l, tmr_cnt_h;
> > +	u64 ns;
> > +
> > +	/* The user must read the TMR_CNC_L register first to get
> > +	 * correct 64-bit TMR_CNT_H/L counter values.
> > +	 */
> > +	tmr_cnt_l =3D netc_timer_rd(priv, NETC_TMR_CNT_L);
> > +	tmr_cnt_h =3D netc_timer_rd(priv, NETC_TMR_CNT_H);
> > +	ns =3D (((u64)tmr_cnt_h) << 32) | tmr_cnt_l;
> > +
> > +	return ns;
> > +}
> > +
> > +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns)
> > +{
> > +	u32 tmr_cnt_h =3D upper_32_bits(ns);
> > +	u32 tmr_cnt_l =3D lower_32_bits(ns);
> > +
> > +	/* The user must write to TMR_CNT_L register first. */
> > +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> > +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h);
> > +}
> > +
> > +static u64 netc_timer_offset_read(struct netc_timer *priv)
> > +{
> > +	u32 tmr_off_l, tmr_off_h;
> > +	u64 offset;
> > +
> > +	tmr_off_l =3D netc_timer_rd(priv, NETC_TMR_OFF_L);
> > +	tmr_off_h =3D netc_timer_rd(priv, NETC_TMR_OFF_H);
> > +	offset =3D (((u64)tmr_off_h) << 32) | tmr_off_l;
> > +
> > +	return offset;
> > +}
> > +
> > +static void netc_timer_offset_write(struct netc_timer *priv, u64 offse=
t)
> > +{
> > +	u32 tmr_off_h =3D upper_32_bits(offset);
> > +	u32 tmr_off_l =3D lower_32_bits(offset);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> > +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h);
> > +}
> > +
> > +static u64 netc_timer_cur_time_read(struct netc_timer *priv)
> > +{
> > +	u32 time_h, time_l;
> > +	u64 ns;
> > +
> > +	/* The user should read NETC_TMR_CUR_TIME_L first to
> > +	 * get correct current time.
> > +	 */
> > +	time_l =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> > +	time_h =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> > +	ns =3D (u64)time_h << 32 | time_l;
> > +
> > +	return ns;
> > +}
> > +
> > +static void netc_timer_alarm_write(struct netc_timer *priv,
> > +				   u64 alarm, int index)
> > +{
> > +	u32 alarm_h =3D upper_32_bits(alarm);
> > +	u32 alarm_l =3D lower_32_bits(alarm);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
> > +	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
> > +}
> > +
> > +static void netc_timer_adjust_period(struct netc_timer *priv, u64 peri=
od)
> > +{
> > +	u32 fractional_period =3D lower_32_bits(period);
> > +	u32 integral_period =3D upper_32_bits(period);
> > +	u32 tmr_ctrl, old_tmr_ctrl;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	old_tmr_ctrl =3D netc_timer_rd(priv, NETC_TMR_CTRL);
> > +	tmr_ctrl =3D u32_replace_bits(old_tmr_ctrl, integral_period,
> > +				    TMR_CTRL_TCLK_PERIOD);
> > +	if (tmr_ctrl !=3D old_tmr_ctrl)
> > +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +}
> > +
> > +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long scaled_=
ppm)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	u64 new_period;
> > +
> > +	new_period =3D adjust_by_scaled_ppm(priv->period, scaled_ppm);
> > +	netc_timer_adjust_period(priv, new_period);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	u64 tmr_cnt, tmr_off;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	tmr_off =3D netc_timer_offset_read(priv);
> > +	if (delta < 0 && tmr_off < abs(delta)) {
>=20
> You go to great lengths to avoid letting TMROFF become negative, but is
> there any problem if you just let it do so, and delete the imprecise
> "TMR_CNT +=3D delta" code path altogether? An addition with the two's
> complement of a number is the same as a subtraction.

Because the RM does not specify that the TMROFF register is signed, I
thought it was unsigned at the time, so I came up with this logic. I should
do an experiment to prove whether it is signed. Thank you for your reminder=
.
I think I can do this experiment now. If it is signed, I will improve this =
logic.

>=20
> Let's say delta=3D-10, and the current TMROFF value is 5.
> Your condition deviates the adjustment through the imprecise method,
> but if we write TMROFF =3D -5 =3D 0xffffffff_fffffffb, we should get the
> correct result, no?
>=20
> I thought about this a number of ways, and they all seem to be fine.
> Like, the worst thing that can happen is a TMROFF value which became
> negative by accident, due to too many netc_timer_adjtime() values with a
> large (but positive) delta.
>=20
> But even that should be fine, because an overflow on TMROFF is
> indistinguishable from an overflow on TMR_CNT.
>=20
> Anyway, _this_ is the time of logic which could really use a comment to
> explain the intention behind it.

Yeah, I will add a comment.

>=20
> > +		delta +=3D tmr_off;
> > +		if (!tmr_off)
> > +			netc_timer_offset_write(priv, 0);
> > +
> > +		tmr_cnt =3D netc_timer_cnt_read(priv);
> > +		tmr_cnt +=3D delta;
> > +		netc_timer_cnt_write(priv, tmr_cnt);
> > +	} else {
> > +		tmr_off +=3D delta;
> > +		netc_timer_offset_write(priv, tmr_off);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> > +				 struct timespec64 *ts,
> > +				 struct ptp_system_timestamp *sts)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	unsigned long flags;
> > +	u64 ns;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +
> > +	ptp_read_system_prets(sts);
> > +	ns =3D netc_timer_cur_time_read(priv);
> > +	ptp_read_system_postts(sts);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	*ts =3D ns_to_timespec64(ns);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> > +				const struct timespec64 *ts)
> > +{
> > +	struct netc_timer *priv =3D ptp_to_netc_timer(ptp);
> > +	u64 ns =3D timespec64_to_ns(ts);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
> > +	netc_timer_offset_write(priv, 0);
> > +	netc_timer_cnt_write(priv, ns);
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return 0;
> > +}
> > +
> > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev)
> > +{
> > +	struct netc_timer *priv;
> > +
> > +	if (!timer_pdev)
> > +		return -ENODEV;
> > +
> > +	priv =3D pci_get_drvdata(timer_pdev);
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	return priv->phc_index;
> > +}
> > +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> > +
> > +static const struct ptp_clock_info netc_timer_ptp_caps =3D {
> > +	.owner		=3D THIS_MODULE,
> > +	.name		=3D "NETC Timer PTP clock",
> > +	.max_adj	=3D 500000000,
> > +	.n_alarm	=3D 2,
>=20
> Is n_alarm functionally hooked with anything in the PTP core, other than
> the "n_alarms" read-only sysfs? I didn't see anything.
>=20
> > +	.n_pins		=3D 0,
> > +	.adjfine	=3D netc_timer_adjfine,
> > +	.adjtime	=3D netc_timer_adjtime,
> > +	.gettimex64	=3D netc_timer_gettimex64,
> > +	.settime64	=3D netc_timer_settime64,
> > +};
> > +
> > +static void netc_timer_init(struct netc_timer *priv)
> > +{
> > +	u32 tmr_emask =3D TMR_TEVENT_ALM1EN | TMR_TEVENT_ALM2EN;
> > +	u32 fractional_period =3D lower_32_bits(priv->period);
> > +	u32 integral_period =3D upper_32_bits(priv->period);
> > +	u32 tmr_ctrl, fiper_ctrl;
> > +	struct timespec64 now;
> > +	u64 ns;
> > +	int i;
> > +
> > +	/* Software must enable timer first and the clock selected must be
> > +	 * active, otherwise, the registers which are in the timer clock
> > +	 * domain are not accessible.
> > +	 */
> > +	tmr_ctrl =3D (priv->clk_select & TMR_CTRL_CK_SEL) | TMR_CTRL_TE;
>=20
> Candidate for FIELD_PREP()?
>=20
> > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> > +
> > +	/* Disable FIPER by default */
> > +	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > +	for (i =3D 0; i < NETC_TMR_FIPER_NUM; i++) {
> > +		fiper_ctrl |=3D FIPER_CTRL_DIS(i);
> > +		fiper_ctrl &=3D ~FIPER_CTRL_PG(i);
> > +	}
> > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +
> > +	ktime_get_real_ts64(&now);
> > +	ns =3D timespec64_to_ns(&now);
> > +	netc_timer_cnt_write(priv, ns);
> > +
> > +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> > +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> > +	 */
> > +	tmr_ctrl |=3D ((integral_period << 16) & TMR_CTRL_TCLK_PERIOD) |
>=20
> Candidate for FIELD_PREP()?
>=20
> > +		     TMR_COMP_MODE | TMR_CTRL_FS;
> > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> > +	netc_timer_wr(priv, NETC_TMR_TEMASK, tmr_emask);
> > +}
> > +
> > +static int netc_timer_pci_probe(struct pci_dev *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err, len;
> > +
> > +	pcie_flr(pdev);
> > +	err =3D pci_enable_device_mem(pdev);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "Failed to enable device\n");
> > +
> > +	err =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > +	if (err) {
> > +		dev_err(dev, "dma_set_mask_and_coherent() failed, err:%pe\n",
> > +			ERR_PTR(err));
> > +		goto disable_dev;
> > +	}
> > +
> > +	err =3D pci_request_mem_regions(pdev, KBUILD_MODNAME);
> > +	if (err) {
> > +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> > +			ERR_PTR(err));
> > +		goto disable_dev;
> > +	}
> > +
> > +	pci_set_master(pdev);
> > +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > +	if (!priv) {
> > +		err =3D -ENOMEM;
> > +		goto release_mem_regions;
> > +	}
> > +
> > +	priv->pdev =3D pdev;
> > +	len =3D pci_resource_len(pdev, NETC_TMR_REGS_BAR);
> > +	priv->base =3D ioremap(pci_resource_start(pdev, NETC_TMR_REGS_BAR),
> len);
> > +	if (!priv->base) {
> > +		err =3D -ENXIO;
> > +		dev_err(dev, "ioremap() failed\n");
> > +		goto free_priv;
> > +	}
> > +
> > +	pci_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +
> > +free_priv:
> > +	kfree(priv);
> > +release_mem_regions:
> > +	pci_release_mem_regions(pdev);
> > +disable_dev:
> > +	pci_disable_device(pdev);
> > +
> > +	return err;
> > +}
> > +
> > +static void netc_timer_pci_remove(struct pci_dev *pdev)
> > +{
> > +	struct netc_timer *priv =3D pci_get_drvdata(pdev);
> > +
> > +	iounmap(priv->base);
> > +	kfree(priv);
> > +	pci_release_mem_regions(pdev);
> > +	pci_disable_device(pdev);
> > +}
> > +
> > +static int netc_timer_get_reference_clk_source(struct netc_timer *priv=
)
> > +{
> > +	struct device *dev =3D &priv->pdev->dev;
> > +	struct device_node *np =3D dev->of_node;
> > +	const char *clk_name =3D NULL;
> > +	u64 ns =3D NSEC_PER_SEC;
>=20
> Nitpick: It's strange to keep a constant in a variable.
>=20
> > +
> > +	/* Select NETC system clock as the reference clock by default */
> > +	priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +	priv->clk_freq =3D NETC_TMR_SYSCLK_333M;
> > +	priv->period =3D div_u64(ns << 32, priv->clk_freq);
>=20
> When reviewing, I found "NSEC_PER_SEC << 32" deeply confusing, since it
> has no physical meaning, and I was left wondering "Why is priv->period
> equal to 4294967296 ns divided by the clock frequency?".
>=20
> It would be helpful if you added a comment explaining that in order to
> store the period in the desired 32-bit fixed-point format, you can
> multiply the numerator of the fraction by 2^32.
>=20

Okay, I will add a comment

> > +
> > +	if (!np)
> > +		return 0;
> > +
> > +	of_property_read_string(np, "clock-names", &clk_name);
> > +	if (!clk_name)
> > +		return 0;
> > +
> > +	/* Update the clock source of the reference clock if the clock
> > +	 * name is specified in DTS node.
> > +	 */
> > +	if (!strcmp(clk_name, "system"))
> > +		priv->clk_select =3D NETC_TMR_SYSTEM_CLK;
> > +	else if (!strcmp(clk_name, "ccm_timer"))
> > +		priv->clk_select =3D NETC_TMR_CCM_TIMER1;
> > +	else if (!strcmp(clk_name, "ext_1588"))
> > +		priv->clk_select =3D NETC_TMR_EXT_OSC;
> > +	else
> > +		return -EINVAL;
> > +
> > +	priv->src_clk =3D devm_clk_get(dev, clk_name);
> > +	if (IS_ERR(priv->src_clk)) {
> > +		dev_err(dev, "Failed to get reference clock source\n");
>=20
> Can this return -EPROBE_DEFER? Should you use dev_err_probe() instead,
> to suppress error messages in that case?
>=20
> > +		return PTR_ERR(priv->src_clk);
> > +	}
> > +
> > +	priv->clk_freq =3D clk_get_rate(priv->src_clk);
> > +	priv->period =3D div_u64(ns << 32, priv->clk_freq);
> > +
> > +	return 0;
> > +}
> > +
> > +static int netc_timer_parse_dt(struct netc_timer *priv)
> > +{
> > +	return netc_timer_get_reference_clk_source(priv);
> > +}
> > +
> > +static irqreturn_t netc_timer_isr(int irq, void *data)
> > +{
> > +	struct netc_timer *priv =3D data;
> > +	u32 tmr_event, tmr_emask;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&priv->lock, flags);
>=20
> In hardirq context (this is not threaded) you don't need irqsave/irqresto=
re.

You are right, I will improve this

>=20
> > +
> > +	tmr_event =3D netc_timer_rd(priv, NETC_TMR_TEVENT);
> > +	tmr_emask =3D netc_timer_rd(priv, NETC_TMR_TEMASK);
>=20
> The value of the NETC_TMR_TEMASK register is a runtime invariant, does
> it make sense to cache it in the driver, to avoid a register read per
> interrupt?
>=20
> > +
> > +	tmr_event &=3D tmr_emask;
> > +	if (tmr_event & TMR_TEVENT_ALM1EN)
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > +
> > +	if (tmr_event & TMR_TEVENT_ALM2EN)
> > +		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 1);
>=20
> Writing GENMASK_ULL(63, 0) has the effect of disabling the alarm, right?
> What is the functional need to have this logic wired up at this stage?
> Somebody needs to have armed the alarm in the first place, yet I see no
> such code.

Hmm, I am sorry, I will remove the alarm logic to PPS patch.
>=20
> > +
> > +	/* Clear interrupts status */
> > +	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
> > +
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +static int netc_timer_probe(struct pci_dev *pdev,
> > +			    const struct pci_device_id *id)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct netc_timer *priv;
> > +	int err;
> > +
> > +	err =3D netc_timer_pci_probe(pdev);
> > +	if (err)
> > +		return err;
> > +
> > +	priv =3D pci_get_drvdata(pdev);
> > +	err =3D netc_timer_parse_dt(priv);
> > +	if (err) {
> > +		dev_err(dev, "Failed to parse DT node\n");
> > +		goto timer_pci_remove;
> > +	}
> > +
> > +	priv->caps =3D netc_timer_ptp_caps;
> > +	priv->oclk_prsc =3D NETC_TMR_DEFAULT_PRSC;
> > +	priv->phc_index =3D -1; /* initialize it as an invalid index */
>=20
> A better use of the comment space would be to explain why, not just to
> add obvious and unhelpful subtitles to the code.
>=20
> When is the priv->phc_index value of -1 preserved (not overwritten with
> the ptp_clock_index() result)? It seems to be when the driver fails to
> probe.
>=20
> But in that case, doesn't device_unbind_cleanup() call "dev_set_drvdata(d=
ev,
> NULL);",
> to prevent what would otherwise be a use-after-free?
>=20

My bad, this line is not reasonable, I will remove it.

> > +	spin_lock_init(&priv->lock);
> > +
> > +	err =3D clk_prepare_enable(priv->src_clk);
> > +	if (err) {
> > +		dev_err(dev, "Failed to enable timer source clock\n");
> > +		goto timer_pci_remove;
> > +	}
> > +
> > +	err =3D netc_timer_init_msix_irq(priv);
> > +	if (err)
> > +		goto disable_clk;
> > +
> > +	netc_timer_init(priv);
> > +	priv->clock =3D ptp_clock_register(&priv->caps, dev);
> > +	if (IS_ERR(priv->clock)) {
> > +		err =3D PTR_ERR(priv->clock);
> > +		goto free_msix_irq;
> > +	}
> > +
> > +	priv->phc_index =3D ptp_clock_index(priv->clock);
> > +
> > +	return 0;
> > +
> > +free_msix_irq:
> > +	netc_timer_free_msix_irq(priv);
> > +disable_clk:
> > +	clk_disable_unprepare(priv->src_clk);
> > +timer_pci_remove:
> > +	netc_timer_pci_remove(pdev);
> > +
> > +	return err;
> > +}

