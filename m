Return-Path: <netdev+bounces-105605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0477911F2C
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32ED1C21686
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906CA16D9B1;
	Fri, 21 Jun 2024 08:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6UBgu2F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FEE16D9A6
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959563; cv=fail; b=J6tCxnH8gAyMc9RpS9owxQ+1o2uEfgaCW8dgWHS1PWZW1c8KUFcbWM+otIYpWlmeVLTmHPPyKTNSPkrUyNCDT5SuTLLcgygpnJHM7h+tWa+zZSgeo1PUVTlSALVf4DzpVbHUufDl0ICCrtcHRx3rm22akK3qXjfvulzdAQohqNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959563; c=relaxed/simple;
	bh=Nd59MTaTPJPk6DsvDaloIMsBerLOtNOQemgp71pRLwQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=paJL2ZtAp/ifKeDDMcR6rSPQIm/50eyxP9pXtFMwLJ/b+YB60iu0oycWxPNbvPWWB2HYWySyTNE2y9yI6JCWa7DVXQUFN0hOJqPhR4qiir8E3aQXRxEKMZkpgddegD/gZcrB0Uppht0d94+q010pvYGBY5GCFDUnk8/0IYNR9aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6UBgu2F; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718959561; x=1750495561;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Nd59MTaTPJPk6DsvDaloIMsBerLOtNOQemgp71pRLwQ=;
  b=h6UBgu2FBIjy8zfOCYCBUZ6f+GLIa6sf7YK9hKmv+rLlzGtUfo9LzV7X
   soBdb+QwRJakCQUMA/MGWu36s9c34tRxhTfODG3G8RR5r9xPgDlyL6HEl
   /rJHTshlEnOMde7uxWDlhHnVpVQb4uVpH/QHIWH2bjuNN/oduhnKJzmRR
   OAH0xdM+qRElhm44+cY3NaJKUC6IAtXbYUWF2Vs1U/OwyJinCzp0XGp5v
   luaIezcDmL9ILCA/Cxu8wSM/NLTy/TgIW9VRETCvNr8aRKfHq6qtScLtU
   gZ7iUlDi909d45OI7Mu2kEbd+Lxz+McVkjuw95zmfcymN+Mv/eTI1T2Ci
   A==;
X-CSE-ConnectionGUID: f9gcJa+0RZujpE0PWppawA==
X-CSE-MsgGUID: TdF1LhyUTIi6BPPET4Oxtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11109"; a="38506254"
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="38506254"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 01:46:00 -0700
X-CSE-ConnectionGUID: oVCY09F0RvamSVUbGJERvA==
X-CSE-MsgGUID: 2iLzkvD8QlGmKXmeQQNn2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,254,1712646000"; 
   d="scan'208";a="42622519"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Jun 2024 01:46:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 01:45:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 21 Jun 2024 01:45:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 21 Jun 2024 01:45:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 21 Jun 2024 01:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPZ69AbOiHaEsdCSn0ueox1fWYkAWyyuOZgI7aLYX6O7fGShtT3wngIKRqyrvwNgO5R/QHT7u97UkpiY41UAJHlD/s5EmLCfPXaNJOgEa3K4PI0gLJUO7a3bCUOec8dukhtR6HXrkSW3PnaJS0EqKEqbFWpF5jR7bcQq3k0+w7w8ZKS8m4ckKJ/2R06QusPob3eIlJGm3HOuw4M9gahixFGaAkvqORppmH74Y0762lZ5kBL4LSOlq8YTyquXrMZIU9ajaFEKL8ktlMG91O0JncETMfp8aA9dT/07gh1+abYDgyvzOWQ8+shVRiPmELW9gTwAoKUvYe4y0hhVQoB1Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WkVWhQ2CeGjKFnSHDqyRQfUCv1WQIGsXHisYeTzFZw=;
 b=ZklNgQHWj/AbOJZURE2j55WRo17JFuUajlWmpL3EiOx5zJCy3WDHBkZSZePSIqBGyIAFXQPO8ydXPtf1ZAL0uRwq2i15SJu+z2y0SMaInrBKaUqnBiXG74nIVrH4HB1CPqo91TnpfSDZtQbnGghORpW+yj4AM6LUwcVucGRODG5Ge+8z2TuhGXfDf0Kd8os1f37cYEifdqeihOEyxYt+sEVBXCpsg4GrzjxuWfKU/vdx6nD2DR7+0+1zJR5fD8vpzR8gwELJ2GNjinckVFcqgNknEQVvuwucZuSyF7kFKSMm8cnf0eHyjNTIu9RzB83afjXH++B2f9Oy7q+lN0UJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 08:45:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 08:45:56 +0000
