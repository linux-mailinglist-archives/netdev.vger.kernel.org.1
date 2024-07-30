Return-Path: <netdev+bounces-114165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104494137D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 15:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF28283953
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677101A073B;
	Tue, 30 Jul 2024 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JqDsdKDu"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221551465A7
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347245; cv=fail; b=eAl1SS+Ry8fhzHZ8Ut+i4EqUrDqrVDhkSWyoEQRY9D0jPRcf/n7ibrv1TriWCdZ0BSRM7giBWGGrmYVjXL3pJG7jOQfHPNAF9KzbB4uZbEMmGTYKGfmJHQ50rm8cO5sMZIvy0IauyJesdmeH1wVyNfwsJ5d/eZA6TIcbq2R2uXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347245; c=relaxed/simple;
	bh=4x5EeZ1QH4C+ZTBJ6d86bfP5sgTdag7r8OFUWCWLrRA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JPC+KCFU8t1rBqv3Qu9X7z4KpWDNi7/5MnDEP2BTGbRqJFSRT4s4vvErC2+64U4bYQK9FK7Dli2Is9gzUL5tr7itBlGNNAW6IAcAtEaFHI4M3mSsxG1y15MN4l5eAQXaBj+qDSy+bRog/DGBHBlIkDBttddlBoP4s3FdcEYZ888=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JqDsdKDu; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfErtorGneVrn/lHqztGXc/8HVakgMvU5OT3sdUP5+vpgxf8jwEjAIaGE9/AB5LZ4tHqHgj74KYdFj03+gq13pAbkKPgkOAIxhT/uAl2uSfenUkMAImudRnpcDweQuvKl3kKL/2jpehey0Knf83zi3tMUBLNvd36ZeYbNteJsVAfaFgzXopmZRngseHF4uiNs8pzWG2La7qpR7E5gpEsNaSreT5tIpsxkpgAC9TR1mBYPY1D7lj6ZhZzNEo3IoHN8zALfwHh6OI4mO/2+bWP0QK3W44KZRjcd2zIpRxwL4e+hBsOXDanIqjXJTTsIwoTJudtcxlpienS8Uz5gVe8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J/LIG1WXAnyGN0K2mEphG3IX5ITYEdeFlwJNW5FFqU=;
 b=iJkocKbxLSxdP7YZ+Hc1GGslluIv452nV28JTu7Kw+fkmYD1Xi1XQ4BzoFdmiOSIrr2EIPBgX6cPgYm19n1SimKcViF+bS+fGVKBKgMPQLFIELDIQcye77QLZdUi/BldrYtri+cLsv6+ehCcz1qGa/D5JiaXGm8yudwwfkSQeFky6k29RaltDZkHB2glSrzU4xIyfjRYfHsfTDFwb6Ul0l/AU/Qf7gpv9KbHRZa+L40JSOkSxptpOyG5MA2yjGNRQqyFCfwrZIbsjNUA555n1wCgdBeFgmBq29ztQosyXkkihi6Sv8lfCbLDatJc+uLLvHsolDkR50INbfunObL2QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J/LIG1WXAnyGN0K2mEphG3IX5ITYEdeFlwJNW5FFqU=;
 b=JqDsdKDuJtIAwv6D/XIXZ5kXK5ZaARZl2zS4xx7MkuBg+Gx9XuwVqRQb/jwT1UJUYGdMacJExDF2Vvwl7XdkYNvzmoTFtMKgJIWWRsnqFOWTYMdXlBOtAciyuEQXtWJnbgF6aurKSMlTinHMODa+/Wtw5kf3AG13VyrTlR98wxRdcbpZjfo2Zw+fM+adJovmYtNTgDlPsOaVzGcih8asGKVrwepUGp+GbVz8t1V79DF6z7PUJxgzBctR/mu+U3fkvtjOJiolhwMuFb9bEQsI7q6vz4Lp8U8N7B18iEmCjxwXpGMLpVYKos0n+461TwTad5OYDT0FEWSoh983VtWAww==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB6778.eurprd04.prod.outlook.com (2603:10a6:10:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 13:47:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 13:47:18 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Joe Damato <jdamato@fastly.com>
CC: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 net-next resent] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Thread-Topic: [PATCH v2 net-next resent] net: fec: Enable SOC specific
 rx-usecs coalescence default setting
