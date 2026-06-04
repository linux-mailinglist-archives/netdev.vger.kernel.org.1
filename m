Return-Path: <netdev+bounces-295063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id akjIAJoiIWoF/gAAu9opvQ
	(envelope-from <netdev+bounces-295063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:00:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 496FE63D714
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 09:00:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Qcdwh2ke;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295063-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F7730837C8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82153DA5B5;
	Thu,  4 Jun 2026 06:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF37F3D902B;
	Thu,  4 Jun 2026 06:51:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555897; cv=fail; b=WRp7m2bTEoUU8JKzbJdLNQlG8droCZ26d3V+VSowiEa8z/Vr5lKs89mT2KhW0vt3fNwFHeQlAMUyD0kxn62zLbLNMnt92w+iDCyBJoxLTQA0A3FrrTuOXj5jmEEJpQ5p5dyPaPeVlcRFJKHTkP0F0VVaCrns427RqBmvP7QpX98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555897; c=relaxed/simple;
	bh=HehsGbXtEYJvabybi2VYLTpICT8kyZDWU36Q39vpAGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sE5Ul12XrrkcoHVhSe5e3nlbQzlANvVf7X0rSqePLo3mxOL510XhLs7lhWprQm4mQF6ptcMHtGX2d21w039RgOwjUTjB20nnsVoQK99HdZkZbk+4YxjKsEvXLPTt3eu61AZWwwxLKnrXY9L5HvD5ePyAfHdJcqmu+ZbQHmoUtB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qcdwh2ke; arc=fail smtp.client-ip=198.175.65.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555896; x=1812091896;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HehsGbXtEYJvabybi2VYLTpICT8kyZDWU36Q39vpAGY=;
  b=Qcdwh2kevxSNfCJ30jefeiPZRl3FTkKt4Hq6CulOrmkolLJfUYMU9dYz
   dZcnLRRJD860CShgaaSClm5blIiSDlxGFv3l5EBaERTUbdOF30Mq2RyIV
   K80aAiu4RCctb01rQbuk8V/yK450mayjMSWJ9Amx/0dN6apG1sAf58AHn
   le7BSKNgx20ntFzCINptfKXEXW9qI6h9NeDFbwn/dROZk9WmodehzVayy
   /bwXH+/bru8tpq/BkBz6PzKtwMrcxr/j8y6ensDNH4muP0s/B7x5nvAvI
   zqAD6zasXTRACGHtcp7mS6OvcHw2g8qIB3Ffld79lzFp++JNiySC9c1Yy
   Q==;
X-CSE-ConnectionGUID: p9VyxsqNSDe+6s4VL7ZeDA==
X-CSE-MsgGUID: 1kcsHCilTDKvQRKw5Uc15Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="92485680"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="92485680"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:51:33 -0700
X-CSE-ConnectionGUID: tGNxb03gThWeoJufne8vSA==
X-CSE-MsgGUID: HRWlqbxQQYy+RGGWnT0xzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241493860"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:51:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 23:51:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 23:51:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 23:51:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5y7ZvpL9lNBJhyrUyg8gsajCRtGPb2AQAqkKAdruKzBSVncS4R7jttaEg4XOm6Eoa8E53W9a/RAKFHoxAxTdzq7Qtqf6EPX9qxkBGUsmQj4CKdvy7LaKkMRtqsTAmGlLBDD4F64hpv1O+4lOPipFledaTsuWMoZ/79ewnEpFcRgRUhgduZ3wE0dOIbtvU9w9JycufLAvLHbrZ3a1qH2TT43RtPoBTWpXO12vigOhrY03FJuLdJIt5QQKmlLZjvYILBTZBnzv1DEU3BM0pZ9mvwkEULgOX9qVAYTk7+fbnLBOBLS8U7sXZYEkhGTgZ6EIrxLUIwoT8FQ0KWS0ZsqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx8gtIFNL6SLFadGz1RqGIIHhM2K/xAFm1BDJddxn34=;
 b=r5Zb1N67+E9AGD0Ngj4goLGfQxIf37u+QxFGNM6PMTJkccyZmRoTZLP6wm+LsjXafW+3dAFIXjAG2AyjrxbMVH0pR44+86JQkcYYHkxfWnx21/qvirSj6/KND/1OuKH/Mr3Tf6Ey+xz0N5a7f+AiQZA+RX3+UCOIGfIKrUSo4U/TzKZO/wr0yU3uKG5fEGVjtdqSoOPq+VX8po/ZkAPrpZqfc3uMjN3dl/aR9L1+OMePOjjXsr1n0LjNobME/h3uGtXEJ93qVDVhf8yF+gJV5SZt4sUPMNrUL07lxhENtNP5ZYtfW+Osxle9OBk9Ej8OCZ2FdbnbTytr9ps9VgUTPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 06:51:01 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::4c62:9ba6:df27:c731]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::4c62:9ba6:df27:c731%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 06:51:01 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "stfomichev@gmail.com" <stfomichev@gmail.com>,
	"kernelxing@tencent.com" <kernelxing@tencent.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "Sarkar, Tirthendu"
	<tirthendu.sarkar@intel.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH net-next v2 2/4] selftests/xsk: Move UMEM state from
 ifobject to xsk_socket_info
