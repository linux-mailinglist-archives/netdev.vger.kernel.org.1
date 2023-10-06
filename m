Return-Path: <netdev+bounces-38674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538027BC16A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 23:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D52281FF9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FFE44494;
	Fri,  6 Oct 2023 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G35Sqwuf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8631A9B
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 21:44:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC222CA
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 14:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696628650; x=1728164650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3DHhp92KHTfaldrTUEO4zn0odOuW1cZPw+pa0QenWlw=;
  b=G35Sqwufsx/uxljlmlAUr9lgfTNyWuu1HAvlDXgD+85Yf9NYs7s/qVlO
   HrQzzeovGIMl4c39KezFPZs0/RLMamWhAfXh/AninNL4mG94rzX6hn13R
   r8wYCjAAd8jXNNJkmuOBXu4o0hZ7ks9safJF1CG5A3h4ky1ARkzQ32wjb
   RAXIwTaN+GdtZSata0yCGM2AwofPXJM5G8GR8kB3+aF5a1zHwHP8bBh1a
   ixC2cLh7ER8Y0P+057ogzDL9nxjW4YsuGXDyHh1fxxt4IrABwZ1ue0Ld0
   a0xXxswqFgOXBcxOSJIvJHrAmiBGkGfIbyvT/HS/w2drAlcRgxY1vbDGz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="5394371"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="5394371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 14:44:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818144995"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="818144995"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 14:44:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 14:44:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 14:44:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 14:44:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 14:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oO8Pjj0Xe+5gZttaaXtsxsA3JPXugv1vRbKqxjcI70Fca4z6j1kiVYPn933ru97/YWLfYlALXojvwdMUbhbYdZ5quiBv6ZAjcZtBbe+0eEUwDoCQ79YriWv/t4JCCGpc8VfBk0hUapJj89jsivnJB903GL2JRLDemMszz1jX3a6opzIx8v+IRGDizRTvrNC+Ri8vbbPu/VFAgMPDZoJo2RsHSHqdwFFHfE/UMB9Q8fAD/1NeLLrFtF0KdiNQX2+IPolOVnfjVOGFfqsMxS86w9qv69JEM0hZcj7HYOWwuR2Ev84jaUE2PrSqmwt/i1R075cMn3WMaOwZqIsTtCiUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+cU/JkvmdDFNPcO7JRgMSLjScW/89Wr+We+NXrOASw=;
 b=Ha3HqUHMVgK0+8vTVonWmwI89DYK4QSpQpL0SDstdvWocYUyST/5BjCwrAuK4gnWA+j75QCsIeZ3935JJidJd1baLH4Y1W7OZUvw3Ri/wmrbbi08KNFdwmzuE4fZbef9CUN/ISzL52q1rMbnGJjx5pQNPvpsKRJNJvU79WstbVf3FVHCXeosgmunscsnRx3m152uywob6r3+rMYUgyg5QiHHG9RMQLq+feQJcVYDQyYZCWYT8FJM2g95rTCUYYjO/zWkC1dWA1T5HrvUYA5At6z145unUvGo963mietr4y6EjRKze89OLh/e/YMm60RLYJ20RGRyf6yFYpey0mX5gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Fri, 6 Oct
 2023 21:44:06 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 6 Oct 2023
 21:44:06 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "Drewek, Wojciech"
	<wojciech.drewek@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v1] docs: update info about
 representor identification
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v1] docs: update info about
 representor identification
