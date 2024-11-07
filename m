Return-Path: <netdev+bounces-142704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C879C00C3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 10:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A1028332E
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 09:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295CD1DC1B7;
	Thu,  7 Nov 2024 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmUaIqtr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD15194096;
	Thu,  7 Nov 2024 09:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730970107; cv=fail; b=FNtjaKKgBYEFiiXEcOhaGfYoGusOtZwTXzZ5h6sZskCG87EtwBwKkqOHxDvcQpm4r6hgqu6WpZW1nb5+XEF+G7CwM69YwkvyAN25FKoRLCNts8W0dX5/z/7qMH0NnlRujWQIq8jBPt2RxLD55gU/4rGL1l+YWn30GVuJTnyJABQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730970107; c=relaxed/simple;
	bh=mwRL60vj3k+FyemK6R/8xJ1x2i5fG+BDExkOAbCaZnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pze0kwPFMlnilfIwIoIDgtiXVoEajnjXDPFBJMexlUWApQtHzHGhWFBkMTlAVdVdmXM8VBL41FWuEUBa931qzkFS/cmWWlJObS/0ifOXJujc0IkDlOoC1zZZHAvWUmT/lhkZM+fBcg+mVw8UCJthnOr1ddvNxvEbxYcxQ8qcnQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmUaIqtr; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730970105; x=1762506105;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mwRL60vj3k+FyemK6R/8xJ1x2i5fG+BDExkOAbCaZnE=;
  b=jmUaIqtrXFiEtvikoTSnGmy8BkioyrbbMkjReU73ucYUMi8TIvH//R/r
   Go/+si2HPSN37PCF3CbSSEwKLF6LbJspSNo4o0hQGwS6QE6DO6ma5ZMX/
   EC8vam2q/NCWoeJb/CLSSZyMC5ckFY1/k00eJ5QTs/p0B5koMsnjLpaih
   Fd8ix9/DWk8uKEbqyIJ+TtApmI+VycmPMiufJxjgJlZjOrDDXFbOJWCpP
   mi2Nn2a+Rul4y8Ia26ctDZ0XTgg3IpyQb9a56yzI/Pk8ii2MHAAYh3ZZp
   eo7qtx+b9q9liBgo3v8jV7NAoCiPfG6ggkiFnTfnXpGqmTMp9HaroC+IC
   w==;
