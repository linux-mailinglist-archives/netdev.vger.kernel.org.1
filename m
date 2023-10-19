Return-Path: <netdev+bounces-42546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D005F7CF4E7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E3E281EF2
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 10:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65345179AC;
	Thu, 19 Oct 2023 10:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZYEqaRm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47D41798C
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:16:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846D812D
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 03:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697710614; x=1729246614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QHsle4fJ4FSXUNJ0D8Fx/E3371+Eb1XCCWn1IQ6Meyw=;
  b=iZYEqaRmpkzBlonWyIlLmpiPBJAIkjgG78RgAnSRo79Big7e5I/lypG6
   LDWXcCSWykgSoxlIF5rerq+PHYhribyh4rMFr1CZXWP0HdC/wBdLC90Ab
   ECVKfbqcNfWpewbuj2pEgD+evVtr+EGP86stW0wAEB1PebZE/8Py4AJxw
   g0lrei5OoomZVKnpfMPsg5aczWVl5YpsFSr7HQcLPg9wrP9UxGfAV7orX
   zaYbNk2aaMoYPEVn7yB2nIpqdTaUcmoZUAErev6oZQulDPqOEfUl/OmQR
   2OsSniCLCuaL78XxQnSwtJlHhFtHG99mA1fbF2611AUydTg08u8sM2W4Y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="366457237"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="366457237"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:16:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750457447"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="750457447"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 03:16:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:16:53 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:16:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 03:16:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 03:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P++WeRSY8sfzNAWgz6+vdtjcrAQsTOQx2moFk/EoSPFHjH894o3HtXiewHLm0zrhe+cxcH5rUfHPjryVGCUx29JExjW+sUot8QDZV5wblscaYwoAitSG4uJMc1ONaUMo6bvUfEzLzqVYP0ZbIfxEeneQ6mY9t+fCcGK7Qoh1bXwSas3t/PDJXYNzSZKnbMBLPWj/pEQXTMADwONat3KQ42ikcI93EzF3NxqLLIAmbA5HKzswxE9z8qUoGZn9PW6eLqTfdXarm/TIujCO4yzpGkqQGxeHiYos/mxhXeYW8WHv9iClM2KwdEDoHSlqpDl4HxtavUG2aR7dGYwP5cRl2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwx4ugVzsb3xtkQfucjfnvVdxTslMkyIwNl995w9xD8=;
 b=dUW/UwoiJPiG2VG5kUWdYJAfReBJfTywX0qtDMPlU+5FE2gXAGFr+burb0Qqqf0G9H/fad1zXYxLIXwMK8liEVvY5FO1DpeuZjffSRhW1xRYtPGFL7mYdIhhKp5banT8nFbXXFyQgK0og4Tn3kLmb8ykmWZ+n2UjTF4Jpnr3JosQBe5llSuIPWjtED2DBnEjTyVILHaCp/ZVi2OUR/dNofWLrAaer1e3wB6gAixAlrJ7lHtCfJEJqMreRTYdxhWNWLuSg1ahDiBgAOalKQM3rwRVN8+rA8ozxb48bjO94cqjppEQeoRnK9SCmixjfptqN+yHGHco49W5mCRtOz/Eow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by IA0PR11MB8353.namprd11.prod.outlook.com (2603:10b6:208:489::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:16:50 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::a2bc:136a:3f41:c858]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::a2bc:136a:3f41:c858%6]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 10:16:50 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: implement num_msix
 field per VF
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: implement
 num_msix field per VF
Thread-Index: AQHZ6fwxRJmRTQCYb0Sts13n/ZcsILBRFqew
Date: Thu, 19 Oct 2023 10:16:50 +0000
Message-ID: <BL0PR11MB35215D3336D5F16D96873AC38FD4A@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20230918062406.90359-1-michal.swiatkowski@linux.intel.com>
 <20230918062406.90359-2-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20230918062406.90359-2-michal.swiatkowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|IA0PR11MB8353:EE_
