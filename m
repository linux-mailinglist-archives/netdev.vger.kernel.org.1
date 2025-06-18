Return-Path: <netdev+bounces-198921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710BADE500
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B831882547
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C224427C175;
	Wed, 18 Jun 2025 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj3FK8eC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D851D5CEA;
	Wed, 18 Jun 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750233372; cv=fail; b=obQQNWzZN4yxPyspvgaXz8JnGHuw85dVp3mQfp1whI3T9xfZcplwz+2z1T1MylX36tIiUkldUBWVXAL2ZlXW8VBDbYQJtpw1pJBWML/+oZ7NsLgoLt/aOXfJcIpuTdPQTQHWr7VsaqHdNs72NaQT3pO06/kn5X3nUJDBwVNOp3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750233372; c=relaxed/simple;
	bh=YYiLSmPWf3Gho2O7t0AYXbPZ+HbbwEIWsDxFJkr1yo8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MrYsA8q4iqPIHel59AHuBq/tBUlIKD4svLvB5C9jMqBwE21rb56wscuskvuqLtavdxjpi3036XS//vpOYDxm1Ty+KjuOxNGFIVKDKwML75TAT7B1oQnoQLvXZGZsR6kDUq/rieAyL48bOuM5jCFudxzuFQWpMU5+aUiTeYjCMIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj3FK8eC; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750233371; x=1781769371;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YYiLSmPWf3Gho2O7t0AYXbPZ+HbbwEIWsDxFJkr1yo8=;
  b=dj3FK8eCBx38bTwk6oX/O5iez2cJR8K6a6WP0ZfJNdKerR/3AqQb4w1i
   0A6fp8kFySf7jm+VfBJkgsRkGDr6lM/ZVIYBjW1m8s1MAiY8dfxeDn8fn
   ihzJiAQHpVLALy3TRhfaeWorLksXFNmoMoBeW1ZawH/5ekA9oLPUr1lAc
   VQYWG8Ri/gGH+NB99KaODl2tdBEtH3TXWgad7YKbU/k5A6DLCdSNYRkOW
   dfDuCUOukQrLR0VWr8ZVn72X+g0vQwfH/Z0WKqf/apu+tBFb1Nt+DqTx9
   Gr4993TXNagJI/u/IanFFv3yDZ19sfsNG92rp7hZ9uZNqydw4A6wfaNEv
   A==;
X-CSE-ConnectionGUID: LEVg0YkoTeqOYgIBwShOGg==
X-CSE-MsgGUID: lEmLhPthSTuJGcXoGx6GwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52525020"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52525020"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 00:54:54 -0700
X-CSE-ConnectionGUID: p0ZwAYNDQtSZnWidw85luQ==
X-CSE-MsgGUID: j1HaoZzJRQCk8oBlxMMf3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="150121220"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 00:54:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 00:54:53 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 18 Jun 2025 00:54:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.70) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 18 Jun 2025 00:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDj7VcL1OihUYbdu1lEERMmpSf1ZzPhMt/9fr2NlROVxXZy5YB19zbY1U4ax4VbDdI4RLFAajpdfxlgHgWDrZQiTZiIWhaS57gzomfyhdOpeOh7f62IcFVm4Vi1wa+X84O5Uoj3GhjoMs+HSLmuQlUCLJAeTQizSDhdEgjdu/EYR9Lzu3+F4cfOZTxVCVQH7apUcG9S42efbdaSOBVJTywb4Qz46jfjyKIK4dFN1L4GlAG0GjaQRop1ocDhuZV3bcqundCp74jK4WSfK235wjRDo4PoNERxEBUR1EJrSoKGq6ENrWD2kpNiLz5dhdlvTour3w1yMjinA4fKuRT7MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMAn5T7drZqqv90Z9FvM8xjiiWOHWFOOw/Nm4TSqGEs=;
 b=Ppg5SoOgaO08pJ6eu8iqZ3kwHcD+EU5bpDy5og2u28wY3i+M6Byc1RtvAgUyOo4UeZxZ0xD8cCDyniOA8nfwz0fdQbm9kfrqHtQjAQXYCAd9Nk3pRt4oTxyRU7SjQiGxJ7QDfxRRIHDS5jXjOxBhu4MFXHwzMtM43Z7JYMhmAXZ6UkWO9/rffXN7vsGavsUSMh8e3Yv6uFeq+lWGmRa6SqDTYWVir73TmiXYm2aIsacxFx5B+MQe7XK+EMS9j7DkCRL0Fs35VS48MblUcusMOMR75oe8UkjDygm2MnP9IY4xFvGRWA+ZxFMCUML11nCyI5EuVnhk+kJNF2sRD77d0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 07:54:45 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 07:54:44 +0000
