Return-Path: <netdev+bounces-95583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358448C2B18
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5855E1C22583
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D124D9F2;
	Fri, 10 May 2024 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="negflEVT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8A46444
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 20:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372437; cv=fail; b=dLx6VZidGzhCGlcSfaSOQhgOdFTySY1z28i6BO7rTHIMxSItevYl5PT7gx/DQHxa6GO2cPuWlkxWYDW4UYJjj6GpNDs+djGjm7EcOdSlcxneFGYcJ9REnpQbjZ6o25I8EuX4DGc4efnd49CPj3qduaoBvT/XM8KDlWLnjQ+P0tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372437; c=relaxed/simple;
	bh=Z1vs87LMfGUAiGCp7MCW++d0E2hQN0Yi8XdXtV/JYBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YWrbsCqYTTc44PX3WV2wrX2uxqOj+hXLMfUrhI3F0LavNLUvJn3O1vU30cmu6Ex+B18qaqb/6jHDnRpDtpiIPIlJjK134X8B5HcH0u/YJeqRmouT/LBNXQB1gi95dzosBqiQ2GUHb4DcNDTA0p4tAi7nYMGiCIGR0Gl3uJCeQbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=negflEVT; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BewqxWhyEFlQIsXLIvD67LQqLuiuqpZni8YTYjz3urNgf5YT7TbQ3CFVAH/3HB3UZgc8LjdwjgVk3ETNSJd0wcFrH92TvEQMOI8QIcYsQO0S/Yec2sPVzBiwAzUhtT7ENAT6YvrrR5R2Ae4wb/rzUe4QKuopiVRdI/yv6khR6aJ6Z4w5td0qQNXq1a8aSVL6eD3hvtLbZT1NlHocq5Oqtn96Jtwu9PuWaK0MRA7gGGgN5KEnXUsQhUNy+fizbZkCgReOA0K7zlfkAHRHH2Q3Rid0yPCXo7vKfy2On9R7EfYHhUuX95OHzLyyKRJ/KFJ12Z6n9cr6UPZ4apgM7fI90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMOnddYCCeraCdTXzOd0tGZA8vdND1A7wh1PuuyMfb0=;
 b=NNP2eLZXnmv63XenGTX8ZKQAHeXgSgqo8aaDPMLrn7BYeNE3sQonbRFHyNrEP6QKNwVXYcrfz+HdXo2D4dP0zNIMIVY0Dndq2B6NVeN9TvZA6qzk7OQ/agrJYf4l/NJ44bZherikkjt8uY6OsIQRA3FxB5GZQie+you7oEduHvA/0yTeTaWUHoHf5FJ2qeNJ6cxAJysxEj+p55SRyiCezHj3DSsF6BRSHLR5dj/tjJGVwGIErdqQJ1/AG4b94W07W/RuC9GiMW2q08i3/X7WjhstStVJdDPzdNaGgG4BMFr0KjBIKZrDrj/LxjawMLuqEfY9P5posinHVWl72U4JuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMOnddYCCeraCdTXzOd0tGZA8vdND1A7wh1PuuyMfb0=;
 b=negflEVTWsKT+PAdvuiV8dnO2EYprJL22gaasT2F3jhC3Yj8cYuNGfd+T0+P5b4BNUQ6vLHetlWpmZdRShk8x8PWM8avydU8ox3uaIvWBtyo5dfTYFyaJIQMaVAPGRa6P3zpcbJo0O3YwN1plv8NjivMiZEfWwzUSXKrkMfzecnJWd2gX5ORK0giBSCmiKF+jcZG0B7ml75uh40hAtcif1UuYHBZk57gDt17xHmhRHAn8eK/9pV/FKWnKwt+QHfwQiiVUtvtjTdmrrz0r/nIIQybRkwK9S3MAiFTl984yhDAmjNtVv2HFGYZo4aR4WB6NgFg7pUNK8efH0i+x+jkKg==
