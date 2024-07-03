Return-Path: <netdev+bounces-108881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D83926235
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1576F1F2353D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D70C171679;
	Wed,  3 Jul 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iuQA7khL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965578C1F;
	Wed,  3 Jul 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014673; cv=fail; b=crKPVy+kJvpF9eXxVmGSQpuzAw5qLcgE5pgqnjqqlP3XyhQSF8ATeAPaIk7QiqdbgOEdCG0Bk3OSbi2LTH+Vf1tXQpx7VcbIl4ZGqaVQpeuJpWQngmyk/WON7Q0Sxysul5jm2dFZieXSeCqgfVmi++x9rZ2bOfsVj2TsBeI15ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014673; c=relaxed/simple;
	bh=uDXaiE6spkmeHTqQH7fdLxkpOLpw9ymhAX6UOlVstAU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWapRqI/PUl5S4UKSaVDAejPdX8RtWBnivM3WXlGq6iC1Ajc7zXDYtT+ayXvZbtKBpum2VFWGxCsPkDmAdLlUPZWJs8VhIF7Y4DlhERyuXnDRIKUJ6CsJPkcZGJnflG7aAU/GJkM4Tc2APh2D6kZvLEQnXOHqv1K6mnHjA11Vt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iuQA7khL; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720014672; x=1751550672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uDXaiE6spkmeHTqQH7fdLxkpOLpw9ymhAX6UOlVstAU=;
  b=iuQA7khLgPhdo++Kc9SSMMVQWAAVokgXZRTZBuUzf2XrpcXEf60fLQM0
   6HV5EFoP/bXI4SwFO9PvMV9bBPsKzAsPXE5vIHdSInSp/NjMentqUnhFE
   zlyIu5BUaHJe3j+17cB8yQJD4QecnPspifL/qs2b+GjczBm8N2IYgWINW
   SdXVA99vGasHy+efIcqsa/kppIvOkWwXlUKdJd5GIsLWFAefe/cyC4TNN
   VFw+bB3MbRhETRtnJfGXT7hUzXsfbD3/4UVTxF13vxwBZdWpW/WDCNW8J
   yFH3LLs01i+cmV1A48RdmpwjfLi1co/ufpqiO9JMymXFl1GlLOSMS0arL
   Q==;
X-CSE-ConnectionGUID: FGd4XlENRfqQEO17zTZMcQ==
X-CSE-MsgGUID: LEjKvM8/RbWYuniBM0tjsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17068443"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17068443"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:51:11 -0700
X-CSE-ConnectionGUID: dWZGlWnWS7Csd+l63HakNg==
X-CSE-MsgGUID: auAaJIRsT0eOfOQJlXHHmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46689037"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 06:51:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:51:10 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 06:51:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 06:51:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 06:51:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjqO7ge2XumAC2QakaKrx9+2niQG5/XGLn8gHRJ7oa+dgNkpHW/qNlvj0dcmRicS7lLbpYoI7qIKhyIUy4RDf74azKZe38wsCvRb5djpjP0i7cZGheAJ8pVBmC2HRMr9TyXjxVoZtBJ9Fs/YE4RoEWwch9o58KyGpTj4BhK0kIWAp/WKuRJ8ONiw21UHJfTTtG0ojqFgr80mEYt0gF/7ictAohysPCjZdtQ5CVl3J8kdYR5stGAAL8JlDBTHKVxr89hmTOeTHd6W3wEtrB7B7h83+Ybw1gcMduNXqFt9Px7eOGBSfd+2ArnY7BeAvZ1gkbRmEPfaURvSbbeg+6W8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEQLbtLFAzSTv20yOgxsMHZepHvD7QDckAcXQITgRhs=;
 b=bgecQFVZAFSZYmDckIAagN4sD8/JBnLUqUgBuVlVDQMpjvLTvKtGQ48UL7wz0XQx2KWpkwVSUIqbtoX3n5D3tDx96OViyRb9UjrE85TgKZBBYjPkzZHewACjoYm8RIxig3vJkrJ+NCDIg3FnKcETk5jiPLxtOPXuhNV52Zub9jhKsfThYnaJe5soqrXm2Str6n5AlAu7nbvNMchmgEhSMYKQS9YCpa745jTcvvCh1BKRhqmnO/QDWjifyDGUgWkQjarzQ2F85f8tcPB700I2SoNxa+fqqwnvewBFAZwla7eYSBwVQPszhePoLtp1OJfkNjexSBJQJiuJW806ROkTaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by IA1PR11MB7342.namprd11.prod.outlook.com (2603:10b6:208:425::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Wed, 3 Jul
 2024 13:51:04 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Wed, 3 Jul 2024
 13:51:04 +0000
Date: Wed, 3 Jul 2024 15:50:53 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <samuel.thibault@ens-lyon.org>, <tparkin@katalix.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] l2tp: Remove duplicate included header file
 trace.h
