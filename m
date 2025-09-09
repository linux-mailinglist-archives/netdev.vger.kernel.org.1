Return-Path: <netdev+bounces-221055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A8B49F97
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D143A1D00
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EC42571D4;
	Tue,  9 Sep 2025 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iTvR5M1j"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E90A225D6;
	Tue,  9 Sep 2025 02:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386700; cv=fail; b=RHEKsrNRf2gPE4UcBBJJp4SzpIjxkwwHjR241m7+O+laNqScEMoH1E4bfJLAt0JazLuGuQPPj1fntCA4+P08F1Gma1aG1r5u93DDzgYPXaWLLJ1i3XTjcm8dRVSHlA3tuQYfNZHltc9tmyp6ng2ZeKyRtoP7gJ/xBWvnYpLOHGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386700; c=relaxed/simple;
	bh=hXpHGREvTHqTpPK4R0ji/FD/fwBfj1jKwYYE5+9shSA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oz0qzpsG6umfDll03P/gqPgqztKxafPLEHKwOvghLxU2ij40Wuw59dB4MQLids2oPzt581rsjbc9pxywUygXogGptCDbEBTqJrQ8fJ7l1WpNqMiLMZe+NwDhFoNHfxevNP5uGrY9o+cPl0tQE4Uuk9MHTC1VlKeug8LrIqaCRD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iTvR5M1j; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpDSCbRm+mJN6ksr0ifvZaMv72NaJuwFQs2r1YC41GOnBWBwVqvF5QByzgCMv7AXfxIizgD/LqzsRifwx5k9uWIKfzFYFVebkG6TbwKce97r/DQBZ5je21I9Oy1mySqKzmomxdrlcmsXkU67wXw+/tpVUmsNlww7UVK0bOPtJBQDe8WcJhXtAneAugAlrp2a6bWZRH+jVx9jLYTfTPcYS0w1s8Iel7iGNBEXe9EcdLigSzR0UH4GZndSiA9e6Q3Di+Nz6hR7d26CqFz8Pr7Jb7d/o65UiDVusqElghW+jKJter/jmDrMgmIe2gJc6OJLxiDgXh6KXOoL3oRtfDSPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXpHGREvTHqTpPK4R0ji/FD/fwBfj1jKwYYE5+9shSA=;
 b=xps8iApm8ddnZWnzpZn9s926EWiLzoflxjXJpjOU+HhKiyyz9DIqKp7hFP4E8m2zuYdLk8aAdr4im+/bKe36NJ2U18eQZ7VBvVf2uXWjnxiw0riqgpQWe+qOdZ0RPveBYUkxcVPeaWK2BRA/H+v3yD0XDuqeSGkeUzlnbtwps+84FaQO3tJA0s6eiegogN80Wb8/ji5hhPtb0ICPw34mvwv8xzipJzCXx5fDGq+JpL2wMGO2sdxJHXoNAatqhT2uHqY6u7t2Oz/B9x/6m7NP0pu/YEn29jnCBIc1LPp+HSChmKziNvfgQTL1JdfHynIeKHWlWl4oKClvuTLqje/qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXpHGREvTHqTpPK4R0ji/FD/fwBfj1jKwYYE5+9shSA=;
 b=iTvR5M1jWlTtV+4+eQTEvBoSe5lw9rLsN8o/b9VZ126VvUN9uTdVHaXi2O6pdlJb0gDQRVYAIxcJr+Dh+BOgPG4m2mrXScn/j+/1cRiFR5p86y8mhiD7NL8zOPBnycp0YR6bnOBHukhmRTSGvDMLbN7QsaFK1qvQbcgcmLZdA0TOs2jQ2sY38gBefWqQ94q9JykWmL5jRVqtIy4DFAP42uhvx3YAqVM0jH1eVlti2lck5DW6xx6k2vwHTWK76lK02RAAyll0vbgBUCZa5CxOH++uC8aiNJZEELrcqDNyjjeadjobmOPRqdOWAXkIRTGRd8pdyN6FRyNK3eI5NfW6YQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 02:58:16 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:58:15 +0000
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
Subject: RE: [PATCH v6 net-next 5/6] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v6 net-next 5/6] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcINxIDdegUW+op06Vqn03Bczw9LSKKFUg
Date: Tue, 9 Sep 2025 02:58:15 +0000
Message-ID:
 <PAXPR04MB85104BC0D96B83A13198F78F880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-6-shenwei.wang@nxp.com>
