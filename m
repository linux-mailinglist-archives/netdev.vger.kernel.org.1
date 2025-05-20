Return-Path: <netdev+bounces-191701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBFABCD43
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142681B6380D
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D286254AE7;
	Tue, 20 May 2025 02:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGah208Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71AC2185AA;
	Tue, 20 May 2025 02:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708577; cv=fail; b=dODIRtaUC/wXaNiMnjwK4Auw8+7x2gVBzT9TVa9xo+vYrsgZAV4n+XKFV6XgRho5esoRMzc3rhb6YgrV3sqUTyyJHvLCIOY09o/i/rNU7CSGW2ACjJ344y8De2JEmiTkii/crSPJay8TFsGSZojILbrVyXcXo2nYM+g9tIm+CaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708577; c=relaxed/simple;
	bh=05GBScyWE1vROUQPz2jZsIZv0DsBOxTh1sbSNj4IWNY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kdVWoTuF/S6nQFntLkkbym9WYcAq4dm1cURvY2hmIrpyJ7KjYmBazX4MiyoM2FiIV2p+oW1lW8N20Uu/s5LET6GtuPtp9grJmZx3sq3ALVR96QS2fNru10nS7cBJ/9Pc8zl27xcdczg04Ced+dPa/uuMLwrvLmXryNkooC+p3rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGah208Y; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708576; x=1779244576;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=05GBScyWE1vROUQPz2jZsIZv0DsBOxTh1sbSNj4IWNY=;
  b=JGah208Yvjww0vcqk+OJjqdqfS2TQ9DFvGD8pd+hTYLMxOF5lIKJ1t+Z
   ksn0BWlQ5UoDCArcVSPbYbc79ZunaKzpLcN25xgmS3G8h0VrmkzhvUy2h
   Dw5s5A6m8xozlpeupGN4CinTPcT0BA4pzqRI9fBwOd5ECt3i7QGeAAxEf
   RDLwG6P64ewF/TfwaLww4NXFzv6JcvJDFeRA9B5mjS47QjxAfeq6rQ6Cq
   rCIvJIMCG848G7NpSPOWlD3qbt+i3y4JkMfOTTNNTOPaXrgZa6+KzkYeE
   /F4Fkez2sqqHgWXROzOxp0oFVWaISVygnf3O+zhXifeaJYFqvrMlZ8LI2
   g==;
