Return-Path: <netdev+bounces-48258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ABB7EDCB2
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 09:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD031280F9E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90F211708;
	Thu, 16 Nov 2023 08:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQVyCuaw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B174C19F
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700122353; x=1731658353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKxJSJ42lS1I6p+yf5jisCGXPLrfRNk988oc/8lYCDQ=;
  b=MQVyCuawob0GvSJ6iwJ/AtS1vhY/3S5aw+G1wf4hjgHNDrLSpJD3i2nx
   VIE+MDB5AAFcFrmvmLoiDWymsCjeSG4gEYB2kKAvLTevRQORUSvMUqDMw
   AwodxjV52EBgNE6K7Dg/1l/TNEAu9GFNLEZaionrNBAGhVj/upqjuy/nT
   YxiSa+NjUiQprWkyCOI1QXdjOFLKUhIzjn8QwuOCyezLF6MnFNc/D2bcY
   Ug/n7h8lvSTXye2jZ1cRZhcefDgWaYE7NvAPY/92UxGPknlMZLEnJdzQx
   Kc+zMcp+KLmBsOaL5RKuzbI1lIGAHlx5Vfev9qqiA04+RBBY6uf1kxhAo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389897507"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389897507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:12:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="6664073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 00:12:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 00:12:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 00:12:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9MWaRUqG9GDiDq5fZhcJTJQ0zDfR2vgR/66XvvXd4c252tKwHqTalbiweOXTXHqj6YXHgwlDhM4RMz3WGaVs3N7vZvl+jc9ZZ+wycA8wclZuM9j4Uzf1lePU9nSqGrcxydi06pW4EPOycKMm3gR/g/AClQPcVRWT6oLTt7mHbQmYkv0sUgDJZZYkm6xEPBYdrls4x3krLYn75ggPG9ixqJUHwbXAnq04X3D+YQcukDVbWvre/HuqJWzH8MnM2MEGmVnynNiT+dRkhnXtJthG7lgV8eiYXYDKYdtSL7hn0iE9bXTcsVvhCjsdQn8MGkVgZ0hX94FR89+ZJdbWD9deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2BtsFHUr/8bL4+Rv2DxtkBFu1O1Bm287hOqqThtcwc=;
 b=H3dtivpiyLQcpOFSPEFBuBsiVlN5hGG52NsT39DUXtHe0iliLa8giciz3JefjNbLO07G13nmV+FLE7HFlNESQUZ6YLtF9X0g7efnrnn5QxcakJlacdVql2kY4E26kEMjZ06MLrQ86XJ/IFeuwVg0Wu55JgRzcvnXrx8lRI75OxwZD6IHq7/pr9VdMGSo7+ybdKTQLXTS81wjpI6WNhMdjmrSmGZkx4jyviZ35OtfzAHv1S5830d6ae6MacfoQW7ekDDz60pXamDUCsa4nipjGJuViSc2IwZLeqMMHRe0F5Bx7i/TEeNDgDPgKCgFLuhCSH4pSlPgfsKSutBJ75UddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 08:12:10 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::b9ce:466:8397:a2c2%5]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 08:12:10 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Staikov, Andrii" <andrii.staikov@intel.com>,
	"Kolacinski, Karol" <karol.kolacinski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next] ice: periodically kick Tx
 timestamp interrupt
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next] ice: periodically kick Tx
 timestamp interrupt
