Return-Path: <netdev+bounces-32262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74951793BA1
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F157281350
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D9BA94D;
	Wed,  6 Sep 2023 11:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57CED6
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:45:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262D81734;
	Wed,  6 Sep 2023 04:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694000705; x=1725536705;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YZvdfQOdudhYsw1rxYVvBOCKztToheRwcyr2mALCPRI=;
  b=HMu3Cn8PE4LRGJmJy98ppMNb3tZnIUgpMVztUz7Zp3p6e3F2A3lpd4oD
   XtuaABSKvE94gOBOR143OgFoikQio1DoQfTsBDkltaHAhSmmjHnTj2JMe
   idueHFLRnu8VkPYS+cmmRr6ibR0+WgjtI9h0SmBTnxTaektPODaPSIqO4
   pPN82VdLghnu4ifInqxRELGC79dW6IhL6eTSgFZrD6yJBeywu3pr2Gp7y
   q9XkxNhOB+oK5GMSZbT06dcp9hf2XFfBNj3gQQ7qFEJZ3Sb+y0ochOD7W
   +7S7g+JAIZrVUgwCNK9Z4urmwjuEf0jNlt5jJnVwSUe2R+YhTLbPtMe/5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463423497"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="463423497"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 04:45:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="915241304"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="915241304"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 04:45:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 04:45:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 04:45:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 04:45:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdaXLCeaZChiGS844Vv+ibAnAPAoKcXeLo5qah6KubLzBSuBdeEl0iSPe2GxL0qiMdqdZ9hJyHZ4Hv8t992S+QCpxvAs+YQ0b8JlTtMEwLG/L80HUoOoBfl2cx2WRLYO54zwa2P039em3Au+oPpaHquYuRu1KRKnMeNMstawA2zWopqdo8cfnpLpjpBlqgcFsc+hGVmzUGA3CLVjO9UaQsgcznqLIPNDv4RQ8zsVtI/JpYrNoZcTmGTY6yFgwl98dIfJx6UDbduId7CNWxIFUDrnsYSqtf6ksaClmX4CBTVCb2YREUToQ0HBLLIkw6OJ9qQ7/0PFRYgIU/C569apaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNS8O1ICD32tp8e4u9G5N3tqidw81LsiOU9CKs7/0Ec=;
 b=UbcApxQDia7I1PHYAeILuf/jfBT+Qfl/eTZhEC7svZpEODd7wwm2hsarxzAJuKHqK6AvC9pz9QDwuFHKVIQdFHjZr1ZC/VR3Lw6ihY12hR008cOclIAQ9bSVe9Hg0Xq9jNjY+xwOsq1Qn9YsiIyeBKzcM8qkDyR0lt0n2PQSZ5otK2vT2PH4k0BIPcNFYqL2QlIU2NTpyF0L3YPHjjKK+nAsNde1OwtWdefOSqNbWThN2SslTjSL9POEBUvs9LEs4UYfNrL/2HZcnnV5FMqZzrGgaN3y/Q6H5TXhU65ZaimwDdFCanPa6p0c+ax05z0P8Jflzq16/tNSyZNWyv99og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 11:45:01 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 11:45:01 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>
CC: "bvanassche@acm.org" <bvanassche@acm.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: add
 support for pin-dpll signal phase offset/adjust
Thread-Topic: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: add
 support for pin-dpll signal phase offset/adjust
Thread-Index: AQHZ4FDbAU6bLbq+B0WxNbnyGXMdhLANb0xQgAApM4CAABVKkA==
Date: Wed, 6 Sep 2023 11:45:01 +0000
Message-ID: <MW4PR11MB57769557F8C5E39FECC64A96FDEFA@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230905232610.1403647-1-arkadiusz.kubalewski@intel.com>
 <20230905232610.1403647-4-arkadiusz.kubalewski@intel.com>
 <MW4PR11MB577647EAF2272B22A73131D4FDEFA@MW4PR11MB5776.namprd11.prod.outlook.com>
 <DM6PR11MB4657497B4D1446F62E3BC5C89BEFA@DM6PR11MB4657.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4657497B4D1446F62E3BC5C89BEFA@DM6PR11MB4657.namprd11.prod.outlook.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|SJ0PR11MB5940:EE_