Message-ID: <ZoVXPZeO21VT8PEN@localhost.localdomain>
References: <20240703061147.691973-2-thorsten.blum@toblux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703061147.691973-2-thorsten.blum@toblux.com>
X-ClientProxiedBy: VI1P190CA0045.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::18) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|IA1PR11MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2cb923-4a78-44bb-27d6-08dc9b672e86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ry1MHA1SCBEye//tq0X+rOV0w9craNoyA0S6kJYinYYf8LhDpqKXy1dvr8hB?=
 =?us-ascii?Q?WKGDKzgpI0/edxTh1i2kaIVSOvh5OEJi/oRre+IgVJ9NwiZaTv7Fjk9Snx3z?=
 =?us-ascii?Q?E5FR/1ZG2IQp3D0lCSHTWOHnqgwyxNh1YX3l+I4JhMZ51UjXHAl+6GbUab0s?=
 =?us-ascii?Q?Kk3jfNqfSAVeJiGm0Ot1TbiwfbaCGMttSgU4ErlaFK1BncB51YC4x4+LixgN?=
 =?us-ascii?Q?DGJ61rSYg3zXaJEn9cwHL3D+LmryTKTYXI//qsRr0uzX2J7IMc+ybQZbf2I6?=
 =?us-ascii?Q?DMG/Tes/4IoB+NOijq1IRVfwQZLammnIc4v3y9m8SW8zKxQHMJ5p58HfrkPZ?=
 =?us-ascii?Q?DxwWXT664w/Yh1z+Al//9uznvcpkvNvxK5PZ8bjQkzpNdbPARGVHk73NrRKd?=
 =?us-ascii?Q?8qv8fjekePbb+pmSub0AbobQ1KlUTuQ66rUvOX5zqDxsOL+xRO1mbbFwutSB?=
 =?us-ascii?Q?OFOzKhg6NbV/SOHGz0h5F0aiQ0ANGdftMvUii8reXdpCld1MpOCUhLYFsEKi?=
 =?us-ascii?Q?FUMxCl5M4OV5rtSrIuU94OnI31a+Co/DN4mhPIs50VdsOZzK3NE6omBCEeZq?=
 =?us-ascii?Q?yV9/NuqNSUV0u6AUN+tMe+krWoKIaYPCp1DSWmADqGdHSTEWwqvC72WTnPOQ?=
 =?us-ascii?Q?cVJCg2sgTpztWZTbLnNg1UU5Dgjc/I+fToqw2v983qUHwKk5/Jsrxgh0Ht6P?=
 =?us-ascii?Q?EAYzARtYYQ3QUshdYpenT4hCAhXx/3WLkolYKriTg7ROZiJG1lnmX+lPu6wN?=
 =?us-ascii?Q?aT2pnFEWopQj6PxRA+c2yUjSDulRvDvCrDqhOXh2lSoY9xmE0fHzY8CVO0H0?=
 =?us-ascii?Q?XNB4EsQDQ1G43Gv8vgx58c2+ilIDsUgzX8CFSITzVgBAhLMmJY3ArGTCB3oC?=
 =?us-ascii?Q?FxFT/wz+LVhXjHX39vhj5dJAgWjWgUv3dCbtUCkmhtnpzp9jAXnUs3NlllFF?=
 =?us-ascii?Q?VXbrfiYEqUTnH4nSgCIQqk94VD5NCnWMf+r6b3C3Pjh7E+V+y7iVOMZzBxwd?=
 =?us-ascii?Q?5LON0MTLFiMUQIlEJLNe6Cun80fJ2aZca90RHEJI4oLjpe5sWGwiZfkCOBKi?=
 =?us-ascii?Q?gIlLOyKKONbxx5KsuzdBOXJMKbuUb+LnkiwYSYl4sM090kpw2GiLxY3XDb3X?=
 =?us-ascii?Q?wRAM4yAlBvdO/ShnJTnN4f+JXA+Dr1kJURjw0o96EnW1WYkEyJhi3uIhzoHk?=
 =?us-ascii?Q?SyucOLdylj5unCGN0KFXNcCCmBmm41ErC5qSzP7qy0Jd7IFaz9LdSkWF9OEw?=
 =?us-ascii?Q?76zrlbIqJjmL9lt3a+d7V9Sx98mng/owYwBx7Lv/NX08eVgy64AE+dMx4iZv?=
 =?us-ascii?Q?C0Nho8GLZZDCWtt00xiT+FwLt41KqVIW3s0qQqcAr/He5w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NURM/SJW6zJ41eqRKkz1uPjuv8yZLFNW98gKk4QMh1nXO+//W0X/RTrcgH25?=
 =?us-ascii?Q?QkxPQbTpOcJQzGjBuCV1V401KfIgMC2yqs1dlJc1f8YJKSnN87FddoU/R+wm?=
 =?us-ascii?Q?z+dl3k84hNYdOas4JdmBXol6qNID5dgapdeSufgDI3dvsqxDf0XRSichIbC9?=
 =?us-ascii?Q?h5vZRJqKmg++6fPdqXVJXGuWDEotyxwI9RlnsGywUXOn80v5sRHmvkUPHhhF?=
 =?us-ascii?Q?oI7Xk9l5K7+ClZOTtYNlxa+9u8rOV3B+JAY5EKOEd7h7hokOKjyYvDa1LnpG?=
 =?us-ascii?Q?Vk0/a5rOjLQvEC+/LPOag0YTMiwO5CaWLE9xt2UAI+PI0uerAXQ/MaDVk8E3?=
 =?us-ascii?Q?fZDvRspw4bDzEkVGGsq/9QV9n0ScSxcPbgApCd2ihIQBlVNL/2yfgsY+uqoS?=
 =?us-ascii?Q?huGqseJ+xNQ1e/HfizXWXbGLEGIOQh/jY/G8KE1SEtCtTFKBL7efhPZSNShH?=
 =?us-ascii?Q?oMcwrP1CqaxPotIS6j+xg0VVUDcmFfToZ+f7LMPj8ZXYlduH1DdnGSf5lNwj?=
 =?us-ascii?Q?+ZgA66WvHh39JREpKJkgfV21h5YKGBBrliZWeapuFu+Ovobt1YhxJ56hgHQW?=
 =?us-ascii?Q?kHb14l+eXwE51H2vH/ucBRmS3IWUJE+e3aawCI1On6YrHvRjf0O6SQgkphdw?=
 =?us-ascii?Q?pLzoXs28ANzbkgJ7TDuSiKpOQ7bXztP5CLxC5/kQz4fNkDLp7LWVv3slv/1A?=
 =?us-ascii?Q?csoWiZo0QVpfpfGPYN2SOTzFHx6FFxOG9bK2sx9Fv28O63UG1J/i7PNkMQbp?=
 =?us-ascii?Q?wfyxcQ7iY0/6zVN8f8YD06Cmr2esdU5x6OSTJnL0j8lBWoSKToi/Q46HGDKD?=
 =?us-ascii?Q?0DYlIiYqmTXm5qzxltmUDFF5vQsZoG+XlLgIb3XA7hy5Oipg13qzokQMn9h8?=
 =?us-ascii?Q?/k1g0bf9QRy3TC95z4ZtCq9G0y2aiwmmOKZuldxCKMsBltvgFv/z0kCrJjQb?=
 =?us-ascii?Q?AGbBNQdNS8rRfvx05fayO7nE+IRHI9cjnGYBbkwC6V9BCV4XfnAJ1gCqiTGp?=
 =?us-ascii?Q?s+kGtM4K/KAgn01l5OwPLMoceE959YCSbUFGtUKlaePEEqREFPshjBFBHkwz?=
 =?us-ascii?Q?EQ3TjcnojhifBWJtnO4amXxMUV8LK/aosKkdudnzQj4JTuBeJzKGNC2yE4OY?=
 =?us-ascii?Q?Ws7REcUJAie17IWlCBvOA1rvPGuKoOVasqGGJDcz7qMnZTlUF5Yrs7QphdwL?=
 =?us-ascii?Q?u4h+mNK1eTtr82VXWG6AT92vyHWg2OjI0fgBhaLb/eymoai8C3EBnHY4nZLP?=
 =?us-ascii?Q?wH0R/xatTefvfBBRwffI8929s+e99wNSz32YjF9yAgQ20mRgkgdvEZB3HNO8?=
 =?us-ascii?Q?QLiK/qQMkwOhzMMne78+sxaiWYm9F7LzC+15im2kBo2WtkgWmLiDc6zxZWRm?=
 =?us-ascii?Q?Roz4hW5FTs2YMqJ0VEhk4W83Azr92XTX1kU8f2/F7JHu8NuQxQyJPz+X47Ub?=
 =?us-ascii?Q?yxUyxu5iQ1C72LrvsBBq4TqxLoRybHhC/WuKF26THAQ7hN+79zfvOXQcwwB9?=
 =?us-ascii?Q?fvxtgpGg5i01dTXhkTjMUoDXl1CeAGLJgBqA3qIJx4xfq786gp68FJyoQB4S?=
 =?us-ascii?Q?u1AHUWs17Fk/fKnbq8FLMg2YGCUHSKDWdeK6dpptgU6hB5tC3tH8M2vrg8px?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2cb923-4a78-44bb-27d6-08dc9b672e86
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 13:51:04.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IGyNSu4tbtitpggH6pUFe9y3a0jTPMVi4wOLDGXb578YVJw0GTcLyCy8j1GlZKFO8P3BdtWIaPWHH3ERmziKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7342
X-OriginatorOrg: intel.com

On Wed, Jul 03, 2024 at 08:11:48AM +0200, Thorsten Blum wrote:
> Remove duplicate included header file trace.h and the following warning
> reported by make includecheck:
> 
>   trace.h is included more than once
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  net/l2tp/l2tp_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> index 88a34db265d8..e45e38be1e7c 100644
> --- a/net/l2tp/l2tp_core.c
> +++ b/net/l2tp/l2tp_core.c
> @@ -61,7 +61,6 @@
>  #include <linux/atomic.h>
>  
>  #include "l2tp_core.h"
> -#include "trace.h"
>  
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> -- 
> 2.45.2
> 
> 

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

