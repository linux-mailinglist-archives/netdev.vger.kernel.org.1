Return-Path: <netdev+bounces-16191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EAD74BB81
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4021F1C2101F
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2721363;
	Sat,  8 Jul 2023 03:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECA17E2
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 03:00:58 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B505F1BC9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 20:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688785257; x=1720321257;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rf0NNV21zrFGRMWYMlOgep5k/bzBBhzhiOJmrMsp6ko=;
  b=DvU+1uEBVqrzoFcQ1IoncEyc8grX6qR7esdtKyBmMax9F5fgiSL0mw8T
   vzW0ULa8GbPh3dsMTIuwR+x79R27BTXSn0s30Os9w2Uh3959LZpu95Fi5
   1VTx1J190/mV5VPITjTizo+NUBQw6h8HE0+qEjsat3vDH8XXuxY/jID0F
   odPuDYbF9ud51VRfZI7b5l9Nb3Hpv+bxa4qpRn7AxNpA0JiZHhwFTgdBX
   YzcdfBPt/s+I11L3OhqaEA9NnxX2IqmcrPJwh9a5My7CxfjrRgPmhxbdK
   2e2vmd2kaJfRvlznMOKbmZMMJG2Ak3tRsOZ3jxjV29qAIeihQm+OSY6tn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="394795520"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="394795520"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 20:00:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="864746737"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="864746737"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2023 20:00:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:00:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 20:00:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 20:00:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR+LQv2PQBwvZU3b8LprOb1vBO8T6zYfaDuysGghs5+cUjKTGy3rLTKE1Cr0nVXx9Pau76PVqx0V0dKhjI28L4/p+f1TDDhPoA5wL8hrAbpBFISICFIAHG1lC+0BJUtjMEP3H6P6OubTalj0+xt/n7OFnwmRYyXW/tQbXIthPm7lZ/5l4WEb6J3NbpFuNFH91lBfsVrUnORRIFwi5UxylVVUTI3u/zBJMpUSnWrRGqT0rfgvbcydgu5n84pSRswyxPDE1/dYm6GNDQnIMvIA5EIP9uz+eok5vH1Q+gDW0Y5bHtD4rl5L/Cg3juQ0/2JXPvIJ1jroanPOnhEazl5e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQgVhqSvcd6uX07M8zNXjIF3nR2bBNraqyKe/bHu1tw=;
 b=MimM9gbqX48hs+Y1tEq6hwwHKd22ydK+I8S4Ic5iOa01MDPusICalvSRmZlzgCG7X1/o7EhTA9EUtoyyYoWNdiF+DPAxATrRnuvznV3CUDbbBOokRWd+p6JWDVGZBN1yba4Xu8A6jvKSKeBEp7hlCFuNTI71YU/m+gl5kXRiMa0svOb8+bBy9HWr+o13w3GJyI7i9F0sk+6AguFRNLMXqDgdbSSVXGDVSOqBdgHAG1G9+xqe85T6JjUgs1gFuHQQ6EGKfOoDAKpObJMUyQui/AVIsXrTACcEhozla7Zff9KXGxFDxC5L4sEiiGySaaGwUPUSnLUSwXROCzr/xbFQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Sat, 8 Jul
 2023 03:00:49 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 03:00:47 +0000
From: "Guo, Junfeng" <junfeng.guo@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jeroendb@google.com"
	<jeroendb@google.com>, "pkaligineedi@google.com" <pkaligineedi@google.com>,
	"shailend@google.com" <shailend@google.com>, "Wang, Haiyue"
	<haiyue.wang@intel.com>, "awogbemila@google.com" <awogbemila@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "yangchun@google.com" <yangchun@google.com>,
	"edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH net-next] gve: enhance driver name usage
Thread-Topic: [PATCH net-next] gve: enhance driver name usage
Thread-Index: AQHZsHz0MQw/GZ55A0+ZSeMxEeNzpq+u8joAgAA8/5A=
Date: Sat, 8 Jul 2023 03:00:47 +0000
Message-ID: <DM6PR11MB3723EEFA8528C8408FEBBDBDE732A@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20230707024405.3653316-1-junfeng.guo@intel.com>
 <20230707162022.2df4359e@kernel.org>
