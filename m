Return-Path: <netdev+bounces-223983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB8B7D0AF
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61172A0B87
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DEA2F83CD;
	Wed, 17 Sep 2025 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vgn4pIIW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4022C11C9;
	Wed, 17 Sep 2025 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758108417; cv=fail; b=htjuXSvblJQ3Z5Qu/r+DFhpymzVYrV2Ttq1vCCEok6KgsN1Oibvt8g9y+IdgnElpavWUe//GS8yMZLamd05ifHqVJSQPQPEp21LcfrucF8NjLMgvoprTxeEuYMmCZeQOQEu9udEptphCIRP1Krhixxgt1RCY/5zi1XjZEHtA+p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758108417; c=relaxed/simple;
	bh=Be5OWWidL5gOPT6OiyO19w5sb6BoimQl+GG50scCzU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXAw6iJGRgYbg+6SoOSXQ+SS4pi51ToCm1kH11wY9RZe38Dvnd4/dUoE7fSb5RsEO7M4FEBJf4to+xJrc/WfGYtk84+sfz4nhtqjwp0GsFlFnWvlDmuVrp4fccwKw/WKBRTdJ1oyZv1ailIr5lmimFZHZ7D6H+5H7rsOAdxfmSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vgn4pIIW; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758108417; x=1789644417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Be5OWWidL5gOPT6OiyO19w5sb6BoimQl+GG50scCzU0=;
  b=Vgn4pIIW9Ykif0ctE2X7Q7BpFfbouW35M1+XURsqYUGABstY4hl3sMWe
   CezoqLr5LIl+pBRctVBNE4XvYswAQ2sL3r2xOPIMU0eeZhUb8zQfk+Vko
   T1IZNo1MhcbKmh1Rd2PtL58tm9U1pYdhaWIMVizdTcCVL0XHihQHFqrDt
   U/hP7kRFAhBNVxCMhmhQ+IqmK44uf0uohvIoYjR+qYIyZ9niL0Ok+ovdu
   MLOuvCn6y802H97un3/6xjOP90tHBjL/4/SkD2ViDzyO7mVG7HTvVJK8y
   gjt7fLlcYKgrpk/H8IlhBOjisSpWaQZ9vDZ04e7PrDUpzv5hRO+zat6ym
   w==;
X-CSE-ConnectionGUID: saS1kr3pRm+c0F/yzApYgQ==
X-CSE-MsgGUID: EVJ/uNrwTBupr6Rk2cvAsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="71514085"
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="71514085"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:26:56 -0700
X-CSE-ConnectionGUID: MCyjN/8HQj6yJEj5xiINbg==
X-CSE-MsgGUID: U1e8KK04RxSATw2C025DXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="206004191"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 04:26:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:26:53 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 17 Sep 2025 04:26:53 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.17) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Sep 2025 04:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgd4zhVahdakljhtt1SWpFkj1M1x5RRuAbeGE4h2nZXoof+JqkKUnQ78oQIlUornhtV+f4mE8LNChuqDGgX9CNlRcYLZQUh5SiqXMdxcUXEjOL4P6LSkqmduH7u7JmKzZ0ZPRVt2/fJwwJ/ZdP8hNRbmpIRtUf7NJw6WGhANodsBqlJELdJ5yWg/5aGjOaen5Nq3nSO9RUw+eIOoN3fzkUqBiE3LiMDNwLuh/QUdnGtJfAt4GnKDQ07BEnXIKVA9dDwrhcF631VcoQKvhXtDlen0Wrb8ZHobRDdoQfyT6cDodGqhUXCtAcLob+AfYwRncwJtFHk/rG4SSGRognuDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ljRdA6uy64t+S1YH3Yh4h+Mx/XtCEvA00IJ4fzCneVw=;
 b=UHIix9E8Ft6BhCbBNC7D0H17PvoXIfQKHPOvbKFWmLUg2n+JVaSobS6O3tKxUDIK599LNidZNYjCeNr2NkqnZdF6gpeWSFqS/5xiy76B4VWUdQV69Lb9NVI5cai28FJKE8YDz8RmBFjK11CJDM1MEHpeei2kgrnW2BfM6Rp/xmWDPEf+Izf1fUHvou8AMzI8nshLb0x3zpeQu+78hgUtjYf+rToCtcuJ8ACR/jTMmvaFro+NrtwkuNzwYujjf/eAOIxVFDoONH8j+25+1Ek1d4tVlYjUEsUQhrcbcDu1yUfxVDPEJYXIsSqR1BtGkoCUTF1TqzX0NJCM1OUlESgfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5)
 by SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 11:26:19 +0000
