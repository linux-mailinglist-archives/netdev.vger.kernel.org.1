Return-Path: <netdev+bounces-88495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA278A7773
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03336282F83
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD576E61A;
	Tue, 16 Apr 2024 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qoyk0Xdw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20D17736
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305321; cv=fail; b=bDTXAjhkmgSSfizk07I+lsq/xLP+YYiMXZODTPyq7b4Fa6qPi5UzoK91nQMVdsSVtjI/iu6dFfPySU9EtU75VWP1rSNckNtdA+aB7dnTSc5KfjDrIX4Kuu8iqSZW0yNZBRKcRyLLON9u21QP5T4HfnKPx/FmGCDh62sMbwBHTWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305321; c=relaxed/simple;
	bh=uCjzLQ3uYZB/JfLE7gzWJbsdYiA6Fl1aYNECaSXV1xI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nc2HJJoUrm/0f3V+3kcXuVKIjw4zsHElhe4OIhdhKsuUD1YAX6QndGLXndoFLsNvihN1/A04j4uwCfn4O0BkSQ9NRMp3Cdtq5CErZFZAJhtt7N7si7euHgE9OIg62XRMbVVilAcWRYk/xIz9VjB1yfcJL30WtSwjMSpV4YWGEoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qoyk0Xdw; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713305320; x=1744841320;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uCjzLQ3uYZB/JfLE7gzWJbsdYiA6Fl1aYNECaSXV1xI=;
  b=Qoyk0XdwD9mAQc/6dYW+0zaGUsI6T/1lwSvz78+lTrU/cglhy3qs0gQq
   EGF0nCpUab5vH0vnGEoVlSFYwYviyZ6C92e2p2d/VXQD5M7BswVA+yZoL
   AZKF9doNPOPgiFCtGZphz2RTpWXcYbRLTV5Wxa3oxKSlGMRpWvcNVMBvs
   g4ai7A3NGuu7udpQIMpvNoQWM2o7wbWUmtkYT0uvn2H30nPGwpFH8FLwO
   hxYVmKKA1KqNDMlAGRUeyS+GM5Vn7Cm/5U3fgN24PpohmnErxTS0KRb5O
   hvDZX/U3WLmD6/YFSlqTGxUQRzN4rmhFKmGdaNYJ64SZ6fViYIu8/wsUB
   Q==;
