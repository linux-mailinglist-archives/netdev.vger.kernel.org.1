Return-Path: <netdev+bounces-266445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIy5KcffsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:21:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E66925B60F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C11E53032D2C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A07A36B046;
	Wed, 11 Mar 2026 03:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KNcWXn07"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339C2F616B;
	Wed, 11 Mar 2026 03:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199270; cv=fail; b=Cu4eyokt4CS5QJbnMadpZwiWRBKzPzmLtdZNIDOnU8TAYl6Iv7aSSk7MuNd3Hr/vld6zJ4AjYb4oHebxJzJ/g3LlN+FbIan91qxm7+pTkaonC8q3JAjfVQqWZ5lRtrVG0X4EbhBH20lbI6E+P/YsxosHY5Bwh8B48FEPFW4i1Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199270; c=relaxed/simple;
	bh=1ud55rA49xFGuf9XrlWhjby76s9grSSHZKGpI2vdL/8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=txFRrlxerkKGBZxJMERX+blfKi2yPcvPWQXV1lDBKb1vVLlHgPI4h3hXPh2LvQZ7kwfaUbNk2z0Oe9afc9p6FAeAzPUiuiaWRIEHk7saABy9HRlp85hInUdTQQ8J61q0OB2xR4RT+kfelDisR0KBtuOKXTxjFTE8zu9nQb/VoMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KNcWXn07; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSe0Z9aagYWiPl4fdwQWYN74jYsQoUbSmWMVn+De608sKHTYWdrT69z/CbzyrWgDQilncYi3RdTcgSJgmwbLz1KR+liIeCAn2OtHvErryUQyUV0n/arOWReuOUHSMBrDxojOS5x72XklfPV0vjscknbs6NDOje1WNrkG/1CsB4MoV/jlaMogtowOjbO+so07kdHf+KHCjEfNsX7tNjozYKlKLy90sjax1WPBi39FecjgcPTFJfaXZuE0vQInqctxo02g5t3tWQQigEMyjKMPEQ0alVeoJ/s5MsTB5JtscQCnFOfb8nzfqTp+5hjW1pWInRl7SncLOZ2HS93At9Ig0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AuVdugl2YcL+rQ2TIbjaytoAlWncFFzI32BPu168ko=;
 b=TpdiGc2MYhfMmQJMb+mc6kQtk45UajSf+zRSVFuh4n3ipuiGjc4bMenJvIH1upE3sxcaNyRubae8Tgp4/rWbJFD/wabfoFQMXKbTZHxPMYIHLCGWvQVJIi6BBe2RDhKeEp8IPGCwZ6OyE2btm3tn2E2oHl5ne8lSBrY52MjNhtqp5YPPWbpqmYpCi45D6kdyCALQfrpRWFKibfMGAopz0ckFSTe94oJGpYMbHkchtonoDay3zVgBSF66o6TGPI/1+Ral/3e3o3cHXBLbKVABUfUSvdMUWA0kWytCyscttazeq2RuSNFwppAwkv86FI0A1IdMZ/LIgYzU8ETxs07Sxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AuVdugl2YcL+rQ2TIbjaytoAlWncFFzI32BPu168ko=;
 b=KNcWXn07tDQHDTezghoBx8ZzUkTYuBZI4taGMG4eCb1/5zxhZdLrxBwuo3e4ztSGhFdImsM7Iq0UBlKuLdCb433EkkoI9e95YmOvK158dSnmLpIKLTYyOOXr2OW8j0xsahtpLEtAGnMUZEWPQgWLY8zlHxI6Daf6+V9TjVMcyr5qbg8JqJG8xMb+FfyMD1R/fzV6EkHPa1Y7VBSPmqLKulCC0Za2gXw8U1WF9whJ2xiD58hVvNcPy9BV/hkj4CDavanXz6UWNysZ/BGpsYaeIOCTiaYN5xpLch3DqgTaqomjeamQFJ6u3P5XeKi3cdLjb9CZCMkxUFxiCeCCBjttWQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11445.eurprd04.prod.outlook.com (2603:10a6:150:2af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Wed, 11 Mar
 2026 03:21:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 03:21:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net] net: enetc: safely reinitialize TX BD ring when it
 has unsent frames
