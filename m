Return-Path: <netdev+bounces-16190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1443D74BB7F
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 04:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD551281943
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69337E2;
	Sat,  8 Jul 2023 02:58:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46211363
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 02:58:42 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271521999
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688785117; x=1720321117;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bSD9QxgXRciyE8+do6wkDjHT2/bgkmla6nsYPa0GGXc=;
  b=gRy8ViamZyCoOgJ/E/RLlpHPCJ6wiQ5nFq/kNlcD0oPkBxqyG+lhnayu
   3Ws0QJyKkqVHy9ak7ATt8Vo2UzdzxRTkND8N8SDsqv6nWWPCjSrtz1G1d
   pGAM0AcO+Yal3Pid2H8DRH3li3zkS8AvzeV7msYJ57xNDrzFBh1+bTk98
   HhMoZl1yEogp3y99L1lh26tIwZW/2s0cOGoaXhoKu8oYTUtiOkGhXlGpm
   HmwqL99HPHnOR7yLr9CUw+bk3en75f8zyR/AJUUKBhf0dJ9hTENeohGq7
   FxX2U49KwKOmVq5n3DvpLsDXIj2h+nuWm9V/9uoC0Zrkpz/qHlI2GJ5Jg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="348819321"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="348819321"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 19:58:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="697410767"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="697410767"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2023 19:58:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 19:58:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 19:58:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 19:58:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 19:58:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/K3ayt7yUPLmO9XJF3N3+OK7I9VDXTSmvO6htcW2rfJzU86jMlH5UZQ0F7YnDxe8FuAK+M4GMDeim6nCWTB8t+9b1u2HgEtwovSeJ32hlTynyr4fz5R1+YOczr9jn6NmeG10oVBfDDMc6NytEU1SonolEegiJdHBeAVRVxRGYCILtAsNCBokYsV8wODz/Y+NwAZrV6t/mv3p8J0TDpbFQtMU+nRxZCGHS9np6YZPASpGHZ+sahMxsAwQwiVpZp5C1B+P9YDfyFtf9udRhhJRMzquBGRBtjGfKmsUMqMK/i0n4bPwS9pGo399JT1PGToo9A4pGaz6xtnzcs1u9FysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+9+ZckLanId4Cz8BrOpPM59kM8W8TpopaOq1i9oHjc=;
 b=ZlYI6r1fc2O2TS14zNoIg7GANj6DseLcb3/2WsyCKSmdQ8T/KKXrqMbfY47dpZIU/kuoXH5brR4D3yuNKFm37xlTql+K7PH+ZpLerTk2XHbks5aEKazkH9tzojlxe4iyHDvkBUhmOCxh6JCBQjbgzr+2K2Fy5v49l5rPvGt8anpxADugALKcGiWFSxR8wPu+sHoPXG3tnpoM3zUYKM691sFulNt9EF1t2Tjfqx67laUujAvifgg/W4YiXNjCPIsVSpjokIpnTPq18fpHtmA0rqJQCqlOzX+IK3A8rmMO4BrIk5NFMef99MXARouPg3ZsgyUJ8VY4cCK3rrYFTOF1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3723.namprd11.prod.outlook.com (2603:10b6:5:13f::25)
 by BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 8 Jul
 2023 02:58:29 +0000
