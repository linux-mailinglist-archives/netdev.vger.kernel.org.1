Return-Path: <netdev+bounces-182633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC982A896F1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722793AE21C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 08:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ED2192D97;
	Tue, 15 Apr 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fV5PtxRB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57C927A90B
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744706526; cv=fail; b=tazZAWtgRL1Jxg9z1vYncS48Pg2RWRO0ARd23Yiwjrz5//QggfHXBNGSCB7gdL9sXbDriIaJPHFE7BuyEzq3/pwUMPB2Q6mp09EpzggDRrWuhhOFjxJCU5xyk+pIS/DfRKACNSTHrfWGwD2u7vq8IBvoZHu1thsTYfMp5vTMTwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744706526; c=relaxed/simple;
	bh=hQDeBFn7JTvR1oamkhe1y53uXobhRLndXjQeVoyfc0k=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=hVu6qpQmdxHbwPIddcNO8WyDu9h3bIV1/0l7ro7fEixVs6w7AXoZTVGwfaQOF6J8CnKWO4+8jiYE3jJp6sQA9/XtuM4ohYKlJf/DcNElqCnT4X+4AHg+LamytG+3uzmoI+7HZSqPFmKkol+/6RzMtgQquzK8J3P6eaNIckyEyqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fV5PtxRB; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744706526; x=1776242526;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hQDeBFn7JTvR1oamkhe1y53uXobhRLndXjQeVoyfc0k=;
  b=fV5PtxRBe67OCY6ekN9QvIdsX2LDkTT7ZSnFoNn6bXtkNsZTAtcGV5yG
   zYIC2so8uzo+dPm4O+NbHjFaEVBiN30bFsAiSei75GUWvhcPMBvGqqA4O
   OLWL/ul1ZliqthggECZQGqjIACGK9tzoTVlAlFlcdhadaGOrVRmOBcTan
   +NMFsCh3mIa8D18ukaWuFEWdq8g59GNA5+KGGeKrKSSY++gP9U3WvFMvE
   xT2tBGE/2lsIlWB92qlv+A8sT42IbiVmtj5/O/Z4PqAO3apkmLqKXeHdt
   fh0Vba/8YLeCZ50kcI760jvzy0zHb+4mFKL6qoICqMjce6KC6R9M7+Jcy
   w==;
X-CSE-ConnectionGUID: 1ERz00RfRQ2Z2T5vX5N1Sg==
X-CSE-MsgGUID: ywkVbSQITT6STxUPgvhQGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="45917059"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="45917059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:42:05 -0700
X-CSE-ConnectionGUID: auWmesHQQwCBaE2NRzQWfA==
X-CSE-MsgGUID: r0uz+5A8RLqwNrsuKE56Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130377731"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:42:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 01:42:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 01:42:03 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 01:42:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWmKqlnvlBFjls3Ln5YLPXqNoDq5fELU0IhFOHyXg/CzkLq8uM7ew6F2BVWt1cibEA+G+Q2vpMYtOjoLSodee0ocevhqrQSJWtAlisJ0mmNtgCQ1xRKN4Qla5X3VOfhjZPk64NXVvr3JE+20uUM/GXb0hQvFz3YH6NCkF5gKtIJ+Mfce6gHs9ly14nGJdor4NCx58gWhSciADu/HKMQVXdj6f0p7eg6qFeTsNuAqUcwjzjtoFORVoTP4s59NUv4Bc7ru4zDWgjoDzKij8FVEsLU9a4z4jbMUhXJrm23EH1IcTQOXKfzKe0HvhsaWUcm74N3u07y6lBzjyvzSZHeIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxC9YetSgcsfv5TxpUpQNkbiG2catIw28ZjJSu1s9I0=;
 b=o73zKtUDKyd6Gxi505jaojWxKf+erV4pOYIW2WRecJXeQ+xbMymG4zEJIktlZ1xf7+55ttsYZtUwbX9y4eONYs9DIczx5ra8ELPjg/2uD5PanT4Xdw3/GrxR9Regtslmj9uzUToMi3xc2YU74hjXpjLKL59PFx1Prp3pPiBXreQt7lbIS8JkIgtVW9CDkzqXlERzmL7e5GZNtxPoLe/PMeXHhM84Kk8cFBVckgcu5w9fYPfEceakfCkeA7+Zeb/mItWt8/Vx3Qf4H+5I9P58pZ54HdM9g5PmtaaP8nniV+2ZQNLEPeC4BgGJb4BMk1VWbPYmKQOWQ3BkqOKXjbBSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 08:40:48 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 08:40:48 +0000
