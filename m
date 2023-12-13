Return-Path: <netdev+bounces-56697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6205810870
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 03:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6154828211A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 02:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3959186E;
	Wed, 13 Dec 2023 02:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFf7VPrj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE04E4
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 18:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702436294; x=1733972294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S11O8kmAqhhsAw0DgmzAb2xS6KUK7deitCgk7q4hCI8=;
  b=hFf7VPrj9gui/ZJiZRarnVOztpb1Lwx8fwcSbmUCP8pX23l99DTvjsVp
   de8ZN78pOqs0iV3mwP/6rP1OufZznrtOVgLwafA1ruNnbKVL9Tx4oLWEG
   4hOyhSla4MuQXq0qT2TyppoVF7Qz3P2w03xhL1sHX6te6I5X1g3El/c/P
   bPEZMYCjNFIxQMptKCpOKOxQHVFatqkJMUpkT/Je3eXjxF3ZiXvAUN4U7
   flIVzlwS/LcuOSZUgXF4pHuXtHxNjNXmgY6kQg0q3mJMFiAfWUNFWlBVG
   JuCEw9fIu0kkYkdPJ0rRFqENd/IAa/ZxNABhJp9k5f2buJpGU2HM/4mF2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="2077839"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="2077839"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:58:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="947019223"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="947019223"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 18:58:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 18:58:12 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 18:58:12 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 18:58:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tex3JSpcYrf9WdWH4a2l9bQdspOs6X9uidtn+e8RsLmtiZd25iCo/Pwzi2GXf1WJKODdAaMfgUS4B6YT6cxqg+N4l0L3KjRHZa6CoTshs2NIJKA3vA3CQ79FlWzod9vlpj8ya5zkIq92/1eVwxzjOAyx794kvcjrWl3ighFroTt1omZZhwhyONHcE8XxnY3VUbAcVgG6B6QeSr9wBt4S3B6f55T0jG52dXKAjPaFcK95yY3A5yGlfpB3+dnfjOQ0tl5nNEtuiYNCe4aaL0RO3NLT/6GlvmXz06I/f3+UMJnEKV5rFosHXTqZL2fJcyYcJjeqykOHsQiS2qzrUbNdXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egjBWHaslhN4A+11JwuyGcW5/Suw+0wL6tdZPg9cED0=;
 b=dv6Oh1WSGgP+IwSWOCeGOwO+nae8zbbN5+UUY7bb4E+VoZCOdlvJRsRE1IwqvwIzqXMoOyiDgWHudALiRu/6SMoPZxnECKgTfIDrzCXLQIVjvY7Mi3SuWLeXG+PxoXaUIqk/aBp2A5JwmPtEPQX9Wey1bbjF2KKDO8vktuvKX2TFcSmuzl6vWvxAW75Vaq6mhRS66YFsTpr+A+1j3F94dFVyszb3VOIbXNo4BEKr6/rQ5ffP9GWpmowi6ly3bq+g4Dyjh34F2oNTFxWDIv0DBxOHeb7Ck9nkFpxPHaxnHmUErijX84vb9rFfMKl3fWgc6CKfaJliYeToxmbkF9FxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 02:57:50 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::954:6050:f988:740f%4]) with mapi id 15.20.7068.031; Wed, 13 Dec 2023
 02:57:50 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 09/15] intel: legacy: field
 get conversion
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 09/15] intel: legacy: field
 get conversion
Thread-Index: AQHaJ+AJiPewAVjJSUaXsNDsRWFDBLCmjLvw
Date: Wed, 13 Dec 2023 02:57:50 +0000
Message-ID: <BL0PR11MB31229B3CD0D8F5A1C20A5CFABD8DA@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
 <20231206010114.2259388-10-jesse.brandeburg@intel.com>
