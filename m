Return-Path: <netdev+bounces-58438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBD181661D
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 06:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122DFB21A88
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC4563D4;
	Mon, 18 Dec 2023 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HG2qZpz4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1A663D2
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702878660; x=1734414660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DGuX4rBYfw77Y4VMXSimG/gC9/smrMnWVFesT7L69p0=;
  b=HG2qZpz450W5gz4dObBrcKHTAneLYPamwpVJTu+XB7fUooZCBCxCL1eX
   GXGvJEcdQdsSDQxWuJfVw8PbwRB3MLC3CIWV90ytEGteRiLBobKxdCYyN
   7OZgOraAm5pMJMxeUHqLxC6mLfsayDqF4XZwH1AdT+uqTDOuipSXej9ja
   dLgTWjU73wK4JDQiJFdvpf4wq2RJfhbCOgHXvotLoBa5Nd2fO80v9vN7z
   5AmoKrYxpxMqSzFXGQdZz/XZMNFdYN6wtt4y7acnyMwTUGKb+V2U5ycw8
   5cgK0q3Gls75NObgyftXAHwOyFqxg2R3xzABNCrDyo05sep+ltrv+vlzP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2286633"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2286633"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 21:50:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="893695410"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="893695410"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2023 21:50:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 21:50:58 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Dec 2023 21:50:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Dec 2023 21:50:57 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Dec 2023 21:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW0p/Sx3fCoIxcJ3B7l8TDdTw+2Ycl5IF0E5pW0riH4PqpvKGbfAg781YiW8lQcoSa4ZrfgQpSPlzT0ZgUpDTNc/yHRU6G5tFVesVVBUwdbEsgGMquusQypNTPhelzgPc9FH8EN0l4yrTu40s9a8XtKQJUevc4JgridzQPxZjuEfGyEYuFijWTn1bF1zQnTCnyV2rt2kcsogunm7jfS8t7HoULof2D4/864NL8WdcsuyyEt9ckdHicbMYggJi3daADN6KkkSq9tSeDsAgcM22LVPotUKEripAe66y0cubbuJTzZRUsVMgSLIG+Rc//IWdlLQDiOhRnkDllrrd+mlHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BB+fnPkc7cyMAjEi/dCCJwwve9GF+JqPqVBZt2FItes=;
 b=eGbTB4dVm0ObbdQIMF0VqFu20wFnv3WdJsbNlEbg+gDu9rITCG/Luk/GVg8PkCo8GE8qY6yoBde0Uvo9ioL5awMGSiaKMr7S5BsocEWjTPh4epzrcEwZe/9/sFbBWq6Zk+XtqtkqhL9zq0yjWjZmO+S9xH+lH3kejMofQoYP20+x8gseaUCwZ1t86hdua8XwcGyjwyMubocQ8Xo5lbtJG4u1+lirNL7AokxWYmtrsB3yypWd3YbnlejOM5Qbk/2jpl5ndBwjbqCzWVFwrNzosLEgyJOzQIw7yBsXI9LUGcc3eixfmUSBCveP0m/at0C8LqI1v6H+wOSiz7FQtzO/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by PH8PR11MB7048.namprd11.prod.outlook.com (2603:10b6:510:214::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 05:50:55 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 05:50:54 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2] ice: alter feature support
 check for SRIOV and LAG
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2] ice: alter feature support
 check for SRIOV and LAG
