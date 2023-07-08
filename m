Return-Path: <netdev+bounces-16189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B76E74BB7C
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 04:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538291C21119
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9661360;
	Sat,  8 Jul 2023 02:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAD7E2
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 02:50:13 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C641DC9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688784612; x=1720320612;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iCNqmiDto1d+XmleCYYpju2XczkULedhdofqnpKD2fA=;
  b=KhRwQI+J+U04POWqhduuSBjPI1rRUbJ8dAlc63CAo6n/+0g5SRpBhRGH
   5U6IA1rrUMpV2ujViHJWVqQeIPHaenqimVNCxmwcqC4ygasna/EN3uLLw
   wcOteqlLjedNuHuKRcFs6XzVE6OAmFG6nktK8T6uN/cXPdtuNg/Uj4cOG
   /flrXKy3St2daz6999fpLEowBa0zab4CQVzr5ycdI4nN2tKuvPatP90gc
   z2XZFhRqfBN156wWyMKNwz/IbEWm/1IhJMGK+QbQ31ZpL7DCFuVaxv5xZ
   NotDfPgN/8lWRPVdwEe/uA6AEshYxPioMg4R65TEQNmcY5Jc71DRMNyCV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="361492545"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="361492545"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 19:50:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="720118497"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="720118497"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 07 Jul 2023 19:50:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 19:50:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 19:50:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 19:50:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 19:50:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnAvL21BsrhqoZxqyB+2OunUdufAbUYcudJ9kl4ECqUejXu/Hrnd3afXZje6oKvtzTCIa59OXQC+Mfi/Ict4LvNLsdM8zr2SWVhLzfzcWZ0nws5ko6pGW8LPIG//nl7G7P/W6UlSIACWCj4wGhZiSHT8uQ00Pfo5MBDUIXdJhGss9yHszSwKeeoHQ1UocrElXcegubDYR2bYEYLUNxCxamRE/V8u6Feak5AZrOK11FLllz64Zm746qB2V7IeQtBWU8qlfkT7bJggaar6eBhWyJGj72ZOuh4k0Afz9vo0FvB8P5nwVGb4rhSvJ8fGLymOi0jKZf28+GQpneLvVX2FDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCNqmiDto1d+XmleCYYpju2XczkULedhdofqnpKD2fA=;
 b=Q8nkpfa51Dj5/mxp+Uj8ASwhJycMId1ieWS4dPycGaCCN9nOYvKQNy5dxdh4VBjPIuQlqgPAW9xxs1bSpGXUM9hFlPQn5HssHhjOBGmAmbW9GbaA5pXXKhLdemeZVjZqu1r+ccM2Hs/GnMwG0k1uc7VI9RqTUmnMQ/PVhrNYxlRNOagPZWG6FjgMd9F4a1pbHAVtjavkst0It0F1xZ2hjPGP1uZT/eUnTKB1w0aysE9XdpzJp9Zauz8HIj4mQxgdtRUX5MXwsXl/r+jU75bxT4Vm3Qlzk2CnfEJfqlq9uHT33uvO4xmGUhnVHZBbsiUpZqlPBsOPpsqPN7R2gSM9KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 8 Jul
 2023 02:50:09 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 02:50:08 +0000
From: "Guo, Junfeng" <junfeng.guo@intel.com>
To: "Kubiak, Michal" <michal.kubiak@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jeroendb@google.com"
	<jeroendb@google.com>, "pkaligineedi@google.com" <pkaligineedi@google.com>,
	"shailend@google.com" <shailend@google.com>, "Wang, Haiyue"
	<haiyue.wang@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"awogbemila@google.com" <awogbemila@google.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"yangchun@google.com" <yangchun@google.com>, "edumazet@google.com"
	<edumazet@google.com>, "csully@google.com" <csully@google.com>
