Return-Path: <netdev+bounces-87008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C54758A1427
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF0C283E3D
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEBA14BFB4;
	Thu, 11 Apr 2024 12:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lx4XTDGo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3D14AD3F
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837673; cv=fail; b=pt6Kb6SUzv/dwEseuDSOD5bSJAyvgyblzUq25njRrgBCL+5/fdtGtmnU5FPWF2Hk7tToTuCOD+C86IVnS8TM+JYVvrRUHdd0Kufp4Sk3ecxLnoFKlZcbrucUYbELs1VG5pNPtRoWr3/2Se97zxSQrX4jkKo9AswQIlbLQvOdxuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837673; c=relaxed/simple;
	bh=bJz7gc45HHqz3DCw22suza0F4ksE+Sxk3MfC+Fji9c8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+PluZomGxrtpRO7wn+Z8YU2PsMjFev/d9UNDibDSzQwzKs2gcIlD0pVLP1m071T4md2Hw2L/oEYmwoS7Fdp1JAAugaf0YFfv/jEpqjF4pBYGPv9MabV2lUOUT1kc7oKcL5LV+qJsLvWr/9bncvR84461BSZxJ73BUySe8AKJ+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lx4XTDGo; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837671; x=1744373671;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bJz7gc45HHqz3DCw22suza0F4ksE+Sxk3MfC+Fji9c8=;
  b=Lx4XTDGoZoXDOTO3Yn7ySsk11s5ouv2G0xdHmTuxcCGf5ZxgaRMhU5MI
   bH/CUQyInNMPMVS+zDIaVXPVwFlA+UUtZY3T85yI5YID/eZCQ2fFjsfo3
   Cdb/IcWnj8bASuWkK0xYa6sRjxLWNdv2g864F2jiFTQSKseCyrT88Jo4G
   1VT+Csy+4NdihMGCzLA8G03L+8/BmfwP0bZUEqWIr8XdwhttmMWHspBdJ
   hYUbw2Yt5kglYM/R8ek2MSWecEQ0Ya5dSJ7GndYdd/dmBxxY7d2TEL2Up
   wfGdMjdZeA4ZWgMzFS4DcKfIKgfivFAejk/4+M0lt1H4tNjWBB7C95Rcm
   g==;
X-CSE-ConnectionGUID: HAEnwx1/QuKUZ002D5VJkw==
X-CSE-MsgGUID: QP9cTYq4QLGJhznl9GvPXw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8417346"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8417346"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:14:31 -0700
X-CSE-ConnectionGUID: 0lPz7B+yR5m8z3x4L5arLw==
X-CSE-MsgGUID: 3OWCo/zNRueVFNjd+8pZ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20887113"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Apr 2024 05:14:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 11 Apr 2024 05:14:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 05:14:29 -0700
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by DM6PR11MB4657.namprd11.prod.outlook.com (2603:10b6:5:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Thu, 11 Apr
 2024 12:14:28 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::4434:a739:7bae:39a9%2]) with mapi id 15.20.7452.019; Thu, 11 Apr 2024
 12:14:28 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: "Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"Wilczynski, Michal" <michal.wilczynski@intel.com>, "Polchlopek, Mateusz"
	<mateusz.polchlopek@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Czapnik, Lukasz" <lukasz.czapnik@intel.com>, "Raj,
 Victor" <victor.raj@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "kuba@kernel.org"
	<kuba@kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net-next v9 2/6] ice: Support 5 layer
 topology
Thread-Topic: [Intel-wired-lan] [PATCH net-next v9 2/6] ice: Support 5 layer
 topology
Thread-Index: AQHahZx9szdQwayyU0iaY2q79LXG5LFjAnpw
Date: Thu, 11 Apr 2024 12:14:28 +0000
Message-ID: <CYYPR11MB84292318DF94D72A20F63362BD052@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
 <20240403074112.7758-3-mateusz.polchlopek@intel.com>