In-Reply-To: <20231206010114.2259388-10-jesse.brandeburg@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|SJ2PR11MB8451:EE_
x-ms-office365-filtering-correlation-id: ef1fc218-234f-41d5-8d95-08dbfb874b57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pMZ4JQaUcbSTvcO2SlmBT06vmM9eHXrfP6r0wFTmRxiPHlVyfNA3sgxmOMujMsEZLS3sNz1C92qaul804Fkb6ub3kspRWg3EpNadl867WP5PX8vQuWtuaQLk2n9P+14KFjvur/hdT8+nUIl7oL2YCe5liEOjXnQGX1bXJhCNODH0NY1nVnCkqZU7TU+3LgS87RxJ2R1B6XZpti7mk2iY2LFtxT/lPYS6TM5NTw2h1/pM6p8twhvjU2jiZpczbroSYhFhb23pcFI/8o/4fTpsoI/bMRKC3G1Qn/TAtEzvtj7+1pdLmjsLLL0ckasCpCE7qc6qx0UTR8Q6EhdFY2Ek0WGk09GGaQmtzvtzQd2GZ0YOED1IEfRYrh2BvuLHWPzF6r1K+S6/fRaGfS2/5bdZEf6WsCXggy/oW7TQLXv+e4Xx607vahKe+hDxSJa4dtHqAvVj8+N4HWqXdLKrBnl5e1tCCF0avkEJCiHivT1RPEI4t5eQe7xc7YsafJPp0RxPF1A4rPwQ17y7vSFpqbIodbx1/zSTOJJuF84L1RUqPzOYTx6VrPuhbGr2FQIx+eABpnyRsQ+c234SaEarPD1zDZ6BmWqXFtduezQZqpowzhOVrbvV8cCjQu4ZDZhiuSlD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(8676002)(8936002)(2906002)(4326008)(52536014)(316002)(5660300002)(55016003)(66476007)(76116006)(66556008)(110136005)(66946007)(64756008)(66446008)(54906003)(478600001)(38070700009)(26005)(6506007)(7696005)(53546011)(41300700001)(9686003)(71200400001)(82960400001)(83380400001)(33656002)(86362001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VEgUz5E6M0TpoTZdqdNjr0CL7sApDoOLiOg3NMRm90o8J1215VDe2asyi3hJ?=
 =?us-ascii?Q?OdjiusqAd0SFC00Yz87b+NTzN2sxn53oXsgBouANXJcpQzkDaYMLrhcOWg4V?=
 =?us-ascii?Q?Xipuc5mY74zKX8Af2Tp9wfU3gmJmqoCPakTyIPjO7QEHg1wk0ctNX5/eDtOL?=
 =?us-ascii?Q?ncFIpIZCRzvgZtVWDE6rKMYfOKM5m3kLEZ7w2hxF68ULS/RBOpKkQvqfleQz?=
 =?us-ascii?Q?+9iaz6G8647ul61uyPWpRF+8QQvDvr5oVeVR2DZLZdaQjc38SxG/7R4WhrAx?=
 =?us-ascii?Q?hdD2a/jRNKz/TN9dcXKa2jf2JOA/bDeVmbKPWJt65NEIyjQ6pboYqo3pY6BA?=
 =?us-ascii?Q?KQdiBHuIm2YHI67HUF724ikKec5lK55dsIx2KXaSdmW0Ex8vp9r61xqmRtN0?=
 =?us-ascii?Q?A9kif877UJvn6yTR6j6rpReZoBa109M7kozsXk5+aFKJs2I1vI3WKtO0RfwR?=
 =?us-ascii?Q?IMC+2xLDFRNe3jNTWQPH+vosoDkNq2in4zddnS2VB0+OWrqteFZsuyIPruMb?=
 =?us-ascii?Q?HViUMNDIlkQxC/3gB/TQjIYttDhJfNSgtiJq/NEZqDe+n1g9LPObWEjwGxov?=
 =?us-ascii?Q?N0I7Dm2fGqa4zzzwKQMTz9QXjRp8xq71wmZ6aujz3XN4ZOaDc9u2ZYayZywG?=
 =?us-ascii?Q?DqSfEAFR6EeHDzYIhvMtgXRVE4YDPYwin2aE0UGKHpK8hP4AmJaecZSP4wjB?=
 =?us-ascii?Q?ugrb/f8rUSTXVVrYp9RxxUWgt80Eexx2liSzW2HOIdyTitriuR1T+g9ArHeB?=
 =?us-ascii?Q?KQd1XXopDDFRbaE+chQYK1rRFrwq2M/WHDJJY7AExTdAnGRRSQq4RNK8mZZD?=
 =?us-ascii?Q?s6sL07L2YgeujTr2IcycLXoML7kxO3mynZRC+E5UfOLzoBekmbGVBMuMsRaI?=
 =?us-ascii?Q?YZvYpTUYt0/RbEyigA0cpDMdyYV59iEcoLaugzKgyBTbdyY0oPDxgLKQzDI3?=
 =?us-ascii?Q?B6W1Got0Vg8CtNXKu/5a8MwvkV5Nbe8YnXttDXzv7+PaQLIq3QCgDtmkcgOT?=
 =?us-ascii?Q?8lnphCMvG1Skif1VnZYzp1xrBOHGi0zKUITT44kZnkzA3eGmmc3ML6QhgUy3?=
 =?us-ascii?Q?OVMuixg/0Z7MnlrxxuuzIEBUla1WCH6IiaWo6d9lrzKaGTMcgbPBfP3QtEKV?=
 =?us-ascii?Q?8SU84oR/GSaDrviqm5LZyTaGnE/4ivjZVQ5w7d93JnMJKbLA7243vrmZLyRX?=
 =?us-ascii?Q?aT+Oq0Kc6CDnWSLbliSWJ32UVNv4NdO6bd0lA/6jATtuTlW/nu9YFP7AebuD?=
 =?us-ascii?Q?3E8VUvl9kaH01i5ptx+lDNzKRZyOT9CEWO4hJhmBRDKTHgpEaViKUEbJetXy?=
 =?us-ascii?Q?pgbHdC2OZZlY47D9TKC7lurZoFVLgtl/bhY9P5NP8Pu0pKT597yd7K9srbm+?=
 =?us-ascii?Q?z+F9nbPqlb4OUsAL/O/1FPilw+jgJfIZG7Z+5AGYeb7T91Pm1thQiGONCTKv?=
 =?us-ascii?Q?Q8ZWME1TSMEmr+s+cHUFK5pKW4T6M+WeTeTzivGfH628mpcqbscx64yPHFev?=
 =?us-ascii?Q?4dBbGVXiRfSFPaAV3j3LwikYn9WMTcy9dxxkHAF0LcYj62NzVMAeb5CMzu0a?=
 =?us-ascii?Q?UlQyeJrbp/dadmtSxHVeZzMj5CiHJXX7v242xgJ05A7owhb+vcU3bIXqVnuY?=
 =?us-ascii?Q?rg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1fc218-234f-41d5-8d95-08dbfb874b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 02:57:50.6146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GEfp+PCznPHY4vfeCZREqx2pGMhuPIKYc6YaYgZCSk+OZ5r9I8Zlic+3WSLwbZ8XMpT4dDSSEpOfPF/enPVsSflv6A6S6+S/8BMMaOWQGbM8XlQrzGnQTVxMpp5KlU5r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
esse Brandeburg
> Sent: Wednesday, December 6, 2023 6:31 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Brandeburg, Jesse=
 <jesse.brandeburg@intel.com>; Julia Lawall <Julia.Lawall@inria.fr>; Lobaki=
n, Aleksander <aleksander.lobakin@intel.com>; marcin.szycik@linux.intel.com=
; horms@kernel.org; netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 09/15] intel: legacy: field=
 get conversion
