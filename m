Return-Path: <netdev+bounces-57416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C307D8130F2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606BC1F21197
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE451C4B;
	Thu, 14 Dec 2023 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdIdBTqd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EDF98
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702559407; x=1734095407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JT8l2WiqKGDiUY4ZHjmgZTMzqhSRAzbukcTGu8wnE50=;
  b=ZdIdBTqdbYAAy9KS6JRZ01NS72RIrVyIb9GacJT16qVn03BRbQ+LULIP
   dRRF7iTSeb19Lx5LgowtEjE+yWQ3q+3u2Cv/xkUmN7D9hHme7recM9/3E
   ncRJLW8oybykBKDnwdulL7bx6fKnVXtPgqqt697ztXI+Lio6NJYEv/xDq
   vLpWd+I0zp0ho3izNCMsIa22NS+PGUo87NnlHP6ovU2693bUXumc1fxi5
   PKnaUDo/veqnCWkau2nLrlOHKuNNulo8T3gZfWVhdp0EK9VnMefexWUJo
   NqZAne+xKbZwI6iTe3Ciw9/kKSH0x7z3D0k1rgrUWtz+b3Ff0T4/OHP3e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="375270561"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="375270561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 05:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892463073"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="892463073"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 05:10:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:10:06 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 05:10:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 05:10:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 05:10:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5+eqRiPCKzr+AZf372hDlnv5cdSjJeLK7eNWwA7DUnxFFhudc57TlbcPiK8A6j76WYN8nQDgHvYW3MnFGLjNRWBAhW6STZtVXlZH5R/QelRw4I+xrXzP5EiDZyUf/Z0DOMbUIkjJtHUOdZ25kqbTc7z09c3nGuxzJk8b8bdRJCPCWsibm0OtgfLLl6FAJYTAFF09PsbtBRQB5Q2XTmDIlsuyeT3nsUWq7lNExeo0+OLFXRPQjadB2F6BJZOyAS0D2Mhd1O0kCC3HzbzodBcVAbo+WFT5W6ANvZ94AjIfb+ANDWYwVDGtZTD1yFxlqSqiVJixVVYjm8MXqI3f0rbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61IY3lXQlswJnsb9zKKMEA0i8atgxvBw2BOV5cNmV/s=;
 b=jwT6Lp2ORbNGdnD247sbihuGmSM0eBTyzGcNx+8eW06zNeS+wWuW/Uenx2jHfQaZ/5M/gBRm7yR2mDCzGwgeL3APHkgzMmozz9WDDIR9aMK8GYN0EDdERJPb8WApToYBgxvAVIHSG96itE2l9EOexpe6XDv0HHY2yUXeMfLVcr8igDYHt4hv4GHdyW3VkA3BqwRX7yT8A1lN2F2FVGgtWaXzeuBrCdPgrQUPw4JrOnERzVv4T0hZwCkemNqYU91xNBVLx2x3h7zZOrj3rlrbnvh1+dyccnrWxa5jVIClE1MbBQqmblXjOa6v7DHFkfkJhe0jOGX2dpH+pA3m1W+Nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3521.namprd11.prod.outlook.com (2603:10b6:208:7b::32)
 by SA1PR11MB8542.namprd11.prod.outlook.com (2603:10b6:806:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 13:09:59 +0000
Received: from BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c]) by BL0PR11MB3521.namprd11.prod.outlook.com
 ([fe80::1498:c32d:2d2:975c%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 13:09:59 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 00/15] intel: use bitfield
 operations
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 00/15] intel: use bitfield
 operations
