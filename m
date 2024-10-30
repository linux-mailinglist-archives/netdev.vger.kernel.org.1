Return-Path: <netdev+bounces-140289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CA69B5D85
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2755B216BA
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6621DFE16;
	Wed, 30 Oct 2024 08:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ec18hzmJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BF1991D8
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276481; cv=fail; b=A+bFSYs02bokuD8PNhKza+sTv9zUGsWiIHwxsunY3J7ZEJb5D6eFBzfmYl3eiD6IojUDV5mbJae6va0f3o7m5ZyMx5NoShjIkdWKlnI8ICaXx++QaHz/Fj8lLM+srsL4rq1tVBvjfM7YLlSPOT5i6Gyb8ql/4nOeif4AB8F4lXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276481; c=relaxed/simple;
	bh=w9uNtI4OgdD6P1tT3cjH6Z53j0pw+sNw+7rE78VNuYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LopxdSSCMNaA3Uq+Og4aMyv0bNp02e1rbzTOfFD3X9jncINOM57DVbpQPIsDM93U3e+muyn4Z4/TOH0UMnOHG8TyUzQ8B6WlMLsxOLzNUajKYmSsEGx6vU0+KQEXpfCEfeOUBuiDFW06qN/rxcB7TDgs5Jio7f8s2AVK+qqhuvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ec18hzmJ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730276479; x=1761812479;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w9uNtI4OgdD6P1tT3cjH6Z53j0pw+sNw+7rE78VNuYs=;
  b=Ec18hzmJ34tB4N/zwE/ymygPvQWJdfOxeANzU0ceHa3F6d6mb5N+ZCPB
   napkJSYX86aRX41xpx2U3x17ontWoQDdiwFuYmsW1BCfU9LkA2G25ehVd
   lBSaVx9Lg0twbZLzkNnYn8cCUnIMP9Pqc8rV07T0Z6U0FHUWzmB2rlXML
   JiHQW24wNKABAn0JqPrxBBHl6n5MgH4OKG163B8+64utLSx0Ii9KtXvkt
   AsmrxlFPDk2ZmalrggJsoZHTh1wT0IJJcy3elnav9ry98MeCWPaylHr6X
   P5kPyNsnfo+zpFChv6UdcOgQ0Wij62BbVkt/BLu7gTWzWxHqBKkkiQDeQ
   Q==;
