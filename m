Return-Path: <netdev+bounces-87103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3668A1C19
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 19:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6BF1C22842
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB29153506;
	Thu, 11 Apr 2024 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TL2o0iLb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF9153504
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851826; cv=fail; b=cltJc6W3PWaPqb6a1M4JgAM/Vmo90r3EmRGGSm2HGcwOxB10ZC+C0I9qJhhPQAJDxMEDNkx6cCJ6JGv4n73at10xhZxmLp+rJy4fknbqCnTKPMb7kH35P+rgPfUOkLwuVf+kJf13T2P04CyTTTPEjwzEk1d7RujVgQIATbwJnhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851826; c=relaxed/simple;
	bh=qPyv59hueTQY94A+JqTWywDOCU3lfjlhmGD79fgooyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oO/AffLF1SDZeTx8ftvbJzCi2DSZJpP8csdxQuvG1SgW1RypNfuUfFnUSXEyoGUw/27uq9EjTI0A4leyMb/RvSK2Dl+RuZ35YiSnnwyXnbYViEIytBXYiivSCAeMqOTk82nSYgybYnXA+AJQO0/ESRNkRZKktmhAj9twncDk1DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TL2o0iLb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712851825; x=1744387825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qPyv59hueTQY94A+JqTWywDOCU3lfjlhmGD79fgooyI=;
  b=TL2o0iLbXg9MJCoMFOUEMUiQHvpIj5SOwB+X7WVkLs4MK3HR69XWuHfh
   gNr+UOnYCkQavMKMWJh919UBCvppZRKuuYkgQ9VxQBABNC8bIaBdqTE48
   H5BzMtciMQgWss1a+GL+X8ysBcDpAwqBazgNUmjd6JcKVTX6P6vYIxS3H
   Rx+fSCol5lytGGkqZ5XbUgjUBaVTSalBq3VC4SwbLTehvf03dKCSKm/wM
   S/m1xhyq+ont9l+6e0Exyb2KD1V1jQIA5xgsoxZSVC45N2JoMm8xHeF+C
   BL8v6vryR9dKXH4WQ4Q91owgv1Q8muEAV7GmVO0eXb2TqvFxa6V43yF7h
   A==;
