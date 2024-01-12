Return-Path: <netdev+bounces-63320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A569782C4C1
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310481F24AE4
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FC22262B;
	Fri, 12 Jan 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSXXHFph"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405517569
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705080788; x=1736616788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TjW51GQ6x0CAiTZdivdkzU5g2pQ1Q+OkAxOMkZdi6gM=;
  b=eSXXHFphhcZRcWCRBfX4emxYoBAxVK5nTaw6F5wlE60LKLgp9LFMrItW
   6av2FW1R06gtBCBvD18pTvLv0qOGj7bNtmuBLUi4WhV5gbSqA3KNls6w7
   8dpWDr6iW8iAV1FKSS0yK6uNvvO0QzvLMXhaRCQ/6vl8MSUV1qlDMv8Si
   TmXa7SOc98kq2yUf01YKh4QrFh3KmTrzMp6VVA995+qBUDfQwcFOjPMld
   7x9l0YJQxl+OUEd16G5qU/QZnk+o/eU3FPL/3w3hna1bK7PGCAUO+rxJQ
   2Ac6Rl3cWeYwEmlw5oItUSkaNyZVC6c+JwqfmSpYxvzHTsPquaDx6vu/r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="396373803"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="396373803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 09:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="783103462"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="783103462"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jan 2024 09:33:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:33:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 09:33:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 12 Jan 2024 09:33:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 09:33:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnY/BWIoSaUrk0QDVCR3/FD/Cwd9XiwI5U6KGrSJyvIuZqI6bRxYu/fQvYfsCKlDyduLUwi8N01Gpt91CLlQdXSOqRX5AMOzgouyp/Qf5Znl+FDToAR5X2zIMvmFQjPew3v9IYh76EAIAxb50OE87mI1fRvO+fDDGlOYB6LSfn9riag5qhnHAqXhuhQoXJKqID6fWdPO3PdK6868xj7Ovfh9s4MBA8FZTQu3ExHH9N/hCjwahJDWYAw1+gCxrt5P0cHBKkJV1XGCKfWfIu0WuUCBphZvUQ59KtykRrbnnJvJiPGHwuGIRHeO1MKDvnAYEy1XlMdA/hnnsdm3LCKjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vykbAlOjXHjb0dlfdOn9M9hJ5efbOnJLQWoxr+eWsY=;
 b=i9L9BTjdhqi41rbe1IfYOgXdYix3kxerA3gx39J6hG8+oJPS0/IMiTeqJcwIIN8X+SvjG1WOP+a86EOPY1SuS3rJb2B0KwIKqDgiAINhR7PRFlhYW0LBfpDeUcOU8rwAz2peCksEboRJA0T4umMZQAtE2bNVong3YKS49hj38f2RdSiIWQURI66w+AK65X4R1yDAMGAp7g9ZL2Lg2ydji5sLSG+Pn/aGjRzAkJjqLDt00dKT3yl8RpPPL7Y1mQLLJZS6byZ8afsjT5qiK4VCeMPxvnUUthFewksgjLhBYTisfOl0/8j8bv2FhcJQrNpAAEHzfh9IfTx1WH5BX+t2FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM6PR11MB4707.namprd11.prod.outlook.com (2603:10b6:5:2a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 17:33:04 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::5fa2:8779:8bd1:9bda%3]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 17:33:04 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kolacinski, Karol" <karol.kolacinski@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH v5 iwl-next 2/6] ice: pass reset type to
 PTP reset functions
Thread-Topic: [Intel-wired-lan] [PATCH v5 iwl-next 2/6] ice: pass reset type
 to PTP reset functions
Thread-Index: AQHaQjD2OPDCKHDZ4kCZtBVszeYuorDWc9JA
Date: Fri, 12 Jan 2024 17:33:04 +0000
Message-ID: <CYYPR11MB84291287C2ABC1482EF16513BD6F2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240108124717.1845481-1-karol.kolacinski@intel.com>
 <20240108124717.1845481-3-karol.kolacinski@intel.com>
