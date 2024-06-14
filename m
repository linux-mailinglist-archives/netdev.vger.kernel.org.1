Return-Path: <netdev+bounces-103495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFE3908531
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E499284EA0
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 07:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDCF14A4C0;
	Fri, 14 Jun 2024 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drZfBo48"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332D149C53
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350635; cv=fail; b=qwOYJj8XDtZOQ/VrRDpGh+1oJcQzzRHehe0cxumqEZ0a0gLRg0ZaBksCYGHLdGsuhn8jwTXcDeTN7VfOoTYfaAw4bHGxSW/7DzFn2u93LGuMQ0dUSXUmc0p/ZlBkMfHCKRpw95UcBh1/qYjUKtr82M8N8vJNJzejV157krFQ5b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350635; c=relaxed/simple;
	bh=qllEhnEp4DmuG1v34aKB5qZ4P7uSpPSr3M2zGiTX2Y8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XjeYhXXQWdC2n6HxSdJUcVw+GIn9634wF7kD2AnNyKdZHTvuilztVnBCcjXD5D041J/pjTGtgE9csObxY1613nvDx9D4TiRl2pszI4I1ZVZuSbE6kiC4O5xYjW9AnKQ/50SDSob4Z0mK5CEmVRV0/pPZ+R/VzK0jXiiV2WrywWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drZfBo48; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718350633; x=1749886633;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qllEhnEp4DmuG1v34aKB5qZ4P7uSpPSr3M2zGiTX2Y8=;
  b=drZfBo48Vn01+NG1aVAC6hvC9riR9uGV2e1VgpRpA4IadCWo8k//zQts
   /Eq0StMDuyr/pou8kSshAQZUm4SUDv0Oijh+j8YG5Y2BNPm6K/FzRTj9n
   eGzNwWWY74vsVuzMbcl+7RNe35hA/lvMBUkjhVnEn1r/C+sUUAEOQaahQ
   lF5sKGZ1WF7uYgNqTCJmamw+bRbg80O86Ox7J0hd3mpRx72kDUXDnZZwh
   VGUfeuzIx8xrqby8wHVcEs6UouTFceRWjQQKowfvlHnROE07fACgwloyg
   ajLjrDYjvPDky48OVUvPrrYC2dkUm07stwtasX5Fi9KtLSe9s59bWTZFZ
   w==;
