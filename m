Return-Path: <netdev+bounces-78617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8F2875E70
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2766B229A6
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2964EB47;
	Fri,  8 Mar 2024 07:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6wogk5/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBA52E3E4
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882814; cv=fail; b=FoX2RNPR5q4ZcndQ8GROjH36unKFCXRjcX06kegSUAl5BG8uwUySFbiXJlci6ItnTkktTjWSenRtncSFMG3J0Ya66EMcGwM5yVOGiYl71flYzkQKTgvy4QLiqgaGGbAMr7pcrGlM0xkGM8d1+G8gSUZ8V0F+/hY07Xp1EgPEUVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882814; c=relaxed/simple;
	bh=sbchJuoPF+mqAXnGd/1iZ8RQ1N0V7hlLPuzM1nMxxyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pscAV5L7GrP/bX3f0Moj7i3yTbRUsq6I7x8DcC6Z/MShD66TiFWfYLszEU+wWePO9b5p0mxW2o7jg9W9Ti55TdoV8hDE3KtQJQhCVHyT63FO8/uBXt5F28B3qxARcFwSyRi1dNDA7MjelGb1kjUE37WVaHjNnauRrGLtlYxqecc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6wogk5/; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882813; x=1741418813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sbchJuoPF+mqAXnGd/1iZ8RQ1N0V7hlLPuzM1nMxxyY=;
  b=T6wogk5/IQZI/aat+o/CARJGdbNBeXAbdst1tgdh7Kfglg3yptvQ4OEp
   V0tCun8XaEpEHdUcqiw0+/qiczFeKhxTCO//wwMCz3ObTtXx+IlI9i4lj
   wvu7xLrIn7m6mImmkI6NvQssmh0PNUbZJ2pKGDnzP53QthShHW7Cp9Ft1
   GuUj6YoRWEsHxUmjXeZegwwpKe2XnfnvNWh2q4w2tgjWFd37Rk5kJJOT2
   M7NG7m06RctnrqMurT4daIPrO8s1nTz9BlZMdKOwfJ5nCXZC49Vt1Frwq
   E76ZuBFa4VcmLKsZj61CILuk9FU+7FGBRbHEm3MEisLdGLy4wGT0veT5f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="8345896"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="8345896"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:26:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="14944310"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:26:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:26:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:26:51 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:26:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNepFW8fkDNj4Trgj9+PMMcx/HmlZ7E9tJ099m8dtABCG2JmQiVLZdfLvof96vxXpUHEIfbQ+ckfKgaFVXEUzkTjr5KGMG7bfeDRM70+Fzz8bSMyC9u+RYZ8q9451M8iVyuG57pQA8vIJJeRREIY/TAgiBFzPLNNyaEO54geT7h7qkiHECNtpErLtjQ2lh6oK1heLKEE8ZgIoLUpYLuXOAm5I58GG4AvtRu9Bp0odygD9I8Jm6m3DvkKef1QOJXCHdgNt6pTtmxq4E1dLXa+Z/LmapqQvP51w4nSC1f57IXeYBrWsfbW3LWLBrzswbPHmKSISeYJFVbXFPChqLR9mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/868M5XLfoCFQu71oJzl43ntK6fPbc5FXvscGT06Bg=;
 b=Kh30uvMl0q0fQYAr2O0/Wzh2M6nuOfjkrbgo9wrEMsDvuJJRH+XBPolrifsSL5O//MKkjE9B+x0UI7V0aSgn0cF+XW+G9PqNMWsnhyX4Q80mQLVOqbjknlr8T6hvnmIei+ITmMhaRdDx2bj0dr2WoLj+k+Jquj78twkpbm+GfULsURwmTp1cMYqTiAF0PpFwKd40n6fnoeHTujCIIFPw3eXOBIuyRfaa+Eb0h5g45DsrEO0FW0FtryisRiV62hE96VsuD9QYZsHLclOyZlpL3G7lY6HSTgNAkZW6fMI7kXIuExCQmyPcqtjGS5WdGfxeZVmmeKJrpsTFU1C335SUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:26:49 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:26:49 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>, Marcin
 Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 2/8] ice: do Tx through PF netdev in slow-path
