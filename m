Return-Path: <netdev+bounces-175581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC87A6673E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 04:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537CB3B6BBE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 03:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73394199384;
	Tue, 18 Mar 2025 03:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k3oHiuDh"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D103010C;
	Tue, 18 Mar 2025 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268541; cv=fail; b=hQvCD5n8BMCzYqsh4MjAoI8pKXxVYrFOSmsg79BGO7IKV5HaPXgN7Je4DVrLVIda38m0kD15nbReAjcJxwbzC70eoepFq8PsH9W179xdOBhu7gIyWvai2QAZeZcb3ZI2hkqcdTbuxiV4QyM5R5qnADcB7tA5H7CHCEGnxqo6cNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268541; c=relaxed/simple;
	bh=Zqk0lIivjgyrQaRvoRlmhLc0EIdMc9/uEcg/SbipNXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OEuBxU6pEiIWM9Bqt0t75+d9D6DbGeiyTbOti943dkvVIkW7SrepuIr/U8oppyJh0LTVD8jD0FAD6LIz4a+nIMwIafeyKZvvuk2EXm0pgRePq+bKLPPzcvWqxM5RWuzg7tJR2p7IT0MXGN8Q69ZtR+CMLZOfKedggU+vXBX76f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k3oHiuDh; arc=fail smtp.client-ip=40.107.20.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz2N/mjNwqZO5OJeYgd8/kdAkR+XojmR+TUCF3eDI/Osvoxdm7LBeGPXI6unrewlvUR/R4fpVcsZ67BRjuHCLl4CxuydgFKxVh4+CP76pdPFiYjmzQV7+HZKFKv54l+F5+qS1lHHvuwQykHZ79oolYl2butXpB4C0tP8pDTJkwyTnj1aKA2cm1UaBRCaj+K14OcGZQFac0tVXrdOjbNw1xUfl1FmufsMsy+1JGbTu6FAUN8Yh8WKg23+x4/q3l/xTVZKsL7K/n5nQQvvol9F+c/v8Bjims6vRjpTjKIAitHdvIcPaXkrF6NGEuwqldnV7vOWmwLbvOeJDHMBJQsczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Z9HDh3qSMJe/SZWV1bn8G3m6v58josMsFdpJgAhMA=;
 b=J4HGDovwrCvt+rPo04dbgVPctTtfSHDW7MI6A3R9yVQxlBER9bDpdAzsFA0jH7Q+jT66VmVIg7aFDZ3kjS2xJSrZXhmziDMMvpU/DjwpI8NnushOtfSre9drN/vM+2o2zD+fwkueK0zgYVQDqS2GPkrKmAOe3/IO7JhCB+sng3sjDmg2AdFBNL5nmaxTKSsVyJUtPiSh/noUIkgeTNdXr4tghoZg9R049aWIcSJdztYoJm03cJPkldIqzV/RFJCu2829IpclmiIX050fwnl6eEihbJrCUnAxQF9WSDmOKUDsj3OrJakqc6F04CwI+7mCbhDl9NUuwM0+FgKEaKs1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Z9HDh3qSMJe/SZWV1bn8G3m6v58josMsFdpJgAhMA=;
 b=k3oHiuDhBjb2FXh9o+ub7NvZFg4os60RVlG2AixCsoRTJ3H8NDQGdF6ScPw0kMpu9vJupd1kKMMFAcWZ0YBWvXIpXtVLAFzCqn/lGVgX1t1gO5/GA5HakiSiW37alszYjjwRtjOUT0WrQgPFyG3OfuOKUqlJjspLepJWbJRD/LDQqqi83JzGu6vGOgqxnVm9Lr4bKezCq3uSijuqvuIj3+lXCCiDT04PaJhilIO9Z0g6ZL+59k2x05D79c73Jt0cph6yk/J2L25ClvcIfhawk+zJDgQXg+HAzUppPeBqxyw6v/XMwXbUXl595gQNMVKne/O1cYsq0e+9QSlw48BOvA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7958.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Tue, 18 Mar
 2025 03:28:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 03:28:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 05/14] net: enetc: add debugfs interface to
 dump MAC filter
Thread-Topic: [PATCH v4 net-next 05/14] net: enetc: add debugfs interface to
 dump MAC filter
Thread-Index: AQHbkkpT5OYUzDZlrUy9J4OCxmUCobN3cswmgADSSwA=
Date: Tue, 18 Mar 2025 03:28:56 +0000
Message-ID:
 <PAXPR04MB8510F67EFC80DFCC7B9F13B588DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-6-wei.fang@nxp.com>
 <20250311053830.1516523-6-wei.fang@nxp.com>
 <20250317144843.wp432pgodn4vjejf@skbuf>