x-ms-office365-filtering-correlation-id: 4e1089d7-51c6-42e6-1869-08dbd08c8244
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y/YCrtUd3dPiXZO3l8IJD5NCU3poSxZFA+JV6LnpR8oS189suWfwOLUoTF8kJb61LMgG59JoWS08QVykjfEHVilXH0aAzUD1NopsTHqbAzIwH1kFnCceUIBc1XnL1SQdcOpWGI8nr4LdzJ85fafgXirUQRM5HjDWm/dYUTXp+WogqCdHQgr2NsftWsBdAcXICgI/DdmdEREIFN5u9u47kLRpphIsEUT+SqOdsIkgCng/wC3ZIqzprKrY+NFSb4MSQXzXo87Btz761n/BlCCXKoxq535kBL/gOUBE2o5UO7cYpNDjd4ja+MPDkQ4lGql4BWGBsQ25syyE2+94NwKqwTAxcF3q+0n1WVyuYoOEapHBSI04K/GtHsFTe7MjFpEIGWk4uid+QoyHv8yiduhFB0ArQ8EupOAYIKGxJa5badRm0CGOcTHbotalivUpcfbpTdqQzmE/Qyn3sTr5fpPxpiXWJPmxCgoiZRZzrpRiLgFdim8DhcB2TqVr/9Xr1gabhOkkHECSc7OmoeCwOqkuIsXQQL42s36POY+NCawSYb/AhS9hBI7OR4o4WQWeqibMZjXTos35Z688iHGzBbW1CryITVzE9hKptmN2ZFhmZRuzi5L1rnbvCP6d6Me7qQz0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6506007)(9686003)(53546011)(7696005)(83380400001)(71200400001)(54906003)(26005)(316002)(41300700001)(2906002)(66556008)(4326008)(110136005)(76116006)(5660300002)(8936002)(66946007)(66446008)(66476007)(52536014)(8676002)(64756008)(122000001)(82960400001)(38100700002)(33656002)(86362001)(38070700005)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hnz0t09QNwWy2Xkc6WCxVYedUqgUGkx/db3lWT7njKlKYDIP954zTTMP1gYp?=
 =?us-ascii?Q?csWNziMMWj+j9fpm04rMpmxQ6wlLa9XmQ/YVophgxLEw4hXZgoI1d3niiQjr?=
 =?us-ascii?Q?Y6ovo+Hr472XbY41mPj9KDj6lIly/Z6viQN4tT6QBnyoz1Vl+Zms4F2/MabQ?=
 =?us-ascii?Q?pW6FUI3Bn6i7dLkweZQRqvTNguH9QY43pstzTeUPKpWjXszOATUG+JqLVpcU?=
 =?us-ascii?Q?ZN1ihNu11UzhuXlu7IcbQ7bjeUKvPH6jqJKeJ0XO7RHzGlI4006dQtiAsff2?=
 =?us-ascii?Q?8NxLMZgPWno6MIPL4Ptb+BQsbGAp/KWLROl71SsUtXEZTjXsClcJxqh8thLe?=
 =?us-ascii?Q?a+GeVPVFQa9g80p8/HTiye7jtwdFa2f3GPyWn6ZKNOL80HcQxOEmovmnbXrq?=
 =?us-ascii?Q?f9hcuP5hvULyJFq6/IqlJTpbFsiJdmW9bPkCO43pvvw0IW92gX3TVINJWwBN?=
 =?us-ascii?Q?5IEpQI1zweLwQ2CZxpnO42oLG77OIvXGHgFVnaZIIqPnJeopdKqMldRXEeaN?=
 =?us-ascii?Q?s2E39ieQeju0ZXTSTxflgKS5ldr5lqI3J6Xvsv2AxzGlxvCaJz+XJhXxns4J?=
 =?us-ascii?Q?CgAGsQBLNi2qfkNiGDDiZ1PHucCsvL/lh0MPKcwWBiDBVKz+VmhrqBq4fmaS?=
 =?us-ascii?Q?SQXErjARSlUrX8bTX3bW7nOMTJEXVfXXf+ofnDdSp4Pmu+ydbzOvgm4Zf+J7?=
 =?us-ascii?Q?Sxsz2czz6DL/kioM8lrzJiOQ6zRZFghrxVAiBOPRTHbMMj3ox0iE3VzxiWPm?=
 =?us-ascii?Q?qCfuT3RB8FmbftShvTsm/6IGQVFhkXtL9A0X9K3ZwuZsr3XFzYTF6rUXBnqw?=
 =?us-ascii?Q?WB6NdVQU4N7xqkGMHDyzhRFnoR/2Wg7u46iTkrDSxG7s+qHQxqGaFYvPZLkn?=
 =?us-ascii?Q?jhOAYrsv4bygXkdJTzCuJi1hruwpSCKqPje6XwHsa6MaUKeVDx6iIhQ2mbu5?=
 =?us-ascii?Q?cdldRstux8oNYZJU7ifq2dlq50nDp8LvFhl+sxi7E9XS7eIkJeaJnfxmvISW?=
 =?us-ascii?Q?ystEDd+3uujpOA0JTdzdL+E2wveyxGDlc9fxyD495xF/jqj0pIIIwW54xVtn?=
 =?us-ascii?Q?hD7TWyksmnGec7+RBwWtCU3uDPXFIC/VGvlxKCtnxw4UP/BgGYXt0jLUwCkf?=
 =?us-ascii?Q?eLOe2DBRVLkRlL6eUEjJ0dHY4bHXiIBgbMNgAsvK9mWdxpwkdj5L1Sjk06SL?=
 =?us-ascii?Q?PHslYX/pKAANZnaLAD8Ajko1VsWL9r2Q/5+qGxianrRqLM0+ntUYxzqA6Lpd?=
 =?us-ascii?Q?iV3PWqQz94IxDtQn6S/3JtPa5S67UjsqkpUP0g/gww0ozkZ3mtqq3Nj9AygA?=
 =?us-ascii?Q?dchYgoSwZHJhXn71yI6OQhtyc24GnEwpOHVSRhcszIR4QVN7HILfPvoj4FEC?=
 =?us-ascii?Q?nQFFreBdeQUrfkouE62Ao7sjEGzubydwiJlvXIfEIS8ehm3GPzlGXRI9MM5j?=
 =?us-ascii?Q?mBhkggDJUIhQnP0nfOoeceh3OpW1vUBjx8h9nn2BqU5QTbESJOqxhPPzTuCS?=
 =?us-ascii?Q?ky8g8DiQwBL8QpQQMXlPRbudRX14Q05Vlzymli6eeNUsk6JMcLQaWXyBCf0v?=
 =?us-ascii?Q?cliECrXXNTgxTmWAlZkktxNp0l0TMhx6HCrMgSWtvyLQyXwucm4liz82wt9B?=
 =?us-ascii?Q?Kg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1089d7-51c6-42e6-1869-08dbd08c8244
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 10:16:50.2195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/AV0bTrK+UjdY6nlsj0M4e1JtW1YF4Vc18eZeYoWjb2oj2BKDiQwA8iabbAEPoOjSPof5vZpUwITKu1ay8zZCYlzRRIdEDbqJEJqiXsqJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8353
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Monday, September 18, 2023 8:24 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 1/4] ice: implement num_msi=
x
> field per VF
>=20
> Store the amount of MSI-X per VF instead of storing it in pf struct. It i=
s used to
> calculate number of q_vectors (and queues) for VF VSI.
>=20
> This is necessary because with follow up changes the number of MSI-X can =
be
> different between VFs. Use it instead of using pf->vf_msix value in all c=
ases.
>=20
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  2 +-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    | 13 +++++++++----
>  drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  4 +++-
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c |  2 +-
>  4 files changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 8da025f59999..c1e0f84146f7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>




