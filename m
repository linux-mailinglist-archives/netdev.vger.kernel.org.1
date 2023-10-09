Return-Path: <netdev+bounces-38952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8287BD285
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 06:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD3771C20860
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 04:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7989AD4B;
	Mon,  9 Oct 2023 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2gYweQF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B8A920
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 04:21:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F97A6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 21:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696825287; x=1728361287;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hSyHaIOtipSdO3RufcZS3JHwYvi5uJUgn0JarH+X8ME=;
  b=W2gYweQF8BZhyU95LB18K3Pcc6N4+bBJMqhKuWodXnyTLtM1BG55bClB
   o1k68J31c4KbQ6j9grpthd67jDR/emgErlj4iG+3AhoG018KxXLjul+74
   fNRm6M6vc37TIdJli56SQCTNVGVwvrtSRXt1ixikVBil1AD1hyCuj9qbV
   GLzWX0quFjaMhK8U9oQ4eysZdNmqlnblbCmrV8ZTMpVTwsX4oIDq20C5L
   o7PzpTyM0+ayQ2SBwzVjiztavAxev/wAIqYde+n7TuBTtTi/rQY0Wo4aU
   QDTKKz8lpLfsEC5VpWgu+/4ZNRVvJPSPtPgnjugVfVmbRMRL/jdvncEHz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386905646"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="386905646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 21:21:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1084190065"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="1084190065"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 21:21:26 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 21:21:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 21:21:25 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 21:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFNBPlbSB9MwGQlcdSgVLssh/1xQ3SSoUlZcemfwi1zys31Whx4dd66DScS4buXCuSd8y651Bz3Tvb6QVKK9c0DQs/T30RhdqPcxjxFem9/kdbxsNbWO7EYE98UMBHBXfD8dmAsN0pBTLayWBpmifzo2J0RzbytYzfJevZDIWStsqeLNv0fxoIXQpLNpmLkX1swDGoyHtdjq80fUijZYVcfAmeJssld9+S4zN8PdJ9ADZ16f8ul8ZPc43JQA5odiC2/dpbC2P/IV6kq55xgkYKARc/biqQiJRPhWJhaWulhwjgYeefHarH024KBEMcmuQw9I4mPqfSEScPC7CmrYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeisU9VuXOBxKwYQpBUzmDXUckIgKnrLju5fk1WZtBg=;
 b=gVGC+vCfq5vlhczTL72b60BQdvPjYWayR9tZe5pDZwtrQj66+yI+BuGcEP+1u/bgPqpxoNsrGQ2MD2jPO9aUbP/N9xby28GXbjD+FxKYmHQR0N01H2bESBeitbhNuScX7vh/zDvUUjL46UxyJBJ5d9a/RBWwGj1V2GbFwL8p89qbKQCUmPkrN+1H2Cb9isjbJ0Hqkp+pvh9RKIV99VpfTuJeRL47lszv+EJQ1DywZiolag+yxD6PNZbc1EXRLZUjYDTD0WW8Fu2HiIVOkO69MqxZGJZPLt7r9rR8yKcRd2pEm8AARJuxFR4uC+KxRLmxaA07L4H/Di4jlbdQ8rZYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 04:21:22 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::e372:f873:de53:dfa8%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 04:21:22 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted
 variable
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted
 variable
