Return-Path: <netdev+bounces-30547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9791A787EB3
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 05:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FEB11C20F46
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 03:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46E80F;
	Fri, 25 Aug 2023 03:44:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABABE7E0
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 03:44:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3855B1BD4
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 20:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692935082; x=1724471082;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jNammblKqH73IMQbpQK9juAvpC7MtWVuFkcvqTe2iNM=;
  b=jy0m9j9D5eu3tYw3B5PhSrHVwrK2DyVuwmkWQwn6sM0Rvle9tVP4Uzr8
   kB1wGc7LGVEmd2Qb77zbPH25AjY9Zd/uS0O5J3tD30QvLHJV0i75L2ZjG
   DOZe0ggDl6sal4a/Iq3yc0mWoBRJ8xiPd506Nok20rgkrAOjk9YFdF/S+
   5StD8c3pj+8bVCKkS2kbZ5sCjJ+watgqcn+GH7U/N4RTsQrUhnNOMObMm
   ymE3k6JpDqzSD+NiQXSv+d/9gLpcrhoOHupkgp+tjdPq53oZ3aeqVcdaA
   036dZy1TwcXzYqbfQ1DyiObYzSP2jBAObzpbKYV1zVE2si4O7HP2OjqE6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374598369"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374598369"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 20:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="860942156"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="860942156"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 24 Aug 2023 20:44:41 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 20:44:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 20:44:37 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 20:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpM28kGRnT7zMnPPMczWml8jB5SSxcKURRHAfBm+83R1b+hfG37D/rlDYOzFZuLeBMoWONsPpCmbbFJr7roBxY9i+YzFf9MHaodiyqvmlEGL9q2b8uTi8/dAHxmUCIkmcpeDdAZrzt98PjGgKNrUkXgyWIm2TWYv0Wh9+PYJSIBXBGo7GFKZxREemzBs74Jt1myiteR90eEcqWE8fhj8UDi07vYLMEcq28uz5mzwSy/M1cqFLPjDk9JlRYfHbq+aHdeC/qQLkMd/uNTNCsq0MPBvJanDCdZZuTX2oBFPvkzUGJ9Xtu4aFCFSgNw8vdxVA8p34OEnKSiT1P59Zq006w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBE9a0yy7l6kK7/DDEb80JnHW/vhgjgUH3GLUenbXWA=;
 b=J9jVMqokzIsD57/yArC1AnrwIIXTObVqpHFjsG3d71inkfi+x6768mE1eEEEeC6uNftUG6lq65Wxy8w6SqiqXQCCTNiHrIPrqd0h681SLHomdVMLgGcZc6alAtk+NquVlpJBM1ULt9DPOGbzgJcZkMncVLIlFH0GlM5+8tRmwZPK9QW6pVvCnxSKXk+S3+ydEsvD7JQ/CxeLkSmRRSnIq92SPVR9UT/TgfFC98//i7FvMbzkjfVxMDOnCf0j8+isFXiv6dipkB4EXjhoA7bFC4P6jm7haVuwnETkAR/LQa+byvdj3ogBjM7mSDGkDJoHdRDQkASR0OSEi0NG//tSBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 03:44:35 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 03:44:35 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Neftin, Sasha" <sasha.neftin@intel.com>,
	"horms@kernel.org" <horms@kernel.org>, "bcreeley@amd.com" <bcreeley@amd.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: RE: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Topic: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
Thread-Index: AQHZ1UdLBr55a0cOOkC26dNjnXpg9K/4uEIAgAFVHMCAABZcAIAAPQoQ
Date: Fri, 25 Aug 2023 03:44:35 +0000
Message-ID: <SJ1PR11MB6180835AA3B1C2CC9611B44AB8E3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230822221620.2988753-1-anthony.l.nguyen@intel.com>
	<20230822221620.2988753-3-anthony.l.nguyen@intel.com>
	<20230823191928.1a32aed7@kernel.org>
	<SJ1PR11MB6180CA2B18577F8D10E8490DB81DA@SJ1PR11MB6180.namprd11.prod.outlook.com>
 <20230824170022.5a055c55@kernel.org>