Date: Fri, 21 Jun 2024 16:45:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [net]  934c29999b: Kernel_BUG_at
Message-ID: <202406211653.493fbfdf-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: f0ffc8bf-855f-4d29-0f91-08dc91ce90c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iaKcu+DRVzBtBUWi7AcyPg1qiY5Rts7vhb+cQIcWLvb5/si6P9PIHnZ2II0e?=
 =?us-ascii?Q?13abY5pUrY/RG03mL2KCUib9OnQ8DnN8vbADOsYp1IMa09Jh18wYQCAVwosH?=
 =?us-ascii?Q?k6HtDLGPKNnUT15ADzZpNcw3r68N+7zZQjiJeOCBjUroPtyivRy+WZ2GR0ae?=
 =?us-ascii?Q?6U/jKnouMkLgy7wi3hJGZgc5/6owmXFk9EIcCGBJQZyvwWqLLqxazVA9khOl?=
 =?us-ascii?Q?hr3x3TRB7oYzyML8Mh0b3UxT/04+3hmgpGgn7u8HHt+FY2y2Ige8GClQEqbF?=
 =?us-ascii?Q?e43IGIPjdL54LwaGa8FcvUSv1BoGwWey9+hEG7DHdSORQHcVsvUzPZBVEuYR?=
 =?us-ascii?Q?EGsUiV70K3LDoQyqoziAXoS71RotDoGju+SGYcrtiG+zKneomsDUx/6Cac8l?=
 =?us-ascii?Q?gUmtcB6Plyxf4VgT80CqqZLWl28sj8hBQxFAfpLu6KsP5iXKR1MQwQqTBz+N?=
 =?us-ascii?Q?OKIgOzVuNmpg7v+CAZX3usAFt5InP5+PmHgaXl6xoXJEZDIhvTWCzXg6JEA+?=
 =?us-ascii?Q?ztWIsWspL/85ZAICFwHgyslfLb7HC+J6EhvRrQ7joBRHWVb87XRUqjggruqA?=
 =?us-ascii?Q?C3qygGjERj4XbRBALZ7VLB8TNfhJOLQ4m2C74HkS9A3Rp8LmeOmeyKYqS5Up?=
 =?us-ascii?Q?qXhR557AvAvirpEbzDD1paE/1HgDcwzIkGlTTj7E/+SHFU9uuu3iNlj23bHA?=
 =?us-ascii?Q?4i282l8/roUfVeykGh7PoR6d3d/0FQI/9Wx2qosCBtccO1WRgmyp+4AJHW+n?=
 =?us-ascii?Q?JssmQAx1ArSQz1pMfi8BcPx8wHmTnMRTMAEAwWq0IxbkOnpo00fl5FZTKmIp?=
 =?us-ascii?Q?Fz46IwBqidOLLXuRbflkyiZ3YGQc8mcdJOcX7KgeFSJ63ux0AZQ2Va74By6B?=
 =?us-ascii?Q?ITfU7j4foxXQGeKyfCbCOaPWRJP7kwAHwYA6J07aZNx3dXy6XXuZkg/lFBLu?=
 =?us-ascii?Q?vJ9p4PEFn4HSacYsHldto9RzSykk/nfuNVeX58UhotYrxLjrTotndnSEDWGy?=
 =?us-ascii?Q?+CIhPyMQ3Oqy/gdjvTO0HN0reQkm4bp4/snNj9ZYoA4oeqBp746f6U5oLnkt?=
 =?us-ascii?Q?FoM/DAR+KPjzGYTagkJT3sxnBRXvSqexMRclaqIkGxm15Xqw1O14cs+XZAty?=
 =?us-ascii?Q?ryt9SK+6O/m49eCKkzwZaEvG3cAl8kkI4DotTKqe7A/RP8ArQhufdd0MpnEb?=
 =?us-ascii?Q?GMcDL0SroQ+kGKqdqVXfZo0/S7SCPkYMs0c8w7MXBX71xJp8y2D1oycUQ52v?=
 =?us-ascii?Q?xKEh66FzZtD3n7Cn6tXwRmpUHdNKlU0GOPP5N55SDw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JQS8lI3olDTWwELBNdGc+KZbZwHVknEa/JC8yXdQC41wM+0Iyq+MC9SPxM5h?=
 =?us-ascii?Q?n1jVIAgGBi09906sJAK8RhrLMLmMrkm9O1h1eaZtM/bOX4yqEgBIx+01zQ/Y?=
 =?us-ascii?Q?susawXMjd/kFGi2QLXH56WPPDSMZ0ZtW+i1U3BRnF86rgnT4MBoVA8JK5tOd?=
 =?us-ascii?Q?GJps2Xl1ER2sPgQQj28lwZZ2t+XWXNIvQBzOWqxB8m6WGkvLHpi8CNOh+OTt?=
 =?us-ascii?Q?LsIw2Yn/pb40onqS5CdtyKHeweHZgeI9QxcuPBsz/UaJfaZd4bGYf8rArFrw?=
 =?us-ascii?Q?fv5/0az6MZ6HULpBUuxi90cjnQzo5XfvJPd0ZEQ98Q0gkVMdg6DYas/0q9HH?=
 =?us-ascii?Q?H55Fm3/l2fp17pjEpMLIsUQEUMMEJOoEs3MGM78+czCCls7Sc40BP5bpAZpY?=
 =?us-ascii?Q?M2jf2KrMu07GtshuPNc/13tOJpHUCQUcZprjqdnbHQNq7IRDy87BvKDp9jtp?=
 =?us-ascii?Q?OCC45iTOoF03Jlt7VBOZd6PrkOfJPfvTqdAWYwh6fIOVXLX0KyJGOvQF8pTm?=
 =?us-ascii?Q?5TtEPijxU2YeL1Z53vj0Dml/MdxmrQpaDZPQvnu90mrLPWHUsb3TW+Rwdbev?=
 =?us-ascii?Q?nHcFf3kMmX3E+keiE8YMS2S6WUe9XHK7PpW8l3MacywQKCVKfI9VyYwHnGFv?=
 =?us-ascii?Q?I2vXe5vhJUUGzU+PMZ3/PT9rWD18IFzdmVciMENNdMEjYNUn+weiSLntlNyC?=
 =?us-ascii?Q?BNkshfeI8veSdmsaRVYrBNtHsMvCFwM9DIWF8cTMXii9vV8qcmmLdVkEpSnu?=
 =?us-ascii?Q?7mPggZRciOaJ7tqoFPDCujlIP8+3yeiognxIHc9yOm4tWsSGBuwSI4H4G0F4?=
 =?us-ascii?Q?nrD38rKs9m/PyUoTS+3+ceYIrsM41KrJjw1NXcd6rPc7H1cQsgZVFG404JTq?=
 =?us-ascii?Q?+wZhe3w6aQJd7fvEsCIpXQ1/PqGB4iTe6n3yie2Df91UA9u/rr9kNPsAGE+D?=
 =?us-ascii?Q?TQzqlkkfdF4sH/2N6L9zYBU1AoCYRrb/rgXX00hF9u+RJ6G0djUZfmeBs0Ok?=
 =?us-ascii?Q?tGVZFi5vgfOpTFN7SESey4lkuBDMdMxaCh78WDpd7crYEqRAkaNGo472JW8X?=
 =?us-ascii?Q?Ri/FgnPjf7tA7ChI0qu9bLHTDdKDPlN3AbCCP4sPEk/JnNchYA8M1ukE695g?=
 =?us-ascii?Q?DHOT7mRbDcr9/P3GfW8MlbS2XzfhtYkFOv3CjDbaFNbOwiYbWAuttc2qw5BW?=
 =?us-ascii?Q?mJGm1PsvxvHoDNA0JVlpclNAcuinhUvmN2n+1XuJ3Br4oOTazJc+S/vt9OT/?=
 =?us-ascii?Q?GxJBswAZ++ADRuOm0+86/OoE/sQzNkaNFB0w7LmToAlNjBf53TnWpyW9QOet?=
 =?us-ascii?Q?cPKhppuNzbssJHiC9RPkn/WXpDHY7mMf7UUgwdyudj9ryRVqYCGdC9ZzCgIC?=
 =?us-ascii?Q?b4N4x/mC6vVNl+A7+qEuOSQRnLehhFyHSVpt+JvSnnH778mDCijsRJWuke9M?=
 =?us-ascii?Q?NHAhT/H0CR8jmLZymuAUzHXV7wbrOJjSCRpnLwdvdg471H/m0fBqhrBVerZH?=
 =?us-ascii?Q?IOzG8kg/TC+w4JZEGHR6loXtuNCInOvs6/RdJUX17yCfRHqgWg9qS/XO8Bqe?=
 =?us-ascii?Q?atE46QHOUu2hvR2mirrEZee8udmIUtZQqY/KdVrKo8rqNUI7/gq/1wSifv+6?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ffc8bf-855f-4d29-0f91-08dc91ce90c4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 08:45:56.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdWWKOdRt+n5LjN+LEUi4+ZKz8PSX+LmkBje4cqss1LnV92L8VCRO7/EELQcMFBr0x6aX9Rj4A6PRRnHH3eBxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com



