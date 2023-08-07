Return-Path: <netdev+bounces-24745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9508077182D
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 04:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50178280FFD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 02:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674AB392;
	Mon,  7 Aug 2023 02:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5480265C
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 02:10:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37AE1703
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 19:10:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEZaL4gaF+ZkAk21A33HsM8b8qLQ0EB/MOO9stANN5S5SOz3f3aykHGMFki1brM7GglQq7CUAuXD3xM7DVjYhaWBH97GEQPckJnP7PeWBqwOuU/t+3X4R/Rs7F5uxHx3W+gfDTpRgHLQbCqHTul573Sc8Yjfdmj2OS4H99M4CCLCkFJWtbHi4olqWDe+98by+lRR9pzY+kjMEx8HAFB3TYAD0ODuqOfRZH7yUkr28xro/kffaxHWBgj1RLf4xtFI7Osn3yz+9IwdTlUC8ZA9TU2Fhqfp5hpk/+DCPEebwO3aQC1k+BGoIbW1hWVCg3s6dVB9J7aJh7fB23BSI5nm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dyor89NvC7x/o/g951SbpQTArs3XSn9WZkWoWNrsLBw=;
 b=TQnTKeDBKRFvSVhYRKQkTg/RG3fjq6vOMHUyOqITIZTwp5BceGCSLV6nJAnKv8A5ItXn+0OaItdMSno8Jeg/r6qp40Zs6ksVCC9RUmzDo7oI44PKd9vPDpz75L6wKZ8v2/gk6yFRX2MKF3GoTLPTDRj1w3DbWlf5KpRUtPqbJlbHzesKV1OdzSjt8wJojnoslE/+4DKnfaYgwKtqnArfueboPxPHCccPRF0xoq6jxlismgwm6RcEI+7oYTs/siJ50lu/L7nQwoZ8Yg5mfJ2Fn7fT4/+XbZto/BxxgCkKrZ6tBI/5Sd3yaOIpZsEDI1uQzLS+VhDtMhH+Z8Hy+ONHNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dyor89NvC7x/o/g951SbpQTArs3XSn9WZkWoWNrsLBw=;
 b=K5tVN63eZ10Scee498bqJcKTIKPmBgNOHG/FEFlKbjsWLvBX95t0wj2/mZ/zYQOAKycYl8kJfDcS320zfZd75EgDADBrS/YnAZQDn9uDuahuALsvULSTHe8VvSBTGR1WlX8aD8loeZRB6D+BtVG/XfMseyAXEQwSOsOXeBNfDfE=
