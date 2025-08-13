Return-Path: <netdev+bounces-213160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E0B23E05
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 04:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4797581E46
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B913AD05;
	Wed, 13 Aug 2025 02:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICktE+M0"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84120EB;
	Wed, 13 Aug 2025 02:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755050655; cv=fail; b=A5apgB0jhjUZX2ZvXFj8mHC5J3RdeZDwmgX+rWT1x6uBS8GWH7NZWOysKGxNX1pbkfXEsk8XYCRkr+/bXuoDh7d9s5kYiTXcmIYDGnvK4ZuYdhh8z3sOzNzhUZC4AJSS/bz27kMCQnCf9IB9LI6lKCZpcgHGDbJvNGhM43N4gsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755050655; c=relaxed/simple;
	bh=dbfWkUdpcU18Ive340xnltOiUp5nrt+EHe0IhgryEBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DKGs/1PmhNhV5a4HFhNtrwpoBM9B5KIO5tkSmW2KZuf9bSWS5LiNSZJGKe05kjqy3i5Mw4xt/YjjKWV8GX3ECtx1tbeePgoohnxaQ2J2siZ9ffnDsotOclsteILhD7zabsbpIo5IBSzegDTepNvDBoAVJKYdDvwagzFR80Jqs1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ICktE+M0; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMw5gOzC2ZTbbbwJfubvBeiMLm7FDEwAogG2iAfh6T9PL3khfTMQnZOuLng6jAYwYWnC4A15oSeJs/JuIu9g1DsKonW88L6BPxn+OkGFzN6n650In5Ti29EVSJN/m/SDbDAIJE/MGyWOSRpda6/1G2SNN+SAyAplvXutxY8x86BvUrabRS4mW3OdQXbe43PHSVRtiVm1byg5SvDeQwEu5WwjNC+sHzwhGlBIadyWTSdGJ6p+eQKFdZADv2H7izeCBZ1EvGLOzGk6oeoALhdD0Y0aGm3pJe2S5aINHtjjwjBg1O1Dz4BTgsPDLlP36gd95ZvjB8DQQknUp5iuTxVZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5MwyvzBpZ7lGiXLdMrOA1x4/KtkDsk1/5DSxNhBVkQ=;
 b=MhEICeBuCvNYFGsx5U5O5+ra1KClV9m14scon+qhO0CXICP+tBFRFmEGfHwCi/3FSKhvrgL+OQN6G+Rp9IQEggmvCGudURIeqOzD8ZpWbbYLfYVQqs63/oQjxdDAxf9lVie/GVKvSh27xpENnOT42cV65xqTeWD2ZWWvbZ8ghI6eyzKdIFYBPMRDd1BM/sGMUA1dUF2g2eZG0UnO5Plsr1uuF01ZYarX7wMZxRxTiw6UR544BaJEZag4KA/4QfF736uVd22XsVjhYw4hTH6+jfy08u7kObhqAtOjj7dAZpCwiR8eCzu9png+VHPvcCIG3eCWMcKrlhQWsjwilnp5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5MwyvzBpZ7lGiXLdMrOA1x4/KtkDsk1/5DSxNhBVkQ=;
 b=ICktE+M0GpIpf9NvvD7Vnfb42b7vTDzlGGiL4hIHdrfwvGIRTkpvKQV+XzTLKDOQ70YthynJK0PGbcwNZMIFtFiv9znX+qOmhG9W3vNmSCwSF2ioTYWagEUznZl1nGElu6euM1FMQ+6a6mLDTYvtKe/g5MGDxeTNgTwzDxb4lS1eCNg5lW7xVrhI/xsLYQ6TBclbYKjtZtrp4hDqV3L0Kru23juE6NXGji1OwoNX0uMZEkbNP8EPB3lR35Srl2PaxbKSRaeYgoOdHP8vVQkPLBmb6PmKN22bxq0mFYO1W1Sh7JCtZL6dBQihxfdewKOkPGgvNyYoEKPQyaJgGlim3g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6914.eurprd04.prod.outlook.com (2603:10a6:208:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 02:04:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 02:04:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 11/15] net: enetc: extract
 enetc_update_ptp_sync_msg() to handle PTP Sync packets
