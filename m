Return-Path: <netdev+bounces-100512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A6E8FAF67
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6928E281D4F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 09:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C71448C7;
	Tue,  4 Jun 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNz9Ie/J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22B12B17B
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495123; cv=fail; b=tMlGP7T4mb0XASvhqVBG7bmFw1qqmnWZyrfGFvhcFdnA6aA6vppWTNBbaLACHkSTX5Fz6ns6eL6tl9XFLTaei/jeQgMCWQeV2hXk4rBeRztnAJWfg+9flQawfdn3GO73zRy+hOIo5iXur0t0GQ59iijcMchKFHY5RWzhVWjslNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495123; c=relaxed/simple;
	bh=Zl2UmPMg0Lp9M+/JLYRzt4l0NzW2OyktNvf+ieIzpAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gZbmao34+sV5QcKB/PYVX9onitiHkIH4EckExLHoH7d76pmDWEadXANhMZcLZBN/HdIuQC/wCQjPjxGk7pTb0twy8tji3XPfuL2NL/IxZiEijODsgwaJ4gzsH9rQJDZ50ZZAHFs3/hf1HPIUwyC1V3E7DRLIvm1Aubk2OgYUQPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNz9Ie/J; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717495122; x=1749031122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zl2UmPMg0Lp9M+/JLYRzt4l0NzW2OyktNvf+ieIzpAc=;
  b=gNz9Ie/JIDFOw3sNrWiK0pFolPEC9AI9F9R3tLpcK9eTEEBy48JQebIh
   zOLew1rjWMd4X3h8hXGoxiVc4oTUX5CTJAfGMqFQeEwSb0997HMvyqBMC
   1A9OA45rAhXUDtto1yWA3Fg7CyKEFaWgdKWhylfb7wCg4mRCgzON1a7Mi
   CweruNVEbftIhI+z17b0+NjGEV7eqEL2mzt6Es49Ud2oJpoX607HtCZ+G
   bhxUZS5tsiVpEJExn1T+i4o8pIpdMDKy/i9Rg6cqAiHNFHdaBcT5wIEOA
   61AjYWjePPRMYfLja5POwkQYP22zSZ+MGPhSB2yPim4r3NFyuF6aSk9D5
   g==;
X-CSE-ConnectionGUID: ju72rzefTbOpk+l4dVUAow==
X-CSE-MsgGUID: kX6uHQ05TEST7QEIutXkhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="14255107"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14255107"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 02:58:41 -0700
X-CSE-ConnectionGUID: TtTcuLSaRDGijxUXIvgdsA==
X-CSE-MsgGUID: 1E4P4kniQrC6DvpVBoUgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="68011460"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 02:58:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 02:58:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 02:58:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 02:58:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McqSVg0P0YXnt8/cpmwFYLIfNycpS76FYvKM3OAaz/f3b6SGasKMiYA/LNqFBDKBhbbtgAd+DxLtk3V212z6OlnnOubPEjmy9deiOoRrSruUrnsbtYRwUryAwVlsn7RZgxbPb5IpeGp+GY4PONW4XoZTNP70CUvW3K2KOko3i20MSQt00m4iO5EWT6J4GbBQginDQT/Oq7kCaeKM0JK1/S92UoWIwfr+Ld5K3Jk75nNlc5bdsUUxCNFkkZ63nucmNYLLG6tR2TlwZL54AYOtFaUiO9ZB56WmDllbPcfatBEPQ/9LTiR95QwiGtqM/xLvdHGEkcmVTzYA9GV1xjHLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZDN+C+BYKmOASCnxXq/CBBF4OQpRXZH2CUZDF7l9Vk=;
 b=ZcCqL6h2pom870K2JjQ3Z3sE1uDHDaveEXUiZtSunxey+Z6dtC91UT7sszhH1Xiur6AGz7PPMzwJI/1pRsoyiqtOoK61NYS2joT2j5DtgMno16kdhn68tOruhlM9WReGLnH4afFlf/UCCv8sPXBtCJgUeGqr/1mEFovLJ6a4lDUdRu2q1Uy1SGBNWmAJb9T+5eJYMM3+bBkR3+/56TBGesCQX45WRoLPa1t1n1bz8sitWN/dcCpkBJ1vpEZXLeyn9P7RqJ1Lir0FJAE4fTa+0lh9Ndplq4QfW0YTf/8j5beIG8mxsHpoo88cT4N2TUeg+5uRltFcqGSsMD11xXDS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by SJ0PR11MB6813.namprd11.prod.outlook.com (2603:10b6:a03:47f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 09:58:38 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4f97:ad9d:79a9:899f%5]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:58:38 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v3] ice: implement AQ download
 pkg retry
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v3] ice: implement AQ download
 pkg retry