Received: from DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330]) by DM6PR11MB3723.namprd11.prod.outlook.com
 ([fe80::199c:7b:b9f2:8330%6]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 02:58:29 +0000
From: "Guo, Junfeng" <junfeng.guo@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jeroendb@google.com"
	<jeroendb@google.com>, "pkaligineedi@google.com" <pkaligineedi@google.com>,
	"shailend@google.com" <shailend@google.com>, "Wang, Haiyue"
	<haiyue.wang@intel.com>, "awogbemila@google.com" <awogbemila@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "yangchun@google.com" <yangchun@google.com>,
	"edumazet@google.com" <edumazet@google.com>, "csully@google.com"
	<csully@google.com>
Subject: RE: [PATCH net] gve: unify driver name usage
Thread-Topic: [PATCH net] gve: unify driver name usage
Thread-Index: AQHZsL8JkgCNcHWx/0mg32ebvKfu16+u4PQAgABLaNA=
Date: Sat, 8 Jul 2023 02:58:29 +0000
Message-ID: <DM6PR11MB3723743789CBF36E46792158E732A@DM6PR11MB3723.namprd11.prod.outlook.com>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
 <20230707152024.0807c5ba@kernel.org>
In-Reply-To: <20230707152024.0807c5ba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3723:EE_|BN9PR11MB5370:EE_
x-ms-office365-filtering-correlation-id: 7768595f-3716-4949-9ecb-08db7f5f3516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jdRQL6l+8OWnocbcBovyr08s33pymjPGH5zqTpSUbY9Ig7D0qRQaeZLWc47/IFEReBOFnSj1Z2Ar9uBz5c3ZKa7Vfc4tuejky66VjPAKgzBgV/UqvqYHdAS2bwrjhZnxGh6g4W16WOMkP2aqgq64EeCifL16rWrCQhZBtJ97viai6N9AnpP0fx4mBHUCpEXS+W3W0PtG3udFXngzhno8sZ8YASnKgDwHPJancXKfp9Qa66v5D16RMJUX7VhOJ/8eUgVOgpz97dE0JNL8bujcUD01VCP3yCkfxnyzpOqzLZacfVyt+YNWRkIg4Za2FSjYtuh+8X1Pxpc/au7YvQQrY22vHuIc/EAZglD2upB06PPBxS6qU2qs6JPM0I2tWVRQNtRNamNqghh8pbnxNRbfwa1xTIqAw4TschoyF9YyPKmjGu6xvoKRpnjAdOhp754MUH7B5vmaCs9UulF6qTJ21cCpl5trQhz3XPENrsVrceTGwhr5rNPJbYleDehiFCaPMTtw/fXbVNmLyzM3Nrr7F8kCTnjMi0uDsbw3Lt9BCYNwaV2AbSKoKBQw6Ydb8AVkPQHKH3U7aE3wHiWVGfC0FE73qTnLwEtii4rzTJF+6hR95IzyO7Ej8Zcdd9WTHv9u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(26005)(9686003)(6506007)(82960400001)(71200400001)(186003)(478600001)(54906003)(76116006)(64756008)(66556008)(6916009)(66476007)(4326008)(66946007)(53546011)(66446008)(83380400001)(38100700002)(7696005)(316002)(122000001)(86362001)(8936002)(5660300002)(7416002)(8676002)(52536014)(38070700005)(2906002)(41300700001)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?evItC5hiDD6oDvw+l+7b6kXudWWS+mNunI58sFL1nLTUlAL9NcIkhfd3L8l8?=
 =?us-ascii?Q?80OqRRGzuTsqplUGOR/GrQQcz+T6VMX5FNmZACbJgb0Tn1ZLIXQigUQV5Rxn?=
 =?us-ascii?Q?Wn0cXha4mSBX9qAJ1cNBRsW+2b6vInEuPv9wFPNMi/8NzFy5MVuDEnNd5Uug?=
 =?us-ascii?Q?vivKvty9YaWyiCw2VCNzOMbcb8Tyif3xrH4jV3Pg8yD6eVYQsCSWnPrxZ8Sr?=
 =?us-ascii?Q?VjfvDuJWwbfUT6Zm5lmGPSmcZ0jj6mqLwjmH9iNYTtZKjUqocaGSKchqcjmi?=
 =?us-ascii?Q?xt17ZguNhLPyGDNyBoeIunM36P8Hdt1X5ZgGFf3+SbxMAb8I7jV38NWDOk3N?=
 =?us-ascii?Q?PTwVLoFBtnIRTvMfaUZJMajqouT7XrmxF5VcKlK63I4LPeerIsvb3D7ONfn+?=
 =?us-ascii?Q?HP9lYFH1KX78tnwkGnagdvAh/RzKY+u41a3pqw3ec3vLqQ0FpAU85QH41mjY?=
 =?us-ascii?Q?IjMgV89kbrxtZU0I6N/EwSqSAxdU+AQsy+bHWhL5/eZ2pBJm4vM63r7T8PHu?=
 =?us-ascii?Q?nDO1MgHfJVVODCTvotFTc1QDJd++4yzosMa1n94QwS/tsLF8WCGDOFTIZTSw?=
 =?us-ascii?Q?z90XaoLPA0UpdAyZEx5/hMHrjUqQ/MP7UToX1EXyWrYyXZJgZoMMQRFm1NRx?=
 =?us-ascii?Q?dw6EhrToMQI277r6eYTriyH793e29/ACrf73Bob96gnwJoNaro492hGfzKLF?=
 =?us-ascii?Q?bwA4C1FEI3VrBvUZfUcB9s7qNV4CrQgqMDwUP5hLk4lI2/+zsnXK8sXcM8Ck?=
 =?us-ascii?Q?NW5mJzCcRMO1hnjcz1Lsh1W6VHLHMUUs+uJPuAJw97YGY6qUO5TmJuCGju5A?=
 =?us-ascii?Q?7c9VkqASUbT1/XBVeNGzOi5ijyXrYAAzqIGOwrxpflcaWwwCPekTSombkKmp?=
 =?us-ascii?Q?Xoh49U5Wkcx9LyrH0MmevON6mA0kTxph44mZdh32U4zAvPYgnPs402UCd4YQ?=
 =?us-ascii?Q?K2UfbFGAIf3kymznc8bUY1u/boMR4Jk5mE5TcSj7tMSaxBLeVJY0BXlDmYpW?=
 =?us-ascii?Q?rrNkULbzb1oIHJIYLSTeUxmWzx3CFcHL2Ut2Zi2TMKJMeIhy836uRclD56pl?=
 =?us-ascii?Q?5hM7mMoTs5F+KgCK45TPLZQxSMW1JEyI1ccHXeJxNukmEZ9L+4sv1//u0CpJ?=
 =?us-ascii?Q?PQM36SJaqXUgu6qF2EsdXtnbvoVdfkbey9GBxAxQrYFtY9Lx998uDjsAzoR7?=
 =?us-ascii?Q?4zpTceWWh1msSzlPzEdN3aqVr2H6XREcIQzkDkwvxrHjFtyVZyB+2Qo7AHpD?=
 =?us-ascii?Q?7QaR/vVuJg1HuzYX54x+joFISEuAAEwsdYmAJsMMKPV8CvMB3P467u1cltYl?=
 =?us-ascii?Q?uJ1SyoKrfGe6KIE25ia5Gbr3IW4m3G4+GXcKhyZxIiaGq+wwT0qwPeh7qkEZ?=
 =?us-ascii?Q?0VQ0iMDnEJhPiIHoVWQllUYrARJ0+NIOVvYH0lnKd6q6Pm0zi2rJCBIn3cLY?=
 =?us-ascii?Q?Dzv1U4vNUtPHuGGkZ3c59AX+uC0oxZHlEgPl3u/TWDtLHvv6UDquzLTGfRiR?=
 =?us-ascii?Q?fsFDJXCQCu7XmV911kDh6mMJem9dd9iX2YqmRTBeEaOlbPrhy2Dp/sDslDZ6?=
 =?us-ascii?Q?0AWItpf9Wsr/LP+zMYla/0cq2GKnojWxlv6VJKCR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7768595f-3716-4949-9ecb-08db7f5f3516
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2023 02:58:29.2226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vw9gd3qauGuK71dV9bmn2DEOR0f50+U7JJs62F2XFGIVQ+9IFX12R2Zrs2PXsSLNTPiuLqlbAUMBfulP4DTQOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5370
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, July 8, 2023 06:20
> To: Guo, Junfeng <junfeng.guo@intel.com>
> Cc: netdev@vger.kernel.org; jeroendb@google.com;
> pkaligineedi@google.com; shailend@google.com; Wang, Haiyue
> <haiyue.wang@intel.com>; awogbemila@google.com;
> davem@davemloft.net; pabeni@redhat.com; yangchun@google.com;
> edumazet@google.com; csully@google.com
> Subject: Re: [PATCH net] gve: unify driver name usage
>=20
> On Fri,  7 Jul 2023 18:37:10 +0800 Junfeng Guo wrote:
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
>=20
> Google's maintainers definitely need to agree to this, because it's
> a user visible change. It can very well break someone's scripts.

Sure, exactly!
Google's maintainers are also CC'ed to give decisive comments for this.

This patch is to align the inconsistencies for the driver name and the
kernel module name, which may also help improve some scripts to
avoid using exception mapping with two different names.

>=20
> > diff --git a/drivers/net/ethernet/google/gve/gve.h
> b/drivers/net/ethernet/google/gve/gve.h
> > index 98eb78d98e9f..4b425bf71ede 100644
> > --- a/drivers/net/ethernet/google/gve/gve.h
> > +++ b/drivers/net/ethernet/google/gve/gve.h
> > @@ -964,5 +964,6 @@ void gve_handle_report_stats(struct gve_priv
> *priv);
> >  /* exported by ethtool.c */
> >  extern const struct ethtool_ops gve_ethtool_ops;
> >  /* needed by ethtool */
> > +extern char gve_driver_name[];
> >  extern const char gve_version_str[];
> >  #endif /* _GVE_H_ */
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c
> b/drivers/net/ethernet/google/gve/gve_adminq.c
> > index 252974202a3f..ae8f8c935bbe 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -899,7 +899,7 @@ int
> gve_adminq_verify_driver_compatibility(struct gve_priv *priv,
> >
> >  int gve_adminq_report_link_speed(struct gve_priv *priv)
> >  {
> > -	union gve_adminq_command gvnic_cmd;
> > +	union gve_adminq_command gve_cmd;
> >  	dma_addr_t link_speed_region_bus;
> >  	__be64 *link_speed_region;
> >  	int err;
> > @@ -911,12 +911,12 @@ int gve_adminq_report_link_speed(struct
> gve_priv *priv)
> >  	if (!link_speed_region)
> >  		return -ENOMEM;
> >
> > -	memset(&gvnic_cmd, 0, sizeof(gvnic_cmd));
> > -	gvnic_cmd.opcode =3D
> cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
> > -	gvnic_cmd.report_link_speed.link_speed_address =3D
> > +	memset(&gve_cmd, 0, sizeof(gve_cmd));
> > +	gve_cmd.opcode =3D
> cpu_to_be32(GVE_ADMINQ_REPORT_LINK_SPEED);
> > +	gve_cmd.report_link_speed.link_speed_address =3D
> >  		cpu_to_be64(link_speed_region_bus);
> >
> > -	err =3D gve_adminq_execute_cmd(priv, &gvnic_cmd);
> > +	err =3D gve_adminq_execute_cmd(priv, &gve_cmd);
>=20
> What's the problem with the variable being called gvnic_cmd ?
> Please limit renames, if you want this to be a fix.

Thanks for the comments!
Yes, this is not very related to the fixing purpose.
Will remove this part in the coming version. Thanks!

> --
> pw-bot: cr

