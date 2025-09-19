Return-Path: <netdev+bounces-224808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F105B8AC9F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E67D1CC3C4D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726A432143F;
	Fri, 19 Sep 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdgQxZbM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2C221D9E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303391; cv=fail; b=M8UU7fMyyEhOSfDk9pcZiP0WLt8YnFQjCUZWsRm3+HiEvigLgD+zYDSX94kkGFcEez8hURKO/Hm3mMZIHkheSOA3Wontu8YQXLKY8yGTGpi2mSxvA5ZLcIg5Yubc8Ifwdy6nTZz6c6Z5cLDEy41ysv1rpWiF7cNeT6F0XLNQY48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303391; c=relaxed/simple;
	bh=wByZrbf69P0+/QIMBOcyR8/kXsfLZrcvwelThlQZ3Gw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KcXmkFOG8WC7tfrK7vggi9VmX4axsfiRgWBBUkZy9elUdl0pNhUGylwlc2lQ3h+h+IjAY6I1PuTOZnsNsGCjxW24ehKyppgn2oOUWEhjI2KybfuJ6YVGwVM9McEjSuLb6FWPMMQ2mh2aCuQCVw1wFyvjlnK6Hyw0uYdovXNAOd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdgQxZbM; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758303389; x=1789839389;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wByZrbf69P0+/QIMBOcyR8/kXsfLZrcvwelThlQZ3Gw=;
  b=CdgQxZbM7Uun2bADHYvfw6kRlq2jbsW5l8XFimBrArz6VLhlfk/c4b89
   YKyb/iEn6oKg7cAKCYwLOJ+y1QL6uHW22+RRpYWcju5ySO+yhiEVgFmPn
   VwHRHBwTXsaNSdAPy062m3tp38fQDT3c07CrIr1DF1+R8EuiDTVVEBlwu
   kjZOYgLjYSvv4BOK1dzwYug8LiZOzVW4bxNvmE5tZL6Cr3dK/w9hVSaOc
   iuhs1pNC5Yko+h0N5E6hdvc314sMWbZqLnj1DmgiqZiKzzR4poROXh9Vz
   zGkjF+XumgjmYTqY4xTa0HSSWqB0t/fiSnFAkGPoKw7nz7EzSCMFSrBtK
   A==;
X-CSE-ConnectionGUID: lU6IsoDkRzivIud0kyMWQw==
X-CSE-MsgGUID: /UI1Uoz0TGmbmWTMwq1JVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60768379"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60768379"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:36:28 -0700
X-CSE-ConnectionGUID: KwxcpG1VRX2Sml4NuEjYcA==
X-CSE-MsgGUID: nG8RdK9lTH2VqZG/hct3CQ==
X-ExtLoop1: 1
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:36:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 10:36:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 10:36:27 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.49) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 10:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wi7KEFpQZiirvV3u89ORn7su4UCv4uoYhLhv3u6O0HuxoDllQRA3YugbMhs99RVo6Pccdz214mDJMh8v2XoisWhW+opUfGPBOA+BaeaxsdEdQq6I0XHFV4N/7xbxKmmPDbhj/Z8kATsRdWHgR6KIPUY3xiimI7ojUaihTCO1a1xzQ5KbaC5QYWQcJMigCxEU2/mCYlVvgAdIxT2TsvA5VrtXG1saaCjAuuSBBo5dhD0cm22n/u69bzoYnNBuzyhNQgl9m1siFzJCHFJ4bBOhDIvucnckuk9Do+CQavgZNd2ztgK1UsS5jye5eYNA8qkq1PLEIj97nHv/gTkM5N5PxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXPEgqrPPJ0HgbOZCorn0DIf4iGxM0DoL+foGnF8aII=;
 b=ieCwoC3CkpRBmqotqdg+LjEpEwUjyS4TZhp2z7ZwOxGkTnBWO9LqKnRROuO26rloxfkJs//XfXDA9nXsIynEWZA5/BVcBlGjucN3UCYInnCVlokTKrmz7TXMHkhu9xW9zS5HuoywvNEOC2L1S/BdH61PqF0biZbJmUHAxYzue3YdYmFQTDonzRayevjB5EENYhah6YJwg0x1fY98v/uX9Z2pw3quPfNXIIsthjaHZgQbfTCl2OI9HwxxxZ4yuT+zwKGhwD71n0E238WrT2Cyie2bNnpQgsX4eUaTz8I/dnOuIigshe+8p3Dclyhn5KyHAKgHtiaKHzyK9DOcA73yEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9)
 by PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 17:36:20 +0000
