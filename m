Return-Path: <netdev+bounces-290087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPj5IKMSDmoW6AUAu9opvQ
	(envelope-from <netdev+bounces-290087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:59:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02972598F9A
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 21:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 13F4830620C9
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 19:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D663624AE;
	Wed, 20 May 2026 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ebk/xiDq"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004C3612F3;
	Wed, 20 May 2026 19:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307152; cv=fail; b=BYO1EkYaf2oaYfcwwNboII1DH1ddiM6ySWwdnnNh7m0tVdnNhwqmY4D2ZlxlX3Oaxw9cgAQ+SORxohKHHb6M1KNju+tOv7+6FlbwZToyZ9mWyb3CIWwYTwA3s3MwBQlnikJeFSaxpf+nZUxpws3Y+FGHGpK4QNskvcR1VFz1aro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307152; c=relaxed/simple;
	bh=rBYRTnrUhwuOiNip8C1mcntYeRKaeYBnrQeV0kfXxy4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EiDggc0sqhB+7sZpgxUn9u6DMMtrOqcKObYE2kDdTjQNwNNTA9hv8j/NJ7KzT1G6jeq5o2bOjeQve32LsVJeLugKhxUAL20xan4sZACK6k4k4GDutTujpDgw/T+QYY71POLuCcuBmk+2PpzoHMbFj531RtUNJ5EpFkHrxE3myuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ebk/xiDq; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9PvWaNMsSMw1hRsYqNRoypI3EeEUpto+sJIsEDBWmtIyh/u9RFvqT1se2OxMt53NRVJ6+rvkBzYkUX4soj+xuQEtOex4g8wdNBFYudAWL+SihrWIaq76LQEFNWcF2Ec3+vB+/lFjR+BTVnWpswzOho7/aBfOwUkI1cZdxU7FUYjSZHtHl0rcnXsjVYkEOqqPYeKdUjCrAUtx9znLmbCxRZgev2pfpW5T3Jv/u8xw2QlA+96lXv8iREJVMKT3p/0gyvX7axds6FxtbirdjIQizywah3to39a2LCnb9XK+5S0rPmkLSO9E84QDzQw9t28XtdjudfMWNCDU7cPiJMaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bSM5OqYeBIDWA1Gm7TFUsPs68/QGwU0R1k+PqTPyvM=;
 b=VN/0fdWgmeJeOINynwfUq6B6FoNjVKpfp6uchu6H+boUT0RTkhy2puQazAkEofoqLAotpFU6d95xGwh2Db8JAXhapEyL3NW74h/HJX4GxHoV71tY8/fQHR+sfQL4SQEKC40AL7XJL252U6znx0Rz0PIq6ICVRvo3rI/Z1kylsUHDLoAcaAyOSJq1lzyFYZp7oeuTnbT+H/WPlNXw+N181PdEqNQEM06D160T3m5w0wYO2oV7zGCgY8hEs8lDPDo4WNZ5T8v7zQoROR2HdNRfWuJ28amRELg3UTr2xIH08O2m1WgwKOSgwVDdz63Bi9QLvmRDaSsJwxVnp414YIcP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bSM5OqYeBIDWA1Gm7TFUsPs68/QGwU0R1k+PqTPyvM=;
 b=Ebk/xiDqr63w9U7hrJeMLzv9i5HX6sWEm1/usQcwM/8ukUCqXi80khpbo5vaM8C7gjqRO/Hna7TFNpsnkOxMKl5PHpUdypEdhr06loytTgVFEssts4MLS97oGNHnjui6GF/7+k8mfw06ooipuIgkHuOmM+Ms4vm888SUDUhjTCaMQN97xgYIfRra/dFYypFGX2OYLoh6/962woE5zrXvMh4milQoGoBBllkU+iwZ4KaiTT4G17v5O/uCkSm6u22LS7VGrAXkzoi+dMbuET2ITDDipRl+zNXBa/Qk1wXzjgQxyjAV4n5GzDVKn61KF27FoUKAUNewEYcTQnKS2V8C/g==
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com (2603:10b6:a03:4e0::20)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Wed, 20 May
 2026 19:59:04 +0000
Received: from SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb]) by SJ0PR12MB8113.namprd12.prod.outlook.com
 ([fe80::fe5b:a71d:fca1:fadb%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 19:59:03 +0000
From: David Thompson <davthompson@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "bryan.whitehead@microchip.com" <bryan.whitehead@microchip.com>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Topic: [PATCH net] net: lan743x: avoid netdev-based logging before
 netdev registration
Thread-Index: AQHc5LUscPiHBMwY0kOblphmtVQSXLYWKhOAgAEuk7A=
Date: Wed, 20 May 2026 19:59:03 +0000
Message-ID:
 <SJ0PR12MB8113A2493154C98E13D246F8C7012@SJ0PR12MB8113.namprd12.prod.outlook.com>
References: <20260515215229.3881949-1-davthompson@nvidia.com>
 <20260519184115.3c70f2ac@kernel.org>
In-Reply-To: <20260519184115.3c70f2ac@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8113:EE_|MN6PR12MB8591:EE_
x-ms-office365-filtering-correlation-id: 61e68b8b-61b3-4014-0fc6-08deb6aa3e25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021|11063799006|4143699003|6133799003;
x-microsoft-antispam-message-info:
 DHs6YkOnn2H0MG+higDv0//8Pgyi7xWN51PJG7FR7gtyby/rHhGEpWMruYzgg5dkzjeBdHXyTglqpZIQ+OrCHigqugTZDN1DF5c6QeSkTImegDp74iW4ntJ8t2w7WkDI+6IJqyisswkwHgthzpo/DKY7ndXzDzOB1j0/jQr/plaTM7jc+ooTrvkFmUXM+UaYapv2tcAK0gor24OP3YY1tK/8StAByvbkuyML9qOdrRQy1zaIjaleV0ndWYJtiBPwD8wXVd/bkC0Xb9z9pgkZR9zwD+Y1A7Py+B6oWxFYYVUAtveCeHiQz9ubqC5DSXpy3iJbqWOnerBU2BeEduRHFD4Rp2aJD0DSU3QWtaWbQMX5h7gUDfR6WfIg/b0CSWwh2Om4COb1MbzSXk+4oUfcgSQP0UJA/tbeeSKlGdvAFaXXeLlwR1RfK8MIBLnXMHOzOI7q1pKeUnmUAwF74S0VvJM3q2+sPJOnQ/LqWktfNYbVqaBQE1G7IZjPAPfwtK4obn6c/dgK0zNeJfESA6nQO4OuchBR8xhjVRFSGx46xZ3wXtEQnKh2PP8fn+yAo12eB7718GKud6tioPEc3XILfqdfLkmHdMXZFBjAuGNB7G6Q1a6lpI/bwOyLHrjaHA/0IF/5MbFjVOaW+37eok5B5kiVkGWqt/2yTRp2S19gjBM9t4hhj9MA63y54d/rRAd/tPAdd+ow9CZw1g8MYfQK0BfRvxUqh9Ky3ZgI7O5WObTkWJ925VDUvJjMrM8ROmRv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8113.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(11063799006)(4143699003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?433PgRFijzlzx36y/pFmbM8QQQmGiXtfi/BN33ucL58femVqWN5HoF6Xlub3?=
 =?us-ascii?Q?kf1YkpYsJzochnV4X6RaSSiwN76KXxqcq3CrHBRVyOlmVCQZfjV3MiitmZob?=
 =?us-ascii?Q?wusPCsA0wcM0vdmuTRrOIciYuP41SPZyVp2RBvqC3qNSYyr+W1ccTksaK1SK?=
 =?us-ascii?Q?TgYSDGv5e/4tlzjDtnuQb11WmOWbU9OrgdtPAfquNc9K6R+2mZrXLJmuYoMY?=
 =?us-ascii?Q?Sj667R815jhAZck/y8MXw+u/dhiiJ/6Dn6lEVCXDle0nkSQc1k4wY4bT8a/n?=
 =?us-ascii?Q?L1M1YyAdtcsupjWlAaKgL/hz0bJLUgMDD8jPjFNyIEGs38EhvJJWHGle1sNK?=
 =?us-ascii?Q?xG4GX/pLN49LcFafu4uWN333bXA0S+XUNeaw5U+e+kAgJFUgdF2gIQuhKs5S?=
 =?us-ascii?Q?TbmMxgH+bIzPh5oH9y8gX4vGVKcm+bie6xhIlRMlGXBBHsQ7h6Afaca9THjw?=
 =?us-ascii?Q?Egox8c8v/K4CZ3Bd++6gfsKxGJ29Kdyco91q1ISi1AgDVppqxzJd9yxEkrp5?=
 =?us-ascii?Q?WkakJ7uGQjIoJpR8Y6r1FIL+QwsyMQrVjrNodBNfFXJWUV4fv/w8NsQgmQhV?=
 =?us-ascii?Q?djdcTs0Q/oQtaWQ2zScA48BcAkbRNm9nGSgi4nj+9RS3lafbjUcrGs3W1Zxe?=
 =?us-ascii?Q?FeM7QcCvc14kZkQeL9twBY9VaqL+orKpk81KM0x4xsF+1kAF2tioc7sypx/y?=
 =?us-ascii?Q?i9ZCEEJa5gbdZPfjsmtKKQtfCNIFMvABaPdKqnfJCdeyY075BoqtYSnJiiJm?=
 =?us-ascii?Q?XB0N/M+oDgzOzVz+5GA4cSCfGxsOgC+ezbj5zcWKIE3rexm3xqdfgqrkBTgT?=
 =?us-ascii?Q?CabgSovRdDEyFta5Z9hWRvVEQoDRD2gfu7DauSiJEsVhBdWG0JZrj6W0Ebnv?=
 =?us-ascii?Q?oG7XuZTmQicltPY+ZAl4xntvRZHwz+58WZCUfaMGbT5vW8+wRGoqHYK67wT9?=
 =?us-ascii?Q?jxr75H0bK4B2nyJQ8TfpJGDiDqOmCq1BtM9gF4WPR15UCsOmY9TtlF0Z/+O3?=
 =?us-ascii?Q?bUbFhCggdJW1heZ4l85xKAhXGCdR/dMCmUv9nywGc9OIFN2vX1fVN0mvYAxE?=
 =?us-ascii?Q?pg3eV08xs0r62m9qxnZ12GoP01EKdLD/vDItmwWf+fM/Id9YtWnlTe69MJIU?=
 =?us-ascii?Q?AvNR1AtHnNVxlYU5O7u1SFc7y6JgOGPTv3jVTgISk3limoKW8DzN7ns8FUPt?=
 =?us-ascii?Q?xm+ub99FJEaHQMyDMRV6IpokfONbXy9zj8Jy8aYf3fypn1LOY9BxG2TM7I1k?=
 =?us-ascii?Q?PUETboMfxfxw+BTmgOO7HcWlEwNdUWl0W9/GfzgwJ/pFbDpWuIuHlDZWE7s4?=
 =?us-ascii?Q?EZLEQC4M8v7D+Z9jh72lVsh66HOX8KnIxk01zP/zuKtD3NMw67bRrayLe4bW?=
 =?us-ascii?Q?r7jeygmNeWu0OcmV+n8VZJw1nfYSpEWvUPC9hJYZs+n9RY0sPj7ugNz/avQC?=
 =?us-ascii?Q?FIZEC8S+t6PIJEplHXec/NaCcaP2b3P88CdZTgYk3r+obIC+NbDHTDfqLxoG?=
 =?us-ascii?Q?H6IYn5Tjxhwul9f2h02APIdPEPof+DpDUJh1zYP/m3/zOIRdTtkIQAU2V7Dk?=
 =?us-ascii?Q?NKelA8LbGrFuevHgtZFvVp7k74q4q1qcWn5uMGhWXcvEt1AuMLimx/VlFTDQ?=
 =?us-ascii?Q?T00BxOF1VWUBRhiW/L8f9DJEKwt26a+Jh0GIm/5+Iu1AGnbc/doobhGqNDQx?=
 =?us-ascii?Q?zsOYJmnxyag7Fk308KmRbjRQYNhoLNygKmaQErCHpD+6saSiS59Mzjzzk3h4?=
 =?us-ascii?Q?MRMogyMmeA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8113.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e68b8b-61b3-4014-0fc6-08deb6aa3e25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 19:59:03.6135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +dUwCgJqHLrfzjOxM4f5xdn/kqPZA/Lhcl7EHHrq5YxQm5K4E1YeeCxDzdoUKFDtPMVKhBREKKZP/7ZYmVrAAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290087-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davthompson@nvidia.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:email,lunn.ch:email,davemloft.net:email]
X-Rspamd-Queue-Id: 02972598F9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, May 19, 2026 9:41 PM
> To: David Thompson <davthompson@nvidia.com>
> Cc: bryan.whitehead@microchip.com; UNGLinuxDriver@microchip.com;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH net] net: lan743x: avoid netdev-based logging before
> netdev registration
>=20
> On Fri, 15 May 2026 21:52:29 +0000 David Thompson wrote:
> > This patch updates the lan743x driver to prevent the use of
> > netdev-based logging APIs (such as netdev_dbg) before the network
> > device has been successfully registered. Using netdev-based logging
> > prior to registration results in log messages referencing "(unnamed
> > net_device) (uninitialized)", which can be confusing and less informati=
ve.
> >
> > The driver must use netif_msg_x APIs and device-based logging (e.g.
> > dev_dbg) until netdev registration is complete. This ensures log
> > entries are associated with the correct device context and improves
> > log clarity. After registration, netdev-based logging APIs can be used =
safely.
> >
> > Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x
> > driver")
>=20
> Not a fix
>=20

Fair enough.  I'll create a v2 and post it to net-next.

> > Signed-off-by: David Thompson <davthompson@nvidia.com>
> > ---
> >  drivers/net/ethernet/microchip/lan743x_main.c | 72
> > ++++++++++++-------
> >  1 file changed, 45 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/microchip/lan743x_main.c
> > b/drivers/net/ethernet/microchip/lan743x_main.c
> > index f3332417162e..53492573f08d 100644
> > --- a/drivers/net/ethernet/microchip/lan743x_main.c
> > +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> > @@ -108,9 +108,10 @@ static int lan743x_pci_init(struct lan743x_adapter
> *adapter,
> >  	if (ret)
> >  		goto return_error;
> >
> > -	netif_info(adapter, probe, adapter->netdev,
> > -		   "PCI: Vendor ID =3D 0x%04X, Device ID =3D 0x%04X\n",
> > -		   pdev->vendor, pdev->device);
> > +	if (netif_msg_probe(adapter))
>=20
> please drop these checks. They are always true.

Good point, I will drop these checks in v2.

> And the message categorization is not encouraged.

Are you requesting that I change pci_info/dev_info portions of the patch in=
to pci_dbg/dev_dbg?

> --
> pw-bot: cr

