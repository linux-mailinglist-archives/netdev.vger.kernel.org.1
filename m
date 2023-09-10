Return-Path: <netdev+bounces-32730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C45799EAB
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A086B1C20828
	for <lists+netdev@lfdr.de>; Sun, 10 Sep 2023 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1627485;
	Sun, 10 Sep 2023 14:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FE257E
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 14:41:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EC09D
	for <netdev@vger.kernel.org>; Sun, 10 Sep 2023 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694356914; x=1725892914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MbyDh+qZ+uw+1ZjBTVu12My8VFM0bW2MsdjQZYpVkCE=;
  b=LZALrpiAYsyF4owQGBeNIUTttRrQmWzxB/M65btwp/D+vTiAyW6TC9iO
   MM2MAH5MkvlCGb+IK6mETe4uM0DEcbKmt/P3ulGypLusqlIFJgkA2vySv
   /G/fVwhBLdueB2hL6c+RKz3f2sFU6ScBsmGsPnX5/j952AX8k/x3g2Vnx
   H/1kscL7z/HswIp/F9oemVG+eOb/svk/bYyGJSZK2EedTaWFFi3XjuyAV
   hLsmPPrNh3lEBuAPxtaHKeYA4gSWeC3niIBlAUrSzWf6yZhYQP8b0VK9P
   BxrBSRXA/6sQmtpIl5SfEhfiaiXYwhiGMjClTOv4iSdJ4CK1hTgUYIhg/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="377816572"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="377816572"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 07:41:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="743036500"
X-IronPort-AV: E=Sophos;i="6.02,241,1688454000"; 
   d="scan'208";a="743036500"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 07:41:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 07:41:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 07:41:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 07:41:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 10 Sep 2023 07:41:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxWY90Zq5GxAXPEBO87xWMOGok3PzNvYfhnAs9N3G4yxnDpvcBLiUndWK68degd6e6Y88U4BzW+H+1f1TMB+jUGC8Lajk5my+jMxCZxBoZay8FKhnJ9tWXlNlD0TC/3SUJcvxluLSj0muXCdQnDdHHx5fH6iGAWAgVwDvzIaE8RpL+9uzuDv9gPKuKLtOpCYFkB1FiSmhWiOVQsBGzrWWWteIU22+WibS4WthiT/ZrrGScvn2H6QH1DmWVX2sRIRUVDc3s25jt9smgj8LezlyE9IljCysKdFh0EQKlpGCbza1Oeb8Kz9rhMgjbt9h+ldPxBUi/N9oiceWH/3hziLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMOaD933CcM5919/s7X9QGv4Eoa7t9BfrfY3qUBvLq8=;
 b=HrVllAWUGj/h+2eCsFAs4SS+Y/SumjcNnjHeSFoTfnqZp2ARLLqs+6W82IOKkwSIN5AEcXZ5dbLROuNnJ68LW+rWvS8Yr5CwvE5AQUdd/odV8d74Y4bRyluru+cjAUQQ6K7WFvdg6F8HMh8ccH3DsO7IE+plchvMb6qUI1itnW53UK9OqPymfR3hcbvS5zan5Ykxjv9pVrKCYneJs3RTV2H5hsRPEEKtZW+MOmdv2X7k3TzInjdjAB4CfEJoGy4t6aOfhJYLYKpxC2KWSwxnv/D+SAMSJAayWrc3ftfAGnlunAMQG086si89SuMbYenbgIvHvhjNv9E7JojAIAqoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sun, 10 Sep
 2023 14:41:51 +0000