Thread-Index: AQHaDnMaImjo0vMoS0eV8KVpAlGXxbB8qpoQ
Date: Thu, 16 Nov 2023 08:12:10 +0000
Message-ID: <BL0PR11MB3122D1659273911F86C264F1BDB0A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231103162943.485467-1-karol.kolacinski@intel.com>
In-Reply-To: <20231103162943.485467-1-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SA0PR11MB4589:EE_
x-ms-office365-filtering-correlation-id: a5fd0b40-6fd6-4707-4442-08dbe67bbb4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b/kO9PUl3WanpcQUnOiPzPX2nbJfmfDVMFecoo0QGX29rIxuHCiElRXC2Aif8GnWScHzgxwIh29HtpWOvyOOpHUYaWv/y/eWGbe1tgGVTDbh8ajWwOArAK+K4GTQ9TuIJnROf9ajdIugEcUYZnKpBoOxc8ps7iYgEE7o2OcxiO4W2sTGy62i9kVuqIzCvsKWJaJNid1L7EkMlzv052+/a9d9zTr3iZbK/C+gezGEBVPZkkBM4WfeHYnxgLS0q54MnO8NxuaGnvOt3agsrSxoICfnjoTNyczFOpdr2YmRqv1ufXPVHBzSwBK+EmYgkRfZuz5aZzseUiRqzcB0j+olph9sZXQSiFWMZuo7QZQhQq2uCa45BvRHlhhij/8oHBi0k8E8tQWeApxwnAfiRibomteo/10htRyQUElBnNk876jKwPzgMEeOAfQ+gWyZTMWPzZHIh8eC2awGJYIYAoIr44VYt+x7977HtHk5LB3saB46VC/RtY4dk+ALFOI0ukTRtBak2Yi0RWMy8wK9aZtToeEaFN0vqnAaWu2koN4MaFZxmrG7LsprlsnF8+A+4qUcVV94g2HbOBobDZJqhHfWYI3zX/fxRXaO+qqyUdBpILk63Zup2v2YYBXDR2kyd/C5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(71200400001)(76116006)(52536014)(4326008)(110136005)(9686003)(54906003)(64756008)(316002)(66946007)(6506007)(7696005)(53546011)(66476007)(66446008)(66556008)(8936002)(8676002)(478600001)(38070700009)(2906002)(55016003)(33656002)(38100700002)(41300700001)(26005)(122000001)(107886003)(83380400001)(86362001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Pezzn5AKBbVJcWQGtg2p0/Iwi7Vf1SUtcf6GFNGaV0HyE1Iuo+X2ovSIkfpl?=
 =?us-ascii?Q?fJFVIprmxbkajLCySectxNUWwbVX3R+z9OvLISmX3qUyyhiXOmIz+3qm/rF3?=
 =?us-ascii?Q?eO3pF0r/+QWLA/704Ym0dxRqW7ltUheU05FvJrnrUNmo9rlGGt2xROKQ8YFb?=
 =?us-ascii?Q?/lUeZgwsdmx4hd00VKvV087uT2FBgj/1FQO1cZc56zN3MuQN2Te67ON3rNAb?=
 =?us-ascii?Q?ZO4FxLjE8GPc1OaKuxOZGKFAD0FtXGN9RLhHIGU3qjUWf/UfKgVq96o2fCnj?=
 =?us-ascii?Q?Kz8D9YufN6SfvnqP7FOADyQikaryw7qTgAu2DvNlgqw2LlGxer0xj2icU0nv?=
 =?us-ascii?Q?OfCFwhqhzm/rFUgaEAI+xbGvxy2qKKwzOuu7FTjk/wVY4A0o08NOsFkFktRt?=
 =?us-ascii?Q?30OJ+kYw4NoDV9Ygzvzv7vjk7qLr4DqD0ktmKfTtyC8fuhNdxWY56dDJH4BN?=
 =?us-ascii?Q?sEQQ2pyemd1fBWP2SxLeLDBkH+zPuJupFV+4yl2+3rFlVoN0MQypMyFLKx4Z?=
 =?us-ascii?Q?j2230pTQlNku7kKJKSDSC2ja29FY4MbNu57QnNL2thHnFxsNualCSXUENPM/?=
 =?us-ascii?Q?VuYhmrX2mG6SwJN4kwKrOkxuYlhr3Kb2r+JVSdKX92+Ak6R2XoixAB1Qo5Ve?=
 =?us-ascii?Q?5DT1L1TTFAxj6IzqLD0qligu3wBDQsI/ZoaSfjonbvjYBN8T15ruFm6ffQ7I?=
 =?us-ascii?Q?jBKmkqxKmJ2V8dkHfyfevgoFMKWTy3eoNdlT2Q+4FxIZoLksd/ckyuYdz/WP?=
 =?us-ascii?Q?pAVW1Y7SjwGeMZog7IE4+VDHw6mG2kivDNEWGqLuiL0MtG9iLSe3HloRhMrj?=
 =?us-ascii?Q?lv7yHzH4D09xYYlBGOFng1Pj/Kq3NGWP+zBzn5H4KmVVkuU6At6Plq4omfG8?=
 =?us-ascii?Q?gYpJ63hUkg2U6eCEWKTiDqpYCgUG7kQb+spHY7nFN1/TdLMoZrMXNkQ6U2Ur?=
 =?us-ascii?Q?zt1OaCfNKo3eBZJzA4Y6Ig14PjH8FXiueaKcfDZVb8DbZQpGXB/NR17keL6D?=
 =?us-ascii?Q?jHIwMpce4VcQ3O0zbcPG2kw997dLjSNEHSOLlnUztFcFdu+45ElpxAoW//br?=
 =?us-ascii?Q?B7gWyJJSh95jstWoAxq73ctSYnvi8KwOUgIUUZNmZZ3KO3nfkyUjXP4iBBpC?=
 =?us-ascii?Q?fi+DQgw/ye6h+/ZSN5V8+bebQU1cKS5iXHed9XzIp1C/E1Iahj8NbqAWYuhP?=
 =?us-ascii?Q?qKES4PCTzNKW6NUarIx6fnpHacc0TGPD+Nce6P/xRIVFyPbwUp0kwymvizaa?=
 =?us-ascii?Q?+6Xxj6JFxD8TzuSfk1f0DCFMovVJbgvmbnJy0urhktkm+MCy6vR3/5zdpAdQ?=
 =?us-ascii?Q?q/c+9zuIb52i77Ir1SkBFn/dGcjQfkJb8+lcsY3Kixaio0WlciLuVwCXYwLn?=
 =?us-ascii?Q?9BM2+JuvgizzEI4LoyO14Vx1wd1yIB4tdDHlfCwcjxcCceeXH8lZRd4UCA/E?=
 =?us-ascii?Q?JZW0xdJ4qIOAakBhXN/xvp6AJllU7Gyo3EK9AO2iT30xenIk3EekjttjsN4E?=
 =?us-ascii?Q?ib+PpcuLgy2DZ7EU6CqjanddkDB5ZpQ6egNUjoqS8uLh46D1WMs358s4r7NB?=
 =?us-ascii?Q?0oEAaCJJBtKYM2AkA03uIpZO1sSgnX7fSB4fuw7e3F73OuVQuLDGKYwnK+Tg?=
 =?us-ascii?Q?mg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fd0b40-6fd6-4707-4442-08dbe67bbb4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 08:12:10.0565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzFRqgZY6z8thB9Y6Q3BgZwZ+V5CPCBujy/2l1zd+z+/xP1I7IwvDHZqT5VZmC2RxQwh09r1dE1GaVK3O4AD9Y6lYf1kWkOjlRKsk6ELlShgsgO6kh9YeecBAXBFS4vp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Friday, November 3, 2023 10:00 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com=
>; Staikov, Andrii <andrii.staikov@intel.com>; Kolacinski, Karol <karol.kol=
acinski@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Keller,=
 Jacob E <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next] ice: periodically kick Tx tim=
