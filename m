Return-Path: <netdev+bounces-59824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBF381C227
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B41288372
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240E079491;
	Thu, 21 Dec 2023 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a0hZSfwR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239497948F
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 23:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703202900; x=1734738900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=idk4xD1otRU1CeUWDuCrnsskJHabauA2vT+m19g+h6U=;
  b=a0hZSfwRK8v5JjS4nu9+J7u85U0DxZipTGLDO0S4cQO8DojyQ38ZOj9k
   eRZh6i6r+4KMOv3fxprSAZj+fytdgt+TR5Rlc6E8dp/CbWsQktntFOHif
   F3e+U6KWDAl4ajx2HiaIilswcMRpukS3gDA2tKR4ddLK+NMTcAulmEMfv
   R77QFTLv2pyahOjFGtixkIygTjF3gEAD44h3OzEN84tp7BiydXLizrbjn
   iVgQBUDWWxj+7PAJFBn3D4lilnHkgXL5+giiun/Rfosj6dwOuWlDNv0W6
   wqPhfzddC0w3xkLOP7mqo71UWgfVnrnDbJnQlC3s4r4oJGtHoRv8TkV2Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="482234106"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="482234106"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 15:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="753095923"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="753095923"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Dec 2023 15:54:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 15:54:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 15:54:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 15:54:54 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 15:54:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXngSthl6B4pK+TmnG5o39H2khCTFz8eAVVFLSULQFeW/FWsgH4AzEOylcqGR85Q0A3IbqMA7ZDyl2z0EX1r1J37fQSSzy7fAqHIDxzEgqBuuUga6eJ8dSqSn8T6K3cjMZHGIJCT7XC0EI1/pLsYgZCmZEZm1wCVda18ncSV8jRb08bcNYDmVrhTwYyXSJ1kbiL2wc7l4FRxOzdkEFaCiTBEBeG9SsBLj+CZUrECeyJZeYfT/9oh76A2bwMhVa4JpEETKhLORCMvnXDZ9o7Ch1yYr8/d9XsNStufuIBWgh1E9h0cobbpmg/R2Uzjb/3TDiX7pFkQ5YVNvWHTM1i8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idk4xD1otRU1CeUWDuCrnsskJHabauA2vT+m19g+h6U=;
 b=Ht1Te1VT0oIV5CmRRqhTUcp2HXzzXtYE6603Lipzb1+9Z7rVYoVzpeiEfEH2rUk6P6d9eFLgtKwp7lkSQvBfOjR4ZQOetRdKoTpoNy1x9flJj/5WhKRHbMkTikQEmJprOY4k68SiivEbLU8iHNvTtxzlGqhq2cmF63lVvfWXnF2elmBNra0OzrnES8ZUQWXyhX+UdqaXLWJ/EaPaXlZt6q8W9E1HdxW+k/PEczdTogWW/irBgrwhKvf8W+OM3fVARLvycVgIixPmT5Ye/K9p4dLuRfV4PP1MkNcyr4ree74CAljFm6oLcEsFc3C49RZivWbtHTI65KASsA1qJuf8Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 23:54:47 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 23:54:47 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: "Sokolowski, Jan" <jan.sokolowski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>
