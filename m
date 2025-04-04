Return-Path: <netdev+bounces-179288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F648A7BB35
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 12:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8B117BAE0
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 10:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7C91C245C;
	Fri,  4 Apr 2025 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLNrd9SR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA03A1B0F31
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743763965; cv=fail; b=hXv0NKozOEnPKkln2ABsdzqASVKSsRfgnEXN4fhHsZhQLCZ+3SqXhpW9VuyIeypeQBQ6vrlxeQGxG9imNtvfcIm0vR3RzqyNF7tpBXgmYJXX1A33OBqIcOXrxrMGMktaYXmDZtJDudVhLsPTwDaQViYqYpDOngAgk0ZLn71aq9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743763965; c=relaxed/simple;
	bh=yh/yaiVL81LmfPa8FBV3xyddvTMCZz3Txoap/zVK2DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uIXzvaRIBfZ2XSJSZsN1MNRUEE42PWisfIz8D5djAwikLOrxUoHYVRdIn5E5xBBB7IeMVkuj1P6YSahzsX68pMSSjvhbckglrxz1+/Mr+CC/HVAPiJ42Nvma9EnCsvOthcveUZsGcKq13vYvW8nnChOL/ZRisc1UM6IeRJykJfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLNrd9SR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743763964; x=1775299964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yh/yaiVL81LmfPa8FBV3xyddvTMCZz3Txoap/zVK2DI=;
  b=PLNrd9SRW0/v8/bqfklLoNneOf3GXxV82HX0up/gKeJyC3kKkE/xLcvG
   DMjrHYdy0kLe7LB7k1035qpn9DofX2QOZ2PP15ziWxv8nABV0trTNSr9c
   BbQe2T9UvTtTfN5f+o2Vl3tGpVzrwFRy2/UffyHpOtMfa4MWf+mGalsVQ
   ooKISCgfTUl1f6sq+D+COufOE4dNo42gSs3xqMdCRQKfyW4L5TzE0gmzx
   if08FkOSGZMzMipgRpxzcDf+3eb33DOuBWfcf/qiwAIV0oH2mCqhEUJoE
   12VmFJ9Q4TLL17oa/kzjyILS/p0NmU5v2bQzs88/+baRhpqzj1GQFYp1M
   Q==;
X-CSE-ConnectionGUID: aHG9Pu8qQlGbXwubcNJhkw==
X-CSE-MsgGUID: k2TMYdafTTyyeUvxTNZBtw==
X-IronPort-AV: E=McAfee;i="6700,10204,11393"; a="67671989"
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="67671989"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:52:43 -0700
X-CSE-ConnectionGUID: eUw0p/qAQpaExqvpTLS58g==
X-CSE-MsgGUID: k5of2g6pR8W9vYptM+ZC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,188,1739865600"; 
   d="scan'208";a="127261169"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 03:52:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 4 Apr 2025 03:52:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 4 Apr 2025 03:52:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 4 Apr 2025 03:52:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQRQTr56gYUPWfsa92q3J3aqDlF6mJBVQ/ewMF7oOE1DoRufEyafE8cPTb5X/j6crZHWKGjk3V4gwOP/vdeYpcdIGRDQT6arXNh2uKkYLsI/Wr2Y7KFQordyI99R2A2mjXsQjAeuZ6riMjVOYWCqU8NmWFZc3WunLG0rvcVDF/mnwQOVLYiYKuKF18l2BbJT/yhnYp8PRzVp+8LTi807+Jcf86fmmehVqfJrpExE9gbVEv0YJQR92wBtcI5xzaQLABiBs/CEWx25Htdba78qLofqulYSQ91rBpCFTz2oLc4zWbF8RzBX6tNJcAdflhCogEAtN6tK0TUaJxhjvdGtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAtwSVKKnrLuP9nodujRAFSuzy4LwdskGQZON6HhUBs=;
 b=KZ3+lZaTznspABlACq0OHJs+/UytTqs3f/aRqNa1ncnyl4u5E0sTKSWQdZ8z3qOXdpfT1rzkKJSZULpXhp4z0RyYMrc5C5X98o6Jk6naXNp5hLhh/7Bw1pTOFDw6Mv4XGMRAdJygXV5AxsEmXLn6JBCzC7F7xWcmCGQZMTM3ypV+GbF4+ZR0GVjhgtHgh9/GxliIoRFFQSZw0+4TNpZxyaLv8PGnQ/GK7ERjqnblCrC0rSRTP79VLFyUYqv8ih+ef1enLkRBignQCXrBohZ08VFyQMG26KvaJiYtamvzQkE/pzbi1NnbP02y/k3CcXG6LdKi77rUFn/ihlPFy/+ZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 10:52:35 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::90b0:6aad:5bb6:b3ae%5]) with mapi id 15.20.8606.027; Fri, 4 Apr 2025
 10:52:35 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Kolacinski, Karol"
	<karol.kolacinski@intel.com>, "horms@kernel.org" <horms@kernel.org>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: enable timesync
 operation on 2xNAC E825 devices
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: enable timesync
 operation on 2xNAC E825 devices