Thread-Topic: [PATCH v3 net-next 11/15] net: enetc: extract
 enetc_update_ptp_sync_msg() to handle PTP Sync packets
Thread-Index: AQHcC3EEapxdw4YqLUKwOg6uIzbfubRfK2KAgACqoqA=
Date: Wed, 13 Aug 2025 02:04:08 +0000
Message-ID:
 <PAXPR04MB8510012AF918CC51DE7449FD882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-12-wei.fang@nxp.com>
 <aJtjSbZGZC/w1YAs@lizhi-Precision-Tower-5810>
In-Reply-To: <aJtjSbZGZC/w1YAs@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6914:EE_
x-ms-office365-filtering-correlation-id: ab8cedcc-0438-4059-cac5-08ddda0db055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/H+1r4TIY2qVabQJC+quk474m6HMfchta/KaDSHmHRshojlfts1IDXiLUKo/?=
 =?us-ascii?Q?yd+mn+8uEsPjSVDzO1Za+Ef++qmF2W4pNRfRXRAm6k2efBD0jlrttW9xl+Hu?=
 =?us-ascii?Q?FTIUQC9p/oicNUQqT6L0OYoMkGFE0UEEyUqLmBvDkHdKpwSs+fBYkGD5hXe4?=
 =?us-ascii?Q?iF7MwdOCXRq4SFoCMo32PXrZ2diMEBRstDEX9OcJRR9EqH7hI5FM4rWmdOuj?=
 =?us-ascii?Q?yEc7uAn83U7z2GcQ5/r3EPwMMJJCn2qHxypMSiNPcXmdLhV10eefdZIeLWt9?=
 =?us-ascii?Q?vUCSDCO7IJtlxEryMPGWXq3wraCb2Eg1jRMMzTlZNyfo56TS3pvq/JH3SmbQ?=
 =?us-ascii?Q?Jep3UJTzWj+A+9k+mJGiH2unc9fE/HQzz9Sn6ZMSq1NUzW/yJ6YBhZH5lKVm?=
 =?us-ascii?Q?2ryntykD9LB4rpvJ/xPJ0I7F9tty3MX8/5VTKzhG62/qQjg9dSba5Q1NXfL0?=
 =?us-ascii?Q?CvOCrkrPG7IGXsKR3vNm29WjQOSW5CygKgEQOSQTph7G3Un5LQYlPf6l8WZY?=
 =?us-ascii?Q?1w9NChO/PUeuQ/oOHGIEYYoWC+WzIwio8zRzPRxi/BdlLWT4mS7Iltd0AssY?=
 =?us-ascii?Q?/tb3oCNCfTrwwNnBGVM2lCUvyXyZQkcLyjCwBnoArS27vTeX0gHYph27kdRn?=
 =?us-ascii?Q?klulxqTgmRHyYkd5la+Ct/QhuljBIyv0HM+w1pVzefUyDLpEKGv6bXhdEc3x?=
 =?us-ascii?Q?t4fuAefLb2fUXZYb5dA3b2D57b3GCVxydqxHiLWWrgBQkjp6zXI01IVVLMUr?=
 =?us-ascii?Q?cwMMk3ovBiGLHp0oWYShs0bRJTrCB+8FFPvATG8J89pslx9hjuVKSB+3x59v?=
 =?us-ascii?Q?jxs39UvCBFZA1LQqvQeCTA9TyX2fbOcIy3F0R/mS8wt3sQO3LVZ5Pznky2WF?=
 =?us-ascii?Q?Dux4wrlqHSPqQo9a1jfx9hD1yymHatUvIyzi+yUthHVgsB/JDG8KbMXDFGrr?=
 =?us-ascii?Q?jnY2RqdHjB86aiNbLsp4XkgTj2r3r/T+J6G28vXXS18l0mMiVEFkY+ZdZHpe?=
 =?us-ascii?Q?5CUNhBILxfOP1oXXkzYrs1MtTM2wOah7Vb/o127eQXf1KtrXNBKRSbd+apd5?=
 =?us-ascii?Q?aNfhQaGL8027nB9C1Wd2vHop7SKLamaoWnY9DuVoSJ1jYr8l2iELSr1V1ljH?=
 =?us-ascii?Q?sB21S1MK8+8/tCUpi3O81elbyaUsI5xQTmsVregAUHg6bxZ4IbgPtluHu1vw?=
 =?us-ascii?Q?k+hhb0dnpUY/bLGx2JwFY04NISKw3MaCEsc/sdlwzrHqJ7yAeKWBLOYBBoBp?=
 =?us-ascii?Q?H9xRtKUG0NLcNzFAIYRV3XyBym6sACaoUoxCO1fpGQpsNA2aGvujIzYnvuCg?=
 =?us-ascii?Q?b/UKmRwJ990B1KdNqtAIbBopeDowGSLyugmT5Ox0kBPL7uFQbKrV2+XzJAHH?=
 =?us-ascii?Q?jTQ0ggfcs0cZjviE86ih3zBbuC+FVyHY45IlOh9tq8uE/suq74TYGCghADWC?=
 =?us-ascii?Q?Zes2QFBINbmxibwvzQw94zl9yh7IVFPa2HUC/TD1uBPQ/w7U74enHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Bcy8rvz6VqmmGAx4zDxhpD7MA0Z3ry/toL+QnI3lJAXvjK2/NTXNLVHfePMS?=
 =?us-ascii?Q?AyBGf9LFLVnFHelx0JT+pIne/79iGNBAZXBlxFIptB+xIfBVj6GgLIwdWj/a?=
 =?us-ascii?Q?J20BMKjoofo3E4vEwMGzfq+cgjUdRuI/Gj9vFyzw1c9d0bbIK6EbtyvXVc6s?=
 =?us-ascii?Q?UijTEseLmH8wBgVaKITvkMIxrFBngL/9U3aSeYZR7S3KowjnD0bhPTD6vA0T?=
 =?us-ascii?Q?n/g8npb6vpjdyJGZW3Y0A0vuClZ7p1mCubC4pLEvPWyfL1MoTrtF59z+Yp70?=
 =?us-ascii?Q?j/jXqZrK5l1g7tp5/A6H5SuhPyQzqyKhNa5tBvQOH8ztOezp+7sOQNEVsfvw?=
 =?us-ascii?Q?l2ZJhZx013yhqJl6HfVun4++0TeDa2ZnciYGrlNIFbSC4hk16TIjRfJUL8Zb?=
 =?us-ascii?Q?gya/aN2NAqkJIrf7Xg2rPz7E5J4xoleFUdqwaMa3mBS/JRRXT9yKSTuwgbIX?=
 =?us-ascii?Q?Q0FMQpnqXjQxkmlt+k18Y+5iwh66gEp7achr0YSCIndwsoVN0QnFs3HDM81S?=
 =?us-ascii?Q?AXWO1eAAfkyCaexra7Mecph+x1OpTaDU9q/GyJqQeKhpy+wCE05vs40GEESv?=
 =?us-ascii?Q?anLRn50CJ/RRZ4/yRU+jD+/LArEMA3ccvYvXGy6RNtxOA5YCAg8RMwUBLx+O?=
 =?us-ascii?Q?+n+b6WwvgJwCjegd/f+rSB8t79j+Nr/AZJDb+fAM2o6t4ROfxLfkXs8yuiwF?=
 =?us-ascii?Q?p6om8Xbiu5Ljx7GYLscQ00aTIuiD9O2M8V5/XRWM0i+YC0lSKygsb0f7zo+Y?=
 =?us-ascii?Q?7YrVVf1+76iuHwt6DCfK8nN38ouAYDQhX/fq1wqS3ZEWygd0TFE85mzNJmmj?=
 =?us-ascii?Q?/+XGQizN2V535tfKHUsFwPAuL+9juG5ZQKG/ulkzAIqoCZYP14HFMHEracva?=
 =?us-ascii?Q?jfbKujUNjRstL3vb+NstyVn9xVgOGCPcttg/s0vo31aYxUxKPdYfw2fNl8tj?=
 =?us-ascii?Q?0H7PLOTUTSqO8gWCpp559Cb6mMqCbanoFO3kfT3BHEQydjtKtYsgFmZp3017?=
 =?us-ascii?Q?3ow5qXVyJs3AX8U2Di2rC4z5nY6HCjgrx+ZY9cWBLELlhcU3ld92XgW/gBIT?=
 =?us-ascii?Q?5wt0jRRBDE+RerJoXhW762YmW1BLMp/YScSG9omYiHaRCCDSFSEqK1vTefNn?=
 =?us-ascii?Q?Xmoovns7bzUkRWfPU6Kn+6X4+CdE/ch2vGfxQi9+CP3DQT2vmEYQZHtzzXCA?=
 =?us-ascii?Q?gajJeCZ4Jc9FT5EkWMJJf4ho3WCZhrYaBLEKcJizlndEfPvmFDQ7i5e6aXqh?=
 =?us-ascii?Q?cDymZcxgaq7uIcbENAQZlalT48d3BA0wNIVrZrRfW8sDFEr/wn5pDdGERzpZ?=
 =?us-ascii?Q?XtYUHIdiVhEQJ8elJb6jAWI9DxbBwQQC3aUi9udj+5v/2XSNrvy/9wCtKgEz?=
 =?us-ascii?Q?oDkVJomU1QRpLO6/GnNvpNUIFdQQKiYp5vth1dI1KN3AYvW+pI7uBm8UEgPg?=
 =?us-ascii?Q?Crey4vVDsRaWqkLc22hHFXYR98VzxvNALxJU4oRdFAv3oo7cLAtRJZxnAq32?=
 =?us-ascii?Q?fsVm2WAlt4nipykQOR1RF407QhuUhJ+DxeAI6Ttj/NInqyOih8FWyH3vRWlH?=
 =?us-ascii?Q?Kro44iAeDh4mg+AmsOc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8cedcc-0438-4059-cac5-08ddda0db055
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 02:04:08.4045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1y+6iqC8sNzQGUm25DxqQKr3MIzsmCc3SOuFC29ejOJBlTeKFPrVgOrV/NCGSYZ/m8Sgk9kC2g3OydT8qCWxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6914

