Return-Path: <netdev+bounces-96698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9A28C731B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBF41C216EC
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B3130AFA;
	Thu, 16 May 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eEloO59t"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB98237142
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849091; cv=fail; b=AcE9ZvpfiEQHLt/EsVnqAIZ+mqeWzhtU6KPn6CWTbpFZO0p2t5lKODalWEE01Jg9ub9GllGt34ICktIUeVJpMY3QYgYi7OhTvnHDDnpXIr/bPraqAkUzCAV/wfUPqD+vlymdKdGZir4yJMOC93p2mWAoqCpA39lS5G/wTwt9wsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849091; c=relaxed/simple;
	bh=PTo+zaKmN42sLX0PHlRZWv3c0rdzhWaobBqRrGq7w9A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O+tqTI3q1lGj9ZivDKzPPjbhHMBoq4GWuoDAlOkFmQXXsyiCY0HuUZZk7ub0fOGRBQzOTa5e2Phsut/0LRQmC3m/vw/5JlBzhKS5Mz0rLpWU2ZPnwgmtuNsmnpL4mj3EO1OysWfNRfr0VqNOyV2Jecp/IrHMu3wm0vcm7uJZm/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eEloO59t; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715849090; x=1747385090;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PTo+zaKmN42sLX0PHlRZWv3c0rdzhWaobBqRrGq7w9A=;
  b=eEloO59toMW156p/sMew4oi9dBod0ZWLqmWUE3l/FPHSFIjnxtekHujk
   QrsE8u7WR27m+3x8aODGmlLBCKs8OaLMrYvO484StYirPUEBypaNZtk3s
   2LGwjDdNEAJncNpJIwR550FBfQpP8eoVVdwK/2kysbtjDdRBUdJpTafD1
   OY3E4q4awjGTlIoyobqQecrtFKH0yd+a9CkYdjNMmn8j/V9hEGKFGwhRg
   6VdCgakzylTKI5gpmrA6tK6Lgd40gysZgL7L5iZK4Zg4sgtj2VszM/Y59
   glVabm5wY2Nyb88DAwjJ4lPbD1TC45zbP1zEVMmHLoT2ORAZvKHPElvO7
   A==;
