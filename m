Return-Path: <netdev+bounces-26638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F273E7787AB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 302851C210D4
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9095A35;
	Fri, 11 Aug 2023 06:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6621ED7
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:52:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA1A2717
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691736723; x=1723272723;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q648/BF6RkGGYalDxa2FVq83nxfWXBfFR+8m5PIJVjM=;
  b=f3MWFoZ9D3Fz7wqA71zXN9HgLU3+1DwNLLz3Co+6j2ozakzeJJFoHjWe
   46NVKVwYS0Vbjh7wJTlnnSmBu0dqL0gfA54GH8+RfiIQvEz8OAkvYlKQQ
   4lSI4uuf8btaJolimWOhMP65MqxYH9H/KXQ00cjiqW+fd2mB9N+cu7PIS
   cOzxhMDPc/fCQ8Q/WruNePP5SvnaFtL6R2IkQY8A7CchHodGo25MWM5WN
   iOTVi2oVeNLJYFAf7chY1MfjxgCxOXPj7BInKQzOGxMr33IjKLl/0N9L1
   5apIoMHTT+VrIk/Uy3fzguj5QN1qN3ZYJk7tRS497aVT2gKpXTfkTsq6M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437950353"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="437950353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 23:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="979137226"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="979137226"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2023 23:50:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 23:50:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 23:50:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 23:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=equpeptdXCOu6alo3QHrpBHKxGTm4ABMPCob3LWQWZs2fTpBfG+XYSFt3vMpd6bNCiQWxX7x5Wk/OhV4b3aNo5DvnT3B/rQTSsHgADPIz8MKx0lU6DLOGRlXLlHroZvQ0OQhMxdVIU7/XOTA1iY115XXeYE88RZy2uR7zQIghR6XUfWZ88BxYi5RUYJB0O/Nx7zmDtGvO6h0n3YwIGxOXBxXNFNEqakIB6eRsc+iXJqaDSPYSXDn7W6myl/RJARQoCeBUQ1YvXvSiAYfLO0c/bJD1wM2Iw3ssKZhc4f+9+XTSYJnhFafn+ightCNx3Ac+xsW9Q2r1pxDpZLfOzXThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmY8m8BfdhSvyUFliKQkbrZbtE8EsQ7P9jwFQ8tzpmc=;
 b=i2NoQHQntRuRIAYQpjEIALD19GsIMIjxnDk7otS1wNcHeCXtKeltmZbQCvN7yaxuU2bIRxjJdmgZZOvpYqY9oXRL9kcyu+cgtxOJ/YMv1BK7blHsJmvLAN2ArNkclLlBu08b8H1Pr5q3qvs94vAh4aDcbyc55XaofytdBZA5yqvrJFdeI556V99Y6dN6JeAynpxbLkQrRb8/U1yOA3pHEP1FV0ASmwfCh4eyXfCKBgKG7Bg19QivYOJCu+yV9VP8DN8Ngn25FkXPxOy8q/Q4V2GENqHk4s4oUrSn6+dU2weVWl2WpVxI6sX+vqW4WiJgyurvIzv9NZERO7+PpXSrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by MN0PR11MB6303.namprd11.prod.outlook.com (2603:10b6:208:3c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:50:32 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:50:32 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Yang Yingliang <yangyingliang@huawei.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, "edumazet@google.com"
	<edumazet@google.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH net-next] ice: use list_for_each_entry()
 helper
Thread-Topic: [Intel-wired-lan] [PATCH net-next] ice: use
 list_for_each_entry() helper