In-Reply-To: <20240108124717.1845481-3-karol.kolacinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM6PR11MB4707:EE_
x-ms-office365-filtering-correlation-id: 9d9b9f58-64f7-415b-399f-08dc139488a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r89YaJ6sxfIsAWNEz+5W/tnJsKdqZS4AoBrT7sYQ5MmD+MWXiOqP2Ey6GFk4sqzU7sW3XRga9A7oYmUTWP9g4vYiVmNo6p4TSAVjIkJk15VfmWyo2S4Noc8YLxP2JDwywe0SvW0uIY3YhFXyomsG+MHSavLCiJzDW2D8do+hsC8gw6CM9kX8fNlubNXMyKioRkRGHBpr12PnXxFBRBeybsu/kzEvqOkvzgjLTG1WPYwWgJ4QSS5p2i9IqBoqeemjQarv6oTkpj0wn62Pz/QsINVP5LVHza0wLyNzZVNRG1zTKZPyHheynKJi+X536S92JRYjIW02PWpbvraDLIFwlhY5rotJO7apwMEv5/EdjgH4F1utbFM3+yf8d2z5Jel3ID52zptscUHm+myvRI4HcpGbhBYXPQ02AK9ZSerDask1mKdgvF6MjedSR7pQv1YW0jBrVbiw+T3urqTMok4bIqBvRfhG9SH9hvFBn2F8+I9WzdWCyn/A15wwTKBchgjk3gDQzFu/jxAlIFTAzo7j5t428qRt1hhxzstMOanCHiF2/7mfgtVKSEjgO9NTtD1HWhiB6c2VleR0fe1k4HTpwVCYx4al+MprYt/CXq50a9zN6WFl1VBTB6Fr/4CTkjR1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82960400001)(26005)(33656002)(107886003)(86362001)(41300700001)(2906002)(66556008)(66946007)(66476007)(64756008)(76116006)(66446008)(8936002)(38100700002)(110136005)(54906003)(7696005)(478600001)(6506007)(8676002)(316002)(71200400001)(38070700009)(5660300002)(9686003)(122000001)(4326008)(53546011)(52536014)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hI8FbtU/kKawYmMECT9Bm84+2NLnN5DiXnflQLK6tTBMsXUaFcsYs0euVfe6?=
 =?us-ascii?Q?CVG+04rTtstS0qsZ6yN2JwSgpbzwIQ+Dky6s58A87j9B5cAkt6C3KrHluMam?=
 =?us-ascii?Q?WbYrMp/BXjs+ZUMX3y2o+Lii/YG5548S+JkK+NuPjxkeYpru2UJW17J2zfoD?=
 =?us-ascii?Q?R77FoilE34JyRCIYlxjZCqAS2u7SwXPgDUwoOp7KYpGk9rn3e39lUkHJAirf?=
 =?us-ascii?Q?VlYZkVtRD4FAZDlvppGeyap01/ycRiH9PfPe5LCMizF5N296nckIBDGPiHkW?=
 =?us-ascii?Q?D8YS11+LmtWZyC9+B8in+o/F39TZQjOyuZPb4HDUaZhAMeK9pt9JZ7kE1YJ+?=
 =?us-ascii?Q?lH8bleFYxAh+QQgN0EHkvATmDqfJaYVR8XCPNkN9TGU/M6okFqCNRn8gkEnQ?=
 =?us-ascii?Q?48LaTLaDUkZSJbHo5vGAsGZuKSkj6vShR2c/cKyRdsXsZo7kQmPJWgspcvt4?=
 =?us-ascii?Q?L6KvB8u7MsgAvBCAPv8bCwPXUZTcLC7+sRD6TKQTkt6ftFyCHurUWV0WARIZ?=
 =?us-ascii?Q?slKLKRUPFlQscR/SBLYseisqr6PUNuifHrdVToI9iDBtSGXQkYYUAhj+Swy9?=
 =?us-ascii?Q?GwUAfXrkORLm4jVpwktUrOW34ay4LpSF+D3bE8wnzfAJ4CmbNaY9rJdhmjkC?=
 =?us-ascii?Q?zVyn7lLyGdMJQSq47F1fb1Fk5aIitKyBhTOzvFMnk9h1hYJ0SMF2Y47Tz9Fi?=
 =?us-ascii?Q?PF/h8sh3z6kyfsB/cU7pEusiDikz55CCblsnlcU1GYWs1SGqLZF0x6pe+8z5?=
 =?us-ascii?Q?t2642vCpVJfCvD7cfdkcuXY35qE5up66wl/gPaEz9iG5BhjzpSfUzsNlyqMw?=
 =?us-ascii?Q?X2PvoQAgJdntng2K/b2PgPQDLn9uzS31bIB0XuYNEGBweKXuVo8L2aFTQZ9K?=
 =?us-ascii?Q?J18r1LwWd+wp2mYY8KsykgCqQsn4px9W3LVexNBQknnbamGebed9f6UCDDZE?=
 =?us-ascii?Q?mH9PlTiuaQJnEmUDEIELRSLSdwZO5n0wNcAFTJtHIb5FudVaBCMvpI/RYV9F?=
 =?us-ascii?Q?HitWhfpRRfryxIgkec1dWPVn+gSVcBhGau+kRf/WvF0uU51Dn9huTHciTOTN?=
 =?us-ascii?Q?tYB6NRKeBJDYzC2bHpiam05a3meTqfJ7hKbVO8zU44ANYj71dJW86lwkqnXo?=
 =?us-ascii?Q?X2CP5kke5Vd8MaouH0KshGsJrRP1bhkpopKx0LEUjek8UZv4tCtaxXBPDeO0?=
 =?us-ascii?Q?3M/C1Mk/y2eSL9QOrst6xxZG/BBboBJoy+qPCYUv9dWi7HaYKUpmTPg2eNAI?=
 =?us-ascii?Q?AcLCm0Y2dlZs6EI16jIvR9mMFZX68fyBHrvfCBMaKhAGkbOx7/1IUxU1HjZo?=
 =?us-ascii?Q?+8zv8eNTkwQLs0Xfnxu/rnUND+t93/+j+xljbmyYmIfD0aQkge0Qk4xT+268?=
 =?us-ascii?Q?rT6xImoGt4YR3q7dEdGhjgDnQEwPov/Ux+uFInp3Zv0bGLTHKUIPyVvSlL5d?=
 =?us-ascii?Q?VN6Q/DjTu2B89vqovv2Rvz+EhxrcisNZrn0gXYxHck+we2US5kF5sDP1x87q?=
 =?us-ascii?Q?c0agieEVKdmjpJMSH644PWZGQWYU7h5a45u+2dvOKGQPrFldjYsFkky4CHJq?=
 =?us-ascii?Q?ZKAmUUUmDc2MT7wMaEuyI8OwCKOhH33yC433eQjEwigRv8xSQwc3iemkcf6r?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9b9f58-64f7-415b-399f-08dc139488a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 17:33:04.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 31Gr/HwDPpgIn99Dhe+kpfOmGx4swT3VQBybu3rm3Ij0ydOVBG41VRC6rhLLF77WrLgyUZEGkqK9hfUhUZOMbNDt13AIkcAqnMPf08n+PQYOXPgZDzTFzTSNBj5n6UoZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4707
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of K=
arol Kolacinski
> Sent: Monday, January 8, 2024 6:17 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; netdev@vger.kernel.org; K=
olacinski, Karol <karol.kolacinski@intel.com>; Nguyen, Anthony L <anthony.l=
.nguyen@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Subject: [Intel-wired-lan] [PATCH v5 iwl-next 2/6] ice: pass reset type t=
o PTP reset functions
>
> From: Jacob Keller <jacob.e.keller@intel.com>
>
> The ice_ptp_prepare_for_reset() and ice_ptp_reset() functions currently
> check the pf->flags ICE_FLAG_PFR_REQ bit to determine if the current
> reset is a PF reset or not.
>
> This is problematic, because it is possible that a PF reset and a higher
> level reset (CORE reset, GLOBAL reset, EMP reset) are requested
> simultaneously. In that case, the driver performs the highest level
> reset requested. However, the ICE_FLAG_PFR_REQ flag will still be set.
>
> The main driver reset functions take an enum ice_reset_req indicating
> which reset is actually being performed. Pass this data into the PTP
> functions and rely on this instead of relying on the driver flags.
>
> This ensures that the PTP code performs the proper level of reset that
> the driver is actually undergoing.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> V4 -> V5: added missing ice_ptp_reset() definition
>
>  drivers/net/ethernet/intel/ice/ice_main.c |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_ptp.c  | 13 +++++++------
>  drivers/net/ethernet/intel/ice/ice_ptp.h  | 16 ++++++++++++----
>  3 files changed, 21 insertions(+), 12 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