Thread-Index: AQHa4ob+MHX6Uf7SV0G4/XN7U5Secw==
Date: Tue, 30 Jul 2024 13:47:18 +0000
Message-ID:
 <PAXPR04MB9185CBA946F34FA6CD853DD489B02@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240729193527.376077-1-shenwei.wang@nxp.com>
 <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
In-Reply-To: <Zqi9oRGbTGDUfjhi@LQ3V64L9R2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|DB8PR04MB6778:EE_
x-ms-office365-filtering-correlation-id: ad17304b-870e-4dcd-aadc-08dcb09e2140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R2S6ulLpvO7t4AAxfVMjLfAG8uYyzA4s49SuregudJ91hCQ9uiJKP2wG55S7?=
 =?us-ascii?Q?7c/1jfSZ6Qoy0o/3kL2gFA9bguxHb7Btte/x1Z7U/nB4jelbHAaVTc3NUTBs?=
 =?us-ascii?Q?8on8SkgPf4A3TkVdIVTRAW5Pjo99RhR4QkMqMbd1JYp4KlJViLQraytBnPnt?=
 =?us-ascii?Q?utsocehDj/1XisBDwxN/bTDUvCbdg6aO7+HMWpmNJN4o06w7vAbSynp/v4kX?=
 =?us-ascii?Q?vm3z6tVvDBmwg01oT5LzwVNK3wzClCTqFwNiXfP+oLfi4MuK6JDNjoH/tIul?=
 =?us-ascii?Q?wa2bqClFMA0RfMGCXQIehayPkB0/lwFLIE7rrP9pdvpDgvA21h2V5tGvwy6z?=
 =?us-ascii?Q?eQMHalSnwh2+Oenq6xwcr+gZhMIEviWrqNpiRfFzRmpqEoa6EcEJvRUrxvH6?=
 =?us-ascii?Q?sFe3AyiFmdMrmT3Oa2n5mHKY8NOFBBzFK9dOmdicV5CTh0XD9m7Az5hoz0vG?=
 =?us-ascii?Q?aNnsj0fxdOE8Ypm/lGB7VJAdwcP9VdekASejGNlm2Pi0aWd2T2+qNGOoa1X8?=
 =?us-ascii?Q?qQ8ayNr2hxloIpSITAi6JKUqJd20v/rvklDYVEP16NHpa2hbmafkY9qXVQhj?=
 =?us-ascii?Q?14JkdeFWSiXM2b2sPaCN0LPx0K7+CjuipOaNt64MK7T6AF9TczHiIL3xVyAu?=
 =?us-ascii?Q?kG2AskOwDZhHAtZebYEsPtzuJGjk+ZB/lrNj4TyuXFxiavVpVwl2V7whI2my?=
 =?us-ascii?Q?37ZKpzXtOn1ZahPXBYv+3Ia+sKLnNz1Ftuw+qe/hGy/Et1VwmChQAIv+aiPO?=
 =?us-ascii?Q?zh+bPEAlUpbFPhyaCalF0aBCzUQrD8zAL1yQW5gH3nuT/1ZzPU8eNW3rZlrS?=
 =?us-ascii?Q?EJ1qflskse0oAA2TRRDdvpNq/WgAc9ml8oJ+bf7OieVLiN9+hhs74OSam7G9?=
 =?us-ascii?Q?QITH/CzgzDYesPsccfVc319y7qZhpI8vlipoWpXVPVe8xyAKsCmw6S/f9ATz?=
 =?us-ascii?Q?tVBhmxw2RdrV4C6kJLVW3STQT62QU5edknxu+2SOh5F7St3Tq2dXxVCYbYh4?=
 =?us-ascii?Q?JnETc2u+6rvWZoLcZrSshUPJGkSWtgIIjQLcnu7D6ccxdJm6oWs6elJnYGDY?=
 =?us-ascii?Q?2EYwBD4YnNdbmcmR0gLa5qYFKpebd23SbNFF168gWoNhYw18K1OcwzTrrFCp?=
 =?us-ascii?Q?pz2IZGIfpLmErAwKxtzyIEwkY+6JWBIdat9HgBoj0A3wqAZkP/IWlkz6EqMy?=
 =?us-ascii?Q?XqoIsjeI9D/tu5k+dfcYcwtYUBTP9UMQ4VmI1Rs+3b7ZbI+ipHv4IVNWmD4e?=
 =?us-ascii?Q?kxWajel84nHEF/cbv0x2f0Tt88mBnGX5bLSq1HbV6IXgkEVzvHfe05x5JbYd?=
 =?us-ascii?Q?2r3OcB2hR/bMn28VjFLKpnwZIyXxws9uWPvmLSZbpxu4P/QemxrRwtTJQfL0?=
 =?us-ascii?Q?jhFe3DMJ7E2Z1dNuRw2Ux1bEqHj/OK3FTPHaV3b43MX+Nv1FlA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sgiDdHNhef5JrlJxKhsbeojAbnvN9z3/Zk+7wflRmmqqYXr2JdUDMKHhoXTY?=
 =?us-ascii?Q?pZuD6oBKkVMe/fVuGWDVLv8AA81NrfJpL8l9MQ9LEDmJwNia1cMgG1InS336?=
 =?us-ascii?Q?Vl+PIcYhZBXZRAmaTlQjFfMdjP40fFjC6t54ZkG1H7X+c31SHFTat4Kjm9tP?=
 =?us-ascii?Q?61o2jqIKT1d1XSUZxDZ+uR2AmLYB8B82jIp1QhrxPmzgr1uyIOrZmORVT5Gi?=
 =?us-ascii?Q?wTf6sw1B1guKqkd7OwztzvKhhNMthbengcZ65zaejS3WybuGjWL+Kq5G3E3s?=
 =?us-ascii?Q?MMSVHOXJBrGnvix7TaGAQR8l+MdYBJxe+swrRp/7yd/KTC9uFDerWWMfXFte?=
 =?us-ascii?Q?rupzYousdHXfJYwfK4bP8m05kzVs2pvS137X0Qm133oAtiYdlUrBPZHi4sNo?=
 =?us-ascii?Q?nhHmCdQzwvfppgOJaNjt2t0XvP035QW91N1WqyNK9UZNQVhgBbp2U7s/hI2e?=
 =?us-ascii?Q?I+gI+hW+6UD7wB+TBly0a8vZkNfmuLztZlAJfpCmlitP4wTt0iknwqkPj2wn?=
 =?us-ascii?Q?IIdKsbcabSQBOPEzqtftePN/08FnNMUJ6qNJ9Zoz1/PgqxLVC2yxR8uXtjDL?=
 =?us-ascii?Q?rSlTsI2Ubt7CNkX5fBLAH6llxqSyf1RRMHZtO7FD7ykzyMrBUF6GQ2o7BFnD?=
 =?us-ascii?Q?cgStvTof6nZAP4I7FYvEjfRbIhLROG0yNnA/HnhLHmAZ9kn9wTwa5ADWFKmW?=
 =?us-ascii?Q?cYIElZnEJVKBAIwDwP7WdLxptq+WrhkD7uwQtYfmNXZyuXdahZtt/kw95zVb?=
 =?us-ascii?Q?nihu57GFdaMpm44ip21rleY4JqeaR3M6jAG84U3+KUrSE4ubv3bEJKB7MZLh?=
 =?us-ascii?Q?OuS+MIIO5Vl8YnyM4T/vzmqXhs6wzYdQ9cvTvaorpdEuQcoW7NVrwrJNnwOS?=
 =?us-ascii?Q?9a6Y4JFD50+7oCFWP8vD2vmpKyGwDHiJYovU+5W2rk90Q2pl0vu7QQMGzhZ0?=
 =?us-ascii?Q?rreRmqVnK5pR68d5q2IzaM7gcu94cb+eQ4FQtf2tbDRV66zqpXL6VRO9+b+q?=
 =?us-ascii?Q?M7uxwh8/hN4iSJHSuZEWkNJ8A9Yd3eJvQFO10pTO8wTo2foxInkRpmaL2czy?=
 =?us-ascii?Q?tcLTLxD8weThMUT6OPiq6mgxGp2EQaBqBGy8U8ffgUtaW6rxtsoRLYY67Ha8?=
 =?us-ascii?Q?y7T8AkvJC0MoD98nEEdNltnpgzyyoEuNtXhBlm+4qxobdGpUI9KLcP782sGG?=
 =?us-ascii?Q?7DATnWb6smevezDhWAeOFZ+kHSBhDOGYCHiP9EgrSEFJT9Z5u+uUrg7NQEhd?=
 =?us-ascii?Q?zXd4AagKbK8I0Bx/SNxWTiXEPiw5HV+RXQYFJMxcZg6kuO/brpRBkMkvpb1e?=
 =?us-ascii?Q?l1EZBzDD4uAnzVWMqqw4YzMlAL3kvdK57Ptef6hbTCwGjD7qOr1laP5773Ag?=
 =?us-ascii?Q?PCJ9Y3S/tJYDkbI3yX50rUBMDmuDcn3brF5b0Upz3W7HqPmxl+h8fiL1gpVI?=
 =?us-ascii?Q?zODgvgFSSRBesUQCDh7FuKrzkT6svae7JnoYunlM8khUO4E37ZvOw6edTWWm?=
 =?us-ascii?Q?Em63kd6cAkw0+c4MYotEzTNkzrL0sSd80ZJzpW+jP4f2n8ufdmnX56d7tacI?=
 =?us-ascii?Q?tZzW3rhH7ARbacdiLDNZWoGdj3cGLSuVpC/n5Onk?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad17304b-870e-4dcd-aadc-08dcb09e2140
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 13:47:18.8811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTGS7Sa/mfTua/qqnjkqWtvSMQgJ+ytPcz17StyYBcL90wFF/nI+G8ra/W+hgr6aJxZEhV5cIkR9Tm081b0zZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6778