Thread-Index: AQHaJ9/hQl4b8vNF8Euv3HRZ0y4mf7Cozc9Q
Date: Thu, 14 Dec 2023 13:09:58 +0000
Message-ID: <BL0PR11MB3521C79E3D0AFFDBFF3662308F8CA@BL0PR11MB3521.namprd11.prod.outlook.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3521:EE_|SA1PR11MB8542:EE_
x-ms-office365-filtering-correlation-id: 7578937b-9ef2-4290-e350-08dbfca5f991
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3IJGR9ELG1szPCbT6+7JOuudGxHYAAfgfWEm4yu/BuuO1q4S1StXgRMS+P3OzUIYGCWw0YxrPGrwX0e96aTBreASpZmSAlDn0O7hOcR3KpmQYBMneJR2RbyMjsPdewBKjlKAPEkFmNfVaJmP5NXpRmp3qwbppoG/BwJU0Nda/jcJg5OJ49O1yX63GETxW/bfStNXax1Q4WCJAVg0N1Q5XlV3Bz08nOGiYtPxpcK50a3Lxd8hjsTMOdX/8PjAe9uMD2GjwEi+6nWz5Ix6vCE+u0DsMTAtZ26Y9WF63SvBJs6jYee0kJhmzVW/SCpqrIp8hJ0NdAIn0eZvqfUou5YhPpIWCLAx0OFCpWMTcfFqVXTwS8VON53m6CACicNBvAd9UrtUtxHAp2M9+jw2H7mdkggriwqOWpivGBmxwWtJjuE7Ra96/xs2iOJPhgHWu9m4KIKApIQF9jhrmIMnFV/BP1tHX2WoEmuJGG+uV02tlzqvsGTUOHq9lDLks2ZKRYkHQZaHTbSMDMjgSgJwfR9XqAL9Y6UG5Sdv+l/LBT7zaW41ivsLLtRdHKeOfA7ZMcJfx7ymXXFWzHnsvZdPKFVmfexCakL4fw2MwCYw68HE15aW+SDPm4t7tPPb1+NGv2y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3521.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(53546011)(7696005)(6506007)(9686003)(83380400001)(26005)(8676002)(52536014)(86362001)(41300700001)(4326008)(33656002)(8936002)(2906002)(5660300002)(38070700009)(54906003)(66556008)(110136005)(66946007)(66476007)(316002)(66446008)(76116006)(64756008)(71200400001)(478600001)(82960400001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6vJyVInsBQv9KtDaeex8LGPROE8UMz6JGQ/C2Ndf9YcZy2IZGs/WpN9TbMg?=
 =?us-ascii?Q?9+oWR1ca5Mgosfej67SS3CE+ssZR4su9p1WA7+axzZEkFRXwyXT29XmOfEB6?=
 =?us-ascii?Q?uV+g1F7ZWrnt39r06zHjGNEsCBYYa+XFz/OflemNsdYu1T8vpUesINdcUyJe?=
 =?us-ascii?Q?N9+s5/q29IRAz1msjIhuuDb7ZW/D9sQaLpvI3rhNEiwpKs+7G0Op3gxBq3Re?=
 =?us-ascii?Q?ukfaMopQDWgWcQs5Mj66tYEFBMjiQFIiG5Z4lb4ax9hBmyCU93O1Or+qdHea?=
 =?us-ascii?Q?LzQroRNAho2m9VOO24hedaYFyLqAsAmuuUMsOJyfnYk58DatCCKluOIaDbcT?=
 =?us-ascii?Q?7AY1BL2josIyqp7GS0xRrQEH14ldVTjLQnUhVBaVW/C18CGWfXrofqBI7vog?=
 =?us-ascii?Q?1ye341GzIyDtLvimGGvSvgbknrbPsWKS58NFhyHRtxPidWXhZsCGIi7kJudY?=
 =?us-ascii?Q?Lb24F2sNNpN8vr9HeNPo8lYLLrUhXDXb8qw0F1UzaIgCvwvRKSNZscUpu7cN?=
 =?us-ascii?Q?GNYHaDPoDFEfPhsPzYAY1W4LWy5dRivpcL9KyNv+v7D3HFYsrqSz26yMmFcd?=
 =?us-ascii?Q?GUuqEXXxhA6PhZLoN8yEyWoJmXbD6DRTCv125cHf9ak7y2qsu1RofzZulLCJ?=
 =?us-ascii?Q?U6sYVojDn5IvqjIdn6fSSaX++rHmFy+0y/CC7oK2xamFaftYuMxbrE8FIe3h?=
 =?us-ascii?Q?p+xMmsC3CffTPbMzZ4P91RMH+A0ieyT+Cg+MjIQT2HYNWXPGrWGqrvBQThNw?=
 =?us-ascii?Q?C2eG335e85v9uJET5yn7gKcpGS92vmL5Wg5C4BE3HM/tTWv+nVcO3LT5dDX5?=
 =?us-ascii?Q?0mO/9ttSZHptasqQaj0P9PlIf/tmBe6lNo9HE1+CI2cxr0I/nU6+qq5E9sSk?=
 =?us-ascii?Q?BhM0FiUhx//a+oIp48tVcdhqvgu41v3Tqn21hBCDyPeF0xFJaUcSv1kXHt1T?=
 =?us-ascii?Q?uUCdKzAK2T3oV8Of171pXyEjEQtaVxcLqtiWIoJiLk3lJq2VVfjILJUkPAkT?=
 =?us-ascii?Q?m7Ofa3ZqcocIp3sSLi00VPf0BfPSN9fLuBA1+fb0TN1aS5YPtmNao1hFS8IU?=
 =?us-ascii?Q?1D9C+5e35tOl6hlfX0zx0vE7IrdwzezrHQj4w74UjIdEOb3fJKQKRusE1cy1?=
 =?us-ascii?Q?4M7n6r38MMeRRfiGz4BI9WkEfjTB945EXYxHgwD1zN3FrydIwfPv2T8gaaqq?=
 =?us-ascii?Q?qy3WbPxaNipXVEm/c6O7WQtxyUWeUoHI2/PTH7mk7/QRG4iqVgsP+Qhwwy21?=
 =?us-ascii?Q?7XkIoIjCgvaCe5RRuxxKL5bm9oku7ROXxlHgudIlqQoBhFaOcfTCcxFeQUtg?=
 =?us-ascii?Q?SrsJo8/dS4uzLyDodH/YUvlqi7d/UcFnCcRFuQs24qRHAOOL5zmMX5t4DYY7?=
 =?us-ascii?Q?yitGcWpLSDWEnHu7NrTFxY3xYjgKSVSxyzkkD0OZ9+xghOyQLjrtIUxiqzaB?=
 =?us-ascii?Q?yO4oQ7iT6YuSsGoemxcs0jd/b5bJRRMI3JFBtNETdkHX+irBzscmWm39zq9o?=
 =?us-ascii?Q?SA/Gy1aC4kXS/MMHiKn3/ZCasyd/jXiAEqfzRu+9qOgsxxDyCege++0xSf7U?=
 =?us-ascii?Q?K8MicGWaWHTfGx83M4S2I228uSP1IC35x/yNUXfThKS+0kGGHFfUTOgSfwJx?=
 =?us-ascii?Q?2Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3521.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7578937b-9ef2-4290-e350-08dbfca5f991
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 13:09:58.9727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5mK3jqmb41kNq5USTSF3N2QgUO+ED7lfxO39Ab2xd4KlaXHCIIlytTpiVlg+NZ5iye3aV/jz8VN/XTYflSdeWgw9nW7g//2bsyNzjTxNAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8542
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Wednesday, December 6, 2023 2:01 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; marcin.szycik@linux.intel.com;
> horms@kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 00/15] intel: use bitfield
> operations
>=20
> After repeatedly getting review comments on new patches, and sporadic
> patches to fix parts of our drivers, we should just convert the Intel cod=
e to use
> FIELD_PREP() and FIELD_GET().  It's then "common" in the code and hopeful=
ly
> future change-sets will see the context and do-the-right-thing.
>=20
> In v2 there were a few conversions to use leXX_{get,set,encode}_bits() wh=
ere
> possible.
>=20
> This conversion was done with a coccinelle script which is mentioned in t=
he
> commit messages. Generally there were only a couple conversions that were
> "undone" after the automatic changes because they tried to convert a non-
> contiguous mask.
>=20
> Patch 1 is required at the beginning of this series to fix a "forever"
> issue in the e1000e driver that fails the compilation test after conversi=
on
> because the shift / mask was out of range.
>=20
> The second patch just adds all the new #includes in one go.
>=20
> The patch titled: "ice: fix pre-shifted bit usage" is needed to allow the=
 use of
> the FIELD_* macros and fix up the unexpected "shifts included"
> defines found while creating this series.
>=20
> The rest are the conversion to use FIELD_PREP()/FIELD_GET(), and the
> occasional leXX_{get,set,encode}_bits() call, as suggested by Alex.
>=20
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: add some conversions to the ice patch, add the idpf patch, respond to
> comments from reviewers, resulting in more le*_bits usage (Olek), add mor=
e
> reviewed-bys, see each individual patch for details. changed title of
> 0/0
> v1: original
>=20


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



