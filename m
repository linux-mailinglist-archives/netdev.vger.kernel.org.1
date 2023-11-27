Return-Path: <netdev+bounces-51219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE27F9BD8
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B107B20A18
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 08:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B94612B;
	Mon, 27 Nov 2023 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBNP79l9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C1F135
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 00:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701074301; x=1732610301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wgGFalUoxM4RzWyKm3lpX6qAhAr3FRazlwbRYk8WYHA=;
  b=CBNP79l9+w2NFMqhyN5iDZDTTYeygiXv8Lg4HZJo9L+9zZBtKEkAz5py
   zC2L76XQUO+dfZtCcpALejKz86GH/14gDpPf7UqJKp7kUfmdL5Zolsh/n
   dqES75NRUPdLb/JW8Q961GNbBoEg4p5kXu6tJIxLkz3bi1ud3kIpj3mY2
   GghUhT7QpZer+TNbHsiHTIXGDlmc4jMV5YwJJ2tv/Kc0qR1OKbp3rJztt
   Peyyky1x/banGNDF2uzHYASpl3eD9vl9RbGa18GTzsJxTlQubbg6vacKY
   jxY54CNRJPOd+I8CuDP60kAL3nNScqzKUSmKACvBOJ8k+UXqRinx9erKQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="14221108"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="14221108"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 00:38:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="771849738"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="771849738"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 00:38:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 00:38:18 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 00:38:18 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 00:38:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KH4slwR9I4Ixf+anygKMqsg2x8CbvlKDcv1uTZq1lji47PI5jk6pBCFKUTbt18ZV6BawoOhYtXs7/6HLjkcVafaan1mnshlyluhtW7X3d9CH50Trrgwq5ETCkNGKMuYEKBwpj/kQnWYCktF1kzGqtRm5UR4isMPMz5VwSU7ZQDXChr7wNIM+7yr+Hl73eQt6yHtBcSp5NgGUYQ2CBqjKfeMvVHl5KteQo17jXpyp7l+Vbj/e7VoOaFgAEyuEYJWKlXypTQtnKeeigmxfZ9IRlCMfOa4AaahoW61Pguasoiqy6VcJGbzXlL/e77yNNsx3r6jKPM6CRaXuLv/WppYIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvJoR0A5IPvIVy7eryA8pYOVWN/5lC+m5jZe5MTUOPw=;
 b=R/Na1ErKyjeBzKcDUp8/nKoEtK3MOGdQDsnzc6jus78IGU+aj+BJz7tZqSL39l0XNNbpJsfbTENoTb8RUWDABDiylyX01DYTGUnMXCUdldBq7TSRLvd7VjDqePQ/LiXnu4oB4CcwWla+laQtF+UPHCiqhF0vBf+2Nt2+aANkKKGyxQKN6qnqoXS2cGtaoqHxru+z2UZz4aRe/LWB7T1+Ed0E9JI/Jh1SDSFixDeyS0JF6JGqzlUU2JIamnooFdRzZMHDDsewtq9Yo5EvmOyDdqh2248gXzvthIV3436n4fklsVFFeb7o+OYoaLCHW+bwFErcG81+edVUCOakIR0gwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com (2603:10b6:a03:429::10)
 by MN2PR11MB4613.namprd11.prod.outlook.com (2603:10b6:208:26d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 08:38:14 +0000
Received: from SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::a418:4b7b:4567:eba9]) by SJ0PR11MB5866.namprd11.prod.outlook.com
 ([fe80::a418:4b7b:4567:eba9%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 08:38:14 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [PATCH iwl-next v1 11/13] i40e: field get conversion
Thread-Topic: [PATCH iwl-next v1 11/13] i40e: field get conversion
Thread-Index: AQHaHMB20ZR5plDAOkS3O7dbWwyw27CN4Gow
Date: Mon, 27 Nov 2023 08:38:13 +0000
Message-ID: <SJ0PR11MB586664F3D1BDB907B3161E85E5BDA@SJ0PR11MB5866.namprd11.prod.outlook.com>
References: <20231121211921.19834-1-jesse.brandeburg@intel.com>
 <20231121211921.19834-12-jesse.brandeburg@intel.com>
In-Reply-To: <20231121211921.19834-12-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5866:EE_|MN2PR11MB4613:EE_
x-ms-office365-filtering-correlation-id: 7165d370-bb64-48f8-d4ba-08dbef2431d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQXIf/7CR96p96T6AFo08RciShquHNWQjx4NxuOfbHxV3AoRwhi8yoJdlaL8lPA7LoW7PVtR9v9x/GC1zYfYF57OaekYwOkCniSnQA/CerqyDBADpDTrQRtXeO+W2jlWdzXWyR5l4P5OgZ0glMr37y4eGu0t4dOn8A6Y4YTmm7nPg97ukgRSqQQJouYF1fAGe/p+6mkaaqKvFtFmBj2wZb7dcLExJbBfmq+/+qXvoEa8RW10NBEv5t5/81ZieeY5mm3G9lWhLJf/HcAcTrM+NmFneEo+ZutCqn2Idalz8NPRTPs813wkfR6mxxwbIRphYbAzGV9Kh6SbU3O4FNxT1UU8Mape9YzKaORojm4IRMMOlSO6fXYVJiO39sQOPN+747hWmdNGaaKv0zfWjT2h/m3WAduqY3PUJg9MfEcQzuD/NjaHxqkMIUjwAdFeTa8MqngM4rBA9upn7A99Xd8Y0RqkGSbx1Lcp4UO5GFYP/dgbYFUvariWhFxPk7oR6Qie5aAruUPVKjwvbDpEq/1E0RIJBuQALHxTdAWXIjH1DJfE0LzKrHIlrpINEpEZ13lFNBNxKspe7B/hsXQ+u2DSPfwimhYqduAV73wgddQ6em+XXDkTahl6RadOwFWUT/yx7AOVGvmWyiLkGtmAxbVMYLsSuW4hTcP7597ufgZ9j6E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(6506007)(7696005)(71200400001)(9686003)(82960400001)(52536014)(8936002)(55016003)(8676002)(4326008)(86362001)(5660300002)(478600001)(316002)(110136005)(76116006)(54906003)(66476007)(66556008)(66946007)(66446008)(64756008)(38100700002)(83380400001)(30864003)(122000001)(53546011)(38070700009)(2906002)(41300700001)(33656002)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OtlPC26ezi0gXTddUy/8z8s159aRPZAuorZmZ7eL4XrqUPMkvWLDS3szJSot?=
 =?us-ascii?Q?0VBk6XcP4/Gv8XM5PqFnJw7K7gegKvxptHUqooyXHnvrZ5pt96kEVq7F+KLv?=
 =?us-ascii?Q?zW32czKEUF3GsYRVU+iC0SyCMyDNbIcbWgpCCUpfKxZAQ8SWgggUrb176vgC?=
 =?us-ascii?Q?j3Loo+hKEiyCTAPKpYYhFmSn0lmis6oGg0O7J4SgPvI/i9sadLu77RUy+nmf?=
 =?us-ascii?Q?Cz8fY7Y8bVaooNVMoyRzM1m4YRYrGZm6FVFkcOtpAt2/fgnMSgAfEguEjGOm?=
 =?us-ascii?Q?ZUbqUvHGyhBeAxHnqUXes9Q2rNk/Mgz2EW6cFmJmwYWeSaimFJgS9lFJ6lB2?=
 =?us-ascii?Q?b386f9bQFg+r4wDTB4eJNO0/u6C8t5EzOBrHVmuMu9ms9jag0fQEeoWYb7x1?=
 =?us-ascii?Q?qDk0ZjyiwpSXj5dEoSUeTe8w/rw0bMlccfu6KhXLKtugmQY4aP/SfZlXqsC6?=
 =?us-ascii?Q?rHLQbWqO2D1OXlWyCWJSWtBUuMCmIjOIib8C0/Iqoq5iz/kwYDtxq4SsEbBR?=
 =?us-ascii?Q?IYW8pQOmwc0BVMZjAfFicutQdUQp8A+bpqPSCKRvJ+ZSHatukTR1GmZFkQ3N?=
 =?us-ascii?Q?Moq5/S70yDTaCVkpVVdmVhD3vRJUMFEnd6PYzSLgQr2Rl5DV6WkWU5r2LwF3?=
 =?us-ascii?Q?N08WXc03TJl6OK646NEg3472bo5U7zGeCqmvtZ8Tn1KeCuMPuqVDYMm0uHJf?=
 =?us-ascii?Q?/GeBv75fUkOGhee5LvkP9MIoLTKX36wKAEQsOgnkhlg6G2rOqaXezd6glHA7?=
 =?us-ascii?Q?Cg/QTaqybx9hPIJ+W5VSC+XBExs7+0uiOv6YAEXR4zgbDacZ0u4ytCTfjqyh?=
 =?us-ascii?Q?qQPyODjlGHxZYOJw1ogO8xQtcMsbiV0QQlSpg6Gxf+ZInsKgKZKmB4im4iUa?=
 =?us-ascii?Q?en4EXvvtIB+MhJI4iQ0lVnuG76fbAP/z41Ng8rHFJ6GYWGZZe+8qk5NAQko+?=
 =?us-ascii?Q?p4UbrSxEQ2nmLYpdTNRfY7NBxsL410UbRmRN76kN305bWItaGd3c6YeowJJU?=
 =?us-ascii?Q?Fff46hFcEk2XoT7RDtm6e4u9mdvGM064ev2Cnpu4Xuxy9e7/q1HmWjgUPQPU?=
 =?us-ascii?Q?SkkSMhg4bveD5h70BgKPW6Mf7ZhEAcHUtnirMIGoraM165+NiU+AisEazzVc?=
 =?us-ascii?Q?YSxNZFV6fj0/C8MTiWNaghYW3pLLEzLYnyMSGZJeZfVzNP6OiQoLszA/oDfC?=
 =?us-ascii?Q?ubjRcgaLtl8RFJvaNLb2LsuXVqtvhRd9dbuyONDe+M43roQrca3wNOGQQPzi?=
 =?us-ascii?Q?6Bv1rdmRN156FRNuLc9qnnB3RjAkFnTUGKI1mVx0bq45knVBN3eZdKkawTuz?=
 =?us-ascii?Q?QzPablXkqCZCMiJ+RSWtbwJtxQwRkPkL3QyGlkPgz8EOqdYuRkEFTqn1bk6K?=
 =?us-ascii?Q?Ql267nkdGtxHWBSfd95lZr303IodqjAUZ6v+yVA8i5dMLiIDaj+XWES7SmU5?=
 =?us-ascii?Q?53gqIedwDv1esc0KWnMugTBW5TqUXrO3ZiF2ytZrKBHeYgdQGn3UBVCVrlzW?=
 =?us-ascii?Q?ovqMD4OJZoRwuBt+0ebnciqcic2TNqoI301nXMXWihdiBHuJs4l8Nl7dtbxX?=
 =?us-ascii?Q?VetZa3mV1vcrLegl9Iksdkwve71HkDDh2dh/36cqh5RcM5hgEn2PtNB2XTTU?=
 =?us-ascii?Q?sw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7165d370-bb64-48f8-d4ba-08dbef2431d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 08:38:13.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gvfxta6o3AyUDoTpZ7Bmx3usJ9ASeb0rhGa1KQithpsTDvRR7o9g8/ouCtKlstw9vmsM+zJ/s/rqLs/usYqWU0im37+dWuXeYtFbMSBBcqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4613
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Sent: Tuesday, November 21, 2023 10:19 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> netdev@vger.kernel.org; Julia Lawall <Julia.Lawall@inria.fr>; Loktionov,
> Aleksandr <aleksandr.loktionov@intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [PATCH iwl-next v1 11/13] i40e: field get conversion
>=20
> Refactor the i40e driver to use FIELD_GET() for mask and shift reads, whi=
ch
> reduces lines of code and adds clarity of intent.
>=20
> This code was generated by the following coccinelle/spatch script and the=
n
> manually repaired.
>=20
> While making one of the conversions, an if() check was inverted to return=
 early
> and avoid un-necessary indentation of the remainder of the function. In s=
ome
> other cases a stack variable was moved inside the block where it was used
> while doing cleanups/review.
>=20
> @get@
> constant shift,mask;
> metavariable type T;
> expression a;
> @@
> -(((T)(a) & mask) >> shift)
> +FIELD_GET(mask, a)
>=20
> and applied via:
> spatch --sp-file field_prep.cocci --in-place --dir \  drivers/net/etherne=
t/intel/
>=20
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  56 +++----
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 158 +++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_ddp.c    |   4 +-
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |   7 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  73 ++++----
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  13 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  29 ++--
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  19 +--
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    |   3 +-
>  11 files changed, 144 insertions(+), 225 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c
> b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index 4ec4ab2c7d48..b4a5b65496d7 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -664,11 +664,11 @@ int i40e_init_shared_code(struct i40e_hw *hw)
>  	hw->phy.get_link_info =3D true;
>=20
>  	/* Determine port number and PF number*/
> -	port =3D (rd32(hw, I40E_PFGEN_PORTNUM) &
> I40E_PFGEN_PORTNUM_PORT_NUM_MASK)
> -					   >>
> I40E_PFGEN_PORTNUM_PORT_NUM_SHIFT;
> +	port =3D FIELD_GET(I40E_PFGEN_PORTNUM_PORT_NUM_MASK,
> +			 rd32(hw, I40E_PFGEN_PORTNUM));
>  	hw->port =3D (u8)port;
> -	ari =3D (rd32(hw, I40E_GLPCI_CAPSUP) &
> I40E_GLPCI_CAPSUP_ARI_EN_MASK) >>
> -
> I40E_GLPCI_CAPSUP_ARI_EN_SHIFT;
> +	ari =3D FIELD_GET(I40E_GLPCI_CAPSUP_ARI_EN_MASK,
> +			rd32(hw, I40E_GLPCI_CAPSUP));
>  	func_rid =3D rd32(hw, I40E_PF_FUNC_RID);
>  	if (ari)
>  		hw->pf_id =3D (u8)(func_rid & 0xff);
> @@ -986,9 +986,8 @@ int i40e_pf_reset(struct i40e_hw *hw)
>  	 * The grst delay value is in 100ms units, and we'll wait a
>  	 * couple counts longer to be sure we don't just miss the end.
>  	 */
> -	grst_del =3D (rd32(hw, I40E_GLGEN_RSTCTL) &
> -		    I40E_GLGEN_RSTCTL_GRSTDEL_MASK) >>
> -		    I40E_GLGEN_RSTCTL_GRSTDEL_SHIFT;
> +	grst_del =3D FIELD_GET(I40E_GLGEN_RSTCTL_GRSTDEL_MASK,
> +			     rd32(hw, I40E_GLGEN_RSTCTL));
>=20
>  	/* It can take upto 15 secs for GRST steady state.
>  	 * Bump it to 16 secs max to be safe.
> @@ -1080,26 +1079,20 @@ void i40e_clear_hw(struct i40e_hw *hw)
>=20
>  	/* get number of interrupts, queues, and VFs */
>  	val =3D rd32(hw, I40E_GLPCI_CNF2);
> -	num_pf_int =3D (val & I40E_GLPCI_CNF2_MSI_X_PF_N_MASK) >>
> -		     I40E_GLPCI_CNF2_MSI_X_PF_N_SHIFT;
> -	num_vf_int =3D (val & I40E_GLPCI_CNF2_MSI_X_VF_N_MASK) >>
> -		     I40E_GLPCI_CNF2_MSI_X_VF_N_SHIFT;
> +	num_pf_int =3D FIELD_GET(I40E_GLPCI_CNF2_MSI_X_PF_N_MASK,
> val);
> +	num_vf_int =3D FIELD_GET(I40E_GLPCI_CNF2_MSI_X_VF_N_MASK,
> val);
>=20
>  	val =3D rd32(hw, I40E_PFLAN_QALLOC);
> -	base_queue =3D (val & I40E_PFLAN_QALLOC_FIRSTQ_MASK) >>
> -		     I40E_PFLAN_QALLOC_FIRSTQ_SHIFT;
> -	j =3D (val & I40E_PFLAN_QALLOC_LASTQ_MASK) >>
> -	    I40E_PFLAN_QALLOC_LASTQ_SHIFT;
> +	base_queue =3D FIELD_GET(I40E_PFLAN_QALLOC_FIRSTQ_MASK, val);
> +	j =3D FIELD_GET(I40E_PFLAN_QALLOC_LASTQ_MASK, val);
>  	if (val & I40E_PFLAN_QALLOC_VALID_MASK && j >=3D base_queue)
>  		num_queues =3D (j - base_queue) + 1;
>  	else
>  		num_queues =3D 0;
>=20
>  	val =3D rd32(hw, I40E_PF_VT_PFALLOC);
> -	i =3D (val & I40E_PF_VT_PFALLOC_FIRSTVF_MASK) >>
> -	    I40E_PF_VT_PFALLOC_FIRSTVF_SHIFT;
> -	j =3D (val & I40E_PF_VT_PFALLOC_LASTVF_MASK) >>
> -	    I40E_PF_VT_PFALLOC_LASTVF_SHIFT;
> +	i =3D FIELD_GET(I40E_PF_VT_PFALLOC_FIRSTVF_MASK, val);
> +	j =3D FIELD_GET(I40E_PF_VT_PFALLOC_LASTVF_MASK, val);
>  	if (val & I40E_PF_VT_PFALLOC_VALID_MASK && j >=3D i)
>  		num_vfs =3D (j - i) + 1;
>  	else
> @@ -1194,8 +1187,7 @@ static u32 i40e_led_is_mine(struct i40e_hw *hw,
> int idx)
>  	    !hw->func_caps.led[idx])
>  		return 0;
>  	gpio_val =3D rd32(hw, I40E_GLGEN_GPIO_CTL(idx));
> -	port =3D (gpio_val & I40E_GLGEN_GPIO_CTL_PRT_NUM_MASK) >>
> -		I40E_GLGEN_GPIO_CTL_PRT_NUM_SHIFT;
> +	port =3D FIELD_GET(I40E_GLGEN_GPIO_CTL_PRT_NUM_MASK,
> gpio_val);
>=20
>  	/* if PRT_NUM_NA is 1 then this LED is not port specific, OR
>  	 * if it is not our port then ignore
> @@ -1239,8 +1231,7 @@ u32 i40e_led_get(struct i40e_hw *hw)
>  		if (!gpio_val)
>  			continue;
>=20
> -		mode =3D (gpio_val &
> I40E_GLGEN_GPIO_CTL_LED_MODE_MASK) >>
> -			I40E_GLGEN_GPIO_CTL_LED_MODE_SHIFT;
> +		mode =3D
> FIELD_GET(I40E_GLGEN_GPIO_CTL_LED_MODE_MASK, gpio_val);
>  		break;
>  	}
>=20
> @@ -4190,8 +4181,7 @@ i40e_validate_filter_settings(struct i40e_hw *hw,
>=20
>  	/* FCHSIZE + FCDSIZE should not be greater than PMFCOEFMAX */
>  	val =3D rd32(hw, I40E_GLHMC_FCOEFMAX);
> -	fcoe_fmax =3D (val & I40E_GLHMC_FCOEFMAX_PMFCOEFMAX_MASK)
> -		     >> I40E_GLHMC_FCOEFMAX_PMFCOEFMAX_SHIFT;
> +	fcoe_fmax =3D
> FIELD_GET(I40E_GLHMC_FCOEFMAX_PMFCOEFMAX_MASK, val);
>  	if (fcoe_filt_size + fcoe_cntx_size >  fcoe_fmax)
>  		return -EINVAL;
>=20
> @@ -4646,8 +4636,7 @@ int i40e_read_phy_register_clause22(struct
> i40e_hw *hw,
>  			   "PHY: Can't write command to external PHY.\n");
>  	} else {
>  		command =3D rd32(hw, I40E_GLGEN_MSRWD(port_num));
> -		*value =3D (command &
> I40E_GLGEN_MSRWD_MDIRDDATA_MASK) >>
> -			 I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT;
> +		*value =3D
> FIELD_GET(I40E_GLGEN_MSRWD_MDIRDDATA_MASK, command);
>  	}
>=20
>  	return status;
> @@ -4756,8 +4745,7 @@ int i40e_read_phy_register_clause45(struct
> i40e_hw *hw,
>=20
>  	if (!status) {
>  		command =3D rd32(hw, I40E_GLGEN_MSRWD(port_num));
> -		*value =3D (command &
> I40E_GLGEN_MSRWD_MDIRDDATA_MASK) >>
> -			 I40E_GLGEN_MSRWD_MDIRDDATA_SHIFT;
> +		*value =3D
> FIELD_GET(I40E_GLGEN_MSRWD_MDIRDDATA_MASK, command);
>  	} else {
>  		i40e_debug(hw, I40E_DEBUG_PHY,
>  			   "PHY: Can't read register value from external
> PHY.\n"); @@ -5902,9 +5890,8 @@ i40e_aq_add_cloud_filters_bb(struct
> i40e_hw *hw, u16 seid,
>  		u16 tnl_type;
>  		u32 ti;
>=20
> -		tnl_type =3D (le16_to_cpu(filters[i].element.flags) &
> -			   I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK) >>
> -			   I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT;
> +		tnl_type =3D
> FIELD_GET(I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK,
> +				     le16_to_cpu(filters[i].element.flags));
>=20
>  		/* Due to hardware eccentricities, the VNI for Geneve is shifted
>  		 * one more byte further than normally used for Tenant ID in
> @@ -5996,9 +5983,8 @@ i40e_aq_rem_cloud_filters_bb(struct i40e_hw
> *hw, u16 seid,
>  		u16 tnl_type;
>  		u32 ti;
>=20
> -		tnl_type =3D (le16_to_cpu(filters[i].element.flags) &
> -			   I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK) >>
> -			   I40E_AQC_ADD_CLOUD_TNL_TYPE_SHIFT;
> +		tnl_type =3D
> FIELD_GET(I40E_AQC_ADD_CLOUD_TNL_TYPE_MASK,
> +				     le16_to_cpu(filters[i].element.flags));
>=20
>  		/* Due to hardware eccentricities, the VNI for Geneve is shifted
>  		 * one more byte further than normally used for Tenant ID in
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> index a0691b7c87c4..9d88ed6105fd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb.c
> @@ -22,8 +22,7 @@ int i40e_get_dcbx_status(struct i40e_hw *hw, u16
> *status)
>  		return -EINVAL;
>=20
>  	reg =3D rd32(hw, I40E_PRTDCB_GENS);
> -	*status =3D (u16)((reg & I40E_PRTDCB_GENS_DCBX_STATUS_MASK) >>
> -			I40E_PRTDCB_GENS_DCBX_STATUS_SHIFT);
> +	*status =3D FIELD_GET(I40E_PRTDCB_GENS_DCBX_STATUS_MASK, reg);
>=20
>  	return 0;
>  }
> @@ -52,12 +51,9 @@ static void i40e_parse_ieee_etscfg_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	 * |1bit | 1bit|3 bits|3bits|
>  	 */
>  	etscfg =3D &dcbcfg->etscfg;
> -	etscfg->willing =3D (u8)((buf[offset] & I40E_IEEE_ETS_WILLING_MASK)
> >>
> -			       I40E_IEEE_ETS_WILLING_SHIFT);
> -	etscfg->cbs =3D (u8)((buf[offset] & I40E_IEEE_ETS_CBS_MASK) >>
> -			   I40E_IEEE_ETS_CBS_SHIFT);
> -	etscfg->maxtcs =3D (u8)((buf[offset] & I40E_IEEE_ETS_MAXTC_MASK)
> >>
> -			      I40E_IEEE_ETS_MAXTC_SHIFT);
> +	etscfg->willing =3D FIELD_GET(I40E_IEEE_ETS_WILLING_MASK,
> buf[offset]);
> +	etscfg->cbs =3D FIELD_GET(I40E_IEEE_ETS_CBS_MASK, buf[offset]);
> +	etscfg->maxtcs =3D FIELD_GET(I40E_IEEE_ETS_MAXTC_MASK,
> buf[offset]);
>=20
>  	/* Move offset to Priority Assignment Table */
>  	offset++;
> @@ -71,11 +67,9 @@ static void i40e_parse_ieee_etscfg_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	 *        -----------------------------------------
>  	 */
>  	for (i =3D 0; i < 4; i++) {
> -		priority =3D (u8)((buf[offset] & I40E_IEEE_ETS_PRIO_1_MASK)
> >>
> -				I40E_IEEE_ETS_PRIO_1_SHIFT);
> -		etscfg->prioritytable[i * 2] =3D  priority;
> -		priority =3D (u8)((buf[offset] & I40E_IEEE_ETS_PRIO_0_MASK)
> >>
> -				I40E_IEEE_ETS_PRIO_0_SHIFT);
> +		priority =3D FIELD_GET(I40E_IEEE_ETS_PRIO_1_MASK,
> buf[offset]);
> +		etscfg->prioritytable[i * 2] =3D priority;
> +		priority =3D FIELD_GET(I40E_IEEE_ETS_PRIO_0_MASK,
> buf[offset]);
>  		etscfg->prioritytable[i * 2 + 1] =3D priority;
>  		offset++;
>  	}
> @@ -126,12 +120,10 @@ static void i40e_parse_ieee_etsrec_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	 *        -----------------------------------------
>  	 */
>  	for (i =3D 0; i < 4; i++) {
> -		priority =3D (u8)((buf[offset] & I40E_IEEE_ETS_PRIO_1_MASK)
> >>
> -				I40E_IEEE_ETS_PRIO_1_SHIFT);
> -		dcbcfg->etsrec.prioritytable[i*2] =3D  priority;
> -		priority =3D (u8)((buf[offset] & I40E_IEEE_ETS_PRIO_0_MASK)
> >>
> -				I40E_IEEE_ETS_PRIO_0_SHIFT);
> -		dcbcfg->etsrec.prioritytable[i*2 + 1] =3D priority;
> +		priority =3D FIELD_GET(I40E_IEEE_ETS_PRIO_1_MASK,
> buf[offset]);
> +		dcbcfg->etsrec.prioritytable[i * 2] =3D priority;
> +		priority =3D FIELD_GET(I40E_IEEE_ETS_PRIO_0_MASK,
> buf[offset]);
> +		dcbcfg->etsrec.prioritytable[(i * 2) + 1] =3D priority;
>  		offset++;
>  	}
>=20
> @@ -172,12 +164,9 @@ static void i40e_parse_ieee_pfccfg_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	 * -----------------------------------------
>  	 * |1bit | 1bit|2 bits|4bits| 1 octet      |
>  	 */
> -	dcbcfg->pfc.willing =3D (u8)((buf[0] & I40E_IEEE_PFC_WILLING_MASK)
> >>
> -				   I40E_IEEE_PFC_WILLING_SHIFT);
> -	dcbcfg->pfc.mbc =3D (u8)((buf[0] & I40E_IEEE_PFC_MBC_MASK) >>
> -			       I40E_IEEE_PFC_MBC_SHIFT);
> -	dcbcfg->pfc.pfccap =3D (u8)((buf[0] & I40E_IEEE_PFC_CAP_MASK) >>
> -				  I40E_IEEE_PFC_CAP_SHIFT);
> +	dcbcfg->pfc.willing =3D FIELD_GET(I40E_IEEE_PFC_WILLING_MASK,
> buf[0]);
> +	dcbcfg->pfc.mbc =3D FIELD_GET(I40E_IEEE_PFC_MBC_MASK, buf[0]);
> +	dcbcfg->pfc.pfccap =3D FIELD_GET(I40E_IEEE_PFC_CAP_MASK, buf[0]);
>  	dcbcfg->pfc.pfcenable =3D buf[1];
>  }
>=20
> @@ -198,8 +187,7 @@ static void i40e_parse_ieee_app_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	u8 *buf;
>=20
>  	typelength =3D ntohs(tlv->typelength);
> -	length =3D (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
> -		       I40E_LLDP_TLV_LEN_SHIFT);
> +	length =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
>  	buf =3D tlv->tlvinfo;
>=20
>  	/* The App priority table starts 5 octets after TLV header */ @@ -
> 217,12 +205,10 @@ static void i40e_parse_ieee_app_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	 *        -----------------------------------------
>  	 */
>  	while (offset < length) {
> -		dcbcfg->app[i].priority =3D (u8)((buf[offset] &
> -						I40E_IEEE_APP_PRIO_MASK)
> >>
> -					       I40E_IEEE_APP_PRIO_SHIFT);
> -		dcbcfg->app[i].selector =3D (u8)((buf[offset] &
> -						I40E_IEEE_APP_SEL_MASK)
> >>
> -					       I40E_IEEE_APP_SEL_SHIFT);
> +		dcbcfg->app[i].priority =3D
> FIELD_GET(I40E_IEEE_APP_PRIO_MASK,
> +						    buf[offset]);
> +		dcbcfg->app[i].selector =3D
> FIELD_GET(I40E_IEEE_APP_SEL_MASK,
> +						    buf[offset]);
>  		dcbcfg->app[i].protocolid =3D (buf[offset + 1] << 0x8) |
>  					     buf[offset + 2];
>  		/* Move to next app */
> @@ -250,8 +236,7 @@ static void i40e_parse_ieee_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	u8 subtype;
>=20
>  	ouisubtype =3D ntohl(tlv->ouisubtype);
> -	subtype =3D (u8)((ouisubtype & I40E_LLDP_TLV_SUBTYPE_MASK) >>
> -		       I40E_LLDP_TLV_SUBTYPE_SHIFT);
> +	subtype =3D FIELD_GET(I40E_LLDP_TLV_SUBTYPE_MASK, ouisubtype);
>  	switch (subtype) {
>  	case I40E_IEEE_SUBTYPE_ETS_CFG:
>  		i40e_parse_ieee_etscfg_tlv(tlv, dcbcfg); @@ -301,11 +286,9
> @@ static void i40e_parse_cee_pgcfg_tlv(struct i40e_cee_feat_tlv *tlv,
>  	 *        -----------------------------------------
>  	 */
>  	for (i =3D 0; i < 4; i++) {
> -		priority =3D (u8)((buf[offset] & I40E_CEE_PGID_PRIO_1_MASK)
> >>
> -				 I40E_CEE_PGID_PRIO_1_SHIFT);
> -		etscfg->prioritytable[i * 2] =3D  priority;
> -		priority =3D (u8)((buf[offset] & I40E_CEE_PGID_PRIO_0_MASK)
> >>
> -				 I40E_CEE_PGID_PRIO_0_SHIFT);
> +		priority =3D FIELD_GET(I40E_CEE_PGID_PRIO_1_MASK,
> buf[offset]);
> +		etscfg->prioritytable[i * 2] =3D priority;
> +		priority =3D FIELD_GET(I40E_CEE_PGID_PRIO_0_MASK,
> buf[offset]);
>  		etscfg->prioritytable[i * 2 + 1] =3D priority;
>  		offset++;
>  	}
> @@ -362,8 +345,7 @@ static void i40e_parse_cee_app_tlv(struct
> i40e_cee_feat_tlv *tlv,
>  	u8 i;
>=20
>  	typelength =3D ntohs(tlv->hdr.typelen);
> -	length =3D (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
> -		       I40E_LLDP_TLV_LEN_SHIFT);
> +	length =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
>=20
>  	dcbcfg->numapps =3D length / sizeof(*app);
>=20
> @@ -419,15 +401,13 @@ static void i40e_parse_cee_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  	u32 ouisubtype;
>=20
>  	ouisubtype =3D ntohl(tlv->ouisubtype);
> -	subtype =3D (u8)((ouisubtype & I40E_LLDP_TLV_SUBTYPE_MASK) >>
> -		       I40E_LLDP_TLV_SUBTYPE_SHIFT);
> +	subtype =3D FIELD_GET(I40E_LLDP_TLV_SUBTYPE_MASK, ouisubtype);
>  	/* Return if not CEE DCBX */
>  	if (subtype !=3D I40E_CEE_DCBX_TYPE)
>  		return;
>=20
>  	typelength =3D ntohs(tlv->typelength);
> -	tlvlen =3D (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
> -			I40E_LLDP_TLV_LEN_SHIFT);
> +	tlvlen =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
>  	len =3D sizeof(tlv->typelength) + sizeof(ouisubtype) +
>  	      sizeof(struct i40e_cee_ctrl_tlv);
>  	/* Return if no CEE DCBX Feature TLVs */ @@ -437,11 +417,8 @@
> static void i40e_parse_cee_tlv(struct i40e_lldp_org_tlv *tlv,
>  	sub_tlv =3D (struct i40e_cee_feat_tlv *)((char *)tlv + len);
>  	while (feat_tlv_count < I40E_CEE_MAX_FEAT_TYPE) {
>  		typelength =3D ntohs(sub_tlv->hdr.typelen);
> -		sublen =3D (u16)((typelength &
> -				I40E_LLDP_TLV_LEN_MASK) >>
> -				I40E_LLDP_TLV_LEN_SHIFT);
> -		subtype =3D (u8)((typelength & I40E_LLDP_TLV_TYPE_MASK) >>
> -				I40E_LLDP_TLV_TYPE_SHIFT);
> +		sublen =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
> +		subtype =3D FIELD_GET(I40E_LLDP_TLV_TYPE_MASK,
> typelength);
>  		switch (subtype) {
>  		case I40E_CEE_SUBTYPE_PG_CFG:
>  			i40e_parse_cee_pgcfg_tlv(sub_tlv, dcbcfg); @@ -
> 478,8 +455,7 @@ static void i40e_parse_org_tlv(struct i40e_lldp_org_tlv *=
tlv,
>  	u32 oui;
>=20
>  	ouisubtype =3D ntohl(tlv->ouisubtype);
> -	oui =3D (u32)((ouisubtype & I40E_LLDP_TLV_OUI_MASK) >>
> -		    I40E_LLDP_TLV_OUI_SHIFT);
> +	oui =3D FIELD_GET(I40E_LLDP_TLV_OUI_MASK, ouisubtype);
>  	switch (oui) {
>  	case I40E_IEEE_8021QAZ_OUI:
>  		i40e_parse_ieee_tlv(tlv, dcbcfg);
> @@ -517,10 +493,8 @@ int i40e_lldp_to_dcb_config(u8 *lldpmib,
>  	tlv =3D (struct i40e_lldp_org_tlv *)lldpmib;
>  	while (1) {
>  		typelength =3D ntohs(tlv->typelength);
> -		type =3D (u16)((typelength & I40E_LLDP_TLV_TYPE_MASK) >>
> -			     I40E_LLDP_TLV_TYPE_SHIFT);
> -		length =3D (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
> -			       I40E_LLDP_TLV_LEN_SHIFT);
> +		type =3D FIELD_GET(I40E_LLDP_TLV_TYPE_MASK, typelength);
> +		length =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
>  		offset +=3D sizeof(typelength) + length;
>=20
>  		/* END TLV or beyond LLDPDU size */
> @@ -594,7 +568,7 @@ static void i40e_cee_to_dcb_v1_config(  {
>  	u16 status, tlv_status =3D le16_to_cpu(cee_cfg->tlv_status);
>  	u16 app_prio =3D le16_to_cpu(cee_cfg->oper_app_prio);
> -	u8 i, tc, err;
> +	u8 i, err;
>=20
>  	/* CEE PG data to ETS config */
>  	dcbcfg->etscfg.maxtcs =3D cee_cfg->oper_num_tc; @@ -603,13 +577,13
> @@ static void i40e_cee_to_dcb_v1_config(
>  	 * from those in the CEE Priority Group sub-TLV.
>  	 */
>  	for (i =3D 0; i < 4; i++) {
> -		tc =3D (u8)((cee_cfg->oper_prio_tc[i] &
> -			 I40E_CEE_PGID_PRIO_0_MASK) >>
> -			 I40E_CEE_PGID_PRIO_0_SHIFT);
> -		dcbcfg->etscfg.prioritytable[i * 2] =3D  tc;
> -		tc =3D (u8)((cee_cfg->oper_prio_tc[i] &
> -			 I40E_CEE_PGID_PRIO_1_MASK) >>
> -			 I40E_CEE_PGID_PRIO_1_SHIFT);
> +		u8 tc;
> +
> +		tc =3D FIELD_GET(I40E_CEE_PGID_PRIO_0_MASK,
> +			       cee_cfg->oper_prio_tc[i]);
> +		dcbcfg->etscfg.prioritytable[i * 2] =3D tc;
> +		tc =3D FIELD_GET(I40E_CEE_PGID_PRIO_1_MASK,
> +			       cee_cfg->oper_prio_tc[i]);
>  		dcbcfg->etscfg.prioritytable[i*2 + 1] =3D tc;
>  	}
>=20
> @@ -631,8 +605,7 @@ static void i40e_cee_to_dcb_v1_config(
>  	dcbcfg->pfc.pfcenable =3D cee_cfg->oper_pfc_en;
>  	dcbcfg->pfc.pfccap =3D I40E_MAX_TRAFFIC_CLASS;
>=20
> -	status =3D (tlv_status & I40E_AQC_CEE_APP_STATUS_MASK) >>
> -		  I40E_AQC_CEE_APP_STATUS_SHIFT;
> +	status =3D FIELD_GET(I40E_AQC_CEE_APP_STATUS_MASK, tlv_status);
>  	err =3D (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
>  	/* Add APPs if Error is False */
>  	if (!err) {
> @@ -641,22 +614,19 @@ static void i40e_cee_to_dcb_v1_config(
>=20
>  		/* FCoE APP */
>  		dcbcfg->app[0].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_FCOE_MASK) >>
> -			 I40E_AQC_CEE_APP_FCOE_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_FCOE_MASK,
> app_prio);
>  		dcbcfg->app[0].selector =3D I40E_APP_SEL_ETHTYPE;
>  		dcbcfg->app[0].protocolid =3D I40E_APP_PROTOID_FCOE;
>=20
>  		/* iSCSI APP */
>  		dcbcfg->app[1].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_ISCSI_MASK) >>
> -			 I40E_AQC_CEE_APP_ISCSI_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_ISCSI_MASK,
> app_prio);
>  		dcbcfg->app[1].selector =3D I40E_APP_SEL_TCPIP;
>  		dcbcfg->app[1].protocolid =3D I40E_APP_PROTOID_ISCSI;
>=20
>  		/* FIP APP */
>  		dcbcfg->app[2].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_FIP_MASK) >>
> -			 I40E_AQC_CEE_APP_FIP_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_FIP_MASK,
> app_prio);
>  		dcbcfg->app[2].selector =3D I40E_APP_SEL_ETHTYPE;
>  		dcbcfg->app[2].protocolid =3D I40E_APP_PROTOID_FIP;
>  	}
> @@ -675,7 +645,7 @@ static void i40e_cee_to_dcb_config(  {
>  	u32 status, tlv_status =3D le32_to_cpu(cee_cfg->tlv_status);
>  	u16 app_prio =3D le16_to_cpu(cee_cfg->oper_app_prio);
> -	u8 i, tc, err, sync, oper;
> +	u8 i, err, sync, oper;
>=20
>  	/* CEE PG data to ETS config */
>  	dcbcfg->etscfg.maxtcs =3D cee_cfg->oper_num_tc; @@ -684,13 +654,13
> @@ static void i40e_cee_to_dcb_config(
>  	 * from those in the CEE Priority Group sub-TLV.
>  	 */
>  	for (i =3D 0; i < 4; i++) {
> -		tc =3D (u8)((cee_cfg->oper_prio_tc[i] &
> -			 I40E_CEE_PGID_PRIO_0_MASK) >>
> -			 I40E_CEE_PGID_PRIO_0_SHIFT);
> -		dcbcfg->etscfg.prioritytable[i * 2] =3D  tc;
> -		tc =3D (u8)((cee_cfg->oper_prio_tc[i] &
> -			 I40E_CEE_PGID_PRIO_1_MASK) >>
> -			 I40E_CEE_PGID_PRIO_1_SHIFT);
> +		u8 tc;
> +
> +		tc =3D FIELD_GET(I40E_CEE_PGID_PRIO_0_MASK,
> +			       cee_cfg->oper_prio_tc[i]);
> +		dcbcfg->etscfg.prioritytable[i * 2] =3D tc;
> +		tc =3D FIELD_GET(I40E_CEE_PGID_PRIO_1_MASK,
> +			       cee_cfg->oper_prio_tc[i]);
>  		dcbcfg->etscfg.prioritytable[i * 2 + 1] =3D tc;
>  	}
>=20
> @@ -713,8 +683,7 @@ static void i40e_cee_to_dcb_config(
>  	dcbcfg->pfc.pfccap =3D I40E_MAX_TRAFFIC_CLASS;
>=20
>  	i =3D 0;
> -	status =3D (tlv_status & I40E_AQC_CEE_FCOE_STATUS_MASK) >>
> -		  I40E_AQC_CEE_FCOE_STATUS_SHIFT;
> +	status =3D FIELD_GET(I40E_AQC_CEE_FCOE_STATUS_MASK, tlv_status);
>  	err =3D (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
>  	sync =3D (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
>  	oper =3D (status & I40E_TLV_STATUS_OPER) ? 1 : 0; @@ -722,15
> +691,13 @@ static void i40e_cee_to_dcb_config(
>  	if (!err && sync && oper) {
>  		/* FCoE APP */
>  		dcbcfg->app[i].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_FCOE_MASK) >>
> -			 I40E_AQC_CEE_APP_FCOE_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_FCOE_MASK,
> app_prio);
>  		dcbcfg->app[i].selector =3D I40E_APP_SEL_ETHTYPE;
>  		dcbcfg->app[i].protocolid =3D I40E_APP_PROTOID_FCOE;
>  		i++;
>  	}
>=20
> -	status =3D (tlv_status & I40E_AQC_CEE_ISCSI_STATUS_MASK) >>
> -		  I40E_AQC_CEE_ISCSI_STATUS_SHIFT;
> +	status =3D FIELD_GET(I40E_AQC_CEE_ISCSI_STATUS_MASK, tlv_status);
>  	err =3D (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
>  	sync =3D (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
>  	oper =3D (status & I40E_TLV_STATUS_OPER) ? 1 : 0; @@ -738,15
> +705,13 @@ static void i40e_cee_to_dcb_config(
>  	if (!err && sync && oper) {
>  		/* iSCSI APP */
>  		dcbcfg->app[i].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_ISCSI_MASK) >>
> -			 I40E_AQC_CEE_APP_ISCSI_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_ISCSI_MASK,
> app_prio);
>  		dcbcfg->app[i].selector =3D I40E_APP_SEL_TCPIP;
>  		dcbcfg->app[i].protocolid =3D I40E_APP_PROTOID_ISCSI;
>  		i++;
>  	}
>=20
> -	status =3D (tlv_status & I40E_AQC_CEE_FIP_STATUS_MASK) >>
> -		  I40E_AQC_CEE_FIP_STATUS_SHIFT;
> +	status =3D FIELD_GET(I40E_AQC_CEE_FIP_STATUS_MASK, tlv_status);
>  	err =3D (status & I40E_TLV_STATUS_ERR) ? 1 : 0;
>  	sync =3D (status & I40E_TLV_STATUS_SYNC) ? 1 : 0;
>  	oper =3D (status & I40E_TLV_STATUS_OPER) ? 1 : 0; @@ -754,8 +719,7
> @@ static void i40e_cee_to_dcb_config(
>  	if (!err && sync && oper) {
>  		/* FIP APP */
>  		dcbcfg->app[i].priority =3D
> -			(app_prio & I40E_AQC_CEE_APP_FIP_MASK) >>
> -			 I40E_AQC_CEE_APP_FIP_SHIFT;
> +			FIELD_GET(I40E_AQC_CEE_APP_FIP_MASK,
> app_prio);
>  		dcbcfg->app[i].selector =3D I40E_APP_SEL_ETHTYPE;
>  		dcbcfg->app[i].protocolid =3D I40E_APP_PROTOID_FIP;
>  		i++;
> @@ -1188,7 +1152,7 @@ static void i40e_add_ieee_app_pri_tlv(struct
> i40e_lldp_org_tlv *tlv,
>  		selector =3D dcbcfg->app[i].selector & 0x7;
>  		buf[offset] =3D (priority << I40E_IEEE_APP_PRIO_SHIFT) |
> selector;
>  		buf[offset + 1] =3D (dcbcfg->app[i].protocolid >> 0x8) & 0xFF;
> -		buf[offset + 2] =3D  dcbcfg->app[i].protocolid & 0xFF;
> +		buf[offset + 2] =3D dcbcfg->app[i].protocolid & 0xFF;
>  		/* Move to next app */
>  		offset +=3D 3;
>  		i++;
> @@ -1284,8 +1248,7 @@ int i40e_dcb_config_to_lldp(u8 *lldpmib, u16
> *miblen,
>  	do {
>  		i40e_add_dcb_tlv(tlv, dcbcfg, tlvid++);
>  		typelength =3D ntohs(tlv->typelength);
> -		length =3D (u16)((typelength & I40E_LLDP_TLV_LEN_MASK) >>
> -				I40E_LLDP_TLV_LEN_SHIFT);
> +		length =3D FIELD_GET(I40E_LLDP_TLV_LEN_MASK, typelength);
>  		if (length)
>  			offset +=3D length + I40E_IEEE_TLV_HEADER_LENGTH;
>  		/* END TLV or beyond LLDPDU size */
> @@ -1537,8 +1500,7 @@ u8 i40e_dcb_hw_get_num_tc(struct i40e_hw
> *hw)  {
>  	u32 reg =3D rd32(hw, I40E_PRTDCB_GENC);
>=20
> -	return (u8)((reg & I40E_PRTDCB_GENC_NUMTC_MASK) >>
> -		I40E_PRTDCB_GENC_NUMTC_SHIFT);
> +	return FIELD_GET(I40E_PRTDCB_GENC_NUMTC_MASK, reg);
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> index 4721845fda6e..b96a92187ab3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c
> @@ -21,8 +21,7 @@ static void i40e_get_pfc_delay(struct i40e_hw *hw, u16
> *delay)
>  	u32 val;
>=20
>  	val =3D rd32(hw, I40E_PRTDCB_GENC);
> -	*delay =3D (u16)((val & I40E_PRTDCB_GENC_PFCLDA_MASK) >>
> -		       I40E_PRTDCB_GENC_PFCLDA_SHIFT);
> +	*delay =3D FIELD_GET(I40E_PRTDCB_GENC_PFCLDA_MASK, val);
>  }
>=20
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> index cf25bfc5dc3f..2f53f0f53bc3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
> @@ -81,8 +81,8 @@ static int i40e_ddp_does_profile_exist(struct i40e_hw
> *hw,  static bool i40e_ddp_profiles_overlap(struct i40e_profile_info *new=
,
>  				      struct i40e_profile_info *old)  {
> -	unsigned int group_id_old =3D (u8)((old->track_id & 0x00FF0000) >>
> 16);
> -	unsigned int group_id_new =3D (u8)((new->track_id & 0x00FF0000) >>
> 16);
> +	unsigned int group_id_old =3D FIELD_GET(0x00FF0000, old->track_id);
> +	unsigned int group_id_new =3D FIELD_GET(0x00FF0000, new-
> >track_id);
>=20
>  	/* 0x00 group must be only the first */
>  	if (group_id_new =3D=3D 0)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index afbe921f6d20..585b599bedeb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1959,9 +1959,8 @@ int i40e_get_eeprom_len(struct net_device
> *netdev)
>  		i40e_trace(ioctl_get_eeprom_len, np->vsi->back, val);
>  		return val;
>  	}
> -	val =3D (rd32(hw, I40E_GLPCI_LBARCTRL)
> -		& I40E_GLPCI_LBARCTRL_FL_SIZE_MASK)
> -		>> I40E_GLPCI_LBARCTRL_FL_SIZE_SHIFT;
> +	val =3D FIELD_GET(I40E_GLPCI_LBARCTRL_FL_SIZE_MASK,
> +			rd32(hw, I40E_GLPCI_LBARCTRL));
>  	/* register returns value in power of 2, 64Kbyte chunks. */
>  	val =3D (64 * 1024) * BIT(val);
>  	i40e_trace(ioctl_get_eeprom_len, np->vsi->back, val); @@ -3300,7
> +3299,7 @@ static int i40e_parse_rx_flow_user_data(struct
> ethtool_rx_flow_spec *fsp,
>  	} else if (valid) {
>  		data->flex_word =3D value & I40E_USERDEF_FLEX_WORD;
>  		data->flex_offset =3D
> -			(value & I40E_USERDEF_FLEX_OFFSET) >> 16;
> +			FIELD_GET(I40E_USERDEF_FLEX_OFFSET, value);
>  		data->flex_filter =3D true;
>  	}
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 0dfe472747c6..903a1e66697d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -1197,11 +1197,9 @@ static void i40e_update_pf_stats(struct i40e_pf
> *pf)
>=20
>  	val =3D rd32(hw, I40E_PRTPM_EEE_STAT);
>  	nsd->tx_lpi_status =3D
> -		       (val & I40E_PRTPM_EEE_STAT_TX_LPI_STATUS_MASK) >>
> -			I40E_PRTPM_EEE_STAT_TX_LPI_STATUS_SHIFT;
> +
> FIELD_GET(I40E_PRTPM_EEE_STAT_TX_LPI_STATUS_MASK, val);
>  	nsd->rx_lpi_status =3D
> -		       (val & I40E_PRTPM_EEE_STAT_RX_LPI_STATUS_MASK) >>
> -			I40E_PRTPM_EEE_STAT_RX_LPI_STATUS_SHIFT;
> +
> FIELD_GET(I40E_PRTPM_EEE_STAT_RX_LPI_STATUS_MASK, val);
>  	i40e_stat_update32(hw, I40E_PRTPM_TLPIC,
>  			   pf->stat_offsets_loaded,
>  			   &osd->tx_lpi_count, &nsd->tx_lpi_count); @@ -
> 4340,8 +4338,7 @@ static irqreturn_t i40e_intr(int irq, void *data)
>  			set_bit(__I40E_RESET_INTR_RECEIVED, pf->state);
>  		ena_mask &=3D ~I40E_PFINT_ICR0_ENA_GRST_MASK;
>  		val =3D rd32(hw, I40E_GLGEN_RSTAT);
> -		val =3D (val & I40E_GLGEN_RSTAT_RESET_TYPE_MASK)
> -		       >> I40E_GLGEN_RSTAT_RESET_TYPE_SHIFT;
> +		val =3D FIELD_GET(I40E_GLGEN_RSTAT_RESET_TYPE_MASK, val);
>  		if (val =3D=3D I40E_RESET_CORER) {
>  			pf->corer_count++;
>  			i40e_trace(state_reset_corer, pf, pf->corer_count);
> @@ -5010,8 +5007,8 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
>  			 * next_q field of the registers.
>  			 */
>  			val =3D rd32(hw, I40E_PFINT_LNKLSTN(vector - 1));
> -			qp =3D (val &
> I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK)
> -				>>
> I40E_PFINT_LNKLSTN_FIRSTQ_INDX_SHIFT;
> +			qp =3D
> FIELD_GET(I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK,
> +				       val);
>  			val |=3D I40E_QUEUE_END_OF_LIST
>  				<<
> I40E_PFINT_LNKLSTN_FIRSTQ_INDX_SHIFT;
>  			wr32(hw, I40E_PFINT_LNKLSTN(vector - 1), val); @@
> -5033,8 +5030,8 @@ static void i40e_vsi_free_irq(struct i40e_vsi *vsi)
>=20
>  				val =3D rd32(hw, I40E_QINT_TQCTL(qp));
>=20
> -				next =3D (val &
> I40E_QINT_TQCTL_NEXTQ_INDX_MASK)
> -					>>
> I40E_QINT_TQCTL_NEXTQ_INDX_SHIFT;
> +				next =3D
> FIELD_GET(I40E_QINT_TQCTL_NEXTQ_INDX_MASK,
> +						 val);
>=20
>  				val &=3D
> ~(I40E_QINT_TQCTL_MSIX_INDX_MASK  |
>=20
> I40E_QINT_TQCTL_MSIX0_INDX_MASK | @@ -5052,8 +5049,7 @@ static
> void i40e_vsi_free_irq(struct i40e_vsi *vsi)
>  		free_irq(pf->pdev->irq, pf);
>=20
>  		val =3D rd32(hw, I40E_PFINT_LNKLST0);
> -		qp =3D (val & I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK)
> -			>> I40E_PFINT_LNKLSTN_FIRSTQ_INDX_SHIFT;
> +		qp =3D FIELD_GET(I40E_PFINT_LNKLSTN_FIRSTQ_INDX_MASK,
> val);
>  		val |=3D I40E_QUEUE_END_OF_LIST
>  			<< I40E_PFINT_LNKLST0_FIRSTQ_INDX_SHIFT;
>  		wr32(hw, I40E_PFINT_LNKLST0, val);
> @@ -9556,18 +9552,18 @@ static void
> i40e_handle_lan_overflow_event(struct i40e_pf *pf,
>  	dev_dbg(&pf->pdev->dev, "overflow Rx Queue Number =3D %d
> QTX_CTL=3D0x%08x\n",
>  		queue, qtx_ctl);
>=20
> +	if (FIELD_GET(I40E_QTX_CTL_PFVF_Q_MASK, qtx_ctl) !=3D
> +	    I40E_QTX_CTL_VF_QUEUE)
> +		return;
> +
>  	/* Queue belongs to VF, find the VF and issue VF reset */
> -	if (((qtx_ctl & I40E_QTX_CTL_PFVF_Q_MASK)
> -	    >> I40E_QTX_CTL_PFVF_Q_SHIFT) =3D=3D I40E_QTX_CTL_VF_QUEUE) {
> -		vf_id =3D (u16)((qtx_ctl & I40E_QTX_CTL_VFVM_INDX_MASK)
> -			 >> I40E_QTX_CTL_VFVM_INDX_SHIFT);
> -		vf_id -=3D hw->func_caps.vf_base_id;
> -		vf =3D &pf->vf[vf_id];
> -		i40e_vc_notify_vf_reset(vf);
> -		/* Allow VF to process pending reset notification */
> -		msleep(20);
> -		i40e_reset_vf(vf, false);
> -	}
> +	vf_id =3D FIELD_GET(I40E_QTX_CTL_VFVM_INDX_MASK, qtx_ctl);
> +	vf_id -=3D hw->func_caps.vf_base_id;
> +	vf =3D &pf->vf[vf_id];
> +	i40e_vc_notify_vf_reset(vf);
> +	/* Allow VF to process pending reset notification */
> +	msleep(20);
> +	i40e_reset_vf(vf, false);
>  }
>=20
>  /**
> @@ -9593,8 +9589,7 @@ u32 i40e_get_current_fd_count(struct i40e_pf
> *pf)
>=20
>  	val =3D rd32(&pf->hw, I40E_PFQF_FDSTAT);
>  	fcnt_prog =3D (val & I40E_PFQF_FDSTAT_GUARANT_CNT_MASK) +
> -		    ((val & I40E_PFQF_FDSTAT_BEST_CNT_MASK) >>
> -		      I40E_PFQF_FDSTAT_BEST_CNT_SHIFT);
> +		    FIELD_GET(I40E_PFQF_FDSTAT_BEST_CNT_MASK, val);
>  	return fcnt_prog;
>  }
>=20
> @@ -9608,8 +9603,7 @@ u32 i40e_get_global_fd_count(struct i40e_pf *pf)
>=20
>  	val =3D rd32(&pf->hw, I40E_GLQF_FDCNT_0);
>  	fcnt_prog =3D (val & I40E_GLQF_FDCNT_0_GUARANT_CNT_MASK) +
> -		    ((val & I40E_GLQF_FDCNT_0_BESTCNT_MASK) >>
> -		     I40E_GLQF_FDCNT_0_BESTCNT_SHIFT);
> +		    FIELD_GET(I40E_GLQF_FDCNT_0_BESTCNT_MASK, val);
>  	return fcnt_prog;
>  }
>=20
> @@ -11200,14 +11194,10 @@ static void i40e_handle_mdd_event(struct
> i40e_pf *pf)
>  	/* find what triggered the MDD event */
>  	reg =3D rd32(hw, I40E_GL_MDET_TX);
>  	if (reg & I40E_GL_MDET_TX_VALID_MASK) {
> -		u8 pf_num =3D (reg & I40E_GL_MDET_TX_PF_NUM_MASK) >>
> -				I40E_GL_MDET_TX_PF_NUM_SHIFT;
> -		u16 vf_num =3D (reg & I40E_GL_MDET_TX_VF_NUM_MASK) >>
> -				I40E_GL_MDET_TX_VF_NUM_SHIFT;
> -		u8 event =3D (reg & I40E_GL_MDET_TX_EVENT_MASK) >>
> -				I40E_GL_MDET_TX_EVENT_SHIFT;
> -		u16 queue =3D ((reg & I40E_GL_MDET_TX_QUEUE_MASK) >>
> -				I40E_GL_MDET_TX_QUEUE_SHIFT) -
> +		u8 pf_num =3D FIELD_GET(I40E_GL_MDET_TX_PF_NUM_MASK,
> reg);
> +		u16 vf_num =3D
> FIELD_GET(I40E_GL_MDET_TX_VF_NUM_MASK, reg);
> +		u8 event =3D FIELD_GET(I40E_GL_MDET_TX_EVENT_MASK, reg);
> +		u16 queue =3D FIELD_GET(I40E_GL_MDET_TX_QUEUE_MASK,
> reg) -
>  				pf->hw.func_caps.base_queue;
>  		if (netif_msg_tx_err(pf))
>  			dev_info(&pf->pdev->dev, "Malicious Driver Detection
> event 0x%02x on TX queue %d PF number 0x%02x VF number 0x%02x\n",
> @@ -11217,12 +11207,9 @@ static void i40e_handle_mdd_event(struct
> i40e_pf *pf)
>  	}
>  	reg =3D rd32(hw, I40E_GL_MDET_RX);
>  	if (reg & I40E_GL_MDET_RX_VALID_MASK) {
> -		u8 func =3D (reg & I40E_GL_MDET_RX_FUNCTION_MASK) >>
> -				I40E_GL_MDET_RX_FUNCTION_SHIFT;
> -		u8 event =3D (reg & I40E_GL_MDET_RX_EVENT_MASK) >>
> -				I40E_GL_MDET_RX_EVENT_SHIFT;
> -		u16 queue =3D ((reg & I40E_GL_MDET_RX_QUEUE_MASK) >>
> -				I40E_GL_MDET_RX_QUEUE_SHIFT) -
> +		u8 func =3D FIELD_GET(I40E_GL_MDET_RX_FUNCTION_MASK,
> reg);
> +		u8 event =3D FIELD_GET(I40E_GL_MDET_RX_EVENT_MASK,
> reg);
> +		u16 queue =3D FIELD_GET(I40E_GL_MDET_RX_QUEUE_MASK,
> reg) -
>  				pf->hw.func_caps.base_queue;
>  		if (netif_msg_rx_err(pf))
>  			dev_info(&pf->pdev->dev, "Malicious Driver Detection
> event 0x%02x on RX queue %d of function 0x%02x\n", @@ -16187,8
> +16174,8 @@ static int i40e_probe(struct pci_dev *pdev, const struct
> pci_device_id *ent)
>=20
>  	/* make sure the MFS hasn't been set lower than the default */
> #define MAX_FRAME_SIZE_DEFAULT 0x2600
> -	val =3D (rd32(&pf->hw, I40E_PRTGL_SAH) &
> -	       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
> +	val =3D FIELD_GET(I40E_PRTGL_SAH_MFS_MASK,
> +			rd32(&pf->hw, I40E_PRTGL_SAH));
>  	if (val < MAX_FRAME_SIZE_DEFAULT)
>  		dev_warn(&pdev->dev, "MFS for port %x has been set below
> the default: %x\n",
>  			 pf->hw.port, val);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> index 70215ae92b0c..987534b0285b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> @@ -27,8 +27,7 @@ int i40e_init_nvm(struct i40e_hw *hw)
>  	 * as the blank mode may be used in the factory line.
>  	 */
>  	gens =3D rd32(hw, I40E_GLNVM_GENS);
> -	sr_size =3D ((gens & I40E_GLNVM_GENS_SR_SIZE_MASK) >>
> -			   I40E_GLNVM_GENS_SR_SIZE_SHIFT);
> +	sr_size =3D FIELD_GET(I40E_GLNVM_GENS_SR_SIZE_MASK, gens);
>  	/* Switching to words (sr_size contains power of 2KB) */
>  	nvm->sr_size =3D BIT(sr_size) * I40E_SR_WORDS_IN_1KB;
>=20
> @@ -194,9 +193,8 @@ static int i40e_read_nvm_word_srctl(struct i40e_hw
> *hw, u16 offset,
>  		ret_code =3D i40e_poll_sr_srctl_done_bit(hw);
>  		if (!ret_code) {
>  			sr_reg =3D rd32(hw, I40E_GLNVM_SRDATA);
> -			*data =3D (u16)((sr_reg &
> -				       I40E_GLNVM_SRDATA_RDDATA_MASK)
> -				    >> I40E_GLNVM_SRDATA_RDDATA_SHIFT);
> +			*data =3D
> FIELD_GET(I40E_GLNVM_SRDATA_RDDATA_MASK,
> +					  sr_reg);
>  		}
>  	}
>  	if (ret_code)
> @@ -772,13 +770,12 @@ static inline u8 i40e_nvmupd_get_module(u32 val)
> }  static inline u8 i40e_nvmupd_get_transaction(u32 val)  {
> -	return (u8)((val & I40E_NVM_TRANS_MASK) >>
> I40E_NVM_TRANS_SHIFT);
> +	return FIELD_GET(I40E_NVM_TRANS_MASK, val);
>  }
>=20
>  static inline u8 i40e_nvmupd_get_preservation_flags(u32 val)  {
> -	return (u8)((val & I40E_NVM_PRESERVATION_FLAGS_MASK) >>
> -		    I40E_NVM_PRESERVATION_FLAGS_SHIFT);
> +	return FIELD_GET(I40E_NVM_PRESERVATION_FLAGS_MASK, val);
>  }
>=20
>  static const char * const i40e_nvm_update_state_str[] =3D { diff --git
> a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 1cf993a79438..e7ebcb09f23c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -1480,8 +1480,8 @@ void i40e_ptp_init(struct i40e_pf *pf)
>  	/* Only one PF is assigned to control 1588 logic per port. Do not
>  	 * enable any support for PFs not assigned via PRTTSYN_CTL0.PF_ID
>  	 */
> -	pf_id =3D (rd32(hw, I40E_PRTTSYN_CTL0) &
> I40E_PRTTSYN_CTL0_PF_ID_MASK) >>
> -		I40E_PRTTSYN_CTL0_PF_ID_SHIFT;
> +	pf_id =3D FIELD_GET(I40E_PRTTSYN_CTL0_PF_ID_MASK,
> +			  rd32(hw, I40E_PRTTSYN_CTL0));
>  	if (hw->pf_id !=3D pf_id) {
>  		clear_bit(I40E_FLAG_PTP_ENA, pf->flags);
>  		dev_info(&pf->pdev->dev, "%s: PTP not supported on %s\n",
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index b0df3dde1386..971ba3322038 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -686,8 +686,7 @@ static void i40e_fd_handle_status(struct i40e_ring
> *rx_ring, u64 qword0_raw,
>  	u32 error;
>=20
>  	qw0 =3D (struct i40e_16b_rx_wb_qw0 *)&qword0_raw;
> -	error =3D (qword1 &
> I40E_RX_PROG_STATUS_DESC_QW1_ERROR_MASK) >>
> -		I40E_RX_PROG_STATUS_DESC_QW1_ERROR_SHIFT;
> +	error =3D
> FIELD_GET(I40E_RX_PROG_STATUS_DESC_QW1_ERROR_MASK, qword1);
>=20
>  	if (error =3D=3D BIT(I40E_RX_PROG_STATUS_DESC_FD_TBL_FULL_SHIFT)) {
>  		pf->fd_inv =3D le32_to_cpu(qw0->hi_dword.fd_id); @@ -
> 1398,8 +1397,7 @@ void i40e_clean_programming_status(struct i40e_ring
> *rx_ring, u64 qword0_raw,  {
>  	u8 id;
>=20
> -	id =3D (qword1 & I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK)
> >>
> -		  I40E_RX_PROG_STATUS_DESC_QW1_PROGID_SHIFT;
> +	id =3D FIELD_GET(I40E_RX_PROG_STATUS_DESC_QW1_PROGID_MASK,
> qword1);
>=20
>  	if (id =3D=3D I40E_RX_PROG_STATUS_DESC_FD_FILTER_STATUS)
>  		i40e_fd_handle_status(rx_ring, qword0_raw, qword1, id);
> @@ -1759,11 +1757,9 @@ static inline void i40e_rx_checksum(struct
> i40e_vsi *vsi,
>  	u64 qword;
>=20
>  	qword =3D le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> -	ptype =3D (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> I40E_RXD_QW1_PTYPE_SHIFT;
> -	rx_error =3D (qword & I40E_RXD_QW1_ERROR_MASK) >>
> -		   I40E_RXD_QW1_ERROR_SHIFT;
> -	rx_status =3D (qword & I40E_RXD_QW1_STATUS_MASK) >>
> -		    I40E_RXD_QW1_STATUS_SHIFT;
> +	ptype =3D FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, qword);
> +	rx_error =3D FIELD_GET(I40E_RXD_QW1_ERROR_MASK, qword);
> +	rx_status =3D FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
>  	decoded =3D decode_rx_desc_ptype(ptype);
>=20
>  	skb->ip_summed =3D CHECKSUM_NONE;
> @@ -1896,13 +1892,10 @@ void i40e_process_skb_fields(struct i40e_ring
> *rx_ring,
>  			     union i40e_rx_desc *rx_desc, struct sk_buff *skb)  {
>  	u64 qword =3D le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> -	u32 rx_status =3D (qword & I40E_RXD_QW1_STATUS_MASK) >>
> -			I40E_RXD_QW1_STATUS_SHIFT;
> +	u32 rx_status =3D FIELD_GET(I40E_RXD_QW1_STATUS_MASK, qword);
>  	u32 tsynvalid =3D rx_status &
> I40E_RXD_QW1_STATUS_TSYNVALID_MASK;
> -	u32 tsyn =3D (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK)
> >>
> -		   I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;
> -	u8 rx_ptype =3D (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> -		      I40E_RXD_QW1_PTYPE_SHIFT;
> +	u32 tsyn =3D FIELD_GET(I40E_RXD_QW1_STATUS_TSYNINDX_MASK,
> rx_status);
> +	u8 rx_ptype =3D FIELD_GET(I40E_RXD_QW1_PTYPE_MASK, qword);
>=20
>  	if (unlikely(tsynvalid))
>  		i40e_ptp_rx_hwtstamp(rx_ring->vsi->back, skb, tsyn); @@ -
> 2549,8 +2542,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring,=
 int
> budget,
>  			continue;
>  		}
>=20
> -		size =3D (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> -		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> +		size =3D FIELD_GET(I40E_RXD_QW1_LENGTH_PBUF_MASK,
> qword);
>  		if (!size)
>  			break;
>=20
> @@ -3594,8 +3586,7 @@ static inline int i40e_tx_map(struct i40e_ring
> *tx_ring, struct sk_buff *skb,
>=20
>  	if (tx_flags & I40E_TX_FLAGS_HW_VLAN) {
>  		td_cmd |=3D I40E_TX_DESC_CMD_IL2TAG1;
> -		td_tag =3D (tx_flags & I40E_TX_FLAGS_VLAN_MASK) >>
> -			 I40E_TX_FLAGS_VLAN_SHIFT;
> +		td_tag =3D FIELD_GET(I40E_TX_FLAGS_VLAN_MASK, tx_flags);
>  	}
>=20
>  	first->tx_flags =3D tx_flags;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> index 5a45c53e6770..024e5d541e17 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> @@ -474,10 +474,10 @@ static void i40e_release_rdma_qvlist(struct i40e_vf
> *vf)
>  			 */
>  			reg_idx =3D (msix_vf - 1) * vf->vf_id + qv_info->ceq_idx;
>  			reg =3D rd32(hw, I40E_VPINT_CEQCTL(reg_idx));
> -			next_q_index =3D (reg &
> I40E_VPINT_CEQCTL_NEXTQ_INDX_MASK)
> -					>>
> I40E_VPINT_CEQCTL_NEXTQ_INDX_SHIFT;
> -			next_q_type =3D (reg &
> I40E_VPINT_CEQCTL_NEXTQ_TYPE_MASK)
> -					>>
> I40E_VPINT_CEQCTL_NEXTQ_TYPE_SHIFT;
> +			next_q_index =3D
> FIELD_GET(I40E_VPINT_CEQCTL_NEXTQ_INDX_MASK,
> +						 reg);
> +			next_q_type =3D
> FIELD_GET(I40E_VPINT_CEQCTL_NEXTQ_TYPE_MASK,
> +						reg);
>=20
>  			reg_idx =3D ((msix_vf - 1) * vf->vf_id) + (v_idx - 1);
>  			reg =3D (next_q_index &
> @@ -555,10 +555,10 @@ i40e_config_rdma_qvlist(struct i40e_vf *vf,
>  		 * queue on top. Also link it with the new queue in CEQCTL.
>  		 */
>  		reg =3D rd32(hw, I40E_VPINT_LNKLSTN(reg_idx));
> -		next_q_idx =3D ((reg &
> I40E_VPINT_LNKLSTN_FIRSTQ_INDX_MASK) >>
> -				I40E_VPINT_LNKLSTN_FIRSTQ_INDX_SHIFT);
> -		next_q_type =3D ((reg &
> I40E_VPINT_LNKLSTN_FIRSTQ_TYPE_MASK) >>
> -				I40E_VPINT_LNKLSTN_FIRSTQ_TYPE_SHIFT);
> +		next_q_idx =3D
> FIELD_GET(I40E_VPINT_LNKLSTN_FIRSTQ_INDX_MASK,
> +				       reg);
> +		next_q_type =3D
> FIELD_GET(I40E_VPINT_LNKLSTN_FIRSTQ_TYPE_MASK,
> +					reg);
>=20
>  		if (qv_info->ceq_idx !=3D I40E_QUEUE_INVALID_IDX) {
>  			reg_idx =3D (msix_vf - 1) * vf->vf_id + qv_info->ceq_idx;
> @@ -4674,8 +4674,7 @@ int i40e_ndo_get_vf_config(struct net_device
> *netdev,
>  	ivi->max_tx_rate =3D vf->tx_rate;
>  	ivi->min_tx_rate =3D 0;
>  	ivi->vlan =3D le16_to_cpu(vsi->info.pvid) & I40E_VLAN_MASK;
> -	ivi->qos =3D (le16_to_cpu(vsi->info.pvid) & I40E_PRIORITY_MASK) >>
> -		   I40E_VLAN_PRIORITY_SHIFT;
> +	ivi->qos =3D FIELD_GET(I40E_PRIORITY_MASK, le16_to_cpu(vsi-
> >info.pvid));
>  	if (vf->link_forced =3D=3D false)
>  		ivi->linkstate =3D IFLA_VF_LINK_STATE_AUTO;
>  	else if (vf->link_up =3D=3D true)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index e99fa854d17f..af7d5fa6cdc1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -476,8 +476,7 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, i=
nt
> budget)
>  			continue;
>  		}
>=20
> -		size =3D (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> -		       I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> +		size =3D FIELD_GET(I40E_RXD_QW1_LENGTH_PBUF_MASK,
> qword);
>  		if (!size)
>  			break;
>=20
> --
> 2.39.3