X-CSE-ConnectionGUID: fgQkrrhjROO4Ci2paHZOvQ==
X-CSE-MsgGUID: DvSuwXxKSm6wY+UxACcO2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18832583"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18832583"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 09:10:24 -0700
X-CSE-ConnectionGUID: gwuNBxk0SLuDu13+13INJg==
X-CSE-MsgGUID: ezgykjl0SEyJKVX7rx+CsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="25730690"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 09:10:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 09:10:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 09:10:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 09:10:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T7J8Hb2EHYo/FNAjCmsMRO95KJjepWTB9Yv9QUhqlCVhRB01WHgKAOIf3Z01DAo1WXpnFVpJvAq1dl440/iLFHlF1SE/eBOsZ8z606e0nLtxw26CpJemJydTvzmEIUbDDIB0iFj8b1/LEBZgFMDpeiW8GvxrfLvlTTLm2if/BozeCy/1q621yK3YFZYMaVAKSq9DOw8xDPIwx0nhR1kIgisqjG1Qk02INhmS9wgvdoH/kI5rc75lI9KOgvCCJo3IOsEeHudKXogFJirCuviA5LAg85yfkQ8s1rE/8Krmfp4HN04vG8gtnpc9JS9LGBME/J1R/e+RWCblE8WW/5kCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMrv0A4AgJt5+F7RcSCxXx2+SX9DsvRMqmLVgJfOPd8=;
 b=aKIbAw2lNW5UAfypVthtG8nlDFsPn7StAv7i5zdduErT+pzjejYjVALEhUwHQ7widCqBBKWxc3RpgQuY7NdqrLvTCaczXxuXjzYnxu3EfLGLhIwhxrWH6A/OsN3gBksUWb4nOrBsBtFh69RkWhE52Phiam1TMrLNS1/6X/ax88LGfnF1oGfq/YW8tN4Y6DE1iyE3bVbTIEKdtzbdh7Y9TClNQCM1n+ObcvEiUtvjtsZpUeIuxj45WzUZ5Ymt/J1Rtm5SVi7Fw9x8cMUg39Sg/aooVgylwDhrPnazB6ACFuvVrFEkkOaSb8kePMnYqzGUhDhWzS/jfpcPIP0w8gUesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6324.namprd11.prod.outlook.com (2603:10b6:208:388::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Thu, 11 Apr
 2024 16:10:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 16:10:19 +0000
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Louis Peens <louis.peens@corigine.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Fei Qin
	<fei.qin@corigine.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"oss-drivers@corigine.com" <oss-drivers@corigine.com>
Subject: RE: [PATCH net-next v5 2/2] nfp: update devlink device info output
Thread-Topic: [PATCH net-next v5 2/2] nfp: update devlink device info output
Thread-Index: AQHaizqIVNYpOCRLX0mDCxkPR1oW6LFiFg0AgACDtQCAAKUKMA==
Date: Thu, 11 Apr 2024 16:10:19 +0000
Message-ID: <CO1PR11MB508971B64D360D27424F9E3DD6052@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20240410112636.18905-1-louis.peens@corigine.com>
 <20240410112636.18905-3-louis.peens@corigine.com>
 <fdfecdb3-2070-40d9-8129-01df41d4232f@intel.com> <ZheAxsfnbF0lBK9Q@LouisNoVo>
In-Reply-To: <ZheAxsfnbF0lBK9Q@LouisNoVo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5089:EE_|IA1PR11MB6324:EE_
x-ms-office365-filtering-correlation-id: df1b58b3-864f-46d6-4316-08dc5a41e25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rt616qEkOsGGrBHhRNMIdxPPnJsErjSWrYD6xMB9cm3ZTcXiEE2+9ej7HcOm4/SQWXHv1ivTlwo0QrQkOJuIB28M8hWy3rYCYYcfk1NwHgUMODxZ3GbpRVAX3Zcs+3tinElqWjNtDC69h8a15DFgVyqzGslErtMILeGNBgoiGsAN8uPEMmRtEp70E6b2clVPlNXN/NTwcOKL9MPS6j7pNBr/ePfYOWIk0B99Ulxeido1x2MVqo4SwkDOQdqHQFvIMeWCqpjLxQ19Gmju+0UQbqL7myN73vPAeVqYvd0oFZziBXAhh4/hVOLPlpidUCHB8wi9x0npSpVXTL+zJcw007LeshFU8gJdX+6+kRHx0WR9A0PQk0rUAIbDuBakypmsqo520sAocVwL7T6Wh98KWcbNXDg42neiDHftCF2VV2X/wlzGAiv9Okgm0Vzuy4EIeFU8nQ/Ip/zPn3oRRYSyRAokdVETFelwTOr98Dab6+uM7eIEj+fTJ3hI6/3ApO0IdjY/n24++6yGGH2efcG5JNTUj9Fwct45Seu+WBOTul/rGBSa79wswoRz1NKWG2aDwzdv5uWhLu68A9Oh1vIbM8jmSycHKkWD0fZB1fD1uz6D4j6Sxlfp6ebqm94UA3uQIpXdLzPmlXGrnWL0KF74Lo49TPEUsR+Ilx3+mimZ9lir7IlBpfZ1psqMfwKo5tlufQ+5rk2l0LbZ5OrcJ1Ict5CFEMiEbwg6HALno+CslOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+C8EMlikQqJiaWonhMkSRcTJAknpASNXvR3oSRzKYbP787yT+GwtL8Pq8H0V?=
 =?us-ascii?Q?P38Tn4+4ZRoiZlsuLGxpFBahl8RqoH18+xKAqsPck21h+tcE1pNmGpayiuT+?=
 =?us-ascii?Q?0zj4TWuZTnh4m3CPe3B852w92yoG3vU67paUqkojOC+pPDNiFUsKrfWNOhdl?=
 =?us-ascii?Q?2BC63jYHYt82ILA62o5ifayEU7zhbEZjoELEzSuylTFAwfEmalY3duGFSygH?=
 =?us-ascii?Q?eMNc+hIqDjqtYOh+BmOw/ptzCUZytrGKvA9g771Qnmcdqzr8mfgfRf5W6uO7?=
 =?us-ascii?Q?HHRJor1fei6k7Axq4Ifj42zfn+e2n+isXqEmnz5jYze3dFL0h+FLAARxmKcI?=
 =?us-ascii?Q?I7JOzfuNiha7c+JzrlepKIuzYyuVq2bp+1191dzQb3xeoNZHsVbLhK4qAc9B?=
 =?us-ascii?Q?YD5Nq0VKNhqSppBhHl7rTFPKlIylxmClzJ/xgHeRXBHq4f4mHBpvRlsycGu6?=
 =?us-ascii?Q?PpvpCz+KEAJVHYzVZt/djEByayJR7V7x5mTQ/qQJ++0TcwQ51/UMTsC0VXLA?=
 =?us-ascii?Q?Rt5o6j+MKGoeMNZNBZvnHvucR9zAMHVC8aO1UIeVUt/F4jBtH+ifg4/t68KG?=
 =?us-ascii?Q?QZwklJsymyBg3R9USkPbl0J/jdriOUDlwCjhaIuNSXChlmb7OvpJT4PbTA78?=
 =?us-ascii?Q?3v+ngNs8UVJ14u/mHjWf7ft20yWwO5dM3zoEE5/jDrS8k05j2hBUGR+s/G6N?=
 =?us-ascii?Q?uWV2hl0Dx8Gqu0k2N3mGnN13Djed0O8rNEaGQyXzB9ckzmpdal2rqKh0/812?=
 =?us-ascii?Q?yMQnCnYHWkcXd1RH/GgbEjy3raCMTivUnDWrHCWvSLcGa/NlnKcRbSHe0PGh?=
 =?us-ascii?Q?kCE5gS36wMCfPYo0hCE4Hc5GE/oVbU0vsDUcyZudZz1OYDDkMCnoOt4QdZbl?=
 =?us-ascii?Q?aTR6D5vqyfkzhkLzeen/dDV3m5XRx8lw7qQRH44/Cuj2lERwr0wyj7dBJ0d3?=
 =?us-ascii?Q?2RLoKzBdkNqKe8qU7MCbBPVgXhLnGjLCc3iDelccg0BwTFa/SwL2XG0/AUCT?=
 =?us-ascii?Q?yfozSucMelP1HmfQIV30ir3pDYRKPo2jev7jxdvYEGMtM0wdCXtafklnhswC?=
 =?us-ascii?Q?AdcC5Qw7hv86FUulA3EB50+wuMH/PX2Xp2Qccxl3CcpsVGB/e/+Kj2LGEgPX?=
 =?us-ascii?Q?cClwBCQQ0PGGI9hn/G92+OAKCMbioakS872XKPFs+Ojqcrz1QGQ4CjgdU6/v?=
 =?us-ascii?Q?iamLKG3vptF2ay3/yIaZ5o4cGs3glsYWKaGpYEijksQFU7o9HedoMxmwGgxE?=
 =?us-ascii?Q?+/LzYa1XEvVQiFTydHZjIkQKScC4z11tgRcjWZ4FzpWnc9BZ3pXowzUwLdFe?=
 =?us-ascii?Q?HRi1QLK50Iig2XkGp0dPNg0iT4eBdcd38+eJ3FU8fgIbhKMiJqqlwgRWcTKm?=
 =?us-ascii?Q?S/wkttT/RSzUm4mpqQfuFkt6UxJal9fxjD9F+Hqj6uDTvUIvJGdafFOq/exd?=
 =?us-ascii?Q?HfFDUO2OAyeRRCM9On4reemzYlqjWnHPs31ySjf0DPPYS4orNcyDTirybIC5?=
 =?us-ascii?Q?VLkndg2/fUyymzo8887IGJWBb9C1oXfo+kaxtGEKhP/1H85BJuHUc7Gx/XUb?=
 =?us-ascii?Q?CMzlQ8wS9KpQswkM4r3Yg2eJYV80xVTbRGBwdB08b8WvXnW+F+daHzDkW97O?=
 =?us-ascii?Q?sw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b58b3-864f-46d6-4316-08dc5a41e25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 16:10:19.6425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BduUh1OPQtZPrmbFMlC8eYlsmBzFx6McBUmtXV+nB4E//rWz9XurLARSCp2h4DBofACGpnRu8lByRlhB4/GbqwfS5YC9fuEMZHxUpy3Wjfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6324
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Louis Peens <louis.peens@corigine.com>
> Sent: Wednesday, April 10, 2024 11:19 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: David Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Jiri Pirko <jiri@resnulli.us>; Fei Qin
> <fei.qin@corigine.com>; netdev@vger.kernel.org; oss-drivers@corigine.com
> Subject: Re: [PATCH net-next v5 2/2] nfp: update devlink device info outp=
ut
>=20
> On Wed, Apr 10, 2024 at 03:27:22PM -0700, Jacob Keller wrote:
> >
> >
> > On 4/10/2024 4:26 AM, Louis Peens wrote:
> > > From: Fei Qin <fei.qin@corigine.com>
> > >
> > > Newer NIC will introduce a new part number, now add it
> > > into devlink device info.
> > >
> > > This patch also updates the information of "board.id" in
> > > nfp.rst to match the devlink-info.rst.
> > >
> >
> > I was a bit confused since you didn't update the board.id to reference
> > something else. I am guessing in newer images, the "assembly.partno"
> > would be different from "pn"?
>=20
> Hi - yes, they would be two different things, approximate example for
> new images:
>     board.id ~ AMDA2001-1003
>     board.part_number ~ CGX11-A2PSNM
>=20
> Old images will just have board.id. The field naming we get from the
> hardware is indeed slightly confusing, but since they are used
> differently we could not just update board.id.
>=20
> I hope this clears things up.
>=20

Yes, thanks! It might be helpful to include examples of actual values in th=
e doc.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Regards
> Louis
> >
> > Thanks,
> > Jake

