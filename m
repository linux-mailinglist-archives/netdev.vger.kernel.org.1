Return-Path: <netdev+bounces-153647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D57B9F8F84
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 10:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E041018881FE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 09:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192651BCA19;
	Fri, 20 Dec 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M68WQYQY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255691BD01F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688712; cv=fail; b=cBwOPh0vppmtDWNMtZDGgAlR3FG4+cW8FkKZLr+8krP/X97U2ZY8KVQ5WyVU3AIyZJchByfNKAhw7DdnpSJdb0JFs4YBf0zOz/DV8b39oAGJkrmLBkxZY1HAAVRlBflNgcD9vxpTMEfUgqdtfzNaV+6EqT47GS7iYp0Z8Rx++w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688712; c=relaxed/simple;
	bh=lweCHLs+hD0LY1e0S6Wd/TN+N22lKrY12FzT+HF2a7o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgCTARPd8np80MfgI9DBrWQlr+fpCku21tnTb9259ZelZskk11PiTtQLxPxOWzhFF+1Nz+YySEOotG964LeZAH1lmSOaGovWuCxkrK5XRcn57KDdV0+EI4OY005S5efXKhUSmyk0hVau5xIg/dmq4IdxSlhhM2U07qyKzms/T0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M68WQYQY; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734688710; x=1766224710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lweCHLs+hD0LY1e0S6Wd/TN+N22lKrY12FzT+HF2a7o=;
  b=M68WQYQYIO+wp577EJso/GaKrbDFT1KRulCsN1E/5XN/fG0GcZUumzw8
   I/SkWDArCI6H5RQcyBz7UwQq0KqfyQyjAOW+kSNK96spuugpMsn+IJcG/
   X76CSP0Bim2G2kUX7a/y4dQ11qgo7OOAsM6TJELaEtT1GvD5pLiD1OBJ4
   HVrMSuucT4FT6i6mP6mBt8XxrKRKBvTpL2R1llEgITw0O0eqRQfpuM99p
   kM9QIVvf02u1i81jnsRmmlheI43Q2aRdrRSlfcUosM7LwkDtj6aLiOk1I
   m0r4z54UOtiXrZKfNN0EBZo44n5/ABrFsOAzDQnS8KXVms2039U/wGBLK
   A==;
X-CSE-ConnectionGUID: pMHqFkn+RoWtBzCuy20xzA==
X-CSE-MsgGUID: 4X90PLsLQni/0BOLMLdv3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="34555193"
X-IronPort-AV: E=Sophos;i="6.12,250,1728975600"; 
   d="scan'208";a="34555193"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 01:58:29 -0800
X-CSE-ConnectionGUID: wYoXhcrSR4WDnUhDG3fKFQ==
X-CSE-MsgGUID: z5MzJuCyRFaUc0mA/sqc5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135801831"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2024 01:58:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 20 Dec 2024 01:58:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 20 Dec 2024 01:58:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 20 Dec 2024 01:58:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkNXmDol3XEhGfIp8xPofDQqE+uccf19esJva+TAc8oO5XcZvJ1l6g1f4TRHr3hMuADH3sPaObUDHX/w8wIhIWL5t9eQeCiwHlfEE1GkfiP5FaKLkjdGa6DZh6FzYrY59PIsgnMaT0EG639is2trjPLw9cFapWIeUKpvyZfLM3AiDTZUa+DtNaLa8BtUuJPgdvg5HJ5smrYvSfdMKChHirqcSpAcM+Ppc8EmErot5MLP43H94UGr/60s+39Lbxk4cE3MfANDd46ucu1FdxfGXxhQd/Wt6cHffS/d5t+w5ZIInzuURO5JIuvXmcrMAnZlwG3ECGF4HjC2zUoiDETnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxZeRJRUUOXQcKsUCX5NJrwFcWMXpiZMF05414I4wF4=;
 b=tnUJtHDdeLOYKE4w+JagwB3N0c5ZTHtgRMWnzy3xWhGicahE/8t7/Q8eDq1W7nPCYYag1Hs7tf85J6qIS0LXHI9ZzQQ1RHC5Ei7URzElzpUqPcHcbeEhY+zSXZXfQpUWZP+b2rtG6vYv5PKW9x4xjdreKwR9CiMCAKULMuI/r3souAJ7AIlbthe7yOpJzYglwgm+A5Yw1ayk8aKQHTUsv4rTkakfgWajPfcnLB7HyCMS6SuU53AXsdy7OEC596teAUHruqBBpWiMo5s2VHRrY2HleoxGilHFmVtwmHRMyC5llYrHi8O+Z/fVNKRrRY+fDwM4MYldWV0jfsmV+yeJVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 09:58:22 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 09:58:21 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 0/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 0/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Index: AQHbUU6VoEWliKFtI0W4e9ynvd4alrLu6LgQ