X-CSE-ConnectionGUID: gIWn6ML0T2KmwhhEamHNBw==
X-CSE-MsgGUID: rv/cGQDiTc+9ChJIwJifdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="56199842"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="56199842"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 01:01:44 -0800
X-CSE-ConnectionGUID: hmAGz7u5T3i/Bo/1QHwiWA==
X-CSE-MsgGUID: R01j0SInSfuTjubPwQ2KNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; 
   d="scan'208";a="85787622"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2024 01:01:44 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Nov 2024 01:01:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 7 Nov 2024 01:01:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 01:01:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMAyAVc+8EnnuoBBVWTSVF+XHeDhuYITE+ctUQ9mmhWEjsRCjZ3br0EFD2p5K6twclj6TInKhXzyRrYNp5/knw2+ikFQ7gRVZYSeNwioOR6FaeI/0XeTk/xJPyAoBtdXP/dunxMB2Iu0u0q7THhhmIePi0Nt4YK8LvanzP3NVtYLx641r17h3p7T4XmSLlYFVfbD3ZXCBBLaAUaH44GBr3xmzAVMiJLIJekBBi5xdmqkoYAqH11YUj/PSWi4phNVch53MN5iVFDE1deLTQTrXuP/2gHciSTfFAB9k9cKBVql2S3/jU3Q3cG3Hf82ZIuEL+CsFmp7eyaunPrZNnn+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aE3CGu2u9sj/MoaIxXcDfz5iRa3EiyluNo5SeLIZ8IE=;
 b=Yqw0gxDZL8V42rUT5NbhwsLcHGcP2hcw42hPhPPUkP0kwLLQum7gNROat1OGFAzrLb1STfFinlrQssSQe1SkjboUyFFsnl1FMdwytbCdQOyat3keSaDWsNek07kwY2Gqg32WsXunEshtppEvllVLW+zzmguk/P1oS2aCGjILVdMwa5VjbVD0yRlXtMEouBaC0tHRgUHQXBkGCvqUDmeP5zgVZNpRjbsP55FicNWO/++3jkBRcfgsGFIen63uNWUUcc7vtMXtDDXhdvC85Vip/vBOBX9D6TpfKO82I9J1Ilu1cfCR4TZMThuy3JynCGIx1ZtwidGk4s/NlY7jQWPQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4664.namprd11.prod.outlook.com (2603:10b6:208:26e::24)
 by IA1PR11MB7270.namprd11.prod.outlook.com (2603:10b6:208:42a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 09:01:41 +0000
Received: from MN2PR11MB4664.namprd11.prod.outlook.com
 ([fe80::85d0:c2bd:72cd:dcb7]) by MN2PR11MB4664.namprd11.prod.outlook.com
 ([fe80::85d0:c2bd:72cd:dcb7%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 09:01:41 +0000
From: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Subject: RE: [PATCH net-next v3 1/2] ptp: add control over HW timestamp latch
 point
Thread-Topic: [PATCH net-next v3 1/2] ptp: add control over HW timestamp latch
 point
Thread-Index: AQHbL+kBdxMULec3CUCOhZKxJSm9MrKpgLyAgAIGc7A=
Date: Thu, 7 Nov 2024 09:01:41 +0000
Message-ID: <MN2PR11MB466441745C8C1D64835C51739B5C2@MN2PR11MB4664.namprd11.prod.outlook.com>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
	<20241106010756.1588973-2-arkadiusz.kubalewski@intel.com>
 <20241105180457.01c54f15@kernel.org>
In-Reply-To: <20241105180457.01c54f15@kernel.org>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4664:EE_|IA1PR11MB7270:EE_
x-ms-office365-filtering-correlation-id: dc9ef506-6d70-4da3-148d-08dcff0acba9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?9B0bqEGOub0R2yORvPiaQ8qZufT8sfoJKdslqLw+LCLFbQcLjTl9wgWb+LYj?=
 =?us-ascii?Q?WJCcDO0JvlUFFqba1pao3b5vRmnVXPNgeDJsg0RAKzAISsPUbqefa7qak2VF?=
 =?us-ascii?Q?AzXUS0HJcqkQ/qHSlxa4w7PqPJW/+DKkAum0i7iRqjC9K4tSJ1D3IKPyomkx?=
 =?us-ascii?Q?wcjzqaJnKDHhmOsCp5p4aVx4+RmO69V1d0dlvm0AP9QhbEXTmtFKFvubmSet?=
 =?us-ascii?Q?9+H6NntgVxa7ii1iJMZPXIsAq1/MHU0K32wmTs3KZPWV0esa1abaapZ2XJT9?=
 =?us-ascii?Q?sLkK8mxydPKM5Jr/AXddEKz7mx5CuEd/I7VUReX0qbYVMKNUa/GuKs5xevru?=
 =?us-ascii?Q?rjlVuht7OKuG2l/lWLdR5+EBwbx2r5Ho5VlASFdxEsQIPS1s+NRoYjZ0aeax?=
 =?us-ascii?Q?+WufpbDgUi/K6Z+EzEv7ao2RaPIhgBIbtIJRS5LKNFZ9eTQSjHfhVGlHt7Oh?=
 =?us-ascii?Q?IUr2U/wjWZwDx/EjA3OO38gOWf4g0kydpCrg26lBfp/P1WMPDxvTngFseqF+?=
 =?us-ascii?Q?A4X3QlRxr7+loZ1Zkz+3obJ/yf8aFgLVG5hB2p29Ee13De/Rv08bXpesDxlQ?=
 =?us-ascii?Q?Z2DDefvuEOUzTj54tIaigrUfgD9f2nvWDH2fjMYvI/NojQ0rslq1Ge4StyKE?=
 =?us-ascii?Q?oH8x1QgNtnJU0Ir+l2kzSj7CYA+R6fb6hB45auRXgpbSpnczSI8tC6iyXL7d?=
 =?us-ascii?Q?06q+GzDGJckTLadSm+RbDxb7NI6doaE9PVNHE22ao3zDkW+BwEHxoFOyhkfo?=
 =?us-ascii?Q?3/VjQTirInnAgjmBo3iyCWbZaXcV9HgI5AVso9MdLm9NFNk27BHDllHRnsQ3?=
 =?us-ascii?Q?Aohyve9Q3XuwqgqEZ2Z6laVMBclicxXpIEGW3oq2IVFBg/+6ol7jD8ZFHRfO?=
 =?us-ascii?Q?QPTpPmRfyIu/GbLuB8KOjJoPnFW52dvK+dhOaCdWSuflCMWA/QN5wA+9I1rB?=
 =?us-ascii?Q?jfhJ2a67uRgjIAQ1wt1m9/uSL0AK4yMtHLvSuIDHAf8f/ElbMeydfcZ/fq4r?=
 =?us-ascii?Q?vAa7Ma6Oc1z3Zu4bp6rEJkRjSGzb4SB+3qxV4x0/alLhtbjsvajgeXFRXEDk?=
 =?us-ascii?Q?6TG18Hn3IpNuKopq18RPj64t1XCJJJzZ8w9beWfGSn6fXW5sOpRDKNjlFmEg?=
 =?us-ascii?Q?zGziB64p0iSracK76trmIO/Yx6hMhsSB5AevMU0z3B2u2H2a7Gy4dDHKEBjf?=
 =?us-ascii?Q?F5DWwWrGG7cV6vzMuU3ldQpWNLaa3a4NhgmzII3P6FXcv3kY6Ag2kY2U59RJ?=
 =?us-ascii?Q?IMmq28qPWQyLQnIkh4DqwbwsJuffrepN5Ct0Dz1y9kVgeNAxbbQ3nkufxWaR?=
 =?us-ascii?Q?c2EyZe3wtPykx3o4Ig5akAqYsb6BV1d3fg3QFt+gUmnne52iE0svFZnpufN8?=
 =?us-ascii?Q?X+k73pg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4664.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cUoD8oPHgRh2w+ctvmTb+KIo+0Ti6WFk4xqsAg+yhyuimVNf9PXVD918Y2L/?=
 =?us-ascii?Q?rQXTXRSqVGB8mbizd5b8D3/cZhkOSdT88LkCgabgxW3eSmV6u7sh3XGXc6Ag?=
 =?us-ascii?Q?dGbgkQJpFqeupdw5qQ5pxvbl2mGnOyZGmfZNysGZQXioH/UbZ/Ciz+uVUNDQ?=
 =?us-ascii?Q?5BEcmRlT74Djd1HD55h/HlE8w64hoA7A8Sk3FPI5ezZk1oTZRLF84YfSnPcY?=
 =?us-ascii?Q?XSG6BMv4yL7955FhiWCUnNJA+loZR1anDfqKwMw9BCr/JhQbhZm7TTDnckb5?=
 =?us-ascii?Q?r50crRkCDu8PvAZSdRLbeF6VXVCwbbbz7NfuuuOwSH6TQ8ARnNlQ8Pq0tOVG?=
 =?us-ascii?Q?6eFzDwJfHp8A0/M8cIcS02XPKXj3P8EW5LDyZTbClUDVqD3gf9c75a2DAlKF?=
 =?us-ascii?Q?Kp3xrsJdVPxZrzoNNkZiFRnBlvUJmt/g8BSL5mhJZ2V2Urwma9W7ldbGuuUv?=
 =?us-ascii?Q?K3wnIqck4ujMYQc7Btw2eandf6br2QTEDL3MePGN+zeJ4+x6T6jo89GMzVT7?=
 =?us-ascii?Q?37SRV/nmz7WpU1w6nA+CpXA+D5AzT8tx0olZvyL6XRphWE69BOYCALrlWBPQ?=
 =?us-ascii?Q?8tCl5Ik3fp1EzQxmLh7wxkBTBuC5Ek/7oNwBJw+WU5GtHtz1AQqlXdwPTu33?=
 =?us-ascii?Q?IFEAsEkyBaivf0ctNuPujJq5X+dGiuc2ASRO4hHgGflc9PjRX/gik0b/7cJF?=
 =?us-ascii?Q?tEMvYdq3Z1u98cvPgprvK1R/jSu7tMjQXQJO/BjkAVXioeTx4hyJsKADrAaV?=
 =?us-ascii?Q?VQLOepu5jB9KoSLOJ80i4Ft2iKDDWMSq/OjbHf4w/pGfEs8KLuog89QphTAL?=
 =?us-ascii?Q?PzuN0Pr0doaie+FIldH7u33kKfcSrW6m382ZFJz7q518VWcJF7SAtVKL0/8k?=
 =?us-ascii?Q?jqPcnu65eje4JzcerOjzbipOnZhfzFaI3v44rp1Mf209HaEXqHqapxjz+Ni/?=
 =?us-ascii?Q?v8F+j0KUxGYkltSv1OBpi+1OA4tbDfSEdl21cG5dduAhU1jSilz2vuKye4RZ?=
 =?us-ascii?Q?KRsrK/oa4FVlRldEP4TMOZbIKcm2+pZlrGvkXg3ifPx8PgoB5GsIdwtYP1tF?=
 =?us-ascii?Q?dTncpggJ8KmNz9KLx1x6pMpIsyTv1kbfal1W3aJq3o/X/nC71tQWh053R/g9?=
 =?us-ascii?Q?oojsuQrFCWLq7qGYacXtHEgrncXJrjHwLxJHJ7nVYsMQOv7iCO+KkKWf0zIP?=
 =?us-ascii?Q?MWTL1THsM+FGrYY8OYwfYmMAs6U4EZE4052y9pxW8xK8awIRmEnxhPrzm97W?=
 =?us-ascii?Q?B3wdIbKua6ThrwKOsmJZOZzJmJlp59n07J/LJUpiH5jZqMShsepa0lODaOdK?=
 =?us-ascii?Q?UULG4D98Vw9S73NZKsX56o9baYGhBuOCq9RxkKpZffISSGIUY9CUjBp0SHYi?=
 =?us-ascii?Q?B38EHQ846adW4Lu2HklMAkWd8lg4wHBZi8hhLZmPNa+mpdtK/LeWQQMbY2s2?=
 =?us-ascii?Q?gcLD4N3TSYc4CQ45i4TeFYTQ200OZVKfQ0LnYuroPMZkEHgq++6rRhRcDiWU?=
 =?us-ascii?Q?dxLRgqA76rG4rRPhVohsQp/kCcZcCdXF16oKTCByLe5MlLEyVL3cr3lSkmqU?=
 =?us-ascii?Q?w0NFGRlIHTC0ahIgUJNp0RO9ytTgR6qRawXL7Cl9ta4fAYJEbLxr4olrDKWF?=
 =?us-ascii?Q?zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4664.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9ef506-6d70-4da3-148d-08dcff0acba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 09:01:41.1063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EiJydy+FA3CrqeCeeeEQ5anpbfmHib4SIfrhVqMOUfUn0MITu3c4LaH11CvyH/nthrFhBI31RfidWmx3aRP62zVyo5wQh5e8Fr0Bf2NsUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7270
X-OriginatorOrg: intel.com

>From: Jakub Kicinski <kuba@kernel.org>
>Sent: Wednesday, November 6, 2024 3:05 AM
>
>On Wed,  6 Nov 2024 02:07:55 +0100 Arkadiusz Kubalewski wrote:
>> +What:		/sys/class/ptp/ptp<N>/ts_point
>> +Date:		October 2024
>> +Contact:	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>> +Description:
>> +		This file provides control over the point in time in
>> +		which the HW timestamp is latched. As specified in IEEE
>> +		802.3cx, the latch point can be either at the beginning
>> +		or after the end of Start of Frame Delimiter (SFD).
>> +		Value "1" means the timestamp is latched at the
>> +		beginning of the SFD. Value "2" means that timestamp is
>> +		latched after the end of SFD.
>
>Richard has the final say but IMO packet timestamping config does not
>belong to the PHC, rather ndo_hwtstamp_set.

Ok, thank you for feedback.

Richard do you agree with Kuba?

Thank you!
Arkadiusz