Subject: RE: [PATCH net] gve: unify driver name usage
Thread-Topic: [PATCH net] gve: unify driver name usage
Thread-Index: AQHZsL8JkgCNcHWx/0mg32ebvKfu16+un6yAgACJwHA=
Date: Sat, 8 Jul 2023 02:50:08 +0000
Message-ID: <DM6PR11MB37236C475AA8948438264CC9E732A@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <ZKhY5Y0C5ySmkp1w@localhost.localdomain>
In-Reply-To: <ZKhY5Y0C5ySmkp1w@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3723:EE_|BN9PR11MB5370:EE_
x-ms-office365-filtering-correlation-id: 5a2b2486-4a39-4bcc-e0d9-08db7f5e0a71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k+rGvdVJewB21UVm4zsA4+H4DATTU7t2todV1PdtRrBrWn6T6gxx1a9LSHOQ0kp5G5DRcXzm+9ToJoKPiTmTKLj8Ilk6y3wHIXMlG8vRb1+Gs1ap9VS4Gb1QkM/0dpOLbedVzBzpK8VoIB47Ho8Px5FpYJVY9g5Qwf1TYoayoor+xMKsnAI+xj1P/sCON/HV7HyD3TJNRIhFQntBQxUOd7FSgNxzfhxH8qaWPJgAUaCXXMMn7v5woWcAqkEnGbkz6eIR5PQBUBSzJwAloZWiBMNQ55A00TG4A+R11nxpbEbYOjelsNNFDlfT2mOWNgpZHIuhKlfFbKLF83TjqayLTEkCcbAUxpkvsCcHd8W8Uu7JvMfY//pto5Aw0q2UGvI14guZaaakj9OxJKleeoPLTmcXGGHFItkeZgXqmLVZqIaiLbV9Wusjgh66z3pkx+7zKfbuqjr6kKenTM47aqbl8zGQj+J/mE6jNQWPbKjJA+iALEw0WfMRFcrwvXR22HalY1HleaPA60MGqg+TJ8eU3eQrJKsHhtFoK/cmhIbB4uXZ8Pyo7T/9t4zZ2M57pPlflynkn2imJtHLrPPl1A9pnWKo5XkdkzJkdAzzGjg4NjWGm+su8O6oDv/5k+Dw89Zg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(26005)(9686003)(6506007)(82960400001)(71200400001)(186003)(478600001)(54906003)(76116006)(64756008)(66556008)(66476007)(4326008)(6636002)(66946007)(53546011)(66446008)(83380400001)(38100700002)(7696005)(316002)(122000001)(86362001)(6862004)(8936002)(5660300002)(7416002)(8676002)(52536014)(38070700005)(2906002)(41300700001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/VKV5Eeq3MvM7diMOJS2TuQ9hObOlirVdy1SRSG55/uOFqlpvHn4YAIzMqX?=
 =?us-ascii?Q?z0yKVUkVodcPIRr3RkjcjcDr66Vy7fJoy6wjyY2Qh0kTS//daDMnBBm21VL4?=
 =?us-ascii?Q?+SPhG1EhAk0N0XwpeRIdFm7AAmhQ8Z120zZg4N+psqXvKjpiX7Cz9NXj8+tw?=
 =?us-ascii?Q?t2PfgLmo2r7QQpAFCg8Qz1rOz68In5UnuE7LBzOLzxHN3KS1UPt/OM3mTeR4?=
 =?us-ascii?Q?WXP/DM2UxLJ6+WGcMrhDHxq+fNzvvAiLg96FyLeewa2Ezvsz0a/EXibTAYqE?=
 =?us-ascii?Q?atZt34AcrAjGqYhyiMUqtA2CTYUCSYfPnZzuLRarzGxlyZ1AnBCEMwoD74E/?=
 =?us-ascii?Q?JbAHgcV9+Efrczndk0VaPp7nJiG2jYSoAWWAVF4wk1BWikZgNcPvIi0GC0RR?=
 =?us-ascii?Q?8Mo4Xor/Ujsgd/Q3fUGK50BNvVi4OIfdBOX+EN38CqyDNlcP2X2/2s7dDZ8t?=
 =?us-ascii?Q?BBIOzfehq1xZ6fYvVvQlS39X3eCNdid9noWVGByYiBQuwi3P2dgqe9buqNti?=
 =?us-ascii?Q?gQYAK8Cb17bsMxK24Bvb/IlSzi3FlZLjaEfngZC6TVw4nswWM8gTwuXaf5hJ?=
 =?us-ascii?Q?cAeOpAxUEuj3UngWddD8/r4cxyXcdVxuZyvb4hgaqVfHOWcoASMeRXoUx5Or?=
 =?us-ascii?Q?a/dYOVG3oFQmNuZY0bJ3SGkiDUnhHshGCsmDdh6nunZdw+iMmVnve5hOB0nR?=
 =?us-ascii?Q?SRnPOV8V3FflA4ivO2fJAriO7Al4Ke4GD5QOWAPCcl+jAmFZ9JldeSQqByUZ?=
 =?us-ascii?Q?1xpnMG4nD4JqIiqSuNitmo2EqDnISI6ZKPsahMCW59+ryNlVBluqog+UH1zq?=
 =?us-ascii?Q?Z0EiklJtozorPb3ktnQw4r3tdOw55u9LvGaxDpqiyEtv3JsJrtd9evZfXEuL?=
 =?us-ascii?Q?BM2fYh092tYiql5eawJlOyA5smLsTYUGn8rS69vXAb4cBjQE4yXKSRQY4H3l?=
 =?us-ascii?Q?PeJsimLoxMTwr6tXMhOVawRzmVql/bhvxOyu3JTb9N1cbNE+uJruRXbIBGar?=
 =?us-ascii?Q?D+sDbH9wTldK0z6VUSWtWk36J7vXiiISc7Q3iXwYneuq3lhzvEonLITRWwHI?=
 =?us-ascii?Q?o9yUxu837PoMkj3ypfEV8rTx8AwVxMdNtrxna2/o7ZbNHFwOjjIzTTP8Kwih?=
 =?us-ascii?Q?q0875+qUiE8eZNlLEpPy2V/7h43lpoAEibNBqA2Lv/I5ixHqPkBzu+7fFFOV?=
 =?us-ascii?Q?qxdE4MImjDkUfdScjLQA9Lt2xRAvYVwz9ixg5oZ/J43LiTfvLPjOtz4kOuUG?=
 =?us-ascii?Q?nhn2PYirV0VR6vH9PMVXlEwUyQ7EpL8pGXvERh8fd/GgK5P+sdsASO2cTR6n?=
 =?us-ascii?Q?UqzXYBrMxvOF+K4wXrJkYFuTc5R49LYGVMshDqtVoMLyGNG6nQrJNPDANpQT?=
 =?us-ascii?Q?lKYqNllB/4OZcLSiObUyAJuiR0vdrkfAfJnAEjas3pAhucqGkPoLjijUDgIY?=
 =?us-ascii?Q?vRoGO8cKtVxOTjGLTAgxeBXBe3YZO/w2hP8s1Ybe+PZCQNpd31uQKO+Kbez2?=
 =?us-ascii?Q?zE0uqrB4MotOYD/GH9L8Ae2zfDgO4glunrIASLobuD2MAML0Kt6X5Atd260D?=
 =?us-ascii?Q?j6kUaGYxVmmUW9zrL3PgUltbbdilCMclc/dpt/Da?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2b2486-4a39-4bcc-e0d9-08db7f5e0a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 02:50:08.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KTjDDywMpo+LaBI5JrSYk16hPeiold4rBnFMQPLngScsGiilf+WvE17S6JNdW11kzRh1fq9+qXr0svGS8BKIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Kubiak, Michal <michal.kubiak@intel.com>
> Sent: Saturday, July 8, 2023 02:27
> To: Guo, Junfeng <junfeng.guo@intel.com>
> Cc: netdev@vger.kernel.org; jeroendb@google.com;
> pkaligineedi@google.com; shailend@google.com; Wang, Haiyue
> <haiyue.wang@intel.com>; kuba@kernel.org; awogbemila@google.com;
> davem@davemloft.net; pabeni@redhat.com; yangchun@google.com;
> edumazet@google.com; csully@google.com
> Subject: Re: [PATCH net] gve: unify driver name usage
>=20
> On Fri, Jul 07, 2023 at 06:37:10PM +0800, Junfeng Guo wrote:
> > Current codebase contained the usage of two different names for this
> > driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> > to use, especially when trying to bind or unbind the driver manually.
> > The corresponding kernel module is registered with the name of `gve`.
> > It's more reasonable to align the name of the driver with the module.
> >
> > Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute
> Engine Virtual NIC")
> > Cc: csully@google.com
> > Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> > ---
> >
>=20
> The patch makes the driver strings much more consistent.
> Looks good to me.
>=20
> Thanks,
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Thanks for the review!