In-Reply-To: <20240403074112.7758-3-mateusz.polchlopek@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|DM6PR11MB4657:EE_
x-ms-office365-filtering-correlation-id: ce034c80-9ab9-46ff-eda2-08dc5a20ef51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nxvbbmmGM/mKJBLtjm6gp9+c1UCvazADi58C/DRPuL6AdwhgxoVs4CEQOAmjBrf0Rfp0kP8/x+G4tV4F0P7XJGoOzSGG7TOgky/60B2R/J3Pa2wK+KsQsS5nF9SJfysZDnEw6JDK3fvst/BcdoCXv60xSYvc4qwl/UllvfsLjzlKHkajHXE4LXmO41sGfQveNIpA68gEpB84edmyFhnEKVRASRXDsV9ngwGhSs0S4MtEGfInjw5EoD3iyneXoz3aIXqdDuZ315vLEdNuTHadwBbDeMBObZ+4MJ+CZ0VmzcpmV3HOge0viciChxVIsmrM3cCe3twL6lpVx2U4exfs9dMQBAqxbFsXgdVnRgbxKyusfyGvxp8ptS53bty7H2BdZi3o+45o1d56Jo13ry4z0kyyG51gJiln73XE7ESSEnEghoWaWQdBaVECbamsUFZc0Ccevx8+9HRYBoDv3xQP4R2GSxqUPbPpA+GTFOXLgTmNU42m9vyS2eLa4xeMHzlGTyUZ4jStqRoBlcbsCjDvIKD/B2gmdCkG/+VNJJhZ82g3QCq3509WuqqvuOakvEQf9nTCYpO8tV/6nR+lDHyOAVmf2QgeTKpz1J6QFMdhRlpAogThBSggMC2tJOWNc6WIASR0g6soE/DNoK5/vvXgJimzuhfyJvMCgGItCWUuxKsAUBGGKnEeGAW7Xjpl7GFrFnGwkW0X803lhSKwia06BabIZeQU4nDKbnU9VfMtNng=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VEUC0aajmXWPYcPXt19TITLuvYiVBgDPZC53nZ6hKtZrV29scwUwbCco3/sQ?=
 =?us-ascii?Q?47/eHBoVOSfiqn0f7RHTDhSjnKHSy1zOLNxQQBTUcZvsrpbqFj8npnK1W/ob?=
 =?us-ascii?Q?s722jA2ntOCem1oX2i5Pa8OPkBrDMZVQgTl8hAEJwVudg5cYBZX4rxVV1SAq?=
 =?us-ascii?Q?x5Q/xfJfOJSXoi7ExW18znfBn9GbZna/aq0eyV+Hf2gJbRXYths3ZHWAhTEN?=
 =?us-ascii?Q?HWaPPtwfjQEOJ129m6OUXDszC+l/oBUz4G+7fbvLn8i/mTb31I7gnnovjFvo?=
 =?us-ascii?Q?b0++5BeJzWsbMjznIDOizbtVZTKMFZ/IKsX55BhadIOpBVaGoTmHDMsO3fef?=
 =?us-ascii?Q?+01nWWLreuyXOD2XeqDAxYht7+om663CRCMuvmR0Gmm+UQv5rIjGs0+duv8Q?=
 =?us-ascii?Q?Z/MZTNceAgefSRjzM/tnD+Yx/q2mk6BwxZa900LPc3XGKWSx/Abz7RwT035q?=
 =?us-ascii?Q?Uu6JzzJfWB8aYOroTE1jMP/ie/aULuW1MYeTBdJEAuhwWO2dtotomqNrmoO+?=
 =?us-ascii?Q?N85/KYrftBUmEx+sQolU+8jBGZccSgBwdbjsG63dIvk1YlR+/ijcRB9n8Bxk?=
 =?us-ascii?Q?b0Nxb43nWWoajHgqhOomZU6kLnP3vc1TUme64HrQCl1qlRvy7s3XpJCS0cJN?=
 =?us-ascii?Q?oEgRZQlmk8QAqpdWRskMshY38nBn1JJnlwQMmE/3wSNERTC02Kjt/dRUbtN9?=
 =?us-ascii?Q?1613dorcTUOaBpQbMn5+utbFgdJKqiuhnmcdmWqHV8x9k2ZU3RAR+8DsNX/y?=
 =?us-ascii?Q?67pfhQZmj8m2HV/37pzJgqBVoy6jbMulwc7wpLg3dnyhHcvpko2Y5OY3VCMr?=
 =?us-ascii?Q?pTEq+SbZlaM3dCL4pmAuvQy1ObxFLuCZ5CEzynUyi63V6dfzk4WDNTLT7A12?=
 =?us-ascii?Q?d2CrwNJ1V8PNnjV9SLJ5SGyS7vS0UD8lbqUZBfRe6Rd7+e17NyHkW0osPH5Q?=
 =?us-ascii?Q?bPNBmY+45tdiV6Zc+gpXsHWdJ18puqXgMasFRQ3riJFNaO/w8mEZdHDuXR1w?=
 =?us-ascii?Q?VzlbIi62XFQMgowLgJGsrNnLHj352GArcZxHY2VqG1inT8nb5GL+pJg37hhD?=
 =?us-ascii?Q?pVIdYTTDM8UeKT3KEpEfXqbU54qtx2JddJaPO/6f+zgC8ZyfGQt+GWR6LXmj?=
 =?us-ascii?Q?IfS/9bHRb9b3byj5KNXVntuWlXlLvdhflaLNabsqqaYETaSf7UqqFcWDVdzl?=
 =?us-ascii?Q?0CbSAOmCDWDIGMkFKzlQLUgYjrL2PclOsu+F1RnZnKouYwqTDPFz0xFwdAK4?=
 =?us-ascii?Q?4/KBmjny72wYsYAJSG4i43Mo/rVfk2Y36LyRNIUnSbMyevAJZBu3qpgXdl0l?=
 =?us-ascii?Q?LfsfNMxuZaUhI6bj/0g7AbYdd22kVckJ+TGvdXtWQOd7tAkuh04DAyJwq6S0?=
 =?us-ascii?Q?pSpYV8oIfq878bXw1g3qsiEQFcEo8ZW9OU3cTUs1FjSlZF7dFsta1oQrVW+r?=
 =?us-ascii?Q?sEf3iuCbcqENVYU4wwB8fFr5xEIMhUb0ZbJVbTsskb9bCfLcAsA+4JLakLO8?=
 =?us-ascii?Q?r9oxmAUtybmm2wzHHxD6DZE+pVAsZ48+khKr+67gCJVYAlYs0li8qX1NwAWA?=
 =?us-ascii?Q?g0+KZ4y9xzWTx7PWuLwrgDH+PPD1Q/i1cLfGycOAQ4Ty8CnAJvWO8n5IZSOW?=
 =?us-ascii?Q?gQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGC4l9HLesr6Ihn7AGxxDo4DqDFzvtair67aDx554LqNoy+8wasEW85+qCL2/N8sqt6qxKkXggaJv0cm2ea414z030BCp/mvdTO8YsfpVNa5U7nphGbGjNqhzOyM186N2cAiommpY4RXKO/Y3kwZkN8GZFJb15+NVc417gMWTHoSi1oPyW5EhdG8cC/AmtYgeQuyObjCHs7mdukLMun+F6LSyf9haGnqU7HlT7v1hm0Q3VRxCICgYFlaGuwjTXOlM4+iYOjq9RGOOqq2d7aGSB+/74ZMTuDvnmaXsbvvJcUYws5GWpYwXumQsYka2SVUz6nb7pfwsQFfDIBSlxkHUg==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdMoX15Y3eSaO9Hz0FCzv3vpx3LQgGrymCMnkqc8RhE=;
 b=HWlDE8/t/iDXG8iGOeO9szH+OOsJ0vOcciMHuPpAI0gnT6gPFEbdEIFBpq64Ywqb/vaMHJe8BYxi/85hqMlTZd05m8ULpQpxNRbgNH5fVm7HeVZnFyLytvI0HNBpZ+FHKATUXpzyMWjtH9XGOFAdTL9681ptsQfaHmNysW+3BRQrqOfVN4sh/WRr+Egd9fywaQJ5LORHTg+a/Q6bHsa2wVIJhoZedIdGtyP7G2K1luHa3SpV+t8JKQhX/00cY9+AW/58P/XI1+P/2u51o7dfoNXHLN9BGIsOa58b6GUXRFnGyk2ICFI6D+kWFaOmHDqRVa0I6OqE3qo2Fu6PPbRBSw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: CYYPR11MB8429.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: ce034c80-9ab9-46ff-eda2-08dc5a20ef51
