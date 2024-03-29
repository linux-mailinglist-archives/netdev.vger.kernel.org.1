Return-Path: <netdev+bounces-83172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BD9891308
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 06:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63AF81C22760
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 05:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF26139FD7;
	Fri, 29 Mar 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KOHqnZQb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E5381B8
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 05:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711688483; cv=fail; b=PRF8RsCn8tadG+EpqayR8r+PC57sIDY7PqS+Mtmv7eqHuGs33mo12LSO0EO07M6ALclpzIyV+OND7/aI286vJPmg0cGZz+xKFG0MrdWYMMtbvgg5Oz+1WeCjO1OSVY8g9cjbiTiTZMTanfgrKe+VC4RmWoDfDypvK3xYH1vhEtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711688483; c=relaxed/simple;
	bh=eKC8f0kLypZVHagZhBbrLNjCiuWzzq9PNcSzU64A6S4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ay2LgTxyLpYylMhXXGPVod0rgLwr6MPA7spOqgt2z9O9X1MKlf7Wa0A+rbTLYnIivtgRccP0HRGorTKRv5XasXFVhpmV13QAEcByhNMj04XCe1zgTKA+cJvwmCb4lisNobfyJGx98xc5BOgzRg+vSvgGnpHesXZmiFYOPju6Mxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KOHqnZQb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711688482; x=1743224482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eKC8f0kLypZVHagZhBbrLNjCiuWzzq9PNcSzU64A6S4=;
  b=KOHqnZQbVdQOLaYEzNU80Q3aTqPuFlnQSGarcPkSEEW5VkXTYkgU45pZ
   DkwgHYvUuIWJW2rOEcrV3Ou8F6mg8CNVpf+Gq5awBvLzN6H/kPLqZ+UGP
   h7Fg6vDsz8KpdOqw3sJWcgKj2xm9GJXw81+fH7VpFjZBlD5ztmZmkkJBX
   00uoByrAdWe82C9k4B98/eXh+bWyc55JpMro2SB9IsvVpmYtDO+qEp2ff
   CFDCd77LbGgNIACQtWy51/0WA6+40W4/0SN1GKEBR+6KMAYhTYK9sQg4v
   nvOQW+p39XHl6yVR3hnIsTH2WeWH+A/gn6ReQBUs2Ebm60cndncAh28ka
   Q==;
X-CSE-ConnectionGUID: 6NOgGd1PS0CNMyZ6R3TyaQ==
X-CSE-MsgGUID: 8Nik8awvSXObvbOW0hIS1g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="17502806"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="17502806"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 22:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="21582298"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 22:01:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 22:01:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 22:01:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 22:01:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 22:01:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDfdbOZ5V2fM0fH5lsRUKVo8pmF6zOzCI65rNIJA8NbM/4yoILfAyNlK269pHuwhskbwI1jHW2N8/u42jZNNISD4S6ZTu4YE2gZuS+xnP7YatJmUZIPa05hpeftXOjsjjuQJXDo/8y4uBvmGKK5aH2I81TYVd9UfpMPCr3cm6H9d68pCt3rQ6av7lmjjm09EycUTvvl376BfGNFhNZYc76Q/6j4vDPMKnQeWw25o6QV7cm8IRXELMqi+FySKzH4pmZlImUlGUQLa80EnAsaGIwcfexoHyY9tXtTqslFrkXJSdSuQoTNarSYgWifojlpU5AHSLrWBFPNk2LEDrqf4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LeBK5gqTDBczsS34u/0YgnBcGkLzBB2b/Vjo5vEwBM=;
 b=RbbQHbEnqooHZONm3ThRP/6qkQv4emCj05MFeqiw29sJRMS0d23A3unYsD48Fj1P43R2ewVS088C9fur7SlIOX7SDuqRNEtioMKKtIg1cCuAeK7vldUkU3FTinJp5++aLwpRlaenUHbTsR+rcjsOuN+Vklw3oOcgavfokmJITUg4cz/hSHsV5bHITMU1otMQcV7+TaonJ79OfyFF0T81lg47yGJa6QcYZWXUbNThU6LbiEUB7CxrcFTtjldWO0lOnF4aKMNXSTBlG4yiIaN91BKYeAUK1b0TEqCpD3UI8suXfkPUydQtO4c+cQDc7cIe0RGMRYb71Ynf6PuW59+Npw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 05:01:17 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 05:01:17 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: mschmidt <mschmidt@redhat.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Jiri Pirko <jiri@resnulli.us>, "Temerkhanov, Sergey"
	<sergey.temerkhanov@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	"Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, Marcin Szycik <marcin.szycik@linux.intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net-next v4 2/3] ice: avoid the PTP
 hardware semaphore in gettimex64 path
Thread-Topic: [Intel-wired-lan] [PATCH net-next v4 2/3] ice: avoid the PTP
 hardware semaphore in gettimex64 path
Thread-Index: AQHafwtH8QqjYiK1M0Ko0FdqeFc+dbFOLYbg
Date: Fri, 29 Mar 2024 05:01:16 +0000
Message-ID: <CYYPR11MB84291C3013A4C2E0D30BF84DBD3A2@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240325232039.76836-1-mschmidt@redhat.com>
 <20240325232039.76836-3-mschmidt@redhat.com>