Received: from SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8]) by SJ1PR11MB6180.namprd11.prod.outlook.com
 ([fe80::5c05:24f1:bd1b:88f8%4]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 14:41:50 +0000
From: "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To: Simon Horman <horms@kernel.org>
CC: "intel-wired-lan@osuosl.org" <intel-wired-lan@osuosl.org>, "Neftin, Sasha"
	<sasha.neftin@intel.com>, "bcreeley@amd.com" <bcreeley@amd.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "naamax.meir@linux.intel.com"
	<naamax.meir@linux.intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "husainizulkifli@gmail.com"
	<husainizulkifli@gmail.com>
Subject: RE: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
Thread-Topic: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to user
Thread-Index: AQHZ4i0bjqcSkAO5LUiiK1NKgim0I7AUIJoAgAAAqVA=
Date: Sun, 10 Sep 2023 14:41:50 +0000
Message-ID: <SJ1PR11MB6180C920CED9ABECC9FD022EB8F3A@SJ1PR11MB6180.namprd11.prod.outlook.com>
References: <20230908081734.28205-1-muhammad.husaini.zulkifli@intel.com>
 <20230910142416.GD775887@kernel.org>
In-Reply-To: <20230910142416.GD775887@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_|CY5PR11MB6258:EE_
x-ms-office365-filtering-correlation-id: 2a0bb7a4-e108-4aaa-ee13-08dbb20c1191
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeydWhLtjcKNn6E3/4NiSvK0e0ZQ4w07PPmlf12/YQxYo/MlKWmpGM8NKmY/A7QFtmF9Nw7Za8l2iwz5QQCz9E4FT0mr+gbDChxLkErbKVDa6KPtXgL0WO6zCt8O341NM43+BanVMcGGGcsTwYi4lunhzyOYE3omnDiYNqSSnggU7YditkxC4cR6vpjYqPTC9EOOxjFCn31ru0iJxtdx6n8YGIJTVQyPTMoUuK6SRYb/qyjZGNgRXegCQ3U5CwfG3+AAadgd5WXRurZNu5Q0FkJ5an83Z4Z/FtAC9v1cGPN57HZoyYArGEntyBkBd8w7EL6aAj9jTbamOiSUXGd1ZP0dFBq6y8znEvHsYasYzQJ0bGW7iV1iqIHJB08kQH9N/VAzktk0nD1shu5LdUYBvz0BScr7VnjhRQr0aIAfj55ZiZQGVc6qXBMMjXphcIko3HiEMeqz3Ct1kG9XnqfwmtfN6mOdJ4Ijm7wzIsSOSdYsLGlD9eAOnIwUoTo0Vy/A7iKLMMWK+PmyUwrFTJg1fo6SlRH5rOPuk4NUmFiPo+oNhdrX7aTo9L4VZR5emyl1kFkpHLxCv5mhNht3/iz3ErG0sj8zgyVndLEI9hQAF5Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6180.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(186009)(1800799009)(451199024)(71200400001)(6506007)(53546011)(7696005)(83380400001)(41300700001)(478600001)(76116006)(9686003)(26005)(966005)(2906002)(66446008)(7416002)(66476007)(54906003)(66556008)(64756008)(316002)(6916009)(4326008)(52536014)(5660300002)(8676002)(8936002)(66946007)(86362001)(33656002)(55016003)(38070700005)(38100700002)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zHvn3Pk84Ehu+W4ZpjFrtJDsDD4sfDSrdamPHnQ7AUltGTNG+KXWllArwB1k?=
 =?us-ascii?Q?lGhTn+BLb5R5P5/II69rvOPc1ODhLOcK1WRucFl47joULkkN0Sc4FSDwI9pm?=
 =?us-ascii?Q?Y/1EXvU6o750gtBw2LzCb0+oU4njtBKvXneavEcqBDpDWnPVNDjp15P8lcy4?=
 =?us-ascii?Q?FBzn3JzEM9Ggl92y0W0d/19juNiPn2d4tka4WCmbDFQtE6jwzBBekkasNhaJ?=
 =?us-ascii?Q?HyDPi3yN6dzKnUowmUqqGsIh/BLILtPWQ6V3Nj3p6jUcpjjj1XOoO6ciyjSv?=
 =?us-ascii?Q?EN1ZKesJDYoti8GLzHOrYZsq513iRLxBdo72vXeh+bBiPPrvJTaMyhMTdv81?=
 =?us-ascii?Q?IO66oAaaX5kh6kRT2BNHOiT26ZdE75Yc/vijLyIQwZEgVYIfBf+EijUDcMWI?=
 =?us-ascii?Q?t+QdSULVqeB6n73UcUGMuW0a8c/L9Z1pRjN6Zy+RKgbXmGHFXNwAil0QdhDY?=
 =?us-ascii?Q?IO/JKhTQSr0Xf8GqSsNvnrOVKxjI1V/JG4SrcAVc71j7X5w6o8Xj9ZUx9vCU?=
 =?us-ascii?Q?r63E3js0EPEXnvrJzMT9kWVFBjetiabfRHMtzD3H3WCPqjQYjlRxkZfPZMZq?=
 =?us-ascii?Q?omuDDBaFuB37Xu3ewt8FZQ+I4h3oMkk4CoLHBVHZr/YebPG2K14tyZgaxjys?=
 =?us-ascii?Q?hVhoJiy80BvX4Lf5E8CA+/u0zvPCG2vqwUJQxtA1dIXznypYQp75ZmS8/xd8?=
 =?us-ascii?Q?bZdLUjaR2xMUgZJrUe7AKaiPflXoh05UuV5QYdTvW8/KKK4U9M2fdepO0UpF?=
 =?us-ascii?Q?+WZboeuClxsloBfWKot9Ygsuh65nWl365+LkPR+BZY3OeFk1/TWjFKgOWXD+?=
 =?us-ascii?Q?SIMb9714VI3bEx7YAKzs/InrEt59TRR/DIsg96Hhvi3v3Aaea+ez+q9guwjh?=
 =?us-ascii?Q?b+liMQDf5jqmIfBF+eOhGnTy78xjJQ7BnOwgf5OUEx10aZMXvCVuwwf7Hkmz?=
 =?us-ascii?Q?X2Pmg28dgtItU9dQKvt2Bmi1vX+xzQQAQ9kCrRKbG7eo502ZgX+J+8WCYR4D?=
 =?us-ascii?Q?yCLngbKGE4nkqyvfUj5D+yYnf9pNzG0rTGrfnSYjQGJzhsBAT755s+dMCEBF?=
 =?us-ascii?Q?8nw6YuluRlU82r9AkKPWX0hx7uxmv8lHwojEda5t4YHUTEt6bH7Z0J4d5ZhJ?=
 =?us-ascii?Q?9uq2qa8WT8t5+xYAmQ3BWlKzwuMn5ATpRpd2+NPumPWN4Z30p9kOf7WNVJGd?=
 =?us-ascii?Q?BhwwVpDADKqpffftAV67V26RVPovBPJw/pnTwRKUsDkCuTuWZK6nS9TpzC8a?=
 =?us-ascii?Q?7uSoQGOTtMlOOTrbJuncnlMsc1+W1T0d8+F8QhNOEuJopkWOgpcNBFsze9GA?=
 =?us-ascii?Q?Jh4x4CQnsTV1vuniLNjcPNwa0YimxT8isdR3hsjWx3DsXvwEHAJ1lj+m0yOV?=
 =?us-ascii?Q?3uA9SNsxRQK/PJHZMMjKGPYYk3qmHys0pO71+DC+YLRPzNXymSIX5lQs4B7F?=
 =?us-ascii?Q?uLOtb3uhCPXUr4PIGtIJhlWe458phag0xKHkjeFetP2F92m7WIepw5x/eGyi?=
 =?us-ascii?Q?ONFQ3nB6LIWj2VEJrZrNwHbpF98J6PzX9phCVPZnLmPMQHJ7IGnQr7SewbCF?=
 =?us-ascii?Q?RDw9E4bIxReT6qowzS2m9f+PMv6JmS3MXBb+4lVfT83Fdq3gOZnMPd6+COm0?=
 =?us-ascii?Q?fm7a+UU6taUaEiwNiiWCprs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a0bb7a4-e108-4aaa-ee13-08dbb20c1191
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2023 14:41:50.6808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzviYm80K8CaAf+k7iWIfye6fK9WmLteLkPQbR5V+N3otGM6P6b9IA0wHEoFDffNHeWKlTvIirB8o7gRmUeDCFOskqvA+qvy8YRz2JUFaalkb3h3dD7O2BLfR0Dp3hGK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dear Simon,

Thanks for reviewing. Replied inline

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Sunday, 10 September, 2023 10:24 PM
> To: Zulkifli, Muhammad Husaini <muhammad.husaini.zulkifli@intel.com>
> Cc: intel-wired-lan@osuosl.org; Neftin, Sasha <sasha.neftin@intel.com>;
> bcreeley@amd.com; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; edumazet@google.com; netdev@vger.kernel.org;
> naamax.meir@linux.intel.com; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; husainizulkifli@gmail.com
> Subject: Re: [PATCH iwl-net v5] igc: Expose tx-usecs coalesce setting to =
user
>=20
> On Fri, Sep 08, 2023 at 04:17:34PM +0800, Muhammad Husaini Zulkifli wrote=
:
> > When users attempt to obtain the coalesce setting using the ethtool
> > command, current code always returns 0 for tx-usecs.
> > This is because I225/6 always uses a queue pair setting, hence
> > tx_coalesce_usecs does not return a value during the
> > igc_ethtool_get_coalesce() callback process. The pair queue condition
> > checking in igc_ethtool_get_coalesce() is removed by this patch so
> > that the user gets information of the value of tx-usecs.
> >
> > Even if i225/6 is using queue pair setting, there is no harm in
> > notifying the user of the tx-usecs. The implementation of the current
> > code may have previously been a copy of the legacy code i210.
> > Since I225 has the queue pair setting enabled, tx-usecs will always
> > adhere to the user-set rx-usecs value. An error message will appear
> > when the user attempts to set the tx-usecs value for the input
> > parameters because, by default, they should only set the rx-usecs value=
.
>=20
> Hi Muhammad,
>=20
> Most likely I'm misunderstanding things. And even if that is not the case
> perhaps this is as good as it gets. But my reading is that an error will =
not be
> raised if a user provides an input value for tx-usecs that matches the cu=
rrent
> value of tx-usecs, even if a different value is provided for rx-usecs (wh=
ich will
> also be applied to tx-usecs).

Yes you are right. This is what I mentioned in previous version discussion.
https://lore.kernel.org/netdev/20230905101504.4a9da6b8@kernel.org/
But at least IMHO, better than current or my previous design submission.

Previously, I had considered changing the ".supported_coalesce_params" duri=
ng ethtool
set ops to only set ETHTOOL_COALESCE_RX_USECS with a new define of=20
ETHTOOL_QUEUE_PAIR_COALESCE_USECS. But, if we change the queue/cpu during
runtime setting, I believe this ".supported_coalesce_params" need to change=
 as well...

>=20
> e.g. (untested!)
>=20
>   # ethool -c <interface>
>   ...
>   rx-usecs: 3
>   ...
>   tx-usecs: 3
>   ...
>=20
>   # ethool -C <interface> tx-usecs 3 rx-usecs 4
>=20
>   # ethool -c <interface>
>   ...
>   rx-usecs: 4
>   ...
>   tx-usecs: 4
>   ...
>=20
> ...