Date: Fri, 20 Dec 2024 09:58:21 +0000
Message-ID: <SJ0PR11MB58652224C1AC96B8B67B97EA8F072@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
In-Reply-To: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|DM4PR11MB6480:EE_
x-ms-office365-filtering-correlation-id: b3ee9823-8abb-4e18-4b2b-08dd20dcd675
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?X5mtVYLqgXItvhvyacckn1pCfgkQh5/q8gJ3F8SxnmXNLF6Gxce1C9ZTrpd1?=
 =?us-ascii?Q?EX3VnPx3VJz/KNC4FcbGx97b0Tg9bHnIHJIgimrU+Lc40H6kTPoXjkqqwmr6?=
 =?us-ascii?Q?7+7/EsffztkwFJzLZcdM2H1hOafInLJboo5liDxJxnwbPTiXNOTbnhoC67Pc?=
 =?us-ascii?Q?zfXjGlumZMJcn2E9EzE+4ltzrTgq8xzo0WLtmWQbALAlWm1W96PeJpxwnczL?=
 =?us-ascii?Q?mhx4v9JifsfLMNr8pldDUlzp0on5AS7xOFDOxLDH1ma3QY0DPMot1ucS5nO8?=
 =?us-ascii?Q?2JaAj9BdhNSVQohcEXtirsA4IjbXVQ5rreP52S2DRYlMVPrRCJe6e4BI6rLB?=
 =?us-ascii?Q?8tW2lM/G7HGBiFPWclAyp4fChE8TwTiN8TbJjtpljCIQtdkviCVxJrv4pkeR?=
 =?us-ascii?Q?OvP4h0DRXNmXzZMItOSSLcgPddGwMjYPGb5pqBlXC9Y85S7G3Gf7P8YTBMLh?=
 =?us-ascii?Q?70oSJhheJXMm8Fqx4b0uYMzJRmCPnqq4pSuAnbIYDNiKFgdpmuQteWC4eb9h?=
 =?us-ascii?Q?IoyETdzBjKoOeOxsQHtJvukDZ1F5ioxBQEcKaKet3ZNyBpNDX+S4Hh8qp5EC?=
 =?us-ascii?Q?SzDdhJvo5B586ThNN2dgWu3LnKNeyv03Pt/Fl3wgbj5m38DIKGUqz/dX9GNi?=
 =?us-ascii?Q?b/Da+cPehwVUMG4dGet3Hl3WIyxyG/hYYacHKG0E5487Gq0OI1LRPyS1VRVO?=
 =?us-ascii?Q?FWiyK+9Rztg1UTf9Bk4RmCt6iB3DUi6MYZRqnMmU/84gv5Ia4i0GVjLrUDy4?=
 =?us-ascii?Q?fmosZ0w2cy6thq6zeIzgHTRCdrhJNJR80ii2lKHCzV58hV7Wu+6QBzWfVpTT?=
 =?us-ascii?Q?255ocCBvzOmUGENU65Io82HtoT6IOyjvNiPCA2MZCa37kBWypmQFtElwgNLc?=
 =?us-ascii?Q?qdcMiR4QxZSJxaAtQjY5YHDjgZeG/intD4g5isCnWXyiAKfPRV7coq1F5NDX?=
 =?us-ascii?Q?1ocUqvy72q8FTC4ciN0N6pmbb5FRDTGgw63eeU0IMn8YrrLyGSYhuJQriJ1+?=
 =?us-ascii?Q?8OYE5Gl8ms8H3MMgdR1+97M2TERpMsWpLMB5SyfDZK5bzKtIB0/arYWFQCk7?=
 =?us-ascii?Q?GPqtIpZwfTGBQMw+oqdxWlI42RBBEHH62SjkgIfXXdOv/qkGUebCXPQPsaIl?=
 =?us-ascii?Q?fthyz6YZAGhmsBhgfiXmeh8n1+Xc7vJdTnDdC1D4bCfS2ksSyRvYUjqh+awd?=
 =?us-ascii?Q?QcZjW/kNAF+8bBhVEzr7MH+XTMlOXcH6JxdoYO7LaT8ahlw8qY/yUKvxnfsI?=
 =?us-ascii?Q?JLlULMRCDzu+fSqbxMxs4OITCypd/6kS4drn0Y3BINVf7h5eDHD6j9v5+h8p?=
 =?us-ascii?Q?xv1XWNbPoymwLGhbs0bjmAsrnGl3ET/U3+TFi6IF3fvFAJdfH675pDDW47u4?=
 =?us-ascii?Q?1CBaJYu6/3D3j8GKxhvMTzV3ClW8N/RJRBrayNy8PtcuaeUHAVSEG5h6Vh7l?=
 =?us-ascii?Q?wotOTMxn8DFFPO14ZsMD7vW3qa4x5ymT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3vzJmB03qNa0clqB/KALIP2JUexJJwihwOpS+MxNEI1e92g1nhjF8KpM9BFI?=
 =?us-ascii?Q?sfUUnRYALLDy1/ZVApKlbNNA0/nomvk5pHyvtPZMUYsmFmHVXBHgRIlhlXPU?=
 =?us-ascii?Q?rMoA9tGrN9GxReI9/55ykyKJ+9vN+R009xjauDUy9mBOLzys+C7wtw7CyGgA?=
 =?us-ascii?Q?3XmUqHyYDvbWE0FeacPXngHuH+Fpzx0qcaxr+dPXmIBrfgCzE2Gvun+LIFfg?=
 =?us-ascii?Q?ZcYyRQ84cY3OLj7Aj44yEx9DqemxtqW5UNWMGYbjcgHMUW3IyGUd1zX0nqCa?=
 =?us-ascii?Q?IuOvBpNCdnDm4NAV47Xefsj7nUOhiNfBtzt0eQ1hAzfoNTV9kd8uIWoFC0Ua?=
 =?us-ascii?Q?owbD2JoYjcbwUZdgiOWEBdq6GLxuGKdiPH5R7AV3QBpxBbfA+7/7PAg7cdQr?=
 =?us-ascii?Q?f/eohpxJXKJAnB0A5L20Ot7QZKnpg0UzCvHoqfQDjRgft8qpxgqccWyEk7Zo?=
 =?us-ascii?Q?Ws6xYwRbcMZGctZYSZzODdge+wywbPa4L7+bPAhlp0gBQUeLvIEcPXQE0jZt?=
 =?us-ascii?Q?5MHKMhUsDbitbpe5CNg80NG7ZvGAX5A6DwMTLtMkCtme+TQAw24GluLEp2Oe?=
 =?us-ascii?Q?n16j0jjZ7nS3MEsTRzy1iLB8pDHLSnOoRWa6pVY5zgZD7ljmfnGN5cHAW4Mp?=
 =?us-ascii?Q?zvg2Nev1mDW+JuowpUgYOfxv8PlHi8QeO0V3qg6pb7EHIpsmXNmEo9/tU0ks?=
 =?us-ascii?Q?DFPQrW/skGdjK5PsGD/iDVQRyYYtiKgDOnIcwdfg4z/KiNdxO52Whg38jn/O?=
 =?us-ascii?Q?+InGBiREjiha8H6mig24gf9RRTZMRuyP0zhzwB15Yr9QZ+DeVQhOVl3579KP?=
 =?us-ascii?Q?4PrUD+5CntWy1+J68HIxsFNgZuYvnytLTD0zR3YLYYWziD5x2zW/b6YCo/v7?=
 =?us-ascii?Q?qKNda7qzxntKKKUuH3K7olqz7Grzk08/iwy7bko0KxbGEAkioKEGSHVMNAX9?=
 =?us-ascii?Q?ovspqcl602T0BDcuQBzf/TXOU9K16VMh0uOeUwnpN+9MlxQROquk4zNHmitb?=
 =?us-ascii?Q?Ik5IRSX/tHAwWiw6Z58Ey9gqKfVY7VK+DfEVvNVg07PBupClS0OAPNG/kLO9?=
 =?us-ascii?Q?QZiSb2sPMoLzL5oL39gDH7qQOsjG/7tlgEo1IcwIsa34wpVS/Qp3POal1Y0F?=
 =?us-ascii?Q?ZqNwmkxsgbzEx7YP3qXQ4Z5/UJtCPWvpn+JxrHiapfciA/vJwRn4VIjF0Rrl?=
 =?us-ascii?Q?9+Qe6iZ1md8h7PCDJl8hJC4+pciiXtSoOJgQvnxoT9TfDsBG/B1yrG7TC8AF?=
 =?us-ascii?Q?xIq/RDFNpt2ioGgaohWSO5W3kBL28JLyrDXBDkOZgjTgE4MBnIGQsBFrLTNM?=
 =?us-ascii?Q?tvV6r0I00B1UcGZW3XCuiIxoLbCoLoDGs4YIUC137CYcZI5xYBjOkZbN/+/6?=
 =?us-ascii?Q?OLo5LXN9xJzr0fD3kX6w42wM5obao9upv1NQHxofjTRWGekn10Vauw8zh7hX?=
 =?us-ascii?Q?dTwqfL1Uo5d6S+M/zIPtyvjL2L0yo8xq7cV6saFClRRvi4wDwb3v9AE2HEtQ?=
 =?us-ascii?Q?rpa9u3ZUqCf0OgiB3MDAvmW/OPM197r8CpNEIHEbCIxDJd3NK7CC1AsZMnpC?=
 =?us-ascii?Q?DNZH506PwIiw0qunVdntqbwaBBTANrt4b04ZsllIdjsTSo5NlPUXl78H+R3O?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ee9823-8abb-4e18-4b2b-08dd20dcd675
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 09:58:21.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlnecF9gyMCRRQMwSqb0PQzjFGBVCDSB5HxaVRMhH6LvrP/2OfF6GrxFYPAw1QnrmHYOdTOTg8XkmEAYo4GLUpoWj8ZNl9TdagL5/ZN5iFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
iotr
> Kwapulinski
> Sent: Wednesday, December 18, 2024 2:13 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr <piotr.kwapulinski@intel.c=
om>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 0/2] ixgbevf: Add support f=
or
> Intel(R) E610 device
>=20
> Add support for Intel(R) E610 Series of network devices. The E610 is base=
d on
> X550 but adds firmware managed link, enhanced security capabilities and s=
upport
> for updated server manageability.
>=20
> Piotr Kwapulinski (2):
>   PCI: Add PCI_VDEVICE_SUB helper macro
>   ixgbevf: Add support for Intel(R) E610 device
>=20
>  drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
>  include/linux/pci.h                               | 14 ++++++++++++++
>  6 files changed, 47 insertions(+), 6 deletions(-)
>=20
> --
> v1 -> v2
>   allow specifying the subvendor ("Subsystem Vendor ID" in the spec) in
>   the PCI_VDEVICE_SUB macro
> v2 -> v3
>   update IXGBE_SUBDEV_ID_E610_VF_HV to 0x00FF
>=20
> 2.43.0


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



