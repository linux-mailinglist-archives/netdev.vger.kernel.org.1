Return-Path: <netdev+bounces-59962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA4281CE81
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0211C22682
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 18:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4725B24B20;
	Fri, 22 Dec 2023 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwKpZYvr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BEC2F841
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703269932; x=1734805932;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4yypARfTj4SjalriH5k1cKS8traBLNON1ZFkO23uNmc=;
  b=lwKpZYvrv1R/PCl9swe57mM/Y/Day70kJVG6hltXgQeTc+hXzGKbdphh
   Ip8xob3jkZ3G8PAHRU1eHbHfj0aUwESRHb6fRSpfepeLkO66raX9m6XMQ
   T3T6JjcktECZyJzqLawNb3Ar9mFuTO/lbI5WmSnSF1RwSnU4N9RQV7kCs
   33qWBtCHbst4oGRbV3R3SIAZz9t+3AXxcW746OBP/jjrhHAynl0eR45Tt
   O6bOnKtBz4pW4rQwpgQR4s4eZypqXEn0e7LO9JgdJwM0wjcWC7lbJC3LN
   R+ZTecn3zfScNoQQjOIYzjp3J75jC+VRZN2FW2f9kuaVoBJDIcfEDmDPY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="462584990"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="462584990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:32:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811382050"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="811382050"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 10:32:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:32:11 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 10:32:11 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 10:32:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQkmqH/AAMnV0SGuTfFjSdafTOf+lm87sxk/MVQT8OcWw5MC5KoU6mIRX+9pQznoQKAjth/j5rJsCZyN2aA7gVIpaYhVrRN14WVV/QXMLD24NRzR79R9hx4ybS/rZwf7ujUJdPkostfz2svg+SF7lc39m/KdbqZlq1xCPnM7QfXRRo7i36XXjekFY9OOJXNHabe4mdIFyfIOyBPZrOE7Jtk47eFLkb/Ppjw/oy0vf1o2JOJ7TSP/GkZVYnxWtVKEvfa1QPiGEx3dQhrmec4vY1VE6iQMmbVIUmmNJhTLxoVsRb4U4IE7DeNg9Qgcv4OOdVtU8jqqqiZLfZ3z11+/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQy/OTok74CoPuvwGAKcM91Hy3liBFSqd2gOR/s0XUA=;
 b=V866KigX9s3StdrDkh/0kCbhkQILBPuETa5/pR13ylO1KdCIy+G5rdcZwHOak7ixgGWo1ZUGCssthaZkJdvz72xmHNEENxVSN3m4RCtI6r0Z4AYPowQfOaQKOxsIqY2ezCfGSSzeYyIDH8oFhhTxUlVqCdjupNuvkkYyG0nQgRJ0G5OybKddmPOj4Fx417E5qHBQu8NWmBnOfWqIEmklBxAu5AoMv0CaG2GC7NiHi/h9LrOFirWBuLQKg1kp1XHr8XHWwVpmk7iAm7ejB3If9dzJXYDt03eT9/qUa8nW3IYpJdnT9LOvukdZCpFAzIcWD7ntcnHKW6xgAy7Wzq9sGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7195.namprd11.prod.outlook.com (2603:10b6:930:93::19)
 by PH8PR11MB6975.namprd11.prod.outlook.com (2603:10b6:510:224::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 18:32:07 +0000
Received: from CY8PR11MB7195.namprd11.prod.outlook.com
 ([fe80::6e9a:e84e:338b:751b]) by CY8PR11MB7195.namprd11.prod.outlook.com
 ([fe80::6e9a:e84e:338b:751b%7]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 18:32:06 +0000
From: "Register, Scott" <scott.register@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Linga, Pavan Kumar"
	<pavan.kumar.linga@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Zaremba, Larysa" <larysa.zaremba@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler introduced
 padding in virtchnl2_rss_key struct
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler
 introduced padding in virtchnl2_rss_key struct
Thread-Index: AQHaL7GIvsQaFP4O2UiqYclT6y+uO7C1qnZw
Date: Fri, 22 Dec 2023 18:32:06 +0000
Message-ID: <CY8PR11MB7195A879FEDD0AA7BF0566FB9794A@CY8PR11MB7195.namprd11.prod.outlook.com>
References: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
In-Reply-To: <20231215234807.1094344-1-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7195:EE_|PH8PR11MB6975:EE_
x-ms-office365-filtering-correlation-id: b915b0f3-25c6-4cda-6090-08dc031c4cf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s5KhvkBoIyV8Wl+Ztk6F4clyQ2jujkkQ6s+OrNhNxsDywD9lAsVJiZ2uPf+zNgqkb41kgP9iuwT8LQoki1nEDosWAgy9YHIlCO127HrU/U6WAELRYVGrIk4AnIS8UXatyYrQIW6/ZrsdGDwXuLrIFSDlP0N60lH7aspH1ja36I3G4/ET3HqTlrWThgebfI9JJuV9/mZteTT/0J6/UqLCmiWbxbZWirV3iVxC7bvMQIvHIuR2A70H1h7NN7MquoH4pHTMcMvo+ruEswDhl7lRemFCe8htY61fzH3ko8N5om3MR/RrtWEBFDpFEsG3q5Vi91yco1UQkxpWbNaCEVgy+A02XbBOz0Oa/N6PkE4DIo/vlaLQux6RCeW5LWkj5bdtpJILL/qWsLw+JlIfshIVsR+3Z/uH4Hw+K1CoyEbY+gWBO2GfwyPI6Nh8NSDrCsYmWb3nwNCaaXgZsaKWJzXtweiA6Tgs9FWxt4P4+BKyS/+rHoKl9eMvfbta7G54/M9ud2OCL+GSb8y35fHP8td7C8PKj5WqWTtJqo6re2nkQzHgqYtcYWgMgZrnuNC6QlUWYGXSOGzclx5gfn46Pe/u7jBsFUFLvSMlgdtcXpHXOgk3IvPFFfRXT5v8IOTby/BW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7195.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38070700009)(86362001)(33656002)(8936002)(9686003)(53546011)(71200400001)(5660300002)(52536014)(4326008)(8676002)(7696005)(6506007)(107886003)(54906003)(2906002)(55016003)(316002)(64756008)(66946007)(66476007)(110136005)(66556008)(76116006)(66446008)(83380400001)(478600001)(122000001)(38100700002)(41300700001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bTyaykPfwbGQ47PYuOlFJ6cqdALzNT8W4+YmwSJ2JZSieTjPEpbOUvLBdg7B?=
 =?us-ascii?Q?QZTcwgUSB+KlQx8kNW7qozzat+57JbVys+O2XNX62CZMTuOxJrQatj9vpm6R?=
 =?us-ascii?Q?y8ES7ufQV/UONIexkr3rfKNyS9h31hT8LKiU5Qg5H/343WXeMaIM/LsF4QtR?=
 =?us-ascii?Q?bg7bf0wSKC8JPGZU/AAyb3tSMtamMKdyMABTlOujkai/4TcAeQty+VAnVGrz?=
 =?us-ascii?Q?wA0wR/EfGHKYuhmri6PtkhmMJXM3ChU655FHub1y1Sz4zmHV2vduDvplMlts?=
 =?us-ascii?Q?snouNWtF2I9ctKg70wUvxbrhQyzzkuSwcTGkec6krIKPgP+QqdGXZTjBS9i+?=
 =?us-ascii?Q?h9Q3NE0BYi6ih78nEI0Wlxn6VHuc9npSVrETq8TRavCVja0ZAX1Bfx8bENSU?=
 =?us-ascii?Q?/Hz7BYzogR7Kmn+8+7ErNAkpk0i5XokLQ9to4tl141DtoRUP0rxCtnHfPdyg?=
 =?us-ascii?Q?qZ12RhLU4EowZ3HLLchs6139eRIw+wG5jSmNIRtgBW850w7tjEnxE70Syejk?=
 =?us-ascii?Q?jwkOQwrbfd0AF0gsIR9DEw2fmD3yEOEHn1WDuFx7EH32/KfSyfXEAu6KQIjh?=
 =?us-ascii?Q?QuiH40ZDek2BqOXOFrCnziG6tPEVtr9kkpud7OWnA9HD69g+NmPRRTtwsvcL?=
 =?us-ascii?Q?l+p6nmRDWdXyBw07WmHwjiaae7iMikWL7Yjy8WJT5Zx2G5exegzwDzrG0w1U?=
 =?us-ascii?Q?mDxz4l9awWibXiBPavv9sX7ZU+htFztm9cBui+OkcVrZYkRNVKBmASzsPTcP?=
 =?us-ascii?Q?Z8CGuVMTGUeOhDXOU5epY+j8f58AHRwtaRbwDdjt12hq/qveMC7qHGby+PRi?=
 =?us-ascii?Q?NsBnCxCBHiYlpXR7iUeVe/ovBUOh3gQyohm7bA5qG+phGwT+5mpelVOoMV35?=
 =?us-ascii?Q?usRsLuw+rOP5BA3WAW4LSx6nJJW8meOtmDv9Tuui5DRkD/m55pTluEELyYYw?=
 =?us-ascii?Q?eTmFTReME27o7txwzfui5yw7HHT7i1+5BOVo3vjJlhjyJgqGQ3s/CMA859c5?=
 =?us-ascii?Q?gh5qHKq72C2VjaHkF9BamQruENrtIOZC3K1CYC+yR1XFk+AXDDIEmjumKsDV?=
 =?us-ascii?Q?UtPkFXSPouupVxWvvI6dn+pd9itYQZf4ZZ3aU5tFMK1zePw92cux+o9le3Kd?=
 =?us-ascii?Q?ogehp3+p4xU8FqKSBUQ+ZOx6xomZoKJucepyb2X84/oeG1/SoGCedge5EWfF?=
 =?us-ascii?Q?Y8mUz/k06wra64cQmTpBRpjgw25VYKjLXG6QuzQx5UKHMkOg6dfHH7hGXOfa?=
 =?us-ascii?Q?Zn1FRaMWNhTiYETh+zQvdltYoobpSNkK7cmLdGYZvyfTeFyTEjbvLtk+A3xy?=
 =?us-ascii?Q?XE8s8eRntIBBNPgWR+fCJMCED/fXVjgPM3FWl27+cGZv/sy3AtChKQdIgesx?=
 =?us-ascii?Q?z9HRgwHIEFxyIuKm4wdK4Xl7j8G4k0sjEaZOlsmnrxZkZe7Rs0kh/UgQoBpe?=
 =?us-ascii?Q?jO/SI2lmErdiqna0ab26lvt3n4qUBDytGi6Uz1ECRrrtogArlk/ywzh5J92C?=
 =?us-ascii?Q?DhKlD2iy74gEOEpFrKPCdOVdY3Oxg4HRrC1njWPt9t9OAMt/gAcxbE5BSuLx?=
 =?us-ascii?Q?QBmwXVXLdDKJv1hicJvykscqZjyPjZHuYyeMupUuAWTgCD7TyA5/OgO8A42x?=
 =?us-ascii?Q?xJud7kLVn0AxmZvYHPuMnEW+g25GmNQqu1rArFP17Uv6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7195.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b915b0f3-25c6-4cda-6090-08dc031c4cf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2023 18:32:06.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qTpNdEZieJk9T5AnY64cjthJtjL9TaoTt/Vms4uZG4aCwgwLnd+P/MNpegnE4D2/28DVoQ/J5S7AGajR1W4KWUWZsuJgMu3llqa1DCxS3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6975
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Friday, December 15, 2023 3:48 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Zaremba, Larysa
> <larysa.zaremba@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net] idpf: avoid compiler introduce=
d
> padding in virtchnl2_rss_key struct
>=20
> Size of the virtchnl2_rss_key struct should be 7 bytes but the
> compiler introduces a padding byte for the structure alignment.
> This results in idpf sending an additional byte of memory to the device
> control plane than the expected buffer size. As the control plane
> enforces virtchnl message size checks to validate the message,
> set RSS key message fails resulting in the driver load failure.
>=20
> Remove implicit compiler padding by using "__packed" structure
> attribute for the virtchnl2_rss_key struct.
>=20
> Also there is no need to use __DECLARE_FLEX_ARRAY macro for the
> 'key_flex' struct field. So drop it.
>=20
> Fixes: 0d7502a9b4a7 ("virtchnl: add virtchnl version 2 ops")
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/virtchnl2.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Scott Register <scott.register@intel.com>