Thread-Topic: [iwl-next v3 2/8] ice: do Tx through PF netdev in slow-path
Thread-Index: AQHaa86a4d6AUDFyyEu+5HGPjvmiBLEtfEhw
Date: Fri, 8 Mar 2024 07:26:49 +0000
Message-ID: <PH0PR11MB501351B2FDF241C7B05C567C96272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-3-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-3-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: aa40ee6e-f55d-47ea-8118-08dc3f411e7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ydsfa7KiMNIegfHSj8S6QpYTGMRAFbKrqoT8VVpETG3EAQV2tdcdB9XCEI9u/wMXWX9IZfAmW+0xgkrikcDB0PR/y2poMWvrz0Ycd/dZs8gJotQSf4mCnoMH77sNuUCINJPoW55qZAQTFixsrKGb53c6lH4q8FnPL4h14acEtULNEiaEZFLSK/3Up4q3QnM3Eaf1Apmy+af397KxeGt1FWlaIQr9M1mEZVBdpbXsFDVcMJylHuWW4gBq2nhvZ9ao+xBCJ6b9HeXFM3qTe2TvMiEaWyL/Boiy8E8IF0SS0bPA8e9TRLj7HSJqaROjz86iPzA0Gcys1Gn63eCqy0mmnomeVVBqt4IiKTwIjEvgE+WzuktNbevUr3y/oFs+xkwZYdaBGTC7L0Nu+Fp7uj8cBCL7AXJPuxzSCDycxHH7bVFk+pqTGX8FMfH6QeA/4J392xn7P639x6GAa6YYpHBpUgGBQjXZw08o5PqVJXMqnXapQpcvqZLbfjhnQN+5umG8QUi3cyIrrie+7FwUoHQ+co0zA9O4yslEtaMB2CTBvJNAKimJx6km66wbrN42tgAWSpydERjzMgKECsvN8/SaVuIxQPppUiLmiZhyIX4/L7gnQRJ4jz0jcrHTfNPkYDVvbNdqDSSM+EFM3raoPMelOsMEXJFJL0cUT16Ur4zJTWgs8Fa7gifyyHSXOTOvLb1OXTLtYTS2nU+I5fyBbzK3+njyIavtYAyNPSrMqfp83aA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?81C8zujZOCIMYAL/1BFLMZYa0QbialoAC6Nx7w9J43470WqLGEbi0nJ6OsmO?=
 =?us-ascii?Q?CcQBQP6SR336hXpd8KERRvF+GNcJLJ4VdDOpX++vbfYjZcsiDa10/FMKjd/3?=
 =?us-ascii?Q?Qo5NVTg9BF2+LsCMdMo17cMZmu+NxXhQg0iXO3UrCLF1dr0hxDvxmmMkzUIv?=
 =?us-ascii?Q?bf9dEmC/35iahWQOr583FfoAvr6Z0WhU/BTFzpOv0EcCQotMW1SLsUs3n9ZY?=
 =?us-ascii?Q?Hd3UzVgH2Bp4XoGGkzEy5+gJz36lfzVk27qVkL/IyftJiyreF3nbYtiMhcuI?=
 =?us-ascii?Q?+bWsk+eoD/HPvyh/4sLPYoYrnz/GG1BMScEHWCYwD0mTUs4cAZV2GsuMbOyo?=
 =?us-ascii?Q?rQqqnV+EtK6srpJFrwGEnmviBAwN6vH/kMWCdP5zUX0Sse4agTzZYsj7ykkW?=
 =?us-ascii?Q?Sy2FfezuyvzkiLed7yovZShttIlmc1RqbLvzeBiVDob5Osf9OfIeQcPNJQZS?=
 =?us-ascii?Q?ueeVGxQ/+4cA9PfoqnJGuAfvDWZEQE89Afs7RPzozXj8HprdubIxpzWoqyiH?=
 =?us-ascii?Q?zEm4UJoPMCrIxp/qB8y/2BJoe3e6sDrOvOwrK/BOQbXhK/e22wxgKxHp4/hS?=
 =?us-ascii?Q?nELWJr4R4VJUYeyfhyHFHdHhqyirzMcsXDqGhu6rBANvFQvdJ+gtGSdclp21?=
 =?us-ascii?Q?JHRJbar7Mm4u3NGk0bu7onfEx9WaGimLiLkk0VllzA/fTjVNNqE1Htodcd0z?=
 =?us-ascii?Q?3K0REhzB7clz49Kqf20YUqLACUPc45jokK/hpRf/4MT4zXe4KJtVNUoVaiIS?=
 =?us-ascii?Q?NzfJ1kjKWQrN4FZWFK459jWT/GJ2xw6Ulp9hHjnGsMp2BBmhexYy27HZZXIc?=
 =?us-ascii?Q?UumxEQWKltkRMpt8iyj5FCenIFGbs3lFlNSViCd2obWZGkZpIXk1Rkislbwu?=
 =?us-ascii?Q?4yFD805i6NxYQ1EdD5ArPTMHBpEimmHd55TVaGLwIk+PgMxuoDDUNiJm2E0c?=
 =?us-ascii?Q?kuntseC6ZHjxwDdazFVui58Sf2EtnrxJg3jNel06lIN6D9gLv4KchbjFh9ed?=
 =?us-ascii?Q?85MnK0iAQxdgJntWAjsQ9qVu0IWZgVDdWokbXPQcYulbSkJhB5kPX4yx0cDo?=
 =?us-ascii?Q?FOVdcujEIEwwdLyE+0rFjPLFrdXBiL0YUOqv++gt47CdqAPOYcgU7AVZLxTe?=
 =?us-ascii?Q?VBwKhUjRC44ZQ6eGhRfY62wB4CBjxPktzjCQ/v+pYVSODuXstNH4r0NTBcYj?=
 =?us-ascii?Q?ENyrxSgWq54sGZ97DhX3mtKpB/ilavsktPKwYHHyrTjt5h3T7nxArirO+VyB?=
 =?us-ascii?Q?7U9SuBM9FyH2mWe0mC65V/gZ9snv6/wiJ+SYaUvs2BnvIxe88bWzIGCiGOSC?=
 =?us-ascii?Q?JIWPLS4HcUqqV/OlyevFTcJDm1hu2cfIS0x7KW2Et582fNgaqnNliC2muCMj?=
 =?us-ascii?Q?WM1xlQcQennbTH//YyXViLWJKTDj/xCIkp1lM5EU6KP11PLWiNncAx6VcgyK?=
 =?us-ascii?Q?ap3pVSyEvRM+0UQrd/szMeNd+oyvsLoMY4xVPkeOP5nSJUP9UWWTwdiaVeFs?=
 =?us-ascii?Q?ewI94vs/yFINDUCrenOqWFvtUfjsTBdJX/DYaFZFs+OOMDPuQ4twN1AtD1fZ?=
 =?us-ascii?Q?i7V3eRI1KsEhGf9jLVkjapwa5O9x67rdXlaKQSZeu4fRuq9qUgkyIWWIpkzn?=
 =?us-ascii?Q?IQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa40ee6e-f55d-47ea-8118-08dc3f411e7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:26:49.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xzF1n9c7Gk5ewzbccM4tCK3+B+AJ/BwzLUys7tCbWfRDj6Enn28mHHN3Mlp9tl4hJZy0UNQkCPwjbcmOXT8xfjRyEgxFLhIWfRLaY6K5e0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Sent: Friday, March 1, 2024 5:24 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Szycik, Marcin <marcin.szycik@intel.com>;
> Drewek, Wojciech <wojciech.drewek@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; horms@kernel.org; Buvaneswaran, Sujai
> <sujai.buvaneswaran@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Marcin Szycik
> <marcin.szycik@linux.intel.com>
> Subject: [iwl-next v3 2/8] ice: do Tx through PF netdev in slow-path
>=20
> Tx can be done using PF netdev.
>=20
> Checks before Tx are unnecessary. Checking if switchdev mode is set seems
> too defensive (there is no PR netdev in legacy mode). If corresponding VF=
 is
> disabled or during reset, PR netdev also should be down.
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_eswitch.c | 26 +++++---------------
>  drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ---------
>  drivers/net/ethernet/intel/ice/ice_repr.h    |  2 --
>  3 files changed, 6 insertions(+), 34 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