Date: Tue, 15 Apr 2025 16:40:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Joe Damato
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [netdev]  99e44f39a8:
 WARNING:at_include/net/netdev_lock.h:#netdev_nl_dev_fill
Message-ID: <202504151654.adca9912-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0201.apcprd04.prod.outlook.com
 (2603:1096:4:187::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 217aaa6c-cef2-430f-2ae6-08dd7bf9386b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1RlfUgiU8JPUKXHWYhEf+6s9WJuxWFRPYPf5AF8aTZv4KNaRzTxTsxoCr5Pk?=
 =?us-ascii?Q?ngAre5iPT49xd1IpjiV0UKxhh8B1dzL+gDAncuC1TmoxCght41iByp2vEnG8?=
 =?us-ascii?Q?rZcOpsVnYPOLiBME/L3BuspsRQLm/jNHgwtngbXSoqOtgkYBUhZWFh7El0xh?=
 =?us-ascii?Q?YePB8FH12aRx6T+E64YRxEgPfeJvBRRLUeCfogUrswX4nNf4+UWUINwNsEZ5?=
 =?us-ascii?Q?+aB8e3WHceeP4zuFvk3iIHqD3LmlG6SRHPahzHEgbxf8RTMg+R458vEXf3fp?=
 =?us-ascii?Q?vpKfjtS5JSnuBKAUIVcmjlDFTjp5RlxMQMrScrNV1iSKJS9TGLvGkd4NUFp2?=
 =?us-ascii?Q?1fYd2WR94882MtPSuSuN1hk2qH1uTKkuQMsrqd1w0A9LChKQ97WMo34ShGau?=
 =?us-ascii?Q?DAIQUhtVGrI3TpFgzMK5Z6aOzcUAI3qPjnAWk5ixDcBCHlFQ4UpknVBrJj/K?=
 =?us-ascii?Q?DDYXyp+JN+o2uYsSOwtv4JNZ7hbZq9RtopQMZ/dYOC3gfSLE72iFVffeykE8?=
 =?us-ascii?Q?3Mjq4XHiOtnRTuOCi2kqC+JgcILWr1fMGCWNICjW3yVdBg0UneUKzo22Yi6Z?=
 =?us-ascii?Q?SQvWg2C0wwdxj3jQhVezzFeiTyWF1u5l3wQ34/kjA90d8bhmlNojMeZoLEEj?=
 =?us-ascii?Q?0LCVv/z7M50w0oP6BZd9KjxhEh/qAjrVpHkEB8C8lVQM3DWw5PBzJz+Z02EG?=
 =?us-ascii?Q?PKNGtiW+aUdFLzdaGoKjWTB/AZE2aYDi9DHrUSOSpwu70sT+MSK6GXWlFJEs?=
 =?us-ascii?Q?zSL4vRgNdXjUf6CanmHO8hnB7AA/Z0Sw/ff6jJ3hDjyoCvZCchSWDFXQ4PsD?=
 =?us-ascii?Q?zDYSS1bpAnt2CxoRg1gowrTaGYzUK0Uw52uovQbkrlealWhIK3UKA9QYV8m3?=
 =?us-ascii?Q?q8Ikt4s7trtuzQ9iOwZd7GchVwxsGWoSmIYNLpfX4tVzXJqRcETqfgJxOdBG?=
 =?us-ascii?Q?lfXizkkuj38ghVSlAGv/oQK10hdB6D2X7sfK9wXzGOpoIZ3XdpGMCETf3+2o?=
 =?us-ascii?Q?fOLhqJQXfOVfQRpsOlpAG2vxK6eQjz5JWlBMIQAqrMMxTS1EUGON3tUjKO2C?=
 =?us-ascii?Q?C9UGN3W/yWohecOQh4nd5LVmY5inc2oL2mC/McS1m5YeQf/GH4abiZaPMhJO?=
 =?us-ascii?Q?9/ZtUrgaSgeA1du1G9E2eB46pHzyqRgkssgdTerxwVSP0YWTDuNs2vr8MBx0?=
 =?us-ascii?Q?AAVSl+r3oE8BrGpgk815+Klu+mzJ8Z/Dnfw2yJGpCnPZE7uSoyocUQs8SzBU?=
 =?us-ascii?Q?Io01fK4rmdIoyi+scEL+nkheBU/+SE4GMNLT+BseiYT0iYw4By1HqSUI3Vpl?=
 =?us-ascii?Q?lBi3/3h9Slivav2un/X0AuzWLy1eD+vjsFGpMtwyOK35F6I9s/0TAWAr2QKm?=
 =?us-ascii?Q?IOZNNOB11sh41YkXawNWzKFzS/fu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJZxblSjMMP+GI9y2wX2m7QTI2/6DvYEM6dFcSdjbiMuJPKIVptKU3vhn7pV?=
 =?us-ascii?Q?ezA1W0Tq0EHvBl6bo3NcjuclCwNWJ7svho0TKjBskyH38v/iJJ7ZEL4G7I06?=
 =?us-ascii?Q?FBaon+lhLaoVWWoAB7kNwG9f9g/DmxYmbODppEEpgklwt0Lu/RAxEJhSFZ34?=
 =?us-ascii?Q?fi15AeYIo3Bkqw9vYJ/NoGbHLnExm2j/58Xvofs6ZWlF8KWtw9L4FF30mnnG?=
 =?us-ascii?Q?CU488U0ouERz8oiDkkw1E59tChklwOjoTxsK6F8SPDixErdgAYnT9Xd6Y4U+?=
 =?us-ascii?Q?rp7ypGRrtstjZGbbfPru2xV9VMkIEMHi76KgsK5MjWfjCXwt+tNIQyYWivTg?=
 =?us-ascii?Q?u13VOumXZlkxADIDsPrffPYS3Jy801oWsGN+LEZvX9Ywm2FyPmc5IpvDzzTw?=
 =?us-ascii?Q?ZwOR3xEKR3ssw+CHxuGsNbrykoE0F4AaCf8p0l8cIdDnfO5BMwa9E9EGrD4Q?=
 =?us-ascii?Q?v/B7Oe8Nuu95XVRgfcYt11Kh0DHyReZWX/6RbvZQLCgfpQjFJkwI7t3KOLYc?=
 =?us-ascii?Q?qnkjpG2mVLF5AyNjfE7oYyTkeCop7NrypqSvD8Q1wWoeI8zOYO1j8rA+bbvx?=
 =?us-ascii?Q?lyFjAS5H/b0qPDGCKR5IGuT6j3FtYJxvcaHDKkSHhP7FGBYtkEMDjTj/cqG0?=
 =?us-ascii?Q?TfJN2CR8EAr2X7Mz8XNf1ttGl6Ts4XVgnl7WdOqLSiSg43cA3rF9Bo0zreem?=
 =?us-ascii?Q?wCR9HM9ZUAYhX0XlJM6/8avdAImEhwV2O0fNluVGBD+bWHmSYVwG0RRVh3g9?=
 =?us-ascii?Q?llLl/ASsiYq6HazLSvkg8sO33EDmb2Jq2mw2BeCqplTx82GvXDYnsMYq4pnQ?=
 =?us-ascii?Q?Hg35PGZ2lERFud8FkKGHeZIoib9P4gfHf98iEBiHyrgdS/pERxgpTrbe5xgY?=
 =?us-ascii?Q?HSWnUFloNsieu4rzjSB7t9+UnKi7TSlKvGgQI+THYKlwh8+5Zz3PtAe8e3fF?=
 =?us-ascii?Q?BBcCvZwhajvgq81Owkg9FkpFw8P5yeeBZxXOUc0UKex8bIykFrKQThBFKm7N?=
 =?us-ascii?Q?yrjwwbGS9i43Mbe87zCbltMHH8pHc+agteVrXjzoo59hAGDc/woI7rWExe2k?=
 =?us-ascii?Q?ZeyTZC5vhEu+hkcziFS/NXZsikAUApL3n0hXEd2QDL+smi5oUShZ6L9rr8jO?=
 =?us-ascii?Q?b0Twz8ZrXeKrkmqBsd4PgwO5JrDnPBQX0q+K3a40JHtTACzWZuU29u5nKAlt?=
 =?us-ascii?Q?EwiLvYSrkorvi4h71j1D65ZFJzuEUcLHRELXO/4p6Ft+VC5K9KsZ75nG5G6J?=
 =?us-ascii?Q?D59b0LOE7tYn9vEJCcmT2ICvX+YFKJA18vVjIup9Q2Fv3yKMPEvyvdT5UpP9?=
 =?us-ascii?Q?WJyHym1oOAaiVMMIQD9RCKhWEGEVGRSA4v5PGgVOw5Vd0EKSaWcskoR65NJl?=
 =?us-ascii?Q?i4d5IIDmZLcrBFf4GyWGx1WDSZLFZah9phxrPuiKrl+adqAnIixNuXDI9sMg?=
 =?us-ascii?Q?l4jExki4hyqDkgXhQEqKS9k5oD0H+e9TK2PX72cq2SoZ0RBMyFj3yWHxOUoC?=
 =?us-ascii?Q?aCn7AHyRtVt/J+jXBXT55FHwQCgb9lNnrQo2UjylhnOeKQ+mDvXn3VVgnRH/?=
 =?us-ascii?Q?EGghfzDalBtEMXRBMSxY9KaC5b6cfXABV+ux0H3VhdCJTilBjVKIgy6K/+mE?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 217aaa6c-cef2-430f-2ae6-08dd7bf9386b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 08:40:48.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCQPfhIiQYO85Z8CB17Qej/wAw2zNlmvqwBX0la95QldnzJcn4KeU5juThbny6wgNLvYsspSQEth5/bxk59nDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_include/net/netdev_lock.h:#netdev_nl_dev_fill" on:

commit: 99e44f39a8f7138f8b9d2bd87b17fceb483f8998 ("netdev: depend on netdev->lock for xdp features")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 01c6df60d5d4ae00cd5c1648818744838bba7763]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-02
	nr_groups: 5