In-Reply-To: <20250317144843.wp432pgodn4vjejf@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7958:EE_
x-ms-office365-filtering-correlation-id: 9ce5ce88-2709-445d-5ea8-08dd65cd03ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qFjxWO43xl39mFcHDRBuzZmLq4cMasOvMUyDyHBDKUSeGkBrkCus43JJEsit?=
 =?us-ascii?Q?Ydve0Vpw9icoNosU6+/MABaXsiN+vfzMrtd/vmVKYdkzZ1cpPML7xuj+EShF?=
 =?us-ascii?Q?xWOlif/w8HPGFSkSnk1t6ursM/Z6bYcgYy6YXtnnxugVY+to644nG1WBHeQZ?=
 =?us-ascii?Q?vNd0KTl8ZSW96cyIKk3dMeR2mRKpnEAcxhoGsHF6f+jMahc2olrMoGMyjJQU?=
 =?us-ascii?Q?3ssvUz1is7YXj9V9nfaHqcQm85RsR45qMA/1U7HTS8HJtMVk46GXyHJg8Bme?=
 =?us-ascii?Q?mDxPWXxUWKTGYqHA47hQw/CyT/K87obYvVAMDbhA8lk4AmQ64JOlStioAbFf?=
 =?us-ascii?Q?k4afImdMPdA4unqEd+PtkzKodfQNlqPkx+QA1IF5LP0Aak3uSTSyKrhjH9Ow?=
 =?us-ascii?Q?INtG8z7G9Ae6ohKL/A3YqaOOXGCSWrbDKjYJOJZ8PeBTzvNwiudwPERLzyyk?=
 =?us-ascii?Q?c3OJiCHMrrKZdyEfPmXAv/DUMrENeXqeRgk0tk9fncrSKcAQbxdiPVaiR9QT?=
 =?us-ascii?Q?51706g0XZenwYwnG+Pvn9HLNUTVThki2mEIrVJEBQObL3+LPoVwYxi+afQJR?=
 =?us-ascii?Q?YCNp+d5CL9wDEmemCuMNtrwzQWyc2/orOzvGlnFO/EVk6Ae0s/C5ZS6ubd6e?=
 =?us-ascii?Q?m2MLN2j04fimBChIiqj7MZB9g4daayujSNlwTwQA4bOD/y10T0INSbzsGoWn?=
 =?us-ascii?Q?sPPZBg/LBNrQD5eXWxwdvOmD5LMGYYkXmFNt0fmMI0NmV1EFOXZo3Nc1v/Nt?=
 =?us-ascii?Q?ZidR0UiIdhG65NIjTEPBUfHAiNQZqi6A92tW5X2KUoyt2DvBk3ZBRVsNTEJT?=
 =?us-ascii?Q?t/A7mcmBoWV+id8Q054WTKuyqJohp/Gq+cQr0VbZi0llB9McAWLqeNL4UYgp?=
 =?us-ascii?Q?zD4KXJBhJMFpKlysetzg7Oc8fJrg7brcpPekrj7LbpwmXQn68Yp8B+9N3ubP?=
 =?us-ascii?Q?hhSAFC1TmvMgazlRw6v2+TG3badDkj/Q/rxE30lmtNrNVUCKxGVyfYi/61KT?=
 =?us-ascii?Q?Q1Bmz00LV4Yk0QPDQKCPyhwaiCF46QoS90PbZoQxLrlBMrfI+Pn6zygrQSWu?=
 =?us-ascii?Q?2drbwqwvsAVkviiMLfKWtol66udlFWOBS3AcOmtSXbDplai8zEOLhhy6CajF?=
 =?us-ascii?Q?mHTH/Zu/0IgGBdjQsYc32XGocO0Zp6HZZjhSkxgVOaHNGhBDrVYKc3nZo+gY?=
 =?us-ascii?Q?V/qHG4CCHW+Io1w6NH6Pd9lHR2Dwu5wPC9r/ev7PDY2kura8/tKz2T6eY4kf?=
 =?us-ascii?Q?6WDdBdPr/U2QIhTY3+CR+gcQ2C3kK43rp+pGmmgnZEVc7uKYUePhpfL735qe?=
 =?us-ascii?Q?zaXTjpGXF1BopYJ+MlsU6XHg668J24sXswa8voCoKHlNnIODueZ2hoOrIjhu?=
 =?us-ascii?Q?SCXwfnN27DFjy5sGvF1H+oQk0Bm0M5bgNSmw/OBHMHrCKuv6uHAQcqhgxG01?=
 =?us-ascii?Q?GHoDSzE/tRnBYnjSnJnvTm9m5za5TK5u?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F6U4IkAj4kZa8BTSkKvEU+iyuOoSSLZcQkiwakxNOx7FF5mcjmmnp3CHFX6m?=
 =?us-ascii?Q?Ajzr5vFn9v23/lvubar+yHbH0cOC3kfUdE6732NAIrKsaBE7LvIfJmmAGYk6?=
 =?us-ascii?Q?SqPfQ17nKEJPARynCStk2/QQxWZ5f+ZAr6ZOIlyOmuKzLoo9gAYs42E2ttMb?=
 =?us-ascii?Q?K9ksogDHv/rHOeyXsxFBr7GmS0FF77F4bzDdmb6EdTQ5N34J+waN0sDSjTfs?=
 =?us-ascii?Q?hM6Ca1wr6k2uhAbwQAFoKk18lHNwmZffZxuz28JBogfv5nm4ykvQ83RcQYt7?=
 =?us-ascii?Q?+kNrczojZjyphDco6DZbn7bKV2rfBRipaqgnodEW/bNuQ7VC+JYkyca8Vvd9?=
 =?us-ascii?Q?96V/KPwDwd4tXNq2l8ZqqZkYPEvErbEyu1/ZS3+k2roGN5mrrcJ+Q0PWdvI6?=
 =?us-ascii?Q?4IVFyWUX3uXPbmgtud28KIs4/0y3WPKsGginfMOA4R1C+Xoy0fQYnljPayng?=
 =?us-ascii?Q?lAH8cs/PVw94aJT46gk149lNVzVYMii3+1ZwK1p7w+vkbGKFKyaqzYdlu7VZ?=
 =?us-ascii?Q?s3bFpL0ImF6qenrSVPXAU5Tmt604vHXfFZy2q8zh+A7F8IXT8xcpMk8Er/5C?=
 =?us-ascii?Q?6D0tQbpHRmjSMXnuxwnusCrYmUsq1eb3T+mwT9wDeZ7pvPFDvzXwbqjPADrR?=
 =?us-ascii?Q?yqnA6Wt9ILh8V5rfof5lliUinvwiLSnzViXrCmj/D9DZpBxKtpvQi+ryyn72?=
 =?us-ascii?Q?uGYXWkSmy6EkLxh8ZArbPA5mqLDnAcaTJgrFHlLPGiNrZbbmFGd3pEs27iFK?=
 =?us-ascii?Q?yPbUwYfpNQdOMMttz8HO5kEGc03oruLno0DXH2PequAfWXs++35X54n2bxgU?=
 =?us-ascii?Q?PCBGAcydEwM4lK7hwdGoLV4hspZdXutFZU+YVoX72hiTtzWuiz54+DQaHU+t?=
 =?us-ascii?Q?svImUT4Bu2oDHqZOnXPmQ17jj5sss72R4S721qklecFPOPaDnAyMpcDfj2yO?=
 =?us-ascii?Q?Cs0AQTpWrDalgiXtRDlmEhrZwGNiHRobAd+JGYpToOF/SSd8mnJ4OuuAO02I?=
 =?us-ascii?Q?Wl/hzU5w8ha/76POKaxGQhjtNVYURCkaZb7hKl+tgGihiR08Zfds0LwUJymu?=
 =?us-ascii?Q?GsMFTBblJElE4xMHNqnchrLHs7+VDM1HJllIXjllTxorg5RN5vzr+dKr0ZjO?=
 =?us-ascii?Q?zDjd7AC84S22UW/Sx9dgKxp/pBiaJeU4CWNwbgGxBTSg33GLuO/+4o7cejlZ?=
 =?us-ascii?Q?TScARji7nZbBOhoZe4RgzoQ6NzsCcR57hdmY8cij2DOJn7yrPD/AVS7MC6eA?=
 =?us-ascii?Q?+z5EM8Gbo6zMFMJuLT81gdiYtfkXUETiw/fvufHvibS6uhd4zVOTfelRv9KK?=
 =?us-ascii?Q?vkiNCW9zALNOmtvyhKcFaQNQygzBQ0XDipB+yLV7Whgb63kHZBcKXocqNQue?=
 =?us-ascii?Q?yq3H8XBpU6ao6yuQ3yc9amrqpeCDuDmamEy9FWxfDa3L9IqnK2Lzix7Nt+Ia?=
 =?us-ascii?Q?Fg0lG43/dM4d5qAl7rhEp1puX5Bf6mtzIJ5Dk39DVn/RCOQHR98NCtGtwuEH?=
 =?us-ascii?Q?4a7mQaYFQodlPQUSd8fu2zrFUVZ1tFFd+7jpsI2efKXcbBq5N76qUakQLmMn?=
 =?us-ascii?Q?RMET1B+uD+a6CmZEKb0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce5ce88-2709-445d-5ea8-08dd65cd03ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 03:28:56.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBth9J24Qxn7T3NcOx+ZJDST87ChMh73irWVZkjHkXl2QEmuHQOlcpGusGkQFbgfKRGPY6Xf4HsH8Hyrxr9ADw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7958

