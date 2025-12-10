Return-Path: <netdev+bounces-244299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C7396CB43C0
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 00:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE6C930052AF
	for <lists+netdev@lfdr.de>; Wed, 10 Dec 2025 23:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77E2236EE;
	Wed, 10 Dec 2025 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmVSadVo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286464D8CE
	for <netdev@vger.kernel.org>; Wed, 10 Dec 2025 23:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408929; cv=fail; b=luF9FQdqrQBKINXpVugoH6hTg1mUabQU3P937v4VVYmXhyYT7RHVNfw6YtKyXmfC0JUJV/so9LiAO5UegRumQR++YymAkVHFTlCxi1wKDZyK6oTaTWQohTxkJmBwXkLGAhxWdUlVRD3e/KNhZJZdPdaXSlIOUoSvPGDUfQPoBKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408929; c=relaxed/simple;
	bh=3Fnj6UG1r99qDxiyV+MhLifaBJuDBN8mInSYJUEmS3A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RQo5RhYPs3g/nUUyMITbYCUEqYz4yJM/cAC9bJrvqZnC/UezkeAUGHgk9CIL0j5qLJrrhcvQIseyeJ51kOKhZWl1WeuAH2xPR1AZQtCXffjM1XQZYUkb96xboZh6x9oX5YgDA4R3jUlam3WbwK7cmFVRwzKffUhih7JS/LSEA5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmVSadVo; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765408921; x=1796944921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3Fnj6UG1r99qDxiyV+MhLifaBJuDBN8mInSYJUEmS3A=;
  b=LmVSadVoAVT9V+HQtBd3Q8LA/3zVT8GKWVEjlSgkgWV+9yB5CrAydOfY
   pqO9X5kC/f233FUtL+9WcKhV1fUpkX0gX9KSJwalYpjMJE+3hwaPcvw5y
   ri9eAYpYUYMgqmCgsVldaTS2uNO86wvCIDDOlw1/265UWKV55OnDfKvyT
   MZQRqgVv71z6x4YQLVdtMhQZfRhcP1O7XBDWJAcCZiq1Ja2jraurBqzaG
   BBicESKzEqAWf34F2vXYboonqhMmLSA7omOIVVUH9i9rxXrt1eQV5pA5a
   F3B1bmNqr66rjOK2NIManYV+ebe/OtHiIxy8+QAGgGu+ws++gY3ubSZ6d
   w==;
X-CSE-ConnectionGUID: 4wOI446kR06s/F/DYoTk2w==
X-CSE-MsgGUID: t0RLMzCCQaaU60Gu6aeUdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="84994681"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="84994681"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:21:55 -0800
X-CSE-ConnectionGUID: 9W9SrPk/RaayK18+LMqXqA==
X-CSE-MsgGUID: We265MKBQSGJin3mzvyt1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; 
   d="scan'208";a="197445173"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 15:21:55 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:21:54 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 15:21:54 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 15:21:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QU3XnxAs/VP2YvqALu8j3F6SOXdbK1TMVZJbL7DIayuEoioPu44y8fcg6NYb4db0HfbdXmTGsHMdsc5xJBUmpnH12GYj52LhVoHcITnDFgetjMw35+TBGyqs+Rjxg0uOyE99BK8zO+/szVYKqxb8N55rMVr5HyhfgVjEHWpGLtiplt3LHKTrua3haaa6dySFtp5PttPe1T4DnfW0jk2NpA9s04s7yRHzDVTIAhFbgyQVL0TK3b75UItakKXikPqXxqJ6YxT6WpkQX2kDoyEvzl3UCoOKP4yCsqYl33eyQmFOPRXwNPzyllaQdZz7kk5G+z2lwDhRYZYAR5rEjDzcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Fnj6UG1r99qDxiyV+MhLifaBJuDBN8mInSYJUEmS3A=;
 b=sUCI1M8R0dwaLbhMgnzEwCypCut2s9cYttcCuKwqL9PwfxWU5nJAwFskuppmCUarnV7lHiqadBV1LG8OJUbGAvLsj4dkqTXitWtNwhASsTPTyHBS2tqoVNj80RpQWqcO6T7dYTuX0mFbi69GleP0+cQi7Tvi3lqMKAU132cyKWjLqIkj4Vjmosu/wOJSaKhfs5b6tY/jWr8twpm2PWxXDmmwNeATV0emxucecksA6//WFHb6PtYAjHBUoTB9tmBn1m3wr3i6LnPx5zBp2gbKWuk1A2HkgNuhgG8DH5iKsh5kJsMSwTwG6L4rEUyWkLfvBhe5Sc3tgTZdb2uXcU5ahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by SN7PR11MB7510.namprd11.prod.outlook.com (2603:10b6:806:349::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 23:21:52 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::dc50:edbf:3882:abf7%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 23:21:52 +0000
