Return-Path: <netdev+bounces-195092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0904ACDECD
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC1241898D01
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AADE28C2D5;
	Wed,  4 Jun 2025 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUEyxOXP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9C1C5D62
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043016; cv=fail; b=r0CwvmeP1AV9QpbWZSf4Y0RcgU4rbPbRS+tUbdpb2CDjfzPTzXlbpwV82fHUa+NUOr1A9Xyscq0sEKqAAqswOfsy0ZVrTsRWMQ5XKJLyTME/SHzgWNRKzGJelJsgfXqaBLD0ziAp5xQhvZF9ImsyjUM1mnhAg/P8wgREHCSc8mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043016; c=relaxed/simple;
	bh=kxH9r7keH6Ajlbijt0HxO8DXgq4JHN181j+OtA9PAAQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ByNyeieP9Yk+azTEcxs4AxFyXD1tTi8dT41ZPCEWGGFZHbz9V/5R9SOf1Wd1jjxqI95IkOauh+U3qjAUSuWLLdO3iiGW2uvOPtKhL24Jop4QpyhAr6IRjhWhE2nikoRhwDDBQT22tf9PdMCfg+ZFVH1X5IeadGp90WaiJb/CExU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUEyxOXP; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749043016; x=1780579016;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kxH9r7keH6Ajlbijt0HxO8DXgq4JHN181j+OtA9PAAQ=;
  b=ZUEyxOXPSWvp91j5ebJjOxR1qIZ2O6NNWi7CDqAG27N5qzOzgxX+WGqh
   kFzDCSUjqyDnuBnVSHObK44a2/8XXWxCGjT326G0ryrsjqm0Yv0zPxFoR
   YF1ivn2t4DcW+NSPZWR5zz2+aV1gmxykgoaJFPsi5UdddiPGSwTR0gVfe
   B8jRc1sMUihD6Cw9giUD9T4+umNx5ChGOmLIpXipEpFfegLJgk6mjAphY
   pbjNE5423icoopz9Le+USdX/v+koPpARAdG+2nrUrANUJX/m74VJk33qJ
   wVeQPI1Oy5YMZgNRN6Sk1BRMY6BiNHDOncV902Lhpn1XXYAPXgK1JQ0eq
   A==;
X-CSE-ConnectionGUID: 42EIQge1RtSbLqnlxXEHGA==
X-CSE-MsgGUID: H4PyGGjFSRGKTHuRXCY6eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="61744581"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="61744581"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:16:53 -0700
X-CSE-ConnectionGUID: dFScTrK2T8KvMCf4qha4OQ==
X-CSE-MsgGUID: h5vqWyfqQrmcf2kKgBNVhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150065626"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 06:16:52 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:16:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 06:16:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 06:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMFybBd7tWHHHaSlhjlPmjCsndZXlJIbCMHUM7KGjCaCRlFB6JJ97/bpJ8fgekuk+Nw7HiUKoZRhVbGhyZ3m2nCNjeuRxjOPrmnr+0XZYtTuy6RADNnRWEmqC0JdoNu0d/IcLi87SFk/gM+ofHX7ohfOHEXyWsvPFXN6Lnq63jzzR6WkN+wBzjJtP4ITDXmc53Ku0M7sL2SuSerh2Pd+z4RzXwIeejLAvbkat4bGIct2P+novWm3BT2DGUSk/sdcBWWXVSrZn86IEbGPpIc9rTk8kHwFxlzy2Tpm9gPusv3q85ZJ2XOvL42Zdk+v7rNXV45iydM9EWXf5LopE7GEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZu+an2xuvaJrvwBX3i6tHV4+HF9Dx+kPFWiYAnA78U=;
 b=tJp9PoLqJFLmI3wArm4VxqtTv/ES53vi7fNZyYtUNmV2aOd2QeOj91G1X6NUGd9sM6eOWfT2/03+VIZ/i8wi3Jz1XxDT/pofu6HgWjz4Q/eQWbyfJUIZQVV+7dU1LbuJtn46n5VqCJVcxAtaN7nScW0IqJiZWjm256jvhS0vgttC4TKYUK+EsorMJN3DhDFs7glHizS3zci7LxeKaLqZnqmCJb1wSznbUVIPEMeZQWN6K7TIt/51z0EomHdCQW+JBCFDbGyE0H+KVLRRePZKTC+jGwZ0dFAFaGqX4kzXFkxZHouCVOSGx5zqPHzgl01Xwq4un7xUEcRSxLzge3Cntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 13:16:49 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 13:16:49 +0000
