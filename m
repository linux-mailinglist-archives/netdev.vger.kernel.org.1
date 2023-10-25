Return-Path: <netdev+bounces-44259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2607D7662
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC001C20C2E
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7889C328BE;
	Wed, 25 Oct 2023 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A28fYQuK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23F8273E6
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:10:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A840133
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698268217; x=1729804217;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HfbpdDocyRmyQhXfLuvbdPXlzQblrXU4wiUTLFyp2lc=;
  b=A28fYQuKHifB83kGY8YaXnyYauY9vTY3juq2SjbHch6zzbu/5FvB2ZEt
   asYxPpnZ2LwOLo79kyL8CxbV2JnJ80KSSZWibtXWkWr3itrzvbx8VvL4L
   MGm6oVE8hSV+1h5XfapFztwhAvdbNU9P2GT5Q+5WSc/Pqcvb4um5XXrLx
   zHVN/fKylSUbpZk09zjT7uySYdOspnJ10GJyu8KRu3V9mO1+aj1PSSeJR
   jBvTchEbBGyKK1kb9/HUCF4Cw7JDXRg2i3B1Y6s0tL5FVq51maZdZCKM1
   xx7jPS8J5SQDJIFQDUhY8PDlOCvlB81yg9udLDT2V42vnrHx0sLY25Jso
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377769489"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377769489"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="788253225"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="788253225"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 14:10:16 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 14:10:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:10:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 14:10:15 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 14:10:15 -0700
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:10:13 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:10:13 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Chmielewski, Pawel" <pawel.chmielewski@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 3/6] ice: Add
 ice_get_link_status_datalen
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 3/6] ice: Add
 ice_get_link_status_datalen
