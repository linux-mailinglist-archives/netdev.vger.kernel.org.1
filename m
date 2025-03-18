Return-Path: <netdev+bounces-175603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA025A66AA4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 07:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957F53B88C1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 06:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BC1B85D1;
	Tue, 18 Mar 2025 06:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr0zRgjo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6BA1A23B7
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 06:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742280014; cv=fail; b=EPEDqYTzrlkplTCBp4kxS3xXn/peYMecrmXhEAy1f7RK/xGcx9ugWoz9Nm2162oPZ5Joz7lVoFuTMRGvx6v8egqaNE2HRHytmAV04INTSm5LXBoT0YgoEKd5MYxradJtSlsfWScDvl025XgUlDy5wVE98RewSOE/Mz3x3G6d5dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742280014; c=relaxed/simple;
	bh=gSosegUPGZdXgiiFgRk0jxzJ4dVn96DUBdL8qotb/dE=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BBGGEwrOVg/kBvvHDqGGulHBVjLvP1UGB7NCDud0IA57X+xe58pjn+wKmsGlpNM7tOpoWiMxzFeKzIRc3tTVX40XXRGNkDKJTCAjj52ee2M+gqzi2oW4JCFpjEW1ODCEjYAlQUuoSPzHC6K9SqvukTeFd/Hqy+F3OE4s66jVruA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr0zRgjo; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742280013; x=1773816013;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=gSosegUPGZdXgiiFgRk0jxzJ4dVn96DUBdL8qotb/dE=;
  b=Jr0zRgjohjUBR6udFRFMznDb03H8h/ilE2VNFdpk67dOZG/dQTcbBBju
   H2hw+bTC+2+X19ISMegZqCXwdrkCih8G+NY6dyaokwRjRNve4EvARZ0bg
   1Vj+qd1975XpCCqAA92/6tgQG7ZDk8nl3OuQ1l5fAv/YI6BQEgFz6BI2b
   G2+8EQxk27LcSFU2h9hciyyYMH/W/l+FOD5gtg7Bg6XzPnyXAI8poE7DX
   XBmgfRf7vhXW7fS1vFusKJY2Nv1RCjguNPyNRdGWAp0xcqTicXuC0Amfn
   oNAvNXK3JDJ0GkOsk96yiKaKc9mH50VgIWwOc0hYdpH9xTVcQmDHLDUNF
   w==;
X-CSE-ConnectionGUID: cByA2fheRg6G3zIIZZpguw==
X-CSE-MsgGUID: YptOYI5rSD+sUZLrYbwb3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="43316963"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43316963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 23:40:12 -0700
X-CSE-ConnectionGUID: qJMLiOSKR4+Hs5bsM2KBVQ==
X-CSE-MsgGUID: o9AVt3ZtRKyatD0a2SFoMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="126821787"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 23:40:12 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 23:40:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 17 Mar 2025 23:40:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 17 Mar 2025 23:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrZFff54rdB7dnxq7I00X4JY7aTA5zpB1zVeJzx2chFOquHXymuuxkHbetG0DVDhKIvZ96VreU0tAVyks1KsJPznlHlC/TMKi9lgVk7dIG7hJEiX+AHWz0ifaxJs/fcBakd7VWh9muX+g7HPlj41FVF2PFLWW7X0Vg6cXgqvopcLysgjWc0PekHmV5gOS04RQCgE6GPjdwXTuBNhbugCI5yTMuEnVZpcYwmwduUFItrj+78jTeymOMSWpFov1nHlG34nJU43hWT76vkbxIXM/Vfv5Zt+oVYWIgMKFOy/Ui6ZtkDnjXbLx3QgyMjPLaxz7CgVuIcSX7XAg/23GAx0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOt8viQn0rGxd44a0ky+e9MBNgRPqkTrui4Tl2bkZZA=;
 b=HEV8Ko6xhtKAr6mOstdg9OPV7+qexkWKGrp6Uq3N+AmZ0jrLL/yMB/87sWR+XjIvt4f6yN89dls3lt7DNz+blZ76Mobxm+IEjSOdz0o/NDXMxE8/ekm9eWkXELTaFeGljYVZ25dcmLH8CnLCDSMWvxF9fPnDRoON8SIt2xwPE/E7ZifEEcq0j7wcxOXsIGMD0iWySVGNgtULa+5arICwpgnH8cv9dvvKxYA0BOPTonG0HR6kyzS78OMtTokvMM3PCb0oCBkHMRilt5awtrQJ7Hu5V2WY+hxyCmUd+DE1JU+F5+hkikqmZegXU8G1/uGTAvVVSmmKqPLLNfwLZvHVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 06:40:06 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 06:40:06 +0000
