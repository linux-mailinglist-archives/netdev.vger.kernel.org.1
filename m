Return-Path: <netdev+bounces-192838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667DAC1583
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4033500329
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4114C2288F4;
	Thu, 22 May 2025 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBPWvj1k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90195139566;
	Thu, 22 May 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747945897; cv=fail; b=k70Qsvo+O8cxIMittErIs87t5hevRPi2FLyv8J33k74ee9tcvv61Gol9FkeqGwiReYhM8ALMm605BZsQBcgwta/TtD0vdUuJuPC/pBXjSMrMmXmPcqdpexh1E7W6V5Oddq4ldQOmrjElBGdLyL0Y1i5bFkpZ8YqWpnemYY2TS2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747945897; c=relaxed/simple;
	bh=h3p+xJIvuB8Zdi6ILY6WRI4bY2BE7HVrlWVsZ69eGqo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uJ5hTFbinU++CR74Zplx5E46rbIjswSC2LCmG61rVLhU0xJuF8cdX0clw/INdQyoDOu52EAGNXBUgCP8J3ME7qohIOhaRrfcQ/Rk/NpF0uHUL6o9VwtXKH+03XU3qz0yu63VZR91yfwtolJ8H6YUvA4912gwzCKaroJ+ur9XTOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBPWvj1k; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747945896; x=1779481896;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h3p+xJIvuB8Zdi6ILY6WRI4bY2BE7HVrlWVsZ69eGqo=;
  b=QBPWvj1kDh1N6yFIv5mlz53rEfI0Y1NZPNnbvE/BcdNiOhyt+V5xiH2O
   z19fdzQAlkMsn7nUYsnCgA0SkDKbEme68sF5oFjAD/aPS+v33qQUicCn1
   XwgkoFieuVVzT4GlzJ4EeKgUsjN2wjfwHQwky8mHCqsgi6Qh7NrGuPftu
   vp9gKcNwxUDAMVccbUHbjyX+beHUjplwnJlrPHARJ8Q/Jhsst05c2h3Jn
   x/x4MGC7cvk/gCbht+wrAykksScTPDMRMGGe2jupOl5kHhK1VmiUSuGuF
   dxSLLBo6e3n1K8XRHuZF485o9cEdGzM70WtZn9leQXQkrF0F9gMSWgf3X
   g==;
X-CSE-ConnectionGUID: 6slSToYIQFqjrdF00avN6A==
X-CSE-MsgGUID: 2Uf1sADdSRWreSiVe9bJpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="53656206"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="53656206"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:31:35 -0700
X-CSE-ConnectionGUID: Xryi0nWhQJetcArZrzNtPA==
X-CSE-MsgGUID: 9jtuj+FbTk+r6AcCfI0Ewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="146002976"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:31:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 13:31:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 13:31:33 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.56)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 13:31:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ActU5Q/Kitb1KvcCL9yZMAIqLY9LopBf4MjjTHVFDMpQvnWaEbeVXjYJbVWxnJy/SH3jQM8OwSFKFngGevrU+DRoqtJFeWzGTN9ZuyRK/AEfay9SwqbYNMVUu66FJ5mjRbnG/qt81is7Laq17rc5AWKWxo60j3IhLMxn7kl/iZ63JTUvA/qezVbYfDlshY3Aeh/mw+p6x1d/FdngKdSXG+flLL9H6HhVgPtfYOI9S5gQ4Xx4XDr4U+4RSWz2Onxz/A9kAtOWOc3juJUyHg4WfCK8voLSeLP9zq7qFQWnk9Qdg6MM/DkHiCZIqY8tpWAZ2vDvtdUezlZ6+CPG2V+Fbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61TuG17SdCh4+o16l0AXF1f0+xNcpGYnRfwrquuel9A=;
 b=RAxH4h5PYOIjw72WZ9AdwUp7TidL4X8lIk5nBis3MGhVxH39tWd8fvsQYPYdP31nGrwYsj8ogsqcvr0nrkoI1hKknBHX0h7USrP0W3nZHgvKEbmPD8P3dtPaHqfEugZUMPXAKE6wMVy9L3fg9m5LJFCDfxJJVufCnIyNruRgjIFrlTNnU3PYhm1IJ3v5dJBy1bO3H63Y2hIyonkacHRlJqrHm/EZrGQrxeKnbQE4xhs49QVj8dezpLuBcSrxLrQQURR2vk6kd+y+XLRABV315724kCEdNzfOMurDu9Bs1Brg49i1gbx8MkDq+gS8bbpMWdaqWV1vCekvbrj+dNp+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Thu, 22 May
 2025 20:31:26 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 20:31:26 +0000
