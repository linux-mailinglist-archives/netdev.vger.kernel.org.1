Return-Path: <netdev+bounces-81516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861D88A0E0
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9F41F3B04D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C276EB62;
	Mon, 25 Mar 2024 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NcVAn7XI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792715D5D4
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348622; cv=fail; b=Zi7P+iKdCCf0KtuN6+PkeItmyJVQN/fjqx9h06Iz3W1c4irlc4tzL2Nqi1H2bTPWAGdvk2tcluWtMUR+MxJy9Gvs38JKakuu/Qe+DjMEONQDJiLTKD8VSARTy0hIuIHUpUYpsXNFgFDK7kppaPxVsMMLEle6mfTf8vASDUUFQoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348622; c=relaxed/simple;
	bh=V5wdU5QOppnHJDVFTkGGx98FesWjSHeKMLAy5NzVFIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqciPUvold6Di1UXDqbgFT6ZNm57iKtF4IHWPYTWZuc3AlWJUGBiWwM7kR6Dz7pxhxKtD4vFx7LBlFn/21mfh1pDXJ8X110stG1QqhSebiti/QZI42Oe8ipreS6S/v9/CAwrjg+YpAkeCp7aH4rIuzmlGxhUFX7hptw81e8p4xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NcVAn7XI; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348620; x=1742884620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V5wdU5QOppnHJDVFTkGGx98FesWjSHeKMLAy5NzVFIM=;
  b=NcVAn7XInqF6mmXbXsIZzUGiidrH5WlI9u7y306lF95qndg8bIdfQN8U
   qPJ+pVf2uOZSr4eWOe8+JZzPL0wzJvSQjlGdg9Ge63dzqBuRIOVyRS08C
   YKPaRNYyZwf+y0bzvbXVLzuzjMxNgiKl10mGX99cM9ch+ooFIoGBOkz23
   txB8IHm3ZBs7WQApy6UsaVH2i/gdlBwGNgwVawLm/U7DBy1VGe6/2oUNM
   lR0YXyIaA1utIwOtZP7hq3YY1keE9R76/xprAT7l0+EouZknVLm+PVR6L
   tqI2J9TJChkhMHGMZy/1Vub+rriQ8qi0rzCG5ihjesgWrgp27epXaqEZJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191643"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191643"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20261550"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Mar 2024 23:36:59 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 23:36:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 24 Mar 2024 23:36:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 24 Mar 2024 23:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foSGmB2pa8XYblLVrg7J5J6cq/V4d2DYqFjHdK3/1EXlgaMGlzesZ6bwdUAfP+dyQGMxufvfGlJr5yXcA1K6kQM08v6C6nJkwsYv4IKyvu9jjXA0vAsFC6KXvjIIkuX5NLiOHOHZjtS8hRQBKDwYinryhqBFeFNxgOfkVOHaBywpW+zV8dRxvOlqGPoAkCW9BoOuJ/S/gCG/gQ8gYIYOMuXr4EgpW/o7e2lfzRMKF0egsvU1jDOJOKkluM9wWwG+T8sDBigi0X2mHKv+92OlREYAKydtoACxzRCZrsZ3uvPhFRTT0WEggvSAW+dvhat4vYDbJEtAveq1OUSoQJlUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZses9gwVwzLQHrEBbXMBf3zxpf9L1dq4xPU4xTKgTg=;
 b=fnqqn0hHrc8R2gRk9a3pD6CeMFVyVBmFjGa8WVSSRjD2YUsOInep8wqRh/NYaxYvA1P++Dxr6DmZBq19j3U+DM2WIcC0mhoWkhYwT/5Ow3JBy7T6qfPK9UvSmPIV3Qof5UzlpEPmpIe/XCvyIWRo3XXRA0W6sCpcDKuQhF/uXubnOP/Yw2h2+1GPYUzRVIQAvFvDWCZnACnK2y0HWqLZyyPTzdUBpmghwwo1D47bNtU+s0T++9nWr+disMG0QnN3YJIFUv9vRHUBzHf0qm4bT1QppUPiBH5IEQUtrUfkS2JxyVoR90L0QBhMFT30k7hbxFBnqqv515/phM9CuYydaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by SA1PR11MB6966.namprd11.prod.outlook.com (2603:10b6:806:2bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 06:36:56 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 06:36:56 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Marcin Szycik
	<marcin.szycik@linux.intel.com>, "Kubiak, Michal" <michal.kubiak@intel.com>
Subject: RE: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
 profiles
Thread-Topic: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
 profiles
Thread-Index: AQHadGrpJu5mvKk/u0ubhKlFLxaJ6LFIE/7A
Date: Mon, 25 Mar 2024 06:36:56 +0000
Message-ID: <PH0PR11MB50130FD5A519919523197C7C96362@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|SA1PR11MB6966:EE_
x-ms-office365-filtering-correlation-id: 24dde03b-c55a-4155-3f4b-08dc4c95f78f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UC5KufXeZj1WzdKSpeIj8fmrWdT2SoOkdMbYLdV957gVRdA+mespIiMRftVWFg2qvNlYPCPtv06M095FxKVpINoKa6Z7J8Y7L9OhZkW2eFLpuGxVTHzI3BoM6IVbPsH6EQzsJSEmqiSA0lJlKG0xcPug0EcbTOBxBsUUVnR3cDSB2U2ZM7WZct9TGT/R73A6GuRUMWa/ZlBhojNaBbH55kssNe/2l7Pk4598zzkPTJv3eQHkpEtzY1bkO3g7YH+jM2KEXELQeQdvSiZkuechBVNOKdmoSjEuIV1vQFtJg0Lu0JHQRlwgd9vCKA6xVNFG0268hecnNI/zXHKMvxDSCwU76c0GrLQgWnGPJyo1ValZBy3kig1iIX56+De9QEeiH+isSJOH0Kz/swXYUkiF9S0ezZqZZH3YDxKb7lvxnpr0nV14XWB8NeEVtSfcrlXZXxW7XcnhjWQOnr/K7CtBLBb5xDEkgtQdfDYoLdaXT9tJTd2VfybWM+oZoUuUfpPfeOTXvG3t5670wjUz4esXjEVIemLdzKytdw2ImKkA3B+/E1KxN9xfvbWd5jg37oNz7cXMIKhd74Ewbt8QXAgp//t5baCvSlj30Mw3FwT+ZlE7ahKKusrKEWe+a1E30YUsymTvDye7qnjlMtz8NnBz67o3LUBqJf6d07kXhUTS3m5JQGh3iPv0M9ap3Ia0T5AXEd5uh9d71HpMAZKN9ESbz0VsuRZ89Ix+NPmkN3FArD8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IoiXu7X8CzWSixDTyIZqtsb4zJmDhQBrUprMzCpiie51qNLtMmM24q4Z+ety?=
 =?us-ascii?Q?w9CQOq9UZLQFNEPdywYlPUgqgYhBRvkvZe6VaHYEpAzWywFHFw6BnOb3HZz6?=
 =?us-ascii?Q?ckFxhMXPQVBMIkcycv8iZsX74j6sbgmukdBBtz2S7EDvQO506spDBVZN49G3?=
 =?us-ascii?Q?hs29dfsLrhbMisQpRRk2+CZ1ldrKQfU0LDXBBtvtCYJpC4iCtl0zW6bnfHUR?=
 =?us-ascii?Q?fQejIInJEo5Dsk+9eUjm5/AfLW149BgcPw9kV12rv+OZhs8rXXiOs4AgJ4xZ?=
 =?us-ascii?Q?LiY613ybykoMTxYXpnHr+WJrMfvGMmLdpDjinFWalvEhvzO2zONLCWIxal8v?=
 =?us-ascii?Q?Y4qqtwy2LcDEYU+3GAa3ywPp/DD8t/IfRxr4WoelmCQlRlHgL0SVUuOsN+uc?=
 =?us-ascii?Q?Tn0sXGSPeu0aAZ0PlPC5xuSkBJ/QcuSSbmsHyW1cSeB6IZMRhZ7PoBm5oxb5?=
 =?us-ascii?Q?8pJ67vQ3G5p60ggkoSYwsdIWUdFl1AU68lH5CK5p/IwKKI62OhNuVx7vcrjc?=
 =?us-ascii?Q?cfRsmpOomMdnaA52l28gdgR4ZizwJOaBngOsLJbQmF6GEXo6u++Ju/xdg947?=
 =?us-ascii?Q?Zhzbi5pnXNykwBjJ9p6QU1NdCGDokW+nJEAUfCfPXpHCG5inVfxGq88E8qw3?=
 =?us-ascii?Q?zf2o3oDwa+0fVVQMWm4R30k1uCiPbr1+lWAXV4FbbrZSvm8Oiwt+buXRfEMp?=
 =?us-ascii?Q?Ubp/vkMMZwOAYupaXcCY1FMlQwnQRUHo7xaNmf3AtulLZ4gTJL7+DOA2wFAu?=
 =?us-ascii?Q?p2y6CGlulY96ZjJ+6Hb9p6aa68FR3XDNtDE1sYnwBWJHO/OYdxb+b3gPeEl1?=
 =?us-ascii?Q?GemWBqJnAod1nIXD48Oqvxs4eTzLYd7iuw57tJPTllmjRwSo1GKGwebB3mdE?=
 =?us-ascii?Q?/gmzE12rgTFW2ruqF1pj+5nFWHfdYpicg8DtWUX5Edc9EFUJf7mNS4k7lcAW?=
 =?us-ascii?Q?Y95X0AOWmtKCm+QDsdIFf+sfBg9iDufvREAn4zWt4we48k6iyOah7fVGPooD?=
 =?us-ascii?Q?NMpNMUo+Z3eNtt409fpEJVYY09x6HKkOPwV7ZE8Feb9RwBUhgYUEs0DTRFI2?=
 =?us-ascii?Q?OfLidqiG9fxAL7SQdByrANV6BB+MmUu9Ox2gyj0CfQm65VSV05LNk5EUeskn?=
 =?us-ascii?Q?c+A1QG0MDW9TGR9OIwUhLB42nTg9xvowhh/MQ+j7cPOfLP39xuRer98KqAFs?=
 =?us-ascii?Q?9nOdk/ff0qg239j8mrJN5HeoSwjXgJ7rLQGs2tofgdkhS8Q4vFoDvJwBmzVI?=
 =?us-ascii?Q?fuVzbKGCDZf4hWBAYr29ZkB2Etl1YlaM1QBwplqRGzsdjojDuKN8lqz4F44i?=
 =?us-ascii?Q?vHa/PYu++y1LD7NcP+nzdlHgAl7Cwd32AKAwwcj2rsK07VnMurWxYNJPm/kf?=
 =?us-ascii?Q?z0mmuS4jjwh72zhNwRiRy2Iw+fn8epxJLCuOLNEbkIgKUtp2crk/MDn2vc8x?=
 =?us-ascii?Q?Kc02MFIVBL26MruyBU6YakQmuF2K6ysNfVLDIrPuQr1Sfay+worCHljY8tns?=
 =?us-ascii?Q?aPMwRPTifd/YSpjKPlpPKDB8CuNAre+yOb3k1hXuKUoHnfv1RPhdAhdwc6jg?=
 =?us-ascii?Q?F8mvBLDxc9mls63SgJT9TnFVWHrSZSjRJnEEuXagC2F6exm+c8t2WQPnmYUn?=
 =?us-ascii?Q?hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24dde03b-c55a-4155-3f4b-08dc4c95f78f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 06:36:56.6907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDeukJ94JvGSAaFqxDP7lpSWrTKnFr+Q7oEyrNSihRkEx+wOHQiQodPhgx/VI0w0+mMukbFsAa96juWyv1vntvVIgzqX5UHCcJsuAXY3jac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6966
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Swiatkowski
> Sent: Tuesday, March 12, 2024 4:23 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Marcin Szycik <marcin.szycik@linux.intel.com>=
;
> Kubiak, Michal <michal.kubiak@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>
> Subject: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all =
profiles
>=20
> A simple non-tunnel rule (e.g. matching only on destination MAC) in
> hardware will be hit only if the packet isn't a tunnel. In software execu=
tion of
> the same command, the rule will match both tunnel and non-tunnel packets.
>=20
> Change the hardware behaviour to match tunnel and non-tunnel packets in
> this case. Do this by considering all profiles when adding non-tunnel rul=
e
> (rule not added on tunnel, or not redirecting to tunnel).
>=20
> Example command:
> tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
> 	egress redirect dev pr0
>=20
> It should match also tunneled packets, the same as command with skip_hw
> will do in software.
>=20
> Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
> v1 --> v2:
>  * fix commit message sugested by Marcin
> ---
>  drivers/net/ethernet/intel/ice/ice_tc_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
Hi,

We are seeing error while adding HW tc rules on PF with the latest net-queu=
e patches. This issue is blocking the validation of latest net-queue Switch=
dev patches.

+ tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower src_mac b4:=
96:91:9f:65:58 dst_mac 52:54:00:00:16:01 skip_sw action mirred egress redir=
ect dev eth0
Error: ice: Unable to add filter due to error.
We have an error talking to the kernel
+ tc filter add dev ens5f0np0 ingress protocol ip prio 1 flower src_mac b4:=
96:91:9f:65:58 dst_mac 52:54:00:00:16:02 skip_sw action mirred egress redir=
ect dev eth1
Error: ice: Unable to add filter due to error.
We have an error talking to the kernel

Thanks,
Sujai B

