Return-Path: <netdev+bounces-20100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D6975DA64
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 08:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAF641C20A2C
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 06:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACC11C94;
	Sat, 22 Jul 2023 06:45:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1810E4
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 06:45:03 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48B3270B
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 23:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690008301; x=1721544301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sY3G4AnRw6EbmYUFzwQIdawvRd3DVVXxPBG5D9fv4As=;
  b=emc3536kF/XTSsPucUZ7Yj7W4gHIOrKAypEUZqChIMSYGX4DQIvoIU1I
   WNLSWlXd38xEpbgDNC0Y+aNlt+nRX7g+4il3LeGp3cRv7lCKSrRZaetBC
   4EqVPM9esPGhFmjjnwUQCFys/HfLttqwMeaQu0oJoiWrY+yUCZcmjGRcd
   7XhpbRRTenYPw3igVZNt8Lv9dUVQnqQuSxaqC8h1skuGRQRZ8yjTtZXm+
   i38STZMWN9hC6xMSYpRyyV157B36MLQ4MgMkSMF0j3nbiZQWI/VrHb4Z4
   cVSx9MdQoXiyIdCWBmjMtfJ1eDPXBjPZXJlhiPLai80pfMkMBjsUbKE1x
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="453547116"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="453547116"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 23:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795210462"
X-IronPort-AV: E=Sophos;i="6.01,223,1684825200"; 
   d="scan'208";a="795210462"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 23:44:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 23:44:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 23:44:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 23:44:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggCPDCoBDCmK8DkdYca9WkwvBZrwOYHsGws0ww+mvw0JBlrSRdKkfCxRyVgXvMBcdz16d1vPa73DEuQ8nR4VP9eErPeqGh5Qg251IZiAg/iMkVgBUca7Wt8sR7EwsvscbgJGfqEQ2B8jsBHv6t83iisD0nxfEqLb0cefRS7wNWmg+BOLLKqdlC8PKEoPq/NFO/h7ypV28usvZeiJSgNG1rX6eKMJQSK7kQfsB3TqiUo35rbT28GniDUw3Xr3m8sThfHsBUFTMatxX8JvfpK6m5paDymmYwjC3z/O5k0NXfyZcmBke8K1Fd35r6Z1zqA8WLQf0OsYZ3Zykne1ZBqJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B66LNg2BkwIHFU2YHwXwHNoeTPbXLxM24J12SDEvCCU=;
 b=QJeg50iouyfHWysp+FM/bKb0wcZNn1OUmvJHmhyx5+PORvSXc7ggYNQ7C5U3rxEV9wuiO+9cesZyFbHDdNdHh7OtJQrCqQN6TvKKa0zbj9XVPusB5SfFAjvWok1SHXSoNfgn5KggT7cR07frgsbLR71EhJVXebMgnRAGmFEN1hrNzSNq6qKSCXegj71XF3ngg4FxCOf+2tUOoy+nxOvJWkT6wO257l/sTOlswJpXM/Cr+BXyT9gfjxtyA9+KWlF7G9nyfXy+fKiMCnI+Gmt7+/pc4DPy9nYzr+VHEyjH5KF1uN7k60Fy5wdMd7hR0FGWvr+HJLApljIaI8tHjzyXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA2PR11MB4828.namprd11.prod.outlook.com (2603:10b6:806:110::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 06:44:49 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66f1:bfcc:6d66:1c6d%4]) with mapi id 15.20.6609.026; Sat, 22 Jul 2023
 06:44:49 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "vladbu@nvidia.com" <vladbu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "simon.horman@corigine.com"
	<simon.horman@corigine.com>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v6 03/12] ice: Don't tx before
 switchdev is fully configured
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v6 03/12] ice: Don't tx before
 switchdev is fully configured
Thread-Index: AQHZtLDaMWOjFhhIi0aPF0cpzI8Qk6/FZo9Q
Date: Sat, 22 Jul 2023 06:44:49 +0000
Message-ID: <PH0PR11MB501390D4B14B14B6DF37D491963CA@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20230712110337.8030-1-wojciech.drewek@intel.com>
 <20230712110337.8030-4-wojciech.drewek@intel.com>