config: x86_64-randconfig-101-20250410
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------------------+------------+------------+
|                                                             | 03df156dd3 | 99e44f39a8 |
+-------------------------------------------------------------+------------+------------+
| WARNING:at_include/net/netdev_lock.h:#netdev_nl_dev_fill    | 0          | 5          |
| RIP:netdev_nl_dev_fill                                      | 0          | 5          |
+-------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504151654.adca9912-lkp@intel.com


[  141.666631][ T3846] ------------[ cut here ]------------
[ 141.668033][ T3846] WARNING: CPU: 0 PID: 3846 at include/net/netdev_lock.h:17 netdev_nl_dev_fill (include/net/netdev_lock.h:17) 
[  141.669548][ T3846] Modules linked in: usbtest
[  141.670575][ T3846] CPU: 0 UID: 0 PID: 3846 Comm: trinity-c0 Not tainted 6.14.0-13326-g99e44f39a8f7 #1 NONE
[  141.672184][ T3846] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 141.673817][ T3846] RIP: 0010:netdev_nl_dev_fill (include/net/netdev_lock.h:17) 
[ 141.674755][ T3846] Code: 0f 85 10 01 00 00 45 03 75 00 45 29 fe 4c 89 f8 48 c1 e8 03 0f b6 04 18 84 c0 0f 85 14 01 00 00 45 89 37 31 c0 e9 27 ff ff ff <0f> 0b e9 08 fc ff ff 0f 0b 41 80 3c 1c 00 0f 85 f4 fe ff ff e9 f7
All code
========
   0:	0f 85 10 01 00 00    	jne    0x116
   6:	45 03 75 00          	add    0x0(%r13),%r14d
   a:	45 29 fe             	sub    %r15d,%r14d
   d:	4c 89 f8             	mov    %r15,%rax
  10:	48 c1 e8 03          	shr    $0x3,%rax
  14:	0f b6 04 18          	movzbl (%rax,%rbx,1),%eax
  18:	84 c0                	test   %al,%al
  1a:	0f 85 14 01 00 00    	jne    0x134
  20:	45 89 37             	mov    %r14d,(%r15)
  23:	31 c0                	xor    %eax,%eax
  25:	e9 27 ff ff ff       	jmp    0xffffffffffffff51
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 08 fc ff ff       	jmp    0xfffffffffffffc39
  31:	0f 0b                	ud2
  33:	41 80 3c 1c 00       	cmpb   $0x0,(%r12,%rbx,1)
  38:	0f 85 f4 fe ff ff    	jne    0xffffffffffffff32
  3e:	e9                   	.byte 0xe9
  3f:	f7                   	.byte 0xf7

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 08 fc ff ff       	jmp    0xfffffffffffffc0f
   7:	0f 0b                	ud2
   9:	41 80 3c 1c 00       	cmpb   $0x0,(%r12,%rbx,1)
   e:	0f 85 f4 fe ff ff    	jne    0xffffffffffffff08
  14:	e9                   	.byte 0xe9
  15:	f7                   	.byte 0xf7