In-Reply-To: <20230707162022.2df4359e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3723:EE_|IA0PR11MB8301:EE_
x-ms-office365-filtering-correlation-id: 6286a49b-4687-46b9-9d2d-08db7f5f876b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQAp/wEgGjMOX2B90zAqwZraPdjRehE4sX8NeK9GjwJfx7O/RA7tvTu0MBwbJwIRBw7FxQ0PWk4I9d6p2ssj/hIf4P84c32uDWSCzLxdw/e8yAkaKq/IkBcGDbZ1ADMN27F2RKg1bLh7JWmLvEIVEKbpewtV5c/A0PVEau0XyygjPi54xaMVskA0GbOKOFXtIf3jIZCNzIeUr89q8qBpWQ3UsXkU5aGqbuZiDeVx+tB/pNl7L4ghulUMw5ustqRyLtCEWkkrCjAygib6fxSgvIi8FzSGVV4FYZivZ9ToD/iI6DzfEpYCmQTFlpgLoBrzSaNTTQdRndDFO5n6QzBFbuqWcZ+mzGOmissQq+m3DFuKpvWNmQXf3xpYsMVxhq0vg7prAjynbTNBv8iZzlNAyXCmOd7g97PHlwr/dFhAl3CM9Ah6VvGy4PsBV2+OK8QHKo+9VaIAVsKbqDeyTRmBp03T6dBZahdPJ0yQPwdmDdmUpFHVD14qEnaz7cLSwCRCAWL9MXKHFysgnoA+UB3EYzcHpzqnuPWrlthSiIe/QUFdLaA7iLPiV8+V4TvzPQom6XE5YPLUEypK1A+B04jfUd7LR2+Z59iuyE9WX1XErtU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199021)(82960400001)(86362001)(53546011)(71200400001)(7416002)(8936002)(54906003)(8676002)(52536014)(5660300002)(66446008)(6506007)(6916009)(478600001)(76116006)(966005)(66476007)(9686003)(26005)(33656002)(7696005)(64756008)(66946007)(41300700001)(4326008)(316002)(66556008)(186003)(4744005)(2906002)(38070700005)(83380400001)(55016003)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GAWf1SdLSY1nUKwKAA50JHGfpMMJN/z0W3YZ23hJa36OO13TobdPX76Pu0q2?=
 =?us-ascii?Q?B8KujmPW8UPIH0ejYK3QL9EZ8xA/a4G3BgNYenZVReWqTjxFJo3remGMyN3M?=
 =?us-ascii?Q?YsYdifMO/Xj+opxJZTZVz/isByhwQK4/Qru2lvtSDjDyqP1lPUrvUZjnpQLd?=
 =?us-ascii?Q?EypiYsbzR1HGDWMXwg02LfeoVsSrp6NoRuaPsd8ca1Uo8qkt2d2CYxPEeTsO?=
 =?us-ascii?Q?qRsoC05XqDl/WL/XhNJAuPfSMVl8MprAaNFpHD0+9Cyygc63KTyH5lF18N1o?=
 =?us-ascii?Q?QWGj6rhNJoXm3B4yux3gOA6Uyuk866kzU4G2RG9IM/xir8tqIgnPCfbYZtdF?=
 =?us-ascii?Q?A93Kdkzw51mol6mTdGAsMeaczz0MlaA1hIZ+bdajWHdvQ0dxP3NA4upa7N+s?=
 =?us-ascii?Q?FQnTSd8k4JXODS5yDZw43kyify2YeoLgcmfHtRp7pmZJ0gNQCRq+o06GQP4P?=
 =?us-ascii?Q?7wnVJJJS7RoK5pNG+xNBLyzOsANXoe4IU8gO0lUKsyeLQrZco7bf8o4/jpO/?=
 =?us-ascii?Q?u0YG5Z+qCBbMsqVUkS/xuSLT+qvKB0mnC+WkkvVOEkfx85f5LSSA5DA0guWZ?=
 =?us-ascii?Q?wXDZ6swp4XzL5HgR1GA7/zoklslbIxaRCfwScFyxfcWgEa+6TmPZUwptsXRV?=
 =?us-ascii?Q?wO2nYyIg/y1ZysmDm2Q2tWf/y0PQXKw32JjkMcSI5a7hOJrzvY2sgYUveX7p?=
 =?us-ascii?Q?9tEpY5y04XbI8fNcwHCEyfVZY3rdiWGXtwdxjZ4Y5E7wYbiAjsyXs+ruE0nm?=
 =?us-ascii?Q?GRFFs8UtsAqnLcuXGM41D1daqzrQLIhtiBZ+xvbQX090NmsFc0xt0t9k32ww?=
 =?us-ascii?Q?DKdd1HU9TOyAsl7huOgOyhSLSkwHcHuUUW/ERpRj74hMrSCYd2YQn8R1VNUa?=
 =?us-ascii?Q?dphJ1lwhlMsJmJp2zru3Eu8VW6Y7BW9wunV49hpFZ8Zuz5PYe17kp+dHK2lR?=
 =?us-ascii?Q?Idw8/4mKG52d43rBer2AN4O56ADbYGAjxEUkuaGO/wv2lcaySGMO27uGMO+M?=
 =?us-ascii?Q?u5kJTiuc4sQowCrmIggRJ8fQDbX6SI34+s6RLToCrQYT2meuVTrIbxAsHOP6?=
 =?us-ascii?Q?OK0x2THdEwwFNuq6SJAvfO15TWX/kI9Q0ZK800clwisuqR+ck4286kgwq2oq?=
 =?us-ascii?Q?wZxpKWMt6TRSSq/QGoIzf1arpS+Rnc7AuRDATlX6DBkEZDFooZEM0z92WOGS?=
 =?us-ascii?Q?SAggc1gk38lS9ThMM+r7rZWA0HRJMpf91FaEKWg+6Zgn8VrV1lnzySRUpS9d?=
 =?us-ascii?Q?BGFbKIrEKtB7I9MbXDrmstw9TRJ8JZ8e//4Kcxuqq62JcVHC+tPMxsnnfRN0?=
 =?us-ascii?Q?z9tRdmWFbn5CfHRHwzB8odQLnaDRZkUT8MPusTQYJwSWLu8hDUqU1D4Ttzum?=
 =?us-ascii?Q?lKidpnlW4vBs6rGlaMsSTp4Hprz+poLWKFav6dm+IYt1hRQe4EbnEJA7XL/G?=
 =?us-ascii?Q?/Nnwyaf5pkA9H3mAl1rM3VWneLxJ/5yY8ucYJrubZaqn9k60H5fxEmvXTPGG?=
 =?us-ascii?Q?aKcc6+r6VEZOD35Gb/lomXZjb6Ao/IkGYNAJ3QhDxkMC42OKp5LAltazElVy?=
 =?us-ascii?Q?US8HBYcRPd3dQctdGNxEnlq+JkGFeM7yUCMQOony?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6286a49b-4687-46b9-9d2d-08db7f5f876b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 03:00:47.3211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qj2AufHopKg6571XJP3u2Ylzfl/UNyq7Th0rmBkKeh+LQrSVBaIKLZq3a/xPENRjtgnCkidyZjcGYmGHXK4vjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, July 8, 2023 07:20
> To: Guo, Junfeng <junfeng.guo@intel.com>
> Cc: netdev@vger.kernel.org; jeroendb@google.com;
> pkaligineedi@google.com; shailend@google.com; Wang, Haiyue
> <haiyue.wang@intel.com>; awogbemila@google.com;
> davem@davemloft.net; pabeni@redhat.com; yangchun@google.com;
> edumazet@google.com
> Subject: Re: [PATCH net-next] gve: enhance driver name usage
>=20
> On Fri,  7 Jul 2023 10:44:05 +0800 Junfeng Guo wrote:
> > Current codebase contained the usage of two different names for this
> > driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> > to use, especially when trying to bind or unbind the driver manually.
> > The corresponding kernel module is registered with the name of `gve`.
> > It's more reasonable to align the name of the driver with the module.
>=20
> Please read the guidelines before posting patches:
>=20
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Thanks for the advice! It's very helpful!

Regards

