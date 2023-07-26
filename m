Return-Path: <netdev+bounces-21125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1B762874
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60C01C21022
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 02:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7949E1118;
	Wed, 26 Jul 2023 02:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E3F7C
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 02:00:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DFA188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 19:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kASGs31Pe68xm2ES6dyGOK1ZqgZvCuVfVch+J5SV6q0qnYsT2bl5XNP1JnA0iw/o/nyVB1kgMbtpCsVInZQ9vFtUQ4LBtrViKFw1kcoQs4GBKBnRYNz9VQpSyoW7OGu6mpID9xAww/yHhygsqQdvyCTwC+cgH2NIP3J3My1uaT7vdTQQZBLyY7SB5rzNoSGbvndYnchlUrvHtHJZEPC488wtF/0RJOPYczXUdRp2fy2CEi02P9IDjW+uGmgH0pfftpi36zTMd9dmNQWUHQhNiVxQyW+UoUnKl8QFAtIdJmkC08qOwRzobifbSjltCq7Tnl5ERm0KhmUSjlh2TXi3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfb6Gou7gHlN6EZTkfmSpqIdXxPaH7a6SEFAHc3AizQ=;
 b=Tk5MZAcqUHe6/KDlSCIuApqqAKc6oEWicCHksOk0TjW6qSsdmV8Lc9eEa/O4ErOoHPty3oYGBlIPi8HsarwB2GW14EQhGjA/j1G3m8j59cOA1fbeMefGVAXEU2qHrCes0ETGhh+iongBZn6QFI0GmR8noT7Fw8V5I+1b6LGgM9jsG6ILA4g/eDLVyBi4GELoPSJ/A8hsU6rQGbCksWpVwoP6vqgq6g+9ZraXENu+VOFqxANIcVJGdpfPdnAuVOEdX5wzHrOjp/NvlzDdUnoO9ejCE+cZBljIUT365OaBTvZrRF6kl7wG1nrgA0wfCZ+xgJayELB2ggTXhFTUM1g2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfb6Gou7gHlN6EZTkfmSpqIdXxPaH7a6SEFAHc3AizQ=;
 b=VSV6e0ZqGLxB0WT5Rh2wAtpGjkGhAWJXaSjQ4iOdOkStmPnx0wQ8scZzpSbvFF4DBgcfe0N/8/VVYDDp57u1Nsq4KsT6ut4oBsEn4s5aLoW/7VRIGRwU2oLURS+hGqxL8rjaYhfblHfdQYehFSzW8bjLliTYs2MF9+g6JG/WxXM=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by PH7PR13MB5867.namprd13.prod.outlook.com (2603:10b6:510:159::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 02:00:30 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 02:00:30 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Louis Peens <louis.peens@corigine.com>, David Miller
	<davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<simon.horman@corigine.com>, Tianyu Yuan <tianyu.yuan@nephogine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
	<oss-drivers@corigine.com>
Subject: RE: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Thread-Topic: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Thread-Index: AQHZvhQOyhJJYaAxoECPRxnGLmndE6/JmggAgAAYBlCAASYVgIAAdJcQ
Date: Wed, 26 Jul 2023 02:00:30 +0000
Message-ID:
 <DM6PR13MB3705D2C63AC215F1BEC51BB7FC00A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
	<20230724170100.14c6493a@kernel.org>
	<DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
 <20230725115933.29171e72@kernel.org>
In-Reply-To: <20230725115933.29171e72@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|PH7PR13MB5867:EE_
x-ms-office365-filtering-correlation-id: 396c2d2a-de5a-4b3f-9184-08db8d7c16ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8oDphbz6TSmSe9qz5+26z91YOU5y6BvsO5E+bL37K+xeWgtCZNDRl3VK9kjrdk78cBTwIjkuN5gKRjfECwRwSlm0GhazctI9F7/IRHtPUCg0tEU1tnyaOyZh3iTDORPj8dky0iHtIarxmW0jKadmsqtnueydy+8x3Ur+20NMs+oBPEbbDNsM4Lj/q55KSOpaRJxxD9TzfseSxXVnJxMAWK8YlpvSaFCuNSp5aCZFnGELHC4UmKqPdRXkhfAwfFoyqwr/Fc+Nz7tTPG6fbMLmPT/5rEP/09sCUs+M0raepnjbv1n7klf0cDG7WaplKiC+sKg2Gx73+YK/kbRHzBoROE+SnfEPwiDsBsJ4FzNjrE9fydeenwHIqwsSvCw3CsDxSV4Iq5aRC4L6jzamykmsrg0DNTxB7MiJ4nRXCySdy8hFtALTCASb0XrzkUG/WQaUDaSQ2+/wkPI9ZkLRbmO1HzihJ9CjMyHWZ854Ccp+Oyz9mbNShpW8TT0HfPo/wvxSBt0ZIuW8+S8oqUS+/3jF0kKRth6W0lZzhnW/HtnW+WkBTEd/vHluE4HwQ3IyKAwo86M8BnIpo8R4K9XVto2gLeXrN9r3VtMevEVs8+vE0nPqNLCWCML/pit6I6qlRwT4qSUraJhV1JUBTr8tGoMf1f/IiauBoCHJXqnPv4sCQXg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(451199021)(7696005)(478600001)(71200400001)(9686003)(54906003)(6506007)(38070700005)(86362001)(55016003)(33656002)(2906002)(44832011)(53546011)(26005)(186003)(107886003)(66556008)(38100700002)(66446008)(66476007)(122000001)(52536014)(8936002)(5660300002)(66946007)(41300700001)(64756008)(8676002)(4326008)(76116006)(6916009)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QgLoLkzGtrs5lDW9+KmZAg9NTbEIbPxl0HsDMQRXr0wKOoWTH+hYuzWgzPT8?=
 =?us-ascii?Q?wQjGTEaCsbMCaXnAYwZpg1PazdPs//WKI/hxeyH9EXobUJagNMPGMr8F0M2j?=
 =?us-ascii?Q?KuI/o/FWSg7bt1K/TEFwpi7KCAR5pOn5qcp111jvyiCuDlQFQXx6xDDfP/4x?=
 =?us-ascii?Q?RUvvvKrVQnIdCiaoj0Exu4a7Wg7X+cPpENCaHnABwT9JGF6/tOBdxRDS2dA5?=
 =?us-ascii?Q?zIZV4irFVHYvjnfhpK+N1QJxJPUHaI4v8wPmBmRSjmVfNLCfRmq17uPuB9iZ?=
 =?us-ascii?Q?lj0bJU8n58E9G3LmqBMDcPvcUCsvDAMZDDFWoUdXGmPeCI0DfqeyLLjMaSAX?=
 =?us-ascii?Q?25LrBcOCrZ8m1fwCEXdMTweRfgx7mVeHQedx/6lcDxKfR3VMSEjBCyuurK7O?=
 =?us-ascii?Q?VrhzvQrpjx/q9s8+Y3/01KYBKDVfY6EuNPIqltSBRKZkfc6Q3+26SYfLy2Fr?=
 =?us-ascii?Q?NG8/JAuaPWHPiLZQ0ZXBMaTka/uCs4VnP+Kpy9CGyha7Q0cTiV/jUkUZSm3S?=
 =?us-ascii?Q?B9s3yULheMJlsQv8xAsDqjg+uZxt0brz817wnY+Q42yedFkQltZZcbOMoZwP?=
 =?us-ascii?Q?dLTmsog4yL6y91U7RRSiYf3HIEGHFrUdspu2Zg91J455L7wLudDhM1UiG+nO?=
 =?us-ascii?Q?JUwdp2TkjDOPBAaL1ksAjWVfIIXmGgBg8cZJ/vteWEiq2nu0UeN2lp7EHLje?=
 =?us-ascii?Q?nU/vedUMF9Sicy3Cc88bycEhGOAC5ft3Vu4QinEa9D5nEJqXH/C6L+7Ptb0O?=
 =?us-ascii?Q?/I+8seUTIWVxo2KaHTgrYU5jK/HAmxGijlyoIL145+gT/eqR+UXZuzIvq4mk?=
 =?us-ascii?Q?OpgqJTa0CE9cVFyNtaQSAe/jG91RTRNX7b3LSUMnF27tET4B3azhkMgCNX0O?=
 =?us-ascii?Q?/7od6K8l63WPhXLopByAKHeaf4NrXDzp4UjBiS60PJ4zsvyTfI7uxj7pNOBg?=
 =?us-ascii?Q?ddBjYKvZq6Vb1ajDyeuDgFCiPHdVDM4i72T19GSLshpY2Id6gdhs9PHR1EZt?=
 =?us-ascii?Q?QvVorlJMSgSceeqRDRRTH1oC/bVy7qDD5xNqse+OBCPXCHCuVpnmdgdnuy0k?=
 =?us-ascii?Q?mXabC/f7ykhCgGHAHr6Xl2VnLTO78MvlJwn8yFeMpRoaOWr4MBpNROlVIQZj?=
 =?us-ascii?Q?xWx2MJfdJGkFZ/G+hrE0uJcAcLb12IQphIuatSQbf6gonUXEryCaZaAFYxoC?=
 =?us-ascii?Q?toZ5jk+upfUBbMbHYach1/ifekcVtIl0usg2JUM/VjfUpO3oIzf1yihoR8vL?=
 =?us-ascii?Q?eA5ZiCAvgx2sFcl/cXQ8ycMmQPJYCUjJC9WzaQJPoD49ffOW+Qw9qYDbw2Zp?=
 =?us-ascii?Q?VMvzfPzIOJRgihpuHyAcPwatsdK7trSzd70clNvLbF0d4UOfrbnSEdLkj/de?=
 =?us-ascii?Q?J7wm6dzPGKHWJIzmJQJIsvEXvLROdySYzCW41LgyoPs5pWW9ENrti1Cv6zjb?=
 =?us-ascii?Q?U+pD5zNreyP4kW6ji1AH86W8LECYRL0IRmDT1WtWl3B6ouqFTpiPThH5r+pd?=
 =?us-ascii?Q?rNmnDoSNUl9WS4rxG6s2F184od2Ot63Eb9QezhXVZ5c5jO4d65v5EYxooVAQ?=
 =?us-ascii?Q?TwMVpWM/27mVPCX/h4U213QXGDMl6Aq0nUkNszjj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 396c2d2a-de5a-4b3f-9184-08db8d7c16ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 02:00:30.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkmBPSxBFzd5G5sXz2iUHLV+6DBj5qDIsEEL7JHEoKEtsDLali8OoGuLbMh3CSJdN+jjYiNywkwVlG863fN3k7/0CoW4mhoHOd4cwkHtMiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5867
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 26, 2023 3:00 AM, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 01:28:34 +0000 Yinjun Zhang wrote:
> > On Tuesday, July 25, 2023 8:01 AM, Jakub Kicinski wrote:
> > > On Mon, 24 Jul 2023 11:48:09 +0200 Louis Peens wrote:
> > > > This patch series is introducing multiple PFs for multiple ports NI=
C
> > > > assembled with NFP3800 chip. This is done since the NFP3800 can
> > > > support up to 4 PFs, and is more in-line with the modern expectatio=
n
> > > > that each port/netdev is associated with a unique PF.
> > > >
> > > > For compatibility concern with NFP4000/6000 cards, and older
> management
> > > > firmware on NFP3800, multiple ports sharing single PF is still supp=
orted
> > > > with this change. Whether it's multi-PF setup or single-PF setup is
> > > > determined by management firmware, and driver will notify the
> > > > application firmware of the setup so that both are well handled.
> > >
> > > So every PF will have its own devlink instance?
> > > Can you show devlink dev info output?
> >
> > Yes, here it is:
>=20
> >   serial_number UKAAMDA2000-100122190023
>=20
> >   serial_number UKAAMDA2000-100122190023
>=20
> Since it's clearly a single ASIC shouldn't it have a single devlink
> instance?

But there're more than one PCI device now. Isn't it universal implementatio=
n
to register a devlink for each PCI device?