Thread-Topic: [PATCH net-next v2 2/4] selftests/xsk: Move UMEM state from
 ifobject to xsk_socket_info
Thread-Index: AQHc8yT5YMn7s8mzgE2i9rgevUDMZbYs6sWAgAEKYJA=
Date: Thu, 4 Jun 2026 06:51:00 +0000
Message-ID: <IA1PR11MB6514BE32ED3444C8D4A4C3228F102@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20260603060327.298389-1-tushar.vyavahare@intel.com>
 <20260603060327.298389-3-tushar.vyavahare@intel.com> <aiA/j1EWpJgAGIwV@boxer>
In-Reply-To: <aiA/j1EWpJgAGIwV@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|PH7PR11MB8503:EE_
x-ms-office365-filtering-correlation-id: c917e0c9-8219-4ef8-123f-08dec205a3b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|17002099007|22082099003|18002099003|6133799003|3023799007|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: Qpai2Y8B1sHuXhWpi3cDfBgHEE3HCxMf0RnkcdHwMRh/BaZuNOcSd4++wVXBGkcpvxm8B/Wks2htFhuZ517cYuDbKyUxwNi9olEOmrBtNUdtggvd1A9cKDhJPb+fXUs5PMTSiW/yaJk5fUPQg0AamPAk5yXmJhTtONlsbv1DSupROvCs8XIPBumbT4zvpjzMiVCMembX5u9wdrtHoHKlD2O1gNh1yWUsfPZFhE47iKESwigVuxnOCScyN7WkWEDn/W6NedlFMInxadl6GSgDj++Uek+17tRMXup2zrcIoPabm5+qLxVhFSt1zNpj8tHWzszRc16VxKVaMzfOFFCA5Ua6GkDoN8jCdTQTnqho7GwLah9tlWEjwgIJIJnVUigaf+sh76ZFgzlFVvd3VHS9Q2l08qmQzpOdP+2MmADiYpE6tng/2D8VfXMST/z9+ep0v1MG09vAHIuJfM4x39QX8Ef2EMrK7HoB9VENi0cMrXnhGR65RIXYoWqVpB4pNyNDObS6t7MsZQXXxVs7CdK89OKd7pjBZd+Atlc8ylki/jd//gpxE+vQE1BRQA9INdAzjYnUfo3oLXhB4YEVhpUTuhai9YvrcYXM247dgna/h8cFXuDlB4BrJV70eH2a/lU5EMb2MXh03ym5nMJjsoSAnaJxfR2aIHws7S7a1Phc2aNnNxq0GrR3xhUt18sVIbloQUpMYf+6R+j2r6C/wIIOzjCNiycWx+LEPZA4k8T4mKsoBTT1UW/pQVlsZBEERItV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(17002099007)(22082099003)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wvNUKJjImc3XyONJL/95rPRdcQ/4CUsjH1jTKO6WcbhjTJbiEgznmhazU3Xn?=
 =?us-ascii?Q?BLhCCuxEb/KB9XdLtJgR3ifYzPxgoaBcOZNRcNuWuTTUzKPsx9mDbjQJ6KYY?=
 =?us-ascii?Q?7xunkeFPX0oAkN6jaeEiMOv+dggdQvAVCqvFZ1IQlvdDpx4OpcU9XBFqzoWa?=
 =?us-ascii?Q?KuyIFOn1FpGr9JIMA3a+4v3dzzGxzEEaRfV7J0RPFnTPBqGoNcI8YA3klnMx?=
 =?us-ascii?Q?vkJ3RbRUV8bZno2Q+j0YYTuGFZCFlPc92IbkiLL8sRfojA/zSsRxaR5VTy9P?=
 =?us-ascii?Q?Q8kxDPYl2Pm8yOO5M/ez8J+JOIDcKqYoFbPVqOQJ5R34xFsVDxNwPlMeL9Y7?=
 =?us-ascii?Q?CblpaxTp91ClE5VWZBXOVC33CeBobgRnNBcC/O0y+/bPdh5FRFnTGuhJotvt?=
 =?us-ascii?Q?GWNeSAqFQ8OUzrn+npLP6pe6BgPs3VE1Mv5RYXcnLquDrjYAlEpoAHz4bbG2?=
 =?us-ascii?Q?Ps/RLZJxWjjtrpCKa132lfplnVAKetg3FxIqj4cHZcHCAPNpyamCoRi8Y/oH?=
 =?us-ascii?Q?4gltOo0B3V6yDmyDfJBh527FMo9jMwkpomE3ZClwP50vPW08mCc76ZkDq81t?=
 =?us-ascii?Q?nqBHn/p1Kv/xyzrbD/rqcU5Qd/PIp6fWJNuO/CTbHtRwem7T+4gnq5XE/VmK?=
 =?us-ascii?Q?VubJHmV0y/HA1HP4PeZL6ey2HMq/a5c6bJ5aHmZ13q4SdOadE/l3373j1xYt?=
 =?us-ascii?Q?U0AuqZ2gDFyqHx0n33+80RidFT8YTpGxvHCIVtPbtFXABMnOYlm/qjLzB+s2?=
 =?us-ascii?Q?b4NqfeP++WIIFyop2vde++8+q2DBwMSKrYBx1QjychgXCIiwfy+i/Qu8FVnj?=
 =?us-ascii?Q?OaqNZD3VNtD4NBU1lnlQRYbk2wliN7R9DbYrnseAv+RQ/FztKUou31BN7ALx?=
 =?us-ascii?Q?fY2NoXETQ+yLj8YV69axdfWPn1jddM/szcJIsPZNpX4bVewuZmGAGN4U1Zju?=
 =?us-ascii?Q?PgvyPuhZAsrRerwIPTprL2EgVGVIaM6sj7cN4s1uKVG0/8u/D7Sge/gWiDUf?=
 =?us-ascii?Q?K9dDEdD0UVj/wRhImMEQmHT0ANdzSbmH5Ll5tvGKNTFyeVne375gMxQu1i58?=
 =?us-ascii?Q?wZUU+TA40mONGx8m7PkeJwhl4wXB73eojYfICN3elMfGssvAbPvUFIqaDgn6?=
 =?us-ascii?Q?/znjkjFV5efuoKG+aW5UCIC/oMfdVC9JqvyP/eZY5S6lTc/MBnzabeBMhN8R?=
 =?us-ascii?Q?inVFqhKMxujzetfTqiWlPqeeRXb3s3U7Q7OFm2CZL7vBQyiKximmAqLMDtve?=
 =?us-ascii?Q?EY8LlvRAZ7otw+xFxI0nn+uryqIy6syFyrOeTOMBxBW66+bi3B9yuBsnuNh4?=
 =?us-ascii?Q?76BhIx1ngxjf3LHB/PdBsNYMSMk+XB45wra5hfr6VSb1WKoYqQfHUk1YPLIE?=
 =?us-ascii?Q?gkg7pkXz1FAYdZw8/3m5P6p/zaOqxEvqNo4l8EAs7zZXhFNH27iJ/OktugrY?=
 =?us-ascii?Q?oupNXKZkLC24f71aLdcoaHDqDk91ygGQmaF8eHLzNP3IGaxsyoxGxMg2SRsb?=
 =?us-ascii?Q?yff5nVwOm0WsgJa0M0yTfis0LUcN2iQc4P5uF/KeZJOGE4wRO04g1V3lOq0+?=
 =?us-ascii?Q?CxBqyoleglGGtiMKtKgr7LujVLBxKEdmj2OhWvs9M0kkjheJEVVdEX1ojp5p?=
 =?us-ascii?Q?XOgl6y0JgSW7qMUYyn2u63H6fb2irAJWj3wBU2e0vx3ovCAwR1ROwaJ02N5C?=
 =?us-ascii?Q?M99co5Aqu/aqu1MJu/M8C4vhX9nLmURPdm8ur/GZcaQ9d6b3ATUFuNxW6Inl?=
 =?us-ascii?Q?sihXonAJSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: goB48zWtAqNn1DpUa6M1LZRbYdH4a96dG55+sMwafIAfNx19AbKc4YdwFv4ZGCkaq7N5RI9UtFT907jSDX/juEJ3jFKY9AJ3otQKtshIsR4qUKTD/5j0GZPDEWrDgJY+dO+a6uTmd2jxNuG4JitFbu+GBVQObkWf+HgJGq0Y7evf7MI1jLg76O4iX2zbjTulbfd8NXBgjgTW7mIKhT/2LOVKRPXsDSu9XP+SHXPTrI5nUzGeoUcBovhk+ssZ5PaLmI8ucXRV9ieA2JOqMnsei29/2oAt4IomAJ8mjd4RlpfH6CaSNxVXS9EM4+GakWJGIKpO4mb4M2cS/dsT0gGL9A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c917e0c9-8219-4ef8-123f-08dec205a3b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 06:51:01.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WucQwAe1QFd4IBt7rqirZZUrSwW/VjidmG6ZcLswtYjCZ+n0P3O6gEnZiz+cXiXDBSIPfdbmZieIFI5LUqUi5/iUfXBJenVIygG6zvpzHqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295063-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,tencent.com,davemloft.net,kernel.org,redhat.com,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,intel.com:dkim,intel.com:from_mime,intel.com:email,tencent.com:email,iogearbox.net:email,IA1PR11MB6514.namprd11.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tushar.vyavahare@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 496FE63D714



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Wednesday, June 3, 2026 8:22 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: netdev@vger.kernel.org; Karlsson, Magnus
> <magnus.karlsson@intel.com>; stfomichev@gmail.com;
> kernelxing@tencent.com; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> Tirthendu <tirthendu.sarkar@intel.com>; bpf@vger.kernel.org
> Subject: Re: [PATCH net-next v2 2/4] selftests/xsk: Move UMEM state from
> ifobject to xsk_socket_info
>=20
> On Wed, Jun 03, 2026 at 11:33:25AM +0530, Tushar Vyavahare wrote:
> > Move UMEM ownership from ifobject to xsk_socket_info and access it
> > through xsk->umem.
> >
> > Allocate one shared umem_real in ifobject_create() and let all sockets
> > reference it through xsk->umem, while keeping ownership in xsk_arr[0].
> > Keep the existing goto-based error path in
> > ifobject_create() and free the allocation once in ifobject_delete().
> >
> > Reset the existing umem_real in __test_spec_init() with memset()
> > instead of reallocating it.
> >
> > Preserve shared-UMEM behavior by copying RX UMEM state into a TX-local
> > UMEM state in thread_common_ops_tx() and reset base_addr/next_buffer
> > before TX socket configuration.
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > ---
> >  .../selftests/bpf/prog_tests/test_xsk.c       | 133 +++++++++++-------
> >  .../selftests/bpf/prog_tests/test_xsk.h       |   2 +-
> >  2 files changed, 80 insertions(+), 55 deletions(-)
>=20
> ...
>=20
> > -static void pkt_generate(struct xsk_socket_info *xsk, struct xsk_umem_=
info
> *umem, u64 addr, u32 len,
> > -			 u32 pkt_nb, u32 bytes_written)
> > +static void pkt_generate(struct xsk_socket_info *xsk, u64 addr, u32 le=
n,
> u32 pkt_nb,
> > +			 u32 bytes_written)
> >  {
> > -	void *data =3D xsk_umem__get_data(umem->buffer, addr);
> > +	void *data =3D xsk_umem__get_data(xsk->umem->buffer, addr);
> >
> >  	if (len < MIN_PKT_SIZE)
> >  		return;
> > @@ -1003,7 +1010,7 @@ static int __receive_pkts(struct test_spec *test,
> struct xsk_socket_info *xsk)
> >  			return TEST_FAILURE;
> >
> >  		if (!ret) {
> > -			if (!is_umem_valid(test->ifobj_tx))
> > +			if (!is_umem_valid(test->ifobj_tx->xsk))
> >  				return TEST_PASS;
> >
> >  			ksft_print_msg("ERROR: [%s] Poll timed out\n",
> __func__); @@
> > -1163,7 +1170,7 @@ static int __send_pkts(struct ifobject *ifobject,
> > struct xsk_socket_info *xsk, b  {
> >  	u32 i, idx =3D 0, valid_pkts =3D 0, valid_frags =3D 0, buffer_len;
> >  	struct pkt_stream *pkt_stream =3D xsk->pkt_stream;
> > -	struct xsk_umem_info *umem =3D ifobject->umem;
> > +	struct xsk_umem_info *umem =3D xsk->umem;
> >  	bool use_poll =3D ifobject->use_poll;
> >  	struct pollfd fds =3D { };
> >  	int ret;
> > @@ -1222,7 +1229,7 @@ static int __send_pkts(struct ifobject *ifobject,
> struct xsk_socket_info *xsk, b
> >  		while (nb_frags_left--) {
> >  			struct xdp_desc *tx_desc =3D
> xsk_ring_prod__tx_desc(&xsk->tx, idx +
> > i);
> >
> > -			tx_desc->addr =3D pkt_get_addr(pkt, ifobject->umem);
> > +			tx_desc->addr =3D pkt_get_addr(pkt, umem);
> >  			if (pkt_stream->verbatim) {
> >  				tx_desc->len =3D pkt->len;
> >  				tx_desc->options =3D pkt->options;
> > @@ -1234,7 +1241,7 @@ static int __send_pkts(struct ifobject *ifobject,
> struct xsk_socket_info *xsk, b
> >  				tx_desc->options =3D 0;
> >  			}
> >  			if (pkt->valid)
> > -				pkt_generate(xsk, umem, tx_desc->addr,
> tx_desc->len, pkt->pkt_nb,
> > +				pkt_generate(xsk, tx_desc->addr, tx_desc-
> >len, pkt->pkt_nb,
>=20
> Nit: you have the umem pointer handy, what's the point to change
> pkt_generate() interface?
>=20

Thanks for the catch; I've reverted that part and kept pkt_generate() using=
 a local
 umem pointer to avoid unnecessary interface churn.
-Tushar

> >  					     bytes_written);
> >  			bytes_written +=3D tx_desc->len;
> >
>=20
> ...
>=20
> > @@ -1856,9 +1875,11 @@ static int testapp_validate_traffic(struct
> > test_spec *test)  {
> >  	struct ifobject *ifobj_rx =3D test->ifobj_rx;
> >  	struct ifobject *ifobj_tx =3D test->ifobj_tx;
> > +	struct xsk_umem_info *umem_rx =3D ifobj_rx->xsk->umem;
> > +	struct xsk_umem_info *umem_tx =3D ifobj_tx->xsk->umem;
> >
> > -	if ((ifobj_rx->umem->unaligned_mode && !ifobj_rx->unaligned_supp)
> ||
> > -	    (ifobj_tx->umem->unaligned_mode && !ifobj_tx->unaligned_supp))
> {
> > +	if ((umem_rx->unaligned_mode && !ifobj_rx->unaligned_supp) ||
> > +	    (umem_tx->unaligned_mode && !ifobj_tx->unaligned_supp)) {
> >  		ksft_print_msg("No huge pages present.\n");
> >  		return TEST_SKIP;
> >  	}
>=20
> this hunk does not add any value IMHO.

Agreed, this was unnecessary indirection. I've removed umem_rx/umem_tx and
now use direct ifobj_{rx,tx}->xsk->umem access. I'll send v3 with this fix.
-Tushar