Received: from SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb]) by SA1PR11MB8446.namprd11.prod.outlook.com
 ([fe80::789f:41c7:7151:23fb%6]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 11:26:19 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, "Vecera, Ivan" <ivecera@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Prathosh Satish
	<Prathosh.Satish@microchip.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Thread-Topic: [PATCH net-next v2] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Thread-Index: AQHcIuz7gBZiqN/7qUGqrdM7g65j8bSU8B6AgAJJoIA=
Date: Wed, 17 Sep 2025 11:26:19 +0000
Message-ID: <SA1PR11MB844643902755174B7D7E9B3F9B17A@SA1PR11MB8446.namprd11.prod.outlook.com>
References: <20250911072302.527024-1-ivecera@redhat.com>
 <20250915164641.0131f7ed@kernel.org>
In-Reply-To: <20250915164641.0131f7ed@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8446:EE_|SA1PR11MB6734:EE_
x-ms-office365-filtering-correlation-id: 8c79f689-317d-4971-6ced-08ddf5dd0616
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?VajRlLbaz79OAZifUdXx2aBZ2GB2t1ZPvg9hFnIOMnsHOk8ALQlGSaELfFsA?=
 =?us-ascii?Q?dKAw7ns+GTnIrw+A7wL0r7aL4M/KLngIsJcKTFcqBHUztRNleXnwzfdES6Ba?=
 =?us-ascii?Q?jTM3IS31vBoN+F5acstu7dksXu2PsDjINSVIDzfXvz+SXeHRQ86Fa/AeBWJ7?=
 =?us-ascii?Q?k0y3S/SgZd/56VFkuIQBibor5H6qSX0SrHXkKMCZ2dlHFQGH21TUebfpWTsW?=
 =?us-ascii?Q?1rEVAatyEkopA3i///sUeoNy3mfCgPnHPeNDNJN5QZs0SLfg1dGZWHeStCRR?=
 =?us-ascii?Q?AZrAVs3b7/40KebF/nW9Hfa0IXHDjHcIVmM02wD7Svgy0tZWWENy9WZUuuDV?=
 =?us-ascii?Q?Ls+WXiX2jrsDUjrjq6eVaToZWc6QylH0R0sU2bHQySKqpgWftr4CEux52X1b?=
 =?us-ascii?Q?kXef4gZ3I+mgjMXwyuqmOcpIpjJH6/G2/UkSG8q3Rq3TO0NMhGIK58ebSVZ5?=
 =?us-ascii?Q?4HcDjASSPZT9qczkx8lt5X691DkLGCEp8sa9lJvKa4sJ6aNpaj2Q2mKXVH4P?=
 =?us-ascii?Q?48ibFeEts5k89pC2S11zP+uUvrwgDT33XfG5FGRWxvZ9gjXbHFo+6GLul9Uk?=
 =?us-ascii?Q?TCpa16XwPk7vptw4aySumOq2AcQSU41RJp6u4UUSLrWrMTFS3/Jsm33+2iWJ?=
 =?us-ascii?Q?Po8dP+6QppUDq7N7HoDBkg6czLVLhcUyzEkBnk2Zd86KvwseN6fg6U71TbL/?=
 =?us-ascii?Q?+3XLmVg8RbwZu3l+gNYPhpSUDRdB5ZIqWAIW3MBnCJnVET4z+569uBr4gN94?=
 =?us-ascii?Q?Z5AC7/3HZc+nGDiUPiXRSIddlibGyIRkqu9w7hThfIuKcMVrzBkuQwDLufrj?=
 =?us-ascii?Q?EiXHHlvD+QY7ZBv1PCCfqaOHVp+F++QLcp0bbdJU8O/rmXJLjt8JBpCz73E9?=
 =?us-ascii?Q?IPYYFfBI/cuT/Oo3D2bJ/7WXO2/26BSa/M+pVgbnrKy9kqttuuKC71zORjL3?=
 =?us-ascii?Q?19P+/s0XGmzoazen1U5UFriVeYerCm92OZ4QgVeymmSUOhVVakDcoJfbkueu?=
 =?us-ascii?Q?HZY4npy9fqKyBOTOLkkBgz0+3bRN6ZtDZ3Jv2xjmZTtAUfwL8vG2bqZFNO96?=
 =?us-ascii?Q?kzYgEbBgvXb4cXLZeW8ziduRB6iI5JK3HwAWTC9MzY4m72FyXJK+TdeROTzj?=
 =?us-ascii?Q?WNbOXcy0cg2OmV/cUWVYXHc3xC+aFL7P+A5eMZ1o6R0EdZgs+8hgSIy3OGhs?=
 =?us-ascii?Q?MmrvyUO17pbUdV7YpVUTQzR5e+fErHrtkMRli0ibrWOwTeiAre2CECfqSDFZ?=
 =?us-ascii?Q?ru+7DACS/R9MhyHf2pWSzOL0T48Q5TPFcwh84D3evaayp/9wjnLN3/FsvFxM?=
 =?us-ascii?Q?XnO85Y2sB8XTgp+zy/s6fXV3wlOZ10stLMIA8ArenAqdna8cY1FD4BvqEmaI?=
 =?us-ascii?Q?GY/JIfGhJZdft1hCrxviiXU6WtoSKjurrvjIGC2T39t/UDqV2rrCyDNhC4zI?=
 =?us-ascii?Q?lMqW4LCIMpluHtpg08RBzqP1oTLazGosBAgucMieGpAxVV+480DHhg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8446.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HunzTe/wTSN1WFQdGDeqo+t12xiLwtnfIza2yF7/6IWllhs/DjbPp5zi7FDW?=
 =?us-ascii?Q?RSrZSZgw2Ntcry0nKVSMxyqXU0JQbb+0N0nSZ1J6bi20eBOu51udTGUyRBnW?=
 =?us-ascii?Q?qgWOu2lsNper3YfR8it6AKDkIwJ2kd/l8ZXWm3fELPaybpPoTEfb74SMTthx?=
 =?us-ascii?Q?I+j9JH9idD3ihcqW5bfTKRaUkb8pg6G+g/ORzUWaBX4aHYbYnesxDQVUxLfd?=
 =?us-ascii?Q?5nxITsz98y81Sz79TX0fKQwswM3ZnFUVxIT1ib1lNWBuDnEpQ0MFlwALOIhp?=
 =?us-ascii?Q?UIROK7TBkvsWuUiPMfHapoL/D7eZK8qqxy9Sn0Bk4NKF3n1l/9SVmHv6af26?=
 =?us-ascii?Q?F/GIdx/IXiK065Qk1kAwVId0hv8R0LUWVbt3KdX5GY12hzcQmpFBb+uiBCbW?=
 =?us-ascii?Q?6ITAcVd9wcQgNhmA/ldLTeYbh/F40y66T3HNlOQ/BQ28PuNzYEAUfyv707Hl?=
 =?us-ascii?Q?QMYl85e2jpfSoeOFgvU0Uq3rT9H0vZYs4KBzwitHaxgSL4TwKGWSoPv1+pJa?=
 =?us-ascii?Q?yOEHPUZQzXYvIP+Ne4c8IqpY9m8IDE6v1l5VHVnqyvMiQrwD+KyO8+ax/eyP?=
 =?us-ascii?Q?rDDITISes90LKdML6uQxcz3ScJiVX+MdrFADe1LEk8fxDkK6y77Ry1c/EO7T?=
 =?us-ascii?Q?X6FdDXD7FEZskAwSaodN2kVLbvQyHGSy6ITj5JcOSYtZFam7UVJqxHZ/6aUz?=
 =?us-ascii?Q?d+2Fmg9H+FNrx4raOHti4rdJ/ISxIGrrM1M1RwRe5eg0UIc1oUMAgN2BSNBA?=
 =?us-ascii?Q?9lleRUi9R9mGGygcPYuvy9wdBJp8QPTlixzHj874LNQxTGI2+K87Iq009Lu3?=
 =?us-ascii?Q?3uwv9Iq1n++ngc7im1IXw7sVk0goPvU1JxW92FHFrzk3wrsVCTqIGexuSvo/?=
 =?us-ascii?Q?6126xbis14cVMuQorPrkAkyH5k1vd/wKSdpyD57KQZgWUMxepJYj2C2WxU0A?=
 =?us-ascii?Q?quhzWtm3EceqcEik8yJKyxiZM9agnyZl8h/oYGbTKOtJfKz6j8QPoV7wMJVf?=
 =?us-ascii?Q?09OQ1NvTAGpYGpxjtyZCL0+MQRds3vDJNJmRIVv7kX5wZmCLhW5xyA4eXFlq?=
 =?us-ascii?Q?jAnCTXp3B+sv0jAUQ7tAvDB27gjnSvSE+90kxRV9L15xayG3I3IwlpaRvsTK?=
 =?us-ascii?Q?EEw423kC+Krz62oD62UH9ueunTex9hHyY3f1s5L39TW5eq0RnjEpfkNaXPOW?=
 =?us-ascii?Q?ypK+e6mIAAlwJuqmk33YJ/CKaNZ5pdQATeZo7Wc5/xhysvk0wLJVfAktkc72?=
 =?us-ascii?Q?9+C8AKN+ln7uh8Ih3gPECYahGLI8pdfXa201o/bbsSCbpn58vBc2G1D1DxbH?=
 =?us-ascii?Q?ut5hO+GcN9SIHNeaG3NfMNg/Whnykv4tfJkrX0T5c1xAOjUlExI/os3iYBfi?=
 =?us-ascii?Q?Tt42mPBzRhcN9K+LyjCwxJMED1DIlBZcvE+fO5dIC0dymMuN0u5ND0wvqVfn?=
 =?us-ascii?Q?lDOxIekXR17gm9EMndnDPJAmWlM6xHHLlc2xd3iC6hHJQlnbHWm5GKrIBsI1?=
 =?us-ascii?Q?a7Pdz4A5b7oIAYuThCWcy5WfEe9WiVQl8pbX1BkVMIgeXRuwu0okO1jzgpAL?=
 =?us-ascii?Q?Cc20O5KrGfU71vLxXiWBI4vj7AL35PTcfb+zLqa4HLjUy+mlqaF5x5uf7Azf?=
 =?us-ascii?Q?nA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8446.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c79f689-317d-4971-6ced-08ddf5dd0616
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 11:26:19.5151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bn+EkhNppP7dvR0TJ8v3m2Q+BbS+9qK7wS6M17de9RYVmBjpgVfuyhWjvEitGZUFxGMeN4PU9p/Eki7rZKzR3B4z2moqw/bh6xL3tWGHPaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6734
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Tuesday, September 16, 2025 1:47 AM
>
>cc: Arkadiusz
>
>On Thu, 11 Sep 2025 09:23:01 +0200 Ivan Vecera wrote:
>> The DPLL phase measurement block uses an exponential moving average,
>> calculated using the following equation:
>>
>>                        2^N - 1                1
>> curr_avg =3D prev_avg * --------- + new_val * -----
>>                          2^N                 2^N
>>
>> Where curr_avg is phase offset reported by the firmware to the driver,
>> prev_avg is previous averaged value and new_val is currently measured
>> value for particular reference.
>>
>> New measurements are taken approximately 40 Hz or at the frequency of
>> the reference (whichever is lower).
>>
>> The driver currently uses the averaging factor N=3D2 which prioritizes
>> a fast response time to track dynamic changes in the phase. But for
>> applications requiring a very stable and precise reading of the average
>> phase offset, and where rapid changes are not expected, a higher factor
>> would be appropriate.
>>
>> Add devlink device parameter phase_offset_avg_factor to allow a user
>> set tune the averaging factor via devlink interface.
>
>Is averaging phase offset normal for DPLL devices?
>If it is we should probably add this to the official API.
>If it isn't we should probably default to smallest possible history?
>

AFAIK, our phase offset measurement uses similar mechanics, but the algorit=
hm
is embedded in the DPLL device FW and currently not user controlled.
Although it might happen that one day we would also provide such knob,
if useful for users, no plans for it now.
From this perspective I would rather see it in dpll api, especially
this relates to the phase measurement which is already there, the value
being shared by multiple dpll devices seems HW related, but also seem not a
problem, as long as a change would notify each device it relates with.

Does frequency offset measurement for EEC DPLL would also use the same valu=
e?

Thank you!
Arkadiusz

>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>> v2:
>> * optimized conversion between factor value and register value
>> * more detailed parameter documentation
>> ---
>>  Documentation/networking/devlink/zl3073x.rst | 17 ++++++
>>  drivers/dpll/zl3073x/core.c                  |  6 +-
>>  drivers/dpll/zl3073x/core.h                  |  8 ++-
>>  drivers/dpll/zl3073x/devlink.c               | 61 ++++++++++++++++++++
>>  4 files changed, 89 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/networking/devlink/zl3073x.rst
>>b/Documentation/networking/devlink/zl3073x.rst
>> index 4b6cfaf386433..1988721bdfa8b 100644
>> --- a/Documentation/networking/devlink/zl3073x.rst
>> +++ b/Documentation/networking/devlink/zl3073x.rst
>> @@ -20,6 +20,23 @@ Parameters
>>       - driverinit
>>       - Set the clock ID that is used by the driver for registering DPLL
>>devices
>>         and pins.
>> +   * - ``phase_offset_avg_factor``
>> +     - runtime
>> +     - Set the factor for the exponential moving average used for phase
>>offset
>> +       reporting. The DPLL phase measurement block applies this value i=
n
>>the
>> +       following formula:
>> +
>> +       .. math::
>> +          curr\_avg =3D prev\_avg * \frac{2^N-1}{2^N} + new\_val *
>>\frac{1}{2^N}
>> +
>> +       where `curr_avg` is the current phase offset, `prev_avg` is the
>>previous
>> +       phase offset, and `new_val` is currently measured phase offset.
>> +
>> +       New measurements are taken approximately 40 Hz or at the
>>frequency of
>> +       the reference, whichever is lower.
>> +
>> +       The default value of this parameter is 2, and the supported rang=
e
>>of
>> +       values is <0, 15>, where a value 0 effectively disables
>averaging.
>>
>>  Info versions
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
>> index 7ebcfc5ec1f09..4f6395372f0eb 100644
>> --- a/drivers/dpll/zl3073x/core.c
>> +++ b/drivers/dpll/zl3073x/core.c
>> @@ -915,7 +915,8 @@ zl3073x_dev_phase_meas_setup(struct zl3073x_dev
>*zldev, int num_channels)
>>
>>  	/* Setup phase measurement averaging factor */
>>  	dpll_meas_ctrl &=3D ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
>> -	dpll_meas_ctrl |=3D FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR, 3);
>> +	dpll_meas_ctrl |=3D FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR,
>> +				     zldev->phase_avg_factor);
>>
>>  	/* Enable DPLL measurement block */
>>  	dpll_meas_ctrl |=3D ZL_DPLL_MEAS_CTRL_EN;
>> @@ -991,6 +992,9 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
>>  	 */
>>  	zldev->clock_id =3D get_random_u64();
>>
>> +	/* Default phase offset averaging factor */
>> +	zldev->phase_avg_factor =3D 3;
>> +
>>  	/* Initialize mutex for operations where multiple reads, writes
>>  	 * and/or polls are required to be done atomically.
>>  	 */
>> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
>> index 71af2c8001109..289d09fcc5c5a 100644
>> --- a/drivers/dpll/zl3073x/core.h
>> +++ b/drivers/dpll/zl3073x/core.h
>> @@ -67,19 +67,19 @@ struct zl3073x_synth {
>>   * @dev: pointer to device
>>   * @regmap: regmap to access device registers
>>   * @multiop_lock: to serialize multiple register operations
>> - * @clock_id: clock id of the device
>>   * @ref: array of input references' invariants
>>   * @out: array of outs' invariants
>>   * @synth: array of synths' invariants
>>   * @dplls: list of DPLLs
>>   * @kworker: thread for periodic work
>>   * @work: periodic work
>> + * @clock_id: clock id of the device
>> + * @phase_avg_factor: phase offset measurement averaging factor
>>   */
>>  struct zl3073x_dev {
>>  	struct device		*dev;
>>  	struct regmap		*regmap;
>>  	struct mutex		multiop_lock;
>> -	u64			clock_id;
>>
>>  	/* Invariants */
>>  	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
>> @@ -92,6 +92,10 @@ struct zl3073x_dev {
>>  	/* Monitor */
>>  	struct kthread_worker		*kworker;
>>  	struct kthread_delayed_work	work;
>> +
>> +	/* Devlink parameters */
>> +	u64			clock_id;
>> +	u8			phase_avg_factor;
>>  };
>>
>>  struct zl3073x_chip_info {
>> diff --git a/drivers/dpll/zl3073x/devlink.c
>>b/drivers/dpll/zl3073x/devlink.c
>> index 7e7fe726ee37a..fe8333a2ea1ee 100644
>> --- a/drivers/dpll/zl3073x/devlink.c
>> +++ b/drivers/dpll/zl3073x/devlink.c
>> @@ -195,10 +195,71 @@ zl3073x_devlink_param_clock_id_validate(struct
>>devlink *devlink, u32 id,
>>  	return 0;
>>  }
>>
>> +static int
>> +zl3073x_devlink_param_phase_avg_factor_get(struct devlink *devlink, u32
>>id,
>> +					   struct devlink_param_gset_ctx *ctx)
>> +{
>> +	struct zl3073x_dev *zldev =3D devlink_priv(devlink);
>> +
>> +	/* Convert the value to actual factor value */
>> +	ctx->val.vu8 =3D (zldev->phase_avg_factor - 1) & 0x0f;
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +zl3073x_devlink_param_phase_avg_factor_set(struct devlink *devlink, u32
>>id,
>> +					   struct devlink_param_gset_ctx *ctx,
>> +					   struct netlink_ext_ack *extack)
>> +{
>> +	struct zl3073x_dev *zldev =3D devlink_priv(devlink);
>> +	u8 avg_factor, dpll_meas_ctrl;
>> +	int rc;
>> +
>> +	/* Read DPLL phase measurement control register */
>> +	rc =3D zl3073x_read_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, &dpll_meas_ctrl);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Convert requested factor to register value */
>> +	avg_factor =3D (ctx->val.vu8 + 1) & 0x0f;
>> +
>> +	/* Update phase measurement control register */
>> +	dpll_meas_ctrl &=3D ~ZL_DPLL_MEAS_CTRL_AVG_FACTOR;
>> +	dpll_meas_ctrl |=3D FIELD_PREP(ZL_DPLL_MEAS_CTRL_AVG_FACTOR,
>>avg_factor);
>> +	rc =3D zl3073x_write_u8(zldev, ZL_REG_DPLL_MEAS_CTRL, dpll_meas_ctrl);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Save the new factor */
>> +	zldev->phase_avg_factor =3D avg_factor;
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +zl3073x_devlink_param_phase_avg_factor_validate(struct devlink *devlink=
,
>>u32 id,
>> +						union devlink_param_value val,
>> +						struct netlink_ext_ack *extack)
>> +{
>> +	return (val.vu8 < 16) ? 0 : -EINVAL;
>> +}
>> +
>> +enum zl3073x_dl_param_id {
>> +	ZL3073X_DEVLINK_PARAM_ID_BASE =3D DEVLINK_PARAM_GENERIC_ID_MAX,
>> +	ZL3073X_DEVLINK_PARAM_ID_PHASE_OFFSET_AVG_FACTOR,
>> +};
>> +
>>  static const struct devlink_param zl3073x_devlink_params[] =3D {
>>  	DEVLINK_PARAM_GENERIC(CLOCK_ID, BIT(DEVLINK_PARAM_CMODE_DRIVERINIT),
>>  			      NULL, NULL,
>>  			      zl3073x_devlink_param_clock_id_validate),
>> +
>>	DEVLINK_PARAM_DRIVER(ZL3073X_DEVLINK_PARAM_ID_PHASE_OFFSET_AVG_FACTOR
>>,
>> +			     "phase_offset_avg_factor", DEVLINK_PARAM_TYPE_U8,
>> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> +			     zl3073x_devlink_param_phase_avg_factor_get,
>> +			     zl3073x_devlink_param_phase_avg_factor_set,
>> +			     zl3073x_devlink_param_phase_avg_factor_validate),
>>  };
>>
>>  static void