Date: Tue, 18 Mar 2025 14:39:56 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eric Dumazet <edumazet@google.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing
	<kerneljasonxing@gmail.com>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [inet]  9544d60a26:
 stress-ng.sockmany.ops_per_sec 4.5% improvement
Message-ID: <202503181447.69ed9a01-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 54569969-784f-42c4-a659-08dd65e7b852
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?6mlU5J12YZOMNKStzvlil2/gXnbFSlS46k0aD12GsS684i1pPdLpZuE7yd?=
 =?iso-8859-1?Q?EjIDhKX3s8a88AyH3OcefGga80eCzVG513xKtj6wVaPU0rbZUmdhbYOC2g?=
 =?iso-8859-1?Q?hfSWz+uvx7LrVnD/7VAYZyVy671y2rLIAQ0Y8whoWKyND82f+ycSGVaESU?=
 =?iso-8859-1?Q?cNnD7Z/ahMzolKDiEyTHUrjFS6IYYGxy1KP0IsSAxzxoWKNQlI5Bt9Jv/B?=
 =?iso-8859-1?Q?+FNvF9gm/yl6cCa+9TIrt2VswUAHNyB5lFd+BI7ep8jtYKrl5QdFwsLVC/?=
 =?iso-8859-1?Q?VKx+kEA25J1wqnp45IfpXhkVRsxOxANrfY8b5DiZwCY+dKSagqhlQLpzAK?=
 =?iso-8859-1?Q?PeNyJaZxGars08U4r8E2AdswJT7CNwOdRPpXdWu7wzeZjnNRvSQssAhXXB?=
 =?iso-8859-1?Q?JFPf/mXolgJ3QoYn0Dslcj+Zgs1ZbwBRxmQ/Vx9L8KzjlyHannE9LcNjea?=
 =?iso-8859-1?Q?/FZGIR+lIi3BvAzaCi0jkAxuPdbBhh+RR/MC7X8HDh8J7uYPnPYf9tiXcS?=
 =?iso-8859-1?Q?kECi2mu6gCyc9uxCB5WAhyUP70Ra3t7CByHWttH/P77ATQXzLAVmb0hqGg?=
 =?iso-8859-1?Q?aQZvuHsks+28Z0ONP5UmHvEkB2tuQPd3X7hdiuSJMQXzDY5p7DfuAJWf3Z?=
 =?iso-8859-1?Q?Sdco8ygUPkUW1WbaFvX1ELLZdzPu3V6HstnPUOGzVFMVnV9bnfCAXpkyh9?=
 =?iso-8859-1?Q?zL8rveQ29ljJXo/H2ddCBqPSkKEb7h8K4Bm1/rTM0Tp8TZrQoVZN6cLOC8?=
 =?iso-8859-1?Q?53vdQu5f2Z4JIUTd8DXmKKQFfH9XNVr1wi8AA7xmkMYBpOSj1mUgC1XjDi?=
 =?iso-8859-1?Q?7aGYOZuxJ0HYpNRlt867RQVc3Bjt5TZAbwecCfi66D6aSbl69U/nUTwbvb?=
 =?iso-8859-1?Q?NvJHOxHB5hAh6veZgN6QSIxm59lpIz3ZjQwEUvIvwsRDJ7EHsBv36K1y4J?=
 =?iso-8859-1?Q?smnDHn93mgw06uNLXAq8Mx+piFbfjVpW7gYG7j8krqsNrgtw5nKO7w7ScM?=
 =?iso-8859-1?Q?Z5Wjxmg/pFgSdNpa1tGbGkJARNVQGcnpgkA9eDLLHVQoh4xKJi70eg0b52?=
 =?iso-8859-1?Q?gbw4saBnwlzTwWZkVkFCtR8scgb5F2N5ftFyd08iOcp4h1LNjarsl32fkl?=
 =?iso-8859-1?Q?T4jNqotvb4bqTTQOzZK8prk1RaMFoPOOq820u/30Fmpl+SI87Hax0GO4ro?=
 =?iso-8859-1?Q?Bhs52uscvKSKwKy6N7ag5bKlPhlr80jKqQGTQmAymLMpwatTnW3IqFlflN?=
 =?iso-8859-1?Q?EssoEllmVOEjykDqw0ofUhHudeKZA4mIC1OyfBN5xymf2mgZPA0QuMuWfD?=
 =?iso-8859-1?Q?KnJQAgxF0t5h8o28vUgJIAEE+H5ChEvuHOqVuxEJfA4pmY8j7UGpL32Iyy?=
 =?iso-8859-1?Q?EFsXBZlevuO9G0jg8nAIui7g6WwNjXaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?A/S8Eqaaqri3BiUSvPz5LTl4DW2N+tw74ejFAJs1Mlz1Zn4BhWlJdfRPqk?=
 =?iso-8859-1?Q?PWCAY57CMmgMx8QwuQgKTBcQD7fjdSdeAo8ZlvyKkoNWYcszp8FznSjWaE?=
 =?iso-8859-1?Q?G/ksG+egPKi1pzHxUQPBsvXQzM1IWIB+lwJWEZFhPyDm/yw0vxbCrZDJ7y?=
 =?iso-8859-1?Q?Zu7L8otM16HEleMeokyEZzjpm4pOgUSbdHzKELYCBCA8UIB8FSz/tw5d+4?=
 =?iso-8859-1?Q?2yjDlLmyLTpR1Rj7HgDgkGeL6wIbeqbt8NGLB4p7sPBbZWtX+3tiLH5U29?=
 =?iso-8859-1?Q?Yx2Un3XOdKpfbXsTfr/Wvs84IJ3s7JDySbzmtd8YQzhuPHz/xNAsdBOyEc?=
 =?iso-8859-1?Q?eBr1NfGKb0sMmR/ffhKENDqQ4VyYytA3vhjaKwwAHoZnJAX9Szok+B4Kd4?=
 =?iso-8859-1?Q?qgVLempGF+i12/Xvg3r6M1+k4NARpbIfdzbzC0K+1NjQCrFcC/sP693NSR?=
 =?iso-8859-1?Q?UeAEmtpWV/Y601pPNeqMugn1RXwsAm2M64nkOMVhHEil3RFqPGqGkHcXVg?=
 =?iso-8859-1?Q?DIrg0SUeLWZACJKO/cR3omVfWiXcv9w8mpaIIKLdQ8w8UtYoJ+Ck4kdJhx?=
 =?iso-8859-1?Q?H8CpAJYBLSkYx+5atqttAxywTwS6Kb9fw3IpXRl2hiSepK250DkZufEqua?=
 =?iso-8859-1?Q?sREiaUQtQ1LeXO3Fo+w4F47bBwHzMykvUsDekhtQTtr2zFxf8AEcBoZXLx?=
 =?iso-8859-1?Q?NE05SRnIWSC9BJIQ5+cB71fGMHCPpXc61MRvI2SnmTi/qLkdD2E92XQyRK?=
 =?iso-8859-1?Q?2RJ913Zd+TON9i3rwz6NmUj8UyX0zzRmeSGVwWNpKb9WbPiv2TBpX1u93M?=
 =?iso-8859-1?Q?uOSH+mcA23v0Rn0weTCM4lpLdL8t52GYRme3BVPfZmjSJjJhdeUq7SWhC6?=
 =?iso-8859-1?Q?HFXcygd1sNUEnQn/ssolpMQZW235UDDLEvw7Va/D2PJxcyQhwdtjxm8Msw?=
 =?iso-8859-1?Q?/VkVbccOySiIouIcrjZqPgt2EIYytAv9upID+2zPP7VcCvwzf00bnHv7Xa?=
 =?iso-8859-1?Q?T1TunW3a/2PGF8m2T8G2tyDpKogyXIatPMrHJOT7sRGoq/Sp8J/lxYD9HX?=
 =?iso-8859-1?Q?u3tDviUULxrz8hDcBwCQN7X3+5Xk1tbpfPb/KEwwXTT4bqBDkHjSlGHlnP?=
 =?iso-8859-1?Q?fRNMFw+Kye0o781ZElfhLtHAMg2ErFnxr/c2zX1CZklC/yOwJT16m0BRi0?=
 =?iso-8859-1?Q?meLDQAGGlTXCqAEdkc+tu3gyupQQkgrW6gZECsh/+SnYK8WwAM61zguw7u?=
 =?iso-8859-1?Q?hozvozQCco+ctXnlZrb5Nx6GwqvaqboeYmnX5Er3CydR1iPc6/ylJ1TjNB?=
 =?iso-8859-1?Q?O756zwc0PvZUVJHWFrOvqNrxlk2UsENCao5NAMt4oXnQfGdZ1ZwvuO5sJt?=
 =?iso-8859-1?Q?iRKKKtQhE742Hm9K6FAoPkGf6MVcNfpHvPIhJhG9ZalPzB7X1ZcRtp9Ql3?=
 =?iso-8859-1?Q?sT/AdOGwKc07vqAabN5Pa3gXPwvoUDWdNSWhUb1aESIs4DwNfMmfSCZjBh?=
 =?iso-8859-1?Q?+acnbps+zRyvEyKE8iNa024S0fsCVtbcB+DHbIoqIngzjtFmqfikENF56R?=
 =?iso-8859-1?Q?Ni5TAqKDDeioc3tveOu8wapMCcEyuwZ84DROleUIq4k1+Vivvw/bfzTPdN?=
 =?iso-8859-1?Q?/SUdGDvOBgM3oG9TLZL5PbU25T4HP2NREqMhDx+XGL34weP7qT3YjWGw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54569969-784f-42c4-a659-08dd65e7b852
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:40:06.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/Ovh/eoub9fJI3FDdkwb4vxqULcPtnV2N8HM31Sodthx8He82Ut+5t60uFD07bPiL5uoAD875Ac0XqDgCBV3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 4.5% improvement of stress-ng.sockmany.ops_per_sec on:


