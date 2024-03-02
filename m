Return-Path: <netdev+bounces-76782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F586EEA4
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 05:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EC13B20CCC
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 04:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B56FC3;
	Sat,  2 Mar 2024 04:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZE8+3Gml"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0563CB
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709354355; cv=fail; b=u26wqVLOcHTawoYm+wVuNcg4sxR9+hoEN2NdokD8un3h8tjBIsXKSizwPIgpoyEanWtp7eoqmS6OugoU6lRofkphB1/Ylf0XkklLkoWTmyk6RwMR6JECI7gfsNDSiFkCP2WNm9fiDGGNcIS/ccDE1ew8dtEsXdB+v7R5/R8sV6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709354355; c=relaxed/simple;
	bh=4NSG+3pCsW838Jnaa+2pAX4GkycQ4PcaWWB4e/lO45g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bcUwso057v4bEdYHnEhFOH4+5UvbjaIO+L9aSMnaiWANCIGF3zDJMyj2U0xHR1wkXXDyWilvbY02cooP2UnmAxw9llyqowczYLeHdx3Ekaa0OVcVJmOrhcGHar7VXs5f/htbWZZ5rJ/uzxgtsEwuGmMt5JG6ZM7qGX43m3ZaEQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZE8+3Gml; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709354354; x=1740890354;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4NSG+3pCsW838Jnaa+2pAX4GkycQ4PcaWWB4e/lO45g=;
  b=ZE8+3Gmlzgn7gpXYbY9PMnnsbemfw1zor5Ffpolr/xHIqJ6k/ilsbmqQ
   ONNchnPavxkdKKWLqng+DUTivF1P2ogcDvPikIMBI07l64OCgJXCEmI//
   oAKGqPYjHUvJA27NTBIvt+IINR+E4Lq9gBWmIX4NYINNOz6a0qpVRLviV
   2vla8jnufi6noNGAz4r8WZh62IOzJUsApoLJxqCT8zhYLT4tCEQCU7hKg
   +A6D/HyDhusVCYKIedziq2eKceNcuuH0OKQo3rcAZ7NL9/8siqeO+y/ze
   bBKr0DqusEXWrHjTXIO8fCE5gqNnqTREGx/37StrMcrVBlctk7Mev65Xc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3834324"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="3834324"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 20:39:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8343336"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 20:39:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 20:39:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 20:39:12 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 20:39:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg28wVUyy8t/Bxmp2YT0JO87aMMLAhBUHYZdJIWLShUtFkex6aULhxmG/9ikaOzMLH3Nc4fP1ZipXFwvNC/5n2mNcDdseQ1AiBahOZytlRTt29Qs5wNmManrtGM4Kr8/sd63b156zCNL1ql/aToXydj/XHJ0XK82pjP/0kNI9rSK991Z7sIm+rPgvXjjPI3wZ2HzisDxQ0IZe8hippjKZCK3eBrGDAraauzkQN4i+yAk4TPVS0cF83e8Mz5HP76hXSYJtjdI0DH2EsrqPKey/3jCwpnd2eIsBpYET6VdKQQJ79zVdREdtH6GYcztpSRsxxBGtswRYtjEU6trD7bgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=betsUej6YFzMqZLbtb8K9IMGlpciiQmyrgaaPlmHVFw=;
 b=WR19JNhoy5NcT+7aWOJ2yrdZjrlFfG2b1rtQWoCx8ZdUIb14g/zwODT4CzG5blr2C0MJWWA89U9MZmSwWT68X9jgdtk8w3lUuTY5S2mIs/JoBdfUC4kRzGjlSeR4/XYLgcoaUgJkBDdicZDP/jeeyfbRSU157ywy29wwDAMNOI935TPAr1KmVw65ZTPv+YmNi7JuoA30w7uO1MmoalzvfmATBMeIPvalB3w8P0Lby908jLms5iGjDAaF2oo2u/GeeY1e8b8MTd2EMMUFMV3GyaCrSook4Fr3JO+DBsc0lptt2HPAfhoBRyTWdcpqREvNSsZGnoLDqiUDRkAyYz4Q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Sat, 2 Mar
 2024 04:39:10 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::6446:3cb8:5fd5:c636%3]) with mapi id 15.20.7362.017; Sat, 2 Mar 2024
 04:39:09 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Brady, Alan" <alan.brady@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Brady, Alan"
	<alan.brady@intel.com>, "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "Bagnucki, Igor"
	<igor.bagnucki@intel.com>