Thread-Index: AQHZ+DX2kpHqfOnzYkGcHNy2wU1zjrA9S+CA
Date: Fri, 6 Oct 2023 21:44:06 +0000
Message-ID: <CO1PR11MB508956381074BCA617762373D6C9A@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20231006091412.92156-1-mateusz.polchlopek@intel.com>
In-Reply-To: <20231006091412.92156-1-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|IA0PR11MB7743:EE_
x-ms-office365-filtering-correlation-id: 6eb03853-8559-4e7e-a3e6-08dbc6b55d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPGeDANhb28GUA3GxeLHHgJsBRIVePKDQ6QjJZIyWryDHYHfdWg9CcHl/Evck980LsZPPI8Lj4hld3ki1u0S8AOeLH3EU8k4fWijnSTJX1UssdYQLMbmFI6tPdYwzwbwlN7jbDhltkiz8brkGog0KE064ehc9v7TqrwttWyeJA5ahSW+vTWJ2GIIqnQSHqR7pIR8bB+I8WWvAIslbkhhZiwUs31DvHVZ/PGzrtTtlUM8nyiPJlKsoHj54fqoln1NdDZfMQK4h/v2KEl7EP09CedgjU9ncUKcj8VeBQh0O4taEfP3mAmWMTmicAWKVWoDZnXt6H9IWG4y61UgH1BUhaa9RArAxNO6ATssd4ybdty4Z/Z05PtjxnE5H69xLZW7k0vZ1ZG8GT0Z97pkd0K0+HGqCnbTsRyyq+FAzs0AaTfWYEZhkLArB+YhCosN8te/vd+aHIV/j7KReIPp2JHMl+uV0ptG3TP6gTpVsjX2hhv2PsPUZB1Rzezrs6ki15Kzb6NcuT9qCwUpGSI8MwVGwcSt7Yrf4xi/K2/pZ0+JNtVz6ct+vMBFG+vcT7biMF1lcFt8a4vjQKcjY4BwCk8rGx4PHvSFKnnM+zvH+jwifPln4ZLaN5ozAdUJM6E+7O8w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(52536014)(83380400001)(478600001)(55016003)(33656002)(9686003)(122000001)(6506007)(7696005)(82960400001)(107886003)(53546011)(26005)(71200400001)(38070700005)(38100700002)(8676002)(66446008)(8936002)(76116006)(54906003)(66556008)(66476007)(64756008)(4326008)(86362001)(110136005)(41300700001)(2906002)(66946007)(316002)(15650500001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ClaHrammxqa2CjyO/UYaXANbgL+/AKnJcYXEgdMBdpHuAeBUpHqlfEPlAuYV?=
 =?us-ascii?Q?f6UAHZGpjgNzcryOe/yzU824whNAc5iN6tkdGKvKzayNWFMvrnWg4FYRqxpF?=
 =?us-ascii?Q?kmouIky0CeskDCV7lZX5Jyj/rTvE78xAwX+rGgY+M4UTwrIoRSRzxgExYvZ9?=
 =?us-ascii?Q?r3P7s3hfJFh5YGWPQDmXtK6yGjbjenmDwaaGHE92IzNRkVftTeeW5I2EUTUW?=
 =?us-ascii?Q?1QYlvmPvgRZqEXJ8K5NHXWMp2eGSWFqjELDmkio00jh4DaiaHW8ApTjIQboX?=
 =?us-ascii?Q?cFKOKfJsW2SNTHEnypCVvRDqI8wJ3qjDee0ZHusb8zXI0jJSPhae+sQAE3IB?=
 =?us-ascii?Q?VeVAd1p3FdI3cYyID0JVrrChinXoLc9AZG1ZVrKXM2GCZGYEGrd+CDWoyiIM?=
 =?us-ascii?Q?WyNREqJXMKpU0dbp+rkpsohbRWWOZT/aeeEX5vahLRF77Rk+dfwOdzwZUPVo?=
 =?us-ascii?Q?6ZHyYoc+YCTp5K7pX2XetM56VcBAn9lAa4cnXhbVbCmY6SIBr0u0fcAPcmzD?=
 =?us-ascii?Q?nul1Dh354Xzh7acf/hACEsbDG+HdbZCLNBLfXS/PeBSVD2Hx0g4gj7FhNYhe?=
 =?us-ascii?Q?T4fZiY4Uy8LNObYskzqb0zRv3JrXcV8gq9N+rhQT5R0/gnQ6PouQEZFTBCOK?=
 =?us-ascii?Q?DRIU0LQ2auo5744MH17WTb+1EaBNOG5kQnhZTfNVy27qnHG4N/cxiBbOPVdc?=
 =?us-ascii?Q?1h0sUMP3B9B5CqrEgBuWHAYIBCyPEbkbZwDnblY/tikCr7CfPzVQOoFbjKtc?=
 =?us-ascii?Q?98PUv+ott4LD5qzD1Hz4AKh21LVyb1cg/NWDtcT+UQFH4sUEEtLPedkrgdv4?=
 =?us-ascii?Q?rpJxzob5Yx+TZiF5s06D9LCUJD/258USpUQK/6do8lMnZynuQDQhGd3QLzv5?=
 =?us-ascii?Q?xixL3787Lsv6GsT1KFXfIiTNKxyQ5yI99ipFu+G/ZYYQhboyXldEFg0RC04Q?=
 =?us-ascii?Q?O8ddwV1C88IgZJB67yQpUaYy1tb4ZtSyixPOaRN+r6S5o0iRuvP3OLDEBWMQ?=
 =?us-ascii?Q?xDO45Jymlmv+ndYitnUbYU1kWbgKHtaf7IW5wwqkaV0n3+I6TLJMMDxLjljV?=
 =?us-ascii?Q?erWIvL04QFuauneSNLZ9Uk7BjiBTsenmSk4ikiqIAXONlK3FGrNKYKN/dasY?=
 =?us-ascii?Q?6mX4VO/8RCuvED2+47v/tnU6jNdpRRfFjBdRwpZIQuXakDb6O3iHzcO1GWe7?=
 =?us-ascii?Q?Huufe7nrZ1s5fqIF8T2GMOvINRn8fY7aAFf3/PbmXMAc4B0HPJB6oyJLF+KC?=
 =?us-ascii?Q?cy/WJKjyF42aHLW+5iY/58KpCxe+qZe43neAHqQBBMz33S4RDAqvge4SxMRE?=
 =?us-ascii?Q?SWtxHw8/oLEYgmDzNRxE4X35HGp/S8+FGBe1IleRd58oXTZ7tMHnXO0vCjob?=
 =?us-ascii?Q?XVKDEIbcMLbNdA16a6JrGoxi7qdQTdueN6SukQqK8Lmh9eA8m2XQG2+mnge4?=
 =?us-ascii?Q?u9aH+y43E3Zvz4TmaklOQA4zohg5AGL3JSXA4KIXayeGqYP4y1SUQ5CK/RMd?=
 =?us-ascii?Q?KlOpoDQ38ItW0R/oFRgDyzq5u6MbSwjGpEWwFgeXCKjULlNP+XLNBfzIBXwA?=
 =?us-ascii?Q?IhSHtNJmIW8yOrV76FmCyfhhCggjSQVrKNQ7eRpq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb03853-8559-4e7e-a3e6-08dbc6b55d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 21:44:06.3132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Elx0ZNmX4l/B0h7YZ+OSqX6FU77rRVdBzoh+Vd9Y/9SYOhsjMQDqLYhcHGI46cfyXoAKphFOicPu9vlePHgxEjQTro1QVwrhRVaSzgjGYcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> -----Original Message-----
> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Sent: Friday, October 6, 2023 2:14 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Polchlopek, Mateusz
> <mateusz.polchlopek@intel.com>; Drewek, Wojciech
> <wojciech.drewek@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v1] docs: update info about rep=
resentor
> identification
>=20
> Update the "How are representors identified?" documentation
> subchapter. For newer kernels driver developers should use
> SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
> callback.
>=20
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---

Since this doesn't change an Intel driver, I think this should just be sent=
 directly targeting net tree without needing to go through Intel Wired LAN.

Thanks,
Jake

>  Documentation/networking/representors.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/networking/representors.rst
> b/Documentation/networking/representors.rst
> index ee1f5cd54496..2d6b7b493fa6 100644
> --- a/Documentation/networking/representors.rst
> +++ b/Documentation/networking/representors.rst
> @@ -162,9 +162,9 @@ How are representors identified?
>  The representor netdevice should *not* directly refer to a PCIe device (=
e.g.
>  through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
>  representee or of the switchdev function.
> -Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op=
, which
> -the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name``=
 sysfs
> -nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
> +Instead, driver developers should use ``SET_NETDEV_DEVLINK_PORT`` macro =
to
> +assign devlink port instance to a netdevice before it registers the netd=
evice.
> +(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
>  ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
>  :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` =
for the
>  details of this API.
> --
> 2.38.1
>=20