Date: Thu, 22 May 2025 13:31:23 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Message-ID: <682f899ba6998_3e70100ee@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-12-alejandro.lucero-palau@amd.com>
 <682e2a0b9b15b_1626e10088@dwillia2-xfh.jf.intel.com.notmuch>
 <b30d7195-fb0b-4ba5-a670-342eb5516605@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b30d7195-fb0b-4ba5-a670-342eb5516605@amd.com>
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2d51aa-90db-47ca-3a01-08dd996f9fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S9MDmQyiO2SluJzhbnbRYivRBxOeVgEkM29j1b3B2Qm8zBi0udLs6NZPnVcA?=
 =?us-ascii?Q?VyGDarXPlLQnD5zmCmtPCwHUh6es7onyBpMADFzp+A4BaTBcikn834tG0WAB?=
 =?us-ascii?Q?+y8YhRQtoXGz7Jo92OgcPNv3ih94hsAWmtUK2+va03gmRWzXJntNsA1gqtoA?=
 =?us-ascii?Q?ZRGy0jG7QUW8E5KbXV3vapSbor11g/BMOrpoOhTvZwZ4KsvkQDktyWllXu+5?=
 =?us-ascii?Q?IFydtB5Y2zrKPA0VfF7ZGUOLxu50bd2LlwDIf4gbpE6Bp2lWF8pvckTsILSI?=
 =?us-ascii?Q?l9+hr6iCFpptirGU8XeoBlw9yRVYFIXKGYnPAeSCO/asCS1X5vhESSbksQJn?=
 =?us-ascii?Q?hRVHkqMLkXnB3lz/YL7b4exHtm/UGirc4QSW5V2fzuYgnn1YcJGjvjBrmuNS?=
 =?us-ascii?Q?yutmreOBMeZFfd4kseRFTYP63JAGkbs++zr3Cr5N/IGYpwihXm9dWUfGfjns?=
 =?us-ascii?Q?o8L3D6kZPJCJXgX826e97IsbUQI4FuFgEdC6GKGNMjETTQg1yyr5wSpN6TfW?=
 =?us-ascii?Q?L/oa3wNE8tlixfTpTWA0jdW9kfRi4BD8kZHTe5jwFRMDfkrTXu32NfOkuD2g?=
 =?us-ascii?Q?huLxxf6iurli9WOiHOextcsWdjDEjoviqHh7eJ5v0sEkShFIFzImX3/9WLZg?=
 =?us-ascii?Q?tLcqlR+SkQ/zefcmBpgBYLHWXavhMMuLwYfQwZFJcW3vQj4AfjQ0RPJ56SLh?=
 =?us-ascii?Q?cbWOKTc9DFMm0/bAkl6sWo6JBmJYfJqTXWzQxTUNgB0laxnFnb6Z8GiCI2EC?=
 =?us-ascii?Q?WFnSbamfEG2xbn1K21EXVEQX8L0Xw31jbpZ1tGVM4sTyclVkYo82uzW9wOz3?=
 =?us-ascii?Q?E/xXdGkB0+PBT/pOfXJhF+9hHR52VsisDqfqg27uDmMhMCUhlGXioBKvpR+G?=
 =?us-ascii?Q?qpjLCB7BYOlG77wi6Muc6bqG7leXqrlPZs9gqbNED8SC0CCBWOSER25pTnq/?=
 =?us-ascii?Q?JfUQ8UeX7buJnD1xZagdu3yA0cBGrEpdjMuFwSkb0anhHN4U4JQ+LeVQG+u7?=
 =?us-ascii?Q?4P1O/vv28O/NXIwCS5bpPvaEvIJKJVsBvYjp913eq5biVn8EFZrIDY1dmKNi?=
 =?us-ascii?Q?qid6bO+JMYgD3lRdJsg9mxXMeUL6uLM8bTBOydAoO0Eh4z42B238n3tNTEE0?=
 =?us-ascii?Q?HtF0pJ5Va4GISmCKbmGVobr6Fh98mN/WFabCIJOXB9Nx75n+WTtcpSKJn2VE?=
 =?us-ascii?Q?/oQc4R7kGy9kHD7iMKzglW8HC0NUYHjUILVUL+N5bvj8KqgL1cryKkz2Rqsu?=
 =?us-ascii?Q?PW0q47tw4O6qrEo6h3LkX3mmXK3s1WAu4bmXYiL1JqsGh2hbldi+gDkK/ZBi?=
 =?us-ascii?Q?TETP5GqtwrIxz8ILZ0E+8j/y7ZPe/PcPQFsUW9uN3LdbwBr2F/jyj2kuW3/A?=
 =?us-ascii?Q?UrNUfLXDCqTFBwgq0ZDZLt4DPfkxWMAZELj4O9+TLJGKXUxq3Ulkfy9NehIM?=
 =?us-ascii?Q?TPG0OffkcfEC6NLiX2HRFylD/uliT8uWPwo3j9mbytxzl2K5OgmI6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uWnBM0H5uWAKjmJMvcjWPwqkunCMlGpWa2thUUAoaPsyZ0S5m8ax1CVADW/j?=
 =?us-ascii?Q?alq0cARq0xzNwN7ooypC9aaF1kEyWV/v33CtsKmckToZV/FJ7dNZWLhcYH6l?=
 =?us-ascii?Q?5D8WeRjhJjPcvt4qGlbAbtgG2OcXM4pH7zDempw1KXJOTDtnXBUUJuRYk3Lh?=
 =?us-ascii?Q?rlqvn9Z8BMTfOAtr5AQhLksa/BiSOUN9/YYQ7jMP/LjqPAmzwT2oGH/fivWJ?=
 =?us-ascii?Q?wtMMTtxZvnwmOKdlXGPHE0ck0ekMgPNGPVdjhU1IqU9TpkxjQFulzLU7N1YK?=
 =?us-ascii?Q?WBRAPLiAmawZBdxRWNlBjohtWdNso3x4D8hQRjohKyawjejB+1bjN5qMV7lU?=
 =?us-ascii?Q?oFuZDZN5LpawGi43IdAIoR4UnRrvP0J4BcQ1414ZpPV9jcYtR0r94WaAjG4K?=
 =?us-ascii?Q?PnOz9j7iEEIJiFPwbsS5wVzVB56TTeeLpzgS0m29EDq6YlZiCxl8JQcf/1v5?=
 =?us-ascii?Q?DQ0tUt5DaKWeYsfhaKT9D9ZTyzI1Se532H2kBzlHGxKxdC5HPXb/lcbhU18i?=
 =?us-ascii?Q?RzyV+EPmZcmUhxLwnscAhpWfu0L7U7hp5cJZlBnMh7J1sYdzm4veMxFO980p?=
 =?us-ascii?Q?tJO4C58kdxrmALqrnfuqXrzN3hk9tvQKIIPO3WmY0jbFdFstjnZw/f3/J+ix?=
 =?us-ascii?Q?cidUv8fLad/Ai5UmCpMcuNmQNugdayn4OUuMTBHHffP+bB92rr8eXOXHc1gl?=
 =?us-ascii?Q?O8BMT5Cr6RRiBlvYOImptCScpt/73yrad4gtjuFy1FchTrkk/CNF3tiFMW9B?=
 =?us-ascii?Q?rXfiF9yrgNrehn6X+iLWPF1Qr/vhfjf8wpkm8DxIODugHSjOOArkGPbB17MP?=
 =?us-ascii?Q?dghgzXdycg+bkPpnH2rS93cpxYRHNgqYm/bpo1OLTDBXQGubKEbaK5I50uZ9?=
 =?us-ascii?Q?nfXMw+iI5LgfCTcYjNrN7luMY/cQ9Yxm387KZAujVNforQPSaAKpZBAbstdC?=
 =?us-ascii?Q?8vB9/ISUsGquHNNvycCT9b9qiNKqlKG1dWxRnhwmemzITiAHTrhSc+LsR815?=
 =?us-ascii?Q?H535IotmhDoarfCgg4yFV9afsQS8A4CEoifd5KoArlhRRZINp5JIXvynXPrJ?=
 =?us-ascii?Q?b0QitYHWIBJggZ8H5bdGxzc7vyvKREReYfpF/gnq0k1NAtbJp2+bjSx4/biS?=
 =?us-ascii?Q?BMYk2bZCG/ILanoSnCvwWvLW2xMQ2rushoox/ugbkJHBDPy5lfJ7dUk3tAw2?=
 =?us-ascii?Q?660T8JO64rhmd+DuszryI68z5JNWG6ANMkaIby3WQ1JwdvfQPSyeiq3x1wEv?=
 =?us-ascii?Q?2vHipOZFqxL3vg0N+DvjLB+aKwhO4vcSPab+tK/9F8iVhobUaO1Eo5yseTZH?=
 =?us-ascii?Q?WwRRJXEC55CC4Ew9JJR9Xm89B17KN1UD6cW1wdoYEGKsWFRbEUa7nMokhJQS?=
 =?us-ascii?Q?r3THztJumEBJcwqKLPX9n0hpoQSRee372fqsnZSPF0Ur6rvhJ7+yCwQDQ8ZF?=
 =?us-ascii?Q?5EdBmWbSmyqKGW1/1v0Rdrm2z49ec2bmGX1dGMA4V4Rtg/CoH1sHhNBPqAkL?=
 =?us-ascii?Q?RxvMRdrTsPWXkggjRcM/FIB5JifQbBMsf2bA1yOAHiJcQSziaMBFRFetzQRO?=
 =?us-ascii?Q?GpNlxI9g+53tkO9zJuPKTVix+SmBwoAAfb9Imo5u6KXBJW+SfPZt74fPNiga?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2d51aa-90db-47ca-3a01-08dd996f9fd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 20:31:26.0248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXNC8vv6IOgZYuyKkdCMI/zpAggTUv2Z3mwrYZLNufHKljZtI8pwqxU6+KC0HT3kW4iF3aJv+6m9ZNcRE7vS+QYJkQ6XVCmoyU5dINFFM7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > The reference does not stop the root decoder from being unregistered and
> > it is clearly broken to allow it to be unregistered while drivers have
> > pending allocations.
> 
> 
> I agree all this requires to address those problems, hopefully in the 
> short-mid term, meaning follow-ups of this patchset.

When I made the comment above it was before realizing that v16 dropped
the cxl_acquire_endpoint() mechanism. There are just too many
memory-safety bugs in this patchset around CXL topology setup/teardown.
I am not seeing a way to address all the problems solely with
follow-ups.