In-Reply-To: <20240325232039.76836-3-mschmidt@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM4PR11MB5247:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofFHMiYXa8nQoEKdS9ttwtLUJmAWbtSCi86z2jqj/sEY06jMids18P8JBVwwyclkc735K5e+wkDTtC9mPwnZ8lYPq33WmwmOUbr3b/sHGRLO/2pGZKm8POpA7sPFWHq0q3eYZprnA8o7CAYxnadSIqdQ0ajqiC4HG0ArOUWmMk5sWEIal3v7BPrJNmElvRDQjR0d78D+whW3H478sMiiuIcT2LksxOFwsUK5t88iSaSALup8nkc9OpPHzbmg6W16Ltzqj6FoDVzc5m4FZJyJlRB36P65cLqDT19SuyGEv09U00eIzTY1aIB+i2zFLmEi2QqgRjBcNDpzL/lgh8EdQsUoMH2qBn9SxAEDzDNmoCWzdMJ1eJkhb+2/a3o9HTrcavBJOPMuWQm5+eUWth+EfCfQsl8IpMstXWJEW3eUrxEP+CqSRXnfY9N2db67BxU1l9HTWWI+zex1tUZhlmpBJ4vXQwkf16LL5WQRcRubcIK2TDue8yKNrfdZkTcwVg2swX3ROTf5WE40g4xo5U4L7jfH5ailcXPj7lY+QmQKtVtlQ2iDYUOneJk7H6ooIX8D5KWWquwRz8ypenw4ccNuCF59Osaa6NPc3PWMcXnGMF8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8NDsH2ejl4AOZSIOgNagHO+H8iHXTCVAiJbssg6o9lWwyqugs9rx8YNy+XL2?=
 =?us-ascii?Q?NFb+1zFvV9bR8z3HZCr//D2uvdJxGaTRoTMJsArh98CjbxKW7UoqcFQD9D21?=
 =?us-ascii?Q?3wIqqqhxLk26cQGGPgzKQ19PR+DtAUaYoO3GqGWmGLNzWAxB2teqlKbL4rkw?=
 =?us-ascii?Q?9ltalu7wS7iL5Atip5VkawpuD3WbiITapnNhZiyhokFJoJkJhoLOb/A/LHmx?=
 =?us-ascii?Q?e3EgAC0Y4OgH7T9Phc9MkC3e5n58LxleOlE0U1+1BRzUaRHWaixoAHLRg407?=
 =?us-ascii?Q?1AjxpxD0av87WnhkeCsT9v2tHVC9BWm+BXiSejrqarG5I6V0jbxNsU28eROz?=
 =?us-ascii?Q?Y0ZYlcxEgP3q1v99QoS7SUBtiA4eBZ4fGJwPF4cAzJBsB1ypA06oAu9PBzRW?=
 =?us-ascii?Q?u58aoNNF/Qvhr5p+ks4Vxwq7XB1brgHYWJh9vM6dL4UVHDtVvkWR+WhhxbpC?=
 =?us-ascii?Q?xpx+EDm81Y5vfzPZjNqYQz1zlU7U/wA4EOQrWoJwVgdChb9YQvcIzwZq3T8A?=
 =?us-ascii?Q?yqLYhkedo1GWUfunXNMc7bvawA7O2gw0evrFcsLyNVs39kKMmpTP3Ode6dvh?=
 =?us-ascii?Q?6y3h6WpGAXC5w+xpRHS1n4Ge7+4Rd3e6I1EBxDqJn1N7BUY5J+dje536tB/7?=
 =?us-ascii?Q?SG6DtG+MIgarKuAYPQnO3ZpHefs1TTKAeosZBx0S7BAAwXE8xzwhQQFK8/bU?=
 =?us-ascii?Q?pY5+p8EX0tZhrn8rP3FOe/dV2Y+PZTn6cYbE9dqsfhGcV3Bp8bkz2Anw4IZ2?=
 =?us-ascii?Q?x3nTDvl9KckVw9AWeD9+ckQZzqCt+MeJ+YxdicsbyF7lxhww24cgl4S4nZVg?=
 =?us-ascii?Q?8s4mBRB4grsaGa+xfBLIPFuRUr8yK4TboSWphs573tBGZukOKwNGarc6Iuja?=
 =?us-ascii?Q?fqWuTwTIB5n5DLHpPtSbFrr0cdYxoIrh4iSt0ZrVTgAuk/BM5UdNPq22zaT/?=
 =?us-ascii?Q?ES2WhECdBzmG5vi38Ub442GbvfJbi4C3q+plmnfWks4+g37de/iBgBA7KHt7?=
 =?us-ascii?Q?PbD7RiHks7gsjTiaaxFD4DSqZ5qMjHhlrn0mVAeOBt6MxF8DIaKLSj1yIqMe?=
 =?us-ascii?Q?iRdgxvwyHEHmNSpFvyuqSkMj+B0exSSXv4snUKsQQPdCRRhXNdtzzTCgX7y7?=
 =?us-ascii?Q?tpKcEIj2Hm2GBNPOBfp0oGgnDZqB92sqP/isEPM3syQxEl89DzJBvchox4h5?=
 =?us-ascii?Q?z9SfLlqy2Pg+vEnyp3DJIoBWTMtWnY4ftlZvUZYTHC5NAIRojJsf7YUGSZMB?=
 =?us-ascii?Q?eIzzUvSlfVVzexLhQCDNggIZlXC64xvr/YddOmFl/q7bu8zkpI8D9bCqV+1m?=
 =?us-ascii?Q?/PCsRI6CVjVgCvsNg5p5NTomr9aXunpXh/G3kbaoPV48p0peJJm+mSAhDs9O?=
 =?us-ascii?Q?6/7WiGVkf4Brm4YmXh5hy23SV1gxe7MYiugReixdljwsrB6xxcqaLGGHfSKK?=
 =?us-ascii?Q?2YTaGXjEtEaF/6Sc9M5V00FeoYPjHhCQGpzJi2vjWdFnD51IQ6iZtL7RT2NJ?=
 =?us-ascii?Q?Br62rgKYV4A5SafnVRXVeuSbPNFT7oqQuz/oWH2exQcxz7w0cTjuGRfcHI01?=
 =?us-ascii?Q?4LrsC3RHqfkTzNfhcDxOY2U+wGbrqqBehaJGe+IEw+pV/4Z7EtTvLD7JmwYT?=
 =?us-ascii?Q?dw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8bcbdc-159e-421c-f0cd-08dc4fad4405
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 05:01:16.8423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5owjNNuLACnENixVVBCPvg+OyQkcwE3Q4qxmd/6B0UfKLIdG5QZfcMRQXq6HfEXGJxhao6RfCqYSOZz71nxTtJAr2qBuvwHZ5wyHRtwpPqG5q8RL5eY1bT9emMXcQ9A3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ichal Schmidt
> Sent: Tuesday, March 26, 2024 4:51 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: Jiri Pirko <jiri@resnulli.us>; Temerkhanov, Sergey <sergey.temerkhano=
v@intel.com>; netdev@vger.kernel.org; Richard Cochran <richardcochran@gmail=
.com>; Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; Kolacinski, =
Karol <karol.kolacinski@intel.com>; Marcin Szycik <marcin.szycik@linux.inte=
l.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw=
 <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v4 2/3] ice: avoid the PTP har=