In-Reply-To: <20250908161755.608704-6-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7553:EE_
x-ms-office365-filtering-correlation-id: edc8cad6-ba9c-4fdb-a933-08ddef4cb927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H64t3fiDXTAO7JmYXld3CSfrzvjKlV5meYrSP0EqtrN5nvc9exnqrxBExL5d?=
 =?us-ascii?Q?MbUb/CqLWlYkZ6jppOS1T2xZQDNI14QB9tJtk6dKl0dp+vfegmK+CjR7m28H?=
 =?us-ascii?Q?krN52lDcO6ZCcacjmleUNMYyR4LxmxQrjid4EEQ4uxGxT+PL1GfQ+0H+xIeU?=
 =?us-ascii?Q?iyVyBJqSX2w/svNr7i3CJKhXnCpuu2rA7nAugXxsRkx2c+RQGer8x1xqsf3b?=
 =?us-ascii?Q?3Ow3lLbC7rrIcndFqJEKj5UZHoI2mxzN9CUpxpN2xLD1SA3VRYZ7DkcNdDt/?=
 =?us-ascii?Q?SrGNSIKyDh6BMyWrl3udq2SREVzJJ+YEp3SJegHLXTtOEkOc02elCdJEL0lt?=
 =?us-ascii?Q?l5ieaJTSwjrDd6Z8vp3we7LcIVtCzm35wzQogq8579jzdxzGtxwUb4G4haP7?=
 =?us-ascii?Q?DMfstWvpjLW5eBkngeiF9Ku4CP6oFN4tYJtqN0GIFAl5Dy1S45QzbZaFTBx5?=
 =?us-ascii?Q?ZIhyOu7uBNhW4J0USi0QylIvAegsMknMrp0NgLmNt1yogYAA0J2QIw3bhEJF?=
 =?us-ascii?Q?gFKHBtuiAIqqzesKa+9+lZxx9EvPw9GPExQ5VHzoD1XXdMWcSZD39REvUWQY?=
 =?us-ascii?Q?bf0zdj0cI8QFNynVjhG1pfwT5r0B7fldp62QVh/FdVIhX+d0e2ewi9+c+CaZ?=
 =?us-ascii?Q?LIHzmTEDHFbV7Y3zb5/XKKJs1cnAuWlobtoifuEYQY6V6VxS8vfC8f1emC/7?=
 =?us-ascii?Q?emlNo4UscsY/kBojaN8FyzkpaBfXqYhJtOVgnGRRqqPeIYXGd2hDMY+bh/fB?=
 =?us-ascii?Q?pvF5nUBBv0C6I4vWTzL+8K5X77hSZZQoz5wxc/Eq10IDWPcjxX5t8KeVi6sP?=
 =?us-ascii?Q?YN+LMtRYFRBTV/as3RQoFbObABIdJka5iZOUScelEJRp5qAJhW72dntKuk86?=
 =?us-ascii?Q?ZbLOYOeVx6PMf1NTbzLLmT/ysRKec2xGwhnHOaHAgTZ9I0wgSli1WZaVrrwz?=
 =?us-ascii?Q?im2Vcnkn7bGFDPLd6N6CXIBW2mjGFho5x/ILMyuCXhBI3suXonvR0/dA+bwj?=
 =?us-ascii?Q?qyPKXwrZOz6jwwUvomfLkv0hOo1iMBmhOsB5Q6l7YPuKotVL6NGGm1eVmHFS?=
 =?us-ascii?Q?2RxZiG2bZV16HWFdkiYb6AOQbGgD0jh96I7xZ6G2xZpaJieR9BXwNAMxHzyf?=
 =?us-ascii?Q?e9TtSJTFs8bXVbjVq3jP4fXQxpGIGLT6AJsnTpJwPUozT0aJdRj1FKJJ9Lar?=
 =?us-ascii?Q?GAZ1B6siS5yFx+RbASkjikiWqQAC8ghnctOzgaCrclw04/j7+2zfg7YSSvUr?=
 =?us-ascii?Q?/mA5FVnS32vzXe97N2d0y6e8yKvxUgyxJU4ymCl1NAFfyvjM6HKLq69X2HHa?=
 =?us-ascii?Q?APE9IulpwE5JmAl9wRLtqaplmFV1TFOz1cQCnCMM+S3KIfwc+I0oTC9S96rb?=
 =?us-ascii?Q?Td5DjXDP8f8lxzAANxj7BJlkBqv7+xenVzcTt28xsHTXzuClr7nDGY7bFQ1N?=
 =?us-ascii?Q?kTmwY2kTXpTWe4ENcylSoAUWLkKlaQMmvrIwpxfhccat/Q8EMq5dN8vhfB9S?=
 =?us-ascii?Q?loy6LiiOrLEGqqY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0O+yN452/PQ6OgqMjljCruvTcDiEM9OHFVKLvZ1+/ybgO+5XY64QtXrBy39A?=
 =?us-ascii?Q?vSkIkO5F4yt7gQHKqBNvP9kDO3Q9eTZ8mxrtXEe9yywDG9ua4igQE0cfoIBB?=
 =?us-ascii?Q?kxS4kEGJlbT7cnn3kMdv4ETtgQ1IOW/qhDzn4xd0Vx7niiTosuoB5yEEyAZ/?=
 =?us-ascii?Q?xNd828EIFEXNKThmZIsDz8Kwpd4dl0dAfH63Lb1RCcdtndFBpxIsOCWnB9gI?=
 =?us-ascii?Q?WQE5X0iVPimSKRT9Ld0A1uSvTw2HkOxwEzIIVb/x2EdRZXLuBhjwFZFunInx?=
 =?us-ascii?Q?nofjnvmFjyWCIU1/65d0Ni1FWJlPJCM1PRQBgpP1qdlyaw73yGu+DTzgAiKM?=
 =?us-ascii?Q?egB4YS2DfHjkwLndAAOQgwj9moOO9qWwUPuHN75sHqxU+76xNRUtwBB84GFB?=
 =?us-ascii?Q?Dv9VjLV/b+bRuiQ1y4N9bwKl9kmyDnA48pNdqflUGsLNf9InZ9zAHhHiI7O1?=
 =?us-ascii?Q?jd1klmYB/LnXZdB4xILaGh+kp61WzJXsfuvKFMSwoEA9g5bohA78qmgBgqCY?=
 =?us-ascii?Q?NoiysbYRCze63Q6FmzkPuz6vhSa+IYpK/yxVoe3BffWpSBrNhthM2CownrWs?=
 =?us-ascii?Q?5D+WvvFFBMAj9NoKk9BBVj4uGjKe9udTw6+kNPwBJABnebeRUKCOhcd3SuMp?=
 =?us-ascii?Q?E4x4L5rSo3gXjAHUrsbN1bRoH9xZyMjzY1dhv16twvApzPrZ5bxw0s4Vfd8a?=
 =?us-ascii?Q?im7ufO/Q8T7Sc1fLl+9DyeynjGjsKu0SDTJIG7ISBbg3YddI+xisgWiHURAq?=
 =?us-ascii?Q?FW9+7Un4sg7cAouHBR25CLOPRQpeiNPu3mAVjBjgVurwGVBRAzPdKopVNd/+?=
 =?us-ascii?Q?WlGfYkgFXfGYEfdzscla0rXUyVu/Q/4d80doHidKse8MJrDS39x4dqC1Sfqq?=
 =?us-ascii?Q?gZL4tG6MTeD5c7TRkNaHZxlS8yZ5ZfL0iiGRTduyv5AXqvNdRzarPJ1vv49z?=
 =?us-ascii?Q?ieaw8CgAYl2qz4Qedb17BOstCIfezr8PgdZ+Dba8cIJF+RLgExdKhTpXKDeu?=
 =?us-ascii?Q?nI/fJU7XTo3/Z30V/XpRbcScGNFzxqKBqsM9a0/eGM0b8B/0JQRlmG3IE9MM?=
 =?us-ascii?Q?oKl+78BP+kMVTv0FiQkLtCqgVFnKyhfWZJuxok8laBtNQWfTw15bTTJhjqfh?=
 =?us-ascii?Q?WAER/IGBf6liNCesjYtP0nhszwd/Awi5XMPO6H0lZuH/POJJGHxi0a9IOlKr?=
 =?us-ascii?Q?vSCfl3i89NNRI0GZLiiSXNiWhSi+S52jquMeuL/KesVUVwrucYj3AaHVJW/E?=
 =?us-ascii?Q?bzpNuBvYyABhkLdX0SomekNBfpnbZfofS2kcIq3GC0DAEbgD1BuNaeA85Y+K?=
 =?us-ascii?Q?ty4BOJHW17Vtr5tQEtYe4CK1nWWNslMeXnqycZbt0rCuQMpqpO8N6i5WGTUT?=
 =?us-ascii?Q?CzCkC4kH/Ux6Kdr/5iQ8FcNatkurHqI4FksQj1pCj2pQks9r1kwTt9nBixUG?=
 =?us-ascii?Q?sUi2EgWqPYikInjFGPCSpQzh/8XzeaUTp9jit9mdoOQAePDIXAEd6q8cJf9n?=
 =?us-ascii?Q?49JABbR+XJFsIYu6lgAr6DHd/XVvQ1ustT7AakN2uhZOhJex1GVlsG7UNX72?=
 =?us-ascii?Q?EuZhD4i5/qaQsJWpwf8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edc8cad6-ba9c-4fdb-a933-08ddef4cb927
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 02:58:15.9268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AghWIBOIstS2x2sYKfnwYCtd4ZQmPQyQ9f0eXsLsaJ7Co4VsFnbpOEfQc9g2wHOd+hJK42FPlaB6ebxTF7OD/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

> Add a fec_change_mtu() handler to recalculate the pagepool_order based on
> the new_mtu value. And update the rx_frame_size accordingly when
> pagepool_order changes.
>=20
> MTU changes are only allowed when the adater is not running.
>=20

It seems further improvements are needed to support runtime modification
of MTU.

Reviewed-by: Wei Fang <wei.fang@nxp.com>