[  141.677856][ T3846] RSP: 0000:ffffc90003dff950 EFLAGS: 00010246
[  141.678825][ T3846] RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
[  141.680156][ T3846] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  141.681572][ T3846] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[  141.682885][ T3846] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88810f6dc000
[  141.684194][ T3846] R13: dffffc0000000000 R14: ffff88813add8a00 R15: ffffc90003dff9a0
[  141.685536][ T3846] FS:  0000000008890880(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[  141.686950][ T3846] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  141.688016][ T3846] CR2: 0000000000001000 CR3: 000000012d9f2000 CR4: 00000000000406b0
[  141.692243][ T3846] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  141.693575][ T3846] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  141.694988][ T3846] Call Trace:
[  141.695668][ T3846]  <TASK>
[ 141.696325][ T3846] ? __alloc_skb (net/core/skbuff.c:684) 
[ 141.697154][ T3846] netdev_genl_dev_notify (net/core/netdev-genl.c:102) 
[ 141.698076][ T3846] ? __cfi_netdev_genl_netdevice_event (net/core/netdev-genl.c:956) 
[ 141.699093][ T3846] netdev_genl_netdevice_event (net/core/netdev-genl.c:971) 
[ 141.700068][ T3846] raw_notifier_call_chain (kernel/notifier.c:90 kernel/notifier.c:453) 
[ 141.700981][ T3846] register_netdevice (net/core/dev.c:2273 net/core/dev.c:2287 net/core/dev.c:11109) 
[ 141.701874][ T3846] register_netdev (net/core/dev.c:11188) 
[ 141.702692][ T3846] loopback_net_init (drivers/net/loopback.c:219) 
[ 141.703546][ T3846] ops_init (net/core/net_namespace.c:139) 
[ 141.704338][ T3846] ? lock_acquire (kernel/locking/lockdep.c:5866) 
[ 141.705148][ T3846] setup_net (net/core/net_namespace.c:364) 
[ 141.705896][ T3846] copy_net_ns (net/core/net_namespace.c:518) 
[ 141.706671][ T3846] create_new_namespaces (kernel/nsproxy.c:110) 
[ 141.707596][ T3846] unshare_nsproxy_namespaces (kernel/nsproxy.c:228) 
[ 141.708613][ T3846] ksys_unshare (kernel/fork.c:3377) 
[ 141.709417][ T3846] __ia32_sys_unshare (kernel/fork.c:3446 kernel/fork.c:3444 kernel/fork.c:3444) 
[ 141.710301][ T3846] do_int80_emulation (arch/x86/entry/syscall_32.c:?) 
[ 141.711196][ T3846] ? do_syscall_64 (arch/x86/entry/syscall_64.c:113) 
[ 141.712062][ T3846] ? _copy_to_user (arch/x86/include/asm/uaccess_64.h:126 arch/x86/include/asm/uaccess_64.h:147 include/linux/uaccess.h:197 lib/usercopy.c:26) 
[ 141.712883][ T3846] ? do_int80_emulation (arch/x86/include/asm/jump_label.h:36 arch/x86/entry/syscall_32.c:148) 
[ 141.713749][ T3846] asm_int80_emulation (arch/x86/include/asm/idtentry.h:626) 
[  141.714602][ T3846] RIP: 0033:0x407ebc
[ 141.715337][ T3846] Code: 83 c0 01 41 89 80 40 30 00 00 8b 44 24 04 4c 89 d1 48 8b 54 24 08 4c 89 de 4c 89 e7 55 41 50 41 51 41 52 41 53 4c 89 cd cd 80 <41> 5b 41 5a 41 59 41 58 5d 48 3d 7a ff ff ff 49 89 c4 0f 87 5c 01
All code
========
   0:	83 c0 01             	add    $0x1,%eax
   3:	41 89 80 40 30 00 00 	mov    %eax,0x3040(%r8)
   a:	8b 44 24 04          	mov    0x4(%rsp),%eax
   e:	4c 89 d1             	mov    %r10,%rcx
  11:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  16:	4c 89 de             	mov    %r11,%rsi
  19:	4c 89 e7             	mov    %r12,%rdi
  1c:	55                   	push   %rbp
  1d:	41 50                	push   %r8
  1f:	41 51                	push   %r9
  21:	41 52                	push   %r10
  23:	41 53                	push   %r11
  25:	4c 89 cd             	mov    %r9,%rbp
  28:	cd 80                	int    $0x80
  2a:*	41 5b                	pop    %r11		<-- trapping instruction
  2c:	41 5a                	pop    %r10
  2e:	41 59                	pop    %r9
  30:	41 58                	pop    %r8
  32:	5d                   	pop    %rbp
  33:	48 3d 7a ff ff ff    	cmp    $0xffffffffffffff7a,%rax
  39:	49 89 c4             	mov    %rax,%r12
  3c:	0f                   	.byte 0xf
  3d:	87                   	.byte 0x87
  3e:	5c                   	pop    %rsp
  3f:	01                   	.byte 0x1