x-ms-office365-filtering-correlation-id: c9604958-ada9-44c9-fb8d-08dbaeceb42d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0roAGLtXSrDwgR8LRrv2lafnFVaDXO8p7trqhm+saSrfPjNZSjQYUaV3BXV/sD2HUcCybAlbyy8cNUpn/WYELUzTpLDA0b9oAUZYEaKBFtbOvdA64flqCALaPXN5in4kO87L700Poc3cz2INbwNQsnJt+F9m1jFT6FyGv5HD6TQnD+OlNLSuCQ3ky/xYezQFRy0eKmlRvWKJH3Tod/RqK9Hz2ajZS938ijDRoW1Ogb5sJpEKtPrZ0gGdg+83MOvJZzxL/Aut8p8OIqpSvmiGhl23s09dr2QLb5z1IpUUYScI2/V/2xcui7lD93ax/JxVmM/XuDhEhOWI+0qlfTgchLE1Mub6/94PRrgK8c5xcxwE323aCVoP7domKn37IIjRGDGDpL5cSwnZpEoPPsx1+QhAbPJsUwD7pUJJosBkfE44ZJXORFA7z5WLhdJwh+MIPjlcq+TnKsoD7LPDXQIcrNSuPJWfEgMvY4g7uCzw7cjy4Ixf1YfuKmhHsQLgerLKjSGBJy/XLmvaiTQ+vzLXOfaCsGlp0Ldn87OxI3kxEGjs51tdQSfKVJbx29WKO87icCTsS7VTzTvzY0IUoCW0Alhm1zNj0pu5Qe7sy/eLeTU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(82960400001)(966005)(478600001)(9686003)(38100700002)(38070700005)(33656002)(122000001)(316002)(54906003)(66446008)(64756008)(66946007)(76116006)(66556008)(66476007)(41300700001)(110136005)(6506007)(7696005)(26005)(53546011)(83380400001)(71200400001)(52536014)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001)(55016003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?05ndcapsBeqtR8givUXOdV/9TbrK7RGneqbfzbCcMxMapSrvbe8ToxAbpAS+?=
 =?us-ascii?Q?IJGn+I2uCSTtae8fAFRsPmNgWpWFPv9mS3yseflU3HK41JtlG51Gr2fiE/TW?=
 =?us-ascii?Q?qwGWbWhiG42ncrSIW4nby/13JICJcEgVSyfTj6DJK4G3XjKCKpNlFZjJaqOk?=
 =?us-ascii?Q?/AWUTAB4HNCcJoJZicoqXSE1MtHIKqo1DmRVamp5ywAI+y2MmgZWd31wG6rK?=
 =?us-ascii?Q?wtatN8EdBWx6wOHWWkso9mSHCfMKNtq/bBTihu/2JHIqOZ0JWfTVnQmRUjVa?=
 =?us-ascii?Q?chBOHYB02Y/Q3FXr9OkogDRb6E9dvqBLoylM89TkGfIn08LqV/zwFMjt/goE?=
 =?us-ascii?Q?YeloSqGhlHK9V5ctVx+euUO/3T1ronI348C9aeyvqvddWm7oOyLeZeggd4SF?=
 =?us-ascii?Q?j74hdz2e9HpKKE3ubGMM+49KyTFKiyXfvSkQBJEcGntzCVI5dzPL3LvKqm8q?=
 =?us-ascii?Q?TU2zRG+E/4HVm8o8i4nLHdEMSOqjqOVaiG5503zTIWiRU5hRvZigYq1FjlGQ?=
 =?us-ascii?Q?Qtam4ZJyCZGVSmtRvyqr2UR/qDx3V0sYsWuXyutsJz0S3EnAFSffu+1G0Fex?=
 =?us-ascii?Q?LYIO8FN7YZ6HSCo+7zaHJqZsyRkaKkavLVI6I0PO3BP8vLCDAyy6fZIbD2A0?=
 =?us-ascii?Q?hfNaQAabO9dWfPVzR9iW6IozHIQQLhC2xJ0NPN00FWTg7rMtMB+ZZ4MQlepA?=
 =?us-ascii?Q?umbIUjd2Qb3vkOG07CXznhGqMgBUhpbK4jD0ojWr+/RWu22DHAWMXDc7ZYGZ?=
 =?us-ascii?Q?6c01oPeUl107o+/ou+tJV5fPDoAHKpe2W8aVXJQat2c3WcbzjY3udD9KuReS?=
 =?us-ascii?Q?QOL3xqR3WlAt0AACa6uI8sv9FsO4tMwSsn3jv6CVjxtsz75bBDsdGshn9fQA?=
 =?us-ascii?Q?EmZq7wSwhUhAcuCDkLzjn6eJFvY39rhfcbpae3hHKbSSliDZ/L7O2PL09G0Z?=
 =?us-ascii?Q?8T0AInBjQvwDaxBT0jkn9BWrfU9SUnDRL6kLs6SmCtvo/ENW0iFxfCIN1k4J?=
 =?us-ascii?Q?VT47iq5x5PehFnMyoMfZ4awbVJcwrwKYupBwzd6uxS3aFJ64AQT9VfpDzEXZ?=
 =?us-ascii?Q?clk01BVFyLp6g39blBj9MsPMZ96bl/qAsbNob+W/gdXaTqOVrCCGM48MhISy?=
 =?us-ascii?Q?vcMgEkmgXp2o2+b6s02YcKCDbiXx4QtJAfAd4OIZwlILVqc6erfUppGbD7li?=
 =?us-ascii?Q?5lnIa00pjCo/iy4jxmQPwtMa03CdVvaGDaf4wjSPksEmlDiG31rt1wK57i+O?=
 =?us-ascii?Q?e+IwZQ8ndpVLxIx9J0zgCcTBa0qip1THb+iEZvb2KcrGni2LteKmBpiKd4lM?=
 =?us-ascii?Q?xLgALwvMZlZY6inmcFTi+2njPHtjfABD3N7Ln69TQF/0lJCfDl5CHkV3LJAK?=
 =?us-ascii?Q?QYraS2+hiypAbYESjbC7qXhOSTHmMXLgM3lKn6xSRwILB4oGJzJWoMNM1q3V?=
 =?us-ascii?Q?JZndOjrJJEU/wuxyL4taNLKllbBjJpkV//xH4Y8jWNpE7MrRd9p/1AEth15Y?=
 =?us-ascii?Q?GnSqdvyCjEQ4/SFzlOxTNY4dHFV0udwtR8gBmgvsZtFR4hdxdrbBEY19SjC0?=
 =?us-ascii?Q?3TH0/7Or8GFWUBMbhVZgq43T3zYdryLHMfml0Hou?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9604958-ada9-44c9-fb8d-08dbaeceb42d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 11:45:01.2087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HQ2U+bN78AxG/xFoOja0MYBm8fSx1OrCHFkyi/azGG3a05Ey6F4OngCmQpm5fKzHeYcomZR6XlHc6nrTqN/83z3IqpMRl492dOMCv7WIyrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Sent: Wednesday, September 6, 2023 12:26 PM
> To: Drewek, Wojciech <wojciech.drewek@intel.com>; kuba@kernel.org;
> jiri@resnulli.us; jonathan.lemon@gmail.com; pabeni@redhat.com;
> vadim.fedorenko@linux.dev
> Cc: bvanassche@acm.org; netdev@vger.kernel.org; intel-wired-
> lan@lists.osuosl.org; linux-clk@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: a=
dd
> support for pin-dpll signal phase offset/adjust
>=20
> >From: Drewek, Wojciech <wojciech.drewek@intel.com>
> >Sent: Wednesday, September 6, 2023 10:02 AM
> >
> >> -----Original Message-----
> >> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf O=
f
> >> Arkadiusz Kubalewski
> >> Sent: Wednesday, September 6, 2023 1:26 AM
> >> To: kuba@kernel.org; jiri@resnulli.us; jonathan.lemon@gmail.com;
> >> pabeni@redhat.com; vadim.fedorenko@linux.dev
> >> Cc: bvanassche@acm.org; netdev@vger.kernel.org; intel-wired-
> >> lan@lists.osuosl.org; linux-clk@vger.kernel.org; linux-arm-
> >> kernel@lists.infradead.org
> >> Subject: [Intel-wired-lan] [PATCH net-next 3/4] dpll: netlink/core: ad=
d
> >> support
> >> for pin-dpll signal phase offset/adjust
> >>
> >> Add callback ops for pin-dpll phase measurment.
> >> Add callback for pin signal phase adjustment.
> >> Add min and max phase adjustment values to pin proprties.
> >> Invoke callbacks in dpll_netlink.c when filling the pin details to
> >> provide user with phase related attribute values.
> >>
> >> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> >> ---
> >>  drivers/dpll/dpll_netlink.c | 99
> >> ++++++++++++++++++++++++++++++++++++-
> >>  include/linux/dpll.h        | 18 +++++++
> >>  2 files changed, 116 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> >> index 764437a0661b..548517d9ca4c 100644
> >> --- a/drivers/dpll/dpll_netlink.c
> >> +++ b/drivers/dpll/dpll_netlink.c
> >> @@ -212,6 +212,53 @@ dpll_msg_add_pin_direction(struct sk_buff *msg,
> >> struct dpll_pin *pin,
> >>  	return 0;
> >>  }
> >>
> >> +static int
> >> +dpll_msg_add_pin_phase_adjust(struct sk_buff *msg, struct dpll_pin
> *pin,
> >> +			      struct dpll_pin_ref *ref,
> >> +			      struct netlink_ext_ack *extack)
> >> +{
> >> +	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
> >> +	struct dpll_device *dpll =3D ref->dpll;
> >> +	s32 phase_adjust;
> >> +	int ret;
> >> +
> >> +	if (!ops->phase_adjust_get)
> >> +		return 0;
> >
> >Why 0 is returned here? If it's intended, I would put a comment stating
> >why.
> >Same thing in dpll_msg_add_phase_offset.
>=20
> The callback is optional, any driver implementing dpll interface doesn't
> have to implement this callback and it must not be seen as an error.
> Callback that are required are pointed out in documentation:
> Documentation/driver-api/dpll.rst
>=20
> All the optional callbacks are returning this way, I don't see a point
> in adding extra comment here.
>=20
> Thank you!
> Arkadiusz

I see,
Thanks

>=20
> >
> >> +	ret =3D ops->phase_adjust_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
> >> +				    dpll, dpll_priv(dpll),
> >> +				    &phase_adjust, extack);
> >> +	if (ret)
> >> +		return ret;
> >> +	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST, phase_adjust))
> >> +		return -EMSGSIZE;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int
> >> +dpll_msg_add_phase_offset(struct sk_buff *msg, struct dpll_pin *pin,
> >> +			  struct dpll_pin_ref *ref,
> >> +			  struct netlink_ext_ack *extack)
> >> +{
> >> +	const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
> >> +	struct dpll_device *dpll =3D ref->dpll;
> >> +	s64 phase_offset;
> >> +	int ret;
> >> +
> >> +	if (!ops->phase_offset_get)
> >> +		return 0;
> >> +	ret =3D ops->phase_offset_get(pin, dpll_pin_on_dpll_priv(dpll, pin),
> >> +				    dpll, dpll_priv(dpll), &phase_offset,
> >> +				    extack);
> >> +	if (ret)
> >> +		return ret;
> >> +	if (nla_put_64bit(msg, DPLL_A_PIN_PHASE_OFFSET,
> >> sizeof(phase_offset),
> >> +			  &phase_offset, DPLL_A_PIN_PAD))
> >> +		return -EMSGSIZE;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int
> >>  dpll_msg_add_pin_freq(struct sk_buff *msg, struct dpll_pin *pin,
> >>  		      struct dpll_pin_ref *ref, struct netlink_ext_ack *extack)
> >> @@ -330,6 +377,9 @@ dpll_msg_add_pin_dplls(struct sk_buff *msg,
> struct
> >> dpll_pin *pin,
> >>  		if (ret)
> >>  			goto nest_cancel;
> >>  		ret =3D dpll_msg_add_pin_direction(msg, pin, ref, extack);
> >> +		if (ret)
> >> +			goto nest_cancel;
> >> +		ret =3D dpll_msg_add_phase_offset(msg, pin, ref, extack);
> >>  		if (ret)
> >>  			goto nest_cancel;
> >>  		nla_nest_end(msg, attr);
> >> @@ -377,6 +427,15 @@ dpll_cmd_pin_get_one(struct sk_buff *msg,
> struct
> >> dpll_pin *pin,
> >>  	if (nla_put_u32(msg, DPLL_A_PIN_CAPABILITIES, prop->capabilities))
> >>  		return -EMSGSIZE;
> >>  	ret =3D dpll_msg_add_pin_freq(msg, pin, ref, extack);
> >> +	if (ret)
> >> +		return ret;
> >> +	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MIN,
> >> +			prop->phase_range.min))
> >> +		return -EMSGSIZE;
> >> +	if (nla_put_s32(msg, DPLL_A_PIN_PHASE_ADJUST_MAX,
> >> +			prop->phase_range.max))
> >> +		return -EMSGSIZE;
> >> +	ret =3D dpll_msg_add_pin_phase_adjust(msg, pin, ref, extack);
> >>  	if (ret)
> >>  		return ret;
> >>  	if (xa_empty(&pin->parent_refs))
> >> @@ -416,7 +475,7 @@ dpll_device_get_one(struct dpll_device *dpll,
> struct
> >> sk_buff *msg,
> >>  	if (nla_put_u32(msg, DPLL_A_TYPE, dpll->type))
> >>  		return -EMSGSIZE;
> >>
> >> -	return ret;
> >> +	return 0;
> >>  }
> >>
> >>  static int
> >> @@ -705,6 +764,39 @@ dpll_pin_direction_set(struct dpll_pin *pin, stru=
ct
> >> dpll_device *dpll,
> >>  	return 0;
> >>  }
> >>
> >> +static int
> >> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
> >> *phase_adj_attr,
> >> +		       struct netlink_ext_ack *extack)
> >> +{
> >> +	struct dpll_pin_ref *ref;
> >> +	unsigned long i;
> >> +	s32 phase_adj;
> >> +	int ret;
> >> +
> >> +	phase_adj =3D nla_get_s32(phase_adj_attr);
> >> +	if (phase_adj > pin->prop->phase_range.max ||
> >> +	    phase_adj < pin->prop->phase_range.min) {
> >> +		NL_SET_ERR_MSG(extack, "phase adjust value not
> >> supported");
> >> +		return -EINVAL;
> >> +	}
> >> +	xa_for_each(&pin->dpll_refs, i, ref) {
> >> +		const struct dpll_pin_ops *ops =3D dpll_pin_ops(ref);
> >> +		struct dpll_device *dpll =3D ref->dpll;
> >> +
> >> +		if (!ops->phase_adjust_set)
> >> +			return -EOPNOTSUPP;
> >> +		ret =3D ops->phase_adjust_set(pin,
> >> +					    dpll_pin_on_dpll_priv(dpll, pin),
> >> +					    dpll, dpll_priv(dpll), phase_adj,
> >> +					    extack);
> >> +		if (ret)
> >> +			return ret;
> >> +	}
> >> +	__dpll_pin_change_ntf(pin);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int
> >>  dpll_pin_parent_device_set(struct dpll_pin *pin, struct nlattr
> >> *parent_nest,
> >>  			   struct netlink_ext_ack *extack)
> >> @@ -793,6 +885,11 @@ dpll_pin_set_from_nlattr(struct dpll_pin *pin,
> >> struct
> >> genl_info *info)
> >>  			if (ret)
> >>  				return ret;
> >>  			break;
> >> +		case DPLL_A_PIN_PHASE_ADJUST:
> >> +			ret =3D dpll_pin_phase_adj_set(pin, a, info->extack);
> >> +			if (ret)
> >> +				return ret;
> >> +			break;
> >>  		case DPLL_A_PIN_PARENT_DEVICE:
> >>  			ret =3D dpll_pin_parent_device_set(pin, a, info->extack);
> >>  			if (ret)
> >> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> >> index bbc480cd2932..578fc5fa3750 100644
> >> --- a/include/linux/dpll.h
> >> +++ b/include/linux/dpll.h
> >> @@ -68,6 +68,18 @@ struct dpll_pin_ops {
> >>  	int (*prio_set)(const struct dpll_pin *pin, void *pin_priv,
> >>  			const struct dpll_device *dpll, void *dpll_priv,
> >>  			const u32 prio, struct netlink_ext_ack *extack);
> >> +	int (*phase_offset_get)(const struct dpll_pin *pin, void *pin_priv,
> >> +				const struct dpll_device *dpll, void *dpll_priv,
> >> +				s64 *phase_offset,
> >> +				struct netlink_ext_ack *extack);
> >> +	int (*phase_adjust_get)(const struct dpll_pin *pin, void *pin_priv,
> >> +				const struct dpll_device *dpll, void *dpll_priv,
> >> +				s32 *phase_adjust,
> >> +				struct netlink_ext_ack *extack);
> >> +	int (*phase_adjust_set)(const struct dpll_pin *pin, void *pin_priv,
> >> +				const struct dpll_device *dpll, void *dpll_priv,
> >> +				const s32 phase_adjust,
> >> +				struct netlink_ext_ack *extack);
> >>  };
> >>
> >>  struct dpll_pin_frequency {
> >> @@ -91,6 +103,11 @@ struct dpll_pin_frequency {
> >>  #define DPLL_PIN_FREQUENCY_DCF77 \
> >>  	DPLL_PIN_FREQUENCY(DPLL_PIN_FREQUENCY_77_5_KHZ)
> >>
> >> +struct dpll_pin_phase_adjust_range {
> >> +	s32 min;
> >> +	s32 max;
> >> +};
> >> +
> >>  struct dpll_pin_properties {
> >>  	const char *board_label;
> >>  	const char *panel_label;
> >> @@ -99,6 +116,7 @@ struct dpll_pin_properties {
> >>  	unsigned long capabilities;
> >>  	u32 freq_supported_num;
> >>  	struct dpll_pin_frequency *freq_supported;
> >> +	struct dpll_pin_phase_adjust_range phase_range;
> >>  };
> >>
> >>  #if IS_ENABLED(CONFIG_DPLL)
> >> --
> >> 2.38.1
> >>
> >> _______________________________________________
> >> Intel-wired-lan mailing list
> >> Intel-wired-lan@osuosl.org
> >> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