Thread-Topic: [PATCH v2 net] net: enetc: safely reinitialize TX BD ring when
 it has unsent frames
Thread-Index: AQHcr3EnS3znnXBKUk2fVpSriP2A/7WoAfkAgACqF9A=
Date: Wed, 11 Mar 2026 03:21:06 +0000
Message-ID:
 <PAXPR04MB85102FFC86FD38FF3A2BCCD98847A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260309030412.2716984-1-wei.fang@nxp.com>
 <20260310170752.GL461701@kernel.org>
In-Reply-To: <20260310170752.GL461701@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11445:EE_
x-ms-office365-filtering-correlation-id: e9a0b363-5ae5-452e-9362-08de7f1d3b87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 qVZ4zc1LuHM6TPxxr7p/rwwiMq6H7iJn7//C4fZTa3RQUbxCIPMtkqN4i45+Rq4l48DpVR9uKkkYkXdhsY5vwwoGKHW3kKkLMXhOW9lEIxRpTxBMozYeqPodj89KI6JWNswg/w7F7MHRq20bmDx7ktAMocmDqu+GDInXg0VzCKf6juELUy1IaDvj+ufaRAAMF8lWBu+B5sqY0efPKaMbFa5ObRJMfjtHzkg6hTX0D/SQBKe9/m8M2tbv13ueFoWGMviovgWve2UTlGagi5IFCbztMFPEqKuWtTQcqUZDIv6tw+JEKtPh5JQTzl+lo/odSb2Jf2EBPNuzd+pvlXJQHq48q4mLHt9F8sLpacyTg4+69owEagJ+z3yTYGpJ83GXUtTKEY8dD7CLf1BI8AEg44lRbydB81HnpMjAks14mKpE/67PY7af1uO5M2/UjBdDL49dkghXQFkfnWTVTWsgXbjJIJS3B74ynBRd7hPXym8Y8N3t6M3RaTanKETZwNmtsJyVAZ2gnqjzzBRCIfQX6nqNk5JvDT7qsfBloyS65zJRKgbd/KGQAqpmdbFrPhkxQU2TKCdkBkOlbTjxgHKBCC8V1iCIk1JCDrh5ff9mey4cSFJh+CmAVzxrEtnhjQAYocnwAFID52r+cEtvdmwhsuldHm/sdQBwZui3H3c45euVHtwtpeb+v3/pyGZQH3aeWBLcgwxe0sOLVgIeIOuG9KCVkK8gTpnKjINH9eIKEo21kqr7QnSIQyl7PziJPYGifBITr9b3eXmFWaoKDoWTYmJn0Uyfn+Pdm+cEDO8kFnI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?85OWmJg6XNH+R8CttGVnt0TLikywBVbKJEv+noOOVKJGJCu/pyWJUgXaIAjW?=
 =?us-ascii?Q?/AvFtQAaHY617Jqo3hLxIUTvT2DBjs70bYK7/PKdER1b7fz41m7zdqa0jMEK?=
 =?us-ascii?Q?uTcXScTL3Z5UQfjGQ77zuixVfzuoRkdi7iuh9AmrFCqAdvrs4eLlKeSeRS2p?=
 =?us-ascii?Q?DU1X0KPfV2aD9E1OCP7MrcQaRpE0Zn/xuvkFw4araIggxyLw6P4pRWQE8yjq?=
 =?us-ascii?Q?nzJriBVnBovD/E79TkDinJYtN6aLHHVeiQwcckka2ZWqtMVwQNz7IUalaAoo?=
 =?us-ascii?Q?9Dtv8iw95VE6y8F3A7cgHKZWohIrVr/4qv2sCV4qmYvd3tQ8an7Dw+JnmubC?=
 =?us-ascii?Q?d7a/0sH6D4JeXyoEJXUJ5sKrxvDu4MXkNa1s2pSmrhjqsfNSbSn9ka7/ZhAE?=
 =?us-ascii?Q?sCzIFhCXDyTFkbe8UQN/5nSH+/XNptwDkHXL6w5FfoH77x+RJQHqannlcGM0?=
 =?us-ascii?Q?lSqUME5C/5b+HAZ60xapdP59KPnd7cmtvfneRvrM0f1d7JwXIxTeqY/24KCu?=
 =?us-ascii?Q?O3XXMtFVpiaaMcII8LVm5iyuMqd/G1OI/YhB7JUbD0JPHjUgDus2JOb1CcjL?=
 =?us-ascii?Q?WXxZSQbiXUnZll9ncBnZMI0oqdHDVejAAPZAXQhlPxLVcBIIL6eZvtBE/QhQ?=
 =?us-ascii?Q?CKLlXMDov78kecbocFEvXeqtMNIxWKUQKCzUfYac/aM1vAoFpuAL1nUS6jUT?=
 =?us-ascii?Q?mOMAcyZZaLEJD/7MTb1oZFJI7El+jlZ03r17YDYH5ApLrXV1Ir8ctxvejAqU?=
 =?us-ascii?Q?XanDu37A4KcwOqD9tTK8F43nGWc6OzjexHu24Z3imZnqCHRVCicK9qblttDf?=
 =?us-ascii?Q?3utUxaw2mmaAsLPOeEiwsI6IEIITo4Tf1B2yCtMC/OkeTV4lltiCsFiSRk5i?=
 =?us-ascii?Q?f7kJZg2jRYP8qsdPMlOYwyz4+V96PJBOpPr5583bNI0gfs/ZD9s0nhYENJ5G?=
 =?us-ascii?Q?LtoIL9XJCNLrmvMKeKaALTmCthAIP+Q17N6wb9kDO50N44w6LbIcaK3ZFL/G?=
 =?us-ascii?Q?7GSwocrmXKRbxg4JKqBYGyuh4DJpqGOO1A8DUoe+2RsPf69MkHh2KcrhWD3U?=
 =?us-ascii?Q?IwQc5LcoTKkw+ofssiN8tICtoLPhqBOYvoG4rR1oM34gVGsuBG64QqVTNpox?=
 =?us-ascii?Q?4R9G3Gu+A893wEYnbCNbpAOyRELc3+SxIBwLHLBRKNazYhpaAbq78WFqC6Fq?=
 =?us-ascii?Q?CTl/qdZrWzmDZJHe9aCWXRPr8oEt1b/Nh50PGx84mqI+CtXKO3fXirkyyFBF?=
 =?us-ascii?Q?ylhB+6/Ch+YOBGWnBIA1K9YqL59HpjK4O2o2MR+AGyu49Vd58m1Zsb4YCaJV?=
 =?us-ascii?Q?7YArUgL06wXNCWpa/h1d4dvdk4gfVOIZcu8kEp02h1ylfX7rtA+rBQjfwKYL?=
 =?us-ascii?Q?L/b6kw2pihZb41yDnH48czHfLN/c8+k8wkMWaV1WmKaqftQXxVhPSgCqgz7O?=
 =?us-ascii?Q?IjcxhiUHdNN4s2YBvkOrrw0r9Jnwh3YstoHw1/7rNdNDDI2iOZ7h3O7Plnzo?=
 =?us-ascii?Q?Y2ZzWnmNquDZ1bjxk9l2WtrXCBxvRGFmhwuh/YsEhDwK0igLa0/cdG9XGtm0?=
 =?us-ascii?Q?Xzt97dQagS3+sttas1Xut70p9BwZm+D772frXdG7vrQ9IFDTu3XlF6+qxSt9?=
 =?us-ascii?Q?2yUIEwNOJuIykcQEB21DK/TqbONGQQBtzjXbBrHU/HhYj3UwrLAU3nRzfwFF?=
 =?us-ascii?Q?ji+DYwYQnBIEcy0csaeFVQwQpQde54w5cm1SJNjx1GxpP3ih?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a0b363-5ae5-452e-9362-08de7f1d3b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 03:21:06.2605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2trnCERMUC9paj49lQp/78Z0E4JdsfxxDN+KEpRX4fnAumdkXSyVu67Mgj6ikuB2BiIUypLYhvVUzgU+CIF+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11445
