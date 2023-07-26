Return-Path: <netdev+bounces-21211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B9762D74
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 09:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886AE1C21103
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 07:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03C8BF1;
	Wed, 26 Jul 2023 07:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1688801
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 07:28:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2108.outbound.protection.outlook.com [40.107.94.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFAB19AF
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 00:28:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDrH91KS8rB1Pkyo9u2mkhzsBNI0wskzgduXJdV2CKnaYxy956tVFpcNA9oC1S4HFolexPhsU4LxecwTVT8ecEU1kykZcYjXse27xUoNmhPDkl+cUte3n1cw+7R5QfP7QsPIfusW+FWThrLinrWUymUXYiI4fYM4/KKwBG8cguOL1IlvioTyC1wd2zwTJllT1zi1yKGERJfE2lw4vgrNX+1GBvsXPtEaCc/Y7RCn0/rWkZyCfkgaxB8nCPQU5A1YUr+CPy5J58gTE7k8UJiLSiGTnAxranxxpAqHUNxqGnk097NDt5544W9U/j8zc5Qc/dJw/Jk4OuFybqcrTmmOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrWGB+YMw0RFUwdZ0+U7k6TlYvbN+hRRtsiriVCytbw=;
 b=FNIEn46Ai/OGWit/6iZTrfTyb9TJP8foieJf5QZDsPRwD/CUVRzpAgS1pG3ZpCx9BfMmiFdynxz9EcF+wX3dC+qJqKGiiX3JdS4K4F6NzFx/+7dlHN7zvyBrmGqPzUCjYLef4ZQ0Yz33p++U5y2HG+Slt+CxVttbguIIC+LSjpQtzz+qT6bx7Q96XTx9Ww36FiH1nBGvWvGVRonVa48BEOgamCSFN4/12RRI+td4IrPCCYmhYI/dncOZqECdBk5g7uaY5t5KPjOgzSuRFnmTO5PYFt0FHmsy+Ur7D/tHuHbPVhxWZvW+V5Wd/3i0Qo4eMtCkxvdrRx1DtlR0Z+5Cxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrWGB+YMw0RFUwdZ0+U7k6TlYvbN+hRRtsiriVCytbw=;
 b=cpfX0ieAWR/JI2ZPeCU4yZyYm5B09AyaZrSlnpRJnf+mtwWVJvgsoIYyI+Jy9wXRA71r7xSCblB23VYvFs6gWDC9KLE5/MLuejtsKIuNzgud45NkmTLcpgMBOZegBXMiURq1wYe83agjUAuRFN38WjF6IH2kbU9DtebevmMMda8=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by BY3PR13MB4993.namprd13.prod.outlook.com (2603:10b6:a03:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 07:28:30 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 07:28:30 +0000
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
Thread-Index:
 AQHZvhQOyhJJYaAxoECPRxnGLmndE6/JmggAgAAYBlCAASYVgIAAdJcQgAAnOYCAADTPAA==
Date: Wed, 26 Jul 2023 07:28:29 +0000
Message-ID:
 <DM6PR13MB370538F8C8B3E542F95CE9A9FC00A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
	<20230724170100.14c6493a@kernel.org>
	<DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
	<20230725115933.29171e72@kernel.org>
	<DM6PR13MB3705D2C63AC215F1BEC51BB7FC00A@DM6PR13MB3705.namprd13.prod.outlook.com>
 <20230725211713.0b603f13@kernel.org>
In-Reply-To: <20230725211713.0b603f13@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|BY3PR13MB4993:EE_
x-ms-office365-filtering-correlation-id: 1f2787e8-6cc5-45a1-338a-08db8da9e8c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iUl7JStMX0jSvWOWPgoz2r6OBd6U1xFW+hwaYc60hj3aZmYO2IzlNK63JKMOUk96g0IUX469PeaGhR5w6uTAlY9Y2F8YrJzLb8aNXw+dnJ9finlvckqQU5gpC0PhyUYWrMKzaVjQ8LflvdMW/1+Dy5Yxko9WZ6tUfWIBz3m6sVdAnhIfhQg7KnOaNB6lUbJAJT8UV/UqBBgskgyHDfJmYhX6iRvF75RPAYk4s1mnFpxV9EQDXiOQuJFMT1Q3v3CdKVTlv0u7KB4MYkTR9kjtmr35rdCnr0Py68Cod68fs6lMa7XP+qI5KkDz+zz/uqnKfaME/OF62WnXnOTDN9anS54/M1ozAZWMNEvF1jFPwOREOf52fGWJlwNUWvbGGKKV9B3OiGgNXj7WGKTN3dgjBDRihqqR72XIsshrWQjpXb4Itc+/5LFDabPHgIaW1PIYiYEmmn3XUpUuhTqc4KSlAUTuB9i+93hgzETXp8kXbPn3gyXfy9nrv06l8FdjgJmxkBQ0gjEzujYiGic897DIP7L5RKY9vGkQIrDXOyOQZnz4CLJzGVepAEstJUyPbZgpIzno0PA0alEybkbJbjnBU7takVjgwez+drQFryyskB+L7MZXhY6Wmc3b4zlnUC569exjwjJIFDwxXm+jJyirefymIZa0ZOrAGNKo0V29q3c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(451199021)(7696005)(38070700005)(6916009)(76116006)(71200400001)(66946007)(9686003)(66476007)(66446008)(66556008)(64756008)(44832011)(4326008)(54906003)(4744005)(55016003)(38100700002)(122000001)(478600001)(2906002)(41300700001)(5660300002)(8676002)(8936002)(52536014)(107886003)(53546011)(6506007)(33656002)(316002)(186003)(26005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rIT/QxUfKo6IAotm5B3joEuZstN67STZRclY5FzjiqEER+qOKwGbLIs2P3dl?=
 =?us-ascii?Q?Kf/ALAc7ALiOuMB+3ASNZyGJ97pEHbY5rYSyFNWf1HgH0frf0bZxBMdUTlqv?=
 =?us-ascii?Q?DCgmE0LUrHZkU123jlqg0b8U4PCnX1qM0Jka52zIEgd74NkFNyIDNEICRtid?=
 =?us-ascii?Q?QtagyYrf9KTZI3bzcW7OpnxwRjqxfo2w54kN/G4qKZ/RumtEvvqHKUmyMvwv?=
 =?us-ascii?Q?xXXfXR40NwtIT6hCctzzUoOTk/UsnRoOdWhBrnEFnRmdkSMjVqZrpx4Xb5Dj?=
 =?us-ascii?Q?AnNYHAqzbVSO+GAM5UQbMJZp3X6rGLE3y/HO8GQp+6vmKy3EJMIpUvbVHRMY?=
 =?us-ascii?Q?Iho8JeHzXv8vF+OZmN+Bp3DnQJVhdLWmjZnmrrdCmLbsZcutsqqLdVKGA5Wa?=
 =?us-ascii?Q?2I5iMw+2hvdf5/xAVJz7nvNJ+K8R5ecvJiLwDvvubjkXf/ZIfITxldxc1Mwv?=
 =?us-ascii?Q?kEI8Twn26BvNnyufvuSVunimN2HPA0Q3C/R4K5avDdXERXHSRXhNulIDWBaQ?=
 =?us-ascii?Q?t3OuEzMvOm2jpUCpbkuCr7IR1W+Q2Yd+PPLnir6hHkRBhBuEgiNaxQLeFjHA?=
 =?us-ascii?Q?mG54iW+JDVlPO94If2WKawhd1uYkQ1+L+kbfX0WvWaB4rs9gT0oyQhJXgq8a?=
 =?us-ascii?Q?FTFlBEvdOETTdmH/qV9rOyn4yaop/NrQH4agT2gXb4UdG3da98e1D+OB4trX?=
 =?us-ascii?Q?cEsJtKGZNdHuYQKt9if6KjVsAO6FuyZp1iAl3A9uxv9X0T5VsTxLd002/HAZ?=
 =?us-ascii?Q?qPrtJ0ZULkDc1N25OEdhV5LvOzPrgPn4+7BnKpAWF1tonsRvfJWfNgII2pt8?=
 =?us-ascii?Q?gDp0t8uSM/04udBUeICOjO8XGNjWvL/G7lVxqiDEOx0zfLV/Dw2P4sVD7Et+?=
 =?us-ascii?Q?zWkBI7jYXXQp1x4q/SvEmvsxT+wS5EHCFsa8uZGLVaua0IX9zha80PBEZFEI?=
 =?us-ascii?Q?DrcgY0eeA11xgm8khHMTzkP9+fp7/gwqgx+jdAMqDLOSI6u4w5yEHg/YRtzq?=
 =?us-ascii?Q?yn3hHIidAUYZcEfIRwqMk/qw7DLqa5twP8sUPiCYdRteOZGkfzufKIhz+SVk?=
 =?us-ascii?Q?q+jwSY9m4kE8GhTor+tKrcSayQxShMDMH4YplnGJsdiR7mOyiH24eW7FNMd3?=
 =?us-ascii?Q?l9Ah9PpfHhejp1c6mRvseAz6qi3RyPpl6o2SPdoCla7x7VOt1M7U2LJRga/d?=
 =?us-ascii?Q?aspPAxXXRA65muy9FMxoc6jSWgvkm/E8ZvH3RDU+kaS7MAaPEQy3SAd1or4C?=
 =?us-ascii?Q?lWeJc08HwlyGgflK3K0kWshQBdQMgUqh2NGu5ZbE8D8uOmgzSFsj9A0nnxlB?=
 =?us-ascii?Q?2VP8gBh+YwQLdsJhkFNRyT4p/arDMbA3WwmgMzC6V/KfgfB7Oq4w7i2XHCCT?=
 =?us-ascii?Q?t+GTPUt2KZtiinW8tYo4H2PvDwVFpi5nPwWWCN7Aj0Y59MEayZCX9HfCHTJ0?=
 =?us-ascii?Q?z+rJ66s8w7zGpoWWL07VfCsD/KHU6BXQodemOFFTluDPqS/pf7+1oMszB+bG?=
 =?us-ascii?Q?bj+JH8oy94f3iHHr1A0lT7Ma33aRa0AUP0w6lwFywSczSDqJalQ4iTOHApoq?=
 =?us-ascii?Q?cqW7E72moU8HsQ37RUyqb03zHrdqndFIgUaXHHnR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2787e8-6cc5-45a1-338a-08db8da9e8c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 07:28:29.6666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4AeTMhZOvzxNDl77Juk6yiTVXdILL+LMoxiiiGX4vhSVzsVu9nFhKEq/SaLdWNTzFB1t+fKnTgZXryuTuPMfCgVf4afJn/t7I9p26toVxIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4993
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wednesday, July 26, 2023 12:17 PM, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 02:00:30 +0000 Yinjun Zhang wrote:
> > > >   serial_number UKAAMDA2000-100122190023
> > >
> > > >   serial_number UKAAMDA2000-100122190023
> > >
> > > Since it's clearly a single ASIC shouldn't it have a single devlink
> > > instance?
> >
> > But there're more than one PCI device now. Isn't it universal
> implementation
> > to register a devlink for each PCI device?
>=20
> It's only the prevailing implementation because people are too lazy to
> implement things correctly, if you ask me. devlink doesn't have the
> ability to bind to multiple bus devices, that would need to be
> addressed.

It sounds like a separate topic to refine devlink infrastructure.