Subject: RE: [PATCH v4 iwl-next 5/6] ice: factor out ice_ptp_rebuild_owner()
Thread-Topic: [PATCH v4 iwl-next 5/6] ice: factor out ice_ptp_rebuild_owner()
Thread-Index: AQHaM/UE0YXo0RXBA0CrExLsxullerCzhqCAgADjgcA=
Date: Thu, 21 Dec 2023 23:54:47 +0000
Message-ID: <PH0PR11MB50955504B9A5D9F778734F58D695A@PH0PR11MB5095.namprd11.prod.outlook.com>
References: <20231221100326.1030761-1-karol.kolacinski@intel.com>
 <20231221100326.1030761-6-karol.kolacinski@intel.com>
 <PH7PR11MB58194ED84F05726358D2A06B9995A@PH7PR11MB5819.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB58194ED84F05726358D2A06B9995A@PH7PR11MB5819.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5095:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 6636bafb-37f0-4502-da34-08dc028036a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXII7Jjm1TANhGbiJf7B1Oavl4gLJbX0RA4A2pDZSypYz0kNiLgK3Ckr55lcbGJbOUyabrO3JmrOHK9hI/WJiWjn0RL0asjDYib6DkbtrHwdy7ENyLMDVkP11wRTv3wlR8+/mTNzf276lHtJCX9YSKpZirWserFusMJM9AVyF/cnwzFGc0NpyWUXhMt5vX20KuB3e15jgBK2N4m57t+BY+CK7gTeivnAbiPLyN1+O3zK5DytjyiDohYT+xRneE+lbiIBXFJ7lDXOgXPlCnLLIvbFDSMY6VN9wZIgiAUIqFzp1lvM8SSLaFRPGYgeDP/07jCr5bqPTyVBqYdG7Z9zNeceQOReO8W0i1/1cStVcKsvxzypLn27K51Qksi08IVkxykvbuEjgSBF2aK0zNHf3nSSp+vMcCreHK2mcdSM2EZ0Xzq2YXl5L68fMMwtEz5TzQlrbHtn02j4mznMgKFbJYRyiU9brhG5EH95kSfKfG8uGaHzwiNyE7aSjzgNXPpsi4koW0c7u6tXmlQnEOpi9B6mI+71AC4JLWwWYK6a2vwmI6WHC6CXiDt4KTZxe3fvAyzJAkV2PH4IMsf9XC8qMJyuE5QYM84n5E1+wqswWr8sFOOs7H1HA3RBG6zeVdol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(55016003)(4326008)(38100700002)(52536014)(122000001)(5660300002)(54906003)(110136005)(316002)(66476007)(66946007)(76116006)(66556008)(66446008)(8676002)(8936002)(64756008)(26005)(83380400001)(107886003)(7696005)(71200400001)(9686003)(53546011)(6506007)(41300700001)(86362001)(33656002)(2906002)(38070700009)(82960400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KKCMEcYQUHkNGaB3jSsAMZ/29Z/S+Gb9p+k9Dk+/KGLep32ryZvWgKhEJj5p?=
 =?us-ascii?Q?3+E+8Decgd8hJoWCxGBEhzK5z9UVCMW5pIbWTJrtqj2x4IY3+y4WG8eYDIHI?=
 =?us-ascii?Q?exwe5I+eNXP07QvT7v1gCSmr7MtQ+IpDdeCdP1F+axLBeION+ONKnOB54j9R?=
 =?us-ascii?Q?OAypLVUMxURAYIh9AaQ9gjpLdbOsPrtDXYBJ37SgoFjSSMJbMvFDGLWdiCUC?=
 =?us-ascii?Q?3sTL2ZGGub+4pYSTYCmOjwvf3gYQNJP+QotDauw5skLbiiSy56kesbJ8yvrZ?=
 =?us-ascii?Q?9Gn9j4hE+Su4GnXl2vTmXGXVAyNoGA5TuDigROwJFTdcdNshYV8OfSbFgEMc?=
 =?us-ascii?Q?6h4v6ali46mqxuGo8NkSUSux79FG/FQ76Y6j0/f45SYMoLh/AoBQL20Y/Go/?=
 =?us-ascii?Q?tKpGSV5wRxfkmHU54g+Ssze4M3i+IMwJzGXaG2dBVtCRdMeb8N/OXAC+dx/4?=
 =?us-ascii?Q?eqeDy6Or2WzLjzlXB4UGMIN7d1SgAnJc5myLoOzjHbakXS413ZvIFjyZ2tze?=
 =?us-ascii?Q?6n2qGLSrwdIWDYImTXVXLBLz3LhOHNWPqv5SJ7kK3Mec8OHezGfyDhk0qF5V?=
 =?us-ascii?Q?yLx478fTEV6Xmd6zbCaX/CeyEjgn7tZHR2hsYDfi5jRcERzKZ3N+80+Hxjw2?=
 =?us-ascii?Q?sOUb3N08Dkw/+6BHtReFjT0a+4N4UAP7H6h04r0KspXRZJbkBpP+rj4xOvS5?=
 =?us-ascii?Q?MQA83+d8VBlIm2Uebhdd/0gzYO21EOJTuQE7IAjnYWhkJnqkQGlJvH4xvqy4?=
 =?us-ascii?Q?4lOUiG03HDEc8//d3BC8AxY70+ZeBTiqpoOafFi3/QCmXWk5DvAG2oZmyMcZ?=
 =?us-ascii?Q?Na/2tkgi+DP1Q3A7sslISCvBBQrdH4bx6eeyd/WP0C7ISeuljPOHDNonLSmR?=
 =?us-ascii?Q?7IFq6srgXQkMGgCXrksxkRXHHcXtOjApZ57wwRaWR2UhuD/8BTF9w5M5mSYJ?=
 =?us-ascii?Q?eSPT1MTzarZhU/iixCgeWLYdyA4Rhdqb5ueg3B8MenM8SD0XSbCIrzBsiJ4p?=
 =?us-ascii?Q?HDw1S5upsKtXfSIgO/orez5nyNOWWiLdeNzJy6pzir0U+A9bhLOSfN/E33wp?=
 =?us-ascii?Q?DH1bq6qaHHp2JuaP/r6ZRt6RUq0hEE0vsf+nkUTpkpuAEm9JIR5gQ9D+RjsX?=
 =?us-ascii?Q?WF1RCl+KsZBQk/Fk6bnk+42B2XV1PzOL3fvyZYzNDJEABsvOQo/KJWmlIHNr?=
 =?us-ascii?Q?4Y6nEspmBn8fs54yzVQGV6muhLUYQBkZ9t7361f3ksTSDvN7OtZ2PX+Bo4fW?=
 =?us-ascii?Q?ucJ3xEyjvYmS3WZAAoYyd01RgFEvn5J4N1xIVhk5XHGihCL4lEI/uiyhjror?=
 =?us-ascii?Q?Mp0Oq7dHK+SmMHMQxC3A49XPutykVJfkeLCyzcxlzCTV8ECHXnuwtaUZ7Byk?=
 =?us-ascii?Q?7lNgiTF3yltNbPEN0RcJlzMz5l43NE+KGNf/8QJFwhETtX2zYbQCMCfn7sLT?=
 =?us-ascii?Q?YYgHEsLMNL3hXZQ4jTIrQLwLSwblA9fPRT9bkKp8f32d7yLTX8WgW5RqbN7H?=
 =?us-ascii?Q?HrlYKZJpMfsZWXh+sWcjoOooPz7ZKq9z5IYPqFGSbt2u3NOLmtt3iRAKmJFg?=
 =?us-ascii?Q?I1JATvI+cdY5avGnGmwoDE5GWPHwuG0cCx4qj20C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6636bafb-37f0-4502-da34-08dc028036a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 23:54:47.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /wwWQLAOCnamhODyasIc3lQAC+A1I8LoPvLBY7YL6qJdRmEBAGmQ454y5wIHTs3CX1tGXfSTJYNzWnjigZ1DspzZ3vGsvq3GmQbhhbDJ6aQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Sokolowski, Jan <jan.sokolowski@intel.com>
> Sent: Thursday, December 21, 2023 2:20 AM
> To: Kolacinski, Karol <karol.kolacinski@intel.com>; intel-wired-lan@lists=
.osuosl.org
> Cc: netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com=
>;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Kolacinski, Karol <karol.kolacinski@intel.com=
>
> Subject: RE: [PATCH v4 iwl-next 5/6] ice: factor out ice_ptp_rebuild_owne=
r()
>=20
> >From: Jacob Keller <jacob.e.keller@intel.com>
> >
> >The ice_ptp_reset() function uses a goto to skip past clock owner
> >operations if performing a PF reset or if the device is not the clock
> >owner. This is a bit confusing. Factor this out into
> >ice_ptp_rebuild_owner() instead.
>=20
> To me at least, the wording of the title (Factor out) is kinda
> confusing when compared to the message itself, as if you were going
> to remove the ice_ptp_rebuild_owner anyway.
>=20
> Other than that, LGTM.
>=20

Ya, the idea is to split the functionality into a separate function.