estamp interrupt
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> The E822 hardware for Tx timestamping keeps track of how many
> outstanding timestamps are still in the PHY memory block. It will not
> generate a new interrupt to the MAC until all of the timestamps in the
> region have been read.
>
> If somehow all the available data is not read, but the driver has exited
> its interrupt routine already, the PHY will not generate a new interrupt
> even if new timestamp data is captured. Because no interrupt is
> generated, the driver never processes the timestamp data. This state
> results in a permanent failure for all future Tx timestamps.
>
> It is not clear how the driver and hardware could enter this state.
> However, if it does, there is currently no recovery mechanism.
>
> Add a recovery mechanism via the periodic PTP work thread which invokes
> ice_ptp_periodic_work(). Introduce a new check,
> ice_ptp_maybe_trigger_tx_interrupt() which checks the PHY timestamp
> ready bitmask. If any bits are set, trigger a software interrupt by
> writing to PFINT_OICR.
>
> Once triggered, the main timestamp processing thread will read through
> the PHY data and clear the outstanding timestamp data. Once cleared, new
> data should trigger interrupts as expected.
>
> This should allow recovery from such a state rather than leaving the
> device in a state where we cannot process Tx timestamps.
>
> It is possible that this function checks for timestamp data
> simultaneously with the interrupt, and it might trigger additional
> unnecessary interrupts. This will cause a small amount of additional
> processing.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Andrii Staikov <andrii.staikov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 50 ++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