>
> Refactor several older Intel drivers to use FIELD_GET(), which reduces
> lines of code and adds clarity of intent.
>
> This code was generated by the following coccinelle/spatch script and
> then manually repaired.
>
> @get@
> constant shift,mask;
> type T;
> expression a;
> @@
> (
> -((T)((a) & mask) >> shift)
> +FIELD_GET(mask, a)
>
> and applied via:
> spatch --sp-file field_prep.cocci --in-place --dir \
>  drivers/net/ethernet/intel/
>
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: update to le16_encode_bits in one spot
> ---
>  drivers/net/ethernet/intel/e1000/e1000_hw.c   | 45 ++++++++-----------
>  .../net/ethernet/intel/e1000e/80003es2lan.c   |  3 +-
>  drivers/net/ethernet/intel/e1000e/82571.c     |  3 +-
>  drivers/net/ethernet/intel/e1000e/ethtool.c   |  7 ++-
>  drivers/net/ethernet/intel/e1000e/ich8lan.c   | 18 +++-----
>  drivers/net/ethernet/intel/e1000e/mac.c       |  8 ++--
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 11 ++---
>  drivers/net/ethernet/intel/e1000e/phy.c       | 17 +++----
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c   |  3 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_vf.c   |  9 ++--
>  drivers/net/ethernet/intel/igb/e1000_82575.c  | 29 +++++-------
>  drivers/net/ethernet/intel/igb/e1000_i210.c   | 15 ++++---
>  drivers/net/ethernet/intel/igb/e1000_mac.c    |  7 ++-
>  drivers/net/ethernet/intel/igb/e1000_nvm.c    | 14 +++---
>  drivers/net/ethernet/intel/igb/e1000_phy.c    |  9 ++--
>  drivers/net/ethernet/intel/igb/igb_ethtool.c  |  8 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c     |  4 +-
>  drivers/net/ethernet/intel/igbvf/mbx.c        |  1 +
>  drivers/net/ethernet/intel/igbvf/netdev.c     |  5 +--
>  .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 30 ++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  8 ++--
>  .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  8 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  8 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 19 ++++----
>  25 files changed, 123 insertions(+), 168 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


