Return-Path: <netdev+bounces-78620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A6875E7E
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 08:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CF51C216DB
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726AE4EB4F;
	Fri,  8 Mar 2024 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHTOnsbt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C54EB3B
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882981; cv=fail; b=VEZ6HT4zyXMHR+Yu7Pl6C1bg8BXgZUAAUnSt8OOTqOI4rvIHGmZ2ZpW2ip9Dve9ar4NzvSVGYHQ2qa1aECBuSn8oWDUm+7JZU6prAd89uu+kAKLtFuFw4AFrS5yTRtuRcQtHu8N1bNZI4jV829+/ZXPTM29w4q3l1UPXWxZWJ50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882981; c=relaxed/simple;
	bh=DsKWjBoDbC/X+A9/cmOpLQjMFjUAJXOx0nlR5UbnpAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAXcDl6mHA8bWaa9F7H2STr2yiqU8Q4IDDLWpedxVTT3dmtM0vOniHIw3q2J8BHZLezfb4SHioNqt3cLp6c5MR0EY9t1pkNgcC+9OUXnNAT9jZ8WVjQfWvCPIL3G0pvDCEhUH73zEPXJIhIKWTixK26XK7OUFxJdRqiITWAk9yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHTOnsbt; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709882979; x=1741418979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DsKWjBoDbC/X+A9/cmOpLQjMFjUAJXOx0nlR5UbnpAE=;
  b=SHTOnsbtsWT7/RafSkCFT/N1RV5cR78AlyX6Vn5tfD3YbrpNoWqGcjqZ
   bv0YH7u+SRGMz8/33ZCxqoYDrI7DQ6QHd5LxF7LjO3jYqiDAg5Afyhm+e
   BTHI46qd4fdcErCPIfvVmKm8wJGJwUEFqsDrcjV7OcuDbIEO5ahV7qfFF
   iis28bR0UPvky3VD79k3zjCCnu3h24/RNg4NsmqPo6j1bo1mV1eFL/XPG
   jwMIPTbtI3AN3hl95SYC8iqzXxPTo5lWAOUeZRCUjonzeQfWQTYf003pS
   0ZdlgoPmM+C2U7O1HBnzWqIvS2jyFhjbj77AGtYmhVcn8aSs+K88V8nV9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4731154"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="4731154"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 23:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="15073250"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Mar 2024 23:29:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:38 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 23:29:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 23:29:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTIubg2UWJpCyqnVzVjmo6mbcHgpRKVIoKXlL6lRSzhvoRnrwFt7/XZkyeS3STUkYQGwRY3aOMB1gJannxK3p6sPhdrnYGYmlpLRm8VECMQkEcYoN8xfEkjOvnEysTEqdtGFJLBPsuWmtxjch16wXae56pbcUoKkqevgVYcnUXV1NDASYIE/Kaz/HTW0Qr2kqmEaux63xd5yHbYdko2S2JD4z0pQuDVaLwD6kkErLkPsLub2hXg6+KfNuNDjqY5UCXTVIWwqU25+aT0t/xCqGypl3IQvUpTiAj4rtdI4TGWOQiq3j2Xu+2POFtiaw5RZAsmfjO0xlT3qFPQN/GwQpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHWf8s/Ml1MCWiBBgWd8j6ro+3egLB/7vzPrV8ktwwA=;
 b=diu9Wh4VayhgV8f28WsIjMlNwC9HMnFHW53MxvWRnnaA05VTKDBOD9iAM8uNc9TiTwudGIY8EbH7REHm1MquD1R4w4XGRjsVjSD/cZ9Vq6uqlPwPe7z9upc2htwrzivVISsW1+UMfQagHkY5tFGf9NjN9eAU1/E3XbHZH58hXqDRRIxo54mdzJqFePKJf/nFRWsSuMF2D+4QjjFGOhvK3wqjH1VbrzFmqT5YfygPK0ITob3W6CmpQV+FDYGuWX82uYk5NQpSwXoHOmHJ1bqOFNMIQhc9roP1eedKUOAzU51+BbN8yo2IjBZqcZcC+4NjRfyfrWEUdgeOzkmgC+jl1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5013.namprd11.prod.outlook.com (2603:10b6:510:30::21)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Fri, 8 Mar
 2024 07:29:31 +0000
Received: from PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2]) by PH0PR11MB5013.namprd11.prod.outlook.com
 ([fe80::66c9:72ce:62ab:73c2%6]) with mapi id 15.20.7386.005; Fri, 8 Mar 2024
 07:29:31 +0000
From: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Szycik, Marcin"
	<marcin.szycik@intel.com>, "Drewek, Wojciech" <wojciech.drewek@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "horms@kernel.org" <horms@kernel.org>, Marcin
 Szycik <marcin.szycik@linux.intel.com>
Subject: RE: [iwl-next v3 5/8] ice: remove switchdev control plane VSI
Thread-Topic: [iwl-next v3 5/8] ice: remove switchdev control plane VSI
Thread-Index: AQHaa86doNJsCmixuUSpFanPlH/ap7EtfQcw
Date: Fri, 8 Mar 2024 07:29:31 +0000
Message-ID: <PH0PR11MB5013357E767EF59CB3E515E096272@PH0PR11MB5013.namprd11.prod.outlook.com>
References: <20240301115414.502097-1-michal.swiatkowski@linux.intel.com>
 <20240301115414.502097-6-michal.swiatkowski@linux.intel.com>
In-Reply-To: <20240301115414.502097-6-michal.swiatkowski@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5013:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 9190a7a8-5849-4440-ce27-08dc3f417f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVI33eatiJOrmeNCVQyA6p9veE6Rgy+rGKvt0UxNLS4mpvUEl/KlZDdrwC2wLFycteGb45eaGLD/3TH5sNl3/yDJdAniza/OklWmql1FdfLwaHMsfGf2ekpGmcJVTtXOF68iD78wogUdBxxAclnkp7bZ8mITXJAqkqAonWHyOpkLgnXHNv9kPtla3o2slTZ/gr7edHgjXKVSbj2/grcEQLk46uXqy4IsfQFEC5388Pcelg54QWLJRkywADvCBdp3XwjEwzs4ll6GywqjlxBpsMR5WkwWjHW+7U750QcWb8IviRrVek/hW53z6/tnVmdz3qDxuJL9RBeL1eWX1/DUaw7Cg8mOp6Ovx9DNN6Ts0F50/gHpXjMSa5l8H4p3YdECkkBVxZEdMHmtEeFC8RGUAM3gCWbqs6fRlhQg20yOTVevuz7ZHC0d93wC0dRDi8zTioSdFBVnih2cgzodRXVQ6fFG+DgaozpXpWQqz72FEjv8UgtlBe5A0KUPVOVZDWYh8YkhjdfosOvVcbhBwOuact+3tL1tuH/yqi+DBH/ldjw4q3WvI2JCBqoXV6CUTP5fIVzfutqXuf9j2EazwUzek2vLbOMoDkd90IzV/6E8s/Tv+Ze8JqqchDOWBzvZV5g4e5jcFTknGMqTqj5FEp4lhVQT5iewhNs+I/l92BPzqVwNphBB7MuZ2iYPqIO8vsHqKKAzBRkpxKDdGIVpijnrIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5013.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E6GLKKZIg8VeZu1hF0XXoN04hIngDzF/5wWcviz/AL/+RdcSi+5IHA07IhL3?=
 =?us-ascii?Q?1dWlckY4dCptr3opjy0t3s7g7iUEXnxyoMDVS30BTzg9Nk4eysuWq/tlM9kd?=
 =?us-ascii?Q?zT0noCwcH0bNOuZCUcx2+iU3nc6y75g2aQfyyAYiKOQGCFe1Yievx/TpanDI?=
 =?us-ascii?Q?lNst662/2VBk42zvMkuSDE4aEXe5NiFk0j+2Jl761AklF5mgXpUIzEr2DN4z?=
 =?us-ascii?Q?EZ1sY+pEL3LA6bTTP2hKNbGJtrfU3VfTrtbnh0CxWwG6VQ8CnwzIEosq6f6F?=
 =?us-ascii?Q?kVcORnQ9JAelaXo4/ZLYXzFkvvYScDYmGAYxkIMK43sW/Wi9DIQym7K7ZtRg?=
 =?us-ascii?Q?6NTFZlpSb0uD7Y0aMHDgfI6e+3Qodnul5khZdYq8QIzpX8Qi1kceEnEGXqPz?=
 =?us-ascii?Q?xfxxD2hJEV8D3XXR+CqwG7JzNMz5Y6AqPI3ODwfnYIv9ddaXzCj8X16OmUN2?=
 =?us-ascii?Q?PQZxPqY8abTtLIg06v6ZzpxbzWU91rlzR0S+W9o+woNg1Pcm52Mb2S4JQfo1?=
 =?us-ascii?Q?BbuJOTCYz0UmLeA0+nPgA35F4nl7hX+VTB7+5tzWwfaRbvgJUp8bZSZA7byX?=
 =?us-ascii?Q?nnkBZQUZpAS4dqyXDlSbEv0lnA4w2tuRrpkWl0KkCHkumazywsFDWhaCOYzP?=
 =?us-ascii?Q?B2AMOWiWNl6PbqjN61Ss5uVoZBVB+M71Ivh/l3dciH3xGAZJciFjlzClLiKd?=
 =?us-ascii?Q?ah0zwQ2nnpY7FxvRoLBU/UCMU+EiM9ssJI9eL3mdx8wcxgHf0o5iAkWusg0w?=
 =?us-ascii?Q?V8pL4a2ERRGmBbO/dR24pz/2ysrPmKQ+lCggyBq6Nw6BJWETmfYKk5fmzkdj?=
 =?us-ascii?Q?Ch4zXSAY9h0s+ctwXHZskZO3jZ//Zh6/3Q+YFXL/9BF7zGCR9YBU5sQYdX7D?=
 =?us-ascii?Q?4MGUiEAGxZkUKEPqnguVruvvXXuJuVlFtnq3wz/el/SnoF5JUzt4G+/YtIKb?=
 =?us-ascii?Q?8fc2MjKGM0MO3ny2zO2lhYdk4/L2r3e0KvF8FPiEv+OeZukkHJIMa1AVIxyd?=
 =?us-ascii?Q?+QDKmBIxV4ZAyT8VVDjc4PrPU5C+7xGMfssZ5jN4i8PfzraXEz7tdT6EZGtQ?=
 =?us-ascii?Q?WVW8i1E2BtVmI0rIpQDJS8E3B6Dk9Zo3pMdpKuYC2JtbQ4cBnS8YJH551WBO?=
 =?us-ascii?Q?f0VQLr/zubRGwUtNJxHGqLgJizAT5CrTTsnOPTNcQczdmuW4up2EkmWEow6m?=
 =?us-ascii?Q?pifdrVRMawS0jJ6a9lKzaG/owxVtUZQcZMe+3CYyy1GqJB6xGZDV44DsTurF?=
 =?us-ascii?Q?m7m7Gj5wJ5l0rYPusIFiQbVEwOW+C13jFQp/2uBaMvsJtZEKShrC+wFLROAV?=
 =?us-ascii?Q?Q2ff2h7HTlgu4vuRsV3AXw2c7ePlEW2ZrW9WychuHPKrdVMOB9ZJmpUchMC6?=
 =?us-ascii?Q?HCrY65aMVjq0+RdjcTZMNP3VFmRFqJXv6teKBw6RXmF2BNuWxLoppPTw7WLz?=
 =?us-ascii?Q?FNPFj5oQgt9kRdtY6ZQjWBkOuJIJRbipfbNTrcIY6lIE0z7ZwasG2pilqGj1?=
 =?us-ascii?Q?Uj3SwZMGamj4m4ekhFqak//RGWWyBg8lYcnQ8N4EvNI4r/4uWmfeoeWNq87S?=
 =?us-ascii?Q?0CDf1zysVqfdqjPgU/IjhBiodkTpjBCKv01Jjm4pNL78wDg5+l+wCzhMOc6f?=
 =?us-ascii?Q?Dg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9190a7a8-5849-4440-ce27-08dc3f417f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 07:29:31.8386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8sH7LrrOXL1XMAj9LtBByfGPwtNbyV1d42C01EmDFFamv4iHUSo2Iy+0DcrcK8Rg7Ff3eAsjl4wtvb5S9wJWtgR2tryNTlKodhro1vIR430=
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
> Subject: [iwl-next v3 5/8] ice: remove switchdev control plane VSI
>=20
> For slow-path Rx and Tx PF VSI is used. There is no need to have control
> plane VSI. Remove all code related to it.
>=20
> Eswitch rebuild can't fail without rebuilding control plane VSI. Return v=
oid
> from ice_eswitch_rebuild().
>=20
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 -
>  drivers/net/ethernet/intel/ice/ice_base.c     |  36 +---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 163 +-----------------
>  drivers/net/ethernet/intel/ice/ice_eswitch.h  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_lag.c      |   9 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  49 +-----
>  drivers/net/ethernet/intel/ice/ice_main.c     |  10 +-
>  drivers/net/ethernet/intel/ice/ice_repr.c     |  12 --
>  drivers/net/ethernet/intel/ice/ice_repr.h     |   2 -
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
>  .../net/ethernet/intel/ice/ice_vsi_vlan_ops.c |   1 -
>  12 files changed, 13 insertions(+), 277 deletions(-)
>=20
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>