Date: Wed, 18 Jun 2025 09:54:31 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko
	<jiri@resnulli.us>, Tatyana Nikolova <tatyana.e.nikolova@intel.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Michael Ellerman <mpe@ellerman.id.au>,
	"Maciej Fijalkowski" <maciej.fijalkowski@intel.com>, Lee Trager
	<lee@trager.us>, Madhavan Srinivasan <maddy@linux.ibm.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Mateusz Polchlopek
	<mateusz.polchlopek@intel.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
	<netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Madhu Chittim <madhu.chittim@intel.com>, "Josh
 Hay" <joshua.a.hay@intel.com>, Milena Olech <milena.olech@intel.com>,
	<pavan.kumar.linga@intel.com>, "Singhai, Anjali" <anjali.singhai@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-next v4 09/15] idpf: refactor idpf to use libie
 control queues
Message-ID: <aFJwt22XQkcZ4qQ4@soc-5CG4396X81.clients.intel.com>
References: <20250516145814.5422-1-larysa.zaremba@intel.com>
 <20250516145814.5422-10-larysa.zaremba@intel.com>
 <16644b14-2101-4e95-a9b8-d1226d52da27@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16644b14-2101-4e95-a9b8-d1226d52da27@intel.com>
X-ClientProxiedBy: BE1P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::19) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cc28f99-3c92-41f3-9674-08ddae3d63b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o9oH/8iFMyKWLeMQN9y3J4/q5SdAkxAVH8mupnwRCgaCtws+0CvG9rR+h1US?=
 =?us-ascii?Q?m4dJSK6dmNonaMfKdoxKencxoFp+HQkF3u1MvP7WjN66o5B7pWCPkAPPBfS+?=
 =?us-ascii?Q?9PyKeHpRYrETyCF01Z8I7CDRh0E890MDMDZvrmaEIv+yK8Nn/tTEhFfEtpNn?=
 =?us-ascii?Q?ljRNY6SVTtm7vnqQVCGwOaGvkWC6EwiggxzXSZnJJyBKezs61AiiTTM4v2+B?=
 =?us-ascii?Q?D98+OFdKzR/clDuxnyv+UnvNai1p+cHNGAzwhHX79nJ7keOPo++Sun4ByLM4?=
 =?us-ascii?Q?dFBVI1otQdm00sj4udOzFKZwIeILvxxCiyU1r0z9Us5MgWCv1/qWkCksIquv?=
 =?us-ascii?Q?QWuO3C0sP6Lh9lDmvOXhIOXfgxTm4Nwkd2/3Q5ZnPa5vHRjfqqK65lSPHgrE?=
 =?us-ascii?Q?ncNbwYqQEZNM+kE1CCOO3TAtiNSceLZ3+BpGzvzzZenFijHNh4A3+el/dtg4?=
 =?us-ascii?Q?KE6fpB2Tey5eZ7Y63jp42f6tw9XADOB3RIUhwnpjmGdwdh5fG3F1wL3Uhp0t?=
 =?us-ascii?Q?ckM1y4ygVLAMHv1x7Z+y/EsnYBs74IU8LhtqIcF6cHFOJOhqheStCzbI1Ky0?=
 =?us-ascii?Q?Ht3QBx0++7v6FMbKduw9wgKerodZf+HoQJNfgQXVQ8pLSszpsWS0k05WyFoV?=
 =?us-ascii?Q?6pTgW4REIFF+TQT72uto9qXvFwzcxZl2mN/a/yTDsZMUr2uVU1MFyz+H7SFX?=
 =?us-ascii?Q?o9eBJM35qc1TBPLWfqVpPzXDtCPAjFMyV69CJCneA4rJTmufjv0xCWDFnmIX?=
 =?us-ascii?Q?HQ2J2rIWH8ZBGCb8kk5dztLazv7jfNtYvl1dmCBWC+hteyGlkOBvAapdIkmc?=
 =?us-ascii?Q?O5eD/+JeP1YE3wsSBZ2jn5DnI+6M/Bt3dM46WHQWoELZGf55m4QtjzsU4+bX?=
 =?us-ascii?Q?a0gPrKWaGLMHaWAnft8Gbkpzhj+Q+a5BIvpP7HuI+wpKELsGLNGInBgduBzY?=
 =?us-ascii?Q?EpaXQtGBI0HVKoZtH9JvsYy61cpxeR4Gd677mTSkLbMFfCSpdxMVHXgrXR1W?=
 =?us-ascii?Q?/nAyy7AOkOq1rbgmryvsHfsB3nLcCSSjJ5hGQjor6Bb67EWQEfB6yQe+Savi?=
 =?us-ascii?Q?tqyhhW8BJByleE65Qs1ewtLK0Hr5++btgcgl0zFIIoUbnIcLOL7Bm0zvEKXG?=
 =?us-ascii?Q?WaPCXa7NH/XDCgFX+azGI0Xc3sICyTYbpsnGVoFKd1nDvw3tkM3ObVHvuCU+?=
 =?us-ascii?Q?mcyhRmmZ0w/p9JCgGnw2zlmKPPU+ttWzR7UGcbEHWeuU4zlp1+qDd1XR6fX2?=
 =?us-ascii?Q?P/HQPR/C+goPYiTY/U9rofkcPzyKTX5yG/Kfw4jg0Mi0SjdEa8mshYE6OTwv?=
 =?us-ascii?Q?NKvzm1CHRU3SfZ/pQpMCGCcd0mA04dp5LR+5D545jcEitl+z5sw9oePpzSo2?=
 =?us-ascii?Q?GXvoaIX5JCdFJRoab5mIK+EXyZpVdBbxXT8PNFE+80oH1Jobk4Flr4P5wBCK?=
 =?us-ascii?Q?Hlm1sXdRP44=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IP+iyCuxV9gDXyY668kwky4lioXKzrrtCG3B9gnssHeNZCQz2NpIbs90bOk/?=
 =?us-ascii?Q?OHG+WBXE2C/LLpWPh5/8FxU82vI8H6qj9y0+ox+creEWV2QdnJWB6+cTG3Dr?=
 =?us-ascii?Q?c+98c0tgihxAZF/KC7vU1wknW/05jp4Xc9Xppwfi3Zdl2LSvBlRxZH3eSLe8?=
 =?us-ascii?Q?zXRI09tbhC6ihNFtW19yoPpytct3BL2tGNyFSRhd5USPSZH+sIeJ7XQQH9DP?=
 =?us-ascii?Q?2Nn0w4H8u6pOZH1jJUG47Ro59Egu21adSFy65fV/SpbF4qdkLIlIOLk8TNmP?=
 =?us-ascii?Q?/QONK8No5NQOYWhpvjibkXYHOvZO5mRF4XOSmJbiVYAWE1LQPkSLul6px0xr?=
 =?us-ascii?Q?rZ+Xrdy7pbYQDDjogrvD8XbwN+RrSSEtISPQwuPG5zy4CqGyDYFm4VHKOCCV?=
 =?us-ascii?Q?2F/46gTXID+NwkkjJAiAwkgl0D58IvGKi/ZeblSvNtD1BpFThfojvkEowFHU?=
 =?us-ascii?Q?rPm8b3xXq4rzl6QprEURNKGn7k+rJI5oLxm1t+JeZ1dfvxSLg30PbT73Bwcx?=
 =?us-ascii?Q?e1utnCgnz8/zq3hvWGFTaIsAMrtPk3OoNLz7YyzEVM7KmK3exHVqb1wsJvYq?=
 =?us-ascii?Q?vTmWFEY4WUIUXmNY0tUF/UT/sGTiF7Ukjq14yZchiUwKnB6M4rfWyszLzxlO?=
 =?us-ascii?Q?+YaJTzsq/KYikiDOskGKUl9v4YJ8Owr3egksIRebrpiyQT1aPoO1a+h83nqx?=
 =?us-ascii?Q?4e+pWjNyygyj7CRzSZkHKV3Mez1F0QVlQm8AocNDzmoUkqeNmxy7I6qIQoBl?=
 =?us-ascii?Q?QYo6Qn7prISArWnWk935t74480cqzYq3WdxCrSDu9eTdk2J8+ynsybcLqtX0?=
 =?us-ascii?Q?+s4VanbSaiyOqZWqlf0WmnGlz3+uugUqd5MgsV+rfUEIniG7enygst9uGvXr?=
 =?us-ascii?Q?PmhfhpBoeCC5/WFSLskyo063bLC63WsPEDkz5wNU2+y0lSZNHJY3laSgRAwV?=
 =?us-ascii?Q?FdoNcwVe3Gizj3th4kTyTYl8/AmjKGf/pWptgi+YVlgL1leFeiNn+Fh2K2rn?=
 =?us-ascii?Q?d0Za3Dcdcwy7o0508Kz7ysEuOEFsBDaXpkSp67nGmn8gAa9wU+fL1KXRnx+q?=
 =?us-ascii?Q?kCj8yR9Uns5Z6B5Em7fqKl9gETl7WbiSM8dRntqoK+cuAaebAqmUPAUOOFZS?=
 =?us-ascii?Q?ClvDcstTYCsFdbVsBeoCvSNEVfCP3XDGWJVzPDIQjLukgpW/EiIUl88wpqSr?=
 =?us-ascii?Q?lt94k73nBknuElUoH3+vULpVjKpitGbda+w9mB9FTb7cuLEVshK5gcUJUiVq?=
 =?us-ascii?Q?+jY8zftEPOt7K+K+ytg48eRVa3jxrOLUdZwYiY6c8VeDAQ8wf7AueTadBp3j?=
 =?us-ascii?Q?cp9+J5aoZN+KU98dj0xGJmfTRlJq45+ht9ymubPC6Pn7KJdDjegY/vdvyKK3?=
 =?us-ascii?Q?2HQxi9DZxoz8e6a573ewyHEcQAoZpYKAg6j+aIxeeQfCOx3+DyS0EcsSIKAm?=
 =?us-ascii?Q?seufbBLZk5lhG6NTMACI7ETKzO2LjgWAmZGPCzwUQ7xw3RWg7LSu4Jl7tjj3?=
 =?us-ascii?Q?BeEm49WoLaJf8UTHqmen+EjxaAbFV+WDd5HQEepOWpxUte0nmG2juSxWIVXf?=
 =?us-ascii?Q?U5RQvIvPYgr8ugg4hJhRZ12i+w5CGlFahiBN6+7+IXzWrDcyGAAPprQyIBz8?=
 =?us-ascii?Q?Fionu7gYBzgVT/E/5sZ2WDVaiXQ0xGQ9mkzGKkGtKp6rO6UKk8fDYxVt0WCN?=
 =?us-ascii?Q?kb/vRQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc28f99-3c92-41f3-9674-08ddae3d63b3
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 07:54:44.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlVS6MKkYiJ9JkOk9QM7wz1uB6N7H/p67Gz8rpzsCG9Wmwzm3gk9X+BAkl+pGZAC/zDsCQKb3dRdwI6NrZ63FnRF2Q6TzjHWfoVF8k3xGxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com