Hello,

we reported similar issue for this patch in
https://lore.kernel.org/all/202406161539.b5ff7b20-oliver.sang@intel.com/
and we saw a lot of dicussion there.

now the patch is merged into linux-next/master, we are not sure if there
is a fix or debug patch is on-going, which will be our pleasure to test.

anyway, just report again FYI that we still observe issues in our tests for
linux-nexts/master



kernel test robot noticed "Kernel_BUG_at" on:

commit: 934c29999b57b835d65442da6f741d5e27f3b584 ("net: micro-optimize skb_datagram_iter")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 2102cb0d050d34d50b9642a3a50861787527e922]

in testcase: boot

compiler: gcc-13
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | abef84957b | 934c29999b |
+------------------------------------------------+------------+------------+
| Kernel_BUG_at                                  | 0          | 6          |
| Oops:invalid_opcode:#[##]                      | 0          | 6          |
| EIP:usercopy_abort                             | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406211653.493fbfdf-lkp@intel.com


[    8.659454][  T161] ------------[ cut here ]------------
[ 8.659874][ T161] Kernel BUG at usercopy_abort+0x58/0x67 [verbose debug info unavailable] 
[    8.660744][  T161] Oops: invalid opcode: 0000 [#1]
[    8.661134][  T161] CPU: 0 PID: 161 Comm: systemctl Not tainted 6.10.0-rc3-00688-g934c29999b57 #1 63c7b7fbd2f7622d539d732370d21837ac16d760
[ 8.662098][ T161] EIP: usercopy_abort (mm/usercopy.c:102) 
[ 8.662483][ T161] Code: 25 40 43 b9 c8 38 41 43 eb 0a bf 9d 73 50 43 b9 e4 ce 3f 43 ff 75 0c ff 75 08 56 52 53 50 57 51 68 d1 38 41 43 e8 50 cc ee ff <0f> 0b b8 4c 09 c7 43 83 c4 24 e8 c2 69 42 00 55 89 e5 57 56 89 d7
All code
========
   0:	25 40 43 b9 c8       	and    $0xc8b94340,%eax
   5:	38 41 43             	cmp    %al,0x43(%rcx)
   8:	eb 0a                	jmp    0x14
   a:	bf 9d 73 50 43       	mov    $0x4350739d,%edi
   f:	b9 e4 ce 3f 43       	mov    $0x433fcee4,%ecx
  14:	ff 75 0c             	push   0xc(%rbp)
  17:	ff 75 08             	push   0x8(%rbp)
  1a:	56                   	push   %rsi
  1b:	52                   	push   %rdx
  1c:	53                   	push   %rbx
  1d:	50                   	push   %rax
  1e:	57                   	push   %rdi
  1f:	51                   	push   %rcx
  20:	68 d1 38 41 43       	push   $0x434138d1
  25:	e8 50 cc ee ff       	call   0xffffffffffeecc7a
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 4c 09 c7 43       	mov    $0x43c7094c,%eax
  31:	83 c4 24             	add    $0x24,%esp
  34:	e8 c2 69 42 00       	call   0x4269fb
  39:	55                   	push   %rbp
  3a:	89 e5                	mov    %esp,%ebp
  3c:	57                   	push   %rdi
  3d:	56                   	push   %rsi
  3e:	89 d7                	mov    %edx,%edi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 4c 09 c7 43       	mov    $0x43c7094c,%eax
   7:	83 c4 24             	add    $0x24,%esp
   a:	e8 c2 69 42 00       	call   0x4269d1
   f:	55                   	push   %rbp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %rdi
  13:	56                   	push   %rsi
  14:	89 d7                	mov    %edx,%edi
[    8.664049][  T161] EAX: 00000052 EBX: 435c7250 ECX: 00000000 EDX: 43c4b518
[    8.664589][  T161] ESI: 435c7250 EDI: 43402547 EBP: bf159c68 ESP: bf159c38
[    8.665127][  T161] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010286
[    8.665708][  T161] CR0: 80050033 CR2: 005c8afc CR3: 7f060000 CR4: 000406d0
[    8.666244][  T161] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[    8.666774][  T161] DR6: fffe0ff0 DR7: 00000400
[    8.667136][  T161] Call Trace:
[ 8.667395][ T161] ? show_regs (arch/x86/kernel/dumpstack.c:478 (discriminator 1)) 
[ 8.667732][ T161] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 8.668060][ T161] ? __die (arch/x86/kernel/dumpstack.c:435) 
[ 8.668358][ T161] ? die (arch/x86/kernel/dumpstack.c:449) 
[ 8.668646][ T161] ? do_trap (arch/x86/kernel/traps.c:114 arch/x86/kernel/traps.c:155) 
[ 8.668968][ T161] ? do_error_trap (arch/x86/kernel/traps.c:176) 
[ 8.669323][ T161] ? usercopy_abort (mm/usercopy.c:102) 
[ 8.669690][ T161] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 8.670057][ T161] ? handle_invalid_op (arch/x86/kernel/traps.c:214) 
[ 8.670434][ T161] ? usercopy_abort (mm/usercopy.c:102) 
[ 8.670803][ T161] ? exc_invalid_op (arch/x86/kernel/traps.c:267) 
[ 8.671174][ T161] ? handle_exception (arch/x86/entry/entry_32.S:1054) 
[ 8.671567][ T161] ? __ia32_sys_membarrier (kernel/sched/membarrier.c:497 kernel/sched/membarrier.c:659 kernel/sched/membarrier.c:625 kernel/sched/membarrier.c:625) 
[ 8.671980][ T161] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 8.672322][ T161] ? usercopy_abort (mm/usercopy.c:102) 
[ 8.672684][ T161] ? exc_overflow (arch/x86/kernel/traps.c:252) 
[ 8.673039][ T161] ? usercopy_abort (mm/usercopy.c:102) 
[ 8.673406][ T161] check_heap_object (mm/usercopy.c:182) 
[ 8.673780][ T161] __check_object_size (mm/usercopy.c:123 mm/usercopy.c:254) 
[ 8.674169][ T161] simple_copy_to_iter (include/linux/uio.h:196 net/core/datagram.c:513) 
[ 8.674554][ T161] __skb_datagram_iter (net/core/datagram.c:424 (discriminator 1)) 
[ 8.674955][ T161] skb_copy_datagram_iter (net/core/datagram.c:529) 
[ 8.675359][ T161] ? skb_free_datagram (include/linux/thread_info.h:249 (discriminator 1) include/linux/uio.h:195 (discriminator 1) net/core/datagram.c:513 (discriminator 1)) 
[ 8.675724][ T161] ? unix_copy_addr (net/unix/af_unix.c:2866) 
[ 8.676083][ T161] unix_stream_read_actor (net/unix/af_unix.c:2871) 
[ 8.676481][ T161] unix_stream_read_generic (net/unix/af_unix.c:2803) 
[ 8.676914][ T161] unix_stream_recvmsg (net/unix/af_unix.c:2907) 
[ 8.677301][ T161] ? unix_copy_addr (net/unix/af_unix.c:2866) 
[ 8.677669][ T161] ? unix_stream_splice_read (net/unix/af_unix.c:2890) 
[ 8.678097][ T161] sock_recvmsg_nosec (net/socket.c:1046 (discriminator 1)) 
[ 8.678472][ T161] ____sys_recvmsg (net/socket.c:1068 (discriminator 2) net/socket.c:2804 (discriminator 2)) 
[ 8.678835][ T161] ___sys_recvmsg (net/socket.c:2846) 
[ 8.679188][ T161] __sys_recvmsg (net/socket.c:2878) 
[ 8.679534][ T161] __do_sys_socketcall (net/socket.c:3173) 
[ 8.679926][ T161] __ia32_sys_socketcall (net/socket.c:3077) 
[ 8.680304][ T161] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-012-20230823-CONFIG_NVME_CORE/./arch/x86/include/generated/asm/syscalls_32.h:103) 
[ 8.680671][ T161] do_int80_syscall_32 (arch/x86/entry/common.c:165 (discriminator 1) arch/x86/entry/common.c:339 (discriminator 1)) 
[ 8.681053][ T161] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 
[    8.681401][  T161] EIP: 0x37f37092
[ 8.681686][ T161] Code: 00 00 00 e9 90 ff ff ff ff a3 24 00 00 00 68 30 00 00 00 e9 80 ff ff ff ff a3 f8 ff ff ff 66 90 00 00 00 00 00 00 00 00 cd 80 <c3> 8d b4 26 00 00 00 00 8d b6 00 00 00 00 8b 1c 24 c3 8d b4 26 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 e9                	add    %ch,%cl
   4:	90                   	nop
   5:	ff                   	(bad)
   6:	ff                   	(bad)
   7:	ff                   	(bad)
   8:	ff a3 24 00 00 00    	jmp    *0x24(%rbx)
   e:	68 30 00 00 00       	push   $0x30
  13:	e9 80 ff ff ff       	jmp    0xffffffffffffff98
  18:	ff a3 f8 ff ff ff    	jmp    *-0x8(%rbx)
  1e:	66 90                	xchg   %ax,%ax
	...
  28:	cd 80                	int    $0x80
  2a:*	c3                   	ret		<-- trapping instruction
  2b:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  32:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	ret
  3c:	8d                   	.byte 0x8d
  3d:	b4 26                	mov    $0x26,%ah
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	ret
   1:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
   8:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	ret
  12:	8d                   	.byte 0x8d
  13:	b4 26                	mov    $0x26,%ah


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240621/202406211653.493fbfdf-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


