Return-Path: <netdev+bounces-12582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D35738371
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F2F2815CD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA0156E9;
	Wed, 21 Jun 2023 12:16:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23109134BF
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:16:21 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B40810F6
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687349778; x=1718885778;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=52ADzsOwsgT0OFDybgJI0HKN6gJBJKIq3BsOGqF1BSE=;
  b=ZezPl97e2jrwC4euNtw3c6yyO8GkI2oZZjHYZS1RjLiY07rXlQkKSUj8
   e0PxTzvp0u40HevGAqkiu57dmClrZMeD11bBnrlXTohpuNDsrr7QbzkJn
   SrRiqkh6y4ennyTlCo3PKLKrGYoXtlk6NqYrpFFto1JSnrrE+RpQyX4L3
   K6/b1VW9rpH/Bq0dpeXct3S4YPXzKbE3MNzSY8QjezOPaffqOVQiKJaUP
   ENpvlcZzWf0uPHxlOrbWcdVt47ev0KAev+VNM6pL4eFbRcTT767m2krhn
   YsokVQ0iHy/Ld6wvf87enG8PfgSqeTGVknMwFuJJQ7LDW31+NqNVchip5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446531145"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446531145"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 05:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="1044677474"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="1044677474"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jun 2023 05:16:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 05:16:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 21 Jun 2023 05:16:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 21 Jun 2023 05:16:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ZUkQICFTGmKfQJm1hn+5C8NrdaAsUMsQCACiNBGc6V7FgiJ96VmBQYW2f1S4q7jYCdyWDhZVLvaBDIrV3G0GaBh5L3/YUx0M4HC6yGJbaUXF18skCOp0P50fEYmy+Ow8vqPLZCvHVg+GfrALCDEdS4eH0OqxyDjMiWIpgWd1FHx+L69YrIN7YXZ8kNdLWhJ493PDtnajGXpi4rEtE6MG6wtT0/YnOOUVxNKMGw3lgAfRAZCIqCfQVnRmB3XV6hIutbEig+zNvkqJDXu+cZoC1UufyCUHUltUhk7ACdGugr6ljeyMAfMw6h3ONAA0TrBPE2IpNSocpUw7TmyrRndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52ADzsOwsgT0OFDybgJI0HKN6gJBJKIq3BsOGqF1BSE=;
 b=BDO+ShRCWm2Q7hYqxqECiqKqY/vah+N2VDegHOe/wO7PVv7W7aqeyFv3/UJyiQg+S2h28YTHppNr8hlr6u21OeLgVEaG0tkGKuvuT2KGWNVVOYtvtPohrT5gmiDLz6nKn1KZxf+6wIoSzVS1O+sxB3QnuMRkPwrgq/6jGHHJpCcGd6m6YgytXtfJKZqH+tLFBSAZnbYrxjeR8YUXAYR3wwlwUZS+EtNy0xNcNcnkADwTDVZpYglVuLio/XgIuDpy/2qAoIpYV6ASdckDBrW8me6pLqQyRDukY5kVrfH9pWZJoHjyRHw6PQw1ZURrxAUzQ1KjuF8b+j6PlhfRtsSkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4045.namprd11.prod.outlook.com (2603:10b6:208:135::27)
 by DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:16:15 +0000