Thread-Index: AQHZ9bsAp8C2Cs6Lz0+lChpHUhki4bBA46Gg
Date: Mon, 9 Oct 2023 04:21:22 +0000
Message-ID: <BL0PR11MB3122C60AEC8E31945A549473BDCEA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
In-Reply-To: <20231003053110.3872424-1-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SN7PR11MB7091:EE_
x-ms-office365-filtering-correlation-id: cb321d3e-0074-42ee-9ca0-08dbc87f31e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGZIdv5vFAT7O/0ncIuD+63IDhuLBw68cZeEUViEt4OEkk9Y11iGDrR93zBL0KZAmmEaa+5nSGrn4E5D8zxgvUw45prtSY7tJoLIAXYLjc5RDukF9C8B/Rh+waIqlA2y2xCVva57eXblyrfoulbdzbvaYct1flzf922JiepjVeXMmoUr7VIPUCay+y6cYpoNQW3LRkb0D37SVhH4UI9xNsDEYMaIgYTxrLabkHwVu8L4nrZ0XLEM1hFa2CLBvdYeFZ2dF5YrtYor+f3c0aDXJfedbUnMKQc0nLW7nZ4DSWtNvp8J9rcbBdY+0m0fk7DHf3ToehJlOqbWIXr5YLIDv7gXcFDhrELEiEvK6u4JEASJ0QXiTKj7glievUe1aO+di2AEjrZBgiN8mxu4lt5f5WRBnbmqu0Nz4XOz4+01/dqHOPG+rvlVc2MvcfHtrmKW1dvZg3nasXefZASgb3UTTE/f1RCJxzG6TzzssDlIZX26Vi2bnBM0hRNE540YPTF3PsdV+QjOONPi8CoaMuRnv4muWEyU9gzcqVHPF8SCgUyNVzoZSBIHwbo0rxz5jSrkfcP8pKBezqaEpgtxexfCmfPuzHaxwmob8NP3MlfIKp5XgNaYlwCnQIl2M/N9QGhi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(122000001)(38100700002)(38070700005)(82960400001)(86362001)(33656002)(55016003)(2906002)(9686003)(478600001)(41300700001)(52536014)(8936002)(5660300002)(4326008)(8676002)(7696005)(71200400001)(53546011)(6506007)(83380400001)(107886003)(66556008)(66476007)(316002)(64756008)(76116006)(54906003)(66446008)(110136005)(66946007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vQrRk9iqbFQpMy55j47799321gX7qAAgSYFkj4FbsJ/ak7l98VrOH7rR/tEh?=
 =?us-ascii?Q?RJKLktGq1b7rgUJp8Lp61YZXSpcwU9UEa2ZarR9ekC03FfPyaMCygYEZtA4P?=
 =?us-ascii?Q?okjkrEziTRwBgvF+D8VjrDD0xtHCiVf6U/H51ra5ahuIdI/VYwXUi2GjIxKG?=
 =?us-ascii?Q?DSAfNkqs1CxIIhD8W6U/M7fEx+/DoUJNzgB32HbYAS253QAPD6SaxYRNjO6j?=
 =?us-ascii?Q?8jqaBG8U67gumX4g9x5gkM/LGbp6ILP39uzysj/uVNEqKFdK9pVCsNvyCdyF?=
 =?us-ascii?Q?oIRjuZugRKmoOYdYH93h9Zqs0fa1OxvgmYhO/J302L4tJiTwU3PsDE5Z0pB7?=
 =?us-ascii?Q?bvyfBlHleYtOuYL4QsJJv3tDTxi6OgsvF9RBXpsfUMS7VCUFUW6DyYRfMrvV?=
 =?us-ascii?Q?x/oUSJ7cBCz+7Np4AgTb5JPAlcz0rK6KAdQcxk0reItrNFR3nxpeptX1CgT5?=
 =?us-ascii?Q?UgsALep5o4iwnCBs/m5lGUmcYqEu2WKN84TeWojSikt+2T2kV57MMcUA7DRZ?=
 =?us-ascii?Q?tY896hMxh6vKrVvU3+NZJv/5VZVkPSOpEHPbuDeYZNEIhhusaiVDN3IfhbJU?=
 =?us-ascii?Q?70v0vYPUhhBqSXvSmTW+aH9CaFQSAN5KwQdHfiPirlu6uNNEXP6qLXVwy+yB?=
 =?us-ascii?Q?3ltuRDkxSLqBbS1F8kU/NExcCXs2OG1vo4QdPBlbiqiFRD8ZwvcquZNOTWJ9?=
 =?us-ascii?Q?dKf30UxInX+BZADZ7bRa/3hU+BrY6i7bF8Be0qZ1/Hcdj3gDQgRJ74HIUUvN?=
 =?us-ascii?Q?q5HtNCA4vBf+lVsqt/uy4oktffPQwZJgEKW0xKYxNYd1NMwvRpyeCLnx+6CL?=
 =?us-ascii?Q?2LowXmau7ADypQtvzsv5DcUISwv+Rmj4dei7WS4QED9dCpaDHLZCLJgp2nPv?=
 =?us-ascii?Q?46EZcfKjx/eq0G9F+0ZPpdvh1m623EoRmWDPMNsTEemXBXwWyzhUCUzB0JzB?=
 =?us-ascii?Q?f/dkEtvRIn5ZpVzjzS9Qek7k6y+mqzIR3LLWlC2QJfdMZECmT76dncaTox6Z?=
 =?us-ascii?Q?rVAWWqca3x66Cnsa8Aoxc93BSJDkIDHU2oAH6WfZ8MCuieGSFBh0lP2J1ntZ?=
 =?us-ascii?Q?2f+5s7kUSbWxxP5oSPMxZSlHBVqfmzbTx4+YXmmA6TB8wjhWMt/9yfHao3C7?=
 =?us-ascii?Q?uvq4EqsWtmbKl3GotY10LUTov4DyRMGTZ051bbB9o78ko5VjYeEzAdLrj18B?=
 =?us-ascii?Q?mbUa+9gExB4yAtnUR+Z9yvKUU85DC6xCInxb8rHMQCiyDEHdHYA1EPcoNEMn?=
 =?us-ascii?Q?8iWALwPIueG5te+7zehTQcdrlWjanxZS3cOiaxQebyQC0k7sPyWuzY4Y+RRz?=
 =?us-ascii?Q?phSGJz+G8eHCIU8zoMIHS+PEJ5BRnQOo1Wby9a3w7pffEDGZPrcGq7amNYc8?=
 =?us-ascii?Q?31yK0bCkxLTZTanJL/ZhS67SYu70ZnzqglNBQFzkJ9Chnf4lC0SMzMz5a4m7?=
 =?us-ascii?Q?OvpUheo5M2BfNIg3oeKXJOufSzYzZKtBRLar3UkLVMc3Vii1+kNVjytFAvLX?=
 =?us-ascii?Q?JxcNZYDrai0Nt5fktNOFNoxb7tX9HWMXBT1pwEVEmU0aPZsycvGvNGS1ScYp?=
 =?us-ascii?Q?dC9oG6g2XB6nA7oG2hZXaRX1+KaA6shh+6Y9jCWhPk8mMZf49l78Tx2khDdN?=
 =?us-ascii?Q?l77sbtuy14RCUNeQiTjKmLs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb321d3e-0074-42ee-9ca0-08dbc87f31e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 04:21:22.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /zku+g+3guVSw3C3lxSZWAbaf2kTtrszhRdFYsoUBUWBY2ddYcCSP9EDSdpm/71XlRtHnQbijQbw1ynd2Vdvl4gwx5XUywT/Y4v4N00T0TSpMGY8tSVK7HYJ4+/QH+Gt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Tuesday, October 3, 2023 11:01 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com=
>; stable@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.co=
m>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] ice: fix over-shifted varia=
ble
>
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
>
> Most places in the code got it right, but one line was still wrong. Fix
> this one location for easy backports to stable. An in-progress patch
> fixes the defines to "standard" and will be applied as part of the
> regular -next process sometime after this one.
>
> Fixes: d76a60ba7afb ("ice: Add support for VLANs and offloads")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: stable@vger.kernel.org
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