Received: from CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 by CY8PR12MB7707.namprd12.prod.outlook.com (2603:10b6:930:86::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 20:20:32 +0000
Received: from CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4]) by CH0PR12MB8580.namprd12.prod.outlook.com
 ([fe80::ff67:b47c:7721:3cd4%4]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 20:20:32 +0000
From: Dan Jurgens <danielj@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "mst@redhat.com"
	<mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>
Subject: RE: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and wake
Thread-Topic: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
 wake
Thread-Index: AQHaoi6KsnE7s0ArT0mYwn0pQXyMcLGPX5MAgAAHyfCAAQfsgIAAeynA
Date: Fri, 10 May 2024 20:20:31 +0000
Message-ID:
 <CH0PR12MB8580577826135FEA6AC52F8DC9E72@CH0PR12MB8580.namprd12.prod.outlook.com>
References: <20240509163216.108665-1-danielj@nvidia.com>
 <20240509163216.108665-2-danielj@nvidia.com>
 <1b16210a-c0dd-4b79-88ac-d7cec2381e11@lunn.ch>
 <CH0PR12MB85808FC72B8F48C3F6BF3A9DC9E62@CH0PR12MB8580.namprd12.prod.outlook.com>
 <26e8aa14-b159-4a3c-ab67-bec41f15f7c6@lunn.ch>
In-Reply-To: <26e8aa14-b159-4a3c-ab67-bec41f15f7c6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB8580:EE_|CY8PR12MB7707:EE_
x-ms-office365-filtering-correlation-id: e1b84379-3d48-498a-4a81-08dc712ea45b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8K0FxfUTkpax2HOoMk8EJcInWUDzyO9BMAcRL4Oakt6wrv2qXuWdTz4VsG4L?=
 =?us-ascii?Q?wzAS4ILx/6KT6cBIzR/NnZU+mYC7BbFpEQC4cGNnaPRVI22n8BzbO7SN7g8l?=
 =?us-ascii?Q?mMv0ELwX8IJa+vaeKVGSEgKwO1hpQY+aw4R6IPvxFEitjQEa4mkho2lN2iA5?=
 =?us-ascii?Q?UnSnSpeftKmI6ORhjHhAy7rM7eRKX+dXqKFu1uue+R65oH6+9D/KLGmjhduK?=
 =?us-ascii?Q?deQFDmEm/2oX4kOAxu/Ap1Xdf1t5yOs+tbkhv314TQm47voSG38267O9Sbua?=
 =?us-ascii?Q?/9cRsJ7rDzW0GHcCwuU7YFczXvMGFgrQjfhIfx115hTSpUiuLIZsEFrFcOa+?=
 =?us-ascii?Q?pbvqc7t5byjhDxUC1g7wxZ4kdg29zIlfL5/ijsIVsf2AT1RPws9tS/oyfwaT?=
 =?us-ascii?Q?AhXUi0QkKhq3y+BGCStkDfoj1P5IEZA2HR9uAjg+O2L5GwzHEXkDcjPRjsEU?=
 =?us-ascii?Q?GJZAF+8BuS7grl7Wz9lqmeWbVP4RFRfQRxJz/kuhAXsYrrnVn363gbW4CWZy?=
 =?us-ascii?Q?JxjK78QghIg6cGJpzNkQjDD5uHv71/v2t2uw47qxngI9bIWgztgXTz3NxQ8t?=
 =?us-ascii?Q?/fqlsWPGZezBgZM9gGSqOtNJqw2LrhbtHiIijhE9N9cS2RuX/+L40arG1kSb?=
 =?us-ascii?Q?yPcpsUYCFKQwio+QXe0hHJBbg+BESLaYc/XP/ufwg/Ghzk5/kkbybiOzj9GS?=
 =?us-ascii?Q?YVey4mz8fe/lYrOZM6w2m79oYYATDdS/EYU5wAijLvogHjanaseZnnpzHksz?=
 =?us-ascii?Q?zWcO/gEnPYsKnF8ckK/bSDbriHpWOr4eSmKBgT1VriiVLYtxxb6amtnZ1MnP?=
 =?us-ascii?Q?Qyo5UxeztnBlZJ6UtRt564w3YDz3w2DWS57HV2Fmr769kJB5hNXH3rJvJOr0?=
 =?us-ascii?Q?aR37Nhye89CMXB0/SInx5PItC076QRyWoQvXGqRZa56XaJemPfW1+zb7nenH?=
 =?us-ascii?Q?DiphTZQ4qIAHjPpWU8KEEyI5+Kv53yTCgXyqRkZ9teOfKD/Hb/Dg2wKIpTRu?=
 =?us-ascii?Q?B0FZzRQXJ7u1qCJAoSuyxu6wDlxfEn+vdmnX9QpuYm4Rq+uyyl7Zs02Ztq9w?=
 =?us-ascii?Q?gvURU2lbsoFELXh3evGiW/H9XW6euoqZ0biYxYLIsOGlscfOVvUOsbQtwHuJ?=
 =?us-ascii?Q?o6QHuQRS13d3v/YJgMtgjvYPwf28xulvZwuQpdPIcSbmY8O366fqgQcydShs?=
 =?us-ascii?Q?7Mg7/TsAlgxUkCEXwWT97whT166GLscbkivAOMnZZuzmAZmupJ3xAcOVYlKN?=
 =?us-ascii?Q?qWlfn6+7ERPf+XLAWORqlUBcZlncB93cYuJp2riZYLiKdFTYAt23K5r49WID?=
 =?us-ascii?Q?NAHJXDzWY2qaBFGzUW3r74qc4YtsztFmAUmDwiSiTJY0cw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB8580.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C19b1kuOE/SA5NH1bYsmR+Yp7QWsMwJhhCTMxtHp+873eCTfF6N0Ji39B6qH?=
 =?us-ascii?Q?cfxogz1cT+VPLnj/JVuhW/AkDl68wFonxpjoiEsXZX48P0g4zPRPPNCNgQ+Y?=
 =?us-ascii?Q?FQ7AFMbD3pxbqdqwoYeLguDXcnfblzEOZU+m7hBBMS2NR4XrWYd4un5YCrki?=
 =?us-ascii?Q?Ii+906tdxavE4QPd8R/9GcNBySE4R2ivDu6qAPeYF7Ru/d8NmMcgydgQdg7v?=
 =?us-ascii?Q?9f8bvl35Iw2sgewqKa9MpVyTBPVA5gCBVW3jYupVlrp9/9x/QE+9yYWErWN/?=
 =?us-ascii?Q?fM1yJd3upBXEtFgDIf7cSliKqa0kZek5iSE/g9GgPu0SPUL/O2wnntC1i9wV?=
 =?us-ascii?Q?1Pxf397ow18YqxE2YcyFHB4J5U5JGz8MNkOYeYXu9bwwkOxAtp4PVqgIyzET?=
 =?us-ascii?Q?WwNCcJnIGBfsfCwMyXl/3yLQuvG+mR0RhROvbLQfZP9BtSy10+90aPBDW3Jl?=
 =?us-ascii?Q?MlWu6ekjefyLHM1nE3cw7+imFo/+N7qgoAWzAEAYYnL09hB+mYTh8prvfnWv?=
 =?us-ascii?Q?lS4LVT17X02Pq5x92qYzZOPDXUL8GPIMYmw5ij9fWVEUarvbY9caIi6X02A2?=
 =?us-ascii?Q?ccSacTG44SEZyoxS9I84TDYtYx8jo7wHIwNS1Zd/+2fDhNhrZN0UXy0cX3qT?=
 =?us-ascii?Q?l4bcxum+R/ZRdWw1avyenDM8Wu3hCc9xSzRqLQpeP1HqdpqNPE2fs+zFQedK?=
 =?us-ascii?Q?yvwyaGKRE6LjXC/D0RcQ0SOjmkKfBhXwP6HHXhhdcZBJj1zMXzwgM+fn7FXo?=
 =?us-ascii?Q?d/m/fVOTsP8wWd8Lr9aFxuWZFO1zS27WyL8P+FXXssF1lZim3Kc5iWhuGkix?=
 =?us-ascii?Q?Ke3WKK87LsgEnharMeWGt5XPKbxJ1pQOiF1xiNoSN0xPDtx+w8h+TBeN2xRF?=
 =?us-ascii?Q?Gu68Hae03VptXjqrV1g1yDr06duKc79cQEFW0MaYpFGgkkC82uaoqitWgXtt?=
 =?us-ascii?Q?Bnt4XilPTVMH+p13Ke7YnSnRXc+2bcBrhhWq4/79PsE1PzB/bWrYk76epWDT?=
 =?us-ascii?Q?wSQ4sTR0s7wAcyuyebhds2b7CTmZhSL15Z2xnZ86HoIXKw0SqqQESr583+v0?=
 =?us-ascii?Q?0iR8PxC1vc1fS4cLt31hzfSyyKIE6tf0GcbyxAjYIcsjY+n0STMx+e+Z+wOd?=
 =?us-ascii?Q?LuJ5XbQraBUYYIyaqGUSQCxuGkEMYNr6Z3N44eyAgWk3XQ++Wyd/6e+umzgI?=
 =?us-ascii?Q?ym5p+6DRwC25QgWm641he0D7Sp0M54/vDp5BFd4aY/V51YxjGPOlxyLkS2Se?=
 =?us-ascii?Q?Hp32QtO+WPIMHBU0lJKuiCdULOveKkZplAfUPV4v9iCbiMt53DEH3I4LbI0T?=
 =?us-ascii?Q?GS/8/MWHajnhmoeZb6B5A9CuLOPNgY7onVPePAng/CzPtkRWnz8oXe+E32+Z?=
 =?us-ascii?Q?zFQSf8SnLmsccOgFr+VTzrUiXNSqsOsqplmoUY3LiJ2lBcLHt6GAK353lxsn?=
 =?us-ascii?Q?joZMDEV5WgJFy73BAJ2Bjf7+FhOEmTx9bkYxfh8W5fBTA3LlhRvZ4LlrQ672?=
 =?us-ascii?Q?L8+hFyrnv8QakAIcoEeb2soRD52zcjnHzKCukHaINW3sCqLmRdMZfaEXJV6T?=
 =?us-ascii?Q?2X9RTwLHzGgHgjU4VHE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8580.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b84379-3d48-498a-4a81-08dc712ea45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 20:20:31.9186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4A+SQoTj7EJORUpshlT8Repy8jmWUQV0rwFSLgXeOn6FQ1WVAkz+95EuyLZlxbYZjdgMToMegGG3Bg2HyjDdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7707

> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, May 10, 2024 7:59 AM
> To: Dan Jurgens <danielj@nvidia.com>
> Cc: netdev@vger.kernel.org; mst@redhat.com; jasowang@redhat.com;
> xuanzhuo@linux.alibaba.com; virtualization@lists.linux.dev;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; Jiri Pirko <jiri@nvidia.com>
> Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX stop and
> wake
>=20
> On Thu, May 09, 2024 at 09:19:52PM +0000, Dan Jurgens wrote:
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: Thursday, May 9, 2024 3:47 PM
> > > To: Dan Jurgens <danielj@nvidia.com>
> > > Subject: Re: [PATCH net-next 1/2] netdev: Add queue stats for TX
> > > stop and wake
> > >
> > > On Thu, May 09, 2024 at 11:32:15AM -0500, Daniel Jurgens wrote:
> > > > TX queue stop and wake are counted by some drivers.
> > > > Support reporting these via netdev-genl queue stats.
> > > >
> > > > +        name: tx-wake
> > > > +        doc: |
> > > > +          Number of times the tx queue was restarted.
> > > > +        type: uint
> > >
> > > I'm curious where these names came from. The opposite of stop would
> > > be start. The opposite of wake would be sleep. Are these meant to be
> > > opposites of each other? If they are opposites, why would they
> > > differ by more than 1? And if they can only differ by 1, why do we ne=
ed
> both?
> >
> > The names come from the API. netif_tx_stop_queue,
> netif_tx_wake_queue.
>=20
> O.K. So in that context, these names make sense. Maybe extend the doc:
> to mention these function names?
>=20
> You say there are a few drivers with these counters? Does it make sense t=
o
> actually push the increment into netif_tx_stop_queue(),
> netif_tx_wake_queue() so that they become available for all drivers?
> I've no idea what that implies...

It wouldn't be trivial. The stats are queried from the driver.

>=20
> 	Andrew