In-Reply-To: <20230712110337.8030-4-wojciech.drewek@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA2PR11MB4828:EE_
x-ms-office365-filtering-correlation-id: c73d306c-f6e4-45b2-ecac-08db8a7f2520
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T8oDLc4ysHc+x/q3XzgQriRbgAx85/LbAVqCFhCBvxlc7Kx9grGqaETTWUWa085Ibpn+Ds81dQbAa3Hedzx3z+JSBc/nVbNsGTR25W5aej+K0vQtBxRkfleQx0x9Sylq9bFhpNFpDqErwqzZppvKfvY560cXG1HxMycVn8QnaGbm7tm58CM/64IbvxRyNf0p3QA05oGa1DJ5WLg3RSDcfs5FoqBiiTp8lbaRLEDUBer8t2CwMOYcRvMkYAD/O3KGjy6Kk1Vze4A38BVPDKWU/0utmrnOccst3JlcR8kSe7Ueu9I6bDwDjsALnsHIMRPiPJlV6cDVRvL2xbfdVAi1uMRxCFJSpoWpaLN3mrlcdUudQGwx7R7uVZj1VhpOv9MDzULu6RUfatvOrBuMJ2qBSexqKG//zkk/UmWcGK/Tph6jbHQRzzOPQOr5Cjw1ykcUjoHRw/bwrri8WdeA2BYDN7nWaWnMGkxztTLXzOmk6qqOWxqUqIxTYs0Bqfpcp2Fcc00BrmZJrMY944lOPSCs6PNA0UIapnBIdCeKdIV9C45YN9hYqpkiQsX/Rqqva2JS45tV17lru54FMeOHqGoPezPqT7a9EuQbEbxRAgp4y7ELcYsQAnaXA4FjRMnGhDzu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199021)(2906002)(4744005)(83380400001)(38070700005)(86362001)(33656002)(82960400001)(122000001)(38100700002)(55016003)(4326008)(64756008)(71200400001)(66476007)(66946007)(66446008)(66556008)(186003)(76116006)(478600001)(26005)(53546011)(41300700001)(316002)(110136005)(6506007)(7696005)(54906003)(9686003)(52536014)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gtDHXJp3UeS8d2QKzAjo8aqBHGupVcQnuSsDj2kJ/rZk8RrCQ8Nv/JmcrSLF?=
 =?us-ascii?Q?m8aun5/OknFTC8HnId7zWu9BU2ahycRoZLEwOnZxl93uHLEtiBZE4LdFxQKQ?=
 =?us-ascii?Q?lbL4EK9568DJHuCEco1fTho4TM3I+DpqRm5tcEiMpEOuMIMs0ZAKv1QuqYsn?=
 =?us-ascii?Q?KDs89AVTu/s0GcAhzh44GsrJt2sPrk0XnPJLEqhFIyC7Tuq1m+BqoSsrHWL6?=
 =?us-ascii?Q?wabD+Po/FYWQg5p//AT3JwyxEzfmffEZg4FkovdBhzZQdJAC+Z2HarjhQjgA?=
 =?us-ascii?Q?XJ9GWH371X8s+qdqHCMCqsrtVz/HwyMM50Uz83gRes43eFFA1VyNGouOh9Ge?=
 =?us-ascii?Q?FCr3QNVSMFQOPI0CDTHJsos/Tex7gmUd8qv/vLpOAnUt8+NioUQ2pNifEkqm?=
 =?us-ascii?Q?xfOrC+3hGOKqbQZRPf1Yty3UcU8NqHc0aoceZWRBNsnE3LEDao0UuU/GQyBI?=
 =?us-ascii?Q?VWQiiRBxYMha87ddUN5CsE6LZlQjBZlHuzCfotxoM+egWuS31y7L0p2dpK/o?=
 =?us-ascii?Q?ISJDYeQljYWZ22vjdK1QDMVqT+qms64GC79n3X86Ljhhu9Mr/gfGsm7jcRdt?=
 =?us-ascii?Q?uw1eFZUMIYec0bE30onYhV2ZS9xUB+snEAdRwQaMN7Tq1bB52LwDbNzkoB4F?=
 =?us-ascii?Q?DjLk0/CpFe7knsAyjXZyRers0oqwTDFuKd1WvN9JQTIes1rhk97HThC/XwfW?=
 =?us-ascii?Q?AEYzQe9lDywX6AHSy4sYYBDSoEnXng3009nGoGuezk9Y2L/ER9i8sbbSTK8v?=
 =?us-ascii?Q?UuCewcPgElAl4vA+VMt+NhMqAwwDHn/lEFZlE8293GcLKz4v3suk5VK33dT6?=
 =?us-ascii?Q?AKRC+iOIV9BHZ7MKCLZQ/6KIuLsGBHY7+YQSH7O7zIgogjkBFP6ddhS1yF05?=
 =?us-ascii?Q?qG2KiNIGhwX89DnKf7xKbbC4UDK/w3K6UlJPjLzqU8IsnU8yqBoaQxO2On2l?=
 =?us-ascii?Q?JEsjx4SEhsJbUY/XjEVqebDml/wl6i9PoGLpvlFO03xRXzmDCnock99KuekK?=
 =?us-ascii?Q?ARKjbTguMi1DXOu3qfE981HWFidC6itXqC5T8Bl63fjHh9BN2vvnHneSXwRD?=
 =?us-ascii?Q?SLFjCxCNSyCHat1VlErnXhymMigcVvKQRXXnqS61HtSyzuHbA0voKXQCSSbL?=
 =?us-ascii?Q?OW1fo9fzgnyqc3FvH2ktfFCWSaYz2JlycGTHFNlaYeH4iQ4O41ZtEwaF6zyw?=
 =?us-ascii?Q?H/tsjsega34ep+tMR0TJSeYfBpOG1yTbNxhpKasaPYASoxHcDVWYIAyMXhFo?=
 =?us-ascii?Q?s9VHTdQOlofX8b+Xv0ASLFOQS0P/b6SdybFWLPnPM+xqoYzcLXyMXmD+XbVS?=
 =?us-ascii?Q?eUSBy9FjEMo6vSuSjLNhDV5R6kVZI5Wjec05fVMm3Vv/StBqWwyFDiqTvtx9?=
 =?us-ascii?Q?8fYQXGQbUWi2l0OpBIaDug0KQoP+maSRpuDAzFEDrjpSazrCDgwzFRHx2jkn?=
 =?us-ascii?Q?Aaept8Jtqrb54DmJDad90GjsCPTmrwK16CenGU2ti1QECbaPq1dnBFu52Nz9?=
 =?us-ascii?Q?8j2PQY5gCo1X8ZtNEkgaotWsdXdR0zPb4URyuNbTYKHD670+9HHfVDULyHhj?=
 =?us-ascii?Q?kVwtAZAA+zmAVnYf7tf3Sp/ECgZjEVjx69wKwEI/qfTRQWqnqjTJVtRzaQ+L?=
 =?us-ascii?Q?Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c73d306c-f6e4-45b2-ecac-08db8a7f2520
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2023 06:44:49.1021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ll+UlmPcZMM9o5gPdbubl6nkMLdHKJs1cq83L1Jc/rj9mRo4eEU02cuGpsiintaU981Zd8XkklK8OzKqAa6yX82ophcasn2l1nZDSrK5P3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Wojciech Drewek
> Sent: Wednesday, July 12, 2023 4:33 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: pmenzel@molgen.mpg.de; netdev@vger.kernel.org; vladbu@nvidia.com;
> kuba@kernel.org; simon.horman@corigine.com; dan.carpenter@linaro.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v6 03/12] ice: Don't tx before
> switchdev is fully configured
>=20
> There is possibility that ice_eswitch_port_start_xmit might be called whi=
le
> some resources are still not allocated which might cause NULL pointer
> dereference. Fix this by checking if switchdev configuration was finished=
.
>=20
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

