Return-Path: <netdev+bounces-44256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B769E7D7650
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32361C20B2B
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B5A30FAE;
	Wed, 25 Oct 2023 21:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuTioije"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B8168DF
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:05:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E89137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698267955; x=1729803955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CNLUXanR9PdSF9zYDdRkxxnBhb2fVgE8e8wXe7bdzgk=;
  b=VuTioijeem1f17HbGcJIqxq2aU2lR/MdqboRDgfPysealUFAMO8JdEha
   PgsEblx3nDq4G8kAJhv1q/hJdn/JdgkMHDr8hq+j9ykQ2G2ygUKszLgvy
   ucQgtYpsCbXrRfRYccphTXiwg/XHjNE4rB4BfXfXR4WqgqV7k6NNg6291
   HrLJzye2XMpvrOZoSgNqt6rQ8a03sjkE2e2E+Gh+Oa3DyU0chLtDodLWk
   1FusrGkVhFsE09CRxXOzdc+94FclQajnVOCCF3A8dymCaCiNdu+JOy003
   AWPsH7q8hcj3DoSidcai2XKAq8UWkObFwC7K0NxuadlXZbsgGpxunUP5P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391272220"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="391272220"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:05:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882574910"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="882574910"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 14:05:49 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:05:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 25 Oct 2023 14:05:48 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 14:05:48 -0700
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:05:41 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:05:41 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Chmielewski, Pawel" <pawel.chmielewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 6/6] ice: Hook up 4 E830
 devices by adding their IDs
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 6/6] ice: Hook up 4 E830
 devices by adding their IDs