Subject: RE: [PATCH v6 08/11 iwl-next] idpf: cleanup virtchnl cruft
Thread-Topic: [PATCH v6 08/11 iwl-next] idpf: cleanup virtchnl cruft
Thread-Index: AQHaZcI7LJ/GSm6EEEeA9/UYETGK5LEj63yQ
Date: Sat, 2 Mar 2024 04:39:09 +0000
Message-ID: <MW4PR11MB5911DAE5B0769ACCB381F0C5BA5D2@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20240222190441.2610930-1-alan.brady@intel.com>
 <20240222190441.2610930-9-alan.brady@intel.com>
In-Reply-To: <20240222190441.2610930-9-alan.brady@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 314aa334-8c3b-4ff3-8a26-08dc3a72b3f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UXF6lSjIiHpOMirmxcRVDTCtTXjMzLzwL2s54q63HxGmi5amqukeqBxbvECPnbRNYXZ0TfbRiif89rlHsZr5f11ItgbGpo3pytQn5pSUT5w8/5aymziSoo0u5mumroCAy1sOm0kJB8uc6QAT4zolnH5/p/6RexC4mwYkoI1BpMUtGztM62LnJydb5yYl7UTvoeAepDI0yZJrv++rrFUSsbHVAsiXOxWhlO4XctrFahl5NU2jDee1b52/kd6tLz4U3AbA/d866/S0Fr0ueRbvmBCZxzAUaf6EhkK+sCntTNwRqVRH8XK2AlezFdM/aDOQYt39VtR2hcTl7IOMcTYkUsI7E696Ycj43lUcPVwJAnYac3+5Yrx8C8MCwRSc/zsVQh5LYZBlikSHWYDiyWMsQeLlrpj0kl6g/2G2F8znD0M4+P5XkoT/rGTu6aXJXxZf9C0hDWY8tMUMVz5wtwFCYXJoaR9CUHN55s3WdoY8B7jMcWinjQaUlHn7CbGXisklbYRxUsUpTt7pgMFKNMnUt7RtNsO/8vJniiH0KgKKM8fBc+c4p1+v/+D6MTSP3JTIo4CUFINa5mAFQCOU+WRuAPFvUArU6xP0uQFtX5ySuAWjf8gQJAdKS/SoX4TwmtUqlOD5X7oTss61vykP8urQc0ZVV3D0NHezalTK+Fn1zUHtL4rbZ9/MUAOG7G3Bd5IgUIF3cH5P/oB7hHuFOvnyd58KdyuWfNtAuGqK2eo6Bo4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q4ySVgQJEdndt0XVtbG5wgqV87T6MYzwq2950pJYmGoLySbQkLGxYq59hpBS?=
 =?us-ascii?Q?HSn82L9D7tdmRn05jX5BpGo9Fo+OYf4j5EIN+W4gLEhVgZqGeYkWcO1swto4?=
 =?us-ascii?Q?ohUU4TJg06RMwiC3u04tVusRLCoeu+BjAz1kvV3HhGrIpc3vSLcJx/WtcesI?=
 =?us-ascii?Q?tzwoMHBGmKsZL7wqjlOdTLwgTPUg0P64+54z+Kr96XXPiM9Rm56Cn+AvufVo?=
 =?us-ascii?Q?4lEncCoSXJJaxcorWGrhuaCSs8H1SG3HxbiZi3ZtGlN+JbS2YTVjhgr2PovX?=
 =?us-ascii?Q?/FvV53JdrmlX7v+KTDD4dIu7APqe1Rz9z7dpZ7W7yU6FYNk/IlJKaEPIQ3h+?=
 =?us-ascii?Q?qpIntwdUqj+5NyINMxOHAPOmVAIe8v/n5gRhbURBrMhu1vgiK4+avyTi7ghO?=
 =?us-ascii?Q?Za3AN/r1WEffL39QQ0SZSqbJYOq6D5XmYKu7gC5EMg45rjGJ+gn0VqiIH0xM?=
 =?us-ascii?Q?wGgYP+H53m6/nZ4me67GFQ4ki7K7rkyWiZJcn0YUNgnFhjHJe3hq50pu8xUu?=
 =?us-ascii?Q?pFuP7lYVjLjOWMYt9Lfg/aGWjZv3PefUAUQNpA4jN9GkBkR1MFDFBZGwy0Nq?=
 =?us-ascii?Q?iVGDKHKTLRpoc4OhPih+7bSeONbcKyqp1TleNgGfXznb4H35baDhJ5qcC9kS?=
 =?us-ascii?Q?SsBH82b1DyhRK8RsxwN1gTNMlN0bPe8QfY1Rvsngyvx7pbwfFAm0/pAMbkRE?=
 =?us-ascii?Q?ukzrhpl45r7jT64dFlNq3BuNqkHkHxHAV7gKqa9NKhokKcPKeFPsjg5esLN4?=
 =?us-ascii?Q?+UFXpwrtaCWxxPcjkJ+4JEXMuhcV8Pt0q50yiDlcTBvFFhSB9faByCFh0dKO?=
 =?us-ascii?Q?/qEI/88Bn3eTP/Cgx/1TZ4AvCuOLKvYW8U/pRc3VQq2uMewJii3AkiOMyEvs?=
 =?us-ascii?Q?JetoDuQyhH8n4s3vTgc89RHc+VyY9sszAU0JHQT4J/XXFBbtXI8Mg25w3mh0?=
 =?us-ascii?Q?/WLbZ2WcEiPPucTqbWWL0qkVt2W1TWBnZ7byXq/e8NFXjjY0RxhF1R82DhMH?=
 =?us-ascii?Q?/9AdVGByh6G4iAlgBnvZx+paiBfkRAk890nXralmgUkph1/KJk9UqA1/rb1S?=
 =?us-ascii?Q?mlF+ZPuNTNwgiByzauVywAQHLmlbZHNEUjwLwOISQpVcx0zG4BBJnomPHXjX?=
 =?us-ascii?Q?0/HPEs2HCu2ebl7eRHwP6qvvDPE+9tktwqPXIloM9D/c0opcSuKmJ2ObU9I3?=
 =?us-ascii?Q?uMAv+o4hieEnXgkWxWpd8IbsKECjvKX4hoyjS9Uy0vmBSW7fe0gwCgwkqX8n?=
 =?us-ascii?Q?kK2NvrKjZOJv3zoV7Z300PyO3rOED6VP+7/mvtc8oM6cX3UsPv2XJjAtXI0f?=
 =?us-ascii?Q?wi1p8H3QkUJG2/cbDlMiYaVNhzlErvnvatnkRYAMX5QXqsHxbryZtUDbrEas?=
 =?us-ascii?Q?dxqb0xiD5ppk1yU33VSilB+1zFO7YPW9DAtVxxzpg7iC6mJ2hlB+tgSpRfqN?=
 =?us-ascii?Q?WDsG2gqwt/H1GCRtbQZ+ZDVMU/T5OQ4gsC/4eFneuC7ztjgiSzmnxI7OicrW?=
 =?us-ascii?Q?QACLzDZiIfNYb0TPhENKJN0h4fjCl7+pASxFI4s5GW4Sii1nhKY6Ww7szN0u?=
 =?us-ascii?Q?tmwWiveo4VpBZjKkDRjrdpF8eiksBTjRPgWjdZmNeeyZkwn8k6LgLXH0fI4S?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5911.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314aa334-8c3b-4ff3-8a26-08dc3a72b3f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2024 04:39:09.9109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thRA4gwdkuFab6ZXVqWrUEfN4gc6jnuUbVipsNYQ9v0lPz4I0lfDPxhmlJkIzcVEb//POxbvY3piL31hoNWMm51DBC4guCmFpBCd4sj1X7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Alan Brady <alan.brady@intel.com>
> Sent: Thursday, February 22, 2024 11:05 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Brady, Alan <alan.brady@intel.com>; Lobakin,
> Aleksander <aleksander.lobakin@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Bagnucki, Igor <igor.bagnucki@intel.com>
> Subject: [PATCH v6 08/11 iwl-next] idpf: cleanup virtchnl cruft
>=20
> We can now remove a bunch of gross code we don't need anymore like the
> vc state bits and vc_buf_lock since everything is using transaction API
> now.
>=20
> Tested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h        | 88 +------------------
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    | 25 +-----
>  drivers/net/ethernet/intel/idpf/idpf_main.c   |  2 -
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 13 ---
>  4 files changed, 3 insertions(+), 125 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

