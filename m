Return-Path: <netdev+bounces-67789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1147844F0F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 03:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FB51C20B62
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 02:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036AB125D2;
	Thu,  1 Feb 2024 02:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="csWTv16N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2137.outbound.protection.outlook.com [40.107.94.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE071A290
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 02:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753815; cv=fail; b=P4cyRMnoCscHTWB1hNH292vcyJJB59sEblM7Bc76MrGEv0pmjqRWTcVpA1Q2xAthA6A2X6km4p8Ctw1VTO9iDyuGsHs4MDpYBYUc0+IaJcJSVL2gykHjnVsRieC7r2VDPn8hbZ9XS5fxItaA+pz//iQJ1nM78XpVduiZht5P2Cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753815; c=relaxed/simple;
	bh=4WeZb1bkm+4dL1RDq+Jh6eyB2M1SqSu7FQG+BiixUCE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kw4cIDfTqWDRxBZPZD9qcuE4xKIntDlzQ8f6lXtDHZFvc0GBH/AdxMILIodxrTf/C4zdd6UpN815IvcpThZSO7KKGZX3d/Gy/jEDXp/+vRlT1FnCfBZlxfSOOuRcHceZEQhtLqcezZcK+iJcKckYW/FY6dSZrkeBUe6PfhAEwHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=csWTv16N; arc=fail smtp.client-ip=40.107.94.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iesgfvxd6vdWgbHwZtjD1+hAtz2R1sVoHR61I/utYPooTURoBKBRsfUm+WQO4DguyoK5Jxf5/NrZCfArZWXoRN7PaWa9OAjtFPJBDk6R1DVZMPYIsRLUTAuhe6kepd0BS3gyPyWZA12ESWQDuxY5eRwVjb4XtPBI50XUOlKT0cb90Z3wEKQXA8nknG3qdvEdaKDuv8+8fA4rScd+i+jjqxEiajiL0s1R5lMo95iu1VstMy3JMwNaug9vlsmHS6K2euYPfPKaouRga8SLqNw2bhAjeKPp/Ysn33j7pxfK+iuAvl025RnpH3ApoMo+OmA6DSuDvAQoMDz8+TEubuBOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nir28N7PDBqMLQH1HtXGk854yT5vzjhxd0NbDlgqdh8=;
 b=gQmAqF6DNpmlv05AQDy+j2gm4p1I3R52WYfeQG1Cb/kklq7sN8CYjC5hLPqe76ZCQaGlJEz5MN5SXjUJ2mcRXPQSpYahDCsHSq/psQLNJIlL+K1J6dtlRziFnch4/LKFIi4msnkF3tkmkou5ArsJcznktHOX2FfB2IUYndFRaISQwNTflpdEDaGtaa52kpX9c6dnD/qSQPwbTYZ8nSygOwrmvP4+vSaNYDm8iT+lG51gbBnPrDbMP2583e08SETLtS+U0A0iTKDkTN8OOgXcVCgC7FEXdY/ybcfg3WJ9KfBJoO+n14dS59yClTeIDbjzU6D7phfW0yefK3gxb6eM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nir28N7PDBqMLQH1HtXGk854yT5vzjhxd0NbDlgqdh8=;
 b=csWTv16NzTK2JQgjmerO2z8phoOE2mfS2fmUX/gU1P9VPgdut7zCpyLkJc6xt0ftxQ0eBd0VEduD7nJOJczSFVYFziLA//EqWJrMNDZBsLCAChtEvmJWZ+DVXG/vyoi3n0pGTxugH5Hj0ct1xuQA+rAIPs3ANrAFqjGLjEl3Vf8=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by DS0PR13MB6206.namprd13.prod.outlook.com (2603:10b6:8:121::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Thu, 1 Feb
 2024 02:16:51 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::1430:6f51:2a9b:7c44]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::1430:6f51:2a9b:7c44%5]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 02:16:50 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Jiri Pirko <jiri@resnulli.us>, Louis Peens <louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@nephogine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
	<oss-drivers@corigine.com>
Subject: RE: [PATCH net-next 2/2] nfp: customize the dim profiles
Thread-Topic: [PATCH net-next 2/2] nfp: customize the dim profiles
Thread-Index: AQHaVCNAwGrllAkNU0eQ7jwunHEpD7Dzql2AgAEUGpA=
Date: Thu, 1 Feb 2024 02:16:50 +0000
Message-ID:
 <DM6PR13MB37051F13B28B53F2CE135CE0FC432@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-3-louis.peens@corigine.com>
 <ZboVNWrlgucuxH9N@nanopsycho>