Received: from DM6PR13MB3705.namprd13.prod.outlook.com (2603:10b6:5:24c::16)
 by SJ0PR13MB5523.namprd13.prod.outlook.com (2603:10b6:a03:425::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 02:10:32 +0000
Received: from DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23]) by DM6PR13MB3705.namprd13.prod.outlook.com
 ([fe80::38ff:ef02:e756:bf23%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 02:10:32 +0000
From: Yinjun Zhang <yinjun.zhang@corigine.com>
To: "lkp@intel.com" <lkp@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, Louis Peens <louis.peens@corigine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, oss-drivers
	<oss-drivers@corigine.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Simon
 Horman <simon.horman@corigine.com>, Tianyu Yuan <tianyu.yuan@nephogine.com>
Subject: RE: [PATCH net-next 05/12] nfp: introduce keepalive mechanism for
 multi-PF setup
Thread-Topic: [PATCH net-next 05/12] nfp: introduce keepalive mechanism for
 multi-PF setup
Thread-Index: AQHZvhQYMXFUsQ7fhk+vZca4nvPCAa/RODWAgACOxgCADGS08A==
Date: Mon, 7 Aug 2023 02:10:31 +0000
Message-ID:
 <DM6PR13MB3705AE29E99E9E90E62ED398FC0CA@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <202307300422.oPy5E1hB-lkp@intel.com>
 <20230730045158.1443547-1-yinjun.zhang@corigine.com>
In-Reply-To: <20230730045158.1443547-1-yinjun.zhang@corigine.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR13MB3705:EE_|SJ0PR13MB5523:EE_
x-ms-office365-filtering-correlation-id: c345dcb8-ce51-4471-15b7-08db96eb7a7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j1H2OXvOA+q3lkpZDk2XT77yNOauf6Z2TgTCGDKP2+cHtQqwTKCbxZYpwDSe4UH9YBbeoqkhNlQtpPQeSW1Ql26mFy/WT5w8rU9QSaVW11XiNpKaM5rjL9DZjGc9keLFAo2e5eVLMsylMqdP+iV+39MCYa9rrfqyJGoyUPam9NI/D2uP8MfMN9Jp0q1I91GQDCs+lh7tP/6RAOUi/WRquojlRKi51qAKgUG4S1EXGLihfYbsP/UXfWJnhUEQWv8onBln9bRc4sVPPXkAr0IcsowAV0TgieZwnBe9tU2bBSDrDZ2kGYexqtnzZVQORZd5iAgCIwkMXjDP++RZBOAJ85Yv54EfD4NWJOT1d7R4/ZgJIPE79jmAssI78u2lnyz7z5I92qKsYKxIue2/+X6YCHPi+8NcUU82gnXsaq8xYcSWkpGezQrkW6URJmHQ5n0s1X9NNqz4VWha7oIAh/g7iLi8aKbF2eAuakeNEh9BJlzA43d0Sc5pTirwx9sVzyfSSvK3ZMgtV/rqkX5Qqo2GvZmUi3T9etupMSuDSuFqlhdttNC2LaT/FGfGrxkWLm63bjprSt8iqdH2UZk/vSDd7yMK4hZ7fHdUzo6fWyQQmZwFiFJUVNcfVe/SGHTq5Zde/RQuzp3bZ5iat1P46cy5dtyIjhN899ZRCr1DtneuIWY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3705.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(366004)(376002)(39830400003)(1800799003)(186006)(451199021)(122000001)(38100700002)(5660300002)(52536014)(12101799015)(2906002)(44832011)(33656002)(38070700005)(76116006)(4326008)(9686003)(107886003)(55016003)(86362001)(6916009)(66476007)(66946007)(64756008)(41300700001)(8676002)(66446008)(8936002)(66556008)(83380400001)(316002)(54906003)(26005)(6506007)(53546011)(966005)(71200400001)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BMg4GFI8ofDHY2OeNByZQYsAzSFc8LDr4iwQmcYCr4c4cRgnQ8RCJhhVys7E?=
 =?us-ascii?Q?sEA4JKxuXvNsUpD9ZznAir945uJzUqa+ds6SHF6V5i/Y2Wwfc+j/gLl1R5CB?=
 =?us-ascii?Q?rrukT34/cbbFXS7tr0M+YBM/sTGsGUDDBMlcACNAB5UnvB0qGJ9/mI/b+jn6?=
 =?us-ascii?Q?TpOIMy8n1AWYyMJ8C9KmbV2DeNjjsol5PmtdJDYFgrG/9IF6QjlfLxvKmU8b?=
 =?us-ascii?Q?fALqgXiJa5t48CtWvnCqYPY0sDeZAXfYI9MHzdJe/0Lz7Oz7LFdjAxWwCKpR?=
 =?us-ascii?Q?KNVsYvJYhTP7f3FsWMf539f9np0jZyptBdJolx3i/tIRB9Xz3XXc7gfD/wNF?=
 =?us-ascii?Q?MJ+uohSeohxocFxYO/CfmhcowDLyYhwXp0+Qam7v/m/HOZjYw4Q+l3jszWcf?=
 =?us-ascii?Q?YTD/2Lb1dWw2FVPaYcQusfRGw1MsAvjx/nSCzCTcZt7WHhROWy2wAWIT0njZ?=
 =?us-ascii?Q?1+9Ceecz8qv2SzH3/rFBC9bmOKf5P/4+/fKexBO2oCVrD84MjeR0SLljG6tZ?=
 =?us-ascii?Q?1NBiz3yvwfSFnxAokDNaZKFuWXt4ePeL3M/CmwuuoUgT8B3gk9/9Md/kPUU9?=
 =?us-ascii?Q?Usyjdno2GHBXm6VuL1oqvLjcOT7V2HnO0SB2gPPSjGHzcPVtzFVEyAYoVNoj?=
 =?us-ascii?Q?g4Hi6v4Jq/8Ljy60YWRBQQVpCRds7d18MeY8gY4onSbPzeqHIlkfxO3pbBsH?=
 =?us-ascii?Q?UXP/vJcDs/CkPrDpbVPKriiTbQPT1vzl1ZaouHo5V04qz1FDWzFeIjzo+un/?=
 =?us-ascii?Q?wym/vCs/GFzTTOZhWuBsPurw1GDVhesdO40JPdN7lOcvPqC6mR34Up4oEvpD?=
 =?us-ascii?Q?nfpUdB8JdOCUmOeUVdh1I++ZSYhhk4dmmNc7jrjZ9CG3v9Rtdp05P4TKVIo6?=
 =?us-ascii?Q?8FtwI0E55KyLdPOleUBdP5C5+JeAi81iweURtj3y1UCdrv4MyB9p06vtFQaB?=
 =?us-ascii?Q?ZyuFzrvwRHODwF66c4IfXRrClljyqqnwIQoOvkErLQhYahQvLNkOe69TSe2G?=
 =?us-ascii?Q?tlOv+MdnUimZhsvxQ/tfpyUi3wGf6MrO3DQf+mOfVa3kNSNDR20Z1Ie6f4h+?=
 =?us-ascii?Q?gql9/P7gnjVAcSwIXPwaNRCkv7E+va1R1IcmFCgWdUp4ZIUU/XP3By9Um3Lb?=
 =?us-ascii?Q?7zFkX/Z0OdI7LKjmkZ/7RjmekJBFXHKDJjkYpTh+jt/p/C49S/AeVizdAaoi?=
 =?us-ascii?Q?6sq8HQBXslbTb2nMNjC6s+iwldD/AS1e8j9nqfSiNi03fAiDgtSuA40TixwA?=
 =?us-ascii?Q?K8NNJvzcA7oJg/xGoJCV9j9oJpn3taITITi4Xlxu2hrHMbAHMGK8SfDtXusF?=
 =?us-ascii?Q?AkwzWFT0HG+Z6SmyRLL810quLMb7y9w+3KTimXd+V9wNNYh+Sa8i6Wp//JJ7?=
 =?us-ascii?Q?QkIwQGo91jLrjBnPtekS6sf44n6nx58R3oNosX1XfafWw+IUIcJKFDdm6sKQ?=
 =?us-ascii?Q?DWlGwK5jP6SXHMuda76wIjhRHypUXFi4cNsLm4X8PQ+DMSfvHS/ZHh+06PZC?=
 =?us-ascii?Q?/IhzMvPcR4OZTbrmvYwCT7g8jN7hNo1i7Xfsjk1zdH4B4GQ7fzb6MXdOVefN?=
 =?us-ascii?Q?ZyijcZfY/Pa7rT8P3tYPOzQar+WzMfsNwLr8VtZw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c345dcb8-ce51-4471-15b7-08db96eb7a7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2023 02:10:31.9360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTpVIx6p8pqV6bgflG3PX8dpmVKMf92LuMRagrj72wNXB+qt6bc9/qzPcdh0SkekdFsMEIQ7v0FHCvepTLC48czUmTSR1CJMg2mD90i/0dM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5523
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Sunday, July 30, 2023 12:52 PM, Yinjun Zhang wrote:
> On Sun, 30 Jul 2023 04:20:57 +0800, kernel test robot wrote:
> > Hi Louis,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on net-next/main]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Louis-Peens/nsp-
> generate-nsp-command-with-variable-nsp-major-version/20230724-180015
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/20230724094821.14295-6-
> louis.peens%40corigine.com
> > patch subject: [PATCH net-next 05/12] nfp: introduce keepalive mechanis=
m
> for multi-PF setup
> > config: openrisc-randconfig-r081-20230730 (https://download.01.org/0day=
-
> ci/archive/20230730/202307300422.oPy5E1hB-lkp@intel.com/config)
> > compiler: or1k-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-
> ci/archive/20230730/202307300422.oPy5E1hB-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202307300422.oPy5E1hB-
> lkp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >    drivers/net/ethernet/netronome/nfp/nfp_main.c: note: in included fil=
e
> (through drivers/net/ethernet/netronome/nfp/nfp_net.h):
> > >> include/linux/io-64-nonatomic-hi-lo.h:22:16: sparse: sparse: cast
> truncates bits from constant value (6e66702e62656174 becomes 62656174)
>=20
> I think it's more like a callee's problem instead of the caller's.
> `writeq` is supposed to be able to be fed with a constant. WDYT?

There's no response for one week. To compromise, I'm going to change
the caller in driver side. Let me know if anybody has some other comments.

>=20
> >
> > vim +22 include/linux/io-64-nonatomic-hi-lo.h
> >
> > 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi
> Mitake 2012-02-07  18
> > 3a044178cccfeb include/asm-generic/io-64-nonatomic-hi-lo.h Jason Baron
> 2014-07-04  19  static inline void hi_lo_writeq(__u64 val, volatile void
> __iomem *addr)
> > 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi
> Mitake 2012-02-07  20  {
> > 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi
> Mitake 2012-02-07  21  	writel(val >> 32, addr + 4);
> > 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi
> Mitake 2012-02-07 @22  	writel(val, addr);
> > 797a796a13df6b include/asm-generic/io-64-nonatomic-hi-lo.h Hitoshi
> Mitake 2012-02-07  23  }
> > 3a044178cccfeb include/asm-generic/io-64-nonatomic-hi-lo.h Jason Baron
> 2014-07-04  24
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki

