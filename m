Return-Path: <netdev+bounces-98402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E926E8D1445
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 08:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178FC1C217CB
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 06:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786A431A8F;
	Tue, 28 May 2024 06:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT6IXFB4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5EC4D9E9
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877088; cv=fail; b=pb0DR12feGO7UuGcBkXatS3sBQghAUcBbdu2YCKAZ5wFPYGsm2dsw6OzD9IUikYXCSyz4P0Ym8cbE5dkI63l+L7OtknLKmsTb2tECXT3TNEheiArDOQDVWqGJi9wh6EDMhFeRDkCrpW7bd++ypy+PzUvI2NCqtOQ/+EmW79/3J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877088; c=relaxed/simple;
	bh=hfsy25YXXwDRQPOCELLgj66ZvubjmAHHcdjRJEPOvoQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5W40/JxNQ16kPkcHNrPJgJ1ML3GICqYZk+gF44kpOSfjsGuEQDjsQBa0K6VoHSxwJDHjebNNHTyGO8qZaHjx3OjINGt1C3gTtY9cMhRyh1wj69GVD3FQGuSFwmsdLCjEYtbSQ3l7Dum/DSWcTk0NEzO6sKzhWysBHXgVZdQVyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT6IXFB4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716877086; x=1748413086;
  h=from:to:subject:date:message-id:references:in-reply-to:
   mime-version;
  bh=hfsy25YXXwDRQPOCELLgj66ZvubjmAHHcdjRJEPOvoQ=;
  b=iT6IXFB4SodhRZV8ZV2JSfnUUTeKfFPdK6KULDCT5OhD5Y6dkq54mqRB
   rxo0G9B6RiDNnXRVBPv5yobFFoo/0JQtOVmiYWZ2CMxxNiALYtAy6BSSz
   7nhNoZnr4cg305r9y/Em4gW2n/m9CkhSnqNmj2fuSi9PpVVQwLjIrOiIQ
   0RAxJqNNfQyKwQTKL/crE1/LkpbpIJ0/Vr2MZ44160+E5sh1Vqyo/2VT3
   Sdy+OO7JzOxWK9D3Wymalt25c+GnX3NGAnnOmg2r1DC22RwhWgniYY3xy
   xlQlSTO5NEETxMGZDrRhBLj/iTL0NiS6+bSBa+OPMp+P3J4w5fMLZThsz
   g==;
X-CSE-ConnectionGUID: AQMvil2eTumsSDcPX8JsuA==
X-CSE-MsgGUID: WTaTBg4dQ7aEit2An7zRFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13389333"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="log'?scan'208,217";a="13389333"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 23:18:05 -0700
X-CSE-ConnectionGUID: qzIR2QqdS3CFI/aMh156bA==
X-CSE-MsgGUID: 9xXbFMbrTmqgnRaRk2z7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="log'?scan'208,217";a="58142648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 May 2024 23:18:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:18:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 27 May 2024 23:18:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 27 May 2024 23:18:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 23:18:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL7geLQa2umYgPZfUgOs85biy9nEwBOazje2oDSnd7TzT6ZsSlapVta20IU1X30RdXJZmhbmPinLqbI7Ui9aeU0FUMIkj+vbMhUyaiulYITKyRKPxJUOGzg2fRTCXimGQ5c/wFj6eT+sJK7zVDVFXCNbZbDdnxcJ7XIGKPX5CyTSPnuPbSpVAm7MGt27FyOB9j3WEunWOQTnTBsdECw05R1zghujXlsQRzkH/REVMEnse7C8u1VLjkmmutfs+QeiuFrmm39UKCs+5lfC+nsXf6na49OHos+M8d/Jku65mVv4JR8qwtei/gbH5V4iubhCmmdfxAzh8BvTCkX44uDTng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlfexMSbxM9d6gyqw0VyFLMepBf0og2JhcreOEHEk6U=;
 b=APe1DmS7CFXVZU3Anj5NOrjoLmYd0hlgW7StTUHiI0IkezkNkA3uSb6inSmRmREWC3A/fODVHKEOkH/meg8fBYr1YfZQjRKgKs9+k4eMpsL5jR9/FuRQjjI/8QIUttVvfDD91hyvZhYJdDm4HLPthjF1BX6WRgGnT2VnNyLFijO70WYjlWkRNnm3CT9XIdhAA1N9PrnxtAuTFANJ2HokpMYIWjlx5cxbPvYtUa9NyniZNWPABdoMSvYtVj36X9HNJxdnXkU9d7f/T8sNyuwVIvf1oEQrcn5GspTx21y6FYAe++6EYi7zVaFvPwmTYTHameL93sFP8kjLhysc1jVFew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5159.namprd11.prod.outlook.com (2603:10b6:510:3c::20)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 06:18:02 +0000
Received: from PH0PR11MB5159.namprd11.prod.outlook.com
 ([fe80::e7aa:f8cd:6386:5562]) by PH0PR11MB5159.namprd11.prod.outlook.com
 ([fe80::e7aa:f8cd:6386:5562%6]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 06:18:02 +0000
From: "Berger, Michal" <michal.berger@intel.com>
To: Shay Drori <shayd@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "moshe@nvidia.com" <moshe@nvidia.com>
Subject: Re: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
Thread-Topic: Kernel panic triggered while removing mlx5_core devices from the
 pci bus
Thread-Index: Adqtr4L1Ysw2QWzPS/S9Q/FUKTvMrwBubLaAAFcaIU4=
Date: Tue, 28 May 2024 06:18:01 +0000
Message-ID: <PH0PR11MB515990257791E24CF6E0E51CE6F12@PH0PR11MB5159.namprd11.prod.outlook.com>
References: <PH0PR11MB515991D1E1AB73AFB7DCBD03E6F52@PH0PR11MB5159.namprd11.prod.outlook.com>
 <c51bef25-e8c5-492d-bb80-965b7f8542f7@nvidia.com>
In-Reply-To: <c51bef25-e8c5-492d-bb80-965b7f8542f7@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5159:EE_|DS0PR11MB7215:EE_
x-ms-office365-filtering-correlation-id: cc9bd3ca-6a55-42fb-a1cb-08dc7edded90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?r9px4DNTmg+3bgSpSdaDnrDc6YYxIVW9GagHrp+OZPbOBpL4Ad6rlzWro0Aj?=
 =?us-ascii?Q?4kkV+F06X95R6ohdUaX3BgDtS4GwER3IYYXpKZ8wCzautOiqXOwVp0HErk+G?=
 =?us-ascii?Q?GOmXD0uemYAZhCHF2IBwrGQSXY2u+fTzG94X2mTwASAky7TBjrlCwqNgXhA9?=
 =?us-ascii?Q?6kA6EmafLOvrsd52TbGDZ82dVAX+sa+wPJQ6Ib2q+tDhWeZVygWO3y9I2qpd?=
 =?us-ascii?Q?TUPOanCqvGJmzrU6mwdPiEnjtW36eKyPScx4+fUxuZ1JqzMkQTsVAcMBnUL5?=
 =?us-ascii?Q?da3R4+lfVaXphrwTwRlTGZGb5uxLe+2mzZOO5cSIBFOHBH7i3+V23CHunGw3?=
 =?us-ascii?Q?zPCYN/stLVWY8QVPhYOv4hX+B2ZPouLSh4MW+1UU85hyVDd2008G2Snvclsi?=
 =?us-ascii?Q?Gz/JpFgIAx/9+/qDjbY1gkC4jm4G8LdwuaN311LBF4ans1rU9KaU3U3CGIBi?=
 =?us-ascii?Q?vwM/gVJWQuApuJFiogqmQRvw4waMAV4V0ZkhkR7+B4wRlp38V0OdBPRANtP0?=
 =?us-ascii?Q?cTjogiR2D4jDkfMOHVX8aR9GZpOwx24NAQclM5sobInFjTo6sXfsGvlPfbVF?=
 =?us-ascii?Q?lg10HMuQDXei73ZnfmZMcg1I/SECWvBTa/wrdtFKdxGjgQYuVglR5eJmIdsN?=
 =?us-ascii?Q?NWfhh7v7gAoVssM8zvaaJmx4JephQksmTpqoXib0+2s+T1Dq6qaavvDPCeML?=
 =?us-ascii?Q?S47mWNUhbMuExFpL2YaJpcZTCvKUf2iFJZUtPNS409CURdHezfSNRil8NSlN?=
 =?us-ascii?Q?/1/xtCKYyZFTLvHPGz/8iRx7cNaLkiCXn/GXVeX1Vb37twXWFIdrpygkiIfa?=
 =?us-ascii?Q?b04bfqK/qIrr2oMX6M8Q6YWnuoJCcAwlUpxR9N/GhnV/sjVkiVmMr9LB3Q+L?=
 =?us-ascii?Q?vktPVKUQxj+48T3kd5GeQwrT6K+idBPl0ybxUoXaqgadN1zn1UMzW3kQiVWU?=
 =?us-ascii?Q?t76buOdYNF4VMEUOywE53v4NOnLvBJtdYDgQ6OaPtwJs/u5U0koGuNdGFfVN?=
 =?us-ascii?Q?ao3ZqZDib6gXrms8LYkI61vU8bnQ9PFIvNnV1EUstvyAv/V0guHlchHFlGth?=
 =?us-ascii?Q?ZiM4iGO38Z/uVqOJ8dPuh4vGBq+J+zbnEd/H/tNAgTpb4pM6gQ+ZSgGay3ND?=
 =?us-ascii?Q?X6AGrBIW7fLwjjy6s+/gi1CE/DDOrwTXc+3uJ7q3HUV3W14d+BU0GQHLY3/c?=
 =?us-ascii?Q?jV4jD8MVOJjaCS81khLxYGgwzPVqRTkERD+yRA8waJMkx4fyfQi6eSZmURzy?=
 =?us-ascii?Q?d2kE6qu3rUG7kqbmR9jq9NMhyjHASDJsFnb828m3oo2wHk5AeBVTNAlgx0a8?=
 =?us-ascii?Q?pcw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5159.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?werjzEyGmxLIZ5/OtyajlHkeOVUvHfGVfB3C//mUEmKACLUcli+/KC+5KqP4?=
 =?us-ascii?Q?ZM1zQls50qZl+yKN5FcJoU4flIRFamx1rNJrj7j778HMd8FrrtVy5L4RIqC+?=
 =?us-ascii?Q?6tzFIRu2OT+82QawxlNLufZtk3fBAxtoIaaGhgTLpSrj19IZ4RiiGtXj+mZv?=
 =?us-ascii?Q?qNSVmaA0KR3TLqqAoqVg/V3SKiyfZad714KUTIuHHMIs8OhBBrA8zidXs7nb?=
 =?us-ascii?Q?GsFlDtuLLoxG/UNa8Zpery4Kc5ASKQ2HFSOr48pMUANgqtlZ+F1nqjSb+lAF?=
 =?us-ascii?Q?1wEFb3NGyIIAzIKOReXCYN5oZWUjdtjGpBGuFIN+FC1ZsSTvUnNBPXyPgJlY?=
 =?us-ascii?Q?XyulEGeAuUR6fSgjMWIOGsOnVc6HzMCdqzpagl/ocf6ltULsXi8F+PBjpNNX?=
 =?us-ascii?Q?dECzV9+L/LEZSGZm6Djp1GOm3hGmXnPNTAmjT473dBMckMfFfGEW9wpRCMrS?=
 =?us-ascii?Q?kJKthIA6s5FKT7c1V/TrzJ67x+7BBovwcaQgVg28us0LNPz+YxzWrobMV1Nt?=
 =?us-ascii?Q?Uzgn5+wlR05efO/xO9xjRaghYkRn7FU4IJOcRnkT19k0NeXHc6KAXTXgXtum?=
 =?us-ascii?Q?dBkzfx3PanqmhL3wcAGD9vigi/6PhMIGkkTgAZE+JuJquAhBd1xg7eCE/8VE?=
 =?us-ascii?Q?9VvhVxH+rX79QzgQ9sr0tMMRCiDOyFWC0yf9ozUa2hLoGtcbZRyOnsNttlse?=
 =?us-ascii?Q?LZD1A4PkvA/QbkDJpBJJeVRQ2p2v1rv76rsvEFjdR0gFCZZCwS48wnoEC/79?=
 =?us-ascii?Q?IbAur2vcSb0CqEujvoEnVaSbELISy/b8/cLehmJWyAbiQc+nW77hNAlbj0VO?=
 =?us-ascii?Q?GvCAAmcPZpQqcCqtqi7rQpE3n0wM29N9nEamsmB3u6DUIql4BcGC3CYXxO2c?=
 =?us-ascii?Q?DHVy3eDbFJ4yRfR/VZsfJuK4OHfuTUINYEzos4lYSTsqsymN3PTA7eRYq+Tt?=
 =?us-ascii?Q?mzctO53LtlWtE5tZ+Q7W8xHgVg6G9wkA7qZ//l94YA/TeYhNopc9HZ53j3ax?=
 =?us-ascii?Q?+wBs7aEb2QEjZQdPAv+QY7Ykg43Tz85YfUFxWDqkdZyCzFlKdkv1rj8WsDWZ?=
 =?us-ascii?Q?6SrwJcVaiwvEqgvRjWkVrm0RcW1gDdaiZSL30jgmdkpjwKXcV7x8rwS8lR+2?=
 =?us-ascii?Q?7SZQ/DOiqnyddHE4E4cEki2jcaMVdBlpjn7mDDjSPOJgRBmjRlXniNN147NO?=
 =?us-ascii?Q?5ZkyXXvWGGCzbdMUcotnO03KMywapyWceHv3UPDCo3F5KFYKv+yym12v/QhN?=
 =?us-ascii?Q?1grRdjHfWaetloAXDUlLCDwO8ElMJ00iZx1kHt4SK+3cjeQY0CaK+rpgijad?=
 =?us-ascii?Q?DIVUlmhKGf5wpjL7n5H2u8occEXQatyjhdVDys7iumjoVxR3xeSy5whg49Js?=
 =?us-ascii?Q?e27rKh/oSSyFWCQhqEPvKCGS5uhiMpImm0Yhk4yzJ0190r3K7tl6RkhI3Mgv?=
 =?us-ascii?Q?AJ37beFFfIEAMHZwUiYoLl8L3vxFN3d6O0zck1Qqf7L/8IH9tGp5i/gkBP/5?=
 =?us-ascii?Q?/j3nzyfo54x0VE2izyJp09I6w6GlbNFTW2Pfc4s6FEmQ4uO7WqyDzZyRzkAC?=
 =?us-ascii?Q?8X5Ji9BE5AOjWo9XHiXX7gvLrHsaSdwEiaLuFxJH?=
Content-Type: multipart/mixed;
	boundary="_004_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5159.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9bd3ca-6a55-42fb-a1cb-08dc7edded90
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 06:18:01.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5e6mcFZeEFlWSLpVj5mv1iHUpQ56JyyRy5Yehbwq5m4/anvo/x2Wm1K37XDEPDB3oDFhdK2HfXC6OuCUGFrJHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com

--_004_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_
Content-Type: multipart/alternative;
	boundary="_000_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_"

--_000_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Shay,

Appreciate your feedback. I applied the suggested change on top of our 6.8.=
9 kernel build, but I am afraid it didn't solve the problem. Granted, the s=
tacktrace doesn't point at the mlx5_health* anymore, but the panic happens =
exactly at the same time - it takes couple dozen of tries to trigger it, bu=
t it's still there. Attaching latest trace.


Michal Berger

Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk

KRS 101882

NIP 957-07-52-316



________________________________
From: Shay Drori <shayd@nvidia.com>
Sent: Sunday, May 26, 2024 2:35 PM
To: Berger, Michal <michal.berger@intel.com>; netdev@vger.kernel.org <netde=
v@vger.kernel.org>; moshe@nvidia.com <moshe@nvidia.com>
Subject: Re: Kernel panic triggered while removing mlx5_core devices from t=
he pci bus

Hi Michal.

can you please try the bellow change[1]?
we try it locally and it seems to solve the issue.

thanks
Shay Drory

[1]
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c
b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6574c145dc1e..459a836a5d9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct
mlx5_core_dev *dev, bool boot)
         if (!err)
                 mlx5_function_disable(dev, boot);
+       else
+               mlx5_stop_health_poll(dev, boot);
+
         return err;
}



On 24/05/2024 11:07, Berger, Michal wrote:
> Kernel: 6.7.0, 6.8.8 (fedora builds)
> Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.1020
> rdma-core: 44.0
>
> We have a small test which performs a somewhat controlled hotplug of the =
net device on the pci bus (via sysfs). The affected device is part of the n=
vmf-rdma setup running in SPDK context (i.e. https://github.com/spdk/spdk/b=
lob/master/test/nvmf/target/device_removal.sh)  Sometimes (it's not reprodu=
cible at each run unfortunately) when the device is removed, kernel hits
> Oops - with our panic setup it's then followed by a kernel reboot, but if=
 we allow the kernel to continue it eventually deadlocks itself.
>
> This happens across different systems using the same set of NICs. Example=
 of these oops attached.
>
> Just to note, we previously had the same issue under older kernels (e.g. =
6.1), all reported here https://bugzilla.kernel.org/show_bug.cgi?id=3D21828=
8. Bump to 6.7.0 helped to reduce the frequency
> of this issue but unfortunately it's still there.
>
> Any hints on how to tackle this issue would be appreciated.
>
> Regards,
> Michal
> ---------------------------------------------------------------------
> Intel Technology Poland sp. z o.o.
> ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wy=
dzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-=
316 | Kapital zakladowy 200.000 PLN.
> Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu us=
tawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w tra=
nsakcjach handlowych.
>
> Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresa=
ta i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej =
wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jaki=
ekolwiek przegladanie lub rozpowszechnianie jest zabronione.
> This e-mail and any attachments may contain confidential material for the=
 sole use of the intended recipient(s). If you are not the intended recipie=
nt, please contact the sender and delete all copies; any review or distribu=
tion by others is strictly prohibited.

--_000_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Shay,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Appreciate your feedback. I applied the suggested change on top of our 6.8.=
9 kernel build, but I am afraid it didn't solve the&nbsp;problem. Granted, =
the stacktrace doesn't point at the mlx5_health* anymore, but the panic hap=
pens exactly at the same time - it takes
 couple dozen of tries to trigger it, but it's still there. Attaching lates=
t trace.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<p><span style=3D"font-family: Arial, sans-serif; font-size: 10.5pt; color:=
 rgb(32, 33, 34); background-color: white;">Michal Berger</span></p>
<p><span style=3D"font-family: Arial, sans-serif; font-size: 10.5pt; color:=
 rgb(32, 33, 34); background-color: white;"><br>
Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk</sp=
an></p>
<p><span style=3D"font-family: Arial, sans-serif; font-size: 10.5pt; color:=
 rgb(32, 33, 34); background-color: white;">KRS 101882</span></p>
<p><span style=3D"font-family: Arial, sans-serif; font-size: 10.5pt; color:=
 rgb(32, 33, 34); background-color: white;">NIP 957-07-52-316</span></p>
<p>&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Shay Drori &lt;shayd@=
nvidia.com&gt;<br>
<b>Sent:</b> Sunday, May 26, 2024 2:35 PM<br>
<b>To:</b> Berger, Michal &lt;michal.berger@intel.com&gt;; netdev@vger.kern=
el.org &lt;netdev@vger.kernel.org&gt;; moshe@nvidia.com &lt;moshe@nvidia.co=
m&gt;<br>
<b>Subject:</b> Re: Kernel panic triggered while removing mlx5_core devices=
 from the pci bus</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Michal.<br>
<br>
can you please try the bellow change[1]?<br>
we try it locally and it seems to solve the issue.<br>
<br>
thanks<br>
Shay Drory<br>
<br>
[1]<br>
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c <br>
b/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
index 6574c145dc1e..459a836a5d9c 100644<br>
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c<br>
@@ -1298,6 +1298,9 @@ static int mlx5_function_teardown(struct <br>
mlx5_core_dev *dev, bool boot)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!err)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mlx5_function_disable(dev, boot);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mlx5_stop_health_poll(dev, boot);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return err;<br>
}<br>
<br>
<br>
<br>
On 24/05/2024 11:07, Berger, Michal wrote:<br>
&gt; Kernel: 6.7.0, 6.8.8 (fedora builds)<br>
&gt; Devices: MT27710 Family [ConnectX-4 Lx] (0x1015), fw_ver: 14.23.1020<b=
r>
&gt; rdma-core: 44.0<br>
&gt; <br>
&gt; We have a small test which performs a somewhat controlled hotplug of t=
he net device on the pci bus (via sysfs). The affected device is part of th=
e nvmf-rdma setup running in SPDK context (i.e.&nbsp;<a href=3D"https://git=
hub.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh)">https://=
github.com/spdk/spdk/blob/master/test/nvmf/target/device_removal.sh)</a>&nb=
sp;&nbsp;Sometimes
 (it's not reproducible at each run unfortunately) when the device is remov=
ed, kernel hits<br>
&gt; Oops - with our panic setup it's then followed by a kernel reboot, but=
 if we allow the kernel to continue it eventually deadlocks itself.<br>
&gt; <br>
&gt; This happens across different systems using the same set of NICs. Exam=
ple of these oops attached.<br>
&gt; <br>
&gt; Just to note, we previously had the same issue under older kernels (e.=
g. 6.1), all reported here
<a href=3D"https://bugzilla.kernel.org/show_bug.cgi?id=3D218288">https://bu=
gzilla.kernel.org/show_bug.cgi?id=3D218288</a>. Bump to 6.7.0 helped to red=
uce the frequency<br>
&gt; of this issue but unfortunately it's still there.<br>
&gt; <br>
&gt; Any hints on how to tackle this issue would be appreciated.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Michal<br>
&gt; ---------------------------------------------------------------------<=
br>
&gt; Intel Technology Poland sp. z o.o.<br>
&gt; ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII=
 Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-=
52-316 | Kapital zakladowy 200.000 PLN.<br>
&gt; Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu=
 ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w =
transakcjach handlowych.<br>
&gt; <br>
&gt; Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adr=
esata i moze zawierac informacje poufne. W razie przypadkowego otrzymania t=
ej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; j=
akiekolwiek przegladanie lub rozpowszechnianie
 jest zabronione.<br>
&gt; This e-mail and any attachments may contain confidential material for =
the sole use of the intended recipient(s). If you are not the intended reci=
pient, please contact the sender and delete all copies; any review or distr=
ibution by others is strictly prohibited.<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_--

--_004_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_
Content-Type: application/octet-stream; name="oops.log"
Content-Description: oops.log
Content-Disposition: attachment; filename="oops.log"; size=5787;
	creation-date="Tue, 28 May 2024 06:16:57 GMT";
	modification-date="Tue, 28 May 2024 06:17:06 GMT"
Content-Transfer-Encoding: base64

WyAxMzIyLjgxMzU0NF0gbWx4NV9jb3JlIDAwMDA6ODI6MDAuMTogZmlybXdhcmUgdmVyc2lvbjog
MTQuMjMuMTAyMApbIDEzMjIuODIwNjcxXSBtbHg1X2NvcmUgMDAwMDo4MjowMC4xOiA2My4wMDgg
R2IvcyBhdmFpbGFibGUgUENJZSBiYW5kd2lkdGggKDguMCBHVC9zIFBDSWUgeDggbGluaykKWyAx
MzIzLjMxNzk2NV0gbWx4NV9jb3JlIDAwMDA6ODI6MDAuMTogRS1Td2l0Y2g6IFRvdGFsIHZwb3J0
cyAxMCwgcGVyIHZwb3J0OiBtYXggdWMoMTAyNCkgbWF4IG1jKDE2Mzg0KQpbIDEzMjMuMzU1NDIy
XSBtbHg1X2NvcmUgMDAwMDo4MjowMC4xOiBQb3J0IG1vZHVsZSBldmVudDogbW9kdWxlIDEsIENh
YmxlIHVucGx1Z2dlZApbIDEzMjMuNTkyMDkyXSBtbHg1X2NvcmUgMDAwMDo4MjowMC4xOiBNTFg1
RTogU3RyZFJxKDApIFJxU3ooMTAyNCkgU3RyZFN6KDI1NikgUnhDcWVDbXByc3MoMCBiYXNpYykK
WyAxMzIzLjYwNTg5OV0gbWx4NV9jb3JlIDAwMDA6ODI6MDAuMSBtbHhfMF8xOiByZW5hbWVkIGZy
b20gZXRoOApbIDEzMjMuOTU0MjUzXSBtbHg1X2NvcmUgMDAwMDo4MjowMC4xIG1seF8wXzE6IExp
bmsgZG93bgpbIDEzMjQuMDEwNjMwXSBtbHg1X2NvcmUgMDAwMDo4MjowMC4xOiBpc19kcGxsX3N1
cHBvcnRlZDoyMTM6KHBpZCA2MzQxOSk6IE1pc3NpbmcgU3luY0UgY2FwYWJpbGl0eQpbIDE0MDcu
MjMxNDQzXSBtbHg1X2NvcmUgMDAwMDo4MjowMC4wOiBFLVN3aXRjaDogVW5sb2FkIHZmczogbW9k
ZShMRUdBQ1kpLCBudmZzKDApLCBuZWN2ZnMoMCksIGFjdGl2ZSB2cG9ydHMoMCkKWyAxNDA3LjI2
MTE4OV0gbWx4NV9jb3JlIDAwMDA6ODI6MDAuMDogRS1Td2l0Y2g6IERpc2FibGU6IG1vZGUoTEVH
QUNZKSwgbnZmcygwKSwgbmVjdmZzKDApLCBhY3RpdmUgdnBvcnRzKDApClsgMTQwNy4yOTQ3Mjld
IEJVRzogdW5hYmxlIHRvIGhhbmRsZSBwYWdlIGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmZmZmZmI0
ZTIwNjAwClsgMTQwNy4zMDI3ODhdICNQRjogc3VwZXJ2aXNvciB3cml0ZSBhY2Nlc3MgaW4ga2Vy
bmVsIG1vZGUKWyAxNDA3LjMwODk4MV0gI1BGOiBlcnJvcl9jb2RlKDB4MDAwMikgLSBub3QtcHJl
c2VudCBwYWdlClsgMTQwNy4zMTUwNzNdIFBHRCA0MzM0MmQwNjcgUDREIDQzMzQyZDA2NyBQVUQg
NDMzNDJlMDYzIFBNRCA4MDBmZmZmYmNjMWZmMDYyClsgMTQwNy4zMjMyMTBdIE9vcHM6IDAwMDIg
WyMxXSBQUkVFTVBUIFNNUCBQVEkKWyAxNDA3LjMyODI0MV0gQ1BVOiAxNCBQSUQ6IDY2MjI3IENv
bW06IGt3b3JrZXIvdTg1OjIgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAgICA2LjguOS0yMDAu
ZmMzOS54ODZfNjQgIzEKWyAxNDA3LjMzOTE5OV0gSGFyZHdhcmUgbmFtZTogSW50ZWwgQ29ycG9y
YXRpb24gUzI2MDBHWi9TMjYwMEdaLCBCSU9TIFNFNUM2MDAuODZCLjAyLjA2LjAwMDYuMDMyNDIw
MTcwOTUwIDAzLzI0LzIwMTcKWyAxNDA3LjM1MTAzMF0gV29ya3F1ZXVlOiBpYi1jb21wLXVuYi13
cSBpYl9jcV9wb2xsX3dvcmsgW2liX2NvcmVdClsgMTQwNy4zNTgwNzVdIFJJUDogMDAxMDpuYXRp
dmVfcXVldWVkX3NwaW5fbG9ja19zbG93cGF0aCsweDI3Zi8weDJkMApbIDE0MDcuMzY1MzU2XSBD
b2RlOiA0MSA4OSBkNiA0NCAwZiBiNyBlOCA0MSA4MyBlZSAwMSA0OSBjMSBlNSAwNSA0ZCA2MyBm
NiA0OSA4MSBjNSAwMCA1NiAwMyAwMCA0OSA4MSBmZSAwMCAyMCAwMCAwMCA3MyA0NSA0ZSAwMyAy
YyBmNSBhMCAzYyBjMCBiMyA8NDk+IDg5IDZkIDAwIDhiIDQ1IDA4IDg1IGMwIDc1IDA5IGYzIDkw
IDhiIDQ1IDA4IDg1IGMwIDc0IGY3IDQ4IDhiClsgMTQwNy4zODcwOTZdIFJTUDogMDAxODpmZmZm
YTczOWNlMWFmZDQ4IEVGTEFHUzogMDAwMTAwODYKWyAxNDA3LjM5MzMxOF0gUkFYOiAwMDAwMDAw
MDAwMDAwMDAwIFJCWDogZmZmZjkwZTJjMzgxYmEwMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMTAKWyAx
NDA3LjQwMTY3Nl0gUkRYOiAwMDAwMDAwMDAwMDAxZmZmIFJTSTogMDAwMDAwMDA3ZmZjMThkMiBS
REk6IGZmZmY5MGUyYzM4MWJhMDAKWyAxNDA3LjQxMDAyNl0gUkJQOiBmZmZmOTBlYWJiZTM1NjAw
IFIwODogMmM2ZjZjNmU2MjJjNjE2OCBSMDk6IGZmZmY5MGUyZjQ1YTgyMDAKWyAxNDA3LjQxODM4
Ml0gUjEwOiAwMDAwMDAwMDAwMDAwMDBmIFIxMTogZmVmZWZlZmVmZWZlZmVmZiBSMTI6IDAwMDAw
MDAwMDAzYzAwMDAKWyAxNDA3LjQyNjcyMV0gUjEzOiBmZmZmZmZmZmI0ZTIwNjAwIFIxNDogMDAw
MDAwMDAwMDAwMWZmZSBSMTU6IDAwMDAwMDAwMDAwMDAwMTAKWyAxNDA3LjQzNTA2OF0gRlM6ICAw
MDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY5MGVhYmJlMDAwMDAoMDAwMCkga25sR1M6MDAw
MDAwMDAwMDAwMDAwMApbIDE0MDcuNDQ0NDk1XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAg
Q1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgMTQwNy40NTEyOTZdIENSMjogZmZmZmZmZmZiNGUyMDYw
MCBDUjM6IDAwMDAwMDA0MzM0MjgwMDEgQ1I0OiAwMDAwMDAwMDAwMTcwNmYwClsgMTQwNy40NTk2
NTRdIENhbGwgVHJhY2U6ClsgMTQwNy40NjI3NjZdICA8VEFTSz4KWyAxNDA3LjQ2NTQ5M10gID8g
X19kaWUrMHgyMy8weDcwClsgMTQwNy40NjkyODZdICA/IHBhZ2VfZmF1bHRfb29wcysweDE3MS8w
eDRmMApbIDE0MDcuNDc0MjQxXSAgPyBleGNfcGFnZV9mYXVsdCsweDE3NS8weDE4MApbIDE0MDcu
NDc5MDk1XSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyNi8weDMwClsgMTQwNy40ODQxNDVdICA/
IG5hdGl2ZV9xdWV1ZWRfc3Bpbl9sb2NrX3Nsb3dwYXRoKzB4MjdmLzB4MmQwClsgMTQwNy40OTA3
NDNdICBfcmF3X3NwaW5fbG9ja19pcnFzYXZlKzB4M2QvMHg1MApbIDE0MDcuNDk1OTgxXSAgbWx4
NV9pYl9wb2xsX2NxKzB4NTAvMHhlMjAgW21seDVfaWJdClsgMTQwNy41MDE2MzhdICA/IGZpbmlz
aF90YXNrX3N3aXRjaC5pc3JhLjArMHg5NC8weDJmMApbIDE0MDcuNTA3NDU0XSAgX19pYl9wcm9j
ZXNzX2NxKzB4NGYvMHgxODAgW2liX2NvcmVdClsgMTQwNy41MTMxMjNdICBpYl9jcV9wb2xsX3dv
cmsrMHgyYS8weDgwIFtpYl9jb3JlXQpbIDE0MDcuNTE4NjcxXSAgcHJvY2Vzc19vbmVfd29yaysw
eDE3Ni8weDM0MApbIDE0MDcuNTIzNTE2XSAgd29ya2VyX3RocmVhZCsweDI3Yi8weDNhMApbIDE0
MDcuNTI4MDYwXSAgPyBfX3BmeF93b3JrZXJfdGhyZWFkKzB4MTAvMHgxMApbIDE0MDcuNTMzMTg0
XSAga3RocmVhZCsweGU4LzB4MTIwClsgMTQwNy41MzcwNDNdICA/IF9fcGZ4X2t0aHJlYWQrMHgx
MC8weDEwClsgMTQwNy41NDE1NzZdICByZXRfZnJvbV9mb3JrKzB4MzQvMHg1MApbIDE0MDcuNTQ1
OTEyXSAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMApbIDE0MDcuNTUwNDMzXSAgcmV0X2Zyb21f
Zm9ya19hc20rMHgxYi8weDMwClsgMTQwNy41NTUxNDddICA8L1RBU0s+ClsgMTQwNy41NTc5MTFd
IE1vZHVsZXMgbGlua2VkIGluOiBudm1lX3JkbWEgbnZtZV9mYWJyaWNzIHZmaW9fcGNpIHZmaW9f
cGNpX2NvcmUgdmZpb19pb21tdV90eXBlMSB2ZmlvIGlvbW11ZmQgcmRtYV91Y20gcmRtYV9jbSBp
d19jbSBpYl91bWFkIGliX2NtIHVzZG1fZHJ2KE9FKSBpbnRlbF9xYXQoT0UpIHJma2lsbCB1aW8g
c3VucnBjIGJpbmZtdF9taXNjIG1seDVfaWIgaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21t
b24gc2JfZWRhYyB4ODZfcGtnX3RlbXBfdGhlcm1hbCBpbnRlbF9wb3dlcmNsYW1wIGNvcmV0ZW1w
IGt2bV9pbnRlbCBrdm0gaTQwZSBpcnFieXBhc3MgY3JjdDEwZGlmX3BjbG11bCBjcmMzMl9wY2xt
dWwgY3JjMzJjX2ludGVsIHBvbHl2YWxfY2xtdWxuaSBwb2x5dmFsX2dlbmVyaWMgZ2hhc2hfY2xt
dWxuaV9pbnRlbCBpYl91dmVyYnMgc2hhNTEyX3Nzc2UzIG1hY3NlYyBzaGEyNTZfc3NzZTMgc2hh
MV9zc3NlMyBpVENPX3dkdCBpbnRlbF9wbWNfYnh0IGlUQ09fdmVuZG9yX3N1cHBvcnQgcmFwbCBt
ZWlfbWUgaW50ZWxfY3N0YXRlIHBrdGNkdmQgaXBtaV9zaSBpcG1pX2RldmludGYgaWJfY29yZSBp
bnRlbF91bmNvcmUgaXBtaV9tc2doYW5kbGVyIHBjc3BrciBkYXhfcG1lbSBtZWkgbGlic2FzIG1n
YWcyMDAgaW9hdGRtYSBscGNfaWNoIGpveWRldiBpMmNfaTgwMSBzY3NpX3RyYW5zcG9ydF9zYXMg
aTJjX3NtYnVzIHdtaSBpcDZfdGFibGVzIGlwX3RhYmxlcyBmdXNlIHpyYW0gYnBmX3ByZWxvYWQg
bG9vcCBvdmVybGF5IHNxdWFzaGZzIG5ldGNvbnNvbGUgbmRfcG1lbSBuZF9idHQgbmRfZTgyMCBs
aWJudmRpbW0gdmlydGlvX2JsayB2aXJ0aW9fbmV0IG5ldF9mYWlsb3ZlciBmYWlsb3ZlciB1YXMg
dXNiX3N0b3JhZ2UgbnZtZSBudm1lX2NvcmUgbnZtZV9hdXRoIG1seDVfY29yZSBtbHhmdyBwc2Ft
cGxlIHRscyBwY2lfaHlwZXJ2X2ludGYgaWNlKE9FKSBnbnNzIGl4Z2JlIG1kaW8gaWdiIGkyY19h
bGdvX2JpdCBkY2EgW2xhc3QgdW5sb2FkZWQ6IG52bWVfZmFicmljc10KWyAxNDA3LjY2MDQxN10g
Q1IyOiBmZmZmZmZmZmI0ZTIwNjAwClsgMTQwNy42NjQ1MDJdIC0tLVsgZW5kIHRyYWNlIDAwMDAw
MDAwMDAwMDAwMDAgXS0tLQpbIDE0MDcuNzQyODQ1XSBSSVA6IDAwMTA6bmF0aXZlX3F1ZXVlZF9z
cGluX2xvY2tfc2xvd3BhdGgrMHgyN2YvMHgyZDAKWyAxNDA3Ljc1MDEzNl0gQ29kZTogNDEgODkg
ZDYgNDQgMGYgYjcgZTggNDEgODMgZWUgMDEgNDkgYzEgZTUgMDUgNGQgNjMgZjYgNDkgODEgYzUg
MDAgNTYgMDMgMDAgNDkgODEgZmUgMDAgMjAgMDAgMDAgNzMgNDUgNGUgMDMgMmMgZjUgYTAgM2Mg
YzAgYjMgPDQ5PiA4OSA2ZCAwMCA4YiA0NSAwOCA4NSBjMCA3NSAwOSBmMyA5MCA4YiA0NSAwOCA4
NSBjMCA3NCBmNyA0OCA4YgpbIDE0MDcuNzcxODgxXSBSU1A6IDAwMTg6ZmZmZmE3MzljZTFhZmQ0
OCBFRkxBR1M6IDAwMDEwMDg2ClsgMTQwNy43NzgxMDRdIFJBWDogMDAwMDAwMDAwMDAwMDAwMCBS
Qlg6IGZmZmY5MGUyYzM4MWJhMDAgUkNYOiAwMDAwMDAwMDAwMDAwMDEwClsgMTQwNy43ODY0NjBd
IFJEWDogMDAwMDAwMDAwMDAwMWZmZiBSU0k6IDAwMDAwMDAwN2ZmYzE4ZDIgUkRJOiBmZmZmOTBl
MmMzODFiYTAwClsgMTQwNy43OTQ4MDldIFJCUDogZmZmZjkwZWFiYmUzNTYwMCBSMDg6IDJjNmY2
YzZlNjIyYzYxNjggUjA5OiBmZmZmOTBlMmY0NWE4MjAwClsgMTQwNy44MDMxNDddIFIxMDogMDAw
MDAwMDAwMDAwMDAwZiBSMTE6IGZlZmVmZWZlZmVmZWZlZmYgUjEyOiAwMDAwMDAwMDAwM2MwMDAw
ClsgMTQwNy44MTE0ODNdIFIxMzogZmZmZmZmZmZiNGUyMDYwMCBSMTQ6IDAwMDAwMDAwMDAwMDFm
ZmUgUjE1OiAwMDAwMDAwMDAwMDAwMDEwClsgMTQwNy44MTk4MTldIEZTOiAgMDAwMDAwMDAwMDAw
MDAwMCgwMDAwKSBHUzpmZmZmOTBlYWJiZTAwMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAw
MDAKWyAxNDA3LjgyOTIyNl0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAw
MDA4MDA1MDAzMwpbIDE0MDcuODM2MDEzXSBDUjI6IGZmZmZmZmZmYjRlMjA2MDAgQ1IzOiAwMDAw
MDAwNDMzNDI4MDAxIENSNDogMDAwMDAwMDAwMDE3MDZmMApbIDE0MDcuODQ0MzU0XSBLZXJuZWwg
cGFuaWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uClsgMTQwNy44NTA2MTBdIEtlcm5l
bCBPZmZzZXQ6IDB4MzEwMDAwMDAgZnJvbSAweGZmZmZmZmZmODEwMDAwMDAgKHJlbG9jYXRpb24g
cmFuZ2U6IDB4ZmZmZmZmZmY4MDAwMDAwMC0weGZmZmZmZmZmYmZmZmZmZmYpClsgMTQwNy45MDcy
OTFdIHBzdG9yZTogYmFja2VuZCAoZXJzdCkgd3JpdGluZyBlcnJvciAoLTI4KQpbIDE0MDcuOTEz
NDEzXSBSZWJvb3RpbmcgaW4gNSBzZWNvbmRzLi4K

--_004_PH0PR11MB515990257791E24CF6E0E51CE6F12PH0PR11MB5159namp_--