X-Rspamd-Queue-Id: 4E66925B60F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266445-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,PAXPR04MB8510.eurprd04.prod.outlook.com:mid]
X-Rspamd-Action: no action

> This is a not a small patch for a fix.
> Could you consider splitting it up a bit?
> Say one patch for the ENETC_TBPIR/ENETC_TBCIR
> portion and another for the graceful stop?

Sure, I will, thanks.

>=20
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 70768392912c..825a5d1f2965 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -2578,6 +2578,7 @@ EXPORT_SYMBOL_GPL(enetc_free_si_resources);
> >
> >  static void enetc_setup_txbdr(struct enetc_hw *hw, struct enetc_bdr
> *tx_ring)
> >  {
> > +	struct enetc_si *si =3D container_of(hw, struct enetc_si, hw);
> >  	int idx =3D tx_ring->index;
> >  	u32 tbmr;
> >
> > @@ -2595,6 +2596,14 @@ static void enetc_setup_txbdr(struct enetc_hw
> *hw, struct enetc_bdr *tx_ring)
>=20
> The line above this hunk is:
>=20
> 	/* clearing PI/CI registers for Tx not supported, adjust sw indexes */
>=20
> And the AI generated review reports:
>=20
>   This isn't a bug, but the comment now contradicts the code. The comment
>   says "clearing PI/CI registers for Tx not supported" but the code
>   immediately below clears TBPIR and TBCIR for ENETC v4 hardware.
>=20
>   Should the comment be updated to clarify that clearing is only
>   unsupported on ENETC rev1?

I will update the comments, only ENETC v1 does not support setting
PIR and CIR.

>=20
> >  	tx_ring->next_to_use =3D enetc_txbdr_rd(hw, idx, ENETC_TBPIR);
> >  	tx_ring->next_to_clean =3D enetc_txbdr_rd(hw, idx, ENETC_TBCIR);
> >
> > +	if (tx_ring->next_to_use !=3D tx_ring->next_to_clean &&
> > +	    !is_enetc_rev1(si)) {
> > +		tx_ring->next_to_use =3D 0;
> > +		tx_ring->next_to_clean =3D 0;
> > +		enetc_txbdr_wr(hw, idx, ENETC_TBPIR, 0);
> > +		enetc_txbdr_wr(hw, idx, ENETC_TBCIR, 0);
> > +	}
> > +
> >  	/* enable Tx ints by setting pkt thr to 1 */
> >  	enetc_txbdr_wr(hw, idx, ENETC_TBICR0, ENETC_TBICR0_ICEN | 0x1);
> >
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
>=20
> ...
>=20
> > @@ -801,15 +792,120 @@ static void enetc4_set_tx_pause(struct enetc_pf
> *pf, int num_rxbdr, bool tx_paus
> >  	enetc_port_wr(hw, ENETC4_PPAUOFFTR, pause_off_thresh);
> >  }
> >
> > -static void enetc4_enable_mac(struct enetc_pf *pf, bool en)
> > +static void enetc4_mac_wait_tx_empty(struct enetc_si *si, int mac)
> > +{
> > +	u32 timeout =3D 0;
> > +
> > +	while (!(enetc_port_rd(&si->hw, ENETC4_PM_IEVENT(mac)) &
> > +		 PM_IEVENT_TX_EMPTY)) {
> > +		if (timeout >=3D 100) {
> > +			dev_warn(&si->pdev->dev,
> > +				 "MAC %d TX is not empty\n", mac);
> > +			break;
> > +		}
> > +
> > +		usleep_range(100, 110);
> > +		timeout++;
> > +	}
> > +}
>=20
> Can this be implemented using poll_timeout_us() ?

Sure, thanks.