In-Reply-To: <ZboVNWrlgucuxH9N@nanopsycho>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|DS0PR13MB6206:EE_
x-ms-office365-filtering-correlation-id: e0b66c53-82c3-4f3a-f536-08dc22cbd9ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 utFbBZx3UTgKabZ4lfzuTdz1SL+3U4CMoEpqTbwyxKKIAMaP2hkTRtSf0yS6turaj1M6EVPvbvu9QC7U7Dl+zsj9zVxKaNWAJLPhMlzr6+l3uX7iKlJKNfRqXaGQJ+I6yZv6jg6HzcXTWnCxK7Auetpjk+UKeL2esu1QgCOxxJq9Mc43KXAPYiIaULfrR/htdsVVHtwFSGzsVyK21/91QKZiOcheUMawlcseeqORFgxGyXuY+KIAd1y0M48ZzDI2QzS9FooN1GQhp8IIBARoyR94u1Y1fq6IM9zX1tYAdSfQql7/20y1PIUJ4AojNqs5B+hRVngZnjSfqfjG88Nw4dCfbLZUDqe/kfln11O6qSWi0K40ooPH6m7Df4Ibn40bNEK2fN6OrqSYFeRizumie0d7dMtqdq2zJYLqvZ/LmK58yI1R9Vn4DBrJ5JMsa9sNhzDyV0/gnCWzAAXQE1kuIk6IN0OKXVDf+wDB/w5aasRGQFKK687XdItgcNoa+bP3Kf2X0gWnSV4bM4ujkGbASQsTPiVm48zPyZaWBHd53N/tjMSF06eMpm4I7KatmWbYOM8z/gx8MLCxLq7EBTr7lPGosBQ55hvZMPYKFY+9wS298JJfQZ3C9o86zUGTMT7r
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(41300700001)(66476007)(8676002)(52536014)(4326008)(44832011)(4744005)(5660300002)(2906002)(110136005)(86362001)(33656002)(8936002)(66946007)(76116006)(38070700009)(64756008)(478600001)(6636002)(66556008)(316002)(122000001)(66446008)(54906003)(7696005)(6506007)(9686003)(53546011)(38100700002)(71200400001)(107886003)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Zta9LR12EysVhJBPqe5+qedu7KgUdH7pmXUgrBhecoW4yUujZmSv5SbsRGv8?=
 =?us-ascii?Q?WZXeKijBAEnFllo4tKm75Bxkz12YU1xsWoNsvqAl2xdoSCsde9Gb5JsmMIhs?=
 =?us-ascii?Q?2wZOPr+d1m0Tiy5YSq4IsVkO6Awu9qrxrOxnE3m5iqg/DfDvb5XedhX23gfF?=
 =?us-ascii?Q?5C3HWmBYdVI9wwwdw7qHNcns2SuXolrnD/8ZhZ1URqafmoBFLP79/g5jQ1yc?=
 =?us-ascii?Q?BVOCoTcMp0aOndBprYLXACIiLnGl8z1QpKQXEG2ftjvi1eNSkpwSuT/F0M04?=
 =?us-ascii?Q?XsZp8cqPQCJpPp1ILGeurZIwrlonoXNdYVq8h3/ozJ1DgjZo4ukW0eNuA/nb?=
 =?us-ascii?Q?hghAC3MH2xItaOHOG6q26E7S4rOPQ2V3i5+49xmG3yGw4e3Tq+AGJiWaCKum?=
 =?us-ascii?Q?GUBsQobKoZSJ019BQhTgenWPdzqqEgpSb42XlV2Y7yU8XhhFBlV/h2Okl2Mh?=
 =?us-ascii?Q?TY47a62kepc5xbhz98YDmUBkV0WSB9Db5YJR+tMYWI2ICOUOETYg0bF6doLP?=
 =?us-ascii?Q?ZvoL8Vr18z3ZdKH1Fpp9h1/P20zYb6g00zXL33P2umWPi4dDNbK3aC+0IzUu?=
 =?us-ascii?Q?LTXFne+/wIvgYuS3CbmrZjS2O75eJ4rLvZa0u9iwRF8Zp9Go6sD/z9seK0nq?=
 =?us-ascii?Q?b+G8hB2gC9S5WA8cqQj6Mr2lqwvnoEflQRNNXlh1rEdI9F1Jun+QNBCePFxw?=
 =?us-ascii?Q?tRawQVCtVkqfNvkUTJbJAASK+HGAnckV/3sqLot9Bw0sfFbOtjq7L9cZ2lNs?=
 =?us-ascii?Q?8YStj55G5NEgsXS6ytkvcX1hBWJsNdnW4E0w3eOmHPl7QBGCgZe5a1m/+x+Y?=
 =?us-ascii?Q?m4GesolPbxhMQjGQIZ3K9h8Tq9xWOtdnLudP3wVllPZpLnA0O41NwAK5i+Bq?=
 =?us-ascii?Q?t6+c0PGPGq94vmPnuqTM7C0AKJP22Ad3Fse2bJuKDfrxFacbAbEJ3dcngUoM?=
 =?us-ascii?Q?M4DoJeNCx++Lc1hPsxonnIa5N+odND9yJOaC44griWDLP4ty+ahjB/ce4d3X?=
 =?us-ascii?Q?5AwuOIJ1zNtftQSF/+gT6xrTDnulLmJmojUQKr+f7la1/9SN+j1pJO9yHil/?=
 =?us-ascii?Q?OcrIlMGUC21XjqOxhNQ/Z53XZaQBYAwKTz1sPZcziQud9SndOYwUAPEz9zdj?=
 =?us-ascii?Q?Pn5dT6IcGK/Yq8OxYiey83rbYTFLcwxQIPuckdVJt+aYpxS+KcADqBRSItBZ?=
 =?us-ascii?Q?DTBLm8q8i7euxfaBieikeUI+ea81yT+ik49EicrfosE6tepHrO7QGnXKx5iH?=
 =?us-ascii?Q?xJIWtEWgnSZJ5B3OEzLtcKe0rs2x612sD+Zxs+U1ahoJGQU0fFgIpPWYwvuz?=
 =?us-ascii?Q?kRq3ZYqSUW3qW8a+8heOPVfsnv37aF/e4ZTwvLFygBpaO55S5ZDa1eUTp5Lg?=
 =?us-ascii?Q?YunsGszRsT+Dkm4WqnQ1ffFUv3auLsQ8DSEpvhK8nPBm9xw+2aKcanQRRToa?=
 =?us-ascii?Q?K8ARg7Ap8AOKRkXE/Vt566kDP6DyKT1XIuWBq0duqT8kX8rX8XVcPVlOkrsR?=
 =?us-ascii?Q?MfIg7Mo9eY40O/yzaGcDoM0/iOdi6xt86t4NTgp66qdGoPXZiCn9XJnw8EKK?=
 =?us-ascii?Q?52Kdl0DFZIGgeozJUHOILEoNYUMK1GuIJNgbpceu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3705.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b66c53-82c3-4f3a-f536-08dc22cbd9ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 02:16:50.7166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awFo3OEZM8T0Pey2M2oXbbXDtVclA+FtMnkESqCM8FiJ93q2UdEGDNyoHyS0P7hBZsrPzeeg6Rw+TcHecMFl6r8+dpkSKlF5FdFx3nF8C0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6206

On Wednesday, January 31, 2024 5:39 PM, Jiri Pirko wrote:
<...>
> It looks incorrect to hardcode it like this. There is a reason this is
> abstracted out in lib/dim/net_dim.c to avoid exactly this. Can't you
> perhaps introduce your modified profile there and keep using
> net_dim_get_[tr]x_moderation() helpers?
>=20

We don't know if this introduced profile is adaptable to other NICs/vendors=
,
it's generated based on NFP's performance. Do you really think it's
appropriate to move it to the net_dim.c as a new common profile like:
enum dim_cq_period_mode {
        DIM_CQ_PERIOD_MODE_START_FROM_EQE =3D 0x0,
        DIM_CQ_PERIOD_MODE_START_FROM_CQE =3D 0x1,
+       DIM_CQ_PERIOD_MODE_SPECIFIC_0 =3D 0x2,
        DIM_CQ_PERIOD_NUM_MODES
 };