Thread-Index: AQHasz2/Ml1QeqJyf0eC6hB4aKVms7G3ZEGg
Date: Tue, 4 Jun 2024 09:58:38 +0000
Message-ID: <CYYPR11MB84294FEE76DDD0FD80E7C72BBDF82@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240531093206.714632-1-wojciech.drewek@intel.com>
In-Reply-To: <20240531093206.714632-1-wojciech.drewek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|SJ0PR11MB6813:EE_
x-ms-office365-filtering-correlation-id: 4a72efb1-5a19-456e-db51-08dc847ce7f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?9PlvRPwP+K8FL4ErEsq9g71qn3J4cBv1XApQdUN+o9GIhhN0FBDFutPh1gKV?=
 =?us-ascii?Q?5EY/HlqjzsR7x0XE8uMtLwVFU8VWjqYzJYcXsAGU1bYgwXNUUX0W6PqBKx3C?=
 =?us-ascii?Q?KFyasTx6nDLVQGfs1+pBIxmqtph+J/YY+ZUF8LenJYfxXZUh3nvt4153T0nR?=
 =?us-ascii?Q?M8sRhbF/UmXYcNb97qdOP5SupFyu8clBFTS99ccGb4Nfpmc1hOF1C2aSAw0G?=
 =?us-ascii?Q?ajQREk5bGS1fgtnvhLETxpdnk0z4xUMLWf5d+efUzA4ySJBL3ccdlCyPsGLy?=
 =?us-ascii?Q?WVwcnoH8KU1/1wt2jNz0Npx2TmT9SKUOYJ19hzCmX1MFMWlphBdUuIWvAL0O?=
 =?us-ascii?Q?RJJ49Y4+0lA5h+q4opllG9YfeFZ/VJ4WW5TlVY0lapd/om2gh3BQYZkH6ChL?=
 =?us-ascii?Q?uMEeG/LaDio7q85ZK/BPR+ZNxFCdJlw69ATfTDGIVD1kBCNZKVpSMJysBeQl?=
 =?us-ascii?Q?TpcQr4fJeRL2KDpv+h+4S7gtLzFbZ1/pQo8CeLcl+QoDEo6xz9jun0PjXfGQ?=
 =?us-ascii?Q?2jFDK50R3ca0qlz777hAoFoiwiijmQmGWq4R8djYURqAhsIq5DyaMPjMQbo2?=
 =?us-ascii?Q?UqVNWDMVsiL/GjLjfWNUYMO9OMz55UFolexCGF7cGFNcyZ0QnTwM8yiYlvOf?=
 =?us-ascii?Q?Uzx4oXsg183WflIaoWlQeNkacllALejNkt04wuGFppPWzJPgSHRekCSMnHMW?=
 =?us-ascii?Q?Z8DeJoPwaKZ0oJF97Fbm+WZC6UwAxl6rPSFuEBA4QBUYnTzzH9ocNys3gQuN?=
 =?us-ascii?Q?fIroAbgCf7ePBFZVt/EiKltg+BE2bw/NDWKOV0KvoGXLACQAVOX3tJrv8mcU?=
 =?us-ascii?Q?n0xEOMBTiPoqaA8CzB7DfHeN/TDO6Trdh4q/e0Nv9ynpeJ0id0SzxyqNsGC2?=
 =?us-ascii?Q?sr6J9xIZl6u4pjSoPHMfyQkDHhP5/0bNVjb8bfRUlTjvRbdcJ4tjNZHu8Fuj?=
 =?us-ascii?Q?zTtVd0BQoV2EBa24Q/quePIMnMHTwweWxxc+i7rt6b7LFN5RFs0mBs+R2oXY?=
 =?us-ascii?Q?JAvX1y/s2ToLBNKHIgfKq8+XLyZ85MjYDB+cytjt1hEok0OXMwtdQBsvPBC/?=
 =?us-ascii?Q?TH0IFLptAEs8xaxR2Vh3Ov03kIkYL3zQMGMqMScsCC74R63qOnajwBpGOTbb?=
 =?us-ascii?Q?+/KD403zRtN1UjF1FajPmo+BaGn7MXGVDg/yxs+MyV6+SWsalu4v8FGMR9m9?=
 =?us-ascii?Q?VPbLawzwfMkj3NFlYeH6jn2d0Imr8cdWI2kJdwwUl4yBvs+jPNQstXZoeGs+?=
 =?us-ascii?Q?K2/wUQCdce4SdPCvcp8fSQjJ5KlDFKd4Nb1pYzC2onkiUN1DvFH/+0q6asc6?=
 =?us-ascii?Q?tPBpy9voEziSQ4ZsVjsh5EK/NddWwcquNo3yL1K0xU2BPCKPj4BSDx8+0VRu?=
 =?us-ascii?Q?bv9Yfrk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yPGxvPQ4vErd8Tw11cILdci//trrFv4vcYSVxdx5UJ8Bz+FpgLz7/1e6rEta?=
 =?us-ascii?Q?UXb+XIos7UoT36h3luBAzSxsGlW3P0JX1MK3jYyXpdH8ZCRB3QxrJEFVoJt9?=
 =?us-ascii?Q?UzrnhWEj4mmx3ZyTuaSoBMAy3TnZVAXvGWX71Ln18glVbh+svBBkAFoV4AUJ?=
 =?us-ascii?Q?rvztwNpGJOHb6Zg3do9oyIydIhqjt6tfbXkaKFBFlP8OaG6kQRu9dwBCAQmT?=
 =?us-ascii?Q?9hQB1ZVHKcMwnhrqzvQc2sNO2/9YL8PdjCPeIdEor0VaC9QQeAC7m1bZoh+E?=
 =?us-ascii?Q?RNBpDUdfu5kHUAHncOLT/s2/BeqbqO4gKeQL8CZVxJYYckLStpYCZLChktnj?=
 =?us-ascii?Q?MiBLKAXr7kMmuntpyYWOp+BSjWs8y43yQ5dgw6IUBFzZwUP8TrqQfd8ANXlm?=
 =?us-ascii?Q?3B1b5uYgmswLTWC2LRIdLa3F97eK1gH+nqqNF2MzS0sfHg4mnRezZNb6Ko18?=
 =?us-ascii?Q?8wIRqLKdNQfG/JUTb/L/Hh4fkeiT4Fkq8mGs4abv2c0gr5DIY/2I/Il7vuzn?=
 =?us-ascii?Q?huSocAQWr4VCZoiaBn67L4JBXfWO16qNh3fjOb851dB8OR+VMZFakpV+s6/G?=
 =?us-ascii?Q?1TrelbPvq7sPA3lBNvMOzHTzTjAqwHdBX5xsgiLS/3gmi1catgq+xmj+PU1A?=
 =?us-ascii?Q?jAlXJspkpWFNdIJjog3eUkzY0n1mLLp0Rastg5mfMIeopPU8gT+N3UkH6a59?=
 =?us-ascii?Q?EZRfI1jFdkwa4+GkFGuEl3hPwFA+IOVtqM5XirU9Jxjola+hIttcj6RtGxmX?=
 =?us-ascii?Q?/4oRbOlV5hMn0qEdisoj3tXfXfb0uXuVCrlhbbFxaq+VeacMJgWISOiqbPGH?=
 =?us-ascii?Q?Kv8s7tk51vznntQo/q1N2OnZxTXE7vifhGfMFGwlv0v/tby1eInqTOVr9z81?=
 =?us-ascii?Q?jQlQN0jCP9AHi8Ij9PqK9hURDghKA2ByxEWxKdxvec6/1rUyy+AWEkTiA56V?=
 =?us-ascii?Q?pzOcJUD6R5LV61+cIS81ErYUdps325SOOY0Ts5W5u+magdWxSVFX+6HW2WJL?=
 =?us-ascii?Q?kDKLYnJoKW4O9RM/+Y0ry/d1QSkxmNd+W7HMvmMatJICWxbaiM7oqMxLuHQD?=
 =?us-ascii?Q?60IDbp0B5uUn45uuQzIVP9bWsIo/rTxUHvDr7XvMsTod7iU6piEtai5zL0wg?=
 =?us-ascii?Q?kq9j3FcosvaDwKm5DizhCummQR5rr+c3BLJC7M1F6YuJJse+1bVI54Vp8z2E?=
 =?us-ascii?Q?tOAaRDXYJDEFZnAF1agxSF1UdoxQPi4JVQw9oKVZGqqbX5BwY0CPVf8pDgKN?=
 =?us-ascii?Q?otyzwp7fySb0qSn57ErdUCNDq1VhS/pVIEJCAJ8Ozdyo3kRN6MDEbeUUQokS?=
 =?us-ascii?Q?Y6hyEXsTdWz38yppN5TniH5z3o6dR3Mugsf6lUa7YjniEjda5he2HxcxULKm?=
 =?us-ascii?Q?7Lda4X9wzLaZw62v4Q3ap6rCmiRjKDf67LISXF6R4tSAAA7mirXc+CNmNEIL?=
 =?us-ascii?Q?YUcOLh/BeN4FW2/Dyh/MhBOrs8vhAfeIwSRkO7DWYV1NjonA3JBtEpabnGuf?=
 =?us-ascii?Q?Ga5sSIR90DvBcq0XuX4xjSsdNSQY1ISLSrgOoEMExPYWS8qeQWBpkXCNrntR?=
 =?us-ascii?Q?ZOChMS8lb+rdQVrfkJl0fSZet77ilrT/ZCnQTDbuygJIB4wqSOd4aw40aO9D?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a72efb1-5a19-456e-db51-08dc847ce7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:58:38.2026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: srQjXsNv06TlMaNOvlkhnb8BfTC4jxBUz76usZ+5Toe03ocGUXpB+LymJiEg1jA3uoAhoJ/BRtIku+zawO8+AtohzaG69T3Q5WK7RlzSRDBpb68jljBegWEsQtSQ5QqR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6813
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of W=
ojciech Drewek
> Sent: Friday, May 31, 2024 3:02 PM
> To: netdev@vger.kernel.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; kuba@kernel.org; intel-wi=
red-lan@lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v3] ice: implement AQ download =
pkg retry
>
> ice_aqc_opc_download_pkg (0x0C40) AQ sporadically returns error due to FW=
 issue. Fix this by retrying five times before moving to Safe Mode.
>
> Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization (DDP)=
 download")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---
> v2: remove "failure" from log message
> v3: don't sleep in the last iteration of the wait loop
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