X-CSE-ConnectionGUID: dqY9/Q8zRY+nCYZoF15ANg==
X-CSE-MsgGUID: BStwhaUCSHWQTIcYRnN+dw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="14959014"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="14959014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 00:37:13 -0700
X-CSE-ConnectionGUID: dNWWsK9zQaKcwoL+Q31sAg==
X-CSE-MsgGUID: FZr4vszjR82yivzinXkfdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44957520"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jun 2024 00:37:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 00:37:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 14 Jun 2024 00:37:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 14 Jun 2024 00:37:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 00:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfYZwdpbZF+JMQ/S5cWHd8HWTaLDXefJPVp7nNP0QMbnMzTqVZzzXZ8WD9upRpkak4pDn9IS5wEaAjUs4K5tIapxjawYtgmeIXrl2J3UyhHznTMyJVzhsN+4BM4v6b+UIhwwR0MFOYvQHiXX5dsVz0OAN6tI0EuGHUk7G19YnZ7fQ0xhW/++cMxHjaoWfu/Jm1ahqgqyE1QegEI52b/L10kOQHt77Q0X+BqNlEAjAaEhGagPPvZpZ/BAbNQiChQagnawFTZfKSUQ569JGSCssfO7H8gWrQLuPTXbtj9eRoFoGFT7V6nZCaxbkCetuvMvqBhctFPsV+tc+I5DCXv7jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hon5dHQVWaTqSirMaR6wOp9L4y+YApZhOLcAIim4Gfo=;
 b=IXIdaOLDTxXiaLBYNNz/iM0/bWlkHvaS4ar0977Bw8HqWJuyoTwAQFN2GOttIpMcQMsE/RlS5Tv6JbV0pEJyVm2SiXHM7Qh+hRbhAV5AzxO+e2ibCZVr9sbeGj9V4NUvILd3gm08Sb3o1C9Pd5MAVN4SnLqEMPpWa4LvUA/pIKynIT7SMyVLR7VjznhpdrXZkaMdfq9DXxgT80da+wWr9xSWHo0g0oQrR+9x/s362hscZCRKIFJAWxtamYMQ9oGKdYhlGcQvDYqKG7Fnof1EKodx0HprU6XdiX0SZz5lUul7KAaoGfCNEwGHCZQSLD0GEt/vODIQrY3yk/0LmskdVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW6PR11MB8438.namprd11.prod.outlook.com (2603:10b6:303:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 07:37:10 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7677.019; Fri, 14 Jun 2024
 07:37:09 +0000
Date: Fri, 14 Jun 2024 09:37:02 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>,
	<anthony.l.nguyen@intel.com>
CC: "Ostrowska, Karen" <karen.ostrowska@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Joyner, Eric" <eric.joyner@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: Check all ice_vsi_rebuild()
 errors in function
Message-ID: <ZmvzHqGHQz0ZSTii@lzaremba-mobl.ger.corp.intel.com>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
 <CYYPR11MB8429472EDFF52E822D765238BDF22@CYYPR11MB8429.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CYYPR11MB8429472EDFF52E822D765238BDF22@CYYPR11MB8429.namprd11.prod.outlook.com>
X-ClientProxiedBy: VI1PR07CA0219.eurprd07.prod.outlook.com
 (2603:10a6:802:58::22) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW6PR11MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: db12083b-c5d1-4912-883f-08dc8c44cc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lsxq4Uh7Q3BYbhEVus5wb+rGFUMocaidn3vMCRrVRJvQboBCySvUsMqbrOH1?=
 =?us-ascii?Q?HCE9gK9YR8nDfCavRdAGL0t2TTqjU6XKD/zHLQAcmg3voqFfeWI16CfX5c8P?=
 =?us-ascii?Q?Jz2unkWb/MeECbUwBTIhiFEGzchsavq8krI77U5CIcKOwD7645759jf5shi5?=
 =?us-ascii?Q?fjUx280G99uP56ZKkiaS6dru4QgltRa7naTJ3TwABurKb7EOUZA9rfMCoxGY?=
 =?us-ascii?Q?lSTcbzzqkUlaO2ra3nfktcUlIb+3tL4WkdHra8S/K+I/i27p/rKlahW5PK9J?=
 =?us-ascii?Q?/GJZVqEmko8ciWQhdOtRn4hU6tFVK/4LQ7xzntb9UaN0ZgpfcjLjNTxqtcyN?=
 =?us-ascii?Q?vkeq4MJEstJ/3zy7kxMkGaVSeaczbSL2cbowFFSbqrpezt3w72V+tKuIVkY+?=
 =?us-ascii?Q?b6gS09lb7HypkPf5jsvwXtDxbE6hUk4wHZ177hoFQThHLgCd3V+CEGfrYZmx?=
 =?us-ascii?Q?mjjSqIsd3zjD/r7a0NPOPwz8YejKDJK0j/T+M1nu2s7JljjfrgbrUmVDHcen?=
 =?us-ascii?Q?PjwY7tYLXfwAoGt+PLvUAecGXItlhCtBuXMS6pk+HAyc+jQxmLvmom6xoJYx?=
 =?us-ascii?Q?QGG58VjkdeswJd4auuW7x2Uf8l0oY4WRD/cmLmSn2L5+I+F9M8DJwOa8wzMy?=
 =?us-ascii?Q?gVz5c2Wb/6raju597XT/MeJuAu9MeP0M1qBpB/5GWcdNDVmP4h0No6idERzs?=
 =?us-ascii?Q?Is+lrfXo0OaJ5fCEu9I2pd+0kSMsmcJ7/arpmwpAVFLALBa/8f29KPG55d6i?=
 =?us-ascii?Q?Nck6W5QMaREg9D5ZEFLocQzCH+hQDXWfCY99WRkHZqsqVtCYsPYNDgFSjmmO?=
 =?us-ascii?Q?L0gTDA3I+TZTe0fzssUSwdfToZigAsRNx7oqobGK1UpuRMEZNmRwNiJnTB8H?=
 =?us-ascii?Q?iqnxNR2CQvOjQay9QjmH/yhRgPm4ZdTN4MJ4bsy30+FJsuj5p/0hKNTvJmbz?=
 =?us-ascii?Q?5Vng+60EaqLbHtkDZEtR1FzcyFerkfkzI0pjayoFBqSfH4Zb/B5kPIfl1Xt5?=
 =?us-ascii?Q?HvrTiC9bstgfMKVhkgsc94LRhGSK7EAyhcZp5jg32gaNV+Ta8wOXib/jSpMy?=
 =?us-ascii?Q?mcUCiRYS/haFCRZGVw2eWKxr4qOwe11nGyGPpefLccRI8XmLh9oW8aSVG5vC?=
 =?us-ascii?Q?zfD0G9kMiVlZEnA7hUtlFZhIOW1ISSuyBqMmjW/zxcPJR2PLFcFIoh72UzEg?=
 =?us-ascii?Q?7IyA38Ee3XlxT+5iFJtcoAZ2GuBwWsyfWXn4ds6XAKZiaKlTZpay46+ZI0Mm?=
 =?us-ascii?Q?xsrdMKXTJlepMngZYoQKVSPYaHN4zpM9re6aOxJfiDJo2wNSMlgDGazMcdgV?=
 =?us-ascii?Q?swQltxbyjSmUf1CyOy/1CIGu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uwdfa+62ljf+uJBeWFAG9WEltge1T3KkDYZ2o69NhHVMKIkupOlkv5VSCT/?=
 =?us-ascii?Q?T2hVLLeqaOdoa7aUYikgIUlDtsSz3+X1ykC0LC/jDj/Ju5huDLbu5tvJO9RW?=
 =?us-ascii?Q?wQJzPdvvm6p3j0NNzskghzTzte+p6UvrJciiiPSEQTc7H+Kl8XV/E6X/daBr?=
 =?us-ascii?Q?NQ0oLzg0G3Oh2DmMJHeqHJfcaXMwXazML0xOrftBzlhSf0Ah84zRyRcGyXQF?=
 =?us-ascii?Q?Ol+RKq9y44SjzZ6Rqw3RP5qwT4wQ2F8ST+VcwseXWACfdQlK/9bYXlS/CRsQ?=
 =?us-ascii?Q?UNvUfssBZinrBUSm2CMRWC+S57v7tAAEdyMORAY3hbEO9/q0NhpIFHW6ryBz?=
 =?us-ascii?Q?9w1+Wrhs/sGmjD6gNYqKvUs8dcq7qsB2UDTwcs94b0WC+kICF956ltwnq3DS?=
 =?us-ascii?Q?bV7A6BQTXUq4ZaNg9APnXRWeGRwJMnGtea/zmCh2ajJe0yfSxvP8udvnNWif?=
 =?us-ascii?Q?U/moiqWkwPBMg9+FgdBkEdtLnilfrwDrTi2znr/cyNA5GQEDUmoWMre4nJCZ?=
 =?us-ascii?Q?ysHQqSrvttmSRljU1hNhuhrNd2B3GEYAFaLkeMsdj5y/GHKrCM02XdhgU0Wd?=
 =?us-ascii?Q?lGhr5vi+bUFO7RwA/8yG/jIk72IeWPCKkkKAyc/zWiOjOl4gzfbJl5TekHQf?=
 =?us-ascii?Q?haOHwXmv4KD1QgHjSazXaJ2Fg5J+wsPp6fYtPGfLuDSwvz9xvHwo13ttyUP6?=
 =?us-ascii?Q?4PNh5OUmV5MHaFI0D20bU7kCc0sBhMIOkzAt3yVCmgkEMSRZNQqR545ZZO2j?=
 =?us-ascii?Q?4Ay7o8OF4TqucyEzJ3a7VTNw0UTe1AIRFeaErpamuQ4GjlY3kXU/CnrNawPg?=
 =?us-ascii?Q?N3MeTKLT6iVmZrPgl6OoEagaqtT6fSfLeDXw4luOlFkyvoV8lpyimQ0KNe+M?=
 =?us-ascii?Q?+BJW2srBBLxTeFsgSnscVWSFxf3BkhbAFfSqEDqaVXNWd6DXJaP0IZ06qn7B?=
 =?us-ascii?Q?/cmB4WZXEZxkU5Eh0yHgrdYAUdEiwJhyz6CM/n/K9vZZXIBlg+6qAC68L1EI?=
 =?us-ascii?Q?4iE0iR2LgiC8UuudSRFUy639lIuOTJTaP9brjr84Z4bTT8Op940aq6k/GWq8?=
 =?us-ascii?Q?6Hu+yXhvzzWBflMd3cHbPX/E43D8Xow2aS1MroxD7Ekfe+N9WaYtOYBQh6n5?=
 =?us-ascii?Q?aG3g5KIt26a8/5V0aj79nB6P9gAuZR/VxhkPldkatutj/EypqaRrCfl0TxVH?=
 =?us-ascii?Q?FskOLPT7R2DgU4L2/nQpTdqMBI7SJph3Fv5s4nZrGxQQvDkbFDmDBdHw0BSh?=
 =?us-ascii?Q?fjLHLZfydS6vFLR7lI2PyEp3Ijo4chZG6pumjtOcS51E3DIORAEykxl99G0z?=
 =?us-ascii?Q?veEMq1LUvjJHFjIq4Cmvp+gGgwVYqW1PeV9GPLSYTVF6nJvGvKYWNDJXdoQ1?=
 =?us-ascii?Q?VHEquTL8CHpMoCN93Htesl64ExndTWeFLn+zi0wy3qS2ly/2xinnhd8Uo/Yh?=
 =?us-ascii?Q?2bm3JV06dwjk18sBxKx4PxvG34ITWWSUCAUWdOlzJ5AwxDBFP7lLD6lYqPQA?=
 =?us-ascii?Q?SrFUzMT1WyCfkD1X59c3vZRwJmksi6ODS2snqM4fjgjKl6I9IFgAuZtITCJT?=
 =?us-ascii?Q?PmExDTafOpWI4WDlchiv6LXc0IPrS/NxRtPTI/tnQUfXy6Eu8Hn6hwFRid+S?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db12083b-c5d1-4912-883f-08dc8c44cc92
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 07:37:09.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os5EjUMK3Nwlwe6EQBUvgkakSIWewnS3UXnCrjM+5qY/q6ut48alLwzjC9OEI5md5LiULga6UjEySVPIvF5yJgFLpiD3jWlZ4j3/lM8tGdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8438
X-OriginatorOrg: intel.com

On Wed, May 29, 2024 at 05:09:52PM +0000, Pucha, HimasekharX Reddy wrote:
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen Ostrowska
> > Sent: Tuesday, May 28, 2024 2:32 PM
> > To: intel-wired-lan@lists.osuosl.org
> > Cc: Joyner, Eric <eric.joyner@intel.com>; netdev@vger.kernel.org; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Ostrowska, Karen <karen.ostrowska@intel.com>; Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Subject: [Intel-wired-lan] [iwl-next v1] ice: Check all ice_vsi_rebuild() errors in function
> >
> > From: Eric Joyner <eric.joyner@intel.com>
> >
> > Check the return value from ice_vsi_rebuild() and prevent the usage of incorrectly configured VSI.
> >
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> > Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> 
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> 

Do not apply this tag, Reddy has found a regression that causes unneeded error 
messages.

[43788.733637] ice 0000:18:00.0: Error during VSI rebuild: 0. Unload and reload the driver.
 

