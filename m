Return-Path: <netdev+bounces-44258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDBB7D7660
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 23:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60ED281C9D
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD9328A5;
	Wed, 25 Oct 2023 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bmdqthFy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28528680
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 21:09:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46F132
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 14:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698268155; x=1729804155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GQKMZ3vh68wi9Esd89d1lj7uLZ9xScyluAMuvwhAorw=;
  b=bmdqthFyt8eOC1PcCYA+E5hrwo49qfV9ibpOTH7a7G46ak/FdF+ImywV
   0kj2m8zs4NFEQMDkCkpvBZaaN9zOBIvm9KcOkTZybMJpDOJXnlaz9J3Rb
   YK6dinUaLTL/y9smsdM5We/NwFXloFj9utVoUuWtSlUuRQWQR61Bctt19
   u7r3bMxvVtmot9Ajj85Dbk+zbPPRfICfn5Dyr6RKhXjP4Y5wtIWCQZjI1
   Rcw0AvtV/5G7fOZPQpVQQday9yURV6i/76FpA+PG+6QA2f/hJjpUQxDhi
   TEtIDS/i2nRywOtcsF21XTJkfbLiWQNZgA2gaK9RJL3h+SGb7Gm29Ohoh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418524021"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="418524021"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 14:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="932503221"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932503221"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 14:09:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 14:09:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 14:09:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 14:09:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf0uO+G4gHZNtypi9G0dLmfvqsTfHcWDyn1wmeA3bvPxrWTPd2cFCCgmSGZXHZ+JMDs5NiOLxYN/+l8yRQtykeEjhDWC8Loj4Fw/LwKkYjoWJNlhlKfvWCtsZkl04+wnl4jFPfS+vyZfOeptOCC6XYoQaj4htC/lVF9jzSLsL1i/NoAZfikGWE1gx15aGQEz2OkupFMrFXYPJsp2OSVz5WQFc6he6PcfHFUmlvbUlKKxbTHPhtz4370NsupycDJqh/zszBk3Ju2sGz1jgicAli73RixWCc0QQcu5yFrLShEuap+pFThvQUnbDxr1V7v9LRFrl6tdvX0MugyF+SQ8Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpcAgk+YUhNjIqAy4RrJb2hTZg5XVhYRJjhzK63K2po=;
 b=LGAfFETwe/VSrbtxaYjdAuUnQMN9RlG8QUeZv+3hGnkD5WfXmDhNz9GnQdO5l2YWbjZP0FSXnNNHEYVn/UO69PnGFekCnRWlTnN0YdSDdi/jD6uSi6VG3HlldHHR4E9PjBpfWXw7QOPQ0T2ehxjGJ5Fuyo4OiEAVy6BCmjV40H5hjfyAMR4i/98ww1z7i6rcaraZ6a+/uTjh2EQSSf/Ghi5ggHRUWBnimrlA3zWMCvB8g1czWVfyPZfDgkKDtnG2ZXTnXC0LoJg29B4gsJ8hZKjEnX/r96aZwlVUhoMQ1LbWTDFScBvNmw3zUS8L6aOWF7KiodroB3yLETEhbS3RxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4218.namprd11.prod.outlook.com (2603:10b6:5:201::15)
 by BL1PR11MB5256.namprd11.prod.outlook.com (2603:10b6:208:30a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 21:09:07 +0000
Received: from DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93]) by DM6PR11MB4218.namprd11.prod.outlook.com
 ([fe80::1c69:1b8b:5fd7:2e93%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 21:09:07 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: "Greenwalt, Paul" <paul.greenwalt@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Nowlin, Dan" <dan.nowlin@intel.com>, "Greenwalt, Paul"
	<paul.greenwalt@intel.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v5 4/6] ice: Add support for
 E830 DDP package segment
Thread-Topic: [Intel-wired-lan] [PATCH net-next v5 4/6] ice: Add support for
 E830 DDP package segment
Thread-Index: AQHaAhpum63mK9/7mkCdzJUs2vw8Y7BbCmiA
Date: Wed, 25 Oct 2023 21:09:07 +0000
Message-ID: <DM6PR11MB4218F6640D1038A776F1F67B82DEA@DM6PR11MB4218.namprd11.prod.outlook.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231018231643.2356-5-paul.greenwalt@intel.com>
In-Reply-To: <20231018231643.2356-5-paul.greenwalt@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4218:EE_|BL1PR11MB5256:EE_
x-ms-office365-filtering-correlation-id: bea48fec-0aff-4112-7aba-08dbd59ea037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t6GooK7Cm+eQiLuwNH3nki0oNVXmXUEsPjNR8BvdDYjigAjrVpeifoEAFDdJAVIBOeTRWngB3J6kZINW9lKYJ7n+qJdjA3RCl8y2XZquZJY2JPme0KGFcsA6tZv/cwtmeW16rg56tTLOBYnqaW4jyWoNJVy4ui2hIQYBWbLwu4IY7Ps0XeY84/kfnYj62mvKUqjMGRFJQOwapS2NJJCJADDU+rVREs8afUXVazCHDN23uU9LYFxO0RFOzf9lOWhNUMOXSlMrTYz19GgEMyAGGt5hfaiD4mOBp1vAR7aUpG89sbsUFA3j+SxSMpqsgGeZlTHFkDe3BPP23XgH/7CBfyeIH1BMNtZ3KXPwkaB2lHPQZRKTRsVJxPfJWbwI1+cSC7CoYUFYal70e7xcvKjlG7RtDHPBdBgyncIlV4b314mb9itfzwAe+xWYFIC4TBvbLMV+gQIP7rxytMKb02244Yry85+RgbUa1abtewMGeF34+X/4TLlxII0GmEapZ3D6HCCwLPiRz7dOeL7NTM5HgFJsVOCcbgpdGVdOpo14iU2fgK9+EmUm78JI+XzowKDXQV5SFjwszWzlW35f9Omz76ZoqEQKjIjVhjdP32fnOa2K0lcqQ6g5OG4DgpnrJEPG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4218.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38070700009)(2906002)(53546011)(55016003)(478600001)(5660300002)(38100700002)(4326008)(8936002)(8676002)(41300700001)(66446008)(52536014)(66476007)(33656002)(66946007)(6506007)(86362001)(54906003)(71200400001)(110136005)(26005)(7696005)(9686003)(66556008)(76116006)(82960400001)(122000001)(64756008)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9HIy6c//fG27Ci3NODBl/cjERhahN5MS8tLm3+RxRcufO3pW7CzO+0s0Hwe+?=
 =?us-ascii?Q?5BgOlgwrz3ajb9w3Rkqq5eTpwmHOct6hxG56O3Krbed8N18ybGOspkK4Rcwr?=
 =?us-ascii?Q?q4EaHhQs2YBR3BUhGdE6NjcLFfDbsk7Qss5BO2P3TGpf71UrbHsXYnO/+l8h?=
 =?us-ascii?Q?lGgDu6STKvAaTVvBcE+IVCbRGpBddC/Jr4I8pYtI5NlIf/rAvxPnWZpg2/bA?=
 =?us-ascii?Q?6j97eFU3eOOJE/5ql0ORCctGsnsyUvDj/USY3tqG+8Tjv4oF0R4DL483t00b?=
 =?us-ascii?Q?gubysxikyf/kvt6EtGPlQ0VJX1Mh5ewl5c7+Qm7FRALDiLf6/i7wFPkjIxJg?=
 =?us-ascii?Q?5mf31kYop7pxH6iVA8aIYrnByimE10x6Jd3Wmsm8AZgv4ZHargNdrD60rhcl?=
 =?us-ascii?Q?bL7nEuRc3sN8nMkSyoR0mbrPwyRdwIo2FkzXfNUtCcM27tmMF5cL2GHPfQNu?=
 =?us-ascii?Q?5/jAH1sg6ipkz08refs0ICvPmCGVuPIy1YnTLmvJR9rJFi5OmPddz9Mm1khn?=
 =?us-ascii?Q?arpAJ1Ze60sMz4H28jILbCAIlPlmj+cnfjKELZDHlBair2ovw4JP+DIVn597?=
 =?us-ascii?Q?THUohxT3DN51VaGjFAP+Yc8sjzJZ/RoMD2a48hj1lNBB/s6avBZAUrElRVhe?=
 =?us-ascii?Q?/ljscwL/hUzgnvw2Uzh9h3PFqeJMkzoWxq0QFtcujFe7M+Dz++TESeJHJxLD?=
 =?us-ascii?Q?+YnSWGHDW+aa9xrUENJEhg1jn4zL0CYTvogkBuZdj8TXVRuFgF/UToaUwY3r?=
 =?us-ascii?Q?xWKVlq11U8Nfg/sWYrxe2mpWKaUaqWVGeM8or95Z3bfpWO8UX1+X8vRtxdB5?=
 =?us-ascii?Q?el31w53hpq1CNmKr+26SH/EKmICZhEKQOje6X3j3NKXbvXbu0ElhJ51+2KHn?=
 =?us-ascii?Q?BGNoek8U4jFJpdDntoV2kbT+Aw2NK+NE97e2U1y9m0TJ7XEzq445DXAQCvMm?=
 =?us-ascii?Q?x05aojxXhCerGE9yx/yOtKi2VkLBzxHAHA1taayjw+u5vUeLz1TlQ+ENY/pN?=
 =?us-ascii?Q?aPGc/v60MbUOMuZW1VYBvcqEEWJtPGnq7EWDZG1pXF/oGKU3xg+ZotOOC5do?=
 =?us-ascii?Q?Nw8IP/Dgg/xl78Bva5l5/wTqvrocVDOZHlN3cm8MK2l1mKT7J+V6+h/IEdr8?=
 =?us-ascii?Q?VgNqbKy2hnDJLS62huzXswb+4CHzITys3n0Vgejdckgy+H4jXE2mt9xMhn7u?=
 =?us-ascii?Q?alQ1ZD4ZeP4TbV0Kb/hK5wrSO+nye/LyxZsi+3VaTthpXHjG3bIzL1iPTPdn?=
 =?us-ascii?Q?Y9G0Kqv22pdyihYWzkGTRzOCEjHYlguQBHjTJOeIzRCLibhsmgDVCm3K7wYK?=
 =?us-ascii?Q?kqYNETDFkGsOKJ36PE/UN1hElisq9WW5RfCXIUy01D7y44JmYoCSpY79gjPb?=
 =?us-ascii?Q?MNVf1FzoioJAGzaBRnxY1rIQPTxbL6I1H45skr/xEwmc/6ydKGQZUXSamXk5?=
 =?us-ascii?Q?GF/lsyJbXseofrHawK7xFquC2FFTf67sMNEDi4byHnXoupUoIhyyVlyY+7BQ?=
 =?us-ascii?Q?N0N5bAN3QUQUJK8rUHhO45wpMG10+PbD9104eLhuovPCmPA0d+08ttTb8PeB?=
 =?us-ascii?Q?7frPFKtRdyhSdXQnN73JhXUSfunMaGO+NmZbpHDv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4218.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea48fec-0aff-4112-7aba-08dbd59ea037
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 21:09:07.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DnOeoWWJWbw7NEvt1VXV9MnldzLKNx4VMSigi7WB/1RNfG+b1RIwo/nGeVPPdvz0d88MTiPM4A+QRyRvHdwJj+CISBWVOVnwCKE9i7sh/sE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5256
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
aul
> Greenwalt
> Sent: Wednesday, October 18, 2023 4:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Nowlin, Dan <dan.nowlin@intel.com>; Greenwalt, Paul
> <paul.greenwalt@intel.com>; andrew@lunn.ch; netdev@vger.kernel.org;
> Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; horms@kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v5 4/6] ice: Add support for E=
830 DDP
> package segment
>=20
> From: Dan Nowlin <dan.nowlin@intel.com>
>=20
> Add support for E830 DDP package segment. For the E830 package, signature
> buffers will not be included inline in the configuration buffers. Instead=
, the
> signature buffers will be located in a signature segment.
>=20
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c  | 426 ++++++++++++++++++----
> drivers/net/ethernet/intel/ice/ice_ddp.h  |  27 +-
>  drivers/net/ethernet/intel/ice/ice_type.h |   3 +
>  3 files changed, 382 insertions(+), 74 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