> On Tue, Aug 12, 2025 at 05:46:30PM +0800, Wei Fang wrote:
> > Move PTP Sync packet processing from enetc_map_tx_buffs() to a new
> > helper function enetc_update_ptp_sync_msg() to simplify the original
> function.
> > Prepare for upcoming ENETC v4 one-step support.
>=20
> Add "no functional change".
>=20
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> > ---
> > v2: no changes
> > v3: Change the subject and improve the commit message
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c  | 129 ++++++++++--------
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |   1 +
> >  2 files changed, 71 insertions(+), 59 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 54ccd7c57961..ef002ed2fdb9 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -221,12 +221,79 @@ static void enetc_unwind_tx_frame(struct
> enetc_bdr *tx_ring, int count, int i)
> >  	}
> >  }
> >
> > +static u32 enetc_update_ptp_sync_msg(struct enetc_ndev_priv *priv,
> > +				     struct sk_buff *skb)
> > +{
> > +	struct enetc_skb_cb *enetc_cb =3D ENETC_SKB_CB(skb);
> > +	u16 tstamp_off =3D enetc_cb->origin_tstamp_off;
> > +	u16 corr_off =3D enetc_cb->correction_off;
> > +	struct enetc_si *si =3D priv->si;
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	__be32 new_sec_l, new_nsec;
> > +	__be16 new_sec_h;
> > +	u32 lo, hi, nsec;
> > +	u8 *data;
> > +	u64 sec;
> > +	u32 val;
> > +
> > +	lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> > +	hi =3D enetc_rd_hot(hw, ENETC_SICTR1);
> > +	sec =3D (u64)hi << 32 | lo;
> > +	nsec =3D do_div(sec, 1000000000);
> > +
> > +	/* Update originTimestamp field of Sync packet
> > +	 * - 48 bits seconds field
> > +	 * - 32 bits nanseconds field
> > +	 *
> > +	 * In addition, the UDP checksum needs to be updated
> > +	 * by software after updating originTimestamp field,
> > +	 * otherwise the hardware will calculate the wrong
> > +	 * checksum when updating the correction field and
> > +	 * update it to the packet.
> > +	 */
> > +
> > +	data =3D skb_mac_header(skb);
> > +	new_sec_h =3D htons((sec >> 32) & 0xffff);
> > +	new_sec_l =3D htonl(sec & 0xffffffff);
> > +	new_nsec =3D htonl(nsec);
> > +	if (enetc_cb->udp) {
> > +		struct udphdr *uh =3D udp_hdr(skb);
> > +		__be32 old_sec_l, old_nsec;
> > +		__be16 old_sec_h;
> > +
> > +		old_sec_h =3D *(__be16 *)(data + tstamp_off);
> > +		inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> > +					 new_sec_h, false);
> > +
> > +		old_sec_l =3D *(__be32 *)(data + tstamp_off + 2);
> > +		inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> > +					 new_sec_l, false);
> > +
> > +		old_nsec =3D *(__be32 *)(data + tstamp_off + 6);
> > +		inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> > +					 new_nsec, false);
> > +	}
> > +
> > +	*(__be16 *)(data + tstamp_off) =3D new_sec_h;
> > +	*(__be32 *)(data + tstamp_off + 2) =3D new_sec_l;
> > +	*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> > +
> > +	/* Configure single-step register */
> > +	val =3D ENETC_PM0_SINGLE_STEP_EN;
> > +	val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > +	if (enetc_cb->udp)
> > +		val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > +
> > +	enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP, val);
> > +
> > +	return lo & ENETC_TXBD_TSTAMP;
> > +}
> > +
> >  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct
> > sk_buff *skb)  {
> >  	bool do_vlan, do_onestep_tstamp =3D false, do_twostep_tstamp =3D fals=
e;
> >  	struct enetc_ndev_priv *priv =3D netdev_priv(tx_ring->ndev);
> >  	struct enetc_skb_cb *enetc_cb =3D ENETC_SKB_CB(skb);
> > -	struct enetc_hw *hw =3D &priv->si->hw;
> >  	struct enetc_tx_swbd *tx_swbd;
> >  	int len =3D skb_headlen(skb);
> >  	union enetc_tx_bd temp_bd;
> > @@ -326,67 +393,11 @@ static int enetc_map_tx_buffs(struct enetc_bdr
> *tx_ring, struct sk_buff *skb)
> >  		}
> >
> >  		if (do_onestep_tstamp) {
> > -			u16 tstamp_off =3D enetc_cb->origin_tstamp_off;
> > -			u16 corr_off =3D enetc_cb->correction_off;
> > -			__be32 new_sec_l, new_nsec;
> > -			u32 lo, hi, nsec, val;
> > -			__be16 new_sec_h;
> > -			u8 *data;
> > -			u64 sec;
> > -
> > -			lo =3D enetc_rd_hot(hw, ENETC_SICTR0);
> > -			hi =3D enetc_rd_hot(hw, ENETC_SICTR1);
> > -			sec =3D (u64)hi << 32 | lo;
> > -			nsec =3D do_div(sec, 1000000000);
> > +			u32 tstamp =3D enetc_update_ptp_sync_msg(priv, skb);
> >
> >  			/* Configure extension BD */
> > -			temp_bd.ext.tstamp =3D cpu_to_le32(lo & 0x3fffffff);
> > +			temp_bd.ext.tstamp =3D cpu_to_le32(tstamp);
> >  			e_flags |=3D ENETC_TXBD_E_FLAGS_ONE_STEP_PTP;
> > -
> > -			/* Update originTimestamp field of Sync packet
> > -			 * - 48 bits seconds field
> > -			 * - 32 bits nanseconds field
> > -			 *
> > -			 * In addition, the UDP checksum needs to be updated
> > -			 * by software after updating originTimestamp field,
> > -			 * otherwise the hardware will calculate the wrong
> > -			 * checksum when updating the correction field and
> > -			 * update it to the packet.
> > -			 */
> > -			data =3D skb_mac_header(skb);
> > -			new_sec_h =3D htons((sec >> 32) & 0xffff);
> > -			new_sec_l =3D htonl(sec & 0xffffffff);
> > -			new_nsec =3D htonl(nsec);
> > -			if (enetc_cb->udp) {
> > -				struct udphdr *uh =3D udp_hdr(skb);
> > -				__be32 old_sec_l, old_nsec;
> > -				__be16 old_sec_h;
> > -
> > -				old_sec_h =3D *(__be16 *)(data + tstamp_off);
> > -				inet_proto_csum_replace2(&uh->check, skb, old_sec_h,
> > -							 new_sec_h, false);
> > -
> > -				old_sec_l =3D *(__be32 *)(data + tstamp_off + 2);
> > -				inet_proto_csum_replace4(&uh->check, skb, old_sec_l,
> > -							 new_sec_l, false);
> > -
> > -				old_nsec =3D *(__be32 *)(data + tstamp_off + 6);
> > -				inet_proto_csum_replace4(&uh->check, skb, old_nsec,
> > -							 new_nsec, false);
> > -			}
> > -
> > -			*(__be16 *)(data + tstamp_off) =3D new_sec_h;
> > -			*(__be32 *)(data + tstamp_off + 2) =3D new_sec_l;
> > -			*(__be32 *)(data + tstamp_off + 6) =3D new_nsec;
> > -
> > -			/* Configure single-step register */
> > -			val =3D ENETC_PM0_SINGLE_STEP_EN;
> > -			val |=3D ENETC_SET_SINGLE_STEP_OFFSET(corr_off);
> > -			if (enetc_cb->udp)
> > -				val |=3D ENETC_PM0_SINGLE_STEP_CH;
> > -
> > -			enetc_port_mac_wr(priv->si, ENETC_PM0_SINGLE_STEP,
> > -					  val);
> >  		} else if (do_twostep_tstamp) {
> >  			skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> >  			e_flags |=3D ENETC_TXBD_E_FLAGS_TWO_STEP_PTP; diff --git
> > a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > index 73763e8f4879..377c96325814 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> > @@ -614,6 +614,7 @@ enum enetc_txbd_flags {
> >  #define ENETC_TXBD_STATS_WIN	BIT(7)
> >  #define ENETC_TXBD_TXSTART_MASK GENMASK(24, 0)  #define
> > ENETC_TXBD_FLAGS_OFFSET 24
> > +#define ENETC_TXBD_TSTAMP	GENMASK(29, 0)
>=20
> Suppose this type patch no any addtional change to reduce review efforts.
>=20
> Or you need say replace 0x3fffffff with ENETC_TXBD_TSTAMP.
>=20

Okay, I will describe this change in the commit message, thanks

>=20
> >
> >  static inline __le32 enetc_txbd_set_tx_start(u64 tx_start, u8 flags)
> > {
> > --
> > 2.34.1
> >