x-ms-exchange-crosstenant-originalarrivaltime: 11 Apr 2024 12:14:28.0154 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: HfwHMChSufEeXzA1lXKH0G76SdDoJb/b1XFiqHnerjBEvnA93xJ/0eb1nlIi30VCoC8YyX6ZAxtuoLycuhyi99mkfWncb9Z9Nq/RWnnHDgSRJtCa7jZqmOr3195dGqGe
x-ms-exchange-transport-crosstenantheadersstamped: DM6PR11MB4657
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of M=
ateusz Polchlopek
> Sent: Wednesday, April 3, 2024 1:11 PM
> To: intel-wired-lan@lists.osuosl.org
> Cc: andrew@lunn.ch; jiri@resnulli.us; Wilczynski, Michal <michal.wilczyns=
ki@intel.com>; Polchlopek, Mateusz <mateusz.polchlopek@intel.com>; netdev@v=
ger.kernel.org; Czapnik, Lukasz <lukasz.czapnik@intel.com>; Raj, Victor <vi=
ctor.raj@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; horms@=
kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; kuba@kernel=
.org
> Subject: [Intel-wired-lan] [PATCH net-next v9 2/6] ice: Support 5 layer t=
opology
>
> From: Raj Victor <victor.raj@intel.com>
>
> There is a performance issue when the number of VSIs are not multiple of =
8. This is caused due to the max children limitation per node(8) in
> 9 layer topology. The BW credits are shared evenly among the children by =
default. Assume one node has 8 children and the other has 1.
> The parent of these nodes share the BW credit equally among them.
> Apparently this causes a problem for the first node which has 8 children.
> The 9th VM get more BW credits than the first 8 VMs.
>
> Example:
>
> 1) With 8 VM's:
> for x in 0 1 2 3 4 5 6 7;
> do taskset -c ${x} netperf -P0 -H 172.68.169.125 &  sleep .1 ; done
>
> tx_queue_0_packets: 23283027
> tx_queue_1_packets: 23292289
> tx_queue_2_packets: 23276136
> tx_queue_3_packets: 23279828
> tx_queue_4_packets: 23279828
> tx_queue_5_packets: 23279333
> tx_queue_6_packets: 23277745
> tx_queue_7_packets: 23279950
> tx_queue_8_packets: 0
>
> 2) With 9 VM's:
> for x in 0 1 2 3 4 5 6 7 8;
> do taskset -c ${x} netperf -P0 -H 172.68.169.125 &  sleep .1 ; done
>
> tx_queue_0_packets: 24163396
> tx_queue_1_packets: 24164623
> tx_queue_2_packets: 24163188
> tx_queue_3_packets: 24163701
> tx_queue_4_packets: 24163683
> tx_queue_5_packets: 24164668
> tx_queue_6_packets: 23327200
> tx_queue_7_packets: 24163853
> tx_queue_8_packets: 91101417
>
> So on average queue 8 statistics show that 3.7 times more packets were se=
nd there than to the other queues.
>
> The FW starting with version 3.20, has increased the max number of childr=
en per node by reducing the number of layers from 9 to 5. Reflect this on d=
river side.
>
> Signed-off-by: Raj Victor <victor.raj@intel.com>
> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  23 ++
>  drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>  drivers/net/ethernet/intel/ice/ice_ddp.c      | 205 ++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
>  6 files changed, 239 insertions(+)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