Thread-Index: AQHaAhptCWjTPe8ri0WYSmOrh2CMzrBbCvdA
Date: Wed, 25 Oct 2023 21:10:13 +0000
Message-ID: <DM6PR11MB4218CA5FD7274EC74715127782DEA@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231018231643.2356-4-paul.greenwalt@intel.com>
In-Reply-To: <20231018231643.2356-4-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: 25ae3123-f57f-402c-28d2-08dbd59ec793
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3wWwixjcvzHQummsI5L22daGWNBradaHH+LAzw5n+P8z8hgzY1vuLmIqMFNG42FdvtCKz9Vp1blgoTRfmcvcBXOrkNKj2W5Uv/aUm5zTd+4wOhgZW5Ibcv0ccs4MyyjUQ+iat4eLjRmmUFcDqWgOLfz0e1I7zJfyNCf4y6a1IXvQ2+1qVsNhsUfOOkRb/pNxObyAwWdK899sszcSeW06xdNpRFMC49/SouSqS5V19notI+/NmqJ+Mzf0EuMN7twB8RDy25L726QKAK8Sw2ZmlBqWu0fBLjN+zs+pzoCqGKBWOvaAiQJl2+6No/qAH6oWV2n9lUhdtjOwOHKJEDg2VaL7M5i2l13a4gEP6/C3E85sUSM3U/TmOD4bzh3EC2DkCHoZym59Ceu+Jp/zs2vHPqcEBiVs/UW0IRJdjcw/4l0rVZcXF5d0whpQHS4xcH6fOvUggmtq43mg//To+X1J0F7wZ1eICpoxMpt0SiotbMABkhnRSRgM7IbsFm0xLU34mhrcGahHFm32Rk9eEIoF3RYBRzcHq3NyBzBvp53cvRbRmQ9+Tgmax6taPXIozpaogK7MDtzdud6dhL6PepCBwYOAniR94sapr8yChUbePBOq0XZl56kw2/mtwtlmqTfE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(2906002)(53546011)(55016003)(478600001)(5660300002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(66446008)(52536014)(66476007)(33656002)(66946007)(6506007)(86362001)(54906003)(71200400001)(110136005)(26005)(7696005)(9686003)(66556008)(76116006)(82960400001)(122000001)(64756008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YeyJ3fdfpRWBNHEgJ5FUA4IzVDstkwkVo8NFuT6x+Uh8reFAQcUzD//JDGaW?=
 =?us-ascii?Q?90GUEj/yEqWrll7pNOab4KZHAkE81UCEroTOxJLQhhtMxCJs0ZbHimRAPhSQ?=
 =?us-ascii?Q?6TUQayDnp+e+aUN+psYFxzKY+8+Zf2nLM38oyYsM5LpjD0HwLmP1mGkmGOPf?=
 =?us-ascii?Q?7VHtHXODrlsYlE2vAFHFhV5sQYWGT3NYQxbr3t+ZIQoX++8itQnFBR2SEGUH?=
 =?us-ascii?Q?nCZOwugHTIzdEBD30JOYdJprkhMlNbxI26dOk/JrH2swV5ZNBUZrb3dcDbwz?=
 =?us-ascii?Q?ZdVzuC14Lcg0hxbZnoD5Fef+HnNgKT9UmvB1lU+YBx1HGfCvyqwdK8bIfctB?=
 =?us-ascii?Q?9sPJYHyewOYhdFPiB2BwBuubH6bBMnce9bh35h63yC4VlKQrAlcFd+VsWfQz?=
 =?us-ascii?Q?R+Rmh9hhlYv676yUo5ZdPcFYtHC7wGAN+Y338MRTAwRiZjgon+wSaVd6zxVK?=
 =?us-ascii?Q?Kc58YLk7g9HeywPmlFqJ3YOYWQYfPLMahIBeRovbu456TL9PCIFDrTSTyaEL?=
 =?us-ascii?Q?xp5b9C10Lk9F/XlOkCk0sA4yUrT7Zr/HuCPAmtHgJ29aGapuyQAATUOM3mFc?=
 =?us-ascii?Q?YYdgshsQcpy/uQx+0NxPQZWmreEWKThQLBF8K/TNJoAkOpu7KTTYHNdclKKy?=
 =?us-ascii?Q?FYm1tdxXwVT4ifQDBKOmmpeqRvO1ZhptbFa3zLgberqdbVehxWIpegtAVCOB?=
 =?us-ascii?Q?S34rqmz+1M3SHBci/wcWGSkXy1h5BhNUzooVd1pXkWEFBCuVs4uMlyiZQH4T?=
 =?us-ascii?Q?j8lPUtSKwz8WX/omo3duiH8VdJ7BVVa+f4+lKvTGnhUTyVLlYZ9qiSZj8jiF?=
 =?us-ascii?Q?hLZcRluK5mlVKm+xM5bc+0VtF4Z3wRa22+UwzTrKrcEa5eedwP6CVQ4GB28H?=
 =?us-ascii?Q?ftS35OMoTdYrgbKzeL3d5xORxieaYbmHY4YmXnc9l7UT/7AHE8T4MXIyUnaY?=
 =?us-ascii?Q?pd5+g8xJUjIYQcJ1nNvs1shuEDH/l2fgvMyIdURu8Tnd1NP39vZQSIwhUY2B?=
 =?us-ascii?Q?v6qcapJMh7C3ZjVYwQ0fIMy5i8WZ2ipnmQhS9Om4pClkf4AyFUFtOq2pbhFw?=
 =?us-ascii?Q?F+rRWFtIoVdRqicCFf/DH5P7atKzWFwP8C8QRv5Vfuc5FxaSUSJGu7ntBbVv?=
 =?us-ascii?Q?O9HQwa78yfwDDkYf4lkogxXPBVnkOCl/0CWgiRc/q+rc+BXtmnSXFZYk8QA2?=
 =?us-ascii?Q?VmfDr2Zw9G5bsdVmzWkJr6tb4eFBySFJb3KAQ4fS4fE1ca2ogy6ektM3Ekks?=
 =?us-ascii?Q?6An0FfoZQEnjQXkQfcHiNR7fXabfL9zzgCbgdKvtEC6m3SrpD7NDANExvd+r?=
 =?us-ascii?Q?oNYyZMwto7VqFW9cyzO8Ri/YDsLqy8+vo7M+0Mw/uJsMQ8i+iVPvS8MrLSU8?=
 =?us-ascii?Q?Smz2QObiqBAd/XC2/WfWpfxFkVvoic0nrLxbjirI3+RmRoAKd9ZaOAWHwlS9?=
 =?us-ascii?Q?r/9saJzVDvexaBvZ06smeALNy/Iq+uiaazmU4NBg78oYS6sG9KZ7x0/eIaUd?=
 =?us-ascii?Q?7IRN6fM/ijQhGz1M1FoDgJNlw4hYWoxJ3BxS5IU7GoggjKsVL+6XuPS0L6Sq?=
 =?us-ascii?Q?PBiwaKoBzFUQ9bXT89Qec0L3OOm43WETom3LkJzf?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qm3yCe/qpk7Jg9iOR4H36y4lCHYMrhpnzaQCQ/zPon9nkR8iAkmpoc0eG5UvCO2ZDGp3IhYUxsfKbJZe1ex7iT8s4kHFo/0IIRIYQRhE+qr6iRz5A7UWoZDX7sIneL7+dZ+upbUbCRe/dgy6eXaIskjm4q7lQWCuNNQIs/ceGvKcZ/1p8ycLSaevOCpfwsFkDEbNq3k4WnOGJ32H5yh/p8kUIvwXW40Z3HS79TE0kSMlqc5Kqcp+wWnPwzc7HieD10k6pHUEG1oVwn/GdjmN5ZIzGL5i97nISlLLYJEMX+iq7i1nJpQkn0MtqiCyLEG9bbXHupL8Ziwuphpzie4lhA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AoZB7JSOFfMozampdu09uFJ7DqxjbHIyonF7uLkEgk=;
 b=PZWuZ5yZ6PxkmrwwYSRfgoIfNkd+Ez+QDPKylv0T36u4n/FV6x1luUCrDU8d4uDSnJAzSdCryA1Dg6JiXbkADdIlnagPTDewG++Y/KvR/bd7kYmNLn/Y9VD3wkteIimNmTivsP/R2AI+RWzOQ4swlrEhGIiAouU5yIs87DbgkkJvCduhbSrsUOdBynBERmXL3opM66JO5k2n0yvDLr3SARtHvPvYS/Ghot1pds8NaVJwYoW4FgkxxDQoLUlql/Ln9uyl3bsoQQ76xxbIonN4VNwEsY3oeEuugmweAoBe/BkVyMEKcQ75Mb9EXdFUq01C1AxDTvAF31ahnV3/N0IEHw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: DM6PR11MB4218.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 25ae3123-f57f-402c-28d2-08dbd59ec793
x-ms-exchange-crosstenant-originalarrivaltime: 25 Oct 2023 21:10:13.2664 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: rFZGYGcJpjasy7Uym3f3rwz0DMyvy3QpvB0c5OY0S5GnKacCZ3OtgKCUvSmZuqbrvni1guU8QSk3DX7a9O5ju7fWaP7B5P0ZHim9s29laic=
x-ms-exchange-transport-crosstenantheadersstamped: BL1PR11MB5256
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

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
> Subject: [Intel-wired-lan] [PATCH net-next v5 3/6] ice: Add
> ice_get_link_status_datalen
>
> The Get Link Status data length can vary with different versions of
> ice_aqc_get_link_status_data. Add ice_get_link_status_datalen() to return
> datalen for the specific ice_aqc_get_link_status_data version.
> Add new link partner fields to ice_aqc_get_link_status_data; PHY type, FE=
C, and
> flow control.
>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Co-developed-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 37 +++++++++++++++++--
>  drivers/net/ethernet/intel/ice/ice_common.c   | 22 ++++++++++-
>  2 files changed, 53 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