On Tue, Jun 17, 2025 at 05:04:55PM -0700, Tantilov, Emil S wrote:
> 
> 
> On 5/16/2025 7:58 AM, Larysa Zaremba wrote:
> > From: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > 
> > Support to initialize and configure controlqs, and manage their
> > transactions was introduced in libie. As part of it, most of the existing
> > controlq structures are renamed and modified. Use those APIs in idpf and
> > make all the necessary changes.
> > 
> > Previously for the send and receive virtchnl messages, there used to be a
> > memcpy involved in controlq code to copy the buffer info passed by the send
> > function into the controlq specific buffers. There was no restriction to
> > use automatic memory in that case. The new implementation in libie removed
> > copying of the send buffer info and introduced DMA mapping of the send
> > buffer itself. To accommodate it, use dynamic memory for the larger send
> > buffers. For smaller ones (<= 128 bytes) libie still can copy them into the
> > pre-allocated message memory.
> > 
> > In case of receive, idpf receives a page pool buffer allocated by the libie
> > and care should be taken to release it after use in the idpf.
> > 
> > The changes are fairly trivial and localized, with a notable exception
> > being the consolidation of idpf_vc_xn_shutdown and idpf_deinit_dflt_mbx
> > under the latter name. This has some additional consequences that are
> > addressed in the following patches.
> 
> There is an issue with this approach that impacts the ability of the driver
> to force a reset. See below ...
> 
> > 
> > This refactoring introduces roughly additional 40KB of module storage used
> > for systems that only run idpf, so idpf + libie_cp + libie_pci takes about
> > 7% more storage than just idpf before refactoring.
> > 
> > We now pre-allocate small TX buffers, so that does increase the memory
> > usage, but reduces the need to allocate. This results in additional 256 *
> > 128B of memory permanently used, increasing the worst-case memory usage by
> > 32KB but our ctlq RX buffers need to be of size 4096B anyway (not changed
> > by the patchset), so this is hardly noticeable.
> > 
> > As for the timings, the fact that we are mostly limited by the HW response
> > time which is far from instant, is not changed by this refactor.
> > 
> > Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > Co-developed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >   drivers/net/ethernet/intel/idpf/Kconfig       |    2 +-
> >   drivers/net/ethernet/intel/idpf/Makefile      |    2 -
> >   drivers/net/ethernet/intel/idpf/idpf.h        |   27 +-
> >   .../net/ethernet/intel/idpf/idpf_controlq.c   |  624 -------
> >   .../net/ethernet/intel/idpf/idpf_controlq.h   |  130 --
> >   .../ethernet/intel/idpf/idpf_controlq_api.h   |  177 --
> >   .../ethernet/intel/idpf/idpf_controlq_setup.c |  171 --
> >   drivers/net/ethernet/intel/idpf/idpf_dev.c    |   54 +-
> >   .../net/ethernet/intel/idpf/idpf_ethtool.c    |   37 +-
> >   drivers/net/ethernet/intel/idpf/idpf_lib.c    |   44 +-
> >   drivers/net/ethernet/intel/idpf/idpf_main.c   |    4 -
> >   drivers/net/ethernet/intel/idpf/idpf_mem.h    |   20 -
> >   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |    2 +-
> >   drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   60 +-
> >   .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1617 ++++++-----------
> >   .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   90 +-
> >   .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  204 +--
> >   17 files changed, 765 insertions(+), 2500 deletions(-)
> >   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.c
> >   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq.h
> >   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
> >   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_controlq_setup.c
> >   delete mode 100644 drivers/net/ethernet/intel/idpf/idpf_mem.h
> > 
> 
> <snip>
> 
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > index 68330b884967..500bff1091d9 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1190,6 +1190,7 @@ void idpf_statistics_task(struct work_struct *work)
> >    */
> >   void idpf_mbx_task(struct work_struct *work)
> >   {
> > +	struct libie_ctlq_xn_recv_params xn_params = {};
> >   	struct idpf_adapter *adapter;
> >   	adapter = container_of(work, struct idpf_adapter, mbx_task.work);
> > @@ -1200,7 +1201,11 @@ void idpf_mbx_task(struct work_struct *work)
> >   		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task,
> >   				   msecs_to_jiffies(300));
> > -	idpf_recv_mb_msg(adapter, adapter->hw.arq);
> > +	xn_params.xnm = adapter->xn_init_params.xnm;
> > +	xn_params.ctlq = adapter->arq;
> > +	xn_params.ctlq_msg_handler = idpf_recv_event_msg;
> > +
> > +	libie_ctlq_xn_recv(&xn_params);
> >   }
> >   /**
> > @@ -1757,7 +1762,6 @@ static int idpf_init_hard_reset(struct idpf_adapter *adapter)
> >   		idpf_vc_core_deinit(adapter);
> >   		if (!is_reset)
> 
> Since one of the checks in idpf_is_reset_detected() is !adapter->arq, this
> will never be possible through the event task. I think we may be able to
> remove this check altogether, but as-is this patch introduces large delays
> in the Tx hang recovery and depending on the cause may not recover at all.
> 
> >   			reg_ops->trigger_reset(adapter, IDPF_HR_FUNC_RESET);
> > -		idpf_deinit_dflt_mbx(adapter);
> >   	} else {
> >   		dev_err(dev, "Unhandled hard reset cause\n");
> >   		err = -EBADRQC;
> > @@ -1825,7 +1829,7 @@ void idpf_vc_event_task(struct work_struct *work)
> >   	return;
> >   func_reset:
> > -	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
> > +	idpf_deinit_dflt_mbx(adapter);
> 
> This is not a straightforward swap, whereas previously we just discard
> messages knowing that we cannot communicate with the CP in a reset, this
> goes much further as it dismantles the MBX resources, and as a result the
> check `if (!is_reset)` in idpf_init_hard_reset() will never be true.
>

Thanks for finding this!

Given the problem seems to only relate to idpf_vc_event_task() in case of 
IDPF_HR_FUNC_RESET and the following call sequence:

	idpf_deinit_dflt_mbx(adapter);
	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
	idpf_init_hard_reset(adapter);
		netif_carrier_off();
		netif_tx_disable();
		is_reset = idpf_is_reset_detected(adapter);
		idpf_set_vport_state(adapter);
		idpf_vc_core_deinit(adapter);
			idpf_deinit_dflt_mbx(adapter);
			...
		...

I think, it is safe to remove idpf_deinit_dflt_mbx() from idpf_vc_event_task(), 
given no mailbox communication is attempted in between it and 
idpf_vc_core_deinit(). Anything going on in parallel also should not suffer from 
having mailbox available just a little bit longer.

What do you think?

> <snip>
> 
> Thanks,
> Emil
> 