Date: Wed, 4 Jun 2025 15:16:37 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Antonio Quartulli <antonio@openvpn.net>
CC: <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Oleksandr
 Natalenko" <oleksandr@natalenko.name>
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
Message-ID: <aEBHNVFvthKTUWuO@soc-5CG4396X81.clients.intel.com>
References: <20250603111110.4575-1-antonio@openvpn.net>
 <20250603111110.4575-2-antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250603111110.4575-2-antonio@openvpn.net>
X-ClientProxiedBy: VI1PR07CA0128.eurprd07.prod.outlook.com
 (2603:10a6:802:16::15) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 181ace08-190a-4988-c5f9-08dda36a1032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NIvreeqAOxy+Yh4+XWg3M/gwnUc4ujYFWf/ZP6NgXYonGmhIagmnrT3pXkl6?=
 =?us-ascii?Q?60OD4yN3kBJcJly6W1U6pvJui86N2eP5Mshq9jEB2GIRbJ1zdvSOMwTXhQI0?=
 =?us-ascii?Q?B4pNyU0vfFuihVhnX0dj70l9tLuAm80xnnYNFP5XZtoIb8DwXcb7mh0Co+sH?=
 =?us-ascii?Q?bE2LyUSEBbIhqKfwzymOROb07DiBn6061dVu66YVhKzqAgJPrQeXvSvcjsXg?=
 =?us-ascii?Q?juuAWeec2Y2S6VPUXFBsUiwTwVTnd81eu/HmcYL7ITzs6hjSlEkmvU5lqnzx?=
 =?us-ascii?Q?Gk0emQVd/HkqSK9fzctQ2lSJnI3L9JFt42rE6bC4ZFmX4vimsFg3UQ5r5QQ2?=
 =?us-ascii?Q?CtiuzJYNhk0pMOn+NH6/41RFw9sLPbxC/fliznCSxd/1/UuT2Mv+pZ8SVEeH?=
 =?us-ascii?Q?I0ulxeMxj3NEvPQqBa1SG/mzLCoB3awFg0LSicZ2xrzXBYXtTqGq8THsGziQ?=
 =?us-ascii?Q?atDA+uyQnmgOqLeOQGkd/OK5G6HT+661ufZ6uGy3khtwafVewlxI1vXuBJli?=
 =?us-ascii?Q?WGXjJKdGAxi4YuLtn5jwG+k2S0b1K4vQiXnki1OjeGqCr9SDHVdNq/ouaFZu?=
 =?us-ascii?Q?AvMrcgtqrYQ9Q0X3pq8Em0Q8xm0HufUCOHoxlV1fQfeY82Ys29WfqFhh/qr8?=
 =?us-ascii?Q?/KhpGTTeIRZ89UrFag/ysZEbXpJerUBvGjf4MJ3of43uF/gzfirh8tQghuMd?=
 =?us-ascii?Q?X51KXVDdVXj7wZa4XKn74Rl1dD9YbNgXUcMygnx2aujMOO0AFRpHLvAmEkvk?=
 =?us-ascii?Q?03tsbDhcgpomhijGC7idu0DlSvxEBviaCHz+Gc3pjINblGdv7xftNc0NRcN+?=
 =?us-ascii?Q?VFllflxVvev0l7kd+9SptWfDZET1Qj28gBo7zkbRtoOpLUb6D/I1hCCb4FE9?=
 =?us-ascii?Q?ijk4MtLvcFvv/QxcXQcW7QFZCqrPLVsmVTyU7LHGmdXXv9mMxrOx32GH3M8a?=
 =?us-ascii?Q?7SjH9oYDlSEUCK8tqXuoUKDsR8jhgOnKvIFIZqtF+URA9tZNoou9gIQKr/RD?=
 =?us-ascii?Q?g/tKbhzdEccw9yq4okYiNMjnfhzUvz3j3tyUZE/YQDsCcJk7hx5v4XjsNC1L?=
 =?us-ascii?Q?g3r6KH2htblP3Oxq/QW80/HonWi3EXsE7GUvkEbrjxDRrodCZ2OpCMDa1zFD?=
 =?us-ascii?Q?9P91RkFeUZLNj6+udp31Y8sMzXscLGHHttYosU/Hs0fstK905j1C1AAZ2Km7?=
 =?us-ascii?Q?2N93oO+9JS3f2vCkZcYMWybXpsOrrg069vttlokU98SQv1ey+1olx61+S/Lb?=
 =?us-ascii?Q?dAqdhPRl0G3aKh5kbcAZM0UalpleveNlq+TPxOFpjd2wVQDD+qkdHqUjHZGu?=
 =?us-ascii?Q?2JiOOjogTAfAMFFXK9ERtAdeh6tBJzOkLDhb6L0sqFBvRZkGvaXSLWU0qjU9?=
 =?us-ascii?Q?sQRBhPgDRzKxcv4Pt20jhJmhPu1BlgjTZ8I/2FuNkqsCssMlvxjQmXYGnT/Z?=
 =?us-ascii?Q?s7sdIO/tVBc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WyxRKng6WcoAKvqR8WIpN0h3fYvMOsIrZ2GfshJoLI0JNW/N9ZywaGZeraLY?=
 =?us-ascii?Q?x/1fYMeiQwVcwrnFplTUke1nj0ZCxYdnRg/8DShJbvZ7ygOymKD8qdZ+c/2j?=
 =?us-ascii?Q?uksL9wZG4Q1N7YQkIedwqYt4itCgSjSeCF+DG0gRDtjG9SBED94OtT//zju5?=
 =?us-ascii?Q?m02wxC+mSnwHLkTIQ5FTVC9C76Hza2vAu9COxV6/oOs8wB6fPBc2QH3BDm8w?=
 =?us-ascii?Q?rtEANP0WFodKZrrfitcWS8Fkz4W0IL4rXhR8M+cYCdPlpIGTeGxb0VItAlEA?=
 =?us-ascii?Q?kNcssM+GlC3+OaNeeNXhf1PPoWagtAXA4l1moYlfX8P7P81whhYTIvBmIT2n?=
 =?us-ascii?Q?rGMtN4Y5diQXrJr7OutEQ1iCyTBv1pCFIyBO+ENiMTfqBQYZA2Bhg6+uXKQW?=
 =?us-ascii?Q?gTKwNNAAMB0bp7YkRUTKjZj0WtLvJ9wptekHyZ1cfbTpdqoSHQbC7w/dAv1X?=
 =?us-ascii?Q?ujRHLIuyLVYp0tKjkORG04O7nw/Bn7CjCivIe4h3qu+pMUqPrLZVLvKR6MR6?=
 =?us-ascii?Q?CRfvQD90t/dY+5mc49lkgHzScm7xa8p2jxmd5wtcVKoQ1/ogy9iz6ksUPE8X?=
 =?us-ascii?Q?uEa56C+84e9f4GFdEb4FuZ1/sNM4p/gC0lb6QAVjiEnJ5/BVJTnXIvIyHI5d?=
 =?us-ascii?Q?9NAqYXIHWJ/outU1jahXfzBhncRYk0nCWgw8i6OpoPEzDtLh4/Prm+mqQme3?=
 =?us-ascii?Q?YqT6SuAQBX6JCrdjBQY8MmUdVaSYycFi4rj/GRLSKtn7E7bQwwDDR5FfanJv?=
 =?us-ascii?Q?9CpSQF7gTrNZNLIuVNJ7+o6bd9g4OmzNTiPaH/1N5JxdWvAcl/fQZgHZkOpa?=
 =?us-ascii?Q?8kAEHAY+WcA6gffAXPgerMWffSyQEoDK14sLAdYAo7msmEAW5+N39S0OqzL8?=
 =?us-ascii?Q?Htuf4BdDHZROXOgSlm+b/aFklH9Z3NK54sr/OTGJ6EBu298eiTSR/rPhOC8p?=
 =?us-ascii?Q?ylLjkgxacAk5h8D/G1ESi3NX0ywCI/X/4YZXdKB7bcezKGWveG1ls/FZFGWn?=
 =?us-ascii?Q?XimI8mqDXKSEVtxtSSTYnsHasFPdAEzV3XtDXmCk0ftMhJv3rgNljMdkB9cV?=
 =?us-ascii?Q?eS1zKr/ujYg0911F+sHXu5B5D111K0mnwvChgI7VU7eVLQ61xYxIkQIzMjZP?=
 =?us-ascii?Q?EuQvqMFriLlZu98s+7mnnrcAyE1StChci7ktFkwh1d8NrEYhFO//c15oeLwE?=
 =?us-ascii?Q?PHQpo8uDxUe64MYYNlTyvVkPCgn/3qvPlTfGP2yhTIarL5lIBm+ykCHEQAeP?=
 =?us-ascii?Q?NGi6Z7Zdj9cXABXGp4IP8FcqPBDZk6MFN/ahXR4l8Wki1M92p6l5xImfJlo8?=
 =?us-ascii?Q?y9F0L57vbSOd7g4+aifpVnncD4ltf0g/e9921vcmRdhOLjDiRrVBBmaMHqbc?=
 =?us-ascii?Q?yTP+QQxCTW8NRD/hRDo0KRQF/H4POAYTWTnAWy4ISO9p60FQVJzc+w7A4+lj?=
 =?us-ascii?Q?7dD50D6wf9jnel4OF3/xSAkazbkUVbUOcQg+KXanOH6vv+hxXdpyBvhgKF1g?=
 =?us-ascii?Q?wTDp4UoAeT4CaiG5lMgqvtPzKafpoxW1VQ5VVFEh5NU8TfNLGe8uJSRZ1PVI?=
 =?us-ascii?Q?mcRkAcFtYan2bEF/xUpddgq1LFeanvdQal4Tp2SPsACfzUK1WEeJvHljXN0d?=
 =?us-ascii?Q?a97uLUk2iS4JsOY/u39cd8gvzT3GBUi6T9qLRJS2ZYu1SQO+Bo5EB8e2jZ8H?=
 =?us-ascii?Q?znDonQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 181ace08-190a-4988-c5f9-08dda36a1032
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:16:49.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FktT9Dvy9grw8xDXwhNR1P2TBO5gKH474ce7XZs9ajP4q8FqvNCWICALlNd20VFzTr3Uf76VYdqmJQ1KQuAoAxGvVLcBkpu4OSZZp8MUHUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com