> On Tue, Mar 11, 2025 at 01:38:21PM +0800, Wei Fang wrote:
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> > new file mode 100644
> > index 000000000000..3a660c80344a
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
> > @@ -0,0 +1,93 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright 2025 NXP */
> > +
> > +#include <linux/device.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/seq_file.h>
> > +
> > +#include "enetc_pf.h"
> > +#include "enetc4_debugfs.h"
> > +
> > +#define is_en(x)	(x) ? "Enabled" : "Disabled"
>=20
> str_enabled_disabled()

Oh, good, I wondered if there was a general implementation in
the kernel, but I did not find one due to my limited knowledge.
Thanks!

>=20
> > +
> > +static void enetc_show_si_mac_hash_filter(struct seq_file *s, int i)
> > +{
> > +	struct enetc_si *si =3D s->private;
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	u32 hash_h, hash_l;
> > +
> > +	hash_l =3D enetc_port_rd(hw, ENETC4_PSIUMHFR0(i));
> > +	hash_h =3D enetc_port_rd(hw, ENETC4_PSIUMHFR1(i));
> > +	seq_printf(s, "SI %d unicast MAC hash filter: 0x%08x%08x\n",
> > +		   i, hash_h, hash_l);
>=20
> Maybe the ":" separator between the high and low 32 bits is clearer than =
"x".

I want it to be presented as a full 64-bit entry. If it is in the format
of "%08x:%08x", it may be difficult to understand which is the high
32-bit and which is the low 32-bit.

>=20
> > +
> > +	hash_l =3D enetc_port_rd(hw, ENETC4_PSIMMHFR0(i));
> > +	hash_h =3D enetc_port_rd(hw, ENETC4_PSIMMHFR1(i));
> > +	seq_printf(s, "SI %d multicast MAC hash filter: 0x%08x%08x\n",
> > +		   i, hash_h, hash_l);
> > +}
> > +
> > +static int enetc_mac_filter_show(struct seq_file *s, void *data) {
> > +	struct maft_entry_data maft_data;
> > +	struct enetc_si *si =3D s->private;
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	struct maft_keye_data *keye;
> > +	struct enetc_pf *pf;
> > +	int i, err, num_si;
> > +	u32 val;
> > +
> > +	pf =3D enetc_si_priv(si);
> > +	num_si =3D pf->caps.num_vsi + 1;
> > +
> > +	val =3D enetc_port_rd(hw, ENETC4_PSIPMMR);
> > +	for (i =3D 0; i < num_si; i++) {
> > +		seq_printf(s, "SI %d Unicast Promiscuous mode: %s\n",
> > +			   i, is_en(PSIPMMR_SI_MAC_UP(i) & val));
> > +		seq_printf(s, "SI %d Multicast Promiscuous mode: %s\n",
> > +			   i, is_en(PSIPMMR_SI_MAC_MP(i) & val));
> > +	}
> > +
> > +	/* MAC hash filter table */
> > +	for (i =3D 0; i < num_si; i++)
> > +		enetc_show_si_mac_hash_filter(s, i);
> > +
> > +	if (!pf->num_mfe)
> > +		return 0;
> > +
> > +	/* MAC address filter table */
> > +	seq_puts(s, "Show MAC address filter table\n");
>=20
> The word "show" seems superfluous.

Okay, will remove it.

>=20
> > +	for (i =3D 0; i < pf->num_mfe; i++) {
> > +		memset(&maft_data, 0, sizeof(maft_data));
> > +		err =3D ntmp_maft_query_entry(&si->ntmp.cbdrs, i, &maft_data);
> > +		if (err)
> > +			return err;
> > +
> > +		keye =3D &maft_data.keye;
> > +		seq_printf(s, "Entry %d, MAC: %pM, SI bitmap: 0x%04x\n", i,
> > +			   keye->mac_addr, le16_to_cpu(maft_data.cfge.si_bitmap));
> > +	}
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);

