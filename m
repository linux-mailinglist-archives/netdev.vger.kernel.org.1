Return-Path: <netdev+bounces-175595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34022A66914
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE45C3A9286
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 05:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221991CB518;
	Tue, 18 Mar 2025 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H/6Bpbwl"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2441A8413;
	Tue, 18 Mar 2025 05:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742274750; cv=fail; b=mbRWOoSrq37NZ2TEi/JnuRjOihNXHlqxWbY5CiuLgbzDOCWGrCKmEPsgtXhFCYHmG1pfe3NivxJduyYZHsus/92/RIxSNdC3opWeeUnx7rMEWTjMwFM7XwbDYgmpBkc5V2FlIlo4AGhfbjH7LeP0hbRv8+tgsYvfeQ10bVLfgKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742274750; c=relaxed/simple;
	bh=nnm5GntivG0nPi2vGqUlz6yj0N7lHR8YzCZS/hrETwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uxH7K1VKHvFIuR3TUF4GBiI4775C2HhN2GylYUoTvxGCamM8l7XgfCh/7OhzbHt47T/qhAWToaS5RC26AwmabFIuu3b3O4tGVVFaLAUftXoYncc5s9NAMIPZW+UeS/lhvqK2VaaAHhHt9+hClTp6wmjXZdHfIKWMko6FCPTNjzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H/6Bpbwl; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMGGlki3/g6ZFqV62ed1JrPV4PgZ67kQv10oOdbK7Gtj0KBMdvNeTYHAYCKrEQxQqlc8JwgDFMauOekkrHirZnhRZ3oc9WYZEqSnwF2skDc24rLPvelXGbK8FuraD2Hea/3k/ChtLgzwAyCY9JD9ZR4h9xyCQELF9Z/PI+johD6BvvSSOhzpkQ87mjti4P/anv0RVVt5qlr4ZomDF0VrdlxSJ9xTjsG9M/vxki/8ZW4qiUzdB5KGDM7vUsZZAs2xKn5vFe/1O1axBOt7ep53IYjL8jPeMsluuwp1SRqBoUHut5CbmGD2g+gg3/Gx1ol9yfGXLsxUyqStrVdWwKS8wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnm5GntivG0nPi2vGqUlz6yj0N7lHR8YzCZS/hrETwM=;
 b=IVQCPwPL9SeKAo5+nJJAM/5Eafme0Wa9Wt2tNYK4pQs2zu3igdSmymtrcfxgD8tdNWcF29mmb20EN/g3qzqMw9p0i/WdrytCmRfl708TT+JrTnbvw+WNa+zzYMYDApUTD38fol9BLWnKBM6XDF5QiL4BO2/8/QVoHSS8nD8ypjcJMdi/JhT0yfZsbSbJAuA4CBhGK9OXeGwIxwK1GHCp/OCJSpjmv3S2SriHyvrx2rI8kXm82v5V4Tje5MCXCGhXPjmdX58nOjq1XgjKXPzaHHJoT0ZbI4fTR/6L4+jpEEyUCWVILC1429jnNOX/Z5YCnrbltwEwfNvtNYGEJvTR1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnm5GntivG0nPi2vGqUlz6yj0N7lHR8YzCZS/hrETwM=;
 b=H/6Bpbwl+YhraGlCisF6Wql3Lj61rQMrpbHlajxSpH5xKRFe1brZnlkHxUJQkvAS0J68mm1xZxaYQvhc76L9Hh/MrctU6l0jYB41Yn8aYOG5TIxnTOkhE6FFt/gEIXo9psR/recOm50lCDU0+4BkPods2NvNQCxolm5FIi8qf2s7tA4eFdnGG8NInDI5H1nBRWSvRaXdYid0SYXg+xM6qP+GBa/5D0fP+vufAAZ11NosXarLmRy2vTCz8Tp+COjfXJWBs+4lgVcwTB9MPT2WINqnTvq69KF4k+V2KHrg4i/C3okA5pf7i2YhvWMG6hrOk6eAEoGPQ9FE1UE7fCdLmg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10536.eurprd04.prod.outlook.com (2603:10a6:150:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 05:12:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:12:25 +0000
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
Subject: RE: [PATCH v4 net-next 10/14] net: enetc: move generic VLAN filter
 interfaces to enetc-core
Thread-Topic: [PATCH v4 net-next 10/14] net: enetc: move generic VLAN filter
 interfaces to enetc-core
Thread-Index: AQHbkkphbU6iBn6QHkCn+bTGbbl6OLN3mOwGgADJvJA=
Date: Tue, 18 Mar 2025 05:12:25 +0000
Message-ID:
 <PAXPR04MB851056BB4772F971F87C70CF88DE2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250311053830.1516523-11-wei.fang@nxp.com>
 <20250311053830.1516523-11-wei.fang@nxp.com>
 <20250317170511.u7kfzmqafznovpoy@skbuf>
In-Reply-To: <20250317170511.u7kfzmqafznovpoy@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10536:EE_
x-ms-office365-filtering-correlation-id: b3c226a1-ac4d-4128-898d-08dd65db788b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T2y3C8vRG5rRYxUDA61QTEaLlJWVxOiUediZ+aTbtTkcjEUaSozBzrM3pQ6N?=
 =?us-ascii?Q?qdlPFcpMnCsEI3R/HE5BUCJBPNRf3ceCXxVfMBAcMH0xFQq90AxYffD0LNmC?=
 =?us-ascii?Q?tS6gJY+VdFj2KfkwhD1jKSIc7hUi6ucVuL0FGXyiNDv1UM7sj69hbmeRvHqJ?=
 =?us-ascii?Q?mKGlhnH+BgBW6V9utmDJEvAMYYqzabPsU/TsG11tuiGxT8VtOjdAYCxznW3y?=
 =?us-ascii?Q?Fl/q8RUGfIjktT0EHZgk/iL2v7ewopQCG2x0ARAxx5CMULYM7+8E61ukDXw5?=
 =?us-ascii?Q?3LgkNpc74uW3sv02OiOZcPf/mKViR/tKyhPMjdYSecGvM05jnr2ACY/+7KyW?=
 =?us-ascii?Q?3/peqtwHySq/HmCGC++zRbpzTsy5elLxktQ+cX028JSpgNPRrL1p8/+6Gkem?=
 =?us-ascii?Q?G4KHel0GJCF4RzQfC8jumbPHoed6bFdqhRfmEMJosewIjAkdS40Ie0n0x4+8?=
 =?us-ascii?Q?CzS/3iAq1LWzre+cTRa8XtILfo9Ix/jD65fEIFsumFBu8GjnvsRiQrF8EwGw?=
 =?us-ascii?Q?getInYPgM5bqEZrkIMNgtsTmz828+1IpZnXI4JM6CyUOYkgIte3E9cghVqAy?=
 =?us-ascii?Q?jEiF3vp6WToFOpu3FtMAtRDLlV0fjxJIU2CnWMPjvckiPIy85vz99xM84rzz?=
 =?us-ascii?Q?f8y+neFuzefxdRSLPuBTYQDYSshMnAn7gJHhAgtVchD+GZU0xwOXPF0uBuve?=
 =?us-ascii?Q?wx+ihIXS0eji8yK5492oXFYd+DstAwWr4Uc1tW1ngV+xszHqGgrQ7aER8B9w?=
 =?us-ascii?Q?vCY7hIvQL1+9uaY2issO84nhoeocd+afHt0BYINVIKPOwHqQ+2mOaJQokARK?=
 =?us-ascii?Q?yGZI2UGc+qzBWMHqQXc/k4dMNPowpNhPOe3cYSQ4DTruVPmql0QYynPqNV6i?=
 =?us-ascii?Q?TVFTg+wq4jVT3Y2HfHz5xjyZc9ejGII2EqCnybRxXlTnRk+9cy6RGsU5tjr0?=
 =?us-ascii?Q?DwnrLLuUCcTuLuouuvLdgl5blhzLf4U+g63qianRZltTVpw8aZkWI4X34st6?=
 =?us-ascii?Q?uuOs9dRSiuuNNo98z79mOw3cCoHrAw2bht0uFlPcGtM1kHhfUruSgv7YDV8v?=
 =?us-ascii?Q?maIoPm4YEcB4e001kD/Wp67zGwO104BV1K/qpnWuUBzPjRZXjlCL1si9Rq04?=
 =?us-ascii?Q?e16Hp/mQ9pxlYAVbuTvXAH8q1cOo9gHGGfZhUf+brQFyeFwslsfGTSK8z9c3?=
 =?us-ascii?Q?O8+Z4MbcbetftJA602NMhpT8w3NJrUxbxJQDf6XDnzOTWasQn8O3yF35STfZ?=
 =?us-ascii?Q?DO0eGnKVx4/eKv1XnK7MnoPI9FsLzBe6SemR6+xau7oC7yVXi2F5qRrnrxsA?=
 =?us-ascii?Q?RGxeaE+yXK0d6mpk6ST2gGXNdxXKJBK0LM2j84QvrRknby1lgwModdX8z5Wp?=
 =?us-ascii?Q?srcwAWEGLri5YtfkB77EUSciVnOlWuwhEvMgRqIuTyBR8LGbNKsa/DS79jw8?=
 =?us-ascii?Q?+6+B1NbZ3il2w3Frog1yadwYFF2JAnac?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H5v5kH9fFRVUiFvUjeY0bHhJQ7xZrPefJRQf1dDeEP6/UKXWyFlQbeh5Q0+k?=
 =?us-ascii?Q?qIOv4wsO8gNz+a+D8Ck0fX8mPBc9dBRNn0iO9WqVmxF7hNWd1NFShJ2o14B8?=
 =?us-ascii?Q?WJB2zX6VjdFY8Gt3kY5qX7NmR3RdL4HLuw8NWotoLTxK26rF2AIDD88amv0Y?=
 =?us-ascii?Q?YJt9yjsQ2EkKpZnNmLGm+VbkLblPhbg/vEYfg4a2aDCJxwdKtcbdQEqoWyIs?=
 =?us-ascii?Q?U4NkhfI8Euu3w1w2//KJX5dChtKtRu2U5G0DTjhdugGputVldMyhvGdYIOBu?=
 =?us-ascii?Q?fyKd/jZAvWHJt8g7ir8Is4SGtGWpfxr7uk+h7oahRXzMKYG7Uf/cAeXgbm+p?=
 =?us-ascii?Q?jt/qHZOpKdIlZdWYFMgC5fHGpzeZTUVb/yojbjM7EkaftoBpHblZ5q5MtQuQ?=
 =?us-ascii?Q?zV0MiGTfP7SqBqHPu8vi0DrN9s7a6MQxQhmYWU/ATGuMaLk3fHVVnEPfUKb8?=
 =?us-ascii?Q?fTWegJ8oOhApY3ZUFSbyUfXKM/9EjDXLAuXd8e8aEGdtVEoJ1hmmwXUyGmie?=
 =?us-ascii?Q?6OBhEFAG/4WIsjhzM2HVXiBF7MwLDPRheRt2ZJMPEVCLRS0e9CvtfZTyZUS+?=
 =?us-ascii?Q?/elTgba3/4CgHJ8WmzbQvED+IQGYetJ2EZWS9JmxEvkx484KEe2XMR2zIUuX?=
 =?us-ascii?Q?aPddOTiT1PEvxJq50A6MwXSmhKh0rO4AnY9hIqp6FAKdp2nY8mrSjOnHDHyT?=
 =?us-ascii?Q?lBnOeknU0kVp/xYpqdFtlpnGJtUV1h+oCeIaKeeZalIcRyGAGy6pdf/B5ON8?=
 =?us-ascii?Q?8JSId+WeirT5zc4yVwTpQ32RJfVKE3rVP9EASEQesrGoWBGi9QTlEK844nHJ?=
 =?us-ascii?Q?tYXyclVpxM+oVYDjFyY5HMGUiTqFFm2Lo9W8g0Cv12DHmLe/Gu+fLaWAcrtb?=
 =?us-ascii?Q?ZirGtmCbV8PWmiW5j5Q6aIdr9bo5QbFCBLk+ql5seoFIIYVcXUu6F20LiMxt?=
 =?us-ascii?Q?3aLcS7yoeBNqA+WLLiPyTJlclhvq4b3jOiYO3fATwqvprlEJzQO/sk+nhiVz?=
 =?us-ascii?Q?vTahBEQsbqlmCPf5xebYrzDtkwWB84ZaoJXvAZGrIivALNJclJAPwRHv6Aol?=
 =?us-ascii?Q?NDjXtfFpZ4nKdiXbUK576nzX3cV6QyJtgRA+bfdV4t0TCskq1yKQ81kUCBkd?=
 =?us-ascii?Q?YwCU72RAfZIDMaD+bZRcqxEvKeBLSQosuZvVpq36+OMCQJr50/XZ6BK8fYRI?=
 =?us-ascii?Q?+SxAIGhV4PdER/etJk0HUySWNpckE5IY8oq62GBwXFhG2LdF/JM/13oGevVV?=
 =?us-ascii?Q?TB0lXIm++xskRtdZ+R3Z8507OlK/cJzoMBRmsNr3/y2xc7CzqPads4eDi7JS?=
 =?us-ascii?Q?qq8+c9PBpHpaEUP+FC7ggHm/3CvA0pB16QGNs0UhiMld6/kDNs5av57NSDCY?=
 =?us-ascii?Q?OdAesOoTrAZ/LMI9ti1F38Lu5/o1X4v9Pv9IB1u1omBhGr66WtJIsprNjvca?=
 =?us-ascii?Q?4KL4Ecq9bl/Y3Nk1wIAAxcdVpQarvoH1Jt+zga2XF5JUI5OzIaCFP/uLLLQn?=
 =?us-ascii?Q?bCrLDv99UkxRshBBSs/hdg/sF3nbLvB+hZN7KHE95DxV8/HeLJRAzgyQr+jN?=
 =?us-ascii?Q?Q2rQgJEg+yK+LonFr5U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c226a1-ac4d-4128-898d-08dd65db788b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 05:12:25.0584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJXXbdCBkudWfyyS2CTWiDvUbLGj9sBI2oln0Vnibbg1rsdUcpVqXjHHioEjSkrpH1kaX1jWIAryAgs1s6MnNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10536

> On Tue, Mar 11, 2025 at 01:38:26PM +0800, Wei Fang wrote:
> > For ENETC, each SI has a corresponding VLAN hash table. That is to say,
> > both PF and VFs can support VLAN filter. However, currently only ENETC =
v1
> > PF driver supports VLAN filter. In order to make i.MX95 ENETC (v4) PF a=
nd
> > VF drivers also support VLAN filter, some related macros are moved from
> > enetc_pf.h to enetc.h, and the related structure variables are moved fr=
om
> > enetc_pf to enetc_si.
> >
> > Besides, enetc_vid_hash_idx() as a generic function is moved to enetc.c=
.
> > Extract enetc_refresh_vlan_ht_filter() from enetc_sync_vlan_ht_filter()
> > so that it can be shared by PF and VF drivers. This will make it easier
> > to add VLAN filter support for i.MX95 ENETC later.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
>=20
> In this and the next patch, can you please separate the code movement
> from the logical changes? It makes review much more difficult. With the
> similar observation that, as in the case of MAC filtering, VSIs don't
> yet support VLAN filtering, so the movement of the hash table structures
> from per-PF to per-SI is currently premature. So I expect to see that
> part removed from the next revision.

Okay, I will keep vlan_ht_filter in struct enetc_pf, and move common
interfaces to enetc_pf_common.c.


