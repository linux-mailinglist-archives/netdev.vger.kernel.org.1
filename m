Return-Path: <netdev+bounces-111431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2423B930EF3
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3875281301
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 07:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4F2B9B9;
	Mon, 15 Jul 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUKbLcoi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CAB64E
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029075; cv=fail; b=IE5WxkqQlRcyzVnDUZyEAesAvBkirLGGTUbRcLpAvAvDXySfNjdXxLfSzgV2XIcOm8JK8GNjvemZ7zY+Ipw3J0b7mGdLfgHZLG2AhcRxBAk+dX8pQEDZpY/pPCs2ShKTihVyoCI4Wo9Ckx6fNrhDWUZa3Vt6LgbhgIATb7l6aSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029075; c=relaxed/simple;
	bh=GzEb7cL4g2lygqFKiBT9pMR06dd2xy0li+zvSzkIRfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GKcmYzjrV45hxNlrxCJpSsjNyOkvCre1GdSlRT595wTU/qbeizJOw8w39AJOt4Nb6amiJRLQHCju4+ND3qRpuLtA3VRdNMaGZNm1mzJvN6V9D7gZsDKXjdYDW+4qd7fmpI6X2Rfp/siNTvRBtbMScv5nWlxL6mBE18z5ObDzkCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUKbLcoi; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721029074; x=1752565074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GzEb7cL4g2lygqFKiBT9pMR06dd2xy0li+zvSzkIRfY=;
  b=nUKbLcoiuiPc3x+MFpSTcq4vHUMXixHKpGtdZcByaBLOg67JFeq1CHp0
   7h31+R6ob6vNaa2AI6F5zrUMEFmEpoHXXsc3ZshX7zEh2Me/rTa3ca5US
   TKazB+bd+tJo8czAqEu4FtoncCOAPOD719IkQN8fIA7Do78chaPD0/rG6
   jVpUBV2YIa+wtFLnPiAKEY/glhSuHBoQwvt//75WEb12Z1uWuT8ozjTz9
   28LtRyc0J7cQT+CW4dHeVFrFwLWwhTVDjSa9iTiP1kaDk9Frg7aj/Vlrh
   EgsAn++lnXaFfwdrS3lMzjQ5RJyYbMv/l5jCqyl8rMQKw7YuGL+MGnt/5
   w==;