X-CSE-ConnectionGUID: 9FSEdsnoQHOz79oH9fOkKQ==
X-CSE-MsgGUID: kbOGR+O7QAOXoPOk+OGrMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="14897377"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="14897377"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 01:44:49 -0700
X-CSE-ConnectionGUID: AGIX4JMMRYaTGhGVjaFi/g==
X-CSE-MsgGUID: IKQXVvDWRIK8K6ouq7il7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="31778908"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 01:44:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 01:44:47 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 01:44:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 16 May 2024 01:44:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 01:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwDMxNEKbgpbW/0cWkG8/JYs5U0t2O4+hoCeR4o1Eso5EPr06ocxfM1dfam0z7vVCCbyUPrlOadS5Vl1OUFMkDh7iXqxN3G1EnK5KCi7kU07RjyjO8mJQtV2EVr6NsWmc+s4k8h8b6VdrvYkiJc0iDikZSLWsqFp6WS13+MLHH6NPNKZX3AWOyk+v4C7Lrfz4zVRbrg3CMJp4bz/7swLImmYUAKaUPprS9w0wjM310MhGbEuCHNzBfzlaVLIomCdm4vMeZQIj38ewFHYzqRV5+7JcHV/g+dFrmrb9h2KN2W4B9c/MOxAG64yFIGTAI4CkkAS+hs4s3kpgkMRHVyzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufnOeeYpVZFRygaQZEBdBdI/jfiBEdT9dC87JFUZGZ4=;
 b=HiWDlfzgN8k0nvvoOoXvL+urWoGxKFHzA+/Xtop0hVYoyvjkmgzCFAkSxrPOMph/d5QrTHWOxE5g4VEd2wmWa2I5lcCx1rRtyqnoPhsDF2gPSY8FCLR6jSFZfbMq/8X1il2/bFB9wzPKghmhUToeymo87bqVPAy07aebXi/XeQElT2jbFtFTSwLzlRepenMIBBI/uwjfBdeBHfh+nT5Y8SFutEBkQhz4+LwC8WK/PtipwoXA6ujZ0Q1vv9k5SgCFgaj0xyX5WxUzGK8YdX2ttv1AqEFdIWqyU8KlfJXW4JPVLVwFdghFAhYRZ2VLa3tRTyRp4tp++neNpVUJY0tISQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ0PR11MB5101.namprd11.prod.outlook.com (2603:10b6:a03:2dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 08:44:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:44:45 +0000
Date: Thu, 16 May 2024 10:44:39 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, netdev <netdev@vger.kernel.org>
CC: netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David
 Miller" <davem@davemloft.net>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Chandan Kumar Rout
	<chandanx.rout@intel.com>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Igor Bagnucki <igor.bagnucki@intel.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>, Simon Horman
	<horms@kernel.org>
Subject: Re: [PATCH net 0/2] intel: Interpret .set_channels() input
 differently
Message-ID: <ZkXHdy6bKGUhIJfO@lzaremba-mobl.ger.corp.intel.com>
References: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com>
X-ClientProxiedBy: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ0PR11MB5101:EE_
X-MS-Office365-Filtering-Correlation-Id: 25618be6-dbbd-4a3b-5a1f-08dc75846fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QIYosDNxI8pnD+RQ1oirqgC6KT/FwGHuWh0CC/4KvCJxDYT9g8JujBmVKdlr?=
 =?us-ascii?Q?P038PUSJ6p8WGiCZDcLUYw8lCZEgcYvZJ9L6ZQ9Ux1HHh16TBNfc1yxKT8/B?=
 =?us-ascii?Q?Ps1Bapz7caf9QJB8iwl7bkSyvDV1HujeiDhVemydCA89/JHlfec/iS5g+OhJ?=
 =?us-ascii?Q?jEi8aNff2He7/H868+l+zUyIjqFo2RCyysmYvkWCaIKZFLSeoHvhF9pq+v2R?=
 =?us-ascii?Q?MlUVYPgchbyxcuE505qIgi2lZkapCH16ODemFQQVH+8rx0gtoMCh9owKRhMQ?=
 =?us-ascii?Q?NaQCeOsAeeE05gI9zmKvDFSjZCjaChmJXC6BMqKKgep7/F9Is+jKMd1y3QBu?=
 =?us-ascii?Q?FmkIDfazilVutdScVeushTf8oYSBKpmGniAEWQ7gN2D748qInftf+ZBETaWV?=
 =?us-ascii?Q?AoGblmE+UWjBmP54HeMTbJ9DRUQARhG3sB/n7DFjYO2tIQP+PZQldRcDNhm/?=
 =?us-ascii?Q?SKlWJ6RGD4HrA98/2NQk0opOHwqyMNFVuiJs8sud/UPYq4AsYru/xWow3CSa?=
 =?us-ascii?Q?CBdUgx9TnsaMioqeToRHlk4g3PdzYbKykWATDTJMxAr4sOM8ZbvDDWUuui38?=
 =?us-ascii?Q?9GcL4TyaRjAVvaeipPa+4+ij1bJRktfbovcNGiWK5Cs0R8uEaDhPza7rnueZ?=
 =?us-ascii?Q?oDa820UWkEZ6xWC3mtRdL7PvYODyx+pCOYt/4imSUoHyE8Ognmi1wBe4oq//?=
 =?us-ascii?Q?B9IC8ExVEnVEFwzQbTWpT8vEvzsIf9ZsxrmzdLO9+PkyDnWllyetgGBHlrFO?=
 =?us-ascii?Q?MLaVfZddgdqE1xh+zxnmpa8cFevtD4GgenAq99UVaKaYtUtfXlCsql7+xRss?=
 =?us-ascii?Q?WVQg4rmeOLqhHqkO+Pjgek77EXp2h5Zy5zQylS5sUX2AiuZjKCxk8G3lihPu?=
 =?us-ascii?Q?JckDnSLw+O7RTkwZbkKBlCeMRUZB5OSnz1Wby5Ujlf7RZtiCXE1r4KJI6YOP?=
 =?us-ascii?Q?RopqwTfKOB79u5WKPDR0agrqzFgfYB/ab3+pVkBdmZoOVfq2tskyak11jdXj?=
 =?us-ascii?Q?ORbsyk9fq8fngheaepI6xCpzMLSEeqiWyoSFzyOBsCdUPinmOlSYkRoQmM4a?=
 =?us-ascii?Q?Uj33nsWGSysT6m3bj/NRURN6Q/yHs76i/TTt3Sht3SKPqBGhoQ6i/JF5Mc5h?=
 =?us-ascii?Q?XBBgOs7STIpgNT8QKPF0SEUIKWsJQ7fnNWRU2w4nkvsEonPQ6zbKQb1nUVJM?=
 =?us-ascii?Q?cxB3XYNd82+8SRlvJuHMt4Tr/zoE3PVLr6Q3ER+2nbNUl//naWztpsuRF2hh?=
 =?us-ascii?Q?ZDoLgiox9S4OuiJRP07pKoDAJH78qdnLKAOn5TblCA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JVd4tIcHVGvqW7u/90txkinvD44LZyvpwQjgS1AWbUc7JMnmfYr5PDpGei7c?=
 =?us-ascii?Q?9w5AZ13o9Cs52n2KVYzkThmX106FVdWttpTdajn5LyWouttUHQrENdRcwE2q?=
 =?us-ascii?Q?60ll2lJyNNzq9khTQBpytGeJMrmRJWrdL2uRdb5dEz963IVHlmwJRDYzC30u?=
 =?us-ascii?Q?8NhsTuTSa5FB45gUJLnH/Hno+69/ENUWl1AxlSs5l1x2pLZCYtVlnHY6NSq0?=
 =?us-ascii?Q?YzStQbk/9jSx8UdLHRd+IotHEEwwvX1pTRjZ1SNeG65zfQ+tZP5npUTPUOS1?=
 =?us-ascii?Q?nlEl5IzCXa9UNdjsEx8ET0bLVf1lg/DCsTd95w0JO++OqXLlBOFEqzwxBH9P?=
 =?us-ascii?Q?Kt0g7dCh3mLdLe5fV025qLRFTuOhtaTNJM7w4e7AbJ1AH3FU7qLsmtKpHnYE?=
 =?us-ascii?Q?Z+QImV2g4dFBzHpoUG+aDo2CweXLH9BtFd/zEqF7jOsEqclEzcCsQ21jGLPh?=
 =?us-ascii?Q?leO8aAfFT46rFRYw4nuQiDjXPEbMEL5/fArF52vhkiNPXwd5EnIqIBsBlAkn?=
 =?us-ascii?Q?vT4N/lBDYfI7LDGLikmbzSF1L9CaULyYvRX+yK0S504SSlDk2FllaOF6WdgU?=
 =?us-ascii?Q?FQ+NHsch8QBNvIF/gbp0AeYpwZwup85DrVWkh0UlWjvlVG9147QGLuoZLXJ7?=
 =?us-ascii?Q?Qh1qZ41h2FdnOksjrGImNtihQkL0n9nEIpl2VSIc5/jOEu79lXYNlvvHwazq?=
 =?us-ascii?Q?LsAbKGpU9t06kM6jS8HPrmRYfWju18BI3dc8YpZu8KgvI0H7dqD5hVe6U6e7?=
 =?us-ascii?Q?Qa/vNCdn8zxePqul88kWENyLYqDbtiCcvzU17ay0zsTg0mBtEeU2S5XQ1yk1?=
 =?us-ascii?Q?BqWTtN1cvLREayj/GTjpf3YWJJMHEUWj2Ae1s5XYsVAzFMx6MbemauRG93DX?=
 =?us-ascii?Q?PxYBXFtSWSnb9eEUODBUxzsSaFC1TX+/bBjOms+qWDyNBglugtv9VoEwuEPW?=
 =?us-ascii?Q?0+ykrYTSqOYCsrlodXCuUuAMug+WRghtnW87T5SrZPEVEpVU6UDLRwEtiyCK?=
 =?us-ascii?Q?7TmvNhNsIfj1Az7jHgv7V5p3cyQ1Q1szx4F+GWhCZ91wjzLVaVjaTxJfWt8P?=
 =?us-ascii?Q?vIzxomyFQ7aztSjZC6HIHlj3pOW5ZcR19zZUbLuZ82gocD1aKiAoWYOSINCg?=
 =?us-ascii?Q?uW/3HG228kgBYrG+JYD0L5EoogFVR6aIqgXMdjEEkg5a9xWVibpsY7sRNGWf?=
 =?us-ascii?Q?401X04RUFf5/SrQUqljUREGXJO3gAwrixWJGbkkOVejIy/7KL9lwfeH2jo9Q?=
 =?us-ascii?Q?23pYb0MNtTRfTUhwVdU1WSqeCJ1W0CdZW2jbtC0hmL3qSBk1dwJJI7Afpuwz?=
 =?us-ascii?Q?vo7kHuwYQh5IzX9F42gntF2vt8mY4Cxd/NEIn2T9ZpTgDDr2GzVZkKQpmU1H?=
 =?us-ascii?Q?u0Y+IUYNanVtBhxhqS6HcAG9Vm4TlJ8RM6w5XOktPGnuFE9R75NBj4K99NcS?=
 =?us-ascii?Q?o7bLgR53vQf9Ha2JjFhbJXHwpBOs81rkmfzlScEjOC+RvR57ATF/7wOWV1Lr?=
 =?us-ascii?Q?haRdPqGHnbFfFV7qOicEC5ScaqdyVGZlBUz35XCjoMJBht7GUgS9T7JHpjH3?=
 =?us-ascii?Q?L/dHZMf2YiibcgjhLTWYBX5wdkxeqQVuMyHoDjpZYI2BhZRSY5o4pZDIhbY+?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25618be6-dbbd-4a3b-5a1f-08dc75846fff
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:44:45.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4NrLLn2PmhbXkSKOu+zraJPc98edXXY4J/oN9XRY8mSAxYZy9khoNlIZTKBW3ZzEsFRBT50QwKfekt2wD6NpolMC40cCtv4pjSxAJl2da0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5101
X-OriginatorOrg: intel.com

On Tue, May 14, 2024 at 11:51:11AM -0700, Jacob Keller wrote:
> The ice and idpf drivers can trigger a crash with AF_XDP due to incorrect
> interpretation of the asymmetric Tx and Rx parameters in their
> .set_channels() implementations:
> 
> 1. ethtool -l <IFNAME> -> combined: 40
> 2. Attach AF_XDP to queue 30
> 3. ethtool -L <IFNAME> rx 15 tx 15
>    combined number is not specified, so command becomes {rx_count = 15,
>    tx_count = 15, combined_count = 40}.
> 4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
>    new (combined_count + rx_count) to the old one, so from 55 to 40, check
>    does not trigger.
> 5. the driver interprets `rx 15 tx 15` as 15 combined channels and deletes
>    the queue that AF_XDP is attached to.
> 
> This is fundamentally a problem with interpreting a request for asymmetric
> queues as symmetric combined queues.
> 
> Fix the ice and idpf drivers to stop interpreting such requests as a
> request for combined queues. Due to current driver design for both ice and
> idpf, it is not possible to support requests of the same count of Tx and Rx
> queues with independent interrupts, (i.e. ethtool -L <IFNAME> rx 15 tx 15)
> so such requests are now rejected.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Please, do not merge, first patch contains a redundant check

if (!ch->combined_count)

I will send another version.

> Larysa Zaremba (2):
>       ice: Interpret .set_channels() input differently
>       idpf: Interpret .set_channels() input differently
> 
>  drivers/net/ethernet/intel/ice/ice_ethtool.c   | 22 ++++++----------------
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 21 ++++++---------------
>  2 files changed, 12 insertions(+), 31 deletions(-)
> ---
> base-commit: aea27a92a41dae14843f92c79e9e42d8f570105c
> change-id: 20240514-iwl-net-2024-05-14-set-channels-fixes-25be6f04a86d
> 
> Best regards,
> -- 
> Jacob Keller <jacob.e.keller@intel.com>
> 