Received: from IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::bd8a:8f94:f384:bf93]) by IA1PR11MB6289.namprd11.prod.outlook.com
 ([fe80::bd8a:8f94:f384:bf93%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 17:36:19 +0000
From: "Joshi, Sreedevi" <sreedevi.joshi@intel.com>
To: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [PATCH iwl-next] idpf: remove duplicate defines in IDPF_CAP_RSS
Thread-Topic: [PATCH iwl-next] idpf: remove duplicate defines in IDPF_CAP_RSS
Thread-Index: AQHcKYvoz5avmfk/5keTBsFt0CXMaQ==
Date: Fri, 19 Sep 2025 17:36:19 +0000
Message-ID: <IA1PR11MB628982EEB7B455EE7E96538B8911A@IA1PR11MB6289.namprd11.prod.outlook.com>
References: <20250919165905.1599964-1-sreedevi.joshi@intel.com>
In-Reply-To: <20250919165905.1599964-1-sreedevi.joshi@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6289:EE_|PH0PR11MB5014:EE_
x-ms-office365-filtering-correlation-id: 5b3c64d2-33ef-4627-0019-08ddf7a30b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?bpCE5gBYggcodXbHcPh8C+Pr0UQmfk7Iv8rAFtqzKu/kdxCwg+kE83OEfNlO?=
 =?us-ascii?Q?lC0cmTR273ScSuEE3aTDrmmY8VuZbs48vZRgodaiNRJqVyce2W5cpacv+oWV?=
 =?us-ascii?Q?gjPeV0T/pxHIofjtKU4ramd3j2USwRM+vbNbKXYcIS0xMM21Azm+0DZLbnao?=
 =?us-ascii?Q?Tl/dFkLu52jUf7wBfjc/yZXHlgchwfqYQgFoMXiC9MYLTownnv3ByGCkqmGO?=
 =?us-ascii?Q?BDCn2FweAXVqS4v7NO+PHeGU8DC72r3L11Cg0JgDWxcgF/OCLHBoPBSKqZ+X?=
 =?us-ascii?Q?PdYxNHwQknIgh2F/fJbxzCQDV2pT6CaPTDkM6LLvsygI4PrpntlIRg0jVZ8N?=
 =?us-ascii?Q?6BY8WYNb/eGmZz4i0Ee7hQdQ7nFJXQjTimLGPr+wevhBXmbOGj/SN1D3SDZU?=
 =?us-ascii?Q?k1XfY1FFOLfsgeSNH7T/xJgX6e9b6Hmd8D0BmNQApah9OpQBSrKU3hp3LQSL?=
 =?us-ascii?Q?7koPke9FuaBQxk2g0zaxjcPegWESB3hbQUqRtSjPmI6IanN02uWuUsLuX13D?=
 =?us-ascii?Q?IjS2qiLr4aOxkaS8+hp25o8XCd9JzzqrOPpSw88f7lss2FaQz/pMOHbbQJap?=
 =?us-ascii?Q?KtdnSbQc8UEQ7DNehzzyOZV/5aCuOsdTz+n2qWedNgcOadzo96LDgEaX+R6P?=
 =?us-ascii?Q?i7IK14mdaARDFP56NRp5hc/Sa/64tT9ctpsld26zufUGT6M4LNYCYZCpNUbp?=
 =?us-ascii?Q?5VAQaoEdxOg2UmW07xD94lb/yfY0LMrriNiSQ9Y+aFn7mLpO1e0Og8SHeVGH?=
 =?us-ascii?Q?NoXyQGpsscmEtp3VuRY103feD76og9Ovwfnv5yx3ELe6wpoKN7pzJhrZ9hKn?=
 =?us-ascii?Q?E60fz/kYP5nbpPwdm6siKB41nBQcNw4iq3qLjiJNFFntJYwPV4kyODkMOjV4?=
 =?us-ascii?Q?6b21WuSN1IHTW/wZcRL63IlPksnj4SLpndb6RBQGCpHf0iWRzu5FDXlfzkhQ?=
 =?us-ascii?Q?MtyboJ6uhU0o+QZdj4sHzvlBPxJfyCMhs6wkx6jKq6GHmCcVW/Qap1rG6cBt?=
 =?us-ascii?Q?08tk1+Kjb996dc4kmtOEYnYbhJjHDvBJBEBThwTcwBCULkKjIb2RtKZnQi2P?=
 =?us-ascii?Q?XkUP0bPlXSQfVQKEuOsnBdSywp6uD/Pcb7vn8U9LgmAeejd2uo50U5pDpJTn?=
 =?us-ascii?Q?+3lfY7Y/2q2b6oBfd23ZdZa7KN8AwMkMrvvlqF24U0kA/I5L8AUdMzb3kRnP?=
 =?us-ascii?Q?JM/ULEAAEoR7Sm+EpQ3ilXVRcZb2kfrudLTr6JWXi/U545PTidwyTu5PKk6d?=
 =?us-ascii?Q?ffkec7ofmi49fNhOuEa5HeMXzyw3StTl+Vh+Ba3FJYTaBiXFdpiWvwXet1GL?=
 =?us-ascii?Q?1BBTshHfWOG/oFh+dau2RTKTRwJzGIoTK5VOlx6X8oRKuXQCqNcGH1e+mh1D?=
 =?us-ascii?Q?B3SlS4pZaUA3M1QiZucymANpuia9pJUVG+G3Y4CjveUm8gl6CxQ/aysuI6Q5?=
 =?us-ascii?Q?eFnXFuKTCfhHodPIOTnn0HJ4wGQTI8U88IpOeVzWyd/BXkExlojiV0MTAcFj?=
 =?us-ascii?Q?itY8YMpW6V5NUmI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?c8GZdg3j8rU3BAdc3QeW6If9+8bc0BZpgXteUf3Ayr9HyiW9RUNYFtWBzDx5?=
 =?us-ascii?Q?D4OawcCdNQO9KwTScKB5qPfMPgtW53cuhcRy61qDMqi5rvF/okCy/eBeIfBk?=
 =?us-ascii?Q?EJqPt4I1dpIYZaqNxKrTlUefNJAXMBMnEUAmFOifptu9G6jeUK5Zi/Y/v9l8?=
 =?us-ascii?Q?TJnWZ2i6WblLgF3vylCFDXWL9FWXM/GJzePCFUYLBVzDFUrGPeelYIaAIGXZ?=
 =?us-ascii?Q?OPKjkbf9aRisl1I2emmFoHpWf8Vq07IqabRuMKnB0RVvf+uGIe9xYowHf0Pm?=
 =?us-ascii?Q?wNU57fCWo7G0AjB91Gxc56Ojs6asP2rp+Rx4xmhV/PNZ/5/gJE/NGzEffYDa?=
 =?us-ascii?Q?mq0/EpeQAhRIwgPhsyGLvp2APnwu3TKkGorfhhhzjRxqnBnvP30j3nRwLVFb?=
 =?us-ascii?Q?aRGTNkgK7EF7OTJ1/2h48H1OkPvItMAMzrqdDe8a34cwK2Dz79aKxLmTCq1y?=
 =?us-ascii?Q?qWBZaWVAIpMEApdiNBG6QMOKJxycn+h/gMWL7lDSJClLka+dKI92rmpKpEbR?=
 =?us-ascii?Q?fmsQEPOZSnep0rABVPyZxIgEVDg2VH2MO2r0PBkk9GWiE75Xjp31MrUuotSC?=
 =?us-ascii?Q?Vai7CSYJGacI9qHkkDyeKA8/iUuNq+zVrd1Vwl6ccQAxWrNPd+I2USxu29Ad?=
 =?us-ascii?Q?N1HemeVTv66EwivWJ7uayZbFV4JiPGp0dSgC0MYbsAc2BqJrT4TkQEf/0Iiq?=
 =?us-ascii?Q?Uitr1GRlb8PsvRqlrk52p5WaJXTAhLAlnvY/8LnAYelh+cYB+4frRUgpBZPv?=
 =?us-ascii?Q?6ZB+hjpR3G8vT1yCgFS0kLf5/cc3wn4xwfYfrbKtqJkDUb+PNlNhOzEhhYCe?=
 =?us-ascii?Q?LHrVVbO6DhdGWvvZIfcY8D9Ev488x50kuXu6HU5ArFuq88iRo+Vw1Ld9P1Rx?=
 =?us-ascii?Q?b9VYLw3H46lJt/DNBGm8NXQE8tOF6cXLJTOzxlywGzw+M47Mhl9YgJ3al0ci?=
 =?us-ascii?Q?GAXkWnOn+lsR6t5Ss1XMRs163L+eQxPHpohNYu6SPihVLhk4BOdP0giT4ue5?=
 =?us-ascii?Q?xs4yamzMilJJLHzQee6Ojzb7HSjgfF7XpPE43eRayOXSFapoGO0QhXAy4QLe?=
 =?us-ascii?Q?0sUvzuvZ0CBxSNOJqtGtbYglSykvDiUcpC3EHmyqWMJs3zTPmgQQwSjmYgdB?=
 =?us-ascii?Q?fZfNGrwEaTumr94ICjJKH0N3gTzy3E4v8RHx6pqClPXrdPLuEBKpwEGkeQL5?=
 =?us-ascii?Q?sko2a1jJ88/XokQuWdJM0YNnVj4vH5hq3Bunzrj0ZR2WoPrHhpS124l7svoc?=
 =?us-ascii?Q?POYTSrY2zQQ9MQZqaKbhgX/tNm43bukqJLZU8kpjVZxS8w7eM03LsoNH4W2J?=
 =?us-ascii?Q?bWnrUc+85fml6Fs58T/FGA5SIj64RLFKG7RQN98/UyzIKJU+8SDCVrGfxCGT?=
 =?us-ascii?Q?8FJrX4lWA0t75+L/11M9Tcvgbm3VnOyPms72xal4QrRIxRLJU7D5PEtOMPs/?=
 =?us-ascii?Q?w4Pa8h34c1SSkHvftMfegcOToYEjbdDu76ynBrBQfWZ/XqROgNQW4oMPtvB4?=
 =?us-ascii?Q?myL7WrdW3d2NkqDVoIiaGVdzLbCDEqrL2MxGAAwqA0XZR/o3Watgozg4xs1G?=
 =?us-ascii?Q?N2Kxdz8E/a4RmyikOfMRrxwZKBPfXFFTUN5ceTss?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3c64d2-33ef-4627-0019-08ddf7a30b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 17:36:19.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLNZdrScWEFH6URg50QtFKtz84RE55XUI0JSB+YlGcA1HGxZUYN8tgrALTE1Y415n3iy2lA/SXxv2rxo0u+dtKBE50oKHwysS8zhQqpSz/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5014
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Joshi, Sreedevi <sreedevi.joshi@intel.com>
> Sent: Friday, September 19, 2025 12:59 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Joshi, Sreedevi <sreedevi.joshi@intel.com>; L=
oktionov, Aleksandr <aleksandr.loktionov@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [PATCH iwl-next] idpf: remove duplicate defines in IDPF_CAP_RSS
>=20
Fixed inline.

> Remove duplicate defines from the OR operation when defining IDPF_CAP_RSS=
.
>=20
> Duplicate definitions were introduced when IDPF_CAP_RSS was originally
> defined and were left behind and went unnoticed during a previous commit
> that renamed them. Review of the original out-of-tree code confirms these
> duplicates were the result of a typing error.
>=20
> Remove the duplicates to clean up the code and avoid potential confusion.
> Also verify no other duplicate occurrences of these defines exist
> elsewhere in the codebase.
>=20
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/etherne=
t/intel/idpf/idpf.h
> index 0f320a2b92d2..21c50695348c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h
> @@ -732,13 +732,11 @@ static inline bool idpf_is_rdma_cap_ena(struct idpf=
_adapter *adapter)
>  }
>=20
>  #define IDPF_CAP_RSS (\
> -	VIRTCHNL2_FLOW_IPV4_TCP		|\
>  	VIRTCHNL2_FLOW_IPV4_TCP		|\
>  	VIRTCHNL2_FLOW_IPV4_UDP		|\
>  	VIRTCHNL2_FLOW_IPV4_SCTP	|\
>  	VIRTCHNL2_FLOW_IPV4_OTHER	|\
>  	VIRTCHNL2_FLOW_IPV6_TCP		|\
> -	VIRTCHNL2_FLOW_IPV6_TCP		|\
>  	VIRTCHNL2_FLOW_IPV6_UDP		|\
>  	VIRTCHNL2_FLOW_IPV6_SCTP	|\
>  	VIRTCHNL2_FLOW_IPV6_OTHER)
> --
> 2.25.1
Patch is meant for iwl-next. Missed specifying that on the subject line. Fi=
xed now.
Thanks
Sreedevi=20