> -----Original Message-----
> From: Joe Damato <jdamato@fastly.com>
> Sent: Tuesday, July 30, 2024 5:17 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; David S. Miller <davem@davemloft.net>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Clark Wang <xiaoning.wang@nxp.com>;
> imx@lists.linux.dev; netdev@vger.kernel.org; dl-linux-imx <linux-
> imx@nxp.com>
> Subject: [EXT] Re: [PATCH v2 net-next resent] net: fec: Enable SOC specif=
ic rx-
> usecs coalescence default setting
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Mon, Jul 29, 2024 at 02:35:27PM -0500, Shenwei Wang wrote:
> > Performance testing using iperf revealed no noticeable impact on
> > network throughput or CPU utilization.
>=20
> I'm not sure this short paragraph addresses Andrew's comment:
>=20
>   Have you benchmarked CPU usage with this patch, for a range of traffic
>   bandwidths and burst patterns. How does it differ?
>=20
> Maybe you could provide more details of the iperf tests you ran? It seems=
 odd
> that CPU usage is unchanged.
>=20
> If the system is more reactive (due to lower coalesce settings and IRQs f=
iring
> more often), you'd expect CPU usage to increase, wouldn't you?
>=20

The driver operates under NAPI polling, where several factors influence IRQ=
 triggering:=20
NAPI polling weight, RX timer threshold, and RX frame count threshold.=20
During iperf testing, my understanding is that the NAPI polling weight is l=
ikely the primary=20
factor affecting triggering frequency, as IRQs are disabled during NAPI pol=
ling cycles.

Thanks,
Shenwei
=09
> - Joe