commit: 9544d60a2605d1500cf5c3e331a76b9eaf4538c9 ("inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: sockmany
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250318/202503181447.69ed9a01-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-spr-r02/sockmany/stress-ng/60s

commit: 
  f8ece40786 ("tcp: bring back NUMA dispersion in inet_ehash_locks_alloc()")
  9544d60a26 ("inet: change lport contribution to inet_ehashfn() and inet6_ehashfn()")

f8ece40786c93422 9544d60a2605d1500cf5c3e331a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.03 ± 61%     +75.0%       0.06 ± 13%  vmstat.procs.b
    197669 ±  9%      +7.1%     211706        vmstat.system.cs
   3052932 ±  2%      +4.3%    3183417        proc-vmstat.nr_slab_unreclaimable
   2120009            +2.2%    2166756        proc-vmstat.numa_hit
   1888278            +2.1%    1927323        proc-vmstat.numa_local
    303242 ±  3%     +58.5%     480662 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.17 ±  7%     -16.7%       0.14 ± 11%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
    303242 ±  3%     +58.5%     480662 ±  2%  sched_debug.cfs_rq:/.min_vruntime.stddev
   4336410            +4.5%    4531719        stress-ng.sockmany.ops
     71830            +4.5%      75040        stress-ng.sockmany.ops_per_sec
   7490830 ±  5%      +5.6%    7912072        stress-ng.time.voluntary_context_switches
    688478 ±  2%     -22.0%     537116 ±  3%  perf-c2c.DRAM.local
    612983           -19.5%     493390 ±  3%  perf-c2c.DRAM.remote
     22430 ±  2%    +873.5%     218364 ± 11%  perf-c2c.HITM.local
     23141 ±  2%    +846.6%     219069 ± 11%  perf-c2c.HITM.total
     40.09 ±  4%     -17.0%      33.28 ±  3%  perf-stat.i.MPKI
 1.398e+10 ±  4%     +17.0%  1.636e+10        perf-stat.i.branch-instructions
      2.26            -0.1        2.14        perf-stat.i.branch-miss-rate%
 3.091e+08 ±  4%     +12.1%  3.467e+08        perf-stat.i.branch-misses
     76.11 ±  3%      -9.4       66.74 ±  3%  perf-stat.i.cache-miss-rate%
 3.694e+09 ±  4%     +10.9%  4.096e+09        perf-stat.i.cache-references
      8.50 ±  3%     -11.6%       7.52        perf-stat.i.cpi
  7.47e+10 ±  4%     +16.5%  8.706e+10        perf-stat.i.instructions
     38.96           -18.1%      31.93 ±  3%  perf-stat.overall.MPKI
      2.21            -0.1        2.12        perf-stat.overall.branch-miss-rate%
     78.85           -11.0       67.89 ±  3%  perf-stat.overall.cache-miss-rate%
      8.30           -12.5%       7.27        perf-stat.overall.cpi
    213.10            +6.9%     227.81 ±  2%  perf-stat.overall.cycles-between-cache-misses
      0.12           +14.3%       0.14        perf-stat.overall.ipc
 1.375e+10 ±  4%     +17.0%  1.609e+10        perf-stat.ps.branch-instructions
  3.04e+08 ±  4%     +12.2%   3.41e+08        perf-stat.ps.branch-misses
 3.632e+09 ±  4%     +10.9%  4.028e+09        perf-stat.ps.cache-references
    204551 ±  9%      +6.8%     218435        perf-stat.ps.context-switches
 7.349e+10 ±  4%     +16.5%  8.565e+10        perf-stat.ps.instructions
 4.651e+12           +14.6%  5.328e+12        perf-stat.total.instructions
      1.22 ±111%     -98.2%       0.02 ±223%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      0.55 ± 11%     -39.5%       0.33 ± 43%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
      1.22 ±111%     -96.5%       0.04 ±223%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_empty_file.alloc_file_pseudo.sock_alloc_file
      3.87 ± 83%    +389.9%      18.96 ± 87%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      8.70 ± 30%    +271.2%      32.31 ±109%  perf-sched.sch_delay.max.ms.schedule_timeout.wait_woken.sk_wait_data.tcp_recvmsg_locked
      3.84 ±  5%    +516.8%      23.70 ± 82%  perf-sched.sch_delay.max.ms.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
     15.53           -13.3%      13.47 ±  2%  perf-sched.total_wait_and_delay.average.ms
    234871           +16.6%     273899        perf-sched.total_wait_and_delay.count.ms
     15.48           -13.3%      13.42 ±  2%  perf-sched.total_wait_time.average.ms
    808.31 ± 27%     -42.5%     464.90 ± 49%  perf-sched.wait_and_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    135.87 ± 16%     -38.9%      83.00 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     10.11           -14.0%       8.69        perf-sched.wait_and_delay.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      4.05 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    103599           +16.3%     120485        perf-sched.wait_and_delay.count.__cond_resched.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     93.17 ± 19%     +67.4%     156.00 ±  7%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
    109023 ±  2%     +17.2%     127816        perf-sched.wait_and_delay.count.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      1230 ±  3%    -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     15.55 ±106%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      9.98           -13.0%       8.68        perf-sched.wait_time.avg.ms.__cond_resched.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
    808.30 ± 27%     -42.5%     464.89 ± 49%  perf-sched.wait_time.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1.81 ± 67%   +8639.1%     157.80 ±217%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    135.32 ± 16%     -38.9%      82.67 ±  6%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range.do_poll.constprop.0.do_sys_poll
     10.09           -14.0%       8.68        perf-sched.wait_time.avg.ms.schedule_timeout.inet_csk_accept.inet_accept.do_accept
      0.03 ± 90%  +1.1e+06%     372.59 ±111%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_commit_planes
      5.22 ± 70%  +15512.3%     815.30 ±205%  perf-sched.wait_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


