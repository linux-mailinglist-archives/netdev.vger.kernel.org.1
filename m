Return-Path: <netdev+bounces-266570-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG9XJDg9sWmAswIAu9opvQ
	(envelope-from <netdev+bounces-266570-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:00:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE13261975
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 429F3304592A
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD13290DE;
	Wed, 11 Mar 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MpzjpMn8"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B8309DB1;
	Wed, 11 Mar 2026 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222580; cv=fail; b=LHtaj8VeA9JxLwItpTkXDZFSxNJEXhZsKkQHiSKgQecYuv2+68UQyC+H4kxMRWFRUEiGi5B6QY+DOjB0NMXWSban7YiqKqvbUUOwg4xhlIXf3ClHb01zHt260zV43Kx/SNId2hzAlG08AFRV+R4/FD/p8BUZyq9Gg6lYENz57RE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222580; c=relaxed/simple;
	bh=WF9ocVH8WN1W02XrIWngDeJYcrWz9gfzA+YvAaz2mv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWkRjuavUjGjq1wDN574YfClzASg+yaqOfXqTCAfYUPIaMxbJC8txFM0I5waqhaoN8QybN1FKy+8mMcLAk5lsZveYje52C3NAxbEjf2Q4R+IWgnh2kAvj+yWBfRE86vibw2rY4/MgtHSSLGdelmztxz17YNYG9m1r6ANMe3FltE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MpzjpMn8; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdoF2XmImi+RHqeDBi6Gl/BFOVso+auy+B8iIy3wMVmY9DfaZmb7TDR9kQh5OvFeUc8np3NecTqkfp9ipx045/28SxgExPxxF20ZIgB/WOxwt6GsLqZq9KeYD5jbZZiXEcd9VXE9FzLtoegaW9yfSOWXNd1+IXD5fsMxkWWQTymLrNcPm8nw83NWkg5I6W3QOwkiMCBY032C924LThC+kcSW5zoYrbucVtvhCJY8VDovBytKtTH3YKJfldrea43de2K8PXyaTdBsBKIjYTp5FaW5KSExtpE2jlbtP/mSV3Z0Athx6N+9FVcbn35tP5/xlDFVcwUZ7hhK0zOCqaphRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU6AlfSu+yG06EW9HOwnlCZ6o7eUJf3IjMg41Px9nfw=;
 b=HqpzBET2N0xmAu4ms/qq7XgVUHZo/uPDA1aTDfudk+MhOXDlrB9p3nrqCJrBLAIiHSuyD+UUUcB5okW4WL0YCrVjRWhn6Wgjlz+zPHbFJ1oeFlsAtgBNm3yLI/9J+P0hPOK3KOVyyCQKlxYuIz0FcH0PWbGzFxyN/4eKV1riCcJJ42NHlzWRaeXrzho5xEpLrQ4g9yRJPS05MMP5TQ7AwsEp7wSBz1DjzDMlhpnKrADcI6oY5hrUXsq1bPhT5M7lUTw96axjHG2VmRzGBbQgPZvjZaTPrXmGBxgiIcHrcscxv83m89C6E3nehoD3vcG0l1QHmiF0srSCBCf/Yu+3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU6AlfSu+yG06EW9HOwnlCZ6o7eUJf3IjMg41Px9nfw=;
 b=MpzjpMn8/t1jOJY58DWcOu0EHkKgJbqHUSNvz1pHBXvBZ1y21ASxwogexXjlAjUBoH7prZqBExJtJ5RUzFtnpB891pYAZhomJTTZN06psi7XnlLQcS8Ceo7EzcQj0wlagja1WChnp3BTOv6PssOrXD5Evp/pjW4ffrJMzPGeT8SIhTqajU8a/kxRQWbWKHFz655pzPazjew5kl/+xVp7cda8IWZAoR8SSg3AZ/yUhPN9ziXeh7X6XlxqdddGf9fy3v2xo1OXvqp+hrIRBfiXvdvxV4HBTMuJmEZuLE4G97+ZGQ353ZXCY2zIAlmIZ97LEuZHUvuWvYcf/3jfWONGMA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8972.eurprd04.prod.outlook.com (2603:10a6:20b:40b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 09:49:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::b476:c19a:24cd:3694%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 09:49:35 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Sai Krishna Gajula <saikrishnag@marvell.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, Frank Li <frank.li@nxp.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v3 net 2/2] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Topic: [PATCH v3 net 2/2] net: enetc: add graceful stop to safely
 reinitialize the TX Ring
Thread-Index: AQHcsTKRGMsRP7DEJ06wCUQeWB3fU7WpE78AgAACAFA=
Date: Wed, 11 Mar 2026 09:49:35 +0000
Message-ID:
 <PAXPR04MB851013A94CA6816FF1B5E3368847A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20260311084105.3982037-1-wei.fang@nxp.com>
 <20260311084105.3982037-3-wei.fang@nxp.com>
 <BYAPR18MB37358BCA45E9FFB570221492A047A@BYAPR18MB3735.namprd18.prod.outlook.com>
In-Reply-To:
 <BYAPR18MB37358BCA45E9FFB570221492A047A@BYAPR18MB3735.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8972:EE_
x-ms-office365-filtering-correlation-id: 55b094a2-1b72-4a15-9b5b-08de7f5380c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|7416014|38070700021|921020|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 sQJKpLXmz0d6ZORDNtG08sZ2WQ8KuqEXYoKsRy4E4QHLNcDWvHFe/+rna2PjOfGcAqTewE+ohBp5RvSZOaoWzU2wuqpgMofrPx7uOsQm1Xh3550p4CnX/S40QEzKto5K9JmQlS1CLAzt0h7hHM7UUxteMy/bTbOIGfzz4qN00yKkSlphbhFYQMOFU49SdSTPVuW2RmIGz3GCeG3BGRun8BXbz3SWbWwE5+SMSCx6vcQZaHJBs0VL5RVUtQBo9EUNxvK394mJkwYp0PRCv03qMyfbZhtmJSsbXpcCbM70f5IjtneYdSPKG1x9iFWvzBFcUNtfPg46n1eB50wkN0+yoEC7K0lqIwi7BljjXa53K0UpKyfx477NcUuEesnv0MOz/oqlgnjVQ1foUn1tSoetJ/4zIsghKuRKcnwBea3LaOMygUFX6v1GQjJZODlW3Z8m5z3v1hL+mso7jw0VhGvdSxXQgtPPZMbXHYuHRldWgit2iTPv5YQZe8rHPAfwfyVOXyNm1w/p7qxDnJrjGtXJFydfaIiAWWuEqj/iK6YyEzF6jEG6585ygayUa972vp5yhHQe0hnOyn0J+eksBPqZctryVK4bf0UOBNN48cSWuJu5no400jFx/fW16/01cyb9TWe1PGNFzgV/1iKJhZZ6vSXE87X+3kM7ScOFIt1MTYBr9axFqhdmy2eaZ9KF1kZoPS6meZcOUHbjvOBh2Y13ug4i/6pEp3Oa4ZrQNwusfSFGJM8WGLJivNHjbV/PqGiJoIWEaG70aO+5wPcRzP8B/Yw7cAKpQJq4DJ+Oc3tgDtkudX58iB2T53yYbp8Lnlpv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W+cWYgel222CvTxCmFwAtBpgWwJH4UKFuBiQICldo12g5zOz0DdbrO3OMHoZ?=
 =?us-ascii?Q?oJlCMdxLs+eTfDU4hxjQVThTz1CDqIemwlDWcXN+SsbBXvdtbzQOOasldCVA?=
 =?us-ascii?Q?QjlhHCZuI/AJTD41mpgnjpbbLljocHTw/puRle8H9PHl+aWT9AbXrXiQbXIp?=
 =?us-ascii?Q?xCwK3ci2Mvs1LGNbZW5GPQlgMHvQ0Oq5iTqLV01DlLpB7PE8oKuowBXinx0f?=
 =?us-ascii?Q?baHiiB4jovjP57TsvqHUDIF68nW0nv6yQ+VcRR3i3e+cJ8ODdVe+TSfJEiJ4?=
 =?us-ascii?Q?WSh2ni8KKVLKuGokCOIIFleD0XA1SJ+nV7BLEOCCcBR2n4xfqeIDgnFJW8yJ?=
 =?us-ascii?Q?YxW/NI8WzM3wPnRi6qOttzhdrPm+YUsrDlMy3UjF00f2r6kZbMaQQfwiPAM0?=
 =?us-ascii?Q?m4g+1AepPzIiZWG2aYlReHZp1LcTAeTPfuGRoi5YPajY5ke9I5Lz1L3ubk/k?=
 =?us-ascii?Q?3+GbzaZhKu4KEGfWkz31YX6cQmuDTOvdVgxoJDWNLBUSlv8DGS2z1B3tUIpZ?=
 =?us-ascii?Q?F6gePK6A7vcP5v67D0T61v5d/lrkiztfSdrvfgRKyAvvbZhjAGME+cQKZC/p?=
 =?us-ascii?Q?B/Fzij3NOZdcORyUmyLov+1KPBdt04jib81tx5QhiZWncbuNZNfwoPOTEl4B?=
 =?us-ascii?Q?7MR3dE5DGTXyp+mn/3YRDo0BYL73mDV943KRv1E2FbEpSosrkT0zn1R1Za3o?=
 =?us-ascii?Q?5uifB5XrdT3z/yG9fDoJ3yhY4zFE/B5cq3KmHwi7B7RiQnwvDbm4galEVAlk?=
 =?us-ascii?Q?zJXE0OgfTTVOLEqetkep3+bzShoK8Ny6ZRWVz1qXc1zKNPY/wTdJwvlmvGOH?=
 =?us-ascii?Q?Bz9qRNU6vszZe+X2C5iAQnxIbCxyC9KjMQVIn60igHB1xs6h4Jb52q/STcTo?=
 =?us-ascii?Q?mfRndTbH5C5BnEta3E4YljRKPsCtLJ+eMlnMn7J18Y95N4qAab4ygGAO3C9z?=
 =?us-ascii?Q?hgbntplJ2sCYbv9KHHYqELbCr6EF8iE0LXHJFx70s1MQGQZf7WpxSZH5Btpn?=
 =?us-ascii?Q?RzZqgziiWsg0BqESvFxiElFgfbGe1Lkz5T89iJKmzSlEa0MFAmq+lkRPn974?=
 =?us-ascii?Q?vJquljjNDMU1ZgI5AXfFmDC2h3NiukX8ZtmrEJQ42gEMNv0EP3nFKsw/a987?=
 =?us-ascii?Q?PD49fHn5Yf0zQ9oIarRcMP2m5h8N4JcTLb1nM8h51Tor08X/sMbjJTL1BA5z?=
 =?us-ascii?Q?j1+3KkKBlRFQcgWLRMcmPBYf8ulXBpoD6sgh52SU7FnxOXqFS05gRn629EOH?=
 =?us-ascii?Q?Jky7AJyvozRQD1cGma4ZwzrDVhuca63KQKAZm63cgVkH70HPlbI9yxkqMalV?=
 =?us-ascii?Q?2LpcZwZdlJMibhcCJyGtqm2QGF34ByyXYKkwtzr1rgKH9I0IOxo/yVUaEC8x?=
 =?us-ascii?Q?kbwBunISvxPlyoNqLaZ19vllxRbnfmiLoKx01JE8KV8iKG5ahMFghdB96lYz?=
 =?us-ascii?Q?jz6gJeG2fKx9tfkgL424FaBu0qJUZ0AOGUSXbF+57T+ydLvykjP3uNmv+K3j?=
 =?us-ascii?Q?z+hgtuOjwLxcxdBKja7veGpGhTZaCnelNYV8xnxFu5dKG1zVGDXtmKGiNlwc?=
 =?us-ascii?Q?ivv9oLDXEEYNAJ8Yk30ssWkG0o2zcpqIZd+Mg34r3Z2TCfeZ2jrCcsgZx6NN?=
 =?us-ascii?Q?Ug+Jx18WBOTCrgD7aKJY7jc9h9Ebx20jIl2pe28rE/XS0jJ4O6kDu8/FXrvN?=
 =?us-ascii?Q?YXp9H0DgS8Sa37gu21kPnFzUTJ4L3e9lAq9TAaLAKdCyL/UC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 55b094a2-1b72-4a15-9b5b-08de7f5380c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 09:49:35.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X3J74ecmEpmDnlnZOn7ZFKEmXSJjuMQDAyWDDltL2nifkTKsJ7892PC+OeR7F3+hS8U1AABHAAsE973Y/w0u/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8972
X-Rspamd-Queue-Id: 3DE13261975
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266570-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

> > For ENETC v4, the PIR and CIR will be reset if they are not equal when
> > reinitializing the TX BD ring. However, resetting the PIR and CIR
> > alone is insufficient. When a link-down event occurs while the TX BD
> > ring is transmitting frames, For ENETC v4, the PIR and CIR will be
> > reset if they are not equal when reinitializing the TX BD ring.
> > However, resetting the PIR and CIR alone is insufficient. When a
> > link-down event occurs while the TX BD ring is transmitting frames,
> > subsequent reinitialization of the TX BD ring may cause it to
> > malfunction. For example, the below steps can reproduce the problem.
> >
> > 1. Unplug the cable when the TX BD ring is busy transmitting frames.
> > 2. Disable the network interface (ifconfig eth0 down).
> > 3. Re-enable the network interface (ifconfig eth0 up).
> > 4. Plug in the cable, the TX BD ring may fail to transmit packets.
> >
> > When the link-down event occurs, enetc4_pl_mac_link_down() only clears
> > PMa_COMMAND_CONFIG[TX_EN] to disable MAC transmit data path. It
> > doesn't set PORT[TXDIS] to 1 to flush the TX BD ring. Therefore,
> > reinitializing the TX BD ring at this point is unsafe. To safely
> > reinitialize the TX BD ring after a link-down event, we checked with
> > the NETC IP team, a proper Ethernet MAC graceful stop is necessary.
> > Therefore, add the Ethernet MAC graceful stop to the link-down event
> handler enetc4_pl_mac_link_down().
> >
> > Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95
> > ENETC
> > PF")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> >  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  11 ++
> > .../net/ethernet/freescale/enetc/enetc4_pf.c  | 111 +++++++++++++++---
> >  2 files changed, 108 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > index 3ed0f7a02767..1ce6551e186c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> > @@ -134,6 +134,12 @@
> >
> >  /* Port operational register */
> >  #define ENETC4_POR			0x4100
> > +#define  POR_TXDIS			BIT(0)
> > +#define  POR_RXDIS			BIT(1)
> > +
> > +/* Port status register */
> > +#define ENETC4_PSR			0x4100
> > +#define  PSR_RX_BUSY			BIT(1)
>=20
> ENETC4_POR =3D 0x4100
> ENETC4_PSR =3D 0x4100
> Minor nit, are both macros point to the same register offset?
>=20

Oh, my bad, ENETC4_PSR should be 0x4104. I will fix it and verify
the solution again. Many thanks.


