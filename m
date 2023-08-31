Return-Path: <netdev+bounces-31521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11A778E800
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0041C20971
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11521C07;
	Thu, 31 Aug 2023 08:30:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90F4846E
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:30:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B28A185
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693470629; x=1725006629;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=HC9H76hA1rkGD/xHKdgWpoE5M9xrFw6g/muOxOIciyM=;
  b=ieD/0BikiSeToJWcCp1DP87mpbM/3LM5awD1nqL012h5gXtpVNR7g0of
   hAyPK2JyTUwpMqs8sYpEAIMX+d9TZDmQ9whXKJgRzN6/Edanl51/I+wC3
   JZYpILJd2OJzx+7e+PBDOiiuVHRxresS1d31snSOiIHJOG041v3YM+ES/
   Xg/6QLWW8flnUOMegUdVmOMXA+y2Ldw2A9OF3+IEYniGk0aV/MqaQNRxx
   Zdo6snrFfUQ5EOy1AdXOwfMEwiu4zHH/rniQmDyp9M9bcpnShrOtOzRlF
   JI2FwAJuMseu1QPR48OjZQMJ6N37YfJGxdTRMc3UgUvbgxP7iRCbHw2+Q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="360852257"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="360852257"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 01:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829569159"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="829569159"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 01:30:28 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 01:30:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 01:30:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 01:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuUD2lOwrnTke6MxAZIs02mZjYJMbEjwsWMkWsRTf7qgfZNVjGH8prgnUQZkBooFTGgEuPvzvw8PQdsmh9SBbqe2bSYhiWs933hYHkwq0gpxsNRptvTLVjp6l2XYz5hChRe0alzHpaXLhAjfcixAAPIdP6BshiIu7tT+uti55sEa9uwYzGmE+cMtVsmOP7o7r0/89HHRoO8eD9VaD6tK2eTZgHPJUP1Aw+h0dVlS57zq5Q5nBhuRfSbIJrlu6TyzDGsUefUBLWAQL83U3m2dXYv4+90acjas+9zhQFdpxuCLKGuCKmdx5oDpUyiX3rU4Vkzj6ghJfIwHeCanLSy08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD5bY8YEqt4yR9TQX2+WDxDKs8olxzsyYVAQ1UJ5Ne8=;
 b=B2QAZlPmE7WjA9NP5d/P+9/+j5vbTmiVLA5V2h+cqkTEBiPQ6T+GwfGNINMvqjvCcE55OpGeg8wjOvj/vyHlwsELg9ew37Q7i5UuGFCHbnVoOAnY+dbmWFSnO9LrV+IaIXICreiDVMrxbnRrgDfeyR4EIVOQp9DBd9hbXZsqiHrAhJ5OWMYWF17oQFY/3wwj3KB+UkXHVJZfwoz6E0eKy9UC4IFnQaPkhLzM1qwRy4QrfytOkl81VLJfpwx8KBrzSK2rmWaOGp8QBoMH+q9RI0/Vw90EKJo06I4NX+GjU7jKC+8gOxVmWhtLTbQYh2sigSdWCh7mkHZOzqFgrUGKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by PH7PR11MB7003.namprd11.prod.outlook.com (2603:10b6:510:20a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 08:30:20 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::2a21:609b:312:5cac%7]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 08:30:19 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>, Jinjie Ruan
	<ruanjinjie@huawei.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ethernet/intel: Use
 list_for_each_entry() helper
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ethernet/intel: Use
 list_for_each_entry() helper
Thread-Index: AQHZ1EJHL87RnI0+l0CtAkvZX9y4aa/4TwwAgAvTFCA=
Date: Thu, 31 Aug 2023 08:30:19 +0000
Message-ID: <BL0PR11MB35217FDD93FD1A23A26CE8C78FE5A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230821134229.3132692-1-ruanjinjie@huawei.com>
 <bbe87002-aa64-cd42-7920-0bfae61cda5a@intel.com>