Received: from MN2PR11MB4045.namprd11.prod.outlook.com
 ([fe80::373:436b:847c:bd82]) by MN2PR11MB4045.namprd11.prod.outlook.com
 ([fe80::373:436b:847c:bd82%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 12:16:15 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "toke@kernel.org" <toke@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, "fred@cloudflare.com"
	<fred@cloudflare.com>, "Kuruvinakunnel, George"
	<george.kuruvinakunnel@intel.com>, "Nagaraju, Shwetha"
	<shwetha.nagaraju@intel.com>, "Nagraj, Shravan" <shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v3 iwl-next] ice: allow hot-swapping XDP
 programs
Thread-Topic: [Intel-wired-lan] [PATCH v3 iwl-next] ice: allow hot-swapping
 XDP programs
Thread-Index: AQHZn31JtWnN0q9/W0aoX5qBzZap16+VNNWw
Date: Wed, 21 Jun 2023 12:16:14 +0000
Message-ID: <MN2PR11MB4045B74536BFE42959654245EA5DA@MN2PR11MB4045.namprd11.prod.outlook.com>
References: <20230615113326.347770-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20230615113326.347770-1-maciej.fijalkowski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4045:EE_|DM4PR11MB5341:EE_
x-ms-office365-filtering-correlation-id: 7396730c-b38c-4402-bbd8-08db72514f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CS95j6w8GdsFgMh3UZ+yBWzHhnh5szMfZ8HQJgOy4uP+3XkTaQDXeajYmrUf88RB/zpfcMVTdpUqnopYtyKIIJ2UkPhJe2rH7xDJQHgxHSyBcxBzIHOarWwe4Llxzl0x9SaVsaCrgZhGYKT/0uXqoFslGB9N0mbx7z48rn28fJbWibcfrNgRPpYDgC2xDVV0rtSLIO99OgIqrC3JBSBk/j3AqCtyLY/kkXc4I/h6xeO2mCWOWqEjRdKUXRc34GnFOrGKk1Shjklr8ugXFoPNmJrBOmpGs/NKpopabFLAZXdvA6ab00iTevgJ7w1N/Iut+YePgTlaahdSWhuKl2pB4189wjwHCwwoJpDcGunFKh2q14DL+2HZtoR1b64L6j3NPZpjUtPKzBTlAK+zp0k1LH/Alw9fPbeUYGBn0mhStRb2BSCTVXTD1FvE5ZWS2oiq5Es26HQ4Gr/QQQVGv/x0T7g6E2hMKzVbgmzqGESm2I7bYFrnYEa78G5rQHXFcZeiknxWJkK4jaD+LKTaWOZ5qjUZoMVUlcnCxpJXRfdNCIqDNne6290a57MnsND0fSQ49n5vXp5DD6xxGVhTtUR0ki6JVKD8eoPrvO+DYgnCpeMmigqCG/2FrpaBB/TtGqvH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4045.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(478600001)(7696005)(71200400001)(76116006)(110136005)(54906003)(9686003)(6506007)(107886003)(186003)(2906002)(66946007)(41300700001)(66556008)(66476007)(4326008)(316002)(66446008)(5660300002)(52536014)(8936002)(8676002)(64756008)(122000001)(82960400001)(38100700002)(86362001)(33656002)(38070700005)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A48zyyYrlGqD+9F5Roq/TI4X/LDPr2OO9jY3Jm1aaaaImHkOIbHuE4Rv870O?=
 =?us-ascii?Q?tSKWylmyD6kvU+YNDY7GEwOP99fwNoaZRJ98ILdqlw7XsjyDkyi32y6H/5Al?=
 =?us-ascii?Q?qmQU6lWezu5XsILYW4Ay1ou0f+9DGVFa7p0xNzwt+R83kFeObYVDNs5L9tgJ?=
 =?us-ascii?Q?WxpIade2gLk8yMnizvDZUGuvci9vZbvFZF5WYU1RolTvqVrcd11zD+YAwb+9?=
 =?us-ascii?Q?B5suUl20nW+zBhZk9DD5XxdMTwv0VWQj+9oNpQLDDtIdvpvBS+yKdi7uZHwI?=
 =?us-ascii?Q?LPmjo+Fz4ScHjFGj6h0Atl+lC//25sHVcDbXxW01IR3KJqqEhKQfol8zkKF1?=
 =?us-ascii?Q?rwGXkqWYxFlfHNQkjbtlXhBCbSHo1RiAYxZkYd8HygUguikoMOFhsosHri7J?=
 =?us-ascii?Q?dkGO5svoHuVgl+zrMslyP6hVpnk+mwj1bYb1kr9J7v1eMWlOx0uGKZtqL95d?=
 =?us-ascii?Q?3/ZBKmN9P1m9TdTp1JYiM+NHmbv8RVg3ChqLU26sfWVjPxdGfmYAGT+ralCT?=
 =?us-ascii?Q?NGSuRGjriefZ8f2FT311rDR/Qe0oWgybXFvq+xr2OW430HOPWFKfTCEWJNfF?=
 =?us-ascii?Q?J8znGZeY5qcc7TFw6YxCSEch72pvC6gni+sNUrlKymNk1Vsjju7UQ4DnmZft?=
 =?us-ascii?Q?fwpDyNw7R/FWqRIyqgJd3nfcKSJ5JBCtG0ybs12eIIfh0sJcCQ5ppNTEFjKp?=
 =?us-ascii?Q?8ZZ1rZGl5XJvXl2M9Jtpxil+h0tgAqN9QNegPkc+odYcAcDWHnpjVerE9LOw?=
 =?us-ascii?Q?K7eOq2gT1+Y2fuWUvS4eb6bGaZ/kgmZNNJh9tGpcZPOREX1wbQfCVx1yQne3?=
 =?us-ascii?Q?qLAqyNrx08CXWsoFDqLvOVUTIW8zKV22vhfwmWXkd9Ih+DHcTTWkz8HyVCLt?=
 =?us-ascii?Q?CAciQPCZFYLoSI+SW8jvlRsRKyO66vUDKQPq5eM6gmGM0gDQPFpJeeajevZd?=
 =?us-ascii?Q?hAo5z26Xqb9R/vI8elrl740315FeBqcUzIUtfyB5rSx0BdVM1SwUqV6V6haY?=
 =?us-ascii?Q?jrv72+9+PuHCAl1uKRM/jtyryuFboBffGT9bYoIMBC8n9R3t2d7xQkXw5viH?=
 =?us-ascii?Q?rVJIQSAIROi6Q4BnsC7RxqJNgLY12vd1fvH5jwiyjPxmDDKHXJAFD1+5fxk6?=
 =?us-ascii?Q?h669Ap/MiIXfcBUg8nuSHYHBRAaAq7/lDyiSGo5ynqetpT5WEnndn/j7WB0N?=
 =?us-ascii?Q?OP1ZXLqUgq8YgfiZKeUHV7xQldQ5TPnQKYBnYmHIqmAXYNjveJZ6j1EfdUxo?=
 =?us-ascii?Q?+UpfUg/L33oHgBhU2vqodchMRJ9fblBiNVMBjrCvO8t/CLn53KidzEg3928t?=
 =?us-ascii?Q?jOqpI4gIagOjfG6NBlkYGKtjg/aEs9PuHEXCkMLGMTNvGArf9UdAxW60zP0r?=
 =?us-ascii?Q?gUpRY5hm9frcPUgK1ArL0CfUqAtb/hcGLBKiCl7T6661tGsQORCOpgOeCcV/?=
 =?us-ascii?Q?ECZpK2UAM9MfJ2c5BIQTLMh1YVFmfnEeC3p35k1LXZZrTVRVYcM3NfsuFl8C?=
 =?us-ascii?Q?bvYYC8K24LD/Iw/U/l7HVka1iUbHiIDnDjnezDSnAQoDMhPGNd/wBA03ZUm8?=
 =?us-ascii?Q?kApBG2QPL7XIrb35jW8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4045.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7396730c-b38c-4402-bbd8-08db72514f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 12:16:15.0094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E8cS178VSwF//OJTfuhkU9yWjproyLPtoU8/xa6yRb+RKocCXQKUwdw2DtgUj0WrhbBbVquz1UhPu9jKQ8iS1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Fijalkowski, Maciej
>Sent: 15 June 2023 17:03
>To: intel-wired-lan@lists.osuosl.org
>Cc: toke@kernel.org; netdev@vger.kernel.org; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Karlsson, Magnus
><magnus.karlsson@intel.com>; fred@cloudflare.com
>Subject: [Intel-wired-lan] [PATCH v3 iwl-next] ice: allow hot-swapping XDP
>programs
>
>Currently ice driver's .ndo_bpf callback brings interface down and up
>independently of XDP resources' presence. This is only needed when either
>these resources have to be configured or removed. It means that if one is
>switching XDP programs on-the-fly with running traffic, packets will be
>dropped.
>
>To avoid this, compare early on ice_xdp_setup_prog() state of incoming
>bpf_prog pointer vs the bpf_prog pointer that is already assigned to VSI. =
Do
>the swap in case VSI has bpf_prog and incoming one are non-NULL.
>
>Lastly, while at it, put old bpf_prog *after* the update of Rx ring's bpf_=
prog
>pointer. In theory previous code could expose us to a state where Rx ring'=
s
>bpf_prog would still be referring to old_prog that got released with earli=
er
>bpf_prog_put().
>
>Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
>---
>
>v2->v3:
>- move bpf_prog_put() after ice_rx_ring::xdp_prog update [Toke, Olek]
>v1->v2:
>- fix missing brace (sigh)
>
> drivers/net/ethernet/intel/ice/ice_main.c | 19 +++++++++----------
> 1 file changed, 9 insertions(+), 10 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)