Thread-Index: AQHaAhp0i6Wn1gDyIE6/qCyy2PNBLbBbCPzQ
Date: Wed, 25 Oct 2023 21:05:41 +0000
Message-ID: <DM6PR11MB4218E5F957EC4942D5A37C3082DEA@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231018231643.2356-7-paul.greenwalt@intel.com>
In-Reply-To: <20231018231643.2356-7-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: 417f4bd7-a87f-41df-1b70-08dbd59e2562
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxj9N16U4VzDjOKsgGN/HYXwESOrfLLsSv3id80IDyNUcPAAK9l2z24Oz36o/WCuTyFEDnqko2jHzjGzjcMwrtYteEbyo+V2aZF+b4Q9PbLT2vUMMT+f4qDrN+Fc5pQupfnhch4dGf2df6Kd9C4mwjpUG8nrUF1p4hj6n4fzDvkR450UtPkMiDt82YXsef6j2fv1XtXxy/RN9tbAZ3bc+Mj/JPbhbhznZhXjg6S+kJP1CDpoaRhEA91iFf0DIuwyZhrtmYpZCLhyDHxnF6Dbmih85bWJr0V9jKpstQvC0SCr9UFVS64M6uvWTsw4SUpDdP8At0hIFjRw/8K7hEs6vj0IaZO4IBnPL/Ip7FoW1LlnUn4IEd39w2s+GXJpmbfqhDlm8lO+Mx7f1wD7KEqyI+1Qrtwxt9Dlje8Pj3z12ktpFzN4qLJHKAS1TSHGP3gnWD+eLtBMw7URnq/DZTbLMhpRDCdUoD1O03JFmDefJT/LWlGLLl6mFXrIcNuqdRob8fbD/BYffvK40CV1T8B+fQWqxk7evWKYGygETvyYZ30mjts/2bWxb+wZbs08rCodKceCd51J3yIGLKrBAHXBEdHkSCcoqzkqDFr2oQ6BMUd+C2lmxihJxh/bJblITkZqJuMTo0wDW51gXAPcz9HiMgRsCghpIPauPifI1S9TxiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(4744005)(2906002)(53546011)(55016003)(478600001)(5660300002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(66446008)(52536014)(66476007)(33656002)(66946007)(6506007)(86362001)(54906003)(71200400001)(110136005)(26005)(7696005)(9686003)(66556008)(76116006)(82960400001)(122000001)(64756008)(83380400001)(316002)(52103002)(158003001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dEHhLFF8Yaw5Uz3FTA380tzH6CsK8VoT4HXvC/uNfWaN1Qf+axCpGrJatEW2?=
 =?us-ascii?Q?bGCPPPKchMLF0WQf8VTAcs5hnpb10HSncuBgenvZEsPVuoCORl922g4loXpJ?=
 =?us-ascii?Q?uRPYJdiANx0Vm6vsEYKOgmEq20HeakTbecHXN+7DIfGDJgZSpsHuXLprygol?=
 =?us-ascii?Q?JflQNcAzl+EcmeLd1We4sNT6igYJ6rYqBdbr7NfgXzEHCG3BJcCH0FYgv8L7?=
 =?us-ascii?Q?PXp8tTGfeH2Jdu7oGUpa9HZh34tMXpoVZJy5JjMT3hOIplA+xD0DsGcHXcmU?=
 =?us-ascii?Q?38cI7kCpPS3FMisP+YeAHCg3w625haH7C81EYJ3oYpJWHDCNpLlygYSiKpR7?=
 =?us-ascii?Q?G6Yoy2o6llDw0rURmCw3dFdcYnzvdgki9sIM4Y/r6peXViM/rabOjm3/d5gW?=
 =?us-ascii?Q?g9Z7Lxfo3mf1/RSO9VJX0SnPE0IRZc2blErIygnZUWBl/yRuNvhv7B/VsSKN?=
 =?us-ascii?Q?MkDtuUr85u5YY73+uqRElXDYIlV6b6OOq4C5dHvzbNvfq6Oi/4hQPP1/wiaq?=
 =?us-ascii?Q?CVoG/Z0FCVymmsF+0cCThTTiZ+kRilj/7FOhSZB1awR0cRl7yDEIYPGRa0vC?=
 =?us-ascii?Q?x3+wcI1UajPvWTXWQrHfZcphjdM4kcDtIAvl/3NMTA+lYa3/ecX7YACXKPqQ?=
 =?us-ascii?Q?0z2XsrVbC7KJTkcKu98Mdssa0X5Z427ZiwqAq8ydA8VCzxq75nMSZ1kVNU+b?=
 =?us-ascii?Q?n20/eyZDDnIF+aQ/MJst5Ji9wAlBjbbjbaCgr7XnyOl2lurSxjsDsP+yri1d?=
 =?us-ascii?Q?LMOv2D/46/XFAxpwdZ/aDcSUnaJtuHz3l1BP/b02SqkHhdFkCVjNFFqqss9v?=
 =?us-ascii?Q?ueSJGPKL+KnsBnQWxF/uIlB9/gEXHxlJT/WQla7MEVC40CVZghu4RtBc+iQ/?=
 =?us-ascii?Q?6dGYz9K2ysOyNJGFXCn77MPkzWpeeTPUzwcs82ybjHqadY/iSYgxxTUmFT57?=
 =?us-ascii?Q?jPPTm/VV1XarQsS1QTAz+n7qlVpsVXgQSa5uhdSviXi+yKkVo2sPcX97JB8D?=
 =?us-ascii?Q?a2aLXk0iRCJjZlq6/ffVc0Cn6XaFSfrCmz4O82vq62Mk13i7bR1M8G5Y0x2s?=
 =?us-ascii?Q?nUf7zGAD0gxM/rsaMnKhzxkhE9zmEbyKxyOn4iF9avXZJHWCYWRTLUz5cFu0?=
 =?us-ascii?Q?10Lw4y+q0+0PLfY4yU72zH3fnGcjDKewQGfY3N91XRZFGuG4U6zLv/YSqhFB?=
 =?us-ascii?Q?XhvVW9QrB3cSIngm/VVj4u/FVJhp9SaeFyop35U3eukeqCnvpEp2G916ZMiH?=
 =?us-ascii?Q?GLm5d0Q8SJ2fvEIrPm1FuBE/Sg3fbFPstEJIFxav+irrNxUmXoND+4XTkjDy?=
 =?us-ascii?Q?dvemd3odDeLvAjUK4S9ciwKTXzLV7PUMQ+XTkqbI4Qi1xLhX5qeNTB/uN13M?=
 =?us-ascii?Q?sHTsRhx0jbGY4OL1/qSA4WH7or+NWLfz/v27KkAxVN/s6NaV5yd077AMGiuH?=
 =?us-ascii?Q?KnKaGNkcHvqmU1tRMICKe38AFXARDafvTOJ8b2pWigKu4UfjIuCb7lfLURAh?=
 =?us-ascii?Q?FrXqZW1QqfWscQxPAJJxJGbq2pMTvbq2ZPFjHA5ocyC3G0OQk4BYWOTYpY2x?=
 =?us-ascii?Q?f1MzZA0m3tjucJj8hE2FxDp58aNzD6ipXATh4+9u?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnN2qo5z0gQXmSjihxflxF1A0PzjPl9w5FyczAatC5ibNMArgWhNrOC67z5uuaCPd8miiRb/zKWDq6ke3z6gXJGaFv7ijdefrMmR1rJ5NKITI6o9hCnYBZOYrsxP0HvWJMsJ/8b9aB1Wuty9Nq3dXZdxM1KL5D9IDrR7DQtb1mxDvDWs/SmMjl9V+AGm6wKn9Jy3skxkimFHzgenk3F8OM9oucVw9Age8bMqxTah7amvi2n9boR1KN+Gwmp2+3JwOqeUuxQrBtAeWMeoVCMDtH2RGqrJj93tG55cUBHZ39u0033ZL5JfOkMRSzgxlaTB4NLW+rJiy61tt0mNu9Rrbw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaHaDbxZ8n4yhWum5dDyxEUk4LNdCcEVMax41AjXJis=;
 b=Vdy5oMONmUDOxsPVRdLUV3X/mvVZCa3Sqs4KaFkWeM2Hrb0CyXMXAFKbum3o0nvchLXPHeV0sCM3hwiW3Uo4hbIXvYGiUi7pMRZBTUaWi3fqz4qBFZ6qZ++h17H6i5jyBb4MPiQEVpqJjLytG6Zp3H/tli4BeRWfOqA/rqapcJzhU8mxlane2zAPXYfOrzuYq4vxU6fxiFxAYpqD1sU0yU7Ffj6hfwwXBBsNk7ANm6/zeGriFiQLOGsInYt6G3ULCEEmmt+hgmpd18H0x7eVJVAojmYZ7cHAkAEB49WL7i8GbBH/9zCf+6Kkzef66h3NxBv32vVoCjmqIq3za4zbMQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM6PR11MB4218.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 417f4bd7-a87f-41df-1b70-08dbd59e2562
x-ms-exchange-crosstenant-originalarrivaltime: 25 Oct 2023 21:05:41.1310 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: Dqs39Df0EfE/3AThxP8Bet8Q2tyo2y9pHTwbMPtw4B6IEKwBACWbCl7NHBKJCtH0OQ/OOaQC/fwRsCfBZqpOA2hskgqQmx0/XDfVHjYOaJY=
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR11MB5256
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
aul
> Greenwalt
> Sent: Wednesday, October 18, 2023 4:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; Greenwalt, Paul <paul.greenwalt@intel.com>;
> netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Chmielewski, Pawel <pawel.chmielewski@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; horms@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v5 6/6] ice: Hook up 4 E830 de=
vices by
> adding their IDs
>
> From: Pawel Chmielewski <pawel.chmielewski@intel.com>
>
> As the previous patches provide support for E830 hardware, add E830 speci=
fic IDs
> to the PCI device ID table, so these devices can now be probed by the ker=
nel.
>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>