In-Reply-To: <bbe87002-aa64-cd42-7920-0bfae61cda5a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|PH7PR11MB7003:EE_
x-ms-office365-filtering-correlation-id: bed2aff6-114e-4105-5dae-08dba9fc82e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OnAPBtRi0EyAtJvwQsUeNSOhv66bZ5AbCjI9MTYD6ePb9/wi962GC38YU44+CSeONfTI5drODCBoYkmVnuYkB/lH+DBxvQPDvCs4PitwwvSPjQkoVHEVfujoDm++WbpXmT9qkUArCoh2BrU66+oI8eAxWUATQv+4dXSplxui4bGQm8T0rbhAzAFsqtL8ELMh+la4Q++RzOYyz4l7oqw1S9eh94jJrefPSgEmEo1nbCSF+mMkEA1kIVrBhSjTZI0+bU2ItLkztkpHtVjlSt8e/tyUvDV4qGyVQuDcOVOHBO4sqK9N7k8Rx/gFFY0uQlvx7F38JT5pOnwYzuhlirYQtlUqVeJ3E0hlH2wGlw9owGS66cOwQ1d11xFZaby0IMnBCncyhBhZ+/7LElwnKP3N2ZORoT9ooe+QubSAXSZQj8db2V+BMtGBQMFPP8p+tpW1VnGylevc2JYmERt5lZxkRTAyCuztxW0g4/BrFve40P7kWfA9oBgX8CAkZcl9tmAXzqzaBi2PLlrNXFn0MWVJ37Cz7sbrNUxgorEQ4SxJmjDspCWsujnJjKvbJ22rFW9amvIm7a6ExcXrVuax2VHacsgSTy5PWwJjCyFdhmgMw5Gs8RP9wNf6/ctmbotlG1vkoXHqjK0Ri/EW5GoW3l0Cig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(186009)(1800799009)(451199024)(41300700001)(82960400001)(921005)(38100700002)(478600001)(122000001)(86362001)(71200400001)(83380400001)(38070700005)(6506007)(9686003)(53546011)(7696005)(26005)(55016003)(76116006)(64756008)(66556008)(316002)(66476007)(66446008)(66946007)(2906002)(33656002)(110136005)(5660300002)(8676002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TVHYohf8O+mzEElc5SHU2s09L5cJ6nu64Yz07wNoVrMu90zrRcYDuB4UCy9g?=
 =?us-ascii?Q?398wL2TvJH+dD9r5hWthjqOfvZRjQRHVX0agkbHtnHNWMiz8xRCdhw3iz8/o?=
 =?us-ascii?Q?y6WvPoG6xwC42k4KHfyXpF4nHYkS9uPzsAZmiTiTsI/Ezm0UDmUeZYkny/MJ?=
 =?us-ascii?Q?dogTYmQR/couvRdCd0OP9zo4dpwhqjk5G4bwNck2fRUQcwIEQdNuX5VTOPH7?=
 =?us-ascii?Q?5gQAODEOU1z+w/ALXkZ9/+R5E9GM1JCGD5LzA6OErq3wVgl9nWiUIo1pPB0t?=
 =?us-ascii?Q?y7HPgpAprP2gMHFwwc4HORmrBzZq3jOtkVg5KJtYXtWYiAxNDu0aQM1CA2aJ?=
 =?us-ascii?Q?mlPo/UMorwmiiu2BMaGO2NIk9YnfWGAnFvwLCioT/m9yAMxSJVGhyyOrZnD+?=
 =?us-ascii?Q?vUpWNMjujBG8BV5TY3cyJKXDp57VYAsJhJmBSJn6T8Vq6sF6V7JekqsFnLZA?=
 =?us-ascii?Q?yhP2uTtFTrO5oxMp+AF3PerJuFtbIke2CS78Ikf8FPff8CKRjdPJ3FspmrOs?=
 =?us-ascii?Q?hKGoo6vwsJQTLhgBxSKY3CABbyd4DaiDbsz8jigLbtIgFpI+SzhDMr6m10Os?=
 =?us-ascii?Q?u+al7rDHRPs9aZfNb+T2VGQh/dHK1FbSmNlC6uNDrO0orkAN+8HAh4wP40sK?=
 =?us-ascii?Q?5tZ5SurB4TReziMRJjGHQeeFjVbinbSOE174XaUId4w5cBpyZxSPi88gkz/o?=
 =?us-ascii?Q?XllUgsYno/ZEWjMVHx+OODMdX6rBycQxCapa30zDtRkbAqJZqpHPuKkP9XfE?=
 =?us-ascii?Q?t1Yjz0A+TZcL2lfWwZaa5S3oO0w9E5aCSsiWQwqAw31POXxu8+/CdwJCC/yZ?=
 =?us-ascii?Q?tZ2b4Um3PadPi+RuLLvF8zYP48Ngwc0rQADHODEEaeAL4EctqNn8HFosefFc?=
 =?us-ascii?Q?9c2WmKJRohIudiPT38zGf4WpGYAfeZ6Wc++nFxDngnb4OWap4QhgjcKY8lyi?=
 =?us-ascii?Q?n4yGuSzzbuGtVxX+9KTfMwzLMy/qTbIEAwdXOq3JnTotHjh0p0ynTk2RZS0S?=
 =?us-ascii?Q?hcXKyFdalGwAdxOlTwzYkHe+HCuckETg2aY02gZQwlNv3LmJ7YfV/mvEz2kq?=
 =?us-ascii?Q?ktLtJgZCjYtpKcKHRId5zeFeTHaL6OqDLcfXb3A8w5sflO5v0t2V6wDfcLsp?=
 =?us-ascii?Q?c0dREq4cvnkdBidb8KvHsvQ3YdFYy9F1Ej/s/XgfgfdZbheJFvKNM2Aqpvuz?=
 =?us-ascii?Q?50CN2RPMg2mnv6y/t83R8z8ZgHpnGUcIS2pqFwaQ34nahbj+JV6IonK1oZge?=
 =?us-ascii?Q?IkknakycGPfNohKGDR3RmWaVq3sh7tiuqyYkY6QnuOUmDoueBaazSDFvrFBk?=
 =?us-ascii?Q?jzyQ6Yzu6VkAtGf86foIofnMITS4HssRFQw0PryXFiTCrdS501xudj1BTHfa?=
 =?us-ascii?Q?SkBG92s5X3iT6c1uV6u6xH0HD3wtH+AJWoyIVkpqNEin+52CbXkPo/KKgObY?=
 =?us-ascii?Q?0QwundNvM7tAgdTkNNM9FMriFhVx1+BaCdUp5vjtY8azBPgPugh90YGJmkVr?=
 =?us-ascii?Q?K02UgHQniW0Rj7ScYA53DxROc8+ID1H/3dnXWJFQb920J9h89hC5wRHk2RyR?=
 =?us-ascii?Q?C9Z86kXCJYBcAqbW9VH6ELMIA+r/7oHqKyQiAofIntitq3mL7aq0N6EJzBGT?=
 =?us-ascii?Q?rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed2aff6-114e-4105-5dae-08dba9fc82e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 08:30:19.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOzTKQFHeyooQ++LPG51VeyqnOkWg4yiIkMQA5J38ONAnGE9X0qf2Du4h73YbX9HgfcCXOa+GblLPxolEWWFswFlJ9HcxcQZHn90KNpXP/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7003
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jacob Keller
> Sent: Wednesday, August 23, 2023 9:56 PM
> To: Jinjie Ruan <ruanjinjie@huawei.com>; intel-wired-lan@lists.osuosl.org=
;
> netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>
> Subject: Re: [Intel-wired-lan] [PATCH net-next] ethernet/intel: Use
> list_for_each_entry() helper
>=20
>=20
>=20
> On 8/21/2023 6:42 AM, Jinjie Ruan wrote:
> > Convert list_for_each() to list_for_each_entry() where applicable.
> >
> > No functional changed.
> >
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>=20
> Thanks for cleaning these up!
>=20
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>=20
> > ---
> >  drivers/net/ethernet/intel/igb/igb_main.c      | 7 ++-----
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 7 ++-----
> >  2 files changed, 4 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> > b/drivers/net/ethernet/intel/igb/igb_main.c
> > index 9f63a10c6f80..bf9c2f6a1164 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -7850,7 +7850,6 @@ static int igb_set_vf_mac_filter(struct


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>