In-Reply-To: <20230824170022.5a055c55@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|PH8PR11MB8015:EE_
x-ms-office365-filtering-correlation-id: 280e2d3e-2a58-451e-088f-08dba51d99b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/CWRSpXEe7bOx3pD8NGKFqyOwDakRrB18Na6L6gaEVQ5YKJZ3Oaf1mkHfK1LagCK6RrWwj300QzULk5dvFFhojpTV8DDckJk83LHvfoZShpUBmTysWxcwLn7bj3xopJ/klw+4f7x/hbZr9M2+ENWWMdC/c4OkJ/zhDstrDktDM4guP8lM9CeAywJ7Z7KvihJe3t6eLrD/zSizOj+BPxWeaBAUIQ+WdsWQghBBMv7C5HSfyxwXKbmzk/sH4BijBuGavidO32vZWwlRARn8VvaSziuQJz0e4LBOQsMi+flUsUE3kYKGhCuGA2uXRb0v3lijAwAt2qiY8AhrPlsPwOQyXg51i6MvsannnrCCU+rjRtzH76j4ZHyYVfSoX1NSqI3pHLvWN435X7jJjzeQ3MZrrpjL4tNCKSgaUh27aWk6H6kPNpfgbdIcToqrmlqsaSHgTAU1CdoQDeRhFmzmClXJnFeDfyM25W+W04o8nMKbYdSN7URLMa5+UI5IqV7jyRnuiahZ6mA8mrvCu0dhbYCbghk135iWbTVucLZFvplm/LvDB2Z84tC7bp7tNv02BYK9OsQ85rQxU3mJIhImjztnHSTC7Y4LFPfnzDeTTWPLW2p4xO96ryZbQlAVgoygP0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(66446008)(66476007)(64756008)(54906003)(66946007)(76116006)(66556008)(316002)(6916009)(82960400001)(122000001)(478600001)(26005)(55016003)(38070700005)(38100700002)(33656002)(71200400001)(41300700001)(53546011)(6506007)(7696005)(86362001)(2906002)(9686003)(4326008)(8676002)(8936002)(83380400001)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LwFPIbL0w5jtwpyIP7qGKYQsyU3riC2fQvDdUzjlHOrEQQVZkp93h/CtndzF?=
 =?us-ascii?Q?z+IekI4nA9zqPx+kOlLIDH4py6OJsK/AdL9zReeNkBpMEYu0BQ7oNwEuJrXW?=
 =?us-ascii?Q?wfLJ5KKD3RNsHbGoO2OGMwEf2yoclQakQZ7KSMmwVV1FXRr1OnUVCN/sRnFx?=
 =?us-ascii?Q?JpTw0jc7T1NhLPuHdWIe5sFOhV6HOb+hTZ1TLzOqeDICsIWVB5HzBxInHfXC?=
 =?us-ascii?Q?jBR0sqLHhv5j8AaQnZ0Iqt1hE6AL5dHuTbu1v6wZYHtqdv/owgA9Yj/W6HMd?=
 =?us-ascii?Q?fwIoVhrXaJzs7JLnfPA/U14vsBlBtkL8Z3Ix6tZRVqHD+9iFmy/valVy7mCL?=
 =?us-ascii?Q?kRMEF5AHmhQOGI++DRxNgilPyVl09QfalslxtAY3nky3YuZfxH9oWsjAt4p5?=
 =?us-ascii?Q?A48QNyMy/KcFbpPfz1SFET9PBkW7KLKuB34mOGZQABRhG+yaLnwaU3169Dk2?=
 =?us-ascii?Q?L5qIgLc0Nf3zctSm9Fr5iAhKpq6leslZSgOZBV+64xZ947TjaCc9scmgww3D?=
 =?us-ascii?Q?9VN0sJ2/aVJcQJlrK1eZerUZ5JIyf7RICPFMyDfAKuop2vnwk+pvIqCZsHID?=
 =?us-ascii?Q?jqQkmZqOz0UqF5JDHUcUaZfJ57m790t42twZ61eKVIjXpLHdc4Q3n1m/9Uuc?=
 =?us-ascii?Q?/fvjhUns/jI94NwVmOmfB8zdRAC0TMQey3ykzhi8AvWrKapUNOCEzIo/3Au1?=
 =?us-ascii?Q?stsDD+Z7SNckqPuRgw9oENDEFbwKQUVdJ9/I0k3fk+1+gBzUVKk+0E5Kv4aY?=
 =?us-ascii?Q?+KhY83E/iffDUpzd8Ix55RQ8/k+beo2/M1j6qL8VgeRqc+V0nDmkgKGYDecv?=
 =?us-ascii?Q?4jaUAUoMOjt7k40i4ZYZVLUj9TBh/KL+BoJJ/EVbnWoFFrAc7Zxvw2L82u6v?=
 =?us-ascii?Q?kfjRRuNNfvipBN4vNvR+7GVdnY9hEX7Hd96+L4OhhallpZQH983Mg/i8Io1l?=
 =?us-ascii?Q?zC+Lqy7Fz9cypH59ywBOzTIL1D59WcyVuysU6wW215cgyZrzVOwoDQL77YMH?=
 =?us-ascii?Q?vYLX6km4EeoEY00EHIKZzvprW6U1ARcYVzIy4fivDEcRXlZL0YBS7LwroDRr?=
 =?us-ascii?Q?bhwpq4W8T+3xM2nSe6roZ6S5kHvToy820KnYs0DrxGNaRraWL9hUBhWneXQa?=
 =?us-ascii?Q?eC2dS3SnsGcxWh3vIS5SdR3dbs3bK2jd2bGPGf7Ql5N/1m7+kwKq/YSHT2u4?=
 =?us-ascii?Q?0Y3NP1o+weN8A2ShjT6yB7mx1hbeqDJye/cAatiTZpjy03weyoi/FkmRdo/C?=
 =?us-ascii?Q?YwYvthUFsqrcMvqRBz5UU+qctMpCiQA6kyP9vNW4bHnkt9bMQEyNVK+uQix4?=
 =?us-ascii?Q?vhUdsVmki9dDf5GwFj4KLNnapxXOtfqJNCRubWMvjx81pnsPAbtM+iAD5v8z?=
 =?us-ascii?Q?Z1QMmeyhwED31GvTd0ajkq4hhEFaEKoh6vRpPT70R0yw0AOoZtOGeoWIcU2p?=
 =?us-ascii?Q?XFqSkq35IIU5X9n3WcpUGievduMtqJjVRZfxJz5764MWYZHESGT5PYzJlfVg?=
 =?us-ascii?Q?Phq2JPNGdlA1byuygsn7aPveE1CrbAjzcle3VjrKAcFtGB45RUx1sAtnLw0E?=
 =?us-ascii?Q?RfzKFkB1dYpiEmAFRhJHyy7yUrVpKgXXTmY4AKd2OfE1x0fsV2WOQDj5O2XY?=
 =?us-ascii?Q?bSFUTjuNuQa53vOE5gK86tM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280e2d3e-2a58-451e-088f-08dba51d99b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 03:44:35.4327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ty9uv1BJYBCvigk/MJlM7CFhWL5YMO/ClMoiy9yC3XNyblOJUoh4/o4GWs6uJVv9iWxmFDg93nyPBW79Vv7jlaj/DwrYaGCbEkS/6R5eFu/12UQb2Een25hFjU+n/kV5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, 25 August, 2023 8:00 AM
> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com;
> netdev@vger.kernel.org; Neftin, Sasha <sasha.neftin@intel.com>;
> horms@kernel.org; bcreeley@amd.com; Naama Meir
> <naamax.meir@linux.intel.com>
> Subject: Re: [PATCH net v3 2/2] igc: Modify the tx-usecs coalesce setting
>=20
> On Thu, 24 Aug 2023 22:50:34 +0000 Zulkifli, Muhammad Husaini wrote:
> > > Why was it returning an error previously? It's not clear from just th=
is
> patch.
> >
> > In patch 1/2, the returned error was removed. The previous error will
> > prevent the user from entering the tx-usecs value; instead, the user
> > can only change the rx-usecs value.
>=20
> I see. Maybe it's better to combine the patches, they are a bit hard to r=
eview
> in separation.

IMHO, I would like to separate get and set function in different patch.
Maybe I can add more details in commit message. Is it okay?

>=20
> > > I'm not sure about this fix. Systems which try to converge
> > > configuration like chef will keep issuing:
> > >
> > > ethtool -C enp170s0 tx-usecs 20 rx-usecs 10
> > >
> > > and AFAICT the values will flip back and froth between 10 and 20,
> > > and never stabilize. Returning an error for unsupported config
> > > sounds right to me. This function takes extack, you can tell the user=
 what
> the problem is.
> >
> > Yeah. In my tests, I missed to set the tx-usecs and rx-usecs together.
> > Thank you for spotting that. We can add the
> > NL_SET_ERR_MSG_MOD(extack,...) and returning error for unsupported
> > config. If I recall even if we only set one of the tx or rx usecs,
> > this [.set_coalesce] callback will still provide the value of both
> > tx-usecs and rx-usecs. Seems like more checking are needed here. Do
> > you have any particular thoughts what should be the best case
> > condition here?
>=20
> I was just thinking of something along the lines of:
>=20
> if (adapter->flags & IGC_FLAG_QUEUE_PAIRS &&
>     adapter->tx_itr_setting !=3D adapter->rx_itr_setting)
>    ... error ...
>=20
> would that work?

Thank you for the suggestion, but it appears that additional checking is re=
quired.=20
I tested it with the code below, and it appears to work.

		/* convert to rate of irq's per second */
		if ((old_tx_itr !=3D ec->tx_coalesce_usecs) && (old_rx_itr =3D=3D ec->rx_=
coalesce_usecs)) {
			adapter->tx_itr_setting =3D
				igc_ethtool_coalesce_to_itr_setting(ec->tx_coalesce_usecs);
			adapter->rx_itr_setting =3D adapter->tx_itr_setting;
		} else if ((old_rx_itr !=3D ec->rx_coalesce_usecs) && (old_tx_itr =3D=3D =
ec->tx_coalesce_usecs)) {
			adapter->rx_itr_setting =3D
				igc_ethtool_coalesce_to_itr_setting(ec->rx_coalesce_usecs);
			adapter->tx_itr_setting =3D adapter->rx_itr_setting;
		} else {
			NL_SET_ERR_MSG_MOD(extack, "Unable to set both TX and RX due to Queue Pa=
irs Flag");
			return -EINVAL;
		}

Thanks,
Husaini