X-CSE-ConnectionGUID: cWzriHl9TKiQptZM7gcUPg==
X-CSE-MsgGUID: KWL5sEONRYa0Jy6SvJEhsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11133"; a="29803686"
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="29803686"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2024 00:37:53 -0700
X-CSE-ConnectionGUID: 2ypn7L5jRdO6Y3TnJpq3Ow==
X-CSE-MsgGUID: i1DsW4PBRyuL3DGyUFiMlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,209,1716274800"; 
   d="scan'208";a="87039270"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Jul 2024 00:37:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 00:37:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 15 Jul 2024 00:37:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 00:37:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 15 Jul 2024 00:37:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fIvVukNDOGaZnMKoijB7qSqm0DpScjeGSkTcDF0SN2j584Jk48frFcosI2SWmTYUqoayCgv0cmNOGJqASuoVsr2mD44zR4oFNgxji+RP5zs/mzkt+4PJNZ2EJhCCj6zQQqlR5hcImX8JgFlWhulBwmYPoUmFKpdVC8JStcfW1sGioVB1y93qmvz+EAeHiXG4MB4taXPbZMbSxtGsKxsgu/z71bRGxsGBqcITJ8fcDms/26dylnTzfekK32GgfYbINf5sR2oEbSmTenI2Wak/5Fds3SFDOjuUUdAc9obozEdCNkiTIpMaNjOHmLXH4ulHgXBqeV+8f1ILjjhti+yIMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/s/DePVS2hjTCByLUF9qt7ZVh8arwkPMEhv0jPUTEY=;
 b=Oe+dAN/07Ty9a+GjELNDyln9mMFSbVzSGcdjVCXXX7f0rHqPAd9nIDDK0LTXCCpw2B75b5Y6Vskc7VUsGvPfURkJ5Z0VxW1+2lrqXDtsptSKQD+QsMIGItU9fXZ+rFFg1swJ/+hroeq8ihgMDY3AjCo3P8cpQnRUMjwWQENaiajdYtxpjUNN7Axdrl/psNu/EclHXgqbO3GW9tqjFXOmt7Kd8VS27CEeI1mp+NXr/MdUDzToJTZAW52Q6Hu41oF/UPTLavIDOeF6LMVNQAwBSPAH3V3GFIWJICwCLLste3SYuyt9VdU16skITcarZ2RBxhsmUKYCFL20i/xoRfalIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6266.namprd11.prod.outlook.com (2603:10b6:208:3e6::12)
 by PH0PR11MB4982.namprd11.prod.outlook.com (2603:10b6:510:37::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:37:46 +0000
Received: from IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb]) by IA1PR11MB6266.namprd11.prod.outlook.com
 ([fe80::7f3a:914e:c90e:34fb%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:37:45 +0000
From: "Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Michal Kubecek
	<mkubecek@suse.cz>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, "Samudrala, Sridhar"
	<sridhar.samudrala@intel.com>
Subject: RE: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Thread-Topic: Netlink handler for ethtool --show-rxfh breaks driver
 compatibility
Thread-Index: AQHa04fohQ1gdP2GFkOu9i09r6WheLH3Pz0w
Date: Mon, 15 Jul 2024 07:37:45 +0000
Message-ID: <IA1PR11MB626638AF6428C3E669F3FD4FE4A12@IA1PR11MB6266.namprd11.prod.outlook.com>
References: <20240711114535.pfrlbih3ehajnpvh@skbuf>
In-Reply-To: <20240711114535.pfrlbih3ehajnpvh@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6266:EE_|PH0PR11MB4982:EE_
x-ms-office365-filtering-correlation-id: e954c737-f868-45a3-e662-08dca4a10475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Id9e+W2X95xFc9OcerFonSNJQRsggJe1i/m9NX/EQx4wJhK3VfVJ56r5s5Wp?=
 =?us-ascii?Q?RJzs4vw3saSAzkXYj+6zB+ITavQQfALk33U/X/5QtpqYTyD39hhrOj2kpywW?=
 =?us-ascii?Q?pDfzx2EXxX0xl/eQ9I8TiFyfChdK7eoPq5gBAAY+kCb3P8cY5j8GD4t2NeKy?=
 =?us-ascii?Q?qa3CC+ymhUr3I1FHjlwIH+lHKIgF6aZr9gxjgAjz/MmcXG2uY8Wae2N8d9dR?=
 =?us-ascii?Q?OsCKFYv9/hA48N0kmJld98P/52Yvtm+1xj3e3RpW6dwbe7c9B353nbQwBMx2?=
 =?us-ascii?Q?VZ4K8GM2Wctpi6q8OBKrjTv091Frqb+VidMA9MRNcHesDtOxyAXzfFoXapW4?=
 =?us-ascii?Q?IAWebBh1eNII/XkZmyovJjxAUCT8VV28kg1Um0ytlPffXtyBr2k4RtGlyRcg?=
 =?us-ascii?Q?b/ZxJPsrPwlnfxZOpWdyaUw3J7MCNvWKck3ZKSewrpv+VnKxWTn3I1AicjgA?=
 =?us-ascii?Q?MRsU3FwXj0uoQQUkvEHoRsKsjx6qXrvLfN/CD+mVWMn0GXqgHk2PZPmixZ+V?=
 =?us-ascii?Q?ZD0/im2HIdAZ79EAWvW0dITeUhyTcVmWus+gisL39nx8a0dm/6xg8sWYNbge?=
 =?us-ascii?Q?+iDwBbM7KTYKFDGivkFKHdgW9G2PcFyGqlfIe0dBN5Ja23LVkIA5HPqyBu90?=
 =?us-ascii?Q?+riOnnnkDbAtFZiCskb2dJedVLZMrE8nXCbb5PooU77hT2zaJXUJEds5HGge?=
 =?us-ascii?Q?IWNpD9gJVWql9Pu9Ur6yVdGm+B5NFsuAHOzo+EY2SNep71fuy4ZFJ4uuO6Fn?=
 =?us-ascii?Q?yn3F+TscE/egRsTD/V/nYniqwFrQvTT0FyNBvBx5yvzUhWT+ZA2Gf37DMgD+?=
 =?us-ascii?Q?8OFchcOH0f5u1wVBtTRNrPZBV/4c7VKQyED0ygEJhH2MEjBPCBQI76LLfshm?=
 =?us-ascii?Q?8J10NrjP9h5rUEHLWPv3diBq6c9jd4AuE+qpGfZeZfAsF7k11qj8ScreAnMF?=
 =?us-ascii?Q?tbfAZ3itUI6SJjcRNCyqjgx6clLRF6LrUSTla7yfu208dfm9DJA6lozieLF/?=
 =?us-ascii?Q?NVEetxFkCvJGhsTCGhYbYY9BwPTjRD/t3Wejzddx+GZepJSUEVtAIM0BYHW2?=
 =?us-ascii?Q?qiWoF3JlB84qCaYksiGO69uq56cYz0o3811G701PwBupjT7+3BKjxqSLgDYC?=
 =?us-ascii?Q?rmCPCWhVlBYep/sIjhqPffEIFK8F+w+vXlN7bQNmwUPpTkNazhKWLU95/ri7?=
 =?us-ascii?Q?8vzOUjbjs3r1uAdW3symAN+x7VqpCNM7V76dsh2t8y/y6767gi9utCCD4wUu?=
 =?us-ascii?Q?nCNy9O2mS/xK5lsRN/y7yPUrLLBSbiIN70VnRqKgr7ICdKuloZKK4pMj3gzv?=
 =?us-ascii?Q?TN/P8tQdkrHaXgxLyriybUV2fG/T9HFZq8J9Lc2wZOXspXx5qMGAeI98YGZz?=
 =?us-ascii?Q?ojHCEao=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6266.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r27KMbxrxNI+9C0ylphD33bdjM/zf6KzJSP68ajjA+nE5pXhD/dwPlMiV+Dg?=
 =?us-ascii?Q?QDvbqNpRDLMSO4Hz0RwNRs+TO/AI/IuPAl96366soC8SvtnmUeI+NwQulpAd?=
 =?us-ascii?Q?qemdEiZHg+NgGbymfWS3/40MA7oSdSMItdDlyIFJm6e5cc/i/wm1s+to3Bw2?=
 =?us-ascii?Q?SopokMANm8kMc3RJoBpxgIvdwAMlufwjB6R3dbdwUVJvhV2izRGmejb469go?=
 =?us-ascii?Q?UxLs9/a7bg6nRbzDHow+wURdAKo3n7ZXuHxkCicwa4owzaiMZvwL0lno0d2Z?=
 =?us-ascii?Q?1QorpzZwF5G/43DS7VZWD23iV9mEuPsK8zlr28H5hmspUb2yo2r5Uy5B+H3Z?=
 =?us-ascii?Q?Gnqcr5Eg8fkle8iv/cLQJaAaWLXoFyiZwgSx9hAQ/gd6lMaKf8TDc0iVznRH?=
 =?us-ascii?Q?/Al07LEa4R9E1hDgTFz/RUuPtxOzTe8abLLNNuBcbHih4XDIBGnXW7UqwC//?=
 =?us-ascii?Q?cPIzT9WcCxLYQYqSSWGNaHlEFsHplZHg2cEq2M1zrmNglD80CZj33n1JmPlk?=
 =?us-ascii?Q?y8t0lOtnPYSNHSmqB5jwDO2c9eZjySPh8zd1SH8Kl+EawnI3pIMToh6cECx8?=
 =?us-ascii?Q?9HM3XU/HVTHdETMtjJbEzKmP/tGpO/wRKhIXSunfApug5anBh1WmOdpegYLV?=
 =?us-ascii?Q?8kF/KgYjmseroDYejK8ep464nmsnw7Zd8a6iu4Zvqivp0LqN6k7ao6jc75Io?=
 =?us-ascii?Q?/3dw3uwapvklQBQu5xgPAvRw/vK5osEWcoVCu9pVVs4Tcs95EZ2EaJZl5tZc?=
 =?us-ascii?Q?ZecALfzKr7ohoXcJTTiaszR7c3ZNYNHLL29K4nBK9mFY2aarI3qP0uT4iG8C?=
 =?us-ascii?Q?RDrn/haWznlABhHqNDOfhbaaIjDKGGP+ssGtoQtUpZX5zMemBEP+bXFoUWMM?=
 =?us-ascii?Q?JBLNvseQsgZiVEB9S/YNM1Hi6PtEc3hw88XyvcEgzVwaBFp31zmenTBt5GcG?=
 =?us-ascii?Q?i26lbzMsEwH+jRFKBJQZBcnFJAijGeMfO/QlikbTyJM3ZPmqM6HBuY397FNh?=
 =?us-ascii?Q?JDEz8wDiMgIB6rIEbWs6XHtxOU62QOegoVEzR+3PGubCvo4X7+TWnOPZrzCW?=
 =?us-ascii?Q?gncTHQ90G+ZSREryy01l8aAxrurTABHBJbVIafWNfAMiMkiGwsFNmTBJrSUA?=
 =?us-ascii?Q?WCMCDjxJw0v8vphcXSRhLOJweA91/WoF4JGGqXglT+GONor2mAsLKlXs6wUQ?=
 =?us-ascii?Q?xjA0MQUV8JSDceILwsBKgtLpz4EZhXxttsLTcxSOF/jnjMnVlyd4kIYPUNpy?=
 =?us-ascii?Q?6K+ivVaJeCKyRQXjrsg5ROINhl7lj3SZloz/lUb3q4oKmMraDBgnxngEYHAz?=
 =?us-ascii?Q?T/390bd9uHU+4Vf0LqvMqnMgcKoPQQugzKd0P/HJ5j2+jDN1DgzycuQsaYEk?=
 =?us-ascii?Q?hZ/gW3AAB1+kOE7ca/KhUmntMygabviEwZYGovyq/JUMwG5IqWxhxPhHl2uY?=
 =?us-ascii?Q?7L72tglx7jxLg+SAaS1K9d7fqWSNXzgZOfkLpr6p/LKHCwBBMzsr7jGsBhh9?=
 =?us-ascii?Q?clgfFuvW6yYK5W59GV5oBpERi4Do+yvCkMplgSbfJOaYJHGwxPxBEe+zpUro?=
 =?us-ascii?Q?fVbsmC6aT2+0vcTi6K5vha35vHSiV1EtJHzOPY6Ym1LM0pMhUzdFHlCecog7?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6266.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e954c737-f868-45a3-e662-08dca4a10475
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 07:37:45.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DT9QZEAtPG7IbLoZWrSviE/M26btqLPc83k+csPah9l/UCRzs2k2iWji1oCCWcg32DHcuXiZna5z7+JkOeptZ04Lc1LX1rqrS8Z9xgxCJUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4982
X-OriginatorOrg: intel.com

Hi Vladimir,=20

Here is related discussion wrt this topic https://lore.kernel.org/netdev/IA=
1PR11MB626656578C50634B3C90E0C4E40E9@IA1PR11MB6266.namprd11.prod.outlook.co=
m/T/#mdfcc6e25edb5b7719356db4759dc13e2a9020487

While introducing netlink support for ethtool --show-rxfh
the tradeoff was whether to modify the command output or to
use ETHTOOL_GCHANNELS to get the queue count. We went with
not modifying command output. Didn't realize about drivers
with no get_channels() support. Currently I have no ideas
on how to resolve this other than drivers implementing
get_channels() support. Any other ideas are welcome.

Though not a solution, one workaround is to compile ethtool
with no netlink support.=20

Thanks
Sudheer



> -----Original Message-----
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> Sent: Thursday, July 11, 2024 4:46 AM
> To: Michal Kubecek <mkubecek@suse.cz>; Mogilappagari, Sudheer
> <sudheer.mogilappagari@intel.com>; netdev@vger.kernel.org
> Cc: Wei Fang <wei.fang@nxp.com>
> Subject: Netlink handler for ethtool --show-rxfh breaks driver
> compatibility
>=20
> Hi,
>=20
> Commit ffab99c1f382 ("netlink: add netlink handler for get rss (-x)")
> in the ethtool user space binary breaks compatibility with device
> drivers.
>=20
> Namely, before the change, ethtool --show-rxfh did not emit a
> ETHTOOL_MSG_CHANNELS_GET netlink message or even the ETHTOOL_GCHANNELS
> ioctl variant. Now it does, and this effectively forces a new
> requirement for drivers to implement ethtool_ops :: get_channels() in
> the kernel.
>=20
> The following drivers implement ethtool_ops :: get_rxfh() but not
> ethtool_ops :: get_channels():
> - drivers/net/ethernet/microchip/lan743x_ethtool.c
> - drivers/net/ethernet/freescale/enetc/enetc_ethtool.c
> - drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> - drivers/net/ethernet/marvell/mvneta.c
> - drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
> - drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
> - drivers/net/ethernet/sfc/ef100_ethtool.c
> - drivers/net/ethernet/sfc/falcon/ethtool.c
> - drivers/net/ethernet/sfc/siena/ethtool.c
> - drivers/net/ethernet/sfc/ethtool.c
> - drivers/net/ethernet/intel/ixgbevf/ethtool.c
>=20
> Thus, for them, this is a breaking ABI change which must be addressed.
>=20
> A demo for the enetc driver.
>=20
> Before:
>   $ ethtool --show-rxfh eno0
>   RX flow hash indirection table for eno0 with 2 RX ring(s):
>       0:      0     1     0     1     0     1     0     1
>       8:      0     1     0     1     0     1     0     1
>      16:      0     1     0     1     0     1     0     1
>      24:      0     1     0     1     0     1     0     1
>      32:      0     1     0     1     0     1     0     1
>      40:      0     1     0     1     0     1     0     1
>      48:      0     1     0     1     0     1     0     1
>      56:      0     1     0     1     0     1     0     1
>   RSS hash key:
>=20
> 0d:1f:cb:76:88:82:dd:ea:70:c9:ef:53:3e:f3:bf:60:5c:79:60:09:32:ff:88:fa
> :aa:39:63:31:ef:ad:31:e4:ac:57:ec:d2:09:4d:9a:01
>   RSS hash function:
>       toeplitz: on
>       xor: off
>       crc32: off
>=20
> After:
>   $ ethtool --show-rxfh eno0
>   netlink error: Operation not supported
>=20
> Sadly, I do not have the time to investigate a possible fix for this
> issue, but I am more than happy to test out proposals.
>=20
> Thanks,
> Vladimir

