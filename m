Return-Path: <netdev+bounces-195015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD77ACD7A4
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 08:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BA33A758C
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 06:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C923817A;
	Wed,  4 Jun 2025 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gA9/m+Mn"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE9230BF6;
	Wed,  4 Jun 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016860; cv=fail; b=qwFVqmCtZwaUPW1vnh0/4k1SGMSlR+3xTQPh7Vcx7JX3XgtoTOnSZOTEgDuDF2DvFTmJ/lxMJmHjsFQtdRFUEpI9ILqg5+3Gzn/zYxGzPo8Ger8xLlG6bwRXUVv1NeYOYAQZtLCUvnJaPyPFAusK9z7PyibVgGKJo//x6JrdWQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016860; c=relaxed/simple;
	bh=HdoT8Mor4jdRXg+BlFnVB69NK0YCwsVAvEOfrm5UfKo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8nzUdUwxLYa6W8yvv88uHjCxG4EAWbi7r/Rafr8Qi5j+bZ+ky6Lvqh+Y6SPvN1PW4tHURtmsobnt0HZoT6p51P5BP/reM2bGROcuPoVv0cN5OR3JJVMSyODBJiZjqdjfdSDl5YZdjVihtNx0VruSmZCkyTJJMsvrw/fC3h9nXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gA9/m+Mn; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/IqfM3UxLkTm8l92JpHHaM9TjlMXr0tXOJ8jTH8hcQXNW3mausm1Lr/0Ztn92PnQG1jdAr7f06qdcyqrt3hpku9nKzwvZMxEdFO7nBDcWI216p0/gHM+K+AhnNJ7i6DTJtX0XTQ7SuqkAa0GeLIV8I22gPfxUSdSNPWifkRV8ML/cQ2+wJhXIV7aLKdLK83QebGhWjettfAOr56NwN/CUuX/oV6iNHUD8xMJSmv1UzHsfKZs4mtreCvuP3TnOKTrvR5Lwts2jmFe3+dHt2bmN+Bbs2t2J+a81JdOvAbeZe0D0pRjpsU7ZZv9Bf2stBsm1+5HzFTZS3itBwHGh17DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Ht6ycpMeoS0UiRRiIeJERrfTZFsoGLUnPFGHXJ+Fw=;
 b=m719yGEbXhusI0tQ0TthZ0whoIJb87gtgdRM23RGcTrqNGLPDX/cPtB49vgUhGj3pyfrZBieqcZA+NIawC19rwfFN6YQrVYKgwl7AbBgztmBQfg+wnnDnLB/cSS9xj/h9kjROG5ppG2SM/LImVytIx1phz2o1TGiRO1ghB8xtAZ/MNULGRH7p5uRcmtxfVYbWgzi5+Prh2qZ5LmuefvFzdDSCt3Mo0CC6VWLcUHqScHTlrK0T2pTt9JNIR6fwnivAGPB3kwlu3YKZWF7yjcpfZxlJVcYVYuZk+Pa5LRmmoUK5k0Fk9V0ZNaxKREsBjZ/O5XhOBDY+llON88sx4kqXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5Ht6ycpMeoS0UiRRiIeJERrfTZFsoGLUnPFGHXJ+Fw=;
 b=gA9/m+MngcLbKMJkf6rT1vM7ZYrhJuLaysT2aEXY1Mn36d2iaxTpWLG/uw87bDzRZE+gJ5uMG4icxv0gIPRRaKZjJXgvXmg/Dx56BurakYalYgkUaC3DNcdYy0Ca5Qsx4Jil4d00nKgvipAmZZPJPiGR7LWRplchv1Z+pzE6A5qQiPeT92ykArgVRVl4mkqjuQO6JD21sHcX37cqLMDO8p9Mr8Jjgan2sGcJ7CcJFhpQ+BmiJ2fh4xamyma2cGrZy04RR8gvwQuKHvZSvlJmsYm6g4lrJiz3uO1WAvtSrgefs+NKS+S2/TGyGNaj+1VGKmC5U933aEcZX5KM6LXpMg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9808.eurprd04.prod.outlook.com (2603:10a6:102:383::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Wed, 4 Jun
 2025 06:00:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 06:00:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
CC: Florian Fainelli <f.fainelli@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"xiaolei.wang@windriver.com" <xiaolei.wang@windriver.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Topic: [PATCH v2 net] net: phy: clear phydev->devlink when the link is
 deleted
Thread-Index: AQHby8C/1AHS0HJUFE6a7bJae4mQobPgVKIAgBGjJoCAAG4doA==
Date: Wed, 4 Jun 2025 06:00:54 +0000
Message-ID:
 <PAXPR04MB85107D8AB628CC9814C9B230886CA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250523083759.3741168-1-wei.fang@nxp.com>
 <8b947cec-f559-40b4-a0e0-7a506fd89341@gmail.com>
 <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
In-Reply-To: <d696a426-40bb-4c1a-b42d-990fb690de5e@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAWPR04MB9808:EE_
x-ms-office365-filtering-correlation-id: daa206f4-427d-497e-b182-08dda32d2ad7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?sQDlaEMN1fGO1nqqpgpYP0E/XK8PZBdZ63Dn3ZYiClhbJpo8GtaNKh8MSK?=
 =?iso-8859-1?Q?ORUQ/7gYX+pcqaS76JwTcmQAyZjuF4+EwuArU3+F5SYAIDIA2XeVg3SpUk?=
 =?iso-8859-1?Q?2bZs1y7axXsQIvNHsaN08fZd1Y7kZqlfyHon1fBTb9vc/vduzs3d9iu9Fx?=
 =?iso-8859-1?Q?6K+Am6N7WaNVB94B8QHJ6SOm4jbQD6F0i3JnjM1bVVoAVcxDzpIfbKhXCZ?=
 =?iso-8859-1?Q?BXN+mNQtx2NGW4d1sFDWHXYLfg57FRKmsPzoemuzIrA7wshuHgfh8Ivdq2?=
 =?iso-8859-1?Q?i3D482XtuvdQb9sE3bDrAlurzIS2bW8ku+ZD+01kD6E7a/8QsiIc/fIA6p?=
 =?iso-8859-1?Q?l04aQAD9GeXOHM3gke2fR1y071a0nVdETzxO0JPfTUooEustXlNLEDdFwy?=
 =?iso-8859-1?Q?SzNaHPn8uXYVbJES9+HDXwEDQduu7Rty23UUuJE2omMiRVR6Apv6Cru5hE?=
 =?iso-8859-1?Q?rHajRT0to4huVaZ9+J5KbR2KLwnIkaaVCkkiSM9clZc0cXHeX5v3Z+fjHd?=
 =?iso-8859-1?Q?tih1s1tgyh/IG+jR5QXJupaFlkjSjIJVMsoWPKBqJbG6VdPwZh8rTpHQ2R?=
 =?iso-8859-1?Q?L3DLLmLyEQZjJZ0I6aFweGJ4xdO8qzB5uAoZeD8qpTqHFbvLUBXqhuGUkU?=
 =?iso-8859-1?Q?DMq/zavBo7xqo8/zccM1TtEpyLjpxLN6KFch24RkJR0SgyEgJgOLZfzExz?=
 =?iso-8859-1?Q?m66Hjtk2q80+D1IFED4tAlRC0tHmCjZAkqpFDxVa4ZJNopmb3ZjZA7IOlL?=
 =?iso-8859-1?Q?U1T7WH3CgXaHgaA8Ud/IAQfeItfjeCrZO5a+lqZsuNEEBzorbN1f1ZyU3T?=
 =?iso-8859-1?Q?y0HYt6li/TBa1zXIOgSOPfB0B+DG7RfnAUqE/HyxR+444chO+P3tqX2n3E?=
 =?iso-8859-1?Q?Y35zza9wPPYWsXzMuDy8A2s80wJRpLQQtWMPRoW4GlsVbMRI7JHAIMN0T3?=
 =?iso-8859-1?Q?pZZgZUEVFgp5MbiGK1a2KsFNNxf3/h0d3WWruQpOR9FwcLuEz4nQCWhZ4h?=
 =?iso-8859-1?Q?7HM+rHurCO1dj8jiS6aeaSlkiG0XaMVGp9HWJnDPU+tBF6JK/USlFqX+5r?=
 =?iso-8859-1?Q?GphQ+qgztRiZvb19nt9haadsHJxdbxpIYujH3yonmzXEiwgjn/lWGmVflQ?=
 =?iso-8859-1?Q?Uucg1DzpUovuiETRsSQGaxD5aGP2PBatjApenM/Q9Rsm8MIXRXIyEatXhI?=
 =?iso-8859-1?Q?iAh0EZF0J384CL3xegSi092aiKSrnNMkBkhs3ph2GEiaGgf/ZZSvaAAKAq?=
 =?iso-8859-1?Q?NKLaHk4Gw1+ci+K4uC3UHhzdqxUJ3Km7PPU8fVj+9bgMj5FNWLontAu2z/?=
 =?iso-8859-1?Q?PMDvgnDHen6BF19VYYuMg6qb8oeb4FwZaN2W6IEb1+Ct0xaRyLOqRVZrlT?=
 =?iso-8859-1?Q?JmrbCcRI1q23dtLMCrcNsxkwd5UFo6zkP4X3RbinDPpBOd4Qsnh1RweHuI?=
 =?iso-8859-1?Q?8CddDmWrnzNm4Oe12oUPXWtGRKi6nX3ZLQyQRT9KNtyuxk9Jh7+nvLikke?=
 =?iso-8859-1?Q?8YKLuDCMzxFu/ddEEaOUCy5/CY7MXAm3KzVBgHHEryoreFwaxvA4XkNGYE?=
 =?iso-8859-1?Q?eCLQHv4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?v1ugMQqDc5WnQK8CD0j7cGlxyfTXGPy97efZsvaroJ0O6X8Yi3PXrDCMya?=
 =?iso-8859-1?Q?iSShNzLSp3dW989hZe8dNR7duRO+uEcy2EWTMzmVDePG7jgEodmiJtRclr?=
 =?iso-8859-1?Q?RNAIoc5zXgNhz5fSyYn9VEzmVkgaiiIFGQZJ4fpKUMEBVJGCeHnOq95PrV?=
 =?iso-8859-1?Q?choSjlAXaI6Zu7ztd0vlY3rz6YllhSXaUaxz/py3cjZvrIa1/bFuLtcwys?=
 =?iso-8859-1?Q?ttUMaUkPsJMBRViJaN+ETnJ51w5rHWUKEDGV73yr6hDi4PCGrj+saLUkCI?=
 =?iso-8859-1?Q?XIHquSAc3tDKgYlSstsjjxSk5s2mUyqB7fz0TAR26hd0i8FZ/E4Ij6i391?=
 =?iso-8859-1?Q?ykEAyd2BzPvbSDmmJSep7bpGc+E43RiUF4sByQbPvlCluTRtvDqoMnIJJ2?=
 =?iso-8859-1?Q?B5R45/ID4CC/crwtQGBUj0a4ObOz5902UFeLMGr1JA7kDMAYMfG3IJPZFt?=
 =?iso-8859-1?Q?8hM+FU5cgTr9FwsrSAbpRJC/GlbFU10W8KF18ED39Z4Z4o+jswGG+tyS73?=
 =?iso-8859-1?Q?HP86MZDRNll2T81hWL6wTMMc3gsoUs2ElsFJyVmuqMhO+zAV5zpnuexbVm?=
 =?iso-8859-1?Q?n3HYEbqXTrgjttZSq7lOnhMcQFhHz6RsfPAd6mC892kbrnkOvOCTncMWkS?=
 =?iso-8859-1?Q?0YeV1tmXvRoMS6qGUsgwAS0kO+dDujmxpqaXLoFhPXLLdKzNMFERhibG/o?=
 =?iso-8859-1?Q?t+vcnO6lD+g4PNjJMpYC0UIYCqEHLyD3V9ypuxvl9/1pdZg755k6ikyECi?=
 =?iso-8859-1?Q?z9EsjCEUipYvx1a4skF0FK3mbvYFTe90M6WKUASrQqHFHhIraAThUXqF/A?=
 =?iso-8859-1?Q?liiwCYIzWkW7GmflP8v97QHhvHSBEGP6zVZ+VNc0P3CqKE0MDsGj7Bz/ne?=
 =?iso-8859-1?Q?QPGzOdaCqqc2uYhqAY1vl20OKd0AqmSp2ujOlg/OHwi6RvT48W+ze3LJEP?=
 =?iso-8859-1?Q?NpRr61Tf/wY3iRhiYEMUn80gP2cUvuPewZYmtzdz0LgbepW9y1tphRx2e5?=
 =?iso-8859-1?Q?mVILrm5Qp4GC4+IhYfnCbs76Tqpop5iDYyXSSFgsuI6sYvPzMV2Locw26A?=
 =?iso-8859-1?Q?f4FFpQwj3V4qjTMFBSR5cupr5eWdNhh4O4sHtf3ovOc4zEJtG7p4h9oeTC?=
 =?iso-8859-1?Q?dulqMabJub7i0SidBwW5P+8DaowNZszDcearynXldsplhMjL2nUl/76rrZ?=
 =?iso-8859-1?Q?GLrYD0A/z8Xw3MjgTwcEkZ5wp2df/eRAN/5NQnTdN5H7x7tiYXQqRVW3iD?=
 =?iso-8859-1?Q?PbBNU4Wti5PXxFd7/kXZlJBP0aAdsGHmix6hjtAnw7jCKC7WuYql3pLMzs?=
 =?iso-8859-1?Q?XxC90GW2HEmnH7RD/q2MErWaKW+0pJbjcULnYaTVc+u3ZDyhNDPR4X/NsU?=
 =?iso-8859-1?Q?KFpzj0z32fXS4jKgNoV+DRRIGqh2R2pj9CXSyF+MQjW5JTb3ijsE7Ygw1b?=
 =?iso-8859-1?Q?AtvPhIcxZUZhXsmqapuIq2qoA4BE5UYsZLSe2M5YKo1j1U7cHAsGyFvRsp?=
 =?iso-8859-1?Q?4eVnYm83QVJslyX6gsRr6MZlFNPPkPJ4Mx1jkefSIFX6s2oMeE2OM7HiTg?=
 =?iso-8859-1?Q?VxKcgt7ceUgW9Fc3zQiz5e425tyFMMj1I5w4z46/sUplepHJAxrQKEiZ5A?=
 =?iso-8859-1?Q?o5itkY8qlWKE8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daa206f4-427d-497e-b182-08dda32d2ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 06:00:54.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pLjZEJI0/q0B8OJFGHEyP1PTM4HN7iRJGVkaFRnTQGlWBaZJ7c3qV/iOrIXewDiPcSD/XD4bT2vAWC/JkOnRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9808

> > On 5/23/2025 1:37 AM, Wei Fang wrote:
> >> There is a potential crash issue when disabling and re-enabling the
> >> network port. When disabling the network port, phy_detach() calls
> >> device_link_del() to remove the device link, but it does not clear
> >> phydev->devlink, so phydev->devlink is not a NULL pointer. Then the
> >> network port is re-enabled, but if phy_attach_direct() fails before
> >> calling device_link_add(), the code jumps to the "error" label and
> >> calls phy_detach(). Since phydev->devlink retains the old value from
> >> the previous attach/detach cycle, device_link_del() uses the old value=
,
> >> which accesses a NULL pointer and causes a crash. The simplified crash
> >> log is as follows.
> >>
> >> [=A0=A0 24.702421] Call trace:
> >> [=A0=A0 24.704856]=A0 device_link_put_kref+0x20/0x120
> >> [=A0=A0 24.709124]=A0 device_link_del+0x30/0x48
> >> [=A0=A0 24.712864]=A0 phy_detach+0x24/0x168
> >> [=A0=A0 24.716261]=A0 phy_attach_direct+0x168/0x3a4
> >> [=A0=A0 24.720352]=A0 phylink_fwnode_phy_connect+0xc8/0x14c
> >> [=A0=A0 24.725140]=A0 phylink_of_phy_connect+0x1c/0x34
> >>
> >> Therefore, phydev->devlink needs to be cleared when the device link is
> >> deleted.
> >>
> >> Fixes: bc66fa87d4fd ("net: phy: Add link between phy dev and mac dev")
> >> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> >
> @Wei
> What happens in case of shared mdio ?
>=20
> 1. Device 23040000 has the mdio node of both the ethernet phy and device
> 23000000 references the phy-handle present in the Device 23040000
> 2. When rmmod of the driver happens
> 3. the parent devlink is already deleted.
> 4. This cause the child mdio to access an entry causing a corruption.
> 5. Thought this fix would help but i see that its not helping the case.
>=20

My patch is only to fix the potential crash issue when re-enabling
the network interface. phy_detach() is not called when the MDIO
controller driver is removed. So phydev->devlink is not cleared, but
actually the device link has been removed by phy_device_remove()
--> device_del(). Therefore, it will cause the crash when the MAC
controller driver is removed.

> Wondering if this is a legacy issue with shared mdio framework.
>=20

I think this issue is also introduced by the commit bc66fa87d4fd
("net: phy: Add link between phy dev and mac dev"). I suggested
to change the DL_FLAG_STATELESS flag to
DL_FLAG_AUTOREMOVE_SUPPLIER to solve this issue, so that
the consumer (MAC controller) driver will be automatically removed
when the link is removed. The changes are as follows.

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..a6d7acd73391 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1515,6 +1515,7 @@ int phy_attach_direct(struct net_device *dev, struct =
phy_device *phydev,
        struct mii_bus *bus =3D phydev->mdio.bus;
        struct device *d =3D &phydev->mdio.dev;
        struct module *ndev_owner =3D NULL;
+       struct device_link *devlink;
        bool using_genphy =3D false;
        int err;

@@ -1646,9 +1647,16 @@ int phy_attach_direct(struct net_device *dev, struct=
 phy_device *phydev,
         * another mac interface, so we should create a device link between
         * phy dev and mac dev.
         */
-       if (dev && phydev->mdio.bus->parent && dev->dev.parent !=3D phydev-=
>mdio.bus->parent)
-               phydev->devlink =3D device_link_add(dev->dev.parent, &phyde=
v->mdio.dev,
-                                                 DL_FLAG_PM_RUNTIME | DL_F=
LAG_STATELESS);
+       if (dev && phydev->mdio.bus->parent &&
+           dev->dev.parent !=3D phydev->mdio.bus->parent) {
+               devlink =3D device_link_add(dev->dev.parent, &phydev->mdio.=
dev,
+                                         DL_FLAG_PM_RUNTIME |
+                                         DL_FLAG_AUTOREMOVE_SUPPLIER);
+               if (!devlink) {
+                       err =3D -ENOMEM;
+                       goto error;
+               }
+       }

        return err;

@@ -1749,11 +1757,6 @@ void phy_detach(struct phy_device *phydev)
        struct module *ndev_owner =3D NULL;
        struct mii_bus *bus;

-       if (phydev->devlink) {
-               device_link_del(phydev->devlink);
-               phydev->devlink =3D NULL;
-       }
-
        if (phydev->sysfs_links) {
                if (dev)
                        sysfs_remove_link(&dev->dev.kobj, "phydev");
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..cc1f45c3ff21 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -505,8 +505,6 @@ struct macsec_ops;
  *
  * @mdio: MDIO bus this PHY is on
  * @drv: Pointer to the driver for this PHY instance
- * @devlink: Create a link between phy dev and mac dev, if the external ph=
y
- *           used by current mac interface is managed by another mac inter=
face.
  * @phyindex: Unique id across the phy's parent tree of phys to address th=
e PHY
  *           from userspace, similar to ifindex. A zero index means the PH=
Y
  *           wasn't assigned an id yet.
@@ -610,8 +608,6 @@ struct phy_device {
        /* And management functions */
        const struct phy_driver *drv;

-       struct device_link *devlink;
-
        u32 phyindex;
        u32 phy_id;