dware semaphore in gettimex64 path
>
> The PTP hardware semaphore (PFTSYN_SEM) is used to synchronize operations=
 that program the PTP timers. The operations involve issuing commands to th=
e sideband queue. The E810 does not have a hardware sideband queue, so the =
admin queue is used. The admin queue is slow.
> I have observed delays in hundreds of milliseconds waiting for ice_sq_don=
e.
>
> When phc2sys reads the time from the ice PTP clock and PFTSYN_SEM is held=
 by a task performing one of the slow operations, ice_ptp_lock can easily t=
ime out. phc2sys gets -EBUSY and the kernel prints:
>   ice 0000:XX:YY.0: PTP failed to get time These messages appear once eve=
ry few seconds, causing log spam.
>
> The E810 datasheet recommends an algorithm for reading the upper 64 bits =
of the GLTSYN_TIME register. It matches what's implemented in ice_ptp_read_=
src_clk_reg. It is robust against wrap-around, but not necessarily against =
the concurrent setting of the register (with GLTSYN_CMD_{INIT,ADJ}_TIME com=
mands). Perhaps that's why
> ice_ptp_gettimex64 also takes PFTSYN_SEM.
>
> The race with time setters can be prevented without relying on the PTP ha=
rdware semaphore. Using the "ice_adapter" from the previous patch, we can h=
ave a common spinlock for the PFs that share the clock hardware.
> It will protect the reading and writing to the GLTSYN_TIME register.
> The writing is performed indirectly, by the hardware, as a result of the =
driver writing GLTSYN_CMD_SYNC in ice_ptp_exec_tmr_cmd. I wasn't sure if th=
e ice_flush there is enough to make sure GLTSYN_TIME has been updated, but =
it works well in my testing.
>=20
> My test code can be seen here:
> https://gitlab.com/mschmidt2/linux/-/commits/ice-ptp-host-side-lock-10
> It consists of:
>  - kernel threads reading the time in a busy loop and looking at the
>    deltas between consecutive values, reporting new maxima.
>  - a shell script that sets the time repeatedly;
>  - a bpftrace probe to produce a histogram of the measured deltas.
> Without the spinlock ptp_gltsyn_time_lock, it is easy to see tearing.
> Deltas in the [2G, 4G) range appear in the histograms.
> With the spinlock added, there is no tearing and the biggest delta I saw =
was in the range [1M, 2M), that is under 2 ms.
>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_adapter.c | 2 ++  drivers/net/etherne=
t/intel/ice/ice_adapter.h | 6 ++++++
>  drivers/net/ethernet/intel/ice/ice_ptp.c     | 8 +-------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 3 +++
>  4 files changed, 12 insertions(+), 7 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