Code starting with the faulting instruction
===========================================
   0:	41 5b                	pop    %r11
   2:	41 5a                	pop    %r10
   4:	41 59                	pop    %r9
   6:	41 58                	pop    %r8
   8:	5d                   	pop    %rbp
   9:	48 3d 7a ff ff ff    	cmp    $0xffffffffffffff7a,%rax
   f:	49 89 c4             	mov    %rax,%r12
  12:	0f                   	.byte 0xf
  13:	87                   	.byte 0x87
  14:	5c                   	pop    %rsp
  15:	01                   	.byte 0x1
[  141.718357][ T3846] RSP: 002b:00007ffd5d3ef228 EFLAGS: 00000202 ORIG_RAX: 0000000000000136
[  141.719853][ T3846] RAX: ffffffffffffffda RBX: 0000000044020000 RCX: 000000000000000d
[  141.721224][ T3846] RDX: 00000000c7c7c7c7 RSI: 000000000000003a RDI: fffffffffffffffd
[  141.722604][ T3846] RBP: fffffffffffffff6 R08: 00007ff21606d000 R09: fffffffffffffff6
[  141.724055][ T3846] R10: 000000000000000d R11: 000000000000003a R12: fffffffffffffffd
[  141.725437][ T3846] R13: 00007ff215d76058 R14: 0000000008890850 R15: 00007ff215d76000
[  141.726820][ T3846]  </TASK>
[  141.727442][ T3846] irq event stamp: 4373695
[ 141.728266][ T3846] hardirqs last enabled at (4373707): __console_unlock (arch/x86/include/asm/irqflags.h:19 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:344 kernel/printk/printk.c:2885) 
[ 141.729809][ T3846] hardirqs last disabled at (4373716): __console_unlock (kernel/printk/printk.c:342) 
[ 141.731371][ T3846] softirqs last enabled at (4373318): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[ 141.732938][ T3846] softirqs last disabled at (4373309): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[  141.734464][ T3846] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250415/202504151654.adca9912-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