Thread-Index: AQHaLHeGHoZtcXw9ukW43k/dr6XicLCukqTA
Date: Mon, 18 Dec 2023 05:50:53 +0000
Message-ID: <BL0PR11MB31228672A582B7CA70FCBF7FBD90A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231211211928.2261079-1-david.m.ertman@intel.com>
In-Reply-To: <20231211211928.2261079-1-david.m.ertman@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|PH8PR11MB7048:EE_
x-ms-office365-filtering-correlation-id: c3f6970f-c2a5-423c-7c2e-08dbff8d4c66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bL1JVUedwk6iaCVgiADHV/m5j2e+OcPc4RTEQ4TQUz3R1dGwIc3140WnTvmXc/4uSInoI8yb1UaxG9EZ+1KbWeWNxBYOchsemI9MUMxPDrNsgrxqHxfKp85Ka/IJtkyhBzfysCRfgo/cdyaWN9xYTMeHBv1zV2PvW70yUzfR9eVrF8cr9ztXKWktuCtXoyT0iH00+7X5cl+hQST5RRWJiQ9DUnse9ZzkCYmwBDcbww5UtdrVLzWbuSZkW7FffqL2JF7go/5Ix6RXIPWqibFff0ME12Vn6A8WbvrL3ugIIUiPDvQrqqhtzlCrahVEv7uV2W9xh/0LmdXYX/AfK1EGDJTlw0nMwEKUT2P/G3kIGMUsdf85WJcUhc+A9/h4z3FSic2f10kQWx0Y9DGm7FI1pUQ94IajVCST/5vzHNnboYNOLYFyYnR3djK48yGqvJb8a9gqffQeFAss3E8seSMhVuN6kW6FIVhQFw7E/HVT/3H8b/ppUHxwMaqOcefm7PGveXTFem9BE/Dphpjtlvi3Jhuo/Ey6s05GfhHvHLGN3sE4BTlTNyuzsKL4q7Z2h5mqUyWQ9aqAkuxe6JnWVBYEiDBWo/aCUkMvEo9j9WpnnsxptefR504T/OTCnr5Ptzk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(5660300002)(38070700009)(41300700001)(33656002)(86362001)(82960400001)(122000001)(38100700002)(26005)(107886003)(55016003)(83380400001)(66946007)(66556008)(64756008)(76116006)(110136005)(66446008)(66476007)(54906003)(316002)(478600001)(53546011)(7696005)(6506007)(9686003)(71200400001)(4326008)(8676002)(8936002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M2f5brN9PNQjwRkcVnZtEhdPjlZyouygtkmAjDkRs0VW1NMkCEzV+dA4nyvv?=
 =?us-ascii?Q?T3B8sDgrsEZ628LWdGpZLiCa9OK2V5cQepup8nv1rGmOnrxrhPPb9MJVSQzE?=
 =?us-ascii?Q?5CY7egzp5OLVQMxq28kQ49anJuOUbRCUSYHF8twCj1/HI+biWy47VZxOtuFl?=
 =?us-ascii?Q?/xsInpCajOWZAfxWwXlZonUJehaNiDMQ76OxPC/Pz8cgcfWyUKx8vbJGO9du?=
 =?us-ascii?Q?+uW2A/kJqoXQz2YXIwUZSfYQkyZ7wpnAQUm+nsV8tH5Tl3t6ufpcaswPWVu3?=
 =?us-ascii?Q?ZwOyRusO7Lizo5xPb2S/TBXFpG3y4o6MoPAJxq0QPLiEAh8RYoLRM+gkub8u?=
 =?us-ascii?Q?oi72hdU4zqmQYqLuEaINQyTl747tjrVONTeVOsTcs7PNuFV8qbPr6x17Vueb?=
 =?us-ascii?Q?+UyPPLD7fn6O779eUy2mkE1fi2yRqwYLQtyugFZOrG50O+xxHtRxD24/7/fL?=
 =?us-ascii?Q?QnnbOpSzVs/T9jUTmjCLxNlE5sVuNoVn2xmj6dctbZUaAVK9Xa7e7S9/pyJJ?=
 =?us-ascii?Q?R59ClG8Mws0M7D7dUcPhIbRhQPlpX17KJf8Jol/WlpF62ILuJXDr9CCj/DIK?=
 =?us-ascii?Q?HcVoxVol129/3yLu5EXab3m2pHjMn+4YHXETNJVeuAf+tvF3gJuB68VAtq9r?=
 =?us-ascii?Q?wqbFp+kEZYPuLVX5LEyBcLlDQfWUgvdRDz8jy94Zu1r/nf7YCkMx2HSA+h5i?=
 =?us-ascii?Q?WlXi+wwrEgi1OZVbCg5zUSzjBDGS0yA2EJZJvQZ/bXB3A+SuRk6KO4HPSz0O?=
 =?us-ascii?Q?FkqSF1xOkA38+2fb9EdL4iv8cCL8piyzVScDmBd6CQEg68vtVJAi1ULgtHnh?=
 =?us-ascii?Q?9jnFpOnyF5Wh7VPx63VqDcfWLn8c+eYgX2FR3qopBIQlMantQHwbPz1rIgO+?=
 =?us-ascii?Q?ezssBnof9oDz0DtGcvTM0zI5GiJOIKuoX4HRqDFsVL9FW7q4nSlHi6VR0mTE?=
 =?us-ascii?Q?WGEeRTJPknk69s6mgPQl9j+JNKmpxx/sAvf0cdwbCc/UtzQktCwAqdgOF6vZ?=
 =?us-ascii?Q?4OfKirokP3YDbjQZhLd8UaYwSK3cJA1d2VpFuym9cceMD8wq2zE+M3NiCb25?=
 =?us-ascii?Q?+GafyIJBMXEVHD+H+Q1nTQYIelbhCwYqWGIAhdmZmVMu9sbhMDa+JthPehzR?=
 =?us-ascii?Q?z7M4eeu/OZc6rgnIrRoyvqG5UyYya/Lm9dKBn/wybv6QPCB3/B2l1iCk6+OB?=
 =?us-ascii?Q?gqocEqXNaOb4SmZd4WpJxg8YirGBY6EFuBsu22PABpG11g6oq9M6h5KKdxWr?=
 =?us-ascii?Q?kTw/8zDekbNi3XSY8VWaNhjZ4/gpfsieBrQwVQwjw3/7OX4oi2DVeV7d4Lq8?=
 =?us-ascii?Q?GEXSirsm2V0eNepgBHfWa9aT9dMcK+Z4szo9R8ZHNZ+kkWjjnfrM02ouNvE5?=
 =?us-ascii?Q?RBLMI8jSYuk5YH0YZCbMqDfU4lWO22wjRZlStawDyuWZA0pQjMATutOSbwWz?=
 =?us-ascii?Q?OESNG9Bf0LDO1BzrNtNStKL5YC8zyiGGtWq7iigO1vY4tYy4rH70iE2LGsoX?=
 =?us-ascii?Q?S5GCBgEFxtZ8yDFT36ERyurmhGdSr/I9Fcx3TPCyyD2LiFUx1YhyqS2f/oC5?=
 =?us-ascii?Q?TREhcNzevt0VG/YNyIA6pkEr66X2W55KJ3hDy7F2iRjFfRL9MN5GFH2/Ef28?=
 =?us-ascii?Q?4A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f6970f-c2a5-423c-7c2e-08dbff8d4c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 05:50:53.9685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Oh9FoCMTgc0aRWOAyQZGUek85QOReMNmoxP7pT6uBAyOTrhkvMJw8QjbzLpRfizA0A47emDvmOsHXZwMWPrpOWpx+lboGtt8yYkHE37vb+iQrn2NpKL+pq7SeY0Lve+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7048
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
ave Ertman
> Sent: Tuesday, December 12, 2023 2:49 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brandeburg, Jesse <jesse.brandeburg@intel.com=
>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2] ice: alter feature support =
check for SRIOV and LAG
>
> Previously, the ice driver had support for using a hanldler for bonding
> netdev events to ensure that conflicting features were not allowed to be
> activated at the same time.  While this was still in place, additional
> support was added to specifically support SRIOV and LAG together.  These
> both utilized the netdev event handler, but the SRIOV and LAG feature was
> behind a capabilities feature check to make sure the current NVM has
> support.
>
> The exclusion part of the event handler should be removed since there are
> users who have custom made solutions that depend on the non-exclusion of
> features.
>
> Wrap the creation/registration and cleanup of the event handler and
> associated structs in the probe flow with a feature check so that the
> only systems that support the full implementation of LAG features will
> initialize support.  This will leave other systems unhindered with
> functionality as it existed before any LAG code was added.
>
> Fixes: bb52f42acef6 ("ice: Add driver support for firmware changes for LA=
G")
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
>
> ---
>
> v2: Added Fixes tag
> ---
>  drivers/net/ethernet/intel/ice/ice_lag.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