On Tue, Jun 03, 2025 at 01:11:06PM +0200, Antonio Quartulli wrote:
> When deconfiguring a UDP-tunnel from a socket, we cannot
> call setup_udp_tunnel_sock() with an empty config, because
> this helper is expected to be invoked only during setup.
> 
> Get rid of the call to setup_udp_tunnel_sock() and just
> revert what it did during socket initialization..
> 
> Note that the global udp_encap_needed_key and the GRO state
> are left untouched: udp_destroy_socket() will eventually
> take care of them.
> 
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

I do not think MC_LOOP is necessarily set before attaching the socket, but 1 is 
the default value, so I guess restoring to it should be fine.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

Another less related thing is more concerning to me: ovpn_udp_socket_attach() 
checks if rcu_dereference_sk_user_data(sock->sk) is NULL to determine if socket 
is available to configure, but a lot of callers of e.g. setup_udp_tunnel_sock(), 
including ovpn, set the user data to NULL by not providing it in the config.

In such case, is checking rcu_dereference_sk_user_data() actually enough to say 
that "socket is currently unused"?

> ---
>  drivers/net/ovpn/udp.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index aef8c0406ec9..f4d3bd070f11 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>   */
>  void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>  {
> -	struct udp_tunnel_sock_cfg cfg = { };
> +	struct sock *sk = ovpn_sock->sock->sk;
>  
> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> -			      &cfg);
> +	/* Re-enable multicast loopback */
> +	inet_set_bit(MC_LOOP, sk);
> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> +	inet_dec_convert_csum(sk);
> +
> +	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
> +	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
> +	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
> +
> +	rcu_assign_sk_user_data(sk, NULL);
>  }
> -- 
> 2.49.0
> 
> 