X-CSE-ConnectionGUID: EEi2v2YxQC+vSiZs0owerA==
X-CSE-MsgGUID: /3cFyQbBSN+2TEYZer6o6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49323746"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49323746"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:36:15 -0700
X-CSE-ConnectionGUID: 9GeWikdgTpqjJIR3DF95Qw==
X-CSE-MsgGUID: P2+twkvXRG+pEnIP+4v6kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144301376"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:36:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:36:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:36:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:36:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyIxrWG8PcOI23eEBBg9iE/Hp3bZEZFBQlIOw0dCVMoLtE4Kk2s9rsryqYG0mrsdTddq+YXHNycknqmpt9OOR6k/R/nvMmrRAX53KNkYjDpmTzp431OOfTlseWy2d9t85r47hiakSRB9VCYiMDF5umhvO6JjQTFhJD7W2M1pEo9uO686SqT+CPUz2R38c0E27g3fM4Y0dbVCavLA3KJ4DF0j0ytUrLnh7pw3r0IB+/DFLNYL5TbiLgizIprYHPWzzulSXcIJQtBDaI8zjVmJ7TuMvxhZC+SzBJRQCI/xjUJ0tSOyBAhPQQyFg0VCvedwW2pC0/suI2A5HNrLiX9x8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43b2T/DB/1JN7jN2mnzxb5j/1nYK2FLnfXfIhWZjW0Q=;
 b=kMNkAP1ZRms5Q8YPE2mm/FhgsqA5P9tMrd6+pe8zFFhkVjglInOOJ0wa0Yy/E1VfKGR5Rn3lxTX3wneZxBB/jLnH8R4e8i4PMODw6fjQhlkikT1EgM8vdMCK04NEk7b4InsrhPDvHafo+4CyRYLe8WqHKuCcETjQxTpdzx+Zw3tXxoFjRgBg7sF0cL7Tp+tkq8V7Q3g2/hlfvOjztHKRNuS82G7N8Fg7cdfCy0HKDnOVaKIrU8gDWZN0EnBWSIbFjI/KNjZIU+8APG4r0/nsfaq6phH1BUcGBX6BwufTLAtEgue9i37FRWcCIXpdAjnfVH+bSFakcZ1QWXH5IL9NqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DS0PR11MB6400.namprd11.prod.outlook.com (2603:10b6:8:c7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.30; Tue, 20 May 2025 02:36:04 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:36:04 +0000
Date: Mon, 19 May 2025 19:36:00 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Message-ID: <aCvqkLB6QV47-QoD@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:74::26) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DS0PR11MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: b17b13dd-180b-455a-66b2-08dd9747113a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VMmJOo8FrHV3gINAwebdSrX26FofWsdL9BZrf0SUsU4i7BsnoAagpL3xVngP?=
 =?us-ascii?Q?zgIze7/vQV7wsO3KqIJwrPZ5k5MhmmGu+ytU6iOEFEQa9SOQW1fGEvFb6lON?=
 =?us-ascii?Q?3ch5Srxrz3IhFYOtclVA9ZtZDdTUIJQ5SN+szYIi4TIIH+QX9Ne65XQ9SWWi?=
 =?us-ascii?Q?ykTlXO/yfOSyPEj4C3r9ti7C8ZH1shB6d0woT94Pf61v5ooqE7kqHTCkOfmz?=
 =?us-ascii?Q?J7Ou4rJK4IvyhE4YswLLRmxD/NwZ+Dc14MQdw3/8SZcCmCUmkDjKery6LAyK?=
 =?us-ascii?Q?TCuzdVt5P1LYEjIqHjSIM2n86pVxtPDwolZGXx79gblkFREzQveuqUWNz4QC?=
 =?us-ascii?Q?e235x1Ffubi+x7Ecj9GuNgZuJhBVoZOGeWItEMIwltDLSZKOCjnOwhBBieVS?=
 =?us-ascii?Q?aeSb+Y8kX0LmcvxLsu1CiO+APtpi4g2NQQWyoEAxDwu3Fh8goR/962HQCn4N?=
 =?us-ascii?Q?psEquwDi4npMLTq+QRTSICpI4hQrAiRO6+FWC6MghRcN3scKFDwqxfhydOK0?=
 =?us-ascii?Q?FTC2opREJHsKp3AJdnS1nh+w7ZIohx7UpxxgW+m1CUlWjy8YXkifpeC5orh7?=
 =?us-ascii?Q?jU2ole0k5JVJ0w83dQ0/moYbUTdGTzoMwXN3pF27KMDIWUh1Kkcl9a1ZHEvx?=
 =?us-ascii?Q?ICdtp/5Ph6OiEGWLQpFCLquSKbIu+KAYJCRqOByZBCygPs896tR/PSjbYgCD?=
 =?us-ascii?Q?U4fEdr7OpeAC0KgrN5dTce4nD5L2mM0zBpOlb7KxBp5yMS8lN5s91VxWhuUX?=
 =?us-ascii?Q?u1lfssHdjG/KjQf8+NKkCcIFf5Lv4QZxJe4HYPB6/+SOplkn+4/K74xM5WIO?=
 =?us-ascii?Q?rdc7YbZoQbQX56yPuXBRg/0P/HeMeGxkwnX6MotDZovlo0hdhs6KZUh+fydS?=
 =?us-ascii?Q?389LFPnd0FgiNss/EQwLjwpEn7uaAUxihAOaZOqDIbWzqAway627JIgH07KS?=
 =?us-ascii?Q?TRqnLVjh63fp5/6qXmS5GXCSHWxXOAbsARLqJ35KnvkgYVuFrKvLDtuU3DYC?=
 =?us-ascii?Q?L37TAg8nuaXmQXF7CItub7W9nHslVBd2g1gM/yg0GUPQJ7q42MLZ/YfKR/1o?=
 =?us-ascii?Q?yE6+HSCb9MMGMBg3Hb4RruXgH38kLskyd3zyLXLE/WIJzus434cmFqpG4DnF?=
 =?us-ascii?Q?NeCZlCoBgjA+J/5X3X1YG4CzDGtJDaVGIbJDVUQhwOP/x5SCx3Lap6gJnkh9?=
 =?us-ascii?Q?MEY7PXkjH26T7CGMBEdsxjS3UicsEz50EyTOB1EP35xg3CN+U7F38vzHUTWP?=
 =?us-ascii?Q?PjkZQ1JhVNzCboJbTcZ0/k9z1qMZ2QLJmzrLeyCZtBpg652wmSjO4KVewoMd?=
 =?us-ascii?Q?g5uJToa+PVA9LsHPxMhrMj85ZzDzHCJOIWGeFDfEnBU9viq1Me3lZ7zQm115?=
 =?us-ascii?Q?0XBSD3k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?extZxCQyMrZ41BaMphjB6EApy1afLXwqWs50ML9i2ZL0YGWGtXe8F3QG0mko?=
 =?us-ascii?Q?L/3LqsM9kSXD31LAF+kdUB8u6fhH8O3/EWHRxgCiH5cMdKSsDMX/VK18g5n1?=
 =?us-ascii?Q?0fSXzyC0ATCCWxabhyIybGATTZbUjpaTzhVaGmM4jVadSbgiKkxjLIZOoM5h?=
 =?us-ascii?Q?BlcoPcl/FrcUaRzMXYa30iNS8lsFt1gm8Q7zICM2NeFrGbZ0GnJlB6JdJXCP?=
 =?us-ascii?Q?pVGV+jt+77OOXmGzPPmxI9qT3l1aGGMUq2O5b145ths+7ah4hwm6uhiWU24f?=
 =?us-ascii?Q?vi1lCQ4rGVSIEqr8NsJCKNHOLI9nxdscwZHKBW+W9o9PYZItoPPS0h+4WtQU?=
 =?us-ascii?Q?GzI3oI0L4R7TNwWS8w+bgzD6/utKcElEvbEJo+Q6vDY8Dso2xZf+/rfNJbHK?=
 =?us-ascii?Q?Ib+wM+Kk07m1hrnass1BWiqUnQU8jxDT4m0+Yp1twtr221kYXDOWzX3fmWxp?=
 =?us-ascii?Q?jTspxrccYqECmPkUiPlfNLrUQvuk08UpQSEIPkafY1L25pC2Nl5wZTPXm1kS?=
 =?us-ascii?Q?3oqNJUucAXIj3kdoxkzvxf1dXEJxVB4XJNusZAV/Q2g8N2B4/yoX2EnBrBCV?=
 =?us-ascii?Q?wSerFI5sdAtNEm8PXqkSH/z7TYqIEMUcP8sZBFQNRdHLWtnn6bhp7VNRUdxB?=
 =?us-ascii?Q?5R5dbwfjFr6bgrfuHoKBTLeu5oLvEXVCi8o2ZwhP76/WNg/lLaDlfey1NSI1?=
 =?us-ascii?Q?/wwpKbHiVtmwFjcuh+gkRP0CkntQnE+HOqIWW3wxVZzedWWTzUMgeieSB6pg?=
 =?us-ascii?Q?e03dEart7g5pjavtzZpMSAcrm+ra+hXSbKjKpn83gRY8Hdq/oIXBQIqdRLId?=
 =?us-ascii?Q?yKaOsWBCQ0y8kEQgAj0PlBEwh7k6PgFyOVNkjXqWpbAi9KVEeA7tVFY/5+e5?=
 =?us-ascii?Q?BdcEdkN/iw+qMmnR1Z1syn4E//9we8cbGqogEzduULuN4RA3HIbXfAytruFH?=
 =?us-ascii?Q?gW1vexhK1MobmTTnxeao79WHL4hNR0J7A8X2ouADbXLGm0rogiDv34cCxtyZ?=
 =?us-ascii?Q?JA/BIrJkSRF7B9fw+dxOHMaz3dAptoDF95rSZVQAAL3Ojk4wcBMJdgaiHK39?=
 =?us-ascii?Q?GEqLYNS12nLlXPXwfRYEeCXslKH7F4KMIwE57NI8K58aqgM0tsuUFG/QDMuK?=
 =?us-ascii?Q?lTFcjSjEZ/+Fj/setVCI1M7OKPdPj4Ib20Mls/eK9Y+VhtSdLVP2RmXTYVcp?=
 =?us-ascii?Q?++w9/02hXMmcvqG+aPIljcA2IyUzJKPWWbYLMbeXNeDX1hAYSmh3qbbj9fYR?=
 =?us-ascii?Q?2dNrsrCCZDveMMfAHpa42iN7N8Quk0F1HNFthlmsbwWLCOBWSsf2W9jY2q/8?=
 =?us-ascii?Q?NEhSSH40Rhwu5UI85vzVIcWE1qUcxTDrRa6Xz0f2k3pqDzkzZHjr6ypv2Wy7?=
 =?us-ascii?Q?tYFcSWFRb6VsZ13x62nfmnInp1TcRAhWY+hJ4Uwbqba/RGdA57U2pZXV4ZX+?=
 =?us-ascii?Q?FjIZemY2jugn13AOJWT6gmSSCnDmZ1BYAHmn8sNInhM8bg0IYBoaSZBI+U1j?=
 =?us-ascii?Q?gcrK+yWZrBCMSxHcX9SRFrOV0Z7VTjZiHUZED5pc/qJ78U17iazvL360HIMK?=
 =?us-ascii?Q?4tSDMiA7+7Pbc4t+N03+4Mh0gxrIrP9rvQV2lG2RU6i3dMOOa796hBcX8yky?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b17b13dd-180b-455a-66b2-08dd9747113a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:36:04.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0LzCagJnEcw5aA1dm+ZatV5R6/f34Pv+Hi+bMm39ofl6xezzaWJ/WpiNi5W2tqu5KYmPRs1SKJLTyn7sXrmdRa98tK2KxKbNtdHh/iDvD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6400
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:32PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is created equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> In order to support Type2 CXL devices, wrap all of those concerns into
> an API that retrieves a root decoder (platform CXL window) that fits the
> specified constraints and the capacity available for a new region.
> 
> Add a complementary function for releasing the reference to such root
> decoder.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