Thread-Index: AQHZxVHjGoAEsuwyCESNvZTqvKSvja/ktYQw
Date: Fri, 11 Aug 2023 06:50:32 +0000
Message-ID: <PH0PR11MB50130A38F17180956CEBA64A9610A@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230802090739.3266122-1-yangyingliang@huawei.com>
In-Reply-To: <20230802090739.3266122-1-yangyingliang@huawei.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|MN0PR11MB6303:EE_
x-ms-office365-filtering-correlation-id: 31be5343-8ff1-4507-aebb-08db9a3741d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J+nSjhJtLdB1Ijacfrm6fqVCO2bk+h0Z/IvanWUAc85JR7kijKGP/jruJruwkp3/hoaWCTvcOdRIVcPOIEs1TxLfN6WrPYo4QarPhhc7xIR3B14tPs5MstUm95FirETAE8UUjGJ3ESgNcqWvIFcIGyQSh+QdWGBqSeYFWKZ+K/D66048DwNZz3TIJRMUCU3mRuKHcoHGXVlSbK6TvpYeHip06Dd2SmdC451O+y/B2rERZrJtTaJLQuK9h5dCDwYEGx5eJx/IlCB4rIUkQaWKfp9MzgJ3azOb6rzaOJj7kS2OWZftsqBts+5Q41/wMycvOoWhqfDCvunsjXwJwv7vldXcjgrsvFs3HfECg3maS1KPzwQ5DufjRN7AqVpITgA826BQxkg4khbujz57NrDbNp8QEEqKy5q6p9wbAdC46ZOevU8KQTZItA/GBYaIibXAuqWy+kCMuqeitk7nvb01BoOOd6IVHzheFP4G9pUckkQoyHvWkc35oQT1FOsIdI4vf7ZTx87IJV9D2Qg/0mYjdnQFPLurAITYyimgpSSy7iRZ6IsHaTRv8LNmvyEg34yJqKb7tKYwyzE9UO1+90vmQuvVeiwexybEMv70QenkyFxRuvuGvGWIErff3SyxCUje
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(186006)(1800799006)(55016003)(9686003)(52536014)(82960400001)(478600001)(110136005)(38100700002)(122000001)(54906003)(71200400001)(7696005)(8676002)(41300700001)(316002)(66556008)(8936002)(66946007)(5660300002)(66476007)(76116006)(66446008)(64756008)(83380400001)(26005)(6506007)(53546011)(4326008)(86362001)(38070700005)(33656002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uC6kS2du8PUHBF0KYSP6rLC6hJ3rOT6RqZR0NjocKRtNqIpXZJDlLJvuLJR6?=
 =?us-ascii?Q?2msj5nva/+GJLRqjlHN4AMIzqInt70zg7BMKmY4qtNKZegjEHWniYBgv4TZz?=
 =?us-ascii?Q?L6PYR9UIYT1OZ/VWnT75dPNJqQMZ+VEIh67R+h3CxWeIu+l0D/9APtOXzYC8?=
 =?us-ascii?Q?jo5j/6oiUEwcKKGBsIxdyI+li4gZ9j+MFtyX938WEJGts9gR+SARRlhCRu5K?=
 =?us-ascii?Q?qHMMxR52+8muJsp6FcToGC9xhrQuHBRnUsuPuuLPzVwO5Db/m75o9l5Oqqfq?=
 =?us-ascii?Q?Sf/luV+Dl6y2RyFi1mer0N8Rzurz1dxMnixLjzNPviTUZr/0WkBNHFSd+Cg/?=
 =?us-ascii?Q?X4InFdw4hR2ZIhaQJEWDuegji2vTTAXgzm2oMnZwBSNubI2q0t1TJB1tiU1J?=
 =?us-ascii?Q?PHYTJtNQWC0DCNCe1eTCxtZ1OqnKr6RP7kv+POck3FCf8mcuirhmaBVaQAg8?=
 =?us-ascii?Q?wvKsZqeaVi7zIAD9tkWmsVVDVCWgXaIO4oi3H//p/ihINY6scerpWDyMz6/y?=
 =?us-ascii?Q?WL+b+J7/eIFLZw+s4ABvkYMJ+39ZOjTbuAVcyC4D+eRndfAEjU3l5w83Sj5G?=
 =?us-ascii?Q?E/jIVHdpmyFc0SkmTavGeMDIj15fBk++dO20H2P3H1KwkDsZ30qw2KpQjk7A?=
 =?us-ascii?Q?BiSUWvNGKQ7v64tnoFo0GGQ46Z9VxrP/ueefNxQbFhVs8ewWbv/1QpmE5WhC?=
 =?us-ascii?Q?dbzv7CkMT18aaOHI34uMEb2+coPCSlc4O2QoTHU0HlC7r5u72n6N9N4o7ZPL?=
 =?us-ascii?Q?mTJg6a+TPJ9t42nOV/IyPFh6ryKV+vGP7OXJlAOXj7KxDvgXD3tO+Q5CdUUU?=
 =?us-ascii?Q?ld0Hr2m/IkyczQsF6K+SlWSlySROOJkUMJUe2SxjLEymvVCBnXPXfs5EJCS6?=
 =?us-ascii?Q?fhMUVOyVRR1NObTVfqXfiSyfN1BooalkxnWPNx7rjJQDLW0RonxLWsoiU6vD?=
 =?us-ascii?Q?oGJA/me7R9xJpxSVRGialkZf7pJoeAPEWihrtogrhgSf2Nz1upsdcfjoXZwC?=
 =?us-ascii?Q?r8KG1/30eJp5q/QoQ7mUiY9oX/KGrf+UA8IP9TzhVATuSZKJGSJTvGR4kP42?=
 =?us-ascii?Q?7c7Vl6axNEL0c0xKPhdnMUfnw7E/kvWVzN+KydNqJF+mPFIiEjGhWP4frweB?=
 =?us-ascii?Q?+QBPZnuj8SWVdr8wmSS+A9KmRZ0mXNyArTUzlcC1WYytB7WZHnBV31byqhh1?=
 =?us-ascii?Q?Cb+LgpW/ignEdwXUvCy5WpGnpoC83oD/fnF5mD7CmdsZHaFfhukybki2wUde?=
 =?us-ascii?Q?M7z+LepoWC/HPP5FmvObdJJYoKeFAMgo0vkQA5mQEtqHO6gsgFDf5LfIzdrq?=
 =?us-ascii?Q?Gz6lvtAvMR6xYroQP15x51kVr5aXZPa/Vm+CkaI4Liakb7MrBRAT1z7PRafk?=
 =?us-ascii?Q?4uctISu4lcKX5njZ2XWW5zl03OhuxHtYRy9eYxvOHcRhtSldnHhe1phcAzRz?=
 =?us-ascii?Q?0XHcuk/iVJSnTDh6oCqGaB4kbE/m5qxJ/Gj63HG20wTS4rx2wnmRGywhJHZZ?=
 =?us-ascii?Q?wOHqXBceWl6qaHx4ZpD8WRxqfulv+a9b/KsCOAp2Rp+vBQW1xN0wkhjmz822?=
 =?us-ascii?Q?32qt+GgOUW9/BwFJNS1SXZOutatnchsK0CIr2TPUjogj4smo2V5+WbHQEMtP?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be5343-8ff1-4507-aebb-08db9a3741d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:50:32.0926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6goTRH80gmtsS4G/4DBvNN8DbQPyCyWlpWxLSDTeF3lnFSsADPUXkMy0I1RQ+KDSK15tQRIHAbcc+zLRLlygqZVLgsxowP2sYE9nTyRNIA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Yang Yingliang
> Sent: Wednesday, August 2, 2023 2:38 PM
> To: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org
> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> edumazet@google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> yangyingliang@huawei.com; kuba@kernel.org; pabeni@redhat.com;
> davem@davemloft.net
> Subject: [Intel-wired-lan] [PATCH net-next] ice: use list_for_each_entry(=
)
> helper
>=20
> Convert list_for_each() to list_for_each_entry() where applicable.
> No functional changed.
>=20
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