Thread-Index: AQHbmZrxMND2QEzl4ki/YffvUIj0j7OTaWvA
Date: Fri, 4 Apr 2025 10:52:35 +0000
Message-ID: <IA1PR11MB6241DE8A9BBCCC937C451C5A8BA92@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20250320131538.712326-1-grzegorz.nitka@intel.com>
 <20250320131538.712326-4-grzegorz.nitka@intel.com>
In-Reply-To: <20250320131538.712326-4-grzegorz.nitka@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|SA1PR11MB5803:EE_
x-ms-office365-filtering-correlation-id: 5e522b30-5444-48e2-e89e-08dd7366cede
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|7053199007;
x-microsoft-antispam-message-info: =?us-ascii?Q?fwpqcvQslFHNVZNQmtv3IcYyd3xISaV7QWtRKOKXvQrSaH+6VgxZfFPwxpxn?=
 =?us-ascii?Q?SlDEgSt/EzmVhF+VaxvPjN2L54RW9A3RiwaS9kGRkiVjuL+MWV9mJM3nbwfv?=
 =?us-ascii?Q?JW0b2cZ2jxKFr3XiZNSgd2iPbCzUies1rOXtkiMrb8PXiITonDlJ8lTghnnF?=
 =?us-ascii?Q?8vL5loRZVwVhhrno3aFRmkt0swNqHsrWy/6JlnNv05ZQ1Vv5PKUhFp76Gsm2?=
 =?us-ascii?Q?rsg/32PyQi9ydst0m2ijgCU8gK58GZ2lBW9PSPUoU8KMR4BIwNCdLRJB/DwL?=
 =?us-ascii?Q?qNHJwjRDJ0GlQZ13boRq7atmGtotkCuYERgn/gtlK6sEd7vuY71TUYquUcwl?=
 =?us-ascii?Q?53XVmd/VkegWd+dKrbpg3fEhq1KBUiWLXpa9/pqIs0A6GqPRlnM7/mL5rI1R?=
 =?us-ascii?Q?skGebwr6VtA4WpB+jzfKSu/BLDoSTAFKakt+eSXKiXVhVudzbCR26GCGW78i?=
 =?us-ascii?Q?yAy9oHBrGzGKCjW4CW3A9Sovzqg/WLDZiNUcARMRd9JHW0/+mDh+kO5uYjOK?=
 =?us-ascii?Q?/PKZYFYlb35uilT57BM3+pkX+/vyrksAAVukgAJBB1pGsfaBKmHsUpjZMwKH?=
 =?us-ascii?Q?Hj/bKjFQZaVZ0oSDUpRLfinXj9ASj45ajRojOQJQd9j6NpPmMdx5V4B0ksEK?=
 =?us-ascii?Q?VqBYYayLw45/BT4QysmxclXem1b+Uadr32e2Ipi53P+TVb8vZ/IZ+l8Hx4eT?=
 =?us-ascii?Q?jfcOLWLB/yXSStNYq2J7qYElHUR7QmikjgoZp8zz4zkOXtQtq4kFgIrBamIa?=
 =?us-ascii?Q?7gDwwxEn6jkNFzIVf00fItlRUDP1jeZOhOVQ8Pdq9xCzQhzNEJTSsdCvXphL?=
 =?us-ascii?Q?V//Tn4Ic96q7sv0F4octw/rAJXpxCYXCJzJDvPn8RjdCyA8OrR3acHVQryiD?=
 =?us-ascii?Q?Fxz1FhBp45BNENiq4fMbuScvJBEQleJw8rGOp0xVpogV5nDXv0ZctYR+q1TJ?=
 =?us-ascii?Q?rrQJNrnp/p7AozdGcF0V2Pqup0e9v4epA+8VtVnENs3Edcw0ssfJxIMyf5Q0?=
 =?us-ascii?Q?9/KbWJJRurBFdbOkGDcXwUYludx8FIYQ4XsnJpgWfpMaGItovwfs8tcBntdY?=
 =?us-ascii?Q?PEvujJgU+OZ+eG4m3MzBCFUk4cbARwXPU3Ku5jUrbTAw6OdG1bPsSJEE4fcH?=
 =?us-ascii?Q?HHkg1ue5LnKlG2uhxHeb0dBiT6yY6hzG3C+LcBOdblR3lesTHzW4IuYDv2h/?=
 =?us-ascii?Q?xpXQ0TRfl6CCoe0JFJfAQ9Rqq3R6A/QerDemam1U5oV5orRFsgXlf+Qo9oqH?=
 =?us-ascii?Q?cwb7N1qtzWjeOj9mBdsmG1mG8wJz3tc8ZP6YHfjHSWUmWJ3WUKhsaw58z+cr?=
 =?us-ascii?Q?1f7ODh/TlXjzPTpNi49O1N2N/f/aexakf8nd9prF20yExJNIwoZxpYnS/+ts?=
 =?us-ascii?Q?hDpmdROYRTz9VxUMkHbBKl+lbRE2XQE0gRNWcxoIbUrcTSGhHZa1QCtV6Gvj?=
 =?us-ascii?Q?Hq6uRu6uX+5hHYdTxMoit07VJHdVBJYm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RIipK17dUi/qmf6+BzR4bjpSfT9GQrhiK97D8zd1SWuV0HSiOQO6RUSUDi7d?=
 =?us-ascii?Q?TDVlR45kxwlOAgo0Ci3lsZJbplKue8+bqA+6xgygyqN9gSFkJN0wfzJf5u+7?=
 =?us-ascii?Q?POQn9E1M9SHrunTYWxvfAR94AvUWEvDXOVOP7dVPVxj0dwnmtQBS0AgOWVs2?=
 =?us-ascii?Q?qpdX9erizFaqI/pBj4EvRkMC9nwwDRNZyDXOMt2o3Jy9lvTY+HPtZYEVxhrY?=
 =?us-ascii?Q?4GTSyr543byDhV3xdVTyheMokgNOICyGWiPAAnGULOM5EpeNkDeMht3DGRtP?=
 =?us-ascii?Q?gr+fQXEUjL6tUP95OxGYycqR+xwmc9cCmdiRC5ESLDdUxEHK+M8iNEJf5mJw?=
 =?us-ascii?Q?2SfjwNxbqlNR8sKTTvj1wPPEqbAn6WisSZwzP0MoDVvZEdgILeN4vWwKHPgS?=
 =?us-ascii?Q?+6AX/Rx1nlFEFg5SadyU8HwV6AVJQCS5a5rXO0TK+3WJppxOynK0rV9dS3os?=
 =?us-ascii?Q?87lffkkRJGK5ge6GemeAxpyoFYts878TL4i1GEqzXk4CkMhI6iclRLixQMZk?=
 =?us-ascii?Q?fug9OjBlecDsG/hR6JoSIK9SwpcseKjAosT5Cy1i/mKbRUNwXI3NUQQQgl7f?=
 =?us-ascii?Q?y0q2njYIN1SZJu1R5JhSHm4eRgLg5uAEMXO3eTzBWodZgb9M0mOkQjkhQXjA?=
 =?us-ascii?Q?rvCZHe5fgQChrtfXrlj3wZ+QI2BxtCcPrK2dlxouV6TPy9y7Abcz3ktLZRZh?=
 =?us-ascii?Q?WuN7rMwSoLM3FVCMovxcqE0dBjVqfMQTaNE2ZLZoGonEmzyKb/kLBx/edzc9?=
 =?us-ascii?Q?mDiGHtGLjYtXtYwPHpuRDtf+at7Mz5m04f5IVG4F534yRi5pq6n+mtJ/irUs?=
 =?us-ascii?Q?Jbi8ITOzGI8gOfIYpVFvDfbQrAuY5uzp0VoE3GDgeBTBRYL/W1mnOMR5FYzv?=
 =?us-ascii?Q?H22TdlXqBgu0/su9K4DZ7LiL92W2CT+ZqvQ+xUoNXwvk5O80351Njg8fRfhX?=
 =?us-ascii?Q?0QVz9LFirkzMpAgv5Qh9zUc1evdIL6YLxzo4fAKpirfyi3B8tnbe1LFQy2uw?=
 =?us-ascii?Q?2tDCEZuunA+f8uT0rm1au+7CWD2hsTMKENNymk3+N3IbCcGgDRhfoig+RdH7?=
 =?us-ascii?Q?l4/sKnPrmf4n9GwqBb8gm475m7R4h6xrehZHTlNGdXgCRKXE64VjBobox5hi?=
 =?us-ascii?Q?S9MbVz/NAg5f5w37wivFGolXUzsfuneoHWPreeFkYL8nlcFx84nHUmIEcYjn?=
 =?us-ascii?Q?WGcT4Z9JwE9vnGd+fEmYUsjZSAuIe/4TDGZN5Q5G8guKxzJ9xSdTF71xou66?=
 =?us-ascii?Q?ze1rbSBOm/WYVPVM67gmiaSkGXdJnRcI96FDtirl1CdrYNvw1tG+N7P+WQ5A?=
 =?us-ascii?Q?FToggZtkM0zfGXx80Hq981SheDKOfxxK0C9j3dcGjiw78h1qbnp1J33F8ALg?=
 =?us-ascii?Q?wivHKFWeZiGXg5/PK3zITPyKniExKmCCxuyJ3HspZ6Qd2jIPhcGHVAvQZHgX?=
 =?us-ascii?Q?RllgIMuv20uKR9VzChSDcyiimCqXlfQaJafg93zpPOjJWUWUIbRdoZinkkuC?=
 =?us-ascii?Q?gmuKWyJFALcYdpQDMun9NSn4uHP6z1rYD+/jQxFEDZ5VbYkKDTqnITQCK/Ut?=
 =?us-ascii?Q?s5n/0dK5HpkXW8FjHfgBbsD19ms7T3H19OpsBc3M?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e522b30-5444-48e2-e89e-08dd7366cede
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2025 10:52:35.0585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P92CfFwWeGuYWsBukoB0mCyRN6HV8PcfbtCx0MOJD8O1eMHpw1DhJbai71sZT56f7hN8nslEu1QcJjaW3dArKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of G=
rzegorz Nitka
> Sent: 20 March 2025 18:46
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; Kolacinski, Karol <karol.kolacinski@intel.com=
>; horms@kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-next v3 3/3] ice: enable timesync o=
peration on 2xNAC E825 devices
>
> From: Karol Kolacinski <karol.kolacinski@intel.com>
>
> According to the E825C specification, SBQ address for ports on a single c=
omplex is device 2 for PHY 0 and device 13 for PHY1.
> For accessing ports on a dual complex E825C (so called 2xNAC mode), the d=
river should use destination device 2 (referred as phy_0) for the current c=
omplex PHY and device 13 (referred as phy_0_peer) for peer complex PHY.
>
> Differentiate SBQ destination device by checking if current PF port numbe=
r is on the same PHY as target port number.
>
> Adjust 'ice_get_lane_number' function to provide unique port number for p=
orts from PHY1 in 'dual' mode config (by adding fixed offset for PHY1 ports=
). Cache this value in ice_hw struct.
>
> Introduce ice_get_primary_hw wrapper to get access to timesync register n=
ot available from second NAC.
>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> ---
> drivers/net/ethernet/intel/ice/ice.h        | 60 ++++++++++++++++++++-
> drivers/net/ethernet/intel/ice/ice_common.c |  6 ++-
> drivers/net/ethernet/intel/ice/ice_ptp.c    | 49 ++++++++++++-----
> drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 39 +++++++++++---  drivers/=
net/ethernet/intel/ice/ice_ptp_hw.h |  5 --
> drivers/net/ethernet/intel/ice/ice_type.h   |  1 +
> 6 files changed, 134 insertions(+), 26 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

