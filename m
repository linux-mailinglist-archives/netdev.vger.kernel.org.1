Return-Path: <netdev+bounces-31169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B478C104
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 11:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB247280FC6
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B814F63;
	Tue, 29 Aug 2023 09:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E32763C0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 09:12:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2AB97
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693300350; x=1724836350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HCw1TTeDURtJNiuyWebXCBEHkj051qiIcqtYyruCNU4=;
  b=A3sXA581jCDDMbupwziemaU0I5qpYAuhIYg5cZIpbQbnQkXoTNaWT0xh
   bzmNckYoGjPwehEX/lZlV2Rhjp0PHaQYs1Ahcx8NaJf90dnn+TKbltXcY
   F8MjMpYxuiC+grGOhtbQTsbn858hMCQfmqxlad9GodYiYdLvhayBMRsKT
   Bm/JIN/zGjhjboReMazokq4JrStT1NW+A71lbpxk7On5ZlGvKPdVcOINl
   b7P8tYuSqak/AhQbruIYoT6QP/3zo+9yGAyqJS5kYAgdIpECHXgHoUX4C
   rsueg/Cse/S5lkuY9ecc7GnHwQwqpUtHdyDy3zxJtPlgTizUXkjQU5cnB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441669963"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="441669963"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 02:12:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="1069381480"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069381480"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 02:12:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 29 Aug 2023 02:12:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 29 Aug 2023 02:12:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 29 Aug 2023 02:12:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR/IN9aq1K38BP8GcP+01E8wnQOL+6bvyWruTVncgZD/z1tgp9seSU5oWAjFEIBslpB2Jp++xaDQR1CVAaEIURabq4qN3V9eJW2yVWnFJbpe39gUMZHcs2/UHhkJIswbEEc/OCJRDBJc0hPOGufCzIeo0PApib0wPZsUvK3yUkoNUtC+Sf8FTnQy0CindzCQqm7TUfgJbzdPhvZttwS8Da1n33D+EiZfKVI7pjGn34RhOEpx66MEV2L0ZgavjBc9ylhAfR+07SXtc+OTFQOmqmBcMe2CwA8kgSvYfDlr+vTAahDZyjb0VHau8hWqikvgICWophb2UCrIBIlRBV0awg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4lc9D85qJrKN3rNTvlUA5oFOX8bm9ME5zHhN4h5jG0=;
 b=Rb3hocSmtI8qgR94ksqZ3mvvAv6F4rMkSOXbqXL7aKyrxFvx6mBIkEfrMVbcQL18gAvNnRoRUaRZhOjr9o9UKYxLnpRHYujmuBvTbBTVIQZydYvQp8nklkM8hbRINv+DsQGJ8sBxgYRky7gxvp9igZ3xvIBqbV/AJ2QQaRpEW/stU8fqioWxepztbdMjrnNYDRn2+UAGOadR8XljI21GdbcOWrvoxQE0WfiGGCzmInKXEwP0gI2SCSdR83m9OO/YXtZeNTT6JTv6I1WLc5JO9c0piZzLztqlTQS/69K+FRcp9yMaJDgFDjZ36PA38GAd2iJ7z/MQjtbJbN2s7hWi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SJ0PR11MB5792.namprd11.prod.outlook.com (2603:10b6:a03:425::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 09:12:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::5842:74bc:4aaf:a4fb%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 09:12:22 +0000
From: "Drewek, Wojciech" <wojciech.drewek@intel.com>
To: Ido Schimmel <idosch@idosch.org>
CC: Jakub Kicinski <kuba@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "idosch@nvidia.com" <idosch@nvidia.com>
Subject: RE: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Thread-Topic: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Thread-Index: AQHZ1qBBv7SVSOjez0eHlWI2L+3Nxa/6wcIAgAMXFgCAAydJcA==
Date: Tue, 29 Aug 2023 09:12:22 +0000
Message-ID: <MW4PR11MB57766C3B9C05C94F51630251FDE7A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
 <20230824083201.79f79513@kernel.org>
 <MW4PR11MB57768054635E8DEF841BB2A9FDE3A@MW4PR11MB5776.namprd11.prod.outlook.com>
 <ZOsNhgd3ZxXEaEA5@shredder>
In-Reply-To: <ZOsNhgd3ZxXEaEA5@shredder>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|SJ0PR11MB5792:EE_
x-ms-office365-filtering-correlation-id: e01885d1-ed5a-44e3-744e-08dba8700d97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3b9lTHjE3OOg1vo1gBsxaNkNusbP05d0X1imxjzILA/ayCst+WyPMPWNF2vx3ugR6s6IXcjPB+w3QI7s2NmtsuqkhJzXR5fO5owOw5N2A1/0pvlOnsE7wDNn3R4FUXJcQ0Sjdf+TryfrZlBNqhoBQigCpilDJbCi+wxfgd3Ze6vjWOmuQAoeorP0s4iT2xORs97OK+7v6Oj5cggSXtlgl/0A5TKzGcnoDOiq43RYerCQN0cG1oSFk3Y6/qgVFEb9Trj5sIP3dbl11f0OOz7+iILotYrYxrxh/SVmLLmWduoJVRdCPWXMZfvJ35Onv/vrI6TOGBzb1D0Hqwdg8y+46ZOywtUzust2wyAZJRMXo/N2zATX33TVmZLXYUPyN/1VYA51l8vUa4baAkakxlik8tcyBdCinfEWtvK79cd9bbAL6EhEqkRMRay2BHHgngy3mPQtNoxWoAZ9Dlhhq0mwyfpK/ANtEHGDJdRzVFUqWtCOpWYnWGStxL5vry5WGp4iseZcQoQABubRZWAnECWz6x0kNe07nOk7RE2uX9paVgBkhS2/uJ/2jkhwJsxHU9oSyKwxcaw6dNMKx2b2LdmnvJc3zhHeWnK5Zf1ZWNXYXu+Kw7mYAg3ChqDWE1Nl2Hz9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(7696005)(71200400001)(6506007)(86362001)(55016003)(82960400001)(38100700002)(33656002)(38070700005)(122000001)(26005)(2906002)(83380400001)(76116006)(9686003)(53546011)(478600001)(52536014)(8676002)(66946007)(66446008)(4326008)(5660300002)(64756008)(66476007)(66556008)(8936002)(316002)(6916009)(41300700001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UbCHpUxDUCEsq2tTj5RvrjdPePnUT6Q90RAsK5I/itodZ8VOAvsMP2/r5QHE?=
 =?us-ascii?Q?BaG4q8Gc7AmMhfbJ/Q70WheJq3GghX0YcWc7QB7lY5HlEoACNFo13/7R4L5B?=
 =?us-ascii?Q?cVLaiPuW3IdzZTpqOOFaO7D66OU0q4vDOY0NN4sEoJOT5w8mxZi/MXsC3xBP?=
 =?us-ascii?Q?qiOsQvIX+AcJsbUZEosFYZvsenxj6b/NczYL1WKQN/F3sbPFVcShEzA3YJF9?=
 =?us-ascii?Q?GhJE2zK+VQajoHbXdyh514I+P4+Br0fRHCDdpoO739EVaL7KPd+iEhYxwSxf?=
 =?us-ascii?Q?yn1ydGxNdOCJItKLqOkK7I2I2VTNk536XHzoN7GbKrf/5wlBYFzyOlI7a+Du?=
 =?us-ascii?Q?4LTc1GLLRhSEV5LXCJVJ9NLVxzKTtO6+OnTPhe+w09tihfEyuvRH5N6aMweL?=
 =?us-ascii?Q?x4qDfMVVTfaJ8c+19/vqFX4rZ4O0FtPMndPQIgWE9YZ/h1lepaT0ZURWb8HE?=
 =?us-ascii?Q?n3ksTnsB0raa2DUa5zycm9T/sLLuapRt8ylLok3hZLlO7w34wqub34rV+P0y?=
 =?us-ascii?Q?rbVHbqSSG9tRxe89+HTn3USWrdR4oWdtQ+VH2N/U36jNd1pin2ZoAqoe0HCl?=
 =?us-ascii?Q?sidTb2DwtfqWzxGr+hupKKYUCKjDqmHE4SRUWl7sFsQRiF7j+Txjd/Gi0QFZ?=
 =?us-ascii?Q?/IYr7WxH8tWfxL+K96HuAWzUGL1ZIaFcJpX129rGnX6mVxNifoCooQbG8MTi?=
 =?us-ascii?Q?hQVjWBLKLHEz2+kbLDvn7wHA0cV9BFfOKKiv5BR2J8XW4avCCoJrTAtQS2jj?=
 =?us-ascii?Q?ocnLyGgtSja3j6ANHoYQa0V9JuZdMti2t/6h8PJXeKRR6ohmRkX7jlKzwyuK?=
 =?us-ascii?Q?6mLQRPYcxOMVxNw4KGzuyO5kFlio9Ni+wu+1h5wMBkeQiMnCAzKZbxZJmodC?=
 =?us-ascii?Q?RDKYO+EYSDq9QJuqrDryY5+D2exGD7938Bd2JwzYgEbgDllrwkv+eehCixda?=
 =?us-ascii?Q?GkT6d+fIWXBjIxIdb0SC0lg3yLOPifs9iREAd0sTobIoiNg1w1ORwWI3fycw?=
 =?us-ascii?Q?rwKiGIgcM7YGk2EagvjhRM5GdvaA/BD10h0RoOCmisrkT2jjgjner5ZkYfcQ?=
 =?us-ascii?Q?GoPgmXadg90eGSRZ0r877jOVVVjP4qRtcvb7dKxPvuM7fy2cEZdkp3NOgA7d?=
 =?us-ascii?Q?RtO49bOgukJV2nNcwo3wUsxsbttyBmfLxYOLRif3pjXlFYSRIuTEDReBtb+j?=
 =?us-ascii?Q?A2sML+SZBa7hXVME40++8kKgcCxP3yJtFAPJoOQAXGaG0UQBUHslngqPZ/mg?=
 =?us-ascii?Q?aFR36VrNc2AGViACoGpCj7W0NC5ttB5Du5yZuxafxl77Ewkyk4IUtj7f+1h3?=
 =?us-ascii?Q?+Jwl0pQfakyt4joPleHJ5lL2+gAblBfirQ/W4vVGm1272NkSCgCptYA7QgDD?=
 =?us-ascii?Q?+Mgtv2oSvgABRJeY5k6rffiLTcsjwQ3QJ19HCD6CfWTBdumBf3f00Nl/Z8h2?=
 =?us-ascii?Q?bJzbaX53SkPbwUR05z0hkCAZNwzm5vUWNlBfLYuyt3qd5XlDXUOBHG08TFfK?=
 =?us-ascii?Q?Q3ejc+djTY2eDX/rfbmpI64M83lyI3lFZ5ethKIYq2Gdoug1M3TMGjqqVzat?=
 =?us-ascii?Q?0Nu9WKA5tthhSq2ORgWFfiaQ0p3wMUqDMtWLnrra?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e01885d1-ed5a-44e3-744e-08dba8700d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 09:12:22.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pq8hoqHGrhlzpFmsRs/++AgEFK0QCrdqoNIZJAoWIIxlk9KFn5/physQKGwzVTQA+AwJoL80Snojgkyokem8p+3XYQWsqvUmWocq475qukk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5792
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Ido Schimmel <idosch@idosch.org>
> Sent: niedziela, 27 sierpnia 2023 10:47
> To: Drewek, Wojciech <wojciech.drewek@intel.com>
> Cc: Jakub Kicinski <kuba@kernel.org>; intel-wired-lan@lists.osuosl.org; n=
etdev@vger.kernel.org; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; idosch@nvidia.com
> Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
>=20
> On Fri, Aug 25, 2023 at 11:01:07AM +0000, Drewek, Wojciech wrote:
> > CC: Ido
> >
> > > -----Original Message-----
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Sent: czwartek, 24 sierpnia 2023 17:32
> > > To: Drewek, Wojciech <wojciech.drewek@intel.com>
> > > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Kitszel=
, Przemyslaw <przemyslaw.kitszel@intel.com>
> > > Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
> > >
> > > On Thu, 24 Aug 2023 10:54:59 +0200 Wojciech Drewek wrote:
> > > > NVM module called "Cage Max Power override" allows to
> > > > change max power in the cage. This can be achieved
> > > > using external tools. The responsibility of the ice driver is to
> > > > go back to the default settings whenever port split is done.
> > > > This is achieved by clearing Override Enable bit in the
> > > > NVM module. Override of the max power is disabled so the
> > > > default value will be used.
> > >
> > > Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
> > > something we could quite easily get ethtool to support?
> >
> > So you're suggesting that ethtool could support setting the maximum pow=
er in the cage?
> > Something like:
> >  - new "--set-module" parameter called "power-max"
> >  - new "--get-module" parameters: "power-max-allowed", "power-min-allow=
ed" indicating limitations reported by the HW.
> >
> > About the patch itself, it's only about restoration of the default sett=
ings upon port split. Those might be overwritten by
> > Intel's external tools.
>=20
> Can you please explain why this setting needs to be changed in the first
> place and why it needs to be restored to the default on port split?

In some cases users are trying to use media with power exceeding max allowe=
d value.
Port split require system reboot so it feels natural to me to restore defau=
lt settings.