X-CSE-ConnectionGUID: sum/vbwxQ3C4piQgkc6NCg==
X-CSE-MsgGUID: 87N7w/cDSs21Uw+KUeWA0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33761256"
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="33761256"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 01:21:18 -0700
X-CSE-ConnectionGUID: pxgnuoRMQqyABUG5ik+q+g==
X-CSE-MsgGUID: eRl0IugeSd2Pt71KY4JGhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,244,1725346800"; 
   d="scan'208";a="82337556"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2024 01:21:17 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Oct 2024 01:21:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 30 Oct 2024 01:21:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 01:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjv2NvDtZSZdJyGOL+rIvn3rBgzEgkRK77vaIU/Ht/Mn8CTbX7rvurPvMWTb/V4GMxVzetpMDq1sFhSihnlOCtg/3SmfKMRBrs3/lL4VCY90jRKitOfxpTsicn3LbgxeOWtVBlMvtrH61cBdhhSQgLU0RKzAw5q0hpHEOMwYkj+7l8mIjQAZcA3p/6tdzksVgrxB7QaTwc/JaB9LwaHOnIAM/kSeJxLOBpX8rT+iv5a/+SL0V5yjNp7+fTNEwXrXlBejsWkOFPrAmOj+DoDyH8fFdIeZmX0zIBhfCYf6ga2gfE+RZ/n4SHumM7CdgAUImfDFbPI+LbGMEQKgqRyFDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwLKMpLf+prqszJckITELIvAzh8tq+jlx57TMfug71c=;
 b=QmjYzNbKDuvI6t++9XZ0VaiadDsjnlLhOk0dLTWrw/s0n5hy5KB+D9gN5D4VuaLKFkkTFvhHnTurW0yiUdstWw7DRQXZKmvzY0Y+b0AFX0Vn480u8duXr3EizsedJ3PWdhrrjLKOyZeX5qxUJPfcZISA/yHV4xoHwCh+WW9AsewH6mRCJQsMGscYKQoBw5hZPamFOy9FsT3Sjrg2tHDEuKahG7iTSppWSXTEs+Z+ksCYXVK8AZvIYX184AOybKO1XlC3yF//y3rllWZgAk2HpTXeN2OC8aVv8jcPW7ULa6BvfxHcd5j9dyValvEQ+fcrpsT1+qKbX/MPLZ2NFn12bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com (2603:10b6:a03:428::13)
 by MN0PR11MB6277.namprd11.prod.outlook.com (2603:10b6:208:3c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.19; Wed, 30 Oct
 2024 08:21:10 +0000
Received: from SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5]) by SJ0PR11MB5865.namprd11.prod.outlook.com
 ([fe80::b615:4475:b6d7:8bc5%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 08:21:10 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Kwapulinski, Piotr" <piotr.kwapulinski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kwapulinski, Piotr"
	<piotr.kwapulinski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2 0/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2 0/2] ixgbevf: Add support
 for Intel(R) E610 device
Thread-Index: AQHbI8ePvUgZqSWvBE+EAUnrywzttrKfAa4w
Date: Wed, 30 Oct 2024 08:21:10 +0000
Message-ID: <SJ0PR11MB58657BF0EB30A7EC322B38728F542@SJ0PR11MB5865.namprd11.prod.outlook.com>
References: <20241021144027.5369-1-piotr.kwapulinski@intel.com>
In-Reply-To: <20241021144027.5369-1-piotr.kwapulinski@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5865:EE_|MN0PR11MB6277:EE_
x-ms-office365-filtering-correlation-id: 9732516b-41fe-40c6-d664-08dcf8bbcf65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?y90vcDSRMK583JbdzuOuVegg9KogcU/vfJHXcuLVUclGKUbE/pPUtfHKK2ih?=
 =?us-ascii?Q?rmv9OxUj9llmPlV4vzDYoaLrNFKX+V5OquSNDLYINkaZEi+Q23uyxIbY7zuY?=
 =?us-ascii?Q?k4qUijiVAEpkkqWyLjt280s49wRC+WQK5DYxASn3Eh40oRRZmJXlB8FcZcJ3?=
 =?us-ascii?Q?ed1Rjcpx8eYfeQf2rgY+5kPouVsoh6QSYqZN4A9g+oPTYWW2S5jbyqSfHx8K?=
 =?us-ascii?Q?YCKRHeG9C9gspgZCgyl2QZ2VR/wJDgmnSWEAKKCEFpRT+CtpBKml0W6G8uTe?=
 =?us-ascii?Q?5E6Hvt6mOY8ZFsCx6r0kiQkuBz1r/bK2N5Ibu+krBxOnzjp8OX1NJLbLpNTx?=
 =?us-ascii?Q?arTYRXNXBqhnzAUygoYHOIYwyEuy76KlBYw0v/xOY9HiRYp0chTtEFhL9ozx?=
 =?us-ascii?Q?AjgjtQpO5li7Begsu52AvHNS4hZvt9XVGvsd2EzUEKaXKDyaLoCvjbkEwHdo?=
 =?us-ascii?Q?gu6UYDTVlxhP6EFCO4TsafVLCwqsAitzV/XLGYonHXWavgW1ftajY9ooeJQ6?=
 =?us-ascii?Q?X1+NLA3/8L0JQLwqlLu0/PKxD72uV4EX4Weybo1jW5z1/0AR7jTrueuAHSmz?=
 =?us-ascii?Q?Jc1buzTkmACV/q5QmdnUaKSEXBDhuEYTfDMHThn5SR36B8RmZkk6704w8MyK?=
 =?us-ascii?Q?4FKFw4l4aDiRmlVv8RDmnbOT2wegPebC+pNpT0LxWXEWcyLcinSGmjIUp8U0?=
 =?us-ascii?Q?Il1Tm1wvZZ/F9U4oWuy5lUuMCtNNhBMvS4dFcm1siFJvuLqcK4KJ4hu+uVgO?=
 =?us-ascii?Q?TfXt8yas31ihTsowNDmvRMvOtpMvRNsqJTCqbXDqpK5+jaey454LnKj6DZRU?=
 =?us-ascii?Q?qItU53vy1f3x2LPrWmB6fpLP8efJwdjEGldm6rkvULACTwBohhBMy2xLiPMS?=
 =?us-ascii?Q?9Al3xKexpRScutT6vNDzvV/dxh+jgdG7yEw3sQhV1PmnO5CgguNgQJtc6mKi?=
 =?us-ascii?Q?nLlbegjMnyiqBzCwdxNvxiU5ZdbmuhNL23ZcYQAJzLIQfyEdwB5D5srbF4js?=
 =?us-ascii?Q?2oOJmE3/q0YCx+h+UCfgxSxc91OESxspi249TmR2DzdosTBIngahKlh3Pv2B?=
 =?us-ascii?Q?2vfXzGJD0BsV0L1y3smYW9EJESNQu9EXdL9XtWEo+4mNKuDDBynbCNc8kBRz?=
 =?us-ascii?Q?LFZ+kDdA35Dp1T1erRaJt/ufqzc+OhxSOg9abjYT8892h5aI/EN9DWAhrYmd?=
 =?us-ascii?Q?crdlzUjrebR5bsn8GLFTKwQbH1Uw28LPSM9gv2hXDhKoZhgbbb/vHtOyYZSY?=
 =?us-ascii?Q?e4JIzWKa4wYyODOuAAGzGWyQd0tMe32bJ9fAd1jX2GiqFNJM87rVJjQzf5fI?=
 =?us-ascii?Q?1ymkF8cs/xxm9jF/j4taWtL35VfZKE+qQ7b8Rp4ghj5QbhOkB1g3GbJSQbII?=
 =?us-ascii?Q?C4qHGVs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S4abJI7ViDIYhkuOCcayxTPEXn8zBvulLPLodE6uO2dTTOO4Ke/s+0dkz5/k?=
 =?us-ascii?Q?k6WbZmwiy8/d25CIfW1hhiU743tf5Mp2duBTypT0euyOw+eCHbn+2aLI7j0U?=
 =?us-ascii?Q?/qpW1aArQyARVpjvN7X/+0Xawk+l5V/yb9hL92ozP8K6yYbZQDrdZpV4agT2?=
 =?us-ascii?Q?66lpcArOHtr+wQGstx9hTr2zwp5JzSAs9yqnNnlCm3kP8WSrARrEXPuryaut?=
 =?us-ascii?Q?2VEzKSnx/LbVbFnk2Vne+iUioOIEH3KZo60rUOP7cKOJzoLdC8U+wEfPMy1o?=
 =?us-ascii?Q?2SK1IA6MtG+Z6YDYbK0MkiQyj0v573USaFgrbkUWJaxztDTPbqqQshfMR6vX?=
 =?us-ascii?Q?f7K533FOzjPW2yopKRipwD89QoPEErNpTkNNxZTfSZyoBYfFXMBXyw7mnziu?=
 =?us-ascii?Q?Q7d6lsDJEQOgABORPvbisdwDJnj0uZAjpMMDo0bWi/LibjlFneKEtNHYunjM?=
 =?us-ascii?Q?+VlyYmbvrP8l8lQgSzaRBRpGcMQ2GCeEwBZwWjiz65nccBvHAhny5nSSdf/3?=
 =?us-ascii?Q?gtxJoGpzjlbXiDCbWfYvqnhRQj+h7K9DoafZ/mFPZnTxUO44JGYXdJA7fU9r?=
 =?us-ascii?Q?daLm++tBigVtMLFeIuQoN3U0xfLoBmEmvSln0rYN8ERCjOqHlrefXW8ezXYX?=
 =?us-ascii?Q?5LZ1OmeTpT6Xld5T749NT9Axu7YOHwatu12uDid9txb/cT6o50+oreiPpP9x?=
 =?us-ascii?Q?yMz0YC3rHfR0xbJ41WJ75iCok20bmbhbnQYERvEe14RzOTQUL1Q2ybxGoWkA?=
 =?us-ascii?Q?gev6x9GLoQTfTuAZfK9dFzc/xjUQfIIb27oATz/Nky8GGNPOsaaVcWpB64qX?=
 =?us-ascii?Q?JWkGOmvCiXHmJ6R2INY+HzlXBf2HdxJR0ALMVTIRSOTpzM2XyyQBauV1u/Iq?=
 =?us-ascii?Q?Nelbe4h+jWXPI1guxZayY+nCJxSVSagnQO7RDRQtjD9D9b4BzxW/NzydPV5+?=
 =?us-ascii?Q?Gf7Xk5giTR7IO3DZGZSN93bJnzk1MP+dMuLx+/G6BYOSYr4ww1bXqCKysjM2?=
 =?us-ascii?Q?ObXBi7XigBNYScqrDvyXdALJfcTgVnu1Uq+ropemK5853rNtzUinKO0HeBbq?=
 =?us-ascii?Q?BGvn1wyeaa7WIRLQVMVwZMcUSXsky6txnEy/Txi/sZHOE6cb4I53pxzne8OJ?=
 =?us-ascii?Q?03h4a3jQUNSsyg6FQBKEWvH5wfd+OW4Q5aBYyEdDanFaWdVE32hc6QfQK19l?=
 =?us-ascii?Q?jQqDBy82+ud4vjv2i0hU8Tk13uujg6mTTAIFf/88RLY2/WILh5PUWcWm1ec4?=
 =?us-ascii?Q?qWfwJTamJmC5f48hBN1gtbHkn3gOAdHCjVtdHO3jSgPFhUmAUk5W9Jz//hBy?=
 =?us-ascii?Q?RCOB4Ou9Dj++yZjGhQBI6V4i8E3cOYV8EMwKZaA/5geP+RUpYcxe5RNp1+LE?=
 =?us-ascii?Q?p3eMT4bDy0D8PStTL3td6t4c4QAcCYR2VeXV7VXbimD9t1YdvQAOSWWWazhq?=
 =?us-ascii?Q?md0qcnL1pnNQ7yN4RjKjLxGu9Pg8cCTgs7avaSfyHC8nmjHDyJrZqODJJ96R?=
 =?us-ascii?Q?44G1Z1Aj+1UCFnRJ4TGgkfO4Wya1bhLP6629dNeUbFSXbNM3/MAP+OgZRuCt?=
 =?us-ascii?Q?NOdqGOxqAdyIHStg1IPmSLxpKKlz1fl1TEfNm6bnjnBs1hw7U7nmlHgAAS2z?=
 =?us-ascii?Q?hA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9732516b-41fe-40c6-d664-08dcf8bbcf65
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 08:21:10.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEl03kyg3A4cbAJs8FqdH3oOb1dKwOgoIlEp9+idhy9c33+D/Po3UT/AEJRWxuOGUsMJPLshhIFBu5qGweIwnm/H4GK0bUyvQSzQ8vGBaz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6277
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of P=
iotr
> Kwapulinski
> Sent: Monday, October 21, 2024 4:40 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kwapulinski, Piotr <piotr.kwapulinski@intel.c=
om>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/2] ixgbevf: Add support f=
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


Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>