From: "Salin, Samuel" <samuel.salin@intel.com>
To: "Hay, Joshua A" <joshua.a.hay@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v10 01/10] idpf: introduce
 local idpf structure to store virtchnl queue chunks
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v10 01/10] idpf: introduce
 local idpf structure to store virtchnl queue chunks
Thread-Index: AQHcVDTb+EPjzuTJckO1oatn3nj+bLUbq7ZA
Date: Wed, 10 Dec 2025 23:21:52 +0000
Message-ID: <SJ1PR11MB6297236A7168BC0666EA18C79BA0A@SJ1PR11MB6297.namprd11.prod.outlook.com>
References: <20251113004143.2924761-1-joshua.a.hay@intel.com>
 <20251113004143.2924761-2-joshua.a.hay@intel.com>
In-Reply-To: <20251113004143.2924761-2-joshua.a.hay@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_|SN7PR11MB7510:EE_
x-ms-office365-filtering-correlation-id: fe9dfb06-80d1-4167-4f5c-08de3842e70f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?MAcJcHnPs7I/EOyFZTk0xNkfQleJVNBK6eGRAjDRpgB6ToNpjH/CNzuV0vw1?=
 =?us-ascii?Q?fabLGG9UBP3h5mc5Khc/2twxck/Dv1moWw4jlZNf9Ck8ATIA2qaN3uqGCyDQ?=
 =?us-ascii?Q?4s15Lx5Ga365p9RsRwRQOBX0QWI3zaJBaNIBjs6OOJUoRCVaZ8rXRp+dWeUN?=
 =?us-ascii?Q?NgWdMR0PVSlPp1ypEdvbQyvVTol4XqppwtWJIDPt2eOi6qGocZ5/AlOK/zRA?=
 =?us-ascii?Q?y8jrZsZnb/He0ikIdr6ApLrb4gVz3sT5QbklzZrAVCtzCru61a/h4ZigO0ou?=
 =?us-ascii?Q?S+W/7gBuEbHyWecpJDbmM2ENnAYID/nq32N39DBJisrR03cFk+DrvKJrq71P?=
 =?us-ascii?Q?oxN+z4WWRKHMXFpwCpqVL8sCBb3HvX6b5aFVThWkaYQK0P8QO85euawBaVde?=
 =?us-ascii?Q?RRP+ZizjtYfrltIhdfnPBrf5yOmSMn0ORNgT2iVV9ofCpS24cnNn4PNuYGUN?=
 =?us-ascii?Q?lx91i60xDohl0D4HjW20tV5O0cBqxK3CxeD+VHUVcgbk59UPb/tyVZiKY9W0?=
 =?us-ascii?Q?FeJDFblJiPVzXJrKGFT8/7Oo11Z1l2lvWz6h5sDJ5cM1CwoNNCtdbZdCBAXZ?=
 =?us-ascii?Q?LOURdE0aZWb64rQpowTorgvw6NrbBV81TB/dtyLif4DvEgasM3ayDI1aJ0ux?=
 =?us-ascii?Q?XiduJA+Ynm8Z+0pYUoT6ymabiTttI1N+p1biaTCSHlofjnjx1GsfWcMkRKIl?=
 =?us-ascii?Q?WSzJuZXzVFtYkg02f7lofirgzZrnWj7dycbEHh6DCBOmoFLqOxz+HbvLBl9L?=
 =?us-ascii?Q?Sfp/OVNZ9FA0uOBfTS290MbATiIo4VIbzZZ8WDGftNMGuPrpv8iav+Ptbg/W?=
 =?us-ascii?Q?hi62JemsdOGMvaL+Rv/GjcrkW4knSFap6uBlH4pzu/3T9AHr5H5BsU17xtJc?=
 =?us-ascii?Q?MewWmOWvR/r6//D59xboCsklsoXT2geqdaAhYtR+ueikV1XUNsE47jdX73sw?=
 =?us-ascii?Q?lailaGJD0pUCCGIgR0SUOFwQF2/LByaZIMYdCeVXynLwUqAgSVH2WB1MdoBg?=
 =?us-ascii?Q?RVjMayUNwxgrKd1OPydQATfFHSo6Cs5DSQZW7oAiJZ4vjAj/TLkw3qTJNvIX?=
 =?us-ascii?Q?jVwYMlRe06Vo58IFI6qG6FYuly371rWk13d+YhPn82oneKeKCr9S3VsiKEek?=
 =?us-ascii?Q?XdJr+1M1zJKuLgkuR79P9f9dx7u6o+rfdCI7VXTlAdlBBxY921fY3Bm+UREI?=
 =?us-ascii?Q?+aoIbiXNq9y52X8qhPYWmNSbSvSDQNo9d5+YkFW/W11XLIwivHjZ6/dWSshP?=
 =?us-ascii?Q?6BF3vMKrUc2XjcIX/+w5Geq5rKtOrOuZdhXbqq3frM9js4kH0dUSfXVBXgJM?=
 =?us-ascii?Q?5AFymCNl8GKMsEMYpSYmIQlrUZ0/tec6Pb+6QbEqFcxH6mWM736y1Syc3SW1?=
 =?us-ascii?Q?QHgEelkZDPs1SeknHvvoSqTGlyIia7ixDoUL88C6JAAYk+Sj9kog3ihHykMt?=
 =?us-ascii?Q?Ccv4FTH97e5NAtpnzwGUqWY5cgC0G4gmYNVJ2VjgIQBs+WyjkSaHMIIxZYB1?=
 =?us-ascii?Q?G1bJUVu+1DPWwmJjX7nJGVlIGD0ax/xV9a38?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P+wBx3g/jLtUvn8sDhLsA5H4rtvS/5i2s6vZnIADvIilczUdKxMxG2kVsfEl?=
 =?us-ascii?Q?e8bY3oMdi1xzU5Tnhl+r6v8Btufhvnfq6DqLBFsz/SHnHvkyHJRiNQIeLqtO?=
 =?us-ascii?Q?6zq/cvqEaxUB9eoJBQ7e+0BRgRXMaUHFMJbqysc2u4ZGVTkNstVrr63p6gZv?=
 =?us-ascii?Q?X/w0651NpnPVr1fnCUaSQxSBcimP19B0PPf6WKmr9eHvtRqVDT7qPK2efXe/?=
 =?us-ascii?Q?zfl8lep/9ScEt+FjFLHLNBgshDNGdnWfmsV0thUfp3ZWkBoZKWKOM836wC9o?=
 =?us-ascii?Q?dTdcY7dxw6QioNo9Nx09NgQ5+hspAGGduiyUsVLZ/wX4HS9dYEgAlXENOpfr?=
 =?us-ascii?Q?+A834Nw1G1YTtSvjOMIIvInK0j1X5uNc1goLrrbG0TwOh5dQWSthnzQluh5z?=
 =?us-ascii?Q?+syRFwTJ1qNLc8Akto2S/lUOY/YrtzPnRwmtBmH2TQ45Kn3giRNkXYtZ48SC?=
 =?us-ascii?Q?jF4Sx/lHyGvq1iY276LGvDwGC9ppBgZRj4i/ZPhaQjpuGoxnKnFW0ddUQnty?=
 =?us-ascii?Q?zBob/Z6OB7+xT3tnlL6yIPPedTZthWtOlg+DHbqAvXrGTPssJrxt7U3BWkgJ?=
 =?us-ascii?Q?TQlmJ3SwDIZmEK6dyk4YyLChORNEnI9ZJqZl+rNdqd0mVmK8r2wXjEoSLyrg?=
 =?us-ascii?Q?UjMmEFA37RCzAyZ9xFsoZ/wDmr3Vg1qm/wjem2Vn8W4dWsuXCDp66ecAP5ze?=
 =?us-ascii?Q?FiMLoeuV0BY/wmbMpqcEFywcgcgzmUT+Pfu4T52zv0SqWLyQ+5P3NjwRZ8Ef?=
 =?us-ascii?Q?E7uix5wHD/+aB1MoUWg/cZXKgx8VxB4cqY3/U64ZiKrNLpwGY6PJvpYpcsvQ?=
 =?us-ascii?Q?C+Ta3ajutEihrPxw0MZaaHqNtPfxIv69QZtO5RlY6hNgccBdEjUdHb8n0Gli?=
 =?us-ascii?Q?ilXCOLsw2r1+az6h3aR/nzX5zuW/NUDFCtgNDLme/9fXnc/M+28YtrhuIn/+?=
 =?us-ascii?Q?QUulDFpgwHHc+KwZHEIZ7Na6jVS18rH92gfxQTaUZP2IV7d7Zsf4ZH/vBwuu?=
 =?us-ascii?Q?TBRxr3WuhxNqse79xrLyIKrA6kHTJfMsTT74ECEavmoN6+qnmeo1pQgw1ieD?=
 =?us-ascii?Q?bkK91bRiAm3lzteydd4/BmmajPBqdIJ98WhWeHuh8hRDEzHgMGFZwejb4nN+?=
 =?us-ascii?Q?kVcmOzluIpfRPItV1l534CruAIDk11ohq8Dis2sgZcA85ndIC5iozVXgeLFv?=
 =?us-ascii?Q?AreEB8L0v93uiacMufCqd3uFIOHNkuU7OxPVjjdH/Awn+cnqWd27FlKZTsaD?=
 =?us-ascii?Q?1rynlZA4XjRRZzAIjPAOKBZ4oGOLvgr6DjlAFCf4lhWDZPmy5C86N1i5HBSW?=
 =?us-ascii?Q?w7672EE18qHBC3zUZZVJDfDwOJ3VVH69ZjU1+WUfe4leaqEB42rv0TakvGvm?=
 =?us-ascii?Q?RaZUvgFIWFrajhhp3+PKY4njqOu7Pv4+Qm4nWMTL9fe4K5M70KBiE42FCWMA?=
 =?us-ascii?Q?CkqIbA0hY/Z6y+69thm5U7yk+iQS5K4HgBlcACykrcAowNQqb821gZLrx/yB?=
 =?us-ascii?Q?eEVqPW5N9nrCRMyYZloUGgm5N3tvazrUAznOJ8W5LfL+FawxLOuPrOXnIoRC?=
 =?us-ascii?Q?459b+iiDS7aPlYFUf51E+ff+R311CFKKrhH9Bmt5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9dfb06-80d1-4167-4f5c-08de3842e70f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 23:21:52.8451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DmLvzy9GTcqNKlF2f1rNx0/v5zfnqdGXBA5baDg81sTno58ueFhcj+ZWKiY5PKfzQsjJ9j6s1lZe6Dx1mYZIqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7510
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Joshua Hay
> Sent: Wednesday, November 12, 2025 4:42 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-next v10 01/10] idpf: introduce loc=
al
> idpf structure to store virtchnl queue chunks
>=20
> From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>=20
> Queue ID and register info received from device Control Plane is stored l=
ocally
> in the same little endian format. As the queue chunks are retrieved in 3
> functions, lexx_to_cpu conversions are done each time.
> Instead introduce a new idpf structure to store the received queue info.
> It also avoids conditional check to retrieve queue chunks.
>=20
> With this change, there is no need to store the queue chunks in
> 'req_qs_chunks' field. So remove that.
>=20
> Suggested-by: Milena Olech <milena.olech@intel.com>
> Reviewed-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
>=20
> ---
> v10: prevent queue_chunk mem leak and add queue_chunk deinit helper func
> v8: rebase on AF_XDP series
> 2.39.2

Tested-by: Samuel Salin <Samuel.salin@intel.com>