X-CSE-ConnectionGUID: SciZP74iTJaPFBt9gOyWIg==
X-CSE-MsgGUID: C79hRpM8TkygmYAM8dj1JQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="11718202"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="11718202"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 15:08:39 -0700
X-CSE-ConnectionGUID: qEMvv738TvKHVs7VtLmVnA==
X-CSE-MsgGUID: R44O5KeZTMaj+QtdsFVXzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22463001"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 15:08:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 15:08:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 15:08:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 15:08:38 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 15:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EicGT/DAxSbELs5oThsVCt9pLA33VXFj97jwKFOpYZaQB7kTIBIkSOPqlTyQEqGkd6icvo/KpUucyiCSSGibhwOGUWD9Qh/UW41p7jCUuTKxAffMDAk1mQn1AoAPJRNdknJ6HiPn1uhaRD1C++MKlsxu7xsKcLCSMKV5Ea34xDcg+RPR30BQqwsaGnt0IsOUpaoa0AFnxUcoBQrIl2GiWdzIq7u6RJfZ4B4k3bMe2NAew+AGTEGe9Bhs1LEJPj2ccWqak5J8mm3vO2QSekLubKQBBTlAqoCTQ8y0c7IXCGJJglxs4jrMfHYjMenzJVFPGXkyTaWPQFlzCs/42rHCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCjzLQ3uYZB/JfLE7gzWJbsdYiA6Fl1aYNECaSXV1xI=;
 b=K9waYeQdoTn3phsnWWAkcaeOIUwlv++8RFR/DnYxRhqJFS6Rk9paYSKN3Jkg06StiYpByD3W9GAASgY7dg65FSAhiAWSfot/L7C+YHq30o2WlcBCST9AXRFNEM94WPtkyq2dVwr72GZTYhl+zap5oifednB2VX480R3IgrqBZ+q26ViBe3t/tgJJ0UyI4s+WerkZRQynUUpghBf/zFuBnnW0l4qO3DT8bXCGMC84ymVaLKDWlmUmNz9PBdyxcAiRv2UNti2CdT5GHDu5/L0QTkqH0aTXWL45M3sMHGRVL0bFqd+U72+aiyjuLnCIIZ8Po6+bgjhKWO/CcpLaVmO83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8377.namprd11.prod.outlook.com (2603:10b6:208:487::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Tue, 16 Apr
 2024 22:08:34 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7472.027; Tue, 16 Apr 2024
 22:08:30 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Gal Pressman
	<gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, "M, Saeed"
	<saeedm@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>
Subject: RE: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics support
Thread-Topic: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics support
Thread-Index: AQHakD30dx4eV1PwB0CiVPK7CxdwiLFrdJjg
Date: Tue, 16 Apr 2024 22:08:30 +0000
Message-ID: <CO1PR11MB508959041326B9BF474DD3B7D6082@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240416203723.104062-1-rrameshbabu@nvidia.com>
 <20240416203723.104062-3-rrameshbabu@nvidia.com>
In-Reply-To: <20240416203723.104062-3-rrameshbabu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|IA0PR11MB8377:EE_
x-ms-office365-filtering-correlation-id: 8fff5875-5a3d-4eed-4669-08dc5e61c00a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q1ybs54gyr3CW8KgF85LYJnqEzKGabWDrQS5PKQwrqqxl4WDlv70MduePYIDohnz8jKpEPeiDHOq4b5jx7gurt2jH21QduoJ/oQFepnmMbfYq4yjnJhAnBeWOR7BpdBO13ZHhlUiJ++G8nX+2XX4CT2uKpDeeCES2sIZmIjRbEgqMNnqTAGezTu28l1Q8nwRr4wMmYLM4zhRrsGNc1R9IUMDC8tYp/94fZSTBpIbHaviJk3yVSNOoeylR2h7vR9dTNbTe+tPjpqEeBSVxSvfm7bBbHCBAt7quPCfXTVggdcJ5zL1SPSaP0aoH+JNneim4+6XisYg62CEYOf+XAxquTgFD+X9oUDVifM4tYpNsqbroRt3xnzba7FZyxnjzs1Y6ZyBIiLss3WMtGaI1CBTk5c56rM2EViY+o6Wbxhg3QlDhIluk6xbDhrjhJ6xwGNdGMHss9Uf+0KrwsIQatEpU7QbDutfhUb1cbp35EjNfrb16Sg5dftRS9wI/VVNOuTq/dDXKVXPnFgRAYQgwlSOy/NVqb92kPhiEN9+udKq35pCa3ZnLffPolW92iHb3twZbwQJ92k5kzr8dnm2fC3BnReb6eF08BLDHpijur1Yke8TLhyMst8zESHPI65D0dhHk13wNtdq0PyChdW5OHqxcp364/0RkAbGSJq4vQXz8rAJrdIbmWOZKUS7Fmkq+PeEvRclXZtLekhtH0sMRqPFEcnOSzwGi2pPtCQRO7S0oQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g56qGf7ur6NxUBsDWPaCxfcZeNUmKI7meRjV+kc29NgZWuARlpo76VgoaQtk?=
 =?us-ascii?Q?BivZGTjdiUksyImbhDuyCApPWJvKFHR49jw8vpkHqjJDf8+1HJgcneCwsZsR?=
 =?us-ascii?Q?VDuYz9UzWLZO64gu4EemrO5TRqAjVqAGlKg4mvlBtm/22wZQi3NYwoAysNxt?=
 =?us-ascii?Q?ieiVrd4ImgzSwNRO8t4Fi/z8GlIwttNe/FD/mwNKGGdtLRcd13FMke3MMj/7?=
 =?us-ascii?Q?R6/XVuHoxrm5lBEkUgyle0ox6rZfs07pGI7QC21jZMgyRWYvS3QXIcw80im8?=
 =?us-ascii?Q?ywLETNabs4VURIAWjq+4eQXHrBClkLMmqQaFCT2f+360eh/0+vRd0Vg/q7kz?=
 =?us-ascii?Q?DxvF0A55Vz6hOHeugoh7/RLTvdHnu7hZ3yA6HQigw/pr4T7FwvHU99s1m8T5?=
 =?us-ascii?Q?06w156jbpUql0JpF4YbuShB362d0HS0COEkbvM4wOxzDRKkUTmQd6NvF/3Rr?=
 =?us-ascii?Q?yDC3a/rvl41IzCsTuiNtOsVmHCzeQrN5oI7B821Npg+eLwnSzezfRbu3ybHM?=
 =?us-ascii?Q?TxaiVnn6ZpPM4y2/08NYuKg2udp2xqpOFhxEpI3hWhON8NLlog0Q5R7mFfyo?=
 =?us-ascii?Q?IOeXKZ8+T0GL8T7igPX7O9btCzPz2oci2gPJuIpK2UjTPRXo+lVKhrbjkZa0?=
 =?us-ascii?Q?niTltvQpyHFCHTmVs55nVClax0liOUQYX0CgKbbq2JEMQEcqTRUDou5GJepW?=
 =?us-ascii?Q?oncZm/saw8f7OWeXdpXnRBhV862dirQRWZN2XwciOFPNEkJys2b+dXmGqjgb?=
 =?us-ascii?Q?LXxzjQK/nDw0wnmUKpDRVhaZowJm9+kjmyIPFoOltgiFw/nQYuyRt9ppc9eD?=
 =?us-ascii?Q?ghT5HMnX71Sl3OGsFvrk1RiSITU4ODA/rov3lbLlZaVAgTGf5eQp8M51i4MI?=
 =?us-ascii?Q?JCvUa4X4ZENamskDJx2e4HDTrHE1/3sjJA6bvqicDVfPD9+NZ/+/KPUeahb+?=
 =?us-ascii?Q?QwqedFrHF5yeNqAu/iyo1aDLkIEAotRqlxTi9v9xIJjgvIk9ANPhujvAEOcd?=
 =?us-ascii?Q?MEy00aF0JCE9HabuPvFSjtsjNJXqaJOjSBBjJKXUtK2gbSvWUcgHv8CgULzB?=
 =?us-ascii?Q?YtzOE8cOAupfTCZXtpOTf6svbM28zxd4qTaK1bwTaIDs2bph2nLi9JXwv4VY?=
 =?us-ascii?Q?OVMaqQsVGLFTVNyYLxNjz0oKixf/YjnrxWmmPMhNjzRPd6n/qMiRKee1DL+p?=
 =?us-ascii?Q?+Ir/DCB+R48p23pQn2oJYXzyuebtKuoZscVAAVIDKqkeORzhf3gZCjsXHhA5?=
 =?us-ascii?Q?x/4/P20L1GQy4FoOlAaf2CGegJv7IrJTQrd+4qU5Twr32emFZXUBmYzs7q7m?=
 =?us-ascii?Q?2DjQXar2rVOQZJOSvy9EeLBKpK52o9JD9FNfEcJKH9D4PZnvfplqDCG0PEl6?=
 =?us-ascii?Q?NSkiFLOiFIypa5rfBii8ysYb0DEHPa4WSToEeWJ7+GbTcjIvHJp0S0a9EehN?=
 =?us-ascii?Q?U9urOGNLdt4iiDfYOgErNIKCgCSvskORs2I9KCMT0zxFu4lpHCVW3FIGBzBQ?=
 =?us-ascii?Q?dA9Bb31FIfsS0yPoCMxi6r4SnQR3KX/tbCxkA8XYR8Gx6je4nejtEtqAdmR0?=
 =?us-ascii?Q?aDg/VoNFwGodI8Htb4azfIez6D1mJWlrIfil2HXa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fff5875-5a3d-4eed-4669-08dc5e61c00a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 22:08:30.6134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FjIlnvncM6+cxlVqDkeijEQCYiY0FCKlIsjChh2mVNG9HWdDG5SP1AoCfbreJcc2zHsuR07jds2XlqA5NOgTVNYje8x2zX2KXqreQdIcmrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8377
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Sent: Tuesday, April 16, 2024 1:37 PM
> To: netdev@vger.kernel.org
> Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Paolo Abeni <pabeni@redhat.com>; Jakub Kicins=
ki
> <kuba@kernel.org>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Gal Pressman <gal@nvidia.com>; Tariq Toukan
> <tariqt@nvidia.com>; M, Saeed <saeedm@nvidia.com>; Carolina Jubran
> <cjubran@nvidia.com>; Cosmin Ratiu <cratiu@nvidia.com>; Michal Kubecek
> <mkubecek@suse.cz>; Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Subject: [PATCH ethtool-next 2/2] netlink: tsinfo: add statistics support
>=20
> If stats flag is present, report back statistics for tsinfo if the netlin=
k
> response body contains statistics information.
>=20
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks! I'm hoping I can get to the Intel drivers soon.


